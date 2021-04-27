pub const ktx_uint8_t = u8;
pub const ktx_bool_t = bool;
pub const ktx_uint16_t = u16;
pub const ktx_int16_t = i16;
pub const ktx_uint32_t = u32;
pub const ktx_int32_t = i32;
pub const ktx_size_t = usize;
pub const ktx_uint32_t_SIZE_ASSERT = [1]u8;
pub const GLboolean = u8;
pub const GLenum = c_uint;
pub const GLint = c_int;
pub const GLsizei = c_int;
pub const GLuint = c_uint;
pub const GLubyte = u8;
pub const KTX_SUCCESS = enum_KTX_error_code_t.KTX_SUCCESS;
pub const KTX_FILE_DATA_ERROR = enum_KTX_error_code_t.KTX_FILE_DATA_ERROR;
pub const KTX_FILE_OPEN_FAILED = enum_KTX_error_code_t.KTX_FILE_OPEN_FAILED;
pub const KTX_FILE_OVERFLOW = enum_KTX_error_code_t.KTX_FILE_OVERFLOW;
pub const KTX_FILE_READ_ERROR = enum_KTX_error_code_t.KTX_FILE_READ_ERROR;
pub const KTX_FILE_SEEK_ERROR = enum_KTX_error_code_t.KTX_FILE_SEEK_ERROR;
pub const KTX_FILE_UNEXPECTED_EOF = enum_KTX_error_code_t.KTX_FILE_UNEXPECTED_EOF;
pub const KTX_FILE_WRITE_ERROR = enum_KTX_error_code_t.KTX_FILE_WRITE_ERROR;
pub const KTX_GL_ERROR = enum_KTX_error_code_t.KTX_GL_ERROR;
pub const KTX_INVALID_OPERATION = enum_KTX_error_code_t.KTX_INVALID_OPERATION;
pub const KTX_INVALID_VALUE = enum_KTX_error_code_t.KTX_INVALID_VALUE;
pub const KTX_NOT_FOUND = enum_KTX_error_code_t.KTX_NOT_FOUND;
pub const KTX_OUT_OF_MEMORY = enum_KTX_error_code_t.KTX_OUT_OF_MEMORY;
pub const KTX_UNKNOWN_FILE_FORMAT = enum_KTX_error_code_t.KTX_UNKNOWN_FILE_FORMAT;
pub const KTX_UNSUPPORTED_TEXTURE_TYPE = enum_KTX_error_code_t.KTX_UNSUPPORTED_TEXTURE_TYPE;
pub const enum_KTX_error_code_t = extern enum {
    KTX_SUCCESS = 0,
    KTX_FILE_DATA_ERROR = 1,
    KTX_FILE_OPEN_FAILED = 2,
    KTX_FILE_OVERFLOW = 3,
    KTX_FILE_READ_ERROR = 4,
    KTX_FILE_SEEK_ERROR = 5,
    KTX_FILE_UNEXPECTED_EOF = 6,
    KTX_FILE_WRITE_ERROR = 7,
    KTX_GL_ERROR = 8,
    KTX_INVALID_OPERATION = 9,
    KTX_INVALID_VALUE = 10,
    KTX_NOT_FOUND = 11,
    KTX_OUT_OF_MEMORY = 12,
    KTX_UNKNOWN_FILE_FORMAT = 13,
    KTX_UNSUPPORTED_TEXTURE_TYPE = 14,
};
pub const KTX_error_code = enum_KTX_error_code_t;
pub const ktxResult = enum_KTX_error_code_t;
pub const struct_ktxKVListEntry = opaque {};
pub const ktxHashList = ?*struct_ktxKVListEntry;
pub const ktxTexture = extern struct {
    glFormat: ktx_uint32_t,
    glInternalformat: ktx_uint32_t,
    glBaseInternalformat: ktx_uint32_t,
    glType: ktx_uint32_t,
    isArray: ktx_bool_t,
    isCubemap: ktx_bool_t,
    isCompressed: ktx_bool_t,
    generateMipmaps: ktx_bool_t,
    baseWidth: ktx_uint32_t,
    baseHeight: ktx_uint32_t,
    baseDepth: ktx_uint32_t,
    numDimensions: ktx_uint32_t,
    numLevels: ktx_uint32_t,
    numLayers: ktx_uint32_t,
    numFaces: ktx_uint32_t,
    kvDataHead: ktxHashList,
    kvDataLen: ktx_uint32_t,
    kvData: [*c]ktx_uint8_t,
    dataSize: ktx_size_t,
    pData: [*c]ktx_uint8_t,
};
pub const ktxTextureCreateInfo = extern struct {
    glInternalformat: ktx_uint32_t,
    baseWidth: ktx_uint32_t,
    baseHeight: ktx_uint32_t,
    baseDepth: ktx_uint32_t,
    numDimensions: ktx_uint32_t,
    numLevels: ktx_uint32_t,
    numLayers: ktx_uint32_t,
    numFaces: ktx_uint32_t,
    isArray: ktx_bool_t,
    generateMipmaps: ktx_bool_t,
};
pub const KTX_TEXTURE_CREATE_NO_STORAGE = 0;
pub const KTX_TEXTURE_CREATE_ALLOC_STORAGE = 1;
pub const ktxTextureCreateStorageEnum = extern enum {
    KTX_TEXTURE_CREATE_NO_STORAGE = 0,
    KTX_TEXTURE_CREATE_ALLOC_STORAGE = 1,
};
pub const KTX_TEXTURE_CREATE_NO_FLAGS = 0;
pub const KTX_TEXTURE_CREATE_LOAD_IMAGE_DATA_BIT = 1;
pub const KTX_TEXTURE_CREATE_RAW_KVDATA_BIT = 2;
pub const KTX_TEXTURE_CREATE_SKIP_KVDATA_BIT = 4;
pub const ktxTextureCreateFlags = ktx_uint32_t;
pub const PFNKTXITERCB = ?fn (c_int, c_int, c_int, c_int, c_int, ktx_uint32_t, ?*c_void, ?*c_void) callconv(.C) KTX_error_code;
pub extern fn ktxTexture_Create(createInfo: [*c]ktxTextureCreateInfo, storageAllocation: ktxTextureCreateStorageEnum, newTex: [*c]([*c]ktxTexture)) KTX_error_code;
pub extern fn ktxTexture_CreateFromStdioStream(stdioStream: [*c]FILE, createFlags: ktxTextureCreateFlags, newTex: [*c]([*c]ktxTexture)) KTX_error_code;
pub extern fn ktxTexture_CreateFromNamedFile(filename: [*:0]const u8, createFlags: ktxTextureCreateFlags, newTex: [*c]([*c]ktxTexture)) KTX_error_code;
pub extern fn ktxTexture_CreateFromMemory(bytes: [*]const u8, size: ktx_size_t, createFlags: ktxTextureCreateFlags, newTex: [*c]([*c]ktxTexture)) KTX_error_code;
pub extern fn ktxTexture_Destroy(This: [*c]ktxTexture) void;
pub extern fn ktxTexture_GetData(This: [*c]ktxTexture) [*c]ktx_uint8_t;
pub extern fn ktxTexture_GetImageOffset(This: [*c]ktxTexture, level: ktx_uint32_t, layer: ktx_uint32_t, faceSlice: ktx_uint32_t, pOffset: [*c]ktx_size_t) KTX_error_code;
pub extern fn ktxTexture_GetRowPitch(This: [*c]ktxTexture, level: ktx_uint32_t) ktx_uint32_t;
pub extern fn ktxTexture_GetElementSize(This: [*c]ktxTexture) ktx_uint32_t;
pub extern fn ktxTexture_GetSize(This: [*c]ktxTexture) ktx_size_t;
pub extern fn ktxTexture_GetImageSize(This: [*c]ktxTexture, level: ktx_uint32_t) ktx_size_t;
pub extern fn ktxTexture_GLUpload(This: [*c]ktxTexture, pTexture: [*c]GLuint, pTarget: [*c]GLenum, pGlerror: [*c]GLenum) KTX_error_code;
pub extern fn ktxTexture_LoadImageData(This: [*c]ktxTexture, pBuffer: [*c]ktx_uint8_t, bufSize: ktx_size_t) KTX_error_code;
pub extern fn ktxTexture_IterateLevelFaces(super: [*c]ktxTexture, iterCb: PFNKTXITERCB, userdata: ?*c_void) KTX_error_code;
pub extern fn ktxTexture_IterateLoadLevelFaces(super: [*c]ktxTexture, iterCb: PFNKTXITERCB, userdata: ?*c_void) KTX_error_code;
pub extern fn ktxTexture_IterateLevels(This: [*c]ktxTexture, iterCb: PFNKTXITERCB, userdata: ?*c_void) KTX_error_code;
pub extern fn ktxTexture_SetImageFromMemory(This: [*c]ktxTexture, level: ktx_uint32_t, layer: ktx_uint32_t, faceSlice: ktx_uint32_t, src: [*c]const ktx_uint8_t, srcSize: ktx_size_t) KTX_error_code;
pub extern fn ktxTexture_SetImageFromStdioStream(This: [*c]ktxTexture, level: ktx_uint32_t, layer: ktx_uint32_t, faceSlice: ktx_uint32_t, src: [*c]FILE, srcSize: ktx_size_t) KTX_error_code;
pub extern fn ktxTexture_WriteToStdioStream(This: [*c]ktxTexture, dstsstr: [*c]FILE) KTX_error_code;
pub extern fn ktxTexture_WriteToNamedFile(This: [*c]ktxTexture, dstname: [*c]const u8) KTX_error_code;
pub extern fn ktxTexture_WriteToMemory(This: [*c]ktxTexture, bytes: [*c]([*c]ktx_uint8_t), size: [*c]ktx_size_t) KTX_error_code;
pub extern fn ktxErrorString(@"error": KTX_error_code) [*c]const u8;
pub extern fn ktxHashList_Create(ppHl: [*c]([*c]ktxHashList)) KTX_error_code;
pub extern fn ktxHashList_Construct(pHl: [*c]ktxHashList) void;
pub extern fn ktxHashList_Destroy(head: [*c]ktxHashList) void;
pub extern fn ktxHashList_Destruct(head: [*c]ktxHashList) void;
pub extern fn ktxHashList_AddKVPair(pHead: [*c]ktxHashList, key: [*c]const u8, valueLen: c_uint, value: ?*const c_void) KTX_error_code;
pub extern fn ktxHashList_FindValue(pHead: [*c]ktxHashList, key: [*c]const u8, pValueLen: [*c]c_uint, pValue: [*c](?*c_void)) KTX_error_code;
pub extern fn ktxHashList_Serialize(pHead: [*c]ktxHashList, kvdLen: [*c]c_uint, kvd: [*c]([*c]u8)) KTX_error_code;
pub extern fn ktxHashList_Deserialize(pHead: [*c]ktxHashList, kvdLen: c_uint, kvd: ?*c_void) KTX_error_code;
pub const struct_KTX_dimensions = extern struct {
    width: GLsizei,
    height: GLsizei,
    depth: GLsizei,
};
pub const KTX_dimensions = struct_KTX_dimensions;
pub const struct_KTX_texture_info = extern struct {
    glType: ktx_uint32_t,
    glTypeSize: ktx_uint32_t,
    glFormat: ktx_uint32_t,
    glInternalFormat: ktx_uint32_t,
    glBaseInternalFormat: ktx_uint32_t,
    pixelWidth: ktx_uint32_t,
    pixelHeight: ktx_uint32_t,
    pixelDepth: ktx_uint32_t,
    numberOfArrayElements: ktx_uint32_t,
    numberOfFaces: ktx_uint32_t,
    numberOfMipmapLevels: ktx_uint32_t,
};
pub const KTX_texture_info = struct_KTX_texture_info;
pub const struct_KTX_image_info = extern struct {
    size: GLsizei,
    data: [*c]GLubyte,
};
pub const KTX_image_info = struct_KTX_image_info;
pub extern fn ktxLoadTextureF(arg0: [*c]FILE, pTexture: [*c]GLuint, pTarget: [*c]GLenum, pDimensions: [*c]KTX_dimensions, pIsMipmapped: [*c]GLboolean, pGlerror: [*c]GLenum, pKvdLen: [*c]c_uint, ppKvd: [*c]([*c]u8)) KTX_error_code;
pub extern fn ktxLoadTextureN(filename: [*c]const u8, pTexture: [*c]GLuint, pTarget: [*c]GLenum, pDimensions: [*c]KTX_dimensions, pIsMipmapped: [*c]GLboolean, pGlerror: [*c]GLenum, pKvdLen: [*c]c_uint, ppKvd: [*c]([*c]u8)) KTX_error_code;
pub extern fn ktxLoadTextureM(bytes: ?*const c_void, size: GLsizei, pTexture: [*c]GLuint, pTarget: [*c]GLenum, pDimensions: [*c]KTX_dimensions, pIsMipmapped: [*c]GLboolean, pGlerror: [*c]GLenum, pKvdLen: [*c]c_uint, ppKvd: [*c]([*c]u8)) KTX_error_code;
pub const KTX_hash_table = [*c]ktxHashList;
pub extern fn ktxHashTable_Create() KTX_hash_table;
pub extern fn ktxHashTable_Serialize(This: KTX_hash_table, kvdLen: [*c]c_uint, kvd: [*c]([*c]u8)) KTX_error_code;
pub extern fn ktxHashTable_Deserialize(kvdLen: c_uint, pKvd: ?*c_void, pHt: [*c]KTX_hash_table) KTX_error_code;
pub extern fn ktxWriteKTXF(dst: [*c]FILE, imageInfo: [*c]const KTX_texture_info, bytesOfKeyValueData: GLsizei, keyValueData: ?*const c_void, numImages: GLuint, images: [*c]KTX_image_info) KTX_error_code;
pub extern fn ktxWriteKTXN(dstname: [*c]const u8, imageInfo: [*c]const KTX_texture_info, bytesOfKeyValueData: GLsizei, keyValueData: ?*const c_void, numImages: GLuint, images: [*c]KTX_image_info) KTX_error_code;
pub extern fn ktxWriteKTXM(dst: [*c]([*c]u8), size: [*c]GLsizei, textureInfo: [*c]const KTX_texture_info, bytesOfKeyValueData: GLsizei, keyValueData: ?*const c_void, numImages: GLuint, images: [*c]KTX_image_info) KTX_error_code;
pub const KTX_ORIENTATION_KEY = "KTXorientation";
pub const KTX_HEADER_SIZE = 64;
pub const KTX_FALSE = @"false";
pub const KTX_ORIENTATION2_FMT = "S=%c,T=%c";
pub const KTXAPIENTRYP = [*c]KTXAPIENTRY;
pub const KTX_ENDIAN_REF = 67305985;
pub const KTX_ORIENTATION3_FMT = "S=%c,T=%c,R=%c";
pub const KTX_ENDIAN_REF_REV = 16909060;
pub const KTX_TRUE = @"true";
pub const KTX_GL_UNPACK_ALIGNMENT = 4;
pub const KTX_error_code_t = enum_KTX_error_code_t;
pub const ktxKVListEntry = struct_ktxKVListEntry;
pub const ktxTextureCreateFlagBits = enum_ktxTextureCreateFlagBits;
