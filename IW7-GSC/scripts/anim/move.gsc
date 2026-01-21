/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\move.gsc
*********************************************/

func_951A() {}

main() {
  if(getdvarint("ai_iw7", 0) == 1) {
    func_89C7();
    return;
  }

  if(isDefined(self.var_4C37)) {
    if(isDefined(self.var_4C37["move"])) {
      [[self.var_4C37["move"]]]();
      return;
    }
  }

  self endon("killanimscript");
  [[self.exception["move"]]]();
  func_BCBE();
  makeportableradar();
  scripts\anim\utility::func_9832("move");
  var_0 = func_1391A();
  if(var_0 && isDefined(self.var_1016F)) {
    func_BCAD();
    func_BCB0();
  } else if(isDefined(self.var_28CF) && self.var_28CF) {
    func_BCF9(var_0);
    scripts\anim\battlechatter::func_CEE8();
  }

  thread func_12F27();
  var_1 = ::func_C968;
  if(isDefined(self.var_C967)) {
    var_1 = self.var_C967;
  }

  self thread[[var_1]]();
  thread func_1FAE();
  scripts\anim\exit_node::func_10DCA();
  self.var_58DC = undefined;
  self.var_932E = undefined;
  thread func_10DFD();
  func_AD66();
  self.var_FE92 = undefined;
  self.var_1A32 = undefined;
  self.var_E873 = undefined;
  func_BCC4(1);
}

end_script() {
  if(getdvarint("ai_iw7", 0) == 1) {
    return;
  }

  if(isDefined(self.var_C3F2)) {
    self.grenadeweapon = self.var_C3F2;
    self.var_C3F2 = undefined;
  }

  self.var_115CE = undefined;
  self.var_B7B5 = undefined;
  self.var_932E = undefined;
  self.var_1016F = undefined;
  self.shufflenode = undefined;
  self.var_E873 = undefined;
  self.var_DD39 = undefined;
  self.var_E1B0 = undefined;
  self.var_4BE6 = undefined;
  self.var_BCC3 = undefined;
  scripts\anim\run::func_F843(0);
  self clearanim(%head, 0.2);
  self.facialidx = undefined;
}

func_89C7() {
  scripts\asm\asm_bb::bb_requestmove();
  self waittill("killanimscript");
  scripts\asm\asm_bb::bb_clearmoverequest();
}

func_BCBE() {
  self.var_DD39 = undefined;
  self.var_E1B0 = undefined;
  self.var_12DEF = undefined;
  self.var_12DF0 = undefined;
  self.var_E879 = 0;
  self.var_22F0 = undefined;
}

makeportableradar() {
  if(self.a.pose == "prone") {
    var_0 = scripts\anim\utility::func_3EF2("stand");
    if(var_0 != "prone") {
      self orientmode("face current");
      self animmode("zonly_physics", 0);
      var_1 = 1;
      if(isDefined(self.objective_position)) {
        var_1 = 2;
      }

      scripts\anim\cover_prone::func_DA87(var_0, var_1);
      self animmode("none", 0);
      self orientmode("face default");
    }
  }
}

func_1391A() {
  switch (self.weaponstartammo) {
    case "turret":
    case "cover_wide_right":
    case "cover_wide_left":
    case "concealment_stand":
    case "concealment_prone":
    case "concealment_crouch":
    case "cover_prone":
    case "cover_stand":
    case "cover_left":
    case "cover_right":
    case "cover_crouch":
    case "hide":
      return 1;
  }

  return 0;
}

func_BCF9(var_0) {
  if(self.synctransients == "run") {
    scripts\anim\battlechatter_ai::func_67D2(var_0);
  }
}

func_BCC4(var_0) {
  func_BCC5(var_0);
  self notify("abort_reload");
}

func_2125() {
  if(isDefined(self.var_1F62) && self.var_1F62 != self.var_D8B6) {
    return 1;
  } else if(!isDefined(self.var_1F62) && self.var_D8B6 != "none") {
    return 1;
  }

  return 0;
}

func_12ED4(var_0) {
  if(var_0 != self.var_D8B7 || func_2125()) {
    if(isDefined(self.custommoveanimset) && isDefined(self.custommoveanimset[var_0])) {
      self.a.var_BCA5 = self.custommoveanimset[var_0];
    } else {
      self.a.var_BCA5 = scripts\anim\utility::func_B028(var_0);
      if((self.var_BC == "ambush" || self.var_BC == "ambush_nodes_only") && isDefined(self.vehicle_getspawnerarray) && distancesquared(self.origin, self.vehicle_getspawnerarray) > squared(100)) {
        self.var_101BB = 1;
        scripts\anim\animset::func_F2AC();
      } else {
        self.var_101BB = 1.35;
      }
    }

    self.var_D8B7 = var_0;
    if(isDefined(self.var_1F62)) {
      self.var_D8B6 = self.var_1F62;
    }
  }
}

func_BCC5(var_0) {
  self endon("killanimscript");
  self endon("move_interrupt");
  var_1 = self getscoreinfocategory(%walk_and_run_loops);
  self.a.var_E860 = randomint(10000);
  self.var_D8B7 = "none";
  self.var_D8B6 = "none";
  self.var_BCC2 = undefined;
  for(;;) {
    var_2 = self getscoreinfocategory(%walk_and_run_loops);
    if(var_2 < var_1) {
      self.a.var_E860++;
    }

    var_1 = var_2;
    func_12ED4(self.synctransients);
    if(isDefined(self.var_BCC7)) {
      self[[self.var_BCC7]](self.synctransients);
    } else {
      func_BCC6(self.synctransients);
    }

    if(isDefined(self.var_BCC2)) {
      self[[self.var_BCC2]]();
      self.var_BCC2 = undefined;
    }

    self notify("abort_reload");
  }
}

func_BCC6(var_0) {
  self endon("move_loop_restart");
  if(isDefined(self.var_BCC3)) {
    self[[self.var_BCC3]]();
  } else if(scripts\anim\utility::func_FFDB()) {
    scripts\anim\cqb::func_BCB1();
  } else if(var_0 == "run") {
    scripts\anim\run::func_BCEB();
  } else {
    scripts\anim\walk::func_BD2B();
  }

  self.var_E1B0 = undefined;
}

func_B4EC() {
  if(self.weapon == "none") {
    return 0;
  }

  var_0 = weaponclass(self.weapon);
  if(!scripts\anim\utility_common::usingriflelikeweapon()) {
    return 0;
  }

  if(scripts\anim\utility_common::isasniper()) {
    if(!scripts\anim\utility::func_9D9B() && self.livestreamingenable) {
      return 0;
    }
  }

  if(isDefined(self.var_596C)) {
    return 0;
  }

  return 1;
}

func_FEEB() {
  self endon("killanimscript");
  self notify("doing_shootWhileMoving");
  self endon("doing_shootWhileMoving");
  var_0 = scripts\anim\utility::func_B028("shoot_while_moving");
  foreach(var_3, var_2 in var_0) {
    self.a.var_2274[var_3] = var_2;
  }

  if(isDefined(self.var_440C) && isDefined(self.var_440C["fire"])) {
    self.a.var_2274["fire"] = self.var_440C["fire"];
  }

  if(isDefined(self.weapon) && scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    self.a.var_2274["single"] = ::scripts\anim\utility::func_B027("shotgun_stand", "single");
  }

  for(;;) {
    if(!self.bulletsinclip) {
      if(scripts\anim\utility::func_9D9C()) {
        self.ammocheattime = 0;
        scripts\anim\utility_common::cheatammoifnecessary();
      }

      if(!self.bulletsinclip) {
        wait(0.5);
        continue;
      }
    }

    scripts\anim\combat_utility::func_FEDF();
    self clearanim(%exposed_aiming, 0.2);
  }
}

func_10DFD() {
  self endon("killanimscript");
  wait(0.05);
  thread func_325C();
  thread func_B5DF();
  thread scripts\anim\door::func_940A();
  thread scripts\anim\door::func_5A09();
}

func_12F27() {
  self endon("killanimscript");
  self.var_D8C1 = self.getcsplinepointtargetname;
  for(;;) {
    wait(0.05);
    if(self.var_D8C1 != self.getcsplinepointtargetname) {
      if(!isDefined(self.var_932E) || self.getcsplinepointtargetname != "none") {
        self notify("move_loop_restart");
      }
    }

    self.var_D8C1 = self.getcsplinepointtargetname;
  }
}

func_E2B4(var_0) {
  self endon("killanimscript");
  if(!var_0) {
    scripts\anim\exit_node::func_10DCA();
  }

  self.var_932E = undefined;
  self clearanim(%root, 0.1);
  self orientmode("face default");
  self animmode("none", 0);
  self.print3d = 1;
  func_BCC4(!var_0);
}

func_C968() {
  self endon("killanimscript");
  self endon("move_interrupt");
  self.var_932E = 1;
  for(;;) {
    self waittill("path_changed", var_0, var_1);
    if(isDefined(self.var_932E) || isDefined(self.noturnanims)) {
      continue;
    }

    if(!isDefined(self.var_36F) || !self.var_36F) {
      if(!self.livestreamingenable || abs(self getspawnpoint_searchandrescue()) > 15) {
        continue;
      }
    }

    if(self.a.pose != "stand") {
      continue;
    }

    self notify("stop_move_anim_update");
    self.var_12DEF = undefined;
    var_2 = vectortoangles(var_1);
    var_3 = angleclamp180(self.angles[1] - var_2[1]);
    var_4 = angleclamp180(self.angles[0] - var_2[0]);
    var_5 = func_C966(var_3, var_4);
    if(isDefined(var_5)) {
      self.var_1299D = var_5;
      self.var_129B0 = gettime();
      self.var_BCC3 = ::func_C965;
      self notify("move_loop_restart");
      scripts\anim\run::func_6318();
    }
  }
}

func_C966(var_0, var_1) {
  if(isDefined(self.var_C976)) {
    return [[self.var_C976]](var_0, var_1);
  }

  var_2 = undefined;
  var_3 = undefined;
  if(self.synctransients == "walk") {
    var_4 = scripts\anim\utility::func_B028("cqb_turn");
  } else if(scripts\anim\utility::func_FFDB()) {
    var_4 = scripts\anim\utility::func_B028("cqb_run_turn");
  } else {
    var_4 = scripts\anim\utility::func_B028("run_turn");
  }

  if(var_0 < 0) {
    if(var_0 > -45) {
      var_5 = 3;
    } else {
      var_5 = int(ceil(var_1 + 180 - 10 / 45));
    }
  } else if(var_1 < 45) {
    var_5 = 5;
  } else {
    var_5 = int(floor(var_1 + 180 + 10 / 45));
  }

  var_2 = var_4[var_5];
  if(isDefined(var_2)) {
    if(isarray(var_2)) {
      while(var_2.size > 0) {
        var_6 = randomint(var_2.size);
        if(func_C963(var_2[var_6])) {
          return var_2[var_6];
        }

        var_2[var_6] = var_2[var_2.size - 1];
        var_2[var_2.size - 1] = undefined;
      }
    } else if(func_C963(var_2)) {
      return var_2;
    }
  }

  var_7 = -1;
  if(var_0 < -60) {
    var_7 = int(ceil(var_0 + 180 / 45));
    if(var_7 == var_5) {
      var_7 = var_5 - 1;
    }
  } else if(var_0 > 60) {
    var_7 = int(floor(var_0 + 180 / 45));
    if(var_7 == var_5) {
      var_7 = var_5 + 1;
    }
  }

  if(var_7 >= 0 && var_7 < 9) {
    var_3 = var_4[var_7];
  }

  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      var_3 = var_3[0];
    }

    if(func_C963(var_3)) {
      return var_3;
    }
  }

  return undefined;
}

func_C963(var_0) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_1 = getnotetracktimes(var_0, "code_move");
  var_2 = var_1[0];
  var_3 = getmovedelta(var_0, 0, var_2);
  var_4 = self gettweakablevalue(var_3);
  if(isDefined(self.var_22F0) && squared(self.var_22F0) > distancesquared(self.vehicle_getspawnerarray, var_4)) {
    return 0;
  }

  var_3 = getmovedelta(var_0, 0, 1);
  var_5 = self gettweakablevalue(var_3);
  var_5 = var_4 + vectornormalize(var_5 - var_4) * 20;
  var_6 = !scripts\engine\utility::actor_is3d();
  return self maymovefrompointtopoint(var_4, var_5, var_6, 1);
}

func_C965() {
  self endon("killanimscript");
  self.var_BCC3 = undefined;
  var_0 = self.var_1299D;
  if(gettime() > self.var_129B0 + 50) {
    return;
  }

  if(scripts\engine\utility::actor_is3d()) {
    self animmode("nogravity", 0);
  } else {
    self animmode("zonly_physics", 0);
  }

  var_1 = 0.1;
  if(isDefined(self.var_C975)) {
    var_1 = self.var_C975;
  }

  self clearanim(%body, var_1);
  self.var_BCC2 = ::func_C964;
  self.var_932E = 1;
  var_1 = 0.05;
  if(isDefined(self.var_C975)) {
    var_1 = self.var_C975;
  }

  self func_82EA("turnAnim", var_0, 1, var_1, self.moveplaybackrate);
  if(scripts\engine\utility::actor_is3d()) {
    self orientmode("face angle 3d", self.angles);
  } else {
    self orientmode("face angle", self.angles[1]);
  }

  scripts\anim\shared::donotetracks("turnAnim");
  self.var_932E = undefined;
  self orientmode("face motion");
  self animmode("none", 0);
  scripts\anim\shared::donotetracks("turnAnim");
}

func_C964() {
  self.var_932E = undefined;
  self orientmode("face default");
  self clearanim(%root, 0.1);
  self animmode("none", 0);
}

func_580E() {
  self func_8250(1);
  self animmode("zonly_physics", 0);
  self clearanim(%body, 0.2);
  self func_82EA("dodgeAnim", self.var_4BE6, 1, 0.2, 1);
  scripts\anim\shared::donotetracks("dodgeAnim");
  self animmode("none", 0);
  self orientmode("face default");
  if(animhasnotetrack(self.var_4BE6, "code_move")) {
    scripts\anim\shared::donotetracks("dodgeAnim");
  }

  self clearanim(%civilian_dodge, 0.2);
  self func_8250(0);
  self.var_4BE6 = undefined;
  self.var_BCC3 = undefined;
  return 1;
}

func_12898(var_0, var_1) {
  var_2 = (self.setocclusionpreset[1], -1 * self.setocclusionpreset[0], 0);
  var_3 = self.setocclusionpreset * var_1[0];
  var_4 = var_2 * var_1[1];
  var_5 = self.origin + var_3 - var_4;
  self func_8250(1);
  if(self maymovetopoint(var_5)) {
    self.var_4BE6 = var_0;
    self.var_BCC3 = ::func_580E;
    self notify("move_loop_restart");
    return 1;
  }

  self func_8250(0);
  return 0;
}

func_1FAE() {
  if(!isDefined(self.var_580B) || !isDefined(self.var_580F)) {
    return;
  }

  self endon("killanimscript");
  self endon("move_interrupt");
  for(;;) {
    self waittill("path_need_dodge", var_0, var_1);
    scripts\anim\utility::func_12EB9();
    if(scripts\anim\utility::func_9E40()) {
      self.target_set = 0;
      return;
    }

    if(!issentient(var_0)) {
      continue;
    }

    var_2 = vectornormalize(var_1 - self.origin);
    if(self.setocclusionpreset[0] * var_2[1] - var_2[0] * self.setocclusionpreset[1] > 0) {
      if(!func_12898(self.var_580F, self.var_5810)) {
        func_12898(self.var_580B, self.var_580C);
      }
    } else if(!func_12898(self.var_580B, self.var_580C)) {
      func_12898(self.var_580F, self.var_5810);
    }

    if(isDefined(self.var_4BE6)) {
      wait(getanimlength(self.var_4BE6));
      continue;
    }

    wait(0.1);
  }
}

func_F6CD(var_0, var_1) {
  self.target_set = 1;
  self.var_580B = var_0;
  self.var_580F = var_1;
  var_2 = 1;
  if(animhasnotetrack(var_0, "code_move")) {
    var_2 = getnotetracktimes(var_0, "code_move")[0];
  }

  self.var_580C = getmovedelta(var_0, 0, var_2);
  var_2 = 1;
  if(animhasnotetrack(var_1, "code_move")) {
    var_2 = getnotetracktimes(var_1, "code_move")[0];
  }

  self.var_5810 = getmovedelta(var_1, 0, var_2);
  self.queuedialog = 80;
}

func_41A8() {
  self.target_set = 0;
  self.var_580B = undefined;
  self.var_580F = undefined;
  self.var_580C = undefined;
  self.var_5810 = undefined;
}

func_B5DF() {}

func_325C() {
  self endon("killanimscript");
  if(isDefined(self.disablebulletwhizbyreaction)) {
    return;
  }

  for(;;) {
    self waittill("bulletwhizby", var_0);
    if(self.synctransients != "run" || !self.livestreamingenable || self.a.pose != "stand" || isDefined(self.var_DD39)) {
      continue;
    }

    if(self.getcsplinepointtargetname != "none") {
      continue;
    }

    if(!isDefined(self.enemy) && !self.precacheleaderboards && isDefined(var_0.team) && isenemyteam(self.team, var_0.team)) {
      self.var_13D13 = var_0;
      self animcustom(scripts\anim\reactions::func_325E);
      continue;
    }

    if(self.setomnvarforallclients || self.setomnvar < 100) {
      continue;
    }

    if(isDefined(self.vehicle_getspawnerarray) && distancesquared(self.origin, self.vehicle_getspawnerarray) < 10000) {
      wait(0.2);
      continue;
    }

    self.var_E1B0 = gettime();
    self notify("move_loop_restart");
    scripts\anim\run::func_6318();
  }
}

func_7C69(var_0, var_1) {
  var_2 = var_1.type;
  if(var_2 == "Cover Left") {
    return scripts\anim\utility::func_B027("shuffle", "shuffle_start_from_cover_left");
  }

  if(var_2 == "Cover Right") {
    return scripts\anim\utility::func_B027("shuffle", "shuffle_start_from_cover_right");
  }

  if(var_0) {
    return scripts\anim\utility::func_B027("shuffle", "shuffle_start_left");
  }

  return scripts\anim\utility::func_B027("shuffle", "shuffle_start_right");
}

func_FA42(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = var_2.type;
  if(var_4 == "Cover Left") {
    var_3["shuffle_start"] = func_7C69(var_0, var_1);
    var_3["shuffle"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_to_cover_left");
    var_3["shuffle_end"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_end_to_cover_left");
  } else if(var_4 == "Cover Right") {
    var_3["shuffle_start"] = func_7C69(var_0, var_1);
    var_3["shuffle"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_to_cover_right");
    var_3["shuffle_end"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_end_to_cover_right");
  } else if(var_4 == "Cover Stand" && var_1.type == var_4) {
    if(var_0) {
      var_3["shuffle_start"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_start_left_stand_to_stand");
      var_3["shuffle"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_left_stand_to_stand");
      var_3["shuffle_end"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_end_left_stand_to_stand");
    } else {
      var_3["shuffle_start"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_start_right_stand_to_stand");
      var_3["shuffle"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_right_stand_to_stand");
      var_3["shuffle_end"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_end_right_stand_to_stand");
    }
  } else if(var_0) {
    var_3["shuffle_start"] = func_7C69(var_0, var_1);
    var_3["shuffle"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_to_left_crouch");
    if(var_4 == "Cover Stand") {
      var_3["shuffle_end"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_end_to_left_stand");
    } else {
      var_3["shuffle_end"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_end_to_left_crouch");
    }
  } else {
    var_3["shuffle_start"] = func_7C69(var_0, var_1);
    var_3["shuffle"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_to_right_crouch");
    if(var_4 == "Cover Stand") {
      var_3["shuffle_end"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_end_to_right_stand");
    } else {
      var_3["shuffle_end"] = ::scripts\anim\utility::func_B027("shuffle", "shuffle_end_to_right_crouch");
    }
  }

  self.a.var_2274 = var_3;
}

func_BCAF(var_0, var_1) {
  if(self.a.pose == "stand" && var_1.type != "Cover Stand" || var_0.type != "Cover Stand") {
    self.a.pose = "crouch";
    return 0;
  }

  return 1;
}

func_BCAE(var_0) {
  if(self.a.pose == "crouch" && var_0.type == "Cover Stand") {
    self.a.pose = "stand";
    return 0;
  }

  return 1;
}

func_BCAD() {
  self endon("killanimscript");
  self endon("goal_changed");
  var_0 = self.shufflenode;
  self.var_1016F = undefined;
  self.shufflenode = undefined;
  self.var_10170 = 1;
  if(!isDefined(self.weaponmaxdist)) {
    return;
  }

  if(!isDefined(self.node) || !isDefined(var_0) || self.node != var_0) {
    return;
  }

  var_1 = self.weaponmaxdist;
  var_2 = self.node;
  var_3 = var_2.origin - self.origin;
  if(lengthsquared(var_3) < 1) {
    return;
  }

  var_3 = vectornormalize(var_3);
  var_4 = anglesToForward(var_2.angles);
  var_5 = var_4[0] * var_3[1] - var_4[1] * var_3[0] > 0;
  if(func_BCB5(var_5, var_1, var_2)) {
    return;
  }

  if(func_BCAF(var_1, var_2)) {
    var_6 = 0.1;
  } else {
    var_6 = 0.4;
  }

  func_FA42(var_5, var_1, var_2);
  self animmode("zonly_physics", 0);
  self clearanim(%body, var_6);
  var_7 = scripts\anim\utility::func_1F64("shuffle_start");
  var_8 = scripts\anim\utility::func_1F64("shuffle");
  var_9 = scripts\anim\utility::func_1F64("shuffle_end");
  if(animhasnotetrack(var_7, "finish")) {
    var_10 = getnotetracktimes(var_7, "finish")[0];
  } else {
    var_10 = 1;
  }

  var_11 = length(getmovedelta(var_7, 0, var_10));
  var_12 = length(getmovedelta(var_8, 0, 1));
  var_13 = length(getmovedelta(var_9, 0, 1));
  var_14 = distance(self.origin, var_2.origin);
  if(var_14 > var_11) {
    self orientmode("face angle", scripts\asm\shared_utility::getnodeforwardyaw(var_1));
    self func_82EA("shuffle_start", var_7, 1, var_6);
    scripts\anim\shared::donotetracks("shuffle_start");
    self clearanim(var_7, 0.2);
    var_14 = var_14 - var_11;
    var_6 = 0.2;
  } else {
    self orientmode("face angle", var_2.angles[1]);
  }

  var_15 = 0;
  if(var_14 > var_13) {
    var_15 = 1;
    var_14 = var_14 - var_13;
  }

  var_10 = getanimlength(var_8);
  var_11 = var_10 * var_14 / var_12 * 0.9;
  var_11 = floor(var_11 * 20) * 0.05;
  self func_82E1("shuffle", var_8, 1, var_6);
  scripts\anim\notetracks::donotetracksfortime(var_11, "shuffle");
  for(var_12 = 0; var_12 < 2; var_12++) {
    var_14 = distance(self.origin, var_2.origin);
    if(var_15) {
      var_14 = var_14 - var_13;
    }

    if(var_14 < 4) {
      break;
    }

    var_11 = var_10 * var_14 / var_12 * 0.9;
    var_11 = floor(var_11 * 20) * 0.05;
    if(var_11 < 0.05) {
      break;
    }

    scripts\anim\notetracks::donotetracksfortime(var_11, "shuffle");
  }

  if(var_15) {
    if(func_BCAE(var_2)) {
      var_6 = 0.2;
    } else {
      var_6 = 0.4;
    }

    self clearanim(var_8, var_6);
    self func_82E1("shuffle_end", var_9, 1, var_6);
    scripts\anim\shared::donotetracks("shuffle_end");
  }

  self ghost_target_position(var_2.origin);
  self animmode("normal");
  self.var_10170 = undefined;
}

func_BCB0() {
  if(isDefined(self.var_10170)) {
    self clearanim(%cover_shuffle, 0.2);
    self.var_10170 = undefined;
    self animmode("none", 0);
    self orientmode("face default");
    return;
  }

  wait(0.2);
  self clearanim(%cover_shuffle, 0.2);
}

func_BCB5(var_0, var_1, var_2) {
  var_3 = undefined;
  if(!isDefined(var_3)) {
    return 0;
  }

  self animmode("zonly_physics", 0);
  self orientmode("face current");
  self func_82EA("sideToSide", var_3, 1, 0.2);
  scripts\anim\shared::donotetracks("sideToSide", ::func_89E3);
  var_4 = self getscoreinfocategory(var_3);
  var_5 = var_2.origin - var_1.origin;
  var_5 = vectornormalize((var_5[0], var_5[1], 0));
  var_6 = getmovedelta(var_3, var_4, 1);
  var_7 = var_2.origin - self.origin;
  var_7 = (var_7[0], var_7[1], 0);
  var_8 = vectordot(var_7, var_5) - abs(var_6[1]);
  if(var_8 > 2) {
    var_9 = getnotetracktimes(var_3, "slide_end")[0];
    var_10 = var_9 - var_4 * getanimlength(var_3);
    var_11 = int(ceil(var_10 / 0.05));
    var_12 = var_5 * var_8 / var_11;
    thread func_102E9(var_12, var_11);
  }

  scripts\anim\shared::donotetracks("sideToSide");
  self ghost_target_position(var_2.origin);
  self animmode("none");
  self orientmode("face default");
  self.var_10170 = undefined;
  wait(0.2);
  return 1;
}

func_89E3(var_0) {
  if(var_0 == "slide_start") {
    return 1;
  }
}

func_102E9(var_0, var_1) {
  self endon("killanimscript");
  self endon("goal_changed");
  while(var_1 > 0) {
    self ghost_target_position(self.origin + var_0);
    var_1--;
    wait(0.05);
  }
}

func_BCF8(var_0, var_1) {
  self endon("movemode");
  self clearanim(%combatrun, 0.6);
  self func_82A5(%combatrun, %body, 1, 0.5, self.moveplaybackrate);
  if(isDefined(self.var_E1B0) && gettime() - self.var_E1B0 < 100 && isDefined(self.var_E80D) && randomfloat(1) < self.a.reacttobulletchance) {
    scripts\anim\run::func_4C9A();
    return;
  }

  if(isarray(var_0)) {
    if(isDefined(self.var_E80B)) {
      var_2 = scripts\engine\utility::choose_from_weighted_array(var_0, var_1);
    } else {
      var_2 = var_1[randomint(var_1.size)];
    }
  } else {
    var_2 = var_1;
  }

  self give_left_powers("moveanim", var_2, 1, 0.2, self.moveplaybackrate);
  scripts\anim\shared::donotetracks("moveanim");
}

func_AD66() {
  thread scripts\anim\cover_arrival::func_FA90(1);
}