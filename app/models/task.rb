class Task < ApplicationRecord
  # before_validation :set_nameless_name
  has_one_attached :image

  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_including_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) } #[知見] 4-8

  def self.csv_attributes
    ["name", "description", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task| #allはTaskのall,Task.where(...)と重ねて呼ぶことも可能
        csv << csv_attributes.map{|attr| task.send(attr)}
      end
    end
  end

  private

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end

  # def set_nameless_name
  #   self.name = '名前なし' if name.blank?
  # end
end
