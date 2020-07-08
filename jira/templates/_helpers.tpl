{{- define "jira.prefix" -}}
    {{- if .Values.prefix -}}
        {{.Values.prefix}}-
    {{- else -}}
    {{- end -}}
{{- end -}}

{{- define "jira.port" -}}8080{{- end -}}

{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "jira.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jira.fullname" -}}
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
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "jira.mysql.fullname" -}}
{{- if .Values.mysql.fullnameOverride -}}
{{- .Values.mysql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.mysql.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "mysql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "jira.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "jira.labels" -}}
helm.sh/chart: {{ include "jira.chart" . }}
{{ include "jira.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Set mysql host
*/}}
{{- define "jira.mysql.host" -}}
{{- if .Values.mysql.enabled -}}
{{- template "jira.mysql.fullname" . -}}
{{- else -}}
{{ required "A valid .Values.externalMysql.host is required" .Values.externalMysql.host }}
{{- end -}}
{{- end -}}


{{/*
Set mysql secret
*/}}
{{- define "jira.mysql.secret" -}}
{{- if .Values.mysql.enabled -}}
{{- template "jira.mysql.fullname" . -}}
{{- else -}}
{{- template "jira.fullname" . -}}
{{- end -}}
{{- end -}}


{{/*
Set mysql port
*/}}
{{- define "jira.mysql.port" -}}
{{- if .Values.mysql.enabled -}}
{{- default 3306 .Values.mysql.service.port }}
{{- else -}}
{{- required "A valid .Values.externalMysql.port is required" .Values.externalMysql.port -}}
{{- end -}}
{{- end -}}

{{/*
Set mysql username
*/}}
{{- define "jira.mysql.username" -}}
{{- if .Values.mysql.enabled -}}
{{- default "jira" .Values.mysql.mysqlUser }}
{{- else -}}
{{ required "A valid .Values.externalMysql.username is required" .Values.externalMysql.username }}
{{- end -}}
{{- end -}}

{{/*
Set mysql password
*/}}
{{- define "jira.mysql.password" -}}
{{- if .Values.mysql.enabled -}}
{{- default "" .Values.mysql.mysqlPassword }}
{{- else -}}
{{ required "A valid .Values.externalMysql.password is required" .Values.externalMysql.password }}
{{- end -}}
{{- end -}}

{{/*
Set mysql database
*/}}
{{- define "jira.mysql.database" -}}
{{- if .Values.mysql.enabled -}}
{{- default "sentry" .Values.mysql.mysqlDatabase }}
{{- else -}}
{{ required "A valid .Values.externalMysql.database is required" .Values.externalMysql.database }}
{{- end -}}
{{- end -}}



{{/*
Selector labels
*/}}
{{- define "jira.selectorLabels" -}}
app.kubernetes.io/name: {{ include "jira.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "jira.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "jira.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
