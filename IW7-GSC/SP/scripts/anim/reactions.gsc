/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\reactions.gsc
**************************************/

main() {
  if(getdvarint("ai_iw7", 0) == 1) {
    return;
  }
  self endon("killanimscript");
  scripts\anim\utility::_id_9832("reactions");
  _id_BF22();
}

_id_951D() {}

_id_DD51() {
  thread _id_325D();
}

_id_38FD() {
  return !isDefined(self._id_A9D9) || gettime() - self._id_A9D9 > 2000;
}

_id_325E() {}

_id_325D() {
  self endon("killanimscript");

  if(isDefined(self.disablebulletwhizbyreaction)) {
    return;
  }
  for(;;) {
    self waittill("bulletwhizby", var_0);

    if(!isDefined(var_0.team) || self.team == var_0.team) {
      continue;
    }
    if(isDefined(self.covernode) || isDefined(self._id_1E2C)) {
      continue;
    }
    if(self.a.pose != "stand") {
      continue;
    }
    if(!_id_38FD()) {
      continue;
    }
    self._id_13D13 = var_0;
    self animcustom(::_id_325E);
  }
}

_id_41C3() {
  self endon("killanimscript");
  wait 0.3;
  self _meth_8306();
}

_id_7FE1() {}

_id_10F51() {}

#using_animtree("generic_human");

_id_BF20() {
  self endon("death");
  self endon("endNewEnemyReactionAnim");
  self._id_A9D9 = gettime();
  self.a.movement = "stop";

  if(isDefined(self._stealth) && self.alertlevel != "combat")
    _id_10F51();
  else {
    var_0 = _id_7FE1();
    self clearanim(%root, 0.2);
    self _meth_82E7("reactanim", var_0, 1, 0.2, 1);
    scripts\anim\shared::donotetracks("reactanim");
  }

  self notify("newEnemyReactionDone");
}

_id_BF22() {
  self endon("death");

  if(isDefined(self._id_560E)) {
    return;
  }
  if(!_id_38FD()) {
    return;
  }
  if(self.a.pose == "prone" || isDefined(self.a.onback)) {
    return;
  }
  self animmode("gravity");

  if(isDefined(self.enemy))
    _id_BF20();
}