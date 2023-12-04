import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pact"
export default class extends Controller {

  static targets = ["modal"]

  connect() {
    console.log("Pact controller connected");
  }

  validate(e) {
    e.preventDefault();
    this.showModal();

    setTimeout(() => {
      const form = document.querySelector('form');
      console.log(form);
    }, 1000);
  }

  showModal() {
    this.modalTarget.classList.remove('d-none');
  }
}
