sops --encrypt --output=config/service_a/prod/main.encrypted.yaml config/service_a/prod/main.yaml
sops --encrypt --output=config/service_a/prod/main.encrypted.json config/service_a/prod/main.json
sops --encrypt --output=config/service_a/stg/main.encrypted.yaml config/service_a/stg/main.yaml
sops --encrypt --output=config/service_a/stg/main.encrypted.json config/service_a/stg/main.json