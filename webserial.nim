## Wrapper library for the Web Serial class
from std/asyncjs import Future
import jsbuffers


type
  Serial* {.importjs.} = ref object of JsRoot
  ## https://developer.mozilla.org/en-US/docs/Web/API/Serial
  
  SerialPort* {.importjs.} = ref object of JsRoot
    ## https://developer.mozilla.org/en-US/docs/Web/API/SerialPort
    readable*: ReadableStream
    writable*: WritableStream
  
  SerialPortOpts* = ref object
    ## https://developer.mozilla.org/en-US/docs/Web/API/SerialPort/open
    ## A positive, non-zero value indicating the baud rate at which serial communication should be established.
    baudRate*: Positive
    ## An unsigned long integer indicating the size of the read and write buffers that are to be established. 
    ## If not passed, defaults to 255.
    bufferSize*: culong
    ## An integer value of 7 or 8 indicating the number of data bits per frame. If not passed, defaults to 8.
    dataBits*: range[7..8]
    ## The flow control type, either "none" or "hardware". The default value is "none".
    flowControl*: cstring
    ## The parity mode, either "none", "even", or "odd". The default value is "none".
    parity*: cstring
    ## An integer value of 1 or 2 indicating the number of stop bits at the end of the frame. 
    ## If not passed, defaults to 1.
    stopBits*: range[1..2]

  ReadableStream* {.importjs.} = ref object of JsRoot
    ## https://developer.mozilla.org/en-US/docs/Web/API/ReadableStream
    locked*: bool
  
  WritableStream* {.importjs.} = ref object of JsRoot
    ## https://developer.mozilla.org/en-US/docs/Web/API/WritableStream
    locked*: bool

  ReadableStreamDefaultReader* {.importjs.} = ref object of JsRoot
    ## The ReadableStreamDefaultReader interface of the Streams API represents a default reader that can be 
    ## used to read stream data supplied from a network (such as a fetch request).
    ## A ReadableStreamDefaultReader can be used to read from a ReadableStream that has an underlying 
    ## source of any type (unlike a ReadableStreamBYOBReader, which can only be used with readable streams 
    ## that have an underlying byte source).
    ## Note however that zero-copy transfer from an underlying source is only supported for underlying byte 
    ## sources that autoallocate buffers. In other words, the stream must have been constructed specifying 
    ## both type="bytes" and autoAllocateChunkSize. For any other underlying source, the stream will always 
    ## satisfy read requests with data from internal queues.
    ## https://developer.mozilla.org/en-US/docs/Web/API/ReadableStreamDefaultReader
    closed*: Future[void]
      ## Returns a Promise that fulfills when the stream closes, or rejects if the stream throws an error 
      ## or the reader's lock is released.
  
  ReadableStreamDefaultReaderChunk* {.importjs.} = ref object of JsRoot
    ## https://developer.mozilla.org/en-US/docs/Web/API/ReadableStreamDefaultReader/read#return_value
    value*: Uint8Array
    done*: bool

  WritableStreamDefaultWriter* {.importjs.} = ref object of JsRoot
    ## The WritableStreamDefaultWriter interface of the Streams API is the object 
    ## returned by WritableStream.getWriter() and once created locks the writer to 
    ## the WritableStream ensuring that no other streams can write to the underlying sink.
    ## https://developer.mozilla.org/en-US/docs/Web/API/WritableStreamDefaultWriter
    closed*: Future[void]
      ## Returns a promise that fulfills if the stream becomes closed, or rejects if 
      ## the stream errors or the writer's lock is released.
    desiredSize*: cint
      ## An integer. Note that this can be negative if the queue is over-full.
    ready*: Future[void]
      ## Returns a Promise that resolves when the desired size of the stream's internal 
      ## queue transitions from non-positive to positive, signaling that it is no longer applying backpressure.

var serial* {.importjs:"navigator.serial", nodecl.}: Serial

####################
## Serial Methods ##
####################

func getPorts*(self: Serial): Future[seq[SerialPort]] {.importjs: "#.$1(@)".}
  ## The getPorts() method of the Serial interface returns a Promise that resolves 
  ## with an array of SerialPort objects representing serial ports connected to the 
  ## host which the origin has permission to access.
  ## https://developer.mozilla.org/en-US/docs/Web/API/Serial/getPorts

func requestPort*(self: Serial): Future[SerialPort] {.importjs: "#.$1(@)".}
  ## The Serial.requestPort() method of the Serial interface returns a Promise that 
  ## resolves with an instance of SerialPort representing the device chosen by the user 
  ## or rejects if no device was selected.
  ## https://developer.mozilla.org/en-US/docs/Web/API/Serial/requestPort

#########################
## Serial Port Methods ##
#########################

func close*(self: SerialPort): Future[void] {.importjs: "#.$1(@)".}
  ## The SerialPort.close() method of the SerialPort interface returns a Promise that resolves when the port closes.
  ## https://developer.mozilla.org/en-US/docs/Web/API/SerialPort/close

func forget*(self: SerialPort): Future[void] {.importjs: "#.$1(@)".}
  ## The SerialPort.forget() method of the SerialPort interface returns a Promise that resolves when 
  ## the serial port is closed and is forgotten.
  ## https://developer.mozilla.org/en-US/docs/Web/API/SerialPort/forget
  
func open*(self: SerialPort, options: SerialPortOpts): Future[void] {.importjs: "#.$1(@)".}
  ## The open() method of the SerialPort interface returns a Promise that resolves 
  ## when the port is opened. By default the port is opened with 8 data bits, 
  ## 1 stop bit and no parity checking. The baudRate parameter is required.
  ## https://developer.mozilla.org/en-US/docs/Web/API/SerialPort/open

####################
## Stream Methods ##
####################

func abort*(self: WritableStream, reason: cstring): Future[cstring] {.importjs: "#.$1(@)".}
  ## Aborts the stream, signaling that the producer can no longer successfully write to the 
  ## stream and it is to be immediately moved to an error state, with any queued writes discarded.
  ## https://developer.mozilla.org/en-US/docs/Web/API/WritableStream/abort

func close*(self: WritableStream) {.importjs: "#.$1(@)".}
  ## Closes the stream.

func cancel*(self: ReadableStream, reason: cstring = ""): Future[cstring] {.importjs: "#.$1(@)".}
  ## The cancel() method of the ReadableStream interface returns a Promise that resolves when the stream is canceled.
  ## Cancel is used when you've completely finished with the stream and don't need any more data from it, 
  ## even if there are chunks enqueued waiting to be read. That data is lost after cancel is called, 
  ## and the stream is not readable any more. To read those chunks still and not completely get rid of the stream, 
  ## you'd use ReadableStreamDefaultController.close(). 

func getReader*(self: ReadableStream): ReadableStreamDefaultReader {.importjs: "#.$1(@)".}
  ## The getReader() method of the ReadableStream interface creates a reader and locks the stream to it. 
  ## While the stream is locked, no other reader can be acquired until this one is released.
  ## https://developer.mozilla.org/en-US/docs/Web/API/ReadableStream/getReader

####################################
## Readable Stream Default Reader ##
####################################

func cancel*(self: ReadableStreamDefaultReader, reason: cstring = ""): Future[cstring] {.importjs: "#.$1(@)".}
  ## The cancel() method of the ReadableStreamDefaultReader interface returns a Promise that resolves when the 
  ## stream is canceled. Calling this method signals a loss of interest in the stream by a consumer.
  ## Cancel is used when you've completely finished with the stream and don't need any more data from it, 
  ## even if there are chunks enqueued waiting to be read. That data is lost after cancel is called, and the 
  ## stream is not readable any more. To read those chunks still and not completely get rid of the stream, 
  ## you'd use ReadableStreamDefaultController.close().
  ## https://developer.mozilla.org/en-US/docs/Web/API/ReadableStreamDefaultReader/cancel 

func read*(self: ReadableStreamDefaultReader): Future[ReadableStreamDefaultReaderChunk] {.importjs: "#.$1(@)".}
  ## The read() method of the ReadableStreamDefaultReader interface returns a Promise providing access 
  ## to the next chunk in the stream's internal queue.
  ## https://developer.mozilla.org/en-US/docs/Web/API/ReadableStreamDefaultReader/read

func releaseLock*(self: ReadableStreamDefaultReader): Future[void] {.importjs: "#.$1(@)".}
  ## The releaseLock() method of the ReadableStreamDefaultReader interface releases the reader's 
  ## lock on the stream. If the associated stream is errored when the lock is released, the reader will 
  ## appear errored in that same way subsequently; otherwise, the reader will appear closed.
  ## If the reader's lock is released while it still has pending read requests then the promises returned 
  ## by the reader's ReadableStreamDefaultReader.read() method are immediately rejected with a TypeError. 
  ## Unread chunks remain in the stream's internal queue and can be read later by acquiring a new reader. 
  ## https://developer.mozilla.org/en-US/docs/Web/API/ReadableStreamDefaultReader/releaseLock

####################################
## Writable Stream Default Writer ##
####################################

func getWriter*(self: WritableStream): WritableStreamDefaultWriter {.importjs: "#.$1(@)".}
  ## Returns a new instance of WritableStreamDefaultWriter and locks the stream to that instance. 
  ## While the stream is locked, no other writer can be acquired until this one is released. 
  ## https://developer.mozilla.org/en-US/docs/Web/API/WritableStream/getWriter

func abort*(self: WritableStreamDefaultWriter, reason: cstring = ""): Future[cstring] {.importjs: "#.$1(@)".}
  ## The abort() method of the WritableStreamDefaultWriter interface aborts the stream, signaling 
  ## that the producer can no longer successfully write to the stream and it is to be immediately 
  ## moved to an error state, with any queued writes discarded.
  ## If the writer is active, the abort() method behaves the same as that for the associated stream 
  ## (WritableStream.abort()). If not, it returns a rejected promise.
  ## https://developer.mozilla.org/en-US/docs/Web/API/WritableStreamDefaultWriter/abort

func close*(self: WritableStreamDefaultWriter): Future[void] {.importjs: "#.$1(@)".}
  ##  The close() method of the WritableStreamDefaultWriter interface closes the associated writable stream.
  ## The underlying sink will finish processing any previously-written chunks, before invoking the close 
  ## behavior. During this time any further attempts to write will fail (without erroring the stream).
  ## https://developer.mozilla.org/en-US/docs/Web/API/WritableStreamDefaultWriter/close

func releaseLock*(self: WritableStreamDefaultWriter): Future[void] {.importjs: "#.$1(@)".}
  ## The releaseLock() method of the WritableStreamDefaultWriter interface releases the writer's 
  ## lock on the corresponding stream. After the lock is released, the writer is no longer active. 
  ## If the associated stream is errored when the lock is released, the writer will appear errored 
  ## in the same way from now on; otherwise, the writer will appear closed.
  ## https://developer.mozilla.org/en-US/docs/Web/API/WritableStreamDefaultWriter/releaseLock

func write*(self: WritableStreamDefaultWriter, chunk: Uint8Array): Future[void] {.importjs: "#.$1(@)".}
  ## The write() method of the WritableStreamDefaultWriter interface writes a passed chunk of data to a 
  ## WritableStream and its underlying sink, then returns a Promise that resolves to indicate the success or 
  ## failure of the write operation.
  ## Note that what "success" means is up to the underlying sink; it might indicate that the chunk has been 
  ## accepted, and not necessarily that it is safely saved to its ultimate destination.
  ## https://developer.mozilla.org/en-US/docs/Web/API/WritableStreamDefaultWriter/write

