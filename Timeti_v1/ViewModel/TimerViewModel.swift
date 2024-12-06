//
//  TimerViewModel.swift
//  Timeti_v1
//
//  Created by Juliana Pereira de Magalhães on 01/12/24.
//

import Combine
import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var progress: CGFloat = 0.0
    @Published var isFinished: Bool = false // Indica quando o timer termina
    private var timer: Timer?
    private let totalTime: CGFloat = 6.0 // Tempo total em segundos
    private var currentTime: CGFloat = 0.0
    
    init() {
        startTimer()
    }
    
    func startTimer() {
        resetTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 30.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.currentTime += 1.0 / 30.0
            self.progress = min(self.currentTime / self.totalTime, 1.0)
            
            if self.progress >= 1.0 {
                self.isFinished = true
                self.timer?.invalidate()
            }
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        currentTime = 0.0
        progress = 0.0
        isFinished = false
    }
}

