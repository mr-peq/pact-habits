import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="category-select"
export default class extends Controller {
  connect() {
  }

  selectCategory(event) {
    const categoryItems = this.element.querySelectorAll('.category-item');

    // Remove 'selected' class from all categories and add 'grayscale'
    categoryItems.forEach(item => {
      item.classList.remove('selected');
      item.classList.add('grayscale');
    });

    // Add 'selected' class to the clicked category and remove 'grayscale'
    const selectedCategory = event.currentTarget;
    selectedCategory.classList.remove('grayscale');
    selectedCategory.classList.add('selected');
  }

  selectBeneficiary(event) {
    const beneficiaryItems = this.element.querySelectorAll('.beneficiary-item');

    // Remove 'selected' class from all categories and add 'grayscale'
    beneficiaryItems.forEach(item => {
      item.classList.remove('selected');
      item.classList.add('grayscale');
    });

    // Add 'selected' class to the clicked category and remove 'grayscale'
    const selectedBeneficiary = event.currentTarget;
    selectedBeneficiary.classList.remove('grayscale');
    selectedBeneficiary.classList.add('selected');
  }
}
