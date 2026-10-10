/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_54e6d1e4fb728cb8.gsc
*************************************************/

#using scripts\engine\math;
#namespace namespace_d81cc0392628bc6d;

function function_683c095e6767c4c8(lookatposition, delta, var_70e8a85177297c1) {
  level endon("game_ended");
  self endon("disconnect");

  while(!function_b69898678ed4466d(lookatposition, delta)) {
    waitframe();
  }

  if(isDefined(var_70e8a85177297c1)) {
    self[[var_70e8a85177297c1]]();
  }
}

function function_ed838558ef4e4e91(entity, delta, mindistance) {
  return function_b69898678ed4466d(entity.origin, delta, mindistance);
}

function function_b69898678ed4466d(position, delta, mindistance) {
  if(isDefined(mindistance) && distance2d(self.origin, position) > mindistance) {
    return false;
  }

  forward = anglesToForward(self getplayerangles(0));
  normalized = vectorNormalize(position - self getEye());
  return math::anglebetweenvectorsunit(forward, normalized) <= delta;
}