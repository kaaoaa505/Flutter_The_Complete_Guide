# Shopping List Backend

A Node.js Express server with SQLite database for managing shopping list items and categories.

## Features

- RESTful API for categories and grocery items
- SQLite database with automatic table creation
- CORS enabled for frontend integration
- Default categories pre-loaded

## Setup

1. Install dependencies:

```bash
npm install
```

2. Start the server:

```bash
# Development mode (with auto-restart)
npm run dev

# Production mode
npm start
```

The server will run on `http://localhost:3000`

## API Endpoints

### Categories

- `GET /api/categories` - Get all categories
- `POST /api/categories` - Create new category

### Grocery Items

- `GET /api/grocery-items` - Get all grocery items with category info
- `POST /api/grocery-items` - Create new grocery item
- `PUT /api/grocery-items/:id` - Update grocery item
- `DELETE /api/grocery-items/:id` - Delete grocery item
- `PATCH /api/grocery-items/:id/toggle` - Toggle item completion status

## Database Schema

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
