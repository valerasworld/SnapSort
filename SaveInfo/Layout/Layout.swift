//
//  Layout.swift
//  SaveInfo
//
//  Created by Valery Zazulin on 23/06/25.
//

import SwiftUI

struct CustomHoneycombsLayout: Layout {
    var spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 0
        return .init(width: width, height: maxHeight(proposal: proposal, subviews: subviews))
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // Set origin at the top left corner – origin (0,0)
        var origin = bounds.origin
        var count = 0
        
        for subview in subviews {
            // Get the subview size
            let fitsize = subview.sizeThatFits(proposal)
            
            // if current x.pos + subview width > parental view width
            if (origin.x + fitsize.width) > bounds.maxX {
                if count == 1 {
                    // refresh x.pos to 0
                    origin.x = bounds.minX
                    count -= 1
                } else {
                    origin.x = bounds.minX + (fitsize.width + spacing) / 2
                    count += 1
                }
                // and make y.pos one line lower
                origin.y += sqrt(0.75) * (fitsize.height + spacing)
                
                // place subview at this new point
                subview.place(at: origin, proposal: proposal)
                // and update x.pos (move pointer to the right)
                origin.x += fitsize.width + spacing
            } else {
                // If subview fits on this line - place it here
                subview.place(at: origin, proposal: proposal)
                // And update the origin horizontally
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
                origin.y += sqrt(0.75) * (fitsize.height + spacing)
                
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

struct CustomHoneycombsSnakeLayout: Layout {
    var spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 0
        return .init(width: width, height: maxHeight(proposal: proposal, subviews: subviews))
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // Set origin at the top left corner – origin (0,0)
        var origin = bounds.origin
        var isEvenLine = false
        
        
        
        for subview in subviews {
            // Get the subview size
            let fitsize = subview.sizeThatFits(proposal)
            let necessarySpaceRight = origin.x + fitsize.width
            let shiftValue = fitsize.width + spacing
            
            if !isEvenLine {
                if necessarySpaceRight < bounds.maxX {
                    subview.place(at: origin, proposal: proposal)
                    origin.x += shiftValue
                    
                } else {
                    origin.y += (sqrt(0.75) * shiftValue)
                    origin.x = bounds.maxX - fitsize.width - (shiftValue / 2)
                    subview.place(at: origin, proposal: proposal)
                    origin.x -= shiftValue
                    isEvenLine.toggle()
                    
                }
            } else {
                if origin.x > bounds.minX {
                    subview.place(at: origin, proposal: proposal)
                    origin.x -= shiftValue
                    
                } else {
                    origin.y += (sqrt(0.75) * shiftValue)
                    origin.x = bounds.minX
                    subview.place(at: origin, proposal: proposal)
                    origin.x += shiftValue
                    isEvenLine.toggle()
                    
                    
                    
                }
            }
        }
    }
    
    private func maxHeight(proposal: ProposedViewSize, subviews: Subviews) -> CGFloat {
        var origin: CGPoint = .zero
        
        for subview in subviews {
            let fitsize = subview.sizeThatFits(proposal)
            
            if (origin.x + fitsize.width) > (proposal.width ?? 0) {
                origin.x = 0
                origin.y += sqrt(0.75) * (fitsize.height + spacing)
                
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

