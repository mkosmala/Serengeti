$ = require 'jqueryify'

module.exports = (el, direction = 'right', range = 25, step = 5) ->
  return unless 'elementFromPoint' of document

  el = $(el)
  {left, top} = el.offset()
  width = el.width()
  height = el.height()

  position = switch direction
    when 'up' then [left + (width / 2), top]
    when 'right' then [left + width, top + (height / 2)]
    when 'down' then [left + (width / 2), top + height]
    when 'left' then [left, top + (height / 2)]

  siblings = el.siblings()

  while range > 0
    range -= step
    switch direction
      when 'up' then position[1] -= step
      when 'right' then position[0] += step
      when 'down' then position[1] += step
      when 'left' then position[0] -= step

    scrollPosition = [position[0] - window.scrollX, position[1] - window.scrollY]

    target = document.elementFromPoint scrollPosition...
    return target if siblings.is target

    has = siblings.has target
    return has.get 0 if has.length isnt 0
