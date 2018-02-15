class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.digest_attr(*attrs)
    attrs.each do |attr|
      method_name = "#{attr}="
      method = instance_method(method_name)

      define_method(method_name) do |value|
        digest = Digest::SHA1.hexdigest(value.to_s) if value.present?
        write_attribute("#{attr}_digest", digest)

        method.bind(self).call(value)
      end
    end
  end
end
