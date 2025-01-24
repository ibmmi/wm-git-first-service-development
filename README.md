# GIT First Service Development for WebMethods

## Purpose

This repository exposes the simplest git-first service development structure for WebMethods microservices runtime and eventually Integration Server.

By "simplest" we mean only MSR, without other runtimes such as universal messaging or database runtimes. Different combinations are provided in separate template repositories.
If a specific combination is needed, contact us, we will be happy to extend the ecosystem with your concrete git template.

## Prerequisites

The scenario foresees a developer having a dedicated workstation, either a PC, laptop, virtual machine or remote development space. This box must have:

1. A git client of choice
2. Docker compose

    The author is using Rancher Desktop with WSL2 on Windows 11 with kubernetes disabled. This way, the docker system is very responsive.

3. WebMethods Designer having the service development perspective

    You do not need "local service development", nor "local unit testing", because the default offer is altering the server structure, and is therefore not 100% deterministic.

4. A code editor with modern linting and syntax highlighting for yaml, docker and docker compose files

    The needed capabilities are not offered in Designer.
    The author is using Visual Studio code.

5. Microservices Runtime License file
6. Microservices Runtime container image(s).

    Either download from the official registry or build them.

## Quick start

1. Ensure prerequisites
2. Generate your own repository with the "use this template" capability in GitHub.
3. In the run configs copy the `EXAMPLE.env` in the `.env` file. Edit according to needs.

    Remember, this repository does not include any software, you need to obtain the binaries and licenses according to your entitlements.

4. Review and run `get-jars` run configuration. Adapt the script to resolve your own dependencies.
5. Review and run `jcode-build` run configuration.
6. Spin up the `my-svc-dev1` run configuration with `docker compose up`.
7. Open Designer, point it to `http://localhost:40155` and develop services.

## Fundamental aspects

Work with Git clients externally, not from Designer. This is necessary due the obsolete abstractions for source control implemented in Designer, which assume you start from a local IS, not from git.

Create packages by with the following procedure:

1. into the folder ./code/is-packages
2. copy the folder Empty into a new folder having the desired package name
3. add the volume mount in the development run configuration following the given example
4. restart the container
5. refresh or restart Designer

It is important to note that some files such as licenses, binaries or password stores MUST NOT be committed in git! Adapt the `.gitignore` files accordingly. This also means that the source code repository does not contain an IS package directly importable in an MSR or IS runtime. You need to build that form of the package using the example scripts provided in `get-jars` and `jcode-build` run configurations. The result should be considered an artifact in the same way a jar file is a java artifact and deposited in some artifactory, not in git!

Docker compose is used in order to eliminate the need to have a specific local development version or rigid runtimes configuration. This way, the developer may use any runtime version! The approach has been tested with versions since 9.7, even with up to 10 different runtimes running in parallel on the same development machine. This use case would only be achievable by installing 10 different homes for service development, which is extremely cumbersome and onerous in resource terms.
Also, this approach allows for testing against databases and other providers, such as kafka, which can be simply inserted in the docker-compose configuration. This capability is not easy to achieve with the out-of-the-box local service development.
