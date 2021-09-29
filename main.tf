resource "google_container_registry" "registry" {
  count = var.module_enabled ? 1 : 0

  project  = var.project
  location = var.location

  depends_on = [var.module_depends_on]
}

resource "google_storage_bucket_iam_member" "pull" {
  for_each = var.module_enabled ? toset(var.pull_members) : toset([])

  bucket = google_container_registry.registry[0].id
  role   = "roles/storage.objectViewer"
  member = each.value

  depends_on = [var.module_depends_on]
}

resource "google_storage_bucket_iam_member" "push" {
  for_each = var.module_enabled ? toset(var.push_members) : toset([])

  bucket = google_container_registry.registry[0].id
  role   = "roles/storage.objectAdmin"
  member = each.value

  depends_on = [var.module_depends_on]
}

// WHY: Because GCP sucks, without being able to list buckets we always get:
//
// Caller does not have permission 'storage.buckets.get'.
// To configure permissions, follow instructions at:
// https://cloud.google.com/container-registry/docs/access-control
//
// Google instructions are NOT correct, following the docs DOESNT work.
// Even for pushing on a registry that already has images on it
// you need the storage.buckets.get permission.
resource "google_storage_bucket_iam_member" "push_buckets_get" {
  for_each = var.module_enabled ? toset(var.push_members) : toset([])

  bucket = google_container_registry.registry[0].id
  role   = "roles/storage.legacyBucketReader"
  member = each.value

  depends_on = [var.module_depends_on]
}
