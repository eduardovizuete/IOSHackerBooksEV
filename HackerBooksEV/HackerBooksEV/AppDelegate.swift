//
//  AppDelegate.swift
//  HackerBooksEV
//
//  Created by usuario on 2/3/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Crear una window de verdad
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Crear una instancia del modelo
        do {
            // array de diccionarios de json
            let json = try downloadAndSaveJSONFile()
            
            // Crear un array de clases de Swift
            var books = [Book]()
            //var setTags = tagType()
            var setTags = Set<Tag>()
            
            for dict in json {
                do {
                    let aBook = try decode(book: dict)
                    books.append(aBook)
                    setTags = setTags.union(aBook.tags)
                } catch {
                    print("Error al procesar \(dict)")
                }
            }
            
            var arrayOrderTags = [Tag]()

            for tag in setTags.sorted() {
                arrayOrderTags.append(tag)
            }
            
            // Ahora podemos crear el modelo
            let model = Library.init(books: books.sorted(), tags: arrayOrderTags)
            
            // Crear el LibraryTableViewController
            let lVC = LibraryTableViewController(model: model)
            lVC.title = "Hacker Books"
            
            // Insertar en un Nav
            let lNav = UINavigationController(rootViewController: lVC)
           
            // Establecer root window
            window?.rootViewController = lNav
            
            // Mostrar la window
            window?.makeKeyAndVisible()
            
            return true
            
        } catch {
            fatalError("Error while loading Model fo JSON")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

