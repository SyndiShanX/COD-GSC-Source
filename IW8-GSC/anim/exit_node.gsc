/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\exit_node.gsc
***********************************************/

getexitnode() {
  var_0 = undefined;
  var_1 = 400;

  if(scripts\engine\utility::actor_is3d())
    var_1 = 1024;
  else if(isDefined(self.heat))
    var_1 = 4096;

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1)
    var_0 = self.node;
  else if(isDefined(self.prevnode) && distancesquared(self.origin, self.prevnode.origin) < var_1)
    var_0 = self.prevnode;

  if(isDefined(self.heat) && !scripts\engine\utility::actor_is3d()) {
    if(isDefined(var_0) && scripts\engine\utility::absangleclamp180(self.angles[1] - var_0.angles[1]) > 30)
      return undefined;
  }

  return var_0;
}