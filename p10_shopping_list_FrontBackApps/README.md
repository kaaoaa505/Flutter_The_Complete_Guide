# Shopping List App

A full-stack shopping list application with a Node.js Express backend and Flutter frontend, featuring real-time synchronization, categories, and a beautiful user interface.

## 🏗️ Architecture

- **Backend**: Node.js with Express and SQLite database
- **Frontend**: Flutter with Material Design
- **Communication**: HTTP REST API
- **State Management**: Provider pattern in Flutter

## 📁 Project Structure

```
p10_shopping_list_FrontBackApps/
├── backend_app/              # Node.js Express backend
│   ├── package.json
│   ├── server.js
│   └── README.md
├── frontend_app/             # Flutter frontend
│   ├── pubspec.yaml
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/
│   │   │   ├── category_model.dart
│   │   │   └── grocery_item_model.dart
│   │   ├── data/
│   │   │   └── categories_data.dart
│   │   ├── services/
│   │   │   └── api_service.dart
│   │   ├── providers/
│   │   │   └── shopping_list_provider.dart
│   │   ├── screens/
│   │   │   └── home_screen.dart
│   │   └── widgets/
│   │       ├── grocery_item_card.dart
│   │       └── add_item_dialog.dart
│   └── README.md
└── README.md
```

## 🚀 Quick Start

### Prerequisites

- Node.js (v14 or higher)
- Flutter SDK (v3.0 or higher)
- Git

### Backend Setup

1. Navigate to the backend directory:

```bash
cd backend_app
```

2. Install dependencies:

```bash
npm install
```

3. Start the server:

```bash
# Development mode (with auto-restart)
npm run dev

# Production mode
npm start
```

The backend will be available at `http://localhost:3000`

### Frontend Setup

1. Navigate to the frontend directory:

```bash
cd frontend_app
```

2. Install Flutter dependencies:

```bash
flutter pub get
```

3. Run the Flutter app:

```bash
flutter run
```

## ✨ Features

### Backend Features

- RESTful API with Express
- SQLite database with automatic table creation
- CORS enabled for frontend integration
- Default categories pre-loaded
- Full CRUD operations for categories and grocery items
- Item completion toggle functionality

### Frontend Features

- Beautiful Material Design UI
- Add, edit, and delete grocery items
- Categorize items with color-coded categories
- Mark items as completed with visual feedback
- Real-time synchronization with backend
- Error handling and loading states
- Responsive design

## 📊 Database Schema

### Categories Table

- `id` (INTEGER PRIMARY KEY)
- `name` (TEXT NOT NULL)
- `color` (TEXT NOT NULL)

### Grocery Items Table

- `id` (INTEGER PRIMARY KEY)
- `name` (TEXT NOT NULL)
- `quantity` (INTEGER DEFAULT 1)
- `category_id` (INTEGER, FOREIGN KEY)
- `is_completed` (BOOLEAN DEFAULT 0)
- `created_at` (DATETIME DEFAULT CURRENT_TIMESTAMP)

## 🔌 API Endpoints

### Categories

- `GET /api/categories` - Get all categories
- `POST /api/categories` - Create new category

### Grocery Items

- `GET /api/grocery-items` - Get all grocery items with category info
- `POST /api/grocery-items` - Create new grocery item
- `PUT /api/grocery-items/:id` - Update grocery item
- `DELETE /api/grocery-items/:id` - Delete grocery item
- `PATCH /api/grocery-items/:id/toggle` - Toggle item completion status

## 🎨 Default Categories

The app comes with 8 pre-configured categories:

- 🥬 Vegetables (Green)
- 🍎 Fruits (Orange)
- 🥩 Meat (Red)
- 🥛 Dairy (Blue)
- 🥖 Bakery (Brown)
- 🥤 Beverages (Purple)
- 🍿 Snacks (Yellow)
- 🧽 Household (Gray)

## 🔧 Development

### Backend Development

- The server uses nodemon for development with auto-restart
- SQLite database file is created automatically
- API endpoints are documented in the backend README

### Frontend Development

- Uses Provider pattern for state management
- HTTP service handles all API communication
- Error handling with user-friendly messages
- Responsive design for different screen sizes

## 🐛 Troubleshooting

### Common Issues

1. **Backend not starting**: Check if port 3000 is available
2. **Frontend can't connect**: Ensure backend is running on localhost:3000
3. **Database errors**: Delete `shopping_list.db` file and restart backend
4. **Flutter dependencies**: Run `flutter pub get` in frontend directory

### Logs

- Backend logs are displayed in the terminal
- Frontend errors are shown in the app UI
- Check browser console for network errors

## 📱 Usage Guide

1. **Adding Items**: Tap the + button, enter item name, quantity, and select category
2. **Completing Items**: Tap the circle icon next to an item
3. **Deleting Items**: Tap the delete icon and confirm
4. **Refreshing Data**: Use the refresh button in the app bar
5. **Viewing Summary**: See total, completed, and pending items at the top

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test both backend and frontend
5. Submit a pull request

## 📄 License

This project is open source and available under the MIT License.
