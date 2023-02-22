//
//  ViewModifier.swift
//  TicTacToe
//
//  Created by admin on 2/15/23.
//

import SwiftUI

struct NavStackContainer: ViewModifier{
    func body(content: Content) -> some View {
        if #available(iOS 16, *){ //have to specify the version
            //asterick is to specify that its everything under 16
            NavigationStack{
                content
            }
        }
        else {
            NavigationView{
                content
            }
            .navigationViewStyle(.stack)
        }
    }
}

extension View {
    public func inNavigationStack()-> some View{
        return self.modifier(NavStackContainer())
    }
}
