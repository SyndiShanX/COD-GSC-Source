/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_coast_eggs.gsc
**************************************/

#include animscripts\zombie_utility;
#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#include maps\_ambientpackage;
#include maps\_music;
#include maps\_busing;
#include maps\_zombiemode_audio;

init() {
  level c_flags();
  level c_anims();
  level mic_test();
  level thread c_overseer();
}
c_flags() {
  flag_init("ffs");
  flag_init("ffd");
  flag_init("hgs");
  flag_init("hg0");
  flag_init("hg1");
  flag_init("hg2");
  flag_init("hg3");
  flag_init("hgd");
  flag_init("bs");
  flag_init("bd");
  flag_init("ke");
  flag_init("aca");
  flag_init("shs");
  flag_init("sr");
  flag_init("bp");
  flag_init("mcs");
  flag_init("hn");
  flag_init("mm");
  flag_init("ss");
  flag_init("re");
  flag_init("sa");
  flag_init("s_s");
  flag_init("sdm");
  flag_init("dmf");
}
#using_animtree("generic_human");

c_anims() {
  level.scr_anim["dancer"]["breakdown"] = % ai_zombie_flinger_flail;
  level.scr_anim["dancer"]["spin"] = % ai_zombie_dying_back_idle;
}
beat_break(str_anim) {
  self endon("death");
  self endon("switch");
  self.ignoreall = true;
  self.ignoreme = true;
  while(isDefined(self) && IsAlive(self)) {
    dance_anim = str_anim;
    self SetFlaggedAnimKnobAllRestart("dance_anim", dance_anim, %body, 1, .1, 1);
    animscripts\traverse\zombie_shared::wait_anim_length(dance_anim, .02);
  }
}
mic_test() {
  PreCacheModel("p_zom_vril_device");
  PreCacheModel("p_zom_vodka_bottle");
  PreCacheModel("p_zom_fuse");
  PreCacheModel("p_zom_ice_chunk_03");
  PreCacheModel("p_zom_minisub");
  PreCacheShader("zom_hud_icon_fuse");
  PreCacheShader("zom_hud_icon_bottle");
  PreCacheShader("zom_hud_icon_vril");
}
summon_the_shamans() {
  level.beginning = getstruct("cheaters_never_prosper", "targetname");
  rough_note = StrTok(level.beginning.script_parameters, " ");
  balance = StrTok(level.beginning.script_noteworthy, " ");
  level.trials = StrTok(level.beginning.script_waittill, " ");
  level.contact = StrTok(level.beginning.script_string, " ");
  level.mermaid = [];
  level.together_again = [];
  for(i = 0; i < rough_note.size; i++) {
    temp = Int(rough_note[i]);
    level.mermaid = add_to_array(level.mermaid, temp, false);
  }
  for(i = 0; i < balance.size; i++) {
    temp = Int(balance[i]);
    level.together_again = add_to_array(level.together_again, temp, false);
  }
  that_one = GetEnt("trig_mine", "targetname");
  that_one SetCursorHint("HINT_NOICON");
  that_one SetHintString("");
}
c_overseer() {
  wait(0.2);
  flag_wait("all_players_connected");
  players = GetPlayers();
  if(players.size > 1) {
    level._e_group = true;
  } else {
    level._e_group = false;
  }
  level summon_the_shamans();
  level thread knock_on_door();
  level thread engage();
  level thread noisemakers();
  level thread rotary_styles();
  players = GetPlayers();
  level thread cancer();
  level thread aries();
  level thread pisces();
  level thread leo();
  level thread capricorn();
  if(level._e_group) {
    level thread virgo();
    level thread denlo();
    level thread libra();
  }
}
knock_on_door() {
  level endon("scrambled");
  knock_trig = GetEnt("e_gargoyle", "targetname");
  if(!isDefined(knock_trig)) {
    return;
  }
  flag_wait("power_on");
  pneumatic_tube = GetEnt("trig_deliver", "targetname");
  pneumatic_tube playLoopSound("zmb_whooooosh_loop", 2);
  level.egg_sound_ent = GetEnt("ent_loop_door_sounds", "targetname");
  knock_trig playSound("zmb_haxorz_suxorz");
  level gargoyle_speaks(knock_trig);
  while(1) {
    knock_trig waittill("damage", i_amt, e_inflictor, vec_direction, vec_point, mod_type);
    if(level.door_knock_vox_occurring) {
      wait(1.0);
      continue;
    }
    if(is_player_valid(e_inflictor) && mod_type == level.trials[2]) {
      if(!flag("ffs")) {
        level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, 1, 0, undefined);
        flag_set("ffs");
        wait(1.0);
        continue;
      }
      if(flag("ffs") && !flag("ffd") && !isDefined(e_inflictor._fuse_acquired)) {
        level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 1);
        wait(1.0);
        continue;
      } else if(flag("ffs") && !flag("ffd") && isDefined(e_inflictor._fuse_acquired) && e_inflictor._fuse_acquired == 1) {
        level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 1);
        wait(1.0);
        continue;
      }
      if(flag("ffd") && flag("hgs") && !flag("hgd")) {
        level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 2);
        wait(1.0);
        continue;
      }
      if(level._e_group) {
        if(flag("ffd") && flag("hgd") && !flag("bs")) {
          flag_set("bs");
          level.egg_sound_ent StopLoopSound(1.5);
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, 4, 3, 5, undefined);
          level.egg_sound_ent playLoopSound("zmb_fantastical_worlds_loop", 1.5);
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("bs") && !flag("bd") && !is_true(e_inflictor._bottle_acquired)) {
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 3);
          wait(1.0);
          continue;
        } else if(flag("ffd") && flag("hgd") && flag("bs") && !flag("bd") && is_true(e_inflictor._bottle_acquired)) {
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 4);
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("bd") && !flag("ke")) {
          flag_set("ke");
          level.egg_sound_ent StopLoopSound(1.5);
          level thread delayed_song_loop();
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, 8, 4, 9, undefined);
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("bd") && !flag("aca")) {
          level.egg_sound_ent StopLoopSound(1);
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 5);
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("bd") && flag("aca") && !flag("mcs")) {
          level.egg_sound_ent StopLoopSound(1.5);
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 6);
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("bd") && flag("aca") &&
          flag("mcs") && !flag("mm")) {
          level.egg_sound_ent StopLoopSound(1.5);
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 7);
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("bd") && flag("aca") &&
          flag("mcs") && flag("mm") && !flag("s_s")) {
          level.egg_sound_ent StopLoopSound(1.5);
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 8);
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("bd") && flag("aca") &&
          flag("mcs") && flag("mm") && flag("s_s") && !flag("sdm")) {
          level.egg_sound_ent StopLoopSound(1.5);
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, 13, 5, 14, undefined);
          level.egg_sound_ent playLoopSound("zmb_fantastical_worlds_loop", 1.5);
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("bd") && flag("aca") &&
          flag("mcs") && flag("mm") && flag("s_s") && flag("sdm") &&
          !flag("dmf")) {
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 9);
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("bd") && flag("aca") &&
          flag("mcs") && flag("mm") && flag("s_s") && flag("dmf")) {
          level.egg_sound_ent StopLoopSound(1.5);
          wait(1.0);
          continue;
          return;
        }
      } else {
        if(flag("ffd") && flag("hgd") && !flag("aca")) {
          level.egg_sound_ent StopLoopSound(1.5);
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, 4, "3b", 9, undefined);
          flag_set("aca");
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("aca") && !flag("mcs")) {
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 3);
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("mcs") && !flag("ss")) {
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 8);
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("mcs") && flag("s_s") &&
          flag("sdm") && !flag("dmf")) {
          level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, undefined, undefined, undefined, 9);
          wait(1.0);
          continue;
        }
        if(flag("ffd") && flag("hgd") && flag("mcs") && flag("s_s") &&
          flag("dmf")) {
          wait(1.0);
          continue;
          return;
        }
      }
    }
  }
}
force_wait_for_forcefield_looper() {
  wait(21.5);
  flag_set("hgs");
  level.egg_sound_ent playLoopSound("zmb_wizzybizzy_home_loop", 1.5);
}
delayed_song_loop() {
  wait(27);
  level.egg_sound_ent playLoopSound("vox_egg_skit_song", 1);
}
gargoyle_speaks(knock_trig) {
  trig = GetEnt("trig_start_voices", "targetname");
  listener = undefined;
  if(!isDefined(trig)) {
    return;
  }
  trig.spoken_word = 0;
  speak_limit = 3;
  level._end_door_intro = false;
  chr = 0;
  level thread gargoyle_watch_early_door_hit();
  while(!level._end_door_intro) {
    trig waittill("trigger", listener);
    if(is_player_valid(listener)) {
      if(chr >= 3) {
        chr = 0;
      }
      knock_trig playSound("vox_chr_" + chr + "_egg_response_0", "sounddone_introvox");
      knock_trig waittill("sounddone_introvox");
      wait(1.0);
      trig.spoken_word++;
      chr++;
      if(trig.spoken_word >= speak_limit) {
        level notify("stop_watching_early_knock");
        while(1) {
          knock_trig waittill("trigger", knocker);
          if(is_player_valid(knocker)) {
            level._end_door_intro = true;
            break;
          }
          wait(.05);
        }
      }
    }
  }
  level notify("stop_watching_early_knock");
  level maps\zombie_coast_amb::play_characters_skits_etc(listener, knock_trig, undefined, 1, 0, undefined);
  flag_set("ffs");
}
gargoyle_watch_early_door_hit() {
  level endon("stop_watching_early_knock");
  knock_trig = GetEnt("e_gargoyle", "targetname");
  hit = false;
  while(!hit) {
    knock_trig waittill("trigger", impatient_player);
    if(is_player_valid(impatient_player)) {
      level._end_door_intro = true;
    }
  }
}
engage() {
  ship_wheel = GetEnt("sm_ship_wheel", "targetname");
  wheel_turn_right = GetEnt("t_rotate_wheel_right", "targetname");
  wheel_turn_left = GetEnt("t_rotate_wheel_left", "targetname");
  ship_wheel.spot = 0;
  wheel_turn_right thread press_the_button(1);
  wheel_turn_left thread press_the_button(0);
  right_lever_trigger = GetEnt("trig_eot_right_switch", "targetname");
  left_lever_trigger = GetEnt("trig_eot_left_switch", "targetname");
  right_lever = GetEnt(right_lever_trigger.target, "targetname");
  right_lever.spot = 0;
  left_lever = GetEnt(left_lever_trigger.target, "targetname");
  left_lever.spot = 0;
  right_lever_trigger thread egg_drop_soup();
  left_lever_trigger thread egg_drop_soup();
  level thread eyes_on_the_wall(ship_wheel, right_lever, left_lever);
}
press_the_button(i_direction) {
  level endon("shs");
  self UseTriggerRequireLookAt();
  self SetHintString("");
  wheel = GetEnt(self.target, "targetname");
  flag_wait("power_on");
  while(!flag("shs")) {
    self waittill("trigger");
    if(i_direction == 0) {
      wheel RotateRoll(60, 0.2, 0, 0);
      wheel playSound("zmb_galactic_rose");
      wheel waittill("rotatedone");
      wheel.spot = wheel.spot - 1;
      if(wheel.spot < 0) {
        wheel.spot = 5;
      }
    } else {
      wheel RotateRoll(-60, 0.2, 0, 0);
      wheel playSound("zmb_galactic_rose");
      wheel waittill("rotatedone");
      wheel.spot = wheel.spot + 1;
      if(wheel.spot > 5) {
        wheel.spot = 0;
      }
    }
  }
}
egg_drop_soup() {
  level endon("shs");
  self UseTriggerRequireLookAt();
  self SetHintString("");
  lever = GetEnt(self.target, "targetname");
  flag_wait("power_on");
  while(!flag("shs")) {
    self waittill("trigger");
    if(lever.spot == 4) {
      lever RotateRoll(-100, 0.2);
      lever.spot = 0;
      lever playSound("zmb_transatlantic_rose");
      lever waittill("rotatedone");
    } else {
      lever RotateRoll(25, 0.2);
      lever.spot = lever.spot + 1;
      lever playSound("zmb_transatlantic_rose");
      lever waittill("rotatedone");
    }
  }
}
cancer() {
  level thread coast_egg_fuse_controller();
  level thread coast_egg_fuse_box_think();
}
coast_egg_fuse_box_think() {
  fuse_box_trigger = GetEnt("trig_fuse_replace", "targetname");
  fuse_box = GetEnt("ent_fuse_box", "targetname");
  if(!isDefined(fuse_box_trigger)) {
    return;
  }
  fuse_box_trigger SetCursorHint("HINT_NOICON");
  fuse_box_trigger SetHintString("");
  fuse_box_trigger UseTriggerRequireLookAt();
  flag_wait("ffs");
  while(!flag("ffd")) {
    fuse_box_trigger waittill("trigger", who);
    if(isDefined(who._fuse_acquired) && who._fuse_acquired == 1) {
      who._fuse_acquired = undefined;
      if(isDefined(fuse_box)) {
        spawn_spot = fuse_box GetTagOrigin("tag_fuse");
        if(isDefined(spawn_spot)) {
          fuse_attached = spawn("script_model", spawn_spot);
          fuse_attached.angles = fuse_box GetTagAngles("tag_fuse");
          fuse_attached setModel("p_zom_fuse");
          fuse_attached playSound("zmb_winepull");
          level.egg_sound_ent playSound("zmb_craziness_supreme");
          exploder(780);
        }
      }
      who thread coast_remove_eggs_hud();
      fuse_placed = true;
      flag_set("ffd");
      level thread coast_egg_fuse_starts_holy(who);
    } else {
      wait(0.1);
    }
  }
}
coast_egg_fuse_controller() {
  fuse_array = getStructArray("struct_ep", "targetname");
  fuse_delivered = undefined;
  fuse_array = array_randomize(fuse_array);
  flag_wait("ffs");
  while(!flag("ffd")) {
    for(i = 0; i < fuse_array.size; i++) {
      fuse_array[i].object = spawn("script_model", fuse_array[i].origin);
      fuse_array[i].object.angles = fuse_array[i].angles;
      fuse_array[i].object setModel(fuse_array[i].script_parameters);
      fuse_array[i].object.starter = GetEnt(fuse_array[i].target, "targetname");
      fuse_array[i].object.starter UseTriggerRequireLookAt();
      fuse_array[i].object.starter SetCursorHint("HINT_NOICON");
      fuse_array[i].object.starter EnableLinkTo();
      fuse_array[i].object.starter LinkTo(fuse_array[i].object);
      fuse_array[i].object coast_egg_fuse_think();
      fuse_delivered = coast_egg_fuse_lost("fuse_lost", "ffd");
      if(isDefined(fuse_delivered) && is_true(fuse_delivered)) {
        return;
      }
    }
    wait(1.0);
  }
  for(i = 0; i < fuse_array.size; i++) {
    if(!isDefined(fuse_array[i].object.starter)) {
      fuse_array[i].object.starter = GetEnt(fuse_array[i].target, "targetname");
    }
    fuse_array[i].starter Delete();
    if(isDefined(fuse_array[i].object)) {
      fuse_array[i].object Delete();
    }
  }
  array_delete(fuse_array);
}
coast_egg_fuse_lost(str_endon, str_waittill) {
  level endon(str_endon);
  level waittill(str_waittill);
  return true;
}
coast_egg_fuse_think() {
  fuse_found = false;
  while(!fuse_found) {
    self.starter waittill("trigger", who);
    if(isDefined(who) && is_player_valid(who)) {
      who._fuse_acquired = 1;
      who playSound("zmb_grabit_wontyou");
      who maps\_zombiemode_audio::create_and_play_dialog("eggs", "coast_response", undefined, 1);
      who thread coast_eggs_hud("zom_hud_icon_fuse", "ffd");
      who thread coast_egg_clear_fuse_on_death();
      fuse_found = true;
    }
  }
  self trigger_off();
  self Hide();
}
coast_egg_clear_fuse_on_death() {
  self endon("disconnect");
  level endon("ffd");
  level thread coast_egg_clear_fuse_on_disconnect(self);
  self waittill_any("death", "_zombie_game_over", "spawned_spectator");
  if(isDefined(self)) {
    self._fuse_acquired = undefined;
  }
  level notify("fuse_lost");
}
coast_egg_clear_fuse_on_disconnect(ent_ply) {
  level endon("ffd");
  level endon("fuse_lost");
  ent_ply endon("death");
  ent_ply waittill("disconnect");
  level notify("fuse_lost");
}
coast_egg_fuse_starts_holy(ent_player) {
  knock_trig = GetEnt("e_gargoyle", "targetname");
  players = GetPlayers();
  level thread force_wait_for_forcefield_looper();
  level maps\zombie_coast_amb::play_characters_skits_etc(ent_player, knock_trig, 2, 2, 3, undefined);
}
aries() {
  flag_wait("hgs");
  enta_made_the_shot_trigger = getEntArray("trig_holy_g_damage", "targetname");
  metal_door = GetEnt("ent_metal_door", "targetname");
  if(!isDefined(enta_made_the_shot_trigger)) {
    return;
  }
  exploder(770);
  for(i = 0; i < enta_made_the_shot_trigger.size; i++) {
    if(level flag_exists("hg" + i)) {
      enta_made_the_shot_trigger[i] thread coast_egg_power_source_react("hg" + i);
    } else {
      PrintLn("***************************** more triggers than flags set up!*********************************************");
    }
  }
  level thread coast_egg_holy_grenade_watcher();
  flag_wait("hgd");
  stop_exploder(770);
}
coast_egg_power_source_react(str_flag) {
  rtg = getstruct(self.target, "targetname");
  field = undefined;
  if(isDefined(rtg)) {
    field = spawn("script_model", rtg.origin);
    field.angles = rtg.angles;
    field setModel("tag_origin");
    field playLoopSound("zmb_wizzybizzy_loop", 1);
    playFXOnTag(level._effect["rtg_field"], field, "tag_origin");
  }
  self._source_damaged = false;
  while(!self._source_damaged) {
    self waittill("damage", i_amount, e_attacker, v_direction, vec_position, i_dmg_type, str_model_name, str_tagname);
    if(is_player_valid(e_attacker) && (i_dmg_type == level.trials[0] || i_dmg_type == level.trials[1])) {
      flag_set(str_flag);
      self._source_damaged = true;
      field StopLoopSound(.1);
      field playSound("zmb_wizzybizzy_explo");
    }
  }
  if(isDefined(field)) {
    field Delete();
  }
  self trigger_off();
  self Delete();
}
coast_egg_holy_grenade_watcher() {
  flag_wait_all("hg0", "hg1", "hg2", "hg3");
  flag_set("hgd");
}
virgo() {
  enta_egg_ice_break_trigger = getEntArray("trig_egg_break_ice", "targetname");
  ice_blocks = getEntArray("ent_bartender", "targetname");
  holsters = getStructArray("struct_that_thing", "targetname");
  if(!isDefined(enta_egg_ice_break_trigger)) {
    return;
  }
  if(!isDefined(ice_blocks)) {
    return;
  }
  if(!isDefined(holsters)) {
    return;
  }
  holsters = array_randomize(holsters);
  flag_wait("bs");
  level thread coast_egg_bottle_delivered();
  level thread coast_egg_bartender(holsters);
}
coast_egg_bartender(structs) {
  level endon("bd");
  while(!flag("bd")) {
    for(i = 0; i < structs.size; i++) {
      wait(0.1);
      another = structs[i] coast_egg_bottle_think();
      if(isDefined(another) && another) {
        level waittill_either("butterfingers", "bd");
      }
    }
    wait(0.1);
    structs = array_randomize(structs);
  }
}
coast_egg_bottle_think() {
  level endon("bd");
  second_spot = getstruct(self.target, "targetname");
  dropper = undefined;
  e_ice_block = spawn("script_model", self.origin);
  e_ice_block.angles = self.angles;
  e_ice_block setModel("p_zom_ice_chunk_03");
  e_bottle = spawn("script_model", second_spot.origin);
  e_bottle.angles = second_spot.angles;
  e_bottle setModel("p_zom_vodka_bottle");
  e_icebreaker = spawn("trigger_damage", self.origin, 0, 11, 13);
  e_catch_trig = spawn("trigger_radius", e_bottle.origin, 0, 10, 10);
  e_inflictor = undefined;
  Assert(isDefined(e_icebreaker));
  Assert(isDefined(e_bottle));
  Assert(isDefined(e_catch_trig));
  e_catch_trig EnableLinkTo();
  e_catch_trig LinkTo(e_bottle);
  e_icebreaker EnableLinkTo();
  e_icebreaker LinkTo(e_ice_block);
  bottle_end = e_bottle.origin + (0, 0, -500);
  ice_solid = true;
  while(ice_solid) {
    e_icebreaker waittill("damage", i_amt, e_inflictor, vec_direction, vec_point, mod_type);
    if(is_player_valid(e_inflictor) && mod_type == level.trials[2]) {
      ice_solid = false;
    }
  }
  e_ice_block Delete();
  e_icebreaker Delete();
  end_point = PhysicsTrace(e_bottle.origin, bottle_end);
  e_bottle NotSolid();
  e_bottle MoveTo(end_point, 1.4, 0.2, 0);
  player_caught = e_bottle coast_egg_bottle_caught(e_catch_trig);
  level notify("stop_egg_debug");
  if(isDefined(player_caught) && is_player_valid(player_caught)) {
    player_caught playSound("zmb_worf_speed");
    player_caught maps\_zombiemode_audio::create_and_play_dialog("eggs", "coast_response", undefined, 7);
    player_caught._bottle_acquired = 1;
    player_caught thread coast_egg_clear_bottle_on_death();
    player_caught thread coast_eggs_hud("zom_hud_icon_bottle", "bd");
    e_catch_trig Unlink();
    e_catch_trig Delete();
    e_bottle Hide();
    e_bottle Delete();
    return true;
  } else {
    if(isDefined(e_inflictor)) {
      e_inflictor maps\_zombiemode_audio::create_and_play_dialog("eggs", "coast_response", undefined, 6);
    }
    e_bottle playSound("zmb_worf_speed_fail");
    e_catch_trig Unlink();
    e_catch_trig Delete();
    e_bottle Hide();
    e_bottle Delete();
    return false;
  }
}
coast_egg_bottle_caught(e_trigger) {
  self endon("movedone");
  while(isDefined(e_trigger)) {
    e_trigger waittill("trigger", who);
    if(is_player_valid(who)) {
      return who;
    }
  }
}
coast_egg_clear_bottle_on_death() {
  self endon("disconnect");
  level endon("bd");
  level thread coast_egg_clear_bottle_on_disconnect(self);
  self waittill_any("death", "_zombie_game_over", "spawned_spectator");
  if(isDefined(self)) {
    self._bottle_acquired = undefined;
  }
  level notify("butterfingers");
}
coast_egg_clear_bottle_on_disconnect(ent_ply) {
  level endon("bd");
  level endon("butterfingers");
  ent_ply endon("death");
  ent_ply waittill("disconnect");
  level notify("butterfingers");
}
coast_egg_bottle_delivered() {
  e_delivery_trigger = GetEnt("trig_deliver", "targetname");
  delivery_tube = GetEnt(e_delivery_trigger.target, "targetname");
  if(!isDefined(e_delivery_trigger)) {
    return;
  }
  e_delivery_trigger SetHintString("");
  while(isDefined(e_delivery_trigger)) {
    e_delivery_trigger waittill("trigger", who);
    if(isDefined(who._bottle_acquired) && who._bottle_acquired == 1) {
      who thread coast_remove_eggs_hud();
      who._bottle_acquired = 0;
      if(isDefined(delivery_tube)) {
        spawn_point = delivery_tube GetTagOrigin("tag_tube");
        device = spawn("script_model", spawn_point);
        device.angles = delivery_tube GetTagAngles("tag_tube");
        device setModel("p_zom_vodka_bottle");
        device playSound("zmb_whooooosh");
        device MoveZ(40, 1.0);
        device waittill("movedone");
        device Delete();
      }
      break;
    }
  }
  flag_set("bd");
}
coast_egg_bottle_cleanup() {
  e_bottle = GetEnt(self.target, "targetname");
  if(isDefined(e_bottle)) {
    e_bottle Delete();
  }
  self Delete();
}
denlo() {
  radios = getEntArray("hello_world", "targetname");
  for(i = 0; i < radios.size; i++) {
    radios[i] SetCursorHint("HINT_NOICON");
    radios[i] SetHintString("");
    radios[i] UseTriggerRequireLookAt();
    radios[i] thread coast_egg_art_critic_message();
  }
}
coast_egg_art_critic_message() {
  level endon("aca");
  if(!isDefined(self.script_special)) {
    return;
  }
  if(!isDefined(self.script_string)) {
    return;
  }
  flag_wait("power_on");
  while(!flag("aca")) {
    self waittill("trigger", dj);
    if(is_player_valid(dj)) {
      if(!flag("ke")) {
        self playSound("zmb_radio_morse_static");
        wait(0.1);
      }
      if(flag("ke")) {
        self playSound(self.script_string);
        if(!isDefined(level._reach)) {
          level._reach = [];
        }
        heard = level call_out(self.script_parameters);
        if(isDefined(heard) && heard) {
          flag_set("aca");
        }
      }
    }
  }
}
call_out(str_message) {
  level endon("aca");
  level._reach = add_to_array(level._reach, str_message);
  if(level._reach.size == level.contact.size) {
    for(i = 0; i < level.contact.size; i++) {
      if(level._reach[i] != level.contact[i]) {
        level._reach = undefined;
        return false;
      }
    }
    return true;
  }
}
pisces() {
  flag_wait("aca");
  level._serenade = [];
  ClientNotify("lmc");
  level thread metal_horse();
  flag_wait("bp");
  flag_set("mcs");
}
eyes_on_the_wall(spinner, starboard, port) {
  Assert(isDefined(spinner.spot));
  Assert(isDefined(starboard.spot));
  Assert(isDefined(port.spot));
  flag_wait("aca");
  while(1) {
    if(spinner.spot == level.mermaid[0] && starboard.spot == level.mermaid[2] && port.spot == level.mermaid[1]) {
      playsoundatposition("zmb_ship_horn_poweron", (-694, -990, 1025));
      flag_set("shs");
      ClientNotify("slc");
      return;
    }
    wait(0.1);
  }
}
metal_horse() {
  horse_struct = getstruct("struct_thunder", "targetname");
  flag_wait("shs");
  wait(2.0);
  horse = spawn("script_model", horse_struct.origin);
  horse.angles = horse_struct.angles;
  horse setModel("p_zom_minisub");
  horse NotSolid();
  horse playSound("zmb_forward_march");
  horse MoveZ(325, 5.0);
  horse waittill("movedone");
  flag_set("sr");
  if(level._e_group) {
    while(!flag("bp")) {
      for(i = 0; i < level.mermaid.size; i++) {
        sound = "zmb_sub_tone_" + level.mermaid[i];
        horse playSound(sound);
        wait(2.0);
      }
      song = coast_egg_fuse_lost("can_not_sing", "bp");
      if(is_true(song)) {
        break;
      } else {
        horse MoveZ(-325, 5.0);
        horse waittill("movedone");
        flag_clear("sr");
        level waittill("between_round_over");
        wait(5.0);
        horse playSound("zmb_forward_march");
        horse MoveZ(325, 10.0);
        horse waittill("movedone");
        flag_set("sr");
      }
    }
  } else {
    for(i = 0; i < level.mermaid.size; i++) {
      sound = "zmb_sub_tone_" + level.mermaid[i];
      horse playSound(sound);
      wait(2.0);
    }
    flag_set("bp");
    flag_set("ss");
  }
  exploder(750);
  if(!level._e_group) {
    exploder(755);
  }
  flag_wait("re");
  stop_exploder(750);
  horse MoveZ(-325, 2.0);
  horse waittill("movedone");
  horse Delete();
}
noisemakers() {
  enta_sound_beacon_triggers = getEntArray("trig_use_sound_beacon", "targetname");
  array_thread(enta_sound_beacon_triggers, ::coast_egg_musical_chairs_beach_beacon_used);
}
coast_egg_musical_chairs_beach_beacon_used() {
  self UseTriggerRequireLookAt();
  self SetHintString("");
  while(1) {
    self waittill("trigger", who);
    if(is_player_valid(who)) {
      if(flag("power_on")) {
        sound = "zmb_sub_tone_" + self.script_int;
        self playSound(sound);
      }
      if(flag("sr")) {
        if(!isDefined(level._serenade)) {
          level._serenade = [];
        }
        level._serenade[level._serenade.size] = self.script_int;
        if(level._serenade.size == level.mermaid.size) {
          if(coast_egg_musical_check()) {
            flag_set("bp");
          } else {
            level notify("can_not_sing");
            level._serenade = undefined;
            level._serenade = [];
          }
        }
      }
    }
  }
}
coast_egg_musical_check() {
  Assert(isDefined(level._serenade));
  Assert(isDefined(level.mermaid));
  for(i = 0; i < level.mermaid.size; i++) {
    if(level._serenade[i] != level.mermaid[i]) {
      return false;
    }
  }
  return true;
}
libra() {
  flag_wait("mcs");
  flag_set("hn");
  flag_wait("mm");
  flag_set("ss");
}
rotary_styles() {
  enta_harmony_triggers = getEntArray("trig_pure_harmony", "targetname");
  if(!isDefined(enta_harmony_triggers)) {
    return;
  }
  level._dials = [];
  level._dials[0] = -1;
  level._dials[1] = -1;
  level._dials[2] = -1;
  level._dials[3] = -1;
  for(i = 0; i < enta_harmony_triggers.size; i++) {
    rand = RandomInt(9);
    enta_harmony_triggers[i] coast_egg_dial_setup(rand);
  }
  for(i = 0; i < enta_harmony_triggers.size; i++) {
    enta_harmony_triggers[i] thread coast_egg_dial_think();
  }
}
coast_egg_dial_setup(int_start_spot) {
  dial = GetEnt(self.target, "targetname");
  dial.pos = 0;
  dial ent_flag_init("rotating");
  level._dials[self.script_special] = dial;
  if(isDefined(int_start_spot)) {
    for(i = 0; i < int_start_spot; i++) {
      if(dial.pos == int_start_spot) {
        return;
      }
      level coast_egg_dial_rotate(dial);
    }
  }
}
coast_egg_dial_think() {
  dial = GetEnt(self.target, "targetname");
  partners = self.script_vector;
  self SetHintString("");
  self SetCursorHint("HINT_NOICON");
  flag_wait("power_on");
  sound = "zmb_harmonizer_tone_" + dial.pos;
  dial playLoopSound(sound);
  while(1) {
    self waittill("trigger", who);
    if(is_player_valid(who)) {
      level coast_egg_dial_rotate(dial);
      if(GetDvarInt(#"scr_coast_egg_debug")) {} else {
        other_dials = getEntArray(self.targetname, "targetname");
        for(i = 0; i < other_dials.size; i++) {
          if(other_dials[i].script_special == partners[0]) {
            partner_dial = GetEnt(other_dials[i].target, "targetname");
            if(isDefined(partner_dial)) {
              level coast_egg_dial_rotate(partner_dial);
            } else {}
          } else if(other_dials[i].script_special == partners[1]) {
            partner_dial = GetEnt(other_dials[i].target, "targetname");
            if(isDefined(partner_dial)) {
              level coast_egg_dial_rotate(partner_dial);
            } else {}
          } else if(other_dials[i].script_special == partners[2]) {
            partner_dial = GetEnt(other_dials[i].target, "targetname");
            if(isDefined(partner_dial)) {
              level coast_egg_dial_rotate(partner_dial);
            } else {}
          }
        }
      }
      if(flag("hn")) {
        if(coast_egg_dials_in_harmony()) {
          flag_set("mm");
          exploder(755);
        }
      }
    }
  }
}
coast_egg_dial_rotate(ent_dial) {
  if(!isDefined(ent_dial.pos)) {
    ent_dial.pos = 0;
  }
  while(ent_dial ent_flag("rotating")) {
    wait(0.1);
  }
  ent_dial ent_flag_set("rotating");
  ent_dial RotatePitch(36, 0.2);
  ent_dial waittill("rotatedone");
  ent_dial.pos++;
  if(ent_dial.pos > 9) {
    ent_dial.pos = 0;
  }
  sound = "zmb_harmonizer_tone_" + ent_dial.pos;
  if(flag("power_on")) {
    ent_dial playLoopSound(sound);
  }
  ent_dial ent_flag_clear("rotating");
}
coast_egg_dials_in_harmony() {
  Assert(isDefined(level._dials));
  Assert(isDefined(level.together_again));
  match = true;
  for(i = 0; i < level.together_again.size; i++) {
    if(level._dials[i].pos != level.together_again[i]) {
      match = false;
    }
  }
  return match;
}
leo() {
  flag_wait("ss");
  level thread coast_egg_sacrifice_spot_start();
  level thread coast_egg_device_delivered();
  flag_wait("re");
  flag_wait("s_s");
}
coast_egg_sacrifice_spot_start() {
  level._humangun_escape_override = getstruct("struct_sacrifice_grabbed_by_light", "targetname");
  middle_of_the_light = getstruct("struct_middle_of_light", "targetname");
  top_of_the_house = getstruct("struct_top_of_the_house", "targetname");
  trig_reached_light = GetEnt("trig_human_into_the_light", "targetname");
  trig_gotcha = GetEnt("trig_mine", "targetname");
  reward = undefined;
  light_mover = undefined;
  who = undefined;
  move_dist = undefined;
  fx_spot = undefined;
  if(!isDefined(level._humangun_escape_override)) {
    return;
  }
  trig_reached_light playSound("zmb_varoooooom");
  trig_reached_light playLoopSound("zmb_varoooooom_loop", 3);
  while(!flag("re")) {
    while(!flag("sa")) {
      trig_reached_light waittill("trigger", who);
      if(isDefined(who) && IsAlive(who) && !isPlayer(who) && who.animname == "human_zombie") {
        light_mover = spawn("script_model", who.origin);
        light_mover.angles = who.angles;
        light_mover setModel("tag_origin");
        who LinkTo(light_mover);
        who.animname = "dancer";
        who thread beat_break(%ai_zombie_flinger_flail);
        light_mover thread watch_for_death(who);
        light_mover thread rotate_while_moving();
        who.ignoreme = true;
        who disable_pain();
        who._lighthouse_owned = true;
        who thread magic_bullet_shield();
        level._zombie_human_array = array_remove(level._zombie_human_array, who);
        who.humangun_zombie_1st_hit_was_upgraded = undefined;
        level._humangun_escape_override = undefined;
        who thread rising_watch(light_mover);
        light_mover MoveTo(middle_of_the_light.origin, 2.0);
        light_mover waittill_notify_or_timeout("movedone", 2.0);
        if(isDefined(who) && IsAlive(who)) {
          flag_set("sa");
        }
        if(!isDefined(light_mover)) {
          continue;
        }
      }
    }
    if(isDefined(light_mover)) {
      move_dist = top_of_the_house.origin[2] - middle_of_the_light.origin[2];
      light_mover MoveZ(move_dist, 25);
      light_mover waittill_notify_or_timeout("movedone", 25.0);
      if(!isDefined(light_mover)) {
        continue;
      }
      light_mover notify("completed");
      fx_spot = spawn("script_model", light_mover.origin + (0, 0, -60));
      fx_spot setModel("tag_origin");
      fx_spot playSound("zmb_northern_lights");
      playFXOnTag(level._effect["fx_zmb_coast_sacrifice_flash"], fx_spot, "tag_origin");
      fx_spot thread rotate_while_moving();
    }
    if(isDefined(who)) {
      if(is_true(who._light_accept)) {
        reward = spawn("script_model", light_mover.origin);
        reward.angles = light_mover.angles;
        reward setModel("p_zom_vril_device");
        reward playLoopSound("zmb_shimmer_sweetly_loop");
      }
      who._lighthouse_owned = undefined;
      who thread stop_magic_bullet_shield();
      who Unlink();
      who Hide();
      who DoDamage(who.health + 10, who.origin);
    }
    if(isDefined(light_mover)) {
      if(isDefined(reward)) {
        reward LinkTo(light_mover);
        back_down = (move_dist - 45) * -1;
        light_mover thread rotate_while_moving();
        light_mover MoveZ(back_down, 5.0);
        light_mover waittill("movedone");
        grabbed = false;
        while(!grabbed) {
          trig_gotcha waittill("trigger", grabber);
          if(is_player_valid(grabber)) {
            level thread device_return_from_death(reward.origin);
            grabber thread device_replace_on_death();
            fx_spot notify("completed");
            light_mover notify("completed");
            fx_spot Delete();
            reward StopLoopSound(.1);
            reward playSound("zmb_tingling_sensation");
            grabber thread coast_eggs_hud("zom_hud_icon_vril", "s_s");
            reward Unlink();
            reward Delete();
            grabber._has_device = true;
            grabber maps\_zombiemode_audio::create_and_play_dialog("eggs", "coast_response", undefined, 12);
            grabbed = true;
            level._humangun_escape_override = undefined;
            flag_set("re");
            stop_exploder(755);
          }
        }
      } else {
        level._humangun_escape_override = getstruct("struct_sacrifice_grabbed_by_light", "targetname");
        flag_clear("sa");
      }
      light_mover Delete();
    }
    wait(0.1);
  }
}
device_return_from_death(vec_spot) {
  level endon("s_s");
  trig_gotcha = GetEnt("trig_mine", "targetname");
  while(!flag("s_s")) {
    level waittill("device_lost");
    device = spawn("script_model", vec_spot);
    device thread rotate_while_moving();
    device setModel("p_zom_vril_device");
    device playLoopSound("zmb_shimmer_sweetly_loop");
    grabbed = false;
    while(!grabbed) {
      trig_gotcha waittill("trigger", who);
      if(is_player_valid(who)) {
        device notify("completed");
        device StopLoopSound(.1);
        device playSound("zmb_tingling_sensation");
        who thread coast_eggs_hud("zom_hud_icon_vril", "s_s");
        device Delete();
        who._has_device = true;
        who maps\_zombiemode_audio::create_and_play_dialog("eggs", "coast_response", undefined, 12);
        grabbed = true;
      }
    }
  }
}
watch_for_death(ent_guy) {
  self endon("completed");
  ent_guy waittill("death");
  if(isDefined(ent_guy)) {
    ent_guy Unlink();
  }
  flag_clear("sa");
  level._humangun_escape_override = getstruct("struct_sacrifice_grabbed_by_light", "targetname");
  self Delete();
}
rotate_while_moving() {
  self endon("completed");
  while(isDefined(self)) {
    self RotateYaw(360, 4.0);
    self waittill("rotatedone");
  }
}
device_replace_on_death() {
  self endon("disconnect");
  level endon("s_s");
  level thread lost_salvation(self);
  self waittill_any("death", "_zombie_game_over", "spawned_spectator");
  if(isDefined(self)) {
    self._has_device = undefined;
  }
  level notify("device_lost");
}
lost_salvation(ent_ply) {
  level endon("s_s");
  ent_ply endon("death");
  ent_ply waittill("disconnect");
  level notify("device_lost");
}
rising_watch(org_mover) {
  self endon("death");
  org_mover endon("completed");
  players = GetPlayers();
  self.essance = 5000 * players.size;
  while(self.essance > 0) {
    self waittill("damage", i_amount, e_inflictor);
    self.essance = self.essance - i_amount;
  }
  self notify("switch");
  self thread beat_break(%ai_zombie_dying_back_idle);
  self notify("lighthouse_owned");
  self._light_accept = true;
}
coast_egg_device_delivered() {
  delivery_trig = GetEnt("trig_deliver", "targetname");
  delivery_tube = GetEnt(delivery_trig.target, "targetname");
  knock_trig = GetEnt("e_gargoyle", "targetname");
  if(!isDefined(delivery_trig)) {
    return;
  }
  flag_wait("re");
  delivered = false;
  while(!delivered) {
    delivery_trig waittill("trigger", shorts_man);
    if(is_player_valid(shorts_man) && isDefined(shorts_man._has_device) && shorts_man._has_device == true) {
      delivered = true;
      shorts_man._has_device = false;
      shorts_man thread coast_remove_eggs_hud();
      if(isDefined(delivery_tube)) {
        spawn_point = delivery_tube GetTagOrigin("tag_tube");
        device = spawn("script_model", spawn_point);
        device.angles = delivery_tube GetTagAngles("tag_tube");
        device setModel("p_zom_vril_device");
        device playSound("zmb_whooooosh");
        device MoveZ(40, 1.0);
        device waittill("movedone");
        device Delete();
      }
      flag_set("s_s");
      level.egg_sound_ent StopLoopSound(1.5);
      level maps\zombie_coast_amb::play_characters_skits_etc(shorts_man, knock_trig, 13, 5, 14, undefined);
      level.egg_sound_ent playLoopSound("zmb_fantastical_worlds_loop", 1.5);
      flag_set("sdm");
    }
  }
}
capricorn() {
  trig_hit = GetEnt("trig_fix_tv", "targetname");
  fuse_box = GetEnt("ent_fuse_box", "targetname");
  knock_trig = GetEnt("e_gargoyle", "targetname");
  fixed = false;
  if(!isDefined(trig_hit)) {
    return;
  }
  flag_wait("sdm");
  level thread coast_egg_broken_spark(fuse_box);
  while(!fixed) {
    trig_hit waittill("damage", i_amount, e_inflictor, v_direction, v_point, mod_type);
    if(is_player_valid(e_inflictor) && mod_type == level.trials[2]) {
      fuse_box playSound("zmb_wizzybizzy_explo");
      level.egg_sound_ent playSound("zmb_craziness_supreme");
      level notify("stop_spark");
      level maps\zombie_coast_amb::play_characters_skits_etc(e_inflictor, knock_trig, 15, 6, undefined, undefined);
      fixed = true;
    }
  }
  flag_set("dmf");
  level notify("scrambled");
  level notify("coast_easter_egg_achieved");
  level thread consequences_will_never_be_the_same();
}
coast_egg_broken_spark(fuse_box) {
  level endon("stop_spark");
  while(isDefined(self)) {
    exploder(780);
    fuse_box playSound("zmb_jumping_jacks");
    wait(RandomFloatRange(0.5, 1.2));
  }
}
consequences_will_never_be_the_same() {
  struct = getstruct("consequence", "targetname");
  if(isDefined(struct)) {
    level thread maps\_zombiemode_powerups::specific_powerup_drop("tesla", struct.origin);
  }
}
coast_eggs_hud(str_shader, str_endon) {
  self.eggHud = create_simple_hud(self);
  self.eggHud.foreground = true;
  self.eggHud.sort = 2;
  self.eggHud.hidewheninmenu = false;
  self.eggHud.alignX = "center";
  self.eggHud.alignY = "bottom";
  self.eggHud.horzAlign = "user_right";
  self.eggHud.vertAlign = "user_bottom";
  self.eggHud.x = -225;
  self.eggHud.y = 0;
  self.eggHud.alpha = 1;
  self.eggHud setshader(str_shader, 32, 32);
  self thread coast_eggs_hud_remove_on_death(str_endon);
}
coast_remove_eggs_hud() {
  self endon("death");
  if(isDefined(self.eggHud)) {
    self.eggHud Destroy();
  }
}
coast_eggs_hud_remove_on_death(str_endon) {
  level endon(str_endon);
  self waittill_any("death", "_zombie_game_over", "spawned_spectator");
  self thread coast_remove_eggs_hud();
}
coast_egg_debug_print3d(str_text) {
  self endon("stop_egg_debug");
  self endon("death");
  while(isDefined(self)) {
    Print3d(self.origin, str_text, (0.9, 0.9, 0.9), 1, 1, 10);
    wait(0.5);
  }
}
coast_egg_play_anim(str_anim, str_notify, str_endon) {
  self endon(str_endon);
  self endon("death");
  while(isDefined(self) && IsAlive(self)) {
    time = getAnimLength(str_anim);
    self animscripted(str_notify, self.origin, self.angles, str_anim);
    wait(time);
  }
}