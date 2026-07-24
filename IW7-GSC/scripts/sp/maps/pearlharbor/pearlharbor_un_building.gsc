/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_un_building.gsc
*******************************************************************/

_id_C9E6() {
  scripts\engine\utility::flag_init("exteriordoor_cursorhint_triggered");
  scripts\engine\utility::flag_init("parade_player_in_dropship");
  scripts\engine\utility::flag_init("parade_dropship_at_hover_pos");
  scripts\engine\utility::flag_init("parade_ride_camera_switch");
  scripts\engine\utility::flag_init("office_player_leaving_office");
  scripts\engine\utility::flag_init("office_complete");
  scripts\engine\utility::flag_init("un_vignette_1");
  scripts\engine\utility::flag_init("un_vignette_1_end");
  scripts\engine\utility::flag_init("un_vignette_2");
  scripts\engine\utility::flag_init("un_vignette_2_end");
  scripts\engine\utility::flag_init("un_vignette_3");
  scripts\engine\utility::flag_init("un_vignette_3_end");
  scripts\engine\utility::flag_init("exterior_opened");
  scripts\engine\utility::flag_init("done_watching_ret");
  scripts\engine\utility::flag_init("begin_ext_vo");
  scripts\engine\utility::flag_init("checkpoint_open");
  scripts\engine\utility::flag_init("checkpoint_done");
  scripts\engine\utility::flag_init("sign_anim_done");
  scripts\engine\utility::flag_init("delete_roof_guys");
  scripts\engine\utility::flag_init("shadow_head_attached");
  scripts\engine\utility::flag_init("dropship_takeoff");
  precachemodel("p7_desk_metal_military_03_tablet");
  precachemodel("body_un_crew_ship_a_med");
  precachemodel("body_un_crew_ship_a_low");
  precachemodel("body_un_crew_ship_b");
  scripts\sp\fakeactor::_id_6B44();
  getEnt("office_landingpad_dropship", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_C34C);
}

_id_C358() {
  level.player _meth_82C0("phparade_opening_bink", 0.0);
  var_0 = getEntArray("memorial_pillar_end", "targetname");

  foreach(var_2 in var_0) {
    var_2 delete();
  }

  setsaveddvar("cg_drawPlayerShadow", 1);
  _id_6DE7();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_newoffice");
  var_4 = ["salter"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_newoffice", var_4);
  _id_C352();
  _id_C355();
  objective_add(scripts\sp\utility::_id_C264("OBJ_CEREMONY_TRANSPORT"), "current", &"PHPARADE_OBJ_CEREMONY_TRANSPORT");
  _id_0BDC::_id_A24B("un_landing_zone1", 0);
}

_id_6A39() {
  _id_C356();
  _id_C355();
  _id_6DE6();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_exterior");
  var_0 = ["salter"];
  level._id_EA2C _id_0B6A::_id_EC0D("salter_new_memorial_start");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_exterior", var_0);
  scripts\engine\utility::flag_set("exteriordoor_cursorhint_triggered");
  objective_add(scripts\sp\utility::_id_C264("OBJ_CEREMONY_TRANSPORT"), "current", &"PHPARADE_OBJ_CEREMONY_TRANSPORT");
}

_id_E6CD() {
  _id_C352();
  _id_C355();
  thread scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_E68C();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_rooftop");
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_rooftop", var_0);
  thread scripts\sp\maps\pearlharbor\pearlharbor_un_building_fleet::_id_6EF6(1);
}

_id_5DD3() {
  _id_C352();
  _id_C355();
  var_0 = getvehiclenode("parade_dropship_pathstart", "targetname");
  level._id_D03A = _id_0BBF::_id_106B8("parade_dropship_heli");
  level._id_D03A scripts\engine\utility::delaythread(0.05, _id_0BBF::_id_F454, 1, "int", "phparade");
  level._id_D03A vehicle_teleport(var_0.origin, var_0.angles);
  level._id_D03A _id_0BBE::_id_5DFB("down");
  level._id_D03A scripts\sp\utility::_id_65DD("thrusterEffects");
  var_1 = scripts\engine\utility::play_loopsound_in_space("phparade_dropship_warmup", level._id_D03A.origin);
  var_1 linkTo(level._id_D03A);
  thread _id_9850();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_rooftop_scene");
  var_2 = ["salter"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_rooftop_scene", var_2);
}

_id_6354() {
  _id_6352(0);
}

_id_6353() {
  _id_6352(1);
}

_id_6352(var_0) {
  _id_0BDC::_id_A24B("un_landing_zone1", 0);
  var_1 = getEnt("memorial_pillar_parade", "targetname");
  var_1 delete();
  var_2 = scripts\engine\utility::getStruct("ending_scene_animnode", "targetname");
  var_3 = getspawner("salter_ending_spawner", "targetname");
  var_4 = scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_C8DA(var_3);
  var_4._id_1FBB = "salter";

  if(var_0) {
    var_4 detach(var_4.headmodel);
    var_4 attach("head_hero_xo");
    var_4 attach("head_hero_xo_dress_whites_hat", "j_helmet");
  }

  var_2 scripts\sp\anim::_id_1EC3(var_4, "ending_scene");
  level.player _meth_81DE(40, 0.05);
  level.player disableweapons();
  var_5 = getstartorigin(var_2.origin, var_2.angles, level._id_EC85["player_rig"]["ending_scene"]);
  var_6 = getstartangles(var_2.origin, var_2.angles, level._id_EC85["player_rig"]["ending_scene"]);
  level.player.origin = var_5;
  level.player setplayerangles(var_6);
  var_7 = _id_7BBB(var_2, "ending_scene");
  _id_BC56(var_7, 0, 0);
  scripts\engine\utility::waitframe();
  var_2 thread scripts\sp\anim::_id_1F35(var_7, "ending_scene");
  var_2 scripts\sp\anim::_id_1F35(var_4, "ending_scene");
}

_id_635A(var_0) {
  level.player _meth_81DE(30, 18);
}

_id_C34D() {
  _id_F9EF();
  setsaveddvar("r_umbraMinObjectContribution", 6);
  level._id_EA2C detach(level._id_EA2C.headmodel);
  level._id_EA2C attach("head_hero_xo_qss");
  thread office_dof_scripts();
  scripts\engine\utility::flag_set("shadow_head_attached");
  thread _id_C610();
  _id_CCF5();
  _id_CD93();
}

office_dof_scripts() {
  thread _id_0B0A::_id_583F(0, 80, 4.0, 0.05, 90, 4, 0);
  wait 5;
  thread _id_0B0A::_id_583D(3);
}

_id_F9EF() {
  _id_6DE6();
}

_id_C355() {
  level.player takeallweapons();
  level.player allowjump(0);
  level.player allowcrouch(0);
  level.player allowmantle(0);
  level.player allowprone(0);
  level.player allowsprint(1);
  level.player allowslide(0);
  level.player allowdoublejump(0);
  level.player allowwallrun(0);
  level.player scripts\sp\utility::_id_F526("safe");
  level.player scripts\sp\utility::_id_D2D1(100, 1);
  level.player thread scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_AB86(level._id_EA2C);
}

_id_C352() {
  _id_C356();
  _id_C354();
  _id_C351();
}

_id_C356() {
  level._id_EA2C = level.allies["salter"];
  level._id_EA2C.script_pushable = 0;
  level._id_EA2C.goalradius = 64;
  level._id_EA2C._id_1359F = "right";
  level._id_EA2C scripts\sp\utility::_id_51E1("casual");
  level._id_EA2C scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_86E4);
}

_id_C354() {
  level.allies["eth3n"] scripts\sp\utility::_id_51E1("casual");
  level.allies["eth3n"].goalradius = 64;
  level.allies["eth3n"] scripts\sp\utility::_id_86E4();
  level.allies["eth3n"].name = "";
}

_id_C351() {
  level.allies["admiral"] scripts\sp\utility::_id_51E1("casual");
  level.allies["admiral"].goalradius = 64;
  level.allies["admiral"] scripts\sp\utility::_id_86E4();
}

_id_C357() {
  _id_9873();
  _id_CE4D();
}

_id_9873() {
  level._id_113CD = scripts\sp\utility::_id_107EA("un_pet_actor_1");
  level._id_113CE = scripts\sp\utility::_id_107EA("un_pet_actor_2");
  level._id_113CD._id_1FBB = "tabletguy1";
  level._id_113CE._id_1FBB = "tabletguy2";
  level._id_113CD scripts\sp\utility::_id_51E1("casual");
  level._id_113CE scripts\sp\utility::_id_51E1("casual");
  level._id_113CA = scripts\sp\utility::_id_10639("tablet");
}

_id_CE4D() {
  var_0 = scripts\engine\utility::getStruct("tabletscene_animnode", "targetname");
  var_1 = [level._id_113CD, level._id_113CE];
  var_0 thread scripts\sp\anim::_id_1EE7(var_1, "tablet_signoff_idle", "stop_tablet_idles");
}

_id_C353() {
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_ADE0();
}

_id_CDB5() {}

_id_C610() {
  _id_15DC();
  level.player freezecontrols(0);
  _id_CDB6();
  level.player allowdoublejump(0);
  level.player allowwallrun(0);
}

_id_15DC() {
  var_0 = scripts\engine\utility::getStruct("officedoor_animnode", "targetname");
  var_1 = "open_exterior_door";
  level._id_D267 = _id_7BBB(var_0, var_1);
  _id_BC56(level._id_D267, 0.5, 0);
  level._id_D267 show();
}

_id_CDB6() {
  thread _id_CDFB();
  thread _id_CDCD();
  thread _id_CCE2();
  level.player scripts\engine\utility::delaycall(1.1, ::_meth_82C0, "phparade_UNHQ_hallway", 0.2);
  scripts\engine\utility::delaythread(1, scripts\engine\utility::play_sound_in_space, "ph_parade_door_start_plr", level.player.origin);
  scripts\engine\utility::delaythread(1.1, scripts\engine\utility::play_sound_in_space, "ph_parade_door_start_open_plr", level.player.origin);
  scripts\engine\utility::delaythread(2, scripts\engine\utility::play_sound_in_space, "ph_parade_door_start_slt", level._id_EA2C.origin);
}

_id_CDCD() {
  var_0 = scripts\engine\utility::getStruct("officedoor_animnode", "targetname");
  var_0 scripts\sp\anim::_id_1F35(level._id_D267, "open_newoffice_door");
  level.player unlink();
  level._id_D267 delete();
}

_id_CDFB() {
  var_0 = scripts\engine\utility::getStruct("officedoor_animnode", "targetname");
  level._id_EA2C scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_DB85("open_newoffice_door");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_EA2C, "open_newoffice_door");
  level._id_EA2C waittill("smooth_anim_exit_complete");
}

_id_CCE2() {
  var_0 = getEnt("officedoor_left", "targetname");
  var_1 = getEnt("officedoor_right", "targetname");
  var_0 scripts\sp\utility::_id_23B7("exterior_door_left");
  var_1 scripts\sp\utility::_id_23B7("exterior_door_right");
  var_2 = scripts\engine\utility::getStruct("officedoor_animnode", "targetname");
  var_2 thread scripts\sp\anim::_id_1F35(var_0, "open_newoffice_door");
  var_2 thread scripts\sp\anim::_id_1F35(var_1, "open_newoffice_door");
}

_id_6DE7() {
  var_0 = getEnt("officedoor_left", "targetname");
  var_1 = getEnt("officedoor_right", "targetname");
  var_0 scripts\sp\utility::_id_23B7("exterior_door_left");
  var_1 scripts\sp\utility::_id_23B7("exterior_door_right");
  var_2 = scripts\engine\utility::getStruct("officedoor_animnode", "targetname");
  var_2 thread scripts\sp\anim::_id_1EC3(var_0, "open_newoffice_door");
  var_2 thread scripts\sp\anim::_id_1EC3(var_1, "open_newoffice_door");
}

_id_CE4B() {
  scripts\engine\utility::flag_init("salter_tablet_signoff_complete");
  _id_15EF();
  scripts\engine\utility::delaythread(5.75, ::_id_CE4C);
  _id_CE4A();
  scripts\engine\utility::flag_wait("salter_tablet_signoff_complete");
}

_id_15EF() {
  var_0 = scripts\engine\utility::getStruct("tabletscene_animnode", "targetname");
  var_1 = "tablet_signoff";
  level._id_D267 = _id_7BBB(var_0, var_1);
  _id_BC56(level._id_D267, 0, 0);
  level._id_D267 show();
}

_id_CE4C() {
  level.player scripts\sp\utility::_id_1034D("phparade_plr_wholefleetallin");
  wait 0.15;
  level.player scripts\sp\utility::_id_1034D("phparade_plr_wholefleetallin2");
}

_id_CE4A() {
  scripts\sp\anim::_id_17F6("salter", "doors_open", ::_id_CCE3, "tablet_signoff");
  thread _id_CDCE();
  thread _id_CDFD();
  thread _id_CE4E();
  thread _id_CE4F();
}

_id_CDCE() {
  var_0 = scripts\sp\utility::_id_10639("player_hat");
  var_1 = [level._id_D267, var_0];
  var_2 = scripts\engine\utility::getStruct("tabletscene_animnode", "targetname");
  var_2 scripts\sp\anim::_id_1F2C(var_1, "tablet_signoff");
  level.player unlink();
  level._id_D267 delete();
  var_0 delete();
}

_id_CDFD() {
  var_0 = scripts\engine\utility::getStruct("tabletscene_animnode", "targetname");
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "tablet_signoff");
  scripts\engine\utility::flag_set("salter_tablet_signoff_complete");
}

_id_CE4E() {
  var_0 = scripts\engine\utility::getStruct("tabletscene_animnode", "targetname");
  var_1 = [level._id_113CD, level._id_113CE];
  var_0 notify("stop_tablet_idles");
  var_0 scripts\sp\anim::_id_1F2C(var_1, "tablet_signoff");
  _id_CE4D();
}

_id_CE4F() {
  var_0 = scripts\engine\utility::getStruct("tabletscene_animnode", "targetname");
  var_0 scripts\sp\anim::_id_1F35(level._id_113CA, "tablet_signoff");
  var_0 scripts\sp\anim::_id_1EEA(level._id_113CA, "tablet_signoff_idle");
}

_id_CCE3(var_0) {
  var_1 = scripts\engine\utility::getStruct("tabletscene_animnode", "targetname");
  var_2 = getEnt("officedoor_left", "targetname");
  var_3 = getEnt("officedoor_right", "targetname");
  var_2 scripts\sp\utility::_id_23B7("office_door_left");
  var_3 scripts\sp\utility::_id_23B7("office_door_right");
  var_1 thread scripts\sp\anim::_id_1F35(var_2, "tablet_signoff");
  var_1 thread scripts\sp\anim::_id_1F35(var_3, "tablet_signoff");
}

_id_6DE8() {
  var_0 = scripts\engine\utility::getStruct("tabletscene_animnode", "targetname");
  var_1 = getEnt("officedoor_left", "targetname");
  var_2 = getEnt("officedoor_right", "targetname");
  var_1 scripts\sp\utility::_id_23B7("office_door_left");
  var_2 scripts\sp\utility::_id_23B7("office_door_right");
  var_0 thread scripts\sp\anim::_id_1EC3(var_1, "tablet_signoff");
  var_0 thread scripts\sp\anim::_id_1EC3(var_2, "tablet_signoff");
}

_id_40CA() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(level._id_113CA);
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_EA07(level._id_113CD);
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_EA07(level._id_113CE);
}

_id_CCF5() {
  level._id_EA2C scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_EC00("salter_office_hallway_wait2");
}

_id_CCF6() {
  wait 3;
  level._id_EA2C scripts\sp\utility::_id_13861("on", level.player, "right");
  level._id_EA2C scripts\sp\utility::_id_10346("phparade_slt_cmonwelltakethe");
  level._id_EA2C scripts\sp\utility::_id_13861("off", level.player, "right");
}

_id_CD93() {
  thread _id_48DF();
  thread _id_CD92();
  setmusicstate("mx_079_memorial_hall");
}

_id_CD92() {
  level endon("exterior_started");
  thread _id_CD94();
  _id_CD91();
  _id_EA88();
}

_id_CD94() {
  level endon("exterior_started");
}

_id_CD91() {
  level endon("exterior_started");
  level._id_EA2C scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_EC00("salter_office_memorial_wait1");
  var_0 = scripts\engine\utility::getStruct("memorialscene_animnode", "targetname");
  var_1 = getstartorigin(var_0.origin, var_0.angles, level._id_EA2C scripts\sp\utility::_id_7DC1("memorial_wall_salter"));
  var_2 = (-24768.6, -20912, -26880.9);
  var_3 = (-24738.1, -20920.9, -26881);
  var_4 = distance2d(var_2, var_3);
  var_5 = var_3 - var_1;
  var_0 = scripts\engine\utility::spawn_tag_origin(var_0.origin + var_5, var_0.angles);
  var_0 scripts\sp\anim::_id_1F17(level._id_EA2C, "memorial_wall_salter");
  level._id_EA2C scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_DB85("memorial_wall_salter");
  var_6 = getanimlength(level._id_EA2C scripts\sp\utility::_id_7DC1("memorial_wall_salter")) - 0.75;
  level.player scripts\engine\utility::delaythread(var_6, scripts\sp\utility::_id_1034D, "phparade_plr_tothefallen");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_EA2C, "memorial_wall_salter");
  level._id_EA2C scripts\asm\asm::_id_237B(0.88);
  var_7 = getanimlength(level._id_EA2C scripts\sp\utility::_id_7DC1("memorial_wall_salter"));
  wait(var_7 - 0.33);
  thread _id_EABF();
  level._id_EA2C waittill("smooth_anim_exit_complete");
}

_id_EABF() {
  level endon("exterior_started");
  level._id_EA2C scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_AB77(1, 3);
}

_id_EA88() {
  level endon("exterior_started");
  thread _id_DB81();
  level._id_EA2C _id_0B6A::_id_EC0B("salter_office_memorial_wait3", "shipcrib_stand_stationary_talk_idle_02", "idle01", undefined, undefined, undefined, undefined, 1);
}

_id_DB81() {
  level._id_EA2C waittill("sceneblock_reach_finished");

  if(!scripts\engine\utility::flag("exterior_opened")) {
    level._id_EA2C._id_136FA = 1;
    level._id_EA2C waittill("sceneblock_reachidle_finished");

    if(!scripts\engine\utility::flag("exterior_opened")) {
      level._id_EA2C _id_0EE5::_id_202D(2, "phparade_slt_readyweremissin");
      scripts\engine\utility::flag_wait("exterior_opened");
      level._id_EA2C _id_0EE5::_id_10FC4();
    }
  }
}

_id_DB6F() {
  wait 8;

  if(!scripts\engine\utility::flag("exterior_opened")) {
    level._id_EA2C scripts\sp\utility::_id_10346("phparade_slt_readyweremissin");
  }
}

_id_48DF() {
  var_0 = getEnt("exteriordoor_cursorhint", "targetname");
  var_0 _id_0E46::_id_48C4(undefined, undefined, undefined, undefined, 400, undefined, 0);
  var_0 waittill("trigger");
  level.player scripts\engine\utility::delaycall(0.3, ::playsound, "scn_phparade_balcony_door_lerp_plr");
  scripts\engine\utility::flag_set("exteriordoor_cursorhint_triggered");
}

_id_ADC7() {
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_ADCB();
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_ADC9();
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_ADCC();
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_ADCD();
  thread _id_B96E();
}

_id_B96E() {
  for(;;) {
    scripts\engine\utility::flag_wait("checkpoint_ambient_on");
    scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_407B();
    scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::disable_ambient_shadows("exterior_balcony_ambient");
    scripts\engine\utility::waitframe();
    scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_ADCA();
    _id_ADB5();
    scripts\engine\utility::flag_wait("balcony_ambient_on");
    scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_407A();
    _id_4060();
    scripts\engine\utility::waitframe();
    scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::enable_ambient_shadows("exterior_balcony_ambient");
    scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_ADCB();
  }
}

_id_DB6D() {
  scripts\engine\utility::flag_wait("ext_first_stop");
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_4079();
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_ADCC();
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_ADCD();
}

_id_C34C() {
  scripts\engine\utility::flag_wait("parade_player_in_dropship");
  self delete();
}

_id_C342() {}

_id_C341() {
  thread _id_C342();
}

_id_6A35() {
  scripts\engine\utility::flag_wait("exteriordoor_cursorhint_triggered");
  level.player freezecontrols(1);
  level notify("exterior_started");
  _id_40CA();
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_409F();
  thread scripts\sp\maps\pearlharbor\pearlharbor_un_building_fleet::_id_6EF6();
  thread _id_CAD9();
  _id_ADC7();

  if(scripts\engine\utility::flag("shadow_head_attached")) {
    level._id_EA2C detach("head_hero_xo_qss");
    level._id_EA2C attach(level._id_EA2C.headmodel);
  }

  _id_6A2A();
  _id_6A3D();
  _id_6A2E();
}

_id_CAD9() {
  wait 1.0;
  setmusicstate("mx_080_parade_reveal");
}

_id_6A2A() {
  var_0 = getEntArray("lake_vista_aatis_guns", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1511);
  thread _id_6A29();
  _id_C5F7();
  thread _id_6A2B();
}

_id_C5F7() {
  scripts\engine\utility::flag_set("exterior_opened");
  thread _id_CD0C();
  _id_15AE();
  level.player freezecontrols(0);
  _id_CD0B();
}

_id_15AE() {
  var_0 = scripts\engine\utility::getStruct("exteriordoor_animnode", "targetname");
  var_1 = "open_exterior_door";
  level._id_D267 = _id_7BBB(var_0, var_1);
  _id_BC56(level._id_D267, 0.5, 0);
  level._id_D267 show();
}

_id_CD0B() {
  scripts\engine\utility::flag_init("salter_door_anim_complete");
  thread _id_CDCC();
  thread _id_CDF7();
  thread _id_CCE1();
  scripts\engine\utility::flag_wait("salter_door_anim_complete");
}

_id_CDCC() {
  var_0 = scripts\engine\utility::getStruct("exteriordoor_animnode", "targetname");
  var_0 scripts\sp\anim::_id_1F35(level._id_D267, "open_exterior_door");
  level.player unlink();
  level._id_D267 delete();
}

_id_CDF7() {
  level._id_EA2C _id_0EE5::_id_10FC4();
  level._id_EA2C _id_0B6A::_id_EC04();
  level._id_EA2C thread scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_AB77(1.05, 0.1);
  level._id_EA2C._id_136FA = 0;
  var_0 = scripts\engine\utility::getStruct("exteriordoor_animnode", "targetname");
  level._id_EA2C scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_DB85("open_exterior_door", undefined, undefined, undefined, "exteriordoor_smoothexit_complete");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_EA2C, "open_exterior_door");
  level._id_EA2C waittill("exteriordoor_smoothexit_complete");
  scripts\engine\utility::flag_set("salter_door_anim_complete");
}

_id_6DE6() {
  var_0 = getEnt("exteriordoor_left", "targetname");
  var_1 = getEnt("exteriordoor_right", "targetname");
  var_0 scripts\sp\utility::_id_23B7("exterior_door_left");
  var_1 scripts\sp\utility::_id_23B7("exterior_door_right");
  var_2 = scripts\engine\utility::getStruct("exteriordoor_animnode", "targetname");
  var_2 thread scripts\sp\anim::_id_1EC3(var_0, "open_exterior_door");
  var_2 thread scripts\sp\anim::_id_1EC3(var_1, "open_exterior_door");
}

_id_CCE1() {
  var_0 = getEnt("exteriordoor_left", "targetname");
  var_1 = getEnt("exteriordoor_right", "targetname");
  var_0 scripts\sp\utility::_id_23B7("exterior_door_left");
  var_1 scripts\sp\utility::_id_23B7("exterior_door_right");
  var_2 = scripts\engine\utility::getStruct("exteriordoor_animnode", "targetname");
  var_2 thread scripts\sp\anim::_id_1F35(var_0, "open_exterior_door");
  var_2 thread scripts\sp\anim::_id_1F35(var_1, "open_exterior_door");
}

_id_CD0C() {
  level.player _meth_82C0("phparade_UNHQ_hallway", 0.0);
  level.player scripts\engine\utility::delaycall(1.0, ::_meth_82C0, "phparade_UNHQ_balcony_intro", 0.8);
  var_0 = getEnt("foyer_left_door", "targetname");
  wait 0.2;
  wait 0.2;
  level.player playSound("phparade_crowd_dist_cheer");
  wait 0.6;
  level.player playSound("phparade_grp_cheer4");
  thread _id_B05C();
  thread _id_B05D();
  wait 10.0;
  level.player clearclienttriggeraudiozone(10.0);
}

_id_B05D() {
  var_0 = level.player scripts\engine\utility::spawn_script_origin();
  var_0 linkTo(level.player);
  var_0 playLoopSound("phparade_balcony_ext_crowd_lr");
  scripts\engine\utility::flag_wait("player_passed_checkpoint");
  var_0 unlink();
}

_id_B05C() {
  var_0 = [];
  var_0[var_0.size] = "phparade_crd_cheer1";
  var_0[var_0.size] = "phparade_crd_cheer2";
  var_0[var_0.size] = "phparade_crd_cheer3";
  var_0[var_0.size] = "phparade_crd_cheer4";
  var_0[var_0.size] = "phparade_grp_cheer1";
  var_0[var_0.size] = "phparade_grp_cheer2";
  var_0[var_0.size] = "phparade_grp_cheer3";
  var_0[var_0.size] = "phparade_grp_cheer4";
  var_1 = "";

  for(;;) {
    var_2 = _id_78F4();

    if(isDefined(var_2)) {
      var_3 = var_0[randomint(var_0.size)];

      if(var_3 != var_1) {
        var_1 = var_3;
        var_2 playSound(var_3);
        var_4 = lookupsoundlength(var_3) / 1000;
        wait(var_4);
        wait(randomfloatrange(1.2, 6));
        var_2 delete();
      }

      continue;
    }

    wait 0.25;
  }
}

_id_78F4(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 800;
  }

  var_1 = scripts\engine\utility::getStructArray("parade_crowd_sound_system", "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    if(distance2d(level.player.origin, var_4.origin) <= var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  if(var_2.size > 0) {
    var_6 = randomint(var_2.size);
    var_7 = var_2[var_6] scripts\engine\utility::spawn_script_origin();
    return var_7;
  } else
    return undefined;
}

_id_CCD2(var_0) {
  var_1 = _id_78F4();

  if(isDefined(var_1)) {
    var_1 playSound(var_0);
    var_2 = lookupsoundlength(var_0) / 1000;
    wait(var_2);
    var_1 delete();
  }
}

_id_6A2B() {
  scripts\engine\utility::flag_init("exterior_balcony_vo_finished");
  wait 0.5;
  level.player playSound("phparade_crowd_dist_cheer");
  wait 0.5;
  wait 5;
  scripts\engine\utility::flag_set("exterior_balcony_vo_finished");
}

_id_6A29() {
  wait 5;
  var_0 = scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_780D("vo_guy_hellyeah");

  if(isDefined(var_0) && distance2d(level.player.origin, var_0.origin) < 700) {
    var_0 scripts\sp\utility::_id_10347("phparade_unfw_hellyeah");
  }

  wait 3.5;
  var_1 = scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_780D("vo_guy_wow");

  if(isDefined(var_1) && distance2d(level.player.origin, var_1.origin) < 700) {
    var_1 scripts\sp\utility::_id_10347("phparade_unfw_wow");
  }

  wait 3;
  var_2 = scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_780D("vo_guy_threedeployments");

  if(isDefined(var_2) && distance2d(level.player.origin, var_2.origin) < 700) {
    var_2 scripts\sp\utility::_id_10347("phparade_unw_didthreedeployment");
  }

  wait 1.5;
  var_3 = scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_780D("vo_guy_unsababy");

  if(isDefined(var_3) && distance2d(level.player.origin, var_3.origin) < 700) {
    var_3 scripts\sp\utility::_id_10347("phparade_unw_unsababy");
  }
}

_id_6A3D() {
  thread _id_6A3E();
  var_0 = _id_7CF4();
  level._id_EA2C scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_721D(var_0);
}

_id_1380F(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 300;
  }

  var_1 = scripts\engine\utility::getStruct("checkpointscene_animnode", "targetname");

  for(;;) {
    if(distance2d(self.origin, level.player.origin) > var_0) {
      if(distance2d(level.player.origin, var_1.origin) < distance2d(self.origin, var_1.origin)) {
        break;
      }
    } else
      break;

    scripts\engine\utility::waitframe();
  }
}

_id_6A3E() {
  scripts\engine\utility::flag_wait("exterior_balcony_vo_finished");
  scripts\engine\utility::delaythread(4, scripts\engine\utility::play_sound_in_space, "phparade_crowd_dist_cheer", (-23253, -17800, -26332));
  level._id_EA2C _id_1380F(300);

  if(isDefined(level._id_E35D)) {
    level._id_EA2C scripts\sp\utility::_id_7799(level._id_E35D);
  }

  level._id_EA2C scripts\sp\utility::_id_10346("phparade_slt_homesweethome");
  level._id_EA2C scripts\engine\utility::delaythread(1.5, scripts\sp\utility::_id_77B9, 0.7);
  level.player scripts\sp\utility::_id_1034D("phparade_plr_wevebeenongroun");
  level._id_EA2C scripts\sp\utility::_id_7798(level.player);
  level._id_EA2C scripts\sp\utility::_id_13861("on", level.player, "right");
  level._id_EA2C scripts\sp\utility::_id_10346("phparade_slt_youknowimmoreco");
  level.player scripts\sp\utility::_id_1034D("phparade_plr_youandmeboth");
  level._id_EA2C scripts\sp\utility::_id_13861("off", level.player, "right");
  level._id_EA2C scripts\sp\utility::_id_7793(1);
  thread _id_CC9F();
  level._id_EA2C _id_1380F(300);
  wait 1;
  level._id_EA2C scripts\sp\utility::_id_7798(level.player);
  level.player scripts\sp\utility::_id_1034D("phparade_plr_rainesmentioned");
  level._id_EA2C scripts\sp\utility::_id_13861("on", level.player, "right");
  level._id_EA2C scripts\sp\utility::_id_10346("phparade_slt_negativerainman");
  level._id_EA2C scripts\sp\utility::_id_13861("off", level.player, "right");
  level.player scripts\sp\utility::_id_1034D("phparade_plr_hesflyintothece");
  level._id_EA2C scripts\sp\utility::_id_10346("phparade_slt_nevertohisface");
  level._id_EA2C scripts\sp\utility::_id_7793(1);
}

_id_CC9F() {
  thread _id_6A3B();
  level.player playSound("phparade_anc_andnowfreshoutofsky");
  wait(lookupsoundlength("phparade_anc_andnowfreshoutofsky") / 1000 - 0.75);
  level.player playSound("phparade_crowd_dist_cheer");
  wait 2;
  level.player playSound("phparade_anc_helmedbycaptained");
  wait(lookupsoundlength("phparade_anc_helmedbycaptained") / 1000);
  level.player playSound("phparade_crowd_dist_cheer");
}

_id_6A3B() {
  wait 7;
  var_0 = scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_780D("vo_guy_atlanticcheer");

  if(isDefined(var_0)) {
    var_0 scripts\sp\utility::_id_10347("phparade_grp_cheeringatlantic");
  }

  wait 2;
  var_1 = scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_780D("vo_guy_thatsawesome");

  if(isDefined(var_1)) {
    var_1 scripts\sp\utility::_id_10347("phparade_unw_thatsawesome");
  }
}

_id_7CF4() {
  var_0 = [];
  var_0[var_0.size] = "salter_exterior_terrace_wait1";
  var_0[var_0.size] = "salter_exterior_terrace_wait2";
  var_0[var_0.size] = "salter_exterior_terrace_wait3";
  var_0[var_0.size] = "salter_exterior_terrace_wait4";
  var_0[var_0.size] = "salter_exterior_terrace_wait5";
  var_0[var_0.size] = "salter_exterior_terrace_wait6";
  var_0[var_0.size] = "salter_exterior_terrace_wait7";
  var_0[var_0.size] = "salter_exterior_terrace_wait9";
  return var_0;
}

_id_3E40() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_checkpoint");
  var_0 = ["salter"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_checkpoint", var_0);
  level.allies["salter"] scripts\sp\utility::_id_86E4();
  level._id_EA2C = level.allies["salter"];
  _id_ADB5();
}

_id_6A2E() {
  scripts\engine\utility::flag_init("salter_checkpoint_anim_complete");
  thread _id_DB6C(level._id_EA2C);
  thread _id_DB6C(level.player);
  thread _id_B95C();
  thread _id_DB6B();
  var_0 = _id_78A2();

  if(var_0 == "fast") {
    _id_CD0E();
  } else {
    _id_CE12();
  }

  scripts\engine\utility::flag_wait("salter_checkpoint_anim_complete");
}

_id_78A2() {
  return "fast";
}

_id_CD0E() {
  thread _id_DB70();
  var_0 = scripts\engine\utility::getStruct("checkpointscene_animnode", "targetname");
  var_1 = scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_7B74(var_0, level._id_EA2C, "checkpoint_open");
  level._id_EA2C scripts\engine\utility::delaycall(0.1, ::_meth_8250, 1);
  level._id_EA2C _id_0B6A::_id_EC0A(var_1);
  var_1 delete();
  _id_DFD6();
  _id_CDF4();
}

_id_DB70() {
  var_0 = scripts\engine\utility::getStruct("checkpointscene_animnode", "targetname");
  var_1 = scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_7B74(var_0, level._id_EA2C, "checkpoint_open");
  level._id_EA2C scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_1375D(var_1, 180);
  var_1 delete();
  thread _id_CCCF();
  wait 2;
  level._id_EA2C scripts\sp\utility::_id_10346("phparade_slt_makeahole");
}

_id_CE12() {
  var_0 = scripts\engine\utility::getStruct("checkpointscene_animnode", "targetname");
  var_0 scripts\sp\anim::_id_1F17(level._id_EA2C, "checkpoint_intro");
  level._id_EA2C._id_136FA = 1;
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "checkpoint_intro");

  if(distance2d(level.player.origin, level._id_EA2C.origin) > 128) {
    var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "checkpoint_idle", "salter_end_idle");
    thread _id_DB84();
    level._id_EA2C _id_135F9(128);
    level._id_EA2C scripts\sp\interaction_manager::_id_11037();
    var_0 notify("salter_end_idle");
  }

  thread _id_CCCF();
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "checkpoint_open_intro");
  _id_DFD6();
  _id_CDF4();
}

_id_DB84() {
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("phparade_slt_comeonreyesdont");
  level._id_EA2C scripts\sp\interaction_manager::_id_E815(20);
}

_id_CDF4() {
  var_0 = scripts\engine\utility::getStruct("checkpointscene_animnode", "targetname");
  var_1 = scripts\engine\utility::getStruct("salter_rooftop_balcony_wait2", "targetname");
  level._id_EA2C scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_DB85("checkpoint_open", 64, 0.75, var_1);
  var_0 thread scripts\sp\anim::_id_1F35(level._id_EA2C, "checkpoint_open");
  level._id_EA2C waittill("smooth_anim_exit_complete");
  scripts\engine\utility::flag_set("salter_checkpoint_anim_complete");
}

_id_CCCF() {
  var_0 = scripts\engine\utility::getStruct("checkpointscene_animnode", "targetname");
  var_0 notify("end_checkpoint_idle");

  foreach(var_2 in level._id_3E36) {
    var_2 thread _id_CCD1(var_0);
  }

  scripts\engine\utility::flag_set("checkpoint_open");
}

_id_CCD1(var_0) {
  var_0 scripts\sp\anim::_id_1F35(self, "checkpoint_open");
  var_0 scripts\sp\anim::_id_1EEA(self, "checkpoint_open_idle", "end_checkpoint_open_idle");
}

_id_CCCE() {
  var_0 = scripts\engine\utility::getStruct("checkpointscene_animnode", "targetname");
  var_0 notify("end_checkpoint_open_idle");

  foreach(var_2 in level._id_3E36) {
    var_2 thread _id_CCD0(var_0);
  }
}

_id_CCD0(var_0) {
  var_0 notify("end_checkpoint_open_idle");
  var_0 scripts\sp\anim::_id_1F35(self, "checkpoint_close");
  var_0 scripts\sp\anim::_id_1EEA(self, "checkpoint_idle", "end_loop");
}

_id_DB6C(var_0) {
  var_1 = getEnt("checkpoint_fx_trigger", "targetname");

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(var_2 == var_0) {
      _id_CCC5();
      break;
    }
  }
}

_id_CCC5() {
  var_0 = scripts\engine\utility::getStruct("checkpoint_vfx_position", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  playFXOnTag(scripts\engine\utility::getfx("security_scan"), var_1, "tag_origin");
  playworldsound("phparade_metal_detector_beep", var_0.origin);
  wait 10;
  var_1 delete();
}

_id_135F9(var_0) {
  while(distance2d(level.player.origin, self.origin) > var_0) {
    scripts\engine\utility::waitframe();
  }
}

_id_ADB5() {
  var_0 = [];
  var_0["checkpoint_guard_1"] = ::scripts\sp\utility::_id_107EA("checkpoint_guard_0", 1);
  var_0["checkpoint_guard_2"] = ::scripts\sp\utility::_id_107EA("checkpoint_guard_1", 1);
  scripts\engine\utility::waitframe();
  var_0["checkpoint_crowd_1"] = ::scripts\sp\utility::_id_107EA("checkpoint_guy_0", 1);
  var_0["checkpoint_crowd_2"] = ::scripts\sp\utility::_id_107EA("checkpoint_guy_1", 1);
  var_0["checkpoint_crowd_3"] = ::scripts\sp\utility::_id_107EA("checkpoint_guy_2", 1);
  var_0["checkpoint_crowd_4"] = ::scripts\sp\utility::_id_107EA("checkpoint_guy_3", 1);
  var_0["checkpoint_guard_1"]._id_1FBB = "checkpoint_guard_1";
  var_0["checkpoint_guard_2"]._id_1FBB = "checkpoint_guard_2";
  var_0["checkpoint_crowd_1"]._id_1FBB = "checkpoint_crowd_1";
  var_0["checkpoint_crowd_2"]._id_1FBB = "checkpoint_crowd_2";
  var_0["checkpoint_crowd_3"]._id_1FBB = "checkpoint_crowd_3";
  var_0["checkpoint_crowd_4"]._id_1FBB = "checkpoint_crowd_4";
  var_0["checkpoint_guard_1"]._id_6B14 = 1;
  var_0["checkpoint_guard_2"]._id_6B14 = 1;
  var_0["checkpoint_crowd_1"]._id_6B14 = 1;
  var_0["checkpoint_crowd_2"]._id_6B14 = 1;
  var_0["checkpoint_crowd_3"]._id_6B14 = 1;
  var_0["checkpoint_crowd_4"]._id_6B14 = 1;
  level._id_3E36 = var_0;
  var_1 = scripts\engine\utility::getStruct("checkpointscene_animnode", "targetname");

  foreach(var_3 in level._id_3E36) {
    if(!scripts\engine\utility::flag("checkpoint_open")) {
      var_1 thread scripts\sp\anim::_id_1EEA(var_3, "checkpoint_idle", "end_checkpoint_idle");
      continue;
    }

    var_1 thread scripts\sp\anim::_id_1EEA(var_3, "checkpoint_open_idle", "end_checkpoint_open_idle");
  }
}

_id_78A1() {
  var_0 = [];
  var_0["checkpoint_guard_0"] = getspawner("checkpoint_guard_0", "targetname");
  var_0["checkpoint_guard_1"] = getspawner("checkpoint_guard_1", "targetname");
  var_0["checkpoint_guy_0"] = getspawner("checkpoint_guy_0", "targetname");
  var_0["checkpoint_guy_1"] = getspawner("checkpoint_guy_1", "targetname");
  var_0["checkpoint_guy_2"] = getspawner("checkpoint_guy_2", "targetname");
  var_0["checkpoint_guy_3"] = getspawner("checkpoint_guy_3", "targetname");
  return var_0;
}

_id_93F6(var_0) {
  foreach(var_2 in var_0) {
    var_2.count++;
  }
}

_id_DFD6() {
  var_0 = getEnt("checkpoint_player_clipbrush1", "targetname");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_16AD() {
  var_0 = getEnt("checkpoint_player_clipbrush2", "targetname");

  if(isDefined(var_0)) {
    var_0 moveTo(var_0.origin + (0, 0, -96), 0.05);
  }
}

_id_DB6B() {
  scripts\engine\utility::flag_wait("player_passed_checkpoint");
  _id_16AD();
  thread _id_CCCE();
  scripts\engine\utility::flag_clear("checkpoint_open");
}

_id_B95C() {
  scripts\engine\utility::flag_wait("player_passed_checkpoint");
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_407C();
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_4079();
  thread _id_B9A8();
  thread scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_E68C();
}

_id_4060() {
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_EA08(level._id_3E36);
}

_id_CDA6() {}

_id_11023() {}

_id_C345() {
  thread _id_C346();
}

_id_C346() {}

_id_E6B1() {
  setsaveddvar("sm_sunSampleSizeNear", 0.6);
  thread _id_E6CF();
  thread _id_EA86();
  scripts\engine\utility::flag_wait("roof_second_stop");
  thread scripts\sp\utility::_id_2669("passed_parade_checkpoint");
  _id_ADE2();
}

_id_B9A8() {
  for(;;) {
    scripts\engine\utility::flag_wait("terrace_ambient_off");
    scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_407D();
    scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_407A();
    _id_4060();
    scripts\engine\utility::flag_wait("terrace_ambient_on");
    scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_4078();
    scripts\engine\utility::waitframe();
    scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_ADCD();
    scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_ADCA();
    _id_ADB5();
  }
}

_id_FB7A() {
  scripts\engine\utility::delaythread(5.8, scripts\engine\utility::play_sound_in_space, "scn_phparade_dropship_land", (-20345, -22011, -26983));
  wait 9;
  level._id_D03A thread _id_FB76();
}

_id_FB76() {
  var_0 = 0.6;

  if(!isDefined(self._id_5DAF)) {
    self._id_5DAF = spawn("script_origin", (-20898, -21883, -27017));
  }

  wait 0.05;
  self._id_5DAF scripts\sp\utility::_id_10461("dropship_lz_debris_lp", var_0, 1, 1);
  wait 6.5;
  self._id_5DAF _meth_8278(0, 2);
  wait 2;
  self._id_5DAF delete();
}

_id_ADE2() {
  scripts\engine\utility::flag_wait("roof_second_stop");
  level._id_D03A = _id_0BBF::_id_106B8("parade_dropship_heli");
  level._id_D03A thread _id_0BBF::_id_F454(1, "int", "phparade");
  level._id_D03A _id_0BBF::_id_1101E();
  level._id_D03A._id_1FBB = "dropship";
  level._id_D03A thread _id_5E2C();
  thread _id_9850();
  var_0 = scripts\engine\utility::getStruct("dropship_landing_animnode", "targetname");
  thread _id_FB7A();
  var_0 scripts\sp\anim::_id_1F35(level._id_D03A, "dropship_landing");
  level._id_D03A _id_0BBE::_id_1104F();
  var_1 = scripts\engine\utility::play_loopsound_in_space("phparade_dropship_warmup", level._id_D03A.origin);
  var_1 linkTo(level._id_D03A);
}

_id_5E2C() {
  scripts\sp\utility::_id_65DD("thrusterEffects");
  wait 0.25;
  _id_0BBE::_id_CE62("back", "low");
  _id_0BBE::_id_CE62("side_back", "low");
  level waittill("dropship_side_thrusters_on");
  _id_0BBE::_id_CE62("side_front", "low");
  level waittill("dropship_side_thrusters_off");
  self._id_11865 = "low";
  _id_0BBE::_id_1104F("side_front");
  _id_0BBE::_id_1104F("back");
  _id_0BBE::_id_1104F("side_back");
}

_id_137FA(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 300;
  }

  var_1 = scripts\engine\utility::getStruct("salter_rooftop_landingzone_wait3", "targetname");

  for(;;) {
    if(distance2d(self.origin, level.player.origin) > var_0) {
      if(distance2d(level.player.origin, var_1.origin) < distance2d(self.origin, var_1.origin)) {
        break;
      }
    } else
      break;

    scripts\engine\utility::waitframe();
  }
}

_id_E6CF() {
  scripts\engine\utility::flag_wait("roof_second_stop");
  thread _id_E68D();
  level.player playSound("phparade_anc_comingupistheec");
  wait(lookupsoundlength("phparade_anc_comingupistheec") / 1000 - 0.75);
  level.player playSound("phparade_crowd_dist_cheer");
  wait 2.5;
  level.player playSound("phparade_pmc_theeclipseisazu");
  wait(lookupsoundlength("phparade_pmc_theeclipseisazu") / 1000 - 0.75);
  level.player playSound("phparade_crowd_dist_cheer");
  wait 2;
  level._id_EA2C _id_137FA(300);

  if(distance2d(level.player.origin, level._id_D03A.origin) > 800) {
    level._id_EA2C scripts\sp\utility::_id_13861("on", level.player, "left");
    level._id_EA2C scripts\sp\utility::_id_7798(level.player, 2, 1);
    level.player scripts\sp\utility::_id_1034D("phparade_slt_listentoemthey");
    level._id_EA2C scripts\sp\utility::_id_7793(1);
    level._id_EA2C scripts\sp\utility::_id_13861("off", level.player, "left");
    level._id_EA2C scripts\sp\utility::_id_10346("phparade_plr_heartsandmindss");
    level.player scripts\sp\utility::_id_1034D("phparade_slt_itspropaganda");
    level._id_EA2C scripts\sp\utility::_id_13861("on", level.player, "left");
    level._id_EA2C scripts\sp\utility::_id_7798(level.player, 2, 1);
    level.player scripts\sp\utility::_id_1034D("phparade_slt_twopilotsaredea");
    level._id_EA2C scripts\sp\utility::_id_7793(1);
    level._id_EA2C scripts\sp\utility::_id_13861("off", level.player, "left");
    level._id_EA2C scripts\sp\utility::_id_10346("phparade_plr_ourhandsaretied");
    level._id_EA2C _id_137FA(300);
    wait 0.66;

    if(distance2d(level.player.origin, level._id_D03A.origin) > 800) {
      level._id_EA2C scripts\sp\utility::_id_7798(level.player, 2, 1);
      level._id_EA2C scripts\sp\utility::_id_10346("phparade_plr_tryandenjoyyour");
      level._id_EA2C scripts\sp\utility::_id_13861("on", level.player, "left");
      level.player scripts\sp\utility::_id_1034D("phparade_slt_yeahandhowmuchy");
      wait 0.1;
      level._id_EA2C scripts\sp\utility::_id_7793(1);
      level._id_EA2C scripts\sp\utility::_id_13861("off", level.player, "left");
      level._id_EA2C scripts\sp\utility::_id_10346("phparade_slt_gotmetheresir");
    }
  }

  scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_11015();
  thread _id_45AA();
}

_id_E68D() {
  wait 4;
  var_0 = scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_780D("vo_guy_badass");

  if(isDefined(var_0)) {
    var_0 scripts\sp\utility::_id_10347("phparade_unw_badass");
  }
}

_id_45AA() {
  wait 3;
  level.player._id_1FFF = level.player scripts\engine\utility::spawn_tag_origin();
  level.player._id_1FFF linkTo(level.player);
  level.player._id_1FFF _meth_8278(0.66, 0);
  level.player._id_1FFF playSound("phparade_anc_thatsthetunguskaone");
  wait(lookupsoundlength("phparade_anc_thatsthetunguskaone") / 1000 - 0.75);
  level.player playSound("phparade_crowd_dist_cheer");
  wait 8;
  level.player._id_1FFF playSound("phparade_anc_cominupnextwehave");
  wait(lookupsoundlength("phparade_anc_cominupnextwehave") / 1000 - 0.75);
  level.player playSound("phparade_crowd_dist_cheer");
  wait 1;
  _id_CCD2("phparade_unfw_yeahorion");
  wait 3;
  _id_CCD2("phparade_unw_crazy");
}

_id_EA86() {
  level endon("dropship_entrance_started");
  level._id_EA2C._id_1359F = "left";
  var_0 = [];
  var_0[var_0.size] = "salter_rooftop_balcony_wait2";
  var_0[var_0.size] = "salter_rooftop_balcony_wait4";
  var_0[var_0.size] = "salter_rooftop_landingzone_wait1";
  var_0[var_0.size] = "salter_rooftop_landingzone_wait1B";
  var_0[var_0.size] = "salter_rooftop_landingzone_wait2";
  level._id_EA2C scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_721D(var_0);
  level._id_EA2C._blackboard.disablestairsexits = 1;
  level._id_EA2C _id_0B6A::_id_EC0B("salter_rooftop_landingzone_wait3", "shipcrib_stand_stationary_talk_idle_03", undefined, undefined, undefined, undefined, undefined, 1);
  level._id_EA2C _id_0EE5::_id_202D(3, "phparade_slt_letsgetairborne");
}

_id_DB6E() {
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("phparade_slt_letsgetairborne");
  level._id_EA2C scripts\sp\interaction_manager::_id_E815(20.0);
}

_id_40B7() {
  thread _id_11023();
}

_id_E691() {
  thread _id_40B7();
}

_id_5DD2() {
  _id_9857();
  var_0 = 0;

  if(var_0) {
    while(!isDefined(level._id_D03A)) {
      wait 0.1;
    }
  } else
    _id_48D5();

  level notify("dropship_entrance_started");
  thread _id_5E38();
  scripts\engine\utility::delaythread(3, scripts\sp\utility::dyndof);
  thread _id_D906();
  scripts\engine\utility::noself_delaycall(5.35, ::playrumbleonposition, "slide_start", level.allies["eth3n"].origin);
  scripts\engine\utility::flag_set("parade_player_in_dropship");
  level._id_EA2C _id_0EE5::_id_10FC4();
  level._id_EA2C scripts\sp\interaction_manager::_id_11037();
  scripts\sp\maps\pearlharbor\pearlharbor_office_util::_id_E692();
  scripts\sp\maps\pearlharbor\pearlharbor_office_ambient::_id_ADC8();
  thread _id_DB86();
  thread _id_DB5F();
  _id_556A();
  _id_15AA();
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_CEREMONY_TRANSPORT"));
  setsaveddvar("cg_drawplayershadow", 0);
  thread _id_259A();
  thread _id_E80E();
  thread _id_5DC4();
  _id_CCF1();
  scripts\engine\utility::flag_wait("dropship_entrance_anims_complete");
  _id_ACFE();
  level._id_D267 linkTo(level._id_D03A);
  thread _id_259B();
  level._id_D03A notify("stop_kicking_up_dust");
  level._id_D03A notify("kill_treads_forever");
  level._id_D03A notify("stop_thrusters_on_off");
  level._id_D03A scripts\sp\utility::_id_65DD("dynamicThrusters");
  level._id_D03A thread _id_0BBC::_id_5DC2();
  var_1 = getvehiclenode("parade_dropship_pathstart", "targetname");
  level._id_D03A scripts\sp\vehicle::_id_2470(var_1);
  level._id_D03A thread scripts\sp\vehicle_paths::_id_845A();
  level._id_D03A scripts\engine\utility::delaythread(1, _id_0BBF::_id_F4B4, "straps", "heavy");
  var_2 = [level.allies["salter"], level.allies["admiral"], level.allies["eth3n"]];
  var_3 = level._id_D03A;
  level waittill("dropship_radio_chatter_done");
  var_3 notify("stop_dropship_idles");
  var_3 thread scripts\sp\anim::_id_1F2C(var_2, "flyover");
  wait 25.8;
  setsaveddvar("r_umbraMinObjectContribution", 20);
  wait 0.05;
  scripts\engine\utility::array_thread(var_2, scripts\sp\utility::anim_stopanimscripted);
  level.player notify("cutscene");
  thread _id_259C();
  thread _id_CAD6();
  scripts\sp\utility::_id_BF95();
}

_id_D1DD() {
  wait 5.5;
  level.player lerpviewangleclamp(2.25, 0.5, 0.5, 3, 10, 5, 5);
}

_id_5DC4() {
  scripts\engine\utility::flag_wait("dropship_takeoff");
  wait 1.5;
  level.player playRumbleOnEntity("damage_light");
  wait 0.5;
  stopallrumbles();
  scripts\engine\utility::waitframe();
  var_0 = spawn("script_origin", level._id_D03A.origin + (0, 0, -400));
  var_0 linkTo(level._id_D03A);
  var_0 _meth_8244("tank_rumble");
  var_1 = gettime() + 1000;
  var_2 = spawn("script_origin", level.player.origin + (0, 0, 0));
  var_2 linkTo(level.player);
  var_3 = 0.12;
  var_4 = 0.15;
  var_5 = 200;
  var_6 = 400;

  for(;;) {
    if(gettime() > var_1) {
      var_1 = gettime() + randomintrange(500, 3000);
      var_7 = 1;
      var_8 = randomfloatrange(var_3, var_4);
      earthquake(var_8, var_7 + 3, level._id_D03A.origin, 5000);
      var_2 dontinterpolate();
      var_2 unlink();
      var_9 = 1 - (var_8 - var_3) / (var_4 - var_3);
      var_10 = (var_5 + (var_6 - var_5) * var_9) * -1;
      var_2.origin = level.player.origin + (0, 0, var_10);
      var_2 linkTo(level.player);
      var_2 playRumbleOnEntity("heavy_1s");
    } else {
      var_7 = 0.2;
      earthquake(0.1, var_7 + 3, level._id_D03A.origin, 5000);
    }

    wait(var_7 - 0.05);
  }
}

_id_D906() {}

_id_CAD6() {}

_id_E80E(var_0) {
  scripts\sp\utility::_id_1264E("phparade_base_tr");
  wait 0.5;
  thread scripts\sp\utility::_id_BF97();
}

_id_259A() {
  wait 3.8;
  level.player _meth_82C0("phparade_UNHQ_dropship_filtered_helipad", 1.2);
}

_id_259B() {
  level.player _meth_82C0("phparade_UNHQ_dropship_int_window", 6.0);
}

_id_259C() {
  level.player _meth_82C0("phparade_ending_bink", 0.3);
}

_id_9857() {
  level.allies["eth3n"].name = "";
}

_id_9850() {
  level._id_5E5D = scripts\sp\utility::_id_107EA("dropship_pilot_spawner");
  level._id_5E5D._id_1FBB = "pilot";
  level._id_5E5D scripts\sp\utility::_id_86E4();
  level._id_5E5D linkTo(level._id_D03A);
}

_id_984F() {}

_id_48D5() {
  while(!isDefined(level._id_D03A)) {
    wait 0.1;
  }

  var_0 = scripts\engine\utility::spawn_tag_origin(level._id_D03A gettagorigin("TAG_DOOR_RIGHT_HANDLE"), level._id_D03A gettagangles("TAG_DOOR_RIGHT_HANDLE"));
  wait 0.05;
  var_0 _id_0E46::_id_48C4("tag_origin", undefined, undefined, undefined, 750, 150, 1);
  var_0 waittill("trigger");
  level.player playSound("scn_phparade_dropship_moveto_door");
}

_id_5E38() {
  visionsetnaked("phparade_dropship", 4);
  setsaveddvar("scr_dof_enable", "1");
  setsaveddvar("r_spotLightEntityShadows", "1");
  setsaveddvar("r_dof_hq", "1");
  thread _id_0B0A::_id_583F(0, 0, 0, 26, 490, 2.3, 2.5);
  level._id_D03A thread _id_0BBF::_id_F454(1, "int", "phparadedoor");
  var_0 = level._id_D03A._id_4D94.lights["int"]["phparadedoor"];
  var_1 = var_0[0];
  scripts\engine\utility::flag_wait("parade_player_in_dropship");
  setsaveddvar("sm_sunSampleSizeNear", 0.56);
  var_2 = 5;
  var_3 = 850;

  if(!isDefined(var_1._id_DC62)) {
    var_1._id_DC62 = 0;
    var_1._id_93F1 = var_3 / (var_2 / 0.05);
  }

  for(var_4 = 0; var_4 < var_2; var_4 = var_4 + 0.05) {
    var_1._id_DC62 = var_1._id_DC62 + var_1._id_93F1;
    var_1._id_DC62 = clamp(var_1._id_DC62, 0, var_3);
    var_1 setlightintensity(var_1._id_DC62);
    scripts\engine\utility::waitframe();
  }
}

_id_556A() {
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
}

_id_15AA() {
  var_0 = level._id_D03A;
  var_1 = "rooftop";
  var_2 = [0, 0, 0, 0];
  level._id_D267 = _id_7BBB(var_0, "dropship_entrance");
  _id_BC56(level._id_D267, 0.5, var_2, 1);
  level._id_D267 show();
}

_id_7BBB(var_0, var_1) {
  var_2 = scripts\sp\utility::_id_10639("player_rig");
  var_2 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_2, var_1);
  return var_2;
}

_id_BC56(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 0.5;
  }

  if(!isDefined(var_2)) {
    var_2 = 15;
  } else if(!isarray(var_2)) {
    var_2 = [var_2, var_2, var_2, var_2];
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  level.player scripts\sp\utility::_id_F526("normal");
  level.player _meth_823C(var_0, "tag_player", var_1, var_1 / 2, var_1 / 2);
  wait(var_1);
  level.player _meth_823B(var_0, "tag_player");
}

_id_CCF1() {
  scripts\engine\utility::flag_init("dropship_entrance_anims_complete");
  thread _id_CDCA();
  thread _id_CC6F();
  thread _id_CCEC();
}

_id_CDCA() {
  var_0 = level._id_D03A;
  var_0 scripts\sp\anim::_id_1F35(level._id_D267, "dropship_entrance");
  level.player playerlinktodelta(level._id_D267, "tag_player", 1, 45, 15, 15, 15, 1);
}

#using_animtree("vehicles");

_id_CCEC() {
  level._id_D03A setanimknob(%ph_parade_1_11_raven_dropship);
  var_0 = getanimlength(%ph_parade_1_11_raven_dropship);
  wait(var_0 - 0.05);
  level._id_D03A _meth_82B1(%ph_parade_1_11_raven_dropship, 0);
}

_id_CC6F() {
  scripts\sp\anim::_id_17F6("eth3n", "vo_phparade_eth_callmeethan2", ::_id_6783, "dropship_entrance");
  level.allies["salter"] thread _id_CC69();
  level.allies["eth3n"] thread _id_CC69();
  level._id_5E5D thread _id_CC69();
  var_0 = getanimlength(level._id_EA2C scripts\sp\utility::_id_7DC1("dropship_entrance"));
  wait(var_0);
  scripts\engine\utility::flag_set("dropship_entrance_anims_complete");
}

_id_CC69() {
  level._id_D03A scripts\sp\anim::_id_1F35(self, "dropship_entrance");
  level._id_D03A scripts\sp\anim::_id_1EEA(self, "dropship_idle", "stop_dropship_idles");
}

_id_6783(var_0) {
  var_1 = lookupsoundlength("phparade_eth_callmeethan2") / 1000;
  wait(var_1);
  level.allies["eth3n"].name = "Ethan";
}

_id_DB5F() {
  level._id_188A = level.allies["admiral"];
  scripts\sp\anim::_id_17F6("eth3n", "start_admiral_ai", ::_id_CC72, "dropship_entrance");
  scripts\sp\anim::_id_17F6("eth3n", "start_admiral", ::_id_CC71, "dropship_entrance");
}

_id_CC72(var_0) {
  level._id_188A endon("dropship_anim_started");
  level._id_188A scripts\sp\utility::_id_86E4();
  level._id_188A scripts\sp\utility::_id_51E1("casual");
  level._id_188A _id_0B6A::_id_EC0D("admiral_spawnpoint");
  level._id_188A scripts\asm\asm::_id_237B(0.992);
  var_1 = scripts\engine\utility::getStruct("admiral_lookat_point", "targetname");
  level._id_188A scripts\sp\utility::_id_7799(var_1, 0.6, 1);
  level._id_188A scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_779B, level._id_EA2C, 1);
  level._id_188A scripts\engine\utility::delaythread(9, scripts\sp\utility::_id_779B, var_1, 1);
  level._id_188A scripts\engine\utility::delaythread(15, scripts\sp\utility::_id_77B9, 0.7);
  var_2 = gettime();
  level._id_D03A scripts\sp\anim::_id_1F0D(level._id_188A, "dropship_entrance");
  var_3 = (gettime() - var_2) / 1000;
}

_id_CC71(var_0) {
  level._id_188A scripts\sp\utility::_id_77B9(1);
  level._id_188A notify("dropship_anim_started");
  level._id_188A _id_CC69();
}

_id_DB86() {
  level.player scripts\engine\utility::delaycall(15, ::playsound, "scn_phparade_dropship_startup_lr");
  var_0 = getanimlength(level._id_EA2C scripts\sp\utility::_id_7DC1("dropship_entrance"));
  var_1 = var_0 - 3;
  wait(var_1);
  _id_CE50();
}

_id_CE50() {
  thread _id_CE51();
  setmusicstate("mx_081_parade_flight");
  level.player scripts\sp\utility::_id_10350("phparade_plt_zeusthisiskings");
  scripts\engine\utility::flag_set("dropship_takeoff");
  thread _id_FB7B();
  wait 2.5;
  level.player scripts\sp\utility::_id_10350("phparade_plt_sixtoredcrownwe");
  level.player scripts\sp\utility::_id_10350("phparade_rcr_rogersixcrowns");
  level.player scripts\sp\utility::_id_10350("phparade_plt_copyravensixtov");
  level.player scripts\sp\utility::_id_10350("phparade_vnv_copysixvengeanc");
}

_id_CE51() {
  wait 12.5;
  level notify("dropship_radio_chatter_done");
}

_id_FB7B() {
  level._id_D03A scripts\engine\utility::delaythread(0.7, scripts\sp\utility::play_sound_on_tag, "dropship_stairs_fold_up", "j_stairs_step_connector_ri");
  level.player scripts\engine\utility::delaycall(1.0, ::playsound, "scn_phparade_dropship_blastoff_swt");
  wait 2.3;
  level.player playSound("scn_phparade_dropship_blastoff_lr");
  wait 1.5;
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkTo(level.player);
  var_0 playLoopSound("scn_phparade_dropship_int_travel_lp_lr");
  level.player waittill("cutscene");
  var_0 scripts\sp\utility::_id_10460(1, 1);
}

_id_ACFE() {
  foreach(var_1 in level.allies) {
    var_1 linkTo(level._id_D03A);
  }
}

_id_5DD1() {}

_id_C33A() {
  self endon("death");
  var_0 = self.spawner;

  if(isDefined(var_0.animation)) {
    _id_F8AC(var_0);
  }

  if(isDefined(self.target)) {
    self waittill("reached_path_end");
  }

  var_1 = self._id_A905;

  if(isDefined(var_1) && isDefined(var_1.animation)) {
    var_1 thread scripts\sp\anim::_id_1ECC(self, var_1.animation);
  }

  scripts\engine\utility::flag_wait("ext_first_stop");
  self delete();
}

_id_C33B() {
  self endon("death");
  var_0 = self.spawner;
  self._id_1FBB = "generic";

  if(isDefined(var_0.animation)) {
    _id_F8AC(var_0);
  } else if(isDefined(self.target)) {
    var_1 = scripts\engine\utility::get_target_ent();

    if(isDefined(var_1.animation)) {
      var_1 scripts\sp\anim::_id_1F17(self, var_1.animation);
      var_1 thread scripts\sp\anim::_id_1EEA(self, var_1.animation);
    } else
      self setgoalpos(var_1.origin);
  }

  scripts\engine\utility::flag_wait("office_complete");
  self delete();
}

_id_F8AC(var_0) {
  if(isDefined(var_0.animation)) {
    if(isDefined(var_0.script_linkto)) {
      var_1 = scripts\engine\utility::getStruct(var_0.script_linkto, "script_linkname");
    } else {
      var_1 = var_0;
    }

    var_1 thread scripts\sp\anim::_id_1ECC(self, var_0.animation);
  }
}

_id_C34E() {
  var_0 = self.spawner;
  var_0 scripts\sp\anim::_id_1EC7(self, "shipcrib_deck_wave_02");
  thread scripts\sp\anim::_id_1ECC(self, "shipcrib_deck_crouch_repair_loop_01");
  scripts\engine\utility::flag_wait("parade_player_in_dropship");
  self delete();
}