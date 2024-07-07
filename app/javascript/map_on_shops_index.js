let map;
let markers = [];
let infoWindows = [];

function initMap() {
  const mapElement = document.getElementById('map');
  const mapContainer = document.getElementById('map-container');
  const centerLat = mapContainer ? Number(mapContainer.dataset.lat) : null;
  const centerLng = mapContainer ? Number(mapContainer.dataset.lng) : null;
  const zoom = mapContainer ? Number(mapContainer.dataset.zoom) : null;
  if (!mapElement) return;
  const mapOptions = {
    center: { lat: centerLat, lng: centerLng },
    zoom: zoom
  };
  map = new google.maps.Map(mapElement, mapOptions);
  updateMarkersFromData();
}

function updateMarkersFromData() {
  const mapContainer = document.getElementById('map-container');
  const markerData = mapContainer ? JSON.parse(mapContainer.dataset.shops) : null;
  updateMarkers(markerData);
}

function updateMarkers(markerData) {
  if (markers) {
    markers.forEach(marker => marker.setMap(null));
  }

  markers = [];
  infoWindows = [];

  for (let i = 0; i < markerData.length; i++) {
    const markerLatLng = new google.maps.LatLng({
      lat: Number(markerData[i]['latitude']),
      lng: Number(markerData[i]['longitude'])
    });

    const marker = new google.maps.Marker({
      position: markerLatLng,
      map: map,
      title: markerData[i]['name']
    });

    const url = location.protocol + '//' + location.host + '/shops/' + markerData[i]['id']

    const contentBody =
      '<div class="shop-name">'
      + markerData[i]['name']
      + '</div>'
      + '<div class="link">'
      + '<a href="'
      + url
      + '" data-turbo="false" class="link">'
      + '詳細を見る'
      + '</a>'
      + '</div>'

    const infoWindow = new google.maps.InfoWindow({
      content: contentBody
    });

    marker.addListener('click', function () {
      infoWindow.open(map, marker);
    });

    markers.push(marker);
    infoWindows.push(infoWindow);
  }
}

document.addEventListener('DOMContentLoaded', () => {
  if (typeof google !== 'undefined') {
    initMap();
  }
})

document.addEventListener('turbo:frame-load', () => {
  if (typeof google !== 'undefined') {
    updateMarkersFromData();
    initMap();
  }
})

window.initMap = initMap;