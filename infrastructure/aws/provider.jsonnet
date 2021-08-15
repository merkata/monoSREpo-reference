local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;

{
  provider: {
    aws: {
      version: p.aws.version,
      region: p.aws.region,
    },
  },

  terraform: {
    required_version: p.terraform.required_version,
    backend: p.terraform.backend
  },

  assert
  std.objectHas(self, "provider") :
    "Provider is required. None defined",

  assert
  std.objectHas(self.provider.aws, "version") :
    "Provider version is required",
}
