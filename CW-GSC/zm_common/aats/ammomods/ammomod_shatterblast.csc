/************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\aats\ammomods\ammomod_shatterblast.csc
************************************************************/

#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#namespace ammomod_shatterblast;

function init_shatterblast() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  aat::register("ammomod_shatterblast", #"zmui/zm_ammomod_shatterblast", "ui_icon_zombie_ammomod_shatterblast_stacked");
  aat::register("ammomod_shatterblast_1", #"zmui/zm_ammomod_shatterblast", "ui_icon_zombie_ammomod_shatterblast_stacked");
  aat::register("ammomod_shatterblast_2", #"zmui/zm_ammomod_shatterblast", "ui_icon_zombie_ammomod_shatterblast_stacked");
  aat::register("ammomod_shatterblast_3", #"zmui/zm_ammomod_shatterblast", "ui_icon_zombie_ammomod_shatterblast_stacked");
  aat::register("ammomod_shatterblast_4", #"zmui/zm_ammomod_shatterblast", "ui_icon_zombie_ammomod_shatterblast_stacked");
  aat::register("ammomod_shatterblast_5", #"zmui/zm_ammomod_shatterblast", "ui_icon_zombie_ammomod_shatterblast_stacked");
  clientfield::register("toplayer", "ammomod_shatterblast_proc", 6000, 1, "counter", &function_d28d723d, 1, 0);
}

function function_d28d723d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playviewmodelfx(bwastimejump, #"hash_49d3b58a14ed6c92", "tag_fx1", 0);
}