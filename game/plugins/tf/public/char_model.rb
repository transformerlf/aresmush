module AresMUSH

  class Character
    reference :sheet, 'AresMUSH::Sheet'
  end

  class Sheet < Ohm::Model
    include ObjectModel

    collection :specs, 'AresMUSH:Sheet'
    collection :skills, 'AresMUSH::Skill'
    collection :quirks, 'AresMUSH::Quirk'
    collection :modes, 'AresMUSH::Mode'
    attribute :energon, type: DataType::Integer, default: 20
    attribute :power, type: DataType::Integer, default: 8
    attribute :xp, type: DataType::Integer, default: 0
  end

  class Spec < Ohm::Model
    include ObjectModel
    reference :sheet, 'AresMUSH::Sheet'
    attribute :name
    attribute :rating, type: DataType::Integer, default: 0

    index :name
  end

  class Skill < Ohm::Model
    include ObjectModel
    reference :sheet, 'AresMUSH::Sheet'
    attribute :name
    attribute :rating, type: DataType::Integer, default: 0

    index :name
  end

  class Quirk < Ohm::Model
    include ObjectModel
    reference :sheet, 'AresMUSH::Sheet'
    attribute :name
    attribute :rating, type: DataType::Integer, default: 0

    index :name
  end

  class Mode < Ohm::Model
    include ObjectModel
    reference :sheet, 'AresMUSH::Sheet'
    attribute :name
    attribute :type
    attribute :rating, type: DataType::Integer, default: 0

    index :name
    index :type
  end
end
