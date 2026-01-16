/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_inventory.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_utility;
#namespace zm_island_inventory;

function init() {
  clientfield::register("clientuimodel", "zmInventory.widget_bucket_parts", 9000, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "bucket_held", 9000, getminbitcountfornum(2), "int", & zm_utility::setinventoryuimodels, 0, 0);
  clientfield::register("toplayer", "bucket_bucket_type", 9000, getminbitcountfornum(2), "int", & zm_utility::setinventoryuimodels, 0, 0);
  clientfield::register("toplayer", "bucket_bucket_water_type", 9000, getminbitcountfornum(3), "int", & zm_utility::setinventoryuimodels, 0, 1);
  clientfield::register("toplayer", "bucket_bucket_water_level", 9000, getminbitcountfornum(3), "int", & zm_utility::setinventoryuimodels, 0, 1);
  clientfield::register("clientuimodel", "zmInventory.widget_skull_parts", 9000, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "skull_skull_state", 9000, getminbitcountfornum(3), "int", & zm_utility::setinventoryuimodels, 0, 1);
  clientfield::register("toplayer", "skull_skull_type", 9000, getminbitcountfornum(3), "int", & zm_utility::setinventoryuimodels, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_gasmask_parts", 9000, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "gaskmask_part_visor", 9000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("toplayer", "gaskmask_part_strap", 9000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("toplayer", "gaskmask_part_filter", 9000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.gaskmask_gasmask_active", 9000, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "gaskmask_gasmask_progress", 9000, getminbitcountfornum(10), "int", & function_67b53ed4, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_machinetools_parts", 9000, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "valveone_part_lever", 9000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("toplayer", "valvetwo_part_lever", 9000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("toplayer", "valvethree_part_lever", 9000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("clientuimodel", "zmInventory.widget_wonderweapon_parts", 9000, 1, "int", undefined, 0, 0);
  clientfield::register("toplayer", "wonderweapon_part_wwi", 9000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("toplayer", "wonderweapon_part_wwii", 9000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
  clientfield::register("toplayer", "wonderweapon_part_wwiii", 9000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0, 0);
}

function main() {}

function function_67b53ed4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isdefined(self.var_b6689566)) {
    self.var_b6689566 = createuimodel(getuimodelforcontroller(localclientnum), "zmInventory.gaskmask_gasmask_progress");
  }
  self.var_7d73c1cd = newval / 10;
  self.var_7d73c1cd = math::clamp(self.var_7d73c1cd, 0, 1);
  if(isdefined(self.var_b6689566)) {
    if(self.var_7d73c1cd == 1) {
      self.var_1abec487 = 0;
      self thread function_63119d2(self.var_b6689566, self.var_1abec487, self.var_7d73c1cd);
      self.var_1abec487 = self.var_7d73c1cd;
    } else {
      if(!isdefined(self.var_1abec487)) {
        self.var_1abec487 = self.var_7d73c1cd + 0.1;
      }
      self thread function_63119d2(self.var_b6689566, self.var_1abec487, self.var_7d73c1cd);
      self.var_1abec487 = self.var_7d73c1cd;
    }
  }
}

function function_63119d2(var_1b778cf0, var_6e653641, n_new_value) {
  self endon("death");
  self notify("hash_63119d2");
  self endon("hash_63119d2");
  n_start_time = getrealtime();
  var_1c9f31e1 = 0;
  while (var_1c9f31e1 <= 1) {
    var_1c9f31e1 = (getrealtime() - n_start_time) / 1000;
    var_9b20c5f5 = lerpfloat(var_6e653641, n_new_value, var_1c9f31e1);
    setuimodelvalue(var_1b778cf0, var_9b20c5f5);
    wait(0.016);
  }
}