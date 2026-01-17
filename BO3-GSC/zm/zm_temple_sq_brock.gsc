/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_sq_brock.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\zm_temple_sq;
#namespace zm_temple_sq_brock;

function init() {
  level flag::init("radio_4_played");
  level._brock_naglines = [];
  level._brock_corpse_locations = [];
  level._radio_structs = struct::get_array("sq_radios", "targetname");
}

function delete_radio_internal() {
  if(isDefined(level._active_sq_radio)) {
    level._active_sq_radio.trigger delete();
    level._active_sq_radio stopsounds();
    util::wait_network_frame();
    level._active_sq_radio delete();
    level._active_sq_radio = undefined;
  }
}

function delete_radio() {
  level thread delete_radio_internal();
}

function trig_thread() {
  self endon("death");
  while(true) {
    self waittill("trigger");
    self.owner_ent notify("triggered");
  }
}

function radio_debug() {
  self endon("death");
  level endon("radio_7_played");
  while(!(isDefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
    print3d(self.origin, "", (0, 255, 255), 1);
    wait(1);
  }
}

function radio9_override(struct) {
  self notify("overridden");
  self endon("death");
  self.trigger delete();
  self ghost();
  sidequest = level._zombie_sidequests["sq"];
  if(sidequest.num_reps >= 3) {
    return;
  }
  level waittill("picked_up");
  level waittill("flush_done");
  self show();
  target = struct.target;
  while(isDefined(target)) {
    struct = struct::get(target, "targetname");
    time = struct.script_float;
    if(!isDefined(time)) {
      time = 1;
    }
    self moveto(struct.origin, time, time / 10);
    self waittill("movedone");
    target = struct.target;
  }
  self.trigger = spawn("trigger_radius_use", self.origin + vectorscale((0, 0, 1), 12), 0, 64, 72);
  self.trigger triggerignoreteam();
  self.trigger.radius = 64;
  self.trigger.height = 72;
  self.trigger setcursorhint("HINT_NOICON");
  self.trigger.owner_ent = self;
  self.trigger thread trig_thread();
  self waittill("triggered");
  snd = "vox_radio_egg_" + (self.script_int - 1);
  self playSound(snd);
  self playLoopSound("vox_radio_egg_snapshot", 1);
  wait(self.manual_wait);
  self stoploopsound(1);
  level flag::set("radio_9_played");
}

function radio7_override(struct) {
  self endon("death");
  self waittill("triggered");
  level flag::set("radio_7_played");
}

function radio4_override(struct) {
  self endon("death");
  self waittill("triggered");
  level flag::set("radio_4_played");
}

function radio2_override(struct) {
  self endon("death");
  self notify("overridden");
  self waittill("triggered");
  var_8e0fe378 = level._player_who_pressed_the_switch.characterindex;
  if(!isDefined(var_8e0fe378)) {
    var_8e0fe378 = 0;
  }
  var_bc7547cb = "a";
  switch (var_8e0fe378) {
    case 0: {
      var_bc7547cb = "a";
      break;
    }
    case 1: {
      var_bc7547cb = "b";
      break;
    }
    case 2: {
      var_bc7547cb = "d";
      break;
    }
    case 3: {
      var_bc7547cb = "c";
      break;
    }
  }
  snd = (("vox_radio_egg_" + (self.script_int - 1)) + "") + var_bc7547cb;
  self playsoundwithnotify(snd, "radiodone");
  self playLoopSound("vox_radio_egg_snapshot", 1);
  self waittill("radiodone");
  self stoploopsound(1);
}

function radio_thread() {
  self endon("death");
  self endon("overridden");
  self thread radio_debug();
  self waittill("triggered");
  snd = "vox_radio_egg_" + (self.script_int - 1);
  self playSound(snd);
  self playLoopSound("vox_radio_egg_snapshot", 1);
  wait(self.manual_wait);
  self stoploopsound(1);
}

function create_radio(radio_num, thread_func) {
  delete_radio();
  radio_struct = undefined;
  for(i = 0; i < level._radio_structs.size; i++) {
    if(level._radio_structs[i].script_int == radio_num) {
      radio_struct = level._radio_structs[i];
      break;
    }
  }
  if(!isDefined(radio_struct)) {
    println("" + radio_num);
    return;
  }
  radio = spawn("script_model", radio_struct.origin);
  radio.angles = radio_struct.angles;
  radio setModel("p7_zm_sha_recorder_digital");
  radio.script_int = radio_struct.script_int;
  radio.script_noteworthy = radio_struct.script_noteworthy;
  radio set_manual_wait_time(radio_num);
  radio.trigger = spawn("trigger_radius_use", radio.origin + vectorscale((0, 0, 1), 12), 0, 64, 72);
  radio.trigger triggerignoreteam();
  radio.trigger.radius = 64;
  radio.trigger.height = 72;
  radio.trigger setcursorhint("HINT_NOICON");
  radio.trigger.owner_ent = radio;
  radio.trigger thread trig_thread();
  radio thread radio_thread();
  if(isDefined(thread_func)) {
    radio thread[[thread_func]](radio_struct);
  }
  level._active_sq_radio = radio;
}

function set_manual_wait_time(num = 1) {
  waittime = 45;
  switch (num) {
    case 1: {
      waittime = 113;
      break;
    }
    case 2: {
      waittime = 95;
      break;
    }
    case 3: {
      waittime = 20;
      break;
    }
    case 4: {
      waittime = 58;
      break;
    }
    case 5: {
      waittime = 74;
      break;
    }
    case 6: {
      waittime = 35;
      break;
    }
    case 7: {
      waittime = 40;
      break;
    }
    case 8: {
      waittime = 39;
      break;
    }
    case 9: {
      waittime = 76;
      break;
    }
  }
  self.manual_wait = waittime;
}