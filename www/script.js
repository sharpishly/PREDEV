
/**
 * @file script.js
 * @brief JavaScript utilities for API calls in the Sharpishly Dev Dashboard
 */

/**
 * @brief Makes an API call and streams the response
 * @param path API endpoint path
 */
async function callApi(path) {
    const outputEl = document.getElementById('output');
    outputEl.textContent = '';
    try {
        const res = await fetch(path, { method: 'POST' });
        const reader = res.body.getReader();
        const decoder = new TextDecoder();
        while (true) {
            const { done, value } = await reader.read();
            if (done) break;
            outputEl.textContent += decoder.decode(value);
            outputEl.scrollTop = outputEl.scrollHeight;
        }
    } catch (error) {
        outputEl.textContent = '❌ Error calling API: ' + error.message;
    }
}

