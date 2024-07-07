let map;
let markers = [];
let infoWindows = [];
const markerData = gon.all_shops;

function initMap() {
  const mapElement = document.getElementById('map');
  const mapOptions = {
    center: { lat: 35.6803997, lng: 139.7690174 },
    zoom: 10
  };
  map = new google.maps.Map(mapElement, mapOptions);

  for (let i = 0; i < markerData.length; i++) {
    let id = markerData[i]['id']

    const markerLatLng = new google.maps.LatLng({
      lat: Number(markerData[i]['latitude']),
      lng: Number(markerData[i]['longitude'])
    });

    markers[i] = new google.maps.Marker({
      position: markerLatLng,
      map: map,
      title: markerData[i]['name']
    });

    infoWindows[i] = new google.maps.InfoWindow({
      content: markerData[i]['name']
    });

    markers[i].addListener('click', function () {
      infoWindows[i].open(map, markers[i]);
    });
  }
}

window.initMap = initMap;