//
//  swizzling.h
//  Segway
//
//  Created by Arnaud Coomans on 02/02/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

void __attribute__((weak)) MethodSwizzle(Class c, SEL origSEL, SEL overrideSEL);
