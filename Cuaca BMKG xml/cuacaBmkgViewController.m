//
//  cuacaBmkgViewController.m
//  Cuaca BMKG xml
//
//  Created by Herman Tolle on 3/4/14.
//  Copyright (c) 2014 Lab. All rights reserved.
//

#import "cuacaBmkgViewController.h"

@interface cuacaBmkgViewController ()

@end

@implementation cuacaBmkgViewController


@synthesize timetableDictionaries;
@synthesize currentElementName;
@synthesize currentTimetableDictionary;
@synthesize tableData;
@synthesize cuaca;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURL *namaurl = [[NSURL alloc] initWithString:@"http://data.bmkg.go.id/cuaca_indo_1.xml"];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:namaurl];
    [parser setDelegate:self];
    [parser parse];
    tableData  = [[NSMutableArray alloc] init];
    cuaca  = [[NSMutableArray alloc] init];
    for (NSMutableArray *feed in timetableDictionaries) {
        NSString *namaKota = [feed valueForKey:@"Kota"];
        NSString *keadaancuaca = [feed valueForKey:@"Cuaca"];
        [cuaca addObject:keadaancuaca];
        [tableData addObject:namaKota];
      
    }
    
    NSLog(@"%@",tableData);
  
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"inicell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [cuaca objectAtIndex:indexPath.row];
    return cell;
}






// parse data dari xml kemudian dijadikan array

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.timetableDictionaries = [NSMutableArray array];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.currentElementName = elementName;
    if ([elementName isEqualToString:@"Row"]) {
        self.currentTimetableDictionary = [NSMutableDictionary dictionary];
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.currentElementName) {
        NSString *existingCharacters = self.currentTimetableDictionary[self.currentElementName] ? : @"";
        NSString *nextCharacters = [existingCharacters stringByAppendingString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([nextCharacters length] > 0) {
            self.currentTimetableDictionary[self.currentElementName] = nextCharacters;
        }
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Row"]) {
        [self.timetableDictionaries addObject:self.currentTimetableDictionary];
        self.currentTimetableDictionary = nil;
    }
    self.currentElementName = nil;
}







@end
