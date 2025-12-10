/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicleriders_shared.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using_animtree("generic");
#namespace vehicle;

function autoexec __init__sytem__() {
  system::register("vehicleriders", &__init__, undefined, undefined);
}

function __init__() {
  a_registered_fields = [];
  foreach(bundle in struct::get_script_bundles("vehicleriders")) {
    foreach(object in bundle.objects) {
      if(isstring(object.vehicleenteranim)) {
        array::add(a_registered_fields, object.position + "_enter", 0);
      }
      if(isstring(object.vehicleexitanim)) {
        array::add(a_registered_fields, object.position + "_exit", 0);
      }
      if(isstring(object.vehicleriderdeathanim)) {
        array::add(a_registered_fields, object.position + "_death", 0);
      }
    }
  }
  foreach(str_clientfield in a_registered_fields) {
    clientfield::register("vehicle", str_clientfield, 1, 1, "counter", &play_vehicle_anim, 0, 0);
  }
}

function play_vehicle_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  s_bundle = struct::get_script_bundle("vehicleriders", self.vehicleridersbundle);
  str_pos = "";
  str_action = "";
  if(strendswith(fieldname, "_enter")) {
    str_pos = getsubstr(fieldname, 0, fieldname.size - 6);
    str_action = "enter";
  } else {
    if(strendswith(fieldname, "_exit")) {
      str_pos = getsubstr(fieldname, 0, fieldname.size - 5);
      str_action = "exit";
    } else if(strendswith(fieldname, "_death")) {
      str_pos = getsubstr(fieldname, 0, fieldname.size - 6);
      str_action = "death";
    }
  }
  str_vh_anim = undefined;
  foreach(s_rider in s_bundle.objects) {
    if(s_rider.position == str_pos) {
      switch (str_action) {
        case "enter": {
          str_vh_anim = s_rider.vehicleenteranim;
          break;
        }
        case "exit": {
          str_vh_anim = s_rider.vehicleexitanim;
          break;
        }
        case "death": {
          str_vh_anim = s_rider.vehicleriderdeathanim;
          break;
        }
      }
      break;
    }
  }
  if(isDefined(str_vh_anim)) {
    self setanimrestart(str_vh_anim);
  }
}

function set_vehicleriders_bundle(str_bundlename) {
  self.vehicleriders = struct::get_script_bundle("vehicleriders", str_bundlename);
}