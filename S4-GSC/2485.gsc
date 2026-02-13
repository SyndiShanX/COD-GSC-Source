/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2485.gsc
*************************************************/

init() {
  level._id_786E = [];
  level._id_786E["radar_drone_recon"] = spawnStruct();
  level._id_786E["radar_drone_recon"]._id_F224 = 45.0;
  level._id_786E["radar_drone_recon"].maxhealth = 30;
  level._id_786E["radar_drone_recon"]._id_79C0 = 3;
  level._id_786E["radar_drone_recon"].speed = 140;
  level._id_786E["radar_drone_recon"].accel = 20;
  level._id_786E["radar_drone_recon"]._id_73BB = 27;
  level._id_786E["radar_drone_recon"]._id_E297 = 30;
  level._id_786E["radar_drone_recon"].streakname = "radar_drone_recon";
  level._id_786E["radar_drone_recon"].vehicleinfo = "veh_radar_drone_recon_mp";
  level._id_786E["radar_drone_recon"].modelbase = "veh8_mil_air_malfa_small";
  level._id_786E["radar_drone_recon"]._id_EFAC = "used_radar_drone_recon";
  level._id_786E["radar_drone_recon"]._id_484B = "callout_destroyed_radar_drone_recon";
  level._id_786E["radar_drone_recon"]._id_6090 = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sm_dest_exp.vfx");
  level._id_786E["radar_drone_recon"]._id_E053 = "recon_drone_explode";
  level._id_786E["radar_drone_recon"]._id_1068F = "ball_drone_backup_destroy";
  level._id_786E["radar_drone_recon"]._id_106B2 = "ball_drone_backup_timeout";
  level._id_786E["radar_drone_recon"]._id_CC16 = "destroyed_radar_drone_recon";
  level._id_786E["radar_drone_recon"]._id_1042A = 1440000;
  level._id_786E["radar_drone_recon"]._id_B841 = ::_id_786D;
  level._id_786E["radar_drone_recon"]._id_BCD2 = "MANUAL";
  level._id_786E["radar_drone_recon"]._id_BCD4 = &"KILLSTREAKS_HINTS/RCD_MANUAL";
  level._id_786E["radar_drone_recon"]._id_BCD3 = ::_id_D69B;
  level._id_786E["radar_drone_recon"]._id_BBB8 = undefined;
  level._id_786E["radar_drone_recon"]._id_BA55 = ::_id_7840;
  level._id_786E["radar_drone_recon"]._id_43E5 = ::_id_786B;
  level._id_786E["radar_drone_recon"]._id_47ED = "ks_remote_drone_mp";
  level._id_786E["radar_drone_overwatch"] = spawnStruct();
  level._id_786E["radar_drone_overwatch"]._id_F224 = 45.0;
  level._id_786E["radar_drone_overwatch"].maxhealth = 700;
  level._id_786E["radar_drone_overwatch"]._id_79C0 = 3;
  level._id_786E["radar_drone_overwatch"].speed = 100;
  level._id_786E["radar_drone_overwatch"].accel = 10;
  level._id_786E["radar_drone_overwatch"]._id_73BB = 50;
  level._id_786E["radar_drone_overwatch"]._id_E297 = 100;
  level._id_786E["radar_drone_overwatch"].streakname = "radar_drone_overwatch";
  level._id_786E["radar_drone_overwatch"].vehicleinfo = "veh_radar_drone_overwatch_mp";
  level._id_786E["radar_drone_overwatch"].modelbase = "";
  level._id_786E["radar_drone_overwatch"]._id_9FD1 = "";
  level._id_786E["radar_drone_overwatch"]._id_EFAC = "used_radar_drone_overwatch";
  level._id_786E["radar_drone_overwatch"]._id_484B = "callout_destroyed_radar_drone_overwatch";
  level._id_786E["radar_drone_overwatch"]._id_6090 = loadfx("vfx/iw8_mp/killstreak/vfx_overwatch_explosion.vfx");
  level._id_786E["radar_drone_overwatch"]._id_E053 = "radar_drone_explode";
  level._id_786E["radar_drone_overwatch"]._id_1068F = "destroyed_radar_drone_overwatch";
  level._id_786E["radar_drone_overwatch"]._id_106B2 = "timeout_radar_drone_overwatch";
  level._id_786E["radar_drone_overwatch"]._id_CC16 = "destroyed_radar_drone_overwatch";
  level._id_786E["radar_drone_overwatch"]._id_1042A = 1440000;
  level._id_786E["radar_drone_overwatch"]._id_B841 = ::_id_786D;
  level._id_786E["radar_drone_overwatch"]._id_6092 = [];
  level._id_786E["radar_drone_overwatch"]._id_6092["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_light_detonator_blink");
  level._id_786E["radar_drone_overwatch"]._id_6092["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
  level._id_786E["radar_drone_overwatch"]._id_E597 = 120;
  level._id_786E["radar_drone_overwatch"]._id_40A5 = 80;
  level._id_786E["radar_drone_overwatch"]._id_BDB0 = 46;
  level._id_786E["radar_drone_overwatch"]._id_20A8 = 124;
  level._id_786E["radar_drone_overwatch"]._id_DD1B = 55;
  level._id_786E["radar_drone_overwatch"]._id_BCD2 = "RADAR";
  level._id_786E["radar_drone_overwatch"]._id_BCD4 = &"KILLSTREAKS_HINTS/RCD_RADAR";
  level._id_786E["radar_drone_overwatch"]._id_BCD3 = ::_id_D638;
  level._id_786E["radar_drone_overwatch"]._id_BBB8 = undefined;
  level._id_786E["radar_drone_overwatch"]._id_BA55 = ::_id_7841;
  level._id_786E["radar_drone_overwatch"]._id_43E5 = ::_id_786B;
  level._id_786E["radar_drone_overwatch"]._id_47ED = "ks_gesture_generic_mp";
  level._id_786E["scrambler_drone_guard"] = spawnStruct();
  level._id_786E["scrambler_drone_guard"]._id_F224 = 45.0;
  level._id_786E["scrambler_drone_guard"].maxhealth = 300;
  level._id_786E["scrambler_drone_guard"].speed = 140;
  level._id_786E["scrambler_drone_guard"].accel = 20;
  level._id_786E["scrambler_drone_guard"]._id_73BB = 50;
  level._id_786E["scrambler_drone_guard"]._id_E297 = 100;
  level._id_786E["scrambler_drone_guard"].streakname = "scrambler_drone_guard";
  level._id_786E["scrambler_drone_guard"].vehicleinfo = "veh_scrambler_drone_guard_mp";
  level._id_786E["scrambler_drone_guard"].modelbase = "veh8_mil_air_cuniform";
  level._id_786E["scrambler_drone_guard"]._id_9FD1 = "veh8_mil_air_cuniform_east";
  level._id_786E["scrambler_drone_guard"]._id_EFAC = "used_scrambler_drone_guard";
  level._id_786E["scrambler_drone_guard"]._id_484B = "callout_destroyed_scrambler_drone_guard";
  level._id_786E["scrambler_drone_guard"]._id_6090 = loadfx("vfx/iw8_mp/killstreak/vfx_drone_dest_exp.vfx");
  level._id_786E["scrambler_drone_guard"]._id_E053 = "scrambler_drone_explode";
  level._id_786E["scrambler_drone_guard"]._id_1068F = "destroyed_scrambler_drone_guard";
  level._id_786E["scrambler_drone_guard"]._id_106B2 = "timeout_scrambler_drone_guard";
  level._id_786E["scrambler_drone_guard"]._id_CC16 = "destroyed_scrambler_drone_guard";
  level._id_786E["scrambler_drone_guard"]._id_1042A = 1440000;
  level._id_786E["scrambler_drone_guard"]._id_B841 = ::_id_786D;
  level._id_786E["scrambler_drone_guard"]._id_6092 = [];
  level._id_786E["scrambler_drone_guard"]._id_6092["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_light_detonator_blink");
  level._id_786E["scrambler_drone_guard"]._id_6092["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
  level._id_786E["scrambler_drone_guard"]._id_BCD3 = ::_id_D584;
  level._id_786E["scrambler_drone_guard"]._id_BBB8 = undefined;
  level._id_786E["scrambler_drone_guard"]._id_BA55 = ::_id_7841;
  level._id_786E["scrambler_drone_guard"]._id_43E5 = ::_id_786B;
  level._id_786E["scrambler_drone_guard"]._id_4311 = ::_id_7853;
  level._id_786E["scrambler_drone_guard"]._id_47ED = "ks_remote_map_mp";
  var_0 = "br";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
  }

  if(var_0 == "br" || var_0 == "cp_survival") {
    level._id_786E["radar_drone_recon"]._id_4987 = 1;
    level._id_786E["scrambler_drone_guard"]._id_4987 = 1;
    level._id_786E["radar_drone_overwatch"]._id_4987 = 1;
  }

  level._id_786E["ammo_drop"] = spawnStruct();
  level._id_786E["ammo_drop"]._id_F224 = undefined;
  level._id_786E["ammo_drop"].maxhealth = 100;
  level._id_786E["ammo_drop"]._id_79C0 = 3;
  level._id_786E["ammo_drop"].speed = 60;
  level._id_786E["ammo_drop"].accel = 20;
  level._id_786E["ammo_drop"]._id_73BB = 30;
  level._id_786E["ammo_drop"]._id_E297 = 100;
  level._id_786E["ammo_drop"].streakname = "ammo_drop";
  level._id_786E["ammo_drop"].vehicleinfo = "veh_delivery_drone_recon_mp";
  level._id_786E["ammo_drop"].modelbase = "veh8_mil_air_malfa_big";
  level._id_786E["ammo_drop"]._id_EFAC = "used_radar_drone_recon";
  level._id_786E["ammo_drop"]._id_484B = "callout_destroyed_radar_drone_overwatch";
  level._id_786E["ammo_drop"]._id_6090 = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sm_dest_exp.vfx");
  level._id_786E["ammo_drop"]._id_E053 = "radar_drone_explode";
  level._id_786E["ammo_drop"]._id_1068F = "ball_drone_backup_destroy";
  level._id_786E["ammo_drop"]._id_106B2 = "ball_drone_backup_timeout";
  level._id_786E["ammo_drop"]._id_CC16 = "destroyed_radar_drone_recon";
  level._id_786E["ammo_drop"]._id_1042A = 1440000;
  level._id_786E["ammo_drop"]._id_B841 = ::_id_786D;
  level._id_786E["ammo_drop"]._id_E597 = 120;
  level._id_786E["ammo_drop"]._id_40A5 = 80;
  level._id_786E["ammo_drop"]._id_BDB0 = 46;
  level._id_786E["ammo_drop"]._id_20A8 = 124;
  level._id_786E["ammo_drop"]._id_DD1B = 55;
  level._id_786E["ammo_drop"]._id_BCD3 = ::_id_D50D;
  level._id_786E["ammo_drop"]._id_BBB8 = undefined;
  level._id_786E["ammo_drop"]._id_BA55 = ::_id_7840;
  level._id_786E["ammo_drop"]._id_43E5 = ::_id_786B;
  level._id_786E["ammo_drop"]._id_47ED = "ks_gesture_generic_mp";
  level._effect["scrambler_screen"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sc_a.vfx");
  level._effect["scrambler_screen_1"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sc_1.vfx");
  level._effect["scrambler_screen_2"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sc_2.vfx");
  level._effect["scrambler_screen_3"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sc_3.vfx");
  level._effect["scrambler_screen_4"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sc_4.vfx");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "init")]]();
  }

  level._id_7DA6 = [];
  _id_7FB3();
  _id_7FB2();
}

_id_7FB3() {
  game["dialog"]["radar_drone_damage_high"] = "radar_drone_health_low";
  game["dialog"]["radar_drone_damage_med"] = "radar_drone_health_med";
  game["dialog"]["radar_drone_damage_light"] = "radar_drone_health_high";
}

#using_animtree("script_model");

_id_7FB2() {
  level._id_CC34["scrambler_drone_guard"] = #animtree;
  level._id_CC31["scrambler_drone_guard"]["rotor_spin"] = [%mp_cuniform_rotor_spin];
  level._id_CC32["scrambler_drone_guard"]["rotor_spin"] = "mp_cuniform_rotor_spin";
}

_id_10D91(var_0) {
  if(var_0.streakname == "scrambler_drone_guard") {
    var_1 = _id_F788(var_0, 1);

    if(var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_COUNTER_UAV");
      }

      return 0;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "startMapSelectSequence")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "startMapSelectSequence")]](0, 0, undefined, 1);
    }
  }

  return 1;
}

_id_10BF(var_0) {
  level._id_7DA6[level._id_7DA6.size] = spawnStruct();
  level._id_7DA6[level._id_7DA6.size - 1].type = var_0.streakname;
  level._id_7DA6[level._id_7DA6.size - 1].owner = self;
  level._id_7DA6[level._id_7DA6.size - 1].team = self.team;
}

_id_C4D4(var_0) {
  if(level._id_7DA6.size == 0) {
    return;
  }
  var_1 = [];

  foreach(var_3 in level._id_7DA6) {
    if(var_3.type == var_0.streakname && var_3.owner == self) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  level._id_7DA6 = var_1;
}

_id_10C0(var_0, var_1) {
  _id_10BF(var_0);

  if(_id_56CF(var_0, self)) {
    _id_C4D4(var_0);
    return 0;
  }

  return 1;
}

_id_7DF0(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level._id_59E1 + 1 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(istrue(var_1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
        }
      }

      return 0;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]](1);
  }

  return 1;
}

_id_C120(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var_1);
  }

  var_3 = _id_F787("radar_drone_recon");

  if(!var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_recondrone", var_1);
    }
  }
}

_id_CC59(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var_1);
  }

  var_3 = _id_F787("scrambler_drone_guard");

  if(!var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_scramblerdrone", var_1);
    }
  }
}

_id_BF0F(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var_1);
  }

  var_3 = _id_F787("radar_drone_overwatch");

  if(!var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_radardrone", var_1);
    }
  }
}

_id_F787(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_4056(var_0, self);
  return _id_F789(var_1);
}

_id_F789(var_0) {
  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  var_1 = 0;

  if(var_0.streakname == "scrambler_drone_guard") {
    var_1 = 1;
  }

  if(!var_1) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B()) {
      return 0;
    }
  }

  var_2 = "s4_ks_gesture_generic_mp";
  var_3 = makeweapon(var_2);
  var_4 = _id_09B9::_id_EA01(var_0, var_3);

  if(!istrue(var_4)) {
    if(!var_1) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    }

    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      if(!var_1) {
        scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      }

      return 0;
    }
  }

  var_5 = var_0.streakname;

  if(var_5 != "scrambler_drone_guard") {
    var_6 = _id_F788(var_0, 1);

    if(var_6) {
      if(!var_1) {
        scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      }

      if(var_2 != "ks_gesture_generic_mp") {
        var_0 notify("killstreak_finished_with_deploy_weapon");
      }

      return 0;
    }
  }

  var_7 = _id_5AD3(var_5, 0);

  if(var_2 == "ks_remote_device_mp") {
    if(!isDefined(var_7)) {
      if(!var_1) {
        scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
      }

      var_0 notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(var_2 == "ks_remote_drone_mp") {
    var_8 = 0.6;
    var_9 = 2;
    var_10 = scripts\engine\utility::_id_108A8(var_8, "death", "weapon_switch_started");

    if(!isDefined(var_10) || var_10 != "timeout") {
      if(!var_1) {
        scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      }

      var_0 notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }

    scripts\common\utility::_id_1593(0);
    var_10 = scripts\engine\utility::_id_108A7(var_9 - var_8, "death");

    if(!isDefined(var_10) || var_10 != "timeout") {
      if(!var_1) {
        scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      }

      scripts\common\utility::_id_1593(1);
      var_0 notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }

    scripts\common\utility::_id_1593(1);
  }

  var_11 = undefined;

  if(var_2 == "ks_remote_map_mp") {
    var_11 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getSelectMapPoint")) {
      var_11 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getSelectMapPoint")]](var_0, 1);
    }

    if(!isDefined(var_11)) {
      if(!var_1) {
        scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      }

      return 0;
    }
  }

  var_12 = self.angles;
  var_13 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    var_13 = 2.0;
  }

  if(isDefined(var_11)) {
    if(var_5 == "scrambler_drone_guard") {
      var_14 = var_11[0]._id_96CF + (0, 0, 3000);
      var_15 = _id_3FEF(var_14, var_12, var_5, var_0, var_1, !var_1);

      if(!isDefined(var_15)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE");
        }

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        _id_C4D4(var_0);
        return 0;
      }

      var_15._id_9AC2 = var_11;
      var_15 thread _id_AFCB();
      _id_C4D4(var_0);
      thread _id_E6B9(var_15);
    }
  } else {
    if(var_5 == "radar_drone_escort" || var_5 == "radar_drone_recon") {
      var_7 = _id_5AD3(var_5, 0);
    }

    if(var_5 == "radar_drone_overwatch") {
      var_7 = self.origin + (0, 0, 1500) - anglesToForward(self.angles) * 5000;
    }

    var_15 = _id_3FEF(var_7, var_12, var_5, var_0, var_1, !var_1);

    if(!isDefined(var_15)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
      }

      _id_786A(var_5, var_7);
      var_0 notify("killstreak_finished_with_deploy_weapon");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      }

      _id_C4D4(var_0);
      return 0;
    }

    if(var_5 == "radar_drone_recon") {
      thread _id_782D(var_0);
    }

    _id_C4D4(var_0);
    thread _id_E6B9(var_15);
  }

  thread scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_0.streakname, 1, var_13);
  var_16 = level._id_786E[var_5]._id_EFAC;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var_16, self);
  }

  return 1;
}

_id_786A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self getEye() + (0, 0, 80);
  }

  var_2 = spawn("script_model", var_1);
  var_2 setModel("ks_" + var_0 + "_mp");
  var_2 setscriptablepartstate("explode", "on", 0);
  var_2 thread _id_4655("explode");
}

_id_F788(var_0, var_1) {
  if(scripts\cp_mp\utility\player_utility::_id_8ACE()) {
    return 1;
  }

  if(istrue(self._id_4FCE)) {
    if(var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE");
      }
    }

    return 1;
  }

  if(var_0.streakname == "radar_drone_recon" && !self isonground() && !self isonladder()) {
    if(var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/FIELD_UPGRADE_CANNOT_USE");
      }
    }

    return 1;
  }

  var_2 = _id_7DF0(var_0, var_1);

  if(!var_2) {
    return 1;
  }

  var_3 = _id_10C0(var_0, var_1);

  if(!var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]](1);
    }

    return 1;
  }

  return 0;
}

_id_4655(var_0) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  self delete();
}

_id_3FEF(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = !istrue(var_4) && istrue(var_5);

  if(!isDefined(var_0)) {
    if(!istrue(var_6)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
    }
  } else {
    var_7 = level._id_786E[var_2];
    var_8 = var_7.modelbase;

    if(scripts\cp_mp\utility\player_utility::_id_6C67(self) && isDefined(var_7._id_9FD1)) {
      var_8 = var_7._id_9FD1;
    }

    var_9 = undefined;

    if(istrue(var_4)) {
      var_9 = spawn("script_model", var_0);
      var_9 setModel(var_8);
      var_9._id_A5B4 = 1;
    } else {
      if(var_6) {
        scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      }

      var_9 = scripts\cp_mp\vehicles\vehicle_tracking::_id_0D7D(self, var_0, var_1, var_7.vehicleinfo, var_8);
    }

    if(!isDefined(var_9)) {
      return;
    }
    var_9 _meth_80D1();
    var_9 setnodeploy(1);
    var_9.health = var_7.maxhealth;
    var_9.maxhealth = var_7.maxhealth;
    var_9._id_014E = 0;
    var_9.speed = var_7.speed;
    var_9.accel = var_7.accel;
    var_9.angles = var_1;
    var_9._id_9A6A = 50;
    var_9.owner = self;
    var_9.team = self.team;
    var_9._id_786F = var_2;
    var_9._id_010D = var_7._id_BCD2;
    var_9._id_41F9 = var_7._id_CFE6;
    var_9.streakinfo = var_3;
    var_9._id_41BE = 0;

    if(istrue(var_9._id_A5B4)) {
      var_9 _id_0812::_id_C2B2("Tactical_Moving", self, undefined, undefined, 0, 1);
    } else {
      var_9 _id_0812::_id_C2B2("Lethal_Moving", self);
      var_9 _meth_83A6(var_9.team);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
      var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var_7.streakname, var_7._id_CC16, var_7._id_1068F, undefined, var_7._id_484B);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
      var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var_3.streakname, var_7._id_BBB8);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
      var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var_3.streakname, var_7._id_BA55);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
      var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var_3.streakname, var_7._id_43E5);
    }

    if(isDefined(var_7._id_5C88)) {
      var_9._id_5C8A = var_7._id_5C88;
    }

    var_9 setotherent(self);
    var_9 setCanDamage(1);

    if(istrue(var_4)) {
      var_9 _meth_856D();
      var_9 _meth_85AF();
    } else {
      var_9 _meth_850D(1);
      var_9 _meth_850C(1);
    }

    var_11 = 12;

    switch (var_2) {
      case "radar_drone_overwatch":
        var_11 = 60;
        break;
      case "scrambler_drone_escort":
        var_12 = var_9 _id_784D("medium");
        var_9._id_CC54 = var_12;
        break;
      case "scrambler_drone_guard":
        var_11 = 100;
        break;
      case "radar_drone_recon":
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
            var_9 _meth_86A2(0);

            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakUseDialog")) {
              [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakUseDialog")]]("radar_drone_recon");
            }
          }
        }

        break;
      default:
        break;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
      var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_3.streakname, "Killstreak_Air", var_9.owner, 0, 1, var_11);
    }

    var_9._id_1E2B = 10000;
    var_9._id_1E2A = 150;
    var_9._id_1E2E = _func_014B(var_9, var_9._id_1E2B, var_9._id_1E2A);
    var_9._id_EAAB = 0;
    var_9._id_7D83 = 0;
    var_9 thread _id_7848();
    var_13 = spawnStruct();
    var_13._id_FF41 = 1;
    var_13._id_43F7 = ::_id_7845;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "handlemovingplatforms")) {
      var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "handlemovingplatforms")]](var_13);
    }

    if(isDefined(level._id_786E[var_9._id_786F].streakname)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
        var_9.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_7.streakname, var_9._id_EEF5);
      }
    }
  }
}

_id_7830() {
  foreach(var_1 in level.players) {
    if(level.teambased && var_1.team == self.team || !level.teambased && var_1 == self.owner) {
      self hidefromplayer(var_1);
    }
  }

  thread _id_783A();
}

_id_783A() {
  self endon("death");
  self endon("leaving");
  self endon("explode");

  for(;;) {
    level waittill("joined_team", var_0);

    if(level.teambased && var_0.team == self.team) {
      self hidefromplayer(var_0);
      continue;
    }

    self showtoplayer(var_0);
  }
}

_id_7822() {
  self notify("scramble_super_finished");

  if(isDefined(self._id_5374) && self._id_5374.size > 0) {
    foreach(var_1 in self._id_5374) {
      if(isDefined(var_1)) {
        var_2 = var_1;

        if(isDefined(var_2.owner)) {
          var_2 = var_2.owner;
        }

        var_2 notify("scramble_off");
      }
    }
  }

  if(isDefined(self._id_5F72) && self._id_5F72.size > 0) {
    foreach(var_5 in self._id_5F72) {
      if(isDefined(var_5)) {
        var_5 notify("scramble_off");
      }
    }
  }
}

_id_7866(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("scramble_super_finished");

  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  self._id_5374 = [];
  var_1 = 0;
  var_2 = 1000;
  var_3 = physics_createcontents(["physicscontents_characterproxy"]);
  var_4 = self.origin;
  var_5 = (var_2, var_2, 3000);
  var_6 = var_4 - var_5;
  var_7 = var_4 + var_5;

  for(;;) {
    var_8 = _func_02BF(var_6, var_7, var_3, []);

    foreach(var_10 in level.players) {
      if(scripts\engine\utility::array_contains(var_8, var_10)) {
        var_11 = var_10;
        var_12 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          var_12 = var_11[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_scrambler_resist");
        }

        var_13 = distance2dsquared(self.origin, var_11.origin);
        var_14 = var_2 * var_2;

        if(isDefined(var_11) && var_13 < var_14 && var_11 scripts\cp_mp\utility\player_utility::_isalive() && !var_12) {
          if(var_1 || level.teambased && var_11.team != self.team && var_11.team != "spectator" || !level.teambased && var_11 != self.owner) {
            if(var_11 scripts\cp_mp\utility\player_utility::_id_8ACE()) {
              continue;
            }
            if(var_11 _id_7823(self, var_1)) {
              continue;
            }
            var_11 _id_784A(1, self, var_1);
            var_11._id_8A19 = 1;
          } else if(isDefined(var_11._id_CC52) && var_11._id_CC52 == self) {
            if(scripts\engine\utility::array_contains(self._id_5374, var_11)) {
              self._id_5374 = scripts\engine\utility::array_remove(self._id_5374, var_11);
            } else {
              self._id_5374 = scripts\engine\utility::_id_1BD1(self._id_5374);
            }

            if(var_11 _id_7823(self, var_1)) {
              continue;
            }
            if(var_11 scripts\cp_mp\utility\player_utility::_id_8ACE()) {
              continue;
            }
            var_11 notify("scramble_off");
          }
        }

        continue;
      }

      var_15 = var_10;

      if(isDefined(var_15._id_8A19) && var_15._id_8A19) {
        var_15 notify("scramble_off");
      }
    }

    waitframe();
  }
}

_id_784B(var_0, var_1) {
  if(_id_7823(var_1) && istrue(var_0)) {
    return;
  }
  if(istrue(var_0)) {
    var_1._id_5F72[var_1._id_5F72.size] = self;
    thread _id_7839(var_1);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_blindeye");
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_noscopeoutline");
    }
  } else if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_blindeye");
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_noscopeoutline");
    }
  }
}

_id_7839(var_0) {
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "scramble_off");
  _id_784B(0, var_0);
}

_id_784A(var_0, var_1, var_2) {
  var_3 = self;

  if(istrue(var_0)) {
    if(isDefined(var_3._id_41EC)) {
      return;
    }
    var_3._id_CC52 = var_1;

    if(!scripts\engine\utility::array_contains(var_1._id_5374, var_3)) {
      var_1._id_5374[var_1._id_5374.size] = var_3;
    }

    var_3 thread _id_7838(var_1, var_2);
    var_3 thread _id_7867(var_1);
  } else if(isDefined(var_3)) {
    var_3._id_CC52 = undefined;
    var_3 _id_078D::_id_E891(var_3._id_41EC);
    var_3._id_BC43 = undefined;
    var_3._id_41EC = undefined;
  }
}

_id_7838(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("death", "scramble_off");

  if(isDefined(self)) {
    if(isDefined(var_0) && isDefined(var_0._id_5374)) {
      var_0._id_5374 = scripts\engine\utility::array_remove(var_0._id_5374, self);
    }
  }

  _id_784A(0, var_0, var_1);
}

_id_7864(var_0, var_1) {
  var_0 endon("death");
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.owner)) {
    if(self.owner _id_7823(var_0, var_1)) {
      self.owner _id_784A(0, var_0, var_1);
    }
  }
}

_id_7867(var_0) {
  self endon("death");
  self endon("scramble_off");
  self endon("disconnect");
  var_0 endon("death");
  var_1 = 0;
  var_2 = 0;
  var_3 = 1000;
  var_4 = var_3 * var_3;

  for(;;) {
    var_5 = distance2dsquared(var_0.origin, self.origin);

    if(var_5 > var_4) {
      var_2 = 0;
    } else if(var_5 >= var_4 * 0.8) {
      var_2 = 1;
    } else if(var_5 >= var_4 * 0.6) {
      var_2 = 2;
    } else if(var_5 >= var_4 * 0.4) {
      var_2 = 3;
    } else if(var_5 >= var_4 * 0.2) {
      var_2 = 4;
    } else {
      var_2 = 5;
    }

    if(var_1 == 0 || var_2 != var_1) {
      self._id_BC43 = var_1;
      self._id_41EC = var_2;

      if(self._id_BC43 > 1) {
        var_6 = self._id_BC43;
      }

      if(self._id_41EC > 1) {
        var_6 = self._id_41EC;
      }

      _id_078D::_id_E891(var_1);
      _id_078D::_id_B21E(var_2);
      var_1 = var_2;
    }

    waitframe();
  }
}

_id_7823(var_0, var_1) {
  var_2 = 0;
  var_3 = undefined;

  if(isDefined(level._id_EB9A) && level._id_EB9A.size > 0) {
    foreach(var_5 in level._id_EB9A) {
      if(var_5._id_786F != "scrambler_drone_guard") {
        continue;
      }
      if(level.teambased) {
        if(!isDefined(var_1) && var_5.team == self.team) {
          var_3 = var_5._id_5F72;
        } else {
          var_3 = var_5._id_5374;
        }
      } else if(!isDefined(var_1) && var_5.owner == self)
        var_3 = var_5._id_5F72;
      else {
        var_3 = var_5._id_5374;
      }

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.size > 0) {
        foreach(var_7 in var_3) {
          if(self == var_7 || isDefined(var_7.owner) && self == var_7.owner) {
            var_2 = 1;
            break;
          }
        }

        if(istrue(var_2)) {
          break;
        }
      }
    }
  }

  return var_2;
}

_id_7821(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1.owner = self.owner;
  var_1.team = self.owner.team;
  self._id_BF09 = var_1;

  if(var_0 == "auto_radar") {
    var_1 _meth_8222(self.owner);
  } else if(var_0 == "escort_radar") {
    var_1 setentityowner(self.owner);
    var_1 setotherent(self.owner);
    var_1 setModel("ks_radar_drone_escort_mp");
  } else if(var_0 == "recon_radar") {
    var_1 setentityowner(self.owner);
    var_1 setotherent(self.owner);
    var_1 setModel("ks_radar_drone_recon_mp");
    var_2 = 1.5;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_improved_target_mark")) {
        var_2 = var_2 * getdvarfloat("#x36b87504ff491b356");
      }
    }

    thread _id_7863(500, 10, 0.1, var_2);
  }

  var_1 linkto(self);
}

_id_7863(var_0, var_1, var_2, var_3) {
  self endon("death");
  self.trigger = spawn("trigger_rotatable_radius", self.origin, 0, var_0, var_0);

  for(;;) {
    self.trigger waittill("trigger", var_4);

    if(!isPlayer(var_4)) {
      continue;
    }
    if(level.teambased) {
      if(var_4.team == self.team) {
        continue;
      }
    }

    if(var_4 == self.owner) {
      continue;
    }
    for(var_5 = 0; var_5 < 3; var_5++) {
      var_6 = var_0 / var_1 * 0.05 * 1000;

      if(level.teambased) {
        _func_02DC(self._id_BF09.origin, self._id_BF09.team, var_0, int(var_6 / 2));
      } else {
        _func_0251(self._id_BF09.origin, self._id_BF09.owner, var_0, int(var_6 / 2));
      }

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
      self._id_BF09 setscriptablepartstate("pulse", "on", 0);
      self playSound("oracle_radar_pulse_npc");
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6 / 1000);
      self._id_BF09 setscriptablepartstate("pulse", "off", 0);
    }

    self notify("death");
  }
}

_id_781E() {
  if(isDefined(self._id_BF09)) {
    self._id_BF09 delete();
  }
}

_id_784D(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self.origin);
  var_3.team = self.owner.team;
  var_3 _meth_8223(self.owner, var_0);
  var_3 linkto(self);
  return var_3;
}

_id_7845(var_0) {
  if(!isDefined(var_0._id_90AD._id_4846) || var_0._id_90AD._id_4846) {
    self notify("death");
  }
}

_id_7848() {
  var_0 = level._id_786E[self._id_786F];

  if(isDefined(var_0._id_B841)) {
    self[[var_0._id_B841]]();
  }
}

_id_786D() {
  self setscriptablepartstate("lights", "on", 0);

  if(self._id_786F == "radar_drone_overwatch") {
    self setscriptablepartstate("glint", "on", 0);
    self setscriptablepartstate("engine", "on", 0);
  }

  if(self._id_786F == "radar_drone_recon") {
    self setscriptablepartstate("glint", "on", 0);
  }

  if(self._id_786F == "ammo_drop") {
    self setscriptablepartstate("glint", "on", 0);
  }
}

_id_E6B9(var_0) {
  level endon("game_ended");
  var_0 endon("death");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  var_1 = level._id_786E[var_0._id_786F];

  if(isDefined(var_1._id_4311)) {
    var_0 thread[[var_1._id_4311]]();
  }

  var_0 thread _id_7869();
  var_0 thread _id_785B();
  var_0 thread _id_785A();
  var_0 thread _id_7865();
  var_0 thread _id_781D();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

    if(var_2 == "br") {
      var_0 thread _id_7852(self);
    }
  }

  var_0 setCanDamage(1);
  var_0 thread[[var_1._id_BCD3]](var_1);
}

_id_7824(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("target_assist");
  self endon("player_defend");
  self endon("switch_modes");

  if(!isDefined(self.owner)) {
    thread _id_7835();
    return;
  }

  self.owner endon("disconnect");
  self endon("owner_gone");

  for(;;) {
    var_1 = self.owner getstance();

    if(!isDefined(self._id_8F46) || var_1 != self._id_8F46 || istrue(self._id_E91E)) {
      if(istrue(self._id_E91E)) {
        self._id_E91E = undefined;
      }

      self._id_8F46 = var_1;
      _id_7844(self.owner, var_0);
    }

    wait 0.5;
  }
}

_id_7846() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
  }

  self.owner._id_DCF8 = 1;
  self.owner thread _id_784C(self);
  var_0 = 1;
  self vehicle_setspeed(200, 50, 10);

  for(;;) {
    var_1 = undefined;

    if(istrue(var_0)) {
      var_2 = self.origin;
      var_3 = self.owner.origin * (1, 1, 0) + (0, 0, self.origin[2]);
      var_1 = scripts\engine\trace::ray_trace(var_2, var_3, self);
    }

    var_4 = self.owner.origin[0];
    var_5 = self.owner.origin[1];

    if(isDefined(var_1)) {
      if(var_1["hittype"] != "hittype_none") {
        var_4 = var_1["position"][0];
        var_5 = var_1["position"][1];
      }
    }

    var_6 = _id_6988(var_4, var_5, 20);
    var_7 = (var_4, var_5, var_6);
    self setlookatent(self.owner);
    self setvehgoalpos(var_7, 1);
    scripts\engine\utility::waittill_any_2("goal", "begin_evasive_maneuvers");

    if(istrue(var_0)) {
      var_0 = undefined;
      self vehicle_setspeed(level._id_786E[self._id_786F].speed, 10, 10);
    }

    self _meth_807E();
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

_id_6988(var_0, var_1, var_2) {
  var_3 = 1500;
  var_5 = _id_F3CB(var_0, var_1);
  var_6 = var_5 + var_3;
  var_6 = var_6 + randomint(var_2);
  return var_6;
}

_id_F3CB(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  var_2 = -99999;
  var_3 = self.origin[2] + 2000;
  var_4 = level._id_1F9C;
  var_5 = [self];
  var_6 = scripts\engine\trace::_id_E409((var_0, var_1, var_3), (var_0, var_1, var_2), 256, var_5, undefined, 1);

  if(var_6["position"][2] < var_4) {
    var_7 = var_4;
  } else {
    var_7 = var_6["position"][2];
  }

  return var_7;
}

_id_7847() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  var_0 = 300;
  var_1 = 1200;

  if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
    var_0 = 1000;
    var_1 = 2500;
  }

  self._id_B0E0 = [];

  for(;;) {
    var_2 = scripts\common\utility::_id_B7BF(self.owner.origin, var_1);

    foreach(var_4 in var_2) {
      if(var_4 == self.owner) {
        continue;
      }
      if(level.teambased && var_4.team == self.owner.team) {
        continue;
      }
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var_4)) {
          continue;
        }
      }

      if(var_4 _id_7833(self)) {
        continue;
      }
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_ghost")) {
          continue;
        }
      }

      _func_0251(var_4.origin, self.owner, var_0, 3000);
      thread _id_785D(var_4, self.owner);
    }

    waitframe();
  }
}

_id_785D(var_0, var_1) {
  self endon("death");
  var_0 endon("disconnect");
  level endon("game_ended");
  self._id_B0E0[self._id_B0E0.size] = var_0;
  var_0 scripts\engine\utility::_id_108A7(3, "death");
  self._id_B0E0 = scripts\engine\utility::array_remove(self._id_B0E0, var_0);
}

_id_7833(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0._id_B0E0) {
    if(isDefined(var_3) && self == var_3) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_7827(var_0) {
  var_1 = var_0._id_E597;
  var_2 = self.owner getstance();

  switch (var_2) {
    case "stand":
      var_1 = var_0._id_E597;
      break;
    case "crouch":
      var_1 = var_0._id_40A5;
      break;
    case "prone":
      var_1 = var_0._id_BDB0;
      break;
  }

  return var_1;
}

_id_782E() {
  self._id_E91E = 1;
  var_0 = self.origin[2] / 2;
  var_1 = self._id_9AC2[0]._id_96CF + (0, 0, var_0);
  var_2 = scripts\engine\trace::_id_E409(self.origin, var_1, 200, self);

  if(isDefined(var_2)) {
    if(isDefined(var_2["entity"])) {
      var_1 = var_2["entity"].origin + (0, 0, randomintrange(50, 150));

      if(isDefined(var_2["entity"]._id_7255)) {
        var_1 = var_2["entity"]._id_7255 + (0, 0, randomintrange(50, 150));
      }
    } else if(isDefined(var_2["hittype"]) && isDefined(var_2["position"]) && var_2["hittype"] != "hittype_none")
      var_1 = var_2["position"] + (0, 0, randomintrange(50, 150));
  }

  thread _id_7843(var_1);
  self._id_7255 = var_1;
}

_id_7843(var_0) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("rotors", "on", 0);
  self playLoopSound("veh_scrambler_drone_idle_high");
  self moveto(var_0 - (0, 0, 20), 3, 2, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.2);
  self moveto(var_0, 1, 0.5, 0.5);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.2);

  for(;;) {
    var_1 = randomintrange(-35, 35);
    var_2 = randomintrange(-15, 15);
    var_3 = var_0[0] + var_1;
    var_4 = var_0[1] + var_1;
    var_5 = var_0[2] + var_2;
    var_6 = (var_3, var_4, var_5);
    self moveto(var_6, 3, 2, 1);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.2);
  }
}

_id_7862() {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");

  for(;;) {
    _func_0251(self.origin, self.owner);
    self.owner playSound("oracle_radar_pulse_npc");
    wait 3;
  }
}

_id_7844(var_0, var_1) {
  self setlookatent(var_0);
  var_2 = _id_782B(self, var_0);

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  self _meth_8618(var_0, var_2, 16, 10);
  self._id_8426 = 1;
  thread _id_7855();
}

_id_7856() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");
  var_0 = level._id_786E[self._id_786F];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "setKillstreakControlPriority")) {
    self._id_FE90[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "setKillstreakControlPriority")]](self.owner, self._id_41F9, 360, 360, 30000, 30000, 3);
  }

  for(;;) {
    self._id_FE90 waittill("trigger", var_1);

    if(var_1 != self.owner) {
      continue;
    }
    if(self.owner scripts\cp_mp\utility\player_utility::_id_8ACE()) {
      continue;
    }
    if(!self.owner scripts\common\utility::_id_86F9()) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "isTouchingBoundsTrigger")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "isTouchingBoundsTrigger")]](self.owner)) {
        continue;
      }
    }

    var_2 = 0;
    var_3 = undefined;
    var_4 = level._id_5F3A;

    while(self.owner usebuttonpressed()) {
      var_2 = var_2 + var_4;

      if(var_2 > 0.1) {
        self notify("switch_modes");
        var_5 = _id_6BE1(self._id_010D, self.streakinfo);
        var_6 = "Empty String";

        if(var_5 == var_0._id_BCD2) {
          var_3 = [[var_0._id_BCD3]](var_0);
          var_6 = var_0._id_CFE6;
        } else {
          var_3 = [[var_0._id_CFE5]](var_0);
          var_6 = var_0._id_BCD4;
        }

        if(!istrue(var_3)) {
          return;
        }
        self._id_010D = var_5;
        self._id_41F9 = var_6;
        self._id_FE90 makeunusable();
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "setKillstreakControlPriority")) {
          self._id_FE90[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "setKillstreakControlPriority")]](self.owner, self._id_41F9, 360, 360, 30000, 30000, 3);
        }

        break;
      }

      wait(var_4);
    }

    wait(var_4);
  }
}

_id_6BE1(var_0, var_1) {
  var_2 = level._id_786E[self._id_786F];

  if(var_0 == var_2._id_BCD2) {
    var_0 = var_2._id_CFE4;
  } else {
    var_0 = var_2._id_BCD2;
  }

  return var_0;
}

_id_D546(var_0) {
  self vehicle_setspeed(self.speed, self.accel);
  self setyawspeed(120, 90);
  self setneargoalnotifydist(16);
  self sethoverparams(30, 10, 5);
  self setturningability(1);
  self _meth_8589(50, 1.3, 30, 20);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
  }

  self.owner thread _id_784C(self);
  _id_7821("escort_radar");
  thread _id_7824();
  return 1;
}

_id_D69B(var_0) {
  self._id_B7AB = spawn("script_origin", self.origin);
  self._id_B7AB _meth_83CA(self.owner);
  self._id_B7AB linkto(self);
  self._id_B7AB playLoopSound("recon_drone_overlay");
  self.owner _meth_867F("mp_recon_drone", 1);

  if(!isDefined(self._id_5377)) {
    self._id_5377 = [];
  }

  if(!isDefined(self._id_FE46)) {
    self._id_FE46 = 0;
  }

  self._id_EED6 = _id_079B::_id_EEDF("rcdmarker", self.owner, undefined, self.owner, 0, 0, 0);
  self._id_8982 = 1;
  self.owner scripts\common\utility::_id_158A(0);
  self.owner scripts\common\utility::_id_153E(0);
  var_1 = 0;
  self.owner._id_C707 = self.owner.angles;
  self.owner setplayerangles(self.angles);
  self.owner cameralinkto(self, "tag_origin");
  self.owner remotecontrolvehicle(self);
  self.owner painvisionoff();

  if(!istrue(var_1)) {
    self.owner setclientomnvar("ui_rcd_controls", 1);
    self.owner setclientomnvar("ui_rcd_outer_ring", 0);
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(self._id_F224 * 1000));
    self.owner setclientomnvar("ui_killstreak_health", _id_7826() / var_0.maxhealth);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerEntForOOB")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerEntForOOB")]](self, "killstreak");
    }

    thread _id_A12C();

    if(0) {
      _id_0796::_id_D89B(self, undefined, self.owner, undefined, 2250000, 9000000);
    }

    scripts\cp_mp\utility\weapon_utility::_id_D5E7(self, ::_id_7836);
    scripts\cp_mp\utility\weapon_utility::_id_D5E8(self, ::_id_7837);
    thread _id_7859(var_0);
    thread _id_7858(var_0);
    thread _id_7857(var_0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "mark_players")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "mark_players")]](var_0);
    } else {
      thread _id_783E(var_0);
    }
  }

  self.owner scripts\cp_mp\utility\killstreak_utility::_id_8DBE();
  thread _id_7854(var_0);
  thread _id_7831();
  thread _id_7842(var_0);
  return 1;
}

_id_7836() {
  _id_09CA::_id_10390("missileLocking", self.owner, "killstreak");
}

_id_7837() {
  _id_09CA::_id_1037B("missileLocking", self.owner, "killstreak");
}

_id_D638(var_0) {
  thread _id_7846();
  thread _id_7847();
  _id_7830();
  return 1;
}

_id_D566(var_0) {
  thread _id_7824();
  return 1;
}

_id_D584(var_0) {
  _id_782E();
  _id_CC58();
  _id_7830();
  self setscriptablepartstate("looping_wave", "on", 0);
  self setscriptablepartstate("scramble_sfx", "on", 0);
  self _meth_82CB(level._id_CC32["scrambler_drone_guard"]["rotor_spin"]);
  thread _id_7866();
  return 1;
}

_id_D50D(var_0) {
  thread _id_781C(var_0);
  return 1;
}

_id_781C(var_0) {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self setneargoalnotifydist(10);
  var_1 = level._id_786E[self._id_786F].speed;
  var_2 = level._id_786E[self._id_786F].accel;
  self vehicle_setspeed(var_1, var_2, var_2);
  var_3 = self._id_47A3 + (0, 0, 4000);
  var_4 = self._id_47A3 + (0, 0, 2500);
  var_5 = self._id_47A3 + (0, 0, 100);
  var_6 = level._id_786E[self._id_786F]._id_73BB;
  var_7 = [];
  var_7[0] = self;
  var_8 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1);
  var_9 = scripts\engine\trace::_id_E409(var_4, var_5, var_6, var_7, var_8, 0);
  var_10 = var_9["shape_position"] + (0, 0, 100);
  self setvehgoalpos(var_10, 1);
  self waittill("goal");
  wait 0.5;
  [[self._id_AAAD]]();
  self _meth_8438(2);
  self vehicle_setspeed(0.1, 1, 1);
  wait 0.5;
  self vehicle_setspeed(var_1, var_2, var_2);
  self setvehgoalpos(var_3, 0);
  self waittill("goal");
  _id_C4D0(self._id_786F, var_0, 0);
}

_id_7826() {
  var_0 = self.maxhealth;
  var_1 = var_0 - self._id_014E;
  return int(max(0, var_1));
}

_id_7854(var_0) {
  self.owner endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("death");
  }

  self waittill("killstreakExit");
  thread _id_786C(0);
}

_id_7831() {
  var_0 = self.owner;
  var_0 thread scripts\cp_mp\utility\player_utility::_id_10C17();
  var_1 = 1;

  if(istrue(var_1)) {
    if(level.mapname == "mp_hideout") {
      var_0 visionsetkillstreakforplayer("drone_color_dark");
    } else {
      var_0 visionsetkillstreakforplayer("drone_color");
    }
  }

  var_0 visionsetthermalforplayer("flir_0_black_to_white_recon");
  _id_7832();

  if(isDefined(var_0)) {
    var_0 scripts\cp_mp\utility\player_utility::_id_E94B();

    if(istrue(var_1)) {
      var_0 visionsetkillstreakforplayer("");
    }

    var_0 visionsetthermalforplayer("");

    if(self._id_8A9E) {
      var_0 _meth_840A();
    }
  }
}

_id_7832() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  self._id_8A9E = 0;

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    self._id_8A9E = 1;
    var_0 _meth_840B();
  }

  for(;;) {
    var_0 waittill("switch_thermal_mode");

    if(self._id_8A9E) {
      self._id_8A9E = 0;
      var_0 _meth_840A();
      continue;
    }

    self._id_8A9E = 1;
    var_0 _meth_840B();
  }
}

_id_7842(var_0) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    self waittill("touch", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = undefined;

    if(var_1 scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
      var_2 = var_1;
    } else if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      var_2 = var_1.vehicle;
    }

    if(!isDefined(var_2)) {
      continue;
    }
    var_3 = undefined;
    var_4 = undefined;

    if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_2.owner))) {
      var_5 = var_2.owner scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(var_5) && var_5 == var_2) {
        var_3 = var_2.owner;
        var_4 = var_2;
      }
    }

    self dodamage(self.maxhealth, var_2.origin, var_3, var_4, "MOD_CRUSH");
    break;
  }
}

_id_783E(var_0) {
  var_1 = self.owner;
  var_1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var_2 = 0;

  for(;;) {
    self._id_EEA4 = 0;
    self._id_EEB3 = 0;
    self._id_1917 = 0;
    var_3 = self._id_EF00;

    foreach(var_5 in var_3) {
      if(var_2 >= 3) {
        var_2 = 0;
        waitframe();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var_5)) {
          continue;
        }
      }

      if(!isDefined(var_5)) {
        continue;
      }
      if(_id_877E(var_5)) {
        continue;
      }
      if(_id_89F1(var_5)) {
        continue;
      }
      var_2++;
      _id_D70A(self._id_EED6, var_5, 1);
      var_6 = _id_31D2(var_5);
      var_7 = var_1 _id_7834(var_5, 70, 40);
      var_8 = _id_88CA(var_5);
      var_9 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(isPlayer(var_5) && var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          var_9 = 1;
        }
      }

      if(var_7 && var_9) {
        self._id_EEA4 = 1;
      }

      if(var_7 && !var_8) {
        self._id_EEB3 = 1;
      }

      if(var_8) {
        self._id_1917 = 1;
      }

      if(var_9) {
        _id_D70A(self._id_EED6, var_5, 3);
        continue;
      }

      if(!var_8 || !var_6) {
        _id_D70A(self._id_EED6, var_5, 0);
        continue;
      }

      if(!var_7) {
        continue;
      }
      if(istrue(self._id_9B80)) {
        continue;
      }
      thread _id_E6E6(var_5, "enemy", 0, 1);
    }

    var_2 = 0;
    waitframe();
  }
}

_id_7858(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");
  var_1 = 0;

  for(;;) {
    if(istrue(self._id_9B80) && var_1 == 0) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 1);
      var_1 = 1;
    } else if(!istrue(self._id_9B80) && var_1 == 1) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 0);
      var_1 = 0;
    }

    waitframe();
  }
}

_id_7857(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");

  for(;;) {
    if(istrue(self._id_EEA4)) {
      self.owner setclientomnvar("ui_rcd_notification", 3);
    } else if(istrue(self._id_EEB3)) {
      self.owner setclientomnvar("ui_rcd_notification", 1);
    } else if(!istrue(self._id_1917)) {
      self.owner setclientomnvar("ui_rcd_notification", 2);
    } else {
      self.owner setclientomnvar("ui_rcd_notification", 0);
    }

    waitframe();
  }
}

_id_7859(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  self.owner endon("disconnect");
  self._id_EF00 = [];

  for(;;) {
    var_1 = level._id_0F4C;
    var_2 = [[level._id_6885]]();
    var_3 = level.players;
    var_4 = var_3;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "get_outer_reticle_targets")) {
      var_4 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "get_outer_reticle_targets")]](var_0);
    }

    foreach(var_6 in var_4) {
      if(isPlayer(var_6)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
          if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var_6)) {
            continue;
          }
        }
      }

      if(level.teambased) {
        if(var_6.team == self.team) {
          continue;
        }
      } else {
        if(isPlayer(var_6) && var_6 == self.owner) {
          continue;
        }
        if(isDefined(var_6.owner) && var_6.owner == self.owner) {
          continue;
        }
      }

      if(!_id_88BE(var_6)) {
        continue;
      }
      if(_id_89F1(var_6)) {
        continue;
      }
      if(_id_88CB(self, var_6)) {
        continue;
      }
      if(!self.owner _id_7834(var_6, 70, 300)) {
        continue;
      }
      thread _id_E6E5(var_6);
    }

    waitframe();
  }
}

_id_31D2(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 1, 1, 0, 1);
  var_3 = [var_0.origin];

  if(isPlayer(var_0)) {
    var_3 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0.origin];
  } else if(isagent(var_0)) {
    var_3 = [var_0.origin + (0, 0, 1)];
  }

  var_4 = [self, var_0];
  var_5 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_5)) {
    var_4[var_4.size] = var_5;
    var_6 = var_5 _meth_8150(1);

    foreach(var_8 in var_6) {
      var_4[var_4.size] = var_5;
    }
  }

  for(var_10 = 0; var_10 < var_3.size; var_10++) {
    if(!scripts\engine\trace::ray_trace_passed(self.owner getvieworigin(), var_3[var_10], var_4, var_2)) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

_id_E6E5(var_0) {
  var_1 = self.owner;
  var_1 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  if(!isDefined(self._id_EED6)) {
    return;
  }
  self._id_EF00[self._id_EF00.size] = var_0;
  _id_079B::_id_EEDC(var_0, self._id_EED6, 0);
  _id_D70A(self._id_EED6, var_0, 0);

  while(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var_0)) {
        break;
      }
    }

    if(!self.owner _id_7834(var_0, 70, 300)) {
      break;
    }

    if(!_id_88BE(var_0)) {
      break;
    }

    waitframe();
  }

  if(isDefined(var_0)) {
    if(_id_079B::_id_EEE7(self._id_EED6) && !_id_89F1(var_0)) {
      _id_079B::_id_EEE2(var_0, var_0 getentitynumber(), self._id_EED6);
    }

    if(scripts\engine\utility::array_contains(self._id_EF00, var_0)) {
      self._id_EF00 = scripts\engine\utility::array_remove(self._id_EF00, var_0);
    }
  } else
    self._id_EF00 = scripts\engine\utility::_id_1BD1(self._id_EF00);
}

_id_E6E6(var_0, var_1, var_2, var_3) {
  var_4 = self.owner;
  var_4 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var_5 = spawnStruct();
  var_5.target = var_0;
  var_5._id_EEEE = var_0 getentitynumber();
  var_5._id_9B7F = self;
  var_5._id_ADAE = var_4.team;
  var_5._id_ACE5 = undefined;
  var_5._id_75E9 = undefined;
  var_5._id_24C4 = undefined;
  var_5._id_C134 = undefined;
  var_5._id_A6B7 = "unmarked_" + var_5._id_EEEE;

  if(!isDefined(var_5._id_EEEE)) {
    return;
  }
  if(!isDefined(self._id_EED6)) {
    return;
  }
  var_5._id_24C4 = 1;
  self._id_9B80 = 1;
  self.owner notify("marking_target");
  self.owner setclientomnvar("ui_rcd_controls", 2);
  var_6 = _id_6B2F(var_0);

  while(var_6 > 0) {
    if(!isDefined(var_0)) {
      return;
    }
    if(!var_4 _id_7834(var_0, 70, 40)) {
      var_5._id_24C4 = undefined;
      self._id_9B80 = undefined;
      self.owner setclientomnvar("ui_rcd_controls", 1);
      return;
    }

    var_6 = var_6 - 0.05;
    wait 0.05;
  }

  var_5._id_C134 = 1;
  self._id_9B80 = undefined;
  _id_9B43(var_5, undefined);
  self.owner setclientomnvar("ui_rcd_controls", 4);
  _id_D70A(self._id_EED6, var_0, 2);
  _id_10E8(var_0, var_1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("reconDroneMarks", 1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "combatRecordSuperMisc")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "combatRecordSuperMisc")]]("super_recon_drone");
  }

  self._id_FE46++;
  var_7 = 5.0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_improved_target_mark")) {
      var_7 = var_7 + 2;
    }
  }

  thread _id_10984(var_5, var_7);
}

_id_10E8(var_0, var_1) {
  if(!isDefined(self._id_9B39)) {
    self._id_9B39 = [];
  }

  var_2 = var_0 getentitynumber();
  var_3 = scripts\engine\utility::ter_op(isDefined(self._id_9BC0), self._id_9BC0, 0);

  if(!isDefined(self._id_9B39[var_2]) || self._id_9B39[var_2] > var_3) {
    self._id_9B39[var_2] = var_3;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
      self.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]](self._id_786F + "_" + var_1 + "_marked");
    }
  }
}

_id_10984(var_0, var_1) {
  level endon("game_ended");
  var_2 = var_0.target;
  var_2 endon(var_0._id_A6B7);
  _id_10985(var_0, var_1);
  _id_F98C(var_0);
}

_id_10985(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("disconnect");
  var_3 = var_0.target;
  var_3 endon("death");
  var_4 = gettime();

  while(var_1 * 1000 + var_4 >= gettime()) {
    wait 0.05;

    if(isDefined(self) && isDefined(self.owner) && self.owner _id_7834(var_3, 70, 40) && _id_88CA(var_3) && _id_31D2(var_3)) {
      var_4 = gettime();
    }
  }
}

_id_C63C(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var_1 = self.owner;
  var_1 endon("disconnect");
  var_1 endon("marking_target");
  wait(var_0);
  self.owner setclientomnvar("ui_rcd_controls", 1);
}

_id_8911(var_0) {
  return istrue(var_0._id_96DA);
}

_id_88CB(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_0._id_EF00, var_1);
}

_id_877E(var_0) {
  if(!isDefined(self._id_5377)) {
    return 0;
  }

  var_1 = self._id_5377[var_0 getentitynumber()];

  if(!isDefined(var_1)) {
    return 0;
  }

  return isDefined(var_1._id_24C4);
}

_id_89F1(var_0) {
  if(!isDefined(self._id_5377)) {
    return 0;
  }

  var_1 = self._id_5377[var_0 getentitynumber()];

  if(!isDefined(var_1)) {
    return 0;
  }

  return istrue(var_1._id_C134);
}

_id_88CA(var_0) {
  var_1 = scripts\cp_mp\utility\game_utility::_id_88FE();
  var_2 = scripts\engine\utility::ter_op(var_1, 6250000, 3062500);
  return distancesquared(self.origin, var_0.origin) < var_2;
}

_id_88BE(var_0) {
  return distancesquared(self.origin, var_0.origin) < 25000000;
}

_id_6B2F(var_0) {
  return 0.3;
}

_id_9B82(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.target = var_0;
  var_4._id_EEEE = var_0 getentitynumber();
  var_4._id_ACE5 = undefined;
  var_4._id_75E9 = undefined;
  var_5 = spawn("script_model", var_1);
  var_5 setModel("tag_origin");
  var_6 = undefined;

  if(level.teambased) {
    var_6 = [];

    foreach(var_8 in level.players) {
      if(!isDefined(var_8)) {
        continue;
      }
      if(var_8.team != self.team) {
        continue;
      }
      var_6[var_6.size] = var_8;
    }
  } else
    var_6 = self.owner;

  if(!isDefined(var_6)) {
    return;
  }
  if(_func_0107(var_6) && var_6.size == 0) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    var_10 = 0;
    var_11 = 5000;
    var_12 = 500;
  } else {
    var_10 = 1;
    var_11 = 5000;
    var_12 = 500;
  }

  if(1) {
    var_4._id_75E9 = var_5 thread _id_078F::_id_D59B(var_6, "icon_navbar_enemy", 15, var_10, var_11, var_12, undefined, 1, 1);
  }

  thread _id_9B83(var_4, var_5, var_3);
}

_id_50E5(var_0) {
  self endon("disconnect");
  waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]](var_0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]](var_0);
      }
    }
  }
}

_id_9B83(var_0, var_1, var_2) {
  level endon("game_ended");
  scripts\engine\utility::_id_108A8(var_2, "death", "explode");

  if(isDefined(var_0._id_7C3B)) {
    _id_078F::_id_D593(var_0._id_7C3B);

    if(isDefined(var_1)) {
      var_1 delete();
    }
  }

  if(isDefined(var_0.target)) {
    var_0.target._id_96DA = undefined;
  }

  self._id_5377[var_0._id_EEEE] = undefined;
}

_id_9B43(var_0, var_1) {
  var_2 = var_0.target;
  self._id_5377[var_0._id_EEEE] = var_0;
  var_3 = "hud_icon_head_marked";
  var_4 = 8;

  if(isPlayer(var_2)) {
    if(0) {
      if(level.teambased) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam")) {
          var_0._id_ACE5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](var_2, "orange", self.owner.team, 0, 1, 0, "killstreak");
        }
      } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForPlayer"))
        var_0._id_ACE5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForPlayer")]](var_2, "orange", self.owner, 0, 1, 0, "killstreak");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "hudOutlineViewmodelEnable")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "hudOutlineViewmodelEnable")]](5, 0, 1);
      }
    }

    var_2 thread _id_9B7C();
    var_2 _id_9B40();
    var_2 playlocalsound("recon_drone_spotted_plr");
  } else {
    var_5 = _id_9B46(var_3, var_4, var_2);
    var_3 = var_5._id_10DA1;
    var_4 = var_5._id_10DB7;
  }

  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    var_6 = 0;
    var_7 = 4000;
    var_8 = 500;
  } else {
    var_6 = 1;
    var_7 = 4000;
    var_8 = 500;
  }

  if(1) {
    var_0._id_75E9 = var_2 _id_078F::_id_D59B([], var_3, var_4, var_6, var_7, var_8, undefined, 1, 1);
    _id_9B8D(var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "watchMarkingEntStatus")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "watchMarkingEntStatus")]](var_0);
  }

  thread _id_C63C(_id_6B2F(var_0.target));
}

_id_D70A(var_0, var_1, var_2) {
  var_3 = (var_2 >> 0) % 2 == 1;
  var_4 = (var_2 >> 1) % 2 == 1;
  _func_036A(var_0, var_1, var_3);
  _func_036B(var_0, var_1, var_4);
}

_id_9B7C() {
  self endon("death_or_disconnect");
  self visionsetnakedforplayer("recon_drone_flash", 0.05);
  wait 0.08;
  self visionsetnakedforplayer("", 1.2);
}

_id_9B40() {
  if(!isDefined(self._id_9B3D)) {
    self._id_9B3D = 1;
    self setclientomnvar("ui_rcd_target_notify", self._id_9B3D);
    thread _id_10BA9();
  } else {
    if(self._id_9B3D == 1) {
      self._id_9B3D = 2;
    } else {
      self._id_9B3D = 1;
    }

    self setclientomnvar("ui_rcd_target_notify", self._id_9B3D);
  }
}

_id_10BA9() {
  self endon("disconnect");
  self notify("markedUIUpdate");
  self endon("markedUIUpdate");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "get_mark_ui_duration")) {
    wait(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "get_mark_ui_duration")]]());
  } else {
    wait 3;
  }

  thread _id_9B3F();
}

_id_9B3F() {
  self notify("markedUIUpdate");
  self._id_9B3D = undefined;
  self setclientomnvar("ui_rcd_target_notify", 0);
}

_id_9B46(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = var_1;
  var_5 = spawnStruct();

  if(isDefined(var_2.weapon_name)) {
    var_6 = undefined;

    if(issubstr(var_2.weapon_name, "claymore")) {
      var_6 = "equip_claymore";
    } else if(issubstr(var_2.weapon_name, "c4")) {
      var_6 = "equip_c4";
    } else if(issubstr(var_2.weapon_name, "atMine")) {
      var_6 = "equip_at_mine";
    } else if(issubstr(var_2.weapon_name, "trophy")) {
      var_6 = "equip_trophy";
    }

    if(isDefined(var_6)) {
      var_7 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "getEquipmentTableInfo")) {
        var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "getEquipmentTableInfo")]](var_6);
      }

      var_3 = var_7._id_7D40;
    }
  } else if(isDefined(var_2.streakinfo)) {
    var_8 = var_2.streakinfo.streakname;
    var_3 = game["killstreakTable"]._id_EC74[var_8]["overheadIcon"];
    var_4 = 75;
  }

  var_5._id_10DA1 = var_3;
  var_5._id_10DB7 = var_4;
  return var_5;
}

_id_9B8D(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2)) {
      return;
    }
    _id_9B8C(var_0, var_2);
  }
}

_id_9B8C(var_0, var_1) {
  var_2 = scripts\mp\utility\player::_id_886C(var_0._id_ADAE, var_1);
  var_3 = isDefined(var_0._id_9B7F) && isDefined(var_0._id_9B7F.owner) && var_1 == var_0._id_9B7F.owner;
  var_4 = isDefined(var_0._id_9B7F) && istrue(var_0._id_9B7F._id_8982);
  var_5 = var_3 && var_4;

  if(isDefined(var_0._id_75E9)) {
    if(var_2 && !var_5) {
      _id_078F::_id_D590(var_0._id_75E9, var_1);
    } else {
      _id_078F::_id_D599(var_0._id_75E9, var_1);
    }
  }
}

_id_F98C(var_0) {
  _id_078F::_id_D593(var_0._id_75E9);

  if(isDefined(var_0.target)) {
    var_0._id_C134 = undefined;
    var_0._id_24C4 = undefined;

    if(isDefined(self)) {
      self._id_5377[var_0._id_EEEE] = undefined;
    }

    if(isPlayer(var_0.target) && 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_0._id_ACE5, var_0.target);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "hudOutlineViewmodelDisable")) {
        var_0.target[[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "hudOutlineViewmodelDisable")]]();
      }
    }

    var_0.target notify(var_0._id_A6B7);
  } else if(isDefined(self))
    self._id_5377[var_0._id_EEEE] = undefined;
}

_id_7855() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("death_or_disconnect");
  self endon("owner_gone");
  self notify("helperDrone_watchForGoal");
  self endon("helperDrone_watchForGoal");
  var_0 = scripts\engine\utility::_id_10898("goal", "near_goal", "hit_goal");
  self._id_8426 = 0;
  self._id_7D83 = 0;
  self notify("hit_goal");
}

_id_7853() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("disconnect");
  self endon("owner_gone");
  self.health = 2147483647;
  var_0 = self.maxhealth;
  var_1 = level._id_786E[self._id_786F];

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);

    if(isDefined(var_3)) {
      if(isDefined(var_3.owner)) {
        var_3 = var_3.owner;
      }

      if(isDefined(var_3.team) && var_3.team == self.team && var_3 != self.owner) {
        continue;
      }
    }

    if(isDefined(var_11)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
        var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var_3, var_11, var_6, var_2, var_1.maxhealth, 1, 1, 1);
      }
    }

    var_0 = var_0 - var_2;

    if(isPlayer(var_3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
        var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("");
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakHit")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakHit")]](var_3, var_11, self, var_6, var_2);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "logAttackerKillstreak")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "logAttackerKillstreak")]](self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
      }

      if(var_0 <= 0) {
        var_3 notify("destroyed_killstreak", var_11);
        var_16 = var_2;
        var_17 = self.streakinfo.streakname;
        var_18 = undefined;
        var_19 = 1;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
          var_20 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](self._id_786F, var_3, var_11, var_18, var_16, var_1._id_CC15, var_1._id_1068F, var_1._id_484B, var_19);
        }

        thread _id_786C(1);
      }
    }

    if(var_0 <= int(self.maxhealth / 1.2) && self._id_41BE == 0) {
      self._id_41BE = 1;
      self setscriptablepartstate("body_damage_light", "on");
      continue;
    }

    if(var_0 <= int(self.maxhealth / 2) && self._id_41BE == 1) {
      self._id_41BE = 2;
      self setscriptablepartstate("body_damage_medium", "on");
      continue;
    }

    if(var_0 <= int(self.maxhealth / 3) && self._id_41BE == 2) {
      self._id_41BE = 3;
      self setscriptablepartstate("body_damage_heavy", "on");
    }
  }
}

_id_7869() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("disconnect");
  self endon("owner_gone");
  var_0 = level._id_786E[self._id_786F];
  self._id_F224 = var_0._id_F224;

  if(self.owner scripts\cp_mp\utility\killstreak_utility::_id_0C44("specialty_reaper")) {
    self._id_F224 = self._id_F224 * 1.5;
  }

  if(!isDefined(self._id_F224)) {
    return;
  }
  var_2 = 0.05;

  while(self._id_F224 > 0) {
    wait(var_2);
    self._id_F224 = self._id_F224 - var_2;

    if(self._id_F224 < 0) {
      self._id_F224 = 0;
    }
  }

  scripts\cp_mp\utility\killstreak_utility::_id_B86F(var_0._id_106B2, 1);
  thread _id_7835();
}

_id_785B() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  childthread _id_785C("disconnect");
  childthread _id_785C("joined_team");
  childthread _id_785C("joined_spectators");
  childthread _id_785C("last_stand_start");
}

_id_785C(var_0) {
  self.owner waittill(var_0);
  self notify("owner_gone");
  thread _id_7835();
}

_id_785A() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");

  for(;;) {
    self.owner waittill("death");
    var_0 = level._id_786E[self._id_786F];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGametypeNumLives")) {
      if(istrue(var_0._id_4987) || [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGametypeNumLives")]]() && self.owner.pers["deaths"] == [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGametypeNumLives")]]()) {
        thread _id_7835();
      }
    }
  }
}

_id_7865() {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("disconnect");
  self endon("owner_gone");
  level scripts\engine\utility::waittill_any_3("round_end_finished", "game_ended", "prematch_cleanup");
  thread _id_7835();
}

_id_7835() {
  self endon("death");
  self endon("explode");

  if(self._id_786F == "radar_drone_overwatch") {
    self _meth_807E();
    self setmaxpitchroll(0, 0);
    self notify("leaving");
    self vehicle_setspeed(50, 25);
    var_0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
    var_0 = var_0 + (0, 0, 1000);
    self setvehgoalpos(var_0, 1);
    self setneargoalnotifydist(100);
    self waittill("near_goal");
    var_1 = _id_782A();
    self vehicle_setspeed(150, 50);
    self setvehgoalpos(var_1, 1);
    self waittill("goal");
    self notify("gone");
    _id_C4D0(self._id_786F, level._id_786E[self._id_786F], 0);
  } else
    thread _id_786C(0);
}

_id_782A() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

_id_AFCB() {
  var_0 = "icon_minimap_scramblerdrone";
  self._id_5423 = _id_07F9::_id_4023(var_0, 1, 1);

  foreach(var_2 in level.players) {
    if(!isPlayer(var_2)) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_engineer") && var_2.team != self.team) {
        if(self._id_5423 != -1) {
          _id_07F9::_id_A89D(self._id_5423, var_2);
        }
      }
    }
  }
}

_id_7840(var_0) {
  _id_7841(var_0);
  var_1 = var_0._id_9CD6;
  var_2 = var_0.damage;

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::_id_8ACE()) {
    if(_func_010F(var_1)) {
      if(_func_0037(var_2 / self.maxhealth) >= 0.4) {
        earthquake(0.25, 0.2, self.origin, 150);
        self.owner playrumbleonentity("damage_heavy");
      } else {
        earthquake(0.15, 0.15, self.origin, 150);
        self.owner playrumbleonentity("damage_light");
      }
    }
  }

  return 1;
}

_id_7841(var_0) {
  var_1 = var_0.damage;
  self._id_41CA = self.health - var_1;

  if(self._id_41CA <= int(self.maxhealth / 1.2) && self._id_41BE == 0) {
    self._id_41BE = 1;
    self setscriptablepartstate("body_damage_light", "on");
  } else if(self._id_41CA <= int(self.maxhealth / 2) && self._id_41BE == 1) {
    self._id_41BE = 2;
    self setscriptablepartstate("body_damage_medium", "on");
  } else if(self._id_41CA <= int(self.maxhealth / 3) && self._id_41BE == 2) {
    self._id_41BE = 3;
    self setscriptablepartstate("body_damage_heavy", "on");
  }

  self.owner setclientomnvar("ui_killstreak_health", self._id_41CA / self.maxhealth);
  return 1;
}

_id_784F(var_0) {
  self notify("helperDrone_stunned");
  self endon("helperDrone_stunned");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("disconnect");
  level endon("game_ended");

  if(istrue(self._id_1DF2)) {
    self notify("disengage_target");
  }

  self._id_EAAB = 1;

  if(isDefined(level._id_786E[self._id_786F]._id_6094)) {
    playFXOnTag(level._id_786E[self._id_786F]._id_6094, self, "tag_origin");
  }

  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  stopFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  self._id_EAAB = 0;
}

_id_786B(var_0) {
  if(!isDefined(self) || istrue(self._id_87FB)) {
    return;
  }
  thread _id_786C(1);
  return 0;
}

_id_786C(var_0) {
  self._id_87FB = 1;
  _id_7822();

  if(isDefined(self._id_9F26)) {
    _id_07F9::_id_C799(self._id_9F26);
    self._id_9F26 = undefined;
  }

  if(isDefined(self._id_786F) && self._id_786F == "radar_drone_recon") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "clearOOB")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "clearOOB")]](self, 1);
    }

    _id_7849(self.owner);
  }

  if(isDefined(level._id_786E[self._id_786F]._id_6090)) {
    playFX(level._id_786E[self._id_786F]._id_6090, self.origin);
  }

  if(isDefined(level._id_786E[self._id_786F]._id_E053)) {
    self playSound(level._id_786E[self._id_786F]._id_E053);
  }

  _id_078D::_id_1538(0);
  self notify("explode");

  if(isDefined(self.streakinfo._id_EB31)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_recon_drone", self._id_FE46);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "fieldUpgradeExpired")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self.streakinfo._id_EB31, self._id_FE46, istrue(var_0));
    }
  }

  waitframe();
  var_1 = self.owner;
  _id_C4D0(self._id_786F, level._id_786E[self._id_786F], var_0);

  if(isDefined(var_1) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "superSlotCleanUp")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "superSlotCleanUp")]](var_1);
  }
}

_id_C4D0(var_0, var_1, var_2) {
  _id_781E();

  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  if(isDefined(self._id_B7AB)) {
    self._id_B7AB delete();
  }

  if(isDefined(self._id_CC54)) {
    self._id_CC54 delete();
  }

  if(isDefined(self._id_5423)) {
    _id_07F9::_id_C799(self._id_5423);
  }

  if(isDefined(self._id_BE23) && self._id_BE23.size > 0) {
    foreach(var_4 in self._id_BE23) {
      var_4 notify("death");
    }
  }

  if(!istrue(self.streakinfo._id_8A74)) {
    if(isDefined(level._id_8DD3)) {
      level thread[[level._id_8DD3]](self.streakinfo);
    }
  }

  if(isDefined(self.owner)) {
    if(isDefined(self.owner._id_781A)) {
      self.owner._id_781A = undefined;
    }

    self.owner _meth_8680("mp_recon_drone", 1);
    self.owner notify("eng_drone_update", -1);

    if(var_0 == "radar_drone_escort" || var_0 == "radar_drone_overwatch") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap")) {
        self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
      }
    }

    self.streakinfo._id_57A7 = istrue(var_2);
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(self.streakinfo);
  }

  if(var_0 == "scrambler_drone_guard") {
    _id_CC57();
  }

  if(istrue(self._id_A5B4)) {
    self delete();
  } else {
    scripts\cp_mp\vehicles\vehicle_tracking::_id_0BB8(self);
  }
}

_id_7849(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = self._id_786F;
  var_2 = level._id_786E[var_1];
  _id_079B::_id_EEDE(self._id_EED6);
  self._id_EED6 = undefined;
  self._id_8982 = undefined;

  foreach(var_4 in self._id_5377) {
    _id_9B8C(var_4, var_0);
  }

  var_0 thread _id_C124(!isalive(var_0), 1);
  var_0 _id_7850(self.streakinfo);
  var_0 painvisionon();
  var_0 scripts\common\utility::_id_158A(1);
  var_0 scripts\common\utility::_id_153E(1);
  var_0 thread _id_7825();
  var_0 _meth_8060(self);
  var_0 _meth_8294();
  var_0 setplayerangles((var_0._id_C707[0], var_0._id_C707[1], 0));
  var_0._id_C707 = undefined;
  var_0 scripts\cp_mp\utility\killstreak_utility::_id_8DBA();
}

_id_7825() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = gettime();
  var_1 = 1000;

  while(gettime() - var_0 < var_1) {
    self setclientomnvar("ui_rcd_controls", 0);
    waitframe();
  }
}

_id_56CF(var_0, var_1) {
  if(!isDefined(level._id_EB9A)) {
    return 0;
  }

  if(level._id_7DA6.size > 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
      if(level._id_7DA6.size >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
        return 1;
      }
    }

    foreach(var_3 in level._id_7DA6) {
      if(isDefined(var_3.owner) && var_3.owner == var_1) {
        continue;
      }
      if(var_0.streakname == "radar_drone_recon" && var_3.type == var_0.streakname) {
        if(level.teambased) {
          if(isDefined(var_3.owner) && isDefined(var_3.owner.team) && var_3.owner.team == var_1.team) {
            return 1;
          }
        }
      } else if(var_0.streakname == "radar_drone_overwatch" && var_3.type == var_0.streakname) {
        if(level.teambased) {
          if(_id_7828("radar_drone_overwatch", level._id_7DA6, var_1.team) >= 10) {
            return 1;
          }
        }

        if(_id_7828("radar_drone_overwatch", level._id_7DA6) >= 20) {
          return 1;
        }
      } else if(var_0.streakname == "scrambler_drone_guard" && var_3.type == var_0.streakname) {
        if(level.teambased) {
          if(_id_7828("scrambler_drone_guard", level._id_7DA6, var_1.team) >= 10) {
            return 1;
          }
        }
      }
    }
  }

  if(level._id_EB9A.size > 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
      if(level._id_EB9A.size >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
        return 1;
      }
    }

    foreach(var_3 in level._id_EB9A) {
      if(var_0.streakname == "radar_drone_escort" && var_3._id_786F == var_0.streakname) {
        if(isDefined(var_3.owner) && var_3.owner == var_1) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/COMPANION_ALREADY_EXISTS");
          }

          return 1;
        }
      } else if(var_0.streakname == "radar_drone_recon" && var_3._id_786F == var_0.streakname) {
        if(level.teambased) {
          if(var_3.team == var_1.team) {
            var_1 scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
            return 1;
          }
        }
      } else if(var_0.streakname == "radar_drone_overwatch" && var_3._id_786F == var_0.streakname) {
        if(_id_7828("radar_drone_overwatch", level._id_EB9A) >= 20) {
          var_1 scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
          return 1;
        }

        if(level.teambased) {
          if(_id_7828("radar_drone_overwatch", level._id_EB9A, var_1.team) >= 10) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
              var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_PERSONAL_RADAR");
            }

            return 1;
          }
        }

        if(_id_7828("radar_drone_overwatch", level._id_EB9A, var_1) >= 1) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/PERSONAL_RADAR_ALREADY_ACTIVE");
          }

          return 1;
        }
      } else if(var_0.streakname == "scrambler_drone_guard" && var_3._id_786F == var_0.streakname) {
        if(level.teambased) {
          if(_id_7828("scrambler_drone_guard", level._id_EB9A, var_1.team) >= 10) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
              var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_COUNTER_UAV");
            }

            return 1;
          }
        } else if(_id_7828("scrambler_drone_guard", level._id_EB9A, var_1) >= 2) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_COUNTER_UAV");
          }

          return 1;
        }
      }
    }
  }

  return 0;
}

_id_7828(var_0, var_1, var_2) {
  var_3 = 0;

  foreach(var_5 in var_1) {
    if(isDefined(var_5.type) && var_5.type == var_0 || isDefined(var_5._id_786F) && var_5._id_786F == var_0) {
      if(isDefined(var_2)) {
        if(isPlayer(var_2)) {
          if(var_5.owner != var_2) {
            continue;
          }
        } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isGameplayTeam") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isGameplayTeam")]](var_2)) {
          if(var_5.team != var_2) {
            continue;
          }
        }
      }

      var_3++;
    }
  }

  return var_3;
}

_id_781D() {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  level scripts\engine\utility::waittill_any_2("bro_shot_start", "game_ended");
  _id_786B();
}

_id_7852(var_0) {
  self endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  var_1 = getdvarfloat("#x3496f237aef709538", 1500);
  var_2 = getdvarfloat("#x39ef1e7621ac9cf70", 3600);
  var_3 = var_1 + var_2;
  var_4 = 0.0;
  var_5 = 0.0;

  for(;;) {
    if(self.origin[2] > var_2) {
      if(self.origin[2] > var_3) {
        var_0 setclientomnvar("ui_out_of_range", 0.0);
        _id_786B();
      }

      var_4 = (self.origin[2] - var_2) / var_1;
    } else
      var_4 = 0.0;

    if(var_4 != var_5) {
      var_5 = var_4;
      var_0 setclientomnvar("ui_out_of_range", var_4);
    }

    waitframe();
  }
}

_id_782B(var_0, var_1) {
  var_2 = level._id_786E[var_0._id_786F];
  var_3 = var_2._id_20A8;
  var_4 = var_2._id_DD1B;
  var_5 = var_0 _id_7827(var_2);

  if(isDefined(var_0._id_98B4)) {
    var_5 = var_5 * var_0._id_98B4;
  }

  var_6 = (var_4, var_3, var_5);
  return var_6;
}

_id_7834(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [var_0.origin];

  if(isPlayer(var_0)) {
    var_4 = [var_0.origin, var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_eye")];
  }

  foreach(var_6 in var_4) {
    if(self _meth_845E(var_6, var_1, var_2)) {
      var_3 = 1;
      break;
    }
  }

  return var_3;
}

_id_5AD3(var_0, var_1) {
  var_2 = self.angles;
  var_3 = (0, 0, 80);

  if(istrue(var_1)) {
    var_4 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();

    if(!isDefined(var_4)) {
      var_3 = (0, 0, 2000);
    } else {
      var_3 = (0, 0, var_4.origin[2]);
    }
  }

  var_5 = level._id_786E[var_0]._id_E297;
  var_6 = (0, 0, var_3[2]);
  var_7 = level._id_786E[var_0]._id_73BB;
  var_8 = anglesToForward(self.angles);
  var_9 = anglestoright(self.angles);
  var_10 = self.origin + (0, 0, 30);
  var_11 = var_5 + 20;

  if(self getstance() == "prone") {
    var_11 = var_11 + 25;
  }

  var_12 = [var_6 + var_5 * var_8, var_6 - var_5 * var_8, var_6 + var_5 * var_9, var_6 - var_5 * var_9, var_6, var_6 + 0.707 * var_5 * (var_8 + var_9), var_6 + 0.707 * var_5 * (var_8 - var_9), var_6 + 0.707 * var_5 * (var_9 - var_8), var_6 + 0.707 * var_5 * (-1 * var_8 - var_9), var_11 * var_8, -1 * var_11 * var_8, var_11 * var_9, -1 * var_11 * var_9, (0, 0, 0), 0.707 * var_11 * (var_8 + var_9), 0.707 * var_11 * (var_8 - var_9), 0.707 * var_11 * (var_9 - var_8), 0.707 * var_11 * (-1 * var_8 - var_9)];
  var_13 = 0;

  for(var_14 = 0; var_14 < var_12.size; var_14++) {
    if(4 <= var_13) {
      var_13 = 0;
      wait 0.05;
    }

    var_15 = var_12[var_14];
    var_16 = var_10 + var_15;
    var_17 = vectornormalize(var_15) * 50;
    var_18 = var_10 + var_17;
    var_19 = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var_20 = scripts\engine\trace::ray_trace(var_10, var_18, self, var_19);

    if(var_20["hittype"] != "hittype_none") {
      continue;
    }
    var_21 = scripts\engine\trace::_id_E409(var_18, var_16, var_7, self, var_19);
    var_22 = var_21["fraction"];
    var_23 = var_22 * (var_16 - var_18);
    var_24 = var_18 + var_23;

    if(var_22 > 0) {
      self._id_C130 = var_24;
      return var_24;
    }

    var_13++;
  }

  return undefined;
}

_id_782D(var_0) {
  self endon("disconnect ");
  scripts\cp_mp\utility\player_utility::_id_D8D4(var_0.streakname);
  scripts\common\utility::_id_1593(0);
}

_id_7850(var_0) {
  scripts\cp_mp\utility\player_utility::_id_3990(1);
  scripts\common\utility::_id_1593(1);
  scripts\common\utility::_id_1562(1);
  var_0 notify("killstreak_finished_with_deploy_weapon");
  var_1 = makeweapon("ks_remote_drone_mp");

  if(self hasweapon(var_1)) {
    thread scripts\cp_mp\utility\inventory_utility::_id_6CF7(var_1);
  }
}

_id_784C(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("explode");
  var_0 endon("leaving");
  level endon("game_ended");
  var_1 = self.guid;
  level notify("helperDrone_show_minimap_" + var_1);
  level endon("helperDrone_show_minimap_" + var_1);

  if(istrue(level._id_8A88)) {
    return;
  }
  for(;;) {
    self waittill("spawned_player");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
    }

    self._id_DCF8 = 1;
  }
}

_id_C11C() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  var_0 = spawnStruct();
  var_0.streakname = "radar_drone_recon";
  var_0._id_04FE = "ks_remote_drone_mp";
  var_0._id_8A74 = 1;
  var_0._id_EB31 = level._id_EB2B._id_E76D["super_recon_drone"]._id_7C8C;

  if(!_id_F788(var_0, 1)) {
    self._id_C12F = 1;
    thread _id_C126(var_0, 0);

    if(scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B()) {
      self._id_C136 = 1;
      thread _id_C126(var_0, 1);

      if(_id_C121()) {
        thread _id_C127(var_0);
        return 1;
      } else {
        thread _id_C124(undefined, 1);
        thread _id_C11D(var_0, 1);
      }
    } else
      thread _id_C11D(var_0, 0);
  }

  return 0;
}

_id_C11F(var_0) {
  self notify("reconDroneEnded");
  self._id_C130 = undefined;

  if(isDefined(self._id_C12E)) {
    self._id_C12E = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "getSuperPointsNeeded")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]]([[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "getSuperPointsNeeded")]]());
    }
  }

  if(isDefined(self._id_C12F)) {
    self._id_C12F = undefined;
    var_1 = spawnStruct();
    var_1.streakname = "radar_drone_recon";
    _id_C11D(var_1);
  }

  if(isDefined(self._id_C136)) {
    self._id_C136 = undefined;
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  }
}

_id_C127(var_0) {
  self endon("disconnect");
  var_1 = _id_C12A(var_0);

  if(!isDefined(var_1)) {
    thread _id_C124(!isalive(self), 1);
  } else if(!var_1) {
    thread _id_C124(!isalive(self), 1);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
    }
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](0);
}

_id_C12A(var_0) {
  self endon("death");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  thread _id_C129();
  thread _id_C11E(2.15);
  wait 1.85;
  childthread _id_5AD3(var_0.streakname, 0);
  wait 0.15;

  if(level.gameended) {
    self._id_C130 = undefined;
  }

  var_1 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isInLastStand")) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isInLastStand")]](self);
  }

  if(isDefined(self._id_C130) && !var_1) {
    self._id_C136 = undefined;
    thread _id_C126(var_0, 0);
    var_2 = _id_3FEF(self._id_C130, self.angles, var_0.streakname, var_0, 0, 1);
    self._id_C130 = undefined;

    if(isDefined(var_2)) {
      thread _id_782D(var_0);
      var_2 _id_C11A(var_2, self);
      thread _id_E6B9(var_2);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
        level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_recon_drone");
      }

      return 1;
    } else
      _id_786A(var_0.streakname);
  } else
    _id_786A(var_0.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
  }

  return 0;
}

_id_C11E(var_0) {
  self endon("death_or_disconnect");
  self freezecontrols(1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self freezecontrols(0);
}

_id_C129() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  self endon("reconDrone_watchSuperEndFromSwitch");
  var_0 = makeweapon("ks_remote_drone_mp");

  for(;;) {
    if(self getcurrentweapon() != var_0) {
      break;
    }

    waitframe();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
  }
}

_id_C125(var_0) {
  self notify("reconDroneUnset");

  if(0) {
    var_1 = self._id_C131;

    if(isDefined(var_1)) {
      if(!istrue(var_1._id_87FB)) {
        var_1 _id_786B();
      }
    }
  }

  thread _id_C11F(var_0);
}

_id_C121() {
  self endon("death_or_disconnect");
  self endon("reconDroneWeaponTaken");
  self notify("reconDroneWeaponGiven");
  self endon("reconDroneWeaponGiven");
  var_0 = makeweapon("ks_remote_drone_mp");

  if(!self hasweapon(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  }

  _id_C11B(0);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1);
  return var_1;
}

_id_C124(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("reconDroneWeaponGiven");
  self notify("reconDroneWeaponTaken");
  self endon("reconDroneWeaponTaken");
  var_2 = makeweapon("ks_remote_drone_mp");

  if(istrue(var_1)) {
    if(scripts\cp_mp\utility\inventory_utility::_id_8A86(var_2)) {
      scripts\cp_mp\utility\inventory_utility::_id_0E0C(var_2);
      return;
    }
  }

  _id_C11B(1, var_0);

  if(istrue(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_id_6CF7(var_2);
  }
}

_id_C11B(var_0, var_1) {
  var_1 = istrue(var_1);

  if(var_0) {
    if(!isDefined(self._id_C12D)) {
      return;
    }
    if(!var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "allow_equipment")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "allow_equipment")]](var_0);
      }

      scripts\common\utility::_id_158A(var_0);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "allowGesture")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "allowGesture")]](var_0);
      }
    }

    self._id_C12D = undefined;
  } else {
    if(isDefined(self._id_C12D)) {
      return;
    }
    if(!var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "allow_equipment")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "allow_equipment")]](var_0);
      }

      scripts\common\utility::_id_158A(var_0);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "allowGesture")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "allowGesture")]](var_0);
      }
    }

    self._id_C12D = 1;
  }
}

_id_C126(var_0, var_1) {
  self notify("reconDrone_cleanupReserved");
  self endon("reconDrone_cleanupReserved");
  self waittill("disconnect");
  thread _id_C11D(var_0, var_1);
}

_id_C11D(var_0, var_1) {
  self notify("reconDrone_cleanupReserved");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]](1);
  }

  _id_C4D4(var_0);

  if(istrue(var_1)) {
    scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  }
}

_id_C11A(var_0, var_1) {
  var_1._id_C131 = var_0;
  var_1._id_AF71 = 1;
  var_2 = var_0 getentitynumber();

  if(!isDefined(level._id_C132)) {
    level._id_C132 = [];
  }

  level._id_C132[var_2] = var_0;
  thread _id_C123(var_0, var_1, var_2);
}

_id_C122(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 notify("reconDrone_removeFromLists");
    var_2 = var_0 getentitynumber();
  }

  if(isDefined(var_1)) {
    var_1._id_C131 = undefined;
    var_1._id_AF71 = 0;
  }

  if(isDefined(level._id_C132)) {
    level._id_C132[var_2] = undefined;
  }
}

_id_C123(var_0, var_1, var_2) {
  var_0 endon("reconDrone_removeFromLists");
  var_0 waittill("death");
  thread _id_C122(var_0, var_1, var_2);
}

_id_47A2(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  var_2 = spawnStruct();
  var_2.streakname = "ammo_drop";
  var_2._id_8A74 = 1;

  if(_id_F788(var_2, 1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    _id_C4D4(var_2);
    return undefined;
  }

  var_3 = var_0 + (0, 0, 4000) - anglesToForward(self.angles) * 0;
  var_4 = _id_3FEF(var_3, self.angles, var_2.streakname, var_2);

  if(!isDefined(var_4)) {
    return undefined;
  }

  _id_C4D4(var_2);
  var_4._id_47A3 = var_0;
  var_4._id_AAAD = var_1;
  thread _id_E6B9(var_4);
  return var_4;
}

_id_CC58() {
  _id_09BD::_id_1087();
  level notify("uav_update");
}

_id_CC57() {
  _id_09BD::_id_C466();
  level notify("uav_update");
}

_id_A12C() {
  self.owner endon("disconnect");
  self endon("death");
  var_0 = 0.0;

  for(;;) {
    if(isDefined(level._id_AD0F)) {
      var_1 = 0;

      foreach(var_3 in level._id_AD0F) {
        if(self istouching(var_3)) {
          var_1 = 1;
          break;
        }
      }

      if(var_1) {
        var_0 = var_0 + 1.0 * level._id_5F3A;
      } else {
        var_0 = var_0 - 2.0 * level._id_5F3A;
      }

      var_0 = clamp(var_0, 0.0, 0.5);
      self.owner setclientomnvar("ui_out_of_range", var_0);
    }

    waitframe();
  }
}

_id_8A90() {
  if(isDefined(level._id_EB9A) && level._id_EB9A.size > 0) {
    foreach(var_1 in level._id_EB9A) {
      if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self, var_1.owner))) {
        if(isDefined(var_1._id_5377) && isDefined(var_1._id_5377[self getentitynumber()])) {
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_889D() {
  if(isDefined(level._id_786E)) {
    if(isDefined(self.streakinfo)) {
      return scripts\engine\utility::_id_1BA1(level._id_786E, self.streakinfo.streakname);
    }
  }

  return 0;
}