#Game da forca
#acervo de dicas, contendo uma série de palavras onde uma delas será sorteada
#todos os tipos de palavras [A-z]
#2 players
#quem completar primeiro ganha
#cada jogador dá um palpite
#perde quem enforcar primeiro
#6 erros por jogo

# issues
# mais ou apenas um jogador?
# validar se o contrutor nao receber players diferentes de String e nem strings vazia, ou contendo numeros
# validar se o gets nao recebe mais que uma letra
# melhorar o result
# pegar o inventario de uma api externa

class Forca
  ERRORS = 6
  INVENTORY = {
    "banheiro" => ["sabonete", "escova", "toalha", "pasta-de-dente"],
    "cozinha" => ["colher", "fogao", "geladeira", "panela"]
  }

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @current_player = nil
    @players = [@player_1, @player_2]
    @correct_answer = false
  end

  def start
    @current_player = @players.shuffle[0]
    guess = []
    step = 0
    hanged = 0

    tip = INVENTORY.keys.shuffle[0]
    secret_word = INVENTORY[tip].shuffle[0].upcase
    underline_word = secret_word.gsub(/[A-Z]/, "_")
    puts "Bem vindo ao Jogo da Foca"
    sleep(2)

    puts "Com #{secret_word.size} letras, a dica é: #{tip}"

    loop do
      if step.positive?
        sleep(1)

        if @correct_answer == true
          puts "Parabens seu palpite esta correto"
        else
          puts "Voce perdeu a vez, joga o proximo jogador"
        end

        @correct_answer = false
      end

      sleep(1)
      puts "Palavra Secreta: #{underline_word}"

      @current_player = (@players - [@current_player])[0] if step.positive?

      sleep(1)
      puts "A vez é do jogador: #{@current_player}"
      sleep(1)
      puts "Diga seu palpite:"
      temp_word = gets.chomp.upcase
      guess << temp_word

      if secret_word.include?(temp_word)
        reg = Regexp.new("[^#{guess.join}]")
        underline_word = secret_word.gsub(reg, "_")

        @correct_answer = true
      else
        hanged += 1
      end

      step += 1
      break if (underline_word == secret_word || hanged == ERRORS)
    end

    result
  end

  def result
    if @correct_answer == true
      puts "Parabens #{@current_player}!!! Você ganhou a partida"
    else
      puts "#{@current_player} se inforcou"
    end
  end

  private

  def is_string?(value)
    value.class.is_a? String
  end
end

partida1 = Forca.new("fulano", 'sicrano')
partida1.start
partida1.result
