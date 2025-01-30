## Concept
* All credentials are encrypted in file
* Keeping file structure and only encrypt specific value
    * Not encrypting entire file
* Encrypt without special setting
    * It only requires public key
* SOPS provides MAC([main.encrypted.json#L30](config/service_a/prod/main.encrypted.json?plain=1#L30)) to ensure file was encrypted file was validated as same as it was encrypted
    * It shows errors when encrypted file has changed
      ```shell
      $./decrypt.sh   
      MAC mismatch. File has 337709D511D9B929CD5095F68941851EE3ADC87210A167155560A5A56D1315C7A6791A278CE44CBD6F08102BFC9CE1B48315DC1B0205D2E3016FECB82DA25E81, computed A7AEE4B0EAAEB936933F96D769FCD585023FB436B12694E97B5EFE97EFECAE79F0CEBE8D411FBF129AA65421DC2D705A24B855C60DFFA1C3E4EED07367732182
      ```
    * MAC can be ignored if you do not want to share private key
        * By Adding CLI option `--ignore-mac`
        * It allows *Any user* can change encrypted file without decryption
            * Non-secret data can be edited without distributing private key

## Terminologies
  * [SOPS](https://github.com/getsops/sops)
  * [age](https://github.com/FiloSottile/age)

## CAUTION
  * **SAVE PRIVATE KEY IN ANOTHER PLACE**
    * This repository is sample
    * Following keys should be stored in secret space
      * [age_key_01_prod.txt](age_key_01_prod.txt)
      * [age_key_02_prod.txt](age_key_02_prod.txt)
      * [age_key_01_stg.txt](age_key_01_stg.txt)
      * [age_key_02_stg.txt](age_key_02_stg.txt)
  * Secret space likes
    * [AWS KMS](https://github.com/getsops/sops?tab=readme-ov-file#aws-kms-encryption-context)
    * [Github Secrets](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions)

## Local Test
  * Tooling - MAC user specific
    1. Install sops cli
       ```shell
       $brew install sops

       $sops --version
       sops 3.9.4 (latest)
       ```
    1. Install age cli
       ```shell
       $brew install age
       
       $age --version
       v1.2.1
       ```
  * Encryption
    * [encrypt.sh](encrypt.sh)
  * Decryption
    * [decrypt.sh](decrypt.sh)


## CI/CD
  * Sample: [decrypt.yml](.github/workflows/decrypt.yml)
  * Github Action Module
    * https://github.com/marketplace/actions/setup-sops
      ```yaml
        - name: Setup SOPS
          uses: nhedger/setup-sops@v2
          with:
        
              # The version of SOPS to install.
              # This input is optional and defaults to "latest".
              # Example values: "3.7.3", "latest"
              version: "latest"
        
              # The GitHub token to use to authenticate GitHub API requests.
              # This input is optional and defaults to the job's GitHub token.
              # Example value: ${{ secrets.GITHUB_TOKEN }}
              token: ${{ github.token }}
      ```