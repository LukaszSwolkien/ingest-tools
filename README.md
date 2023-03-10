# Ingest-Tools
Sample bash scripts to POST json data over http into Splunk o11y suite. 

* Golang samples (OpenTelemetry Protocol [OTLP](https://github.com/open-telemetry/opentelemetry-proto-go)) are available here: https://github.com/LukaszSwolkien/ingest-tools-go

* Python samples (client library [signalfx-python](https://github.com/signalfx/signalfx-python)) are available here: https://github.com/LukaszSwolkien/ingest-tools-py

## Usage examples:

Create your organisation using Splunk API (see `create_org.sh`) and setup access token(s).

To learn more about sending data to Splunk O11y see: https://dev.splunk.com/observability/reference/api/ingest_data/latest

### Post metric data (SignalFx format):
```bash
./sample_metric_ingest.sh -i https://ingest.REALM.signalfx.com/v2/datapoint -t YOUR_ACCESS_TOKEN
```

### Post trace data (Zipkin format):
```bash
./sample_trace_ingest.sh -i https://ingest.REALM.signalfx.com/v2/trace -t YOUR_ACCESS_TOKEN
```

### Post log data (HEC format):
```bash
./sample_log_ingest.sh -i https://ingest.REALM.signalfx.com/v1/log -t YOUR_ACCESS_TOKEN
```

### Post rum trace data (Zipkin format)
```bash
./sample_rum_ingest.sh -i https://rum-ingest.REALM.signalfx.com/v1/rum -t YOUR_RUM_TOKEN
```
You can run any script periodicaly as a cron job, for example:

```crontab -e```

```vim
*/1 * * * * /home/ec2-user/Devel/ingest-tools/sample_metic_ingest.sh -i https://ingest.REALM.signalfx.com/v2/datapoint -t YOUR_ACCESS_TOKEN
```

./sample_otlp_trace_ingest.sh -i https://ingest.lab0.signalfx.com/v2/trace/otlp -t YOUR_ACCESS_TOKEN
./sample_otlp_metric_ingest.sh -i https://ingest.lab0.signalfx.com/v2/datapoint/otlp -t YOUR_ACCESS_TOKEN

## Setup organisation 
To use `create_org.sh` script you need to define following variables in `.secrets.yaml` file:

```yaml
my-first-name: "Lukasz"
my-last-name: "Swolkien"
my-email: "my_email@domain.com"
my-org-name: "your_org_name"
my-company-name: "your_company_name"
```
