const sqlite3 = require("sqlite3").verbose();
const fs = require("fs");

// Delete existing database file
if (fs.existsSync("./shopping_list.db")) {
  fs.unlinkSync("./shopping_list.db");
  console.log("Existing database deleted.");
}

// Create new database
const db = new sqlite3.Database("./shopping_list.db", (err) => {
  if (err) {
    console.error("Error creating database:", err.message);
  } else {
    console.log("New database created successfully.");
    initDatabase();
  }
});

function initDatabase() {
  // Categories table with unique constraint
  db.run(
    `CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    color TEXT NOT NULL
  )`,
    (err) => {
      if (err) {
        console.error("Error creating categories table:", err.message);
      } else {
        console.log("Categories table created with UNIQUE constraint on name.");
        insertDefaultCategories();
      }
    }
  );

  // Grocery items table
  db.run(
    `CREATE TABLE grocery_items (
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
        console.log("Grocery items table created.");
      }
    }
  );
}

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

  const stmt = db.prepare("INSERT INTO categories (name, color) VALUES (?, ?)");

  defaultCategories.forEach((category, index) => {
    stmt.run(category.name, category.color, (err) => {
      if (err) {
        console.error(`Error inserting ${category.name}:`, err.message);
      } else {
        console.log(`✓ ${category.name} added successfully`);
      }

      // Close database after last category
      if (index === defaultCategories.length - 1) {
        stmt.finalize(() => {
          db.close((err) => {
            if (err) {
              console.error("Error closing database:", err.message);
            } else {
              console.log("\n✅ Database reset completed successfully!");
              console.log("You can now start the server with: npm run dev");
            }
          });
        });
      }
    });
  });
}
