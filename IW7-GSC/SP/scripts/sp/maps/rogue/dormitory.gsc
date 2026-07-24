/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\dormitory.gsc
***********************************************/

_id_5A9E() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("dormitory_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("dormitory_start");
  scripts\sp\maps\rogue\rogue_util::_id_111E7(19, 30, 25, 10, 145);
  thread scripts\sp\maps\rogue\surface::_id_5A6B(1);
  thread scripts\sp\maps\rogue\surface::_id_112DE();
  thread scripts\sp\maps\rogue\surface::_id_112D6();
  _id_4527();
}

_id_5A87() {
  precachemodel("civ_miner_male");
  precachemodel("parts_flightsuit_no_patches");
}

_id_5A86() {
  scripts\engine\utility::flag_init("dorm_airlock_door_shut");
  scripts\engine\utility::flag_init("flag_creep_unlock_door");
  scripts\engine\utility::flag_init("rogue_dorm_steam_gag");
  scripts\engine\utility::flag_init("armory_opened");
  scripts\engine\utility::flag_init("player_stumbled_in_dorm_run");
  scripts\engine\utility::flag_init("dorm_run_started");
}

_id_5A88() {}

_id_5A9C() {
  scripts\engine\utility::flag_set("dorm_run_started");
  scripts\engine\utility::flag_clear("dorm_run_over");
  setmusicstate("");
  thread _id_EA57();
  thread _id_7574();
  thread scripts\sp\maps\rogue\rogue_util::_id_E64A(450, 450, 450, 450);
  level.player scripts\sp\utility::_id_D2D1(180, 0.5);
  setsaveddvar("player_sprintunlimited", 1);
  var_0 = getEnt("array_2_animNode", "targetname");
  var_1 = getEnt("dorm_animnode", "targetname");
  var_2 = [level._id_B33E, level._id_B33B, level._id_B4F9, level._id_13E12];
  var_3 = getEnt("dorm_airlock_door", "targetname");
  level._id_8772 = 0;
  thread _id_5A8B();
  thread _id_D2E7(var_0, var_1);
  thread _id_59FB();

  foreach(var_5 in var_2) {
    var_5 scripts\sp\utility::_id_5564();
    var_5 thread _id_10AD4(var_0, var_1);
  }

  level.player clearclienttriggeraudiozone(2);
  thread _id_5A85();
  scripts\sp\anim::_id_1EB3(var_2);
  setglobalsoundcontext("atmosphere", "helmet", 1);
  thread scripts\sp\maps\rogue\rogue_util::_id_1AC5("red");
  var_3 thread _id_5A70(var_1);
  scripts\engine\utility::flag_wait("dorm_run_over");
  scripts\engine\utility::flag_clear("outdoor_surface_physics_on");
  thread scripts\sp\maps\rogue\rogue_util::_id_1AC5("green");

  foreach(var_5 in var_2)
  var_5 scripts\sp\utility::_id_6224();
}

_id_EA57() {
  level endon("player_in_scene");
  scripts\engine\utility::flag_waitopen("power_on");
  wait 2;
  scripts\engine\utility::flag_wait("power_on");
  wait 2;
  level._id_13E12 scripts\sp\utility::_id_10346("asteroid_slt_reesewherethe");
}

_id_5A9D() {
  while(!scripts\engine\utility::flag("dorm_run_over")) {
    var_0 = scripts\sp\utility::_id_78AA(level.player.origin, "allies");
    var_1 = distance2d(level.player.origin, var_0.origin);

    if(var_1 <= 64)
      level.player scripts\sp\utility::_id_D2CD(70, 0.2);
    else if(var_1 <= 128)
      level.player scripts\sp\utility::_id_D2CD(75, 0.2);
    else if(var_1 <= 256)
      level.player scripts\sp\utility::_id_D2CD(80, 0.2);
    else if(var_1 <= 512)
      level.player scripts\sp\utility::_id_D2CD(90, 0.2);
    else
      level.player scripts\sp\utility::_id_D2CD(100, 0.2);

    wait 0.2;
  }

  level.player scripts\sp\utility::_id_D2CD(100, 0.2);
}

_id_59FB() {
  var_0 = getEntArray("airlock_door_collision", "targetname");

  while(distance2d(var_0[0].origin, level.player.origin) > 450)
    wait 0.05;

  scripts\engine\utility::exploder("reachairlock");
}

_id_7574() {
  wait 3;
  scripts\engine\utility::exploder("rockland_06");
}

_id_10AD4(var_0, var_1) {
  self endon("default_jump_endon");
  var_2 = undefined;

  switch (tolower(self._id_1FBB)) {
    case "mco":
      var_2 = 9.25;
      break;
    case "marine1":
      var_2 = 7.85;
      break;
    case "xo":
      var_2 = 9.5;
      break;
    case "marine2":
      var_2 = 9.8;
    default:
      break;
  }

  scripts\engine\utility::delaythread(var_2, ::_id_2273);
  var_0 scripts\sp\anim::_id_1F35(self, "array_2_exit");
  var_1 scripts\sp\anim::_id_1F17(self, "dorm_airlock_entrance_run");

  if(self == level._id_B4F9)
    _id_B4FA(var_1);
  else {
    level notify("first_guy_in");
    scripts\sp\utility::_id_65E1("playing_dorm_intro");
    var_1 scripts\sp\anim::_id_1F35(self, "dorm_airlock_entrance_run");

    if(isDefined(self._id_2271))
      self._id_2271 notify("stop_array_idle");

    var_1 thread scripts\sp\anim::_id_1EEA(self, "dorm_airlock_entrance_idle", "airlock_open");
  }
}

_id_5A8B() {
  foreach(var_1 in level._id_10AC8)
  var_1 scripts\sp\utility::_id_65E0("playing_dorm_intro");

  level waittill("first_guy_in");
  var_3 = getEnt("dorm_animnode", "targetname");
  var_4 = sortbydistance(level._id_10AC8, var_3.origin);
  var_5 = 2.5;

  foreach(var_1 in var_4) {
    var_1 thread _id_5A72(var_5);
    var_5 = var_5 - 0.5;
  }
}

#using_animtree("generic_human");

_id_5A72(var_0) {
  scripts\sp\utility::_id_65E3("playing_dorm_intro");
  var_1 = undefined;

  switch (self._id_1FBB) {
    case "xo":
      var_1 = % asteroid_airlock_salter_entrance_run;
      break;
    case "marine1":
      var_1 = % asteroid_airlock_ally2_entrance_run;
      break;
    case "marine2":
      var_1 = % asteroid_airlock_ally1_entrance_run;
      break;
    case "MCO":
      var_1 = % asteroid_airlock_mco_entrance_enter_nostop;
      break;
    default:
      return;
  }

  self _meth_82B1(var_1, var_0);
}

_id_2273() {
  self._id_5A79 = 1;
  level._id_8772++;
}

_id_5A85() {
  level waittill("start_vo");
  level._id_B33E scripts\sp\utility::_id_10346("asteroid_brk_Thedoorsopen");
  wait 1;
  level._id_B4F9 scripts\sp\utility::_id_10346("asteroid_usf_GetinsideMoveit");
  wait 1;
  level notify("player_efforts");
  level._id_13E12 scripts\sp\utility::_id_10346("asteroid_slt_hurryraiderbook");
}

_id_5A78(var_0, var_1) {
  if(isDefined(self._id_5A79) && self._id_5A79) {
    return;
  }
  self notify("default_jump_endon");
  self notify("reach_notify");
  self notify("single anim", "end");
  self _meth_83A1();
  var_0 thread scripts\sp\anim::_id_1F35(self, "dorm_approach_land");
  wait 0.05;
  self _meth_82B0(scripts\sp\utility::_id_7DC1("dorm_approach_land"), 0.85);
  var_1 scripts\sp\anim::_id_1F17(self, "dorm_airlock_entrance_run");

  if(self == level._id_B4F9)
    _id_B4FA(var_1);
  else {
    level notify("first_guy_in");
    scripts\sp\utility::_id_65E1("playing_dorm_intro");
    var_1 scripts\sp\anim::_id_1F35(self, "dorm_airlock_entrance_run");

    if(isDefined(self._id_2271))
      self._id_2271 notify("stop_array_idle");

    var_1 thread scripts\sp\anim::_id_1EEA(self, "dorm_airlock_entrance_idle", "airlock_open");
  }
}

_id_B4FA(var_0) {
  level endon("stop_dorm_run_anims");
  var_1 = getEnt("dorm_airlock_door", "targetname");
  var_0 thread _id_1ACC(var_0);
  level notify("first_guy_in");
  scripts\sp\utility::_id_65E1("playing_dorm_intro");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_airlock_entrance_nostop");
  var_0 scripts\sp\anim::_id_1EEA(self, "dorm_airlock_inside_idle", "airlock_open");
}

_id_1ADC() {
  scripts\engine\utility::flag_set("player_stumbled_in_dorm_run");
  scripts\sp\maps\rogue\rogue_util::_id_111E7(5, 20, 20, 90, 240);
  scripts\engine\utility::flag_set("sun_safe_zone");
  wait 4;
  scripts\engine\utility::flag_clear("sun_safe_zone");
  var_0 = scripts\engine\utility::getStruct("dorm_airlock_trig_org", "targetname");
  var_1 = squared(1200);

  while(distancesquared(var_0.origin, level.player.origin) > var_1)
    scripts\engine\utility::waitframe();

  scripts\engine\utility::flag_set("fake_burn_player");
  thread _id_A604();
  scripts\engine\utility::flag_clear("flashlight_desired");
  scripts\engine\utility::flag_clear("sun_vision_blend");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  level waittill("time_6");
  level endon("player_is_inside");
  wait 5;
  scripts\engine\utility::flag_clear("fake_burn_player");
}

_id_A604() {
  level endon("player_is_inside");
  wait 6;
  level.player _meth_81D0();
}

_id_1ACC(var_0) {
  var_1 = scripts\engine\utility::getStruct("dorm_airlock_trig_org", "targetname");
  var_2 = scripts\sp\utility::_id_10639("player_rig");
  level.player._id_4BA6 = var_2;
  var_2 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_2, "dorm_airlock_entrance_player");
  var_3 = spawn("trigger_radius", var_2.origin, 0, 64, 64);
  var_3 waittill("trigger");
  scripts\engine\utility::flag_set("fake_burn_player");
  var_3 delete();
  thread _id_FB34();
  scripts\engine\utility::flag_set("player_is_inside");
  level.player scripts\sp\maps\rogue\rogue_util::_id_DB2E(var_2, 0.3, 0, 0, 0, 0);
  scripts\engine\utility::delaythread(1, scripts\engine\utility::flag_set, "disable_alt_vision_calls");
  var_0 thread scripts\sp\anim::_id_1F35(var_2, "dorm_airlock_entrance_player");
  level waittill("start_ally_anims");

  foreach(var_5 in level._id_10AC8)
  var_5 scripts\sp\utility::_id_5522();

  var_0 thread _id_DAE2(var_2);
  var_0 notify("player_arrived");
  level.player._id_4BA6 = undefined;
  scripts\engine\utility::flag_set("sun_safe_zone");
  level.player notify("burn_stopped");
  scripts\engine\utility::flag_clear("fake_burn_player");
  scripts\engine\utility::flag_set("dorm_run_over");
}

_id_DAE2(var_0) {
  var_0 waittill("single anim");
  level.player scripts\sp\maps\rogue\rogue_util::_id_DAE1(var_0);
  thread scripts\sp\maps\rogue\rogue::_id_E65B();
}

_id_FB34() {
  wait 1.1;
  level.player playSound("scn_rogue_airlock_door_shut");
  wait 1.5;
  level.player _meth_82C0("rogue_airlock_room_dorm", 0.5);
  wait 1.1;
  level.player playSound("scn_rogue_airlock_pressurize_lr");
}

#using_animtree("player");

_id_D2E7(var_0, var_1) {
  level.player endon("death");
  scripts\engine\utility::flag_wait("player_jumped_chasm");
  scripts\engine\utility::delaythread(2, scripts\sp\maps\rogue\rogue_util::_id_404C);

  foreach(var_3 in level._id_10AC8)
  var_3 _meth_8250(0);

  thread scripts\engine\utility::exploder("Bigjump_01");
  var_5 = getgroundposition(level.player.origin, 32);

  while(distance(level.player.origin, var_5) > 32) {
    var_5 = getgroundposition(level.player.origin, 32);
    wait 0.05;
  }

  foreach(var_3 in level._id_10AC8)
  var_3 _meth_8250(1);

  thread _id_1ADC();
  thread _id_5A8A(var_0, var_1);
  level notify("stumbled");
  thread _id_5A9D();
  var_8 = scripts\sp\utility::_id_10639("player_rig");
  var_8.origin = level.player.origin;
  var_8.angles = level.player.angles;
  var_8 movez(32, 0.05, 0, 0);
  var_8 thread _id_A60F();
  level.player _meth_84FE();
  level.player _meth_818A();
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player playerlinktodelta(var_8, "tag_player", 1, 0, 0, 0, 0, 1);
  scripts\engine\utility::flag_set("player_in_scene");
  var_9 = getEnt("dormitory_run_rail_blocker", "targetname");

  if(isDefined(var_9))
    var_9 delete();

  thread _id_D1BB();
  var_8 thread scripts\sp\anim::_id_1F35(var_8, "player_landing");
  var_8 _meth_82B1(%rogue_player_land, 0.75);
  var_8 waittill("single anim");
  level.player unlink();
  var_8 delete();
  level.player enableweapons();
  level.player freezecontrols(0);
  level.player _meth_84FD();
  level.player showviewmodel();
  scripts\engine\utility::flag_clear("player_in_scene");
  level notify("start_vo");
  wait 1.5;
  scripts\sp\utility::_id_56BE("sprint", 6);
}

_id_A60F() {
  level endon("start_vo");
  level.player waittill("death");

  if(isDefined(self))
    self delete();
}

_id_D1BB() {
  wait 0.25;
  level.player playSound("scn_rogue_plr_catwalk_land");
  earthquake(1, 0.45, level.player getEye(), 70);
  level.player playRumbleOnEntity("damage_heavy");
}

_id_5A8A(var_0, var_1) {
  foreach(var_3 in level._id_10AC8)
  var_3 thread _id_5A78(var_0, var_1);
}

_id_5A70(var_0) {
  self._id_1FBB = "airlock_door";
  scripts\sp\anim::_id_F64A();
  var_0 scripts\sp\anim::_id_1EC3(self, "dorm_airlock_entrance_player");
  level._id_B4F9 waittill("shut_door");
  setmusicstate("");
  level notify("stop_surface_vfx_helmet");
  scripts\sp\utility::_id_10FEC("68");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_airlock_entrance_player");
  thread scripts\sp\maps\rogue\surface::_id_5A6B(0);
  scripts\engine\utility::flag_set("dorm_airlock_door_shut");
}

_id_5A97() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("dormitory_airlock_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("dormitory_airlock_start");
  scripts\engine\utility::flag_set("player_is_inside");
}

_id_5A6A() {}

_id_5A69() {
  scripts\engine\utility::flag_init("dorm_airlock_opened");
}

_id_5A6C() {}

_id_5A68() {
  scripts\engine\utility::flag_set("dorm_run_over");
  scripts\engine\utility::flag_set("player_stumbled_in_dorm_run");
}

_id_5A96() {
  thread toggle_dorm_flares();
  _id_5634();
  thread scripts\sp\maps\rogue\rogue_util::_id_1AC5("green");
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  scripts\sp\maps\rogue\rogue_util::_id_404C();
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12984);

  foreach(var_1 in level._id_10AC8) {
    var_1 _meth_8250(1);
    var_1.grenadeawareness = 0;
  }

  setsaveddvar("player_sprintunlimited", 0);
  scripts\engine\utility::flag_set("sun_safe_zone");
  scripts\engine\utility::flag_set("flag_lgt_dormitory_start");
  scripts\engine\utility::flag_set("interior_quakes");
  level notify("stop_dorm_run_anims");
  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(12, 12, 1, "enetered_dorm");
  level.player scripts\sp\utility::_id_D2D1(180, 0.5);
  _id_F946();
  thread _id_F948();
  var_3 = getEnt("dorm_airlock_door", "targetname");
  var_4 = _id_0B1E::_id_794D("dorm_intro_airlock");
  thread _id_0B1F::_id_1AA9("dormitory_entrance_airlock", 1, var_3, var_4, 1);
  var_5 = getEnt("dorm_animnode", "targetname");
  var_5 notify("player_arrived");
  var_5 notify("airlock_open");

  foreach(var_1 in level._id_10AC8)
  var_5 thread _id_1ADA(var_1);

  _id_0B1F::_id_1374E("dormitory_entrance_airlock");
  waitforalltransients();
  wait 0.5;
}

_id_1ADA(var_0) {
  level endon("player_opened_dorm_airlock");
  scripts\sp\anim::_id_1F35(var_0, "dorm_airlock_intro");
  var_0._id_1AC8 = 1;

  if(var_0 == level._id_B33B) {
    level._id_B33B setgoalpos(level._id_B33B.origin);
    return;
  }

  if(isDefined(var_0._id_2271))
    var_0._id_2271 notify("stop_array_idle");

  var_0 setgoalpos(var_0.origin);
}

_id_5AA0() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("dormitory_airlock_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("dormitory_airlock_start");
  scripts\engine\utility::flag_set("sun_safe_zone");
  scripts\engine\utility::flag_set("interior_quakes");
  _id_F946();
  thread _id_F948();
  level.player scripts\sp\utility::_id_D2D1(180, 0.5);
  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(12, 12, 1, "enetered_dorm");
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  _id_5634();
  scripts\engine\utility::flag_set("player_is_inside");
  thread toggle_dorm_flares();
}

_id_5A83() {}

_id_5A76() {
  scripts\engine\utility::flag_init("dorm_exploration_finished");
  scripts\engine\utility::flag_init("start_dorm_entrances");
  scripts\engine\utility::flag_init("player_viewing_scene");
  scripts\engine\utility::flag_init("bail_on_shuffle");
  scripts\engine\utility::flag_init("player_visited_kitchen");
  scripts\engine\utility::flag_init("player_visited_media");
  scripts\engine\utility::flag_init("player_visited_quarters");
  scripts\engine\utility::flag_init("player_visited_armory");
  scripts\engine\utility::flag_init("pause_nags");
  scripts\engine\utility::flag_init("dorm_explore_finished");
  scripts\engine\utility::flag_init("mco_ready_for_kichen_scene");
  scripts\engine\utility::flag_init("timeout_occured_in_dorms");
  scripts\engine\utility::flag_init("player_sees_bodies");
  scripts\engine\utility::flag_init("flag_dorm_scene_active");
  scripts\engine\utility::flag_init("player_leaving_dorms");
  scripts\engine\utility::flag_init("all_dorm_scenes_complete");
  scripts\engine\utility::flag_init("dorm_explore_xo_done");
  scripts\engine\utility::flag_init("dorm_explore_marine1_done");
  scripts\engine\utility::flag_init("dorm_explore_kitchen_done");
  scripts\engine\utility::flag_init("start_creep_vo");
}

_id_5A8D() {}

_id_5A9A() {
  level.player scripts\sp\utility::_id_F526("normal");
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  thread _id_10F5B();
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12984);
  _id_1ABB();

  foreach(var_1 in level._id_10AC8)
  var_1 _meth_8250(0);

  scripts\engine\utility::flag_wait("start_dorm_entrances");
  thread achievement_watcher();
  _id_B22A();
  _id_F9E4();
  getEnt("dorm_animnode", "targetname") thread _id_D1CB();
  thread _id_5A75();
  thread _id_5A74();
  thread _id_1629();
  thread _id_D1C8();
  thread _id_5713();
  _id_5A8E();
  thread _id_D06F();
}

_id_5713() {
  while(!scripts\engine\utility::flag("player_leaving_dorms")) {
    wait(randomfloatrange(10, 20));
    thread _id_7650();
    wait(randomfloatrange(10, 20));
    thread _id_7650();
    wait(randomfloatrange(10, 20));
    thread _id_7650();
    wait(randomfloatrange(10, 20));
    thread _id_7650();
    wait(randomfloatrange(10, 20));
    thread _id_7650();
    wait(randomfloatrange(10, 20));
    thread _id_7650();
  }
}

_id_D1C8() {
  var_0 = getEnt("leaving_dorm_nag_trig", "targetname");
  var_0 waittill("trigger", var_1);
  scripts\engine\utility::flag_set("player_leaving_dorms");

  if(scripts\engine\utility::flag("all_dorm_scenes_complete")) {
    level.player scripts\sp\utility::_id_10350("asteroid_plr_letsgetthisshow");

    if(distance(level.player.origin, level._id_13E12.origin) > 800)
      level._id_13E12 scripts\sp\utility::_id_10346("asteroid_slt_okaywellberight");
  }
}

_id_5A75() {
  level endon("player_leaving_dorm");
  scripts\engine\utility::flag_wait("player_visited_kitchen");
  scripts\engine\utility::flag_wait("player_visited_quarters");
  scripts\engine\utility::flag_wait("player_visited_media");
  scripts\engine\utility::flag_wait("player_visited_armory");
  level scripts\engine\utility::waittill_either("dorm_scene_bailed", "dorm_scene_done");
  scripts\engine\utility::flag_set("all_dorm_scenes_complete");
}

_id_1ABB() {
  scripts\engine\utility::flag_init("dorm_door_peeked_open");
  scripts\engine\utility::flag_init("dorm_door_kicked_open");
  var_0 = getEnt("dorm_animnode", "targetname");
  thread _id_2A4D(var_0);
  thread _id_0B1E::_id_59BE("dorm_intro_airlock");
  level._id_5A23["dorm_intro_airlock"]._id_55B2 = 1;
  level._id_5A23["dorm_intro_airlock"]._id_560A = 1;
  thread _id_6DB8();
  thread _id_6DB9();
  var_1 = scripts\engine\utility::flag_wait_any_return("dorm_door_peeked_open", "dorm_door_kicked_open");

  if(var_1 == "dorm_door_peeked_open") {
    while(_id_0B1E::_id_794C("dorm_intro_airlock") <= 67)
      wait 0.05;
  } else {}

  thread _id_5A82();
  level notify("player_opened_dorm_airlock");
  _id_5A89();
  thread scripts\sp\utility::_id_266F();
  thread _id_5A71();
  var_0 notify("stop_idles");
  var_2 = [level._id_B33B, level._id_B33E, level._id_13E12, level._id_B4F9];

  foreach(var_4 in var_2)
  var_0 thread _id_DD0E(var_4);

  scripts\engine\utility::flag_set("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_61D3(0, 1);
  wait 1;
  thread scripts\sp\maps\rogue\rogue_util::_id_1AC5("red");
}

_id_6DB9() {
  level endon("dorm_door_kicked_open");
  level endon("door_kick_start");

  while(_id_0B1E::_id_794C("dorm_intro_airlock") <= 5)
    wait 0.05;

  scripts\engine\utility::delaythread(0.2, scripts\engine\utility::play_sound_in_space, "rogue_steam_hiss_medium_close_deep", (22706, 44681, -812));
  level.player clearclienttriggeraudiozone(2);

  while(_id_0B1E::_id_794C("dorm_intro_airlock") <= 20)
    wait 0.05;

  thread scripts\engine\utility::play_sound_in_space("emt_rogue_sparks_runner", (22864, 44816, -821));

  while(_id_0B1E::_id_794C("dorm_intro_airlock") <= 40)
    wait 0.05;

  thread scripts\engine\utility::play_sound_in_space("emt_rogue_sparks_runner", (22864, 44816, -821));

  while(_id_0B1E::_id_794C("dorm_intro_airlock") <= 60)
    wait 0.05;

  level._id_5A23["dorm_intro_airlock"]._id_55F5 = 1;
  thread _id_0B1E::_id_59C9("dorm_intro_airlock");
  scripts\engine\utility::flag_set("dorm_door_peeked_open");
}

_id_6DB8() {
  level endon("dorm_door_peeked_open");
  level waittill("door_kick_finished");
  scripts\engine\utility::flag_set("dorm_door_kicked_open");
}

_id_6663() {
  for(var_0 = 0; var_0 < 50; var_0++) {
    if(scripts\engine\utility::cointoss())
      playFX(level._effect["vfx_rogue_shiphall_spark_a"], (23205, 44915, -597));
    else
      playFX(level._effect["vfx_rogue_shiphall_spark_a"], (23205, 44915, -597));

    wait(randomfloatrange(0.1, 0.3));
  }
}

_id_1ABC() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = (22745, 44840, -823);
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.origin = (22864, 44816, -821);
  playFXOnTag(level._effect["vfx_ra_int_sparks_explosive_01"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_sparks_explosive_01"], var_1, "tag_origin");

  for(var_2 = 0; var_2 < 5; var_2++) {
    if(scripts\engine\utility::cointoss()) {
      playFX(level._effect["vfx_rogue_spark_wall_direction_a"], var_0.origin + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5)));
      thread scripts\engine\utility::play_sound_in_space("emt_rogue_sparks_runner", (22864, 44816, -821));
    } else {
      playFX(level._effect["vfx_rogue_spark_wall_direction_a"], var_1.origin + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5)));
      thread scripts\engine\utility::play_sound_in_space("retract_shield_spark", (22864, 44816, -821));
    }

    wait(randomfloatrange(0.05, 0.2));
  }

  stopFXOnTag(level._effect["vfx_ra_int_sparks_explosive_01"], var_0, "tag_origin");
  stopFXOnTag(level._effect["vfx_ra_int_sparks_explosive_01"], var_1, "tag_origin");

  for(var_2 = 0; var_2 < 20; var_2++) {
    if(scripts\engine\utility::cointoss()) {
      playFX(level._effect["vfx_rogue_spark_wall_direction_a"], var_0.origin + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5)));
      thread scripts\engine\utility::play_sound_in_space("emt_rogue_sparks_runner", (22864, 44816, -821));
    } else {
      playFX(level._effect["vfx_rogue_spark_wall_direction_a"], var_1.origin + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5)));
      thread scripts\engine\utility::play_sound_in_space("retract_shield_spark", (22864, 44816, -821));
    }

    wait(randomfloatrange(0.2, 2.2));
  }

  var_0 delete();
  var_1 delete();
}

_id_5A71() {
  wait 7.5;
  level._id_B33E scripts\sp\utility::_id_10346("asteroid_ksh_everybodyhearth");
}

_id_A60A(var_0) {
  wait 0.5;
  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(20, 15, 0);
  scripts\engine\utility::flag_clear("force_flashlights_off");
}

_id_DD0E(var_0) {
  var_0 endon("stop_intros");
  scripts\sp\anim::_id_1F35(var_0, "dorm_airlock_exit");
  scripts\sp\anim::_id_1F17(var_0, "dorm_main_room_intro");
  scripts\sp\anim::_id_1F35(var_0, "dorm_main_room_intro");

  if(var_0 != level._id_B4F9)
    scripts\sp\anim::_id_1EE0(var_0, "dorm_main_room_intro");
  else {
    if(!scripts\engine\utility::flag("kickoff_dorm_intro_anims")) {
      scripts\sp\anim::_id_1EE0(var_0, "dorm_main_room_intro");
      scripts\engine\utility::flag_wait("kickoff_dorm_intro_anims");
    }

    scripts\engine\utility::flag_set("start_dorm_entrances");
  }
}

_id_B22A() {
  var_0 = getEnt("dorm_animnode", "targetname");

  foreach(var_2 in level._id_10AC8) {
    var_2 notify("stop_intros");
    var_2 _meth_83A1();
    var_2 scripts\sp\utility::_id_51E1("cqb");
  }
}

_id_F9E4() {
  level._id_13E12._id_5A80 = 0;
  level._id_B33B._id_5A80 = 0;
  level._id_B33E._id_5A80 = 0;
  level._id_B4F9._id_5A80 = 0;
}

_id_5A74() {
  var_0 = getEnt("dorm_animnode", "targetname");
  level._id_13E12 thread _id_13E15(var_0);
  level._id_B33B thread _id_B33C(var_0);
  level._id_B33E thread _id_B33F(var_0);
  level._id_B4F9 thread _id_B4FE(var_0);
  level._id_B33E thread _id_21EA(var_0);
}

_id_D034() {
  level endon("player_sees_bodies");
  level endon("player_leaving_dorms");

  for(;;) {
    scripts\engine\utility::flag_wait("power_off");
    level.player scripts\sp\utility::_id_F526("normal");
    wait 1;
    scripts\engine\utility::flag_wait("power_on");
    wait 5;
    level.player scripts\sp\utility::_id_F526("relaxed");
  }
}

_id_13E15(var_0) {
  var_0 endon("dorm_is_over");
  var_0 endon("bail_on_quarters");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_main_room_scene");
  var_0 scripts\sp\anim::_id_1F17(self, "dorm_explore_entrance");
  scripts\sp\utility::_id_51E1("combat");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_explore_entrance");
  level.player notify("main_scene_done");
  thread _id_D034();
  thread _id_2FB7(var_0);
  scripts\sp\anim::_id_1EEA(self, "dorm_explore_flip_idle", "flip_idle_stop");
  scripts\sp\anim::_id_1F35(self, "dorm_explore_idle_trans");
  thread scripts\sp\interaction::_id_CD4B("rogue_quarters_react_01");
  self waittill("interaction_done");
  level._id_13E12 thread _id_CDFF(var_0, "quarters_complete", "player_in_quarters", "dorm_explore_node_salt", "bail_on_quarters");
  var_0 notify("flip_idle_stop");
  level._id_13E12 notify("flip_idle_stop");
  scripts\engine\utility::flag_set("player_visited_quarters");
  level.player notify("reset_nag");
  var_0 thread _id_D1CB();
  scripts\engine\utility::flag_set("flag_dorm_scene_active");
  scripts\sp\anim::_id_1F35(self, "dorm_explore_scene_a");
  scripts\engine\utility::flag_clear("flag_dorm_scene_active");
  self._id_1C4D = 1;
  thread scripts\sp\interaction::_id_CD4B("rogue_quarters_react_02");
  scripts\sp\interaction_manager::_id_12753();
  self waittill("interaction_done");
  level._id_5A67++;
  scripts\engine\utility::flag_set("flag_dorm_scene_active");
  scripts\sp\anim::_id_1F35(self, "dorm_explore_scene_b");
  scripts\engine\utility::flag_clear("flag_dorm_scene_active");
  scripts\engine\utility::flag_set("flag_dorm_scene_active");
  scripts\sp\anim::_id_1F35(self, "dorm_explore_scene_c");
  var_0 notify("quarters_complete");
  scripts\engine\utility::flag_clear("flag_dorm_scene_active");
  thread _id_1CDF("dorm_explore_node_salt");
  scripts\engine\utility::flag_set("dorm_explore_xo_done");
  level notify("dorm_scene_done");
}

_id_2FB7(var_0) {
  var_0 endon("dorm_is_over");
  var_1 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), level._id_13E12.origin);

  while(!scripts\engine\utility::flag("player_in_quarters") || var_1 <= 0.2) {
    var_1 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), level._id_13E12.origin);
    wait 0.1;
  }

  wait 0.5;
  self notify("flip_idle_stop");
}

_id_13E16(var_0) {
  var_0 endon("dorm_is_over");
  level._id_13E12 endon("stop_scene_cuz_player_left");
  self endon("time_for_scene");
  var_1 = 1;
  var_2 = 1;
  self._id_9CC0 = 0;
  thread _id_2FB4(var_0);

  while(!scripts\engine\utility::flag("bail_on_shuffle")) {
    self notify("flip_idle_stop");
    scripts\sp\anim::_id_1EEA(self, "dorm_explore_flip_idle", "flip_idle_stop");

    while(!scripts\engine\utility::flag("bail_on_shuffle")) {
      var_3 = randomfloatrange(7, 15);
      level scripts\engine\utility::waittill_any_timeout(var_3, "bail_on_shuffle");

      if(!scripts\engine\utility::flag("player_in_quarters")) {
        break;
      } else {}
    }

    if(var_2) {
      var_2 = 0;
      self._id_9CC0 = 1;
      scripts\sp\anim::_id_1F35(self, "dorm_explore_move");
      self._id_10124 = 1;
      self._id_9CC0 = 0;
      continue;
    }

    self._id_9CC0 = 1;
    scripts\sp\anim::_id_1F35(self, "dorm_explore_return");
    self._id_10124 = undefined;
    self._id_9CC0 = 0;
    var_2 = 1;
  }
}

_id_B33C(var_0) {
  var_0 endon("dorm_is_over");
  var_0 endon("bail_on_media");
  scripts\engine\utility::flag_waitopen("flag_dorm_scene_active");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_main_room_scene");
  thread _id_1100B(var_0);
  var_0 scripts\sp\anim::_id_1EEA(self, "rogue_dorm_mr1_idle", "ipd_idle_stop");
  thread scripts\sp\interaction::_id_CD4F("rogue_ipd_01_react");
  self waittill("interaction_done");
  level._id_B33B thread _id_CDFF(var_0, "media_complete", "dorm_player_in_scene", undefined, "bail_on_media", "rogue_dorm_mr1_idle", undefined, "asteroid_plr_keepsearching");
  scripts\engine\utility::flag_set("player_visited_media");
  level.player notify("reset_nag");
  var_0 thread _id_D1CB();
  scripts\engine\utility::flag_set("flag_dorm_scene_active");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_main_room_mr1_scene2");
  scripts\engine\utility::flag_clear("flag_dorm_scene_active");
  self._id_1C4D = 1;
  thread scripts\sp\interaction::_id_CD4B("rogue_ipd_02_react");
  self waittill("interaction_done");
  level._id_5A67++;
  scripts\engine\utility::flag_set("flag_dorm_scene_active");
  var_0 notify("media_complete");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_main_room_mr1_scene3");
  scripts\engine\utility::flag_clear("flag_dorm_scene_active");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "rogue_dorm_mr1_idle", "dorm_is_over");
  scripts\engine\utility::flag_set("dorm_explore_marine1_done");
  level notify("dorm_scene_done");
}

_id_1100B(var_0) {
  var_0 endon("dorm_is_over");
  var_0 endon("bail_on_media");
  wait 1;

  for(var_1 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), self.origin); var_1 <= 0.2 || !scripts\engine\utility::flag("dorm_player_in_scene"); var_1 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), self.origin))
    wait 0.2;

  var_0 notify("ipd_idle_stop");
}

_id_1629(var_0) {
  level endon("dorm_is_over");

  for(;;) {
    level waittill("playing_interaction");
    scripts\engine\utility::flag_set("flag_dorm_scene_active");
    level waittill("interaction_done");
    scripts\engine\utility::flag_clear("flag_dorm_scene_active");
  }
}

_id_2A4D(var_0) {
  var_1 = scripts\sp\utility::_id_10639("beer");
  var_0 scripts\sp\anim::_id_1EC3(var_1, "scene");
  level._id_B33E waittill("beer_scene");
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "scene");
  var_0 scripts\engine\utility::waittill_either("bail_on_kitchen", "kitchen_complete");
  var_0 scripts\sp\anim::_id_1EE0(var_1, "scene");
}

_id_B33F(var_0) {
  var_0 endon("armory_opened");
  var_0 endon("dorm_is_over");
  var_0 endon("bail_on_kitchen");
  scripts\sp\utility::_id_51E1("cqb");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_main_room_scene");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_explore_entrance");
  thread _id_D349(var_0, "mco_at_position");
  var_0 scripts\sp\anim::_id_1EEA(self, "dorm_explore_idle", "mco_at_position");
  scripts\engine\utility::flag_set("player_visited_kitchen");
  level.player notify("reset_nag");
  var_0 thread _id_D1CB();
  level._id_B33E thread _id_842A();
  level._id_B33E thread _id_CDFF(var_0, "kitchen_complete", "dorm_player_in_kitchen", "dorm_explore_node_kash", "bail_on_kitchen");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_explore_check");
  level._id_B33E notify("beer_scene");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_explore");
  var_0 notify("kitchen_complete");
  thread _id_1CDF("dorm_explore_node_kash");
  scripts\engine\utility::flag_set("dorm_explore_kitchen_done");
  level notify("dorm_scene_done");
}

_id_842A() {
  scripts\sp\utility::_id_51E1("casual_gun");
  var_0 = scripts\engine\utility::getStruct("dorm_explore_node_kash_0", "targetname");
  self setgoalpos(var_0.origin);
}

_id_B4FE(var_0) {
  level._id_B4F9 thread _id_B4FC(var_0);
  var_0 endon("armory_opened");
  var_0 endon("dorm_is_over");
  var_0 endon("bail_on_kitchen");
  scripts\sp\utility::_id_51E1("cqb");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_main_room_scene");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_explore_entrance");
  scripts\engine\utility::flag_set("mco_ready_for_kichen_scene");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "dorm_explore_idle_stand", "kitchen_pcap_go");
  level waittill("start_mco_kitchen");
  var_0 notify("kitchen_pcap_go");
  level._id_B4F9 thread _id_CDFF(var_0, "kitchen_complete", "dorm_player_in_kitchen", undefined, "bail_on_kitchen", "dorm_explore_idle_crouch");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_explore");
  level._id_5A67++;

  if(scripts\sp\utility::_id_65DF("mco_crouched") == 0) {
    scripts\sp\utility::_id_65E0("mco_crouched");
    scripts\sp\utility::_id_65E1("mco_crouched");
    var_0 thread scripts\sp\anim::_id_1EEA(self, "dorm_explore_idle_crouch", "stop_dorm_anims");
  }
}

_id_B4FC(var_0) {
  var_0 endon("dorm_is_over");
  scripts\engine\utility::flag_wait("player_visited_kitchen");
  level waittill("dorm_scene_bailed");

  for(;;) {
    if(distance2d(level.player.origin, level._id_B4F9.origin) > 350) {
      var_1 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, level._id_B4F9.origin);

      if(var_1 < 0.3) {
        break;
      }
    }

    wait 0.05;
  }

  var_0 notify("kitchen_pcap_go");

  if(scripts\sp\utility::_id_65DF("mco_crouched") == 0) {
    scripts\sp\utility::_id_65E0("mco_crouched");
    scripts\sp\utility::_id_65E1("mco_crouched");
    var_0 thread scripts\sp\anim::_id_1EEA(self, "dorm_explore_idle_crouch", "stop_dorm_anims");
  }
}

_id_21EA(var_0) {
  var_0 endon("dorm_is_over");
  var_0 endon("bail_on_armory");
  var_1 = getEnt("armory_box", "targetname");
  var_1._id_1FBB = "armory_box";
  var_1 hide();
  var_1 scripts\sp\anim::_id_F64A();
  var_0 scripts\sp\anim::_id_1EC3(var_1, "armory_enter");
  level.player waittill("opening_armory_locker");
  thread _id_2231();

  if(isDefined(self._id_69D9)) {
    self._id_69D9 notify("stop_explore_idle");
    scripts\sp\utility::anim_stopanimScripted();
    thread scripts\sp\anim::_id_1F12(self);
  }

  self notify("stop_individual_explore");
  var_0 notify("armory_opened");
  scripts\engine\utility::flag_set("armory_opened");
  var_0 notify("mco_at_position");
  level.player notify("reset_nag");
  var_0 thread _id_D1CB();
  scripts\sp\utility::anim_stopanimScripted();
  thread scripts\sp\maps\rogue\rogue_util::flag_waitopen_any("dorm_player_in_armory", scripts\engine\utility::flag_set, "player_visited_armory");
  thread scripts\sp\maps\rogue\rogue_util::flag_waitopen_any("dorm_player_in_armory", ::_id_225C, var_0);
  var_1 show();
  thread _id_21BF(var_1, var_0);
  level._id_B33E scripts\sp\utility::_id_DC45("raise");
  level._id_B33E thread _id_CDFF(var_0, "armory_complete", "dorm_player_in_armory", "dorm_explore_node_kash", "bail_on_armory", undefined, "stop_armory_idle");
  var_0 scripts\sp\anim::_id_1F2C([self, var_1], "armory_enter");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "armory_idle", "stop_armory_idle");

  if(isDefined(var_1)) {
    var_2 = scripts\engine\utility::spawn_tag_origin();
    var_3 = [var_1 gettagorigin("j_gun"), var_1 gettagorigin("tag_flash")];
    var_2.origin = averagepoint(var_3) + (0, 0, 4);
    var_1._id_A014 = var_2;
    var_2 _id_0E46::_id_48C4(undefined, undefined, undefined, 90, undefined, 40, 1, 0, 0, &"hud_interaction_prompt_center_steel_dragon");
    var_2 _id_0E46::_id_9016();
  } else
    var_0 notify("bail_on_armory");

  level._id_B33E scripts\sp\utility::_id_BE49();
  _id_0E25::_id_DFBE();
  _id_0E21::_id_DFBA();
  thread scripts\sp\maps\rogue\rogue_util::_id_117FF(300);
  var_1 delete();
  var_4 = scripts\sp\utility::_id_10639("player_rig");
  var_4 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_4, "armory_exit");
  scripts\sp\maps\rogue\rogue_util::_id_DB2E(var_4, 0.5, 20, 20, 20, 20);
  level.player giveweapon("iw7_steeldragon");
  var_5 = [var_4, self];
  var_0 notify("armory_complete");
  level._id_5A67++;
  level notify("dorm_scene_done");
  var_0 notify("stop_armory_idle");
  var_0 scripts\sp\anim::_id_1F2C(var_5, "armory_exit");
  level.player switchtoweaponimmediate("iw7_steeldragon");
  level.player disableweaponswitch();
  scripts\sp\maps\rogue\rogue_util::_id_DAE1(var_4, 2);
  thread armory_delay_weapon_switch();
  level._id_B33E scripts\sp\utility::_id_BE4A();
  level notify("player_used_sd_prompt");
  thread _id_1CDF("dorm_explore_node_kash");
}

armory_delay_weapon_switch() {
  wait 2.5;
  level.player enableweaponswitch();
}

_id_2231() {
  thread _id_3D8C();

  if(!scripts\engine\utility::flag("power_on"))
    wait 2;

  level._id_B33E scripts\sp\maps\rogue\rogue_util::_id_12958();
  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(12, 12, 1, "stop_fake_armory_power");
  level scripts\engine\utility::waittill_any("dorm_is_over", "player_left_the_armory", "player_used_sd_prompt");
  wait 2;
  level notify("stop_fake_armory_power");
  level._id_B33E scripts\sp\maps\rogue\rogue_util::_id_12984();
}

_id_3D8C() {
  level endon("dorm_is_over");
  scripts\engine\utility::flag_waitopen("dorm_player_in_armory");
  level notify("player_left_the_armory");
}

_id_11310(var_0) {
  var_1 = getEnt("rogue_armory_sd", "targetname");
  wait 2;
  var_1 itemweaponsetammo(42, 150);
  var_1 scripts\sp\utility::_id_65E0("armory_dragon_got");
  thread _id_13609(var_1, var_0);
}

_id_225C(var_0) {
  if(!scripts\engine\utility::flag("player_visited_kitchen")) {
    var_0 notify("kitchen_pcap_go");
    var_0 notify("bail_on_kitchen");
    level._id_B4F9 thread _id_B4FB(var_0);
    scripts\engine\utility::flag_set("player_visited_kitchen");
  }
}

_id_21BF(var_0, var_1) {
  level endon("player_used_sd_prompt");
  scripts\engine\utility::flag_waitopen("dorm_player_in_armory");
  var_2 = getEnt("rogue_armory_sd", "targetname");

  if(isDefined(var_2) && var_2 scripts\sp\utility::_id_65DF("armory_dragon_got") == 0) {
    var_1 scripts\sp\anim::_id_1EE0(var_0, "armory_enter");
    thread _id_13609(var_2, var_0);
  }
}

_id_13609(var_0, var_1) {
  if(!isDefined(var_1._id_A014)) {
    var_2 = scripts\engine\utility::spawn_tag_origin();
    var_3 = [var_1 gettagorigin("j_gun"), var_1 gettagorigin("tag_flash")];
    var_2.origin = averagepoint(var_3) + (0, 0, 4);
    var_1._id_A014 = var_2;
  }

  var_1._id_A014 _id_0E46::_id_48C4(undefined, undefined, undefined, 90, undefined, 1, 1, 0, 0, &"hud_interaction_prompt_center_steel_dragon");
  var_0 itemweaponsetammo(42, 150);
  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;
  var_1 hide();

  while(!scripts\engine\utility::flag("player_grabbed_knife")) {
    if(issubstr(level.player getcurrentweapon(), "steeldragon")) {
      break;
    }

    wait 0.25;
  }

  if(isDefined(var_1._id_A014)) {
    var_1._id_A014 delete();
    var_1 delete();
  }
}

_id_21C1(var_0) {
  level notify("stop_armory_box_bail");
  var_0 scripts\sp\utility::anim_stopanimScripted();
}

_id_2FB4(var_0) {
  var_0 endon("dorm_is_over");

  for(;;) {
    if(distance2d(level.player.origin, self.origin) <= 200) {
      scripts\engine\utility::flag_set("bail_on_shuffle");
      level notify("bail_on_shuffle");

      while(self._id_9CC0)
        wait 0.1;

      self notify("time_for_scene");
      break;
    }

    wait 0.1;
  }
}

_id_B4FB(var_0) {
  var_0 endon("dorm_is_over");
  var_0 endon("bail_on_kitchen");
  var_0 notify("kitchen_pcap_go");
  thread _id_D348(var_0, "kitchen_pcap_go");
  var_0 scripts\sp\anim::_id_1EEA(self, "dorm_explore_idle_stand", "kitchen_pcap_go");
  scripts\engine\utility::flag_set("player_visited_kitchen");
  level.player notify("reset_nag");
  var_0 thread _id_D1CB();
  level._id_B4F9 thread _id_CDFF(var_0, "kitchen_complete", "dorm_player_in_kitchen", undefined, "bail_on_kitchen", "dorm_explore_idle_crouch");
  var_0 scripts\sp\anim::_id_1F35(self, "dorm_explore_alt");
  var_0 notify("kitchen_complete");
  level._id_5A67++;

  if(scripts\sp\utility::_id_65DF("mco_crouched") == 0) {
    scripts\sp\utility::_id_65E0("mco_crouched");
    scripts\sp\utility::_id_65E1("mco_crouched");
    var_0 thread scripts\sp\anim::_id_1EEA(self, "dorm_explore_idle_crouch", "stop_dorm_anims");
  }
}

_id_1CDF(var_0) {
  level endon("dorm_is_over");
  self endon("stop_individual_explore");
  var_1 = 0;
  var_2 = scripts\engine\utility::getStruct(var_0 + "_" + var_1, "targetname");
  self._id_69D9 = var_2;
  thread _id_E1CF();
  scripts\sp\utility::_id_51E1("casual_gun");

  if(scripts\engine\utility::cointoss())
    var_3 = "rogue_poi_idle_A";
  else
    var_3 = "rogue_poi_idle_B";

  if(self == level._id_13E12 && isDefined(self._id_10124)) {
    var_4 = scripts\engine\utility::getStruct("dorm_explore_node_xo_pitstop", "targetname");
    var_4 scripts\sp\anim::_id_1F17(self, var_3);
    thread _id_138D7();
    var_4 thread scripts\sp\anim::_id_1EEA(self, var_3, "stop_explore_idle");
    wait(randomfloatrange(5, 9));
    var_4 notify("stop_explore_idle");
  }

  while(!scripts\engine\utility::flag("dorm_exploration_finished")) {
    var_2 scripts\sp\anim::_id_1F0D(self, var_3);
    thread _id_138D7();
    var_2 thread scripts\sp\anim::_id_1EEA(self, var_3, "stop_explore_idle");
    wait(randomfloatrange(5, 9));
    var_2 notify("stop_explore_idle");
    var_1++;
    var_2 = scripts\engine\utility::getStruct(var_0 + "_" + var_1, "targetname");

    if(!isDefined(var_2)) {
      self._id_69D9 notify("stop_explore_idle");
      break;
    }

    self._id_69D9 = var_2;
  }
}

_id_138D7() {
  wait 1;
  self.a.movement = "stop";
}

_id_E1CF() {
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "dorm_exploration_finished");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "stop_individual_explore");
  scripts\sp\utility::_id_57D6();
}

_id_D349(var_0, var_1) {
  var_0 endon("dorm_is_over");
  var_2 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), self.origin);
  scripts\engine\utility::waitframe();

  while(var_2 <= 0.7 || !scripts\engine\utility::flag("dorm_player_in_kitchen")) {
    wait 0.05;
    var_2 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), self.origin);
  }

  var_0 notify(var_1);
}

_id_D348(var_0, var_1) {
  var_0 endon("dorm_is_over");

  for(var_2 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), self.origin); var_2 <= 0.7 || !scripts\engine\utility::flag("dorm_player_in_kitchen"); var_2 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), self.origin))
    wait 0.05;

  var_0 notify(var_1);
}

_id_D1C9() {
  var_0 = getEnt("dorm_animnode", "targetname");
  scripts\engine\utility::flag_set("dorm_exploration_finished");
  var_0 notify("bail_on_kitchen");
  var_0 notify("bail_on_media");
  var_0 notify("stop_dorm_done_idle");
  var_0 notify("dorm_is_over");
  var_0 notify("ipd_idle_stop");
  level notify("dorm_is_over");
  var_0 notify("kitchen_pcap_go");
  var_0 notify("stop_explore_idle");
  var_0 notify("stop_dorm_anims");
  var_0 notify("mco_at_position");
  var_0 notify("stop_armory_idle");
  level._id_13E12 notify("flip_idle_stop");
  level notify("corpse_airlock_opened");
  level._id_B33B notify("stop_reaction");
  level._id_B33B._id_1FBB = "marine1";
  level._id_13E12 notify("stop_individual_explore");
  level._id_B33E notify("stop_individual_explore");

  foreach(var_2 in level._id_10AC8) {
    if(isDefined(var_2._id_69D9))
      var_2._id_69D9 notify("stop_explore_idle");

    var_2 scripts\sp\utility::anim_stopanimScripted();
  }

  scripts\sp\pip_util::_id_CBA3();
  var_4 = [level._id_13E12, level._id_B33B, level._id_B33E];

  foreach(var_2 in var_4) {
    if(isDefined(var_2._id_1580))
      var_2._id_1580 delete();

    if(isDefined(var_2._id_CBB1))
      var_2._id_CBB1 delete();
  }
}

_id_CDFF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("dorm_is_over");
  var_0 endon(var_1);
  scripts\engine\utility::flag_waitopen(var_2);
  var_0 notify(var_4);
  self notify("stop_reaction");
  self notify("stop_scene_cuz_player_left");

  if(isDefined(var_6))
    var_0 notify(var_6);

  level notify("dorm_scene_bailed");

  if(isDefined(var_5) && var_5 == "dorm_explore_idle_crouch") {
    if(scripts\sp\utility::_id_65DF("mco_crouched") == 0) {
      scripts\sp\utility::_id_65E0("mco_crouched");
      scripts\sp\utility::_id_65E1("mco_crouched");
      var_0 thread scripts\sp\anim::_id_1EEA(self, var_5, "stop_explore_idle");
    }
  } else if(isDefined(var_5))
    var_0 thread scripts\sp\anim::_id_1EEA(self, var_5, "stop_explore_idle");
  else {
    scripts\sp\utility::anim_stopanimScripted();
    thread _id_1CDF(var_3);
  }

  if(isDefined(var_7)) {
    scripts\engine\utility::flag_waitopen("flag_dorm_scene_active");
    wait 1;
    level.player scripts\sp\utility::_id_1034D(var_7);
  }
}

_id_5A8E(var_0) {
  level endon("corpse_airlock_opened");
  level endon("dorm_explore_finished");
  level notify("dorm_timeout");
  waittillframeend;
  level endon("dorm_timeout");
  var_1 = 60;

  if(isDefined(var_0))
    var_1 = var_0;

  scripts\engine\utility::flag_wait_either("player_leaving_dorms", "all_dorm_scenes_complete");

  if(scripts\engine\utility::flag("all_dorm_scenes_complete")) {
    for(;;) {
      if(!level.player scripts\sp\utility::_id_D1DF(level._id_B4F9.origin + (0, 0, 32), 0.5) && !level.player scripts\sp\utility::_id_D1DF(level._id_B33B.origin + (0, 0, 32), 0.5) && !level.player scripts\sp\utility::_id_D1DF(level._id_B33E.origin + (0, 0, 32), 0.5) && !level.player scripts\sp\utility::_id_D1DF(level._id_13E12.origin + (0, 0, 32), 0.5)) {
        wait 2;

        if(!level.player scripts\sp\utility::_id_D1DF(level._id_B4F9.origin + (0, 0, 32), 0.5) && !level.player scripts\sp\utility::_id_D1DF(level._id_B33B.origin + (0, 0, 32), 0.5) && !level.player scripts\sp\utility::_id_D1DF(level._id_B33E.origin + (0, 0, 32), 0.5) && !level.player scripts\sp\utility::_id_D1DF(level._id_13E12.origin + (0, 0, 32), 0.5)) {
          break;
        }
      }

      scripts\engine\utility::waitframe();
    }
  }

  _id_1C14();
}

_id_1C14() {
  level endon("dorm_explore_finished");

  if(!scripts\engine\utility::flag("timeout_occured_in_dorms"))
    scripts\engine\utility::flag_set("timeout_occured_in_dorms");
  else
    return;

  level.player notify("reset_nag");
  _id_1C15();
  var_0 = getEnt("dorm_animnode", "targetname");

  if(!scripts\engine\utility::flag("player_leaving_dorms"))
    thread _id_B500();

  foreach(var_2 in level._id_10AC8) {
    var_2 scripts\sp\utility::_id_51E1("cqb");
    var_2 thread _id_694F(var_0);
  }
}

_id_B500() {
  level endon("dorm_explore_finished");
  level._id_B4F9 scripts\sp\utility::_id_10350("rogue_omr_placeisaghostto");
}

_id_694F(var_0) {
  level endon("dorm_explore_finished");

  if(self == level._id_B4F9) {
    var_0 scripts\sp\anim::_id_1F0D(self, "dorm_main_exit_enter");
    thread _id_BE39();

    if(!scripts\engine\utility::flag("player_sees_bodies"))
      thread _id_6984();
    else
      thread _id_6986();

    var_0 scripts\sp\anim::_id_1F35(self, "dorm_main_exit_enter");
    var_0 scripts\sp\anim::_id_1EEA(self, "dorm_done_idle", "stop_dorm_done_idle");
  } else
    self _meth_82EE(getnode("corpse_airlock_start" + self._id_111B7, "targetname"));
}

_id_6984() {
  if(isDefined(level._id_466E)) {
    level._id_466E _meth_84A4(1400);
    level._id_466E _meth_84A9("show");
  }
}

_id_BE39() {
  level endon("dorm_explore_finished");
  var_0 = 0;

  while(!scripts\engine\utility::flag("dorm_explore_finished")) {
    wait(randomfloatrange(10, 15));

    if(scripts\engine\utility::flag("dorm_explore_finished")) {
      break;
    }

    if(var_0) {
      var_0 = 0;
      level._id_B4F9 scripts\sp\utility::_id_10346("asteroid_usf_Letskeepmoving");
    } else {
      var_0 = 1;
      level._id_B4F9 scripts\sp\utility::_id_10346("asteroid_usf_LeadthewayCaptain");
    }

    level notify("MCO_NAGGED");
  }
}

_id_6986() {
  level endon("dorm_explore_finished");
  level waittill("MCO_NAGGED");
  thread _id_6984();
}

_id_1C15() {
  level notify("dorms_timed_out");
  var_0 = getEnt("dorm_animnode", "targetname");
  var_0 notify("dorm_is_over");
  var_0 notify("ipd_idle_stop");
  var_0 notify("bail_on_kitchen");
  var_0 notify("stop_dorm_done_idle");
  var_0 notify("kitchen_pcap_go");
  var_0 notify("stop_dorm_anims");
  var_0 notify("mco_at_position");
  var_0 notify("stop_armory_idle");
  var_0 notify("stop_explore_idle");
  var_0 notify("bail_on_quarters");
  level._id_13E12 notify("flip_idle_stop");
  level._id_B33B notify("stop_reaction");
  level._id_B33B._id_1FBB = "marine1";
  level._id_13E12 notify("stop_individual_explore");
  level._id_B33E notify("stop_individual_explore");

  foreach(var_2 in level._id_10AC8) {
    if(isDefined(var_2._id_69D9))
      var_2._id_69D9 notify("stop_explore_idle");

    var_2 scripts\sp\utility::anim_stopanimScripted();
    thread scripts\sp\anim::_id_1F12(var_2);
  }
}

_id_4677() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("corpse_airlock_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("corpse_airlock_start");
  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(12, 12, 0);
  _id_F946();
  thread _id_F948();
  level.player scripts\sp\utility::_id_D2D1(180, 0.5);
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12984);
  scripts\engine\utility::flag_set("sun_safe_zone");
  scripts\engine\utility::flag_set("interior_quakes");
  scripts\engine\utility::flag_set("player_is_inside");
  thread scripts\sp\maps\rogue\rogue_util::_id_1AC5("red");
  scripts\engine\utility::delaythread(1, _id_0E4B::_id_1348D, 1);

  foreach(var_1 in level._id_10AC8)
  var_1 scripts\sp\utility::_id_DC45("raise");

  thread toggle_dorm_flares();
}

_id_4675() {}

_id_4671() {
  scripts\engine\utility::flag_init("activate_knife");
  scripts\engine\utility::flag_init("allow_exit_from_dorm");
  scripts\engine\utility::flag_init("bring_allies_in");
  scripts\engine\utility::flag_init("player_grabbed_knife");
  scripts\engine\utility::flag_init("crep_hall_door_flag");
  scripts\engine\utility::flag_init("shipping_go");
  scripts\engine\utility::flag_init("creep_vo_wait_0");
  scripts\engine\utility::flag_init("creep_vo_wait_1");
  scripts\engine\utility::flag_init("creep_vo_wait_2");
  scripts\engine\utility::flag_init("creep_vo_wait_3");
  scripts\engine\utility::flag_init("creep_vo_wait_4");
  scripts\engine\utility::flag_init("creep_vo_wait_5");
}

_id_4678() {}

_id_4674() {
  level.player disableweaponpickup();
  level.player scripts\sp\utility::_id_F526("normal");

  foreach(var_1 in level._id_10AC8)
  var_1 scripts\sp\utility::_id_4145();

  scripts\engine\utility::flag_clear("force_flashlights_on");
  scripts\engine\utility::flag_set("scbt_ignore_combat");
  scripts\engine\utility::flag_set("flag_lgt_robot_start");
  scripts\engine\utility::flag_set("allow_exit_from_dorm");
  var_3 = _id_4672();
  level.player scripts\sp\utility::_id_F526("relaxed");
  _id_0B1F::_id_1374E("dormitory_exit_airlock");
  level.player scripts\sp\utility::_id_F526("normal");
}

_id_4672() {
  var_0 = getEnt("dormitory_exit_animNode", "targetname");
  var_1 = scripts\sp\maps\rogue\rogue_util::_id_F943("hall_entrance_door");
  var_2 = scripts\sp\utility::_id_10639("player_rig");
  var_3 = var_0._id_468C["guy"];
  var_4 = var_0._id_468C["robot"];
  var_5 = scripts\sp\utility::_id_10639("robot_knife");
  level._id_466E = var_1;
  var_2 hide();
  var_6 = [var_1, var_2];
  var_0 scripts\sp\anim::_id_1EC1(var_6, "corpse_hall_scene_1");
  var_6 = [var_4, var_5];
  var_0 scripts\sp\anim::_id_1EC3(var_4, "corpse_hall_scene_2");
  var_0 scripts\sp\anim::_id_1EC3(var_5, "corpse_hall_scene_2_keepknife");
  var_0 thread _id_12BAD(var_2);
  var_1 thread _id_0E46::_id_48C4("tag_ui_back", undefined, undefined, 140, 750, 28, 0);
  var_1 _id_0E46::_id_9016();
  level notify("kill_fspar_hint");
  thread _id_CFE6();
  scripts\engine\utility::flag_clear("flashlight_desired");
  scripts\engine\utility::flag_set("reached_creep");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  level.player playSound("scn_rogue_airlock_door_open");
  level notify("dorm_explore_finished");
  scripts\engine\utility::flag_set("dorm_explore_finished");
  level.player scripts\sp\maps\rogue\rogue_util::_id_DB2E(var_2, 0.3, 20, 10, 10, 10);
  _id_D1C9();
  var_6 = [var_1, var_2, level._id_B4F9, level._id_B33B, level._id_B33E, var_3];

  foreach(var_8 in var_6)
  var_0 thread _id_167C(var_8);

  var_0._id_A6FB = var_5;
  var_0._id_5978 = var_1;
  var_0 thread scripts\sp\maps\rogue\rogue_util::_id_1E94(level._id_13E12, "corpse_hall_scene_1", "corpse_hall_idle_1", undefined, "player_grabbed_knife", "stop_idles");
  setmusicstate("mx_410_airlock");
  var_0 waittill("corpse_hall_scene_1");
  thread _id_4673();
}

_id_CFE6() {
  wait 5;
  level.player scripts\sp\utility::_id_10350("asteroid_plr_Heysomeonegiveme");
}

_id_4679() {
  wait 2.8;
  thread scripts\engine\utility::play_sound_in_space("rogue_steam_hiss_medium_close_deep", (25938, 46118, -637));
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = (25938, 46118, -637);
  var_0.angles = (359, 128, 3);
  playFXOnTag(level._effect["vfx_escape_ship_steam_jet"], var_0, "tag_origin");
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.origin = (25938, 46118, -610);
  var_1.angles = (359, 128, 3);
  playFXOnTag(level._effect["vfx_escape_ship_steam_jet"], var_1, "tag_origin");
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = (25938, 46118, -580);
  var_2.angles = (359, 128, 3);
  playFX(level._effect["vfx_rogue_dryice_ground_high_dense_a"], (26014, 46078, -637));
  playFXOnTag(level._effect["vfx_escape_ship_steam_jet"], var_2, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  wait 1.0;
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  stopFXOnTag(level._effect["vfx_escape_ship_steam_jet"], var_0, "tag_origin");
  stopFXOnTag(level._effect["vfx_escape_ship_steam_jet"], var_1, "tag_origin");
  stopFXOnTag(level._effect["vfx_escape_ship_steam_jet"], var_2, "tag_origin");
  wait 0.1;
  stopFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  wait 1.0;
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  wait 10;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

_id_167C(var_0) {
  self endon("stop_corpse_airlock_idle");
  self notify("stop_idle_1");
  scripts\sp\anim::_id_1F35(var_0, "corpse_hall_scene_1");

  if(scripts\engine\utility::flag("player_grabbed_knife")) {
    return;
  }
  if(isai(var_0))
    thread scripts\sp\anim::_id_1EEA(var_0, "corpse_hall_idle_1", "stop_idles");
}

_id_4673() {
  var_0 = getEnt("dormitory_exit_animNode", "targetname");
  var_1 = var_0._id_468C["guy"];
  var_2 = var_0._id_468C["robot"];
  var_3 = var_0._id_A6FB;
  var_4 = var_0._id_5978;
  var_5 = 0;

  if(_id_0A2F::_id_DA19())
    var_5 = 1;

  var_6 = scripts\sp\utility::_id_10639("player_rig");
  var_6 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_6, "corpse_hall_scene_2_keepknife");
  thread _id_8C65(var_2, var_3);
  var_3 _id_0E46::_id_48C4("tag_origin", undefined, undefined, 140, 500, 64);
  scripts\sp\utility::_id_B979(var_3, "stand");
  thread scripts\sp\maps\rogue\rogue_util::remove_navigating_equipment();
  scripts\engine\utility::flag_set("player_grabbed_knife");
  var_0 notify("player_grabbed_knife");
  var_0 notify("stop_idles");
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_F225, "stop_idles");
  level.player scripts\sp\maps\rogue\rogue_util::_id_DB2E(var_6, 0.5, 0, 0, 0, 0);
  var_7 = [level._id_B33B, level._id_B33E, level._id_B4F9, level._id_13E12, var_4, var_2];

  foreach(var_9 in var_7)
  var_0 thread _id_167D(var_9);

  var_11 = _id_0B1E::_id_794D("creep_hall_airlock");
  thread _id_466F();
  scripts\engine\utility::delaythread(8.5, _id_0B1F::_id_1AA9, "dormitory_exit_airlock", 1, var_4, var_11, 0);
  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(12, 12, 0, "never");

  if(!var_5)
    level.player thread _id_8303();

  var_12 = "corpse_hall_scene_2_keepknife";

  if(getDvar("corpse_airlock_knifeforce") == "keep")
    var_12 = "corpse_hall_scene_2_keepknife";
  else if(var_5 || getDvar("corpse_airlock_knifeforce") == "throw")
    var_12 = "corpse_hall_scene_2_throwknife";

  var_0 scripts\sp\anim::_id_1F2C([var_6, var_3], var_12);
  scripts\sp\maps\rogue\rogue_util::_id_DAE1(var_6);
  var_3 delete();
  thread scripts\sp\maps\rogue\rogue_util::_id_1AC5("green");
}

_id_8303() {
  var_0 = "specialty_slasher";

  if(!isDefined(self.perks[var_0]))
    self.perks[var_0] = 1;
  else
    self.perks[var_0]++;

  self setperk(var_0, !isDefined(level.scriptperks[var_0]));
  scripts\sp\utility::_id_12641("weapon_iw7_knife_perk_tr");
  scripts\sp\utility::_id_82EA("iw7_knife_perk");
  level.player _meth_84C7("suitUpgradeState", "slasher", "scanned");
}

_id_8C65(var_0, var_1) {
  level waittill("play_knife_sparks");
  var_2 = var_0 gettagorigin("j_head_pv_z") + anglestoup(var_0 gettagangles("j_head_pv_z")) * 2;
  playFX(level._effect["c6_knife_head_sparks"], var_2);
}

_id_466F() {
  wait 3;
  scripts\engine\utility::play_sound_in_space("airlock_entry_door_close", (25966, 46134, -588));
}

_id_4670() {
  wait 3;
}

_id_167D(var_0) {
  self endon("stop_corpse_airlock_idle");
  self notify("stop_idle_1");
  scripts\sp\anim::_id_1F35(var_0, "corpse_hall_scene_2");

  if(isai(var_0)) {
    if(var_0 != level._id_13E12)
      thread scripts\sp\anim::_id_1EEA(var_0, "corpse_hall_idle_2", "stop_corpse_airlock_idle");
    else
      thread scripts\sp\anim::_id_1EEA(var_0, "corpse_hall_salt_ready_idle", "stop_corpse_airlock_idle");
  }
}

_id_12BAF(var_0) {
  var_0 waittill("single anim");
  scripts\sp\maps\rogue\rogue_util::_id_DAE1(var_0);
}

_id_10F5B() {
  scripts\engine\utility::flag_wait("rogue_dorm_steam_gag");
  var_0 = scripts\engine\utility::getStructArray("rogue_dorm_steam_gag_audio_node", "targetname");
  var_0 = sortbydistance(var_0, level.player.origin);
  scripts\engine\utility::exploder(var_0[0].script_noteworthy);
  playworldsound("rogue_steam_hiss_medium_close_deep", var_0[0].origin);
}

_id_4A56() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("creep_hallway_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("creep_hallway_start");
  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(12, 12, 0, "never");
  scripts\engine\utility::flag_set("sun_safe_zone");
  scripts\engine\utility::flag_set("interior_quakes");
  scripts\engine\utility::flag_set("player_is_inside");
  thread scripts\sp\maps\rogue\rogue_util::_id_1AC5("instant_green");
  scripts\engine\utility::flag_set("start_creep_vo");
}

_id_4A55() {
  scripts\engine\utility::flag_clear("in_creep_hallway");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  level.player notify("kill_flashlights");

  if(isDefined(level.player._id_AC92)) {
    killfxontag(level._effect["ra_flashlight"], level.player._id_AC92, "tag_origin");
    level.player._id_AC92 scripts\engine\utility::delaycall(1, ::delete);
  }

  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  thread _id_4A4E();
  thread _id_4A4D();

  foreach(var_1 in level._id_10AC8)
  thread scripts\sp\anim::_id_1F12(var_1);

  thread _id_0B1E::_id_59BE("creep_hall_airlock", undefined, 60, 1);
  level._id_5A23["creep_hall_airlock"]._id_C9F9 = 1;
  var_3 = scripts\engine\utility::getStruct("creep_hall_animnode", "targetname");
  var_3._id_2BAE = _id_F929();
  var_4 = getspawner("creep_hall_bot", "targetname");
  var_5 = var_4 scripts\sp\utility::_id_10619(1);
  var_5._id_1FBB = "creep_bot";
  var_5.ignoreall = 1;
  var_5.ignoreme = 1;
  var_5._id_BFF8 = 1;
  var_5 thread scripts\sp\maps\rogue\rogue_util::_id_EBDD();
  var_6 = [];
  var_6[0] = getEnt("creep_hall_box_0", "targetname");
  var_6[1] = getEnt("creep_hall_box_1", "targetname");
  var_6[2] = getEnt("creep_hall_box_2", "targetname");

  foreach(var_8 in var_6) {
    if(isDefined(var_8))
      var_8 delete();
  }

  var_10 = getEnt("model_salter_grab_bot_restraint", "targetname");
  var_10 scripts\sp\utility::_id_23B7("restraint");
  var_11 = getspawner("creep_hall_corpse", "targetname");
  var_11._id_ED1B = 1;
  var_12 = var_11 scripts\sp\utility::_id_10619(1);
  var_12._id_1FBB = "corpse";
  setglobalsoundcontext("atmosphere", "helmet", 1);
  var_3 thread scripts\sp\anim::_id_1EEA(var_12, "creep_hall_corpse_idle", "stop_corpse_idle");
  var_3 thread scripts\sp\anim::_id_1EEA(var_5, "creep_hall_idle", "stop_bot_idle");
  var_3 thread scripts\sp\anim::_id_1EEA(var_10, "creep_hall_idle", "stop_bot_idle");
  _id_0E29::_id_877F(var_5);
  thread _id_6B09();
  thread _id_4A53();
  level waittill("door_peek_start");

  while(_id_0B1E::_id_794C("creep_hall_airlock") <= 60)
    wait 0.05;

  if(!level.console)
    waitforalltransients();

  level notify("creep_hall_airlockdoor_peek_disabled");
  level.player setclienttriggeraudiozonepartialwithfade("rogue_creep_mix", 4, "mix");
  level notify("creep_hall_airlockdoor_script_disabled");
  thread _id_6A47();
  level.player disableweaponpickup();
  _id_0E4B::_id_8DEA();

  foreach(var_1 in level._id_10AC8) {
    var_1 _meth_83A1();

    if(var_1 == level._id_13E12)
      var_1 scripts\sp\utility::_id_1160F(getnode("creep_hallway_start" + var_1._id_111B7, "targetname"));
  }

  thread better_ally_pathing_in_hall();
  thread scripts\sp\utility::_id_266F();
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12984);
  var_15 = getEnt("dormitory_exit_animNode", "targetname");
  var_15 notify("stop_corpse_airlock_idle");
  var_15 delete();
  var_16 = level._id_13E12;
  var_16 scripts\sp\utility::_id_51E1("cqb");
  scripts\engine\utility::flag_clear("flashlight_desired");
  scripts\engine\utility::flag_clear("force_flashlights_off");
  scripts\engine\utility::flag_set("in_creep_hallway");
  thread scripts\sp\maps\rogue\rogue_util::_id_61D3(0, 1, "Salter", "ra_flashlight");
  var_3 _id_4A50(var_16, "creep_hall_1", "creep_hall_1_idle", 120, 1);
  scripts\engine\utility::flag_set("creep_vo_wait_0");
  thread scripts\sp\maps\rogue\rogue_util::_id_1AC5("red");
  var_3 _id_4A50(var_16, "creep_hall_2", "creep_hall_2_idle", 150);
  scripts\engine\utility::flag_set("creep_vo_wait_1");
  var_3 _id_4A50(var_16, "creep_hall_3", "creep_hall_3_idle", 160);
  scripts\engine\utility::flag_set("creep_vo_wait_2");
  var_17 = [var_16, var_5, var_10];
  var_3 notify("stop_bot_idle");
  level notify("salter_grabbed");
  scripts\engine\utility::delaythread(1, scripts\sp\maps\rogue\rogue_util::_id_9A6C, 12, 12, 1, "never");
  level._id_13E12 thread _id_EA8B(var_5);
  var_5 scripts\engine\utility::delaythread(1.75, ::_id_AB38);
  scripts\engine\utility::delaythread(1.5, ::_id_E5AB);
  var_3 scripts\sp\anim::_id_1F2C(var_17, "creep_hall_grab");
  var_17 = [var_16, var_5, var_10];
  var_3 thread _id_135BC(var_5);
  scripts\engine\utility::waitframe();

  if(!var_5 scripts\sp\utility::_id_65DB("arm_l_destroyed"))
    var_3 scripts\sp\anim::_id_1EE7(var_17, "creep_hall_grab_idle", "stop_creep_grab");

  scripts\engine\utility::flag_set("creep_vo_wait_3");
  var_17 = [var_16, var_10];
  var_5.a.nodeath = 0;
  var_5._id_10265 = undefined;
  var_5._id_4E2A = var_5 scripts\sp\utility::_id_7DC1("creep_hall_grab_escape");
  var_5.noragdoll = 1;
  var_5 _meth_81D0();
  var_3 scripts\sp\anim::_id_1F2C(var_17, "creep_hall_grab_escape");
  var_10 _meth_83A1();
  var_3 thread scripts\sp\anim::_id_1EEA(var_10, "creep_hall_grab_dead", "stop_bot_idle");
  var_3 thread _id_A5C0();
  var_3 _id_4A50(var_16, "creep_hall_4", "creep_hall_4_idle", 9999);
  thread scripts\sp\utility::_id_266F();
  scripts\engine\utility::flag_set("creep_vo_wait_4");
  var_16._id_1FBD = var_3;
  var_3 _id_4A50(var_16, "creep_hall_5", "creep_hall_5_idle", 9999, undefined, 1);
  scripts\engine\utility::flag_clear("in_creep_hallway");
  scripts\engine\utility::flag_set("flag_creep_unlock_door");

  foreach(var_1 in level._id_10AC8) {
    var_1 scripts\sp\utility::_id_61C7();
    var_1 scripts\sp\utility::_id_F3B5("g");
  }

  thread _id_A5CA(var_12);
}

better_ally_pathing_in_hall() {
  level endon("stop_hand_holding_allies");
  level._id_B33E scripts\sp\utility::_id_1160F(getnode("creep_hallway_start_xo", "targetname"));
  level._id_B33B scripts\sp\utility::_id_1160F(getnode("creep_hallway_start_marine2", "targetname"));
  level._id_B4F9 scripts\sp\utility::_id_1160F(getnode("creep_hallway_start_marine1", "targetname"));
  level._id_B33E scripts\sp\utility::_id_54F7();
  level._id_B33B scripts\sp\utility::_id_54F7();
  level._id_B4F9 scripts\sp\utility::_id_54F7();
  scripts\engine\utility::flag_wait("ch_ally_move_0");
  level._id_B33E _meth_82EE(getnode("ch_start_node_front", "targetname"));
  level._id_B33E waittill("goal");
  level._id_B33B _meth_82EE(getnode("ch_start_node_mid", "targetname"));
  level._id_B33B waittill("goal");
  level._id_B4F9 _meth_82EE(getnode("ch_start_node_rear", "targetname"));
  scripts\engine\utility::flag_wait("ch_ally_move_1");
  level._id_B33E _meth_82EE(getnode("ch_start_node_front_1", "targetname"));
  level._id_B33E waittill("goal");
  level._id_B33B _meth_82EE(getnode("ch_start_node_mid_1", "targetname"));
  level._id_B33B waittill("goal");
  level._id_B4F9 _meth_82EE(getnode("ch_start_node_rear_1", "targetname"));
  scripts\engine\utility::flag_wait("ch_ally_move_2");
  level._id_B33E _meth_8250(1);
  level._id_B4F9 _meth_8250(1);
  level._id_B33B _meth_8250(1);
  level._id_B33E _meth_82EE(getnode("ch_start_node_front_2", "targetname"));
  level._id_B33E waittill("goal");
  level._id_B33B _meth_82EE(getnode("ch_start_node_mid_2", "targetname"));
  level._id_B33B waittill("goal");
  level._id_B4F9 _meth_82EE(getnode("ch_start_node_rear_2", "targetname"));
  scripts\engine\utility::flag_wait("ch_ally_move_3");
  level._id_B33E _meth_82EE(getnode("ch_start_node_front_3", "targetname"));
  level._id_B33E waittill("goal");
  level._id_B33B _meth_82EE(getnode("ch_start_node_mid_3", "targetname"));
  level._id_B33B waittill("goal");
  level._id_B4F9 _meth_82EE(getnode("ch_start_node_rear_3", "targetname"));
}

_id_E5AB() {
  var_0 = getEnt("ch_robot_weap_clip", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  wait 0.25;

  if(isDefined(var_0)) {
    var_0 delete();
    scripts\engine\utility::exploder("moreglass");
    glassradiusdamage(var_1.origin, 50, 9999, 9999);
  }
}

_id_AAC1() {
  var_0 = getEnt("player_creep_blocker_0", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  while(isDefined(var_0)) {
    if(!scripts\engine\utility::flag("creep_vo_wait_3"))
      level._id_13E12 _id_137C3(var_0);
    else
      wait 3;

    var_1 = var_0;

    if(isDefined(var_0.target)) {
      var_0 = var_0 scripts\engine\utility::get_target_ent();
      var_1 delete();
      continue;
    }

    var_1 delete();
    break;
  }
}

_id_137C3(var_0) {
  while(level._id_13E12 istouching(var_0) == 0 && !scripts\engine\utility::flag("creep_vo_wait_3"))
    wait 0.05;
}

_id_6A47() {
  var_0 = _id_0B1E::_id_794D("creep_hall_airlock");
  scripts\sp\utility::_id_5FC7(var_0.origin);
  playworldsound("doorpeek_bulkhead_hit_wall", var_0.origin);
  level._id_5A23["creep_hall_airlock"]._id_5A03 connectpaths();
  wait 2.5;
  _id_0B1E::_id_11F9("creep_hall_airlock", var_0, 0, 1, undefined, undefined);
  level._id_5A23["creep_hall_airlock"]._id_5A03 disconnectPaths();

  foreach(var_2 in level._id_10AC8) {
    if(var_2 != level._id_13E12)
      var_2 scripts\sp\utility::_id_51E1("cqb");
  }
}

_id_4A51(var_0) {
  thread scripts\engine\utility::play_sound_in_space("rogue_c6_creep_warning_vox", var_0);
  wait(randomfloatrange(1, 5));
  thread scripts\engine\utility::play_sound_in_space("rogue_c6_creep_warning_vox", var_0);
  wait(randomfloatrange(1, 5));
  thread scripts\engine\utility::play_sound_in_space("rogue_c6_creep_warning_vox", var_0);
  wait(randomfloatrange(1, 5));
  thread scripts\engine\utility::play_sound_in_space("rogue_c6_creep_warning_vox", var_0);
  wait(randomfloatrange(1, 5));
  thread scripts\engine\utility::play_sound_in_space("rogue_c6_creep_warning_vox", var_0);
}

_id_4A4D() {
  scripts\engine\utility::flag_wait("creep_vo_wait_0");
  thread _id_4A51((26514, 45634, -586));
  wait 2.3;
  thread _id_4A51((26604, 45831, -586));
  wait 5;
  scripts\engine\utility::flag_wait("creep_vo_wait_1");
  wait 2;
  level.player playSound("pnr_capship_settle");
  wait 4;
  level.player playSound("pnr_capship_settle");
  scripts\engine\utility::flag_wait("creep_vo_wait_2");
  wait 1.0;
  thread scripts\engine\utility::play_sound_in_space("c6_0_exposed_open", level.player.origin + (300, -200, 0));
  scripts\engine\utility::flag_wait("creep_vo_wait_3");
  scripts\engine\utility::flag_wait("creep_vo_wait_4");
  wait 4;
  wait 4;
  thread _id_7650();
}

_id_7650() {
  if(scripts\engine\utility::flag("power_on"))
    thread scripts\engine\utility::play_sound_in_space("c6_hostile_burst", level.player.origin + (9000, -20, 0));
  else {
    scripts\engine\utility::flag_wait("power_on");
    wait(randomintrange(1, 3));
    thread scripts\engine\utility::play_sound_in_space("c6_hostile_burst", level.player.origin + (9000, -20, 0));
  }

  wait 2.25;

  if(scripts\engine\utility::flag("power_on"))
    thread scripts\engine\utility::play_sound_in_space("c6_0_inform_incoming_c6", level.player.origin + (20, -9000, 0));
  else {
    scripts\engine\utility::flag_wait("power_on");
    wait(randomintrange(1, 3));
    thread scripts\engine\utility::play_sound_in_space("c6_0_inform_incoming_c6", level.player.origin + (20, -9000, 0));
  }

  wait 1.25;

  if(scripts\engine\utility::flag("power_on"))
    thread scripts\engine\utility::play_sound_in_space("c6_0_resp_ack_co_gnrc_affirm", level.player.origin + (6000, -6000, 0));
  else {
    scripts\engine\utility::flag_wait("power_on");
    wait(randomintrange(1, 3));
    thread scripts\engine\utility::play_sound_in_space("c6_0_resp_ack_co_gnrc_affirm", level.player.origin + (6000, -6000, 0));
  }
}

_id_4A52(var_0, var_1, var_2) {
  while(!scripts\engine\utility::flag(var_0)) {
    playFX(level._effect["vfx_rogue_steam_leak_large"], var_1, var_2);
    wait(randomfloatrange(0.5, 1));
  }
}

_id_4A4E() {
  scripts\engine\utility::flag_wait("creep_vo_wait_2");
  wait 1.3;
  scripts\engine\utility::exploder("robotgag");
}

_id_AB38() {
  self._id_BFF8 = undefined;
}

_id_EA8B(var_0) {
  level endon("creep_vo_wait_4");
  var_1 = 1;

  for(;;) {
    level waittill("fire");
    level.player clearclienttriggeraudiozone(2);
    var_2 = self gettagorigin("tag_flash");
    var_3 = self gettagangles("tag_flash");
    var_4 = anglesToForward(var_3) * 92 + anglestoright(var_3) * randomintrange(-10, 10) + anglestoup(var_3) * randomintrange(-10, 10);

    if(isDefined(var_0) && !var_0 scripts\sp\utility::_id_65DB("head_destroyed"))
      var_4 = anglesToForward(var_3) * 92 + anglestoup(var_3) * 10;

    var_1 = 0;
    magicbullet(self.primaryweapon, var_2, var_2 + var_4);
  }
}

_id_A5CA(var_0) {
  level.doors["creep_exit_doors"] scripts\sp\utility::_id_65E3("begin_opening");
  var_0 delete();
}

_id_F929() {
  var_0 = scripts\engine\utility::getStruct("creep_hall_player_blocker_link", "targetname");
  var_1 = scripts\sp\utility::_id_10639("creep_blocker");
  var_1.clip = getEnt("creep_hall_player_blocker", "targetname");
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.clip.angles = var_1.clip.angles + (0, 90, 0);
  var_1.clip linkTo(var_1);
  return var_1;
}

_id_4A4F() {
  var_0 = getEntArray("creep_hall_light", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);

  level waittill("salter_grabbed");

  foreach(var_2 in var_0)
  var_2 setlightintensity(5);

  while(!scripts\engine\utility::flag("shipping_go")) {
    scripts\engine\utility::flag_waitopen("power_on");

    foreach(var_2 in var_0)
    var_2 setlightintensity(0);

    scripts\engine\utility::flag_wait("power_on");

    foreach(var_2 in var_0)
    var_2 setlightintensity(5);
  }

  foreach(var_2 in var_0)
  var_2 delete();
}

_id_4A50(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = 0;

  var_6 = [var_0];

  if(isDefined(self._id_2BAE))
    var_6 = [var_0, self._id_2BAE];

  if(isDefined(var_4)) {
    thread scripts\sp\anim::_id_1EEA(self._id_2BAE, var_2, "stop_creep_idle");
    scripts\sp\anim::_id_1F35(var_0, var_1);
    self notify("stop_creep_idle");
  } else
    scripts\sp\anim::_id_1F2C(var_6, var_1);

  if(var_5 || distance2d(level.player.origin, var_0.origin) > var_3) {
    foreach(var_8 in var_6)
    thread scripts\sp\anim::_id_1EEA(var_8, var_2, "stop_creep_idle");
  } else
    return;

  while(distance2d(level.player.origin, var_0.origin) > var_3)
    wait 0.1;

  if(!var_5)
    self notify("stop_creep_idle");
}

_id_A5C0() {
  self._id_2BAE.clip delete();
  self._id_2BAE delete();
}

_id_135BC(var_0) {
  self endon("stop_creep_grab");
  var_0 thread _id_3BFB(self);
  var_0 scripts\sp\utility::_id_65E6("arm_l_destroyed", 3);
  self notify("stop_creep_grab");
}

_id_3BFB(var_0) {
  var_0 endon("stop_creep_grab");
  var_1 = 0;

  for(var_2 = 200; var_1 < var_2; var_1 = var_1 + var_3)
    self waittill("damage", var_3);

  scripts\sp\utility::_id_65E1("arm_l_destroyed");
}

_id_4A53() {
  while(_id_0B1E::_id_794C("creep_hall_airlock") <= 42)
    wait 0.05;

  scripts\engine\utility::flag_wait("start_creep_vo");
  level.player scripts\sp\utility::_id_10350("asteroid_plr_werelookingfors");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_onmereyes");
  level.player scripts\sp\utility::_id_10350("rogue_plr_rightbehindyouf");
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_onyoursix");
  scripts\engine\utility::flag_wait("creep_vo_wait_0");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_workerdrones");
  wait 1;
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_notarmed");
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_whyaretheymovin");
  wait 2;
  level._id_B33B scripts\sp\utility::_id_10346("rogue_brk_theresbloodonth");
  scripts\engine\utility::flag_wait("creep_vo_wait_1");
  wait 3;
  level._id_13E12 playSound("rogue_slt_gotadeadcivilia");
  wait(lookupsoundlength("rogue_slt_gotadeadcivilia") / 1000);
  level._id_B33B scripts\sp\utility::_id_10346("rogue_brk_anotherone");
  scripts\engine\utility::flag_wait("creep_vo_wait_2");
  setmusicstate("mx_411_robotgrab");
  level._id_13E12 playSound("rogue_slt_lookslikehisnec");
  wait(lookupsoundlength("rogue_slt_lookslikehisnec") / 1000);
  level._id_13E12 playSound("rogue_slt_argh");
  wait(lookupsoundlength("rogue_slt_argh") / 1000);
  level.player scripts\sp\utility::_id_10350("rogue_plr_salt");
  scripts\engine\utility::flag_wait("creep_vo_wait_3");
  level._id_13E12 playSound("rogue_slt_pieceofshit");
  wait(lookupsoundlength("rogue_slt_pieceofshit") / 1000);
  wait 2;
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_youhurtlieutena");
  level.player scripts\sp\utility::_id_10350("rogue_plr_shesgoodkash");
  scripts\engine\utility::flag_wait("creep_vo_wait_4");
  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(20, 12, 0, "never");
  wait 0.75;
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_lightsout");
  level._id_B33B scripts\sp\utility::_id_10346("rogue_brk_nightcycle");
  level._id_13E12 scripts\sp\utility::_id_10346("asteroid_slt_theyretiedtothe");
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_goodcallmaam");
}

_id_6B09() {
  var_0 = getspawnerarray("creep_bot_wall_spawner");
  level._id_4A57 = scripts\sp\utility::_id_22C6(var_0, 1, 1);

  foreach(var_2 in level._id_4A57) {
    var_2 thread _id_4A58();
    _id_0E29::_id_877F(var_2);
    wait 0.2;
  }
}

_id_4A58() {
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  self._id_1FBB = "wall_bot";
  self.ignoreall = 1;
  self.ignoreme = 1;
  thread scripts\sp\maps\rogue\rogue_util::_id_EBDD();
  self _meth_83B9(var_0.origin, var_0.angles);
  var_0 thread scripts\sp\anim::_id_1EEA(self, "power_off_idle", "stop_idle");
}

_id_4A46() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("shipping_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("shipping_start");
  level._id_13E12._id_1FBD = scripts\engine\utility::getStruct("creep_hall_animnode", "targetname");
  level._id_13E12._id_1FBD thread scripts\sp\anim::_id_1EEA(level._id_13E12, "creep_hall_5_idle");
  scripts\engine\utility::flag_set("player_is_inside");
  scripts\engine\utility::flag_set("sun_safe_zone");
  scripts\engine\utility::flag_set("interior_quakes");
}

_id_4A45() {
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12984);
  var_0 = spawn("trigger_radius", level._id_13E12.origin, 0, 336, 128);
  var_0 scripts\engine\utility::waittill_any_timeout(10, "trigger");
  var_0 scripts\engine\utility::delaycall(1, ::delete);
  level notify("stop_hand_holding_allies");
  var_1 = [level._id_B4F9, level._id_B33B, level._id_B33E];

  foreach(var_3 in var_1)
  var_3 _meth_82EE(getnode("shipping_start" + var_3._id_111B7, "targetname"));

  setglobalsoundcontext("atmosphere", "helmet", 1);

  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_2683();

  _id_F928();
  _id_4A4C();
}

_id_F928() {
  level._id_4A4B = level.doors["creep_exit_doors"];
  level._id_4A4B._id_901E = (5, 27, 5);
  level._id_4A4B._id_9333 = 1;
  level._id_4A4B._id_10247 = 1;
  level._id_4A4B scripts\sp\utility::_id_65E1("crep_hall_door_flag");
  level._id_4A4B scripts\sp\utility::_id_65E1("no_anim_reach");
  level._id_4A4B _id_0B1F::_id_5982(scripts\sp\maps\rogue\rogue_anim::_id_4A47, scripts\sp\maps\rogue\rogue_anim::_id_4A49, scripts\sp\maps\rogue\rogue_anim::_id_4A48);
  level._id_4A4B _id_0B1F::_id_59EB("scn_europa_bddy_door_open_grab", "scn_europa_bddy_door_open_start", "scn_europa_bddy_door_open_lp", "scn_europa_bddy_door_shut", "scn_europa_bddy_door_open_finish");
  level._id_4A4B._id_28B6 = "tag_bash";
  level._id_4A4B._id_9027 = "tag_origin";
}

_id_4A4C() {
  var_0 = [level._id_13E12, level._id_B4F9, level._id_B33B, level._id_B33E];
  thread _id_EA45();
  level.doors["creep_exit_doors"] scripts\sp\utility::_id_65E3("player_used_door");
  level._id_13E12._id_1FBD notify("stop_creep_idle");
  level._id_13E12._id_1FBD notify("stop_loop");
  level._id_4A4B thread _id_0B1F::_id_168A(var_0);
  level.doors["creep_exit_doors"] scripts\sp\utility::_id_65E3("begin_opening");
  level.player scripts\engine\utility::delaycall(1, ::playsound, "scn_rogue_buddy_door_swt");
  level.player scripts\engine\utility::delaycall(7.5, ::playsound, "scn_rogue_buddy_door_swt_close_02");
  thread scripts\sp\maps\rogue\rogue::_id_E65E();
  thread _id_59AA();
  setmusicstate("mx_366_hallway");
  scripts\engine\utility::flag_set("creep_vo_wait_5");

  if(isDefined(level._id_4A57)) {
    foreach(var_2 in level._id_4A57) {
      if(isDefined(var_2))
        var_2 delete();
    }
  }

  foreach(var_2 in level._id_10AC8) {
    if(isDefined(var_2._id_C381))
      var_2.grenadeawareness = var_2._id_C381;
  }

  scripts\engine\utility::flag_clear("disable_alt_vision_calls");
  thread _id_4A4A();
}

#using_animtree("generic_human");

_id_EA45() {
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_letsgetthisdoor");
  level._id_13E12 setanimknob(%rogue_slt_letsgetthisdoor_face, 0, 0.1, 1);
}

_id_4A4A() {
  wait 2;
  scripts\sp\maps\rogue\rogue_util::_id_119AF(0);
  thread scripts\sp\maps\rogue\rogue_util::remove_navigating_equipment();

  foreach(var_1 in level._id_10AC8)
  var_1 _meth_8250(0);

  var_3 = getEntArray("shipping_hallway_init_robots", "targetname");
  var_4 = [];
  var_5 = scripts\sp\utility::_id_7E72();
  var_6 = 6;

  if(var_5 == "easy" || var_5 == "medium")
    var_6 = 4;

  for(var_7 = 0; var_7 < var_6; var_7++)
    var_4[var_7] = var_3[var_7] scripts\sp\utility::_id_10619(1);

  for(var_7 = 0; var_7 < var_4.size; var_7++) {
    var_4[var_7]._id_1FBB = "worker_bot";
    var_8 = "c6_reveal_" + var_7;
    var_4[var_7] thread _id_F361();
    level.doors["creep_exit_doors"] thread scripts\sp\anim::_id_1F35(var_4[var_7], var_8);
  }
}

_id_F361() {
  var_0 = scripts\sp\utility::_id_7E72();
  var_1 = undefined;

  switch (var_0) {
    case "easy":
      self._id_12B7F = 20;
      var_1 = 1;
      break;
    case "medium":
      self._id_12B7F = 40;
      var_1 = 1.1;
      break;
    case "hard":
      self._id_12B7F = 70;
      var_1 = 1.3;
      break;
    case "fu":
      self._id_12B7F = 90;
      var_1 = 1.5;
      break;
  }

  self.health = int(floor(self.health * var_1));
  self.maxhealth = int(floor(self.health * var_1));
}

_id_59AA() {
  wait 2;
  thread scripts\engine\utility::play_sound_in_space("c6_0_inform_incoming_c6", (27587, 44656, -605));
  wait 3.5;
  thread scripts\engine\utility::play_sound_in_space("c6_hostile_burst", (27556, 44552, -605));
  wait 1;
  level._id_B33B thread scripts\sp\utility::_id_10346("asteroid_brk_gotbotsinstandb");
  wait 1.5;
  thread scripts\engine\utility::play_sound_in_space("c6_0_resp_ack_co_gnrc_affirm", (27674, 44481, -605));
  wait 1.5;
  level.player scripts\sp\utility::_id_10350("asteroid_plr_powersuptheyrel");
  thread scripts\engine\utility::play_sound_in_space("c6_0_inform_incoming_c6", (27603, 44391, -605));
  wait 1;
  level._id_B4F9 thread scripts\sp\utility::_id_10346("asteroid_omr_takeemoutnowman");
  thread scripts\engine\utility::play_sound_in_space("c6_0_resp_ack_co_gnrc_affirm", (27556, 44552, -605));
  wait 1.0;
  thread scripts\engine\utility::play_sound_in_space("c6_hostile_burst", (27674, 44481, -605));
  wait 0.7;
  thread scripts\engine\utility::play_sound_in_space("c6_0_inform_incoming_c6", (27587, 44656, -605));
  wait 0.5;
  thread scripts\engine\utility::play_sound_in_space("c6_0_resp_ack_co_gnrc_affirm", (27603, 44391, -605));
  wait 1.25;
  thread scripts\engine\utility::play_sound_in_space("c6_0_resp_ack_co_gnrc_affirm", (27556, 44552, -605));
  wait 1.0;
  thread scripts\engine\utility::play_sound_in_space("c6_hostile_burst", (27587, 44656, -605));
  wait 1.7;
  thread scripts\engine\utility::play_sound_in_space("c6_0_inform_incoming_c6", (27603, 44391, -605));
}

_id_F946() {
  thread _id_5A6F();
  thread _id_1AA7();
}

_id_F948() {
  thread _id_5A7F();
  thread _id_5A81();
}

_id_5A81() {
  scripts\engine\utility::flag_wait("start_dorm_entrances");
  wait 11.5;
  var_0 = spawn("script_origin", level.player.origin);
  wait 0.5;

  if(scripts\engine\utility::flag("power_on"))
    var_0 playSound("asteroid_anc_emergencybeaconactivated_r");
  else {
    scripts\engine\utility::flag_wait("power_on");
    wait(randomintrange(2, 5));
    var_0 playSound("asteroid_anc_emergencybeaconactivated_r");
  }

  wait 25;

  if(scripts\engine\utility::flag("power_on"))
    var_0 playSound("asteroid_anc_asteroiddestabilizationdetected_r");
  else {
    scripts\engine\utility::flag_wait("power_on");
    wait(randomintrange(2, 5));
    var_0 playSound("asteroid_anc_asteroiddestabilizationdetected_r");
  }

  wait 25;

  if(scripts\engine\utility::flag("power_on"))
    var_0 playSound("asteroid_anc_lockdownmodeinitiated_r", "sound_done");
  else {
    scripts\engine\utility::flag_wait("power_on");
    wait(randomintrange(2, 5));
    var_0 playSound("asteroid_anc_lockdownmodeinitiated_r", "sound_done");
  }

  var_0 waittill("sound_done");
  wait 0.05;
  var_0 delete();
}

_id_5A7F() {
  var_0 = spawn("script_origin", (24823, 44519, -538));
  wait 0.05;
  var_0 _meth_8278(0.0, 0.05);
  var_0 _meth_8277(0.0, 0.05);
  wait 0.05;
  level waittill("player_opened_dorm_airlock");
  var_0 playLoopSound("emt_rog_dorm_music");

  while(!scripts\engine\utility::flag("player_grabbed_knife")) {
    scripts\engine\utility::flag_wait("power_on");
    var_0 _meth_8277(1, 4);
    wait 2;
    var_0 _meth_8278(1, 2);
    scripts\engine\utility::flag_waitopen("power_on");
    var_0 _meth_8277(0, 4);
    var_0 _meth_8278(0, 2);
  }

  wait 1;
  var_0 _meth_8278(0.0, 2);
  wait 2;
  var_0 stoploopsound();
  var_0 delete();
}

_id_5A6F() {
  var_0 = getEnt("dorm_animnode", "targetname");
  var_1 = [];
  var_1[0] = _id_5A6E("dorm_kitchen_corpse");
  var_1[0] setModel("parts_flightsuit_no_patches");
  var_0 scripts\sp\anim::_id_1EC1(var_1, "dorm_corpse");
  var_1[0] thread scripts\sp\maps\rogue\rogue_util::_id_4073("player_grabbed_knife");
}

_id_1AA7() {
  var_0 = getEnt("dormitory_exit_animNode", "targetname");
  var_1 = [];
  var_1[0] = _id_5A6E("dorm_exit_corpse_1");
  var_1[1] = _id_5A6E("dorm_exit_corpse_2");
  var_2 = scripts\sp\utility::_id_10639("robot_corpse");
  var_3 = _id_5A6E("dorm_exit_corpse_3");
  var_3 setModel("civ_miner_male");
  var_4 = [];
  var_4["robot"] = var_2;
  var_4["guy"] = var_3;
  var_0._id_468C = var_4;
  var_1[0] scripts\sp\anim::_id_1EC3(var_1[0], "dorm_exit_corpse");
  var_0 scripts\sp\anim::_id_1EC3(var_1[1], "dorm_exit_corpse");
  var_0 scripts\sp\anim::_id_1EC3(var_3, "corpse_hall_scene_1");
  var_4["guy"] thread scripts\sp\maps\rogue\rogue_util::_id_4073("creep_vo_wait_5");
  var_4["robot"] thread scripts\sp\maps\rogue\rogue_util::_id_4073("creep_vo_wait_5");
}

_id_5A6E(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1._id_ED1B = 1;
  var_2 = var_1 scripts\sp\utility::_id_10619(1);
  var_2._id_1FBB = var_0;
  var_2 scripts\sp\utility::_id_B14F(1);
  var_2._id_EDB8 = "";
  return var_2;
}

_id_12BAD(var_0) {
  self waittill("corpse_hall_scene_1");
  level.player scripts\sp\maps\rogue\rogue_util::_id_DAE1(var_0);
}

_id_D1CB() {
  level.player endon("reset_nag");
  level endon("player_sees_bodies");
  level endon("player_leaving_dorms");

  for(;;) {
    scripts\engine\utility::flag_wait("flag_dorm_missed_scenes");

    if(!scripts\engine\utility::flag("flag_dorm_scene_active")) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  var_0 = sortbydistance(level.allies, level.player.origin);

  foreach(var_2 in var_0) {
    if(var_2 == level._id_B33E) {
      if(level._id_B33E._id_5A80 == 0 && !scripts\engine\utility::flag("player_visited_kitchen")) {
        wait 0.5;
        level._id_B33E._id_5A80 = 1;
        return;
      }
    } else if(var_2 == level._id_B33B) {
      if(!scripts\engine\utility::flag("player_visited_media") && scripts\engine\utility::flag("player_visited_kitchen") || scripts\engine\utility::flag("player_visited_quarters") && !scripts\engine\utility::flag("player_visited_media") && level._id_B33B._id_5A80 == 0) {
        wait 0.5;
        level._id_B33B._id_5A80 = 1;
        scripts\engine\utility::flag_clear("pause_nags");
        return;
      }
    }
  }
}

_id_CBB2() {
  wait 0.5;
  level._id_13E12._id_5A80 = 1;
}

_id_D06F() {
  scripts\sp\utility::_id_127B3("player_leaving_dorm_trigger");
  scripts\engine\utility::flag_set("player_sees_bodies");
  level.player scripts\sp\utility::_id_F526("normal");
  level.player._id_EA2B = 1;
  level.player scripts\sp\utility::_id_10350("asteroid_plr_ohshit");

  if(!scripts\engine\utility::flag("all_dorm_scenes_complete"))
    _id_CBB2();
}

_id_2762(var_0, var_1) {
  if(isDefined(var_1))
    _id_0B6A::_id_EC0E(var_0);
  else if(!scripts\engine\utility::flag("dorm_explore_finished")) {
    if(self == level.player)
      scripts\sp\utility::_id_1034D(var_0);
    else
      scripts\sp\utility::_id_10346(var_0);
  }
}

achievement_watcher() {
  level._id_5A67 = 0;
  scripts\engine\utility::flag_wait("dorm_explore_finished");

  if(level._id_5A67 >= 4)
    level.player giveachievement("Dorm Fully Explored");
}

_id_5A9F() {
  wait 0.1;
  var_0 = getscriptablearray("dorm_coffee_machine", "targetname");
  var_1 = getscriptablearray("dorm_ceiling_fan", "targetname");

  while(!scripts\engine\utility::flag("dorm_explore_finished")) {
    scripts\engine\utility::flag_wait("power_on");
    var_1[0] setscriptablepartstate("onoff", "on");
    var_0[0] setscriptablepartstate("coffee_machine", "on");
    scripts\engine\utility::flag_waitopen("power_on");
    var_1[0] setscriptablepartstate("onoff", "off");
    var_0[0] setscriptablepartstate("coffee_machine", "off");
  }
}

_id_5A8F() {
  scripts\engine\utility::flag_wait("rogue_scriptables_ready");
  var_0 = getscriptablearray("dorm_tv_set", "targetname");
  var_1 = getEntArray("dorm_tv_screen", "targetname");
  scripts\engine\utility::array_call(var_1, ::hide);
  var_0[0] thread _id_12AC0();
  var_0[0] endon("death");

  while(!scripts\engine\utility::flag("dorm_explore_finished")) {
    scripts\engine\utility::flag_wait("power_on");
    scripts\engine\utility::array_call(var_1, ::show);
    scripts\engine\utility::flag_waitopen("power_on");
    scripts\sp\maps\rogue\rogue_util::_id_75D6();
    scripts\engine\utility::array_call(var_1, ::hide);
  }
}

_id_12AC0() {
  self waittill("death");
  scripts\sp\maps\rogue\rogue_util::_id_75D6();
  scripts\engine\utility::flag_wait("dorm_explore_finished");
  var_0 = getEnt("dorm_tv_screen", "targetname");
  var_0 delete();
}

_id_5A89() {
  thread _id_5F09();
  thread _id_5F08();
}

_id_5F09() {
  level endon("dorm_explore_finished");
  var_0 = scripts\engine\utility::getStructArray("rogue_toilet_pusher_a", "targetname");
  var_1 = scripts\engine\utility::getStructArray("rogue_toilet_pusher_b", "targetname");
  var_2 = 0.1;

  while(!scripts\engine\utility::flag("dorm_explore_finished")) {
    level waittill("rogue_quake", var_3);

    foreach(var_5 in var_0)
    physicsexplosionsphere(var_5.origin, 40, 8, 0.05);

    level waittill("rogue_quake", var_3);

    foreach(var_5 in var_1)
    physicsexplosionsphere(var_5.origin, 40, 8, 0.05);
  }
}

_id_5F08() {
  var_0 = scripts\engine\utility::getStructArray("rogue_locker_pusher", "targetname");

  while(!scripts\engine\utility::flag("dorm_explore_finished")) {
    level waittill("rogue_quake", var_1);
    wait 0.1;

    foreach(var_3 in var_0)
    physicsexplosionsphere(var_3.origin, 32, 30, 0.1);
  }
}

_id_5634() {
  var_0 = getEnt("airlock_door_clip", "script_noteworthy");

  if(isDefined(var_0))
    var_0 disconnectPaths();
}

_id_4527() {
  var_0 = getEnt("airlock_door_clip", "script_noteworthy");

  if(isDefined(var_0))
    var_0 connectpaths();
}

_id_5A82() {
  level.player scripts\engine\utility::allow_sprint(0);
  level.player scripts\sp\utility::_id_D2D1(120);
  scripts\engine\utility::flag_wait("kickoff_dorm_intro_anims");
  level.player scripts\engine\utility::allow_sprint(1);
  level.player scripts\sp\utility::_id_D2CA();
}

toggle_dorm_flares() {
  while(!scripts\engine\utility::flag("player_grabbed_knife")) {
    if(scripts\engine\utility::flag("power_on")) {
      scripts\engine\utility::exploder("dorm_room_lights");
      scripts\engine\utility::exploder("day_night_flares");
    } else {
      scripts\sp\utility::_id_10FEC("dorm_room_lights");
      scripts\sp\utility::_id_10FEC("day_night_flares");
    }

    level scripts\engine\utility::waittill_any("power_on", "power_off");
  }

  scripts\sp\utility::_id_10FEC("dorm_room_lights");
  scripts\sp\utility::_id_10FEC("day_night_flares");
}