export SOPS_AGE_KEY=$(cat age_key_02_stg.txt | tail -n 1)
sops edit config/service_a/stg/main.encrypted.json