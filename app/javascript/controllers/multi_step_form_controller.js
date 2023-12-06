// multi_step_form_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "day", "step", "previousButton", "nextButton", "form", "category", "distance", "deadline", "bet", "beneficiary", "categoryConfirmation", "distanceOrDurationConfirmation", "deadlineConfirmation", "betConfirmation", "beneficiaryConfirmation", "recurring"]

  join(event) {
    const challengeId = event.currentTarget.dataset.challengeId;
    this.formTarget.action = `/pacts/${challengeId}/join`;
  }

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
    this.previousButtonTarget.classList.toggle("hidden", this.currentStep === 0);

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
  // captureData() {
  //   const category = this.selectedRadioButtonValue(this.categoryTargets);
  //   const distanceOrDuration = this.distanceTarget.value
  //   const deadline = this.deadlineTarget.value;
  //   const bet = this.betTarget.value;
  //   const beneficiary = this.selectedRadioButtonValue(this.beneficiaryTargets);

  //   // Debugging: Log captured data
  //   console.log("Captured Data:", { category, distanceOrDuration, deadline, bet, beneficiary });
  //   console.log("Captured Category: ", category);
  //   console.log("Captured Beneficiary: ", beneficiary);

  //   // Display the captured data in the confirmation step
  //   this.categoryConfirmationTarget.textContent = category;
  //   this.distanceOrDurationConfirmationTarget.textContent = distanceOrDuration;
  //   this.deadlineConfirmationTarget.textContent = deadline;
  //   this.betConfirmationTarget.textContent = bet;
  //   this.beneficiaryConfirmationTarget.textContent = beneficiary;
  // }

  captureData() {
    const category = this.selectedRadioButtonValue(this.categoryTargets);
    const distanceOrDuration = this.distanceTarget.value
    const deadline = this.deadlineTarget.value;
    const bet = this.betTarget.value;
    const beneficiaryId = this.selectedRadioButtonValue(this.beneficiaryTargets);
    const beneficiaryNameElement = document.querySelector(`[data-beneficiary-id="${beneficiaryId}"]`);
    const beneficiaryName = beneficiaryNameElement ? beneficiaryNameElement.getAttribute('data-beneficiary-name') : 'Unknown';
    const recurring = this.recurringTarget.checked;
    const selectedWeekdays = this.captureWeekdays(); // This will be an array of selected weekdays
    let weekdaysText = selectedWeekdays.join(", "); // This will create a string like "M, W, F"




    // Access the distance_duration_controller
    const selectedType = document.querySelector('input[name="distance_type"]:checked').value;

    // Generate the confirmation message
    let confirmationHtml = `You committed to <strong class="highlight">${category}</strong> for <strong class="highlight">${distanceOrDuration} ${selectedType === "distance" ? 'Km' : 'min'}</strong>`;
    if (recurring) {
      confirmationHtml += ` every:<ul class="weekday-list">`;
      selectedWeekdays.forEach(day => {
        confirmationHtml += `<li><strong class="highlight">${day}</strong></li>`;
      });
      confirmationHtml += `</ul>`;
      confirmationHtml += `Till <strong class="highlight">${deadline}</strong><br><br>`
    } else {
      confirmationHtml += ` before <strong class="highlight">${deadline}</strong><br><br>`;
    }

    confirmationHtml += ` Or give <strong class="highlight">${bet}€</strong> to <strong class="highlight">${beneficiaryName}</strong>`;
    document.getElementById('confirmation-message').innerHTML = confirmationHtml;

    // let confirmationMessage = `You committed to ${category} for `;
    // if (selectedType === "distance") {
    //   confirmationMessage += `${distanceOrDuration} Km`;
    // } else if (selectedType === "duration") {
    //   confirmationMessage += `${distanceOrDuration} min`;
    // }
    // if (recurring) {
    //   confirmationMessage += ` every ${weekdaysText} till ${deadline}`;
    // } else {
    //   confirmationMessage += ` before ${deadline}`;
    // }
    // confirmationMessage += ` or give ${bet}€ to ${beneficiaryName}.`;

    // // Set the message in the confirmation step
    // document.getElementById('confirmation-message').textContent = confirmationMessage;
  }

  // ...

  captureWeekdays() {
    const WEEKDAYS_MAP = {
      0: 'Monday',
      1: 'Tuesday',
      2: 'Wednesday',
      3: 'Thursday',
      4: 'Friday',
      5: 'Saturday',
      6: 'Sunday'
    };

    return this.dayTargets.filter(checkbox => checkbox.checked).map(checkbox => WEEKDAYS_MAP[checkbox.value]);
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
