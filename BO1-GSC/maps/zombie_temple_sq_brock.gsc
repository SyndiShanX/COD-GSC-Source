/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_temple_sq_brock.gsc
*******************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init() {
  flag_init("radio_4_played");
  level._brock_naglines = [];
  level._brock_corpse_locations = [];
  PreCacheModel("p_ztem_digital_recorder");
  level._radio_structs = getstructarray("sq_radios", "targetname");
}

delete_radio_internal() {
  if(isDefined(level._active_sq_radio)) {
    level._active_sq_radio.trigger Delete();
    level._active_sq_radio StopSounds();
    wait_network_frame();
    level._active_sq_radio Delete();
    level._active_sq_radio = undefined;
  }
}

delete_radio() {
  level thread delete_radio_internal();
}

trig_thread() {
  self endon("death");
  while(1) {
    self waittill("trigger");
    self.owner_ent notify("triggered");
  }
}

radio_debug() {
  self endon("death");
  level endon("radio_7_played");
}

radio9_override(struct) {
  self notify("overridden");
  self endon("death");
  self.trigger Delete();
  self hide();
  sidequest = level._zombie_sidequests["sq"];
  if(sidequest.num_reps >= 3) {
    return;
  }
  level waittill("picked_up");
  level waittill("flush_done");
  self Show();
  target = struct.target;
  while(isDefined(target)) {
    struct = getstruct(target, "targetname");
    time = struct.script_float;
    if(!isDefined(time)) {
      time = 1.0;
    }
    self moveTo(struct.origin, time, time / 10);
    self waittill("movedone");
    target = struct.target;
  }
  self.trigger = spawn("trigger_radius_use", self.origin + (0, 0, 12), 0, 64, 72);
  self.trigger.radius = 64;
  self.trigger.height = 72;
  self.trigger SetCursorHint("HINT_NOICON");
  self.trigger.owner_ent = self;
  self.trigger thread trig_thread();
  self waittill("triggered");
  snd = "vox_radio_egg_" + (self.script_int - 1);
  self playSound(snd, "radiodone");
  self playLoopSound("vox_radio_egg_snapshot", 1);
  wait(self.manual_wait);
  self stopLoopSound(1);
  flag_set("radio_9_played");
}

radio7_override(struct) {
  self endon("death");
  self waittill("triggered");
  flag_set("radio_7_played");
}

radio4_override(struct) {
  self endon("death");
  self waittill("triggered");
  flag_set("radio_4_played");
}

radio2_override(struct) {
  self endon("death");
  self notify("overridden");
  self waittill("triggered");
  player_number = level._player_who_pressed_the_switch;
  if(!isDefined(player_number)) {
    player_number = 0;
  }
  post_fix = "a";
  switch (player_number) {
    case 0:
      post_fix = "a";
      break;
    case 1:
      post_fix = "b";
      break;
    case 2:
      post_fix = "c";
      break;
    case 3:
      post_fix = "d";
      break;
  }
  snd = "vox_radio_egg_" + (self.script_int - 1) + "" + post_fix;
  self playSound(snd, "radiodone");
  self playLoopSound("vox_radio_egg_snapshot", 1);
  wait(self.manual_wait);
  self stopLoopSound(1);
}

radio_thread() {
  self endon("death");
  self endon("overridden");
  self thread radio_debug();
  self waittill("triggered");
  snd = "vox_radio_egg_" + (self.script_int - 1);
  self playSound(snd, "radiodone");
  self playLoopSound("vox_radio_egg_snapshot", 1);
  wait(self.manual_wait);
  self stopLoopSound(1);
}

create_radio(radio_num, thread_func) {
  delete_radio();
  radio_struct = undefined;
  for(i = 0; i < level._radio_structs.size; i++) {
    if(level._radio_structs[i].script_int == radio_num) {
      radio_struct = level._radio_structs[i];
      break;
    }
  }
  if(!isDefined(radio_struct)) {
    PrintLn("** ERROR:Couldn't find radio struct " + radio_num);
    return;
  }
  radio = spawn("script_model", radio_struct.origin);
  radio.angles = radio_struct.angles;
  radio setModel("p_ztem_digital_recorder");
  radio.script_int = radio_struct.script_int;
  radio.script_noteworthy = radio_struct.script_noteworthy;
  radio set_manual_wait_time(radio_num);
  radio.trigger = spawn("trigger_radius_use", radio.origin + (0, 0, 12), 0, 64, 72);
  radio.trigger.radius = 64;
  radio.trigger.height = 72;
  radio.trigger SetCursorHint("HINT_NOICON");
  radio.trigger.owner_ent = radio;
  radio.trigger thread trig_thread();
  radio thread radio_thread();
  if(isDefined(thread_func)) {
    radio thread[[thread_func]](radio_struct);
  }
  level._active_sq_radio = radio;
}

set_manual_wait_time(num) {
  if(!isDefined(num)) {
    num = 1;
  }
  waittime = 45;
  switch (num) {
    case 1:
      waittime = 113;
      break;
    case 2:
      waittime = 95;
      break;
    case 3:
      waittime = 20;
      break;
    case 4:
      waittime = 58;
      break;
    case 5:
      waittime = 74;
      break;
    case 6:
      waittime = 35;
      break;
    case 7:
      waittime = 40;
      break;
    case 8:
      waittime = 39;
      break;
    case 9:
      waittime = 76;
      break;
  }
  self.manual_wait = waittime;
}