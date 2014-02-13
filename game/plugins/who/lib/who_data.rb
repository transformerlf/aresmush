module AresMUSH
  class WhoData
    include ToLiquidHelper
    
    def initialize(clients)
      @clients = clients
    end
    
    attr_reader :clients
    
    def online_total
      t('who.players_online', :count => @clients.count)
    end
    
    def ic_total
      ic = @clients.select { |c| c.char.is_ic? }
      t('who.players_ic', :count => ic.count)
    end
    
    def online_record
      t('who.online_record', :count => Game.online_record)
    end
    
    def mush_name
      Global.config['server']['mush_name']
    end
  end  
end