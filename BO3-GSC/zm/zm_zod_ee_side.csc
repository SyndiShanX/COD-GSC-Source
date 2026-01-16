/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_ee_side.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_zod;
#using_animtree("generic");
#namespace zm_zod_ee_side;

function autoexec __init__sytem__() {
  system::register("zm_zod_ee_side", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("world", "change_bouncingbetties", 1, 2, "int", & function_fc478037, 0, 0);
  clientfield::register("world", "lil_arnie_dance", 1, 1, "int", & lil_arnie_dance, 0, 0);
  level._effect["portal_3p"] = "zombie/fx_quest_portal_trail_zod_zmb";
  level._effect["octobomb_explode"] = "zombie/fx_octobomb_explo_death_ee_zod_zmb";
}

function function_fc478037(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 1: {
      level._effect["fx_betty_exp"] = "zombie/fx_donut_exp_zod_zmb";
      break;
    }
    case 2: {
      level._effect["fx_betty_exp"] = "zombie/fx_cake_exp_zod_zmb";
      break;
    }
  }
}

function lil_arnie_dance(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    thread function_a5b33f7(localclientnum);
  }
}

function function_a5b33f7(localclientnum) {
  scene::add_scene_func("zm_zod_lil_arnie_dance", & function_75ad5595, "play");
  level scene::play("zm_zod_lil_arnie_dance");
  s_center = struct::get("lil_arnie_stage_center");
  playfx(localclientnum, level._effect["octobomb_explode"], s_center.origin);
}

function private function_75ad5595(var_ff840495) {
  var_ff840495["arnie_tie_mdl"] setscale(0.13);
  var_ff840495["arnie_hat_mdl"] setscale(0.18);
  var_ff840495["arnie_cane_mdl"] setscale(0.08);
  foreach(var_fba08aba in var_ff840495) {
    playfx(0, level._effect["portal_3p"], var_fba08aba.origin);
  }
}