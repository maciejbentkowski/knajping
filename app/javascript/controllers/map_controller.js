// app/javascript/controllers/map_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    latitude: Number,
    longitude: Number,
    name: String,
  };

  connect() {
    if (this.hasLatitudeValue && this.hasLongitudeValue) {
      this.initializeMap();
    }
  }

  initializeMap() {
    const map = L.map(this.element).setView(
      [this.latitudeValue, this.longitudeValue],
      13
    );

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution:
        '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    }).addTo(map);

    L.marker([this.latitudeValue, this.longitudeValue])
      .addTo(map)
      .bindPopup(this.nameValue)
      .openPopup();
  }
}
