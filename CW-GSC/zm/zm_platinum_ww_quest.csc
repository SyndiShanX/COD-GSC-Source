/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_platinum_ww_quest.csc
***********************************************/

#using script_3461e14083d6d41b;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_ping;
#namespace zm_platinum_ww_quest;

function init() {
  clientfield::register("toplayer", "" + # "hash_548794e256c5bad6", 24000, 1, "int", &function_3cc5163a, 0, 0);
  function_f8a8ff3f();
  zm_ping::function_5ae4a10c("p7_lockers_metal_tall_01", "black_light_locker", #"hash_278d26f49cc82f87", undefined, #"ui_icon_minimap_pointofinterest", 1, -20);
}

function function_3cc5163a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_498c6118 = getent(fieldname, "black_light_mdl", "targetname");

  if(bwasdemojump == 0) {
    var_498c6118 show();
    return;
  }

  var_498c6118 hide();
}