# HTTP Status Codes Reference

> **Reference:** [MDN HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)

## Table of Contents

- [Success Codes (2xx)](#success-codes-2xx)
- [Client Error Codes (4xx)](#client-error-codes-4xx)
- [Server Error Codes (5xx)](#server-error-codes-5xx)

---

## Success Codes (2xx)

| Code | Name | Description |
|------|------|-------------|
| **200** | OK | Request succeeded. The meaning varies by HTTP method |

## Client Error Codes (4xx)

| Code | Name | Description |
|------|------|-------------|
| **400** | Bad Request | Server could not understand the request due to invalid syntax |
| **401** | Unauthorized | Client must authenticate to get the requested response (semantically means "unauthenticated") |
| **403** | Forbidden | Client does not have access rights to the content; server refuses to provide response |
| **404** | Not Found | Server cannot find the requested resource. URL not recognized or endpoint valid but resource doesn't exist |
| **408** | Request Timeout | Server wants to shut down unused connection. Sent on idle connection without previous request |

## Server Error Codes (5xx)

| Code | Name | Description |
|------|------|-------------|
| **500** | Internal Server Error | Server encountered a situation it doesn't know how to handle |
| **501** | Not Implemented | Request method not supported by the server |
| **502** | Bad Gateway | Server acting as gateway received invalid response |
| **503** | Service Unavailable | Server not ready to handle request (maintenance or overloaded) |
| **504** | Gateway Timeout | Server acting as gateway cannot get response in time |
| **511** | Network Authentication Required | Client needs to authenticate to gain network access |

## Quick Reference by Category

### Informational (1xx)
- 100 Continue
- 101 Switching Protocols

### Success (2xx)
- 200 OK
- 201 Created
- 204 No Content

### Redirection (3xx)
- 301 Moved Permanently
- 302 Found
- 304 Not Modified

### Client Error (4xx)
- 400 Bad Request
- 401 Unauthorized
- 403 Forbidden
- 404 Not Found
- 405 Method Not Allowed

### Server Error (5xx)
- 500 Internal Server Error
- 502 Bad Gateway
- 503 Service Unavailable
- 504 Gateway Timeout
