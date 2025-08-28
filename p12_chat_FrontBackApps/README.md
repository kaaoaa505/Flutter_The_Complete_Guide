# Chat Application - Flutter + Laravel

A real-time chat application built with Flutter frontend and Laravel backend, connected via REST APIs.

## Project Structure

```
p12_chat_FrontBackApps/
├── frontend/
│   └── chat_app/          # Flutter chat application
└── backend/
    └── chat_backend/      # Laravel API backend
```

## Prerequisites

- **Flutter SDK** (latest stable version)
- **PHP** (8.1 or higher)
- **Composer** (PHP package manager)
- **MySQL** (5.7 or higher)
- **Git**

## Database Setup

1. Create a MySQL database named `chat_db`
2. Configure your MySQL credentials in the `.env` file:
   - **Database**: `chat_db`
   - **Username**: `root` (or your MySQL username)
   - **Password**: `[YOUR_MYSQL_PASSWORD]`

> **Security Note**: Never commit your actual database credentials to version control. The `.env` file is already included in `.gitignore` to prevent accidental commits.

## Backend Setup (Laravel)

### 1. Navigate to the backend directory

```bash
cd backend/chat_backend
```

### 2. Install PHP dependencies

```bash
composer install
```

### 3. Configure environment

1. Copy the example environment file:

   ```bash
   cp .env.example .env
   ```

2. Update the `.env` file with your database settings:
   - Database: `chat_db`
   - Username: `root` (or your MySQL username)
   - Password: `[YOUR_MYSQL_PASSWORD]`

### 4. Generate application key

```bash
php artisan key:generate
```

### 5. Run database migrations

```bash
php artisan migrate
```

### 6. Start the Laravel development server

```bash
php artisan serve --host=0.0.0.0 --port=8000
```

The Laravel API will be available at: `http://localhost:8000`
**Note**: Using `--host=0.0.0.0` allows connections from Android emulators and other devices on the network.

## Frontend Setup (Flutter)

### 1. Navigate to the frontend directory

```bash
cd frontend/chat_app
```

### 2. Install Flutter dependencies

```bash
flutter pub get
```

### 3. Run the Flutter application

```bash
flutter run
```

## API Endpoints

The Laravel backend provides the following REST API endpoints:

- `GET /api/messages` - Get all messages
- `POST /api/messages` - Send a new message
- `GET /api/messages/{id}` - Get a specific message
- `PUT /api/messages/{id}` - Update a message
- `DELETE /api/messages/{id}` - Delete a message

### Request/Response Format

**Send Message (POST /api/messages)**

```json
{
  "sender": "John Doe",
  "content": "Hello, world!"
}
```

**Response**

```json
{
  "success": true,
  "data": {
    "id": 1,
    "sender": "John Doe",
    "content": "Hello, world!",
    "created_at": "2024-01-01T12:00:00.000000Z",
    "updated_at": "2024-01-01T12:00:00.000000Z"
  },
  "message": "Message sent successfully"
}
```

## Features

### Flutter Frontend

- Real-time chat interface
- Message bubbles with sender avatars
- Timestamp display
- Error handling and retry functionality
- Responsive design
- Auto-scroll to latest messages

### Laravel Backend

- RESTful API endpoints
- Database integration with MySQL
- CORS configuration for cross-origin requests
- Input validation
- JSON response formatting

## Usage

1. Start the Laravel backend server
2. Start the Flutter application
3. Enter your name in the "Your name" field
4. Type messages and send them
5. Messages will appear in real-time chat bubbles

## Troubleshooting

### Common Issues

1. **Database Connection Error**

   - Ensure MySQL is running
   - Verify database credentials in `.env`
   - Check if `chat_db` database exists
   - Make sure your `.env` file contains the correct database credentials

2. **Flutter Dependencies Error**

   - Run `flutter pub get` in the frontend directory
   - Ensure Flutter SDK is properly installed

3. **API Connection Error**

   - Verify Laravel server is running on `http://localhost:8000`
   - Check CORS configuration
   - Ensure both frontend and backend are running simultaneously
   - **For Android Emulator**: The Flutter app automatically uses `10.0.2.2:8000` to access the host machine's localhost
   - **For Web/iOS**: Uses `localhost:8000` directly

4. **Port Already in Use**
   - Change the Laravel port: `php artisan serve --port=8001`
   - Update the API base URL in `frontend/chat_app/lib/services/api_service.dart`

## Development

### Adding New Features

1. **Backend**: Add new routes in `routes/api.php`
2. **Frontend**: Update the API service and UI components
3. **Database**: Create new migrations for additional tables

### Code Structure

- **Models**: Data structures and database relationships
- **Controllers**: API logic and request handling
- **Services**: Business logic and external API calls
- **Providers**: State management in Flutter
- **Screens**: UI components and user interface

## License

This project is open source and available under the MIT License.
