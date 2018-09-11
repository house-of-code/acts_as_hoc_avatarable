module ActsAsHocAvatarable
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def copy_initializer_file
        template "initializer.rb", "config/initializers/acts_as_hoc_avatarable.rb"
      end

      # def install_active_storage
      #   rake 'active_storage::install'
      # end
    end
  end
end
