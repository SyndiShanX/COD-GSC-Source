/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_emp.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_hostmigration;
#using scripts\mp\killstreaks\_airsupport;
#using scripts\mp\killstreaks\_emp;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreak_hacking;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_placeables;
#using scripts\mp\teams\_teams;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\popups_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\weapons\_weaponobjects;
#using_animtree("mp_emp_power_core");
#namespace emp;

function init() {
  bundle = struct::get_script_bundle("killstreak", "killstreak_emp");
  level.empkillstreakbundle = bundle;
  level.activeplayeremps = [];
  level.activeemps = [];
  foreach(team in level.teams) {
    level.activeemps[team] = 0;
  }
  level.enemyempactivefunc = & enemyempactive;
  level thread emptracker();
  killstreaks::register("emp", "emp", "killstreak_emp", "emp_used", & activateemp);
  killstreaks::register_strings("emp", & "KILLSTREAK_EARNED_EMP", & "KILLSTREAK_EMP_NOT_AVAILABLE", & "KILLSTREAK_EMP_INBOUND", undefined, & "KILLSTREAK_EMP_HACKED", 0);
  killstreaks::register_dialog("emp", "mpl_killstreak_emp_activate", "empDialogBundle", undefined, "friendlyEmp", "enemyEmp", "enemyEmpMultiple", "friendlyEmpHacked", "enemyEmpHacked", "requestEmp", "threatEmp");
  clientfield::register("scriptmover", "emp_turret_init", 1, 1, "int");
  clientfield::register("vehicle", "emp_turret_deploy", 1, 1, "int");
  spinanim = % mp_emp_power_core::o_turret_emp_core_spin;
  deployanim = % mp_emp_power_core::o_turret_emp_core_deploy;
  callback::on_spawned( & onplayerspawned);
  callback::on_connect( & onplayerconnect);
  vehicle::add_main_callback("emp_turret", & initturretvehicle);
}

function initturretvehicle() {
  turretvehicle = self;
  turretvehicle killstreaks::setup_health("emp");
  turretvehicle.damagetaken = 0;
  turretvehicle.health = turretvehicle.maxhealth;
  turretvehicle clientfield::set("enemyvehicle", 1);
  turretvehicle.soundmod = "drone_land";
  turretvehicle.overridevehicledamage = & onturretdamage;
  turretvehicle.overridevehicledeath = & onturretdeath;
  target_set(turretvehicle, vectorscale((0, 0, 1), 36));
}

function onplayerspawned() {
  self endon("disconnect");
  self updateemp();
}

function onplayerconnect() {
  self.entnum = self getentitynumber();
  level.activeplayeremps[self.entnum] = 0;
}

function activateemp() {
  player = self;
  killstreakid = player killstreakrules::killstreakstart("emp", player.team, 0, 0);
  if(killstreakid == -1) {
    return false;
  }
  bundle = level.empkillstreakbundle;
  empbase = player placeables::spawnplaceable("emp", killstreakid, & onplaceemp, & oncancelplacement, undefined, & onshutdown, undefined, undefined, "wpn_t7_turret_emp_core", "wpn_t7_turret_emp_core_yellow", "wpn_t7_turret_emp_core_red", 1, "", undefined, undefined, 0, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint);
  empbase thread util::ghost_wait_show_to_player(player);
  empbase.othermodel thread util::ghost_wait_show_to_others(player);
  empbase clientfield::set("emp_turret_init", 1);
  empbase.othermodel clientfield::set("emp_turret_init", 1);
  event = empbase util::waittill_any_return("placed", "cancelled", "death", "disconnect");
  if(event != "placed") {
    return false;
  }
  return true;
}

function onplaceemp(emp) {
  player = self;
  assert(isplayer(player));
  assert(!isDefined(emp.vehicle));
  emp.vehicle = spawnvehicle("emp_turret", emp.origin, emp.angles);
  emp.vehicle thread util::ghost_wait_show(0.05);
  emp.vehicle.killstreaktype = emp.killstreaktype;
  emp.vehicle.owner = player;
  emp.vehicle setowner(player);
  emp.vehicle.ownerentnum = player.entnum;
  emp.vehicle.parentstruct = emp;
  player.emptime = gettime();
  player killstreaks::play_killstreak_start_dialog("emp", player.pers["team"], emp.killstreakid);
  player addweaponstat(getweapon("emp"), "used", 1);
  level thread popups::displaykillstreakteammessagetoall("emp", player);
  emp.vehicle killstreaks::configure_team("emp", emp.killstreakid, player);
  emp.vehicle killstreak_hacking::enable_hacking("emp", & hackedcallbackpre, & hackedcallbackpost);
  emp thread killstreaks::waitfortimeout("emp", 60000, & on_timeout, "death");
  if(issentient(emp.vehicle) == 0) {
    emp.vehicle makesentient();
  }
  emp.vehicle vehicle::disconnect_paths(0, 0);
  player thread deployempturret(emp);
}

function deployempturret(emp) {
  player = self;
  player endon("disconnect");
  player endon("joined_team");
  player endon("joined_spectators");
  emp endon("death");
  emp.vehicle useanimtree($mp_emp_power_core);
  emp.vehicle setanim( % mp_emp_power_core::o_turret_emp_core_deploy, 1);
  length = getanimlength( % mp_emp_power_core::o_turret_emp_core_deploy);
  emp.vehicle clientfield::set("emp_turret_deploy", 1);
  wait(length * 0.75);
  emp.vehicle thread playempfx();
  emp.vehicle playSound("mpl_emp_turret_activate");
  emp.vehicle setanim( % mp_emp_power_core::o_turret_emp_core_spin, 1);
  player thread emp_jamenemies(emp, 0);
  wait(length * 0.25);
  emp.vehicle clearanim( % mp_emp_power_core::o_turret_emp_core_deploy, 0);
}

function hackedcallbackpre(hacker) {
  emp_vehicle = self;
  emp_vehicle clientfield::set("enemyvehicle", 2);
  emp_vehicle.parentstruct killstreaks::configure_team("emp", emp_vehicle.parentstruct.killstreakid, hacker, undefined, undefined, undefined, 1);
}

function hackedcallbackpost(hacker) {
  emp_vehicle = self;
  hacker thread emp_jamenemies(emp_vehicle.parentstruct, 1);
}

function doneempfx(fxtagorigin) {
  playFX("killstreaks/fx_emp_exp_death", fxtagorigin);
  playsoundatposition("mpl_emp_turret_deactivate", fxtagorigin);
}

function playempfx() {
  emp_vehicle = self;
  emp_vehicle playLoopSound("mpl_emp_turret_loop_close");
  wait(0.05);
}

function on_timeout() {
  emp = self;
  if(isDefined(emp.vehicle)) {
    fxtagorigin = emp.vehicle gettagorigin("tag_fx");
    doneempfx(fxtagorigin);
  }
  shutdownemp(emp);
}

function oncancelplacement(emp) {
  stopemp(emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid);
}

function onturretdamage(einflictor, attacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  empdamage = 0;
  idamage = self killstreaks::ondamageperweapon("emp", attacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1);
  self.damagetaken = self.damagetaken + idamage;
  if(self.damagetaken > self.maxhealth && !isDefined(self.will_die)) {
    self.will_die = 1;
    self thread ondeathafterframeend(attacker, weapon);
  }
  return idamage;
}

function onturretdeath(inflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self ondeath(attacker, weapon);
}

function ondeathafterframeend(attacker, weapon) {
  waittillframeend();
  if(isDefined(self)) {
    self ondeath(attacker, weapon);
  }
}

function ondeath(attacker, weapon) {
  emp_vehicle = self;
  fxtagorigin = self gettagorigin("tag_fx");
  doneempfx(fxtagorigin);
  if(isDefined(attacker) && isplayer(attacker) && (!isDefined(emp_vehicle.owner) || emp_vehicle.owner util::isenemyplayer(attacker))) {
    attacker challenges::destroyscorestreak(weapon, 0, 1, 0);
    attacker challenges::destroynonairscorestreak_poststatslock(weapon);
    attacker addplayerstat("destroy_turret", 1);
    attacker addweaponstat(weapon, "destroy_turret", 1);
    scoreevents::processscoreevent("destroyed_emp", attacker, emp_vehicle.owner, weapon);
    luinotifyevent(&"player_callout", 2, & "KILLSTREAK_DESTROYED_EMP", attacker.entnum);
  }
  if(isDefined(attacker) && isDefined(emp_vehicle.owner) && attacker != emp_vehicle.owner) {
    emp_vehicle killstreaks::play_destroyed_dialog_on_owner("emp", emp_vehicle.parentstruct.killstreakid);
  }
  shutdownemp(emp_vehicle.parentstruct);
}

function onshutdown(emp) {
  shutdownemp(emp);
}

function shutdownemp(emp) {
  if(!isDefined(emp)) {
    return;
  }
  if(isDefined(emp.already_shutdown)) {
    return;
  }
  emp.already_shutdown = 1;
  if(isDefined(emp.vehicle)) {
    emp.vehicle clientfield::set("emp_turret_deploy", 0);
  }
  stopemp(emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid);
  if(isDefined(emp.othermodel)) {
    emp.othermodel delete();
  }
  if(isDefined(emp.vehicle)) {
    emp.vehicle delete();
  }
  emp delete();
}

function stopemp(currentteam, currentownerentnum, originalteam, killstreakid) {
  stopempeffect(currentteam, currentownerentnum);
  stopemprule(originalteam, killstreakid);
}

function stopempeffect(team, ownerentnum) {
  level.activeemps[team] = 0;
  level.activeplayeremps[ownerentnum] = 0;
  level notify("emp_updated");
}

function stopemprule(killstreakoriginalteam, killstreakid) {
  killstreakrules::killstreakstop("emp", killstreakoriginalteam, killstreakid);
}

function hasactiveemp() {
  return level.activeplayeremps[self.entnum];
}

function teamhasactiveemp(team) {
  return level.activeemps[team] > 0;
}

function enemyempactive() {
  if(level.teambased) {
    foreach(team in level.teams) {
      if(team != self.team && teamhasactiveemp(team)) {
        return true;
      }
    }
  } else {
    enemies = self teams::getenemyplayers();
    foreach(player in enemies) {
      if(player hasactiveemp()) {
        return true;
      }
    }
  }
  return false;
}

function enemyempowner() {
  enemies = self teams::getenemyplayers();
  foreach(player in enemies) {
    if(player hasactiveemp()) {
      return player;
    }
  }
  return undefined;
}

function emp_jamenemies(empent, hacked) {
  level endon("game_ended");
  self endon("killstreak_hacked");
  if(level.teambased) {
    if(hacked) {
      level.activeemps[empent.originalteam] = 0;
    }
    level.activeemps[self.team] = 1;
  }
  if(hacked) {
    level.activeplayeremps[empent.originalownerentnum] = 0;
  }
  level.activeplayeremps[self.entnum] = 1;
  level notify("emp_updated");
  level notify("emp_deployed");
  visionsetnaked("flash_grenade", 1.5);
  wait(0.1);
  visionsetnaked("flash_grenade", 0);
  visionsetnaked(getdvarstring("mapname"), 5);
  empkillstreakweapon = getweapon("emp");
  empkillstreakweapon.isempkillstreak = 1;
  level killstreaks::destroyotherteamsactivevehicles(self, empkillstreakweapon);
  level killstreaks::destroyotherteamsequipment(self, empkillstreakweapon);
  level weaponobjects::destroy_other_teams_supplemental_watcher_objects(self, empkillstreakweapon);
}

function emptracker() {
  level endon("game_ended");
  while(true) {
    level waittill("emp_updated");
    foreach(player in level.players) {
      player updateemp();
    }
  }
}

function updateemp() {
  player = self;
  enemy_emp_active = player enemyempactive();
  player setempjammed(enemy_emp_active);
  emped = player isempjammed();
  player clientfield::set_to_player("empd_monitor_distance", emped);
  if(emped) {
    player notify("emp_jammed");
  }
}