/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_theater_movie_screen.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_theater;
#using scripts\zm\zm_theater_amb;
#namespace zm_theater_movie_screen;

function initmoviescreen() {
  level thread setupcurtains();
  level thread movie_reels_init();
}

function setupcurtains() {
  level flag::wait_till("power_on");
  curtains_clip = getent("theater_curtains_clip", "targetname");
  curtains_clip notsolid();
  curtains_clip connectpaths();
  level zm_theater::function_ce6ee03b();
  wait(3);
  level thread lower_movie_screen();
  wait(6);
  level flag::set("curtains_done");
}

function monitorcurtain(curtorg) {
  clip = getent(self.target, "targetname");
  while(isDefined(clip)) {
    if((abs(curtorg[0] - self.origin[0])) >= 38) {
      clip connectpaths();
      clip notsolid();
      if(isDefined(clip.target)) {
        clip = getent(clip.target, "targetname");
      } else {
        clip = undefined;
      }
    }
    wait(0.1);
  }
}

function open_left_curtain() {
  level flag::wait_till("power_on");
  curtain = getent("left_curtain", "targetname");
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

function open_right_curtain() {
  level flag::wait_till("power_on");
  curtain = getent("right_curtain", "targetname");
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

function lower_movie_screen() {
  var_d647fedd = getEntArray("movie_screen", "targetname");
  var_d647fedd[0] playSound("evt_screen_lower");
  array::run_all(var_d647fedd, & movez, -466, 6);
  wait(8);
  level clientfield::set("zm_theater_screen_in_place", 1);
  util::clientnotify("sip");
}

function movie_reels_init() {
  clean_bedroom_reels = getEntArray("trigger_movie_reel_clean_bedroom", "targetname");
  bear_bedroom_reels = getEntArray("trigger_movie_reel_bear_bedroom", "targetname");
  interrogation_reels = getEntArray("trigger_movie_reel_interrogation", "targetname");
  pentagon_reels = getEntArray("trigger_movie_reel_pentagon", "targetname");
  level.reel_trigger_array = [];
  array::add(level.reel_trigger_array, clean_bedroom_reels, 0);
  array::add(level.reel_trigger_array, bear_bedroom_reels, 0);
  array::add(level.reel_trigger_array, interrogation_reels, 0);
  array::add(level.reel_trigger_array, pentagon_reels, 0);
  level.reel_trigger_array = array::randomize(level.reel_trigger_array);
  reel_0 = movie_reels_random(level.reel_trigger_array[0], "ps1");
  reel_1 = movie_reels_random(level.reel_trigger_array[1], "ps2");
  reel_2 = movie_reels_random(level.reel_trigger_array[2], "ps3");
  temp_reels_0 = arraycombine(clean_bedroom_reels, bear_bedroom_reels, 0, 0);
  temp_reels_1 = arraycombine(interrogation_reels, pentagon_reels, 0, 0);
  all_reels = arraycombine(temp_reels_0, temp_reels_1, 0, 0);
  array::thread_all(all_reels, & movie_reels);
  level thread movie_projector_reel_change();
}

function movie_reels_random(array_reel_triggers, str_reel) {
  if(!isDefined(array_reel_triggers)) {
    return;
  }
  if(array_reel_triggers.size <= 0) {
    return;
  }
  if(!isDefined(str_reel)) {
    return;
  }
  random_reels = array::randomize(array_reel_triggers);
  random_reels[0].script_string = str_reel;
  random_reels[0].reel_active = 1;
  return random_reels[0];
}

function movie_reels() {
  if(!isDefined(self.target)) {
    /
    #
    assert(isDefined(self.target), "");
    return;
  }
  self.reel_model = getent(self.target, "targetname");
  if(!isDefined(self.reel_active)) {
    self.reel_active = 0;
  }
  if(self.reel_active === 0) {
    self.reel_model hide();
    self setcursorhint("HINT_NOICON");
    self sethintstring("");
    self triggerenable(0);
    return;
  }
  if(isDefined(self.reel_active) && self.reel_active == 1) {
    self.reel_model setModel("p7_zm_kin_movie_reel_case_vintage_logo");
    self setcursorhint("HINT_NOICON");
  }
  level flag::wait_till("power_on");
  self waittill("trigger", who);
  who playSound("zmb_reel_pickup");
  self.reel_model hide();
  self triggerenable(0);
  self thread function_63d5f7f2(who);
  who.reel = self.script_string;
  who thread theater_movie_reel_hud();
}

function function_63d5f7f2(e_player) {
  level endon("end_game");
  e_player waittill("disconnect");
  self.reel_model show();
  self triggerenable(1);
  self.reel_active = 1;
  self thread movie_reels();
}

function movie_projector_reel_change() {
  screen_struct = struct::get("struct_theater_screen", "targetname");
  projector_trigger = getent("trigger_change_projector_reels", "targetname");
  projector_trigger setcursorhint("HINT_NOICON");
  if(!isDefined(screen_struct.script_string)) {
    screen_struct.script_string = "ps0";
  }
  while(true) {
    projector_trigger waittill("trigger", who);
    if(isDefined(who.reel) && isstring(who.reel)) {
      switch (who.reel) {
        case "ps1": {
          level clientfield::set("zm_theater_movie_reel_playing", 1);
          break;
        }
        case "ps2": {
          level clientfield::set("zm_theater_movie_reel_playing", 2);
          break;
        }
        case "ps3": {
          level clientfield::set("zm_theater_movie_reel_playing", 3);
          break;
        }
      }
      who notify("reel_set");
      who thread theater_remove_reel_hud();
      projector_trigger thread zm_theater_amb::play_radio_egg(2);
      who playSound("zmb_reel_place");
      level notify("play_movie", who.reel);
      who.reel = undefined;
      wait(3);
    } else {
      wait(0.1);
    }
    wait(0.1);
  }
}

function theater_movie_reel_hud() {
  self zm_sidequests::add_sidequest_icon(undefined, "movieReel");
  self thread theater_remove_reel_on_death();
}

function theater_remove_reel_hud() {
  self zm_sidequests::remove_sidequest_icon(undefined, "movieReel");
}

function theater_remove_reel_on_death() {
  self endon("reel_set");
  self util::waittill_either("death", "_zombie_game_over");
  self thread theater_remove_reel_hud();
}