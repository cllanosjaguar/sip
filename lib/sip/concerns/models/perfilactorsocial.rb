# encoding: UTF-8

module Sip
  module Concerns
    module Models
      module Perfilactorsocial
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo 
          include Sip::Localizacion
          include Sip::Basica

          self.table_name = 'sip_perfilactorsocial'

        end # included

      end
    end
  end
end
