import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="my-badges"
export default class extends Controller {

  static targets = ["form", "myBadges"];

  connect() {
    console.log("BADGES CONTROLLER");
    console.log(this.formTarget);
  }

  getBadge(event) {
    event.preventDefault();

    const url = this.formTarget.action;
    const body = new FormData(this.formTarget);

    const modal = this.formTarget.parentElement.parentElement.parentElement;
    modal.classList.remove('modal-container');
    this.formTarget.parentElement.classList.add('spin-faster');

    setTimeout(() => {
      this.formTarget.parentElement.classList.remove('spin-faster');
      this.formTarget.parentElement.classList.add('spin-even-faster');
    }, 500);

    setTimeout(() => {
      this.formTarget.parentElement.classList.remove('spin-even-faster');
      this.formTarget.parentElement.classList.add('spin-rocket');
    }, 750);

    setTimeout(() => {
      this.formTarget.parentElement.classList.remove('spin-rocket');
      this.formTarget.parentElement.classList.add('dive-in');
    }, 1000);

    setTimeout(() => {
      this.formTarget.parentElement.classList.remove('dive-in');
      this.formTarget.parentElement.classList.add('d-none');
      const badgeCard = modal.parentElement.parentElement;
      this.element.removeChild(badgeCard);
      document.documentElement.style.setProperty('--mbcolor', "#666");
      this.myBadgesTarget.insertAdjacentHTML(
        'beforeend',
        '<div class="insert-badge-star mx-2"><img src="/assets/special/insert-badge-star-a422445f4e003685727bacccb6c4e5921049212495a401b54e5ea4d4ddacd5c6.svg"></div>'
        );
    }, 1500);

    setTimeout(() => {
      fetch(url, {
        method: "PATCH",
        headers: {
          "Accept": "application/json"
         },
        body: body
      })
      .then(response => response.json())
      .then((data) => {
        document.documentElement.style.setProperty('--mbcolor', "#ffffff");
        this.myBadgesTarget.parentElement.outerHTML = data.html;
      });
    }, 2500);
  }
}
