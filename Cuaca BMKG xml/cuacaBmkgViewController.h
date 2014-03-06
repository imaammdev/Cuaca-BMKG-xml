//
//  cuacaBmkgViewController.h
//  Cuaca BMKG xml
//
//  Created by Herman Tolle on 3/4/14.
//  Copyright (c) 2014 Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cuacaBmkgViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>

@property (nonatomic,strong) NSMutableArray *timetableDictionaries;
@property (nonatomic,strong) NSMutableArray *tableData;
@property (nonatomic,strong) NSMutableArray *cuaca;
@property (nonatomic,strong) NSMutableDictionary *currentTimetableDictionary;
@property (nonatomic,copy) NSString *currentElementName;

@end
