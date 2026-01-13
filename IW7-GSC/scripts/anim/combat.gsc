/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\combat.gsc
*********************************************/

func_9504() {}

main() {
  if(isDefined(self.var_BFDC)) {
    return;
  }

  if(isDefined(self.var_4C37)) {
    if(isDefined(self.var_4C37["combat"])) {
      [
        [self.var_4C37["combat"]]
      ]();
      return;
    }
  }

  self endon("killanimscript");
  if(getdvarint("ai_iw7", 0) == 1) {
    wait(0.05);
  }

  [[self.exception["exposed"]]]();
  scripts\anim\utility::func_9832("combat");
  self.a.var_22F5 = undefined;
  if(isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Ambush" && self getweaponassetfromrootweapon(self.target_getindexoftarget)) {
    self.var_1E2C = self.target_getindexoftarget;
  }

  transitiontocombat();
  func_5859();
  if(isDefined(self.var_1095A)) {
    scripts\anim\stop::func_1095B();
  }

  func_F8A3();
  func_6A13();
  self notify("stop_deciding_how_to_shoot");
}

end_script() {
  if(getdvarint("ai_iw7", 0) == 1) {
    return;
  }

  self.var_1E2C = undefined;
  func_43D0();
}

func_5859() {
  if(self.team != "allies") {
    return;
  }

  if(self _meth_81B1() && self.weaponstartammo == "move" && self.a.pose == "stand" && !isDefined(self.var_55EF)) {
    if(isDefined(self.isnodeoccupied) && distancesquared(self.origin, self.isnodeoccupied.origin) < squared(128)) {
      return;
    }

    if(!isDefined(self.a.var_2274)) {
      return;
    }

    if(isDefined(self.a.var_2274["surprise_stop"])) {
      var_0 = scripts\anim\utility::func_1F64("surprise_stop");
    } else {
      var_0 = scripts\anim\utility::func_B027("combat", "surprise_stop");
    }

    func_E246();
    self _meth_82E4("react", var_0, % root, 1, 0.2, self.animplaybackrate);
    func_43E3(var_0, "run");
    scripts\anim\shared::donotetracks("react");
  }
}

transitiontocombat() {
  if(isDefined(self.var_1095A) || isDefined(self.var_4C8C)) {
    return;
  }

  if(isDefined(self.isnodeoccupied) && distancesquared(self.origin, self.isnodeoccupied.origin) < 262144) {
    return;
  }

  if(self.weaponstartammo == "stop" && !scripts\anim\utility::func_9D9B() && self.a.pose == "stand") {
    func_E246();
    var_0 = scripts\anim\utility::func_B027("combat", "trans_to_combat");
    self _meth_82E4("transition", var_0, % root, 1, 0.2, 1.2 * self.animplaybackrate);
    func_43E3(var_0, "run");
    scripts\anim\shared::donotetracks("transition");
  }
}

func_F8BD() {
  if(self.a.pose == "stand") {
    scripts\anim\animset::func_F2BE();
    return;
  }

  if(self.a.pose == "crouch") {
    scripts\anim\animset::func_F2B6();
    return;
  }

  if(self.a.pose == "prone") {
    scripts\anim\animset::func_F2BC();
    return;
  }
}

func_F8A3() {
  if(scripts\anim\utility_common::isusingsidearm() && self getteleportlonertargetplayer("stand")) {
    transitionto("stand");
  }

  func_F8BD();
  func_F296();
  thread func_1108A();
  self clearanim( % root, 0.2);
  scripts\anim\combat_utility::func_FA8C(0.2);
  thread scripts\anim\combat_utility::func_1A3E();
  func_5123();
}

func_1108A() {
  self endon("killanimscript");
  wait(0.2);
  self.a.movement = "stop";
}

func_F337(var_0) {
  if(isDefined(var_0)) {
    self _meth_82D0(var_0);
  } else {
    self _meth_82D0();
  }

  if(scripts\engine\utility::actor_is3d()) {
    self.var_368 = -65;
    self.isbot = 65;
    self.setdevdvar = -56;
    self.setmatchdatadef = 56;
  }
}

func_F296() {
  func_F337();
  if(self.a.pose == "stand" && !scripts\engine\utility::actor_is3d()) {
    self.var_368 = -45;
    self.isbot = 45;
  }

  self.var_129AF = self.var_504E;
  self.var_CBF8 = self.var_5042;
}

func_FAAC() {
  thread scripts\anim\track::func_11B07();
  thread func_DD26();
  thread scripts\anim\shoot_behavior::func_4F69("normal");
  thread func_13B3F();
  func_E251();
  if(isDefined(self.a.var_B168)) {
    scripts\anim\weaponlist::refillclip();
    self.a.var_B168 = undefined;
  }

  self.a.var_5956 = gettime() + randomintrange(500, 1500);
}

func_100A1(var_0) {
  if(!scripts\anim\utility_common::usingrocketlauncher()) {
    return 0;
  }

  return scripts\anim\utility::func_10000(var_0);
}

func_1109D() {
  if(self.a.pose != "stand" && self.a.pose != "crouch") {
    transitionto("crouch");
  }

  if(self.a.pose == "stand") {
    scripts\anim\shared::func_1180E(scripts\anim\utility::func_B027("combat", "drop_rpg_stand"));
  } else {
    scripts\anim\shared::func_1180E(scripts\anim\utility::func_B027("combat", "drop_rpg_crouch"));
  }

  self clearanim( % root, 0.2);
  scripts\anim\combat_utility::func_631A();
  func_F8BD();
  scripts\anim\combat_utility::func_10D9A();
}

func_7E71(var_0) {
  if(self.a.pose != "stand" && self getteleportlonertargetplayer("stand")) {
    if(var_0 < 81225) {
      return "stand";
    }

    if(isDefined(self.isnodeoccupied) && !self getpersstat(self.isnodeoccupied) || !self canshootenemy() && sighttracepassed(self.origin + (0, 0, 64), self.isnodeoccupied getshootatpos(), 0, undefined)) {
      self.a.var_5956 = gettime() + 3000;
      return "stand";
    }
  }

  if(var_0 > 262144 && self.a.pose != "crouch" && self getteleportlonertargetplayer("crouch") && !scripts\engine\utility::actor_is3d() && !scripts\anim\utility_common::isusingsidearm() && !isDefined(self.heat) && gettime() >= self.a.var_5956 && lengthsquared(self.var_FE9F) < 10000) {
    if(!isDefined(self.var_FECF) || sighttracepassed(self.origin + (0, 0, 36), self.var_FECF, 0, undefined)) {
      return "crouch";
    }
  }

  return undefined;
}

func_6A11(var_0) {
  var_1 = scripts\anim\utility_common::isusingsidearm();
  if(!var_1 && func_391A()) {
    if((isDefined(self.var_72DE) && self.a.pose == "stand") || scripts\anim\utility_common::isasniper(0) && var_0 < 167772.2) {
      func_5AB9();
      return 1;
    }
  }

  if(scripts\anim\utility_common::needtoreload(0)) {
    if(!var_1 && scripts\engine\utility::cointoss() && !scripts\anim\utility_common::usingrocketlauncher() && scripts\anim\utility_common::isusingprimary() && var_0 < 167772.2 && self getteleportlonertargetplayer("stand")) {
      if(self.a.pose != "stand") {
        transitionto("stand");
        return 1;
      }

      if(func_391A()) {
        func_5AB9();
        return 1;
      }
    }

    func_6A19(0);
    return 1;
  }

  return 0;
}

func_391A() {
  if(isDefined(self.secondaryweapon) && scripts\anim\utility_common::isshotgun(self.secondaryweapon)) {
    return 0;
  }

  if(isDefined(self.var_C009)) {
    return 0;
  }

  return 1;
}

func_5AB9() {
  self.a.pose = "stand";
  func_11381(scripts\anim\utility::func_B027("combat", "primary_to_pistol"));
}

func_10062(var_0) {
  if(scripts\anim\utility_common::isusingsidearm() && self.a.pose == "stand" && !isDefined(self.var_72DE)) {
    if(var_0 > 262144) {
      return 1;
    }

    if(self.var_BC == "ambush_nodes_only" && !isDefined(self.isnodeoccupied) || !self getpersstat(self.isnodeoccupied)) {
      return 1;
    }
  }

  return 0;
}

func_DB34() {
  func_11380(scripts\anim\utility::func_B027("combat", "pistol_to_primary"));
}

func_6A15() {
  if(isDefined(self.heat) && self getwatcheddvar()) {
    self ghost_target_position(self.target_remove, self.target_getindexoftarget.angles);
  }
}

func_6A14() {
  if(func_BEA0()) {
    var_0 = 0.25;
    if(isDefined(self.var_FE9E) && !issentient(self.var_FE9E)) {
      var_0 = 1.5;
    }

    var_1 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(var_0);
    if(func_129B2(var_1)) {
      return 1;
    }
  }

  return 0;
}

func_6A13() {
  self endon("killanimscript");
  func_FAAC();
  func_E246(0);
  if(scripts\engine\utility::actor_is3d()) {
    var_0 = (0, self.angles[1], 0);
    self orientmode("face angle 3d", var_0);
  } else {
    self orientmode("face angle", self.angles[1]);
  }

  for(;;) {
    if(scripts\anim\utility_common::usingrocketlauncher()) {
      self.var_4E46 = undefined;
    }

    scripts\anim\utility::func_12EB9();
    if(func_136EA()) {
      continue;
    }

    if(shouldmelee()) {
      domelee();
    }

    func_6A15();
    if(!isDefined(self.var_FECF)) {
      func_392C();
      continue;
    }

    func_E251();
    var_1 = lengthsquared(self.origin - self.var_FECF);
    if(func_100A1(var_1)) {
      func_1109D();
      continue;
    }

    if(func_6A14()) {
      continue;
    }

    if(func_453F()) {
      continue;
    }

    if(func_6A11(var_1)) {
      continue;
    }

    if(scripts\anim\utility_common::usingrocketlauncher() && self.a.pose != "crouch" && randomfloat(1) > 0.65) {
      self.var_4E46 = ::func_E774;
    }

    if(func_10062(var_1)) {
      func_DB34();
    }

    var_2 = func_7E71(var_1);
    if(isDefined(var_2) && var_2 != self.a.pose) {
      transitionto(var_2);
      continue;
    }

    if(scripts\anim\combat_utility::func_1A3B()) {
      func_FEDE();
      scripts\anim\combat_utility::func_8EBF();
      continue;
    }

    func_6A1C();
  }
}

func_6A1C() {
  if(!isDefined(self.isnodeoccupied) || !self getpersstat(self.isnodeoccupied)) {
    self endon("enemy");
    self endon("shoot_behavior_change");
    wait(0.2 + randomfloat(0.1));
    self waittill("do_slow_things");
    return;
  }

  wait(0.05);
}

func_10B70() {
  if(isDefined(self.isnodeoccupied) && !self getpersstat(self.isnodeoccupied) || !self canshootenemy() && sighttracepassed(self.origin + (0, 0, 64), self.isnodeoccupied getshootatpos(), 0, undefined)) {
    self.a.var_5956 = gettime() + 3000;
    transitionto("stand");
    return 1;
  }

  return 0;
}

func_BEA0() {
  var_0 = self.var_FECF;
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = self.angles[1] - vectortoyaw(var_0 - self.origin);
  var_2 = distancesquared(self.origin, var_0);
  if(var_2 < 65536) {
    var_3 = sqrt(var_2);
    if(var_3 > 3) {
      var_1 = var_1 + asin(-3 / var_3);
    }
  }

  return scripts\engine\utility::absangleclamp180(var_1) > self.var_129AF;
}

func_136EA() {
  var_0 = self.a.pose;
  if(isDefined(self.a.onback)) {
    wait(0.1);
    return 1;
  }

  if(var_0 == "stand" && isDefined(self.heat)) {
    return 0;
  }

  if(!self getteleportlonertargetplayer(var_0)) {
    var_1 = "crouch";
    if(var_0 == "crouch") {
      var_1 = "stand";
    }

    var_2 = "prone";
    if(var_0 == "prone") {
      var_1 = "stand";
      var_2 = "crouch";
    }

    if(self getteleportlonertargetplayer(var_1)) {
      if(var_0 == "stand" && scripts\anim\utility_common::isusingsidearm()) {
        return 0;
      }

      transitionto(var_1);
      return 1;
    } else if(self getteleportlonertargetplayer(var_2)) {
      if(var_0 == "stand" && scripts\anim\utility_common::isusingsidearm()) {
        return 0;
      }

      transitionto(var_2);
      return 1;
    }
  }

  return 0;
}

func_392C() {
  if(self.a.pose != "stand" && self getteleportlonertargetplayer("stand") && func_10B70()) {
    return 1;
  }

  var_0 = gettime();
  self.a.var_5956 = var_0 + 1500;
  if(isDefined(self.group) && isDefined(self.group.missionfailed)) {
    var_1 = angleclamp180(self.angles[1] - vectortoyaw(self.group.missionfailed));
    if(func_129B2(var_1)) {
      return 1;
    }
  }

  if(isDefined(self.target_getindexoftarget) && isDefined(level.var_9D8E[self.target_getindexoftarget.type])) {
    var_1 = angleclamp180(self.angles[1] - self.target_getindexoftarget.angles[1]);
    if(func_129B2(var_1)) {
      return 1;
    }
  } else if((isDefined(self.isnodeoccupied) && self seerecently(self.isnodeoccupied, 2)) || var_0 > self.a.var_EF87 + 1200) {
    var_1 = undefined;
    var_2 = self getsafeanimmovedeltapercentage();
    if(isDefined(var_2)) {
      var_1 = angleclamp180(self.angles[1] - var_2[1]);
    } else if(isDefined(self.target_getindexoftarget)) {
      var_1 = angleclamp180(self.angles[1] - self.target_getindexoftarget.angles[1]);
    } else if(isDefined(self.isnodeoccupied)) {
      var_2 = vectortoangles(self lastknownpos(self.isnodeoccupied) - self.origin);
      var_1 = angleclamp180(self.angles[1] - var_2[1]);
    }

    if(isDefined(var_1) && func_129B2(var_1)) {
      return 1;
    }
  } else if(isDefined(self.heat) && self _meth_8213()) {
    var_1 = angleclamp180(self.angles[1] - self.target_getindexoftarget.angles[1]);
    if(func_129B2(var_1)) {
      return 1;
    }
  }

  if(func_453F()) {
    return 1;
  }

  var_3 = self.a.var_BF82 < var_0;
  var_4 = 0;
  if(var_3) {
    var_4 = 0.99999;
  }

  if(scripts\anim\utility_common::needtoreload(var_4)) {
    func_6A19(var_4);
    return 1;
  }

  if(var_3 && scripts\anim\utility_common::isusingsidearm()) {
    if(func_11380(scripts\anim\utility::func_B027("combat", "pistol_to_primary"))) {
      return 1;
    }
  }

  func_392D();
  return 1;
}

func_392D() {
  self endon("shoot_behavior_change");
  wait(0.4 + randomfloat(0.4));
  self waittill("do_slow_things");
}

func_E251() {
  self.a.var_BF82 = gettime() + randomintrange(2000, 4000);
}

func_129B2(var_0) {
  if(var_0 < 0 - self.var_129AF) {
    if(self.a.pose == "prone") {
      scripts\anim\cover_prone::func_DA87("crouch");
      scripts\anim\animset::func_F2B6();
    }

    func_5AC8("right", 0 - var_0);
    scripts\sp\gameskill::func_54C4();
    return 1;
  }

  if(var_0 > self.var_129AF) {
    if(self.a.pose == "prone") {
      scripts\anim\cover_prone::func_DA87("crouch");
      scripts\anim\animset::func_F2B6();
    }

    func_5AC8("left", var_0);
    scripts\sp\gameskill::func_54C4();
    return 1;
  }

  return 0;
}

func_13B3F() {
  self endon("killanimscript");
  self.var_FE9F = (0, 0, 0);
  var_0 = undefined;
  var_1 = self.origin;
  var_2 = 0.15;
  for(;;) {
    if(isDefined(self.var_FE9E) && isDefined(var_0) && self.var_FE9E == var_0) {
      var_3 = self.var_FE9E.origin;
      self.var_FE9F = var_3 - var_1 * 1 / var_2;
      var_1 = var_3;
    } else {
      if(isDefined(self.var_FE9E)) {
        var_1 = self.var_FE9E.origin;
      } else {
        var_1 = self.origin;
      }

      var_0 = self.var_FE9E;
      self.var_FE9F = (0, 0, 0);
    }

    wait(var_2);
  }
}

func_100A6() {
  return 0;
}

donotetrackswithendon(var_0) {
  self endon("killanimscript");
  scripts\anim\shared::donotetracks(var_0);
}

func_6A6F() {
  self endon("killanimscript");
  self notify("facing_enemy_immediately");
  self endon("facing_enemy_immediately");
  var_0 = 5;
  for(;;) {
    var_1 = 0 - scripts\anim\utility_common::getyawtoenemy();
    if(abs(var_1) < 2) {
      break;
    }

    if(abs(var_1) > var_0) {
      var_1 = var_0 * scripts\engine\utility::sign(var_1);
    }

    self orientmode("face angle", self.angles[1] + var_1);
    wait(0.05);
  }

  self orientmode("face current");
  self notify("can_stop_turning");
}

isdeploying(var_0) {
  var_1 = getmovedelta(var_0, 0, 1);
  var_2 = self gettweakablevalue(var_1);
  return self _meth_81A5(var_2) && self maymovetopoint(var_2);
}

func_9D43(var_0) {
  var_1 = getmovedelta(var_0, 0, 1);
  var_2 = self gettweakablevalue(var_1);
  return self _meth_81A5(var_2);
}

func_5AC8(var_0, var_1) {
  var_2 = isDefined(self.var_FECF);
  var_3 = 1;
  var_4 = 0.2;
  var_5 = isDefined(self.isnodeoccupied) && !isDefined(self.var_129B3) && self seerecently(self.isnodeoccupied, 2) && distancesquared(self.isnodeoccupied.origin, self.origin) < 262144;
  if(self.a.var_EF87 + 500 > gettime()) {
    var_4 = 0.25;
    if(var_5) {
      thread func_6A6F();
    }
  } else if(var_5) {
    var_6 = 1 - distance(self.isnodeoccupied.origin, self.origin) / 512;
    var_3 = 1 + var_6 * 1;
    if(var_3 > 2) {
      var_4 = 0.05;
    } else if(var_3 > 1.3) {
      var_4 = 0.1;
    } else {
      var_4 = 0.15;
    }
  }

  var_7 = 0;
  if(var_1 > 157.5) {
    var_7 = 180;
  } else if(var_1 > 112.5) {
    var_7 = 135;
  } else if(var_1 > 67.5) {
    var_7 = 90;
  } else {
    var_7 = 45;
  }

  var_8 = "turn_" + var_0 + "_" + var_7;
  var_9 = scripts\anim\utility::func_1F64(var_8);
  if(isDefined(self.var_129B3)) {
    self animmode("angle deltas", 0);
  } else if(isDefined(self.target_getindexoftarget) && isDefined(level.var_9D8D[self.target_getindexoftarget.type]) && distancesquared(self.origin, self.target_getindexoftarget.origin) < 256) {
    self animmode("angle deltas", 0);
  } else if(func_9D43(var_9)) {
    func_E246();
  } else {
    self animmode("angle deltas", 0);
  }

  self _meth_82A5( % exposed_aiming, % body, 1, var_4);
  if(!isDefined(self.var_129B3)) {
    func_129A1(var_4);
  }

  self _meth_82AC( % turn, 1, var_4);
  if(isDefined(self.heat)) {
    var_3 = min(1, var_3);
  } else if(isDefined(self.var_129B3)) {
    var_3 = max(1.5, var_3);
  }

  self _meth_82E6("turn", var_9, 1, var_4, var_3);
  func_43E3(var_9, "aim");
  self notify("turning");
  if(var_2 && !isDefined(self.var_129B3) && !isDefined(self.heat)) {
    thread func_FEEC();
  }

  func_5AC9();
  self _meth_82AC( % turn, 0, 0.2);
  if(!isDefined(self.var_129B3)) {
    func_129A0(0.2);
  }

  if(!isDefined(self.var_129B3)) {
    self clearanim( % turn, 0.2);
    self setanimknob( % exposed_aiming, 1, 0.2, 1);
  } else {
    self clearanim( % exposed_modern, 0.3);
  }

  if(isDefined(self.var_129A5)) {
    self.var_129A5 = undefined;
    thread func_6A6F();
  }

  func_E246(0);
  self notify("done turning");
}

func_5AC9() {
  self endon("can_stop_turning");
  scripts\anim\shared::donotetracks("turn");
}

func_B2B2() {
  self endon("killanimscript");
  self endon("done turning");
  var_0 = self.angles[1];
  wait(0.3);
  if(self.angles[1] == var_0) {
    self notify("turning_isnt_working");
    self.var_129A5 = 1;
  }
}

func_129A1(var_0) {
  self _meth_82AC(scripts\anim\utility::func_1F64("straight_level"), 0, var_0);
  self give_attacker_kill_rewards( % add_idle, 0, var_0);
  if(!scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    self clearanim( % add_fire, 0.2);
  }
}

func_129A0(var_0) {
  self _meth_82AC(scripts\anim\utility::func_1F64("straight_level"), 1, var_0);
  self give_attacker_kill_rewards( % add_idle, 1, var_0);
}

func_FEEC() {
  self endon("killanimscript");
  self endon("done turning");
  if(scripts\anim\utility_common::usingrocketlauncher()) {
    return;
  }

  scripts\anim\combat_utility::func_FEDF();
  self clearanim( % add_fire, 0.2);
}

func_FEDE() {
  thread func_13A4D();
  self endon("need_to_turn");
  thread func_A57F();
  scripts\anim\combat_utility::func_FEDF();
  self notify("stop_watching_for_need_to_turn");
  self notify("stop_trying_to_melee");
}

func_13A4D() {
  self endon("killanimscript");
  self endon("stop_watching_for_need_to_turn");
  var_0 = gettime() + 4000 + randomint(2000);
  for(;;) {
    if(gettime() > var_0 || func_BEA0()) {
      self notify("need_to_turn");
      break;
    }

    wait(0.1);
  }
}

func_453F() {
  if(!scripts\anim\combat_utility::func_BE18()) {
    return 0;
  }

  if(isDefined(level.var_11813) && isalive(level.player)) {
    if(func_1289C(level.player, 200)) {
      return 1;
    }
  }

  if(isDefined(self.isnodeoccupied) && func_1289C(self.isnodeoccupied, self.var_B781)) {
    return 1;
  }

  self.a.nextgrenadetrytime = gettime() + 500;
  return 0;
}

func_1289C(var_0, var_1) {
  var_2 = 0;
  if(isDefined(self.dontevershoot) || isDefined(var_0.var_5951)) {
    return 0;
  }

  if(!isDefined(self.a.var_2274["exposed_grenade"])) {
    return 0;
  }

  var_3 = var_0.origin;
  if(!self getpersstat(var_0)) {
    if(isDefined(self.isnodeoccupied) && var_0 == self.isnodeoccupied && isDefined(self.var_FECF)) {
      var_3 = self.var_FECF;
    }
  }

  if(!self getpersstat(var_0)) {
    var_1 = 100;
  }

  if(distancesquared(self.origin, var_3) > var_1 * var_1 && self.a.pose == self.a.var_85E2) {
    scripts\anim\combat_utility::func_F62B(var_0);
    if(!scripts\anim\combat_utility::_meth_85B5(var_0)) {
      return 0;
    }

    var_4 = scripts\engine\utility::getyawtospot(var_3);
    if(abs(var_4) < 60) {
      var_5 = [];
      foreach(var_7 in self.a.var_2274["exposed_grenade"]) {
        if(isdeploying(var_7)) {
          var_5[var_5.size] = var_7;
        }
      }

      if(var_5.size > 0) {
        self give_attacker_kill_rewards( % exposed_aiming, 0, 0.1);
        func_43D0();
        self animmode("zonly_physics");
        scripts\anim\track::func_F641(0, 0);
        var_2 = scripts\anim\combat_utility::func_128A0(var_0, var_5[randomint(var_5.size)]);
        self give_attacker_kill_rewards( % exposed_aiming, 1, 0.1);
        func_43E3(undefined, "aim");
        if(var_2) {
          scripts\anim\track::func_F641(1, 0.5);
        } else {
          scripts\anim\track::func_F641(1, 0);
        }
      }
    }
  }

  if(var_2) {
    scripts\sp\gameskill::func_54C4();
  }

  return var_2;
}

transitionto(var_0) {
    if(var_0 == self.a.pose) {
      return;
    }

    var_1 = self.a.pose + "_2_" + var_0;
    if(!isDefined(self.a.var_2274)) {
      return;
    }

    var_2 = self.a.var_2274[var_1];
    if(!isDefined(var_2)) {
      return;
    }

    self clearanim( % root, 0.3);
    scripts\anim\combat_utility::func_631A();
    if(var_0 == "stand") {
      var_3 = 2;
    } else {
      var_3 = 1.5;
    }

    if(!animhasnotetrack(var_2, "anim_pose = \" + var_0 + "\
        ")) {
      }

      self _meth_82E4("trans", var_2, % body, 1, 0.2, var_3); func_43E3(var_2, "run"); var_4 = getanimlength(var_2) / var_3; var_5 = var_4 - 0.3;
      if(var_5 < 0.2) {
        var_5 = 0.2;
      }

      scripts\anim\notetracks::donotetracksfortime(var_5, "trans"); self.a.pose = var_0; func_F8BD(); scripts\anim\combat_utility::func_10D9A(); scripts\sp\gameskill::func_54C4();
    }

    func_A57F() {
      self endon("killanimscript");
      self endon("stop_trying_to_melee");
      self endon("done turning");
      self endon("need_to_turn");
      self endon("shoot_behavior_change");
      for(;;) {
        wait(0.2 + randomfloat(0.3));
        if(isDefined(self.isnodeoccupied)) {
          if(isplayer(self.isnodeoccupied)) {
            var_0 = -25536;
          } else {
            var_0 = 10000;
          }

          if(distancesquared(self.isnodeoccupied.origin, self.origin) < var_0) {
            if(shouldmelee()) {
              domelee();
            }
          }
        }
      }
    }

    shouldmelee() {}

    domelee() {}

    func_5123() {
      if(isDefined(self.var_C070)) {
        return;
      }

      if(isplayer(self.isnodeoccupied)) {}
    }

    func_6A19(var_0) {
      self.a.var_6A1A = 1;
      scripts\anim\combat_utility::func_631A();
      var_1 = undefined;
      if(isDefined(self.var_1096A)) {
        var_1 = self[[self.var_1096A]]();
        self.sendclientmatchdata = 1;
      } else {
        var_1 = scripts\anim\utility::func_1F67("reload");
        if(self.a.pose == "stand" && scripts\anim\utility::func_1F65("reload_crouchhide") && scripts\engine\utility::cointoss()) {
          var_1 = scripts\anim\utility::func_1F67("reload_crouchhide");
        }
      }

      thread func_A57F();
      self.var_6CDB = 0;
      if(weaponclass(self.var_394) == "pistol") {
        self orientmode("face default");
      }

      func_5A66(var_1, var_0 > 0.05);
      self notify("abort_reload");
      self orientmode("face current");
      if(self.var_6CDB) {
        scripts\anim\weaponlist::refillclip();
      }

      self clearanim( % reload, 0.2);
      self.sendclientmatchdata = 0;
      self notify("stop_trying_to_melee");
      self.a.var_6A1A = 0;
      self.var_6CDB = undefined;
      scripts\sp\gameskill::func_54C4();
      scripts\anim\combat_utility::func_10D9A();
    }

    func_5A66(var_0, var_1) {
      self endon("abort_reload");
      if(var_1) {
        thread func_152A();
      }

      var_2 = 1;
      if(!scripts\anim\utility_common::isusingsidearm() && !scripts\anim\utility_common::isshotgun(self.var_394) && isDefined(self.isnodeoccupied) && self getpersstat(self.isnodeoccupied) && distancesquared(self.isnodeoccupied.origin, self.origin) < 1048576) {
        var_2 = 1.2;
      }

      var_3 = "reload_" + scripts\anim\combat_utility::_meth_81EB();
      self clearanim( % root, 0.2);
      self _meth_82EA(var_3, var_0, 1, 0.2, var_2);
      func_43E3(var_0, "run");
      thread func_C16A("abort_reload", var_3);
      self endon("start_aim");
      scripts\anim\shared::donotetracks(var_3);
      self.var_6CDB = 1;
    }

    func_152A() {
      self endon("abort_reload");
      self endon("killanimscript");
      for(;;) {
        if(isDefined(self.var_FE9E) && self getpersstat(self.var_FE9E)) {
          break;
        }

        wait(0.05);
      }

      self notify("abort_reload");
    }

    func_C16A(var_0, var_1) {
      self endon(var_0);
      self waittillmatch("start_aim", var_1);
      self.var_6CDB = 1;
      self notify("start_aim");
    }

    func_6CDE(var_0) {
      self endon("killanimscript");
      scripts\anim\shared::donotetracks(var_0);
    }

    func_5D15() {
      scripts\sp\mgturret::func_5EEF();
      scripts\anim\weaponlist::refillclip();
      self.a.needstorechamber = 0;
      self notify("dropped_gun");
      scripts\sp\mgturret::func_E2DB();
    }

    func_68C7() {
      func_5D15();
    }

    func_11381(var_0) {
      self endon("killanimscript");
      thread scripts\anim\combat_utility::putgunbackinhandonkillanimscript();
      scripts\anim\combat_utility::func_631A();
      self.var_11317 = var_0;
      self _meth_82E4("weapon swap", var_0, % body, 1, 0.2, scripts\anim\combat_utility::func_6B9A());
      func_43E3(var_0, "run");
      donotetrackspostcallbackwithendon("weapon swap", ::func_89D2, "end_weapon_swap");
      self clearanim(self.var_11317, 0.2);
      self notify("facing_enemy_immediately");
      self notify("switched_to_sidearm");
      scripts\sp\gameskill::func_54C4();
    }

    donotetrackspostcallbackwithendon(var_0, var_1, var_2) {
      self endon(var_2);
      scripts\anim\notetracks::donotetrackspostcallback(var_0, var_1);
    }

    func_6A6E(var_0) {
      self endon("killanimscript");
      wait(var_0);
      func_6A6F();
    }

    func_89D2(var_0) {
      foreach(var_2 in var_0) {
        if(var_2 == "pistol_pickup") {
          self clearanim(scripts\anim\utility::func_1F64("straight_level"), 0);
          scripts\anim\animset::func_F2BE();
          thread func_6A6E(0.25);
          continue;
        }

        if(var_2 == "start_aim") {
          scripts\anim\combat_utility::func_10D9A();
          if(func_BEA0()) {
            self notify("end_weapon_swap");
          }
        }
      }
    }

    func_11380(var_0, var_1) {
      self endon("killanimscript");
      if(scripts\anim\utility_common::isshotgun(self.primaryweapon) && isDefined(self.var_138DF) && !self.var_138DF && self.lastweapon == scripts\anim\utility::getaiprimaryweapon()) {
        return 0;
      }

      scripts\anim\combat_utility::func_631A();
      self.var_11317 = var_0;
      self _meth_82E4("weapon swap", var_0, % body, 1, 0.1, 1);
      func_43E3(var_0, "run");
      if(isDefined(var_1)) {
        donotetrackspostcallbackwithendon("weapon swap", ::func_8984, "end_weapon_swap");
      } else {
        donotetrackspostcallbackwithendon("weapon swap", ::func_89D7, "end_weapon_swap");
      }

      self clearanim(self.var_11317, 0.2);
      self notify("switched_to_lastweapon");
      scripts\sp\gameskill::func_54C4();
      return 1;
    }

    func_89D7(var_0) {
      foreach(var_2 in var_0) {
        if(var_2 == "pistol_putaway") {
          self clearanim(scripts\anim\utility::func_1F64("straight_level"), 0);
          scripts\anim\animset::func_F2BE();
          thread scripts\anim\combat_utility::putgunbackinhandonkillanimscript();
          continue;
        }

        if(var_2 == "start_aim") {
          scripts\anim\combat_utility::func_10D9A();
          if(func_BEA0()) {
            self notify("end_weapon_swap");
          }
        }
      }
    }

    func_8984(var_0) {
      foreach(var_2 in var_0) {
        if(var_2 == "pistol_putaway") {
          thread scripts\anim\combat_utility::putgunbackinhandonkillanimscript();
          continue;
        }

        if(issubstr(var_2, "anim_gunhand")) {
          self notify("end_weapon_swap");
        }
      }
    }

    func_E774() {
      if(!scripts\anim\utility_common::usingrocketlauncher() || self.bulletsinclip == 0) {
        return 0;
      }

      if(randomfloat(1) > 0.5) {
        var_0 = scripts\anim\utility::func_B027("combat", "rpg_death");
      } else {
        var_0 = scripts\anim\utility::func_B027("combat", "rpg_death_stagger");
      }

      self _meth_82E3("deathanim", var_0, % root, 1, 0.05, 1);
      func_43E3(var_0, "death");
      scripts\anim\shared::donotetracks("deathanim");
      scripts\anim\shared::func_5D1A();
    }

    func_DD26() {
      self endon("killanimscript");
      self.a.var_6A1A = 0;
      for(;;) {
        wait(0.2);
        if(isDefined(self.isnodeoccupied) && !self seerecently(self.isnodeoccupied, 2)) {
          if(self.var_BC == "ambush" || self.var_BC == "ambush_nodes_only") {
            continue;
          }
        }

        func_1289B();
      }
    }

    func_1289B() {
      if(self.logstring) {
        return;
      }

      if(!isDefined(self.isnodeoccupied)) {
        self.var_DD23 = 0;
        return;
      }

      if(gettime() < self.var_33B) {
        self.var_DD23 = 0;
        return;
      }

      if(isDefined(self.var_D895) && self.var_D895 != self.isnodeoccupied) {
        self.var_DD23 = 0;
        self.var_D895 = undefined;
        return;
      }

      self.var_D895 = self.isnodeoccupied;
      if(self getpersstat(self.isnodeoccupied) && self canshootenemy()) {
        self.var_DD23 = 0;
        return;
      }

      if(isDefined(self.var_6CDB) && !self.var_6CDB) {
        self.var_DD23 = 0;
        return;
      }

      if(!isDefined(self.var_DD24) || !self.var_DD24) {
        var_0 = vectornormalize(self.isnodeoccupied.origin - self.origin);
        var_1 = anglesToForward(self.angles);
        if(vectordot(var_0, var_1) < 0.5) {
          self.var_DD23 = 0;
          return;
        }
      }

      if(self.a.var_6A1A && scripts\anim\utility_common::needtoreload(0.25) && self.isnodeoccupied.health > self.isnodeoccupied.maxhealth * 0.5) {
        self.var_DD23 = 0;
        return;
      }

      if(scripts\anim\combat_utility::func_10026() && self.var_DD23 < 3) {
        self.var_DD23 = 3;
      }

      switch (self.var_DD23) {
        case 0:
          if(self getzonearray(32)) {
            return;
          }
          break;

        case 1:
          if(self getzonearray(64)) {
            self.var_DD23 = 0;
            return;
          }
          break;

        case 2:
          if(self getzonearray(96)) {
            self.var_DD23 = 0;
            return;
          }
          break;

        case 3:
          if(scripts\anim\combat_utility::func_128AA(0)) {
            self.var_DD23 = 0;
            return;
          }
          break;

        case 4:
          if(!self getpersstat(self.isnodeoccupied) || !self canshootenemy()) {
            self _meth_80EC();
          }
          break;

        default:
          if(self.var_DD23 > 15) {
            self.var_DD23 = 0;
            return;
          }
          break;
      }

      self.var_DD23++;
    }

    func_E246(var_0) {
      var_1 = var_0;
      if(!isDefined(var_1)) {
        var_1 = 1;
      }

      if(scripts\engine\utility::actor_is3d()) {
        self animmode("nogravity", var_1);
        return;
      }

      self animmode("zonly_physics", var_1);
    }

    func_43E3(var_0, var_1) {
      self.facialidx = scripts\anim\face::playfacialanim(var_0, var_1, self.facialidx);
    }

    func_43D0() {
      self.facialidx = undefined;
      self clearanim( % head, 0.2);
    }