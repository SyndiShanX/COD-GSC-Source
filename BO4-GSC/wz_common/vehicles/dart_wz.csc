/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\vehicles\dart_wz.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\filter_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;

#namespace dart_wz;

autoexec __init__system__() {
  system::register(#"dart_wz", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "dart_wz_out_of_circle", 24000, 5, "int", &function_a94aaca4, 0, 0);
  clientfield::register("toplayer", "dart_wz_static_postfx", 24000, 1, "int", &function_2d1ff9c7, 0, 0);
  clientfield::register("vehicle", "dart_wz_timeout_beep", 24000, 1, "int", &timeout_beep, 0, 0);
}

function_a94aaca4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    if(isDefined(self.var_2d39c392) && self.var_2d39c392) {
      filter::disable_filter_vehicle_hijack_oor(self, 0);
      self.var_2d39c392 = undefined;
    }
  }
}

function_2d1ff9c7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread dart_static_postfx(localclientnum);
    return;
  }

  self notify(#"hash_16c59bda348653cd");

  if(isDefined(self.var_ed19a23) && self.var_ed19a23) {
    filter::disable_filter_vehicle_hijack_oor(self, 0);
    function_32a729d9(localclientnum, 0);
    self.var_ed19a23 = undefined;
  }
}

private function_32a729d9(localclientnum, value) {
  model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.outOfRange");

  if(isDefined(model)) {
    setuimodelvalue(model, value);
  }
}

private dart_static_postfx(localclientnum) {
  self notify("3edfd3cf94760371");
  self endon("3edfd3cf94760371");
  self endon(#"death", #"exit_vehicle", #"hash_16c59bda348653cd");

  while(true) {
    vehicle = getplayervehicle(self);

    if(isDefined(vehicle)) {
      break;
    }

    waitframe(1);
  }

  vehicle endon(#"death");
  filter::init_filter_vehicle_hijack_oor(self);

  while(true) {
    var_e96a9222 = self clientfield::get_to_player("dart_wz_out_of_circle") / 31;
    var_2a1bc201 = distance(self.origin, vehicle.origin);

    if(1 && var_2a1bc201 < 7000 && var_e96a9222 <= 0) {
      if(isDefined(self.var_ed19a23) && self.var_ed19a23) {
        filter::disable_filter_vehicle_hijack_oor(self, 0);
        function_32a729d9(localclientnum, 0);
        self.var_ed19a23 = undefined;
      }
    } else {
      staticamount = mapfloat(7000, 8000, 0, 1, var_2a1bc201);
      staticamount = max(staticamount, var_e96a9222);

      if(!(isDefined(self.var_ed19a23) && self.var_ed19a23)) {
        filter::enable_filter_vehicle_hijack_oor(self, 0);
        function_32a729d9(localclientnum, 1);
        self.var_ed19a23 = 1;
      }

      filter::set_filter_vehicle_hijack_oor_amount(self, 0, staticamount);
    }

    waitframe(1);
  }
}

timeout_beep(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify(#"timeout_beep");

  if(!newval) {
    return;
  }

  self endon(#"death", #"exit_vehicle", #"timeout_beep");
  interval = 1;
  time = gettime();
  var_ff8d278a = time + 30000 - 4000;

  while(true) {
    var_91e09a3a = 1;
    driver = self getlocalclientdriver();

    if(isDefined(driver)) {
      self playSound(localclientnum, "veh_dart_timer_alert");
    }

    if(gettime() >= var_ff8d278a) {
      interval = 0.133;
    }

    util::server_wait(localclientnum, interval);
    interval = math::clamp(interval / 1.17, 0.1, 1);
  }
}