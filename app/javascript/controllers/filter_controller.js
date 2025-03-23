import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  connect() {
    console.log("Filter controller connected");
  }

  submit() {
    this.formTarget.requestSubmit();
  }
}
