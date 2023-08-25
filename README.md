![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)   ![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

# flutter-network-image-nossl
A Flutter NetworkImage with disabled SSL check

Sometimes the Image.network Flutter Widget throws the following error:

`Handshake error in client (OS Error: CERTIFICATE_VERIFY_FAILED: unable to get local issuer certificate).`

This is due to missing or broken SSL certificates on the image hosting server.
If you are developing on a local server or own the remote server on wich you don't want to setup a proper SSL certificate just use this component with disabled SSL check.

**WARNING: USE AT YOUR RISK IN A PRODUCTION ENVIRONMENT!**

This component is ment for rapid prototyping and shouldn't be used in a production environment as it disables SSL verification and so poses security risks. 

# Usage

```
  child: Image( 
    image: LSNetworkImageNoSSL("https://server.com/yourimage.jpg"),
    width: 90,
    fit: BoxFit.fill,
  )
```
