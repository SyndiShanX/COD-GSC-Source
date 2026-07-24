/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heist\heist_un_rooftop.gsc
******************************************************/

_id_1D1E() {
  if(!isDefined(level._id_EA2C)) {
    scripts\sp\maps\heist\heist_util::_id_107BE();
  }

  if(!isDefined(level._id_6754)) {
    scripts\sp\maps\heist\heist_util::_id_106D9();
  }

  if(!isDefined(level._id_76FB)) {
    scripts\sp\maps\heist\heist_util::_id_10710();
  }

  level._id_EA2C scripts\sp\utility::_id_54F7();
  level._id_76FB scripts\sp\utility::_id_54F7();
  level._id_6754 scripts\sp\utility::_id_54F7();
  level._id_EA2C setgoalpos(level._id_EA2C.origin);
  level._id_76FB setgoalpos(level._id_76FB.origin);
  level._id_6754 setgoalpos(level._id_6754.origin);
}

_id_D93F() {
  scripts\sp\utility::_id_F5AF("continue_player_beatdown", [level.player]);
  setomnvar("ui_hide_hud", 1);

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_8E06();
  }
}

_id_D93D() {
  thread _id_8D25();
  scripts\engine\utility::delaythread(0.5, scripts\engine\utility::flag_set, "transient_top_of_church");
  scripts\sp\maps\heist\heist::_id_F044();
  scripts\sp\maps\heist\heist::_id_F052();
  thread _id_3F89();
  thread _id_6EEF();
  scripts\sp\maps\heist\heist_util::_id_5569("!freeze");
  scripts\sp\maps\prisoner\prisoner_hvt_scene::_id_9240();
}

_id_D93E() {
  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_8E06();
  }
}

_id_119FE() {
  scripts\sp\utility::_id_F5AF("continue_player_top_of_church", [level.player]);
  scripts\sp\maps\prisoner\prisoner_hvt_scene::_id_9248();
  scripts\sp\maps\heist\heist::_id_F044();
  scripts\sp\maps\heist\heist::_id_F052();
  thread _id_3F89();
  _id_6EEF();
  level.player giveweapon("iw7_gunless");
  level.player switchtoweapon("iw7_gunless");
  level.player scripts\sp\maps\heist\heist_util::_id_5569("!freeze");
  level._id_9225 = getEnt("fake_peek_church", "targetname");
  level._id_9225._id_1FBB = "churchfall_door";
  level._id_9225 scripts\sp\utility::_id_23B7();
  level._id_9265 = scripts\engine\utility::getStruct("hvr_finale_anim_origin", "targetname");
  level._id_9266 = level._id_9265 scripts\engine\utility::spawn_tag_origin();
  level._id_9267 = level._id_9265 scripts\engine\utility::spawn_tag_origin();
  scripts\sp\maps\prisoner\prisoner_hvt_scene::_id_1073D();
  level.player._id_E505 = scripts\sp\utility::_id_10639("player_rig", level._id_9265.origin, level._id_9265.angles);
  level.player playerlinktodelta(level.player._id_E505, "tag_player", 1, 10, 10, 10, 10, 1);
  level.player _meth_8392(0, 5, 5);
  level._id_924B = 1;
  level._id_10DA9 = 1;
  scripts\engine\utility::flag_set("hvt_anim_done");
  thread scripts\sp\maps\prisoner\prisoner_hvt_scene::_id_D757(1);
  [var_1, var_2, var_3, var_4] = ::scripts\sp\maps\prisoner\prisoner_hvt_scene::_id_107AC();
  scripts\sp\maps\prisoner\prisoner_hvt_scene::_id_8D20();
  scripts\sp\maps\prisoner\prisoner_hvt_scene::_id_1073C();
  level._id_9265 scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F2A, [level._id_920F], "churchfall_death_b", 0.99);
  level.player._id_E505 scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F2A, [var_1, var_2, var_3, var_4], "churchfall_death_b", 0.4);
  level.player._id_E505 scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F2A, [level._id_E6C3, level._id_E690], "mons_rumble", 0.4);
  level._id_9265 thread scripts\sp\anim::_id_1F35(level._id_920F, "churchfall_death_b");
  level._id_9265 thread scripts\sp\anim::_id_1F2C([level._id_E6C3, level._id_E690], "mons_rumble");
  level._id_9265 thread scripts\sp\anim::_id_1F2C([var_1, var_2, var_3, var_4], "churchfall_death_b");
  playFX(scripts\engine\utility::getfx("heist_riah_bloodpool"), (-4552, -14389, 696));
}

_id_119F5() {
  scripts\sp\maps\heist\heist::_id_F054();
  thread _id_0B1E::_id_551D("hvr_finale_door");
  thread _id_119FD();
  thread _id_119F6();
  thread _id_119FF();
  scripts\engine\utility::flag_wait("top_of_church_end");
}

_id_8D25() {}

_id_2AE0(var_0) {
  stopcinematicingame();
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame(var_0);

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  while(iscinematicplaying()) {
    wait 0.05;
  }

  stopcinematicingame();
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
}

_id_119F6() {
  level waittill("gator_pip");
  thread _id_2AE0("heist_hud_gator_fullscreen");
  wait 5.3;
  thread scripts\sp\utility::_id_1034D("prisoner_plr_copyineedretto");
  level waittill("admiral_pip");
  thread _id_DC37();
  thread _id_2AE0("heist_hud_adm_fullscreen");
  level.player playSound("ui_pip_on_hud_right");
  level.player scripts\engine\utility::delaythread(2.75, scripts\sp\utility::_id_D090, "ges_radio");
  level.player scripts\engine\utility::delaycall(3.25, ::playsound, "ges_plr_radio_on");
  wait 3.5;
  thread scripts\sp\utility::_id_1034D("prisoner_plr_riahsdeadhedes");
  wait 5.5;
  level scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_F225, "sdf_ships_arrive");
  level scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_F225, "mons_fire");
  scripts\sp\utility::_id_10350("prisoner_eth_allstationsolymp");
  scripts\sp\utility::_id_1034D("prisoner_plr_admiralyouneedt");
  wait 0.6;
  level notify("raines_ar_callout_remove");
  wait 1;
  level.player scripts\sp\utility::_id_1034D("heist_plr_nonono");
  wait 0.25;
  level.player scripts\sp\utility::_id_1034D("heist_plr_rainesadmiralra");
  scripts\engine\utility::flag_set("top_of_church_end");
  thread scripts\sp\utility::_id_10350("prisoner_slt_hesgonereyest");
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::_id_1102B("ges_radio");
}

_id_119FD() {
  while(!isDefined(level._id_924B)) {
    wait 0.05;
  }

  thread _id_119F7();

  if(isDefined(level._id_10DA9)) {
    level.player._id_E505 scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F2A, [level.player._id_E505], "churchfall_death_b", 0.4);
    level._id_9267 scripts\sp\anim::_id_1F35(level.player._id_E505, "churchfall_death_b");
  } else {
    level._id_9267 scripts\sp\anim::_id_1F35(level.player._id_E505, "churchfall_death_a");
    level._id_9267 scripts\sp\anim::_id_1F35(level.player._id_E505, "churchfall_death_b");
  }

  if(isDefined(level._id_9262)) {
    setsaveddvar("sv_znear", level._id_9262);
  }

  level._id_9266 delete();
  level._id_9267 delete();
  level.player unlink();
  level.player._id_E505 delete();
  level.player _meth_84FD();
  level.player setstance("stand");
  level.player scripts\sp\maps\heist\heist_util::_id_6229(["!prone", "!weaponswitch"]);
  level notify("player_standing");
  thread scripts\sp\utility::_id_266F();
  level waittill("mons_fire");
  var_0 = scripts\engine\utility::getStruct("un_rooftop_dragon_target", "targetname");
  level._id_BAE8 thread _id_0BB4::_id_BA69(var_0.origin, 1.5);
  wait 2.0;
  level._id_BAE8 thread _id_0BB4::_id_BA6A(2, 2);
  wait 2.0;
  thread scripts\engine\utility::play_sound_in_space("scn_heist_mons_blowup_building", var_0.origin);
  level notify("un_building_go_boom");
}

_id_119FF() {
  var_0 = scripts\engine\utility::getStruct("un_rooftop_dragon_target", "targetname");
  level._id_12B4E = getEnt("un_building_model", "targetname");
  level._id_12B4F = getEnt("un_building_tower_model", "targetname");
  level._id_12B4E._id_1FBB = "un_building";
  level._id_12B4E scripts\sp\utility::_id_23B7();
  level._id_12B4E notsolid();
  level._id_12B4E dontcastshadows();
  level waittill("un_building_go_boom");
  level._id_12B4F delete();
  level._id_12B4E setModel("building_geneva_vista_periph_un_01_dest_full_animate");
  playFX(level._effect["vfx_heist_building_explosion"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  playFX(level._effect["vfx_heist_dragon_imp_flare"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  thread _id_11A00();
  level._id_12B4E scripts\sp\anim::_id_1F35(level._id_12B4E, "un_building_destruction");
  level._id_12B4E scripts\sp\anim::_id_1EE0(level._id_12B4E, "un_building_destruction");
}

_id_11A00() {
  level.player playRumbleOnEntity("heavy_3s");
  setsaveddvar("r_mbenable", 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideRadius", 0.5, 0.25);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialoverridechromaticAberration", 1.0, 0.25);
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0.1, 0.25);
  setsaveddvar("r_mbRadialOverridePosition", level._id_12B4E.origin);
  setsaveddvar("r_mbRadialOverridePositionActive", 1);
  scripts\sp\hud_util::_id_6AA3(0.1, "white");
  scripts\sp\hud_util::_id_6A99(0.2, "white");
  wait 0.2;
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideRadius", 0.4, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialoverridechromaticAberration", 0.2, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0.05, 1);
  wait 1.0;
  thread scripts\sp\utility::_id_AB9A("r_mbenable", 0, 3);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialoverridechromaticAberration", 0, 3);
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0, 3);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideRadius", 0, 2);
  wait 3.0;
  setsaveddvar("r_mbRadialOverridePosition", 0);
  setsaveddvar("r_mbRadialOverridePositionActive", 0);
}

_id_DC37() {
  scripts\sp\utility::_id_9187("heistHighlightRaines", 1000, ::_id_DC38);
  level._id_12B4F thread scripts\sp\utility::_id_918B("ar_callouts_admiral_raines", 1, (1250, 0, 1250));
  wait 0.25;
  scripts\sp\utility::_id_9199("heistHighlightRaines", 1);
  level._id_12B4F scripts\sp\utility::_id_9196(1, 0, 1, "heistHighlightRaines");
  wait 0.2;
  level._id_12B4F scripts\sp\utility::_id_9193("heistHighlightRaines");
  wait 0.2;
  level._id_12B4F scripts\sp\utility::_id_9196(1, 0, 1, "heistHighlightRaines");
  wait 0.2;
  level._id_12B4F scripts\sp\utility::_id_9193("heistHighlightRaines");
  wait 0.2;
  level._id_12B4F scripts\sp\utility::_id_9196(1, 0, 1, "heistHighlightRaines");
  wait 0.2;
  level._id_12B4F scripts\sp\utility::_id_9193("heistHighlightRaines");
  scripts\sp\utility::_id_9199("heistHighlightRaines", 0);
  level waittill("raines_ar_callout_remove");
  level._id_12B4F thread scripts\sp\utility::_id_918C();
}

_id_DC38() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 1;
  var_0["r_hudoutlineFillColor0"] = "1 1 1 0.8";
  var_0["r_hudoutlineFillColor1"] = "1 1 1 0.4";
  var_0["r_hudoutlineOccludedOutlineColor"] = "1 1 1 1";
  var_0["r_hudoutlineOccludedInlineColor"] = "1 1 1 0.8";
  var_0["r_hudoutlineOccludedInteriorColor"] = "1 1 1 0.4";
  var_0["r_hudOutlineOccludedColorFromFill"] = 0;
  return var_0;
}

_id_119F7() {
  level._id_10232 = getEntArray("skelter_spawner", "targetname");
  level._id_10233 = 0;

  foreach(var_1 in level._id_10232) {
    var_1._id_9BE9 = 1;
  }

  level waittill("small_shake");
  level.player playSound("scn_heist_mons_arrive");
  level waittill("start_shake");

  if(level._id_10CDA != "jackal_arrives") {
    thread _id_BA49();
  }

  level._id_F058 = scripts\sp\utility::_id_7C9B("skelter_path");
  level._id_F055 = 0;
  level._id_B7E2 = ["amb_missile_l_1", "amb_missile_l_2", "amb_missile_r_1", "amb_missile_r_2"];
  level waittill("start_mons");
  thread _id_F023();
  level waittill("sdf_ships_arrive");
  waitfortransient("heist_cap_ships_tr");
  thread _id_F022();
  thread _id_F021();
}

_id_7694() {
  level notify("top_of_church_garbage_collect");
  level notify("retribution_light_off");

  if(isDefined(level._id_E3F6)) {
    scripts\sp\utility::_id_228A(level._id_E3F6._id_6A21);
    level._id_E3F6 delete();
  }

  if(isDefined(level._id_7695)) {
    foreach(var_1 in level._id_7695) {
      if(isDefined(var_1) && isent(var_1)) {
        if(isDefined(var_1._id_CB53)) {
          foreach(var_3 in var_1._id_CB53) {
            var_3 delete();
          }
        }

        var_1 _id_0BA9::_id_397B();
      }
    }
  }

  if(isDefined(level._id_7696)) {
    foreach(var_1 in level._id_7696) {
      if(isDefined(var_1) && isent(var_1)) {
        var_1 delete();
      }
    }
  }

  if(isDefined(level._id_1678)) {
    foreach(var_9 in level._id_1678) {
      if(isDefined(var_9)) {
        var_9 delete();
      }
    }
  }

  thread _id_3F8C();
  level._id_12B4E = getEnt("un_building_model", "targetname");
  level._id_12B4F = getEnt("un_building_tower_model", "targetname");

  if(isDefined(level._id_12B4E)) {
    level._id_12B4E delete();
  }

  if(isDefined(level._id_12B4F)) {
    level._id_12B4F delete();
  }

  var_11 = getEntArray("atis_guns", "targetname");

  if(isDefined(var_11)) {
    foreach(var_13 in var_11) {
      var_13 delete();
    }
  }

  var_15 = getEntArray("heist_atis_tower", "targetname");

  if(isDefined(var_15)) {
    foreach(var_3 in var_15) {
      var_3 delete();
    }
  }

  if(isDefined(level._id_6EF0)) {
    foreach(var_19 in level._id_6EF0) {
      stopFXOnTag(level._effect["vfx_heist_cloud_bg"], var_19, "tag_origin");
      var_19 delete();
    }
  }

  thread scripts\sp\utility::_id_10FEC("powersurge1");
}

_id_3B4B() {
  _id_7694();
  thread scripts\sp\maps\heist\heist::_id_F04F();
  scripts\sp\utility::_id_228A(getEntArray("disabled", "targetname"));
}

_id_6EEF() {
  level._id_6EF0 = [];

  foreach(var_1 in level._id_F05A) {
    var_2 = getvehiclenode(var_1.target, "targetname");
    var_3 = getvehiclenode(var_2.target, "targetname");
    var_1._id_42B2 = vectortoangles(var_3.origin - var_2.origin);
    var_1._id_42BC = var_2 _id_36FF((12000, 0, 0), var_1._id_42B2);
    var_4 = scripts\engine\utility::spawn_tag_origin(var_1._id_42BC, var_1._id_42B2);

    if(var_1 != level._id_BAE8 && var_2.origin[1] > 45000) {
      playFXOnTag(level._effect["vfx_heist_cloud_bg"], var_4, "tag_origin");
    }

    level._id_6EF0 = scripts\engine\utility::array_add(level._id_6EF0, var_4);
  }
}

_id_36FF(var_0, var_1) {
  if(!isDefined(var_1) && isDefined(self.angles)) {
    var_1 = self.angles;
  }

  var_2 = anglesToForward(var_1) * var_0[0];
  var_3 = anglestoright(var_1) * var_0[1];
  var_4 = anglestoup(var_1) * var_0[2];
  var_5 = self.origin + var_2 + var_3 + var_4;
  return var_5;
}

_id_F022() {
  foreach(var_1 in level._id_F05B) {
    thread _id_119F9(var_1, 1);
    wait(randomfloatrange(0.5, 1.0));
  }
}

_id_F021() {
  foreach(var_1 in level._id_F05C) {
    thread _id_119F9(var_1, 0);
    wait(randomfloatrange(0.5, 1.0));
  }
}

_id_F01F() {
  var_0 = getEntArray("clear_on_fly", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2 scripts\sp\vehicle::_id_9FEF()) {
      var_2 _id_0BA9::_id_397B();
    }
  }

  var_4 = scripts\engine\utility::getStruct("sdf_boom_point", "targetname");
  var_5 = scripts\sp\utility::_id_7D40("sdf_go_boom", "script_noteworthy");

  if(isDefined(var_5)) {
    var_5 vehicle_setspeedimmediate(0, 1000, 1000);
    var_5 vehicle_teleport(var_4.origin, var_4.angles);
  }

  foreach(var_7 in level._id_7696) {
    if(isDefined(var_7) && isalive(var_7)) {
      var_7 delete();
    }
  }

  wait 0.05;
  level._id_F055 = 0;
  level waittill("player_launched");
  scripts\engine\utility::delaythread(0.5, ::_id_F017, var_5);
  scripts\engine\utility::delaythread(0.75, ::_id_F017, var_5);
  scripts\engine\utility::delaythread(1.0, ::_id_F017, var_5);
  scripts\engine\utility::delaythread(0.5, ::_id_F01C, var_5);
  scripts\engine\utility::delaythread(1.0, ::_id_F01C, var_5);
}

_id_F020() {
  level notify("ret_shockwave");
  var_0 = [];
  var_0 = getEntArray("sdf_go_boom", "script_noteworthy");

  if(var_0.size > 0) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2._id_9B82)) {
        var_3 = var_2 _id_0BA9::_id_39AA(var_2.origin, 1, 0);
        level._id_7695 = scripts\engine\utility::array_add(level._id_7695, var_3);
        wait 0.05;

        if(isDefined(var_3._id_CB53)) {
          foreach(var_5 in var_3._id_CB53) {
            var_5 notsolid();
            var_5 dontcastshadows();
          }
        }
      }
    }
  }
}

_id_119F9(var_0, var_1) {
  level endon("top_of_church_garbage_collect");
  level endon("ret_shockwave");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");

  if(isDefined(var_0._id_ED75)) {
    wait(var_0._id_ED75);
  }

  var_2 = scripts\sp\maps\heist\heist::_id_F045(var_0);
  var_2 endon("death");
  var_2 _id_0BB8::_id_39BB();
  var_2 _id_0BB8::_id_3980();
  var_2 thread _id_0BB8::_id_39D0("idle");
  var_2 thread _id_0BB8::_id_39CD("heavy");
  level._id_7695 = scripts\engine\utility::array_add(level._id_7695, var_2);
  playFX(level._effect["vfx_heist_cloud_bg_flash"], var_0._id_42BC, anglesToForward(var_0._id_42B2), anglestoup(var_0._id_42B2));

  if(var_1) {
    thread _id_F016(var_2);
    var_2.team = "axis";
    var_2 _id_0BB6::_id_39E1();
    var_2._id_B80E = (0, 0, -1000);

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "sdf_destroyer_closeup") {
      var_2._id_EEF9 = "cannon_missile_ca_hardpoint cannon_small_ca,3,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7 cannon_flak_ca,3,1 cannon_phalanx";
    } else {
      var_2._id_EEF9 = "missile_tube_ca cannon_large_un,1,1,amb_turret_lu_1,amb_turret_lu_2,amb_turret_ru_1,amb_turret_ru_2";
      thread _id_F015(var_2);
    }

    var_2 _id_0BB6::_id_39E8();
  } else {
    thread _id_F016(var_2);
    thread _id_F018(var_2);
    var_2 thread _id_F04A();
  }

  if(!var_1) {
    var_2 playLoopSound("ajak_engine_high");
  }

  var_3 = undefined;
  var_3 = getvehiclenode(var_2.target, "targetname");

  if(var_1) {
    var_2 scripts\sp\vehicle::_id_2471(var_3);
    var_2 waittill("reached_end_node");
  } else {
    for(;;) {
      var_2 scripts\sp\vehicle::_id_2471(var_3);
      var_2 waittill("reached_end_node");
      wait(randomfloatrange(1.5, 3.0));
    }
  }
}

_id_F016(var_0) {
  var_0 endon("death");
  level endon("ret_shockwave");
  var_0._id_B81F = 0;

  for(;;) {
    var_0 waittill("noteworthy", var_1);
    var_2 = strtok(var_1, " ");

    if(scripts\engine\utility::array_contains(var_2, "action_skelter")) {
      thread _id_F01C(var_0);
    }

    if(scripts\engine\utility::array_contains(var_2, "action_missile")) {
      thread _id_F017(var_0);
    }

    if(scripts\engine\utility::array_contains(var_2, "action_missile_off")) {
      var_0._id_B81F = 1;
    }

    wait 0.05;
  }
}

_id_F01C(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  level endon("ret_shockwave");
  var_1 = randomintrange(4, 8);
  var_2 = 0;

  while(var_2 < var_1 && level._id_F055 < 20) {
    level._id_F055++;
    var_2++;
    var_3 = _id_F01D();
    var_4 = level._id_10232[var_3];
    var_5 = undefined;
    var_5 = var_4 _id_F01E();
    var_5 endon("death");
    var_5 notsolid();
    var_5 dontcastshadows();
    var_5 hide();
    level._id_7696 = scripts\engine\utility::array_add(level._id_7696, var_5);

    if(!isDefined(var_5)) {
      continue;
    }
    var_6 = var_0 _id_F057();

    if(!isDefined(var_6)) {
      var_6 = scripts\engine\utility::random(level._id_F058);
    }

    var_7 = getcsplinepointposition(var_6, 0);
    var_8 = vectordot(anglesToForward(var_0.angles), var_7 - var_0.origin);

    if(var_8 >= 0) {
      var_9 = anglestoleft(var_0.angles);
    } else {
      var_9 = anglestoright(var_0.angles);
    }

    var_5 dontinterpolate();
    var_5 vehicle_teleport(var_0.origin, var_9);
    var_5 scripts\engine\utility::delaycall(1, ::show);
    var_5 thread _id_0BDC::_id_A1EF(var_6, randomintrange(600, 651));
    var_5 thread _id_0C1A::_id_11130(1);
    var_5 thread _id_F056();
    var_5 thread _id_F059();
    wait(randomfloatrange(0.5, 0.8));
  }
}

_id_F01D() {
  if(level._id_10233 < level._id_10232.size - 1) {
    level._id_10233++;
  } else {
    level._id_10233 = 0;
  }

  return level._id_10233;
}

_id_F01E() {
  while(!self._id_9BE9) {
    scripts\engine\utility::waitframe();
    waittillframeend;
  }

  self._id_9BE9 = 0;
  var_0 = scripts\sp\utility::_id_10808();
  waittillframeend;
  self._id_9BE9 = 1;
  return var_0;
}

_id_F057() {
  self endon("death");
  var_0 = undefined;

  while(!isDefined(var_0)) {
    var_1 = scripts\engine\utility::random(level._id_F058);
    var_2 = getcsplinepointposition(var_1, 0);

    if(var_2[2] <= self.origin[2]) {
      var_0 = var_1;
    }

    wait 0.05;
  }

  return var_0;
}

_id_F056() {
  self endon("death");
  self waittill("end_spline");
  level._id_F055--;
  self delete();
}

_id_F059() {
  self endon("death");
  level waittill("ret_shockwave");
  wait(randomfloatrange(0.1, 0.6));
  level._id_F055--;
  playFX(level._effect["fighter_spaceship_explosion_cheap"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  self delete();
}

_id_F017(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 thread _id_F01B();
}

_id_F01B() {
  self endon("death");
  level endon("ret_shockwave");
  var_0 = 0;

  while(var_0 < 2) {
    var_0++;
    var_1 = randomintrange(1, 3);

    if(!isDefined(level._id_3F86)) {
      wait 0.5;
      continue;
    }

    var_2 = scripts\engine\utility::getclosest(self.origin, level._id_3F86);

    for(var_3 = 1; var_3 <= var_1; var_3++) {
      var_4 = spawnStruct();
      var_4.origin = scripts\sp\maps\heist\heist_util::_id_E45E(var_2.origin, 5000);

      if(_id_BA97(var_4.origin)) {
        break;
      }

      thread _id_0B0F::_id_3986(var_4, "capship_missile_trail", "capship_missile_impact");
      wait(randomfloatrange(0.4, 0.8));
    }

    wait(randomfloatrange(3.0, 5.1));
  }
}

_id_F015(var_0) {
  var_0 endon("death");
  level endon("ret_shockwave");
  wait 5.0;

  for(;;) {
    var_1 = var_0.origin[2];
    var_2 = var_0.origin - (0, 0, var_1);

    if(!isDefined(level._id_3F86)) {
      wait 0.5;
      continue;
    }

    var_3 = scripts\engine\utility::get_array_of_closest(var_2, level._id_3F86, undefined, 4, 30000);

    foreach(var_5 in var_3) {
      var_6 = randomintrange(2, 5);
      var_7 = randomfloatrange(0.2, 0.6);
      var_8 = var_5 scripts\engine\utility::spawn_tag_origin();

      if(var_0 _id_BA97(var_8.origin)) {
        break;
      }

      for(var_9 = 1; var_9 <= var_6; var_9++) {
        var_0 _id_0BB6::_id_3984(var_8);
        wait(var_7);
      }

      var_8 delete();
      wait(randomfloatrange(1.5, 3.1));
    }

    wait(randomfloatrange(1.5, 4.1));
  }
}

_id_F018(var_0) {
  var_0 endon("death");
  wait 2.0;

  for(;;) {
    var_1 = var_0 _id_F01A(level._id_3F86, 4, 40000);

    if(!isDefined(var_1)) {
      wait 1;
      continue;
    }

    foreach(var_3 in var_1) {
      var_4 = randomintrange(0, 3);
      var_5 = randomfloatrange(0.2, 0.6);
      var_6 = spawnStruct();

      for(var_7 = 0; var_7 <= var_4; var_7++) {
        var_6.origin = scripts\sp\maps\heist\heist_util::_id_E45E(var_3.origin, 5000);

        if(var_0 _id_BA97(var_6.origin)) {
          break;
        }

        var_0 _id_F019(var_6, level._id_B7E2[var_7], "capship_missile_trail", ["capship_missile_impact", "capship_missile_impact", 5]);
        wait(var_5);
      }

      wait(randomfloatrange(1.5, 3.1));
    }

    wait(randomfloatrange(1.5, 4.1));
  }
}

_id_F019(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  var_4 = (0, 0, 0);
  var_5 = _id_0B76::_id_A26D(0.1, 0.15, 25, 0.2, 0.3, 25);
  var_6 = 400;
  var_7 = 1.5;
  var_8 = self gettagangles(var_1);
  var_8 = invertangles(var_8);
  var_9 = scripts\engine\utility::spawn_tag_origin();
  var_9.origin = self gettagorigin(var_1) + (0, 0, -700);
  var_9.angles = var_8;
  var_9._id_AA99 = "capitalship_missile_launch";
  var_9._id_69E9 = "capitalship_missile_impact";
  var_9._id_BFEC = 0;
  var_9 thread _id_0B76::_id_A332(var_0, 1, self, var_2, var_6, undefined, 0, var_3, 500, 1, var_7, 0, var_4, var_5, 500);
}

_id_F01A(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_3 = scripts\engine\utility::flat_origin(self.origin);

  if(!isDefined(var_1)) {
    var_1 = var_0.size;
  }

  var_4 = undefined;

  if(isDefined(var_2)) {
    var_4 = var_2 * var_2;
  }

  var_5 = 0;

  if(var_1 >= var_0.size && var_5 == 0 && !isDefined(var_4)) {
    return sortbydistance(var_0, var_3);
  }

  var_6 = [];

  foreach(var_8 in var_0) {
    var_9 = distancesquared(var_3, var_8.origin);

    if(isDefined(var_4) && var_9 > var_4) {
      continue;
    }
    if(var_9 < var_5) {
      continue;
    }
    if(!scripts\sp\maps\heist\heist_util::_id_9E47(var_8)) {
      continue;
    }
    var_6[var_6.size] = var_8;
  }

  var_6 = sortbydistance(var_6, var_3);

  if(var_1 >= var_6.size) {
    return var_6;
  }

  var_11 = [];

  for(var_12 = 0; var_12 < var_1; var_12++) {
    var_11[var_12] = var_6[var_12];
  }

  return var_11;
}

_id_F04A() {
  self endon("death");
  level waittill("ret_shockwave");
  wait(randomfloatrange(0.1, 0.6));
  _id_0BB2::_id_B850();
}

_id_BA97(var_0) {
  var_1 = scripts\common\trace::create_all_contents();
  var_2 = scripts\common\trace::ray_trace(self.origin, var_0, undefined, var_1);

  if(isDefined(var_2["entity"]) && isDefined(var_2["entity"].targetname) && var_2["entity"].targetname == "fake_mons_collision") {
    return 1;
  }

  return 0;
}

_id_F023() {
  var_0 = scripts\engine\utility::getStruct("mons_entrance_ref", "targetname");
  var_1 = getvehiclenode("mons_skybox_path3c", "targetname");
  level._id_BAE8 dontinterpolate();

  if(isDefined(level._id_10CDA) && level._id_10CDA == "jackal_arrives") {
    return;
  }
  level._id_BAE8 endon("death");
  level._id_BAE8._id_72DB = 1;
  level._id_BAE8 thread _id_0BB8::_id_39D0("idle");
  level._id_BAE8 thread _id_0BB8::_id_39CD("heavy");
  level._id_BAE8 show();
  level._id_BAE8 thread _id_0BB4::_id_10770();
  var_0 scripts\sp\anim::_id_1F35(level._id_BAE8, "mons_entrance");
  level._id_BAE8 vehicle_setspeedimmediate(0, 1000, 1000);
  var_0 scripts\sp\anim::_id_1EE0(level._id_BAE8, "mons_entrance");
}

_id_BA49() {
  level._id_BAE8 notify("kill_rumble_forever");
  playFX(scripts\engine\utility::getfx("vfx_heist_mons_dust_kickup"), (-4467, -14410, 696));
  level.player _meth_8244("steady_rumble");
  var_0 = 14;
  var_1 = 0.5;
  var_2 = 0.25;
  var_3 = 0.25;

  for(var_4 = 0; var_4 < var_0; var_4 = var_4 + 0.05) {
    var_5 = scripts\sp\math::_id_6A8E(0, var_1, scripts\sp\math::_id_C097(0, var_0, exp(var_4)));
    var_6 = 0;
    var_7 = 0;

    if(var_4 > 0) {
      var_6 = randomfloatrange(var_5 * 0.25, var_5 * 0.5);
      var_7 = randomfloatrange(var_5 * 0.25, var_5 * 0.5);
    }

    level.player _meth_8291(var_5, var_6, var_7, 0.05, 0, 0, 0, 30, 15, 15);
    scripts\engine\utility::waitframe();
  }

  level.player stoprumble("steady_rumble");
  level.player _meth_8291(var_1, var_2, var_3, 5, 0, -3, 0, 30, 15, 15);
}

_id_3F89() {
  level._id_12B4E = getEnt("un_building_model", "targetname");
  level._id_12B4F = getEnt("un_building_tower_model", "targetname");
  level._id_3F86 = getEntArray("city_destruction_damage_trigger", "targetname");
  level._id_528A = [];
  level._id_528B = [];
  scripts\engine\utility::array_thread(level._id_3F86, ::_id_3F8D);
  level waittill("sdf_ships_arrive");
  wait 2;
  thread _id_3F8B();
}

_id_3F8B() {
  level endon("top_of_church_garbage_collect");
  level._id_528A = sortbydistance(level._id_528A, (0, 124000, 0));
  var_0 = 8;
  var_1 = int(level._id_528A.size / var_0);
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0; var_3++) {
    for(var_4 = 0; var_4 < var_1; var_4++) {
      level._id_528A[var_2].trigger scripts\engine\utility::delaythread(randomfloatrange(0, 5), scripts\sp\utility::_id_F225, "trigger");
      var_2++;
    }

    wait 1;
  }
}

_id_3F8D() {
  level endon("top_of_church_garbage_collect");
  var_0 = [];

  if(isDefined(self.target)) {
    var_0 = scripts\engine\utility::get_target_array();
  }

  if(var_0.size == 0) {
    return;
  }
  foreach(var_2 in var_0) {
    if(getdvarint("debug_fleet")) {
      thread _id_D8F3();
    }

    var_2 dontcastshadows();
    var_2.trigger = self;

    if(var_2 == level._id_12B4E || var_2 == level._id_12B4F) {
      continue;
    }
    level._id_528A[level._id_528A.size] = var_2;
  }

  self._id_385E = 1;
  level._id_3F88 = [level._effect["vfx_heist_explosion_01"]];

  while(self._id_385E) {
    self waittill("trigger");
    self._id_385E = 0;

    foreach(var_2 in var_0) {
      thread _id_3F8A(var_2);
      wait(randomfloatrange(0.5, 1.5));
    }
  }
}

_id_D8F3() {
  self endon("death");
  var_0 = ".";

  if(isDefined(self._id_6A0B)) {
    var_0 = self._id_6A0B;
  }

  for(;;) {
    wait 0.1;
  }
}

_id_3F8A(var_0) {
  var_0 endon("death");
  var_1 = var_0.script_parameters;
  var_2 = [];

  if(isDefined(var_0.target)) {
    var_2 = var_0 scripts\engine\utility::get_target_array();
  }

  if(var_2.size > 0) {
    foreach(var_4 in var_2) {
      playFX(scripts\engine\utility::random(level._id_3F88), var_4.origin, anglesToForward(var_4.angles), anglestoup(var_4.angles));
      wait(randomfloatrange(0.25, 0.5));
    }
  }

  wait 0.5;
  playFX(level._effect["vfx_heist_building_explosion_lrg"], var_0 _meth_810C(), anglesToForward(var_0.angles), anglestoup(var_0.angles));

  if(isDefined(var_0._id_ED75)) {
    wait 1.5;
    var_6 = (0, 0, var_0._id_ED75);
    playFX(level._effect["vfx_heist_building_explosion_sml"], var_0 _meth_810C() + var_6, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  }

  wait 1.5;
  var_0 setModel(var_1);

  if(isDefined(var_0.script_noteworthy)) {
    var_0._id_1FBB = var_0.model;
    var_0 scripts\sp\utility::_id_23B7();
    var_0 thread scripts\sp\anim::_id_1F35(var_0, "collapse");
    var_0 notsolid();
  }
}

_id_3F8C() {
  if(!isDefined(level._id_3F86)) {
    level._id_3F86 = getEntArray("city_destruction_damage_trigger", "targetname");
  }

  foreach(var_1 in level._id_3F86) {
    var_2 = [];

    if(isDefined(var_1.target)) {
      var_2 = var_1 scripts\engine\utility::get_target_array();
    }

    if(var_2.size == 0) {
      continue;
    }
    foreach(var_4 in var_2) {
      var_4 delete();
    }
  }
}