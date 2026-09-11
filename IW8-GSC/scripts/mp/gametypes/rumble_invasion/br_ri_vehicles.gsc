/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_vehicles.gsc
*******************************************************************/

function ref_14216(var0) {
  var1 = spawnStruct();
  var2 = scripts\engine\utility::getStruct("launch_code_drop_button", "targetname");
  var1.origin = var2.origin + (0, 0, 50000);

  if(isDefined(var0)) {
    var2.origin = var0;
  }

  var3 = scripts\mp\gametypes\br_gametype_truckwar::ref_14263(var1);

  if(isDefined(var3)) {
    level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13de4(var3, var2.origin, var3.angles, 1);
    return;
  }
}

function ref_13570() {
  level endon("game_ended");
  var0 = 0;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    if(getdvarint("scr_ri_spawn_vehicles_in_prematch", 1) == 1) {
      var0 = 1;
    }
  } else {
    var0 = 1;
  }

  if(!var0) {
    return;
  }

  if(getdvarint("scr_ri_default_veh_spawns", 0)) {
    scripts\mp\gametypes\br_vehicles::spawninitialvehicles();
    return;
  }

  if(!isDefined(level.start_reach_exhaust_waste.ref_12e2c.ref_141be)) {
    return;
  }

  foreach(var2 in level.start_reach_exhaust_waste.ref_12e2c.ref_141be) {
    var3 = spawnStruct();
    var3.ref = var2[0];
    var3.origin = var2[1];
    var3.angles = var2[2];
    var3.ref_13a22 = var4;
    thread ref_1421b(level);
  }
}

function ref_12b07(var0) {
  level.start_reach_exhaust_waste.spawned_vehicles[var0.ref_1352e.ref_13a22] = var0;
}

function lasttuttxt(var0) {
  level.start_reach_exhaust_waste.spawned_vehicles[var0.ref_1352e.ref_13a22] = undefined;
}

function ref_1421b(var0) {
  if(var0.ref == "aa_turret") {
    if(isDefined(level.arenaflag_setenabled)) {
      var1 = var0[[level.arenaflag_setenabled]]();

      if(isDefined(var1)) {
        var1.ref_1352e = var0;
        var2 = var0.origin;
        var2 -= anglesToForward(var0.angles) * 5;
        var3 = easepower("veh_s4_mil_lnd_turret_quad_aa_wz_clip_dyn", var2, var0.angles);
        var3 setscriptablepartstate("clip", "enabled");
        var1.clip = var3;
        return;
      }

      return;
    }

    return;
  }

  var4 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle(var1.ref, var1);

  if(isDefined(var4)) {
    var4.ref_1352e = var1;

    if(scripts\mp\flags::gameflag("prematch_done")) {
      ref_12b07(var4);
      thread vehicle_death_watcher();
      thread ref_141c5();
      return;
    }

    return;
  }
}

function ref_1420b(var0) {
  level endon("game_ended");
  wait 45;
  ref_1421b(var0);
}

function ref_141c5() {
  level endon("game_ended");
  self endon("death");
  self endon("vehicle_pending_respawn");
  var0 = self.origin;
  var1 = 1500;
  var2 = getdvarfloat("scr_ri_veh_neglect_duration", 30);
  self.ref_11e49 = undefined;
  self.ref_11e4a = 0;
  self.ref_1381c = undefined;
  self.mp_layover_patch = undefined;

  for(;;) {
    self.loot_nag = distance2d(var0, self.origin);
    self.ref_141fa = isDefined(self getvehicleowner());

    if(!self.ref_11e4a && self.loot_nag > var1 && !self.ref_141fa) {
      self.ref_1381c = gettime();
      self.mp_layover_patch = gettime() + var2 * 1000;
      self.ref_11e4a = 1;
    } else if(self.ref_11e4a && self.ref_141fa) {
      self.ref_11e4a = 0;
      self.ref_1381c = undefined;
      self.mp_layover_patch = undefined;
      self.ref_11e49 = undefined;
    }

    if(isDefined(self.ref_1381c) && isDefined(self.mp_layover_patch)) {
      var3 = gettime();
      self.ref_11e49 = (self.mp_layover_patch - var3) / 1000;
      var4 = 0;

      if(var3 >= self.mp_layover_patch) {
        foreach(var6 in level.players) {
          if(distance(var6.origin, self.origin) < var1) {
            self.mp_layover_patch = var3 + var2 / 2 * 1000;
            var4 = 1;
            break;
          }
        }

        if(!var4) {
          var8 = self.health * 0.95;
          self dodamage(var8, self.origin);
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
  var0 = self.ref_1352e;
  self waittill("death");
  self notify("vehicle_pending_respawn");
  lasttuttxt(self);
  ref_1420b(var0);
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

  var0 = (0, 0, 60);
  var1 = self.origin + var0;
  var1 -= anglesToForward(self.angles) * 28;
  self.useownerobj = scripts\mp\gameobjects::createhintobject(var1, "HINT_BUTTON", undefined, &"BR_RUMBLE_INVASION/REPAIR_TURRET", -1, "duration_none", undefined, 100, 60, 60, 60);

  for(;;) {
    self.useownerobj waittill("trigger", var2);

    if(isDefined(var2) && var2.plundercount >= 5) {
      break;
    }

    playsoundatpos(self.useownerobj.origin, "ui_select_purchase_deny");
  }

  self.useownerobj delete();
  var2 scripts\mp\gametypes\br_plunder::ref_1261e(5);
  playsoundatpos(self.origin, "ui_select_purchase_confirm");
  var2 thread scripts\mp\hud_message::showsplash("aa_turret_repaired");
  var2 thread scripts\mp\rank::giverankxp("ri_turret_repaired", 25, var2 getcurrentprimaryweapon());
  var2 thread scripts\mp\rank::scoreeventpopup("ri_turret_repaired");
  var3 = spawnStruct();
  var3.origin = self.origin;
  var3.angles = self.angles;

  if(isDefined(level.arenaknivesout)) {
    level.arenaknivesout = scripts\engine\utility::array_remove(level.arenaknivesout, self);
  }

  if(isDefined(level.arenaflag_setenabled)) {
    var3[[level.arenaflag_setenabled]]();
  }

  self delete();
}