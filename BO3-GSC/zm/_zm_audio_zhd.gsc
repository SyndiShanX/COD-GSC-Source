/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_audio_zhd.gsc
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
#namespace zm_audio_zhd;

function autoexec __init__sytem__() {
  system::register("zm_audio_zhd", & __init__, undefined, undefined);
}

function __init__() {
  level flag::init("snd_zhdegg_activate");
  level flag::init("snd_zhdegg_completed");
  level flag::init("snd_song_completed");
  clientfield::register("scriptmover", "snd_zhdegg", 21000, 2, "int");
  clientfield::register("scriptmover", "snd_zhdegg_arm", 21000, 1, "counter");
  level.var_252a085b = 0;
  level thread snd_zhdegg_activate();
  level thread snd_monty_radio();
  level thread setup_personality_character_exerts();
}

function snd_zhdegg_activate() {
  level flag::wait_till("snd_zhdegg_activate");
  level function_513f51e1();
  while(true) {
    if(isDefined(level.var_61f315ab)) {
      success = [
        [level.var_61f315ab]
      ]();
    } else {
      success = level function_cf1b154();
    }
    if(!(isDefined(success) && success)) {
      level function_513f51e1(1);
      continue;
    }
    if(isDefined(level.var_8229c449)) {
      level[[level.var_8229c449]]();
    } else {
      level function_5b2770da();
    }
    break;
  }
  level thread zm_audio::sndmusicsystem_playstate("sam");
}

function function_513f51e1(restart = 0) {
  s_ballerina_start = struct::get("s_ballerina_start", "targetname");
  if(!isDefined(s_ballerina_start)) {
    return;
  }
  if(!(isDefined(restart) && restart)) {
    playsoundatposition("zmb_sam_egg_success", (0, 0, 0));
    var_ac086ffb = util::spawn_model(s_ballerina_start.model, s_ballerina_start.origin - vectorscale((0, 0, 1), 20), s_ballerina_start.angles);
    var_ac086ffb clientfield::set("snd_zhdegg", 2);
    var_ac086ffb moveto(s_ballerina_start.origin, 2);
    var_ac086ffb waittill("movedone");
  } else {
    playsoundatposition("zmb_sam_egg_fail", (0, 0, 0));
    var_ac086ffb = util::spawn_model(s_ballerina_start.model, s_ballerina_start.origin, s_ballerina_start.angles);
    var_ac086ffb clientfield::set("snd_zhdegg", 1);
  }
  s_ballerina_start zm_unitrigger::create_unitrigger(undefined, 80);
  s_ballerina_start waittill("trigger_activated");
  zm_unitrigger::unregister_unitrigger(s_ballerina_start.s_unitrigger);
  var_ac086ffb clientfield::set("snd_zhdegg", 0);
  util::wait_network_frame();
  var_ac086ffb delete();
}

function function_cf1b154() {
  var_d1f154fd = struct::get_array("s_ballerina_timed", "targetname");
  var_d1f154fd = array::randomize(var_d1f154fd);
  if(isDefined(var_d1f154fd[0].script_int)) {
    var_d1f154fd = array::sort_by_script_int(var_d1f154fd, 1);
  }
  n_amount = var_d1f154fd.size;
  if(n_amount >= 5) {
    n_amount = 5;
  }
  for(i = 0; i < n_amount; i++) {
    success = var_d1f154fd[i] function_3cf3ba48();
    if(!(isDefined(success) && success)) {
      return false;
    }
  }
  return true;
}

function function_3cf3ba48() {
  self.var_ac086ffb = util::spawn_model(self.model, self.origin, self.angles);
  self.var_ac086ffb clientfield::set("snd_zhdegg", 1);
  self.var_ac086ffb playLoopSound("mus_musicbox_lp", 2);
  self.success = 0;
  self thread function_9d55fd08();
  self thread function_2fdaabf3();
  self thread function_a9a34039();
  self.var_ac086ffb thread zm_utility::print3d_ent("", (0, 1, 0), 3, vectorscale((0, 0, 1), 24));
  self util::waittill_any("ballerina_destroyed", "ballerina_timeout");
  self.var_ac086ffb notify("end_print3d");
  self.var_ac086ffb clientfield::set("snd_zhdegg", 0);
  util::wait_network_frame();
  self.var_ac086ffb delete();
  return self.success;
}

function function_9d55fd08() {
  self.var_ac086ffb endon("death");
  self endon("hash_636d801f");
  self endon("ballerina_destroyed");
  self endon("ballerina_timeout");
  while(true) {
    self.var_ac086ffb rotateyaw(360, 4);
    wait(4);
  }
}

function function_2fdaabf3() {
  self endon("ballerina_timeout");
  self.var_ac086ffb setCanDamage(1);
  self.var_ac086ffb.health = 1000000;
  while(true) {
    self.var_ac086ffb waittill("damage", damage, attacker, dir, loc, type, model, tag, part, weapon, flags);
    if(isDefined(level.var_252a085b) && level.var_252a085b) {
      continue;
    }
    if(!isDefined(attacker) || !isplayer(attacker)) {
      continue;
    }
    if(type == "MOD_PROJECTILE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_GRENADE" || type == "MOD_EXPLOSIVE") {
      continue;
    }
    self.success = 1;
    self notify("ballerina_destroyed");
    level.var_252a085b = 1;
    wait(0.1);
    level.var_252a085b = 0;
    break;
  }
}

function function_a9a34039() {
  self endon("ballerina_destroyed");
  if(level.players.size > 1) {
    wait(90 - (15 * level.players.size));
  } else {
    wait(90);
  }
  self notify("ballerina_timeout");
}

function function_5b2770da() {
  playsoundatposition("zmb_sam_egg_success", (0, 0, 0));
  s_ballerina_end = struct::get("s_ballerina_end", "targetname");
  s_ballerina_end.var_ac086ffb = util::spawn_model(s_ballerina_end.model, s_ballerina_end.origin, s_ballerina_end.angles);
  s_ballerina_end.var_ac086ffb clientfield::set("snd_zhdegg", 1);
  s_ballerina_end.var_ac086ffb playLoopSound("mus_musicbox_lp", 2);
  s_ballerina_end thread function_9d55fd08();
  s_ballerina_end zm_unitrigger::create_unitrigger(undefined, 65);
  s_ballerina_end waittill("trigger_activated");
  zm_unitrigger::unregister_unitrigger(s_ballerina_end.s_unitrigger);
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
  s_ballerina_end.var_3609adde clientfield::increment("snd_zhdegg_arm");
  s_ballerina_end.var_3609adde waittill("movedone");
  wait(1);
  s_ballerina_end.var_ac086ffb playLoopSound("zmb_challenge_skel_arm_lp", 0.25);
  s_ballerina_end.var_ac086ffb movez(-40, 1.5);
  s_ballerina_end.var_3609adde movez(-40, 1.5);
  s_ballerina_end.var_2a9b65c7 movez(-40, 1.5);
  s_ballerina_end.var_79dc7980 movez(-40, 1.5);
  s_ballerina_end.var_ac086ffb waittill("movedone");
  zm_powerups::specific_powerup_drop("full_ammo", s_ballerina_end.origin);
  s_ballerina_end.var_ac086ffb delete();
  s_ballerina_end.var_3609adde delete();
  s_ballerina_end.var_2a9b65c7 delete();
  s_ballerina_end.var_79dc7980 delete();
  level flag::set("snd_zhdegg_completed");
}

function function_e753d4f() {
  level.var_2a0600f = 0;
  var_8bd44282 = struct::get_array("songstructs", "targetname");
  array::thread_all(var_8bd44282, & function_929c4dba);
  while(true) {
    level waittill("hash_9b53c751");
    if(level.var_2a0600f == var_8bd44282.size) {
      break;
    }
  }
  level flag::set("snd_song_completed");
}

function function_929c4dba() {
  e_origin = spawn("script_origin", self.origin);
  e_origin zm_unitrigger::create_unitrigger();
  e_origin playLoopSound("zmb_ee_mus_lp", 1);
  e_origin thread zm_utility::print3d_ent("", (1, 1, 0), 3, vectorscale((0, 0, 1), 24));
  while(!(isDefined(e_origin.b_activated) && e_origin.b_activated)) {
    e_origin waittill("trigger_activated", who);
    if(!function_8090042c()) {
      continue;
    }
    who notify("hash_9b53c751");
    e_origin function_bd90259b(who);
  }
  e_origin notify("end_print3d");
  zm_unitrigger::unregister_unitrigger(e_origin.s_unitrigger);
  e_origin delete();
}

function function_8090042c() {
  if(isDefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || (isDefined(level.musicsystemoverride) && level.musicsystemoverride)) {
    return false;
  }
  return true;
}

function function_bd90259b(e_player) {
  if(!(isDefined(self.b_activated) && self.b_activated)) {
    self.b_activated = 1;
    level.var_2a0600f++;
    level notify("hash_9b53c751", e_player);
    self stoploopsound(0.2);
  }
  self playSound("zmb_ee_mus_activate");
}

function snd_monty_radio() {
  level waittill("connected", player);
  s_radio = struct::get("snd_monty_radio", "targetname");
  if(!isDefined(s_radio)) {
    return;
  }
  s_radio zm_unitrigger::create_unitrigger();
  s_radio waittill("trigger_activated");
  playsoundatposition("vox_abcd_radio", s_radio.origin);
  zm_unitrigger::unregister_unitrigger(s_radio.s_unitrigger);
}

function setup_personality_character_exerts() {
  level.exert_sounds[1]["hitmed"][0] = "vox_plr_0_exert_pain_0";
  level.exert_sounds[1]["hitmed"][1] = "vox_plr_0_exert_pain_1";
  level.exert_sounds[1]["hitmed"][2] = "vox_plr_0_exert_pain_2";
  level.exert_sounds[1]["hitmed"][3] = "vox_plr_0_exert_pain_3";
  level.exert_sounds[1]["hitmed"][4] = "vox_plr_0_exert_pain_4";
  level.exert_sounds[2]["hitmed"][0] = "vox_plr_1_exert_pain_0";
  level.exert_sounds[2]["hitmed"][1] = "vox_plr_1_exert_pain_1";
  level.exert_sounds[2]["hitmed"][2] = "vox_plr_1_exert_pain_2";
  level.exert_sounds[2]["hitmed"][3] = "vox_plr_1_exert_pain_3";
  level.exert_sounds[2]["hitmed"][4] = "vox_plr_1_exert_pain_4";
  level.exert_sounds[3]["hitmed"][0] = "vox_plr_2_exert_pain_0";
  level.exert_sounds[3]["hitmed"][1] = "vox_plr_2_exert_pain_1";
  level.exert_sounds[3]["hitmed"][2] = "vox_plr_2_exert_pain_2";
  level.exert_sounds[3]["hitmed"][3] = "vox_plr_2_exert_pain_3";
  level.exert_sounds[3]["hitmed"][4] = "vox_plr_2_exert_pain_4";
  level.exert_sounds[4]["hitmed"][0] = "vox_plr_3_exert_pain_0";
  level.exert_sounds[4]["hitmed"][1] = "vox_plr_3_exert_pain_1";
  level.exert_sounds[4]["hitmed"][2] = "vox_plr_3_exert_pain_2";
  level.exert_sounds[4]["hitmed"][3] = "vox_plr_3_exert_pain_3";
  level.exert_sounds[4]["hitmed"][3] = "vox_plr_3_exert_pain_4";
  level.exert_sounds[1]["hitlrg"][0] = "vox_plr_0_exert_pain_0";
  level.exert_sounds[1]["hitlrg"][1] = "vox_plr_0_exert_pain_1";
  level.exert_sounds[1]["hitlrg"][2] = "vox_plr_0_exert_pain_2";
  level.exert_sounds[1]["hitlrg"][3] = "vox_plr_0_exert_pain_3";
  level.exert_sounds[1]["hitlrg"][4] = "vox_plr_0_exert_pain_4";
  level.exert_sounds[2]["hitlrg"][0] = "vox_plr_1_exert_pain_0";
  level.exert_sounds[2]["hitlrg"][1] = "vox_plr_1_exert_pain_1";
  level.exert_sounds[2]["hitlrg"][2] = "vox_plr_1_exert_pain_2";
  level.exert_sounds[2]["hitlrg"][3] = "vox_plr_1_exert_pain_3";
  level.exert_sounds[2]["hitlrg"][4] = "vox_plr_1_exert_pain_4";
  level.exert_sounds[3]["hitlrg"][0] = "vox_plr_2_exert_pain_0";
  level.exert_sounds[3]["hitlrg"][1] = "vox_plr_2_exert_pain_1";
  level.exert_sounds[3]["hitlrg"][2] = "vox_plr_2_exert_pain_2";
  level.exert_sounds[3]["hitlrg"][3] = "vox_plr_2_exert_pain_3";
  level.exert_sounds[3]["hitlrg"][4] = "vox_plr_2_exert_pain_4";
  level.exert_sounds[4]["hitlrg"][0] = "vox_plr_3_exert_pain_0";
  level.exert_sounds[4]["hitlrg"][1] = "vox_plr_3_exert_pain_1";
  level.exert_sounds[4]["hitlrg"][2] = "vox_plr_3_exert_pain_2";
  level.exert_sounds[4]["hitlrg"][3] = "vox_plr_3_exert_pain_3";
  level.exert_sounds[4]["hitlrg"][4] = "vox_plr_3_exert_pain_4";
}

function set_exert_id() {
  self endon("disconnect");
  util::wait_network_frame();
  util::wait_network_frame();
  self zm_audio::setexertvoice(self.characterindex + 1);
}