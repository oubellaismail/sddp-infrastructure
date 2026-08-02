# Production container registry (registry of record).
#
# The prod half of the two-registry model: the staging registry holds unsigned
# build/scan artifacts, while this registry receives ONLY signed digests (via a
# later `cosign copy` promote step) and is the ONLY registry the cluster pulls
# from. Its presence is a structural promotion boundary — an unsigned image is
# not merely unverified but absent from here, so it is unpullable.
#
# One registry per DigitalOcean account: this is *the* registry
# (registry.digitalocean.com/<name>); application images are repositories inside
# it (e.g. .../sddp-backend). The name is globally unique across all customers.
#
# DOKS pull access is enabled out-of-band via the native cluster↔registry
# integration (see README) — DigitalOcean has no Terraform resource for that
# association, and the integration auto-injects pull credentials into every
# namespace, including ones GitOps creates later. Terraform owns the registry;
# the cluster attach is the one imperative step here, analogous to bootstrap.
resource "digitalocean_container_registry" "sddp" {
  name                   = var.registry_name
  subscription_tier_slug = "basic" # ~$5/mo, 5 GB — smallest paid tier (free tier is 1 repo only)
  region                 = var.region
}
