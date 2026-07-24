/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3831.gsc
**************************************/

_id_FDE4(var_0, var_1) {
  level _id_FDE0(var_0, var_1);

  if(level.script == "shipcrib_europa")
    level[[level._id_67BC]]();
  else
    level _id_FDE2(var_0);
}

_id_FDE5(var_0) {
  if(level.script != "shipcrib_europa")
    _id_0EFB::_id_FDBB("bridge_crew");

  level thread _id_0A2F::_id_12642();
  level thread _id_0EE6::_id_2201();
  level._id_FD6E._id_21A8[0] thread _id_0EE6::_id_21A6();
  _id_ADF0();
}

_id_ADF0() {
  if(level.script == "shipcrib_europa")
    level thread scripts\sp\utility::_id_12651([level.script + "_halore_tr", level.script + "_dropship_tr", level.script + "_ambientmr_tr"]);
  else {
    if(isDefined(level._id_FD6E._id_5D89)) {
      level._id_FD6E._id_5D89 delete();
      level thread _id_0EFB::_id_FE0C();
    }

    level thread scripts\sp\utility::_id_12651([level.script + "_bridgee_tr", level.script + "_exterior_tr", level.script + "_halore_tr", level.script + "_dropship_tr", level.script + "_ambientmr_tr"]);
  }

  level scripts\sp\utility::_id_12641(level.script + "_vr_tr");
  level scripts\sp\utility::_id_12641(level.script + "_mezz_tr");
  level thread scripts\sp\utility::_id_12643([level.script + "_hangar_tr", level.script + "_ambient_tr", level.script + "_jackal_tr"]);
}

_id_12BCA() {
  if(isDefined(level._id_FD6E._id_5D89)) {
    level._id_FD6E._id_5D89 delete();
    level thread _id_0EFB::_id_FE0C();
  }

  if(level.script != "shipcrib_europa")
    level scripts\sp\utility::_id_1264E(level.script + "_bridgem_tr");

  level thread scripts\sp\utility::_id_12651([level.script + "_bridge_tr", level.script + "_bridgee_tr", level.script + "_exterior_tr"]);
  _id_0EFB::_id_FDBB("bridge_crew");
}

_id_FDE0(var_0, var_1) {
  level thread _id_0EFB::shipcrib_autosave_now_silent();

  if(level.script == "shipcrib_europa") {
    _id_0EFB::_id_FDBA(level._id_B11D);
    _id_0EFB::_id_FDBA(level._id_76FB);
    level thread _id_12BCA();
  }

  setsaveddvar("spaceshipHackServerToClientDobj", 0);
  level thread _id_FDE1();
  level thread _id_0EE6::_id_2202();
  level._id_FD6E._id_21A8[0] thread _id_0EE6::_id_21A7();
  scripts\engine\utility::flag_clear("at_fullscreen_opsmap");
  level.player._id_E9C4 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player _meth_823B(level.player._id_E9C4);

  if(isDefined(var_1))
    var_1 delete();

  var_2 = _id_0EE8::_id_7CF3("player_terminal");
  var_2 _id_0E46::_id_DFE3();
  level.player._id_E9C4.origin = getstartorigin(var_2._id_BC97.origin, var_2._id_BC97.angles, _id_0EFB::_id_7B87("player_terminal_enter_twostep"));
  level.player._id_E9C4.angles = getstartangles(var_2._id_BC97.origin, var_2._id_BC97.angles, _id_0EFB::_id_7B87("player_terminal_enter_twostep"));
  var_3 = _id_0EFB::_id_7C60();
  var_4 = issubstr(var_3, "ja_");

  if(!var_4) {
    _id_0EF8::_id_FDFC("spawner_griff", "armory_officer_reaction_point");
    level._id_8604 scripts\sp\utility::_id_86E2();
    _id_ADEB();
    var_5 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
    var_5 scripts\sp\anim::_id_1EC3(level._id_8604, "sa_armory");
    var_5 scripts\engine\utility::delaythread(0.5, scripts\sp\anim::_id_1F35, level._id_8604, "sa_armory");
  }

  scripts\engine\utility::flag_wait(level.script + "_vr_tr_loaded");
  scripts\engine\utility::delaythread(0, scripts\sp\hud_util::_id_6A99, 2, "black");
  var_2 notify("trigger");
  thread _id_2604();

  if(var_3 == "sa_empambush") {
    wait 1;
    var_6 = _id_0EF1::_id_7AED("armory_terminal");
    level.player thread _id_CE07(var_6);
    scripts\engine\utility::delaythread(6.5, ::_id_CD9C);
  } else {
    scripts\engine\utility::delaythread(1.33, ::_id_CD9B);
    level waittill("fade_done");
    thread _id_CD9D();
    level scripts\engine\utility::flag_wait("armory_chose_loadout");
    scripts\engine\utility::delaythread(4.6, ::_id_CD9C);
  }

  level waittill("terminal_anim_exit_done");
  scripts\sp\utility::_id_13C3C();
  thread _id_2603();
  scripts\sp\hud_util::_id_6AA3(1, "black");
  _id_0EE6::_id_2200();
  _id_0EE6::_id_21A9();
  _id_0EFB::_id_FDBA(level._id_8604);
  wait 0.33;
  setomnvar("ui_hide_hud", 1);
  scripts\engine\utility::flag_wait(level.script + "_jackal_tr_loaded");
}

_id_FDE1() {
  if(isDefined(level._id_FD69)) {
    scripts\engine\utility::flag_wait(level.script + "_ambient_tr_loaded");
    level thread[[level._id_FD69]]();
  }
}

_id_CD9B() {
  var_0 = _id_0EF1::_id_7AED("armory_terminal_entrance");
  level.player thread _id_CE07(var_0);

  if(isDefined(level._id_8604)) {
    var_1 = _id_0EF1::_id_7AED("armory_terminal_entrance_griff");
    level._id_8604 thread _id_CE07(var_1);
  }
}

_id_CD9D(var_0) {
  thread _id_C147("end_terminal_vo");
  thread _id_C145("end_terminal_vo");
  level.player endon("end_terminal_vo");
  wait 1;
  var_1 = _id_0EF1::_id_7AED("armory_terminal", var_0);
  level.player _id_CE07(var_1);
  var_2 = level.player _meth_84C6("scTaughtVR");

  if(!isDefined(var_2) || !var_2) {
    if(isDefined(level._id_FDFA) && !issubstr(level._id_FDFA, "ja_") && (level._id_FDFA != "sa_empambush" && level._id_FDFA != "moon_port")) {
      level.player _meth_84C7("scTaughtVR", 1);
      level.player thread scripts\sp\utility::_id_1034D("sc_wnd_grf_greeniesgotthef_spk");
    }
  }
}

_id_B8CC() {
  wait 0.5;
  cinematicingame("sc_moon_loadout_tutorial_vr");

  while(!iscinematicplaying())
    wait 0.05;

  while(iscinematicplaying())
    wait 0.05;

  stopcinematicingame();
  setomnvar("ui_loadouts_menu_disabled", 0);
}

_id_CD9C() {
  wait 2;
  var_0 = _id_0EF1::_id_7AED("armory_terminal_exit");
  level.player _id_CE07(var_0);
}

_id_C147(var_0) {
  scripts\engine\utility::flag_wait("acceped_vr");
  level.player notify(var_0);
}

_id_C145(var_0) {
  scripts\engine\utility::flag_waitopen("at_terminal");
  level.player notify(var_0);
}

#using_animtree("generic_human");

_id_ADEB() {
  level._id_EC85["griff"]["sa_armory"] = % sa_griff_arm_scene;
  level._id_EC88["griff"]["sc_wnd_grf_gotafullinvento"] = % sc_wnd_grf_1_130_ag_i2;
  level._id_EC88["griff"]["sc_emp_grf_hardwarespreppe"] = % sa_arm_emp_face_01;
  level._id_EC88["griff"]["sc_vips_grf_gotafreshbatcho"] = % sc_vips_grf_1_110_ag_i2;
  level._id_EC88["griff"]["sc_wnd_amo_readytochooseyour"] = % sc_titan_grf_8_380_ag_i2;
}

#using_animtree("jackal");

_id_FDE2(var_0) {
  if(isDefined(level._id_FD68))
    level thread[[level._id_FD68]]();

  _id_0EFB::_id_FDBB("all");
  _id_0EFB::_id_FDE8(level._id_FD6E._id_209C);
  _id_0EFB::_id_FDE8(level._id_FD6E.jackals);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_5EE3);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_7316);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_11A55);
  _id_0EFB::_id_FDCD();
  level._id_E35D._id_6A38 thread _id_0B51::_id_5155();
  level notify("screens_stop_thinking");
  level thread scripts\sp\utility::_id_12651([level.script + "_bridge_tr", level.script + "_bridgem_tr", level.script + "_mezz_tr", level.script + "_halore_tr", level.script + "_prime_tr", level.script + "_prime_in_tr", level.script + "_dropship_tr", level.script + "_ambient_tr", level.script + "_vr_tr"]);
  setomnvar("ui_jackal_load_ui", 1);
  var_1 = _id_0EF9::_id_FE03("jackal", "jackal_bay_3", "player");
  _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_4");
  var_1 _id_0BDC::_id_104A6(0);
  var_1 thread _id_FA35();
  var_1 thread _id_0BDC::_id_A07D();
  level.player._id_E9C4.origin = var_1.origin;
  level.player._id_E9C4.angles = var_1.angles;
  scripts\engine\utility::waitframe();
  level scripts\engine\utility::delaythread(1, scripts\sp\hud_util::_id_6A99, 1, "black");
  level._id_CB8A = % jackal_pilot_mount_03_starboard;
  level.vehicle_allows_rider_death = % jackal_vehicle_mount_03_starboard;
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  scripts\engine\utility::noself_delaycall(7.5, ::cinematicingame, "sc_assault_hud_jackal_launch");
  level scripts\engine\utility::delaythread(4.5, _id_0EE0::_id_E3BE, "jackal_bay_4", 1, 0, 1);
  var_2 = _id_0EF1::_id_7AED("jackal_launch");
  level.player scripts\engine\utility::delaythread(10, ::_id_CE07, var_2);
  scripts\engine\utility::delaythread(0.05, _id_0BDC::_id_A153);
  _id_0BDC::_id_10CD1(var_1, undefined, "shipcrib_europa_launch", "shipcrib");
  level notify("shipcrib_jackal_launch_started");

  switch (level._id_FDFA) {
    case "ja_wreckage":
    case "ja_titan":
    case "ja_spacestation":
    case "ja_mining":
    case "ja_asteroid":
    case "sa_wounded":
    case "sa_vips":
    case "sa_empambush":
    case "sa_moon":
    case "sa_assassination":
      level thread _id_FDE3();
      break;
  }

  level thread _id_0EE0::_id_E3BE("jackal_bay_3", 1, 1);
  level waittill("player_jackal_launch_actual_started");
  level.player _meth_82C0("fade_to_black", 0.05);

  if(level.script == "shipcrib_titan")
    level.player _meth_84C7("scTitanFirstPlay", 1);

  level._id_D127 _id_0BDC::_id_A226();
  scripts\sp\utility::_id_BF95();
}

_id_FDE3() {
  level scripts\sp\utility::_id_BF97(undefined, undefined, 0);

  while(!iscinematicplaying())
    scripts\engine\utility::waitframe();

  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  level thread scripts\sp\utility::_id_BF98();
}

_id_2605() {
  level.player _meth_82C0("shipcrib_sa_fade_to_black_before_armory", 1.0);
  wait 1.0;
  level.player stopsounds();
}

_id_2604() {
  wait 1.0;
  level.player _meth_82C0("shipcrib_sa_fade_up_to_armory", 1.0);
  wait 1.1;
  level.player clearclienttriggeraudiozone(0.1);
}

_id_2603() {
  level.player _meth_82C0("shipcrib_sa_fade_to_black_before_hangar", 2.0);
  wait 1.0;
  thread scripts\engine\utility::play_sound_in_space("emt_ship_hangar_pa_2d_transitions", level.player.origin + (300, 300, 0));
}

_id_2602() {
  level.player _meth_82C0("shipcrib_sa_fade_up_to_ship_assault_hangar", 1.0);
  wait 2.0;
  level.player clearclienttriggeraudiozone(1.0);
}

#using_animtree("script_model");

_id_FA35() {
  level._id_EC87["jackal_helmet"] = #animtree;
  level._id_EC8C["jackal_helmet"] = "hero_jackal_helmet_a";
  level._id_EC85["jackal_helmet"]["jackal_mount"] = % jackal_vehicle_mount_03_helmet;
  var_0 = self;
  var_1 = level.player scripts\sp\utility::_id_10639("jackal_helmet", var_0.origin, var_0.angles);
  var_0 scripts\sp\anim::_id_1EC3(var_1, "jackal_mount");
}

_id_FDE6() {
  level.player _meth_82C0("fade_to_black", 0.0);
  var_0 = _id_0EEB::_id_7976("return");
  _id_0EEB::_id_60FD("return", "Ship Assault", 1);
  var_0._id_BFEA = 1;
  var_0 setanimknob(var_0.anims["4_raise"], 1);
  var_0 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_0.anims["4_raise"], 1);
  var_0._id_5989["4"] solid();
  var_1 = _id_0EFB::_id_7D7A("return_sa_start");
  var_2 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player _meth_823B(var_2);
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  var_2 linkTo(var_0);
  level notify("shipcrib_sa_setup_complete");
  level thread scripts\sp\hud_util::_id_6AA3(0, "black");
  level thread _id_0EEB::_id_60F0("return", 45);
  level thread _id_0EEB::_id_60FD("return", "Bridge Level");
  var_0._id_BFEA = undefined;
  wait 0.75;
  level.player clearclienttriggeraudiozone(1.0);
  level thread scripts\sp\hud_util::_id_6A99(2, "black");
  wait 1;
  level thread _id_E465();
  var_2 delete();
  level.player unlink();
  var_0 waittill("move_finished");
  level thread _id_0B21::_id_5A43("return_elevator", "open");
  level notify("shipcrib_sa_start_complete");
}

_id_9960() {
  level endon("stop_intel_updates");
  var_0 = ["newsVideo1", "newsVideo2", "newsVideo3", "newsVideo4", "newsVideo5", "newsVideo6", "newsVideo7"];

  switch (level.script) {
    case "shipcrib_moon":
      scripts\sp\utility::_id_914C("fluff_messages_tally", "fluff_messages_tally_body", "tally_intel", undefined);
      break;
    case "shipcrib_prisoner":
    case "shipcrib_rogue":
    case "shipcrib_titan":
    case "shipcrib_europa":
      foreach(var_2 in var_0) {
        var_3 = level.player _meth_84C6("scNewsReels", var_2);

        if(isDefined(var_3) && var_3 == "open") {
          scripts\sp\utility::_id_9145("fluff_messages_news_body");
          break;
        }
      }

      wait 5.0;
      scripts\sp\utility::_id_914C("fluff_messages_tally", "fluff_messages_tally_body", "tally_intel", undefined);
      break;
  }
}

_id_E465() {
  level endon("stop_intel_updates");
  _id_0A2F::_id_DA4F();
  level thread _id_9960();
}

_id_30AD() {
  if(!level.console) {
    while(!scripts\engine\utility::flag(level.script + "_bridgee_tr_loaded")) {
      waitforalltransients();
      wait 0.15;
    }
  }

  _id_0EF0::_id_FD9F();
  _id_10AB::_id_300C();
  var_0 = level.player _meth_84C6("lastCompletedMission");
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_1 = strtok(var_0, "_");

    if(var_1.size < 1)
      var_0 = "sa_assassination";
  }

  level._id_C6AA["retribution"] thread _id_0EDE::_id_C683("solar_system", undefined, 1);
  _id_306F();
  _id_3065();
  _id_ADF7();
  var_2 = level._id_C6AA["retribution"]._id_EF67;
  level._id_C6AA["retribution"]._id_10E52["xo"]._id_EE92 = "opsmap_salter_react";
  level._id_C6AA["retribution"]._id_10E52["nav"]._id_EE92 = "opsmap_gator_react";
  level._id_C6AA["retribution"]._id_10E52["drop"]._id_EE92 = "opsmap_drops_react";
  _id_0EF8::_id_FDFC("spawner_gator", level._id_C6AA["retribution"]._id_10E52["nav"]);
  level thread _id_0B20::_id_AB71(self, "left_push", 0.4, ::_id_2FF9);
  _id_0EF8::_id_FDFC("spawner_drop_officer", level._id_C6AA["retribution"]._id_10E52["drop"]);
  _id_0EF8::_id_FDFC("spawner_sotomura", "homebase");
  _id_0EF8::_id_FDFC("spawner_salter", level._id_C6AA["retribution"]._id_10E52["xo"]);
  _id_0EF8::_id_FDFC("spawner_comms", "homebase");
  _id_0EF8::_id_FDFC("spawner_bridge_ftl1", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_ftl2", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_ftl3", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_tac1", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_tac2", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_tac3", _id_0EFB::_id_EFDB("drop"));
  _id_0EF8::_id_FDFC("spawner_bridge_tac4", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_sys1", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_sys2", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_sys3", _id_0EFB::_id_EFDB("sysend"));
  wait 0.05;
  level._id_5CFC thread _id_0EFB::_id_CD3F("opsmap_drops_react");
  level._id_EA2C thread _id_0EFB::_id_CD3F("opsmap_salter_react");
  level scripts\engine\utility::delaythread(1.0, _id_0EF0::_id_FDA0);
  level scripts\engine\utility::delaythread(1.0, scripts\sp\interaction_manager::_id_F2A7, "busy");
  level._id_30C2 scripts\engine\utility::delaythread(0.5, _id_10AB::_id_300A);
  level._id_30BD scripts\engine\utility::delaythread(0.5, _id_10AB::_id_300A);
  level waittill("door_lerp_finished");
  wait 1.0;
  var_3 = _id_0EF1::_id_7AED("dropo_opsmap_reaction");
  var_4 = _id_0EF1::_id_7AED("salter_opsmap_reaction");
  level._id_5CFC thread _id_0EE5::_id_202D(undefined, var_3);
  level._id_EA2C thread _id_0EE5::_id_202D(undefined, var_4);
  level._id_1044B thread _id_0EE5::_id_202D();
  level._id_4451 thread _id_0EE5::_id_202D();
  wait 1.0;
}

_id_2FF9() {
  level thread scripts\sp\utility::_id_266A("bridge_door");
  level thread _id_0EDC::_id_2FF7();
  _id_0EDB::early_out_broadcast();
  thread _id_CDEC();
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  setmusicstate("");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_BA11["nav"], "SH_SA_1_monitor_intro");
  var_0 scripts\sp\anim::_id_1F35(level._id_76FB, "bridge_enter_sa");
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C642();
  level._id_76FB thread _id_0EFB::_id_CD3F("opsmap_gator_react");
  var_1 = _id_0EF1::_id_7AED("gator_opsmap_reaction");
  level._id_76FB scripts\engine\utility::delaythread(1.0, _id_0EE5::_id_202D, undefined, var_1);
  level thread bridge_opsmap_nags();
}

_id_CDEC() {
  level._id_76FB endon("death");
  wait 3;
  level._id_76FB scripts\sp\utility::_id_7799(level.player);
  var_0 = _id_0EF1::_id_7AED("welcome_line");
  level._id_76FB scripts\sp\utility::_id_7799(level.player);
  var_1 = _id_0EFB::_id_7AF0();

  switch (var_1) {
    case "sa_assassination":
      level._id_76FB _id_CE07(var_0[0]);
      level._id_EA2C _id_CE07(var_0[1]);
      break;
    case "sa_vips":
      var_2 = level.player _meth_84C6("saVIPHostagesState");

      if(!isDefined(var_2))
        var_2 = "all";

      if(var_2 != "all") {
        var_3 = _id_0EF1::_id_7AED("welcome_line_failure");
        level._id_76FB _id_CE07(var_3);
      } else
        level._id_76FB _id_CE07(var_0);

      break;
    default:
      level._id_76FB _id_CE07(var_0);
  }

  level._id_76FB scripts\sp\utility::_id_77B9(0.7);
}

bridge_opsmap_nags() {
  level endon("opsmap_nag_cancel");
  wait 30.0;

  while(distance2dsquared(level.player.origin, level._id_EA2C.origin) > squared(500.0))
    wait 0.05;

  wait 2.0;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_rogue_slt_whatsourtarget");
  wait 30.0;

  while(distance2dsquared(level.player.origin, level._id_EA2C.origin) > squared(500.0))
    wait 0.05;

  level._id_76FB scripts\sp\utility::_id_10346("sc_rogue_nav_illplotacourse");
}

_id_119C() {
  if(isDefined(level._id_5CFC)) {
    level._id_5CFC thread _id_0EE5::_id_10FC4();
    level._id_5CFC thread _id_0EFB::_id_11004();
  }

  if(isDefined(level._id_EA2C))
    level._id_EA2C thread _id_0EFB::_id_11004();

  if(isDefined(level._id_76FB))
    level._id_76FB thread _id_0EFB::_id_11004();

  if(isDefined(level._id_1044B))
    level._id_1044B thread _id_0EE5::_id_10FC4();

  if(isDefined(level._id_4451))
    level._id_4451 thread _id_0EE5::_id_10FC4();
}

#using_animtree("generic_human");

_id_306F() {
  level._id_EC85["salter"]["bridge_enter_sa"] = % shipcrib_titan_bridge_salter_enter;
  level._id_EC85["gator"]["bridge_enter_sa"] = % sh_sa_1_nav_intro;
}

#using_animtree("script_model");

_id_3065() {
  level._id_EC85["opsmap_monitor_nav"]["SH_SA_1_monitor_intro"] = % sh_sa_1_monitor_intro;
}

_id_ADF3() {
  level waittill("shipcrib_sa_setup_complete");
  _id_0EF8::_id_FDFC("spawner_salter", "return_sa_salter_start");
  var_0 = _id_0EEB::_id_7976("return");
  level._id_EA2C linkTo(var_0);
  var_1 = randomintrange(2, 6);
  level._id_EA2C _id_0EE5::_id_202D(var_1);
  var_0 waittill("move_finished");
  wait 0.33;
  _id_CDEF();
}

_id_CDEF() {
  level endon("entering_bridge_scene");
  _id_FA3F();
  _id_EAD8();
  thread _id_EADA();
  _id_EAD9();
}

_id_FA3F() {
  scripts\engine\utility::flag_init("sa_salter_atBridgeDoor");
  scripts\engine\utility::flag_init("sa_salter_played_walkntalk");
  scripts\engine\utility::flag_init("sa_salter_walkntalk_vo_complete");
}

_id_EAD8() {
  level._id_EA2C _id_0EE5::_id_10FC4();
  level._id_EA2C unlink();
  var_0 = scripts\engine\utility::getStruct("shipassault_salter_bridgehallway_lookat1", "targetname");
  var_1 = scripts\engine\utility::getStruct("shipassault_salter_bridgehallway_lookat2", "targetname");
  level._id_EA2C scripts\sp\utility::_id_7799(var_0, 1, 2);
  level._id_EA2C _id_0B6A::_id_EC0A("shipassault_salter_elevatorexit_wait");
  level._id_EA2C thread scripts\sp\utility::_id_779B(var_1, 1.5);
  level._id_EA2C thread scripts\sp\utility::_id_77B9(3);
}

_id_EAD9() {
  level endon("entering_bridge_scene");
  level._id_EA2C thread scripts\sp\utility::_id_7799(level.player);
  level._id_EA2C thread _id_CE07(_id_0EF1::_id_7AED("salter_elevator_exit"));
  level._id_EA2C scripts\engine\utility::delaythread(2.5, scripts\sp\utility::_id_77B9, 1.2);
  level._id_EA2C _id_0B6A::_id_EC0B("shipassault_salter_bridgedoor_wait", "shipcrib_stand_stationary_talk_idle_02");
  scripts\engine\utility::flag_set("sa_salter_atBridgeDoor");
  wait 1;

  if(scripts\engine\utility::flag("sa_salter_played_walkntalk"))
    scripts\engine\utility::flag_wait("sa_salter_walkntalk_vo_complete");

  var_0 = _id_0EF1::_id_7AED("salter_bridgedoor_reaction");
  level._id_EA2C _id_0EE5::_id_202D("stand_idle_2_left_reaction", var_0);
}

_id_EADA() {
  level endon("entering_bridge_scene");
  var_0 = scripts\engine\utility::getStruct("shipassault_salter_bridgedoor_wait", "targetname");

  while(distance2d(level.player.origin, var_0.origin) > 500)
    scripts\engine\utility::waitframe();

  if(!scripts\engine\utility::flag("sa_salter_atBridgeDoor") && distance2d(level._id_EA2C.origin, var_0.origin) > 150) {
    scripts\engine\utility::flag_set("sa_salter_played_walkntalk");
    level._id_EA2C scripts\sp\interaction_manager::_id_11009();
    level._id_EA2C scripts\sp\utility::_id_13861("on", level.player, "right");
    level._id_EA2C scripts\sp\utility::_id_7798(level.player, 2, 1);
    var_1 = _id_0EF1::_id_7AED("salter_walkntalk");
    _id_CDF0(var_1);
    scripts\engine\utility::flag_set("sa_salter_walkntalk_vo_complete");
    level._id_EA2C scripts\sp\utility::_id_7793(1);
    level._id_EA2C scripts\sp\utility::_id_13861("off", level.player, "right");
    level._id_EA2C scripts\sp\interaction_manager::_id_45A6();
  }
}

_id_CDF0(var_0) {
  if(isarray(var_0)) {
    foreach(var_2 in var_0) {
      var_3 = _id_53C0(var_2);
      var_3 _id_CE07(var_2);
    }
  } else {
    var_2 = var_0;
    var_3 = _id_53C0(var_2);
    var_3 _id_CE07(var_0);
  }
}

_id_53C0(var_0) {
  var_1 = strtok("_", var_0);

  foreach(var_3 in var_1) {
    if(var_3 == "slt")
      return level._id_EA2C;

    if(var_3 == "plr")
      return level.player;

    if(var_3 == "grf")
      return level._id_8604;
  }

  return level._id_EA2C;
}

_id_ADF6() {
  var_0 = _id_0EFB::_id_7A73();

  if(!isDefined(var_0)) {
    return;
  }
  thread _id_ADF8(var_0);
  thread _id_ADFA(var_0);
  thread _id_ADFB(var_0);
  thread _id_0EE9::_id_ADFC();
  wait 0.25;
}

_id_40C0() {
  var_0 = _id_0EFB::_id_7A73();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _id_7C56(var_0);
  _id_0EFB::_id_FDBA(level._id_E9B4);
  _id_10AB::_id_404E(var_1);

  if(issubstr(var_1, "vips") && (!isDefined(level._id_EFF6) || !level._id_EFF6))
    _id_10AB::_id_404E(var_1 + "_front");

  _id_0EFB::_id_FDBA(level._id_1355C);
  _id_0EDB::_id_40C2();
}

_id_ADFA(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _id_7C56(var_0);
  var_2 = _id_7C57(var_0);
  _id_10AB::_id_ADAD(var_1, var_2, ::_id_CD9A);

  if(issubstr(var_1, "vips") && (!isDefined(level._id_EFF6) || !level._id_EFF6))
    _id_10AB::_id_ADAD(var_1 + "_front", var_2, ::_id_CD9A);

  _id_CE06(var_0);
}

_id_40C1(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _id_7C56(var_0);
  _id_10AB::_id_404E(var_1);
}

_id_CD9A(var_0) {
  var_1 = getarraykeys(var_0);

  foreach(var_3 in var_1) {
    var_4 = var_0[var_3];

    if(isarray(var_4)) {
      var_5 = var_4;

      foreach(var_7 in var_5)
      var_7 _id_CC6A();

      continue;
    }

    var_4 _id_CC6A();
  }
}

_id_CC6A() {
  if(isDefined(self)) {
    self endon("death");

    if(issubstr(self._id_1D77, "inspect"))
      _id_173C();

    if(self._id_1D77 == "shipcrib_hangar_guy_hustle_idle_kneel")
      self._id_1D77 = "sa_hallway_hustle_kneel";

    if(self._id_1D77 == "shipcrib_hangar_guy_hustle_idle_lean")
      self._id_1D77 = "sa_hallway_hustle_lean";

    var_0 = _id_3D75();

    if(!var_0)
      _id_10AB::_id_1F5E(0.0, 0.0);

    if(isDefined(self._id_B00D)) {
      scripts\sp\utility::_id_77B9(0.5);
      wait 0.5;
      scripts\sp\utility::_id_779A(self._id_B00D);
    }
  }
}

_id_173C() {
  self._id_247B = spawn("script_model", self.origin);
  self._id_247B setModel("p7_desk_metal_military_03_tablet");
  self._id_247B linkTo(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  self._id_247B thread _id_E9D0(self);
}

_id_E9D0(var_0) {
  var_0 waittill("death");

  if(isDefined(self))
    self delete();
}

_id_3D75() {
  var_0 = 0;
  var_1 = undefined;

  switch (self._id_1D77) {
    case "shipcrib_stand_stationary_talk_idle_01":
      var_1 = 1;
      break;
    case "shipcrib_stand_stationary_talk_idle_02":
      var_1 = 2;
      break;
    case "shipcrib_stand_stationary_talk_idle_03":
      var_1 = 3;
      break;
    case "shipcrib_stand_stationary_talk_idle_04":
      var_1 = 4;
      break;
    case "shipcrib_stand_stationary_talk_idle_05":
      var_1 = 5;
      break;
  }

  if(isDefined(var_1)) {
    if(!issubstr(self._id_A594, "ambientfeedback") && !issubstr(self._id_A594, "directfeedback")) {}
  }

  return var_0;
}

_id_9872(var_0, var_1) {
  _id_ADE9("ambientfeedback1", var_0, var_1);
}

_id_ADE8(var_0, var_1, var_2) {
  var_3 = var_2 + "_" + var_0;
  var_4 = _id_10AB::_id_780D(var_3, var_1);

  if(isDefined(var_4)) {
    if(isarray(var_4))
      _id_ADEC(var_0, var_4);
    else
      _id_ADEE(var_0, var_4);
  }
}

_id_ADEE(var_0, var_1) {
  var_2 = _id_0EF1::_id_7AED(var_0);

  if(isDefined(var_2) && !isarray(var_2))
    var_1 _id_0EE5::_id_202D(undefined, var_2);
  else {}
}

_id_ADEC(var_0, var_1) {
  var_2 = _id_0EF1::_id_7AED(var_0);

  if(isDefined(var_2) && isarray(var_2) && var_1.size <= var_2.size)
    _id_0EE5::_id_2032(var_1, var_2);
  else {}
}

_id_ADE9(var_0, var_1, var_2) {
  var_3 = var_2 + "_" + var_0;
  var_4 = _id_10AB::_id_780D(var_3, var_1);

  if(isDefined(var_4)) {
    if(isarray(var_4))
      thread _id_ADED(var_0, var_4);
    else
      thread _id_ADEF(var_0, var_4);
  }
}

_id_ADEF(var_0, var_1) {
  var_1 endon("death");
  _id_DB77(var_1);
}

_id_DB77(var_0) {
  var_0 endon("death");

  if(!isDefined(var_0)) {
    var_1 = _id_0EFB::_id_7A73();
    var_2 = _id_7C56(var_1);
    var_0 = _id_10AB::_id_780D(var_1 + "_ambientfeedback1", var_2);

    if(!isDefined(var_0))
      return;
  }

  var_3 = 600;

  if(isDefined(level._id_EFF6) && level._id_EFF6)
    var_3 = 250;

  var_0 _id_1375E(var_3);
  var_0 _id_1681("ambientfeedback1");
  var_0 _id_13677(90, var_3 + 100);
  var_0 _id_1375E(var_3);
  var_0 _id_1681("ambientfeedback2");
}

_id_1681(var_0) {
  var_1 = _id_0EF1::_id_7AED(var_0);

  if(isDefined(var_1))
    _id_CE07(var_1);
}

_id_13677(var_0, var_1) {
  var_2 = 0;

  while(distance2d(self.origin, level.player.origin) < var_1 && var_2 < var_0) {
    var_2 = var_2 + 0.05;
    scripts\engine\utility::waitframe();
  }
}

_id_ADED(var_0, var_1) {
  foreach(var_3 in var_1)
  var_3 endon("death");

  var_1[1] _id_1375E(256);
  var_5 = _id_0EF1::_id_7AED(var_0);
}

_id_CE06(var_0) {
  var_1 = _id_9837();
  var_2 = 225;

  if(isDefined(var_1[var_0]))
    thread[[var_1[var_0]]](var_2);
}

_id_1E0C(var_0) {
  var_1 = 0;
  scripts\engine\utility::waitframe();

  if(!scripts\engine\utility::flag_exist("broadcast_postfunc_complete"))
    scripts\engine\utility::flag_init("broadcast_postfunc_complete");

  while(distance2d(self.origin, level.player.origin) > var_0) {
    if(!var_1 && scripts\engine\utility::flag("broadcast_postfunc_complete")) {
      var_0 = var_0 + 175;
      var_1 = 1;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_9837() {
  var_0 = [];
  var_0["ml_moon"] = ::_id_B8E3;
  var_0["ml_titan"] = ::_id_B8E5;
  var_0["ml_rogue"] = ::_id_B8E4;
  var_0["sa_assassination"] = ::_id_E983;
  var_0["sa_empambush"] = ::_id_E9A3;
  var_0["sa_vips"] = ::_id_E9EA;
  var_0["sa_wounded"] = ::_id_E9F8;
  var_0["ja_asteroid"] = ::_id_A040;
  var_0["ja_mining"] = ::_id_A044;
  var_0["ja_spacestation"] = ::_id_A048;
  var_0["ja_titan"] = ::_id_A04A;
  var_0["ja_wreckage"] = ::_id_A04C;
  return var_0;
}

_id_B8E3(var_0) {}

_id_B8E5(var_0) {
  var_1 = _id_10AB::_id_780D("ml_titan_ambientfeedback1", "ml_titan_bridgelevel_ambient");
  var_2 = _id_10AB::_id_780D("ml_titan_ambientfeedback2", "ml_titan_bridgelevel_ambient");
  var_3 = _id_10AB::_id_780D("ml_titan_ambientfeedback1", "ml_titan_bridgelevel_ambient");
  var_4 = _id_10AB::_id_780D("ml_titan_ambientfeedback2", "ml_titan_bridgelevel_ambient");
  var_1 endon("death");
  var_2 endon("death");
  var_3 endon("death");
  var_4 endon("death");
  var_1 scripts\sp\utility::_id_7799(var_3 gettagorigin("j_head"));
  var_3 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_2 scripts\sp\utility::_id_7799(var_4 gettagorigin("j_head"));
  var_4 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_1 _id_1E0C(650);
  var_1 _id_0EE9::_id_CD78("sc_rogue_un3_iheardwelostano");
  var_2 _id_0EE9::_id_CD78("sc_rogue_un4_youdidntgetther");
  var_1 _id_0EE9::_id_CD78("sc_rogue_un3_captainsgotnine");
  wait 3;
  var_1 _id_1E0C(225);
  var_2 _id_0EE9::_id_CD78("sc_rogue_un1_icantbelievethey");
  var_4 _id_0EE9::_id_CD78("sc_rogue_un2_rumorishes");
  var_2 _id_0EE9::_id_CD78("sc_rogue_un1_soundslikeweneed");
  var_4 _id_0EE9::_id_CD78("sc_rogue_un2_youknowwedallbe");
}

_id_B8E4(var_0) {
  var_1 = _id_10AB::_id_780D("ml_rogue_ambientfeedback1", "ml_rogue_bridgelevel_ambient");
  var_2 = _id_10AB::_id_780D("ml_rogue_ambientfeedback2", "ml_rogue_bridgelevel_ambient");
  var_3 = _id_10AB::_id_780D("ml_rogue_ambientfeedback3", "ml_rogue_bridgelevel_ambient");
  var_1 endon("death");
  var_2 endon("death");
  var_3 endon("death");
  var_1 scripts\sp\utility::_id_7799(var_3 gettagorigin("j_head"));
  var_2 scripts\sp\utility::_id_7799(var_3 gettagorigin("j_head"));
  var_3 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_1 _id_1E0C(var_0);
  var_2 _id_0EE9::_id_CD78("sc_prisoner_un3_yougetyournexta");
  var_3 _id_0EE9::_id_CD78("sc_prisoner_un4_nonotyet");
  var_2 _id_0EE9::_id_CD78("sc_prisoner_un3_haventheardanyt");
  var_3 _id_0EE9::_id_CD78("sc_prisoner_un4_thatsnotlikehim");
  wait 0.6;
  var_1 scripts\sp\utility::_id_77B9(0.7);
  wait 0.4;
  var_2 scripts\sp\utility::_id_77B9(0.6);
  wait 0.3;
  var_3 scripts\sp\utility::_id_77B9(1);
}

_id_E983(var_0) {
  var_1 = _id_10AB::_id_780D("sa_assassination_ambientfeedback1", "sa_assassination_bridgelevel_ambient");
  var_2 = _id_10AB::_id_780D("sa_assassination_ambientfeedback2", "sa_assassination_bridgelevel_ambient");
  var_3 = _id_10AB::_id_780D("sa_assassination_ambientfeedback3", "sa_assassination_bridgelevel_ambient");
  var_4 = _id_10AB::_id_780D("sa_assassination_ambientfeedback4", "sa_assassination_bridgelevel_ambient");
  var_1 endon("death");
  var_2 endon("death");
  var_3 endon("death");
  var_4 endon("death");
  var_1 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_1 scripts\sp\utility::_id_7798(var_2 gettagorigin("j_head"));
  var_2 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_2 scripts\sp\utility::_id_7798(var_1 gettagorigin("j_head"));
  var_1 _id_1E0C(var_0);
  var_1 _id_0EE9::_id_CD78("sc_asn_cm3_iheardthathekil");
  var_2 _id_0EE9::_id_CD78("sc_asn_cm4_thewholecommand");
  var_1 _id_0EE9::_id_CD78("sc_asn_cm3_yeahsetdefmustb");
}

_id_E9A3(var_0) {
  var_1 = _id_10AB::_id_780D("sa_empambush_ambientfeedback1", "sa_empambush_bridgelevel_ambient");
  var_2 = _id_10AB::_id_780D("sa_empambush_ambientfeedback2", "sa_empambush_bridgelevel_ambient");
  var_3 = _id_10AB::_id_780D("sa_empambush_ambientfeedback3", "sa_empambush_bridgelevel_ambient");
  var_4 = _id_10AB::_id_780D("sa_empambush_ambientfeedback4", "sa_empambush_bridgelevel_ambient");
  var_1 endon("death");
  var_2 endon("death");
  var_3 endon("death");
  var_4 endon("death");
  var_1 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_2 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_3 scripts\sp\utility::_id_7799(var_4 gettagorigin("j_head"));
  var_4 scripts\sp\utility::_id_7799(var_3 gettagorigin("j_head"));
  var_1 _id_1E0C(var_0);
  var_1 _id_0EE9::_id_CD78("sc_emp_cm3_hahahayepcaptai");
  var_2 _id_0EE9::_id_CD78("sc_emp_cm4_nicesoundsliket");
  var_1 _id_0EE9::_id_CD78("sc_emp_cm3_absolutelymeanw");
}

_id_E9EA(var_0) {
  var_1 = _id_10AB::_id_780D("sa_vips_ambientfeedback1", "sa_vips_bridgelevel_ambient");
  var_2 = _id_10AB::_id_780D("sa_vips_ambientfeedback2", "sa_vips_bridgelevel_ambient");
  var_3 = _id_10AB::_id_780D("sa_vips_ambientfeedback3", "sa_vips_bridgelevel_ambient");
  var_4 = _id_10AB::_id_780D("sa_vips_ambientfeedback4", "sa_vips_bridgelevel_ambient");
  var_5 = _id_10AB::_id_780D("sa_vips_ambientfeedback5", "sa_vips_bridgelevel_ambient");
  var_6 = _id_10AB::_id_780D("sa_vips_ambientfeedback6", "sa_vips_bridgelevel_ambient");
  var_1 endon("death");
  var_2 endon("death");
  var_3 endon("death");
  var_4 endon("death");
  var_5 endon("death");
  var_6 endon("death");
  var_1 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_5 scripts\sp\utility::_id_7799(var_6 gettagorigin("j_head"));
  var_6 scripts\sp\utility::_id_7799(var_5 gettagorigin("j_head"));
  var_1 _id_1E0C(var_0);
  var_3 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_2 _id_0EE9::_id_CD78("sc_vips_cm3_imonmywaytoengi");
  var_3 scripts\sp\utility::_id_77B7("shrug");
  var_3 _id_0EE9::_id_CD78("sc_vips_cm4_nohowdidyouseei");
  var_2 scripts\sp\utility::_id_7799(var_3 gettagorigin("j_head"));
  var_2 _id_0EE9::_id_CD78("sc_vips_cm3_oneofthebenefit");
  wait 0.33;
  var_2 scripts\sp\utility::_id_77B9(0.7);
  wait 0.45;
  var_3 scripts\sp\utility::_id_77B9(1.2);
}

_id_E9F8(var_0) {
  var_1 = _id_10AB::_id_780D("sa_wounded_ambientfeedback1", "sa_wounded_bridgelevel_ambient");
  var_2 = _id_10AB::_id_780D("sa_wounded_ambientfeedback3", "sa_wounded_bridgelevel_ambient");
  var_1 endon("death");
  var_2 endon("death");
  var_1 _id_1E0C(var_0);
  var_1 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_2 scripts\engine\utility::delaythread(0.7, scripts\sp\utility::_id_7799, var_1 gettagorigin("j_head"));
  var_1 _id_0EE9::_id_CD78("sc_wnd_cm3_idontknowwordar");
  var_2 _id_0EE9::_id_CD78("sc_wnd_cm4_ohmanthatsahuge");
  var_1 _id_0EE9::_id_CD78("sc_wnd_cm3_exactlyimpretty");
  wait 0.5;
  var_1 scripts\sp\utility::_id_77B9(0.7);
}

_id_A040(var_0) {
  var_1 = _id_10AB::_id_780D("ja_asteroid_ambientfeedback2", "ja_asteroid_bridgelevel_ambient");
  var_2 = _id_10AB::_id_780D("ja_asteroid_ambientfeedback3", "ja_asteroid_bridgelevel_ambient");
  var_3 = _id_10AB::_id_780D("ja_asteroid_ambientfeedback4", "ja_asteroid_bridgelevel_ambient");
  var_4 = _id_10AB::_id_780D("ja_asteroid_ambientfeedback6", "ja_asteroid_bridgelevel_ambient");
  var_5 = _id_10AB::_id_780D("ja_asteroid_ambientfeedback7", "ja_asteroid_bridgelevel_ambient");
  var_2 endon("death");
  var_3 endon("death");
  var_4 endon("death");
  var_5 endon("death");
  var_2 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_3 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_1 scripts\sp\utility::_id_7799(var_3 gettagorigin("j_head"));
  var_5 scripts\sp\utility::_id_7799(var_4 gettagorigin("j_head"));
  var_2 _id_1E0C(var_0);
  var_3 _id_0EE9::_id_CD78("ja_ast_un1_lottapressureri");
  var_1 _id_0EE9::_id_CD78("ja_ast_un2_dontletthemgeti");
  var_3 _id_0EE9::_id_CD78("ja_ast_un1_yourerightcapta");
  wait 0.7;
  var_3 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  wait 0.4;
  var_2 scripts\sp\utility::_id_77B9(0.7);
}

_id_A044(var_0) {
  var_1 = _id_10AB::_id_780D("ja_mining_ambientfeedback1", "ja_mining_bridgelevel_ambient");
  var_2 = _id_10AB::_id_780D("ja_mining_ambientfeedback2", "ja_mining_bridgelevel_ambient");
  var_3 = _id_10AB::_id_780D("ja_mining_ambientfeedback4", "ja_mining_bridgelevel_ambient");
  var_1 endon("death");
  var_2 endon("death");
  var_3 endon("death");
  var_1 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_2 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_1 _id_1E0C(var_0);
  var_1 _id_0EE9::_id_CD78("ja_mining_un1_manittookgutsgo");
  var_2 _id_0EE9::_id_CD78("ja_mining_un2_idontthinkthere");
  var_1 _id_0EE9::_id_CD78("ja_mining_un1_thatshowscarsdo");
  var_1 _id_13677(90, var_0 + 100);
  var_3 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_1 scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_7799, var_3 gettagorigin("j_head"));
  var_2 scripts\engine\utility::delaythread(0.8, scripts\sp\utility::_id_7799, var_3 gettagorigin("j_head"));
  var_3 _id_0EE9::_id_CD78("ja_mining_un5_onestepupforthe");
  var_3 _id_0EE9::_id_CD78("ja_mining_un5_thewaythisshipa");
  wait 0.6;
  var_3 scripts\sp\utility::_id_77B9(0.6);
  wait 0.3;
  var_2 scripts\sp\utility::_id_77B9(1);
  wait 0.2;
  var_1 scripts\sp\utility::_id_77B9(0.8);
}

_id_A048(var_0) {
  var_1 = _id_10AB::_id_780D("ja_spacestation_ambientfeedback1", "ja_spacestation_bridgelevel_ambient");
  var_2 = _id_10AB::_id_780D("ja_spacestation_ambientfeedback2", "ja_spacestation_bridgelevel_ambient");
  var_3 = _id_10AB::_id_780D("ja_spacestation_ambientfeedback3", "ja_spacestation_bridgelevel_ambient");
  var_4 = _id_10AB::_id_780D("ja_spacestation_ambientfeedback4", "ja_spacestation_bridgelevel_ambient");
  var_1 endon("death");
  var_2 endon("death");
  var_3 endon("death");
  var_4 endon("death");
  var_1 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_2 scripts\sp\utility::_id_7799(var_3 gettagorigin("j_head"));
  var_3 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_4 scripts\sp\utility::_id_7799(var_3 gettagorigin("j_head"));
  var_1 _id_1E0C(var_0);
  var_3 _id_0EE9::_id_CD78("ja_spstation_un1_theyretryingtor");
  var_2 _id_0EE9::_id_CD78("ja_spstation_un2_olympusmonsistw");
  var_3 _id_0EE9::_id_CD78("ja_spstation_un1_everyshipsgotaw");
}

_id_A04A(var_0) {
  var_1 = _id_10AB::_id_780D("ja_titan_ambientfeedback1", "ja_titan_bridgelevel_ambient");
  var_2 = _id_10AB::_id_780D("ja_titan_ambientfeedback2", "ja_titan_bridgelevel_ambient");
  var_3 = _id_10AB::_id_780D("ja_titan_ambientfeedback3", "ja_titan_bridgelevel_ambient");
  var_4 = _id_10AB::_id_780D("ja_titan_ambientfeedback4", "ja_titan_bridgelevel_ambient");
  var_5 = _id_10AB::_id_780D("ja_titan_ambientfeedback5", "ja_titan_bridgelevel_ambient");
  var_1 endon("death");
  var_2 endon("death");
  var_3 endon("death");
  var_4 endon("death");
  var_5 endon("death");
  var_1 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_2 scripts\sp\utility::_id_7799(var_3 gettagorigin("j_head"));
  var_3 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_4 scripts\sp\utility::_id_7799(var_5 gettagorigin("j_head"));
  var_5 scripts\sp\utility::_id_7799(var_4 gettagorigin("j_head"));
  var_1 _id_1E0C(var_0);
  var_2 _id_0EE9::_id_CD78("ja_titan_un2_iwonderwhathapp");
  var_3 _id_0EE9::_id_CD78("ja_titan_un1_itssetdefwhatdo");
  var_2 _id_0EE9::_id_CD78("ja_titan_un2_manimgladthecap");
  var_2 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_3 scripts\sp\utility::_id_7799(var_1 gettagorigin("j_head"));
  var_1 _id_0EE9::_id_CD78("ja_titan_un5_yeahyoudthinkwi");
  var_1 _id_0EE9::_id_CD78("ja_titan_un5_goodthingtooloo");
}

_id_A04C(var_0) {
  var_1 = _id_10AB::_id_780D("ja_wreckage_ambientfeedback1", "ja_wreckage_bridgelevel_ambient");
  var_2 = _id_10AB::_id_780D("ja_wreckage_ambientfeedback2", "ja_wreckage_bridgelevel_ambient");
  var_3 = _id_10AB::_id_780D("ja_wreckage_ambientfeedback3", "ja_wreckage_bridgelevel_ambient");
  var_4 = _id_10AB::_id_780D("ja_wreckage_ambientfeedback4", "ja_wreckage_bridgelevel_ambient");
  var_5 = _id_10AB::_id_780D("ja_wreckage_ambientfeedback5", "ja_wreckage_bridgelevel_ambient");
  var_1 endon("death");
  var_2 endon("death");
  var_3 endon("death");
  var_4 endon("death");
  var_5 endon("death");
  var_3 scripts\sp\utility::_id_7799(var_2 gettagorigin("j_head"));
  var_2 _id_1E0C(var_0);
  var_2 scripts\sp\utility::_id_7799(var_3 gettagorigin("j_head"));
  var_2 _id_0EE9::_id_CD78("ja_wreck_un2_theyweregettini");
  var_3 _id_0EE9::_id_CD78("ja_wreck_un1_yeahtheystitche");
  var_2 _id_0EE9::_id_CD78("ja_wreck_un2_nahcapnknowshow");
}

_id_1375E(var_0) {
  while(distance2d(self.origin, level.player.origin) > var_0)
    scripts\engine\utility::waitframe();
}

_id_CE07(var_0) {
  if(isDefined(var_0)) {
    if(isarray(var_0)) {
      for(var_1 = 0; var_1 < var_0.size; var_1++)
        _id_CE09(var_0[var_1]);
    } else
      _id_CE09(var_0);
  }
}

_id_CE09(var_0) {
  if(isstring(var_0)) {
    if(soundexists(var_0))
      _id_CE08(var_0);
    else
      _id_0B6A::_id_EC0E(var_0);
  } else if(isnumber(var_0))
    wait(var_0);
}

_id_CE08(var_0) {
  if(self == level.player || issubstr(var_0, "plr"))
    scripts\sp\utility::_id_1034D(var_0);
  else
    scripts\sp\utility::_id_10346(var_0);
}

_id_7C58() {
  return _id_0EFB::_id_7AF0();
}

_id_7C56(var_0) {
  return var_0 + "_bridgelevel_ambient";
}

_id_7C57(var_0) {
  var_1 = ::_id_ADF5;
  return var_1;
}

#using_animtree("generic_human");

_id_ADF5() {
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_02"][0] = % shipcrib_stand_stationary_talk_idle_02;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_01"][0] = % shipcrib_lounge_seated_table_idle_01;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_02"][0] = % shipcrib_lounge_seated_table_idle_02;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_03"][0] = % shipcrib_lounge_seated_table_idle_03;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_04_guya"][0] = % shipcrib_lounge_seated_table_idle_04_guya;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_04_guyb"][0] = % shipcrib_lounge_seated_table_idle_04_guyb;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_05_guya"][0] = % shipcrib_lounge_seated_table_idle_05_guya;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_05_guyb"][0] = % shipcrib_lounge_seated_table_idle_05_guyb;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_04_guyA"][0] = % shipcrib_lounge_seated_table_idle_04_guya;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_04_guyB"][0] = % shipcrib_lounge_seated_table_idle_04_guyb;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_05_guyA"][0] = % shipcrib_lounge_seated_table_idle_05_guya;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_05_guyB"][0] = % shipcrib_lounge_seated_table_idle_05_guyb;
  level._id_EC85["generic"]["shipcrib_stand_conversation_loop_guya"][0] = % shipcrib_stand_conversation_loop_guya;
  level._id_EC85["generic"]["shipcrib_stand_conversation_loop_guyb"][0] = % shipcrib_stand_conversation_loop_guyb;
  level._id_EC85["generic"]["shipcrib_stand_conversation_loop_guyA"][0] = % shipcrib_stand_conversation_loop_guya;
  level._id_EC85["generic"]["shipcrib_stand_conversation_loop_guyB"][0] = % shipcrib_stand_conversation_loop_guyb;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_01"][0] = % shipcrib_stand_stationary_talk_idle_01;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_02"][0] = % shipcrib_stand_stationary_talk_idle_02;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_03"][0] = % shipcrib_stand_stationary_talk_idle_03;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_04"][0] = % shipcrib_stand_stationary_talk_idle_04;
  level._id_EC85["generic"]["shipcrib_stand_stationary_talk_idle_05"][0] = % shipcrib_stand_stationary_talk_idle_05;
  level._id_EC85["generic"]["shipcrib_lounge_lean_idle_01"][0] = % shipcrib_lounge_lean_idle_01;
  level._id_EC85["generic"]["shipcrib_lounge_lean_idle_02"][0] = % shipcrib_lounge_lean_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_death_B"][0] = % shipcrib_moon_injured_grnd_01_idle_death_b;
  level._id_EC85["generic"]["shipcrib_moon_coughing"][0] = % shipcrib_moon_coughing;
  level._id_EC85["generic"]["shipcrib_deck_crouch_repair_loop_01"][0] = % shipcrib_deck_crouch_repair_loop_01;
  level._id_EC85["generic"]["shipcrib_inspection_idle"][0] = % shipcrib_inspection_idle;
  level._id_EC85["generic"]["shipcrib_hangar_stand_lean_idle_01"][0] = % shipcrib_hangar_stand_lean_idle_01;
  level._id_EC85["generic"]["shipcrib_hangar_stand_lean_idle_02"][0] = % shipcrib_hangar_stand_lean_idle_02;
  level._id_EC85["generic"]["shipcrib_hangar_stand_lean_idle_03"][0] = % shipcrib_hangar_stand_lean_idle_03;
  level._id_EC85["generic"]["shipcrib_hangar_stand_lean_idle_04"][0] = % shipcrib_hangar_stand_lean_idle_04;
  level._id_EC85["generic"]["shipcrib_hangar_stand_lean_idle_05"][0] = % shipcrib_hangar_stand_lean_idle_05;
  level._id_EC85["generic"]["shipcrib_hangar_stand_lean_idle_06"][0] = % shipcrib_hangar_stand_lean_idle_06;
  level._id_EC85["generic"]["shipcrib_hangar_stand_lean_idle_07"][0] = % shipcrib_hangar_stand_lean_idle_07;
  level._id_EC85["generic"]["shipcrib_standing_console_idle_01"][0] = % shipcrib_standing_console_idle_01;
  level._id_EC85["generic"]["shipcrib_standing_console_idle_02"][0] = % shipcrib_standing_console_idle_02;
  level._id_EC85["generic"]["shipcrib_standing_console_idle_03"][0] = % shipcrib_standing_console_idle_03;
  level._id_EC85["generic"]["shipcrib_deck_standing_console_idle_02"][0] = % shipcrib_deck_standing_console_idle_02;
  level._id_EC85["generic"]["shipcrib_europa_bridge_hall_repair_ladder_01"][0] = % shipcrib_europa_bridge_hall_repair_ladder_01;
  level._id_EC85["generic"]["SH4_2_10B_ARM_HALL_JACK_idle"][0] = % sh4_2_10b_arm_hall_jack_idle;
  level._id_EC85["generic"]["SH_MN_1_14A_ARM_HALL_JACK_idle"][0] = % sh_mn_1_14a_arm_hall_jack_idle;
  level._id_EC85["generic"]["shipcrib_bridge_micro_manage_idle_02"][0] = % shipcrib_bridge_micro_manage_idle_02;
  level._id_EC85["generic"]["shipcrib_europa_bridge_hall_repair_powerbox"][0] = % shipcrib_europa_bridge_hall_repair_powerbox;
  level._id_EC85["generic"]["sa_hallway_hustle_kneel"][0] = % shipcrib_hangar_guy_hustle_idle_kneel;
  level._id_EC85["generic"]["shipcrib_lounge_sit_idle_02"][0] = % shipcrib_lounge_sit_idle_02;
  level._id_EC85["generic"]["shipcrib_lounge_sit_idle_03"][0] = % shipcrib_lounge_sit_idle_03;
  level._id_EC85["generic"]["hm_grnd_grn_kneel_idle_01"][0] = % hm_grnd_grn_kneel_idle_01;
  level._id_EC85["generic"]["sa_hallway_hustle_lean"][0] = % shipcrib_hangar_guy_hustle_idle_lean;
  level._id_EC85["generic"]["shipcrib_lounge_barstool_idle_01"][0] = % shipcrib_lounge_barstool_idle_01;
  level._id_EC85["generic"]["shipcrib_lounge_barstool_idle_03"][0] = % shipcrib_lounge_barstool_idle_03;
  level._id_EC85["generic"]["shipcrib_lounge_barstool_idle_04_fem"][0] = % shipcrib_lounge_barstool_idle_04_fem;
  level._id_EC85["generic"]["shipcrib_lounge_barstool_idle_05"][0] = % shipcrib_lounge_barstool_idle_05;
  level._id_EC85["generic"]["shipcrib_lounge_barcounter_stand_01"][0] = % shipcrib_lounge_barcounter_stand_01;
}

_id_ADFB(var_0) {
  if(!isDefined(level._id_1355C) && var_0 != "ml_rogue") {
    _id_0EE8::_id_FA5A();
    _id_ADF2();
    _id_ADF1();
    var_1 = scripts\sp\utility::_id_10639("vr_rifle");
    level._id_1355C = _id_0EF8::_id_FDFC("spawner_vr_user", "lounge_vr_ambientguy", "cheap");
    var_2 = scripts\engine\utility::getStruct("lounge_vr_ambientguy", "targetname");
    var_2 thread scripts\sp\anim::_id_1ECC(level._id_1355C, "vr_loop");
    var_2 thread scripts\sp\anim::_id_1EEA(var_1, "vr_loop");
    level._id_1355C _id_DB8A();
    level._id_1355C waittill("death");
    var_1 delete();
  }
}

#using_animtree("script_model");

_id_ADF2() {
  level._id_EC87["vr_goggles"] = #animtree;
  level._id_EC8C["vr_goggles"] = "vr_goggles_hero_xo";
  level._id_EC85["vr_goggles"]["vr_loop"][0] = % shipcrib_lounge_vr_goggles_loop;
  level._id_EC87["vr_rifle"] = #animtree;
  level._id_EC8C["vr_rifle"] = "weapon_vr_rifle_wm";
  level._id_EC85["vr_rifle"]["vr_loop"][0] = % shipcrib_lounge_vr_gun_loop;
}

#using_animtree("generic_human");

_id_ADF1() {
  level._id_EC85["generic"]["vr_loop"][0] = % shipcrib_lounge_vr_loop;
}

_id_DB8A() {
  self endon("death");
  var_0 = [];
  var_0[var_0.size] = "sc_europa_uf1_yeah";
  var_0[var_0.size] = "sc_europa_uf1_gotem";
  var_0[var_0.size] = "sc_europa_uf1_thatsthekickims";
  var_0[var_0.size] = "sc_europa_uf1_definitelyputti";

  while(!scripts\sp\interaction_manager::_id_9EED(120))
    scripts\engine\utility::waitframe();

  var_1 = randomintrange(1, 6);

  switch (var_1) {
    case 1:
      _id_0EE9::_id_CD78("sc_europa_uf1_thatsthekickims");
      break;
    case 2:
      _id_0EE9::_id_CD78("sc_europa_uf1_definitelyputti");
      break;
    default:
      _id_0EE9::_id_CD78("sc_europa_uf1_yeah");
      _id_0EE9::_id_CD78("sc_europa_uf1_gotem");
  }
}

_id_ADF8(var_0) {
  if(_id_0EFB::_id_9CB4() || !(issubstr(var_0, "sa_") || issubstr(var_0, "ja_"))) {
    return;
  }
  _id_ADF9();
  var_1 = scripts\engine\utility::getStruct("sc_sa_greeting_animnode", "targetname");
  level._id_E9B4 = _id_0EF8::_id_FE01("spawner_interior", var_1);
  level._id_E9B4 endon("death");
  var_2 = var_0 + "_greeting_intro";
  var_3 = var_0 + "_greeting_idle";

  if(var_2 == "ja_spacestation_greeting_intro")
    level._id_E9B4 hidepart("j_helmet");

  level._id_E9B4 _id_16E6(var_2);
  var_1 scripts\sp\anim::_id_1ECA(level._id_E9B4, var_2);
  _id_8576(var_2);
  var_1 scripts\sp\anim::_id_1EC7(level._id_E9B4, var_2);
  level._id_E9B4 scripts\sp\anim::_id_1ECC(level._id_E9B4, var_3);
}

_id_ADF9() {
  level._id_EC85["generic"]["sa_assassination_greeting_intro"] = % sa_assassination_return_ally01_scene;
  level._id_EC85["generic"]["sa_empambush_greeting_intro"] = % sa_ambush_return_ally01_scene;
  level._id_EC85["generic"]["sa_vips_greeting_intro"] = % sa_vips_return_ally01_scene;
  level._id_EC85["generic"]["sa_wounded_greeting_intro"] = % sa_wounded_return_ally01_scene;
  level._id_EC85["generic"]["ja_asteroid_greeting_intro"] = % ja_asteroid_return_ally01_scene;
  level._id_EC85["generic"]["ja_mining_greeting_intro"] = % ja_mining_return_ally01_scene;
  level._id_EC85["generic"]["ja_titan_greeting_intro"] = % ja_titan_return_ally01_scene;
  level._id_EC85["generic"]["ja_spacestation_greeting_intro"] = % ja_spacestation_return_ally01_scene;
  level._id_EC85["generic"]["ja_wreckage_greeting_intro"] = % ja_wreckage_return_ally01_scene;
  level._id_EC85["generic"]["sa_assassination_greeting_idle"][0] = % shipcrib_inspection_idle;
  level._id_EC85["generic"]["sa_empambush_greeting_idle"][0] = % shipcrib_inspection_idle;
  level._id_EC85["generic"]["sa_vips_greeting_idle"][0] = % shipcrib_standing_console_idle_01;
  level._id_EC85["generic"]["sa_wounded_greeting_idle"][0] = % sh4_2_10b_arm_hall_jack_idle;
  level._id_EC85["generic"]["ja_asteroid_greeting_idle"][0] = % shipcrib_inspection_idle;
  level._id_EC85["generic"]["ja_mining_greeting_idle"][0] = % shipcrib_stand_stationary_talk_idle_02;
  level._id_EC85["generic"]["ja_titan_greeting_idle"][0] = % shipcrib_inspection_idle;
  level._id_EC85["generic"]["ja_spacestation_greeting_idle"][0] = % shipcrib_stand_stationary_talk_idle_02;
  level._id_EC85["generic"]["ja_wreckage_greeting_idle"][0] = % shipcrib_inspection_idle;
}

_id_16E6(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "sa_assassination_greeting_intro":
      var_1 = 1;
      break;
    case "sa_empambush_greeting_intro":
      var_1 = 1;
      break;
    case "sa_vips_greeting_intro":
      break;
    case "ja_asteroid_greeting_intro":
      var_1 = 1;
      break;
    case "ja_titan_greeting_intro":
      var_1 = 1;
      break;
    case "ja_wreckage_greeting_intro":
      var_1 = 1;
      break;
  }

  if(var_1)
    _id_2462();
}

_id_2462() {
  self._id_247B = spawn("script_model", self.origin);
  self._id_247B setModel("p7_desk_metal_military_03_tablet");
  self._id_247B linkTo(self, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
  self._id_247B thread _id_4081(self);
}

_id_4081(var_0) {
  var_0 waittill("death");

  if(isDefined(self))
    self delete();
}

_id_8576(var_0) {
  var_1 = 3;

  switch (var_0) {
    case "sa_assassination_greeting_intro":
      var_1 = var_1 + -0.5;
      break;
    case "sa_empambush_greeting_intro":
      var_1 = var_1 + -0.75;
      break;
    case "sa_vips_greeting_intro":
      var_1 = var_1 + 0;
      break;
    case "sa_wounded_greeting_intro":
      var_1 = var_1 + -1.25;
      break;
    case "ja_asteroid_greeting_intro":
      var_1 = var_1 + -1.25;
      break;
    case "ja_mining_greeting_intro":
      var_1 = var_1 + 0.25;
      break;
    case "ja_spacestation_greeting_intro":
      var_1 = var_1 + 0;
      break;
    case "ja_titan_greeting_intro":
      var_1 = var_1 + -2.95;
      break;
    case "ja_wreckage_greeting_intro":
      var_1 = var_1 + -2;
      break;
  }

  wait(var_1);
}

_id_ADF7() {
  level._id_EC88["gator"]["sc_asn_nav_welcomebacksir"] = % sc_asn_nav_200_230_i2;
  level._id_EC88["salter"]["sc_asn_slt_ibriefedeveryon"] = % sc_asn_slt_200_240_i2;
  level._id_EC88["gator"]["sc_asn_nav_youvegotthemrun"] = % sc_asn_nav_200_250_i2;
  level._id_EC88["drop_officer"]["sc_asn_dpo_theyrestillprob"] = % sc_asn_dpo_200_270_i2;
  level._id_EC88["salter"]["sc_asn_slt_nexttimeyouandm"] = % sc_asn_slt_200_260_i2;
  level._id_EC88["gator"]["sc_emp_nav_thesdfcerberusw"] = % sc_emp_nav_200_250_i2;
  level._id_EC88["salter"]["sc_emp_slt_notabaddayswork"] = % sc_emp_slt_200_260_i2;
  level._id_EC88["gator"]["sc_emp_nav_wellexecutedina"] = % sc_emp_nav_200_270_i2;
  level._id_EC88["drop_officer"]["sc_emp_dpo_gladyouandthelt"] = % sc_emp_dpo_200_290_i2;
  level._id_EC88["salter"]["sc_emp_slt_impressiveoutth"] = % sc_emp_slt_200_280_i2;
  level._id_EC88["gator"]["sc_vips_nav_salutecaptainso"] = % sc_vips_nav_200_280_i2;
  level._id_EC88["gator"]["sc_vips_nav_thatdefinitelyp"] = % sc_vips_nav_200_300_i2;
  level._id_EC88["drop_officer"]["sc_vips_dpo_griffsbeenitchi"] = % sc_vips_dpo_200_320_i2;
  level._id_EC88["salter"]["sc_vips_slt_iwonderwhatothe"] = % sc_vips_slt_200_310_i2;
  level._id_EC88["gator"]["sc_wnd_nav_roughskiesoutth"] = % sc_wnd_nav_200_240_i2;
  level._id_EC88["gator"]["sc_wnd_nav_thesuccessofthi"] = % sc_wnd_nav_200_260_i2;
  level._id_EC88["drop_officer"]["sc_wnd_dpo_thatwasabraveru"] = % sc_wnd_dpo_200_280_i2;
  level._id_EC88["salter"]["sc_wnd_slt_nothinglikedrop"] = % sc_wnd_slt_200_250_i2;
  level._id_EC88["gator"]["ja_ast_nav_welcomebacksirw"] = % ja_ast_nav_3_90_i2;
  level._id_EC88["gator"]["ja_ast_nav_gladtohaveyouba"] = % ja_ast_nav_3_110_i2;
  level._id_EC88["drop_officer"]["ja_ast_dpo_iwassecondsaway"] = % ja_ast_dpo_3_130_i2;
  level._id_EC88["salter"]["ja_ast_slt_fornowithinkits"] = % ja_ast_slt_3_120_i2;
  level._id_EC88["gator"]["ja_mining_nav_captainyouhadme"] = % ja_mining_nav_3_90_i2;
  level._id_EC88["gator"]["ja_mining_nav_wheretonextsir"] = % ja_mining_nav_3_110_i2;
  level._id_EC88["salter"]["ja_mining_slt_readyformoreico"] = % ja_mining_slt_3_120_i2;
  level._id_EC88["drop_officer"]["ja_mining_dpo_welcomebackcapt"] = % ja_mining_dpo_3_130_i2;
  level._id_EC88["gator"]["ja_spstation_nav_captainhastheco"] = % ja_spstation_nav_3_90_i2;
  level._id_EC88["gator"]["ja_spstation_nav_wearestandingby"] = % ja_spstation_nav_3_110_i2;
  level._id_EC88["salter"]["ja_spstation_slt_letsgoseeifsdfi"] = % ja_spstation_slt_3_120_i2;
  level._id_EC88["drop_officer"]["ja_spstation_dpo_largescalebattl"] = % ja_spstation_dpo_3_130_i2;
  level._id_EC88["gator"]["ja_titan_nav_jackpotsquareda"] = % ja_titan_nav_3_90_i2;
  level._id_EC88["gator"]["ja_titan_nav_preppingtoleave"] = % ja_titan_nav_3_110_i2;
  level._id_EC88["salter"]["ja_titan_slt_anothersetdeffl"] = % ja_titan_slt_3_120_i2;
  level._id_EC88["drop_officer"]["ja_titan_dpo_thanksforcleari"] = % ja_titan_dpo_3_130_i2;
  level._id_EC88["gator"]["ja_wreck_nav_anotherjobwelld"] = % ja_wreck_nav_3_90_i2;
  level._id_EC88["salter"]["ja_wreck_slt_setdefcankeepma"] = % ja_wreck_slt_3_100_i2;
  level._id_EC88["gator"]["ja_wreck_nav_wehavenotyetsto"] = % ja_wreck_nav_3_110_i2;
  level._id_EC88["drop_officer"]["ja_wreck_dpo_thatdestroyerwa"] = % ja_wreck_dpo_3_130_i2;
}