module AresMUSH
  module Pose
    class PoseCatcherCmd
      include CommandHandler
           
      def handle
        message = PoseFormatter.format(enactor_name, cmd.raw)
        is_emit = cmd.raw.start_with?("\\")
        is_ooc = cmd.raw.start_with?("'") || cmd.raw.start_with?(">")
        Pose.emit_pose(enactor, message, is_emit, is_ooc)
      end

      def log_command
        # Don't log poses
      end 
    end
  end
end
