/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_rus_yamantau_flashlight.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flashlight;
#namespace cp_rus_yamantau_flashlight;

function preload() {
  clientfield::register("toplayer", "cp_rus_yamantau_flashlight", 1, 2, "int", &function_70723e25, 0, 0);
  clientfield::register("actor", "set_flashlight_fx", 1, 1, "int", &set_flashlight_fx, 0, 0);
}

function postload() {
  level._effect[# "hash_2b8b4be2cb5925ab"] = # "hash_670a56e843776b6f";
}

function function_70723e25(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(isDefined(level.var_d392b4d1)) {
      stopfx(fieldname, level.var_d392b4d1);
      level.var_d392b4d1 = undefined;
    }

    n_offset = 4;

    if(bwastimejump == 2) {
      n_offset = 0;
    }

    level.var_d392b4d1 = playfxoncamera(fieldname, level._effect[# "hash_2b8b4be2cb5925ab"], (0, n_offset, 1.5), (1, 0, -0.1), (0, 0, 1));
    return;
  }

  stopfx(fieldname, level.var_d392b4d1);
  level.var_d392b4d1 = undefined;
}

function set_flashlight_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  flashlightfx = "maps/cp_rus_yamantau/fx9_yam_flashlight_ai";
  self flashlight::function_69258685(bwasdemojump, flashlightfx);
}