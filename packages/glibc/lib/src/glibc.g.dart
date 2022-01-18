// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

/// glibc FFI bindings
class GlibC {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  GlibC(ffi.DynamicLibrary dynamicLibrary) : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  GlibC.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  int getuid() {
    return _getuid();
  }

  late final _getuidPtr =
      _lookup<ffi.NativeFunction<__uid_t Function()>>('getuid');
  late final _getuid = _getuidPtr.asFunction<int Function()>();

  int geteuid() {
    return _geteuid();
  }

  late final _geteuidPtr =
      _lookup<ffi.NativeFunction<__uid_t Function()>>('geteuid');
  late final _geteuid = _geteuidPtr.asFunction<int Function()>();

  int sysinfo1(
    ffi.Pointer<sysinfo> __info,
  ) {
    return _sysinfo1(
      __info,
    );
  }

  late final _sysinfo1Ptr =
      _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<sysinfo>)>>(
          'sysinfo');
  late final _sysinfo1 =
      _sysinfo1Ptr.asFunction<int Function(ffi.Pointer<sysinfo>)>();
}

typedef __uid_t = ffi.Uint32;

class sysinfo extends ffi.Struct {
  @__kernel_long_t()
  external int uptime;

  @ffi.Array.multi([3])
  external ffi.Array<__kernel_ulong_t> loads;

  @__kernel_ulong_t()
  external int totalram;

  @__kernel_ulong_t()
  external int freeram;

  @__kernel_ulong_t()
  external int sharedram;

  @__kernel_ulong_t()
  external int bufferram;

  @__kernel_ulong_t()
  external int totalswap;

  @__kernel_ulong_t()
  external int freeswap;

  @__u16()
  external int procs;

  @__u16()
  external int pad;

  @__kernel_ulong_t()
  external int totalhigh;

  @__kernel_ulong_t()
  external int freehigh;

  @__u32()
  external int mem_unit;

  @ffi.Array.multi([0])
  external ffi.Array<ffi.Int8> _f;
}

typedef __kernel_long_t = ffi.Int64;
typedef __kernel_ulong_t = ffi.Uint64;
typedef __u16 = ffi.Uint16;
typedef __u32 = ffi.Uint32;

const int SI_LOAD_SHIFT = 16;