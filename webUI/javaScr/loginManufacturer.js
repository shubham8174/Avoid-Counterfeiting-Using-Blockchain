document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('login-form');
    loginForm.addEventListener('submit', function(event) {
        event.preventDefault();

        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        
        if (username === 'manufacturer' && password === 'manu@23') {
        
            window.location.href = 'manufacturer.html';
        
        } else {
            
            alert('Invalid username or password');
        }
    });
});