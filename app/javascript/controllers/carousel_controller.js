// app/javascript/controllers/carousel_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "slide", "dot"];

  connect() {
    this.currentIndex = 0;
    this.sliding = false;
    this.updateDots();

    // Opcjonalnie: automatyczne przewijanie
    this.startAutoplay();

    // Obsługa klawiatury
    this.handleKeyboard = this.handleKeyboard.bind(this);
    document.addEventListener("keydown", this.handleKeyboard);
  }

  disconnect() {
    this.stopAutoplay();
    document.removeEventListener("keydown", this.handleKeyboard);
  }

  next() {
    if (this.sliding) return;
    this.slideTo((this.currentIndex + 1) % this.slideTargets.length);
  }

  previous() {
    if (this.sliding) return;
    this.slideTo(
      this.currentIndex === 0
        ? this.slideTargets.length - 1
        : this.currentIndex - 1
    );
  }

  goToSlide(event) {
    const slideIndex = parseInt(event.currentTarget.dataset.slide);
    this.slideTo(slideIndex);
  }

  slideTo(index) {
    if (this.sliding || index === this.currentIndex) return;

    this.sliding = true;
    this.currentIndex = index;

    const offset = -(index * 100);
    this.containerTarget.style.transform = `translateX(${offset}%)`;

    this.updateDots();

    // Reset sliding lock after transition
    setTimeout(() => {
      this.sliding = false;
    }, 300); // Matches duration-300 in CSS
  }

  updateDots() {
    this.dotTargets.forEach((dot, index) => {
      if (index === this.currentIndex) {
        dot.classList.remove("bg-white/50");
        dot.classList.add("bg-white");
      } else {
        dot.classList.add("bg-white/50");
        dot.classList.remove("bg-white");
      }
    });
  }

  handleKeyboard(event) {
    if (event.key === "ArrowLeft") {
      this.previous();
    } else if (event.key === "ArrowRight") {
      this.next();
    }
  }

  // Autoplay functions
  startAutoplay() {
    this.autoplayInterval = setInterval(() => {
      this.next();
    }, 5000); // Change slide every 5 seconds
  }

  stopAutoplay() {
    if (this.autoplayInterval) {
      clearInterval(this.autoplayInterval);
    }
  }

  // Optional: Pause autoplay on hover
  mouseEnter() {
    this.stopAutoplay();
  }

  mouseLeave() {
    this.startAutoplay();
  }
}
