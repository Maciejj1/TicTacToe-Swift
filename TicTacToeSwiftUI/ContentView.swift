import SwiftUI

struct ContentView: View {
    
    @StateObject var gameState = GameState()
    
    var body: some View {
        let borderSize = CGFloat(5)
        Spacer()
        VStack {
            HStack {
                Spacer()
                Rectangle()
                    .fill(Color(red: 72/255, green: 210/255, blue: 254/255))
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        VStack {
                            Text("Gracz X:")
                                .foregroundColor(.black)
                                .font(.headline)
                                .padding(.bottom, 0)
                            Text(String(format:"%d",gameState.crossesScore))
                                .foregroundColor(.black)
                                .font(.title).bold()
                        }
                        .padding(.top, 5)
                    )
            
                Spacer()
                Rectangle()
                    .fill(Color(red: 188/255, green: 219/255, blue: 249/255))
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    .overlay(
                        VStack {
                            Text("Remisy:")
                                .foregroundColor(.black)
                                .font(.headline)
                                .padding(.bottom, 0)
                            Text(String(format:"%d",gameState.drawesScore))
                                .foregroundColor(.black)
                                .font(.title).bold()
                        }
                        .padding(.top, 5)
                    )
                Spacer()
                Rectangle()
                    .fill(Color(red: 45/255, green: 255/255, blue: 91/255))
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    .overlay(
                        VStack {
                            Text("Gracz O:")
                                .foregroundColor(.black)
                                .font(.headline)
                                .padding(.bottom, 0)
                            Text(String(format:"%d",gameState.noughtsScore))
                                .foregroundColor(.black)
                                .font(.title).bold()
                        }
                        .padding(.top, 5)
                    )
                Spacer()
            }
            .padding()
            Text(gameState.turnText())
                .font(.title)
                .bold()
                .padding()
                .foregroundColor(.white)
            
            VStack(spacing: borderSize)
            {
                ForEach(0...2, id: \.self)
                {
                    row in
                    HStack(spacing: borderSize)
                    {
                        ForEach(0...2, id: \.self)
                        {
                            column in
                            let cell = gameState.board[row][column]
                            Text(cell.displayTile())
                                .font(.system(size: 60))
                                .bold()
                                .foregroundStyle(cell.tileColor())
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .aspectRatio(1, contentMode: .fit )
                                .background(Color(red: 67/255, green: 17/255, blue: 91/255))
                                .onTapGesture {
                                    gameState.placeTile(row, column)
                                }
                        }
                    }
                }
            }
            .padding()
            Spacer()
        }
        .background(Color(red: 43/255, green: 0/255, blue: 64/255))
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $gameState.showAlert) {
            Alert(title: Text(gameState.alertMessage),
                  dismissButton: .default(Text("Okay")) {
                    gameState.resetBoard()
                  }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

