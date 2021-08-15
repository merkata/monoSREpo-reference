local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p =  inv.parameters;

{
    module: {
      [module]: p.infrastructure.modules[module],
      for module in std.objectFields(p.infrastructure.modules)
    }
}
