$:.unshift File.dirname(__FILE__)
load "public/char_model.rb"
load "lib/helpers/utils.rb"

module AresMUSH
  module TF
    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.shortcuts
      Global.read_config("tf", "shortcuts")
    end

    def self.load_plugin
      self
    end

    def self.unload_plugin
    end

    def self.config_files
      [
        "config_tf.yml",
        "config_tf_chargen.yml",
        "config_tf_quirks.yml",
        "config_tf_skills.yml",
        "config_tf_specs.yml",
        "config_tf_modes.yml"
      ]
    end

    def self.locale_files
      [ "locales/locale_en.yml" ]
    end

    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      # when "backup"
      #   return CharBackupCmd
      # when "reset"
      #   return ResetCmd
      when "roll"
        if (cmd.args =~ / vs /)
          return OpposedRollCmd
        else
          return RollCmd
        end
      when "sheet"
        return SheetCmd
      when "xp"
        case cmd.switch
        when "award"
          return XpAwardCmd
        when "undo"
          return XpUndoCmd
        else
          return XpCmd
        end
      end

      nil
    end

    def self.get_event_handler(event_name)
      # case event_name
      # when "CronEvent"
      #   return XpCronHandler
      # end
      # nil
    end
  end
end
