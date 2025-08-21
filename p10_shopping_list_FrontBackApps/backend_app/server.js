const express = require("express");
const sqlite3 = require("sqlite3").verbose();
const cors = require("cors");
const bodyParser = require("body-parser");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Database setup
const db = new sqlite3.Database("./shopping_list.db", (err) => {
  if (err) {
    console.error("Error opening database:", err.message);
  } else {
    console.log("Connected to SQLite database.");
    initDatabase();
  }
});

// Initialize database tables
function initDatabase() {
  // Categories table
  db.run(
    `CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    color TEXT NOT NULL
  )`,
    (err) => {
      if (err) {
        console.error("Error creating categories table:", err.message);
      } else {
        console.log("Categories table created or already exists.");
        // Insert default categories
        insertDefaultCategories();
      }
    }
  );

  // Grocery items table
  db.run(
    `CREATE TABLE IF NOT EXISTS grocery_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    category_id INTEGER,
    is_completed BOOLEAN DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories (id)
  )`,
    (err) => {
      if (err) {
        console.error("Error creating grocery_items table:", err.message);
      } else {
        console.log("Grocery items table created or already exists.");
      }
    }
  );
}

// Insert default categories
function insertDefaultCategories() {
  const defaultCategories = [
    { name: "Vegetables", color: "#4CAF50" },
    { name: "Fruits", color: "#FF9800" },
    { name: "Meat", color: "#F44336" },
    { name: "Dairy", color: "#2196F3" },
    { name: "Bakery", color: "#795548" },
    { name: "Beverages", color: "#9C27B0" },
    { name: "Snacks", color: "#FFC107" },
    { name: "Household", color: "#607D8B" },
  ];

  const stmt = db.prepare(
    "INSERT OR IGNORE INTO categories (name, color) VALUES (?, ?)"
  );
  defaultCategories.forEach((category) => {
    stmt.run(category.name, category.color);
  });
  stmt.finalize();
}

// API Routes

// Get all categories
app.get("/api/categories", (req, res) => {
  db.all("SELECT * FROM categories ORDER BY name", [], (err, rows) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.json(rows);
  });
});

// Create new category
app.post("/api/categories", (req, res) => {
  const { name, color } = req.body;
  if (!name || !color) {
    res.status(400).json({ error: "Name and color are required" });
    return;
  }

  db.run(
    "INSERT INTO categories (name, color) VALUES (?, ?)",
    [name, color],
    function (err) {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      res.json({ id: this.lastID, name, color });
    }
  );
});

// Get all grocery items
app.get("/api/grocery-items", (req, res) => {
  db.all(
    `
    SELECT 
      gi.*,
      c.name as category_name,
      c.color as category_color
    FROM grocery_items gi
    LEFT JOIN categories c ON gi.category_id = c.id
    ORDER BY gi.created_at DESC
  `,
    [],
    (err, rows) => {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      res.json(rows);
    }
  );
});

// Create new grocery item
app.post("/api/grocery-items", (req, res) => {
  const { name, quantity, category_id } = req.body;
  if (!name) {
    res.status(400).json({ error: "Name is required" });
    return;
  }

  db.run(
    "INSERT INTO grocery_items (name, quantity, category_id) VALUES (?, ?, ?)",
    [name, quantity || 1, category_id || null],
    function (err) {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      res.json({
        id: this.lastID,
        name,
        quantity: quantity || 1,
        category_id: category_id || null,
        is_completed: 0,
        created_at: new Date().toISOString(),
      });
    }
  );
});

// Update grocery item
app.put("/api/grocery-items/:id", (req, res) => {
  const { id } = req.params;
  const { name, quantity, category_id, is_completed } = req.body;

  db.run(
    "UPDATE grocery_items SET name = ?, quantity = ?, category_id = ?, is_completed = ? WHERE id = ?",
    [name, quantity, category_id, is_completed ? 1 : 0, id],
    function (err) {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      if (this.changes === 0) {
        res.status(404).json({ error: "Item not found" });
        return;
      }
      res.json({ message: "Item updated successfully" });
    }
  );
});

// Delete grocery item
app.delete("/api/grocery-items/:id", (req, res) => {
  const { id } = req.params;

  db.run("DELETE FROM grocery_items WHERE id = ?", [id], function (err) {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    if (this.changes === 0) {
      res.status(404).json({ error: "Item not found" });
      return;
    }
    res.json({ message: "Item deleted successfully" });
  });
});

// Toggle item completion
app.patch("/api/grocery-items/:id/toggle", (req, res) => {
  const { id } = req.params;

  db.get(
    "SELECT is_completed FROM grocery_items WHERE id = ?",
    [id],
    (err, row) => {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      if (!row) {
        res.status(404).json({ error: "Item not found" });
        return;
      }

      const newStatus = row.is_completed ? 0 : 1;
      db.run(
        "UPDATE grocery_items SET is_completed = ? WHERE id = ?",
        [newStatus, id],
        function (err) {
          if (err) {
            res.status(500).json({ error: err.message });
            return;
          }
          res.json({ is_completed: newStatus === 1 });
        }
      );
    }
  );
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
  console.log(`API available at http://localhost:${PORT}/api`);
});

// Graceful shutdown
process.on("SIGINT", () => {
  db.close((err) => {
    if (err) {
      console.error("Error closing database:", err.message);
    } else {
      console.log("Database connection closed.");
    }
    process.exit(0);
  });
});
