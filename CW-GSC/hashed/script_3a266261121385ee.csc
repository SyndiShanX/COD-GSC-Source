/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3a266261121385ee.csc
***********************************************/

#using script_49d63131b6de89a1;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\util_shared;
#namespace namespace_b574e135;

function init() {
  var_a91808c6 = array("lgt_env_power_on");
  var_18e68ce9 = array("lgt_env_power_on", "fxexp_env_flare_01", "fxexp_env_flare_02", "fxexp_env_flare_underground");
  var_f81ee838 = array("fxexp_light_moths", "fxexp_light_moths_underground");
  namespace_cf4aa5f0::function_6dbaba52("default", undefined, undefined, var_a91808c6, undefined);
  namespace_cf4aa5f0::function_6dbaba52("power_on", var_18e68ce9, undefined, undefined, undefined, &power_on);
  namespace_cf4aa5f0::function_6dbaba52("power_on_immediate", undefined, var_18e68ce9, undefined, undefined);
  namespace_cf4aa5f0::function_6dbaba52("train_warning_light_south_on", "lgt_env_train_warning_south", undefined, undefined, undefined);
  namespace_cf4aa5f0::function_6dbaba52("train_warning_light_south_off", undefined, undefined, "lgt_env_train_warning_south", undefined);
  namespace_cf4aa5f0::function_6dbaba52("train_warning_light_north_on", "lgt_env_train_warning_north", undefined, undefined, undefined);
  namespace_cf4aa5f0::function_6dbaba52("train_warning_light_north_off", undefined, undefined, "lgt_env_train_warning_north", undefined);
  namespace_cf4aa5f0::function_6dbaba52("bunny_club_window_light_on_1", "lgt_env_bunny_club_window_1", undefined, undefined, undefined);
  namespace_cf4aa5f0::function_6dbaba52("bunny_club_window_light_on_2", "lgt_env_bunny_club_window_2", undefined, undefined, undefined);
  namespace_cf4aa5f0::function_6dbaba52("bunny_club_window_light_on_3", "lgt_env_bunny_club_window_3", undefined, undefined, undefined);
  namespace_cf4aa5f0::function_6dbaba52("bunny_club_window_light_on_4", "lgt_env_bunny_club_window_4", undefined, undefined, undefined);
  namespace_cf4aa5f0::function_6dbaba52("bunny_club_window_light_on_5", "lgt_env_bunny_club_window_5", undefined, undefined, undefined);
  namespace_cf4aa5f0::function_6dbaba52("bunny_club_window_light_on_6", "lgt_env_bunny_club_window_6", undefined, undefined, undefined);
  namespace_cf4aa5f0::function_6dbaba52("bunny_battle_light_off", undefined, undefined, undefined, ["lgt_bny_club_stage", "lgt_bny_club_booth", "lgt_bny_club_ball", "lgt_bny_club_env", "lgt_bny_club_slow"]);
  namespace_cf4aa5f0::function_6dbaba52("bunny_battle_light_booth", ["lgt_bny_club_booth", "lgt_bny_club_env", "lgt_bny_club_slow"], undefined, "lgt_bny_club_ball", undefined);
  namespace_cf4aa5f0::function_6dbaba52("bunny_battle_light_ball", "lgt_bny_club_ball", undefined, ["lgt_bny_club_booth", "lgt_bny_club_slow"], undefined);
  namespace_cf4aa5f0::function_6dbaba52("bunny_battle_light_stage", ["lgt_bny_club_stage", "lgt_bny_club_env", "lgt_bny_club_slow"], undefined, ["lgt_bny_club_ball", "lgt_bny_club_booth"], undefined);
  namespace_cf4aa5f0::function_6dbaba52("failed_open_power_light_on", "lgt_env_fail_power_on", undefined, undefined, undefined);
  namespace_cf4aa5f0::function_6dbaba52("failed_open_power_light_off", undefined, undefined, "lgt_env_fail_power_on", undefined);
  namespace_cf4aa5f0::function_6dbaba52("lgt_env_fx_moths_on", var_f81ee838, undefined, undefined, undefined);
  clientfield::register("world", "" + # "hash_11f590eba265ab9e", 24000, 4, "int", &function_95a3fa7e, 1, 0);
  clientfield::register("world", "" + # "hash_3227b9d6476c5f3b", 24000, 1, "int", &function_7573534c, 1, 0);
  clientfield::register("world", "" + # "hash_5d84af8c16684d61", 24000, 1, "int", &function_96d7a08a, 1, 0);
  clientfield::register("world", "" + # "hash_17dd998c0d1ddef9", 24000, 2, "int", &function_3cbd013d, 1, 0);
  clientfield::register("world", "" + # "hash_6e50c5223648d97", 24000, 1, "int", &function_9a13661b, 1, 0);
  clientfield::register("world", "" + # "hash_2c8008207dc4c591", 24000, 1, "int", &function_5423fcc2, 1, 0);
}

function function_dcf22669() {
  namespace_cf4aa5f0::function_470d684a("default");

  if(level clientfield::get("zombie_power_on")) {
    namespace_cf4aa5f0::function_470d684a("power_on_immediate");
    return;
  }

  namespace_cf4aa5f0::function_470d684a("power_on");
}

function private power_on() {
  level waittill(#"power_on");

  iprintlnbold("<dev string:x38>");
}

function function_95a3fa7e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 1:
      namespace_cf4aa5f0::function_470d684a("bunny_club_window_light_on_1");
      break;
    case 2:
      namespace_cf4aa5f0::function_470d684a("bunny_club_window_light_on_2");
      break;
    case 3:
      namespace_cf4aa5f0::function_470d684a("bunny_club_window_light_on_3");
      break;
    case 4:
      namespace_cf4aa5f0::function_470d684a("bunny_club_window_light_on_4");
      break;
    case 5:
      namespace_cf4aa5f0::function_470d684a("bunny_club_window_light_on_5");
      break;
    case 6:
      namespace_cf4aa5f0::function_470d684a("bunny_club_window_light_on_6");
      break;
  }
}

function function_7573534c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 0:
      namespace_cf4aa5f0::function_470d684a("train_warning_light_south_off");
      break;
    case 1:
      namespace_cf4aa5f0::function_470d684a("train_warning_light_south_on");
      break;
  }
}

function function_96d7a08a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 0:
      namespace_cf4aa5f0::function_470d684a("train_warning_light_north_off");
      break;
    case 1:
      namespace_cf4aa5f0::function_470d684a("train_warning_light_north_on");
      break;
  }
}

function function_3cbd013d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 0:
      namespace_cf4aa5f0::function_470d684a("bunny_battle_light_off");
      break;
    case 1:
      namespace_cf4aa5f0::function_470d684a("bunny_battle_light_booth");
      break;
    case 2:
      namespace_cf4aa5f0::function_470d684a("bunny_battle_light_ball");
      break;
    case 3:
      namespace_cf4aa5f0::function_470d684a("bunny_battle_light_stage");
      break;
  }
}

function function_9a13661b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 0:
      namespace_cf4aa5f0::function_470d684a("failed_open_power_light_off");
      break;
    case 1:
      namespace_cf4aa5f0::function_470d684a("failed_open_power_light_on");
      break;
  }
}

function function_5423fcc2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    namespace_cf4aa5f0::function_470d684a("lgt_env_fx_moths_on");
  }
}