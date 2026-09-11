/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\exit_node.gsc
***********************************************/

function getexitnode() {
  var0 = undefined;
  var1 = 400;

  if(scripts\engine\utility::actor_is3d()) {
    var1 = 1024;
  } else if(isDefined(self.heat)) {
    var1 = 4096;
  }

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var1) {
    var0 = self.node;
  } else if(isDefined(self.prevnode) && distancesquared(self.origin, self.prevnode.origin) < var1) {
    var0 = self.prevnode;
  }

  if(isDefined(self.heat) && !scripts\engine\utility::actor_is3d()) {
    if(isDefined(var0) && scripts\engine\utility::absangleclamp180(self.angles[1] - var0.angles[1]) > 30) {
      return undefined;
    }
  }

  return var0;
}