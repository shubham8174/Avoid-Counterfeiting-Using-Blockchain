document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('login-form');
    loginForm.addEventListener('submit', function(event) {
        event.preventDefault();

        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        
        if (username === 'retailer' && password === 'ret@23') {
        
            window.location.href = 'retailer.html';
        
        } else {
            
            alert('Invalid username or password');
        }
    });
});