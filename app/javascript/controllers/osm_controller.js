import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    tile: Object,
    airport: Object,
    airports: Array
  }

  static targets = [ 'map' ]

  connect() {
    console.log("Openstreetmap connected!")
    this.displayMap();
  }

  displayMap() {
    // We display the map
    this.map = L.map(this.mapTarget).setView([49.6 ,6.2], 6);

    // We define the tile layer
    L.tileLayer('https://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}', {
      maxZoom: 19,}).addTo(this.map);

    // We add the weather tile
    const geojsonLayer = L.geoJSON(this.tileValue).addTo(this.map);
    this.map.fitBounds(geojsonLayer.getBounds());

    // We display the airport homebase marker
    var myStyle = {
      "color": "#ff7800",
      "weight": 5,
      "opacity": 0.65
    };
    L.geoJSON(this.airportValue, { style: myStyle }).addTo(this.map)

    // We display all airports
    this.airportsValue.forEach((airport) => {
      var circle = L.circle([airport.geojson.coordinates[1], airport.geojson.coordinates[0]], {
      //var circle = L.circle([48.0, 6.0], {
        color: '#FF8600',
        fillColor: '#FF8600',
        fillOpacity: 0.2,
        radius: 1000
      }).addTo(this.map);
    });

  }
  disconnect(){
    this.map.remove()
  }
}
