# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create seed users with different roles
puts "Creating seed users..."

# Master user
master_user = User.find_or_create_by!(email: "master@example.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = "master"
end
puts "✓ Master user created: #{master_user.email}"

# Admin user
admin_user = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = "admin"
end
puts "✓ Admin user created: #{admin_user.email}"

# Regular users
regular_users = [
  { email: "user1@example.com", role: "user" },
  { email: "user2@example.com", role: "user" },
  { email: "user3@example.com", role: "user" }
]

regular_users.each do |user_data|
  user = User.find_or_create_by!(email: user_data[:email]) do |u|
    u.password = "password123"
    u.password_confirmation = "password123"
    u.role = user_data[:role]
  end
  puts "✓ Regular user created: #{user.email}"
end

# Test user with different password
test_user = User.find_or_create_by!(email: "test@example.com") do |user|
  user.password = "testpass456"
  user.password_confirmation = "testpass456"
  user.role = "user"
end
puts "✓ Test user created: #{test_user.email}"

puts "Seed users creation completed!"
puts ""
puts "Created users:"
puts "- master@example.com (password: password123) - Role: master"
puts "- admin@example.com (password: password123) - Role: admin"
puts "- user1@example.com (password: password123) - Role: user"
puts "- user2@example.com (password: password123) - Role: user"
puts "- user3@example.com (password: password123) - Role: user"
puts "- test@example.com (password: testpass456) - Role: user"

# Create sample publishers
puts "Creating sample publishers..."

publishers_data = [
  {
    name: "Tech Weekly",
    description: "A leading publication for technology news and insights",
    active: true
  },
  {
    name: "Daily News Hub",
    description: "Your source for breaking news and current events",
    active: true
  },
  {
    name: "Creative Minds",
    description: "A platform for creative writing and artistic expression",
    active: true
  },
  {
    name: "Business Today",
    description: "Business news, analysis, and market insights",
    active: false  # Example of inactive publisher
  }
]

publishers_data.each do |publisher_data|
  publisher = Publisher.find_or_create_by!(name: publisher_data[:name]) do |p|
    p.description = publisher_data[:description]
    p.active = publisher_data[:active]
  end
  puts "✓ Publisher created: #{publisher.name} (#{publisher.active? ? 'Active' : 'Inactive'})"
end

puts "Publishers creation completed!"
puts ""

# Create sample posts for users (only users with 'user' role can create posts)
puts "Creating sample posts..."

# Get all regular users and publishers
users_who_can_post = User.where(role: 'user')
active_publishers = Publisher.where(active: true)

# Sample post data
post_templates = [
  {
    title: "Getting Started with Ruby on Rails",
    content: "Ruby on Rails is a powerful web application framework that makes it easy to build robust web applications. In this post, I'll share my experience learning Rails and some tips for beginners.\n\nRails follows the convention over configuration principle, which means it makes assumptions about what you want to do and how you're going to do it, rather than requiring you to specify every little thing through endless configuration files.\n\nSome key concepts to understand:\n- MVC (Model-View-Controller) architecture\n- Active Record for database interactions\n- RESTful routing\n- Gems for extending functionality\n\nThe Rails community is incredibly welcoming and helpful, making it a great framework for both beginners and experienced developers."
  },
  {
    title: "The Future of Web Development",
    content: "Web development is constantly evolving, and it's exciting to see where the industry is heading. Here are some trends I'm watching:\n\n1. **Progressive Web Apps (PWAs)**: Bridging the gap between web and mobile apps\n2. **JAMstack Architecture**: JavaScript, APIs, and Markup for faster, more secure sites\n3. **AI Integration**: Machine learning becoming more accessible to web developers\n4. **Web Assembly**: Bringing near-native performance to web applications\n5. **Serverless Computing**: Focus on code, not infrastructure\n\nAs developers, staying current with these trends while maintaining strong fundamentals is key to long-term success."
  },
  {
    title: "Tips for Better Code Organization",
    content: "Writing clean, maintainable code is an art form. Here are some strategies I've learned over the years:\n\n**Follow SOLID Principles:**\n- Single Responsibility: Each class should have one reason to change\n- Open/Closed: Open for extension, closed for modification\n- Liskov Substitution: Objects should be replaceable with instances of their subtypes\n- Interface Segregation: No client should depend on methods it doesn't use\n- Dependency Inversion: Depend on abstractions, not concretions\n\n**Other Best Practices:**\n- Use meaningful variable and method names\n- Keep methods small and focused\n- Write tests for your code\n- Refactor regularly\n- Document complex logic\n\nRemember, code is read more often than it's written!"
  },
  {
    title: "Building a Personal Portfolio",
    content: "Creating a personal portfolio is essential for any developer. It's your chance to showcase your skills and personality to potential employers or clients.\n\n**Key Elements to Include:**\n- About section with your story\n- Projects with live demos and code links\n- Skills and technologies you're proficient in\n- Contact information\n- Blog or writing samples\n\n**Design Tips:**\n- Keep it simple and professional\n- Make sure it's responsive\n- Use your own projects as examples\n- Include a clear call-to-action\n- Optimize for performance\n\nYour portfolio is often the first impression you make, so invest time in making it great!"
  },
  {
    title: "Learning New Programming Languages",
    content: "As developers, we're constantly learning new technologies. Here's my approach to picking up new programming languages efficiently:\n\n**Start with the Basics:**\n- Understand syntax and core concepts\n- Learn about data types and structures\n- Practice with simple programs\n\n**Build Real Projects:**\n- Don't just do tutorials\n- Solve problems you care about\n- Compare with languages you already know\n\n**Join the Community:**\n- Follow language-specific blogs and forums\n- Attend meetups or online events\n- Contribute to open source projects\n\n**Focus on Fundamentals:**\n- Algorithms and data structures transfer between languages\n- Good software engineering practices are universal\n- Problem-solving skills are language-agnostic\n\nRemember, the goal isn't to learn every language, but to become a better problem solver."
  },
  {
    title: "The Importance of Version Control",
    content: "Version control is one of the most important tools in a developer's toolkit. Git has become the standard, and for good reason.\n\n**Why Version Control Matters:**\n- Track changes over time\n- Collaborate with team members\n- Revert to previous versions when needed\n- Branch and experiment safely\n- Maintain project history\n\n**Git Best Practices:**\n- Write clear, descriptive commit messages\n- Make small, focused commits\n- Use branches for features and experiments\n- Keep your main branch clean\n- Learn to use git rebase and merge effectively\n\n**Beyond the Basics:**\n- Set up automated testing with CI/CD\n- Use pull requests for code review\n- Tag releases appropriately\n- Learn git hooks for automation\n\nEven for personal projects, version control saves time and prevents headaches."
  },
  {
    title: "Debugging Strategies That Work",
    content: "Debugging is an essential skill that every developer needs to master. Here are some strategies that have served me well:\n\n**Systematic Approach:**\n1. Reproduce the bug consistently\n2. Understand what should happen vs. what's happening\n3. Form hypotheses about the cause\n4. Test each hypothesis methodically\n5. Fix and verify the solution\n\n**Useful Tools:**\n- Browser developer tools\n- Debugger statements and breakpoints\n- Logging and print statements\n- Unit tests to isolate issues\n- Code review with fresh eyes\n\n**Mindset Tips:**\n- Stay calm and methodical\n- Don't make assumptions\n- Question everything\n- Take breaks when stuck\n- Ask for help when needed\n\nRemember, debugging skills improve with experience. Every bug you fix makes you a better developer."
  },
  {
    title: "Understanding Database Design",
    content: "Good database design is crucial for building scalable applications. Here are the fundamentals every developer should know:\n\n**Normalization:**\n- First Normal Form (1NF): Eliminate repeating groups\n- Second Normal Form (2NF): Remove partial dependencies\n- Third Normal Form (3NF): Remove transitive dependencies\n\n**Key Concepts:**\n- Primary and foreign keys\n- Indexes for performance\n- Relationships (one-to-one, one-to-many, many-to-many)\n- Data types and constraints\n\n**Performance Considerations:**\n- Query optimization\n- Proper indexing strategy\n- Avoiding N+1 problems\n- Connection pooling\n- Caching strategies\n\n**Best Practices:**\n- Use meaningful table and column names\n- Document your schema\n- Plan for data growth\n- Consider data integrity\n- Regular backups and maintenance\n\nA well-designed database is the foundation of a successful application."
  }
]

users_who_can_post.each do |user|
  # Create 1-3 posts per user
  num_posts = rand(1..3)

  num_posts.times do |i|
    # Select a random post template
    template = post_templates.sample

    # Randomly assign a publisher (or leave it nil)
    publisher = rand < 0.7 ? active_publishers.sample : nil

    # Randomly assign status (70% published, 30% draft)
    status = rand < 0.7 ? 'published' : 'draft'

    # Create unique title by adding user-specific info
    unique_title = "#{template[:title]} - #{user.email.split('@').first}'s perspective"

    post = Post.find_or_create_by!(
      title: unique_title,
      user: user
    ) do |p|
      p.content = template[:content]
      p.publisher = publisher
      p.status = status
    end

    publisher_info = publisher ? " (Published to: #{publisher.name})" : " (No publisher)"
    status_info = " [#{post.status.capitalize}]"
    puts "✓ Post created: '#{post.title.truncate(50)}' by #{user.email}#{publisher_info}#{status_info}"
  end
end

puts "Sample posts creation completed!"
puts ""
puts "Summary:"
puts "- Created #{Post.count} posts total"
puts "- Status breakdown:"
puts "  - Published: #{Post.published.count} posts"
puts "  - Draft: #{Post.draft.count} posts"
puts "- Posts by publisher:"
Publisher.includes(:posts).each do |publisher|
  puts "  - #{publisher.name}: #{publisher.posts.count} posts (#{publisher.posts.published.count} published, #{publisher.posts.draft.count} drafts)"
end
puts "  - No publisher: #{Post.where(publisher: nil).count} posts (#{Post.where(publisher: nil).published.count} published, #{Post.where(publisher: nil).draft.count} drafts)"
