import std/asyncjs
import ../src/webserial
import ../src/jsbuffers

proc sleep(ms: int): Future[void] {.async.} =
  # JavaScript setTimeout equivalent
  {.emit: "await new Promise(resolve => setTimeout(resolve, `ms`));".}

proc main() {.async.} =
  try:
    # Request a serial port from the user
    echo "Please select a serial port..."
    let port = await serial.requestPort()
    
    # Open the port with default settings
    await port.open(SerialPortOpts(
      baudRate: 9600,
      dataBits: 8,
      stopBits: 1,
      parity: "none",
      bufferSize: 255,
      flowControl: "none"
    ))
    
    echo "Port opened successfully!"
    
    # Get a reader for incoming data
    let reader = port.readable.getReader()
    
    # Get a writer for outgoing data
    let writer = port.writable.getWriter()
    
    # Send a test message using Uint8Array
    let buffer = "Hello Serial!".toUint8Array()
    await writer.write(buffer)
    echo "Sent message:\t", $buffer
    
    # Wait 1 second before reading
    echo "Waiting 1 second before reading..."
    await sleep(1000)
    
    # Read response (if any)
    let chunk = await reader.read()
    if not chunk.done:
      echo "Received:\t\t", $chunk.value
    else:
      echo "No data received"
    
    # Clean up
    await reader.releaseLock()
    await writer.releaseLock()
    await port.close()
    echo "Port closed successfully!"
    
  except Exception as e:
    echo "Error: ", e.msg

# Export the main function for JavaScript
proc startSerialExample() {.exportc.} =
  discard main()
