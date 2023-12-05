import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.add("fade-out");
      setTimeout(() => {
        this.element.remove();
      }, 2000); // Remove the alert after the animation
    }, 2000); // Change 5000 to the desired display duration in milliseconds
  }
}
