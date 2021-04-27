pub const MPG123_ENC_8 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_8);
pub const MPG123_ENC_16 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_16);
pub const MPG123_ENC_24 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_24);
pub const MPG123_ENC_32 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_32);
pub const MPG123_ENC_SIGNED = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_SIGNED);
pub const MPG123_ENC_FLOAT = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_FLOAT);
pub const MPG123_ENC_SIGNED_16 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_SIGNED_16);
pub const MPG123_ENC_UNSIGNED_16 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_UNSIGNED_16);
pub const MPG123_ENC_UNSIGNED_8 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_UNSIGNED_8);
pub const MPG123_ENC_SIGNED_8 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_SIGNED_8);
pub const MPG123_ENC_ULAW_8 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_ULAW_8);
pub const MPG123_ENC_ALAW_8 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_ALAW_8);
pub const MPG123_ENC_SIGNED_32 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_SIGNED_32);
pub const MPG123_ENC_UNSIGNED_32 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_UNSIGNED_32);
pub const MPG123_ENC_SIGNED_24 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_SIGNED_24);
pub const MPG123_ENC_UNSIGNED_24 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_UNSIGNED_24);
pub const MPG123_ENC_FLOAT_32 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_FLOAT_32);
pub const MPG123_ENC_FLOAT_64 = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_FLOAT_64);
pub const MPG123_ENC_ANY = @enumToInt(enum_mpg123_enc_enum.MPG123_ENC_ANY);
pub const enum_mpg123_enc_enum = extern enum(c_int) {
    MPG123_ENC_8 = 15,
    MPG123_ENC_16 = 64,
    MPG123_ENC_24 = 16384,
    MPG123_ENC_32 = 256,
    MPG123_ENC_SIGNED = 128,
    MPG123_ENC_FLOAT = 3584,
    MPG123_ENC_SIGNED_16 = 208,
    MPG123_ENC_UNSIGNED_16 = 96,
    MPG123_ENC_UNSIGNED_8 = 1,
    MPG123_ENC_SIGNED_8 = 130,
    MPG123_ENC_ULAW_8 = 4,
    MPG123_ENC_ALAW_8 = 8,
    MPG123_ENC_SIGNED_32 = 4480,
    MPG123_ENC_UNSIGNED_32 = 8448,
    MPG123_ENC_SIGNED_24 = 20608,
    MPG123_ENC_UNSIGNED_24 = 24576,
    MPG123_ENC_FLOAT_32 = 512,
    MPG123_ENC_FLOAT_64 = 1024,
    MPG123_ENC_ANY = 30719,
};
pub const struct_mpg123_fmt = extern struct {
    rate: c_long,
    channels: c_int,
    encoding: c_int,
};
pub const wchar_t = c_int;
pub const _Float32 = f32;
pub const _Float64 = f64;
pub const _Float32x = f64;
pub const _Float64x = c_longdouble;
const struct_unnamed_1 = extern struct {
    quot: c_int,
    rem: c_int,
};
pub const div_t = struct_unnamed_1;
const struct_unnamed_2 = extern struct {
    quot: c_long,
    rem: c_long,
};
pub const ldiv_t = struct_unnamed_2;
const struct_unnamed_3 = extern struct {
    quot: c_longlong,
    rem: c_longlong,
};
pub const lldiv_t = struct_unnamed_3;
pub extern fn __ctype_get_mb_cur_max() usize;
pub extern fn atof(__nptr: [*c]const u8) f64;
pub extern fn atoi(__nptr: [*c]const u8) c_int;
pub extern fn atol(__nptr: [*c]const u8) c_long;
pub extern fn atoll(__nptr: [*c]const u8) c_longlong;
pub extern fn strtod(__nptr: [*c]const u8, __endptr: [*c][*c]u8) f64;
pub extern fn strtof(__nptr: [*c]const u8, __endptr: [*c][*c]u8) f32;
pub extern fn strtold(__nptr: [*c]const u8, __endptr: [*c][*c]u8) c_longdouble;
pub extern fn strtol(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_long;
pub extern fn strtoul(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_ulong;
pub extern fn strtoq(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_longlong;
pub extern fn strtouq(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_ulonglong;
pub extern fn strtoll(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_longlong;
pub extern fn strtoull(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_ulonglong;
pub extern fn l64a(__n: c_long) [*c]u8;
pub extern fn a64l(__s: [*c]const u8) c_long;
pub const __u_char = u8;
pub const __u_short = c_ushort;
pub const __u_int = c_uint;
pub const __u_long = c_ulong;
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_long;
pub const __uint64_t = c_ulong;
pub const __int_least8_t = __int8_t;
pub const __uint_least8_t = __uint8_t;
pub const __int_least16_t = __int16_t;
pub const __uint_least16_t = __uint16_t;
pub const __int_least32_t = __int32_t;
pub const __uint_least32_t = __uint32_t;
pub const __int_least64_t = __int64_t;
pub const __uint_least64_t = __uint64_t;
pub const __quad_t = c_long;
pub const __u_quad_t = c_ulong;
pub const __intmax_t = c_long;
pub const __uintmax_t = c_ulong;
pub const __dev_t = c_ulong;
pub const __uid_t = c_uint;
pub const __gid_t = c_uint;
pub const __ino_t = c_ulong;
pub const __ino64_t = c_ulong;
pub const __mode_t = c_uint;
pub const __nlink_t = c_ulong;
pub const __off_t = c_long;
pub const __off64_t = c_long;
pub const __pid_t = c_int;
const struct_unnamed_4 = extern struct {
    __val: [2]c_int,
};
pub const __fsid_t = struct_unnamed_4;
pub const __clock_t = c_long;
pub const __rlim_t = c_ulong;
pub const __rlim64_t = c_ulong;
pub const __id_t = c_uint;
pub const __time_t = c_long;
pub const __useconds_t = c_uint;
pub const __suseconds_t = c_long;
pub const __daddr_t = c_int;
pub const __key_t = c_int;
pub const __clockid_t = c_int;
pub const __timer_t = ?*c_void;
pub const __blksize_t = c_long;
pub const __blkcnt_t = c_long;
pub const __blkcnt64_t = c_long;
pub const __fsblkcnt_t = c_ulong;
pub const __fsblkcnt64_t = c_ulong;
pub const __fsfilcnt_t = c_ulong;
pub const __fsfilcnt64_t = c_ulong;
pub const __fsword_t = c_long;
pub const __ssize_t = c_long;
pub const __syscall_slong_t = c_long;
pub const __syscall_ulong_t = c_ulong;
pub const __loff_t = __off64_t;
pub const __caddr_t = [*c]u8;
pub const __intptr_t = c_long;
pub const __socklen_t = c_uint;
pub const __sig_atomic_t = c_int;
pub const u_char = __u_char;
pub const u_short = __u_short;
pub const u_int = __u_int;
pub const u_long = __u_long;
pub const quad_t = __quad_t;
pub const u_quad_t = __u_quad_t;
pub const fsid_t = __fsid_t;
pub const loff_t = __loff_t;
pub const ino_t = __ino_t;
pub const dev_t = __dev_t;
pub const gid_t = __gid_t;
pub const mode_t = __mode_t;
pub const nlink_t = __nlink_t;
pub const uid_t = __uid_t;
pub const off_t = __off_t;
pub const pid_t = __pid_t;
pub const id_t = __id_t;
pub const daddr_t = __daddr_t;
pub const caddr_t = __caddr_t;
pub const key_t = __key_t;
pub const clock_t = __clock_t;
pub const clockid_t = __clockid_t;
pub const time_t = __time_t;
pub const timer_t = __timer_t;
pub const ulong = c_ulong;
pub const ushort = c_ushort;
pub const uint = c_uint;
pub const u_int8_t = __uint8_t;
pub const u_int16_t = __uint16_t;
pub const u_int32_t = __uint32_t;
pub const u_int64_t = __uint64_t;
pub const register_t = c_long;
pub fn __bswap_16(arg___bsx: __uint16_t) callconv(.C) __uint16_t {
    var __bsx = arg___bsx;
    return (@bitCast(__uint16_t, @truncate(c_short, (((@bitCast(c_int, @as(c_uint, (__bsx))) >> @intCast(@import("std").math.Log2Int(c_int), 8)) & @as(c_int, 255)) | ((@bitCast(c_int, @as(c_uint, (__bsx))) & @as(c_int, 255)) << @intCast(@import("std").math.Log2Int(c_int), 8))))));
}
pub fn __bswap_32(arg___bsx: __uint32_t) callconv(.C) __uint32_t {
    var __bsx = arg___bsx;
    return ((((((__bsx) & @as(c_uint, 4278190080)) >> @intCast(@import("std").math.Log2Int(c_uint), 24)) | (((__bsx) & @as(c_uint, 16711680)) >> @intCast(@import("std").math.Log2Int(c_uint), 8))) | (((__bsx) & @as(c_uint, 65280)) << @intCast(@import("std").math.Log2Int(c_uint), 8))) | (((__bsx) & @as(c_uint, 255)) << @intCast(@import("std").math.Log2Int(c_uint), 24)));
}
pub fn __bswap_64(arg___bsx: __uint64_t) callconv(.C) __uint64_t {
    var __bsx = arg___bsx;
    return @bitCast(__uint64_t, @truncate(c_ulong, (((((((((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 18374686479671623680)) >> @intCast(@import("std").math.Log2Int(c_ulonglong), 56)) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 71776119061217280)) >> @intCast(@import("std").math.Log2Int(c_ulonglong), 40))) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 280375465082880)) >> @intCast(@import("std").math.Log2Int(c_ulonglong), 24))) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 1095216660480)) >> @intCast(@import("std").math.Log2Int(c_ulonglong), 8))) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 4278190080)) << @intCast(@import("std").math.Log2Int(c_ulonglong), 8))) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 16711680)) << @intCast(@import("std").math.Log2Int(c_ulonglong), 24))) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 65280)) << @intCast(@import("std").math.Log2Int(c_ulonglong), 40))) | ((@bitCast(c_ulonglong, @as(c_ulonglong, (__bsx))) & @as(c_ulonglong, 255)) << @intCast(@import("std").math.Log2Int(c_ulonglong), 56)))));
}
pub fn __uint16_identity(arg___x: __uint16_t) callconv(.C) __uint16_t {
    var __x = arg___x;
    return __x;
}
pub fn __uint32_identity(arg___x: __uint32_t) callconv(.C) __uint32_t {
    var __x = arg___x;
    return __x;
}
pub fn __uint64_identity(arg___x: __uint64_t) callconv(.C) __uint64_t {
    var __x = arg___x;
    return __x;
}
const struct_unnamed_5 = extern struct {
    __val: [16]c_ulong,
};
pub const __sigset_t = struct_unnamed_5;
pub const sigset_t = __sigset_t;
pub const struct_timeval = extern struct {
    tv_sec: __time_t,
    tv_usec: __suseconds_t,
};
pub const struct_timespec = extern struct {
    tv_sec: __time_t,
    tv_nsec: __syscall_slong_t,
};
pub const suseconds_t = __suseconds_t;
pub const __fd_mask = c_long;
const struct_unnamed_6 = extern struct {
    __fds_bits: [16]__fd_mask,
};
pub const fd_set = struct_unnamed_6;
pub const fd_mask = __fd_mask;
pub extern fn select(__nfds: c_int, noalias __readfds: [*c]fd_set, noalias __writefds: [*c]fd_set, noalias __exceptfds: [*c]fd_set, noalias __timeout: [*c]struct_timeval) c_int;
pub extern fn pselect(__nfds: c_int, noalias __readfds: [*c]fd_set, noalias __writefds: [*c]fd_set, noalias __exceptfds: [*c]fd_set, noalias __timeout: [*c]const struct_timespec, noalias __sigmask: [*c]const __sigset_t) c_int;
pub const blksize_t = __blksize_t;
pub const blkcnt_t = __blkcnt_t;
pub const fsblkcnt_t = __fsblkcnt_t;
pub const fsfilcnt_t = __fsfilcnt_t;
pub const struct___pthread_rwlock_arch_t = extern struct {
    __readers: c_uint,
    __writers: c_uint,
    __wrphase_futex: c_uint,
    __writers_futex: c_uint,
    __pad3: c_uint,
    __pad4: c_uint,
    __cur_writer: c_int,
    __shared: c_int,
    __rwelision: i8,
    __pad1: [7]u8,
    __pad2: c_ulong,
    __flags: c_uint,
};
pub const struct___pthread_internal_list = extern struct {
    __prev: [*c]struct___pthread_internal_list,
    __next: [*c]struct___pthread_internal_list,
};
pub const __pthread_list_t = struct___pthread_internal_list;
pub const struct___pthread_mutex_s = extern struct {
    __lock: c_int,
    __count: c_uint,
    __owner: c_int,
    __nusers: c_uint,
    __kind: c_int,
    __spins: c_short,
    __elision: c_short,
    __list: __pthread_list_t,
};
const struct_unnamed_9 = extern struct {
    __low: c_uint,
    __high: c_uint,
};
const union_unnamed_8 = extern union {
    __wseq: c_ulonglong,
    __wseq32: struct_unnamed_9,
};
const struct_unnamed_12 = extern struct {
    __low: c_uint,
    __high: c_uint,
};
const union_unnamed_11 = extern union {
    __g1_start: c_ulonglong,
    __g1_start32: struct_unnamed_12,
};
pub const struct___pthread_cond_s = extern struct {
    unnamed_7: union_unnamed_8,
    unnamed_10: union_unnamed_11,
    __g_refs: [2]c_uint,
    __g_size: [2]c_uint,
    __g1_orig_size: c_uint,
    __wrefs: c_uint,
    __g_signals: [2]c_uint,
};
pub const pthread_t = c_ulong;
const union_unnamed_13 = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_mutexattr_t = union_unnamed_13;
const union_unnamed_14 = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_condattr_t = union_unnamed_14;
pub const pthread_key_t = c_uint;
pub const pthread_once_t = c_int;
pub const union_pthread_attr_t = extern union {
    __size: [56]u8,
    __align: c_long,
};
pub const pthread_attr_t = union_pthread_attr_t;
const union_unnamed_15 = extern union {
    __data: struct___pthread_mutex_s,
    __size: [40]u8,
    __align: c_long,
};
pub const pthread_mutex_t = union_unnamed_15;
const union_unnamed_16 = extern union {
    __data: struct___pthread_cond_s,
    __size: [48]u8,
    __align: c_longlong,
};
pub const pthread_cond_t = union_unnamed_16;
const union_unnamed_17 = extern union {
    __data: struct___pthread_rwlock_arch_t,
    __size: [56]u8,
    __align: c_long,
};
pub const pthread_rwlock_t = union_unnamed_17;
const union_unnamed_18 = extern union {
    __size: [8]u8,
    __align: c_long,
};
pub const pthread_rwlockattr_t = union_unnamed_18;
pub const pthread_spinlock_t = c_int;
const union_unnamed_19 = extern union {
    __size: [32]u8,
    __align: c_long,
};
pub const pthread_barrier_t = union_unnamed_19;
const union_unnamed_20 = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_barrierattr_t = union_unnamed_20;
pub extern fn random() c_long;
pub extern fn srandom(__seed: c_uint) void;
pub extern fn initstate(__seed: c_uint, __statebuf: [*c]u8, __statelen: usize) [*c]u8;
pub extern fn setstate(__statebuf: [*c]u8) [*c]u8;
pub const struct_random_data = extern struct {
    fptr: [*c]i32,
    rptr: [*c]i32,
    state: [*c]i32,
    rand_type: c_int,
    rand_deg: c_int,
    rand_sep: c_int,
    end_ptr: [*c]i32,
};
pub extern fn random_r(noalias __buf: [*c]struct_random_data, noalias __result: [*c]i32) c_int;
pub extern fn srandom_r(__seed: c_uint, __buf: [*c]struct_random_data) c_int;
pub extern fn initstate_r(__seed: c_uint, noalias __statebuf: [*c]u8, __statelen: usize, noalias __buf: [*c]struct_random_data) c_int;
pub extern fn setstate_r(noalias __statebuf: [*c]u8, noalias __buf: [*c]struct_random_data) c_int;
pub extern fn rand() c_int;
pub extern fn srand(__seed: c_uint) void;
pub extern fn rand_r(__seed: [*c]c_uint) c_int;
pub extern fn drand48() f64;
pub extern fn erand48(__xsubi: [*c]c_ushort) f64;
pub extern fn lrand48() c_long;
pub extern fn nrand48(__xsubi: [*c]c_ushort) c_long;
pub extern fn mrand48() c_long;
pub extern fn jrand48(__xsubi: [*c]c_ushort) c_long;
pub extern fn srand48(__seedval: c_long) void;
pub extern fn seed48(__seed16v: [*c]c_ushort) [*c]c_ushort;
pub extern fn lcong48(__param: [*c]c_ushort) void;
pub const struct_drand48_data = extern struct {
    __x: [3]c_ushort,
    __old_x: [3]c_ushort,
    __c: c_ushort,
    __init: c_ushort,
    __a: c_ulonglong,
};
pub extern fn drand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]f64) c_int;
pub extern fn erand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]f64) c_int;
pub extern fn lrand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn nrand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn mrand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn jrand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn srand48_r(__seedval: c_long, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn seed48_r(__seed16v: [*c]c_ushort, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn lcong48_r(__param: [*c]c_ushort, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn malloc(__size: c_ulong) ?*c_void;
pub extern fn calloc(__nmemb: c_ulong, __size: c_ulong) ?*c_void;
pub extern fn realloc(__ptr: ?*c_void, __size: c_ulong) ?*c_void;
pub extern fn reallocarray(__ptr: ?*c_void, __nmemb: usize, __size: usize) ?*c_void;
pub extern fn free(__ptr: ?*c_void) void;
pub extern fn alloca(__size: c_ulong) ?*c_void;
pub extern fn valloc(__size: usize) ?*c_void;
pub extern fn posix_memalign(__memptr: [*c]?*c_void, __alignment: usize, __size: usize) c_int;
pub extern fn aligned_alloc(__alignment: usize, __size: usize) ?*c_void;
pub extern fn abort() noreturn;
pub extern fn atexit(__func: ?fn () callconv(.C) void) c_int;
pub extern fn at_quick_exit(__func: ?fn () callconv(.C) void) c_int;
pub extern fn on_exit(__func: ?fn (c_int, ?*c_void) callconv(.C) void, __arg: ?*c_void) c_int;
pub extern fn exit(__status: c_int) noreturn;
pub extern fn quick_exit(__status: c_int) noreturn;
pub extern fn _Exit(__status: c_int) noreturn;
pub extern fn getenv(__name: [*c]const u8) [*c]u8;
pub extern fn putenv(__string: [*c]u8) c_int;
pub extern fn setenv(__name: [*c]const u8, __value: [*c]const u8, __replace: c_int) c_int;
pub extern fn unsetenv(__name: [*c]const u8) c_int;
pub extern fn clearenv() c_int;
pub extern fn mktemp(__template: [*c]u8) [*c]u8;
pub extern fn mkstemp(__template: [*c]u8) c_int;
pub extern fn mkstemps(__template: [*c]u8, __suffixlen: c_int) c_int;
pub extern fn mkdtemp(__template: [*c]u8) [*c]u8;
pub extern fn system(__command: [*c]const u8) c_int;
pub extern fn realpath(noalias __name: [*c]const u8, noalias __resolved: [*c]u8) [*c]u8;
pub const __compar_fn_t = ?fn (?*const c_void, ?*const c_void) callconv(.C) c_int;
pub extern fn bsearch(__key: ?*const c_void, __base: ?*const c_void, __nmemb: usize, __size: usize, __compar: __compar_fn_t) ?*c_void;
pub extern fn qsort(__base: ?*c_void, __nmemb: usize, __size: usize, __compar: __compar_fn_t) void;
pub extern fn abs(__x: c_int) c_int;
pub extern fn labs(__x: c_long) c_long;
pub extern fn llabs(__x: c_longlong) c_longlong;
pub extern fn div(__numer: c_int, __denom: c_int) div_t;
pub extern fn ldiv(__numer: c_long, __denom: c_long) ldiv_t;
pub extern fn lldiv(__numer: c_longlong, __denom: c_longlong) lldiv_t;
pub extern fn ecvt(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn fcvt(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn gcvt(__value: f64, __ndigit: c_int, __buf: [*c]u8) [*c]u8;
pub extern fn qecvt(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn qfcvt(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn qgcvt(__value: c_longdouble, __ndigit: c_int, __buf: [*c]u8) [*c]u8;
pub extern fn ecvt_r(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn fcvt_r(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn qecvt_r(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn qfcvt_r(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn mblen(__s: [*c]const u8, __n: usize) c_int;
pub extern fn mbtowc(noalias __pwc: [*c]wchar_t, noalias __s: [*c]const u8, __n: usize) c_int;
pub extern fn wctomb(__s: [*c]u8, __wchar: wchar_t) c_int;
pub extern fn mbstowcs(noalias __pwcs: [*c]wchar_t, noalias __s: [*c]const u8, __n: usize) usize;
pub extern fn wcstombs(noalias __s: [*c]u8, noalias __pwcs: [*c]const wchar_t, __n: usize) usize;
pub extern fn rpmatch(__response: [*c]const u8) c_int;
pub extern fn getsubopt(noalias __optionp: [*c][*c]u8, noalias __tokens: [*c]const [*c]u8, noalias __valuep: [*c][*c]u8) c_int;
pub extern fn getloadavg(__loadavg: [*c]f64, __nelem: c_int) c_int;
pub const struct_mpg123_handle_struct = opaque {};
pub const mpg123_handle = struct_mpg123_handle_struct;

pub const init_lib = mpg123_init;
extern fn mpg123_init() mpg123_errors;

pub const exit_lib = mpg123_exit;
extern fn mpg123_exit() void;

pub const get_new_decoder_handle = mpg123_new;
extern fn mpg123_new(decoder: ?[*:0]const u8, @"error": [*c]c_int) ?*mpg123_handle;

pub const free_decoder = mpg123_delete;
extern fn mpg123_delete(mh: ?*mpg123_handle) void;

pub const MPG123_VERBOSE = @enumToInt(enum_mpg123_parms.MPG123_VERBOSE);
pub const MPG123_FLAGS = @enumToInt(enum_mpg123_parms.MPG123_FLAGS);
pub const MPG123_ADD_FLAGS = @enumToInt(enum_mpg123_parms.MPG123_ADD_FLAGS);
pub const MPG123_FORCE_RATE = @enumToInt(enum_mpg123_parms.MPG123_FORCE_RATE);
pub const MPG123_DOWN_SAMPLE = @enumToInt(enum_mpg123_parms.MPG123_DOWN_SAMPLE);
pub const MPG123_RVA = @enumToInt(enum_mpg123_parms.MPG123_RVA);
pub const MPG123_DOWNSPEED = @enumToInt(enum_mpg123_parms.MPG123_DOWNSPEED);
pub const MPG123_UPSPEED = @enumToInt(enum_mpg123_parms.MPG123_UPSPEED);
pub const MPG123_START_FRAME = @enumToInt(enum_mpg123_parms.MPG123_START_FRAME);
pub const MPG123_DECODE_FRAMES = @enumToInt(enum_mpg123_parms.MPG123_DECODE_FRAMES);
pub const MPG123_ICY_INTERVAL = @enumToInt(enum_mpg123_parms.MPG123_ICY_INTERVAL);
pub const MPG123_OUTSCALE = @enumToInt(enum_mpg123_parms.MPG123_OUTSCALE);
pub const MPG123_TIMEOUT = @enumToInt(enum_mpg123_parms.MPG123_TIMEOUT);
pub const MPG123_REMOVE_FLAGS = @enumToInt(enum_mpg123_parms.MPG123_REMOVE_FLAGS);
pub const MPG123_RESYNC_LIMIT = @enumToInt(enum_mpg123_parms.MPG123_RESYNC_LIMIT);
pub const MPG123_INDEX_SIZE = @enumToInt(enum_mpg123_parms.MPG123_INDEX_SIZE);
pub const MPG123_PREFRAMES = @enumToInt(enum_mpg123_parms.MPG123_PREFRAMES);
pub const MPG123_FEEDPOOL = @enumToInt(enum_mpg123_parms.MPG123_FEEDPOOL);
pub const MPG123_FEEDBUFFER = @enumToInt(enum_mpg123_parms.MPG123_FEEDBUFFER);
pub const enum_mpg123_parms = extern enum(c_int) {
    MPG123_VERBOSE = 0,
    MPG123_FLAGS = 1,
    MPG123_ADD_FLAGS = 2,
    MPG123_FORCE_RATE = 3,
    MPG123_DOWN_SAMPLE = 4,
    MPG123_RVA = 5,
    MPG123_DOWNSPEED = 6,
    MPG123_UPSPEED = 7,
    MPG123_START_FRAME = 8,
    MPG123_DECODE_FRAMES = 9,
    MPG123_ICY_INTERVAL = 10,
    MPG123_OUTSCALE = 11,
    MPG123_TIMEOUT = 12,
    MPG123_REMOVE_FLAGS = 13,
    MPG123_RESYNC_LIMIT = 14,
    MPG123_INDEX_SIZE = 15,
    MPG123_PREFRAMES = 16,
    MPG123_FEEDPOOL = 17,
    MPG123_FEEDBUFFER = 18,
    _,
};
pub const MPG123_FORCE_MONO = @enumToInt(enum_mpg123_param_flags.MPG123_FORCE_MONO);
pub const MPG123_MONO_LEFT = @enumToInt(enum_mpg123_param_flags.MPG123_MONO_LEFT);
pub const MPG123_MONO_RIGHT = @enumToInt(enum_mpg123_param_flags.MPG123_MONO_RIGHT);
pub const MPG123_MONO_MIX = @enumToInt(enum_mpg123_param_flags.MPG123_MONO_MIX);
pub const MPG123_FORCE_STEREO = @enumToInt(enum_mpg123_param_flags.MPG123_FORCE_STEREO);
pub const MPG123_FORCE_8BIT = @enumToInt(enum_mpg123_param_flags.MPG123_FORCE_8BIT);
pub const MPG123_QUIET = @enumToInt(enum_mpg123_param_flags.MPG123_QUIET);
pub const MPG123_GAPLESS = @enumToInt(enum_mpg123_param_flags.MPG123_GAPLESS);
pub const MPG123_NO_RESYNC = @enumToInt(enum_mpg123_param_flags.MPG123_NO_RESYNC);
pub const MPG123_SEEKBUFFER = @enumToInt(enum_mpg123_param_flags.MPG123_SEEKBUFFER);
pub const MPG123_FUZZY = @enumToInt(enum_mpg123_param_flags.MPG123_FUZZY);
pub const MPG123_FORCE_FLOAT = @enumToInt(enum_mpg123_param_flags.MPG123_FORCE_FLOAT);
pub const MPG123_PLAIN_ID3TEXT = @enumToInt(enum_mpg123_param_flags.MPG123_PLAIN_ID3TEXT);
pub const MPG123_IGNORE_STREAMLENGTH = @enumToInt(enum_mpg123_param_flags.MPG123_IGNORE_STREAMLENGTH);
pub const MPG123_SKIP_ID3V2 = @enumToInt(enum_mpg123_param_flags.MPG123_SKIP_ID3V2);
pub const MPG123_IGNORE_INFOFRAME = @enumToInt(enum_mpg123_param_flags.MPG123_IGNORE_INFOFRAME);
pub const MPG123_AUTO_RESAMPLE = @enumToInt(enum_mpg123_param_flags.MPG123_AUTO_RESAMPLE);
pub const MPG123_PICTURE = @enumToInt(enum_mpg123_param_flags.MPG123_PICTURE);
pub const MPG123_NO_PEEK_END = @enumToInt(enum_mpg123_param_flags.MPG123_NO_PEEK_END);
pub const MPG123_FORCE_SEEKABLE = @enumToInt(enum_mpg123_param_flags.MPG123_FORCE_SEEKABLE);
pub const enum_mpg123_param_flags = extern enum(c_int) {
    MPG123_FORCE_MONO = 7,
    MPG123_MONO_LEFT = 1,
    MPG123_MONO_RIGHT = 2,
    MPG123_MONO_MIX = 4,
    MPG123_FORCE_STEREO = 8,
    MPG123_FORCE_8BIT = 16,
    MPG123_QUIET = 32,
    MPG123_GAPLESS = 64,
    MPG123_NO_RESYNC = 128,
    MPG123_SEEKBUFFER = 256,
    MPG123_FUZZY = 512,
    MPG123_FORCE_FLOAT = 1024,
    MPG123_PLAIN_ID3TEXT = 2048,
    MPG123_IGNORE_STREAMLENGTH = 4096,
    MPG123_SKIP_ID3V2 = 8192,
    MPG123_IGNORE_INFOFRAME = 16384,
    MPG123_AUTO_RESAMPLE = 32768,
    MPG123_PICTURE = 65536,
    MPG123_NO_PEEK_END = 131072,
    MPG123_FORCE_SEEKABLE = 262144,
    _,
};
pub const MPG123_RVA_OFF = @enumToInt(enum_mpg123_param_rva.MPG123_RVA_OFF);
pub const MPG123_RVA_MIX = @enumToInt(enum_mpg123_param_rva.MPG123_RVA_MIX);
pub const MPG123_RVA_ALBUM = @enumToInt(enum_mpg123_param_rva.MPG123_RVA_ALBUM);
pub const MPG123_RVA_MAX = @enumToInt(enum_mpg123_param_rva.MPG123_RVA_MAX);
pub const enum_mpg123_param_rva = extern enum(c_int) {
    MPG123_RVA_OFF = 0,
    MPG123_RVA_MIX = 1,
    MPG123_RVA_ALBUM = 2,
    MPG123_RVA_MAX = 2,
    _,
};
pub const set_decoder_param = mpg123_param;
extern fn mpg123_param(mh: *mpg123_handle, type: enum_mpg123_parms, value: c_long, fvalue: f64) mpg123_errors;

pub const get_decoder_param = mpg123_getparam;
extern fn mpg123_getparam(mh: ?*mpg123_handle, type: enum_mpg123_parms, value: [*c]c_long, fvalue: [*c]f64) mpg123_errors;

pub const MPG123_FEATURE_ABI_UTF8OPEN = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_ABI_UTF8OPEN);
pub const MPG123_FEATURE_OUTPUT_8BIT = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_OUTPUT_8BIT);
pub const MPG123_FEATURE_OUTPUT_16BIT = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_OUTPUT_16BIT);
pub const MPG123_FEATURE_OUTPUT_32BIT = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_OUTPUT_32BIT);
pub const MPG123_FEATURE_INDEX = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_INDEX);
pub const MPG123_FEATURE_PARSE_ID3V2 = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_PARSE_ID3V2);
pub const MPG123_FEATURE_DECODE_LAYER1 = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_DECODE_LAYER1);
pub const MPG123_FEATURE_DECODE_LAYER2 = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_DECODE_LAYER2);
pub const MPG123_FEATURE_DECODE_LAYER3 = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_DECODE_LAYER3);
pub const MPG123_FEATURE_DECODE_ACCURATE = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_DECODE_ACCURATE);
pub const MPG123_FEATURE_DECODE_DOWNSAMPLE = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_DECODE_DOWNSAMPLE);
pub const MPG123_FEATURE_DECODE_NTOM = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_DECODE_NTOM);
pub const MPG123_FEATURE_PARSE_ICY = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_PARSE_ICY);
pub const MPG123_FEATURE_TIMEOUT_READ = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_TIMEOUT_READ);
pub const MPG123_FEATURE_EQUALIZER = @enumToInt(enum_mpg123_feature_set.MPG123_FEATURE_EQUALIZER);
pub const enum_mpg123_feature_set = extern enum(c_int) {
    MPG123_FEATURE_ABI_UTF8OPEN = 0,
    MPG123_FEATURE_OUTPUT_8BIT = 1,
    MPG123_FEATURE_OUTPUT_16BIT = 2,
    MPG123_FEATURE_OUTPUT_32BIT = 3,
    MPG123_FEATURE_INDEX = 4,
    MPG123_FEATURE_PARSE_ID3V2 = 5,
    MPG123_FEATURE_DECODE_LAYER1 = 6,
    MPG123_FEATURE_DECODE_LAYER2 = 7,
    MPG123_FEATURE_DECODE_LAYER3 = 8,
    MPG123_FEATURE_DECODE_ACCURATE = 9,
    MPG123_FEATURE_DECODE_DOWNSAMPLE = 10,
    MPG123_FEATURE_DECODE_NTOM = 11,
    MPG123_FEATURE_PARSE_ICY = 12,
    MPG123_FEATURE_TIMEOUT_READ = 13,
    MPG123_FEATURE_EQUALIZER = 14,
    _,
};

pub const query_lib_feature_support = mpg123_feature;
pub extern fn mpg123_feature(key: enum_mpg123_feature_set) c_int;

pub const MPG123_DONE = @enumToInt(enum_mpg123_errors.MPG123_DONE);
pub const MPG123_NEW_FORMAT = @enumToInt(enum_mpg123_errors.MPG123_NEW_FORMAT);
pub const MPG123_NEED_MORE = @enumToInt(enum_mpg123_errors.MPG123_NEED_MORE);
pub const MPG123_ERR = @enumToInt(enum_mpg123_errors.MPG123_ERR);
pub const MPG123_OK = @enumToInt(enum_mpg123_errors.MPG123_OK);
pub const MPG123_BAD_OUTFORMAT = @enumToInt(enum_mpg123_errors.MPG123_BAD_OUTFORMAT);
pub const MPG123_BAD_CHANNEL = @enumToInt(enum_mpg123_errors.MPG123_BAD_CHANNEL);
pub const MPG123_BAD_RATE = @enumToInt(enum_mpg123_errors.MPG123_BAD_RATE);
pub const MPG123_ERR_16TO8TABLE = @enumToInt(enum_mpg123_errors.MPG123_ERR_16TO8TABLE);
pub const MPG123_BAD_PARAM = @enumToInt(enum_mpg123_errors.MPG123_BAD_PARAM);
pub const MPG123_BAD_BUFFER = @enumToInt(enum_mpg123_errors.MPG123_BAD_BUFFER);
pub const MPG123_OUT_OF_MEM = @enumToInt(enum_mpg123_errors.MPG123_OUT_OF_MEM);
pub const MPG123_NOT_INITIALIZED = @enumToInt(enum_mpg123_errors.MPG123_NOT_INITIALIZED);
pub const MPG123_BAD_DECODER = @enumToInt(enum_mpg123_errors.MPG123_BAD_DECODER);
pub const MPG123_BAD_HANDLE = @enumToInt(enum_mpg123_errors.MPG123_BAD_HANDLE);
pub const MPG123_NO_BUFFERS = @enumToInt(enum_mpg123_errors.MPG123_NO_BUFFERS);
pub const MPG123_BAD_RVA = @enumToInt(enum_mpg123_errors.MPG123_BAD_RVA);
pub const MPG123_NO_GAPLESS = @enumToInt(enum_mpg123_errors.MPG123_NO_GAPLESS);
pub const MPG123_NO_SPACE = @enumToInt(enum_mpg123_errors.MPG123_NO_SPACE);
pub const MPG123_BAD_TYPES = @enumToInt(enum_mpg123_errors.MPG123_BAD_TYPES);
pub const MPG123_BAD_BAND = @enumToInt(enum_mpg123_errors.MPG123_BAD_BAND);
pub const MPG123_ERR_NULL = @enumToInt(enum_mpg123_errors.MPG123_ERR_NULL);
pub const MPG123_ERR_READER = @enumToInt(enum_mpg123_errors.MPG123_ERR_READER);
pub const MPG123_NO_SEEK_FROM_END = @enumToInt(enum_mpg123_errors.MPG123_NO_SEEK_FROM_END);
pub const MPG123_BAD_WHENCE = @enumToInt(enum_mpg123_errors.MPG123_BAD_WHENCE);
pub const MPG123_NO_TIMEOUT = @enumToInt(enum_mpg123_errors.MPG123_NO_TIMEOUT);
pub const MPG123_BAD_FILE = @enumToInt(enum_mpg123_errors.MPG123_BAD_FILE);
pub const MPG123_NO_SEEK = @enumToInt(enum_mpg123_errors.MPG123_NO_SEEK);
pub const MPG123_NO_READER = @enumToInt(enum_mpg123_errors.MPG123_NO_READER);
pub const MPG123_BAD_PARS = @enumToInt(enum_mpg123_errors.MPG123_BAD_PARS);
pub const MPG123_BAD_INDEX_PAR = @enumToInt(enum_mpg123_errors.MPG123_BAD_INDEX_PAR);
pub const MPG123_OUT_OF_SYNC = @enumToInt(enum_mpg123_errors.MPG123_OUT_OF_SYNC);
pub const MPG123_RESYNC_FAIL = @enumToInt(enum_mpg123_errors.MPG123_RESYNC_FAIL);
pub const MPG123_NO_8BIT = @enumToInt(enum_mpg123_errors.MPG123_NO_8BIT);
pub const MPG123_BAD_ALIGN = @enumToInt(enum_mpg123_errors.MPG123_BAD_ALIGN);
pub const MPG123_NULL_BUFFER = @enumToInt(enum_mpg123_errors.MPG123_NULL_BUFFER);
pub const MPG123_NO_RELSEEK = @enumToInt(enum_mpg123_errors.MPG123_NO_RELSEEK);
pub const MPG123_NULL_POINTER = @enumToInt(enum_mpg123_errors.MPG123_NULL_POINTER);
pub const MPG123_BAD_KEY = @enumToInt(enum_mpg123_errors.MPG123_BAD_KEY);
pub const MPG123_NO_INDEX = @enumToInt(enum_mpg123_errors.MPG123_NO_INDEX);
pub const MPG123_INDEX_FAIL = @enumToInt(enum_mpg123_errors.MPG123_INDEX_FAIL);
pub const MPG123_BAD_DECODER_SETUP = @enumToInt(enum_mpg123_errors.MPG123_BAD_DECODER_SETUP);
pub const MPG123_MISSING_FEATURE = @enumToInt(enum_mpg123_errors.MPG123_MISSING_FEATURE);
pub const MPG123_BAD_VALUE = @enumToInt(enum_mpg123_errors.MPG123_BAD_VALUE);
pub const MPG123_LSEEK_FAILED = @enumToInt(enum_mpg123_errors.MPG123_LSEEK_FAILED);
pub const MPG123_BAD_CUSTOM_IO = @enumToInt(enum_mpg123_errors.MPG123_BAD_CUSTOM_IO);
pub const MPG123_LFS_OVERFLOW = @enumToInt(enum_mpg123_errors.MPG123_LFS_OVERFLOW);
pub const MPG123_INT_OVERFLOW = @enumToInt(enum_mpg123_errors.MPG123_INT_OVERFLOW);
pub const enum_mpg123_errors = extern enum(c_int) {
    MPG123_DONE = -12,
    MPG123_NEW_FORMAT = -11,
    MPG123_NEED_MORE = -10,
    MPG123_ERR = -1,
    MPG123_OK = 0,
    MPG123_BAD_OUTFORMAT = 1,
    MPG123_BAD_CHANNEL = 2,
    MPG123_BAD_RATE = 3,
    MPG123_ERR_16TO8TABLE = 4,
    MPG123_BAD_PARAM = 5,
    MPG123_BAD_BUFFER = 6,
    MPG123_OUT_OF_MEM = 7,
    MPG123_NOT_INITIALIZED = 8,
    MPG123_BAD_DECODER = 9,
    MPG123_BAD_HANDLE = 10,
    MPG123_NO_BUFFERS = 11,
    MPG123_BAD_RVA = 12,
    MPG123_NO_GAPLESS = 13,
    MPG123_NO_SPACE = 14,
    MPG123_BAD_TYPES = 15,
    MPG123_BAD_BAND = 16,
    MPG123_ERR_NULL = 17,
    MPG123_ERR_READER = 18,
    MPG123_NO_SEEK_FROM_END = 19,
    MPG123_BAD_WHENCE = 20,
    MPG123_NO_TIMEOUT = 21,
    MPG123_BAD_FILE = 22,
    MPG123_NO_SEEK = 23,
    MPG123_NO_READER = 24,
    MPG123_BAD_PARS = 25,
    MPG123_BAD_INDEX_PAR = 26,
    MPG123_OUT_OF_SYNC = 27,
    MPG123_RESYNC_FAIL = 28,
    MPG123_NO_8BIT = 29,
    MPG123_BAD_ALIGN = 30,
    MPG123_NULL_BUFFER = 31,
    MPG123_NO_RELSEEK = 32,
    MPG123_NULL_POINTER = 33,
    MPG123_BAD_KEY = 34,
    MPG123_NO_INDEX = 35,
    MPG123_INDEX_FAIL = 36,
    MPG123_BAD_DECODER_SETUP = 37,
    MPG123_MISSING_FEATURE = 38,
    MPG123_BAD_VALUE = 39,
    MPG123_LSEEK_FAILED = 40,
    MPG123_BAD_CUSTOM_IO = 41,
    MPG123_LFS_OVERFLOW = 42,
    MPG123_INT_OVERFLOW = 43,
};
pub extern fn mpg123_plain_strerror(errcode: c_int) [*c]const u8;
pub extern fn mpg123_strerror(mh: ?*mpg123_handle) [*c]const u8;
pub extern fn mpg123_errcode(mh: ?*mpg123_handle) c_int;

pub const get_decoder_names = mpg123_decoders;
extern fn mpg123_decoders() [*:null][*:0]const u8;

pub const get_supported_decoder_names = mpg123_supported_decoders;
extern fn mpg123_supported_decoders() [*:null]?[*:0]const u8;

pub const set_active_decoder = mpg123_decoder;
extern fn mpg123_decoder(mh: ?*mpg123_handle, decoder_name: [*:0]const u8) mpg123_errors;

pub const get_active_decoder = mpg123_current_decoder;
pub extern fn mpg123_current_decoder(mh: *mpg123_handle) [*:0]const u8;

pub const MPG123_MONO = @enumToInt(enum_mpg123_channelcount.MPG123_MONO);
pub const MPG123_STEREO = @enumToInt(enum_mpg123_channelcount.MPG123_STEREO);
pub const enum_mpg123_channelcount = extern enum(c_int) {
    MPG123_MONO = 1,
    MPG123_STEREO = 2,
};

pub const get_supported_sample_rates = mpg123_rates;
extern fn mpg123_rates(list: *[*]const c_long, in_number: *usize) void;

pub const get_supported_encodings = mpg123_encodings;
extern fn mpg123_encodings(list: *[*]const c_int, in_number: *usize) void;

pub const get_encsize = mpg123_encsize;
extern fn mpg123_encsize(encoding: c_int) c_int;

pub const set_decoder_format_none = mpg123_format_none;
extern fn mpg123_format_none(mh: *mpg123_handle) mpg123_errors;

pub const set_decoder_format_all = mpg123_format_all;
extern fn mpg123_format_all(mh: *mpg123_handle) mpg123_errors;

pub const set_decoder_format = mpg123_format;
extern fn mpg123_format(mh: *mpg123_handle, rate: c_long, channels: mpg123_channelcount, encodings: mpg123_enc_enum) mpg123_errors;

pub const check_decoder_format_support = mpg123_format_support;
extern fn mpg123_format_support(mh: ?*mpg123_handle, rate: c_long, encoding: c_int) mpg123_errors;

pub const get_source_format = mpg123_getformat;
extern fn mpg123_getformat(mh: ?*mpg123_handle, rate: [*c]c_long, out_channels: [*c]mpg123_channelcount, out_encoding: *mpg123_enc_enum) mpg123_errors;

pub const get_source_format_extra = mpg123_getformat2;
extern fn mpg123_getformat2(mh: ?*mpg123_handle, rate: [*c]c_long, channels: [*c]c_int, encoding: [*c]c_int, clear_flag: c_int) mpg123_errors;

pub const load_source_from_path = mpg123_open;
extern fn mpg123_open(mh: ?*mpg123_handle, path: [*:0]const u8) mpg123_errors;

pub const load_source_from_fd = mpg123_open_fd;
extern fn mpg123_open_fd(mh: ?*mpg123_handle, fd: c_int) mpg123_errors;

pub const load_source_from_handle = mpg123_open_handle;
extern fn mpg123_open_handle(mh: ?*mpg123_handle, iohandle: ?*c_void) c_int;

pub const open_source_feed = mpg123_open_feed;
extern fn mpg123_open_feed(mh: ?*mpg123_handle) mpg123_errors;

pub const close_source = mpg123_close;
extern fn mpg123_close(mh: ?*mpg123_handle) mpg123_errors;

pub const read_and_decode_source = mpg123_read;
extern fn mpg123_read(mh: ?*mpg123_handle, outmemory: [*]u8, outmemsize: usize, done: [*c]usize) mpg123_errors;

pub const queue_source_bytes = mpg123_feed;
extern fn mpg123_feed(mh: ?*mpg123_handle, in: [*]const u8, size: usize) mpg123_errors;

const decode_bytes_into_buffer = mpg123_decode;
pub extern fn mpg123_decode(mh: ?*mpg123_handle, inmemory: [*]const u8, inmemsize: usize, outmemory: [*]u8, outmemsize: usize, done: [*c]usize) mpg123_errors;

pub const decode_frame = mpg123_decode_frame;
extern fn mpg123_decode_frame(mh: ?*mpg123_handle, num: [*c]off_t, audio: [*c][*c]u8, bytes: [*c]usize) mpg123_errors;

pub const decode_curent_frame_into_buffer = mpg123_framebyframe_decode;
extern fn mpg123_framebyframe_decode(mh: ?*mpg123_handle, num: [*c]off_t, audio: [*c][*c]u8, bytes: [*c]usize) mpg123_errors;

pub const decode_next_frame = mpg123_framebyframe_next;
extern fn mpg123_framebyframe_next(mh: ?*mpg123_handle) mpg123_errors;

pub const get_frame_data = mpg123_framedate;
extern fn mpg123_framedata(mh: ?*mpg123_handle, header: [*c]c_ulong, bodydata: [*c][*c]u8, bodybytes: [*c]usize) mpg123_errors;

pub const get_current_frame_source_offset = mpg123_framepos;
pub extern fn mpg123_framepos(mh: ?*mpg123_handle) off_t;

pub extern fn mpg123_tell(mh: ?*mpg123_handle) off_t;
pub extern fn mpg123_tellframe(mh: ?*mpg123_handle) off_t;
pub extern fn mpg123_tell_stream(mh: ?*mpg123_handle) off_t;
pub extern fn mpg123_seek(mh: ?*mpg123_handle, sampleoff: off_t, whence: c_int) off_t;
pub extern fn mpg123_feedseek(mh: ?*mpg123_handle, sampleoff: off_t, whence: c_int, input_offset: [*c]off_t) off_t;

pub const seek_frame = mpg123_seek_frame;
extern fn mpg123_seek_frame(mh: ?*mpg123_handle, frameoff: off_t, whence: c_int) off_t;

pub extern fn mpg123_timeframe(mh: ?*mpg123_handle, sec: f64) off_t;
pub extern fn mpg123_index(mh: ?*mpg123_handle, offsets: [*c][*c]off_t, step: [*c]off_t, fill: [*c]usize) c_int;
pub extern fn mpg123_set_index(mh: ?*mpg123_handle, offsets: [*c]off_t, step: off_t, fill: usize) c_int;
pub extern fn mpg123_position(mh: ?*mpg123_handle, frame_offset: off_t, buffered_bytes: off_t, current_frame: [*c]off_t, frames_left: [*c]off_t, current_seconds: [*c]f64, seconds_left: [*c]f64) c_int;
pub const MPG123_LEFT = @enumToInt(enum_mpg123_channels.MPG123_LEFT);
pub const MPG123_RIGHT = @enumToInt(enum_mpg123_channels.MPG123_RIGHT);
pub const MPG123_LR = @enumToInt(enum_mpg123_channels.MPG123_LR);
pub const enum_mpg123_channels = extern enum(c_int) {
    MPG123_LEFT = 1,
    MPG123_RIGHT = 2,
    MPG123_LR = 3,
    _,
};
pub extern fn mpg123_eq(mh: ?*mpg123_handle, channel: enum_mpg123_channels, band: c_int, val: f64) c_int;
pub extern fn mpg123_geteq(mh: ?*mpg123_handle, channel: enum_mpg123_channels, band: c_int) f64;
pub extern fn mpg123_reset_eq(mh: ?*mpg123_handle) c_int;
pub extern fn mpg123_volume(mh: ?*mpg123_handle, vol: f64) c_int;
pub extern fn mpg123_volume_change(mh: ?*mpg123_handle, change: f64) c_int;
pub extern fn mpg123_getvolume(mh: ?*mpg123_handle, base: [*c]f64, really: [*c]f64, rva_db: [*c]f64) c_int;
pub const MPG123_CBR = @enumToInt(enum_mpg123_vbr.MPG123_CBR);
pub const MPG123_VBR = @enumToInt(enum_mpg123_vbr.MPG123_VBR);
pub const MPG123_ABR = @enumToInt(enum_mpg123_vbr.MPG123_ABR);
pub const enum_mpg123_vbr = extern enum(c_int) {
    MPG123_CBR = 0,
    MPG123_VBR = 1,
    MPG123_ABR = 2,
    _,
};
pub const MPG123_1_0 = @enumToInt(enum_mpg123_version.MPG123_1_0);
pub const MPG123_2_0 = @enumToInt(enum_mpg123_version.MPG123_2_0);
pub const MPG123_2_5 = @enumToInt(enum_mpg123_version.MPG123_2_5);
pub const enum_mpg123_version = extern enum(c_int) {
    MPG123_1_0 = 0,
    MPG123_2_0 = 1,
    MPG123_2_5 = 2,
    _,
};
pub const MPG123_M_STEREO = @enumToInt(enum_mpg123_mode.MPG123_M_STEREO);
pub const MPG123_M_JOINT = @enumToInt(enum_mpg123_mode.MPG123_M_JOINT);
pub const MPG123_M_DUAL = @enumToInt(enum_mpg123_mode.MPG123_M_DUAL);
pub const MPG123_M_MONO = @enumToInt(enum_mpg123_mode.MPG123_M_MONO);
pub const enum_mpg123_mode = extern enum(c_int) {
    MPG123_M_STEREO = 0,
    MPG123_M_JOINT = 1,
    MPG123_M_DUAL = 2,
    MPG123_M_MONO = 3,
    _,
};
pub const MPG123_CRC = @enumToInt(enum_mpg123_flags.MPG123_CRC);
pub const MPG123_COPYRIGHT = @enumToInt(enum_mpg123_flags.MPG123_COPYRIGHT);
pub const MPG123_PRIVATE = @enumToInt(enum_mpg123_flags.MPG123_PRIVATE);
pub const MPG123_ORIGINAL = @enumToInt(enum_mpg123_flags.MPG123_ORIGINAL);
pub const enum_mpg123_flags = extern enum(c_int) {
    MPG123_CRC = 1,
    MPG123_COPYRIGHT = 2,
    MPG123_PRIVATE = 4,
    MPG123_ORIGINAL = 8,
    _,
};
pub const struct_mpg123_frameinfo = extern struct {
    version: enum_mpg123_version,
    layer: c_int,
    rate: c_long,
    mode: enum_mpg123_mode,
    mode_ext: c_int,
    framesize: c_int,
    flags: enum_mpg123_flags,
    emphasis: c_int,
    bitrate: c_int,
    abr_rate: c_int,
    vbr: enum_mpg123_vbr,
};
pub extern fn mpg123_info(mh: ?*mpg123_handle, mi: [*c]struct_mpg123_frameinfo) c_int;
pub extern fn mpg123_safe_buffer() usize;
pub extern fn mpg123_scan(mh: ?*mpg123_handle) c_int;
pub extern fn mpg123_framelength(mh: ?*mpg123_handle) off_t;
pub extern fn mpg123_length(mh: ?*mpg123_handle) off_t;
pub extern fn mpg123_set_filesize(mh: ?*mpg123_handle, size: off_t) c_int;
pub extern fn mpg123_tpf(mh: ?*mpg123_handle) f64;
pub extern fn mpg123_spf(mh: ?*mpg123_handle) c_int;
pub extern fn mpg123_clip(mh: ?*mpg123_handle) c_long;
pub const MPG123_ACCURATE = @enumToInt(enum_mpg123_state.MPG123_ACCURATE);
pub const MPG123_BUFFERFILL = @enumToInt(enum_mpg123_state.MPG123_BUFFERFILL);
pub const MPG123_FRANKENSTEIN = @enumToInt(enum_mpg123_state.MPG123_FRANKENSTEIN);
pub const MPG123_FRESH_DECODER = @enumToInt(enum_mpg123_state.MPG123_FRESH_DECODER);
pub const enum_mpg123_state = extern enum(c_int) {
    MPG123_ACCURATE = 1,
    MPG123_BUFFERFILL = 2,
    MPG123_FRANKENSTEIN = 3,
    MPG123_FRESH_DECODER = 4,
    _,
};
pub extern fn mpg123_getstate(mh: ?*mpg123_handle, key: enum_mpg123_state, val: [*c]c_long, fval: [*c]f64) c_int;
const struct_unnamed_21 = extern struct {
    p: [*c]u8,
    size: usize,
    fill: usize,
};
pub const mpg123_string = struct_unnamed_21;
pub extern fn mpg123_init_string(sb: [*c]mpg123_string) void;
pub extern fn mpg123_free_string(sb: [*c]mpg123_string) void;
pub extern fn mpg123_resize_string(sb: [*c]mpg123_string, news: usize) c_int;
pub extern fn mpg123_grow_string(sb: [*c]mpg123_string, news: usize) c_int;
pub extern fn mpg123_copy_string(from: [*c]mpg123_string, to: [*c]mpg123_string) c_int;
pub extern fn mpg123_add_string(sb: [*c]mpg123_string, stuff: [*c]const u8) c_int;
pub extern fn mpg123_add_substring(sb: [*c]mpg123_string, stuff: [*c]const u8, from: usize, count: usize) c_int;
pub extern fn mpg123_set_string(sb: [*c]mpg123_string, stuff: [*c]const u8) c_int;
pub extern fn mpg123_set_substring(sb: [*c]mpg123_string, stuff: [*c]const u8, from: usize, count: usize) c_int;
pub extern fn mpg123_strlen(sb: [*c]mpg123_string, utf8: c_int) usize;
pub extern fn mpg123_chomp_string(sb: [*c]mpg123_string) c_int;
pub const mpg123_text_unknown = @enumToInt(enum_mpg123_text_encoding.mpg123_text_unknown);
pub const mpg123_text_utf8 = @enumToInt(enum_mpg123_text_encoding.mpg123_text_utf8);
pub const mpg123_text_latin1 = @enumToInt(enum_mpg123_text_encoding.mpg123_text_latin1);
pub const mpg123_text_icy = @enumToInt(enum_mpg123_text_encoding.mpg123_text_icy);
pub const mpg123_text_cp1252 = @enumToInt(enum_mpg123_text_encoding.mpg123_text_cp1252);
pub const mpg123_text_utf16 = @enumToInt(enum_mpg123_text_encoding.mpg123_text_utf16);
pub const mpg123_text_utf16bom = @enumToInt(enum_mpg123_text_encoding.mpg123_text_utf16bom);
pub const mpg123_text_utf16be = @enumToInt(enum_mpg123_text_encoding.mpg123_text_utf16be);
pub const mpg123_text_max = @enumToInt(enum_mpg123_text_encoding.mpg123_text_max);
pub const enum_mpg123_text_encoding = extern enum(c_int) {
    mpg123_text_unknown = 0,
    mpg123_text_utf8 = 1,
    mpg123_text_latin1 = 2,
    mpg123_text_icy = 3,
    mpg123_text_cp1252 = 4,
    mpg123_text_utf16 = 5,
    mpg123_text_utf16bom = 6,
    mpg123_text_utf16be = 7,
    mpg123_text_max = 7,
    _,
};
pub const mpg123_id3_latin1 = @enumToInt(enum_mpg123_id3_enc.mpg123_id3_latin1);
pub const mpg123_id3_utf16bom = @enumToInt(enum_mpg123_id3_enc.mpg123_id3_utf16bom);
pub const mpg123_id3_utf16be = @enumToInt(enum_mpg123_id3_enc.mpg123_id3_utf16be);
pub const mpg123_id3_utf8 = @enumToInt(enum_mpg123_id3_enc.mpg123_id3_utf8);
pub const mpg123_id3_enc_max = @enumToInt(enum_mpg123_id3_enc._max);
pub const enum_mpg123_id3_enc = extern enum(c_int) {
    mpg123_id3_latin1 = 0,
    mpg123_id3_utf16bom = 1,
    mpg123_id3_utf16be = 2,
    mpg123_id3_utf8 = 3,
    _max = 3,
    _,
};
pub extern fn mpg123_enc_from_id3(id3_enc_byte: u8) enum_mpg123_text_encoding;
pub extern fn mpg123_store_utf8(sb: [*c]mpg123_string, enc: enum_mpg123_text_encoding, source: [*c]const u8, source_size: usize) c_int;
const struct_unnamed_22 = extern struct {
    lang: [3]u8,
    id: [4]u8,
    description: mpg123_string,
    text: mpg123_string,
};
pub const mpg123_text = struct_unnamed_22;
pub const mpg123_id3_pic_other = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_other);
pub const mpg123_id3_pic_icon = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_icon);
pub const mpg123_id3_pic_other_icon = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_other_icon);
pub const mpg123_id3_pic_front_cover = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_front_cover);
pub const mpg123_id3_pic_back_cover = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_back_cover);
pub const mpg123_id3_pic_leaflet = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_leaflet);
pub const mpg123_id3_pic_media = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_media);
pub const mpg123_id3_pic_lead = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_lead);
pub const mpg123_id3_pic_artist = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_artist);
pub const mpg123_id3_pic_conductor = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_conductor);
pub const mpg123_id3_pic_orchestra = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_orchestra);
pub const mpg123_id3_pic_composer = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_composer);
pub const mpg123_id3_pic_lyricist = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_lyricist);
pub const mpg123_id3_pic_location = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_location);
pub const mpg123_id3_pic_recording = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_recording);
pub const mpg123_id3_pic_performance = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_performance);
pub const mpg123_id3_pic_video = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_video);
pub const mpg123_id3_pic_fish = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_fish);
pub const mpg123_id3_pic_illustration = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_illustration);
pub const mpg123_id3_pic_artist_logo = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_artist_logo);
pub const mpg123_id3_pic_publisher_logo = @enumToInt(enum_mpg123_id3_pic_type.mpg123_id3_pic_publisher_logo);
pub const enum_mpg123_id3_pic_type = extern enum(c_int) {
    mpg123_id3_pic_other = 0,
    mpg123_id3_pic_icon = 1,
    mpg123_id3_pic_other_icon = 2,
    mpg123_id3_pic_front_cover = 3,
    mpg123_id3_pic_back_cover = 4,
    mpg123_id3_pic_leaflet = 5,
    mpg123_id3_pic_media = 6,
    mpg123_id3_pic_lead = 7,
    mpg123_id3_pic_artist = 8,
    mpg123_id3_pic_conductor = 9,
    mpg123_id3_pic_orchestra = 10,
    mpg123_id3_pic_composer = 11,
    mpg123_id3_pic_lyricist = 12,
    mpg123_id3_pic_location = 13,
    mpg123_id3_pic_recording = 14,
    mpg123_id3_pic_performance = 15,
    mpg123_id3_pic_video = 16,
    mpg123_id3_pic_fish = 17,
    mpg123_id3_pic_illustration = 18,
    mpg123_id3_pic_artist_logo = 19,
    mpg123_id3_pic_publisher_logo = 20,
    _,
};
const struct_unnamed_23 = extern struct {
    type: u8,
    description: mpg123_string,
    mime_type: mpg123_string,
    size: usize,
    data: [*c]u8,
};
pub const mpg123_picture = struct_unnamed_23;
const struct_unnamed_24 = extern struct {
    version: u8,
    title: [*c]mpg123_string,
    artist: [*c]mpg123_string,
    album: [*c]mpg123_string,
    year: [*c]mpg123_string,
    genre: [*c]mpg123_string,
    comment: [*c]mpg123_string,
    comment_list: [*c]mpg123_text,
    comments: usize,
    text: [*c]mpg123_text,
    texts: usize,
    extra: [*c]mpg123_text,
    extras: usize,
    picture: [*c]mpg123_picture,
    pictures: usize,
};
pub const mpg123_id3v2 = struct_unnamed_24;
const struct_unnamed_25 = extern struct {
    tag: [3]u8,
    title: [30]u8,
    artist: [30]u8,
    album: [30]u8,
    year: [4]u8,
    comment: [30]u8,
    genre: u8,
};
pub const mpg123_id3v1 = struct_unnamed_25;
pub extern fn mpg123_meta_check(mh: ?*mpg123_handle) c_int;
pub extern fn mpg123_meta_free(mh: ?*mpg123_handle) void;
pub extern fn mpg123_id3(mh: ?*mpg123_handle, v1: [*c][*c]mpg123_id3v1, v2: [*c][*c]mpg123_id3v2) c_int;
pub extern fn mpg123_icy(mh: ?*mpg123_handle, icy_meta: [*c][*c]u8) c_int;
pub extern fn mpg123_icy2utf8(icy_text: [*c]const u8) [*c]u8;
pub const struct_mpg123_pars_struct = opaque {};
pub const mpg123_pars = struct_mpg123_pars_struct;
pub extern fn mpg123_parnew(mp: ?*mpg123_pars, decoder: [*c]const u8, @"error": [*c]c_int) ?*mpg123_handle;
pub extern fn mpg123_new_pars(@"error": [*c]c_int) ?*mpg123_pars;
pub extern fn mpg123_delete_pars(mp: ?*mpg123_pars) void;
pub extern fn mpg123_fmt_none(mp: ?*mpg123_pars) c_int;
pub extern fn mpg123_fmt_all(mp: ?*mpg123_pars) c_int;
pub extern fn mpg123_fmt(mp: ?*mpg123_pars, rate: c_long, channels: c_int, encodings: c_int) c_int;
pub extern fn mpg123_fmt_support(mp: ?*mpg123_pars, rate: c_long, encoding: c_int) c_int;
pub extern fn mpg123_par(mp: ?*mpg123_pars, type: enum_mpg123_parms, value: c_long, fvalue: f64) c_int;
pub extern fn mpg123_getpar(mp: ?*mpg123_pars, type: enum_mpg123_parms, value: [*c]c_long, fvalue: [*c]f64) c_int;
pub extern fn mpg123_replace_buffer(mh: ?*mpg123_handle, data: [*c]u8, size: usize) c_int;
pub extern fn mpg123_outblock(mh: ?*mpg123_handle) usize;
pub extern fn mpg123_replace_reader(mh: ?*mpg123_handle, r_read: ?fn (c_int, ?*c_void, usize) callconv(.C) isize, r_lseek: ?fn (c_int, off_t, c_int) callconv(.C) off_t) c_int;
pub extern fn mpg123_replace_reader_handle(mh: ?*mpg123_handle, r_read: ?fn (?*c_void, ?*c_void, usize) callconv(.C) isize, r_lseek: ?fn (?*c_void, off_t, c_int) callconv(.C) off_t, cleanup: ?fn (?*c_void) callconv(.C) void) c_int;
pub const __INTMAX_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINTMAX_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __PTRDIFF_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __INTPTR_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __SIZE_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __WINT_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __CHAR16_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __CHAR32_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINTPTR_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __INT8_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __INT64_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINT8_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINT16_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINT32_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINT64_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __INT_LEAST8_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINT_LEAST8_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINT_LEAST16_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINT_LEAST32_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __INT_LEAST64_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINT_LEAST64_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __INT_FAST8_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINT_FAST8_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINT_FAST16_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINT_FAST32_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __INT_FAST64_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UINT_FAST64_TYPE__ = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const MPG123_SAMPLESIZE = @compileError("unable to translate C expr: unexpected token Id.Eq");
pub const __GLIBC_USE = @compileError("macro tokenizing failed: unexpected character '#'");
pub const __NTH = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __NTHNL = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __CONCAT = @compileError("macro tokenizing failed: unexpected character '#'");
pub const __STRING = @compileError("macro tokenizing failed: unexpected character '#'");
pub const __ptr_t = @compileError("unable to translate C expr: unexpected token Id.Eof");
pub const __warndecl = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __warnattr = @compileError("unable to translate C expr: unexpected token Id.Eof");
pub const __errordecl = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __flexarr = @compileError("unable to translate C expr: unexpected token Id.LBrace");
pub const __REDIRECT = @compileError("macro tokenizing failed: unexpected character '#'");
pub const __REDIRECT_NTH = @compileError("macro tokenizing failed: unexpected character '#'");
pub const __REDIRECT_NTHNL = @compileError("macro tokenizing failed: unexpected character '#'");
pub const __ASMNAME2 = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __attribute_alloc_size__ = @compileError("unable to translate C expr: unexpected token Id.Eof");
pub const __always_inline = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __extern_inline = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __extern_always_inline = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __fortify_function = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __attribute_copy__ = @compileError("unable to translate C expr: unexpected token Id.Eof");
pub const __LDBL_REDIR1 = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __LDBL_REDIR = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __LDBL_REDIR1_NTH = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __LDBL_REDIR_NTH = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __LDBL_REDIR_DECL = @compileError("unable to translate C expr: unexpected token Id.Eof");
pub const __glibc_macro_warning1 = @compileError("macro tokenizing failed: unexpected character '#'");
pub const __glibc_macro_warning = @compileError("unable to translate C expr: expected ',' or ')'");
pub const __WIFEXITED = @compileError("unable to translate C expr: unexpected token Id.Eq");
pub const __WIFSTOPPED = @compileError("unable to translate C expr: unexpected token Id.Eq");
pub const __WIFCONTINUED = @compileError("unable to translate C expr: unexpected token Id.Eq");
pub const __HAVE_FLOAT128_UNLIKE_LDBL = @compileError("unable to translate C expr: unexpected token Id.Ne");
pub const __f32 = @compileError("macro tokenizing failed: unexpected character '#'");
pub const __f64x = @compileError("macro tokenizing failed: unexpected character '#'");
pub const __CFLOAT32 = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __CFLOAT64 = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __CFLOAT32X = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __CFLOAT64X = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __builtin_huge_valf32 = @compileError("unable to translate C expr: expected identifier");
pub const __builtin_inff32 = @compileError("unable to translate C expr: expected identifier");
pub const __builtin_huge_valf64 = @compileError("unable to translate C expr: expected identifier");
pub const __builtin_inff64 = @compileError("unable to translate C expr: expected identifier");
pub const __builtin_huge_valf32x = @compileError("unable to translate C expr: expected identifier");
pub const __builtin_inff32x = @compileError("unable to translate C expr: expected identifier");
pub const __builtin_huge_valf64x = @compileError("unable to translate C expr: expected identifier");
pub const __builtin_inff64x = @compileError("unable to translate C expr: expected identifier");
pub const MB_CUR_MAX = @compileError("unable to translate C expr: unexpected token Id.RParen");
pub const __S16_TYPE = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __U16_TYPE = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __U32_TYPE = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __SLONGWORD_TYPE = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __ULONGWORD_TYPE = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __SQUAD_TYPE = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UQUAD_TYPE = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __SWORD_TYPE = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __UWORD_TYPE = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __ULONG32_TYPE = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __S64_TYPE = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __U64_TYPE = @compileError("unable to translate C expr: unexpected token Id.Identifier");
pub const __TIMER_T_TYPE = @compileError("unable to translate C expr: unexpected token Id.Eof");
pub const __FSID_T_TYPE = @compileError("macro tokenizing failed: unexpected character '{'");
pub const __LONG_LONG_PAIR = @compileError("unable to translate C expr: unexpected token Id.Comma");
pub const __FD_ZERO = @compileError("macro tokenizing failed: unexpected character '{'");
pub const __FD_SET = @compileError("unable to translate C expr: unexpected token Id.Assign");
pub const __FD_CLR = @compileError("unable to translate C expr: unexpected token Id.Assign");
pub const __FD_ISSET = @compileError("unable to translate C expr: unexpected token Id.Ne");
pub const _SIGSET_NWORDS = @compileError("unable to translate C expr: unexpected token Id.Slash");
pub const __FD_ELT = @compileError("unable to translate C expr: unexpected token Id.Slash");
pub const __FD_MASK = @compileError("macro tokenizing failed: unexpected character '%'");
pub const __PTHREAD_RWLOCK_ELISION_EXTRA = @compileError("macro tokenizing failed: unexpected character '{'");
pub const __PTHREAD_SPINS_DATA = @compileError("macro tokenizing failed: unexpected character ';'");
pub const __PTHREAD_SPINS = @compileError("unable to translate C expr: unexpected token Id.Comma");
pub const __AVX__ = 1;
pub const __UINT64_MAX__ = @as(c_ulong, 18446744073709551615);
pub const __WORDSIZE_TIME64_COMPAT32 = 1;
pub const __FINITE_MATH_ONLY__ = 0;
pub const __SYSCALL_WORDSIZE = 64;
pub const __SIZEOF_FLOAT__ = 4;
pub const __SEG_GS = 1;
pub const __PIE__ = 2;
pub const __UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST8_MAX__ = 127;
pub const __OBJC_BOOL_IS_BOOL = 0;
pub const __CLOCKID_T_TYPE = __S32_TYPE;
pub const __INT_LEAST8_FMTi__ = "hhi";
pub const __USE_POSIX2 = 1;
pub const _STDLIB_H = 1;
pub const __UINT64_FMTX__ = "lX";
pub const __SSE4_2__ = 1;
pub const __SIG_ATOMIC_MAX__ = 2147483647;
pub const __SIZEOF_PTHREAD_CONDATTR_T = 4;
pub const __SSE__ = 1;
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __NO_MATH_INLINES = 1;
pub const __SIZEOF_FLOAT128__ = 16;
pub fn __GNUC_PREREQ(maj: anytype, min: anytype) callconv(.Inline) @TypeOf(__GNUC__ << 16 + __GNUC_MINOR__ >= maj << 16 + min) {
    return __GNUC__ << 16 + __GNUC_MINOR__ >= maj << 16 + min;
}
pub const __INT_FAST32_FMTd__ = "d";
pub const _POSIX_C_SOURCE = @as(c_long, 200809);
pub const __STDC_UTF_16__ = 1;
pub const __UINT_FAST16_MAX__ = 65535;
pub const __ATOMIC_ACQUIRE = 2;
pub const _FEATURES_H = 1;
pub const __LDBL_HAS_DENORM__ = 1;
pub const __INTMAX_FMTi__ = "li";
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FMA__ = 1;
pub const __UINT_FAST32_FMTo__ = "o";
pub const __UINT32_MAX__ = @as(c_uint, 4294967295);
pub const PDP_ENDIAN = __PDP_ENDIAN;
pub const __SIZEOF_PTHREAD_MUTEXATTR_T = 4;
pub fn htobe64(x: anytype) callconv(.Inline) @TypeOf(__bswap_64(x)) {
    return __bswap_64(x);
}
pub const __INT_MAX__ = 2147483647;
pub const __INT_LEAST64_MAX__ = @as(c_long, 9223372036854775807);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = 1;
pub const __USE_FORTIFY_LEVEL = 0;
pub const __RLIM_T_MATCHES_RLIM64_T = 1;
pub const __SIZEOF_INT128__ = 16;
pub const __INT64_MAX__ = @as(c_long, 9223372036854775807);
pub const __DBL_MIN_10_EXP__ = -307;
pub const __INT_LEAST32_MAX__ = 2147483647;
pub const __INT_FAST16_FMTd__ = "hd";
pub const __attribute_pure__ = __attribute__(__pure__);
pub const __PDP_ENDIAN = 3412;
pub fn htole32(x: anytype) callconv(.Inline) @TypeOf(__uint32_identity(x)) {
    return __uint32_identity(x);
}
pub const __UINT_LEAST64_FMTu__ = "lu";
pub const __WCLONE = 0x80000000;
pub const __DBL_DENORM_MIN__ = 4.9406564584124654e-324;
pub const __UINT8_FMTu__ = "hhu";
pub const __INT_FAST16_MAX__ = 32767;
pub const WNOWAIT = 0x01000000;
pub fn le16toh(x: anytype) callconv(.Inline) @TypeOf(__uint16_identity(x)) {
    return __uint16_identity(x);
}
pub fn __bos0(ptr: anytype) callconv(.Inline) @TypeOf(__builtin_object_size(ptr, 0)) {
    return __builtin_object_size(ptr, 0);
}
pub const __LP64__ = 1;
pub const __SIZE_FMTx__ = "lx";
pub const __ORDER_PDP_ENDIAN__ = 3412;
pub const __UINT8_FMTX__ = "hhX";
pub const __SIZEOF_PTHREAD_MUTEX_T = 40;
pub const __LDBL_MIN_10_EXP__ = -4931;
pub const __LDBL_MAX_10_EXP__ = 4932;
pub const __DBL_MAX_10_EXP__ = 308;
pub const __PTRDIFF_FMTi__ = "li";
pub fn WIFSIGNALED(status: anytype) callconv(.Inline) @TypeOf(__WIFSIGNALED(status)) {
    return __WIFSIGNALED(status);
}
pub const _BITS_BYTESWAP_H = 1;
pub const __STDC_IEC_559__ = 1;
pub fn __REDIRECT_NTH_LDBL(name: anytype, proto: anytype, alias: anytype) callconv(.Inline) @TypeOf(__REDIRECT_NTH(name, proto, alias)) {
    return __REDIRECT_NTH(name, proto, alias);
}
pub const __CLFLUSHOPT__ = 1;
pub const __SIZEOF_LONG__ = 8;
pub const __FLT_MIN_EXP__ = -125;
pub fn __builtin_nansf32x(x: anytype) callconv(.Inline) @TypeOf(__builtin_nans(x)) {
    return __builtin_nans(x);
}
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __FLT_EVAL_METHOD__ = 0;
pub fn __WCOREDUMP(status: anytype) callconv(.Inline) @TypeOf(status & __WCOREFLAG) {
    return status & __WCOREFLAG;
}
pub fn __builtin_nansf32(x: anytype) callconv(.Inline) @TypeOf(__builtin_nansf(x)) {
    return __builtin_nansf(x);
}
pub const __UINTMAX_FMTx__ = "lx";
pub const __UINT_LEAST8_FMTo__ = "hho";
pub const __code_model_small_ = 1;
pub const __ELF__ = 1;
pub const __CLZERO__ = 1;
pub const __UINT_FAST8_FMTu__ = "hhu";
pub const __DADDR_T_TYPE = __S32_TYPE;
pub const _LP64 = 1;
pub const __FLT_MAX_EXP__ = 128;
pub const __DBL_HAS_DENORM__ = 1;
pub const __WINT_UNSIGNED__ = 1;
pub const __INT_LEAST64_FMTd__ = "ld";
pub const __GNU_LIBRARY__ = 6;
pub const __SSSE3__ = 1;
pub const __UINT_LEAST8_FMTu__ = "hhu";
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub fn __glibc_likely(cond: anytype) callconv(.Inline) @TypeOf(__builtin_expect(cond, 1)) {
    return __builtin_expect(cond, 1);
}
pub fn __W_STOPCODE(sig: anytype) callconv(.Inline) @TypeOf(sig << 8 | 0x7f) {
    return sig << 8 | 0x7f;
}
pub const __CPU_MASK_TYPE = __SYSCALL_ULONG_TYPE;
pub const __UINT_FAST8_FMTX__ = "hhX";
pub const __SIZEOF_PTHREAD_RWLOCK_T = 56;
pub const __UINT_FAST16_FMTu__ = "hu";
pub const __UINT_FAST32_FMTX__ = "X";
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __LZCNT__ = 1;
pub fn __glibc_clang_has_extension(ext: anytype) callconv(.Inline) @TypeOf(__has_extension(ext)) {
    return __has_extension(ext);
}
pub const __BLKCNT_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const _BITS_TYPES_H = 1;
pub const __clang_patchlevel__ = 1;
pub fn htobe32(x: anytype) callconv(.Inline) @TypeOf(__bswap_32(x)) {
    return __bswap_32(x);
}
pub const __UINT64_FMTu__ = "lu";
pub const __SIZEOF_PTHREAD_BARRIER_T = 32;
pub const EXIT_SUCCESS = 0;
pub const WUNTRACED = 2;
pub fn WSTOPSIG(status: anytype) callconv(.Inline) @TypeOf(__WSTOPSIG(status)) {
    return __WSTOPSIG(status);
}
pub const __SIZEOF_SHORT__ = 2;
pub const __LDBL_DIG__ = 18;
pub const MPG123_API_VERSION = 44;
pub const __HAVE_FLOAT64 = 1;
pub fn __WTERMSIG(status: anytype) callconv(.Inline) @TypeOf(status & 0x7f) {
    return status & 0x7f;
}
pub const __OPENCL_MEMORY_SCOPE_DEVICE = 2;
pub const __INT_FAST8_FMTd__ = "hhd";
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub fn le64toh(x: anytype) callconv(.Inline) @TypeOf(__uint64_identity(x)) {
    return __uint64_identity(x);
}
pub const __HAVE_FLOAT32 = 1;
pub const __MMX__ = 1;
pub const BIG_ENDIAN = __BIG_ENDIAN;
pub const __NO_INLINE__ = 1;
pub const __SIZEOF_WINT_T__ = 4;
pub fn __GLIBC_PREREQ(maj: anytype, min: anytype) callconv(.Inline) @TypeOf(__GLIBC__ << 16 + __GLIBC_MINOR__ >= maj << 16 + min) {
    return __GLIBC__ << 16 + __GLIBC_MINOR__ >= maj << 16 + min;
}
pub const __STDC_IEC_559_COMPLEX__ = 1;
pub const __CLANG_ATOMIC_POINTER_LOCK_FREE = 2;
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 = 1;
pub const __INTMAX_C_SUFFIX__ = L;
pub const __UINT_LEAST32_FMTu__ = "u";
pub fn FD_ISSET(fd: anytype, fdsetp: anytype) callconv(.Inline) @TypeOf(__FD_ISSET(fd, fdsetp)) {
    return __FD_ISSET(fd, fdsetp);
}
pub const __LITTLE_ENDIAN__ = 1;
pub const __INT_LEAST16_FMTi__ = "hi";
pub const __FLOAT_WORD_ORDER = __BYTE_ORDER;
pub const __UINTMAX_C_SUFFIX__ = UL;
pub const __INO_T_MATCHES_INO64_T = 1;
pub fn __attribute_deprecated_msg__(msg: anytype) callconv(.Inline) @TypeOf(__attribute__(__deprecated__(msg))) {
    return __attribute__(__deprecated__(msg));
}
pub const __OPENCL_MEMORY_SCOPE_WORK_ITEM = 0;
pub const __VERSION__ = "Clang 9.0.1 ";
pub const __DBL_HAS_INFINITY__ = 1;
pub const _BITS_PTHREADTYPES_ARCH_H = 1;
pub const __INT_LEAST16_MAX__ = 32767;
pub const __SCHAR_MAX__ = 127;
pub const __GNUC_MINOR__ = 2;
pub const __tune_znver1__ = 1;
pub const __UINT32_FMTx__ = "x";
pub const __WNOTHREAD = 0x20000000;
pub const __LDBL_HAS_QUIET_NAN__ = 1;
pub const __UINT_FAST32_FMTu__ = "u";
pub const __UINT8_FMTx__ = "hhx";
pub const __WALL = 0x40000000;
pub const __clockid_t_defined = 1;
pub const __UINT_LEAST8_FMTX__ = "hhX";
pub const _DEFAULT_SOURCE = 1;
pub const __UINT_LEAST64_FMTx__ = "lx";
pub const __UINT_LEAST64_MAX__ = @as(c_ulong, 18446744073709551615);
pub const MPG123_NEW_ID3 = 0x1;
pub const __pic__ = 2;
pub const __GCC_ATOMIC_CHAR16_T_LOCK_FREE = 2;
pub const __clang__ = 1;
pub const __FLT_HAS_INFINITY__ = 1;
pub const __GLIBC__ = 2;
pub const _BITS_STDINT_INTN_H = 1;
pub const __UINTPTR_FMTu__ = "lu";
pub const __USE_XOPEN2K8 = 1;
pub const __unix__ = 1;
pub fn __bswap_constant_32(x: anytype) callconv(.Inline) @TypeOf(x & @as(c_uint, 0xff000000) >> 24 | x & @as(c_uint, 0x00ff0000) >> 8 | x & @as(c_uint, 0x0000ff00) << 8 | x & @as(c_uint, 0x000000ff) << 24) {
    return x & @as(c_uint, 0xff000000) >> 24 | x & @as(c_uint, 0x00ff0000) >> 8 | x & @as(c_uint, 0x0000ff00) << 8 | x & @as(c_uint, 0x000000ff) << 24;
}
pub const __UID_T_TYPE = __U32_TYPE;
pub const __INT_FAST32_TYPE__ = int;
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 = 1;
pub const __UINT16_FMTx__ = "hx";
pub const __restrict_arr = __restrict;
pub const __ADX__ = 1;
pub fn be32toh(x: anytype) callconv(.Inline) @TypeOf(__bswap_32(x)) {
    return __bswap_32(x);
}
pub const __SIZEOF_PTHREAD_BARRIERATTR_T = 4;
pub const __UINT_LEAST32_FMTo__ = "o";
pub fn FD_ZERO(fdsetp: anytype) callconv(.Inline) @TypeOf(__FD_ZERO(fdsetp)) {
    return __FD_ZERO(fdsetp);
}
pub const __glibc_c99_flexarr_available = 1;
pub const __FLT_MIN_10_EXP__ = -37;
pub const __UINT_LEAST16_FMTX__ = "hX";
pub const __UINT_LEAST32_MAX__ = @as(c_uint, 4294967295);
pub const __RLIM64_T_TYPE = __UQUAD_TYPE;
pub const __FSFILCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __SIZEOF_PTHREAD_ATTR_T = 56;
pub fn htole16(x: anytype) callconv(.Inline) @TypeOf(__uint16_identity(x)) {
    return __uint16_identity(x);
}
pub const __UINT_FAST8_FMTx__ = "hhx";
pub const __SIZE_FMTu__ = "lu";
pub const __SIZEOF_POINTER__ = 8;
pub const __SIZE_FMTX__ = "lX";
pub const __USE_XOPEN2K = 1;
pub const __INT16_FMTd__ = "hd";
pub const __HAVE_FLOAT32X = 1;
pub fn __f32x(x: anytype) callconv(.Inline) @TypeOf(x) {
    return x;
}
pub const __clang_version__ = "9.0.1 ";
pub const __ATOMIC_RELEASE = 3;
pub const __UINT_FAST64_FMTX__ = "lX";
pub const __INTMAX_FMTd__ = "ld";
pub const __SEG_FS = 1;
pub const __USE_POSIX199309 = 1;
pub const __UINT_FAST8_FMTo__ = "hho";
pub const __WINT_WIDTH__ = 32;
pub const __timer_t_defined = 1;
pub const __FLT_MAX_10_EXP__ = 38;
pub const __LDBL_MAX__ = @as(f64, 1.18973149535723176502e+4932);
pub const __GCC_ATOMIC_LONG_LOCK_FREE = 2;
pub const __gnu_linux__ = 1;
pub const _DEBUG = 1;
pub fn __WEXITSTATUS(status: anytype) callconv(.Inline) @TypeOf(status & 0xff00 >> 8) {
    return status & 0xff00 >> 8;
}
pub fn __PMT(args: anytype) callconv(.Inline) @TypeOf(args) {
    return args;
}
pub fn htole64(x: anytype) callconv(.Inline) @TypeOf(__uint64_identity(x)) {
    return __uint64_identity(x);
}
pub const __UINTPTR_WIDTH__ = 64;
pub const __HAVE_DISTINCT_FLOAT128 = 0;
pub const __INT_LEAST32_FMTi__ = "i";
pub const __WCHAR_WIDTH__ = 32;
pub const __UINT16_FMTX__ = "hX";
pub const __OFF64_T_TYPE = __SQUAD_TYPE;
pub const unix = 1;
pub fn __builtin_nansf64(x: anytype) callconv(.Inline) @TypeOf(__builtin_nans(x)) {
    return __builtin_nans(x);
}
pub const __STDC_ISO_10646__ = @as(c_long, 201706);
pub const _STRUCT_TIMESPEC = 1;
pub const __SYSCALL_ULONG_TYPE = __ULONGWORD_TYPE;
pub const __BLKSIZE_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __GNUC_PATCHLEVEL__ = 1;
pub const __INT_LEAST16_TYPE__ = short;
pub const __INT64_FMTd__ = "ld";
pub fn FD_SET(fd: anytype, fdsetp: anytype) callconv(.Inline) @TypeOf(__FD_SET(fd, fdsetp)) {
    return __FD_SET(fd, fdsetp);
}
pub const __SSE3__ = 1;
pub const __SYSCALL_SLONG_TYPE = __SLONGWORD_TYPE;
pub const __pie__ = 2;
pub const __HAVE_FLOAT64X_LONG_DOUBLE = 1;
pub const __UINT16_MAX__ = 65535;
pub const __ATOMIC_RELAXED = 0;
pub const _POSIX_SOURCE = 1;
pub const __SSE4A__ = 1;
pub const __HAVE_DISTINCT_FLOAT64X = 0;
pub const __GCC_ATOMIC_CHAR_LOCK_FREE = 2;
pub const __UINT_LEAST16_FMTx__ = "hx";
pub const __UINT_FAST64_FMTu__ = "lu";
pub const __CLANG_ATOMIC_CHAR16_T_LOCK_FREE = 2;
pub const __SSE2__ = 1;
pub const _ATFILE_SOURCE = 1;
pub const __STDC__ = 1;
pub const __attribute_warn_unused_result__ = __attribute__(__warn_unused_result__);
pub const __time_t_defined = 1;
pub const __GLIBC_USE_IEC_60559_BFP_EXT = 0;
pub const __INT_FAST16_TYPE__ = short;
pub fn be64toh(x: anytype) callconv(.Inline) @TypeOf(__bswap_64(x)) {
    return __bswap_64(x);
}
pub const __UINT64_C_SUFFIX__ = UL;
pub const _BITS_PTHREADTYPES_COMMON_H = 1;
pub const __LONG_MAX__ = @as(c_long, 9223372036854775807);
pub const __DBL_MAX__ = 1.7976931348623157e+308;
pub const __MODE_T_TYPE = __U32_TYPE;
pub const __CHAR_BIT__ = 8;
pub const __HAVE_FLOAT64X = 1;
pub const __DBL_DECIMAL_DIG__ = 17;
pub fn __FDS_BITS(set: anytype) callconv(.Inline) @TypeOf(set.*.__fds_bits) {
    return set.*.__fds_bits;
}
pub const __UINT_LEAST8_FMTx__ = "hhx";
pub const __FSBLKCNT64_T_TYPE = __UQUAD_TYPE;
pub const linux = 1;
pub fn __bswap_constant_64(x: anytype) callconv(.Inline) @TypeOf(x & @as(c_ulonglong, 0xff00000000000000) >> 56 | x & @as(c_ulonglong, 0x00ff000000000000) >> 40 | x & @as(c_ulonglong, 0x0000ff0000000000) >> 24 | x & @as(c_ulonglong, 0x000000ff00000000) >> 8 | x & @as(c_ulonglong, 0x00000000ff000000) << 8 | x & @as(c_ulonglong, 0x0000000000ff0000) << 24 | x & @as(c_ulonglong, 0x000000000000ff00) << 40 | x & @as(c_ulonglong, 0x00000000000000ff) << 56) {
    return x & @as(c_ulonglong, 0xff00000000000000) >> 56 | x & @as(c_ulonglong, 0x00ff000000000000) >> 40 | x & @as(c_ulonglong, 0x0000ff0000000000) >> 24 | x & @as(c_ulonglong, 0x000000ff00000000) >> 8 | x & @as(c_ulonglong, 0x00000000ff000000) << 8 | x & @as(c_ulonglong, 0x0000000000ff0000) << 24 | x & @as(c_ulonglong, 0x000000000000ff00) << 40 | x & @as(c_ulonglong, 0x00000000000000ff) << 56;
}
pub const __FSGSBASE__ = 1;
pub const __ORDER_BIG_ENDIAN__ = 4321;
pub const __PTHREAD_MUTEX_USE_UNION = 0;
pub const __INTPTR_MAX__ = @as(c_long, 9223372036854775807);
pub const __INT_LEAST8_FMTd__ = "hhd";
pub fn __W_EXITCODE(ret: anytype, sig: anytype) callconv(.Inline) @TypeOf(ret << 8 | sig) {
    return ret << 8 | sig;
}
pub const __INTMAX_WIDTH__ = 64;
pub const __CLANG_ATOMIC_SHORT_LOCK_FREE = 2;
pub const __FLOAT128__ = 1;
pub const __attribute_deprecated__ = __attribute__(__deprecated__);
pub const __LDBL_DENORM_MIN__ = @as(f64, 3.64519953188247460253e-4951);
pub const __GLIBC_MINOR__ = 30;
pub const __HAVE_FLOATN_NOT_TYPEDEF = 0;
pub const __PID_T_TYPE = __S32_TYPE;
pub const __x86_64 = 1;
pub const __CLANG_ATOMIC_LONG_LOCK_FREE = 2;
pub const __INTMAX_MAX__ = @as(c_long, 9223372036854775807);
pub const __INT8_FMTd__ = "hhd";
pub const __UINTMAX_WIDTH__ = 64;
pub const __UINT8_MAX__ = 255;
pub fn __builtin_nanf64(x: anytype) callconv(.Inline) @TypeOf(__builtin_nan(x)) {
    return __builtin_nan(x);
}
pub const __lldiv_t_defined = 1;
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT = 0;
pub const __DBL_MIN__ = 2.2250738585072014e-308;
pub const __PRAGMA_REDEFINE_EXTNAME = 1;
pub const __DBL_HAS_QUIET_NAN__ = 1;
pub const __clang_minor__ = 0;
pub fn FD_CLR(fd: anytype, fdsetp: anytype) callconv(.Inline) @TypeOf(__FD_CLR(fd, fdsetp)) {
    return __FD_CLR(fd, fdsetp);
}
pub const __LDBL_DECIMAL_DIG__ = 21;
pub const __SSE4_1__ = 1;
pub const __USE_MISC = 1;
pub const __WCHAR_TYPE__ = int;
pub const __INT_FAST64_FMTd__ = "ld";
pub const NFDBITS = __NFDBITS;
pub fn WTERMSIG(status: anytype) callconv(.Inline) @TypeOf(__WTERMSIG(status)) {
    return __WTERMSIG(status);
}
pub const __RDRND__ = 1;
pub const __KEY_T_TYPE = __S32_TYPE;
pub const __GCC_ATOMIC_WCHAR_T_LOCK_FREE = 2;
pub const __seg_fs = __attribute__(address_space(257));
pub const __XSAVEOPT__ = 1;
pub const __attribute_malloc__ = __attribute__(__malloc__);
pub const __HAVE_GENERIC_SELECTION = 1;
pub const __INT16_FMTi__ = "hi";
pub const __UINTMAX_FMTX__ = "lX";
pub const WSTOPPED = 2;
pub const __PRFCHW__ = 1;
pub const __LDBL_MIN_EXP__ = -16381;
pub const __ID_T_TYPE = __U32_TYPE;
pub const __AVX2__ = 1;
pub const __PTHREAD_MUTEX_LOCK_ELISION = 1;
pub const __UINTMAX_FMTu__ = "lu";
pub const __UINT_LEAST16_FMTo__ = "ho";
pub const __HAVE_DISTINCT_FLOAT16 = __HAVE_FLOAT16;
pub const __glibc_has_include = __has_include;
pub const _STDC_PREDEF_H = 1;
pub const __UINT32_FMTu__ = "u";
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 = 1;
pub const __SIG_ATOMIC_WIDTH__ = 32;
pub const LITTLE_ENDIAN = __LITTLE_ENDIAN;
pub const __amd64__ = 1;
pub const __BYTE_ORDER = __LITTLE_ENDIAN;
pub const __INT64_C_SUFFIX__ = L;
pub const __LDBL_EPSILON__ = @as(f64, 1.08420217248550443401e-19);
pub const __CLANG_ATOMIC_INT_LOCK_FREE = 2;
pub const _BITS_TYPESIZES_H = 1;
pub const __SSE2_MATH__ = 1;
pub fn WIFCONTINUED(status: anytype) callconv(.Inline) @TypeOf(__WIFCONTINUED(status)) {
    return __WIFCONTINUED(status);
}
pub const __SIZEOF_PTHREAD_COND_T = 48;
pub const __GCC_ATOMIC_SHORT_LOCK_FREE = 2;
pub fn __P(args: anytype) callconv(.Inline) @TypeOf(args) {
    return args;
}
pub const __TIME_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __POPCNT__ = 1;
pub const __POINTER_WIDTH__ = 64;
pub const __UINT64_FMTx__ = "lx";
pub const __ATOMIC_ACQ_REL = 4;
pub const __UINT_LEAST32_FMTx__ = "x";
pub const __OFF_T_MATCHES_OFF64_T = 1;
pub const __STDC_HOSTED__ = 1;
pub const __INO64_T_TYPE = __UQUAD_TYPE;
pub const __GNUC__ = 4;
pub const __INT_FAST32_FMTi__ = "i";
pub const __PIC__ = 2;
pub const __BLKCNT64_T_TYPE = __SQUAD_TYPE;
pub const __GCC_ATOMIC_BOOL_LOCK_FREE = 2;
pub const __seg_gs = __attribute__(address_space(256));
pub const __FXSR__ = 1;
pub const __UINT64_FMTo__ = "lo";
pub fn __builtin_nansf64x(x: anytype) callconv(.Inline) @TypeOf(__builtin_nansl(x)) {
    return __builtin_nansl(x);
}
pub fn le32toh(x: anytype) callconv(.Inline) @TypeOf(__uint32_identity(x)) {
    return __uint32_identity(x);
}
pub const __UINT_FAST16_FMTx__ = "hx";
pub const WNOHANG = 1;
pub const __MWAITX__ = 1;
pub const _THREAD_SHARED_TYPES_H = 1;
pub const __CLOCK_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __GLIBC_USE_DEPRECATED_SCANF = 0;
pub const __UINT_LEAST64_FMTo__ = "lo";
pub const __attribute_used__ = __attribute__(__used__);
pub const __FD_ZERO_STOS = "stosq";
pub const __STDC_UTF_32__ = 1;
pub const __FSFILCNT64_T_TYPE = __UQUAD_TYPE;
pub const _ALLOCA_H = 1;
pub const __PTRDIFF_WIDTH__ = 64;
pub fn WIFSTOPPED(status: anytype) callconv(.Inline) @TypeOf(__WIFSTOPPED(status)) {
    return __WIFSTOPPED(status);
}
pub const __SIZE_WIDTH__ = 64;
pub const __LDBL_MIN__ = @as(f64, 3.36210314311209350626e-4932);
pub const __UINTMAX_MAX__ = @as(c_ulong, 18446744073709551615);
pub const _SYS_CDEFS_H = 1;
pub const __INT_LEAST16_FMTd__ = "hd";
pub const __SIZEOF_PTRDIFF_T__ = 8;
pub fn __glibc_clang_prereq(maj: anytype, min: anytype) callconv(.Inline) @TypeOf(__clang_major__ << 16 + __clang_minor__ >= maj << 16 + min) {
    return __clang_major__ << 16 + __clang_minor__ >= maj << 16 + min;
}
pub const __UINT_LEAST16_FMTu__ = "hu";
pub const __UINT16_FMTu__ = "hu";
pub const __DBL_MANT_DIG__ = 53;
pub const __CLANG_ATOMIC_WCHAR_T_LOCK_FREE = 2;
pub const __INT_LEAST64_FMTi__ = "li";
pub const __GNUC_STDC_INLINE__ = 1;
pub const __UINT32_FMTX__ = "X";
pub const __W_CONTINUED = 0xffff;
pub const __DBL_DIG__ = 15;
pub const __SHRT_MAX__ = 32767;
pub const __HAVE_DISTINCT_FLOAT32 = 0;
pub const __ATOMIC_CONSUME = 1;
pub const __PTHREAD_MUTEX_HAVE_PREV = 1;
pub const __have_pthread_attr_t = 1;
pub const __GLIBC_USE_DEPRECATED_GETS = 0;
pub const __UINT_FAST16_FMTX__ = "hX";
pub const __INT_FAST16_FMTi__ = "hi";
pub const __FSBLKCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __INT32_FMTd__ = "d";
pub const __PTHREAD_MUTEX_NUSERS_AFTER_KIND = 0;
pub const __INT8_MAX__ = 127;
pub const __sigset_t_defined = 1;
pub const __FLT_DECIMAL_DIG__ = 9;
pub const __INT_LEAST32_FMTd__ = "d";
pub const __HAVE_DISTINCT_FLOAT32X = 0;
pub const __UINT8_FMTo__ = "hho";
pub const __USE_POSIX199506 = 1;
pub fn __bos(ptr: anytype) callconv(.Inline) @TypeOf(__builtin_object_size(ptr, __USE_FORTIFY_LEVEL > 1)) {
    return __builtin_object_size(ptr, __USE_FORTIFY_LEVEL > 1);
}
pub const __FLT_HAS_DENORM__ = 1;
pub const __NFDBITS = if (@typeId(@TypeOf(sizeof(__fd_mask))) == .Pointer) @ptrCast(8 * int, sizeof(__fd_mask)) else if (@typeId(@TypeOf(sizeof(__fd_mask))) == .Int) @intToPtr(8 * int, sizeof(__fd_mask)) else @as(8 * int, sizeof(__fd_mask));
pub const __FLT_DIG__ = 6;
pub const __INTPTR_FMTi__ = "li";
pub const __UINT32_FMTo__ = "o";
pub const __UINT_FAST64_MAX__ = @as(c_ulong, 18446744073709551615);
pub const __SIZEOF_PTHREAD_RWLOCKATTR_T = 8;
pub const _BITS_UINTN_IDENTITY_H = 1;
pub const __GID_T_TYPE = __U32_TYPE;
pub const __UINT_FAST64_FMTo__ = "lo";
pub const __GXX_ABI_VERSION = 1002;
pub const __SIZEOF_LONG_LONG__ = 8;
pub const _ENDIAN_H = 1;
pub const __INT32_TYPE__ = int;
pub const RAND_MAX = 2147483647;
pub fn __ASMNAME(cname: anytype) callconv(.Inline) @TypeOf(__ASMNAME2(__USER_LABEL_PREFIX__, cname)) {
    return __ASMNAME2(__USER_LABEL_PREFIX__, cname);
}
pub const __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES = 3;
pub const __UINTPTR_FMTX__ = "lX";
pub const __INT8_FMTi__ = "hhi";
pub const __SIZEOF_LONG_DOUBLE__ = 16;
pub const __znver1 = 1;
pub const __WCOREFLAG = 0x80;
pub const __DBL_MIN_EXP__ = -1021;
pub const __INT64_FMTi__ = "li";
pub const __INT_FAST64_FMTi__ = "li";
pub const __RLIM_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __attribute_const__ = __attribute__(__const__);
pub fn __attribute_format_arg__(x: anytype) callconv(.Inline) @TypeOf(__attribute__(__format_arg__(x))) {
    return __attribute__(__format_arg__(x));
}
pub const __GCC_ATOMIC_TEST_AND_SET_TRUEVAL = 1;
pub const __clang_major__ = 9;
pub const __USE_ISOC95 = 1;
pub const __OPENCL_MEMORY_SCOPE_SUB_GROUP = 4;
pub const __INT16_MAX__ = 32767;
pub const __linux = 1;
pub const BYTE_ORDER = __BYTE_ORDER;
pub const __OFF_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __HAVE_DISTINCT_FLOAT64 = 0;
pub const __GCC_ATOMIC_LLONG_LOCK_FREE = 2;
pub const EXIT_FAILURE = 1;
pub const __UINT16_FMTo__ = "ho";
pub const __INT_FAST8_FMTi__ = "hhi";
pub const __NLINK_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __UINT_FAST64_FMTx__ = "lx";
pub const __GLIBC_USE_LIB_EXT2 = 0;
pub const __timeval_defined = 1;
pub const __XSAVES__ = 1;
pub const __UINT_LEAST8_MAX__ = 255;
pub const __HAVE_FLOAT16 = 0;
pub const __LDBL_HAS_INFINITY__ = 1;
pub fn WEXITSTATUS(status: anytype) callconv(.Inline) @TypeOf(__WEXITSTATUS(status)) {
    return __WEXITSTATUS(status);
}
pub const __UINT_LEAST32_FMTX__ = "X";
pub fn __nonnull(params: anytype) callconv(.Inline) @TypeOf(__attribute__(if (@typeId(@TypeOf(params)) == .Pointer) @ptrCast(__nonnull__, params) else if (@typeId(@TypeOf(params)) == .Int) @intToPtr(__nonnull__, params) else @as(__nonnull__, params))) {
    return __attribute__(if (@typeId(@TypeOf(params)) == .Pointer) @ptrCast(__nonnull__, params) else if (@typeId(@TypeOf(params)) == .Int) @intToPtr(__nonnull__, params) else @as(__nonnull__, params));
}
pub const __WORDSIZE = 64;
pub fn __WIFSIGNALED(status: anytype) callconv(.Inline) @TypeOf(if (@typeId(@TypeOf(char)) == .Pointer) @ptrCast(signed, char) else if (@typeId(@TypeOf(char)) == .Int) @intToPtr(signed, char) else @as(signed, char)(status & 0x7f + 1) >> 1 > 0) {
    return if (@typeId(@TypeOf(char)) == .Pointer) @ptrCast(signed, char) else if (@typeId(@TypeOf(char)) == .Int) @intToPtr(signed, char) else @as(signed, char)(status & 0x7f + 1) >> 1 > 0;
}
pub const __USE_POSIX = 1;
pub fn __builtin_nanf32(x: anytype) callconv(.Inline) @TypeOf(__builtin_nanf(x)) {
    return __builtin_nanf(x);
}
pub const __unix = 1;
pub const __UINT_LEAST16_MAX__ = 65535;
pub const __CONSTANT_CFSTRINGS__ = 1;
pub const __SSE_MATH__ = 1;
pub const __DBL_EPSILON__ = 2.2204460492503131e-16;
pub const __TIME64_T_TYPE = __TIME_T_TYPE;
pub const __SHA__ = 1;
pub fn htobe16(x: anytype) callconv(.Inline) @TypeOf(__bswap_16(x)) {
    return __bswap_16(x);
}
pub const __llvm__ = 1;
pub const __SLONG32_TYPE = int;
pub const WEXITED = 4;
pub const __DBL_MAX_EXP__ = 1024;
pub const __CLANG_ATOMIC_CHAR_LOCK_FREE = 2;
pub const __HAVE_DISTINCT_FLOAT128X = __HAVE_FLOAT128X;
pub const __CLANG_ATOMIC_CHAR32_T_LOCK_FREE = 2;
pub const __LITTLE_ENDIAN = 1234;
pub fn __glibc_unlikely(cond: anytype) callconv(.Inline) @TypeOf(__builtin_expect(cond, 0)) {
    return __builtin_expect(cond, 0);
}
pub const _SYS_SELECT_H = 1;
pub const __GCC_ASM_FLAG_OUTPUTS__ = 1;
pub fn __glibc_has_attribute(attr: anytype) callconv(.Inline) @TypeOf(__has_attribute(attr)) {
    return __has_attribute(attr);
}
pub const MPG123_NEW_ICY = 0x4;
pub const __PTRDIFF_MAX__ = @as(c_long, 9223372036854775807);
pub const __ORDER_LITTLE_ENDIAN__ = 1234;
pub const __linux__ = 1;
pub const __INT16_TYPE__ = short;
pub const __PCLMUL__ = 1;
pub const __attribute_noinline__ = __attribute__(__noinline__);
pub const __FSWORD_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __UINTPTR_FMTx__ = "lx";
pub fn WIFEXITED(status: anytype) callconv(.Inline) @TypeOf(__WIFEXITED(status)) {
    return __WIFEXITED(status);
}
pub const __USE_ISOC99 = 1;
pub const __LDBL_MAX_EXP__ = 16384;
pub const __UINT_FAST32_MAX__ = @as(c_uint, 4294967295);
pub const __STD_TYPE = typedef;
pub const __AES__ = 1;
pub const __S32_TYPE = int;
pub const __FLT_RADIX__ = 2;
pub const __FD_SETSIZE = 1024;
pub const FD_SETSIZE = __FD_SETSIZE;
pub const __amd64 = 1;
pub const WCONTINUED = 8;
pub const __WINT_MAX__ = @as(c_uint, 4294967295);
pub fn __attribute_format_strfmon__(a: anytype, b: anytype) callconv(.Inline) @TypeOf(__attribute__(__format__(__strfmon__, a, b))) {
    return __attribute__(__format__(__strfmon__, a, b));
}
pub fn __builtin_nanf64x(x: anytype) callconv(.Inline) @TypeOf(__builtin_nanl(x)) {
    return __builtin_nanl(x);
}
pub const __UINTPTR_FMTo__ = "lo";
pub const __INT32_MAX__ = 2147483647;
pub const __PTHREAD_RWLOCK_INT_FLAGS_SHARED = 1;
pub const __INTPTR_FMTd__ = "ld";
pub const __USECONDS_T_TYPE = __U32_TYPE;
pub const __INTPTR_WIDTH__ = 64;
pub const __XSAVE__ = 1;
pub const __INT_FAST32_MAX__ = 2147483647;
pub const _BITS_TIME64_H = 1;
pub const __HAVE_FLOAT128X = 0;
pub const __BIG_ENDIAN = 4321;
pub const __INT32_FMTi__ = "i";
pub fn __bswap_constant_16(x: anytype) callconv(.Inline) @TypeOf(if (@typeId(@TypeOf(x >> 8 & 0xff | x & 0xff << 8)) == .Pointer) @ptrCast(__uint16_t, x >> 8 & 0xff | x & 0xff << 8) else if (@typeId(@TypeOf(x >> 8 & 0xff | x & 0xff << 8)) == .Int) @intToPtr(__uint16_t, x >> 8 & 0xff | x & 0xff << 8) else @as(__uint16_t, x >> 8 & 0xff | x & 0xff << 8)) {
    return if (@typeId(@TypeOf(x >> 8 & 0xff | x & 0xff << 8)) == .Pointer) @ptrCast(__uint16_t, x >> 8 & 0xff | x & 0xff << 8) else if (@typeId(@TypeOf(x >> 8 & 0xff | x & 0xff << 8)) == .Int) @intToPtr(__uint16_t, x >> 8 & 0xff | x & 0xff << 8) else @as(__uint16_t, x >> 8 & 0xff | x & 0xff << 8);
}
pub const __GCC_ATOMIC_CHAR32_T_LOCK_FREE = 2;
pub const __UINT_FAST16_FMTo__ = "ho";
pub const __RDSEED__ = 1;
pub const __ldiv_t_defined = 1;
pub const __USE_ISOC11 = 1;
pub const __GCC_ATOMIC_INT_LOCK_FREE = 2;
pub const __FLT_HAS_QUIET_NAN__ = 1;
pub const __MOVBE__ = 1;
pub const __INT_LEAST32_TYPE__ = int;
pub const __BIGGEST_ALIGNMENT__ = 16;
pub fn __REDIRECT_LDBL(name: anytype, proto: anytype, alias: anytype) callconv(.Inline) @TypeOf(__REDIRECT(name, proto, alias)) {
    return __REDIRECT(name, proto, alias);
}
pub const __GCC_ATOMIC_POINTER_LOCK_FREE = 2;
pub const __SIZE_MAX__ = @as(c_ulong, 18446744073709551615);
pub const __INT_FAST64_MAX__ = @as(c_long, 9223372036854775807);
pub const __HAVE_FLOAT128 = 0;
pub const __XSAVEC__ = 1;
pub const __CLANG_ATOMIC_LLONG_LOCK_FREE = 2;
pub const __UINTPTR_MAX__ = @as(c_ulong, 18446744073709551615);
pub const __UINT_FAST32_FMTx__ = "x";
pub const __PTRDIFF_FMTd__ = "ld";
pub const __INO_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __CLANG_ATOMIC_BOOL_LOCK_FREE = 2;
pub const __WCHAR_MAX__ = 2147483647;
pub const __ATOMIC_SEQ_CST = 5;
pub const __LDBL_MANT_DIG__ = 64;
pub fn be16toh(x: anytype) callconv(.Inline) @TypeOf(__bswap_16(x)) {
    return __bswap_16(x);
}
pub const __UINT_FAST8_MAX__ = 255;
pub const __SIZEOF_SIZE_T__ = 8;
pub const __THROW = __attribute__(if (@typeId(@TypeOf(__LEAF)) == .Pointer) @ptrCast(__nothrow__, __LEAF) else if (@typeId(@TypeOf(__LEAF)) == .Int) @intToPtr(__nothrow__, __LEAF) else @as(__nothrow__, __LEAF));
pub const __STDC_VERSION__ = @as(c_long, 201112);
pub const __BMI2__ = 1;
pub const __THROWNL = __attribute__(__nothrow__);
pub const __F16C__ = 1;
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16 = 1;
pub const MPG123_ID3 = 0x3;
pub const __OPENCL_MEMORY_SCOPE_WORK_GROUP = 1;
pub const __SSIZE_T_TYPE = __SWORD_TYPE;
pub const __DEV_T_TYPE = __UQUAD_TYPE;
pub const __SIZEOF_INT__ = 4;
pub const __znver1__ = 1;
pub const NULL = if (@typeId(@TypeOf(0)) == .Pointer) @ptrCast([*c]void, 0) else if (@typeId(@TypeOf(0)) == .Int) @intToPtr([*c]void, 0) else @as([*c]void, 0);
pub const __TIMESIZE = __WORDSIZE;
pub const __x86_64__ = 1;
pub const __UINT32_C_SUFFIX__ = U;
pub fn __f64(x: anytype) callconv(.Inline) @TypeOf(x) {
    return x;
}
pub const __clock_t_defined = 1;
pub const __BMI__ = 1;
pub const __SUSECONDS_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __FLT_MANT_DIG__ = 24;
pub const __INT_LEAST8_MAX__ = 127;
pub const __GLIBC_USE_IEC_60559_TYPES_EXT = 0;
pub const __UINTMAX_FMTo__ = "lo";
pub const __BIT_TYPES_DEFINED__ = 1;
pub const __SIZE_FMTo__ = "lo";
pub const __SIZEOF_DOUBLE__ = 8;
pub const __USE_ATFILE = 1;
pub fn __builtin_nanf32x(x: anytype) callconv(.Inline) @TypeOf(__builtin_nan(x)) {
    return __builtin_nan(x);
}
pub const MPG123_ICY = 0xc;
pub const __USE_POSIX_IMPLICITLY = 1;
pub const _SYS_TYPES_H = 1;
pub fn __WSTOPSIG(status: anytype) callconv(.Inline) @TypeOf(__WEXITSTATUS(status)) {
    return __WEXITSTATUS(status);
}
pub const __SIZEOF_WCHAR_T__ = 4;
pub const mpg123_enc_enum = enum_mpg123_enc_enum;
pub const timeval = struct_timeval;
pub const timespec = struct_timespec;
pub const __pthread_rwlock_arch_t = struct___pthread_rwlock_arch_t;
pub const __pthread_internal_list = struct___pthread_internal_list;
pub const __pthread_mutex_s = struct___pthread_mutex_s;
pub const __pthread_cond_s = struct___pthread_cond_s;
pub const random_data = struct_random_data;
pub const drand48_data = struct_drand48_data;
pub const mpg123_handle_struct = struct_mpg123_handle_struct;
pub const mpg123_parms = enum_mpg123_parms;
pub const mpg123_param_flags = enum_mpg123_param_flags;
pub const mpg123_param_rva = enum_mpg123_param_rva;
pub const mpg123_feature_set = enum_mpg123_feature_set;
pub const mpg123_errors = enum_mpg123_errors;
pub const mpg123_channelcount = enum_mpg123_channelcount;
pub const mpg123_channels = enum_mpg123_channels;
pub const mpg123_vbr = enum_mpg123_vbr;
pub const mpg123_version = enum_mpg123_version;
pub const mpg123_mode = enum_mpg123_mode;
pub const mpg123_flags = enum_mpg123_flags;
pub const mpg123_frameinfo = struct_mpg123_frameinfo;
pub const mpg123_state = enum_mpg123_state;
pub const mpg123_text_encoding = enum_mpg123_text_encoding;
pub const mpg123_id3_enc = enum_mpg123_id3_enc;
pub const mpg123_id3_pic_type = enum_mpg123_id3_pic_type;
pub const mpg123_pars_struct = struct_mpg123_pars_struct;
