//
// Copyright 2009-2010 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "Three20/TTHighlightBorderStyle.h"

// Style
#import "Three20/TTStyleContext.h"
#import "Three20/TTShape.h"

// Core
#import "Three20/TTCorePreprocessorMacros.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTHighlightBorderStyle

@synthesize color           = _color;
@synthesize highlightColor  = _highlightColor;
@synthesize width           = _width;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNext:(TTStyle*)next {
  if (self = [super initWithNext:next]) {
    _width = 1;
  }

  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_color);
  TT_RELEASE_SAFELY(_highlightColor);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class public


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (TTHighlightBorderStyle*)styleWithColor:(UIColor*)color highlightColor:(UIColor*)highlightColor
                                    width:(CGFloat)width next:(TTStyle*)next {
  TTHighlightBorderStyle* style = [[[self alloc] initWithNext:next] autorelease];
  style.color = color;
  style.highlightColor = highlightColor;
  style.width = width;
  return style;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTStyle


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)draw:(TTStyleContext*)context {
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGContextSaveGState(ctx);

  {
    CGRect strokeRect = CGRectInset(context.frame, _width/2, _width/2);
    strokeRect.size.height-=2;
    strokeRect.origin.y++;
    [context.shape addToPath:strokeRect];

    [_highlightColor setStroke];
    CGContextSetLineWidth(ctx, _width);
    CGContextStrokePath(ctx);
  }

  {
    CGRect strokeRect = CGRectInset(context.frame, _width/2, _width/2);
    strokeRect.size.height-=2;
    [context.shape addToPath:strokeRect];

    [_color setStroke];
    CGContextSetLineWidth(ctx, _width);
    CGContextStrokePath(ctx);
  }

  context.frame = CGRectInset(context.frame, _width, _width * 2);
  return [self.next draw:context];
}


@end
