/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2484.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "init")]]();
  }

  level._effect["clouds"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_view_clouds.vfx");
  level._effect["gunship_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_flares.vfx");
  level._effect["camera_shutter"] = loadfx("vfx/iw8_mp/killstreak/vfx_ui_camera_shutter.vfx");
  level._effect["camera_spotlight"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_ir_spotlight.vfx");
  level._id_3D8F = [];
  level._id_3D8F["45"] = cos(45);
  level._id_3D8F["5"] = cos(5);
  level._id_B054["ac130_25mm_mp"] = 60;
  level._id_B054["ac130_40mm_mp"] = 600;
  level._id_B054["ac130_105mm_mp"] = 1000;
  level._id_B053["ac130_25mm_mp"] = 0;
  level._id_B053["ac130_40mm_mp"] = 3.0;
  level._id_B053["ac130_105mm_mp"] = 6.0;
  level._id_10DC7["ac130_25mm_mp"] = 2;
  level._id_10DC7["ac130_40mm_mp"] = 4;
  level._id_10DC7["ac130_105mm_mp"] = 6;
  level._id_72F9["move"] = 250;
  level._id_72F9["rotate"] = 120;
  scripts\engine\utility::_id_5C11("allow_context_sensative_dialog");
  scripts\engine\utility::_id_5C1B("allow_context_sensative_dialog");
  var_0 = getEntArray("minimap_corner", "targetname");
  var_1 = level._id_9AAC;

  if(var_0.size) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "findBoxCenter")) {
      var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "findBoxCenter")]](var_0[0].origin, var_0[1].origin);
    }
  }

  level._id_72C7 = spawn("script_model", var_1);
  level._id_72C7 setModel("tag_origin");
  level._id_72C7.angles = (0, 115, 0);
  level._id_72C7.owner = undefined;
  level._id_72C7._id_F0F0 = "ac130_thermal_mp";
  level._id_72C7._id_5465 = "ac130_enhanced_mp";
  level._id_72C7._id_0481 = "ac130rig_script_model";
  level._id_72C7 hide();
  level._id_731B = 0;
  level._id_72C7._id_47EE = makeweapon("ks_remote_gunship_mp");
  thread _id_C923("on");
  scripts\mp\playeractions::_id_C23B("gunshipIntro", ["usability", "killstreaks", "supers", "gesture", "fire", "weapon_switch", "allow_movement", "offhand_weapons", "shellshock"]);
  scripts\mp\playeractions::_id_C23B("gunshipUse", ["usability", "killstreaks", "supers", "gesture", "allow_movement", "shellshock"]);
  level._id_731D = [];
  _id_7FA8();
  _id_7FA9();
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("gunship", "on", 9);
}

_id_10D90(var_0) {
  return 1;
}

#using_animtree("script_model");

_id_7FA8() {
  level._id_CC34["gunship"] = #animtree;
  level._id_CC31["gunship"]["gunship_intro"] = % mp_acharlie130_intro;
  level._id_CC32["gunship"]["gunship_intro"] = "mp_acharlie130_intro";
  level._id_CC31["gunship"]["gunship_intro_alt"] = % mp_acharlie130_intro_alt;
  level._id_CC32["gunship"]["gunship_intro_alt"] = "mp_acharlie130_intro_alt";
  level._id_CC31["gunship"]["gunship_intro_long"] = % mp_acharlie130_intro_old;
  level._id_CC32["gunship"]["gunship_intro_long"] = "mp_acharlie130_intro_old";
  level._id_CC31["gunship"]["gunship_death"] = % mp_acharlie130_death;
  level._id_CC32["gunship"]["gunship_death"] = "mp_acharlie130_death";
  level._id_72D0 = _func_0079(level._id_CC31["gunship"]["gunship_death"]);
}

_id_7FA9() {
  game["dialog"]["gunship_engage"] = "gunship_engage";
  game["dialog"]["gunship_single_spotted"] = "gunship_single_enemy_spotted";
  game["dialog"]["gunship_multi_spotted"] = "gunship_multi_enemy_spotted";
  game["dialog"]["gunship_good_hit"] = "gunship_hit";
  game["dialog"]["gunship_bad_hit"] = "gunship_miss";
  game["dialog"]["gunship_taking_damage_light"] = "gunship_damage_reaction_10";
  game["dialog"]["gunship_taking_damage_medium"] = "gunship_damage_reaction_30";
  game["dialog"]["gunship_taking_damage_heavy"] = "gunship_damage_reaction_40";
  game["dialog"]["gunship_missile_lock"] = "gunship_missile_lock";
  game["dialog"]["gunship_flares"] = "gunship_launch_flares";
  game["dialog"]["gunship_105mm_reloaded"] = "gunship_reload_105mm";
  game["dialog"]["gunship_40mm_reloaded"] = "gunship_reload_40mm";
  game["dialog"]["gunship_25mm_reloaded"] = "gunship_reload_25mm";
  game["dialog"]["gunship_crashing"] = "gunship_crash";
}

_id_731A() {
  self endon("disconnect");
  level endon("game_ended");
  self setclientomnvar("ui_airspace_crowded_gunship", 1);

  while(istrue(level._id_731B)) {
    waitframe();
  }

  self setclientomnvar("ui_airspace_crowded_gunship", 0);
}

_id_F783() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("gunship", self);
  return _id_F784(var_0);
}

_id_F784(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_killstreak_ac130");
  }

  var_1 = _id_09B9::_id_EA01(var_0, makeweapon("s4_ks_gesture_generic_mp"));

  if(!istrue(var_1)) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(istrue(level._id_731B)) {
    scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  if(level.gameended) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  var_2 = _id_72FD(self, var_0);

  if(!istrue(var_2)) {
    return 0;
  }

  return var_2;
}

_id_72E9(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_0 endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]();
  }

  self waittill("killstreakExit");
  thread _id_72E3(var_0);
}

_id_72FD(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(level._id_731C)) {
    return 0;
  }

  var_2 = randomint(360);
  var_3 = 9000;
  var_4 = cos(var_2) * var_3;
  var_5 = sin(var_2) * var_3;
  var_6 = 8000;
  var_7 = vectornormalize((var_4, var_5, var_6));
  var_7 = var_7 * var_6;
  level._id_731B = 1;
  thread _id_731A();

  if(scripts\common\utility::iscp()) {
    var_0._id_E631 = var_0.origin;
  }

  var_8 = _id_72EF(var_0, var_1, var_2, var_7);

  if(!isDefined(var_8) || var_8 == 0) {
    level._id_731B = 0;
    return 0;
  }

  var_9 = _id_72F7(var_0, var_1, var_2, var_7);

  if(!isDefined(var_9)) {
    level._id_731B = 0;
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_gunship", var_0);
  }

  if(getdvarint("#x36c8f5946a1247e70")) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setThirdPersonDOF")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setThirdPersonDOF")]](0);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_9.streakinfo.streakname, "Killstreak_Air", var_0);
  }

  scripts\cp_mp\utility\weapon_utility::_id_D5E7(var_9, ::_id_72E6);
  scripts\cp_mp\utility\weapon_utility::_id_D5E8(var_9, ::_id_72E7);
  var_9 thread _id_72CB(var_0);
  var_9 thread _id_7309(var_0);
  var_9 thread _id_7317(var_0);
  var_9 thread _id_7314(var_0);
  var_9 thread _id_730A(var_0);
  var_9 thread _id_7316(var_0);
  var_9 thread _id_730C(var_0);
  var_9 thread _id_7310(var_0, "disconnect");
  var_9 thread _id_7310(var_0, "joined_team");
  var_9 thread _id_7310(var_0, "joined_spectators");
  var_9 thread _id_7310(var_0, "team_kill_punish");
  var_9 thread _id_730B(var_0);
  var_9 thread _id_72F0(var_0);
  var_9 thread _id_72E4();
  var_9 thread _id_72E5();
  var_9 thread _id_72E9(var_0);
  var_9 thread _id_72FF(var_0);
  var_9 thread _id_7311(var_0);
  var_9 thread _id_730E(var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    var_9 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](::_id_72DD);
  }

  var_9 playLoopSound("iw8_ks_ac130_lp");
  return 1;
}

_id_72E6() {
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("gunship_missile_lock");
  _id_09CA::_id_10390("missileLocking", self.owner, "killstreak");
}

_id_72E7() {
  _id_09CA::_id_1037B("missileLocking", self.owner, "killstreak");
}

_id_72EF(var_0, var_1, var_2, var_3) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0 _meth_865E();
  var_0 _id_72C8(0);
  var_4 = 0;

  if(!var_4) {
    var_0 _id_09C8::_id_0D89();
    var_0 scripts\mp\playeractions::_id_1596("gunshipIntro", 0);
  }

  var_5 = "gunship_intro";
  var_7 = level._id_CC31[var_1.streakname][var_5];
  var_8 = _func_0079(var_7);

  if(_id_72E2()) {
    if(level.gametype == "arm") {
      if(isDefined(level._id_7B20)) {
        level._id_72C7.origin = level._id_7B20;
      }
    } else if(isDefined(level._id_72EB))
      level._id_72C7.origin = level._id_72EB;
    else {
      level._id_72C7.origin = var_0.origin;
    }
  }

  var_9 = "veh8_mil_air_acharlie130_ks";

  if(scripts\cp_mp\utility\player_utility::_id_6C67(var_0)) {
    var_9 = "veh8_mil_air_acharlie130_ks_east";
  }

  level._id_72E0 = spawn("script_model", level._id_72C7.origin);
  level._id_72E0 setModel(var_9);
  level._id_72E0.angles = level._id_72C7.angles;
  level._id_72E0 setotherent(var_0);
  level._id_72E0._id_18AF = var_1.streakname;
  level._id_72E0.owner = var_0;

  if(!var_4) {
    foreach(var_11 in level.players) {
      if(var_11 != var_0) {
        level._id_72E0 hidefromplayer(var_11);
      }
    }

    level._id_72E0 thread _id_72DF();
  }

  var_13 = 2000;

  switch (level.mapname) {
    case "mp_cave_am":
    case "mp_cave":
      var_13 = 500;
      break;
  }

  level._id_72E0 linkto(level._id_72C7, "tag_origin", var_3 - (0, 0, var_13), (0, var_2 + 90, 0));
  level._id_72E0 thread _id_730D("disconnect", var_1);
  level._id_72E0 thread _id_730D("joined_team", var_1);
  level._id_72E0 thread _id_730D("joined_spectators", var_1);
  waitframe();

  if(!isDefined(level._id_72E0)) {
    return 0;
  }

  level._id_72E0 _id_06C6::_id_D47B();
  level._id_72E0._id_CBD0 = spawn("script_model", level._id_72E0.origin);
  level._id_72E0._id_CBD0.angles = level._id_72E0.angles;
  level._id_72E0._id_CBD0 setModel("tag_origin");

  if(!var_4) {
    var_0 cameralinkto(level._id_72E0, "tag_player", 0, 1);
    var_0 painvisionoff();
    var_0 scripts\cp_mp\utility\killstreak_utility::_id_8DBE();
    level._id_72E0 setscriptablepartstate("clouds_intro", "on", 0);
    level._id_72E0 setscriptablepartstate("bodyFX_intro", "on", 0);
    level._id_72E0 thread _id_72FC(var_5, var_8, var_0);
    level._id_72E0 thread _id_72F1(var_8, var_0);
    level._id_72E0 thread _id_72EC();
  }

  var_0 scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_1.streakname, 1);
  level._id_72E0._id_CBD0 _id_06C6::_id_1845(level._id_72E0, var_5);

  if(!isDefined(level._id_72E0)) {
    return 0;
  }

  level._id_72E0 notify("gunship_end_intro");

  if(!var_4) {
    var_0 _meth_865E();
    _id_09C8::_id_0D89();
    var_0 scripts\mp\playeractions::_id_1596("gunshipIntro", 1);
  }

  return 1;
}

_id_730D(var_0, var_1) {
  self endon("death");
  self endon("gunship_end_intro");
  level endon("game_ended");
  var_2 = level._id_72E0.owner;
  var_2 waittill(var_0);

  if(var_0 == "disconnect") {
    level._id_731B = 0;
  }

  _id_72D4(var_2, var_1);
}

_id_72D4(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && !var_2) {
    var_0 _meth_8060();
    var_0 _id_09C8::_id_0D89();
    var_0 _meth_865E();
    var_0 scripts\mp\playeractions::_id_1596("gunshipIntro", 1);
    var_0 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(var_1.streakname, "off");
    var_0 setclientomnvar("ui_ac130_hud", 0);
    var_0 painvisionon();
    var_0 scripts\cp_mp\utility\killstreak_utility::_id_8DBA();
    var_0 visionsetkillstreakforplayer("");
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_0, 0);
  }

  var_1 notify("killstreak_finished_with_deploy_weapon");
  self setscriptablepartstate("clouds_intro", "off", 0);
  self setscriptablepartstate("bodyFX_intro", "off", 0);
  self delete();
}

_id_72DF() {
  self endon("death");
  self.owner endon("disconnect");

  for(;;) {
    level waittill("connected", var_0);
    self hidefromplayer(var_0);
  }
}

_id_72EC() {
  self endon("death");
  self.owner endon("disconnect");
  self.owner _meth_865D();
  self.owner _meth_8660(1.4, 20, 10, 10);
  wait 0.1;
  self.owner _meth_8660(0.125, 1500, 5, 10);
  wait 3;
  self.owner _meth_8660(0.125, 1000, 5, 10);
  wait 1.5;
  self.owner _meth_8660(5.6, 5000, 1, 1);
}

_id_72FC(var_0, var_1, var_2) {
  self endon("death");
  var_3 = var_1;
  var_4 = 0.45;
  var_5 = 0.05;

  while(var_3 > 0) {
    earthquake(var_4, var_5, self.origin, 5000);
    var_4 = var_4 - 0.01;

    if(var_4 <= 0.12) {
      var_4 = 0.12;
    }

    var_3 = var_3 - var_5;
    wait(var_5);
  }
}

_id_72F1(var_0, var_1) {
  self endon("death");
  var_1 endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0 - 0.2);
  var_1 visionsetkillstreakforplayer("cruise_predator_slamzoom", 0.1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_1, 1, 0.1);
}

_id_72F4(var_0) {
  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](self.streakinfo);
  }

  if(isDefined(var_0)) {
    var_1 = 0;

    if(!var_1) {
      var_0 _id_09C8::_id_0D89();
      var_0 scripts\mp\playeractions::_id_1596("gunshipUse", 1);
      var_0 _id_72C8(1);
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
    var_0._id_FF0D = undefined;

    if(getdvarint("#x36c8f5946a1247e70")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setThirdPersonDOF")) {
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setThirdPersonDOF")]](1);
      }
    }

    if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(level._id_72C7._id_47EE);
      var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(level._id_72C7._id_47EE);
    }

    if(!var_1) {
      var_0 thread _id_72F3(self.streakinfo);
    }

    var_0 unlink();

    if(isDefined(var_0._id_72CC)) {
      var_0._id_72CC delete();
    }
  }

  _id_72E7();

  if(isDefined(self._id_542C)) {
    _id_079B::_id_EEDE(self._id_542C);
  }

  if(isDefined(self._id_5FBD)) {
    _id_079B::_id_EEDE(self._id_5FBD);
  }

  if(isDefined(level._id_72E0)) {
    level._id_72E0 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "br_respawn")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "br_respawn")]](var_0);
  }

  level._id_731B = 0;
}

_id_72F3(var_0) {
  self endon("disconnect");
  var_0 notify("killstreak_finished_with_deploy_weapon");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::_id_153E(0);
    wait 0.05;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self._id_8FC2);
    wait 0.767;
    scripts\cp_mp\utility\inventory_utility::_takeweapon("ac130_105mm_mp");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("ac130_40mm_mp");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("ac130_25mm_mp");
    scripts\cp_mp\utility\inventory_utility::_takeweapon(level._id_72C7._id_47EE);
    scripts\common\utility::_id_153E(1);
    scripts\common\utility::_id_1593(1);
  }
}

_id_730A(var_0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self._id_014E = 0;
  self._id_1E2E = _func_014B(self, 1000, 4096);

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_11 = undefined;

    if(isDefined(level.teambased) && isPlayer(var_2) && (var_2.team == self.team && (!isDefined(var_11) || !var_11))) {
      continue;
    }
    if(var_5 == "MOD_RIFLE_BULLET" || var_5 == "MOD_PISTOL_BULLET" || var_5 == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }
    if(isDefined(self.owner) && self.owner _id_8AC9()) {
      var_12 = "light";

      if(_func_010F(var_5)) {
        if(_func_0037(var_1 / self.maxhealth) >= 0.33) {
          self.owner earthquakeforplayer(0.25, 0.2, self._id_2FF8.origin, 150);
          self.owner playrumbleonentity("damage_heavy");
          var_12 = "heavy";
        } else {
          self.owner earthquakeforplayer(0.15, 0.15, self._id_2FF8.origin, 150);
          self.owner playrumbleonentity("damage_light");
        }
      }

      thread _id_72F5(0.2, var_12);
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

    if(isDefined(self.owner) && self.owner _id_8AC9()) {
      var_0 setclientomnvar("ui_killstreak_health", self._id_41CA / self.maxhealth);
    }

    if(self._id_41CA <= 500 && self._id_41BE == 0) {
      self._id_41BE = 1;
      self setscriptablepartstate("body_damage_light", "on");

      if(isDefined(self.owner) && self.owner _id_8AC9()) {
        self._id_5CA8 setscriptablepartstate("camera_damage_light", "on");
        self.owner scripts\cp_mp\utility\killstreak_utility::_id_B86F("gunship_taking_damage_light");
      }
    } else if(self._id_41CA <= 250 && self._id_41BE == 1) {
      self._id_41BE = 2;
      self setscriptablepartstate("body_damage_light", "off");
      self setscriptablepartstate("body_damage_medium", "on");

      if(isDefined(self.owner) && self.owner _id_8AC9()) {
        self._id_5CA8 setscriptablepartstate("camera_damage_medium", "on");
        self.owner scripts\cp_mp\utility\killstreak_utility::_id_B86F("gunship_taking_damage_medium");
        self.owner playlocalsound("ks_ac130_damage_warning");
      }
    } else if(self._id_41CA <= 0 && self._id_41BE == 2) {
      self._id_41BE = 3;
      self setscriptablepartstate("body_damage_medium", "off");
      self setscriptablepartstate("contrails", "off");
      thread _id_72FB();

      if(isDefined(self.owner) && self.owner _id_8AC9()) {
        self._id_5CA8 setscriptablepartstate("camera_damage_heavy", "on");
        self.owner scripts\cp_mp\utility\killstreak_utility::_id_B86F("gunship_taking_damage_heavy");
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

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
        var_20 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](var_14, var_2, var_10, var_15, var_1, var_16, var_17, var_18, var_19);
      }

      thread _id_72CE(8, var_0);
    }
  }
}

_id_72FB() {
  level endon("game_ended");
  self._id_91A2 setscriptablepartstate("engine_blowout", "on");
  self._id_91A2 setscriptablepartstate("body_damage_heavy", "on");
  var_0 = randomfloatrange(0.5, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self._id_C868 setscriptablepartstate("engine_blowout", "on");
  self._id_C868 setscriptablepartstate("body_damage_heavy", "on");
}

_id_7316(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(self._id_F224);
  thread _id_72E3(var_0);
}

_id_730C(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level waittill("game_ended");
  thread _id_72E3(var_0);
}

_id_72E3(var_0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  self notify("leaving");
  self unlink();
  self rotateroll(30, 3);
  var_1 = self.angles;
  var_2 = anglesToForward(var_1);

  if(isDefined(self.owner)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_B86F("timeout_gunship", 1);
  }

  _id_72F4(var_0);
  self moveto(self.origin + var_2 * 50000, 10, 5);
  _id_7307(self.origin + var_2 * 50000);
  _id_72F2(0);
}

_id_7307(var_0) {
  while(isDefined(self) && self.origin != var_0) {
    waitframe();
  }
}

_id_7310(var_0, var_1) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  var_0 waittill(var_1);
  thread _id_72CE(8, var_0);
}

_id_730B(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var_0 endon("disconnect");
  level waittill("game_ended");
  var_0 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(self.streakinfo.streakname, "off");
  var_0 setclientomnvar("ui_ac130_hud", 0);
}

_id_72FF(var_0) {
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

_id_72F7(var_0, var_1, var_2, var_3) {
  var_4 = "veh8_mil_air_acharlie130_small";

  if(scripts\cp_mp\utility\player_utility::_id_6C67(var_0)) {
    var_4 = "veh8_mil_air_acharlie130_small_east";
  }

  var_5 = spawn("script_model", level._id_72C7.origin);
  var_5 setModel(var_4);
  var_5 setCanDamage(1);
  var_5._id_41CA = 1000;
  var_5.maxhealth = var_5._id_41CA;
  var_5.health = 99999;
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5._id_F224 = 45;
  var_5._id_41BE = 0;

  if(var_0 scripts\cp_mp\utility\killstreak_utility::_id_0C44("specialty_reaper")) {
    var_5._id_41CA = 1500.0;
    var_5.maxhealth = 1500.0;
    var_5.health = 99999;
  }

  var_5 _id_0812::_id_C2B2("Killstreak_Air", var_0, undefined, undefined, 1, 0);
  var_5._id_5C8A = 2;
  var_5.streakinfo = var_1;
  var_5 _meth_856D();
  var_5 _meth_85AF();
  var_5 setotherent(var_0);
  var_8 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_8 = var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", var_5.team, 1, 1, 1);
  }

  var_5._id_9F26 = var_8;
  var_5 linkto(level._id_72C7, "tag_origin", var_3, (0, var_2 + 90, -30));
  level notify("matchrecording_plane", var_5);
  return var_5;
}

_id_7301(var_0) {
  var_0 endon("death");
  var_0 endon("crashing");
  var_0 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  thread _id_7302(var_0);
  thread _id_7304(var_0);
  thread _id_7300(var_0);
}

_id_7302(var_0) {
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

_id_7304(var_0) {
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

_id_7300(var_0) {
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
    var_2 = level._id_72F9["rotate"] / 360 * var_1;
    level._id_72C7 rotateyaw(level._id_72C7.angles[2] + var_1, var_2, var_2, 0);
    var_3 = 360 / level._id_72F9["rotate"];
    var_4 = var_3 * 0.0174533;
    level._id_72E8 = var_4 * 9000;

    for(;;) {
      level._id_72C7 rotateyaw(360, level._id_72F9["rotate"]);
      wait(level._id_72F9["rotate"]);
    }
  } else if(var_0 == "off") {
    var_5 = 10;
    var_2 = level._id_72F9["rotate"] / 360 * var_5;
    level._id_72C7 rotateyaw(level._id_72C7.angles[2] + var_5, var_2, 0, var_2);
  } else if(var_0 == "crash") {
    var_1 = 50;
    var_2 = level._id_72F9["rotate"] / 360 * var_1;
    level._id_72C7 rotateyaw(level._id_72C7.angles[2] + var_1, var_2, var_2, 0);
  }
}

_id_72CB(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var_0 visionsetkillstreakforplayer("", level._id_5F3A);
  level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_0, 0, 0.1);
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("ac130_105mm_mp");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("ac130_40mm_mp");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("ac130_25mm_mp");
  var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("ac130_105mm_mp");
  self._id_4208 = "ac130_color";
  waitframe();
  var_0 _meth_8060();

  if(isDefined(level._id_72E0)) {
    if(isDefined(level._id_72E0._id_CBD0)) {
      level._id_72E0._id_CBD0 delete();
    }

    level._id_72E0 setscriptablepartstate("clouds_intro", "off", 0);
    level._id_72E0 setscriptablepartstate("bodyFX_intro", "off", 0);
    level._id_72E0 hide();
  }

  self._id_2FF8 = spawn("script_model", self.origin - (0, 0, 20));
  self._id_2FF8 setModel("tag_player");
  self._id_2FF8.angles = vectortoangles(level._id_72C7.origin - self._id_2FF8.origin);
  self._id_2FF8 linkto(self);

  if(isbot(var_0)) {
    var_0 cameralinkto(self._id_2FF8, "tag_player");
  } else {
    var_0 scripts\cp_mp\utility\killstreak_utility::_id_B86F("gunship_engage");
    var_0._id_FF0D = 1;
    var_0 _meth_826E(self._id_2FF8, "tag_player", 1.0, 100, 100, 17, 90, 0);
    var_0 _meth_8266(0);
    var_0 visionsetkillstreakforplayer(self._id_4208);
    var_0 _meth_82FA("ac130_killstreak");
    var_0 setplayerangles(self._id_2FF8.angles);
    var_0 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(self.streakinfo.streakname, "on");
    var_0 setclientomnvar("ui_ac130_hud", 1);
    var_0 setclientomnvar("ui_killstreak_weapon_1_ammo", var_0 getweaponammoclip("ac130_105mm_mp"));
    var_0 setclientomnvar("ui_killstreak_weapon_2_ammo", var_0 getweaponammoclip("ac130_40mm_mp"));
    var_0 setclientomnvar("ui_killstreak_weapon_3_ammo", var_0 getweaponammoclip("ac130_25mm_mp"));
    var_0 setclientomnvar("ui_killstreak_countdown", gettime() + int(self._id_F224 * 1000));
    var_0 setclientomnvar("ui_killstreak_health", self.maxhealth);
    var_0 setclientomnvar("ui_killstreak_flares", self._id_5C8A);
    var_0 _id_09C8::_id_0CF9("killstreak_veh_camera_mp", "top", self._id_F224, 0);
    var_0 _id_09C8::_id_0D89();
    var_0 scripts\mp\playeractions::_id_1596("gunshipUse", 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gunship", "assignTargetMarkers")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("gunship", "assignTargetMarkers")]](var_0);
    }

    var_0 thread _id_7301(self);
  }
}

_id_7309(var_0) {
  var_0 endon("disconnect");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  var_2 = ["ac130_105mm_mp", "ac130_40mm_mp", "ac130_25mm_mp"];
  var_0 scripts\common\utility::_id_1593(0);

  if(!isai(var_0)) {
    var_0 notifyonplayercommand("gunship_switch_weapon", "+weapnext");
    var_0 notifyonplayercommand("gunship_switch_weapon", "+weapprev");
    var_0 setclientomnvar("ui_killstreak_weapon", 3);
  }

  var_3 = 3;

  for(;;) {
    var_0 waittill("gunship_switch_weapon");
    var_4 = var_0 getcurrentweapon();
    var_5 = var_4;

    foreach(var_9, var_7 in var_2) {
      if(var_4.basename == var_7) {
        var_8 = var_9 + 1;

        if(var_8 > var_2.size - 1) {
          var_8 = 0;
        }

        var_5 = var_2[var_8];
        break;
      }
    }

    var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_5);

    if(self._id_4208 == "flir_0_black_to_white") {
      var_10 = _id_72D9(var_5);
      var_0 _meth_8660(var_10._id_5FEC, var_10._id_5E07, 20, 20);
    }

    var_3--;

    if(var_3 == 0) {
      var_3 = 3;
    }

    var_0 setclientomnvar("ui_killstreak_weapon", var_3);
    _func_019D(scripts\engine\utility::getfx("camera_shutter"), var_0, "tag_eye", var_0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.4);
  }
}

_id_7317(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  var_2 = self.streakinfo;

  for(;;) {
    var_0 waittill("missile_fire", var_3);
    var_0 thread _id_7318(var_3);
    var_3.streakinfo = var_2;
    var_2._id_DA63++;
    var_4 = var_0 getcurrentweapon();
    var_5 = var_0 getweaponammoclip(var_4);

    switch (var_4.basename) {
      case "ac130_105mm_mp":
        earthquake(0.2, 1, self.origin, 1000);
        var_0 setclientomnvar("ui_killstreak_weapon_1_ammo", var_5);
        var_3 thread _id_7308(self, var_0);
        break;
      case "ac130_40mm_mp":
        earthquake(0.1, 0.5, self.origin, 1000);
        var_0 setclientomnvar("ui_killstreak_weapon_2_ammo", var_5);
        break;
      case "ac130_25mm_mp":
        var_0 setclientomnvar("ui_killstreak_weapon_3_ammo", var_5);
        break;
    }

    if(var_5 == 0) {
      var_0 thread _id_7319(var_4, self);
    }
  }
}

_id_7318(var_0, var_1) {
  level endon("game_ended");
  var_2 = self getcurrentweapon();
  var_0 waittill("missile_stuck", var_3, var_4, var_5, var_6, var_7, var_8);
  var_9 = 0.5;
  var_10 = 100;

  if(isDefined(var_2) && isDefined(var_2.basename)) {
    switch (var_2.basename) {
      case "ac130_105mm_mp":
        var_9 = 1.5;
        var_10 = 500;
        break;
      case "ac130_40mm_mp":
        var_9 = 1;
        var_10 = 300;
        break;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_0.origin, var_10, var_10, self.team, var_9, self, 1);
  }

  var_11 = spawn("script_model", var_0.origin);
  var_11 setModel("ks_ac130_target_mp");
  var_11.angles = vectortoangles(var_8);
  var_11 linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_11 setotherent(self);
  var_12 = "on";

  if(istrue(var_1)) {
    var_12 = "debug_ground_fx";
  }

  var_11 setscriptablepartstate(var_0.weapon_name, var_12, 0);

  if(isDefined(self)) {
    var_0 detonate();
  } else {
    var_0 delete();
  }

  var_13 = var_11.origin;
  var_14 = _id_6B62(var_0.weapon_name);
  var_15 = 0.75;
  var_16 = _id_6B61(var_0.weapon_name);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "artillery_earthQuake")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "artillery_earthQuake")]](var_13, var_14, var_15, var_16);
  }

  var_11 thread _id_475A(5);
}

_id_6B62(var_0) {
  var_1 = 1.0;

  switch (var_0) {
    case "ac130_105mm_mp":
      var_1 = 0.75;
      break;
    case "ac130_40mm_mp":
      var_1 = 0.5;
      break;
    case "ac130_25mm_mp":
      var_1 = 0.15;
      break;
  }

  return var_1;
}

_id_6B61(var_0) {
  var_1 = 1.0;

  switch (var_0) {
    case "ac130_105mm_mp":
      var_1 = 2000;
      break;
    case "ac130_40mm_mp":
      var_1 = 1300;
      break;
    case "ac130_25mm_mp":
      var_1 = 700;
      break;
  }

  return var_1;
}

_id_7308(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("leaving");
  var_0 endon("crashing");
  var_1 endon("disconnect");
  self waittill("death");
  earthquake(0.125, 0.5, var_0.origin, 1000);
  var_2 = _id_72DC(var_0._id_4208);
  var_3 = _id_72DB(var_2);

  if(var_2 == "flir") {
    var_1 visionsetthermalforplayer(var_3);
  } else {
    var_1 visionsetkillstreakforplayer(var_3);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);

  if(var_2 == "flir") {
    var_1 visionsetthermalforplayer(var_0._id_4208);
  } else {
    var_1 visionsetkillstreakforplayer(var_0._id_4208);
  }
}

_id_72F5(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(isDefined(var_2)) {
    var_3 = _id_72DC(self._id_4208);
    var_4 = _id_72DB(var_3, var_1);

    if(var_3 == "flir") {
      var_2 visionsetthermalforplayer(var_4);
    } else {
      var_2 visionsetkillstreakforplayer(var_4);
    }

    if(isDefined(var_0) && isDefined(self._id_4208)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

      if(var_3 == "flir") {
        var_2 visionsetthermalforplayer(self._id_4208);
      } else {
        var_2 visionsetkillstreakforplayer(self._id_4208);
      }
    }
  }
}

_id_72DC(var_0) {
  return scripts\engine\utility::ter_op(issubstr(var_0, "flir"), "flir", "color");
}

_id_72DB(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1)) {
    if(var_0 == "flir") {
      var_2 = var_0 + "_0_black_to_white_" + var_1 + "_damage";
    } else {
      var_2 = "ac130_color_" + var_1 + "_damage";
    }
  } else
    var_2 = "ac130_" + var_0 + "_glitch";

  return var_2;
}

_id_7314(var_0) {
  if(!isai(var_0)) {
    var_0 thread scripts\cp_mp\utility\player_utility::_id_10C17();
  }

  _id_7315(var_0);

  if(isDefined(var_0) && !isai(var_0)) {
    var_0 scripts\cp_mp\utility\player_utility::_id_E94B();
  }
}

_id_7315(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_0 endon("disconnect");
  level endon("game_ended");
  self._id_5CA8 = spawn("script_model", self.origin);
  self._id_5CA8 setModel("ks_ac130_mp");
  self._id_5CA8 dontinterpolate();
  self._id_5CA8 thread _id_7312(self, var_0);

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    self._id_5CA8 thread _id_72F6();
  }

  var_1 = 0;
  var_2 = 1;
  var_4 = 12;
  var_5 = 1000;

  if(scripts\cp_mp\utility\game_utility::isnightmap() && istrue(var_2)) {
    var_0 setclientomnvar("ui_killstreak_thermal_mode", 1);
    var_0 visionsetthermalforplayer("flir_0_black_to_white");
    var_0 scripts\cp_mp\utility\player_utility::_id_D720(1, var_4, var_5);
    self._id_4208 = "flir_0_black_to_white";
    self._id_5CA8 notify("flashlight_on");
    var_1 = 1;
    var_0 _id_09C8::_id_0CF9("killstreak_veh_camera_flir_mp", "top", self._id_F224, 0);
  }

  for(;;) {
    var_0 waittill("switch_thermal_mode");
    var_6 = var_0 getcurrentweapon();
    var_7 = _id_72D9(var_6.basename);

    if(!istrue(var_1)) {
      var_0 setclientomnvar("ui_killstreak_thermal_mode", 1);
      var_0 visionsetthermalforplayer("flir_0_black_to_white");
      var_0 scripts\cp_mp\utility\player_utility::_id_D720(1, var_7._id_5FEC, var_7._id_5E07);
      self._id_4208 = "flir_0_black_to_white";
      var_1 = 1;
      var_0 _id_09C8::_id_0CF9("killstreak_veh_camera_flir_mp", "top", self._id_F224, 0);
      continue;
    }

    var_0 setclientomnvar("ui_killstreak_thermal_mode", 0);
    var_0 scripts\cp_mp\utility\player_utility::_id_D720(0);
    var_0 visionsetkillstreakforplayer("ac130_color");
    self._id_4208 = "ac130_color";
    var_1 = 0;
    var_0 _id_09C8::_id_0CF9("killstreak_veh_camera_mp", "top", self._id_F224, 0);
  }
}

_id_72D9(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case "ac130_105mm_mp":
      var_1._id_5FEC = 8;
      var_1._id_5E07 = 600;
      break;
    case "ac130_40mm_mp":
      var_1._id_5FEC = 8;
      var_1._id_5E07 = 600;
      break;
    case "ac130_25mm_mp":
      var_1._id_5FEC = 8;
      var_1._id_5E07 = 3500;
      break;
  }

  return var_1;
}

_id_7312(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  var_2 = 1;

  while(isDefined(var_0) && isDefined(var_1)) {
    self.origin = var_0.origin;

    if(istrue(var_2)) {
      self.angles = var_1 getplayerangles();
    }

    wait 0.05;
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_72F6() {
  self endon("death");
  level endon("game_ended");
  playFXOnTag(scripts\engine\utility::getfx("camera_spotlight"), self, "tag_origin");

  for(;;) {
    level waittill("player_enabled_nvgs");
    stopFXOnTag(scripts\engine\utility::getfx("camera_spotlight"), self, "tag_origin");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    playFXOnTag(scripts\engine\utility::getfx("camera_spotlight"), self, "tag_origin");
  }
}

_id_7319(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("crashing");
  var_1 endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = _id_6A8C(var_0);
  _id_7306(var_0, var_2);
  var_3 = var_2 + "_reloaded";

  if(var_2 == "ac130_105mm") {
    var_3 = "gunship_105mm_reloaded";
  } else if(var_2 == "ac130_40mm") {
    var_3 = "gunship_40mm_reloaded";
  } else {
    var_3 = "gunship_25mm_reloaded";
  }

  scripts\cp_mp\utility\killstreak_utility::_id_B86F(var_3);
  var_4 = weaponmaxammo(var_0);
  self setweaponammoclip(var_0, var_4);
  var_5 = undefined;

  switch (var_2) {
    case "ac130_105mm":
      var_5 = "ui_killstreak_weapon_1_ammo";
      break;
    case "ac130_40mm":
      var_5 = "ui_killstreak_weapon_2_ammo";
      break;
    case "ac130_25mm":
      var_5 = "ui_killstreak_weapon_3_ammo";
      break;
  }

  self setclientomnvar(var_5, var_4);
}

_id_7306(var_0, var_1) {
  var_2 = level._id_10DC7[var_0.basename];
  var_3 = undefined;

  switch (var_1) {
    case "ac130_105mm":
      var_3 = "ui_killsreak_weapon_1_reloadtime";
      break;
    case "ac130_40mm":
      var_3 = "ui_killsreak_weapon_2_reloadtime";
      break;
    case "ac130_25mm":
      var_3 = "ui_killsreak_weapon_3_reloadtime";
      break;
  }

  self setclientomnvar(var_3, gettime() + int(var_2 * 1000));

  for(;;) {
    wait 0.05;
    var_2 = var_2 - 0.05;

    if(var_2 <= 0) {
      break;
    }
  }
}

_id_6A8C(var_0) {
  var_1 = 0;
  var_2 = var_0.basename;
  var_3 = strtok(var_2, "_");
  return var_3[var_1] + "_" + var_3[var_1 + 1];
}

_id_72F0(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_0._id_72CC = spawn("script_model", var_0 getEye());
  var_0._id_72CC setModel("tag_origin");
  var_0._id_72CC linkto(var_0, "tag_eye");
  waitframe();
  _func_019D(scripts\engine\utility::getfx("clouds"), var_0._id_72CC, "tag_origin", var_0);
}

_id_475A(var_0) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self delete();
}

_id_72CE(var_0, var_1) {
  self notify("crashing");
  self._id_3E66 = 1;
  _id_72F4(var_1);
  thread _id_72EA(var_0);
}

_id_72EA(var_0) {
  level endon("game_ended");
  self._id_91A2 setscriptablepartstate("engine_blowout", "off");
  self._id_C868 setscriptablepartstate("engine_blowout", "off");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  self._id_91A2 setscriptablepartstate("engine_blowout", "on");
  self._id_C868 setscriptablepartstate("engine_blowout", "on");
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_B86F("gunship_crashing", 1);
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
  var_1._id_18AF = self.streakinfo.streakname;
  var_1 _id_06C6::_id_D47B();
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("ks_ac130_mp");
  var_2.angles = self.angles;
  var_2 linkto(var_1, "tag_body", (0, 0, -10), (0, 0, 0));
  var_3 = "crash_air";
  var_2 setscriptablepartstate(var_3, "on", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "delayEntDelete")) {
    var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "delayEntDelete")]](10);
    var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "delayEntDelete")]](10);
  }

  var_1 thread _id_72CF();
  thread _id_72D3();
  thread _id_72D2(level._id_72D0);
  thread _id_72D1(level._id_72D0);
  self._id_CBD0 _id_06C6::_id_1845(var_1, "gunship_death", undefined);
  self._id_CBD0 delete();
  _id_72F2(1);
}

_id_72D3() {
  level endon("game_ended");
  wait 0.05;
  self hide();
}

_id_72D2(var_0) {
  level endon("game_ended");
  var_1 = var_0 - 2;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_3 earthquakeforplayer(0.25, 2, self.origin, 30000);
    }
  }
}

_id_72D1(var_0) {
  level endon("game_ended");
  var_1 = var_0 - 3;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  _id_09C1::_id_B8A7();
}

_id_72CF() {
  waitframe();
  playsoundatpos(self.origin, "iw8_ks_ac130_explo_main");
  playsoundatpos(self.origin, "iw8_ks_ac130_explo_low_02");
  playsoundatpos(self.origin, "iw8_ks_ac130_shake_explo");
  playsoundatpos(self.origin, "iw8_ks_ac130_whine");
}

_id_72F2(var_0) {
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

  self delete();
}

_id_72CD() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_5 = undefined;
  var_6 = (self _meth_8030("minInaccuracy") + self _meth_8030("maxInaccuracy")) / 2;
  var_7 = 0;

  for(;;) {
    var_8 = 0;
    var_9 = 0;

    if(isDefined(var_1) && var_1.health <= 0 && gettime() - var_1._id_441F < 2000) {
      var_8 = 1;
      var_9 = 1;
    } else if(isalive(self._id_0192) && (self _meth_8028(self._id_0192) || gettime() - self _meth_8205(self._id_0192) <= 300)) {
      var_8 = 1;
      var_1 = self._id_0192;
      var_10 = var_1.origin;
      var_0 = self._id_0192.origin;

      if(self _meth_8028(self._id_0192)) {
        var_7 = 0;
        var_9 = 1;
        var_11 = gettime();
      } else {
        var_7 = var_7 + 0.05;

        if(var_7 > 5.0) {
          var_8 = 0;
        }
      }
    }

    if(var_8) {
      if(isDefined(var_0)) {
        var_2 = var_0;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bots", "bot_body_is_dead")) {
        if(var_9 && (self[[scripts\cp_mp\utility\script_utility::getsharedfunc("bots", "bot_body_is_dead")]]() || distancesquared(var_2, level._id_72C7.origin) > level._id_B054["ac130_105mm_mp"] * level._id_B054["ac130_105mm_mp"])) {
          self _meth_804E("attack");
        }
      }

      if(gettime() > var_4 + 500) {
        var_12 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_13 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_14 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_5 = (150 * var_12, 150 * var_13, 150 * var_14);
        var_4 = gettime();
      }

      var_2 = var_2 + var_5;
    } else if(gettime() > var_3) {
      var_3 = gettime() + randomintrange(1000, 2000);
      var_2 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("bots", "get_random_outside_target")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("bots", "get_random_outside_target")]]();
      }
    }

    self _meth_8045(var_2, 0.2, "script_forced");
    wait 0.05;
  }
}

_id_72DD(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 _meth_8174(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2._id_5C8A > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](var_2);
      }

      var_2 thread _id_72EE(var_3);
      var_2 scripts\cp_mp\utility\killstreak_utility::_id_B86F("gunship_flares", 1);
      var_6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy")) {
        var_6 = var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](var_0);
      }

      self missile_settargetent(var_6);
      self notify("missile_pairedWithFlare");
      return;
    } else if(var_5 < 300 && var_2._id_5C8A <= 0) {
      var_2 thread _id_72ED();
      var_7 = _func_02CD(self.weapon_name);

      if(isDefined(self.owner)) {
        var_2 dodamage(var_7, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name);
      }

      self delete();
    }

    waitframe();
  }
}

_id_72ED() {
  if(!isDefined(self._id_9F6C)) {
    self._id_9F6C = 0;
  }

  self._id_9F6C++;

  if(self._id_9F6C > 4) {
    self._id_9F6C = 0;
  }

  self setscriptablepartstate("fake_missile_expl_" + self._id_9F6C, "on", 0);
  self _meth_827E("iw8_ks_ac130_dist_rkt_explo");
  wait 2;
  self setscriptablepartstate("fake_missile_expl_" + self._id_9F6C, "off", 0);
}

_id_72EE(var_0) {
  var_1 = "tag_origin";

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  playsoundatpos(self gettagorigin(var_1), "ks_ac130_flares");
  playFXOnTag(scripts\engine\utility::getfx("gunship_flares"), self, var_1);
  var_2 = self._id_5C8A + 1;
  self setscriptablepartstate("fake_flares_" + var_2, "on", 0);
}

_id_8AC9() {
  return isDefined(self._id_FF0D);
}

_id_72E4() {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  var_0 = anglesToForward(self.angles);
  self setscriptablepartstate("lights", "on");
}

_id_72E5() {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  var_0 = self gettagorigin("tag_left_outer_prop");
  self._id_91A2 = spawn("script_model", var_0);
  self._id_91A2 setModel("ks_ac130_mp");
  self._id_91A2.angles = self.angles;
  self._id_91A2 setotherent(self.owner);
  self._id_91A2 linkto(self, "tag_left_outer_prop", (0, 0, 0), (0, 0, 0));
  var_1 = self gettagorigin("tag_right_outer_prop");
  self._id_C868 = spawn("script_model", var_1);
  self._id_C868 setModel("ks_ac130_mp");
  self._id_C868.angles = self.angles;
  self._id_C868 setotherent(self.owner);
  self._id_C868 linkto(self, "tag_right_outer_prop", (0, 0, 0), (0, 0, 0));
  self setscriptablepartstate("contrails", "on");
}

_id_7311(var_0) {
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

        var_1 = _id_72DA(var_3);
        break;
      }

      wait 0.05;
    }

    if(var_1.size > 0 && var_1.size < 2) {
      var_0 scripts\cp_mp\utility\killstreak_utility::_id_B86F("gunship_single_spotted");
    } else if(var_1.size >= 2) {
      var_0 scripts\cp_mp\utility\killstreak_utility::_id_B86F("gunship_multi_spotted");
    }

    wait(randomintrange(5, 15));
  }
}

_id_72DA(var_0) {
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

_id_730E(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    self.owner waittill("update_rapid_kill_buffered", var_1, var_2);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

    if(isDefined(self.owner._id_C0F3)) {
      if(self.owner._id_C0F3 >= 1 && _id_72E1(var_2)) {
        scripts\cp_mp\utility\killstreak_utility::_id_B86F("gunship_good_hit");
      }
    }
  }
}

_id_72E1(var_0) {
  return scripts\engine\utility::ter_op(isDefined(var_0) && (var_0 == "ac130_105mm_mp" || var_0 == "ac130_40mm_mp" || var_0 == "ac130_25mm_mp"), 1, 0);
}

_id_72E2() {
  var_0 = scripts\cp_mp\utility\game_utility::_id_88FE();
  return var_0;
}

_id_72C8(var_0) {
  if(!istrue(var_0)) {
    self._id_72D5 = [];
    var_1 = self getstance();

    switch (var_1) {
      case "stand":
        self._id_72D5 = ["crouch", "prone"];
        break;
      case "crouch":
        self._id_72D5 = ["stand", "prone"];
        break;
      case "prone":
        self._id_72D5 = ["stand", "crouch"];
        break;
    }

    scripts\mp\playeractions::_id_C23B("gunshipStance", self._id_72D5);
    scripts\mp\playeractions::_id_1596("gunshipStance", 0);
  } else
    scripts\mp\playeractions::_id_1596("gunshipStance", 1);
}