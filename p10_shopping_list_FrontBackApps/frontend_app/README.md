# Shopping List Frontend

A Flutter application for managing shopping lists with categories and real-time synchronization with a Node.js backend.

## Features

- Add, edit, and delete grocery items
- Categorize items with color-coded categories
- Mark items as completed
- Real-time synchronization with backend
- Beautiful Material Design UI
- Error handling and loading states

## Setup

1. Make sure you have Flutter installed on your system
2. Install dependencies:

```bash
flutter pub get
```

3. Start the backend server first (see backend README)
4. Run the Flutter app:

```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── category_model.dart
│   └── grocery_item_model.dart
├── data/                     # Data and constants
│   └── categories_data.dart
├── services/                 # API services
│   └── api_service.dart
├── providers/                # State management
│   └── shopping_list_provider.dart
├── screens/                  # App screens
│   └── home_screen.dart
└── widgets/                  # Reusable widgets
    ├── grocery_item_card.dart
    └── add_item_dialog.dart
```

## Dependencies

- `flutter`: Core Flutter framework
- `http`: For API communication with backend
- `provider`: For state management
- `shared_preferences`: For local storage (future use)

## API Integration

The app communicates with the backend through HTTP requests:

- GET `/api/categories` - Fetch all categories
- POST `/api/categories` - Create new category
- GET `/api/grocery-items` - Fetch all grocery items
- POST `/api/grocery-items` - Create new grocery item
- PUT `/api/grocery-items/:id` - Update grocery item
- DELETE `/api/grocery-items/:id` - Delete grocery item
- PATCH `/api/grocery-items/:id/toggle` - Toggle item completion

## Usage

1. **Adding Items**: Tap the + button to add new items with name, quantity, and optional category
2. **Completing Items**: Tap the circle icon next to an item to mark it as completed
3. **Deleting Items**: Tap the delete icon to remove items
4. **Refreshing**: Use the refresh button in the app bar to reload data
5. **Categories**: Items are automatically categorized and color-coded

## Error Handling

The app includes comprehensive error handling:

- Network connectivity issues
- Backend server errors
- Invalid data validation
- User-friendly error messages with retry options
