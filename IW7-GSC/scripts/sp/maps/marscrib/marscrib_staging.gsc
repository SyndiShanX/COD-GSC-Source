/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marscrib\marscrib_staging.gsc
*********************************************************/

_id_10B47() {
  scripts\engine\utility::flag_init("in_conversation");
  scripts\engine\utility::flag_init("near_conversation");
  scripts\engine\utility::flag_init("used_terminal");
  scripts\engine\utility::flag_init("staging_area_exit");
  scripts\engine\utility::flag_init("staging_area_exit_ready");
  scripts\engine\utility::flag_init("mc_swap_dropship");
  scripts\engine\utility::flag_init("dropship_obj_cont");
  scripts\engine\utility::flag_init("dropship_obj_rev");
  scripts\engine\utility::flag_init("flag_dropship_reached");
}

_id_10B48() {
  precacheitem("iw7_gunless");
  precachemodel("hero_boost_pack");
  precachemodel("pack_prop_female");
  precachemodel("decor_vintage_book_marscrib");
  precachemodel("equipment_industrial_screwdriver_01");
  precachemodel("corpse_bodybag_02_dust");
  precachemodel("p7_desk_metal_military_03_tablet");
  precacheshader("dirt_gravel_mars_02_rvl");
  _id_0E88::main();
  _id_0EA3::main();
  _id_0E8C::main();
}

_id_AE0D() {
  scripts\sp\utility::_id_13705();
  level thread _id_0A2F::_id_12642();
}

_id_9ACC() {
  level.player _meth_80D1();
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_doublejump(0);
  level.player scripts\engine\utility::allow_mantle(0);
  level.player scripts\engine\utility::allow_weapon_switch(0);
  level.player scripts\sp\utility::_id_11428();
  level.player giveweapon("iw7_gunless");
  level.player switchtoweaponimmediate("iw7_gunless");
  level.player scripts\sp\utility::_id_F526("safe", 1);
}

_id_10D30() {}

_id_3B8C() {}

_id_B236() {
  level endon("sa_dropship_cleanup");
  level._id_21AD = 1;
  _id_9ACC();
  level thread scripts\sp\maps\marscrib\marscrib_util::_id_D21E();
  _id_10630(scripts\engine\utility::getStructArray("sa_anim_ambient_loop", "targetname"));
  _id_10740();
  _id_10741();
  _id_106FE();
  _id_952F();
  level._id_E97A = [];
  thread _id_9AB2();
  thread _id_9ABB();
  thread _id_2ADC();
  thread _id_223C();
  thread _id_B34D();
  thread _id_4457();
  thread _id_6F1B();
  thread _id_1270D();
  thread _id_2B95();
  thread _id_A055();
  thread _id_B516();
}

_id_B237() {
  level endon("sa_dropship_cleanup");
  thread _id_AE0D();
  _id_B236();
  _id_B396();
  scripts\sp\utility::_id_2669("main_staging_area");
  setmusicstate("mx_212_marscrib_explore");
  scripts\engine\utility::flag_wait("staging_area_exit_ready");
  _id_B38C();
}

_id_B396() {
  level endon("sa_dropship_cleanup");
  var_0 = scripts\engine\utility::getStruct("mc_anim_jumpdown", "targetname");
  var_1 = scripts\sp\utility::_id_10639("player_rig", (42944, -80448, -15104));
  var_1 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_1, "jump_down");
  level.player scripts\sp\utility::_id_F526("normal");
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_melee(0);
  level.player freezecontrols(1);
  level.player playerlinkTo(var_1, "tag_player");
  level.player _meth_823C(var_1, "tag_player", 0);
  level.player playerlinktodelta(var_1, "tag_player", 1, 0, 0, 0, 0, 1);
  var_0 scripts\sp\anim::_id_1F35(var_1, "jump_down");
  level.player unlink();
  var_1 delete();
  level.player scripts\sp\utility::_id_F526("safe", 1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_melee(1);
  level.player freezecontrols(0);
  scripts\sp\loadout::_id_F56D("marsbase");
}

_id_B38C() {
  level endon("sa_dropship_cleanup");
  scripts\engine\utility::getStruct("sa_hero_salter", "targetname") notify("stop_loop");
  level._id_EA2C delete();
  level._id_5E29 = scripts\sp\vehicle::_id_1080C("mc_veh_dropship_land");
  level._id_5E29._id_1FBB = "dropship";
  level._id_5E29 playSound("marscrib_dropship_land");
  level._id_5E29 scripts\sp\utility::_id_65DD("dynamicThrusters");
  level._id_5E29 scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_75C4, "allies_dropship_thrust_high", "tag_frontsidethrsuter_ri");
  level._id_5E29 scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_75C4, "allies_dropship_thrust_high", "tag_frontsidethruster_le");
  level._id_5E29 scripts\engine\utility::delaythread(1.2, scripts\sp\utility::_id_75F8, "allies_dropship_thrust_high", "tag_frontsidethrsuter_ri");
  level._id_5E29 scripts\engine\utility::delaythread(1.2, scripts\sp\utility::_id_75F8, "allies_dropship_thrust_high", "tag_frontsidethruster_le");
  var_0 = scripts\engine\utility::getStruct("mc_anim_loadout", "targetname");
  var_0 scripts\sp\anim::_id_1F35(level._id_5E29, "dropship_enter");
  level thread _id_5E54();
  var_1 = getEnt("mc_trig_swap_dropship", "targetname");
  var_1 scripts\engine\utility::trigger_on();

  while(isDefined(level._id_5E29)) {
    if(scripts\engine\utility::flag("mc_swap_dropship") && !level.player scripts\sp\utility::_id_3849(level._id_5E29.origin, 0)) {
      level._id_5E29 delete();
    }

    wait 0.1;
  }

  var_1 delete();
}

_id_5E54() {
  level endon("sa_dropship_cleanup");
  level endon("flag_dropship_reached");
  objective_add(scripts\sp\utility::_id_C264("dropship"), "current", &"MARSCRIB_OBJ_DROPSHIP");
  var_0 = getEntArray("trig_obj_dropship", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\engine\utility::trigger_on);
  level thread _id_5E55("dropship_obj_3", scripts\engine\utility::getStruct("obj_dropship_3", "targetname"), "dropship_obj_1", "dropship_obj_2");
  level thread _id_5E55("dropship_obj_2", scripts\engine\utility::getStruct("obj_dropship_2", "targetname"), "dropship_obj_1", "dropship_obj_3");
  level thread _id_5E55("dropship_obj_1", scripts\engine\utility::getStruct("obj_dropship_1", "targetname"), "dropship_obj_2", "dropship_obj_3");
  level thread dropship_objective_vr_proc();
}

_id_5E55(var_0, var_1, var_2, var_3) {
  level endon("sa_dropship_cleanup");
  level endon("flag_dropship_reached");

  for(;;) {
    scripts\engine\utility::flag_wait(var_0);
    objective_position(scripts\sp\utility::_id_C264("dropship"), var_1.origin);
    scripts\engine\utility::flag_wait_either(var_2, var_3);
  }
}

dropship_objective_vr_proc() {
  level endon("sa_dropship_cleanup");
  level endon("flag_dropship_reached");

  for(;;) {
    scripts\engine\utility::flag_wait("in_vr_mode");
    objective_state(scripts\sp\utility::_id_C264("dropship"), "active");
    scripts\engine\utility::flag_waitopen("in_vr_mode");
    objective_state(scripts\sp\utility::_id_C264("dropship"), "current");
  }
}

_id_B34D() {
  level endon("sa_dropship_cleanup");
  var_0 = scripts\sp\maps\marscrib\marscrib_util::_id_1065E();
  var_0._id_C6EA = scripts\engine\utility::getStruct("sa_hero_" + var_0._id_1FBB, "targetname");
  var_0._id_C6EA thread scripts\sp\anim::_id_1EEA(var_0, var_0._id_C6EA.animation, "stop_loop", undefined, undefined, "generic");
  var_1 = getEnt("mc_marines_intro_marine", "script_noteworthy");
  var_2 = getEnt("mc_marines_idle_marine", "script_noteworthy");
  var_3 = spawn("trigger_radius", var_0._id_C6EA.origin, 0, 500, 128);
  var_3 waittill("trigger");
  scripts\engine\utility::flag_set("near_conversation");
  var_0 scripts\sp\utility::_id_10346("marscrib_brk_getourfkvsloaded");
  var_1 _id_10345("marscrib_un3_huah", [var_0, 128], []);
  scripts\engine\utility::flag_clear("near_conversation");
  var_0._id_C6EA notify("stop_loop");
  var_0 thread scripts\sp\interaction::_id_CE18(var_0._id_C6EA._id_EE92, "marscrib_brk_mymenwereable", undefined, undefined, undefined, var_0._id_C6EA, undefined, 1.0);
  var_0 waittill("playing_interaction_scene");
  scripts\engine\utility::flag_set("in_conversation");
  wait 4;
  _id_FC57("marscrib_plr_welldonesergean", var_0, 192, 1, 0, 2);
  var_0 notify("stop_smart_reaction");
  var_0 notify("stop_reaction_look");
  var_0 scripts\sp\utility::_id_77B9(0.5);
  scripts\engine\utility::flag_clear("in_conversation");
  wait 1;
  var_0 _id_10345("marscrib_brk_whatstheplancom", [level.player, 300, 1], [150, 1], "in_conversation", "in_conversation");

  if(_id_FC57("marscrib_plr_airshipstotheel", var_0, 192, 1, 0, 2)) {
    var_0 _id_10345("marscrib_brk_rogerthat", [level.player, 300], [300, 1, 0, 2]);
  } else {
    var_0 notify("stop_reaction_look");
    var_0 scripts\sp\utility::_id_77B9(0.5);
  }

  scripts\engine\utility::flag_clear("in_conversation");
  wait 3;
  var_0 _id_10345("marscrib_brk_illseeyoudown", [level.player, 300], [150, 1], "in_conversation", ["in_conversation", "near_conversation"]);
  _id_FC57("marscrib_plr_countonit", var_0, 192, 1, 0, 2);
  scripts\engine\utility::flag_clear("in_conversation");
  wait 5;
  var_4 = ["marscrib_brk_sir", "marscrib_brk_captain", "marscrib_brk_captainreyes"];
  var_0 thread _id_B397(scripts\engine\utility::random(var_4), var_4, "in_conversation");
  var_2 thread _id_B397(scripts\engine\utility::random(level._id_92F0[var_2.gender]), level._id_92F0[var_2.gender], "near_conversation");
  var_5 = squared(576);

  while(distancesquared(level.player.origin, var_0._id_C6EA.origin) < var_5) {
    wait 0.1;
  }

  var_0 thread _id_B38E();
  var_2 thread _id_B38E();
  wait 5;
  var_6 = getEnt("trig_scene_armory", "targetname");

  while(level.player istouching(var_6)) {
    wait 0.15;
  }

  var_0 _id_10345("marscrib_brk_whatdoyouthinkb", [var_2, 128], [448], "near_conversation", ["in_conversation", "near_conversation"]);
  var_1 _id_10345("marscrib_ma2_itsthebestchanc", [var_0, 128], [768, undefined, undefined, 2]);
  scripts\engine\utility::flag_clear("near_conversation");
  var_2 _id_10345("marscrib_ma3_setdefbotsareag", [var_0, 128], [768], "near_conversation", ["in_conversation", "near_conversation"]);

  if(var_0 _id_10345("marscrib_brk_ethansgotemhand", [var_2, 128], [768, undefined, undefined, 2])) {
    if(var_2 _id_10345("marscrib_ma3_youtrusthim", [var_0, 128], [768, undefined, undefined, 2])) {
      var_0 _id_10345("marscrib_brk_withmylife", [var_2, 128], [768, undefined, undefined, 2]);
    }
  }

  scripts\engine\utility::flag_clear("near_conversation");
  var_1 _id_10345("marscrib_ma2_theydotheirjobw", [var_0, 128], [768], "near_conversation", ["in_conversation", "near_conversation"]);
  var_0 _id_10345("marscrib_brk_memorizetheplan", [var_2, 128], [768, undefined, undefined, 2]);
  scripts\engine\utility::flag_clear("near_conversation");
  wait 3;
  var_0 thread _id_B397(scripts\engine\utility::random(var_4), var_4, "in_conversation");
  var_2 thread _id_B397(scripts\engine\utility::random(level._id_92F0[var_2.gender]), level._id_92F0[var_2.gender], "near_conversation");
}

_id_4457() {
  level endon("sa_dropship_cleanup");
  var_0 = scripts\sp\maps\marscrib\marscrib_util::_id_10710("sa_hero_gator");
  var_1 = scripts\sp\maps\marscrib\marscrib_util::_id_10652("sa_hero_boats");
  var_2 = scripts\sp\maps\marscrib\marscrib_util::_id_1068C("sa_hero_commo");

  foreach(var_4 in [var_0, var_1, var_2]) {
    var_5 = scripts\engine\utility::getStruct("sa_hero_" + var_4._id_1FBB, "targetname");
    var_4._id_C6EA = var_5;

    if(!isDefined(var_5._id_595C) && var_4.weapon != "none") {
      var_4 thread scripts\sp\utility::_id_86E4();
    }

    if(isDefined(var_5.animation)) {
      var_5 thread scripts\sp\anim::_id_1EEA(var_4, var_5.animation, undefined, undefined, undefined, "generic");
    }
  }

  var_1._id_113CA = spawn("script_model", (42944, -80448, -15104));
  var_1._id_113CA setModel("p7_desk_metal_military_03_tablet");
  var_1._id_113CA linkTo(var_1, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
  var_7 = getEnt("trig_scene_comms", "targetname");
  var_7 waittill("trigger");
  var_0 _id_10345("marscrib_gtr_status", [var_2, 300, 1], [], "in_conversation", "in_conversation");
  var_2 _id_10345("marscrib_cmo_radarsclearbutthey", [var_0, 300], []);
  var_0 _id_10345("marscrib_nav_reportalltraffi", [var_2, 300, 0], []);
  scripts\engine\utility::flag_clear("in_conversation");
  var_8 = ["marscrib_bts_captainreyes", "marscrib_bts_sir", "marscrib_bts_captain"];
  var_9 = ["marscrib_cmo_captain", "marscrib_cmo_commander", "marscrib_cmo_sir"];
  var_10 = ["marscrib_nav_sir", "marscrib_nav_captain", "marscrib_nav_commander"];
  var_0 thread _id_4456(var_0, var_10);
  var_1 thread _id_4452(var_1, var_8);
  var_2 thread _id_4453(var_2, var_9);
}

_id_4452(var_0, var_1) {
  level endon("sa_dropship_cleanup");
  _id_FC57("marscrib_plr_sipesgoodtosee", var_0, 96, 1, undefined, undefined, "in_conversation", ["in_conversation", "near_conversation"]);
  var_0 _id_10345("marscrib_bsw_youtoosir", [level.player, 300], [192, 1, undefined, 2]);
  scripts\engine\utility::flag_clear("in_conversation");
  wait 5;
  var_0 thread _id_B397(scripts\engine\utility::random(var_1), var_1, "in_conversation");
}

_id_4453(var_0, var_1) {
  level endon("sa_dropship_cleanup");
  level waittill("gator_done");
  var_0 thread scripts\sp\interaction::_id_CD4B(var_0._id_C6EA._id_EE92, var_0._id_C6EA);
  var_0 scripts\engine\utility::waittill_any("playing_interaction", "playing_interaction_scene");
  scripts\engine\utility::flag_set("in_conversation");
  wait 0.5;
  var_0 scripts\sp\utility::_id_10346("marscrib_cmo_werewithyoucaptain");
  scripts\engine\utility::flag_clear("in_conversation");
  wait 5;
  var_0 thread _id_B397(scripts\engine\utility::random(var_1), var_1, "in_conversation");
}

_id_4456(var_0, var_1) {
  level endon("sa_dropship_cleanup");
  _id_FC57("marscrib_plr_gator", var_0, 192, 1, [0.26], undefined, "in_conversation", "in_conversation");
  scripts\engine\utility::flag_clear("in_conversation");
  var_0 _id_10345("marscrib_gtr_captainwethoughtthe", [level.player, 300], [192, 1, [0.26]], "in_conversation", ["in_conversation", "near_conversation"]);

  if(_id_FC57("marscrib_plr_likewise", var_0, 192, 1, undefined, 2)) {
    var_0 _id_10345("marscrib_gtr_thankyousirmeans", [level.player, 300], []);
  }

  scripts\engine\utility::flag_clear("in_conversation");
  var_0 _id_10345("marscrib_nav_quiteamaneuveru", [level.player, 300], [192, 1], "in_conversation", ["in_conversation", "near_conversation"]);
  _id_FC57("marscrib_plr_didntseemlikeac", var_0, 192, 1, undefined, 2);
  scripts\engine\utility::flag_clear("in_conversation");
  level notify("gator_done");
  wait 5;
  var_0 thread _id_B397(scripts\engine\utility::random(var_1), var_1, "in_conversation");
}

_id_6F1B() {
  level endon("sa_dropship_cleanup");
  var_0 = scripts\sp\maps\marscrib\marscrib_util::_id_10750();
  var_1 = scripts\sp\maps\marscrib\marscrib_util::_id_107BD();
  var_0._id_C6EA = scripts\engine\utility::getStruct("sa_hero_" + var_0._id_1FBB, "targetname");
  var_1._id_C6EA = scripts\engine\utility::getStruct("sa_hero_" + var_1._id_1FBB, "targetname");
  var_0 scripts\sp\utility::_id_86E4();
  var_1 scripts\sp\utility::_id_86E4();
  var_0._id_C6EA thread scripts\sp\anim::_id_1EEA(var_0, var_0._id_C6EA.animation, undefined, undefined, undefined, "generic");
  var_1._id_C6EA thread scripts\sp\anim::_id_1EEA(var_1, var_1._id_C6EA.animation, undefined, undefined, undefined, "generic");
  wait 5;
  var_0 _id_10345("marscrib_kls_sahorawhatsthestatus", [var_1, 1024], [400, 1], "in_conversation", "in_conversation");
  var_1 _id_10345("marscrib_shr_slowgoingweusually", [var_0, 1024], []);
  scripts\engine\utility::flag_clear("in_conversation");
  var_0 scripts\sp\interaction_manager::_id_13775(128);
  var_0 _id_10345("marscrib_kls_captainreyes", [level.player, 192], [160, 1], "in_conversation", ["in_conversation", "near_conversation"]);
  scripts\engine\utility::flag_clear("in_conversation");
  var_0 _id_10345("marscrib_kls_goodtoseeyoure", [level.player, 192], [160], "in_conversation", ["in_conversation", "near_conversation"]);
  _id_FC57("marscrib_plr_youtookloos", var_0, 160, 1, undefined, 2);
  scripts\engine\utility::flag_clear("in_conversation");
  _id_FC57("marscrib_plr_whenyouredonehere", var_0, 160, 1, undefined, undefined, "in_conversation", "in_conversation");
  var_0 _id_10345("marscrib_kls_ayesir", [level.player, 192], [160, undefined, undefined, 1]);
  scripts\engine\utility::flag_clear("in_conversation");
}

_id_1270D() {
  level endon("sa_dropship_cleanup");
  scripts\engine\utility::flag_wait("in_triage");
  var_0 = getEnt("mc_triage_intro_medic", "script_noteworthy");
  var_1 = getEnt("mc_triage_intro_marine", "script_noteworthy");
  var_0._id_1FBB = "generic";
  var_1._id_1FBB = "generic";
  var_0 scripts\sp\utility::_id_10347("marscrib_doc_yourealuckysob");
  var_1 scripts\sp\utility::_id_10347("marscrib_un3_justpatchmeup");
  wait 2;

  while(!scripts\engine\utility::flag("in_triage")) {
    wait 0.65;
  }

  scripts\engine\utility::flag_set("in_conversation");
  scripts\sp\utility::_id_1034D("marscrib_plr_hanginthere");
  scripts\engine\utility::flag_clear("in_conversation");
  wait 1;
  var_2 = sortbydistance(getEntArray("mc_triage_linger_medic", "script_noteworthy"), level.player.origin);
  var_3 = var_2[0];

  foreach(var_5 in var_2) {
    if(level.player scripts\sp\utility::_id_D1DF(var_5.origin, 0.7, 1)) {
      var_3 = var_5;
      break;
    }
  }

  var_3 scripts\sp\interaction_manager::_id_13775(128);
  var_3 thread scripts\sp\interaction_manager::_id_DD45(400);
  scripts\engine\utility::flag_set("in_conversation");
  scripts\sp\utility::_id_1034D("marscrib_plr_corpsmankeepthe");
  var_3 _id_10345("marscrib_doc_yessir", [level.player, 400], []);
  scripts\engine\utility::flag_clear("in_conversation");
  wait 2;
}

_id_2B95() {
  level endon("sa_dropship_cleanup");
  var_0 = scripts\sp\utility::_id_5CC9(getspawner("sa_ally_chaplain", "targetname"));
  var_0._id_1FBB = "chaplain";
  var_0._id_6B14 = 1;
  var_0._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), var_0, "J_Lip_Top");
  var_0 _meth_8307("Ch. Fillion", &"");
  level._id_E97A = scripts\engine\utility::array_add(level._id_E97A, var_0);
  var_1 = scripts\sp\utility::_id_5CC9(getspawner("sa_ally_ambient_marine_male", "targetname"));
  var_1._id_1FBB = "mourner";
  var_1.gender = var_1 _id_7B00();
  var_1._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), var_1, "J_Lip_Top");
  var_1 scripts\sp\names::_id_7B07(var_1.voice);
  var_1 _meth_8307(var_1.name, &"");
  level._id_E97A = scripts\engine\utility::array_add(level._id_E97A, var_1);
  var_2 = spawn("script_model", (42944, -80448, -15104));
  var_2 setModel("decor_vintage_book_marscrib");
  var_2 linkTo(var_0, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
  var_3 = getEnt("org_blessing_bodybag", "targetname");
  var_3 setModel("corpse_bodybag_02_dust");
  var_4 = scripts\engine\utility::getStruct("sa_blessing_chaplain", "targetname");
  var_4 thread scripts\sp\anim::_id_1EEA(var_0, "bless_idle");
  var_4 thread scripts\sp\anim::_id_1EEA(var_1, "bless_idle");
  var_5 = getEnt("trig_blessing_start", "targetname");
  var_5 waittill("trigger");
  scripts\engine\utility::flag_set("near_conversation");
  var_6 = getanimlength(var_0 scripts\sp\utility::_id_7DC1("bless_scene"));
  scripts\engine\utility::delaythread(var_6, scripts\engine\utility::flag_clear, "near_conversation");
  var_4 notify("stop_loop");
  var_4 thread _id_1F3C(var_0, "bless_scene", "bless_end_idle");
  var_4 thread _id_1F3C(var_1, "bless_scene", "bless_end_idle");
}

_id_A055() {
  level endon("sa_dropship_cleanup");
  var_0 = scripts\sp\utility::_id_5CC9(getspawner("player_dropship_marine06", "targetname"));
  var_0._id_C6EA = scripts\engine\utility::getStruct("sa_hero_jack", "targetname");
  var_0._id_1FBB = "jack";
  var_0._id_6B14 = 1;
  var_0._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), var_0, "J_Lip_Top");
  var_0 _meth_8307("Hamilton", &"");
  level._id_E97A = scripts\engine\utility::array_add(level._id_E97A, var_0);
  var_0._id_113CA = spawn("script_model", (42944, -80448, -15104));
  var_0._id_113CA setModel("p7_desk_metal_military_03_tablet");
  var_0._id_113CA linkTo(var_0, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var_0._id_C6EA thread scripts\sp\anim::_id_1EEA(var_0, "jack_idle");

  while(distancesquared(level.player.origin, var_0.origin) > 16384 || !scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.766) || scripts\engine\utility::flag("in_conversation") || scripts\engine\utility::flag("near_conversation")) {
    wait 0.05;
  }

  scripts\engine\utility::flag_set("in_conversation");
  scripts\sp\utility::_id_1034D("marscrib_plr_hamiltonineedyou");
  var_0 _id_10345("sc_rogue_un2_thankscaptain", [level.player, 400, 0], []);
  scripts\engine\utility::flag_clear("in_conversation");
  var_1 = ["marscrib_jck_lieutenants", "marscrib_un2_weightoftheworld", "marscrib_un2_wererightbehind"];
  var_0 scripts\engine\utility::delaythread(5, ::_id_B397, var_1[0], var_1, "in_conversation");
}

_id_B516() {
  level endon("sa_dropship_cleanup");
  var_0 = scripts\sp\maps\marscrib\marscrib_util::_id_106D9();
  var_0._id_C6EA = scripts\engine\utility::getStruct("sa_hero_" + var_0._id_1FBB, "targetname");
  var_0 scripts\sp\utility::_id_86E4();
  var_0._id_C6EA thread scripts\sp\anim::_id_1EEA(var_0, var_0._id_C6EA.animation, "stop_ethan", undefined, undefined, "generic");
  wait 0.1;
  var_1 = spawn("trigger_radius", var_0.origin, 0, 196, 128);
  var_1 waittill("trigger");
  _id_FC57("marscrib_plr_getyourteamloaded", var_0, 192, 1, 1, undefined, "in_conversation", "in_conversation");
  var_0._id_C6EA notify("stop_ethan");
  var_0 thread scripts\sp\interaction::_id_CE18(var_0._id_C6EA._id_EE92, "marscrib_eth_rogerthatsir", undefined, undefined, undefined, var_0._id_C6EA, undefined, 0.25);
  var_0 waittill("interaction_done");
  wait 1.0;

  if(_id_FC57("marscrib_plr_thatsokayethant", var_0, 192, 1, 1, 2)) {
    if(_id_FC57("marscrib_plr_theyrecannonfod", var_0, 192, 1, 1, 2)) {
      var_0 _id_10345("marscrib_eth_goodcallcaptain", [level.player, 300], [150, undefined, undefined, 1]);
    }
  }

  scripts\engine\utility::flag_clear("in_conversation");
  var_2 = ["marscrib_eth_sir", "marscrib_eth_commander", "marscrib_eth_letsdothiscapta"];
  var_0 scripts\engine\utility::delaythread(5, ::_id_B397, scripts\engine\utility::random(var_2), var_2, "in_conversation");
}

_id_223C() {
  level endon("sa_dropship_cleanup");
  _id_220C();
  _id_220E();
  _id_2229();
  _id_21F0();
}

_id_220C() {
  level endon("sa_dropship_cleanup");
  var_0 = getEntArray("trig_obj_dropship", "targetname");
  var_1 = getEnt("trig_inside_dropship", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\engine\utility::trigger_off);
  var_1 scripts\engine\utility::trigger_off();
  var_2 = scripts\sp\maps\marscrib\marscrib_util::_id_10766();
  var_2._id_C6EA = scripts\engine\utility::getStruct("sa_hero_" + var_2._id_1FBB, "targetname");
  var_2 scripts\sp\utility::_id_86E4();
  var_2._id_C6EA thread scripts\sp\anim::_id_1EEA(var_2, "armory_idle", "stop_idle");
  var_3 = spawn("script_model", (42944, -80448, -15104));
  var_4 = getweaponmodel("iw7_steeldragon");
  var_3 setModel(var_4);
  var_3 linkTo(var_2, "j_gun", (0, 0, 0), (0, 0, 0));
  var_3 scripts\engine\utility::delaycall(0.25, ::unlink);
  var_5 = spawn("script_model", (42944, -80448, -15104));
  var_5 setModel("equipment_industrial_screwdriver_01");
  var_5 linkTo(var_2, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  var_6 = scripts\sp\maps\marscrib\marscrib_util::_id_10722();
  var_6._id_845E = undefined;
  var_6._id_C6EB = scripts\engine\utility::getStruct("sa_hero_griff", "targetname");
  var_6._id_C6EC = scripts\engine\utility::getStruct("sa_hero_griff_loadout", "targetname");
  var_6 scripts\sp\utility::_id_86E4();
  var_6._id_C6EB thread scripts\sp\anim::_id_1EEA(var_6, "armory_idle", "stop_idle");
  wait 0.1;
}

_id_220E() {
  level endon("sa_dropship_cleanup");
  level endon("at_terminal");
  var_0 = scripts\engine\utility::getStruct("loadout_interact", "script_noteworthy");
  objective_add(scripts\sp\utility::_id_C264("armory"), "current", &"MARSCRIB_OBJ_ARMORY", var_0.origin + (0, 0, 16));
  var_1 = getEnt("trig_scene_armory", "targetname");

  while(!level.player istouching(var_1) || !_id_FC56(level._id_8604, 400, 1, undefined, undefined, "in_conversation")) {
    wait 0.1;
  }

  objective_state(scripts\sp\utility::_id_C264("armory"), "active");
  scripts\engine\utility::flag_set("in_conversation");
  level._id_8604._id_C6EB notify("stop_idle");
  level._id_B4F1._id_C6EA notify("stop_idle");
  level._id_8604._id_C6EB thread _id_1F3C(level._id_8604, "armory_intro", "armory_idle", "stop_idle", undefined, undefined, "stop_idle");
  level._id_B4F1._id_C6EA thread _id_1F3C(level._id_B4F1, "armory_intro", "armory_idle", "stop_idle");
  wait 5.25;
  scripts\engine\utility::flag_clear("in_conversation");
  _id_FC57("marscrib_plr_weremountingana", level._id_8604, 192, 1, 1, undefined, "in_conversation", "in_conversation");
  scripts\engine\utility::flag_clear("in_conversation");
  var_1 = getEnt("trig_scene_armory", "targetname");

  while(level.player istouching(var_1) && !_id_FC56(level._id_8604, 192, 1, undefined, undefined, "in_conversation")) {
    wait 0.1;
  }

  level._id_8604._id_C6EB notify("stop_idle");
  scripts\engine\utility::flag_set("in_conversation");
  level._id_8604._id_C6EB thread _id_1F3C(level._id_8604, "armory_prompt", "armory_idle", "stop_idle", undefined, undefined, "stop_idle");
  scripts\engine\utility::delaythread(7.75, scripts\engine\utility::flag_clear, "in_conversation");
  scripts\engine\utility::delaythread(8, ::_id_2220);
}

_id_2229() {
  level endon("sa_dropship_cleanup");
  level waittill("armory_pickup_look_complete");
  wait 0.5;
  scripts\engine\utility::flag_set("in_conversation");
  scripts\sp\utility::_id_1034D("marscrib_plr_armupwellbe");
  wait 1.1;
  scripts\engine\utility::flag_clear("in_conversation");
}

_id_21F0() {
  level endon("sa_dropship_cleanup");
  _id_FC57("marscrib_plr_macyouleadechot", level._id_B4F1, 192, undefined, undefined, undefined, "in_conversation", "in_conversation");
  level._id_B4F1 _id_10345("marscrib_mac_illbereadycaptain", [level.player, 300], [192, undefined, undefined, 2]);
  scripts\engine\utility::flag_clear("in_conversation");
  var_0 = ["marscrib_grf_sir1", "marscrib_grf_captain1", "marscrib_grf_captainreyes1"];
  var_1 = ["marscrib_mac_captainreyes", "marscrib_mac_sir", "marscrib_mac_commander"];
  level._id_8604 scripts\engine\utility::delaythread(5, ::_id_B397, scripts\engine\utility::random(var_0), var_0, "in_conversation");
  level._id_B4F1 scripts\engine\utility::delaythread(5, ::_id_B397, scripts\engine\utility::random(var_1), var_1, "in_conversation");
}

_id_2220() {
  level endon("at_terminal");
  level endon("armory_alt_complete");
  level endon("armory_nag_pickup");
  level endon("sa_dropship_cleanup");
  wait 4;
  level._id_8604 _id_10345("marscrib_grf_hittheterminalwhen", [level.player, 300], [192, 1, 1], "in_conversation", ["in_conversation", "near_conversation"]);
  scripts\engine\utility::flag_clear("in_conversation");
  wait 6;
  level._id_B4F1 _id_10345("marscrib_mac_youshouldarmup", [level.player, 300], [192], "in_conversation", ["in_conversation", "near_conversation"]);
  scripts\engine\utility::flag_clear("in_conversation");
}

_id_221F() {
  level notify("armory_nag_pickup");
  level endon("armory_nag_pickup");
  level endon("armory_pickup_complete");
  level endon("armory_pickup_look_complete");
  level endon("sa_dropship_cleanup");
  level._id_8604 _id_10345("marscrib_grf_gotyourkiton", [level.player, 300], [], "in_conversation");
  wait 5;

  while(!_id_FC56(level._id_8604, 300, undefined, undefined, undefined, ["in_conversation", "near_conversation"])) {
    wait 0.05;
  }

  level._id_8604 _id_10345("marscrib_grf_youcanpickup", [level.player, 300], [], "in_conversation");
  scripts\engine\utility::flag_clear("in_conversation");
  wait 12;

  while(!_id_FC56(level._id_8604, 300, undefined, undefined, undefined, ["in_conversation", "near_conversation"])) {
    wait 0.05;
  }

  level._id_8604 _id_10345("marscrib_grf_gotyourkiton", [level.player, 300], [], "in_conversation");
  scripts\engine\utility::flag_clear("in_conversation");
}

_id_952F() {
  level endon("sa_dropship_cleanup");
  level thread _id_9532();
  level._id_E981 = getEnt("sa_armory_primary", "targetname");
  level._id_E981 hide();
  level._id_E980 = getEntArray("sa_armory_equip", "targetname");
  scripts\engine\utility::array_call(level._id_E980, ::hide);
  getEnt("mc_trig_swap_dropship", "targetname") scripts\engine\utility::trigger_off();
  level thread _id_CF72();
  level thread _id_CF71();
}

_id_9532() {
  var_0 = scripts\engine\utility::getStruct("loadout_interact", "script_noteworthy");
  var_0 scripts\engine\utility::delaythread(3.75, _id_0E46::_id_DFE3);
  wait 4;
  var_0 _id_0E46::_id_48C4(undefined, undefined, &"SHIPCRIB_USETERMINAL", undefined, undefined, 60, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
}

_id_CF72() {
  level endon("sa_dropship_cleanup");
  var_0 = scripts\engine\utility::getStruct("sa_hero_griff_loadout", "targetname");
  thread _id_8605();

  for(;;) {
    level waittill("armory_chose_loadout");
    scripts\engine\utility::flag_clear("in_conversation");

    if(isDefined(level._id_E981._id_4C1F)) {
      level._id_E981 thread _id_0E46::_id_DFE3();
    }

    var_1 = undefined;

    if(!isDefined(level._id_8604._id_845E)) {
      level._id_8604._id_C6EB notify("stop_idle");
      var_1 = 1;
      level._id_8604._id_845E = 1;
      level._id_8604._id_C6EC thread scripts\sp\anim::_id_1EEA(level._id_8604, "armory_idle", "stop_idle");
    }

    level.player thread armory_return_saved_loadout();
    level scripts\engine\utility::delaythread(0.1, ::_id_CF6E);

    if(isDefined(var_1)) {
      level waittill("armory_alt_complete");
      level._id_EC85["player_rig"]["player_terminal_exit"] = level._id_EC85["player_rig"]["player_armory_use_turn"];
      thread _id_221F();
      wait 1;
      level notify("armory_pickup_ready");
    }
  }
}

_id_CF6E() {
  level notify("player_armory_pickup");
  level endon("player_armory_pickup");
  level endon("sa_dropship_cleanup");
  scripts\engine\utility::array_call(level._id_E980, ::show);
  var_0 = level.player _meth_84C6("selectedLoadout");
  var_1 = level.player _meth_84C6("loadouts", var_0, "weaponSetups", 0, "weapon");
  var_2 = undefined;

  if(isDefined(var_1) && issubstr(var_1, "none")) {
    return;
  } else if(isDefined(var_1)) {
    _id_0A2F::_id_12646(var_1);
    var_2 = getweaponviewmodel(var_1);

    if(isDefined(var_2)) {
      level._id_E981 setModel(var_2);
      _id_0EE8::_id_12D8(var_1, level._id_E981);
    }
  }

  var_3 = scripts\engine\utility::getStruct("mc_anim_loadout", "targetname");
  var_4 = scripts\sp\utility::_id_10639("player_rig", (42944, -80448, -15104));
  var_5 = _id_21FA(var_1);
  var_6 = var_4 scripts\sp\utility::_id_7DC1(var_5);
  var_7 = getanimlength(var_6);
  var_4 hide();
  var_8 = scripts\engine\utility::get_notetrack_time(var_6, "gun_attach") / getanimlength(var_6);
  var_3 thread scripts\sp\anim::_id_1F35(var_4, var_5);
  var_4 _meth_82B1(var_6, 0);
  var_4 _meth_82B0(var_6, var_8);
  level._id_E981 linkTo(var_4, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  wait 0.05;
  level thread _id_CF6D(var_4);
  level._id_E981 show();
  level._id_E981 _id_0E46::_id_48C4(undefined, (0, 0, 4), &"MARSCRIB_GET_LOADOUT", 180, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  level._id_E981 waittill("trigger");
  level notify("armory_pickup_complete");
  level._id_8604 notify("smart_dialog_lookat_gesture");
  level._id_8604 notify("stop_reaction_look");
  level._id_8604 scripts\sp\utility::_id_77B9(0.5);
  level._id_E981 unlink();
  var_4 _meth_82B0(var_6, 0);
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("armory"));
  level.player scripts\sp\utility::_id_F526("normal");
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_melee(0);
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player _meth_823C(var_4, "tag_player", 0.5, 0.2, 0.2);
  wait 0.55;
  level.player playerlinktodelta(var_4, "tag_player", 1, 0, 0, 0, 0, 1);
  var_4 show();
  var_4 _meth_82B1(var_6, 1);
  wait(var_7);

  if(!scripts\engine\utility::flag("staging_area_exit_ready")) {
    scripts\engine\utility::flag_set("staging_area_exit_ready");
    scripts\engine\utility::delaythread(2, scripts\engine\utility::exploder, "1");
    level._id_8604._id_C6EB notify("stop_idle");
    level._id_8604._id_C6EC notify("stop_idle");
    level._id_8604._id_C6EC thread _id_1F3C(level._id_8604, "armory_exit", "armory_idle", "stop_idle");
    var_3 scripts\sp\anim::_id_1F35(var_4, "player_armory_look");
    level notify("armory_pickup_look_complete");
    _id_0E4B::helmethud_on();
    level thread _id_220B(getEnt("trig_scene_armory", "targetname"));
  }

  level.player unlink();
  var_4 hide();
  var_4 delete();
  level.player scripts\sp\utility::_id_F526("safe", 1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_melee(1);
  level.player enableweapons();
  level.player freezecontrols(0);
  level._id_E981 unlink();
  level._id_E981 hide();
  level.player armory_save_loadout();
  _id_0EE8::_id_8311();
}

_id_CF6D(var_0) {
  level endon("player_armory_pickup");
  level endon("sa_dropship_cleanup");
  level.player endon("death");
  level waittill("gun_attach");
  level._id_E981 linkTo(var_0, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
}

_id_CF71() {
  level.player endon("death");
  var_0 = scripts\engine\utility::getStruct("loadout_interact", "script_noteworthy");

  for(;;) {
    var_0 waittill("trigger");
    level.player setstance("stand");
    level waittill("armory_chose_loadout");
    level.player setstance("stand");
    wait 0.05;
  }
}

armory_save_loadout() {
  var_0 = self _meth_84C6("selectedLoadout");

  if(getdvarint("skip_loadout") > 0 || !isDefined(self _meth_84C6("selectedLoadout"))) {
    var_0 = 0;
  }

  var_1 = self _meth_84C6("loadouts", var_0, "weaponSetups", 0, "weapon");
  var_2 = self _meth_84C6("loadouts", var_0, "weaponSetups", 1, "weapon");
  var_3 = spawnStruct();
  var_3.primary = scripts\sp\loadout::_id_31CE(0, var_0);
  var_3.secondary = scripts\sp\loadout::_id_31CE(1, var_0);
  var_3.item = self _meth_84C6("loadouts", var_0, "equipment", 0);
  var_3._id_0216 = self _meth_84C6("loadouts", var_0, "offhandEquipment", 0);
  var_3._id_A016 = self _meth_84C6("loadouts", var_0, "equipment", 1);
  var_3._id_C327 = self _meth_84C6("loadouts", var_0, "offhandEquipment", 1);
  var_3.jack_primary = self _meth_84C6("loadouts", var_0, "jackalSetup", "jackalPrimary");
  var_3.jack_secondary = self _meth_84C6("loadouts", var_0, "jackalSetup", "jackalSecondary");
  var_3.jack_upgrade = self _meth_84C6("loadouts", var_0, "jackalSetup", "jackalUpgrade");
  self.saved_loadout = var_3;
}

armory_return_saved_loadout() {
  if(!isDefined(self.saved_loadout)) {
    return 0;
  }

  scripts\sp\utility::_id_11428();
  var_0 = self.saved_loadout;
  scripts\sp\loadout::_id_8305(var_0.primary, var_0.secondary, var_0.item, var_0._id_0216, var_0._id_A016, var_0._id_C327);
}

_id_21FA(var_0) {
  if(issubstr(var_0, "ar57")) {
    return "plr_grab_ar57";
  }

  if(issubstr(var_0, "acr")) {
    return "plr_grab_acr";
  }

  if(issubstr(var_0, "ake")) {
    return "plr_grab_ake";
  }

  if(issubstr(var_0, "sdfar") || issubstr(var_0, "gambit")) {
    return "plr_grab_sdfar";
  }

  if(issubstr(var_0, "fmg")) {
    return "plr_grab_fmg";
  }

  if(issubstr(var_0, "sdflmg") || issubstr(var_0, "repeater") || issubstr(var_0, "lmg03")) {
    return "plr_grab_sdflmg";
  }

  if(issubstr(var_0, "mauler")) {
    return "plr_grab_mauler";
  }

  if(issubstr(var_0, "m1")) {
    return "plr_grab_m1";
  }

  if(issubstr(var_0, "kbs")) {
    return "plr_grab_kbs";
  }

  if(issubstr(var_0, "m8")) {
    return "plr_grab_m8";
  } else {
    return "plr_grab_m4";
  }
}

_id_8605() {
  level endon("armory_chose_loadout");
  level endon("sa_dropship_cleanup");
  scripts\engine\utility::flag_wait("at_terminal");
  scripts\engine\utility::flag_set("used_terminal");
  wait 2.5;
  scripts\sp\utility::_id_1034D("marscrib_plr_anyreccommendat");
  wait 0.3;
  scripts\sp\utility::_id_1034D("marscrib_grf_whateversgonnakill");
}

_id_220B(var_0) {
  level endon("sa_dropship_cleanup");
  level endon("dropship_obj_2");

  while(level.player istouching(var_0)) {
    wait 0.05;
  }

  var_1 = scripts\sp\utility::_id_107EA("sa_hustle_armory");
  var_1 _id_B272("idle", "armed", undefined, undefined, 1, scripts\engine\utility::getStruct("sa_hustle_armory_org", "targetname"), 1);
}

_id_2ADC() {
  level endon("sa_dropship_cleanup");
  var_0 = scripts\sp\maps\marscrib\marscrib_util::_id_107BE();
  var_0._id_C6EA = scripts\engine\utility::getStruct("sa_hero_" + var_0._id_1FBB, "targetname");

  if(isDefined(var_0._id_A489)) {
    var_0 detach(var_0._id_A489);
  }

  var_0._id_C6EA thread scripts\sp\anim::_id_1EEA(var_0, var_0._id_C6EA.animation, undefined, undefined, undefined, "generic");
}

_id_9AB2() {
  var_0 = scripts\sp\vehicle::_id_1080D("mc_dropship");
  wait 1.0;
  var_0 playSound("marscrib_dropship_intro_takeoff");
}

_id_9ABB() {
  scripts\sp\utility::_id_22CA("sa_hustle_walk_2a", ::_id_23B6, "generic");
  scripts\sp\utility::_id_22CA("sa_hustle_walk_2a", scripts\asm\asm::_id_237B, 1.15);
  scripts\sp\utility::_id_22CA("sa_hustle_walk_2a", scripts\sp\utility::_id_51E1, "casual");
  scripts\sp\utility::_id_22CA("sa_hustle_walk_2a", scripts\sp\utility::_id_F48E, "casual", "walk_frantic");
  var_0 = scripts\sp\utility::_id_22CD("sa_hustle_1a", 1);
  var_1 = scripts\sp\utility::_id_22CD("sa_hustle_1b", 1);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_7226, scripts\engine\utility::getStruct("sa_hustle_org_1a", "targetname"));
  scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_7226, scripts\engine\utility::getStruct("sa_hustle_org_1b", "targetname"));
  level scripts\engine\utility::delaythread(4.0, scripts\sp\utility::_id_228A, var_0);
  wait 2;
  var_2 = scripts\sp\utility::_id_22CD("sa_hustle_walk_2a", 1);
  var_3 = scripts\sp\utility::_id_22CD("sa_hustle_2a", 1);
  var_4 = scripts\sp\utility::_id_22CD("sa_hustle_2b", 1);
  var_5 = scripts\sp\utility::_id_107EA("sa_hustle_idle_walker_2a", 1);
  scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_7226, scripts\engine\utility::getStruct("sa_hustle_org_2a", "targetname"));
  scripts\engine\utility::array_thread(var_3, scripts\sp\utility::_id_7226, scripts\engine\utility::getStruct("sa_hustle_org_2a", "targetname"));
  scripts\engine\utility::array_thread(var_4, scripts\sp\utility::_id_7226, scripts\engine\utility::getStruct("sa_hustle_org_2b", "targetname"));
  var_5 _id_B272("idle", "armed", undefined, undefined, 1, scripts\engine\utility::getStruct("sa_hustle_idle_walker_org_2a", "targetname"));
  var_6 = scripts\sp\utility::_id_107EA("sa_hustle_idle_walker_3a");
  scripts\engine\utility::flag_wait("start_intro_hustle_late");
  var_6 _id_B272("idle", "armed", undefined, undefined, 1, scripts\engine\utility::getStruct("sa_hustle_idle_walker_org_3a", "targetname"), 1);
}

_id_23B6(var_0) {
  self._id_1FBB = var_0;
}

#using_animtree("generic_human");

_id_91F4(var_0) {
  self endon("death");
  self endon("hustle_do_stop");
  level endon("sa_dropship_cleanup");
  createnavrepulsor(self.script_noteworthy, 0, self, 192);
  self.origin = self._id_1F54.origin;
  self.angles = self._id_1F54.angles;
  thread _id_91F6();
  wait 0.05;
  var_1 = scripts\sp\utility::_id_7DC1(var_0[0]);
  self _meth_82E3("single anim", var_1, %root);
  wait(getanimlength(var_1));
  var_2 = gettime();
  var_3 = 0;
  var_4 = 1;

  for(;;) {
    var_1 = scripts\sp\utility::_id_7DC1(var_0[1]);
    var_5 = randomintrange(var_3, var_4);

    for(var_6 = 0; var_6 < var_5; var_6++) {
      if(var_6 == 0) {
        self _meth_82E3("idle", var_1, %root);
      } else {
        self _meth_82E4("idle", var_1, %root);
      }

      wait(getanimlength(var_1));
    }

    var_1 = scripts\sp\utility::_id_7DC1(var_0[2]);
    self _meth_82E3("single anim", var_1, %root);
    wait(getanimlength(var_1));
    var_1 = scripts\sp\utility::_id_7DC1(var_0[3]);
    var_5 = randomintrange(var_3, var_4);

    for(var_6 = 0; var_6 < var_5; var_6++) {
      if(var_6 == 0) {
        self _meth_82E3("idle", var_1, %root);
      } else {
        self _meth_82E4("idle", var_1, %root);
      }

      wait(getanimlength(var_1));
    }

    self.origin = self._id_1F54.origin;
    self.angles = self._id_1F54.angles;
    var_1 = scripts\sp\utility::_id_7DC1(var_0[0]);
    self _meth_82E3("single anim", var_1, %root);
    wait(getanimlength(var_1));

    if(gettime() - var_2 > 40000) {
      var_3 = 1;
      var_4 = 4;
      continue;
    }

    if(gettime() - var_2 > 20000) {
      var_3 = 1;
      var_4 = 2;
    }
  }
}

_id_7A23(var_0) {
  if(var_0 == "shipcrib_hangar_hustle_30ft_guy_C_pt1") {
    return "lean";
  }

  if(var_0 == "shipcrib_hangar_hustle_15ft_guy_B_pt1") {
    return "kneel";
  } else {
    return "stand";
  }
}

_id_91F6() {
  self endon("death");
  self endon("hustle_do_stop");
  level endon("sa_dropship_cleanup");

  for(;;) {
    self.origin = scripts\engine\utility::drop_to_ground(self.origin);
    wait 0.05;
  }
}

_id_10630(var_0) {
  level endon("sa_dropship_cleanup");
  var_1 = [];
  var_1["generic"] = getspawnerarray("sa_ally_ambient");
  var_1["comms"] = getspawnerarray("sa_ally_ambient_comms");
  var_1["marines"] = getspawnerarray("sa_ally_ambient_marine");
  var_1["marines_male"] = getspawnerarray("sa_ally_ambient_marine_male");
  var_1["medic"] = getspawnerarray("sa_ally_ambient_medic");
  var_1["triage_male"] = getspawnerarray("sa_ally_ambient_triage_male");
  var_1["triage_female"] = getspawnerarray("sa_ally_ambient_triage_female");
  var_1["deck"] = getspawnerarray("sa_ally_ambient_deck");
  var_1["mech"] = getspawnerarray("sa_ally_ambient_mech");
  var_1["fuel"] = getspawnerarray("sa_ally_ambient_fuel");
  var_1["handler"] = getspawnerarray("sa_ally_ambient_handler");
  var_1["hustler"] = ::scripts\engine\utility::array_combine(getspawnerarray("sa_ally_ambient_crew"), getspawnerarray("sa_ally_ambient_deck"));
  var_2["stand"] = ["hustle_stand_1", "hustle_stand_idle", "hustle_stand_2", "hustle_stand_idle"];
  var_2["kneel"] = ["hustle_kneel_1", "hustle_kneel_idle", "hustle_kneel_2", "hustle_kneel_idle"];
  var_2["lean"] = ["hustle_lean_1", "hustle_kneel_idle", "hustle_lean_2", "hustle_lean_idle"];
  level._id_92F0 = [];
  level._id_92F0["male_1"] = ["marscrib_ma1_readytokicksome", "marscrib_ma2_setdefaintgonna"];
  level._id_92F0["male_2"] = ["marscrib_cm1_startingtothink", "marscrib_cr3_theygotusgooddi"];
  level._id_92F0["male_3"] = ["marscrib_cm2_downbutnotoutca", "marscrib_cr4_captaingoodtose"];
  level._id_92F0["male_4"] = ["marscrib_ma3_dontgoafteremwi", "marscrib_ma4_gooddayforafigh"];
  level._id_92F0["female_1"] = ["shipcrib_un1_captain", "shipcrib_un1_sir"];
  level._id_92F0["female_2"] = ["shipcrib_unf2_captain", "shipcrib_unf2_youllhavetoexcus"];
  level._id_92F0["female_3"] = ["shipcrib_unf3_captainreyes", "shipcrib_unf3_sir"];
  level._id_E9D6 = [];
  level._id_E998["unarmed"] = ["casual"];
  level._id_E998["armed"] = ["combat"];
  level._id_E997 = [];
  level._id_E997["unarmed"] = ["casual"];
  level._id_E997["armed"] = ["casual_gun"];
  level._id_E97E = [];

  foreach(var_4 in var_0) {
    var_5 = var_4.script_type;

    if(!isDefined(var_5)) {
      var_5 = "generic";
    }

    var_6 = scripts\sp\utility::_id_5CC9(scripts\engine\utility::random(var_1[var_5]));
    var_6._id_1FBB = "generic";
    var_6._id_9B89 = 1;
    var_6._id_6B14 = 1;
    var_6._id_19F6 = var_5;
    var_6.script_noteworthy = var_4.script_noteworthy;
    var_6._id_1F54 = var_4;
    var_6.gender = var_6 _id_7B00();
    var_6._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), var_6, "J_Lip_Top");
    var_6 scripts\sp\names::_id_7B07(var_6.voice);
    var_6 _meth_8307(var_6.name, &"");

    if(isDefined(var_4._id_EF20) && var_4._id_EF20 == "ambient_interact") {
      var_6 thread _id_B397(scripts\engine\utility::random(level._id_92F0[var_6.gender]), level._id_92F0[var_6.gender], "near_conversation");
    }

    if(!isDefined(var_4._id_595C) && var_6.weapon != "none") {
      var_6 thread scripts\sp\utility::_id_86E4();
    }

    if(issubstr(var_5, "triage") && isDefined(var_6._id_A489)) {
      var_6 detach(var_6._id_A489);
    }

    if(issubstr(var_5, "hustler")) {
      var_7 = _id_7A23(var_4.animation);
      var_6 thread _id_91F4(var_2[var_7]);
      level._id_E97E = scripts\engine\utility::array_add(level._id_E97E, var_6);
      continue;
    }

    var_4 thread scripts\sp\anim::_id_1EEA(var_6, var_4.animation, undefined, undefined, undefined, "generic");
    var_8 = var_6 scripts\sp\utility::_id_7DC1(var_4.animation);

    if(isDefined(var_4._id_ED75)) {
      var_6 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_8[0], var_4._id_ED75);
    }

    level._id_E97E = scripts\engine\utility::array_add(level._id_E97E, var_6);
  }
}

_id_10740() {
  level endon("sa_dropship_cleanup");
  level._id_E9BD = getEntArray("sa_idle_robot", "targetname");

  foreach(var_1 in level._id_E9BD) {
    var_1 scripts\sp\utility::_id_23B7("ally_" + var_1.script_noteworthy);

    if(var_1.script_noteworthy == "c12") {
      var_1 thread scripts\sp\anim::_id_1EEA(var_1, var_1.animation);
      continue;
    }

    var_1 thread idle_c6_setup();
  }
}

idle_c6_setup() {
  self endon("death");

  while(!isDefined(self.model) || !scripts\sp\utility::hastag(self.model, "j_gun")) {
    wait 0.05;
  }

  thread scripts\sp\anim::_id_1EEA(self, "c6_idle_1");
  var_0 = scripts\sp\utility::_id_7DC1("c6_idle_1");
  scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_0[0], randomfloat(1));
  scripts\engine\utility::delaycall(0.05, ::_meth_82B1, var_0[0], randomfloatrange(0.33, 1.0));
  wait 0.05;
  self.gun = spawn("script_model", self.origin);
  self.gun setModel("weapon_e_ak47_legendary_wm");
  self.gun linkTo(self, "j_gun", (0, 0, 0), (0, 0, 0));
}

_id_10741() {
  level endon("sa_dropship_cleanup");
  level._id_E9BE = [];
  level._id_E9F5 = [];
  level._id_E9F5["idle"] = ::scripts\engine\utility::getStructArray("sa_idle_path", "targetname");
  level._id_E9F5["jackal"] = ::scripts\engine\utility::getStructArray("sa_jackal_path", "targetname");
  var_0 = [];

  foreach(var_2 in level._id_E9F5["idle"]) {
    if(!isDefined(var_2.script_type) || var_2.script_type != "no_start") {
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  var_4 = scripts\sp\utility::_id_22C6(getspawnerarray("sa_ally_walker"), 1);

  foreach(var_6 in var_4) {
    var_7 = scripts\engine\utility::random(var_0);
    var_0 = scripts\engine\utility::array_remove(var_0, var_7);
    var_6 thread _id_B272("idle", undefined, var_7);
  }

  var_9 = level._id_E9F5["jackal"];
  var_10 = scripts\sp\utility::_id_22C6(getspawnerarray("sa_ally_jackal_walker"), 1);

  foreach(var_6 in var_10) {
    var_7 = scripts\engine\utility::random(var_9);
    var_9 = scripts\engine\utility::array_remove(var_9, var_7);
    var_6 thread _id_B272("jackal", undefined, var_7);
  }
}

_id_92EB(var_0, var_1) {
  level endon("sa_dropship_cleanup");
  self notify("stop_idle_stop_for");
  self endon("stop_idle_stop_for");
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = level.player;
  }

  if(!isDefined(var_1)) {
    var_1 = 150;
  }

  var_2 = var_1;

  for(;;) {
    for(;;) {
      while(distance2d(var_0.origin, self.origin) > var_1) {
        wait 0.1;
      }

      if(scripts\engine\utility::within_fov(var_0.origin, var_0.angles, self.origin, 0.766) && scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, 0.7)) {
        break;
      }

      wait 0.05;
    }

    self notify("stop_finish_walk");
    self._id_92ED = gettime() + randomintrange(3000, 4000);
    var_3 = self.origin + anglesToForward(self.angles) * 64;
    var_4 = scripts\engine\utility::spawn_tag_origin(var_3 + (0, 0, 32), vectortoangles(var_3));
    thread _id_10345(scripts\engine\utility::random(level._id_92F0[self.gender]), [level.player, 110], [85, 0, 1, 5, 0.26], "near_conversation", ["in_conversation", "near_conversation"], "near_conversation");
    scripts\sp\utility::_id_7226(var_4);
    var_4 delete();

    while(gettime() < self._id_92ED && distance2d(var_0.origin, self.origin) < var_2) {
      wait 0.15;
    }

    thread _id_92EC();
    scripts\sp\utility::_id_135F1("reached_path_end", 3);
  }
}

_id_92EC() {
  level endon("sa_dropship_cleanup");
  self notify("stop_finish_walk");
  self endon("stop_finish_walk");
  self endon("death");
  scripts\sp\utility::_id_7226(self.goal);
  self._id_92ED = undefined;
  self notify("idle_stop_goal");
}

_id_92F1(var_0, var_1, var_2, var_3, var_4) {
  level endon("sa_dropship_cleanup");
  self notify("idle_walk_start");
  self endon("idle_walk_start");
  self endon("death");
  self._id_13868 = gettime();

  if(isDefined(var_0)) {
    self _meth_80F1(var_0.origin, var_0.angles);
    wait 0.05;
  }

  if(isDefined(self.goal) && isDefined(self.goal.in_use)) {
    self.goal.in_use = undefined;
  }

  var_5 = squared(768);

  for(;;) {
    if(isDefined(self.running) && self.index == "idle" && !isDefined(var_2)) {
      thread _id_92EB();
    }

    self.running = undefined;
    var_6 = _id_7A2E(level._id_E9F5[self.index], self, var_1, var_4);
    var_4 = undefined;
    self.goal = _id_7A2F(var_6, self, var_3);
    self.goal.in_use = 1;
    var_1 = undefined;
    var_3 = undefined;

    if(isDefined(var_2) && var_2) {
      var_2 = undefined;
      scripts\sp\utility::_id_51E1("combat");
      self.running = 1;
      self notify("start_running", self.goal);
      scripts\engine\utility::delaythread(0.05, ::_id_B38E);
    } else if(distancesquared(level.player.origin, self.origin) > var_5 && distancesquared(level.player.origin, self.goal.origin) > var_5) {
      var_7 = scripts\engine\utility::random(level._id_E998[self.script_noteworthy]);
      scripts\sp\utility::_id_51E1(var_7);

      if(var_7 == "combat") {
        self.running = 1;
        self notify("start_running", self.goal);
        scripts\engine\utility::delaythread(0.05, ::_id_B38E);
      }
    } else
      scripts\sp\utility::_id_51E1(scripts\engine\utility::random(level._id_E997[self.script_noteworthy]));

    scripts\sp\utility::_id_7226(self.goal);

    if(isDefined(self._id_92ED)) {
      self waittill("idle_stop_goal");
    }

    if(isDefined(self.goal.animation) && self.script_noteworthy == self.goal.script_noteworthy && scripts\engine\utility::cointoss()) {
      self.goal scripts\sp\anim::_id_1F0A([self], self.goal.animation, undefined, "generic");
      self.goal scripts\sp\anim::_id_1F2C([self], self.goal.animation, undefined, undefined, "generic");
    }

    self.goal.in_use = undefined;
  }
}

_id_7A2E(var_0, var_1, var_2, var_3) {
  level endon("sa_dropship_cleanup");
  var_1 notify("get_idle_walk_array");
  var_1 endon("get_idle_walk_array");
  var_1 endon("death");

  if(!isDefined(var_1.goal)) {
    var_1.goal = var_1;
  }

  if(isDefined(var_3)) {
    var_3 = squared(var_3);
  }

  var_4 = [];

  foreach(var_6 in var_0) {
    if(!isDefined(var_6.in_use) && scripts\engine\utility::within_fov(var_1.origin, var_1.angles, var_6.origin, 0) && var_6 != var_1.goal && (!isDefined(var_3) || distancesquared(var_1.origin, var_6.origin) > var_3)) {
      var_4 = scripts\engine\utility::array_add(var_4, var_6);
    }
  }

  if(var_4.size == 0) {
    var_4 = var_0;
  }

  var_8 = var_4;
  var_9 = [];

  if(isDefined(var_2)) {
    var_10 = vectortoangles(var_2.origin - var_1.origin);

    foreach(var_6 in var_0) {
      if(isDefined(var_6.in_use) || scripts\engine\utility::within_fov(var_1.origin, var_10, var_6.origin, 0.65) || var_6 == var_1.goal) {
        var_9 = scripts\engine\utility::array_add(var_9, var_6);
      }
    }
  }

  var_4 = scripts\engine\utility::array_remove_array(var_4, var_9);

  if(var_4.size > 0) {
    return var_4;
  }

  var_13 = scripts\engine\utility::array_remove_array(var_0, var_9);

  if(isDefined(var_2) && var_13.size > 0) {
    return var_13;
  }

  return var_8;
}

_id_7A2F(var_0, var_1, var_2) {
  level endon("sa_dropship_cleanup");
  var_1 endon("death");

  if(isDefined(var_2)) {
    return var_2;
  }

  var_0 = scripts\engine\utility::array_randomize(var_0);

  for(;;) {
    foreach(var_4 in var_0) {
      if(!isDefined(var_4.in_use)) {
        return var_4;
      }
    }

    wait 0.05;
  }
}

_id_92E7(var_0) {
  self endon("death");
  self notify("idle_runner_walk_alert");
  self endon("idle_runner_walk_alert");
  var_1 = squared(var_0 * 2);
  var_0 = squared(var_0);

  for(;;) {
    self waittill("start_running", var_2);

    while(isDefined(self.running) && distancesquared(self.origin, var_2.origin) > var_1) {
      wait 0.05;
    }

    if(isDefined(self.running) && scripts\sp\utility::_id_CFAC(self)) {
      thread _id_92F1(undefined, undefined, 1, undefined, 256);
      continue;
    }

    while(isDefined(self.running) && distancesquared(self.origin, var_2.origin) > var_0) {
      wait 0.05;
    }

    if(isDefined(self.running)) {
      scripts\sp\utility::_id_51E1(scripts\engine\utility::random(level._id_E997[self.script_noteworthy]));
    }
  }
}

_id_B272(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("sa_dropship_cleanup");
  self endon("death");

  if(isDefined(var_0)) {
    self.index = var_0;
  } else {
    self.index = "idle";
  }

  if(isDefined(var_1)) {
    self.script_noteworthy = var_1;
  }

  self._id_1FBB = "generic";
  _id_92F2();
  thread scripts\sp\utility::_id_B14F(1);
  thread _id_92E7(128);
  thread _id_92F1(var_2, var_3, var_4, var_5);

  if(self.index != "jackal") {
    self.gender = _id_7B00();
    self._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), self, "J_Lip_Top");
    thread _id_92EB();
  }

  level._id_E9BE = scripts\engine\utility::array_add(level._id_E9BE, self);
  level._id_E9BE = scripts\engine\utility::array_remove_duplicates(level._id_E9BE);

  if(isDefined(var_6) && var_6) {
    level thread _id_A5EB(self.script_noteworthy, self.classname, self.index);
  }
}

_id_92F2() {
  var_0 = randomfloatrange(0.95, 1.15);
  scripts\asm\asm::_id_237B(var_0);
  scripts\sp\utility::_id_51E1(scripts\engine\utility::random(level._id_E997[self.script_noteworthy]));

  if(var_0 > 1 && scripts\engine\utility::cointoss()) {
    scripts\sp\utility::_id_F48E("casual", "walk_frantic");
  }
}

_id_A5EB(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "idle";
  }

  level thread _id_A5EC(var_0, var_1, var_2);
}

_id_A5EC(var_0, var_1, var_2) {
  level endon("sa_dropship_cleanup");

  for(;;) {
    wait 1;
    var_3 = scripts\engine\utility::array_reverse(sortbydistance(level._id_E9BE, level.player.origin));

    foreach(var_5 in var_3) {
      if(var_5.index != var_2) {
        continue;
      }
      if(isDefined(var_0) && var_5.script_noteworthy != var_0) {
        continue;
      }
      if(isDefined(var_1) && var_5.classname != var_1) {
        continue;
      }
      if(distancesquared(level.player.origin, var_5.origin) < 147456 || scripts\sp\utility::_id_CFAC(var_5)) {
        var_5._id_A901 = gettime();
      }

      if(!isDefined(var_5._id_A901) || gettime() - var_5._id_A901 > 5000) {
        level._id_E9BE = scripts\engine\utility::array_remove(level._id_E9BE, var_5);
        var_5 delete();
        return 1;
      }
    }
  }
}

_id_106FE() {
  level endon("sa_dropship_cleanup");
  var_0 = scripts\sp\vehicle::_id_1080E("sa_forklift");
  var_1 = getspawnerarray("sa_ally_ambient_crew");

  foreach(var_3 in var_0) {
    var_4 = scripts\sp\utility::_id_5CC9(scripts\engine\utility::random(var_1));
    var_4._id_1FBB = "generic";
    var_4._id_9B89 = 1;
    var_4._id_EEC9 = 0;
    var_4._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), var_4, "J_Lip_Top");
    var_4 scripts\sp\names::_id_7B07(var_4.voice);
    var_4 _meth_8307(var_4.name, &"");
    createnavrepulsor(var_3.script_noteworthy, 0, var_3, 192);
    var_3._id_5BC8 = var_4;
    var_3 thread scripts\sp\vehicle_aianim::_id_8739(var_4);
    var_3._id_1FBB = "forklift";
    var_3 thread scripts\sp\anim::_id_1F35(var_3, "raise_lift");
    var_3._id_3A5D = scripts\engine\utility::getclosest(var_3.origin, getEntArray("sa_cargo", "targetname"), 192);
    var_5 = getEnt(var_3._id_3A5D.target, "targetname");
    var_5 linkTo(var_3._id_3A5D);
    var_3._id_3A5D linkTo(var_3, "j_lifter_mid", (44, 0, 12), (0, 90, 0.6));
    var_3._id_11083 = 0;
    var_3._id_D30A = scripts\engine\utility::getclosest(var_3.origin, getEntArray("trig_forklift_stop_plr", "targetname"), 256);

    if(isDefined(var_3._id_D30A)) {
      var_3._id_D30A enablelinkTo();
      var_3._id_D30A linkTo(var_3);
      var_3 thread _id_7314(var_3._id_D30A);
    }

    var_3._id_19F5 = scripts\engine\utility::getclosest(var_3.origin, getEntArray("trig_forklift_stop_ai", "targetname"), 256);

    if(isDefined(var_3._id_19F5)) {
      var_3._id_19F5 enablelinkTo();
      var_3._id_19F5 linkTo(var_3);
      var_3 thread _id_7314(var_3._id_19F5);
    }

    var_3._id_12715 = scripts\engine\utility::getclosest(var_3.origin, getEntArray("trig_forklift_ai", "targetname"), 256);

    if(isDefined(var_3._id_12715)) {
      var_3._id_12715 enablelinkTo();
      var_3._id_12715 linkTo(var_3);
      var_3 thread _id_72FF();
    }

    var_6 = getvehiclenode(var_3.script_noteworthy, "targetname");
    var_3 scripts\engine\utility::delaythread(0.05, scripts\sp\vehicle::_id_2471, var_6);
  }

  level._id_E9AC = var_0;
}

_id_7314(var_0) {
  level endon("sa_dropship_cleanup");
  self endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);
    _id_7313();

    if(isai(var_1)) {
      self._id_274C = "sa_bp_" + scripts\sp\utility::string(randomintrange(100000, 999999));
      badplace_cylinder(self._id_274C, -1, self.origin, 192, 192, "allies", "neutral");
    }

    while(isDefined(var_1) && var_1 istouching(var_0)) {
      scripts\engine\utility::waitframe();
    }

    if(isDefined(self._id_274C)) {
      badplace_delete(self._id_274C);
      self._id_274C = undefined;
    }

    _id_7303();
  }
}

_id_72FF() {
  level endon("sa_dropship_cleanup");
  self endon("death");

  for(;;) {
    self._id_12715 waittill("trigger", var_0);

    if(isDefined(var_0) && isDefined(var_0._id_13868) && var_0._id_13868 < gettime() - 3000) {
      var_0 thread _id_92F1(undefined, self);
    }

    wait 0.05;
  }
}

_id_7313() {
  self._id_11083 = self._id_11083 + 1;
  self vehicle_setspeed(0, 5, 5);
}

_id_7303() {
  self._id_11083 = self._id_11083 - 1;

  if(self._id_11083 < 1) {
    self resumespeed(1);
  }
}

_id_FC57(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1)) {
    var_1 endon("death");
  }

  if(isDefined(var_5)) {
    var_5 = var_5 * 20;
  }

  if(isDefined(var_1) && isDefined(var_2)) {
    for(var_8 = 1; !_id_FC56(var_1, var_2, var_3, var_4, 0.766, var_7); var_8++) {
      if(isDefined(var_5) && var_8 > var_5) {
        return 0;
      }

      wait 0.05;
    }
  }

  if(isDefined(var_6)) {
    scripts\engine\utility::flag_set(var_6);
  }

  scripts\sp\utility::_id_1034D(var_0);
  return 1;
}

_id_10345(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("stop_reaction");
  self endon("reaction_end");
  self endon("stop_gesture_reaction");
  self endon("stop_smart_reaction");
  self notify("smart_dialog_lookat_gesture");
  self endon("smart_dialog_lookat_gesture");
  var_1[0] endon("death");
  var_6 = var_1[0];
  var_7 = _id_95A8([var_1[1], 192.0]);
  var_8 = _id_95A8([var_1[2]]);
  var_9 = _id_95A8([var_2[0]]);
  var_10 = _id_95A8([var_2[1]]);
  var_11 = _id_95A8([var_2[2]]);
  var_12 = _id_95A8([var_2[3]]);
  var_13 = _id_95A8([var_2[4], 0.766]);

  if(isDefined(var_12)) {
    var_12 = var_12 * 20;
  }

  if(isDefined(self._id_B398)) {
    self._id_B398 = undefined;

    if(isDefined(var_5) && scripts\engine\utility::flag(var_5)) {
      scripts\engine\utility::flag_clear(var_5);
    } else if(isDefined(var_3) && scripts\engine\utility::flag(var_3)) {
      scripts\engine\utility::flag_clear(var_3);
    }
  }

  if(!isDefined(self._id_9BFC) || isDefined(self._id_9BFC) && !self._id_9BFC) {
    thread scripts\sp\interaction_manager::_id_DD45(var_7, var_6, 0, 1);
  }

  if(isDefined(var_9)) {
    for(var_14 = 1; !_id_FC56(self, var_9, var_10, var_11, var_13, var_4); var_14++) {
      if(isDefined(var_12) && var_14 > var_12) {
        return 0;
      }

      wait 0.05;
    }
  }

  if(isDefined(var_3)) {
    self._id_B398 = 1;
    scripts\engine\utility::flag_set(var_3);
  }

  scripts\sp\interaction_manager::_id_CE17(var_0);

  if(isDefined(var_5)) {
    scripts\engine\utility::flag_clear(var_5);
  }

  self._id_B398 = undefined;

  if(isDefined(var_8) && !var_8) {
    self notify("stop_reaction_look");
    scripts\sp\utility::_id_77B9(0.5);
  } else if(!isDefined(var_8) || !var_8) {
    var_15 = randomfloatrange(0.5, 1.5);
    thread scripts\sp\utility::_id_C12D("stop_reaction_look", var_15);
    scripts\engine\utility::delaythread(var_15, scripts\sp\utility::_id_77B9, 0.7);
  }

  return 1;
}

_id_B397(var_0, var_1, var_2) {
  self endon("death");
  self notify("stop_mars_smart_basic_interaction");
  self endon("stop_mars_smart_basic_interaction");

  if(!isDefined(var_2)) {
    var_2 = "near_conversation";
  }

  var_3 = var_0;

  for(;;) {
    _id_10345(var_3, [level.player, 110], [85, 1, [0.4]], var_2, ["in_conversation", "near_conversation"]);
    scripts\engine\utility::flag_clear(var_2);
    wait(randomfloatrange(10, 20));
  }
}

_id_B38E(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_1) || !var_1) {
    self notify("stop_idle_stop_for");
  }

  if(!isDefined(var_0) || !var_0) {
    self notify("stop_mars_smart_basic_interaction");
  }

  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }

  self notify("stop_smart_reaction");
  self notify("stop_reaction_look");
  thread scripts\sp\utility::_id_77B9(var_2);
}

_id_1F3C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  var_0 endon("death");

  if(isDefined(var_6)) {
    self endon(var_6);
  }

  scripts\sp\anim::_id_1F35(var_0, var_1, var_4, undefined, var_5);
  thread scripts\sp\anim::_id_1EEA(var_0, var_2, var_3, var_4, undefined, var_5);
}

_id_7B00() {
  self endon("death");

  if(!isDefined(level._id_E9A6) || level._id_E9A6 > 2) {
    level._id_E9A6 = 0;
  }

  if(!isDefined(level._id_E9C5) || level._id_E9C5 > 3) {
    level._id_E9C5 = 0;
  }

  if(issubstr(self.model, "female") || issubstr(self.headmodel, "female")) {
    level._id_E9A6++;
    return "female_" + scripts\sp\utility::string(level._id_E9A6);
  }

  level._id_E9C5++;
  return "male_" + scripts\sp\utility::string(level._id_E9C5);
}

_id_FC56(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_1 = var_1 * var_1;

  if(isarray(var_3)) {
    var_4 = var_3[0];
    var_3 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.766;
  }

  if(isDefined(var_5) && !isarray(var_5)) {
    var_5 = [var_5];
  } else if(!isDefined(var_5)) {
    var_5 = [];
  }

  foreach(var_7 in var_5) {
    if(scripts\engine\utility::flag(var_7)) {
      return 0;
    }
  }

  if(distancesquared(level.player.origin, var_0.origin) > var_1) {
    return 0;
  }

  if(isDefined(var_2) && var_2 && isai(var_0) && !scripts\sp\utility::_id_CFAC(var_0)) {
    return 0;
  } else if(isDefined(var_2) && var_2 && !isai(var_0) && !scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.766)) {
    return 0;
  }

  if(isDefined(var_3) && var_3 && !scripts\engine\utility::within_fov(var_0.origin, var_0.angles, level.player.origin, var_4)) {
    return 0;
  }

  return 1;
}

_id_95A8(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      return var_2;
    }
  }

  return undefined;
}