module AresMUSH
  module FS3Skills
    def self.receives_roll_results?(actor)
      actor.has_permission?("receives_roll_results")
    end

    def self.can_manage_abilities?(actor)
      actor.has_permission?("manage_abilities")
    end

    def self.can_view_sheets?(actor)
      actor.has_permission?("view_sheets")
    end

    def self.specs
      Global.read_config('tf', 'specs')
    end

    def self.skills
      Global.read_config('tf', 'skills')
    end

    def self.quirks
      Global.read_config('tf', 'quirks')
    end

    def self.attr_names
      attrs.map { |a| a['name'].titlecase }
    end

    def self.school_names
      schools.map { |s| s['name'].titlecase }
    end

    def self.spell_names
      spells.map { |s| s['name'].titlecase }
    end

    def self.focus_names
      focus.map { |f| f['name'].titlecase }
    end

    def self.action_skill_names
      action_skills.map { |a| a['name'].titlecase }
    end

    def self.language_names
      languages.map { |l| l['name'].titlecase }
    end

    def self.action_skill_config(name)
      FS3Skills.action_skills.find { |s| s["name"].upcase == name.upcase }
    end

    def self.attr_blurb
      Global.read_config("fs3skills", "attributes_blurb")
    end

    def self.school_blurb
      Global.read_config("fs3skills", "schools_blurb")
    end

    def self.spell_blurb
      Global.read_config("fs3skills", "spells_blurb")
    end

    def self.focus_blurb
      Global.read_config("fs3skills", "focus_blurb")
    end

    def self.action_blurb
      Global.read_config("fs3skills", "action_skills_blurb")
    end

    def self.bg_blurb
      Global.read_config("fs3skills", "bg_skills_blurb")
    end

    def self.language_blurb
      Global.read_config("fs3skills", "language_blurb")
    end

    # Returns the type (attribute, action, etc) for a skill being rolled.
    def self.get_ability_type(ability)
      ability = ability.titlecase
      if (attr_names.include?(ability))
        return :attribute
      elsif (school_names.include?(ability))
        return :school
      elsif (spell_names.include?(ability))
        return :spell
      elsif (focus_names.include?(ability))
        return :focus
      elsif (action_skill_names.include?(ability))
        return :action
      elsif (language_names.include?(ability))
        return :language
      else
        return :background
      end
    end

    private

    def self.add_to_hash(hash, char, skill)
      if (hash[skill.name])
        hash[skill.name] << "#{char.name}:#{skill.rating}"
      else
        hash[skill.name] = ["#{char.name}:#{skill.rating}"]
      end
    end
  end
end
