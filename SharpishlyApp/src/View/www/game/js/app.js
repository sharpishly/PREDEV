// src/View/www/game/js/app.js

// Define global app object
const app = {};

// Simple loading animation (replace with CSS spinner if you want)
app.showLoading = function () {
  const loader = document.createElement("div");
  loader.id = "loader";
  loader.innerText = "⏳ Loading...";
  document.body.appendChild(loader);
};

app.hideLoading = function () {
  const loader = document.getElementById("loader");
  if (loader) loader.remove();
};

// Minimal GET request wrapper
app.get = async function (url) {
  try {
    app.showLoading();

    const response = await fetch(url, { method: "GET" });
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.json().catch(() => response.text()); // JSON or fallback text
    console.log("✅ Data received:", data);

    return data;
  } catch (error) {
    console.error("❌ Request failed:", error);
  } finally {
    app.hideLoading();
  }
};

// Example usage on page load
document.addEventListener("DOMContentLoaded", () => {
  console.log("🎮 Game Engine ready...");
  // Example test request
  app.get("/game/test");
});
