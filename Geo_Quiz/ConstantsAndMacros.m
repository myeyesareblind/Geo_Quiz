#import <math.h>
NSString * NSStringFromCLLocationCoordinate2d(CLLocationCoordinate2D coord) {
    return [NSString stringWithFormat:@"Location Coordinate: \n {lat: %f, long: %f}", coord.latitude, coord.longitude];
}

const double CBY_CLLocationCoordinateEpsilon = 0.1f;
BOOL       CLLocationCoordinateAreEqual(CLLocationCoordinate2D lhs, CLLocationCoordinate2D rhs) {
    return
    (fabs(lhs.latitude - rhs.latitude) <= CBY_CLLocationCoordinateEpsilon
     && fabs(lhs.longitude - rhs.longitude) <= CBY_CLLocationCoordinateEpsilon);
}

inline
CLLocationCoordinate2D CLLocationCoordinate2DInfinity() {
    return CLLocationCoordinate2DMake(INFINITY, INFINITY);
}


NSString * const SigToMain = @"sToMain";

NSString * NBY_ApplicationDidEnterForeGround = @"NBY_ApplicationDidEnterForeGround";
NSString * NBY_ApplicationDidEnterBackGround = @"NBY_ApplicationDidEnterBackGround";

/// User Defauls
NSString * const UDBY_SoundEnabled               = @"UDBY_SoundEnabled";
NSString * const UDBY_StandartUserDefaultsLoaded = @"UDBY_StandartUserDefaultsLoaded";
NSString * const UDBY_UserName                   = @"UDBY_UserName";
NSString * const UDBY_DefaultUserName            = @"Player";

int const CBY_NumberOfQuizesPerRound = 3;