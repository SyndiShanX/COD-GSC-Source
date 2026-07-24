/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\ja_wreckage\ja_wreckage.gsc
*******************************************************/

main() {
  scripts\sp\utility::_id_116CB("ja_wreckage");
  _id_10AE::_id_A0AB();
  scripts\sp\maps\ja_wreckage\gen\ja_wreckage_art::main();
  scripts\sp\maps\ja_wreckage\ja_wreckage_fx::main();
  scripts\sp\maps\ja_wreckage\ja_wreckage_precache::main();
  scripts\sp\utility::_id_F343("launch");
  scripts\sp\utility::_id_1749("launch", ::_id_10C98, "launch", ::_id_B209, undefined, undefined, 1);
  scripts\sp\utility::_id_1749("ace", ::_id_10B93, "ace", ::_id_B176, undefined, undefined, 1);
  scripts\sp\utility::_id_1749("mission_complete", ::_id_10CAE, "mission_complete", ::_id_B20F, undefined, undefined, 1);
  scripts\sp\utility::_id_1749("ftl_test", ::_id_10C57, "ftl_test", ::_id_B1E5, undefined, undefined, 1);
  scripts\sp\load::main();
  scripts\sp\utility::_id_241F(0);
  _id_10AE::_id_9637();
  _id_10AE::_id_9638();
  setsuncolorandintensity(5.0);
  physics_setgravity((0, 0, 0));
  _id_A04D();
  setsaveddvar("r_transShadowEnable", 1);
  setsaveddvar("r_heightfieldSunShadow", 0);
  setsaveddvar("sm_sunSampleSizeNear", 10.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 3);
  setdvarifuninitialized("rotate_cody", 0);
  setdvarifuninitialized("debug_rotate", 0);
  _id_1DE7();
  thread _id_13332();
  setglobalsoundcontext("atmosphere", "space", 1);
}

_id_A04D() {
  _id_0BDC::_id_F435("jackal_landing_ja_wreckage");
  thread _id_10AE::_id_104D0("debris_cloud_struct", "vfx_space_debris_field_01");
  thread _id_10AE::_id_A043("vfx_sunflare_wreckage");
}

_id_13332() {
  var_0 = scripts\engine\utility::getStructArray("ambient_gas_cloud", "script_noteworthy");

  foreach(var_2 in var_0) {
    playFX(scripts\engine\utility::getfx("vfx_ja_space_gas_cloud_04"), var_2.origin);
    playFX(scripts\engine\utility::getfx("vfx_jaw_camcentr_space_dust"), var_2.origin);
  }
}

_id_10C98() {}

_id_B209() {
  _id_10AE::_id_D7C9();
  var_0 = getEnt("player_jackal", "targetname");
  _id_0BDC::_id_10CD1(var_0);
  var_0 thread _id_10AE::_id_57C4("player_spline_intro", 420, 6);
  scripts\engine\utility::flag_wait("intro_start");
  thread _id_10AE::_id_E3B6(1);
  thread _id_10AE::_id_57A8("destroyers", "sdf_destroyer", undefined, undefined, ::_id_52EB);
  level._id_52DF = level._id_A3A8["destroyers"]._id_FE2D[0];
  thread _id_10AE::_id_57AC("skelters", "axis_arena_jackals", 18, 4, 7, 1, undefined, undefined);
  thread _id_10AE::_id_5769("allyJackals", "ally_jackals", 7);
  thread _id_10230();
  thread _id_52FF();
  thread _id_10AE::_id_56B3("skelters", "jackal_objective_skelters", 0, &"JACKAL_OBJECTIVE_SKELTERS_MENU");
  thread _id_10AE::_id_56B3("destroyers", "jackal_objective_destroyer", 0, &"JACKAL_OBJECTIVE_DESTROYER_MENU");
  thread _id_13DEA();
  scripts\engine\utility::delaythread(0.5, _id_10AE::_id_CE81, ::_id_AAA1);
  thread _id_13DE9();
  scripts\engine\utility::flag_wait("intro_done");
  thread _id_10231();
  thread _id_B882();
  thread _id_C505();
  thread _id_52FC();
  scripts\engine\utility::flag_wait("skelterscomplete_vo_finished");
  scripts\engine\utility::flag_wait("destroyerscomplete_vo_finished");
  scripts\engine\utility::flag_wait("missileboatscomplete_vo_finished");
}

_id_13DEA() {
  wait 1;
  setmusicstate("mx_96_ja_wreckage");
}

_id_13DE9() {
  _id_10AE::_id_E3FA("ret_start");
  thread _id_10AE::_id_5768("intro_jackals", "intro_jackal", undefined, 1);
}

_id_10230() {
  scripts\engine\utility::delaythread(0, _id_10AE::_id_57AA, "introflybyskelters", "sdf_intro_flyby_skelters");
  scripts\engine\utility::delaythread(3.8, _id_10AE::_id_57AA, "introskelters", "sdf_intro_skelters");
  scripts\engine\utility::delaythread(5.2, _id_10AE::_id_57AA, "introflyby2skelters", "sdf_intro_flyby2_skelters");
  wait 7.2;
  _id_10AE::_id_1700(level._id_A3A8["introflybyskelters"]._id_FE2D, "skelters");
  _id_10AE::_id_1700(level._id_A3A8["introskelters"]._id_FE2D, "skelters");
  _id_10AE::_id_1700(level._id_A3A8["introflyby2skelters"]._id_FE2D, "skelters");
}

_id_52FF() {
  level._id_52DF._id_BCDA delete();
  level._id_52DF scripts\sp\vehicle::_id_2470(getvehiclenode("destroyer_path1", "targetname"));
  var_0 = 5.25;
  var_1 = 0.5;
  level._id_52DF scripts\engine\utility::delaythread(var_0, _id_0BB8::_id_39CD, "burst");
  level._id_52DF scripts\engine\utility::delaythread(var_0 + 0.25, _id_0BB8::_id_39CD, "heavy");
  level._id_52DF scripts\engine\utility::delaythread(var_0 + 0.25 + var_1, _id_0BB8::_id_39CD, "burst");
  level._id_52DF scripts\engine\utility::delaythread(var_0 + 0.25 + var_1 + 0.25, _id_0BB8::_id_39CD, "idle");
  wait(var_0);
  scripts\sp\vehicle_paths::_id_845A(level._id_52DF);
}

_id_B882() {
  scripts\engine\utility::flag_wait_any("skelterscomplete", "destroyerscomplete");
  wait 10.0;
  _id_BC43();
  thread _id_10AE::_id_57A9("missileboats", "sdf_missileboats", undefined, ::_id_B87F, ::_id_B881, 1, 1);
  wait 3.0;
  thread _id_10AE::_id_56B3("missileboats", "jackal_objective_missile_boats", 0, &"JACKAL_OBJECTIVE_MISSILE_BOATS_MENU");
  thread _id_B885();
}

_id_BC43() {
  var_0 = getEntArray("sdf_missileboats", "targetname");
  var_1 = _id_10AE::_id_6C7B("missileboat_ftl_point", var_0.size, 15000, 25000, 0.9);

  foreach(var_4, var_3 in var_0)
  var_3 scripts\sp\utility::_id_11624(var_1[var_4]);
}

_id_C505() {
  for(;;) {
    var_0 = ["skelterscomplete_vo_finished", "destroyerscomplete_vo_finished", "missileboatscomplete_vo_finished"];
    var_1 = level scripts\engine\utility::waittill_any_return(var_0[0], var_0[1], var_0[2]);
    var_2 = [];

    foreach(var_4 in var_0) {
      if(!scripts\engine\utility::flag_exist(var_4) || !scripts\engine\utility::flag(var_4))
        var_2[var_2.size] = var_4;
    }

    if(var_2.size == 1) {
      if(var_2[0] == "destroyerscomplete_vo_finished")
        thread _id_10AE::_id_CE80(::_id_52FE);
      else
        thread _id_10AE::_id_CE80(::_id_C074);

      break;
    }

    wait 0.05;
  }
}

_id_52FC() {
  scripts\engine\utility::flag_wait("destroyerscomplete");
  _id_0A2F::_id_DA45("captain8", 2.0);
}

_id_10B93() {
  var_0 = getEnt("player_jackal", "targetname");
  var_0 _id_0BDC::_id_1162F("start_ace");
  _id_0BDC::_id_10CD1(var_0);
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
  thread _id_10AE::_id_E3B6(1);
  scripts\engine\utility::delaythread(0.05, _id_10AE::_id_E3FA, "ret_start");

  if(getdvarint("ja_skip_preload", 0) == 0)
    level thread scripts\sp\utility::_id_BF97();

  scripts\engine\utility::flag_set("jackal_objectives_can_display");
}

_id_B176() {
  while(!isDefined(level._id_E35D))
    wait 0.05;

  scripts\engine\utility::flag_init("ethen_called_out_ace");
  wait 1.0;
  thread _id_1555();
  scripts\engine\utility::flag_wait("ethen_called_out_ace");
  wait 1.0;
  _id_BBF9();
  thread _id_10AE::_id_57A7("aces", "sdf_ace", undefined, undefined, ::_id_1551);
  thread _id_10AE::_id_56B3("aces", "jackal_objective_ace", 0, &"JACKAL_OBJECTIVE_ACE_MENU");
  level._id_A3A8["aces"]._id_FE2D[0] _id_0BDC::_id_A36D();
  scripts\engine\utility::flag_wait("acescomplete_vo_finished");
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

  if(!isDefined(var_1))
    var_1 = var_2[randomint(var_2.size)];

  var_0 scripts\sp\utility::_id_11624(var_1);
}

_id_10CAE() {
  var_0 = getEnt("player_jackal", "targetname");
  _id_0BDC::_id_10CD1(var_0);
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
  thread _id_10AE::_id_E3B6(1);

  if(getdvarint("ja_skip_preload", 0) == 0)
    level thread scripts\sp\utility::_id_BF97();

  scripts\engine\utility::flag_set("jackal_objectives_can_display");
}

_id_B20F() {
  while(!isDefined(level._id_E35D))
    wait 0.05;

  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_6EEA();
  scripts\engine\utility::flag_init("mission_complete_vo_done");
  thread _id_10AE::_id_CE81(::_id_B8BD);
  _id_10AE::_id_E3F9();
  scripts\engine\utility::flag_wait("mission_complete_vo_done");
  _id_10AE::_id_579D(::_id_A7DA, ::_id_A7D9, ::_id_A82F, ::_id_A7F4);
}

_id_10C57() {
  var_0 = getEnt("player_jackal", "targetname");
  var_0 _id_0BDC::_id_1162F("start_ace");
  _id_0BDC::_id_10CD1(var_0);
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
  thread _id_10AE::_id_E3B6(1);
}

_id_B1E5() {
  level.player notifyonplayercommand("dpadup", "+actionslot 1");
  level.player waittill("dpadup");
  wait 1.0;
  _id_BC43();
  thread _id_10AE::_id_57A9("missileboats", "sdf_missileboats", undefined, undefined, undefined, 1, 1);
}

_id_AAA1() {
  scripts\sp\utility::_id_10350("ja_wreck_slt_setdefdestroyerat12");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_retributionholdup");
  scripts\sp\utility::_id_10350("ja_wreck_nav_rogerthatsirgood");
  scripts\sp\utility::_id_10350("ja_wreck_slt_letsgetinthereraider");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_skeltersareprimary");
  scripts\sp\utility::_id_10350("ja_wreck_slt_copy12isweapons");
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_6EEB();
}

_id_10231() {
  scripts\engine\utility::flag_wait("skelters4_left");
  wait 1.7;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_1034D("ja_wreck_plr_skeltersarethinningout");
  scripts\sp\utility::_id_10350("ja_wreck_slt_mypleasure");
  _id_10AE::_id_134D1();
  scripts\engine\utility::flag_wait("skelters2_left");
  wait 1.7;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_10350("ja_wreck_slt_couplestragglersleft");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_letsmopemup");
  _id_10AE::_id_134D1();
}

_id_B87F() {
  thread wreckage_ajak_music();
  scripts\sp\utility::_id_10350("ja_wreck_nav_beadvisedmultiple");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_solidcopyletsget");
  scripts\sp\utility::_id_10350("ja_wreck_slt_rogerevilweapons");
}

wreckage_ajak_music() {
  setmusicstate("");
  wait 8;
  setmusicstate("mx_383_ja_wreckage_ajak");
}

_id_B885() {
  scripts\engine\utility::flag_wait("missileboats1_left");
  wait 2.5;
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_1034D("ja_wreck_plr_gotem");
  scripts\sp\utility::_id_10350("ja_wreck_slt_niceshotraider");
  _id_10AE::_id_134D1();
}

_id_B881() {
  scripts\sp\utility::_id_1034D("ja_wreck_plr_ajacksdown");
  scripts\sp\utility::_id_10350("ja_wreck_slt_goodeffecttargetdestroyed");
}

_id_52EB() {
  scripts\sp\utility::_id_1034D("ja_wreck_plr_goodkillgoodkill");
  scripts\sp\utility::_id_10350("ja_wreck_slt_setdefdestroyer");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_greatshootingte");
}

_id_C074() {
  if(scripts\engine\utility::flag_exist("destroyerscomplete") && scripts\engine\utility::flag("destroyerscomplete") && scripts\engine\utility::flag_exist("skelterscomplete") && scripts\engine\utility::flag("skelterscomplete") && scripts\engine\utility::flag_exist("missileboatscomplete") && scripts\engine\utility::flag("missileboatscomplete")) {
    return;
  }
  scripts\sp\utility::_id_10350("ja_wreck_plr_sdfstillintheao");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_rgerfevercomein");
  scripts\sp\utility::_id_10350("ja_wreck_slt_youknowit");
}

_id_52FE() {
  if(scripts\engine\utility::flag_exist("destroyerscomplete") && scripts\engine\utility::flag("destroyerscomplete") && scripts\engine\utility::flag_exist("skelterscomplete") && scripts\engine\utility::flag("skelterscomplete") && scripts\engine\utility::flag_exist("missileboatscomplete") && scripts\engine\utility::flag("missileboatscomplete")) {
    return;
  }
  scripts\sp\utility::_id_10350("ja_wreck_nav_focusfireonthed");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_rogerthatgatora");
  scripts\sp\utility::_id_10350("ja_wreck_slt_getgunsonthoseturrets");
}

_id_1555() {
  _id_10AE::_id_1350F();
  scripts\sp\utility::_id_1034D("ja_wreck_plr_isthatallofthem");
  scripts\engine\utility::delaythread(2.0, scripts\engine\utility::flag_set, "ethen_called_out_ace");
  scripts\sp\utility::_id_10350("ja_wreck_eth_notquitegoteyes");
  wait 1.0;
  scripts\sp\utility::_id_10350("ja_wreck_slt_takehimraider");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_engaging");
  _id_10AE::_id_134D1();
}

_id_1551() {
  thread wreckage_victory_music();
  scripts\sp\utility::_id_10350("ja_wreck_slt_splashoneacesolidraider");
  scripts\sp\utility::_id_10350("ja_wreck_eth_goodshootingsir");
}

wreckage_victory_music() {
  setmusicstate("");
  wait 6;
  setmusicstate("mx_wreckage_victory");
}

_id_B8BD() {
  scripts\sp\utility::_id_10350("ja_wreck_nav_allsdfvesselsha");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_affirmative");
  scripts\sp\utility::_id_10350("ja_wreck_slt_goodcallreyesunsaneeds");
  scripts\engine\utility::delaythread(1.8, scripts\engine\utility::flag_set, "mission_complete_vo_done");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_letsheadhomesca");
}

_id_A7DA() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_retsquadisonapproach");
  scripts\sp\utility::_id_10350("ja_wreck_nav_copyallyourstower");
  scripts\sp\utility::_id_10350("ja_wreck_amb_youreclearforland");
}

_id_A7D9() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_retsquadisonapproach");
}

_id_A82F() {
  level endon("ja_vo_interrupt");
  scripts\sp\utility::_id_10350("ja_wreck_amb_standbyfordrone");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_flapsgearsout");
}

_id_A7F4() {
  level endon("ja_vo_interrupt");
  wait 3.5;
  scripts\sp\utility::_id_10350("ja_wreck_slt_youdidgoodoutth");
  scripts\sp\utility::_id_1034D("ja_wreck_plr_youtoofever");
}

_id_1DE7() {
  var_0 = getEntArray("ambient_rotate_object", "script_noteworthy");
  level._id_E736 = [];

  foreach(var_2 in var_0) {
    if(!issubstr(var_2.classname, "script_brushmodel")) {
      var_3 = getEntArray(var_2.target, "targetname");

      if(isDefined(var_2.target))
        scripts\engine\utility::array_call(var_3, ::linkto, var_2);

      level._id_E736[level._id_E736.size] = var_2;
      var_2 thread _id_1DE6();
    }
  }
}

_id_1DE6() {
  var_0 = 1;
  var_1 = 10;
  var_2 = 2;
  var_3 = [];

  if(isDefined(self.script_parameters))
    var_3 = strtok(self.script_parameters, " ");

  var_4 = [];
  var_5 = [];
  var_2 = clamp(var_2, 2, 3);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    if(!isDefined(var_3[var_6])) {
      if(var_3.size == 1)
        var_4[var_6] = float(var_3[0]);
      else
        var_4[var_6] = randomintrange(var_0, var_1);
    } else
      var_4[var_6] = float(var_3[var_6]);

    var_5[var_6] = scripts\engine\utility::random([-1, 1]);
  }

  for(;;) {
    var_7 = [];
    var_8 = "";

    for(var_6 = 0; var_6 < var_2; var_6++) {
      var_7[var_6] = self.angles[var_6] + var_4[var_6] / 20 * var_5[var_6];
      var_8 = var_8 + (var_4[var_6] + " ");
    }

    self.angles = (var_7[0], var_7[1], self.angles[2]);

    if(getdvarint("debug_rotate") == 1)
      thread scripts\engine\utility::draw_ent_axis((1, 0, 0), 2, 1000);

    scripts\engine\utility::waitframe();
  }
}