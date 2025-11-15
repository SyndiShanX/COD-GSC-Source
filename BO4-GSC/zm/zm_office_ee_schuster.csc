/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_office_ee_schuster.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_office_ee_schuster;

autoexec __init__system__() {
  system::register(#"zm_office_ee_schuster", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "audio_log_ball_fx", 1, 3, "int", &function_50865dc7, 0, 0);
  level._effect[#"audio_ball"] = #"hash_445f04139d92c61b";
}

function_50865dc7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_s_locs = struct::get_array("office_audio_log_schuster");

  foreach(s_loc in a_s_locs) {
    if(s_loc.var_614bfc5c + 1 == newval) {
      var_a1cf77d2 = util::spawn_model(localclientnum, "tag_origin", s_loc.origin, s_loc.angles);
      break;
    }
  }

  util::playFXOnTag(localclientnum, level._effect[#"audio_ball"], var_a1cf77d2, "tag_origin");
}