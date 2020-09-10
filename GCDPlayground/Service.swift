//
//  Service.swift
//  GCDPlayground
//
//  Created by Mohamed Korany on 9/9/20.
//  Copyright © 2020 Mohamed Korany. All rights reserved.
//

import Foundation
class Service {
    
    let queue = DispatchQueue(label: "Some serial queue")
    
    /*DispatchWorkItem is used to store a task on a dispatch queue for later use, and you can perform operations several operations on it, you can even cancel the task if it is not required later in the code.*/
    func doNetworkItem() {
        
        
        let newWorkItem = DispatchWorkItem {
            
            for i in 0..<5 {
                print(i)
                
            }
            
        }
        
        
        // task 1
        queue.async(execute: newWorkItem)
        
        
        // Task 2
        queue.asyncAfter(deadline: DispatchTime.now() + 1, execute: newWorkItem)
        
        // Work Item Cancel
        newWorkItem.cancel()
        
        // Task 3
        queue.async(execute: newWorkItem)
        
        if newWorkItem.isCancelled {
            print("Task was cancelled")
        }
        /*only one task is executed, the rest of them were cancelled as Task 2 was supposed to execute after a second, and Task 3 was initialized after cancelling the work item.*/
    }
}
