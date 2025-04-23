import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="primary-photo-preview"
export default class extends Controller {
  static targets = ["input", "preview"];
  connect() {
    console.log("Hello, world", this.targets);
    console.log("Input target on connect:", this.inputTarget);
    console.log("Preview target on connect:", this.previewTarget);
  }

  preview() {
    let input = this.inputTarget;
    let preview = this.previewTarget;
    let file = input.files[0];
    let reader = new FileReader();

    reader.onloadend = function () {
      preview.src = reader.result;
    };

    if (file) {
      reader.readAsDataURL(file);
    } else {
      preview.src = "";
    }
  }
}
