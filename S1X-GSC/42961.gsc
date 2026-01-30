/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42961.gsc
**************************************/

init() {
  level.warbirdsetting = [];
  level.warbirdsetting["Warbird"] = spawnStruct();
  level.warbirdsetting["Warbird"].vehicle = "warbird_player_mp";
  level.warbirdsetting["Warbird"].modelbase = "vehicle_xh9_warbird_low_cloaked_in_out_mp_cloak";
  level.warbirdsetting["Warbird"].helitype = "warbird";
  level.warbirdsetting["Warbird"].maxhealth = level.heli_maxhealth;
  level.killstreakfuncs["warbird"] = ::tryusewarbird;
  level.killstreakwieldweapons["warbird_remote_turret_mp"] = "warbird";
  level.killstreakwieldweapons["warbird_player_turret_mp"] = "warbird";
  level.killstreakwieldweapons["warbird_missile_mp"] = "warbird";
  level.killstreakwieldweapons["paint_missile_killstreak_mp"] = "warbird";

  if(!isDefined(level.spawnedwarbirds)) {
    level.spawnedwarbirds = [];
  }

  if(!isDefined(level.warbirdinuse)) {
    level.warbirdinuse = 0;
  }

  level.chopper_fx["light"]["warbird"] = loadfx("vfx/lights/air_light_wingtip_red");
  level.chopper_fx["engine"]["warbird"] = loadfx("vfx/distortion/distortion_warbird_mp");
  maps\mp\killstreaks\_aerial_utility::makehelitype("warbird", "vfx/explosion/vehicle_warbird_explosion_midair", ::warbirdlightfx);
  maps\mp\killstreaks\_aerial_utility::addairexplosion("warbird", "vfx/explosion/vehicle_warbird_explosion_midair");
  game["dialog"]["assist_mp_warbird"] = "ks_warbird_joinreq";
  game["dialog"]["pilot_sup_mp_warbird"] = "pilot_sup_mp_warbird";
  game["dialog"]["pilot_aslt_mp_warbird"] = "pilot_aslt_mp_warbird";
  game["dialog"]["ks_warbird_destroyed"] = "ks_warbird_destroyed";
}

tryusewarbird(var_0, var_1) {
  if(!canusewarbird()) {
    self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  } else if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed()) {
    self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
    return 0;
  }

  maps\mp\_utility::incrementfauxvehiclecount();
  level.warbirdinuse = 1;
  var_2 = common_scripts\utility::array_contains(var_1, "warbird_ai_attack") || common_scripts\utility::array_contains(var_1, "warbird_ai_follow");

  if(!var_2) {
    thread playerclearwarbirdonteamchange();
    var_3 = maps\mp\killstreaks\_killstreaks::initridekillstreak("warbird");

    if(var_3 != "success") {
      maps\mp\_utility::decrementfauxvehiclecount();
      level.warbirdinuse = 0;
      return 0;
    }

    maps\mp\_utility::setusingremote("warbird");
  }

  var_3 = setupwarbirdkillstreak(var_0, var_1);

  if(var_3) {
    maps\mp\_matchdata::logkillstreakevent("warbird", self.origin);
  }

  return var_3;
}

playerclearwarbirdonteamchange() {
  self endon("rideKillstreakBlack");
  self endon("rideKillstreakFailed");
  self waittill("joined_team");
  level.warbirdinuse = 0;
  maps\mp\_utility::decrementfauxvehiclecount();
}

canusewarbird() {
  return !level.warbirdinuse;
}

iscontrollingwarbird() {
  return isDefined(self.controllingwarbird) && self.controllingwarbird;
}

warbirdmakevehiclesolidcapsule() {
  self endon("death");
  waitframe();
  self makevehiclesolidcapsule(300, -9, 160);
}

setupplayercommands(var_0) {
  if(isbot(self)) {
    return;
  }
  self notifyonplayercommand("SwitchVisionMode", "+actionslot 1");
  self notifyonplayercommand("SwitchWeapon", "weapnext");
  self notifyonplayercommand("ToggleControlState", "+activate");
  self notifyonplayercommand("ToggleControlCancel", "-activate");
  self notifyonplayercommand("ToggleControlState", "+usereload");
  self notifyonplayercommand("ToggleControlCancel", "-usereload");
  self notifyonplayercommand("StartFire", "+attack");
  self notifyonplayercommand("StartFire", "+attack_akimbo_accessible");

  if(isDefined(var_0) && common_scripts\utility::array_contains(var_0, "warbird_cloak")) {
    self notifyonplayercommand("Cloak", "+smoke");
  }
}

disableplayercommands(var_0) {
  if(isbot(self)) {
    return;
  }
  self notifyonplayercommandremove("SwitchVisionMode", "+actionslot 1");
  self notifyonplayercommandremove("SwitchWeapon", "weapnext");
  self notifyonplayercommandremove("ToggleControlState", "+activate");
  self notifyonplayercommandremove("ToggleControlCancel", "-activate");
  self notifyonplayercommandremove("ToggleControlState", "+usereload");
  self notifyonplayercommandremove("ToggleControlCancel", "-usereload");
  self notifyonplayercommandremove("StartFire", "+attack");
  self notifyonplayercommandremove("StartFire", "+attack_akimbo_accessible");

  if(isDefined(var_0) && var_0.cancloak) {
    self notifyonplayercommandremove("Cloak", "+smoke");
  }
}

setupwarbirdkillstreak(var_0, var_1) {
  self endon("warbirdStreakComplete");
  setupplayercommands(var_1);
  self.possesswarbird = 0;
  self.controllingwarbird = 0;
  self.warbirdinit = 1;
  var_2 = buildvalidflightpaths();
  var_3 = findbestspawnlocation(var_2);
  var_3 = rotatehelispawn(var_3);
  var_4 = spawnhelicopter(self, var_3.origin, var_3.angles, level.warbirdsetting["Warbird"].vehicle, level.warbirdsetting["Warbird"].modelbase);
  var_4.currentnode = var_3;

  if(!isDefined(var_4)) {
    return 0;
  }

  var_4 thread warbird_audio();
  var_4 hide();
  var_4 thread warbirdmakevehiclesolidcapsule();
  var_4.targetent = spawn("script_origin", (0, 0, 0));
  var_4.vehicletype = "Warbird";
  var_4.heli_type = level.warbirdsetting["Warbird"].helitype;
  var_4.helitype = level.warbirdsetting["Warbird"].helitype;
  var_4.attractor = missile_createattractorent(var_4, level.heli_attract_strength, level.heli_attract_range);
  var_4.lifeid = var_0;
  var_4.team = self.pers["team"];
  var_4.pers["team"] = self.pers["team"];
  var_4.owner = self;
  var_4.maxhealth = level.warbirdsetting["Warbird"].maxhealth;
  var_4.zoffset = (0, 0, 0);
  var_4.targeting_delay = level.heli_targeting_delay;
  var_4.primarytarget = undefined;
  var_4.secondarytarget = undefined;
  var_4.attacker = undefined;
  var_4.currentstate = "ok";
  var_4.picknewtarget = 1;
  var_4.lineofsight = 0;
  var_4.overheattime = 6;
  var_4.firetime = 0;
  var_4.weaponfire = 0;
  var_4.ismoving = 1;
  var_4.cloakcooldown = 0;
  var_4.iscrashing = 0;
  var_4.ispossessed = 0;
  var_4.modules = var_1;
  var_4.aiattack = common_scripts\utility::array_contains(var_4.modules, "warbird_ai_attack");
  var_4.aifollow = common_scripts\utility::array_contains(var_4.modules, "warbird_ai_follow");
  var_4.hasai = var_4.aiattack || var_4.aifollow;
  var_4.cancloak = common_scripts\utility::array_contains(var_4.modules, "warbird_cloak");
  var_4.hasrockets = common_scripts\utility::array_contains(var_4.modules, "warbird_rockets");
  var_4.coopoffensive = common_scripts\utility::array_contains(var_4.modules, "warbird_coop_offensive");
  var_4.extraflare = common_scripts\utility::array_contains(var_4.modules, "warbird_flares");

  if(var_4.extraflare) {
    var_4.numextraflares = 1;
  } else {
    var_4.numextraflares = 0;
  }

  if(var_4.hasrockets) {
    var_4.rocketclip = 3;
  } else {
    var_4.rocketclip = 0;
  }

  var_4.remainingrocketshots = var_4.rocketclip;

  if(var_4.hasai) {
    var_4.usableent = spawn("script_origin", (0, 0, 0));
    var_4.usableent linkto(var_4);
    var_4.usableent maps\mp\_utility::makegloballyusablebytype("killstreakRemote", &"MP_WARBIRD_PLAYER_PROMPT", self);
  }

  var_4 thread[[level.lightfxfunc["warbird"]]]();
  var_4 common_scripts\utility::make_entity_sentient_mp(var_4.team);

  if(!isDefined(level.spawnedwarbirds)) {
    level.spawnedwarbirds = [];
  }

  level.spawnedwarbirds = common_scripts\utility::array_add(level.spawnedwarbirds, var_4);
  var_4 maps\mp\killstreaks\_aerial_utility::addtohelilist();
  var_4 thread maps\mp\killstreaks\_aerial_utility::heli_flares_monitor(var_4.numextraflares);
  var_4 thread maps\mp\killstreaks\_aerial_utility::heli_leave_on_disconnect(self);
  var_4 thread maps\mp\killstreaks\_aerial_utility::heli_leave_on_changeteams(self);
  var_4 thread maps\mp\killstreaks\_aerial_utility::heli_leave_on_gameended(self);
  var_5 = 30;

  if(common_scripts\utility::array_contains(var_4.modules, "warbird_time")) {
    var_5 = 45;
  }

  if(maps\mp\_utility::_hasperk("specialty_blackbox") && isDefined(self.specialty_blackbox_bonus)) {
    var_5 = var_5 * self.specialty_blackbox_bonus;
  }

  var_4.endtime = gettime() + var_5 * 1000;
  var_4 thread maps\mp\killstreaks\_aerial_utility::heli_leave_on_timeout(var_5);
  var_4 thread maps\mp\killstreaks\_aerial_utility::heli_monitoremp();
  var_4 thread maps\mp\gametypes\_damage::setentitydamagecallback(var_4.maxhealth, undefined, ::warbirdondeath, maps\mp\killstreaks\_aerial_utility::heli_modifydamage, 1);
  var_4 thread warbird_health();
  var_4 thread maps\mp\killstreaks\_aerial_utility::heli_existance();
  thread monitoraiwarbirddeathortimeout(var_4);
  thread monitorplayerdisconnect(var_4);
  var_4.warbirdturret = var_4 spawn_warbird_turret("warbird_remote_turret_mp", "vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak", "tag_player_mp", 0);
  var_4.warbirdturret hide();

  if(!var_4.aiattack && !var_4.aifollow) {
    var_4.warbirdturret showtoplayer(self);
  }

  var_6 = "orbitalsupport_big_turret_mp";

  if(var_4.coopoffensive) {
    var_6 = "warbird_remote_turret_mp";
  }

  var_4.warbirdbuddyturret = var_4 spawn_warbird_turret(var_6, "vehicle_xh9_warbird_turret_cloaked_inout_killstreak_mp_cloak", "tag_playerbuddy_mp", 1);
  var_4.warbirdbuddyturret hide();
  thread setupcloaking(var_4);
  thread warbirdoverheatbarcolormonitor(var_4, var_4.warbirdturret);

  if(var_4.aiattack || var_4.aifollow) {
    thread playermonitorwarbirdpossession(var_4);
  } else {
    thread playercontrolwarbirdsetup(var_4);
  }

  if(isDefined(var_4)) {
    if(level.teambased) {
      level thread handlecoopjoining(var_4, self);
    }

    return 1;
  } else {
    return 0;
  }
}

playermonitorwarbirdpossession(var_0) {
  self endon("warbirdStreakComplete");
  var_0 waittill("cloaked");
  waitframe();

  for(;;) {
    monitoraiwarbirdswitch(var_0);
    var_0.usableent waittill("trigger");
    thread manuallyjoinwarbird();
    playercontrolwarbirdsetup(var_0);
  }
}

manuallyjoinwarbird() {
  self.manuallyjoiningkillstreak = 1;
  common_scripts\utility::waittill_any("death", "initRideKillstreak_complete", "warbirdStreakComplete");
  self.manuallyjoiningkillstreak = 0;
}

warbirdondeath(var_0, var_1, var_2, var_3) {
  maps\mp\gametypes\_damage::onkillstreakkilled(var_0, var_1, var_2, var_3, "warbird_destroyed", "ks_warbird_destroyed", "callout_destroyed_warbird", 1);
}

setupcloaking(var_0) {
  var_0.cloakstate = 0;
  cloakingtransition(var_0, 1, 1);
}

warbirdrockethudupdate(var_0) {
  if(!var_0.hasrockets) {
    return;
  }
  switch (var_0.remainingrocketshots) {
    case 0:
      self setclientomnvar("ui_warbird_missile", 0);
      break;
    case 1:
      self setclientomnvar("ui_warbird_missile", 1);
      break;
    case 2:
      self setclientomnvar("ui_warbird_missile", 2);
      break;
    case 3:
      self setclientomnvar("ui_warbird_missile", 3);
      break;
  }
}

setupwarbirdhud(var_0, var_1, var_2) {
  self endon("warbirdStreakComplete");
  var_0 endon("death");
  self endon("ResumeWarbirdAI");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self forcefirstpersonwhenfollowed();
  maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
  wait 0.05;

  if(var_1) {
    self setclientomnvar("ui_warbird_toggle", 2);
  } else {
    self setclientomnvar("ui_warbird_toggle", 1);
  }

  maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
  self setclientomnvar("ui_warbird_cloak", 0);
  self setclientomnvar("ui_warbird_countdown", var_0.endtime);

  if(!var_1) {
    warbirdrockethudupdate(var_0);
  }

  if(var_1 && !var_0.coopoffensive) {
    self setclientomnvar("ui_warbird_weapon", 3);
  } else if(var_1 && var_0.coopoffensive) {
    self setclientomnvar("ui_warbird_weapon", 0);
  } else if(var_0.hasrockets) {
    self setclientomnvar("ui_warbird_weapon", 1);
  } else {
    self setclientomnvar("ui_warbird_weapon", 0);
  }

  if(var_1) {
    var_3 = var_2 getentitynumber();
    self setclientomnvar("ui_coop_primary_num", var_3);
  }

  if(var_0.cancloak && !var_1) {
    self setclientomnvar("ui_warbird_cloaktext", 1);
  } else {
    self setclientomnvar("ui_warbird_cloaktext", 0);
  }

  self setclientomnvar("ui_killstreak_optic", 0);
}

warbirdoverheatbarcolormonitor(var_0, var_1) {
  self endon("warbirdStreakComplete");
  var_0 endon("death");

  for(;;) {
    var_1.heat_level = var_1 getturretheat();
    self setclientomnvar("ui_warbird_heat", var_1.heat_level);
    var_2 = 0;

    if(isDefined(var_1)) {
      var_2 = var_1 isturretoverheated();
    }

    if(var_2) {
      self setclientomnvar("ui_warbird_fire", 1);
    } else if(var_1.heat_level > 0.7) {
      self setclientomnvar("ui_warbird_fire", 2);
    } else {
      self setclientomnvar("ui_warbird_fire", 0);
    }

    while(var_2) {
      wait 0.05;
      var_2 = var_1 isturretoverheated();
      var_1.heat_level = var_1 getturretheat();
      self setclientomnvar("ui_warbird_heat", var_1.heat_level);
    }

    self notify("overheatFinished");
    waitframe();
  }
}

spawn_warbird_turret(var_0, var_1, var_2, var_3) {
  var_4 = spawnturret("misc_turret", self gettagorigin(var_2), var_0, 0);
  var_4.angles = self gettagangles(var_2);
  var_4 setModel(var_1);
  var_4 setdefaultdroppitch(45.0);
  var_4 linkto(self, var_2, (0, 0, 0), (0, 0, 0));
  var_4.owner = self.owner;
  var_4.health = 99999;
  var_4.maxhealth = 1000;
  var_4.damagetaken = 0;
  var_4.stunned = 0;
  var_4.stunnedtime = 0.0;
  var_4 setCanDamage(0);
  var_4 setCanRadiusDamage(0);
  var_4.team = self.team;
  var_4.pers["team"] = self.team;

  if(level.teambased) {
    var_4 setturretteam(self.team);
  }

  var_4 setmode("sentry_manual");
  var_4 setsentryowner(self.owner);
  var_4 setturretminimapvisible(0);
  var_4.chopper = self;

  if(var_3) {
    var_4.firesoundent = spawn("script_model", self gettagorigin(var_2));
    var_4.firesoundent setModel("tag_origin");
    var_4.firesoundent linktosynchronizedparent(self, var_2, (0, 0, 0), (0, 0, 0));
  }

  return var_4;
}

takeover_warbird_turret_buddy(var_0) {
  if(getdvarint("camera_thirdPerson")) {
    maps\mp\_utility::setthirdpersondof(0);
  }

  var_0.warbirdbuddyturret.owner = self;
  var_0.warbirdbuddyturret setmode("sentry_manual");
  var_0.warbirdbuddyturret setsentryowner(self);
  self playerlinkweaponviewtodelta(var_0.warbirdbuddyturret, "tag_player", 0, 180, 180, -20, 180, 0);
  self playerlinkedsetviewznear(0);
  self playerlinkedsetusebaseangleforviewclamp(1);
  self remotecontrolturret(var_0.warbirdbuddyturret, 45, var_0.angles[1]);
}

findbestspawnlocation(var_0) {
  var_1 = common_scripts\utility::get_array_of_closest(self.origin, var_0);
  return var_1[0];
}

rotatehelispawn(var_0) {
  var_1 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
  var_2 = anglesToForward(var_0.angles);
  var_3 = var_1.origin - var_0.origin;
  var_4 = vectortoangles(var_3);
  var_0.angles = var_4;
  return var_0;
}

buildvalidflightpaths() {
  self endon("warbirdStreakComplete");

  if(!isDefined(level.warbirdflightpathnodes)) {
    level.warbirdflightpathnodes = [];
  } else {
    return level.warbirdflightpathnodes;
  }

  var_0 = maps\mp\killstreaks\_aerial_utility::getentorstruct("heli_loop_start", "targetname");
  var_1 = var_0;
  var_2 = maps\mp\killstreaks\_aerial_utility::gethelianchor();
  var_3 = var_2.origin[2];

  for(;;) {
    var_4 = maps\mp\killstreaks\_aerial_utility::getentorstruct(var_1.target, "targetname");
    var_1.next = var_4;
    var_4.prev = var_1;
    var_4.origin = (var_4.origin[0], var_4.origin[1], var_3);

    if(isinarray(level.warbirdflightpathnodes, var_4)) {
      break;
    }

    level.warbirdflightpathnodes = common_scripts\utility::array_add(level.warbirdflightpathnodes, var_4);
    var_1 = var_4;
  }

  foreach(var_6 in level.warbirdflightpathnodes) {}

  return level.warbirdflightpathnodes;
}

isinarray(var_0, var_1) {
  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(var_3 == var_1) {
        return 1;
      }
    }
  }

  return 0;
}

monitorwarbirdsafearea(var_0) {
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");
  thread maps\mp\killstreaks\_aerial_utility::playerhandleboundarystatic(var_0, "warbirdStreakComplete", "ResumeWarbirdAI");
  var_0 waittill("outOfBounds");
  wait 2;
  var_0 thread maps\mp\killstreaks\_aerial_utility::heli_leave();
}

warbirdaiattack(var_0) {
  thread warbirdfire(var_0);
  thread warbirdlookatenemy(var_0);
  thread warbirdmovetoattackpoint(var_0);
}

warbirdmovetoattackpoint(var_0) {
  self endon("warbirdPlayerControlled");
  self endon("warbirdStreakComplete");

  if(!isDefined(level.warbirdaiattackbasespeed)) {
    level.warbirdaiattackbasespeed = 40;
  }

  if(!isDefined(level.warbirdaiattackneargoal)) {
    level.warbirdaiattackneargoal = 100;
  }

  var_1 = level.warbirdaiattackbasespeed;
  var_0 vehicle_setspeed(var_1, var_1 / 4, var_1 / 4);
  var_0 setneargoalnotifydist(level.warbirdaiattackneargoal);
  var_2 = var_0.currentnode;

  if(!isDefined(var_2)) {
    var_3 = common_scripts\utility::get_array_of_closest(var_0.origin, buildvalidflightpaths());
    var_4 = var_0.origin;

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      var_6 = var_3[var_5].origin;

      if(maps\mp\killstreaks\_aerial_utility::flynodeorgtracepassed(var_4, var_6, var_0)) {
        var_7 = var_6 - var_4;
        var_8 = distance(var_4, var_6);
        var_9 = rotatevector(var_7, (0, 90, 0));
        var_10 = var_4 + var_9 * 100;
        var_11 = var_10 + var_7 * var_8;

        if(maps\mp\killstreaks\_aerial_utility::flynodeorgtracepassed(var_10, var_11, var_0)) {
          var_12 = rotatevector(var_7, (0, -90, 0));
          var_10 = var_4 + var_12 * 100;
          var_11 = var_10 + var_7 * var_8;

          if(maps\mp\killstreaks\_aerial_utility::flynodeorgtracepassed(var_10, var_11, var_0)) {
            var_2 = var_3[var_5];
            break;
          }
        }
      }

      waitframe();
    }
  } else {
    var_2 = var_2.next;
  }

  if(!isDefined(var_2)) {
    return;
  }
  for(;;) {
    var_13 = 0;

    if(var_0.aifollow) {
      var_13 = 1;
    }

    var_0 setvehgoalpos(var_2.origin, var_13);
    var_0.ismoving = 1;
    var_0 waittill("near_goal");
    var_0.currentnode = var_2;
    var_0.ismoving = 0;
    var_2 = waituntilmovereturnnode(var_0);
    var_0.currentnode = undefined;
  }
}

waituntilmovereturnnode(var_0) {
  if(var_0.aifollow && isDefined(var_0.owner)) {
    var_1 = var_0.currentnode;
    var_2 = var_1.next;
    var_3 = var_1.prev;

    while(isDefined(var_0.owner)) {
      var_4 = distance2dsquared(var_0.owner.origin, var_1.origin);
      var_5 = distance2dsquared(var_0.owner.origin, var_2.origin);
      var_6 = distance2dsquared(var_0.owner.origin, var_3.origin);

      if(var_5 < var_4 && var_5 < var_6) {
        return var_2;
      } else if(var_6 < var_4 && var_6 < var_5) {
        return var_3;
      }

      waitframe();
    }
  } else {
    return var_0.currentnode.next;
  }
}

warbirdlookatenemy(var_0) {
  self endon("warbirdPlayerControlled");
  self endon("warbirdStreakComplete");

  for(;;) {
    if(isDefined(var_0.enemy_target)) {
      monitorlookatent(var_0);
      var_0.warbirdturret cleartargetentity();
    }

    waitframe();
  }
}

monitorlookatent(var_0) {
  self endon("warbirdPlayerControlled");
  self endon("warbirdStreakComplete");
  var_0 endon("pickNewTarget");
  var_0 setlookatent(var_0.enemy_target);
  var_0.warbirdturret settargetentity(var_0.enemy_target);
  var_0.enemy_target common_scripts\utility::waittill_either("death", "disconnect");
  var_0.picknewtarget = 1;
  var_0.lineofsight = 0;
}

warbirdfire(var_0) {
  self endon("warbirdPlayerControlled");
  self endon("warbirdStreakComplete");
  thread fireai(var_0);

  for(;;) {
    if(var_0.picknewtarget) {
      var_1 = level.participants;
      var_2 = [];

      foreach(var_4 in var_1) {
        if(var_4.team != self.team) {
          var_2 = common_scripts\utility::array_add(var_2, var_4);
        }
      }

      if(var_0.aiattack) {
        var_2 = sortbydistance(var_2, var_0.origin);
      } else {
        var_2 = sortbydistance(var_2, self.origin);
      }

      var_6 = undefined;

      foreach(var_4 in var_2) {
        if(!isDefined(var_4)) {
          continue;
        }
        if(!isalive(var_4)) {
          continue;
        }
        if(var_4 maps\mp\_utility::_hasperk("specialty_blindeye")) {
          continue;
        }
        if(isDefined(var_4.spawntime) && (gettime() - var_4.spawntime) / 1000 < 5) {
          continue;
        }
        var_6 = var_4;
        var_0.enemy_target = var_6;
        checkwarbirdtargetlos(var_0);
        break;
      }
    }

    var_0 notify("LostLOS");
    wait 0.05;
  }
}

fireai(var_0) {
  self endon("warbirdPlayerControlled");
  self endon("warbirdStreakComplete");
  var_0.remainingrocketshots = var_0.rocketclip;

  for(;;) {
    waitframe();

    if(!isDefined(var_0.enemy_target) || !isalive(var_0.enemy_target) || !var_0.lineofsight) {
      continue;
    }
    if(var_0.hasrockets && var_0.remainingrocketshots) {
      fireairocket(var_0);
    }

    var_0.warbirdturret shootturret();
  }
}

fireairocket(var_0) {
  var_1 = var_0 gettagorigin("tag_missile_right");
  var_2 = vectornormalize(anglesToForward(var_0.angles));
  var_3 = var_0 vehicle_getvelocity();
  var_4 = magicbullet("warbird_missile_mp", var_1 + var_3 / 10, self getEye() + var_3 + var_2 * 1000, self);
  var_4.killcament = var_0;
  playFXOnTag(level.chopper_fx["rocketlaunch"]["warbird"], var_0, "tag_missile_right");
  var_4 missile_settargetent(var_0.enemy_target);
  var_4 missile_setflightmodedirect();
  var_0.remainingrocketshots--;

  if(var_0.remainingrocketshots <= 0) {
    thread warbirdairocketreload(var_0);
  }

  waittillrocketdeath(var_0, var_4);
}

warbirdairocketreload(var_0) {
  var_0 endon("warbirdStreakComplete");
  wait 6;
  var_0.remainingrocketshots = var_0.rocketclip;
}

waittillrocketdeath(var_0, var_1) {
  var_0.enemy_target endon("death");
  var_0.enemy_target endon("disconnect");
  var_1 waittill("death");
}

checkwarbirdtargetlos(var_0) {
  self endon("warbirdPlayerControlled");
  self endon("warbirdStreakComplete");
  var_0.enemy_target endon("death");
  var_0.enemy_target endon("disconnect");

  for(;;) {
    var_1 = var_0 gettagorigin("TAG_FLASH1");
    var_2 = var_0.enemy_target getEye();
    var_3 = vectornormalize(var_2 - var_1);
    var_4 = var_1 + var_3 * 20;
    var_5 = bulletTrace(var_4, var_2, 0, var_0, 0, 0, 0, 0, 0);

    if(!checktargetisinvision(var_0) && var_5["fraction"] < 1) {
      var_0.lineofsight = 0;
      var_0.picknewtarget = 1;
      var_0.enemy_target = undefined;
      var_0 notify("pickNewTarget");
      return;
    }

    var_0.lineofsight = 1;
    wait 0.25;
  }
}

checktargetisinvision(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_2 = var_0.enemy_target.origin - var_0.origin;
  var_3 = vectordot(var_1, var_2);
  return var_3 < 0;
}

playercontrolwarbirdsetup(var_0) {
  self endon("warbirdStreakComplete");
  self.possesswarbird = 1;
  self.controllingwarbird = 1;
  var_0.player = self;
  var_0.currentnode = undefined;
  maps\mp\_utility::playersaveangles();
  waitframe();
  self notify("warbirdPlayerControlled");
  var_0.ispossessed = 1;
  var_0.killcamstarttime = undefined;
  var_0.warbirdturret.killcament = undefined;

  if(self.warbirdinit != 1) {
    maps\mp\_utility::_giveweapon("killstreak_predator_missile_mp");
    self switchtoweapon("killstreak_predator_missile_mp");

    while(self getcurrentweapon() != "killstreak_predator_missile_mp") {
      waitframe();
    }

    thread playerdoridekillstreak(var_0, 0);
    self waittill("initRideKillstreak_complete", var_1);

    if(!var_1) {
      return;
    }
    maps\mp\_utility::setusingremote("Warbird");
  }

  thread setupwarbirdhud(var_0);
  thread monitorwarbirdsafearea(var_0);
  thread waitsetthermal(0.5);
  thread setwarbirdvisionsetpermap(0.5);
  self enableslowaim(0.3, 0.3);
  pausewarbirdenginefxforplayer(var_0);
  var_0.playerattachpoint = spawn("script_model", (0, 0, 0));
  var_0.playerattachpoint setModel("tag_player");
  var_0.playerattachpoint hide();
  var_2 = var_0 gettagorigin("tag_origin");
  var_3 = var_0 gettagangles("tag_origin");
  var_4 = anglesToForward(var_3);
  var_2 = var_2 + var_4 * 165;
  var_2 = var_2 + (0, 0, -10);
  var_0.playerattachpoint.origin = var_2;
  var_0.playerattachpoint.angles = var_3;
  var_0.playerattachpoint linkto(var_0, "tag_player_mp");
  self unlink();
  var_0 cancelaimove(var_0);
  thread warbirdrocketdamageindicator(var_0);
  self remotecontrolvehicle(var_0);
  thread weaponsetup(var_0);
  thread playercloakready(var_0);
  var_0.warbirdturret setmode("sentry_manual");
  self remotecontrolturret(var_0.warbirdturret, 45);

  while(self.possesswarbird) {
    exitwarbirdcontrolstate(var_0);
  }

  maps\mp\_utility::playerrestoreangles();

  if(!var_0.aiattack && !var_0.aifollow) {
    var_0 thread maps\mp\killstreaks\_aerial_utility::heli_leave();
  }
}

setwarbirdvisionsetpermap(var_0) {
  self endon("disconnect");
  self endon("warbirdStreakComplete");
  wait(var_0);

  if(isDefined(level.warbirdvisionset)) {
    self setclienttriggervisionset(level.warbirdvisionset, 0);
  }
}

removewarbirdvisionsetpermap(var_0) {
  self setclienttriggervisionset("", var_0);
}

playerdoridekillstreak(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = "warbird";

  if(var_1) {
    var_2 = "coop";
  }

  var_3 = maps\mp\killstreaks\_killstreaks::initridekillstreak(var_2);

  if(var_3 != "success" || var_1 && !level.warbirdinuse || !isDefined(var_0) || isDefined(var_0.isleaving) && var_0.isleaving) {
    if(var_1) {
      removewarbirdbuddy(var_0, var_3 == "disconnect");
    } else if(var_3 != "disconnect") {
      playerreset(var_0);
    }

    self notify("initRideKillstreak_complete", 0);
    return;
  }

  self notify("initRideKillstreak_complete", 1);
}

exitwarbirdcontrolstate(var_0) {
  self endon("warbirdStreakComplete");
  self waittill("ToggleControlState");
  thread cancelexitbuttonpressmonitor();
  self.possesswarbird = 0;
  wait 0.5;
  self notify("ExitHoldTimeComplete");
}

cancelexitbuttonpressmonitor() {
  self endon("warbirdStreakComplete");
  self endon("ExitHoldTimeComplete");
  self waittill("ToggleControlCancel");
  self.possesswarbird = 1;
}

waitsetthermal(var_0) {
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");
  wait(var_0);
  self thermalvisionfofoverlayon();
  self setblurforplayer(1.1, 0);
  var_1 = 135;
  var_2 = 0;
  var_3 = 60;
  var_4 = 0;
  var_5 = 12;
  var_6 = 5;
  maps\mp\killstreaks\_aerial_utility::thermalvision("warbirdThermalOff", var_1, var_2, var_3, var_4, var_5, var_6);
}

waitsetthermalbuddy(var_0) {
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");
  wait(var_0);
  self thermalvisionfofoverlayon();
  self setblurforplayer(1.1, 0);
  var_1 = 100;
  var_2 = 60;
  var_3 = 512;
  var_4 = 0;
  var_5 = 12;
  var_6 = 5;
  maps\mp\killstreaks\_aerial_utility::thermalvision("warbirdThermalOff", var_1, var_2, var_3, var_4, var_5, var_6);
}

playercloakready(var_0, var_1) {
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");

  if(isDefined(self.warbirdinit) && self.warbirdinit == 1) {
    var_0 waittill("cloaked");
    common_scripts\utility::waittill_any_return_no_endon_death("ForceUncloak", "Cloak", "ResumeWarbirdAI");
    switchtovisible(var_0);
    var_0.playerattachpoint play_sound_on_entity("warbird_cloak_deactivate");
  }

  for(;;) {
    thread playercloakactivated(var_0);
    thread playercloakcooldown(var_0);

    if(var_0.cloakcooldown != 0) {
      self setclientomnvar("ui_warbird_cloaktext", 3);
      wait(var_0.cloakcooldown);
    }

    thread cloakreadydialog();

    if(var_0.cancloak) {
      self setclientomnvar("ui_warbird_cloaktext", 1);
    }

    self waittill("Cloak");
    self notify("ActivateCloak");
    var_0 play_sound_on_entity("warbird_cloak_activate");
    self waittill("CloakCharged");
  }
}

playercloakactivated(var_0) {
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");
  self waittill("ActivateCloak");
  var_1 = 10000;
  self setclientomnvar("ui_warbird_cloaktime", var_1 + gettime());
  switchtocloaked(var_0);
  thread cloakactivateddialog(var_0);
  self setclientomnvar("ui_warbird_cloaktext", 2);
  var_0.cloakcooldown = 5;
  thread cloakcooldown(var_0);
  thread playercloakwaitforexit(var_0);
}

playercloakcooldown(var_0) {
  self endon("warbirdStreakComplete");
  self waittill("UnCloak");
  thread playcloakoverheatdialog(var_0);
  switchtovisible(var_0);
  self setclientomnvar("ui_warbird_cloaktext", 3);
  thread cloakdeactivateddialog(var_0);
}

cloakcooldown(var_0) {
  self endon("warbirdStreakComplete");
  self waittill("UnCloak");

  while(var_0.cloakcooldown > 0) {
    var_0.cloakcooldown = var_0.cloakcooldown - 0.5;
    wait 0.5;
  }

  var_0.cloakcooldown = 0;
  self notify("CloakCharged");
}

playercloakwaitforexit(var_0) {
  self endon("warbirdStreakComplete");
  var_1 = gettime();
  common_scripts\utility::waittill_any_timeout_no_endon_death(10, "ForceUncloak", "Cloak", "ResumeWarbirdAI");
  var_2 = gettime();
  var_3 = max(var_2 - var_1, 5000);
  var_0.cloakcooldown = var_3 / 1000;
  var_4 = gettime() + var_3;
  self setclientomnvar("ui_warbird_cloakdur", var_4);
  self notify("UnCloak");
}

switchtocloaked(var_0) {
  if(isDefined(var_0)) {
    thread cloakingtransition(var_0, 1);
    missile_deleteattractor(var_0.attractor);
    self setclientomnvar("ui_warbird_cloak", 1);
    thread monitordamagewhilecloaking(var_0);
  }
}

switchtovisible(var_0) {
  if(isDefined(var_0)) {
    thread cloakingtransition(var_0, 0);
    var_0.attractor = missile_createattractorent(var_0, level.heli_attract_strength, level.heli_attract_range);
    self setclientomnvar("ui_warbird_cloak", 0);
  }
}

cloakingtransition(var_0, var_1, var_2) {
  var_0 notify("cloaking_transition");
  var_0 endon("cloaking_transition");
  var_0 endon("warbirdStreakComplete");

  if(var_1) {
    if(var_0.cloakstate == -2) {
      return;
    }
    var_0.cloakstate = -1;
    var_0 cloakingenable();
    var_0.warbirdturret cloakingenable();

    if(var_0.coopoffensive) {
      var_0.warbirdbuddyturret cloakingenable();
    }

    var_0 vehicle_setminimapvisible(0);

    if(!isDefined(var_2) || !var_2) {
      wait 0.2;
    } else {
      wait 1.5;
    }

    var_0 show();
    var_0.warbirdturret show();

    if(var_0.coopoffensive) {
      var_0.warbirdbuddyturret show();
    }

    var_0.cloakstate = -2;
    var_0 notify("cloaked");
    var_0 stopwarbirdenginefx();
  } else {
    if(var_0.cloakstate == 2) {
      return;
    }
    var_0.cloakstate = 1;
    var_0 cloakingdisable();
    var_0 vehicle_setminimapvisible(1);
    var_0.warbirdturret cloakingdisable();

    if(var_0.coopoffensive) {
      var_0.warbirdbuddyturret cloakingdisable();
    }

    wait 2.2;
    var_0.cloakstate = 2;
    var_0 playwarbirdenginefx();
  }
}

cloakdeactivateddialog(var_0) {
  self endon("CloakCharged");
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");

  for(;;) {
    self waittill("Cloak");
    var_0.playerattachpoint play_sound_on_entity("warbird_cloak_notready");
    wait 1;
  }
}

cloakreadydialog() {}

cloakactivateddialog(var_0) {}

playcloakoverheatdialog(var_0) {
  var_0.playerattachpoint play_sound_on_entity("warbird_cloak_deactivate");
}

cloakwarbirdexit(var_0, var_1) {
  if(isDefined(var_0) && var_0.iscrashing == 0) {
    if(isDefined(var_1)) {
      var_1 notify("ActivateCloak");
    }

    thread cloakingtransition(var_0, 1);
    missile_deleteattractor(var_0.attractor);
  }
}

monitordamagewhilecloaking(var_0) {
  self endon("UnCloak");
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");
  wait 1;
  var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5);
  self notify("ForceUncloak");
}

warbirdrocketdamageindicator(var_0) {
  self endon("ResumeWarbirdAI");
  self endon("warbirdStreakComplete");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(var_5 == "MOD_PROJECTILE") {
      earthquake(0.75, 1, var_0.origin, 1000);
      self shellshock("frag_grenade_mp", 0.5);
    }
  }
}

updateshootinglocation(var_0) {
  self endon("warbirdStreakComplete");
  level endon("ResumeWarbirdAI");

  for(;;) {
    var_1 = self getangles();
    var_2 = var_0.playerattachpoint.origin;
    var_3 = anglesToForward(var_1);
    var_4 = var_2 + var_3 * 4000;
    var_0.targetent.origin = var_4;
    wait 0.05;
  }
}

monitorweaponselection(var_0) {
  self endon("warbirdStreakComplete");
  self endon("ResumeWarbirdAI");
  self.current_warbird_weapon = "turret";
  var_0.warbirdturret turretfireenable();

  if(!var_0.hasrockets) {
    return;
  }
  for(;;) {
    self waittill("SwitchWeapon");

    if(self.current_warbird_weapon == "turret") {
      self.current_warbird_weapon = "missiles";
      var_0.warbirdturret turretfiredisable();
      self setclientomnvar("ui_warbird_weapon", 2);
    } else if(self.current_warbird_weapon == "missiles") {
      self.current_warbird_weapon = "turret";
      var_0.warbirdturret turretfireenable();
      self setclientomnvar("ui_warbird_weapon", 1);
    }

    self playlocalsound("warbird_weapon_cycle_plr");
  }
}

weaponsetup(var_0) {
  if(var_0.hasrockets) {
    thread firewarbirdrockets(var_0);
  }

  thread monitorweaponselection(var_0);
  thread updateshootinglocation(var_0);
  thread force_uncloak_on_fire(var_0);
}

waittillturretfired(var_0) {
  var_0 endon("warbirdStreakComplete");
  var_0.warbirdturret endon("turret_fire");

  if(var_0.coopoffensive) {
    var_0.warbirdbuddyturret endon("turret_fire");
  }

  level waittill("forever");
}

force_uncloak_on_fire(var_0) {
  level endon("game_ended");
  self endon("warbirdStreakComplete");

  for(;;) {
    waittillturretfired(var_0);
    self notify("ForceUncloak");
    wait 0.05;
  }
}

firewarbirdthreatgrenades(var_0) {
  var_0 endon("warbirdStreakComplete");
  self endon("warbirdStreakComplete");
  self endon("warbird_player_removed");

  for(;;) {
    self waittill("StartFire");
    maps\mp\killstreaks\_aerial_utility::playerfakeshootpaintmissile(var_0.warbirdbuddyturret.firesoundent);
    playFXOnTag(level.chopper_fx["rocketlaunch"]["warbird"], var_0, "tag_origin");
    wait 2;
  }
}

firewarbirdrockets(var_0) {
  self endon("ResumeWarbirdAI");
  self endon("warbirdStreakComplete");
  var_0.remainingrocketshots = var_0.rocketclip;

  for(;;) {
    if(self.guid == "bot0" || self.guid == "bot1" || self.guid == "bot2" || self.guid == "bot3") {
      wait 3;
    } else {
      self waittill("StartFire");
    }

    if(self.current_warbird_weapon == "missiles" || (self.guid == "bot0" || self.guid == "bot1" || self.guid == "bot2" || self.guid == "bot3")) {
      earthquake(0.4, 1, var_0.origin, 1000);
      self playrumbleonentity("ac130_105mm_fire");
      var_1 = var_0 gettagorigin("tag_missile_right");
      var_2 = vectornormalize(anglesToForward(self getangles()));
      var_3 = var_0 getentityvelocity();
      var_4 = magicbullet("warbird_missile_mp", var_1 + var_3 / 10, self getEye() + var_3 + var_2 * 1000, self);
      playFXOnTag(level.chopper_fx["rocketlaunch"]["warbird"], var_0, "tag_missile_right");
      var_4 missile_settargetent(var_0.targetent);
      var_4 missile_setflightmodedirect();
      var_0.remainingrocketshots--;
      self notify("ForceUncloak");
      warbirdrockethudupdate(var_0);

      if(var_0.remainingrocketshots == 0) {
        thread warbirdrocketreloadsound(var_0, 6);
        wait 6;
        var_0.remainingrocketshots = var_0.rocketclip;
        self notify("rocketReloadComplete");
        warbirdrockethudupdate(var_0);
      } else {
        wait 0.05;
      }
    }
  }
}

warbirdrocketreloadsound(var_0, var_1) {
  self endon("rocketReloadComplete");
  self endon("ResumeWarbirdAI");
  self endon("warbirdStreakComplete");
  var_2 = 3;
  self playlocalsound("warbird_missile_reload_bed");
  wait 0.5;

  for(;;) {
    self playlocalsound("warbird_missile_reload");
    wait(var_1 / var_2);
  }
}

handlecoopjoining(var_0, var_1) {
  var_2 = "warbird_coop_defensive";
  var_3 = &"MP_JOIN_WARBIRD_DEF";
  var_4 = "pilot_sup_mp_warbird";
  var_5 = "copilot_sup_mp_paladin";

  if(var_0.coopoffensive) {
    var_2 = "warbird_coop_offensive";
    var_3 = &"MP_JOIN_WARBIRD_OFF";
    var_4 = "pilot_aslt_mp_warbird";
    var_5 = "copilot_aslt_mp_paladin";
  }

  for(;;) {
    var_6 = maps\mp\killstreaks\_coop_util::promptforstreaksupport(var_1.team, var_3, var_2, "assist_mp_warbird", var_4, var_1, var_5);
    level thread watchforjoin(var_6, var_0, var_1);
    var_7 = waittillpromptcomplete(var_0, "buddyJoinedStreak");
    maps\mp\killstreaks\_coop_util::stoppromptforstreaksupport(var_6);

    if(!isDefined(var_7)) {
      return;
    }
    var_7 = waittillpromptcomplete(var_0, "buddyLeftWarbird");

    if(!isDefined(var_7)) {
      return;
    }
  }
}

waittillpromptcomplete(var_0, var_1) {
  var_0 endon("warbirdStreakComplete");
  var_0 waittill(var_1);
  return 1;
}

watchforjoin(var_0, var_1, var_2) {
  var_1 endon("warbirdStreakComplete");
  var_3 = maps\mp\killstreaks\_coop_util::waittillbuddyjoinedstreak(var_0);
  var_1 notify("buddyJoinedStreak");
  var_3 thread buddyjoinwarbirdsetup(var_1, var_2);
}

buddyjoinwarbirdsetup(var_0, var_1) {
  var_0 endon("warbirdStreakComplete");
  self endon("warbirdStreakComplete");
  self endon("warbird_player_removed");
  thread warbirdoverheatbarcolormonitor(var_0, var_0.warbirdbuddyturret);
  var_0.buddy = self;
  self.controllingwarbird = 1;
  thread playerdoridekillstreak(var_0, 1);
  self waittill("initRideKillstreak_complete", var_2);

  if(!var_2) {
    return;
  }
  maps\mp\_utility::setusingremote("Warbird");
  maps\mp\_utility::playersaveangles();
  thread setupwarbirdhud(var_0, 1, var_1);
  thread monitorbuddywarbirddeathortimeout(var_0);
  thread monitorbuddydisconnect(var_0);
  thread waitsetthermalbuddy(0.5);
  thread setwarbirdvisionsetpermap(0.5);
  pausewarbirdenginefxforplayer(var_0);
  thread warbirdrocketdamageindicator(var_0);
  takeover_warbird_turret_buddy(var_0);
  setupplayercommands();

  if(!var_0.coopoffensive) {
    thread firewarbirdthreatgrenades(var_0);
  }

  if(!isbot(self)) {
    thread removewarbirdbuddyoncommand(var_0);
  }
}

removewarbirdbuddy(var_0, var_1) {
  self notify("warbird_player_removed");

  if(!var_1) {
    playerresetwarbirdomnvars();
    self setblurforplayer(0, 0);
    self notify("warbirdThermalOff");
    maps\mp\killstreaks\_aerial_utility::disableorbitalthermal(self);
    thread removewarbirdvisionsetpermap(1.5);
    self thermalvisionfofoverlayoff();

    if(isDefined(var_0.warbirdbuddyturret) && iscontrollingwarbird()) {
      self remotecontrolturretoff(var_0.warbirdbuddyturret);
    }

    self.controllingwarbird = undefined;
    self enableweapons();
    self unlink();
    maps\mp\killstreaks\_coop_util::playerresetaftercoopstreak();
    self disableslowaim();
    disableplayercommands(var_0);
    restartwarbirdenginefxforplayer(var_0);

    if(maps\mp\_utility::isusingremote()) {
      maps\mp\_utility::clearusingremote();
    }

    maps\mp\_utility::playerremotekillstreakshowhud();
    maps\mp\_utility::playerrestoreangles();
  }

  var_0 notify("buddyLeftWarbird");
  var_0.buddy = undefined;
}

monitorbuddywarbirddeathortimeout(var_0) {
  self endon("disconnect");
  var_0 common_scripts\utility::waittill_any("leaving", "death", "crashing");
  self notify("warbirdStreakComplete");
  self notify("StopWaitForDisconnect");
  waittillframeend;
  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  thread removewarbirdbuddy(var_0, 0);
}

monitorbuddydisconnect(var_0) {
  self endon("StopWaitForDisconnect");
  self waittill("disconnect");
  thread removewarbirdbuddy(var_0, 1);
}

removewarbirdbuddyoncommand(var_0) {
  self endon("warbird_player_removed");

  for(;;) {
    self waittill("ToggleControlState");
    thread startwarbirdbuddyexitcommand(var_0);
    thread cancelwarbirdbuddyexitcommand();
  }
}

startwarbirdbuddyexitcommand(var_0) {
  self endon("warbird_player_removed");
  self endon("ToggleControlCancel");
  self.warbird_buddy_exit = 1;
  wait 0.5;

  if(self.warbird_buddy_exit == 1) {
    thread removewarbirdbuddy(var_0, 0);
  }
}

cancelwarbirdbuddyexitcommand() {
  self endon("warbird_player_removed");
  self waittill("ToggleControlCancel");
  self.warbird_buddy_exit = 0;
}

monitoraiwarbirdswitch(var_0, var_1) {
  self endon("warbirdStreakComplete");
  self.warbirdinit = 0;
  self notify("ResumeWarbirdAI");
  self notify("warbirdThermalOff");
  var_0.ispossessed = 0;
  thread cloakingtransition(var_0, 0);
  var_0.warbirdturret setmode("auto_nonai");
  playerresetwarbirdomnvars();
  waittillframeend;
  thread warbirdaiattack(var_0);
  var_0.killcamstarttime = gettime();
  var_0.warbirdturret.killcament = var_0;
  var_0.player = undefined;

  if(maps\mp\_utility::isusingremote()) {
    playerreset(var_0);
  }

  waitframe();
}

monitoraiwarbirddeathortimeout(var_0) {
  self endon("disconnect");
  thread checkforcrashing(var_0);
  var_1 = var_0 common_scripts\utility::waittill_any_return("leaving", "death", "crashing");
  playerresetafterwarbird(var_0);
  level thread warbirdcleanup(var_0, self, var_1 != "death");
}

warbirdcleanup(var_0, var_1, var_2) {
  level.spawnedwarbirds = common_scripts\utility::array_remove(level.spawnedwarbirds, var_0);
  level.warbirdinuse = 0;

  if(isDefined(var_0.usableent)) {
    var_0.usableent maps\mp\_utility::makegloballyunusablebytype();
  }

  thread cloakwarbirdexit(var_0, var_1);

  if(isDefined(var_0.attractor)) {
    missile_deleteattractor(var_0.attractor);
  }

  if(isDefined(var_0.playerattachpoint)) {
    var_0.playerattachpoint delete();
  }

  var_0.enemy_target = undefined;

  if(var_2) {
    var_0 waittill("death");
  } else {
    waittillframeend;
  }

  var_3 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

  if(var_3 != 0) {
    waitframe();
  }

  var_0.warbirdturret delete();

  if(isDefined(var_0.warbirdbuddyturret)) {
    if(isDefined(var_0.warbirdbuddyturret.firesoundent)) {
      var_0.warbirdbuddyturret.firesoundent delete();
    }

    var_0.warbirdbuddyturret delete();
  }

  if(isDefined(var_0.usableent)) {
    var_0.usableent delete();
  }
}

playerresetafterwarbird(var_0) {
  self notify("warbirdStreakComplete");
  var_0 notify("warbirdStreakComplete");
  waittillframeend;
  playerresetwarbirdomnvars();

  if(var_0.ispossessed && !maps\mp\_utility::isinremotetransition()) {
    playerreset(var_0);
    var_0.ispossessed = 0;
  }

  disableplayercommands(var_0);
  self notify("StopWaitForDisconnect");
}

playerreset(var_0) {
  self setblurforplayer(0, 0);
  maps\mp\killstreaks\_aerial_utility::disableorbitalthermal(self);
  self thermalvisionfofoverlayoff();
  thread removewarbirdvisionsetpermap(1.5);
  self remotecontrolvehicleoff();

  if(isDefined(var_0.warbirdturret) && iscontrollingwarbird()) {
    self remotecontrolturretoff(var_0.warbirdturret);
  }

  self.controllingwarbird = undefined;
  self.possesswarbird = undefined;
  self enableweapons();
  self unlink();

  if(maps\mp\_utility::isusingremote()) {
    maps\mp\_utility::clearusingremote();
  } else {
    var_1 = self getcurrentweapon();

    if(var_1 == "none" || maps\mp\_utility::iskillstreakweapon(var_1)) {
      self switchtoweapon(common_scripts\utility::getlastweapon());
    }

    maps\mp\_utility::playerremotekillstreakshowhud();
  }

  thread playerdelaycontrol();

  if(var_0.hasai) {
    maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe("killstreak_predator_missile_mp");
  }

  self enableweaponswitch();
  self disableslowaim();

  if(!isDefined(var_0.isleaving) || !var_0.isleaving) {
    restartwarbirdenginefxforplayer(var_0);
  }

  maps\mp\_utility::playerrestoreangles();
}

playerdelaycontrol() {
  self endon("disconnect");
  maps\mp\_utility::freezecontrolswrapper(1);
  wait 0.5;
  maps\mp\_utility::freezecontrolswrapper(0);
}

checkforcrashing(var_0) {
  var_0 common_scripts\utility::waittill_any("crashing", "death");
  var_0.iscrashing = 1;
}

monitorplayerdisconnect(var_0) {
  self endon("StopWaitForDisconnect");
  self waittill("disconnect");
  var_0 notify("warbirdStreakComplete");
  self notify("warbirdStreakComplete");
  self notify("warbirdThermalOff");
  var_0 thread maps\mp\killstreaks\_aerial_utility::heli_leave();
  level thread warbirdcleanup(var_0, self, 1);
}

play_sound_on_entity(var_0) {
  self playSound(var_0);
}

warbird_health() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.currentstate = "ok";
  self.laststate = "ok";
  self setdamagestage(3);
  var_0 = 3;
  self setdamagestage(var_0);

  for(;;) {
    if(self.damagetaken >= self.maxhealth * 0.33 && var_0 == 3) {
      var_0 = 2;
      self setdamagestage(var_0);
      self.currentstate = "light smoke";
      playFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, "tag_static_main_rotor_l");
    } else if(self.damagetaken >= self.maxhealth * 0.66 && var_0 == 2) {
      var_0 = 1;
      self setdamagestage(var_0);
      self.currentstate = "heavy smoke";
      stopFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, "tag_static_main_rotor_l");
      playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_static_main_rotor_l");
    } else if(self.damagetaken >= self.maxhealth) {
      var_0 = 0;
      self setdamagestage(var_0);

      if(isDefined(self.largeprojectiledamage) && self.largeprojectiledamage) {
        thread maps\mp\killstreaks\_aerial_utility::heli_explode(1);
      } else {
        playFXOnTag(level.chopper_fx["damage"]["on_fire"], self, "TAG_TAIL_FX");
        thread maps\mp\killstreaks\_aerial_utility::heli_crash();
      }
    }

    wait 0.05;
  }
}

playerresetwarbirdomnvars() {
  self setclientomnvar("ui_warbird_heat", 0);
  self setclientomnvar("ui_warbird_flares", 0);
  self setclientomnvar("ui_warbird_fire", 0);
  self setclientomnvar("ui_warbird_cloak", 0);
  self setclientomnvar("ui_warbird_cloaktime", 0);
  self setclientomnvar("ui_warbird_cloakdur", 0);
  self setclientomnvar("ui_warbird_countdown", 0);
  self setclientomnvar("ui_warbird_missile", -1);
  self setclientomnvar("ui_warbird_weapon", 0);
  self setclientomnvar("ui_warbird_cloaktext", 0);
  self setclientomnvar("ui_warbird_toggle", 0);
  self setclientomnvar("ui_coop_primary_num", 0);
  maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
  self disableforcefirstpersonwhenfollowed();
}

playwarbirdenginefx() {
  playFXOnTag(level.chopper_fx["engine"]["warbird"], self, "tag_static_main_rotor_r");
  playFXOnTag(level.chopper_fx["engine"]["warbird"], self, "tag_static_main_rotor_l");

  if(isDefined(self.player)) {
    self.player pausewarbirdenginefxforplayer(self);
  }

  if(isDefined(self.buddy)) {
    self.buddy pausewarbirdenginefxforplayer(self);
  }
}

stopwarbirdenginefx() {
  stopFXOnTag(level.chopper_fx["engine"]["warbird"], self, "tag_static_main_rotor_r");
  stopFXOnTag(level.chopper_fx["engine"]["warbird"], self, "tag_static_main_rotor_l");
}

pausewarbirdenginefxforplayer(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  stopfxontagforclient(level.chopper_fx["engine"]["warbird"], var_0, "tag_static_main_rotor_r", self);
  stopfxontagforclient(level.chopper_fx["engine"]["warbird"], var_0, "tag_static_main_rotor_l", self);
}

restartwarbirdenginefxforplayer(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(maps\mp\killstreaks\_aerial_utility::vehicleiscloaked()) {
    return;
  }
  playfxontagforclients(level.chopper_fx["engine"]["warbird"], var_0, "tag_static_main_rotor_r", self);
  playfxontagforclients(level.chopper_fx["engine"]["warbird"], var_0, "tag_static_main_rotor_l", self);
}

warbird_audio() {
  if(isDefined(self)) {
    return;
  }
}

warbirdlightfx() {
  self endon("death");

  for(;;) {
    self.owner waittill("UnCloak");
    playFXOnTag(level.chopper_fx["light"]["warbird"], self, "tag_light_body_L");
    wait 0.05;
    playFXOnTag(level.chopper_fx["light"]["warbird"], self, "tag_light_body_R");
    wait 0.05;
    playFXOnTag(level.chopper_fx["light"]["warbird"], self, "tag_light_tail");
    self.owner waittill("ActivateCloak");
    stopFXOnTag(level.chopper_fx["light"]["warbird"], self, "tag_light_body_L");
    wait 0.05;
    stopFXOnTag(level.chopper_fx["light"]["warbird"], self, "tag_light_body_R");
    wait 0.05;
    stopFXOnTag(level.chopper_fx["light"]["warbird"], self, "tag_light_tail");
  }
}