/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\killstreaks\_zombie_drone_assault.gsc
*****************************************************************/

init() {
  level.dronesdeployed = 0;
  level._effect["assault_c4_explode"] = loadfx("vfx/vehicle/vehicle_assault_drone_rocket");
  level._effect["remote_tank_explode"] = loadfx("vfx/explosion/vehicle_assault_drone_death");
  level._effect["c4_forward_blur"] = loadfx("vfx/unique/forward_view_radial_blur");
  level._effect["assault_drone_exhaust"] = loadfx("vfx/vehicle/vehicle_mp_assault_drone_exhaust");
  level._effect["assault_drone_thruster"] = loadfx("vfx/vehicle/vehicle_mp_assault_drone_thruster");
  level._effect["assault_drone_marker"] = loadfx("vfx/ui/vfx_marker_drone_assault");
  level._effect["assault_drone_exhaust_bottom"] = loadfx("vfx/vehicle/vehicle_mp_assault_drone_exhaust");
  level.killstreakfuncs["zm_ugv"] = ::tryuseassaultdrone;
  level.killstreakwieldweapons["drone_assault_remote_turret_mp"] = "assault_ugv";
  level.killstreakwieldweapons["ugv_missile_mp"] = "assault_ugv";
  level.killstreakwieldweapons["assaultdrone_c4_mp"] = "assault_ugv";
  level.killstreakwieldweapons["killstreak_terrace_mp"] = "mp_terrace";
  thread maps\mp\zombies\killstreaks\_zombie_assaultdrone_ai::assault_vehicle_ai_init();
  game["dialog"]["ks_adrone_destroyed"] = "ks_adrone_destroyed";
}

getdronespawnpoint(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = spawnStruct();
  var_4.placementok = 1;

  if(common_scripts\utility::array_contains(var_0, "mp_terrace")) {
    var_5 = getent("killstreak_orbit_initial", "targetname");
    var_6 = getent("killstreak_orbit_lookat", "targetname");

    if(isDefined(var_5) && isDefined(var_6)) {
      var_4.origin = var_5.origin;
      var_4.angles = vectortoangles(var_6.origin - var_5.origin);
    } else {
      var_7 = common_scripts\utility::getstruct("mp_terrace_killstreak_start", "targetname");
      var_4.origin = var_7.origin;
      var_4.angles = var_7.angles;
    }
  } else {
    var_4 = maps\mp\zombies\killstreaks\_zombie_drone_common::dronegetspawnpoint();
  }

  return var_4;
}

tryuseassaultdrone(var_0, var_1) {
  if(maps\mp\zombies\_util::arekillstreaksdisabled()) {
    return 0;
  }

  if(isDefined(level.ishorde) && level.ishorde) {
    if(isDefined(self.aerialdrone)) {
      self.aerialdrone notify("death");
    }
  }

  if(var_1.size == 0) {
    var_1 = ["assault_ugv_ai", "assault_ugv_mg"];
  }

  var_2 = 1;

  if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_2 >= maps\mp\_utility::maxvehiclesallowed()) {
    self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
    return 0;
  }

  if(level.dronesdeployed >= 2) {
    self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
    return 0;
  }

  maps\mp\_utility::incrementfauxvehiclecount();
  var_3 = getdronespawnpoint(var_1);

  if(!var_3.placementok) {
    self iprintlnbold(&"MP_DRONE_PLACEMENT_INVALID");
    maps\mp\_utility::decrementfauxvehiclecount();
    return 0;
  }

  var_4 = common_scripts\utility::array_contains(var_1, "assault_ugv_ai");

  if(!var_4) {
    var_5 = maps\mp\killstreaks\_killstreaks::initridekillstreak("assault_ugv");

    if(var_5 != "success") {
      maps\mp\_utility::decrementfauxvehiclecount();
      return 0;
    }

    maps\mp\_utility::setusingremote("assault_ugv");
  }

  var_6 = createassaultuav(var_0, var_1, var_3.origin, var_3.angles);

  if(isDefined(var_6)) {
    if(common_scripts\utility::array_contains(var_1, "mp_terrace")) {
      maps\mp\_matchdata::logkillstreakevent("mp_terrace", self.origin);
      thread maps\mp\_utility::teamplayercardsplash("used_mp_terrace", self);
    } else {
      maps\mp\_matchdata::logkillstreakevent("assault_ugv", self.origin);
      thread maps\mp\_utility::teamplayercardsplash("used_assault_ugv", self);
    }

    if(isDefined(level.ishorde) && level.ishorde) {
      self.aerialdrone = var_6;
    }

    thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo("ss_use_assault_drone");
    level.dronesdeployed++;
    return 1;
  } else {
    return 0;
  }
}

createassaultuav(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::array_contains(var_1, "assault_ugv_mg") || common_scripts\utility::array_contains(var_1, "assault_ugv_rockets") || common_scripts\utility::array_contains(var_1, "mp_terrace");
  var_5 = common_scripts\utility::array_contains(var_1, "mp_terrace");
  var_6 = "assault_uav_mp";
  var_7 = 90;

  if(var_4) {
    var_6 = "mg_assault_uav_mp";
  }

  var_8 = "vehicle_atlas_aerial_drone_01_assult_mp_noturret_clr_50p";

  if(!var_4) {
    var_8 = "vehicle_atlas_aerial_drone_01_patrol_mp_static_clr_01_50p";
  }

  if(var_5) {
    var_6 = "assault_uav_mp_terrace";
    var_8 = "vehicle_sniper_drone_cloak_mp";
    var_7 = 30;
  }

  var_9 = spawnhelicopter(self, var_2, var_3, var_6, var_8);

  if(!isDefined(var_9)) {
    return;
  }
  thread setupcommonassaultdroneproperties(var_9, var_0, var_7, var_1);
  var_9.getstingertargetposfunc = ::assault_drone_stinger_target_pos;
  return var_9;
}

assault_drone_stinger_target_pos() {
  return self gettagorigin("tag_origin");
}

setupplayercommands(var_0) {
  if(isbot(self)) {
    return;
  }
  if(isDefined(var_0) && var_0.hasaioption) {
    return;
  }
  self notifyonplayercommand("FirePrimaryWeapon", "+attack");
  self notifyonplayercommand("FirePrimaryWeapon", "+attack_akimbo_accessible");
  self notifyonplayercommand("FireSecondaryWeapon", "+speed_throw");
  self notifyonplayercommand("FireSecondaryWeapon", "+toggleads_throw");
  self notifyonplayercommand("FireSecondaryWeapon", "+ads_akimbo_accessible");

  if(isDefined(var_0) && var_0.hascloak) {
    self notifyonplayercommand("Cloak", "+usereload");
    self notifyonplayercommand("Cloak", "+activate");
  }
}

disableplayercommands(var_0) {
  if(isbot(self)) {
    return;
  }
  if(isDefined(var_0) && var_0.hasaioption) {
    return;
  }
  self notifyonplayercommandremove("FirePrimaryWeapon", "+attack");
  self notifyonplayercommandremove("FirePrimaryWeapon", "+attack_akimbo_accessible");
  self notifyonplayercommandremove("FireSecondaryWeapon", "+speed_throw");
  self notifyonplayercommandremove("FireSecondaryWeapon", "+toggleads_throw");
  self notifyonplayercommandremove("FireSecondaryWeapon", "+ads_akimbo_accessible");

  if(isDefined(var_0) && var_0.hascloak) {
    self notifyonplayercommandremove("Cloak", "+usereload");
    self notifyonplayercommandremove("Cloak", "+activate");
  }
}

setupcommonassaultdroneproperties(var_0, var_1, var_2, var_3) {
  var_0 makeunusable();
  var_0 makevehiclesolidcapsule(23, 23, 23);
  var_0.lifeid = var_1;
  var_0.team = self.team;
  var_0.owner = self;
  var_0.maxhealth = 250;
  var_0.destroyed = 0;
  var_0.vehicletype = "drone_assault";
  var_0 common_scripts\utility::make_entity_sentient_mp(self.team);
  var_0.modules = var_3;
  var_0.mp_terrace = common_scripts\utility::array_contains(var_3, "mp_terrace");
  var_0.hardened = common_scripts\utility::array_contains(var_3, "assault_ugv_hardened");
  var_0.hasmg = common_scripts\utility::array_contains(var_3, "assault_ugv_mg") || var_0.mp_terrace;
  var_0.hasrockets = common_scripts\utility::array_contains(var_3, "assault_ugv_rockets");
  var_0.hascloak = common_scripts\utility::array_contains(var_3, "assault_ugv_cloak");
  var_0.hasaioption = common_scripts\utility::array_contains(var_3, "assault_ugv_ai");
  var_0.hasarhud = common_scripts\utility::array_contains(var_3, "assault_ugv_ar_hud") || var_0.mp_terrace;
  var_0.hasturret = var_0.hasmg || var_0.hasrockets;
  var_0.endtime = gettime() + var_2 * 1000;

  if(var_0.hardened) {
    var_0.maxhealth = int(var_0.maxhealth * 1.3);
  }

  if(!var_0.hasaioption) {
    setupplayercommands(var_0);
    thread notify_assault_drone_on_player_command(var_0);
  }

  var_0 setCanDamage(1);
  var_0.empgrenaded = 0;
  var_0.damagefade = 1.0;
  var_0.oldcontents = var_0 setcontents(0);
  var_0 thread maps\mp\gametypes\_damage::setentitydamagecallback(var_0.maxhealth, undefined, ::onassaultdronedeath, ::drone_modifydamage, 1);
  var_0 ghost();
  thread maps\mp\zombies\killstreaks\_zombie_drone_common::dronesetupcloaking(var_0, var_0.hascloak);

  if(var_0.hascloak) {
    thread maps\mp\zombies\killstreaks\_zombie_drone_common::dronecloakready(var_0, var_0.hascloak);
  }

  self.using_remote_tank = !var_0.hasaioption;
  self.hasaiassaultdrone = var_0.hasaioption;

  if(!var_0.hasaioption) {
    playerstartusingassaultvehicle(var_0);
    thread assaulthudsetup(var_0);
    thread monitoruavsafearea(var_0);
  } else {
    thread maps\mp\zombies\killstreaks\_zombie_assaultdrone_ai::aistartusingassaultvehicle(var_0);
  }

  thread monitorplayerdisconnect(var_0);
  thread assaulthandledeath(var_0);
  thread monitorplayerswitchteams(var_0);
  thread monitorplayergameended(var_0);
  thread maps\mp\zombies\killstreaks\_zombie_drone_common::playerwatchfordroneemp(var_0);

  if(var_0.mp_terrace) {
    var_4 = getent("killstreak_orbit_origin", "targetname");
    var_5 = getent("killstreak_orbit_initial", "targetname");
    var_6 = getent("killstreak_orbit_lookat", "targetname");

    if(isDefined(var_4) && isDefined(var_5) && isDefined(var_6)) {
      var_0 setorbiterents(self, var_4, var_5, var_6);
    }
  }

  if(!var_0.mp_terrace) {
    thread maps\mp\zombies\killstreaks\_zombie_drone_common::playerhandleexhaustfx(var_0, "assault_drone_exhaust", "TAG_EXHAUST_REAR", "assaultDroneHunterKiller");
    thread maps\mp\zombies\killstreaks\_zombie_drone_common::playerhandleexhaustfx(var_0, "assault_drone_exhaust_bottom", "tag_exhaust_lt");
    thread maps\mp\zombies\killstreaks\_zombie_drone_common::playerhandleexhaustfx(var_0, "assault_drone_exhaust_bottom", "tag_exhaust_rt");
  }

  if(!isDefined(level.ishorde) || isDefined(level.ishorde) && self getclientomnvar("ui_horde_player_class") != "drone") {
    thread assaulthandletimeoutwarning(var_0, var_2);
  }

  assaultvehiclemonitorweapons(var_0);
  thread maps\mp\zombies\killstreaks\_zombie_drone_common::updateshootinglocation(var_0, common_scripts\utility::getfx("assault_drone_marker"));
  thread debug_show_origin(var_0);
  var_7 = spawnStruct();
  var_7.validateaccuratetouching = 1;
  var_7.deathoverridecallback = ::override_drone_platform_death;
  var_0 thread maps\mp\_movers::handle_moving_platforms(var_7);
  return var_0;
}

drone_modifydamage(var_0, var_1, var_2, var_3) {
  var_4 = maps\mp\gametypes\_damage::modifydamage(var_0, var_1, var_2, var_3);

  if(isDefined(var_1) && (var_1 == "drone_assault_remote_turret_mp" || var_1 == "ugv_missile_mp")) {
    var_4 = -1;
  }

  if(isplayer(var_0)) {
    var_4 = -1;
  }

  return var_4;
}

override_drone_platform_death(var_0) {
  self notify("death");
}

debug_show_origin(var_0) {}

notify_assault_drone_on_player_command(var_0) {
  self endon("disconnect");
  var_0 endon("death");

  for(;;) {
    var_1 = common_scripts\utility::waittill_any_return("FirePrimaryWeapon", "FireSecondaryWeapon", "Cloak");

    if(isDefined(var_1)) {
      var_0 notify(var_1);
    }
  }
}

playerstartusingassaultvehicle(var_0) {
  var_1 = self;

  if(getdvarint("camera_thirdPerson")) {
    var_1 maps\mp\_utility::setthirdpersondof(0);
  }

  var_1 maps\mp\_utility::playersaveangles();

  if(!var_0.mp_terrace) {
    var_1 cameralinkto(var_0, "tag_origin");
  }

  var_1 remotecontrolvehicle(var_0);
  var_1 thread maps\mp\zombies\killstreaks\_zombie_drone_common::setdronevisionandlightsetpermap(1.5, var_0);
  var_1.using_remote_tank = 1;
  return 1;
}

assaultvehiclemonitorweapons(var_0) {
  if(var_0.hasturret) {
    thread spawnmgturret(var_0);
  } else {
    thread waitforc4detonation(var_0);
  }

  if(var_0.hasrockets) {
    thread setuprockets(var_0);
  }

  thread assaultplayerexit(var_0);
}

getassaultvehiclec4radius() {
  return 200;
}

waitforc4detonation(var_0) {
  level endon("game_ended");
  var_0 endon("death");

  if(!var_0.hasaioption) {
    thread playerhudoutlineshunterkiller(var_0);
  }

  wait 2;
  var_0 waittill("FirePrimaryWeapon");
  self notify("ForceUncloak");
  playerdohunterkillerbehavior(var_0);
  var_0 radiusdamage(var_0.origin + (0, 0, 50), getassaultvehiclec4radius(), 200, 200, self, "MOD_EXPLOSIVE", "AssaultDrone_C4_mp");
  playFX(common_scripts\utility::getfx("assault_c4_explode"), var_0.origin);
  var_0 notify("death");
}

playerhudoutlineshunterkiller(var_0) {
  foreach(var_2 in level.players) {
    if(self.team != var_2.team && !var_2 maps\mp\_utility::_hasperk("specialty_blindeye")) {
      var_2 hudoutlineenableforclient(self, 0, 1);
    }
  }

  var_0 waittill("death");

  if(!isDefined(self)) {
    return;
  }
  foreach(var_2 in level.players) {
    if(self.team != var_2.team) {
      var_2 hudoutlinedisableforclient(self);
    }
  }
}

onplayerconnecthunterkiller(var_0) {
  var_0 endon("death");

  for(;;) {
    level waittill("connected", var_1);

    if(!isDefined(self)) {
      return;
    }
    if(self.team != var_1.team) {
      var_1 thread onplayerspawnedhunterkiller();
    }
  }
}

onplayerspawnedhunterkiller(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");

  if(isDefined(var_0)) {
    self hudoutlineenableforclient(var_0, 0, 1);
  }
}

playerdohunterkillerbehavior(var_0) {
  var_1 = 7000;
  var_2 = 22500;
  var_3 = 3600;
  self notify("assaultDroneHunterKiller");
  var_0.hunterkiller = 1;

  if(var_0.hasaioption) {
    var_4 = var_0.origin;
  } else {
    var_4 = self getvieworigin(1);
  }

  var_5 = var_0.targetent.origin;
  var_6 = vectornormalize(var_5 - var_4);
  var_5 = var_4 + var_6 * 20000;
  var_7 = bulletTrace(var_4, var_5, 0, var_0, 0, 0, 1, 0, 0);
  var_8 = var_7["position"];
  var_9 = distancesquared(var_0.origin, var_8);

  if(var_9 > var_3) {
    var_10 = undefined;

    if(var_0.hasaioption) {
      var_11 = var_0.origin;
      var_12 = var_0.angles;
    } else {
      var_11 = self getvieworigin(1);
      var_12 = self getangles();
      var_0.camlinkent = spawn("script_model", var_11);
      var_0.camlinkent setModel("tag_player");
      var_0.camlinkent.angles = var_12;
      var_0.camlinkent linkto(var_0, "tag_origin");
      waitframe();
      self playerlinkweaponviewtodelta(var_0.camlinkent, "tag_player", 1, 0, 0, 0, 0, 1);
      self playerlinkedsetviewznear(0);
      self remotecontrolvehicleoff();
      earthquake(0.2, 1, var_11, 100);
      var_10 = spawnfxforclient(common_scripts\utility::getfx("c4_forward_blur"), var_11, self);
      triggerfx(var_10);
    }

    stopFXOnTag(common_scripts\utility::getfx("assault_drone_exhaust"), var_0, "TAG_EXHAUST_REAR");
    var_0 notify("stopShootLocationUpdate");
    var_0 setotherent(undefined);
    var_0 vehicle_teleport(var_0.origin, var_0.angles, 0, 0);
    waitframe();
    thread playerplaytargetfx(var_0, var_8);
    thread playerplaythrustersound(var_0);
    var_13 = gettime() + var_1;
    var_14 = 120;
    var_15 = var_14 * 4 / 5;
    var_0 vehicle_setspeed(var_14, var_15);
    var_0 setvehgoalpos(var_8, 0);
    var_0.staticlevelwaittime = 0.3;
    var_0.alwaysstaticout = 1;
    var_0 setcontents(0);
    waitframe();
    playFXOnTag(common_scripts\utility::getfx("assault_drone_thruster"), var_0, "TAG_EXHAUST_REAR");
    var_9 = distancesquared(var_0.origin, var_8);

    while(gettime() < var_13 && var_9 > var_2) {
      waitframe();
      var_9 = distancesquared(var_0.origin, var_8);
      glassradiusdamage(var_0.origin, 70, 200, 200);
    }

    if(!var_0.hasaioption) {
      var_0.camlinkent unlink();
    }

    while(gettime() < var_13 && var_9 > var_3) {
      waitframe();
      var_9 = distancesquared(var_0.origin, var_8);
      glassradiusdamage(var_0.origin, 70, 200, 200);
    }

    var_0 vehicle_setspeedimmediate(0);

    if(!var_0.hasaioption) {
      var_10 delete();
    }
  }
}

playerplaythrustersound(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 linkto(var_0, "tag_origin");
  var_1 hide();

  foreach(var_3 in level.players) {
    if(self == var_3) {
      continue;
    }
    var_1 showtoplayer(var_3);
  }

  var_1 playsoundonmovingent("assault_drn_kamikaze_boost_npc");
  self playlocalsound("assault_drn_kamikaze_boost_plr");
  wait 2;
  var_1 delete();
}

playerplaytargetfx(var_0, var_1) {
  var_2 = spawn("script_model", var_1);
  var_2 setModel("tag_origin");
  var_2.angles = (-90, 0, 0);
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("assault_drone_marker"), var_2, "tag_origin");
  var_0 waittill("death");
  maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("assault_drone_marker"), var_2, "tag_origin");
  waitframe();
  var_2 delete();
}

spawnmgturret(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  var_1 = "drone_assault_remote_turret_mp";
  var_2 = "vehicle_atlas_aerial_drone_01_mp_turret_50p";
  var_3 = 0.0;
  var_4 = "tag_origin";
  var_5 = (0, 0, 0);
  var_6 = (0, 0, 0);

  if(var_0.mp_terrace) {
    var_1 = "killstreak_terrace_mp";
    var_2 = "vehicle_sniper_drone_turret_mp_cloak";
  }

  var_7 = var_0 gettagorigin(var_4);
  var_8 = spawnturret("misc_turret", var_7, var_1, 0);
  var_8.angles = var_0.angles;
  var_8 setModel(var_2);
  var_8 setdefaultdroppitch(var_3);
  var_8 linkto(var_0, var_4, var_5, var_6);
  var_8.owner = self;
  var_8.health = 99999;
  var_8 setCanDamage(0);
  var_8 setCanRadiusDamage(0);
  var_8.tank = var_0;
  var_8 makeunusable();

  if(var_0.hasaioption) {
    var_8.killcament = var_0;
  }

  var_0.mgturret = var_8;
  var_0.mgturret setmode("sentry_manual");
  var_0.mgturret setsentryowner(self);
  var_0.mgturret setturretminimapvisible(0);
  var_0.mgturret cloakingenable();

  if(!var_0.hasmg) {
    var_0.mgturret turretfiredisable();
  }

  if(var_0.mp_terrace) {
    self enableslowaim(0.2, 0.3, 0.8, 0.8);
    thread terrace_turret_fx(var_0);
  }

  if(!var_0.hasaioption) {
    if(var_0.mp_terrace) {
      thread control_turret_after_delay(var_0, 0.0);
    } else {
      thread control_turret_after_delay(var_0, 1.6);
    }
  }

  thread delete_turret_on_death(var_0);

  if(var_0.hascloak && var_0.hasmg) {
    thread watchmgfireuncloak(var_0);
  }
}

control_turret_after_delay(var_0, var_1) {
  var_2 = 0.0;

  if(var_1 > 0) {
    wait(var_1);
  }

  if(isDefined(self) && isDefined(var_0) && isDefined(var_0.mgturret)) {
    self remotecontrolturret(var_0.mgturret, var_2);
  }
}

watchmgfireuncloak(var_0) {
  var_0 endon("death");
  self endon("disconnect");

  for(;;) {
    var_0 waittill("FirePrimaryWeapon");
    self notify("ForceUncloak");
  }
}

terrace_turret_fx(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  waitframe();
  playfxontagforclients(level._effect["sniper_drone_thruster_view"], var_0.mgturret, "tag_fx2", self);
  waitframe();
  playfxontagforclients(level._effect["sniper_drone_wind_marker"], var_0.mgturret, "tag_fx1", self);
}

delete_turret_on_death(var_0) {
  var_0 waittill("death");

  if(isDefined(self)) {
    self remotecontrolturretoff(var_0.mgturret);
    self thermalvisionfofoverlayoff();
  }

  if(var_0.mp_terrace) {
    stopFXOnTag(level._effect["sniper_drone_thruster_view"], var_0.mgturret, "tag_fx2");
    stopFXOnTag(level._effect["sniper_drone_wind_marker"], var_0.mgturret, "tag_fx1");
  }

  var_0.mgturret delete();
}

setuprockets(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  var_0.rocketammo = 3;

  if(self getclientomnvar("ui_assaultdrone_toggle")) {
    self setclientomnvar("ui_assaultdrone_rockets", var_0.rocketammo);
  }

  for(;;) {
    if(var_0.hasmg) {
      var_0 waittill("FireSecondaryWeapon");
    } else {
      var_0 waittill("FirePrimaryWeapon");
    }

    self notify("ForceUncloak");
    earthquake(0.3, 1, var_0.origin, 500);
    self playrumbleonentity("damage_heavy");
    var_1 = var_0.mgturret gettagorigin("tag_flash");
    var_2 = var_0.targetent.origin;

    if(var_0.hasaioption) {
      var_3 = var_0 vehicle_getvelocity();
    } else {
      var_3 = var_0 getentityvelocity();
    }

    var_4 = magicbullet("ugv_missile_mp", var_1 + var_3 / 10, var_2, self, 1);
    var_0.mgturret playsoundonmovingent("wpn_mahem_npc");
    playFXOnTag(common_scripts\utility::getfx("sentry_rocket_muzzleflash_wv"), var_0.mgturret, "tag_flash");
    var_4 missile_settargetent(var_0.targetent);
    var_4 missile_setflightmodedirect();

    if(var_0.hasaioption) {
      var_4.killcament = var_0;
    }

    var_0.rocketammo--;

    if(var_0.rocketammo > 0) {
      self setclientomnvar("ui_assaultdrone_rockets", var_0.rocketammo);
      wait 1;
      continue;
    }

    self setclientomnvar("ui_assaultdrone_rockets", 4);
    wait 5;
    var_0.rocketammo = 3;
    self setclientomnvar("ui_assaultdrone_rockets", var_0.rocketammo);
  }
}

assaulthudsetup(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  assaulthudremove(var_0);
  wait 0.5;
  self setclientomnvar("ui_assaultdrone_toggle", 1);

  if(var_0.mp_terrace) {
    self forcefirstpersonwhenfollowed();
  }

  maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
  self setclientomnvar("ui_assaultdrone_countdown", var_0.endtime);

  if(!var_0.hasturret) {
    self setclientomnvar("ui_assaultdrone_weapon", 2);
  } else if(var_0.mp_terrace) {
    self setclientomnvar("ui_assaultdrone_weapon", 3);
  } else if(var_0.hasmg) {
    self setclientomnvar("ui_assaultdrone_weapon", 1);
  }

  if(var_0.hasrockets && isDefined(var_0.rocketammo)) {
    self setclientomnvar("ui_assaultdrone_rockets", var_0.rocketammo);
  }

  if(var_0.hascloak) {
    self setclientomnvar("ui_drone_cloak", 2);
  }

  if(isDefined(level.ishorde) && level.ishorde && self getclientomnvar("ui_horde_player_class") == "drone") {
    self setclientomnvar("ui_horde_drone_heal", 1);
  }

  if(var_0.hasarhud) {
    self thermalvisionfofoverlayon();
  }
}

assaulthudremove(var_0) {
  self setclientomnvar("ui_assaultdrone_toggle", 0);
  self setclientomnvar("ui_assaultdrone_countdown", 0);
  self setclientomnvar("ui_drone_cloak", 0);
  self setclientomnvar("ui_drone_cloak_time", 0);
  self setclientomnvar("ui_drone_cloak_cooldown", 0);
  self setclientomnvar("ui_assaultdrone_weapon", 0);
  self setclientomnvar("ui_assaultdrone_rockets", 0);
  maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();

  if(var_0.mp_terrace) {
    self disableforcefirstpersonwhenfollowed();
  }
}

monitoruavsafearea(var_0) {
  self endon("assaultStreakComplete");

  if(var_0.mp_terrace) {
    return;
  }
  thread maps\mp\killstreaks\_aerial_utility::playerhandleboundarystatic(var_0, "assaultStreakComplete");
  thread maps\mp\killstreaks\_aerial_utility::playerhandlekillvehicle(var_0, "assaultStreakComplete");
  var_0 waittill("outOfBounds");
  wait 2;
  var_0 notify("death");
}

monitorplayerdisconnect(var_0) {
  self endon("StopWaitForDisconnect");
  var_0 endon("death");
  self waittill("disconnect");
  var_0 notify("death");
}

monitorplayerswitchteams(var_0) {
  self endon("assaultStreakComplete");
  common_scripts\utility::waittill_any("joined_team", "joined_spectators");
  var_0 notify("death");
}

monitorplayergameended(var_0) {
  self endon("assaultStreakComplete");
  level waittill("game_ended");
  var_0 notify("death");
}

onassaultdronedeath(var_0, var_1, var_2, var_3) {
  self notify("death", var_0, var_2, var_1);

  if(isDefined(level.ishorde) && level.ishorde && isDefined(var_0.ishordeenemysentry) && var_0.ishordeenemysentry) {
    return;
  }
  if(self.mp_terrace) {
    maps\mp\gametypes\_damage::onkillstreakkilled(var_0, var_1, var_2, var_3, "map_killstreak_destroyed", undefined, "callout_destroyed_terrace_sniper_drone", 1);
  } else {
    maps\mp\gametypes\_damage::onkillstreakkilled(var_0, var_1, var_2, var_3, "assault_drone_destroyed", undefined, "callout_destroyed_drone_assault", 1);
  }
}

assaulthandletimeoutwarning(var_0, var_1) {
  var_0 endon("death");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_1 - 10);
  var_2 = 10;

  while(var_2 != 0) {
    if(!var_0.hasaioption) {
      var_0 playSound("mp_warbird_outofbounds_warning");
    }

    var_2 = var_2 - 1;
    wait 1;
  }

  if(isDefined(var_0.hunterkiller)) {
    return;
  }
  var_0 notify("death");
}

assaulthandledeath(var_0) {
  var_1 = var_0 getentitynumber();
  var_0 maps\mp\zombies\killstreaks\_zombie_drone_common::droneaddtogloballist(var_1);
  var_0 waittill("death", var_2);

  if(isDefined(var_0.camlinkent)) {
    var_0.camlinkent unlink();
  }

  if(isDefined(var_0)) {
    var_0 ghost();
  }

  if(isDefined(var_0.mgturret)) {
    var_0.mgturret ghost();
  }

  if(isDefined(self) && !var_0.hasaioption) {
    maps\mp\_utility::freezecontrolswrapper(1);
  }

  self notify("assaultStreakComplete");
  self notify("StopWaitForDisconnect");
  var_0 playSound("assault_drn_death");
  playFX(level._effect["remote_tank_explode"], var_0.origin);
  var_0 maps\mp\zombies\killstreaks\_zombie_drone_common::droneremovefromgloballist(var_1);

  if(isDefined(self) && !var_0.hasturret && !var_0.hasaioption && !level.gameended) {
    wait 1;
    maps\mp\killstreaks\_aerial_utility::playershowfullstatic();
    wait 0.8;
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  }

  if(isDefined(self) && isDefined(var_2) && self != var_2) {
    thread maps\mp\_utility::leaderdialogonplayer("ks_adrone_destroyed", undefined, undefined, self.origin);
  }

  if(!var_0.hasaioption) {
    if(isDefined(self) && !level.gameended) {
      maps\mp\_utility::freezecontrolswrapper(0);
    }

    if(isDefined(self) && (self.using_remote_tank || maps\mp\_utility::isusingremote())) {
      assaultsetinactivity(var_0);
      self.using_remote_tank = 0;
    }
  } else if(isDefined(self)) {
    self.hasaiassaultdrone = 0;
  }

  maps\mp\_utility::decrementfauxvehiclecount();
  level.dronesdeployed--;

  if(isDefined(var_0.camlinkent)) {
    var_0.camlinkent delete();
  }

  var_0 delete();
}

assaultsetinactivity(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = self;

  if(isDefined(var_1.using_remote_tank) && var_1.using_remote_tank) {
    var_1 notify("end_remote");
    var_1 disableslowaim();
    var_1 remotecontrolvehicleoff(var_0);
    var_1 thermalvisionfofoverlayoff();
    thread maps\mp\zombies\killstreaks\_zombie_drone_common::removedronevisionandlightsetpermap(1.5);
    var_1 unlink();

    if(var_1 maps\mp\_utility::isusingremote() && !level.gameended) {
      var_1 maps\mp\_utility::clearusingremote();
    }

    var_1 switch_back_to_player_weapon();
    var_1 maps\mp\_utility::playerrestoreangles();
    var_1 disableplayercommands(var_0);
    thread assaulthudremove(var_0);

    if(getdvarint("camera_thirdPerson")) {
      var_1 maps\mp\_utility::setthirdpersondof(1);
    }

    if(isDefined(var_1.disabledusability) && var_1.disabledusability) {
      var_1 common_scripts\utility::_enableusability();
    }

    var_1.using_remote_tank = 0;
  }
}

switch_back_to_player_weapon() {
  var_0 = maps\mp\_utility::getkillstreakweapon("orbitalsupport");
  self takeweapon(var_0);
  self enableweaponswitch();
  self switchtoweapon(common_scripts\utility::getlastweapon());
}

assaultplayerexit(var_0) {
  if(!isDefined(self)) {
    return;
  }
  var_1 = self;
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("assaultDroneHunterKiller");
  var_0 endon("death");

  for(;;) {
    var_2 = 0;

    while(!var_0.hasaioption && var_1 usebuttonpressed()) {
      var_2 = var_2 + 0.05;

      if(var_2 > 0.75) {
        var_0 notify("death");
        return;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}