import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="circle-timer"
export default class extends Controller {

  static targets = ["deadline", "createdAt"];

  connect() {
    console.log("CIRCLE TIMER CONNECTED");
    console.log(this.deadlineTarget);
    console.log(this.createdAtTarget);
    this.setTimer();
  }

  setTimer() {
    const totalTime = new Date(+this.deadlineTarget.innerText) - new Date(+this.createdAtTarget.innerText);
    const timeLeft = new Date(+this.deadlineTarget.innerText) - Date.now();
    const fillPercentage = (Math.round((timeLeft / totalTime) * 100)) -80;
    let fillColor;
    if (fillPercentage <= 20) {
      fillColor = "rgb(255, 133, 4)";
    } else {
      fillColor = "#4ECDC4";
    }
    this.element.style = `background: linear-gradient(white, white) content-box no-repeat, conic-gradient(${fillColor} ${fillPercentage}%, 0, #A6ACBA ) border-box;`;
  }
}
