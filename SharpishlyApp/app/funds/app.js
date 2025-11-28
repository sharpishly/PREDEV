const app = {};

// Navigation Menu
app.menus = [
    { key: 'home', value: 'Home' },
    { key: 'about', value: 'About' },
    { key: 'login', value: 'Login' },
    { key: 'register', value: 'Register' }
];

// Define common attribute sets (unchanged)
app.commonAttrs = {
    textField: { type: 'text', required: true },
    requiredTextField: { type: 'text', required: true, minlength: 2 },
    emailField: { type: 'email', required: true },
    passwordField: { type: 'password', required: true, minlength: 8 },
    textareaField: { type: 'textarea', required: true, rows: 4 }
};

// Fields array (unchanged)
app.fields = [
    {
        key: 'title',
        value: 'Title',
        attr: {
            ...app.commonAttrs.textField,
            type: 'select',
            placeholder: 'Select a title'
        }
    },
    {
        key: 'full_name',
        value: 'Full Name',
        attr: {
            ...app.commonAttrs.requiredTextField,
            placeholder: 'John Doe'
        }
    },
    {
        key: 'email',
        value: 'Email Address',
        attr: {
            ...app.commonAttrs.emailField,
            placeholder: 'user@york.ac.uk'
        }
    },
    {
        key: 'password',
        value: 'Password',
        attr: {
            ...app.commonAttrs.passwordField
        }
    },
    {
        key: 'research_proposal_summary',
        value: 'Research Proposal Summary',
        attr: {
            ...app.commonAttrs.textareaField,
            rows: 6,
            maxlength: 1000,
            placeholder: 'Provide a concise summary of your research proposal...'
        }
    }
];

app.next = function(currentInput, currentIndex) {
    const value = currentInput.value.trim();
    if (value !== '') {
        const nextFieldIndex = currentIndex + 1;
        const nextFieldDiv = document.querySelector(`[data-field-index="${nextFieldIndex}"]`);
        if (nextFieldDiv && nextFieldDiv.style.display === 'none') {
            nextFieldDiv.style.display = 'block';
            nextFieldDiv.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }
};

app.addFormInput = function(section, field, index) {
    const div = document.createElement('div');
    div.className = 'form-group';
    
    // Hide all fields except the first one
    if (index !== 0) {
        div.style.display = 'none';
    }
    
    // Add data attribute to identify the field by its index
    div.setAttribute('data-field-index', index);
    
    section.appendChild(div);

    const label = document.createElement('label');
    label.setAttribute('for', field.key);
    label.textContent = field.value;
    div.appendChild(label);

    let input;

    if (field.attr.type === 'select') {
        input = document.createElement('select');
        input.id = field.key;
        input.name = field.key;
        if (field.attr.required) input.required = true;

        const optionsToUse = field.options || [
            { value: '', text: 'Please select a title' },
            { value: 'Doctor', text: 'Doctor' },
            { value: 'Ms', text: 'Ms' },
            { value: 'Mr', text: 'Mr' },
            { value: 'Mrs', text: 'Mrs' },
            { value: 'Miss', text: 'Miss' },
            { value: 'Prof', text: 'Professor' },
            { value: 'Dr', text: 'Dr' },
            { value: 'Rev', text: 'Reverend' }
        ];

        optionsToUse.forEach(function(optionData) {
            const option = document.createElement('option');
            option.value = optionData.value;
            option.textContent = optionData.text;
            input.appendChild(option);
        });

    } else if (field.attr.type === 'textarea') {
        input = document.createElement('textarea');
        if (field.attr.rows) input.setAttribute('rows', field.attr.rows);
    } else {
        input = document.createElement('input');
        input.setAttribute('type', field.attr.type || 'text');
    }

    // Apply all attributes
    if (field.attr.placeholder) input.placeholder = field.attr.placeholder;
    if (field.attr.minlength) input.minLength = field.attr.minlength;
    if (field.attr.maxlength) input.maxLength = field.attr.maxlength;
    if (field.attr.pattern) input.pattern = field.attr.pattern;
    if (field.attr.title) input.title = field.attr.title;
    if (field.attr.required) input.required = true;

    div.appendChild(input);

    const error = document.createElement('span');
    error.className = 'error';
    div.appendChild(error);

    // Add event listener to show next field when current field is completed
    const showNextField = function() {
        app.next(input, index);
    };

    input.addEventListener('blur', showNextField);
    input.addEventListener('change', showNextField); // For select elements
};

app.addForm = function() {
    const container = document.getElementById('main');
    const form = document.createElement('form');
    form.id = 'registerForm';
    form.noValidate = true;

    const section = document.createElement('section');
    section.className = 'form-section';

    const h2 = document.createElement('h2');
    h2.textContent = 'Join Funder Cat – Create Your Account';
    section.appendChild(h2);

    // Add all fields with their respective indices
    app.fields.forEach(function(field, index) {
        app.addFormInput(section, field, index);
    });

    // Submit button (always visible)
    const submitBtn = document.createElement('button');
    submitBtn.type = 'submit';
    submitBtn.textContent = 'Create Account';
    submitBtn.className = 'btn-primary';
    section.appendChild(submitBtn);

    form.appendChild(section);
    container.appendChild(form);

    // Handle form submission
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        // Show all remaining hidden fields before submission
        const hiddenFields = section.querySelectorAll('.form-group[style*="display: none"]');
        hiddenFields.forEach(function(field) {
            field.style.display = 'block';
        });
        alert('Welcome to Funder Cat! Your account is ready!');
    });
};

// Rest of the existing functions remain unchanged
app.addMainMenu = function() {
    const container = document.getElementById('container');
    const ul = document.createElement('ul');
    ul.className = 'main-menu';

    app.menus.forEach(menu => {
        const li = document.createElement('li');
        li.textContent = menu.value;
        li.setAttribute('style','border:1px dashed red;float:left;padding-left:20px;padding-right:20px;list-style-type:none');
        li.addEventListener('click', () => {
            alert(`Going to ${menu.value}... (not implemented yet)`);
        });
        ul.appendChild(li);
    });

    container.appendChild(ul);
};

app.addMainTitle = function() {
    const container = document.getElementById('container');
    const h1 = document.createElement('h1');
    h1.textContent = 'Funder Cat';
    container.appendChild(h1);
};

app.addSubtitle = function() {
    const container = document.getElementById('container');
    const h2 = document.createElement('h2');
    h2.textContent = 'The cat that funds your dreams';
    container.appendChild(h2);
};

app.run = function() {
    app.addMainMenu();
    app.addMainTitle();
    app.addSubtitle();
    app.addForm();
};

window.addEventListener('load', app.run);