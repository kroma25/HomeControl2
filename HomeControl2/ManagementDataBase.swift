//
//  ManagementDataBase.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 31/05/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit
import CoreData

class ManagementDataBase: UIViewController {

    @IBOutlet var textLabelLogi: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //createData()
    //retrieveData()
    //deleteData()
    //DeleteAllData()
    
    @IBAction func buttonShowDateBase(_ sender: Any) {
        retrieveData()
    }
    
    @IBAction func buttonDeleteAllData(_ sender: Any) {
        DeleteAllData()
        textLabelLogi.text = ""
    }
    
    @IBAction func buttonAddDateBase(_ sender: Any) {
        createData()
        
    }
    
    
    
    func createData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "Lights", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        for i in 1...6 {
            
            let devices = NSManagedObject(entity: userEntity, insertInto: managedContext)
            devices.setValue("Pomieszczenie nr \(i)", forKeyPath: "name")
            devices.setValue(70, forKey: "wat")
            devices.setValue(0.0070, forKey: "kW")
            switch i {
            case 1:
                devices.setValue(100, forKey: "brightness")
                
            case 2:
                devices.setValue(0, forKey: "brightness")
                
            case 3:
                devices.setValue(43, forKey: "brightness")
                
            case 4:
                devices.setValue(20, forKey: "brightness")
                
            case 5:
                devices.setValue(0, forKey: "brightness")
                
            case 6:
                devices.setValue(0, forKey: "brightness")
                
            default:
                
                print("brak danych dla: ",i)
            }
        }
        let devices = NSManagedObject(entity: userEntity, insertInto: managedContext)
        devices.setValue("Kocioł gazowy", forKeyPath: "name")
        devices.setValue(24000, forKey: "wat")
        devices.setValue(24, forKey: "kW")
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func retrieveData() {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Lights")
        
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String," ",data.value(forKey: "brightness") as! Int16)
                textLabelLogi.text.append(data.value(forKey: "name") as! String)
                textLabelLogi.text.append("   kW: ")
                let a:Double = data.value(forKey: "kW") as! Double
                let b:String = String(format:"%f", a)
                textLabelLogi.text.append(b)
                textLabelLogi.text.append("\n")
                
                
                
            }
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    func updateData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Lights")
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur1")
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue("newName", forKey: "username")
            objectUpdate.setValue("newmail", forKey: "email")
            objectUpdate.setValue("newpassword", forKey: "password")
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
    }
    
    func deleteData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Lights")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "Pomieszczenie nr 4")
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    func DeleteAllData(){
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Lights"))
        do {
            try managedContext.execute(DelAllReqVar)
        }
        catch {
            print(error)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
