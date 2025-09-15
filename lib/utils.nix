# Small helpers reusable across the tree.
{ lib }:
{
# Pick a list of module paths by names from a registry attrset.
pick = names: registry: map (n: lib.getAttr n registry) names;
}