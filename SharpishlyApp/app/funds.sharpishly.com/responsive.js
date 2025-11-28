// responsive.js – pure vanilla JS, no dependencies
document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('fundingForm');
    const successMessage = document.getElementById('successMessage');

    // Simple email regex
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    form.addEventListener('submit', function (e) {
        e.preventDefault();
        let isValid = true;

        // Reset previous errors
        document.querySelectorAll('.error').forEach(el => el.textContent = '');

        // Validate Name
        const name = document.getElementById('name').value.trim();
        if (name.length < 2) {
            showError('name', 'Name must be at least 2 characters');
            isValid = false;
        }

        // Validate Email
        const email = document.getElementById('email').value.trim();
        if (!emailRegex.test(email)) {
            showError('email', 'Please enter a valid email address');
            isValid = false;
        }

        // Validate Amount
        const amount = document.getElementById('amount').value;
        if (!amount || amount < 1000) {
            showError('amount', 'Minimum funding request is $1,000');
            isValid = false;
        }

        // Validate Idea
        const idea = document.getElementById('idea').value.trim();
        if (idea.length < 20) {
            showError('idea', 'Tell us more – at least 20 characters');
            isValid = false;
        }

        if (isValid) {
            // Simulate submission
            successMessage.classList.add('success-visible');
            form.reset();
            // Auto-hide message after 8 seconds
            setTimeout(() => {
                successMessage.classList.remove('success-visible');
            }, 8000);
        }
    });

    function showError(fieldId, message) {
        const field = document.querySelector(`#${fieldId}`);
        const errorEl = field.parentElement.querySelector('.error');
        errorEl.textContent = message;
    }
});