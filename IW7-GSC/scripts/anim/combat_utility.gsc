/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\combat_utility.gsc
*********************************************/

_meth_8197(var_0) {
  var_1 = self getshootatpos() + (0, 0, -3);
  var_2 = (var_1[0] - var_0[0], var_1[1] - var_0[1], var_1[2] - var_0[2]);
  var_2 = vectornormalize(var_2);
  var_3 = var_2[2] * -1;
  return var_3;
}

getjointype() {
  if(isplayer(self.isnodeoccupied)) {
    return randomfloatrange(self.isnodeoccupied.gs.var_B750, self.isnodeoccupied.gs.var_B461);
  }

  return randomfloatrange(level.var_B750, level.var_B461);
}

_meth_80E7() {
  var_0 = gettime() - self.a.var_A9ED / 1000;
  var_1 = func_7E12();
  if(var_1 > var_0) {
    return var_1 - var_0;
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

    var_0 = _meth_80E7();
    if(var_0) {
      wait(var_0);
    }
  }
}

func_1A39() {
  for(var_0 = int(60); var_0 > 0; var_0--) {
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
    var_0 = randomintrange(1, 5);
  } else {
    var_0 = 10;
  }

  for(;;) {
    func_32BE();
    if(func_1A39()) {
      break;
    }

    if(self.var_FED7 == "full") {
      func_6D97(scripts\anim\utility::func_1F64("fire"), 1, scripts\anim\shared::func_4F66());
    } else if(self.var_FED7 == "burst" || self.var_FED7 == "semi") {
      var_1 = scripts\anim\shared::func_4F65();
      if(var_1 == 1) {
        func_6D97(scripts\anim\utility::func_1F67("single"), 1, var_1);
      } else {
        func_6D97(scripts\anim\utility::func_1F64(self.var_FED7 + var_1), 1, var_1);
      }
    } else if(self.var_FED7 == "single") {
      func_6D97(scripts\anim\utility::func_1F67("single"), 1, 1);
    } else {
      self waittill("hell freezes over");
    }

    if(!self.bulletsinclip) {
      break;
    }

    var_0--;
    if(var_0 < 0) {
      self.var_1006D = 1;
      break;
    }
  }
}

_meth_81EB() {
  level.var_1FB5++;
  return level.var_1FB5;
}

func_FA8C(var_0) {
  self give_attacker_kill_rewards( % exposed_aiming, 1, 0.2);
  if(scripts\engine\utility::actor_is3d()) {
    self _meth_82E5("exposed_aim", scripts\anim\utility::func_1F64("straight_level"), 1, var_0);
  } else {
    self _meth_82A9(scripts\anim\utility::func_1F64("straight_level"), 1, var_0);
  }

  self _meth_82A9(scripts\anim\utility::func_1F64("add_aim_up"), 1, var_0);
  self _meth_82A9(scripts\anim\utility::func_1F64("add_aim_down"), 1, var_0);
  self _meth_82A9(scripts\anim\utility::func_1F64("add_aim_left"), 1, var_0);
  self _meth_82A9(scripts\anim\utility::func_1F64("add_aim_right"), 1, var_0);
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

func_1A3E(var_0) {
  self endon("killanimscript");
  self endon("end_aim_idle_thread");
  if(isDefined(self.a.var_1A3E)) {
    return;
  }

  self.a.var_1A3E = 1;
  wait(0.1);
  self _meth_82AC( % add_idle, 1, 0.2);
  var_1 = % add_idle;
  var_2 = 0;
  for(;;) {
    var_3 = "idle" + var_2;
    if(isDefined(self.a.var_AAF2)) {
      var_4 = scripts\anim\utility::func_1F67("lean_idle");
    } else if(scripts\anim\utility::func_1F65("exposed_idle")) {
      var_4 = scripts\anim\utility::func_1F67("exposed_idle");
    } else {
      wait(0.5);
    } else {
      if(var_4 == var_1) {
        self _meth_82E9(var_3, var_4, 1, 0.2);
      } else {
        self _meth_82E6(var_3, var_4, 1, 0.2);
      }

      var_1 = var_4;
      self waittillmatch("end", var_3);
    }

    var_2++;
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

func_6D97(var_0, var_1, var_2) {
  var_3 = "fireAnim_" + _meth_81EB();
  scripts\sp\gameskill::resetmisstime_code();
  while(!func_1A3B()) {
    wait(0.05);
  }

  func_10126();
  var_4 = 1;
  if(isDefined(self.var_FED4)) {
    var_4 = self.var_FED4;
  } else if(self.var_FED7 == "full") {
    var_4 = scripts\anim\weaponlist::autoshootanimrate() * randomfloatrange(0.5, 1);
  } else if(self.var_FED7 == "burst") {
    var_4 = scripts\anim\weaponlist::burstshootanimrate();
  } else if(scripts\anim\utility_common::isusingsidearm()) {
    var_4 = 3;
  } else if(scripts\anim\utility_common::isusingshotgun()) {
    var_4 = func_FEFE();
  }

  self _meth_82E7(var_3, var_0, 1, 0.2, var_4);
  self _meth_83CE();
  func_6D99(var_3, var_0, var_1, var_2);
  func_8EBF();
}

func_6D98() {
  self endon("killanimscript");
  self endon("fireAnimEnd");
  var_0 = thisthread;
  for(;;) {
    waittillframeend;
    if(!isDefined(var_0)) {
      self shootstopsound();
      return;
    }

    wait(0.05);
  }
}

func_6D99(var_0, var_1, var_2, var_3) {
  self endon("enemy");
  if(isplayer(self.isnodeoccupied) && self.var_FED7 == "full" || self.var_FED7 == "semi") {
    level endon("player_becoming_invulnerable");
  }

  if(var_2) {
    thread func_C168(var_0, "fireAnimEnd");
    self endon("fireAnimEnd");
  }

  if(!isDefined(var_3)) {
    var_3 = -1;
  }

  var_4 = 0;
  var_5 = animhasnotetrack(var_1, "fire");
  var_6 = scripts\engine\utility::weaponclass(self.var_394) == "rocketlauncher";
  thread func_6D98();
  while(var_4 < var_3 && var_3 > 0) {
    if(var_5) {
      self waittillmatch("fire", var_0);
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

    if(var_6) {
      self.a.rockets--;
      if(issubstr(tolower(self.var_394), "rpg") || issubstr(tolower(self.var_394), "panzerfaust")) {
        self hidepart("tag_rocket");
        self.a.rocketvisible = 0;
      }
    }

    var_4++;
    thread func_FEFF(var_0);
    if(self.var_6B92 && var_4 == var_3) {
      break;
    }

    if(!var_5 || var_3 == 1 && self.var_FED7 == "single") {
      self waittillmatch("end", var_0);
    }
  }

  self shootstopsound();
  if(var_2) {
    self notify("fireAnimEnd");
  }
}

func_1A3B() {
  if(!isDefined(self.var_FECF)) {
    return 1;
  }

  var_0 = self getspawnpointdist();
  var_1 = scripts\anim\shared::_meth_811C();
  var_2 = vectortoangles(self.var_FECF - var_1);
  var_3 = scripts\engine\utility::absangleclamp180(var_0[1] - var_2[1]);
  if(var_3 > level.var_1A52) {
    if(distancesquared(self getEye(), self.var_FECF) > level.var_1A50 || var_3 > level.var_1A51) {
      return 0;
    }
  }

  return scripts\engine\utility::absangleclamp180(var_0[0] - var_2[0]) <= level.var_1A44;
}

func_C168(var_0, var_1) {
  self endon("killanimscript");
  self endon(var_1);
  self waittillmatch("end", var_0);
  self notify(var_1);
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
  var_0 = func_9F57();
  if(isDefined(self.var_FE9E)) {
    if(isDefined(self.isnodeoccupied) && self.var_FE9E == self.isnodeoccupied) {
      scripts\anim\utility_common::shootenemywrapper(var_0);
    }
  } else {
    self[[level.var_FED3]](self.var_FECF, var_0);
  }
}

decrementbulletsinclip() {
  if(self.bulletsinclip) {
    self.bulletsinclip--;
  }
}

func_FEFF(var_0) {
  if(!scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return;
  }

  self endon("killanimscript");
  self notify("shotgun_pump_sound_end");
  self endon("shotgun_pump_sound_end");
  thread func_1108B(2);
  self waittillmatch("rechamber", var_0);
  self playSound("ai_shotgun_pump");
  self notify("shotgun_pump_sound_end");
}

func_1108B(var_0) {
  self endon("killanimscript");
  self endon("shotgun_pump_sound_end");
  wait(var_0);
  self notify("shotgun_pump_sound_end");
}

func_DDCF(var_0) {}

putgunbackinhandonkillanimscript() {
  self endon("weapon_switch_done");
  self endon("death");
  self waittill("killanimscript");
  scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
}

reload(var_0, var_1) {}

func_17CC(var_0, var_1) {
  if(!isDefined(level.var_85DF)) {
    anim.var_85DF = [];
    anim.var_85E1 = [];
  }

  var_2 = level.var_85DF.size;
  level.var_85DF[var_2] = var_0;
  level.var_85E1[var_2] = var_1;
}

func_9812() {}

func_7EE8(var_0) {
  var_1 = (0, 0, 64);
  return var_1;
}

func_11814() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(level.players[var_0].numgrenadesinprogresstowardsplayer == 0) {
      level.players[var_0].grenadetimers["frag"] = 0;
      level.players[var_0].grenadetimers["flash_grenade"] = 0;
      level.players[var_0].grenadetimers["seeker"] = 0;
    }
  }

  anim.var_11813 = 1;
}

func_F62B(var_0) {
  self.var_1652 = spawnStruct();
  if(isplayer(var_0)) {
    self.var_1652.isplayertimer = 1;
    self.var_1652.player = var_0;
    self.var_1652.timername = self.objective_team;
    return;
  }

  self.var_1652.isplayertimer = 0;
  self.var_1652.timername = "AI_" + self.objective_team;
}

usingplayer() {
  return self.var_1652.isplayertimer;
}

func_F72C(var_0, var_1) {
  if(var_0.isplayertimer) {
    var_2 = var_0.player;
    var_3 = var_2.grenadetimers[var_0.timername];
    var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
    return;
  }

  var_3 = level.grenadetimers[var_1.timername];
  level.grenadetimers[var_0.timername] = max(var_1, var_3);
}

func_7E6D() {
  var_0 = undefined;
  if(usingplayer()) {
    var_1 = self.var_1652.player;
    var_0 = gettime() + var_1.gs.var_D396 + randomint(var_1.gs.var_D397);
  } else {
    var_0 = gettime() + 30000 + randomint(30000);
  }

  return var_0;
}

func_7EE9(var_0) {
  if(var_0.isplayertimer) {
    return var_0.player.grenadetimers[var_0.timername];
  }

  return level.grenadetimers[var_0.timername];
}

func_453D(var_0) {
  if(!isplayer(var_0) && self gettargetchargepos()) {
    if(gettime() < func_7EE9(self.var_1652)) {
      if(level.player.ignoreme) {
        return var_0;
      }

      var_1 = self getthreatbiasgroup();
      var_2 = level.player getthreatbiasgroup();
      if(var_1 != "" && var_2 != "" && getthreatbias(var_2, var_1) < -10000) {
        return var_0;
      }

      if(self getpersstat(level.player) || isai(var_0) && var_0 getpersstat(level.player)) {
        if(isDefined(self.covernode)) {
          var_3 = vectortoangles(level.player.origin - self.origin);
          var_4 = angleclamp180(self.covernode.angles[1] - var_3[1]);
        } else {
          var_4 = scripts\engine\utility::getyawtospot(level.player.origin);
        }

        if(abs(var_4) < 60) {
          var_0 = level.player;
          func_F62B(var_0);
        }
      }
    }
  }

  return var_0;
}

func_B4EF(var_0) {
  if(scripts\sp\utility::func_D022()) {
    return 0;
  }

  if(!var_0.gs.double_grenades_allowed) {
    return 0;
  }

  var_1 = gettime();
  if(var_1 < var_0.grenadetimers["double_grenade"]) {
    return 0;
  }

  if(var_1 > var_0.lastfraggrenadetoplayerstart + 3000) {
    return 0;
  }

  if(var_1 < var_0.lastfraggrenadetoplayerstart + 500) {
    return 0;
  }

  return var_0.numgrenadesinprogresstowardsplayer < 2;
}

func_BE18() {
  return gettime() >= self.a.nextgrenadetrytime;
}

_meth_85B5(var_0) {
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
    return func_B4EF(var_0);
  }

  return 0;
}

func_128A1(var_0, var_1, var_2, var_3) {
  if(!self _meth_81A2(var_0, var_1)) {
    return 0;
  } else if(distancesquared(self.origin, var_1) < -25536) {
    return 0;
  }

  var_4 = physicstrace(var_1 + (0, 0, 1), var_1 + (0, 0, -500));
  if(var_4 == var_1 + (0, 0, -500)) {
    return 0;
  }

  var_4 = var_4 + (0, 0, 0.1);
  return trygrenadethrow(var_0, var_4, var_2, var_3);
}

func_128A0(var_0, var_1) {
  if(self.var_394 == "mg42" || self.objective_state <= 0) {
    return 0;
  }

  func_F62B(var_0);
  var_0 = func_453D(var_0);
  if(!_meth_85B5(var_0)) {
    return 0;
  }

  var_2 = func_7EE8(var_1);
  if(isDefined(self.isnodeoccupied) && var_0 == self.isnodeoccupied) {
    if(!func_3E1C()) {
      return 0;
    }

    if(scripts\anim\utility_common::canseeenemyfromexposed()) {
      if(!self _meth_81A2(var_0, var_0.origin)) {
        return 0;
      }

      return trygrenadethrow(var_0, undefined, var_1, var_2);
    } else if(scripts\anim\utility_common::cansuppressenemyfromexposed()) {
      return func_128A1(var_0, scripts\anim\utility::func_7E90(), var_1, var_2);
    } else {
      if(!self _meth_81A2(var_0, var_0.origin)) {
        return 0;
      }

      return trygrenadethrow(var_0, undefined, var_1, var_2);
    }

    return 0;
  }

  return func_128A1(var_0, var_0.origin, var_1, var_2);
}

trygrenadethrow(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {}

func_DE37(var_0) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill("killanimscript");
  var_0.numgrenadesinprogresstowardsplayer--;
}

func_58BA(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  if(self.script == "combat" || self.script == "move") {
    self orientmode("face direction", var_1);
  }

  scripts\anim\battlechatter_ai::func_67CF(self.objective_team);
  self notify("stop_aiming_at_enemy");
  self _meth_82E4("throwanim", var_0, % body, func_6B9A(), 0.1, 1);
  thread scripts\anim\notetracks::donotetracksforever("throwanim", "killanimscript");
  var_4 = scripts\anim\utility_common::getgrenademodel();
  var_5 = "none";
  for(;;) {
    self waittill("throwanim", var_6);
    if(var_6 == "grenade_left" || var_6 == "grenade_right") {
      var_5 = func_2481(var_4, "TAG_INHAND");
      self.var_9E33 = 1;
    }

    if(var_6 == "grenade_throw" || var_6 == "grenade throw") {
      break;
    }

    if(var_6 == "end") {
      self.var_1652.player.numgrenadesinprogresstowardsplayer--;
      self notify("dont_reduce_giptp_on_killanimscript");
      return 0;
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");
  if(usingplayer()) {
    thread func_13A98(self.var_1652.player, var_2);
  }

  self _meth_83C2();
  if(!usingplayer()) {
    func_F72C(self.var_1652, var_2);
  }

  if(var_3) {
    var_0D = self.var_1652.player;
    if(var_0D.numgrenadesinprogresstowardsplayer > 1 || gettime() - var_0D.var_A990 < 2000) {
      var_0D.grenadetimers["double_grenade"] = gettime() + min(5000, var_0D.gs.var_D382);
    }
  }

  self notify("stop grenade check");
  if(var_5 != "none") {
    self detach(var_4, var_5);
  }

  self.var_9E33 = undefined;
  self.objective_state_nomessage = self.var_C3F3;
  self.var_C3F3 = undefined;
  self waittillmatch("end", "throwanim");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
  self give_attacker_kill_rewards( % exposed_modern, 1, 0.2);
  self give_attacker_kill_rewards( % exposed_aiming, 1);
  self clearanim(var_0, 0.2);
}

func_13A98(var_0, var_1) {
  var_0 endon("death");
  func_13A99(var_1);
  var_0.numgrenadesinprogresstowardsplayer--;
}

func_13A99(var_0) {
  var_1 = self.var_1652;
  var_2 = spawnStruct();
  var_2 thread func_13A9A(5);
  var_2 endon("watchGrenadeTowardsPlayerTimeout");
  var_3 = self.objective_team;
  var_4 = func_7EE6();
  if(!isDefined(var_4)) {
    return;
  }

  func_F72C(var_1, min(gettime() + 5000, var_0));
  var_5 = -3036;
  var_6 = 160000;
  if(var_3 == "flash_grenade") {
    var_5 = 810000;
    var_6 = 1690000;
  }

  var_7 = level.players;
  var_8 = var_4.origin;
  for(;;) {
    wait(0.1);
    if(!isDefined(var_4)) {
      break;
    }

    if(distancesquared(var_4.origin, var_8) < 400) {
      var_9 = [];
      for(var_0A = 0; var_0A < var_7.size; var_0A++) {
        var_0B = var_7[var_0A];
        var_0C = distancesquared(var_4.origin, var_0B.origin);
        if(var_0C < var_5) {
          var_0B _meth_85C8(var_1, var_0);
          continue;
        }

        if(var_0C < var_6) {
          var_9[var_9.size] = var_0B;
        }
      }

      var_7 = var_9;
      if(var_7.size == 0) {
        break;
      }
    }

    var_8 = var_4.origin;
  }
}

_meth_85C8(var_0, var_1) {
  var_2 = self;
  anim.var_11813 = undefined;
  if(gettime() - var_2.var_A990 < 3000) {
    var_2.grenadetimers["double_grenade"] = gettime() + var_2.gs.var_D382;
  }

  var_2.var_A990 = gettime();
  var_3 = var_2.grenadetimers[var_0.timername];
  var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
}

func_7EE6() {
  self endon("killanimscript");
  self waittill("grenade_fire", var_0);
  return var_0;
}

func_13A9A(var_0) {
  wait(var_0);
  self notify("watchGrenadeTowardsPlayerTimeout");
}

func_2481(var_0, var_1) {
  self attach(var_0, var_1);
  thread func_5392(var_0, var_1);
  return var_1;
}

func_5392(var_0, var_1) {
  self endon("stop grenade check");
  self waittill("killanimscript");
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_C3F3)) {
    self.objective_state_nomessage = self.var_C3F3;
    self.var_C3F3 = undefined;
  }

  self detach(var_0, var_1);
}

func_C371(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoup(self.angles);
  var_1 = var_1 * var_0[0];
  var_2 = var_2 * var_0[1];
  var_3 = var_3 * var_0[2];
  return var_1 + var_2 + var_3;
}

_meth_85C9(var_0, var_1) {
  level notify("armoffset");
  level endon("armoffset");
  var_0 = self.origin + func_C371(var_0);
  wait(0.05);
}

func_7EE3() {
  var_0 = randomfloat(360);
  var_1 = randomfloatrange(30, 75);
  var_2 = sin(var_1);
  var_3 = cos(var_1);
  var_4 = cos(var_0) * var_3;
  var_5 = sin(var_0) * var_3;
  var_6 = randomfloatrange(100, 200);
  var_7 = (var_4, var_5, var_2) * var_6;
  return var_7;
}

func_5D29() {
  var_0 = self gettagorigin("tag_accessory_right");
  var_1 = func_7EE3();
  self getuniqueobjectid(var_0, var_1, 3);
}

func_B019() {
  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(self.logstring || self.var_FC) {
    return 0;
  }

  var_0 = func_7DFB();
  if(isDefined(var_0)) {
    return func_13059(var_0);
  }

  return 0;
}

func_7DFB() {
  var_0 = self getregendata();
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = scripts\anim\utility_common::func_7E28();
  if(isDefined(var_1) && var_0 == var_1) {
    return undefined;
  }

  if(isDefined(self.covernode) && var_0 == self.covernode) {
    return undefined;
  }

  return var_0;
}

func_13059(var_0) {
  var_1 = self.sendmatchdata;
  var_2 = self.sendclientmatchdata;
  self.sendmatchdata = 0;
  self.sendclientmatchdata = 0;
  if(self _meth_83D4(var_0)) {
    return 1;
  }

  self.sendmatchdata = var_1;
  self.sendclientmatchdata = var_2;
  return 0;
}

func_10026() {
  if(level.var_18D5[self.team] > 0 && level.var_18D5[self.team] < level.var_18D6) {
    if(gettime() - level.var_A936[self.team] > 4000) {
      return 0;
    }

    var_0 = level.var_A933[self.team];
    if(var_0 == self) {
      return 0;
    }

    var_1 = isDefined(var_0) && distancesquared(self.origin, var_0.origin) < 65536;
    if((var_1 || distancesquared(self.origin, level.var_A935[self.team]) < 65536) && !isDefined(self.isnodeoccupied) || distancesquared(self.isnodeoccupied.origin, level.var_A934[self.team]) < 262144) {
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

  var_0 = isDefined(self.var_18CC) && self.var_18CC;
  if(!var_0 && getaicount(self.team) < getaicount(self.isnodeoccupied.team)) {
    return 0;
  }

  return 1;
}

func_128AA(var_0) {
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

  self getrelativeteam(var_0);
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

func_50FB(var_0) {
  self endon("death");
  wait(0.5);
  var_1 = "" + level.var_2755;
  badplace_cylinder(var_1, 5, var_0, 16, 64, self.team);
  level.var_2759[level.var_2759.size] = var_1;
  if(level.var_2759.size >= 10) {
    var_2 = [];
    for(var_3 = 1; var_3 < level.var_2759.size; var_3++) {
      var_2[var_2.size] = level.var_2759[var_3];
    }

    badplace_delete(level.var_2759[0]);
    anim.var_2759 = var_2;
  }

  level.var_2755++;
  if(level.var_2755 > 10) {
    anim.var_2755 = level.var_2755 - 20;
  }
}

func_13156(var_0, var_1, var_2) {
  if(var_0 > var_1 && var_0 < var_2) {
    return 1;
  }

  return 0;
}

func_7EEC() {
  if(!isDefined(self.var_FECF)) {
    return 0;
  }

  var_0 = self getspawnpointdist()[1] - scripts\engine\utility::getyaw(self.var_FECF);
  var_0 = angleclamp180(var_0);
  return var_0;
}

func_7EEB() {
  if(!isDefined(self.var_FECF)) {
    return 0;
  }

  var_0 = self getspawnpointdist()[0] - vectortoangles(self.var_FECF - self getmuzzlepos())[0];
  var_0 = angleclamp180(var_0);
  return var_0;
}

canspawntestclient() {
  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  var_0 = self.isnodeoccupied getshootatpos() - self getshootatpos();
  var_0 = vectornormalize(var_0);
  var_1 = vectortoangles(var_0)[0];
  return angleclamp180(var_1);
}

castshadows(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0 - self getshootatpos();
  var_1 = vectornormalize(var_1);
  var_2 = vectortoangles(var_1)[0];
  return angleclamp180(var_2);
}

_meth_8063(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return 0;
  }

  if(isDefined(self) && scripts\engine\utility::actor_is3d()) {
    var_2 = anglesToForward(self.angles);
    var_3 = rotatepointaroundvector(var_2, var_0 - self.origin, self.angles[2] * -1);
    var_0 = var_3 + self.origin;
  }

  var_4 = var_0 - var_1;
  var_4 = vectornormalize(var_4);
  var_5 = vectortoangles(var_4)[0];
  return angleclamp180(var_5);
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
    var_0 = self getcurrentweapon();
    if(var_0 == "none") {
      break;
    }

    if(self getcurrentweaponclipammo() >= weaponclipsize(var_0)) {
      break;
    }
  }

  self notify("reloadtimeout");
}

func_118EC(var_0, var_1) {
  self endon(var_1);
  wait(var_0);
  self notify(var_1);
}

func_3E1C() {
  var_0 = self.isnodeoccupied.origin - self.origin;
  var_1 = lengthsquared((var_0[0], var_0[1], 0));
  if(self.objective_team == "flash_grenade") {
    return var_1 < 589824;
  }

  return var_1 >= -25536 && var_1 <= 1562500;
}

func_B9D9() {
  self endon("death");
  if(!isDefined(level.var_BEFB)) {
    self endon("stop_monitoring_flash");
  }

  for(;;) {
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    self waittill("flashbang", var_1, var_0, var_2, var_3, var_4);
    if(isDefined(self.var_6EC4) && self.var_6EC4) {
      continue;
    }

    if(isDefined(self.var_EDE6) && self.var_EDE6 != 0) {
      continue;
    }

    if(isDefined(self.team) && isDefined(var_4) && self.team == var_4) {
      var_0 = 3 * var_0 - 0.75;
      if(var_0 < 0) {
        continue;
      }

      if(isDefined(self.var_115CE)) {
        continue;
      }
    }

    var_5 = 0.2;
    if(var_0 > 1 - var_5) {
      var_0 = 1;
    } else {
      var_0 = var_0 / 1 - var_5;
    }

    var_6 = 4.5 * var_0;
    if(var_6 < 0.25) {
      continue;
    }

    self.var_6ECE = var_4;
    scripts\sp\utility::func_6EC6(var_6);
    self notify("doFlashBanged", var_1, var_3);
  }
}

func_6B9A() {
  return 1.5;
}

func_DCAD() {
  return randomfloatrange(1, 1.2);
}

dospawn(var_0) {
  if(var_0.size == 0) {
    return undefined;
  }

  if(var_0.size == 1) {
    return var_0[0];
  }

  if(isDefined(self.a.var_D892) && randomint(100) > 20) {
    foreach(var_3, var_2 in var_0) {
      if(var_2 == self.a.var_D892) {
        if(var_3 < var_0.size - 1) {
          var_0[var_3] = var_0[var_0.size - 1];
        }

        var_0[var_0.size - 1] = undefined;
        break;
      }
    }
  }

  return var_0[randomint(var_0.size)];
}

func_D285() {
  var_0 = self getEye();
  foreach(var_2 in level.players) {
    if(!self getpersstat(var_2)) {
      continue;
    }

    var_3 = var_2 getEye();
    var_4 = vectortoangles(var_0 - var_3);
    var_5 = anglesToForward(var_4);
    var_6 = var_2 getplayerangles();
    var_7 = anglesToForward(var_6);
    var_8 = vectordot(var_5, var_7);
    if(var_8 < 0.805) {
      continue;
    }

    if(scripts\engine\utility::cointoss() && var_8 >= 0.996) {
      continue;
    }

    return 1;
  }

  return 0;
}