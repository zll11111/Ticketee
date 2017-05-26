class State < ActiveRecord::Base

  def to_s
    self.name
  end

  def make_default!
    State.update_all(default:false)

    update!(default:true)
  end

  def self.default
    find_by(default:true)
  end
end
