/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\ja_asteroid\ja_asteroid.gsc
*******************************************************/

main() {
  scripts\sp\utility::_id_116CB("ja_asteroid");
  _id_10AE::_id_A0AB();
  scripts\sp\maps\ja_asteroid\gen\ja_asteroid_art::main();
  scripts\sp\maps\ja_asteroid\ja_asteroid_fx::main();
  scripts\sp\maps\ja_asteroid\ja_asteroid_precache::main();
  scripts\sp\utility::_id_F343("launch");
  scripts\sp\utility::_id_1749("launch", ::_id_10C98, "launch", ::_id_B209, undefined, ::_id_3B7C, 1);
  scripts\sp\utility::_id_1749("post_decoy", ::_id_10CE4, "post_decoy", ::_id_B216, undefined, undefined, 1);
  scripts\sp\utility::_id_1749("mission_complete", ::_id_10CAE, "mission_complete", ::_id_B20F, undefined, undefined, 1);
  scripts\sp\utility::_id_1749("ftl_test", ::_id_10C57, "ftl_test", ::_id_B1E5, undefined, undefined, 1);
  scripts\sp\load::main();
  scripts\sp\utility::_id_241F(0);
  _id_10AE::_id_9637();
  _id_10AE::_id_9638();
  physics_setgravity((0, 0, 0));
  _id_A041();
  setsaveddvar("r_heightfieldSunShadow", 0);
  setsaveddvar("sm_sunSampleSizeNear", 29.6);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 3);
  _id_1DE7();
  thread _id_13331();
  setglobalsoundcontext("atmosphere", "space", 1);
}

_id_A041() {
  _id_0BDC::_id_F435("jackal_landing_ja_asteroid");
  thread _id_10AE::_id_104D0("debris_cloud_struct", "vfx_space_debris_field_ice");
  thread _id_10AE::_id_104D0("asteroid_debris_struct", "vfx_ja_space_asteroid_debris");
  thread _id_10AE::_id_104D0("asteroid_gas_01_struct", "vfx_ja_space_gas_cloud_01");
  thread _id_10AE::_id_A043();
  thread _id_10AE::_id_104D0("decoy_debris_struct", "vfx_space_debris_field_debris_sml");
}

_id_10C98() {}

_id_B209() {
  thread _id_23F9();
  scripts\engine\utility::flag_init("player_found_destroyer");
  scripts\engine\utility::flag_init("salter_found_destroyer");
  scripts\engine\utility::flag_init("post_decoy_salter_move");
  scripts\engine\utility::flag_init("destroyer_vo_done");
  scripts\engine\utility::flag_init("sdf_ambush");
  scripts\engine\utility::flag_init("display_ambush_objectives");
  _id_10AE::_id_D7C9();
  var_0 = getEnt("player_jackal", "targetname");
  _id_0BDC::_id_10CD1(var_0);
  var_0 thread _id_10AE::_id_57C4("player_spline_intro", 300, 8, 2.0);
  scripts\engine\utility::flag_wait("intro_start");
  scripts\engine\utility::delaythread(0.5, _id_10AE::_id_CE81, ::_id_AAA1);
  scripts\engine\utility::flag_wait("intro_hold_on_black_done");
  _id_10AE::_id_577D("find_destroyer");
  thread _id_10AE::_id_56B3("find_destroyer", "jackal_objective_find_destroyer", 0, &"JACKAL_OBJECTIVE_FIND_DESTROYER_MENU");
  thread _id_10AE::_id_E3B6(0);
  thread _id_10AE::_id_5768("intro_jackals", "intro_jackal", undefined, 1);
  level._id_EA2C = getEnt("salter_jackal", "targetname") scripts\sp\utility::_id_10808();
  level._id_EA2C _id_0BDC::_id_1998();
  var_1 = getcsplineidarray(level._id_EA2C.target);
  level._id_EA2C thread _id_0BDC::_id_A1EF(var_1[0]);
  level._id_EA2C thread _id_EAE2();
  level._id_EA2C _id_0BDC::_id_19A9();
  level._id_EA2C _id_0BDC::_id_19AE("dont_shoot");
  level._id_5311 = _id_106A5();
  thread _id_23FC();
  scripts\engine\utility::flag_wait("intro_done");
  _id_0BDC::_id_A162(1);
  thread _id_6C8B();
  thread _id_EA6F();
  thread _id_F083();
  var_2 = level scripts\engine\utility::waittill_any_return("player_found_destroyer", "salter_found_destroyer");

  if(var_2 == "player_found_destroyer") {
    level._id_EA2C thread _id_EAE1();
    thread _id_D081();
  } else {
    _id_170D();
    thread _id_EA7F();
    scripts\engine\utility::flag_wait("player_found_destroyer");
    _id_E055();
    thread _id_5310();
  }

  level._id_5311 thread _id_0B76::_id_39C3(3, 0, "neutral");
  thread _id_10AE::_id_7265("find_destroyer");
  scripts\engine\utility::flag_wait("post_decoy_salter_move");
  level._id_EA2C thread _id_10AE::_id_A1F1("salter_spline_post_decoy");
  scripts\engine\utility::flag_wait("destroyer_vo_done");
}

_id_23F9() {
  wait 5;
  setmusicstate("mx_203_ja_asteroid_start");
}

_id_3B7C() {
  scripts\engine\utility::flag_init("player_found_destroyer");
  scripts\engine\utility::flag_init("salter_found_destroyer");
  scripts\engine\utility::flag_init("post_decoy_salter_move");
  scripts\engine\utility::flag_init("destroyer_vo_done");
  scripts\engine\utility::flag_init("sdf_ambush");
  scripts\engine\utility::flag_init("display_ambush_objectives");
}

_id_23FC() {
  _id_10AE::_id_E3FA("ret_start");
  var_0 = "ret_goal1";

  for(;;) {
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
    var_2 = 0;

    if(!isDefined(var_1.target)) {
      var_2 = 1;
    }

    _id_10AE::_id_E3A7(var_0, 1400, 0, var_2);

    if(!isDefined(var_1.target)) {
      break;
    }

    var_0 = var_1.target;
  }

  _id_10AE::_id_E3A7("ret_goal_ambush", 300, 1, 1);
  scripts\engine\utility::flag_wait("sdf_ambush");
  thread _id_10AE::_id_E382("ret_pivot");
}

_id_EAE2() {
  level._id_EA2C waittill("end_spline");
  level._id_EA2C thread _id_0BDC::_id_A1F4("salter_goal_decoy", 1, undefined, 1);
}

_id_EAE1() {
  level._id_EA2C _meth_845F(600);
  level._id_EA2C thread _id_0BDC::_id_A1F4("salter_goal_decoy", 1, undefined, 1);
  level._id_EA2C waittill("near_goal");
  level._id_EA2C _meth_845F(420);
}

_id_EA6F() {
  var_0 = 35.0;
  var_1 = 3.0;
  wait(var_0 - var_1);
  level._id_EA2C thread _id_0BDC::_id_A1F4("salter_goal_decoy", 1, undefined, 1);
  wait(var_1);
  scripts\engine\utility::flag_set("salter_found_destroyer");
}

_id_10CE4() {
  var_0 = getEnt("player_jackal", "targetname");
  var_0 _id_0BDC::_id_1162F("start_post_decoy");
  _id_0BDC::_id_10CD1(var_0);
  level._id_5311 = _id_106A5();
  thread _id_10AE::_id_E3B6(1);
  scripts\engine\utility::delaythread(0.05, _id_10AE::_id_E3FA, "ret_goal_ambush");
  scripts\engine\utility::flag_set("intro_done");
  _id_0BDC::_id_A162(1);
  level._id_EA2C = scripts\sp\vehicle::_id_1080C("salter_jackal");
  level._id_EA2C _id_0BDC::_id_1162F("salter_goal_decoy");
  level._id_EA2C _id_0BDC::_id_19A9();
  level._id_EA2C _id_0BDC::_id_19AE("dont_shoot");
  level._id_EA2C thread _id_10AE::_id_A1F1("salter_spline_post_decoy");

  if(getdvarint("ja_skip_preload", 0) == 0) {
    level thread scripts\sp\utility::_id_BF97();
  }

  scripts\engine\utility::flag_set("jackal_objectives_can_display");
  scripts\engine\utility::flag_set("destroyer_vo_done");
  wait 0.5;
  _id_10AE::_id_577D("find_destroyer");
  thread _id_10AE::_id_56B3("find_destroyer", "jackal_objective_find_destroyer", 0, &"JACKAL_OBJECTIVE_FIND_DESTROYER_MENU");
  thread _id_10AE::_id_7265("find_destroyer");
}

_id_B216() {
  while(!isDefined(level._id_E35D)) {
    wait 0.05;
  }

  wait 5.0;
  scripts\engine\utility::flag_set("sdf_ambush");
  scripts\engine\utility::delaythread(1.7, _id_10AE::_id_CE81, ::_id_1E29);
  thread ambush_music();
  _id_BC20();
  thread _id_10AE::_id_57A8("destroyers", "sdf_destroyers", undefined, undefined, undefined, 1, 1, 1);
  scripts\engine\utility::delaythread(0.05, ::_id_5316);
  wait 1.0;
  _id_BC43();
  thread _id_10AE::_id_57A9("missileBoats", "sdf_missileboats", undefined, undefined, ::_id_B881, 1, 1);
  scripts\engine\utility::delaythread(8.0, ::_id_B883);
  wait 3.0;
  scripts\sp\utility::_id_6EEB();
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  thread _id_10AE::_id_57AC("skelters", "axis_arena_jackals", 18, 5, 6, 1, undefined, ::_id_10237);
  level._id_EA2C scripts\engine\utility::delaythread(0.5, _id_10AF::_id_A123, 0);
  scripts\engine\utility::flag_wait("display_ambush_objectives");
  scripts\engine\utility::delaythread(0.2, _id_10AE::_id_8E7F, "find_destroyer");
  wait 0.5;
  thread _id_10AE::_id_56B3("missileBoats", "jackal_objective_missile_boats", 0, &"JACKAL_OBJECTIVE_MISSILE_BOATS_MENU");
  wait 0.5;
  thread _id_10AE::_id_56B3("destroyers", "jackal_objective_destroyers", 0, &"JACKAL_OBJECTIVE_DESTROYERS_MENU");
  wait 0.5;
  thread _id_10AE::_id_56B3("skelters", "jackal_objective_skelters", 0, &"JACKAL_OBJECTIVE_SKELTERS_MENU");
  thread _id_B885();
  thread _id_E315();
  thread _id_C505();
  _id_0BDC::_id_A162(0);
  wait 5.0;
  _id_BBF9();
  thread _id_10AE::_id_57A7("aces", "sdf_ace", undefined, ::_id_1550, ::_id_1551);
  thread _id_10AE::_id_56B3("aces", "jackal_objective_ace", 0, &"JACKAL_OBJECTIVE_ACE_MENU");
  scripts\engine\utility::flag_wait("skelterscomplete_vo_finished");
  scripts\engine\utility::flag_wait("missileBoatscomplete_vo_finished");
  scripts\engine\utility::flag_wait("destroyerscomplete_vo_finished");
  scripts\engine\utility::flag_wait("acescomplete_vo_finished");
}

ambush_music() {
  setmusicstate("mx_283_ja_asteroid_ambush");
}

_id_E315() {
  var_0 = "destroyers1_left";
  scripts\engine\utility::flag_wait(var_0);
  wait 3.0;
  _id_10AE::_id_CE80(::_id_52DE);
  wait 0.5;
  level._id_A3A8["destroyers"]._id_FE2D = scripts\engine\utility::array_removeundefined(level._id_A3A8["destroyers"]._id_FE2D);

  if(level._id_A3A8["destroyers"]._id_FE2D.size == 0) {
    return;
  }
  scripts\engine\utility::flag_init("ret_can_kill_destroyer");
  scripts\engine\utility::flag_init("ret_killed_destroyer");
  thread _id_10AE::_id_CE80(::_id_E316);
  scripts\engine\utility::flag_wait("ret_can_kill_destroyer");
  level._id_A3A8["destroyers"]._id_FE2D = scripts\engine\utility::array_removeundefined(level._id_A3A8["destroyers"]._id_FE2D);

  if(level._id_A3A8["destroyers"]._id_FE2D.size == 0) {
    return;
  }
  _id_10AE::_id_E3DD(level._id_A3A8["destroyers"]._id_FE2D[0], 0, 30.0);
  scripts\engine\utility::flag_set("ret_killed_destroyer");
}

_id_B883() {
  foreach(var_1 in level._id_A3A8["missileBoats"]._id_FE2D) {
    if(isDefined(var_1) && isalive(var_1)) {
      var_1 thread _id_B86C();
    }
  }
}

_id_B86C() {
  self endon("death");
  thread _id_B86B();
  self._id_24CE.occupied = 1;
  var_0 = randomfloatrange(0.0, 5.0);
  var_1 = 1.0;
  wait(var_0);

  for(;;) {
    var_2 = 0;
    var_3 = _id_0BB1::_id_77D2(getEntArray("missileboat_volume", "targetname"));
    var_3 = scripts\engine\utility::array_randomize(var_3);

    if(var_3.size > 0) {
      foreach(var_5 in var_3) {
        if(!isDefined(var_5.occupied) || var_5.occupied == 0) {
          self._id_24CE.occupied = 0;
          thread _id_0BB1::_id_F486(var_5);
          var_5.occupied = 1;
          var_2 = 1;

          while(self._id_24CE != var_5) {
            wait 0.1;
          }

          break;
        }
      }
    }

    if(var_2) {
      var_0 = randomfloatrange(3.0, 8.0);
    } else {
      var_0 = var_1;
    }

    wait(var_0);
  }
}

_id_B86B() {
  self waittill("death");

  if(isDefined(self) && isDefined(self._id_24CE)) {
    self._id_24CE.occupied = 0;
  }
}

_id_C505() {
  for(;;) {
    var_0 = ["skelterscomplete_vo_finished", "destroyerscomplete_vo_finished", "missileBoatscomplete_vo_finished", "acescomplete_vo_finished"];
    var_1 = level scripts\engine\utility::waittill_any_return(var_0[0], var_0[1], var_0[2], var_0[3]);
    var_2 = [];

    foreach(var_4 in var_0) {
      if(!scripts\engine\utility::flag_exist(var_4) || !scripts\engine\utility::flag(var_4)) {
        var_2[var_2.size] = var_4;
      }
    }

    if(var_2.size == 1) {
      var_6 = 0.8;

      if(var_2[0] == "destroyerscomplete_vo_finished") {
        thread _id_10AE::_id_CE80(::_id_52FE, 0, var_6);
      } else {
        thread _id_10AE::_id_CE80(::_id_C074, 0, var_6);
      }

      break;
    }

    wait 0.05;
  }
}

_id_10CAE() {
  var_0 = getEnt("player_jackal", "targetname");
  var_0 _id_0BDC::_id_1162F("start_post_decoy");
  _id_0BDC::_id_10CD1(var_0);
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
  thread _id_10AE::_id_E3B6(1);
  scripts\engine\utility::delaythread(0.05, _id_10AE::_id_E3FA, "ret_goal_ambush");

  if(getdvarint("ja_skip_preload", 0) == 0) {
    level thread scripts\sp\utility::_id_BF97();
  }
}

_id_B20F() {
  while(!isDefined(level._id_E35D)) {
    wait 0.05;
  }

  thread jackass_victory_music();
  scripts\sp\utility::_id_6EEA();
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7();
  scripts\engine\utility::flag_init("mission_complete_vo_done");
  thread _id_10AE::_id_CE81(::_id_B8BD);
  _id_10AE::_id_E3F9();
  scripts\engine\utility::flag_wait("mission_complete_vo_done");
  _id_10AE::_id_E3F8();
  _id_10AE::_id_579D(::_id_A7DA, ::_id_A7D9, ::_id_A82F, ::_id_A7F4);
}

jackass_victory_music() {
  setmusicstate("");
  wait 8;
  setmusicstate("mx_368b_ja_asteroid_victory");
}

_id_10C57() {
  var_0 = getEnt("player_jackal", "targetname");
  var_0 _id_0BDC::_id_1162F("start_ftl_test");
  _id_0BDC::_id_10CD1(var_0);
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
  thread _id_10AE::_id_E3B6(1);
  scripts\engine\utility::delaythread(0.05, _id_10AE::_id_E3FA, "ret_goal_ambush");
}

_id_B1E5() {
  level.player notifyonplayercommand("dpadup", "+actionslot 1");
  level.player waittill("dpadup");
  _id_BC20();
  thread _id_10AE::_id_57A8("destroyers", "sdf_destroyers", undefined, undefined, undefined, 1, 1, 1);
  scripts\engine\utility::delaythread(0.05, ::_id_5316);
  wait 1.0;
  _id_BC43();
  thread _id_10AE::_id_57A9("missileBoats", "sdf_missileboats", undefined, undefined, undefined, 1, 1);
  wait 2.0;
  _id_BBF9();
  thread _id_10AE::_id_57A7("aces", "sdf_ace");
}

_id_5316() {
  foreach(var_1 in level._id_A3A8["destroyers"]._id_FE2D) {
    var_1 thread _id_5300();
  }
}

_id_5300() {
  self waittill("mover_spawned");
  var_0 = self.origin;
  var_1 = (0, self.angles[1], 0);
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoup(self.angles);
  self._id_BCDA moveTo(var_0 + var_2 * 8000, 4.0, 0.0, 4.0);
  self._id_BCDA rotateTo(var_1, 6.0, 3.0, 3.0);
}

_id_D901() {
  for(;;) {
    var_0 = level._id_D127.spaceship_vel;
    var_1 = vectorNormalize(var_0);
    var_2 = anglesToForward(level._id_D127.angles);
    var_3 = vectorNormalize(var_2);
    var_4 = length(var_0) * vectordot(var_1, var_3);
    var_5 = 1.0;
    var_6 = 2.0;
    var_7 = clamp(var_4 / 720 * (var_6 - var_5) + var_5, var_5, var_6);
    iprintlnbold(var_7);
    wait 0.2;
  }
}

_id_AAA1() {
  scripts\sp\utility::_id_10350("ja_ast_nav_wereapproaching");
  wait 1.2;
  scripts\sp\utility::_id_10350("ja_ast_slt_copywerevisual");
  scripts\sp\utility::_id_1034D("ja_ast_plr_scarsgetaperime");
  scripts\sp\utility::_id_10350("ja_ast_slt_rogerthat");
}

_id_F083() {
  level endon("player_found_destroyer");
  level endon("salter_found_destroyer");
  wait 9.0;
  thread _id_10AE::_id_CE80(::_id_F080);
  wait 2.0;
  wait 3.0;
  thread _id_10AE::_id_CE80(::_id_F081);
}

_id_F080() {
  scripts\sp\utility::_id_1034D("ja_ast_plr_youseeanything");
  scripts\sp\utility::_id_10350("ja_ast_slt_allquiet");
}

_id_F081() {
  scripts\sp\utility::_id_1034D("ja_ast_plr_tooquietgator");
  scripts\sp\utility::_id_10350("ja_ast_nav_rightcoordinates");
}

_id_D081() {
  _id_10AE::_id_CE87(scripts\sp\utility::_id_1034D, "ja_ast_plr_founditsdfdestr");
  wait 1.25;
  thread _id_5310();
}

_id_EA7F() {
  _id_10AE::_id_CE87(scripts\sp\utility::_id_1034D, "ja_ast_slt_raideroverherei");
}

_id_5310() {
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_10350("ja_ast_nav_nosignature");
  scripts\sp\utility::_id_10350("ja_ast_slt_lookslikesetdef");
  scripts\sp\utility::_id_10350("ja_ast_nav_thatwouldexplain");
  scripts\sp\utility::_id_1034D("ja_ast_plr_welldeployasalv");
  scripts\engine\utility::flag_set("post_decoy_salter_move");
  scripts\sp\utility::_id_10350("ja_ast_nav_rightawaysir");
  scripts\sp\utility::_id_1034D("ja_ast_plr_letscirclebackto");
  _id_10AE::_id_134D1();
  scripts\engine\utility::flag_set("destroyer_vo_done");
}

_id_700A() {}

_id_1E29() {
  scripts\sp\utility::_id_10350("ja_ast_nav_sdfdestroyers");
  scripts\sp\utility::_id_10350("ja_ast_slt_shititsanambush");
  scripts\sp\utility::_id_1034D("ja_ast_plr_scarswevegotmul");
  scripts\sp\utility::_id_10350("ja_ast_slt_givethemhell");
  scripts\engine\utility::flag_set("display_ambush_objectives");
}

_id_10237() {
  wait 1.7;
}

_id_1550() {
  scripts\sp\utility::_id_10350("ja_ast_nav_sirradarshows");
  scripts\sp\utility::_id_1034D("ja_ast_plr_solidcopy141");
  scripts\sp\utility::_id_1034D("ja_ast_plr_saltyougood");
  scripts\sp\utility::_id_10350("ja_ast_slt_neverbetter");
}

_id_1551() {
  scripts\sp\utility::_id_1034D("ja_ast_plr_acedustedhesdow");
}

_id_B885() {
  scripts\engine\utility::flag_wait("missileBoats2_left");
  wait 2.5;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_10350("ja_ast_slt_ajakinthebox");
  _id_10AE::_id_134D1();
  scripts\engine\utility::flag_wait("missileBoats1_left");
  wait 2.5;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_1034D("ja_ast_plr_lightsoutonan");
  _id_10AE::_id_134D1();
}

_id_B881() {
  scripts\sp\utility::_id_10350("ja_ast_slt_splashxone");
  scripts\sp\utility::_id_10350("ja_ast_nav_allenemyajak");
}

_id_52DE() {
  scripts\sp\utility::_id_10350("ja_ast_slt_thatsonedestroy");
  scripts\sp\utility::_id_10350("ja_ast_nav_retributionhasd");
}

_id_E316() {
  scripts\sp\utility::_id_1034D("ja_ast_plr_gatorifyouvegotthe");
  scripts\sp\utility::_id_10350("ja_ast_nav_ayesirweapons");
  scripts\engine\utility::flag_set("ret_can_kill_destroyer");
  scripts\engine\utility::flag_wait("ret_killed_destroyer");
  wait 3.0;
  scripts\sp\utility::_id_10350("ja_ast_slt_bigbangfromret");
  scripts\sp\utility::_id_10350("ja_ast_nav_retributiondisabled");
  scripts\sp\utility::_id_10350("ja_ast_slt_thatsanunderstatement");
}

_id_52FE() {
  if(scripts\engine\utility::flag_exist("skelterscomplete") && scripts\engine\utility::flag("skelterscomplete") && scripts\engine\utility::flag_exist("missileBoatscomplete") && scripts\engine\utility::flag("missileBoatscomplete") && scripts\engine\utility::flag_exist("destroyerscomplete") && scripts\engine\utility::flag("destroyerscomplete") && scripts\engine\utility::flag_exist("acescomplete") && scripts\engine\utility::flag("acescomplete")) {
    return;
  }
  scripts\sp\utility::_id_1034D("ja_ast_plr_allscarsconcent");
}

_id_C074() {
  if(scripts\engine\utility::flag_exist("skelterscomplete") && scripts\engine\utility::flag("skelterscomplete") && scripts\engine\utility::flag_exist("missileBoatscomplete") && scripts\engine\utility::flag("missileBoatscomplete") && scripts\engine\utility::flag_exist("destroyerscomplete") && scripts\engine\utility::flag("destroyerscomplete") && scripts\engine\utility::flag_exist("acescomplete") && scripts\engine\utility::flag("acescomplete")) {
    return;
  }
  scripts\sp\utility::_id_10350("ja_ast_slt_weclearthisector");
  scripts\sp\utility::_id_1034D("ja_ast_plr_stillmoreofthem");
}

_id_B8BD() {
  scripts\sp\utility::_id_1034D("ja_ast_plr_thatsthelastofe");
  scripts\sp\utility::_id_10350("ja_ast_slt_setdefpickedafi");
  scripts\engine\utility::delaythread(2.0, scripts\engine\utility::flag_set, "mission_complete_vo_done");
  scripts\sp\utility::_id_1034D("ja_ast_plr_retributionswai");
  scripts\sp\utility::_id_10350("ja_ast_nav_bringemhomecaptain");
}

_id_A7DA() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_1034D("ja_ast_plr_scar11returning");
  scripts\sp\utility::_id_10350("ja_ast_amb_scarsclearforlan");
  scripts\sp\utility::_id_1034D("ja_ast_plr_11roger");
  scripts\sp\utility::_id_10350("ja_ast_slt_12");
}

_id_A7D9() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_1034D("ja_ast_plr_scar11returning");
}

_id_A82F() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_10350("ja_ast_amb_captaindroneass");
  scripts\sp\utility::_id_10350("ja_ast_amb_standbyfordrone");
}

_id_A7F4() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_1034D("ja_ast_plr_flapsdowngearsout");
  scripts\sp\utility::_id_10350("ja_ast_amb_goodlock11we");
}

_id_106A5() {
  var_0 = getEnt("sdf_destroyer_decoy", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10808();
  var_1 scripts\engine\utility::delaythread(0.05, _id_0BB8::_id_39CD, "off_kill");
  var_1 scripts\engine\utility::delaythread(0.05, _id_0BB8::_id_39CE, "off_kill");
  return var_1;
}

_id_6C8B() {
  level.player endon("death");
  level endon("player_found_destroyer");
  thread _id_52EC();
  level._id_5311._id_B89E = 15000;
  level._id_5311._id_B89F = 5000;
  level._id_5311._id_B89B = 25000;
  level._id_5311._id_B89C = 0.9;
  level._id_5311._id_B89D = 1.0;
  level._id_5311._id_B8A3 = 30000;
  level._id_5311._id_B8A0 = 18000;
  level._id_5311._id_B8A1 = 0.8;
  level._id_5311._id_B8A2 = 3.0;
  level._id_5311 childthread _id_0BA9::_id_39BD();
  wait 0.05;
  level._id_5311 scripts\sp\utility::_id_65E3("player_is_near");
  scripts\engine\utility::flag_set("player_found_destroyer");
}

_id_52EC() {
  level.player endon("death");
  level endon("player_found_destroyer");

  for(;;) {
    var_0 = level._id_5311.origin - level._id_D127.origin;
    var_1 = vectorNormalize(var_0);
    var_2 = anglesToForward(level._id_D127.angles);
    level._id_5311._id_56EA = length(var_0);
    level._id_5311._id_5ABB = vectordot(var_1, var_2);
    wait 0.05;
  }
}

_id_170D() {
  level._id_5311 _id_0BDC::_id_105DB("missile", undefined, "none", undefined, 0, undefined, 1);
  level._id_5311 _id_0B76::_id_F42C("ally_objective");
}

_id_E055() {
  level._id_5311 _id_0BDC::_id_E046();
  level._id_5311 _id_0BDC::_id_105DA();
}

_id_BC43() {
  var_0 = getEntArray("sdf_missileboats", "targetname");
  var_1 = _id_10AE::_id_6C7B("missileboat_ftl_point", var_0.size, 15000, 25000, 0.9);

  foreach(var_4, var_3 in var_0) {
    var_3 scripts\sp\utility::_id_11624(var_1[var_4]);
  }
}

_id_BC20() {
  var_0 = getEntArray("sdf_destroyers", "targetname");
  var_1 = _id_10AE::_id_6C7B("destroyer_ftl_point", var_0.size, 20000, 55000, 0.9);

  foreach(var_4, var_3 in var_0) {
    var_3 scripts\sp\utility::_id_11624(var_1[var_4]);
  }
}

_id_BBF9() {
  var_0 = getEnt("sdf_ace", "targetname");
  var_1 = undefined;
  var_2 = scripts\engine\utility::getStructArray("ace_spawn_point", "targetname");
  var_3 = 35000;

  foreach(var_5 in var_2) {
    if(!var_5 _id_0BDC::_id_9C1B(0.6) && distance(var_5.origin, level._id_D127.origin) >= var_3) {
      var_1 = var_5;
      break;
    }
  }

  if(!isDefined(var_1)) {
    foreach(var_5 in var_2) {
      if(!var_5 _id_0BDC::_id_9C1B(0.6)) {
        var_1 = var_5;
        break;
      }
    }
  }

  if(!isDefined(var_1)) {
    var_1 = var_2[randomint(var_2.size)];
  }

  var_0 scripts\sp\utility::_id_11624(var_1);
}

_id_13331() {
  var_0 = getEntArray("ambient_rotate_object", "script_noteworthy");

  foreach(var_2 in var_0) {
    playFX(scripts\engine\utility::getfx("vfx_ja_space_gas_cloud_03"), var_2.origin);
  }
}

_id_1DE7() {
  var_0 = getEntArray("ambient_rotate_object", "script_noteworthy");
  level._id_E736 = [];

  foreach(var_2 in var_0) {
    if(!issubstr(var_2.classname, "script_brushmodel")) {
      var_3 = getEntArray(var_2.target, "targetname");

      if(isDefined(var_2.target)) {
        scripts\engine\utility::array_call(var_3, ::linkto, var_2);
      }

      level._id_E736[level._id_E736.size] = var_2;
      var_2 thread _id_1DE6();
    }
  }
}

_id_1DE6() {
  var_0 = 3;
  var_1 = 6;
  var_2 = 2;
  var_3 = [];

  if(isDefined(self.script_parameters)) {
    var_3 = strtok(self.script_parameters, " ");
  }

  var_4 = [];
  var_5 = [];
  var_2 = clamp(var_2, 2, 3);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    if(!isDefined(var_3[var_6])) {
      if(var_3.size == 1) {
        var_4[var_6] = float(var_3[0]);
      } else {
        var_4[var_6] = randomintrange(var_0, var_1);
      }
    } else
      var_4[var_6] = float(var_3[var_6]);

    var_5[var_6] = ::scripts\engine\utility::random([-1, 1]);
  }

  for(;;) {
    var_7 = [];
    var_8 = "";

    for(var_6 = 0; var_6 < var_2; var_6++) {
      var_7[var_6] = self.angles[var_6] + var_4[var_6] / 20 * var_5[var_6];
      var_8 = var_8 + (var_4[var_6] + " ");
    }

    self.angles = (var_7[0], var_7[1], self.angles[2]);

    if(getdvarint("debug_rotate") == 1) {
      thread scripts\engine\utility::draw_ent_axis((1, 0, 0), 2, 1000);
    }

    scripts\engine\utility::waitframe();
  }
}