/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_616d0f01498f9128.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace namespace_1d4ee4f8;

function preload() {
  clientfield::register("toplayer", "optional_objective_camera_fx", 1, 1, "int", &optional_objective_camera_fx, 0, 0);
  clientfield::register("toplayer", "set_sun_color_black", 1, 1, "int", &function_1f548758, 0, 0);
}

function postload() {
  level._effect[#"hash_57ee68985468f554"] = # "wz/fx8_plyr_pstfx_numbers";
}

function optional_objective_camera_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_dcb8af99)) {
    stopfx(fieldname, self.var_dcb8af99);
    self.var_d392b4d1 = undefined;
  }

  if(bwastimejump) {
    self.var_dcb8af99 = playfxoncamera(fieldname, level._effect[#"hash_57ee68985468f554"], undefined, (1, 0, 0), (0, 0, 1));
  }
}

function function_1f548758(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    util::function_8d617b62((0, 0, 0), 12.5);
    return;
  }

  util::function_5ff170ee();
}