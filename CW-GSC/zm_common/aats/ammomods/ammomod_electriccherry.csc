/**************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\aats\ammomods\ammomod_electriccherry.csc
**************************************************************/

#using script_312c65d6c946308;
#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\util_shared;
#using scripts\zm_common\aats\ammomods\ammomod_deadwire;
#namespace ammomod_electriccherry;

function init_electriccherry() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  aat::register("ammomod_electriccherry", #"hash_6c2c475aa887c056", "ui_icon_zombie_ammomod_deadwire_stacked");
  clientfield::register("allplayers", "ammomod_electric_cherry_explode", 1, 1, "counter", &electric_cherry_explode, 0, 0);
}

function electric_cherry_explode(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"game_ended");
  electric_cherry_reload_fx = util::playFXOnTag(bwastimejump, "zombie/fx7_perk_electric_cherry_down", self, "tag_origin");
  wait 1;
  stopfx(bwastimejump, electric_cherry_reload_fx);
}