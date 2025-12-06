import Foundation
struct Habit {
    var habitName:String
    var weeklyGoal: Int
    var logs:[Date] = []
    let calendar = Calendar.current
    var today: Date { Date() }
    
   
    
    init(habitName: String, weeklyGoal: Int, logs: [Date] = []) {
        self.habitName = habitName
        if weeklyGoal < 1 {
            print("Weekly goal cannot be negative or zero. Setting it to 1. You can change it later if you want.")
            self.weeklyGoal = 1
        }
        else {
            self.weeklyGoal = weeklyGoal
        }
        self.logs = logs
    }
    
    mutating func logCompletion(on date: Date) {
        if logs.contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
            if calendar.isDate(date, inSameDayAs: today) {
                print("You already logged this today! Take a break!")
            }
            else {
                print("You've already logged your habit for this day before!")
            }
        }
        else {
            logs.append(date)
            if calendar.isDate(date, inSameDayAs: today) {
                print("Congrats on completing your habit for today! Keep going!")
            }
            else {
                print("Keep the streak going! I've added this date to your log")
            }
        }
    }
        // calculating # of attempts past 7 days
        var completionsThisWeek:Int {
            
            var daysThisWeek = 0

            for loggedDay in logs{
                if let dayDiff = calendar.dateComponents([.day], from: loggedDay, to: today).day {
                    if dayDiff < 7 && dayDiff >= 0 {
                        daysThisWeek += 1
                    }
                }
            }
            if daysThisWeek == 0 {
                print("You haven't logged this habit in the past 7 days")
            }
            return daysThisWeek
        }
        
        //CLAMPING PROGRESS BETWEEN 0.0 and 1.0
        var progress: Double {
            if completionsThisWeek <= weeklyGoal {
                return Double(completionsThisWeek)/Double(weeklyGoal)
            }
            else {
                return 1.0
            }
        }
           
    }
    
    

