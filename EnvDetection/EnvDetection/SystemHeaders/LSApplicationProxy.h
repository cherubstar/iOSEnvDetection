//
//  LSApplicationProxy.h
//  EnvDetection
//
//  Created by 小七 on 2023/3/27.
//

#ifndef LSApplicationProxy_h
#define LSApplicationProxy_h

@interface LSApplicationProxy : NSObject <NSSecureCoding> {
    NSArray * _activityTypes;
    NSString * _applicationVariant;
    long  _bundleModTime;
    NSString * _companionApplicationIdentifier;
    NSString * _complicationPrincipalClass;
    NSArray * _deviceFamily;
    NSString * _deviceIdentifierVendorName;
    NSNumber * _downloaderDSID;
    NSNumber * _familyID;
    NSString * _genre;
    NSNumber * _genreID;
    unsigned int  _installType;
    NSNumber * _itemID;
    NSString * _itemName;
    NSString * _minimumSystemVersion;
    unsigned int  _originalInstallType;
    NSArray * _plugInKitPlugins;
    NSArray * _pluginUUIDs;
    NSString * _preferredArchitecture;
    NSArray * _privateDocumentIconNames;
    LSApplicationProxy * _privateDocumentTypeOwner;
    NSNumber * _purchaserDSID;
    NSString * _ratingLabel;
    NSNumber * _ratingRank;
    NSDate * _registeredDate;
    NSString * _sdkVersion;
    NSString * _shortVersionString;
    NSString * _sourceAppIdentifier;
    NSNumber * _storeFront;
    NSArray * _supportedComplicationFamilies;
    NSString * _teamID;
    BOOL  _userInitiatedUninstall;
    NSString * _vendorName;
    NSNumber * _versionID;
    NSString * _watchKitVersion;
}

@property (nonatomic, readonly) NSNumber *ODRDiskUsage;
@property (nonatomic, readonly) NSArray *UIBackgroundModes;
@property (nonatomic, readonly) NSArray *VPNPlugins;
@property (nonatomic, readonly) NSArray *activityTypes;
@property (nonatomic, readonly) NSArray *appTags;
@property (nonatomic, readonly) NSString *applicationDSID;
@property (nonatomic, readonly) NSString *applicationIdentifier;
@property (nonatomic, readonly) NSString *applicationType;
@property (nonatomic, readonly) NSString *applicationVariant;
@property (nonatomic, readonly) NSArray *audioComponents;
@property (nonatomic, readonly) NSNumber *betaExternalVersionIdentifier;
@property (nonatomic, readonly) long bundleModTime;
@property (nonatomic, readonly) NSString *companionApplicationIdentifier;
@property (readonly) NSString *complicationPrincipalClass;
@property (nonatomic, readonly) NSArray *deviceFamily;
@property (nonatomic, readonly) NSUUID *deviceIdentifierForAdvertising;
@property (nonatomic, readonly) NSUUID *deviceIdentifierForVendor;
@property (nonatomic, readonly) NSArray *directionsModes;
@property (nonatomic, readonly) NSNumber *downloaderDSID;
@property (nonatomic, readonly) NSNumber *dynamicDiskUsage;
@property (nonatomic, readonly) NSArray *externalAccessoryProtocols;
@property (nonatomic, readonly) NSNumber *externalVersionIdentifier;
@property (nonatomic, readonly) NSNumber *familyID;
@property (nonatomic, readonly) BOOL fileSharingEnabled;
@property (getter=isGameCenterEnabled, nonatomic, readonly) BOOL gameCenterEnabled;
@property (nonatomic, readonly) BOOL gameCenterEverEnabled;
@property (nonatomic, readonly) NSString *genre;
@property (nonatomic, readonly) NSNumber *genreID;
@property (readonly) BOOL hasComplication;
@property (nonatomic, readonly) BOOL hasCustomNotification;
@property (nonatomic, readonly) BOOL hasGlance;
@property (nonatomic, readonly) BOOL hasMIDBasedSINF;
@property (nonatomic, readonly) BOOL hasSettingsBundle;
@property (nonatomic, readonly) BOOL iconIsPrerendered;
@property (nonatomic, readonly) NSProgress *installProgress;
@property (nonatomic, readonly) unsigned int installType;
@property (nonatomic, readonly) BOOL isAdHocCodeSigned;
@property (nonatomic, readonly) BOOL isAppUpdate;
@property (nonatomic, readonly) BOOL isBetaApp;
@property (nonatomic, readonly) BOOL isInstalled;
@property (nonatomic, readonly) BOOL isLaunchProhibited;
@property (nonatomic, readonly) BOOL isNewsstandApp;
@property (nonatomic, readonly) BOOL isPlaceholder;
@property (nonatomic, readonly) BOOL isPurchasedReDownload;
@property (nonatomic, readonly) BOOL isRestricted;
@property (nonatomic, readonly) BOOL isStickerProvider;
@property (nonatomic, readonly) BOOL isWatchKitApp;
@property (nonatomic, readonly) NSNumber *itemID;
@property (nonatomic, readonly) NSString *itemName;
@property (nonatomic, readonly) NSString *minimumSystemVersion;
@property (nonatomic, readonly) BOOL missingRequiredSINF;
@property (nonatomic, readonly) unsigned int originalInstallType;
@property (nonatomic, readonly) NSArray *plugInKitPlugins;
@property (nonatomic, readonly) NSString *preferredArchitecture;
@property (nonatomic, readonly) NSNumber *purchaserDSID;
@property (nonatomic, readonly) NSString *ratingLabel;
@property (nonatomic, readonly) NSNumber *ratingRank;
@property (nonatomic, readonly) NSDate *registeredDate;
@property (getter=isRemoveableSystemApp, nonatomic, readonly) BOOL removeableSystemApp;
@property (getter=isRemovedSystemApp, nonatomic, readonly) BOOL removedSystemApp;
@property (nonatomic, readonly) NSArray *requiredDeviceCapabilities;
@property (nonatomic, readonly) NSString *sdkVersion;
@property (nonatomic, readonly) NSString *shortVersionString;
@property (nonatomic, readonly) BOOL shouldSkipWatchAppInstall;
@property (nonatomic, readonly) NSString *sourceAppIdentifier;
@property (nonatomic, readonly) NSNumber *staticDiskUsage;
@property (nonatomic, readonly) NSArray *staticShortcutItems;
@property (nonatomic, readonly) NSString *storeCohortMetadata;
@property (nonatomic, readonly) NSNumber *storeFront;
@property (nonatomic, readonly) NSArray *subgenres;
@property (readonly) NSArray *supportedComplicationFamilies;
@property (nonatomic, readonly) BOOL supportsAudiobooks;
@property (nonatomic, readonly) BOOL supportsExternallyPlayableContent;
@property (nonatomic, readonly) BOOL supportsODR;
@property (nonatomic, readonly) BOOL supportsOpenInPlace;
@property (nonatomic, readonly) BOOL supportsPurgeableLocalStorage;
@property (nonatomic, readonly) NSString *teamID;
@property (nonatomic) BOOL userInitiatedUninstall;
@property (nonatomic, readonly) NSString *vendorName;
@property (nonatomic, readonly) NSString *watchKitVersion;
@property (getter=isWhitelisted, nonatomic, readonly) BOOL whitelisted;

+ (id)applicationProxyForBundleURL:(id)arg1;
+ (id)applicationProxyForCompanionIdentifier:(id)arg1;
+ (id)applicationProxyForIdentifier:(id)arg1;
+ (id)applicationProxyForIdentifier:(id)arg1 placeholder:(BOOL)arg2;
+ (id)applicationProxyForItemID:(id)arg1;
+ (id)applicationProxyWithBundleUnitID:(unsigned int)arg1;
+ (id)iconQueue;
+ (BOOL)supportsSecureCoding;

- (id)ODRDiskUsage;
- (id)UIBackgroundModes;
- (BOOL)UPPValidated;
- (id)VPNPlugins;
- (id)_initWithBundleUnit:(unsigned int)arg1 applicationIdentifier:(id)arg2;
- (id)activityTypes;
- (id)alternateIconName;
- (id)appState;
- (id)appTags;
- (id)applicationDSID;
- (id)applicationIdentifier;
- (id)applicationType;
- (id)applicationVariant;
- (id)audioComponents;
- (id)betaExternalVersionIdentifier;
- (long)bundleModTime;
- (void)clearAdvertisingIdentifier;
- (id)companionApplicationIdentifier;
- (id)complicationPrincipalClass;
- (void)dealloc;
- (id)description;
- (id)deviceFamily;
- (id)deviceIdentifierForAdvertising;
- (id)deviceIdentifierForVendor;
- (id)directionsModes;
- (id)diskUsage;
- (id)downloaderDSID;
- (id)dynamicDiskUsage;
- (void)encodeWithCoder:(id)arg1;
- (id)externalAccessoryProtocols;
- (id)externalVersionIdentifier;
- (id)familyID;
- (BOOL)fileSharingEnabled;
- (BOOL)gameCenterEverEnabled;
- (id)genre;
- (id)genreID;
- (BOOL)hasComplication;
- (BOOL)hasCustomNotification;
- (BOOL)hasGlance;
- (BOOL)hasMIDBasedSINF;
- (BOOL)hasSettingsBundle;
- (id)iconDataForVariant:(int)arg1;
- (id)iconDataForVariant:(int)arg1 preferredIconName:(id)arg2 withOptions:(int)arg3;
- (id)iconDataForVariant:(int)arg1 withOptions:(int)arg2;
- (BOOL)iconIsPrerendered;
- (id)iconStyleDomain;
- (id)initWithCoder:(id)arg1;
- (id)installProgress;
- (id)installProgressSync;
- (unsigned int)installType;
- (BOOL)isAdHocCodeSigned;
- (BOOL)isAppUpdate;
- (BOOL)isBetaApp;
- (BOOL)isGameCenterEnabled;
- (BOOL)isInstalled;
- (BOOL)isLaunchProhibited;
- (BOOL)isNewsstandApp;
- (BOOL)isPlaceholder;
- (BOOL)isPurchasedReDownload;
- (BOOL)isRemoveableSystemApp;
- (BOOL)isRemovedSystemApp;
- (BOOL)isRestricted;
- (BOOL)isStickerProvider;
- (BOOL)isSystemOrInternalApp;
- (BOOL)isWatchKitApp;
- (BOOL)isWhitelisted;
- (id)itemID;
- (id)itemName;
- (id)localizedName;
- (id)localizedNameForContext:(id)arg1;
- (id)localizedShortName;
- (id)minimumSystemVersion;
- (BOOL)missingRequiredSINF;
- (unsigned int)originalInstallType;
- (id)plugInKitPlugins;
- (id)preferredArchitecture;
- (id)primaryIconDataForVariant:(int)arg1;
- (id)privateDocumentIconNames;
- (id)privateDocumentTypeOwner;
- (BOOL)profileValidated;
- (id)purchaserDSID;
- (id)ratingLabel;
- (id)ratingRank;
- (id)registeredDate;
- (id)requiredDeviceCapabilities;
- (id)resourcesDirectoryURL;
- (id)sdkVersion;
- (void)setAlternateIconName:(id)arg1 withResult:(id /* block */)arg2;
- (void)setPrivateDocumentIconNames:(id)arg1;
- (void)setPrivateDocumentTypeOwner:(id)arg1;
- (void)setUserInitiatedUninstall:(BOOL)arg1;
- (id)shortVersionString;
- (BOOL)shouldSkipWatchAppInstall;
- (id)sourceAppIdentifier;
- (id)staticDiskUsage;
- (id)staticShortcutItems;
- (id)storeCohortMetadata;
- (id)storeFront;
- (id)subgenres;
- (id)supportedComplicationFamilies;
- (BOOL)supportsAudiobooks;
- (BOOL)supportsExternallyPlayableContent;
- (BOOL)supportsODR;
- (BOOL)supportsOpenInPlace;
- (BOOL)supportsPurgeableLocalStorage;
- (id)teamID;
- (id)uniqueIdentifier;
- (BOOL)userInitiatedUninstall;
- (id)vendorName;
- (id)watchKitVersion;

// Image: /System/Library/Frameworks/Intents.framework/Intents

- (BOOL)_inapptrust_isFirstParty;

// Image: /System/Library/Frameworks/UIKit.framework/UIKit

//- (struct CGSize { float x1; float x2; })_defaultStyleSize:(id)arg1;

// Image: /System/Library/PrivateFrameworks/ChatKit.framework/ChatKit

- (id)__ck_messagesPluginKitProxy;

// Image: /System/Library/PrivateFrameworks/ManagedConfiguration.framework/MDM.framework/MDM

+ (BOOL)applicationProxyIsMISAuthorizedForBundleID:(id)arg1;

- (BOOL)isMISAuthorized;

// Image: /System/Library/PrivateFrameworks/TVMLKit.framework/TVMLKit

+ (id)tvmlKitBundle;

- (id)tv_applicationLaunchImageName;

// Image: /System/Library/PrivateFrameworks/UserNotificationsServer.framework/UserNotificationsServer

+ (id)uns_bundleForBundleIdentifier:(id)arg1;

- (BOOL)_uns_isReallyInstalled;
- (id)uns_bundle;
- (BOOL)uns_isSystemApplication;
- (id)uns_path;
- (BOOL)uns_requiresLocalNotifications;
- (BOOL)uns_sdkVersionOnOrLaterThan:(id)arg1;
- (BOOL)uns_shouldUseDefaultDataProvider;
- (BOOL)uns_usesCloudKit;
- (BOOL)uns_usesLocalNotifications;

@end

#endif /* LSApplicationProxy_h */
