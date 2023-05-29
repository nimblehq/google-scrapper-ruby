# frozen_string_literal: true

require 'pagy/extras/bootstrap'

# Override default options
Pagy::DEFAULT[:items] = 5
Pagy::DEFAULT[:size] = [1, 2, 2, 1]

require 'pagy/extras/overflow'
Pagy::DEFAULT[:overflow] = :last_page
