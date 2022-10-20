//
//  ViewModel.swift
//  Mini#01
//
//  Created by Sarah dos Santos Silva on 12/09/22.
//

import Foundation
import SwiftUI

let ruidosTxt: LocalizedStringKey = "ruidos"
let sonsTxt: LocalizedStringKey = "sons"
let sensorTxt: LocalizedStringKey = "sensor de barulho"
let micTxt: LocalizedStringKey = "microfone"
let concederMicTxt: LocalizedStringKey = "não foi concedido acesso ao microfone para esse aplicativo. Habilite o microfone nas configurações do sistema"
let cancelarTxt: LocalizedStringKey = "cancelar"
let configTxt: LocalizedStringKey = "configurações"
let reiniciaSensorTxt: LocalizedStringKey = "o sensor capta barulhos altos e reinicia o timer do último som selecionado. O microfone ficará ligado apenas quando o sensor estiver ligado"
let horasTxt: LocalizedStringKey = "horas"
let alertaTxt: LocalizedStringKey = "alerta"
let acabaTimerTxt: LocalizedStringKey = "seu timer acabou"
let iniciarTxt: LocalizedStringKey = "iniciar"
let pausaTxt: LocalizedStringKey = "pausa"

var ruidos = [Ruidos(imagem: "0", nome: "aspirador", id: 0, audio: "aspirador", background: "aspirador"),
              Ruidos(imagem: "1", nome: "coracao", id: 1, audio: "coracao", background: "coracao"),
              Ruidos(imagem: "2", nome: "chuva", id: 2, audio: "chuva", background: "chuva"),
              Ruidos(imagem: "3", nome: "lagoa", id: 3, audio: "lagoa", background: "lagoa"),
              Ruidos(imagem: "4", nome: "lareira", id: 4, audio: "lareira", background: "lareira"),
              Ruidos(imagem: "5", nome: "mar", id: 5, audio: "mar", background: "mar"),
              Ruidos(imagem: "6", nome: "ronrom", id: 6, audio: "ronrom", background: "ronrom"),
              Ruidos(imagem: "7", nome: "secador", id: 7, audio: "secador", background: "secador"),
              Ruidos(imagem: "8", nome: "shh", id: 8, audio: "shh", background: "shh"),
              Ruidos(imagem: "9", nome: "tv", id: 9, audio: "tv", background: "tv"),
              Ruidos(imagem: "10", nome: "utero", id: 10, audio: "utero", background: "utero"),
              Ruidos(imagem: "11", nome: "vento", id: 11, audio: "vento", background: "vento")
]
