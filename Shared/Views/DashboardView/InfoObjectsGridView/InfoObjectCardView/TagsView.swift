//
//  TagsView.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 08/05/25.
//
import SwiftUI

struct TagsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var tags: [String]
    var spacing: CGFloat = 10
    var typedTagName: String = "+"
    
    var body: some View {
        CustomTagsLayout(spacing: spacing) {
            ForEach(tags, id: \.self) { tag in
                Text(tag.capitalized)
                    .foregroundStyle((colorScheme == .light ? .black : .white))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colorScheme == .light ? .white : .black)
                            .shadow(color: .black.opacity(0.12), radius: 5)
                    }
            }
            Text(typedTagName)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(colorScheme == .light ? .black : .white)
                        .shadow(color: .black.opacity(0.12), radius: 5)
                }
                .onTapGesture {
                    
                }
        }
    }
}

fileprivate struct CustomTagsLayout: Layout {
    var spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 0
        return .init(width: width, height: maxHeight(proposal: proposal, subviews: subviews))
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        
        for subview in subviews {
            let fitsize = subview.sizeThatFits(proposal)
            
            if (origin.x + fitsize.width) > bounds.maxX {
                origin.x = bounds.minX
                origin.y += fitsize.height + spacing
                
                subview.place(at: origin, proposal: proposal)
                origin.x += fitsize.width + spacing
            } else {
                subview.place(at: origin, proposal: proposal)
                origin.x += fitsize.width + spacing
            }
        }
    }
    
    private func maxHeight(proposal: ProposedViewSize, subviews: Subviews) -> CGFloat {
        var origin: CGPoint = .zero
        
        for subview in subviews {
            let fitsize = subview.sizeThatFits(proposal)
            
            if (origin.x + fitsize.width) > (proposal.width ?? 0) {
                origin.x = 0
                origin.y += fitsize.height + spacing
                
                origin.x += fitsize.width + spacing
            } else {
                origin.x += fitsize.width + spacing
            }
            
            if subview == subviews.last {
                origin.y += fitsize.height
            }
        }
        
        return origin.y
    }
}

#Preview {
    TagsView(tags: ["Actress", "Theater", "Zemfira", "Art", "Kirill Trubetskoy"])
}
