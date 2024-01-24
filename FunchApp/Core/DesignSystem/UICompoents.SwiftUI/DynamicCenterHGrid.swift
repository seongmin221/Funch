//
//  DynamicCenterHGrid.swift
//  FunchApp
//
//  Created by 이성민 on 1/24/24.
//

import SwiftUI

// TODO: 주석 작성
struct DynamicCenterHGrid {
    var itemSpacing: CGFloat
    var lineSpacing: CGFloat
    
    init(itemSpacing: CGFloat,
         lineSpacing: CGFloat) {
        self.itemSpacing = itemSpacing
        self.lineSpacing = lineSpacing
    }
}

extension DynamicCenterHGrid: Layout {
    /// DynamicGrid의 사이즈를 계산하는 함수
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return calculateLayout(of: sizes, containerWidth: width).size
    }
    
    /// DynamicGrid 내부에 있는 subview들을 배치시키는 함수
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let offsets = calculateLayout(of: sizes,
                                      containerWidth: bounds.width).offsets
        let leftSpacingArray = calculateStartingOffsets(from: sizes,
                                                        and: offsets,
                                                        containerWidth: bounds.width)
        
        for ((leftSpacing, offset), subview) in zip(zip(leftSpacingArray, offsets), subviews) {
            subview.place(at: .init(x: leftSpacing + offset.x + bounds.minX, y: offset.y + bounds.minY),
                          proposal: .unspecified)
        }
    }
}

extension DynamicCenterHGrid {
    
    /// 레이아웃을 계산해서 부모 뷰가 제시해 주는 크기 내부에 들어가는 사이즈 중
    /// 가장 fit 한 사이즈와 내부에 들어갈 subview 들의 위치를 계산하는 함수입니다.
    /// - offsets: subview 들 위치
    /// - size: 계산된 DynamicGrid의 사이즈
    func calculateLayout(of subviewSizes: [CGSize], containerWidth: CGFloat) -> (offsets: [CGPoint], size: CGSize) {
        /// subview들의 위치
        var offsets: [CGPoint] = []
        /// 해당 DynamicGrid에 가장 fit 한 사이즈
        var containerSize: CGSize = .zero
        /// subview들이 레이아웃 되면서 옮겨질 기준점
        var currentPosition: CGPoint = .zero
        for size in subviewSizes {
            /// 현재 시작 지점(currentPosition.x)에서 추가될 subview의 width가
            /// DynamicGrid의 너비를 넘을 경우
            if currentPosition.x + size.width > containerWidth {
                /// 현재 위치의 x 좌표는 0으로
                currentPosition.x = 0
                /// 현재 위치의 y 좌표는 다음 행으로 이동
                currentPosition.y += size.height + lineSpacing
            }
            /// 계산된 subview의 위치를 placeSubviews에 전달하기 위한 값들
            /// - 각 subview들의 시작 위치 배열
            offsets.append(currentPosition)
            /// subview 들 사이의 간격을 더해 다음 subview의 시작 위치를 업데이트
            currentPosition.x += size.width + itemSpacing
            /// 가장 fit 한 container의 size를 계산하기 위해 지금까지 나온 값들 중 최대값을 기록
            containerSize.width = max(containerSize.width, currentPosition.x)
            containerSize.height = max(containerSize.height, currentPosition.y + size.height)
        }
        
        return (offsets, containerSize)
    }
    
    func calculateStartingOffsets(from sizes: [CGSize], and offsets: [CGPoint], containerWidth: CGFloat) -> [CGFloat] {
        var groupedRowSizes: [[CGSize]] = []
        var rowSizes: [CGSize] = []
        var memo: CGFloat = 0
        
        let subviewCount = offsets.count
        for index in 0..<subviewCount {
            if memo != offsets[index].y {
                groupedRowSizes.append(rowSizes)
                rowSizes = []
            }
            
            rowSizes.append(sizes[index])
            memo = offsets[index].y
            
            if index == subviewCount - 1 {
                groupedRowSizes.append(rowSizes)
            }
        }
        
        var leftSpacingArray: [CGFloat] = []
        for rowSizes in groupedRowSizes {
            var rowWidth = rowSizes.reduce(CGFloat(0), { $0 + itemSpacing + $1.width })
            rowWidth -= itemSpacing
            let leftSpacing = (containerWidth - rowWidth) / 2
            leftSpacingArray += Array(repeating: leftSpacing, count: rowSizes.count)
        }
        
        return leftSpacingArray
    }
}


// MARK: - 과거 버전
//struct DynamicCenterHGrid {
//    var itemSpacing: CGFloat
//    var lineSpacing: CGFloat
//
//    init(itemSpacing: CGFloat,
//         lineSpacing: CGFloat) {
//        self.itemSpacing = itemSpacing
//        self.lineSpacing = lineSpacing
//    }
//}
//
//extension DynamicCenterHGrid: Layout {
//    /// DynamicGrid의 사이즈를 계산하는 함수
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        let width = proposal.replacingUnspecifiedDimensions().width
//        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
//        return calculateLayout(sizes: sizes, containerWidth: width).size
//        return .zero
//    }
//
//    /// DynamicGrid 내부에 있는 subview들을 배치시키는 함수
//    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
//        let offsets = calculateLayout(sizes: sizes, containerWidth: bounds.width).offsets
//        print(offsets)
//        for (offset, subview) in zip(offsets, subviews) {
//            subview.place(at: .init(x: offset.x + bounds.minX, y: offset.y + bounds.minY), proposal: .unspecified)
//        }
//    }
//}
//
//extension DynamicCenterHGrid {
//
//    private func groupSubviews(_ subviewSizes: [CGSize], containerWidth: CGFloat) -> [[CGSize]] {
//        var groupedRowItemSizes: [[CGSize]] = []
//
//        var rowWidth: CGFloat = 0
//        var rowItemSizes: [CGSize] = []
//        for size in subviewSizes {
//            if rowWidth + itemSpacing + size.width > containerWidth {
//                groupedRowItemSizes.append(rowItemSizes)
//                rowItemSizes = []
//                rowWidth = 0
//            }
//
//            rowItemSizes.append(size)
//            rowWidth += itemSpacing + size.width
//        }
//        groupedRowItemSizes.append(rowItemSizes)
//
//        return groupedRowItemSizes
//    }
//
//    private func calculateRowSize(of subviewSizes: [CGSize]) -> CGSize {
//        var rowSize: CGSize = .zero
//        for subviewSize in subviewSizes {
//            rowSize.width += subviewSize.width + itemSpacing
//            rowSize.height = max(rowSize.height, subviewSize.height)
//        }
//        rowSize.width -= itemSpacing
//        return rowSize
//    }
//
//    private func calculateLayout(sizes subviewSizes: [CGSize], containerWidth: CGFloat) -> (offsets: [CGPoint], size: CGSize) {
//        var offsets: [CGPoint] = []
//        var fittedContainerSize: CGSize = .zero
//
//        let groupedRowItemSizes: [[CGSize]] = groupSubviews(subviewSizes, containerWidth: containerWidth)
//        let rowSizes: [CGSize] = groupedRowItemSizes.map { calculateRowSize(of: $0) }
//
//        var currentPosition: CGPoint = .zero
//        let rowCount = rowSizes.count
//
//        for i in 0..<rowCount {
//            let initX: CGFloat = (containerWidth - rowSizes[i].width) / 2
//            currentPosition.x = initX
//
//            for itemSize in groupedRowItemSizes[i] {
//                offsets.append(currentPosition)
//                currentPosition.x += itemSize.width + itemSpacing
//            }
//            currentPosition.y += rowSizes[i].height + lineSpacing
//        }
//        fittedContainerSize.width = rowSizes.map { $0.width }.max() ?? 0
//        fittedContainerSize.height = rowSizes
//            .map { $0.height }
//            .reduce(0, { $0 + $1 + itemSpacing }) - lineSpacing
//
//        return (offsets, fittedContainerSize)
//    }
//}
