$:.unshift File.dirname(__FILE__)
load "lib/autospace_cmd.rb"
load "lib/colors_cmd.rb"
load "lib/dice_cmd.rb"
load "lib/echo_cmd.rb"
load "lib/edit_prefix_cmd.rb"
load "lib/fansi_cmd.rb"
load "lib/math_cmd.rb"
load "lib/notes_cmd.rb"
load "lib/note_add_cmd.rb"
load "lib/note_delete_cmd.rb"
load "lib/recall_cmd.rb"
load "lib/shortcuts_cmd.rb"
load "lib/shortcut_add_cmd.rb"
load "lib/shortcut_delete_cmd.rb"
load "lib/save_cmd.rb"
load "lib/set_catcher_cmd.rb"
load "lib/sweep_cmd.rb"
load "lib/sweep_kick_cmd.rb"
load "public/utils_model.rb"
load "public/utils_api.rb"

load 'templates/bordered_display_template.rb'
load 'templates/bordered_list_template.rb'
load 'templates/bordered_paged_list_template.rb'
load 'templates/bordered_table_template.rb'
load "templates/line_with_text_template.rb"
load "templates/page_footer.rb"

module AresMUSH
  module Utils
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("utils", "shortcuts")
    end
 
    def self.load_plugin
      self
    end
 
    def self.unload_plugin
    end
 
    def self.config_files
      [ "config_utils.yml" ]
    end
 
    def self.locale_files
      [ "locale/locale_en.yml" ]
    end
 
    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "colors"
        return ColorsCmd
      when "dice"
        return DiceCmd
      when "echo"
        return EchoCmd
      when "edit"
        if (cmd.switch_is?("prefix"))
          return EditPasswordCmd
        end
      when "fansi"
        return FansiCmd
      when "math"
        return MathCmd
      when "notes"
        return NotesCmd
      when "note"
        case cmd.switch
        when "add"
          return NoteAddCmd
        when "delete"
          return NoteDeleteCmd
        end
      when "recall"
        return RecallCmd
      when "save"
        return SaveCmd
      when "set"
        return SetCatcherCmd
      when "shortcuts"
        return ShortcutsCmd
      when "shortcut"
        case cmd.switch
        when "add"
          return ShortcutAddCmd
        when "delete"
          return ShortcutDeleteCmd
        end
      when "sweep"
        case cmd.switch
        when "kick"
          return SweepKickCmd
        else
          return SweepCmd
        end
      end
      
      nil
    end

    def self.get_event_handler(event_name) 
      nil
    end
  end
end