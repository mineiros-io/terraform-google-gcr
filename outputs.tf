# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "gcr" {
  description = "All outputs of the created GCR resource."
  value       = try(google_container_registry.registry, {})
}

output "pull_iam_members" {
  description = "A map of outputs, keyed by the member id, of all iam_members allowed to pull images to GCR."
  value       = try(google_storage_bucket_iam_member.pull, {})
}

output "push_iam_members" {
  description = "A map of outputs, keyed by the member id, of all iam_members allowed to push images to GCR."
  value       = try(google_storage_bucket_iam_member.push, {})
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

output "module_inputs" {
  description = "A map of all module arguments. Omitted optional arguments will be represented with their actual defaults."
  value = {
    location     = var.location
    pull_members = var.pull_members
    push_members = var.push_members
  }
}

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------

output "project" {
  description = "The ID of the project in which the resources belong."
  value       = var.project
}

output "module_enabled" {
  description = "Whether the module is enabled"
  value       = var.module_enabled
}
