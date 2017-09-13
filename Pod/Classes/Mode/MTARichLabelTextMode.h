//
//  MTARichLabelTextMode.h
//  Pods
//
//  Created by 余卓 on 2017/9/13.
//
//

#import <Foundation/Foundation.h>
#import "MTARichStyleMode.h"

@interface MTARichLabelTextMode : NSObject

/** desc */
@property (nonatomic,strong) NSString *desc;

/** styleArray */
@property (nonatomic,strong) NSMutableArray<MTARichStyleMode *> *styleArray;


@end
