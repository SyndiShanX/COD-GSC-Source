/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_d3ced43465e5aec.csc
***********************************************/

#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_54c0478b7e9d6d81;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_5d515bd5;

function init() {
  clientfield::register("actor", "clone_activated", 1, 1, "int", &clone_activated, 0, 1);
  clientfield::register("actor", "clone_damaged", 1, 1, "int", &clone_damaged, 0, 0);
  clientfield::register("allplayers", "clone_activated", 1, 1, "int", &player_clone_activated, 0, 0);
}

function clone_activated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self._isclone = 1;

    if(isDefined(level._monitor_tracker)) {
      self thread[[level._monitor_tracker]](fieldname);
    }

    self thread gadget_clone_render::transition_shader(fieldname);
  }
}

function player_clone_activated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    self thread gadget_clone_render::transition_shader(fieldname);
    return;
  }

  self notify(#"clone_shader_off");
  self mapshaderconstant(fieldname, 0, "scriptVector3", 1, 0, 0, 1);
}

function clone_damage_flicker(localclientnum) {
  self endon(#"death");
  self notify(#"start_flicker");
  self endon(#"start_flicker");
  self waittill(#"stop_flicker");
}

function clone_damage_finish() {
  self endon(#"death");
  self endon(#"start_flicker");
  self endon(#"stop_flicker");
  wait 0.2;
  self notify(#"stop_flicker");
}

function clone_damaged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self thread clone_damage_flicker(fieldname);
    return;
  }

  self thread clone_damage_finish();
}