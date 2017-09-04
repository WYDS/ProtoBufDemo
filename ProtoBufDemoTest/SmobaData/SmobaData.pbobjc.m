// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: SmobaData.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

 #import "SmobaData.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - SmobaDataRoot

@implementation SmobaDataRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - SmobaDataRoot_FileDescriptor

static GPBFileDescriptor *SmobaDataRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@""
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - RoomInfoPB

@implementation RoomInfoPB

@dynamic roomType;
@dynamic roomData;

typedef struct RoomInfoPB__storage_ {
  uint32_t _has_storage_[1];
  RoomInfoPB_PVPRoomType roomType;
  NSString *roomData;
} RoomInfoPB__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "roomType",
        .dataTypeSpecific.enumDescFunc = RoomInfoPB_PVPRoomType_EnumDescriptor,
        .number = RoomInfoPB_FieldNumber_RoomType,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(RoomInfoPB__storage_, roomType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldHasEnumDescriptor),
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "roomData",
        .dataTypeSpecific.className = NULL,
        .number = RoomInfoPB_FieldNumber_RoomData,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(RoomInfoPB__storage_, roomData),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[RoomInfoPB class]
                                     rootClass:[SmobaDataRoot class]
                                          file:SmobaDataRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(RoomInfoPB__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\002\001\010\000\002H\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t RoomInfoPB_RoomType_RawValue(RoomInfoPB *message) {
  GPBDescriptor *descriptor = [RoomInfoPB descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:RoomInfoPB_FieldNumber_RoomType];
  return GPBGetMessageInt32Field(message, field);
}

void SetRoomInfoPB_RoomType_RawValue(RoomInfoPB *message, int32_t value) {
  GPBDescriptor *descriptor = [RoomInfoPB descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:RoomInfoPB_FieldNumber_RoomType];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum RoomInfoPB_PVPRoomType

GPBEnumDescriptor *RoomInfoPB_PVPRoomType_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "PvproomType5V51\000PvproomType5V52\000PvproomT"
        "ype5V53\000PvproomType3V3\000PvproomType1V1\000";
    static const int32_t values[] = {
        RoomInfoPB_PVPRoomType_PvproomType5V51,
        RoomInfoPB_PVPRoomType_PvproomType5V52,
        RoomInfoPB_PVPRoomType_PvproomType5V53,
        RoomInfoPB_PVPRoomType_PvproomType3V3,
        RoomInfoPB_PVPRoomType_PvproomType1V1,
    };
    static const char *extraTextFormatInfo = "\005\000d\n\201\000\001d\n\201\000\002d\n\201\000\003d\n\000\004d\n\000";
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(RoomInfoPB_PVPRoomType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:RoomInfoPB_PVPRoomType_IsValidValue
                              extraTextFormatInfo:extraTextFormatInfo];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL RoomInfoPB_PVPRoomType_IsValidValue(int32_t value__) {
  switch (value__) {
    case RoomInfoPB_PVPRoomType_PvproomType5V51:
    case RoomInfoPB_PVPRoomType_PvproomType5V52:
    case RoomInfoPB_PVPRoomType_PvproomType5V53:
    case RoomInfoPB_PVPRoomType_PvproomType3V3:
    case RoomInfoPB_PVPRoomType_PvproomType1V1:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - MatchResultPB

@implementation MatchResultPB

@dynamic mvpValue;
@dynamic totalCoin;
@dynamic killSoldier;
@dynamic killMonster;
@dynamic kill;
@dynamic dead;
@dynamic assist;
@dynamic doubleKillNum;
@dynamic soulLevel;
@dynamic equipIdsArray, equipIdsArray_Count;

typedef struct MatchResultPB__storage_ {
  uint32_t _has_storage_[1];
  uint32_t mvpValue;
  uint32_t totalCoin;
  uint32_t killSoldier;
  uint32_t killMonster;
  uint32_t kill;
  uint32_t dead;
  uint32_t assist;
  uint32_t doubleKillNum;
  uint32_t soulLevel;
  GPBUInt32Array *equipIdsArray;
} MatchResultPB__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "mvpValue",
        .dataTypeSpecific.className = NULL,
        .number = MatchResultPB_FieldNumber_MvpValue,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(MatchResultPB__storage_, mvpValue),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "totalCoin",
        .dataTypeSpecific.className = NULL,
        .number = MatchResultPB_FieldNumber_TotalCoin,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(MatchResultPB__storage_, totalCoin),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "killSoldier",
        .dataTypeSpecific.className = NULL,
        .number = MatchResultPB_FieldNumber_KillSoldier,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(MatchResultPB__storage_, killSoldier),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "killMonster",
        .dataTypeSpecific.className = NULL,
        .number = MatchResultPB_FieldNumber_KillMonster,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(MatchResultPB__storage_, killMonster),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "kill",
        .dataTypeSpecific.className = NULL,
        .number = MatchResultPB_FieldNumber_Kill,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(MatchResultPB__storage_, kill),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "dead",
        .dataTypeSpecific.className = NULL,
        .number = MatchResultPB_FieldNumber_Dead,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(MatchResultPB__storage_, dead),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "assist",
        .dataTypeSpecific.className = NULL,
        .number = MatchResultPB_FieldNumber_Assist,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(MatchResultPB__storage_, assist),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "doubleKillNum",
        .dataTypeSpecific.className = NULL,
        .number = MatchResultPB_FieldNumber_DoubleKillNum,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(MatchResultPB__storage_, doubleKillNum),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "soulLevel",
        .dataTypeSpecific.className = NULL,
        .number = MatchResultPB_FieldNumber_SoulLevel,
        .hasIndex = 8,
        .offset = (uint32_t)offsetof(MatchResultPB__storage_, soulLevel),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "equipIdsArray",
        .dataTypeSpecific.className = NULL,
        .number = MatchResultPB_FieldNumber_EquipIdsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(MatchResultPB__storage_, equipIdsArray),
        .flags = (GPBFieldFlags)(GPBFieldRepeated | GPBFieldPacked | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[MatchResultPB class]
                                     rootClass:[SmobaDataRoot class]
                                          file:SmobaDataRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(MatchResultPB__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\n\001\010\000\002I\000\003K\000\004K\000\005D\000\006D\000\007F\000\010M\000\tI\000\n\000EquipIds\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - PlayerPB

@implementation PlayerPB

@dynamic playerId;
@dynamic camp;
@dynamic isMaster;
@dynamic isReady;
@dynamic heroSkin;
@dynamic heroName;
@dynamic hasResult, result;

typedef struct PlayerPB__storage_ {
  uint32_t _has_storage_[1];
  uint32_t camp;
  NSString *heroSkin;
  NSString *heroName;
  MatchResultPB *result;
  uint64_t playerId;
} PlayerPB__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "playerId",
        .dataTypeSpecific.className = NULL,
        .number = PlayerPB_FieldNumber_PlayerId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PlayerPB__storage_, playerId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "camp",
        .dataTypeSpecific.className = NULL,
        .number = PlayerPB_FieldNumber_Camp,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PlayerPB__storage_, camp),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "isMaster",
        .dataTypeSpecific.className = NULL,
        .number = PlayerPB_FieldNumber_IsMaster,
        .hasIndex = 2,
        .offset = 3,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "isReady",
        .dataTypeSpecific.className = NULL,
        .number = PlayerPB_FieldNumber_IsReady,
        .hasIndex = 4,
        .offset = 5,  // Stored in _has_storage_ to save space.
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeBool,
      },
      {
        .name = "heroSkin",
        .dataTypeSpecific.className = NULL,
        .number = PlayerPB_FieldNumber_HeroSkin,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(PlayerPB__storage_, heroSkin),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "heroName",
        .dataTypeSpecific.className = NULL,
        .number = PlayerPB_FieldNumber_HeroName,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(PlayerPB__storage_, heroName),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "result",
        .dataTypeSpecific.className = GPBStringifySymbol(MatchResultPB),
        .number = PlayerPB_FieldNumber_Result,
        .hasIndex = 8,
        .offset = (uint32_t)offsetof(PlayerPB__storage_, result),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PlayerPB class]
                                     rootClass:[SmobaDataRoot class]
                                          file:SmobaDataRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PlayerPB__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\005\001\007A\000\003\010\000\004\007\000\005\010\000\006\010\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - SmobaData

@implementation SmobaData

@dynamic magic;
@dynamic flags;
@dynamic req;
@dynamic accountId;
@dynamic accountInfo;
@dynamic logicWorldId;
@dynamic winCamp;
@dynamic hasRoomInfo, roomInfo;
@dynamic playerArray, playerArray_Count;

typedef struct SmobaData__storage_ {
  uint32_t _has_storage_[1];
  uint32_t magic;
  uint32_t flags;
  uint32_t req;
  uint32_t accountId;
  uint32_t logicWorldId;
  uint32_t winCamp;
  NSString *accountInfo;
  RoomInfoPB *roomInfo;
  NSMutableArray *playerArray;
} SmobaData__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "magic",
        .dataTypeSpecific.className = NULL,
        .number = SmobaData_FieldNumber_Magic,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(SmobaData__storage_, magic),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "flags",
        .dataTypeSpecific.className = NULL,
        .number = SmobaData_FieldNumber_Flags,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(SmobaData__storage_, flags),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "req",
        .dataTypeSpecific.className = NULL,
        .number = SmobaData_FieldNumber_Req,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(SmobaData__storage_, req),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "accountId",
        .dataTypeSpecific.className = NULL,
        .number = SmobaData_FieldNumber_AccountId,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(SmobaData__storage_, accountId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "accountInfo",
        .dataTypeSpecific.className = NULL,
        .number = SmobaData_FieldNumber_AccountInfo,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(SmobaData__storage_, accountInfo),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "logicWorldId",
        .dataTypeSpecific.className = NULL,
        .number = SmobaData_FieldNumber_LogicWorldId,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(SmobaData__storage_, logicWorldId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "winCamp",
        .dataTypeSpecific.className = NULL,
        .number = SmobaData_FieldNumber_WinCamp,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(SmobaData__storage_, winCamp),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "roomInfo",
        .dataTypeSpecific.className = GPBStringifySymbol(RoomInfoPB),
        .number = SmobaData_FieldNumber_RoomInfo,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(SmobaData__storage_, roomInfo),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "playerArray",
        .dataTypeSpecific.className = GPBStringifySymbol(PlayerPB),
        .number = SmobaData_FieldNumber_PlayerArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(SmobaData__storage_, playerArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[SmobaData class]
                                     rootClass:[SmobaDataRoot class]
                                          file:SmobaDataRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(SmobaData__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\005\004\010A\000\005\013\000\006\013A\000\007\007\000\010\010\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
