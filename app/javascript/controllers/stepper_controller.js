// app/javascript/controllers/stepper_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["value"]

  connect() {
    // Ensure the input value is a number
    this.valueTarget.value = parseInt(this.valueTarget.value) || 0;
  }

  increment() {
    // Increment the value
    this.valueTarget.value = parseInt(this.valueTarget.value) + 5;
  }

  decrement() {
    // Decrement the value, but not below 0
    let currentValue = parseInt(this.valueTarget.value);
    if (currentValue > 6) {
      this.valueTarget.value = currentValue - 5;
    }
  }
}
