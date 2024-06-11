resource "google_storage_bucket" "auto-expire" {
  name = "tf-cicdbuild-bucket"
  location = "US"
  project = "tf-dev-001"
  force_destroy = true
  public_access_prevention = "enforced"
}