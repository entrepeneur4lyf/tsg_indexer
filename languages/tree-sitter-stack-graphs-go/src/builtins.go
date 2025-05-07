// This file contains minimal definitions of Go standard library types
// for use with tree-sitter-stack-graphs.

// Basic types
type string string
type int int
type int8 int8
type int16 int16
type int32 int32
type int64 int64
type uint uint
type uint8 uint8
type uint16 uint16
type uint32 uint32
type uint64 uint64
type byte uint8
type rune int32
type float32 float32
type float64 float64
type complex64 complex64
type complex128 complex128
type bool bool

// Error interface
type error interface {
    Error() string
}

// fmt package
package fmt

func Print(a ...interface{}) (n int, err error)
func Printf(format string, a ...interface{}) (n int, err error)
func Println(a ...interface{}) (n int, err error)
func Sprint(a ...interface{}) string
func Sprintf(format string, a ...interface{}) string
func Sprintln(a ...interface{}) string

// strings package
package strings

func Contains(s, substr string) bool
func Join(elems []string, sep string) string
func Split(s, sep string) []string
func Replace(s, old, new string, n int) string

// io package
package io

type Reader interface {
    Read(p []byte) (n int, err error)
}

type Writer interface {
    Write(p []byte) (n int, err error)
}

type ReadWriter interface {
    Reader
    Writer
}

type Closer interface {
    Close() error
}

type ReadCloser interface {
    Reader
    Closer
}

type WriteCloser interface {
    Writer
    Closer
}

type ReadWriteCloser interface {
    Reader
    Writer
    Closer
}

// http package
package http

type Handler interface {
    ServeHTTP(ResponseWriter, *Request)
}

type ResponseWriter interface {
    Header() Header
    Write([]byte) (int, error)
    WriteHeader(statusCode int)
}

type Request struct {
    Method string
    URL *URL
    Header Header
    Body io.ReadCloser
}

type Client struct {
    Timeout time.Duration
}

func (c *Client) Get(url string) (*Response, error)
func (c *Client) Post(url, contentType string, body io.Reader) (*Response, error)

type Response struct {
    Status string
    StatusCode int
    Header Header
    Body io.ReadCloser
}

// context package
package context

type Context interface {
    Deadline() (deadline time.Time, ok bool)
    Done() <-chan struct{}
    Err() error
    Value(key interface{}) interface{}
}

// sync package
package sync

type Mutex struct{}
func (m *Mutex) Lock()
func (m *Mutex) Unlock()

type WaitGroup struct{}
func (wg *WaitGroup) Add(delta int)
func (wg *WaitGroup) Done()
func (wg *WaitGroup) Wait()

type Once struct{}
func (o *Once) Do(f func())

type Map struct{}
func (m *Map) Delete(key interface{})
func (m *Map) Load(key interface{}) (value interface{}, ok bool)
func (m *Map) Store(key, value interface{})

// time package
package time

type Time struct{}
type Duration int64

func Now() Time
func (t Time) Add(d Duration) Time
func (t Time) Sub(u Time) Duration
func Parse(layout, value string) (Time, error)
func Sleep(d Duration)

// json package
package json

func Marshal(v interface{}) ([]byte, error)
func Unmarshal(data []byte, v interface{}) error

type Decoder struct{}
func NewDecoder(r io.Reader) *Decoder
func (dec *Decoder) Decode(v interface{}) error

type Encoder struct{}
func NewEncoder(w io.Writer) *Encoder
func (enc *Encoder) Encode(v interface{}) error

// os package
package os

type File struct{}
func Open(name string) (*File, error)
func Create(name string) (*File, error)
func (f *File) Close() error
func (f *File) Read(b []byte) (n int, err error)
func (f *File) Write(b []byte) (n int, err error)

func Remove(name string) error
func RemoveAll(path string) error
func Getwd() (dir string, err error)
func Mkdir(name string, perm FileMode) error