/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_cart.gsc
******************************************************/

main() {
  level._id_2DA8 = 0;
  level._id_2DA9 = 0;
  level._id_305F = 0;
  common_scripts\utility::flag_init("flag_ww_part_01_picked_up");
  common_scripts\utility::flag_init("flag_ww_part_02_picked_up");
  common_scripts\utility::flag_init("flag_ww_part_01_placed");
  common_scripts\utility::flag_init("flag_ww_part_02_placed");
  common_scripts\utility::flag_init("flag_ww_forged");
  common_scripts\utility::flag_init("flag_workbench_found");
  common_scripts\utility::flag_init("flag_cart_reached_end");
  common_scripts\utility::flag_init("flag_cart_req_1_met");
  common_scripts\utility::flag_init("flag_cart_req_2_met");
  common_scripts\utility::flag_init("flag_cart_req_3_met");
  _id_0557::_id_7846("4 cart", ::_id_2020, ["3 shard"], &"ZOMBIE_NEST_HINT_QUEST_CART", "ZOMBIE_NEST_HINT_QUEST_CART");
  _id_0557::_id_781E("4 cart", "press button", ::_id_7865, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_START_ASSEMBLY");
  _id_0557::_id_781E("4 cart", "head to rnd", ::_id_7859, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_ESCORT_CLAW");
  _id_0557::_id_781E("4 cart", "pickup ww frame", ::_id_7863, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_PICKUP_WW_PART_1");
  _id_0557::_id_781E("4 cart", "rewind from rnd", ::_id_7869, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_ESCORT_CLAW");
  _id_0557::_id_781E("4 cart", "head to med", ::_id_7858, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_ESCORT_CLAW");
  _id_0557::_id_781E("4 cart", "pickup ww core", ::_id_7864, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_PICKUP_WW_PART_2");
  _id_0557::_id_781E("4 cart", "rewind from med", ::_id_7868, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_ESCORT_CLAW");
  _id_0557::_id_781E("4 cart", "head to com", ::_id_7857, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_ESCORT_CLAW");
  _id_0557::_id_781E("4 cart", "assemble ww", ::_id_784A, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_ENERGIZE_WW");
  _id_0557::_id_7848("4 cart");
  _id_52DE();
}

_id_7865() {
  level._id_3571._id_692A = 1;
  level._id_3571._id_5787 = 0;
  var_0 = common_scripts\utility::_id_46B5("cart_align_node", "targetname");
  level._id_3571._id_0BBE = var_0;
  thread _id_9033();
  thread _id_0378::_id_8D74("aud_cart_lights_off");
  level thread _id_A0EF(level._id_3573, 0);
  common_scripts\utility::flag_set("flag_bunker_lights_off");
  _id_0378::_id_8D74("aud_bunker_lights", "off");
  wait 4;
  var_1 = level._id_64C7;
  var_2 = undefined;

  if(1) {
    if(isDefined(var_1._id_2590))
      var_2 = _id_0557::_id_782F(undefined, var_1._id_2590);
    else
      var_2 = _id_0557::_id_782F(undefined, var_1._id_1DD3);

    _id_0557::_id_781D("4 cart", var_2);
  }

  var_1._id_92A1 common_scripts\utility::_id_9DA3();
  var_1._id_92A1 sethintstring(&"ZOMBIE_NEST_MOVE_SHROUD");
  var_1._id_1DD3 showpart("TAG_LIGHT_GREEN");
  var_1._id_1DD3 hidepart("TAG_LIGHT_RED");

  foreach(var_4 in var_1._id_5D20)
  var_4 setscriptablepartstate("light", "green");

  var_1._id_92A1 waittill("trigger", var_6);
  var_1 thread _id_64A0();

  if(1)
    _id_0557::_id_7847("4 cart", var_2);

  var_1._id_92A1 common_scripts\utility::_id_9D9F();
  _id_0557::_id_782D("4 cart", "press button");
}

_id_7859() {
  if(1) {
    var_0 = _id_0557::_id_782F(undefined, level._id_3571);
    level._id_3571._id_68C1 = var_0;
    _id_0557::_id_781D("4 cart", var_0, 0);
  }

  thread _id_2E7B();
  _id_2023("rnd");
  _id_0557::_id_782D("4 cart", "head to rnd");
}

_id_7863() {
  if(1) {
    var_0 = _getent("ww_part_01_model", "targetname");
    var_1 = _id_0557::_id_782F(undefined, var_0);
    _id_0557::_id_781D("4 cart", var_1);
  }

  level._id_3E3B._id_4D91 = _id_0559::_id_7BE3(level._id_3E3B._id_6FC5, "tesla_barrel");
  var_2 = level._id_3E3B maps\mp\mp_zombie_nest_ee_util::_id_8BEC();
  level._id_3E3B._id_4D91._id_2F74 = 1;
  common_scripts\utility::flag_set("flag_ww_part_01_picked_up");
  var_2 _id_2EBE(1);
  _id_0557::_id_782D("4 cart", "pickup ww frame");
}

_id_7869() {
  _id_0378::_id_8D74("aud_claw_move_start", level._id_3571);
  level._id_3571 _id_202D("rnd_5");
  _id_0557::_id_782D("4 cart", "rewind from rnd");
}

_id_7858() {
  _id_2023("med");
  _id_0557::_id_782D("4 cart", "head to med");
}

_id_7864() {
  if(1) {
    var_0 = _getent("ww_part_02_model", "targetname");
    var_1 = _id_0557::_id_782F(undefined, var_0);
    _id_0557::_id_781D("4 cart", var_1);
  }

  level._id_5981._id_4D91 = _id_0559::_id_7BE3(level._id_5981._id_6FC5, "tesla_core");
  var_2 = level._id_5981 maps\mp\mp_zombie_nest_ee_util::_id_8BEC();
  level._id_5981._id_4D91._id_2F74 = 1;
  common_scripts\utility::flag_set("flag_ww_part_02_picked_up");
  var_2 _id_2EBE(2);
  _id_0557::_id_782D("4 cart", "pickup ww core");
}

_id_7868() {
  _id_0378::_id_8D74("aud_claw_move_start", level._id_3571);
  level._id_3571 _id_202D("med_5");
  _id_0557::_id_782D("4 cart", "rewind from med");
}

_id_7857() {
  level._id_3571 _id_202D("com_1");
  _id_0378::_id_8D74("aud_claw_move_stop", level._id_3571);
  common_scripts\utility::flag_set("flag_cart_reached_end");
  level thread _id_A0EF(level._id_3573, 1);
  common_scripts\utility::_id_3C7B("flag_bunker_lights_off");
  level._id_6F18 = 0;
  _id_0378::_id_8D74("aud_bunker_lights", "on");

  if(1)
    _id_0557::_id_7847("4 cart", level._id_3571._id_68C1);

  _id_0557::_id_782D("4 cart", "head to com");
}

_id_784A() {
  if(0) {
    var_0 = _id_0557::_id_782F(undefined, level._id_AA67._id_48F2);
    _id_0557::_id_781D("4 cart", var_0);
  }

  common_scripts\utility::_id_3C9F("flag_ww_forged");
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("geistcraft_device_powered");

  foreach(var_2 in level.players)
  var_2 thread _id_2EB1();

  _id_0557::_id_782D("4 cart", "assemble ww");
}

_id_2020() {
  foreach(var_1 in level.players)
  var_1 _id_054C::_id_AC23("escortclaw");
}

#using_animtree("animated_props_zombies");

_id_52DE() {
  maps\mp\mp_zombie_nest_ee_util::_id_8A53();
  maps\mp\mp_zombie_nest_ee_workbench::_id_536B();
  thread _id_2EAD();
  level._id_3571 = _getent("ee_shard", "targetname");
  level._id_3571._id_9B8C = [];
  level._id_3571._id_9B8C["rnd_1"] = % s2_zom_shroud_rd_track_1;
  level._id_3571._id_9B8C["rnd_2"] = % s2_zom_shroud_rd_track_2;
  level._id_3571._id_9B8C["rnd_3"] = % s2_zom_shroud_rd_track_3;
  level._id_3571._id_9B8C["rnd_4"] = % s2_zom_shroud_rd_track_4;
  level._id_3571._id_9B8C["rnd_5"] = % s2_zom_shroud_rd_track_5;
  level._id_3571._id_9B8C["med_1"] = % s2_zom_shroud_med_track_1;
  level._id_3571._id_9B8C["med_2"] = % s2_zom_shroud_med_track_2;
  level._id_3571._id_9B8C["med_3"] = % s2_zom_shroud_med_track_3;
  level._id_3571._id_9B8C["med_4"] = % s2_zom_shroud_med_track_4;
  level._id_3571._id_9B8C["med_5"] = % s2_zom_shroud_med_track_5;
  level._id_3571._id_9B8C["com_1"] = % s2_zom_shroud_control_track_1;
  level._id_3571._id_9B8C["com_2"] = % s2_zom_shroud_workbench_activate;
  level._id_3573 = [];
  var_0 = _id_8A2B("light_zm_objective", "light_zm_puzzle", "cycle1b", "cycle1a", "puzzlelight");
  var_0 = _id_8A2B("light_zm_objective", "light_zm_puzzle_test", "cycle1b", "cycle1a", "puzzlelight");
  var_1 = _id_8A2B("beam_zm_objective", "light_zm_lgtbeam", "lightbeam", "lightbeamoff", "glow");
  level._id_3574 = _id_8A2B("light_zm_objective_med", "light_zm_puzzl_med", "flicker", "cycle1a", "puzzlelight");
  level._id_3575 = _id_8A2B("light_zm_objective_rnd", "light_zm_puzzle_test", "flicker", "lightoff", "puzzlelight");
  level._id_3573 = common_scripts\utility::_id_0F73(var_0, var_1);
  level._id_3573 = common_scripts\utility::_id_0F73(level._id_3573, level._id_3575);
  level._id_3573 = common_scripts\utility::_id_0F73(level._id_3573, level._id_3574);

  foreach(var_3 in level._id_3573) {
    var_3._id_760E = [];
    _id_A12E(var_3, "facility", 1, 0);
  }

  var_5 = spawnStruct();
  var_5._id_1DD3 = _getent("move_cart_button_model", "targetname");
  var_5._id_2590 = _getent("move_cart_button_console", "targetname");
  var_5._id_92A1 = _getent("move_shroud_trig", "targetname");
  var_5._id_92A1 sethintstring(&"ZOMBIE_NEST_OBJECTIVE_OFFLINE");
  var_5._id_1DD3 showpart("TAG_LIGHT_RED");
  var_5._id_1DD3 hidepart("TAG_LIGHT_GREEN");
  var_5._id_5D20 = _getscriptablearray("move_cart_button_light", "targetname");

  foreach(var_7 in var_5._id_5D20)
  var_7 setscriptablepartstate("light", "red");

  level._id_64C7 = var_5;
}

_id_64A0() {
  var_0 = % zmb_objective_button_02_push;
  var_1 = % zmb_objective_button_02_reverse;
  var_2 = _getanimlength(var_0);
  var_3 = _getanimlength(var_1);
  self._id_1DD3 scriptmodelplayanim("zmb_objective_button_02_push");
  self._id_1DD3 _id_0378::_id_8D74("aud_start_claw_button_press");
  wait(var_2);
  self._id_1DD3 showpart("TAG_LIGHT_RED");
  self._id_1DD3 hidepart("TAG_LIGHT_GREEN");

  foreach(var_5 in self._id_5D20)
  var_5 setscriptablepartstate("light", "red");

  wait 0.5;
  self._id_1DD3 scriptmodelplayanim("zmb_objective_button_02_reverse");
  wait(var_3);
}

_id_2023(var_0) {
  if(!isDefined(var_0))
    var_0 = "rnd";

  level._id_3571._id_7E93 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_geistkraft_radius_256"), level._id_3571, "TAG_FX");
  _triggerfx(level._id_3571._id_7E93);
  level._id_3571._id_2DA8 = 1;
  level._id_3571 thread _id_201F(var_0);

  if(var_0 == "rnd")
    _id_0378::_id_8D74("aud_claw_move_start", level._id_3571);

  level._id_3571 _id_202D(var_0 + "_1");
  _id_0378::_id_8D74("aud_claw_move_stop", level._id_3571);
  common_scripts\utility::_id_3C9F("flag_cart_req_1_met");
  _id_6AA2();
  _id_0378::_id_8D74("aud_claw_move_start", level._id_3571);
  level._id_3571 _id_202D(var_0 + "_2");
  _id_0378::_id_8D74("aud_claw_move_stop", level._id_3571);
  common_scripts\utility::_id_3C9F("flag_cart_req_2_met");
  _id_0378::_id_8D74("aud_claw_move_start", level._id_3571);
  level._id_3571 _id_202D(var_0 + "_3");
  _id_0378::_id_8D74("aud_claw_move_stop", level._id_3571);
  common_scripts\utility::_id_3C9F("flag_cart_req_3_met");
  _id_6A9F();
  _id_0378::_id_8D74("aud_claw_move_start", level._id_3571);
  level._id_3571 _id_202D(var_0 + "_4");
  _id_0378::_id_8D74("aud_claw_move_stop", level._id_3571);
  thread _id_08B9(var_0);

  if(var_0 == "rnd") {
    level waittill(var_0 + "_show_ww_part");
    level._id_3E3B._id_6FC2 show();
  }

  level waittill(var_0 + "_create_ww_part");

  if(var_0 == "rnd")
    level thread _id_A0EF(level._id_3575, 1, 0.04, 0.8);
  else if(var_0 == "med")
    level thread _id_A0EF(level._id_3574, 1, 0.05, 0.6);
}

_id_201F(var_0) {
  common_scripts\utility::_id_3C7B("flag_cart_req_1_met");
  common_scripts\utility::_id_3C7B("flag_cart_req_2_met");
  common_scripts\utility::_id_3C7B("flag_cart_req_3_met");
  level._id_3571 thread _id_91C5(5, "flag_cart_req_1_met");
  common_scripts\utility::_id_3C9F("flag_cart_req_1_met");
  level._id_3571 thread _id_91C5(5, "flag_cart_req_2_met");
  common_scripts\utility::_id_3C9F("flag_cart_req_2_met");
  level._id_3571 thread _id_91C5(5, "flag_cart_req_3_met");
}

_id_6AA2() {
  if(!common_scripts\utility::_id_562E(level._id_305F))
    thread _id_2E84();
}

_id_6A9F() {
  level._id_3571._id_2959 = 0;
  level._id_3571._id_2DA8 = 0;
  level._id_3571._id_7E93 delete();
}

_id_91C5(var_0, var_1) {
  maps\mp\mp_zombie_nest_special_event_creator::_id_170B(var_0, 250, undefined, "zmb_cart_zombie_killed", undefined, "tag_fx");
  common_scripts\utility::flag_set(var_1);
}

_id_202D(var_0) {
  switch (var_0) {
    case "med_5":
    case "rnd_5":
      break;
    case "med_4":
    case "rnd_4":
      _id_0378::_id_8D74("aud_claw_connection_forge");
    case "med_3":
    case "med_2":
    case "rnd_3":
    case "rnd_2":
      _playfxontag(level._effect["zmb_gk_claw_full"], self, "TAG_FX");
      _playfxontag(level._effect["zmb_gk_claw_battery_full_1"], self, "flap1_shroud");
      _playfxontag(level._effect["zmb_gk_claw_battery_full_2"], self, "flap2_shroud");
      _playfxontag(level._effect["zmb_gk_claw_battery_full_3"], self, "flap3_shroud");
      break;
    case "med_1":
    case "rnd_1":
      break;
  }

  var_1 = self._id_9B8C[var_0];
  var_2 = _getanimlength(var_1);
  var_3 = _debuggetanimname(var_1);
  self scriptmodelplayanimdeltamotionfrompos(var_3, self._id_0BBE.origin, self._id_0BBE.angles);
  wait(var_2);
}

_id_43E8() {
  return "flag_ww_part_02_picked_up";
}

_id_43E9() {
  return "flag_ww_part_01_picked_up";
}

_id_43E7() {
  return "flag_ww_forged";
}

_id_08B9(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "rnd":
      var_1 = maps\mp\mp_zombie_nest_ee_util::_id_08B6;
      break;
    case "med":
      var_1 = maps\mp\mp_zombie_nest_ee_util::_id_08B0;
      break;
    case "com":
      var_1 = maps\mp\mp_zombie_nest_ee_util::_id_08A8;
      break;
    default:
      break;
  }

  if(isDefined(var_1))
    [[var_1]]();
}

_id_2EBE(var_0) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == 1)
    thread _id_0367::_id_8E3C("workbenchpart3");
  else if(var_0 == 2)
    thread _id_0367::_id_8E3C("forgepart");
}

_id_2EAD() {
  level endon("flag_ww_forged");
  var_0 = _getent("ww_creation_station_dialogue", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      wait 0.5;
      continue;
    }

    common_scripts\utility::flag_set("flag_workbench_found");

    if(!isDefined(var_1._id_3077) && isPlayer(var_1)) {
      var_2 = var_1 _id_0367::_id_8E3D("workbench");

      if(isDefined(var_2))
        var_1._id_3077 = 1;
    }
  }
}

_id_2E7B() {
  level endon("flag_ww_part_01_picked_up");
  var_0 = _id_0557::_id_7838("4 cart", "head to rnd");
  var_1 = _getent("cart_dialog_trig", "targetname");
  var_1._id_0CA5 = 0;
  var_2 = level._id_3571;

  if(isDefined(var_2))
    var_1._id_5ED1 = var_2.origin;
  else
    var_1._id_5ED1 = var_1.origin;

  while(!common_scripts\utility::_id_3C77(var_0)) {
    var_1 waittill("trigger", var_3);

    if(!isPlayer(var_3)) {
      continue;
    }
    if(isDefined(var_2))
      var_1._id_5ED1 = var_2.origin;
    else
      var_1._id_5ED1 = var_1.origin;

    var_4 = var_1 _id_2025(var_3);

    if(var_4 && !isDefined(var_3._id_3060) && level._id_2DA8) {
      var_5 = var_3 _id_0367::_id_8E3D("clawmove");

      if(isDefined(var_5))
        var_3._id_3060 = 1;

      continue;
    }

    wait 0.5;
  }
}

_id_2E84() {
  foreach(var_1 in level.players) {
    if(_id_0547::_id_577E(var_1)) {
      continue;
    }
    if(distance(var_1.origin, level._id_3571.origin) < 500)
      var_1 thread _id_0367::_id_8E3C("clawmove2");
  }

  level._id_305F = 1;
}

_id_2EB1() {
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_fired", var_0);

    if(var_0 == "teslagun_zm") {
      if(!isDefined(self._id_3066)) {
        wait 1;
        var_1 = _id_0367::_id_8E3D("teslafired");

        if(isDefined(var_1)) {
          self._id_3066 = 1;
          break;
        }
      }
    }

    wait 0.5;
  }
}

_id_9033() {
  wait 6;
  var_0 = "zmb_uberschnalle_light";
  var_1 = level._id_3571 gettagorigin("TAG_FX");
  maps\mp\mp_zombie_nest_ee_util::_id_9066(level._id_3571, "TAG_FX", var_1, var_0, "flag_cart_reached_end");
}

_id_2025(var_0) {
  var_1 = self._id_5ED1 - var_0 getEye();
  var_2 = vectorNormalize((var_1[0], var_1[1], 0));
  var_3 = anglesToForward(var_0.angles);
  var_4 = vectorNormalize((var_3[0], var_3[1], 0));
  var_5 = vectordot(var_2, var_4);
  var_5 = clamp(var_5, -1, 1);
  var_6 = _acos(var_5);
  var_7 = var_6 < 60;
  return var_7;
}

_id_A0EF(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 0.05;

  if(!isDefined(var_3))
    var_3 = 0.1;

  foreach(var_5 in var_0) {
    wait(_randomfloatrange(var_2, var_3));
    _id_A12E(var_5, "facility", var_1);
  }
}

_id_8A2B(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _getscriptablearray(var_0, "targetname");

  foreach(var_7 in var_5) {
    var_7._id_760A = var_3;
    var_7._id_760B = var_2;
    var_7._id_760D = var_4;
    var_7.setclientdvar = var_1;
  }

  return var_5;
}

_id_5D7B(var_0, var_1) {
  var_2 = var_0._id_760A;

  if(var_1)
    var_2 = var_0._id_760B;

  var_0 setscriptablepartstate(var_0._id_760D, var_2, 0);
}

_id_A12E(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1;

  if(var_2 == common_scripts\utility::_id_0F79(var_0._id_760E, var_1)) {
    return;
  }
  if(var_2) {
    var_0._id_760E = common_scripts\utility::_id_0F6F(var_0._id_760E, var_1);

    if(var_0._id_760E.size == 1 && var_3)
      _id_5D7B(var_0, 1);
  } else {
    var_0._id_760E = common_scripts\utility::_id_0F93(var_0._id_760E, var_1);

    if(var_0._id_760E.size == 0 && var_3)
      _id_5D7B(var_0, 0);
  }
}