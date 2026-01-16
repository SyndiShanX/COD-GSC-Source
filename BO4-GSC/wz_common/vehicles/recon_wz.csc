/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\vehicles\recon_wz.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\filter_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\vehicle_shared;

#namespace recon_wz;

autoexec __init__system__() {
  system::register("recon_wz", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "recon_out_of_circle", 1, 5, "int", &function_a94aaca4, 0, 0);
  clientfield::register("toplayer", "recon_static_postfx", 1, 1, "int", &function_b53c3ad2, 0, 0);
  vehicle::add_vehicletype_callback("recon_wz", &_setup_);
}

_setup_(localclientnum) {
  self thread vehicle::boost_think(localclientnum);
}

function_a94aaca4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    if(isDefined(self.var_2d39c392) && self.var_2d39c392) {
      filter::disable_filter_vehicle_hijack_oor(self, 0);
      self.var_2d39c392 = undefined;
    }
  }
}

function_b53c3ad2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread function_d765daa4(localclientnum);
    return;
  }

  self notify(#"hash_16c59bda348653cd");

  if(isDefined(self.var_2d39c392) && self.var_2d39c392) {
    filter::disable_filter_vehicle_hijack_oor(self, 0);
    self.var_2d39c392 = undefined;
  }
}

private function_d765daa4(localclientnum) {
  self notify("214105bf7d36e37f");
  self endon("214105bf7d36e37f");
  self endon(#"death");
  self endon(#"exit_vehicle");
  self endon(#"hash_16c59bda348653cd");

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
    var_e96a9222 = self clientfield::get_to_player("recon_out_of_circle") / 31;
    var_2a1bc201 = distance(self.origin, vehicle.origin);

    if(var_2a1bc201 < 7000 && var_e96a9222 <= 0) {
      if(isDefined(self.var_2d39c392) && self.var_2d39c392) {
        filter::disable_filter_vehicle_hijack_oor(self, 0);
        self.var_2d39c392 = undefined;
      }
    } else {
      staticamount = mapfloat(7000, 8000, 0, 1, var_2a1bc201);
      staticamount = max(staticamount, var_e96a9222);

      if(!(isDefined(self.var_2d39c392) && self.var_2d39c392)) {
        filter::enable_filter_vehicle_hijack_oor(self, 0);
        self.var_2d39c392 = 1;
      }

      filter::set_filter_vehicle_hijack_oor_amount(self, 0, staticamount);
    }

    waitframe(1);
  }
}