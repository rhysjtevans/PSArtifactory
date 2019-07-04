# Authentication

The module supports two methods
 - Bearer Token
 - Basic Auth (username/password)

The `New-AFToken` can be used with `Set-AFCredential` to login with Basic Auth followed by generating and configuring the module to use an auth token instead.


## Getting Started

### Login with Basic Auth
```
Set-AFCredential -UserId admin -Password "Winter10"
```

### Obtaining a token
```
Set-AFCredential -Token (New-AFToken).access_token
```