import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  connect() {
    // Zamykanie dropdown przy kliknięciu poza menu
    document.addEventListener("click", this.handleClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside.bind(this));
  }

  toggle(event) {
    event.stopPropagation();
    this.menuTarget.classList.toggle("hidden");
  }

  handleClickOutside(event) {
    if (
      !this.element.contains(event.target) &&
      !this.menuTarget.classList.contains("hidden")
    ) {
      this.menuTarget.classList.add("hidden");
    }
  }
}
