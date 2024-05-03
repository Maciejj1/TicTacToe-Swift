import Foundation
import SwiftUI
struct Cell
{
    var tile: Tile
    func displayTile() -> String
    {
        switch(tile)
        {
        case Tile.Nought:
            return "O"
        case Tile.Cross:
            return "X"
        default:
            return ""
            
        }
    }
    func tileColor() -> Color
    {
        switch(tile)
        {
        case Tile.Nought:
            return Color(red: 72/255, green: 210/255, blue: 254/255)
        case Tile.Cross:
            return Color(red: 45/255, green: 255/255, blue: 91/255)
        default:
            return Color.red
            
        }
    }
}
enum Tile
{
    case Nought
    case Cross
    case Empty
}
