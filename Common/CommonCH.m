//
//  COMMONIMPORT.h
//  jason

//
//  Copyright 2013 Studio. All rights reserved.
//


#import "CommonCH.h"


BOOL TTIsStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]]&& [(NSString*)object length] > 0 && object !=nil ;}