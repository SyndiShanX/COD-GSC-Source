/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2476.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ball_turret_gunner", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("ball_turret_gunner", "init")]]();
  }

  level._id_2178["move"] = getdvarint("#x349c3e053c9d511ca", 180);
  level._id_2178["rotate"] = getdvarint("#x3c21e962ee70d25d4", 60);
  scripts\engine\utility::_id_5C11("allow_context_sensative_dialog");
  scripts\engine\utility::_id_5C1B("allow_context_sensative_dialog");
  var_0 = getEntArray("minimap_corner", "targetname");
  var_1 = (0, 0, 0);

  if(isDefined(level._id_9AAC)) {
    var_1 = level._id_9AAC;
  }

  if(var_0.size) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ball_turret_gunner", "findBoxCenter")) {
      var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("ball_turret_gunner", "findBoxCenter")]](var_0[0].origin, var_0[1].origin);
    }
  }

  level._id_21B8 = spawn("script_model", var_1);
  level._id_21B8 setModel("tag_origin");
  level._id_21B8.angles = (0, 115, 0);
  level._id_21B8.owner = undefined;
  level._id_21B8 hide();
  level._id_21B9 = 0;
  thread _id_C923("on");
  scripts\mp\playeractions::_id_C23B("ballTurretGunnerUse", ["usability", "killstreaks", "supers", "gesture", "weapon_switch", "allow_movement", "shellshock"]);
  _id_7EFB();
  _id_7EFC();
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("ball_turret_gunner", "on", 9);
}

#using_animtree("script_model");

_id_7EFB() {
  level._id_CC34["ball_turret_gunner"] = #animtree;
  level._id_CC31["ball_turret_gunner"]["ball_turret_gunner_death"] = % mp_acharlie130_death;
  level._id_CC32["ball_turret_gunner"]["ball_turret_gunner_death"] = "mp_acharlie130_death";
  level._id_2163 = _func_0079(level._id_CC31["ball_turret_gunner"]["ball_turret_gunner_death"]);
}

_id_7EFC() {
  game["dialog"]["ball_turret_gunner_engage"] = "ball_turret_gunner_engage";
  game["dialog"]["ball_turret_gunner_single_spotted"] = "ball_turret_gunner_single_enemy_spotted";
  game["dialog"]["ball_turret_gunner_multi_spotted"] = "ball_turret_gunner_multi_enemy_spotted";
  game["dialog"]["ball_turret_gunner_good_hit"] = "ball_turret_gunner_hit";
  game["dialog"]["ball_turret_gunner_bad_hit"] = "ball_turret_gunner_miss";
  game["dialog"]["ball_turret_gunner_taking_damage_light"] = "ball_turret_gunner_damage_reaction_10";
  game["dialog"]["ball_turret_gunner_taking_damage_medium"] = "ball_turret_gunner_damage_reaction_30";
  game["dialog"]["ball_turret_gunner_taking_damage_heavy"] = "ball_turret_gunner_damage_reaction_40";
  game["dialog"]["ball_turret_gunner_missile_lock"] = "ball_turret_gunner_missile_lock";
  game["dialog"]["ball_turret_gunner_flares"] = "ball_turret_gunner_launch_flares";
  game["dialog"]["ball_turret_gunner_105mm_reloaded"] = "ball_turret_gunner_reload_105mm";
  game["dialog"]["ball_turret_gunner_40mm_reloaded"] = "ball_turret_gunner_reload_40mm";
  game["dialog"]["ball_turret_gunner_25mm_reloaded"] = "ball_turret_gunner_reload_25mm";
  game["dialog"]["ball_turret_gunner_crashing"] = "ball_turret_gunner_crash";
}

_id_F76C() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("ball_turret_gunner", self);
  return _id_F76D(var_0);
}

_id_F76D(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint("#x3977164f55f7286a2", 1) == 0) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  var_1 = makeweapon("s4_ks_remote_ball_turret_gunner_mp");
  var_2 = _id_09B9::_id_EA05(var_0, undefined, undefined, undefined, undefined, "s4_ks_remote_ball_turret_gunner_mp", 1, 1);

  if(!istrue(var_2)) {
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
  }

  var_3 = 0;

  if(!istrue(var_3)) {}

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(istrue(level._id_21B9)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  if(level.gameended) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  var_4 = _id_217A(self, var_0);

  if(!istrue(var_4)) {
    return 0;
  }

  return var_4;
}

_id_2171(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_0 endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]();
  }

  self waittill("killstreakExit");
  thread _id_216C(var_0);
}

_id_217A(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(level._id_21BA)) {
    return 0;
  }

  var_2 = 180;
  var_3 = getdvarint("#x33652b41c2f9a74f5", 9000);
  var_4 = cos(var_2) * var_3;
  var_5 = sin(var_2) * var_3;
  var_6 = getdvarint("#x37a9a1c1030528402", 8000);
  var_7 = vectornormalize((var_4, var_5, var_6));
  var_7 = var_7 * var_6;
  level._id_21B9 = 1;

  if(scripts\common\utility::iscp()) {
    var_0._id_E631 = var_0.origin;
  }

  var_8 = 0;

  if(!var_8) {
    var_0 _id_215D(0);
  }

  var_9 = _id_2176(var_0, var_1, var_2, var_7);

  if(!isDefined(var_9)) {
    level._id_21B9 = 0;
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_ball_turret_gunner", var_0);
  }

  if(getdvarint("#x36c8f5946a1247e70")) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setThirdPersonDOF")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setThirdPersonDOF")]](0);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_9.streakinfo.streakname, "Killstreak_Air", var_0);
  }

  scripts\cp_mp\utility\weapon_utility::_id_D5E7(var_9, ::_id_216E);
  scripts\cp_mp\utility\weapon_utility::_id_D5E8(var_9, ::_id_216F);

  if(!var_8) {
    var_0 scripts\common\utility::_id_1593(0);
  }

  var_9 thread _id_215F(var_0);
  var_9 thread _id_2188(var_0);
  var_9 thread _id_2181(var_0);
  var_9 thread _id_2187(var_0);
  var_9 thread _id_2183(var_0);
  var_9 thread _id_2185(var_0, "disconnect");
  var_9 thread _id_2185(var_0, "joined_team");
  var_9 thread _id_2185(var_0, "joined_spectators");
  var_9 thread _id_2185(var_0, "team_kill_punish");
  var_9 thread _id_2182(var_0);
  var_9 thread _id_216D();
  var_9 thread _id_2171(var_0);
  var_9 thread _id_217B(var_0);
  var_9 thread _id_2186(var_0);
  var_9 thread _id_2184(var_0);
  var_9 thread ball_turret_gunner_watchisfiring(var_0);
  thread _id_084C::ball_turret_gunner_vehicle_loop(var_9, self);
  return 1;
}

ball_turret_gunner_watchisfiring(var_0) {
  var_0 endon("crashing");
  var_0 endon("leaving");
  level endon("game_ended");
  self waittill("gunner_attached");

  if(!isDefined(self._id_F81F)) {
    return;
  }
  for(;;) {
    self._id_F81F waittill("turret_fire");
    var_0 setclientomnvar("ui_ac130_firing", 1);
  }
}

_id_216E() {
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("ball_turret_gunner_missile_lock");
  _id_09CA::_id_10390("missileLocking", self.owner, "killstreak");
}

_id_216F() {
  _id_09CA::_id_1037B("missileLocking", self.owner, "killstreak");
}

_id_2175(var_0) {
  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](self.streakinfo);
  }

  if(isDefined(var_0)) {
    var_1 = 0;

    if(!var_1) {
      var_0 _id_09C8::_id_0D89();
      var_0 scripts\mp\playeractions::_id_1596("ballTurretGunnerUse", 1);
      var_0 _id_215D(1);
    }

    var_0 setclientomnvar("ui_killstreak_thermal_mode", 0);
    var_0 visionsetthermalforplayer("");
    var_0 scripts\cp_mp\utility\player_utility::_id_D720(0);
    var_0 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(self.streakinfo.streakname, "off");
    var_0 setclientomnvar("ui_ac130_hud", 0);
    var_0 stoploopsound();
    var_0 visionsetkillstreakforplayer("");
    var_0 _meth_8078(0.5);
    var_0 painvisionon();
    var_0 _id_09C8::_id_0D89();
    var_0 scripts\cp_mp\utility\killstreak_utility::_id_8DBA();

    if(!var_1) {
      var_0 scripts\cp_mp\utility\killstreak_utility::_id_C14A(self._id_F81F.streakinfo);
      var_0.streakinfo = undefined;
      var_0 _meth_8290(self._id_F81F);
      self._id_F81F delete();
    }

    var_0._id_FF07 = undefined;

    if(getdvarint("#x36c8f5946a1247e70")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setThirdPersonDOF")) {
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setThirdPersonDOF")]](1);
      }
    }

    if(!var_1) {
      var_0 thread _id_2174(self.streakinfo);
      var_0 unlink();
    }

    if(isDefined(var_0._id_2160)) {
      var_0._id_2160 delete();
    }
  }

  _id_216F();

  if(isDefined(self._id_542C)) {
    _id_079B::_id_EEDE(self._id_542C);
  }

  if(isDefined(self._id_5FBD)) {
    _id_079B::_id_EEDE(self._id_5FBD);
  }

  level._id_21B9 = 0;
  setomnvar("lgt_ball_turret_killstreak_in_progress", 0);
}

_id_2174(var_0) {
  self endon("disconnect");
  var_0 notify("killstreak_finished_with_deploy_weapon");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::_id_153E(0);
    wait 0.05;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self._id_8FC2);
    wait 0.767;
    scripts\cp_mp\utility\inventory_utility::_takeweapon("s4_ks_tw_ball_turret_gunner_mp");
    scripts\common\utility::_id_153E(1);
    scripts\common\utility::_id_1593(1);
  }
}

_id_2181(var_0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self._id_014E = 0;
  self._id_1E2E = _func_014B(self, 1000, 4096);

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    thread _id_084C::ball_turret_gunner_shotat(self);
    var_11 = 0;

    if(isDefined(level.teambased) && isPlayer(var_2) && var_2.team == self.team && getdvarint("#x3e0ef8627be45090a", 0) == 0 && (!isDefined(var_11) || !var_11)) {
      continue;
    }
    if(isDefined(self.owner) && self.owner _id_8AC5()) {
      var_12 = "light";

      if(_func_010F(var_5)) {
        if(_func_0037(var_1 / self.maxhealth) >= 0.166667) {
          self.owner earthquakeforplayer(0.25, 0.2, self._id_2FF8.origin, 150);
          self.owner playrumbleonentity("damage_heavy");
          var_12 = "heavy";
        } else {
          self.owner earthquakeforplayer(0.15, 0.15, self._id_2FF8.origin, 150);
          self.owner playrumbleonentity("damage_light");
        }
      }
    }

    self._id_10A0C = 1;
    var_13 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
      var_13 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var_2, var_10, var_5, var_1, self.maxhealth, 4, 5, 6);
    }

    if(isPlayer(var_2)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakHit")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakHit")]](var_2, var_10, self, var_5, var_13);
    }

    if(isDefined(var_2.owner) && isPlayer(var_2.owner)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
        var_2.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }
    }

    self._id_014E = self._id_014E + var_13;
    self._id_41CA = self.maxhealth - self._id_014E;

    if(isDefined(self.owner) && self.owner _id_8AC5()) {
      var_0 setclientomnvar("ui_killstreak_health", self._id_41CA / self.maxhealth);
    }

    if(self._id_41CA <= 2000 && self._id_41BE == 0) {
      self._id_41BE = 1;
      self setscriptablepartstate("body_damage_light", "on");

      if(isDefined(self.owner) && self.owner _id_8AC5()) {
        self.owner scripts\cp_mp\utility\killstreak_utility::_id_B86F("ball_turret_gunner_taking_damage_light");
      }
    } else if(self._id_41CA <= 1000 && self._id_41BE == 1) {
      self._id_41BE = 2;
      self setscriptablepartstate("body_damage_light", "off");
      self setscriptablepartstate("body_damage_medium", "on");

      if(isDefined(self.owner) && self.owner _id_8AC5()) {
        self.owner scripts\cp_mp\utility\killstreak_utility::_id_B86F("ball_turret_gunner_taking_damage_medium");
        thread _id_084C::ball_turret_gunner_damaged(self);
        thread _id_084C::ball_turret_gunner_damage_explosion(self);
      }
    } else if(self._id_41CA <= 500 && self._id_41BE == 2) {
      self._id_41BE = 3;
      self setscriptablepartstate("body_damage_medium", "off");
      self setscriptablepartstate("contrails", "off");
      thread _id_2179();

      if(isDefined(self.owner) && self.owner _id_8AC5()) {
        self.owner scripts\cp_mp\utility\killstreak_utility::_id_B86F("ball_turret_gunner_taking_damage_heavy");
      }
    }

    if(self._id_014E >= self.maxhealth) {
      var_14 = self.streakinfo.streakname;
      var_15 = undefined;
      var_16 = "destroyed_" + var_14;
      var_17 = undefined;
      var_18 = "callout_destroyed_" + var_14;
      var_19 = 1;

      if(isPlayer(var_2)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
          thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var_18, var_2);
        }
      }

      thread _id_2161(8, var_0);
    }
  }
}

_id_2179() {
  level endon("game_ended");
  self._id_91A2 setscriptablepartstate("engine_blowout", "on");
  self._id_91A2 setscriptablepartstate("body_damage_heavy", "on");
  var_0 = randomfloatrange(0.5, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self._id_C868 setscriptablepartstate("engine_blowout", "on");
  self._id_C868 setscriptablepartstate("body_damage_heavy", "on");
  thread _id_084C::ball_turret_gunner_damage_explosion(self);
}

_id_2187(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(self._id_F224);
  thread _id_216C(var_0);
}

_id_2183(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level waittill("game_ended");
  thread _id_216C(var_0);
}

_id_216C(var_0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self notify("leaving");
  self unlink();
  self rotateroll(30, 3);
  var_1 = self.angles;
  var_2 = anglesToForward(var_1);

  if(isDefined(self.owner)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_B86F("timeout_ballTurretGunner", 1);
  }

  thread _id_084C::ball_turret_gunner_exit(self);
  _id_2175(var_0);
  self moveto(self.origin + var_2 * 50000, 10, 5);
  _id_2180(self.origin + var_2 * 50000);
  _id_2173(0);
}

_id_2180(var_0) {
  while(isDefined(self) && self.origin != var_0) {
    waitframe();
  }
}

_id_2185(var_0, var_1) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  var_0 waittill(var_1);
  thread _id_2161(8, var_0);
}

_id_2182(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var_0 endon("disconnect");
  level waittill("game_ended");
  var_0 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(self.streakinfo.streakname, "off");
  var_0 setclientomnvar("ui_ac130_hud", 0);
}

_id_217B(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  self._id_04DF = (0, 0, 0);

  for(;;) {
    self._id_9023 = self.origin;
    wait(level._id_5F3A);
    self._id_04DF = (self.origin - self._id_9023) / level._id_5F3A;
  }
}

_id_2176(var_0, var_1, var_2, var_3) {
  var_4 = "plane_boscar17_01";

  if(scripts\cp_mp\utility\player_utility::_id_6C67(var_0)) {
    var_4 = "plane_boscar17_01";
  }

  var_5 = spawn("script_model", level._id_21B8.origin);
  var_5 setModel(var_4);
  var_5 setCanDamage(1);
  var_5._id_41CA = getdvarint("#x3115c51de8c6e113", 4000);
  var_5.maxhealth = var_5._id_41CA;
  var_5.health = 99999;
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5._id_F224 = getdvarint("#x325a52bc18ebc7a83", 60);
  var_5._id_41BE = 0;
  var_5 _id_0812::_id_C2B2("Killstreak_Air", var_0, undefined, undefined, 1, 0);
  var_5.streakinfo = var_1;
  var_5 _meth_856D();
  var_5 _meth_85AF();
  var_5 setotherent(var_0);
  var_5 _meth_8851(3, var_0.team);
  var_8 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_8 = var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", var_5.team, 1, 1, 1);
  }

  var_5._id_9F26 = var_8;
  var_5.origin = level._id_21B8.origin + var_3;
  var_5.angles = (0, var_2 + 90, -30);
  var_5 linkto(level._id_21B8, "tag_origin");
  level notify("matchrecording_plane", var_5);
  return var_5;
}

_id_2177(var_0, var_1) {
  self._id_F81F = spawnturret("misc_turret", self gettagorigin("tag_turret"), "s4_ks_tw_ball_turret_gunner_mp");
  self._id_F81F setModel("usa_boscar17_ballturret_00");
  self._id_F81F.owner = var_0;
  self._id_F81F.team = var_0.team;
  self._id_F81F.streakinfo = var_1;
  self._id_F81F.origin = self gettagorigin("tag_turret") - (0, 0, 50);
  self._id_F81F linkto(self);
  self._id_F81F.angles = vectortoangles(level._id_21B8.origin - self._id_F81F.origin);
  self._id_F81F _meth_83A0(self.team);
  self._id_F81F _meth_839D(0);
  self._id_F81F setmode("manual");
  self._id_F81F setentityowner(var_0);
  self._id_F81F setotherent(var_0);

  foreach(var_3 in level.players) {
    if(var_3 != var_0) {
      self._id_F81F hidefromplayer(var_3);
    }
  }

  self._id_F81F.health = 99999;
  self._id_F81F.maxhealth = 1000;
  self._id_F81F._id_014E = 0;
  self._id_F81F._id_EAAB = 0;
  self._id_F81F._id_EAAC = 0.0;
  self._id_F81F setCanDamage(0);
  self._id_F81F _meth_82F2(0);
  self._id_F81F _meth_839C(0);
  self._id_F81F._id_3643 = self;
  self._id_F81F._id_C316 = 0;
  self._id_F81F._id_5803 = spawn("script_model", self._id_F81F.origin);
  self._id_F81F._id_5803 setModel("plane_boscar17_00_tur_main");
  self._id_F81F._id_5803 linkto(self, "", (0, 0, 0), (0, 0, 0));
  self._id_F81F._id_5803 hidefromplayer(var_0);
}

_id_217D(var_0) {
  var_0 endon("death");
  var_0 endon("crashing");
  var_0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  thread _id_217E(var_0);
  thread _id_217F(var_0);
  thread _id_217C(var_0);
}

_id_217E(var_0) {
  var_0 endon("death");
  var_0 endon("crashing");
  var_0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self setclientomnvar("ui_ac130_coord1_posx", int(var_0.origin[0]));
    self setclientomnvar("ui_ac130_coord1_posy", int(var_0.origin[1]));
    self setclientomnvar("ui_ac130_coord1_posz", int(var_0.origin[2]));
    wait 0.5;
  }
}

_id_217F(var_0) {
  var_0 endon("death");
  var_0 endon("crashing");
  var_0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  waitframe();
  self setclientomnvar("ui_ac130_coord2_posx", int(self.origin[0]));
  self setclientomnvar("ui_ac130_coord2_posy", int(self.origin[1]));
  self setclientomnvar("ui_ac130_coord2_posz", int(self.origin[2]));
}

_id_217C(var_0) {
  var_0 endon("death");
  var_0 endon("crashing");
  var_0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_1 = self getvieworigin();
    var_2 = var_1 + anglesToForward(self getplayerangles()) * 15000;
    var_3 = _func_0198(var_1, var_2);
    self setclientomnvar("ui_ac130_coord3_posx", int(var_3[0]));
    self setclientomnvar("ui_ac130_coord3_posy", int(var_3[1]));
    self setclientomnvar("ui_ac130_coord3_posz", int(var_3[2]));
    wait 0.1;
  }
}

_id_C923(var_0) {
  level notify("stop_rotatePlane_thread");
  level endon("stop_rotatePlane_thread");

  if(var_0 == "on") {
    var_1 = 10;
    var_2 = level._id_2178["rotate"] / 360 * var_1;
    level._id_21B8 rotateyaw(level._id_21B8.angles[2] + var_1, var_2, var_2, 0);
    var_3 = 360 / level._id_2178["rotate"];
    var_4 = var_3 * 0.0174533;
    var_5 = getdvarint("#x33652b41c2f9a74f5", 9000);
    level._id_2170 = var_4 * var_5;

    for(;;) {
      level._id_21B8 rotateyaw(360, level._id_2178["rotate"]);
      wait(level._id_2178["rotate"]);
    }
  } else if(var_0 == "off") {
    var_6 = 10;
    var_2 = level._id_2178["rotate"] / 360 * var_6;
    level._id_21B8 rotateyaw(level._id_21B8.angles[2] + var_6, var_2, 0, var_2);
  } else if(var_0 == "crash") {
    var_1 = 50;
    var_2 = level._id_2178["rotate"] / 360 * var_1;
    level._id_21B8 rotateyaw(level._id_21B8.angles[2] + var_1, var_2, var_2, 0);
  }
}

_id_215F(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  waitframe();
  setomnvar("lgt_ball_turret_killstreak_in_progress", 1);
  self._id_2FF8 = spawn("script_model", self.origin);
  self._id_2FF8 setModel("tag_player");
  self._id_2FF8.angles = vectortoangles(level._id_21B8.origin - self._id_2FF8.origin);
  _id_2177(var_0, self.streakinfo);

  if(isbot(var_0)) {
    var_0 cameralinkto(self._id_2FF8, "tag_player");
  } else {
    var_0 scripts\cp_mp\utility\killstreak_utility::_id_B86F("ball_turret_gunner_engage");
    var_0._id_FF07 = 1;

    if(isDefined(level._id_8DED)) {
      var_0 visionsetkillstreakforplayer(level._id_8DED);
    }

    var_0 _meth_82FA("ac130_killstreak");
    var_0 unlink();
    var_0 _meth_8060();
    var_0.streakinfo = self.streakinfo;
    var_0 _meth_828F(self._id_F81F);
    var_0 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(self.streakinfo.streakname, "on");
    var_0 setclientomnvar("ui_ac130_hud", 1);
    var_0 setclientomnvar("ui_killstreak_countdown", gettime() + int(self._id_F224 * 1000));
    var_0 setclientomnvar("ui_killstreak_health", self.maxhealth);
    var_0 _id_09C8::_id_0CF9("killstreak_veh_camera_mp", "top", self._id_F224, 0);
    var_0 _id_09C8::_id_0D89();
    var_0 scripts\mp\playeractions::_id_1596("ballTurretGunnerUse", 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("ball_turret_gunner", "assignTargetMarkers")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("ball_turret_gunner", "assignTargetMarkers")]](var_0);
    }

    var_0 thread _id_217D(self);
  }

  self notify("gunner_attached");
}

_id_2188(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  var_2 = self.streakinfo;

  for(;;) {
    var_3 = var_0 getcurrentweapon();
    var_4 = var_0 getweaponammoclip(var_3);

    if(var_4 == 0) {
      var_0 thread _id_2189(var_3, self);
    }

    waitframe();
  }
}

_id_2189(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("crashing");
  var_1 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = weaponmaxammo(var_0);
  self setweaponammoclip(var_0, var_2);
}

_id_475A(var_0) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self delete();
}

_id_2161(var_0, var_1) {
  self notify("crashing");
  self._id_3E66 = 1;
  _id_2175(var_1);
  thread _id_2172(var_0);
}

_id_2172(var_0) {
  level endon("game_ended");
  self._id_91A2 setscriptablepartstate("engine_blowout", "off");
  self._id_C868 setscriptablepartstate("engine_blowout", "off");
  thread _id_084C::ball_turret_gunner_explosion(self.origin);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  self._id_91A2 setscriptablepartstate("engine_blowout", "on");
  self._id_C868 setscriptablepartstate("engine_blowout", "on");
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_B86F("ball_turret_gunner_crashing", 1);
  self unlink();
  self._id_CBD0 = spawn("script_model", self.origin);
  self._id_CBD0 setModel("tag_origin");
  self._id_CBD0.angles = vectortoangles(anglesToForward(self.angles));
  self._id_91A2 setscriptablepartstate("engine_blowout", "off");
  self._id_C868 setscriptablepartstate("engine_blowout", "off");
  self._id_91A2 setscriptablepartstate("body_damage_heavy", "off");
  self._id_C868 setscriptablepartstate("body_damage_heavy", "off");
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("ks_ac130_mp_mesh");
  var_1.angles = self.angles;
  var_1._id_18AF = "ball_turret_gunner";
  var_1 _id_06C6::_id_D47B();
  var_2 = spawn("script_model", var_1.origin);
  var_2.angles = var_1.angles;
  var_2 setModel("plane_boscar17_vista_des");
  var_2 linkto(var_1, "tag_body");
  self.crashmodel = var_2;
  var_3 = spawn("script_model", self.origin);
  var_3 setModel("ks_ac130_mp");
  var_3.angles = self.angles;
  var_3._id_18AF = self.streakinfo.streakname;
  var_3 _id_06C6::_id_D47B();
  var_3 linkto(var_1, "tag_body", (0, 0, -10), (0, 0, 0));
  var_4 = self.origin + anglesToForward(self.angles) * 3000 - (0, 0, 8000);
  var_6 = "crash_air";
  var_3 setscriptablepartstate(var_6, "on", 0);
  var_1 thread _id_2162();
  thread _id_084C::ball_turret_gunner_explosion2(var_1);
  var_7 = 0;
  thread _id_2166();
  thread _id_2165(var_7);
  thread _id_2164(var_7);
  wait 0.5;
  self._id_CBD0 delete();
  _id_2173(1);
}

_id_2166() {
  level endon("game_ended");
  wait 0.05;
  self hide();
}

_id_2165(var_0) {
  level endon("game_ended");
  var_1 = max(var_0 - 2, 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_3 earthquakeforplayer(0.25, 2, self.origin, 30000);
    }
  }
}

_id_2164(var_0) {
  level endon("game_ended");
  var_1 = max(var_0 - 3, 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  _id_09C1::_id_B8A7();
}

_id_2162() {
  waitframe();
}

_id_2173(var_0) {
  if(isDefined(self._id_5CA8)) {
    self._id_5CA8 delete();
  }

  if(isDefined(self._id_2FF8)) {
    self._id_2FF8 delete();
  }

  if(isDefined(self._id_91A2)) {
    self._id_91A2 delete();
  }

  if(isDefined(self._id_C868)) {
    self._id_C868 delete();
  }

  if(isDefined(self._id_945F)) {
    self._id_945F delete();
  }

  if(isDefined(self._id_9F26)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self._id_9F26);
    }

    self._id_9F26 = undefined;
  }

  self.streakinfo._id_57A7 = istrue(var_0);

  if(isDefined(self.owner)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(self.streakinfo);
  }

  if(isDefined(self.crashmodel)) {
    self.crashmodel delete();
  }

  self delete();
}

_id_8AC5() {
  return isDefined(self._id_FF07);
}

_id_216D() {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  var_0 = self gettagorigin("tag_wing_l_fx");
  self._id_91A2 = spawn("script_model", var_0);
  self._id_91A2 setModel("ks_ac130_mp");
  self._id_91A2.angles = self.angles;
  self._id_91A2 setotherent(self.owner);
  self._id_91A2 linkto(self, "tag_wing_l_fx", (0, 0, 0), (0, 0, 0));
  var_1 = self gettagorigin("tag_wing_r_fx");
  self._id_C868 = spawn("script_model", var_1);
  self._id_C868 setModel("ks_ac130_mp");
  self._id_C868.angles = self.angles;
  self._id_C868 setotherent(self.owner);
  self._id_C868 linkto(self, "tag_wing_r_fx", (0, 0, 0), (0, 0, 0));
  self setscriptablepartstate("contrails", "on");
}

_id_2186(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_0 endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  for(;;) {
    var_1 = [];

    foreach(var_3 in level.players) {
      if(!isDefined(var_3) || !var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(self.owner _meth_845E(var_3.origin, 80, 100)) {
        if(level.teambased && var_3.team == self.team) {
          continue;
        }
        if(var_3 == self.owner) {
          continue;
        }
        if(!scripts\cp_mp\utility\killstreak_utility::_id_E9FD(self.origin, var_3 gettagorigin("j_spineupper"), self)) {
          continue;
        }
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          if(var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
            continue;
          }
        }

        var_1 = _id_216A(var_3);
        break;
      }

      wait 0.05;
    }

    if(var_1.size > 0 && var_1.size < 2) {
      var_0 scripts\cp_mp\utility\killstreak_utility::_id_B86F("ball_turret_gunner_single_spotted");
    } else if(var_1.size >= 2) {
      var_0 scripts\cp_mp\utility\killstreak_utility::_id_B86F("ball_turret_gunner_multi_spotted");
    }

    wait(randomintrange(5, 15));
  }
}

_id_216A(var_0) {
  var_1 = scripts\common\utility::_id_B7BF(var_0.origin, 300);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(level.teambased && var_4.team != var_0.team) {
      continue;
    }
    if(!level.teambased && var_4 == self.owner) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_2184(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    self.owner waittill("update_rapid_kill_buffered", var_1, var_2);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

    if(isDefined(self.owner._id_C0F3)) {
      if(self.owner._id_C0F3 >= 1 && _id_216B(var_2)) {
        scripts\cp_mp\utility\killstreak_utility::_id_B86F("ball_turret_gunner_good_hit");
      }
    }
  }
}

_id_216B(var_0) {
  return scripts\engine\utility::ter_op(isDefined(var_0) && var_0 == "s4_ks_tw_ball_turret_gunner_mp", 1, 0);
}

_id_215D(var_0) {
  self._id_2167 = [];

  if(!istrue(var_0)) {
    var_1 = self getstance();

    switch (var_1) {
      case "stand":
        self._id_2167 = ["crouch", "prone"];
        break;
      case "crouch":
        self._id_2167 = ["stand", "prone"];
        break;
      case "prone":
        self._id_2167 = ["stand", "crouch"];
        break;
    }

    scripts\mp\playeractions::_id_C23B("ballTurretGunnerStance", self._id_2167);
    scripts\mp\playeractions::_id_1596("ballTurretGunnerStance", 0);
  } else
    scripts\mp\playeractions::_id_1596("ballTurretGunnerStance", 1);
}