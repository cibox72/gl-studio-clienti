// auth.js
(function() {
  if (!localStorage.getItem('isLoggedIn')) {
    if (window.location.pathname !== '/index.html' && window.location.pathname !== '/index.html/') {
      window.location.href = 'index.html';
    }
  }
})();
