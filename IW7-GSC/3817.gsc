/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3817.gsc
**************************************/

_id_ADFC() {
  level endon("stop_broadcast");
  _id_0EDB::_id_984A();
  var_0 = _id_7C59();

  if(!isDefined(var_0)) {
    return;
  }
  level._id_FD7A = var_0;
  var_1 = "broadcast_speaker";
  var_2 = "lounge_brdcst_still";
  var_3 = "lounge_brdcst_bink";
  var_4 = _id_7C5A(var_0);
  var_5 = _id_7C5B(var_0);
  var_6 = _id_7C5E(var_0);
  thread _id_0EDB::_id_984C(var_0, var_1, var_4, var_5, var_2, var_3);
  scripts\engine\utility::flag_wait("broadcast_setup_complete");
  _id_F2E9();
  var_7 = getEnt("shipcrib_broadcast_trigger", "targetname");
  var_7 waittill("trigger");
  _id_F2EA();
  _id_0EDB::_id_CCB8();
  _id_0EDB::_id_13744();
  thread _id_CCB7(var_6);
  _id_0EDB::_id_62BF();
}

_id_CCB7(var_0) {
  [[var_0]]();
  scripts\engine\utility::flag_set("broadcast_postfunc_complete");
}

_id_7C59() {
  var_0 = level.player _meth_84C6("lastCompletedMission");

  if(isDefined(var_0) && var_0 != "") {
    var_1 = _id_7BDC(var_0);
  } else {
    var_1 = _id_792E();
  }

  return var_1;
}

_id_7BDC(var_0) {
  var_1 = undefined;

  if(var_0 == "sa_moon" || var_0 == "titanjackal" || var_0 == "rogue") {
    switch (var_0) {
      case "sa_moon":
        var_1 = "moonport_broadcast";
        break;
      case "titanjackal":
        var_1 = "titan_broadcast";
        break;
      case "rogue":
        var_1 = "prisoner_broadcast";
        break;
      default:
        var_1 = "rogue_broadcast";
    }
  } else if(issubstr(var_0, "sa_") && var_0 != "sa_moon")
    var_1 = _id_7C25(var_0);
  else if(issubstr(var_0, "ja_")) {
    var_1 = _id_7A55();
  }

  return var_1;
}

_id_7C25(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "sa_assassination":
      var_1 = "assassination_broadcast";
      break;
    case "sa_empambush":
      var_1 = "empambush_broadcast";
      break;
    case "sa_vips":
      var_1 = "vips_broadcast";
      break;
    case "sa_wounded":
      var_1 = "wounded_broadcast";
      break;
  }

  if(isDefined(level._id_EFF6) && level._id_EFF6) {
    _id_F2E9(var_1);
    var_1 = "geneva_broadcast";
  }

  return var_1;
}

_id_7A55() {
  var_0 = undefined;
  var_1 = _id_7BDD();

  if(var_1["moonport_broadcast"] == "open") {
    var_0 = "moonport_broadcast";
  } else if(var_1["geneva_broadcast"] == "open") {
    var_0 = "geneva_broadcast";
  } else if(var_1["titan_broadcast"] == "open") {
    var_0 = "titan_broadcast";
  } else if(var_1["assassination_broadcast"] == "open") {
    var_0 = "assassination_broadcast";
  } else if(var_1["empambush_broadcast"] == "open") {
    var_0 = "empambush_broadcast";
  } else if(var_1["vips_broadcast"] == "open") {
    var_0 = "vips_broadcast";
  } else if(var_1["wounded_broadcast"] == "open") {
    var_0 = "wounded_broadcast";
  } else {
    var_0 = "rogue_broadcast";
  }

  return var_0;
}

_id_955D() {}

_id_7BDD() {
  var_0 = [];
  var_0["moonport_broadcast"] = level.player _meth_84C6("scNewsReels", "newsVideo1");
  var_0["geneva_broadcast"] = level.player _meth_84C6("scNewsReels", "newsVideo2");
  var_0["titan_broadcast"] = level.player _meth_84C6("scNewsReels", "newsVideo3");
  var_0["assassination_broadcast"] = level.player _meth_84C6("scNewsReels", "newsVideo4");
  var_0["empambush_broadcast"] = level.player _meth_84C6("scNewsReels", "newsVideo5");
  var_0["vips_broadcast"] = level.player _meth_84C6("scNewsReels", "newsVideo6");
  var_0["wounded_broadcast"] = level.player _meth_84C6("scNewsReels", "newsVideo7");
  return var_0;
}

_id_F2E9(var_0) {
  if(!isDefined(var_0) && isDefined(level._id_FD7A)) {
    var_0 = level._id_FD7A;
  }

  var_1 = _id_7883(var_0);

  if(isDefined(var_1)) {
    if(level.player _meth_84C6("scNewsReels", var_1) == "locked") {
      level.player _meth_84C7("scNewsReels", var_1, "open");
    }
  }
}

_id_F2EA(var_0) {
  if(!isDefined(var_0) && isDefined(level._id_FD7A)) {
    var_0 = level._id_FD7A;
  }

  var_1 = _id_7883(var_0);

  if(isDefined(var_1)) {
    if(level.player _meth_84C6("scNewsReels", var_1) == "open") {
      level.player _meth_84C7("scNewsReels", var_1, "watched");
    }
  }
}

_id_7883(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "moonport_broadcast":
      var_1 = "newsVideo1";
      break;
    case "geneva_broadcast":
      var_1 = "newsVideo2";
      break;
    case "titan_broadcast":
      var_1 = "newsVideo3";
      break;
    case "assassination_broadcast":
      var_1 = "newsVideo4";
      break;
    case "empambush_broadcast":
      var_1 = "newsVideo5";
      break;
    case "vips_broadcast":
      var_1 = "newsVideo6";
      break;
    case "wounded_broadcast":
      var_1 = "newsVideo7";
      break;
  }

  return var_1;
}

_id_792E() {
  var_0 = undefined;

  switch (level._id_10CDA) {
    case "sc_sa_assa":
      var_0 = "assassination_broadcast";
      break;
    case "sc_sa_emp":
      var_0 = "empambush_broadcast";
      break;
    case "sc_sa_vips":
      var_0 = "vips_broadcast";
      break;
    case "sc_sa_wound":
      var_0 = "wounded_broadcast";
      break;
  }

  if(!isDefined(var_0)) {
    switch (level.script) {
      case "shipcrib_europa":
        var_0 = "moonport_broadcast";
        break;
      case "shipcrib_titan":
        var_0 = "geneva_broadcast";
        break;
      case "shipcrib_rogue":
        var_0 = "rogue_broadcast";
        break;
      case "shipcrib_prisoner":
        var_0 = "prisoner_broadcast";
        break;
      default:
        var_0 = "rogue_broadcast";
    }
  }

  return var_0;
}

_id_7C5D(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(level._id_FD7A)) {
      var_0 = level._id_FD7A;
    }
  }

  if(!isDefined(level._id_30DA)) {
    _id_9849();
  }

  if(isDefined(level._id_30DA[var_0])) {
    return level._id_30DA[var_0];
  }
}

_id_9849() {
  var_0 = [];
  var_0["moonport_broadcast"] = "sc_europa_world_newscast";
  var_0["geneva_broadcast"] = "sc_titan_world_newscast";
  var_0["titan_broadcast"] = "sc_rogue_world_newscast";
  var_0["prisoner_broadcast"] = "sc_world_lounge_titanloop";
  var_0["assassination_broadcast"] = "sc_assault_world_newscast_assassination";
  var_0["empambush_broadcast"] = "sc_assault_world_newscast_empambush";
  var_0["vips_broadcast"] = "sc_assault_world_newscast_vips";
  var_0["wounded_broadcast"] = "sc_assault_world_newscast_wounded";
  var_0["rogue_broadcast"] = "sc_world_lounge_titanloop";
  level._id_30DA = var_0;
}

_id_7C5C(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(level._id_30DB)) {
      _id_9848();
    }

    if(isDefined(level._id_30DB[var_0])) {
      return level._id_30DB[var_0];
    }
  }
}

_id_9848() {
  var_0 = [];
  var_0["moonport_broadcast"] = "bink3d_broadcast_news_shipcrib_europa";
  var_0["geneva_broadcast"] = "bink3d_broadcast_news_shipcrib_titan";
  var_0["titan_broadcast"] = "bink3d_broadcast_news";
  var_0["prisoner_broadcast"] = "bink3d_broadcast_news";
  var_0["assassination_broadcast"] = "bink3d_broadcast_news";
  var_0["empambush_broadcast"] = "bink3d_broadcast_news";
  var_0["vips_broadcast"] = "bink3d_broadcast_news";
  var_0["wounded_broadcast"] = "bink3d_broadcast_news";
  level._id_30DB = var_0;
}

_id_7C5A(var_0) {
  if(!isDefined(level._id_30D7)) {
    _id_9846();
  }

  if(isDefined(level._id_30D7[var_0])) {
    return level._id_30D7[var_0];
  }
}

_id_48AB(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7._id_1FBB = var_0;
  var_7._id_DD4D = var_1;
  var_7._id_DD42 = var_3;
  var_7._id_C6B3 = var_4;
  var_7._id_10880 = var_2;
  var_7.gender = var_5;
  var_7._id_C7D9 = "anim_only";

  if(isDefined(var_4) && isDefined(var_6)) {
    var_7._id_C7D9 = "custom_interaction";
  }

  if(isDefined(var_1) && !isDefined(var_6)) {
    var_7._id_C7D9 = "anim_interaction";
  }

  return var_7;
}

_id_9846() {
  var_0 = [];
  var_0["moonport_broadcast"] = _id_1716();
  var_0["geneva_broadcast"] = _id_16E2();
  var_0["titan_broadcast"] = _id_1737();
  var_0["prisoner_broadcast"] = _id_1737();
  var_0["assassination_broadcast"] = _id_1739();
  var_0["empambush_broadcast"] = _id_1739();
  var_0["vips_broadcast"] = _id_1739();
  var_0["wounded_broadcast"] = _id_1739();
  var_0["rogue_broadcast"] = _id_1737();
  level._id_30D7 = var_0;
}

_id_1716() {
  var_0 = [];
  var_0[0] = _id_48AB("broadcast_audience_01", undefined, "spawner_mech", undefined, undefined, "female");
  var_0[1] = _id_48AB("broadcast_audience_02", undefined, "spawner_marine_casual");
  var_0[2] = _id_48AB("broadcast_audience_03", undefined);
  var_0[3] = _id_48AB("broadcast_audience_04", undefined, "spawner_marine_casual");
  var_0[4] = _id_48AB("broadcast_audience_05", undefined);
  var_0[5] = _id_48AB("broadcast_audience_06", undefined, "spawner_mech");
  return var_0;
}

_id_16E2() {
  var_0 = [];
  var_0[0] = _id_48AB("broadcast_audience_01", undefined, "spawner_marine_casual");
  var_0[1] = _id_48AB("broadcast_audience_02", undefined, "spawner_marine_casual");
  var_0[3] = _id_48AB("broadcast_audience_04", undefined, "spawner_marine_casual");
  var_0[4] = _id_48AB("broadcast_audience_05");
  var_0[6] = _id_48AB("broadcast_audience_07");
  var_0[7] = _id_48AB("broadcast_audience_08", undefined, "spawner_mech");
  var_0[8] = _id_48AB("broadcast_audience_09");
  return var_0;
}

_id_1739() {
  var_0 = [];
  var_0[0] = _id_48AB("broadcast_audience_01", undefined, "spawner_mech", undefined, undefined, "female");
  var_0[1] = _id_48AB("broadcast_audience_02", undefined, "spawner_marine_casual");
  var_0[2] = _id_48AB("broadcast_audience_03");
  var_0[3] = _id_48AB("broadcast_audience_04");
  var_0[4] = _id_48AB("broadcast_audience_05", "broadcast_reaction_03", "spawner_mech", "group2");
  var_0[5] = _id_48AB("broadcast_audience_06", "broadcast_reaction_04", undefined, "group2");
  return var_0;
}

_id_1737() {
  var_0 = [];
  var_0[0] = _id_48AB("broadcast_audience_01", undefined, "spawner_mech", undefined, undefined, "female");
  var_0[1] = _id_48AB("broadcast_audience_02", undefined, "spawner_marine_casual");
  var_0[2] = _id_48AB("broadcast_audience_03", undefined, "spawner_marine_casual");
  var_0[3] = _id_48AB("broadcast_audience_04");
  var_0[4] = _id_48AB("broadcast_audience_05", undefined, "spawner_marine_casual");
  var_0[5] = _id_48AB("broadcast_audience_06", undefined, "spawner_mech");
  return var_0;
}

_id_7C5B(var_0) {
  if(!isDefined(level._id_30D9)) {
    _id_9847();
  }

  if(isDefined(level._id_30D9[var_0])) {
    return level._id_30D9[var_0];
  }
}

_id_9847() {
  var_0 = [];
  var_0["moonport_broadcast"] = ::_id_ADDD;
  var_0["geneva_broadcast"] = ::_id_ADD1;
  var_0["titan_broadcast"] = ::_id_ADEA;
  var_0["prisoner_broadcast"] = ::_id_ADEA;
  var_0["assassination_broadcast"] = ::_id_ADEA;
  var_0["empambush_broadcast"] = ::_id_ADEA;
  var_0["vips_broadcast"] = ::_id_ADEA;
  var_0["wounded_broadcast"] = ::_id_ADEA;
  var_0["rogue_broadcast"] = ::_id_ADE7;
  level._id_30D9 = var_0;
}

#using_animtree("generic_human");

_id_ADDD() {
  level._id_EC85["broadcast_audience_01"]["broadcast_scene"] = % shipcrib_europa_lounge_newsreel_scene_un1_scene;
  level._id_EC85["broadcast_audience_02"]["broadcast_scene"] = % shipcrib_europa_lounge_newsreel_scene_un2_scene;
  level._id_EC85["broadcast_audience_03"]["broadcast_scene"] = % shipcrib_europa_lounge_newsreel_scene_un3_scene;
  level._id_EC85["broadcast_audience_04"]["broadcast_scene"] = % shipcrib_europa_lounge_newsreel_scene_un4_scene;
  level._id_EC85["broadcast_audience_05"]["broadcast_scene"] = % shipcrib_europa_lounge_newsreel_scene_un5_scene;
  level._id_EC85["broadcast_audience_06"]["broadcast_scene"] = % shipcrib_europa_lounge_newsreel_scene_un6_scene;
  level._id_EC85["broadcast_audience_07"]["broadcast_scene"] = % shipcrib_europa_lounge_newsreel_scene_un7_scene;
  level._id_EC85["broadcast_audience_08"]["broadcast_scene"] = % shipcrib_europa_lounge_newsreel_scene_un8_scene;
  level._id_EC85["broadcast_audience_01"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un1_idle;
  level._id_EC85["broadcast_audience_02"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un2_idle;
  level._id_EC85["broadcast_audience_03"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un3_idle;
  level._id_EC85["broadcast_audience_04"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un4_idle;
  level._id_EC85["broadcast_audience_05"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un5_idle;
  level._id_EC85["broadcast_audience_06"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un6_idle;
}

_id_ADD1() {
  level._id_EC85["broadcast_audience_01"]["broadcast_scene"] = % shipcrib_titan_newsreel_scene_01;
  level._id_EC85["broadcast_audience_02"]["broadcast_scene"] = % shipcrib_titan_newsreel_scene_02;
  level._id_EC85["broadcast_audience_03"]["broadcast_scene"] = % shipcrib_titan_newsreel_scene_03;
  level._id_EC85["broadcast_audience_04"]["broadcast_scene"] = % shipcrib_titan_newsreel_scene_04;
  level._id_EC85["broadcast_audience_05"]["broadcast_scene"] = % shipcrib_titan_newsreel_scene_05;
  level._id_EC85["broadcast_audience_07"]["broadcast_scene"] = % shipcrib_titan_newsreel_scene_09;
  level._id_EC85["broadcast_audience_08"]["broadcast_scene"] = % shipcrib_titan_newsreel_scene_pu1;
  level._id_EC85["broadcast_audience_09"]["broadcast_scene"] = % shipcrib_titan_newsreel_scene_pu2;
  level._id_EC85["broadcast_audience_01"]["broadcast_post_scene"][0] = % shipcrib_titan_newsreel_loop_01;
  level._id_EC85["broadcast_audience_02"]["broadcast_post_scene"][0] = % shipcrib_titan_newsreel_loop_02;
  level._id_EC85["broadcast_audience_03"]["broadcast_post_scene"][0] = % shipcrib_titan_newsreel_loop_03;
  level._id_EC85["broadcast_audience_04"]["broadcast_post_scene"][0] = % shipcrib_titan_newsreel_loop_04;
  level._id_EC85["broadcast_audience_05"]["broadcast_post_scene"][0] = % shipcrib_titan_newsreel_loop_05;
  level._id_EC85["broadcast_audience_07"]["broadcast_post_scene"][0] = % shipcrib_titan_newsreel_loop_09;
  level._id_EC85["broadcast_audience_08"]["broadcast_post_scene"][0] = % shipcrib_titan_newsreel_loop_pu1;
  level._id_EC85["broadcast_audience_09"]["broadcast_post_scene"][0] = % shipcrib_titan_newsreel_loop_pu2;
}

_id_ADEA() {
  level._id_EC85["broadcast_audience_01"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un1_idle;
  level._id_EC85["broadcast_audience_02"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un2_idle;
  level._id_EC85["broadcast_audience_03"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un3_idle_notalk;
  level._id_EC85["broadcast_audience_04"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un4_idle_notalk;
  level._id_EC85["broadcast_audience_05"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un5_idle;
  level._id_EC85["broadcast_audience_06"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un6_idle;
  level._id_EC89["broadcast_audience_03"]["broadcast_post_scene"] = 1.5;
  level._id_EC89["broadcast_audience_04"]["broadcast_post_scene"] = 1.5;
  level._id_EC89["broadcast_audience_05"]["broadcast_post_scene"] = 0.7;
  level._id_EC89["broadcast_audience_06"]["broadcast_post_scene"] = 0.7;
  level._id_EC85["broadcast_audience_03"]["broadcast_talking"][0] = % shipcrib_europa_lounge_newsreel_scene_un3_idle_noface;
  level._id_EC85["broadcast_audience_04"]["broadcast_talking"][0] = % shipcrib_europa_lounge_newsreel_scene_un4_idle_noface;
  level._id_EC85["broadcast_audience_05"]["broadcast_talking"][0] = % shipcrib_europa_lounge_newsreel_scene_un5_idle;
  level._id_EC85["broadcast_audience_06"]["broadcast_talking"][0] = % shipcrib_europa_lounge_newsreel_scene_un6_idle;
  level._id_EC89["broadcast_audience_03"]["broadcast_talking"] = 0.7;
  level._id_EC89["broadcast_audience_04"]["broadcast_talking"] = 0.7;
  level._id_EC89["broadcast_audience_05"]["broadcast_talking"] = 0.7;
  level._id_EC89["broadcast_audience_06"]["broadcast_talking"] = 0.7;
}

_id_ADE7() {
  level._id_EC85["broadcast_audience_01"]["broadcast_post_scene"][0] = % shipcrib_titan_newsreel_loop_pu1;
  level._id_EC85["broadcast_audience_02"]["broadcast_post_scene"][0] = % shipcrib_titan_newsreel_loop_pu2;
  level._id_EC85["broadcast_audience_03"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un3_idle_notalk;
  level._id_EC85["broadcast_audience_04"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un4_idle_notalk;
  level._id_EC85["broadcast_audience_05"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un5_idle;
  level._id_EC85["broadcast_audience_06"]["broadcast_post_scene"][0] = % shipcrib_europa_lounge_newsreel_scene_un6_idle;
  level._id_EC85["broadcast_audience_03"]["broadcast_talking"][0] = % shipcrib_europa_lounge_newsreel_scene_un3_idle_noface;
  level._id_EC85["broadcast_audience_04"]["broadcast_talking"][0] = % shipcrib_europa_lounge_newsreel_scene_un4_idle_noface;
  level._id_EC89["broadcast_audience_03"]["broadcast_talking"] = 0.5;
  level._id_EC89["broadcast_audience_04"]["broadcast_talking"] = 0.5;
}

_id_7C5E(var_0) {
  if(!isDefined(level._id_30DF)) {
    _id_984B();
  }

  if(isDefined(level._id_30DF[var_0])) {
    return level._id_30DF[var_0];
  }
}

_id_984B() {
  var_0 = [];
  var_0["moonport_broadcast"] = ::_id_BB4F;
  var_0["geneva_broadcast"] = ::_id_7782;
  var_0["titan_broadcast"] = ::_id_11954;
  var_0["prisoner_broadcast"] = ::_id_D937;
  var_0["assassination_broadcast"] = ::_id_2393;
  var_0["empambush_broadcast"] = ::_id_6191;
  var_0["vips_broadcast"] = ::_id_1342E;
  var_0["wounded_broadcast"] = ::_id_13DD1;
  var_0["rogue_broadcast"] = ::_id_E641;
  level._id_30DF = var_0;
}

_id_BB4F() {
  level endon("stop_broadcast");
  var_0 = _id_0EDB::_id_7E0E("broadcast_audience_01");
  var_1 = _id_0EDB::_id_7E0E("broadcast_audience_01");
}

_id_7782() {
  level endon("stop_broadcast");
  wait 4;
  var_0 = _id_0EDB::_id_7E0E("broadcast_audience_01");
  var_1 = _id_0EDB::_id_7E0E("broadcast_audience_09");
  var_2 = _id_0EDB::_id_7881();
}

_id_11954() {
  level endon("stop_broadcast");
  var_0 = _id_0EDB::_id_7E0E("broadcast_audience_03");
  var_1 = _id_0EDB::_id_7E0E("broadcast_audience_04");
  var_2 = _id_0EDB::_id_7881();

  while(distance2d(level.player.origin, var_2.origin) > 400) {
    scripts\engine\utility::waitframe();
  }

  var_2 notify(var_0._id_1FBB + "_stop_idle");
  var_2 notify(var_1._id_1FBB + "_stop_idle");
  var_2 thread scripts\sp\anim::_id_1EEA(var_0, "broadcast_talking", "end_talking");
  var_2 thread scripts\sp\anim::_id_1EEA(var_1, "broadcast_talking", "end_talking");
  var_0 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_1 scripts\sp\utility::_id_7799(var_0 gettagorigin("j_head"));
  wait 0.33;
  var_0 _id_CD78("sc_rogue_un6_iwasonlevel3whe");
  var_1 _id_CD78("sc_rogue_un5_ididntknowyoual");
  var_0 _id_CD78("sc_rogue_un6_yeahdocclearedm");
  var_0 _id_CD78("sc_rogue_un6_buttheywerentto");
  var_0 _id_CD78("sc_rogue_un6_3stepsforwardan");
  var_1 _id_CD78("sc_rogue_un5_shit");
  var_2 notify("end_talking");
  var_2 thread scripts\sp\anim::_id_1EEA(var_0, "broadcast_post_scene");
  var_2 thread scripts\sp\anim::_id_1EEA(var_1, "broadcast_post_scene");
  var_0 scripts\sp\utility::_id_77B9(0.7);
  wait 0.4;
  var_1 scripts\sp\utility::_id_77B9(0.8);
}

_id_D937() {
  level endon("stop_broadcast");
  var_0 = _id_0EDB::_id_7E0E("broadcast_audience_03");
  var_1 = _id_0EDB::_id_7E0E("broadcast_audience_04");
  var_2 = _id_0EDB::_id_7881();

  while(distance2d(level.player.origin, var_2.origin) > 400) {
    scripts\engine\utility::waitframe();
  }

  var_2 notify(var_0._id_1FBB + "_stop_idle");
  var_2 notify(var_1._id_1FBB + "_stop_idle");
  var_2 thread scripts\sp\anim::_id_1EEA(var_0, "broadcast_talking", "end_talking");
  var_2 thread scripts\sp\anim::_id_1EEA(var_1, "broadcast_talking", "end_talking");
  var_0 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_1 scripts\sp\utility::_id_7799(var_0 gettagorigin("j_head"));
  wait 0.33;
  var_0 _id_CD78("sc_prisoner_un5_yousureabouttha");
  var_1 _id_CD78("sc_prisoner_un6_yeahtigrisiseng");
  var_0 _id_CD78("sc_prisoner_un5_thenwhatthehell");
  var_1 _id_CD78("sc_prisoner_un6_captainsgottama");
  var_0 _id_CD78("sc_prisoner_un5_whatshethinking");
  var_2 notify("end_talking");
  var_2 thread scripts\sp\anim::_id_1EEA(var_0, "broadcast_post_scene");
  var_2 thread scripts\sp\anim::_id_1EEA(var_1, "broadcast_post_scene");
  var_0 scripts\sp\utility::_id_77B9(0.7);
  wait 0.4;
  var_1 scripts\sp\utility::_id_77B9(0.8);
}

_id_2393() {
  level endon("stop_broadcast");
  var_0 = _id_0EDB::_id_7E0E("broadcast_audience_03");
  var_1 = _id_0EDB::_id_7E0E("broadcast_audience_04");
  var_2 = _id_0EDB::_id_7881();

  while(distance2d(level.player.origin, var_2.origin) > 400) {
    scripts\engine\utility::waitframe();
  }

  var_2 notify(var_0._id_1FBB + "_stop_idle");
  var_2 notify(var_1._id_1FBB + "_stop_idle");
  var_2 thread scripts\sp\anim::_id_1EEA(var_0, "broadcast_talking", "end_talking");
  var_2 thread scripts\sp\anim::_id_1EEA(var_1, "broadcast_talking", "end_talking");
  var_0 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_1 scripts\sp\utility::_id_7799(var_0 gettagorigin("j_head"));
  wait 0.33;
  var_0 _id_CD78("sc_asn_un4_peaceafterwhatt");
  var_1 _id_CD78("sc_asn_un3_dudesoutofhisda");
  var_0 _id_CD78("sc_asn_un5_weshouldbeturni");
  var_1 _id_CD78("sc_asn_un3_nahjustshiphisa");
  var_2 notify("end_talking");
  var_2 thread scripts\sp\anim::_id_1EEA(var_0, "broadcast_post_scene");
  var_2 thread scripts\sp\anim::_id_1EEA(var_1, "broadcast_post_scene");
  var_0 scripts\sp\utility::_id_77B9(0.7);
  wait 0.4;
  var_1 scripts\sp\utility::_id_77B9(0.8);
}

_id_6191() {
  level endon("stop_broadcast");
  var_0 = _id_0EDB::_id_7E0E("broadcast_audience_04");
  var_1 = _id_0EDB::_id_7E0E("broadcast_audience_03");
  var_2 = _id_0EDB::_id_7E0E("broadcast_audience_05");
  var_3 = _id_0EDB::_id_7E0E("broadcast_audience_06");
  var_4 = _id_0EDB::_id_7881();

  while(distance2d(level.player.origin, var_4.origin) > 400) {
    scripts\engine\utility::waitframe();
  }

  var_4 notify(var_0._id_1FBB + "_stop_idle");
  var_4 notify(var_1._id_1FBB + "_stop_idle");
  var_4 thread scripts\sp\anim::_id_1EEA(var_0, "broadcast_talking", "end_talking");
  var_4 thread scripts\sp\anim::_id_1EEA(var_1, "broadcast_talking", "end_talking");
  var_0 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_1 scripts\sp\utility::_id_7799(var_0 gettagorigin("j_head"));
  wait 0.33;
  var_0 _id_CD78("sc_emp_un3_tothefallen");
  var_1 _id_CD78("sc_emp_un5_tothefallen");
  var_4 notify("end_talking");
  var_4 thread scripts\sp\anim::_id_1EEA(var_0, "broadcast_post_scene");
  var_4 thread scripts\sp\anim::_id_1EEA(var_1, "broadcast_post_scene");
  var_0 scripts\sp\utility::_id_77B9(0.7);
  wait 0.4;
  var_1 scripts\sp\utility::_id_77B9(0.8);
}

_id_1342E() {
  level endon("stop_broadcast");
  var_0 = _id_0EDB::_id_7E0E("broadcast_audience_03");
  var_1 = _id_0EDB::_id_7E0E("broadcast_audience_04");
  var_2 = _id_0EDB::_id_7E0E("broadcast_audience_05");
  var_3 = _id_0EDB::_id_7881();

  while(distance2d(level.player.origin, var_3.origin) > 400) {
    scripts\engine\utility::waitframe();
  }

  var_3 notify(var_0._id_1FBB + "_stop_idle");
  var_3 notify(var_1._id_1FBB + "_stop_idle");
  var_3 thread scripts\sp\anim::_id_1EEA(var_0, "broadcast_talking", "end_talking");
  var_3 thread scripts\sp\anim::_id_1EEA(var_1, "broadcast_talking", "end_talking");
  var_0 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_1 scripts\sp\utility::_id_7799(var_0 gettagorigin("j_head"));
  wait 0.33;
  var_4 = level.player _meth_84C6("saVIPHostagesState");

  if(!isDefined(var_4)) {
    var_4 = "all";
  }

  switch (var_4) {
    case "all":
      var_0 _id_CD78("sc_vips_un2_theycantjusttak");
      var_1 _id_CD78("sc_vips_un3_ourboysgotemou");
      break;
    case "some":
      var_0 _id_CD78("sc_vips_un3_goodnewsistheyr");
      var_1 _id_CD78("sc_vips_un4_notallofem");
      var_0 _id_CD78("sc_vips_un5_setdefdoesnttak");
      break;
    case "failed":
      var_0 _id_CD78("sc_vips_un4_failedrescueatt");
      var_1 _id_CD78("sc_vips_un5_setdefdoesnttake");
      break;
  }

  var_3 notify("end_talking");
  var_3 thread scripts\sp\anim::_id_1EEA(var_0, "broadcast_post_scene");
  var_3 thread scripts\sp\anim::_id_1EEA(var_1, "broadcast_post_scene");
  var_0 scripts\sp\utility::_id_77B9(0.7);
  wait 0.4;
  var_1 scripts\sp\utility::_id_77B9(0.8);
}

_id_13DD1() {
  level endon("stop_broadcast");
  var_0 = _id_0EDB::_id_7E0E("broadcast_audience_03");
  var_1 = _id_0EDB::_id_7E0E("broadcast_audience_04");
  var_2 = _id_0EDB::_id_7E0E("broadcast_audience_05");
  var_3 = _id_0EDB::_id_7E0E("broadcast_audience_06");
  var_4 = _id_0EDB::_id_7881();

  while(distance2d(level.player.origin, var_4.origin) > 400) {
    scripts\engine\utility::waitframe();
  }

  var_4 notify(var_0._id_1FBB + "_stop_idle");
  var_4 notify(var_1._id_1FBB + "_stop_idle");
  var_4 thread scripts\sp\anim::_id_1EEA(var_0, "broadcast_talking", "end_talking");
  var_4 thread scripts\sp\anim::_id_1EEA(var_1, "broadcast_talking", "end_talking");
  var_0 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_1 scripts\sp\utility::_id_7799(var_0 gettagorigin("j_head"));
  wait 0.33;
  var_0 _id_CD78("sc_wnd_un1_helloretributio");
  var_1 _id_CD78("sc_wnd_un4_setdefyoukille");
  var_4 notify("end_talking");
  var_4 thread scripts\sp\anim::_id_1EEA(var_0, "broadcast_post_scene");
  var_4 thread scripts\sp\anim::_id_1EEA(var_1, "broadcast_post_scene");
  var_0 scripts\sp\utility::_id_77B9(0.7);
  wait 0.4;
  var_1 scripts\sp\utility::_id_77B9(0.8);
}

_id_E641() {
  level endon("stop_broadcast");
  wait 2;
  var_0 = _id_0EDB::_id_7E0E("broadcast_audience_01");
  var_1 = _id_0EDB::_id_7E0E("broadcast_audience_01");
}

_id_CD78(var_0) {
  thread scripts\sp\utility::_id_77B7("salute");
  self setanimknob(%facial_talk_1, 10, 0.33, 1);
  scripts\sp\utility::_id_10346(var_0);
  self setanimknob(%facial_talk_1, 0, 0.33, 0);
}