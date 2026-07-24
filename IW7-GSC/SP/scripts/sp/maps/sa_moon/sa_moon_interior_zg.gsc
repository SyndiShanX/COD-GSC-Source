/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_interior_zg.gsc
***********************************************************/

_id_E948() {
  _id_0F35::_id_FB25(0, 0);
  _id_0F31::_id_E0C8();
  _id_0F31::_id_E0CE();
  _id_0F31::_id_E0CD();
  _id_0F35::_id_FB26(0, 1);
  level.player thread _id_0F35::_id_D385();
  scripts\engine\utility::trigger_off("player_in_gravity_trigger", "targetname");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_10626();
  thread _id_0F16::_id_3E3E("interior_zg_start");
  thread _id_0F16::_id_3E3D("interior_zg_start", 1);
  thread _id_0F16::_id_8EA3();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_9A7C();
  scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(1);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_8E92(1);
  level thread scripts\sp\maps\sa_moon\sa_moon_breach::_id_E907();
  level thread _id_A4F1();
  var_0 = getEnt("bridge_glass_shot_block", "targetname");
  var_0 delete();
  level._id_2FD7 = scripts\engine\utility::getStruct("bridge_breach_anim_struct", "targetname");
  level._id_2FD7 scripts\sp\anim::_id_1EE0(level._id_30CB, "breach_react");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF9(1, 1);
  scripts\engine\utility::exploder("vfx_bridge_breach");
  scripts\engine\utility::exploder("vfx_bridge_halon");
  scripts\engine\utility::exploder("vfx_amb_bridge");
  scripts\engine\utility::exploder("vfx_zg_bridge");
  scripts\engine\utility::flag_set("player_finished_breach_enter");
  scripts\engine\utility::flag_set("breach_detonation");
  scripts\engine\utility::flag_set("breach_end");
}

_id_E941() {
  scripts\sp\utility::_id_F3E4(0, 0);
  level._id_2FD7 = scripts\engine\utility::getStruct("bridge_breach_anim_struct", "targetname");
  scripts\engine\utility::flag_set("interior_zg_begin");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_9A7B();
  level thread _id_0F16::_id_991E(1, 1);
  level thread _id_E944();
  level thread _id_E949();
  level._id_6754 thread _id_E943();
  level._id_C47F thread _id_E945();
  level._id_EA2C thread _id_E947();
  level thread _id_9A7D();
  level thread _id_E2C4();
  scripts\engine\utility::flag_wait("bridge_gravity_restored");
  level notify("hull_ammo_crate");
  scripts\sp\utility::_id_F44E(1);

  if(isDefined(level._id_118A8))
    thread scripts\sp\maps\sa_moon\sa_moon_util::_id_405F();

  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_8EA5();
  wait 0.1;
  thread scripts\sp\utility::_id_1264E("sa_moon_exterior_tr");
  thread scripts\sp\utility::_id_1264E("sa_moon_exterior_ship_tr");
  thread scripts\sp\utility::_id_1264E("sa_moon_hull_tr");
  wait 0.5;
  thread scripts\sp\utility::_id_12641("sa_moon_elevator_tr");
  thread scripts\sp\utility::_id_12641("sa_moon_interior_tr");
  wait 1.1;
  level _id_A59D();
  thread scripts\sp\utility::_id_266F();
  scripts\engine\utility::flag_wait("omar_at_elevator");
  waitforalltransients();
  scripts\engine\utility::flag_wait("sa_moon_interior_tr_loaded");
  level thread _id_60B6();
  thread _id_88F4();
}

_id_88F4() {
  scripts\engine\utility::flag_set("move_allies_down_elevator_enabled");
  scripts\engine\utility::flag_wait("move_allies_down_elevator");
  scripts\engine\utility::flag_wait("player_starting_elevator_scene");
  clearallcorpses();
  scripts\engine\utility::flag_set("player_inside_maintenance_tunnel_enabled");
  scripts\engine\utility::flag_wait("player_inside_maintenance_tunnel");
  scripts\sp\utility::_id_10FEC("vfx_amb_bridge");
}

_id_A4F1() {
  wait 0.1;
  var_0 = getEnt("bridge_window_player", "targetname");
  var_0 setModel("sdf_bridge_window_break_01_static");
  var_1 = getEnt("bridge_window_allies", "targetname");
  var_1 setModel("sdf_bridge_window_break_02_static");
  var_2 = getEntArray("bridge_window_cracks", "script_noteworthy");
  scripts\engine\utility::array_call(var_2, ::show);
  setsaveddvar("bg_cinematicFullScreen", "0");
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_30A9();
  cinematicingameloopresident("moon_screen_damaged_v1");
  var_3 = getEnt("bridge_console_cracks", "targetname");
  var_3 show();
  scripts\engine\utility::flag_wait_either("interior_zg_end", "moon_breach_ender");
  stopcinematicingame();
}

_id_2F67() {
  self endon("death");
  self _meth_847C();
  var_0 = getEnt("bridge_enemy_sphere_clip", "targetname");
  self._id_438A = spawn("script_model", (0, 0, 0));
  self._id_438A linkTo(self, "j_spinelower", (0, 0, 0), (0, 0, 0));
  self._id_438A clonebrushmodeltoscriptmodel(var_0);
  self._id_438A thread scripts\sp\maps\sa_moon\sa_moon_util::_id_51A1();
  var_1 = level._id_2FD7;

  if(self.script_noteworthy == "breach_enemy_05")
    var_1 scripts\sp\anim::_id_1F35(self, "breach_enter_new");

  if(self.script_noteworthy == "breach_captain") {
    level._id_3A1E = scripts\sp\utility::_id_10639("keycard");
    var_1 scripts\sp\anim::_id_1EC3(level._id_3A1E, "breach_enter_new");
  }

  if(isDefined(self._id_2F5F)) {
    var_1 thread scripts\sp\anim::_id_1EEA(self, "breach_death_loop_new", self._id_1FBB + "stop_breach_death_loop");

    if(self.script_noteworthy == "breach_captain")
      var_1 thread scripts\sp\anim::_id_1EEA(level._id_3A1E, "breach_enter_loop", "keycard_stop_breach_loop");
  } else {
    if(isDefined(self._id_B14F) && self._id_B14F)
      scripts\sp\utility::_id_1101B();

    if(isDefined(self._id_438A))
      self._id_438A delete();

    scripts\engine\utility::waitframe();
    self delete();
    return;
  }
}

_id_E2C4() {
  scripts\engine\utility::flag_wait("breach_entry_ethan_inside");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_6776();
  var_0 = getEnt("bridge_revert_gravity", "targetname");

  if(!level.player istouching(var_0)) {
    while(!level.player istouching(var_0))
      wait 0.05;
  }

  _id_0F0A::life_support_cleanup_equipment_disable_use();
  scripts\engine\utility::flag_set("bridge_gravity_restoring");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_101A0();
  level._id_2FD7 thread scripts\sp\anim::_id_1F35(level._id_30CB, "gravity_restored");
  setsaveddvar("player_zeroGravWorldUp", (0, 0, 1));
  scripts\engine\utility::flag_wait("bridge_gravity_restored");
  level.player thread _id_8527();
  setomnvar("ui_hud_ability_primary", 0);
  setomnvar("ui_hud_ability_secondary", 0);
  scripts\sp\utility::_id_10FEC("vfx_bridge_breach");
  scripts\engine\utility::exploder("vfx_zg_bridge_glassrain");
  scripts\engine\utility::delaythread(0.7, scripts\sp\utility::_id_10FEC, "vfx_zg_bridge");
  scripts\engine\utility::delaythread(0.7, scripts\engine\utility::exploder, "vfx_zg_bridge_return");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_E461();
  var_1 = getEnt("bridge_zerog_clip", "targetname");
  var_1 delete();
  scripts\engine\utility::waitframe();
  scripts\engine\utility::trigger_on("player_in_gravity_trigger", "targetname");
  _id_0F35::_id_FB24(0, level.player);
  _id_0F35::_id_FB25(0, 0);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF9(0);
  level.player _id_0B2A::_id_11429();
  _id_0F0A::life_support_equipment_enable_use();
  setsaveddvar("player_zeroGravWorldUp", (0, 0, 0));
  scripts\engine\utility::waitframe();
  level notify("stop_space_debris");
}

_id_8527() {
  while(!level.player isonground() || level.player _meth_84F4() != "none")
    scripts\engine\utility::waitframe();

  level.player forceplaygestureviewmodel("ges_samoon_bridge_gravity_land");
  level thread _id_5D42();
  level thread _id_5D41();
  level thread _id_5D3F();
}

_id_5D42() {
  var_0 = level.player getplayerangles();
  var_1 = anglesToForward(var_0) * 62;
  var_2 = anglestoleft(var_0) * 8;
  var_3 = spawn("script_model", level.player.origin + var_1 + var_2);
  var_3.origin = (var_3.origin[0], var_3.origin[1], 1462);
  var_3.angles = (45, 35, 0);
  var_3 setModel("oxygen_tank_gascanister_01_zerog_to_gravity");
  scripts\engine\utility::waitframe();
  var_4 = var_3.origin + (anglestoup(var_3.angles) * 16 + anglesToForward(var_0) * -8);
  var_5 = var_3.origin + (anglestoup(var_3.angles) * 16 + anglesToForward(var_0) * -24);
  var_6 = vectorNormalize(var_5 - var_4);
  var_3 physicslaunchserver(var_3.origin + (0, 0, 12), (var_6[0] * -50, var_6[1] * -50, -300));
  scripts\engine\utility::flag_wait("player_started_elevator_scene");
  var_3 delete();
}

_id_5D41() {
  var_0 = level.player getplayerangles();
  var_1 = anglesToForward(var_0) * 72;
  var_2 = anglestoright(var_0) * 12;
  var_3 = spawn("script_model", level.player.origin + var_1 + var_2);
  var_3.origin = (var_3.origin[0], var_3.origin[1], 1462);
  var_3.angles = (75, 25, 90);
  var_3 setModel("weapon_ar57_wm");
  wait 0.4;
  var_4 = var_3.origin + (anglestoup(var_3.angles) * 16 + anglesToForward(var_0) * -8);
  var_5 = var_3.origin + (anglestoup(var_3.angles) * 16 + anglesToForward(var_0) * -24);
  var_6 = vectorNormalize(var_5 - var_4);
  var_3 physicslaunchserver(var_3.origin + (0, 0, 12), (var_6[0] * -50, var_6[1] * -50, -50));
  scripts\engine\utility::flag_wait("player_started_elevator_scene");
  var_3 delete();
}

_id_5D3F() {
  wait 0.6;
  var_0 = level.player getplayerangles();
  var_1 = anglesToForward(var_0) * 86;
  var_2 = anglestoleft(var_0) * 2;
  var_3 = level.player scripts\engine\utility::spawn_tag_origin(level.player.origin + var_1 + var_2, (-90, var_0[1], 0));
  var_3.origin = (var_3.origin[0], var_3.origin[1], 1462);
  playFXOnTag(scripts\engine\utility::getfx("vfx_sa_moon_bridge_breach_fg_coffee"), var_3, "tag_origin");
  wait 5;
  var_3 delete();
}

_id_A59D() {
  var_0 = scripts\sp\utility::_id_10639("player_arms");
  var_0 hide();
  level._id_2FD7 scripts\sp\anim::_id_1EC3(var_0, "grab_keycard");
  scripts\engine\utility::flag_wait("captain_key_card_spawned");
  var_1 = [];
  var_1[var_1.size] = var_0;
  var_1[var_1.size] = level._id_2F5C;
  var_1[var_1.size] = level._id_3A1E;

  if(!isDefined(level._id_9DD0))
    level._id_3A1E _id_0E46::_id_48C4(undefined, undefined, undefined, undefined, 1000, 64, 1);

  level._id_3A1E waittill("trigger");
  level thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_3A1D();
  scripts\engine\utility::flag_set("captain_key_card_pickup_started");
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
  var_2 = distance(level.player.origin, var_0 gettagorigin("tag_player"));
  var_3 = 64;
  var_4 = var_2 / var_3;
  level.player _meth_823C(var_0, "tag_player", var_4, var_4 * 0.5, 0.0);
  wait(var_4);
  var_0 show();
  level._id_2F5C thread _id_3A22();
  level._id_2FD7 notify("stop_breach_captain_breach_enter_loop");
  level._id_2FD7 scripts\sp\anim::_id_1F2C(var_1, "grab_keycard");
  thread _id_0A2F::_id_DA45("captain3");
  level._id_3A1E delete();
  scripts\engine\utility::flag_set("captain_key_card_picked_up");
  level.player unlink();
  var_0 delete();
  level.player enableweapons();
  level.player allowsprint(1);
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
}

_id_60B6() {
  var_0 = scripts\sp\utility::_id_10639("player_arms");
  var_0 hide();
  var_0 dontcastshadows();
  level._id_2FD7 scripts\sp\anim::_id_1EC3(var_0, "elevator_down");
  scripts\engine\utility::flag_wait("player_wait_elevator_scene");
  scripts\engine\utility::flag_wait("player_starting_elevator_scene");
  level.player disableweapons();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player allowslide(0);
  level.player _meth_80D1();
  level.player setvelocity(level.player getentityvelocity() / 100);
  scripts\engine\utility::waitframe();
  var_1 = distance(level.player.origin, var_0 gettagorigin("tag_player"));
  var_2 = 64;
  var_3 = var_1 / var_2;
  level.player _meth_823C(var_0, "tag_player", var_3, var_3 * 0.5, 0.0);
  wait(var_3);
  var_0 show();
  level.player _meth_84FE();
  scripts\engine\utility::flag_set("player_started_elevator_scene");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_D035();
  thread _id_6236();
  level.player playerlinktodelta(var_0, "tag_player", 0.75, 20, 20, 5, 50, 1);
  level._id_2FD7 scripts\sp\anim::_id_1F35(var_0, "elevator_down");
  level.player unlink();
  level.player _meth_84FD();
  var_0 delete();
  level.player enableweapons();
  level.player allowsprint(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowslide(1);
  level.player _meth_80A1();
}

_id_6236() {
  wait 8;
  level.player _meth_84FD();
}

_id_9A7D() {
  if(!isDefined(level._id_2F65)) {
    scripts\sp\utility::_id_22CA("bridge_breach_enemies", scripts\sp\maps\sa_moon\sa_moon_breach::_id_2FD8);
    scripts\sp\utility::_id_22CA("bridge_breach_enemies", ::_id_2F67);
    level._id_2F65 = scripts\sp\utility::_id_22CD("bridge_breach_enemies", 1);
  }

  scripts\engine\utility::flag_wait("bridge_gravity_restoring");
  level._id_2F65 = scripts\sp\utility::_id_22B9(level._id_2F65);
  level._id_2F65 = scripts\engine\utility::array_removeundefined(level._id_2F65);

  foreach(var_1 in level._id_2F65)
  var_1 thread _id_9A7E();
}

_id_9A7E() {
  if(self.script_noteworthy == "breach_enemy_05" || self.script_noteworthy == "breach_captain")
    scripts\engine\utility::flag_wait("bridge_gravity_restored");

  if(self == level._id_2F5C) {
    level._id_2FD7 notify("keycard_stop_breach_loop");
    level._id_2FD7 thread scripts\sp\anim::_id_1F35(level._id_3A1E, "gravity_restored");
  }

  level._id_2FD7 notify(self._id_1FBB + "stop_breach_death_loop");
  level._id_2FD7 scripts\sp\anim::_id_1F35(self, "gravity_restored");

  if(self == level._id_2F5C) {
    level._id_2FD7 thread scripts\sp\anim::_id_1EEA(level._id_3A1E, "gravity_restored_loop", "stop_breach_captain_breach_enter_loop");
    level._id_2FD7 thread scripts\sp\anim::_id_1EEA(level._id_2F5C, "grab_captain_loop", "stop_breach_captain_breach_enter_loop");
    scripts\engine\utility::flag_set("captain_key_card_spawned");
  } else {
    if(isDefined(self._id_B14F) && self._id_B14F)
      scripts\sp\utility::_id_1101B();

    self _meth_83F7();

    if(isDefined(self._id_438A))
      self._id_438A delete();

    self _meth_81D0();
  }
}

_id_3A22() {
  self waittillmatch("single anim", "end");
  level._id_2FD7 scripts\sp\anim::_id_1EEA(self, "grab_keycard_loop");
}

_id_E943() {
  level endon("moon_breach_ender");
  self endon("death");
  scripts\sp\utility::_id_54F7();
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F39F();
  var_0 = scripts\engine\utility::getStruct("bridge_breach_anim_struct", "targetname");
  var_0 notify("stop_ethan_loop");
  thread _id_675A();
  thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_132E2();
  var_0 scripts\sp\anim::_id_1F35(self, "breach_enter_new");
  scripts\engine\utility::flag_set("breach_entry_ethan_inside");

  if(!scripts\engine\utility::flag("bridge_gravity_restoring"))
    var_0 thread scripts\sp\anim::_id_1EEA(self, "breach_enter_loop", "stop_ethan_breach_enter_loop");

  scripts\engine\utility::flag_wait("bridge_gravity_restoring");
  var_0 notify("stop_ethan_breach_enter_loop");
  scripts\sp\utility::_id_61E7();
  var_0 scripts\sp\anim::_id_1F35(self, "gravity_restored");
  self.goalradius = 16;
  var_1 = getnode("ethan_elevator_node", "targetname");
  self _meth_82EE(var_1);
  scripts\engine\utility::flag_wait("player_started_elevator_scene");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_676D();
  var_0 scripts\sp\anim::_id_1F35(self, "elevator_down");
}

_id_675A() {
  while(!scripts\engine\utility::flag("bridge_gravity_restoring")) {
    physicsexplosionsphere(level._id_6754.origin + anglestoup(level._id_6754.angles) * 16, 34, 33, 8);
    wait 0.25;
  }
}

_id_E945() {
  level endon("moon_breach_ender");
  self endon("death");
  scripts\sp\utility::_id_54F7();
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F39F();
  var_0 = scripts\engine\utility::getStruct("bridge_breach_anim_struct", "targetname");
  var_1 = scripts\sp\utility::_id_10639("generic_prop_x3");
  var_0 scripts\sp\anim::_id_1EC3(var_1, "elevator_down");
  var_2 = getEnt("bridge_elevator_door_right", "targetname");
  var_3 = getEnt("bridge_elevator_door_right_clip", "targetname");
  var_3 linkTo(var_2, "tag_origin");
  var_2 linkTo(var_1, "j_prop_1", (0, 0, 0), (0, 0, 0));
  var_4 = getEnt("bridge_elevator_door_left", "targetname");
  var_5 = getEnt("bridge_elevator_door_left_clip", "targetname");
  var_5 linkTo(var_4, "tag_origin");
  var_4 linkTo(var_1, "j_prop_2", (0, 0, 0), (0, 0, 0));
  var_4 _id_0F05::_id_8ED3("tag_screen_open");
  var_4 _id_0F05::_id_8ED3("tag_screen_restricted");
  thread _id_2FF8(var_4);
  var_0 scripts\sp\anim::_id_1F35(self, "breach_enter_new");

  if(!scripts\engine\utility::flag("bridge_gravity_restored"))
    var_0 thread scripts\sp\anim::_id_1EEA(self, "breach_enter_loop", "stop_omar_breach_enter_loop");

  scripts\engine\utility::flag_wait("bridge_gravity_restored");
  var_0 notify("stop_omar_breach_enter_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "gravity_restored");
  scripts\engine\utility::flag_wait("captain_key_card_picked_up");
  self.goalradius = 16;
  var_6 = getnode("omar_elevator_node", "targetname");
  self _meth_82EE(var_6);
  var_0 scripts\sp\anim::_id_1F17(self, "elevator_down");
  scripts\engine\utility::flag_set("omar_at_elevator");
  scripts\engine\utility::flag_wait("sa_moon_interior_tr_loaded");
  scripts\engine\utility::flag_wait("move_allies_down_elevator");
  thread _id_E979();
  level thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_C484(var_1);
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "elevator_down");
  var_0 thread scripts\sp\anim::_id_1F35(self, "elevator_down");
  var_7 = 1;

  if(var_7)
    wait 5.133;
  else
    self waittillmatch("single anim", "allow_player");

  scripts\engine\utility::flag_set("move_player_down_elevator_enabled");
  scripts\engine\utility::flag_set("player_wait_elevator_scene");
  scripts\engine\utility::flag_wait("player_started_elevator_scene");
  wait 10;
  var_0 scripts\sp\anim::_id_1EC3(var_1, "elevator_down");
  scripts\engine\utility::flag_wait("fleet_data_downloaded");
  var_1 delete();
}

_id_2FF8(var_0) {
  level endon("player_inside_maintenance_tunnel");

  for(;;) {
    var_0 _id_0F05::_id_8ED3("tag_screen_locked");
    wait(randomfloatrange(0.25, 1));
    var_0 _id_0F05::_id_10145("tag_screen_locked");
    wait(randomfloatrange(0.25, 1));
  }
}

_id_E947() {
  level endon("moon_breach_ender");
  self endon("death");
  scripts\sp\utility::_id_54F7();
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_F39F();
  var_0 = scripts\engine\utility::getStruct("bridge_breach_anim_struct", "targetname");
  var_0 scripts\sp\anim::_id_1F35(self, "breach_enter_new");

  if(!scripts\engine\utility::flag("bridge_gravity_restoring"))
    var_0 thread scripts\sp\anim::_id_1EEA(self, "breach_enter_loop", "stop_salter_breach_enter_loop");

  scripts\engine\utility::flag_wait("bridge_gravity_restoring");
  var_0 notify("stop_salter_breach_enter_loop");
  scripts\sp\utility::_id_61E7();
  var_0 scripts\sp\anim::_id_1F35(self, "gravity_restored");
  self.goalradius = 16;
  var_1 = getnode("salter_elevator_node", "targetname");
  self _meth_82EE(var_1);
  scripts\engine\utility::flag_wait("player_started_elevator_scene");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_EA58();
  var_0 scripts\sp\anim::_id_1F35(self, "elevator_down");
  wait 5;
  thread scripts\sp\utility::_id_1264E("sa_moon_bridge_tr");
}

_id_E949() {
  level endon("captain_key_card_picked_up");
  thread _id_E940();
  wait 1.0;
  level.player scripts\sp\utility::_id_1034D("mn_plr_force_in");
  wait 1.25;
  level.player scripts\sp\utility::_id_1034D("mn_plr_shut_down_primary");
  level.player scripts\sp\utility::_id_1034D("mn_plr_shutdownprimary");
  wait 0.3;
  level._id_6754 thread scripts\sp\utility::_id_10346("mn_eth_aye_sir");
  wait 1.5;

  if(!scripts\engine\utility::flag("bridge_gravity_restoring"))
    level.player scripts\sp\utility::_id_1034D("mn_plr_scope_windows");

  level thread _id_E946();
  scripts\engine\utility::flag_wait("bridge_gravity_restored");
  wait 4;
  level.player scripts\sp\utility::_id_1034D("mn_plr_illgetthecoscard");
  wait 6;
  level._id_C47F scripts\sp\utility::_id_10346("mn_omr_secure_card");
}

_id_E940() {
  scripts\engine\utility::flag_wait("captain_key_card_picked_up");
  scripts\engine\utility::flag_set("move_to_elevator");
  level.player scripts\sp\utility::_id_1034D("mn_plr_primary_down");
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_10350("mn_fer_roger_that_152");
  scripts\engine\utility::flag_wait("move_allies_down_elevator");
  level.player scripts\sp\utility::_id_1034D("mn_plr_down_shaft");
  scripts\engine\utility::flag_wait("player_inside_maintenance_tunnel");
  scripts\engine\utility::flag_set("sealing_the_room_vo_done");
}

_id_E946() {
  scripts\engine\utility::flag_wait("player_finished_breach_enter");
  wait 1.0;
  level notify("end_pa_group");
  _id_0F00::_id_CDBD("mn_paa_vessel_compromised", 1);
  wait 4.0;
  _id_0F00::_id_CDBD("mn_paa_captain_down430", 1);
  wait 4.0;
  _id_0F00::_id_CDBD("mn_paa_code_red", 1);
}

_id_E944() {
  level endon("moon_breach_ender");

  if(isDefined(level._id_9DD0)) {
    return;
  }
  scripts\engine\utility::flag_wait("captain_key_card_spawned");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("obj_shutdown_primary_defenses", "current", &"SA_MOON_OBJ_SHUTDOWN_PRIMARY_DEFENSES", 1);
  level notify("objective_center_fade_obj_shutdown_primary_defenses");
  wait 0.05;
  objective_state_nomessage(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"), "current");
  var_0 = level._id_3A1E;
  objective_onentity(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"), level._id_3A1E);
  _func_2E9(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"), 1);
  _func_2F7(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"), 0);
  level thread scripts\sp\maps\sa_moon\sa_moon_util::_id_119C1(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"), level._id_3A1E.origin, 250000, "captain_key_card_pickup_started");
  scripts\engine\utility::flag_wait("captain_key_card_pickup_started");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_12DFB("obj_shutdown_primary_defenses", (0, 0, 0));
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_shutdown_primary_defenses"));
  scripts\engine\utility::flag_wait("move_to_elevator");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("obj_shutdown_secondary_defenses", "current", &"SA_MOON_OBJ_SHUTDOWN_SECONDARY_DEFENSES");
  var_0 = scripts\engine\utility::getStruct("bridge_elevator_pre_drop_obj_org", "targetname");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_12DFB("obj_shutdown_secondary_defenses", var_0.origin);
  scripts\engine\utility::flag_wait("move_player_down_elevator_enabled");
  var_0 = scripts\engine\utility::getStruct("bridge_elevator_drop_obj_org_01", "targetname");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_12DFB("obj_shutdown_secondary_defenses", var_0.origin);
  scripts\engine\utility::flag_wait("player_started_elevator_scene");
  var_0 = scripts\engine\utility::getStruct("bridge_elevator_drop_obj_org_02", "targetname");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_12DFB("obj_shutdown_secondary_defenses", var_0.origin);
  scripts\engine\utility::flag_wait("bridge_elevator_drop_obj_into_maintenance");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_12DFB("obj_shutdown_secondary_defenses", (0, 0, 0));
}

_id_E979() {
  var_0 = getEnt("maintenance_entrance_door", "targetname");
  var_1 = getEnt("maintenance_entrance_door_clip", "targetname");
  self waittillmatch("single anim", "open_door");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_B24F(var_0);
  var_1 notsolid();
  var_0 movez(116, 1.5);
  scripts\engine\utility::flag_wait("player_inside_maintenance_tunnel");
}