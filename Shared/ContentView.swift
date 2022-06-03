//
//  ContentView.swift
//  Shared
//
//  Created by Tariq Almazyad on 6/3/22.
//

import SwiftUI
import LoremSwiftum

struct ContentView: View {
    @State var myPets: [String] = [
        "bird1",
        "bird2",
        "bird3",
        "bird4",
        "bird5",
        "bird6",
    ]
    
    @State var isShowingCommentsView: Bool = false
    @State var commentText: String = ""
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                TabView{
                    ForEach(myPets, id:\.self) { pet in
                        Image(pet)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 360, height: 260)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding()
                            .offset(y: -20)
                        // Fixer for  control the space btn the paging index and the content top
                    }
                }.tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .frame(height: 320) // Can control the space btn the paging index and the content top
                    .padding(.top)
                
                HStack{
                    VStack{
                        Text("Cat")
                            .font(.title)
                        Text("Riyadh")
                            .font(.callout)
                    }.padding(.leading, 24)
                    Spacer()
                    VStack(alignment: .center){
                        Text("Need Help")
                            .foregroundColor(.orange)
                        Text("\(Date())")
                            .foregroundColor(.secondary)
                            .font(.caption2)
                            .frame(width: 140)
                            .multilineTextAlignment(.center)
                    }
                }.padding(.horizontal)
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.2))
                    .frame(width: UIScreen.main.bounds.width - 10, height: 1)
                
                
                HStack{
                    VStack{
                        Text("Health")
                            .font(.title)
                            .foregroundColor(.cyan)
                        Text("Behavior")
                            .font(.callout)
                            .foregroundColor(.cyan)
                    }.padding(.leading, 14)
                    Spacer()
                    VStack(alignment: .center){
                        Text("Need Help")
                            .foregroundColor(.orange)
                        Text("Healthy")
                            .foregroundColor(.secondary)
                            .font(.caption2)
                    }
                }.padding(.horizontal)
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.2))
                    .frame(width: UIScreen.main.bounds.width - 10, height: 1)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Details")
                            .font(.title)
                            .foregroundColor(.cyan)
                            .multilineTextAlignment(.leading)
                        Text(Lorem.tweet)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .multilineTextAlignment(.leading)
                    Spacer()
                }.padding()
                
                Button {
                    withAnimation {
                        isShowingCommentsView.toggle()
                    }
                } label: {
                    Text("Help Pet")
                        .frame(width: 200, height: 40)
                                        .background(Color.yellow.cornerRadius(5))
                                        .foregroundColor(.black)
                                }
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.2))
                    .frame(width: UIScreen.main.bounds.width - 10, height: 1)
                    .opacity(isShowingCommentsView ? 1 : 0)
                
                if isShowingCommentsView {
                    LazyVStack {
                        ForEach(0 ..< 20) { item in
                            HStack(alignment: .top){
                                VStack(alignment: .center){
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 20, height: 20)
                                    Text(Lorem.firstName)
                                        .minimumScaleFactor(0.5)
                                    Text(Lorem.lastName)
                                        .minimumScaleFactor(0.5)
                                }.frame(width: 80)
                                Text(Lorem.tweet)
                                    .padding(12)
                                    .background(Color.blue.cornerRadius(12, corners: [.topRight, .bottomLeft, .bottomRight]))
                                    .padding(.top, 8)
                                    .padding(.trailing, 12)
                                
                            }.padding(6)
                        }
                        Divider()
                            .padding()
                    }.padding(.top)
                        .padding(.bottom, 64)
                }
                
            }
            .overlay(
                overlayView
                ,alignment: .bottom
            ).navigationTitle("Sample Proj")
        }
    }
    
    private var overlayView: some View {
        HStack{
            TextField("Write a comment", text: $commentText)
            Divider()
                .frame(height: 20)
                .padding(0)
            Button {
                
            } label: {
                Image(systemName: "paperplane.fill")
            }
            
        }.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white, lineWidth: 0.4)
            ).padding()
            .background(Material.ultraThinMaterial)
            .opacity(isShowingCommentsView ? 1: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
