import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ["range", "valueDisplay"];

  connect() {
    this.updateValue();
  }

  updateValue() {
    const value = this.rangeTarget.value;
    this.valueDisplayTarget.textContent = value + " €";
  }
}
