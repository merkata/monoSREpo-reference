local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;

local provider = import "provider.jsonnet";
local locals = import "locals.jsonnet";
local modules = import "modules.jsonnet";
local outputs = import "outputs.jsonnet";

{
  [m.desc + ".tf"]: m.type,
  for m in [{desc: "provider", type: provider},
{desc: "locals", type: locals},
{desc: "main", type: modules},
{desc: "outputs", type: outputs},]
}
