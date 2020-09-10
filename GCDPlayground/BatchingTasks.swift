//
//  BatchingTasks.swift
//  GCDPlayground
//
//  Created by Mohamed Korany on 9/9/20.
//  Copyright © 2020 Mohamed Korany. All rights reserved.
//

import Foundation
class BatchingTasks {
    /*The purpose of dispatch groups is to let you know when several independent tasks have completed.
     DispatchGroup
     A group of tasks that you monitor as a single unit.
     */
    
    func doGrouping() {
        let queue = DispatchQueue(label: "Serial queue")
        let group = DispatchGroup()

        queue.async(group: group) {
            sleep(1)
            print("Task 1 done")
        }

        queue.async(group: group) {
            sleep(2)
            print("Task 2 done")
        }

        
        group.wait()

        // will execute after finish all group queues as long as we have group.wait
        print("All tasks done")
    }





/*DispatchGroup manages dispatch groups. Using dispatch groups, we can create groups of multiple tasks and either wait for them to complete or receive a notification once they complete*/
func dispatchGroupNotify(){
    // Create a group
    let dispatchGroup = DispatchGroup()
    let queue1 = DispatchQueue(label: "com.kentakodashima.app.sampleQueue1")
    let queue2 = DispatchQueue(label: "com.kentakodashima.app.sampleQueue2")
    let queue3 = DispatchQueue(label: "com.kentakodashima.app.sampleQueue3")
    
    
    let lastQueue = DispatchQueue(label: "last.one")
    // Put all queues into dispatchGroup
    queue1.async(group: dispatchGroup) {
        sleep(1)
      print("Queue1 complete.")
        
    }
    queue2.async(group: dispatchGroup) {
        sleep(2)
      print("Qqueue2 complete.")
    }
    queue3.async(group: dispatchGroup) {
      print("Queue3 complete.")
    }
    // After the queues in dispatchGroup are all done, back to the main thread
    dispatchGroup.notify(queue: lastQueue) {
        sleep(1)
      print("In last queue")
    }
}
    
    /*we can specify when to enter into the group tasks and when to leave. dispatchGroup.enter() and dispatchGroup.leave() are completed.*/
        func specifyOnThreadEnterBydispatchGroup() {
            DispatchQueue.global(qos: .default).async {
              var result = 0
              let array = [1, 4, 5, 8]
              let dispatchGroup = DispatchGroup()
                print("enter")
            dispatchGroup.enter()
              for element in array {
                sleep(1)
                result += element
              }
             
               print("wait 5 seconds before leave")
                sleep(5)
                
              dispatchGroup.leave()
             print("leave")
                
          
             
              DispatchQueue.main.async {
                print("result of the group \(result)")
              }
            }
        }

    }

