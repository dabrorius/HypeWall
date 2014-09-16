class ActivationCode < ActiveRecord::Base
  belongs_to :wall
  after_create :generate_code

  private

    def generate_code
      self.code = "#{self.id.to_s}-#{SecureRandom.base64(8)}"
    end
end
