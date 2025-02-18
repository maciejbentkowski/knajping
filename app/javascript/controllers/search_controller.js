import { Controller } from "@hotwired/stimulus";
import debounce from "debounce";

// Connects to data-controller="search"
export default class extends Controller {
  initialize() {
    this.submit = debounce(this.submit, 400);
  }
  submit(_event) {
    this.element.requestSubmit();
  }
}
