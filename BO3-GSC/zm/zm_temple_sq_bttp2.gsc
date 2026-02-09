/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_sq_bttp2.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\zm_temple_sq;
#using scripts\zm\zm_temple_sq_brock;
#using scripts\zm\zm_temple_sq_skits;
#namespace zm_temple_sq_bttp2;

function init() {
  zm_sidequests::declare_sidequest_stage("sq", "bttp2", &init_stage, &stage_logic, &exit_stage);
  zm_sidequests::set_stage_time_limit("sq", "bttp2", 300, &function_e9d67422);
}

function init_stage() {
  level notify("hash_d146ae8a");
  level.var_64d74143 = 0;
  dials = getEntArray("sq_bttp2_dial", "targetname");
  level.var_83becb0e = dials.size;
  array::thread_all(dials, &function_5ac3fada);
  zm_temple_sq_brock::delete_radio();
  if(level flag::get("radio_7_played")) {
    level thread delayed_start_skit("tt7a");
  } else {
    level thread delayed_start_skit("tt7b");
  }
  level thread function_6908dcf2();
}

function delayed_start_skit(skit) {
  wait(0.5);
  level thread zm_temple_sq_skits::start_skit(skit);
}

function function_6908dcf2() {
  wait(25);
  a_struct = struct::get("sq_bttp2_bolt_from_the_blue_a", "targetname");
  var_2b775263 = struct::get("sq_bttp2_bolt_from_the_blue_b", "targetname");
  a = spawn("script_model", a_struct.origin);
  a setModel("tag_origin");
  util::wait_network_frame();
  b = spawn("script_model", var_2b775263.origin);
  b setModel("tag_origin");
  util::wait_network_frame();
  original_origin = a.origin;
  for(i = 0; i < 7; i++) {
    yaw = randomfloat(360);
    r = randomfloatrange(500, 1000);
    amntx = cos(yaw) * r;
    amnty = sin(yaw) * r;
    a.origin = original_origin + (amntx, amnty, 0);
    zm_temple_sq::bounce_from_a_to_b(a, b, 0);
    wait(0.55);
  }
  wait(5);
  a.origin = original_origin;
  zm_temple_sq::bounce_from_a_to_b(b, a, 1);
  wait(1);
  a delete();
  b delete();
}

function function_e9d67422() {
  if(level flag::get("radio_7_played")) {
    return 300;
  }
  return 60;
}

function stage_logic() {
  while(level.var_64d74143 != level.var_83becb0e) {
    wait(0.1);
  }
  level notify("raise_crystal_1");
  level notify("raise_crystal_2");
  level notify("raise_crystal_3");
  level notify("raise_crystal_4");
  level notify("raise_crystal_5");
  level notify("raise_crystal_6", 1);
  level waittill("hash_a6dd8381");
  wait(5);
  zm_sidequests::stage_completed("sq", "bttp2");
}

function exit_stage(success) {
  dials = getEntArray("sq_bttp2_dial", "targetname");
  array::thread_all(dials, &dud_dial_handler);
  if(success) {
    zm_temple_sq_brock::create_radio(8);
  } else {
    zm_temple_sq_brock::create_radio(7, &zm_temple_sq_brock::radio7_override);
    level thread zm_temple_sq_skits::fail_skit();
  }
}

function dial_trigger() {
  level endon("hash_d146ae8a");
  level endon("hash_1ee44755");
  while(true) {
    self waittill("triggered", who);
    self.owner_ent notify("triggered", who);
  }
}

function function_5ac3fada() {
  if(!level flag::get("radio_7_played")) {
    self thread dud_dial_handler("We don't know what we're doing.");
  }
  level endon("hash_1ee44755");
  self.angles = self.original_angles;
  pos = randomintrange(0, 3);
  if(pos == self.script_int) {
    pos = (pos + 1) % 4;
  }
  self rotatepitch(90 * pos, 0.01);
  correct = 0;
  while(!(isDefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
    self waittill("triggered", who);
    self playSound("evt_sq_bttp2_wheel_turn");
    self rotatepitch(90, 0.25);
    self waittill("rotatedone");
    pos = (pos + 1) % 4;
    if(pos == self.script_int) {
      level.var_64d74143++;
      print3d(self.origin, "", vectorscale((0, 1, 0), 255), 10);
      correct = 1;
      if(isDefined(who) && isPlayer(who)) {
        if(level.var_64d74143 == level.var_83becb0e) {
          who thread zm_audio::create_and_play_dialog("eggs", "quest7", 0);
        }
      }
    } else if(correct) {
      correct = 0;
      level.var_64d74143--;
    }
    wait(0.1);
  }
}

function dud_dial_handler(var_10be97cb) {
  level endon("hash_d146ae8a");
  self.trigger thread dial_trigger();
  if(!isDefined(self.original_angles)) {
    self.original_angles = self.angles;
  }
  self.angles = self.original_angles;
  rot = randomintrange(0, 3);
  self rotatepitch(rot * 90, 0.01);
  while(true) {
    self waittill("triggered");
    self playSound("evt_sq_bttp2_wheel_turn");
    if(isDefined(var_10be97cb)) {
      iprintlnbold("" + var_10be97cb);
    }
    self rotatepitch(90, 0.25);
  }
}