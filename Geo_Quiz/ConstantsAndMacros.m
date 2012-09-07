NSString * NSStringFromCLLocationCoordinate2d(CLLocationCoordinate2D coord) {
    return [NSString stringWithFormat:@"Location Coordinate: \n {lat: %f, long: %f}", coord.latitude, coord.longitude];
}

const double CBY_CLLocationCoordinateEpsilon = 0.1f;
BOOL       CLLocationCoordinateAreEqual(CLLocationCoordinate2D lhs, CLLocationCoordinate2D rhs) {
    return
    (fabs(lhs.latitude - rhs.latitude) <= CBY_CLLocationCoordinateEpsilon
     && fabs(lhs.longitude - rhs.longitude) <= CBY_CLLocationCoordinateEpsilon);
}


NSString * const SigToMain = @"sToMain";

NSString * NBY_ApplicationDidEnterForeGround = @"NBY_ApplicationDidEnterForeGround";
NSString * NBY_ApplicationDidEnterBackGround = @"NBY_ApplicationDidEnterBackGround";


NSString * const UDBY_SoundEnabled = @"UDBY_SoundEnabled";
NSString * const UDBY_StandartUserDefaultsLoaded = @"UDBY_StandartUserDefaultsLoaded";