//
//  PhotosDataSource.m
//  Solver
//
//  Created by Sergii Lantratov on 11/13/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//

#import "PhotosDataSource.h"
#import "Constants.h"


static PhotosDataSource *dataSource = nil;


@interface PhotosDataSource ()

@property (nonatomic, strong) NSMutableArray *photos;

@end


@implementation PhotosDataSource

#pragma mark - Initialization

+ (PhotosDataSource *)defaultDataSource
{
    if (nil == dataSource)
    {
        dataSource = [[super allocWithZone:NULL] init];
    }
    
    return dataSource;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultDataSource];
}

- (id)init
{
    if (nil != dataSource)
    {
        return dataSource;
    }
    
    self = [super init];
    
    if (self)
    {
        self.photos = [NSMutableArray new];
    }
    
    return self;
}


#pragma mark - Private methods

- (void)notifyStorageUpdated:(NSString *)updateKind
{
    NSDictionary *updateInfo = [NSDictionary dictionaryWithObject:updateKind forKey:UPDATE_KIND_KEY];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PHOTOS_UPDATE_NOTIFICATION
                                                        object:nil userInfo:updateInfo];
}


#pragma mark - Public methods

- (NSArray *)allPhotos
{
    return self.photos;
}

- (UIImage *)photoAtIndex:(NSInteger)index
{
    if ((index >= 0) && (index < self.photos.count))
    {
        return [self.photos objectAtIndex:index];
    }
    
    return nil;
}

- (void)removePhotoFromIndex:(NSInteger)index
{
    if ((index >= 0) && (index < self.photos.count))
    {
        [self.photos removeObjectAtIndex:index];
        [self notifyStorageUpdated:REMOVE_PHOTO_UPDATE];
    }
}

- (void)addPhoto:(UIImage *)photo
{
    if (photo != nil)
    {
        [self.photos addObject:photo];
        [self notifyStorageUpdated:ADD_PHOTO_UPDATE];
    }
}

- (void)clearPhotos
{
    [self.photos removeAllObjects];
    [self notifyStorageUpdated:CLEAR_PHOTOS_UPDATE];
}

- (void)savePhotos
{
    //
}

@end
