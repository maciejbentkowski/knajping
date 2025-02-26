import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["starContainer", "ratingValue"];
  static values = {
    rating: Number,
    maxStars: { type: Number, default: 6 },
  };

  connect() {
    this.renderStars();
  }

  renderStars() {
    const rating = this.ratingValue;
    const maxStars = this.maxStarsValue;

    this.starContainerTarget.innerHTML = "";

    const fullStars = Math.floor(rating);
    const halfStar = rating - fullStars >= 0.5 ? 1 : 0;
    const emptyStars = maxStars - fullStars - halfStar;

    for (let i = 0; i < fullStars; i++) {
      this.addStar("fas fa-star");
    }

    if (halfStar) {
      this.addStar("fas fa-star-half-alt");
    }

    for (let i = 0; i < emptyStars; i++) {
      this.addStar("far fa-star");
    }

    this.ratingValueTarget.textContent = rating.toFixed(1);
  }

  addStar(className) {
    const star = document.createElement("i");
    star.className = className;
    this.starContainerTarget.appendChild(star);
  }
}
