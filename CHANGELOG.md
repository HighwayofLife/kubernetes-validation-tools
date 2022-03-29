v2.7
----
### Features 🚀
* 🚀 **[NEW]** Added **[KubeSec](https://github.com/controlplaneio/kubesec)**, a Security risk analysis for Kubernetes Resources

### Additions
* Install Kubesec [v2.11.4](https://github.com/controlplaneio/kubesec/releases/tag/v2.11.4)

### Updates 📝
* Upgrade Python from 3.9 to 3.10
* Upgrade Kustomize from 4.1.3 to 4.5.3
* Upgrade Conftest from 0.25 to 0.30
* Upgrade Kube Score from 1.11 to 1.14
* Upgrade Polaris 4.0.2 to 5.1.0
* Upgrade Kube Linter 0.2.2 to 0.2.6
* Upgrade Kube Conform from 0.4.7 to 0.4.13
* Upgrade Kube Audit from 0.14.1 to 0.16.0
* Upgrade Datree from 0.1.431 to 1.0.15

v2.6
----
### Features 🚀
* 🚀 **[NEW]** Added **[Helm](https://github.com/helm/helm)** is a tool for managing Charts. Charts are packages of pre-configured Kubernetes resources.

Use Helm to:

* Lint and Validate your Helm Charts
* Generate manifests from your Helm Chart Templates
* Find and use popular software packaged as Helm Charts to run in Kubernetes
* Share your own applications as Helm Charts
* Create reproducible builds of your Kubernetes applications
* Intelligently manage your Kubernetes manifest files
* Manage releases of Helm packages

* 🚀 **[NEW]** Added **[Datree](https://github.com/datreeio/datree)** is a CLI tool that helps prevent Kubernetes misconfigurations from reaching production. Datree is a CLI tool to ensure K8s manifests and Helm charts follow best practices as well as your organization’s policies.

The Datree CLI integration provides a policy enforcement solution for Kubernetes to run automatic checks on every code change for rule violations and misconfigurations. When rule violations are found, Datree produces an alert which guides the developer to fix the issue inside the CI process — or even earlier as a pre-commit hook — while explaining the reason behind the rule.

### Additions
* Install Helm [v3.6.0](https://github.com/helm/helm/releases/tag/v3.6.0)
* Install Datree [v0.1.431](https://github.com/datreeio/datree/releases/tag/0.1.431)
* Install Datree Helm Plugin

### Updates 📝
* Kustomize from 4.1.0 to [4.1.3](https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv4.1.3)
* Polaris from 3.2.1 to [4.0.2](https://github.com/FairwindsOps/polaris/releases/tag/4.0.2)
* KubeLinter from 0.2.1 to [0.2.2](https://github.com/stackrox/kube-linter/releases/tag/0.2.2)
* KubeAudit from 0.14.0 to [0.14.1](https://github.com/Shopify/kubeaudit/releases/tag/v0.14.1)


v2.5
----

### Features 🚀

* 🚀  **[NEW]** Added **[Kubeconform](https://github.com/yannh/kubeconform)**, a Kubernetes manifests validation tool.

It is inspired by, contains code from and is designed to stay close to Kubeval, but with the following improvements:

* high performance: will validate & download manifests over multiple routines, caching downloaded files in memory
* configurable list of remote, or local schemas locations, enabling validating Kubernetes custom resources (CRDs) and offline validation capabilities
* uses by default a self-updating fork of the schemas registry maintained by the kubernetes-json-schema project - which guarantees up-to-date schemas for all recent versions of Kubernetes.

* 🚀  **[NEW]** Added **[Kubeaudit](https://github.com/Shopify/kubeaudit)**, a command line tool and a Go package to audit Kubernetes clusters for various different security concerns.

### Additions
* Install Kubeconform [v0.4.7](https://github.com/yannh/kubeconform/releases/tag/v0.4.7)
* Install Kubeaudit [v0.14.0](https://github.com/Shopify/kubeaudit/releases/tag/v0.14.0)

### Updates 📝
* Update Python from 3.9.0 to 3.9.5 on Alpine 3.13
* Update Kubectl from 1.19.3 to [v1.21.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.21.md), now installed via [Alpine package manager](https://pkgs.alpinelinux.org/package/edge/testing/x86_64/kubectl)
* Update Yamllint from 1.25.0 to [1.26.0](https://github.com/adrienverge/yamllint/blob/master/CHANGELOG.rst#1260-2021-01-29)
* Update Kustomize from 3.8.6 to [v4.1.0](https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv4.1.0)
* Update OPA Conftest from 0.21.0 to [v0.25.0](https://github.com/open-policy-agent/conftest/releases/tag/v0.25.0)
* Update Kube-Score to [v1.11.0](https://github.com/zegl/kube-score/releases/tag/v1.11.0)
* Update Polaris to [3.2.1](https://github.com/FairwindsOps/polaris/releases/tag/3.2.1)
* Update Kube-Linter to [0.2.1](https://github.com/stackrox/kube-linter/releases/tag/0.2.1)


v2.4
----
* 🚀 **[NEW]** Added [Kube-Score](https://github.com/zegl/kube-score), a tool that performs static code analysis of your Kubernetes object definitions. The output is a list of recommendations of what you can improve to make your application more secure and resilient.
* 🚀 **[NEW]** Added [Polaris](https://github.com/FairwindsOps/polaris), Polaris runs a variety of checks to ensure that Kubernetes pods and controllers are configured using best practices. Polaris is included as a CLI tool to test local YAML files, e.g. as part of a CI/CD process.
* 🚀 **[NEW]** Added [Kube Linter](https://github.com/stackrox/kube-linter), a static analysis tool that checks Kubernetes YAML files and Helm charts to ensure the applications represented in them adhere to best practices. KubeLinter accepts YAML files as input and runs a series of checks on them. If it finds any issues, it reports them and returns a non-zero exit code.

### Updates
* 📝 Updated Python from 3.8.4 to 3.9.0
* 📝 Updated Kubectl from 1.18.6 to 1.19.3
* 📝 Updated Yamllint from 1.24.2 to 1.25.0
* 📝 Updated Kustomize from 3.8.1 to 3.8.6
* 📝 Updated Conftest from 0.20.0 to 0.21.0

v2.3
----
* 🚀 **[NEW]** Added [Config-lint](https://stelligent.github.io/config-lint/#/?id=%f0%9f%94%8d-config-lint-%f0%9f%94%8e), A CLI tool to validate config files (JSON, Terraform, YAML + Kubernetes), using rules specified in YAML.

### Updates
* 📝 Updated Kubectl to [v1.18.6](https://kubernetes.io/docs/setup/release/notes/)
* 📝 Updated YAMLLint to [v1.24.2](https://github.com/adrienverge/yamllint/blob/master/CHANGELOG.rst)
* 📝 Updated Kustomize to [v3.8.1](https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv3.8.1)
* 📝 Updated Conftest to [v0.20.0](https://github.com/open-policy-agent/conftest/releases/tag/v0.20.0)

v2.2
----
* Create latest tag on Docker hub

v2.1
----

### Updates
* Updated base Python to 3.8.4-alpine3.12
* Updated Kubectl to v1.18.5
* Updated Kustomize to 3.8.0
* Updated Conftest to 0.19.0
* Updated Conftest to new home at open-policy-agent

v2.0
----

* 🚀 **[NEW]** Added ConfTest v0.18.1

### Updates
* Updated base Python to v3.8.2-alpine3.11
* Updated KubeCTL to v1.18.2
* Updated KubeVal to v0.15
* Updated YamlLint to v1.23
* Updated Kustomize to v3.5.4

