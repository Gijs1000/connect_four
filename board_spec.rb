require_relative 'board'

RSpec.describe Board do
  def instantiate_and_build_board
    board = Board.new
    board.build_board(board.instance_variable_get(:@height), board.instance_variable_get(:@width))
    return board
  end

  describe '#new' do
    context 'when initialized without any arguments' do
      subject(:default_board) { Board.new }

      it 'is assigned the default size' do
        height = default_board.instance_variable_get(:@height)
        width = default_board.instance_variable_get(:@width)

        expect(height).to eq(6)
        expect(width).to eq(7)
      end
    end

    context 'when initialized with two arguments' do
      subject(:two_arguments_board) { Board.new(2, 4) }

      it 'takes on the size of those arguments' do
        height = two_arguments_board.instance_variable_get(:@height)
        width = two_arguments_board.instance_variable_get(:@width)

        expect(height).to eq(2)
        expect(width).to eq(4)
      end
    end

    context 'when initialized with only the first argument' do
      subject(:one_argument_board) { Board.new(4) }

      it 'uses the default value for the second argument' do
        height = one_argument_board.instance_variable_get(:@height)
        width = one_argument_board.instance_variable_get(:@width)

        expect(height).to eq(4)
        expect(width).to eq(7)
      end
    end

    
  end

  describe '#build_board' do
    context 'when correct arguments are passed (e.g. 7, 6)' do
      matcher :be_of_length_six do
        match { |arr| arr.length == 6 }
      end
      
      it 'creates a board that is 7 wide' do
        board_width = instantiate_and_build_board.board.length
        expect(board_width).to eq(7)
      end

      it 'creates a board that is 6 high' do
        array_of_board_columns = instantiate_and_build_board.board
        expect(array_of_board_columns).to all(be_of_length_six)
      end
    end
  end

  describe '#update_board' do
    let(:player1) { double('player1', symbol: 'X') }

    it 'preserves column height' do
      board = instantiate_and_build_board
      chosen_column = 3
      board.update_board(chosen_column, player1.symbol)
      affected_column_height = board.board[2].length # 2 because update_board subtracts 1 from the chosen_column argument
      expected_column_height = board.instance_variable_get(:@height)
      expect(affected_column_height).to eq(expected_column_height)
    end

    context 'when arguments are valid' do 
      context 'and it is the first stone in a column,' do
        it 'add a stone with the correct symbol to the correct position' do
          board = instantiate_and_build_board
          chosen_column = 3
          board.update_board(chosen_column, player1.symbol)
          affected_position = board.board[2][0]
          expect(affected_position).to eq(player1.symbol)
        end
      end

      context 'and it is not the first stone in a column, ' do
        it 'add a stone with the correct symbol to the correct position' do
          board = instantiate_and_build_board
          chosen_column = 3
          3.times { board.update_board(chosen_column, player1.symbol) }
          affected_positions = board.board[2][0..2]
          expect(affected_positions).to all(eq(player1.symbol))
        end
      end

      context 'but the column is already full, ' do
        it 'ask the player to try another column' do
          board = instantiate_and_build_board
          allow(board).to receive(:board).and_return([[][][][][][]])
          chosen_column = 0
          return_value = board.update_board(chosen_column, player1.symbol)
          expect(return_value).to eq('That column is full. Try another one!')
        end
      end
    end

    context 'when position is invalid' do
    end

    context 'when symbol is invalid' do
    end
  end



end