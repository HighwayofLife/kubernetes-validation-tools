FROM python:3.8.4-alpine3.12
# https://hub.docker.com/_/python

ARG APP_VERSION=2.1

# https://github.com/kubernetes/kubectl/releases
ARG KUBECTL_VERSION=1.18.5

# https://github.com/instrumenta/kubeval/releases
ARG KUBEVAL_VERSION=0.15.0

# https://pypi.org/project/yamllint/
ARG YAMLLINT_VERSION=1.23.0

# https://github.com/kubernetes-sigs/kustomize/releases
ARG KUSTOMIZE_VERSION=3.8.0

# https://github.com/open-policy-agent/conftest/releases
ARG CONFTEST_VERSION=0.19.0

# split layers into distinct components
RUN apk add --no-cache ca-certificates curl

# Install Kubeval
RUN  mkdir /tmp/kubeval \
    && curl -L -o /tmp/kubeval/kubeval.tar.gz \
      https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz \
    && tar xf /tmp/kubeval/kubeval.tar.gz -C /tmp/kubeval \
    && mv /tmp/kubeval/kubeval /usr/local/bin \
    && chmod +x /usr/local/bin/kubeval \
    && rm -rf /tmp/kubeval

# Install yamllint
RUN pip install yamllint==${YAMLLINT_VERSION} && \
    rm -rf ~/.cache/pip

# Install Kustomize
RUN mkdir /tmp/kustomize \
  && curl -L -o /tmp/kustomize/kustomize.tar.gz \
  https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
  && tar xf /tmp/kustomize/kustomize.tar.gz -C /tmp/kustomize \
  && mv /tmp/kustomize/kustomize /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize \
  && rm -rf /tmp/kustomize

# Install Conftest (https://www.conftest.dev/)
RUN mkdir /tmp/conftest \
  && curl -L -o /tmp/conftest/conftest.tar.gz \
  https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz \
  && tar xf /tmp/conftest/conftest.tar.gz -C /tmp/conftest \
  && mv /tmp/conftest/conftest /usr/local/bin \
  && chmod +x /usr/local/bin/conftest \
  && rm -rf /tmp/conftest

# Install Kubectl
RUN curl -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

CMD ["/bin/sh"]

