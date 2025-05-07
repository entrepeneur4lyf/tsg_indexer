// This file contains minimal definitions of C# standard library types
// for use with tree-sitter-stack-graphs.

using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Net;
using System.Net.Http;
using System.Linq;

namespace System
{
    public class Object
    {
        public virtual bool Equals(object obj) { return false; }
        public virtual int GetHashCode() { return 0; }
        public virtual string ToString() { return null; }
        public Type GetType() { return null; }
    }

    public class String : IEnumerable<char>, IEquatable<string>, IComparable<string>
    {
        public int Length { get; }
        public char this[int index] { get { return '\0'; } }
        public bool Contains(string value) { return false; }
        public bool StartsWith(string value) { return false; }
        public bool EndsWith(string value) { return false; }
        public int IndexOf(string value) { return 0; }
        public int LastIndexOf(string value) { return 0; }
        public string Substring(int startIndex, int length) { return null; }
        public string[] Split(char separator) { return null; }
        public string Trim() { return null; }
        public string ToLower() { return null; }
        public string ToUpper() { return null; }
        public string Replace(string oldValue, string newValue) { return null; }
        public bool Equals(string other) { return false; }
        public int CompareTo(string other) { return 0; }
        public IEnumerator<char> GetEnumerator() { return null; }
        IEnumerator IEnumerable.GetEnumerator() { return null; }
        public static bool IsNullOrEmpty(string value) { return false; }
        public static bool IsNullOrWhiteSpace(string value) { return false; }
        public static string Join(string separator, IEnumerable<string> values) { return null; }
    }

    public struct Int32 : IEquatable<int>, IComparable<int>
    {
        public bool Equals(int other) { return false; }
        public int CompareTo(int other) { return 0; }
        public string ToString() { return null; }
        public static int Parse(string s) { return 0; }
        public static bool TryParse(string s, out int result) { result = 0; return false; }
    }

    public struct Boolean : IEquatable<bool>, IComparable<bool>
    {
        public bool Equals(bool other) { return false; }
        public int CompareTo(bool other) { return 0; }
        public string ToString() { return null; }
        public static bool Parse(string s) { return false; }
        public static bool TryParse(string s, out bool result) { result = false; return false; }
    }

    public struct DateTime : IEquatable<DateTime>, IComparable<DateTime>
    {
        public static readonly DateTime Now;
        public static readonly DateTime UtcNow;
        public static readonly DateTime MinValue;
        public static readonly DateTime MaxValue;

        public DateTime(int year, int month, int day) { }
        public DateTime(int year, int month, int day, int hour, int minute, int second) { }
        
        public int Year { get; }
        public int Month { get; }
        public int Day { get; }
        public int Hour { get; }
        public int Minute { get; }
        public int Second { get; }
        public DayOfWeek DayOfWeek { get; }
        
        public DateTime AddDays(double days) { return default; }
        public DateTime AddHours(double hours) { return default; }
        public DateTime AddMinutes(double minutes) { return default; }
        public DateTime AddMonths(int months) { return default; }
        public DateTime AddSeconds(double seconds) { return default; }
        public DateTime AddYears(int years) { return default; }
        
        public bool Equals(DateTime other) { return false; }
        public int CompareTo(DateTime other) { return 0; }
        public string ToString() { return null; }
        public string ToString(string format) { return null; }
        
        public static DateTime Parse(string s) { return default; }
        public static bool TryParse(string s, out DateTime result) { result = default; return false; }
    }

    public enum DayOfWeek
    {
        Sunday,
        Monday,
        Tuesday,
        Wednesday,
        Thursday,
        Friday,
        Saturday
    }

    public class Type
    {
        public string Name { get; }
        public string FullName { get; }
        public Type BaseType { get; }
        public bool IsClass { get; }
        public bool IsInterface { get; }
        public bool IsEnum { get; }
        public bool IsValueType { get; }
        public bool IsAbstract { get; }
        public bool IsGenericType { get; }
        public static Type GetType(string typeName) { return null; }
    }

    public class Exception
    {
        public Exception() { }
        public Exception(string message) { }
        public Exception(string message, Exception innerException) { }
        
        public string Message { get; }
        public string StackTrace { get; }
        public Exception InnerException { get; }
        public virtual string ToString() { return null; }
    }

    public class ArgumentException : Exception
    {
        public ArgumentException() { }
        public ArgumentException(string message) { }
        public ArgumentException(string message, string paramName) { }
        public ArgumentException(string message, Exception innerException) { }
        public string ParamName { get; }
    }

    public class ArgumentNullException : ArgumentException
    {
        public ArgumentNullException() { }
        public ArgumentNullException(string paramName) { }
        public ArgumentNullException(string paramName, string message) { }
    }

    public class NullReferenceException : Exception
    {
        public NullReferenceException() { }
        public NullReferenceException(string message) { }
        public NullReferenceException(string message, Exception innerException) { }
    }

    public interface IEquatable<T>
    {
        bool Equals(T other);
    }

    public interface IComparable<T>
    {
        int CompareTo(T other);
    }
}

namespace System.Collections
{
    public interface IEnumerable
    {
        IEnumerator GetEnumerator();
    }

    public interface IEnumerator
    {
        bool MoveNext();
        object Current { get; }
        void Reset();
    }

    public interface ICollection : IEnumerable
    {
        int Count { get; }
        bool IsSynchronized { get; }
        object SyncRoot { get; }
        void CopyTo(Array array, int index);
    }

    public interface IList : ICollection
    {
        bool IsFixedSize { get; }
        bool IsReadOnly { get; }
        object this[int index] { get; set; }
        int Add(object value);
        void Clear();
        bool Contains(object value);
        int IndexOf(object value);
        void Insert(int index, object value);
        void Remove(object value);
        void RemoveAt(int index);
    }
}

namespace System.Collections.Generic
{
    public interface IEnumerable<T> : IEnumerable
    {
        new IEnumerator<T> GetEnumerator();
    }

    public interface IEnumerator<T> : IDisposable, IEnumerator
    {
        new T Current { get; }
    }

    public interface ICollection<T> : IEnumerable<T>
    {
        int Count { get; }
        bool IsReadOnly { get; }
        void Add(T item);
        void Clear();
        bool Contains(T item);
        void CopyTo(T[] array, int arrayIndex);
        bool Remove(T item);
    }

    public interface IList<T> : ICollection<T>
    {
        T this[int index] { get; set; }
        int IndexOf(T item);
        void Insert(int index, T item);
        void RemoveAt(int index);
    }

    public interface IDictionary<TKey, TValue> : ICollection<KeyValuePair<TKey, TValue>>
    {
        TValue this[TKey key] { get; set; }
        ICollection<TKey> Keys { get; }
        ICollection<TValue> Values { get; }
        bool ContainsKey(TKey key);
        bool TryGetValue(TKey key, out TValue value);
        void Add(TKey key, TValue value);
        bool Remove(TKey key);
    }

    public class List<T> : IList<T>, IList
    {
        public List() { }
        public List(IEnumerable<T> collection) { }
        public List(int capacity) { }
        
        public int Count { get; }
        public int Capacity { get; set; }
        public T this[int index] { get { return default; } set { } }
        
        public void Add(T item) { }
        public void AddRange(IEnumerable<T> collection) { }
        public void Clear() { }
        public bool Contains(T item) { return false; }
        public void CopyTo(T[] array, int arrayIndex) { }
        public int IndexOf(T item) { return 0; }
        public void Insert(int index, T item) { }
        public bool Remove(T item) { return false; }
        public void RemoveAt(int index) { }
        public T[] ToArray() { return null; }
    }

    public class Dictionary<TKey, TValue> : IDictionary<TKey, TValue>, IDictionary
    {
        public Dictionary() { }
        public Dictionary(IDictionary<TKey, TValue> dictionary) { }
        public Dictionary(int capacity) { }
        
        public int Count { get; }
        public TValue this[TKey key] { get { return default; } set { } }
        public ICollection<TKey> Keys { get; }
        public ICollection<TValue> Values { get; }
        
        public void Add(TKey key, TValue value) { }
        public void Clear() { }
        public bool ContainsKey(TKey key) { return false; }
        public bool Remove(TKey key) { return false; }
        public bool TryGetValue(TKey key, out TValue value) { value = default; return false; }
    }
}

namespace System.Threading.Tasks
{
    public class Task
    {
        public Task(Action action) { }
        public static Task Delay(int millisecondsDelay) { return null; }
        public static Task<TResult> FromResult<TResult>(TResult result) { return null; }
        public bool IsCompleted { get; }
        public bool IsCanceled { get; }
        public bool IsFaulted { get; }
        public Task ContinueWith(Action<Task> continuationAction) { return null; }
        public static Task WhenAll(IEnumerable<Task> tasks) { return null; }
        public static Task WhenAny(IEnumerable<Task> tasks) { return null; }
        public void Wait() { }
        public static Task Run(Action action) { return null; }
        public static Task<TResult> Run<TResult>(Func<TResult> function) { return null; }
    }

    public class Task<TResult> : Task
    {
        public Task(Func<TResult> function) : base(null) { }
        public TResult Result { get; }
        public new Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, TNewResult> continuationFunction) { return null; }
    }
}

namespace System.IO
{
    public class File
    {
        public static bool Exists(string path) { return false; }
        public static string ReadAllText(string path) { return null; }
        public static string[] ReadAllLines(string path) { return null; }
        public static byte[] ReadAllBytes(string path) { return null; }
        public static void WriteAllText(string path, string contents) { }
        public static void WriteAllLines(string path, IEnumerable<string> contents) { }
        public static void WriteAllBytes(string path, byte[] bytes) { }
        public static void Copy(string sourceFileName, string destFileName) { }
        public static void Move(string sourceFileName, string destFileName) { }
        public static void Delete(string path) { }
        public static FileStream Create(string path) { return null; }
        public static FileStream Open(string path, FileMode mode) { return null; }
    }

    public class Directory
    {
        public static bool Exists(string path) { return false; }
        public static string[] GetFiles(string path) { return null; }
        public static string[] GetDirectories(string path) { return null; }
        public static void CreateDirectory(string path) { }
        public static void Delete(string path) { }
        public static void Delete(string path, bool recursive) { }
        public static void Move(string sourceDirName, string destDirName) { }
    }

    public class Path
    {
        public static readonly char DirectorySeparatorChar;
        public static readonly char AltDirectorySeparatorChar;
        public static readonly char PathSeparator;
        
        public static string Combine(string path1, string path2) { return null; }
        public static string GetDirectoryName(string path) { return null; }
        public static string GetFileName(string path) { return null; }
        public static string GetFileNameWithoutExtension(string path) { return null; }
        public static string GetExtension(string path) { return null; }
        public static string GetFullPath(string path) { return null; }
        public static string GetPathRoot(string path) { return null; }
        public static string GetTempPath() { return null; }
        public static string ChangeExtension(string path, string extension) { return null; }
    }

    public class FileStream : Stream
    {
        public FileStream(string path, FileMode mode) { }
        public FileStream(string path, FileMode mode, FileAccess access) { }
        public string Name { get; }
    }

    public abstract class Stream : IDisposable
    {
        public abstract bool CanRead { get; }
        public abstract bool CanWrite { get; }
        public abstract bool CanSeek { get; }
        public abstract long Length { get; }
        public abstract long Position { get; set; }
        public abstract void Flush();
        public abstract int Read(byte[] buffer, int offset, int count);
        public abstract long Seek(long offset, SeekOrigin origin);
        public abstract void SetLength(long value);
        public abstract void Write(byte[] buffer, int offset, int count);
        public virtual void Close() { }
        public void Dispose() { }
    }

    public enum FileMode
    {
        CreateNew,
        Create,
        Open,
        OpenOrCreate,
        Truncate,
        Append
    }

    public enum FileAccess
    {
        Read,
        Write,
        ReadWrite
    }

    public enum SeekOrigin
    {
        Begin,
        Current,
        End
    }
}

namespace System.Text
{
    public class StringBuilder
    {
        public StringBuilder() { }
        public StringBuilder(string value) { }
        public StringBuilder(int capacity) { }
        
        public int Length { get; set; }
        public int Capacity { get; set; }
        
        public StringBuilder Append(string value) { return this; }
        public StringBuilder Append(char value) { return this; }
        public StringBuilder Append(int value) { return this; }
        public StringBuilder AppendLine() { return this; }
        public StringBuilder AppendLine(string value) { return this; }
        public StringBuilder Insert(int index, string value) { return this; }
        public StringBuilder Remove(int startIndex, int length) { return this; }
        public StringBuilder Replace(string oldValue, string newValue) { return this; }
        public override string ToString() { return null; }
    }
}

namespace System.Text.RegularExpressions
{
    public class Regex
    {
        public Regex(string pattern) { }
        public Regex(string pattern, RegexOptions options) { }
        
        public bool IsMatch(string input) { return false; }
        public Match Match(string input) { return null; }
        public MatchCollection Matches(string input) { return null; }
        public string Replace(string input, string replacement) { return null; }
        public string[] Split(string input) { return null; }
        
        public static bool IsMatch(string input, string pattern) { return false; }
        public static Match Match(string input, string pattern) { return null; }
        public static MatchCollection Matches(string input, string pattern) { return null; }
        public static string Replace(string input, string pattern, string replacement) { return null; }
        public static string[] Split(string input, string pattern) { return null; }
    }

    public class Match
    {
        public bool Success { get; }
        public string Value { get; }
        public int Index { get; }
        public int Length { get; }
        public Group Groups { get; }
    }

    public class Group
    {
        public bool Success { get; }
        public string Value { get; }
        public int Index { get; }
        public int Length { get; }
        public CaptureCollection Captures { get; }
    }

    public class Capture
    {
        public string Value { get; }
        public int Index { get; }
        public int Length { get; }
    }

    public class MatchCollection : ICollection
    {
        public int Count { get; }
        public Match this[int i] { get { return null; } }
    }

    public class CaptureCollection : ICollection
    {
        public int Count { get; }
        public Capture this[int i] { get { return null; } }
    }

    public enum RegexOptions
    {
        None,
        IgnoreCase,
        Multiline,
        ExplicitCapture,
        Compiled,
        Singleline,
        IgnorePatternWhitespace,
        RightToLeft,
        ECMAScript,
        CultureInvariant
    }
}

namespace System.Linq
{
    public static class Enumerable
    {
        public static IEnumerable<TSource> Where<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate) { return null; }
        public static IEnumerable<TResult> Select<TSource, TResult>(this IEnumerable<TSource> source, Func<TSource, TResult> selector) { return null; }
        public static IOrderedEnumerable<TSource> OrderBy<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector) { return null; }
        public static IOrderedEnumerable<TSource> OrderByDescending<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector) { return null; }
        public static TSource First<TSource>(this IEnumerable<TSource> source) { return default; }
        public static TSource FirstOrDefault<TSource>(this IEnumerable<TSource> source) { return default; }
        public static TSource Single<TSource>(this IEnumerable<TSource> source) { return default; }
        public static TSource SingleOrDefault<TSource>(this IEnumerable<TSource> source) { return default; }
        public static TSource Last<TSource>(this IEnumerable<TSource> source) { return default; }
        public static TSource LastOrDefault<TSource>(this IEnumerable<TSource> source) { return default; }
        public static int Count<TSource>(this IEnumerable<TSource> source) { return 0; }
        public static TSource[] ToArray<TSource>(this IEnumerable<TSource> source) { return null; }
        public static List<TSource> ToList<TSource>(this IEnumerable<TSource> source) { return null; }
        public static Dictionary<TKey, TSource> ToDictionary<TSource, TKey>(this IEnumerable<TSource> source, Func<TSource, TKey> keySelector) { return null; }
    }

    public interface IOrderedEnumerable<TElement> : IEnumerable<TElement>
    {
        IOrderedEnumerable<TElement> ThenBy<TKey>(Func<TElement, TKey> keySelector);
        IOrderedEnumerable<TElement> ThenByDescending<TKey>(Func<TElement, TKey> keySelector);
    }
}

namespace System.Net.Http
{
    public class HttpClient : IDisposable
    {
        public HttpClient() { }
        public HttpClient(HttpMessageHandler handler) { }
        
        public Uri BaseAddress { get; set; }
        public TimeSpan Timeout { get; set; }
        
        public Task<HttpResponseMessage> GetAsync(string requestUri) { return null; }
        public Task<HttpResponseMessage> PostAsync(string requestUri, HttpContent content) { return null; }
        public Task<HttpResponseMessage> PutAsync(string requestUri, HttpContent content) { return null; }
        public Task<HttpResponseMessage> DeleteAsync(string requestUri) { return null; }
        public Task<string> GetStringAsync(string requestUri) { return null; }
        public Task<byte[]> GetByteArrayAsync(string requestUri) { return null; }
        public Task<Stream> GetStreamAsync(string requestUri) { return null; }
        public Task<HttpResponseMessage> SendAsync(HttpRequestMessage request) { return null; }
        
        public void Dispose() { }
    }

    public class HttpRequestMessage : IDisposable
    {
        public HttpRequestMessage() { }
        public HttpRequestMessage(HttpMethod method, string requestUri) { }
        public HttpRequestMessage(HttpMethod method, Uri requestUri) { }
        
        public HttpMethod Method { get; set; }
        public Uri RequestUri { get; set; }
        public HttpContent Content { get; set; }
        public HttpRequestHeaders Headers { get; }
        
        public void Dispose() { }
    }

    public class HttpResponseMessage : IDisposable
    {
        public HttpResponseMessage() { }
        public HttpResponseMessage(HttpStatusCode statusCode) { }
        
        public HttpStatusCode StatusCode { get; set; }
        public string ReasonPhrase { get; set; }
        public HttpContent Content { get; set; }
        public HttpResponseHeaders Headers { get; }
        public bool IsSuccessStatusCode { get; }
        
        public void Dispose() { }
    }

    public abstract class HttpContent : IDisposable
    {
        public HttpContentHeaders Headers { get; }
        
        public Task<byte[]> ReadAsByteArrayAsync() { return null; }
        public Task<string> ReadAsStringAsync() { return null; }
        public Task<Stream> ReadAsStreamAsync() { return null; }
        
        public void Dispose() { }
    }

    public class StringContent : HttpContent
    {
        public StringContent(string content) { }
        public StringContent(string content, Encoding encoding) { }
        public StringContent(string content, Encoding encoding, string mediaType) { }
    }

    public abstract class HttpMessageHandler : IDisposable
    {
        public void Dispose() { }
    }

    public abstract class HttpRequestHeaders
    {
    }

    public abstract class HttpResponseHeaders
    {
    }

    public abstract class HttpContentHeaders
    {
    }

    public class HttpMethod
    {
        public static readonly HttpMethod Get;
        public static readonly HttpMethod Post;
        public static readonly HttpMethod Put;
        public static readonly HttpMethod Delete;
        public static readonly HttpMethod Head;
        public static readonly HttpMethod Options;
        public static readonly HttpMethod Trace;
        
        public HttpMethod(string method) { }
        
        public string Method { get; }
    }
}