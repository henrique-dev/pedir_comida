namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("[:spinner] Deletando o banco de dados") {%x(rails db:drop)}
      show_spinner("[:spinner] Criando o banco de dados") {%x(rails db:create)}
      show_spinner("[:spinner] Migrando o banco de dados") {%x(rails db:migrate)}
      show_spinner("[:spinner] Populando o banco de dados") {%x(rails db:seed)}
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  def show_spinner(msg)
    spinner = TTY::Spinner.new(msg, format: :classic)
    spinner.auto_spin
    yield
    spinner.success
  end

end