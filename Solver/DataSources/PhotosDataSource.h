//
//  PhotosDataSource.h
//  Solver
//
//  Created by Sergii Lantratov on 11/13/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


@interface PhotosDataSource : NSObject

+ (PhotosDataSource *)defaultDataSource;

- (NSArray *)allPhotos;

- (UIImage *)photoAtIndex:(NSInteger)index;
- (void)removePhotoFromIndex:(NSInteger)index;
- (void)addPhoto:(UIImage *)photo;
- (void)clearPhotos;

- (void)savePhotos;

@end
