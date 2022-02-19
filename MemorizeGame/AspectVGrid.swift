//
//  AspectVGrid.swift
//  MemorizeGame
//
//  Created by Entangled Mind on 16/2/2022.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where Item:Identifiable, ItemView: View {

    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    // @ViewBuilder to tell compiler that the closure or function is returning some views
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            // VStack and Spacer ensure the GeometryReader take up all flexible content
            VStack {
                let width: CGFloat = findCardWidthForSignlePage(numOfItem: items.count, in: geometry.size, aspectRatio: aspectRatio)
                LazyVGrid(columns: [zeroSpacingGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(2/3, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func zeroSpacingGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func findCardWidthForSignlePage(numOfItem: Int, in size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = numOfItem
        var itemWidth = size.width / CGFloat(columnCount)
        var itemHeight = itemWidth / aspectRatio
        while (CGFloat(rowCount) * itemHeight > size.height) {
            columnCount += 1
            let quotient = numOfItem / columnCount
            let reminder = numOfItem % columnCount
            rowCount = (reminder > 0) ? (quotient + 1) : (quotient)
            itemWidth = size.width / CGFloat(columnCount)
            itemHeight = itemWidth / aspectRatio
        }
        return itemWidth
    }
}

