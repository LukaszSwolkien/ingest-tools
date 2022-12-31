# Ingest-Tools
Sample bash scripts to POST json data over http into Splunk o11y suite. 

* Python sample data generators are available here: https://github.com/LukaszSwolkien/ingest-tools-py
* Golang sample data generators are available here: https://github.com/LukaszSwolkien/ingest-tools-go

## Usage examples:

Create your organisation using Splunk API (see `create_org.sh`) and setup access token(s).
Remember to create `.secrets.yaml` file with secrets, see [here](#Setup-project).

To learn more about sending data to Splunk O11y see: https://dev.splunk.com/observability/reference/api/ingest_data/latest

### Post metric data (SignalFx format):
```bash
./sample_metric_ingest.sh
```

### Post trace data (Zipkin format):
```bash
./sample_trace_ingest.sh
```

### Post log data (HEC format):
```bash
./sample_log_ingest.sh
```

You can run any script periodicaly as a cron job, for example:

```crontab -e```

```vim
*/1 * * * * /home/ec2-user/Devel/ingest-tools/sample_metic_ingest.sh
```

## Setup project 
You need to create `.secrets.yaml` file with tokens and endpoints defined, for example:

```yaml
splunk-ingest-token: "your_access_token"
splunk-api-token: "your_access_token"
splunk-ingest: "https://ingest.{realm}.signalfx.com"
splunk-api: "https://api.{realm}.signalfx.com/v2/integration"
```
to use `create_org.sh` you need to define following variables:

```yaml
my-first-name: "Lukasz"
my-last-name: "Swolkien"
my-email: "my_email@domain.com"
my-org-name: "your_org_name"
my-company-name: "your_company_name"
```
