/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\helper_drone.gsc
******************************************************/

function init() {
  level.helperdronesettings = [];
  level.helperdronesettings["radar_drone_recon"] = spawnStruct();
  level.helperdronesettings["radar_drone_recon"].timeout = 45;
  level.helperdronesettings["radar_drone_recon"].maxhealth = 30;
  level.helperdronesettings["radar_drone_recon"].hitstokill = 3;
  level.helperdronesettings["radar_drone_recon"].speed = 140;
  level.helperdronesettings["radar_drone_recon"].accel = 20;
  level.helperdronesettings["radar_drone_recon"].halfsize = 27;
  level.helperdronesettings["radar_drone_recon"].spawndist = 30;
  level.helperdronesettings["radar_drone_recon"].streakname = "radar_drone_recon";
  level.helperdronesettings["radar_drone_recon"].vehicleinfo = "veh_radar_drone_recon_mp";
  level.helperdronesettings["radar_drone_recon"].modelbase = "veh8_mil_air_malfa_small";
  level.helperdronesettings["radar_drone_recon"].teamsplash = "used_radar_drone_recon";
  level.helperdronesettings["radar_drone_recon"].destroyedsplash = "callout_destroyed_radar_drone_recon";
  level.helperdronesettings["radar_drone_recon"].fxid_explode = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sm_dest_exp.vfx");
  level.helperdronesettings["radar_drone_recon"].sound_explode = "recon_drone_explode";
  level.helperdronesettings["radar_drone_recon"].vodestroyed = "ball_drone_backup_destroy";
  level.helperdronesettings["radar_drone_recon"].votimedout = "ball_drone_backup_timeout";
  level.helperdronesettings["radar_drone_recon"].scorepopup = "destroyed_radar_drone_recon";
  level.helperdronesettings["radar_drone_recon"].playfxcallback = &helperdronefx;
  level.helperdronesettings["radar_drone_recon"].primarymode = "MANUAL";
  level.helperdronesettings["radar_drone_recon"].primarymodestring = &"KILLSTREAKS_HINTS/RCD_MANUAL";
  level.helperdronesettings["radar_drone_recon"].primarymodefunc = &setreconmodesettings;
  level.helperdronesettings["radar_drone_recon"].premoddamagefunc = undefined;
  level.helperdronesettings["radar_drone_recon"].postmoddamagefunc = &helperdrone_modifydamageresponse;
  level.helperdronesettings["radar_drone_recon"].deathfunc = &helperdronedestroyed;
  level.helperdronesettings["radar_drone_recon"].deployweaponname = "ks_remote_drone_mp";
  level.helperdronesettings["radar_drone_recon"].ref_11B06 = 1;
  level.helperdronesettings["radar_drone_recon"].ref_11B07 = 1;
  level.helperdronesettings["radar_drone_recon"].ref_11B17 = 3062500;
  level.helperdronesettings["radar_drone_recon"].ref_11B18 = 6250000;
  level.helperdronesettings["radar_drone_overwatch"] = spawnStruct();
  level.helperdronesettings["radar_drone_overwatch"].timeout = 45;
  level.helperdronesettings["radar_drone_overwatch"].maxhealth = 700;
  level.helperdronesettings["radar_drone_overwatch"].hitstokill = 3;
  level.helperdronesettings["radar_drone_overwatch"].speed = 100;
  level.helperdronesettings["radar_drone_overwatch"].accel = 10;
  level.helperdronesettings["radar_drone_overwatch"].halfsize = 50;
  level.helperdronesettings["radar_drone_overwatch"].spawndist = 100;
  level.helperdronesettings["radar_drone_overwatch"].streakname = "radar_drone_overwatch";
  level.helperdronesettings["radar_drone_overwatch"].vehicleinfo = "veh_radar_drone_overwatch_mp";
  level.helperdronesettings["radar_drone_overwatch"].modelbase = "veh8_mil_air_mquebec8_small";
  level.helperdronesettings["radar_drone_overwatch"].modelbasealt = "veh8_mil_air_mquebec8_small_east";
  level.helperdronesettings["radar_drone_overwatch"].teamsplash = "used_radar_drone_overwatch";
  level.helperdronesettings["radar_drone_overwatch"].destroyedsplash = "callout_destroyed_radar_drone_overwatch";
  level.helperdronesettings["radar_drone_overwatch"].fxid_explode = loadfx("vfx/iw8_mp/killstreak/vfx_overwatch_explosion.vfx");
  level.helperdronesettings["radar_drone_overwatch"].sound_explode = "radar_drone_explode";
  level.helperdronesettings["radar_drone_overwatch"].vodestroyed = "destroyed_radar_drone_overwatch";
  level.helperdronesettings["radar_drone_overwatch"].votimedout = "timeout_radar_drone_overwatch";
  level.helperdronesettings["radar_drone_overwatch"].scorepopup = "destroyed_radar_drone_overwatch";
  level.helperdronesettings["radar_drone_overwatch"].playfxcallback = &helperdronefx;
  level.helperdronesettings["radar_drone_overwatch"].fxid_light1 = [];
  level.helperdronesettings["radar_drone_overwatch"].fxid_light1["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_light_detonator_blink");
  level.helperdronesettings["radar_drone_overwatch"].fxid_light1["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
  level.helperdronesettings["radar_drone_overwatch"].standupoffset = 120;
  level.helperdronesettings["radar_drone_overwatch"].crouchupoffset = 80;
  level.helperdronesettings["radar_drone_overwatch"].proneupoffset = 46;
  level.helperdronesettings["radar_drone_overwatch"].backoffset = 124;
  level.helperdronesettings["radar_drone_overwatch"].sideoffset = 55;
  level.helperdronesettings["radar_drone_overwatch"].primarymode = "RADAR";
  level.helperdronesettings["radar_drone_overwatch"].primarymodestring = &"KILLSTREAKS_HINTS/RCD_RADAR";
  level.helperdronesettings["radar_drone_overwatch"].primarymodefunc = &setoverwatchmodesettings;
  level.helperdronesettings["radar_drone_overwatch"].premoddamagefunc = undefined;
  level.helperdronesettings["radar_drone_overwatch"].postmoddamagefunc = &helperdrone_modifydamagestates;
  level.helperdronesettings["radar_drone_overwatch"].deathfunc = &helperdronedestroyed;
  level.helperdronesettings["radar_drone_overwatch"].deployweaponname = "ks_gesture_generic_mp";
  level.helperdronesettings["scrambler_drone_guard"] = spawnStruct();
  level.helperdronesettings["scrambler_drone_guard"].timeout = 45;
  level.helperdronesettings["scrambler_drone_guard"].maxhealth = 300;
  level.helperdronesettings["scrambler_drone_guard"].speed = 140;
  level.helperdronesettings["scrambler_drone_guard"].accel = 20;
  level.helperdronesettings["scrambler_drone_guard"].halfsize = 50;
  level.helperdronesettings["scrambler_drone_guard"].spawndist = 100;
  level.helperdronesettings["scrambler_drone_guard"].streakname = "scrambler_drone_guard";
  level.helperdronesettings["scrambler_drone_guard"].vehicleinfo = "veh_scrambler_drone_guard_mp";

  if(level.gametype == "br") {
    level.helperdronesettings["scrambler_drone_guard"].modelbase = "veh8_mil_air_cuniform_br";
  } else {
    level.helperdronesettings["scrambler_drone_guard"].modelbase = "veh8_mil_air_cuniform";
    level.helperdronesettings["scrambler_drone_guard"].modelbasealt = "veh8_mil_air_cuniform_east";
  }

  level.helperdronesettings["scrambler_drone_guard"].teamsplash = "used_scrambler_drone_guard";
  level.helperdronesettings["scrambler_drone_guard"].destroyedsplash = "callout_destroyed_scrambler_drone_guard";
  level.helperdronesettings["scrambler_drone_guard"].fxid_explode = loadfx("vfx/iw8_mp/killstreak/vfx_drone_dest_exp.vfx");
  level.helperdronesettings["scrambler_drone_guard"].sound_explode = "scrambler_drone_explode";
  level.helperdronesettings["scrambler_drone_guard"].vodestroyed = "destroyed_scrambler_drone_guard";
  level.helperdronesettings["scrambler_drone_guard"].votimedout = "timeout_scrambler_drone_guard";
  level.helperdronesettings["scrambler_drone_guard"].scorepopup = "destroyed_scrambler_drone_guard";
  level.helperdronesettings["scrambler_drone_guard"].playfxcallback = &helperdronefx;
  level.helperdronesettings["scrambler_drone_guard"].fxid_light1 = [];
  level.helperdronesettings["scrambler_drone_guard"].fxid_light1["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_light_detonator_blink");
  level.helperdronesettings["scrambler_drone_guard"].fxid_light1["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
  level.helperdronesettings["scrambler_drone_guard"].primarymodefunc = &setguardmode;
  level.helperdronesettings["scrambler_drone_guard"].premoddamagefunc = undefined;
  level.helperdronesettings["scrambler_drone_guard"].postmoddamagefunc = &helperdrone_modifydamagestates;
  level.helperdronesettings["scrambler_drone_guard"].deathfunc = &helperdronedestroyed;
  level.helperdronesettings["scrambler_drone_guard"].damagemonitorfunc = &helperdrone_watchdamage;

  if(level.gametype == "br") {
    level.helperdronesettings["scrambler_drone_guard"].deployweaponname = "ks_gesture_generic_mp";
  } else {
    level.helperdronesettings["scrambler_drone_guard"].deployweaponname = "ks_remote_map_mp";
  }

  level.helperdronesettings["ammo_drop"] = spawnStruct();
  level.helperdronesettings["ammo_drop"].timeout = undefined;
  level.helperdronesettings["ammo_drop"].maxhealth = 100;
  level.helperdronesettings["ammo_drop"].hitstokill = 3;
  level.helperdronesettings["ammo_drop"].speed = 60;
  level.helperdronesettings["ammo_drop"].accel = 20;
  level.helperdronesettings["ammo_drop"].halfsize = 30;
  level.helperdronesettings["ammo_drop"].spawndist = 100;
  level.helperdronesettings["ammo_drop"].streakname = "ammo_drop";
  level.helperdronesettings["ammo_drop"].vehicleinfo = "veh_delivery_drone_recon_mp";
  level.helperdronesettings["ammo_drop"].modelbase = "veh8_mil_air_malfa_big";
  level.helperdronesettings["ammo_drop"].teamsplash = "used_radar_drone_recon";
  level.helperdronesettings["ammo_drop"].destroyedsplash = "callout_destroyed_radar_drone_overwatch";
  level.helperdronesettings["ammo_drop"].fxid_explode = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sm_dest_exp.vfx");
  level.helperdronesettings["ammo_drop"].sound_explode = "radar_drone_explode";
  level.helperdronesettings["ammo_drop"].vodestroyed = "ball_drone_backup_destroy";
  level.helperdronesettings["ammo_drop"].votimedout = "ball_drone_backup_timeout";
  level.helperdronesettings["ammo_drop"].scorepopup = "destroyed_radar_drone_recon";
  level.helperdronesettings["ammo_drop"].playfxcallback = &helperdronefx;
  level.helperdronesettings["ammo_drop"].standupoffset = 120;
  level.helperdronesettings["ammo_drop"].crouchupoffset = 80;
  level.helperdronesettings["ammo_drop"].proneupoffset = 46;
  level.helperdronesettings["ammo_drop"].backoffset = 124;
  level.helperdronesettings["ammo_drop"].sideoffset = 55;
  level.helperdronesettings["ammo_drop"].primarymodefunc = &setdeliverymodesettings;
  level.helperdronesettings["ammo_drop"].premoddamagefunc = undefined;
  level.helperdronesettings["ammo_drop"].postmoddamagefunc = &helperdrone_modifydamageresponse;
  level.helperdronesettings["ammo_drop"].deathfunc = &helperdronedestroyed;
  level.helperdronesettings["ammo_drop"].deployweaponname = "ks_gesture_generic_mp";
  level.helperdronesettings["assault_drone"] = spawnStruct();
  level.helperdronesettings["assault_drone"].timeout = 45;
  level.helperdronesettings["assault_drone"].maxhealth = 100;
  level.helperdronesettings["assault_drone"].hitstokill = 3;
  level.helperdronesettings["assault_drone"].speed = 100;
  level.helperdronesettings["assault_drone"].accel = 20;
  level.helperdronesettings["assault_drone"].halfsize = 27;
  level.helperdronesettings["assault_drone"].spawndist = 30;
  level.helperdronesettings["assault_drone"].streakname = "assault_drone";
  level.helperdronesettings["assault_drone"].vehicleinfo = "veh_assault_drone_mp";
  level.helperdronesettings["assault_drone"].modelbase = "veh8_mil_air_tuniform_c4";
  level.helperdronesettings["assault_drone"].teamsplash = "used_assault_drone";
  level.helperdronesettings["assault_drone"].destroyedsplash = "callout_destroyed_assault_drone";
  level.helperdronesettings["assault_drone"].fxid_explode = loadfx("vfx/iw8/prop/scriptables/vfx_veh8_mil_air_tuniform_c4_debris.vfx");
  level.helperdronesettings["assault_drone"].sound_explode = "recon_drone_explode";
  level.helperdronesettings["assault_drone"].vodestroyed = "ball_drone_backup_destroy";
  level.helperdronesettings["assault_drone"].votimedout = "ball_drone_backup_timeout";
  level.helperdronesettings["assault_drone"].scorepopup = "destroyed_assault_drone";
  level.helperdronesettings["assault_drone"].playfxcallback = &helperdronefx;
  level.helperdronesettings["assault_drone"].primarymode = "MANUAL";
  level.helperdronesettings["assault_drone"].primarymodestring = &"KILLSTREAKS_HINTS/RCD_MANUAL";
  level.helperdronesettings["assault_drone"].primarymodefunc = &ref_13128;
  level.helperdronesettings["assault_drone"].premoddamagefunc = undefined;
  level.helperdronesettings["assault_drone"].postmoddamagefunc = &helperdrone_modifydamageresponse;
  level.helperdronesettings["assault_drone"].deathfunc = &helperdronedestroyed;
  level.helperdronesettings["assault_drone"].deployweaponname = "ks_assault_drone_mp";
  level.helperdronesettings["assault_drone"].ref_11B06 = 0;
  level.helperdronesettings["assault_drone"].ref_11B07 = 0;
  level.helperdronesettings["assault_drone"].ref_11B17 = 73984;
  level.helperdronesettings["assault_drone"].ref_11B18 = 73984;
  level.helperdronesettings["assault_drone"].leaderinteractionthink = 1;
  level.helperdronesettings["assault_drone"].leaderboarddata = undefined;
  level.helperdronesettings["assault_drone"].leaderplunderstring = 1;
  level.helperdronesettings["assault_drone"].ref_1217E = undefined;
  var_0 = "br";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
  }

  if(var_0 == "br" || var_0 == "cp_survival") {
    level.helperdronesettings["radar_drone_recon"].diewithowner = 1;
    level.helperdronesettings["scrambler_drone_guard"].diewithowner = 1;
    level.helperdronesettings["radar_drone_overwatch"].diewithowner = 1;
    level.helperdronesettings["assault_drone"].diewithowner = 1;
  }

  level._effect["scrambler_screen"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sc_a.vfx");
  level._effect["scrambler_screen_1"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sc_1.vfx");
  level._effect["scrambler_screen_2"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sc_2.vfx");
  level._effect["scrambler_screen_3"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sc_3.vfx");
  level._effect["scrambler_screen_4"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_sc_4.vfx");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "init")]]();
  }

  level.incominghelperdrones = [];
  init_helper_drone_vo();
  init_helper_drone_anim();
  level.cargo_truck_horn = getdvarfloat("scr_assault_drone_enemy_notify_dist", 3000);
  level.cargo_truck = getdvarint("scr_assault_drone_freeze_debug", 0);
  level.mine_caves_turrets = getdvarint("scr_drone_freeze_switch_debug", 1);
}

function init_helper_drone_vo() {
  game["dialog"]["radar_drone_damage_high"] = "radar_drone_health_low";
  game["dialog"]["radar_drone_damage_med"] = "radar_drone_health_med";
  game["dialog"]["radar_drone_damage_light"] = "radar_drone_health_high";
}

#using_animtree("");

function init_helper_drone_anim() {
  level.scr_animtree["scrambler_drone_guard"] = #animtree;
  level.scr_anim["scrambler_drone_guard"]["rotor_spin"] = [$mp_cuniform_rotor_spin];
  level.scr_animname["scrambler_drone_guard"]["rotor_spin"] = "mp_cuniform_rotor_spin";
}

function weapongivenhelperdrone(var_0) {
  var_1 = var_0.streakname;

  if(var_1 == "scrambler_drone_guard" || var_1 == "radar_drone_recon" || var_1 == "assault_drone") {
    var_2 = tryusehelperdroneearlyout(var_0, 1);

    if(var_2) {
      if(var_1 == "scrambler_drone_guard") {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_COUNTER_UAV");
        }
      }

      return false;
    }

    if(var_1 == "scrambler_drone_guard") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "startMapSelectSequence")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "startMapSelectSequence")]](0, 0, undefined, 1);
      }
    }
  }

  return true;
}

function addincominghelperdrone(var_0) {
  level.incominghelperdrones[level.incominghelperdrones.size] = spawnStruct();
  level.incominghelperdrones[level.incominghelperdrones.size - 1].type = var_0.streakname;
  level.incominghelperdrones[level.incominghelperdrones.size - 1].owner = self;
  level.incominghelperdrones[level.incominghelperdrones.size - 1].team = self.team;
}

function removeincominghelperdrone(var_0) {
  if(level.incominghelperdrones.size == 0) {
    return;
  }

  var_1 = [];

  foreach(var_3 in level.incominghelperdrones) {
    if(var_3.type == var_0.streakname && var_3.owner == self) {
      continue;
    }

    var_1 = var_3;
  }

  level.incominghelperdrones = var_1;
}

function addincominghelperdroneifpossible(var_0, var_1) {
  addincominghelperdrone(var_0);

  if(exceededmaxhelperdrones(var_0, self)) {
    removeincominghelperdrone(var_0);
    return false;
  }

  return true;
}

function incrementfauxvehiclecountifpossible(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + 1 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(istrue(var_1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
        }
      }

      return false;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]](1);
  }

  return true;
}

function recondrone_equipment_wrapper(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var_1);
  }

  var_3 = tryusehelperdrone("radar_drone_recon");

  if(!var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_recondrone", var_1);
      return;
    }

    return;
  }
}

function scramblerdrone_equipment_wrapper(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var_1);
  }

  var_3 = tryusehelperdrone("scrambler_drone_guard");

  if(!var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_scramblerdrone", var_1);
      return;
    }

    return;
  }
}

function radardrone_equipment_wrapper(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var_1);
  }

  var_3 = tryusehelperdrone("radar_drone_overwatch");

  if(!var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_radardrone", var_1);
      return;
    }

    return;
  }
}

function tryusehelperdrone(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  return tryusehelperdronefromstruct(var_1);
}

function tryusehelperdronefromstruct(var_0) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  var_1 = 0;

  if(var_0.streakname == "scrambler_drone_guard") {
    var_1 = 1;
  }

  if(!var_1) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
      return false;
    }
  }

  var_2 = level.helperdronesettings[var_0.streakname].deployweaponname;
  var_3 = getcompleteweaponname(var_2);

  if(var_2 == "ks_remote_map_mp") {
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, var_3, 1, &weapongivenhelperdrone);
  } else if(var_3 == "ks_remote_drone_mp") {
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_1, var_4, 1, &weapongivenhelperdrone);
  } else if(var_4 == "ks_assault_drone_mp") {
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_2, var_4, 1, &weapongivenhelperdrone);
  } else if(var_4 == "ks_gesture_generic_mp") {
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_3, var_4);
  } else if(var_4 == "ks_remote_device_mp") {
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_4);
  } else {
    var_4 = 0;
  }

  var_5 = self.start_player_links;
  self.start_player_links = undefined;

  if(!istrue(var_4)) {
    if(!var_4) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    if(istrue(var_5)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      }

      removeincominghelperdrone(var_4);
    }

    return false;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1) && self hasweapon(var_4)) {
    if(!var_4) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    if(istrue(var_5)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      }

      removeincominghelperdrone(var_4);
    }

    if(var_4 != "ks_gesture_generic_mp") {
      var_4 notify("killstreak_finished_with_deploy_weapon");
    }

    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_4)) {
      if(!var_4) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var_4);
      }

      if(var_4 != "ks_gesture_generic_mp") {
        var_4 notify("killstreak_finished_with_deploy_weapon");
      }

      return false;
    }
  }

  var_6 = var_4.streakname;
  var_7 = var_6 == "scrambler_drone_guard" || var_6 == "radar_drone_recon" || var_6 == "assault_drone";

  if(!var_7 || var_4 == "ks_gesture_generic_mp") {
    var_8 = tryusehelperdroneearlyout(var_4, 1);

    if(var_8) {
      if(!var_4) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var_4);
      }

      if(var_4 != "ks_gesture_generic_mp") {
        var_4 notify("killstreak_finished_with_deploy_weapon");
      }

      return false;
    }
  }

  var_9 = find_safe_spawn(var_6);

  if(var_4 == "ks_remote_device_mp") {
    if(!isDefined(var_9)) {
      if(!var_4) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var_4);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
      }

      var_4 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  if(var_4 == "ks_remote_drone_mp" || var_4 == "ks_assault_drone_mp") {
    if(istrue(level.mine_caves_turrets)) {
      self freezecontrols(1);
    } else {
      scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "helperDroneKillstreakDeploy");
    }

    var_10 = 0.6;
    var_11 = 2;
    var_12 = scripts\engine\utility::ref_143BA(var_10, "death", "weapon_switch_started");

    if(!isDefined(var_12) || var_12 != "timeout") {
      if(!var_4) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var_4);
      }

      if(istrue(level.mine_caves_turrets)) {
        self freezecontrols(0);
      } else {
        scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "helperDroneKillstreakDeploy");
      }

      var_4 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }

    scripts\common\utility::allow_weapon_switch(0);
    var_12 = scripts\engine\utility::ref_143B9(var_11 - var_10, "death");

    if(!isDefined(var_12) || var_12 != "timeout") {
      if(!var_4) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var_4);
      }

      if(istrue(level.mine_caves_turrets)) {
        self freezecontrols(0);
      } else {
        scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "helperDroneKillstreakDeploy");
      }

      scripts\common\utility::allow_weapon_switch(1);
      var_4 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }

    if(istrue(level.mine_caves_turrets)) {
      self freezecontrols(0);
    } else {
      scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "helperDroneKillstreakDeploy");
    }

    scripts\common\utility::allow_weapon_switch(1);
  }

  var_13 = undefined;

  if(var_4 == "ks_remote_map_mp") {
    var_13 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getSelectMapPoint")) {
      var_13 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getSelectMapPoint")]](var_4, 1);
    }

    if(!isDefined(var_13)) {
      if(!var_4) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var_4);
      }

      return false;
    }
  } else if(var_6 == "scrambler_drone_guard") {
    var_14 = self.origin;

    if(isDefined(level.ref_13C34)) {
      var_15 = [[level.ref_13C34]](self.origin);
      var_14 = var_15["position"];
    }

    var_16 = spawnStruct();
    var_16.location = var_14;
    var_13 = [];
    var_13 = var_16;
  }

  var_17 = self.angles;
  var_18 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_4.streakname);
    var_18 = 2;
  }

  if(level.gametype == "br") {
    if(var_6 == "scrambler_drone_guard") {
      scripts\cp_mp\killstreaks\uav::ref_13ED5(self.team, 15000, "scrambler_drone_guard");
    }
  }

  if(isDefined(var_13)) {
    if(var_6 == "scrambler_drone_guard") {
      var_19 = var_13[0].location + (0, 0, 3000);
      var_20 = createhelperdrone(var_19, var_17, var_6, var_4, var_4, !var_4);

      if(!isDefined(var_20)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE");
        }

        if(istrue(var_5)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
          }

          removeincominghelperdrone(var_4);
        }

        return false;
      }

      var_20.mappointinfo = var_13;
      thread perkengineer_manageminimap();
      removeincominghelperdrone(var_4);
      thread starthelperdrone(var_20);
    }
  } else {
    if(var_6 == "radar_drone_escort" || var_6 == "radar_drone_recon" || var_6 == "assault_drone") {
      var_9 = find_safe_spawn(var_6);
    }

    if(var_6 == "radar_drone_overwatch") {
      var_9 = self.origin + (0, 0, 1500) - anglesToForward(self.angles) * 5000;
    }

    var_20 = createhelperdrone(var_9, var_17, var_6, var_4, var_4, !var_4);

    if(!isDefined(var_20)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
      }

      helperdronecreationfailedfx(var_6, var_9);
      var_4 notify("killstreak_finished_with_deploy_weapon");

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var_4);
      }

      return false;
    }

    if(var_6 == "radar_drone_recon" || var_6 == "assault_drone") {
      thread helperdrone_giveplayerfauxremote(var_4);
    }

    removeincominghelperdrone(var_4);
    thread starthelperdrone(var_20);
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_4.streakname, 1, var_18);
  var_21 = level.helperdronesettings[var_6].teamsplash;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var_21, self);
  }

  return true;
}

function helperdronecreationfailedfx(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self getEye() + (0, 0, 80);
  }

  var_2 = level.helperdronesettings[var_0];
  var_3 = "ks_" + var_0 + "_mp";

  if(var_0 == "assault_drone") {
    var_3 = var_2.modelbase;
  }

  var_4 = spawn("script_model", var_1);
  var_4 setModel(var_3);
  var_4 setscriptablepartstate("explode", "on", 0);
  thread delay_deletescriptable(var_4);
}

function tryusehelperdroneearlyout(var_0, var_1) {
  if(scripts\cp_mp\utility\player_utility::isusingremote()) {
    return true;
  }

  if(istrue(self.drones_disabled)) {
    if(var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE");
      }
    }

    return true;
  }

  if((var_0.streakname == "radar_drone_recon" || var_0.streakname == "assault_drone") && (!self isonground() && !self isonladder() || _calloutmarkerping_handleluinotify_enemyrepinged::updateleaders())) {
    if(var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/FIELD_UPGRADE_CANNOT_USE");
      }
    }

    return true;
  }

  if(isDefined(level.getfirespoutlaunchvectors)) {
    if(![[level.getfirespoutlaunchvectors]](self)) {
      if(var_1) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/FIELD_UPGRADE_CANNOT_USE");
        }
      }

      return true;
    }
  }

  var_2 = incrementfauxvehiclecountifpossible(var_0, var_1);

  if(!var_2) {
    return true;
  }

  var_3 = addincominghelperdroneifpossible(var_0, var_1);

  if(!var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]](1);
    }

    return true;
  }

  self.start_player_links = 1;
  return false;
}

function delay_deletescriptable(var_0) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  self delete();
}

function createhelperdrone(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = !istrue(var_4) && istrue(var_5);

  if(!isDefined(var_0)) {
    if(!istrue(var_6)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    return;
  }

  var_7 = level.helperdronesettings[var_2];
  var_8 = var_7.modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(self) && isDefined(var_7.modelbasealt)) {
    var_8 = var_7.modelbasealt;
  }

  var_9 = undefined;

  if(istrue(var_4)) {
    var_9 = spawn("script_model", var_0);
    var_9 setModel(var_8);
    var_9.nonvehicle = 1;
  } else {
    if(var_6) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    var_9 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(self, var_0, var_1, var_7.vehicleinfo, var_8);
  }

  if(!isDefined(var_9)) {
    return;
  }

  var_9 enableaimassist();
  var_9 setnodeploy(1);
  var_9.health = var_7.maxhealth;
  var_9.maxhealth = var_7.maxhealth;
  var_9.damagetaken = 0;
  var_9.speed = var_7.speed;
  var_9.accel = var_7.accel;
  var_9.angles = var_1;
  var_9.manualspeed = 50;
  var_9.owner = self;
  var_9.team = self.team;
  var_9.helperdronetype = var_2;
  var_9.combatmode = var_7.primarymode;
  var_9.currentstring = var_7.secondarymodestring;
  var_9.streakinfo = var_3;
  var_9.currentdamagestate = 0;

  if(istrue(var_9.nonvehicle)) {
    var_9 scripts\mp\sentientpoolmanager::registersentient("Tactical_Moving", self, undefined, undefined, 0, 1);
  } else {
    var_9 scripts\mp\sentientpoolmanager::registersentient("Lethal_Moving", self);
    var_9 setvehicleteam(var_9.team);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var_7.streakname, var_7.scorepopup, var_7.vodestroyed, undefined, var_7.destroyedsplash);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var_3.streakname, var_7.premoddamagefunc);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var_3.streakname, var_7.postmoddamagefunc);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var_3.streakname, var_7.deathfunc);
  }

  if(isDefined(var_7.flarescount)) {
    var_9.flaresreservecount = var_7.flarescount;
  }

  var_9 setotherent(self);
  var_9 setCanDamage(1);

  if(istrue(var_4)) {
    var_9 scriptmoveroutline();
    var_9 scriptmoverthermal();
  } else {
    var_9 vehicle_invoketriggers(1);
    var_9 vehicle_breakglass(1);
  }

  var_11 = 12;

  switch (var_2) {
    case "radar_drone_overwatch":
      var_11 = 60;
      break;
    case "scrambler_drone_escort":
      var_12 = helperdrone_spawnnewscrambler(var_9, "medium");
      var_9.scrambler = var_12;
      break;
    case "scrambler_drone_guard":
      if(istrue(level.ref_11A9D)) {
        var_12 = helperdrone_spawnnewscrambler(var_9, "large");
        var_9.scrambler = var_12;
      }

      var_11 = 100;
      break;
    case "radar_drone_recon":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
          var_9 vehicleshowonminimap(0);

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakUseDialog")) {
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakUseDialog")]]("radar_drone_recon");
          }

          spawn_additional_covernode(var_9, var_2);
        }
      }

      break;
    case "assault_drone":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
          var_9 vehicleshowonminimap(0);

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakUseDialog")) {
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakUseDialog")]]("assault_drone");
          }

          spawn_additional_covernode(var_9, var_2);
        }
      }

      break;
    default:
      break;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_3.streakname, "Killstreak_Air", var_9.owner, 0, 1, var_11);
  }

  var_9.attract_strength = 10000;
  var_9.attract_range = 150;
  var_9.attractor = missile_createattractorent(var_9, var_9.attract_strength, var_9.attract_range);
  var_9.stunned = 0;
  var_9.inactive = 0;
  thread helperdrone_play_lightfx();
  var_13 = spawnStruct();
  var_13.validateaccuratetouching = 1;
  var_13.deathoverridecallback = &helperdrone_moving_platform_death;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "handlemovingplatforms")) {
    var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "handlemovingplatforms")]](var_13);
  }

  if(isDefined(level.helperdronesettings[var_9.helperdronetype].streakname)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
      var_9.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_7.streakname, var_9.targetpos);
    }
  }

  return var_9;
}

function spawn_additional_covernode(var_0) {
  var_1 = 3000;

  if(var_0 == "assault_drone") {
    var_1 = level.cargo_truck_horn;
  }

  var_2 = level.teamdata[self.team]["players"];
  var_3 = scripts\common\utility::playersincylinder(self.origin, var_1, var_2);

  foreach(var_5 in var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayer")) {
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayer")]](var_5, var_0, 1);
    }
  }
}

function helperdrone_handleteamvisibility() {
  foreach(var_1 in level.players) {
    if(level.teambased && var_1.team == self.team || !level.teambased && var_1 == self.owner) {
      self hidefromplayer(var_1);
    }
  }

  thread helperdrone_managevisibilityonteamjoin();
}

function helperdrone_managevisibilityonteamjoin() {
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

function helperdrone_endscramblereffect() {
  self notify("scramble_super_finished");

  if(isDefined(self.new_objective_thread) && self.new_objective_thread.size > 0) {
    foreach(var_1 in self.new_objective_thread) {
      if(isDefined(var_1)) {
        var_2 = var_1;

        if(isDefined(var_2.owner)) {
          var_2 = var_2.owner;
        }

        var_2 notify("scramble_off");
      }
    }
  }

  if(isDefined(self.friendliesaffectedbyscrambler) && self.friendliesaffectedbyscrambler.size > 0) {
    foreach(var_5 in self.friendliesaffectedbyscrambler) {
      if(isDefined(var_5)) {
        var_5 notify("scramble_off");
      }
    }

    return;
  }
}

function spawn_ai_single(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("scramble_super_finished");

  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  self.new_objective_thread = [];
  var_1 = 0;
  var_2 = getdvarfloat("compassScramblerRadius", 1000);
  var_3 = var_2 * var_2;
  var_4 = physics_createcontents(["physicscontents_player"]);
  var_5 = self.origin - (0, 0, 3000);
  var_6 = (var_2, var_2, 3000);
  var_7 = var_5 - var_6;
  var_8 = var_5 + var_6;

  for(;;) {
    var_9 = physics_aabbbroadphasequery(var_7, var_8, var_4, []);

    foreach(var_11 in var_9) {
      var_12 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        var_12 = var_11[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_scrambler_resist");
      }

      if(isDefined(var_11) && var_11 scripts\cp_mp\utility\player_utility::_isalive() && !var_12) {
        if(distance2dsquared(self.origin, var_11.origin) > var_3) {
          continue;
        }

        if(var_1 || level.teambased && var_11.team != self.team && var_11.team != "spectator" || !level.teambased && var_11 != self.owner) {
          if(var_11 scripts\cp_mp\utility\player_utility::isusingremote()) {
            continue;
          }

          if(helperdrone_entaffectedbyscramble(var_11, self, var_1)) {
            continue;
          }

          helperdrone_setscramblerjammed(var_11, 1, self, var_1);
        }

        continue;
      }

      if(isDefined(var_11.scrambledby) && var_11.scrambledby == self) {
        var_11 notify("scramble_off");
      }
    }

    waitframe();
  }
}

function helperdrone_setscramblerplayerbuffs(var_0, var_1) {
  if(helperdrone_entaffectedbyscramble(var_1) && istrue(var_0)) {
    return;
  }

  if(istrue(var_0)) {
    var_1.friendliesaffectedbyscrambler[var_1.friendliesaffectedbyscrambler.size] = self;
    thread helperdrone_managescramblerplayerbuff(var_1);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_blindeye");
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_noscopeoutline");
      return;
    }

    return;
  }

  if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_blindeye");
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_noscopeoutline");
      return;
    }

    return;
  }
}

function helperdrone_managescramblerplayerbuff(var_0) {
  scripts\engine\utility::ref_143A5("death_or_disconnect", "scramble_off");
  helperdrone_setscramblerplayerbuffs(0, var_0);
}

function helperdrone_setscramblerjammed(var_0, var_1, var_2) {
  var_3 = self;

  if(istrue(var_0)) {
    var_3.scrambledby = var_1;

    if(!scripts\engine\utility::array_contains(var_1.new_objective_thread, var_3)) {
      var_1.new_objective_thread[var_1.new_objective_thread.size] = var_3;
    }

    thread helperdrone_managescramblereffect(var_3, var_1);
    thread helperdrone_watchscramblestrength(var_3);
    return;
  }

  if(isDefined(var_3)) {
    var_3.scrambledby = undefined;
    var_3 scripts\cp_mp\emp_debuff::stop_emp_scramble(var_3.currentscramblerstrength);
    var_3.previousscramblerstrength = undefined;
    var_3.currentscramblerstrength = undefined;
    return;
  }
}

function helperdrone_managescramblereffect(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::ref_143A5("death", "scramble_off");

  if(isDefined(self)) {
    helperdrone_setscramblerjammed(0, var_0, var_1);

    if(isDefined(var_0) && isDefined(var_0.new_objective_thread)) {
      var_0.new_objective_thread = scripts\engine\utility::array_remove(var_0.new_objective_thread, self);
      return;
    }

    return;
  }

  if(isDefined(var_0) && isDefined(var_0.new_objective_thread)) {
    var_0.new_objective_thread = scripts\engine\utility::array_removeundefined(var_0.new_objective_thread);
    return;
  }
}

function helperdrone_watchremotescrambledent(var_0, var_1) {
  var_0 endon("death");
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.owner)) {
    if(helperdrone_entaffectedbyscramble(self.owner, var_0, var_1)) {
      helperdrone_setscramblerjammed(self.owner, 0, var_0, var_1);
      return;
    }

    return;
  }
}

function helperdrone_watchscramblestrength(var_0) {
  self endon("death");
  self endon("scramble_off");
  self endon("disconnect");
  var_0 endon("death");
  var_1 = 0;
  var_2 = 0;
  var_3 = getdvarfloat("compassScramblerRadius", 1000);
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

    var_6 = var_2 != var_1;

    if(var_1 == 0 || var_6) {
      self.previousscramblerstrength = var_1;
      self.currentscramblerstrength = var_2;

      if(self.previousscramblerstrength > 1) {
        var_7 = self.previousscramblerstrength;
      }

      if(self.currentscramblerstrength > 1) {
        var_7 = self.currentscramblerstrength;
      }

      scripts\cp_mp\emp_debuff::stop_emp_scramble(var_1);
      scripts\cp_mp\emp_debuff::play_emp_scramble(var_2);
      var_1 = var_2;
    }

    waitframe();
  }
}

function helperdrone_entaffectedbyscramble() {
  var_2 = 0;
  var_3 = undefined;

  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(var_5 in level.supportdrones) {
      if(var_5.helperdronetype != "scrambler_drone_guard") {
        continue;
      }

      if(level.teambased) {
        if(!isDefined(var_1) && var_5.team == self.team) {
          var_3 = var_5.friendliesaffectedbyscrambler;
        } else {
          var_3 = var_5.new_objective_thread;
        }
      } else if(!isDefined(var_1) && var_5.owner == self) {
        var_3 = var_5.friendliesaffectedbyscrambler;
      } else {
        var_3 = var_5.new_objective_thread;
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

    var_1 = undefined;
    var_3 = undefined;
  }

  return < error > ;
}

function helperdrone_enableradar(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1.owner = self.owner;
  var_1.team = self.owner.team;
  self.radar = var_1;

  if(var_0 == "auto_radar") {
    var_1 makeportableradar(self.owner);
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
        var_2 *= getdvarfloat("perk_target_marked_longer_rate");
      }
    }

    thread helperdrone_watchradartrigger(500, 10, 0.1, var_2);
  }

  var_1 linkTo(self);
}

function helperdrone_watchradartrigger(var_0, var_1, var_2, var_3) {
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
        triggerportableradarpingteam(self.radar.origin, self.radar.team, var_0, int(var_6 / 2));
      } else {
        triggerportableradarping(self.radar.origin, self.radar.owner, var_0, int(var_6 / 2));
      }

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
      self.radar setscriptablepartstate("pulse", "on", 0);
      self playSound("oracle_radar_pulse_npc");
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6 / 1000);
      self.radar setscriptablepartstate("pulse", "off", 0);
    }

    self notify("death");
  }
}

function helperdrone_disableradar() {
  if(isDefined(self.radar)) {
    self.radar delete();
    return;
  }
}

function helperdrone_spawnnewscrambler(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self.origin);
  var_3.team = self.owner.team;
  var_3 makescrambler(self.owner, var_0);
  var_3 linkTo(self);
  return var_3;
}

function helperdrone_moving_platform_death(var_0) {
  if(!isDefined(var_0.lasttouchedplatform.destroydroneoncollision) || var_0.lasttouchedplatform.destroydroneoncollision) {
    self notify("death");
    return;
  }
}

function helperdrone_play_lightfx() {
  var_0 = level.helperdronesettings[self.helperdronetype];

  if(isDefined(var_0.playfxcallback)) {
    self[[var_0.playfxcallback]]();
    return;
  }
}

function helperdronefx() {
  self setscriptablepartstate("lights", "on", 0);

  if(self.helperdronetype == "radar_drone_overwatch") {
    self setscriptablepartstate("glint", "on", 0);
    self setscriptablepartstate("engine", "on", 0);
  }

  if(self.helperdronetype == "radar_drone_recon") {
    self setscriptablepartstate("glint", "on", 0);
  }

  if(self.helperdronetype == "ammo_drop") {
    self setscriptablepartstate("glint", "on", 0);
    return;
  }
}

function starthelperdrone(var_0) {
  level endon("game_ended");
  var_0 endon("death");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  var_1 = level.helperdronesettings[var_0.helperdronetype];

  if(isDefined(var_1.damagemonitorfunc)) {
    var_0 thread[[var_1.damagemonitorfunc]]();
  }

  thread helperdrone_watchtimeout();
  thread helperdrone_watchownerloss();
  thread helperdrone_watchownerdeath();
  thread helperdrone_watchroundend();
  thread helperdrone_destroyongameend();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

    if(var_2 == "br") {
      thread spawn_ai_and_seat_in_vehicle(var_0);
    }
  }

  var_0 setCanDamage(1);
  var_0 thread[[var_1.primarymodefunc]](var_1);
}

function helperdrone_followplayer(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("target_assist");
  self endon("player_defend");
  self endon("switch_modes");

  if(!isDefined(self.owner)) {
    thread helperdrone_leave();
    return;
  }

  self.owner endon("disconnect");
  self endon("owner_gone");

  for(;;) {
    var_1 = self.owner getstance();

    if(!isDefined(self.last_owner_stance) || var_1 != self.last_owner_stance || istrue(self.stoppedatlocation)) {
      if(istrue(self.stoppedatlocation)) {
        self.stoppedatlocation = undefined;
      }

      self.last_owner_stance = var_1;
      helperdrone_movetoplayer(self.owner, var_0);
    }

    wait 0.5;
  }
}

function helperdrone_overwatchplayer() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
  }

  self.owner.showuavminimaponspawn = 1;
  thread helperdrone_showminimaponspawn(self.owner);
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

    var_6 = getcorrectheight(var_4, var_5, 20);
    var_7 = (var_4, var_5, var_6);
    self setlookatent(self.owner);
    self setvehgoalpos(var_7, 1);
    scripts\engine\utility::ref_143A5("goal", "begin_evasive_maneuvers");

    if(istrue(var_0)) {
      var_0 = undefined;
      self vehicle_setspeed(level.helperdronesettings[self.helperdronetype].speed, 10, 10);
    }

    self clearlookatent();
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

function getcorrectheight(var_0, var_1, var_2) {
  var_3 = 1500;
  var_5 = tracegroundpoint(var_0, var_1);
  var_6 = var_5 + var_3;
  var_6 += randomint(var_2);
  return var_6;
}

function tracegroundpoint(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  var_2 = -99999;
  var_3 = self.origin[2] + 2000;
  var_4 = level.averagealliesz;
  var_5 = [self];
  var_6 = scripts\engine\trace::sphere_trace((var_0, var_1, var_3), (var_0, var_1, var_2), 256, var_5, undefined, 1);

  if(var_6["position"][2] < var_4) {
    var_7 = var_4;
  } else {
    var_7 = var_7["position"][2];
  }

  return var_7;
}

function helperdrone_pingnearbyenemies() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  var_0 = 300;
  var_1 = 1200;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var_0 = 1000;
    var_1 = 2500;
  }

  self.ref_12368 = [];

  for(;;) {
    var_2 = scripts\common\utility::playersinsphere(self.owner.origin, var_1);

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

      if(source(var_4, self)) {
        continue;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_ghost")) {
          continue;
        }
      }

      triggerportableradarping(var_4.origin, self.owner, var_0, 3000);
      thread helperdrone_watchpingedstatus(var_4, self.owner);
    }

    waitframe();
  }
}

function helperdrone_watchpingedstatus(var_0, var_1) {
  self endon("death");
  var_0 endon("disconnect");
  level endon("game_ended");

  if(isDefined(var_1)) {
    var_0 playsoundtoplayer("recondrone_marker", var_1);
  }

  self.ref_12368[self.ref_12368.size] = var_0;
  var_0 scripts\engine\utility::ref_143B9(3, "death");
  self.ref_12368 = scripts\engine\utility::array_remove(self.ref_12368, var_0);
}

function source(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0.ref_12368) {
    if(isDefined(var_3) && self == var_3) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

function helperdrone_getheightoffset(var_0) {
  var_1 = var_0.standupoffset;
  var_2 = self.owner getstance();

  switch (var_2) {
    case "stand":
      var_1 = var_0.standupoffset;
      break;
    case "crouch":
      var_1 = var_0.crouchupoffset;
      break;
    case "prone":
      var_1 = var_0.proneupoffset;
      break;
  }

  return var_1;
}

function helperdrone_guardlocation() {
  self.stoppedatlocation = 1;
  var_0 = self.origin[2] / 2;
  var_1 = self.mappointinfo[0].location + (0, 0, var_0);
  var_2 = scripts\engine\trace::sphere_trace(self.origin, var_1, 200, self);

  if(isDefined(var_2)) {
    if(isDefined(var_2["entity"])) {
      var_1 = var_2["entity"].origin + (0, 0, randomintrange(50, 150));

      if(isDefined(var_2["entity"].guardlocation)) {
        var_1 = var_2["entity"].guardlocation + (0, 0, randomintrange(50, 150));
      }
    } else if(isDefined(var_2["hittype"]) && isDefined(var_2["position"]) && var_2["hittype"] != "hittype_none") {
      var_1 = var_2["position"] + (0, 0, randomintrange(50, 150));
    }
  }

  thread helperdrone_moveintoplace(var_1);
  self.guardlocation = var_1;
}

function helperdrone_moveintoplace(var_0) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("rotors", "on", 0);
  self playLoopSound("veh_scrambler_drone_idle_high");
  self moveTo(var_0 - (0, 0, 20), 3, 2, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.2);
  self moveTo(var_0, 1, 0.5, 0.5);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.2);

  for(;;) {
    var_1 = randomintrange(-35, 35);
    var_2 = randomintrange(-15, 15);
    var_3 = var_0[0] + var_1;
    var_4 = var_0[1] + var_1;
    var_5 = var_0[2] + var_2;
    var_6 = (var_3, var_4, var_5);
    self moveTo(var_6, 3, 2, 1);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.2);
  }
}

function helperdrone_watchradarpulse() {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");

  for(;;) {
    triggerportableradarping(self.origin, self.owner);
    self.owner playSound("oracle_radar_pulse_npc");
    wait 3;
  }
}

function helperdrone_movetoplayer(var_0, var_1) {
  self setlookatent(var_0);
  var_2 = helperdrone_gettargetoffset(self, var_0);

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  self setdronegoalent(var_0, var_2, 16, 10);
  self.intransit = 1;
  thread helperdrone_watchforgoal();
}

function helperdrone_watchmodeswitch() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");
  var_0 = level.helperdronesettings[self.helperdronetype];
  jumpiffalse(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "setKillstreakControlPriority")) LOC_00000076;
  self.useobj[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "setKillstreakControlPriority")]](self.owner, self.currentstring, 360, 360, 30000, 30000, 3);

  for(;;) {
    self.useobj waittill("trigger", var_1);

    if(var_1 != self.owner) {
      continue;
    }

    if(self.owner scripts\cp_mp\utility\player_utility::isusingremote()) {
      continue;
    }

    if(!self.owner scripts\common\utility::is_usability_allowed()) {
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "isTouchingBoundsTrigger")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "isTouchingBoundsTrigger")]](self.owner)) {
        continue;
      }
    }

    var_2 = 0;
    var_3 = undefined;
    var_4 = level.framedurationseconds;

    while(self.owner useButtonPressed()) {
      var_2 += var_4;

      if(var_2 > 0.1) {
        self notify("switch_modes");
        var_5 = getothermode(self.combatmode, self.streakinfo);
        var_6 = "Empty String";

        if(var_5 == var_0.primarymode) {
          var_3 = [[var_0.primarymodefunc]](var_0);
          var_6 = var_0.secondarymodestring;
        } else {
          var_3 = [[var_0.secondarymodefunc]](var_0);
          var_6 = var_0.primarymodestring;
        }

        if(!istrue(var_3)) {
          return;
        }

        self.combatmode = var_5;
        self.currentstring = var_6;
        self.useobj makeunusable();
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "setKillstreakControlPriority")) {
          self.useobj[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "setKillstreakControlPriority")]](self.owner, self.currentstring, 360, 360, 30000, 30000, 3);
        }

        break;
      }

      wait var_4;
    }

    wait var_4;
  }
}

function getothermode(var_0, var_1) {
  var_2 = level.helperdronesettings[self.helperdronetype];

  if(var_0 == var_2.primarymode) {
    var_0 = var_2.secondarymode;
  } else {
    var_0 = var_2.primarymode;
  }

  return var_0;
}

function setescortmodesettings(var_0) {
  self vehicle_setspeed(self.speed, self.accel);
  self setyawspeed(120, 90);
  self setneargoalnotifydist(16);
  self sethoverparams(30, 10, 5);
  self setturningability(1);
  self setdroneturnparams(50, 1.3, 30, 20);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
  }

  thread helperdrone_showminimaponspawn(self.owner);
  helperdrone_enableradar("escort_radar");
  thread helperdrone_followplayer();
  return true;
}

function setreconmodesettings(var_0) {
  self.playersfx = spawn("script_origin", self.origin);
  self.playersfx showonlytoplayer(self.owner);
  self.playersfx linkTo(self);
  self.playersfx playLoopSound("recon_drone_overlay");
  self.owner setsoundsubmix("mp_recon_drone", 1);

  if(!isDefined(self.enemiesmarked)) {
    self.enemiesmarked = [];
  }

  if(!isDefined(self.usedcount)) {
    self.usedcount = 0;
  }

  self.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("rcdmarker", self.owner, undefined, self.owner, 0, 0, 0);
  self.ispiloted = 1;
  self.owner scripts\common\utility::allow_usability(0);
  self.owner scripts\common\utility::allow_fire(0);
  var_1 = 0;
  self.owner.restoreangles = self.owner.angles;
  self.owner setplayerangles(self.angles);
  self.owner cameralinkTo(self, "tag_origin");
  self.owner remotecontrolvehicle(self);
  self.owner painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::ref_11DC0(self.owner);

  if(!istrue(var_1)) {
    ref_131B7(self.owner, 1, self);
    self.owner setclientomnvar("ui_rcd_outer_ring", 0);
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.timeout * 1000));
    self.owner setclientomnvar("ui_killstreak_health", helperdrone_getcurrenthealth() / var_0.maxhealth);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerEntForOOB")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerEntForOOB")]](self, "killstreak");
    }

    thread monitoroutofboundsdistortion();

    if(false) {
      scripts\cp_mp\outofrange::setupoutofrangewatcher(self, undefined, self.owner, undefined, 2250000, 9000000);
    }

    scripts\cp_mp\utility\weapon_utility::setlockedoncallback(self, &helperdrone_lockedoncallback);
    scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(self, &helperdrone_lockedonremovedcallback);
    thread helperdrone_watchouterreticletargets(var_0);
    thread helperdrone_watchouterreticlestate(var_0);
    thread helperdrone_watchnotificationstate(var_0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "mark_players")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "mark_players")]](var_0);
    } else {
      thread helperdrone_markplayers(var_0);
    }
  }

  self.owner scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  thread helperdrone_watchearlyexit(var_0);
  thread spawn_ai_func_ref(var_0);
  thread helperdrone_handlethermalswitch();
  thread spawn_acceleration(var_0);
  return true;
}

function ref_13128(var_0) {
  self.playersfx = spawn("script_origin", self.origin);
  self.playersfx showonlytoplayer(self.owner);
  self.playersfx linkTo(self);
  self.playersfx playLoopSound("recon_drone_overlay");
  self.owner setsoundsubmix("mp_recon_drone", 1);
  self.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("asdmarker", self.owner, undefined, self.owner, 0, 0, 0);
  self.ispiloted = 1;
  self.owner scripts\common\utility::allow_usability(0);
  self.owner scripts\common\utility::allow_fire(0);
  var_1 = 0;
  self.owner.restoreangles = self.owner.angles;
  self.owner setplayerangles(self.angles);
  self.owner cameralinkTo(self, "tag_origin");
  self.owner remotecontrolvehicle(self);
  self.owner painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::ref_11DC0(self.owner);

  if(!istrue(var_1)) {
    ref_131B7(self.owner, 1, self);
    self.owner setclientomnvar("ui_rcd_outer_ring", 0);
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.timeout * 1000));
    self.owner setclientomnvar("ui_killstreak_health", helperdrone_getcurrenthealth() / var_0.maxhealth);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerEntForOOB")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerEntForOOB")]](self, "killstreak");
    }

    thread monitoroutofboundsdistortion();

    if(false) {
      scripts\cp_mp\outofrange::setupoutofrangewatcher(self, undefined, self.owner, undefined, 2250000, 9000000);
    }

    scripts\cp_mp\utility\weapon_utility::setlockedoncallback(self, &helperdrone_lockedoncallback);
    scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(self, &helperdrone_lockedonremovedcallback);
    thread helperdrone_watchouterreticletargets(var_0);
    thread spawn_ai_individual(var_0);
    thread sp_stealth_broken_listener(var_0);
  }

  self playLoopSound("assault_drone_warning_beep");
  self.owner scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  thread helperdrone_watchearlyexit(var_0);
  thread spawn_ai_func_ref(var_0);
  thread helperdrone_handlethermalswitch();
  thread spawn_acceleration(var_0);

  if(istrue(level.cargo_truck)) {
    thread sounddebouncetimestamp(2);
  }

  return true;
}

function helperdrone_lockedoncallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

function helperdrone_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

function setoverwatchmodesettings(var_0) {
  thread helperdrone_overwatchplayer();
  thread helperdrone_pingnearbyenemies();
  helperdrone_handleteamvisibility();
  return true;
}

function setfollowmode(var_0) {
  thread helperdrone_followplayer();
  return true;
}

function setguardmode(var_0) {
  helperdrone_guardlocation();
  scramblerdrone_counteruavmodeon();
  helperdrone_handleteamvisibility();
  self setscriptablepartstate("looping_wave", "on", 0);
  self setscriptablepartstate("scramble_sfx", "on", 0);
  self scriptmodelplayanim(level.scr_animname["scrambler_drone_guard"]["rotor_spin"]);
  thread spawn_ai_single();
  return true;
}

function setdeliverymodesettings(var_0) {
  thread helperdrone_deliver(var_0);
  return true;
}

function helperdrone_deliver(var_0) {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self setneargoalnotifydist(10);
  var_1 = level.helperdronesettings[self.helperdronetype].speed;
  var_2 = level.helperdronesettings[self.helperdronetype].accel;
  self vehicle_setspeed(var_1, var_2, var_2);
  var_3 = self.deliverytarget + (0, 0, 4000);
  var_4 = self.deliverytarget + (0, 0, 2500);
  var_5 = self.deliverytarget + (0, 0, 100);
  var_6 = level.helperdronesettings[self.helperdronetype].halfsize;
  var_7 = [];
  GscBinSkip0(0x2e, 0, self);
}

function helperdrone_getcurrenthealth() {
  var_0 = self.maxhealth;
  var_1 = var_0 - self.damagetaken;
  return int(max(0, var_1));
}

function helperdrone_watchearlyexit(var_0) {
  self.owner endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("death", var_0.ref_1217E);
  }

  self waittill("killstreakExit");
  thread helperdroneexplode(0, istrue(var_0.leaderboarddata));
}

function spawn_ai_func_ref(var_0) {
  if(!istrue(var_0.leaderinteractionthink)) {
    return;
  }

  var_1 = self.owner;
  var_1 notifyonplayercommand("detonate_drone", "+attack");
  spawn_ai_group();

  if(isDefined(var_1)) {
    var_1 notifyonplayercommandremove("detonate_drone", "+attack");
    return;
  }
}

function spawn_ai_group() {
  self.owner endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  self.owner waittill("detonate_drone");
  thread helperdroneexplode(0, 1);
}

function helperdrone_handlethermalswitch() {
  var_0 = self.owner;
  var_0 thread scripts\cp_mp\utility\player_utility::watchthermalinputchange();
  var_1 = 1;

  if(istrue(var_1)) {
    if(level.mapname == "mp_hideout") {
      var_0 visionsetkillstreakforplayer("drone_color_dark");
    } else {
      var_0 visionsetkillstreakforplayer("drone_color");
    }
  }

  var_0 visionsetthermalforplayer("flir_0_black_to_white_recon");
  helperdrone_handlethermalswitchinternal();

  if(isDefined(var_0)) {
    var_0 scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();

    if(istrue(var_1)) {
      var_0 visionsetkillstreakforplayer("");
    }

    var_0 visionsetthermalforplayer("");

    if(self.isthermalenabled) {
      var_0 thermalvisionoff();
      return;
    }

    return;
  }
}

function helperdrone_handlethermalswitchinternal() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  self.isthermalenabled = 0;

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    self.isthermalenabled = 1;
    var_0 thermalvisionon();
  }

  for(;;) {
    var_0 waittill("switch_thermal_mode");

    if(self.isthermalenabled) {
      self.isthermalenabled = 0;
      var_0 thermalvisionoff();
      var_0 playlocalsound("weap_thermal_toggle_click");
      continue;
    }

    self.isthermalenabled = 1;
    var_0 playlocalsound("weap_thermal_toggle_click");
    var_0 thermalvisionon();
  }
}

function spawn_acceleration(var_0) {
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

    if(var_1 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var_2 = var_1;
    } else if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      var_2 = var_1.vehicle;
    } else if(istrue(var_1.velstartid)) {
      var_2 = var_1;
    }

    if(!isDefined(var_2)) {
      continue;
    }

    var_3 = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_2.owner));

    if(istrue(var_0.leaderplunderstring)) {
      if(var_3 || !isDefined(var_2.owner)) {
        thread helperdroneexplode(0, 1);
      } else {
        self dodamage(self.maxhealth, var_2.origin, undefined, undefined, "MOD_CRUSH");
      }
    } else {
      var_4 = undefined;
      var_5 = undefined;

      if(var_3) {
        var_6 = var_2.owner scripts\cp_mp\utility\player_utility::getvehicle();

        if(isDefined(var_6) && var_6 == var_2) {
          var_4 = var_2.owner;
          var_5 = var_2;
        }
      }

      self dodamage(self.maxhealth, var_2.origin, var_4, var_5, "MOD_CRUSH");
    }

    break;
  }
}

function sounddebouncetimestamp(var_0) {
  self.owner endon("disconnect");
  self endon("death");
  wait var_0;
  self.owner thread scripts\cp_mp\utility\player_utility::ai_offhandfiremanager();
}

function helperdrone_markplayers(var_0) {
  var_1 = self.owner;
  var_1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var_2 = 0;

  for(;;) {
    self.targethascoldblooded = 0;
    self.targetisnotinmarkingrange = 0;
    self.c130airdrop_findvaliddroplocation = 0;
    var_3 = self.targetsinouterradius;

    foreach(var_5 in var_3) {
      if(var_2 >= 3) {
        var_2 = 0;
        waitframe();
      }

      if(isPlayer(var_5) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var_5)) {
          continue;
        }
      }

      if(isagent(var_5) && !isalive(var_5)) {
        continue;
      }

      if(!isDefined(var_5)) {
        continue;
      }

      if(isbeingmarked(var_5)) {
        continue;
      }

      if(isreconmarked(var_5)) {
        continue;
      }

      var_2++;
      ref_131C9(self.targetmarkergroup, var_5, 1);
      var_6 = canseetarget(var_5);
      var_7 = helperdrone_istargetinreticle(var_1, var_5, 70, 40);
      var_8 = isinmarkingrange(var_5);
      var_9 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(isPlayer(var_5) && var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          var_9 = 1;
        }
      }

      if(var_7 && var_9) {
        self.targethascoldblooded = 1;
      }

      if(var_7 && !var_8) {
        self.targetisnotinmarkingrange = 1;
      }

      if(var_8) {
        self.c130airdrop_findvaliddroplocation = 1;
      }

      if(var_9) {
        ref_131C9(self.targetmarkergroup, var_5, 3);
        continue;
      }

      if(!var_8 || !var_6) {
        ref_131C9(self.targetmarkergroup, var_5, 0);
        continue;
      }

      if(!var_7) {
        continue;
      }

      if(istrue(self.markingtarget)) {
        continue;
      }

      thread startmarkingtarget(var_5, "enemy", 0, 1);
    }

    var_2 = 0;
    waitframe();
  }
}

function sp_stealth_broken_listener(var_0) {
  var_1 = self.owner;
  var_1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var_2 = 0;

  for(;;) {
    var_3 = self.targetsinouterradius;
    var_4 = 0;

    foreach(var_6 in var_3) {
      if(var_2 >= 3) {
        var_2 = 0;
        waitframe();
      }

      if(!isDefined(var_6)) {
        continue;
      }

      if(isPlayer(var_6) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var_6)) {
          continue;
        }
      }

      var_2++;
      ref_131C9(self.targetmarkergroup, var_6, 1);
      var_7 = canseetarget(var_6);
      var_8 = isinmarkingrange(var_6);

      if(!var_8 || !var_7) {
        ref_131C9(self.targetmarkergroup, var_6, 0);
        continue;
      }

      var_4 = 1;
      ref_131C9(self.targetmarkergroup, var_6, 2);
    }

    self.ref_13A79 = var_4;
    var_2 = 0;
    waitframe();
  }
}

function helperdrone_watchouterreticlestate(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");
  var_1 = 0;

  for(;;) {
    if(istrue(self.markingtarget) && var_1 == 0) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 1);
      var_1 = 1;
    } else if(!istrue(self.markingtarget) && var_1 == 1) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 0);
      var_1 = 0;
    }

    waitframe();
  }
}

function spawn_ai_individual(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");
  var_1 = 0;

  for(;;) {
    if(istrue(self.ref_13A79) && var_1 == 0) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 1);
      var_1 = 1;
    } else if(!istrue(self.ref_13A79) && var_1 == 1) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 0);
      var_1 = 0;
    }

    waitframe();
  }
}

function helperdrone_watchnotificationstate(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");

  for(;;) {
    if(istrue(self.targethascoldblooded)) {
      self.owner setclientomnvar("ui_rcd_notification", 3);
    } else if(istrue(self.targetisnotinmarkingrange)) {
      self.owner setclientomnvar("ui_rcd_notification", 1);
    } else if(!istrue(self.c130airdrop_findvaliddroplocation)) {
      self.owner setclientomnvar("ui_rcd_notification", 2);
    } else {
      self.owner setclientomnvar("ui_rcd_notification", 0);
    }

    waitframe();
  }
}

function helperdrone_watchouterreticletargets(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  self.owner endon("disconnect");
  self.targetsinouterradius = [];

  for(;;) {
    var_1 = level.activekillstreaks;
    var_2 = [[level.getactiveequipmentarray]]();
    var_3 = level.characters;

    if(isDefined(level.battle_tracks_shouldstartbattletracks)) {
      var_4 = [];

      foreach(var_6 in level.battle_tracks_shouldstartbattletracks) {
        if(isDefined(var_6.iscash)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "gameFlag")) {
            if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "gameFlag")]]("prematch_done")) {
              if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isPlayerOnIntelChallenge")) {
                if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerOnIntelChallenge")]](self.owner, var_6.iscash)) {
                  var_4 = var_6;
                }
              }
            }
          }

          continue;
        }

        var_4 = var_6;
      }

      var_8 = scripts\engine\utility::array_combine(var_3, var_4);
    } else {
      var_8 = var_3;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "get_outer_reticle_targets")) {
      var_8 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "get_outer_reticle_targets")]](var_0);
    }

    foreach(var_10 in var_8) {
      if(isPlayer(var_10)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
          if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var_10)) {
            continue;
          }
        }

        if(!istrue(var_0.ref_11B06)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
            if(var_10[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
              continue;
            }
          }
        }
      }

      if(isagent(var_10) && !isalive(var_10)) {
        continue;
      }

      if(level.teambased) {
        if(isDefined(var_10.team) && var_10.team == self.team) {
          continue;
        }
      } else {
        if(isPlayer(var_10) && var_10 == self.owner) {
          continue;
        }

        if(isDefined(var_10.owner) && var_10.owner == self.owner) {
          continue;
        }
      }

      if(!isindetectrange(var_10)) {
        continue;
      }

      if(isreconmarked(var_10)) {
        continue;
      }

      if(isinouterradius(self, var_10)) {
        continue;
      }

      var_0 = level.helperdronesettings[self.helperdronetype];

      if(istrue(var_0.ref_11B07) && !helperdrone_istargetinreticle(self.owner, var_10, 70, 300)) {
        continue;
      }

      thread startmarkingpassivetarget(var_10);
    }

    waitframe();
  }
}

function canseetarget(var_0) {
  var_1 = 0;

  if(isDefined(var_0.ref_12A9B)) {
    var_2 = var_0.ref_12A9B;
  } else {
    var_2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  }

  var_3 = var_1.origin;

  if(isDefined(var_1.ref_12A9C)) {
    var_3 += var_1.ref_12A9C;
  }

  var_4 = [var_3];

  if(isPlayer(var_1)) {
    var_5 = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      var_5 = var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceTop")]]();
    }

    var_6 = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      var_6 = var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceCenter")]]();
    }

    var_4 = [var_5, var_6, var_3];
  } else if(isagent(var_1)) {
    var_4 = [var_3 + (0, 0, 1)];
  }

  var_7 = [self, var_1];
  var_8 = var_1 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_8)) {
    var_7 = var_8;
    var_9 = var_8 getlinkedchildren(1);

    foreach(var_11 in var_9) {
      var_7 = var_8;
    }
  }

  for(var_13 = 0; var_13 < var_4.size; var_13++) {
    if(!scripts\engine\trace::ray_trace_passed(self.owner getvieworigin(), var_4[var_13], var_7, var_2)) {
      continue;
    }

    var_2 = 1;
    break;
  }

  return var_2;
}

function startmarkingpassivetarget(var_0) {
  var_1 = self.owner;
  var_1 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  if(!isDefined(self.targetmarkergroup)) {
    return;
  }

  self.targetsinouterradius[self.targetsinouterradius.size] = var_0;
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_0, self.targetmarkergroup, 0);
  ref_131C9(self.targetmarkergroup, var_0, 0);

  while(isDefined(var_0)) {
    if(isPlayer(var_0) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var_0)) {
        break;
      }
    }

    if(isagent(var_0) && !isalive(var_0)) {
      break;
    }

    var_2 = level.helperdronesettings[self.helperdronetype];

    if(istrue(var_2.ref_11B07) && !helperdrone_istargetinreticle(self.owner, var_0, 70, 300)) {
      break;
    }

    if(!isindetectrange(var_0)) {
      break;
    }

    waitframe();
  }

  if(isDefined(var_0)) {
    if(scripts\cp_mp\targetmarkergroups::targetmarkergroupexists(self.targetmarkergroup) && !isreconmarked(var_0)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var_0, var_0 getentitynumber(), self.targetmarkergroup);
    }

    if(scripts\engine\utility::array_contains(self.targetsinouterradius, var_0)) {
      self.targetsinouterradius = scripts\engine\utility::array_remove(self.targetsinouterradius, var_0);
      return;
    }

    return;
  }

  self.targetsinouterradius = scripts\engine\utility::array_removeundefined(self.targetsinouterradius);
}

function startmarkingtarget(var_0, var_1, var_2, var_3) {
  var_4 = self.owner;
  var_4 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var_5 = spawnStruct();
  var_5.target = var_0;
  var_5.targetnum = var_0 getentitynumber();
  var_5.markingent = self;
  var_5.ownerteam = var_4.team;
  var_5.outlineid = undefined;
  var_5.headicon = undefined;
  var_5.beingmarked = undefined;
  var_5.reconmarked = undefined;
  var_5.notifytoendmark = "unmarked_" + var_5.targetnum;

  if(!isDefined(var_5.targetnum)) {
    return;
  }

  if(!isDefined(self.targetmarkergroup)) {
    return;
  }

  var_5.beingmarked = 1;
  self.markingtarget = 1;
  self.owner notify("marking_target");
  ref_131B7(self.owner, 2, self);
  var_6 = getmarkingdelay(var_0);
  self.owner playlocalsound("recon_drone_marking_owner");

  while(var_6 > 0) {
    if(!isDefined(var_0)) {
      return;
    }

    if(!helperdrone_istargetinreticle(var_4, var_0, 70, 40)) {
      var_5.beingmarked = undefined;
      self.markingtarget = undefined;
      self.owner stoplocalsound("recon_drone_marking_owner");
      ref_131B7(self.owner, 1, self);
      return;
    }

    var_6 -= 0.05;
    wait 0.05;
  }

  if(isDefined(var_0.ref_12A99)) {
    [[var_0.ref_12A99]](var_4, var_0);
  }

  var_5.reconmarked = 1;
  self.markingtarget = undefined;
  markent(var_5, undefined);
  self.owner playlocalsound("recon_drone_marked_owner");
  self.owner stoplocalsound("recon_drone_marking_owner");
  ref_131B7(self.owner, 4, self);
  ref_131C9(self.targetmarkergroup, var_0, 2);
  addmarkpoints(var_0, var_1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("reconDroneMarks", 1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "combatRecordSuperMisc")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "combatRecordSuperMisc")]]("super_recon_drone");
  }

  self.usedcount++;
  var_7 = 5;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_improved_target_mark")) {
      var_7 += 2;
    }
  }

  thread waituntilunmarked(var_5, var_7);
}

function addmarkpoints(var_0, var_1) {
  if(!isDefined(self.markedentitieslifeindicices)) {
    self.markedentitieslifeindicices = [];
  }

  var_2 = var_0 getentitynumber();
  var_3 = scripts\engine\utility::ter_op(isDefined(self.matchdatalifeindex), self.matchdatalifeindex, 0);

  if(!isDefined(self.markedentitieslifeindicices[var_2]) || self.markedentitieslifeindicices[var_2] > var_3) {
    self.markedentitieslifeindicices[var_2] = var_3;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
      self.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]](self.helperdronetype + "_" + var_1 + "_marked");
      return;
    }

    return;
  }
}

function waituntilunmarked(var_0, var_1) {
  level endon("game_ended");
  var_2 = var_0.target;
  var_2 endon(var_0.notifytoendmark);
  waituntilunmarkedinternal(var_0, var_1);
  unmark(var_0);
}

function waituntilunmarkedinternal(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("disconnect");
  var_3 = var_0.target;
  var_3 endon("death");

  for(var_4 = gettime(); var_1 * 1000 + var_4 >= gettime(); var_4 = gettime()) {
    wait 0.05;

    if(isDefined(self) && isDefined(self.owner) && helperdrone_istargetinreticle(self.owner, var_3, 70, 40) && isinmarkingrange(var_3) && canseetarget(var_3)) {}
  }
}

function resetreticlemarkingprogressstate(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var_1 = self.owner;
  var_1 endon("disconnect");
  var_1 endon("marking_target");
  wait var_0;
  ref_131B7(self.owner, 1, self);
}

function islocationmarked(var_0) {
  return istrue(var_0.locationmarked);
}

function isinouterradius(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_0.targetsinouterradius, var_1);
}

function isbeingmarked(var_0) {
  if(!isDefined(self.enemiesmarked)) {
    return false;
  }

  var_1 = self.enemiesmarked[var_0 getentitynumber()];

  if(!isDefined(var_1)) {
    return false;
  }

  return isDefined(var_1.beingmarked);
}

function isreconmarked(var_0) {
  if(!isDefined(self.enemiesmarked)) {
    return false;
  }

  var_1 = self.enemiesmarked[var_0 getentitynumber()];

  if(!isDefined(var_1)) {
    return false;
  }

  return istrue(var_1.reconmarked);
}

function isinmarkingrange(var_0) {
  var_1 = level.helperdronesettings[self.helperdronetype];
  var_2 = scripts\cp_mp\utility\game_utility::islargemap();
  var_3 = scripts\engine\utility::ter_op(var_2, var_1.ref_11B18, var_1.ref_11B17);

  if(isDefined(var_0.ref_11B08)) {
    var_3 = var_0.ref_11B08;
  }

  var_4 = var_0.origin;

  if(isPlayer(var_0)) {
    var_4 = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      var_4 = var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceCenter")]]();
    }
  }

  return distancesquared(self.origin, var_4) < var_3;
}

function isindetectrange(var_0) {
  return distancesquared(self.origin, var_0.origin) < 25000000;
}

function getmarkingdelay(var_0) {
  return 0.3;
}

function marklocation(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.target = var_0;
  var_4.targetnum = var_0 getentitynumber();
  var_4.outlineid = undefined;
  var_4.headicon = undefined;
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

      var_6 = var_8;
    }
  } else {
    var_6 = self.owner;
  }

  if(!isDefined(var_6)) {
    return;
  }

  if(isarray(var_6) && var_6.size == 0) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_10 = 0;
    var_11 = 5000;
    var_12 = 500;
  } else {
    var_10 = 1;
    var_11 = 5000;
    var_12 = 500;
  }

  if(true) {
    var_10.headicon = var_11 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_12, "icon_navbar_enemy", 15, var_10, var_11, var_12, undefined, 1, 1);
  }

  thread marklocation_watchmarkentstatus(var_10, var_11, var_6);
}

function earlyremoveradarperk(var_0) {
  self endon("disconnect");
  waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]](var_0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]](var_0);
        return;
      }

      return;
    }

    return;
  }
}

function marklocation_watchmarkentstatus(var_0, var_1, var_2) {
  level endon("game_ended");
  scripts\engine\utility::ref_143BA(var_2, "death", "explode");

  if(isDefined(var_0.icon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_0.icon);

    if(isDefined(var_1)) {
      var_1 delete();
    }
  }

  if(isDefined(var_0.target)) {
    var_0.target.locationmarked = undefined;
  }

  self.enemiesmarked[var_0.targetnum] = undefined;
}

function markent(var_0, var_1) {
  var_2 = var_0.target;
  self.enemiesmarked[var_0.targetnum] = var_0;
  var_3 = "hud_icon_head_marked";
  var_4 = 8;

  if(isPlayer(var_2)) {
    if(false) {
      if(level.teambased) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam")) {
          var_0.outlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](var_2, "orange", self.owner.team, 0, 1, 0, "killstreak");
        }
      } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForPlayer")) {
        var_0.outlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForPlayer")]](var_2, "orange", self.owner, 0, 1, 0, "killstreak");
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "hudOutlineViewmodelEnable")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "hudOutlineViewmodelEnable")]](5, 0, 1);
      }
    }

    thread markflash();
    markeduion(var_2);
    var_2 playlocalsound("recon_drone_spotted_plr");
  } else {
    var_5 = markent_getweaponicon(var_3, var_4, var_2);
    var_3 = var_5.weaponicon;
    var_4 = var_5.weaponoffset;
  }

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_6 = 0;
    var_7 = 4000;
    var_8 = 500;
  } else {
    var_6 = 1;
    var_7 = 4000;
    var_8 = 500;
  }

  if(true) {
    var_3.headicon = var_6 scripts\cp_mp\entityheadicons::setheadicon_singleimage([], var_7, var_8, var_6, var_7, var_8, undefined, 1, 1);
    markupdateheadiconallplayers(var_3);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "watchMarkingEntStatus")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "watchMarkingEntStatus")]](var_3);
  }

  thread resetreticlemarkingprogressstate(getmarkingdelay(var_3.target));
}

function ref_131B7(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1)) {
    var_2 = var_1.helperdronetype == "assault_drone";
  }

  if(var_0 > 0 && var_2) {
    var_0 += 4;
  }

  self setclientomnvar("ui_rcd_controls", var_0);
  self notify("omnvar_ui_rcd_changed", var_0);
}

function ref_131C9(var_0, var_1, var_2) {
  var_3 = (var_2 >> 0) % 2 == 1;
  var_4 = (var_2 >> 1) % 2 == 1;
  targetmarkergroupsetextrastate(var_0, var_1, var_3);
  addclienttotargetmarkergroupmask(var_0, var_1, var_4);
}

function markflash() {
  self endon("death_or_disconnect");

  if(!istrue(self.iszombie)) {
    self visionsetnakedforplayer("recon_drone_flash", 0.05);
    wait 0.08;
    scripts\mp\utility\player::restorebasevisionset(1.2);
    return;
  }
}

function markeduion() {
  if(!isDefined(self.markedomnvar)) {
    self.markedomnvar = 1;
    self setclientomnvar("ui_rcd_target_notify", self.markedomnvar);
    thread watchmarkedui();
    return;
  }

  if(self.markedomnvar == 1) {
    self.markedomnvar = 2;
  } else {
    self.markedomnvar = 1;
  }

  self setclientomnvar("ui_rcd_target_notify", self.markedomnvar);
}

function watchmarkedui() {
  self endon("disconnect");
  self notify("markedUIUpdate");
  self endon("markedUIUpdate");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "get_mark_ui_duration")) {
    wait self[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "get_mark_ui_duration")]]();
  } else {
    wait 3;
  }

  thread markeduioff();
}

function markeduioff() {
  self notify("markedUIUpdate");
  self.markedomnvar = undefined;
  self setclientomnvar("ui_rcd_target_notify", 0);
}

function markent_getweaponicon(var_0, var_1, var_2) {
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

      var_3 = var_7.image;
    }
  } else if(isDefined(var_2.streakinfo)) {
    var_8 = var_2.streakinfo.streakname;
    var_3 = game["killstreakTable"].tabledatabyref[var_8]["overheadIcon"];
    var_4 = 75;
  }

  var_5.weaponicon = var_3;
  var_5.weaponoffset = var_4;
  return var_5;
}

function markupdateheadiconallplayers(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2)) {
      return;
    }

    markupdateheadicon(var_0, var_2);
  }
}

function markupdateheadicon(var_0, var_1) {
  var_2 = scripts\mp\utility\player::isfriendly(var_0.ownerteam, var_1);
  var_3 = isDefined(var_0.markingent) && isDefined(var_0.markingent.owner) && var_1 == var_0.markingent.owner;
  var_4 = isDefined(var_0.markingent) && istrue(var_0.markingent.ispiloted);
  var_5 = var_3 && var_4;

  if(isDefined(var_0.headicon)) {
    if(var_2 && !var_5) {
      scripts\cp_mp\entityheadicons::ref_1315D(var_0.headicon, var_1);
      return;
    }

    scripts\cp_mp\entityheadicons::ref_1315E(var_0.headicon, var_1);
    return;
  }
}

function unmark(var_0) {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_0.headicon);

  if(isDefined(var_0.target)) {
    var_0.reconmarked = undefined;
    var_0.beingmarked = undefined;

    if(isDefined(self)) {
      self.enemiesmarked[var_0.targetnum] = undefined;
    }

    if(isPlayer(var_0.target) && false) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_0.outlineid, var_0.target);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "hudOutlineViewmodelDisable")) {
        var_0.target[[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "hudOutlineViewmodelDisable")]]();
      }
    }

    var_0.target notify(var_0.notifytoendmark);
    return;
  }

  if(isDefined(self)) {
    self.enemiesmarked[var_0.targetnum] = undefined;
    return;
  }
}

function helperdrone_watchforgoal() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("death_or_disconnect");
  self endon("owner_gone");
  self notify("helperDrone_watchForGoal");
  self endon("helperDrone_watchForGoal");
  var_0 = scripts\engine\utility::ref_143AE("goal", "near_goal", "hit_goal");
  self.intransit = 0;
  self.inactive = 0;
  self notify("hit_goal");
}

function helperdrone_watchdamage() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("disconnect");
  self endon("owner_gone");
  self.health = 2147483647;
  var_0 = self.maxhealth;
  var_1 = level.helperdronesettings[self.helperdronetype];

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

    var_0 -= var_2;

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

        if(isDefined(var_11)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
            var_20 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](self.helperdronetype, var_3, var_11, var_18, var_16, var_1.scorepop, var_1.vodestroyed, var_1.destroyedsplash, var_19);
          }
        }

        thread helperdroneexplode(1);
      }
    }

    if(var_0 <= int(self.maxhealth / 1.2) && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("body_damage_light", "on");
      continue;
    }

    if(var_0 <= int(self.maxhealth / 2) && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("body_damage_medium", "on");
      continue;
    }

    if(var_0 <= int(self.maxhealth / 3) && self.currentdamagestate == 2) {
      self.currentdamagestate = 3;
      self setscriptablepartstate("body_damage_heavy", "on");
    }
  }
}

function helperdrone_watchtimeout() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("disconnect");
  self endon("owner_gone");
  var_0 = level.helperdronesettings[self.helperdronetype];
  self.timeout = var_0.timeout;

  if(!isDefined(self.timeout)) {
    return;
  }

  if(self.timeout > 0) {
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.timeout * 1000));
    wait self.timeout;
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(var_0.votimedout, 1);
  thread helperdrone_leave();
}

function helperdrone_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  GscBinSkip4(0x35, "disconnect");
}

function helperdrone_watchownerstatus(var_0) {
  self.owner waittill(var_0);
  self notify("owner_gone");
  thread helperdrone_leave();
}

function helperdrone_watchownerdeath() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");

  for(;;) {
    self.owner waittill("death");
    var_0 = level.helperdronesettings[self.helperdronetype];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGametypeNumLives")) {
      if(istrue(var_0.diewithowner) || [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGametypeNumLives")]]() && self.owner.pers["deaths"] == [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGametypeNumLives")]]()) {
        thread helperdrone_leave();
      }
    }
  }
}

function helperdrone_watchroundend() {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("disconnect");
  self endon("owner_gone");
  level scripts\engine\utility::ref_143A6("round_end_finished", "game_ended", "prematch_cleanup");
  thread helperdrone_leave();
}

function helperdrone_leave() {
  self endon("death");
  self endon("explode");

  if(self.helperdronetype == "radar_drone_overwatch") {
    self clearlookatent();
    self setmaxpitchroll(0, 0);
    self notify("leaving");
    self vehicle_setspeed(50, 25);
    var_0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
    var_0 += (0, 0, 1000);
    self setvehgoalpos(var_0, 1);
    self setneargoalnotifydist(100);
    self waittill("near_goal");
    var_1 = helperdrone_getpathend();
    self vehicle_setspeed(150, 50);
    self setvehgoalpos(var_1, 1);
    self waittill("goal");
    self notify("gone");
    removehelperdrone(self.helperdronetype, level.helperdronesettings[self.helperdronetype], 0);
    return;
  }

  thread helperdroneexplode(0);
}

function helperdrone_getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

function perkengineer_manageminimap() {
  var_0 = "icon_minimap_scramblerdrone";
  self.enemyobjid = scripts\mp\objidpoolmanager::createobjective_engineer(var_0, 1, 1);

  foreach(var_2 in level.players) {
    if(!isPlayer(var_2)) {
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_engineer") && var_2.team != self.team) {
        if(self.enemyobjid != -1) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.enemyobjid, var_2);
        }
      }
    }
  }
}

function helperdrone_modifydamageresponse(var_0) {
  helperdrone_modifydamagestates(var_0);
  var_1 = var_0.meansofdeath;
  var_2 = var_0.damage;

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::isusingremote()) {
    if(isexplosivedamagemod(var_1)) {
      if(ceil(var_2 / self.maxhealth) >= 0.4) {
        earthquake(0.25, 0.2, self.origin, 150);
        self.owner playRumbleOnEntity("damage_heavy");
      } else {
        earthquake(0.15, 0.15, self.origin, 150);
        self.owner playRumbleOnEntity("damage_light");
      }
    }
  }

  return true;
}

function helperdrone_modifydamagestates(var_0) {
  var_1 = var_0.damage;
  self.currenthealth = self.health - var_1;

  if(self.currenthealth <= int(self.maxhealth / 1.2) && self.currentdamagestate == 0) {
    self.currentdamagestate = 1;
    self setscriptablepartstate("body_damage_light", "on");
  } else if(self.currenthealth <= int(self.maxhealth / 2) && self.currentdamagestate == 1) {
    self.currentdamagestate = 2;
    self setscriptablepartstate("body_damage_medium", "on");
  } else if(self.currenthealth <= int(self.maxhealth / 3) && self.currentdamagestate == 2) {
    self.currentdamagestate = 3;
    self setscriptablepartstate("body_damage_heavy", "on");
  }

  self.owner setclientomnvar("ui_killstreak_health", self.currenthealth / self.maxhealth);
  return true;
}

function helperdrone_stunned(var_0) {
  self notify("helperDrone_stunned");
  self endon("helperDrone_stunned");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self.owner endon("disconnect");
  level endon("game_ended");

  if(istrue(self.attackingtarget)) {
    self notify("disengage_target");
  }

  self.stunned = 1;

  if(isDefined(level.helperdronesettings[self.helperdronetype].fxid_sparks)) {
    playFXOnTag(level.helperdronesettings[self.helperdronetype].fxid_sparks, self, "tag_origin");
  }

  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  stopFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  self.stunned = 0;
}

function helperdronedestroyed(var_0) {
  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return;
  }

  thread helperdroneexplode(1);
  return 0;
}

function helperdroneexplode(var_0, var_1) {
  self.isdestroyed = 1;
  var_2 = level.helperdronesettings[self.helperdronetype];
  helperdrone_endscramblereffect();

  if(isDefined(self.minimapid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.minimapid);
    self.minimapid = undefined;
  }

  if(isDefined(self.helperdronetype) && (self.helperdronetype == "radar_drone_recon" || self.helperdronetype == "assault_drone")) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "clearOOB")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "clearOOB")]](self, 1);
    }

    helperdrone_returnplayer(self.owner);
  }

  if(istrue(var_1)) {
    if(isDefined(self.owner)) {
      self.owner playlocalsound("weap_c4detpack_trigger_plr");
    }

    spawn_ai_solo();
  } else {
    spawn_aitype();
  }

  scripts\cp_mp\emp_debuff::allow_emp(0);
  self notify("explode");

  if(isDefined(self.streakinfo.superid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_recon_drone", self.usedcount);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "fieldUpgradeExpired")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self.streakinfo.superid, self.usedcount, istrue(var_0));
    }
  }

  waitframe();
  var_3 = self.owner;
  removehelperdrone(self.helperdronetype, level.helperdronesettings[self.helperdronetype], var_0);

  if(level.gametype != "br" && isDefined(var_3) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "superSlotCleanUp")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "superSlotCleanUp")]](var_3);
    return;
  }
}

function spawn_aitype() {
  var_0 = level.helperdronesettings[self.helperdronetype];

  if(isDefined(var_0.fxid_explode)) {
    playFX(var_0.fxid_explode, self.origin);
  }

  if(isDefined(var_0.sound_explode)) {
    self playSound(var_0.sound_explode);
    return;
  }
}

function spawn_ai_solo() {
  var_0 = level.helperdronesettings[self.helperdronetype];
  self setscriptablepartstate("explode", "detonate");
  var_1 = scripts\common\utility::playersinsphere(self.origin, 2000);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(self.owner) && var_3 == self.owner) {
      continue;
    }

    var_3 earthquakeforplayer(0.3, 2, var_3.origin, 100);
    var_3 setclientomnvar("ui_hud_shake", 1);
    var_3 playrumbleonpositionforclient("artillery_rumble_light", var_3.origin);
  }

  if(isDefined(self.owner)) {
    self.owner earthquakeforplayer(0.2, 2, self.owner.origin, 100);
    self.owner setclientomnvar("ui_hud_shake", 1);
    self.owner playrumbleonpositionforclient("artillery_rumble_light", self.owner.origin);
    return;
  }
}

function removehelperdrone(var_0, var_1, var_2) {
  helperdrone_disableradar();

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  if(isDefined(self.playersfx)) {
    self.playersfx delete();
  }

  if(isDefined(self.scrambler)) {
    self.scrambler delete();
  }

  if(isDefined(self.enemyobjid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.enemyobjid);
  }

  if(isDefined(self.pulsedarts) && self.pulsedarts.size > 0) {
    foreach(var_4 in self.pulsedarts) {
      var_4 notify("death");
    }
  }

  if(!istrue(self.streakinfo.issuper)) {
    if(isDefined(level.killstreakfinishusefunc)) {
      level thread[[level.killstreakfinishusefunc]](self.streakinfo);
    }
  }

  if(isDefined(self.owner)) {
    if(isDefined(self.owner.helperdrone)) {
      self.owner.helperdrone = undefined;
    }

    self.owner clearsoundsubmix("mp_recon_drone", 1);
    self.owner notify("eng_drone_update", -1);

    if(var_0 == "radar_drone_escort" || var_0 == "radar_drone_overwatch") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap")) {
        self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
      }
    }

    self.streakinfo.onspray = istrue(var_2);
    self.owner scripts\cp_mp\utility\killstreak_utility::ref_12AA7(self.streakinfo);
  }

  if(var_0 == "scrambler_drone_guard") {
    scramblerdrone_counteruavmodeoff();
  }

  if(istrue(self.nonvehicle)) {
    self delete();
  } else {
    scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
    self.owner setclientomnvar("ui_killstreak_countdown", 0);
    return;
  }
}

function helperdrone_returnplayer(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = self.helperdronetype;
  var_2 = level.helperdronesettings[var_1];

  if(isDefined(self.targetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.targetmarkergroup);
    self.targetmarkergroup = undefined;
  }

  self.ispiloted = undefined;

  if(isDefined(self.enemiesmarked)) {
    foreach(var_4 in self.enemiesmarked) {
      markupdateheadicon(var_4, var_0);
    }
  }

  thread recondrone_takedeployweapon(var_0, !isalive(var_0));
  helperdrone_takeplayerfauxremote(var_0, self.streakinfo);
  var_0 painvisionon();
  var_0 scripts\common\utility::allow_usability(1);
  var_0 scripts\common\utility::allow_fire(1);
  thread soundorg_int();
  var_0 cameraunlink(self);
  var_0 remotecontrolvehicleoff();
  scripts\cp_mp\utility\killstreak_utility::ref_11DC1(var_0);

  if(isDefined(var_0.restoreangles)) {
    var_0 setplayerangles((var_0.restoreangles[0], var_0.restoreangles[1], 0));
    var_0.restoreangles = undefined;
  }

  var_0 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
}

function soundorg_int() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = gettime();
  var_1 = 1000;

  while(gettime() - var_0 < var_1) {
    ref_131B7(0);
    waitframe();
  }
}

function exceededmaxhelperdrones(var_0, var_1) {
  if(!isDefined(level.supportdrones)) {
    return false;
  }

  if(level.incominghelperdrones.size > 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
      if(level.incominghelperdrones.size >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
        return true;
      }
    }

    foreach(var_3 in level.incominghelperdrones) {
      if(isDefined(var_3.owner) && var_3.owner == var_1) {
        continue;
      }

      if(var_0.streakname == "radar_drone_recon" && var_3.type == var_0.streakname) {
        if(level.teambased) {
          if(isDefined(var_3.owner) && isDefined(var_3.owner.team) && var_3.owner.team == var_1.team) {
            return true;
          }
        }

        continue;
      }

      if(var_0.streakname == "assault_drone" && var_3.type == var_0.streakname) {
        if(level.teambased) {
          if(isDefined(var_3.owner) && isDefined(var_3.owner.team) && var_3.owner.team == var_1.team) {
            return true;
          }
        }

        continue;
      }

      if(var_0.streakname == "radar_drone_overwatch" && var_3.type == var_0.streakname) {
        if(level.teambased) {
          if(helperdrone_getnumdrones("radar_drone_overwatch", level.incominghelperdrones, var_1.team) >= 10) {
            return true;
          }
        }

        if(helperdrone_getnumdrones("radar_drone_overwatch", level.incominghelperdrones) >= 20) {
          return true;
        }

        continue;
      }

      if(var_0.streakname == "scrambler_drone_guard" && var_3.type == var_0.streakname) {
        if(level.teambased) {
          if(helperdrone_getnumdrones("scrambler_drone_guard", level.incominghelperdrones, var_1.team) >= 10) {
            return true;
          }
        }
      }
    }
  }

  if(level.supportdrones.size > 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
      if(level.supportdrones.size >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
        return true;
      }
    }

    foreach(var_3 in level.supportdrones) {
      if(var_0.streakname == "radar_drone_escort" && var_3.helperdronetype == var_0.streakname) {
        if(isDefined(var_3.owner) && var_3.owner == var_1) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/COMPANION_ALREADY_EXISTS");
          }

          return true;
        }

        continue;
      }

      if(var_0.streakname == "radar_drone_recon" && var_3.helperdronetype == var_0.streakname) {
        if(level.teambased) {
          if(var_3.team == var_1.team) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
              var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
            }

            return true;
          }
        }

        continue;
      }

      if(var_0.streakname == "assault_drone" && var_3.helperdronetype == var_0.streakname) {
        if(level.teambased) {
          if(var_3.team == var_1.team) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
              var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
            }

            return true;
          }
        }

        continue;
      }

      if(var_0.streakname == "radar_drone_overwatch" && var_3.helperdronetype == var_0.streakname) {
        if(helperdrone_getnumdrones("radar_drone_overwatch", level.supportdrones) >= 20) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
          }

          return true;
        }

        if(level.teambased) {
          if(helperdrone_getnumdrones("radar_drone_overwatch", level.supportdrones, var_1.team) >= 10) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
              var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_PERSONAL_RADAR");
            }

            return true;
          }
        }

        if(helperdrone_getnumdrones("radar_drone_overwatch", level.supportdrones, var_1) >= 1) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/PERSONAL_RADAR_ALREADY_ACTIVE");
          }

          return true;
        }

        continue;
      }

      if(var_0.streakname == "scrambler_drone_guard" && var_3.helperdronetype == var_0.streakname) {
        if(level.teambased) {
          if(helperdrone_getnumdrones("scrambler_drone_guard", level.supportdrones, var_1.team) >= 10) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
              var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_COUNTER_UAV");
            }

            return true;
          }

          continue;
        }

        if(helperdrone_getnumdrones("scrambler_drone_guard", level.supportdrones, var_1) >= 2) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_COUNTER_UAV");
          }

          return true;
        }
      }
    }
  }

  return false;
}

function helperdrone_getnumdrones(var_0, var_1, var_2) {
  var_3 = 0;

  foreach(var_5 in var_1) {
    if(isDefined(var_5.type) && var_5.type == var_0 || isDefined(var_5.helperdronetype) && var_5.helperdronetype == var_0) {
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

function helperdrone_destroyongameend() {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  level scripts\engine\utility::ref_143A6("bro_shot_start", "game_ended", "ending_sequence");
  helperdronedestroyed();
}

function spawn_ai_and_seat_in_vehicle(var_0) {
  self endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  var_1 = getdvarfloat("br_recon_altitude_envelope", 1500);
  var_2 = getdvarfloat("br_recon_altitude_warn", 5600);
  var_3 = var_1 + var_2;
  var_4 = 0;
  var_5 = 0;

  for(;;) {
    if(self.origin[2] > var_2) {
      if(self.origin[2] > var_3) {
        var_0 setclientomnvar("ui_out_of_range", 0);
        helperdronedestroyed();
      }

      var_4 = (self.origin[2] - var_2) / var_1;
    } else {
      var_4 = 0;
    }

    if(var_4 != var_5) {
      var_5 = var_4;
      var_0 setclientomnvar("ui_out_of_range", var_4);
    }

    waitframe();
  }
}

function helperdrone_gettargetoffset(var_0, var_1) {
  var_2 = level.helperdronesettings[var_0.helperdronetype];
  var_3 = var_2.backoffset;
  var_4 = var_2.sideoffset;
  var_5 = helperdrone_getheightoffset(var_0, var_2);

  if(isDefined(var_0.low_entry)) {
    var_5 *= var_0.low_entry;
  }

  var_6 = (var_4, var_3, var_5);
  return var_6;
}

function helperdrone_istargetinreticle(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = var_0.origin;

  if(isDefined(var_0.ref_12A9C)) {
    var_4 += var_0.ref_12A9C;
  }

  var_5 = [var_4];

  if(isPlayer(var_0)) {
    var_6 = var_0 scripts\mp\utility\player::round_smoke_logic();
    var_7 = var_0 scripts\mp\utility\player::getstancecenter();
    var_5 = [var_6, var_7, var_4];
  } else if(isagent(var_0)) {
    var_5 = [var_4 + (0, 0, 1)];
  }

  foreach(var_9 in var_5) {
    if(self worldpointinreticle_circle(var_9, var_1, var_2)) {
      var_3 = 1;
      break;
    }
  }

  return var_3;
}

function find_safe_spawn(var_0) {
  var_1 = self.angles;
  var_2 = (0, 0, 80);
  var_3 = level.helperdronesettings[var_0].spawndist;
  var_4 = (0, 0, var_2[2]);
  var_5 = level.helperdronesettings[var_0].halfsize;
  var_6 = anglesToForward(self.angles);
  var_7 = anglestoright(self.angles);
  var_8 = self.origin + (0, 0, 30);
  var_9 = var_3 + 20;

  if(self getstance() == "prone") {
    var_9 += 25;
  }

  if(_calloutmarkerping_handleluinotify_enemyrepinged::ref_124F5()) {
    var_4 += (0, 0, 130);
  }

  var_10 = [var_4 + var_3 * var_6, var_4 - var_3 * var_6, var_4 + var_3 * var_7, var_4 - var_3 * var_7, var_4, var_4 + 0.707 * var_3 * (var_6 + var_7), var_4 + 0.707 * var_3 * (var_6 - var_7), var_4 + 0.707 * var_3 * (var_7 - var_6), var_4 + 0.707 * var_3 * (-1 * var_6 - var_7), var_9 * var_6, -1 * var_9 * var_6, var_9 * var_7, -1 * var_9 * var_7, (0, 0, 0), 0.707 * var_9 * (var_6 + var_7), 0.707 * var_9 * (var_6 - var_7), 0.707 * var_9 * (var_7 - var_6), 0.707 * var_9 * (-1 * var_6 - var_7)];
  var_11 = 0;

  for(var_12 = 0; var_12 < var_10.size; var_12++) {
    if(4 <= var_11) {
      var_11 = 0;
      wait 0.05;
    }

    var_13 = var_10[var_12];
    var_14 = var_8 + var_13;
    var_15 = vectorNormalize(var_13) * 50;
    var_16 = var_8 + var_15;
    var_17 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var_18 = scripts\engine\trace::ray_trace(var_8, var_16, self, var_17);

    if(var_18["hittype"] != "hittype_none") {
      continue;
    }

    var_19 = scripts\engine\trace::sphere_trace(var_16, var_14, var_5, self, var_17);
    var_20 = var_19["fraction"];
    var_21 = var_20 * (var_14 - var_16);
    var_22 = var_16 + var_21;

    if(var_20 > 0) {
      self.recondronesafespawn = var_22;
      return var_22;
    }

    var_11++;
  }

  return undefined;
}

function helperdrone_giveplayerfauxremote(var_0) {
  self endon("disconnect ");
  scripts\cp_mp\utility\player_utility::setusingremote(var_0.streakname);
  scripts\common\utility::allow_weapon_switch(0);
}

function helperdrone_takeplayerfauxremote(var_0) {
  scripts\cp_mp\utility\player_utility::clearusingremote(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_offhand_weapons(1);
  var_0 notify("killstreak_finished_with_deploy_weapon");
  var_1 = getcompleteweaponname("ks_remote_drone_mp");

  if(self hasweapon(var_1)) {
    thread scripts\cp_mp\utility\inventory_utility::getridofweapon(var_1);
    return;
  }
}

function helperdrone_showminimaponspawn(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("explode");
  var_0 endon("leaving");
  level endon("game_ended");
  var_1 = self.guid;
  level notify("helperDrone_show_minimap_" + var_1);
  level endon("helperDrone_show_minimap_" + var_1);

  if(istrue(level.istacops)) {
    return;
  }

  for(;;) {
    self waittill("spawned_player");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
    }

    self.showuavminimaponspawn = 1;
  }
}

function recondrone_beginsuper() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  var_0 = spawnStruct();
  var_0.streakname = "radar_drone_recon";
  var_0.weaponname = "ks_remote_drone_mp";
  var_0.issuper = 1;
  var_0.superid = level.superglobals.staticsuperdata["super_recon_drone"].id;

  if(!tryusehelperdroneearlyout(var_0, 1)) {
    self.recondronereserved = 1;
    thread recondrone_watchcleanupreserved(var_0, 0);

    if(scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
      self.reconvehiclereserved = 1;
      thread recondrone_watchcleanupreserved(var_0, 1);

      if(recondrone_givedeployweapon()) {
        thread recondrone_watchsuper(var_0);
        return true;
      } else {
        thread recondrone_takedeployweapon(undefined, 1);
        thread recondrone_cleanupreserved(var_0, 1);
      }
    } else {
      thread recondrone_cleanupreserved(var_0, 0);
    }
  }

  return false;
}

function recondrone_endsuper(var_0) {
  self notify("reconDroneEnded");
  self.recondronesafespawn = undefined;

  if(isDefined(self.recondronerefund)) {
    self.recondronerefund = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "getSuperPointsNeeded")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]]([[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "getSuperPointsNeeded")]]());
    }
  }

  if(isDefined(self.recondronereserved)) {
    self.recondronereserved = undefined;
    var_1 = spawnStruct();
    var_1.streakname = "radar_drone_recon";
    recondrone_cleanupreserved(var_1);
  }

  if(isDefined(self.reconvehiclereserved)) {
    self.reconvehiclereserved = undefined;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return;
  }
}

function recondrone_watchsuper(var_0) {
  self endon("disconnect");
  var_1 = ref_12A98(var_0);

  if(!isDefined(var_1)) {
    thread recondrone_takedeployweapon(!isalive(self), 1);
    return;
  }

  if(!var_1) {
    thread recondrone_takedeployweapon(!isalive(self), 1);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
      return;
    }

    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](0);
    return;
  }
}

function ref_12A98(var_0) {
  self endon("death");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  thread recondrone_watchsuperendfromswitch();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helperDrone", "onReconDroneSuperStarted")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("helperDrone", "onReconDroneSuperStarted")]]();
  }

  thread recondrone_disablecontrols(2.15);
  wait 1.85;
  GscBinSkip4(0x35, var_0.streakname);
}

function recondrone_disablecontrols(var_0) {
  self endon("death_or_disconnect");

  if(istrue(level.mine_caves_turrets)) {
    self freezecontrols(1);
  } else {
    scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "reconDrone");
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(istrue(level.mine_caves_turrets)) {
    self freezecontrols(0);
    return;
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "reconDrone");
}

function recondrone_watchsuperendfromswitch() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  self endon("reconDrone_watchSuperEndFromSwitch");
  var_0 = getcompleteweaponname("ks_remote_drone_mp");

  for(;;) {
    if(self getcurrentweapon() != var_0) {
      break;
    }

    waitframe();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
    return;
  }
}

function recondrone_unsetsuper(var_0) {
  self notify("reconDroneUnset");

  if(false) {
    var_1 = self.recondronesuper;

    if(isDefined(var_1)) {
      if(!istrue(var_1.isdestroyed)) {
        helperdronedestroyed(var_1);
      }
    }
  }

  thread recondrone_endsuper(var_0);
}

function recondrone_givedeployweapon() {
  self endon("death_or_disconnect");
  self endon("reconDroneWeaponTaken");
  self notify("reconDroneWeaponGiven");
  self endon("reconDroneWeaponGiven");
  var_0 = getcompleteweaponname("ks_remote_drone_mp");

  if(!self hasweapon(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  }

  recondrone_allowcontrols(0);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1);
  return var_1;
}

function recondrone_takedeployweapon(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("reconDroneWeaponGiven");
  self notify("reconDroneWeaponTaken");
  self endon("reconDroneWeaponTaken");
  var_2 = getcompleteweaponname("ks_remote_drone_mp");

  if(istrue(var_1)) {
    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_2)) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_2);
      return;
    }
  }

  recondrone_allowcontrols(1, var_0);

  if(istrue(var_1)) {
    scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);
    return;
  }
}

function recondrone_allowcontrols(var_0, var_1) {
  var_1 = istrue(var_1);

  if(var_0) {
    if(!isDefined(self.recondronefrozecontrols)) {
      return;
    }

    if(!var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "allow_equipment")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "allow_equipment")]](var_0);
      }

      scripts\common\utility::allow_usability(var_0);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "allowGesture")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "allowGesture")]](var_0);
      }
    }

    self.recondronefrozecontrols = undefined;
    return;
  }

  if(isDefined(self.recondronefrozecontrols)) {
    return;
  }

  if(!var_1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "allow_equipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "allow_equipment")]](var_0);
    }

    scripts\common\utility::allow_usability(var_0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "allowGesture")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "allowGesture")]](var_0);
    }
  }

  self.recondronefrozecontrols = 1;
}

function recondrone_watchcleanupreserved(var_0, var_1) {
  self notify("reconDrone_cleanupReserved");
  self endon("reconDrone_cleanupReserved");
  self waittill("disconnect");
  thread recondrone_cleanupreserved(var_0, var_1);
}

function recondrone_cleanupreserved(var_0, var_1) {
  self notify("reconDrone_cleanupReserved");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]](1);
  }

  removeincominghelperdrone(var_0);

  if(istrue(var_1)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return;
  }
}

function recondrone_addtolists(var_0, var_1) {
  var_1.recondronesuper = var_0;
  var_1.pausesuperpointsovertime = 1;
  var_2 = var_0 getentitynumber();

  if(!isDefined(level.recondronesupers)) {
    level.recondronesupers = [];
  }

  level.recondronesupers[var_2] = var_0;
  thread recondrone_removefromlistsondeath(var_0, var_1, var_2);
}

function recondrone_removefromlists(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 notify("reconDrone_removeFromLists");
    var_2 = var_0 getentitynumber();
  }

  if(isDefined(var_1)) {
    var_1.recondronesuper = undefined;
    var_1.pausesuperpointsovertime = 0;
  }

  if(isDefined(level.recondronesupers)) {
    level.recondronesupers[var_2] = undefined;
    return;
  }
}

function recondrone_removefromlistsondeath(var_0, var_1, var_2) {
  var_0 endon("reconDrone_removeFromLists");
  var_0 waittill("death");
  thread recondrone_removefromlists(var_0, var_1, var_2);
}

function deliverydrone_delivertopoint(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  var_2 = spawnStruct();
  var_2.streakname = "ammo_drop";
  var_2.issuper = 1;

  if(tryusehelperdroneearlyout(var_2, 1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    removeincominghelperdrone(var_2);
    return undefined;
  }

  var_3 = var_0 + (0, 0, 4000) - anglesToForward(self.angles) * 0;
  var_4 = createhelperdrone(var_3, self.angles, var_2.streakname, var_2);

  if(!isDefined(var_4)) {
    return undefined;
  }

  removeincominghelperdrone(var_2);
  var_4.deliverytarget = var_0;
  var_4.ondelivercallback = var_1;
  thread starthelperdrone(var_4);
  return var_4;
}

function scramblerdrone_counteruavmodeon() {
  scripts\cp_mp\killstreaks\uav::addactivecounteruav();
  level notify("uav_update");
}

function scramblerdrone_counteruavmodeoff() {
  scripts\cp_mp\killstreaks\uav::removeactivecounteruav();
  level notify("uav_update");
}

function monitoroutofboundsdistortion() {
  self.owner endon("disconnect");
  self endon("death");
  var_0 = 0;

  for(;;) {
    if(isDefined(level.outofboundstriggers)) {
      var_1 = 0;

      foreach(var_3 in level.outofboundstriggers) {
        if(!isDefined(var_3)) {
          continue;
        }

        if(var_3.classname == "trigger_radius") {
          continue;
        }

        if(self istouching(var_3)) {
          var_1 = 1;
          break;
        }
      }

      if(var_1) {
        var_0 += 1 * level.framedurationseconds;
      } else {
        var_0 -= 2 * level.framedurationseconds;
      }

      var_0 = clamp(var_0, 0, 0.5);
      self.owner setclientomnvar("ui_out_of_range", var_0);
    }

    waitframe();
  }
}

function istargetmarked() {
  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(var_1 in level.supportdrones) {
      if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, var_1.owner))) {
        if(isDefined(var_1.enemiesmarked) && isDefined(var_1.enemiesmarked[self getentitynumber()])) {
          return true;
        }
      }
    }
  }

  return false;
}

function unset_relic_noks() {
  if(isDefined(level.helperdronesettings)) {
    if(isDefined(self.streakinfo)) {
      return scripts\engine\utility::array_contains_key(level.helperdronesettings, self.streakinfo.streakname);
    }
  }

  return 0;
}