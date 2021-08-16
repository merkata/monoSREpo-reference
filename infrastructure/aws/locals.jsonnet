local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;

{
    locals: {
      [field]: p.infrastructure.locals[field],
      for field in std.objectFields(p.infrastructure.locals)
    }
}
