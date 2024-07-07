let map;
let markers = [];
let infoWindows = [];

function initMap() {
  const mapElement = document.getElementById('map');
  if (!mapElement) return; // マップ要素が存在しない場合は初期化しない
  const mapOptions = {
    center: { lat: 35.6803997, lng: 139.7690174 },
    zoom: 10
  };
  map = new google.maps.Map(mapElement, mapOptions);
  updateMarkersFromData();
}

function updateMarkersFromData() {
  const mapContainer = document.getElementById('map-container');
  const markerData = JSON.parse(mapContainer.dataset.shops);
  console.log(markerData);
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

    const infoWindow = new google.maps.InfoWindow({
      content: markerData[i]['name']
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