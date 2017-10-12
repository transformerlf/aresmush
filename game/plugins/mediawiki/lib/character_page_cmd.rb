module AresMUSH
  module Mediawiki
    class CharacterPageCmd
      include CommandHandler

      attr_accessor :target

      def parse_args
        self.target = !cmd.args ? enactor_name : trim_arg(cmd.args)
      end

      def handle

        ClassTargetFinder.with_a_character(self.target, client, enactor) do |model|

          if (!model.is_approved?)
            client.emit_failure t('mediawiki.only_approved_chars')
            return
          end

          template = CharTemplate.new(model)
          content = template.render
          tags = Mediawiki.character_tags(model)
          page_name = Mediawiki.character_page_name(model.name)

          icon_format = Global.read_config("mediawiki", "icon_url")
          if (!icon_format.blank?)
            icon_name = icon_format % { :name => model.name, :site => Mediawiki.site_name }
            model.update(icon: icon_name)
          end

          client.emit_ooc t('mediawiki.creating_page')

          Global.dispatcher.spawn("Creating wiki character page", client) do

            page_exists = Mediawiki.page_exists?(page_name)

            if (Mediawiki.autopost_enabled? && !page_exists)
              error = Mediawiki.create_page(page_name, model.name, content, tags)
              if (error)
                client.emit_failure error
              else
                client.emit_success t('mediawiki.page_creation_successful')
              end
            else
              message = ""
              if (page_exists)
                message << t('mediawiki.page_already_exists')
                message << "%r%% "
              end
              message << t('mediawiki.template_provided')
              message << "%r%% "
              message << t('mediawiki.page_tags', :tags => tags.join(" "))

              client.emit content
              client.emit_ooc message
            end
          end
        end
      end
    end
  end
end
