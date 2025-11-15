/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_helicopter_gunner.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\killstreaks\_airsupport;
#using scripts\mp\killstreaks\_helicopter;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreak_detect;
#using scripts\mp\killstreaks\_killstreak_hacking;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_remote_weapons;
#using scripts\mp\teams\_teams;
#using scripts\shared\_oob;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\popups_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\weapons\_hacker_tool;
#using scripts\shared\weapons\_heatseekingmissile;
#using scripts\shared\weapons\_weaponobjects;
#namespace helicopter_gunner;

function init() {
  killstreaks::register("helicopter_gunner", "helicopter_player_gunner", "killstreak_helicopter_player_gunner", "helicopter_used", & activatemaingunner, 1);
  killstreaks::register_strings("helicopter_gunner", & "KILLSTREAK_EARNED_HELICOPTER_GUNNER", & "KILLSTREAK_HELICOPTER_GUNNER_NOT_AVAILABLE", & "KILLSTREAK_HELICOPTER_GUNNER_INBOUND", undefined, & "KILLSTREAK_HELICOPTER_GUNNER_HACKED");
  killstreaks::register_dialog("helicopter_gunner", "mpl_killstreak_osprey_strt", "helicopterGunnerDialogBundle", "helicopterGunnerPilotDialogBundle", "friendlyHelicopterGunner", "enemyHelicopterGunner", "enemyHelicopterGunnerMultiple", "friendlyHelicopterGunnerHacked", "enemyHelecopterGunnerHacked", "requestHelicopterGunner", "threatHelicopterGunner");
  killstreaks::register_alt_weapon("helicopter_gunner", "helicopter_gunner_turret_rockets");
  killstreaks::register_alt_weapon("helicopter_gunner", "helicopter_gunner_turret_primary");
  killstreaks::register_alt_weapon("helicopter_gunner", "helicopter_gunner_turret_secondary");
  killstreaks::register_alt_weapon("helicopter_gunner", "helicopter_gunner_turret_tertiary");
  killstreaks::set_team_kill_penalty_scale("helicopter_gunner", level.teamkillreducedpenalty);
  killstreaks::devgui_scorestreak_command("helicopter_gunner", "Debug Paths", "toggle scr_devHeliPathsDebugDraw 1 0");
  killstreaks::register("helicopter_gunner_assistant", "helicopter_gunner_assistant", "killstreak_" + "helicopter_gunner_assistant", "helicopter_used", & activatesupportgunner, 1, undefined, 0, 0);
  killstreaks::register_strings("helicopter_gunner_assistant", & "KILLSTREAK_EARNED_HELICOPTER_GUNNER", & "KILLSTREAK_HELICOPTER_GUNNER_NOT_AVAILABLE", & "KILLSTREAK_HELICOPTER_GUNNER_INBOUND", undefined, & "KILLSTREAK_HELICOPTER_GUNNER_HACKED");
  killstreaks::register_dialog("helicopter_gunner_assistant", "mpl_killstreak_osprey_strt", "helicopterGunnerDialogBundle", "helicopterGunnerPilotDialogBundle", "friendlyHelicopterGunner", "enemyHelicopterGunner", "enemyHelicopterGunnerMultiple", "friendlyHelicopterGunnerHacked", "enemyHelecopterGunnerHacked", "requestHelicopterGunner", "threatHelicopterGunner");
  killstreaks::set_team_kill_penalty_scale("helicopter_gunner_assistant", level.teamkillreducedpenalty);
  level.killstreaks["helicopter_gunner"].threatonkill = 1;
  callback::on_connect( & onplayerconnect);
  callback::on_spawned( & updateplayerstate);
  callback::on_joined_team( & updateplayerstate);
  callback::on_joined_spectate( & updateplayerstate);
  callback::on_disconnect( & updateplayerstate);
  callback::on_player_killed( & updateplayerstate);
  clientfield::register("vehicle", "vtol_turret_destroyed_0", 1, 1, "int");
  clientfield::register("vehicle", "vtol_turret_destroyed_1", 1, 1, "int");
  clientfield::register("vehicle", "mothership", 1, 1, "int");
  clientfield::register("toplayer", "vtol_update_client", 1, 1, "counter");
  clientfield::register("toplayer", "fog_bank_2", 1, 1, "int");
  visionset_mgr::register_info("visionset", "mothership_visionset", 1, 70, 16, 1, & visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
  level thread waitforgameendthread();
  level.vtol = undefined;
}

function onplayerconnect() {
  if(!isDefined(self.entnum)) {
    self.entnum = self getentitynumber();
  }
}

function updateplayerstate() {
  player = self;
  updateallkillstreakinventory();
}

function updateallkillstreakinventory() {
  foreach(player in level.players) {
    if(isDefined(player.sessionstate) && player.sessionstate == "playing") {
      updatekillstreakinventory(player);
    }
  }
}

function updatekillstreakinventory(player) {
  if(!isDefined(player)) {
    return;
  }
  heli_team = undefined;
  if(isDefined(level.vtol) && isDefined(level.vtol.owner) && !level.vtol.shuttingdown && level.vtol.totalrockethits < 6) {
    heli_team = level.vtol.owner.team;
  }
  if(isDefined(heli_team) && player.team == heli_team) {
    if(getfirstavailableseat(player) != -1 && !isDefined(level.vtol.usage[player.entnum])) {
      if(!player killstreaks::has_killstreak("inventory_helicopter_gunner_assistant")) {
        player killstreaks::give("inventory_helicopter_gunner_assistant", undefined, undefined, 1, 1);
      }
      return;
    }
  }
  if(player killstreaks::has_killstreak("inventory_helicopter_gunner_assistant")) {
    player killstreaks::take("inventory_helicopter_gunner_assistant");
  }
}

function activatemaingunner(killstreaktype) {
  player = self;
  while(isDefined(level.vtol) && level.vtol.shuttingdown) {
    if(!player killstreakrules::iskillstreakallowed("helicopter_gunner", player.team)) {
      return 0;
    }
  }
  player util::freeze_player_controls(1);
  result = player spawnheligunner();
  player util::freeze_player_controls(0);
  if(level.gameended) {
    return 1;
  }
  if(!isDefined(result)) {
    return 0;
  }
  return result;
}

function activatesupportgunner(killstreaktype) {
  player = self;
  if(isDefined(level.vtol) && level.vtol.shuttingdown) {
    return 0;
  }
  if(isDefined(level.vtol.usage[player.entnum])) {
    return 0;
  }
  player util::freeze_player_controls(1);
  result = player enterhelicopter(0);
  player util::freeze_player_controls(0);
  return result;
}

function getfirstavailableseat(player) {
  if(isDefined(level.vtol) && !level.vtol.shuttingdown && level.vtol.team == player.team && level.vtol.owner != player) {
    for(i = 0; i < 2; i++) {
      if(!isDefined(level.vtol.assistants[i].occupant) && !level.vtol.assistants[i].destroyed) {
        return i;
      }
    }
  }
  return -1;
}

function inithelicopterseat(index, destroytag) {
  level.vtol.assistants[index] = spawnStruct();
  assistant = level.vtol.assistants[index];
  assistant.occupant = undefined;
  assistant.destroyed = 0;
  assistant.rockethits = 0;
  assistant.targettag = destroytag;
  assistant.targetent = spawn("script_model", (0, 0, 0));
  assistant.targetent.usevtoltime = 1;
  assistant.targetent setModel("p7_dogtags_enemy");
  assistant.targetent linkto(level.vtol, assistant.targettag, (0, 0, 0), (0, 0, 0));
  assistant.targetent.team = level.vtol.team;
  target_set(assistant.targetent, (0, 0, 0));
  target_setallowhighsteering(assistant.targetent, 1);
  assistant.targetent.parent = level.vtol;
  level.vtol vehicle::add_to_target_group(assistant.targetent);
}

function hackedprefunction(hacker) {
  heligunner = self;
  heligunner.owner unlink();
  level.vtol clientfield::set("vehicletransition", 0);
  visionset_mgr::deactivate("visionset", "mothership_visionset", heligunner.owner);
  heligunner.owner setmodellodbias(0);
  heligunner.owner clientfield::set_to_player("fog_bank_2", 0);
  heligunner.owner clientfield::set_to_player("toggle_flir_postfx", 0);
  heligunner.owner notify("gunner_left");
  heligunner.owner killstreaks::clear_using_remote();
  heligunner.owner killstreaks::unhide_compass();
  heligunner.owner vehicle::stop_monitor_missiles_locked_on_to_me();
  heligunner.owner vehicle::stop_monitor_damage_as_occupant();
  foreach(assistant in heligunner.assistants) {
    if(isDefined(assistant.occupant)) {
      assistant.occupant iprintlnbold(&"KILLSTREAK_HELICOPTER_GUNNER_DAMAGED");
    }
    leavehelicopter(assistant.occupant, 0);
  }
  heligunner makevehicleunusable();
}

function hackedpostfunction(hacker) {
  heligunner = self;
  heligunner clientfield::set("enemyvehicle", 2);
  heligunner makevehicleusable();
  heligunner usevehicle(hacker, 0);
  level.vtol clientfield::set("vehicletransition", 1);
  heligunner thread vehicle::monitor_missiles_locked_on_to_me(hacker);
  heligunner thread vehicle::monitor_damage_as_occupant(hacker);
  hacker thread watchvisionswitchthread();
  hacker killstreaks::hide_compass();
  heligunner thread watchplayerexitrequestthread(hacker);
  visionset_mgr::activate("visionset", "mothership_visionset", hacker, 1, heligunner killstreak_hacking::get_hacked_timeout_duration_ms(), 1);
  hacker setmodellodbias((isDefined(level.mothership_lod_bias) ? level.mothership_lod_bias : 8));
  heligunner.owner givededicatedshadow(level.vtol);
  heligunner.owner clientfield::set_to_player("fog_bank_2", 1);
  hacker thread watchplayerteamchangethread(heligunner);
  hacker killstreaks::set_killstreak_delay_killcam("helicopter_gunner");
  if(heligunner.killstreak_timer_started) {
    heligunner.killstreak_duration = heligunner killstreak_hacking::get_hacked_timeout_duration_ms();
    heligunner.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(heligunner);
    heligunner.killstreakendtime = int(heligunner.killstreak_end_time);
  } else {
    heligunner.killstreak_timer_start_using_hacked_time = 1;
  }
}

function spawnheligunner() {
  player = self;
  player endon("disconnect");
  level endon("game_ended");
  if(!isDefined(level.heli_paths) || !level.heli_paths.size) {
    return 0;
  }
  if(!isDefined(level.heli_primary_path) || !level.heli_primary_path.size) {
    return 0;
  }
  if(isDefined(player.isplanting) && player.isplanting || (isDefined(player.isdefusing) && player.isdefusing) || player util::isusingremote() || player iswallrunning() || player oob::isoutofbounds()) {
    return 0;
  }
  killstreak_id = player killstreakrules::killstreakstart("helicopter_gunner", player.team, undefined, 1);
  if(killstreak_id == -1) {
    return 0;
  }
  startnode = level.heli_primary_path[0];
  level.vtol = spawnvehicle("veh_bo3_mil_gunship_mp", startnode.origin, startnode.angles, "dynamic_spawn_ai");
  level.vtol killstreaks::configure_team("helicopter_gunner", killstreak_id, player, "helicopter");
  level.vtol killstreak_hacking::enable_hacking("helicopter_gunner", & hackedprefunction, & hackedpostfunction);
  level.vtol.killstreak_id = killstreak_id;
  level.vtol.destroyfunc = & deletehelicoptercallback;
  level.vtol.hardpointtype = "helicopter_gunner";
  level.vtol clientfield::set("enemyvehicle", 1);
  level.vtol clientfield::set("vtol_turret_destroyed_0", 0);
  level.vtol clientfield::set("vtol_turret_destroyed_1", 0);
  level.vtol clientfield::set("mothership", 1);
  level.vtol vehicle::init_target_group();
  level.vtol.killstreak_timer_started = 0;
  level.vtol.allowdeath = 0;
  level.vtol.playermovedrecently = 0;
  level.vtol.soundmod = "default_loud";
  level.vtol hacker_tool::registerwithhackertool(50, 10000);
  level.vtol.assistants = [];
  level.vtol.usage = [];
  inithelicopterseat(0, "tag_gunner_barrel1");
  inithelicopterseat(1, "tag_gunner_barrel2");
  level.destructible_callbacks["turret_destroyed"] = & vtoldestructiblecallback;
  level.destructible_callbacks["turret1_destroyed"] = & vtoldestructiblecallback;
  level.destructible_callbacks["turret2_destroyed"] = & vtoldestructiblecallback;
  level.vtol.shuttingdown = 0;
  level.vtol thread playlockonsoundsthread(player, level.vtol);
  level.vtol thread helicopter::wait_for_killed();
  level.vtol thread wait_for_bda_dialog();
  level.vtol.maxhealth = 15000;
  tablehealth = killstreak_bundles::get_max_health("helicopter_gunner");
  if(isDefined(tablehealth)) {
    level.vtol.maxhealth = tablehealth;
  }
  level.vtol.original_health = level.vtol.maxhealth;
  level.vtol.health = level.vtol.maxhealth;
  level.vtol setCanDamage(1);
  level.vtol thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("death");
  level.vtol thread watchmissilesthread();
  attack_nodes = getEntArray("heli_attack_area", "targetname");
  if(attack_nodes.size) {
    level.vtol thread helicopterthinkthread(startnode, attack_nodes);
    player thread watchlocationchangethread(attack_nodes);
  } else {
    level.vtol thread helicopter::heli_fly(startnode, 0, "helicopter_gunner");
  }
  level.vtol.totalrockethits = 0;
  level.vtol.turretrockethits = 0;
  level.vtol.targetent = undefined;
  level.vtol.overridevehicledamage = & helicoptergunnerdamageoverride;
  level.vtol.hackedhealthupdatecallback = & helicoptergunner_hacked_health_callback;
  level.vtol.detonateviaemp = & helicoptedetonateviaemp;
  player thread killstreaks::play_killstreak_start_dialog("helicopter_gunner", player.team, killstreak_id);
  level.vtol killstreaks::play_pilot_dialog_on_owner("arrive", "helicopter_gunner", killstreak_id);
  player addweaponstat(getweapon("helicopter_player_gunner"), "used", 1);
  level.vtol thread waitforvtolshutdownthread();
  result = player enterhelicopter(1);
  return result;
}

function helicoptergunner_hacked_health_callback() {
  helicopter = self;
  if(helicopter.shuttingdown == 1) {
    return;
  }
  hackedhealth = killstreak_bundles::get_hacked_health("helicopter_gunner");
  assert(isDefined(hackedhealth));
  if(helicopter.health > hackedhealth) {
    helicopter.health = hackedhealth;
  }
}

function waitforgameendthread() {
  level waittill("game_ended");
  if(isDefined(level.vtol) && isDefined(level.vtol.owner)) {
    leavehelicopter(level.vtol.owner, 1);
  }
}

function waitforvtolshutdownthread() {
  helicopter = self;
  helicopter waittill("vtol_shutdown", attacker);
  if(isDefined(attacker)) {
    luinotifyevent(&"player_callout", 2, & "KILLSTREAK_DESTROYED_HELICOPTER_GUNNER", attacker.entnum);
  }
  if(isDefined(helicopter.targetent)) {
    target_remove(helicopter.targetent);
    helicopter.targetent delete();
    helicopter.targetent = undefined;
  }
  for(seatindex = 0; seatindex < 2; seatindex++) {
    assistant = level.vtol.assistants[seatindex];
    if(isDefined(assistant.targetent)) {
      target_remove(assistant.targetent);
      assistant.targetent delete();
      assistant.targetent = undefined;
    }
  }
  killstreakrules::killstreakstop("helicopter_gunner", helicopter.originalteam, helicopter.killstreak_id);
  leavehelicopter(level.vtol.owner, 1);
  level.vtol = undefined;
  helicopter delete();
}

function deletehelicoptercallback() {
  helicopter = self;
  helicopter notify("vtol_shutdown", undefined);
}

function ontimeoutcallback() {
  for(i = 0; i < 2; i++) {
    if(isDefined(level.vtol.assistants[i].occupant)) {
      level.vtol.assistants[i].occupant killstreaks::play_pilot_dialog("timeout", "helicopter_gunner", undefined, level.vtol.killstreak_id);
    }
  }
  leavehelicopter(level.vtol.owner, 1);
}

function watchplayerteamchangethread(helicopter) {
  helicopter notify("mothership_team_change");
  helicopter endon("mothership_team_change");
  assert(isplayer(self));
  player = self;
  player endon("gunner_left");
  player util::waittill_any("joined_team", "disconnect", "joined_spectators");
  ownerleft = helicopter.ownerentnum == player.entnum;
  player thread leavehelicopter(player, ownerleft);
  if(ownerleft) {
    helicopter notify("vtol_shutdown", undefined);
  }
}

function watchplayerexitrequestthread(player) {
  player notify("watchplayerexitrequestthread_singleton");
  player endon("watchplayerexitrequestthread_singleton");
  assert(isplayer(player));
  mothership = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("gunner_left");
  owner = mothership.ownerentnum == player.entnum;
  while(true) {
    timeused = 0;
    while(player usebuttonpressed()) {
      timeused = timeused + 0.05;
      if(timeused > 0.25) {
        mothership killstreaks::play_pilot_dialog_on_owner("remoteOperatorRemoved", "helicopter_gunner", level.vtol.killstreak_id);
        player thread leavehelicopter(player, owner);
        return;
      }
      wait(0.05);
    }
    wait(0.05);
  }
}

function enterhelicopter(isowner) {
  assert(isplayer(self));
  player = self;
  seatindex = -1;
  if(!isowner) {
    seatindex = getfirstavailableseat(player);
    if(seatindex == -1) {
      return false;
    }
    level.vtol.assistants[seatindex].occupant = player;
  }
  level.vtol.occupied = 1;
  player util::setusingremote("helicopter_gunner");
  player.ignoreempjammed = 1;
  result = player killstreaks::init_ride_killstreak("helicopter_gunner");
  player.ignoreempjammed = 0;
  if(result != "success") {
    if(result != "disconnect") {
      player killstreaks::clear_using_remote();
    }
    if(!isowner) {
      level.vtol.assistants[seatindex].occupant = undefined;
    }
    if(isowner) {
      level.vtol.failed2enter = 1;
      level.vtol notify("vtol_shutdown");
    }
    return false;
  }
  if(isowner) {
    level.vtol usevehicle(player, 0);
    level.vtol clientfield::set("vehicletransition", 1);
  } else {
    if(level.vtol.shuttingdown) {
      player killstreaks::clear_using_remote();
      return false;
    }
    level.vtol usevehicle(player, seatindex + 1);
    level.vtol clientfield::set("vehicletransition", 1);
    level.vtol killstreaks::play_pilot_dialog_on_owner("remoteOperatorAdd", "helicopter_gunner", level.vtol.killstreak_id);
  }
  killcament = spawn("script_model", (0, 0, 0));
  killcament setModel("tag_origin");
  killcament.angles = (0, 0, 0);
  killcament setweapon(getweapon("helicopter_gunner_turret_primary"));
  killcament linkto(level.vtol, "tag_barrel", (370, 0, 25), (0, 0, 0));
  level.vtol.killcament = killcament;
  level.vtol.usage[player.entnum] = 1;
  level.vtol thread audio::sndupdatevehiclecontext(1);
  level.vtol thread vehicle::monitor_missiles_locked_on_to_me(player);
  level.vtol thread vehicle::monitor_damage_as_occupant(player);
  if(level.vtol.killstreak_timer_started) {
    player vehicle::set_vehicle_drivable_time(level.vtol.killstreak_duration, level.vtol.killstreak_end_time);
  } else {
    player vehicle::set_vehicle_drivable_time(9009009, gettime() + 9009009);
  }
  update_client_for_player(player);
  updateallkillstreakinventory();
  player thread watchvisionswitchthread();
  level.vtol thread watchplayerexitrequestthread(player);
  player thread watchplayerteamchangethread(level.vtol);
  visionset_mgr::activate("visionset", "mothership_visionset", player, 1, 60000, 1);
  player setmodellodbias((isDefined(level.mothership_lod_bias) ? level.mothership_lod_bias : 8));
  player givededicatedshadow(level.vtol);
  player clientfield::set_to_player("fog_bank_2", 1);
  if(1) {
    player thread hidecompassafterwait(0.1);
  }
  return true;
}

function hidecompassafterwait(waittime) {
  self endon("death");
  self endon("disconnect");
  wait(waittime);
  self killstreaks::hide_compass();
}

function mainturretdestroyed(helicopter, eattacker, weapon) {
  helicopter.owner iprintlnbold(&"KILLSTREAK_HELICOPTER_GUNNER_DAMAGED");
  if(isDefined(helicopter.targetent)) {
    target_remove(helicopter.targetent);
    helicopter.targetent delete();
    helicopter.targetent = undefined;
  }
  helicopter.shuttingdown = 1;
  updateallkillstreakinventory();
  eattacker = self[[level.figure_out_attacker]](eattacker);
  if(!isDefined(helicopter.destroyscoreeventgiven) && isDefined(eattacker) && (!isDefined(helicopter.owner) || helicopter.owner util::isenemyplayer(eattacker))) {
    luinotifyevent(&"player_callout", 2, & "KILLSTREAK_HELICOPTER_GUNNER_DAMAGED", eattacker.entnum);
    challenges::destroyedaircraft(eattacker, weapon, 1);
    eattacker challenges::addflyswatterstat(weapon, helicopter);
    scoreevents::processscoreevent("destroyed_vtol_mothership", eattacker, helicopter.owner, weapon);
    helicopter killstreaks::play_destroyed_dialog_on_owner("helicopter_gunner", helicopter.killstreak_id);
    helicopter.destroyscoreeventgiven = 1;
  }
  helicopter thread performleavehelicopterfromdamage();
}

function wait_for_bda_dialog(killstreakid) {
  self endon("vtol_shutdown");
  while(true) {
    self waittill("bda_dialog", dialogkey);
    for(i = 0; i < 2; i++) {
      if(isDefined(level.vtol.assistants[i].occupant)) {
        level.vtol.assistants[i].occupant killstreaks::play_pilot_dialog(dialogkey, "helicopter_gunner", killstreakid, self.pilotindex);
      }
    }
  }
}

function supportturretdestroyed(helicopter, seatindex) {
  assistant = helicopter.assistants[seatindex];
  if(!assistant.destroyed) {
    target_remove(assistant.targetent);
    level.vtol vehicle::remove_from_target_group();
    assistant.targetent delete();
    assistant.targetent = undefined;
    assistant.destroyed = 1;
    if(isDefined(helicopter.owner) && isDefined(helicopter.hardpointtype)) {
      helicopter killstreaks::play_pilot_dialog_on_owner("weaponDestroyed", helicopter.hardpointtype, helicopter.killstreak_id);
    }
    if(isDefined(assistant.occupant)) {
      assistant.occupant globallogic_audio::flush_killstreak_dialog_on_player(helicopter.killstreak_id);
      assistant.occupant killstreaks::play_pilot_dialog("weaponDestroyed", helicopter.hardpointtype, undefined, helicopter.pilotindex);
      wait(2);
      leavehelicopter(assistant.occupant, 0);
    }
  }
  if(seatindex == 0) {
    level.vtol clientfield::set("vtol_turret_destroyed_0", 1);
    level.vtol update_client_for_driver_and_occupants();
  } else if(seatindex == 1) {
    level.vtol clientfield::set("vtol_turret_destroyed_1", 1);
    level.vtol update_client_for_driver_and_occupants();
  }
}

function update_client_for_driver_and_occupants() {
  vtol = self;
  update_client_for_player(vtol.owner);
  foreach(assistant in vtol.assistants) {
    update_client_for_player(assistant.occupant);
  }
}

function update_client_for_player(player) {
  if(isDefined(player)) {
    player clientfield::increment_to_player("vtol_update_client", 1);
  }
}

function vtoldestructiblecallback(brokennotify, eattacker, weapon) {
  helicopter = self;
  helicopter endon("delete");
  helicopter endon("vtol_shutdown");
  notifies = [];
  notifies[0] = "turret1_destroyed";
  notifies[1] = "turret2_destroyed";
  for(seatindex = 0; seatindex < 2; seatindex++) {
    if(brokennotify == notifies[seatindex]) {
      supportturretdestroyed(helicopter, seatindex);
      break;
    }
  }
  if(brokennotify == "turret_destroyed") {
    mainturretdestroyed(helicopter, eattacker, weapon);
    return;
  }
  helicopter allowmainturretlockon();
}

function allowmainturretlockon() {
  helicopter = self;
  if(helicopter.assistants[0].destroyed && helicopter.assistants[1].destroyed) {
    if(!isDefined(helicopter.targetent)) {
      helicopter.targetent = spawn("script_model", (0, 0, 0));
      helicopter.targetent setModel("p7_dogtags_enemy");
      helicopter.targetent linkto(level.vtol, "tag_barrel", (0, 0, 0), (0, 0, 0));
      helicopter.targetent.parent = level.vtol;
      helicopter.targetent.team = level.vtol.team;
      target_set(helicopter.targetent, (0, 0, 0));
      helicopter.targetent.usevtoltime = 1;
      target_setallowhighsteering(helicopter.targetent, 1);
      level.vtol vehicle::add_to_target_group(helicopter.targetent);
    }
  }
}

function leavehelicopter(player, ownerleft) {
  if(!isDefined(level.vtol) || level.vtol.completely_shutdown === 1) {
    return;
  }
  if(isDefined(player)) {
    player vehicle::stop_monitor_missiles_locked_on_to_me();
    player vehicle::stop_monitor_damage_as_occupant();
  }
  if(isDefined(player) && isDefined(level.vtol) && isDefined(level.vtol.owner)) {
    if(isDefined(player.usingvehicle) && player.usingvehicle) {
      player unlink();
      level.vtol clientfield::set("vehicletransition", 0);
      if(ownerleft) {
        player killstreaks::take("helicopter_gunner");
      } else {
        player killstreaks::take("inventory_helicopter_gunner_assistant");
      }
    }
  }
  if(ownerleft) {
    level.vtol.shuttingdown = 1;
    foreach(assistant in level.vtol.assistants) {
      if(isDefined(assistant.occupant)) {
        assistant.occupant iprintlnbold(&"KILLSTREAK_HELICOPTER_GUNNER_DAMAGED");
        leavehelicopter(assistant.occupant, 0);
      }
    }
    level.vtol.occupied = 0;
    level.vtol.hardpointtype = "helicopter_gunner";
    level.vtol thread helicopter::heli_leave();
    level.vtol thread audio::sndupdatevehiclecontext(0);
  } else if(isDefined(player)) {
    player globallogic_audio::flush_killstreak_dialog_on_player(level.vtol.killstreak_id);
    foreach(assistant in level.vtol.assistants) {
      if(isDefined(assistant.occupant) && assistant.occupant == player) {
        assistant.occupant = undefined;
        break;
      }
    }
  }
  if(isDefined(player)) {
    player clientfield::set_to_player("toggle_flir_postfx", 0);
    visionset_mgr::deactivate("visionset", "mothership_visionset", player);
    player setmodellodbias(0);
    player givededicatedshadow(player);
    player clientfield::set_to_player("fog_bank_2", 0);
    player killstreaks::unhide_compass();
    player notify("gunner_left");
    player killstreaks::clear_using_remote();
    if(level.gameended) {
      player util::freeze_player_controls(1);
    }
  }
  updateallkillstreakinventory();
  if(ownerleft) {
    level.vtol.completely_shutdown = 1;
  }
}

function vtol_shake() {
  if(isDefined(level.vtol) && isDefined(level.vtol.owner)) {
    org = level.vtol gettagorigin("tag_barrel");
    magnitude = 0.3;
    duration = 2;
    radius = 500;
    v_pos = self.origin;
    earthquake(magnitude, duration, org, 500);
  }
}

function helicoptergunnerdamageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  helicopter = self;
  if(smeansofdeath == "MOD_TRIGGER_HURT") {
    return 0;
  }
  if(helicopter.shuttingdown) {
    return 0;
  }
  idamage = self killstreaks::ondamageperweapon("helicopter_gunner", eattacker, idamage, idflags, smeansofdeath, weapon, level.vtol.maxhealth, undefined, level.vtol.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
  if(idamage == 0) {
    return 0;
  }
  handleasrocketdamage = smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_EXPLOSIVE";
  if(weapon.statindex == level.weaponshotgunenergy.statindex || weapon.statindex == level.weaponpistolenergy.statindex || weapon.statindex == level.weaponsmgnailgun.statindex) {
    handleasrocketdamage = 0;
  }
  if(handleasrocketdamage) {
    updateinventory = 1;
    missiletarget = einflictor missile_gettarget();
    vtol_shake();
    rockethit = 1;
    if(weapon.statindex == level.weaponlaunchermulti.statindex) {
      rockethit = 0.5;
    }
    helicopter.totalrockethits = helicopter.totalrockethits + rockethit;
    if(isDefined(missiletarget)) {
      for(seatindex = 0; seatindex < 2; seatindex++) {
        assistant = helicopter.assistants[seatindex];
        if(!assistant.destroyed && assistant.targetent == missiletarget) {
          assistant.rockethits = assistant.rockethits + rockethit;
          if(assistant.rockethits >= 2) {
            helicopter dodamage(idamage, assistant.targetent.origin, eattacker, einflictor, shitloc, "MOD_UNKNOWN", 0, weapon, seatindex + 8);
            idamage = 0;
            supportturretdestroyed(helicopter, seatindex);
          }
        }
      }
      if(isDefined(helicopter.targetent) && helicopter.targetent == missiletarget) {
        helicopter.turretrockethits = helicopter.turretrockethits + rockethit;
        if(helicopter.turretrockethits >= 2) {
          target_remove(helicopter.targetent);
          helicopter.targetent delete();
          helicopter.targetent = undefined;
        }
      }
    }
    if(helicopter.assistants[0].destroyed && helicopter.assistants[1].destroyed && !isDefined(helicopter.targetent)) {
      helicopter.targetent = spawn("script_model", (0, 0, 0));
      helicopter.targetent setModel("p7_dogtags_enemy");
      helicopter.targetent linkto(level.vtol, "tag_barrel", (0, 0, 0), (0, 0, 0));
      helicopter.targetent.parent = level.vtol;
      helicopter.targetent.team = level.vtol.team;
      target_set(helicopter.targetent, (0, 0, 0));
      helicopter.targetent.usevtoltime = 1;
      target_setallowhighsteering(helicopter.targetent, 1);
    }
    if(helicopter.totalrockethits >= 6) {
      mainturretdestroyed(helicopter, eattacker, weapon);
      updateinventory = 0;
    }
    if(updateinventory) {
      updateallkillstreakinventory();
    }
  }
  if(idamage >= level.vtol.health && !helicopter.shuttingdown) {
    helicopter.shuttingdown = 1;
    updateallkillstreakinventory();
    if(!isDefined(helicopter.destroyscoreeventgiven) && isDefined(eattacker) && (!isDefined(helicopter.owner) || helicopter.owner util::isenemyplayer(eattacker))) {
      eattacker = self[[level.figure_out_attacker]](eattacker);
      luinotifyevent(&"player_callout", 2, & "KILLSTREAK_HELICOPTER_GUNNER_DAMAGED", eattacker.entnum);
      scoreevents::processscoreevent("destroyed_vtol_mothership", eattacker, helicopter.owner, weapon);
      helicopter killstreaks::play_destroyed_dialog_on_owner("helicopter_gunner", helicopter.killstreak_id);
      helicopter.destroyscoreeventgiven = 1;
    }
    helicopter thread performleavehelicopterfromdamage();
  }
  if(helicopter.shuttingdown) {
    if(idamage >= helicopter.health) {
      idamage = helicopter.health - 1;
    }
  }
  return idamage;
}

function performleavehelicopterfromdamage() {
  helicopter = self;
  helicopter endon("death");
  if(self.leave_by_damage_initiated === 1) {
    return;
  }
  self.leave_by_damage_initiated = 1;
  helicopter thread remote_weapons::do_static_fx();
  failsafe_timeout = 5;
  helicopter util::waittill_any_timeout(failsafe_timeout, "static_fx_done");
  leavehelicopter(helicopter.owner, 1);
}

function helicoptedetonateviaemp(attacker, weapon) {
  mainturretdestroyed(level.vtol, attacker, weapon);
}

function missilecleanupthread(missile) {
  targetent = self;
  targetent endon("delete");
  targetent endon("death");
  missile util::waittill_any("death", "delete");
  targetent delete();
}

function watchmissilesthread() {
  helicopter = self;
  player = helicopter.owner;
  player endon("disconnect");
  player endon("gunner_left");
  helimissile = getweapon("helicopter_gunner_turret_rockets");
  while(true) {
    player waittill("missile_fire", missile);
    trace_origin = level.vtol gettagorigin("tag_flash");
    trace_direction = level.vtol gettagangles("tag_barrel");
    trace_direction = anglesToForward(trace_direction) * 8000;
    trace = bulletTrace(trace_origin, trace_origin + trace_direction, 0, level.vtol);
    end_origin = trace["position"];
    missiles = getEntArray("rocket", "classname");
    foreach(missile in missiles) {
      if(missile.item == helimissile) {
        targetent = spawn("script_model", end_origin);
        missile missile_settarget(targetent);
        targetent thread missilecleanupthread(missile);
      }
    }
    weapon_wait_duration_ms = int(helimissile.firetime * 1000);
    player setvehicleweaponwaitduration(weapon_wait_duration_ms);
    player setvehicleweaponwaitendtime(gettime() + weapon_wait_duration_ms);
  }
}

function watchvisionswitchthread() {
  assert(isplayer(self));
  player = self;
  player endon("disconnect");
  player endon("gunner_left");
  inverted = 0;
  player clientfield::set_to_player("toggle_flir_postfx", 2);
  while(true) {
    if(player jumpbuttonpressed()) {
      if(inverted) {
        player clientfield::set_to_player("toggle_flir_postfx", 2);
        player playsoundtoplayer("mpl_cgunner_flir_off", player);
      } else {
        player clientfield::set_to_player("toggle_flir_postfx", 1);
        player playsoundtoplayer("mpl_cgunner_flir_on", player);
      }
      inverted = !inverted;
      while(player jumpbuttonpressed()) {
        wait(0.05);
      }
    }
    wait(0.05);
  }
}

function playlockonsoundsthread(player, heli) {
  player endon("disconnect");
  player endon("gunner_left");
  heli endon("death");
  heli endon("crashing");
  heli endon("leaving");
  heli.locksounds = spawn("script_model", heli.origin);
  wait(0.1);
  heli.locksounds linkto(heli, "tag_player");
  while(true) {
    heli waittill("hash_b081980b");
    while(true) {
      if(enemyislocking(heli)) {
        heli.locksounds playsoundtoplayer("uin_alert_lockon", player);
        wait(0.125);
      }
      if(enemylockedon(heli)) {
        heli.locksounds playsoundtoplayer("uin_alert_lockon", player);
        wait(0.125);
      }
      if(!enemyislocking(heli) && !enemylockedon(heli)) {
        heli.locksounds stopsounds();
        break;
      }
    }
  }
}

function enemyislocking(heli) {
  return isDefined(heli.locking_on) && heli.locking_on;
}

function enemylockedon(heli) {
  return isDefined(heli.locked_on) && heli.locked_on;
}

function helicopterthinkthread(startnode, destnodes) {
  self notify("flying");
  self endon("flying");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  nextnode = getent(startnode.target, "targetname");
  assert(isDefined(nextnode), "");
  self setspeed(150, 80);
  self setvehgoalpos(nextnode.origin + (0, 0, 2000), 1);
  self waittill("near_goal");
  firstpass = 1;
  if(!self.playermovedrecently) {
    node = self updateareanodes(destnodes, 0);
    level.vtol.currentnode = node;
    targetnode = getent(node.target, "targetname");
    traveltonode(targetnode);
    if(isDefined(targetnode.script_airspeed) && isDefined(targetnode.script_accel)) {
      heli_speed = targetnode.script_airspeed;
      heli_accel = targetnode.script_accel;
    } else {
      heli_speed = 150 + randomint(20);
      heli_accel = 40 + randomint(10);
    }
    self setspeed(heli_speed, heli_accel);
    self setvehgoalpos(targetnode.origin + (0, 0, 2000), 1);
    self setgoalyaw(targetnode.angles[1] + 0);
  }
  if(0 != 0) {
    self waittill("near_goal");
    waittime = 0;
  } else {
    if(!isDefined(targetnode.script_delay)) {
      self waittill("near_goal");
      waittime = 10 + randomint(5);
    } else {
      self waittillmatch("goal");
      waittime = targetnode.script_delay;
    }
  }
  if(firstpass) {
    self.killstreak_duration = (self.killstreak_timer_start_using_hacked_time === 1 ? self killstreak_hacking::get_hacked_timeout_duration_ms() : 60000);
    self.killstreak_end_time = gettime() + self.killstreak_duration;
    self.killstreakendtime = int(self.killstreak_end_time);
    self thread killstreaks::waitfortimeout("helicopter_gunner", self.killstreak_duration, & ontimeoutcallback, "delete", "death");
    self.killstreak_timer_started = 1;
    self updatedrivabletimeforalloccupants(self.killstreak_duration, self.killstreak_end_time);
    firstpass = 0;
  }
  wait(waittime);
}

function updatedrivabletimeforalloccupants(duration_ms, end_time_ms) {
  if(isDefined(self.owner)) {
    self.owner vehicle::set_vehicle_drivable_time(duration_ms, end_time_ms);
  }
  for(i = 0; i < 2; i++) {
    if(isDefined(self.assistants[i].occupant) && !self.assistants[i].destroyed) {
      self.assistants[i].occupant vehicle::set_vehicle_drivable_time(duration_ms, end_time_ms);
    }
  }
}

function watchlocationchangethread(destnodes) {
  player = self;
  player endon("disconnect");
  player endon("gunner_left");
  helicopter = level.vtol;
  helicopter endon("delete");
  helicopter endon("vtol_shutdown");
  player.moves = 0;
  helicopter waittill("near_goal");
  helicopter waittill("goal");
  while(true) {
    if(self secondaryoffhandbuttonpressed()) {
      player.moves++;
      player thread setplayermovedrecentlythread();
      node = self updateareanodes(destnodes, 1);
      helicopter.currentnode = node;
      targetnode = getent(node.target, "targetname");
      player playlocalsound("mpl_cgunner_nav");
      helicopter traveltonode(targetnode);
      if(isDefined(targetnode.script_airspeed) && isDefined(targetnode.script_accel)) {
        heli_speed = targetnode.script_airspeed;
        heli_accel = targetnode.script_accel;
      } else {
        heli_speed = 80 + randomint(20);
        heli_accel = 40 + randomint(10);
      }
      helicopter setspeed(heli_speed, heli_accel);
      helicopter setvehgoalpos(targetnode.origin + (0, 0, 2000), 1);
      helicopter setgoalyaw(targetnode.angles[1] + 0);
      helicopter waittill("goal");
      while(self secondaryoffhandbuttonpressed()) {
        wait(0.05);
      }
    }
    wait(0.05);
  }
}

function setplayermovedrecentlythread() {
  player = self;
  player endon("disconnect");
  player endon("gunner_left");
  helicopter = level.vtol;
  helicopter endon("delete");
  helicopter endon("vtol_shutdown");
  mymove = self.moves;
  level.vtol.playermovedrecently = 1;
  wait(100);
  if(mymove == self.moves && isDefined(level.vtol)) {
    level.vtol.playermovedrecently = 0;
  }
}

function updateareanodes(areanodes, forcemove) {
  validenemies = [];
  foreach(node in areanodes) {
    node.validplayers = [];
    node.nodescore = 0;
  }
  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    if(player.team == self.team) {
      continue;
    }
    foreach(node in areanodes) {
      if(distancesquared(player.origin, node.origin) > 1048576) {
        continue;
      }
      node.validplayers[node.validplayers.size] = player;
    }
  }
  bestnode = undefined;
  foreach(node in areanodes) {
    if(isDefined(level.vtol.currentnode) && node == level.vtol.currentnode) {
      continue;
    }
    helinode = getent(node.target, "targetname");
    foreach(player in node.validplayers) {
      node.nodescore = node.nodescore + 1;
      if(bullettracepassed(player.origin + vectorscale((0, 0, 1), 32), helinode.origin, 0, player)) {
        node.nodescore = node.nodescore + 3;
      }
    }
    if(forcemove && distance(level.vtol.origin, helinode.origin) < 200) {
      node.nodescore = -1;
    }
    if(!isDefined(bestnode) || node.nodescore > bestnode.nodescore) {
      bestnode = node;
    }
  }
  return bestnode;
}

function traveltonode(goalnode) {
  originoffets = getoriginoffsets(goalnode);
  if(originoffets["start"] != self.origin) {
    if(isDefined(goalnode.script_airspeed) && isDefined(goalnode.script_accel)) {
      heli_speed = goalnode.script_airspeed;
      heli_accel = goalnode.script_accel;
    } else {
      heli_speed = 30 + randomint(20);
      heli_accel = 15 + randomint(15);
    }
    self setspeed(heli_speed, heli_accel);
    self setvehgoalpos(originoffets["start"] + vectorscale((0, 0, 1), 30), 0);
    self setgoalyaw(goalnode.angles[1] + 0);
    self waittill("goal");
  }
  if(originoffets["end"] != goalnode.origin) {
    if(isDefined(goalnode.script_airspeed) && isDefined(goalnode.script_accel)) {
      heli_speed = goalnode.script_airspeed;
      heli_accel = goalnode.script_accel;
    } else {
      heli_speed = 30 + randomint(20);
      heli_accel = 15 + randomint(15);
    }
    self setspeed(heli_speed, heli_accel);
    self setvehgoalpos(originoffets["end"] + vectorscale((0, 0, 1), 30), 0);
    self setgoalyaw(goalnode.angles[1] + 0);
    self waittill("goal");
  }
}

function getoriginoffsets(goalnode) {
  startorigin = self.origin;
  endorigin = goalnode.origin;
  numtraces = 0;
  maxtraces = 40;
  traceoffset = vectorscale((0, 0, -1), 196);
  traceorigin = bulletTrace(startorigin + traceoffset, endorigin + traceoffset, 0, self);
  while((distancesquared(traceorigin["position"], endorigin + traceoffset)) > 10 && numtraces < maxtraces) {
    println("" + (distancesquared(traceorigin[""], endorigin + traceoffset)));
    if(startorigin[2] < endorigin[2]) {
      startorigin = startorigin + vectorscale((0, 0, 1), 128);
    } else {
      if(startorigin[2] > endorigin[2]) {
        endorigin = endorigin + vectorscale((0, 0, 1), 128);
      } else {
        startorigin = startorigin + vectorscale((0, 0, 1), 128);
        endorigin = endorigin + vectorscale((0, 0, 1), 128);
      }
    }
    numtraces++;
    traceorigin = bulletTrace(startorigin + traceoffset, endorigin + traceoffset, 0, self);
  }
  offsets = [];
  offsets["start"] = startorigin;
  offsets["end"] = endorigin;
  return offsets;
}