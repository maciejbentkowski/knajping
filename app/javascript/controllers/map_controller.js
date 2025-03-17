// app/javascript/controllers/map_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    latitude: Number,
    longitude: Number,
    name: String,
    markers: Array,
  };

  connect() {
    if (
      (this.hasLatitudeValue && this.hasLongitudeValue) ||
      (this.hasMarkersValue && this.markersValue.length > 0)
    ) {
      this.initializeMap();
    }
  }

  initializeMap() {
    let centerLat, centerLng;

    if (this.hasMarkersValue && this.markersValue.length > 0) {
      centerLat = this.markersValue[0].latitude;
      centerLng = this.markersValue[0].longitude;
    } else {
      centerLat = this.latitudeValue;
      centerLng = this.longitudeValue;
    }

    const map = L.map(this.element).setView([centerLat, centerLng], 13);

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution:
        '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    }).addTo(map);

    if (this.hasMarkersValue && this.markersValue.length > 0) {
      this.markersValue.forEach((marker) => {
        L.marker([marker.latitude, marker.longitude])
          .addTo(map)
          .bindPopup(marker.name);
      });

      if (this.markersValue.length > 1) {
        const bounds = new L.LatLngBounds();
        this.markersValue.forEach((marker) => {
          bounds.extend([marker.latitude, marker.longitude]);
        });
        map.fitBounds(bounds);
      }
    } else {
      L.marker([this.latitudeValue, this.longitudeValue])
        .addTo(map)
        .bindPopup(this.nameValue)
        .openPopup();
    }
  }
}
