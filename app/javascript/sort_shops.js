const selectBox = document.getElementById('sort-options');
const dataContainer = document.getElementById('data-container');
const searchShopsParams = JSON.parse(dataContainer.getAttribute('data-search-params'));
const queryParams = new URLSearchParams(searchShopsParams).toString();

function putMessage() {
  console.log(searchShopsParams);
}

function sort() {
  window.location.href = `/shops?${queryParams}`;
}

selectBox.onchange = sort;