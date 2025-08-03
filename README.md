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

# Read data
let chunk = await reader.read()
echo "Received: ", chunk.value

# Get a writer for the writable stream
let writer = port.writable.getWriter()

# Write data
await writer.write(@[65'u8, 66'u8, 67'u8]) # "ABC"

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

- `read()`: Read the next chunk of data
- `releaseLock()`: Release the reader lock
- `cancel(reason)`: Cancel the stream

#### Writer Methods

- `write(chunk)`: Write data to the stream
- `close()`: Close the stream
- `releaseLock()`: Release the writer lock
- `abort(reason)`: Abort the stream

## Browser Compatibility

This wrapper requires a browser that supports the Web Serial API. Currently supported in:

- Chrome/Chromium 89+
- Edge 89+
- Opera 76+

## License

MIT License - see LICENSE file for details.
