namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Droping BD...") { %x(rails db:drop) }
      show_spinner("Creating BD...") { %x(rails db:create) }
      show_spinner("Running migrates BD...") { %x(rails db:migrate) }
      show_spinner("Executing seeds...") { %x(rails db:seed) }
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  private

  def show_spinner(start_message, msg_end = "Done!!!")
    spinner = TTY::Spinner.new("[:spinner] #{start_message}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")    
  end
end
