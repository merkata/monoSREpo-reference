# monoSREpo-reference
A reference for a monorepo that implements SRE principles against a toy API application

## Summary
The repository provides an overview of some SRE principles and best practices that you can reuse (or improve, feedback is always appreciated).

With this repo, you get the notion of a monorepo type of CI/CD, where code, infrastructure, configuration and application lifecycle live all under the same (GitOps) managed repository.

## Layout
The structure of the repository is as follows:

```shell
.
├── LICENSE holds the Apache 2.0 license
├── README.md <- you are here
├── app is the (Go) application that is used for the reference
├── chart is a helm chart for said app
├── dashboards are Grafana default dashboards used for monitoring
├── docs is the reference documentation, everything that does not fit in the README.md
├── infrastructure is the IaC for deploying on the cloud (reference cloud is AWS)
├── installer is a bootstrapper app in Go that can configure a repo for you based off this one
└── inventory is a kapitan configuration used for configuration reusability and target management
```

## Design

## Best practices

## Trade-offs

## Usage

## Pipeline workflow
