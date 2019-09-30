module FieldFormatter
  def strip_and_downcase_in_ram(field)
    self.send("#{field}=", strip_and_downcase(field))
  end

  def strip_and_downcase_in_db(field)
    self.update_column(field, strip_and_downcase(field))
  end

  def strip_and_downcase(field)
    self.send(field)&.strip&.downcase
  end
end
