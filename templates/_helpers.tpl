{{/*
Expand the name of the chart.
*/}}
{{- define "kafkahelmdeploy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kafkahelmdeploy.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kafkahelmdeploy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "kafkahelmdeploy.kafkalabels" -}}
app.kubernetes.io/name: kafka
app.kubernetes.io/instance: kafka1
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/component: kafka
app.kubernetes.io/part-of: confluentkafka
helm.sh/chart: {{ include "kafkahelmdeploy.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "kafkahelmdeploy.zookeeperlabels" -}}
app.kubernetes.io/name: zookeeper
app.kubernetes.io/instance: zookeeper1
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/component: zookeeper
app.kubernetes.io/part-of: confluentkafka
helm.sh/chart: {{ include "kafkahelmdeploy.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "kafkahelmdeploy.kafkaselectors" -}}
app.kubernetes.io/name: kafka
app.kubernetes.io/instance: kafka1
{{- end }}

{{- define "kafkahelmdeploy.zookeeperselectors" -}}
app.kubernetes.io/name: zookeeper
app.kubernetes.io/instance: zookeeper1
{{- end }}


{{/*
Common labels
*/}}
{{- define "kafkahelmdeploy.labels" -}}
helm.sh/chart: {{ include "kafkahelmdeploy.chart" . }}
{{ include "kafkahelmdeploy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kafkahelmdeploy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kafkahelmdeploy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kafkahelmdeploy.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kafkahelmdeploy.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
