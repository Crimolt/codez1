function checkWindowScrolled() {
  if (window.scrollY >= 10) {
    document.querySelector('body').classList.add("scrolled");
  } else {
    document.querySelector('body').classList.remove("scrolled");
  }
}

window.addEventListener('scroll', checkWindowScrolled);

window.addEventListener('load', checkWindowScrolled);