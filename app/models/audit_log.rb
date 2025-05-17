class Log < ApplicationRecord
  self.table_name = "logs"  # если модель называется Log, а таблица — logs

  belongs_to :user, optional: true

  enum event_type: {
    login:       0,
    logout:      1,
    operation:   2,
    data_change: 3,
    error:       4
  }

  validates :event_type, presence: true
  validates :payload,    presence: true
end
