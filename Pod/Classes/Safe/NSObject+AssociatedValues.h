//
//  NSObject+AssociatedValues.h
//  DiCarpool
//
//  Created by alex on 3/24/15.
//  Copyright (c) 2015 DiDi. All rights reserved.
//

#import "NSObject+AssociatedObjects.h"

@interface NSObject (AssociatedValues)

/* C */
- (float)associatedFloatForKey:(const void *)key;
- (void)associateFloat:(float)value withKey:(const void *)key;
- (double)associatedDoubleForKey:(const void *)key;
- (void)associateDouble:(double)value withKey:(const void *)key;

/* C More */
- (long long)associatedLongLongForKey:(const void *)key;
- (void)associateLongLong:(long long)value withKey:(const void *)key;
- (unsigned long long)associatedUnsignedLongLongForKey:(const void *)key;
- (void)associateUnsignedLongLong:(unsigned long long)value withKey:(const void *)key;

/* OC */
- (BOOL)associatedBOOLForKey:(const void *)key;
- (void)associateBOOL:(BOOL)value withKey:(const void *)key;
- (NSInteger)associatedIntegerForKey:(const void *)key;
- (void)associateInteger:(NSInteger)value withKey:(const void *)key;

/* OC More */
- (NSUInteger)associatedUnsignedIntegerForKey:(const void *)key;
- (void)associateUnsignedInteger:(NSUInteger)value withKey:(const void *)key;

/* OC Object */
- (id)associatedValueForKey:(const void *)key class:(Class)class;

@end
