# Project Management API

A Laravel-based REST API for project management with dynamic attributes (EAV pattern).

## Project Requirements

### Core Models & Relations
- User: first_name, last_name, email, password
- Project: name, status
- Timesheet: task_name, date, hours
- Relations:
  - Users can be assigned to multiple projects
  - Projects can have multiple users
  - Timesheets are linked to one project and one user

### EAV Implementation
- Dynamic attributes system for Projects
- Models:
  - Attribute: name, type (text, date, number, select)
  - AttributeValue: attribute_id, entity_id, value
- Projects support dynamic fields like department, start_date, end_date

## Setup Instructions

1. **Install Dependencies**
    - composer install

2. **Environment Setup**
    - cp .env.example .env
    - php artisan key:generate

3. **Configure Database in .env**
    - DB_CONNECTION=mysql
    - DB_HOST=127.0.0.1
    - DB_PORT=3306
    - DB_DATABASE=your_database
    - DB_USERNAME=your_username
    - DB_PASSWORD=your_password

4. **Run Migrations and Seeders**
    - php artisan migrate --seed
    - php artisan passport:keys
    - php artisan passport:client --personal

5. **Run Server**
    - php artisan serve

6. **Run Tests**
    - php artisan test

7. **Run Server**

## Test Credentials

User:
Email: admin@example.com
Password: password

User:
Email: user@example.com
Password: password

## API Documentation

All authenticated endpoints require the Authorization header:

### Authentication Endpoints

- POST    /api/register    # Register a new user
- POST    /api/login       # Login a user
- POST    /api/logout      # Logout a user


#### Register

```json
POST /api/register

Request:
{
    "first_name": "John",
    "last_name": "Doe",
    "email": "john@example.com",
    "password": "password",
    "password_confirmation": "password"
}

Response:
{
    "success": true,
    "message": "User registered successfully",
    "data": {
        "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1...",
        "user": {
            "id": 1,
            "first_name": "John",
            "last_name": "Doe",
            "email": "john@example.com"
        }
    }
}
```

#### Login

```json
POST /api/login

Request:
{
    "email": "john@example.com",
    "password": "password"
}

Response:
{
    "success": true,
    "message": "User logged in successfully",
    "data": {
        "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1...",
        "user": {
            "id": 1,
            "first_name": "John",
            "last_name": "Doe",
            "email": "john@example.com"
        }
    }
}
```

#### Logout

```json
POST /api/logout

Response:
{
    "success": true,
    "message": "User logged out successfully"
}
```

### User Endpoints

- GET    /api/users          # List all users
- GET    /api/users/{id}     # Get single user
- POST   /api/users          # Create user
- PUT    /api/users/{id}     # Update user
- DELETE /api/users/{id}     # Delete user


#### List Users

```json
GET /api/users

Response:
{
    "success": true,
    "data": [
        {
            "id": 1,
            "first_name": "John",
            "last_name": "Doe",
            "email": "john@example.com",
            "created_at": "2024-03-15T10:00:00.000000Z",
            "updated_at": "2024-03-15T10:00:00.000000Z",
            "timesheets": [
                {
                    "id": 1,
                    "task_name": "Development",
                    "date": "2024-03-15",
                    "hours": 8
                }
            ]
        }
    ]
}
```

#### Get Single User

```json
GET /api/users/{id}

Response:
{
    "success": true,
    "data": {
        "id": 1,
        "first_name": "John",
        "last_name": "Doe",
        "email": "john@example.com",
        "created_at": "2024-03-15T10:00:00.000000Z",
        "updated_at": "2024-03-15T10:00:00.000000Z",
        "timesheets": [
            {
                "id": 1,
                "task_name": "Development",
                "date": "2024-03-15",
                "hours": 8
            }
        ],
        "creator": {
            "id": 1,
            "first_name": "Admin",
            "last_name": "User",
            "email": "admin@example.com"
        }
    }
}
```

#### Create User

```json
POST /api/users

Request:
{
    "first_name": "Jane",
    "last_name": "Smith",
    "email": "jane@example.com",
    "password": "password"
}

Response:
{
    "success": true,
    "message": "User created successfully",
    "data": {
        "id": 2,
        "first_name": "Jane",
        "last_name": "Smith",
        "email": "jane@example.com"
    }
}
```

#### Update User

```json
PUT /api/users/{id}

Request:
{
    "first_name": "Jane",
    "last_name": "Doe",
    "email": "jane.doe@example.com"
}

Response:
{
    "success": true,
    "message": "User updated successfully",
    "data": {
        "id": 2,
        "first_name": "Jane",
        "last_name": "Doe",
        "email": "jane.doe@example.com"
    }
}
```

#### Delete User

```json
DELETE /api/users/{id}

Response:
{
    "success": true,
    "message": "User deleted successfully"
}
```

### Project Endpoints

- GET    /api/projects          # List all projects
- GET    /api/projects/{id}     # Get single project
- POST   /api/projects          # Create project
- PUT    /api/projects/{id}     # Update project
- DELETE /api/projects/{id}     # Delete project

#### List Projects

```json
GET /api/projects

Response:
{
    "success": true,
    "data": [
        {
            "id": 1,
            "name": "Project A",
            "status": "active",
            "creator_id": 1,
            "created_at": "2024-03-15T10:00:00.000000Z",
            "updated_at": "2024-03-15T10:00:00.000000Z",
            "users": [
                {
                    "id": 1,
                    "first_name": "John",
                    "last_name": "Doe",
                    "email": "john@example.com"
                }
            ],
            "attributes": {
                "department": "IT",
                "start_date": "2024-03-15",
                "budget": "10000"
            }
        }
    ]
}
```

#### Get Single Project

```json
GET /api/projects/{id}

Response:
{
    "success": true,
    "data": {
        "id": 1,
        "name": "Project A",
        "status": "active",
        "creator_id": 1,
        "created_at": "2024-03-15T10:00:00.000000Z",
        "updated_at": "2024-03-15T10:00:00.000000Z",
        "users": [
            {
                "id": 1,
                "first_name": "John",
                "last_name": "Doe",
                "email": "john@example.com"
            }
        ],
        "attributes": {
            "department": "IT",
            "start_date": "2024-03-15",
            "budget": "10000"
        },
        "timesheets": [
            {
                "id": 1,
                "task_name": "Development",
                "date": "2024-03-15",
                "hours": 8,
                "user": {
                    "id": 1,
                    "first_name": "John",
                    "last_name": "Doe"
                }
            }
        ]
    }
}
```

#### Create Project

```json
POST /api/projects

Request:
{
    "name": "New Project",
    "status": "active",
    "user_ids": [1, 2],
    "attributes": {
        "department": "IT",
        "start_date": "2024-03-15",
        "budget": 10000
    }
}

Response:
{
    "success": true,
    "message": "Project created successfully",
    "data": {
        "id": 2,
        "name": "New Project",
        "status": "active",
        "creator_id": 1,
        "created_at": "2024-03-15T10:00:00.000000Z",
        "updated_at": "2024-03-15T10:00:00.000000Z",
        "attributes": {
            "department": "IT",
            "start_date": "2024-03-15",
            "budget": "10000"
        }
    }
}
```

#### Update Project

```json
PUT /api/projects/{id}

Request:
{
    "name": "Updated Project",
    "status": "completed",
    "user_ids": [1, 3],
    "attributes": {
        "department": "Marketing",
        "end_date": "2024-04-15"
    }
}

Response:
{
    "success": true,
    "message": "Project updated successfully",
    "data": {
        "id": 2,
        "name": "Updated Project",
        "status": "completed",
        "creator_id": 1,
        "created_at": "2024-03-15T10:00:00.000000Z",
        "updated_at": "2024-03-15T10:00:00.000000Z",
        "users": [
            {
                "id": 1,
                "first_name": "John",
                "last_name": "Doe",
                "email": "john@example.com"
            }
        ],
        "attributes": {
            "department": "Marketing",
            "start_date": "2024-03-15",
            "budget": "10000",
            "end_date": "2024-04-15"
        }
    }
}
```

#### Delete Project

```json
DELETE /api/projects/{id}

Response:
{
    "success": true,
    "message": "Project deleted successfully"
}
```

### Filtering System

The API supports filtering on both regular and EAV attributes:

```
# Regular fields
GET /api/projects?filters[name]=ProjectA
GET /api/projects?filters[status]=active

# Dynamic attributes
GET /api/projects?filters[department]=IT
GET /api/projects?filters[budget]=>1000

# Operators supported:
=    # Exact match (default)
>    # Greater than
<    # Less than
LIKE # Pattern matching

Example:
GET /api/projects?filters[name]=LIKEProject
GET /api/projects?filters[budget]=>1000
GET /api/projects?filters[department]=IT
```

### Validation Rules

#### Project
```php
{
    'name' => 'required|string|max:255',
    'status' => 'required|in:active,inactive,completed',
    'user_ids' => 'sometimes|array',
    'user_ids.*' => 'exists:users,id',
    'attributes' => 'sometimes|array'
}
```

#### Attribute Types
- text: String values
- date: Date values (YYYY-MM-DD)
- number: Numeric values
- select: Predefined options



### Timesheet Endpoints

- GET    /api/timesheets          # List all timesheets
- GET    /api/timesheets/{id}     # Get single timesheet
- POST   /api/timesheets          # Create timesheet
- PUT    /api/timesheets/{id}     # Update timesheet
- DELETE /api/timesheets/{id}     # Delete timesheet

#### List Timesheets

```json
GET /api/timesheets

Optional Query Parameters:
- user_id: Filter by user
- project_id: Filter by project
- start_date: Filter by date range start
- end_date: Filter by date range end

Response:
{
    "success": true,
    "data": [
        {
            "id": 1,
            "task_name": "Development",
            "date": "2024-03-15",
            "hours": 8,
            "created_at": "2024-03-15T10:00:00.000000Z",
            "updated_at": "2024-03-15T10:00:00.000000Z",
            "user": {
                "id": 1,
                "first_name": "John",
                "last_name": "Doe"
            }
        }
    ]
}
```

#### Get Single Timesheet

```json
GET /api/timesheets/{id}

Response:
{
    "success": true,
    "data": {
        "id": 1,
        "task_name": "Development",
        "date": "2024-03-15",
        "hours": 8,
        "created_at": "2024-03-15T10:00:00.000000Z",
        "updated_at": "2024-03-15T10:00:00.000000Z",
        "user": {
            "id": 1,
            "first_name": "John",
            "last_name": "Doe"
        }
    }
}
```

#### Create Timesheet

```json
POST /api/timesheets

Request:
{
    "project_id": 1,
    "task_name": "Development",
    "date": "2024-03-15",
    "hours": 8
}

Response:
{
    "success": true,
    "message": "Timesheet created successfully",
    "data": {
        "id": 1,
        "task_name": "Development",
        "date": "2024-03-15",
        "hours": 8,
        "user": {
            "id": 1,
            "first_name": "John",
            "last_name": "Doe"
        }
    }
}
```

#### Update Timesheet

```json
PUT /api/timesheets/{id}

Request:
{
    "task_name": "Testing",
    "date": "2024-03-16",
    "hours": 6
}

Response:
{
    "success": true,
    "message": "Timesheet updated successfully",
    "data": {
        "id": 1,
        "task_name": "Testing",
        "date": "2024-03-16",
        "hours": 6
    }
}
```

#### Delete Timesheet

```json
DELETE /api/timesheets/{id}

Response:
{
    "success": true,
    "message": "Timesheet deleted successfully"
}
```

### Attribute Endpoints

- GET    /api/attributes          # List all attributes
- GET    /api/attributes/{id}     # Get single attribute
- POST   /api/attributes          # Create attribute
- PUT    /api/attributes/{id}     # Update attribute
- DELETE /api/attributes/{id}     # Delete attribute

#### List Attributes

```json
GET /api/attributes

Response:
{
    "success": true,
    "data": [
        {
            "id": 1,
            "name": "department",
            "type": "text",
            "created_at": "2024-03-15T10:00:00.000000Z",
            "updated_at": "2024-03-15T10:00:00.000000Z"
        },
        {
            "id": 2,
            "name": "start_date",
            "type": "date"
        },
        {
            "id": 3,
            "name": "budget",
            "type": "number"
        }
    ]
}
```

#### Get Single Attribute

```json
GET /api/attributes/{id}

Response:
{
    "success": true,
    "data": {
        "id": 1,
        "name": "department",
        "type": "text",
        "created_at": "2024-03-15T10:00:00.000000Z",
        "updated_at": "2024-03-15T10:00:00.000000Z",
        "attribute_values": [
            {
                "id": 1,
                "entity_id": 1,
                "value": "IT"
            }
        ]
    }
}
```

#### Create Attribute

```json
POST /api/attributes

Request:
{
    "name": "location",
    "type": "text"
}

Response:
{
    "success": true,
    "message": "Attribute created successfully",
    "data": {
        "id": 4,
        "name": "location",
        "type": "text",
        "created_at": "2024-03-15T10:00:00.000000Z",
        "updated_at": "2024-03-15T10:00:00.000000Z"
    }
}
```

#### Update Attribute

```json
PUT /api/attributes/{id}

Request:
{
    "name": "office_location",
    "type": "text"
}

Response:
{
    "success": true,
    "message": "Attribute updated successfully",
    "data": {
        "id": 4,
        "name": "office_location",
        "type": "text",
        "created_at": "2024-03-15T10:00:00.000000Z",
        "updated_at": "2024-03-15T10:00:00.000000Z"
    }
}
```

#### Delete Attribute

```json
DELETE /api/attributes/{id}

Response:
{
    "success": true,
    "message": "Attribute deleted successfully"
}
```


### Error Responses

All endpoints return consistent error responses:

```json
{
    "success": false,
    "message": "Error description",
    "errors": {
        "field": ["Specific error message"]
    }
}
```

Status codes:
- 200: Success
- 201: Created
- 400: Bad Request
- 401: Unauthorized
- 403: Forbidden
- 404: Not Found
- 422: Validation Error
