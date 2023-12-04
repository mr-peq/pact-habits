import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {

  // static targets = ["deadline", "days", "hours", "minutes", "seconds"];
  // impossible with Stimulus, cuz it sucks ass

  connect() {
    this.#updateTimer();
    setInterval(this.#updateTimer, 1000);
  }

  #updateTimer() {
    const deadlineElement = document.getElementById('deadline');
    let deadline;
    if (deadlineElement) {
      deadline = +(deadlineElement.innerText);
    } else return;
    const day = 86400000;
    const hour = 3600000;
    const minute = 60000;
    const second = 1000;

    const timeRemaining = new Date(deadline) - Date.now();
    if (Math.floor(timeRemaining / day) < 10) {
      document.getElementById('days').parentElement.classList.add('fewer-days');
    }
    document.getElementById('days').innerText = Math.floor(timeRemaining / day);

    if (Math.floor((timeRemaining % day) / hour) < 10) {
      document.getElementById('hours').innerText = '0' + Math.floor((timeRemaining % day) / hour);
    } else {
      document.getElementById('hours').innerText = Math.floor((timeRemaining % day) / hour);
    }
    if (Math.floor((timeRemaining % hour) / minute) < 10) {
      document.getElementById('minutes').innerText = '0' + Math.floor((timeRemaining % hour) / minute);
    } else {
      document.getElementById('minutes').innerText = Math.floor((timeRemaining % hour) / minute);
    }
    if (Math.floor((timeRemaining % minute) / second) < 10) {
      document.getElementById('seconds').innerText = '0' + Math.floor((timeRemaining % minute) / second);
    } else {
      document.getElementById('seconds').innerText = Math.floor((timeRemaining % minute) / second);
    }
  }
}
