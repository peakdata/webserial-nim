# webserial-nim

Nim wrapper for the [Web Serial API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Serial_API)

## Installation

```bash
nimble install webserial
```

Or add to your `.nimble` file:

```nimble
requires "webserial >= 0.1.0"
```

## Usage

```nim
import webserial
import jsbuffers
import std/sequtils

# Request a serial port from the user
let port = await serial.requestPort()

# Open the port with specific options
await port.open(SerialPortOpts(
  baudRate: 9600,
  dataBits: 8,
  stopBits: 1,
  parity: "none",
  bufferSize: 255,
  flowControl: "none"
))

# Get a reader for the readable stream
let reader = port.readable.getReader()

# Get a writer for the writable stream
let writer = port.writable.getWriter()

# Send data using Uint8Array
let buffer = "Hello, Serial Port!".toUint8Array()
await writer.write(buffer)
echo "Sent message:", $buffer

# Read data
let chunk = await reader.read()
if not chunk.done:
  echo "Received:", $chunk.value
else:
  echo "No data received"

# Clean up
await reader.releaseLock()
await writer.releaseLock()
await port.close()
```

## API Reference

### Types

- `Serial`: The main serial interface
- `SerialPort`: Represents a serial port
- `SerialPortOpts`: Configuration options for opening a port
- `ReadableStream`: Stream for reading data
- `WritableStream`: Stream for writing data
- `ReadableStreamDefaultReader`: Reader for readable streams
- `WritableStreamDefaultWriter`: Writer for writable streams

### Buffer Types (from jsbuffers module)

- `ArrayBuffer`: JavaScript ArrayBuffer for binary data
- `DataView`: View for reading/writing binary data
- `Uint8Array`: Typed array for 8-bit unsigned integers

### Global Variables

- `serial`: The global serial interface (equivalent to `navigator.serial`)

### Methods

#### Serial Interface

- `getPorts()`: Get available serial ports
- `requestPort()`: Request user to select a serial port

#### SerialPort Interface

- `open(options)`: Open the port with specified options
- `close()`: Close the port
- `forget()`: Close and forget the port

#### Stream Methods

- `getReader()`: Get a reader for readable streams
- `getWriter()`: Get a writer for writable streams
- `cancel(reason)`: Cancel a readable stream
- `close()`: Close a writable stream
- `abort(reason)`: Abort a writable stream

#### Reader Methods

- `read()`: Read the next chunk of data (returns Uint8Array)
- `releaseLock()`: Release the reader lock
- `cancel(reason)`: Cancel the stream

#### Writer Methods

- `write(chunk)`: Write Uint8Array data to the stream
- `close()`: Close the stream
- `releaseLock()`: Release the writer lock
- `abort(reason)`: Abort the stream

#### Buffer Methods

- `newArrayBuffer(size)`: Create a new ArrayBuffer
- `newDataView(buffer)`: Create a DataView from ArrayBuffer
- `newUint8Array(buffer)`: Create an Uint8Array from ArrayBuffer
- `toUint8Array(seq[uint8] | openArray[uint8])`: Convert sequence or array to Uint8Array
- `toUint8Array(string)`: Convert string to Uint8Array
- `$`(uint8Array): Convert Uint8Array to string representation
- `setUint8(dataView, pos, value)`: Set a byte in DataView
- `getUint8(dataView, pos)`: Get a byte from DataView
- `byteLength`: Get the length of the buffer

## Browser Compatibility

The Web Serial API is currently supported in:

- Chrome/Chromium 89+
- Edge 89+
- Opera 76+

## License

MIT License - see LICENSE file for details.
