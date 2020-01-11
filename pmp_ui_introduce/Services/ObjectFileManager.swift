//
//  ObjectFileManager.swift
//  pmp_ui_introduce
//
//  Created by Student on 12/19/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import UIKit

class ObjectFileManager: NSObject {

    var path: URL;

    override init() {
        self.path = ObjectFileManager.privateDocsDir;
        super.init();
    }
    
    static let privateDocsDir: URL = {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask);
        let documentsDirectoryURL = paths.first!.appendingPathComponent("PrivateDocuments");
        do {
            try FileManager.default.createDirectory(at: documentsDirectoryURL, withIntermediateDirectories: true, attributes: nil);
        } catch {
            print("Couldn't create directory");
        }
        
        return documentsDirectoryURL;
    }();
    
    func objectPath<T: EntityBase>(object: T) -> URL {
        return self.objectPath(type: String(describing: type(of: object.self)), id: object.entityId)
    }
       
    func objectPath(type: String, id: Int) -> URL {
        return path.appendingPathComponent(id.description).appendingPathExtension(type);
    }
    
    func createDataPath() throws {
        try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil);
    }
    
    func saveData<T: EntityBase>(object: T, type: String, id: Int) {
        do {
            try createDataPath();
        } catch {
            print("Counldn't create save folder." + error.localizedDescription);
            return;
        }
        
        let codedData = try! NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false);
        
        do {
            try codedData.write(to: self.objectPath(type: type, id: id));
        } catch {
            print("Couldn't write to save file" + error.localizedDescription);
        }
    }
    
    func load<T: EntityBase>(type: String, id: Int) -> T? {
        let path = self.objectPath(type: type, id: id);
        guard let codedData = try? Data(contentsOf: path) else { return nil }
        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedData) as? T;
    }
}
