export SOPS_AGE_KEY=$(cat age_key_01_prod.txt | tail -n 1)
sops --decrypt --output=config/service_a/prod/main.yaml config/service_a/prod/main.encrypted.yaml
sops --decrypt --output=config/service_a/prod/main.json config/service_a/prod/main.encrypted.json

export SOPS_AGE_KEY=$(cat age_key_02_stg.txt | tail -n 1)
sops --decrypt --output=config/service_a/stg/main.yaml config/service_a/stg/main.encrypted.yaml
sops --decrypt --output=config/service_a/stg/main.json config/service_a/stg/main.encrypted.json