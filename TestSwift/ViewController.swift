//
//  ViewController.swift
//  TestSwift
//
//  Created by 雷勇 on 14-11-17.
//  Copyright (c) 2014年 __FULLNAME__. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var tableview:UITableView!
    var arr:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arr = NSMutableArray();
        for (var i=1; i<=50; i++){
            arr[i-1] = "data \(i)"
        }
    }

    @IBAction func editButtonClick(item:UIBarButtonItem){
        var editing = !self.tableview.editing
        self.tableview.setEditing(editing, animated: true);
        if editing == true{
            item.title = "done";
        }else{
            item.title = "edit";
        }
    }
    
    @IBAction func addButtonClick(item:UIBarButtonItem){
        var row = self.arr.count
        var indexPath = NSIndexPath(forRow:row,inSection:0)
        self.arr.addObject(String(format: "data %d", row+1))
        self.tableview.insertRowsAtIndexPaths(NSArray(object: indexPath), withRowAnimation: UITableViewRowAnimation.Left)
        self.tableview.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arr.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ViewController") as UITableViewCell
        cell.textLabel?.text = arr[indexPath.row] as NSString;
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        let alert = UIAlertController(title: "提示", message:NSString(format: "%@ 被点击", arr[indexPath.row] as NSString), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //删除行
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            arr.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths(NSArray(object: indexPath), withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    //移动行
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true;
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle{
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath){
        var destStr = arr[destinationIndexPath.row] as NSString;
        arr.removeObjectAtIndex(destinationIndexPath.row);
        arr.insertObject(destStr, atIndex: sourceIndexPath.row);
    }
}

