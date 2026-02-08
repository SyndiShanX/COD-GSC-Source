/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\see2_sound.gsc
**************************************/

#include maps\_anim;
#include maps\_utility;
#include common_scripts\utility;
#include maps\pel2_util;
#include maps\_vehicle_utility;
#include maps\_music;

see2_playSound(anime, animname) {
  if(isDefined(level.scr_sound[anime][animname])) {
    level.line_queue = array_add(level.line_queue, level.scr_sound[anime][animname]);
    println("see2_playSound " + level.scr_sound[anime][animname]);
  }
}
see2_playAudio(soundAlias) {
  new_string = "";
  name = "";
  if(IsSubStr(soundAlias, "print:")) {
    for(i = 6; i < soundAlias.size; i++) {
      new_string = new_string + soundAlias[i];
    }

    iprintln(name + new_string);
    println("^3TEMP DIALOGUE - " + new_string);
    wait(2);
  } else {
    get_players()[0] playSound(soundAlias, soundAlias + " done");
    println("see2_PlayAudio : " + soundAlias);
    level.dialogue_timer = 0;
    get_players()[0] waittill(soundAlias + " done");
    println("see2_PlayAudio : " + soundAlias + " done.");
  }
}
see2_handleLineQueue() {
  level endon("kill the audio queue");

  new_array = [];
  while(1) {
    if(level.line_queue.size == 0) {
      wait(0.05);
      continue;
    }

    see2_playAudio(level.line_queue[0]);
    println("see2_handleLineQueue : Play audio " + level.line_queue[0]);
    new_array = [];
    for(i = 1; i < level.line_queue.size; i++) {
      new_array = array_add(new_array, level.line_queue[i]);
    }
    level.line_queue = new_array;
  }
}
see2_makeRadioBreaks(flag) {
  if(!flag(flag)) {
    see2_playRadioStop();
    flag_wait(flag);
    see2_playRadioStart();
  }
}
see2_playRadioStart() {}
see2_playRadioStop() {}
level_intro_announcements(endon_signal, complete_signal, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");

  see2_playRadioStart();
  see2_playSound("commissar", "intro1");

  see2_playSound("commissar", "intro2");

  see2_playSound("commissar", "intro3");

  see2_playRadioStop();

  level notify(complete_signal);
}
first_88_obj(endon_signal, complete_signal, destroyed_first_88, arg2, arg3, arg4, arg5, arg6, arg7) {
  setmusicstate("FIRST_FIGHT");

  level endon(endon_signal);
  flag_waitopen("playback happening");

  if(flag(destroyed_first_88)) {
    return;
  }
  see2_playRadioStart();
  see2_playSound("reznov", "first_88");
  see2_playRadioStop();

  level notify(complete_signal);
}
second_88_obj(endon_signal, complete_signal, second_88_in_sights, destroyed_second_88, arg3, arg4, arg5, arg6, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");
  if(flag(destroyed_second_88)) {
    return;
  }
  see2_playRadioStart();
  see2_playSound("reznov", "second_88");

  see2_makeRadioBreaks(second_88_in_sights);

  if(!flag(destroyed_second_88)) {
    see2_playSound("reznov", "second_88_fire");
    see2_playRadioStop();
  }

  level notify(complete_signal);
}
flamethrower_tutorial(endon_signal, complete_signal, flame_on_success, ads_success, flamethrower_prox, arg4, arg5, arg6, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");

  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] thread do_hud_for_ft_tut_by_client(endon_signal, complete_signal);
  }

  level thread cleanup_ft_tut_hud(endon_signal, complete_signal);

  see2_playRadioStart();
  see2_playSound("reznov", "flame_tip");

  see2_makeRadioBreaks(flame_on_success);

  see2_playSound("reznov", "flame_success");

  see2_makeRadioBreaks(ads_success);

  see2_playSound("reznov", "ads_success");

  see2_makeRadioBreaks(flamethrower_prox);

  see2_playSound("reznov", "flame_prompt");

  see2_playRadioStop();

  level notify(complete_signal);
}
cleanup_ft_tut_hud(endon_signal, complete_signal) {
  level waittill_either(endon_signal, complete_signal);

  if(!isDefined(level.hint_huds)) {
    return;
  }

  for(i = 0; i < get_players().size; i++) {
    level.hint_huds[i].alpha = 0;
    level.hint_huds[i] setText("");
  }
}

do_hud_for_ft_tut(endon_signal, complete_signal) {
  level endon(endon_signal);
  level endon(complete_signal);

  players = get_players();

  level.hint_huds = [];
  for(i = 0; i < players.size; i++) {
    level.hint_huds[i] = newClientHudElem(players[i]);
    level.hint_huds[i].x = 220;
    level.hint_huds[i].y = 200;
    level.hint_huds[i].fontScale = 1.5;
    level.hint_huds[i] setText(&"SEE2_FLAMETHROWER_HINT");
  }

  flag_wait("flamethrower_fired_once");

  for(i = 0; i < players.size; i++) {
    level.hint_huds[i] setText(&"SEE2_ADS_HINT");
  }

  flag_wait("ads_once");

  for(i = 0; i < players.size; i++) {
    level.hint_huds[i].alpha = 0;
    level.hint_huds[i] setText("");
  }
}

do_hud_for_ft_tut_by_client(endon_signal, complete_signal) {
  level endon(endon_signal);
  level endon(complete_signal);

  has_flamethrower = false;
  if(self == get_players()[0]) {
    has_flamethrower = true;
  }

  i = 0;
  players = get_players();
  for(j = 0; j < players.size; j++) {
    if(players[j] == self) {
      i = j;
      break;
    }
  }

  if(!isDefined(level.hint_huds)) {
    level.hint_huds = [];
  }

  level.hint_huds[i] = newClientHudElem(self);
  level.hint_huds[i].x = 220;
  level.hint_huds[i].y = 200;
  level.hint_huds[i].fontScale = 1.5;

  if(has_flamethrower) {
    level.hint_huds[i] setText(&"SEE2_FLAMETHROWER_HINT");
  } else {
    level.hint_huds[i] setText(&"SEE2_MG_COOP_HINT");
  }

  if(self != get_players()[0]) {
    flame_allowed_time = 0;
    while(!(self FragButtonPressed()) && flame_allowed_time > 120) {
      wait(0.05);
      flame_allowed_time++;
    }
  } else {
    self waittill("go_past_ft_tut");
  }

  wait(0.5);

  level.hint_huds[i] setText("");
  wait(0.2);

  level.hint_huds[i] setText(&"SEE2_ADS_HINT");

  if(self != get_players()[0]) {
    ads_time_allowed = 0;
    while(!(self AdsButtonPressed()) && ads_time_allowed > 120) {
      wait(0.05);
      ads_time_allowed++;
    }
  } else {
    if(!flag("ads_once")) {
      self waittill("go_past_ads_tut");
    } else {
      ads_time_allowed = 0;
      while(!(self AdsButtonPressed()) && ads_time_allowed > 120) {
        wait(0.05);
        ads_time_allowed++;
      }
    }
  }

  wait(0.5);
  level.hint_huds[i].alpha = 0;
  level.hint_huds[i] setText("");
}
tank_reload_movement_tutorial(endon_signal, complete_signal, first_fired_on_event, first_shot, arg3, arg4, arg5, arg6, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");
  flag_wait(first_fired_on_event);
  see2_playRadioStart();
  see2_playSound("reznov", "motion_is_life");

  see2_playRadioStart();

  flag_wait(first_shot);
  see2_playRadioStart();
  see2_playSound("reznov", "reloading");

  see2_playRadioStart();

  level notify(complete_signal);
}
first_panther_prompt(endon_signal, complete_signal, panther_activated, panther_in_sights, panther_first_shot, panther_second_shot, panther_third_shot, panther_dead, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");
  flag_wait(panther_activated);
  see2_playRadioStart();
  see2_playSound("reznov", "first_panther1");

  see2_playRadioStop();
  flag_wait(panther_in_sights);
  if(!flag(panther_dead)) {
    see2_playRadioStart();
    see2_playSound("reznov", "first_panther2");

    see2_playRadioStop();
    flag_wait(panther_first_shot);

    if(!flag(panther_dead)) {
      see2_playRadioStart();
      see2_playSound("reznov", "first_panther3");

      see2_playRadioStop();
      flag_wait(panther_second_shot);
    }
    if(!flag(panther_dead)) {
      see2_playRadioStart();
      see2_playSound("reznov", "first_panther4");

      see2_playRadioStop();
      flag_wait(panther_third_shot);
    }
  }
  flag_wait(panther_dead);
  see2_playRadioStart();
  see2_playSound("reznov", "first_panther_dead");

  see2_playRadioStop();

  level notify(complete_signal);
}
choose_path(endon_signal, complete_signal, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");

  if(!flag("coop")) {
    return;
  }

  see2_playRadioStart();
  see2_playSound("reznov", "route");
  see2_playRadioStop();

  see2_playRadioStart();
  see2_playSound("reznov", "route2");
  see2_playRadioStop();

  level notify(complete_signal);
}
choose_right_path(endon_signal, complete_signal, destroyed_both_88s, destroyed_second_last_88, destroyed_last_88, arg4, arg5, arg6, arg7) {
  flag_waitopen("playback happening");

  if(!flag("coop") || flag(destroyed_both_88s) || flag(destroyed_second_last_88) || flag(destroyed_last_88)) {
    return;
  }

  see2_playRadioStart();
  see2_playSound("reznov", "field_88s");
  see2_playRadioStop();

  level notify(complete_signal);
}
choose_left_path(endon_signal, complete_signal, destroyed_both_88s, destroyed_second_last_88, destroyed_last_88, arg4, arg5, arg6, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");

  if(flag(destroyed_both_88s) || flag(destroyed_second_last_88) || flag(destroyed_last_88)) {
    return;
  }

  see2_playRadioStart();
  see2_playSound("reznov", "road_88s");
  see2_playRadioStop();

  flag_set("left_path");

  level notify(complete_signal);
}
dead_88(endon_signal, complete_signal, destroyed_first_88, destroyed_second_88, destroyed_both_88s, destroyed_second_last_88, destroyed_last_88, arg6, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");

  flag_wait(destroyed_first_88);
  see2_playRadioStart();
  see2_playSound("reznov", "first_88_destroy");
  see2_makeRadioBreaks(destroyed_second_88);
  see2_playSound("reznov", "second_88_destroy");
  if(flag("coop")) {
    see2_makeRadioBreaks(destroyed_both_88s);
    if(!flag("left_path")) {
      see2_playSound("reznov", "road_88s_destroy");
    } else {
      see2_playSound("reznov", "field_88s_destroy");
    }
  }

  see2_makeRadioBreaks(destroyed_second_last_88);
  see2_playSound("reznov", "second_last_88");
  see2_makeRadioBreaks(destroyed_last_88);
  see2_playSound("reznov", "last_88_destroy");
}
player_exposed(endon_signal, complete_signal, first_warning_given, second_warning_given, arg3, arg4, arg5, arg6, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");

  if(!flag(first_warning_given)) {
    see2_playRadioStart();
    see2_playSound("reznov", "center_map1");

    see2_playRadioStop();
    flag_set(first_warning_given);
  }

  if(!flag(second_warning_given)) {
    see2_playRadioStart();
    see2_playSound("reznov", "center_map2");

    see2_playRadioStop();
    flag_set(second_warning_given);
  }

  see2_playRadioStart();
  see2_playSound("reznov", "center_map3");

  see2_playRadioStop();

  level notify(complete_signal);
}
radio_tower_dialog(endon_signal, complete_signal, radio_tower_visible, radio_tower_close, radio_tower_destroyed, arg4, arg5, arg6, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");

  see2_playRadioStart();
  see2_playSound("commissar", "radio_tower_obj");

  see2_playRadioStop();

  see2_playRadioStart();
  see2_playSound("reznov", "onward");

  if(!flag(radio_tower_visible)) {
    see2_playSound("reznov", "next_area");

    see2_makeRadioBreaks(radio_tower_visible);
  }
  see2_playSound("reznov", "radio_tower_prompt");

  see2_playRadioStop();

  flag_wait(radio_tower_close);

  see2_playRadioStart();
  if(!flag(radio_tower_destroyed)) {
    see2_playSound("reznov", "radio_tower2");

    see2_makeRadioBreaks(radio_tower_destroyed);
  }
  see2_playSound("reznov", "radio_tower_destroy");

  see2_playSound("reznov", "train3");

  see2_playRadioStop();

  level notify(complete_signal);
}
fuel_depot_dialog(endon_signal, complete_signal, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");

  see2_playSound("reznov", "train2");

  level notify(complete_signal);
}
final_battle_dialog(endon_signal, complete_signal, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");

  see2_playSound("commissar", "almost_there1");
  see2_playSound("commissar", "almost_there2");

  level notify(complete_signal);
}
victory_dialog(endon_signal, complete_signal, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
  level endon(endon_signal);
  flag_waitopen("playback happening");

  see2_playSound("commissar", "victory1");
  see2_playSound("commissar", "victory2");
  see2_playSound("commissar", "victory3");

  level notify(complete_signal);
}
do_battlechatter(endon_signal, complete_signal, do_firing, heavy_damage, damage, infantry_close, retreaters, destruction, idle) {
  level endon("kill the audio queue");
  level endon(endon_signal);
  flag_waitopen("playback happening");
  current_idle_line = 1;

  while(1) {
    if(!flag("battlechatter allowed")) {
      wait(0.05);
      continue;
    }

    if(level.dialogue_timer > level.time_between_dialogue) {
      if(flag(idle)) {
        if(current_idle_line <= level.num_idle_lines) {
          clear_battlechatter_flags(do_firing, heavy_damage, damage, infantry_close, retreaters, destruction, idle);
          see2_playSound("reznov", "idle" + current_idle_line);
          current_idle_line++;
        }
      }
      if(flag(infantry_close)) {
        clear_battlechatter_flags(do_firing, heavy_damage, damage, infantry_close, retreaters, destruction, idle);
        see2_playSound("reznov", "infantry_close" + randomintrange(1, 7));
      } else if(flag(do_firing)) {
        clear_battlechatter_flags(do_firing, heavy_damage, damage, infantry_close, retreaters, destruction, idle);
        see2_playSound("reznov", "shoot" + randomintrange(1, 7));
      } else if(flag(retreaters)) {
        clear_battlechatter_flags(do_firing, heavy_damage, damage, infantry_close, retreaters, destruction, idle);
        see2_playSound("reznov", "retreaters" + randomintrange(1, 4));
      } else if(flag(damage)) {
        clear_battlechatter_flags(do_firing, heavy_damage, damage, infantry_close, retreaters, destruction, idle);
        see2_playSound("reznov", "hit" + randomintrange(1, 7));
      } else if(flag(heavy_damage)) {
        clear_battlechatter_flags(do_firing, heavy_damage, damage, infantry_close, retreaters, destruction, idle);
        if((get_players()[0].myTank.armor / get_players()[0].myTank.maxarmor) < 0.1) {
          see2_playSound("reznov", "almost_dead");
        } else {
          see2_playSound("reznov", "half_damage");
        }
      } else if(flag(destruction)) {
        id = randomintrange(1, 12);
        clear_battlechatter_flags(do_firing, heavy_damage, damage, infantry_close, retreaters, destruction, idle);
        if(id < 10) {
          see2_playSound("reznov", "generic_destroy" + id);
        } else {
          see2_playSound("commissar", "generic_destroy" + id);
        }
      } else {
        object = get_players()[0] get_most_threatening_object();
        if(isDefined(object)) {
          level.identified_entities = array_add(level.identified_entities, object);
          direction = get_players()[0].myTank get_heading_of_object(object);
          designation = get_designation(object);
          if(isDefined(direction) && isDefined(designation)) {
            see2_playSound("reznov", designation);
            see2_playSound("reznov", direction);
          }
        }
        wait(1);
      }
    }
    wait(1);
  }

  level notify(complete_signal);
}
clear_battlechatter_flags(almost_dead, half_damage, damage, infantry_close, retreaters, destruction, idle) {
  flag_clear(infantry_close);
  flag_clear(retreaters);
  flag_clear(damage);
  flag_clear(half_damage);
  flag_clear(almost_dead);
  flag_clear(destruction);
  flag_clear(idle);
}
get_most_threatening_object() {
  best_dist = 10000000000;
  best_ent = undefined;
  for(i = 0; i < level.enemy_armor.size; i++) {
    if(isDefined(level.enemy_armor[i]) && level.enemy_armor[i].health > 0 && level.enemy_armor[i].classname != "script_vehicle_corpse") {
      dist = distanceSquared(level.enemy_armor[i].origin, self.origin);
      if(isDefined(level.enemy_armor[i].current_target) && level.enemy_armor[i].current_target == self && dist < best_dist && array_check_for_dupes(level.identified_entities, level.enemy_armor[i]) && level.enemy_armor[i].model != "artillery_ger_flak88") {
        object_origin = (level.enemy_armor[i].origin[0], level.enemy_armor[i].origin[1], 0);
        player_origin = (self.origin[0], self.origin[1], 0);
        player_vec = anglesToForward(self.angles);
        player_vec = (player_vec[0], player_vec[1], 0);
        player_vec = VectorNormalize(player_vec);
        target_vec = VectorNormalize(object_origin - player_origin);
        dot = VectorDot(target_vec, player_vec);
        if(acos(dot) < 32.5) {
          best_ent = level.enemy_armor[i];
          best_dist = dist;
        }
      }
    }
  }

  wait(0.05);

  for(z = 0; z < level.enemy_armor.size; z++) {
    if(isDefined(level.enemy_armor[z]) && level.enemy_armor[z].health > 0 && level.enemy_armor[z].classname != "script_vehicle_corpse" && array_check_for_dupes(level.identified_entities, level.enemy_armor[z]) && level.enemy_armor[z].model != "artillery_ger_flak88") {
      dist = distanceSquared(level.enemy_armor[z].origin, self.origin);
      if(dist < best_dist) {
        object_origin = (level.enemy_armor[z].origin[0], level.enemy_armor[z].origin[1], 0);
        player_origin = (self.origin[0], self.origin[1], 0);
        player_vec = anglesToForward(self.angles);
        player_vec = (player_vec[0], player_vec[1], 0);
        player_vec = VectorNormalize(player_vec);
        target_vec = VectorNormalize(object_origin - player_origin);
        dot = VectorDot(target_vec, player_vec);

        if(acos(dot) > 10) {
          trace = bulletTrace(player_origin + (0, 0, 120), object_origin + (0, 0, 120), false, get_players()[0].myTank);
          if(trace["fraction"] > 0.95) {
            best_ent = level.enemy_armor[z];
            best_dist = dist;
          }
        }
      }
    }
  }

  wait(0.05);

  guard_tower_array = getEntArray("guard tower damage trigger", "script_noteworthy");
  for(j = 0; j < guard_tower_array.size; j++) {
    if(isDefined(guard_tower_array[j]) && !isDefined(guard_tower_array[j].destroyed) && array_check_for_dupes(level.identified_entities, guard_tower_array[j])) {
      dist = distanceSquared(guard_tower_array[j].origin, self.origin);
      if(dist < best_dist) {
        object_origin = (guard_tower_array[j].origin[0], guard_tower_array[j].origin[1], 0);
        player_origin = (self.origin[0], self.origin[1], 0);
        player_vec = anglesToForward(self.angles);
        player_vec = (player_vec[0], player_vec[1], 0);
        player_vec = VectorNormalize(player_vec);
        target_vec = VectorNormalize(object_origin - player_origin);
        dot = VectorDot(target_vec, player_vec);
        if(acos(dot) > 10) {
          trace = bulletTrace(player_origin + (0, 0, 120), object_origin + (0, 0, 120), false, get_players()[0].myTank);
          if(trace["fraction"] > 0.95) {
            best_ent = guard_tower_array[j];
            best_dist = dist;
          }
        }
      }
    }
  }

  wait(0.05);

  retreat_truck_array = getEntArray("retreat truck", "targetname");
  for(m = 0; m < retreat_truck_array.size; m++) {
    if(isDefined(retreat_truck_array[m]) && retreat_truck_array[m].health > 0 && retreat_truck_array[m].classname != "script_vehicle_corpse") {
      dist = distanceSquared(retreat_truck_array[m].origin, self.origin);
      if(dist < best_dist) {
        object_origin = (retreat_truck_array[m].origin[0], retreat_truck_array[m].origin[1], 0);
        player_origin = (self.origin[0], self.origin[1], 0);
        player_vec = anglesToForward(self.angles);
        player_vec = (player_vec[0], player_vec[1], 0);
        player_vec = VectorNormalize(player_vec);
        target_vec = VectorNormalize(object_origin - player_origin);
        dot = VectorDot(target_vec, player_vec);
        if(acos(dot) > 32.5) {
          trace = bulletTrace(player_origin + (0, 0, 120), object_origin + (0, 0, 120), false, get_players()[0].myTank);
          if(trace["fraction"] > 0.95) {
            best_ent = retreat_truck_array[m];
            best_dist = dist;
          }
        }
      }
    }
  }

  return best_ent;
}
get_designation(object) {
  designation = undefined;
  if(object.classname == "script_vehicle" && object.model != "artillery_ger_flak88") {
    size = level.designation[object.model].size;
    index = 0;
    if(size > 1) {
      index = randomint(size);
    }
    designation = level.designation[object.model][index];
  } else if(object.script_noteworthy == "guard tower damage trigger") {
    size = level.designation["guard_tower"].size;
    index = 0;
    if(size > 1) {
      index = randomint(size);
    }
    designation = level.designation["guard_tower"][index];
  } else {
    size = level.designation[object.classname].size;
    index = 0;
    if(size > 1) {
      index = randomint(size);
    }
    designation = level.designation[object.classname][index];
  }
  return designation;
}
get_heading_of_object(object) {
  if(isDefined(object)) {
    theirPos = (object.origin[0], object.origin[1], 0);
    myPos = (self.origin[0], self.origin[1], 0);

    diff = object.origin - self.origin;
    angles = vectorToAngles(diff);

    diff = abs(self.angles[1] - angles[1]);

    if(diff > 315 || diff <= 45) {
      return "ahead" + randomintrange(1, 3);
    }
    if(diff <= 135 && diff > 45) {
      max = 4;
      if(diff > 100) {
        max = 5;
      }
      return "right" + randomintrange(1, max);
    }
    if(diff > 135 && diff <= 225) {
      return "behind" + randomintrange(1, 3);
    }
    if(diff > 225 && diff <= 315) {
      max = 4;
      if(diff < 260) {
        max = 5;
      }
      return "left" + randomintrange(1, max);
    }
  }
}