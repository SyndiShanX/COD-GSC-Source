/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_audio.gsc
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
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_stalingrad_dragon;
#namespace zm_stalingrad_audio;

function autoexec __init__sytem__() {
  system::register("zm_stalingrad_audio", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "ee_anthem_pa", 12000, 1, "int");
  clientfield::register("scriptmover", "ee_ballerina", 12000, 2, "int");
  level flag::init("ballerina_ready");
  level.var_bf88fef7 = 0;
  level.var_a31a784f = [];
  level.monkey_song_override = &function_24ff7a78;
}

function main() {
  level thread function_af4c67d();
  level thread function_41f49ee8();
  level thread function_5c7f73da();
  level thread function_7584d453();
  level thread function_663128e3();
  level thread function_ae93bb6d();
}

function on_player_spawned() {}

function function_af4c67d() {
  level.var_c128c3f5 = 0;
  level.var_9d74f1a7 = struct::get_array("side_ee_song_vodka", "targetname");
  array::thread_all(level.var_9d74f1a7, &function_5583a127);
  while(true) {
    level waittill("hash_9727ab41");
    if(level.var_c128c3f5 == level.var_9d74f1a7.size) {
      break;
    }
  }
  level thread zm_audio::sndmusicsystem_playstate("dead_ended");
}

function function_5583a127() {
  e_origin = spawn("script_origin", self.origin);
  e_origin zm_unitrigger::create_unitrigger();
  e_origin playLoopSound("zmb_ee_mus_lp", 1);
  e_origin thread function_8faf1d24(vectorscale((0, 0, 1), 255), "");
  while(!(isDefined(e_origin.b_activated) && e_origin.b_activated)) {
    e_origin waittill("trigger_activated");
    if(isDefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || (isDefined(level.musicsystemoverride) && level.musicsystemoverride)) {
      continue;
    }
    e_origin function_81b46338();
  }
  zm_unitrigger::unregister_unitrigger(e_origin.s_unitrigger);
  e_origin delete();
}

function function_81b46338() {
  if(!(isDefined(self.b_activated) && self.b_activated)) {
    self.b_activated = 1;
    level.var_c128c3f5++;
    level notify("hash_9727ab41");
    self stoploopsound(0.2);
  }
  self playSound("zmb_ee_mus_activate");
}

function function_41f49ee8() {
  level.var_62e63d78 = 0;
  level.var_68982832 = struct::get_array("side_ee_song_card", "targetname");
  array::thread_all(level.var_68982832, &function_f021c688);
  while(true) {
    level waittill("hash_ce64d360");
    if(level.var_62e63d78 == level.var_68982832.size) {
      break;
    }
  }
  level thread zm_audio::sndmusicsystem_playstate("ace_of_spades");
}

function function_f021c688() {
  self zm_unitrigger::create_unitrigger();
  self thread function_8faf1d24(vectorscale((0, 0, 1), 255), "");
  while(!(isDefined(self.b_activated) && self.b_activated)) {
    self waittill("trigger_activated");
    if(isDefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || (isDefined(level.musicsystemoverride) && level.musicsystemoverride)) {
      continue;
    }
    self.b_activated = 1;
    level.var_62e63d78++;
    level notify("hash_ce64d360");
    playsoundatposition("zmb_card_activate", self.origin);
  }
  zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

function function_8faf1d24(v_color, var_8882142e, n_scale, str_endon) {
  if(!isDefined(v_color)) {
    v_color = vectorscale((0, 0, 1), 255);
  }
  if(!isDefined(var_8882142e)) {
    var_8882142e = "";
  }
  if(!isDefined(n_scale)) {
    n_scale = 0.25;
  }
  if(!isDefined(str_endon)) {
    str_endon = "";
  }
  if(getdvarint("") == 0) {
    return;
  }
  if(isDefined(str_endon)) {
    self endon(str_endon);
  }
  origin = self.origin;
  while(true) {
    print3d(origin, var_8882142e, v_color, n_scale);
    wait(0.1);
  }
}

function function_ae93bb6d() {
  var_8e47507d = struct::get_array("creepyyuse", "targetname");
  if(!isDefined(var_8e47507d)) {
    return;
  }
  array::thread_all(var_8e47507d, &function_d75eac4e);
}

function function_d75eac4e() {
  self zm_unitrigger::create_unitrigger(undefined, 50);
  while(true) {
    self waittill("trigger_activated");
    playsoundatposition(self.script_sound, self.origin);
    wait(200);
  }
}

function function_e01c1b04(var_99ad39b9) {
  if(var_99ad39b9.size <= 0) {
    return;
  }
  while(true) {
    var_4237d65e = randomintrange(0, var_99ad39b9.size);
    var_99ad39b9[var_4237d65e] zm_unitrigger::create_unitrigger(undefined, 24);
    var_99ad39b9[var_4237d65e] waittill("trigger_activated");
    playsoundatposition(var_99ad39b9[var_4237d65e].script_sound, var_99ad39b9[var_4237d65e].origin);
    zm_unitrigger::unregister_unitrigger(var_99ad39b9[var_4237d65e].unitrigger);
    wait(150);
  }
}

function function_5c7f73da() {
  for(i = 1; i < 6; i++) {
    var_2de8cf5e = struct::get_array("ee_sophia_reels_" + i, "targetname");
    if(var_2de8cf5e.size <= 0) {
      return;
    }
    foreach(s_reel in var_2de8cf5e) {
      var_de6d4fc0 = util::spawn_model(s_reel.model, s_reel.origin, s_reel.angles);
      s_reel.var_de6d4fc0 = var_de6d4fc0;
      s_reel.var_de6d4fc0 thread function_e464aa51();
    }
    if(i == 5) {
      level thread function_8c75c164(var_2de8cf5e, i);
      continue;
    }
    level thread function_ab32c346(var_2de8cf5e, i);
  }
}

function function_ab32c346(var_2de8cf5e, var_bee8e45) {
  var_2de8cf5e[0] zm_unitrigger::create_unitrigger();
  while(true) {
    var_2de8cf5e[0] waittill("trigger_activated", who);
    if(!who zm_utility::is_player_looking_at(var_2de8cf5e[0].origin)) {
      continue;
    }
    function_ccdb680e(var_2de8cf5e, 1);
    var_2de8cf5e[0].var_de6d4fc0 function_8e130ce5(var_bee8e45);
    function_ccdb680e(var_2de8cf5e, 0);
  }
}

function function_8c75c164(var_2de8cf5e, var_bee8e45) {
  var_2de8cf5e[0].var_de6d4fc0 setCanDamage(1);
  while(true) {
    var_2de8cf5e[0].var_de6d4fc0.health = 1000000;
    var_2de8cf5e[0].var_de6d4fc0 waittill("damage", damage, attacker, dir, loc, type, model, tag, part, weapon, flags);
    if(!isDefined(attacker) || !isPlayer(attacker)) {
      continue;
    }
    function_ccdb680e(var_2de8cf5e, 1);
    var_2de8cf5e[0].var_de6d4fc0 function_8e130ce5(var_bee8e45);
    function_ccdb680e(var_2de8cf5e, 0);
  }
}

function function_8e130ce5(var_bee8e45) {
  self playsoundwithnotify("vox_soph_sophia_log_" + var_bee8e45, "sounddone");
  if(var_bee8e45 == 2) {
    self playSound("zmb_sophia_log_2_sfx");
  }
  self waittill("sounddone");
}

function function_ccdb680e(var_2de8cf5e, b_on) {
  foreach(s_reel in var_2de8cf5e) {
    if(isDefined(s_reel.var_de6d4fc0)) {
      s_reel.var_de6d4fc0.var_a02b0d5a = b_on;
    }
  }
}

function function_e464aa51() {
  while(true) {
    if(isDefined(self.var_a02b0d5a) && self.var_a02b0d5a) {
      self rotateroll(-30, 0.2);
    }
    wait(0.2);
  }
}

function function_7584d453() {
  level waittill("hash_9b1cee4c");
  var_18b908ea = spawn("script_origin", (0, 0, 0));
  var_18b908ea playLoopSound("zmb_outro_battle_bg", 1);
  level waittill("hash_846351df");
  var_18b908ea stoploopsound(1);
  var_18b908ea delete();
}

function function_f1ce2a9a(state = 0) {
  level endon("end_game");
  switch (state) {
    case 1: {
      level.musicsystemoverride = 1;
      music::setmusicstate("none");
      level thread function_61c5cb4e();
      break;
    }
    case 2: {
      level thread function_9fa22cf7();
      music::setmusicstate("ace_of_spades");
      level thread function_d0e8b85d();
      break;
    }
    case 3: {
      level thread function_9fa22cf7();
      music::setmusicstate("nikolai_fight");
      break;
    }
    case 4: {
      level thread function_9fa22cf7();
      music::setmusicstate("none");
      level.musicsystemoverride = 0;
      break;
    }
  }
}

function function_61c5cb4e() {
  level endon("hash_787a404e");
  var_4540293a = struct::get_array("s_anthem_array", "targetname");
  level.var_96d76bfc = 0;
  level.var_c9c5dfcc = var_4540293a.size;
  foreach(var_71f55e40 in var_4540293a) {
    var_71f55e40 thread function_3b8ba4e9();
  }
  wait(68.7);
  level thread function_f1ce2a9a(3);
}

function function_3b8ba4e9() {
  level endon("hash_787a404e");
  self.var_1431218c = util::spawn_model(self.model, self.origin, self.angles);
  self.var_1431218c clientfield::set("ee_anthem_pa", 1);
  self.var_1431218c setCanDamage(1);
  if(1) {
    for(;;) {
      self.var_1431218c.health = 1000000;
      self.var_1431218c waittill("damage", damage, attacker, dir, loc, type, model, tag, part, weapon, flags);
    }
    if(!isDefined(attacker) || !isPlayer(attacker)) {}
    self.var_1431218c clientfield::set("ee_anthem_pa", 0);
    self.var_1431218c playSound("zmb_nikolai_mus_pa_destruct");
    util::wait_network_frame();
    self.var_1431218c delete();
    self.var_1431218c = undefined;
    level.var_96d76bfc++;
    if(level.var_96d76bfc >= level.var_c9c5dfcc) {
      level thread function_f1ce2a9a(2);
    }
    return;
  }
}

function function_9fa22cf7() {
  level notify("hash_787a404e");
  var_4540293a = struct::get_array("s_anthem_array", "targetname");
  foreach(var_71f55e40 in var_4540293a) {
    if(isDefined(var_71f55e40.var_1431218c)) {
      var_71f55e40.var_1431218c clientfield::set("ee_anthem_pa", 0);
      util::wait_network_frame();
      var_71f55e40.var_1431218c delete();
      var_71f55e40.var_1431218c = undefined;
    }
  }
}

function function_d0e8b85d() {
  level endon("hash_787a404e");
  level endon("end_game");
  wait(170);
  music::setmusicstate("nikolai_fight");
}

function function_663128e3() {
  level flag::wait_till("ballerina_ready");
  wait(8);
  level function_6b495bd6();
  while(true) {
    success = level function_4c503dc7();
    if(!(isDefined(success) && success)) {
      level function_6b495bd6(1);
      continue;
    }
    level function_d64d6d35();
    break;
  }
  level thread zm_audio::sndmusicsystem_playstate("sam");
}

function function_6b495bd6(restart = 0) {
  s_ballerina_start = struct::get("s_ballerina_start", "targetname");
  if(!(isDefined(restart) && restart)) {
    playsoundatposition("zmb_sam_egg_success", (0, 0, 0));
    var_ac086ffb = util::spawn_model(s_ballerina_start.model, s_ballerina_start.origin - vectorscale((0, 0, 1), 20), s_ballerina_start.angles);
    var_ac086ffb clientfield::set("ee_ballerina", 2);
    var_ac086ffb moveto(s_ballerina_start.origin, 2);
    var_ac086ffb waittill("movedone");
  } else {
    playsoundatposition("zmb_sam_egg_fail", (0, 0, 0));
    var_ac086ffb = util::spawn_model(s_ballerina_start.model, s_ballerina_start.origin, s_ballerina_start.angles);
    var_ac086ffb clientfield::set("ee_ballerina", 1);
  }
  s_ballerina_start zm_unitrigger::create_unitrigger(undefined, 24);
  s_ballerina_start waittill("trigger_activated");
  zm_unitrigger::unregister_unitrigger(s_ballerina_start.unitrigger);
  var_ac086ffb clientfield::set("ee_ballerina", 0);
  util::wait_network_frame();
  var_ac086ffb delete();
}

function function_4c503dc7() {
  var_d1f154fd = struct::get_array("s_ballerina_timed", "targetname");
  var_d1f154fd = array::randomize(var_d1f154fd);
  for(i = 0; i < 5; i++) {
    success = var_d1f154fd[i] function_dc391fc3();
    if(!(isDefined(success) && success)) {
      return false;
    }
  }
  return true;
}

function function_dc391fc3() {
  self.var_ac086ffb = util::spawn_model(self.model, self.origin, self.angles);
  self.var_ac086ffb clientfield::set("ee_ballerina", 1);
  self.var_ac086ffb playLoopSound("mus_stalingrad_musicbox_lp", 2);
  self.success = 0;
  self thread function_631d8c1();
  self thread function_75442852();
  self thread function_db914e();
  self.var_ac086ffb thread zm_utility::print3d_ent("", (0, 1, 0), 3, vectorscale((0, 0, 1), 24));
  self util::waittill_any("ballerina_destroyed", "ballerina_timeout");
  self.var_ac086ffb notify("end_print3d");
  self.var_ac086ffb clientfield::set("ee_ballerina", 0);
  util::wait_network_frame();
  self.var_ac086ffb delete();
  return self.success;
}

function function_631d8c1() {
  self.var_ac086ffb endon("death");
  self endon("hash_636d801f");
  self endon("ballerina_destroyed");
  self endon("ballerina_timeout");
  while(true) {
    self.var_ac086ffb rotateyaw(360, 4);
    wait(4);
  }
}

function function_75442852() {
  self endon("ballerina_timeout");
  self.var_ac086ffb setCanDamage(1);
  self.var_ac086ffb.health = 1000000;
  while(true) {
    self.var_ac086ffb waittill("damage", damage, attacker, dir, loc, type, model, tag, part, weapon, flags);
    if(!isDefined(attacker) || !isPlayer(attacker)) {
      continue;
    }
    self.success = 1;
    self notify("ballerina_destroyed");
    break;
  }
}

function function_db914e() {
  self endon("ballerina_destroyed");
  if(level.players.size > 1) {
    wait(90 - (15 * level.players.size));
  } else {
    wait(90);
  }
  self notify("ballerina_timeout");
}

function function_d64d6d35() {
  playsoundatposition("zmb_sam_egg_success", (0, 0, 0));
  s_ballerina_end = struct::get("s_ballerina_end", "targetname");
  s_ballerina_end.var_ac086ffb = util::spawn_model(s_ballerina_end.model, s_ballerina_end.origin, s_ballerina_end.angles);
  s_ballerina_end.var_ac086ffb clientfield::set("ee_ballerina", 1);
  s_ballerina_end.var_ac086ffb playLoopSound("mus_stalingrad_musicbox_lp", 2);
  s_ballerina_end thread function_631d8c1();
  s_ballerina_end zm_unitrigger::create_unitrigger(undefined, 65);
  s_ballerina_end waittill("trigger_activated");
  zm_unitrigger::unregister_unitrigger(s_ballerina_end.unitrigger);
  s_ballerina_end notify("hash_636d801f");
  s_ballerina_end.var_ac086ffb stoploopsound(0.5);
  s_ballerina_end.var_ac086ffb playSound("zmb_challenge_skel_arm_up");
  var_f6c28cea = (2, 0, -6.5);
  var_e97ebb83 = (3.5, 0, -18.5);
  s_ballerina_end.var_3609adde = util::spawn_model("c_zom_dlc1_skeleton_zombie_body_s_rarm", s_ballerina_end.origin, s_ballerina_end.angles);
  s_ballerina_end.var_2a9b65c7 = util::spawn_model("p7_skulls_bones_arm_lower", s_ballerina_end.origin + var_f6c28cea, vectorscale((1, 0, 0), 180));
  s_ballerina_end.var_79dc7980 = util::spawn_model("p7_skulls_bones_arm_lower", s_ballerina_end.origin + var_e97ebb83, vectorscale((1, 0, 0), 180));
  s_ballerina_end.var_ac086ffb movez(20, 0.5);
  s_ballerina_end.var_3609adde movez(20, 0.5);
  s_ballerina_end.var_2a9b65c7 movez(20, 0.5);
  s_ballerina_end.var_79dc7980 movez(20, 0.5);
  wait(0.05);
  s_ballerina_end.var_3609adde clientfield::increment("challenge_arm_reveal");
  s_ballerina_end.var_3609adde waittill("movedone");
  wait(1);
  s_ballerina_end.var_ac086ffb playLoopSound("zmb_challenge_skel_arm_lp", 0.25);
  s_ballerina_end.var_ac086ffb movez(-30, 1.5);
  s_ballerina_end.var_3609adde movez(-30, 1.5);
  s_ballerina_end.var_2a9b65c7 movez(-30, 1.5);
  s_ballerina_end.var_79dc7980 movez(-30, 1.5);
  s_ballerina_end.var_ac086ffb waittill("movedone");
  zm_powerups::specific_powerup_drop("full_ammo", s_ballerina_end.origin);
  s_ballerina_end.var_ac086ffb delete();
  s_ballerina_end.var_3609adde delete();
  s_ballerina_end.var_2a9b65c7 delete();
  s_ballerina_end.var_79dc7980 delete();
}

function function_24ff7a78(owner, weapon) {
  var_c4311d6f = dragon::function_69a0541c();
  if(isDefined(var_c4311d6f)) {
    if(array::contains(level.var_a31a784f, var_c4311d6f)) {
      return false;
    }
    var_12bd8497 = getent(var_c4311d6f + "_1_damage", "targetname");
    if(isDefined(var_12bd8497.var_3eb19318) && var_12bd8497.var_3eb19318 && self istouching(var_12bd8497)) {
      array::add(level.var_a31a784f, var_c4311d6f);
      level.var_bf88fef7++;
      if(level.var_bf88fef7 >= 3) {
        level flag::set("ballerina_ready");
        level.monkey_song_override = undefined;
        return true;
      }
      return true;
    }
  }
  return false;
}