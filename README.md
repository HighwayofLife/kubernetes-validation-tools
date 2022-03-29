Kubernetes Validation Tools
===========================

An all-in-one collection of tools to run linting, common validation, static code analysis, security scanning, configuration tests, auditing, kustomize build, and dry run configuration for structured Kubernetes YAML Manifests. Designed to run in a CI (Continuious Integration) process as part of validation and testing, especially useful for Kubernetes clusters that are managed through GitOps.

[![Docker](https://github.com/HighwayofLife/kubernetes-validation-tools/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/HighwayofLife/kubernetes-validation-tools/actions/workflows/docker-publish.yml) ![Docker Pulls](https://img.shields.io/docker/pulls/deck15/kubeval-tools?style=plastic)

Why?
----

I wasn't able to find a single docker image that contained all of the major validation tools (of which there are several!) to validate Kubernetes YAML manifest files as part of a CI/CD process before being automatically deployed to Kubernetes. This repo isn't designed to cover how to use these individual tools, though it does contain some basic usage examples. The links below should lead you to documentation for more details on using each tool. We have found it useful to use several tools during our CI validation and scanning process because some tools check certain aspects that others cannot.

Usage
-----

Grab the latest image from [Github Packages](https://github.com/HighwayofLife?tab=packages&repo_name=kubernetes-validation-tools) or from [Docker Hub](https://hub.docker.com/r/deck15/kubeval-tools).

You can run the image directly in docker, or see below for CI/CD usage examples.

```sh
docker run --rm -it docker.pkg.github.com/highwayoflife/kubernetes-validation-tools/image:latest /bin/bash
```

```sh
docker run --rm -it deck15/kubeval-tools:latest /bin/bash
```

Tools List
----------
| Tool        | Version  | Purpose    | Description                                                                       |
|-------------|----------|------------|-----------------------------------------------------------------------------------|
| Kubectl     | 1.23.5   | CLI        | Kubernetes CLI. Can be used with `--dry-run=client` to validate manifests         |
| Helm        | 3.8.1    | CLI        | Helm helps you manage Kubernetes applications — define, install, and upgrade  Kubernetes applications as helm charts. Run as a validation tool, can be run as `helm lint`, or `helm template`. |
| Yamllint    | 1.26.3   | Linter     | Basic linter for YAML files                                                       |
| Kubeval     | 0.16.1   | Validation | Tool for validating a Kubernetes YAML manifests. Doesn't work with CRDs.          |
| Kustomize   | 4.5.3    | Compile    | Template-free way to customize app configs. Useful to validate kustomize configs. |
| Config Lint | 1.6.0    | Validation | Validate config files using custom rules specified in YAML.                       |
| Conftest    | 0.30.0   | Tests      | Utility to help you write tests against structured configuration data.            |
| Kube Score  | 1.14.0   | Security   | Tool that performs **static code analysis** of Kubernetes object definitions.     |
| Polaris     | 5.1.0    | Validation | Identifies Kubernetes deployment configuration errors                             |
| Kube Linter | 0.2.6    | Security   | Linter and Static analysis tool that checks Kubernetes manifests                  |
| Kubeconform | 0.4.13   | Validation | Kubernetes manifests validation tool like Kubeval with CRD support                |
| Kubeaudit   | 0.16.0   | Security   | Audit clusters or manifest files for security concerns                            |
| Datree      | 1.0.15   | Policy     | Ensure Kubernetes manifests and Helm charts are valid and follow your policies.   |
| Kubesec     | 2.11.4   | Security   | Security risk analysis for Kubernetes resources                                   |

CI Examples
-----------

Ideally the kubernetes-validation-tools container should be used in a CI build process to validate, scan, and lint Kubernetes configs and manifests or helm charts. It's optimal to run these tools as part of a [GitOps](https://www.gitops.tech/) Continuious Integration workflow.

#### GitHub Actions Example
Use the container specifier to run a step inside a container. Be sure to specify runs-on as the appropriate host environment for your container (ubuntu-latest for Linux containers, windows-latest for Windows containers). For example:

```yaml
jobs:
  container:
    runs-on: ubuntu-latest
    container: deck15/kubeval-tools:latest
    steps:
      - run: |
          kubeconform -summary manifests.yaml
        name: Run in container
```

#### Jenkinsfile declarative example on Kubernetes
This example is useful if Jenkins is running agents in a Kubernetes cluster: `Jenkinsfile`

```groovy
pipeline {
  agent {
    kubernetes {
      cloud 'build-pipeline'
        defaultContainer 'validate'
        inheritFrom 'jnlp'
        yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: validate
    image: deck15/kubeval-tools:latest
    command:
      - cat
    tty: true
"""
    } // kubernetes
  } // agent

  stages {
    steps {
      container('validate') {
        sh 'kubeconform -summary manifests.yaml'
      }
    }
  }
}
```

#### Jenkinsfile declarative example using Docker agents

```groovy
pipeline {
  agent {
    docker { image 'deck15/kubeval-tools:latest' }
  } // agent

  ...
}
```

#### Drone example: `.drone.yml`

```yaml
kind: pipeline
type: docker
name: default

steps:
- name: validate
  image: deck15/kubeval-tools:latest
  commands:
    - kubeconform -summary manifests.yaml
```

#### Circle-CI example: `.circleci/config.yml`

```yaml
version: 2.0
jobs:
  build:
    docker:
      - image: deck15/kubeval-tools:latest
```

#### Gitlab CI example: `.gitlab-ci.yaml`
You can define an image that’s used for all jobs, and a list of services that you want to use during runtime:

```yaml
default:
  image: deck15/kubeval-tools:latest

validate:
  script:
    - kubeconform -summary manifests.yaml
```
Kubeaudit
---------
[Kubeaudit](https://github.com/Shopify/kubeaudit) is a command line tool and a Go package to audit Kubernetes clusters for various different security concerns, such as:

* run as non-root
* use a read-only root filesystem
* drop scary capabilities, don't add new ones
* don't run privileged
* and more!

kubeaudit makes sure you deploy secure containers!

KubeVal
-------

[kubeval](https://kubeval.instrumenta.dev/) is a tool for validating a Kubernetes YAML or JSON configuration file. It does so using schemas generated from the Kubernetes OpenAPI specification, and therefore can validate schemas for multiple versions of Kubernetes.

KubeConform
-----------

[Kubeconform](https://github.com/yannh/kubeconform) is a Kubernetes manifests validation tool. Build it into your CI to validate your Kubernetes configuration!

It is inspired by, contains code from and is designed to stay close to Kubeval, but with the following improvements:

* high performance: will validate & download manifests over multiple routines, caching downloaded files in memory
* configurable list of remote, or local schemas locations, enabling validating Kubernetes custom resources (CRDs) and offline validation capabilities
* uses by default a self-updating fork of the schemas registry maintained by the kubernetes-json-schema project - which guarantees up-to-date schemas for all recent versions of Kubernetes.

#### Usage examples
Validating a single, valid file

```sh
kubeconform fixtures/valid.yaml
echo $?
0
```

Validating a single invalid file, setting output to json, and printing a summary

```sh
kubeconform -summary -output json fixtures/invalid.yaml
{
  "resources": [
    {
      "filename": "fixtures/invalid.yaml",
      "kind": "ReplicationController",
      "version": "v1",
      "status": "INVALID",
      "msg": "Additional property templates is not allowed - Invalid type. Expected: [integer,null], given: string"
    }
  ],
  "summary": {
    "valid": 0,
    "invalid": 1,
    "errors": 0,
    "skipped": 0
  }
}

echo $?
1
```

Passing manifests via Stdin

```sh
cat fixtures/valid.yaml  | kubeconform -summary
Summary: 1 resource found parsing stdin - Valid: 1, Invalid: 0, Errors: 0 Skipped: 0
```

Validating a folder, increasing the number of parallel workers

```sh
kubeconform -summary -n 16 fixtures
fixtures/crd_schema.yaml - CustomResourceDefinition trainingjobs.sagemaker.aws.amazon.com failed validation: could not find schema for CustomResourceDefinition
fixtures/invalid.yaml - ReplicationController bob is invalid: Invalid type. Expected: [integer,null], given: string
[...]
Summary: 65 resources found in 34 files - Valid: 55, Invalid: 2, Errors: 8 Skipped: 0
```

ConfTest
--------
[ConfTest](https://www.conftest.dev/) is a utility to help you write tests against structured configuration data. For instance you could write tests for your Kubernetes configurations, or Tekton pipeline definitions, Terraform code, Serverless configs or any other structured data.

Conftest relies on the Rego language from Open Policy Agent for writing the assertions.

YAMLLint
--------
[yamllint](https://yamllint.readthedocs.io/) is a linter for YAML files.

yamllint does not only check for syntax validity, but for weirdnesses like key repetition and cosmetic problems such as lines length, trailing spaces, indentation, etc.

Kustomize
---------

[Kustomize](https://kustomize.io/) lets you customize raw, template-free YAML files for multiple purposes, leaving the original YAML untouched and usable as is.

kustomize targets kubernetes; it understands and can patch kubernetes style API objects. It's like make, in that what it does is declared in a file, and it's like sed, in that it emits edited text. Kustomize traverses a Kubernetes manifest to add, remove or update configuration options without forking.

Kustomize is particularly useful to use with tools like [ArgoCD](https://argoproj.github.io/argo-cd/user-guide/kustomize/), [FluxCD](https://docs.fluxcd.io/en/latest/references/fluxyaml-config-files/), or [Spinnaker](https://www.spinnaker.io/guides/user/kubernetes-v2/kustomize-manifests/) to enable shared manifests (resources) across multiple clusters or environments without duplicating code. Kustomize allows overrides, merges, and other configuration features.

KubeCTL
-------

[kubectl](https://kubectl.docs.kubernetes.io/) is the Kubernetes cli version of a swiss army knife, and can do many things. One of those things is being able to do a dry-run validate on a yaml file.

```sh
$ kubectl create --dry-run --validate -f invalid.yaml
```

Helm
----

Helm commands to use in CI to lint or validate helm charts.

#### helm lint
examine a chart for possible issues.

**NOTE:** 
> `helm lint` by itself is insufficient to adequately validate a helm chart. It is recommended to use `helm lint` and `helm template` in combination with one of the other manifest validation tools. (See below example)

This command takes a path to a chart and runs a series of tests to verify that the chart is well-formed.

If the linter encounters things that will cause the chart to fail installation, it will emit `[ERROR]` messages. If it encounters issues that break with convention or recommendation, it will emit `[WARNING]` messages.

```sh
helm lint PATH [flags]
```

#### helm template with kubeconform 

```sh
helm template ./path/to/chart | kubeconform -strict -ignore-missing-schemas
```

Config-Lint
-----------

[config-lint](https://stelligent.github.io/config-lint/) is a command line tool to validate configuration files using rules specified in YAML. The configuration files can be one of several formats: Terraform, JSON, YAML, with support for Kubernetes. There are built-in rules provided for Terraform, and custom files can be used for other formats.

```sh
config-lint -rules example-files/rules/kubernetes.yml example-files/config
```

Kube-Score
----------
[Kube-Score](https://github.com/zegl/kube-score), a tool that performs static code analysis of your Kubernetes object definitions. The output is a list of recommendations of what you can improve to make your application more secure and resilient.

kube-score can run in your CI/CD environment and will exit with exit code 1 if a critical error has been found. The trigger level can be changed to warning with the --exit-one-on-warning argument.

The input to kube-score should be all applications that you deploy to the same namespace for the best result.

#### Example with Helm
```sh
helm template my-app | kube-score score -
```

#### Example with Kustomize
```sh
kustomize build . | kube-score score -
```

#### Example with static YAMLs
```sh
kube-score score my-app/*.yaml
kube-score score my-app/deployment.yaml my-app/service.yaml
```

Polaris
-------
[Polaris](https://github.com/FairwindsOps/polaris), Polaris runs a variety of checks to ensure that Kubernetes pods and controllers are configured using best practices. Polaris is included as a CLI tool to test local YAML files, e.g. as part of a CI/CD process.

Polaris can be run in a few different modes:

* As a dashboard, so you can audit what's running inside your cluster.
* As a validating webhook, so you can automatically reject workloads that don't adhere to your organization's policies.
* As a command-line tool, so you can test local YAML files, e.g. as part of a CI/CD process.

You can run audits on the command line and see the output as JSON, YAML, or a raw score:

```sh
polaris audit --format yaml > report.yaml
polaris audit --format score
# 92
```

Audits can run against a local directory or YAML file rather than a cluster:

```sh
polaris audit --audit-path ./deploy/

# or to use STDIN
cat pod.yaml | polaris audit --audit-path -
```
You can also run the audit on a single resource instead of the entire cluster:

```sh
polaris audit --resource "nginx-ingress/Deployment.apps/v1/default-backend"
```
#### Running with CI/CD
You can integrate Polaris into CI/CD for repositories containing infrastructure-as-code. For example, to fail if polaris detects any danger-level issues, or if the score drops below 90%:

```sh
polaris audit --audit-path ./deploy/ \
  --set-exit-code-on-danger \
  --set-exit-code-below-score 90
```

For more usage options for CLI, see the [Usage Doc](https://github.com/FairwindsOps/polaris/blob/master/docs/usage.md)

Kube Linter
-----------

[Kube Linter](https://github.com/stackrox/kube-linter) is a static analysis tool that checks Kubernetes YAML files and Helm charts to ensure the applications represented in them adhere to best practices. KubeLinter accepts YAML files as input and runs a series of checks on them. If it finds any issues, it reports them and returns a non-zero exit code.

Datree
-----------

[Datree](https://github.com/datreeio/datree) is a CLI tool that can be used locally or in your CI/CD to ensure Kubernetes manifests and Helm charts follow best practices as well as your organization’s policies. It comes with 30 battle-tested rules to choose from, together with built-in support for YAML and kubernetes schema validation.  

#### Example with static YAMLs
```sh
datree test my-app/*.yaml
datree test my-app/deployment.yaml
```

#### Example with Helm
```sh
helm datree test <CHART_DIRECTORY>
```

KubeSec
-------

[KubeSec](https://github.com/controlplaneio/kubesec) is a security scanning tool for Kubernetes pods, deployments, daemonsets and statefulsets.

#### Example usage

```sh
kubesec scan manifest.yaml
```

#### Example output

Kubesec returns a returns a JSON array, and can scan multiple YAML documents in a single input file.

```json
[
  {
    "object": "Pod/security-context-demo.default",
    "valid": true,
    "message": "Failed with a score of -30 points",
    "score": -30,
    "scoring": {
      "critical": [
        {
          "selector": "containers[] .securityContext .capabilities .add == SYS_ADMIN",
          "reason": "CAP_SYS_ADMIN is the most privileged capability and should always be avoided",
          "points": -30
        }
      ],
      "advise": [
        {
          "selector": "containers[] .securityContext .runAsNonRoot == true",
          "reason": "Force the running image to run as a non-root user to ensure least privilege",
          "points": 1
        },
        {
          // ...
        }
      ]
    }
  }
]
```

Contributing
------------

PRs welcome! Check out the [CONTRIBUTING](CONTRIBUTING.md) Guidelines for more information.
