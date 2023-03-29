Rails.application.config.after_initialize do
  FetchCompaniesJob.new.perform()
end
  