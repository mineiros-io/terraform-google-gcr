# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "project" {
  description = "(Required) The ID of the project in which the resources belong."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "location" {
  description = "(Optional) The location for the GCR. For a list of all supported locations, please see https://cloud.google.com/container-registry/docs/pushing-and-pulling#pushing_an_image_to_a_registry"
  type        = string
  default     = null
}

variable "pull_members" {
  type        = set(string)
  description = "(Optional) A set of identities that will be able to pull images from GCR."
  default     = []
}

variable "push_members" {
  type        = set(string)
  description = "(Optional) A set of identities that will be able to pull&push images from GCR."
  default     = []
}

# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# See https://medium.com/mineiros/the-ultimate-guide-on-how-to-write-terraform-modules-part-1-81f86d31f024
# ------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether resource in the module should be created."
  default     = true
}

variable "module_depends_on" {
  type        = list(any)
  description = "(Optional) A list of external resources the module depends_on. Default is '[]'."
  default     = []
}
