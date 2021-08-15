local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;

local provider = import "provider.jsonnet";
local modules = import "modules.jsonnet";

{
  [m.desc + ".tf"]: m.type,
  for m in [{desc: "provider", type: provider},
{desc: "main", type: modules},]
}
