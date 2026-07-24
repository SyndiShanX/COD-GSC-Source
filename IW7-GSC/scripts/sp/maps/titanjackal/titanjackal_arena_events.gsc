/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titanjackal\titanjackal_arena_events.gsc
********************************************************************/

_id_963A() {
  scripts\engine\utility::flag_init("turbine_dogfighting_complete");
  scripts\engine\utility::flag_init("salter_landing_building1");
  scripts\engine\utility::flag_init("salter_landing_building2");
  scripts\engine\utility::flag_init("salter_landing");
  scripts\engine\utility::flag_init("player_landing_building1");
  scripts\engine\utility::flag_init("player_landing_building2");
  scripts\engine\utility::flag_init("player_landed");
  scripts\engine\utility::flag_init("player_landed_building1");
  scripts\engine\utility::flag_init("player_landed_building2");
  scripts\engine\utility::flag_init("salter_landed_building1");
  scripts\engine\utility::flag_init("salter_landed_building2");
  scripts\engine\utility::flag_init("player_abandoned_building1");
  scripts\engine\utility::flag_init("player_abandoned_building2");
  scripts\engine\utility::flag_init("intro_vo_complete");
  scripts\engine\utility::flag_init("turbine1_exposed");
  scripts\engine\utility::flag_init("turbine2_exposed");
  scripts\engine\utility::flag_init("turbine1_destroyed");
  scripts\engine\utility::flag_init("turbine2_destroyed");
  scripts\engine\utility::flag_init("both_turbines_destroyed");
  scripts\engine\utility::flag_init("salter_left_entrance_vol_clear");
  scripts\engine\utility::flag_init("building1_aa_turrets_destroyed");
  scripts\engine\utility::flag_init("building2_aa_turrets_destroyed");
  scripts\engine\utility::flag_init("begin_dogfight");
  scripts\engine\utility::flag_init("missile_boat_spawned");
  scripts\engine\utility::flag_init("missile_boats_destroyed");
  scripts\engine\utility::flag_init("arena_jackals_destroyed");
  scripts\engine\utility::flag_init("jackals_retreated");
  scripts\engine\utility::flag_init("player_has_landed_on_turbine");
  scripts\engine\utility::flag_init("player_has_left_the_turbine");
  scripts\engine\utility::flag_init("salter_ground_stop1");
  scripts\engine\utility::flag_init("salter_ground_stop2");
  scripts\engine\utility::flag_init("salter_ground_stop3");
  scripts\engine\utility::flag_init("salter_ground_stop4");
  scripts\engine\utility::flag_init("salter_at_button");
  scripts\engine\utility::flag_init("flag_pipeline_exploded");
  scripts\engine\utility::flag_init("flag_tower_triggered");
  scripts\engine\utility::flag_init("flag_pipeline_nearly_complete");
  scripts\engine\utility::flag_init("flag_player_ready_for_launch");
  scripts\engine\utility::flag_init("building1_attacking");
  scripts\engine\utility::flag_init("building2_attacking");
  scripts\engine\utility::flag_init("player_close_to_building1");
  scripts\engine\utility::flag_init("player_close_to_building2");
  scripts\engine\utility::flag_init("cargoship_moment_finished");
  scripts\engine\utility::flag_init("enemy_jackal_down");
}

_id_A086() {
  scripts\engine\utility::flag_set("jackal_arena_begin_vision_fx");
  level thread hud_boot_down();
}

hud_boot_down() {
  scripts\sp\utility::_id_13705();
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_level_transition", 3);
  wait 2;
  setomnvar("ui_level_transition", 0);
}

_id_A085() {
  setglobalsoundcontext("wind", "none", 3.0);
  thread _id_3209();
  thread _id_13520();
  level._id_740B = 0.01;
}

_id_A084() {
  scripts\engine\utility::flag_set("jackal_arena_begin_vision_fx");
  level thread scripts\sp\maps\titan\titan_jackal_arena_dogfight::_id_119A2();
  scripts\engine\utility::exploder("bridge_lights");
  thread scripts\sp\maps\titan\titan_hot_landing::_id_F9D0();
  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_D250(1);
  level._id_740B = 0.01;
  thread _id_6E83();
  scripts\engine\utility::exploder("99");
  _id_FA05("jackal_arena_start");
  _id_0BDC::_id_137CF();
  wait 0.05;
  level._id_D127 _id_0BDD::_id_A2D5();
  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_D24F();
  thread _id_9166();
  _id_0BDC::_id_137D6();
  setsaveddvar("r_volumetricsScatterTemporalFactor", 0.5);
  thread _id_134E0();
  setglobalsoundcontext("wind", "none", 3.0);
  thread _id_A3A1();
  thread _id_B986();
  thread _id_13520();
  level._id_D127 _id_0BDC::_id_F48D("default_landed");
  level._id_D127 _id_0BDC::_id_F5BD("vtol");
  level._id_11A70 = _id_0BDC::_id_7BBA();
  _id_A08F();
  var_0 = scripts\sp\utility::_id_7C9A("salter_fly_to_turbine");
  level._id_EAD6 _id_0BDC::_id_A372("salter_fly_to_turbine");
  level._id_EAD6 _meth_8479(var_0);
  level._id_EAD6 _meth_847B(0.05, level._id_EAD6.origin);
  level._id_EAD6.ignoreall = 1;
  level._id_EAD6 thread scripts\sp\maps\titan\titan_jackal_arena_dogfight::_id_A184();
  level._id_EAD6 waittill("near_goal");
  scripts\engine\utility::flag_set("begin_dogfight");
  level._id_EAD6 thread scripts\sp\maps\titan\titan_jackal_arena_dogfight::_id_A183();
}

_id_6E83() {
  level endon("tower_destroyed");
  level.player endon("death");
  var_0 = getEnt("flame_damage_trigger", "targetname");

  for(;;) {
    var_0 waittill("trigger");

    while(level._id_D127 istouching(var_0)) {
      level._id_D127 dodamage(50, var_0.origin, undefined, undefined, "MOD_EXPLOSIVE");
      wait 0.15;
    }
  }
}

_id_A08A() {
  scripts\engine\utility::flag_set("jackal_first_building_vision_fx");
  thread scripts\sp\maps\titan\titan_hot_landing::_id_F9D0();
  _id_A08F();
  _id_FA05("building1_arrive");
  wait 0.05;
  level._id_D127 _id_0BDD::_id_A2D5();
  scripts\engine\utility::exploder("fx_splash_field");
}

_id_A089() {
  scripts\engine\utility::flag_set("jackal_first_building_vision_fx");
  level thread scripts\sp\maps\titan\titan_jackal_arena_dogfight::_id_119A1();
  level thread scripts\sp\maps\titan\titan_jackal_arena_dogfight::_id_A188();
  scripts\engine\utility::exploder("fx_splash_field");
  wait 5;
  _id_6DBC();
}

_id_A088() {}

_id_A08D() {
  level._id_6DBA = "building_1";
  level._id_F08E = "building_2";
  _id_FA05("jackal_building1_exit");
  thread _id_5190();
  level thread scripts\sp\maps\titan\titan_jackal_arena_dogfight::_id_1195A();
  scripts\engine\utility::exploder("fx_splash_field");
  scripts\engine\utility::exploder("bridge_lights");
}

_id_A08C() {
  if(scripts\sp\maps\titanjackal\titanjackal_code::_id_9BF6()) {
    return;
  }
  level _id_F090(level._id_F08E);
}

_id_A08B() {
  _id_A08E();
  level._id_6DBA = "building_1";
  level._id_F08E = "building_2";
  scripts\engine\utility::flag_set("turbine1_destroyed");

  if(isDefined(level._id_EAD6)) {
    level._id_EAD6._id_55A4 = undefined;
  }
}

_id_A096() {
  _id_FA05("building2_arrive");
  scripts\engine\utility::exploder("fx_splash_field");
  scripts\engine\utility::exploder("bridge_lights");
}

_id_A095() {
  if(scripts\sp\maps\titanjackal\titanjackal_code::_id_9BF6()) {
    return;
  }
  level._id_EAD6 thread _id_EA39();
  _id_2F49(level._id_F08E);
}

_id_A091() {}

_id_A094() {
  scripts\engine\utility::flag_set("jackal_second_building_exit_vision_fx");
  thread scripts\sp\maps\titan\titan_hot_landing::_id_F9D0();
  var_0 = "jackal_building1_exit";
  _id_FA05(var_0);
  scripts\engine\utility::flag_set("both_turbines_destroyed");
  wait 1;
  thread _id_A3A1();
  scripts\engine\utility::exploder("fx_splash_field");
  scripts\engine\utility::exploder("bridge_lights");
  scripts\engine\utility::exploder("fx_turbine_fires");
}

_id_4B07() {
  setculldist(80500);
  scripts\engine\utility::flag_wait("player_at_bottleneck");
  setculldist(65000);
}

_id_A093() {
  scripts\engine\utility::flag_set("jackal_second_building_exit_vision_fx");
  scripts\engine\utility::flag_wait("both_turbines_destroyed");
  scripts\sp\utility::_id_28D7("allies");
  _id_0BDC::_id_A06A(0);
  level.player scripts\sp\utility::_id_65E3("flag_player_is_flying");
  scripts\engine\utility::flag_set("player_has_left_the_turbine");
  thread _id_EA7C();
  _id_F534();
  thread scripts\sp\maps\titan\titan_hot_landing::_id_CBD1();
  wait 2.0;
  level._id_EAD6 _id_0BDC::_id_19A0(0);
  level._id_EAD6 _id_0BDC::_id_19B2("face motion");
  level._id_EAD6 _id_0BDC::_id_19B0("fly");
  thread _id_1350A();
  wait 2.5;
  scripts\engine\utility::flag_wait("player_at_bottleneck");
}

_id_C6FD() {
  var_0 = scripts\engine\utility::getStruct("calvary_start_player", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.origin = level._id_D127.origin;
  var_1.angles = level._id_D127.angles;
  level._id_D127 linkTo(var_1, "tag_origin");
  var_2 = 5;
  var_1 rotateTo(var_0.angles, var_2, var_2 * 0.5, var_2 * 0.5);
  wait(var_2);
  var_2 = 7;
  var_1 moveTo(level._id_D127.origin + (0, 0, 900), var_2, var_2 * 0.5, var_2 * 0.5);
  wait(var_2);
  level._id_D127 unlink();
  var_1 delete();
}

_id_EA7C() {
  level._id_EAD6._id_116AE = level._id_EAD6 scripts\engine\utility::spawn_tag_origin();
  level._id_EAD6._id_116AE linkTo(level._id_EAD6, "j_weapon_hatch_right2", (0, 0, 30), (0, 0, 0));
  objective_add(scripts\sp\utility::_id_C264("SALTER_GUIDE"), "invisible");
  objective_onentity(scripts\sp\utility::_id_C264("SALTER_GUIDE"), level._id_EAD6._id_116AE);
  objective_state(scripts\sp\utility::_id_C264("SALTER_GUIDE"), "current");
  level._id_EAD6 notify("stop_hovering_between_structs");
  var_0 = scripts\sp\utility::_id_7C9A("salter_fly_to_tower_exit");
  level._id_EAD6 _id_0BDC::_id_19A0(0);
  level._id_EAD6 _id_0BDC::_id_A372("salter_fly_to_tower_exit");
  level._id_EAD6 _meth_8479(var_0);
  level._id_EAD6 _meth_847B(0.05, level._id_EAD6.origin);
  level._id_EAD6.ignoreall = 1;
  level._id_EAD6 thread scripts\sp\maps\titan\titan_jackal_arena_dogfight::_id_A184();
  level._id_EAD6 scripts\engine\utility::waittill_any("near_goal", "salter_tower_idle_position");
  thread salter_idle_near_tower();
}

salter_idle_near_tower() {
  objective_delete(scripts\sp\utility::_id_C264("SALTER_GUIDE"));
  level._id_EAD6 _id_0BDC::_id_19B0("hover");
  level._id_EAD6 _meth_845F(400);
  level._id_EAD6 _meth_847A();
  level._id_EAD6 notify("disable_rubberband_speed");
  level._id_EAD6 _id_0BDC::_id_19A0(1);
  var_0 = scripts\engine\utility::getStructArray("salter_tower_hover_exit", "targetname");
  level._id_EAD6 thread _id_90D0(var_0, 400);
}

_id_A092() {}

_id_1350A() {
  var_0 = ["titan_slt_fuseislit", "titan_plr_letsgetvisualonthat", "titan_slt_followthesepipesto"];
  scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_0);
}

_id_EAB2() {
  level._id_EAD6 notify("stop_attacking_with_player");
  var_0 = scripts\engine\utility::getStruct("player_jackal_takeoff_position", "targetname");
  level._id_EAD6 _id_10589(var_0.origin);
  scripts\engine\utility::flag_wait("player_at_bottleneck");
  level._id_EAD6 notify("stop_leading_player");
}

_id_A3A1() {
  level endon("stop_windshield_fx");
  _id_0BDC::_id_137DA();
  var_0 = level.player _meth_8473();
  var_1 = "j_mainroot_ship";
  playFXOnTag(scripts\engine\utility::getfx("vfx_jackal_methane_drops"), var_0, var_1);
  level.player scripts\sp\utility::_id_65E8("flag_player_has_jackal");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_jackal_methane_drops"), var_0, var_1);
  _id_0BDC::_id_137D6();
  playFXOnTag(scripts\engine\utility::getfx("vfx_jackal_methane_drops"), var_0, var_1);
}

_id_A3A2() {
  level notify("stop_windshield_fx");
  var_0 = level.player _meth_8473();
  var_1 = "j_mainroot_ship";
  stopFXOnTag(scripts\engine\utility::getfx("vfx_jackal_methane_drops"), var_0, var_1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_jackal_windshield_rain_gust"), var_0, var_1);
}

_id_A3A3() {
  level notify("stop_windshield_fx");
  var_0 = level.player _meth_8473();
  var_1 = "j_mainroot_ship";
  stopFXOnTag(scripts\engine\utility::getfx("vfx_jackal_windshield_rain_gust"), var_0, var_1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_jackal_windshield_gust"), var_0, var_1);
}

_id_B986() {
  var_0 = scripts\engine\utility::getStruct("building_1", "targetname");

  if(scripts\sp\maps\titanjackal\titanjackal_code::_id_9BF6()) {
    level endon("turbine1_destroyed");
  } else {
    level endon("both_turbines_destroyed");
  }

  for(;;) {
    _id_F3A0(var_0, "player_close_to_building1");
    wait 2;
  }
}

_id_F3A0(var_0, var_1) {
  var_2 = 35000;
  var_3 = distance2d(_id_0BDC::_id_7BBA(), var_0.origin);

  if(var_3 <= var_2) {
    if(!scripts\engine\utility::flag(var_1)) {
      scripts\engine\utility::flag_set(var_1);
    }
  } else if(scripts\engine\utility::flag(var_1))
    scripts\engine\utility::flag_clear(var_1);
}

_id_13520() {
  level endon("both_turbines_destroyed");
  var_0 = 10;

  for(;;) {
    level.player waittill("jackal_near_death");
    scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_reesegetoutof", 1);
    wait(var_0);
  }
}

_id_3209() {
  var_0 = scripts\engine\utility::getfx("vfx_tb_light_red_blinking");
  var_1 = scripts\engine\utility::getfx("vfx_tb_light_blue_steady");
  var_2 = scripts\engine\utility::getfx("vfx_tb_light_white_steady");
  var_3 = ["blue", "white"];
}

_id_134E0() {
  while(iscinematicplaying()) {
    wait 0.05;
  }

  wait 1.5;
  var_0 = ["titan_slt_goodworkmarinesscars", "titan_usf_rogerthatlieutenantbutton", "titan_plr_copythatstaffsergeant"];
  scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_0);
  wait 0.15;
  var_0 = ["titan_slt_getyourwarpaint"];
  scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_0);
  wait 0.15;
  scripts\engine\utility::flag_set("intro_vo_complete");
}

_id_A08F() {
  _id_12938();
  thread _id_D1BA();
  thread _id_31E2();
  thread _id_2EDF();
  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_535E();
  level thread _id_D0B3();
  level thread _id_3A97();
  thread _id_134FB();
  scripts\sp\utility::_id_22C9("player_enemies", ::_id_D04A);
  scripts\sp\utility::_id_22C9("salter_enemies_triggered", ::_id_EA61);
  _id_0BDC::_id_A24B("building1_landing_pad", 0);
}

_id_A08E() {
  _id_12938();
  thread _id_2EDF();
  scripts\sp\utility::_id_22C9("jackal_rocket_guys", ::_id_E5CB);
  scripts\sp\utility::_id_22C9("salter_enemies_triggered", ::_id_EA61);
  _id_0BDC::_id_A24B("building1_landing_pad", 0);
}

_id_12935(var_0) {
  var_1 = var_0.spawners[0];
  var_2 = 225000000;

  while(distance2dsquared(var_1.origin, _id_0BDC::_id_7BBA()) > var_2) {
    wait 1;
  }

  wait 1;
  level.player scripts\sp\utility::_id_65E3("flag_player_is_landing");
  scripts\sp\utility::_id_228A(var_0.spawners);
}

_id_A090() {
  setsaveddvar("r_hudoutlineEnable", "1");
  setsaveddvar("r_hudoutlineFillColor0", ".5 .5. 5 1");
  setsaveddvar("r_hudoutlineFillColor1", "1 1 1 .2");
  setsaveddvar("r_hudoutlineOccludedOutlineColor", ".5 .5 .5 1");
  setsaveddvar("r_hudoutlineOccludedInlineColor", ".7 .7 .7 1");
  setsaveddvar("r_hudoutlineOccludedInteriorColor", ".5 .5 .5 1");
  setsaveddvar("r_hudOutlineOccludedColorFromFill", 1);
  setsaveddvar("r_hudoutlineWidth", "2");
}

_id_EA7A() {
  self endon("death");
  self.goalradius = 650;

  if(isDefined(level._id_2F46)) {
    self setgoalpos(level._id_2F46.origin);
  }

  if(getdvarint("ai_iw7") == 1) {
    if(scripts\engine\utility::cointoss()) {
      var_0 = randomint(100);

      if(var_0 < 34) {
        scripts\sp\utility::_id_51E1("frantic");
      } else if(var_0 < 67) {
        scripts\sp\utility::_id_51E1("cqb");
      } else {
        scripts\sp\utility::_id_51E1("sprint");
      }
    }
  }

  _id_A090();
  wait 5;
  self waittill("goal");
  self _meth_80E3();
}

_id_EA61() {
  if(getdvarint("ai_iw7") == 1) {
    scripts\sp\utility::_id_51E1("sprint");
  } else {
    scripts\sp\utility::_id_623B();
  }

  _id_A090();
}

_id_D04A() {
  thread _id_4E07();

  if(getdvarint("ai_iw7") == 1) {
    return;
  }
  scripts\sp\utility::_id_623B();
}

_id_AD9D() {
  self endon("death");
  scripts\sp\utility::_id_F2D8(0.15);
  childthread _id_518E();

  if(level.console) {
    _id_A090();
    thread scripts\sp\maps\titanjackal\titanjackal_code::_id_F40C("enemy", 0, 0);
  }

  wait 1;
  self waittill("goal");

  for(;;) {
    var_0 = _id_77EB();

    if(isDefined(var_0)) {
      self clearentitytarget();
      self _meth_82DE(var_0);
      wait(randomintrange(6, 9));
    }

    wait 0.15;
  }
}

_id_9166() {
  level.player scripts\sp\utility::_id_65E3("flag_player_dismounting");
  level.player _meth_8497(1);
}

_id_518E() {
  level.player scripts\sp\utility::_id_65E3("flag_player_dismounting");
  scripts\sp\utility::_id_1938([self], 1500);
}

_id_4E07() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);

    if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "worldspawn") {
      if(randomint(100) > 60) {
        self _meth_81D0(self.origin);
        return;
      }
    }
  }
}

_id_D26B() {
  self.a.rockets = 100;
  _id_E5CC(level._id_EAD6);
}

_id_E5CB() {
  self endon("death");
  self.a.rockets = 100;
  _id_A090();
  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_F40C("enemy", 0, 0);
  thread _id_4E07();
  childthread _id_518E();
  return;
}

_id_E5CC(var_0) {
  if(!isDefined(level._id_A2EF)) {
    self._id_A2EF = scripts\engine\utility::spawn_tag_origin();
  }

  thread _id_514F(self._id_A2EF);
  self endon("death");

  for(;;) {
    if(self cansee(level._id_EAD6)) {
      self._id_A2EF linkTo(var_0, "j_mainroot_ship", (0, 0, 0), (0, 0, 0));
      self clearentitytarget();
      self _meth_82DE(self._id_A2EF);
    } else if(self cansee(level.player)) {
      self._id_A2EF unlink();
      self._id_A2EF.origin = level.player.origin + scripts\engine\utility::randomvector(8);
      self clearentitytarget();
      self _meth_82DE(self._id_A2EF);
    }

    wait 3;
  }
}

_id_514F(var_0) {
  self waittill("death");
  var_0 delete();
}

_id_8B6B(var_0) {
  self endon("death");

  if(scripts\engine\utility::flag("turbine_dogfighting_complete")) {
    var_1 = 625000000;
  } else {
    var_1 = 81000000;
  }

  if(distance2dsquared(self.origin, var_0.origin) > var_1) {
    return 0;
  }

  if(isai(self)) {
    var_2 = self getEye();
  } else {
    var_2 = self gettagorigin("tag_flash");
  }

  var_3 = scripts\common\trace::ray_trace(var_2, var_0.origin, self);

  if(isDefined(var_3["entity"])) {
    if(var_3["entity"] == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_77EB() {
  var_0 = level._id_D127;
  var_1 = undefined;

  if(isDefined(level._id_EAD6)) {
    var_1 = level._id_EAD6;
  }

  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = sortbydistance([var_0, var_1], self.origin);

    foreach(var_4 in var_2) {
      if(_id_8B6B(var_4)) {
        return var_4;
      }
    }
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, var_1);

  if(isDefined(var_6)) {
    if(_id_8B6B(var_6)) {
      return var_6;
    }
  }

  return undefined;
}

_id_12938() {
  level._id_1292A = _id_1292F("turbine_building_1");
}

_id_13770() {
  _id_DA74(["titan_slt_Theresthefirstturbine"]);
}

_id_6DBC() {
  while(!isDefined(level._id_EAD6)) {
    wait 0.05;
  }

  _id_0BDC::_id_A24B("building1_landing_pad", 0);
  _id_0BDC::_id_A06A(0);
  scripts\engine\utility::flag_wait_all("missile_boats_destroyed", "arena_jackals_destroyed");
  _id_0BDC::_id_A1A9(1);
  wait 2;
  _id_0BDC::_id_A24B("building1_landing_pad", 1);
  _id_0BDC::_id_A06A(1);
  thread _id_D1B5();
  thread _id_A7F8();
  thread _id_EAD1();
  level.player scripts\sp\utility::_id_65E8("flag_player_has_jackal");
}

_id_A7F8() {
  setmusicstate("");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_lookslikewereclear");
  wait 2;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_youcanopentheturbine");
}

_id_A7D2() {
  scripts\engine\utility::flag_set("landed_turbine_vision_fx");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_BC52("turbine_building_1_player");
  thread scripts\sp\maps\titan\titan_hot_landing::_id_F9D0();
  level.player scripts\sp\utility::_id_65E1("flag_player_is_landing");
  level.player scripts\sp\utility::_id_65E1("flag_player_dismounting");
  level._id_D223 = _id_0BDC::_id_1079F("player_rooftop_jackal", "turbine_building_1_jackal");
  level._id_D223 _id_0BDC::_id_A07D();
  level._id_1F8C = 1;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_10732();
  var_0 = getEntArray("player_trigs", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::_id_D30B);
  _id_0BDC::_id_CF50(0);
  _id_0BDC::_id_A24B("building1_landing_pad", 0);
  thread _id_0BDC::_id_A159(1);
  level thread _id_D0B3();
  level thread _id_2EDF();
  level thread _id_3A97();
  _id_12938();
  scripts\engine\utility::flag_set("player_landed_building1");
  _id_EADE();
  scripts\engine\utility::exploder("fx_splash_field");
}

_id_A7D1() {
  scripts\engine\utility::flag_set("landed_turbine_vision_fx");
  _id_A7D0();

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F530(0);
  }

  var_0 = scripts\engine\utility::flag_wait_any_return("turbine1_destroyed", "turbine2_destroyed");
  thread _id_A7CF();
  _id_0BDC::_id_137CF();

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F530(1);
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_D24F();
  _id_13794();
  setsaveddvar("sm_sunsamplesizenear", 32);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 1);
  thread _id_D6E9();
}

#using_animtree("jackal");

_id_A7D0() {
  _id_0BDC::_id_CF50(0);
  level._id_A056._id_12F96[0] _id_0BDC::_id_A07D();
  level._id_A056._id_12F96[0]._id_BBC9 = % titan_jackal_plr_board;
  level._id_A056._id_12F96[0]._id_BBCA = % titan_jackal_jackal_board;
  level._id_A056._id_12F96[0] _id_0BDC::_id_F48D("default_landed");
  level._id_A056._id_12F96[0] _id_0BDC::_id_F420(undefined, 75, undefined, undefined, 0);
}

_id_13794() {
  level.player endon("death");
  var_0 = getEnt("turbine_landing_pad_exit_trigger", "targetname");

  for(;;) {
    if(isDefined(level._id_D127) && !level._id_D127 istouching(var_0)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_D6E9() {
  var_0 = scripts\engine\utility::getStruct("turbine_exit_jackal_lookat", "targetname");
  _id_0BDC::_id_D165(var_0, 1, 1, 1);
  wait 3;
  level.player _meth_8463("lookat");
}

_id_A7CE() {}

_id_A7CF() {
  level.player waittill("mount_link_complete");
  _id_0BDC::_id_A24B("building1_landing_pad", 0);
  level._id_6753 scripts\sp\utility::_id_54F7();
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = level._id_A056._id_12F96[0].origin;
  var_0.angles = level._id_A056._id_12F96[0].angles;
  level._id_6753._id_1FBB = "turbine_eth3n";
  var_0 scripts\sp\anim::_id_1F35(level._id_6753, "mount_turbine_jackal");
  level._id_6753 delete();
}

_id_11990() {
  wait 2;
  setmusicstate("mx_018_refinerycombat");
}

_id_7A6B(var_0) {
  var_1 = undefined;

  if(var_0 == "turbine_building_1") {
    var_1 = "building1_landing_pad";
  }

  return _id_7A67(var_1);
}

_id_7A66(var_0) {
  if(var_0 == "building_1") {
    return "building1_landing_pad";
  } else {
    return undefined;
  }
}

_id_137E5(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = 10;
  var_3 = 0;

  for(;;) {
    while(_id_CFB1(var_1.origin)) {
      var_3++;

      if(var_3 >= var_2) {
        level notify("player_sees_" + var_1.targetname);
        return;
      }

      wait 0.05;
    }

    var_3 = 0;
    wait 0.05;
  }
}

_id_137EE(var_0) {
  level endon("stop_waittill_player_sees_salter_ship");
  thread scripts\sp\utility::_id_C12D("stop_waittill_player_sees_salter_ship", var_0);
  var_1 = _id_137ED();
  return var_1;
}

_id_137ED(var_0) {
  level endon("stop_waittill_player_sees_salter_ship");
  var_1 = 0;

  if(!isDefined(var_0)) {
    var_0 = 5;
  }

  while(var_1 != var_0) {
    if(_id_CFB1(level._id_EAD6.origin + (0, 0, 100))) {
      var_1++;
      wait 0.05;
      continue;
    } else {
      var_1 = 1;
      wait 0.05;
      continue;
    }

    wait 0.15;
  }

  return 1;
}

_id_780F(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;

  if(!isDefined(var_0)) {
    var_0 = 3;
  }

  while(var_3 != var_0) {
    var_2 = undefined;

    while(!isDefined(var_2)) {
      var_2 = _id_78CA();
      wait 0.05;
    }

    if(!isDefined(var_1)) {
      var_1 = var_2;
      var_3++;
      continue;
    } else if(var_1 == var_2) {
      var_3++;
      continue;
    } else if(var_1 != var_2) {
      var_3 = 1;
      var_1 = undefined;
      continue;
    }

    wait 0.25;
  }

  return var_1;
}

_id_23A0() {
  thread scripts\sp\utility::_id_56BA("jackal_assault");

  while(isDefined(level._id_D127) && level._id_D127.spaceship_mode != "hover" && level.player scripts\sp\utility::_id_65DB("flag_player_is_flying")) {
    wait 0.1;
  }
}

_id_EADD(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_6 = distance(self.origin, var_0);
    var_4 = var_6 * 0.3;
    scripts\engine\utility::ter_op(var_4 > 1000, 1000, var_4);
  }

  if(!isDefined(var_1)) {
    var_1 = 400;
  }

  if(!isDefined(var_5)) {
    var_5 = var_1 * 0.3;
  }

  self _meth_845F(var_1, var_5);

  if(isDefined(var_3)) {
    _id_0BDC::_id_A1EC(var_0, var_2, var_4, var_3);
  } else {
    _id_0BDC::_id_A1EC(var_0, var_2, var_4);
  }
}

_id_A1D9() {
  var_0 = scripts\engine\utility::getStruct("building_1", "targetname");
  var_1 = _id_0BDC::_id_1079F("player_rooftop_jackal", "building_1");
  var_1 vehicle_teleport(var_1.origin + (0, 0, 300), var_1.angles);
  _id_0BDC::_id_10CD1(var_1);
  thread _id_EAB3();
}

_id_D900() {
  _id_0BDC::_id_137CF();

  for(;;) {
    iprintlnbold(length(level._id_D127.spaceship_vel));
    wait 0.05;
  }
}

_id_EAB3() {
  wait 1;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_10732();
  level._id_EAD6 _id_73CB(_id_0BDC::_id_7BBA(), 1);
  var_0 = scripts\engine\utility::getStruct("jackal_cave_spot", "targetname");
  var_1 = scripts\engine\utility::getStruct("building_2", "targetname");
  var_2 = scripts\engine\utility::getStruct("building_1", "targetname");
  var_3 = [var_0.origin, var_1.origin, var_0.origin, var_2.origin];
  level._id_EAD6 _id_10589(var_3);
}

_id_10589(var_0) {
  self endon("stop_leading_player");
  scripts\asm\asm_bb::bb_setanimScripted();
  self._id_AAE5 = spawnStruct();

  if(isarray(var_0)) {
    self._id_AAE5.targets = var_0;
    self._id_AAE5._id_11537 = self._id_AAE5.targets[0];
    self._id_AAE5.targets = scripts\engine\utility::array_remove(self._id_AAE5.targets, self._id_AAE5.targets[0]);
  } else
    self._id_AAE5._id_11537 = var_0;

  self _meth_8455(self._id_AAE5._id_11537, 1);
  _id_0BDC::_id_19B2("face motion");
  childthread _id_10598();
  wait 0.05;
  childthread _id_1059A();
  wait 0.05;
  childthread _id_10599();
}

_id_1059A() {
  for(;;) {
    if(_id_CFB1(self.origin, undefined, undefined, self)) {
      self._id_AAE5._id_CFB2 = 1;
    } else {
      self._id_AAE5._id_CFB2 = 0;
    }

    wait 0.05;
  }
}

_id_10598() {
  self._id_AAE5._id_D02A = distancesquared(level._id_D127.origin, self._id_AAE5._id_11537);
  self._id_AAE5._id_D23B = 1;

  for(;;) {
    self._id_AAE5._id_BF0F = distancesquared(level._id_D127.origin, self._id_AAE5._id_11537);

    if(self._id_AAE5._id_BF0F <= 9000000) {
      if(isDefined(self._id_AAE5.targets)) {
        self._id_AAE5.targets = scripts\engine\utility::array_remove(self._id_AAE5.targets, self._id_AAE5._id_11537);

        if(self._id_AAE5.targets.size > 0) {
          self._id_AAE5._id_11537 = self._id_AAE5.targets[0];
          wait 0.5;
          continue;
        } else {
          self notify("player_reached_follow_goal");
          thread scripts\sp\utility::_id_C12D("stop_leading_player", 0.5);
          return;
        }
      } else {
        self notify("player_reached_follow_goal");
        thread scripts\sp\utility::_id_C12D("stop_leading_player", 0.5);
        return;
      }
    }

    if(self._id_AAE5._id_BF0F < self._id_AAE5._id_D02A) {
      self._id_AAE5._id_D23B = 1;
    } else {
      self._id_AAE5._id_D23B = 0;
    }

    self._id_AAE5._id_D02A = self._id_AAE5._id_BF0F;
    wait 0.05;
  }
}

_id_10599() {
  var_0 = 9500;
  self._id_AAE5._id_2CCE = 0;
  self._id_AAE5._id_D111 = 1;
  self._id_AAE5._id_9B7F = 0;
  self._id_AAE5._id_E1AA = 0;
  self _meth_845F(1);

  for(;;) {
    self _meth_8455(self._id_AAE5._id_11537, 1);
    var_1 = _id_0BDC::_id_7B9E();

    if((!self._id_AAE5._id_D23B || isDefined(level._id_D127.spaceship_mode) && level._id_D127.spaceship_mode == "hover") && !self._blackboard._id_90F3) {
      _id_0BDC::_id_19A4(1);
    } else if(isDefined(level._id_D127.spaceship_mode) && level._id_D127.spaceship_mode == "fly" && self._blackboard._id_90F3) {
      _id_0BDC::_id_19A4(0);
    }

    if(!_id_65EB(level._id_D127)) {
      self._id_AAE5._id_D111 = 1;
      self._id_AAE5._id_D029 = distance(self.origin, _id_0BDC::_id_7BBA());

      if(self._id_AAE5._id_D029 < var_0 * 0.3) {
        var_1 = _id_0BDC::_id_7B9E() * 2;
        self._id_AAE5._id_E1AA = var_1;
        self _meth_845F(var_1);
        self _meth_8485(5);

        if(self._id_AAE5._id_9B7F) {
          self _meth_8459("face motion");
          self._id_AAE5._id_9B7F = 0;
        }
      } else if(self._id_AAE5._id_D029 < var_0 * 0.6) {
        var_1 = _id_0BDC::_id_7B9E() * 1.3;
        self._id_AAE5._id_E1AA = var_1;
        self _meth_845F(var_1);
        self _meth_8485(1.3);
      } else if(self._id_AAE5._id_D029 < var_0) {
        var_1 = _id_0BDC::_id_7B9E() * 0.8;
        self._id_AAE5._id_E1AA = var_1;
        self _meth_845F(var_1);
        self _meth_8485(0.8);

        if(!self._id_AAE5._id_9B7F) {
          self _meth_8459("always");
          self._id_AAE5._id_9B7F = 1;
        }
      } else if(self._id_AAE5._id_D029 > var_0) {
        var_1 = _id_0BDC::_id_7B9E() * 0.1;
        self._id_AAE5._id_E1AA = var_1;
        self _meth_845F(var_1);
        self _meth_8485(0.1);

        if(self._id_AAE5._id_9B7F) {
          self _meth_8459("never");
          self._id_AAE5._id_9B7F = 0;
        }
      }
    } else {
      self._id_AAE5._id_D111 = 0;

      if(!self._id_AAE5._id_2CCE) {
        _id_10597();
      }
    }

    wait 0.05;
  }
}

_id_10597() {
  self._id_AAE5._id_2CCE = 1;
  self _meth_847A();

  if(!self._id_AAE5._id_9B7F) {
    self _meth_8459("always");
    self._id_AAE5._id_9B7F = 1;
  }

  var_0 = 550;
  self._id_AAE5._id_E1AA = var_0;
  self _meth_845F(var_0);
  self _meth_8485(1);
  _id_0BDC::_id_1994(level._id_D127, (3000, 0, 0));

  while(!self._id_AAE5._id_CFB2) {
    wait 2;
  }

  _id_0BDC::_id_19B7();
  self._id_AAE5._id_2CCE = 0;
  self _meth_8455(self._id_AAE5._id_11537, 1);

  if(self._id_AAE5._id_9B7F) {
    self _meth_8459("face motion");
    self._id_AAE5._id_9B7F = 0;
  }
}

_id_65EB(var_0) {
  var_1 = vectorNormalize(self.origin - var_0.origin);
  var_2 = anglesToForward(var_0.angles);
  var_3 = vectordot(var_2, var_1);
  return var_3 < 0;
}

_id_2F49(var_0) {
  if(var_0 == "building_1") {
    var_1 = level._id_1292A;
  } else {
    var_1 = level._id_1292B;
  }

  thread _id_134B9();
  _id_10657();
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  var_2 = getnodearray("friendly_left1", "targetname");
  var_3 = scripts\engine\utility::getclosest(level._id_2F46.origin, var_2);
  var_2 = getnodearray("friendly_left2", "targetname");
  var_4 = scripts\engine\utility::getclosest(level._id_2F47.origin, var_2);
  level._id_2F46 thread _id_0B77::_id_8409(var_3, undefined, ::_id_2F4B);
  level._id_2F47 thread _id_0B77::_id_8409(var_4);
  scripts\engine\utility::flag_wait("salter_at_button");
  var_1._id_32D9 notify("trigger", level._id_2F46);
}

_id_10657() {
  var_0 = getEntArray("bravo_spawner", "targetname");
  var_1 = scripts\engine\utility::getclosest(_id_0BDC::_id_7BBA(), var_0);
  level._id_2F46 = var_1 scripts\sp\utility::_id_10619(1, 1);
  wait 0.05;
  level._id_2F47 = var_1 scripts\sp\utility::_id_10619(1, 1);
  level._id_2F4C = [level._id_2F46, level._id_2F47];

  foreach(var_3 in level._id_2F4C) {
    var_3 scripts\sp\utility::_id_F40A("friendly", 0, 0);
    var_3 scripts\sp\utility::_id_51E1("frantic");
  }
}

_id_2F4B(var_0) {
  if(isDefined(var_0.script_noteworthy)) {} else
    return;

  level._id_EA60 = [];
  wait 4;
  var_1 = 8;
  var_2 = _id_787C(var_0.script_noteworthy, "script_noteworthy");

  if(!isDefined(var_2)) {
    if(scripts\engine\utility::flag_exist(var_0.script_noteworthy)) {
      scripts\engine\utility::flag_set(var_0.script_noteworthy);
    }

    return;
  }

  level notify("new_bravo_enemies");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_1381E(var_2, var_1);
  var_3 = var_2 scripts\sp\utility::_id_77E3("axis");

  if(isDefined(var_3.size) && var_3.size > 0) {
    scripts\sp\maps\titanjackal\titanjackal_code::_id_A5E5(var_3);
  }

  scripts\engine\utility::flag_set(var_0.script_noteworthy);
}

_id_134B9() {
  if(scripts\engine\utility::cointoss()) {
    scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_plr_roger");
  } else {
    scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_plr_copy");
  }

  _id_137E8();
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_plr_igoteyeson");

  while(!level.player attackButtonPressed()) {
    wait 0.05;
  }

  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_plr_engagingtargets");
  scripts\engine\utility::flag_wait("salter_ground_stop1");
  level waittill("new_bravo_enemies");
  var_0 = _id_137E8(undefined, undefined, 4);

  if(isDefined(var_0)) {
    scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_plr_incominghostiles");
  } else {
    scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_yougotavisual");
  }

  scripts\engine\utility::flag_wait("salter_ground_stop3");
  wait 6;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_13782([level._id_2F46]);
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_couldusealittle");
}

_id_107BF(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    thread scripts\sp\maps\titanjackal\titanjackal_code::_id_8258(var_2);
    wait 0.1;
  }
}

_id_1163C(var_0) {
  self endon("at_botton");
  wait 5;

  if(scripts\engine\utility::player_is_in_jackal()) {
    while(_id_CFB1(self.origin)) {
      wait 0.15;
    }
  } else {
    while(scripts\sp\utility::_id_CFAC(level._id_EA2C)) {
      wait 0.15;
    }
  }

  self _meth_80F1(var_0.origin, var_0.angles, 999999);
}

_id_EA3B(var_0) {
  var_1 = _id_7908();
  var_2 = undefined;

  if(var_1 == "building1") {
    var_2 = "building1_attack";
    var_3 = "building_1";
  }

  _id_C9C5(1);
  level._id_EAD6 _id_EA50();
  level._id_EAD6 _meth_8455(level._id_EAD6.origin, 1, level._id_EAD6.angles);
  var_4 = scripts\engine\utility::spawn_tag_origin(var_0._id_4D27.origin);
  var_4.team = "axis";
  thread _id_EAEC(var_4);
  level waittill("destroy_turbine_event");
  thread _id_52B9(var_0);
  level._id_EAD6 _id_0BDC::_id_1988();
  thread _id_EAF3();
  _id_C9C5(0);
}

_id_EAEC(var_0) {
  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_DangercloseReese");

  for(var_1 = 0; var_1 < 2; var_1++) {
    level._id_EAD6 _id_0B76::_id_1992("tag_flash", var_0, 0);
    wait 0.35;
    level._id_EAD6 _id_0B76::_id_1992("tag_flash_2", var_0, 0);
  }

  wait 0.5;
  level notify("destroy_turbine_event");
}

_id_EA50() {
  var_0 = scripts\engine\utility::getStruct("salter_turbine_node", "targetname");
  self._id_1FBB = "salter_ship";
  var_0 scripts\sp\anim::_id_1F35(self, "turbine_attack");
}

_id_EAF3() {
  var_0 = level._id_D223;
  var_1 = var_0 scripts\sp\maps\titanjackal\titanjackal_code::_id_79D9(1000, var_0.angles, 1);
  var_2 = var_1 + (0, 0, 450);
  _id_C9C5(1);
  level._id_EAD6 _id_EADD(var_2, 150, 1, var_0.angles);
}

_id_D30B() {
  level endon("disable_trigger_guide_logic");
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  if(!isDefined(var_0) || _id_9BCB(var_0)) {
    return;
  }
  self endon("death");
  self endon("entiydeleted");

  for(;;) {
    self waittill("trigger", var_1);

    if(var_1 != level.player) {
      wait 0.05;
      continue;
    }

    if(!isDefined(level.player._id_A8C8)) {
      level.player._id_A8C8 = self;
    } else if(level.player._id_A8C8 == self || level._id_EAD6 scripts\sp\utility::_id_65DB("pause_scripted_behavior")) {
      wait 1;
      continue;
    } else if(level.player._id_A8C8 != self)
      level.player._id_A8C8 = self;

    scripts\sp\utility::_id_EF15();

    if(isDefined(self._id_EDA0)) {
      scripts\engine\utility::flag_wait(self._id_EDA0);
    }

    level._id_EAD6 thread _id_90D0(var_0);
    wait 1;
  }
}

_id_90D0(var_0, var_1) {
  self endon("death");
  self notify("new_hover_spots");
  self endon("new_hover_spots");
  self endon("stop_hovering_between_structs");
  self _meth_8457("face angle", self.angles);
  _id_0BDC::_id_19B7();
  wait 0.05;

  while(scripts\sp\utility::_id_65DB("pause_scripted_behavior")) {
    scripts\engine\utility::waitframe();
  }

  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = 150;
  }

  _id_EADD(var_0[0].origin, var_2, 1, var_0[0].angles);

  if(var_0.size == 1) {
    return;
  }
  var_3 = var_0[0];

  for(;;) {
    foreach(var_5 in var_0) {
      if(scripts\sp\utility::_id_65DB("pause_scripted_behavior")) {
        scripts\engine\utility::waitframe();
        continue;
      }

      self _meth_8457("face angle", self.angles);
      _id_EADD(var_5.origin, 120, 1, var_5.angles, 24);
      wait(randomintrange(4, 7));
    }
  }

  wait 0.1;
}

_id_9BCB(var_0) {
  if(isDefined(var_0.size) && var_0.size == 0) {
    return 1;
  }

  return 0;
}

_id_EA39() {
  self endon("stop_attacking_with_player");
  _id_0BDC::_id_19B7();
  var_0 = scripts\engine\utility::getStructArray("salter_attack_points", "targetname");
  var_1 = 50000;

  foreach(var_3 in var_0) {
    var_4 = distance2d(var_3.origin, _id_0BDC::_id_7BBA());

    if(var_4 > var_1) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_3);
    }
  }

  scripts\asm\asm_bb::bb_setanimScripted();
  self._id_4B42 = scripts\engine\utility::random(var_0);
  self notify("stop_friendly_wingman");
  self _meth_847A();
  _id_0BDC::_id_19B7();
  var_6 = _id_0BDC::_id_7B9E();

  if(var_6 >= 100) {
    var_7 = var_6 * 1.8;
  } else {
    var_7 = 400;
  }

  _id_EADD(var_0[0].origin, var_7, 1, var_0[0].angles);
  childthread _id_EAED();

  for(;;) {
    var_8 = _id_CB1E(var_0);
    self._id_4B42 = var_8;
    var_9 = 95;

    while(isDefined(self.is_shooting)) {
      wait 0.05;
    }

    self._id_9B87 = 1;
    _id_EADD(var_8.origin, var_9, 1, var_8.angles);
    self._id_9B87 = undefined;
    _id_1367B();
  }
}

_id_EAED() {
  _id_0BDC::_id_19AE("dont_shoot");
  _id_0BDC::_id_19AA("spaceship_cannon_projectile");

  for(;;) {
    if(isDefined(self._id_9B87)) {
      wait 0.25;
      continue;
    }

    var_0 = getaispeciesarray("axis", "human");
    var_1 = getEntArray("misc_turret", "classname");
    var_2 = scripts\engine\utility::array_combine(var_0, var_1);
    var_2 = _id_E00F(self.origin, var_2);
    var_2 = sortbydistance(var_2, self.origin);

    foreach(var_4 in var_2) {
      if(_id_A1F5(self, var_4)) {
        _id_105C7([var_4], 1);
        break;
      }
    }

    wait 0.25;
  }
}

_id_A0B1(var_0) {
  var_1 = vectortoangles(var_0.origin - self.origin);
  self _meth_846A(var_0);
  wait 0.15;

  if(isDefined(var_0)) {
    _id_0BDC::_id_19AE("shoot_now");
    wait 2.5;
    _id_10577();
  }
}

_id_E00F(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    if(distance2d(var_4.origin, var_0) > 400000000) {
      continue;
    }
    if(isai(var_4) && !isalive(var_4)) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_CB1E(var_0) {
  foreach(var_2 in var_0) {
    if(_id_CFB1(var_2.origin) && self._id_4B42 != var_2) {
      return var_2;
    }
  }

  return scripts\engine\utility::random(var_0);
}

_id_1367B() {
  self endon("emergency_move");
  var_0 = randomintrange(6, 9);
  thread _id_6121();
  scripts\sp\utility::_id_C12D("timeout", var_0);
}

_id_6121() {
  self endon("timeout");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_0 > 75) {
      self notify("emergency_move");
      return;
    }
  }
}

_id_EA3A() {
  self endon("stop_attack_player_enemies");

  if(isDefined(self._id_86C2)) {
    self._id_86C2 = spawn("script_origin", self.origin);
    self._id_86C2 linkTo(self, "tag_spotlight", (0, 0, 0), (0, 0, 0));
  }

  var_0 = 3;
  var_1 = 6;

  for(;;) {
    if(scripts\sp\utility::_id_65DB("pause_scripted_behavior") || scripts\sp\utility::_id_65DB("pause_scripted_shooting")) {
      wait 1;
      continue;
    }

    var_2 = _id_A1E9();

    if(isDefined(var_2) && isDefined(var_2.size) && var_2.size > 0) {
      scripts\sp\maps\titanjackal\titanjackal_code::_id_137EB(1, var_2, undefined, 4);
      _id_105C7(var_2);
      scripts\engine\utility::delaythread(0.5, ::_id_13503);
    } else {
      wait 0.15;
      continue;
    }

    if(scripts\sp\maps\titanjackal\titanjackal_code::_id_9BF6()) {
      var_0 = 2;
    }

    _id_EAF1(var_0);
    wait 0.05;
  }
}

_id_105C7(var_0, var_1) {
  if(!isDefined(var_1)) {
    thread _id_13506();
  }

  if(_id_9BCB(var_0)) {
    return;
  }
  self.is_shooting = 1;
  var_2 = "jackal_gatling_fire_salt";
  thread scripts\sp\utility::play_loop_sound_on_tag(var_2, "tag_spotlight", 1, 1, "jackal_gatling_release");

  foreach(var_4 in var_0) {
    if(isDefined(var_4)) {
      var_5 = vectortoangles(var_4.origin - self.origin);
      _id_0BDC::_id_19B2("face angle", var_5);
      _id_1059B(var_4, randomintrange(15, 20), 1, 3);
    }
  }

  self notify("stop sound" + var_2);
  self.is_shooting = undefined;
}

_id_10577(var_0, var_1) {
  var_2 = gettime() + var_1 * 1000;
  var_3 = "scn_jackal_gatling_fire_salt";
  var_4 = "tag_flash";
  level._id_EAD6 thread scripts\sp\utility::play_loop_sound_on_tag(var_3, "tag_spotlight", 1, 1, "jackal_streak_gatling_release");

  while(var_2 >= gettime() || !isDefined(var_0)) {
    level._id_EAD6 fireweapon(var_4, var_0, scripts\engine\utility::randomvectorrange(-128, 128));

    if(var_4 == "tag_flash") {
      var_4 = "tag_flash_2";
    } else {
      var_4 = "tag_flash";
    }

    wait 0.1;
  }

  level._id_EAD6 scripts\engine\utility::stop_loop_sound_on_entity(var_3);
}

_id_105D1(var_0, var_1) {
  _id_C9C5(1);
  var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_3 = scripts\engine\utility::getclosest(level.player.origin, var_2, 20000);
  var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
  var_5 = level.player scripts\engine\utility::spawn_tag_origin();
  var_5 hide();
  var_5.origin = var_3.origin;
  var_6 = 3;
  var_5 moveTo(var_4.origin, var_6);
  var_7 = "scn_jackal_gatling_fire_salt";
  level._id_EAD6 thread scripts\sp\utility::play_loop_sound_on_tag(var_7, "tag_spotlight", 1, 1, "jackal_streak_gatling_release");
  scripts\engine\utility::delaythread(0.5, ::_id_105D0, var_5);
  level._id_EAD6 _id_10577(var_5, 3);
  level._id_EAD6 scripts\engine\utility::stop_loop_sound_on_entity(var_7);
  level._id_EAD6 notify("stop_shooting");
  level._id_EAD6 scripts\engine\utility::waittill_any_timeout(1, "rockets_done");
  var_5 delete();
  _id_C9C5(0);
}

_id_105D0(var_0) {
  var_1 = ["scripted_jackal_rocket_impact", "scn_jackal_rocket_salt_exp", 5];
  var_2 = "scripted_jackal_rocket_trail";

  for(var_3 = 0; var_3 < 4; var_3++) {
    level._id_EAD6 _id_0B76::_id_1992("tag_flash", var_0, 1, undefined, undefined, undefined, var_2, var_1, 1);
    wait(randomfloatrange(0.25, 0.45));
    level._id_EAD6 _id_0B76::_id_1992("tag_flash_2", var_0, 1, undefined, undefined, undefined, var_2, var_1, 1);
    wait(randomfloatrange(0.25, 0.45));
  }

  level._id_EAD6 notify("rockets_done");
}

_id_1059C(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    self setturrettargetEnt(var_0);
  } else {
    self _meth_8080();
  }

  self._id_B164 = "tag_flash";
  var_4 = 1;
  self._id_B6B6 = "magic_spaceship_20mm_bullet";

  if(isDefined(var_0)) {
    var_4 = 0;
  }

  var_5 = "jackal_gatling_fire_salt";
  thread scripts\sp\utility::play_loop_sound_on_tag(var_5, "tag_spotlight", 1, 1, "jackal_gatling_release");
  _id_105C6(var_0, var_1, var_2, var_3);
  self notify("stop sound" + var_5);
  self.is_shooting = undefined;
  self _meth_8080();
}

_id_105C6(var_0, var_1, var_2, var_3) {
  self endon(var_1);

  if(isDefined(var_0)) {
    self setturrettargetEnt(var_0);
  } else {
    self _meth_8080();
  }

  self._id_B164 = "tag_flash";
  var_4 = 1;
  self._id_B6B6 = "magic_spaceship_20mm_bullet";

  if(isDefined(var_0)) {
    var_4 = 0;
  }

  for(;;) {
    var_5 = self gettagorigin(self._id_B164) + anglesToForward(self.angles) * 60;

    if(var_4 || !isDefined(var_0)) {
      var_6 = var_5 + anglesToForward(self.angles) * 1000;
    } else {
      var_6 = _id_7BF2(var_0.origin + (0, 0, 50), var_2, var_3);
    }

    magicbullet(self._id_B6B6, var_5, var_6, undefined, level._id_EAD6);
    wait 0.05;

    if(self._id_B164 == "tag_flash") {
      self._id_B164 = "tag_flash_2";
      continue;
    }

    self._id_B164 = "tag_flash";
  }
}

_id_1059B(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    self setturrettargetEnt(var_0);
  } else {
    self _meth_8080();
  }

  self._id_B164 = "tag_flash";
  var_4 = 1;
  self._id_B6B6 = "magic_spaceship_20mm_bullet";

  if(isDefined(var_0)) {
    var_4 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = randomintrange(15, 25);
  }

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = self gettagorigin(self._id_B164) + anglesToForward(self.angles) * 60;

    if(var_4 || !isDefined(var_0)) {
      var_7 = var_6 + anglesToForward(self.angles) * 1000;
    } else {
      var_7 = _id_7BF2(var_0.origin + (0, 0, 50), var_2, var_3);
    }

    magicbullet(self._id_B6B6, var_6, var_7, undefined, level._id_EAD6);
    wait 0.05;

    if(self._id_B164 == "tag_flash") {
      self._id_B164 = "tag_flash_2";
      continue;
    }

    self._id_B164 = "tag_flash";
  }

  self _meth_8080();
}

_id_7BF2(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    if(isDefined(var_1)) {
      return var_0 + scripts\engine\utility::randomvectorrange(var_1, var_2);
    } else {
      return var_0 + scripts\engine\utility::randomvectorrange(0, var_2);
    }
  } else if(isDefined(var_1)) {
    if(isDefined(var_2)) {
      return var_0 + scripts\engine\utility::randomvectorrange(var_1, var_2);
    } else {
      return var_0 + scripts\engine\utility::randomvectorrange(0, var_1);
    }
  }

  return var_0;
}

_id_EAF1(var_0) {
  self endon("done_waiting");
  thread scripts\sp\utility::_id_C12D("done_waiting", var_0);

  while(!_id_D205()) {
    wait 0.2;
  }
}

_id_D205() {
  return level.player scripts\sp\utility::_id_65DB("player_has_red_flashing_overlay");
}

_id_13502() {
  level.player endon("flag_player_has_jackal");

  for(;;) {
    if(level._id_EAD6 scripts\sp\utility::_id_65DB("pause_scripted_behavior")) {
      wait 1;
      continue;
    }

    var_0 = getaiarray("axis");
    var_1 = scripts\engine\utility::getclosest(_id_0BDC::_id_7BBA(), var_0, 250);

    if(isDefined(var_1)) {
      _id_13507(var_1);
      wait 1;
      continue;
    }

    wait 1;
  }
}

_id_13507(var_0) {
  if(isDefined(level._id_EAD6._id_A89A) && gettime() - level._id_EAD6._id_A89A <= 5000) {
    return;
  }
  var_1 = _id_7B8D(var_0.origin);

  if(level.player scripts\sp\maps\titanjackal\titanjackal_code::_id_10A5C(var_0.origin, 200)) {
    return undefined;
  }

  var_2 = undefined;

  if(isDefined(var_1)) {
    switch (var_1) {
      case "forward_left":
      case "forward_right":
      case "forward":
        var_2 = undefined;
        break;
      case "behind_right":
      case "behind_left":
      case "behind":
        var_2 = "titan_slt_behindyou";
        break;
      case "left":
        var_2 = "titan_slt_targetsleft";
        break;
      case "right":
        var_2 = "titan_slt_onyourright";
        break;
    }
  }

  if(isDefined(var_2)) {
    scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7(var_2, 1);
  }

  if(!isDefined(level._id_EAD6._id_A89A)) {
    if(!scripts\sp\maps\titanjackal\titanjackal_code::_id_9BF6()) {
      scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_hestooclosecant", 1);
    }
  }

  level._id_EAD6._id_A89A = gettime();
}

_id_13503() {
  if(!isDefined(level._id_EAD6._id_A926)) {
    level._id_EAD6._id_A926 = gettime();
    _id_EAAF();
    return;
  }

  if(gettime() - level._id_EAD6._id_A926 >= 20000) {
    level._id_EAD6._id_A926 = gettime();
    _id_EAAF();
    return;
  }
}

_id_EAAF() {
  var_0 = ["titan_slt_targetsdown", "titan_slt_enemiesdown", "titan_slt_theyredown", "titan_slt_gotem"];

  if(!isDefined(level._id_A8D8)) {
    level._id_A8D8 = scripts\engine\utility::random(var_0);
  }

  for(var_1 = scripts\engine\utility::random(var_0); var_1 == level._id_A8D8; var_1 = scripts\engine\utility::random(var_0)) {}

  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7(var_1);
  level._id_A8D8 = var_1;
  _id_134C1();
}

_id_134C1() {
  if(_id_9B8D()) {
    scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_clearahead");
  }
}

_id_9B8D() {
  var_0 = getaispeciesarray("axis", "human");

  foreach(var_2 in var_0) {
    if(scripts\sp\maps\titanjackal\titanjackal_code::_id_9C18(var_2) && var_2 _id_9B46(level.player)) {
      return 0;
    }
  }

  return 1;
}

_id_9B46(var_0) {
  if(isDefined(self.ignoreall) && self.ignoreall) {
    return 0;
  }

  if(isDefined(self.enemy) && self.enemy == level.player && self cansee(level.player)) {
    return 1;
  }

  if(distance2d(self.origin, var_0.origin) < 1300) {
    return 1;
  }

  return 0;
}

_id_134DD() {
  scripts\engine\utility::flag_wait("turbine_stairs_arrive");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_1381F("salter_ground_stop3", "script_noteworthy");
  wait 2;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_letsgokeepmoving");
}

_id_134FC() {
  level endon("turbine1_destroyed");
  scripts\engine\utility::flag_wait("cargoship_moment_finished");
  level.player scripts\sp\utility::_id_65E3("player_has_red_flashing_overlay");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_plr_handleit");
}

_id_13506() {
  if(!isDefined(level._id_EAD6._id_A927)) {
    level._id_EAD6._id_A927 = gettime();
    _id_EAE8();
    return;
  }

  if(gettime() - level._id_EAD6._id_A927 >= 10000) {
    level._id_EAD6._id_A927 = gettime();
    _id_EAE8();
    return;
  }
}

_id_EAE8() {
  var_0 = ["titan_slt_grabsomecover", "titan_slt_igoteyeson", "titan_slt_iseeemengaging", "titan_slt_engaginghostiles"];

  if(!isDefined(level._id_A893)) {
    level._id_A893 = scripts\engine\utility::random(var_0);
  }

  for(var_1 = scripts\engine\utility::random(var_0); var_1 == level._id_A893; var_1 = scripts\engine\utility::random(var_0)) {}

  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7(var_1);
  level._id_A893 = var_1;

  if(randomint(100) < 26) {
    scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_plr_roger2");
  }
}

_id_EA3C(var_0) {
  scripts\engine\utility::waittill_notify_or_timeout("shoot_turbine", 15);

  if(var_0 == "building1") {
    var_1 = level._id_1292A;
  } else {
    var_1 = level._id_1292B;
  }

  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_DangercloseReese");
  scripts\engine\utility::delaythread(1, _id_0BDC::_id_B156, 3, var_1._id_4D27);
  thread scripts\sp\utility::play_loop_sound_on_tag("jackal_gatling_fire_salt", "tag_spotlight", 1, 1, "jackal_gatling_release");
  _id_1059B(undefined, 40);
  self notify("stop soundjackal_gatling_fire_salt");
  thread _id_52B9(var_1);
}

_id_A1E8() {
  var_0 = getaiarray("axis");

  if(!var_0.size) {
    return undefined;
  }

  foreach(var_2 in var_0) {
    if(level.player scripts\sp\utility::_id_CFAC(var_2) && _id_A1F5(level._id_EAD6, var_2)) {
      return var_2;
    }

    if(scripts\engine\utility::within_fov(_id_0BDC::_id_7BBA(), _id_0BDC::_id_7BB9(), var_2.origin, cos(65)) && _id_A1F5(level._id_EAD6, var_2)) {
      return var_2;
    }
  }

  return undefined;
}

_id_A1E9(var_0) {
  var_1 = getaispeciesarray("axis", "human");
  var_2 = [];

  if(!var_1.size) {
    return undefined;
  }

  foreach(var_4 in var_1) {
    if(level._id_EAD6 _id_199A(var_4) && _id_A1F5(level._id_EAD6, var_4)) {
      var_2[var_2.size] = var_4;
    }

    if(isDefined(var_0) && var_2.size == var_0) {
      return var_2;
    }
  }

  if(var_2.size > 0) {
    return var_2;
  }

  return undefined;
}

_id_A1F5(var_0, var_1) {
  if(!scripts\engine\utility::player_is_in_jackal()) {
    if(level.player scripts\sp\maps\titanjackal\titanjackal_code::_id_10A5C(var_1.origin, 300)) {
      return 0;
    }
  }

  var_2 = 250;

  if(var_1 scripts\sp\maps\titanjackal\titanjackal_code::_id_9BBC(var_2)) {
    return 0;
  }

  var_3 = var_0 gettagorigin("tag_flash_right");
  var_4 = var_1.origin + (0, 0, 10);
  var_5 = scripts\common\trace::create_contents(1, 1, 0, 1, 1, 1);
  var_6 = scripts\common\trace::ray_trace(var_3, var_4, undefined, var_5, 1);

  if(isDefined(var_6["entity"]) && var_6["entity"] == var_1) {
    return 1;
  }

  if(isDefined(var_6["fraction"]) && var_6["fraction"] > 0.98) {
    if(randomint(100) < 41) {
      return 1;
    }

    return 0;
  }

  return 0;
}

_id_199A(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = var_0.origin - self.origin;
  var_1 = vectorNormalize(var_1);
  var_2 = vectorNormalize(var_2);
  var_3 = vectordot(var_1, var_2) > 0.94;
  return var_3;
}

_id_1292F(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_1 = scripts\engine\utility::array_combine(var_1, var_2);
  var_3 = spawnStruct();

  foreach(var_5 in var_1) {
    if(isDefined(var_5.classname) && var_5.classname == "script_origin") {
      var_3._id_32D9 = var_5;
      continue;
    }

    if(isDefined(var_5.classname) && var_5.classname == "trigger_multiple") {
      var_3.trigger = var_5;
      continue;
    }

    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "fan") {
      var_3._id_6B7C = var_5;
      continue;
    }

    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "player_button_anim") {
      var_3._id_CF56 = var_5;
      continue;
    }

    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "blade_damage_trig") {
      var_3._id_4D27 = var_5;
    }
  }

  var_3._id_6E88 = getEnt("new_flaps", "script_noteworthy");
  var_3._id_9A62 = getEnt("turbine_destroyed", "targetname");
  var_3._id_994E = getEnt("turbine_intact", "targetname");

  if(isDefined(var_3._id_9A62)) {
    var_3._id_9A62 hide();
  }

  thread _id_12937(var_3);
  var_7 = scripts\engine\utility::getStructArray("turbine_lights", "script_noteworthy");
  var_8 = [];
  var_9 = scripts\engine\utility::spawn_tag_origin();

  foreach(var_12, var_11 in var_7) {
    var_9.origin = var_11.origin;

    if(var_9 istouching(var_3.trigger)) {
      var_8[var_12] = spawnfx(scripts\engine\utility::getfx("vfx_tb_light_red_blinking"), var_11.origin);
    }
  }

  var_3.lights = var_8;
  var_9 delete();
  var_3.trigger delete();
  var_13 = undefined;

  if(var_0 == "turbine_building_1") {
    var_13 = "building1_landing_lights";
  }

  var_3._id_A7F3 = [];
  var_14 = scripts\engine\utility::getStructArray(var_13, "targetname");

  foreach(var_12, var_11 in var_14) {
    var_3._id_A7F3[var_12] = spawnfx(scripts\engine\utility::getfx("vfx_tb_light_white_steady"), var_11.origin);
    triggerfx(var_3._id_A7F3[var_12]);
  }

  if(var_0 == "turbine_building_1") {
    var_16 = getEnt("building1_ai_bucket", "targetname");
  } else {
    var_16 = getEnt("building2_ai_bucket", "targetname");
  }

  var_3.spawners = [];
  var_17 = ["jackal_rocket_guys", "jackal_lmg"];

  foreach(var_19 in var_17) {
    var_20 = getEntArray(var_19, "script_noteworthy");

    foreach(var_22 in var_20) {
      if(var_22 istouching(var_16)) {
        var_3.spawners = scripts\engine\utility::array_add(var_3.spawners, var_22);
      }
    }
  }

  thread _id_12932(var_3);
  thread _id_12935(var_3);
  return var_3;
}

_id_12931() {
  level endon("disable_turbine_hint");
  var_0 = ["titan_slt_Theturbinecontrolsshould", "titan_slt_usethecontrolstoopen"];
  scripts\engine\utility::flag_wait("control_room_clear");
  scripts\sp\utility::_id_56BE("turbine_button_hint", 5);
  wait 30;

  for(;;) {
    if(distance(self.origin, level.player.origin) < 1500) {
      scripts\sp\utility::_id_56BE("turbine_button_hint", 5);

      if(var_0.size > 0) {
        scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8(var_0[0]);
        var_0 = scripts\engine\utility::array_remove(var_0, var_0[0]);
      }
    }
  }
}

_id_12932(var_0) {
  var_1 = scripts\sp\utility::_id_10639("turbine_console", var_0._id_CF56.origin, var_0._id_CF56.angles);
  var_1._id_1FBB = "turbine_console";
  var_0._id_CF56 scripts\sp\anim::_id_1EC3(var_1, "turbine_button_push");
  var_0._id_32D9 thread _id_12931();
  thread _id_134BD(var_0._id_32D9);
  var_0._id_32D9 show();
  var_0._id_32D9 _id_0E46::_id_48C4(undefined, (0, 0, 2), &"TITANJACKAL_TURBINE_INTERACT", undefined, 1500, 32);
  var_0._id_32D9 waittill("trigger", var_2);
  _id_54FE();
  level notify("disable_turbine_hint");
  level notify("disable_trigger_guide_logic");
  level.player playSound("scn_meth_turbine_console_foley");
  _id_40D4();

  if(var_0._id_32D9.targetname == "turbine_building_1") {
    scripts\engine\utility::flag_set("turbine1_exposed");
    var_3 = "building1_red_light";
  }

  if(var_2 == level.player) {
    if(!isDefined(level.player._id_1E9C)) {
      level.player._id_1E9C = scripts\sp\utility::_id_10639("player_rig", var_0._id_CF56.origin, var_0._id_CF56.angles);
      level.player._id_1E9C hide();
    } else {
      level.player._id_1E9C hide();
      level.player._id_1E9C.origin = var_0._id_CF56.origin;
      level.player._id_1E9C.angles = var_0._id_CF56.angles;
    }

    var_0._id_CF56 scripts\sp\anim::_id_1EC3(level.player._id_1E9C, "turbine_button_push");
    level.player.ignoreme = 1;
    scripts\sp\maps\titanjackal\titanjackal_code::_id_D85C();
    level.player _meth_823C(level.player._id_1E9C, "tag_player", 0.2, 0.1, 0.1);
    wait 0.2;
    level.player playerlinktodelta(level.player._id_1E9C, "tag_player", 1, 15, 15, 15, 5, 1);
    level.player._id_1E9C scripts\engine\utility::delaycall(0.25, ::show);
    level._id_EAD6 scripts\engine\utility::delaythread(2.5, ::_id_EA3B, var_0);
    level thread _id_12939(var_0);
    var_0._id_CF56 thread scripts\sp\anim::_id_1F35(var_1, "turbine_button_push");
    var_0._id_CF56 scripts\sp\anim::_id_1F35(level.player._id_1E9C, "turbine_button_push");
    level.player.ignoreme = 0;
    level.player._id_1E9C delete();
    scripts\sp\maps\titanjackal\titanjackal_code::_id_DF3E();
    scripts\sp\utility::_id_2669("turbine_destroyed");
    thread scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_Turbineexposed");
    setmusicstate("");
    scripts\sp\maps\titan\titan_jackal_arena_dogfight::_id_4051();
    var_4 = getEntArray("exit_quake", "targetname");

    foreach(var_6 in var_4) {
      if(distance2dsquared(var_6.origin, level.player.origin) > 25000000) {
        var_6 delete();
      }
    }

    var_4 = scripts\engine\utility::array_removeundefined(var_4);
    scripts\engine\utility::array_thread(var_4, ::_id_695C);
    _id_0BDC::_id_CF50(1);
    _id_0BDC::_id_A24B("building1_landing_pad", 1);
    _id_0BDC::_id_A164(0);
    thread _id_1292E();
    thread _id_6752();
  }
}

_id_40D4() {
  var_0 = getEntArray("geyser_spawner", "targetname");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

_id_6752() {
  level._id_6753 scripts\sp\utility::_id_54F7();
  level._id_6753 scripts\sp\utility::_id_1160F(getnode("eth3n_guide_player_to_exit", "targetname"));
  scripts\sp\utility::_id_127AE("eth3n_head_to_exit", "targetname");
  scripts\sp\utility::_id_56BE("jackal_return", 5);
  level._id_6753 scripts\sp\utility::_id_F3D9(getnode("turbine_exit_cover_node", "targetname"));
  scripts\sp\utility::_id_127AE("eth3n_head_to_jackal", "targetname");
  level._id_6753 scripts\sp\utility::_id_F3D9(getnode("eth3n_landing_pad", "targetname"));
}

_id_D125() {
  var_0 = distance(level.player.origin, level._id_D223.origin);
  wait 0.1;
  var_1 = distance(level.player.origin, level._id_D223.origin);
  return var_1 < var_0;
}

_id_12939(var_0) {
  wait 1.5;

  foreach(var_2 in var_0.lights) {
    triggerfx(var_2);
  }

  wait 1;
  scripts\engine\utility::delaythread(0.2, scripts\engine\utility::play_sound_in_space, "scn_meth_turbine_open", (38255, 77322, -64581));
  var_0._id_6E88._id_1FBB = "turbine_flaps";
  var_0._id_6E88 scripts\sp\utility::_id_23B7();
  var_0._id_6E88 thread scripts\sp\anim::_id_1F35(var_0._id_6E88, "open");
}

_id_12937(var_0) {
  if(!isDefined(var_0._id_6B7C)) {
    return;
  }
  var_0._id_6B7C endon("destroyed");
  var_1 = 0.15;

  for(;;) {
    var_0._id_6B7C rotateYaw(360, var_1);
    wait(var_1);
  }
}

_id_12927(var_0) {
  if(var_0 == level.player) {
    return 1;
  }

  if(isDefined(level._id_D127) && var_0 == level._id_D127) {
    return 1;
  }

  if(isDefined(level._id_EAD6) && var_0 == level._id_EAD6) {
    return 1;
  }

  return 0;
}

_id_12934() {
  level.player setOrigin(getnodearray("salter_at_button", "script_noteworthy")[0].origin);
  level.player setplayerangles((0, 180, 0));
  _id_12938();
  wait 2;
  thread _id_52B9(level._id_1292A);
}

_id_52B9(var_0) {
  if(var_0._id_32D9.targetname == "turbine_building_1") {
    var_1 = "turbine1_destroyed";
    var_2 = "titan_slt_YeahthatswhatIm";
    level._id_6DBA = "building_1";
    level._id_F08E = "building_2";
  } else {
    var_1 = "turbine2_destroyed";
    var_2 = "titan_slt_THATSnotgettingrepaired";
    level._id_6DBA = "building_2";
    level._id_F08E = "building_1";
  }

  if(scripts\engine\utility::flag(var_1)) {
    return;
  }
  scripts\engine\utility::flag_set(var_1);

  if(isDefined(var_0._id_6B7C)) {
    var_3 = var_0._id_6B7C;
  } else {
    var_3 = var_0._id_4D27;
  }

  var_3 notify("destroyed");
  var_3._id_9BB8 = 1;
  scripts\engine\utility::exploder("fx_turbine_expl_small");
  wait 1.0;
  playFX(scripts\engine\utility::getfx("turbine_explosion"), var_3.origin);
  playworldsound("scn_titan_turbine_explo", var_3.origin);
  earthquake(0.75, 1.25, var_3.origin, 5000);
  scripts\engine\utility::flag_set("stop_turbine_emitter");
  thread scripts\engine\utility::play_loopsound_in_space("scn_titan_turbine_destroyed_fire_lp", (38323, 77319, -64758));
  var_0._id_6E88 delete();
  var_0._id_6B7C delete();
  var_0._id_994E delete();
  thread _id_1293A();
  scripts\engine\utility::exploder("fx_turbine_fires");
  var_0._id_9A62 show();
  setglobalsoundcontext("rattle", "none", 8.0);

  foreach(var_5 in var_0.lights) {
    var_5 delete();
  }

  var_0._id_32D9._id_9C97 = 1;
  scripts\sp\utility::_id_2669("turbine_destroyed");

  if(!scripts\engine\utility::player_is_in_jackal()) {
    thread _id_134BC();
  }
}

_id_69F0() {
  setsaveddvar("r_mbRadialOverrideStrength", 0.02);
  setsaveddvar("r_mbRadialOverrideRadius", 0.15);
  setsaveddvar("r_mbRadialOverrideDistortion", 0.05);
  var_0 = 0.1;
  var_1 = 2 - var_0;

  while(var_1 > 0) {
    setsaveddvar("r_mbRadialOverrideStrength", 0.01 * var_1);
    var_1 = var_1 - var_0;
    wait(var_0);
  }

  setsaveddvar("r_mbRadialOverrideStrength", 0.0);
}

_id_1293A() {
  var_0 = getEntArray("turbine_destruction_chunks", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_12936);
  thread _id_12933();
}

_id_12933() {
  var_0 = getEntArray("turbine_concrete_explosion", "targetname");
  var_1 = scripts\engine\utility::getfx("turbine_explosion_small");

  foreach(var_3 in var_0) {
    playFX(var_1, var_3.origin + (0, 0, -3000));
    thread _id_69F0();
    wait 0.2;
  }
}

_id_12936() {
  self.origin = self._id_10CCA;
  self.angles = self._id_10BA1;
  var_0 = 50 + randomfloatrange(1, 5);
  var_1 = (0, 0, -2.5);
  var_2 = 4;
  var_3 = 0.05;
  var_4 = scripts\engine\utility::getStructArray("turbine_explosion_impulse", "targetname");
  var_5 = self.origin - (var_4[0].origin + (0, 0, -5000));
  var_6 = vectorNormalize(var_5);
  var_7 = var_6 * var_0;
  var_8 = (randomfloatrange(1, 10), randomfloatrange(1, 10), randomfloatrange(1, 5));
  var_9 = (0, 0, 0);
  var_10 = (0, 0, 0);
  self show();

  while(var_2 > 0) {
    self.origin = self.origin + var_7;
    self.angles = self.angles + var_8;
    var_7 = var_7 * 0.98 + var_1;
    var_2 = var_2 - var_3;
    wait(var_3);
  }

  self hide();
}

_id_134BC() {
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_turbinedownallscars");
  wait 4;
  var_0 = ["titan_plr_nowordfromgator", "titan_slt_nothinyet", "titan_slt_theyregooddontworry", "titan_plr_ihopeso", "titan_slt_hopesnotgoodenough"];
  scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_0);
}

_id_10D54() {
  setDvar("salter_spaceship", 1);
  scripts\sp\maps\titanjackal\titanjackal_code::_id_BC52("turbine_building_1_player");
  level.player scripts\sp\utility::_id_65E1("flag_player_is_landing");
  level.player scripts\sp\utility::_id_65E1("flag_player_dismounting");
  level._id_D223 = _id_0BDC::_id_1079F("player_rooftop_jackal", "turbine_building_1_jackal");
  level._id_1F8C = 1;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_10732();
  level._id_EAD6 vehicle_teleport(level.player.origin + (0, 0, 600), level.player.angles);
  var_0 = getEntArray("player_trigs", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::_id_D30B);
  level thread _id_D0B3();
  level thread _id_3A97();
  _id_12938();
  scripts\engine\utility::flag_set("player_landed_building1");
  _id_EADE();
  scripts\sp\utility::_id_6E2B("turbine1_destroyed", 1);
}

_id_EADE() {
  level._id_EAD6 _id_0BDC::_id_19A0();
  level._id_EAD6 scripts\asm\asm_bb::bb_setanimScripted();
  level._id_EAD6 _id_0BDC::_id_19AE("dont_shoot");
  level._id_EAD6 _meth_8491("hover");
  level._id_EAD6 _meth_8456((0, 0, 1));
  level._id_EAD6 _id_0BDC::_id_19A4(1);
  level._id_EAD6._id_55A4 = 1;
}

_id_EA36(var_0) {
  return 0;
}

_id_10D53() {}

_id_10D52() {}

_id_73C2() {
  self endon("stop_friendly_wingman");
  _id_0BDC::_id_137D6();

  if(scripts\engine\utility::player_is_in_jackal()) {
    var_0 = level.player _meth_8473();
    _id_0BDC::_id_1994(var_0, (2500, -800, 400), 300, 0.08, 15000, 1.0);
    self waittill("near_goal");
    return;
  }
}

_id_73CB(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = _id_0BDC::_id_7BBA();
  }

  if(distancesquared(self.origin, var_0) > 7000) {
    var_2 = anglesToForward(_id_0BDC::_id_7BB9());

    if(!isDefined(var_1)) {
      var_2 = var_2 * -1;
    }

    var_3 = var_0 + var_2 * 2000;
    self vehicle_teleport(var_3, _id_0BDC::_id_7BB9());
  }
}

_id_73C1(var_0) {
  if(isDefined(var_0)) {
    self setlookatent(var_0);
  }
}

_id_A245(var_0) {
  var_1 = ["titan_slt_Touchingdown", "titan_plr_BecarefulSalt"];
  scripts\engine\utility::delaythread(3, scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD, var_1);
  _id_0BDC::_id_A1EF(scripts\sp\utility::_id_7C9A(var_0.targetname), undefined, 0, 200);

  if(var_0.targetname == "salter_land1") {
    scripts\engine\utility::flag_set("salter_landed_building1");
  }
}

_id_78BA() {
  var_0 = getEntArray("trigger_multiple_landingzone", "classname");
  return scripts\engine\utility::getclosest(_id_0BDC::_id_7BBA(), var_0);
}

_id_78C9() {
  var_0 = _id_78BA();

  if(var_0.script_noteworthy == "building1_landing_pad") {
    return "turbine_building_1";
  } else {
    return "turbine_building_2";
  }
}

_id_78CA() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("building_los_structs", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(_id_CFB1(var_3.origin)) {
      var_0[var_0.size] = var_3.targetname;
    }
  }

  if(var_0.size == 0) {
    return undefined;
  }

  if(var_0.size == 1) {
    return "turbine_" + var_0[0];
  }

  if(var_0.size == 2) {
    return _id_78C9();
  }
}

_id_7C26(var_0) {
  if(var_0 == "turbine_building_1") {
    var_1 = "salter_land1";
  } else {
    var_1 = "salter_land2";
  }

  return scripts\engine\utility::getStruct(var_1, "targetname");
}

_id_CFB1(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = squared(45000);
  } else {
    var_1 = squared(var_1);
  }

  if(distancesquared(_id_0BDC::_id_7BBA(), var_0) > var_1) {
    return 0;
  }

  var_4 = 0.81883;
  var_5 = _id_0B76::_id_7A60(var_0);

  if(var_5 >= var_4) {
    if(!isDefined(var_2)) {
      var_6 = _id_0BDC::_id_7B9B();
      var_7 = var_0;
      var_8 = level._id_D127;
      var_9 = undefined;

      if(isDefined(var_3)) {
        if(isarray(var_3)) {
          var_9 = scripts\engine\utility::add_to_array(var_3, var_8);
        } else {
          var_9 = [var_8, var_3];
        }
      }

      if(scripts\common\trace::ray_trace_passed(var_6, var_7, var_9)) {
        return 1;
      } else {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

_id_D11C() {
  return scripts\engine\utility::flag("flag_jackal_in_landingzone");
}

_id_D0C2() {
  if(level.player scripts\sp\utility::_id_65DF("flag_player_has_jackal")) {
    if(!level.player scripts\sp\utility::_id_65DB("flag_player_has_jackal")) {
      return 1;
    }
  }

  return 0;
}

_id_137E8(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    level endon("stop_waittill");
    level thread scripts\sp\utility::_id_C12D("stop_waittill", var_2);
  }

  for(;;) {
    var_3 = getaiarray("axis");

    if(!var_3.size) {
      wait 0.25;
      continue;
    }

    foreach(var_5 in var_3) {
      if(_id_CFB1(var_5 getEye(), var_0, var_1)) {
        return 1;
      }
    }

    wait 0.2;
  }
}

_id_137F0(var_0, var_1, var_2) {
  for(;;) {
    var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

    if(!var_0.size) {
      return;
    }
    foreach(var_4 in var_0) {
      if(_id_CFB1(var_4 getEye(), var_1, var_2)) {
        return;
      }
    }

    wait 0.1;
  }
}

_id_137DE(var_0) {
  level thread _id_D1B6();
  level thread scripts\sp\utility::_id_C12D("player_land_timeout", var_0);
  var_1 = level scripts\engine\utility::waittill_any_return("player_land_timeout", "player_landed");

  if(var_1 == "player_land_timeout") {
    for(;;) {
      if(!_id_D0C2() && _id_D112()) {
        wait 0.15;
        continue;
      }

      if(_id_D0C2()) {
        return 1;
      } else {
        return undefined;
      }
    }
  }

  return 1;
}

_id_A832(var_0) {
  self endon("death");
  var_1 = undefined;

  if(var_0 == "building1_landing_pad") {
    var_1 = "arena_jackals_destroyed";
  }

  level endon(var_1);
  var_2 = ["titanjackal_slt_clearthisairspa", "titanjackal_slt_wegottatakeoutt"];

  for(;;) {
    while(!_id_D115()) {
      wait 0.5;
    }

    if(!scripts\engine\utility::flag(var_1) && !_id_D0C2()) {
      scripts\sp\utility::_id_56BE("destroy_air_support", 5);

      if(var_2.size > 0) {
        var_3 = scripts\engine\utility::random(var_2);
        scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8(var_3);
        var_2 = scripts\engine\utility::array_remove(var_2, var_3);
      }

      wait 45;
    }

    wait 0.5;
  }
}

_id_A249() {
  level.player endon("death");
  level._id_D127 endon("jackal_touchdown");
  var_0 = getEnt("jackal_speed_monitor", "targetname");

  for(;;) {
    var_0 waittill("trigger");
    _id_F533();
    _id_0BDC::_id_A14A(1);

    while(isDefined(level._id_D127) && level._id_D127 istouching(var_0)) {
      scripts\engine\utility::waitframe();
    }

    _id_F534();
    _id_0BDC::_id_A14A(0);
  }
}

_id_D1B6() {
  level endon("player_land_timeout");

  for(;;) {
    if(_id_D0C2()) {
      level notify("player_landed");
      return;
    }

    wait 0.05;
  }
}

_id_D1B5() {
  level endon("player_landed");
  level endon("player_land_timeout");
  level endon("disable_landing_hint");

  for(;;) {
    if(!_id_D112()) {
      scripts\sp\utility::_id_56BE("land_on_turbine", 5);
    }

    wait 25;
  }
}

_id_D1BA() {
  level._id_CFA9 = 0;
  var_0 = _id_7A67("building1_landing_pad");
  var_0 thread _id_A833("player_landed_building1");
}

_id_7A67(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    if(var_3.classname == "trigger_multiple_landingzone") {
      return var_3;
    }
  }

  return undefined;
}

_id_A833(var_0) {
  self endon("death");
  level endon("both_turbines_destroyed");
  scripts\sp\utility::_id_65E0("player_close_to_landing_zone");
  thread _id_A832(self.script_noteworthy);
  var_1 = undefined;

  for(;;) {
    if(!_id_D115()) {
      if(scripts\sp\utility::_id_65DB("player_close_to_landing_zone")) {
        scripts\sp\utility::_id_65DD("player_close_to_landing_zone");
      }

      wait 0.15;
      continue;
    }

    if(!scripts\sp\utility::_id_65DB("player_close_to_landing_zone")) {
      scripts\sp\utility::_id_65E1("player_close_to_landing_zone");
    }

    if(level.player istouching(self)) {
      if(_id_D0C2()) {
        scripts\engine\utility::flag_set(var_0);
        level notify("player_landed");

        if(var_0 == "player_landed_building1") {
          var_2 = "turbine_building_1";
          var_1 = "building1_landing_pad";
        }

        return;
      }
    }

    wait 0.05;
  }
}

_id_3A97() {
  thread _id_1292D();
  level.player scripts\sp\utility::_id_65E3("flag_player_is_landing");
  thread _id_6794();
  level notify("disable_landing_hint");
  scripts\engine\utility::flag_set("player_has_landed_on_turbine");
  scripts\engine\utility::flag_clear("jackals_retreated");
  scripts\engine\utility::array_call(getaiarray("axis"), ::hudoutlinedisable);
  var_0 = getEntArray("cargoship_trig", "script_noteworthy");
  var_1 = scripts\engine\utility::getclosest(_id_0BDC::_id_7BBA(), var_0);

  while(isDefined(level._id_EAD6.is_shooting)) {
    wait 0.05;
  }

  level._id_EAD6 notify("stop_attacking_with_player");
  _id_EADE();
  level._id_EAD6 _meth_8457("face motion");
  level.player scripts\sp\utility::_id_65E8("flag_player_has_jackal");
  thread scripts\sp\utility::_id_266F();
  var_2 = scripts\engine\utility::getStruct("salter_cargo_sweep_pos", "targetname");
  level._id_EAD6 vehicle_teleport(var_2.origin + (0, 0, 100), var_2.angles);
  level._id_EAD6 _meth_8080();
  level._id_EAD6 _meth_8455(level._id_EAD6.origin, 1, level._id_EAD6.angles);
  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_D250(1);
  var_1 scripts\sp\utility::_id_15F2(level.player);
  var_3 = getEntArray("cargoship_guys_vol", "script_noteworthy");
  var_4 = scripts\engine\utility::getclosest(_id_0BDC::_id_7BBA(), var_3);
  var_5 = [];

  while(var_5.size != 6) {
    var_5 = var_4 scripts\sp\utility::_id_77E3("axis");
    wait 0.05;
  }

  scripts\engine\utility::array_thread(var_5, scripts\sp\utility::_id_F2D8, 0.01);
  scripts\engine\utility::array_thread(var_5, scripts\sp\utility::_id_F415, 1);
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_plr_coverme");
  thread scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_twostepsahead");
  wait 2;
  scripts\engine\utility::array_thread(var_5, scripts\sp\utility::_id_F415, 0);
  thread _id_3A96(var_5);
  var_6 = 4;
  thread _id_105D1("cargoship_shoot_start");
  wait 2;
  var_5 = scripts\sp\utility::_id_22B9(var_5);

  if(isDefined(var_5.size) && var_5.size > 0) {
    thread scripts\sp\maps\titanjackal\titanjackal_code::_id_A5E5(var_5);
  }

  scripts\engine\utility::flag_set("cargoship_moment_finished");
  thread _id_1292C();
  scripts\sp\utility::_id_15F1("eth3n_shutters_closed_color_trigger", "targetname", level.player);
  wait 3;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_swingaroundleft");
  wait 1;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_youreadytomop");
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_plr_always");
  scripts\sp\utility::_id_2669("post_salter_turbine_strafing_run");
}

_id_6794() {
  if(isDefined(level._id_D127)) {
    level._id_D127 waittill("jackal_touchdown");
    wait 3;
  }

  level thread _id_674F();
}

_id_1292C() {
  var_0 = scripts\engine\utility::getStructArray("shutter_spawner", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_12930();
    wait(randomfloatrange(0.25, 0.5));
  }
}

_id_12930() {
  var_0 = -19;

  for(var_1 = 0; var_1 < 11; var_1++) {
    var_2 = scripts\engine\utility::spawn_tag_origin(self.origin);
    var_2 setModel("titan_jackal_window_armor_panel");
    var_2 show();

    if(var_1 == 4) {
      var_2 playSound("scn_titanjackal_window_shutters");
    }

    var_2 movez(var_0 * var_1, 2.5);
    wait 0.25;
  }
}

_id_1292E() {
  var_0 = getEnt("building_exit_door", "targetname");
  var_0 movez(128, 2.5);
  var_0 connectpaths();
}

_id_1292D() {
  level.player endon("death");
  var_0 = getEnt("turbine_player_kill_trigger", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1) && isPlayer(var_1)) {
      level.player _meth_81D0();
    }
  }
}

_id_3A96(var_0) {
  for(var_1 = 0; var_1 < 1; var_1++) {
    var_0 = scripts\sp\utility::_id_22B9(var_0);
    var_2 = scripts\engine\utility::random(var_0);

    if(!isDefined(var_2)) {
      return;
    }
    var_3 = var_2 scripts\sp\maps\titanjackal\titanjackal_code::_id_79D9(150, var_2.angles, 1);
    scripts\engine\utility::exploder("fx_salter_window_burst");
    playworldsound("frag_grenade_explode", var_3);
    var_2 startragdoll();
    wait 0.05;
    physicsexplosionsphere(var_2.origin, 500, 100, 5);
    wait 0.1;
    playworldsound("generic_death_falling_scream", var_3);
    wait 0.4;
  }
}

_id_3208(var_0) {
  if(var_0 == "turbine_building_1") {
    return scripts\engine\utility::flag("building1_aa_turrets_destroyed");
  }
}

_id_737B(var_0) {
  if(var_0) {
    level.player freezecontrols(1);
  } else {
    level.player freezecontrols(0);
  }
}

_id_674F() {
  level._id_6753 = scripts\sp\utility::_id_107EA("eth3n_turbine_spawner", 1);
  level._id_6753 scripts\sp\utility::_id_5131();
  level._id_6753.name = "Ethan";
  level._id_6753._id_1FBB = "atom";
  level._id_6753._id_134DB = scripts\sp\maps\titanjackal\titanjackal_code::_id_2434;
  level._id_6753 scripts\sp\utility::_id_72EC("iw7_crb", "primary");
  level._id_6753 scripts\sp\utility::_id_F3B5("c");
  level._id_6753 scripts\sp\utility::_id_61C7();
}

_id_D0B3() {
  setsaveddvar("r_volumetricsScatterTemporalFactor", 0.85);
  scripts\engine\utility::flag_wait("cargoship_moment_finished");
  scripts\engine\utility::flag_set("turn_off_building_01_curtain_lights");
  scripts\sp\utility::_id_28D8("axis");
  _id_61D2();
  var_0 = getEntArray("player_trigs", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::_id_D30B);
  wait 2;
  level thread _id_13502();
  var_1 = _id_7908();
  thread _id_EAB6();
  thread _id_134DD();
  thread _id_10B4D();

  if(var_1 == "building1") {
    var_2 = level._id_1292A._id_32D9;
  } else {
    var_2 = level._id_1292B._id_32D9;
  }

  thread _id_1293C(var_2);
  thread _id_13740(var_2);
  scripts\engine\utility::flag_wait("player_in_control_room");
  var_3 = getEntArray("player_trigs", "script_noteworthy");
  thread scripts\sp\utility::_id_228A(var_3);
  _id_0BDC::_id_137CF();
  level._id_EAD6 notify("stop_attack_player_enemies");
  setsaveddvar("r_volumetricsScatterTemporalFactor", 0.5);
  scripts\sp\utility::_id_2669("player_back_in_jackal");
}

_id_61D2() {
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_CF8D();
}

_id_54FE() {
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_CF8B();
}

_id_10B4D() {
  scripts\engine\utility::flag_wait("turbine_stairs_arrive");
  var_0 = getEntArray("salter_ground_stop3", "script_noteworthy");

  if(var_0.size) {
    foreach(var_2 in var_0) {
      if(var_2.classname != "info_volume") {
        var_0 = scripts\engine\utility::array_remove(var_0, var_2);
      }
    }
  }

  if(var_0.size == 1) {
    var_4 = var_0[0];
  } else {
    var_4 = scripts\engine\utility::getclosest(_id_0BDC::_id_7BBA(), var_0, 10000);
  }

  level._id_EAD6 scripts\sp\utility::_id_65E1("pause_scripted_shooting");
  wait 3;
  var_5 = 4;
  thread _id_105D1("stairs_shoot_start");
  wait(var_5 * 0.5);
  var_6 = var_4 scripts\sp\utility::_id_77E3("axis");

  if(var_6.size) {
    scripts\sp\maps\titanjackal\titanjackal_code::_id_A5E5(var_6);
  }

  wait 2;
  level._id_EAD6 scripts\sp\utility::_id_65DD("pause_scripted_shooting");
}

_id_134BD(var_0) {
  level.player endon("flag_player_has_jackal");
  scripts\engine\utility::flag_wait("player_in_control_room");
  wait 0.5;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_turbinecontrolsshouldbe");

  while(distance(var_0.origin, level.player.origin) > 150) {
    scripts\engine\utility::waitframe();
  }

  scripts\sp\maps\titanjackal\titanjackal_code::_id_D1D5("titan_plr_iseeit");
  wait 0.2;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_Standingby");
}

_id_1293C(var_0) {
  var_1 = 0.09;
  var_2 = 0.18;
  var_3 = "damage_light";
  var_4 = 1;

  while(!isDefined(var_0._id_9C97)) {
    var_5 = randomfloatrange(var_1, var_2);
    earthquake(var_5, var_4, var_0.origin, 1100);

    if(var_5 < 0.13) {
      playworldsound("emt_room_shake_mtl_sml_lr", (40455, 75831, -64567));
    } else {
      playworldsound("emt_room_shake_mtl_lrg_lr", (40455, 75831, -64567));
    }

    wait(randomfloatrange(var_4 * 0.4, var_4 * 0.8));
  }
}

_id_13290() {
  scripts\engine\utility::flag_wait("vent_enter");
  var_0 = getEnt("vent_exit", "targetname");
  var_0 endon("open");
  var_0 childthread _id_1328C();
  thread _id_13295();

  for(;;) {
    var_0 waittill("touch", var_1);

    if(var_1 == level.player) {
      if(level.player getnormalizedmovement()[0] > 0.4) {
        var_0 _id_13291();
        return;
      }
    }
  }
}

_id_13295() {
  scripts\sp\utility::_id_22CA("vent_enemies", ::_id_10F49);
  var_0 = scripts\sp\utility::_id_22CD("vent_enemies", 1);
}

_id_1328C() {
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      _id_13291();
      return;
    }
  }
}

_id_13291() {
  if(isDefined(self.fallen)) {
    return;
  }
  var_0 = 0.45;
  self.fallen = 1;
  self.anchor = scripts\engine\utility::get_target_ent();
  self linkTo(self.anchor);
  self._id_6B5D = self.anchor scripts\engine\utility::get_target_ent();
  self.anchor moveTo(scripts\sp\utility::_id_864C(self._id_6B5D.origin), var_0);
  self.anchor rotateTo(self._id_6B5D.angles, var_0);
  wait(var_0);
  self notify("open");
}

_id_D2F5() {
  thread scripts\sp\utility::_id_56BA("jackal_launch_start");

  while(!level.player _meth_81CE()) {
    wait 0.05;
  }

  thread _id_0BDC::_id_A159(0);
  thread _id_A249();
  var_0 = _id_7908();

  if(var_0 == "building1") {
    var_1 = scripts\engine\utility::getStruct("building_1", "targetname");
    var_2 = scripts\engine\utility::getStruct("building_2", "targetname");
  } else {
    var_1 = scripts\engine\utility::getStruct("building_2", "targetname");
    var_2 = scripts\engine\utility::getStruct("building_1", "targetname");
  }

  var_3 = (_id_0BDC::_id_7BBA()[0], _id_0BDC::_id_7BBA()[1], var_1.origin[2]);

  if(scripts\engine\utility::flag("both_turbines_destroyed")) {
    var_4 = level._id_11A70;
  } else {
    var_4 = var_2.origin;
  }

  _id_0BDC::_id_7AB7().origin = var_4;
  _id_0BDC::_id_7AFB().origin = var_3;
  _id_737B(1);
  var_5 = 3;
  var_6 = var_5 * 0.5;
  wait(var_5);
  _id_737B(0);
}

_id_EAB6() {
  scripts\engine\utility::flag_wait("gl_salter_leaves");

  while(level._id_EAD6 scripts\sp\utility::_id_65DB("pause_scripted_behavior")) {
    scripts\engine\utility::waitframe();
  }

  wait 0.15;
  level._id_EAD6 notify("stop_attacking_with_player");
  var_0 = scripts\engine\utility::getStruct("salter_dodge_point", "script_noteworthy");
  level._id_EAD6 thread _id_EADD(var_0.origin, 150, 1, var_0.angles, 100);
  wait 1;
  thread _id_EA6E();
  thread _id_13504();
  level._id_EAD6 thread _id_EADD(var_0.origin + (0, 0, 250), 150, 1, var_0.angles, 100);
  level._id_EAD6 scripts\engine\utility::waittill_any_timeout(5, "near_goal");
  var_1 = scripts\engine\utility::getStructArray("salter_wait_for_button_idle_points", "targetname");
  var_2 = scripts\engine\utility::random(var_1);
  wait 3;
  level._id_EAD6 _id_EADD(var_2.origin, 300, 1, var_2.angles, 1000);
}

_id_B9AD() {
  level endon("disable_turbine_hint");
  _id_13800();
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_niceonenowhit");
  wait 2;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_imanchoredoutside");
}

_id_EA6E() {
  var_0 = scripts\engine\utility::getStruct("building_1", "targetname");
  var_1 = scripts\engine\utility::getStructArray("salter_rpg_attack", "targetname");
  var_2 = scripts\engine\utility::getclosest(level.player.origin, var_1);
  var_3 = magicbullet("iw7_lockon", var_2.origin, level._id_EAD6.origin + (0, 0, 300));
  wait 1.5;
  var_4 = 3;

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = randomintrange(150, 300);
    var_7 = level._id_EAD6 scripts\sp\maps\titanjackal\titanjackal_code::_id_7C16(level._id_EAD6.origin, var_6);
    var_3 = magicbullet("iw7_lockon", var_0.origin + scripts\engine\utility::randomvector(16), var_7);

    for(var_8 = 0; var_8 < 2; var_8++) {
      level._id_EAD6 _id_0C1B::_id_6EA0(var_3);
    }

    wait(randomfloatrange(0.45, 0.95));
  }
}

_id_13505() {
  scripts\engine\utility::flag_wait("turbine_control_balcony");
  var_0 = ["titan_slt_needme", "titan_plr_imdugin", "titan_slt_likewise"];
  scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_0);
}

_id_13504() {
  var_0 = ["titan_slt_dammittakingfire", "titan_plr_handleit", "titan_slt_illhookback", "titan_slt_watchyourskindown"];
  scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_0);
}

_id_13800() {
  level endon("disable_turbine_hint");
  scripts\engine\utility::flag_wait("player_in_control_room");

  for(;;) {
    if(!isDefined(level._id_45B4)) {
      wait 1;
      continue;
    }

    if(level._id_45B4.size == 0) {
      return;
    }
    wait 0.15;
  }
}

_id_C9C5(var_0) {
  if(var_0) {
    level._id_EAD6 notify("stop soundjackal_gatling_fire_salt");
    level._id_EAD6 scripts\sp\utility::_id_65E1("pause_scripted_behavior");
  } else
    level._id_EAD6 scripts\sp\utility::_id_65DD("pause_scripted_behavior");
}

_id_13740(var_0) {
  scripts\engine\utility::flag_wait("player_in_control_room");
  var_1 = getEntArray("turbine_control_room", "targetname");
  var_2 = scripts\engine\utility::getclosest(level.player.origin, var_1);
  var_2 endon("death");
  var_0 endon("trigger");
  wait 3;

  for(;;) {
    level._id_45B4 = var_2 scripts\sp\utility::_id_77E3("axis");

    if(isDefined(level._id_45B4)) {
      if(level._id_45B4.size > 0) {
        wait 0.25;
        continue;
      } else {
        scripts\sp\maps\titanjackal\titanjackal_code::_id_EAB8("titan_slt_niceonenowhit");
        scripts\engine\utility::flag_set("control_room_clear");
        return 1;
      }
    } else
      return 1;

    wait 1;
  }
}

_id_F5D5() {
  if(isDefined(self._id_A7C8)) {
    return;
  }
  self._id_A7C8 = 1;
  self notify("player_landed");
  self._id_A7BA.alpha = 0;
  var_0 = strtok(self.targetname, "_");
  var_1 = var_0[0];
  var_2 = getEnt(var_1 + "_outline", "targetname");

  if(isDefined(var_2)) {
    var_2 hudoutlinedisable();
  }
}

_id_31E2() {
  level endon("turbine1_destroyed");
  scripts\engine\utility::flag_wait("player_landed_building1");
  wait 2;
  level.player scripts\sp\utility::_id_65E3("flag_player_has_jackal");
  scripts\engine\utility::flag_set("player_abandoned_building1");
}

_id_2EDF() {
  scripts\engine\utility::flag_wait("turbine1_destroyed");
  scripts\engine\utility::flag_set("both_turbines_destroyed");
}

_id_7908() {
  return "building1";
}

_id_8FEE(var_0) {
  var_1 = level.player scripts\sp\hud_util::_id_4999("default", 1.7);
  var_1.alpha = 0;
  var_1 settext(var_0);
  var_1.x = 0;
  var_1.y = -48;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.foreground = 0;
  var_1.hidewhendead = 1;
  var_1.hidewheninmenu = 1;
  return var_1;
}

_id_EAD1() {
  level endon("salter_landing");
  level endon("player_landed");
  level endon("stop_prompts");
  var_0 = ["titan_slt_Reeselandyourjackal", "titan_slt_HurryupIdont"];

  while(!_id_D0C2()) {
    foreach(var_2 in var_0) {
      wait(randomintrange(12, 18));

      while(_id_D112()) {
        wait 1;
      }

      scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7(var_2);
    }
  }
}

_id_DA74(var_0) {
  _id_780F(3);
}

_id_F090(var_0) {
  var_1 = level.player _meth_8473();
  level._id_EAD6 _id_0BDC::_id_1994(var_1, (2500, -800, 400), 300, 0.08, 15000, 1.0);
  level._id_EAD6 scripts\engine\utility::waittill_notify_or_timeout("near_goal", 3);
  wait 1.5;
  wait 4;
  level._id_EAD6 _id_0BDC::_id_19B7();
  thread _id_EAB4();
  _id_137E5(var_0);
}

_id_EAB4() {
  var_0 = scripts\engine\utility::getStruct(level._id_F08E, "targetname");
  var_1 = "player_sees_" + var_0.targetname;
  level._id_EAD6 endon(var_1);
  var_2 = scripts\engine\utility::getStruct("jackal_cave_spot", "targetname");
  var_3 = [var_2.origin, var_0.origin];
  level._id_EAD6 childthread _id_10589(var_3);
}

_id_134CC(var_0, var_1) {
  level endon(var_1);

  for(;;) {
    if(_id_D0C2()) {
      return;
    }
    _id_134CB(var_0);
    wait(randomintrange(8, 15));
  }
}

_id_134CB(var_0) {
  var_1 = undefined;

  if(var_0 == "turbine_building_1") {
    var_2 = scripts\engine\utility::getStruct("building_1", "targetname");
  } else {
    var_2 = scripts\engine\utility::getStruct("building_2", "targetname");
  }

  var_3 = "titan_slt_Itsonyourleft";
  var_4 = "titan_slt_Onyourright";
  var_5 = "titan_slt_Itsbehindyou";
  var_6 = "titan_slt_Itsaheadofyou";
  var_1 = _id_7B8D(var_2.origin);

  if(!isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "forward_left":
    case "forward_right":
    case "forward":
      var_1 = var_6;
      break;
    case "behind_right":
    case "behind_left":
    case "behind":
      var_1 = var_5;
      break;
    case "left":
      var_1 = var_3;
      break;
    case "right":
      var_1 = var_4;
      break;
  }

  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7(var_1);
}

_id_7B8D(var_0) {
  var_1 = _id_0BDC::_id_7BB9();
  var_2 = _id_0BDC::_id_7BBA();
  var_3 = 0.85;
  var_4 = 0.5;
  var_5 = undefined;
  var_6 = vectorNormalize(var_0 - var_2);
  var_7 = vectordot(anglesToForward(var_1), var_6);
  var_8 = vectordot(anglestoright(var_1), var_6);

  if(var_7 <= var_3 * -1) {
    return "behind";
  } else if(var_7 <= var_4 * -1 && var_8 < 0) {
    return "behind_left";
  } else if(var_8 <= var_3 * -1) {
    return "left";
  } else if(var_7 >= var_3) {
    return "forward";
  } else if(var_7 >= var_4 && var_8 < 0) {
    return "forward_left";
  } else if(var_7 >= var_4 && var_8 >= 0) {
    return "forward_right";
  } else if(var_8 >= var_3) {
    return "right";
  } else if(var_7 <= var_4 * -1 && var_8 >= 0) {
    return "behind_right";
  }

  return undefined;
}

_id_D115() {
  return distance2dsquared(self.origin, _id_0BDC::_id_7BBA()) < 9000000;
}

_id_D112() {
  foreach(var_1 in getEntArray("jackal_landingzone", "targetname")) {
    if(var_1 _id_D115()) {
      return 1;
    }
  }

  return 0;
}

_id_D113() {
  if(isDefined(level._id_A056._id_1632) && level._id_A056._id_1632.size) {
    var_0 = level._id_A056._id_1632;
  } else {
    var_0 = scripts\engine\utility::getStructArray("building_los_structs", "script_noteworthy");
  }

  var_1 = scripts\engine\utility::getclosest(_id_0BDC::_id_7BBA(), var_0);
  var_2 = distance(var_1.origin, _id_0BDC::_id_7BBA());
  var_3 = vectordot(vectorNormalize(var_1.origin - _id_0BDC::_id_7BBA()), _id_0BDC::_id_7BB9());

  if(var_2 < 12000 && var_3 > 0.6) {
    return 1;
  } else {
    return 0;
  }
}

_id_D114(var_0, var_1) {
  var_2 = distance(var_0.origin, _id_0BDC::_id_7BBA());
  var_3 = vectordot(vectorNormalize(var_0.origin - _id_0BDC::_id_7BBA()), anglesToForward(_id_0BDC::_id_7BB9()));

  if(var_2 < var_1 && var_3 > 0.6) {
    return 1;
  } else {
    return 0;
  }
}

_id_CE36(var_0, var_1) {
  var_2 = spawn("script_origin", self.origin);
  var_2 linkTo(self);

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_2 playSound(var_0, "sound_done");
    var_2 waittill("sound_done");
  }

  var_2 delete();
}

_id_787C(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);
  return scripts\engine\utility::getclosest(level._id_2F46.origin, var_2);
}

_id_A7B5() {
  while(!_id_D113()) {
    wait 0.15;
  }

  thread _id_23A0();
}

_id_11137() {
  _id_0BDC::_id_137D6();
  thread scripts\sp\utility::_id_56BA("jackal_strike");

  while(level._id_D127.spaceship_mode != "fly") {
    wait 0.1;
  }
}

_id_129BA() {
  level thread _id_12A1D();
  level._id_4B46 = undefined;
  var_0 = scripts\engine\utility::getStructArray("aa_turret", "targetname");

  foreach(var_2 in var_0) {
    var_2 _id_1060F();
  }
}

_id_1060F() {
  self.script_team = "axis";
  var_0 = spawnturret("misc_turret", self.origin, "cap_turret_med_proj");
  var_0.angles = self.angles;
  var_0 setModel("jackal_arena_aa_turret");
  var_0 setturretteam("axis");
  var_0 setmode("manual");
  var_0 setCanDamage(1);
  var_0.script_noteworthy = self.script_noteworthy;
  var_0.type = "projectile";
  var_0 setleftarc(180);
  var_0 setrightarc(180);
  var_0 settoparc(50);
  var_0 setbottomarc(20);
  var_0 _meth_82C9(0.75, "yaw");
  var_0 _meth_82C9(0.75, "pitch");
  var_0._id_4D1F = getEnt(self.target, "targetname");
  var_0._id_4D1F delete();
  var_0 makeentitysentient(self.script_team, 0);
  var_0 _meth_84BE("ground_turret");
  var_0 _meth_8339(0);
  var_0 thread _id_129DD();
  var_0 thread _id_129C7();
  _id_A090();
  var_0 thread scripts\sp\maps\titanjackal\titanjackal_code::_id_F40C("enemy", 0, 0);
  var_0 setdefaultdroppitch(0);

  if(!isDefined(level._id_3210)) {
    level._id_3210 = [];
  }

  level._id_3210 = scripts\engine\utility::add_to_array(level._id_3210, var_0);
}

_id_5190() {
  if(level._id_F08E == "building_1") {
    var_0 = "building1_turret";
  } else {
    var_0 = "building2_turret";
  }

  var_1 = getEntArray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    var_3 notify("turret_deletion");
    var_3 delete();
  }
}

_id_129DD() {
  self._id_10DAD = 2400;
  self._id_EF52 = self._id_10DAD;
  self.health = 999999;
  self._id_56D8 = undefined;
  self endon("turret_deletion");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(_id_24DB(var_1)) {
      self playSound("jackal_enemy_impact");

      if(self._id_EF52 - var_0 <= 0) {
        thread _id_129DF();
        return;
      } else {
        if(var_1 == level._id_EAD6) {
          var_0 = var_0 * 0.1;
        }

        self._id_EF52 = self._id_EF52 - var_0;

        if(self._id_EF52 <= self._id_10DAD * 0.5 && !isDefined(self._id_56D8)) {
          thread _id_129DA();
          self._id_56D8 = 1;
        }
      }
    }
  }
}

_id_129DA() {
  playFXOnTag(scripts\engine\utility::getfx("fighter_spaceship_damage_med_linger"), self, "tag_flash");
}

_id_24DB(var_0) {
  if(!isDefined(var_0.classname)) {
    return 0;
  }

  if(var_0.classname == "script_vehicle_jackal_friendly") {
    return 1;
  }

  return 0;
}

_id_129C7() {
  self endon("turret_death");
  self endon("turret_deletion");
  level._id_6DDC = 1;
  var_0 = 8;
  var_1 = randomfloatrange(0.6, 1.2);
  var_2 = scripts\engine\utility::ter_op(isDefined(self.type), var_0, var_1);
  var_3 = [];
  var_4 = "left";

  for(var_5 = 1; var_5 < 11; var_5++) {
    var_3[var_3.size] = "TAG_" + var_4 + "_MISSILE_" + var_5;
    var_4 = scripts\engine\utility::ter_op(var_4 == "left", "right", "left");
  }

  for(;;) {
    var_6 = _id_77EC();

    if(isDefined(var_6)) {
      self settargetentity(var_6);

      if(_id_8B6B(var_6)) {
        if(level._id_6DDC) {
          level._id_6DDC = 0;
          _id_F2EB(self.script_noteworthy);
        }

        _id_135A0(var_6, 3);

        if(_id_12A3A(var_6)) {
          level._id_4B46 = self;
          _id_0B76::_id_1945(var_6, var_3, 4);
          wait(var_2);
        } else {
          _id_0B76::_id_1945(var_6, var_3, 4);
          wait 4;
        }
      }
    }

    wait 0.25;
  }
}

_id_F2EB(var_0) {
  if(var_0 == "building2_turret") {
    var_1 = "building2_attacking";
  } else {
    var_1 = "building1_attacking";
  }

  if(!scripts\engine\utility::flag(var_1)) {
    scripts\engine\utility::flag_set(var_1);
  }
}

_id_134AF() {
  if(scripts\engine\utility::cointoss()) {
    scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_wegottatakeout");
  } else {
    scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7("titan_slt_cantlanduntilthat");
  }
}

_id_11524(var_0) {
  var_1 = self.origin[2] - var_0.origin[2];

  if(var_1 > 50) {
    return 1;
  }

  return 0;
}

_id_129DF() {
  self notify("turret_death");
  var_0 = self.origin;
  var_1 = self.script_noteworthy;
  playFX(scripts\engine\utility::getfx("capital_turret_death_smt"), var_0);
  playworldsound("scn_titan_aa_gun_explo", var_0);
  earthquake(0.6, 0.4, var_0, 1000);

  if(var_1 == "building1_turret") {
    var_2 = "building1_aa_turrets_destroyed";
  } else {
    var_2 = "building2_aa_turrets_destroyed";
  }

  if(isDefined(self._id_56D8) && self._id_56D8) {
    stopFXOnTag(scripts\engine\utility::getfx("fighter_spaceship_damage_med_linger"), self, "tag_flash");
  }

  self notify("death");
  self delete();
  var_3 = getEntArray("misc_turret", "classname");
  var_4 = [];

  foreach(var_6 in var_3) {
    if(var_6.script_noteworthy == var_1) {
      var_4 = scripts\engine\utility::add_to_array(var_4, var_6);
    }
  }

  if(var_4.size == 2) {
    return;
  } else if(var_4.size == 1) {
    _id_1351E("titan_slt_oneleft");
    return;
  } else if(!var_4.size) {
    scripts\engine\utility::flag_set(var_2);
    _id_1351E("titan_slt_okaadefensesare");
  }

  if(var_2 == "building1_aa_turrets_destroyed") {
    var_8 = "building1_landing_pad";
  } else {
    var_8 = "building2_landing_pad";
  }

  _id_0BDC::_id_A24B(var_8);
  _id_0BDC::_id_A164(1);
}

_id_1351E(var_0) {
  level notify("new_turret_count_update");
  level endon("new_turret_count_update");
  wait 1;
  scripts\sp\maps\titanjackal\titanjackal_code::_id_134B7(var_0);
}

_id_135A0(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon("waittill_aim_timeout");
    thread scripts\sp\utility::_id_C12D("waittill_aim_timeout", var_1);
  }

  if(issentient(var_0)) {
    var_0 endon("death");
  }

  while(!scripts\engine\utility::within_fov(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), var_0.origin, cos(60))) {
    wait 0.05;
  }
}

_id_134FB() {
  level.player scripts\sp\utility::_id_65E3("flag_player_is_landing");
  var_0 = ["titan_plr_Touchingdownnow", "titan_slt_scar2acknowledge", "titan_s21_roger11"];
  scripts\sp\maps\titanjackal\titanjackal_code::_id_48BD(var_0);
  thread _id_11990();
}

_id_129CE(var_0) {
  if(isDefined(self.type) && self.type == "projectile") {
    var_1 = 4;
  } else {
    var_1 = randomintrange(7, 12);
  }

  var_2 = 0;
  var_3 = _id_12A3A(var_0);

  if(var_3 && scripts\sp\maps\titanjackal\titanjackal_code::_id_65EC(var_0, self, 2500)) {
    var_2 = 1;

    if(!isDefined(self.type)) {
      var_1 = randomintrange(20, 30);
    }
  }

  var_4 = 0.15;
  var_5 = [];

  for(var_6 = 0; var_6 < var_1; var_6++) {
    if(var_2) {
      var_7 = 0;
      var_8 = 0;
      var_9 = 0;
      var_4 = 0.05;
    } else {
      var_7 = randomintrange(-10, 10);
      var_8 = randomintrange(-10, 10);
      var_9 = randomintrange(-10, 10);
    }

    self settargetentity(var_0, (var_7, var_8, var_9));
    var_10 = _id_12A0C(var_0);
    wait(var_4);

    if(isDefined(var_10)) {
      if(var_3) {
        var_10 makeentitysentient("axis");
        var_10 _meth_84BE("spaceship");
        var_10 _meth_8339(0);
      }

      var_5[var_5.size] = var_10;
      var_10.group = var_5;
    }
  }

  _id_137A8(var_5);
}

_id_137A8(var_0) {
  for(;;) {
    var_0 = scripts\engine\utility::array_removeundefined(var_0);

    if(!var_0.size) {
      level._id_4B46 = undefined;
      return;
    }

    wait 1;
  }
}

_id_12A0C(var_0, var_1, var_2) {
  if(!isDefined(self._id_FE7F)) {
    self._id_FE7F = "left";
  }

  var_3 = "TAG_" + self._id_FE7F + "_MISSILE_" + randomintrange(1, 12);
  var_4 = 1;

  if(isDefined(var_0)) {
    var_4 = 0;
  }

  var_5 = self gettagorigin(var_3) + anglesToForward(self.angles) * 20;

  if(var_4) {
    var_6 = var_5 + anglesToForward(self.angles) * 1000;
  } else {
    var_6 = _id_7BF2(var_0.origin, var_1, var_2);
  }

  var_7 = magicbullet("cap_turret_proj_weapon", var_5, var_6, undefined, self);

  if(isDefined(var_7)) {
    thread _id_12A25(var_7);
  }

  self._id_FE7F = scripts\engine\utility::ter_op(self._id_FE7F == "left", "right", "left");
  return var_7;
}

_id_12A25(var_0) {
  var_0 endon("death");
  var_0 childthread _id_12A21();
  var_0 childthread _id_12A24();
  var_0 childthread _id_12A26();
}

_id_12A26() {
  self setCanDamage(1);
  self.health = 10000;

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && _id_24DB(var_1)) {
      var_2 = self.origin;
      playFX(scripts\engine\utility::getfx("om_flak_expl"), var_2);
      var_3 = self.group;

      if(isDefined(var_3)) {
        foreach(var_5 in var_3) {
          if(isDefined(var_5)) {
            var_5 detonate();
          }
        }
      }

      return;
    }
  }
}

_id_12A24() {
  for(;;) {
    if(distance(self.origin, _id_0BDC::_id_7BBA()) >= 6000) {
      _id_12A23(self);
      _id_0BDC::_id_13797();
      _id_12A22(self);
      return;
    }

    wait 0.05;
  }
}

_id_12A23(var_0) {
  var_0 missile_settargetEnt(level._id_D127);
  var_1 = distance2dsquared(var_0.origin, _id_0BDC::_id_7BBA());
  var_2 = var_1 * 0.3;

  for(;;) {
    if(distance2dsquared(var_0.origin, _id_0BDC::_id_7BBA()) <= var_2) {
      break;
    }

    wait 0.05;
  }

  level notify("missile_locked_on_player");
  target_set(var_0);
  target_setscaledrendermode(var_0, 0);
  target_setshader(var_0, "apache_target_lock");
  target_setminsize(var_0, 15, 0);
  target_setmaxsize(var_0, 20, 0);
}

_id_12A22(var_0) {
  if(target_istarget(var_0)) {
    target_remove(var_0);
  }

  var_0 missile_cleartarget();
}

_id_12A1D() {
  var_0 = 2.5;
  var_1 = 4;
  var_2 = 0;
  var_3 = 1;

  for(;;) {
    level waittill("missile_locked_on_player");
    level.player thread scripts\engine\utility::play_loop_sound_on_entity("jackal_collision_warning");

    if(var_3) {
      scripts\engine\utility::flag_set("jackal_juke_hint");
      thread scripts\sp\utility::_id_56BA("jackal_juke_hint");
    }

    var_4 = level.player scripts\sp\maps\titanjackal\titanjackal_code::_id_13798(3);
    scripts\engine\utility::flag_clear("jackal_juke_hint");
    level.player thread scripts\engine\utility::stop_loop_sound_on_entity("jackal_collision_warning");

    if(!isDefined(var_4)) {
      level.player thread _id_CE36("jackal_hud_ads_on", 2);
    }

    var_2++;
    var_3 = scripts\engine\utility::ter_op(var_2 >= var_1, 0, 1);
    wait(var_0);

    if(_id_2EDE()) {
      return;
    }
  }
}

_id_12A21() {
  self endon("death");

  while(_id_0B76::_id_9C19(self)) {
    wait 1.5;
  }

  self delete();
}

_id_12A3A(var_0) {
  return isDefined(level._id_D127) && var_0 == level._id_D127;
}

_id_77EC() {
  var_0 = level._id_D127;
  var_1 = undefined;

  if(isDefined(level._id_EAD6)) {
    var_1 = level._id_EAD6;
  }

  if(isDefined(var_0) && isDefined(var_1)) {
    if(scripts\sp\maps\titanjackal\titanjackal_code::_id_65EC(var_0, self, 1500)) {
      return var_0;
    } else if(randomint(100) < 33) {
      return var_1;
    } else {
      return var_0;
    }
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, var_1);

  if(isDefined(var_2)) {
    return var_2;
  }

  return undefined;
}

_id_D12B(var_0) {}

_id_2EDE() {
  return scripts\engine\utility::flag("building1_aa_turrets_destroyed") && scripts\engine\utility::flag("building2_aa_turrets_destroyed");
}

_id_CDC7() {}

_id_FA05(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0 + "_player", "targetname");
  var_2 = scripts\engine\utility::getStruct(var_0 + "_salter", "targetname");
  var_3 = _id_0BDC::_id_1079F("player_rooftop_jackal");
  _id_0BDC::_id_10CD1(var_3, var_1, "hover");
  level._id_D127 _id_0BDC::_id_A19D(0);
  _id_F534();
  thread _id_A249();
  scripts\sp\maps\titanjackal\titanjackal_code::_id_10732();
  level._id_EAD6 vehicle_teleport(var_2.origin, var_2.angles);
}

_id_F534() {
  _id_0BDC::_id_A301(0.9, 0.25);
}

_id_F533() {
  _id_0BDC::_id_A301(0.5, 0.75);
}

_id_695C() {
  self waittill("trigger");
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");
  level.player _meth_8244("damage_heavy");
  level.player playSound("scn_titan_meth_lab_quake_lr");
  level.player scripts\engine\utility::delaycall(2, ::stoprumble, "damage_heavy");
  earthquake(0.15, 1.5, level.player.origin, 500);
  scripts\engine\utility::array_thread(var_0, ::_id_6965);
  self delete();
}

_id_6965() {
  var_0 = "vfx_tdi_falling_dust_and_debris";
  var_1 = "exp_titan_dirt_splod_ss";

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "sparks") {
      var_0 = "vfx_tdi_exploding_sparks";
      var_1 = "exp_titan_spark_splod_ss";
    }

    if(self.script_noteworthy == "steam") {
      var_0 = "vfx_tdi_burst_pipe_steam";
      var_1 = "exp_titan_pipe_burst_ss";
    }
  }

  for(var_2 = 0; var_2 < 4; var_2++) {
    playFX(scripts\engine\utility::getfx(var_0), self.origin);
    playworldsound(var_1, self.origin);
    wait(randomfloatrange(1, 3));
  }
}

_id_10F49() {
  self endon("shutdown_stealthlight");
  self endon("death");
  self._id_10F49 = spawnStruct();
  self._id_10F49._id_2521 = 0;
  self addaieventlistener("bulletwhizby");
  self.ignoreall = 1;
  childthread _id_10F4D();
  childthread _id_10F4C();
  childthread _id_10F50();
  self waittill("stealthlight_attack");
  self._id_10F49._id_2521 = 1;
  self.ignoreall = 0;

  foreach(var_1 in getaiunittypearray("axis", "soldier")) {
    if(distance(self.origin, var_1.origin) < 800 && !var_1 _id_10F4A()) {
      var_1 thread scripts\sp\utility::_id_C12D("stealthlight_attack", randomfloatrange(0.4, 2));
    }
  }

  self _meth_8260("bulletwhizby");
  self notify("shutdown_stealthlight");
}

_id_10F4D() {
  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && var_1 == level.player) {
      self notify("stealthlight_attack");
    }
  }
}

_id_10F4C() {
  for(;;) {
    if(distancesquared(self.origin, level.player.origin) < 250000) {
      if(self cansee(level.player)) {
        self notify("stealthlight_attack");
      }
    }

    wait 1;
  }
}

_id_10F50() {
  for(;;) {
    self waittill("bulletwhizby");
    self notify("stealthlight_attack");
  }
}

_id_10F4A() {
  if(isDefined(self._id_10F49) && self._id_10F49._id_2521) {
    return 1;
  }

  return 0;
}

_id_BACE() {
  _id_0BA9::_id_3994("ca");
  var_0 = scripts\sp\vehicle::_id_1080C("mons_test");
  var_1 = scripts\engine\utility::getStruct("mons_player", "targetname");
  var_2 = _id_0BDC::_id_1079F("player_rooftop_jackal");
  _id_0BDC::_id_10CD1(var_2, var_1, "hover");
  _id_0BDC::_id_A301(0.01, 0.1);
  wait 1;
  var_0 thread _id_BA71();
}

_id_BA71() {
  _id_0BDC::_id_A156(0);

  for(;;) {
    _id_0BB6::_id_4335(6, level._id_D127);
    wait(randomfloatrange(2, 2.5));
  }
}