class Recipe < ActiveRecord::Base

  def display_time
    return nil unless self.elapsed_time || self.prep_time
    [self.elapsed_time,self.prep_time].reject(&:blank?).map(&:to_s).join('+')
  end
end
