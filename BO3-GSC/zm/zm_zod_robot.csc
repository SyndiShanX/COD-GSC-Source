/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_robot.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_zod_robot;

function autoexec __init__sytem__() {
  system::register("zm_zod_robot", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "robot_switch", 1, 1, "int", & robot_switch, 0, 0);
  clientfield::register("world", "robot_lights", 1, 2, "int", & robot_lights, 0, 0);
  ai::add_archetype_spawn_function("zod_companion", & function_a0b7ccbf);
}

function private function_a0b7ccbf(localclientnum) {
  entity = self;
  entity setdrawname(&"ZM_ZOD_ROBOT_NAME");
}

function robot_switch(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFX(localclientnum, "zombie/fx_fuse_master_switch_on_zod_zmb", self.origin);
}

function robot_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 1: {
      exploder::exploder("lgt_robot_callbox_green");
      exploder::stop_exploder("lgt_robot_callbox_red");
      exploder::stop_exploder("lgt_robot_callbox_yellow");
      break;
    }
    case 2: {
      exploder::stop_exploder("lgt_robot_callbox_green");
      exploder::exploder("lgt_robot_callbox_red");
      exploder::stop_exploder("lgt_robot_callbox_yellow");
      break;
    }
    case 3: {
      exploder::stop_exploder("lgt_robot_callbox_green");
      exploder::stop_exploder("lgt_robot_callbox_red");
      exploder::exploder("lgt_robot_callbox_yellow");
      break;
    }
    default: {
      exploder::stop_exploder("lgt_robot_callbox_green");
      exploder::stop_exploder("lgt_robot_callbox_red");
      exploder::stop_exploder("lgt_robot_callbox_yellow");
      break;
    }
  }
}