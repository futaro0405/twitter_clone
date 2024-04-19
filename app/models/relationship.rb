# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :follow, class_name: 'User'
  belongs_to :followed, class_name: 'User'
end
