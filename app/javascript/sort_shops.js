document.addEventListener('turbo:load', function() {
  const sortOptions = document.querySelector('#sort-options');
  if (sortOptions) {
    sortOptions.addEventListener('change', function() {
      this.form.requestSubmit();
    })
  }
})