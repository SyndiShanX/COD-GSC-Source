/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_lights.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\system_shared;

#namespace zm_orange_lights;

autoexec __init__system__() {
  system::register(#"zm_orange_lights", &__init__, undefined, undefined);
}

__init__() {
  init_clientfields();
  level.var_13a6af33 = &function_619bb271;
}

init_clientfields() {
  clientfield::register("world", "ship_lights_control", 24000, 1, "int", &ship_lights_control, 0, 0);
  clientfield::register("world", "lighthouse_lights_control", 24000, 1, "int", &lighthouse_lights_control, 0, 0);
  clientfield::register("world", "facility_lights_control", 24000, 1, "int", &facility_lights_control, 0, 0);
  clientfield::register("world", "infusion_lights_hot", 24000, 1, "int", &infusion_lights_hot, 0, 0);
  clientfield::register("world", "infusion_lights_cold", 24000, 1, "int", &infusion_lights_cold, 0, 0);
  clientfield::register("world", "orange_deactivate_radiant_exploders_client", 24000, 1, "counter", &orange_deactivate_radiant_exploders_client, 0, 0);
}

ship_lights_control(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    exploder::exploder("fxexp_script_ship_power");
    exploder::exploder("fx_power_on2");
    return;
  }

  if(newval == 0) {
    exploder::stop_exploder("fxexp_script_ship_power");
    exploder::stop_exploder("fx_power_on2");
  }
}

lighthouse_lights_control(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    exploder::exploder("fxexp_script_lighthouse_interior_power");
    exploder::exploder("fxexp_script_docks_power");
    exploder::exploder("fx_power_on1");
    return;
  }

  if(newval == 0) {
    exploder::stop_exploder("fxexp_script_lighthouse_interior_power");
    exploder::exploder("fxexp_script_docks_power");
    exploder::stop_exploder("fx_power_on1");
  }
}

facility_lights_control(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    exploder::exploder("fxexp_script_facility_power_on");
    exploder::exploder("fxexp_script_facility_power_on_fx");
    exploder::exploder("fxexp_script_infusion_default");
    exploder::exploder("fxexp_script_facility_power_off");
    return;
  }

  if(newval == 0) {
    exploder::stop_exploder("fxexp_script_facility_power_on");
    exploder::stop_exploder("fxexp_script_facility_power_on_fx");
    exploder::stop_exploder("fxexp_script_infusion_default");
    exploder::stop_exploder("fxexp_script_facility_power_off");
  }
}

infusion_lights_hot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    exploder::stop_exploder("fxexp_script_infusion_default");
    exploder::exploder("fxexp_script_infusion_hot");
    return;
  }

  if(newval == 0) {
    exploder::stop_exploder("fxexp_script_infusion_hot");
    exploder::exploder("fxexp_script_infusion_default");
  }
}

infusion_lights_cold(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    exploder::stop_exploder("fxexp_script_infusion_default");
    exploder::exploder("fxexp_script_infusion_cold");
    return;
  }

  if(newval == 0) {
    exploder::stop_exploder("fxexp_script_infusion_cold");
    exploder::exploder("fxexp_script_infusion_default");
  }
}

private function_619bb271(string) {
  if(!isDefined(level.var_989f7c7c)) {
    level.var_989f7c7c = [];
  }

  array::add(level.var_989f7c7c, string, 0);
}

orange_deactivate_radiant_exploders_client(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(level.var_989f7c7c)) {
      foreach(exploder_id in level.var_989f7c7c) {
        exploder::kill_exploder(exploder_id);
        wait 0.3;
      }

      level.var_989f7c7c = undefined;
    }
  }
}