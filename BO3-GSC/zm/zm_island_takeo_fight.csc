/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_takeo_fight.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\craftables\_zm_craftables;
#using_animtree("generic");
#namespace zm_island_takeo_fight;

function autoexec __init__sytem__() {
  system::register("zm_island_takeo_fight", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "takeofight_teleport_fx", 9000, 1, "int", & takeofight_teleport_fx, 0, 0);
  clientfield::register("scriptmover", "takeo_arm_hit_fx", 1, 3, "int", & takeo_arm_hit_fx, 0, 0);
}

function main() {}

function takeofight_teleport_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function takeo_arm_hit_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval > 0) {
    str_tag = ("tag_fx_eye" + newval) + "_jnt";
    self.var_2c75d806 = playFXOnTag(localclientnum, level._effect["takeofight_postule_burst"], self, str_tag);
  }
}