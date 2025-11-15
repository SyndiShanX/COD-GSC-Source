/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\combat_utility.gsc
*******************************************/

_meth_8197(param_00) {
  var_01 = self getshootatpos() + (0, 0, -3);
  var_02 = (var_01[0] - param_00[0], var_01[1] - param_00[1], var_01[2] - param_00[2]);
  var_02 = vectornormalize(var_02);
  var_03 = var_02[2] * -1;
  return var_03;
}

getjointype() {
  if(isplayer(self.isnodeoccupied)) {
    return randomfloatrange(self.isnodeoccupied.gs.var_B750, self.isnodeoccupied.gs.var_B461);
  }

  return randomfloatrange(level.var_B750, level.var_B461);
}

_meth_80E7() {
  var_00 = gettime() - self.a.var_A9ED / 1000;
  var_01 = func_7E12();
  if(var_01 > var_00) {
    return var_01 - var_00;
  }

  return 0;
}

func_7E12() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    return randomfloatrange(0.15, 0.55);
  }

  if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return randomfloatrange(1, 1.7);
  }

  if(scripts\anim\utility_common::isasniper()) {
    return getjointype();
  }

  if(self.var_6B92) {
    return randomfloatrange(0.1, 0.35);
  }

  return randomfloatrange(0.4, 0.9);
}

func_32BE() {
  if(self.bulletsinclip) {
    if(self.var_FED7 == "full" && !self.var_6B92) {
      if(self.a.var_A9ED == gettime()) {
        wait(0.05);
      }

      return;
    }

    var_00 = _meth_80E7();
    if(var_00) {
      wait(var_00);
    }
  }
}

func_1A39() {
  for(var_00 = int(60); var_00 > 0; var_00--) {
    if(isDefined(self.dontevershoot) || isDefined(self.isnodeoccupied) && isDefined(self.isnodeoccupied.var_5951)) {
      wait(0.05);
      continue;
    }

    return 0;
  }

  return 1;
}

func_FEDF() {
  self endon("shoot_behavior_change");
  self endon("stopShooting");
  if(scripts\anim\utility_common::islongrangeai()) {
    if(isDefined(self.isnodeoccupied) && isai(self.isnodeoccupied) && distancesquared(level.player.origin, self.isnodeoccupied.origin) < 147456) {
      self.isnodeoccupied scripts\anim\battlechatter_ai::func_183F("infantry", self, 1);
    }

    if(scripts\anim\utility_common::usingrocketlauncher() && issentient(self.isnodeoccupied)) {
      wait(randomfloat(2));
    }
  }

  if(isDefined(self.isnodeoccupied) && distancesquared(self.origin, self.isnodeoccupied.origin) > 160000) {
    var_00 = randomintrange(1, 5);
  } else {
    var_00 = 10;
  }

  for(;;) {
    func_32BE();
    if(func_1A39()) {
      break;
    }

    if(self.var_FED7 == "full") {
      func_6D97(scripts\anim\utility::func_1F64("fire"), 1, scripts\anim\shared::func_4F66());
    } else if(self.var_FED7 == "burst" || self.var_FED7 == "semi") {
      var_01 = scripts\anim\shared::func_4F65();
      if(var_01 == 1) {
        func_6D97(scripts\anim\utility::func_1F67("single"), 1, var_01);
      } else {
        func_6D97(scripts\anim\utility::func_1F64(self.var_FED7 + var_01), 1, var_01);
      }
    } else if(self.var_FED7 == "single") {
      func_6D97(scripts\anim\utility::func_1F67("single"), 1, 1);
    } else {
      self waittill("hell freezes over");
    }

    if(!self.bulletsinclip) {
      break;
    }

    var_00--;
    if(var_00 < 0) {
      self.var_1006D = 1;
      break;
    }
  }
}

_meth_81EB() {
  level.var_1FB5++;
  return level.var_1FB5;
}

func_FA8C(param_00) {
  self give_attacker_kill_rewards( % exposed_aiming, 1, 0.2);
  if(scripts\engine\utility::actor_is3d()) {
    self _meth_82E5("exposed_aim", scripts\anim\utility::func_1F64("straight_level"), 1, param_00);
  } else {
    self _meth_82A9(scripts\anim\utility::func_1F64("straight_level"), 1, param_00);
  }

  self _meth_82A9(scripts\anim\utility::func_1F64("add_aim_up"), 1, param_00);
  self _meth_82A9(scripts\anim\utility::func_1F64("add_aim_down"), 1, param_00);
  self _meth_82A9(scripts\anim\utility::func_1F64("add_aim_left"), 1, param_00);
  self _meth_82A9(scripts\anim\utility::func_1F64("add_aim_right"), 1, param_00);
  self.facialidx = scripts\anim\face::playfacialanim(undefined, "aim", self.facialidx);
}

func_10D9A() {
  if(!isDefined(self.a.var_1A3E)) {
    func_FA8C(0.2);
    thread func_1A3E();
    thread scripts\anim\track::func_11B07();
  }
}

func_631A() {
  func_6309();
  self clearanim( % add_fire, 0.1);
  self notify("stop tracking");
}

func_10126() {
  if(isDefined(self.a.var_1A3E)) {
    self give_attacker_kill_rewards( % add_idle, 0, 0.2);
  }

  self give_attacker_kill_rewards( % add_fire, 1, 0.1);
}

func_8EBF() {
  if(isDefined(self.a.var_1A3E)) {
    self give_attacker_kill_rewards( % add_idle, 1, 0.2);
  }

  self give_attacker_kill_rewards( % add_fire, 0, 0.1);
}

func_1A3E(param_00) {
  self endon("killanimscript");
  self endon("end_aim_idle_thread");
  if(isDefined(self.a.var_1A3E)) {
    return;
  }

  self.a.var_1A3E = 1;
  wait(0.1);
  self _meth_82AC( % add_idle, 1, 0.2);
  var_01 = % add_idle;
  var_02 = 0;
  for(;;) {
    var_03 = "idle" + var_02;
    if(isDefined(self.a.var_AAF2)) {
      var_04 = scripts\anim\utility::func_1F67("lean_idle");
    } else if(scripts\anim\utility::func_1F65("exposed_idle")) {
      var_04 = scripts\anim\utility::func_1F67("exposed_idle");
    } else {
      wait(0.5);
    } else {
      if(var_04 == var_01) {
        self _meth_82E9(var_03, var_04, 1, 0.2);
      } else {
        self _meth_82E6(var_03, var_04, 1, 0.2);
      }

      var_01 = var_04;
      self waittillmatch("end", var_03);
    }

    var_02++;
  }

  self clearanim( % add_idle, 0.1);
}

func_6309() {
  self notify("end_aim_idle_thread");
  self.a.var_1A3E = undefined;
  self clearanim( % add_idle, 0.1);
}

func_FEFE() {
  if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return 1;
  }

  if(scripts\anim\weaponlist::usingautomaticweapon()) {
    return scripts\anim\weaponlist::autoshootanimrate() * 0.7;
  }

  return 0.4;
}

func_6D97(param_00, param_01, param_02) {
  var_03 = "fireAnim_" + _meth_81EB();
  scripts\sp\gameskill::resetmisstime_code();
  while(!func_1A3B()) {
    wait(0.05);
  }

  func_10126();
  var_04 = 1;
  if(isDefined(self.var_FED4)) {
    var_04 = self.var_FED4;
  } else if(self.var_FED7 == "full") {
    var_04 = scripts\anim\weaponlist::autoshootanimrate() * randomfloatrange(0.5, 1);
  } else if(self.var_FED7 == "burst") {
    var_04 = scripts\anim\weaponlist::burstshootanimrate();
  } else if(scripts\anim\utility_common::isusingsidearm()) {
    var_04 = 3;
  } else if(scripts\anim\utility_common::isusingshotgun()) {
    var_04 = func_FEFE();
  }

  self _meth_82E7(var_03, param_00, 1, 0.2, var_04);
  self _meth_83CE();
  func_6D99(var_03, param_00, param_01, param_02);
  func_8EBF();
}

func_6D98() {
  self endon("killanimscript");
  self endon("fireAnimEnd");
  var_00 = thisthread;
  for(;;) {
    waittillframeend;
    if(!isDefined(var_00)) {
      self shootstopsound();
      return;
    }

    wait(0.05);
  }
}

func_6D99(param_00, param_01, param_02, param_03) {
  self endon("enemy");
  if(isplayer(self.isnodeoccupied) && self.var_FED7 == "full" || self.var_FED7 == "semi") {
    level endon("player_becoming_invulnerable");
  }

  if(param_02) {
    thread func_C168(param_00, "fireAnimEnd");
    self endon("fireAnimEnd");
  }

  if(!isDefined(param_03)) {
    param_03 = -1;
  }

  var_04 = 0;
  var_05 = animhasnotetrack(param_01, "fire");
  var_06 = scripts\engine\utility::weaponclass(self.var_394) == "rocketlauncher";
  thread func_6D98();
  while(var_04 < param_03 && param_03 > 0) {
    if(var_05) {
      self waittillmatch("fire", param_00);
    }

    if(!self.bulletsinclip) {
      if(!scripts\anim\utility_common::cheatammoifnecessary()) {
        break;
      }
    }

    if(!func_1A3B()) {
      break;
    }

    shootatshootentorpos();
    if(isplayer(self.isnodeoccupied) && self.isnodeoccupied scripts\sp\utility::func_65DB("player_is_invulnerable")) {
      if(randomint(3) == 0) {
        self.bulletsinclip--;
      }
    } else {
      self.bulletsinclip--;
    }

    if(var_06) {
      self.a.rockets--;
      if(issubstr(tolower(self.var_394), "rpg") || issubstr(tolower(self.var_394), "panzerfaust")) {
        self hidepart("tag_rocket");
        self.a.rocketvisible = 0;
      }
    }

    var_04++;
    thread func_FEFF(param_00);
    if(self.var_6B92 && var_04 == param_03) {
      break;
    }

    if(!var_05 || param_03 == 1 && self.var_FED7 == "single") {
      self waittillmatch("end", param_00);
    }
  }

  self shootstopsound();
  if(param_02) {
    self notify("fireAnimEnd");
  }
}

func_1A3B() {
  if(!isDefined(self.var_FECF)) {
    return 1;
  }

  var_00 = self getspawnpointdist();
  var_01 = scripts\anim\shared::_meth_811C();
  var_02 = vectortoangles(self.var_FECF - var_01);
  var_03 = scripts\engine\utility::absangleclamp180(var_00[1] - var_02[1]);
  if(var_03 > level.var_1A52) {
    if(distancesquared(self getEye(), self.var_FECF) > level.var_1A50 || var_03 > level.var_1A51) {
      return 0;
    }
  }

  return scripts\engine\utility::absangleclamp180(var_00[0] - var_02[0]) <= level.var_1A44;
}

func_C168(param_00, param_01) {
  self endon("killanimscript");
  self endon(param_01);
  self waittillmatch("end", param_00);
  self notify(param_01);
}

func_9F57() {
  if(weaponburstcount(self.var_394) > 0) {
    return 0;
  } else if(weaponisauto(self.var_394) || weaponisbeam(self.var_394)) {
    return 0;
  }

  return 1;
}

shootatshootentorpos() {
  var_00 = func_9F57();
  if(isDefined(self.var_FE9E)) {
    if(isDefined(self.isnodeoccupied) && self.var_FE9E == self.isnodeoccupied) {
      scripts\anim\utility_common::shootenemywrapper(var_00);
    }
  } else {
    self[[level.var_FED3]](self.var_FECF, var_00);
  }
}

decrementbulletsinclip() {
  if(self.bulletsinclip) {
    self.bulletsinclip--;
  }
}

func_FEFF(param_00) {
  if(!scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return;
  }

  self endon("killanimscript");
  self notify("shotgun_pump_sound_end");
  self endon("shotgun_pump_sound_end");
  thread func_1108B(2);
  self waittillmatch("rechamber", param_00);
  self playSound("ai_shotgun_pump");
  self notify("shotgun_pump_sound_end");
}

func_1108B(param_00) {
  self endon("killanimscript");
  self endon("shotgun_pump_sound_end");
  wait(param_00);
  self notify("shotgun_pump_sound_end");
}

func_DDCF(param_00) {}

putgunbackinhandonkillanimscript() {
  self endon("weapon_switch_done");
  self endon("death");
  self waittill("killanimscript");
  scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
}

reload(param_00, param_01) {}

func_17CC(param_00, param_01) {
  if(!isDefined(level.var_85DF)) {
    anim.var_85DF = [];
    anim.var_85E1 = [];
  }

  var_02 = level.var_85DF.size;
  level.var_85DF[var_02] = param_00;
  level.var_85E1[var_02] = param_01;
}

func_9812() {}

func_7EE8(param_00) {
  var_01 = (0, 0, 64);
  return var_01;
}

func_11814() {
  for(var_00 = 0; var_00 < level.players.size; var_00++) {
    if(level.players[var_00].numgrenadesinprogresstowardsplayer == 0) {
      level.players[var_00].grenadetimers["frag"] = 0;
      level.players[var_00].grenadetimers["flash_grenade"] = 0;
      level.players[var_00].grenadetimers["seeker"] = 0;
    }
  }

  anim.var_11813 = 1;
}

func_F62B(param_00) {
  self.var_1652 = spawnStruct();
  if(isplayer(param_00)) {
    self.var_1652.isplayertimer = 1;
    self.var_1652.player = param_00;
    self.var_1652.timername = self.objective_team;
    return;
  }

  self.var_1652.isplayertimer = 0;
  self.var_1652.timername = "AI_" + self.objective_team;
}

usingplayer() {
  return self.var_1652.isplayertimer;
}

func_F72C(param_00, param_01) {
  if(param_00.isplayertimer) {
    var_02 = param_00.player;
    var_03 = var_02.grenadetimers[param_00.timername];
    var_02.grenadetimers[param_00.timername] = max(param_01, var_03);
    return;
  }

  var_03 = level.grenadetimers[param_01.timername];
  level.grenadetimers[param_00.timername] = max(param_01, var_03);
}

func_7E6D() {
  var_00 = undefined;
  if(usingplayer()) {
    var_01 = self.var_1652.player;
    var_00 = gettime() + var_01.gs.var_D396 + randomint(var_01.gs.var_D397);
  } else {
    var_00 = gettime() + 30000 + randomint(30000);
  }

  return var_00;
}

func_7EE9(param_00) {
  if(param_00.isplayertimer) {
    return param_00.player.grenadetimers[param_00.timername];
  }

  return level.grenadetimers[param_00.timername];
}

func_453D(param_00) {
  if(!isplayer(param_00) && self gettargetchargepos()) {
    if(gettime() < func_7EE9(self.var_1652)) {
      if(level.player.ignoreme) {
        return param_00;
      }

      var_01 = self getthreatbiasgroup();
      var_02 = level.player getthreatbiasgroup();
      if(var_01 != "" && var_02 != "" && getthreatbias(var_02, var_01) < -10000) {
        return param_00;
      }

      if(self getpersstat(level.player) || isai(param_00) && param_00 getpersstat(level.player)) {
        if(isDefined(self.covernode)) {
          var_03 = vectortoangles(level.player.origin - self.origin);
          var_04 = angleclamp180(self.covernode.angles[1] - var_03[1]);
        } else {
          var_04 = scripts\engine\utility::getyawtospot(level.player.origin);
        }

        if(abs(var_04) < 60) {
          param_00 = level.player;
          func_F62B(param_00);
        }
      }
    }
  }

  return param_00;
}

func_B4EF(param_00) {
  if(scripts\sp\utility::func_D022()) {
    return 0;
  }

  if(!param_00.gs.double_grenades_allowed) {
    return 0;
  }

  var_01 = gettime();
  if(var_01 < param_00.grenadetimers["double_grenade"]) {
    return 0;
  }

  if(var_01 > param_00.lastfraggrenadetoplayerstart + 3000) {
    return 0;
  }

  if(var_01 < param_00.lastfraggrenadetoplayerstart + 500) {
    return 0;
  }

  return param_00.numgrenadesinprogresstowardsplayer < 2;
}

func_BE18() {
  return gettime() >= self.a.nextgrenadetrytime;
}

_meth_85B5(param_00) {
  if(scripts\sp\utility::func_D022()) {
    return 0;
  }

  if(self.script_forcegrenade == 1) {
    return 1;
  }

  if(!func_BE18()) {
    return 0;
  }

  if(gettime() >= func_7EE9(self.var_1652)) {
    return 1;
  }

  if(self.var_1652.isplayertimer && self.var_1652.timername == "fraggrenade") {
    return func_B4EF(param_00);
  }

  return 0;
}

func_128A1(param_00, param_01, param_02, param_03) {
  if(!self _meth_81A2(param_00, param_01)) {
    return 0;
  } else if(distancesquared(self.origin, param_01) < -25536) {
    return 0;
  }

  var_04 = physicstrace(param_01 + (0, 0, 1), param_01 + (0, 0, -500));
  if(var_04 == param_01 + (0, 0, -500)) {
    return 0;
  }

  var_04 = var_04 + (0, 0, 0.1);
  return trygrenadethrow(param_00, var_04, param_02, param_03);
}

func_128A0(param_00, param_01) {
  if(self.var_394 == "mg42" || self.objective_state <= 0) {
    return 0;
  }

  func_F62B(param_00);
  param_00 = func_453D(param_00);
  if(!_meth_85B5(param_00)) {
    return 0;
  }

  var_02 = func_7EE8(param_01);
  if(isDefined(self.isnodeoccupied) && param_00 == self.isnodeoccupied) {
    if(!func_3E1C()) {
      return 0;
    }

    if(scripts\anim\utility_common::canseeenemyfromexposed()) {
      if(!self _meth_81A2(param_00, param_00.origin)) {
        return 0;
      }

      return trygrenadethrow(param_00, undefined, param_01, var_02);
    } else if(scripts\anim\utility_common::cansuppressenemyfromexposed()) {
      return func_128A1(param_00, scripts\anim\utility::func_7E90(), param_01, var_02);
    } else {
      if(!self _meth_81A2(param_00, param_00.origin)) {
        return 0;
      }

      return trygrenadethrow(param_00, undefined, param_01, var_02);
    }

    return 0;
  }

  return func_128A1(param_00, param_00.origin, param_01, var_02);
}

trygrenadethrow(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {}

func_DE37(param_00) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill("killanimscript");
  param_00.numgrenadesinprogresstowardsplayer--;
}

func_58BA(param_00, param_01, param_02, param_03) {
  self endon("killanimscript");
  if(self.script == "combat" || self.script == "move") {
    self orientmode("face direction", param_01);
  }

  scripts\anim\battlechatter_ai::func_67CF(self.objective_team);
  self notify("stop_aiming_at_enemy");
  self _meth_82E4("throwanim", param_00, % body, func_6B9A(), 0.1, 1);
  thread scripts\anim\notetracks::donotetracksforever("throwanim", "killanimscript");
  var_04 = scripts\anim\utility_common::getgrenademodel();
  var_05 = "none";
  for(;;) {
    self waittill("throwanim", var_06);
    if(var_06 == "grenade_left" || var_06 == "grenade_right") {
      var_05 = func_2481(var_04, "TAG_INHAND");
      self.var_9E33 = 1;
    }

    if(var_06 == "grenade_throw" || var_06 == "grenade throw") {
      break;
    }

    if(var_06 == "end") {
      self.var_1652.player.numgrenadesinprogresstowardsplayer--;
      self notify("dont_reduce_giptp_on_killanimscript");
      return 0;
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");
  if(usingplayer()) {
    thread func_13A98(self.var_1652.player, param_02);
  }

  self _meth_83C2();
  if(!usingplayer()) {
    func_F72C(self.var_1652, param_02);
  }

  if(param_03) {
    var_0D = self.var_1652.player;
    if(var_0D.numgrenadesinprogresstowardsplayer > 1 || gettime() - var_0D.var_A990 < 2000) {
      var_0D.grenadetimers["double_grenade"] = gettime() + min(5000, var_0D.gs.var_D382);
    }
  }

  self notify("stop grenade check");
  if(var_05 != "none") {
    self detach(var_04, var_05);
  } else {}

  self.var_9E33 = undefined;
  self.objective_state_nomessage = self.var_C3F3;
  self.var_C3F3 = undefined;
  self waittillmatch("end", "throwanim");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
  self give_attacker_kill_rewards( % exposed_modern, 1, 0.2);
  self give_attacker_kill_rewards( % exposed_aiming, 1);
  self clearanim(param_00, 0.2);
}

func_13A98(param_00, param_01) {
  param_00 endon("death");
  func_13A99(param_01);
  param_00.numgrenadesinprogresstowardsplayer--;
}

func_13A99(param_00) {
  var_01 = self.var_1652;
  var_02 = spawnStruct();
  var_02 thread func_13A9A(5);
  var_02 endon("watchGrenadeTowardsPlayerTimeout");
  var_03 = self.objective_team;
  var_04 = func_7EE6();
  if(!isDefined(var_04)) {
    return;
  }

  func_F72C(var_01, min(gettime() + 5000, param_00));
  var_05 = -3036;
  var_06 = 160000;
  if(var_03 == "flash_grenade") {
    var_05 = 810000;
    var_06 = 1690000;
  }

  var_07 = level.players;
  var_08 = var_04.origin;
  for(;;) {
    wait(0.1);
    if(!isDefined(var_04)) {
      break;
    }

    if(distancesquared(var_04.origin, var_08) < 400) {
      var_09 = [];
      for(var_0A = 0; var_0A < var_07.size; var_0A++) {
        var_0B = var_07[var_0A];
        var_0C = distancesquared(var_04.origin, var_0B.origin);
        if(var_0C < var_05) {
          var_0B _meth_85C8(var_01, param_00);
          continue;
        }

        if(var_0C < var_06) {
          var_09[var_09.size] = var_0B;
        }
      }

      var_07 = var_09;
      if(var_07.size == 0) {
        break;
      }
    }

    var_08 = var_04.origin;
  }
}

_meth_85C8(param_00, param_01) {
  var_02 = self;
  anim.var_11813 = undefined;
  if(gettime() - var_02.var_A990 < 3000) {
    var_02.grenadetimers["double_grenade"] = gettime() + var_02.gs.var_D382;
  }

  var_02.var_A990 = gettime();
  var_03 = var_02.grenadetimers[param_00.timername];
  var_02.grenadetimers[param_00.timername] = max(param_01, var_03);
}

func_7EE6() {
  self endon("killanimscript");
  self waittill("grenade_fire", var_00);
  return var_00;
}

func_13A9A(param_00) {
  wait(param_00);
  self notify("watchGrenadeTowardsPlayerTimeout");
}

func_2481(param_00, param_01) {
  self attach(param_00, param_01);
  thread func_5392(param_00, param_01);
  return param_01;
}

func_5392(param_00, param_01) {
  self endon("stop grenade check");
  self waittill("killanimscript");
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_C3F3)) {
    self.objective_state_nomessage = self.var_C3F3;
    self.var_C3F3 = undefined;
  }

  self detach(param_00, param_01);
}

func_C371(param_00) {
  var_01 = anglesToForward(self.angles);
  var_02 = anglestoright(self.angles);
  var_03 = anglestoup(self.angles);
  var_01 = var_01 * param_00[0];
  var_02 = var_02 * param_00[1];
  var_03 = var_03 * param_00[2];
  return var_01 + var_02 + var_03;
}

_meth_85C9(param_00, param_01) {
  level notify("armoffset");
  level endon("armoffset");
  param_00 = self.origin + func_C371(param_00);
  wait(0.05);
}

func_7EE3() {
  var_00 = randomfloat(360);
  var_01 = randomfloatrange(30, 75);
  var_02 = sin(var_01);
  var_03 = cos(var_01);
  var_04 = cos(var_00) * var_03;
  var_05 = sin(var_00) * var_03;
  var_06 = randomfloatrange(100, 200);
  var_07 = (var_04, var_05, var_02) * var_06;
  return var_07;
}

func_5D29() {
  var_00 = self gettagorigin("tag_accessory_right");
  var_01 = func_7EE3();
  self getuniqueobjectid(var_00, var_01, 3);
}

func_B019() {
  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(self.logstring || self.var_FC) {
    return 0;
  }

  var_00 = func_7DFB();
  if(isDefined(var_00)) {
    return func_13059(var_00);
  }

  return 0;
}

func_7DFB() {
  var_00 = self getregendata();
  if(!isDefined(var_00)) {
    return undefined;
  }

  var_01 = scripts\anim\utility_common::func_7E28();
  if(isDefined(var_01) && var_00 == var_01) {
    return undefined;
  }

  if(isDefined(self.covernode) && var_00 == self.covernode) {
    return undefined;
  }

  return var_00;
}

func_13059(param_00) {
  var_01 = self.sendmatchdata;
  var_02 = self.sendclientmatchdata;
  self.sendmatchdata = 0;
  self.sendclientmatchdata = 0;
  if(self _meth_83D4(param_00)) {
    return 1;
  } else {}

  self.sendmatchdata = var_01;
  self.sendclientmatchdata = var_02;
  return 0;
}

func_10026() {
  if(level.var_18D5[self.team] > 0 && level.var_18D5[self.team] < level.var_18D6) {
    if(gettime() - level.var_A936[self.team] > 4000) {
      return 0;
    }

    var_00 = level.var_A933[self.team];
    if(var_00 == self) {
      return 0;
    }

    var_01 = isDefined(var_00) && distancesquared(self.origin, var_00.origin) < 65536;
    if((var_01 || distancesquared(self.origin, level.var_A935[self.team]) < 65536) && !isDefined(self.isnodeoccupied) || distancesquared(self.isnodeoccupied.origin, level.var_A934[self.team]) < 262144) {
      return 1;
    }
  }

  return 0;
}

func_3DE5() {
  if(!isDefined(level.var_A936[self.team])) {
    return 0;
  }

  if(func_10026()) {
    return 1;
  }

  if(gettime() - level.var_A936[self.team] < level.var_18D7) {
    return 0;
  }

  if(!issentient(self.isnodeoccupied)) {
    return 0;
  }

  if(level.var_18D5[self.team]) {
    level.var_18D5[self.team] = 0;
  }

  var_00 = isDefined(self.var_18CC) && self.var_18CC;
  if(!var_00 && getaicount(self.team) < getaicount(self.isnodeoccupied.team)) {
    return 0;
  }

  return 1;
}

func_128AA(param_00) {
  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(self.logstring) {
    return 0;
  }

  if(self.var_BC == "ambush" || self.var_BC == "ambush_nodes_only") {
    return 0;
  }

  if(!self _meth_81A5(self.isnodeoccupied.origin)) {
    return 0;
  }

  if(scripts\anim\utility_common::islongrangeai()) {
    return 0;
  }

  if(!func_3DE5()) {
    return 0;
  }

  if(isDefined(self.var_36F) && self.var_36F) {
    return 0;
  }

  self getrelativeteam(param_00);
  if(self _meth_8254()) {
    self.sendmatchdata = 0;
    self.sendclientmatchdata = 0;
    self.a.var_B168 = 1;
    if(level.var_18D5[self.team] == 0) {
      level.var_A936[self.team] = gettime();
      level.var_A933[self.team] = self;
    }

    level.var_A935[self.team] = self.origin;
    level.var_A934[self.team] = self.isnodeoccupied.origin;
    level.var_18D5[self.team]++;
    return 1;
  }

  return 0;
}

func_50FB(param_00) {
  self endon("death");
  wait(0.5);
  var_01 = "" + level.var_2755;
  badplace_cylinder(var_01, 5, param_00, 16, 64, self.team);
  level.var_2759[level.var_2759.size] = var_01;
  if(level.var_2759.size >= 10) {
    var_02 = [];
    for(var_03 = 1; var_03 < level.var_2759.size; var_03++) {
      var_02[var_02.size] = level.var_2759[var_03];
    }

    badplace_delete(level.var_2759[0]);
    anim.var_2759 = var_02;
  }

  level.var_2755++;
  if(level.var_2755 > 10) {
    anim.var_2755 = level.var_2755 - 20;
  }
}

func_13156(param_00, param_01, param_02) {
  if(param_00 > param_01 && param_00 < param_02) {
    return 1;
  }

  return 0;
}

func_7EEC() {
  if(!isDefined(self.var_FECF)) {
    return 0;
  }

  var_00 = self getspawnpointdist()[1] - scripts\engine\utility::getyaw(self.var_FECF);
  var_00 = angleclamp180(var_00);
  return var_00;
}

func_7EEB() {
  if(!isDefined(self.var_FECF)) {
    return 0;
  }

  var_00 = self getspawnpointdist()[0] - vectortoangles(self.var_FECF - self getmuzzlepos())[0];
  var_00 = angleclamp180(var_00);
  return var_00;
}

canspawntestclient() {
  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  var_00 = self.isnodeoccupied getshootatpos() - self getshootatpos();
  var_00 = vectornormalize(var_00);
  var_01 = vectortoangles(var_00)[0];
  return angleclamp180(var_01);
}

castshadows(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = param_00 - self getshootatpos();
  var_01 = vectornormalize(var_01);
  var_02 = vectortoangles(var_01)[0];
  return angleclamp180(var_02);
}

_meth_8063(param_00, param_01) {
  if(!isDefined(param_00) || !isDefined(param_01)) {
    return 0;
  }

  if(isDefined(self) && scripts\engine\utility::actor_is3d()) {
    var_02 = anglesToForward(self.angles);
    var_03 = rotatepointaroundvector(var_02, param_00 - self.origin, self.angles[2] * -1);
    param_00 = var_03 + self.origin;
  }

  var_04 = param_00 - param_01;
  var_04 = vectornormalize(var_04);
  var_05 = vectortoangles(var_04)[0];
  return angleclamp180(var_05);
}

func_13B22() {
  self.isreloading = 0;
  self.var_A9DC = -1;
  for(;;) {
    self waittill("reload_start");
    self.isreloading = 1;
    self.var_A9DC = gettime();
    scripts\anim\battlechatter_ai::func_67D4();
    func_1383F();
    self.isreloading = 0;
  }
}

func_1383F() {
  thread func_118EC(4, "reloadtimeout");
  self endon("reloadtimeout");
  self endon("weapon_taken");
  for(;;) {
    self waittill("reload");
    var_00 = self getcurrentweapon();
    if(var_00 == "none") {
      break;
    }

    if(self getcurrentweaponclipammo() >= weaponclipsize(var_00)) {
      break;
    }
  }

  self notify("reloadtimeout");
}

func_118EC(param_00, param_01) {
  self endon(param_01);
  wait(param_00);
  self notify(param_01);
}

func_3E1C() {
  var_00 = self.isnodeoccupied.origin - self.origin;
  var_01 = lengthsquared((var_00[0], var_00[1], 0));
  if(self.objective_team == "flash_grenade") {
    return var_01 < 589824;
  }

  return var_01 >= -25536 && var_01 <= 1562500;
}

func_B9D9() {
  self endon("death");
  if(!isDefined(level.var_BEFB)) {
    self endon("stop_monitoring_flash");
  }

  for(;;) {
    var_00 = undefined;
    var_01 = undefined;
    var_02 = undefined;
    var_03 = undefined;
    var_04 = undefined;
    self waittill("flashbang", var_01, var_00, var_02, var_03, var_04);
    if(isDefined(self.var_6EC4) && self.var_6EC4) {
      continue;
    }

    if(isDefined(self.var_EDE6) && self.var_EDE6 != 0) {
      continue;
    }

    if(isDefined(self.team) && isDefined(var_04) && self.team == var_04) {
      var_00 = 3 * var_00 - 0.75;
      if(var_00 < 0) {
        continue;
      }

      if(isDefined(self.var_115CE)) {
        continue;
      }
    }

    var_05 = 0.2;
    if(var_00 > 1 - var_05) {
      var_00 = 1;
    } else {
      var_00 = var_00 / 1 - var_05;
    }

    var_06 = 4.5 * var_00;
    if(var_06 < 0.25) {
      continue;
    }

    self.var_6ECE = var_04;
    scripts\sp\utility::func_6EC6(var_06);
    self notify("doFlashBanged", var_01, var_03);
  }
}

func_6B9A() {
  return 1.5;
}

func_DCAD() {
  return randomfloatrange(1, 1.2);
}

dospawn(param_00) {
  if(param_00.size == 0) {
    return undefined;
  }

  if(param_00.size == 1) {
    return param_00[0];
  }

  if(isDefined(self.a.var_D892) && randomint(100) > 20) {
    foreach(var_03, var_02 in param_00) {
      if(var_02 == self.a.var_D892) {
        if(var_03 < param_00.size - 1) {
          param_00[var_03] = param_00[param_00.size - 1];
        }

        param_00[param_00.size - 1] = undefined;
        break;
      }
    }
  }

  return param_00[randomint(param_00.size)];
}

func_D285() {
  var_00 = self getEye();
  foreach(var_02 in level.players) {
    if(!self getpersstat(var_02)) {
      continue;
    }

    var_03 = var_02 getEye();
    var_04 = vectortoangles(var_00 - var_03);
    var_05 = anglesToForward(var_04);
    var_06 = var_02 getplayerangles();
    var_07 = anglesToForward(var_06);
    var_08 = vectordot(var_05, var_07);
    if(var_08 < 0.805) {
      continue;
    }

    if(scripts\engine\utility::cointoss() && var_08 >= 0.996) {
      continue;
    }

    return 1;
  }

  return 0;
}