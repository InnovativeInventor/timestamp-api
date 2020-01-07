## Timestamp-API

A simple timestamping API (using [opentimestamps](https://opentimestamps.org)) that uploads attestations to the Bitcoin blockchain. 

Currently hosted on https://stamp.homelabs.space.


## API

Only 256-bit hashes are accepted right now (with a preference for SHA256):
```
/stamp/$HASH
```
This stamps a particular hash and returns the relative URL to access the proof.

```
/hash/$HASH
```
This how you access the timestamped proof of the hash.

```
/upgrade
```
This is how you force the server to upgrade the proof to a full, offline proof (this requires the transaction to be completed on the blockchain and takes a long time).

## Docker

Fetch:
```
docker pull innovativeinventor/timestamp-api
```

Build: 
```
docker build -t timestamp-api .
```

Running:
```
docker run --rm -it -p 8080:8080 -v hash:/hash/ timestam
```
