function geoFindMe() {
  const status = document.querySelector("#status");
  const lat_field = document.querySelector("#q_latitude");
  const lng_filed = document.querySelector("#q_longitude");

  function success(position) {
    let raw_latitude = position.coords.latitude;
    raw_latitude = raw_latitude * 1000000;
    raw_latitude = Math.round(raw_latitude);
    let raw_longitude = position.coords.longitude;
    raw_longitude = raw_longitude * 1000000;
    raw_longitude = Math.round(raw_longitude);
    const latitude = raw_latitude / 1000000;
    const longitude = raw_longitude / 1000000;

    lat_field.value = latitude;
    lng_filed.value = longitude;

    search_button.textContent = "現在地から探す";
    search_button.classList.remove("btn-disabled");
    document.getElementById("current-location-form").submit();
  }

  function error() {
    status.textContent = "Unable to retrieve your location";
  }

  if (!navigator.geolocation) {
    status.textContent = "このブラウザーは位置情報に対応していません";
  } else {
    search_button.textContent = "位置情報を取得中…";
    search_button.classList.add("btn-disabled");
    navigator.geolocation.getCurrentPosition(success, error);
  }
}

const search_button = document.querySelector("#search-with-current-location");

search_button.addEventListener("click", geoFindMe);