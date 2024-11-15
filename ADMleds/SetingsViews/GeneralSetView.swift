import SwiftUI

struct GeneralSetView: View {
    @State var devices: [Device] = []
    @State var nightModeBrightness = 50.0
    @State var edit: Bool = false
    var body: some View {
        ZStack{
            Color("Background")
            VStack{
                VStack{
                    Label("Jasność trybu nocnego: \(Int(nightModeBrightness))", systemImage: "moon.stars.fill")
                        .foregroundStyle(Color("Text"))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.headline)
                    Slider(
                        value: $nightModeBrightness,
                        in: 0...100,
                        onEditingChanged: { isEditing in
                            if !isEditing{
                                sendToAllDevices(devices: devices, varName: "nightbrightness", value: Int(nightModeBrightness))
                            }
                        }
                    )
                    .tint(Color("CustomAccent"))
                }
                .padding()
                .background(Color("CustomSecondary").opacity(0.8))
                .cornerRadius(10)
                .padding(.top, 100)
                
                Spacer()
            }
            .padding()
            
        }
        .ignoresSafeArea()
        .onAppear(){
            devices = readDevices(fileName: "devices.json") ?? []
        }
        .navigationTitle("Ogólne")
    }
}

#Preview {
    GeneralSetView()
}
