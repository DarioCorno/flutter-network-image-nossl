# flutter-network-image-nossl
A Flutter NetworkImage with disabled SSL check

Sometimes the Image.network Flutter Widget throws the following error:

`Handshake error in client (OS Error: CERTIFICATE_VERIFY_FAILED: unable to get local issuer certificate).`

This is due to missing or broken SSL certificates on the image hosting server.
If you are developing on a local server or hown a remote testing server on wich you don't want to setup a proper certificate just use this component with disabled SSL check.

** WARNING: USE AT YOUR RISK IN A PRODUCTION ENVIRONMENT! **

This component is ment for rapid prototyping and shouldn't be used in a production environment as it poses security risks. 

# Usage

```
  child: Image( 
    image: LSNetworkImageNoSSL(widget.seduta.esercizi[eserciziFatti].immagine),
    width: 90,
    fit: BoxFit.fill,
  )
```
