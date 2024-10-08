# terraform-google-gke


Making a Kubernetes cluster with some basic hardening configuration included.

> [!CAUTION]
> this is some pretty old code and its poorly written, a rewrite is planned with better standardisation
> 
> edit: ohh wow i didnt realise `enable_binary_authorization` was deprecated also, so now its badly written and out of date :teehee:


### Binary Authorization
Prevents non approved or signed images used within your project or specific kubernetes clusters.
On a basic level you can whitelist registries or digests that you are happy to use within your environment.
Though for regular release images you are not going to want to update the policy that frequently.

That's where you would create a key in Google KMS and sign images (this is called creating an `attestation`) with it at the end of a ci pipeline.
You attach this same key to an `attestor` who checks that the `attestation` is authentic before allowing a deployment into the cluster.

You can sign an image at the end of a deployment pipeline using the gcloud cli full instructions can be found [here](https://cloud.google.com/binary-authorization/docs/making-attestations#gcloud)
with the command looking like this, It's pretty self-explanatory.

```
gcloud beta container binauthz attestations sign-and-create \
--project="${ATTESTATION_PROJECT_ID}" \
--artifact-url="${IMAGE_TO_ATTEST}" \
--attestor="${ATTESTOR_NAME}" \
--attestor-project="${ATTESTOR_PROJECT_ID}" \
--keyversion-project="${KMS_KEY_PROJECT_ID}" \
--keyversion-location="${KMS_KEY_LOCATION}" \
--keyversion-keyring="${KMS_KEYRING_NAME}" \
--keyversion-key="${KMS_KEY_NAME}" \
--keyversion="${KMS_KEY_VERSION}"
```
