NSString * NSStringFromCLLocationCoordinate2d(CLLocationCoordinate2D coord) {
    return [NSString stringWithFormat:@"Location Coordinate: \n {lat: %f, long: %f}", coord.latitude, coord.longitude];
}

NSString * const SigToMain = @"sToMain";

NSString * NBY_ApplicationDidEnterForeGround = @"NBY_ApplicationDidEnterForeGround";
NSString * NBY_ApplicationDidEnterBackGround = @"NBY_ApplicationDidEnterBackGround";