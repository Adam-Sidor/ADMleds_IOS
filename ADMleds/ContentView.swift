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
    func getRGBComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat)? {
        let uiColor = UIColor(self)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        return (red, green, blue)
    }
}

func saveToFile(array: [[String]], fileName: String) {
    if let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = docsURL.appendingPathComponent(fileName)
        do {
            let JSONdata = try JSONEncoder().encode(array)
            try JSONdata.write(to: fileURL)
        } catch {
            print("Błąd podczas zapisu tablicy: \(error)")
        }
    }
}

func readFromFile(fileName: String) -> [[String]]? {
    if let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = docsURL.appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            let array = try JSONDecoder().decode([[String]].self, from: data)
            return array
        } catch {
            print("Błąd podczas odczytu tablicy: \(error)")
        }
    }
    return nil
}


struct ContentView: View {    
    @State var red: String = "255"
    @State var green: String = "255"
    @State var blue: String = "255"
    @State var color: Color = .red
    
    enum LedMode: String, CaseIterable, Identifiable {
        case Tęcza_argb, Tęcza_rgb
        var id: Self { self }
    }
    @State var selectedLedMode: LedMode = .Tęcza_argb
    @State var whichSelectedLedMode: Int = 1
    
    @State var devices: [[String]] = []
    
    var body: some View {
        NavigationStack {
            ZStack{
                /*LinearGradient(gradient: Gradient(colors: [Color("CustomPrimary"), Color("CustomAccent")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()*/
                Color("Background")
                    .ignoresSafeArea()
                VStack {
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
                        .background(Color("CustomSecondary").opacity(0.5))
                        .cornerRadius(12)
                        Spacer()
                    }
                    .padding(.bottom, 30)
                    VStack{
                        HStack{
                            VStack{
                                Spacer()
                                Text("Wybierz tryb:")
                                    .font(.system(size: 17, weight: .light))
                                Picker("Led Mode",selection: $selectedLedMode){
                                    ForEach(LedMode.allCases){ledMode in
                                        Text(ledMode.rawValue)
                                    }
                                    .onChange(of: selectedLedMode) {
                                        switch(selectedLedMode){
                                        case .Tęcza_argb:
                                            whichSelectedLedMode=1
                                        case .Tęcza_rgb:
                                            whichSelectedLedMode=2
                                        }
                                        
                                    }
                                }
                                .padding(.top, -10)
                            }
                            .padding()
                            .frame(maxWidth: .infinity,maxHeight: 80)
                            .background(Color("Background").opacity(0.8))
                            .accentColor(Color("CustomPrimary"))
                            .foregroundStyle(Color("CustomPrimary"))
                            .cornerRadius(8)
                            Button {
                                refreshColors()
                            } label: {
                                VStack{
                                    Image(systemName: "arrow.trianglehead.2.clockwise")
                                        .font(.system(size: 25, weight: .light))
                                    Text("Odśwież")
                                        .font(.system(size: 12, weight: .light))
                                }
                                .padding()
                                .frame(maxWidth: .infinity,maxHeight: 80)
                                .background(Color("Background").opacity(0.8))
                                .foregroundStyle(Color("CustomPrimary"))
                                .cornerRadius(8)
                            }
                            
                        }
                        ColorPicker("Wybierz kolor:", selection: $color)
                            .padding(.all, 10)
                            .foregroundStyle(Color("CustomPrimary"))
                            .background(Color("Background").opacity(0.8))
                            .cornerRadius(8)
                    }
                    .padding()
                    .background(Gradient(colors: [Color("CustomPrimary"), Color("CustomAccent")]))
                    .cornerRadius(12)
                    .padding(.bottom, 20)
                    VStack{
                        Text("Ledy Kolor:")
                            .font(.system(size: 25, weight: .light))
                            .foregroundStyle(Color("Text"))
                            .frame(maxWidth: .infinity,alignment: .leading)
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
                                .frame(maxWidth: .infinity,maxHeight: 65)
                                .background(Color("CustomPrimary"))
                                .foregroundStyle(Color("Background").opacity(0.8))
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
                                .frame(maxWidth: .infinity,maxHeight: 65)
                                .background(Color("CustomPrimary"))
                                .foregroundStyle(Color("Background").opacity(0.8))
                                .cornerRadius(8)
                            }
                        }
                        .padding(.bottom, 15)
                        Text("Ledy Białe:")
                            .font(.system(size: 25, weight: .light))
                            .foregroundStyle(Color("Text"))
                            .frame(maxWidth: .infinity,alignment: .leading)
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
                                .frame(maxWidth: .infinity,maxHeight: 65)
                                .background(Color("CustomPrimary"))
                                .foregroundStyle(Color("Background").opacity(0.8))
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
                                .frame(maxWidth: .infinity,maxHeight: 65)
                                .background(Color("CustomPrimary"))
                                .foregroundStyle(Color("Background").opacity(0.8))
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                    .background(Color("CustomSecondary").opacity(0.5))
                    .cornerRadius(12)
                    VStack{
                        Text("Tryb nocny:")
                            .font(.system(size: 25, weight: .light))
                            .foregroundStyle(Color("Text"))
                            .frame(maxWidth: .infinity,alignment: .leading)
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
                                .frame(maxWidth: .infinity,maxHeight: 65)
                                .background(Color("CustomPrimary"))
                                .foregroundStyle(Color("Background").opacity(0.8))
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
                                .frame(maxWidth: .infinity,maxHeight: 65)
                                .background(Color("CustomPrimary"))
                                .foregroundStyle(Color("Background").opacity(0.8))
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                    .background(Color("CustomSecondary").opacity(0.5))
                    .cornerRadius(12)
                    Spacer()
                }
                .padding()
            }
            .onAppear(){
                devices = readFromFile(fileName: "devices.json") ?? []
            }
            //.navigationTitle("LED control panel")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .foregroundStyle(Color("CustomPrimary"))
                }
            }
        }
    }
    
    func refreshColors(){
        if let rgbComponents = color.getRGBComponents() {
            red = String(Int(rgbComponents.red * 255))
            green = String(Int(rgbComponents.green * 255))
            blue = String(Int(rgbComponents.blue * 255))
        }
    }
    
}

#Preview {
    ContentView()
}
