// app/javascript/controllers/stepper_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["value"]

  increment() {
    let currentValue = Number(this.valueTarget.value);
    this.valueTarget.value = currentValue + 5;
  }

  decrement() {
    let currentValue = Number(this.valueTarget.value);
    if (currentValue > 6) {
      this.valueTarget.value = currentValue - 5;
    }
  }
}
