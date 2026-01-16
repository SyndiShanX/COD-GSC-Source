/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\audio_shared.gsc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\music_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#namespace audio;

function autoexec __init__sytem__() {
  system::register("audio", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_spawned( & sndresetsoundsettings);
  callback::on_spawned( & missilelockwatcher);
  callback::on_spawned( & missilefirewatcher);
  callback::on_player_killed( & on_player_killed);
  callback::on_vehicle_spawned( & vehiclespawncontext);
  level thread register_clientfields();
  level thread sndchyronwatcher();
  level thread sndigcskipwatcher();
}

function register_clientfields() {
  clientfield::register("world", "sndMatchSnapshot", 1, 2, "int");
  clientfield::register("world", "sndFoleyContext", 1, 1, "int");
  clientfield::register("scriptmover", "sndRattle", 1, 1, "int");
  clientfield::register("toplayer", "sndMelee", 1, 1, "int");
  clientfield::register("vehicle", "sndSwitchVehicleContext", 1, 3, "int");
  clientfield::register("toplayer", "sndCCHacking", 1, 2, "int");
  clientfield::register("toplayer", "sndTacRig", 1, 1, "int");
  clientfield::register("toplayer", "sndLevelStartSnapOff", 1, 1, "int");
  clientfield::register("world", "sndIGCsnapshot", 1, 4, "int");
  clientfield::register("world", "sndChyronLoop", 1, 1, "int");
  clientfield::register("world", "sndZMBFadeIn", 1, 1, "int");
}

function sndchyronwatcher() {
  level waittill("chyron_menu_open");
  level clientfield::set("sndChyronLoop", 1);
  level waittill("chyron_menu_closed");
  level clientfield::set("sndChyronLoop", 0);
}

function sndigcskipwatcher() {
  while (true) {
    level waittill("scene_skip_sequence_started");
    music::setmusicstate("death");
  }
}

function sndresetsoundsettings() {
  self clientfield::set_to_player("sndMelee", 0);
  self util::clientnotify("sndDEDe");
}

function on_player_killed() {
  if(!(isdefined(self.killcam) && self.killcam)) {
    self util::clientnotify("sndDED");
  }
}

function vehiclespawncontext() {
  self clientfield::set("sndSwitchVehicleContext", 1);
}

function sndupdatevehiclecontext(added) {
  if(!isdefined(self.sndoccupants)) {
    self.sndoccupants = 0;
  }
  if(added) {
    self.sndoccupants++;
  } else {
    self.sndoccupants--;
    if(self.sndoccupants < 0) {
      self.sndoccupants = 0;
    }
  }
  self clientfield::set("sndSwitchVehicleContext", self.sndoccupants + 1);
}

function playtargetmissilesound(alias, looping) {
  self notify("stop_target_missile_sound");
  self endon("stop_target_missile_sound");
  self endon("disconnect");
  self endon("death");
  if(isdefined(alias)) {
    time = soundgetplaybacktime(alias) * 0.001;
    if(time > 0) {
      do {
        self playlocalsound(alias);
        wait(time);
      }
      while (looping);
    }
  }
}

function missilelockwatcher() {
  self endon("death");
  self endon("disconnect");
  if(!self flag::exists("playing_stinger_fired_at_me")) {
    self flag::init("playing_stinger_fired_at_me", 0);
  } else {
    self flag::clear("playing_stinger_fired_at_me");
  }
  while (true) {
    self waittill("missile_lock", attacker, weapon);
    if(!flag::get("playing_stinger_fired_at_me")) {
      self thread playtargetmissilesound(weapon.lockontargetlockedsound, weapon.lockontargetlockedsoundloops);
      self util::waittill_any("stinger_fired_at_me", "missile_unlocked", "death");
      self notify("stop_target_missile_sound");
    }
  }
}

function missilefirewatcher() {
  self endon("death");
  self endon("disconnect");
  while (true) {
    self waittill("stinger_fired_at_me", missile, weapon, attacker);
    waittillframeend();
    self flag::set("playing_stinger_fired_at_me");
    self thread playtargetmissilesound(weapon.lockontargetfiredonsound, weapon.lockontargetfiredonsoundloops);
    missile util::waittill_any("projectile_impact_explode", "death");
    self notify("stop_target_missile_sound");
    self flag::clear("playing_stinger_fired_at_me");
  }
}

function unlockfrontendmusic(unlockname, allplayers = 1) {
  if(isdefined(allplayers) && allplayers) {
    if(isdefined(level.players) && level.players.size > 0) {
      foreach(player in level.players) {
        player unlocksongbyalias(unlockname);
      }
    }
  } else {
    self unlocksongbyalias(unlockname);
  }
}