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
            
            ScrollView(.horizontal){
                LazyHGrid(rows:rows, spacing:10) {
                    ForEach(allQuotes, id: \.id) { quote in
                        ZStack{
                            VStack{
                                Spacer()
                                Text(quote.quote)
                                    .font(.title)
                                    .multilineTextAlignment(.center)
                                    .fontDesign(.rounded)
                                Text("-- " + quote.author).font(.caption)
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
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(UIColor.systemGray2),Color(UIColor.systemGray6)]) , startPoint: .top, endPoint: .bottom)
                            )
                        .cornerRadius(20)
                        .shadow(color: Color.primary.opacity(0.7), radius: 10)
                        .padding(.horizontal)
                    }
                    
                }
                
                Spacer()
                
            }
            .onAppear{
                allQuotes = decodeData(selectedCategory: selectedCategory)
            }
        }
        .background(Color(UIColor.secondarySystemBackground).ignoresSafeArea())
    }
    
}

#Preview {
    QuoteView(
        selectedCategory: "tv",
        path: .constant(NavigationPath())
    )
}
