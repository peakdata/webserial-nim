## Wrapper library for the JS ArrayBuffer and related classes.

type
  ArrayBuffer* {.importjs.} = ref object of JsRoot
  DataView* {.importjs.} = ref object of JsRoot
  Uint8Array* {.importjs.} = ref object of JsRoot
    buffer*: ArrayBuffer
    byteLength*: uint


proc newArrayBuffer*(bytes: int): ArrayBuffer {.importjs: "new ArrayBuffer(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer

proc newDataView*(buffer: ArrayBuffer): DataView {.importjs: "new DataView(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView

proc newUint8Array*(buffer: ArrayBuffer): Uint8Array {.importjs: "new Uint8Array(@)".}
proc newUint8Array*(buffer: ArrayBuffer, byteOffset: int): Uint8Array {.importjs: "new Uint8Array(@)".}
proc newUint8Array*(buffer: ArrayBuffer, byteOffset: int, length: int): Uint8Array {.importjs: "new Uint8Array(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Uint8Array#constructor


proc getBigInt64*(dataView: DataView, pos: int, littleEndian = false): int64 {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/getBigInt64
proc getBigUint64*(dataView: DataView, pos: int, littleEndian = false): uint64 {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/getBigUint64
proc getFloat32*(dataView: DataView, pos: int, littleEndian = false): float32 {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/getFloat32
proc getFloat64*(dataView: DataView, pos: int, littleEndian = false): float64 {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/getFloat64
proc getInt16*(dataView: DataView, pos: int, littleEndian = false): int16 {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/getInt16
proc getInt32*(dataView: DataView, pos: int, littleEndian = false): int32 {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/getInt32
proc getInt8*(dataView: DataView, pos: int, littleEndian = false): int8 {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/getInt8
proc getUint16*(dataView: DataView, pos: int, littleEndian = false): uint16 {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/getUint16
proc getUint32*(dataView: DataView, pos: int, littleEndian = false): uint32 {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/getUint32
proc getUint8*(dataView: DataView, pos: int, littleEndian = false): uint8 {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/getUint8
proc setBigInt64*(dataView: DataView, pos: int, value: int64, littleEndian = false) {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/setBigInt64
proc setBigUint64*(dataView: DataView, pos: int, value: uint64, littleEndian = false) {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/setBigUint64
proc setFloat32*(dataView: DataView, pos: int, value: float32, littleEndian = false) {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/setFloat32
proc setFloat64*(dataView: DataView, pos: int, value: float64, littleEndian = false) {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/setFloat64
proc setInt16*(dataView: DataView, pos: int, value: int16, littleEndian = false) {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/setInt16
proc setInt32*(dataView: DataView, pos: int, value: int32, littleEndian = false) {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/setInt32
proc setInt8*(dataView: DataView, pos: int, value: int8, littleEndian = false) {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/setInt8
proc setUint16*(dataView: DataView, pos: int, value: uint16, littleEndian = false) {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/setUint16
proc setUint32*(dataView: DataView, pos: int, value: uint32, littleEndian = false) {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/setUint32
proc setUint8*(dataView: DataView, pos: int, value: uint8, littleEndian = false) {.importjs: "#.$1(@)".}
## https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView/setUint8
