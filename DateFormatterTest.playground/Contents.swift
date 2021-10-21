//import UIKit
//
//let data = "2021-05-02T10:11:15Z"
//
//var dataformatada = DateFormatter()
//dataformatada.locale = Locale(identifier: "pt_BR")
//dataformatada.dateFormat = "dd-MM-yyyy"
//let date = dataformatada.date(from: data)
//print(date)

//import UIKit
//
//let data = "2021-05-02T10:11:15Z"
//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//let result : Date = dateFormatter.date(from: data) ?? .now
//print(result)
//dateFormatter.dateStyle = .short
//dateFormatter.locale = Locale(identifier: "pt_BR")
//let final = dateFormatter.string(from: result) ?? "......"
//print(final)


//print(dateFormatter.date(from: data) ?? "No date retrieved")

//dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//dateFormatter.date(from: data)
//print(dateFormatter)

import UIKit

var valor = 211334.78
print(valor)
var texto = String(format: "%.2f", valor)
print("texto: \(texto)")
var textofinal = texto.replacingOccurrences(of: ".", with: ",")
print("texto: \(textofinal)")
var count = 6
while (textofinal.count > count ) {
    print("texto 1: \(textofinal.count)")
    print("count 2: \(count)")
    if (textofinal.count > count) {
        textofinal.insert(".", at: textofinal.index(textofinal.endIndex, offsetBy: -count))
    }
    count += 4
    print("texto: \(textofinal)")
}
print("texto: \(textofinal)")
//
//var number = 364123.45
//var text = String(format: "%.2f", number)
//
//var textofinal = text.replacingOccurrences(of: ".", with: ",")
//print("text: \(textofinal)")

//var i = 3
//var result = textofinal.count - i
//print(result)
//if (result % 3 != 0 || result == ) {
//    print ("diferente de zero")
//    textofinal.insert(".", at: textofinal.index(textofinal.endIndex, offsetBy: -(i * 2)))
//}
//print("text: \(textofinal)")


//var count = -6
//for i in stride(from: textofinal.count - 3, through: 0, by: -3) {
//        textofinal.insert(".", at: textofinal.index(textofinal.endIndex, offsetBy: count))
//    count -= 3
//    print("text: \(textofinal)")
//
//}
