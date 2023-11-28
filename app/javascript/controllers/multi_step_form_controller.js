// multi_step_form_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step"]

  initialize() {
    this.showCurrentStep()
  }

  // Show only the current step based on the dataset attribute 'step'
  showCurrentStep() {
    this.stepTargets.forEach((element, index) => {
      element.classList.toggle("d-none", index != this.currentStep)
    })
  }

  // Go to the next step
  next() {
    if (this.currentStep < this.stepTargets.length - 1) {
      this.currentStep++
      this.showCurrentStep()
    }
  }

  // Go to the previous step
  previous() {
    if (this.currentStep > 0) {
      this.currentStep--
      this.showCurrentStep()
    }
  }

  get currentStep() {
    return parseInt(this.data.get("step")) || 0
  }

  set currentStep(value) {
    this.data.set("step", value)
    this.showCurrentStep()
  }
}

