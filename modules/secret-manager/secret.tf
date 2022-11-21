resource "kubernetes_secret" "azure-secret-sp" {
  metadata {
    name = "MK-Azure-Secret-sp"
  }

  data = {
    ClientID     = "40ebfbe9-bc62-432e-9f04-c9fb87673dd8"
    ClientSecret = "RG88Q~m_TQMGXP7RbKH8hBRPiHo0Uh~0VImY6b4L"
  }
}