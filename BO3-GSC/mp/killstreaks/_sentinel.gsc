/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_sentinel.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_shellshock;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\killstreaks\_airsupport;
#using scripts\mp\killstreaks\_helicopter;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreak_detect;
#using scripts\mp\killstreaks\_killstreak_hacking;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_qrdrone;
#using scripts\mp\killstreaks\_rcbomb;
#using scripts\mp\killstreaks\_remote_weapons;
#using scripts\mp\teams\_teams;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_wasp;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\weapons\_heatseekingmissile;
#namespace sentinel;

function init() {
  killstreaks::register("sentinel", "sentinel", "killstreak_" + "sentinel", "sentinel" + "_used", &activatesentinel, 1);
  killstreaks::register_strings("sentinel", &"KILLSTREAK_SENTINEL_EARNED", &"KILLSTREAK_SENTINEL_NOT_AVAILABLE", &"KILLSTREAK_SENTINEL_INBOUND", undefined, &"KILLSTREAK_SENTINEL_HACKED");
  killstreaks::register_dialog("sentinel", "mpl_killstreak_sentinel_strt", "sentinelDialogBundle", "sentinelPilotDialogBundle", "friendlySentinel", "enemySentinel", "enemySentinelMultiple", "friendlySentinelHacked", "enemySentinelHacked", "requestSentinel", "threatSentinel");
  killstreaks::register_alt_weapon("sentinel", "killstreak_remote");
  killstreaks::register_alt_weapon("sentinel", "sentinel_turret");
  remote_weapons::registerremoteweapon("sentinel", &"KILLSTREAK_SENTINEL_USE_REMOTE", &startsentinelremotecontrol, &endsentinelremotecontrol, 0);
  level.killstreaks["sentinel"].threatonkill = 1;
  vehicle::add_main_callback("veh_sentinel_mp", &initsentinel);
  visionset_mgr::register_info("visionset", "sentinel_visionset", 1, 100, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
}

function initsentinel() {
  self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  target_set(self, (0, 0, 0));
  self.health = self.healthdefault;
  self.numflares = 1;
  self.damagetaken = 0;
  self vehicle::friendly_fire_shield();
  self enableaimassist();
  self setneargoalnotifydist(40);
  self sethoverparams(50, 100, 100);
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self.vehaircraftcollisionenabled = 1;
  self thread vehicle_ai::nudge_collision();
  self thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("explode", "death");
  self thread helicopter::create_flare_ent(vectorscale((0, 0, -1), 20));
  self thread audio::vehiclespawncontext();
  self.do_scripted_crash = 0;
  self.overridevehicledamage = &sentineldamageoverride;
  self.selfdestruct = 0;
  self.enable_target_laser = 1;
  self.aggresive_navvolume_recover = 1;
  self vehicle_ai::init_state_machine_for_role("default");
  self vehicle_ai::get_state_callbacks("combat").enter_func = &wasp::state_combat_enter;
  self vehicle_ai::get_state_callbacks("combat").update_func = &wasp::state_combat_update;
  self vehicle_ai::get_state_callbacks("death").update_func = &wasp::state_death_update;
  self vehicle_ai::get_state_callbacks("driving").enter_func = &driving_enter;
  wasp::init_guard_points();
  self vehicle_ai::add_state("guard", &wasp::state_guard_enter, &wasp::state_guard_update, &wasp::state_guard_exit);
  vehicle_ai::add_utility_connection("combat", "guard", &wasp::state_guard_can_enter);
  vehicle_ai::add_utility_connection("guard", "combat");
  vehicle_ai::add_interrupt_connection("guard", "emped", "emped");
  vehicle_ai::add_interrupt_connection("guard", "surge", "surge");
  vehicle_ai::add_interrupt_connection("guard", "off", "shut_off");
  vehicle_ai::add_interrupt_connection("guard", "pain", "pain");
  vehicle_ai::add_interrupt_connection("guard", "driving", "enter_vehicle");
  self vehicle_ai::startinitialstate("combat");
}

function driving_enter(params) {
  vehicle_ai::defaultstate_driving_enter(params);
}

function drone_pain_for_time(time, stablizeparam, restorelookpoint, weapon) {
  self endon("death");
  self.painstarttime = gettime();
  if(!(isDefined(self.inpain) && self.inpain) && isDefined(self.health) && self.health > 0) {
    self.inpain = 1;
    while(gettime() < (self.painstarttime + (time * 1000))) {
      self setvehvelocity(self.velocity * stablizeparam);
      self setangularvelocity(self getangularvelocity() * stablizeparam);
      wait(0.1);
    }
    if(isDefined(restorelookpoint) && isDefined(self.health) && self.health > 0) {
      restorelookent = spawn("script_model", restorelookpoint);
      restorelookent setModel("tag_origin");
      self clearlookatent();
      self setlookatent(restorelookent);
      self setturrettargetent(restorelookent);
      wait(1.5);
      self clearlookatent();
      self clearturrettarget();
      restorelookent delete();
    }
    if(weapon.isemp) {
      remote_weapons::set_static(0);
    }
    self.inpain = 0;
  }
}

function drone_pain(eattacker, damagetype, hitpoint, hitdirection, hitlocationinfo, partname, weapon) {
  if(!(isDefined(self.inpain) && self.inpain)) {
    yaw_vel = math::randomsign() * randomfloatrange(280, 320);
    ang_vel = self getangularvelocity();
    ang_vel = ang_vel + (randomfloatrange(-120, -100), yaw_vel, randomfloatrange(-200, 200));
    self setangularvelocity(ang_vel);
    self thread drone_pain_for_time(0.8, 0.7, undefined, weapon);
  }
}

function sentineldamageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(smeansofdeath == "MOD_TRIGGER_HURT") {
    return 0;
  }
  emp_damage = (self.healthdefault * 0.5) + 0.5;
  idamage = killstreaks::ondamageperweapon("sentinel", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, &destroyed_cb, self.maxhealth * 0.4, &low_health_cb, emp_damage, undefined, 1, 1);
  if(isDefined(eattacker) && isDefined(eattacker.team) && eattacker.team != self.team) {
    drone_pain(eattacker, smeansofdeath, vpoint, vdir, shitloc, partname, weapon);
  }
  self.damagetaken = self.damagetaken + idamage;
  return idamage;
}

function destroyed_cb(attacker, weapon) {
  if(isDefined(attacker) && isDefined(attacker.team) && attacker.team != self.team) {
    self.owner.dofutz = 1;
  }
}

function low_health_cb(attacker, weapon) {
  if(self.playeddamaged == 0) {
    self killstreaks::play_pilot_dialog_on_owner("damaged", "sentinel", self.killstreak_id);
    self.playeddamaged = 1;
  }
}

function calcspawnorigin(origin, angles) {
  heightoffset = rcbomb::getplacementstartheight();
  mins = vectorscale((-1, -1, 0), 5);
  maxs = (5, 5, 10);
  startpoints = [];
  testangles = [];
  testangles[0] = (0, 0, 0);
  testangles[1] = vectorscale((0, 1, 0), 30);
  testangles[2] = vectorscale((0, -1, 0), 30);
  testangles[3] = vectorscale((0, 1, 0), 60);
  testangles[4] = vectorscale((0, -1, 0), 60);
  testangles[3] = vectorscale((0, 1, 0), 90);
  testangles[4] = vectorscale((0, -1, 0), 90);
  bestorigin = origin;
  bestangles = angles;
  bestfrac = 0;
  for(i = 0; i < testangles.size; i++) {
    startpoint = origin + (0, 0, heightoffset);
    endpoint = startpoint + (vectorscale(anglesToForward((0, angles[1], 0) + testangles[i]), 70));
    mask = 1 | 2;
    trace = physicstrace(startpoint, endpoint, mins, maxs, self, mask);
    if(isDefined(trace["entity"]) && isplayer(trace["entity"])) {
      continue;
    }
    if(trace["fraction"] > bestfrac) {
      bestfrac = trace["fraction"];
      bestorigin = trace["position"];
      bestangles = (0, angles[1], 0) + testangles[i];
      if(bestfrac == 1) {
        break;
      }
    }
  }
  if(bestfrac > 0) {
    if(distance2dsquared(origin, bestorigin) < 400) {
      return undefined;
    }
    trace = physicstrace(bestorigin, bestorigin + (0, 0, 25), mins, maxs, self, mask);
    placement = spawnStruct();
    placement.origin = trace["position"];
    placement.angles = bestangles;
    return placement;
  }
  return undefined;
}

function activatesentinel(killstreaktype) {
  assert(isplayer(self));
  player = self;
  if(!isnavvolumeloaded()) {
    iprintlnbold("");
    self iprintlnbold(&"KILLSTREAK_SENTINEL_NOT_AVAILABLE");
    return false;
  }
  if(player isplayerswimming()) {
    self iprintlnbold(&"KILLSTREAK_SENTINEL_NOT_PLACEABLE");
    return false;
  }
  spawnpos = calcspawnorigin(player.origin, player.angles);
  if(!isDefined(spawnpos)) {
    self iprintlnbold(&"KILLSTREAK_SENTINEL_NOT_PLACEABLE");
    return false;
  }
  killstreak_id = player killstreakrules::killstreakstart("sentinel", player.team, 0, 1);
  if(killstreak_id == -1) {
    return false;
  }
  player addweaponstat(getweapon("sentinel"), "used", 1);
  sentinel = spawnvehicle("veh_sentinel_mp", spawnpos.origin, spawnpos.angles, "dynamic_spawn_ai");
  sentinel killstreaks::configure_team("sentinel", killstreak_id, player, "small_vehicle", undefined, &configureteampost);
  sentinel killstreak_hacking::enable_hacking("sentinel", &hackedcallbackpre, &hackedcallbackpost);
  sentinel.killstreak_id = killstreak_id;
  sentinel.killstreak_end_time = gettime() + 60000;
  sentinel.original_vehicle_type = sentinel.vehicletype;
  sentinel.ignore_vehicle_underneath_splash_scalar = 1;
  sentinel clientfield::set("enemyvehicle", 1);
  sentinel.hardpointtype = "sentinel";
  sentinel.soundmod = "player";
  sentinel.maxhealth = killstreak_bundles::get_max_health("sentinel");
  sentinel.lowhealth = killstreak_bundles::get_low_health("sentinel");
  sentinel.health = sentinel.maxhealth;
  sentinel.hackedhealth = killstreak_bundles::get_hacked_health("sentinel");
  sentinel.rocketdamage = (sentinel.maxhealth / 1) + 1;
  sentinel.playeddamaged = 0;
  sentinel.treat_owner_damage_as_friendly_fire = 1;
  sentinel.ignore_team_kills = 1;
  sentinel thread healthmonitor();
  sentinel.goalradius = 1200;
  sentinel.goalheight = 500;
  sentinel.enable_guard = 1;
  sentinel.always_face_enemy = 1;
  sentinel thread killstreaks::waitfortimeout("sentinel", 60000, &ontimeout, "sentinel_shutdown");
  sentinel thread watchwater();
  sentinel thread watchdeath();
  sentinel thread watchshutdown();
  player remote_weapons::useremoteweapon(sentinel, "sentinel", 0);
  sentinel killstreaks::play_pilot_dialog_on_owner("arrive", "sentinel", killstreak_id);
  sentinel vehicle::init_target_group();
  sentinel vehicle::add_to_target_group(sentinel);
  self killstreaks::play_killstreak_start_dialog("sentinel", self.team, killstreak_id);
  sentinel thread watchgameended();
  return true;
}

function hackedcallbackpre(hacker) {
  sentinel = self;
  sentinel.owner unlink();
  sentinel clientfield::set("vehicletransition", 0);
  if(sentinel.controlled === 1) {
    visionset_mgr::deactivate("visionset", "sentinel_visionset", sentinel.owner);
  }
  sentinel.owner remote_weapons::removeandassignnewremotecontroltrigger(sentinel.usetrigger);
  sentinel remote_weapons::endremotecontrolweaponuse(1);
  endsentinelremotecontrol(sentinel, 1);
}

function hackedcallbackpost(hacker) {
  sentinel = self;
  hacker remote_weapons::useremoteweapon(sentinel, "sentinel", 0);
  sentinel notify("watchremotecontroldeactivate_remoteweapons");
  sentinel.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(sentinel);
}

function configureteampost(owner, ishacked) {
  sentinel = self;
  sentinel thread watchteamchange();
}

function watchgameended() {
  sentinel = self;
  sentinel endon("death");
  level waittill("game_ended");
  sentinel.abandoned = 1;
  sentinel.selfdestruct = 1;
  sentinel notify("sentinel_shutdown");
}

function startsentinelremotecontrol(sentinel) {
  player = self;
  assert(isplayer(player));
  sentinel usevehicle(player, 0);
  sentinel clientfield::set("vehicletransition", 1);
  sentinel thread audio::sndupdatevehiclecontext(1);
  sentinel thread vehicle::monitor_missiles_locked_on_to_me(player);
  sentinel.inheliproximity = 0;
  sentinel.treat_owner_damage_as_friendly_fire = 0;
  sentinel.ignore_team_kills = 0;
  minheightoverride = undefined;
  minz_struct = struct::get("vehicle_oob_minz", "targetname");
  if(isDefined(minz_struct)) {
    minheightoverride = minz_struct.origin[2];
  }
  sentinel thread qrdrone::qrdrone_watch_distance(0, minheightoverride);
  sentinel.distance_shutdown_override = &sentineldistancefailure;
  player vehicle::set_vehicle_drivable_time(60000, sentinel.killstreak_end_time);
  visionset_mgr::activate("visionset", "sentinel_visionset", player, 1, 90000, 1);
  if(isDefined(sentinel.playerdrivenversion)) {
    sentinel setvehicletype(sentinel.playerdrivenversion);
  }
}

function endsentinelremotecontrol(sentinel, exitrequestedbyowner) {
  sentinel.treat_owner_damage_as_friendly_fire = 1;
  sentinel.ignore_team_kills = 1;
  if(isDefined(sentinel.owner)) {
    sentinel.owner vehicle::stop_monitor_missiles_locked_on_to_me();
    if(sentinel.controlled === 1) {
      visionset_mgr::deactivate("visionset", "sentinel_visionset", sentinel.owner);
    }
  }
  if(exitrequestedbyowner) {
    if(isDefined(sentinel.owner)) {
      sentinel.owner qrdrone::destroyhud();
      sentinel.owner unlink();
      sentinel clientfield::set("vehicletransition", 0);
    }
    sentinel thread audio::sndupdatevehiclecontext(0);
  }
  if(isDefined(sentinel.original_vehicle_type)) {
    sentinel setvehicletype(sentinel.original_vehicle_type);
  }
}

function ontimeout() {
  sentinel = self;
  sentinel killstreaks::play_pilot_dialog_on_owner("timeout", "sentinel");
  params = level.killstreakbundle["sentinel"];
  if(isDefined(sentinel.owner)) {
    radiusdamage(sentinel.origin, params.ksexplosionouterradius, params.ksexplosioninnerdamage, params.ksexplosionouterdamage, sentinel.owner, "MOD_EXPLOSIVE", getweapon("sentinel"));
    if(isDefined(params.ksexplosionrumble)) {
      sentinel.owner playrumbleonentity(params.ksexplosionrumble);
    }
  }
  sentinel notify("sentinel_shutdown");
}

function healthmonitor() {
  self endon("death");
  params = level.killstreakbundle["sentinel"];
  if(isDefined(params.fxlowhealth)) {
    while(true) {
      if(self.lowhealth > self.health) {
        playFXOnTag(params.fxlowhealth, self, "tag_origin");
        break;
      }
      wait(0.05);
    }
  }
}

function sentineldistancefailure() {
  sentinel = self;
  sentinel notify("sentinel_shutdown");
}

function watchdeath() {
  sentinel = self;
  sentinel waittill("death", attacker, damagefromunderneath, weapon, point, dir, modtype);
  sentinel notify("sentinel_shutdown");
  attacker = self[[level.figure_out_attacker]](attacker);
  if(isDefined(attacker) && (!isDefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
    if(isplayer(attacker)) {
      challenges::destroyedaircraft(attacker, weapon, sentinel.controlled === 1);
      attacker challenges::addflyswatterstat(weapon, self);
      attacker addweaponstat(weapon, "destroy_aitank_or_setinel", 1);
      scoreevents::processscoreevent("destroyed_sentinel", attacker, sentinel.owner, weapon);
      if(modtype == "MOD_RIFLE_BULLET" || modtype == "MOD_PISTOL_BULLET") {
        attacker addplayerstat("shoot_down_sentinel", 1);
      }
      luinotifyevent(&"player_callout", 2, &"KILLSTREAK_DESTROYED_SENTINEL", attacker.entnum);
    }
    if(isDefined(sentinel) && isDefined(sentinel.owner)) {
      sentinel killstreaks::play_destroyed_dialog_on_owner("sentinel", sentinel.killstreak_id);
    }
  }
}

function watchteamchange() {
  self notify("sentinel_watchteamchange_singleton");
  self endon("sentinel_watchteamchange_singleton");
  sentinel = self;
  sentinel endon("sentinel_shutdown");
  sentinel.owner util::waittill_any("joined_team", "disconnect", "joined_spectators");
  sentinel notify("sentinel_shutdown");
}

function watchwater() {
  sentinel = self;
  sentinel endon("sentinel_shutdown");
  while(true) {
    wait(0.1);
    trace = physicstrace(self.origin + vectorscale((0, 0, 1), 10), self.origin + vectorscale((0, 0, 1), 6), vectorscale((-1, -1, -1), 2), vectorscale((1, 1, 1), 2), self, 4);
    if(trace["fraction"] < 1) {
      break;
    }
  }
  sentinel notify("sentinel_shutdown");
}

function watchshutdown() {
  sentinel = self;
  sentinel waittill("sentinel_shutdown");
  if(isDefined(sentinel.control_initiated) && sentinel.control_initiated || (isDefined(sentinel.controlled) && sentinel.controlled)) {
    sentinel remote_weapons::endremotecontrolweaponuse(0);
    while(isDefined(sentinel.control_initiated) && sentinel.control_initiated || (isDefined(sentinel.controlled) && sentinel.controlled)) {
      wait(0.05);
    }
  }
  if(isDefined(sentinel.owner)) {
    sentinel.owner qrdrone::destroyhud();
  }
  killstreakrules::killstreakstop("sentinel", sentinel.originalteam, sentinel.killstreak_id);
  if(isalive(sentinel)) {
    sentinel kill();
  }
}