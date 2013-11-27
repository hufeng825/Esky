//
//  ESBaseModel.m
//  Esquire
//
//  Created by jason on 13-11-15.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESBaseModel.h"
#import <objc/runtime.h>

@implementation ESBaseModel


-(void)encodeWithCoder:(NSCoder *)aCoder{
    //    //encode properties/values
    //    [aCoder encodeObject:self.respCode forKey:@"respCode"];
    //    [aCoder encodeObject:self.respMsg  forKey:@"respMsg"];
    Class clazz = [self class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    
    for (NSString *name in propertyArray)
    {
        id value = [self valueForKey:name];
        [aCoder encodeObject:value forKey:name];
    }
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    //    if((self = [super init])) {
    //        //decode properties/values
    //        self.respCode       = [aDecoder decodeObjectForKey:@"respCode"];
    //        self.respMsg   = [aDecoder decodeObjectForKey:@"respMsg"];
    //    }
    if (self = [super init])
    {
        if (aDecoder == nil)
        {
            return self;
        }
        
        Class clazz = [self class];
        u_int count;
        
        objc_property_t* properties = class_copyPropertyList(clazz, &count);
        NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i < count ; i++)
        {
            const char* propertyName = property_getName(properties[i]);
            [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        }
        free(properties);
        
        for (NSString *name in propertyArray)
        {
            id value = [aDecoder decodeObjectForKey:name];
            [self setValue:value forKey:name];
        }
    }
    return self;
}
@end
