import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="top-navbar"
export default class extends Controller {
  static targets = ["navbar"]

  connect() {
    console.log("top-navbar")
    this.lastScrollTop = 0;
    window.addEventListener('scroll', this.handleScroll.bind(this));
  }

  handleScroll() {
    let currentScroll = window.scrollY || document.documentElement.scrollTop;
    console.log('Current Scroll: ', currentScroll);

    if (currentScroll > this.lastScrollTop) {
      console.log('Scrolling down');
      this.navbarTarget.classList.add('navbar-hidden');
    } else {
      console.log('Scrolling up');
      this.navbarTarget.classList.remove('navbar-hidden');
    }
    this.lastScrollTop = currentScroll <= 0 ? 0 : currentScroll; // For Mobile or negative scrolling
  }
}
