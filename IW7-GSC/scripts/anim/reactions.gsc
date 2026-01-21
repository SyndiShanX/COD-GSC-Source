/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\reactions.gsc
*********************************************/

main() {
  if(getdvarint("ai_iw7", 0) == 1) {
    return;
  }

  self endon("killanimscript");
  scripts\anim\utility::func_9832("reactions");
  func_BF22();
}

func_951D() {}

func_DD51() {
  thread func_325D();
}

func_38FD() {
  return !isDefined(self.var_A9D9) || gettime() - self.var_A9D9 > 2000;
}

func_325E() {}

func_325D() {
  self endon("killanimscript");
  if(isDefined(self.disablebulletwhizbyreaction)) {
    return;
  }

  for(;;) {
    self waittill("bulletwhizby", var_0);
    if(!isDefined(var_0.team) || self.team == var_0.team) {
      continue;
    }

    if(isDefined(self.covernode) || isDefined(self.var_1E2C)) {
      continue;
    }

    if(self.a.pose != "stand") {
      continue;
    }

    if(!func_38FD()) {
      continue;
    }

    self.var_13D13 = var_0;
    self animcustom(::func_325E);
  }
}

func_41C3() {
  self endon("killanimscript");
  wait(0.3);
  self func_8306();
}

func_7FE1() {}

func_10F51() {}

func_BF20() {
  self endon("death");
  self endon("endNewEnemyReactionAnim");
  self.var_A9D9 = gettime();
  self.a.movement = "stop";
  if(isDefined(self._stealth) && self.opcode::OP_inequality != "combat") {
    func_10F51();
  } else {
    var_0 = func_7FE1();
    self clearanim(%root, 0.2);
    self func_82E7("reactanim", var_0, 1, 0.2, 1);
    scripts\anim\shared::donotetracks("reactanim");
  }

  self notify("newEnemyReactionDone");
}

func_BF22() {
  self endon("death");
  if(isDefined(self.var_560E)) {
    return;
  }

  if(!func_38FD()) {
    return;
  }

  if(self.a.pose == "prone" || isDefined(self.a.onback)) {
    return;
  }

  self animmode("gravity");
  if(isDefined(self.enemy)) {
    func_BF20();
  }
}