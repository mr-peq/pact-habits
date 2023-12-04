import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="badge"
export default class extends Controller {
  connect() {
    this.modalEvents();
  }

  modalEvents() {
    const modalLaunchers = document.querySelectorAll('.launch-modal');
    modalLaunchers.forEach((modalLauncher) => {
      modalLauncher.addEventListener('click', this.showModal)
    });
  }

  showModal(e) {
    e.currentTarget.nextElementSibling.classList.remove('d-none');
  }
}
