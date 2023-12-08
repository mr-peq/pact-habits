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
    const badge = this.formTarget.parentElement;
    badge.classList.add('spin-and-climb');

    setTimeout(() => {
      badge.classList.add('spin-faster');
    }, 1900);

    setTimeout(() => {
      badge.classList.remove('spin-and-climb');
    }, 2000);

    setTimeout(() => {
      badge.classList.add('spin-rocket');
      badge.classList.remove('spin-faster');
    }, 3000);

    setTimeout(() => {
      badge.classList.add('dive-in');
      badge.classList.remove('spin-rocket');
    }, 4000);

    setTimeout(() => {
      const badgeCard = modal.parentElement.parentElement;
      badgeCard.remove();
    }, 4450);

    setTimeout(() => {
      badge.classList.add('d-none');
      badge.classList.remove('dive-in');
      // const badgeCard = modal.parentElement.parentElement;
      // badgeCard.remove();
      document.documentElement.style.setProperty('--mbcolor', "#666");
      this.myBadgesTarget.insertAdjacentHTML(
        'beforeend',
        '<div class="insert-badge-star mx-2"><img src="/assets/special/insert-badge-star-a422445f4e003685727bacccb6c4e5921049212495a401b54e5ea4d4ddacd5c6.svg"></div>'
        );
    }, 4500);
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
        // const newBadge = document.querySelector('.my-badges div:last-child');
        // newBadge.classList.add('check-me-out');
      });
    }, 5500);
    // before: 4500, added 200ms security (in case of slow response from controller)
  }
}
