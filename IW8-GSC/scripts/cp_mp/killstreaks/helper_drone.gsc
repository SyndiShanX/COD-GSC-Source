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
  level.helperdronesettings["radar_drone_recon"].ref_11b06 = 1;
  level.helperdronesettings["radar_drone_recon"].ref_11b07 = 1;
  level.helperdronesettings["radar_drone_recon"].ref_11b17 = 3062500;
  level.helperdronesettings["radar_drone_recon"].ref_11b18 = 6250000;
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
  level.helperdronesettings["assault_drone"].ref_11b06 = 0;
  level.helperdronesettings["assault_drone"].ref_11b07 = 0;
  level.helperdronesettings["assault_drone"].ref_11b17 = 73984;
  level.helperdronesettings["assault_drone"].ref_11b18 = 73984;
  level.helperdronesettings["assault_drone"].leaderinteractionthink = 1;
  level.helperdronesettings["assault_drone"].leaderboarddata = undefined;
  level.helperdronesettings["assault_drone"].leaderplunderstring = 1;
  level.helperdronesettings["assault_drone"].ref_1217e = undefined;
  var0 = "br";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
  }

  if(var0 == "br" || var0 == "cp_survival") {
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

function weapongivenhelperdrone(var0) {
  var1 = var0.streakname;

  if(var1 == "scrambler_drone_guard" || var1 == "radar_drone_recon" || var1 == "assault_drone") {
    var2 = tryusehelperdroneearlyout(var0, 1);

    if(var2) {
      if(var1 == "scrambler_drone_guard") {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_COUNTER_UAV");
        }
      }

      return false;
    }

    if(var1 == "scrambler_drone_guard") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "startMapSelectSequence")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "startMapSelectSequence")]](0, 0, undefined, 1);
      }
    }
  }

  return true;
}

function addincominghelperdrone(var0) {
  level.incominghelperdrones[level.incominghelperdrones.size] = spawnStruct();
  level.incominghelperdrones[level.incominghelperdrones.size - 1].type = var0.streakname;
  level.incominghelperdrones[level.incominghelperdrones.size - 1].owner = self;
  level.incominghelperdrones[level.incominghelperdrones.size - 1].team = self.team;
}

function removeincominghelperdrone(var0) {
  if(level.incominghelperdrones.size == 0) {
    return;
  }

  var1 = [];

  foreach(var3 in level.incominghelperdrones) {
    if(var3.type == var0.streakname && var3.owner == self) {
      continue;
    }

    var1 = var3;
  }

  level.incominghelperdrones = var1;
}

function addincominghelperdroneifpossible(var0, var1) {
  addincominghelperdrone(var0);

  if(exceededmaxhelperdrones(var0, self)) {
    removeincominghelperdrone(var0);
    return false;
  }

  return true;
}

function incrementfauxvehiclecountifpossible(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + 1 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(istrue(var1)) {
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

function recondrone_equipment_wrapper(var0, var1, var2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var1);
  }

  var3 = tryusehelperdrone("radar_drone_recon");

  if(!var3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_recondrone", var1);
      return;
    }

    return;
  }
}

function scramblerdrone_equipment_wrapper(var0, var1, var2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var1);
  }

  var3 = tryusehelperdrone("scrambler_drone_guard");

  if(!var3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_scramblerdrone", var1);
      return;
    }

    return;
  }
}

function radardrone_equipment_wrapper(var0, var1, var2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](var1);
  }

  var3 = tryusehelperdrone("radar_drone_overwatch");

  if(!var3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_radardrone", var1);
      return;
    }

    return;
  }
}

function tryusehelperdrone(var0) {
  var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var0, self);
  return tryusehelperdronefromstruct(var1);
}

function tryusehelperdronefromstruct(var0) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return false;
    }
  }

  var1 = 0;

  if(var0.streakname == "scrambler_drone_guard") {
    var1 = 1;
  }

  if(!var1) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
      return false;
    }
  }

  var2 = level.helperdronesettings[var0.streakname].deployweaponname;
  var3 = getcompleteweaponname(var2);

  if(var2 == "ks_remote_map_mp") {
    var4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var0, var3, 1, &weapongivenhelperdrone);
  } else if(var3 == "ks_remote_drone_mp") {
    var4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var1, var4, 1, &weapongivenhelperdrone);
  } else if(var4 == "ks_assault_drone_mp") {
    var4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var2, var4, 1, &weapongivenhelperdrone);
  } else if(var4 == "ks_gesture_generic_mp") {
    var4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var3, var4);
  } else if(var4 == "ks_remote_device_mp") {
    var4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var4);
  } else {
    var4 = 0;
  }

  var5 = self.start_player_links;
  self.start_player_links = undefined;

  if(!istrue(var4)) {
    if(!var4) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    if(istrue(var5)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      }

      removeincominghelperdrone(var4);
    }

    return false;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1) && self hasweapon(var4)) {
    if(!var4) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    if(istrue(var5)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      }

      removeincominghelperdrone(var4);
    }

    if(var4 != "ks_gesture_generic_mp") {
      var4 notify("killstreak_finished_with_deploy_weapon");
    }

    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var4)) {
      if(!var4) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(istrue(var5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var4);
      }

      if(var4 != "ks_gesture_generic_mp") {
        var4 notify("killstreak_finished_with_deploy_weapon");
      }

      return false;
    }
  }

  var6 = var4.streakname;
  var7 = var6 == "scrambler_drone_guard" || var6 == "radar_drone_recon" || var6 == "assault_drone";

  if(!var7 || var4 == "ks_gesture_generic_mp") {
    var8 = tryusehelperdroneearlyout(var4, 1);

    if(var8) {
      if(!var4) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(istrue(var5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var4);
      }

      if(var4 != "ks_gesture_generic_mp") {
        var4 notify("killstreak_finished_with_deploy_weapon");
      }

      return false;
    }
  }

  var9 = find_safe_spawn(var6);

  if(var4 == "ks_remote_device_mp") {
    if(!isDefined(var9)) {
      if(!var4) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(istrue(var5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var4);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
      }

      var4 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  if(var4 == "ks_remote_drone_mp" || var4 == "ks_assault_drone_mp") {
    if(istrue(level.mine_caves_turrets)) {
      self freezecontrols(1);
    } else {
      scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "helperDroneKillstreakDeploy");
    }

    var10 = 0.6;
    var11 = 2;
    var12 = scripts\engine\utility::ref_143ba(var10, "death", "weapon_switch_started");

    if(!isDefined(var12) || var12 != "timeout") {
      if(!var4) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(istrue(var5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var4);
      }

      if(istrue(level.mine_caves_turrets)) {
        self freezecontrols(0);
      } else {
        scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "helperDroneKillstreakDeploy");
      }

      var4 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }

    scripts\common\utility::allow_weapon_switch(0);
    var12 = scripts\engine\utility::ref_143b9(var11 - var10, "death");

    if(!isDefined(var12) || var12 != "timeout") {
      if(!var4) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(istrue(var5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var4);
      }

      if(istrue(level.mine_caves_turrets)) {
        self freezecontrols(0);
      } else {
        scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "helperDroneKillstreakDeploy");
      }

      scripts\common\utility::allow_weapon_switch(1);
      var4 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }

    if(istrue(level.mine_caves_turrets)) {
      self freezecontrols(0);
    } else {
      scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "helperDroneKillstreakDeploy");
    }

    scripts\common\utility::allow_weapon_switch(1);
  }

  var13 = undefined;

  if(var4 == "ks_remote_map_mp") {
    var13 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getSelectMapPoint")) {
      var13 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getSelectMapPoint")]](var4, 1);
    }

    if(!isDefined(var13)) {
      if(!var4) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(istrue(var5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var4);
      }

      return false;
    }
  } else if(var6 == "scrambler_drone_guard") {
    var14 = self.origin;

    if(isDefined(level.ref_13c34)) {
      var15 = [[level.ref_13c34]](self.origin);
      var14 = var15["position"];
    }

    var16 = spawnStruct();
    var16.location = var14;
    var13 = [];
    var13 = var16;
  }

  var17 = self.angles;
  var18 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var4.streakname);
    var18 = 2;
  }

  if(level.gametype == "br") {
    if(var6 == "scrambler_drone_guard") {
      scripts\cp_mp\killstreaks\uav::ref_13ed5(self.team, 15000, "scrambler_drone_guard");
    }
  }

  if(isDefined(var13)) {
    if(var6 == "scrambler_drone_guard") {
      var19 = var13[0].location + (0, 0, 3000);
      var20 = createhelperdrone(var19, var17, var6, var4, var4, !var4);

      if(!isDefined(var20)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE");
        }

        if(istrue(var5)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
          }

          removeincominghelperdrone(var4);
        }

        return false;
      }

      var20.mappointinfo = var13;
      thread perkengineer_manageminimap();
      removeincominghelperdrone(var4);
      thread starthelperdrone(var20);
    }
  } else {
    if(var6 == "radar_drone_escort" || var6 == "radar_drone_recon" || var6 == "assault_drone") {
      var9 = find_safe_spawn(var6);
    }

    if(var6 == "radar_drone_overwatch") {
      var9 = self.origin + (0, 0, 1500) - anglesToForward(self.angles) * 5000;
    }

    var20 = createhelperdrone(var9, var17, var6, var4, var4, !var4);

    if(!isDefined(var20)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
      }

      helperdronecreationfailedfx(var6, var9);
      var4 notify("killstreak_finished_with_deploy_weapon");

      if(istrue(var5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
        }

        removeincominghelperdrone(var4);
      }

      return false;
    }

    if(var6 == "radar_drone_recon" || var6 == "assault_drone") {
      thread helperdrone_giveplayerfauxremote(var4);
    }

    removeincominghelperdrone(var4);
    thread starthelperdrone(var20);
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var4.streakname, 1, var18);
  var21 = level.helperdronesettings[var6].teamsplash;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var21, self);
  }

  return true;
}

function helperdronecreationfailedfx(var0, var1) {
  if(!isDefined(var1)) {
    var1 = self getEye() + (0, 0, 80);
  }

  var2 = level.helperdronesettings[var0];
  var3 = "ks_" + var0 + "_mp";

  if(var0 == "assault_drone") {
    var3 = var2.modelbase;
  }

  var4 = spawn("script_model", var1);
  var4 setModel(var3);
  var4 setscriptablepartstate("explode", "on", 0);
  thread delay_deletescriptable(var4);
}

function tryusehelperdroneearlyout(var0, var1) {
  if(scripts\cp_mp\utility\player_utility::isusingremote()) {
    return true;
  }

  if(istrue(self.drones_disabled)) {
    if(var1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE");
      }
    }

    return true;
  }

  if((var0.streakname == "radar_drone_recon" || var0.streakname == "assault_drone") && (!self isonground() && !self isonladder() || _calloutmarkerping_handleluinotify_enemyrepinged::updateleaders())) {
    if(var1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/FIELD_UPGRADE_CANNOT_USE");
      }
    }

    return true;
  }

  if(isDefined(level.getfirespoutlaunchvectors)) {
    if(![[level.getfirespoutlaunchvectors]](self)) {
      if(var1) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/FIELD_UPGRADE_CANNOT_USE");
        }
      }

      return true;
    }
  }

  var2 = incrementfauxvehiclecountifpossible(var0, var1);

  if(!var2) {
    return true;
  }

  var3 = addincominghelperdroneifpossible(var0, var1);

  if(!var3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]](1);
    }

    return true;
  }

  self.start_player_links = 1;
  return false;
}

function delay_deletescriptable(var0) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  self delete();
}

function createhelperdrone(var0, var1, var2, var3, var4, var5) {
  var6 = !istrue(var4) && istrue(var5);

  if(!isDefined(var0)) {
    if(!istrue(var6)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    return;
  }

  var7 = level.helperdronesettings[var2];
  var8 = var7.modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(self) && isDefined(var7.modelbasealt)) {
    var8 = var7.modelbasealt;
  }

  var9 = undefined;

  if(istrue(var4)) {
    var9 = spawn("script_model", var0);
    var9 setModel(var8);
    var9.nonvehicle = 1;
  } else {
    if(var6) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    var9 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(self, var0, var1, var7.vehicleinfo, var8);
  }

  if(!isDefined(var9)) {
    return;
  }

  var9 enableaimassist();
  var9 setnodeploy(1);
  var9.health = var7.maxhealth;
  var9.maxhealth = var7.maxhealth;
  var9.damagetaken = 0;
  var9.speed = var7.speed;
  var9.accel = var7.accel;
  var9.angles = var1;
  var9.manualspeed = 50;
  var9.owner = self;
  var9.team = self.team;
  var9.helperdronetype = var2;
  var9.combatmode = var7.primarymode;
  var9.currentstring = var7.secondarymodestring;
  var9.streakinfo = var3;
  var9.currentdamagestate = 0;

  if(istrue(var9.nonvehicle)) {
    var9 scripts\mp\sentientpoolmanager::registersentient("Tactical_Moving", self, undefined, undefined, 0, 1);
  } else {
    var9 scripts\mp\sentientpoolmanager::registersentient("Lethal_Moving", self);
    var9 setvehicleteam(var9.team);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var7.streakname, var7.scorepopup, var7.vodestroyed, undefined, var7.destroyedsplash);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var3.streakname, var7.premoddamagefunc);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var3.streakname, var7.postmoddamagefunc);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var3.streakname, var7.deathfunc);
  }

  if(isDefined(var7.flarescount)) {
    var9.flaresreservecount = var7.flarescount;
  }

  var9 setotherent(self);
  var9 setCanDamage(1);

  if(istrue(var4)) {
    var9 scriptmoveroutline();
    var9 scriptmoverthermal();
  } else {
    var9 vehicle_invoketriggers(1);
    var9 vehicle_breakglass(1);
  }

  var11 = 12;

  switch (var2) {
    case "radar_drone_overwatch":
      var11 = 60;
      break;
    case "scrambler_drone_escort":
      var12 = helperdrone_spawnnewscrambler(var9, "medium");
      var9.scrambler = var12;
      break;
    case "scrambler_drone_guard":
      if(istrue(level.ref_11a9d)) {
        var12 = helperdrone_spawnnewscrambler(var9, "large");
        var9.scrambler = var12;
      }

      var11 = 100;
      break;
    case "radar_drone_recon":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
          var9 vehicleshowonminimap(0);

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakUseDialog")) {
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakUseDialog")]]("radar_drone_recon");
          }

          spawn_additional_covernode(var9, var2);
        }
      }

      break;
    case "assault_drone":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
          var9 vehicleshowonminimap(0);

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakUseDialog")) {
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakUseDialog")]]("assault_drone");
          }

          spawn_additional_covernode(var9, var2);
        }
      }

      break;
    default:
      break;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var9[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var3.streakname, "Killstreak_Air", var9.owner, 0, 1, var11);
  }

  var9.attract_strength = 10000;
  var9.attract_range = 150;
  var9.attractor = missile_createattractorent(var9, var9.attract_strength, var9.attract_range);
  var9.stunned = 0;
  var9.inactive = 0;
  thread helperdrone_play_lightfx();
  var13 = spawnStruct();
  var13.validateaccuratetouching = 1;
  var13.deathoverridecallback = &helperdrone_moving_platform_death;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "handlemovingplatforms")) {
    var9[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "handlemovingplatforms")]](var13);
  }

  if(isDefined(level.helperdronesettings[var9.helperdronetype].streakname)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
      var9.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var7.streakname, var9.targetpos);
    }
  }

  return var9;
}

function spawn_additional_covernode(var0) {
  var1 = 3000;

  if(var0 == "assault_drone") {
    var1 = level.cargo_truck_horn;
  }

  var2 = level.teamdata[self.team]["players"];
  var3 = scripts\common\utility::playersincylinder(self.origin, var1, var2);

  foreach(var5 in var3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayer")) {
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayer")]](var5, var0, 1);
    }
  }
}

function helperdrone_handleteamvisibility() {
  foreach(var1 in level.players) {
    if(level.teambased && var1.team == self.team || !level.teambased && var1 == self.owner) {
      self hidefromplayer(var1);
    }
  }

  thread helperdrone_managevisibilityonteamjoin();
}

function helperdrone_managevisibilityonteamjoin() {
  self endon("death");
  self endon("leaving");
  self endon("explode");

  for(;;) {
    level waittill("joined_team", var0);

    if(level.teambased && var0.team == self.team) {
      self hidefromplayer(var0);
      continue;
    }

    self showtoplayer(var0);
  }
}

function helperdrone_endscramblereffect() {
  self notify("scramble_super_finished");

  if(isDefined(self.new_objective_thread) && self.new_objective_thread.size > 0) {
    foreach(var1 in self.new_objective_thread) {
      if(isDefined(var1)) {
        var2 = var1;

        if(isDefined(var2.owner)) {
          var2 = var2.owner;
        }

        var2 notify("scramble_off");
      }
    }
  }

  if(isDefined(self.friendliesaffectedbyscrambler) && self.friendliesaffectedbyscrambler.size > 0) {
    foreach(var5 in self.friendliesaffectedbyscrambler) {
      if(isDefined(var5)) {
        var5 notify("scramble_off");
      }
    }

    return;
  }
}

function spawn_ai_single(var0) {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("scramble_super_finished");

  if(!isDefined(var0)) {
    var0 = self.owner;
  }

  self.new_objective_thread = [];
  var1 = 0;
  var2 = getdvarfloat("compassScramblerRadius", 1000);
  var3 = var2 * var2;
  var4 = physics_createcontents(["physicscontents_player"]);
  var5 = self.origin - (0, 0, 3000);
  var6 = (var2, var2, 3000);
  var7 = var5 - var6;
  var8 = var5 + var6;

  for(;;) {
    var9 = physics_aabbbroadphasequery(var7, var8, var4, []);

    foreach(var11 in var9) {
      var12 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        var12 = var11[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_scrambler_resist");
      }

      if(isDefined(var11) && var11 scripts\cp_mp\utility\player_utility::_isalive() && !var12) {
        if(distance2dsquared(self.origin, var11.origin) > var3) {
          continue;
        }

        if(var1 || level.teambased && var11.team != self.team && var11.team != "spectator" || !level.teambased && var11 != self.owner) {
          if(var11 scripts\cp_mp\utility\player_utility::isusingremote()) {
            continue;
          }

          if(helperdrone_entaffectedbyscramble(var11, self, var1)) {
            continue;
          }

          helperdrone_setscramblerjammed(var11, 1, self, var1);
        }

        continue;
      }

      if(isDefined(var11.scrambledby) && var11.scrambledby == self) {
        var11 notify("scramble_off");
      }
    }

    waitframe();
  }
}

function helperdrone_setscramblerplayerbuffs(var0, var1) {
  if(helperdrone_entaffectedbyscramble(var1) && istrue(var0)) {
    return;
  }

  if(istrue(var0)) {
    var1.friendliesaffectedbyscrambler[var1.friendliesaffectedbyscrambler.size] = self;
    thread helperdrone_managescramblerplayerbuff(var1);

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

function helperdrone_managescramblerplayerbuff(var0) {
  scripts\engine\utility::ref_143a5("death_or_disconnect", "scramble_off");
  helperdrone_setscramblerplayerbuffs(0, var0);
}

function helperdrone_setscramblerjammed(var0, var1, var2) {
  var3 = self;

  if(istrue(var0)) {
    var3.scrambledby = var1;

    if(!scripts\engine\utility::array_contains(var1.new_objective_thread, var3)) {
      var1.new_objective_thread[var1.new_objective_thread.size] = var3;
    }

    thread helperdrone_managescramblereffect(var3, var1);
    thread helperdrone_watchscramblestrength(var3);
    return;
  }

  if(isDefined(var3)) {
    var3.scrambledby = undefined;
    var3 scripts\cp_mp\emp_debuff::stop_emp_scramble(var3.currentscramblerstrength);
    var3.previousscramblerstrength = undefined;
    var3.currentscramblerstrength = undefined;
    return;
  }
}

function helperdrone_managescramblereffect(var0, var1) {
  level endon("game_ended");
  scripts\engine\utility::ref_143a5("death", "scramble_off");

  if(isDefined(self)) {
    helperdrone_setscramblerjammed(0, var0, var1);

    if(isDefined(var0) && isDefined(var0.new_objective_thread)) {
      var0.new_objective_thread = scripts\engine\utility::array_remove(var0.new_objective_thread, self);
      return;
    }

    return;
  }

  if(isDefined(var0) && isDefined(var0.new_objective_thread)) {
    var0.new_objective_thread = scripts\engine\utility::array_removeundefined(var0.new_objective_thread);
    return;
  }
}

function helperdrone_watchremotescrambledent(var0, var1) {
  var0 endon("death");
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.owner)) {
    if(helperdrone_entaffectedbyscramble(self.owner, var0, var1)) {
      helperdrone_setscramblerjammed(self.owner, 0, var0, var1);
      return;
    }

    return;
  }
}

function helperdrone_watchscramblestrength(var0) {
  self endon("death");
  self endon("scramble_off");
  self endon("disconnect");
  var0 endon("death");
  var1 = 0;
  var2 = 0;
  var3 = getdvarfloat("compassScramblerRadius", 1000);
  var4 = var3 * var3;

  for(;;) {
    var5 = distance2dsquared(var0.origin, self.origin);

    if(var5 > var4) {
      var2 = 0;
    } else if(var5 >= var4 * 0.8) {
      var2 = 1;
    } else if(var5 >= var4 * 0.6) {
      var2 = 2;
    } else if(var5 >= var4 * 0.4) {
      var2 = 3;
    } else if(var5 >= var4 * 0.2) {
      var2 = 4;
    } else {
      var2 = 5;
    }

    var6 = var2 != var1;

    if(var1 == 0 || var6) {
      self.previousscramblerstrength = var1;
      self.currentscramblerstrength = var2;

      if(self.previousscramblerstrength > 1) {
        var7 = self.previousscramblerstrength;
      }

      if(self.currentscramblerstrength > 1) {
        var7 = self.currentscramblerstrength;
      }

      scripts\cp_mp\emp_debuff::stop_emp_scramble(var1);
      scripts\cp_mp\emp_debuff::play_emp_scramble(var2);
      var1 = var2;
    }

    waitframe();
  }
}

function helperdrone_entaffectedbyscramble() {
  var2 = 0;
  var3 = undefined;

  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(var5 in level.supportdrones) {
      if(var5.helperdronetype != "scrambler_drone_guard") {
        continue;
      }

      if(level.teambased) {
        if(!isDefined(var1) && var5.team == self.team) {
          var3 = var5.friendliesaffectedbyscrambler;
        } else {
          var3 = var5.new_objective_thread;
        }
      } else if(!isDefined(var1) && var5.owner == self) {
        var3 = var5.friendliesaffectedbyscrambler;
      } else {
        var3 = var5.new_objective_thread;
      }

      if(!isDefined(var3)) {
        continue;
      }

      if(var3.size > 0) {
        foreach(var7 in var3) {
          if(self == var7 || isDefined(var7.owner) && self == var7.owner) {
            var2 = 1;
            break;
          }
        }

        if(istrue(var2)) {
          break;
        }
      }
    }

    var1 = undefined;
    var3 = undefined;
  }

  return < error > ;
}

function helperdrone_enableradar(var0) {
  var1 = spawn("script_model", self.origin);
  var1.owner = self.owner;
  var1.team = self.owner.team;
  self.radar = var1;

  if(var0 == "auto_radar") {
    var1 makeportableradar(self.owner);
  } else if(var0 == "escort_radar") {
    var1 setentityowner(self.owner);
    var1 setotherent(self.owner);
    var1 setModel("ks_radar_drone_escort_mp");
  } else if(var0 == "recon_radar") {
    var1 setentityowner(self.owner);
    var1 setotherent(self.owner);
    var1 setModel("ks_radar_drone_recon_mp");
    var2 = 1.5;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_improved_target_mark")) {
        var2 *= getdvarfloat("perk_target_marked_longer_rate");
      }
    }

    thread helperdrone_watchradartrigger(500, 10, 0.1, var2);
  }

  var1 linkTo(self);
}

function helperdrone_watchradartrigger(var0, var1, var2, var3) {
  self endon("death");
  self.trigger = spawn("trigger_rotatable_radius", self.origin, 0, var0, var0);

  for(;;) {
    self.trigger waittill("trigger", var4);

    if(!isPlayer(var4)) {
      continue;
    }

    if(level.teambased) {
      if(var4.team == self.team) {
        continue;
      }
    }

    if(var4 == self.owner) {
      continue;
    }

    for(var5 = 0; var5 < 3; var5++) {
      var6 = var0 / var1 * 0.05 * 1000;

      if(level.teambased) {
        triggerportableradarpingteam(self.radar.origin, self.radar.team, var0, int(var6 / 2));
      } else {
        triggerportableradarping(self.radar.origin, self.radar.owner, var0, int(var6 / 2));
      }

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
      self.radar setscriptablepartstate("pulse", "on", 0);
      self playSound("oracle_radar_pulse_npc");
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var6 / 1000);
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

function helperdrone_spawnnewscrambler(var0, var1, var2) {
  var3 = spawn("script_model", self.origin);
  var3.team = self.owner.team;
  var3 makescrambler(self.owner, var0);
  var3 linkTo(self);
  return var3;
}

function helperdrone_moving_platform_death(var0) {
  if(!isDefined(var0.lasttouchedplatform.destroydroneoncollision) || var0.lasttouchedplatform.destroydroneoncollision) {
    self notify("death");
    return;
  }
}

function helperdrone_play_lightfx() {
  var0 = level.helperdronesettings[self.helperdronetype];

  if(isDefined(var0.playfxcallback)) {
    self[[var0.playfxcallback]]();
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

function starthelperdrone(var0) {
  level endon("game_ended");
  var0 endon("death");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  var1 = level.helperdronesettings[var0.helperdronetype];

  if(isDefined(var1.damagemonitorfunc)) {
    var0 thread[[var1.damagemonitorfunc]]();
  }

  thread helperdrone_watchtimeout();
  thread helperdrone_watchownerloss();
  thread helperdrone_watchownerdeath();
  thread helperdrone_watchroundend();
  thread helperdrone_destroyongameend();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

    if(var2 == "br") {
      thread spawn_ai_and_seat_in_vehicle(var0);
    }
  }

  var0 setCanDamage(1);
  var0 thread[[var1.primarymodefunc]](var1);
}

function helperdrone_followplayer(var0) {
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
    var1 = self.owner getstance();

    if(!isDefined(self.last_owner_stance) || var1 != self.last_owner_stance || istrue(self.stoppedatlocation)) {
      if(istrue(self.stoppedatlocation)) {
        self.stoppedatlocation = undefined;
      }

      self.last_owner_stance = var1;
      helperdrone_movetoplayer(self.owner, var0);
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
  var0 = 1;
  self vehicle_setspeed(200, 50, 10);

  for(;;) {
    var1 = undefined;

    if(istrue(var0)) {
      var2 = self.origin;
      var3 = self.owner.origin * (1, 1, 0) + (0, 0, self.origin[2]);
      var1 = scripts\engine\trace::ray_trace(var2, var3, self);
    }

    var4 = self.owner.origin[0];
    var5 = self.owner.origin[1];

    if(isDefined(var1)) {
      if(var1["hittype"] != "hittype_none") {
        var4 = var1["position"][0];
        var5 = var1["position"][1];
      }
    }

    var6 = getcorrectheight(var4, var5, 20);
    var7 = (var4, var5, var6);
    self setlookatent(self.owner);
    self setvehgoalpos(var7, 1);
    scripts\engine\utility::ref_143a5("goal", "begin_evasive_maneuvers");

    if(istrue(var0)) {
      var0 = undefined;
      self vehicle_setspeed(level.helperdronesettings[self.helperdronetype].speed, 10, 10);
    }

    self clearlookatent();
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

function getcorrectheight(var0, var1, var2) {
  var3 = 1500;
  var5 = tracegroundpoint(var0, var1);
  var6 = var5 + var3;
  var6 += randomint(var2);
  return var6;
}

function tracegroundpoint(var0, var1) {
  self endon("death");
  self endon("leaving");
  var2 = -99999;
  var3 = self.origin[2] + 2000;
  var4 = level.averagealliesz;
  var5 = [self];
  var6 = scripts\engine\trace::sphere_trace((var0, var1, var3), (var0, var1, var2), 256, var5, undefined, 1);

  if(var6["position"][2] < var4) {
    var7 = var4;
  } else {
    var7 = var7["position"][2];
  }

  return var7;
}

function helperdrone_pingnearbyenemies() {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  var0 = 300;
  var1 = 1200;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var0 = 1000;
    var1 = 2500;
  }

  self.ref_12368 = [];

  for(;;) {
    var2 = scripts\common\utility::playersinsphere(self.owner.origin, var1);

    foreach(var4 in var2) {
      if(var4 == self.owner) {
        continue;
      }

      if(level.teambased && var4.team == self.owner.team) {
        continue;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var4)) {
          continue;
        }
      }

      if(source(var4, self)) {
        continue;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var4[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_ghost")) {
          continue;
        }
      }

      triggerportableradarping(var4.origin, self.owner, var0, 3000);
      thread helperdrone_watchpingedstatus(var4, self.owner);
    }

    waitframe();
  }
}

function helperdrone_watchpingedstatus(var0, var1) {
  self endon("death");
  var0 endon("disconnect");
  level endon("game_ended");

  if(isDefined(var1)) {
    var0 playsoundtoplayer("recondrone_marker", var1);
  }

  self.ref_12368[self.ref_12368.size] = var0;
  var0 scripts\engine\utility::ref_143b9(3, "death");
  self.ref_12368 = scripts\engine\utility::array_remove(self.ref_12368, var0);
}

function source(var0) {
  var1 = 0;

  foreach(var3 in var0.ref_12368) {
    if(isDefined(var3) && self == var3) {
      var1 = 1;
      break;
    }
  }

  return var1;
}

function helperdrone_getheightoffset(var0) {
  var1 = var0.standupoffset;
  var2 = self.owner getstance();

  switch (var2) {
    case "stand":
      var1 = var0.standupoffset;
      break;
    case "crouch":
      var1 = var0.crouchupoffset;
      break;
    case "prone":
      var1 = var0.proneupoffset;
      break;
  }

  return var1;
}

function helperdrone_guardlocation() {
  self.stoppedatlocation = 1;
  var0 = self.origin[2] / 2;
  var1 = self.mappointinfo[0].location + (0, 0, var0);
  var2 = scripts\engine\trace::sphere_trace(self.origin, var1, 200, self);

  if(isDefined(var2)) {
    if(isDefined(var2["entity"])) {
      var1 = var2["entity"].origin + (0, 0, randomintrange(50, 150));

      if(isDefined(var2["entity"].guardlocation)) {
        var1 = var2["entity"].guardlocation + (0, 0, randomintrange(50, 150));
      }
    } else if(isDefined(var2["hittype"]) && isDefined(var2["position"]) && var2["hittype"] != "hittype_none") {
      var1 = var2["position"] + (0, 0, randomintrange(50, 150));
    }
  }

  thread helperdrone_moveintoplace(var1);
  self.guardlocation = var1;
}

function helperdrone_moveintoplace(var0) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("rotors", "on", 0);
  self playLoopSound("veh_scrambler_drone_idle_high");
  self moveTo(var0 - (0, 0, 20), 3, 2, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.2);
  self moveTo(var0, 1, 0.5, 0.5);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.2);

  for(;;) {
    var1 = randomintrange(-35, 35);
    var2 = randomintrange(-15, 15);
    var3 = var0[0] + var1;
    var4 = var0[1] + var1;
    var5 = var0[2] + var2;
    var6 = (var3, var4, var5);
    self moveTo(var6, 3, 2, 1);
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

function helperdrone_movetoplayer(var0, var1) {
  self setlookatent(var0);
  var2 = helperdrone_gettargetoffset(self, var0);

  if(isDefined(var1)) {
    var2 = var1;
  }

  self setdronegoalent(var0, var2, 16, 10);
  self.intransit = 1;
  thread helperdrone_watchforgoal();
}

function helperdrone_watchmodeswitch() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");
  var0 = level.helperdronesettings[self.helperdronetype];
  jumpiffalse(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "setKillstreakControlPriority")) LOC_00000076;
  self.useobj[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "setKillstreakControlPriority")]](self.owner, self.currentstring, 360, 360, 30000, 30000, 3);

  for(;;) {
    self.useobj waittill("trigger", var1);

    if(var1 != self.owner) {
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

    var2 = 0;
    var3 = undefined;
    var4 = level.framedurationseconds;

    while(self.owner useButtonPressed()) {
      var2 += var4;

      if(var2 > 0.1) {
        self notify("switch_modes");
        var5 = getothermode(self.combatmode, self.streakinfo);
        var6 = "Empty String";

        if(var5 == var0.primarymode) {
          var3 = [[var0.primarymodefunc]](var0);
          var6 = var0.secondarymodestring;
        } else {
          var3 = [[var0.secondarymodefunc]](var0);
          var6 = var0.primarymodestring;
        }

        if(!istrue(var3)) {
          return;
        }

        self.combatmode = var5;
        self.currentstring = var6;
        self.useobj makeunusable();
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "setKillstreakControlPriority")) {
          self.useobj[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "setKillstreakControlPriority")]](self.owner, self.currentstring, 360, 360, 30000, 30000, 3);
        }

        break;
      }

      wait var4;
    }

    wait var4;
  }
}

function getothermode(var0, var1) {
  var2 = level.helperdronesettings[self.helperdronetype];

  if(var0 == var2.primarymode) {
    var0 = var2.secondarymode;
  } else {
    var0 = var2.primarymode;
  }

  return var0;
}

function setescortmodesettings(var0) {
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

function setreconmodesettings(var0) {
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
  var1 = 0;
  self.owner.restoreangles = self.owner.angles;
  self.owner setplayerangles(self.angles);
  self.owner cameralinkTo(self, "tag_origin");
  self.owner remotecontrolvehicle(self);
  self.owner painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::ref_11dc0(self.owner);

  if(!istrue(var1)) {
    ref_131b7(self.owner, 1, self);
    self.owner setclientomnvar("ui_rcd_outer_ring", 0);
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.timeout * 1000));
    self.owner setclientomnvar("ui_killstreak_health", helperdrone_getcurrenthealth() / var0.maxhealth);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerEntForOOB")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerEntForOOB")]](self, "killstreak");
    }

    thread monitoroutofboundsdistortion();

    if(false) {
      scripts\cp_mp\outofrange::setupoutofrangewatcher(self, undefined, self.owner, undefined, 2250000, 9000000);
    }

    scripts\cp_mp\utility\weapon_utility::setlockedoncallback(self, &helperdrone_lockedoncallback);
    scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(self, &helperdrone_lockedonremovedcallback);
    thread helperdrone_watchouterreticletargets(var0);
    thread helperdrone_watchouterreticlestate(var0);
    thread helperdrone_watchnotificationstate(var0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "mark_players")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "mark_players")]](var0);
    } else {
      thread helperdrone_markplayers(var0);
    }
  }

  self.owner scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  thread helperdrone_watchearlyexit(var0);
  thread spawn_ai_func_ref(var0);
  thread helperdrone_handlethermalswitch();
  thread spawn_acceleration(var0);
  return true;
}

function ref_13128(var0) {
  self.playersfx = spawn("script_origin", self.origin);
  self.playersfx showonlytoplayer(self.owner);
  self.playersfx linkTo(self);
  self.playersfx playLoopSound("recon_drone_overlay");
  self.owner setsoundsubmix("mp_recon_drone", 1);
  self.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("asdmarker", self.owner, undefined, self.owner, 0, 0, 0);
  self.ispiloted = 1;
  self.owner scripts\common\utility::allow_usability(0);
  self.owner scripts\common\utility::allow_fire(0);
  var1 = 0;
  self.owner.restoreangles = self.owner.angles;
  self.owner setplayerangles(self.angles);
  self.owner cameralinkTo(self, "tag_origin");
  self.owner remotecontrolvehicle(self);
  self.owner painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::ref_11dc0(self.owner);

  if(!istrue(var1)) {
    ref_131b7(self.owner, 1, self);
    self.owner setclientomnvar("ui_rcd_outer_ring", 0);
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.timeout * 1000));
    self.owner setclientomnvar("ui_killstreak_health", helperdrone_getcurrenthealth() / var0.maxhealth);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerEntForOOB")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerEntForOOB")]](self, "killstreak");
    }

    thread monitoroutofboundsdistortion();

    if(false) {
      scripts\cp_mp\outofrange::setupoutofrangewatcher(self, undefined, self.owner, undefined, 2250000, 9000000);
    }

    scripts\cp_mp\utility\weapon_utility::setlockedoncallback(self, &helperdrone_lockedoncallback);
    scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(self, &helperdrone_lockedonremovedcallback);
    thread helperdrone_watchouterreticletargets(var0);
    thread spawn_ai_individual(var0);
    thread sp_stealth_broken_listener(var0);
  }

  self playLoopSound("assault_drone_warning_beep");
  self.owner scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  thread helperdrone_watchearlyexit(var0);
  thread spawn_ai_func_ref(var0);
  thread helperdrone_handlethermalswitch();
  thread spawn_acceleration(var0);

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

function setoverwatchmodesettings(var0) {
  thread helperdrone_overwatchplayer();
  thread helperdrone_pingnearbyenemies();
  helperdrone_handleteamvisibility();
  return true;
}

function setfollowmode(var0) {
  thread helperdrone_followplayer();
  return true;
}

function setguardmode(var0) {
  helperdrone_guardlocation();
  scramblerdrone_counteruavmodeon();
  helperdrone_handleteamvisibility();
  self setscriptablepartstate("looping_wave", "on", 0);
  self setscriptablepartstate("scramble_sfx", "on", 0);
  self scriptmodelplayanim(level.scr_animname["scrambler_drone_guard"]["rotor_spin"]);
  thread spawn_ai_single();
  return true;
}

function setdeliverymodesettings(var0) {
  thread helperdrone_deliver(var0);
  return true;
}

function helperdrone_deliver(var0) {
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self setneargoalnotifydist(10);
  var1 = level.helperdronesettings[self.helperdronetype].speed;
  var2 = level.helperdronesettings[self.helperdronetype].accel;
  self vehicle_setspeed(var1, var2, var2);
  var3 = self.deliverytarget + (0, 0, 4000);
  var4 = self.deliverytarget + (0, 0, 2500);
  var5 = self.deliverytarget + (0, 0, 100);
  var6 = level.helperdronesettings[self.helperdronetype].halfsize;
  var7 = [];
  GscBinSkip0(0x2e, 0, self);
}

function helperdrone_getcurrenthealth() {
  var0 = self.maxhealth;
  var1 = var0 - self.damagetaken;
  return int(max(0, var1));
}

function helperdrone_watchearlyexit(var0) {
  self.owner endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("death", var0.ref_1217e);
  }

  self waittill("killstreakExit");
  thread helperdroneexplode(0, istrue(var0.leaderboarddata));
}

function spawn_ai_func_ref(var0) {
  if(!istrue(var0.leaderinteractionthink)) {
    return;
  }

  var1 = self.owner;
  var1 notifyonplayercommand("detonate_drone", "+attack");
  spawn_ai_group();

  if(isDefined(var1)) {
    var1 notifyonplayercommandremove("detonate_drone", "+attack");
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
  var0 = self.owner;
  var0 thread scripts\cp_mp\utility\player_utility::watchthermalinputchange();
  var1 = 1;

  if(istrue(var1)) {
    if(level.mapname == "mp_hideout") {
      var0 visionsetkillstreakforplayer("drone_color_dark");
    } else {
      var0 visionsetkillstreakforplayer("drone_color");
    }
  }

  var0 visionsetthermalforplayer("flir_0_black_to_white_recon");
  helperdrone_handlethermalswitchinternal();

  if(isDefined(var0)) {
    var0 scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();

    if(istrue(var1)) {
      var0 visionsetkillstreakforplayer("");
    }

    var0 visionsetthermalforplayer("");

    if(self.isthermalenabled) {
      var0 thermalvisionoff();
      return;
    }

    return;
  }
}

function helperdrone_handlethermalswitchinternal() {
  var0 = self.owner;
  var0 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  self.isthermalenabled = 0;

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    self.isthermalenabled = 1;
    var0 thermalvisionon();
  }

  for(;;) {
    var0 waittill("switch_thermal_mode");

    if(self.isthermalenabled) {
      self.isthermalenabled = 0;
      var0 thermalvisionoff();
      var0 playlocalsound("weap_thermal_toggle_click");
      continue;
    }

    self.isthermalenabled = 1;
    var0 playlocalsound("weap_thermal_toggle_click");
    var0 thermalvisionon();
  }
}

function spawn_acceleration(var0) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  for(;;) {
    self waittill("touch", var1);

    if(!isDefined(var1)) {
      continue;
    }

    var2 = undefined;

    if(var1 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var2 = var1;
    } else if(var1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      var2 = var1.vehicle;
    } else if(istrue(var1.velstartid)) {
      var2 = var1;
    }

    if(!isDefined(var2)) {
      continue;
    }

    var3 = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var2.owner));

    if(istrue(var0.leaderplunderstring)) {
      if(var3 || !isDefined(var2.owner)) {
        thread helperdroneexplode(0, 1);
      } else {
        self dodamage(self.maxhealth, var2.origin, undefined, undefined, "MOD_CRUSH");
      }
    } else {
      var4 = undefined;
      var5 = undefined;

      if(var3) {
        var6 = var2.owner scripts\cp_mp\utility\player_utility::getvehicle();

        if(isDefined(var6) && var6 == var2) {
          var4 = var2.owner;
          var5 = var2;
        }
      }

      self dodamage(self.maxhealth, var2.origin, var4, var5, "MOD_CRUSH");
    }

    break;
  }
}

function sounddebouncetimestamp(var0) {
  self.owner endon("disconnect");
  self endon("death");
  wait var0;
  self.owner thread scripts\cp_mp\utility\player_utility::ai_offhandfiremanager();
}

function helperdrone_markplayers(var0) {
  var1 = self.owner;
  var1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var2 = 0;

  for(;;) {
    self.targethascoldblooded = 0;
    self.targetisnotinmarkingrange = 0;
    self.c130airdrop_findvaliddroplocation = 0;
    var3 = self.targetsinouterradius;

    foreach(var5 in var3) {
      if(var2 >= 3) {
        var2 = 0;
        waitframe();
      }

      if(isPlayer(var5) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var5)) {
          continue;
        }
      }

      if(isagent(var5) && !isalive(var5)) {
        continue;
      }

      if(!isDefined(var5)) {
        continue;
      }

      if(isbeingmarked(var5)) {
        continue;
      }

      if(isreconmarked(var5)) {
        continue;
      }

      var2++;
      ref_131c9(self.targetmarkergroup, var5, 1);
      var6 = canseetarget(var5);
      var7 = helperdrone_istargetinreticle(var1, var5, 70, 40);
      var8 = isinmarkingrange(var5);
      var9 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(isPlayer(var5) && var5[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          var9 = 1;
        }
      }

      if(var7 && var9) {
        self.targethascoldblooded = 1;
      }

      if(var7 && !var8) {
        self.targetisnotinmarkingrange = 1;
      }

      if(var8) {
        self.c130airdrop_findvaliddroplocation = 1;
      }

      if(var9) {
        ref_131c9(self.targetmarkergroup, var5, 3);
        continue;
      }

      if(!var8 || !var6) {
        ref_131c9(self.targetmarkergroup, var5, 0);
        continue;
      }

      if(!var7) {
        continue;
      }

      if(istrue(self.markingtarget)) {
        continue;
      }

      thread startmarkingtarget(var5, "enemy", 0, 1);
    }

    var2 = 0;
    waitframe();
  }
}

function sp_stealth_broken_listener(var0) {
  var1 = self.owner;
  var1 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var2 = 0;

  for(;;) {
    var3 = self.targetsinouterradius;
    var4 = 0;

    foreach(var6 in var3) {
      if(var2 >= 3) {
        var2 = 0;
        waitframe();
      }

      if(!isDefined(var6)) {
        continue;
      }

      if(isPlayer(var6) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var6)) {
          continue;
        }
      }

      var2++;
      ref_131c9(self.targetmarkergroup, var6, 1);
      var7 = canseetarget(var6);
      var8 = isinmarkingrange(var6);

      if(!var8 || !var7) {
        ref_131c9(self.targetmarkergroup, var6, 0);
        continue;
      }

      var4 = 1;
      ref_131c9(self.targetmarkergroup, var6, 2);
    }

    self.ref_13a79 = var4;
    var2 = 0;
    waitframe();
  }
}

function helperdrone_watchouterreticlestate(var0) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");
  var1 = 0;

  for(;;) {
    if(istrue(self.markingtarget) && var1 == 0) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 1);
      var1 = 1;
    } else if(!istrue(self.markingtarget) && var1 == 1) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 0);
      var1 = 0;
    }

    waitframe();
  }
}

function spawn_ai_individual(var0) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");
  var1 = 0;

  for(;;) {
    if(istrue(self.ref_13a79) && var1 == 0) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 1);
      var1 = 1;
    } else if(!istrue(self.ref_13a79) && var1 == 1) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 0);
      var1 = 0;
    }

    waitframe();
  }
}

function helperdrone_watchnotificationstate(var0) {
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

function helperdrone_watchouterreticletargets(var0) {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  self.owner endon("disconnect");
  self.targetsinouterradius = [];

  for(;;) {
    var1 = level.activekillstreaks;
    var2 = [[level.getactiveequipmentarray]]();
    var3 = level.characters;

    if(isDefined(level.battle_tracks_shouldstartbattletracks)) {
      var4 = [];

      foreach(var6 in level.battle_tracks_shouldstartbattletracks) {
        if(isDefined(var6.iscash)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "gameFlag")) {
            if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "gameFlag")]]("prematch_done")) {
              if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isPlayerOnIntelChallenge")) {
                if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerOnIntelChallenge")]](self.owner, var6.iscash)) {
                  var4 = var6;
                }
              }
            }
          }

          continue;
        }

        var4 = var6;
      }

      var8 = scripts\engine\utility::array_combine(var3, var4);
    } else {
      var8 = var3;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "get_outer_reticle_targets")) {
      var8 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "get_outer_reticle_targets")]](var0);
    }

    foreach(var10 in var8) {
      if(isPlayer(var10)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
          if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var10)) {
            continue;
          }
        }

        if(!istrue(var0.ref_11b06)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
            if(var10[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
              continue;
            }
          }
        }
      }

      if(isagent(var10) && !isalive(var10)) {
        continue;
      }

      if(level.teambased) {
        if(isDefined(var10.team) && var10.team == self.team) {
          continue;
        }
      } else {
        if(isPlayer(var10) && var10 == self.owner) {
          continue;
        }

        if(isDefined(var10.owner) && var10.owner == self.owner) {
          continue;
        }
      }

      if(!isindetectrange(var10)) {
        continue;
      }

      if(isreconmarked(var10)) {
        continue;
      }

      if(isinouterradius(self, var10)) {
        continue;
      }

      var0 = level.helperdronesettings[self.helperdronetype];

      if(istrue(var0.ref_11b07) && !helperdrone_istargetinreticle(self.owner, var10, 70, 300)) {
        continue;
      }

      thread startmarkingpassivetarget(var10);
    }

    waitframe();
  }
}

function canseetarget(var0) {
  var1 = 0;

  if(isDefined(var0.ref_12a9b)) {
    var2 = var0.ref_12a9b;
  } else {
    var2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  }

  var3 = var1.origin;

  if(isDefined(var1.ref_12a9c)) {
    var3 += var1.ref_12a9c;
  }

  var4 = [var3];

  if(isPlayer(var1)) {
    var5 = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      var5 = var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceTop")]]();
    }

    var6 = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      var6 = var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceCenter")]]();
    }

    var4 = [var5, var6, var3];
  } else if(isagent(var1)) {
    var4 = [var3 + (0, 0, 1)];
  }

  var7 = [self, var1];
  var8 = var1 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var8)) {
    var7 = var8;
    var9 = var8 getlinkedchildren(1);

    foreach(var11 in var9) {
      var7 = var8;
    }
  }

  for(var13 = 0; var13 < var4.size; var13++) {
    if(!scripts\engine\trace::ray_trace_passed(self.owner getvieworigin(), var4[var13], var7, var2)) {
      continue;
    }

    var2 = 1;
    break;
  }

  return var2;
}

function startmarkingpassivetarget(var0) {
  var1 = self.owner;
  var1 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");

  if(!isDefined(self.targetmarkergroup)) {
    return;
  }

  self.targetsinouterradius[self.targetsinouterradius.size] = var0;
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var0, self.targetmarkergroup, 0);
  ref_131c9(self.targetmarkergroup, var0, 0);

  while(isDefined(var0)) {
    if(isPlayer(var0) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](var0)) {
        break;
      }
    }

    if(isagent(var0) && !isalive(var0)) {
      break;
    }

    var2 = level.helperdronesettings[self.helperdronetype];

    if(istrue(var2.ref_11b07) && !helperdrone_istargetinreticle(self.owner, var0, 70, 300)) {
      break;
    }

    if(!isindetectrange(var0)) {
      break;
    }

    waitframe();
  }

  if(isDefined(var0)) {
    if(scripts\cp_mp\targetmarkergroups::targetmarkergroupexists(self.targetmarkergroup) && !isreconmarked(var0)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var0, var0 getentitynumber(), self.targetmarkergroup);
    }

    if(scripts\engine\utility::array_contains(self.targetsinouterradius, var0)) {
      self.targetsinouterradius = scripts\engine\utility::array_remove(self.targetsinouterradius, var0);
      return;
    }

    return;
  }

  self.targetsinouterradius = scripts\engine\utility::array_removeundefined(self.targetsinouterradius);
}

function startmarkingtarget(var0, var1, var2, var3) {
  var4 = self.owner;
  var4 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var5 = spawnStruct();
  var5.target = var0;
  var5.targetnum = var0 getentitynumber();
  var5.markingent = self;
  var5.ownerteam = var4.team;
  var5.outlineid = undefined;
  var5.headicon = undefined;
  var5.beingmarked = undefined;
  var5.reconmarked = undefined;
  var5.notifytoendmark = "unmarked_" + var5.targetnum;

  if(!isDefined(var5.targetnum)) {
    return;
  }

  if(!isDefined(self.targetmarkergroup)) {
    return;
  }

  var5.beingmarked = 1;
  self.markingtarget = 1;
  self.owner notify("marking_target");
  ref_131b7(self.owner, 2, self);
  var6 = getmarkingdelay(var0);
  self.owner playlocalsound("recon_drone_marking_owner");

  while(var6 > 0) {
    if(!isDefined(var0)) {
      return;
    }

    if(!helperdrone_istargetinreticle(var4, var0, 70, 40)) {
      var5.beingmarked = undefined;
      self.markingtarget = undefined;
      self.owner stoplocalsound("recon_drone_marking_owner");
      ref_131b7(self.owner, 1, self);
      return;
    }

    var6 -= 0.05;
    wait 0.05;
  }

  if(isDefined(var0.ref_12a99)) {
    [[var0.ref_12a99]](var4, var0);
  }

  var5.reconmarked = 1;
  self.markingtarget = undefined;
  markent(var5, undefined);
  self.owner playlocalsound("recon_drone_marked_owner");
  self.owner stoplocalsound("recon_drone_marking_owner");
  ref_131b7(self.owner, 4, self);
  ref_131c9(self.targetmarkergroup, var0, 2);
  addmarkpoints(var0, var1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("reconDroneMarks", 1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "combatRecordSuperMisc")) {
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "combatRecordSuperMisc")]]("super_recon_drone");
  }

  self.usedcount++;
  var7 = 5;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_improved_target_mark")) {
      var7 += 2;
    }
  }

  thread waituntilunmarked(var5, var7);
}

function addmarkpoints(var0, var1) {
  if(!isDefined(self.markedentitieslifeindicices)) {
    self.markedentitieslifeindicices = [];
  }

  var2 = var0 getentitynumber();
  var3 = scripts\engine\utility::ter_op(isDefined(self.matchdatalifeindex), self.matchdatalifeindex, 0);

  if(!isDefined(self.markedentitieslifeindicices[var2]) || self.markedentitieslifeindicices[var2] > var3) {
    self.markedentitieslifeindicices[var2] = var3;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
      self.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]](self.helperdronetype + "_" + var1 + "_marked");
      return;
    }

    return;
  }
}

function waituntilunmarked(var0, var1) {
  level endon("game_ended");
  var2 = var0.target;
  var2 endon(var0.notifytoendmark);
  waituntilunmarkedinternal(var0, var1);
  unmark(var0);
}

function waituntilunmarkedinternal(var0, var1) {
  var2 = self.owner;
  var2 endon("disconnect");
  var3 = var0.target;
  var3 endon("death");

  for(var4 = gettime(); var1 * 1000 + var4 >= gettime(); var4 = gettime()) {
    wait 0.05;

    if(isDefined(self) && isDefined(self.owner) && helperdrone_istargetinreticle(self.owner, var3, 70, 40) && isinmarkingrange(var3) && canseetarget(var3)) {}
  }
}

function resetreticlemarkingprogressstate(var0) {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  var1 = self.owner;
  var1 endon("disconnect");
  var1 endon("marking_target");
  wait var0;
  ref_131b7(self.owner, 1, self);
}

function islocationmarked(var0) {
  return istrue(var0.locationmarked);
}

function isinouterradius(var0, var1) {
  return scripts\engine\utility::array_contains(var0.targetsinouterradius, var1);
}

function isbeingmarked(var0) {
  if(!isDefined(self.enemiesmarked)) {
    return false;
  }

  var1 = self.enemiesmarked[var0 getentitynumber()];

  if(!isDefined(var1)) {
    return false;
  }

  return isDefined(var1.beingmarked);
}

function isreconmarked(var0) {
  if(!isDefined(self.enemiesmarked)) {
    return false;
  }

  var1 = self.enemiesmarked[var0 getentitynumber()];

  if(!isDefined(var1)) {
    return false;
  }

  return istrue(var1.reconmarked);
}

function isinmarkingrange(var0) {
  var1 = level.helperdronesettings[self.helperdronetype];
  var2 = scripts\cp_mp\utility\game_utility::islargemap();
  var3 = scripts\engine\utility::ter_op(var2, var1.ref_11b18, var1.ref_11b17);

  if(isDefined(var0.ref_11b08)) {
    var3 = var0.ref_11b08;
  }

  var4 = var0.origin;

  if(isPlayer(var0)) {
    var4 = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      var4 = var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceCenter")]]();
    }
  }

  return distancesquared(self.origin, var4) < var3;
}

function isindetectrange(var0) {
  return distancesquared(self.origin, var0.origin) < 25000000;
}

function getmarkingdelay(var0) {
  return 0.3;
}

function marklocation(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.target = var0;
  var4.targetnum = var0 getentitynumber();
  var4.outlineid = undefined;
  var4.headicon = undefined;
  var5 = spawn("script_model", var1);
  var5 setModel("tag_origin");
  var6 = undefined;

  if(level.teambased) {
    var6 = [];

    foreach(var8 in level.players) {
      if(!isDefined(var8)) {
        continue;
      }

      if(var8.team != self.team) {
        continue;
      }

      var6 = var8;
    }
  } else {
    var6 = self.owner;
  }

  if(!isDefined(var6)) {
    return;
  }

  if(isarray(var6) && var6.size == 0) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var10 = 0;
    var11 = 5000;
    var12 = 500;
  } else {
    var10 = 1;
    var11 = 5000;
    var12 = 500;
  }

  if(true) {
    var10.headicon = var11 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var12, "icon_navbar_enemy", 15, var10, var11, var12, undefined, 1, 1);
  }

  thread marklocation_watchmarkentstatus(var10, var11, var6);
}

function earlyremoveradarperk(var0) {
  self endon("disconnect");
  waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]](var0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]](var0);
        return;
      }

      return;
    }

    return;
  }
}

function marklocation_watchmarkentstatus(var0, var1, var2) {
  level endon("game_ended");
  scripts\engine\utility::ref_143ba(var2, "death", "explode");

  if(isDefined(var0.icon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var0.icon);

    if(isDefined(var1)) {
      var1 delete();
    }
  }

  if(isDefined(var0.target)) {
    var0.target.locationmarked = undefined;
  }

  self.enemiesmarked[var0.targetnum] = undefined;
}

function markent(var0, var1) {
  var2 = var0.target;
  self.enemiesmarked[var0.targetnum] = var0;
  var3 = "hud_icon_head_marked";
  var4 = 8;

  if(isPlayer(var2)) {
    if(false) {
      if(level.teambased) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam")) {
          var0.outlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](var2, "orange", self.owner.team, 0, 1, 0, "killstreak");
        }
      } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForPlayer")) {
        var0.outlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForPlayer")]](var2, "orange", self.owner, 0, 1, 0, "killstreak");
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "hudOutlineViewmodelEnable")) {
        var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "hudOutlineViewmodelEnable")]](5, 0, 1);
      }
    }

    thread markflash();
    markeduion(var2);
    var2 playlocalsound("recon_drone_spotted_plr");
  } else {
    var5 = markent_getweaponicon(var3, var4, var2);
    var3 = var5.weaponicon;
    var4 = var5.weaponoffset;
  }

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var6 = 0;
    var7 = 4000;
    var8 = 500;
  } else {
    var6 = 1;
    var7 = 4000;
    var8 = 500;
  }

  if(true) {
    var3.headicon = var6 scripts\cp_mp\entityheadicons::setheadicon_singleimage([], var7, var8, var6, var7, var8, undefined, 1, 1);
    markupdateheadiconallplayers(var3);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "watchMarkingEntStatus")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "watchMarkingEntStatus")]](var3);
  }

  thread resetreticlemarkingprogressstate(getmarkingdelay(var3.target));
}

function ref_131b7(var0, var1) {
  var2 = 0;

  if(isDefined(var1)) {
    var2 = var1.helperdronetype == "assault_drone";
  }

  if(var0 > 0 && var2) {
    var0 += 4;
  }

  self setclientomnvar("ui_rcd_controls", var0);
  self notify("omnvar_ui_rcd_changed", var0);
}

function ref_131c9(var0, var1, var2) {
  var3 = (var2 >> 0) % 2 == 1;
  var4 = (var2 >> 1) % 2 == 1;
  targetmarkergroupsetextrastate(var0, var1, var3);
  addclienttotargetmarkergroupmask(var0, var1, var4);
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

function markent_getweaponicon(var0, var1, var2) {
  var3 = var0;
  var4 = var1;
  var5 = spawnStruct();

  if(isDefined(var2.weapon_name)) {
    var6 = undefined;

    if(issubstr(var2.weapon_name, "claymore")) {
      var6 = "equip_claymore";
    } else if(issubstr(var2.weapon_name, "c4")) {
      var6 = "equip_c4";
    } else if(issubstr(var2.weapon_name, "atMine")) {
      var6 = "equip_at_mine";
    } else if(issubstr(var2.weapon_name, "trophy")) {
      var6 = "equip_trophy";
    }

    if(isDefined(var6)) {
      var7 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "getEquipmentTableInfo")) {
        var7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "getEquipmentTableInfo")]](var6);
      }

      var3 = var7.image;
    }
  } else if(isDefined(var2.streakinfo)) {
    var8 = var2.streakinfo.streakname;
    var3 = game["killstreakTable"].tabledatabyref[var8]["overheadIcon"];
    var4 = 75;
  }

  var5.weaponicon = var3;
  var5.weaponoffset = var4;
  return var5;
}

function markupdateheadiconallplayers(var0) {
  foreach(var2 in level.players) {
    if(!isDefined(var2)) {
      return;
    }

    markupdateheadicon(var0, var2);
  }
}

function markupdateheadicon(var0, var1) {
  var2 = scripts\mp\utility\player::isfriendly(var0.ownerteam, var1);
  var3 = isDefined(var0.markingent) && isDefined(var0.markingent.owner) && var1 == var0.markingent.owner;
  var4 = isDefined(var0.markingent) && istrue(var0.markingent.ispiloted);
  var5 = var3 && var4;

  if(isDefined(var0.headicon)) {
    if(var2 && !var5) {
      scripts\cp_mp\entityheadicons::ref_1315d(var0.headicon, var1);
      return;
    }

    scripts\cp_mp\entityheadicons::ref_1315e(var0.headicon, var1);
    return;
  }
}

function unmark(var0) {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var0.headicon);

  if(isDefined(var0.target)) {
    var0.reconmarked = undefined;
    var0.beingmarked = undefined;

    if(isDefined(self)) {
      self.enemiesmarked[var0.targetnum] = undefined;
    }

    if(isPlayer(var0.target) && false) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var0.outlineid, var0.target);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "hudOutlineViewmodelDisable")) {
        var0.target[[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "hudOutlineViewmodelDisable")]]();
      }
    }

    var0.target notify(var0.notifytoendmark);
    return;
  }

  if(isDefined(self)) {
    self.enemiesmarked[var0.targetnum] = undefined;
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
  var0 = scripts\engine\utility::ref_143ae("goal", "near_goal", "hit_goal");
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
  var0 = self.maxhealth;
  var1 = level.helperdronesettings[self.helperdronetype];

  for(;;) {
    self waittill("damage", var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15);

    if(isDefined(var3)) {
      if(isDefined(var3.owner)) {
        var3 = var3.owner;
      }

      if(isDefined(var3.team) && var3.team == self.team && var3 != self.owner) {
        continue;
      }
    }

    if(isDefined(var11)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
        var2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var3, var11, var6, var2, var1.maxhealth, 1, 1, 1);
      }
    }

    var0 -= var2;

    if(isPlayer(var3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
        var3[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("");
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakHit")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakHit")]](var3, var11, self, var6, var2);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "logAttackerKillstreak")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "logAttackerKillstreak")]](self, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
      }

      if(var0 <= 0) {
        var3 notify("destroyed_killstreak", var11);
        var16 = var2;
        var17 = self.streakinfo.streakname;
        var18 = undefined;
        var19 = 1;

        if(isDefined(var11)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
            var20 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](self.helperdronetype, var3, var11, var18, var16, var1.scorepop, var1.vodestroyed, var1.destroyedsplash, var19);
          }
        }

        thread helperdroneexplode(1);
      }
    }

    if(var0 <= int(self.maxhealth / 1.2) && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("body_damage_light", "on");
      continue;
    }

    if(var0 <= int(self.maxhealth / 2) && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("body_damage_medium", "on");
      continue;
    }

    if(var0 <= int(self.maxhealth / 3) && self.currentdamagestate == 2) {
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
  var0 = level.helperdronesettings[self.helperdronetype];
  self.timeout = var0.timeout;

  if(!isDefined(self.timeout)) {
    return;
  }

  if(self.timeout > 0) {
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.timeout * 1000));
    wait self.timeout;
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(var0.votimedout, 1);
  thread helperdrone_leave();
}

function helperdrone_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  GscBinSkip4(0x35, "disconnect");
}

function helperdrone_watchownerstatus(var0) {
  self.owner waittill(var0);
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
    var0 = level.helperdronesettings[self.helperdronetype];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGametypeNumLives")) {
      if(istrue(var0.diewithowner) || [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGametypeNumLives")]]() && self.owner.pers["deaths"] == [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGametypeNumLives")]]()) {
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
  level scripts\engine\utility::ref_143a6("round_end_finished", "game_ended", "prematch_cleanup");
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
    var0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
    var0 += (0, 0, 1000);
    self setvehgoalpos(var0, 1);
    self setneargoalnotifydist(100);
    self waittill("near_goal");
    var1 = helperdrone_getpathend();
    self vehicle_setspeed(150, 50);
    self setvehgoalpos(var1, 1);
    self waittill("goal");
    self notify("gone");
    removehelperdrone(self.helperdronetype, level.helperdronesettings[self.helperdronetype], 0);
    return;
  }

  thread helperdroneexplode(0);
}

function helperdrone_getpathend() {
  var0 = 150;
  var1 = 15000;
  var2 = self.angles[1];
  var3 = (0, var2, 0);
  var4 = self.origin + anglesToForward(var3) * var1;
  return var4;
}

function perkengineer_manageminimap() {
  var0 = "icon_minimap_scramblerdrone";
  self.enemyobjid = scripts\mp\objidpoolmanager::createobjective_engineer(var0, 1, 1);

  foreach(var2 in level.players) {
    if(!isPlayer(var2)) {
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_engineer") && var2.team != self.team) {
        if(self.enemyobjid != -1) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.enemyobjid, var2);
        }
      }
    }
  }
}

function helperdrone_modifydamageresponse(var0) {
  helperdrone_modifydamagestates(var0);
  var1 = var0.meansofdeath;
  var2 = var0.damage;

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::isusingremote()) {
    if(isexplosivedamagemod(var1)) {
      if(ceil(var2 / self.maxhealth) >= 0.4) {
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

function helperdrone_modifydamagestates(var0) {
  var1 = var0.damage;
  self.currenthealth = self.health - var1;

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

function helperdrone_stunned(var0) {
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
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  stopFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  self.stunned = 0;
}

function helperdronedestroyed(var0) {
  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return;
  }

  thread helperdroneexplode(1);
  return 0;
}

function helperdroneexplode(var0, var1) {
  self.isdestroyed = 1;
  var2 = level.helperdronesettings[self.helperdronetype];
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

  if(istrue(var1)) {
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
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self.streakinfo.superid, self.usedcount, istrue(var0));
    }
  }

  waitframe();
  var3 = self.owner;
  removehelperdrone(self.helperdronetype, level.helperdronesettings[self.helperdronetype], var0);

  if(level.gametype != "br" && isDefined(var3) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "superSlotCleanUp")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "superSlotCleanUp")]](var3);
    return;
  }
}

function spawn_aitype() {
  var0 = level.helperdronesettings[self.helperdronetype];

  if(isDefined(var0.fxid_explode)) {
    playFX(var0.fxid_explode, self.origin);
  }

  if(isDefined(var0.sound_explode)) {
    self playSound(var0.sound_explode);
    return;
  }
}

function spawn_ai_solo() {
  var0 = level.helperdronesettings[self.helperdronetype];
  self setscriptablepartstate("explode", "detonate");
  var1 = scripts\common\utility::playersinsphere(self.origin, 2000);

  foreach(var3 in var1) {
    if(!isDefined(var3) || !var3 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(self.owner) && var3 == self.owner) {
      continue;
    }

    var3 earthquakeforplayer(0.3, 2, var3.origin, 100);
    var3 setclientomnvar("ui_hud_shake", 1);
    var3 playrumbleonpositionforclient("artillery_rumble_light", var3.origin);
  }

  if(isDefined(self.owner)) {
    self.owner earthquakeforplayer(0.2, 2, self.owner.origin, 100);
    self.owner setclientomnvar("ui_hud_shake", 1);
    self.owner playrumbleonpositionforclient("artillery_rumble_light", self.owner.origin);
    return;
  }
}

function removehelperdrone(var0, var1, var2) {
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
    foreach(var4 in self.pulsedarts) {
      var4 notify("death");
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

    if(var0 == "radar_drone_escort" || var0 == "radar_drone_overwatch") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap")) {
        self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
      }
    }

    self.streakinfo.onspray = istrue(var2);
    self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
  }

  if(var0 == "scrambler_drone_guard") {
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

function helperdrone_returnplayer(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = self.helperdronetype;
  var2 = level.helperdronesettings[var1];

  if(isDefined(self.targetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.targetmarkergroup);
    self.targetmarkergroup = undefined;
  }

  self.ispiloted = undefined;

  if(isDefined(self.enemiesmarked)) {
    foreach(var4 in self.enemiesmarked) {
      markupdateheadicon(var4, var0);
    }
  }

  thread recondrone_takedeployweapon(var0, !isalive(var0));
  helperdrone_takeplayerfauxremote(var0, self.streakinfo);
  var0 painvisionon();
  var0 scripts\common\utility::allow_usability(1);
  var0 scripts\common\utility::allow_fire(1);
  thread soundorg_int();
  var0 cameraunlink(self);
  var0 remotecontrolvehicleoff();
  scripts\cp_mp\utility\killstreak_utility::ref_11dc1(var0);

  if(isDefined(var0.restoreangles)) {
    var0 setplayerangles((var0.restoreangles[0], var0.restoreangles[1], 0));
    var0.restoreangles = undefined;
  }

  var0 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
}

function soundorg_int() {
  level endon("game_ended");
  self endon("disconnect");
  var0 = gettime();
  var1 = 1000;

  while(gettime() - var0 < var1) {
    ref_131b7(0);
    waitframe();
  }
}

function exceededmaxhelperdrones(var0, var1) {
  if(!isDefined(level.supportdrones)) {
    return false;
  }

  if(level.incominghelperdrones.size > 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
      if(level.incominghelperdrones.size >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
        return true;
      }
    }

    foreach(var3 in level.incominghelperdrones) {
      if(isDefined(var3.owner) && var3.owner == var1) {
        continue;
      }

      if(var0.streakname == "radar_drone_recon" && var3.type == var0.streakname) {
        if(level.teambased) {
          if(isDefined(var3.owner) && isDefined(var3.owner.team) && var3.owner.team == var1.team) {
            return true;
          }
        }

        continue;
      }

      if(var0.streakname == "assault_drone" && var3.type == var0.streakname) {
        if(level.teambased) {
          if(isDefined(var3.owner) && isDefined(var3.owner.team) && var3.owner.team == var1.team) {
            return true;
          }
        }

        continue;
      }

      if(var0.streakname == "radar_drone_overwatch" && var3.type == var0.streakname) {
        if(level.teambased) {
          if(helperdrone_getnumdrones("radar_drone_overwatch", level.incominghelperdrones, var1.team) >= 10) {
            return true;
          }
        }

        if(helperdrone_getnumdrones("radar_drone_overwatch", level.incominghelperdrones) >= 20) {
          return true;
        }

        continue;
      }

      if(var0.streakname == "scrambler_drone_guard" && var3.type == var0.streakname) {
        if(level.teambased) {
          if(helperdrone_getnumdrones("scrambler_drone_guard", level.incominghelperdrones, var1.team) >= 10) {
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

    foreach(var3 in level.supportdrones) {
      if(var0.streakname == "radar_drone_escort" && var3.helperdronetype == var0.streakname) {
        if(isDefined(var3.owner) && var3.owner == var1) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/COMPANION_ALREADY_EXISTS");
          }

          return true;
        }

        continue;
      }

      if(var0.streakname == "radar_drone_recon" && var3.helperdronetype == var0.streakname) {
        if(level.teambased) {
          if(var3.team == var1.team) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
              var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
            }

            return true;
          }
        }

        continue;
      }

      if(var0.streakname == "assault_drone" && var3.helperdronetype == var0.streakname) {
        if(level.teambased) {
          if(var3.team == var1.team) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
              var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
            }

            return true;
          }
        }

        continue;
      }

      if(var0.streakname == "radar_drone_overwatch" && var3.helperdronetype == var0.streakname) {
        if(helperdrone_getnumdrones("radar_drone_overwatch", level.supportdrones) >= 20) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
          }

          return true;
        }

        if(level.teambased) {
          if(helperdrone_getnumdrones("radar_drone_overwatch", level.supportdrones, var1.team) >= 10) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
              var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_PERSONAL_RADAR");
            }

            return true;
          }
        }

        if(helperdrone_getnumdrones("radar_drone_overwatch", level.supportdrones, var1) >= 1) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/PERSONAL_RADAR_ALREADY_ACTIVE");
          }

          return true;
        }

        continue;
      }

      if(var0.streakname == "scrambler_drone_guard" && var3.helperdronetype == var0.streakname) {
        if(level.teambased) {
          if(helperdrone_getnumdrones("scrambler_drone_guard", level.supportdrones, var1.team) >= 10) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
              var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_COUNTER_UAV");
            }

            return true;
          }

          continue;
        }

        if(helperdrone_getnumdrones("scrambler_drone_guard", level.supportdrones, var1) >= 2) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_COUNTER_UAV");
          }

          return true;
        }
      }
    }
  }

  return false;
}

function helperdrone_getnumdrones(var0, var1, var2) {
  var3 = 0;

  foreach(var5 in var1) {
    if(isDefined(var5.type) && var5.type == var0 || isDefined(var5.helperdronetype) && var5.helperdronetype == var0) {
      if(isDefined(var2)) {
        if(isPlayer(var2)) {
          if(var5.owner != var2) {
            continue;
          }
        } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isGameplayTeam") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isGameplayTeam")]](var2)) {
          if(var5.team != var2) {
            continue;
          }
        }
      }

      var3++;
    }
  }

  return var3;
}

function helperdrone_destroyongameend() {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  level scripts\engine\utility::ref_143a6("bro_shot_start", "game_ended", "ending_sequence");
  helperdronedestroyed();
}

function spawn_ai_and_seat_in_vehicle(var0) {
  self endon("game_ended");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  var1 = getdvarfloat("br_recon_altitude_envelope", 1500);
  var2 = getdvarfloat("br_recon_altitude_warn", 5600);
  var3 = var1 + var2;
  var4 = 0;
  var5 = 0;

  for(;;) {
    if(self.origin[2] > var2) {
      if(self.origin[2] > var3) {
        var0 setclientomnvar("ui_out_of_range", 0);
        helperdronedestroyed();
      }

      var4 = (self.origin[2] - var2) / var1;
    } else {
      var4 = 0;
    }

    if(var4 != var5) {
      var5 = var4;
      var0 setclientomnvar("ui_out_of_range", var4);
    }

    waitframe();
  }
}

function helperdrone_gettargetoffset(var0, var1) {
  var2 = level.helperdronesettings[var0.helperdronetype];
  var3 = var2.backoffset;
  var4 = var2.sideoffset;
  var5 = helperdrone_getheightoffset(var0, var2);

  if(isDefined(var0.low_entry)) {
    var5 *= var0.low_entry;
  }

  var6 = (var4, var3, var5);
  return var6;
}

function helperdrone_istargetinreticle(var0, var1, var2) {
  var3 = 0;
  var4 = var0.origin;

  if(isDefined(var0.ref_12a9c)) {
    var4 += var0.ref_12a9c;
  }

  var5 = [var4];

  if(isPlayer(var0)) {
    var6 = var0 scripts\mp\utility\player::round_smoke_logic();
    var7 = var0 scripts\mp\utility\player::getstancecenter();
    var5 = [var6, var7, var4];
  } else if(isagent(var0)) {
    var5 = [var4 + (0, 0, 1)];
  }

  foreach(var9 in var5) {
    if(self worldpointinreticle_circle(var9, var1, var2)) {
      var3 = 1;
      break;
    }
  }

  return var3;
}

function find_safe_spawn(var0) {
  var1 = self.angles;
  var2 = (0, 0, 80);
  var3 = level.helperdronesettings[var0].spawndist;
  var4 = (0, 0, var2[2]);
  var5 = level.helperdronesettings[var0].halfsize;
  var6 = anglesToForward(self.angles);
  var7 = anglestoright(self.angles);
  var8 = self.origin + (0, 0, 30);
  var9 = var3 + 20;

  if(self getstance() == "prone") {
    var9 += 25;
  }

  if(_calloutmarkerping_handleluinotify_enemyrepinged::ref_124f5()) {
    var4 += (0, 0, 130);
  }

  var10 = [var4 + var3 * var6, var4 - var3 * var6, var4 + var3 * var7, var4 - var3 * var7, var4, var4 + 0.707 * var3 * (var6 + var7), var4 + 0.707 * var3 * (var6 - var7), var4 + 0.707 * var3 * (var7 - var6), var4 + 0.707 * var3 * (-1 * var6 - var7), var9 * var6, -1 * var9 * var6, var9 * var7, -1 * var9 * var7, (0, 0, 0), 0.707 * var9 * (var6 + var7), 0.707 * var9 * (var6 - var7), 0.707 * var9 * (var7 - var6), 0.707 * var9 * (-1 * var6 - var7)];
  var11 = 0;

  for(var12 = 0; var12 < var10.size; var12++) {
    if(4 <= var11) {
      var11 = 0;
      wait 0.05;
    }

    var13 = var10[var12];
    var14 = var8 + var13;
    var15 = vectorNormalize(var13) * 50;
    var16 = var8 + var15;
    var17 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var18 = scripts\engine\trace::ray_trace(var8, var16, self, var17);

    if(var18["hittype"] != "hittype_none") {
      continue;
    }

    var19 = scripts\engine\trace::sphere_trace(var16, var14, var5, self, var17);
    var20 = var19["fraction"];
    var21 = var20 * (var14 - var16);
    var22 = var16 + var21;

    if(var20 > 0) {
      self.recondronesafespawn = var22;
      return var22;
    }

    var11++;
  }

  return undefined;
}

function helperdrone_giveplayerfauxremote(var0) {
  self endon("disconnect ");
  scripts\cp_mp\utility\player_utility::setusingremote(var0.streakname);
  scripts\common\utility::allow_weapon_switch(0);
}

function helperdrone_takeplayerfauxremote(var0) {
  scripts\cp_mp\utility\player_utility::clearusingremote(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_offhand_weapons(1);
  var0 notify("killstreak_finished_with_deploy_weapon");
  var1 = getcompleteweaponname("ks_remote_drone_mp");

  if(self hasweapon(var1)) {
    thread scripts\cp_mp\utility\inventory_utility::getridofweapon(var1);
    return;
  }
}

function helperdrone_showminimaponspawn(var0) {
  self endon("disconnect");
  var0 endon("death");
  var0 endon("explode");
  var0 endon("leaving");
  level endon("game_ended");
  var1 = self.guid;
  level notify("helperDrone_show_minimap_" + var1);
  level endon("helperDrone_show_minimap_" + var1);

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
  var0 = spawnStruct();
  var0.streakname = "radar_drone_recon";
  var0.weaponname = "ks_remote_drone_mp";
  var0.issuper = 1;
  var0.superid = level.superglobals.staticsuperdata["super_recon_drone"].id;

  if(!tryusehelperdroneearlyout(var0, 1)) {
    self.recondronereserved = 1;
    thread recondrone_watchcleanupreserved(var0, 0);

    if(scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
      self.reconvehiclereserved = 1;
      thread recondrone_watchcleanupreserved(var0, 1);

      if(recondrone_givedeployweapon()) {
        thread recondrone_watchsuper(var0);
        return true;
      } else {
        thread recondrone_takedeployweapon(undefined, 1);
        thread recondrone_cleanupreserved(var0, 1);
      }
    } else {
      thread recondrone_cleanupreserved(var0, 0);
    }
  }

  return false;
}

function recondrone_endsuper(var0) {
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
    var1 = spawnStruct();
    var1.streakname = "radar_drone_recon";
    recondrone_cleanupreserved(var1);
  }

  if(isDefined(self.reconvehiclereserved)) {
    self.reconvehiclereserved = undefined;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return;
  }
}

function recondrone_watchsuper(var0) {
  self endon("disconnect");
  var1 = ref_12a98(var0);

  if(!isDefined(var1)) {
    thread recondrone_takedeployweapon(!isalive(self), 1);
    return;
  }

  if(!var1) {
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

function ref_12a98(var0) {
  self endon("death");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  thread recondrone_watchsuperendfromswitch();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helperDrone", "onReconDroneSuperStarted")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("helperDrone", "onReconDroneSuperStarted")]]();
  }

  thread recondrone_disablecontrols(2.15);
  wait 1.85;
  GscBinSkip4(0x35, var0.streakname);
}

function recondrone_disablecontrols(var0) {
  self endon("death_or_disconnect");

  if(istrue(level.mine_caves_turrets)) {
    self freezecontrols(1);
  } else {
    scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "reconDrone");
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);

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
  var0 = getcompleteweaponname("ks_remote_drone_mp");

  for(;;) {
    if(self getcurrentweapon() != var0) {
      break;
    }

    waitframe();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
    return;
  }
}

function recondrone_unsetsuper(var0) {
  self notify("reconDroneUnset");

  if(false) {
    var1 = self.recondronesuper;

    if(isDefined(var1)) {
      if(!istrue(var1.isdestroyed)) {
        helperdronedestroyed(var1);
      }
    }
  }

  thread recondrone_endsuper(var0);
}

function recondrone_givedeployweapon() {
  self endon("death_or_disconnect");
  self endon("reconDroneWeaponTaken");
  self notify("reconDroneWeaponGiven");
  self endon("reconDroneWeaponGiven");
  var0 = getcompleteweaponname("ks_remote_drone_mp");

  if(!self hasweapon(var0)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var0);
  }

  recondrone_allowcontrols(0);
  var1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var0, 1);
  return var1;
}

function recondrone_takedeployweapon(var0, var1) {
  self endon("death_or_disconnect");
  self endon("reconDroneWeaponGiven");
  self notify("reconDroneWeaponTaken");
  self endon("reconDroneWeaponTaken");
  var2 = getcompleteweaponname("ks_remote_drone_mp");

  if(istrue(var1)) {
    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var2)) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var2);
      return;
    }
  }

  recondrone_allowcontrols(1, var0);

  if(istrue(var1)) {
    scripts\cp_mp\utility\inventory_utility::getridofweapon(var2);
    return;
  }
}

function recondrone_allowcontrols(var0, var1) {
  var1 = istrue(var1);

  if(var0) {
    if(!isDefined(self.recondronefrozecontrols)) {
      return;
    }

    if(!var1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "allow_equipment")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "allow_equipment")]](var0);
      }

      scripts\common\utility::allow_usability(var0);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "allowGesture")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "allowGesture")]](var0);
      }
    }

    self.recondronefrozecontrols = undefined;
    return;
  }

  if(isDefined(self.recondronefrozecontrols)) {
    return;
  }

  if(!var1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "allow_equipment")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "allow_equipment")]](var0);
    }

    scripts\common\utility::allow_usability(var0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "allowGesture")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "allowGesture")]](var0);
    }
  }

  self.recondronefrozecontrols = 1;
}

function recondrone_watchcleanupreserved(var0, var1) {
  self notify("reconDrone_cleanupReserved");
  self endon("reconDrone_cleanupReserved");
  self waittill("disconnect");
  thread recondrone_cleanupreserved(var0, var1);
}

function recondrone_cleanupreserved(var0, var1) {
  self notify("reconDrone_cleanupReserved");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]](1);
  }

  removeincominghelperdrone(var0);

  if(istrue(var1)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return;
  }
}

function recondrone_addtolists(var0, var1) {
  var1.recondronesuper = var0;
  var1.pausesuperpointsovertime = 1;
  var2 = var0 getentitynumber();

  if(!isDefined(level.recondronesupers)) {
    level.recondronesupers = [];
  }

  level.recondronesupers[var2] = var0;
  thread recondrone_removefromlistsondeath(var0, var1, var2);
}

function recondrone_removefromlists(var0, var1, var2) {
  if(isDefined(var0)) {
    var0 notify("reconDrone_removeFromLists");
    var2 = var0 getentitynumber();
  }

  if(isDefined(var1)) {
    var1.recondronesuper = undefined;
    var1.pausesuperpointsovertime = 0;
  }

  if(isDefined(level.recondronesupers)) {
    level.recondronesupers[var2] = undefined;
    return;
  }
}

function recondrone_removefromlistsondeath(var0, var1, var2) {
  var0 endon("reconDrone_removeFromLists");
  var0 waittill("death");
  thread recondrone_removefromlists(var0, var1, var2);
}

function deliverydrone_delivertopoint(var0, var1) {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  var2 = spawnStruct();
  var2.streakname = "ammo_drop";
  var2.issuper = 1;

  if(tryusehelperdroneearlyout(var2, 1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    removeincominghelperdrone(var2);
    return undefined;
  }

  var3 = var0 + (0, 0, 4000) - anglesToForward(self.angles) * 0;
  var4 = createhelperdrone(var3, self.angles, var2.streakname, var2);

  if(!isDefined(var4)) {
    return undefined;
  }

  removeincominghelperdrone(var2);
  var4.deliverytarget = var0;
  var4.ondelivercallback = var1;
  thread starthelperdrone(var4);
  return var4;
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
  var0 = 0;

  for(;;) {
    if(isDefined(level.outofboundstriggers)) {
      var1 = 0;

      foreach(var3 in level.outofboundstriggers) {
        if(!isDefined(var3)) {
          continue;
        }

        if(var3.classname == "trigger_radius") {
          continue;
        }

        if(self istouching(var3)) {
          var1 = 1;
          break;
        }
      }

      if(var1) {
        var0 += 1 * level.framedurationseconds;
      } else {
        var0 -= 2 * level.framedurationseconds;
      }

      var0 = clamp(var0, 0, 0.5);
      self.owner setclientomnvar("ui_out_of_range", var0);
    }

    waitframe();
  }
}

function istargetmarked() {
  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(var1 in level.supportdrones) {
      if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, var1.owner))) {
        if(isDefined(var1.enemiesmarked) && isDefined(var1.enemiesmarked[self getentitynumber()])) {
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