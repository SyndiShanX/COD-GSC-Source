/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2477.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "init")]]();
  }

  level._effect["chopper_gunner_explosion"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_explosion.vfx");
  level._effect["chopper_gunner_friendly_strobe"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_friendly_strobe.vfx");
  level._id_36AE = [];
  level._id_7702 = scripts\cp_mp\utility\game_utility::_id_6B17("heli_pilot_mesh");

  if(isDefined(level._id_7702)) {
    level._id_7702 hide();
  }

  game["dialog"]["chopper_gunner_attack_engage"] = "chopper_gunner_engage";
  game["dialog"]["chopper_gunner_attack_single"] = "chopper_gunner_attack_single";
  game["dialog"]["chopper_gunner_attack_multi"] = "chopper_gunner_attack_multi";
  game["dialog"]["chopper_gunner_flares"] = "chopper_gunner_flares";
  game["dialog"]["chopper_gunner_light_damage"] = "chopper_gunner_health_high";
  game["dialog"]["chopper_gunner_med_damage"] = "chopper_gunner_health_med";
  game["dialog"]["chopper_gunner_heavy_damage"] = "chopper_gunner_health_low";
  game["dialog"]["chopper_gunner_killconf_single"] = "chopper_gunner_killconf_single";
  game["dialog"]["chopper_gunner_killconf_multi"] = "chopper_gunner_killconf_multi";
  game["dialog"]["chopper_gunner_killconf_missile"] = "chopper_gunner_killconf_missile";
  game["dialog"]["chopper_gunner_lockedon"] = "chopper_gunner_lockedon";
  game["dialog"]["chopper_gunner_reattack"] = "chopper_gunner_reattack";
  game["dialog"]["chopper_gunner_crash"] = "chopper_gunner_crash";
  _id_3692();
  _id_369F();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "set_vehicle_hit_damage_data")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "set_vehicle_hit_damage_data")]]("chopper_gunner", 12);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("thermite_bolt_mp", 1, "chopper_gunner");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("chopper_gunner", 30, "thermite_bolt_mp");
  }

  level._id_7D9E = 0;
  level._id_7DA4["allies"] = 0;
  level._id_7DA4["axis"] = 0;
  scripts\cp_mp\utility\killstreak_utility::_id_C2C8("chopper_gunner", "on", 6);
}

#using_animtree("script_model");

_id_3692() {
  level._id_CC34["ks_chopper_gunner_pilot"] = #animtree;
  level._id_CC31["ks_chopper_gunner_pilot"]["pilot_intro"] = % mp_player_ahotel64_intro_01;
  level._id_CC32["ks_chopper_gunner_pilot"]["pilot_intro"] = "mp_player_ahotel64_intro_01";
  level._id_CC31["ks_chopper_gunner_pilot"]["pilot_crash"] = % mp_player_ahotel64_crash_01;
  level._id_CC32["ks_chopper_gunner_pilot"]["pilot_crash"] = "mp_player_ahotel64_crash_01";
}

#using_animtree("mp_vehicles_always_loaded");

_id_369F() {
  level._id_CC34["ks_chopper_gunner_vehicle_camera"] = #animtree;
  level._id_CC31["ks_chopper_gunner_vehicle_camera"]["vehicle_intro"] = % mp_ahotel64_intro_01;
  level._id_CC31["ks_chopper_gunner_vehicle_camera"]["vehicle_crash"] = % mp_ahotel64_crash_01;
}

_id_10D8A(var_0) {
  return 1;
}

_id_F76F() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("chopper_gunner", self);
  return _id_F770(var_0);
}

_id_F770(var_0) {
  self endon("disconnect");
  level endon("game_ended");

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B()) {
    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_killstreak_choppergunner");
  }

  var_1 = makeweapon("ks_remote_device_mp");
  var_2 = _id_09B9::_id_EA05(var_0, ::_id_10D8A);

  if(!istrue(var_2)) {
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  var_3 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level._id_59E1 + var_3 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
      }

      var_0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  level._id_7D9E++;
  var_4 = 1;

  if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
    var_4 = 2;
  }

  if(level._id_36AE.size >= var_4 || level._id_36AE.size + level._id_7D9E > var_4) {
    scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    level._id_7D9E--;
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::_id_88FE() && level.teambased) {
    var_5 = 1;
    level._id_7DA4[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::_id_6BAC(self.team, level._id_36AE) + level._id_7DA4[self.team] > var_5) {
      level._id_7D9E--;
      level._id_7DA4[self.team]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_CHOPPER_GUNNER");
      }

      var_0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  if(level.gameended) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  var_6 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  var_7 = _id_E68E(self, var_0, var_6);
  level._id_7D9E--;

  if(scripts\cp_mp\utility\game_utility::_id_88FE() && level.teambased) {
    level._id_7DA4[self.team]--;
  }

  if(!isDefined(var_7)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("chopper_gunner", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_chopper_gunner", self);
  }

  var_7 thread _id_369B(var_6);
  return 1;
}

_id_E68E(var_0, var_1, var_2) {
  var_0 _meth_865E();
  var_3 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_4 = (0, 0, 0);

  if(isDefined(var_3)) {
    var_4 = (0, 0, var_3.origin[2] - 1000);
  } else {
    var_4 = (0, 0, 1500);
  }

  var_6 = 9000;

  if(level.mapname == "mp_port2_gw") {
    var_6 = 7000;
  }

  var_7 = var_0.origin - anglesToForward(var_0.angles) * var_6 + var_4;
  var_8 = var_0.origin + anglesToForward(var_0.angles) * 2000 + var_4;
  var_9 = var_0.angles;

  if(isDefined(level._id_774A) && level._id_774A.size > 0) {
    var_10 = randomint(level._id_774A.size);
    var_11 = level._id_774A[var_10];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "findTargetStruct")) {
      var_12 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "findTargetStruct")]](var_11._id_0399, level._id_774B);

      if(isDefined(var_12)) {
        var_4 = (0, 0, var_12.origin[2] + 200);
        var_13 = var_11.origin * (1, 1, 0) + var_4;
        var_14 = var_12.origin * (1, 1, 0) + var_4;
        var_15 = vectornormalize(var_14 - var_13);
        var_16 = 9000;

        if(level.mapname == "mp_shipment") {
          var_16 = 8000;
        }

        var_7 = var_14 - var_15 * var_16;
        var_8 = var_14 + var_15 * 1000;
        var_9 = vectortoangles(var_15);
      } else {}
    }
  } else if(istrue(var_0._id_7E86) && level.script == "cp_so_aniyah") {
    if(level.players.size > 1) {
      var_17 = scripts\engine\utility::array_remove(level.players, var_0);
    } else {
      var_17 = level.players;
    }

    var_18 = scripts\engine\utility::random(var_17);
    var_19 = (var_18.origin[0], var_18.origin[1], 1750);

    while(level._id_A886.size == 0) {
      waitframe();
    }

    var_20 = scripts\engine\utility::_id_6969(var_19, level._id_A886);
    var_21 = (var_20.origin[0], var_20.origin[1], 1750);
    var_22 = vectornormalize(var_19 - var_21);
    var_7 = var_21 - var_22 * 11000;
    var_8 = var_21 - var_22 * 1000;
    var_9 = vectortoangles(var_22);
  } else
    var_0 iprintlnbold("Level is missing heli structs, please set them up!");

  var_23 = "veh8_mil_air_ahotel64_ks_mp";

  if(scripts\cp_mp\utility\player_utility::_id_6C67(var_0)) {
    var_23 = "veh8_mil_air_ahotel64_ks_east_mp";
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();

  if(istrue(var_0._id_7E86) && level.script == "cp_so_aniyah") {
    var_24 = scripts\cp_mp\vehicles\vehicle_tracking::_id_0D7D(var_0, var_7, var_9, "veh_apache_cp_so_aniyah", var_23);
  } else {
    var_24 = scripts\cp_mp\vehicles\vehicle_tracking::_id_0D7D(var_0, var_7, var_9, "veh_apache_mp", var_23);
  }

  if(!isDefined(var_24)) {
    return;
  }
  var_25 = 45;
  var_24.speed = 100;
  var_24.accel = 50;
  var_24.lifetime = var_25;
  var_24.team = var_0.team;
  var_24.owner = var_0;
  var_24.angles = var_9;
  var_24.streakinfo = var_1;
  var_24.streakname = var_1.streakname;
  var_24._id_5C8A = 1;
  var_24._id_41BE = 0;
  var_24._id_AEE6 = var_7;
  var_24._id_AEDC = var_8;
  var_24._id_9F7F = 8;
  var_24._id_18AF = "ks_chopper_gunner_vehicle_camera";
  var_24._id_7E86 = istrue(var_0._id_7E86);
  var_24 _meth_83A6(var_24.team);
  var_24 thread _id_36A5("disconnect", var_1);
  var_24 thread _id_36A5("joined_team", var_1);
  var_24 thread _id_36A5("joined_spectator", var_1);
  var_27 = 2000;

  if(istrue(level._id_8A88)) {
    var_27 = 1000;
  }

  if(var_0 scripts\cp_mp\utility\killstreak_utility::_id_0C44("specialty_reaper") && var_0 scripts\cp_mp\utility\killstreak_utility::_id_C0B7("chopper_gunner")) {
    var_27 = var_27 * 1.5;

    foreach(var_30, var_29 in var_0._id_E9FF._id_EA14) {
      if(var_29.streakname == "chopper_gunner" && istrue(var_0._id_E9FF._id_EA14[var_30]._id_C0B4)) {
        var_0._id_E9FF._id_EA14[var_30]._id_C0B4 = undefined;
      }
    }
  }

  var_24.health = int(var_27);
  var_24.maxhealth = int(var_27);
  var_24 _id_0812::_id_C2B2("Killstreak_Air", var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var_1.streakname, "destroyed_chopper_gunner", undefined, "timeout_chopper_gunner", "callout_destroyed_chopper_gunner");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var_1.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var_1.streakname, ::_id_3690);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var_1.streakname, ::_id_3687);
  }

  level._id_36AE[level._id_36AE.size] = var_24;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1.streakname, "Killstreak_Air", var_0, 0, 1, 100);
  }

  var_24 setmaxpitchroll(15, 15);
  var_24 vehicle_setspeed(var_24.speed, var_24.accel);
  var_24 sethoverparams(50, 5, 2.5);
  var_24 setturningability(1);
  var_24 setyawspeed(500, 100, 25, 0.5);
  var_24 setotherent(var_0);
  var_24 setCanDamage(1);
  var_24 setneargoalnotifydist(5000);
  var_24 _id_078D::_id_D3BA(::_id_367D);
  var_24 _id_078D::_id_D189(::_id_367C);
  var_24 setscriptablepartstate("blinking_lights", "on", 0);
  var_24 setscriptablepartstate("interior_light", "on", 0);
  var_24 setscriptablepartstate("engine", "on", 0);
  var_31 = "veh8_mil_air_ahotel64_turret_wm";

  if(scripts\cp_mp\utility\player_utility::_id_6C67(var_0)) {
    var_31 = "veh8_mil_air_ahotel64_turret_wm_east";
  }

  var_24._id_F81F = spawnturret("misc_turret", var_24 gettagorigin("tag_turret"), "apache_turret_mp");
  var_24._id_F81F setModel(var_31);
  var_24._id_F81F.owner = var_0;
  var_24._id_F81F.team = var_0.team;
  var_24._id_F81F.angles = var_24.angles;
  var_24._id_F81F.streakinfo = var_1;
  var_24._id_F81F linkto(var_24, "tag_turret");
  var_24._id_F81F _meth_83A0(var_0.team);
  var_24._id_F81F _meth_839D(0);
  var_24._id_F81F setmode("manual");
  var_24._id_F81F setotherent(var_0);
  var_24._id_F81F setdefaultdroppitch(45);
  var_24._id_A2B3 = spawn("script_model", var_24 gettagorigin("tag_gun_l"));
  var_24._id_A2B3 setModel("ks_apache_turret_mp");
  var_24._id_A2B3.angles = var_24.angles;
  var_24._id_A2B3.owner = var_24.owner;
  var_24._id_A2B3.team = var_24.team;
  var_24._id_A2B3 linkto(var_24, "tag_gun_l");
  var_24._id_A2B3 setentityowner(var_0);
  var_24._id_A2B3 setotherent(var_0);
  var_24._id_A2B4 = spawn("script_model", var_24 gettagorigin("tag_gun_r"));
  var_24._id_A2B4 setModel("ks_apache_turret_mp");
  var_24._id_A2B4.angles = var_24.angles;
  var_24._id_A2B4.owner = var_24.owner;
  var_24._id_A2B4.team = var_24.team;
  var_24._id_A2B4 linkto(var_24, "tag_gun_r");
  var_24._id_A2B4 setentityowner(var_0);
  var_24._id_A2B4 setotherent(var_0);
  var_24._id_F880 = spawn("script_model", var_24._id_F81F.origin);
  var_24._id_F880 setModel("ks_apache_turret_mp");
  var_24._id_F880.angles = var_24.angles;
  var_24._id_F880 linkto(var_24._id_F81F, "tag_player");
  var_24._id_F880 setotherent(var_0);
  var_24._id_B0CB = spawn("script_model", var_24 gettagorigin("tag_origin"));
  var_24._id_B0CB setModel("pilot_viewmodel_arms");
  var_24._id_B0CB.angles = var_24.angles;
  var_24._id_B0CB linkto(var_24, "tag_origin");
  var_24._id_B0CB._id_18AF = "ks_chopper_gunner_pilot";
  var_24._id_B0CB _id_06C6::_id_D47B();
  level notify("matchrecording_chopper", var_24);
  self notify("chopper_gunner_used");
  thread _id_369D(var_24);

  if(!istrue(var_2)) {
    var_24 setvehgoalpos(var_24._id_AEDC, 0);
    _id_09C8::_id_0D89();
    self._id_C707 = self getplayerangles();
    scripts\common\utility::_id_153E(0);
    scripts\common\utility::_id_1554(0);
    scripts\common\utility::_id_1593(0);
    scripts\common\utility::_id_158A(0);
    scripts\common\utility::_id_157E(0);
    thread _id_3679(var_24);
    self setclientomnvar("ui_apache_screens_state", 1);
    self _meth_826E(var_24, "tag_player", 1, 0, 0, 0, 0, 1);
    self _meth_8266(0);
    self painvisionoff();
    scripts\cp_mp\utility\killstreak_utility::_id_8DBE();
    var_24 playsoundtoplayer("mp_killstreak_apache_transition_lr", self);
  } else
    var_24 setvehgoalpos(var_24._id_AEDC, 1);

  scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_1.streakname, 1);
  var_24 thread _id_3693();
  var_24 thread _id_06C6::_id_1845(var_24, "vehicle_intro");
  var_24 thread _id_06C6::_id_1845(var_24._id_B0CB, "pilot_intro", "body_animate_jnt");
  var_24 thread _id_369A(3.75);
  var_32 = var_24 _id_36A0(4.25);

  if(!istrue(var_32)) {
    return;
  }
  var_24 notify("start_chopper_use");
  return var_24;
}

_id_36A5(var_0, var_1) {
  var_2 = self.owner;
  self endon("death");
  self endon("exit_chopper_intro");
  self endon("start_chopper_use");
  level endon("game_ended");
  var_2 waittill(var_0);

  if(var_0 == "disconnect") {
    level._id_7D9E--;

    if(scripts\cp_mp\utility\game_utility::_id_88FE() && level.teambased) {
      level._id_7DA4[self.team]--;
    }
  }

  if(isDefined(var_2)) {
    var_2 unlink();
    var_2 _meth_865E();
    var_2 scripts\common\utility::_id_153E(1);
    var_2 scripts\common\utility::_id_1554(1);
    var_2 scripts\common\utility::_id_1593(1);
    var_2 scripts\common\utility::_id_158A(1);
    var_2 scripts\common\utility::_id_157E(1);
    var_2 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(var_1.streakname, "off");
    var_2 setclientomnvar("ui_apache_screens_state", 0);
    var_2 painvisionon();
    var_2 scripts\cp_mp\utility\killstreak_utility::_id_8DBA();
    var_2 visionsetkillstreakforplayer("");
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_2, 0);
  }

  thread _id_367E();
  self notify("exit_chopper_intro");
}

_id_36A0(var_0) {
  self endon("death");
  self endon("exit_chopper_intro");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  return 1;
}

_id_3693() {
  self endon("death");
  self endon("exit_chopper_intro");
  self.owner endon("disconnect");
  self.owner _meth_865D();
  self.owner _meth_8660(4, 5000, 10, 10);
  wait 2;
  self.owner _meth_8660(4, 20, 5, 10);
  wait 1.5;
  self.owner _meth_8660(4, 1, 3, 10);
}

_id_3694(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_5 = self getEye();
  var_6 = self.angles;

  if(isDefined(var_1)) {
    var_5 = var_1;
  }

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  var_7 = spawn("script_model", var_5);
  var_7 setModel("tag_player");
  var_7.owner = self;
  var_7.angles = var_6;
  var_8 = undefined;
  var_9 = undefined;

  if(isDefined(var_0)) {
    var_8 = var_0.origin;
    var_9 = var_0.angles;
  }

  if(isDefined(var_3)) {
    var_8 = var_3;
  }

  if(isDefined(var_4)) {
    var_9 = var_4;
  }

  if(isDefined(var_0)) {
    _id_369A();
  } else {
    thread _id_369A();
  }

  self _meth_826E(var_7, "tag_player", 1, 0, 0, 0, 0, 1);
  self _meth_8266(0);
  self visionsetkillstreakforplayer("tac_ops_slamzoom", 0.2);
  var_7 moveto(var_8, 0.5);
  var_7 rotateto(var_9, 0.5);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self visionsetkillstreakforplayer("", 0.2);
  self unlink();
  self setplayerangles(var_9);

  if(isDefined(var_0)) {
    self _meth_826E(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
    self _meth_8266(0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
    var_0 _meth_8620(%mp_ahotel64_intro_01);
    var_0._id_B0CB _meth_82CB("mp_player_ahotel64_intro_01");
  }

  var_7 delete();
}

_id_369D(var_0) {
  var_0 endon("death");
  var_0 endon("near_goal");
  level endon("game_ended");
  var_1 = var_0.speed;
  var_2 = 0.25;

  for(;;) {
    var_1 = var_1 + var_2;
    var_0 vehicle_setspeed(var_1, var_0.accel);
    wait 0.05;
  }
}

_id_3679(var_0) {
  var_0 endon("death");
  var_0 endon("explode");
  var_0 endon("leaving");
  var_0 endon("crashing");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self earthquakeforplayer(0.07, 0.1, var_0 gettagorigin("tag_origin"), 700);
    wait 0.1;
  }
}

_id_369B(var_0) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  var_1 = self.owner;
  var_1 _meth_865E();

  if(!istrue(var_0)) {
    var_1._id_FF09 = 1;
    var_1 scripts\common\utility::_id_153E(1);
    var_1 scripts\common\utility::_id_151F(1);
    var_1 unlink();
    var_1 remotecontrolvehicle(self);
    var_1 _meth_828F(self._id_F81F);
    var_1 _id_09C8::_id_0CF9("killstreak_veh_camera_mp", "top", self.lifetime, 0);
    _id_369E();
  }

  if(!isDefined(self._id_B7AB)) {
    self._id_B7AB = spawn("script_origin", self.origin);
    self._id_B7AB linkto(self);
  }

  scripts\cp_mp\utility\weapon_utility::_id_D5E7(self, ::_id_368E);
  scripts\cp_mp\utility\weapon_utility::_id_D5E8(self, ::_id_368F);
  self setCanDamage(1);
  thread _id_368B(var_0);
  thread _id_368A(var_0);
  thread _id_36AC(var_0);
  thread _id_36A4(var_0);
  thread _id_36AA("disconnect");
  thread _id_36AA("joined_team");
  thread _id_36AA("joined_spectator");
  thread _id_36AA("team_kill_punish");
  thread _id_36A6();
  thread _id_3688(var_0);
  thread _id_3691();

  if(!self._id_7E86) {
    thread _id_3696();
    thread _id_36A1(var_0);
    thread _id_36A7(var_0);
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.lifetime * 1000));
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](::_id_3689);
  }

  if(!istrue(var_0)) {
    var_1 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(self.streakinfo.streakname, "on");
    var_1 setclientomnvar("ui_apache_screens_state", 0);
    var_1 setclientomnvar("ui_apache_controls", 1);
    var_1 setclientomnvar("ui_killstreak_weapon_1_ammo", self._id_9F7F);
    var_1 setclientomnvar("ui_killstreak_health", self.health / self.maxhealth);
    self._id_B7AB playLoopSound("veh_apache_killstreak_amb_lr");
    var_1 _meth_82FD("apache_killstreak", 1.5, "mix", "filter");
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);

  if(isDefined(level._id_7702)) {
    level._id_7702 show();
  }
}

_id_368E() {
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_gunner_lockedon");
  _id_09CA::_id_10390("missileLocking", self.owner, "killstreak");
}

_id_368F() {
  _id_09CA::_id_1037B("missileLocking", self.owner, "killstreak");
}

_id_3696() {
  level endon("game_ended");
  self waittill("chopper_gunner_ended");
  _id_369E(1);
}

_id_369E(var_0) {
  if(self._id_7E86) {
    return;
  }
  if(istrue(level._id_4AF3)) {
    return;
  }
  var_1 = isDefined(self._id_542C);
  var_2 = !_id_078D::_id_85B3() && !istrue(var_0);

  if(var_2 && !var_1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "assignTargetMarkers")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "assignTargetMarkers")]]();
    }
  } else if(!var_2 && var_1) {
    _id_079B::_id_EEDE(self._id_542C);
    _id_079B::_id_EEDE(self._id_5FBD);
    self._id_542C = undefined;
    self._id_5FBD = undefined;
  }
}

_id_3691() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("leaving", "death", "explode");
  self notify("chopper_gunner_ended");

  if(isDefined(self.owner)) {
    self.owner notify("chopper_gunner_ended");
  }
}

_id_36A2(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 scripts\engine\utility::waittill_any_2("death", "leaving");
  self delete();
}

_id_369A(var_0, var_1) {
  self endon("death");
  self endon("exit_chopper_intro");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  var_2 = 0.5;

  if(istrue(var_1)) {
    var_2 = 0;
  }

  level thread scripts\cp_mp\utility\game_utility::_id_58C7(self.owner, 1, var_2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  level thread scripts\cp_mp\utility\game_utility::_id_58C7(self.owner, 0, var_2);
}

_id_3686(var_0) {
  self endon("leaving");
  self endon("crashing");
  self endon("death");
  level endon("game_ended");
  var_1 = undefined;
  var_2 = self.origin;
  var_3 = 750;
  var_4 = 2000;
  var_5 = self.team;
  var_6 = self.lifetime;
  var_7 = self.owner;
  var_8 = 1;
  var_9 = self;
  var_10 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(isDefined(var_1) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "getCodeHandleFromScriptHandle")) {
    var_11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "getCodeHandleFromScriptHandle")]](var_1);

    for(;;) {
      var_12 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 20000), self);

      if(var_12["hittype"] != "hittype_none") {
        _func_03BE(var_11, var_12["position"]);
      }

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);
    }
  }
}

_id_368B(var_0) {
  if(!istrue(var_0)) {
    var_1 = self.owner;
    var_1 thread scripts\cp_mp\utility\player_utility::_id_10C17();
    _id_368C();

    if(isDefined(var_1)) {
      var_1 scripts\cp_mp\utility\player_utility::_id_E94B();
    }
  }
}

_id_368C(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_2 = self.owner;
  var_0 = 0;
  var_1 = ["chopper_color", "flir_0_black_to_white", "flir_1_white_to_black", "flir_2_color_gradient", "flir_3_color_gradient"];
  self._id_4208 = "chopper_color";
  var_2 visionsetkillstreakforplayer(self._id_4208);

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_0 = 1;
    var_2 scripts\cp_mp\utility\player_utility::_id_D720(1, 12, 1000);
    self._id_4208 = var_1[var_0];
    var_2 _id_09C8::_id_0CF9("killstreak_veh_camera_flir_mp", "top", self.lifetime, 0);
  }

  var_3 = 1;

  for(;;) {
    var_2 setclientomnvar("ui_killstreak_thermal_mode", var_0);
    var_2 visionsetthermalforplayer(var_1[var_0]);
    var_2 waittill("switch_thermal_mode");
    var_0++;

    if(var_0 == 1) {
      var_2 scripts\cp_mp\utility\player_utility::_id_D720(1, 12, 1000);
      self._id_4208 = var_1[var_0];
      var_2 _id_09C8::_id_0CF9("killstreak_veh_camera_flir_mp", "top", self.lifetime, 0);
      continue;
    }

    if(var_0 > var_3) {
      var_0 = 0;
      var_2 scripts\cp_mp\utility\player_utility::_id_D720(0);
      self._id_4208 = "chopper_color";
      var_2 _id_09C8::_id_0CF9("killstreak_veh_camera_mp", "top", self.lifetime, 0);
    }
  }
}

_id_368A(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_1 = self.owner;
  var_1 notifyonplayercommand("shoot_missile", "+frag");
  self._id_9F6F = undefined;
  var_2 = 0;
  var_3 = 4;

  for(;;) {
    var_1 waittill("shoot_missile", var_4);

    if(self._id_7E86 && self._id_9F7F == 8) {
      childthread _id_3695();
    }

    var_2++;
    self.streakinfo._id_DA63++;

    if(var_2 > var_3) {
      var_2 = 1;
    }

    self.owner earthquakeforplayer(0.25, 0.4, self._id_F81F.origin, 150);
    self.owner playrumbleonentity("damage_heavy");
    var_5 = self._id_A2B3;

    if(!isDefined(self._id_9F6F) || self._id_9F6F == "right") {
      self._id_9F6F = "left";
      self._id_A2B3 thread _id_3680(var_2);
      var_5 = self._id_A2B3;
    } else {
      self._id_9F6F = "right";
      self._id_A2B4 thread _id_3680(var_2);
      var_5 = self._id_A2B4;
    }

    var_6 = self._id_F81F gettagorigin("tag_pivot");
    var_7 = anglesToForward(self._id_F81F gettagangles("tag_player"));
    var_8 = var_5.origin * (1, 1, 0) + (0, 0, var_6[2]);
    var_9 = var_8 + var_7 * 100;
    var_10 = var_8 + var_7 * 1000;
    var_11 = self.owner getvieworigin();
    var_12 = anglesToForward(self.owner getplayerangles());
    var_13 = var_11 + var_12 * 50000;
    var_14 = [self, self._id_F81F, var_5];
    var_15 = scripts\engine\trace::ray_trace(var_11, var_13, var_14, scripts\engine\trace::_id_3EE5(1, 1, 0, 1, 0, 1, 0, 1, 1));
    var_16 = var_15["position"];

    if(isDefined(var_4)) {
      var_16 = var_4;
    }

    var_17 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("apache_proj_mp"), var_9, var_10, var_1);
    var_17 thread _id_36A8(var_16);
    var_17 thread _id_36A3(self.owner, 2, 300, 300);
    var_17.streakinfo = self.streakinfo;
    self._id_9F7F--;
    var_1 setclientomnvar("ui_killstreak_weapon_1_ammo", self._id_9F7F);

    if(self._id_9F7F == 0) {
      if(self._id_7E86) {
        self waittill("missiles_refilled");
        continue;
      }

      break;
    }
  }
}

_id_3695() {
  self endon("missiles_refilled");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(8.0);
  self._id_9F7F = 8;
  self.owner setclientomnvar("ui_killstreak_weapon_1_ammo", self._id_9F7F);
  self notify("missiles_refilled");
}

_id_36AC(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  for(;;) {
    self._id_F81F waittill("missile_fire", var_1);
    self.owner earthquakeforplayer(0.15, 0.1, self._id_F81F.origin, 150);
    var_1.streakinfo = self.streakinfo;
    self.streakinfo._id_DA63++;
    var_1 thread _id_36A3(self.owner, 0.5, 256, 200);
  }
}

_id_3680(var_0) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("fire_missile_" + var_0, "on", 0);
  wait 1;
  self setscriptablepartstate("fire_missile_" + var_0, "off", 0);
}

_id_36A8(var_0) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(isDefined(self)) {
    self _meth_8234(var_0);
  }
}

_id_36A7(var_0) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_1 = self.lifetime;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("timeout_chopper_gunner", 1);
  thread _id_368D(var_0);
}

_id_36A4(var_0) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level waittill("game_ended");
  self._id_C143 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(self.streakinfo);
  thread _id_368D(var_0);
}

_id_36AA(var_0) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner waittill(var_0);
  thread _id_3697(0, 0);
  thread _id_367E();
}

_id_36AB() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_gunner_attack_engage");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  for(;;) {
    var_0 = [];

    foreach(var_2 in level.players) {
      if(self.owner _meth_845E(var_2.origin, 80, 100)) {
        if(level.teambased && var_2.team == self.team) {
          continue;
        }
        if(var_2 == self.owner) {
          continue;
        }
        var_3 = [self, self._id_F81F];

        if(!scripts\cp_mp\utility\killstreak_utility::_id_E9FD(self._id_F81F gettagorigin("tag_flash"), var_2 gettagorigin("j_head"), var_3)) {
          continue;
        }
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          if(var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
            continue;
          }
        }

        var_0 = _id_3681(var_2);
        break;
      }

      wait 0.05;
    }

    if(var_0.size > 0 && var_0.size < 2) {
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_gunner_attack_single");
    } else if(var_0.size >= 2) {
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_gunner_attack_multi");
    }

    wait(randomintrange(5, 15));
  }
}

_id_3681(var_0) {
  var_1 = scripts\common\utility::_id_B7B6(var_0.origin, 300);
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

_id_36A6() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner endon("disconnect");

  for(;;) {
    self.owner waittill("update_rapid_kill_buffered", var_0, var_1);
    wait 1;

    if(isDefined(self.owner._id_C0F3)) {
      if(self.owner._id_C0F3 >= 1 && var_1 == "apache_proj_mp") {
        scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_gunner_killconf_missile");
        continue;
      }

      if(self.owner._id_C0F3 == 1) {
        scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_gunner_killconf_single");
        continue;
      }

      if(self.owner._id_C0F3 >= 2) {
        scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_gunner_killconf_multi");
      }
    }
  }
}

_id_368D(var_0) {
  self endon("death");
  self endon("crashing");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  thread _id_3697(0, var_0);
  self vehicle_setspeed(50, 25);
  var_1 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_1 = var_1 + (0, 0, 1000);
  self setvehgoalpos(var_1, 1);
  self setneargoalnotifydist(100);
  self waittill("near_goal");
  var_2 = _id_3682();
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(150, 50);
  self setvehgoalpos(var_2, 1);
  self waittill("goal");
  self notify("gone");
  thread _id_367B(0);
}

_id_3682() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

_id_3685() {
  self setCanDamage(1);
}

_id_3690(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;

  if(isDefined(self.owner) && self.owner _id_8AC7()) {
    var_6 = "light";

    if(_func_010F(var_3)) {
      if(_func_0037(var_4 / self.maxhealth) >= 0.33) {
        self.owner earthquakeforplayer(0.25, 0.2, self._id_F81F.origin, 150);
        self.owner playrumbleonentity("damage_heavy");
        var_6 = "heavy";
      } else {
        self.owner earthquakeforplayer(0.15, 0.15, self._id_F81F.origin, 150);
        self.owner playrumbleonentity("damage_light");
      }
    }

    thread _id_3698(0.2, var_6);
  }

  self._id_41CA = self.health - var_4;

  if(self._id_41CA <= 1500 && self._id_41BE == 0) {
    self._id_41BE = 1;
    self setscriptablepartstate("body_damage_light", "on");

    if(isDefined(self.owner) && self.owner _id_8AC7()) {
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_gunner_light_damage");
    }
  } else if(self._id_41CA <= 1000 && self._id_41BE == 1) {
    self._id_41BE = 2;
    self setscriptablepartstate("body_damage_medium", "on");

    if(isDefined(self.owner) && self.owner _id_8AC7()) {
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_gunner_med_damage");
    }
  } else if(self._id_41CA <= 500 && self._id_41BE == 2) {
    self._id_41BE = 3;
    self setscriptablepartstate("body_damage_heavy", "on");

    if(isDefined(self.owner) && self.owner _id_8AC7()) {
      scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_gunner_heavy_damage");
    }
  }

  self.owner setclientomnvar("ui_killstreak_health", self._id_41CA / self.maxhealth);
  return 1;
}

_id_3687(var_0) {
  self._id_8D79 = var_0.objweapon;
  return 1;
}

_id_3688(var_0) {
  self endon("gone");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.owner) && self.owner _id_8AC7()) {
    thread _id_3697(1, var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](self._id_8D79)) {
      _id_367A(150);
    }
  }

  thread _id_367E();
}

_id_367A(var_0, var_1) {
  self endon("explode");
  self _meth_807E();
  self notify("crashing");
  self _meth_827E("veh_apache_explode_mp");
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(var_0, 20, 20);
  self setneargoalnotifydist(100);
  var_2 = _id_367F(1250);

  if(!isDefined(var_2)) {
    return;
  }
  scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_gunner_crash", 1);
  self setvehgoalpos(var_2, 0);
  thread _id_3699(var_0);
  thread _id_06C6::_id_1845(self, "vehicle_crash");
  _id_06C6::_id_1845(self._id_B0CB, "pilot_crash", "body_animate_jnt");
  _id_09C1::_id_B8A7();
}

_id_3699(var_0) {
  self endon("death");
  self setyawspeed(var_0, 50, 50, 0.5);

  while(isDefined(self)) {
    self _meth_838A(self.angles[1] + var_0 * 0.6);
    wait 0.5;
  }
}

_id_367F(var_0) {
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

_id_367E() {
  self notify("explode");

  if(isDefined(self.owner)) {
    self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "apache_turret_mp");
  }

  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  thread _id_367B(1);
}

_id_367B(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - chopperGunner", self.owner);
  }

  self.streakinfo._id_57A7 = istrue(var_0);

  if(!istrue(self._id_C143)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(self.streakinfo);
  }

  self stoploopsound();

  if(isDefined(self._id_B0CB)) {
    self._id_B0CB delete();
  }

  if(isDefined(self._id_F880)) {
    self._id_F880 delete();
  }

  if(isDefined(self._id_3A17)) {
    self._id_3A17 delete();
  }

  if(isDefined(self._id_5B90)) {
    self._id_5B90 delete();
  }

  if(isDefined(self._id_F81F)) {
    self._id_F81F setentityowner(undefined);
    self._id_F81F delete();
  }

  if(isDefined(self._id_A2B3)) {
    self._id_A2B3 setentityowner(undefined);
    self._id_A2B3 delete();
  }

  if(isDefined(self._id_A2B4)) {
    self._id_A2B4 setentityowner(undefined);
    self._id_A2B4 delete();
  }

  level._id_36AE = scripts\engine\utility::array_remove(level._id_36AE, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(self);
}

_id_3697(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("disconnect");
  self._id_F880 setscriptablepartstate("camera_damage_light", "off");
  self._id_F880 setscriptablepartstate("camera_damage_medium", "off");
  self._id_F880 setscriptablepartstate("camera_damage_heavy", "off");

  if(isDefined(level._id_7702)) {
    level._id_7702 hide();
  }

  if(isDefined(self._id_B7AB)) {
    self._id_B7AB stoploopsound();
    self._id_B7AB delete();
  }

  _id_368F();
  var_2 _meth_8078(0.5);

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](self.streakinfo);
  }

  if(isDefined(var_2)) {
    if(!istrue(var_1)) {
      var_2 visionsetthermalforplayer("");
      var_2 scripts\cp_mp\utility\player_utility::_id_D720(0);
      var_2 scripts\cp_mp\utility\killstreak_utility::_id_0CF8(self.streakinfo.streakname, "off");
      var_2 setclientomnvar("ui_apache_controls", 0);
      var_2 _meth_8294();
      var_2 _meth_8290(self._id_F81F);
      var_2 visionsetkillstreakforplayer("");
      var_2 _id_09C8::_id_0D89();
      var_2 scripts\common\utility::_id_1554(1);
      var_2 scripts\common\utility::_id_1593(1);
      var_2 scripts\common\utility::_id_158A(1);
      var_2 scripts\common\utility::_id_151F(0);
      var_2 scripts\common\utility::_id_157E(1);

      if(istrue(var_0)) {
        var_2 setclientomnvar("ui_apache_screens_state", 2);
        var_2 setplayerangles(self.angles);
        var_2 _meth_826E(self, "tag_player", 1, 0, 0, 0, 0, 1);
        var_2 _meth_8266(0);
        var_2 playlocalsound("mp_killstreak_apache_death_plr");
        self waittill("explode");
        var_2 unlink();
      }

      level thread scripts\cp_mp\utility\killstreak_utility::_id_C70C(var_2);
      var_2 setclientomnvar("ui_apache_screens_state", 0);
      var_2 painvisionon();
      var_2 scripts\cp_mp\utility\killstreak_utility::_id_8DBA();
      var_2._id_FF09 = undefined;
    }
  }

  self.streakinfo notify("killstreak_finished_with_deploy_weapon");
}

_id_36A1(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("leaving");
  }

  self waittill("killstreakExit");
  thread _id_368D(var_0);
}

_id_3689(var_0, var_1, var_2, var_3) {
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

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx")) {
        var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]](undefined, var_3);
      }

      var_2 scripts\cp_mp\utility\killstreak_utility::_id_B86F("chopper_gunner_flares");
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
    }

    waitframe();
  }
}

_id_8AC7() {
  return isDefined(self._id_FF09);
}

_id_3698(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("disconnect");
  self endon("death");
  self endon("explode");
  self endon("leaving");

  if(isDefined(var_2)) {
    var_3 = _id_3684(self._id_4208);
    var_4 = _id_3683(var_3, var_1);

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

_id_3684(var_0) {
  return scripts\engine\utility::ter_op(issubstr(var_0, "flir"), "flir", "color");
}

_id_3683(var_0, var_1) {
  var_2 = undefined;

  if(var_0 == "flir") {
    var_2 = var_0 + "_0_black_to_white_" + var_1 + "_damage";
  } else {
    var_2 = "chopper_color_" + var_1 + "_damage";
  }

  return var_2;
}

_id_367D(var_0) {
  thread _id_078D::_id_B2B4(self.owner, 5);
  _id_369E();
}

_id_367C(var_0) {
  _id_369E();
}

_id_36A3(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self waittill("explode", var_4);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_4, var_2, var_3, var_0.team, var_1, var_0, 1);
  }
}