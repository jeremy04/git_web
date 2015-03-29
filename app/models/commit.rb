class Commit < ActiveRecord::Base
  belongs_to :bug
  belongs_to :author
end
