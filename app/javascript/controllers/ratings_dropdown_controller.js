import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["ratings", "arrow"];

  connect() {
    document.addEventListener("click", this.handleClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside.bind(this));
  }

  toggle(event) {
    event.stopPropagation();
    this.arrowTarget.classList.toggle("rotate-180");

    if (this.ratingsTarget.classList.contains("hidden")) {
      this.ratingsTarget.classList.remove("hidden");
      setTimeout(() => {
        this.ratingsTarget.classList.remove("opacity-0", "-translate-y-2");
      }, 10);
    } else {
      this.ratingsTarget.classList.add("opacity-0", "-translate-y-2");
      setTimeout(() => {
        this.ratingsTarget.classList.add("hidden");
      }, 300);
    }
  }

  handleClickOutside(event) {
    if (
      !this.element.contains(event.target) &&
      !this.ratingsTarget.classList.contains("hidden")
    ) {
      this.arrowTarget.classList.remove("rotate-180");
      this.ratingsTarget.classList.add("opacity-0", "-translate-y-2");
      setTimeout(() => {
        this.ratingsTarget.classList.add("hidden");
      }, 300);
    }
  }
}
