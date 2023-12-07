import { Controller } from "@hotwired/stimulus";
import confetti from "canvas-confetti";

// Connects to data-controller="my-badges"
export default class extends Controller {

  static targets = ["form", "myBadges", "badgesCount"];

  connect() {
  }

  getBadge(event) {
    event.preventDefault();

    const url = this.formTarget.action;
    const body = new FormData(this.formTarget);

    const modal = this.formTarget.parentElement.parentElement.parentElement;

    // 1st ANIMATION
    modal.classList.remove('modal-container');
    this.formTarget.parentElement.classList.add('spin-and-climb');

    setTimeout(() => {
      this.formTarget.parentElement.classList.add('spin-faster');
    }, 1800);

    setTimeout(() => {
      this.formTarget.parentElement.classList.remove('spin-and-climb');
    }, 2000);

    setTimeout(() => {
      this.formTarget.parentElement.classList.add('dive-in');
      this.formTarget.parentElement.classList.remove('spin-faster');
    }, 3000);

    setTimeout(() => {
      this.formTarget.parentElement.classList.add('d-none');
      this.formTarget.parentElement.classList.remove('dive-in');
      const badgeCard = modal.parentElement.parentElement;
      badgeCard.remove();
      document.documentElement.style.setProperty('--mbcolor', "#666");
      this.myBadgesTarget.insertAdjacentHTML(
        'beforeend',
        '<div class="insert-badge-star mx-2"><img src="/assets/special/insert-badge-star-a422445f4e003685727bacccb6c4e5921049212495a401b54e5ea4d4ddacd5c6.svg"></div>'
        );
    }, 3500);
    // before: 1500

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
        document.documentElement.style.setProperty('--mbcolor', "#96e8e0");
        this.myBadgesTarget.parentElement.outerHTML = data.html;
        confetti({
          particleCount: 100,
          spread: 70,
          origin: { y: 0.6 }
        });
        const currentBadges = +(this.badgesCountTarget.innerText.slice(0, 1));
        this.badgesCountTarget.innerText = `${currentBadges + 1} / 14`;
      });
    }, 4500);
    // before: 2500
  }
}
