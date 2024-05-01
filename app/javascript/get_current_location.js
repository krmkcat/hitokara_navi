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

    status.textContent = ""
    document.getElementById("current-location-form").submit();
  }

  function error() {
    status.textContent = "Unable to retrieve your location";
  }

  if (!navigator.geolocation) {
    status.textContent = "このブラウザーは位置情報に対応していません";
  } else {
    status.textContent = "位置情報を取得中…";
    navigator.geolocation.getCurrentPosition(success, error);
  }
}

document.querySelector("#find-me").addEventListener("click", geoFindMe);