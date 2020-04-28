//
//  ToDoDB.swift
//  ToDo
//
//  Created by YangMinUk on 28/04/2020.
//  Copyright © 2020 MinUkYang. All rights reserved.
//

import Foundation
import SQLite3

class ToDoDB{
    
    enum SQLError: Error {
       case connectionError
       case queryError
       case otherError
     }
    
    var db : OpaquePointer? //db를 가리키는 포인터

    
    let createTableString = """
    CREATE TABLE IF NOT EXISTS ToDo(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Work CHAR(255),
    Done INT);
    """
    let insertStatementString = "INSERT INTO ToDo (Work, Done) VALUES (?, ?);"
    
    let queryStatementString = "SELECT * FROM ToDo;"
    
    let path: String = {
      let fm = FileManager.default
      return fm.urls(for:.libraryDirectory, in:.userDomainMask).last!
               .appendingPathComponent("ToDo.db").path
    }()
    
    init() throws{ //생성자
        if sqlite3_open(path,&db) == SQLITE_OK {
            if sqlite3_exec(db, createTableString,nil,nil,nil) == SQLITE_OK {
                return
            }
        }
        throw SQLError.connectionError
    }
    
    func insertToDo(work : String){
        var stmt: OpaquePointer? //query를 가리키는 포인터
        
        if sqlite3_prepare(db, insertStatementString, -1, &stmt, nil) == SQLITE_OK{
            sqlite3_bind_text(stmt, 1, work, -1, nil)
            sqlite3_bind_int(stmt, 2, 0) //0 is false
            if sqlite3_step(stmt) == SQLITE_DONE{
                print("\nInsert row Success")
            }else{
                print("\nInsert row Faild")
            }
        }else{
            print("\nInsert Statement is not prepared")
        }
        sqlite3_finalize(stmt)
    }
    
    func updateToDo(id: Int, isSelected : Bool){
        
    }
    func deleteToDo(id: Int) {
        
    }
    func fetchToDo() -> [ToDoItem]{
        var items : [ToDoItem] = []
        var stmt: OpaquePointer? //query를 가리키는 포인터
        
        if sqlite3_prepare(db, queryStatementString, -1, &stmt, nil) == SQLITE_OK{
            while(sqlite3_step(stmt) == SQLITE_ROW){
                let idResult = sqlite3_column_int(stmt, 0)
                guard let workResult = sqlite3_column_text(stmt, 1) else {
                    continue
                }
                let isSelectedResult = sqlite3_column_int(stmt, 2)
                let work = String(cString: workResult)
                let isSelected = isSelectedResult == 1 ? true : false
                
                let item = ToDoItem(id: Int(idResult), working: work, isSelected: isSelected)
                items.append(item)
            }
        }else{
            print("query is not prepared")
        }
        
        sqlite3_finalize(stmt)
        return items
    }
    
    deinit { //클래스의 인스턴스가 해제되기 전 호출
        sqlite3_close(db)
    }
}
