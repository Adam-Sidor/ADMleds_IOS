import SwiftUI

struct Device: Codable {
    var name:String
    var IP:String
    var enabled:Bool
    var edit:Bool
    var icon:String
}

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

func save2DStringToFile(array: [[String]], fileName: String) {
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

func read2DStringFromFile(fileName: String) -> [[String]]? {
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

func save1DBoolToFile(array: [Bool], fileName: String) {
    let fileManager = FileManager.default
    
    if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(array)
            
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }
}

func read1DBoolFromFile(fileName: String) -> [Bool]? {
    let fileManager = FileManager.default
    
    if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            // Odczyt danych z pliku
            let data = try Data(contentsOf: fileURL)
            
            // Dekodowanie danych
            let decoder = JSONDecoder()
            let tablica = try decoder.decode([Bool].self, from: data)
            
            return tablica
        } catch {
            print(error)
        }
    }
    return nil
}

func saveDevices(devices: [Device],fileName: String) {
    let fileManager = FileManager.default
    if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(devices)
            
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }
}

func readDevices(fileName: String) -> [Device]? {
    let fileManager = FileManager.default
    if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                
                let decoder = JSONDecoder()
                let devices = try decoder.decode([Device].self, from: data)
                return devices
            } catch {
                print(error)
            }
        }
    }
    return nil
}



func sendHttp(_ url:String, _ subUrl: String,_ value:Int) -> String {
    var resultText: String = ""
    let valueString: String = String(value)
    guard let url = URL(string: "http://"+url+"/"+subUrl+"="+valueString) else {
        resultText = "Nieprawidłowy URL"
        return resultText
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            DispatchQueue.main.async {
                resultText = "Błąd: \(error.localizedDescription)"
            }
            return
        }
        
        if data != nil {
            DispatchQueue.main.async {
                resultText = "Udalo sie!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    resultText = "Wprowadz podstrone i wyslij zapytanie"
                }
            }
        }
    }
    
    task.resume()
    return resultText
}

func sendToAllDevices(devices: [Device],varName: String, value: Int){
    if !devices.isEmpty{
        for device in devices{
            if device.enabled == true{
                _ = sendHttp(device.IP, varName, value)
            }
        }
    }
}


@main
struct ADMledsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
