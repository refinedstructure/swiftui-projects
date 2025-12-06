//
//  BookmarkView.swift
//  Quotecards
//
//  Created by Abhishek Rane on 20/10/24.
//

import SwiftUI
import SwiftData

struct BookmarkView: View {
    @Binding var isBookmarked: Bool
    var bookmarkOn = Image(systemName: "bookmark.fill")
    var bookmarkOff = Image(systemName: "bookmark")
    
    var body: some View {
            Button{
                withAnimation{
                    isBookmarked.toggle()
                }
            }
            label: {
                isBookmarked ? bookmarkOn : bookmarkOff
            }
        .buttonStyle(.plain)

    }
}

#Preview {
    BookmarkView(isBookmarked: .constant(false))
}
