FROM python:3.9.5-alpine3.13
# https://hub.docker.com/_/python

ARG APP_VERSION=2.6

# https://github.com/instrumenta/kubeval/releases
ARG KUBEVAL_VERSION=0.16.1

# https://github.com/kubernetes-sigs/kustomize/releases
ARG KUSTOMIZE_VERSION=4.1.3

# https://github.com/open-policy-agent/conftest/releases
ARG CONFTEST_VERSION=0.25.0

# https://github.com/stelligent/config-lint/releases
ARG CONFIG_LINT_VERSION=1.6.0

# https://github.com/zegl/kube-score/releases
ARG KUBE_SCORE_VERSION=1.11.0

# https://github.com/FairwindsOps/polaris/releases
ARG POLARIS_VERSION=4.0.2

# https://github.com/stackrox/kube-linter/releases
ARG KUBE_LINTER_VERSION=0.2.2

# https://github.com/yannh/kubeconform/releases
ARG KUBECONFORM_VERSION=0.4.7

# https://github.com/Shopify/kubeaudit/releases
ARG KUBEAUDIT_VERSION=0.14.1

# https://github.com/datreeio/datree/releases
ARG DATREE_VERSION=0.1.431

# split layers into distinct components
# Install yamllint and kubectl via the alpine packages repositories
RUN apk add --no-cache --upgrade bash ca-certificates curl tar yamllint git \
  && apk add kubectl helm --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Install Kubeval
RUN  mkdir /tmp/kubeval \
  && curl -L -o /tmp/kubeval/kubeval.tar.gz \
  https://github.com/instrumenta/kubeval/releases/download/v${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz \
  && tar -xzf /tmp/kubeval/kubeval.tar.gz -C /tmp/kubeval \
  && mv /tmp/kubeval/kubeval /usr/local/bin \
  && chmod +x /usr/local/bin/kubeval \
  && rm -rf /tmp/kubeval

# Install Kustomize
RUN mkdir /tmp/kustomize \
  && curl -L -o /tmp/kustomize/kustomize.tar.gz \
  https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
  && tar -xzf /tmp/kustomize/kustomize.tar.gz -C /tmp/kustomize \
  && mv /tmp/kustomize/kustomize /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize \
  && rm -rf /tmp/kustomize

# Install KubeConform
RUN mkdir /tmp/kubeconform \
  && curl -L -o /tmp/kubeconform/kubeconform.tar.gz \
  https://github.com/yannh/kubeconform/releases/download/v${KUBECONFORM_VERSION}/kubeconform-linux-amd64.tar.gz \
  && tar -xzf /tmp/kubeconform/kubeconform.tar.gz -C /tmp/kubeconform \
  && mv /tmp/kubeconform/kubeconform /usr/local/bin \
  && chmod +x /usr/local/bin/kubeconform \
  && rm -rf /tmp/kubeconform

# Install Kubeaudit
RUN mkdir /tmp/kubeaudit \
  && curl -L -o /tmp/kubeaudit/kubeaudit.tar.gz \
  https://github.com/Shopify/kubeaudit/releases/download/v${KUBEAUDIT_VERSION}/kubeaudit_${KUBEAUDIT_VERSION}_linux_amd64.tar.gz \
  && tar -xzf /tmp/kubeaudit/kubeaudit.tar.gz -C /tmp/kubeaudit \
  && mv /tmp/kubeaudit/kubeaudit /usr/local/bin \
  && chmod +x /usr/local/bin/kubeaudit \
  && rm -rf /tmp/kubeaudit

# Install Conftest (https://www.conftest.dev/)
RUN mkdir /tmp/conftest \
  && curl -L -o /tmp/conftest/conftest.tar.gz \
  https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz \
  && tar -xzf /tmp/conftest/conftest.tar.gz -C /tmp/conftest \
  && mv /tmp/conftest/conftest /usr/local/bin \
  && chmod +x /usr/local/bin/conftest \
  && rm -rf /tmp/conftest

# Install Config Lint (https://stelligent.github.io/config-lint/#/install)
RUN mkdir /tmp/config-lint \
  && curl -L -o /tmp/config-lint/config-lint.tar.gz \
  https://github.com/stelligent/config-lint/releases/download/v${CONFIG_LINT_VERSION}/config-lint_Linux_x86_64.tar.gz \
  && tar -xzf /tmp/config-lint/config-lint.tar.gz -C /tmp/config-lint \
  && mv /tmp/config-lint/config-lint /usr/local/bin \
  && chmod +x /usr/local/bin/config-lint \
  && rm -rf /tmp/config-lint

# Install Kube Score (https://github.com/zegl/kube-score)
RUN mkdir /tmp/kube-score \
  && curl -L -o /tmp/kube-score/kube-score.tar.gz \
  https://github.com/zegl/kube-score/releases/download/v${KUBE_SCORE_VERSION}/kube-score_${KUBE_SCORE_VERSION}_linux_amd64.tar.gz \
  && tar -xzf /tmp/kube-score/kube-score.tar.gz -C /tmp/kube-score \
  && mv /tmp/kube-score/kube-score /usr/local/bin \
  && chmod +x /usr/local/bin/kube-score \
  && rm -rf /tmp/kube-score

# Install Polaris (https://github.com/FairwindsOps/polaris)
RUN mkdir /tmp/polaris \
  && curl -L -o /tmp/polaris/polaris.tar.gz \
  https://github.com/FairwindsOps/polaris/releases/download/${POLARIS_VERSION}/polaris_${POLARIS_VERSION}_linux_amd64.tar.gz \
  && tar -xzf /tmp/polaris/polaris.tar.gz -C /tmp/polaris \
  && mv /tmp/polaris/polaris /usr/local/bin \
  && chmod +x /usr/local/bin/polaris \
  && rm -rf /tmp/polaris

# Install Kube Linter (https://github.com/stackrox/kube-linter)
RUN mkdir /tmp/kube-linter \
  && curl -L -o /tmp/kube-linter/kube-linter.tar.gz \
  https://github.com/stackrox/kube-linter/releases/download/${KUBE_LINTER_VERSION}/kube-linter-linux.tar.gz \
  && tar -xzf /tmp/kube-linter/kube-linter.tar.gz -C /tmp/kube-linter \
  && mv /tmp/kube-linter/kube-linter /usr/local/bin \
  && chmod +x /usr/local/bin/kube-linter \
  && rm -rf /tmp/kube-linter

# Install Datree (https://github.com/datreeio/datree)
RUN mkdir /tmp/datree \
  && curl -L -o /tmp/datree/datree.zip \
  https://github.com/datreeio/datree/releases/download/${DATREE_VERSION}/datree-cli_${DATREE_VERSION}_Linux_x86_64.zip \
  && unzip /tmp/datree/datree.zip -d /tmp/datree/ \
  && mv /tmp/datree/datree /usr/local/bin \
  && chmod +x /usr/local/bin/datree \
  && rm -rf /tmp/datree \
  && helm plugin install https://github.com/datreeio/helm-datree

CMD ["/bin/bash"]

