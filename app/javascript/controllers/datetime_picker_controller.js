import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = ["datetime", "anytime", "recurring", "weekdays", "day"]

  connect() {
    this.initializeFlatpickr();
    const flatpickrHours = document.querySelector('.flatpickr-hour');

    flatpickrHours.addEventListener('focus', () => {
      console.log("HOURS focused");
      flatpickrHours.blur();
    });
  }

  initializeFlatpickr() {
    // Initialize Flatpickr and store the instance
    this.flatpickrInstance = flatpickr(this.datetimeTarget, {
      disableMobile: "true",
      enableTime: true,
      dateFormat: "Y-m-d H:i",
      time_24hr: true,
      inline: true,
    });
  }

  openFlatpickr() {
      // Position the calendar at the center of the container on the top
      this.flatpickrInstance.open();
  }

  toggleRecurring() {
    // Show or hide the weekdays based on the 'Recurring' checkbox
    this.weekdaysTarget.classList.toggle("d-none", !this.recurringTarget.checked);
  }

  toggleDay(event) {
    // Find the parent label of the clicked checkbox and toggle the 'selected' class on it
    event.target.closest('.weekday-toggle').classList.toggle('selected');
  }
}


  // handleDateTimeChange(selectedDates, dateStr, instance) {
  //   // If 'Anytime' is checked, set the time to 23:59
  //   if (this.anytimeTarget.checked) {
  //     const dateValue = dateStr.split(" ")[0]; // Assumes dateStr is in "Y-m-d H:i" format
  //     this.datetimeTarget.value = `${dateValue} 23:59`;
  //   }
  // }

  // toggleAnytime() {
  //   // If 'Anytime' is checked, adjust the datetime picker value
  //   if (this.anytimeTarget.checked) {
  //     const dateValue = this.datetimeTarget.value.split("T")[0]; // Get only the date part
  //     this.datetimeTarget.value = `${dateValue}T23:59`; // Set the time to 23:59
  //   } else {
  //     // Reset the time if 'Anytime' is unchecked
  //     this.datetimeTarget.value = this.datetimeTarget.value.split("T")[0];
  //   }
  // }
