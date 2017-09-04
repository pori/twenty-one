# 21

A simple command-line implementation of _21_, better known as _blackjack_.

## Installation

Just install the gem:

    $ gem install twenty_one

## Usage

To start a new game. Simply execute:

    $ 21

### Tests

Testing was done with rspec. If the you cloned the project run tests with:

    $ rspec

### Game Rules

#### Terms

* "blackjack" is a hand worth 21
* "bust" is a loss
* "push" is a tie between the player's hand and the dealer's hand
* "shoe" is a stack of decks mixed together
* "hit" drawing a single card from the shoe
* "stand" ending a turn
* "hole" the card that the dealer keeps hidden
* "hand" the cards a player poses
* "showdown" when the player's hand is pitted against the player's hand

#### Goal

The goal of the game is to draw a hand with a value greater than the dealer's as long as it is not greater than 21.

#### Phases

1. Bet 
	* The player will state the amount (in dollars) they want to bet
2. Deal cards 
	* The player and the dealer are each hit with two cards
	* The dealer's second card will be the hole 
3. Player turn
	* Player can choose to hit
	* Player ends with a stand
	* A hand exceeding 21 is an automatic bust
4. Dealer turn
	* The dealer reveals the hole card
	* The dealer will hit if their hand is worth less than 21
	* If the dealer busts and the player did not bust, the player wins 
		* Otherwise, it is a push
5. Showdown
	* If the player has a hand worth more than the dealer, the player wins.
		* Otherwise, the dealer wins 

### Cards

* 52 cards are represented
* Regular cards are valued at whatever number they hold
* Face cards are worth 10
* Ace cards are worth 1 or 11
	* Players can choose whichever they like
	* Dealers must choose whichever is appropriate to surpass 17
* A player can choose to hit when it is their turn
	* If a hit causes a hand higher than 21, the player automatically busts
* A player can choose to stand when it is their turn

#### Chips

* White chips are worth $1
* Red chips are worth $5 
* Green chips are worth $25
* Black chips are worth $100

#### Player

* A player will start with 100 total chips
	* 50 white chips
	* 25 red chips
	* 15 green chips
	* 10 black chips 
* Bets will be filled sequentially from highest value chips to lowest
* A regular win will give the player double what theu bet in chips
* A blackjack will win the player 2.5 times what they bet in chips
* A bust means the player will not get back their chips

#### Dealer 

* A dealer's hand must be no less than 17
	* If the hand is worth less than 17, the dealer must hit until it is 17 or greater
* If a dealer busts and the player has not, then player wins the round

## Contributing

1. Fork it ( https://github.com/pori/twenty-one/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
