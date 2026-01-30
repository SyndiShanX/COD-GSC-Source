/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_ammo_drone.gsc
*************************************************/

init() {
  level._effect["ammo_drone_drops_credits"] = loadfx("vfx/props/dlc_cash_drone_drop");
  level._effect["ammo_drone_drops_ammo"] = loadfx("vfx/shelleject/dlc_drone_drop_shell_eject_loop");
  level._effect["ammo_drone_thruster"] = loadfx("vfx/vehicle/dlc_drone_thrusters_small");
  level._effect["ammo_drone_drops_explode"] = loadfx("vfx/sparks/welding_sparks_a");
  level._effect["ammo_drone_explode"] = loadfx("vfx/explosion/tracking_drone_explosion");
  level thread findammodronespawnlocations();
  level thread roundlogic();
}

findammodronespawnlocations() {
  while(!isDefined(level.zone_data)) {
    waitframe();
  }

  while(!isDefined(level.closetpathnodescalculated) || !level.closetpathnodescalculated) {
    waitframe();
  }

  foreach(var_1 in level.zone_data.zones) {
    if(!isDefined(var_1.volumes)) {
      continue;
    }
    if(isDefined(level.ammodroneillegalzones)) {
      if(common_scripts\utility::array_contains(level.ammodroneillegalzones, var_1.zone_name)) {
        continue;
      }
    }

    var_2 = var_1.volumes[randomint(var_1.volumes.size)];
    var_3 = getnodesintrigger(var_2);

    if(!isDefined(var_1.ammodronespawnnodes)) {
      var_1.ammodronespawnnodes = [];
    }

    foreach(var_5 in var_3) {
      if(!var_5 nodeisdisconnected() && isDefined(var_5.zombieszone)) {
        var_1.ammodronespawnnodes[var_1.ammodronespawnnodes.size] = var_5;
      }
    }

    if(!isDefined(var_1.ammodroneleavenodes)) {
      var_1.ammodroneleavenodes = [];
    }

    foreach(var_5 in var_3) {
      if(nodegetremotemissilename(var_5) != "none") {
        var_1.ammodroneleavenodes[var_1.ammodroneleavenodes.size] = var_5;
      }
    }
  }
}

roundlogic() {
  var_0 = randomintrange(3, 5);
  level.ammodroneactive = 0;

  for(;;) {
    level waittill("zombie_wave_started");

    if(level.wavecounter >= var_0 && !atvehiclelimit()) {
      var_1 = startammodrone();

      if(var_1) {
        var_0 = level.wavecounter + randomintrange(3, 5);
      }
    }
  }
}

atvehiclelimit() {
  return maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed();
}

startammodrone(var_0, var_1, var_2, var_3) {
  level.ammodroneactive = 1;

  if(!isDefined(level.numammodronesencountered)) {
    level.numammodronesencountered = 0;
  }

  if(!isDefined(var_0)) {
    var_0 = getstartzone();
  }

  if(!isDefined(var_1)) {
    var_1 = var_0.ammodronespawnnodes[randomint(var_0.ammodronespawnnodes.size)];
  }

  maps\mp\_utility::incrementfauxvehiclecount();
  level.numammodronesencountered++;
  level.ammodrone = spawnammodrone(var_1.origin, (0, 0, 0));

  if(!isDefined(level.ammodrone)) {
    maps\mp\_utility::decrementfauxvehiclecount();
    level.numammodronesencountered--;
    return 0;
  }

  if(isDefined(level.players[0])) {
    level.players[0] thread maps\mp\_matchdata::loggameevent("zm_tr_drone_spawn", var_1.origin);
  }

  level.ammodrone.startnode = var_1;
  level.ammodrone.startzone = var_0;
  level.ammodrone.linegunignore = 1;
  level notify("zombie_ammo_drone_spawn", level.ammodrone, var_0, var_1);
  var_4 = waittillactivate(level.ammodrone, var_0);

  if(isDefined(var_4)) {
    var_4 playerspottreasuredrone();
  }

  var_5 = getdestinationzone(var_0);
  var_6 = getdestinationnode(var_5, var_1);

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  if(isDefined(var_3)) {
    var_6 = var_3;
  }

  level.ammodrone.endnode = var_6;
  level.ammodrone.endzone = var_5;

  if(isDefined(level.players[0])) {
    level.players[0] thread maps\mp\_matchdata::loggameevent("zm_tr_drone_active", var_1.origin);
  }

  level notify("zombie_ammo_drone_activate", level.ammodrone, var_5, var_6);
  droneactivate(level.ammodrone, var_5, var_6);
  level.ammodroneactive = 0;
  level.ammodrone = undefined;
  return 1;
}

getstartzone() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.zone_data.zones) {
    if(isDefined(var_3.ammodronespawnnodes) && isDefined(var_3.ammodroneleavenodes)) {
      var_0[var_0.size] = var_3;

      if(var_3.ammodronespawnnodes.size > 0 && var_3.ammodroneleavenodes.size == 0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  var_5 = [];

  foreach(var_3 in var_1) {
    if(!maps\mp\zombies\_zombies_zone_manager::isplayerinzone(var_3.zone_name)) {
      var_5[var_5.size] = var_3;
    }
  }

  var_8 = undefined;

  if(var_5.size > 0) {
    var_8 = var_5[randomint(var_5.size)];
  } else if(var_1.size > 0) {
    var_8 = var_1[randomint(var_1.size)];
  } else {
    var_8 = common_scripts\utility::random(var_0);
  }

  return var_8;
}

getdestinationzone(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.zone_data.zones) {
    if(var_4.zone_name != var_0.zone_name && (!isDefined(var_1) || var_4.zone_name != var_1.zone_name) && maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_4.zone_name) && isDefined(var_4.ammodroneleavenodes) && var_4.ammodroneleavenodes.size > 0) {
      var_2[var_2.size] = var_4;
    }
  }

  var_6 = [];

  foreach(var_4 in var_2) {
    if(!maps\mp\zombies\_zombies_zone_manager::isplayerinzone(var_4.zone_name)) {
      var_6[var_6.size] = var_4;
    }
  }

  var_9 = undefined;

  if(var_6.size > 0) {
    var_9 = var_6[randomint(var_6.size)];
  } else if(var_2.size > 0) {
    var_9 = var_2[randomint(var_2.size)];
  } else {
    var_9 = level.zone_data.zones[randomint(level.zone_data.zones.size)];
  }

  return var_9;
}

getdestinationnode(var_0, var_1) {
  var_2 = 90000;
  var_3 = -1;
  var_4 = var_0.ammodroneleavenodes[randomint(var_0.ammodroneleavenodes.size)];
  var_5 = distancesquared(var_4.origin, var_1.origin);

  if(var_5 < var_2) {
    foreach(var_7 in var_0.ammodroneleavenodes) {
      var_5 = distancesquared(var_1.origin, var_7.origin);

      if(var_5 > var_3) {
        var_3 = var_5;
        var_4 = var_7;
      }
    }
  }

  if(!isDefined(var_4)) {
    return var_0.ammodroneleavenodes[randomint(var_0.ammodroneleavenodes.size)];
  }

  return var_4;
}

spawnammodrone(var_0, var_1) {
  var_2 = getactiveplayer();
  var_3 = spawnhelicopter(var_2, var_0, (0, 0, 0), "orbital_carepackage_drone_mp", "vehicle_treasure_drone_01_ai");

  if(!isDefined(var_3)) {
    return undefined;
  }

  var_3.owner = var_2;
  var_3.team = level.enemyteam;
  var_3 vehicle_turnengineoff();
  var_3 thread trackpreviousorigin();
  setupdamagecallback(var_3);
  playFX(common_scripts\utility::getfx("teleport_post_fx"), var_0);
  return var_3;
}

trackpreviousorigin() {
  self endon("death");

  for(;;) {
    waittillframeend;
    self.prevorigin = self.origin;
    waitframe();
  }
}

setupdamagecallback(var_0) {
  var_0.health = getdronehealth();
  var_0.maxhealth = var_0.health;
  var_0 setCanDamage(1);
  var_0.damagecallback = ::dronehandledamagecallback;
}

getdronehealth() {
  var_0 = 2;

  if(level.players.size > 2) {
    var_0 = 3;
  }

  var_1 = 1500 + (level.wavecounter - 1) * 200 * var_0;
  return var_1;
}

disabledamagecallback(var_0) {
  var_0 setCanDamage(0);
  var_0.damagecallback = undefined;
}

dronehandledamagecallback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(self.startzone.zone_name)) {
    return;
  }
  var_12 = dronemodifydamage(var_1, var_5, var_4, var_2);
  self.health = self.health - var_12;
  self notify("droneDamaged", var_12);
  var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("ammo_drone");
  thread dronedodamageoutline();

  if(self.health <= 0) {
    var_13 = var_1;

    if(!isplayer(var_13)) {
      var_13 = level.players[0];
    }

    if(isDefined(var_13)) {
      var_13 thread maps\mp\_matchdata::loggameevent("zm_tr_drone_kill", self.origin);
    }

    if(isDefined(var_1) && isplayer(var_1) && !maps\mp\zombies\_util::is_true(self.skipplayervo)) {
      var_1 thread playerdestroytreasuredrone();
    }

    disabledamagecallback(self);
    self notify("disabled", self.origin);
  }

  return 0;
}

dronedodamageoutline() {
  self notify("droneDoDamageOutline");
  self endon("droneDoDamageOutline");
  self endon("disabled");
  self hudoutlineenable(5, 0);
  wait 1;
  self hudoutlinedisable();
}

dronemodifydamage(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  var_4 = maps\mp\gametypes\_damage::handleempdamage(var_1, var_2, var_4, var_0);
  var_4 = maps\mp\gametypes\_damage::handlemissiledamage(var_1, var_2, var_4);
  var_4 = maps\mp\gametypes\_damage::handlegrenadedamage(var_1, var_2, var_4);
  var_4 = maps\mp\gametypes\_damage::handleapdamage(var_1, var_2, var_4, var_0);

  if(issubstr(var_1, "iw5_fusionzm")) {
    var_4 = int(var_4 * 0.4);
  } else if(issubstr(var_1, "iw5_rhinozm")) {
    var_4 = int(var_4 * 0.4);
  } else if(issubstr(var_1, "iw5_linegunzm")) {
    var_4 = int(var_4 * 0.4);
  }

  return var_4;
}

waittillactivate(var_0, var_1) {
  var_0 endon("droneDamaged");
  level endon("activateAmmoDrone");
  var_2 = undefined;

  for(;;) {
    waitframe();

    if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_1.zone_name)) {
      continue;
    }
    var_3 = maps\mp\zombies\_zombies_zone_manager::getplayersinzone(var_1.zone_name, 1);

    if(var_3.size == 0) {
      continue;
    }
    var_2 = getplayerclosetodrone(var_0, var_3);

    if(isDefined(var_2)) {
      break;
    }

    var_2 = getplayerlookingatdronetoolong(var_0, var_3);

    if(isDefined(var_2)) {
      break;
    }
  }

  foreach(var_5 in level.players) {
    var_5.lookingatammodrone = undefined;
  }

  return var_2;
}

getplayerclosetodrone(var_0, var_1) {
  foreach(var_3 in var_1) {
    var_4 = distancesquared(var_0.origin, var_3.origin);

    if(var_4 < 160000) {
      return var_3;
    }
  }
}

getplayerlookingatdronetoolong(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(!isDefined(var_3.lookingatammodrone)) {
      var_3.lookingatammodrone = [];
    }

    if(!common_scripts\utility::array_contains(var_1, var_3)) {
      var_3.lookingatammodrone[var_0 getentitynumber()] = undefined;
      continue;
    }

    var_4 = anglesToForward(var_3 getangles());
    var_5 = vectornormalize(var_0.origin - var_3.origin);
    var_6 = vectordot(var_4, var_5);

    if(var_6 < 0.7) {
      var_3.lookingatammodrone[var_0 getentitynumber()] = undefined;
      continue;
    }

    var_7 = var_3 getEye();
    var_8 = var_0.origin + (0, 0, 40);
    var_9 = bulletTrace(var_7, var_8, 0, var_0, 0, 0, 0, 0, 0, 0, 0);
    var_10 = var_9["entity"];

    if(var_9["fraction"] != 1 && (!isDefined(var_10) || var_10 != var_0)) {
      var_3.lookingatammodrone[var_0 getentitynumber()] = undefined;
      continue;
    }

    if(!isDefined(var_3.lookingatammodrone[var_0 getentitynumber()])) {
      var_3.lookingatammodrone[var_0 getentitynumber()] = gettime();
      continue;
    }

    var_11 = gettime() - var_3.lookingatammodrone[var_0 getentitynumber()];

    if(var_11 > 1500) {
      return var_3;
    }
  }
}

getdronespeed(var_0) {
  if(isDefined(var_0.speedoverride)) {
    return var_0.speedoverride;
  }

  return 9;
}

droneactivate(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  setupdrone(var_0);
  var_0.active = 1;
  var_0 thread drone_thrusterfx();
  var_0 thread dronebeep();

  if(var_3) {
    var_0 thread dronehandledrops();
    var_0 thread dronehandlepickup();
  }

  var_0 setvehgoalpos(var_0.origin + (0, 0, 10));
  var_0.currentspeed = getdronespeed(var_0);
  var_0 vehicle_setspeed(var_0.currentspeed, 10, 10);
  var_0 sethoverparams(30, 5, 5);
  var_0 setmaxpitchroll(15, 15);
  wait 0.5;
  var_4 = var_0 dronepathtogoal(var_1, var_2);

  if(isDefined(var_0)) {
    var_0 drone_stopthrustereffects();
  }

  maps\mp\zombies\_util::waitnetworkframe();

  if(isDefined(var_0)) {
    var_0 droneexplode();
  }

  return var_4;
}

droneexplode() {
  self notify("explode");
  playFX(common_scripts\utility::getfx("ammo_drone_explode"), self.origin);
  playsoundatpos(self.origin, "treasure_drone_exp");
  playsoundatpos(self.origin, "treasure_drone_exp_credits");
  maps\mp\_utility::decrementfauxvehiclecount();
  self delete();
}

dronehandledrops() {
  self endon("stopSpeedIncreasing");
  self endon("disabled");
  var_0 = min(level.numammodronesencountered, 3);
  var_1 = self.maxhealth / (var_0 + 1);
  var_2 = self.maxhealth - var_1;
  var_3 = self.origin;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(self.health <= var_2) {
      var_4 = self.origin;
      thread dronedodrop(var_4);
      var_2 = var_2 - var_1;

      if(var_2 <= 0) {
        return;
      }
    }

    waitframe();
  }
}

dronedodrop(var_0) {
  var_1 = getnextdroptype();
  var_2 = "";
  var_3 = 0;
  var_4 = 0;

  if(var_1 == "credits") {
    var_2 = "zark_money_01_obj";
    var_3 = common_scripts\utility::getfx("ammo_drone_drops_credits");
    var_4 = 1000;
  } else {
    var_2 = "zark_grenadebag_01_obj";
    var_3 = common_scripts\utility::getfx("ammo_drone_drops_ammo");
    var_4 = 20;
  }

  var_5 = var_0 + (0, 0, 40);
  var_6 = (randomfloatrange(-1 * var_4, var_4), randomfloatrange(-1 * var_4, var_4), var_4);
  var_7 = vectornormalize(var_6);
  var_8 = spawn("script_model", var_5);
  var_8 setModel(var_2);
  var_8 physicslaunchserver(var_5, var_6);
  var_8 hudoutlineenable(3, 0);
  playFX(common_scripts\utility::getfx("ammo_drone_drops_explode"), var_5 + (0, 0, 5));
  var_9 = var_8 common_scripts\utility::waittill_notify_or_timeout_return("physics_finished", 5);

  if(!isDefined(var_9) || var_9 != "timeout") {
    var_10 = spawnfx(var_3, var_8.origin + (0, 0, 10), (0, 0, 1), (1, 0, 0));
    triggerfx(var_10);
    var_8 dropdobonus(var_1);
    var_10 delete();
  }

  var_8 delete();
}

getnextdroptype() {
  if(!isDefined(level.ammodronedropschedule)) {
    level.ammodronedropschedule = [];
    level.ammodronedropschedule[level.ammodronedropschedule.size] = "ammo";
    level.ammodronedropschedule[level.ammodronedropschedule.size] = "credits";
    level.ammodronedropschedule[level.ammodronedropschedule.size] = "ammo";
    level.ammodronedropschedule[level.ammodronedropschedule.size] = "credits";
    level.ammodronedropschedule = common_scripts\utility::array_randomize(level.ammodronedropschedule);
    level.ammodronedropindex = 0;
  }

  if(level.ammodronedropindex >= level.ammodronedropschedule.size) {
    level.ammodronedropschedule = common_scripts\utility::array_randomize(level.ammodronedropschedule);
    level.ammodronedropindex = 0;
  }

  var_0 = level.ammodronedropschedule[level.ammodronedropindex];
  level.ammodronedropindex++;
  return var_0;
}

dropdobonus(var_0) {
  var_1 = 10000;
  var_2 = 10000;
  var_3 = gettime() + var_1;

  while(gettime() < var_3) {
    foreach(var_5 in level.players) {
      var_6 = distancesquared(var_5.origin, self.origin);

      if(var_6 < var_2) {
        if(var_0 == "ammo") {
          var_5 thread playergiveammo();
          continue;
        }

        if(var_0 == "credits") {
          var_5 thread playergivecredits();
        }
      }
    }

    wait 0.5;
  }
}

playergiveammo() {
  self endon("death");
  self endon("disconnect");
  var_0 = self getcurrentprimaryweapon();

  if(!isDefined(var_0) || var_0 == "none" || maps\mp\zombies\_util::isrippedturretweapon(var_0) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_0) || maps\mp\zombies\_util::iszombieequipment(var_0)) {
    return;
  }
  if(issubstr(var_0, "em1")) {
    waittillframeend;
    var_1 = maps\mp\zombies\_util::playergetem1ammo();
    var_2 = maps\mp\gametypes\zombies::getem1maxammo();

    if(var_1 >= var_2) {
      return;
    }
    var_1 = getnewammoamount(var_1, var_2);
    maps\mp\zombies\_util::playerrecordem1ammo(var_1);
    maps\mp\gametypes\zombies::playerupdateem1omnvar();
  } else {
    var_1 = self getweaponammostock(var_0);
    var_2 = weaponmaxammo(var_0);

    if(var_1 < var_2) {
      var_1 = getnewammoamount(var_1, var_2);
      self setweaponammostock(var_0, var_1);
      return;
    }

    var_1 = self getweaponammoclip(var_0, "right");
    var_2 = weaponclipsize(var_0);

    if(var_1 < var_2) {
      var_1 = getnewammoamount(var_1, var_2);
      self setweaponammoclip(var_0, var_1, "right");
    }

    if(issubstr(var_0, "akimbo")) {
      var_1 = self getweaponammoclip(var_0, "left");

      if(var_1 < var_2) {
        var_1 = getnewammoamount(var_1, var_2);
        self setweaponammoclip(var_0, var_1, "left");
      }
    }
  }
}

getnewammoamount(var_0, var_1) {
  var_2 = 0.02;
  var_3 = int(max(1, var_1 * var_2));

  if(var_0 + var_3 <= var_1) {
    var_0 = var_0 + var_3;
  } else if(var_0 < var_1) {
    var_0 = var_1;
  }

  return var_0;
}

playergivecredits() {
  var_0 = 20;
  maps\mp\gametypes\zombies::givepointsforevent("treasureDrone", var_0, 0);
}

dronehandlespeed() {
  self endon("stopSpeedIncreasing");
  self endon("disabled");

  for(;;) {
    self waittill("droneDamaged", var_0);
    self.currentspeed = min(self.currentspeed + 1, 30);
    self vehicle_setspeed(self.currentspeed, 10, 10);
  }
}

dronebeep() {
  self playLoopSound("treasure_drone_vox_lp");
  common_scripts\utility::waittill_any("disabled", "stopBeeping");
  self stoploopsound();
}

dronehandlepickup() {
  self endon("explode");
  var_0 = maps\mp\gametypes\zombies::selectnextvalidpickup();
  var_1 = level.pickup[var_0]["fx"];
  var_2 = level.pickup[var_0]["model"];
  var_3 = level.pickup[var_0]["outline"];
  var_4 = undefined;

  if(isDefined(var_1)) {
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_1), self, "tag_trophy");
  } else {
    var_4 = spawn("script_model", self.origin);
    var_4 setModel(var_2);
    var_4 hudoutlineenable(2, 0);
    var_4 linkto(self, "tag_origin", (0, 0, 60), (0, 0, 0));
    thread dronecleanuppickupmodel(var_4);
  }

  self waittill("disabled", var_5);

  if(isDefined(var_1)) {
    maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx(var_1), self, "tag_trophy");
  }

  if(isDefined(self.lastgroundposition)) {
    var_5 = self.lastgroundposition;
  }

  if(!isDefined(var_5)) {
    var_5 = self.origin;
  }

  maps\mp\gametypes\zombies::createpickup(var_0, var_5, "Ammo Drone");
}

dronecleanuppickupmodel(var_0) {
  common_scripts\utility::waittill_any("disabled", "explode");
  var_0 delete();
}

getactiveplayer() {
  foreach(var_1 in level.players) {
    if(var_1.sessionstate == "spectator") {
      continue;
    }
    if(isalive(var_1)) {
      return var_1;
    }
  }

  return level.players[0];
}

dronepathtogoal(var_0, var_1) {
  self endon("disabled");
  var_2 = 22500;
  var_3 = gettime();
  self.goalent = spawn("script_origin", var_1.origin);
  self.goalent.health = 1;
  self.goalent.maxhealth = 1;
  thread dronecleanupgoalent();
  self setdronegoalpos(self.goalent, (0, 0, 30));

  for(;;) {
    var_4 = distancesquared(self.origin, self.goalent.origin + (0, 0, 30));

    if(var_4 < var_2) {
      break;
    }

    waitframe();
  }

  if(!nodehasremotemissileset(var_1)) {
    return 1;
  }

  self.lastgroundposition = self.origin;
  var_5 = maps\mp\killstreaks\_aerial_utility::getentorstructarray("remoteMissileSpawn", "targetname");
  var_6 = maps\mp\killstreaks\_orbital_util::nodegetremotemissileorigin(var_1, var_5);
  self setvehgoalpos(var_6, 0);
  thread droneincreaseexitspeed();
  common_scripts\utility::waittill_any("near_goal", "goal");

  if(isDefined(self.goalent)) {
    self.goalent delete();
  }

  return 1;
}

dronecleanupgoalent() {
  common_scripts\utility::waittill_any("disabled", "death");

  if(isDefined(self.goalent)) {
    self.goalent delete();
  }
}

droneincreaseexitspeed() {
  self endon("death");
  wait 7;
  self notify("stopSpeedIncreasing");
  self notify("stopBeeping");
  disabledamagecallback(self);
  self vehicle_setspeed(100, 10, 10);
  level thread dotreasuredroneleavevo(self);
}

drone_thrusterfx() {
  self endon("death");
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"), self, "j_thruster_fl");
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"), self, "j_thruster_fr");
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"), self, "j_thruster_kl");
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"), self, "j_thruster_kr");
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("ocp_exhaust"), self, "tag_fx");

  for(;;) {
    level waittill("connected", var_0);
    thread drone_thrusterplayerconnected(var_0);
  }
}

drone_thrusterplayerconnected(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");

  if(isDefined(var_0) && isDefined(self)) {
    drone_thrusterplayer(var_0);
  }
}

drone_thrusterplayer(var_0) {
  maps\mp\zombies\_util::playfxontagforclientnetwork(common_scripts\utility::getfx("ammo_drone_thruster"), self, "j_thruster_fl", var_0);
  maps\mp\zombies\_util::playfxontagforclientnetwork(common_scripts\utility::getfx("ammo_drone_thruster"), self, "j_thruster_fr", var_0);
  maps\mp\zombies\_util::playfxontagforclientnetwork(common_scripts\utility::getfx("ammo_drone_thruster"), self, "j_thruster_kl", var_0);
  maps\mp\zombies\_util::playfxontagforclientnetwork(common_scripts\utility::getfx("ammo_drone_thruster"), self, "j_thruster_kr", var_0);
  maps\mp\zombies\_util::playfxontagforclientnetwork(common_scripts\utility::getfx("ocp_exhaust"), self, "tag_fx", var_0);
}

drone_stopthrustereffects() {
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"), self, "j_thruster_fl");
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"), self, "j_thruster_fr");
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"), self, "j_thruster_kl");
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("ammo_drone_thruster"), self, "j_thruster_kr");
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("ocp_exhaust"), self, "tag_fx");
}

setupdrone(var_0) {
  var_0 makevehiclenotcollidewithplayers(1);
  var_0.speed = getdronespeed(var_0);
  var_0.followspeed = var_0.speed;
  var_0 vehicle_setspeed(var_0.speed, 10, 10);
  var_0 setyawspeed(120, 90);
  var_0 setneargoalnotifydist(64);
  var_0 sethoverparams(4, 5, 5);
  var_0 vehicle_turnengineon();
  var_1 = 45;
  var_2 = 45;
  var_0 setmaxpitchroll(var_1, var_2);
  var_3 = 10000;
  var_4 = 150;
  var_0.attractor = missile_createattractorent(var_0, var_3, var_4);
  var_0.stunned = 0;
}

playerspottreasuredrone() {
  maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "td_spot");
}

playerdestroytreasuredrone() {
  self endon("disconnect");
  wait 2;
  maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "td_win");
}

dotreasuredroneleavevo(var_0) {
  if(maps\mp\zombies\_util::is_true(var_0.skipplayervo)) {
    return;
  }
  var_1 = sortbydistance(level.players, var_0.origin);
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(!maps\mp\zombies\_util::isplayerinlaststand(var_1[var_3]) && isalive(var_1[var_3])) {
      var_2 = var_1[var_3];
      break;
    }
  }

  if(isDefined(var_2)) {
    var_4 = var_2 maps\mp\zombies\_zombies_zone_manager::getplayerzone();

    if(var_4 == var_0.endzone.zone_name) {
      var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "td_lose");
    }
  }
}