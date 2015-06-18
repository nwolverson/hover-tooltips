// From @basarat
// https://github.com/TypeStrong/atom-typescript/lib/main/views/tooltip-view.coffee
// https://discuss.atom.io/t/anyone-got-some-tooltips/12127/5


{$, View} = require 'atom'

class TooltipView extends View
  @content: ->
    @div class: 'hover-tooltip'

  initialize: (@rect, text = null) ->
    @html(text) if text?
    $(document.body).append this
    @updatePosition()

  # update tooltip text
  updateText: (text) ->
    @html(text)
    @updatePosition()

  # smart position update
  updatePosition: ->
    coords = [@rect.right, @rect.bottom, undefined]
    offset = 10

    # x axis adjust
    if coords[0] + this[0].offsetWidth >= $(document.body).width()
      coords[0] = $(document.body).width() - this[0].offsetWidth - offset
    if coords[0] < 0
      this.css({ 'white-space': 'pre-wrap' })
      coords[0] = offset
      coords[2] = offset

    # y axis adjust
    if coords[1] + this[0].offsetHeight >= $(document.body).height()
      coords[1] = @rect.top - this[0].offsetHeight

    this.css({ left: coords[0], top: coords[1], right: coords[2] })

module.exports = {
  TooltipView
}
