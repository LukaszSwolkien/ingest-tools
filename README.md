# Tools to feed Splunk o11y with sample data
Sample bash scripts to POST json data over http into Splunk o11y suite. 

* Python sample data generators are available here: https://github.com/LukaszSwolkien/ingest-tools-py
* Golang Sample data generators are available here: https://github.com/LukaszSwolkien/ingest-tools-go

## Usage examples:

Create your organisation using Splunk API (see `create_org.sh`) and setup access token(s).
Remember to create `.secrets.yaml` file with secrets, see [here](#Setup-project).

To learn more about sending data to Splunk O11y see: https://dev.splunk.com/observability/reference/api/ingest_data/latest

### Metric data generator (SignalFx format):
```bash
./sample_metric_ingest.sh
```

### Trace data generator (Zipkin format):
```bash
./sample_trace_ingest.sh
```

### Log data generator (HEC format):
```bash
./sample_log_ingest.sh
```

You can run any script periodicaly as a cron job, for example:

```crontab -e```

```vim
*/1 * * * * /home/ec2-user/Devel/test_integration/sample_metic_ingest.sh
```

## Setup project 
You need to create `.secrets.yaml` file with tokens and endpoints defined, for example:

```yaml
SPLUNK_INGEST_TOKEN: "your_access_token"
SPLUNK_API_TOKEN: "your_access_token"
SPLUNK_INGEST: "https://ingest.{realm}.signalfx.com"
SPLUNK_API: "https://api.{realm}.signalfx.com/v2/integration"
```
to use `create_org.sh` you need to define following variables:

```yaml
MY_FIRST_NAME: "Lukasz"
MY_LAST_NAME: "Swolkien"
MY_EMAIL: "my_email@domain.com"
MY_ORG_NAME: "your-org-name"
MY_COMPANY_NAME: "your-company-name"
```
