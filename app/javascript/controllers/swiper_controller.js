import { Controller } from "@hotwired/stimulus"
import Swiper from 'swiper'


// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    this.swiper = new Swiper('.swiper-container', {
      spaceBetween: 20,
      loop: true, // For infinite loop
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
    });
  }
}
