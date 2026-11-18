import { Controller } from "@hotwired/stimulus"
// Don't forget to import GMaps!
import GMaps from 'gmaps';

// Connects to data-controller="google-maps"
export default class extends Controller {
  static values = { markers: Array }

  connect() {
    const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    const markers = this.markersValue;
    map.addMarkers(markers);
    if (markers.length === 0) {
      map.setZoom(2);
    } else if (markers.length === 1) {
      const { lat, lng } = markers[0];
      const delta = 0.45;
      map.fitLatLngBounds([
        { lat: lat + delta, lng: lng + delta },
        { lat: lat - delta, lng: lng - delta }
      ]);
    } else {
      map.fitLatLngBounds(markers);
    }
  }
}
