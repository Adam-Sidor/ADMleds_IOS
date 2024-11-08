import SwiftUI
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
struct ContentView: View {
    @State var red: String = "255"
    @State var green: String = "255"
    @State var blue: String = "255"
    @State var color: Color = .red
    var body: some View {
        NavigationStack {
            ZStack{
                /*LinearGradient(gradient: Gradient(colors: [Color(hex: 0x7DBAF2), Color(hex: 0x3e25fe)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()*/
                Color(hex: 0x011020)
                    .ignoresSafeArea()
                ScrollView {
                    HStack{
                        Spacer()
                        HStack{
                            Text("Red: "+red)
                                .foregroundStyle(.red)
                                .font(.system(size: 20, weight: .bold))
                            Text("Green: "+green)
                                .foregroundStyle(.green)
                                .font(.system(size: 20, weight: .bold))
                            Text("Blue: "+blue)
                                .foregroundStyle(.blue)
                                .font(.system(size: 20, weight: .bold))
                        }
                        .padding()
                        .background(Color(hex: 0x4304A7).opacity(0.5))
                        .cornerRadius(12)
                        Spacer()
                    }
                    .padding(.bottom, 30)
                    VStack{
                        HStack{
                            Button {
                                //
                                
                            } label: {
                                VStack{
                                    Image(systemName: "lightspectrum.horizontal")
                                        .font(.system(size: 25, weight: .light))
                                    Text("Wybierz tryb")
                                        .font(.system(size: 12, weight: .light))
                                }
                                .padding()
                                .frame(maxWidth: .infinity,maxHeight: 80)
                                .background(Color(hex: 0x011020).opacity(0.8))
                                .foregroundStyle(Color(hex: 0x7dbaf2))
                                .cornerRadius(8)
                            }
                            Button {
                                //
                            } label: {
                                VStack{
                                    Image(systemName: "arrow.trianglehead.2.clockwise")
                                        .font(.system(size: 25, weight: .light))
                                    Text("Odśwież")
                                        .font(.system(size: 12, weight: .light))
                                }
                                .padding()
                                .frame(maxWidth: .infinity,maxHeight: 80)
                                .background(Color(hex: 0x011020).opacity(0.8))
                                .foregroundStyle(Color(hex: 0x7dbaf2))
                                .cornerRadius(8)
                            }
                            
                        }
                        .padding(.bottom, 10)
                        ColorPicker("Wybierz kolor:", selection: $color)
                            .foregroundStyle(Color(hex: 0x011020).opacity(0.8))
                        
                    }
                    .padding()
                    .background(Gradient(colors: [Color(hex: 0x7DBAF2), Color(hex: 0x3e25fe)]))
                    .cornerRadius(12)
                    .padding(.bottom, 20)
                    VStack{
                        Text("Ledy Kolor:")
                            .font(.system(size: 25, weight: .light))
                            .foregroundStyle(Color(hex: 0xe1f0fe))
                        HStack{
                            Button {
                                //
                            } label: {
                                HStack{
                                    Text("Włącz")
                                        .font(.system(size: 20, weight: .bold))
                                    Image(systemName: "lightbulb.max.fill")
                                        .font(.system(size: 25, weight: .light))
                                }
                                .padding()
                                .frame(maxWidth: .infinity,maxHeight: 80)
                                .background(Color(hex: 0x7dbaf2))
                                .foregroundStyle(Color(hex: 0x011020).opacity(0.8))
                                .cornerRadius(8)
                            }
                            Button {
                                //
                            } label: {
                                HStack{
                                    Text("Wyłącz")
                                        .font(.system(size: 20, weight: .bold))
                                    Image(systemName: "lightbulb")
                                        .font(.system(size: 25, weight: .light))
                                }
                                .padding()
                                .frame(maxWidth: .infinity,maxHeight: 80)
                                .background(Color(hex: 0x7dbaf2))
                                .foregroundStyle(Color(hex: 0x011020).opacity(0.8))
                                .cornerRadius(8)
                            }
                        }
                        .padding(.bottom, 25)
                        Text("Ledy Białe:")
                            .font(.system(size: 25, weight: .light))
                            .foregroundStyle(Color(hex: 0xe1f0fe))
                        HStack{
                            Button {
                                //
                            } label: {
                                HStack{
                                    Text("Włącz")
                                        .font(.system(size: 20, weight: .bold))
                                    Image(systemName: "lightbulb.max.fill")
                                        .font(.system(size: 25, weight: .light))
                                }
                                .padding()
                                .frame(maxWidth: .infinity,maxHeight: 80)
                                .background(Color(hex: 0x7dbaf2))
                                .foregroundStyle(Color(hex: 0x011020).opacity(0.8))
                                .cornerRadius(8)
                            }
                            Button {
                                //
                            } label: {
                                HStack{
                                    Text("Wyłącz")
                                        .font(.system(size: 20, weight: .bold))
                                    Image(systemName: "lightbulb")
                                        .font(.system(size: 25, weight: .light))
                                }
                                .padding()
                                .frame(maxWidth: .infinity,maxHeight: 80)
                                .background(Color(hex: 0x7dbaf2))
                                .foregroundStyle(Color(hex: 0x011020).opacity(0.8))
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                    .background(Color(hex: 0x4304a9).opacity(0.5))
                    .cornerRadius(12)
                    VStack{
                        Text("Tryb nocny:")
                            .font(.system(size: 25, weight: .light))
                            .foregroundStyle(Color(hex: 0xe1f0fe))
                        HStack{
                            Button {
                                //
                            } label: {
                                HStack{
                                    Text("Włącz")
                                        .font(.system(size: 20, weight: .bold))
                                    Image(systemName: "light.beacon.min")
                                        .font(.system(size: 25, weight: .light))
                                }
                                .padding()
                                .frame(maxWidth: .infinity,maxHeight: 80)
                                .background(Color(hex: 0x7dbaf2))
                                .foregroundStyle(Color(hex: 0x011020).opacity(0.8))
                                .cornerRadius(8)
                            }
                            Button {
                                //
                            } label: {
                                HStack{
                                    Text("Wyłącz")
                                        .font(.system(size: 20, weight: .bold))
                                    Image(systemName: "light.beacon.max")
                                        .font(.system(size: 25, weight: .light))
                                }
                                .padding()
                                .frame(maxWidth: .infinity,maxHeight: 80)
                                .background(Color(hex: 0x7dbaf2))
                                .foregroundStyle(Color(hex: 0x011020).opacity(0.8))
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                    .background(Color(hex: 0x4304a9).opacity(0.5))
                    .cornerRadius(12)
                    Spacer()
                }.padding()
            }
            //.navigationTitle("LED control panel")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
