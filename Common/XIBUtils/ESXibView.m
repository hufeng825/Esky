//
//  FAXibView.m

#import "ESXibView.h"
#import "ESXibViewUtils.h"


@implementation ESXibView

+ (id)loadFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}
@end
