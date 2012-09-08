#import <MapKit/MapKit.h>
#ifdef DEBUG
#   define BYLOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define BYLOG(...)
#endif


extern int const CBY_NumberOfQuizesPerRound;

extern BOOL       CLLocationCoordinateAreEqual(CLLocationCoordinate2D lhs, CLLocationCoordinate2D rhs);
extern NSString * NSStringFromCLLocationCoordinate2d(CLLocationCoordinate2D coord);
extern NSString * const SigToMain;


/// notifications:
extern NSString * NBY_ApplicationDidEnterForeGround;
extern NSString * NBY_ApplicationDidEnterBackGround;

/// NSUderDefaultsSettings
extern NSString * const UDBY_SoundEnabled;
extern NSString * const UDBY_StandartUserDefaultsLoaded;