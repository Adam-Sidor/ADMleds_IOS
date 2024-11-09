import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            ScrollView {
                Text("Ustawienia")
                    .font(.title)
                    .foregroundColor(Color("Text"))
                VStack{
                    NavigationLink(destination: GeneralSetView()) {
                        Label("Ogólne", systemImage: "gear")
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
                    .padding(.all, 15)
                    Divider()
                        .background(Color("Text"))
                    NavigationLink(destination: DevicesSetView()) {
                        Label("Wi-Fi", systemImage: "wifi")
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
                    .padding(.all,15)
                    Divider()
                        .background(Color("Text"))
                    NavigationLink(destination: DevicesSetView()) {
                        Label("Urządzenia", systemImage: "sensor")
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
                    .padding(.all,15)
                }
                .padding()
                .background(Color("CustomSecondary").opacity(0.5))
                .foregroundColor(Color("Text"))
                .font(.system(size: 20, weight: .semibold))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
