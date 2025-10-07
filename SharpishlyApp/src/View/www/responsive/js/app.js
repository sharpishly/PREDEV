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

// Minimal GET wrapper with safe body parsing
app.get = async function (url) {
  try {
    app.showLoading();
    const response = await fetch(url, { method: "GET" });
    if (!response.ok) throw new Error(`HTTP error! ${response.status}`);
    const text = await response.text();
    let data;
    try {
      data = JSON.parse(text);
    } catch {
      data = text;
    }
    console.log("✅ Response:", data);
    app.msg(data);
    return data;
  } catch (err) {
    console.error("❌ Fetch failed:", err);
    app.msg(`<span style="color:red;">${err.message}</span>`);
    throw err; // Allow calling code to handle errors
  } finally {
    app.hideLoading();
  }
};

// Output message into <div id="test">
app.msg = function (msg) {
  const test = document.getElementById("test");
  if (test) {
    test.innerHTML = msg;
  } else {
    console.warn("⚠️ Element #test not found!");
  }
};