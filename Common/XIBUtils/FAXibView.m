//
//  FAXibView.m

#import "FAXibView.h"
#import "FAXibViewUtils.h"


@implementation FAXibView

+ (id)loadFromXib
{
    return [FAXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}
@end
