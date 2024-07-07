function initMap() {
  const mapElement = document.getElementById('map');

  const shop = gon.shop;
  const lat = Number(shop.latitude);
  const lng = Number(shop.longitude);

  const mapOptions = {
    center: { lat: lat , lng: lng  },
    zoom: 14
  };

  const map = new google.maps.Map(mapElement, mapOptions);

  // マーカーを追加
  const marker = new google.maps.Marker({
    position: {lat: lat , lng: lng },
    map: map,
    title: shop.name,
    clickable: false
  });
}

window.initMap = initMap;