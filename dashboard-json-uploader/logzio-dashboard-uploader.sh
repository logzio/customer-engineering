while getopts f:a:r: flag
do
    case "${flag}" in
        a) api_token=${OPTARG};;
        f) dashboard_dir=${OPTARG};;
        r) region=${OPTARG};;
    esac
done

api_url="https://api.logz.io/v1"

if [[ $region != "us" ]]
then
  api_url="https://api-$region.logz.io/v1"
fi

for d in $dashboard_dir*/ ; do

    folder_name=$(basename $d)

    echo "Attempting to create $folder_name"

    curl -X POST "$api_url/grafana/api/folders" \
        -H 'Content-Type: application/json' \
        -H "X-API-TOKEN: $api_token" \
        -d '{
                "uid": "'"$folder_name"'",
                "title": "'"$folder_name"'"
        }'
    folder_id=$(curl -X GET "$api_url/grafana/api/search?query=$folder_name&type=dash-folder" \
            -H 'Content-Type: application/json' \
            -H "X-API-TOKEN: $api_token" | sed -r 's/.*"id":([0-9]+).*/\1/')

    for f in $d*.json ; do
        if [[ ! -e $f ]]; then continue; fi

        echo "Uploading $f"
       
        curl -X POST "$api_url/grafana/api/dashboards/db" \
            -H 'Content-Type: application/json' \
             -H "X-API-TOKEN: $api_token" \
            -d "{
                \"dashboard\": $(cat $f),
                \"folderid\": $folder_id,
                \"overwrite\": false }"
    done
done
