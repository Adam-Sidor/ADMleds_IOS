import SwiftUI

struct DevicesSetView: View {
    @State var devices: [[String]] = []
    @State var editDevice: [Bool] = []
    @State var enabledDevice: [Bool] = [true]
    @State var showAddDeviceForm: Bool = false
    @State var deviceName: String = ""
    @State var IPAddress: String = ""
    @State var isFormEmpty: Bool = false
    var body: some View {
        ZStack{
            Color("Background")
                .ignoresSafeArea()
            VStack{
                if devices.isEmpty {
                    Text("Brak urządzeń")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }else{
                    ForEach(devices.indices, id:\.self) { index in
                        HStack{
                            Image(systemName: "person.crop.circle")
                            Toggle(isOn: $enabledDevice[index]) {
                                Text(devices[index][0] + ": " + devices[index][1])
                                    .onTapGesture {
                                        editDevice[index].toggle()
                                    }
                            }
                            
                            .padding()
                        }
                        if editDevice[index] {
                            VStack{
                                Section(header: Text("Edytuj urządzenie")){
                                    TextField("Nazwa urządzenia", text: $devices[index][0])
                                        .padding()
                                        .background(Color("CustomSecondary").opacity(0.8))
                                        .cornerRadius(8)
                                    TextField("Adres IP", text: $devices[index][1])
                                        .padding()
                                        .background(Color("CustomSecondary").opacity(0.8))
                                        .cornerRadius(8)
                                }
                            }
                            .padding()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
            }
            .padding()

        }
        .onDisappear{
            save2DStringToFile(array: devices, fileName: "devices.json")
        }
        .onAppear(){
            devices = read2DStringFromFile(fileName: "devices.json") ?? []
            for _ in 0..<devices.count{
                editDevice.append(false)
            }
        }
        .navigationTitle("Urządzenia")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button{
                    showAddDeviceForm.toggle()
                }label: {
                    Label("Dodaj urządzenie", systemImage: "plus")
                        .foregroundStyle(Color("CustomPrimary"))
                }
            }
        }
        .sheet(isPresented: $showAddDeviceForm){
            NavigationStack {
                Form {
                    Section(header: Text("Urządzenie")) {
                        TextField("Nazwa urządzenia", text: $deviceName)
                        TextField("Adres IP", text: $IPAddress)

                    }
                }
                .frame(maxHeight: 150)
                VStack{
                    Button("Zatwierdź") {
                        if deviceName.isEmpty || IPAddress.isEmpty {
                            isFormEmpty = true
                        }
                        else{
                            devices.append([deviceName, IPAddress])
                            editDevice.append(false)
                            deviceName.removeAll()
                            IPAddress.removeAll()
                            showAddDeviceForm=false
                        }
                    }
                    .alert("Nie podano wszystkich danych",isPresented: $isFormEmpty) {
                        Button("OK",role: .cancel) {}
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("CustomPrimary"))
                    .foregroundColor(Color("Background").opacity(0.9))
                    .cornerRadius(10)
                    Button("Anuluj") {
                        deviceName.removeAll()
                        IPAddress.removeAll()
                        showAddDeviceForm=false
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(.red))
                    .cornerRadius(10)
                    Spacer()
                }
                .padding()
                .navigationTitle("Dodaj urządzenie")
            }
        }
    }
}



#Preview {
    DevicesSetView()
}
