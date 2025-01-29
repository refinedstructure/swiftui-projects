//
//  QuoteView.swift
//  Quotecards
//
//  Created by Abhishek R on 03/07/24.
//
import SwiftData
import SwiftUI


struct QuoteView: View {
    @Environment(\.modelContext) private var context 
    @State private var bookmarkEnabled = false
    let selectedCategory: String
    @Binding var path: NavigationPath
    
    @State private var allQuotes: [Quote] = []
    @Query(
        sort: [
            SortDescriptor(\QuoteCard.quoteText),
            SortDescriptor(\QuoteCard.quoteAuthor)
        ]
    )
    
    var quotes: [QuoteCard]

    let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            Text("\(selectedCategory.uppercased()) QUOTES").font(.title2).foregroundStyle(.gray).shadow(radius: 10)
        }.padding()
        ScrollView(.horizontal){
            LazyHGrid(rows:rows, spacing:10) {
                ForEach(allQuotes, id: \.id) { quote in
                        ZStack{
                            VStack{
                                Spacer()
                                Text(quote.quote)
                                    .font(.largeTitle)
                                    .multilineTextAlignment(.center)
                                    .fontDesign(.rounded)
                                Text("-- " + quote.author).font(.subheadline)
                                    .multilineTextAlignment(.center)

                                Spacer()
                            }
                            
                            VStack{
                                Spacer()
                                HStack{
                                    Spacer()
                                    BookmarkView(isBookmarked: $bookmarkEnabled)
                                        .padding([.bottom, .trailing], 10)
                             
                                }
                            }
                            
                        }
                    
                        .frame(width:330, height:350, alignment:.center)
                        .background(.linearGradient(colors:[.gray,.white,.gray], startPoint: .top, endPoint: .bottom))
                        .cornerRadius(25)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                }
            }
            Spacer()
        }.onAppear{
            allQuotes = decodeData(selectedCategory: selectedCategory)
        }
    }
}

#Preview {
    QuoteView(
        selectedCategory: "tv",
        path: .constant(NavigationPath())
    )
}
