import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="circle-xp"
export default class extends Controller {

  static targets = ["xp", "toNext"];

  connect() {
    this.setXP();
  }

  setXP() {
    const xp = +(this.xpTarget.innerText);
    const toNext = +(this.toNextTarget.innerText);
    const fillPercentage = Math.round((xp / toNext) * 100);
    this.element.style = `background: linear-gradient(white, white) content-box no-repeat, conic-gradient(#4ECDC4 ${fillPercentage}%, 0, #A6ACBA ) border-box;`;
  }
}
