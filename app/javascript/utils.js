$(document).on("turbo:before-cache", function() {
  $('.js-multiple-select').each(function () {
    $(this).select2('destroy');
  })
})

$(document).on("turbo:load", function () {
  $('.js-multiple-select').each(function () {
    const $this = $(this)

    let opts = {
      theme: 'bootstrap',
      width: $this.data("width") ? $this.data("width") : $this.hasClass("w-100") ? "100%" : "style",
      allowClear: Boolean($this.data("allow-clear")),
    }

    $this.select2(opts)
  })
});
