class Entry < ApplicationRecord
  has_many :cvsses
  has_many :references
  has_many :vulnerable_software_lists
  belongs_to :assessment_check
  has_many :scanners
end
