// SharpishlyApp Game Engine
// Version: Phase 1 — Browser-Only Responsive Engine
// Author: sharpishly / ChatGPT (2025)

const app = {};

// Show loading animation
app.showLoading = function () {
  if (document.getElementById("loader")) return;
  const loader = document.createElement("div");
  loader.id = "loader";
  loader.textContent = "⏳ Loading...";
  Object.assign(loader.style, {
    position: "fixed",
    top: "50%",
    left: "50%",
    transform: "translate(-50%, -50%)",
    background: "rgba(0,0,0,0.75)",
    color: "#fff",
    padding: "1em 2em",
    borderRadius: "8px",
    fontFamily: "monospace",
    zIndex: 9999,
  });
  document.body.appendChild(loader);
};

// Hide loading animation
app.hideLoading = function () {
  const loader = document.getElementById("loader");
  if (loader) loader.remove();
};

// Minimal GET wrapper with fallback
app.get = async function (url) {
  try {
    app.showLoading();
    const response = await fetch(url, { method: "GET" });
    if (!response.ok) throw new Error(`HTTP error! ${response.status}`);
    const data = await response.json().catch(() => response.text());
    console.log("✅ Response:", data);
    return data;
  } catch (err) {
    console.error("❌ Fetch failed:", err);
  } finally {
    app.hideLoading();
  }
};

// Initialize a simple 2D “game” on canvas
app.initGame = function () {
  const canvas = document.getElementById("gameCanvas");
  if (!canvas) return console.error("Canvas not found");
  const ctx = canvas.getContext("2d");

  let player = { x: 400, y: 300, size: 20, speed: 5 };
  const keys = {};

  document.addEventListener("keydown", e => (keys[e.key] = true));
  document.addEventListener("keyup", e => (keys[e.key] = false));

  function loop() {
    // Update
    if (keys["ArrowLeft"]) player.x -= player.speed;
    if (keys["ArrowRight"]) player.x += player.speed;
    if (keys["ArrowUp"]) player.y -= player.speed;
    if (keys["ArrowDown"]) player.y += player.speed;

    // Keep player in bounds
    player.x = Math.max(player.size, Math.min(canvas.width - player.size, player.x));
    player.y = Math.max(player.size, Math.min(canvas.height - player.size, player.y));

    // Draw
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = "#3498db";
    ctx.beginPath();
    ctx.arc(player.x, player.y, player.size, 0, Math.PI * 2);
    ctx.fill();

    requestAnimationFrame(loop);
  }

  loop();
};

document.addEventListener("DOMContentLoaded", () => {
  console.log("🎮 Sharpishly Game Engine initialized");
  app.initGame();

  // Optional test endpoint
  app.get("/game/test").catch(() =>
    console.warn("⚠️ Test endpoint unavailable — continuing offline mode.")
  );
});
