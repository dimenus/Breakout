pub const SoundIoErrorNone = @enumToInt(enum_SoundIoError.None);
pub const SoundIoErrorNoMem = @enumToInt(enum_SoundIoError.NoMem);
pub const SoundIoErrorInitAudioBackend = @enumToInt(enum_SoundIoError.InitAudioBackend);
pub const SoundIoErrorSystemResources = @enumToInt(enum_SoundIoError.SystemResources);
pub const SoundIoErrorOpeningDevice = @enumToInt(enum_SoundIoError.OpeningDevice);
pub const SoundIoErrorNoSuchDevice = @enumToInt(enum_SoundIoError.NoSuchDevice);
pub const SoundIoErrorInvalid = @enumToInt(enum_SoundIoError.Invalid);
pub const SoundIoErrorBackendUnavailable = @enumToInt(enum_SoundIoError.BackendUnavailable);
pub const SoundIoErrorStreaming = @enumToInt(enum_SoundIoError.Streaming);
pub const SoundIoErrorIncompatibleDevice = @enumToInt(enum_SoundIoError.IncompatibleDevice);
pub const SoundIoErrorNoSuchClient = @enumToInt(enum_SoundIoError.NoSuchClient);
pub const SoundIoErrorIncompatibleBackend = @enumToInt(enum_SoundIoError.IncompatibleBackend);
pub const SoundIoErrorBackendDisconnected = @enumToInt(enum_SoundIoError.BackendDisconnected);
pub const SoundIoErrorInterrupted = @enumToInt(enum_SoundIoError.Interrupted);
pub const SoundIoErrorUnderflow = @enumToInt(enum_SoundIoError.Underflow);
pub const SoundIoErrorEncodingString = @enumToInt(enum_SoundIoError.EncodingString);
pub const enum_SoundIoError = extern enum(c_int) {
    None,
    NoMem,
    InitAudioBackend,
    SystemResources,
    OpeningDevice,
    NoSuchDevice,
    Invalid,
    BackendUnavailable,
    Streaming,
    IncompatibleDevice,
    NoSuchClient,
    IncompatibleBackend,
    BackendDisconnected,
    Interrupted,
    Underflow,
    EncodingString,
};
pub const SoundIoChannelIdInvalid = @enumToInt(enum_SoundIoChannelId.Invalid);
pub const SoundIoChannelIdFrontLeft = @enumToInt(enum_SoundIoChannelId.FrontLeft);
pub const SoundIoChannelIdFrontRight = @enumToInt(enum_SoundIoChannelId.FrontRight);
pub const SoundIoChannelIdFrontCenter = @enumToInt(enum_SoundIoChannelId.FrontCenter);
pub const SoundIoChannelIdLfe = @enumToInt(enum_SoundIoChannelId.Lfe);
pub const SoundIoChannelIdBackLeft = @enumToInt(enum_SoundIoChannelId.BackLeft);
pub const SoundIoChannelIdBackRight = @enumToInt(enum_SoundIoChannelId.BackRight);
pub const SoundIoChannelIdFrontLeftCenter = @enumToInt(enum_SoundIoChannelId.FrontLeftCenter);
pub const SoundIoChannelIdFrontRightCenter = @enumToInt(enum_SoundIoChannelId.FrontRightCenter);
pub const SoundIoChannelIdBackCenter = @enumToInt(enum_SoundIoChannelId.BackCenter);
pub const SoundIoChannelIdSideLeft = @enumToInt(enum_SoundIoChannelId.SideLeft);
pub const SoundIoChannelIdSideRight = @enumToInt(enum_SoundIoChannelId.SideRight);
pub const SoundIoChannelIdTopCenter = @enumToInt(enum_SoundIoChannelId.TopCenter);
pub const SoundIoChannelIdTopFrontLeft = @enumToInt(enum_SoundIoChannelId.TopFrontLeft);
pub const SoundIoChannelIdTopFrontCenter = @enumToInt(enum_SoundIoChannelId.TopFrontCenter);
pub const SoundIoChannelIdTopFrontRight = @enumToInt(enum_SoundIoChannelId.TopFrontRight);
pub const SoundIoChannelIdTopBackLeft = @enumToInt(enum_SoundIoChannelId.TopBackLeft);
pub const SoundIoChannelIdTopBackCenter = @enumToInt(enum_SoundIoChannelId.TopBackCenter);
pub const SoundIoChannelIdTopBackRight = @enumToInt(enum_SoundIoChannelId.TopBackRight);
pub const SoundIoChannelIdBackLeftCenter = @enumToInt(enum_SoundIoChannelId.BackLeftCenter);
pub const SoundIoChannelIdBackRightCenter = @enumToInt(enum_SoundIoChannelId.BackRightCenter);
pub const SoundIoChannelIdFrontLeftWide = @enumToInt(enum_SoundIoChannelId.FrontLeftWide);
pub const SoundIoChannelIdFrontRightWide = @enumToInt(enum_SoundIoChannelId.FrontRightWide);
pub const SoundIoChannelIdFrontLeftHigh = @enumToInt(enum_SoundIoChannelId.FrontLeftHigh);
pub const SoundIoChannelIdFrontCenterHigh = @enumToInt(enum_SoundIoChannelId.FrontCenterHigh);
pub const SoundIoChannelIdFrontRightHigh = @enumToInt(enum_SoundIoChannelId.FrontRightHigh);
pub const SoundIoChannelIdTopFrontLeftCenter = @enumToInt(enum_SoundIoChannelId.TopFrontLeftCenter);
pub const SoundIoChannelIdTopFrontRightCenter = @enumToInt(enum_SoundIoChannelId.TopFrontRightCenter);
pub const SoundIoChannelIdTopSideLeft = @enumToInt(enum_SoundIoChannelId.TopSideLeft);
pub const SoundIoChannelIdTopSideRight = @enumToInt(enum_SoundIoChannelId.TopSideRight);
pub const SoundIoChannelIdLeftLfe = @enumToInt(enum_SoundIoChannelId.LeftLfe);
pub const SoundIoChannelIdRightLfe = @enumToInt(enum_SoundIoChannelId.RightLfe);
pub const SoundIoChannelIdLfe2 = @enumToInt(enum_SoundIoChannelId.Lfe2);
pub const SoundIoChannelIdBottomCenter = @enumToInt(enum_SoundIoChannelId.BottomCenter);
pub const SoundIoChannelIdBottomLeftCenter = @enumToInt(enum_SoundIoChannelId.BottomLeftCenter);
pub const SoundIoChannelIdBottomRightCenter = @enumToInt(enum_SoundIoChannelId.BottomRightCenter);
pub const SoundIoChannelIdMsMid = @enumToInt(enum_SoundIoChannelId.MsMid);
pub const SoundIoChannelIdMsSide = @enumToInt(enum_SoundIoChannelId.MsSide);
pub const SoundIoChannelIdAmbisonicW = @enumToInt(enum_SoundIoChannelId.AmbisonicW);
pub const SoundIoChannelIdAmbisonicX = @enumToInt(enum_SoundIoChannelId.AmbisonicX);
pub const SoundIoChannelIdAmbisonicY = @enumToInt(enum_SoundIoChannelId.AmbisonicY);
pub const SoundIoChannelIdAmbisonicZ = @enumToInt(enum_SoundIoChannelId.AmbisonicZ);
pub const SoundIoChannelIdXyX = @enumToInt(enum_SoundIoChannelId.XyX);
pub const SoundIoChannelIdXyY = @enumToInt(enum_SoundIoChannelId.XyY);
pub const SoundIoChannelIdHeadphonesLeft = @enumToInt(enum_SoundIoChannelId.HeadphonesLeft);
pub const SoundIoChannelIdHeadphonesRight = @enumToInt(enum_SoundIoChannelId.HeadphonesRight);
pub const SoundIoChannelIdClickTrack = @enumToInt(enum_SoundIoChannelId.ClickTrack);
pub const SoundIoChannelIdForeignLanguage = @enumToInt(enum_SoundIoChannelId.ForeignLanguage);
pub const SoundIoChannelIdHearingImpaired = @enumToInt(enum_SoundIoChannelId.HearingImpaired);
pub const SoundIoChannelIdNarration = @enumToInt(enum_SoundIoChannelId.Narration);
pub const SoundIoChannelIdHaptic = @enumToInt(enum_SoundIoChannelId.Haptic);
pub const SoundIoChannelIdDialogCentricMix = @enumToInt(enum_SoundIoChannelId.DialogCentricMix);
pub const SoundIoChannelIdAux = @enumToInt(enum_SoundIoChannelId.Aux);
pub const SoundIoChannelIdAux0 = @enumToInt(enum_SoundIoChannelId.Aux0);
pub const SoundIoChannelIdAux1 = @enumToInt(enum_SoundIoChannelId.Aux1);
pub const SoundIoChannelIdAux2 = @enumToInt(enum_SoundIoChannelId.Aux2);
pub const SoundIoChannelIdAux3 = @enumToInt(enum_SoundIoChannelId.Aux3);
pub const SoundIoChannelIdAux4 = @enumToInt(enum_SoundIoChannelId.Aux4);
pub const SoundIoChannelIdAux5 = @enumToInt(enum_SoundIoChannelId.Aux5);
pub const SoundIoChannelIdAux6 = @enumToInt(enum_SoundIoChannelId.Aux6);
pub const SoundIoChannelIdAux7 = @enumToInt(enum_SoundIoChannelId.Aux7);
pub const SoundIoChannelIdAux8 = @enumToInt(enum_SoundIoChannelId.Aux8);
pub const SoundIoChannelIdAux9 = @enumToInt(enum_SoundIoChannelId.Aux9);
pub const SoundIoChannelIdAux10 = @enumToInt(enum_SoundIoChannelId.Aux10);
pub const SoundIoChannelIdAux11 = @enumToInt(enum_SoundIoChannelId.Aux11);
pub const SoundIoChannelIdAux12 = @enumToInt(enum_SoundIoChannelId.Aux12);
pub const SoundIoChannelIdAux13 = @enumToInt(enum_SoundIoChannelId.Aux13);
pub const SoundIoChannelIdAux14 = @enumToInt(enum_SoundIoChannelId.Aux14);
pub const SoundIoChannelIdAux15 = @enumToInt(enum_SoundIoChannelId.Aux15);
pub const enum_SoundIoChannelId = extern enum(c_int) {
    Invalid,
    FrontLeft,
    FrontRight,
    FrontCenter,
    Lfe,
    BackLeft,
    BackRight,
    FrontLeftCenter,
    FrontRightCenter,
    BackCenter,
    SideLeft,
    SideRight,
    TopCenter,
    TopFrontLeft,
    TopFrontCenter,
    TopFrontRight,
    TopBackLeft,
    TopBackCenter,
    TopBackRight,
    BackLeftCenter,
    BackRightCenter,
    FrontLeftWide,
    FrontRightWide,
    FrontLeftHigh,
    FrontCenterHigh,
    FrontRightHigh,
    TopFrontLeftCenter,
    TopFrontRightCenter,
    TopSideLeft,
    TopSideRight,
    LeftLfe,
    RightLfe,
    Lfe2,
    BottomCenter,
    BottomLeftCenter,
    BottomRightCenter,
    MsMid,
    MsSide,
    AmbisonicW,
    AmbisonicX,
    AmbisonicY,
    AmbisonicZ,
    XyX,
    XyY,
    HeadphonesLeft,
    HeadphonesRight,
    ClickTrack,
    ForeignLanguage,
    HearingImpaired,
    Narration,
    Haptic,
    DialogCentricMix,
    Aux,
    Aux0,
    Aux1,
    Aux2,
    Aux3,
    Aux4,
    Aux5,
    Aux6,
    Aux7,
    Aux8,
    Aux9,
    Aux10,
    Aux11,
    Aux12,
    Aux13,
    Aux14,
    Aux15,
    _,
};
pub const SoundIoChannelLayoutIdMono = @enumToInt(enum_SoundIoChannelLayoutId.Mono);
pub const SoundIoChannelLayoutIdStereo = @enumToInt(enum_SoundIoChannelLayoutId.Stereo);
pub const SoundIoChannelLayoutId2Point1 = @enumToInt(enum_SoundIoChannelLayoutId.@"2Point1");
pub const SoundIoChannelLayoutId3Point0 = @enumToInt(enum_SoundIoChannelLayoutId.@"3Point0");
pub const SoundIoChannelLayoutId3Point0Back = @enumToInt(enum_SoundIoChannelLayoutId.@"3Point0Back");
pub const SoundIoChannelLayoutId3Point1 = @enumToInt(enum_SoundIoChannelLayoutId.@"3Point1");
pub const SoundIoChannelLayoutId4Point0 = @enumToInt(enum_SoundIoChannelLayoutId.@"4Point0");
pub const SoundIoChannelLayoutIdQuad = @enumToInt(enum_SoundIoChannelLayoutId.Quad);
pub const SoundIoChannelLayoutIdQuadSide = @enumToInt(enum_SoundIoChannelLayoutId.QuadSide);
pub const SoundIoChannelLayoutId4Point1 = @enumToInt(enum_SoundIoChannelLayoutId.@"4Point1");
pub const SoundIoChannelLayoutId5Point0Back = @enumToInt(enum_SoundIoChannelLayoutId.@"5Point0Back");
pub const SoundIoChannelLayoutId5Point0Side = @enumToInt(enum_SoundIoChannelLayoutId.@"5Point0Side");
pub const SoundIoChannelLayoutId5Point1 = @enumToInt(enum_SoundIoChannelLayoutId.@"5Point1");
pub const SoundIoChannelLayoutId5Point1Back = @enumToInt(enum_SoundIoChannelLayoutId.@"5Point1Back");
pub const SoundIoChannelLayoutId6Point0Side = @enumToInt(enum_SoundIoChannelLayoutId.@"6Point0Side");
pub const SoundIoChannelLayoutId6Point0Front = @enumToInt(enum_SoundIoChannelLayoutId.@"6Point0Front");
pub const SoundIoChannelLayoutIdHexagonal = @enumToInt(enum_SoundIoChannelLayoutId.Hexagonal);
pub const SoundIoChannelLayoutId6Point1 = @enumToInt(enum_SoundIoChannelLayoutId.@"6Point1");
pub const SoundIoChannelLayoutId6Point1Back = @enumToInt(enum_SoundIoChannelLayoutId.@"6Point1Back");
pub const SoundIoChannelLayoutId6Point1Front = @enumToInt(enum_SoundIoChannelLayoutId.@"6Point1Front");
pub const SoundIoChannelLayoutId7Point0 = @enumToInt(enum_SoundIoChannelLayoutId.@"7Point0");
pub const SoundIoChannelLayoutId7Point0Front = @enumToInt(enum_SoundIoChannelLayoutId.@"7Point0Front");
pub const SoundIoChannelLayoutId7Point1 = @enumToInt(enum_SoundIoChannelLayoutId.@"7Point1");
pub const SoundIoChannelLayoutId7Point1Wide = @enumToInt(enum_SoundIoChannelLayoutId.@"7Point1Wide");
pub const SoundIoChannelLayoutId7Point1WideBack = @enumToInt(enum_SoundIoChannelLayoutId.@"7Point1WideBack");
pub const SoundIoChannelLayoutIdOctagonal = @enumToInt(enum_SoundIoChannelLayoutId.Octagonal);
pub const enum_SoundIoChannelLayoutId = extern enum(c_int) {
    Mono,
    Stereo,
    @"2Point1",
    @"3Point0",
    @"3Point0Back",
    @"3Point1",
    @"4Point0",
    Quad,
    QuadSide,
    @"4Point1",
    @"5Point0Back",
    @"5Point0Side",
    @"5Point1",
    @"5Point1Back",
    @"6Point0Side",
    @"6Point0Front",
    Hexagonal,
    @"6Point1",
    @"6Point1Back",
    @"6Point1Front",
    @"7Point0",
    @"7Point0Front",
    @"7Point1",
    @"7Point1Wide",
    @"7Point1WideBack",
    Octagonal,
    _,
};
pub const SoundIoBackendNone = @enumToInt(enum_SoundIoBackend.None);
pub const SoundIoBackendJack = @enumToInt(enum_SoundIoBackend.Jack);
pub const SoundIoBackendPulseAudio = @enumToInt(enum_SoundIoBackend.PulseAudio);
pub const SoundIoBackendAlsa = @enumToInt(enum_SoundIoBackend.Alsa);
pub const SoundIoBackendCoreAudio = @enumToInt(enum_SoundIoBackend.CoreAudio);
pub const SoundIoBackendWasapi = @enumToInt(enum_SoundIoBackend.Wasapi);
pub const SoundIoBackendDummy = @enumToInt(enum_SoundIoBackend.Dummy);
pub const enum_SoundIoBackend = extern enum(c_int) {
    None,
    Jack,
    PulseAudio,
    Alsa,
    CoreAudio,
    Wasapi,
    Dummy,
    _,
};
pub const SoundIoDeviceAimInput = @enumToInt(enum_SoundIoDeviceAim.Input);
pub const SoundIoDeviceAimOutput = @enumToInt(enum_SoundIoDeviceAim.Output);
pub const enum_SoundIoDeviceAim = extern enum(c_int) {
    Input,
    Output,
    _,
};
pub const SoundIoFormatInvalid = @enumToInt(enum_SoundIoFormat.Invalid);
pub const SoundIoFormatS8 = @enumToInt(enum_SoundIoFormat.S8);
pub const SoundIoFormatU8 = @enumToInt(enum_SoundIoFormat.U8);
pub const SoundIoFormatS16LE = @enumToInt(enum_SoundIoFormat.S16LE);
pub const SoundIoFormatS16BE = @enumToInt(enum_SoundIoFormat.S16BE);
pub const SoundIoFormatU16LE = @enumToInt(enum_SoundIoFormat.U16LE);
pub const SoundIoFormatU16BE = @enumToInt(enum_SoundIoFormat.U16BE);
pub const SoundIoFormatS24LE = @enumToInt(enum_SoundIoFormat.S24LE);
pub const SoundIoFormatS24BE = @enumToInt(enum_SoundIoFormat.S24BE);
pub const SoundIoFormatU24LE = @enumToInt(enum_SoundIoFormat.U24LE);
pub const SoundIoFormatU24BE = @enumToInt(enum_SoundIoFormat.U24BE);
pub const SoundIoFormatS32LE = @enumToInt(enum_SoundIoFormat.S32LE);
pub const SoundIoFormatS32BE = @enumToInt(enum_SoundIoFormat.S32BE);
pub const SoundIoFormatU32LE = @enumToInt(enum_SoundIoFormat.U32LE);
pub const SoundIoFormatU32BE = @enumToInt(enum_SoundIoFormat.U32BE);
pub const SoundIoFormatFloat32LE = @enumToInt(enum_SoundIoFormat.Float32LE);
pub const SoundIoFormatFloat32BE = @enumToInt(enum_SoundIoFormat.Float32BE);
pub const SoundIoFormatFloat64LE = @enumToInt(enum_SoundIoFormat.Float64LE);
pub const SoundIoFormatFloat64BE = @enumToInt(enum_SoundIoFormat.Float64BE);
pub const enum_SoundIoFormat = extern enum(c_int) {
    Invalid,
    S8,
    U8,
    S16LE,
    S16BE,
    U16LE,
    U16BE,
    S24LE,
    S24BE,
    U24LE,
    U24BE,
    S32LE,
    S32BE,
    U32LE,
    U32BE,
    Float32LE,
    Float32BE,
    Float64LE,
    Float64BE,
    _,
};
pub const struct_SoundIoChannelLayout = extern struct {
    name: [*c]const u8,
    channel_count: c_int,
    channels: [24]enum_SoundIoChannelId,
};
pub const struct_SoundIoSampleRateRange = extern struct {
    min: c_int,
    max: c_int,
};
pub const struct_SoundIoChannelArea = extern struct {
    ptr: [*c]u8,
    step: c_int,
};
pub const struct_SoundIo = extern struct {
    userdata: ?*c_void,
    on_devices_change: ?fn ([*c]struct_SoundIo) callconv(.C) void,
    on_backend_disconnect: ?fn ([*c]struct_SoundIo, c_int) callconv(.C) void,
    on_events_signal: ?fn ([*c]struct_SoundIo) callconv(.C) void,
    current_backend: enum_SoundIoBackend,
    app_name: [*c]const u8,
    emit_rtprio_warning: ?fn () callconv(.C) void,
    jack_info_callback: ?fn ([*c]const u8) callconv(.C) void,
    jack_error_callback: ?fn ([*c]const u8) callconv(.C) void,
};
pub const struct_SoundIoDevice = extern struct {
    soundio: [*c]struct_SoundIo,
    id: [*c]u8,
    name: [*c]u8,
    aim: enum_SoundIoDeviceAim,
    layouts: [*c]struct_SoundIoChannelLayout,
    layout_count: c_int,
    current_layout: struct_SoundIoChannelLayout,
    formats: [*c]enum_SoundIoFormat,
    format_count: c_int,
    current_format: enum_SoundIoFormat,
    sample_rates: [*c]struct_SoundIoSampleRateRange,
    sample_rate_count: c_int,
    sample_rate_current: c_int,
    software_latency_min: f64,
    software_latency_max: f64,
    software_latency_current: f64,
    is_raw: bool,
    ref_count: c_int,
    probe_error: c_int,
};
pub const struct_SoundIoOutStream = extern struct {
    device: [*c]struct_SoundIoDevice,
    format: enum_SoundIoFormat,
    sample_rate: c_int,
    layout: struct_SoundIoChannelLayout,
    software_latency: f64,
    volume: f32,
    userdata: ?*c_void,
    write_callback: ?fn ([*c]struct_SoundIoOutStream, c_int, c_int) callconv(.C) void,
    underflow_callback: ?fn ([*c]struct_SoundIoOutStream) callconv(.C) void,
    error_callback: ?fn ([*c]struct_SoundIoOutStream, c_int) callconv(.C) void,
    name: [*c]const u8,
    non_terminal_hint: bool,
    bytes_per_frame: c_int,
    bytes_per_sample: c_int,
    layout_error: SoundIoError,
};
pub const struct_SoundIoInStream = extern struct {
    device: [*c]struct_SoundIoDevice,
    format: enum_SoundIoFormat,
    sample_rate: c_int,
    layout: struct_SoundIoChannelLayout,
    software_latency: f64,
    userdata: ?*c_void,
    read_callback: ?fn ([*c]struct_SoundIoInStream, c_int, c_int) callconv(.C) void,
    overflow_callback: ?fn ([*c]struct_SoundIoInStream) callconv(.C) void,
    error_callback: ?fn ([*c]struct_SoundIoInStream, c_int) callconv(.C) void,
    name: [*c]const u8,
    non_terminal_hint: bool,
    bytes_per_frame: c_int,
    bytes_per_sample: c_int,
    layout_error: SoundIoError,
};
pub const version_string = soundio_version_string;
extern fn soundio_version_string() [*c]const u8;

pub const version_major = soundio_version_major;
extern fn soundio_version_major() SoundIoError;

pub const version_minor = soundio_version_minor;
extern fn soundio_version_minor() SoundIoError;

pub const verison_patch = soundio_version_patch;
extern fn soundio_version_patch() SoundIoError;

pub const create = soundio_create;
extern fn soundio_create() ?*struct_SoundIo;

pub const destroy = soundio_destroy;
extern fn soundio_destroy(soundio: [*c]struct_SoundIo) void;

pub const connect = soundio_connect;
extern fn soundio_connect(soundio: [*c]struct_SoundIo) SoundIoError;

pub const connect_backend = soundio_connect_backend;
extern fn soundio_connect_backend(soundio: [*c]struct_SoundIo, backend: enum_SoundIoBackend) SoundIoError;

pub const disconnect = soundio_disconnect;
extern fn soundio_disconnect(soundio: [*c]struct_SoundIo) void;

pub const backend_name = soundio_backend_name;
extern fn soundio_backend_name(backend: enum_SoundIoBackend) [*c]const u8;

pub const backend_count = soundio_backend_count;
pub extern fn soundio_backend_count(soundio: [*c]struct_SoundIo) SoundIoError;

pub const get_backend = soundio_get_backend;
extern fn soundio_get_backend(soundio: [*c]struct_SoundIo, index: c_int) enum_SoundIoBackend;

pub const have_backend = soundio_have_backend;
extern fn soundio_have_backend(backend: enum_SoundIoBackend) bool;

pub const flush_events = soundio_flush_events;
extern fn soundio_flush_events(soundio: [*c]struct_SoundIo) void;

pub const wait_events = soundio_wait_events;
extern fn soundio_wait_events(soundio: [*c]struct_SoundIo) void;

pub const wakeup = soundio_wakeup;
extern fn soundio_wakeup(soundio: [*c]struct_SoundIo) void;

pub const force_device_scan = soundio_force_device_scan;
extern fn soundio_force_device_scan(soundio: [*c]struct_SoundIo) void;

pub const channel_layout_equal = soundio_channel_layout_equal;
extern fn soundio_channel_layout_equal(a: [*c]const struct_SoundIoChannelLayout, b: [*c]const struct_SoundIoChannelLayout) bool;

pub const get_channel_name = soundio_get_channel_name;
extern fn soundio_get_channel_name(id: enum_SoundIoChannelId) [*c]const u8;

pub const channel_layout_builtin_count = soundio_channel_layout_builtin_count;
extern fn soundio_channel_layout_builtin_count() SoundIoError;

pub const channel_layout_get_builtin = soundio_channel_layout_get_builtin;
extern fn soundio_channel_layout_get_builtin(index: c_int) [*c]const struct_SoundIoChannelLayout;

pub const channel_layout_get_default;
extern fn soundio_channel_layout_get_default(channel_count: SoundIoError) [*c]const struct_SoundIoChannelLayout;

pub const channel_layout_find_channel = soundio_channel_layout_find_channel;
extern fn soundio_channel_layout_find_channel(layout: [*c]const struct_SoundIoChannelLayout, channel: enum_SoundIoChannelId) SoundIoError;

pub const channel_layout_detect_builtin = soundio_channel_layout_detect_builtin;
extern fn soundio_channel_layout_detect_builtin(layout: [*c]struct_SoundIoChannelLayout) bool;

pub const best_matching_channel_layout = soundio_best_matching_channel;
extern fn soundio_best_matching_channel_layout(preferred_layouts: [*c]const struct_SoundIoChannelLayout, preferred_layout_count: SoundIoError, available_layouts: [*c]const struct_SoundIoChannelLayout, available_layout_count: SoundIoError) [*c]const struct_SoundIoChannelLayout;

pub const sort_channel_layouts = soundio_sort_channel_layouts;
extern fn soundio_sort_channel_layouts(layouts: [*c]struct_SoundIoChannelLayout, layout_count: SoundIoError) void;

pub const get_bytes_per_sample = soundio_get_bytes_per_sample;
extern fn soundio_get_bytes_per_sample(format: enum_SoundIoFormat) SoundIoError;

pub fn get_bytes_per_frame(arg_format: enum_SoundIoFormat, arg_channel_count: SoundIoError) callconv(.C) SoundIoError {
    var format = arg_format;
    var channel_count = arg_channel_count;
    return (soundio_get_bytes_per_sample(format) * channel_count);
}
pub fn get_bytes_per_second(arg_format: enum_SoundIoFormat, arg_channel_count: SoundIoError, arg_sample_rate: SoundIoError) callconv(.C) SoundIoError {
    var format = arg_format;
    var channel_count = arg_channel_count;
    var sample_rate = arg_sample_rate;
    return (soundio_get_bytes_per_frame(format, channel_count) * sample_rate);
}

pub const format_string = soundio_format_string;
extern fn soundio_format_string(format: enum_SoundIoFormat) [*c]const u8;

pub const input_device_count = soundio_input_device_count;
extern fn soundio_input_device_count(soundio: [*c]struct_SoundIo) SoundIoError;

pub const output_device_count = soundio_output_device_count;
extern fn soundio_output_device_count(soundio: [*c]struct_SoundIo) SoundIoError;

pub const get_intput_device = soundio_get_input_device;
extern fn soundio_get_input_device(soundio: [*c]struct_SoundIo, index: c_int) ?*struct_SoundIoDevice;

pub const get_output_device = soundio_get_output_device;
extern fn soundio_get_output_device(soundio: [*c]struct_SoundIo, index: c_int) ?*struct_SoundIoDevice;

pub const default_input_device_index = soundio_default_input_device_index;
extern fn soundio_default_input_device_index(soundio: [*c]struct_SoundIo) c_int;

pub const default_output_device_index = soundio_default_output_device_index;
extern fn soundio_default_output_device_index(soundio: [*c]struct_SoundIo) c_int;

pub const device_ref = soundio_device_ref;
extern fn soundio_device_ref(device: [*c]struct_SoundIoDevice) void;

pub const device_unref = soundio_device_unref;
extern fn soundio_device_unref(device: [*c]struct_SoundIoDevice) void;

pub const device_equal = soundio_device_equal;
extern fn soundio_device_equal(a: [*c]const struct_SoundIoDevice, b: [*c]const struct_SoundIoDevice) bool;

pub const device_sort_channel_layouts = soundio_device_sort_channel_layouts;
extern fn soundio_device_sort_channel_layouts(device: [*c]struct_SoundIoDevice) void;

pub const device_supports_format = soundio_device_supports_format;
extern fn soundio_device_supports_format(device: [*c]struct_SoundIoDevice, format: enum_SoundIoFormat) bool;

pub const device_supports_layout = soundio_device_supports_layout;
extern fn soundio_device_supports_layout(device: [*c]struct_SoundIoDevice, layout: [*c]const struct_SoundIoChannelLayout) bool;

pub const device_supports_sample_rate = soundio_device_supports_sample_rate;
extern fn soundio_device_supports_sample_rate(device: [*c]struct_SoundIoDevice, sample_rate: SoundIoError) bool;

pub const device_nearest_sample_rate = soundio_device_nearest_sample_rate;
extern fn soundio_device_nearest_sample_rate(device: [*c]struct_SoundIoDevice, sample_rate: SoundIoError) SoundIoError;

pub const outstream_create = soundio_outstream_create;
extern fn soundio_outstream_create(device: [*c]struct_SoundIoDevice) ?*struct_SoundIoOutStream;

pub const outstream_destroy = soundio_outstream_destroy;
extern fn soundio_outstream_destroy(outstream: [*c]struct_SoundIoOutStream) void;

pub const outstream_open = soundio_outstream_open;
extern fn soundio_outstream_open(outstream: [*c]struct_SoundIoOutStream) SoundIoError;

pub const outstream_start = soundio_outstream_start;
extern fn soundio_outstream_start(outstream: [*c]struct_SoundIoOutStream) SoundIoError;

pub const outstream_begin_write = soundio_outstream_begin_write;
extern fn soundio_outstream_begin_write(outstream: [*c]struct_SoundIoOutStream, areas: [*c][*c]struct_SoundIoChannelArea, frame_count: [*c]c_int) SoundIoError;

pub const outstream_end_write = soundio_outstream_end_write;
extern fn soundio_outstream_end_write(outstream: [*c]struct_SoundIoOutStream) SoundIoError;

pub const outstream_clear_buffer = soundio_outstream_clear_buffer;
extern fn soundio_outstream_clear_buffer(outstream: [*c]struct_SoundIoOutStream) SoundIoError;

pub const outstream_pause = soundio_outstream_pause;
extern fn soundio_outstream_pause(outstream: [*c]struct_SoundIoOutStream, pause: bool) SoundIoError;

pub const outstream_get_latency = soundio_outstream_get_latency;
pub extern fn soundio_outstream_get_latency(outstream: [*c]struct_SoundIoOutStream, out_latency: [*c]f64) SoundIoError;

pub const outstream_set_volume = soundio_outstream_set_volume;
extern fn soundio_outstream_set_volume(outstream: [*c]struct_SoundIoOutStream, volume: f64) SoundIoError;

pub const instream_create = soundio_instream_create;
extern fn soundio_instream_create(device: [*c]struct_SoundIoDevice) [*c]struct_SoundIoInStream;

pub const instream_destroy = soundio_instream_destory;
extern fn soundio_instream_destroy(instream: [*c]struct_SoundIoInStream) void;

pub const instream_open = soundio_instream_open;
extern fn soundio_instream_open(instream: [*c]struct_SoundIoInStream) SoundIoError;

pub const instream_start = soundio_instream_start;
extern fn soundio_instream_start(instream: [*c]struct_SoundIoInStream) SoundIoError;

pub const instream_begin_read = soundion_instream_begin_read;
extern fn soundio_instream_begin_read(instream: [*c]struct_SoundIoInStream, areas: [*c][*c]struct_SoundIoChannelArea, frame_count: [*c]SoundIoError) SoundIoError;

pub const instream_end_read = soundio_instream_end_read;
extern fn soundio_instream_end_read(instream: [*c]struct_SoundIoInStream) SoundIoError;

pub const instream_pause = soundio_instream_pause;
extern fn soundio_instream_pause(instream: [*c]struct_SoundIoInStream, pause: bool) SoundIoError;

pub const instream_get_latency = soundio_instream_get_latency;
extern fn soundio_instream_get_latency(instream: [*c]struct_SoundIoInStream, out_latency: [*c]f64) SoundIoError;

pub const struct_SoundIoRingBuffer = opaque {};

pub const ring_buffer_create = soundio_ring_buffer_create;
extern fn soundio_ring_buffer_create(soundio: [*c]struct_SoundIo, requested_capacity: SoundIoError) ?*struct_SoundIoRingBuffer;

pub const ring_buffer_destroy = soundio_ring_buffer_destroy;
extern fn soundio_ring_buffer_destroy(ring_buffer: ?*struct_SoundIoRingBuffer) void;

pub const ring_buffer_capacity = soundio_ring_buffer_capacity;
extern fn soundio_ring_buffer_capacity(ring_buffer: ?*struct_SoundIoRingBuffer) SoundIoError;

pub const ring_buffer_write_ptr = soundio_ring_buffer_write_ptr;
extern fn soundio_ring_buffer_write_ptr(ring_buffer: ?*struct_SoundIoRingBuffer) [*c]u8;

pub const ring_buffer_advance_write_ptr = soundio_ring_buffer_advance_ptr;
extern fn soundio_ring_buffer_advance_write_ptr(ring_buffer: ?*struct_SoundIoRingBuffer, count: SoundIoError) void;

pub const ring_buffer_read_ptr = soundio_ring_buffer_read_ptr;
extern fn soundio_ring_buffer_read_ptr(ring_buffer: ?*struct_SoundIoRingBuffer) [*c]u8;

pub const ring_buffer_advance_reader_ptr = soundio_ring_buffer_advance_read_ptr;
extern fn soundio_ring_buffer_advance_read_ptr(ring_buffer: ?*struct_SoundIoRingBuffer, count: SoundIoError) void;

pub const ring_buffer_fill_count = soundio_ring_buffer_fill_count;
pub extern fn soundio_ring_buffer_fill_count(ring_buffer: ?*struct_SoundIoRingBuffer) SoundIoError;

pub const ring_buffer_free_count = soundio_ring_buffer_free_count;
pub extern fn soundio_ring_buffer_free_count(ring_buffer: ?*struct_SoundIoRingBuffer) SoundIoError;

pub const ring_buffer_clear = soundio_ring_buffer_clear;
pub extern fn soundio_ring_buffer_clear(ring_buffer: ?*struct_SoundIoRingBuffer) void;

pub const SoundIoFormatFloat32NE = SoundIoFormatFloat32LE;
pub const SoundIoFormatU16FE = SoundIoFormatU16BE;
pub const SoundIoFormatS32NE = SoundIoFormatS32LE;
pub const SoundIoFormatFloat64NE = SoundIoFormatFloat64LE;
pub const SoundIoFormatU32NE = SoundIoFormatU32LE;
pub const SOUNDIO_MAX_CHANNELS = 24;
pub const SoundIoFormatU24NE = SoundIoFormatU24LE;
pub const SoundIoFormatS16FE = SoundIoFormatS16BE;
pub const SoundIoFormatS24FE = SoundIoFormatS24BE;
pub const SoundIoFormatS16NE = SoundIoFormatS16LE;
pub const SoundIoFormatU32FE = SoundIoFormatU32BE;
pub const SoundIoFormatS24NE = SoundIoFormatS24LE;
pub const SoundIoFormatFloat32FE = SoundIoFormatFloat32BE;
pub const SoundIoFormatU16NE = SoundIoFormatU16LE;
pub const SoundIoFormatFloat64FE = SoundIoFormatFloat64BE;
pub const SoundIoFormatU24FE = SoundIoFormatU24BE;
pub const SoundIoFormatS32FE = SoundIoFormatS32BE;
pub const SoundIoError = enum_SoundIoError;
pub const SoundIoChannelId = enum_SoundIoChannelId;
pub const SoundIoChannelLayoutId = enum_SoundIoChannelLayoutId;
pub const SoundIoBackend = enum_SoundIoBackend;
pub const SoundIoDeviceAim = enum_SoundIoDeviceAim;
pub const SoundIoFormat = enum_SoundIoFormat;
pub const SoundIoChannelLayout = struct_SoundIoChannelLayout;
pub const SoundIoSampleRateRange = struct_SoundIoSampleRateRange;
pub const SoundIoChannelArea = struct_SoundIoChannelArea;
pub const SoundIo = struct_SoundIo;
pub const SoundIoDevice = struct_SoundIoDevice;
pub const SoundIoOutStream = struct_SoundIoOutStream;
pub const SoundIoInStream = struct_SoundIoInStream;
pub const SoundIoRingBuffer = struct_SoundIoRingBuffer;
