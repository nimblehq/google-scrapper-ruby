# frozen_string_literal: true

require 'pagy/extras/bootstrap'
require 'pagy/extras/overflow'

# Override default options
Pagy::DEFAULT[:items] = 5
Pagy::DEFAULT[:size] = [1, 2, 2, 1]

Pagy::DEFAULT[:overflow] = :last_page
