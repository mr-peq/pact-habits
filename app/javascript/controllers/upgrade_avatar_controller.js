import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upgrade-avatar"
export default class extends Controller {

  static targets = ["upgradePoints", "skills"]

  connect() {
    const upgradePoints = +this.upgradePointsTarget.innerText;
    if (upgradePoints) this.#addButtons()
    if (upgradePoints >= 4) this.#newSkillButton()
  }

  #addButtons() {
    const stats = document.querySelectorAll('.stat');
    const incrementBtn = `<i class="fa-solid fa-circle-plus increment-btn" data-action="click->upgrade-avatar#increment"></i>`;
    stats.forEach((stat) => {
      stat.insertAdjacentHTML('beforeend', incrementBtn);
    });
  }

  #newSkillButton() {
    const skillSlot = document.getElementById('skillSlot');
    if (skillSlot != null) {
      const newSkillBtn = `new skill ! <i class="fa-solid fa-circle-plus new-skill-btn" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBottom" aria-controls="offcanvasBottom"></i>`;
      skillSlot.insertAdjacentHTML('beforeend', newSkillBtn);
    }
  }

  increment(event) {
    const statValue = event.currentTarget.previousElementSibling;
    switch (statValue.id) {
      case "health":
        statValue.innerText = +(statValue.innerText) + 20;
        break;
      case "mana":
        statValue.innerText = +(statValue.innerText) + 20;
        break;
      case "critRate":
        statValue.innerText = `${+(statValue.innerText.slice(0, -1)) + 2}%`;
        break;
      default:
        statValue.innerText = +(statValue.innerText) + 1;
        break;
    };
    this.upgradePointsTarget.innerText = +(this.upgradePointsTarget.innerText) - 1;
    if (!(+(this.upgradePointsTarget.innerText))) this.#removeButtons();
  }

  #removeButtons() {
    const stats = document.querySelectorAll('.stat');
    stats.forEach((stat) => {
      stat.removeChild(stat.querySelector('.increment-btn'));
    });
  }

  addSkill(event) {
    const newSkillName = event.currentTarget.innerText;
    const skillSlot = document.getElementById('skillSlot');
    const newSkill = document.createElement('div');
    newSkill.classList.add('skill');
    newSkill.innerText = newSkillName;

    this.skillsTarget.removeChild(skillSlot);
    this.skillsTarget.appendChild(newSkill);
    this.upgradePointsTarget.innerText = +(this.upgradePointsTarget.innerText) - 4;
    if (!(+(this.upgradePointsTarget.innerText))) this.#removeButtons();
  }
}
