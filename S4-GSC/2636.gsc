/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2636.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("hover_jet", ::_id_F78B);
  level._id_7B10 = [];
  _id_0AAF::_id_D42B("hover_jet", 12);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("thermite_bolt_mp", 1, "hover_jet");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("hover_jet", 24, "thermite_bolt_mp");
  }

  _id_7FB8();
  _id_7FB9();
  level._id_7DA0 = 0;
  level._id_7DA7["allies"] = 0;
  level._id_7DA7["axis"] = 0;
}

#using_animtree("mp_vehicles_always_loaded");

_id_7FB8() {
  level._id_CC31["hover_jet"]["airstrike_flyby"] = % mp_halfa_flyin;
  level._id_CC31["hover_jet"]["exit"] = % mp_halfa_exit;
}

_id_7FB9() {
  game["dialog"]["hover_jet_move"] = "hover_jet_acknowledge";
  game["dialog"]["hover_jet_guard"] = "hover_jet_guard";
  game["dialog"]["hover_jet_flares"] = "hover_jet_flares";
  game["dialog"]["hover_jet_damage_heavy"] = "hover_jet_health_low";
  game["dialog"]["hover_jet_damage_med"] = "hover_jet_health_med";
  game["dialog"]["hover_jet_damage_light"] = "hover_jet_health_high";
  game["dialog"]["hover_jet_crash"] = "hover_jet_crash";
  game["dialog"]["hover_jet_attack_air"] = "hover_jet_air_target";
}

_id_10D92(var_0) {
  _id_0A54::_id_E6E4();
  return 1;
}

_id_F78A() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("hover_jet", self);
  return _id_F78B(var_0);
}

_id_F78B(var_0) {
  var_1 = self.team;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B()) {
    scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  level._id_7DA0++;
  var_2 = 1;

  if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
    var_2 = 2;
  }

  if(level._id_7B10.size >= var_2 || level._id_7B10.size + level._id_7DA0 > var_2) {
    scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    level._id_7DA0--;
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::_id_88FE() && level.teambased) {
    var_3 = 1;
    level._id_7DA7[var_1]++;

    if(scripts\cp_mp\utility\killstreak_utility::_id_6BAC(var_1, level._id_7B10) + level._id_7DA7[var_1] > var_3) {
      level._id_7DA0--;
      level._id_7DA7[var_1]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_VTOL_JET");
      }

      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  var_4 = _id_0D99(var_0);
  var_4 = istrue(var_4);
  level._id_7DA0--;

  if(scripts\cp_mp\utility\game_utility::_id_88FE() && level.teambased) {
    level._id_7DA7[var_1]--;
  }

  if(!var_4) {
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  }

  return var_4;
}

_id_0D99(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  var_1 = _id_09B9::_id_EA04(var_0, makeweapon("ks_remote_map_mp"), 1, ::_id_10D92);

  if(!istrue(var_1)) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  var_2 = _id_7AEF(var_0, 1);

  if(!isDefined(var_2)) {
    return 0;
  }

  var_0 notify("killstreak_finished_with_deploy_weapon");
  thread _id_E6BB(self, var_0, var_2);
  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    var_3 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_0.streakname, 1, var_3);
  scripts\common\utility::_id_F73A(level._id_9BB4, "hover_jet", self.origin);
  thread scripts\mp\hud_util::_id_EF8D("used_hover_jet", self);
  return 1;
}

_id_7AEF(var_0, var_1) {
  scripts\common\utility::_id_1593(0);
  self _meth_867F("mp_killstreak_overlay");
  var_2 = _id_0A54::_id_6D1F(var_0, var_1);

  if(!isDefined(var_2)) {
    scripts\common\utility::_id_1593(1);
    self _meth_8680("mp_killstreak_overlay");
    return undefined;
  }

  scripts\common\utility::_id_1593(1);
  self _meth_8680("mp_killstreak_overlay");
  return var_2;
}

_id_E6BB(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_4 = 24000;
  var_5 = 6500;
  var_6 = 3250;
  var_7 = 1500;
  var_8 = (0, 0, 0);
  var_9 = 1500;
  var_10 = var_0.angles;
  var_11 = 1;

  if(isDefined(var_3)) {
    var_6 = var_3.origin[2] + 750;
  }

  var_12 = scripts\cp_mp\utility\game_utility::_id_6B18();

  if(isDefined(var_12) && var_12 == "locale_6") {
    var_6 = var_6 + 500;
  }

  var_14 = var_2[0]._id_96CF;
  var_10 = _id_09AB::_id_2FD8(var_0, var_14, var_6);
  var_15 = _id_09AB::_id_6A4E(var_14, var_10, var_4, var_3, var_6, var_5, var_9, var_1.streakname, var_11);
  var_16 = var_15["startPoint"];
  var_17 = var_15["endPoint"];
  var_18 = "veh8_mil_air_halfa_mp";

  if(scripts\cp_mp\utility\player_utility::_id_6C67(var_0)) {
    var_18 = "veh8_mil_air_halfa_east_mp";
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  var_19 = scripts\cp_mp\vehicles\vehicle_tracking::_id_0D7D(var_0, var_16, var_10, "veh_hover_jet_mp", var_18);

  if(!isDefined(var_19)) {
    return;
  }
  var_20 = 45;
  var_19.speed = 250;
  var_19.accel = 175;
  var_19.health = 2500;
  var_19.maxhealth = 2500;
  var_19.angles = vectortoangles(var_10);
  var_19.lifetime = var_20;
  var_19.team = var_0.team;
  var_19.owner = var_0;
  var_19.streakinfo = var_1;
  var_19.streakname = var_1.streakname;
  var_19._id_5C8A = 1;
  var_19._id_C794 = var_14;
  var_19._id_41BE = 0;
  var_19._id_5D44 = var_6;
  var_19._id_7AD8 = var_7;
  var_19._id_9F7E = 6;
  var_19.pers["team"] = var_19.team;
  var_19._id_24D0 = undefined;
  var_19._id_24CF = undefined;
  var_19._id_5CF2 = var_15["directionAngles"];
  var_19 setmaxpitchroll(0, 90);
  var_19 vehicle_setspeed(var_19.speed, var_19.accel);
  var_19 sethoverparams(50, 100, 50);
  var_19 setturningability(0.05);
  var_19 setyawspeed(45, 25, 25, 0.5);
  var_19 setotherent(var_19.owner);
  var_19 setCanDamage(1);
  var_19 setneargoalnotifydist(700);
  var_19 _meth_83A6(var_19.team);
  level._id_7B10[level._id_7B10.size] = var_19;
  var_19 scripts\mp\utility\killstreak::_id_1155(var_1.streakname, "Killstreak_Air", var_19.owner, 0, 1, 100);
  var_19 setscriptablepartstate("blinking_lights", "on", 0);
  var_19 setscriptablepartstate("thrusters", "active", 0);
  var_19 setscriptablepartstate("contrails", "on", 0);
  var_19._id_F81F = spawnturret("misc_turret", var_19 gettagorigin("tag_turret"), "hover_jet_turret_mp");
  var_19._id_F81F setModel("veh8_mil_air_halfa_turret");
  var_19._id_F81F.owner = var_19.owner;
  var_19._id_F81F.team = var_19.team;
  var_19._id_F81F.angles = var_19.angles;
  var_19._id_F81F.streakinfo = var_1;
  var_19._id_F81F linkto(var_19, "tag_turret", (0, 0, 5), (0, 0, 0));
  var_19._id_F81F _meth_83A0(var_19.team);
  var_19._id_F81F _meth_839D(0);
  var_19._id_F81F setmode("manual_target");
  var_19._id_F81F setsentryowner(var_19.owner);
  var_19._id_F81F setdefaultdroppitch(45);
  var_19._id_F81F _meth_8224();
  var_19._id_F81F _meth_8331(360);
  var_19._id_F81F _meth_8372(360);
  var_19._id_F81F _meth_82F0(90);
  var_19._id_F81F _meth_8395(90);
  var_19._id_F81F _meth_8302(0.5, "pitch");
  var_19._id_F81F _meth_8302(0.5, "yaw");
  var_19._id_F81F _meth_8301(0.65);
  var_19.killcament = spawn("script_model", var_19._id_F81F gettagorigin("bi_center"));
  var_19.killcament linkto(var_19, "tag_origin", (-500, 0, 500), (0, 0, 0));
  var_19._id_F81F._id_71F1 = spawn("script_model", var_19.origin);
  var_19._id_F81F._id_71F1 setModel("tag_origin");
  var_19._id_F81F._id_71F1 dontinterpolate();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_19[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1.streakname, "Killstreak_Air", var_0, 0, 1, 100);
  }

  var_19._id_18AF = var_1.streakname;
  var_19._id_CBD0 = spawn("script_model", var_19._id_C794 * (1, 1, 0) + (0, 0, var_6));
  var_19._id_CBD0.angles = var_19.angles;
  var_19._id_CBD0 setModel("tag_origin");
  var_19 thread _id_7AEB(var_14);
  var_19 _id_7AFC();
  var_24 = _func_0079(level._id_CC31[var_19._id_18AF]["airstrike_flyby"]);
  var_25 = scripts\engine\utility::_id_65F1(level._id_CC31[var_19._id_18AF]["airstrike_flyby"], "contrail_off");
  var_19._id_CBD0 thread _id_06C6::_id_1845(var_19, "airstrike_flyby");
  var_19 thread _id_7AE2(var_25, "contrails", "off");
  var_19 thread _id_7AF1();
  var_19 thread _id_7B09();
  var_19 _id_0812::_id_C2B2("Killstreak_Air", self);
  var_19 scripts\mp\utility\killstreak::_id_8DB7(var_1.streakname, "destroyed_hover_jet", undefined, "timeout_hover_jet", "callout_destroyed_hover_jet");
  var_19 scripts\mp\utility\killstreak::_id_8DC1(var_1.streakname);
  var_19 scripts\mp\utility\killstreak::_id_8DC0(var_1.streakname, ::_id_7AF7);
  var_19 scripts\mp\utility\killstreak::_id_8DBF(var_1.streakname, ::_id_7AF0);
  var_19 thread _id_0A44::_id_5C7F(::_id_7AF2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_24);

  if(!isDefined(var_19)) {
    return;
  }
  if(isDefined(var_19._id_CBD0)) {
    var_19._id_CBD0 delete();
  }

  var_19 _id_E6BC(var_1);
}

_id_7AE2(var_0, var_1, var_2) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setscriptablepartstate(var_1, var_2, 0);
}

_id_7AFC() {
  thread scripts\engine\utility::delaythread(0.05, ::_id_7AFA);
  thread scripts\engine\utility::delaythread(6, ::_id_7AFB);
  thread scripts\engine\utility::delaythread(14, ::_id_7AFD);
}

_id_7AFA() {
  self _meth_827E("ks_hoverjet_approach");
}

_id_7AFB() {
  self _meth_827E("ks_hoverjet_flyby");
}

_id_7AFD() {
  self _meth_827E("ks_hoverjet_return");
}

_id_7AEB(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = scripts\engine\utility::_id_65F1(level._id_CC31["hover_jet"]["airstrike_flyby"], "attack");
  var_2 = var_1 - 4;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  var_3 = ["physicscontents_clipshot", "physicscontents_missileclip"];
  var_4 = physics_createcontents(var_3);
  var_5 = self.angles * (0, 1, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = [var_0 - var_6 * 2250 + var_7 * 750, var_0 - var_6 * 1500 - var_7 * 750, var_0 - var_6 * 750 + var_7 * 250, var_0 - var_7 * 250, var_0 + var_6 * 750 + var_7 * 750, var_0 + var_6 * 1500 - var_7 * 750, var_0 + var_6 * 2250 + var_7 * 250, var_0 + var_6 * 3000 - var_7 * 250];
  var_9 = ["tag_right_aphid_missile", "tag_left_aphid_missile", "tag_right_archer_missile", "tag_left_archer_missile"];
  var_10 = 0;
  var_11 = [];

  foreach(var_22, var_13 in var_8) {
    var_14 = var_13 + (0, 0, 10000);
    var_15 = var_13 - (0, 0, 10000);
    var_16 = scripts\engine\trace::ray_trace(var_14, var_15, level.characters, var_4);
    var_17 = scripts\common\utility::_id_B7BF(var_16["position"], 1000);
    var_18 = _id_7AE7(var_17, var_11);
    var_19 = self gettagorigin(var_9[var_10]) + anglesToForward(self gettagangles(var_9[var_10])) * 300;
    var_20 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("hover_jet_proj_mp"), var_19, var_16["position"], self.owner);
    var_20.killcament = spawn("script_model", var_20.origin);
    var_20.killcament linkto(var_20, "tag_origin", (-100, 0, 500), (0, 0, 0));
    var_20.killcament thread _id_7AF6(var_16["position"], var_20.angles);
    var_20.streakinfo = self.streakinfo;
    self.streakinfo._id_DA63++;
    thread _id_7AE8(var_10 + 1);

    if(isDefined(var_18)) {
      var_13 = var_18.origin;
      var_11[var_11.size] = var_18;
      thread _id_7AE0(var_20, 0.05, var_18);
    }

    wait 0.5;
    var_10++;

    if(var_10 > var_9.size - 1) {
      var_10 = 0;
    }
  }

  var_11 = undefined;
}

_id_7AF6(var_0, var_1) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  self unlink();
  self moveto(var_0 - anglesToForward(var_1) * 750, 6);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(7);
  self delete();
}

_id_7AE8(var_0) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("fire_missile_" + var_0, "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self setscriptablepartstate("fire_missile_" + var_0, "off", 0);
}

_id_7AE7(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(level.teambased && var_4.team == self.team) {
      continue;
    }
    if(var_4 == self.owner) {
      continue;
    }
    if(scripts\engine\utility::array_contains(var_1, var_4)) {
      continue;
    }
    if(var_4 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
      continue;
    }
    var_2 = var_4;
    break;
  }

  return var_2;
}

_id_7AE0(var_0, var_1, var_2) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  var_0 missile_settargetent(var_2, (0, 0, 10));
}

_id_7AE1(var_0) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("explode" + var_0, "active", 0);
  wait 1;
  self setscriptablepartstate("explode" + var_0, "neutral", 0);
}

_id_E6BC(var_0) {
  thread _id_7ADF();
}

_id_7ADF() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  thread _id_7B0B(self.lifetime);
  thread _id_7B0C();
  thread _id_7B02();
  thread _id_7AF9(self._id_C794);
}

_id_7AF2(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 _meth_8174(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2._id_5C8A > 0) {
      var_2 scripts\cp_mp\utility\killstreak_utility::_id_B86F("hover_jet_flares", 1);
      _id_0A44::_id_5C84(var_2);
      var_2 thread _id_0A44::_id_5C82("jet_flares", var_3);
      var_6 = var_2 _id_0A44::_id_5C76();
      self missile_settargetent(var_6);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

_id_7B0B(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("timeout_" + self.streakinfo.streakname, 1);
  thread _id_7AF4();
}

_id_7B09() {
  self endon("death");
  level waittill("game_ended");
  self._id_C143 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(self.streakinfo);
}

_id_7B0C() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  thread _id_7AF5("disconnect");
  thread _id_7AF5("joined_team");
}

_id_7AF5(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner waittill(var_0);
  thread _id_7AF4();
}

_id_7B02() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self._id_F81F.killcament = self.killcament;
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(45, 10);
  thread _id_7B08();
  thread _id_7AE4();
  self setscriptablepartstate("thrusters", "idle", 0);
}

_id_7AF9(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_1 = [self, self._id_F81F];

  for(;;) {
    var_2 = self.origin;
    var_3 = var_0 * (1, 1, 0) + (0, 0, self.origin[2]);
    var_4 = scripts\engine\trace::_id_E409(var_2, var_3, 256, var_1);
    var_5 = 0;
    var_6 = var_0[0];
    var_7 = var_0[1];

    if(isDefined(var_4)) {
      if(var_4["hittype"] != "hittype_none") {
        var_6 = var_4["position"][0];
        var_7 = var_4["position"][1];
        var_5 = 1;
      }
    }

    var_8 = _id_7AEE(var_6, var_7, 20);
    var_9 = (var_6, var_7, var_8);
    self setvehgoalpos(var_9, 1);
    self waittill("near_goal");

    if(!istrue(var_5)) {
      self._id_41C9 = var_9;
      self notify("hoverJet_moveToNewlocation", var_9);
      break;
    }
  }

  self _meth_807E();
}

_id_7AEE(var_0, var_1, var_2) {
  var_3 = self._id_7AD8;
  var_5 = _id_7B03(var_0, var_1);
  var_6 = var_5 + var_3;
  var_6 = var_6 + randomint(var_2);
  return var_6;
}

_id_7B03(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_2 = -99999;
  var_3 = self.origin[2];
  var_4 = level._id_1F9C;
  var_5 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 0, 0, 0, 0);
  var_6 = scripts\engine\trace::_id_E409((var_0, var_1, var_3), (var_0, var_1, var_2), 512, self, var_5, 1);

  if(var_6["position"][2] < var_4) {
    var_7 = var_4;
  } else {
    var_7 = var_6["position"][2];
  }

  return var_7;
}

_id_7AE4() {
  self notify("engageGround");
  self endon("engageGround");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");

  for(;;) {
    var_0 = undefined;

    if(!isDefined(self._id_24D0)) {
      [self._id_24D0, var_0] = _id_7AED();
      self notify("acquiringTarget", self._id_24D0);

      if(!isDefined(self._id_24D0)) {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);
        continue;
      }
    }

    var_2 = undefined;

    if(istrue(var_0)) {
      var_2 = self._id_24D0 scripts\cp_mp\utility\player_utility::getvehicle();
    }

    self._id_F81F _meth_8389(self._id_F81F._id_71F1);

    if(!isDefined(self._id_24CF)) {
      self setlookatent(self._id_24D0);
    }

    thread _id_7B0E(self._id_24D0);
    thread _id_7B0D(self._id_24D0, undefined, var_2);
    thread _id_7B0F(self._id_24D0);
    _id_7AEA(var_0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  }
}

_id_7AED() {
  self endon("death");
  self endon("leaving");
  var_0 = _id_09AE::_id_36C5(self._id_F81F, 3000, 0, 1);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(!_id_09AE::_id_36CA(var_5.player)) {
      continue;
    }
    var_6 = 0;
    var_7 = 0;
    var_8 = abs(vectortoangles(var_5.player.origin - self.origin)[1]);
    var_9 = abs(self gettagangles("tag_flash")[1]);
    var_8 = abs(var_8 - var_9);
    var_10 = var_5.player _meth_8194();

    foreach(var_12 in var_10) {
      var_13 = weaponclass(var_12);

      if(var_13 == "rocketlauncher") {
        var_8 = var_8 - 40;
      }
    }

    if(istrue(var_5._id_EF0F)) {
      var_7 = 1;
      var_8 = var_8 + 40;
    }

    if(!isDefined(var_1) || var_1 > var_8) {
      var_1 = var_8;
      var_2 = var_5.player;
      var_3 = var_7;
    }
  }

  return [var_2, var_3];
}

_id_7AEA(var_0) {
  var_1 = weaponfiretime("hover_jet_turret_mp");
  var_2 = 0;
  var_3 = 0;
  var_4 = 100;

  while(isDefined(self) && isDefined(self._id_24D0) && !isDefined(self._id_87D7) && !isDefined(self._id_8908)) {
    if(self._id_F81F _id_7B04()) {
      var_6 = undefined;

      if(istrue(var_0)) {
        var_6 = self._id_24D0.origin;
      } else {
        var_6 = self._id_24D0 gettagorigin("j_mainroot");
      }

      _id_09AE::_id_36D8(self._id_F81F, self._id_24D0, var_6, var_4);

      if(var_3 == 15) {
        var_4 = 50;
      } else if(var_3 == 30) {
        var_4 = undefined;
      }

      self._id_F81F _meth_83C1("tag_flash");
      var_3++;
      self._id_F81F.streakinfo._id_DA63++;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  }
}

_id_7B04() {
  var_0 = 0.996;
  var_1 = anglesToForward(self gettagangles("tag_flash"));
  var_2 = vectornormalize(self._id_71F1.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(isDefined(self _meth_817F(1)) && var_3 >= var_0) {
    return 1;
  }

  return 0;
}

_id_7AE3() {
  self notify("engageAir");
  self endon("engageAir");
  self endon("death");
  self endon("leaving");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self._id_24CF)) {
      var_0 = [];
      var_0 = scripts\engine\utility::array_combine(level._id_77D9, level._id_9593, level._id_EB9A);
      self._id_24CF = _id_7AEC(var_0);
      self notify("hoverJet_acquiringAirTarget", self._id_24CF);

      if(!isDefined(self._id_24CF)) {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
        continue;
      }
    }

    thread _id_7B0E(self._id_24CF);
    _id_7AE9();
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  }
}

_id_7AE9() {
  var_0 = "right";
  var_1 = makeweapon("hover_jet_proj_mp");
  var_2 = undefined;
  self setlookatent(self._id_24CF);

  while(isDefined(self) && isDefined(self._id_24CF)) {
    var_3 = 5;

    if(!istrue(var_2)) {
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("hover_jet_attack_air");
      var_2 = 1;
    }

    while(var_3 > 0 && isDefined(self._id_24CF) && !_id_7ADB(self._id_24CF)) {
      var_3 = var_3 - level._id_5F3A;
      waitframe();
    }

    if(isDefined(self._id_24CF)) {
      _id_7AF8(self._id_24CF);
    } else {
      break;
    }

    if(isDefined(self._id_24CF)) {
      var_5 = self gettagorigin("tag_" + var_0 + "_archer_missile") + anglesToForward(self.angles) * 100;
      var_6 = var_5 + anglesToForward(self.angles) * 100;
      var_7 = scripts\cp_mp\utility\weapon_utility::_magicbullet(var_1, var_5, var_6, self.owner);
      var_8 = _id_7B00(self._id_24CF);
      var_7 missile_settargetent(self._id_24CF, var_8);
      var_7.streakinfo = self.streakinfo;

      if(var_0 == "right") {
        var_0 = "left";
      } else {
        var_0 = "right";
      }
    } else
      break;

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  }

  if(istrue(self._id_A22B)) {
    thread _id_7AF9(self._id_41C9);
    self._id_A22B = undefined;
  }
}

_id_7B00(var_0) {
  var_1 = (0, 0, 0);

  if(isDefined(var_0.streakinfo)) {
    switch (var_0.streakinfo.streakname) {
      case "chopper_gunner":
      case "chopper_support":
        var_1 = (0, 0, -50);
        break;
      case "radar_drone_overwatch":
        var_1 = (0, 0, -30);
        break;
      case "hover_jet":
        var_1 = (0, 0, 20);
        break;
      case "scrambler_drone_guard":
        var_1 = (0, 0, 10);
        break;
    }
  }

  return var_1;
}

_id_7ADB(var_0) {
  var_1 = 0.866;
  var_2 = anglesToForward(self.angles);
  var_3 = vectornormalize(var_0.origin - self.origin);
  var_4 = vectordot(var_2, var_3);
  return scripts\engine\utility::ter_op(var_4 >= var_1, 1, 0);
}

_id_7ADA(var_0) {
  return scripts\engine\utility::ter_op(distance2dsquared(var_0.origin, self.origin) < 1000000, 1, 0);
}

_id_7AF8(var_0) {
  while(isDefined(var_0) && _id_7ADA(var_0)) {
    var_1 = undefined;
    var_2 = anglesToForward(self.angles);
    var_3 = anglestoright(self.angles);
    var_4 = self.origin - var_2 * 1000;
    var_5 = self.origin + 707.0 * (var_3 - var_2);
    var_6 = self.origin + 707.0 * (-1 * var_2 - var_3);
    var_7 = [var_4, var_5, var_6];
    var_8 = [self, var_0];

    foreach(var_10 in var_7) {
      if(scripts\engine\trace::_id_E40D(self.origin, var_10, 256, var_8)) {
        var_1 = var_10 * (1, 1, 0) + (0, 0, var_0.origin[2]);
      }
    }

    if(isDefined(var_1)) {
      self._id_A22B = 1;
      self setvehgoalpos(var_1, 1);
    }

    waitframe();
  }
}

_id_7B08() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  self setneargoalnotifydist(100);
  self._id_FE90 = spawn("script_model", self.origin);
  self._id_FE90 setModel("tag_origin");
  self._id_FE90 scripts\mp\utility\killstreak::_id_D5D2(self.owner, &"KILLSTREAKS_HINTS/HOVER_JET_GUARD", 360, 360, 30000, 30000, 2);
  self._id_FE90 linkto(self);

  while(isDefined(self._id_FE90)) {
    self._id_FE90 waittill("trigger", var_0);
    scripts\cp_mp\utility\killstreak_utility::_id_B86F("hover_jet_move");
    self setscriptablepartstate("thrusters", "active", 0);

    if(isDefined(var_0)) {
      thread _id_7AF9(var_0.origin);
      thread _id_7B07();
    }
  }
}

_id_7B07() {
  self endon("death");
  self endon("leaving");
  self waittill("near_goal");
  self setscriptablepartstate("thrusters", "idle", 0);
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("hover_jet_guard");
}

_id_7AFE() {
  self notify("random_movement");
  self endon("random_movement");
  self endon("stopRand");
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
}

_id_7AF7(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  self._id_41CA = self.health - var_4;

  if(self._id_41CA > 0) {
    if(self._id_41CA <= 2000 && self._id_41BE == 0) {
      self._id_41BE = 1;
      self setscriptablepartstate("body_damage_light", "on");
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("hover_jet_damage_light");
    } else if(self._id_41CA <= 1000 && self._id_41BE == 1) {
      self._id_41BE = 2;
      self setscriptablepartstate("body_damage_medium", "on");
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("hover_jet_damage_med");
    } else if(self._id_41CA <= 500 && self._id_41BE == 2) {
      self._id_41BE = 3;
      self setscriptablepartstate("body_damage_heavy", "on");
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("hover_jet_damage_heavy");
    }
  }

  return 1;
}

_id_7AF0(var_0) {
  self._id_8D79 = var_0.objweapon;
  return 1;
}

_id_7AF1() {
  level endon("game_ended");
  self endon("hover_jet_gone");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(!scripts\mp\utility\weapon::_id_88F6(self._id_8D79)) {
    _id_7ADE(75);
  }

  thread _id_7AE5();
}

_id_7ADE(var_0) {
  self endon("explode");
  self._id_87D7 = 1;
  self.killcament unlink();
  self.killcament.origin = self.origin + (0, 0, 100);

  if(isDefined(self._id_FE90) && isDefined(self.owner)) {
    self._id_FE90 disableplayeruse(self.owner);
  }

  self _meth_807E();
  self notify("crashing");
  self _meth_827E("ks_hoverjet_crash");
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(var_0, 20, 20);
  self setneargoalnotifydist(100);
  var_1 = _id_7AE6(2500);

  if(!isDefined(var_1)) {
    return;
  }
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("hover_jet_crash", 1);
  self setvehgoalpos(var_1, 0);
  thread _id_7B01(var_0);
  self waittill("near_goal");
  _id_09C1::_id_B8A7();
}

_id_7B01(var_0) {
  self endon("death");
  self setyawspeed(var_0, 50, 50, 0.5);

  while(isDefined(self)) {
    self _meth_838A(self.angles[1] + var_0 * 0.5);
    wait 0.5;
  }
}

_id_7AE6(var_0) {
  var_1 = self.origin;
  var_2 = 1000;
  var_3 = undefined;
  var_4 = anglesToForward(self.angles);
  var_5 = anglestoright(self.angles);
  var_6 = var_1 + var_4 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 - var_4 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + var_5 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 - var_5 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_4 + var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_4 - var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_5 - var_4) - (0, 0, var_2);
  var_7 = scripts\engine\trace::ray_trace(var_1, var_6, self);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (-1 * var_4 - var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  return var_3;
}

_id_7AE5() {
  self notify("explode");
  self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "hover_jet_turret_mp");
  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  thread _id_7ADD(1);
}

_id_7AF4() {
  self endon("death");
  self._id_8908 = 1;
  self notify("leaving");

  if(isDefined(self._id_FE90) && isDefined(self.owner)) {
    self._id_FE90 disableplayeruse(self.owner);
  }

  _id_7ADC(undefined, 1);
  self setmaxpitchroll(0, 0);
  self vehicle_setspeed(35, 25);
  var_0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_0 = var_0 + (0, 0, 900);
  self setvehgoalpos(var_0, 1);
  self _meth_8620(level._id_CC31["hover_jet"]["exit"]);
  self _meth_827E("ks_hoverjet_leave");
  self waittill("goal");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  self setscriptablepartstate("contrails", "on", 0);
  var_1 = self.origin + anglesToForward(self.angles) * 24000;
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_1, 1);
  self waittill("goal");
  self notify("hover_jet_gone");
  _id_7ADD();
}

_id_7ADD(var_0) {
  if(isDefined(self._id_F81F)) {
    self._id_F81F setentityowner(undefined);
    self._id_F81F delete();
  }

  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self._id_F81F._id_71F1)) {
    self._id_F81F._id_71F1 delete();
  }

  if(isDefined(self._id_CBD0)) {
    self._id_CBD0 delete();
  }

  self setscriptablepartstate("blinking_lights", "off", 0);
  self setscriptablepartstate("thrusters", "off", 0);
  self.streakinfo._id_57A7 = istrue(var_0);

  if(!istrue(self._id_C143)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(self.streakinfo);
  }

  level._id_7B10 = scripts\engine\utility::array_remove(level._id_7B10, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(self);
}

_id_7B0E(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("hoverJet_breakOffTarget " + var_1);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");

  if(isPlayer(var_0)) {
    thread _id_7B0A(var_0);
  } else {
    thread _id_7B05(var_0);
  }

  thread _id_7B06(var_0, "hoverJet_targetLost " + var_1);
  thread _id_7B06(var_0, "hoverJet_targetNotInView " + var_1);
  thread _id_7B06(var_0, "hoverJet_moveToNewlocation");
  thread _id_7B06(var_0, "hoverJet_targetTimeout");
}

_id_7B0A(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("hoverJet_breakOffTarget " + var_1);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  var_0 waittill("death_or_disconnect");
  self notify("hoverJet_targetLost " + var_1);
}

_id_7B05(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("hoverJet_breakOffTarget " + var_1);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  var_0 waittill("death");
  self notify("hoverJet_targetLost " + var_1);
}

_id_7B06(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  self endon("hoverJet_breakOffTarget " + var_2);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  self waittill(var_1);
  _id_7ADC(var_2);
}

_id_7B0D(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  self endon("death");
  self endon("leaving");
  self endon("hoverJet_breakOffTarget " + var_3);
  self endon("hoverJet_breakOffAllTargets");
  self._id_24D0 endon("death_or_disconnect");
  var_4 = undefined;

  if(!isDefined(var_1)) {
    var_1 = 500;
  }

  var_5 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_6 = [self._id_F81F];

  if(isDefined(var_2)) {
    var_6[var_6.size] = var_2;
    var_7 = var_2 _meth_8150();

    if(isDefined(var_7) && var_7.size > 0) {
      var_6 = scripts\engine\utility::array_combine(var_6, var_7);
    }
  }

  for(;;) {
    var_8 = scripts\engine\trace::ray_trace_passed(self._id_F81F gettagorigin("tag_barrel"), var_0 gettagorigin("j_head"), var_6, var_5);

    if(!istrue(var_8)) {
      if(!isDefined(var_4)) {
        var_4 = gettime();
      }

      if(gettime() - var_4 > var_1) {
        self notify("hoverJet_targetNotInView " + var_3);
        return;
      }
    } else
      var_4 = undefined;

    wait 0.25;
  }
}

_id_7B0F(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("death");
  self endon("leaving");
  self endon("hoverJet_breakOffTarget " + var_1);
  self endon("hoverJet_breakOffAllTargets");
  self._id_24D0 endon("death_or_disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self notify("hoverJet_targetTimeout");
}

_id_7ADC(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_0) || istrue(var_1)) {
    self._id_24D0 = undefined;
    self._id_24CF = undefined;
    self _meth_807E();
    self._id_F81F _meth_8086();
    self._id_F81F._id_71F1 unlink();
    var_2 = "Breaking off all targets";
    self notify("hoverJet_breakOffAllTargets");
    return;
  } else {
    if(isDefined(self._id_24D0) && var_0 == self._id_24D0 getentitynumber()) {
      var_2 = "Breaking off ground target: " + self._id_24D0.name;
      self._id_24D0 = undefined;
      self._id_F81F _meth_8086();
      self._id_F81F._id_71F1 unlink();
    } else if(isDefined(self._id_24CF) && var_0 == self._id_24CF getentitynumber()) {
      var_2 = "Breaking off air target: " + self._id_24CF.model;
      self._id_24CF = undefined;
    } else
      var_2 = "Breaking off removed target: " + var_0;

    if(!isDefined(self._id_24D0) && !isDefined(self._id_24CF)) {
      self _meth_807E();
    }
  }

  self notify("hoverJet_breakOffTarget " + var_0);
}

_id_7AEC(var_0) {
  self endon("death");
  self endon("leaving");
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(!istrue(var_3)) {
      if(level.teambased && var_5.team == self.team) {
        continue;
      }
      if(var_5.owner == self.owner) {
        continue;
      }
    }

    var_7 = distance2dsquared(var_5.origin, self.origin);

    if(var_7 >= 6250000) {
      continue;
    }
    if(!isDefined(var_2) || var_7 < var_2) {
      var_1 = var_5;
      var_2 = var_7;
    }
  }

  return var_1;
}