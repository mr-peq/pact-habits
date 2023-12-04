import { Controller } from "@hotwired/stimulus";
// import Typed from "typedjs";

// Connects to data-controller="pact"
export default class extends Controller {

  static targets = ["modal"]

  connect() {
    console.log("Pact controller connected");
  }

  validate(e) {
    e.preventDefault();
    this.showModal();
    const waitMessage = document.getElementById('waitMessage');
    const form = document.querySelector('form');
    // const typed = new Typed('#waitMessage', {
    //   strings: ['test', 'test'],
    //   typeSpeed: 50,
    // });

    const messages = [
      "Compiling data...",
      "Looking for a pact-finisher...",
      "Excluding manual activities...",
      "Running as fast as we can..."
    ];
    let i = 0;
    setInterval(() => {
      waitMessage.innerText = messages[i];
      i++;
    }, 2000);

    setTimeout(() => {
      form.submit();
    }, 5000);
  }

  showModal() {
    this.modalTarget.classList.remove('d-none');
  }
}
