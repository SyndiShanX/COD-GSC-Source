/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_sector.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_sector_fx;
#using scripts\mp\mp_sector_sound;
#using scripts\shared\_oob;
#using scripts\shared\compass;
#using scripts\shared\util_shared;
#namespace mp_sector;

function main() {
  precache();
  trigger = spawn("trigger_radius_out_of_bounds", (687.5, 2679, -356.5), 0, 300, 400);
  trigger thread oob::run_oob_trigger();
  mp_sector_fx::main();
  mp_sector_sound::main();
  level.add_raps_omit_locations = &add_raps_omit_locations;
  level.add_raps_drop_locations = &add_raps_drop_locations;
  level.remotemissile_kill_z = -680;
  load::main();
  setdvar("compassmaxrange", "2100");
  compass::setupminimap("compass_map_mp_sector");
  link_traversals("under_bridge", "targetname", 1);
  spawncollision("collision_clip_wall_128x128x10", "collider", (597.185, -523.817, 584.206), (-5, 90, 0));
  level spawnkilltrigger();
  level.cleandepositpoints = array((-1.72432, 176.047, 172.125), (715.139, 1279.47, 158.417), (-825.34, 171.066, 106.517), (-108.124, -751.785, 154.839));
}

function link_traversals(str_value, str_key, b_enable) {
  a_nodes = getnodearray(str_value, str_key);
  foreach(node in a_nodes) {
    if(b_enable) {
      linktraversal(node);
      continue;
    }
    unlinktraversal(node);
  }
}

function precache() {}

function add_raps_omit_locations(&omit_locations) {
  if(!isDefined(omit_locations)) {
    omit_locations = [];
  } else if(!isarray(omit_locations)) {
    omit_locations = array(omit_locations);
  }
  omit_locations[omit_locations.size] = (32, 710, 189);
  if(!isDefined(omit_locations)) {
    omit_locations = [];
  } else if(!isarray(omit_locations)) {
    omit_locations = array(omit_locations);
  }
  omit_locations[omit_locations.size] = (-960, 1020, 168);
}

function add_raps_drop_locations(&drop_candidate_array) {
  if(!isDefined(drop_candidate_array)) {
    drop_candidate_array = [];
  } else if(!isarray(drop_candidate_array)) {
    drop_candidate_array = array(drop_candidate_array);
  }
  drop_candidate_array[drop_candidate_array.size] = (-1100, 860, 145);
  if(!isDefined(drop_candidate_array)) {
    drop_candidate_array = [];
  } else if(!isarray(drop_candidate_array)) {
    drop_candidate_array = array(drop_candidate_array);
  }
  drop_candidate_array[drop_candidate_array.size] = (0, 520, 163);
}

function spawnkilltrigger() {
  trigger = spawn("trigger_radius", (-480.116, 3217.5, 119.108), 0, 150, 200);
  trigger thread watchkilltrigger();
  trigger = spawn("trigger_radius", (-480.115, 3309.66, 119.108), 0, 150, 200);
  trigger thread watchkilltrigger();
}

function watchkilltrigger() {
  level endon("game_ended");
  trigger = self;
  while(true) {
    trigger waittill("trigger", player);
    player dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
  }
}