/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_fleet_data.gsc
**********************************************************/

_id_E934() {
  level thread scripts\sp\maps\sa_moon\sa_moon_util::_id_10626();
  level thread _id_0F16::_id_3E3E("fleet_start");
  level thread _id_0F16::_id_3E3D("fleet_start", undefined, 1);
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_6EF3();
  level thread _id_0F16::_id_991E(undefined, 1);
  visionsetalternate(5, 0);
  scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(1);
  level thread _id_0E4B::_id_1348D(1);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_8E92(1);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF9(0, 1);
  scripts\engine\utility::flag_set("fleet_data_checkpoint_start");
  scripts\engine\utility::flag_set("stealth_kill_done");
  scripts\sp\utility::_id_F44E(1);
}

_id_E92A() {
  level._id_E99E["server_room_exit_door"] _id_0F05::_id_AED6(0);
  level._id_6EF1 = scripts\engine\utility::getStruct("fleet_data_anim_pos", "targetname");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_6EF2();
  level.player thread _id_E932();
  level._id_6754 thread _id_E92E();
  level._id_C47F thread _id_E931();
  level._id_EA2C thread _id_E933();
  level thread _id_E935();
  level thread _id_0F16::_id_8EA3();
  level thread _id_E930();
  level thread _id_F981();
  scripts\engine\utility::flag_wait("fleet_data_downloaded");
  scripts\engine\utility::flag_wait("fleet_data_move_out");
}

_id_E932() {
  var_0 = scripts\engine\utility::getStruct("fleet_data_obj_org", "targetname");
  var_1 = [];
  var_2 = scripts\engine\utility::getStruct("fleet_data_anim_struct", "targetname");
  var_3 = scripts\sp\utility::_id_10639("player_arms");
  var_1[var_1.size] = var_3;
  var_3 hide();
  level._id_6EF1 scripts\sp\anim::_id_1EC3(var_3, "fleet_data");
  scripts\engine\utility::flag_wait("start_fleet_data_enabled");
  var_0 _id_0E46::_id_48C4(undefined, undefined, &"SA_MOON_HACK_TERMINAL", undefined, 500, 100, 1);
  var_0 waittill("trigger");
  thread scripts\sp\utility::_id_1264E("sa_moon_interior_tr");
  thread scripts\sp\utility::_id_1264E("sa_moon_elevator_tr");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_D101();
  scripts\engine\utility::flag_set("fleet_data_patch_in");
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
  var_4 = distance(level.player.origin, var_3 gettagorigin("tag_player"));
  var_5 = 64;
  var_6 = var_4 / var_5;
  level.player _meth_823C(var_3, "tag_player", var_6, var_6 * 0.5, 0.0);
  wait(var_6);
  level._id_6EF1 notify("stop_fleet_data_enter_loop");
  scripts\engine\utility::flag_set("fleet_data_patched_in");
  var_3 show();
  var_7 = scripts\sp\utility::_id_10639("keycard");
  level._id_6EF1 thread scripts\sp\anim::_id_1F2C([var_3, level._id_6754], "fleet_data");
  level._id_6EF1 thread scripts\sp\anim::_id_1F35(var_7, "fleet_data");
  var_3 waittillmatch("single anim", "start_bink");
  scripts\engine\utility::flag_set("fleet_data_bink_start");
  var_3 waittillmatch("single anim", "vo_mn_plr_solid_go");
  scripts\engine\utility::flag_set("fleet_data_player_done");
  thread _id_4270();

  if(isDefined(var_7))
    var_7 delete();

  wait 0.5;
  scripts\engine\utility::flag_set("fleet_data_player_unlinked");
  var_3 waittillmatch("single anim", "end");
  scripts\engine\utility::flag_wait("fleet_data_downloaded");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("OBJ_PLAYER_GRAPPLE", "current", &"SA_MOON_OBJ_ESCAPE");
  level.player unlink();
  var_3 delete();
  level.player enableweapons();
  level.player allowsprint(1);
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
}

_id_4270() {
  var_0 = getEnt("maintenance_hatch_02_collision", "targetname");
  var_1 = getEnt("maintenance_hatch_02_bsp", "targetname");
  var_2 = getEnt("vent_cover_model", "targetname");
  var_2.origin = var_2.tag_origin;
  var_2.angles = var_2._id_113D6;
  var_1 show();
  var_0 show();
  var_0 solid();
  var_0 disconnectPaths();
}

_id_E92E() {
  scripts\sp\utility::_id_54F7();
  scripts\sp\utility::_id_F415(0);
  scripts\sp\utility::_id_F416(0);
  scripts\sp\utility::_id_F39F();
  scripts\sp\utility::_id_61ED();
  self _meth_8250(1);
  scripts\sp\utility::_id_51E1("combat");
  self allowedstances("stand", "crouch", "prone");
  scripts\engine\utility::flag_wait("stealth_kill_done");

  if(!isDefined(level._id_9DD0)) {
    level._id_6EF1 scripts\sp\anim::_id_1F17(self, "fleet_data_enter");
    level._id_6EF1 scripts\sp\anim::_id_1F35(self, "fleet_data_enter");
    level._id_6EF1 thread scripts\sp\anim::_id_1EEA(self, "fleet_data_enter_loop", "stop_fleet_data_enter_loop");
    wait 0.05;
    scripts\engine\utility::flag_set("start_fleet_data_enabled");
    thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_6779();
    scripts\engine\utility::flag_wait("fleet_data_patched_in");
    self waittillmatch("single anim", "vo_mn_eth_already_downloaded");
    scripts\engine\utility::flag_set("fleet_data_ethan_done");
    self waittillmatch("single anim", "end");
  }

  var_0 = getnode("ethan_hero_kill_node", "targetname");

  if(isDefined(var_0.radius))
    scripts\sp\utility::_id_F3E0(var_0.radius);

  self _meth_82EE(var_0);
}

_id_E931() {
  scripts\sp\utility::_id_54F7();
  scripts\sp\utility::_id_F415(0);
  scripts\sp\utility::_id_F416(0);
  scripts\sp\utility::_id_61ED();
  scripts\sp\utility::_id_F39F();
  self _meth_8250(1);
  scripts\sp\utility::_id_51E1("cqb");
  self allowedstances("stand", "crouch", "prone");
  scripts\engine\utility::flag_wait("stealth_kill_done");
  wait 1;
  var_0 = getnode("omar_fleet_data_node_01", "targetname");
  scripts\sp\utility::_id_F3E0(var_0.radius);
  self _meth_82EE(var_0);
  self waittill("goal");
}

_id_E933() {
  scripts\sp\utility::_id_54F7();
  scripts\sp\utility::_id_F415(0);
  scripts\sp\utility::_id_F416(0);
  scripts\sp\utility::_id_61ED();
  scripts\sp\utility::_id_F39F();
  self _meth_8250(1);
  scripts\sp\utility::_id_51E1("cqb");
  self allowedstances("stand", "crouch", "prone");
  scripts\engine\utility::flag_wait("stealth_kill_done");
  wait 2;
  var_0 = getnode("salter_fleet_data_node_01", "targetname");
  scripts\sp\utility::_id_F3E0(var_0.radius);
  self _meth_82EE(var_0);
  self waittill("goal");
}

_id_E935() {
  if(isDefined(level._id_9DD0)) {
    wait 1.0;
    level._id_6754 scripts\sp\utility::_id_10346("mn_eth_secondary_down");
    scripts\engine\utility::flag_set("fleet_data_downloaded");
    wait 2.5;
    level.player scripts\sp\utility::_id_1034D("mn_plr_solid_go");
    scripts\engine\utility::flag_wait("player_wakes_server_room");
    wait 0.5;
    scripts\sp\maps\sa_moon\sa_moon_util::_id_8899(80, 0.05);
    level.player scripts\sp\utility::_id_1034D("mn_plr_weapons_are_down");
    scripts\sp\maps\sa_moon\sa_moon_util::_id_8897(2);
    scripts\engine\utility::flag_set("fleet_data_move_out");
    level._id_EA2C thread scripts\sp\utility::_id_10346("mn_slt_lets_move_218");
  } else {
    wait 1.0;
    level.player scripts\sp\utility::_id_1034D("mn_plr_shut_down_secondary");
    level._id_6754 scripts\sp\utility::_id_10346("mn_eth_check_204");
    thread _id_E92F();
    scripts\engine\utility::flag_wait("fleet_data_ethan_done");
    scripts\engine\utility::flag_set("fleet_data_downloaded");
    scripts\engine\utility::flag_wait("fleet_data_player_unlinked");
    wait 0.5;
    scripts\engine\utility::flag_set("fleet_data_move_out");
    scripts\sp\maps\sa_moon\sa_moon_util::_id_8899(80, 0.05);
    level.player scripts\sp\utility::_id_1034D("mn_plr_weapons_are_down");
    scripts\sp\maps\sa_moon\sa_moon_util::_id_8897(2);
    level._id_EA2C scripts\sp\utility::_id_10346("mn_slt_take_us_out");
  }
}

_id_E92F() {
  level endon("fleet_data_patched_in");

  if(!scripts\engine\utility::flag("fleet_data_patched_in")) {
    wait 6;
    level._id_6754 scripts\sp\utility::_id_10346("mn_eth_card_opens_board");
  }
}

_id_E930() {
  scripts\engine\utility::flag_wait("start_fleet_data_enabled");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("obj_shutdown_secondary_defenses", "current", &"SA_MOON_OBJ_SHUTDOWN_SECONDARY_DEFENSES");
  level notify("objective_center_fade_obj_shutdown_secondary_defenses");
  wait 0.05;
  var_0 = scripts\engine\utility::getStruct("fleet_data_obj_org", "targetname");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_12DFB("obj_shutdown_secondary_defenses", var_0.origin, 1);
  objective_state_nomessage(scripts\sp\utility::_id_C264("obj_shutdown_secondary_defenses"), "current");
  _func_2E9(scripts\sp\utility::_id_C264("obj_shutdown_secondary_defenses"), 1);
  _func_2F7(scripts\sp\utility::_id_C264("obj_shutdown_secondary_defenses"), 0);
  level thread scripts\sp\maps\sa_moon\sa_moon_util::_id_119C1(scripts\sp\utility::_id_C264("obj_shutdown_secondary_defenses"), var_0.origin, 250000, "fleet_data_patch_in");
  scripts\engine\utility::flag_wait("fleet_data_patch_in");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_12DFB("obj_shutdown_secondary_defenses", (0, 0, 0));
  scripts\engine\utility::flag_wait("fleet_data_downloaded");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_shutdown_secondary_defenses"));
}

_id_F981() {
  var_0 = getEntArray("fleet_data_screen_static", "targetname");

  foreach(var_2 in var_0)
  var_2 hide();

  if(scripts\engine\utility::flag("fleet_data_checkpoint_start")) {
    setsaveddvar("bg_cinematicFullScreen", "0");
    cinematicingameloopresident("sa_moon_fleet_data_loop_1");
  }

  setsaveddvar("bg_cinematicCanPause", "1");
  scripts\engine\utility::flag_wait("fleet_data_bink_start");
  stopcinematicingame();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_4D99();
  cinematicingame("sa_moon_fleet_data_1");
  scripts\engine\utility::flag_wait("fleet_data_player_done");

  foreach(var_2 in var_0)
  var_2 show();

  pausecinematicingame(1);
  scripts\engine\utility::flag_wait("hero_kill_over");
  stopcinematicingame();
}

#using_animtree("generic_human");

_id_E92B() {
  level._id_EC85["ethan"]["fleet_data_enter"] = % sa_moon_data_center_ethan_enter;
  level._id_EC85["ethan"]["fleet_data_enter_loop"][0] = % sa_moon_data_center_ethan_loop;
  level._id_EC85["ethan"]["fleet_data"] = % sa_moon_data_center_ethan;
}

#using_animtree("player");

_id_E92D() {
  level._id_EC87["player_arms"] = #animtree;
  level._id_EC8C["player_arms"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_arms"]["fleet_data"] = % sa_moon_data_center_plr;
}

#using_animtree("script_model");

_id_E92C() {
  level._id_EC87["keycard"] = #animtree;
  level._id_EC8C["keycard"] = "sdf_captain_keycard_01";
  level._id_EC85["keycard"]["fleet_data"] = % sa_moon_data_center_keycard;
}