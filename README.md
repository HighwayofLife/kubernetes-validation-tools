Kubernetes Validation Tools
===========================

An all-in-one collection of tools to run linting, common validation, static code analysis, security scanning, configuration tests, auditing, kustomize build, and dry run configuration for structured Kubernetes YAML Manifests. Designed to run in a CI (Continuious Integration) process as part of validation and testing, especially useful for Kubernetes clusters that are managed through GitOps.

Why?
----

I wasn't able to find a single docker image that contained all of the major validation tools (of which there are several!) to validate Kubernetes YAML manifest files as part of a CI/CD process before being automatically deployed to Kubernetes. This repo isn't designed to cover how to use these individual tools, but the links below should lead you to documentation for using each tool. We have found it useful to use several tools during our CI process because some check certain aspects that others cannot.

Usage
-----

Grab the latest image from Docker hub: [Deck15/kubeval-tools](https://hub.docker.com/r/deck15/kubeval-tools)

```sh
docker run --rm -it deck15/kubeval-tools /bin/sh
```

Ideally the kubeval-tools container should be used in a CI process to validate and lint Kubernetes configs and manifests. It's optimal to run these tools as part of a [GitOps](https://www.gitops.tech/) CI workflow.

Tools List
----------


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


Contributing
------------

PRs welcome! Check out the [CONTRIBUTING](CONTRIBUTING.md) Guidelines for more information.
