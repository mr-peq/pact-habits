import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upgrade-avatar"
export default class extends Controller {

  static targets = ["upgradePoints", "skills", "statsAndSkills", "updateBtn"];

  connect() {
    const upgradePoints = +this.upgradePointsTarget.innerText;
    const addBtns = document.querySelectorAll('.increment-btn');
    if (upgradePoints && addBtns.length == 0) this.#incrementButtons();
    if (upgradePoints >= 4 && addBtns.length == 0) this.#newSkillButton()
  }

  #incrementButtons() {
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

  #removeNewSkillButton() {
    document.getElementById('skillSlot').innerHTML = "";
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
      case "crit_rate":
        statValue.innerText = `${(+(statValue.innerText.slice(0, -1)) + 2)}%`;
        break;
      default:
        statValue.innerText = +(statValue.innerText) + 1;
        break;
    };
    this.upgradePointsTarget.innerText = +(this.upgradePointsTarget.innerText) - 1;
    const upgradePoints = +this.upgradePointsTarget.innerText
    if (!upgradePoints) {
      this.#removeButtons();
      this.updateBtnTarget.classList.remove('hide');
    }
    if (upgradePoints < 4) this.#removeNewSkillButton();

    const decrementBtn = statValue.parentElement.querySelector('.decrement-btn');
    if (decrementBtn == null) this.#decrementButton(statValue);
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
    const upgradePoints = +this.upgradePointsTarget.innerText
    if (!upgradePoints) {
      this.#removeButtons();
      this.updateBtnTarget.classList.remove('hide');
    }
    // if (upgradePoints < 4) this.#removeNewSkillButton();
  }

  #decrementButton(statValue) {
    const decrementBtn = `<i class="fa-solid fa-circle-minus decrement-btn" data-action="click->upgrade-avatar#decrement" style="font-size: 1.5em;"></i>`;
    statValue.insertAdjacentHTML('beforebegin', decrementBtn);
  }

  decrement(event) {
    const statValue = event.currentTarget.nextElementSibling;
    const initialStats = this.#getInitialStats();
    switch (statValue.id) {
      case "health":
        statValue.innerText = +(statValue.innerText) - 20;
        if (statValue.innerText == initialStats[statValue.id]) this.#removeDecrementButton(statValue.parentElement);
        break;
      case "mana":
        statValue.innerText = +(statValue.innerText) - 20;
        if (statValue.innerText == initialStats[statValue.id]) this.#removeDecrementButton(statValue.parentElement);
        break;
      case "crit_rate":
        statValue.innerText = `${+(statValue.innerText.slice(0, -1)) - 2}%`;
        if (statValue.innerText.slice(0, -1) == initialStats[statValue.id]) this.#removeDecrementButton(statValue.parentElement);
        break;
      default:
        statValue.innerText = +(statValue.innerText) - 1;
        if (statValue.innerText == initialStats[statValue.id]) this.#removeDecrementButton(statValue.parentElement);
        break;
    };

    this.upgradePointsTarget.innerText = +(this.upgradePointsTarget.innerText) + 1;
    const upgradePoints = +this.upgradePointsTarget.innerText

    const incrementBtn = statValue.parentElement.querySelector('.increment-btn');
    if (incrementBtn == null) this.#incrementButtons();
    if (upgradePoints > 0) this.updateBtnTarget.classList.add('hide');
    if (upgradePoints >= 4) this.#newSkillButton();
  }

  #removeDecrementButton(parent) {
    const decrementBtn = parent.querySelector('.decrement-btn');
    parent.removeChild(decrementBtn);
  }

  #getInitialStats() {
    const initialValues = document.getElementById('initialStats').querySelectorAll('div');
    const initialStats = {};
    initialValues.forEach((stat) => {
      const key = stat.firstElementChild.innerText;
      const value = stat.lastElementChild.innerText;
      initialStats[key] = value;
    });
    return initialStats;
  }

  update() {
    const url = window.location.toString();
    const stats = {};
    const newStats = document.querySelectorAll('.stat');
    newStats.forEach((newStat) => {
      const key = newStat.lastElementChild.id;
      let value;
      if (key != "crit_rate") {
        value = +(newStat.lastElementChild.innerText);
      } else {
        value = +(newStat.lastElementChild.innerText.slice(0, -1));
      }
      stats[key] = value;
    });

    console.log(stats);
    const token = document.getElementsByName('csrf-token')[0].content;
    fetch(url, {
      method: "PATCH",
      headers: {
        "Accept": "application/json",
        "X-CSRF-Token": token
       },
      body: JSON.stringify({ stats })
    })
    .then(response => response.json())
    .then((data) => {
      this.statsAndSkillsTarget.outerHTML = data.html;
    })
  }
}
