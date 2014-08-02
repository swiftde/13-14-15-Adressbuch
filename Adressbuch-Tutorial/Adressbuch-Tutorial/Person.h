//
//  Person.h
//  Adressbuch-Tutorial
//
//  Created by Benjamin Herzog on 02.07.14.
//  Copyright (c) 2014 Benjamin Herzog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * nachname;
@property (nonatomic, retain) NSString * telnr;
@property (nonatomic, retain) NSString * stadt;
@property (nonatomic, retain) NSString * plz;
@property (nonatomic, retain) NSString * strasse;
@property (nonatomic, retain) NSString * vorname;

@end
