module AresMUSH
  module Mediawiki

    # Note!  Assumes you've already checked for all the log info fields being set.
    def self.create_log(scene, client, show_source_if_unsuccessul)
      Global.logger.debug "mediawiki is creating a log"
      template =  LogTemplate.new(scene)
      content = template.render
      tags = Mediawiki.log_tags(scene)

      title = Mediawiki.log_page_title(scene)
      page_name = Mediawiki.log_page_name(scene)

      Global.dispatcher.spawn("Creating mediawiki log page", client) do
        page_exists = Mediawiki.page_exists?(page_name)

        if (Mediawiki.autopost_enabled? && !page_exists)
          error = Mediawiki.create_page(page_name, title, content, tags)
          if (error)
            client.emit_failure error
          else
            client.emit_success t('mediawiki.page_creation_successful')
          end
        elsif (show_source_if_unsuccessul)
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
        else
          client.emit_failure t('mediawiki.autocreate_unsuccessful')
        end
      end

    end

    def self.page_exists?(page)
      begin
        wiki = MediawikiApi::Client.new Mediawiki.site
        wiki.log_in Mediawiki.username, Mediawiki.password
        res = wiki.query titles: page, formatversion: 2

        return !Mediawiki.missing?(res)
      rescue Exception => ex
        Global.logger.debug ex
        return false
      end
    end

    def self.create_page(page, title, content, tags = [])
      return t('mediawiki.autopost_disabled') if !Mediawiki.autopost_enabled?

      Global.logger.debug "Creating wiki page #{page}"

      begin
        wiki = MediawikiApi::Client.new Mediawiki.site
        wiki.log_in Mediawiki.username, Mediawiki.password

        res = wiki.create_page title, content
        return res.data["result"] == "Success" ? nil : t('mediawiki.page_creation_failed')
      rescue Exception => ex
        Global.logger.debug ex
        return t('mediawiki.page_creation_failed', :error => ex)
      end
    end

    def self.autopost_enabled?
      return false if Mediawiki.site.blank?
      return false if Mediawiki.username.blank?
      return false if Mediawiki.password.blank?
      return false if !AresMUSH::Global.read_config('mediawiki', 'autopost_enabled' )
      true
    end
  end
end
