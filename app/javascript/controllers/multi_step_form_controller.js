// multi_step_form_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step", "previousButton", "nextButton", "form", "category", "distance", "duration", "deadline", "bet", "beneficiary", "categoryConfirmation", "distanceOrDurationConfirmation", "deadlineConfirmation", "betConfirmation", "beneficiaryConfirmation"]

  initialize() {
    this.showCurrentStep()
    console.log(this.categoryTargets);
  }

  showCurrentStep() {
    this.stepTargets.forEach((element, index) => {
      if (index === this.currentStep) {
        element.classList.remove("d-none"); // Show current step
      } else {
        element.classList.add("d-none"); // Hide other steps
      }

      console.log(this.currentStep)
    });

    // Only show the Next button on the first step
    this.previousButtonTarget.classList.add("d-none", this.currentStep === 0);

    // Only show the Previous button on the last step
    if (this.currentStep === this.stepTargets.length - 1) {
      this.previousButtonTarget.classList.remove("d-none");
      this.nextButtonTarget.classList.add("d-none");
    }

    // Show both buttons on intermediate steps
    if (this.currentStep > 0 && this.currentStep < this.stepTargets.length - 1) {
      this.nextButtonTarget.classList.remove("d-none");
      this.previousButtonTarget.classList.remove("d-none");
    }
  }

  // Capture data and display in the confirmation step
  captureData() {
    const category = this.selectedRadioButtonValue(this.categoryTargets);
    const distanceOrDuration = this.distanceTarget.value
    const deadline = this.deadlineTarget.value;
    const bet = this.betTarget.value;
    const beneficiary = this.selectedRadioButtonValue(this.beneficiaryTargets);

    // Debugging: Log captured data
    console.log("Captured Data:", { category, distanceOrDuration, deadline, bet, beneficiary });
    console.log("Captured Category: ", category);
    console.log("Captured Beneficiary: ", beneficiary);

    // Display the captured data in the confirmation step
    this.categoryConfirmationTarget.textContent = category;
    this.distanceOrDurationConfirmationTarget.textContent = distanceOrDuration;
    this.deadlineConfirmationTarget.textContent = deadline;
    this.betConfirmationTarget.textContent = bet;
    this.beneficiaryConfirmationTarget.textContent = beneficiary;
  }

  selectedRadioButtonValue(radioButtons) {
    // Convert NodeList to Array to use Array methods like find
    const selected = Array.from(radioButtons).find(radio => radio.checked);
    return selected ? selected.value : null;
  }

  next() {
    if (this.currentStep < this.stepTargets.length - 1) {
      this.captureData(); // Capture data at each step
      this.currentStep++;
      this.showCurrentStep();
    }

    if (this.currentStep === 1) { // Assuming step 2 is index 1
      this.openFlatpickrOnStep2();
    }
  }

  openFlatpickrOnStep2() {
    const datetimePickerController = this.application.getControllerForElementAndIdentifier(
      this.formTarget,
      "datetime-picker"
    );
    datetimePickerController.openFlatpickr();
  }

  isBeforeConfirmationStep() {
    return this.currentStep === this.stepTargets.length - 2;
  }

  isConfirmationStep() {
    return this.currentStep === this.stepTargets.length - 1;
  }

  previous() {
    if (this.currentStep >= 1) {
      this.currentStep--
      this.showCurrentStep()
    }
  }

  submit() {
    this.formTarget.submit();
  }

  get currentStep() {
    return parseInt(this.data.get("step")) || 0;
  }

  set currentStep(value) {
    this.data.set("step", value)
    this.showCurrentStep();
  }
}
