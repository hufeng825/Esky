//
//  ESXibViewUtils.h

#import <UIKit/UIKit.h>

@interface ESXibViewUtils : NSObject

+ (id)loadViewFromXibNamed:(NSString *)xibName withFileOwner:(id)fileOwner;

//  the view must not have any connecting to the file owner
+ (id)loadViewFromXibNamed:(NSString *)xibName;
@end
