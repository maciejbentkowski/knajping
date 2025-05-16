import { Controller } from "@hotwired/stimulus";
import debounce from "debounce";

// Connects to data-controller="search"
export default class extends Controller {
  initialize() {
    this.performSubmit = debounce(this.performSubmit, 400);
  }
  performSubmit(_event) {
    this.element.requestSubmit();
  }

  visit(event) {
    event.preventDefault();
    const url = event.currentTarget.href;
    Turbo.visit(url, { frame: "search-results", action: "advance" });
  }
}
