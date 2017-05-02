console.log("ca");
window.addEventListener('scroll', function() {  
  if (window.scrollY > 0) {
    document.querySelector('body').classList.add("scrolled");
  } else {
    document.querySelector('body').classList.remove("scrolled");
  }
});