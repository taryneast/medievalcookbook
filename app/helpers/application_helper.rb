module ApplicationHelper
  # puts an AJAXy "X" delete button
  # Will just remove the named div-class if the given model is a new-record,
  # or will go and call the appropriate delete-link on the model if it's a
  # real, saved one.
  def ajax_x_button(model,div_class)
    if model.new_record?
      # if we're a new instance - just close the surrounding div
      link_to 'X', '#', :onclick => "$(this).closest('.#{div_class}').fadeOut(function() {$(this).remove()});return false;"
    else
      # if we're a saved instance of the model - make it go through the
      # delete-action first
      link_to 'X', model, method: :delete, remote: true, confirm: "This will permanently destroy this item. Are you sure?"
    end
  end

end
