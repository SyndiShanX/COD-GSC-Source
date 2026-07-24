/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_intro.gsc
*****************************************************/

_id_E94A() {
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_9A9E();
  thread _id_9ABD();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_A127();
  thread _id_891C();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_8E92(1);
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_E9C9();
  var_0 = getEnt("carrier_damage_model", "targetname");
  var_0 hide();
  thread scripts\sp\maps\sa_moon\sa_moon_hull::_id_91B6();
  thread scripts\sp\maps\sa_moon\sa_moon_hull::_id_91C3();
  thread scripts\sp\maps\sa_moon\sa_moon_hull::_id_8918();
  scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(0);
  setsaveddvar("cg_helmetLinearVelocityToAngleRate", (0, 0, 0));
  setsaveddvar("cg_helmetViewSwayRate", 0.0);
  level._id_C0B7 = 1;
  wait 0.5;
  level._id_3965 thread _id_0BB6::_id_39F0(undefined, undefined, 1, 1);
  var_1 = _id_0F0E::_id_88BE(undefined, 1, "tigris", undefined, 6, 1, "cannon_large_lock_ca,1,1,amb_turret_l_1,amb_turret_l_2,amb_turret_m_1,amb_turret_m_2,amb_turret_r_1,amb_turret_r_2", 1);
  level._id_118A8 = var_1;
  level notify("tigris_spawned");
  wait 9.5;
  thread _id_E953();
  scripts\engine\utility::flag_wait("forever");
}

_id_9ABD() {
  var_0 = scripts\engine\utility::getStruct("zerog_start", "targetname");
  var_1 = _id_0BDC::_id_1079F("player_jackal", "jackal_start_point");
  level._id_D127 = var_1;
  var_1._id_1FBB = "player_jackal";
  var_1.ignoreall = 1;
  var_1 notsolid();
  var_1 _id_0BDC::_id_6B4C("none");
  scripts\engine\utility::waitframe();
  var_1 scripts\sp\maps\sa_moon\sa_moon_util::_id_871D();
  var_1 thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_D129();
  var_1 thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_13328();
  thread _id_F97A(var_1);
  _id_0BDC::_id_A156();
  var_2 = scripts\sp\vehicle::_id_1080C("ally_jackal_intro0");
  var_2._id_1FBB = "salter_jackal";
  var_2.ignoreall = 1;
  var_2 _id_0BDC::_id_6B4C("fly_space");
  var_2 scripts\sp\vehicle::_id_8441();
  var_2 thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_EA9A();
  var_2 thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_13330();
  var_3 = scripts\sp\vehicle::_id_1080C("ally_jackal_intro1");
  var_3._id_1FBB = "red_jackal";
  var_3.ignoreall = 1;
  var_3 _id_0BDC::_id_6B4C("fly_space");
  var_3 thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_DE10();
  var_3 thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_1332E();
  thread _id_88A1(var_2, var_3);
  thread _id_891F(var_1, var_2, var_3);
  scripts\sp\maps\sa_moon\sa_moon_util::_id_10628();
  var_4 = scripts\sp\utility::_id_10639("player_rig");
  var_4 hide();
  var_4 notsolid();
  var_5 = scripts\sp\utility::_id_10639("intro_debris", var_0.origin, var_0.angles);
  var_6 = scripts\sp\utility::_id_10639("intro_debris_fx", var_0.origin, var_0.angles);
  thread _id_88A9(var_5);
  thread _id_FA62(var_0);
  var_7 = [];
  var_7[0] = level._id_EAFE;
  var_7[1] = level._id_C49F;
  var_8 = [];
  var_8[0] = var_4;
  var_8[1] = level._id_679E;
  var_9 = [level._id_EAFE, level._id_C49F, var_4, level._id_679E];
  var_10 = [level._id_EAFE, level._id_C49F, level._id_679E];
  var_11 = [];
  var_11[0] = var_1;
  var_11[1] = var_2;
  var_11[2] = var_3;
  var_12 = [];
  var_12[0] = var_5;
  var_12[1] = var_6;
  level.player playerlinktodelta(var_4, "tag_player", 1, 1, 1, 1, 1);
  var_4 linkTo(var_1, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player _meth_81DE(69, 0.05);
  level.player disableweapons();
  level.player _meth_80D1();
  var_4 show();
  var_1 thread scripts\sp\anim::_id_1F35(var_4, "intro_bink", "tag_player");
  var_0 thread scripts\sp\anim::_id_1F2C(var_11, "intro_bink");
  var_0 thread scripts\sp\anim::_id_1EC1(var_12, "intro");
  scripts\engine\utility::waitframe();
  level.player playerlinktodelta(var_4, "tag_player", 1, 1, 1, 1, 1);
  level.player _meth_8392(3);
}

_id_FA62(var_0) {
  level waittill("tigris_spawned");
  var_1 = scripts\sp\utility::_id_10639("tigris", var_0.origin, var_0.angles);
  level._id_118A8 linkTo(var_1, "j_prop_1", (0, 0, 0), (0, 0, 0));
  wait 6;
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "intro");
}

_id_E94F() {
  scripts\engine\utility::flag_init("jackal_intro_end");
  scripts\engine\utility::flag_init("canopy_open");
  scripts\engine\utility::flag_init("samuels_jackal_down");
  scripts\engine\utility::flag_init("hull_strafes_start");
  scripts\engine\utility::flag_init("jackal_vo_done");
}

_id_E952() {
  scripts\sp\utility::_id_13705();
  scripts\sp\utility::_id_12641("sa_moon_prime_tr");
  level thread scripts\sp\utility::_id_12643(["sa_moon_bridge_tr", "sa_moon_hull_tr"]);
}

_id_E951() {
  level thread _id_E952();
  _id_0F16::_id_3E3F("jackal_start_point");
  scripts\sp\maps\sa_moon\sa_moon_audio::_id_A0BA();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF9(1, 1);

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F3FF(1);
  }
}

_id_E94C() {
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_A0B8();
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132C5(1);
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132BF(1);

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F53C(0);
  }

  thread _id_A1C9();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_A127();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_3970();
  thread _id_891C();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_8E92(1);
  thread _id_E953();
  thread scripts\sp\maps\sa_moon\sa_moon_lighting::_id_E9C9();
  var_0 = getEnt("carrier_damage_model", "targetname");
  var_0 hide();
  thread scripts\sp\maps\sa_moon\sa_moon_hull::_id_91B6();
  thread scripts\sp\maps\sa_moon\sa_moon_hull::_id_91C3();
  thread scripts\sp\maps\sa_moon\sa_moon_hull::_id_8918();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(0);
  setsaveddvar("cg_helmetLinearVelocityToAngleRate", (0, 0, 0));
  setsaveddvar("cg_helmetViewSwayRate", 0.0);
  level._id_C0B7 = 1;
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_wait("jackal_intro_end");
}

_id_E953() {
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_10350("mn_slt_big_bandit");
  wait 0.1;
  scripts\sp\utility::_id_1034D("mn_plr_eyes_on");
  scripts\sp\utility::_id_10350("mn_fer_covering_fire_20");
  wait 0.1;
  scripts\sp\utility::_id_10350("mn_slt_follow_me_in");
  wait 0.1;
  scripts\sp\utility::_id_1034D("mn_plr_on_you_fever");
  wait 1;
  scripts\sp\utility::_id_10350("mn_slt_watch_flak");
  wait 0.5;
  scripts\sp\utility::_id_1034D("mn_plr_i_see_it");
  scripts\engine\utility::flag_wait("samuels_jackal_down");
  wait 1;
  scripts\sp\utility::_id_1034D("mn_plr_coast_guard");
  wait 2;
  scripts\sp\utility::_id_10350("mn_omr_zone_coming_up");
  wait 0.15;
  scripts\sp\utility::_id_10350("mn_slt_boots_out");
  level._id_EAFE scripts\sp\utility::_id_10346("mn_slt_2_is_away");
  scripts\sp\utility::_id_1034D("mn_plr_1_is_away");
  wait 0.5;
  scripts\engine\utility::flag_set("jackal_vo_done");
}

#using_animtree("player");

_id_A1C9() {
  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("obj_board", "current", &"SA_MOON_BOARD");
  var_0 = scripts\engine\utility::getStruct("zerog_start", "targetname");
  var_1 = _id_0BDC::_id_1079F("player_jackal", "jackal_start_point");
  level._id_D127 = var_1;
  var_1._id_1FBB = "player_jackal";
  var_1.ignoreall = 1;
  var_1 notsolid();
  var_1 _id_0BDC::_id_6B4C("none");
  var_1 thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_D129();
  var_1 thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_13328();
  thread _id_F97A(var_1);
  _id_0BDC::_id_A156();
  var_2 = scripts\sp\vehicle::_id_1080C("ally_jackal_intro0");
  var_2._id_1FBB = "salter_jackal";
  var_2 setModel("veh_mil_air_un_jackal_02_sa_moon");
  var_2.ignoreall = 1;
  var_2 _id_0BDC::_id_6B4C("fly_space");
  var_2 scripts\sp\vehicle::_id_8441();
  var_2 thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_EA9A();
  var_2 thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_13330();
  var_3 = scripts\sp\vehicle::_id_1080C("ally_jackal_intro1");
  var_3._id_1FBB = "red_jackal";
  var_3 setModel("veh_mil_air_un_jackal_02_sa_moon");
  var_3.ignoreall = 1;
  var_3 _id_0BDC::_id_6B4C("fly_space");
  var_3 thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_DE10();
  var_3 thread scripts\sp\maps\sa_moon\sa_moon_fx::_id_1332E();
  thread _id_88A1(var_2, var_3);
  thread _id_891F(var_1, var_2, var_3);
  scripts\sp\maps\sa_moon\sa_moon_util::_id_10628();
  var_4 = scripts\sp\utility::_id_10639("player_rig");
  var_4 hide();
  var_4 notsolid();
  level._id_679E hide();
  var_5 = scripts\sp\utility::_id_10639("intro_debris", var_0.origin, var_0.angles);
  var_6 = scripts\sp\utility::_id_10639("intro_debris_fx", var_0.origin, var_0.angles);
  thread _id_88A9(var_5);
  thread _id_FA60(var_0);
  var_7 = [];
  var_7[0] = level._id_EAFE;
  var_7[1] = level._id_C49F;
  var_8 = [];
  var_8[0] = var_4;
  var_8[1] = level._id_679E;
  var_9 = [level._id_EAFE, level._id_C49F, var_4, level._id_679E];
  var_10 = [level._id_EAFE, level._id_C49F, level._id_679E];
  var_11 = [];
  var_11[0] = var_1;
  var_11[1] = var_2;
  var_11[2] = var_3;
  var_11[3] = var_5;
  var_11[4] = var_6;
  level.player playerlinktodelta(var_4, "tag_player", 1, 0, 0, 0, 1);
  level._id_EAFE linkTo(var_2, "tag_player", (0, 0, 0), (0, 0, 0));
  level._id_C49F linkTo(var_2, "tag_copilot", (0, 0, 0), (0, 0, 0));
  var_4 linkTo(var_1, "tag_player", (0, 0, 0), (0, 0, 0));
  level._id_679E linkTo(var_1, "tag_copilot", (0, 0, 0), (0, 0, 0));
  level.player _meth_81DE(69, 0.05);
  level.player disableweapons();
  level.player _meth_80D1();
  var_4 show();
  var_2 thread scripts\sp\anim::_id_1F35(level._id_EAFE, "intro", "tag_player");
  var_2 thread scripts\sp\anim::_id_1F35(level._id_C49F, "intro", "tag_copilot");
  var_1 thread scripts\sp\anim::_id_1F35(var_4, "intro", "tag_player");
  var_1 thread scripts\sp\anim::_id_1F35(level._id_679E, "intro", "tag_copilot");
  var_0 thread scripts\sp\anim::_id_1F2C(var_11, "intro");
  var_12 = scripts\engine\utility::get_notetrack_time(%sa_moon_intro_plr, "passed_tigris");
  var_13 = scripts\engine\utility::get_notetrack_time(%sa_moon_intro_plr, "canopy_open");
  var_14 = scripts\engine\utility::get_notetrack_time(%sa_moon_intro_plr, "ally_jackal_hover");
  var_15 = scripts\engine\utility::get_notetrack_time(%sa_moon_intro_plr, "allies_eject");
  var_16 = scripts\engine\utility::get_notetrack_time(%sa_moon_intro_plr, "finish_link");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_6006(var_13);
  scripts\engine\utility::waitframe();
  scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_266F);
  var_1 scripts\sp\maps\sa_moon\sa_moon_util::_id_871D();
  level.player lerpviewangleclamp(3, 0, 0, 30, 30, 30, 1);
  level.player _meth_8392(3);
  wait(var_14 - 0.05);
  scripts\engine\utility::flag_set("hull_strafes_start");
  var_2 _id_0BDC::_id_6B4C("hover_space");
  level.player lerpviewangleclamp(1, 0.1, 0.1, 0, 0, 0, 0);
  level.player _meth_81DE(65, 1);
  wait(var_15 - var_14);
  waitforalltransients();
  thread scripts\sp\maps\sa_moon\sa_moon_hull::_id_91C4();
  var_17 = scripts\sp\utility::_id_10639("mco_rope");
  var_18 = scripts\sp\utility::_id_10639("xo_rope");
  var_7 = [];
  var_7[0] = level._id_EAFE;
  var_7[1] = level._id_C49F;
  var_7[2] = var_18;
  var_7[3] = var_17;
  level._id_EAFE unlink();
  level._id_C49F unlink();
  var_0 thread scripts\sp\anim::_id_1F2C(var_7, "eject");
  level._id_EAFE thread _id_88A0(var_18);
  level._id_C49F thread _id_88A0(var_17);
  _id_0BDC::_id_A22A(1);
  wait(var_16 - var_15);
  setomnvar("ui_hide_hud", 0);
  setomnvar("ui_active_hud", "infantry");
  _id_0BDB::_id_12975();
  level._id_679E show();
  level._id_679E unlink();
  var_0 thread scripts\sp\anim::_id_1F35(level._id_679E, "eject");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_BB36();
  var_4 waittillmatch("single anim", "gun_up");
  setomnvar("ui_jackal_cockpit_screens", 0);
  setomnvar("ui_jackal_entity", undefined);
  var_2 _id_0BDC::_id_6B4C("fly_space");
  var_1 thread _id_F535();
  level.player enableweapons();
  level.player _meth_80A1();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_F979("hull_grapple_struct");
  _id_0BDB::_id_88C8(level.player, var_4, 0.003, undefined, 1);
  var_4 unlink();
  level.player enableweapons();
  level.player _meth_80A1();
  setomnvar("ui_active_hud", "infantry");
  var_4 delete();
  scripts\engine\utility::flag_set("jackal_intro_end");
}

_id_F535() {
  _id_0C20::_id_A3B7("none");
  wait 0.05;
  _id_0BDB::_id_A330();
  wait 0.05;
  _id_0C20::_id_A3B7("fly_space");
}

_id_88A1(var_0, var_1) {
  scripts\engine\utility::waitframe();
  var_0 _id_0BDC::_id_6B4C("hover_space");
  scripts\engine\utility::waitframe();
  var_1 _id_0BDC::_id_6B4C("hover_space");
  wait 0.25;
  var_0 _id_0BDC::_id_6B4C("fly_space");
  scripts\engine\utility::waitframe();
  var_1 _id_0BDC::_id_6B4C("fly_space");
}

_id_88A0(var_0) {
  self waittillmatch("single anim", "grapple_start");
  playFXOnTag(scripts\engine\utility::getfx("zerog_grapple_launch"), var_0, "tag_origin");
  self waittillmatch("single anim", "grapple_land");
  playFX(scripts\engine\utility::getfx("zerog_grapple_impact"), self.origin);

  if(self != level._id_C49F) {
    return;
  }
  self waittillmatch("single anim", "grapple_start");
  playFXOnTag(scripts\engine\utility::getfx("zerog_grapple_launch"), var_0, "tag_origin");
  self waittillmatch("single anim", "grapple_land");
  playFX(scripts\engine\utility::getfx("zerog_grapple_impact"), self.origin);
}

#using_animtree("jackal");

_id_891F(var_0, var_1, var_2) {
  _id_A1BB(%sa_moon_intro_jackal_ally01, "jackal_explode", var_2);
  scripts\engine\utility::flag_set("samuels_jackal_down");
}

_id_A1BB(var_0, var_1, var_2, var_3) {
  var_2 endon("death");

  if(animhasnotetrack(var_0, var_1)) {
    wait(scripts\engine\utility::get_notetrack_time(var_0, var_1));
  } else if(isDefined(var_3)) {
    wait(var_3);
  } else {}
}

_id_FA60(var_0) {
  level waittill("tigris_spawned");
  var_1 = scripts\sp\utility::_id_10639("tigris", var_0.origin, var_0.angles);
  level._id_118A8 linkTo(var_1, "j_prop_1", (0, 0, 0), (0, 0, 0));
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "intro");
}

_id_88A9(var_0) {
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_07_scale15", "J_prop_1");
  thread _id_1076D(var_0, "debris_exterior_damaged_metal_panels_06_scale15", "J_prop_2");
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_07_scale15", "J_prop_6");
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_07_scale15", "J_prop_8");
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_07_scale15", "J_prop_9");
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_07_scale15", "J_prop_16");
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_07_scale15", "J_prop_17");
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_07_scale15", "J_prop_18");
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_07_scale15", "J_prop_27");
  thread _id_1076D(var_0, "debris_exterior_damaged_metal_panels_05_scale15", "J_prop_7");
  thread _id_1076D(var_0, "debris_exterior_damaged_metal_panels_05_scale15", "J_prop_10");
  thread _id_1076D(var_0, "debris_exterior_damaged_metal_panels_05_scale15", "J_prop_20");
  thread _id_1076D(var_0, "debris_exterior_damaged_metal_panels_05_scale15", "J_prop_22");
  thread _id_1076D(var_0, "debris_exterior_damaged_metal_panels_06_scale15", "J_prop_5");
  thread _id_1076D(var_0, "debris_exterior_damaged_metal_panels_06_scale15", "J_prop_13");
  thread _id_1076D(var_0, "debris_exterior_damaged_metal_panels_06_scale15", "J_prop_14");
  thread _id_1076D(var_0, "debris_exterior_damaged_metal_panels_06_scale15", "J_prop_19");
  thread _id_1076D(var_0, "debris_exterior_damaged_metal_panels_06_scale15", "J_prop_23");
  thread _id_1076D(var_0, "debris_exterior_damaged_metal_panels_06_scale15", "J_prop_26");
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_05_scale15", "J_prop_11");
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_05_scale15", "J_prop_15");
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_05_scale15", "J_prop_21");
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_05_scale15", "J_prop_24");
  thread _id_1076D(var_0, "debris_exterior_metal_panels_thick_05_scale15", "J_prop_25");
  scripts\engine\utility::flag_wait("bridge_gravity_restored");
  var_0 delete();
}

_id_1076D(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0 gettagorigin(var_2));
  var_3.angles = var_0 gettagangles(var_2);
  var_3 setModel(var_1);
  var_3 linkTo(var_0, var_2, (0, 0, 0), (0, 0, 0));
  scripts\engine\utility::flag_wait("bridge_gravity_restored");
  var_3 delete();
}

_id_F97A(var_0) {
  level.player _meth_8497(1);
  var_0 scripts\engine\utility::delaythread(0.05, _id_0BDC::_id_A2DE, 0);
  var_0 thread scripts\sp\maps\sa_moon\sa_moon_util::_id_A32B();
  var_0 thread _id_F978(0);
  var_0 _id_0BDC::_id_4323(1);
  var_0 _id_0BDC::_id_4310();
  var_0 hidepart("j_landinggear_front1");
  var_0 hidepart("j_landinggear_front_tire");
  wait 0.05;
  _id_0BDC::_id_A228();
  level.player scripts\sp\utility::_id_65E1("disable_jackal_overheat");
  setomnvar("ui_jackal_weapon_display_temp", 0);
  setomnvar("ui_jackal_show_horizon", 0);
  scripts\engine\utility::delaythread(0.05, _id_0BDC::_id_A224, 1, 1);
  setomnvar("ui_jackal_current_weapon", "spaceship_30mm_projectile");
  var_0 _id_0BDC::_id_19B0("fly");
}

_id_F978(var_0) {
  self._id_612D = spawnStruct();
  self._id_612D._id_DE86 = 0.009;
  self._id_612D._id_DE85 = 0.0017;
  self._id_612D._id_DE84 = 0.00005;
  self._id_612D._id_3CB7 = 0;
  self._id_612D._id_657B = 1;
  self._id_612D._id_3CCC = 4;
  self._id_612D.min_energy = 0.2;
  self._id_612D.active = 0;
  self._id_612D._id_B74D = 0;
  self._id_612D._id_B453 = 14000;
  self._id_612D._id_DCCA = self._id_612D._id_B74D;
  self._id_612D._id_CA04 = 0.5;
  self._id_612D._id_CA03 = 2.5;
  self._id_612D._id_CA02 = 0;
  self._id_612D._id_B754 = 0.2;
  self._id_612D.speed = 43000;
  setomnvar("ui_jackal_emp_energy", 1);
  setomnvar("ui_jackal_emp_charge", 0);
  setomnvar("ui_jackal_emp_alpha", 0);
  setomnvar("ui_jackal_min_charge_alpha", 0);
  setomnvar("ui_jackal_emp_depleted_alpha", 0);
}

_id_891C() {
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(108, "hull_strafes_start");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(111, "hull_strafes_start", 0.5);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(107, "hull_strafes_start", 3);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(101, "hull_strafes_start", 3.5);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(103, "hull_strafes_start", 5);
}