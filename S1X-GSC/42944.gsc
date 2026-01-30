/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42944.gsc
**************************************/

init() {
  level._effect["emp_grenade"] = loadfx("vfx/explosion/emp_grenade_explosion");
  level._effect["antenna_light_mp"] = loadfx("vfx/lights/light_reconugv_antenna");
  level._effect["recon_drone_marker_threat"] = loadfx("vfx/ui/vfx_marker_drone_recon");
  level._effect["recon_drone_marker_emp"] = loadfx("vfx/ui/vfx_marker_drone_recon2");
  level._effect["recond_drone_exhaust"] = loadfx("vfx/vehicle/vehicle_mp_recon_drone_smoke");
  level.ugvmarkedarrays = [];
  thread onplayerconnect();
  level.killstreakfuncs["recon_ugv"] = ::tryuserecondrone;
  level.killstreakwieldweapons["recon_drone_turret_mp"] = "recon_ugv";
  level.killstreakwieldweapons["emp_grenade_killstreak_mp"] = "recon_ugv";
  level.killstreakwieldweapons["paint_grenade_killstreak_mp"] = "recon_ugv";
  game["dialog"]["ks_recdrone_destroyed"] = "ks_recdrone_destroyed";
}

getdronespawnpoint() {
  var_0 = maps\mp\killstreaks\_drone_common::dronegetspawnpoint();
  return var_0;
}

tryuserecondrone(var_0, var_1) {
  if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed()) {
    self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
    return 0;
  }

  maps\mp\_utility::incrementfauxvehiclecount();
  var_2 = getdronespawnpoint();

  if(!var_2.placementok) {
    self iprintlnbold(&"MP_DRONE_PLACEMENT_INVALID");
    maps\mp\_utility::decrementfauxvehiclecount();
    return 0;
  }

  common_scripts\utility::_disableweaponswitch();
  var_3 = maps\mp\killstreaks\_killstreaks::initridekillstreak("recon_ugv");

  if(var_3 != "success") {
    common_scripts\utility::_enableweaponswitch();
    maps\mp\_utility::decrementfauxvehiclecount();
    return 0;
  }

  maps\mp\_utility::setusingremote("recon_ugv");
  var_4 = createreconuav(var_0, var_1, var_2.origin, var_2.angles);
  common_scripts\utility::_enableweaponswitch();
  self switchtoweapon("killstreak_predator_missile_mp");

  if(isDefined(var_4)) {
    maps\mp\_matchdata::logkillstreakevent("recon_ugv", self.origin);
    thread maps\mp\_utility::teamplayercardsplash("used_recon_ugv", self);
    return 1;
  } else {
    maps\mp\_utility::decrementfauxvehiclecount();
    return 0;
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  self waittill("spawned_player");
  var_0 = spawnStruct();
  var_0.markedplayerarray = [];
  var_0.markedturretarray = [];
  var_0.owner = self;
  var_0.monitormarkingthread = 0;
  level.ugvmarkedarrays = common_scripts\utility::array_add(level.ugvmarkedarrays, var_0);
}

createreconuav(var_0, var_1, var_2, var_3) {
  var_4 = "recon_uav_mp";
  var_5 = "vehicle_atlas_aerial_drone_02_patrol_mp_static_75p";
  var_6 = spawnhelicopter(self, var_2, var_3, var_4, var_5);

  if(!isDefined(var_6)) {
    return undefined;
  }

  thread playercommonreconvehiclesetup(var_6, var_1, var_0);
  var_6.maxhealth = 250;
  var_6.vehicletype = "drone_recon";
  var_6.vehname = "recon_uav";
  var_6.markdistance = 1500;

  if(var_6.hasincreasedtime) {
    var_7 = 45.0;
  } else {
    var_7 = 30.0;
  }

  var_6.lifespan = var_7;
  var_6.endtime = gettime() + var_7 * 1000;
  var_6 thread maps\mp\gametypes\_damage::setentitydamagecallback(var_6.maxhealth, undefined, ::onrecondronedeath, maps\mp\killstreaks\_aerial_utility::heli_modifydamage, 1);

  if(var_6.hascloak) {
    thread maps\mp\killstreaks\_drone_common::dronecloakready(var_6, var_6.hascloak);
  }

  startusingreconvehicle(var_6);
  thread monitoruavsafearea(var_6);
  thread monitorplayerdisconnect(var_6);
  thread monitorplayerswitchteams(var_6);
  thread monitorplayergameended(var_6);
  thread reconhandletimeoutwarning(var_6);
  thread reconhandletimeout(var_6);
  thread reconhandledeath(var_6);
  thread reconhudsetup(var_6);
  thread maps\mp\killstreaks\_drone_common::playerwatchfordroneemp(var_6);
  var_8 = spawnStruct();
  var_8.validateaccuratetouching = 1;
  var_8.deathoverridecallback = ::override_drone_platform_death;
  var_6 thread maps\mp\_movers::handle_moving_platforms(var_8);
  var_6.getstingertargetposfunc = ::reconuav_stinger_target_pos;
  return var_6;
}

reconuav_stinger_target_pos() {
  return self gettagorigin("tag_origin");
}

override_drone_platform_death(var_0) {
  self notify("death");
}

setupplayercommands(var_0) {
  if(isbot(self)) {
    return;
  }
  self notifyonplayercommand("recon_fire_main", "+attack");
  self notifyonplayercommand("recon_fire_main", "+attack_akimbo_accessible");
  self notifyonplayercommand("recon_fire_secondary", "+speed_throw");
  self notifyonplayercommand("recon_fire_secondary", "+toggleads_throw");
  self notifyonplayercommand("recon_fire_secondary", "+ads_akimbo_accessible");

  if(common_scripts\utility::array_contains(var_0, "recon_ugv_cloak")) {
    self notifyonplayercommand("Cloak", "+activate");
    self notifyonplayercommand("Cloak", "+usereload");
  }
}

disableplayercommands(var_0) {
  if(isbot(self)) {
    return;
  }
  self notifyonplayercommandremove("recon_fire_main", "+attack");
  self notifyonplayercommandremove("recon_fire_main", "+attack_akimbo_accessible");
  self notifyonplayercommandremove("recon_fire_secondary", "+speed_throw");
  self notifyonplayercommandremove("recon_fire_secondary", "+toggleads_throw");
  self notifyonplayercommandremove("recon_fire_secondary", "+ads_akimbo_accessible");

  if(isDefined(var_0) && var_0.hascloak) {
    self notifyonplayercommandremove("Cloak", "+activate");
    self notifyonplayercommandremove("Cloak", "+usereload");
  }
}

playercommonreconvehiclesetup(var_0, var_1, var_2) {
  self endon("reconStreakComplete");
  var_0 endon("death");
  self.using_remote_tank = 0;
  var_0.lifeid = var_2;
  var_0.team = self.team;
  var_0.owner = self;
  var_0.damagetaken = 0;
  var_0.destroyed = 0;
  var_0.empgrenaded = 0;
  var_0.damagefade = 1.0;
  var_0.markedplayers = [];
  var_0.modules = var_1;
  var_0.hasarhud = common_scripts\utility::array_contains(var_0.modules, "recon_ugv_ar_hud");
  var_0.haspaintgrenade = 1;
  var_0.hasassistpoints = common_scripts\utility::array_contains(var_0.modules, "recon_ugv_assist_points");
  var_0.hasstun = common_scripts\utility::array_contains(var_0.modules, "recon_ugv_stun");
  var_0.hasincreasedtime = common_scripts\utility::array_contains(var_0.modules, "recon_ugv_increased_time");
  var_0.hascloak = common_scripts\utility::array_contains(var_0.modules, "recon_ugv_cloak");
  var_0.hasempgrenade = common_scripts\utility::array_contains(var_0.modules, "recon_ugv_emp");
  var_0 hide();
  var_0 makeunusable();
  var_0 makevehiclesolidcapsule(23, -9, 23);
  var_0 setCanDamage(1);
  var_0 common_scripts\utility::make_entity_sentient_mp(var_0.team);
  reconspawnturret(var_0);
  thread maps\mp\killstreaks\_drone_common::dronesetupcloaking(var_0, var_0.hascloak);
  wait 1.6;
  setupplayercommands(var_1);
  thread notify_recon_drone_on_player_command(var_0);
  var_3 = "recon_drone_marker_threat";

  if(var_0.hasempgrenade) {
    var_3 = "recon_drone_marker_emp";
  }

  thread maps\mp\killstreaks\_drone_common::updateshootinglocation(var_0, common_scripts\utility::getfx(var_3), 1);
  thread maps\mp\killstreaks\_drone_common::playerhandleexhaustfx(var_0, "recond_drone_exhaust", "tag_exhaust");
  var_0.mgturret settargetentity(var_0.targetent);
  thread reconplayerexit(var_0);
}

reconspawnturret(var_0) {
  var_1 = "recon_drone_turret_mp";
  var_2 = "tag_turret";
  var_3 = "vehicle_atlas_aerial_drone_02_patrol_mp_turret_75p";
  var_4 = spawnturret("misc_turret", var_0 gettagorigin(var_2), var_1, 0);
  var_4.angles = var_0 gettagangles(var_2);
  var_4 setModel(var_3);
  var_4 setdefaultdroppitch(45.0);
  var_4 linkto(var_0, var_2, (0, 0, 0), (0, 0, 0));
  var_4.owner = var_0.owner;
  var_4.health = 99999;
  var_4.maxhealth = 1000;
  var_4.damagetaken = 0;
  var_4.stunned = 0;
  var_4.stunnedtime = 0.0;
  var_4 setCanDamage(0);
  var_4 setCanRadiusDamage(0);
  var_4 makeunusable();
  var_4.team = var_0.team;
  var_4.pers["team"] = var_0.team;

  if(level.teambased) {
    var_4 setturretteam(var_0.team);
  }

  var_4 setmode("sentry_manual");
  var_4 setsentryowner(var_0.owner);
  var_4 setturretminimapvisible(0);
  var_4.chopper = var_0;
  var_4 setcontents(0);
  var_4.firesoundent = spawn("script_model", var_0 gettagorigin(var_2));
  var_4.firesoundent setModel("tag_origin");
  var_4.firesoundent linktosynchronizedparent(var_0, var_2, (0, 0, 0), (0, 0, 0));
  var_4.firesoundent setcontents(0);
  var_4 hide();
  var_0.mgturret = var_4;

  if(var_0.haspaintgrenade) {
    thread firethreatgrenades(var_0);
  }

  if(var_0.hasempgrenade) {
    thread fireempgrenades(var_0);
  }
}

firethreatgrenades(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  var_1 = gettime();
  var_2 = 0;

  for(;;) {
    self waittill("recon_fire_main");
    self notify("ForceUncloak");
    var_3 = var_0.mgturret gettagorigin("tag_aim");
    var_4 = var_0.targetent.origin;

    if(var_0.hasstun && gettime() >= var_1) {
      var_1 = gettime() + 6000;
      var_2 = 1;
    }

    maps\mp\killstreaks\_aerial_utility::playerfakeshootpaintgrenadeattarget(var_0.mgturret.firesoundent, var_3, var_4, var_2, var_0);
    self setclientomnvar("ui_recondrone_paint", 2);
    wait 2;
    self setclientomnvar("ui_recondrone_paint", 1);
    var_2 = 0;
  }
}

fireempgrenades(var_0) {
  var_0 endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("recon_fire_secondary");
    self notify("ForceUncloak");
    var_1 = var_0.mgturret gettagorigin("tag_aim");
    var_2 = var_0.targetent.origin;
    maps\mp\killstreaks\_aerial_utility::playerfakeshootempgrenadeattarget(var_0.mgturret.firesoundent, var_1, var_2);
    self setclientomnvar("ui_recondrone_emp", 2);
    wait 5;
    self setclientomnvar("ui_recondrone_emp", 1);
  }
}

notify_recon_drone_on_player_command(var_0) {
  self endon("disconnect");
  var_0 endon("death");

  for(;;) {
    var_1 = common_scripts\utility::waittill_any_return("recon_fire_main", "recon_fire_secondary", "Cloak");

    if(isDefined(var_1)) {
      var_0 notify(var_1);
    }
  }
}

startusingreconvehicle(var_0) {
  var_1 = self;

  if(getdvarint("camera_thirdPerson")) {
    var_1 maps\mp\_utility::setthirdpersondof(0);
  }

  var_1 maps\mp\_utility::playersaveangles();
  var_1 cameralinkto(var_0, "tag_origin");
  var_1 remotecontrolvehicle(var_0);
  var_1 thread maps\mp\killstreaks\_drone_common::setdronevisionandlightsetpermap(1.5, var_0);
  var_1.using_remote_tank = 1;

  if(var_1 maps\mp\_utility::isjuggernaut()) {
    var_1.juggernautoverlay.alpha = 0;
  }
}

reconhudsetup(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  reconhudremove(var_0);
  wait 0.5;
  self setclientomnvar("ui_recondrone_toggle", 1);
  maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
  self setclientomnvar("ui_recondrone_countdown", var_0.endtime);

  if(var_0.hascloak) {
    self setclientomnvar("ui_drone_cloak", 2);
  }

  if(var_0.haspaintgrenade) {
    self setclientomnvar("ui_recondrone_paint", 1);
  }

  if(var_0.hasempgrenade) {
    self setclientomnvar("ui_recondrone_emp", 1);
  }

  if(var_0.hasarhud) {
    self thermalvisionfofoverlayon();
  }
}

reconhudremove(var_0) {
  self setclientomnvar("ui_recondrone_toggle", 0);
  self setclientomnvar("ui_recondrone_countdown", 0);
  self setclientomnvar("ui_drone_cloak", 0);
  self setclientomnvar("ui_drone_cloak_time", 0);
  self setclientomnvar("ui_drone_cloak_cooldown", 0);
  self setclientomnvar("ui_recondrone_paint", 0);
  self setclientomnvar("ui_recondrone_emp", 0);
  maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
}

monitoruavsafearea(var_0) {
  self endon("reconStreakComplete");
  thread maps\mp\killstreaks\_aerial_utility::playerhandleboundarystatic(var_0, "reconStreakComplete");
  thread maps\mp\killstreaks\_aerial_utility::playerhandlekillvehicle(var_0, "reconStreakComplete");
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
  self endon("reconStreakComplete");
  common_scripts\utility::waittill_any("joined_team", "joined_spectators");
  var_0 notify("death");
}

monitorplayergameended(var_0) {
  self endon("reconStreakComplete");
  level waittill("game_ended");
  var_0 notify("death");
}

onrecondronedeath(var_0, var_1, var_2, var_3) {
  self notify("death", var_0, var_2, var_1);
  maps\mp\gametypes\_damage::onkillstreakkilled(var_0, var_1, var_2, var_3, "recon_drone_destroyed", undefined, "callout_destroyed_drone_recon", 1);
}

reconhandletimeoutwarning(var_0) {
  var_0 endon("death");
  var_1 = 10.0;
  var_2 = 1.0;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0.lifespan - var_1);

  while(var_1 > 0) {
    var_0 playSound("mp_warbird_outofbounds_warning");
    var_1 = var_1 - var_2;
    wait(var_2);
  }

  var_0 notify("death");
}

reconhandletimeout(var_0) {
  var_0 endon("death");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0.lifespan);
  var_0 notify("death");
}

reconhandledeath(var_0) {
  var_1 = var_0 getentitynumber();
  var_0 maps\mp\killstreaks\_drone_common::droneaddtogloballist(var_1);
  var_0 waittill("death", var_2);

  if(isDefined(var_0)) {
    var_0 ghost();
  }

  if(isDefined(var_0.mgturret)) {
    var_0.mgturret ghost();
  }

  if(isDefined(self)) {
    maps\mp\_utility::freezecontrolswrapper(1);
  }

  self notify("reconStreakComplete");
  self notify("StopWaitForDisconnect");
  var_0 playSound("assault_drn_death");
  var_0 maps\mp\killstreaks\_drone_common::droneremovefromgloballist(var_1);
  waitframe();
  playFXOnTag(level._effect["remote_tank_explode"], var_0, "tag_origin");
  wait 1;
  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

  if(isDefined(self) && !level.gameended) {
    maps\mp\_utility::freezecontrolswrapper(0);
  }

  if(isDefined(self) && isDefined(var_2) && self != var_2) {
    thread maps\mp\_utility::leaderdialogonplayer("ks_recdrone_destroyed", undefined, undefined, self.origin);
  }

  if(isDefined(self) && (self.using_remote_tank || maps\mp\_utility::isusingremote())) {
    reconsetinactivity(var_0);
    self.using_remote_tank = 0;

    if(maps\mp\_utility::isjuggernaut()) {
      self.juggernautoverlay.alpha = 1;
    }
  }

  maps\mp\_utility::decrementfauxvehiclecount();

  if(isDefined(var_0.mgturret)) {
    if(isDefined(var_0.mgturret.firesoundent)) {
      var_0.mgturret.firesoundent delete();
    }

    var_0.mgturret delete();
  }

  if(isDefined(var_0.thing)) {
    var_0.thing delete();
  }

  var_0 delete();
}

reconsetinactivity(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = self;

  if(isDefined(var_1.using_remote_tank) && var_1.using_remote_tank) {
    var_1 notify("end_remote");
    var_1 remotecontrolvehicleoff(var_0);
    var_1 thermalvisionfofoverlayoff();
    thread maps\mp\killstreaks\_drone_common::removedronevisionandlightsetpermap(1.5);
    var_1 reconhudremove(var_0);
    var_1 disableplayercommands(var_0);

    if(var_1 maps\mp\_utility::isusingremote() && !level.gameended) {
      var_1 maps\mp\_utility::clearusingremote();
    }

    var_2 = maps\mp\_utility::getkillstreakweapon("recon_ugv");
    var_1 takeweapon(var_2);
    var_1 enableweaponswitch();
    var_1 switchtoweapon(common_scripts\utility::getlastweapon());
    var_1 maps\mp\_utility::playerrestoreangles();

    if(getdvarint("camera_thirdPerson")) {
      var_1 maps\mp\_utility::setthirdpersondof(1);
    }

    if(isDefined(var_1.disabledusability) && var_1.disabledusability) {
      var_1 common_scripts\utility::_enableusability();
    }

    var_1.using_remote_tank = 0;
  }
}

reconplayerexit(var_0) {
  if(!isDefined(self)) {
    return;
  }
  var_1 = self;
  level endon("game_ended");
  var_1 endon("disconnect");
  var_0 endon("death");

  for(;;) {
    var_2 = 0;

    while(var_1 usebuttonpressed()) {
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