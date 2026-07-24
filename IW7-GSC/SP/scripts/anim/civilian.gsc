/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\civilian.gsc
**************************************/

#using_animtree("generic_human");

cover() {
  self endon("killanimscript");
  self clearanim(%root, 0.2);
  scripts\anim\utility::_id_12EB9();

  if(scripts\anim\utility::_id_9E40()) {
    var_0 = "idle_combat";
  } else {
    var_0 = "idle_noncombat";
  }

  var_1 = undefined;

  if(isDefined(self._id_1FBB) && isDefined(level._id_EC85[self._id_1FBB])) {
    var_1 = level._id_EC85[self._id_1FBB][var_0];
  }

  if(!isDefined(var_1)) {
    if(!isDefined(level._id_EC85["default_civilian"])) {
      return;
    }
    var_1 = level._id_EC85["default_civilian"][var_0];
  }

  thread _id_BC1C();

  for(;;) {
    self _meth_82E3("idle", scripts\engine\utility::random(var_1), %root, 1, 0.2, 1);
    self waittillmatch("idle", "end");
  }
}

_id_BC1C() {
  self endon("killanimscript");

  while(!isDefined(self._id_3C34)) {
    wait 1;
  }
}

_id_02C8() {
  cover();
}

_id_79BE() {
  return anim._id_3FD8[randomint(anim._id_3FD8.size)];
}