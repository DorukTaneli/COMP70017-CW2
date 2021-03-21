//SPDX-License-Identifier: Unlicense
pragma solidity ^0.4.24;

/**
 * @title TicTacToe contract
 **/
contract TicTacToe {
    address[2] public players;

    /**
     turn
     1 - players[0]'s turn
     2 - players[1]'s turn
     */
    uint public turn = 1;

    /**
     status
     0 - ongoing
     1 - players[0] won
     2 - players[1] won
     3 - draw
     */
    uint public status;

    /**
    board status
     0    1    2
     3    4    5
     6    7    8
     */
    uint[9] private board;

    /**
      * @dev Deploy the contract to create a new game
      * @param opponent The address of player2
      **/
    constructor(address opponent) public {
        require(msg.sender != opponent, "No self play");
        players = [msg.sender, opponent];
    }

    /**
      * @dev Check a, b, c in a line are the same
      * _threeInALine doesn't check if a, b, c are in a line
      * @param a position a
      * @param b position b
      * @param c position c
      **/    
    function _threeInALine(uint a, uint b, uint c) private view returns (bool){
        /*Please complete the code here.*/ //DONE
        if (board[a] == board[b] && board[b] == board[c] && board[a] != 0) {
          return true;
        } else {
          return false;
        }
    }

    /**
     * @dev get the status of the game
     * @param pos the position the player places at
     * @return the status of the game
     */
    function _getStatus(uint pos) private view returns (uint) {
        /*Please complete the code here.*/ //DONE
        if (_checkDraw()) {
          return 3;
        } else {
          return _checkWinBoard();
        }
    }

    function _checkWinBoard() private view returns (uint) {
      if (_threeInALine(0,1,2)) {
        return board[0];
      } else if (_threeInALine(3,4,5)) {
        return board[3];
      } else if (_threeInALine(6,7,8)) {
        return board[6];
      } else if (_threeInALine(0,3,6)) {
        return board[0];
      } else if (_threeInALine(1,4,7)) {
        return board[1];
      } else if (_threeInALine(2,5,8)) {
        return board[2];
      } else if (_threeInALine(0,4,8)) {
        return board[0];
      } else if (_threeInALine(2,4,6)) {
        return board[2];
      } else {
        return 0;
      }
    }

    function _checkDraw() private view returns (bool) {
      for (uint i = 0; i <= 8; i++) {
        if (board[i] == 0) {
          return false;
        }
      }
      return true;
    }

    /**
     * @dev ensure the game is still ongoing before a player moving
     * update the status of the game after a player moving
     * @param pos the position the player places at
     */
    modifier _checkStatus(uint pos) {
        /*Please complete the code here.*/ //DONE
        require(status == 0); //game ongoing
        _; //move
        status = _getStatus(pos); //status after move
    }

    /**
     * @dev check if it's msg.sender's turn
     * @return true if it's msg.sender's turn otherwise false
     */
    function myTurn() public view returns (bool) {
       /*Please complete the code here.*/ //DONE
       address currentPlayer;
       if (turn == 1) {
         currentPlayer = players[0];
       } else {
         currentPlayer = players[1];
       }

       if (msg.sender == currentPlayer) {
         return true;
       } else {
         return false;
       }
    }

    /**
     * @dev ensure it's a msg.sender's turn
     * update the turn after a move
     */
    modifier _myTurn() {
      /*Please complete the code here.*/ //DONE
      require(myTurn());
      _;
      if (turn == 1) {
        turn = 2;
      } else {
        turn = 1;
      }
    }

    /**
     * @dev check a move is valid
     * @param pos the position the player places at
     * @return true if valid otherwise false
     */
    function validMove(uint pos) public view returns (bool) {
      /*Please complete the code here.*/ //DONE
      if (board[pos] == 0) {
        return true;
      } else {
        return false;
      }
    }

    /**
     * @dev ensure a move is valid
     * @param pos the position the player places at
     */
    modifier _validMove(uint pos) {
      /*Please complete the code here.*/ //DONE
      require(validMove(pos));
      _;
    }

    /**
     * @dev a player makes a move
     * @param pos the position the player places at
     */
    function move(uint pos) public _validMove(pos) _checkStatus(pos) _myTurn() {
        board[pos] = turn;
    }

    /**
     * @dev show the current board
     * @return board
     */
    function showBoard() public view returns (uint[9]) {
      return board;
    }
}
