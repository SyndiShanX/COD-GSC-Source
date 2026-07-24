/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heist\heist_flytomons.gsc
*****************************************************/

_id_95E8() {
  scripts\sp\utility::_id_16EB("eject", &"HEIST_HINT_EJECT", ::_id_8FF6);
  scripts\engine\utility::flag_init("player_should_eject");
  scripts\engine\utility::flag_init("player_eject_time_limit");
  scripts\engine\utility::flag_init("player_ejected");
  scripts\engine\utility::flag_init("player_ready_for_launch");
  scripts\engine\utility::flag_init("player_on_mons");
  scripts\engine\utility::flag_init("ret_emp");
  scripts\engine\utility::flag_init("player_launched");
  scripts\engine\utility::flag_init("player_on_mons_getup");
  scripts\engine\utility::flag_init("player_failed_to_enter_jackal");
  precachemodel("veh_mil_air_un_jackal_02");
  level.player scripts\sp\utility::_id_65E0("eject_complete");
}

_id_8FF6() {
  if(scripts\engine\utility::flag("player_ejected"))
    return 1;
  else
    return 0;
}

_id_A0A2() {
  scripts\sp\utility::_id_F5AF("continue_player_top_of_church", [level.player]);
  scripts\sp\maps\heist\heist::_id_F044();
  scripts\sp\maps\heist\heist::_id_F052();
  scripts\sp\maps\heist\heist::_id_F054();
  scripts\sp\maps\heist\heist_un_rooftop::_id_6EEF();
  thread scripts\sp\maps\heist\heist_un_rooftop::_id_119F7();
  scripts\sp\maps\heist\heist_util::_id_5569("prone");
  scripts\engine\utility::delaythread(1, ::_id_BAEE);

  foreach(var_1 in level._id_BAE9)
  var_1 show();

  thread _id_0B1E::_id_551D("hvr_finale_door");
  thread scripts\sp\maps\prisoner\prisoner_hvt_scene::_id_D757(1);
}

_id_BAEE() {
  var_0 = scripts\engine\utility::getStruct("fly_to_mons_ref", "targetname");
  wait 2;
  level._id_BAE8 _meth_83A1();
  var_0 thread scripts\sp\anim::_id_1EC3(level._id_BAE8, "fly_to_mons");
  level._id_BAE8 show();
}

_id_A09D() {
  thread autosave_jackal_arrives();
  thread _id_134E1();
  thread _id_A0A1();
  wait 2.0;
  scripts\engine\utility::flag_wait("jackal_arrives_end");
}

autosave_jackal_arrives() {
  level endon("jackal_arrives_end");

  while(!level.player isonground())
    wait 1;

  scripts\sp\utility::_id_2669("jackal_arrives");
}

_id_A09F() {}

_id_A0A1() {
  level.player endon("death");
  var_0 = scripts\engine\utility::getStruct("jackal_arrival_ap_ref", "targetname");
  var_1 = scripts\engine\utility::getStruct("fly_to_mons_ref", "targetname");
  level._id_D267 = var_1 scripts\sp\utility::_id_10639("player_rig");
  level._id_D267 hide();
  _id_9633();
  var_1._id_A056 = level._id_D127;
  var_1._id_D267 = level._id_D267;
  var_1 scripts\sp\anim::_id_1EC3(level._id_D267, "fly_to_mons_eject");
  _id_A09C(var_1);
  _id_D1AC();
  _id_D1F9(var_1);
  level.player _meth_80D1();

  foreach(var_3 in level._id_871C)
  var_3 delete();

  level._id_BAE8._id_4348 delete();
  _id_D100(var_1);
  _id_D07B(var_1);
  scripts\engine\utility::flag_set("jackal_arrives_end");
}

#using_animtree("jackal");

_id_8D1B() {
  thread _id_0BDB::_id_1EC6(%heist_mons_attack_plr_overmount, "dof_grab", ::_id_5842);
  thread _id_0BDB::_id_1EC6(%heist_mons_attack_plr_overmount, "dof_topview", ::_id_584D);
  thread _id_0BDB::_id_1EC6(%heist_mons_attack_plr_overmount, "dof_sit", ::_id_584A);
  level._id_D127 clearanim(%heist_mons_attack_jackal_arrival, 0);
  level._id_D127 clearanim(%jackal_vehicle_assault_motion_idle, 0);
  level._id_D127 _meth_83A1();
  _id_0BDB::_id_BBDD(undefined, %heist_mons_attack_plr_overmount, %heist_mons_attack_jackal_overmount);
  return "hover";
}

_id_5842() {
  _id_0B0A::_id_583F(0, 0, 0, 6.9, 33.5, 3, 0);
}

_id_584D() {
  _id_0B0A::_id_583F(0, 0, 0, 71, 800, 1.75, 0.5);
}

_id_584A() {
  _id_0B0A::_id_583F(0, 0, 0, 71, 800, 1.6, 0.25);
  wait 2;
  _id_0B0A::_id_583D(2.5);
}

_id_A09C(var_0) {
  level.player endon("death");
  var_1 = level._id_D127 scripts\sp\utility::_id_7DC1("church_jackal_arrive");
  var_2 = getanimlength(var_1);
  level._id_D127 scripts\engine\utility::delaythread(var_2 - 4, scripts\sp\utility::_id_918C);
  level._id_D127 thread scripts\sp\utility::_id_918B("ar_callouts_unsa_jackal", 0, (0, 0, 0));
  var_0 thread scripts\sp\anim::_id_1F35(level._id_D127, "church_jackal_arrive");
  wait(var_2 - 4);
  thread _id_A0A0();
}

_id_A0A0() {
  level.player endon("death");
  level endon("jackal_arrives_player_jumped");
  level._id_D127._id_BBD4 = ::_id_8D1B;
  level._id_D127 waittillmatch("single anim", "end");
  level._id_D127 _meth_83A1();
  level._id_D127 setanimknob(%heist_mons_attack_jackal_idle, 1, 0.2);
  wait 0.6;
}

_id_9633() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in getEntArray("jackal_ridicuclip", "targetname")) {
    if(issubstr(var_3.classname, "script_brushmodel")) {
      var_0 = var_3;
      continue;
    }

    if(issubstr(var_3.classname, "trigger")) {
      var_1 = var_3;
      var_1 enablelinkTo();
      var_1 _meth_8314();
      level._id_A4D1 = var_3;
    }
  }

  var_1 linkTo(var_0);
  level._id_D127 = scripts\sp\vehicle::_id_1080C("jackal_player_new");
  level._id_D127 thread _id_0BDC::_id_A07D();
  var_0 linkTo(level._id_D127, "tag_origin", (0, 0, 0), (0, 0, 0));
  level._id_D127 thread scripts\engine\utility::delete_on_death(var_0);
  level._id_D127 thread scripts\engine\utility::delete_on_death(var_1);
  level._id_D127 _id_0BDC::_id_104A6(0);
  level._id_D127 _id_0BDC::_id_F48D("jump_in");
  level._id_D127 _id_0BDC::_id_A19F();
  level._id_D127 thread _id_0C1A::_id_A3B6("fly", 1.0);
  level._id_D127 thread _id_0C20::_id_A3B7("fly");
  wait 0.1;
  level._id_D127 _id_0BDC::_id_A2DE(1);
  level._id_D127._id_1FBB = "player_jackal";
  level._id_D127 scripts\sp\anim::_id_F64A();
  thread _id_A251();
  level._id_D127 _id_0BDC::_id_A156();
}

_id_D1AC() {
  thread _id_A4F6();
  scripts\engine\utility::flag_wait("jackal_arrives_player_jumped");
  scripts\engine\utility::flag_set("jackal_arrives_player_jumped");
  scripts\sp\maps\heist\heist_util::_id_6229(["prone", "weaponswitch"]);
  level._id_D127._id_116AE delete();
  level notify("mons_cannon_targeting");
  level.player takeweapon("iw7_gunless");
  level._id_D127 _id_0BDC::_id_A167();
  _id_0BDC::_id_A153(1);
  return;
}

_id_A4F6() {
  level endon("jackal_arrives_player_jumped");

  if(level._id_7683 < 2)
    var_0 = 12;
  else
    var_0 = 8;

  var_1 = 5;
  var_2 = var_0;
  thread _id_7F15(var_0);

  if(!isDefined(level._id_BAE8.cannon))
    level._id_BAE8 _id_0BB4::_id_10770();

  var_3 = level._id_D127.origin + (0, 0, 64) + anglestoright(level._id_D127.angles) * 128;
  level._id_BAE8 thread _id_0BB4::_id_BA69(var_3, var_2);
  wait(var_2);
  scripts\engine\utility::flag_set("player_failed_to_enter_jackal");
  level._id_A4D1 delete();
  level._id_BAE8 thread _id_0BB4::_id_BA6A(0, var_1);
  wait 0.75;
  level.player _meth_80A1();
  var_4 = level._id_D127.origin;
  level notify("player_failed_to_jump");
  playFX(level._effect["fighter_spaceship_explosion_ground"], var_4);
  earthquake(1, 1, level.player.origin, 500);
  playworldsound("fighter_spaceship_expl", var_4);
  wait 0.6;
  radiusdamage(level.player getEye(), 800, 1000, 1000, level._id_BAE8);
  wait 0.25;
  _id_0B60::_id_F32D("HEIST_MONS_KILL");

  if(isalive(level.player))
    level.player scripts\sp\utility::_id_54C6();

  if(!scripts\engine\utility::flag("jackal_arrives_player_jumped"))
    level._id_D127 hide();

  scripts\sp\utility::_id_B8D1();
}

_id_BBD4() {
  _id_0BDB::_id_F919(1);
  _id_0BDB::_id_BBE3();
  return "hover";
}

_id_11474() {}

_id_D1F9(var_0) {
  thread player_music_jackal_mount();
  level.player scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_1034D, "prisoner_plr_affirmativetarget");
  var_1 = 1.5;
  var_0 notify("stop_loop");
  level._id_A336 = level._id_D127 scripts\sp\utility::_id_10639("jackal_sled", var_0._id_A056.origin, var_0._id_A056.angles);
  level._id_BAE8 thread _id_BA85(var_0);
  thread scripts\sp\maps\heist\heist_un_rooftop::_id_F01F();
  var_2 = getanimlength(level._id_A336 scripts\sp\utility::_id_7DC1("church_jackal_mount"));
  thread scripts\engine\utility::flag_set_delayed("player_ready_for_launch", var_2);
  level._id_D127._id_11474 = ::_id_11474;
  level._id_D127 thread _id_0BDB::_id_F51F();
  level._id_D127 _id_0BDC::_id_6B4C("none", 1);
  level._id_D127 linkTo(level._id_A336, "tag_origin");
  _id_0BDC::_id_D164(level._id_A336);
  var_0 thread scripts\sp\anim::_id_1F35(level._id_A336, "church_jackal_mount");
  _id_0BDB::spawn_jackal_mip_buffer("veh_mil_air_un_jackal_02_player");
  scripts\engine\utility::flag_wait("player_ready_for_launch");
  playFX(scripts\engine\utility::getfx("vfx_heist_cloud_whispy"), (-3888, -13492, 1010));
  playFX(scripts\engine\utility::getfx("vfx_heist_cloud_whispy"), (-3750, -13300, 1027));
  playFX(scripts\engine\utility::getfx("vfx_heist_cloud_whispy"), (-3287, -13182, 1192));
  playFX(scripts\engine\utility::getfx("vfx_heist_cloud_whispy"), (-2800, -12608, 1681));
  playFX(scripts\engine\utility::getfx("vfx_heist_cloud_whispy"), (-2297, -12257, 2205));
  playFX(scripts\engine\utility::getfx("vfx_heist_cloud_whispy"), (-2682, -12600, 1973));
  playFX(scripts\engine\utility::getfx("vfx_heist_cloud_whispy"), (-3560, -13298, 1080));
  playFX(scripts\engine\utility::getfx("vfx_heist_cloud_whispy"), (-2954, -12925, 1447));
  playFX(scripts\engine\utility::getfx("vfx_heist_cloud_whispy"), (-2007, -12191, 2111));
}

player_music_jackal_mount() {
  wait 3.75;
  setmusicstate("mx_314_heist_enter_mons");
}

_id_BA85(var_0) {
  self endon("death");
  wait 1.5;
  self vehicle_setspeedimmediate(0, 1000, 1000);
  self _meth_83A1();
  self notify("newpath");
  var_0 scripts\sp\anim::_id_1EC3(self, "fly_to_mons");
}

_id_D100(var_0) {
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_A336, "idle_before_launch");
  _id_0BDC::_id_137DA();
  var_1 = 1.5;
  level._id_D127 thread _id_0BDB::_id_11479();
  level._id_D127 thread _id_0BDB::_id_1147B(var_1);
  _id_8D1D();
  thread _id_D0FF(var_1 + 7);
  level._id_D127 waittill("notify_player_launch");
  scripts\engine\utility::flag_set("player_launched");
  level._id_D127 _id_0BDC::_id_A0BE(1);
}

_id_D0FF(var_0) {
  if(!isDefined(level._id_BAE8.cannon))
    level._id_BAE8 _id_0BB4::_id_10770();

  var_1 = var_0 * 0.8;
  var_2 = var_0 * 0.2;
  level._id_BAE8 thread _id_0BB4::_id_BA69(_id_0BDC::_id_7BBA(), var_0);
  scripts\engine\utility::flag_wait_or_timeout("player_launched", var_0);

  if(scripts\engine\utility::flag("player_launched")) {
    return;
  }
  scripts\engine\utility::flag_set("player_failed_to_launch");
  level._id_BAE8 thread _id_0BB4::_id_BA6A(var_2, 5);
  wait(var_2);
  level.player _meth_80A1();
  var_3 = level._id_D127.origin;
  var_4 = anglesToForward(level._id_D127 gettagangles("tag_camera"));
  var_3 = level._id_D127.origin + var_4 * 500;
  playFX(level._effect["fighter_spaceship_explosion_ground"], var_3);
  playworldsound("fighter_spaceship_expl", var_3);
  wait 0.25;
  level._id_4C48 = "HEIST_MONS_KILL";
  level._id_D127 notify("script_death");
  level waittill("forever");
}

_id_1173E(var_0) {
  var_1 = level.player scripts\sp\hud_util::_id_499D("objective", 2.5);
  var_1.alpha = 1;
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.horzalign = "left";
  var_1.vertalign = "top";
  var_1.x = 10;
  var_1.y = 10;
  var_1.hidewheninmenu = 0;
  var_1.hidewhendead = 1;
  var_1 settenthstimer(var_0 * 60);
}

_id_D07B(var_0) {
  level._id_BAE8 show();
  var_0 notify("stop_loop");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_BAE8, "fly_to_mons");
  var_0 thread _id_687D();
  var_1 = 3;
  thread _id_B98B(var_1);
  var_2 = _id_5F32(var_0);
  var_3 = scripts\engine\utility::getStruct("start_mons_landed", "targetname");
  var_4 = getanimlength(level._id_A336 scripts\sp\utility::_id_7DC1("fly_to_mons"));
  thread scripts\engine\utility::flag_set_delayed("player_should_eject", var_4 - var_1);
  thread scripts\engine\utility::flag_set_delayed("player_eject_time_limit", var_4);
  var_2 thread scripts\sp\anim::_id_1F35(level._id_A336, "fly_to_mons");
  var_5 = scripts\sp\vehicle::_id_1080C("vehicle_ally_dropship_flytomons");
  var_5._id_1FBB = "ret_smash_dropship_1";
  var_2 thread scripts\sp\anim::_id_1F35(var_5, "ret_smash");
  var_5 scripts\engine\utility::delaycall(2, ::playsound, "scn_heist_dropship_flyby");
  var_5 thread _id_5175("ret_smash");
  var_6 = level._id_D127;
  var_7 = scripts\engine\utility::getStruct("dropship_arrive", "targetname");
  var_8 = var_7 _id_5F32(var_7);

  if(!scripts\engine\utility::flag("player_failed_to_launch"))
    scripts\sp\utility::_id_2669("mons_flight");

  thread jackal_fuel_depletion();
  var_9 = scripts\engine\utility::flag_wait_any_return("player_ejected", "player_eject_time_limit");
  visionsetnaked("heist_ext_mons_eject", 3.0);

  foreach(var_11 in level._id_BAE9)
  var_11 show();

  level notify("mons_fake_hangar_lights_on");

  if(var_9 != "player_ejected") {
    var_2 thread scripts\sp\anim::_id_1F35(level._id_A336, "fly_to_mons_eject_fail");
    thread _id_0BDC::_id_A2B0(%heist_mons_attack_plr_flight_failtoeject, %heist_mons_attack_jackal_flight_failtoeject, 0.4);
    level._id_BAE8 _id_0BB4::_id_BA69(_id_0BDC::_id_7BBA(), 0.25);
    level._id_BAE8 thread _id_0BB4::_id_BA6A(0.25, 2);
    wait 0.5;
    thread _id_69F1(4);
    level._id_4C48 = "HEIST_EJECT_DEATH_HINT";
    level._id_D127 notify("script_death");
    level waittill("forever");
  }

  scripts\engine\utility::delaythread(1, ::_id_6004);
  var_13 = getanimlength(%heist_mons_attack_plr_flight_eject);
  thread r_sdfshadowpenumbra(var_13);
  _id_0BDC::_id_A2B0(%heist_mons_attack_plr_flight_eject, %heist_mons_attack_jackal_flight_eject, 0.1, 0.1);
  var_14 = getanimlength(level._id_D267 scripts\sp\utility::_id_7DC1("fly_to_mons_eject"));
  var_15 = scripts\engine\utility::get_notetrack_time(level._id_D267 scripts\sp\utility::_id_7DC1("fly_to_mons_eject"), "fade_out");
  thread scripts\engine\utility::flag_set_delayed("player_on_mons", var_14);
  level.player scripts\engine\utility::delaycall(2.8, ::clearclienttriggeraudiozone, 1);
  var_16 = spawn("script_model", level._id_D127.origin);
  var_16._id_1FBB = "player_jackal";
  var_16 scripts\sp\utility::_id_23B7();
  var_16 setModel("veh_mil_air_un_jackal_02");
  var_16 thread _id_5134();
  var_2 thread scripts\sp\anim::_id_1EC3(var_16, "fly_to_mons_eject");
  var_17 = scripts\sp\utility::_id_10639("ret_fall_jackal_1");
  var_17 thread _id_5175("ret_fall");
  var_0 thread scripts\sp\anim::_id_1F35(var_17, "ret_fall");
  thread _id_E075(var_0);
  level.player scripts\sp\utility::_id_65E3("eject_complete");
  var_2 thread scripts\sp\anim::_id_1F2C([level._id_D267, level._id_A336, var_16], "fly_to_mons_eject");
  scripts\engine\utility::noself_delaycall(3.5, ::visionsetnaked, "heist_int_mons_hangar", 1.5);
  wait 2.5;
  thread scripts\sp\maps\heist\heist_un_rooftop::_id_7694();
  scripts\engine\utility::flag_wait("player_on_mons");
  scripts\engine\utility::flag_clear("obj_flytomons");

  if(!scripts\engine\utility::flag("mons_boost") || scripts\engine\utility::flag("mons_boost_failed"))
    level waittill("forever");

  scripts\engine\utility::flag_set("transient_mons_hangar");
  scripts\engine\utility::waitframe();
  waitfortransient("heist_geo_om_hangar_tr");
  thread scripts\sp\maps\heist\heist_hangar::_id_5D72();
  thread _id_D09F(var_8);
  level notify("mons_fake_hangar_lights_off");
}

jackal_fuel_depletion() {
  var_0 = 15;
  var_1 = 100;
  var_2 = var_1 / (var_0 * 20);

  for(var_3 = 0; var_3 < var_0; var_3 = var_3 + 0.05) {
    var_1 = scripts\sp\utility::_id_E753(var_1 - var_2, 2);
    setomnvar("ui_jackal_launch_fuel", var_1);
    scripts\engine\utility::waitframe();
  }
}

r_sdfshadowpenumbra(var_0) {
  var_1 = getDvar("r_sdfShadowPenumbra");
  setsaveddvar("r_sdfShadowPenumbra", 0.1);
  wait(var_0 + 4);
  setsaveddvar("r_sdfShadowPenumbra", var_1);
}

_id_687D() {
  var_0 = getdvarfloat("ret_timing_offset");
  var_1 = [];

  for(var_2 = 0; var_2 < 3; var_2++) {
    var_1[var_2] = scripts\sp\utility::_id_10639("ret_smash_jackal_" + (var_2 + 1));
    var_1[var_2] thread _id_5175("ret_smash");
  }

  var_3 = 0;

  if(var_0 > 0)
    var_3 = var_0;
  else if(var_0 < 0) {
    foreach(var_5 in var_1) {
      var_6 = getanimlength(var_5 scripts\sp\utility::_id_7DC1("ret_smash"));
      var_7 = var_6 - (var_6 + var_0);
      var_7 = scripts\sp\math::_id_C097(0, var_6, var_7);
      scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F2A, [var_5], "ret_smash", var_7);
    }

    var_6 = getanimlength(level._id_E3F6 scripts\sp\utility::_id_7DC1("fly_to_mons"));
    var_7 = var_6 - (var_6 + var_0);
    var_7 = scripts\sp\math::_id_C097(0, var_6, var_7);
    scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F2A, [level._id_E3F6], "fly_to_mons", var_7);
  }

  scripts\engine\utility::delaythread(var_3, scripts\sp\anim::_id_1F2C, var_1, "ret_smash");
  scripts\engine\utility::delaythread(var_3, scripts\sp\anim::_id_1F35, level._id_E3F6, "fly_to_mons");
  thread _id_E30D();
}

_id_5175(var_0) {
  wait(getanimlength(scripts\sp\utility::_id_7DC1(var_0)));
  scripts\sp\utility::_id_F1DE();
}

_id_D09F(var_0) {
  level.player _meth_80D1();
  thread scripts\sp\utility::_id_266F();
  thread scripts\sp\maps\heist\heist::_id_F04F();
  wait 1;
  setsaveddvar("sm_sunsamplesizenear", 1.0);
  thread _id_BA86();
  scripts\engine\utility::delaythread(0, ::_id_B150, 0.5);
  scripts\engine\utility::delaythread(0.75, ::_id_B150, 0.25);
  scripts\engine\utility::delaythread(2, ::_id_B150, 0.1);
  level scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_F225, "stop_magic_bullets");
  level.player _meth_8392(0.5, 5, 5);
  var_0 scripts\sp\anim::_id_1F35(level._id_D267, "fly_to_mons_eject_getup");
  level.player _meth_80A1();
  setomnvar("ui_hide_hud", 0);
  scripts\engine\utility::flag_set("player_on_mons_getup");
  scripts\engine\utility::flag_clear("mons_boost");
  _id_DF3E();
  level._id_D267 delete();
  scripts\engine\utility::flag_set("obj_securethehangar");
}

_id_B150(var_0) {
  var_1 = -32;
  var_2 = 32;
  var_3 = -32;
  var_4 = 32;
  var_5 = scripts\engine\utility::getStruct("struct_hangar_enter_fakefire", "targetname");
  var_6 = var_5.origin + anglesToForward(var_5.angles);
  var_7 = var_5.origin + anglesToForward(var_5.angles) * 1500;
  level endon("stop_magic_bullets");

  for(;;) {
    var_8 = (randomfloatrange(var_1, var_2), 0, 0);
    var_9 = (randomfloatrange(var_3, var_4), 0, randomfloatrange(0, var_4));
    var_6 = var_6 + var_8;
    var_7 = var_7 + var_9;
    magicbullet("iw7_sdfar", var_6, var_7);
    bullettracer(var_6, var_7, "iw7_sdfar", 1);
    wait(var_0);

    if(!scripts\engine\utility::random([0, 1, 2, 3]))
      wait(randomfloatrange(0.3, 0.7));
  }
}

_id_BA86() {
  _id_67BE();
  _id_0B0A::_id_583F(0, 0, 0, 182.5, 606.8, 2.7, 1);
  level.player setblurforplayer(5, 0.05);
  level.player scripts\engine\utility::delaycall(0.25, ::setblurforplayer, 0, 2);
  thread scripts\sp\utility::_id_10321();
  scripts\sp\hud_util::_id_6A99(0.05, "black");
  scripts\engine\utility::delaythread(1.3, scripts\sp\utility::_id_10322);
  scripts\engine\utility::delaythread(5.3, _id_0B0A::_id_583D, 1.5);
}

_id_67BE() {
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_1_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_alt_2_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_alt_3_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_alt_4_2d", 0.15);
  soundsettimescalefactor("weap_npc_main_3d", 0.2);
  soundsettimescalefactor("weap_npc_mech_3d", 0.2);
  soundsettimescalefactor("weap_npc_mid_3d", 0.2);
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  soundsettimescalefactor("weap_npc_dist_3d", 0.2);
  soundsettimescalefactor("weap_npc_lo_3d", 0.2);
  soundsettimescalefactor("explo_1_3d", 0.2);
  soundsettimescalefactor("explo_2_3d", 0.2);
  soundsettimescalefactor("explo_3_3d", 0.2);
  soundsettimescalefactor("explo_4_3d", 0.2);
  soundsettimescalefactor("bulletflesh_1_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_2_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_lfe_unres_2d_lim", 0);
  soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_npcnpc1_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_npcnpc2_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletimpact_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletimpact_lo_unres_3d_lim", 0.2);
  soundsettimescalefactor("bullet_ricochets_unres_3d_lim", 0.2);
  soundsettimescalefactor("physics_lo_unres_3d_lim", 0.2);
  soundsettimescalefactor("foley_npc_step_3d", 0.2);
  soundsettimescalefactor("whizby_out_unres_3d_lim", 0.2);
  soundsettimescalefactor("whizby_in_unres_3d_lim", 0.2);
  soundsettimescalefactor("special_lo_unres_1_2d", 0.15);
  soundsettimescalefactor("voice_plr_breath_2d", 0.15);
  soundsettimescalefactor("scn_lfe_unres_2d", 0);
  soundsettimescalefactor("pa_speaker", 0.15);
  soundsettimescalefactor("amb_bed_2d", 0.25);
  soundsettimescalefactor("amb_elm_unres_3d", 0.25);
  soundsettimescalefactor("amb_elm_int_unres_3d", 0.25);
  soundsettimescalefactor("amb_elm_ext_special_unres_3d", 0.25);
}

_id_5134() {
  self waittillmatch("single anim", "end");
  self delete();
}

_id_D86A() {
  level endon("kill_boost_button");
  level endon("player_on_mons");
  notifyoncommand("playerboost", "+gostand");
  notifyoncommand("playerboost", "+moveup");
  scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_56BA, "boost_hint");

  for(;;) {
    level.player waittill("playerboost");
    scripts\engine\utility::flag_set("mons_boost");
    level.player playSound("scn_heist_plr_boost");
    level.player _meth_8291(0.3, 0.3, 0.3, 0.4, 0, -1, 0, 30, 30, 30);
    earthquake(0.6, 0.35, level.player.origin - (0, 0, 40), 500);
    level.player playRumbleOnEntity("heavy_1s");
    level.player thread scripts\sp\gameskill::_id_2BDB(1, 0.25);
    wait 1;
  }
}

_id_A251() {
  var_0 = getdvarint("r_mbenable");
  var_1 = getDvar("r_mbRadialOverridePosition");
  var_2 = getDvar("r_mbRadialOverrideAngleAttenuation");
  var_3 = getDvar("r_mbRadialOverrideRadius");
  var_4 = getDvar("r_mbRadialOverrideFocusDir");
  scripts\engine\utility::flag_wait("player_launched");
  setsaveddvar("r_mbenable", 1);
  level thread _id_A062();
  scripts\engine\utility::flag_wait("ret_emp");
  level _id_A42E(var_1, var_2, var_3, var_4);
}

_id_616A() {
  var_0 = level._id_E3F6.origin + anglesToForward(level._id_E3F6.angles) * 500;
  setsaveddvar("r_mbenable", 1);
  setsaveddvar("r_mbRadialOverridePosition", var_0);
  setsaveddvar("r_mbRadialOverridePositionActive", 1);
  setsaveddvar("r_mbRadialoverridechromaticAberration", 1.15);
  setsaveddvar("r_mbradialoverridestrength", 0.34);
  wait 0.4;
  thread scripts\sp\utility::_id_AB9A("r_mbRadialoverridechromaticAberration", 0, 0.25);
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0, 0.25);
  wait 0.25;
  setsaveddvar("r_mbRadialOverridePositionActive", 0);
}

_id_6005() {
  setsaveddvar("r_mbenable", 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideRadius", 0.314878, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialoverridechromaticAberration", 0.25, 2);
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0.05, 1);
  wait 2.2;
  thread scripts\sp\utility::_id_AB9A("r_mbRadialoverridechromaticAberration", 0.15, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0.009, 1);
  scripts\engine\utility::flag_wait("player_on_mons");
  setsaveddvar("r_mbenable", 0);
  setsaveddvar("r_mbRadialoverridechromaticAberration", 0);
  setsaveddvar("r_mbradialoverridestrength", 0);
  setsaveddvar("r_mbRadialOverrideRadius", 0);
}

_id_A062() {
  level endon("stop_jackal_aberration");
  var_0 = anglesToForward(_id_0BDC::_id_7B9F()) * 800;
  setsaveddvar("r_mbRadialOverrideChromaticAberration", 0.9);
  setsaveddvar("r_mbRadialOverridePosition", var_0);
  setsaveddvar("r_mbRadialOverridePositionActive", 1);
  setsaveddvar("r_mbRadialOverrideRadius", -0.2);
  setsaveddvar("r_mbRadialOverrideFocusDir", 0.2);
  setsaveddvar("r_mbRadialOverrideAngleAttenuation", 0.1);
  setsaveddvar("r_mbradialoverridestrength", 0.0);
  setsaveddvar("r_mbradialoverridedistortion", 0.05);
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridedistortion", 0.025, 0.1);
  scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0.015, 0.1);

  for(;;) {
    var_1 = randomfloatrange(0.05, 0.1);
    var_2 = randomfloatrange(0.005, 0.02);
    thread scripts\sp\utility::_id_AB9A("r_mbradialoverridedistortion", var_2 * 2, var_1);
    scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", var_2, var_1);
  }
}

_id_A42E(var_0, var_1, var_2, var_3) {
  level notify("stop_jackal_aberration");
  wait 0.05;
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridedistortion", 0.0, 1.0);
  scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0.0, 1.0);
  setsaveddvar("r_mbRadialOverrideChromaticAberration", 0);
  setsaveddvar("r_mbRadialOverridePosition", var_0);
  setsaveddvar("r_mbRadialOverridePositionActive", 0);
  setsaveddvar("r_mbRadialOverrideRadius", var_2);
  setsaveddvar("r_mbRadialOverrideFocusDir", var_3);
  setsaveddvar("r_mbRadialOverrideAngleAttenuation", var_1);
  setsaveddvar("r_mbradialoverridestrength", 0.0);
  setsaveddvar("r_mbradialoverridedistortion", 0.0);
}

_id_69F1(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 0.4);

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_3 = anglesToForward(level._id_D127 gettagangles("tag_camera"));
    var_4 = level._id_D127.origin + var_3 * 2000;
    playFX(level._effect["fighter_spaceship_explosion_ground"], var_4);
    wait(var_1);
  }
}

_id_6004() {
  earthquake(1, 1, level.player.origin, 1000);
  level.player playRumbleOnEntity("heavy_3s");
  level.player playSound("scn_heist_jackal_eject");
  level.player _meth_82C0("heist_eject_wind", 0.5);
  level._id_D127 thread _id_0BDC::_id_1100D("jackal_severe_damaged_alarm");
  thread _id_D86A();
  thread _id_6003();
  thread _id_6005();
  thread _id_6002();
}

_id_6002() {
  level endon("player_on_mons");
  wait 0.6;
  level.player scripts\sp\utility::play_sound_on_entity("plr_breath_shield_melee");

  for(;;) {
    level.player scripts\sp\utility::play_sound_on_entity("plr_breath_sprint_inh");
    wait(randomfloatrange(0.05, 0.2));
    level.player scripts\sp\utility::play_sound_on_entity("plr_breath_sprint_exh");
    wait(randomfloatrange(0.1, 0.3));
  }
}

_id_E075(var_0) {
  setomnvar("ui_jackal_critical_health", 0);
  _id_0BDC::_id_A10F();
  level._id_D127 _id_0BDC::_id_F358("heist_mons_breach");
  level._id_D127 thread scripts\sp\utility::_id_C12D("notify_stop_thrust_audio", 2);
  level._id_D127 _id_0BDB::_id_E073();
  scripts\engine\utility::waitframe();
  setomnvar("ui_hide_hud", 1);
  scripts\sp\maps\heist\heist_util::_id_5569("!freeze");
}

_id_B98B(var_0) {
  level endon("player_eject_time_limit");
  scripts\engine\utility::flag_wait("player_should_eject");
  setomnvar("ui_hide_hud", 0);
  scripts\sp\utility::_id_56BA("eject");

  while(level.player useButtonPressed())
    wait 0.05;

  while(!level.player useButtonPressed())
    wait 0.05;

  scripts\engine\utility::flag_set("player_ejected");
}

_id_E30D() {
  scripts\engine\utility::flag_wait("ret_emp");
  level notify("retribution_light_on");
  level.player playSound("scn_heist_ret_ftl_in");
  level._id_E3F6 show();
  level.player playRumbleOnEntity("heavy_1s");
  level waittill("hit_by_emp");
  level.player playSound("scn_heist_jackal_emp_hit");
  thread _id_616A();
  thread _id_6138();
  thread _id_E30C();
  _id_104EF();
  level._id_D127 _id_0BDC::_id_A0BE(0);
  level._id_D127 thread _id_0BDC::_id_A10B("damage_alarm");
  level._id_D127 thread _id_0BDC::_id_A261("jackal_severe_damaged_alarm");
  level.player thread _id_0BD5::_id_A13A(3, 0.8);
  level._id_D127 thread _id_0BD5::_id_1284F();
  scripts\engine\utility::delaythread(2, ::_id_A111);
  level.player playRumbleOnEntity("heavy_1s");
  thread _id_0BDC::_id_A2B0(%heist_mons_attack_plr_emp_reaction, %heist_mons_attack_jackal_emp_reaction, 0.1, 0.1);
}

_id_E30C() {
  level._id_D127 _id_0BD5::_id_D13F(4);
  wait 0.2;
  level._id_D127 _id_0BD5::_id_D13F(8);
}

_id_6138() {
  level endon("stop_cam_shake");
  level thread scripts\sp\utility::_id_C12D("stop_cam_shake", 1);

  for(;;) {
    var_0 = randomfloatrange(1.9, 2.4);
    var_1 = randomfloatrange(0.7, 1.3);
    var_2 = randomfloatrange(0.4, 1.2);
    var_3 = 0.1;
    var_4 = var_3 * 0.5;
    var_5 = var_3 * 0.5;
    var_6 = 0;
    var_7 = 1;
    var_8 = 0;
    var_9 = 0;
    var_10 = 1;
    var_0 = var_0 * 3;
    var_1 = var_1 * 3;
    var_2 = var_2 * 3;
    level.player _meth_8291(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    wait(var_3);
  }
}

_id_A111() {
  level endon("player_ejected");
  _id_0BDC::_id_A22A();
}

_id_6003() {
  level endon("player_on_mons");

  for(;;) {
    var_0 = randomfloatrange(1.9, 2.4);
    var_1 = randomfloatrange(0.7, 1.3);
    var_2 = randomfloatrange(0.4, 1.2);
    var_3 = 0.15;
    var_4 = var_3 * 0.5;
    var_5 = var_3 * 0.5;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 1;
    level.player _meth_8291(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    wait(var_3);
  }
}

_id_5F32(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  return var_1;
}

_id_D85C() {
  level.player setstance("stand");
  level.player _meth_84FE();
  scripts\sp\maps\heist\heist_util::_id_5569("!freeze");
}

_id_DF3E() {
  level.player unlink();
  level.player _meth_84FD();
  level.player showviewmodel();
  scripts\sp\maps\heist\heist_util::_id_6229();
  wait 0.05;

  if(level.player getcurrentweapon() == "none") {
    var_0 = level.player scripts\sp\utility::_id_7D74();

    if(isDefined(var_0[0]))
      level.player switchtoweapon(var_0[0]);
  }
}

_id_7F15(var_0) {
  level endon("jackal_arrives_player_jumped");

  if(level._id_7683 < 2) {
    wait(var_0 / 2);
    scripts\sp\utility::_id_10350("heist_eth_sirweneedtogeta");
  }
}

_id_134E1() {
  level endon("player_failed_to_launch");
  wait 2.5;
  scripts\engine\utility::flag_set("obj_flytomons");
  scripts\sp\utility::_id_10353("prisoner_eth_olympusistarget");
  scripts\engine\utility::flag_wait("player_ready_for_launch");
  wait 0.3;
  level.player scripts\sp\utility::_id_1034D("heist_plr_gatoryoureuphi");
  scripts\engine\utility::flag_wait("player_launched");
  scripts\sp\utility::_id_10350("prisoner_gtr_sirinfluxin321");
  scripts\sp\utility::_id_10350("prisoner_slt_onmeillguideusin");
  scripts\sp\maps\heist\heist_util::_id_106D9();
  scripts\engine\utility::flag_wait("ret_emp");
  wait 1;
  level.player thread scripts\sp\utility::_id_1034D("heist_plr_losingpower");
  wait 1;
  thread scripts\sp\utility::_id_10350("heist_slt_staywithit");
  scripts\engine\utility::flag_wait("player_should_eject");
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_sireject");
  wait 0.5;

  if(!scripts\engine\utility::flag("player_ejected"))
    level._id_6754 scripts\sp\utility::_id_10346("heist_eth_captainnow");
}

_id_8D1D() {
  thread _id_104EB();
  level._id_D127 notify("notify_player_can_launch");
}

_id_104EB() {
  _id_0BDC::_id_A250();
  setomnvar("ui_jackal_autopilot", 0);
  thread _id_104EC();
  thread _id_104EE();
  thread _id_104F1();
  thread _id_104F0();
  thread _id_104F2();
  thread _id_104ED();
}

_id_104EF() {
  level notify("launch_hud_off");
  _id_0BDC::_id_A250(0);
}

_id_104EC() {
  level endon("launch_hud_off");
  level._id_1161E = 0;

  for(;;) {
    var_0 = level._id_D127.origin[2];
    var_0 = var_0 - level._id_1161E;
    var_1 = scripts\sp\math::_id_C097(-109728, 80000, var_0);
    var_2 = scripts\sp\math::_id_6A8E(0, 310000, var_1);
    setomnvar("ui_jackal_launch_alt", int(var_2));
    wait 0.05;
  }
}

_id_104EE() {
  setomnvar("ui_jackal_launch_gforce", 0.0);
  level._id_D127 waittill("notify_player_launch");
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 2, 2);
  wait 2;
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 9.5, 65);
  level waittill("flag_player_boosters_disengaged");
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 0, 15);
}

_id_104F1() {
  setomnvar("ui_jackal_launch_speed", 0);
  level._id_D127 waittill("notify_player_launch");
  scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 235, 2);
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 500, 2);
  wait 2;
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 40500, 65);
  level waittill("flag_player_boosters_disengaged");
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 0, 15);
}

_id_104F0() {
  level endon("launch_hud_off");

  for(;;) {
    var_0 = level._id_D127 gettagangles("tag_body");
    var_1 = anglesToForward(var_0);
    var_2 = vectortoangles(var_1);
    setomnvar("ui_jackal_launch_pitch", abs(360 - var_2[0]));
    wait 0.05;
  }
}

_id_104F2() {
  setomnvar("ui_jackal_launch_state", 0);
}

_id_104ED() {
  level endon("launch_hud_off");
  setomnvar("ui_jackal_launch_fuel", 100);
}