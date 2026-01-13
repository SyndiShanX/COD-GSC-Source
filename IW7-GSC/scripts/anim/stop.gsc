/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\stop.gsc
*********************************/

func_9518() {}

main() {
  if(isDefined(self.var_BFDC)) {
    return;
  }

  if(isDefined(self.var_4C37)) {
    if(isDefined(self.var_4C37["stop"])) {
      [
        [self.var_4C37["stop"]]
      ]();
      return;
    }
  }

  self notify("stopScript");
  self endon("killanimscript");
  [[self.exception["stop_immediate"]]]();
  thread func_50FE();
  scripts\anim\utility::func_9832("stop");
  if(isDefined(self.var_1095A)) {
    func_1095B();
  }

  scripts\anim\utility::func_DCB7();
  thread func_F77E();
  thread scripts\anim\reactions::func_DD51();
  var_0 = isDefined(self.var_4C8C);
  if(!var_0) {
    if(self.a.weaponpos["right"] == "none" && self.a.weaponpos["left"] == "none") {
      var_0 = 1;
    } else if(angleclamp180(self getspawnpointdist()[0]) > 20) {
      var_0 = 1;
    }
  }

  for(;;) {
    var_1 = func_7E6F();
    if(var_1 == "prone") {
      var_0 = 1;
      func_DA85();
      continue;
    }

    if(self.a.pose != var_1) {
      self clearanim( % root, 0.3);
      var_0 = 0;
    }

    scripts\anim\setposemovement::setposemovement(var_1, "stop");
    if(!var_0) {
      transitiontoidle(var_1, self.a.var_92F9);
      var_0 = 1;
      continue;
    }

    func_D49C(var_1, self.a.var_92F9);
  }
}

func_E732(var_0, var_1) {
  self orientmode("face angle", var_0);
  while(angleclamp(var_0 - self.angles[1]) > var_1) {
    wait(0.1);
  }
}

func_F77E() {
  self endon("death");
  self waittill("killanimscript");
  self.var_AA1F = gettime();
}

func_1095B() {
  self endon("stop_specialidle");
  var_0 = self.var_1095A;
  self animmode("gravity");
  self orientmode("face current");
  self clearanim( % root, 0.2);
  for(;;) {
    self _meth_82EA("special_idle", var_0[randomint(var_0.size)], 1, 0.2, self.animplaybackrate);
    self waittillmatch("end", "special_idle");
  }
}

func_7E6F() {
  var_0 = scripts\anim\utility_common::func_7E28();
  if(isDefined(var_0)) {
    var_1 = var_0.angles[1];
    var_2 = var_0.type;
  } else {
    var_1 = self.var_EC;
    var_2 = "node was undefined";
  }

  var_3 = scripts\anim\utility::func_3EF2();
  if(var_2 == "Cover Stand" || var_2 == "Conceal Stand") {
    var_3 = scripts\anim\utility::func_3EF2("stand");
  } else if(var_2 == "Cover Crouch" || var_2 == "Conceal Crouch") {
    var_3 = scripts\anim\utility::func_3EF2("crouch");
  } else if(var_2 == "Cover Prone" || var_2 == "Conceal Prone") {
    var_3 = scripts\anim\utility::func_3EF2("prone");
  }

  return var_3;
}

transitiontoidle(var_0, var_1) {
  if(scripts\anim\utility::func_9D9B() && self.a.pose == "stand") {
    var_0 = "stand_cqb";
  }

  var_2 = scripts\anim\utility::func_B028("idle_transitions");
  if(isDefined(var_2[var_0])) {
    var_3 = var_2[var_0];
    self _meth_82E4("idle_transition", var_3, % body, 1, 0.2, self.animplaybackrate);
    scripts\anim\shared::donotetracks("idle_transition");
  }
}

func_D49C(var_0, var_1) {
  if(scripts\anim\utility::func_9D9B() && self.a.pose == "stand") {
    var_0 = "stand_cqb";
  }

  var_2 = undefined;
  if(isDefined(self.var_4C8C) && isDefined(self.var_4C8C[var_0])) {
    if(isarray(self.var_4C8C[var_0])) {
      var_3 = scripts\anim\utility::func_1E9D(self.var_4C8C[var_0], self.var_4C8D[var_0]);
    } else {
      var_3 = self.var_4C8C[var_1];
      var_4 = var_0 + "_add";
      if(isDefined(self.var_4C8C[var_4])) {
        var_2 = self.var_4C8C[var_4];
      }
    }
  } else if(isDefined(level.var_DD76) && var_1 == "stand" || var_1 == "stand_cqb" && isDefined(self.var_32D4) && self.var_32D4 == 1) {
    var_3 = scripts\anim\utility::func_1E9D(level.var_DD76["stand"][0], level.var_DD77["stand"][0]);
  } else {
    var_5 = scripts\anim\utility::func_B028("idle");
    var_6 = scripts\anim\utility::func_B028("idle_weights");
    var_1 = var_1 % var_5[var_0].size;
    var_3 = scripts\anim\utility::func_1E9D(var_5[var_0][var_1], var_6[var_0][var_1]);
  }

  var_7 = 0.2;
  if(gettime() == self.a.var_EF87) {
    var_7 = 0.5;
  }

  if(isDefined(var_2)) {
    self _meth_82A5(var_3, % body, 1, var_7, 1);
    self give_attacker_kill_rewards( % add_idle);
    self _meth_82E4("idle", var_2, % add_idle, 1, var_7, self.animplaybackrate);
  } else {
    self _meth_82E4("idle", var_3, % body, 1, var_7, self.animplaybackrate);
  }

  scripts\anim\shared::donotetracks("idle");
}

func_DA85() {
  if(self.a.pose != "prone") {
    return;
  }

  thread func_12EF5();
  if(randomint(10) < 3) {
    var_0 = scripts\anim\utility::func_B027("cover_prone", "twitch");
    var_1 = var_0[randomint(var_0.size)];
    self _meth_82E3("prone_idle", var_1, % exposed_modern, 1, 0.2);
  } else {
    self _meth_82A5(scripts\anim\utility::func_B027("cover_prone", "straight_level"), % exposed_modern, 1, 0.2);
    self give_left_powers("prone_idle", scripts\anim\utility::func_B027("cover_prone", "exposed_idle")[0], 1, 0.2);
  }

  self waittillmatch("end", "prone_idle");
  self notify("kill UpdateProneThread");
}

func_12EF5() {
  self endon("killanimscript");
  self endon("kill UpdateProneThread");
  for(;;) {
    scripts\anim\cover_prone::func_12EF6(0.1);
    wait(0.1);
  }
}

func_50FE() {
  self endon("killanimscript");
  wait(0.05);
  [[self.exception["stop"]]]();
}