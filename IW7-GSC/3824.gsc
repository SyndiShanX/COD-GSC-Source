/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3824.gsc
**************************************/

_id_FD9F() {
  _id_FD76();
}

_id_FDA0() {
  level thread _id_FD75("navigation");
  level thread _id_FD75("systems");
  level thread _id_FD75("tactical");
}

_id_FD6D() {
  level notify("stop_group_idle_controller");
  level notify("stop_ftl_group_vignette_controller");
}

pause_group_vignettes() {
  if(scripts\engine\utility::flag_exist("hold_group_vignettes")) {
    scripts\engine\utility::flag_set("hold_group_vignettes");
  }
}

release_group_vignettes() {
  if(scripts\engine\utility::flag_exist("hold_group_vignettes")) {
    scripts\engine\utility::flag_clear("hold_group_vignettes");
  }
}

_id_FD75(var_0, var_1) {
  level endon("stop_group_idle_controller");

  if(!isDefined(var_1)) {
    var_1 = level._id_C6AA["retribution"]._id_EF67;
  }

  switch (var_0) {
    case "navigation":
      var_2 = [level._id_3014, level._id_3015, level._id_3016];
      var_3 = ["casual_vignette_1", "casual_vignette_2", "casual_vignette_3"];
      var_1 thread scripts\sp\interaction::_id_DC7F(var_2, 15.0, var_3);
      var_1 thread _id_10FFF(var_2);
      break;
    case "tactical":
      var_2 = [level._id_30C0, level._id_30C1, level._id_30C4];
      var_3 = ["casual_vignette_1", "casual_vignette_2", "casual_vignette_3"];
      var_1 thread scripts\sp\interaction::_id_DC7F(var_2, 10.0, var_3);
      var_1 thread _id_11368(var_2);
      break;
    case "systems":
      var_2 = [level._id_30B9, level._id_30BB];
      var_3 = ["casual_vignette_1", "casual_vignette_2", "casual_vignette_3"];
      var_1 thread scripts\sp\interaction::_id_DC7F(var_2, 12.0, var_3);
      var_1 thread _id_11368(var_2);
      break;
  }
}

_id_10FFF(var_0) {
  level endon("stop_ftl_group_vignette_controller");
  level waittill("ftl triggered");
  var_1 = _id_7A82();
  var_2 = 0;
  level scripts\engine\utility::waittill_any("ftl_start", "ftl_prep", "start_group_vignette");

  if(isDefined(var_1)) {
    foreach(var_4 in var_0) {
      var_4 scripts\sp\interaction_manager::_id_11048();
      thread scripts\sp\anim::_id_1F35(var_4, var_1);
      var_2 = getanimlength(var_4 scripts\sp\utility::_id_7DC1(var_1));
      var_4 scripts\engine\utility::delaythread(var_2, scripts\sp\interaction_manager::_id_CE40, "standing_console", undefined, "alert");
    }

    wait(var_2);
  } else {
    self notify("stop_group_idle_controller");
    level waittill("ftl_finished");

    foreach(var_7 in var_0) {
      var_7 thread scripts\sp\interaction_manager::_id_F566("alert");
    }
  }
}

_id_D902() {
  wait 2.0;
  var_0 = [level._id_3014, level._id_3015, level._id_3016];
  var_1 = level._id_C6AA["retribution"]._id_EF67;

  foreach(var_3 in var_0) {
    iprintln("Guy " + var_3._id_1FBB + " position is " + (var_3.origin - var_1.origin));
    iprintln("Guy " + var_3._id_1FBB + " angle is is " + var_3.angles);
  }
}

_id_11368(var_0) {
  level endon("stop_ftl_group_vignette_controller");
  level scripts\engine\utility::waittill_any("ftl triggered", "ftl_start", "ftl_prep", "start_group_vignette");
  self notify("stop_group_idle_controller");
  level waittill("ftl_finished");

  foreach(var_2 in var_0) {
    var_2._id_383A = 1;
    var_2 thread scripts\sp\interaction_manager::_id_F566("alert");
  }
}

_id_7A82() {
  var_0 = level.script;
  var_1 = undefined;

  switch (var_0) {
    case "shipcrib_europa":
      break;
    case "shipcrib_titan":
      var_1 = "ftl_sequence_titan";
      break;
    case "gravity":
      break;
    case "shipcrib_rogue":
      var_1 = "ftl_sequence_rogue";
      break;
    case "shipcrib_prisoner":
      var_1 = "ftl_sequence_prisoner";
      break;
    case "shipcrib_moon":
      var_1 = "ftl_sequence_moon";
      break;
  }

  return var_1;
}

#using_animtree("generic_human");

_id_FD76() {
  level._id_EC85["ftl1"]["casual_vignette_1"] = % shipcrib_bridge_ftl_guy1_vig_idle01;
  level._id_EC85["ftl2"]["casual_vignette_1"] = % shipcrib_bridge_ftl_guy2_vig_idle01;
  level._id_EC85["ftl3"]["casual_vignette_1"] = % shipcrib_bridge_ftl_guy3_vig_idle01;
  level._id_EC85["ftl1"]["casual_vignette_2"] = % shipcrib_bridge_ftl_guy1_vig_idle02;
  level._id_EC85["ftl2"]["casual_vignette_2"] = % shipcrib_bridge_ftl_guy2_vig_idle02;
  level._id_EC85["ftl3"]["casual_vignette_2"] = % shipcrib_bridge_ftl_guy3_vig_idle02;
  level._id_EC85["ftl1"]["casual_vignette_3"] = % shipcrib_bridge_ftl_guy1_vig_idle03;
  level._id_EC85["ftl2"]["casual_vignette_3"] = % shipcrib_bridge_ftl_guy2_vig_idle03;
  level._id_EC85["ftl3"]["casual_vignette_3"] = % shipcrib_bridge_ftl_guy3_vig_idle03;
  level._id_EC85["tac1"]["casual_vignette_1"] = % shipcrib_bridge_tac_guy1_vig_idle01;
  level._id_EC85["tac2"]["casual_vignette_1"] = % shipcrib_bridge_tac_guy2_vig_idle01;
  level._id_EC85["tac4"]["casual_vignette_1"] = % shipcrib_bridge_tac_guy3_vig_idle01;
  level._id_EC85["tac1"]["casual_vignette_2"] = % shipcrib_bridge_tac_guy1_vig_idle02;
  level._id_EC85["tac2"]["casual_vignette_2"] = % shipcrib_bridge_tac_guy2_vig_idle02;
  level._id_EC85["tac4"]["casual_vignette_2"] = % shipcrib_bridge_tac_guy3_vig_idle02;
  level._id_EC85["tac1"]["casual_vignette_3"] = % shipcrib_bridge_tac_guy1_vig_idle03;
  level._id_EC85["tac2"]["casual_vignette_3"] = % shipcrib_bridge_tac_guy2_vig_idle03;
  level._id_EC85["tac4"]["casual_vignette_3"] = % shipcrib_bridge_tac_guy3_vig_idle03;
  level._id_EC85["sys1"]["casual_vignette_1"] = % shipcrib_bridge_sys_guy01_vig_idle01;
  level._id_EC85["sys2"]["casual_vignette_1"] = % shipcrib_bridge_sys_guy02_vig_idle01;
  level._id_EC85["sys1"]["casual_vignette_2"] = % shipcrib_bridge_sys_guy01_vig_idle02;
  level._id_EC85["sys2"]["casual_vignette_2"] = % shipcrib_bridge_sys_guy02_vig_idle02;
  level._id_EC85["sys1"]["casual_vignette_3"] = % shipcrib_bridge_sys_guy01_vig_idle03;
  level._id_EC85["sys2"]["casual_vignette_3"] = % shipcrib_bridge_sys_guy02_vig_idle03;
  level._id_EC85["ftl1"]["ftl_sequence_europa"] = % sh4_2_3_sh_ttn_br_ops_ally01_ftl_drop;
  level._id_EC85["ftl2"]["ftl_sequence_europa"] = % sh4_2_3_sh_ttn_br_ops_ally02_ftl_drop;
  level._id_EC85["ftl3"]["ftl_sequence_europa"] = % sh4_2_3_sh_ttn_br_ops_ally03_ftl_drop;
  level._id_EC85["ftl1"]["ftl_sequence_titan"] = % sh4_2_3_sh_ttn_br_ops_ally01_ftl_drop;
  level._id_EC85["ftl2"]["ftl_sequence_titan"] = % sh4_2_3_sh_ttn_br_ops_ally02_ftl_drop;
  level._id_EC85["ftl3"]["ftl_sequence_titan"] = % sh4_2_3_sh_ttn_br_ops_ally03_ftl_drop;
  level._id_EC85["ftl1"]["ftl_sequence_gravity"] = % sh4_2_3_sh_ttn_br_ops_ally01_ftl_drop;
  level._id_EC85["ftl2"]["ftl_sequence_gravity"] = % sh4_2_3_sh_ttn_br_ops_ally02_ftl_drop;
  level._id_EC85["ftl3"]["ftl_sequence_gravity"] = % sh4_2_3_sh_ttn_br_ops_ally03_ftl_drop;
  level._id_EC85["ftl1"]["ftl_sequence_rogue"] = % sh6_13_ra_jump_ally01_ftl_drop;
  level._id_EC85["ftl2"]["ftl_sequence_rogue"] = % sh6_13_ra_jump_ally02_ftl_drop;
  level._id_EC85["ftl3"]["ftl_sequence_rogue"] = % sh6_13_ra_jump_ally03_ftl_drop;
  level._id_EC85["ftl1"]["ftl_sequence_prisoner"] = % sh_pri_7_12_jump_ally01_ftl_drop;
  level._id_EC85["ftl2"]["ftl_sequence_prisoner"] = % sh_pri_7_12_jump_ally02_ftl_drop;
  level._id_EC85["ftl3"]["ftl_sequence_prisoner"] = % sh_pri_7_12_jump_ally03_ftl_drop;
  level._id_EC85["ftl1"]["ftl_sequence_moon"] = % sh_mn_1_12_moon_jump_ally01_ftl_drop;
  level._id_EC85["ftl2"]["ftl_sequence_moon"] = % sh_mn_1_12_moon_jump_ally02_ftl_drop;
  level._id_EC85["ftl3"]["ftl_sequence_moon"] = % sh_mn_1_12_moon_jump_ally03_ftl_drop;
}