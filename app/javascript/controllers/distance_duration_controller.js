// app/javascript/controllers/distance_duration_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.setType();
  }

  setType(event) {
    const selectedType = event ? event.target.value : this.element.querySelector('input[name="distance_type"]:checked').value;
    this.inputTarget.name = `pact[${selectedType}]`;
    if (selectedType === "distance") {
      this.inputTarget.placeholder = 'Enter distance (Km)';
    } else if (selectedType === "duration") {
      this.inputTarget.placeholder = 'Enter duration (Min)';
    }
  }

  getSelectedType() {
    const radio = this.element.querySelector('input[name="distance_type"]:checked');
    return radio ? radio.value : null; // Returns 'distance' or 'duration'
  }
}
