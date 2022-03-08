//
//  InformationViewModel.swift
//  SOSiety
//
//  Created by Natalia Kuznetsova on 18/02/22.
//

import Foundation
import SwiftUI



class InformationScreenViewModel: ObservableObject {
    @Published var engInformationScreens: [InformationScreen] = [
        InformationScreen(icon: "on1-2", heading: "In case of detention, we’ll immediately notify your selected contacts.", description: "When SOS mode is on, we’ll share your location with them (if you allow us) and we’ll also send them clear step-by-step instructions about how to help you."),
        InformationScreen(icon: "on2", heading: "Turn on SOS mode by simply swiping right", description: "Notification sending will be delayed by 30 seconds, therefore a notification will not be sent if the SOS button has been swiped accidentally. You’ll be informed of the notification delivery status: we’ll let you know when the notification is sent, delivered and read. You can also set your shared location update frequency.")
//        InformationScreen(icon: "onboardingImage", heading: "Or use check in mode", description: "We will frequently ask you to check your status with FaceID or password. If you don't do that, we'll start emegency mode automatically."),
//        InformationScreen(icon: "onboardingImage", heading: "Start with adding emergency contacts", description: "Add contacts from the phonebook or choose human rights organisation to notify them in case of arrest.")
    ]
    
    @Published var ruInformationScreens: [InformationScreen] = [
        InformationScreen(icon: "on1-2", heading: "В случае задержания мы немедленно уведомим об этом выбранные контакты.", description: "Когда режим SOS будет включён, мы сообщим им о твоём местонахождении (если ты нам это разрешишь) и мы также дадим им чёткие пошаговые инструкции о том, как тебе помочь."),
        InformationScreen(icon: "on2", heading: "Включи режим SOS просто смахнув вправо", description: "Отправка уведомлений будет отложена на 30 секунд, таким образом они не будут отправлены, если ты смахнул кнопку SOS случайно. Ты будешь проинформирован(а) о состоянии доставки уведомлений: мы сообщим тебе об их отправке, доставке и прочтении.Ты также можешь настроить частоту отправки уведомлений об обновлении твоего местоположения.")
    ]
    
    @Published var frInformationScreens: [InformationScreen] = [
        InformationScreen(icon: "on1-2", heading: "En cas de détention, nous en informerons  immédiatement tes personnes de contact sélectionnées.", description: "Lorsque le mode SOS est activé, nous partagerons ta position avec eux (si tu nous l’autorises) et nous leur enverrons également des instructions claires sur les prochaines étapes à suivre afin de t’aider."),
        InformationScreen(icon: "on2", heading: "Active le mode SOS en swipant simplement vers la droite", description: "L'envoi des notifications sera retardé de 30 secondes, par conséquent, elles ne seront pas envoyée si la touche SOS a été swipé accidentellement. Tu seras informé(e) de l'état de livraison des notifications: nous t’informerons de leur envoi, livraison et lecture. Tu peux également paramétrer la fréquence d’envoi des notification de mise à jour de ta position partagée.")
    ]
}

