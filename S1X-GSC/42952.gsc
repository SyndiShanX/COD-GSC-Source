/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42952.gsc
**************************************/

init() {
  level._orbital_care_pod = [];
  level.orbitaldropmarkers = [];
  level._effect["ocp_death"] = loadfx("vfx/explosion/exo_droppod_explosion");
  level._effect["ocp_midair"] = loadfx("vfx/explosion/exo_droppod_split");
  level._effect["ocp_ground_marker"] = loadfx("vfx/unique/vfx_marker_killstreak_guide_carepackage");
  level._effect["ocp_ground_marker_bad"] = loadfx("vfx/unique/vfx_marker_killstreak_guide_carepackage_fizzle");
  level._effect["ocp_exhaust"] = loadfx("vfx/vehicle/vehicle_ocp_exhaust");
  level._effect["ocp_thruster_small"] = loadfx("vfx/vehicle/vehicle_ocp_thrusters_small");
  level._effect["vfx_ocp_steam"] = loadfx("vfx/steam/vfx_ocp_steam");
  level._effect["vfx_ocp_steam2"] = loadfx("vfx/steam/vfx_ocp_steam2");
  level._effect["ocp_glow"] = loadfx("vfx/unique/orbital_carepackage_glow");
  level.killstreakfuncs["orbital_carepackage"] = ::tryusedefaultorbitalcarepackage;
  level.killstreakwieldweapons["orbital_carepackage_pod_mp"] = "orbital_carepackage";
  level.killstreakfuncs["orbital_carepackage_juggernaut_exosuit"] = ::tryuseorbitaljuggernautexosuit;
  precachempanim("orbital_care_package_open");
  precachempanim("orbital_care_package_fan_spin");
  level.ocp_weap_name = "orbital_carepackage_pod_mp";

  if(!isDefined(level.missileitemclipdelay)) {
    level.missileitemclipdelay = 3.0;
  }
}

tryusedefaultorbitalcarepackage(var_0, var_1) {
  return tryuseorbitalcarepackage(var_0, "orbital_carepackage", var_1);
}

tryuseorbitaljuggernautexosuit(var_0, var_1) {
  return tryuseorbitalcarepackage(var_0, "orbital_carepackage_juggernaut_exosuit", var_1);
}

tryuseorbitalcarepackage(var_0, var_1, var_2) {
  if(common_scripts\utility::array_contains(var_2, "orbital_carepackage_drone") && maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed()) {
    self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
    return 0;
  }

  var_3 = playerlaunchcarepackage(var_1, var_2);

  if(!isDefined(var_3) || !var_3) {
    return 0;
  }

  if(var_1 == "orbital_carepackage") {
    maps\mp\gametypes\_missions::processchallenge("ch_streak_orbitalcare", 1);
  }

  return 1;
}

playerlaunchcarepackage(var_0, var_1) {
  var_2 = maps\mp\killstreaks\_orbital_util::playergetoutsidenode("carepackage");
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = var_2.origin;
  } else if(isDefined(level.ishorde) && level.ishorde) {
    var_2 = [[level.hordegetoutsideposition]]();
    var_3 = var_2.origin;
  } else {
    thread maps\mp\killstreaks\_orbital_util::playerplayinvalidpositioneffect(common_scripts\utility::getfx("ocp_ground_marker_bad"));
    self setclientomnvar("ui_invalid_orbital_care_package", 1);
    return 0;
  }

  var_4 = undefined;

  if(common_scripts\utility::array_contains(var_1, "orbital_carepackage_drone")) {
    var_4 = spawnhelicopter(self, var_3 + (0, 0, 200), (0, 0, 0), "orbital_carepackage_drone_mp", "orbital_carepackage_pod_01_vehicle");

    if(!isDefined(var_4)) {
      return 0;
    }

    var_4 hide();
  }

  var_5 = firepod(level.ocp_weap_name, self, var_2, var_0, var_1, var_4, undefined, undefined, 1);
  return isDefined(var_5);
}

firepod(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_6)) {
    var_6 = var_1 maps\mp\killstreaks\_orbital_util::playergetorbitalstartpos(var_2, "carepackage");
  }

  var_9 = var_2.origin;

  if(!isDefined(var_7)) {
    var_7 = [];
  }

  var_10 = magicbullet(var_0, var_6, var_9, var_1, 0, 1);

  if(!isDefined(var_10)) {
    return;
  }
  var_10 thread setmissilespecialclipmaskdelayed(level.missileitemclipdelay);

  if(!isDefined(level.iszombiegame) || !level.iszombiegame) {
    var_10 thread trajectory_kill(var_1);
  }

  var_11 = var_1 createplayerdroppod(var_10);
  var_11.streakname = var_3;
  var_11.modules = var_4;
  var_11.droppoint = var_2.origin;
  var_11.drone = var_5;
  var_11.givebackcarepackage = var_8;
  var_10.team = var_1.team;
  var_10.owner = var_1;
  var_10.type = "remote";
  return monitordrop(var_1, var_10, var_11, var_3, var_7, var_0);
}

trajectory_kill(var_0) {
  self endon("death");
  var_1 = self.origin;

  while(isDefined(self)) {
    if(!level.teambased) {
      capsule_damage(10000, self.origin, var_1, 30, undefined, var_0);
    } else {
      capsule_damage(10000, self.origin, var_1, 30, level.otherteam[var_0.team], var_0);
    }

    var_1 = self.origin;
    wait 0.05;
  }
}

capsule_damage(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_2 - var_1;
  var_7 = vectornormalize(var_6);
  var_8 = length(var_6);
  var_9 = var_3 * var_3;

  foreach(var_11 in level.characters) {
    if(!isalive(var_11)) {
      continue;
    }
    if(var_11 != var_5 && isDefined(var_4) && isDefined(var_11.team) && var_11.team != var_4) {
      continue;
    }
    var_12 = var_11.origin - var_1;
    var_13 = vectordot(var_12, var_7);

    if(var_13 > var_3 * -1 && var_13 < var_8 + var_3) {
      var_14 = var_1 + var_7 * var_13;
      var_15 = distancesquared(var_14, var_11.origin);

      if(var_15 <= var_9) {
        var_11 dodamage(var_0, var_14, var_5, self, "MOD_EXPLOSIVE", level.ocp_weap_name);
      }
    }
  }
}

setmissilespecialclipmaskdelayed(var_0) {
  self endon("death");
  wait(var_0);
  self setmissilespecialclipmask(1);
}

createplayerdroppod(var_0) {
  var_1 = 0;

  if(!isDefined(level._orbital_care_pod)) {
    level._orbital_care_pod = [];
  } else {
    level._orbital_care_pod = maps\mp\_utility::cleanarray(level._orbital_care_pod);
    var_1 = level._orbital_care_pod.size;
  }

  level._orbital_care_pod[var_1] = spawnStruct();
  level._orbital_care_pod[var_1].hasleftcam = 0;
  level._orbital_care_pod[var_1].podrocket = var_0;
  level._orbital_care_pod[var_1].podrocket.maxhealth = 100;
  level._orbital_care_pod[var_1].podrocket.health = 100;
  level._orbital_care_pod[var_1].podrocket.damagetaken = 0;
  level._orbital_care_pod[var_1].podrocket.ispodrocket = 1;
  level._orbital_care_pod[var_1].owner = self;
  level._orbital_care_pod[var_1].alive = 1;
  return level._orbital_care_pod[var_1];
}

rocket_cleanupondeath() {
  var_0 = self getentitynumber();
  level.rockets[var_0] = self;
  self waittill("death");

  if(isDefined(level.orbitaldropupgrade) && level.orbitaldropupgrade == 1) {
    magicgrenademanual("dna_aoe_grenade_throw_zombie_mp", self.origin + (0, 0, 64), (0, 0, 0), 3.0, level.player, 1);
  }

  level.rockets[var_0] = undefined;

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament.origin = self.killcament.origin + (0, 0, 300);
  }
}

getdroptypefromstreakname(var_0) {
  switch (var_0) {
    case "orbital_carepackage_juggernaut_exosuit":
      return "orbital_carepackage_juggernaut_exosuit";
    case "airdrop_reinforcement_common":
      return "airdrop_reinforcement_common";
    case "airdrop_reinforcement_uncommon":
      return "airdrop_reinforcement_uncommon";
    case "airdrop_reinforcement_rare":
      return "airdrop_reinforcement_rare";
    case "airdrop_reinforcement_practice":
      return "airdrop_reinforcement_practice";
    case "horde_support_drop":
      return "horde_support_drop";
    default:
      return "airdrop_assault";
  }
}

allowdronedelivery(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(level.teambased && level.teamemped[var_0.team]) {
    return 0;
  }

  if(!level.teambased && isDefined(level.empplayer) && level.empplayer != var_0) {
    return 0;
  }

  return 1;
}

monitordrop(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getdroptypefromstreakname(var_3);

  if(var_6 == "airdrop_assault" && common_scripts\utility::array_contains(var_2.modules, "orbital_carepackage_odds")) {
    var_6 = "airdrop_assault_odds";
  }

  if(isDefined(level.getcratefordroptype)) {
    var_7 = [[level.getcratefordroptype]](var_6);
  } else {
    var_7 = maps\mp\killstreaks\_airdrop::getcratetypefordroptype(var_6);
  }

  thread monitordropinternal(var_0, var_1, var_2, var_6, var_7, var_5);
  return var_7;
}

monitordropinternal(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_1 thread rocket_cleanupondeath();
  var_6 = common_scripts\utility::array_contains(var_2.modules, "orbital_carepackage_trap");
  var_7 = var_0 maps\mp\killstreaks\_airdrop::createairdropcrate(var_0, var_3, var_4, var_1.origin, undefined, var_6, 0);
  var_7.moduletrap = common_scripts\utility::array_contains(var_2.modules, "orbital_carepackage_trap");
  var_7.modulehide = common_scripts\utility::array_contains(var_2.modules, "orbital_carepackage_hide");
  var_7.moduleroll = common_scripts\utility::array_contains(var_2.modules, "orbital_carepackage_roll");
  var_7.modulepickup = common_scripts\utility::array_contains(var_2.modules, "orbital_carepackage_fast_pickup");
  var_7.angles = (0, 0, 0);
  var_7.en_route_in_air = 1;
  var_1.killcament = var_7.killcament;

  if(var_5 == "orbital_carepackage_pod_plane_mp") {
    var_1.killcament.killcamstarttime = gettime();
  }

  var_8 = common_scripts\utility::array_contains(var_2.modules, "orbital_carepackage_drone");
  var_9 = spawn("script_model", var_2.droppoint + (0, 0, 5));
  var_9.angles = (-90, 0, 0);
  var_9 setModel("tag_origin");
  var_9 hide();
  var_9 showtoplayer(var_0);
  playFXOnTag(common_scripts\utility::getfx("ocp_ground_marker"), var_9, "tag_origin");
  var_9 thread carepackagesetupminimap(var_2.modules, var_0);
  maps\mp\killstreaks\_orbital_util::adddropmarker(var_9);

  if(var_8) {
    var_0 thread playermonitorfordronedelivery(var_1, var_2, var_9, var_7);
  }

  var_7 linkto(var_1, "tag_origin", (0, 0, 0), (-90, 0, 0));
  var_1 waittill("death", var_10, var_11, var_12);

  if(isDefined(var_1) && !var_8 && var_1.origin[2] > var_2.droppoint[2] && distancesquared(var_1.origin, var_2.droppoint) > 22500) {
    if(var_2.givebackcarepackage) {
      if(isDefined(level.ishorde) && level.ishorde) {
        var_13 = [[level.hordegetoutsideposition]]();
        firepod(level.ocp_weap_name, self, var_13, "horde_support_drop", var_2.modules, 0, undefined, undefined, 1);
      } else if(isDefined(var_0)) {
        var_0 playergivebackcarepackage(var_2);
      }
    }

    level thread cleanupcarepackage(var_2, var_7, var_9);
    return;
  }

  if(var_8 && allowdronedelivery(var_0) && isDefined(var_2.drone)) {
    var_2.drone show();
  } else {
    earthquake(0.4, 1, var_2.droppoint, 800);
    playrumbleonposition("artillery_rumble", var_2.droppoint);
  }

  killfxontag(common_scripts\utility::getfx("ocp_ground_marker"), var_9, "tag_origin");
  var_2.alive = 0;

  if(var_8 && allowdronedelivery(var_0) && isDefined(var_2.drone)) {
    var_2.drone waittill("delivered");
    var_7 setcontents(var_7.oldcontents);
    var_7.oldcontents = undefined;
  }

  var_9 thread carepackagecleanup(var_7);
  var_7 clonebrushmodeltoscriptmodel(level.airdropcratecollision);
  var_7.droppingtoground = 1;
  var_7 unlink();
  var_7 physicslaunchserver((0, 0, 0));
  var_7 thread cratedetectstopphysics();
  var_7 thread orbitalphysicswaiter(var_3, var_4, var_0);
  level thread removepod(var_7, var_2);
  var_7.en_route_in_air = 0;
}

crateimpactcleanup(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getnodesinradiussorted(self.origin, 300, 0, 300);

  foreach(var_3 in level.characters) {
    if(!isalive(var_3)) {
      continue;
    }
    if(isalliedsentient(var_3, var_0)) {
      if(var_3 istouching(self)) {
        foreach(var_5 in var_1) {
          if(distancesquared(var_5.origin, self.origin) > 10000) {
            var_3 setorigin(var_5.origin, 1);
            var_1 = common_scripts\utility::array_remove(var_1, var_5);
            break;
          }
        }
      }
    }
  }
}

cratedetectstopphysics() {
  self endon("physics_finished");
  self endon("death");
  var_0 = 4;
  var_1 = var_0 / 0.05;
  var_2 = 25;
  var_3 = 0;
  var_4 = self.origin;

  for(;;) {
    waitframe();
    var_5 = distancesquared(var_4, self.origin);

    if(var_5 < var_2) {
      var_3++;
    } else {
      var_3 = 0;
    }

    var_4 = self.origin;

    if(var_3 >= var_1) {
      self physicsstop();
      return;
    }
  }
}

playergivebackcarepackage(var_0) {
  var_1 = maps\mp\killstreaks\_killstreaks::getstreakcost("orbital_carepackage");
  var_2 = maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex("orbital_carepackage", 0);
  thread maps\mp\gametypes\_hud_message::killstreaksplashnotify("orbital_carepackage", var_1, undefined, var_0.modules, var_2);
  thread maps\mp\killstreaks\_killstreaks::givekillstreak("orbital_carepackage", 0, 0, self, var_0.modules);
}

cleanupcarepackage(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    thread removepod(var_1, var_0);
    var_1 delete();
  }

  if(isDefined(var_0.drone)) {
    var_0.drone maps\mp\killstreaks\_drone_carepackage::carepackagedrone_remove();
  }

  if(isDefined(var_2)) {
    if(isDefined(var_2.objidfriendly)) {
      maps\mp\_utility::_objective_delete(var_2.objidfriendly);
    }

    if(isDefined(var_2.objidenemy)) {
      maps\mp\_utility::_objective_delete(var_2.objidenemy);
    }

    killfxontag(common_scripts\utility::getfx("ocp_ground_marker"), var_2, "tag_origin");
    waitframe();
    var_2 delete();
  }
}

orbitalphysicswaiter(var_0, var_1, var_2) {
  self endon("death");
  maps\mp\killstreaks\_airdrop::physicswaiter(var_0, var_1);
  self playSound("orbital_pkg_panel");

  if(isDefined(self.enemymodel)) {
    self.enemymodel thread orbitalanimate();
    self.enemymodel solid();
  }

  if(isDefined(self.friendlymodel)) {
    self.friendlymodel thread orbitalanimate();
    self.friendlymodel solid();
  }

  thread crateimpactcleanup(var_2);
}

orbitalanimate(var_0) {
  self endon("death");

  if(!isDefined(var_0) || !var_0) {
    wait 0.75;
  }

  if(isDefined(var_0) && var_0) {
    self scriptmodelplayanim("orbital_care_package_open_loop");
  } else {
    self scriptmodelplayanim("orbital_care_package_open");
  }

  playFXOnTag(common_scripts\utility::getfx("ocp_glow"), self, "TAG_ORIGIN");

  if(!isDefined(var_0) || !var_0) {
    waitframe();
    playFXOnTag(common_scripts\utility::getfx("vfx_ocp_steam2"), self, "TAG_FX_PANEL_F");
    playFXOnTag(common_scripts\utility::getfx("vfx_ocp_steam2"), self, "TAG_FX_PANEL_K");
    waitframe();
    playFXOnTag(common_scripts\utility::getfx("vfx_ocp_steam"), self, "TAG_FX_PANEL_FR");
    playFXOnTag(common_scripts\utility::getfx("vfx_ocp_steam"), self, "TAG_FX_PANEL_KL");
    waitframe();
    playFXOnTag(common_scripts\utility::getfx("vfx_ocp_steam"), self, "TAG_FX_PANEL_FL");
    playFXOnTag(common_scripts\utility::getfx("vfx_ocp_steam"), self, "TAG_FX_PANEL_KR");
  }
}

delaycleanupdroppod(var_0) {
  wait 5;
  var_0 delete();
}

removepod(var_0, var_1) {
  var_0 waittill("death");
  wait 15;

  for(var_2 = 0; var_2 < level._orbital_care_pod.size; var_2++) {
    if(isDefined(level._orbital_care_pod[var_2]) && level._orbital_care_pod[var_2] == var_1) {
      if(level._orbital_care_pod[var_2].alive == 0) {
        level._orbital_care_pod[var_2] = undefined;
      }
    }
  }

  if(isDefined(var_1)) {
    var_1 = undefined;
  }
}

carepackagesetupminimap(var_0, var_1) {
  self endon("death");

  if(common_scripts\utility::array_contains(var_0, "orbital_carepackage_hide")) {
    return;
  }
  var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
  objective_add(var_2, "invisible", (0, 0, 0));
  objective_position(var_2, self.origin);
  objective_state(var_2, "active");
  var_3 = "compass_objpoint_ammo_friendly";
  objective_icon(var_2, var_3);

  if(!level.teambased) {
    objective_playerteam(var_2, var_1 getentitynumber());
  } else {
    objective_team(var_2, var_1.team);
  }

  self.objidfriendly = var_2;

  if(!(isDefined(level.ishorde) && level.ishorde)) {
    var_2 = maps\mp\gametypes\_gameobjects::getnextobjid();
    objective_add(var_2, "invisible", (0, 0, 0));
    objective_position(var_2, self.origin);
    objective_state(var_2, "active");
    objective_icon(var_2, "compass_objpoint_ammo_enemy");

    if(!level.teambased) {
      objective_playerenemyteam(var_2, var_1 getentitynumber());
    } else {
      objective_team(var_2, level.otherteam[var_1.team]);
    }

    self.objidenemy = var_2;
  }

  if(common_scripts\utility::array_contains(var_0, "orbital_carepackage_drone")) {
    self waittill("linkedToDrone");
    objective_onentity(self.objidfriendly, self);

    if(isDefined(self.objidenemy)) {
      objective_onentity(self.objidenemy, self);
      self show();
    }
  }
}

carepackagecleanup(var_0) {
  var_0 common_scripts\utility::waittill_any("physics_finished", "death");

  if(isDefined(self.objidfriendly)) {
    maps\mp\_utility::_objective_delete(self.objidfriendly);
  }

  if(isDefined(self.objidenemy)) {
    maps\mp\_utility::_objective_delete(self.objidenemy);
  }

  killfxontag(common_scripts\utility::getfx("ocp_glow"), self, "TAG_ORIGIN");

  if(isDefined(level.ishorde) && level.ishorde) {
    var_0 notify("drop_pod_cleared");
  }

  waitframe();
  self delete();
}

setupdamagecallback(var_0) {
  var_0.health = 500;
  var_0.maxhealth = var_0.health;
  var_0.readytodie = 0;
  setupdamagecallbackinternal(var_0.friendlymodel);
  setupdamagecallbackinternal(var_0.enemymodel);
}

setupdamagecallbackinternal(var_0) {
  var_0 thread maps\mp\gametypes\_damage::setentitydamagecallback(9999, undefined, undefined, ::cratehandledamagecallback, 1);
}

disabledamagecallback(var_0) {
  disabledamagecallbackinternal(var_0.friendlymodel);
  disabledamagecallbackinternal(var_0.enemymodel);
}

disabledamagecallbackinternal(var_0) {
  var_0.damagecallback = undefined;
  var_0 setCanDamage(0);
  var_0 setdamagecallbackon(0);
}

cratehandledamagecallback(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(isDefined(self.parentcrate)) {
    var_4 = self.parentcrate;
  }

  var_5 = maps\mp\gametypes\_damage::modifydamage(var_0, var_1, var_2, var_3);
  var_4.health = var_4.health - var_5;

  if(var_4.health <= 0) {
    disabledamagecallback(var_4);
    var_4 notify("disabled");
  }

  return 0;
}

playermonitorfordronedelivery(var_0, var_1, var_2, var_3) {
  self endon("disconenct");
  self endon("joined_team");
  self endon("joined_spectators");
  var_4 = 576;
  var_5 = 250000;
  var_6 = var_1.droppoint;
  var_7 = var_0.origin;
  var_8 = distancesquared(var_7, var_6);
  setupdamagecallback(var_3);
  var_9 = var_1.drone;
  var_9 thread carepackagedronewatchcratedeath(var_3);
  var_3.oldcontents = var_3 setcontents(0);
  var_3.friendlymodel solid();
  var_3.enemymodel solid();

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    var_7 = var_0.origin;
    var_8 = distancesquared(var_7, var_6);

    if(var_8 <= var_5) {
      break;
    }

    waitframe();
  }

  if(var_8 > var_5) {
    if(var_1.givebackcarepackage && allowdronedelivery(self)) {
      playergivebackcarepackage(var_1);
    }

    level thread cleanupcarepackage(var_1, var_3, var_2);
    return;
  }

  if(!isDefined(self)) {
    level thread cleanupcarepackage(var_1, var_3, var_2);
    return;
  }

  if(!allowdronedelivery(self)) {
    level thread cleanupcarepackage(var_3, undefined, undefined);
    return;
  }

  var_9 thread carepackagedronewatchdeath();
  var_9 endon("death");
  var_9 vehicle_teleport(var_3.origin, var_3.angles, 0, 0);
  var_3 linkto(var_9, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_3.friendlymodel scriptmodelplayanim("orbital_care_package_fan_spin", "nothing");
  var_3.enemymodel scriptmodelplayanim("orbital_care_package_fan_spin", "nothing");
  maps\mp\killstreaks\_drone_carepackage::setupcarepackagedrone(var_9, 1);
  var_9.crate = var_3;

  if(isDefined(var_0)) {
    var_7 = var_0.origin;
    var_0 notify("death");
    var_0 delete();
  }

  playsoundatpos(var_7, "orbital_pkg_pod_midair_exp");
  playFX(common_scripts\utility::getfx("ocp_midair"), var_7, getdvarvector("scr_ocp_forward", (0, 0, -1)));
  var_9 thread drone_thrusterfx();
  var_10 = var_1.droppoint + (0, 0, 35);
  var_9 setvehgoalpos(var_10, 1);
  var_9 vehicle_setspeedimmediate(getdvarfloat("scr_ocp_dropspeed", 30), getdvarfloat("scr_ocp_dropa", 20), getdvarfloat("scr_ocp_dropd", 1));
  var_9 sethoverparams(30, 5, 5);
  var_9 setmaxpitchroll(15, 15);

  while(distancesquared(var_9.origin, var_10) > var_4 && var_3.health > 0) {
    waitframe();
  }

  if(var_3.health > 0) {
    wait 1;
  }

  if(var_3.health > 0) {
    var_2 linkto(var_9, "tag_origin");
    var_2 notify("linkedToDrone");
    var_9 thread maps\mp\killstreaks\_drone_carepackage::carepackagedrone_deleteonactivate();
    var_9 carepackagedronefindowner();
  }

  disabledamagecallback(var_3);
  var_3 playsoundonmovingent("orbital_pkg_drone_jets_off");

  if(isDefined(var_9)) {
    var_9 drone_stopthrustereffects();
  }

  var_3.friendlymodel scriptmodelclearanim("orbital_care_package_fan_spin", "nothing");
  var_3.enemymodel scriptmodelclearanim("orbital_care_package_fan_spin", "nothing");
  waitframe();

  if(isDefined(var_9)) {
    var_9 maps\mp\killstreaks\_drone_carepackage::carepackagedrone_delete();
  }
}

carepackagedronewatchdeath() {
  self endon("delivered");
  self waittill("death");
  self notify("delivered");
}

carepackagedronewatchcratedeath(var_0) {
  self endon("delivered");
  var_0 waittill("disabled");
  self notify("delivered");
}

carepackagedronefindowner() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  self endon("death");
  self endon("delivered");
  var_1 = 22500;
  var_2 = 1;
  var_3 = gettime();

  for(;;) {
    var_4 = maps\mp\_utility::isreallyalive(var_0);

    if(!var_4) {
      var_2 = 1;
      waitframe();
    }

    if(var_3 < gettime() || var_2) {
      var_2 = 0;
      self setdronegoalpos(var_0, (0, -100, 15));
      var_3 = gettime() + 1000;
    }

    var_5 = distancesquared(self.origin, var_0.origin + (0, 0, 15));

    if(var_5 < var_1) {
      wait(getdvarfloat("scr_ocp_waitDeliver", 1));
      self notify("delivered");
      return;
    }

    waitframe();
  }
}

drone_thrusterfx() {
  self endon("death");
  playFXOnTag(common_scripts\utility::getfx("ocp_thruster_small"), self, "j_thruster_fl");
  playFXOnTag(common_scripts\utility::getfx("ocp_thruster_small"), self, "j_thruster_fr");
  playFXOnTag(common_scripts\utility::getfx("ocp_thruster_small"), self, "j_thruster_kl");
  playFXOnTag(common_scripts\utility::getfx("ocp_thruster_small"), self, "j_thruster_kr");
  waitframe();
  waitframe();

  if(isDefined(self)) {
    playFXOnTag(common_scripts\utility::getfx("ocp_exhaust"), self, "tag_fx");
  }

  for(;;) {
    level waittill("connected", var_0);
    thread drone_thrusterplayerconnected(var_0);
  }
}

drone_thrusterplayerconnected(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");

  if(isDefined(var_0) && isDefined(self)) {
    drone_thrusterplayer(var_0);
  }
}

drone_thrusterplayer(var_0) {
  var_0 endon("disconnect");
  self endon("death");
  playfxontagforclients(common_scripts\utility::getfx("ocp_thruster_small"), self, "j_thruster_fl", var_0);
  playfxontagforclients(common_scripts\utility::getfx("ocp_thruster_small"), self, "j_thruster_fr", var_0);
  playfxontagforclients(common_scripts\utility::getfx("ocp_thruster_small"), self, "j_thruster_kl", var_0);
  playfxontagforclients(common_scripts\utility::getfx("ocp_thruster_small"), self, "j_thruster_kr", var_0);
  waitframe();
  waitframe();

  if(isDefined(self)) {
    playfxontagforclients(common_scripts\utility::getfx("ocp_exhaust"), self, "tag_fx", var_0);
  }
}

drone_stopthrustereffects() {
  killfxontag(common_scripts\utility::getfx("ocp_thruster_small"), self, "j_thruster_fl");
  killfxontag(common_scripts\utility::getfx("ocp_thruster_small"), self, "j_thruster_fr");
  killfxontag(common_scripts\utility::getfx("ocp_thruster_small"), self, "j_thruster_kl");
  killfxontag(common_scripts\utility::getfx("ocp_thruster_small"), self, "j_thruster_kr");
  waitframe();
  waitframe();

  if(isDefined(self)) {
    killfxontag(common_scripts\utility::getfx("ocp_exhaust"), self, "tag_fx");
  }
}