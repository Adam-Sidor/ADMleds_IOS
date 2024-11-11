import SwiftUI

struct DevicesSetView: View {
    @State var devices: [Device] = []
    @State var showAddDeviceForm: Bool = false
    @State var deviceName: String = ""
    @State var IPAddress: String = ""
    @State var isFormEmpty: Bool = false
    @State var showDeleteAlert: Bool = false
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
                            Toggle(isOn: $devices[index].enabled) {
                                Text(devices[index].name + ": " + devices[index].IP)
                                    .onTapGesture {
                                        devices[index].edit.toggle()
                                    }
                            }
                            
                            .padding()
                        }
                        if devices[index].edit {
                            VStack{
                                Section(header: Text("Edytuj urządzenie")){
                                    TextField("Nazwa urządzenia", text: $devices[index].name)
                                        .padding()
                                        .background(Color("CustomSecondary").opacity(0.8))
                                        .cornerRadius(8)
                                    TextField("Adres IP", text: $devices[index].IP)
                                        .padding()
                                        .background(Color("CustomSecondary").opacity(0.8))
                                        .cornerRadius(8)
                                    Button{
                                        showDeleteAlert=true
                                    }
                                    label: {
                                        Text("Usuń urządzenie")
                                    }
                                    .padding()
                                    .background(.red)
                                    .foregroundStyle(Color("Background").opacity(0.8))
                                    .cornerRadius(8)
                                    .alert(isPresented: $showDeleteAlert) {
                                        Alert(title: Text("Czy na pewno chcesz usunąć urządzenie?"),
                                            message: nil,
                                            primaryButton:
                                                .destructive(Text("Usuń")) {
                                                    devices.remove(at: index)
                                                },
                                            secondaryButton:
                                                .cancel(Text("Anuluj"))
                                        )
                                    }
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
            saveDevices(devices: devices, fileName: "devices.json")
        }
        .onAppear(){
            devices = readDevices(fileName: "devices.json") ?? []
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
                            devices.append(Device(name: deviceName, IP: IPAddress, enabled: true, edit: false))
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
