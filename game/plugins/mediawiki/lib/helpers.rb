module AresMUSH
  module Mediawiki
    def self.site_name
      AresMUSH::Global.read_config('mediawiki', 'site_name' )
    end

    def self.site
      AresMUSH::Global.read_config('secrets', 'mediawiki', 'site')
    end

    def self.username
      AresMUSH::Global.read_config('secrets', 'mediawiki', 'username')
    end

    def self.password
      AresMUSH::Global.read_config('secrets', 'mediawiki', 'password')
    end

    def self.missing?(response)
      response.data.dig "pages", 0, "missing"
    end

    def self.character_category
      AresMUSH::Global.read_config('wikidot', 'character_category' )
    end

    def self.character_page_name(char_name)
      category = Mediawiki.character_category ? "#{Mediawiki.character_category}:" : ""
      "#{category}#{char_name}"
    end

    def self.log_page_title(scene)
      "#{scene.date_title}"
    end

    def self.log_page_category(scene)
      categories = AresMUSH::Global.read_config('mediawiki', 'log_categories' )
      categories[scene.scene_type] || "log"
    end

    def self.log_page_name(scene)
      title = Mediawiki.log_page_title(scene)
      category = Mediawiki.log_page_category(scene)
      "#{category}:#{title}"
    end

    def self.character_tags(char)
      [ char.name, "character" ]
    end

    def self.log_tags(scene)
      tags = scene.participant_names
      tags << "log"
      tags << scene.scene_type
      tags
    end
  end
end
