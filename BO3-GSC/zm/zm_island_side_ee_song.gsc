/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_side_ee_song.gsc
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
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_island_power;
#using scripts\zm\zm_island_util;
#namespace zm_island_side_ee_song;

function autoexec __init__sytem__() {
  system::register("zm_island_side_ee_song", &__init__, undefined, undefined);
}

function __init__() {}

function main() {
  level thread function_88ab6cf8();
  level thread function_553b8e23();
  level thread function_222dc6f4();
  level thread function_76bcb530();
  level thread function_ae93bb6d();
}

function on_player_spawned() {}

function function_553b8e23() {
  level.var_51d5c50c = 0;
  level.var_c911c0a2 = struct::get_array("side_ee_song_bear", "targetname");
  array::thread_all(level.var_c911c0a2, &function_4b02c768);
  while(true) {
    level waittill("hash_c3f82290");
    if(level.var_51d5c50c == level.var_c911c0a2.size) {
      break;
    }
  }
  level thread zm_audio::sndmusicsystem_playstate("dead_flowers");
  level thread audio::unlockfrontendmusic("mus_dead_flowers_intro");
}

function function_4b02c768() {
  e_origin = spawn("script_origin", self.origin);
  e_origin zm_unitrigger::create_unitrigger();
  e_origin playLoopSound("zmb_ee_mus_lp", 1);
  e_origin thread zm_island_util::function_8faf1d24(vectorscale((0, 0, 1), 255), "");
  while(!(isDefined(e_origin.b_activated) && e_origin.b_activated)) {
    e_origin waittill("trigger_activated");
    if(isDefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || (isDefined(level.musicsystemoverride) && level.musicsystemoverride)) {
      continue;
    }
    e_origin function_f86c981f();
  }
  zm_unitrigger::unregister_unitrigger(e_origin.s_unitrigger);
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

function function_88ab6cf8() {
  zm_devgui::add_custom_devgui_callback(&function_aed87222);
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
}

function function_aed87222(cmd) {
  switch (cmd) {
    case "": {
      level.var_c911c0a2[0] function_f86c981f();
      return true;
    }
    case "": {
      level.var_c911c0a2[1] function_f86c981f();
      return true;
    }
    case "": {
      level.var_c911c0a2[2] function_f86c981f();
      return true;
    }
  }
  return false;
}

function function_222dc6f4() {
  locations = array((-114.98, 5300.02, -615.31), (1104, 4637.37, -493.965), (-1175.08, 2711.62, -379.708), (-2139.84, 633.162, 141), (2804.92, 798.876, -144.977));
  for(i = 0; i < locations.size; i++) {
    level thread function_4824fe93(locations[i], i + 1);
  }
}

function function_4824fe93(origin, num) {
  s_origin = spawnStruct();
  s_origin.origin = origin;
  s_origin zm_unitrigger::create_unitrigger();
  s_origin thread zm_island_util::function_8faf1d24(vectorscale((0, 0, 1), 255), "");
  s_origin waittill("trigger_activated");
  zm_unitrigger::unregister_unitrigger(s_origin.s_unitrigger);
  playsoundatposition("vox_maxis_maxis_radio_" + num, origin);
}

function function_76bcb530() {
  level.var_eeab4a07 = 0;
  var_f59c3cb2 = getEntArray("plantMusicPods", "targetname");
  if(!isDefined(var_f59c3cb2)) {
    return;
  }
  var_f59c3cb2 = array::sort_by_script_int(var_f59c3cb2, 1);
  foreach(pod in var_f59c3cb2) {
    pod thread function_69208549();
  }
  var_f918ed35 = struct::get("plantMusicPlay", "targetname");
  var_f918ed35 zm_unitrigger::create_unitrigger(undefined, 24);
  var_be2a0077 = array(1, 3, 5, 6, 7, 5);
  while(true) {
    var_f918ed35 waittill("trigger_activated");
    playsoundatposition("zmb_pod_play", var_f918ed35.origin);
    level.var_eeab4a07 = 1;
    var_d1146a02 = function_c5359566();
    match = 1;
    for(i = 0; i < var_d1146a02.size; i++) {
      if(var_d1146a02[i] != var_be2a0077[i]) {
        match = 0;
        break;
      }
    }
    if(isDefined(match) && match) {
      level function_88572b8();
    } else {
      for(i = 0; i < var_f59c3cb2.size; i++) {
        var_f59c3cb2[i] playSound("mus_podegg_note_" + var_f59c3cb2[i].var_b3a7fe6c);
        wait(0.6);
      }
    }
    level.var_eeab4a07 = 0;
  }
}

function function_69208549() {
  self.var_b3a7fe6c = 0;
  self thread function_cd6c47c5();
  self thread function_f86f94db();
}

function function_cd6c47c5() {
  self.unitrigger_stub = spawnStruct();
  self.unitrigger_stub.origin = self.origin;
  self.unitrigger_stub.angles = self.angles;
  self.unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
  self.unitrigger_stub.cursor_hint = "HINT_NOICON";
  self.unitrigger_stub.radius = 16;
  self.unitrigger_stub.require_look_at = 1;
  self.unitrigger_stub.related_parent = self;
  zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &zm_unitrigger::unitrigger_logic);
  while(true) {
    self waittill("trigger_activated", who);
    if(isDefined(level.var_eeab4a07) && level.var_eeab4a07) {
      continue;
    }
    if(self.var_b3a7fe6c < 8 && (isDefined(who.var_6fd3d65c) && who.var_6fd3d65c) && isDefined(who.var_bb2fd41c) && who.var_bb2fd41c > 0) {
      who thread zm_island_power::function_a84a1aec();
      self.var_b3a7fe6c++;
      self playSound("zmb_pod_fill");
    }
  }
}

function function_f86f94db() {
  while(true) {
    self waittill("damage", damage, attacker, dir, loc, str_type, model, tag, part, weapon, flags);
    if(!isDefined(attacker) || !isPlayer(attacker)) {
      continue;
    }
    if(isDefined(str_type) && str_type != "MOD_MELEE") {
      continue;
    }
    if(isDefined(level.var_eeab4a07) && level.var_eeab4a07) {
      continue;
    }
    self.var_b3a7fe6c = 0;
    self playSound("zmb_pod_empty");
  }
}

function function_c5359566() {
  var_f59c3cb2 = getEntArray("plantMusicPods", "targetname");
  var_5b979d9 = array::sort_by_script_int(var_f59c3cb2, 1);
  var_6ec57f04 = array();
  for(i = 0; i < var_5b979d9.size; i++) {
    array::add(var_6ec57f04, var_5b979d9[i].var_b3a7fe6c);
  }
  return var_6ec57f04;
}

function function_88572b8() {
  var_1d1c464d = array(0, 1, 2, 3, 4, 5, 3, 4);
  var_5c996589 = array(0, 1, 2, 3, 4, 3, 4);
  var_f59c3cb2 = getEntArray("plantMusicPods", "targetname");
  var_f59c3cb2 = array::sort_by_script_int(var_f59c3cb2, 1);
  var_60000174 = 3;
  n_waittime = 0.55;
  while(var_60000174 > 0) {
    for(i = 0; i < var_1d1c464d.size; i++) {
      var_f59c3cb2[var_1d1c464d[i]] playSound("mus_podegg_note_" + var_f59c3cb2[var_1d1c464d[i]].var_b3a7fe6c);
      wait(n_waittime);
      n_waittime = n_waittime - 0.01;
    }
    var_60000174--;
  }
  for(i = 0; i < var_5c996589.size; i++) {
    var_f59c3cb2[var_5c996589[i]] playSound("mus_podegg_note_" + var_f59c3cb2[var_5c996589[i]].var_b3a7fe6c);
    wait(n_waittime);
    n_waittime = n_waittime - 0.01;
  }
  wait(n_waittime);
  var_f59c3cb2[3] playsoundwithnotify("mus_podegg_lullaby", "sounddone");
  wait(103);
}

function function_ae93bb6d() {
  var_8e47507d = struct::get_array("sndusescare", "targetname");
  var_f45614a = struct::get_array("sndusescareTube", "targetname");
  if(!isDefined(var_8e47507d)) {
    return;
  }
  array::thread_all(var_8e47507d, &function_d75eac4e);
  level thread function_e01c1b04(var_f45614a);
}

function function_d75eac4e() {
  self zm_unitrigger::create_unitrigger(undefined, 24);
  while(true) {
    self waittill("trigger_activated");
    playsoundatposition(self.script_sound, self.origin);
    wait(200);
  }
}

function function_e01c1b04(var_f45614a) {
  if(var_f45614a.size <= 0) {
    return;
  }
  while(true) {
    var_4237d65e = randomintrange(0, var_f45614a.size);
    var_f45614a[var_4237d65e] zm_unitrigger::create_unitrigger(undefined, 24);
    var_f45614a[var_4237d65e] waittill("trigger_activated");
    playsoundatposition(var_f45614a[var_4237d65e].script_sound, var_f45614a[var_4237d65e].origin);
    zm_unitrigger::unregister_unitrigger(var_f45614a[var_4237d65e].unitrigger);
    wait(150);
  }
}