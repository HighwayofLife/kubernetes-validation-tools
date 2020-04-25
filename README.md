Kubernetes Validation Tools
===========================

Common validation and linting tools for structured configuration data, including Kubernetes YAML Manifests.

Why?
----

I wasn't able to find a single docker image that contained all of the major validation tools (of which there are several!) to validate Kubernetes YAML manifest files as part of a CI/CD process before being automatically deployed to Kubernetes. This repo isn't designed to cover how to use these individual tools, but the links below should lead you to documentation for using each tool. We have found it useful to use several tools during our CI process because some check certain aspects that others cannot.

Usage
-----

Grab the latest image from Docker hub: [Deck15/kubeval-tools](https://hub.docker.com/r/deck15/kubeval-tools)

```sh
docker run --rm -it deck15/kubeval-tools /bin/sh
```

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

