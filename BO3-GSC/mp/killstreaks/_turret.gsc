/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_turret.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_hostmigration;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\killstreaks\_airsupport;
#using scripts\mp\killstreaks\_emp;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreak_hacking;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_placeables;
#using scripts\mp\killstreaks\_remote_weapons;
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
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\weapons\_weaponobjects;
#using_animtree("mp_autoturret");
#namespace turret;

function init() {
  killstreaks::register("autoturret", "autoturret", "killstreak_auto_turret", "auto_turret_used", & activateturret);
  killstreaks::register_alt_weapon("autoturret", "auto_gun_turret");
  killstreaks::register_remote_override_weapon("autoturret", "killstreak_remote_turret");
  killstreaks::register_strings("autoturret", & "KILLSTREAK_EARNED_AUTO_TURRET", & "KILLSTREAK_AUTO_TURRET_NOT_AVAILABLE", & "KILLSTREAK_AUTO_TURRET_INBOUND", undefined, & "KILLSTREAK_AUTO_TURRET_HACKED", 0);
  killstreaks::register_dialog("autoturret", "mpl_killstreak_auto_turret", "turretDialogBundle", undefined, "friendlyTurret", "enemyTurret", "enemyTurretMultiple", "friendlyTurretHacked", "enemyTurretHacked", "requestTurret", "threatTurret");
  level.killstreaks["autoturret"].threatonkill = 1;
  clientfield::register("vehicle", "auto_turret_open", 1, 1, "int");
  clientfield::register("scriptmover", "auto_turret_init", 1, 1, "int");
  clientfield::register("scriptmover", "auto_turret_close", 1, 1, "int");
  level.autoturretopenanim = % mp_autoturret::o_turret_sentry_deploy;
  level.autoturretcloseanim = % mp_autoturret::o_turret_sentry_close;
  remote_weapons::registerremoteweapon("autoturret", & "MP_REMOTE_USE_TURRET", & startturretremotecontrol, & endturretremotecontrol, 1);
  vehicle::add_main_callback("sentry_turret", & initturret);
  visionset_mgr::register_info("visionset", "turret_visionset", 1, 81, 16, 1, & visionset_mgr::ramp_in_out_thread_per_player, 0);
}

function initturret() {
  turretvehicle = self;
  turretvehicle.dontfreeme = 1;
  turretvehicle.damage_on_death = 0;
  turretvehicle.delete_on_death = undefined;
  turretvehicle.watch_remote_weapon_death = 1;
  turretvehicle.watch_remote_weapon_death_duration = 1.2;
  turretvehicle.maxhealth = 2000;
  turretvehicle.damagetaken = 0;
  tablehealth = killstreak_bundles::get_max_health("autoturret");
  if(isdefined(tablehealth)) {
    turretvehicle.maxhealth = tablehealth;
  }
  turretvehicle.health = turretvehicle.maxhealth;
  turretvehicle set_max_target_distance(2500, 0);
  turretvehicle set_min_target_distance_squared(distancesquared(turretvehicle gettagorigin("tag_flash"), turretvehicle gettagorigin("tag_barrel")), 0);
  turretvehicle set_on_target_angle(15, 0);
  turretvehicle clientfield::set("enemyvehicle", 1);
  turretvehicle.soundmod = "drone_land";
  turretvehicle.overridevehicledamage = & onturretdamage;
  turretvehicle.overridevehicledeath = & onturretdeath;
}

function activateturret() {
  player = self;
  assert(isplayer(player));
  killstreakid = self killstreakrules::killstreakstart("autoturret", player.team, 0, 0);
  if(killstreakid == -1) {
    return false;
  }
  bundle = level.killstreakbundle["autoturret"];
  turret = player placeables::spawnplaceable("autoturret", killstreakid, & onplaceturret, & oncancelplacement, & onpickupturret, & onshutdown, undefined, undefined, "veh_t7_turret_sentry_gun_world_mp", "veh_t7_turret_sentry_gun_world_yellow", "veh_t7_turret_sentry_gun_world_red", 1, & "KILLSTREAK_SENTRY_TURRET_PICKUP", 90000, undefined, 0, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint);
  turret thread watchturretshutdown(killstreakid, player.team);
  turret thread util::ghost_wait_show_to_player(player);
  turret.othermodel thread util::ghost_wait_show_to_others(player);
  turret clientfield::set("auto_turret_init", 1);
  turret.othermodel clientfield::set("auto_turret_init", 1);
  event = turret util::waittill_any_return("placed", "cancelled", "death");
  if(event != "placed") {
    return false;
  }
  turret playsound("mpl_turret_startup");
  return true;
}

function onplaceturret(turret) {
  player = self;
  assert(isplayer(player));
  if(isdefined(turret.vehicle)) {
    turret.vehicle.origin = turret.origin;
    turret.vehicle.angles = turret.angles;
    turret.vehicle thread util::ghost_wait_show(0.05);
    turret.vehicle playsound("mpl_turret_startup");
  } else {
    turret.vehicle = spawnvehicle("sentry_turret", turret.origin, turret.angles, "dynamic_spawn_ai");
    turret.vehicle.owner = player;
    turret.vehicle setowner(player);
    turret.vehicle.ownerentnum = player.entnum;
    turret.vehicle.parentstruct = turret;
    turret.vehicle.controlled = 0;
    turret.vehicle.treat_owner_damage_as_friendly_fire = 1;
    turret.vehicle.ignore_team_kills = 1;
    turret.vehicle.deal_no_crush_damage = 1;
    turret.vehicle.team = player.team;
    turret.vehicle setteam(player.team);
    turret.vehicle set_team(player.team, 0);
    turret.vehicle set_torso_targetting(0);
    turret.vehicle set_target_leading(0);
    turret.vehicle.use_non_teambased_enemy_selection = 1;
    turret.vehicle.waittill_turret_on_target_delay = 0.25;
    turret.vehicle.ignore_vehicle_underneath_splash_scalar = 1;
    turret.vehicle killstreaks::configure_team("autoturret", turret.killstreakid, player, "small_vehicle");
    turret.vehicle killstreak_hacking::enable_hacking("autoturret", & hackedcallbackpre, & hackedcallbackpost);
    turret.vehicle thread turret_watch_owner_events();
    turret.vehicle thread turret_laser_watch();
    turret.vehicle thread setup_death_watch_for_new_targets();
    turret.vehicle createturretinfluencer("turret");
    turret.vehicle createturretinfluencer("turret_close");
    turret.vehicle thread util::ghost_wait_show(0.05);
    if(issentient(turret.vehicle) == 0) {
      turret.vehicle makesentient();
    }
    player killstreaks::play_killstreak_start_dialog("autoturret", player.pers["team"], turret.killstreakid);
    level thread popups::displaykillstreakteammessagetoall("autoturret", player);
    player addweaponstat(getweapon("autoturret"), "used", 1);
    turret.vehicle.killstreak_end_time = (gettime() + 90000) + 5000;
  }
  turret.vehicle enable(0, 0);
  target_set(turret.vehicle, vectorscale((0, 0, 1), 36));
  turret.vehicle unlink();
  turret.vehicle vehicle::disconnect_paths(0, 0);
  turret.vehicle thread turretscanning();
  turret play_deploy_anim();
  player remote_weapons::useremoteweapon(turret.vehicle, "autoturret", 0);
}

function hackedcallbackpre(hacker) {
  turretvehicle = self;
  turretvehicle clientfield::set("enemyvehicle", 2);
  turretvehicle.owner clientfield::set_to_player("static_postfx", 0);
  if(turretvehicle.controlled === 1) {
    visionset_mgr::deactivate("visionset", "turret_visionset", turretvehicle.owner);
  }
  turretvehicle.owner remote_weapons::removeandassignnewremotecontroltrigger(turretvehicle.usetrigger);
  turretvehicle remote_weapons::endremotecontrolweaponuse(1);
  turretvehicle.owner unlink();
  turretvehicle clientfield::set("vehicletransition", 0);
}

function hackedcallbackpost(hacker) {
  turretvehicle = self;
  hacker remote_weapons::useremoteweapon(turretvehicle, "autoturret", 0);
  turretvehicle notify("watchremotecontroldeactivate_remoteweapons");
  turretvehicle.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(turretvehicle);
}

function play_deploy_anim_after_wait(wait_time) {
  turret = self;
  turret endon("death");
  wait(wait_time);
  turret play_deploy_anim();
}

function play_deploy_anim() {
  turret = self;
  turret clientfield::set("auto_turret_close", 0);
  turret.othermodel clientfield::set("auto_turret_close", 0);
  if(isdefined(turret.vehicle)) {
    turret.vehicle clientfield::set("auto_turret_open", 1);
  }
}

function oncancelplacement(turret) {
  turret notify("sentry_turret_shutdown");
}

function onpickupturret(turret) {
  player = self;
  turret.vehicle ghost();
  turret.vehicle disable(0);
  turret.vehicle linkto(turret);
  target_remove(turret.vehicle);
  turret clientfield::set("auto_turret_close", 1);
  turret.othermodel clientfield::set("auto_turret_close", 1);
  if(isdefined(turret.vehicle)) {
    turret.vehicle notify("end_turret_scanning");
    turret.vehicle setturrettargetrelativeangles((0, 0, 0));
    turret.vehicle clientfield::set("auto_turret_open", 0);
    if(isdefined(turret.vehicle.usetrigger)) {
      turret.vehicle.usetrigger delete();
      turret.vehicle playsound("mpl_turret_down");
    }
    turret.vehicle vehicle::connect_paths();
  }
}

function onturretdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  empdamage = int((idamage + (self.healthdefault * 1)) + 0.5);
  idamage = self killstreaks::ondamageperweapon("autoturret", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1);
  self.damagetaken = self.damagetaken + idamage;
  if(self.controlled) {
    self.owner vehicle::update_damage_as_occupant(self.damagetaken, self.maxhealth);
  }
  if(self.damagetaken > self.maxhealth && !isdefined(self.will_die)) {
    self.will_die = 1;
    self thread ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }
  return idamage;
}

function onturretdeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

function ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  waittillframeend();
  if(isdefined(self)) {
    self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }
}

function ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  turretvehicle = self;
  if(turretvehicle.dead === 1) {
    return;
  }
  turretvehicle.dead = 1;
  turretvehicle disabledriverfiring(1);
  turretvehicle disable(0);
  turretvehicle vehicle::connect_paths();
  eattacker = self[[level.figure_out_attacker]](eattacker);
  if(isdefined(turretvehicle.parentstruct)) {
    turretvehicle.parentstruct placeables::forceshutdown();
    if(turretvehicle.parentstruct.killstreaktimedout === 1 && isdefined(turretvehicle.owner)) {
      turretvehicle.owner globallogic_audio::play_taacom_dialog("timeout", turretvehicle.parentstruct.killstreaktype);
    } else if(isdefined(eattacker) && isdefined(turretvehicle.owner) && eattacker != turretvehicle.owner) {
      turretvehicle.parentstruct killstreaks::play_destroyed_dialog_on_owner(turretvehicle.parentstruct.killstreaktype, turretvehicle.parentstruct.killstreakid);
    }
  }
  if(isdefined(eattacker) && isplayer(eattacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(eattacker))) {
    scoreevents::processscoreevent("destroyed_sentry_gun", eattacker, self, weapon);
    eattacker challenges::destroyscorestreak(weapon, turretvehicle.controlled, 1, 0);
    eattacker challenges::destroynonairscorestreak_poststatslock(weapon);
    eattacker addplayerstat("destroy_turret", 1);
    eattacker addweaponstat(weapon, "destroy_turret", 1);
    luinotifyevent(&"player_callout", 2, & "KILLSTREAK_DESTROYED_AUTO_TURRET", eattacker.entnum);
  }
  turretvehicle vehicle_death::death_fx();
  turretvehicle playsound("mpl_m_turret_exp");
  wait(0.1);
  turretvehicle ghost();
  turretvehicle notsolid();
  turretvehicle util::waittill_any_timeout(2, "remote_weapon_end");
  if(isdefined(turretvehicle)) {
    while (isdefined(turretvehicle) && (turretvehicle.controlled || !isdefined(turretvehicle.owner))) {
      wait(0.05);
    }
    turretvehicle.dontfreeme = undefined;
    wait(0.5);
    if(isdefined(turretvehicle)) {
      turretvehicle delete();
    }
  }
}

function onshutdown(turret) {
  turret notify("sentry_turret_shutdown");
}

function startturretremotecontrol(turretvehicle) {
  player = self;
  assert(isplayer(player));
  turretvehicle disable(0);
  turretvehicle usevehicle(player, 0);
  turretvehicle clientfield::set("vehicletransition", 1);
  turretvehicle.controlled = 1;
  turretvehicle.treat_owner_damage_as_friendly_fire = 0;
  turretvehicle.ignore_team_kills = 0;
  player vehicle::set_vehicle_drivable_time(90000 + 5000, turretvehicle.killstreak_end_time);
  loc_000023E4:
    player vehicle::update_damage_as_occupant((isdefined(turretvehicle.damagetaken) ? turretvehicle.damagetaken : 0), (isdefined(turretvehicle.maxhealth) ? turretvehicle.maxhealth : 100));
  visionset_mgr::activate("visionset", "turret_visionset", self, 1, 90000, 1);
}

function endturretremotecontrol(turretvehicle, exitrequestedbyowner) {
  if(exitrequestedbyowner) {
    turretvehicle thread enableturretafterwait(0.1);
  }
  turretvehicle clientfield::set("vehicletransition", 0);
  if(isdefined(turretvehicle.owner) && turretvehicle.controlled === 1) {
    visionset_mgr::deactivate("visionset", "turret_visionset", turretvehicle.owner);
  }
  turretvehicle.controlled = 0;
  turretvehicle.treat_owner_damage_as_friendly_fire = 1;
  turretvehicle.ignore_team_kills = 1;
}

function enableturretafterwait(wait_time) {
  self endon("death");
  if(isdefined(self.owner)) {
    self.owner endon("joined_team");
    self.owner endon("disconnect");
    self.owner endon("joined_spectators");
  }
  wait(wait_time);
  self enable(0, 0);
}

function createturretinfluencer(name) {
  turret = self;
  preset = getinfluencerpreset(name);
  if(!isdefined(preset)) {
    return;
  }
  projected_point = turret.origin + (vectorscale(anglestoforward(turret.angles), preset["radius"] * 0.7));
  return spawning::create_enemy_influencer(name, turret.origin, turret.team);
}

function turret_watch_owner_events() {
  self notify("turret_watch_owner_events_singleton");
  self endon("tturet_watch_owner_events_singleton");
  self endon("death");
  self.owner util::waittill_any("joined_team", "disconnect", "joined_spectators");
  self makevehicleusable();
  self.controlled = 0;
  if(isdefined(self.owner)) {
    self.owner unlink();
    self clientfield::set("vehicletransition", 0);
  }
  self makevehicleunusable();
  if(isdefined(self.owner)) {
    self.owner killstreaks::clear_using_remote();
  }
  self.abandoned = 1;
  onshutdown(self);
}

function turret_laser_watch() {
  turretvehicle = self;
  turretvehicle endon("death");
  while (true) {
    laser_should_be_on = !turretvehicle.controlled && turretvehicle does_have_target(0);
    if(laser_should_be_on) {
      if(islaseron(turretvehicle) == 0) {
        turretvehicle enable_laser(1, 0);
      }
    } else if(islaseron(turretvehicle)) {
      turretvehicle enable_laser(0, 0);
    }
    wait(0.25);
  }
}

function setup_death_watch_for_new_targets() {
  turretvehicle = self;
  turretvehicle endon("death");
  old_target = undefined;
  while (true) {
    turretvehicle waittill("has_new_target", new_target);
    if(isdefined(old_target)) {
      old_target notify("abort_death_watch");
    }
    new_target thread target_death_watch(turretvehicle);
    old_target = new_target;
  }
}

function target_death_watch(turretvehicle) {
  target = self;
  target endon("abort_death_watch");
  turretvehicle endon("death");
  target util::waittill_any("death", "disconnect", "joined_team", "joined_spectators");
  turretvehicle stop(0, 1);
}

function turretscanning() {
  turretvehicle = self;
  turretvehicle endon("death");
  turretvehicle endon("end_turret_scanning");
  turret_data = turretvehicle _get_turret_data(0);
  turretvehicle.do_not_clear_targets_during_think = 1;
  wait(0.8);
  while (true) {
    if(turretvehicle.controlled) {
      wait(0.5);
      continue;
    }
    if(turretvehicle does_have_target(0)) {
      wait(0.25);
      continue;
    }
    turret_data = turretvehicle _get_turret_data(0);
    turretvehicle clear_target(0);
    if(turretvehicle.scanpos === "left") {
      turretvehicle setturrettargetrelativeangles((0, turret_data.leftarc - 10, 0), 0);
      turretvehicle.scanpos = "right";
    } else {
      turretvehicle setturrettargetrelativeangles((0, (turret_data.rightarc - 10) * -1, 0), 0);
      turretvehicle.scanpos = "left";
    }
    wait(2.5);
  }
}

function watchturretshutdown(killstreakid, team) {
  turret = self;
  turret waittill("sentry_turret_shutdown");
  killstreakrules::killstreakstop("autoturret", team, killstreakid);
  if(isdefined(turret.vehicle)) {
    turret.vehicle spawning::remove_influencers();
  }
}