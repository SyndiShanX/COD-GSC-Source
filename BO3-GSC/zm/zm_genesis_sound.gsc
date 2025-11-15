/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_sound.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\music_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace zm_genesis_sound;

function autoexec __init__sytem__() {
  system::register("zm_genesis_sound", & __init__, undefined, undefined);
}

function __init__() {
  level.sndplaystateoverride = & function_de04b701;
}

function main() {
  level thread function_ae93bb6d();
  level thread function_7624a208();
  level thread function_c2fa1ebc();
}

function function_de04b701(state) {
  if(!function_b01e339d(state)) {
    return false;
  }
  level thread function_69f1cd9e(state);
  return true;
}

function function_69f1cd9e(state) {
  foreach(player in level.players) {
    location = player function_5d99d675();
    num = function_d6870cf0(state, location);
    num = randomintrange(1, num + 1);
    if(!isDefined(location)) {
      return;
    }
    if(state == "round_start_short") {
      state = "round_start";
    }
    statename = (state + "_") + location;
    if(state != "game_over") {
      statename = (statename + "_") + num;
    }
    music::setmusicstate(statename, player);
  }
}

function function_b01e339d(state) {
  if(state == "round_start" || state == "round_start_short" || state == "round_end" || state == "game_over") {
    return true;
  }
  return false;
}

function function_5d99d675() {
  str_player_zone = self zm_zonemgr::get_player_zone();
  if(!isDefined(str_player_zone)) {
    return "genesis";
  }
  if(issubstr(str_player_zone, "zm_tomb")) {
    return "tomb";
  }
  if(issubstr(str_player_zone, "zm_prison")) {
    return "motd";
  }
  if(issubstr(str_player_zone, "zm_temple")) {
    if(str_player_zone == "zm_temple_undercroft_zone" || str_player_zone == "zm_temple_undercroft2_zone" || str_player_zone == "zm_temple_box_zone") {
      return "castle";
    }
    return "temple";
  }
  if(issubstr(str_player_zone, "zm_castle")) {
    return "castle";
  }
  if(issubstr(str_player_zone, "zm_theater")) {
    return "theater";
  }
  if(issubstr(str_player_zone, "zm_asylum")) {
    return "asylum";
  }
  if(issubstr(str_player_zone, "zm_prototype")) {
    return "prototype";
  }
  return "genesis";
}

function function_d6870cf0(state, location) {
  switch (location) {
    case "castle": {
      if(state == "round_start") {
        return 1;
      }
      if(state == "round_end") {
        return 3;
      }
      break;
    }
    case "motd": {
      if(state == "round_start") {
        return 4;
      }
      if(state == "round_end") {
        return 1;
      }
      break;
    }
    case "genesis": {
      if(state == "round_start") {
        return 3;
      }
      if(state == "round_end") {
        return 1;
      }
      break;
    }
    case "tomb": {
      if(state == "round_start") {
        return 4;
      }
      if(state == "round_end") {
        return 1;
      }
    }
    case "theater": {
      if(state == "round_start") {
        return 2;
      }
      if(state == "round_end") {
        return 1;
      }
      break;
    }
  }
  return 1;
}

function function_3fee3760() {
  level util::clientnotify("stpThm");
}

function function_ae93bb6d() {
  var_8e47507d = struct::get_array("sndusescare", "targetname");
  if(!isDefined(var_8e47507d)) {
    return;
  }
  array::thread_all(var_8e47507d, & function_d75eac4e);
}

function function_d75eac4e() {
  if(self.script_sound == "zmb_usescare_sam_phono") {
    self thread function_44448bcb();
    return;
  }
  self zm_unitrigger::create_unitrigger(undefined, 35);
  while(true) {
    self waittill("trigger_activated");
    playsoundatposition(self.script_sound, self.origin);
    wait(200);
  }
}

function function_44448bcb() {
  var_bc15748 = spawn("trigger_radius_use", self.origin, 0, 100, 100);
  var_bc15748 sethintstring("");
  var_bc15748 setcursorhint("HINT_NOICON");
  var_bc15748 triggerignoreteam();
  var_bc15748 usetriggerrequirelookat();
  var_bc15748 waittill("trigger");
  var_bc15748 playSound(self.script_sound);
  wait(120);
  var_bc15748 delete();
}

function function_b18c11d8() {
  level function_4b776d12();
  level thread function_8554d5da();
}

function function_8554d5da() {
  var_d0a6531d = struct::get("old_school_radio", "targetname");
  if(!isDefined(var_d0a6531d)) {
    return;
  }
  var_99ff4537 = util::spawn_model(var_d0a6531d.model, var_d0a6531d.origin, var_d0a6531d.angles);
  var_99ff4537 setCanDamage(1);
  var_99ff4537 thread function_2d4f4459();
  var_99ff4537 thread function_f184004e();
  while(true) {
    var_99ff4537.health = 1000000;
    var_99ff4537 waittill("damage", damage, attacker, dir, loc, type, model, tag, part, weapon, flags);
    if(!isDefined(attacker) || !isplayer(attacker)) {
      continue;
    }
    if(type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE") {
      continue;
    }
    if(type == "MOD_MELEE") {
      var_99ff4537 notify("hash_dec13539");
    } else {
      var_99ff4537 notify("hash_34d24635");
    }
  }
}

function function_2d4f4459() {
  self.trackname = undefined;
  self.tracknum = 0;
  while(true) {
    self waittill("hash_34d24635");
    if(isDefined(self.var_175c09e5)) {
      self stopsound(self.var_175c09e5);
      wait(0.05);
    }
    self playsoundwithnotify("zmb_minor_skool_radio_switch", "sounddone");
    self waittill("sounddone");
    self thread function_c62f1c37();
  }
}

function function_c62f1c37() {
  self endon("hash_34d24635");
  self endon("hash_dec13539");
  self playsoundwithnotify(level.var_2ec01df2[self.tracknum], "songdone");
  self.var_175c09e5 = level.var_2ec01df2[self.tracknum];
  self.tracknum++;
  if(self.tracknum >= level.var_2ec01df2.size) {
    self.tracknum = 0;
  }
  self waittill("songdone");
  self notify("hash_34d24635");
}

function function_f184004e() {
  while(true) {
    self waittill("hash_dec13539");
    self playsoundwithnotify("zmb_minor_skool_radio_off", "sounddone");
    if(isDefined(self.var_175c09e5)) {
      self stopsound(self.var_175c09e5);
    }
  }
}

function function_4b776d12() {
  level.var_2ec01df2 = array("mus_genesis_radio_track_1", "mus_genesis_radio_track_2", "mus_genesis_radio_track_3", "mus_genesis_radio_track_4", "mus_genesis_radio_track_5", "mus_genesis_radio_track_6", "mus_genesis_radio_track_7", "mus_genesis_radio_track_8", "mus_genesis_radio_track_9", "mus_genesis_radio_track_10", "mus_genesis_radio_track_11", "mus_genesis_radio_track_12", "mus_genesis_radio_track_13", "mus_genesis_radio_track_14", "mus_genesis_radio_track_15", "mus_genesis_radio_track_16", "mus_genesis_radio_track_17", "mus_genesis_radio_track_18", "mus_genesis_radio_track_19", "mus_genesis_radio_track_20", "mus_genesis_radio_track_21", "mus_genesis_radio_track_22", "mus_genesis_radio_track_23", "mus_genesis_radio_track_24", "mus_genesis_radio_track_25", "mus_genesis_radio_track_26", "mus_genesis_radio_track_27", "mus_genesis_radio_track_28", "mus_genesis_radio_track_29", "mus_genesis_radio_track_30", "mus_genesis_radio_track_31", "mus_genesis_radio_track_33", "mus_genesis_radio_track_32");
}

function function_7624a208() {
  level.var_51d5c50c = 0;
  level.var_c911c0a2 = struct::get_array("side_ee_song_bear", "targetname");
  array::thread_all(level.var_c911c0a2, & function_4b02c768);
  while(true) {
    level waittill("hash_c3f82290");
    if(level.var_51d5c50c == level.var_c911c0a2.size) {
      break;
    }
  }
  level thread function_3fee3760();
  level thread zm_audio::sndmusicsystem_playstate("the_gift");
  wait(1);
  while(isDefined(level.musicsystem.currentstate)) {
    wait(1);
  }
  level util::clientnotify("strtthm");
}

function function_4b02c768() {
  e_origin = spawn("script_origin", self.origin);
  e_origin zm_unitrigger::create_unitrigger();
  e_origin playLoopSound("zmb_ee_mus_lp", 1);
  while(!(isDefined(e_origin.b_activated) && e_origin.b_activated)) {
    e_origin waittill("trigger_activated");
    if(isDefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || (isDefined(level.musicsystemoverride) && level.musicsystemoverride)) {
      continue;
    }
    e_origin function_f86c981f();
  }
  zm_unitrigger::unregister_unitrigger(e_origin.s_unitrigger);
  e_origin delete();
}

function function_f86c981f() {
  if(!(isDefined(self.b_activated) && self.b_activated)) {
    self.b_activated = 1;
    level.var_51d5c50c++;
    level notify("hash_c3f82290");
    self stoploopsound(0.2);
  }
  self playSound("zmb_ee_mus_activate");
}

function function_936d084f() {
  level.musicsystemoverride = 1;
  music::setmusicstate("bossrush");
}

function function_e9341208() {
  level.musicsystemoverride = 1;
  music::setmusicstate("finalfight_start");
}

function function_ecd49d9c() {
  level.musicsystemoverride = 1;
  music::setmusicstate("finalfight");
}

function function_d73dcf42() {
  level.musicsystemoverride = 0;
  music::setmusicstate("none");
}

function function_c2fa1ebc() {
  vending_triggers = getEntArray("zombie_vending", "targetname");
  array::thread_all(vending_triggers, & function_1d3f00e6);
}

function function_1d3f00e6() {
  self endon("hash_55cf60a4");
  var_3628045a = function_692ac4e1(self.script_noteworthy);
  if(!isDefined(var_3628045a)) {
    return;
  }
  var_326ccfe3 = self.bump;
  for(;;) {
    var_326ccfe3 waittill("trigger", e_player);
    if(isDefined(e_player) && isplayer(e_player)) {
      if(isDefined(e_player.perks_active) && e_player.perks_active.size == 9 && (isDefined(self.sndjingleactive) && self.sndjingleactive)) {
        e_player thread function_97997a8c(self, var_326ccfe3, var_3628045a);
        while(e_player istouching(var_326ccfe3)) {
          wait(0.05);
        }
        e_player notify("hash_56e16440");
      }
    }
    wait(0.05);
  }
}

function function_97997a8c(perk_machine, var_326ccfe3, var_3628045a) {
  self endon("death");
  self endon("disconnect");
  self endon("player_downed");
  self endon("hash_56e16440");
  while(!self meleebuttonpressed()) {
    wait(0.05);
  }
  perk_machine notify("hash_55cf60a4");
  perk_machine.sndjinglecooldown = 1;
  perk_machine.var_1afc1154 = 1;
  perk_machine stopsound(perk_machine.str_jingle_alias);
  perk_machine playSound("vox_lyrics_bump");
  playsoundatposition(var_3628045a, var_326ccfe3.origin);
  wait(60);
  perk_machine.var_1afc1154 = 0;
  perk_machine.sndjinglecooldown = 0;
}

function function_692ac4e1(perk) {
  switch (perk) {
    case "specialty_doubletap2": {
      str_alias = "vox_lyrics_dt";
      break;
    }
    case "specialty_armorvest": {
      str_alias = "vox_lyrics_jugg";
      break;
    }
    case "specialty_quickrevive": {
      str_alias = "vox_lyrics_revive";
      break;
    }
    case "specialty_fastreload": {
      str_alias = "vox_lyrics_speed";
      break;
    }
  }
  return str_alias;
}