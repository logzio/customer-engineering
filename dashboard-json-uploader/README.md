# Dashboard bulk uploader
This uploader will traverse a folder hierarchy and recreate that folder structure within Logz.io's metrics product.  The intended use case is where customers are exporting dashboards from a local Grafana instance to a filesystem structure and want to preserve that structure in Logz.io whilst still developing locally.  A similar [Migration Tool](https://github.com/logzio/grafana-dashboard-migration-tool) allows upload directly from local Grafana instances using an API Key

## Usage
The script requires a Logz.io [API token](https://docs.logz.io/api/#:~:text=tokens%20from%20the-,Logz.io%20API%20tokens,-page.), and takes the following requires flags as input:

* -a your Logz.io API Token
* -f the folder you wish to upload subfolders anbd dashboards from.  Make sure you add the trailing slash (/)
* -r your two-letter Logz.io [Region Code](https://docs.logz.io/user-guide/accounts/account-region.html)

Example:

```./logzio-dashboard-uploader.sh -f ~/dashboard-test/ -a abc123 -r us```