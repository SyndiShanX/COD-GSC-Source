/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\vehicleriders_shared.csc
************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;

#namespace vehicle;

autoexec init() {
  function_d64f1d30();
}

private function_d64f1d30() {
  a_registered_fields = [];

  foreach(bundle in struct::get_script_bundles("vehicleriders")) {
    foreach(object in bundle.objects) {
      if(isDefined(object.vehicleenteranim)) {
        array::add(a_registered_fields, object.position + "_enter", 0);
      }

      if(isDefined(object.vehicleexitanim)) {
        array::add(a_registered_fields, object.position + "_exit", 0);
      }

      if(isDefined(object.vehiclecloseanim)) {
        array::add(a_registered_fields, object.position + "_close", 0);
      }

      if(isDefined(object.vehicleriderdeathanim)) {
        array::add(a_registered_fields, object.position + "_death", 0);
      }
    }
  }

  foreach(str_clientfield in a_registered_fields) {
    clientfield::register("vehicle", str_clientfield, 1, 1, "counter", &play_vehicle_anim, 0, 0);
  }
}

play_vehicle_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  s_bundle = struct::get_script_bundle("vehicleriders", self.vehicleridersbundle);
  str_pos = "";
  str_action = "";

  if(strendswith(fieldname, "_enter")) {
    str_pos = getsubstr(fieldname, 0, fieldname.size - 6);
    str_action = "enter";
  } else if(strendswith(fieldname, "_exit")) {
    str_pos = getsubstr(fieldname, 0, fieldname.size - 5);
    str_action = "exit";
  } else if(strendswith(fieldname, "_close")) {
    str_pos = getsubstr(fieldname, 0, fieldname.size - 6);
    str_action = "close";
  } else if(strendswith(fieldname, "_death")) {
    str_pos = getsubstr(fieldname, 0, fieldname.size - 6);
    str_action = "death";
  }

  str_vh_anim = undefined;

  foreach(s_rider in s_bundle.objects) {
    if(s_rider.position == str_pos) {
      switch (str_action) {
        case #"enter":
          str_vh_anim = s_rider.vehicleenteranim;
          break;
        case #"exit":
          str_vh_anim = s_rider.vehicleexitanim;
          break;
        case #"close":
          str_vh_anim = s_rider.vehiclecloseanim;
          break;
        case #"death":
          str_vh_anim = s_rider.vehicleriderdeathanim;
          break;
      }

      break;
    }
  }

  if(isDefined(str_vh_anim)) {
    self setanimrestart(str_vh_anim);
  }
}

set_vehicleriders_bundle(str_bundlename) {
  self.vehicleriders = struct::get_script_bundle("vehicleriders", str_bundlename);
}