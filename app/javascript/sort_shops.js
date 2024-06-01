document.addEventListener('turbo:load', function() {
  const sortOptions = document.querySelector('#sort-options');
  const hiddenField = document.querySelector('#sort_key');
  if (sortOptions) {
    sortOptions.addEventListener('change', function() {
      hiddenField.value = sortOptions.value
      this.form.requestSubmit();
    })
  }
})