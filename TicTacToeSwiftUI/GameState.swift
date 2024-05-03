import Foundation

class GameState: ObservableObject
{
    @Published var board =  [[Cell]]()
    @Published var turn = Tile.Cross
    @Published var noughtsScore = 0
    @Published var crossesScore = 0
    @Published var drawesScore = 0
    @Published var showAlert = false
    @Published var alertMessage = "Remis"
    
    init()
    {
        resetBoard()
    }
    
    func placeTile(_ row: Int,_ column: Int)
    {
        if(board[row][column].tile != Tile.Empty)
        {
            return
        }
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        if(checkVictory())
        {
            if(turn == Tile.Cross)
            {
                crossesScore += 1
            }
            else
            {
                noughtsScore += 1
            }
            let winner = turn == Tile.Cross ? "Gracz X" : "Gracz O"
            alertMessage = winner + " Wygrał!"
            showAlert = true
        }
        else
        {
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
        if(checkForDraw())
        {
            alertMessage = "Remis"
            showAlert = true
        }
    }
    
    func turnText() -> String
    {
        return  turn == Tile.Cross ? "Tura: Gracza X" : "Tura: Gracza O"
    }
    
    func checkForDraw() -> Bool
    {
        for row in board
        {
            for cell in row
            {
                if cell.tile == Tile.Empty
                {
             
                    return false
                }
            }
        }
        drawesScore += 1
        return true
    }
    
    func checkVictory() -> Bool
    {
        //vertical victory
        if isTurnTile(0, 0) && isTurnTile(1, 0) && isTurnTile(2, 0)
        {
        return true
        }
        if isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1)
        {
        return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 2) && isTurnTile(2, 2)
        {
        return true
        }       
        //horizontal vicotry
        if isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2)
        {
        return true
        }
        if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(2, 1)
        {
        return true
        }
        if isTurnTile(2, 0) && isTurnTile(1, 2) && isTurnTile(2, 2)
        {
        return true
        }
        //diagonal victory
        if isTurnTile(0, 0) && isTurnTile(1, 1) && isTurnTile(2, 2)
        {
        return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2, 0)
        {
        return true
        }
        return false
    }
    
    func isTurnTile(_ row: Int,_ column: Int) -> Bool
    {
        return board[row][column].tile == turn
    }
    
    func resetBoard()
    {
        var newBoard = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            for _ in 0...2
            {
                row.append(Cell(tile: Tile.Empty))
                
            }
            newBoard.append(row)
        }
        board = newBoard
    }
}
