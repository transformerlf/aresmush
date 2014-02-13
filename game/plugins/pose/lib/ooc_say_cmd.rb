module AresMUSH
  module Pose
    class OOCSay
      include AresMUSH::Plugin

      def after_initialize
        @client_monitor = Global.client_monitor
      end
      
      def want_command?(cmd)
        cmd.logged_in? && cmd.root_is?("ooc")
      end
      
      def on_command(client, cmd)
        room = client.room
        room.emit_ooc PoseFormatter.format(client.name, "#{cmd.args}")
      end
    end
  end
end