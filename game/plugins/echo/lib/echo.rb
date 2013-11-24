module AresMUSH
  module Echo
    class Echo
      include AresMUSH::Plugin

      def want_command?(cmd)
        cmd.root_is?("echo")
      end
      
      def on_command(client, cmd)
        client.emit cmd.args
      end
    end
  end
end