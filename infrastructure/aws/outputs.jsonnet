local kap = import "lib/kapitan.libjsonnet";
local inv = kap.inventory();
local p = inv.parameters;

{
    output: {
        [name]: p.infrastructure.outputs[name],
        for name in std.objectFields(p.infrastructure.outputs)
    }
}
