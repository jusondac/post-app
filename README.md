# Authorization Management System

A comprehensive Rails application demonstrating role-based authorization and content management with a sophisticated user permission system.

## 🚀 Overview

This Rails application implements a multi-tiered authorization system with three distinct user roles, each with specific permissions for managing posts and publishers. The system demonstrates best practices for role-based access control (RBAC) in Rails applications.

## 🛠 Technology Stack

- **Ruby**: 3.x
- **Rails**: ~> 8.0.2
- **Database**: SQLite3 (>= 2.1)
- **Authentication**: Devise (~> 4.9)
- **UI Framework**: Tailwind CSS
- **Frontend**: Hotwire (Turbo & Stimulus)
- **Search**: Ransack (~> 4.0)
- **Pagination**: Kaminari (~> 1.2)
- **Asset Pipeline**: Propshaft
- **Server**: Puma (>= 5.0)

## 📊 Database Schema

### Users
- `email` (string, unique)
- `encrypted_password` (string)
- `role` (integer: 0=user, 1=admin, 2=master)
- Devise fields for password reset and remember functionality

### Posts
- `title` (string, 3-100 characters)
- `content` (text, minimum 10 characters)
- `status` (integer: 0=draft, 1=published)
- `user_id` (foreign key)
- `publisher_id` (foreign key, optional)

### Publishers
- `name` (string, unique, 2-100 characters)
- `description` (text, max 500 characters)
- `active` (boolean, default: true)

## 👥 User Roles & Permissions

### 🔴 Master (Role: 2)
**Full System Access**
- Manage all users and their roles
- Delete users
- Manage publishers (create, edit, delete)
- Create and manage posts
- Access authorization control panel
- View all content

### 🟡 Admin (Role: 1)
**Administrative Access**
- Access admin panel
- View all users (read-only)
- Manage publishers (create, edit, delete)
- View all posts
- Limited administrative access

### 🟢 User (Role: 0)
**Content Creator**
- Create and manage own posts
- View published content
- Edit own profile
- Basic user access

## 🏗 Application Architecture

### Models

#### User Model
```ruby
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  enum :role, { user: 0, admin: 1, master: 2 }
  has_many :posts, dependent: :destroy
  
  # Permission methods
  def can_create_posts?
  def can_manage_publishers?
  def can_see_publisher?
  def can_manage_users?
  def can_access_authorization?
end
```

#### Post Model
```ruby
class Post < ApplicationRecord
  belongs_to :user
  belongs_to :publisher, optional: true
  
  enum :status, { draft: 0, published: 1 }
  
  # Validation: Only users with 'user' role can create posts
  # Ransack support for search functionality
end
```

#### Publisher Model
```ruby
class Publisher < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :posts, dependent: :nullify
  
  scope :active, -> { where(active: true) }
  # Ransack support for search functionality
end
```

### Controllers

#### Authorization Controller
- Manages user role assignments (Master only)
- Displays user permissions matrix
- Handles role updates

#### Posts Controller
- CRUD operations for posts
- Draft/Published status management
- User ownership validation
- Search and pagination (My Posts page)

#### Publishers Controller
- CRUD operations for publishers (Admin/Master only)
- Publisher-specific post listings

## 🔐 Security Features

### Authentication
- Devise-based user authentication
- Secure password encryption
- Password reset functionality
- Remember me functionality

### Authorization
- Role-based access control
- Controller-level permission checks
- Model-level validation for role restrictions
- Ownership verification for post management

### Validation
- Strong parameter filtering
- Input validation on all models
- CSRF protection
- SQL injection prevention via ActiveRecord

## 🚦 Installation & Setup

### Prerequisites
```bash
- Ruby 3.x
- Rails 8.x
- SQLite3
- Node.js (for asset compilation)
```

### Installation Steps

1. **Clone the repository**
```bash
git clone <repository-url>
cd authorization
```

2. **Install dependencies**
```bash
bundle install
```

3. **Database setup**
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. **Install JavaScript dependencies**
```bash
bin/importmap install
```

5. **Build Tailwind CSS**
```bash
rails tailwindcss:build
```

6. **Start the server**
```bash
rails server
# or for development with file watching
bin/dev
```

The application will be available at `http://localhost:3000`

## 🧪 Testing

```bash
# Run all tests
rails test

# Run specific test files
rails test test/models/user_test.rb
rails test test/controllers/posts_controller_test.rb

# Run system tests
rails test:system
```

## 📱 Features

### Content Management
- **Post Creation**: Users can create and manage their own posts
- **Draft System**: Save posts as drafts before publishing
- **Publisher Association**: Link posts to publishers
- **Search & Filter**: Ransack-powered search with filtering options
- **Pagination**: Kaminari pagination for better performance

### User Management
- **Role Assignment**: Masters can assign roles to users
- **Permission Matrix**: Clear display of user permissions
- **Profile Management**: Users can edit their own profiles

### Publisher Management
- **Publisher CRUD**: Admins and Masters can manage publishers
- **Active/Inactive Status**: Control publisher visibility
- **Post Association**: View all posts by publisher

## 🔧 Development Tools

### Code Quality
- **Brakeman**: Security vulnerability scanning
- **RuboCop**: Ruby style guide enforcement
- **Debug**: Built-in debugging tools

### Development Workflow
- **Bootsnap**: Faster boot times through caching
- **Web Console**: In-browser debugging
- **Hot Reloading**: Turbo for SPA-like experience

## 🚀 Deployment

### Docker Support
The application includes Docker configuration:
```bash
# Build and run with Docker
docker build -t authorization-app .
docker run -p 3000:3000 authorization-app
```

### Kamal Deployment
Configured for deployment with Kamal:
```bash
kamal setup
kamal deploy
```

## 📝 API Endpoints

### Authentication
- `POST /users/sign_in` - User login
- `POST /users/sign_up` - User registration
- `DELETE /users/sign_out` - User logout

### Posts
- `GET /posts` - List published posts
- `GET /posts/my_posts` - User's own posts with search
- `POST /posts` - Create new post
- `PATCH /posts/:id` - Update post
- `DELETE /posts/:id` - Delete post

### Publishers
- `GET /publishers` - List publishers
- `POST /publishers` - Create publisher (Admin/Master)
- `PATCH /publishers/:id` - Update publisher (Admin/Master)
- `DELETE /publishers/:id` - Delete publisher (Admin/Master)

### Authorization
- `GET /authorization` - View permissions (Master only)
- `PATCH /authorization/update_user_role` - Update user role (Master only)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Review the Rails guides for framework-specific questions
- Check the Devise documentation for authentication issues

---

Built with ❤️ using Ruby on Rails
