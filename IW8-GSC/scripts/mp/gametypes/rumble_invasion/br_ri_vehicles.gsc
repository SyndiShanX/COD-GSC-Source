/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_vehicles.gsc
*******************************************************************/

function ref_14216(var_0) {
  var_1 = spawnStruct();
  var_2 = scripts\engine\utility::getStruct("launch_code_drop_button", "targetname");
  var_1.origin = var_2.origin + (0, 0, 50000);

  if(isDefined(var_0)) {
    var_2.origin = var_0;
  }

  var_3 = scripts\mp\gametypes\br_gametype_truckwar::ref_14263(var_1);

  if(isDefined(var_3)) {
    level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13de4(var_3, var_2.origin, var_3.angles, 1);
    return;
  }
}

function ref_13570() {
  level endon("game_ended");
  var_0 = 0;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    if(getdvarint("scr_ri_spawn_vehicles_in_prematch", 1) == 1) {
      var_0 = 1;
    }
  } else {
    var_0 = 1;
  }

  if(!var_0) {
    return;
  }

  if(getdvarint("scr_ri_default_veh_spawns", 0)) {
    scripts\mp\gametypes\br_vehicles::spawninitialvehicles();
    return;
  }

  if(!isDefined(level.start_reach_exhaust_waste.ref_12e2c.ref_141be)) {
    return;
  }

  foreach(var_2 in level.start_reach_exhaust_waste.ref_12e2c.ref_141be) {
    var_3 = spawnStruct();
    var_3.ref = var_2[0];
    var_3.origin = var_2[1];
    var_3.angles = var_2[2];
    var_3.ref_13a22 = var_4;
    thread ref_1421b(level);
  }
}

function ref_12b07(var_0) {
  level.start_reach_exhaust_waste.spawned_vehicles[var_0.ref_1352e.ref_13a22] = var_0;
}

function lasttuttxt(var_0) {
  level.start_reach_exhaust_waste.spawned_vehicles[var_0.ref_1352e.ref_13a22] = undefined;
}

function ref_1421b(var_0) {
  if(var_0.ref == "aa_turret") {
    if(isDefined(level.arenaflag_setenabled)) {
      var_1 = var_0[[level.arenaflag_setenabled]]();

      if(isDefined(var_1)) {
        var_1.ref_1352e = var_0;
        var_2 = var_0.origin;
        var_2 -= anglesToForward(var_0.angles) * 5;
        var_3 = easepower("veh_s4_mil_lnd_turret_quad_aa_wz_clip_dyn", var_2, var_0.angles);
        var_3 setscriptablepartstate("clip", "enabled");
        var_1.clip = var_3;
        return;
      }

      return;
    }

    return;
  }

  var_4 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle(var_1.ref, var_1);

  if(isDefined(var_4)) {
    var_4.ref_1352e = var_1;

    if(scripts\mp\flags::gameflag("prematch_done")) {
      ref_12b07(var_4);
      thread vehicle_death_watcher();
      thread ref_141c5();
      return;
    }

    return;
  }
}

function ref_1420b(var_0) {
  level endon("game_ended");
  wait 45;
  ref_1421b(var_0);
}

function ref_141c5() {
  level endon("game_ended");
  self endon("death");
  self endon("vehicle_pending_respawn");
  var_0 = self.origin;
  var_1 = 1500;
  var_2 = getdvarfloat("scr_ri_veh_neglect_duration", 30);
  self.ref_11e49 = undefined;
  self.ref_11e4a = 0;
  self.ref_1381c = undefined;
  self.mp_layover_patch = undefined;

  for(;;) {
    self.loot_nag = distance2d(var_0, self.origin);
    self.ref_141fa = isDefined(self getvehicleowner());

    if(!self.ref_11e4a && self.loot_nag > var_1 && !self.ref_141fa) {
      self.ref_1381c = gettime();
      self.mp_layover_patch = gettime() + var_2 * 1000;
      self.ref_11e4a = 1;
    } else if(self.ref_11e4a && self.ref_141fa) {
      self.ref_11e4a = 0;
      self.ref_1381c = undefined;
      self.mp_layover_patch = undefined;
      self.ref_11e49 = undefined;
    }

    if(isDefined(self.ref_1381c) && isDefined(self.mp_layover_patch)) {
      var_3 = gettime();
      self.ref_11e49 = (self.mp_layover_patch - var_3) / 1000;
      var_4 = 0;

      if(var_3 >= self.mp_layover_patch) {
        foreach(var_6 in level.players) {
          if(distance(var_6.origin, self.origin) < var_1) {
            self.mp_layover_patch = var_3 + var_2 / 2 * 1000;
            var_4 = 1;
            break;
          }
        }

        if(!var_4) {
          var_8 = self.health * 0.95;
          self dodamage(var_8, self.origin);
          break;
        }
      }
    }

    wait 1;
  }
}

function vehicle_death_watcher() {
  level endon("game_ended");
  self endon("end_death_watcher");
  var_0 = self.ref_1352e;
  self waittill("death");
  self notify("vehicle_pending_respawn");
  lasttuttxt(self);
  ref_1420b(var_0);
}

function ref_141b6() {
  return self.vehiclename == "veh_a10fd" || self.vehiclename == "veh_bt";
}

function ref_141b5() {
  return self.vehiclename == "veh_a10fd";
}

function ref_12d35() {
  level endon("match_start_reset_aa_turrets");
  level endon("game_ended");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  var_0 = (0, 0, 60);
  var_1 = self.origin + var_0;
  var_1 -= anglesToForward(self.angles) * 28;
  self.useownerobj = scripts\mp\gameobjects::createhintobject(var_1, "HINT_BUTTON", undefined, &"BR_RUMBLE_INVASION/REPAIR_TURRET", -1, "duration_none", undefined, 100, 60, 60, 60);

  for(;;) {
    self.useownerobj waittill("trigger", var_2);

    if(isDefined(var_2) && var_2.plundercount >= 5) {
      break;
    }

    playsoundatpos(self.useownerobj.origin, "ui_select_purchase_deny");
  }

  self.useownerobj delete();
  var_2 scripts\mp\gametypes\br_plunder::ref_1261e(5);
  playsoundatpos(self.origin, "ui_select_purchase_confirm");
  var_2 thread scripts\mp\hud_message::showsplash("aa_turret_repaired");
  var_2 thread scripts\mp\rank::giverankxp("ri_turret_repaired", 25, var_2 getcurrentprimaryweapon());
  var_2 thread scripts\mp\rank::scoreeventpopup("ri_turret_repaired");
  var_3 = spawnStruct();
  var_3.origin = self.origin;
  var_3.angles = self.angles;

  if(isDefined(level.arenaknivesout)) {
    level.arenaknivesout = scripts\engine\utility::array_remove(level.arenaknivesout, self);
  }

  if(isDefined(level.arenaflag_setenabled)) {
    var_3[[level.arenaflag_setenabled]]();
  }

  self delete();
}