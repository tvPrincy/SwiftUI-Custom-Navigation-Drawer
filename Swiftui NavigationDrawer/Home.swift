//
//  Homw.swift
//  Swiftui NavigationDrawer
//
//  Created by Kevin Baldha on 19/04/21.
//

import SwiftUI

struct Home: View {
    @State var eadges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var width = UIScreen.main.bounds.width
    @State var show = false
    @State var selectedIndex = ""
    @State var min : CGFloat = 0
    
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    HStack{
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "line.horizontal.3")
                                .font(.system(size: 22))
                                .foregroundColor(.black)
                        })
                        Spacer(minLength: 0)
                        
                        Button(action: {
                            withAnimation(.spring()){
                                show.toggle()
                            }
                        }, label: {
                            Image("pic")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                        })
                    }
                    Text("Home")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding()
                .padding(.top,eadges!.top)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                
                Spacer(minLength: 0)
                Text(selectedIndex)
                Spacer(minLength: 0)
            }
            //Side menu
            
            HStack(spacing:0){
                Spacer(minLength: 0)
                VStack{
                    HStack{
                        Spacer(minLength: 0)
                        Button(action: {
                            withAnimation(.spring()){
                                show.toggle()
                            }
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 22, weight:.bold))
                                .foregroundColor(.white)
                        })
                    }
                    .padding()
                    .padding(.top,eadges!.top)
                    HStack(spacing:15) {
                        
                        GeometryReader {reader in
                            Image("pic")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                            //for getting midPoint
                            
                                .onAppear(perform: {
                                    self.min = reader.frame(in: .global).minY
                                })
                        }.frame(width: 75, height: 75)
                        
                        VStack(alignment: .leading, content: {
                            Text("Princy")
                                .font(.title)
                                .fontWeight(.semibold)
                            Text("princyvarsani@gmail.com")
                                .fontWeight(.semibold)
                        }).foregroundColor(.white)
                        Spacer(minLength: 0)
                    }.padding(.horizontal)
                    
                    //Menu buttons.....
                    
                    VStack(alignment: .leading,spacing:5, content: {
                        Menubuttons(image: "cart", title: "My Order", selected: $selectedIndex, show: $show)
                        Menubuttons(image: "person", title: "My Profile",selected: $selectedIndex, show: $show)
                        Menubuttons(image: "mappin", title: "Delivery Address",selected: $selectedIndex, show: $show)
                        Menubuttons(image: "creditcard", title: "Payment Method",selected: $selectedIndex, show: $show)
                        Menubuttons(image: "envelope", title: "Contact Us",selected: $selectedIndex, show: $show)
                        Menubuttons(image: "gear", title: "Setting",selected: $selectedIndex, show: $show)
                        Menubuttons(image: "info.circle", title: "Help & FAQs",selected: $selectedIndex, show: $show)
                    })
                    .padding(.top)
                    .padding(.leading,45)
                    
                    Spacer(minLength: 0)
                }.frame(width: width-100)
                .background(Color("bg").clipShape(CustomShape(min: $min)))
                .offset(x: show ? 0 : width - 100)
            }.background(Color.black.opacity(show ? 0.3 : 0))
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct Menubuttons: View {
    var image : String
    var title : String
    @Binding var selected : String
    @Binding var show : Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()){
                selected = title
                show.toggle()
            }
        }, label: {
            HStack(spacing: 15){
                Image(systemName: image)
                    .font(.system(size: 22))
                    .frame(width: 25, height: 25)
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
            }.padding(.vertical)
            .padding(.trailing)
        })
        //For smallest size iPhone....
        .padding(.top,UIScreen.main.bounds.width < 750 ? 0 : 5)
        .foregroundColor(.white)
    }
}

struct CustomShape: Shape{
    @Binding var min : CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            path.move(to: CGPoint(x: rect.width, y:0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 35, y: rect.height))
            path.addLine(to: CGPoint(x: 35, y: 0))
            
            path.move(to: CGPoint(x: 35, y: min - 15))
            path.addQuadCurve(to: CGPoint(x: 35, y: min + 90), control: CGPoint(x: -35, y: min + 35))
        }
    }
}
