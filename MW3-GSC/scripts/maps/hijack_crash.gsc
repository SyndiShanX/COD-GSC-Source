/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_crash.gsc
*****************************************/

_id_5A15() {
  level.player giveweapon("fnfiveseven");
  level.player switchtoweapon("fnfiveseven");
  maps\_compass::setupminimap("compass_map_dcemp_static", "crash_minimap_corner");
  setsaveddvar("compassmaxrange", 50000);
  common_scripts\utility::flag_set("show_crash_model");
  level._id_58C4 = getent("intro_door3", "targetname");
  level._id_58C4 movey(50, 0.1);
  level._id_58D2 = maps\hijack_code::_id_594A("commander");
  level._id_58BA = maps\hijack_code::_id_594A("president");
  level._id_58CB = maps\hijack_code::_id_594A("hero_agent_01");
  level._id_58C6 = maps\hijack_code::_id_594A("advisor", "end_scene_advisor");
  level._id_59E0 = maps\_utility::_id_272F("find_daughter_pre_crash");
  level._id_58CB maps\_utility::_id_123B();
  level._id_58D2 maps\_utility::_id_13A4("c");
  level._id_58D2 maps\_utility::_id_2686();
  level._id_5A16 = common_scripts\utility::getstruct("cargo_room_anim_struct", "targetname");
  var_0 = [];
  var_0[0] = level._id_58BA;
  var_0[1] = level._id_59E0;
  level._id_5A16 thread maps\_anim::_id_11D6(var_0, "post_find_loop");
  common_scripts\utility::flag_set("find_daughter_moment_finished");
  maps\_audio::aud_send_msg("cargo_room_zone_off");
  level._id_5A16 thread maps\_anim::_id_124E(level._id_58D2, "find_daughter_commander_loop");
  var_1 = common_scripts\utility::getstruct("player_start_crash", "targetname");
  level.player setorigin(var_1.origin);
  level.player setplayerangles(var_1.angles);
  level.player giveweapon("fnfiveseven");
  level.player switchtoweapon("fnfiveseven");
  var_2 = getnode("hero_agent_crash_node", "targetname");
  level._id_58CB maps\_utility::_id_27A1(var_2);
  level._id_58CB setgoalnode(var_2);
  thread _id_5A20();
  thread maps\hijack_crash_fx::_id_5980();
  thread maps\hijack_crash_fx::_id_597F();
  thread _id_5A1E();
  thread _id_5A1A();
  thread maps\hijack::_id_5A17();
  thread _id_5A19();
  main();
  level waittill("crash_teleport");
  level._id_5A16 notify("stop_loop");
}

_id_5A18() {
  common_scripts\utility::flag_init("stop_managing_crash_player");
  common_scripts\utility::flag_init("crash_throw_player");
  common_scripts\utility::flag_init("hero_agent_ready_for_crash");
  common_scripts\utility::flag_init("commander_finished_wake_up_anim");
  common_scripts\utility::flag_init("stop_sun_crash_lerp");
  common_scripts\utility::flag_init("tower_is_down");
}

_id_5A19() {
  objective_add(maps\_utility::_id_2816("escape_pod"), "current", &"HIJACK_OBJ_ESCAPE_HATCH", level._id_58CB.origin);
  objective_onentity(maps\_utility::_id_2816("escape_pod"), level._id_58CB, (0, 0, 70));
  level waittill("crash_teleport");
  objective_state(maps\_utility::_id_2816("escape_pod"), "failed");
}

_id_5A1A() {
  maps\_audio::aud_send_msg("approaching_ground");
  thread maps\_utility::_id_1425("pre_crash");
  thread maps\hijack_code::_id_5953();
  thread maps\hijack_airplane::_id_5A1B();
  common_scripts\utility::flag_wait("player_is_in_crash_room");
  thread _id_5A5A();
  common_scripts\utility::flag_wait("player_is_in_end_room");
}

_id_5A1C() {
  level._id_58D2 endon("start_crash_anim");
  level._id_5A16 notify("stop_loop");
  level._id_58D2 stopanimscripted();
  var_0 = common_scripts\utility::getstruct("cargo_room_anim_struct", "targetname");
  var_0 maps\_anim::_id_124A(level._id_58D2, "door1");
  var_0 maps\_anim::_id_1246(level._id_58D2, "door1");
  level._id_58D2 thread maps\_anim::_id_124E(level._id_58D2, "corner_standL_alert_twitch04", "stop_door_loop");
}

_id_5A1D() {
  var_0 = getent("crash_door_blocker_2", "targetname");
  var_0 notsolid();
  common_scripts\utility::flag_wait_any("start_plane_crash_aisle_1", "start_plane_crash_aisle_2");
  var_0 solid();
}

#using_animtree("animated_props");

_id_5A1E() {
  foreach(var_1 in level._id_5976) {
    var_1._id_1032 = "generic";
    var_1 useanimtree(#animtree);
  }

  var_3 = getent("hijack_crash_model_props", "script_noteworthy");
  var_3 thread maps\_anim::_id_124E(var_3, "hijack_pre_plane_crash_compartments", "stop loop");
  var_4 = getent("hijack_crash_model_front_interior", "script_noteworthy");
  maps\_audio::aud_send_msg("pre_crash_door");
  var_4 maps\_anim::_id_1246(var_4, "hijack_pre_plane_crash_door");
  var_5 = getent("crash_door_blocker", "targetname");
  var_5 notsolid();
  thread _id_5A1D();
  common_scripts\utility::flag_wait("player_is_in_crash_room");
  var_5 solid();
  var_4 maps\_anim::_id_1246(var_4, "hijack_pre_plane_crash_door_close");
}

_id_5A1F() {
  thread main();
}

_id_5A20() {
  level._id_5960 = getent("org_view_roll", "targetname");
  level.player playersetgroundreferenceent(level._id_5960);
  level._id_5961 = [];
  level._id_5961 = maps\_utility::_id_0BC3(level._id_5961, level._id_5960);
  thread maps\hijack_code::_id_5953();
  common_scripts\utility::array_thread(level._id_5961, maps\hijack_code::_id_5958, -10, 1, 0, 0);
  wait 1;
  common_scripts\utility::array_thread(level._id_5961, maps\hijack_code::_id_5958, 20, 1.5, 0, 0);
  wait 1.5;
  common_scripts\utility::array_thread(level._id_5961, maps\hijack_code::_id_5958, -10, 1, 0, 0);
  level waittill("planecrash_approaching");
}

main() {
  thread _id_5A46();
  thread maps\hijack_crash_fx::_id_5974();
  level._id_58CB _id_5A2A(level._id_5976[0]);
  common_scripts\utility::flag_wait_any("start_plane_crash_aisle_1", "start_plane_crash_aisle_2");
  thread maps\hijack_airplane::_id_5A21();
  level._id_5A22 = 0;
  var_0 = "tag_player1_rotate";
  var_1 = common_scripts\utility::getstruct("struct_aisle2_front", "targetname");
  var_2 = common_scripts\utility::getstruct("struct_aisle2_back", "targetname");
  var_3 = common_scripts\utility::getstruct("struct_aisle2_left", "targetname");
  var_4 = common_scripts\utility::getstruct("struct_aisle2_right", "targetname");

  if(common_scripts\utility::flag("start_plane_crash_aisle_1")) {
    level._id_5A22 = 1;
  }
  maps\_utility::delaythread(0.75, ::_id_5A2D, 0.05);
  var_5 = level._id_5976;
  var_6 = 0;

  foreach(var_8 in var_5) {
    level._id_5976[var_6] = spawn("script_model", (0, 0, 0));
    level._id_5976[var_6] setModel(var_5[var_6].model);
    level._id_5976[var_6]._id_1032 = "generic";
    level._id_5976[var_6] useanimtree(#animtree);

    if(isDefined(var_8.script_noteworthy)) {
      level._id_5976[var_6].script_noteworthy = var_8.script_noteworthy + "_new";
    }
    var_6++;
  }

  var_5[0] useanimtree(#animtree);
  var_5[0]._id_1032 = "generic";
  _id_5A2F(level._id_5976);
  var_10 = common_scripts\utility::spawn_tag_origin();
  var_0 = "tag_player1_rotate";

  if(!level._id_5A22) {}

  _id_5A25(var_5[0], var_0);
  var_10 linkto(level._id_5976[0], var_0, (0, 0, 0), (0, 0, 0));
  level._id_5A23 = var_10;
  level.player playersetgroundreferenceent(var_10);
  level._id_5A24 = var_0;
  level notify("planecrash_approaching");
  level notify("crash_lights_out");
  _id_5A2B();
  level._id_58CB.ignoreall = 1;
  thread _id_5A4A();
  earthquake(0.3, 1.2, level.player.origin, 200000);
  thread _id_5A2D(0.05);
  common_scripts\utility::flag_clear("in_flight");
  wait 0.05;
  var_11 = (var_1.origin[0] - level.player.origin[0]) / (var_1.origin[0] - var_2.origin[0]);
  var_11 = clamp(var_11, 0.0, 1.0);
  var_12 = (var_3.origin[1] - level.player.origin[1]) / (var_3.origin[1] - var_4.origin[1]);
  var_12 = clamp(var_12, 0.0, 1.0);
  _id_5A43(var_5[1], level._id_5976[1]);
  maps\_compass::setupminimap("compass_map_dcemp_static", "crash_minimap_corner");
  setsaveddvar("compassmaxrange", 50000);
  level.player playrumblelooponentity("hijack_plane_medium");
  level._id_58CB thread _id_5A44();
  level._id_58D2 thread _id_5A45();
  level notify("crash_teleport");
  thread _id_5A30(level._id_5976);
  thread _id_5A36(level._id_5976[0], var_11, var_12, level._id_5A22);
  thread _id_5A53(level._id_5976[0]);
  common_scripts\utility::flag_wait("stop_managing_crash_player");
  _id_5A35();
}

_id_5A25(var_0, var_1) {
  var_2 = % hijack_plane_crash_player_move_forward;
  var_3 = % hijack_plane_crash_player_move_right;
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4 linkto(var_0, var_1, (0, 0, 0), (0, 0, 0));
  var_0 setanim(var_2, 1, 0, 0);
  var_0 setanim(var_3, 1, 0, 0);
  waittillframeend;
  var_0 setanimtime(var_2, 1.0);
  waittillframeend;
  level._id_5A26 = var_0 gettagorigin(var_1);
  var_0 setanimtime(var_2, 0.0);
  waittillframeend;
  level._id_5A27 = var_0 gettagorigin(var_1);
  var_0 setanimtime(var_3, 1.0);
  waittillframeend;
  level._id_5A28 = var_0 gettagorigin(var_1);
  var_0 setanimtime(var_3, 0.0);
  waittillframeend;
  level._id_5A29 = var_0 gettagorigin(var_1);
}

_id_5A2A(var_0) {
  level._id_58CB._id_1032 = "generic";
  level._id_58CB._id_117F = 1;
  level._id_58CB._id_1199 = 1;
  var_0 maps\_anim::_id_124A(level._id_58CB, "planecrash_agent1", "tag_agent");
  common_scripts\utility::flag_set("hero_agent_ready_for_crash");
}

_id_5A2B() {}

_id_5A2C(var_0) {
  var_0 waittillmatch("single anim", "vo_line");
  maps\_utility::_id_11F4("hijack_plt_brace");
}

_id_5A2D(var_0) {
  maps\hijack_code::_id_09FA(var_0);
  maps\hijack_code::_id_17CC(0.05);
}

_id_5A2E() {
  for(;;) {
    var_0 = 0;
    wait 0.05;
  }
}

_id_5A2F(var_0) {
  var_1 = common_scripts\utility::getstruct("hijack_crash_align", "targetname");

  foreach(var_3 in var_0) {}
  var_3._id_1032 = "generic";

  var_1 maps\_anim::_id_11BF(var_0, "hijack_plane_crash_anim");
}

_id_5A30(var_0) {
  maps\_audio::aud_send_msg("crash_sequence");
  level notify("crash_anim_start");
  var_1 = common_scripts\utility::getstruct("hijack_crash_align", "targetname");
  level thread maps\_utility::_id_1424("luggage_falls_out", 15.5);
  var_1 thread _id_5A34();
  thread _id_5A2C(var_0[0]);
  thread _id_5A52(var_0[0]);
  maps\_audio::aud_send_msg("suitcase_prop_sound_impact", var_0[0]);
  var_2 = maps\_utility::_id_1287("crash_tower", (0, 0, 0));
  var_3 = maps\_utility::_id_1287("crash_tower_lights", (0, 0, 0));
  var_4[0] = var_2;
  var_4[1] = var_3;
  var_1 thread maps\_anim::_id_11DD(var_4, "hijack_plane_crash_anim");
  var_3 thread _id_5A31();
  thread _id_5A32(var_0[0]);
  var_5 = maps\_utility::_id_1287("crash_engine_1", (0, 0, 0));
  var_0 = maps\_utility::_id_0BC3(var_0, var_5);
  thread _id_5A33(var_5);
  var_1 maps\_anim::_id_11DD(var_0, "hijack_plane_crash_anim");
  level notify("crash_done");
  common_scripts\utility::flag_set("stop_managing_crash_player");
  waittillframeend;
  maps\_utility::_id_135B(level._id_5976);
}

_id_5A31() {
  level waittill("tail_hits_tower");
  wait 0.3;
  thread maps\_utility::_id_25EE("tower_is_down", 2.0);
  self hide();
  wait 0.15;
  self show();

  for(var_0 = 1.0; !common_scripts\utility::flag("tower_is_down"); var_0 = var_0 * 0.8) {
    self hide();
    var_1 = randomfloatrange(0.1 * var_0, 0.2 * var_0);
    wait(var_1);
    self show();
    var_1 = randomfloatrange(0.1 * var_0, 0.5 * var_0);
    wait(var_1);
  }

  self delete();
}

_id_5A32(var_0) {
  level._id_5907 = common_scripts\utility::spawn_tag_origin();
  level._id_5907 linkto(var_0, "FX_R_Wing", (0, 0, 0), (0, 0, 0));
  level._id_5909 = common_scripts\utility::spawn_tag_origin();
  level._id_5909 linkto(var_0, "J_Break_Chunk", (0, 0, 0), (0, 0, 0));
  level waittill("crash_impact");
  wait 0.5;
  maps\_audio::aud_send_msg("crash_chunk_breaks_away");
  wait 1.0;
  maps\_audio::aud_send_msg("crash_explosion");
  common_scripts\utility::flag_wait("crash_throw_player");
  level._id_5907 delete();
  level._id_5909 delete();
}

_id_5A33(var_0) {
  var_0 waittillmatch("single anim", "engine_fire");
  var_0 setModel(level._id_1F90["crash_engine_2"]);
}

_id_5A34() {
  var_0 = maps\_utility::_id_1287("pine_tree_lg");
  var_1 = maps\_utility::_id_1287("pine_tree_lg");
  var_2 = maps\_utility::_id_1287("pine_tree_sm");
  var_3 = maps\_utility::_id_1287("pine_tree_sm");
  var_4 = maps\_utility::_id_1287("pine_tree_lg");
  var_5 = maps\_utility::_id_1287("pine_tree_sm");
  thread maps\_anim::_id_1246(var_0, "crash_tree_1");
  thread maps\_anim::_id_1246(var_1, "crash_tree_2");
  thread maps\_anim::_id_1246(var_2, "crash_tree_3");
  thread maps\_anim::_id_1246(var_3, "crash_tree_4");
  thread maps\_anim::_id_1246(var_4, "crash_tree_5");
  thread maps\_anim::_id_1246(var_5, "crash_tree_6");
  common_scripts\utility::flag_wait("crash_throw_player");
}

_id_5A35() {
  level notify("stop_rumbling");
  level._id_58D2 notify("stop_loop");
  level._id_58D2 stopanimscripted();
  thread maps\hijack_tarmac::_id_5A04();
  level.player setweaponammostock("fnfiveseven", 60);
  maps\hijack_tarmac::_id_599A();
}

_id_5A36(var_0, var_1, var_2, var_3) {
  thread _id_5A3E();
  var_4 = "tag_player1_rotate";
  var_5 = % hijack_plane_crash_player_move_forward;
  var_6 = % hijack_plane_crash_player_move_back;
  var_7 = % hijack_plane_crash_player_move_left;
  var_8 = % hijack_plane_crash_player_move_right;
  level._id_5A37 = [];
  level._id_5A37[0]["left"] = 0.3;
  level._id_5A37[0]["right"] = 0.4;
  level._id_5A37[0]["front"] = 1.0;
  level._id_5A37[0]["back"] = 0.45;
  level._id_5A37[1]["left"] = 0.7;
  level._id_5A37[1]["right"] = 0.79;
  level._id_5A37[1]["front"] = 1.0;
  level._id_5A37[1]["back"] = 0.3;
  level._id_5A38 = [];
  level._id_5A38[0]["back"] = 0.84;
  level._id_5A38[0]["front"] = 0.9;
  level._id_5A38[0]["left"] = 0.15;
  level._id_5A38[0]["right"] = 1.0;
  level._id_5A38[1]["back"] = 0.55;
  level._id_5A38[1]["front"] = 0.6;
  level._id_5A38[1]["left"] = 0.1;
  level._id_5A38[1]["right"] = 1.0;
  _id_5A3D(var_1, var_2);
  var_9 = var_5;
  var_10 = var_5;
  var_0 setanim(var_9, 1, 0, 0);
  var_0 setanimtime(var_9, var_1);
  var_11 = var_8;
  var_12 = var_8;
  var_0 setanim(var_11, 1, 0, 0);
  var_0 setanimtime(var_11, var_2);
  level.player playerlinktodelta(level._id_5A23, "tag_origin", 0.0, 180, 180, 70, 70, 1);
  var_13 = 0;
  var_14 = 0;
  var_15 = 0;
  var_16 = 1;
  level._id_5A39 = 0;
  level._id_5A3A = gettime();

  while(!common_scripts\utility::flag("stop_managing_crash_player")) {
    if(!common_scripts\utility::flag("crash_throw_player")) {
      if(!isalive(level.player)) {
        var_17 = (0, 0, 0);
      } else {
        var_17 = level.player getnormalizedmovement();
      }
      var_18 = distance((0, 0, 0), var_17);
      var_17 = (var_17[0], var_17[1] * -1, 0);
      var_19 = vectortoangles(var_17);
      var_20 = level.player getplayerangles();

      if(isDefined(level._id_5A23)) {
        var_20 = combineangles(level._id_5A23.angles, var_20);
      }
      var_21 = combineangles(var_20, var_19);
      var_22 = vectornormalize(anglesToForward(var_21));
      var_23 = var_0 gettagangles(var_4);
      var_24 = vectornormalize(anglesToForward(var_23));
      var_25 = vectornormalize(anglestoright(var_23));
      var_26 = vectordot(var_22, var_24);
      var_27 = var_18 * var_26;
      var_28 = vectordot(var_22, var_25);
      var_29 = var_18 * var_28;
      var_30 = var_0 getanimtime(var_9);
      var_31 = getanimlength(var_9);
      var_32 = var_30 / var_31;
      var_33 = var_0 getanimtime(var_11);
      var_34 = getanimlength(var_11);
      var_35 = var_33 / var_34;

      if(var_18 == 0 || var_27 == 0) {
        if(var_13) {
          var_0 setanim(var_9, 1, 0, 0);
        }
        if(var_14) {
          var_0 setanim(var_11, 1, 0, 0);
        }
        var_13 = 0;
        var_14 = 0;
        wait 0.05;
        continue;
      }

      var_36 = 1.0;
      var_37 = 1.0;
      var_38 = 1.0;
      var_39 = 0.0;

      if(var_27 <= 0) {
        var_10 = var_6;
      } else {
        var_10 = var_5;
      }
      var_40 = 1.0;
      var_41 = 1.0;
      var_42 = 1.0;
      var_43 = 1.0;

      if(level._id_5A3B != -1) {
        var_40 = 1.0 - level._id_5A37[level._id_5A3B]["back"];
        var_41 = level._id_5A37[level._id_5A3B]["front"];
      } else {
        var_40 = 1.0 - level._id_5A38[level._id_5A3C]["back"];
        var_41 = level._id_5A38[level._id_5A3C]["front"];
      }

      if(level._id_5A3C != -1) {
        var_42 = 1.0 - level._id_5A38[level._id_5A3C]["left"];
        var_43 = level._id_5A38[level._id_5A3C]["right"];
      } else {
        var_43 = level._id_5A37[level._id_5A3B]["right"];
        var_42 = 1.0 - level._id_5A37[level._id_5A3B]["left"];
      }

      if(var_10 == var_6) {
        var_44 = var_30 + 0.05 * (abs(var_27) * var_36 * 0.5 * var_16);

        if(var_44 > var_40) {
          var_36 = 0.0;
          var_30 = var_40;
          var_0 setanimtime(var_6, var_40);
        }
      }

      if(var_10 == var_5) {
        var_44 = var_30 + 0.05 * (abs(var_27) * var_36 * 0.5 * var_16);

        if(var_44 > var_41) {
          var_36 = 0.0;
          var_30 = var_41;
          var_0 setanimtime(var_6, var_41);
        }
      }

      if(var_12 == var_7) {
        var_45 = var_33 + 0.05 * (abs(var_29) * var_37 * 0.5 * var_16);

        if(var_45 > var_42) {
          var_37 = 0.0;
          var_33 = var_42;
          var_0 setanimtime(var_7, var_42);
        }
      }

      if(var_12 == var_8) {
        var_46 = var_33 + 0.05 * (abs(var_29) * var_37 * 0.5 * var_16);

        if(var_46 > var_43) {
          var_37 = 0.0;
          var_33 = var_43;
          var_0 setanimtime(var_8, var_43);
        }
      }

      if(var_9 != var_10) {
        var_0 clearanim(var_9, 0);
        var_32 = 1 - var_32;
        var_32 = clamp(var_32, var_39, var_38);
        var_0 setanim(var_10, 1, 0, abs(var_27) * var_36 * 0.5 * var_16);
        var_0 setanimtime(var_10, var_32);
        var_9 = var_10;
      } else {
        var_0 setanim(var_9, 1, 0, abs(var_27) * var_36 * 0.5 * var_16);
      }
      if(var_29 < 0) {
        var_12 = var_7;
      } else {
        var_12 = var_8;
      }
      if(var_11 != var_12) {
        var_0 clearanim(var_11, 0);
        var_35 = 1 - var_35;
        var_35 = clamp(var_35, 0.0, 1.0);
        var_0 setanim(var_12, 1, 0, abs(var_29) * var_37 * 0.5 * var_16);
        var_0 setanimtime(var_12, var_35);
        var_11 = var_12;
      } else {
        var_0 setanim(var_11, 1, 0, abs(var_29) * 0.5 * var_16);
      }
      var_13 = 1;
      var_14 = 1;

      if(var_27 < 0 && var_9 == var_6 && var_0 getanimtime(var_9) > 0.99) {
        level._id_5A39 = level._id_5A39 + (gettime() - level._id_5A3A);

        if(level._id_5A39 > 1000) {
          thread _id_5A49();
          return;
        }
      } else {
        var_47 = 0;
      }
      level._id_5A3A = gettime();
      wait 0.05;
      var_48 = var_0 getanimtime(var_9);

      if(var_9 == var_6) {
        var_48 = 1.0 - var_48;
      }
      var_49 = var_0 getanimtime(var_11);

      if(var_11 == var_7) {
        var_49 = 1.0 - var_49;
      }
      _id_5A3D(var_48, var_49);
      continue;
    }

    if(!var_15) {
      var_15 = 1;
      level.player freezecontrols(1);
      var_0 setanim(var_5, 1.0, 0, 3.0);
      var_0 setanim(var_6, 0.0, 0);
      var_50 = var_0 getanimtime(var_11);

      if(var_50 > 0.8) {
        var_0 setanimtime(var_11, 0.8);
      } else if(var_50 < 0.35) {
        var_0 setanimtime(var_11, 0.35);
      }
      var_0 setanim(var_11, 1.0, 0.0, 0.0);
      wait 0.85;
      level.player freezecontrols(0);
      var_16 = 0.6;
      common_scripts\utility::flag_clear("crash_throw_player");
      var_10 = var_5;
      var_9 = var_5;
      var_32 = 1.0;
    }

    wait 0.05;
  }
}

_id_5A3D(var_0, var_1) {
  level._id_5A3B = -1;
  var_2 = -1;
  var_3 = 1.0;

  for(var_4 = 0; var_4 < level._id_5A37.size; var_4++) {
    var_5 = abs(var_1 - 0.5 * (level._id_5A37[var_4]["left"] + level._id_5A37[var_4]["right"]));

    if(var_1 >= level._id_5A37[var_4]["left"] && var_1 <= level._id_5A37[var_4]["right"]) {
      level._id_5A3B = var_4;
      break;
    }

    if(var_5 < var_3) {
      var_3 = var_5;
      var_2 = var_4;
    }
  }

  level._id_5A3C = -1;
  var_6 = -1;
  var_7 = 1.0;

  for(var_4 = 0; var_4 < level._id_5A38.size; var_4++) {
    var_5 = abs(var_0 - 0.5 * (level._id_5A38[var_4]["back"] + level._id_5A38[var_4]["front"]));

    if(var_0 >= level._id_5A38[var_4]["back"] && var_0 <= level._id_5A38[var_4]["front"]) {
      level._id_5A3C = var_4;
      break;
    }

    if(var_5 < var_7) {
      var_7 = var_5;
      var_6 = var_4;
    }
  }

  if(level._id_5A3B == -1 && level._id_5A3C == -1) {
    if(var_7 < var_3) {
      level._id_5A3C = var_6;
    } else {
      level._id_5A3B = var_2;
    }
  }
}

_id_5A3E() {
  thread _id_5A3F();
  thread _id_5A40();
}

_id_5A3F() {
  level waittill("luggage_falls_out");
  level._id_5A37[1]["back"] = 0.0;
}

_id_5A40() {
  level waittill("agent_falls_out");
  level._id_5A37[0]["back"] = 0.0;
}

_id_5A41(var_0, var_1) {
  if(!isDefined(level._id_5A42)) {
    level._id_5A42 = common_scripts\utility::spawn_tag_origin();
  }
  level._id_5A42.origin = var_0 gettagorigin("J_Mid_Section");
  var_2 = level._id_5A42 maps\_shg_common::_id_1683(self.origin);
  level._id_5A42.origin = var_1 gettagorigin("J_Mid_Section");
  var_3 = level._id_5A42 localtoworldcoords(var_2);

  if(isai(self)) {
    self forceteleport(var_3, self.angles);
  } else if(isPlayer(self)) {
    level._id_5A42.origin = var_3;
    level._id_5A42.angles = self getplayerangles();
    maps\_utility::_id_1FDF(level._id_5A42);
  } else {
    self.origin = var_3;
  }
}

_id_5A43(var_0, var_1) {
  level.player _id_5A41(var_0, var_1);
  level._id_58CB _id_5A41(var_0, var_1);
  level._id_58CB linkto(var_1, "tag_agent", (0, 0, 0), (0, 0, 0));
  level._id_58D2 _id_5A41(var_0, var_1);
  level._id_58D2 linkto(var_1, "J_Mid_Section");
  var_2 = getEntArray("sled_attach_ents", "targetname");

  foreach(var_4 in var_2) {
    var_4 _id_5A41(var_0, var_1);
    var_4 setModel("tag_origin");
    var_4 linkto(var_1, "J_Mid_Section");
  }

  var_6 = getEntArray("tail_attach_ents", "targetname");

  foreach(var_4 in var_6) {
    var_4 _id_5A41(var_0, var_1);
    var_4 setModel("tag_origin");
    var_4 linkto(var_1, "J_Tail_Sled");
  }
}

_id_5A44() {
  self.ignoreall = 1;
  self._id_1032 = "generic";
  maps\_audio::aud_send_msg("agent_scream", level._id_58CB);
  level thread maps\_utility::_id_1424("agent_falls_out", 19.5);
  level._id_5976[0] maps\_anim::_id_1246(self, "planecrash_agent1", "tag_agent");

  if(isDefined(self._id_0D04) && self._id_0D04) {
    maps\_utility::_id_1902();
  }
  self._id_0D45 = undefined;
  waittillframeend;
  self kill();
}

_id_5A45() {
  level._id_58D2 notify("stop_door_loop");
}

_id_5A46() {
  level waittill("crash_teleport");
  thread _id_5A47(getent("planecrash_enemy1", "targetname"), "planecrash_enemy1");
  thread _id_5A47(getent("planecrash_enemy2", "targetname"), "planecrash_enemy2");
  thread _id_5A47(getent("planecrash_enemy3", "targetname"), "planecrash_enemy3");
  thread _id_5A47(getent("planecrash_enemy4", "targetname"), "planecrash_enemy4");
  thread _id_5A47(getent("planecrash_enemy5", "targetname"), "planecrash_enemy5");
  thread _id_5A47(getent("planecrash_enemy6", "targetname"), "planecrash_enemy6");
}

_id_5A47(var_0, var_1) {
  var_2 = var_0 maps\_utility::_id_166F();
  var_2.ignoreall = 1;
  var_2 linkto(level._id_5976[0], "tag_enemy", (0, 0, 0), (0, 0, 0));
  var_2._id_240B = 1;
  level._id_5976[0] thread maps\_anim::_id_11C1(var_2, var_1, "tag_enemy");
  var_2.allowdeath = 1;
  var_2._id_0EC6 = 1;
  level waittill("crash_done");

  if(isDefined(var_2)) {
    var_2 delete();
  }
}

_id_5A48(var_0, var_1) {
  self shellshock(var_0, var_1);
}

_id_5A49() {
  var_0 = maps\_utility::_id_1287("player_rig", level.player.origin);
  var_0.angles = level.player.angles;
  var_0 maps\_anim::_id_1244();
  level.player disableweapons();
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player maps\_utility::delaythread(0.75, ::_id_5A48, "hijack_airplane", 3.0);
  maps\_audio::aud_send_msg("crash_death");
  var_0 linkto(level._id_5976[0], level._id_5A24, (0, 0, 0), (0, 180, 0));
  level.player playerlinktoabsolute(var_0, "tag_player");
  level.player playersetgroundreferenceent(undefined);
  var_1 = getanimlength(var_0 maps\_utility::_id_1281("crash_fall_out"));
  level._id_5976[0] thread maps\_anim::_id_1246(var_0, "crash_fall_out", level._id_5A24);
  wait(var_1 - 0.5);
  setDvar("ui_deadquote", &"HIJACK_FELL_OUT_OF_PLANE");
  level notify("mission failed");
  maps\_utility::_id_1826();
}

_id_5A4A() {
  setsunlight(0, 0, 0);
  level waittill("crash_impact");
  setsaveddvar("sm_sunSampleSizeNear", 2.5);
  enableforcedsunshadows();
  resetsunlight();
  thread _id_5A4B();
  thread _id_5A51();
  common_scripts\utility::flag_wait("crash_throw_player");
  disableforcedsunshadows();
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
}

_id_5A4B() {
  wait 0.5;
  var_0 = (0, 0, 0);
  thread _id_5A4F();

  while(!common_scripts\utility::flag("stop_sun_crash_lerp")) {
    var_1 = randomfloatrange(level._id_5A4D, level._id_5A4C);
    wait(randomfloatrange(0.1, 0.3));
    var_0 = level._id_5A4E * var_1;
    setsunlight(var_0[0], var_0[1], var_0[2]);
  }

  var_2 = (0.878431, 0.443137, 0.121569);
  _id_5A50(var_0, var_2, 0.5);
}

_id_5A4F() {
  var_0 = (0.878431, 0.443137, 0.121569);
  var_1 = (0.965, 0.847, 0.584);
  var_2 = 1.2;
  var_3 = 3.0;
  var_4 = 0.9;
  var_5 = 0.98;
  level._id_5A4E = var_0;
  level._id_5A4D = var_2;
  level._id_5A4C = var_3;
  var_6 = 13;
  var_7 = var_6;

  while(var_7 > 0) {
    var_8 = (var_6 - var_7) / var_6;
    var_8 = var_8 * var_8;
    level._id_5A4E = vectorlerp(var_0, var_1, var_8);
    level._id_5A4D = maps\_utility::_id_281D(var_8, var_2, var_4);
    level._id_5A4C = maps\_utility::_id_281D(var_8, var_3, var_5);
    var_7 = var_7 - 0.1;
    wait 0.1;
  }

  common_scripts\utility::flag_set("stop_sun_crash_lerp");
}

_id_5A50(var_0, var_1, var_2) {
  var_3 = var_2;
  var_4 = 0;

  while(var_3 > 0) {
    var_3 = var_3 - 0.05;
    var_4 = (var_2 - var_3) / var_2;
    var_5 = var_0 + (var_1 - var_0) * var_4;
    setsunlight(var_5[0], var_5[1], var_5[2]);
  }
}

_id_5A51() {
  var_0 = (-5, -90, 0);
  var_1 = -5;
  var_2 = -120;
  var_3 = -70;
  var_4 = (-5, -130, 0);
  var_5 = (-5, -80, 0);
  var_6 = (0.878431, 0.443137, 0.121569);
  lerpsunangles(var_0, var_4, 0.05);

  while(!common_scripts\utility::flag("stop_sun_crash_lerp")) {
    lerpsunangles(var_5, var_4, randomfloatrange(0.5, 1.1));
    wait(randomfloatrange(0.6, 0.9));
    lerpsunangles(var_4, var_5, 0.05);
    wait 0.05;
  }
}

_id_5A52(var_0) {
  var_0 waittillmatch("single anim", "hit_ground");
  level notify("crash_impact");
  level notify("crash_stop_pre_sled_lights");
  thread _id_5A59();
  level.player stoprumble("hijack_plane_medium");
  earthquake(0.7, 1.2, level.player.origin, 200000);
  level.player disableweapons();
  wait 0.5;
  level.player playrumblelooponentity("hijack_plane_large");
  thread maps\hijack_code::_id_5953();
  wait 1.5;
  level.player enableweapons();
}

_id_5A53(var_0) {
  var_0 waittillmatch("single anim", "hit_stop");
  common_scripts\utility::flag_set("crash_throw_player");
  level notify("crash_stop_flashing_lights");
  level notify("sled_scrape_stop");
  stopallrumbles();
  level notify("stop_rumbling");
  var_1 = common_scripts\utility::getstruct("player_crash_end_lookat", "targetname");
  var_2 = getent("crash_player_dest_2", "script_noteworthy");

  if(level._id_5A22) {
    var_2 = getent("crash_player_dest_1", "script_noteworthy");
  }
  var_3 = vectortoangles(var_1.origin - var_2.origin);
  var_3 = (0, var_3[1], 0);
  _id_59D7();
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4.origin = var_0 gettagorigin(level._id_5A24);
  var_4.angles = var_0 gettagangles(level._id_5A24) + (10, 180, 0);
  var_4 linkto(level._id_5A23);
  level.player playerlinktoblend(var_4, "tag_origin", 0.1, 0, 0);
  wait 0.1;

  if(isDefined(level._id_58D2)) {
    level._id_58D2 maps\_utility::_id_1902();
    level._id_58D2 delete();
    level._id_58D2 = maps\hijack_code::_id_594A("commander_tarmac", "tarmac_commander_tarmac");
    var_5 = getnode("commander_pre_ramp_node", "targetname");
    level._id_58D2 maps\_utility::_id_27A1(var_5);
    level._id_58D2 hide();
  }

  level.player shellshock("hijack_airplane", 2.5);
  level.player playrumbleonentity("damage_heavy");
  wait 0.3;
  var_0 waittillmatch("single anim", "hit_end");
  common_scripts\utility::flag_set("stop_managing_crash_player");
  level.player playrumbleonentity("damage_heavy");
  thread maps\hijack_code::_id_09FA(0.05);
  wait 0.2;
  level notify("crash_sequence_done");
  setsaveddvar("compass", 0);
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  level.player enableslowaim(0, 0);
  wait 10.0;
  setsaveddvar("compass", 1);
  setsaveddvar("hud_showStance", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("actionSlotsHide", 0);
  level.player disableslowaim();
  level._id_58D2 show();
  level.player allowcrouch(0);
  maps\_compass::setupminimap("compass_map_hijack_tarmac", "tarmac_minimap_corner");
  setsaveddvar("compassmaxrange", 3500);
  thread maps\hijack_code::_id_17CC(3.0);
  thread _id_5A58();
  var_6 = common_scripts\utility::getstruct("agent_helps_player_origin", "targetname");
  thread _id_5A54(var_6);
  thread _id_5A55(var_6);
  thread _id_59D8();
}

_id_59D7() {
  level.player disableweapons();
}

_id_59D8() {
  var_0 = common_scripts\utility::getstruct("agent_helps_player_origin", "targetname");
  var_1 = getent("post_crash_phone", "targetname");
  var_1._id_1032 = "post_crash_telephone";
  var_1 maps\_anim::_id_1244();
  var_0 thread maps\_anim::_id_1246(var_1, "telephone_swing");
}

_id_5A54(var_0) {
  var_1 = maps\_utility::_id_1287("player_rig", level.player.origin);
  level.player playerlinktodelta(var_1, "tag_player", 1.0, 10, 10, 10, 10, 1);
  thread _id_5A57();
  level.player enableslowaim();
  var_0 maps\_anim::_id_1246(var_1, "help_player_up");
  level.player unlink();
  var_1 delete();
  thread _id_5A56();
  common_scripts\utility::flag_set("player_on_feet_post_crash");
}

_id_5A55(var_0) {
  level notify("start_commander_wake_up_anim");
  var_0 maps\_anim::_id_1246(level._id_58D2, "help_player_up");
  common_scripts\utility::flag_set("commander_finished_wake_up_anim");
}

_id_5A56() {
  var_0 = 0.4;
  level.player enableslowaim(0.2, 0.2);
  wait(var_0);
  level.player enableslowaim(0.3, 0.3);
  wait(var_0);
  level.player enableslowaim(0.4, 0.4);
  wait(var_0);
  level.player enableslowaim(0.5, 0.5);
  wait(var_0);
  level.player enableslowaim(0.6, 0.6);
  wait(var_0);
  level.player enableslowaim(0.7, 0.7);
  wait(var_0);
  level.player enableslowaim(0.8, 0.8);
  wait(var_0);
  level.player enableslowaim(0.9, 0.9);
  wait(var_0);
  level.player disableslowaim();
}

_id_5A57() {
  setblur(9, 1);
  wait 1;
  setblur(0, 1);
  wait 2;
  setblur(4, 0.5);
  wait 0.5;
  setblur(0, 0.5);
  wait 2.5;
  setblur(5, 3);
  wait 2.5;
  setblur(0, 1.5);
  wait 0.5;
  var_0 = level._id_1436;
  var_1 = [];
  var_1["nearStart"] = 0.1;
  var_1["nearEnd"] = 0.2;
  var_1["nearBlur"] = 6.0;
  var_1["farStart"] = 50;
  var_1["farEnd"] = 100;
  var_1["farBlur"] = 5;
  maps\_utility::_id_27C0(var_0, var_1, 2.5);
  common_scripts\utility::flag_wait("player_on_feet_post_crash");
  maps\_utility::_id_27C0(var_1, var_0, 5);
}

_id_5A58() {
  level endon("player_exit_plane_3");
  level._id_59EF = spawn("script_origin", level.player.origin);
  level._id_59EF linkto(level.player);
  level._id_59EF._id_1046 = 1;
  var_0 = 1.75;
  var_1 = 3.0;
  maps\hijack_code::_id_5956("hijack_rt1_stillinarea", level._id_59EF);
  wait(randomfloatrange(var_0, var_1));
  maps\hijack_code::_id_5956("hijack_rt2_command", level._id_59EF);
  wait(randomfloatrange(var_0, var_1));
  maps\hijack_code::_id_5956("hijack_rt3_scrambling", level._id_59EF);
  wait(randomfloatrange(var_0, var_1));
  maps\hijack_code::_id_5956("hijack_rt1_clearing", level._id_59EF);
  wait(randomfloatrange(var_0, var_1));
  maps\hijack_code::_id_5956("hijack_rt2_neutralized", level._id_59EF);
  wait(randomfloatrange(var_0 - 1, var_1 - 1));
  maps\hijack_code::_id_5956("hijack_rt3_wounded", level._id_59EF);
  wait(randomfloatrange(var_0 - 1, var_1 - 1));
  maps\hijack_code::_id_5956("hijack_rt1_verifylocation", level._id_59EF);
  wait(randomfloatrange(var_0 - 1, var_1 - 1));
  maps\hijack_code::_id_5956("hijack_rt2_hamburg", level._id_59EF);
  wait(randomfloatrange(var_0 - 1, var_1 - 1));
  maps\hijack_code::_id_5956("hijack_fso1_flightpath", level._id_59EF);
}

_id_5A59() {
  var_0 = getent("hijack_crash_model_front_interior_new", "script_noteworthy");
  var_1 = getent("hijack_crash_model_rear_interior_new", "script_noteworthy");
  _id_5A5C(0, var_0, "plane_crash_lights_on_front", "plane_crash_lights_off_front");
  _id_5A5C(0, var_1, "plane_crash_lights_on_rear", "plane_crash_lights_off_rear");
  wait 2.0;
  thread _id_5A5B(var_0, "stop_front_flicker", "plane_crash_lights_on_front", "plane_crash_lights_off_front");
  wait 3.0;
  _id_5A5C(0, var_1, "plane_crash_lights_on_rear", "plane_crash_lights_off_rear");
  common_scripts\utility::flag_wait("crash_throw_player");
  level notify("stop_front_flicker");
  _id_5A5C(0, var_0, "plane_crash_lights_on_front", "plane_crash_lights_off_front");
  _id_5A5C(0, var_1, "plane_crash_lights_on_rear", "plane_crash_lights_off_rear");
}

_id_5A5A() {
  level endon("crash_teleport");
  var_0 = getent("crash_battlechatter_origin", "script_noteworthy");

  for(;;) {
    var_0 maps\_utility::play_sound_on_entity("RU_1_order_move_combat");
    var_0 maps\_utility::play_sound_on_entity("RU_1_hostile_burst");
  }
}

_id_5A5B(var_0, var_1, var_2, var_3) {
  level endon(var_1);

  for(;;) {
    _id_5A5C(1, var_0, var_2, var_3);
    wait(randomfloatrange(0.05, 0.5));
    _id_5A5C(0, var_0, var_2, var_3);
    wait(randomfloatrange(0.05, 0.2));
  }
}

_id_5A5C(var_0, var_1, var_2, var_3) {
  if(var_0) {
    var_1 setModel(level._id_1F90[var_2]);
  } else {
    var_1 setModel(level._id_1F90[var_3]);
  }
}