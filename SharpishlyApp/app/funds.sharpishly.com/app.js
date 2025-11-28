const app = {};

// Navigation Menu
app.menus = [
    { key: 'home', value: 'Home' },
    { key: 'about', value: 'About' },
    { key: 'login', value: 'Login' },
    { key: 'register', value: 'Register' }
];

// Optimized registration fields array
app.fields = [
    {
        key: 'title',
        value: 'Title',
        attr: {
            type: 'select',
            placeholder: 'Select a title',
            required: true
        }
    },
    {
        key: 'full_name',
        value: 'Full Name',
        attr: {
            type: 'text',
            placeholder: 'John Doe',
            minlength: 2,
            required: true
        }
    },
    {
        key: 'username',
        value: 'Username',
        attr: {
            type: 'text',
            placeholder: 'coolcat123',
            minlength: 4,
            maxlength: 20,
            pattern: '^[a-zA-Z0-9_]+$',
            title: 'Only letters, numbers, and underscores allowed',
            required: true
        }
    },
    {
        key: 'email',
        value: 'Email Address',
        attr: {
            type: 'email',
            placeholder: 'user@york.ac.uk',
            required: true
        }
    },
    {
        key: 'phone',
        value: 'Phone Number',
        attr: {
            type: 'tel',
            placeholder: '+44 (0) 1234 567890',
            pattern: '^[+]?[\\d\\s\\-\\(\\)]{10,20}$',
            title: 'Enter a valid phone number',
            required: true
        }
    },
    {
        key: 'date_of_birth',
        value: 'Date of Birth',
        attr: {
            type: 'date',
            required: true
        }
    },
    {
        key: 'country_region_of_nationality',
        value: 'Country/Region of Nationality',
        attr: {
            type: 'text',
            placeholder: 'United Kingdom',
            minlength: 2,
            required: true
        }
    },
    {
        key: 'second_country_region_of_nationality',
        value: 'Second Country/Region of Nationality',
        attr: {
            type: 'text',
            placeholder: 'Leave blank if not applicable',
            minlength: 2,
            required: false
        }
    },
    {
        key: 'country_of_domicile',
        value: 'Country of Domicile',
        attr: {
            type: 'text',
            placeholder: 'United Kingdom',
            minlength: 2,
            required: true
        }
    },
    {
        key: 'research_title',
        value: 'Research Title',
        attr: {
            type: 'text',
            placeholder: 'Enter the title of your research project',
            minlength: 10,
            maxlength: 200,
            required: true
        }
    },
    {
        key: 'research_proposal_summary',
        value: 'Research Proposal Summary',
        attr: {
            type: 'textarea',
            rows: 6,
            placeholder: 'Provide a concise summary of your research proposal...',
            maxlength: 1000,
            required: true
        }
    },
    {
        key: 'research_proposal',
        value: 'Detailed Research Proposal',
        attr: {
            type: 'textarea',
            rows: 10,
            placeholder: 'Provide a detailed description of your research proposal...',
            maxlength: 4000,
            required: true
        }
    },
    {
        key: 'password',
        value: 'Password',
        attr: {
            type: 'password',
            minlength: 8,
            required: true
        }
    },
    {
        key: 'confirm_password',
        value: 'Confirm Password',
        attr: {
            type: 'password',
            minlength: 8,
            required: true
        }
    },
    {
        key: 'personal_statement',
        value: 'Personal Statement/Bio',
        attr: {
            type: 'textarea',
            rows: 4,
            placeholder: 'Briefly describe your background, qualifications, and research interests...',
            maxlength: 500,
            required: true
        }
    }
];

// Add a single form input/textarea with proper labeling
app.addFormInput = function (section, field) {
    const div = document.createElement('div');
    div.className = 'form-group';
    section.appendChild(div);

    const label = document.createElement('label');
    label.setAttribute('for', field.key);
    label.textContent = field.value;
    div.appendChild(label);

    let input;

    if (field.attr.type === 'textarea') {
        input = document.createElement('textarea');
        if (field.attr.rows) input.setAttribute('rows', field.attr.rows);
    } else {
        input = document.createElement('input');
        input.setAttribute('type', field.attr.type || 'text');
    }

    // Apply all attributes
    input.id = field.key;
    input.name = field.key;
    if (field.attr.placeholder) input.placeholder = field.attr.placeholder;
    if (field.attr.minlength) input.minLength = field.attr.minlength;
    if (field.attr.maxlength) input.maxLength = field.attr.maxlength;
    if (field.attr.pattern) input.pattern = field.attr.pattern;
    if (field.attr.title) input.title = field.attr.title;
    if (field.attr.required) input.required = true;

    div.appendChild(input);

    // Error message span
    const error = document.createElement('span');
    error.className = 'error';
    div.appendChild(error);
};

// Create the full registration form
app.addForm = function () {
    const container = document.getElementById('main');
    const form = document.createElement('form');
    form.id = 'registerForm';
    form.noValidate = true; // We'll handle validation manually if needed

    const section = document.createElement('section');
    section.className = 'form-section';

    const h2 = document.createElement('h2');
    h2.textContent = 'Join Funder Cat – Create Your Account';
    section.appendChild(h2);

    // Add all fields
    app.fields.forEach(field => {
        app.addFormInput(section, field);
    });

    // Submit button
    const submitBtn = document.createElement('button');
    submitBtn.type = 'submit';
    submitBtn.textContent = 'Create Account';
    submitBtn.className = 'btn-primary';
    section.appendChild(submitBtn);

    form.appendChild(section);
    container.appendChild(form);

    // Optional: Handle form submission
    form.addEventListener('submit', function (e) {
        e.preventDefault();
        alert('Welcome to Funder Cat! Your account is ready!');
        // form.submit(); // Uncomment if using real backend
    });
};

// Main menu
app.addMainMenu = function () {
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

    container.appendChild(ul); // Fixed: was inside loop before!
};

// Titles
app.addMainTitle = function () {
    const container = document.getElementById('container');
    const h1 = document.createElement('h1');
    h1.textContent = 'Funder Cat';
    container.appendChild(h1);
};

app.addSubtitle = function () {
    const container = document.getElementById('container');
    const h2 = document.createElement('h2');
    h2.textContent = 'The cat that funds your dreams';
    container.appendChild(h2);
};

// Main app runner
app.run = function () {
    app.addMainMenu();
    app.addMainTitle();
    app.addSubtitle();
    app.addForm();
};

// Safe window load
window.addEventListener('load', app.run);