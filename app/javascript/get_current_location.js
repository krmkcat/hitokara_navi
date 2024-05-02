function geoFindMe() {
  const warning = document.querySelector("#warning");
  const latField = document.querySelector("#q_latitude");
  const lngField = document.querySelector("#q_longitude");

  function success(position) {
    const raw_latitude = position.coords.latitude;
    const raw_longitude = position.coords.longitude;
    const latitude = Math.round(raw_latitude * 1000000) / 1000000;
    const longitude = Math.round(raw_longitude * 1000000) / 1000000;

    latField.value = latitude;
    lngField.value = longitude;

    document.getElementById("current-location-form").submit();
  }

  function error() {
    warning.textContent = "位置情報を取得できません";
  }

  if (!navigator.geolocation) {
    warning.textContent = "このブラウザーは位置情報に対応していません";
  } else {
    searchIcon.remove();
    buttonText.before(loadingSpinner);
    buttonText.textContent = "位置情報を取得中…";
    searchButton.classList.add("btn-disabled");
    navigator.geolocation.getCurrentPosition(success, error);
  }
}

const searchButton = document.querySelector("#search-with-current-location");
const searchIcon = document.querySelector("#search-icon");
const loadingSpinner = document.createElement('span');
loadingSpinner.className = "loading loading-spinner";
const buttonText = document.querySelector("#button-text");

searchButton.addEventListener("click", geoFindMe);

window.addEventListener("pageshow", function(event) {
  if (event.persisted) {
      window.location.reload();
  }
});