module AresMUSH
  class WebApp

    get '/chargen/?' do
      if (!@user)
        erb :"chargen/login_required"
      else
        if (@user.is_approved?)
          flash[:error] = "You are already approved."
          redirect char_page_url(@user)
        end

        if (Chargen.check_chargen_locked(@user))
          flash[:error] = "Unsubmit your app (in-game) before making changes."
          redirect char_page_url(@user)
        end

        @chargen = JSON.generate(Global.read_config('tf', 'chargen'))
        @specs = JSON.generate(Global.read_config('tf', 'specs'))
        @skills = JSON.generate(Global.read_config('tf', 'skills'))
        @quirks = JSON.generate(Global.read_config('tf', 'quirks'))
        @modes = JSON.generate(Global.read_config('tf', 'modes'))

        template = Chargen::AppTemplate.new(@user, @user)
        @app = ClientFormatter.format template.render, false

        erb :"chargen/chargen"
      end
    end

  end
end
