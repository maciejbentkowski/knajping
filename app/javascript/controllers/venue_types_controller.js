// app/javascript/controllers/venue_types_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select"];

  connect() {
    this.updateSelections();
  }

  updateSelections() {
    const selectedValues = this.selectTargets.map((select) => select.value);

    const mainCount = {
      main1: 0,
      main2: 0,
      main3: 0,
    };

    selectedValues.forEach((value) => {
      if (mainCount.hasOwnProperty(value)) {
        mainCount[value]++;
      }
    });

    this.selectTargets.forEach((select) => {
      Array.from(select.options).forEach((option) => {
        if (
          option.value === select.value ||
          option.value === "" ||
          option.value === "side"
        ) {
          return;
        }

        if (
          ["main1", "main2", "main3"].includes(option.value) &&
          mainCount[option.value] > 0
        ) {
          option.disabled = true;
        } else {
          option.disabled = false;
        }
      });
    });
  }
}
