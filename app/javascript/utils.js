import "select2"
import "select2_locale_ru"
import "select2_locale_en"

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
      language: $('body').data('lang')
    }

    if($this.hasClass('js-ajax-select')) {
      const ajax_opts = {
        ajax: {
          url: $this.data('ajax-url'),
          data: function(params) {
            return {
              term: params.term
            }
          },
          dataType: 'json',
          delay: 500,
          processResults: function (data, params) {
            const arr = $.map(data, function(value, index) {
              return {
                id: value.id,
                text: value.title
              }
            })

            return {results: arr}
          },
          cache: true
        },
        minimumInputLength: 2
      }

      opts = Object.assign(opts, ajax_opts)
    }

    $this.select2(opts)
  })
});
