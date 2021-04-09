require_relative 'player'

RSpec.describe Player do
  describe '#new' do
    it 'creates a player with a name and a symbol' do
      subject(:player) { described_class.new('Gijs', 'X') }
      expect(player).to have_atrributes(:name => 'Gijs', :symbol => 'X')
    end
  end
end

