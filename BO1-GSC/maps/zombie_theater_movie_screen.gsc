/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_theater_movie_screen.gsc
************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

initMovieScreen() {
  level thread setupCurtains();
  level thread movie_reels_init();
}

set_up_images() {
  level.images = [];
  level.images = getEntArray("screen_image", "targetname");
  level.images = mergeSort(level.images);
  for(x = 0; x < level.images.size; x++)
    level.images[x] hide();
}

mergeSort(current_list) {
  if(current_list.size <= 1)
    return current_list;
  left = [];
  right = [];
  middle = current_list.size / 2;
  for(x = 0; x < middle; x++)
    left = add_to_array(left, current_list[x]);
  for(; x < current_list.size; x++)
    right = add_to_array(right, current_list[x]);
  left = mergeSort(left);
  right = mergeSort(right);
  if(left[left.size - 1].script_int > right[right.size - 1].script_int)
    result = merge(left, right);
  else
    result = append(left, right);
  return result;
}

merge(left, right) {
  result = [];
  while(left.size > 0 && right.size > 0) {
    if(left[0] <= right[0]) {
      result = add_to_array(result, left[0]);
      left = array_remove_index(left, 0);
    } else {
      result = add_to_array(result, right[0]);
      right = array_remove_index(right, 0);
    }
  }
  while(left.size > 0)
    result = append(result, left);
  while(right.size > 0)
    result = append(result, right);
  return result;
}

append(left, right) {
  for(x = 0; x < right.size; x++)
    left = add_to_array(left, right[x]);
  return left;
}

setupCurtains() {
  flag_wait("power_on");
  curtains = getEnt("theater_curtains", "targetname");
  curtains_clip = getEnt("theater_curtains_clip", "targetname");
  curtains_clip notsolid();
  curtains_clip connectpaths();
  curtains maps\zombie_theater::theater_playanim("curtains_move");
  curtains waittill("curtains_move_done");
  flag_set("curtains_done");
  level thread lower_movie_screen();
}

moveCurtains(curtent) {
  curtain = getEnt(curtent, "targetname");
  curtorg = curtain.origin;
  time = 2;
  curtain thread monitorCurtain(curtorg);
  curtain connectpaths();
  curtain moveTo(curtain.origin + curtain.script_vector, time, time * 0.25, time * 0.25);
  curtain playSound("curtain_open");
}

monitorCurtain(curtorg) {
  clip = getEnt(self.target, "targetname");
  while(isDefined(clip)) {
    if((abs(curtorg[0] - self.origin[0])) >= 38) {
      clip connectpaths();
      clip NotSolid();
      if(isDefined(clip.target))
        clip = getEnt(clip.target, "targetname");
      else
        clip = undefined;
    }
    wait(0.1);
  }
}

open_left_curtain() {
  flag_wait("power_on");
  curtain = getEnt("left_curtain", "targetname");
  if(isDefined(curtain)) {
    wait(2);
    curtain_clip = getEntArray("left_curtain_clip", "targetname");
    for(i = 0; i < curtain_clip.size; i++) {
      curtain_clip[i] connectpaths();
      curtain_clip[i] notsolid();
    }
    curtain connectpaths();
    curtain movex(-300, 2);
  }
}

open_right_curtain() {
  flag_wait("power_on");
  curtain = getEnt("right_curtain", "targetname");
  if(isDefined(curtain)) {
    wait(2);
    curtain_clip = getEntArray("right_curtain_clip", "targetname");
    for(i = 0; i < curtain_clip.size; i++) {
      curtain_clip[i] connectpaths();
      curtain_clip[i] notsolid();
    }
    curtain connectpaths();
    curtain movex(300, 2);
  }
}

lower_movie_screen() {
  screen = getEnt("movie_screen", "targetname");
  if(isDefined(screen)) {
    screen movez(-466, 6);
    screen playSound("evt_screen_lower");
  }
  screen waittill("movedone");
  wait(2);
  clientnotify("sip");
}

play_images() {
  x = 0;
  while(1) {
    if(x > level.images.size - 1)
      x = 0;
    level.images[x] show();
    wait(0.1);
    level.images[x] hide();
    x++;
  }
}

movie_reels_init() {
  clean_bedroom_reels = getEntArray("trigger_movie_reel_clean_bedroom", "targetname");
  bear_bedroom_reels = getEntArray("trigger_movie_reel_bear_bedroom", "targetname");
  interrogation_reels = getEntArray("trigger_movie_reel_interrogation", "targetname");
  pentagon_reels = getEntArray("trigger_movie_reel_pentagon", "targetname");
  level.reel_trigger_array = [];
  level.reel_trigger_array = add_to_array(level.reel_trigger_array, clean_bedroom_reels, false);
  level.reel_trigger_array = add_to_array(level.reel_trigger_array, bear_bedroom_reels, false);
  level.reel_trigger_array = add_to_array(level.reel_trigger_array, interrogation_reels, false);
  level.reel_trigger_array = add_to_array(level.reel_trigger_array, pentagon_reels, false);
  level.reel_trigger_array = array_randomize(level.reel_trigger_array);
  reel_0 = movie_reels_random(level.reel_trigger_array[0], "ps1");
  reel_1 = movie_reels_random(level.reel_trigger_array[1], "ps2");
  reel_2 = movie_reels_random(level.reel_trigger_array[2], "ps3");
  temp_reels_0 = array_merge(clean_bedroom_reels, bear_bedroom_reels);
  temp_reels_1 = array_merge(interrogation_reels, pentagon_reels);
  all_reels = array_merge(temp_reels_0, temp_reels_1);
  array_thread(all_reels, ::movie_reels);
  level thread movie_projector_reel_change();
}

movie_reels_random(array_reel_triggers, str_reel) {
  if(!isDefined(array_reel_triggers)) {
    return;
  } else if(array_reel_triggers.size <= 0) {
    return;
  } else if(!isDefined(str_reel)) {
    return;
  }
  random_reels = array_randomize(array_reel_triggers);
  random_reels[0].script_string = str_reel;
  random_reels[0].reel_active = true;
  return random_reels[0];
}

movie_reels() {
  if(!isDefined(self.target)) {
    return;
  }
  self.reel_model = getEnt(self.target, "targetname");
  if(!isDefined(self.reel_active)) {
    self.reel_active = false;
  }
  if(isDefined(self.reel_active) && self.reel_active == false) {
    self.reel_model hide();
    self SetCursorHint("HINT_NOICON");
    self SetHintString("");
    self trigger_off();
    return;
  } else if(isDefined(self.reel_active) && self.reel_active == true) {
    self.reel_model setModel("zombie_theater_reelcase_obj");
    self SetCursorHint("HINT_NOICON");
  }
  flag_wait("power_on");
  self waittill("trigger", who);
  who playSound("zmb_reel_pickup");
  self.reel_model hide();
  self trigger_off();
  who.reel = self.script_string;
  who thread theater_movie_reel_hud();
}

movie_projector_reel_change() {
  screen_struct = getstruct("struct_theater_screen", "targetname");
  projector_trigger = getEnt("trigger_change_projector_reels", "targetname");
  projector_trigger SetCursorHint("HINT_NOICON");
  if(!isDefined(screen_struct.script_string)) {
    screen_struct.script_string = "ps0";
  }
  while(true) {
    projector_trigger waittill("trigger", who);
    if(isDefined(who.reel) && IsString(who.reel)) {
      clientnotify(who.reel);
      who notify("reel_set");
      who thread theater_remove_reel_hud();
      who thread maps\zombie_theater_amb::play_radio_egg(2);
      who playSound("zmb_reel_place");
      who.reel = undefined;
      wait(3);
    } else {
      wait(0.1);
    }
    wait(0.1);
  }
}

theater_movie_reel_hud() {
  self.reelHud = create_simple_hud(self);
  self.reelHud.foreground = true;
  self.reelHud.sort = 2;
  self.reelHud.hidewheninmenu = false;
  self.reelHud.alignX = "center";
  self.reelHud.alignY = "bottom";
  self.reelHud.horzAlign = "user_right";
  self.reelHud.vertAlign = "user_bottom";
  self.reelHud.x = -200;
  self.reelHud.y = 0;
  self.reelHud.alpha = 1;
  self.reelHud setshader("zom_icon_theater_reel", 32, 32);
  self thread theater_remove_reel_on_death();
}

theater_remove_reel_hud() {
  if(isDefined(self.reelHud)) {
    self.reelHud Destroy();
  }
}

theater_remove_reel_on_death() {
  self endon("reel_set");
  self waittill_either("death", "_zombie_game_over");
  self thread theater_remove_reel_hud();
}