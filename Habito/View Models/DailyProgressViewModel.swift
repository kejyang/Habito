//
//  DailyProgressViewModel.swift
//  Habito
//
//  Created by Kenneth Yang on 2/15/25.
//

import Foundation


class DailyProgressViewModel: ObservableObject {
    @Published var dailyProgress : Double?
    @Published var weekProgress : [Double]?
    @Published var stepsWeekProgress : Int?
    let dailyProgressManager = DailyProgressManager()
    
    
    func setDailyProgress(accountId : Int){
        dailyProgress = dailyProgressManager.getDailyProgress(accountId: accountId)
    }
    
    func setWeekProgress(accountId : Int){
        weekProgress = dailyProgressManager.getWeeklyProgress(accountId: accountId)
    }
    
    func setStepsWeekProgress(accountId : Int) {
        stepsWeekProgress = dailyProgressManager.getStepsWeeklyProgress(accountId: accountId)
    }
    
}
