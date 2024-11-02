output "id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.kv.id
}

output "name" {
  description = "Name of key vault created."
  value       = azurerm_key_vault.kv.name
}

output "vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.kv.vault_uri
}