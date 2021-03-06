//
//  DataBuffer.m
//  Aural
//
//  Created by Karl Stenerud on 2/27/11.
//
// Copyright 2011 Karl Stenerud
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// Note: You are NOT required to make the license available from within your
// iOS application. Including it in your project is sufficient.
//
// Attribution is not required, but appreciated :)
//

#import "DataBuffer.h"


@implementation DataBuffer

+ (DataBuffer*) bufferWithLength:(unsigned int) numBytes
{
	return [[[self alloc] initWithLength:numBytes] autorelease];
}

+ (DataBuffer*) bufferWithLength:(unsigned int) numBytes
				   freeOnDealloc:(bool) freeOnDealloc
{
	return [[[self alloc] initWithLength:numBytes freeOnDealloc:freeOnDealloc] autorelease];
}

+ (DataBuffer*) bufferWithData:(void*) data
					  numBytes:(unsigned int) numBytes
				 freeOnDealloc:(bool) freeOnDealloc
{
	return [[[self alloc] initWithData:data
							  numBytes:numBytes
						 freeOnDealloc:freeOnDealloc] autorelease];
}

- (id) initWithLength:(unsigned int) numBytes
{
	return [self initWithLength:numBytes freeOnDealloc:YES];
}

- (id) initWithLength:(unsigned int) numBytes
		freeOnDealloc:(bool) freeOnDealloc
{
	if(nil != (self = [super init]))
	{
		_data = malloc(numBytes);
		if(nil == _data)
		{
			NSLog(@"Error: Could not allocate %d bytes of memory", numBytes);
			[self release];
			return nil;
		}
		_numBytes = numBytes;
		_freeOnDealloc = freeOnDealloc;
	}
	return self;
}

- (id) initWithData:(void*) data
		   numBytes:(unsigned int) numBytes
	  freeOnDealloc:(bool) freeOnDealloc
{
	if(nil != (self = [super init]))
	{
		_data = data;
		_numBytes = numBytes;
		_freeOnDealloc = freeOnDealloc;
	}
	return self;
}

- (void) dealloc
{
	if(nil != _data && _freeOnDealloc)
	{
		free(_data);
	}
	[super dealloc];
}

@synthesize data = _data;
@synthesize numBytes = _numBytes;
@synthesize freeOnDealloc = _freeOnDealloc;

@end
