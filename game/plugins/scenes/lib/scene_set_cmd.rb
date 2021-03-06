module AresMUSH
  module Scenes
    class SceneSetCmd
      include CommandHandler
      
      attr_accessor :set
      
      def parse_args
        self.set = trim_arg(cmd.args)
      end
      
      def handle
        room = enactor.room
        
        if (self.set)
          room.update(scene_set: self.set)
          
          if (room.scene)
            Scenes.add_pose(room.scene, self.set, enactor)
          end
          
          line = "%R%xh%xc%% #{'-'.repeat(75)}%xn%R"
          room.emit "#{line}%R#{self.set}%R#{line}"
        else
          room.update(scene_set: nil)
          client.emit_success t('scenes.scene_set_cleared')
        end
      end
    end
  end
end
