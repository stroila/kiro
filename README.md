# Kiro

## Build the image
```
make build
```

## Run the container
```
make run
```

## Login to Kiro CLI
Provide the ULR for the license, the AWS region. 
Open that URL (either by Crtl+click on it or by copy/pasting it into a browser)
- On the next window click "Confirm and continue"
- On the next window click "Allow access"
```
podman exec -it kiro-cli kiro-cli login --use-device-flow
```

## Check your identity
```
host:~/src/kiro$ podman exec -it kiro-cli kiro-cli whoami
```

## Ask questions
```
podman exec -it kiro-cli kiro-cli chat --no-interactive --trust-all-tools "describe the Zero Trust Pillars"
```

