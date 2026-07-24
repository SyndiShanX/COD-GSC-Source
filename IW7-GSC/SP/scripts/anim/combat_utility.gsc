/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\combat_utility.gsc
*******************************************/

_id_8197(var_0) {
  var_1 = self getshootatpos() + (0, 0, -3);
  var_2 = (var_1[0] - var_0[0], var_1[1] - var_0[1], var_1[2] - var_0[2]);
  var_2 = vectorNormalize(var_2);
  var_3 = var_2[2] * -1;
  return var_3;
}

_id_8130() {
  if(isPlayer(self.enemy)) {
    return randomfloatrange(self.enemy.gs._id_B750, self.enemy.gs._id_B461);
  } else {
    return randomfloatrange(anim._id_B750, anim._id_B461);
  }
}

_id_80E7() {
  var_0 = (gettime() - self.a._id_A9ED) / 1000;
  var_1 = _id_7E12();

  if(var_1 > var_0) {
    return var_1 - var_0;
  }

  return 0;
}

_id_7E12() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    return randomfloatrange(0.15, 0.55);
  } else if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return randomfloatrange(1.0, 1.7);
  } else if(scripts\anim\utility_common::isasniper()) {
    return _id_8130();
  } else if(self._id_6B92) {
    return randomfloatrange(0.1, 0.35);
  } else {
    return randomfloatrange(0.4, 0.9);
  }
}

_id_32BE() {
  if(self.bulletsinclip) {
    if(self._id_FED7 == "full" && !self._id_6B92) {
      if(self.a._id_A9ED == gettime()) {
        wait 0.05;
      }

      return;
    }

    var_0 = _id_80E7();

    if(var_0) {
      wait(var_0);
    }
  }
}

_id_1A39() {
  for(var_0 = int(60.0); var_0 > 0; var_0--) {
    if(isDefined(self.dontevershoot) || isDefined(self.enemy) && isDefined(self.enemy._id_5951)) {
      wait 0.05;
      continue;
    }

    return 0;
  }

  return 1;
}

_id_FEDF() {
  self endon("shoot_behavior_change");
  self endon("stopShooting");

  if(scripts\anim\utility_common::islongrangeai()) {
    if(isDefined(self.enemy) && isai(self.enemy) && distancesquared(level.player.origin, self.enemy.origin) < 147456) {
      self.enemy scripts\anim\battlechatter_ai::_id_183F("infantry", self, 1.0);
    }

    if(scripts\anim\utility_common::usingrocketlauncher() && issentient(self.enemy)) {
      wait(randomfloat(2.0));
    }
  }

  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) > 160000) {
    var_0 = randomintrange(1, 5);
  } else {
    var_0 = 10;
  }

  for(;;) {
    _id_32BE();

    if(_id_1A39()) {
      break;
    }

    if(self._id_FED7 == "full") {
      _id_6D97(scripts\anim\utility::_id_1F64("fire"), 1, scripts\anim\shared::_id_4F66());
    } else if(self._id_FED7 == "burst" || self._id_FED7 == "semi") {
      var_1 = scripts\anim\shared::_id_4F65();

      if(var_1 == 1) {
        _id_6D97(scripts\anim\utility::_id_1F67("single"), 1, var_1);
      } else {
        _id_6D97(scripts\anim\utility::_id_1F64(self._id_FED7 + var_1), 1, var_1);
      }
    } else if(self._id_FED7 == "single")
      _id_6D97(scripts\anim\utility::_id_1F67("single"), 1, 1);
    else {
      self waittill("hell freezes over");
    }

    if(!self.bulletsinclip) {
      break;
    }

    var_0--;

    if(var_0 < 0) {
      self._id_1006D = 1;
      break;
    }
  }
}

_id_81EB() {
  anim._id_1FB5++;
  return anim._id_1FB5;
}

#using_animtree("generic_human");

_id_FA8C(var_0) {
  self _meth_82A2(%exposed_aiming, 1, 0.2);

  if(scripts\engine\utility::actor_is3d()) {
    self _meth_82E5("exposed_aim", scripts\anim\utility::_id_1F64("straight_level"), 1, var_0);
  } else {
    self _meth_82A9(scripts\anim\utility::_id_1F64("straight_level"), 1, var_0);
  }

  self _meth_82A9(scripts\anim\utility::_id_1F64("add_aim_up"), 1, var_0);
  self _meth_82A9(scripts\anim\utility::_id_1F64("add_aim_down"), 1, var_0);
  self _meth_82A9(scripts\anim\utility::_id_1F64("add_aim_left"), 1, var_0);
  self _meth_82A9(scripts\anim\utility::_id_1F64("add_aim_right"), 1, var_0);
  self.facialidx = scripts\anim\face::playfacialanim(undefined, "aim", self.facialidx);
}

_id_10D9A() {
  if(!isDefined(self.a._id_1A3E)) {
    _id_FA8C(0.2);
    thread _id_1A3E();
    thread scripts\anim\track::_id_11B07();
  }
}

_id_631A() {
  _id_6309();
  self clearanim(%add_fire, 0.1);
  self notify("stop tracking");
}

_id_10126() {
  if(isDefined(self.a._id_1A3E)) {
    self _meth_82A2(%add_idle, 0, 0.2);
  }

  self _meth_82A2(%add_fire, 1, 0.1);
}

_id_8EBF() {
  if(isDefined(self.a._id_1A3E)) {
    self _meth_82A2(%add_idle, 1, 0.2);
  }

  self _meth_82A2(%add_fire, 0, 0.1);
}

_id_1A3E(var_0) {
  self endon("killanimscript");
  self endon("end_aim_idle_thread");

  if(isDefined(self.a._id_1A3E)) {
    return;
  }
  self.a._id_1A3E = 1;
  wait 0.1;
  self _meth_82AC(%add_idle, 1, 0.2);
  var_1 = % add_idle;
  var_2 = 0;

  for(;;) {
    var_3 = "idle" + var_2;

    if(isDefined(self.a._id_AAF2)) {
      var_4 = scripts\anim\utility::_id_1F67("lean_idle");
    } else if(scripts\anim\utility::_id_1F65("exposed_idle")) {
      var_4 = scripts\anim\utility::_id_1F67("exposed_idle");
    } else {
      wait 0.5;
      __asm_jmp(loc_5BC)
    }

    if(var_4 == var_1) {
      self _meth_82E9(var_3, var_4, 1, 0.2);
    } else {
      self _meth_82E6(var_3, var_4, 1, 0.2);
    }

    var_1 = var_4;
    self waittillmatch(var_3, "end");
    var_2++;
  }

  self clearanim(%add_idle, 0.1);
}

_id_6309() {
  self notify("end_aim_idle_thread");
  self.a._id_1A3E = undefined;
  self clearanim(%add_idle, 0.1);
}

_id_FEFE() {
  if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return 1.0;
  }

  if(scripts\anim\weaponlist::usingautomaticweapon()) {
    return scripts\anim\weaponlist::autoshootanimrate() * 0.7;
  }

  return 0.4;
}

_id_6D97(var_0, var_1, var_2) {
  var_3 = "fireAnim_" + _id_81EB();
  scripts\sp\gameskill::resetmisstime_code();

  while(!_id_1A3B()) {
    wait 0.05;
  }

  _id_10126();
  var_4 = 1.0;

  if(isDefined(self._id_FED4)) {
    var_4 = self._id_FED4;
  } else if(self._id_FED7 == "full") {
    var_4 = scripts\anim\weaponlist::autoshootanimrate() * randomfloatrange(0.5, 1.0);
  } else if(self._id_FED7 == "burst") {
    var_4 = scripts\anim\weaponlist::burstshootanimrate();
  } else if(scripts\anim\utility_common::isusingsidearm()) {
    var_4 = 3.0;
  } else if(scripts\anim\utility_common::isusingshotgun()) {
    var_4 = _id_FEFE();
  }

  self _meth_82E7(var_3, var_0, 1, 0.2, var_4);
  self _meth_83CE();
  _id_6D99(var_3, var_0, var_1, var_2);
  _id_8EBF();
}

_id_6D98() {
  self endon("killanimscript");
  self endon("fireAnimEnd");
  var_0 = thisthread;

  for(;;) {
    waittillframeend;

    if(!isDefined(var_0)) {
      self shootstopsound();
      return;
    }

    wait 0.05;
  }
}

_id_6D99(var_0, var_1, var_2, var_3) {
  self endon("enemy");

  if(isPlayer(self.enemy) && (self._id_FED7 == "full" || self._id_FED7 == "semi")) {
    level endon("player_becoming_invulnerable");
  }

  if(var_2) {
    thread _id_C168(var_0, "fireAnimEnd");
    self endon("fireAnimEnd");
  }

  if(!isDefined(var_3)) {
    var_3 = -1;
  }

  var_4 = 0;
  var_5 = animhasnotetrack(var_1, "fire");
  var_6 = scripts\engine\utility::weaponclass(self.weapon) == "rocketlauncher";
  thread _id_6D98();

  while(var_4 < var_3 && var_3 > 0) {
    if(var_5) {
      self waittillmatch(var_0, "fire");
    }

    if(!self.bulletsinclip) {
      if(!scripts\anim\utility_common::cheatammoifnecessary()) {
        break;
      }
    }

    if(!_id_1A3B()) {
      break;
    }

    shootatshootentorpos();

    if(isPlayer(self.enemy) && self.enemy scripts\sp\utility::_id_65DB("player_is_invulnerable")) {
      if(randomint(3) == 0) {
        self.bulletsinclip--;
      }
    } else
      self.bulletsinclip--;

    if(var_6) {
      self.a.rockets--;

      if(issubstr(tolower(self.weapon), "rpg") || issubstr(tolower(self.weapon), "panzerfaust")) {
        self hidepart("tag_rocket");
        self.a.rocketvisible = 0;
      }
    }

    var_4++;
    thread _id_FEFF(var_0);

    if(self._id_6B92 && var_4 == var_3) {
      break;
    }

    if(!var_5 || var_3 == 1 && self._id_FED7 == "single") {
      self waittillmatch(var_0, "end");
    }
  }

  self shootstopsound();

  if(var_2) {
    self notify("fireAnimEnd");
  }
}

_id_1A3B() {
  if(!isDefined(self._id_FECF)) {
    return 1;
  }

  var_0 = self getmuzzleangle();
  var_1 = scripts\anim\shared::_id_811C();
  var_2 = vectortoangles(self._id_FECF - var_1);
  var_3 = scripts\engine\utility::absangleclamp180(var_0[1] - var_2[1]);

  if(var_3 > anim._id_1A52) {
    if(distancesquared(self getEye(), self._id_FECF) > anim._id_1A50 || var_3 > anim._id_1A51) {
      return 0;
    }
  }

  return scripts\engine\utility::absangleclamp180(var_0[0] - var_2[0]) <= anim._id_1A44;
}

_id_C168(var_0, var_1) {
  self endon("killanimscript");
  self endon(var_1);
  self waittillmatch(var_0, "end");
  self notify(var_1);
}

_id_9F57() {
  if(weaponburstcount(self.weapon) > 0) {
    return 0;
  } else if(weaponisauto(self.weapon) || weaponisbeam(self.weapon)) {
    return 0;
  }

  return 1;
}

shootatshootentorpos() {
  var_0 = _id_9F57();

  if(isDefined(self._id_FE9E)) {
    if(isDefined(self.enemy) && self._id_FE9E == self.enemy) {
      scripts\anim\utility_common::shootenemywrapper(var_0);
    }
  } else
    self[[anim._id_FED3]](self._id_FECF, var_0);
}

decrementbulletsinclip() {
  if(self.bulletsinclip) {
    self.bulletsinclip--;
  }
}

_id_FEFF(var_0) {
  if(!scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return;
  }
  self endon("killanimscript");
  self notify("shotgun_pump_sound_end");
  self endon("shotgun_pump_sound_end");
  thread _id_1108B(2.0);
  self waittillmatch(var_0, "rechamber");
  self playSound("ai_shotgun_pump");
  self notify("shotgun_pump_sound_end");
}

_id_1108B(var_0) {
  self endon("killanimscript");
  self endon("shotgun_pump_sound_end");
  wait(var_0);
  self notify("shotgun_pump_sound_end");
}

_id_DDCF(var_0) {}

putgunbackinhandonkillanimscript() {
  self endon("weapon_switch_done");
  self endon("death");
  self waittill("killanimscript");
  scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
}

reload(var_0, var_1) {}

_id_17CC(var_0, var_1) {
  if(!isDefined(anim._id_85DF)) {
    anim._id_85DF = [];
    anim._id_85E1 = [];
  }

  var_2 = anim._id_85DF.size;
  anim._id_85DF[var_2] = var_0;
  anim._id_85E1[var_2] = var_1;
}

_id_9812() {}

_id_7EE8(var_0) {
  var_1 = (0, 0, 64);
  return var_1;
}

_id_11814() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(level.players[var_0].numgrenadesinprogresstowardsplayer == 0) {
      level.players[var_0].grenadetimers["frag"] = 0;
      level.players[var_0].grenadetimers["flash_grenade"] = 0;
      level.players[var_0].grenadetimers["seeker"] = 0;
    }
  }

  anim._id_11813 = 1;
}

_id_F62B(var_0) {
  self._id_1652 = spawnStruct();

  if(isPlayer(var_0)) {
    self._id_1652.isplayertimer = 1;
    self._id_1652.player = var_0;
    self._id_1652.timername = self.grenadeweapon;
  } else {
    self._id_1652.isplayertimer = 0;
    self._id_1652.timername = "AI_" + self.grenadeweapon;
  }
}

usingplayer() {
  return self._id_1652.isplayertimer;
}

_id_F72C(var_0, var_1) {
  if(var_0.isplayertimer) {
    var_2 = var_0.player;
    var_3 = var_2.grenadetimers[var_0.timername];
    var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
  } else {
    var_3 = anim.grenadetimers[var_0.timername];
    anim.grenadetimers[var_0.timername] = max(var_1, var_3);
  }
}

_id_7E6D() {
  var_0 = undefined;

  if(usingplayer()) {
    var_1 = self._id_1652.player;
    var_0 = gettime() + var_1.gs._id_D396 + randomint(var_1.gs._id_D397);
  } else
    var_0 = gettime() + 30000 + randomint(30000);

  return var_0;
}

_id_7EE9(var_0) {
  if(var_0.isplayertimer) {
    return var_0.player.grenadetimers[var_0.timername];
  } else {
    return anim.grenadetimers[var_0.timername];
  }
}

_id_453D(var_0) {
  if(!isPlayer(var_0) && self isbadguy()) {
    if(gettime() < _id_7EE9(self._id_1652)) {
      if(level.player.ignoreme) {
        return var_0;
      }

      var_1 = self getthreatbiasgroup();
      var_2 = level.player getthreatbiasgroup();

      if(var_1 != "" && var_2 != "" && getthreatbias(var_2, var_1) < -10000) {
        return var_0;
      }

      if(self cansee(level.player) || isai(var_0) && var_0 cansee(level.player)) {
        if(isDefined(self.covernode)) {
          var_3 = vectortoangles(level.player.origin - self.origin);
          var_4 = angleclamp180(self.covernode.angles[1] - var_3[1]);
        } else
          var_4 = scripts\engine\utility::getyawtospot(level.player.origin);

        if(abs(var_4) < 60) {
          var_0 = level.player;
          _id_F62B(var_0);
        }
      }
    }
  }

  return var_0;
}

_id_B4EF(var_0) {
  if(scripts\sp\utility::_id_D022()) {
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

_id_BE18() {
  return gettime() >= self.a.nextgrenadetrytime;
}

_id_85B5(var_0) {
  if(scripts\sp\utility::_id_D022()) {
    return 0;
  }

  if(self.script_forcegrenade == 1) {
    return 1;
  }

  if(!_id_BE18()) {
    return 0;
  }

  if(gettime() >= _id_7EE9(self._id_1652)) {
    return 1;
  }

  if(self._id_1652.isplayertimer && self._id_1652.timername == "fraggrenade") {
    return _id_B4EF(var_0);
  }

  return 0;
}

_id_128A1(var_0, var_1, var_2, var_3) {
  if(!self _meth_81A2(var_0, var_1)) {
    return 0;
  } else if(distancesquared(self.origin, var_1) < 40000) {
    return 0;
  }

  var_4 = physicstrace(var_1 + (0, 0, 1), var_1 + (0, 0, -500));

  if(var_4 == var_1 + (0, 0, -500)) {
    return 0;
  }

  var_4 = var_4 + (0, 0, 0.1);
  return trygrenadethrow(var_0, var_4, var_2, var_3);
}

_id_128A0(var_0, var_1) {
  if(self.weapon == "mg42" || self.grenadeammo <= 0) {
    return 0;
  }

  _id_F62B(var_0);
  var_0 = _id_453D(var_0);

  if(!_id_85B5(var_0)) {
    return 0;
  }

  var_2 = _id_7EE8(var_1);

  if(isDefined(self.enemy) && var_0 == self.enemy) {
    if(!_id_3E1C()) {
      return 0;
    }

    if(scripts\anim\utility_common::canseeenemyfromexposed()) {
      if(!self _meth_81A2(var_0, var_0.origin)) {
        return 0;
      }

      return trygrenadethrow(var_0, undefined, var_1, var_2);
    } else if(scripts\anim\utility_common::cansuppressenemyfromexposed())
      return _id_128A1(var_0, scripts\anim\utility::_id_7E90(), var_1, var_2);
    else {
      if(!self _meth_81A2(var_0, var_0.origin)) {
        return 0;
      }

      return trygrenadethrow(var_0, undefined, var_1, var_2);
    }

    return 0;
  } else
    return _id_128A1(var_0, var_0.origin, var_1, var_2);
}

trygrenadethrow(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {}

_id_DE37(var_0) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill("killanimscript");
  var_0.numgrenadesinprogresstowardsplayer--;
}

_id_58BA(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");

  if(self.script == "combat" || self.script == "move") {
    self orientmode("face direction", var_1);
  }

  scripts\anim\battlechatter_ai::_id_67CF(self.grenadeweapon);
  self notify("stop_aiming_at_enemy");
  self _meth_82E4("throwanim", var_0, %body, _id_6B9A(), 0.1, 1);
  thread scripts\anim\notetracks::donotetracksforever("throwanim", "killanimscript");
  var_4 = scripts\anim\utility_common::getgrenademodel();
  var_5 = "none";

  for(;;) {
    self waittill("throwanim", var_6);

    if(var_6 == "grenade_left" || var_6 == "grenade_right") {
      var_5 = _id_2481(var_4, "TAG_INHAND");
      self._id_9E33 = 1;
    }

    if(var_6 == "grenade_throw" || var_6 == "grenade throw") {
      break;
    }

    if(var_6 == "end") {
      self._id_1652.player.numgrenadesinprogresstowardsplayer--;
      self notify("dont_reduce_giptp_on_killanimscript");
      return 0;
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");

  if(usingplayer()) {
    thread _id_13A98(self._id_1652.player, var_2);
  }

  self _meth_83C2();

  if(!usingplayer()) {
    _id_F72C(self._id_1652, var_2);
  }

  if(var_3) {
    var_13 = self._id_1652.player;

    if(var_13.numgrenadesinprogresstowardsplayer > 1 || gettime() - var_13._id_A990 < 2000) {
      var_13.grenadetimers["double_grenade"] = gettime() + min(5000, var_13.gs._id_D382);
    }
  }

  self notify("stop grenade check");

  if(var_5 != "none") {
    self detach(var_4, var_5);
  } else {}

  self._id_9E33 = undefined;
  self.grenadeawareness = self._id_C3F3;
  self._id_C3F3 = undefined;
  self waittillmatch("throwanim", "end");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
  self _meth_82A2(%exposed_modern, 1, 0.2);
  self _meth_82A2(%exposed_aiming, 1);
  self clearanim(var_0, 0.2);
}

_id_13A98(var_0, var_1) {
  var_0 endon("death");
  _id_13A99(var_1);
  var_0.numgrenadesinprogresstowardsplayer--;
}

_id_13A99(var_0) {
  var_1 = self._id_1652;
  var_2 = spawnStruct();
  var_2 thread _id_13A9A(5);
  var_2 endon("watchGrenadeTowardsPlayerTimeout");
  var_3 = self.grenadeweapon;
  var_4 = _id_7EE6();

  if(!isDefined(var_4)) {
    return;
  }
  _id_F72C(var_1, min(gettime() + 5000, var_0));
  var_5 = 62500;
  var_6 = 160000;

  if(var_3 == "flash_grenade") {
    var_5 = 810000;
    var_6 = 1690000;
  }

  var_7 = level.players;
  var_8 = var_4.origin;

  for(;;) {
    wait 0.1;

    if(!isDefined(var_4)) {
      break;
    }

    if(distancesquared(var_4.origin, var_8) < 400) {
      var_9 = [];

      for(var_10 = 0; var_10 < var_7.size; var_10++) {
        var_11 = var_7[var_10];
        var_12 = distancesquared(var_4.origin, var_11.origin);

        if(var_12 < var_5) {
          var_11 _id_85C8(var_1, var_0);
          continue;
        }

        if(var_12 < var_6) {
          var_9[var_9.size] = var_11;
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

_id_85C8(var_0, var_1) {
  var_2 = self;
  anim._id_11813 = undefined;

  if(gettime() - var_2._id_A990 < 3000) {
    var_2.grenadetimers["double_grenade"] = gettime() + var_2.gs._id_D382;
  }

  var_2._id_A990 = gettime();
  var_3 = var_2.grenadetimers[var_0.timername];
  var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
}

_id_7EE6() {
  self endon("killanimscript");
  self waittill("grenade_fire", var_0);
  return var_0;
}

_id_13A9A(var_0) {
  wait(var_0);
  self notify("watchGrenadeTowardsPlayerTimeout");
}

_id_2481(var_0, var_1) {
  self attach(var_0, var_1);
  thread _id_5392(var_0, var_1);
  return var_1;
}

_id_5392(var_0, var_1) {
  self endon("stop grenade check");
  self waittill("killanimscript");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_C3F3)) {
    self.grenadeawareness = self._id_C3F3;
    self._id_C3F3 = undefined;
  }

  self detach(var_0, var_1);
}

_id_C371(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoup(self.angles);
  var_1 = var_1 * var_0[0];
  var_2 = var_2 * var_0[1];
  var_3 = var_3 * var_0[2];
  return var_1 + var_2 + var_3;
}

_id_85C9(var_0, var_1) {
  level notify("armoffset");
  level endon("armoffset");
  var_0 = self.origin + _id_C371(var_0);

  for(;;) {
    wait 0.05;
  }
}

_id_7EE3() {
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

_id_5D29() {
  var_0 = self gettagorigin("tag_accessory_right");
  var_1 = _id_7EE3();
  self _meth_81EE(var_0, var_1, 3);
}

_id_B019() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(self.fixednode || self.doingambush) {
    return 0;
  }

  var_0 = _id_7DFB();

  if(isDefined(var_0)) {
    return _id_13059(var_0);
  }

  return 0;
}

_id_7DFB() {
  var_0 = self _meth_80E3();

  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = scripts\anim\utility_common::_id_7E28();

  if(isDefined(var_1) && var_0 == var_1) {
    return undefined;
  }

  if(isDefined(self.covernode) && var_0 == self.covernode) {
    return undefined;
  }

  return var_0;
}

_id_13059(var_0) {
  var_1 = self.keepclaimednodeifvalid;
  var_2 = self.keepclaimednode;
  self.keepclaimednodeifvalid = 0;
  self.keepclaimednode = 0;

  if(self _meth_83D4(var_0)) {
    return 1;
  } else {}

  self.keepclaimednodeifvalid = var_1;
  self.keepclaimednode = var_2;
  return 0;
}

_id_10026() {
  if(level._id_18D5[self.team] > 0 && level._id_18D5[self.team] < level._id_18D6) {
    if(gettime() - level._id_A936[self.team] > 4000) {
      return 0;
    }

    var_0 = level._id_A933[self.team];

    if(var_0 == self) {
      return 0;
    }

    var_1 = isDefined(var_0) && distancesquared(self.origin, var_0.origin) < 65536;

    if((var_1 || distancesquared(self.origin, level._id_A935[self.team]) < 65536) && (!isDefined(self.enemy) || distancesquared(self.enemy.origin, level._id_A934[self.team]) < 262144)) {
      return 1;
    }
  }

  return 0;
}

_id_3DE5() {
  if(!isDefined(level._id_A936[self.team])) {
    return 0;
  }

  if(_id_10026()) {
    return 1;
  }

  if(gettime() - level._id_A936[self.team] < level._id_18D7) {
    return 0;
  }

  if(!issentient(self.enemy)) {
    return 0;
  }

  if(level._id_18D5[self.team]) {
    level._id_18D5[self.team] = 0;
  }

  var_0 = isDefined(self._id_18CC) && self._id_18CC;

  if(!var_0 && getaicount(self.team) < getaicount(self.enemy.team)) {
    return 0;
  }

  return 1;
}

_id_128AA(var_0) {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(self.fixednode) {
    return 0;
  }

  if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") {
    return 0;
  }

  if(!self _meth_81A5(self.enemy.origin)) {
    return 0;
  }

  if(scripts\anim\utility_common::islongrangeai()) {
    return 0;
  }

  if(!_id_3DE5()) {
    return 0;
  }

  if(isDefined(self.usingnavmesh) && self.usingnavmesh) {
    return 0;
  }

  self _meth_80E6(var_0);

  if(self _meth_8254()) {
    self.keepclaimednodeifvalid = 0;
    self.keepclaimednode = 0;
    self.a._id_B168 = 1;

    if(level._id_18D5[self.team] == 0) {
      level._id_A936[self.team] = gettime();
      level._id_A933[self.team] = self;
    }

    level._id_A935[self.team] = self.origin;
    level._id_A934[self.team] = self.enemy.origin;
    level._id_18D5[self.team]++;
    return 1;
  }

  return 0;
}

_id_50FB(var_0) {
  self endon("death");
  wait 0.5;
  var_1 = "" + anim._id_2755;
  badplace_cylinder(var_1, 5, var_0, 16, 64, self.team);
  anim._id_2759[anim._id_2759.size] = var_1;

  if(anim._id_2759.size >= 10) {
    var_2 = [];

    for(var_3 = 1; var_3 < anim._id_2759.size; var_3++) {
      var_2[var_2.size] = anim._id_2759[var_3];
    }

    badplace_delete(anim._id_2759[0]);
    anim._id_2759 = var_2;
  }

  anim._id_2755++;

  if(anim._id_2755 > 10) {
    anim._id_2755 = anim._id_2755 - 20;
  }
}

_id_13156(var_0, var_1, var_2) {
  if(var_0 > var_1 && var_0 < var_2) {
    return 1;
  }

  return 0;
}

_id_7EEC() {
  if(!isDefined(self._id_FECF)) {
    return 0;
  }

  var_0 = self getmuzzleangle()[1] - scripts\engine\utility::getyaw(self._id_FECF);
  var_0 = angleclamp180(var_0);
  return var_0;
}

_id_7EEB() {
  if(!isDefined(self._id_FECF)) {
    return 0;
  }

  var_0 = self getmuzzleangle()[0] - vectortoangles(self._id_FECF - self getmuzzlepos())[0];
  var_0 = angleclamp180(var_0);
  return var_0;
}

_id_8062() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  var_0 = self.enemy getshootatpos() - self getshootatpos();
  var_0 = vectorNormalize(var_0);
  var_1 = vectortoangles(var_0)[0];
  return angleclamp180(var_1);
}

_id_8065(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0 - self getshootatpos();
  var_1 = vectorNormalize(var_1);
  var_2 = vectortoangles(var_1)[0];
  return angleclamp180(var_2);
}

_id_8063(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return 0;
  }

  if(isDefined(self) && scripts\engine\utility::actor_is3d()) {
    var_2 = anglesToForward(self.angles);
    var_3 = rotatepointaroundvector(var_2, var_0 - self.origin, self.angles[2] * -1);
    var_0 = var_3 + self.origin;
  }

  var_4 = var_0 - var_1;
  var_4 = vectorNormalize(var_4);
  var_5 = vectortoangles(var_4)[0];
  return angleclamp180(var_5);
}

_id_13B22() {
  self.isreloading = 0;
  self._id_A9DC = -1;

  for(;;) {
    self waittill("reload_start");
    self.isreloading = 1;
    self._id_A9DC = gettime();
    scripts\anim\battlechatter_ai::_id_67D4();
    _id_1383F();
    self.isreloading = 0;
  }
}

_id_1383F() {
  thread _id_118EC(4, "reloadtimeout");
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

_id_118EC(var_0, var_1) {
  self endon(var_1);
  wait(var_0);
  self notify(var_1);
}

_id_3E1C() {
  var_0 = self.enemy.origin - self.origin;
  var_1 = lengthsquared((var_0[0], var_0[1], 0));

  if(self.grenadeweapon == "flash_grenade") {
    return var_1 < 589824;
  }

  return var_1 >= 40000 && var_1 <= 1562500;
}

_id_B9D9() {
  self endon("death");

  if(!isDefined(level._id_BEFB)) {
    self endon("stop_monitoring_flash");
  }

  for(;;) {
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    self waittill("flashbang", var_1, var_0, var_2, var_3, var_4);

    if(isDefined(self._id_6EC4) && self._id_6EC4) {
      continue;
    }
    if(isDefined(self._id_EDE6) && self._id_EDE6 != 0) {
      continue;
    }
    if(isDefined(self.team) && isDefined(var_4) && self.team == var_4) {
      var_0 = 3 * (var_0 - 0.75);

      if(var_0 < 0) {
        continue;
      }
      if(isDefined(self._id_115CE)) {
        continue;
      }
    }

    var_5 = 0.2;

    if(var_0 > 1 - var_5) {
      var_0 = 1.0;
    } else {
      var_0 = var_0 / (1 - var_5);
    }

    var_6 = 4.5 * var_0;

    if(var_6 < 0.25) {
      continue;
    }
    self._id_6ECE = var_4;
    scripts\sp\utility::_id_6EC6(var_6);
    self notify("doFlashBanged", var_1, var_3);
  }
}

_id_6B9A() {
  return 1.5;
}

_id_DCAD() {
  return randomfloatrange(1, 1.2);
}

_id_80B5(var_0) {
  if(var_0.size == 0) {
    return undefined;
  }

  if(var_0.size == 1) {
    return var_0[0];
  }

  if(isDefined(self.a._id_D892) && randomint(100) > 20) {
    foreach(var_3, var_2 in var_0) {
      if(var_2 == self.a._id_D892) {
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

_id_D285() {
  var_0 = self getEye();

  foreach(var_2 in level.players) {
    if(!self cansee(var_2)) {
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