/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\yard\yard_junction.gsc
**************************************************/

_id_A50C() {
  scripts\engine\utility::flag_init("junction_enter_end");
  scripts\engine\utility::flag_init("junction_tram_end");
  scripts\engine\utility::flag_init("junction_arrive_end");
  scripts\engine\utility::flag_init("junction_capture_end");
  scripts\engine\utility::flag_init("junction_combat_corridor_1_go");
  scripts\engine\utility::flag_init("junction_combat_corridor_2_go");
  scripts\engine\utility::flag_init("junction_capture_corridor_3_go");
  scripts\engine\utility::flag_init("dropship_go");
  scripts\engine\utility::flag_init("junction_capture_corridor_3_first_rack");
  scripts\engine\utility::flag_init("junction_capture_corridor_3_mid");
  scripts\engine\utility::flag_init("c8_tracking_ready");
  scripts\engine\utility::flag_init("junction_capture_corridor_4_go");
  scripts\engine\utility::flag_init("junction_capture_corridor_4_c8");
  scripts\engine\utility::flag_init("junction_corridor_4_c8_start");
  scripts\engine\utility::flag_init("junction_spaced_end");
  scripts\engine\utility::flag_init("yard_stop_crawl_hack");
  scripts\engine\utility::flag_init("player_crawling");
  scripts\engine\utility::flag_init("flag_turn_tram");
}

_id_A50E() {
  scripts\engine\utility::array_thread(getEntArray("move_server_trigger", "targetname"), ::_id_BC6B);
}

_id_10C92() {
  scripts\engine\utility::flag_set("yard_start_objectives");
  scripts\engine\utility::flag_set("yard_obj_ambush_done");
  scripts\sp\maps\yard\yard_audio::_id_25EE("junction_tram", "start");
}

_id_10C8F() {
  scripts\engine\utility::flag_set("yard_start_objectives");
  scripts\engine\utility::flag_set("yard_obj_ambush_done");
  scripts\sp\maps\yard\yard_central::_id_3BE5();
  scripts\sp\maps\yard\yard_audio::_id_25EE("junction_arrive", "start");
  _id_A510();
  scripts\sp\maps\yard\yard_util::_id_106D9("continue_junction_enter_ethan");
  _id_F5EF();
  var_0 = scripts\engine\utility::getStruct("org_tram_end", "targetname");
  level._id_11B49._id_C6EA.origin = var_0.origin;
  level._id_11B49._id_C6EA.angles = var_0.angles;
  level._id_11B49._id_5978 scripts\engine\utility::delaycall(0.1, ::unlink);
  level._id_11B49._id_5978 scripts\engine\utility::delaycall(0.15, ::rotateby, (0, -92, 0), 0.05);
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("continue_junction_arrive_player", "targetname"));
  level._id_10DAA = 1;
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_CF8B();
}

_id_10C90() {
  scripts\engine\utility::flag_set("yard_start_objectives");
  scripts\engine\utility::flag_set("yard_obj_ambush_done");
  scripts\sp\maps\yard\yard_central::_id_3BE5();
  scripts\sp\maps\yard\yard_audio::_id_25EE("junction_capture", "start");
  _id_A510();
  scripts\sp\maps\yard\yard_util::_id_106D9("continue_junction_enter_ethan");
  var_0 = scripts\engine\utility::getStruct("org_tram_end", "targetname");
  level._id_11B49._id_C6EA.origin = var_0.origin;
  level._id_11B49._id_C6EA.angles = var_0.angles;
  level._id_11B49._id_5978 scripts\engine\utility::delaycall(0.1, ::unlink);
  level._id_11B49._id_5978 scripts\engine\utility::delaycall(0.15, ::rotateby, (0, -92, 0), 0.05);
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("continue_junction_capture_player", "targetname"));
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_1", "open", "unlocked", "generic_door_open");
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_2", "open", "unlocked", "generic_door_open");
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_3", "open", "unlocked", "generic_door_open");
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_4", "close", "locked", "generic_door_open");
  scripts\engine\utility::flag_set("dropship_go");
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_CF8B();
  level._id_10DAB = 1;
}

_id_10C91() {
  scripts\engine\utility::flag_set("yard_start_objectives");
  scripts\engine\utility::flag_set("yard_obj_ambush_done");
  scripts\sp\maps\yard\yard_central::_id_3BE5();
  scripts\sp\maps\yard\yard_audio::_id_25EE("junction_spaced", "start");
  scripts\sp\maps\yard\yard_util::_id_106D9("org_ethan_hack");
  scripts\sp\maps\yard\yard_util::_id_107BE("org_salter_ship");
  thread _id_A500(1);
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_final", "open", "unlocked", "generic_door_open");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("continue_junction_spaced_player", "targetname"));
  scripts\engine\utility::flag_set("junction_capture_corridor_4_c8");
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_CF8B();
}

_id_B205() {
  level thread scripts\sp\utility::_id_CE10("mars_cutscene_shipyard_plan", "yard_cutscene_start_skippable");
  level thread scripts\sp\maps\yard\yard_audio::_id_2592();
  scripts\sp\maps\yard\yard_central::_id_3BE5();
  wait 0.1;
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_tram", "targetname"));
  _id_A510();
  wait 0.5;
  scripts\sp\utility::_id_2669("yard_junction_pre_tram");
  thread _id_A51B();

  if(isDefined(level._id_6754)) {
    level._id_6754 delete();
  }

  level waittill("skippable_cinematic_done");
  scripts\engine\utility::flag_set("junction_bink_finished");
  scripts\sp\maps\yard\yard_fx::_id_132BA(1);
  scripts\sp\maps\yard\yard_audio::_id_25EE("junction_tram", "main");
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_2669("yard_junction_tram");
  thread _id_11B46();
  thread scripts\sp\utility::_id_1264E("yard_airlock_tr");
  thread _id_A51F();
  thread _id_F5EF();
  scripts\engine\utility::flag_wait("junction_tram_end");
  thread scripts\sp\utility::_id_1264E("yard_tram_central_tr");
  thread scripts\sp\utility::_id_1264E("yard_tram_tr");
  thread scripts\sp\utility::_id_12641("yard_central_hub_tr");
  var_0 = getEntArray("control_room_vista_dome_01", "targetname");

  if(isDefined(var_0) && var_0.size) {
    foreach(var_2 in var_0) {
      var_2 hide();
    }
  }

  while(!istransientloaded("yard_central_hallway_tr")) {
    wait 0.05;
    waitforalltransients();
  }
}

_id_11B46() {
  wait 7;
  setmusicstate("mx_281_yard_post_tram");
}

_id_A51F() {
  level notify("tram_sequence");
  var_0 = level._id_11B49._id_C6EA scripts\engine\utility::spawn_tag_origin();
  var_1 = level._id_11B49._id_C6EA scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(level._id_11B49._id_C6EA, "tag_origin", (60, 0, -47), (90, 0, 0));
  var_1 linkTo(level._id_11B49._id_C6EA, "tag_origin", (-60, 0, -47), (90, 0, 0));
  var_0 thread scripts\sp\maps\yard\yard_fx::_id_13346();
  var_1 thread scripts\sp\maps\yard\yard_fx::_id_13346();
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_sprint(0);
  level.player thread scripts\sp\utility::_id_2B76(0.7, 0.2);
  level.player scripts\sp\utility::_id_F526("relaxed");
  thread tram_kill_player(level._id_11B49._id_C6EA);
  wait 1.0;
  var_2 = 8;
  var_3 = scripts\sp\vehicle::_id_1080C("veh_tram_player");
  var_3 hide();
  level.player thread _id_11B4E(var_3);
  level._id_11B49._id_C6EA moveTo(var_3.origin, var_2, 2, 0.05);
  scripts\engine\utility::delaythread(4, ::_id_A51D, var_3);
  level._id_11B49 thread scripts\sp\maps\yard\yard_audio::_id_2600(var_3);
  wait(var_2);
  level._id_11B49._id_C6EA linkTo(var_3);
  thread scripts\sp\vehicle_paths::_id_845A(var_3);
  scripts\engine\utility::flag_wait("flag_turn_tram");
  level._id_11B49._id_C6EA _meth_826A((0, 90, 0), 6, 1.5, 1);
  var_3 waittill("reached_end_node");
  level._id_11B49._id_C6EA unlink();
  var_4 = scripts\engine\utility::getStruct("org_tram_end", "targetname");
  level._id_11B49._id_C6EA moveTo(var_4.origin, 4, 0, 2);
  level._id_11B49._id_C6EA rotateTo(var_4.angles, 3, 1, 1);
  level._id_11B49._id_C6EA waittill("movedone");
  wait 1.0;
  level._id_11B49._id_5978 unlink();
  level._id_11B49._id_5978 rotateby((0, -92, 0), 2.6, 0.6, 1.2);
  level._id_11B49._id_5978 playSound("scn_tram_airlock_open");
  level.player scripts\engine\utility::allow_jump(1);
  level.player scripts\engine\utility::allow_sprint(1);
  level.player thread scripts\sp\utility::_id_2B77(0.2);
  level.player scripts\sp\utility::_id_F526("normal");
  level._id_11B49 thread _id_11B4B();
  level notify("stop_tram_logic");
  scripts\engine\utility::flag_set("junction_tram_end");
}

tram_kill_player(var_0) {
  level endon("stop_tram_logic");
  level.player endon("death");
  var_1 = 1000;

  while(!scripts\engine\utility::flag("junction_tram_end")) {
    if(!isDefined(var_0)) {
      break;
    }

    var_2 = distance(var_0.origin, level.player.origin);

    if(var_2 > var_1) {
      level.player _meth_81D0();
    }

    scripts\engine\utility::waitframe();
  }
}

_id_11B4E(var_0) {
  var_1 = scripts\sp\utility::_id_7C23();
  var_1 scripts\sp\utility::_id_F581(0.65);
  wait 4;
  var_1 thread scripts\sp\utility::_id_E7C9(0.25, 1);
  scripts\engine\utility::flag_wait("flag_turn_tram");
  var_1 thread scripts\sp\utility::_id_E7C9(0.65, 1);
  wait 1;
  var_1 thread scripts\sp\utility::_id_E7C9(0.25, 1);
  var_0 waittill("reached_end_node");
  var_1 scripts\sp\utility::_id_F581(0.15);
  level._id_11B49._id_C6EA waittill("movedone");
  var_1 scripts\sp\utility::_id_F581(0);
  scripts\engine\utility::waitframe();
  level.player playRumbleOnEntity("damage_light");
}

_id_11B4B() {
  scripts\engine\utility::flag_wait("junction_capture_scene_door_close");

  foreach(var_1 in self._id_ACFC) {
    var_1 unlink();
    var_1 delete();
  }

  self._id_11B30 unlink();
  self._id_11B30 delete();
  self._id_5978 unlink();
  self._id_5978 delete();
  self._id_5985 unlink();
  self._id_5985 delete();
}

_id_A51D(var_0) {
  scripts\sp\utility::_id_10350("yard_eth_canyouhear");
  scripts\sp\utility::_id_1034D("yard_plr_affirmativeethan");
  scripts\sp\utility::_id_10350("yard_eth_goteyesonyou");
  scripts\sp\utility::_id_1034D("yard_plr_enemypositions");
  scripts\sp\utility::_id_10350("yard_eth_onthosetoo");
  wait 0.5;
  scripts\sp\utility::_id_10350("yard_slt_thisissuicide");
  scripts\sp\utility::_id_1034D("yard_plr_igavemyorder");
  wait 0.25;
  scripts\sp\utility::_id_10350("yard_slt_captaindoesnt");
  wait 0.5;
  scripts\sp\utility::_id_1034D("yard_plr_notalways");
  var_0 waittill("reached_end_node");
  scripts\sp\utility::_id_10350("yard_eth_thisisyourstopsir");
  scripts\sp\utility::_id_1034D("yard_plr_check");
}

_id_A51B() {
  var_0 = getEnt("anim_tram_allies", "targetname");
  var_0 linkTo(level._id_11B31._id_11B30);

  if(!isDefined(level._id_EA2C)) {
    scripts\sp\maps\yard\yard_util::_id_107BE("org_salter_tram");
    level._id_EA2C thread scripts\sp\utility::_id_DC45("raise");
  }

  if(!isDefined(level._id_30F6)) {
    scripts\sp\maps\yard\yard_util::_id_1065E("org_brooks_tram");
    level._id_30F6 thread scripts\sp\utility::_id_DC45("raise");
  }

  var_1 = scripts\sp\utility::_id_22CD("tram_ally_marine", 1);
  var_2 = scripts\engine\utility::array_combine([level._id_EA2C, level._id_30F6], var_1);

  foreach(var_5, var_4 in var_1) {
    var_4._id_1FBB = "ally" + scripts\sp\utility::string(var_5 + 1);
    var_4 scripts\sp\utility::_id_72EC("iw7_m4", "primary");
  }

  var_6 = scripts\sp\vehicle::_id_1080C("veh_tram_allies");
  var_6 hide();
  level._id_11B31._id_11B30 linkTo(var_6);
  var_7 = var_6 scripts\engine\utility::spawn_tag_origin();
  var_8 = var_6 scripts\engine\utility::spawn_tag_origin();
  var_7 linkTo(var_6, "tag_origin", (60, 0, -47), (90, 0, 0));
  var_8 linkTo(var_6, "tag_origin", (-60, 0, -47), (90, 0, 0));
  var_7 thread scripts\sp\maps\yard\yard_fx::_id_13346();
  var_8 thread scripts\sp\maps\yard\yard_fx::_id_13346();
  wait 1.5;

  foreach(var_10 in var_2) {
    var_0 scripts\sp\anim::_id_1EC3(var_10, "tram_scene");
  }

  wait 1.5;
  level notify("yard_cutscene_start_skippable");

  foreach(var_10 in var_2) {
    var_10 linkTo(var_0);
  }

  thread _id_0B0A::_id_583F(0, 100, 1, 8700, 50000, 3.1, 0);
  scripts\engine\utility::flag_wait("junction_bink_finished");
  var_0 thread scripts\sp\anim::_id_1F2C(var_2, "tram_scene");
  scripts\engine\utility::delaythread(1.5, scripts\sp\vehicle_paths::_id_845A, var_6);
  var_6 waittill("reached_end_node");
  level._id_EA2C unlink();
  var_6 unlink();
  var_6 delete();
  level._id_11B31 thread _id_11B4B();
  scripts\sp\utility::_id_228A(var_2);
}

_id_A510() {
  level._id_11B49 = _id_A4FD(getEntArray("tram_player", "script_noteworthy"));
  level._id_11B31 = _id_A4FD(getEntArray("tram_allies", "script_noteworthy"));
  var_0 = scripts\engine\utility::getStruct("tram_struct_start_player", "targetname");
  var_1 = scripts\engine\utility::getStruct("tram_struct_start_allies", "targetname");
  level._id_11B49._id_C6EA.origin = var_0.origin;
  level._id_11B49._id_C6EA.angles = var_0.angles;
  level._id_11B31._id_C6EA.origin = var_1.origin;
  level._id_11B31._id_C6EA.angles = var_1.angles;
}

_id_A4FD(var_0) {
  var_1 = spawnStruct();
  var_1._id_ACFC = [];

  foreach(var_3 in var_0) {
    var_3._id_142B = var_1;

    if(!isDefined(var_3.script_type)) {
      continue;
    }
    if(var_3.script_type == "tram_link") {
      var_1._id_ACFC[var_1._id_ACFC.size] = var_3;
      continue;
    }

    if(var_3.script_type == "tram") {
      var_1._id_11B30 = var_3;
      continue;
    }

    if(var_3.script_type == "console") {
      var_1.console = var_3;
      continue;
    }

    if(var_3.script_type == "door") {
      var_1._id_5978 = var_3;
      continue;
    }

    if(var_3.script_type == "door_clip") {
      var_1._id_5985 = var_3;
    }
  }

  var_1._id_5978 linkTo(var_1._id_11B30);
  var_1._id_5985 linkTo(var_1._id_5978);

  foreach(var_6 in var_1._id_ACFC) {
    var_6 linkTo(var_1._id_11B30);
  }

  var_1._id_C6EA = var_1._id_11B30 scripts\engine\utility::spawn_tag_origin();
  var_1._id_11B30 linkTo(var_1._id_C6EA);
  return var_1;
}

_id_B202() {
  scripts\sp\maps\yard\yard_fx::_id_132BA(0);
  scripts\sp\maps\yard\yard_fx::_id_132CE(1);
  scripts\sp\maps\yard\yard_audio::_id_25EE("junction_arrive", "main");
  scripts\sp\utility::_id_2669("yard_junction_arrive");
  thread _id_A50B();
  var_0 = scripts\engine\utility::getStruct("org_ethan_hack", "targetname");

  if(!isDefined(level._id_6754)) {
    scripts\sp\maps\yard\yard_util::_id_106D9("org_ethan_hack");
  } else {
    if(isDefined(level._id_6037)) {
      level._id_6754 unlink();
      level._id_6037 notify("elevator_end_idle");
      level._id_6754 scripts\sp\utility::anim_stopanimScripted();
      scripts\engine\utility::waitframe();
    }

    level._id_6754 dontinterpolate();
    level._id_6754 _meth_80F1(var_0.origin, var_0.angles, 500000.0);
    level._id_6754 setgoalpos(level._id_6754.origin);
  }

  var_1 = getEnt("junction_capture_trig", "targetname");
  scripts\sp\utility::_id_10350("yard_eth_junctionroomsho");
  scripts\sp\utility::_id_1034D("yard_plr_lasthaulhuh");
  scripts\sp\utility::_id_10350("yard_eth_regrettablysir");
  scripts\sp\utility::_id_2669("yard_junction_arrive_2");
  thread _id_A4FA(var_1);
  scripts\engine\utility::flag_wait("junction_arrive_end");
}

_id_A50B() {
  var_0 = getEnt("tram_dock_door_left", "targetname");
  var_1 = getEnt("tram_dock_door_right", "targetname");
  var_2 = var_0.origin;
  var_3 = var_1.origin;
  var_4 = getEnt("tram_dock_door_clip_left", "targetname");
  var_5 = getEnt("tram_dock_door_clip_right", "targetname");
  var_6 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_7 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  wait 3;
  var_0 moveTo(var_6.origin, 0.5);
  var_1 moveTo(var_7.origin, 0.5);
  var_4 notsolid();
  var_5 notsolid();
  var_1 thread scripts\sp\utility::play_sound_on_entity("generic_door_open");
  scripts\sp\utility::_id_127B3("junction_thermal_door_trig");
  var_0 moveTo(var_2, 0.5);
  var_1 moveTo(var_3, 0.5);
  var_4 solid();
  var_5 solid();
  var_1 thread scripts\sp\utility::play_sound_on_entity("generic_door_close");
}

_id_A4FA(var_0) {
  scripts\sp\utility::_id_127B3("junction_thermal_door_trig");
  thread _id_0B0A::_id_583D(1);
  scripts\sp\utility::_id_1034D("yard_plr_allsetwhereto");
  scripts\sp\utility::_id_10350("yard_eth_hallwaytothefor");
  var_1 = scripts\sp\utility::_id_22CD("recon_guy", 1);
  thread scripts\sp\utility::_id_1034D("yard_plr_copy3");
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_1", "open", "locked", "generic_door_open");
  scripts\engine\utility::flag_set("junction_combat_corridor_1_go");
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_CF8B();
  thread _id_A4FB();
  thread _id_A4FC();
  scripts\engine\utility::flag_wait("junction_capture_scene");
  scripts\engine\utility::flag_set("junction_arrive_end");
}

_id_468F(var_0) {
  foreach(var_2 in var_0) {
    var_2 thread _id_A51A();
  }
}

_id_A51A() {
  self endon("death");
  scripts\engine\utility::flag_wait("junction_combat_corridor_1_go");
  _id_0F1B::_id_6808(level.player);
}

_id_10BFD() {
  self endon("death");
  scripts\engine\utility::flag_wait("corridor_combat_begin");
  self _meth_83A1();
}

_id_10BFE() {
  self endon("death");
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("explode");
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "ai_events");
  scripts\sp\utility::_id_57D6();
  scripts\engine\utility::flag_set("corridor_combat_begin");
}

_id_425C() {
  scripts\engine\utility::flag_wait("junction_combat_corridor_2_door_close");
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_2", "close", "lock", "generic_door_close");
}

_id_A4FB() {
  scripts\engine\utility::flag_wait("corridor_combat_begin");
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_2", "open", "unlock", "generic_door_open");
  var_0 = scripts\sp\utility::_id_22C6(getEntArray("corridor_1", "targetname"), 1);
  thread _id_D7B5(var_0);
  level._id_84BE = scripts\sp\utility::_id_107EA("grate_guy");
  thread _id_D7B6(level._id_84BE);
}

_id_A4FC() {
  scripts\engine\utility::flag_wait("junction_combat_corridor_2_go");
  var_0 = scripts\sp\utility::_id_22C6(scripts\sp\utility::_id_77DF("corridor_2"));
  thread _id_D7B5(var_0);
  scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_3", "open", "unlocked", "generic_door_open");
  thread _id_4690();
  scripts\engine\utility::flag_wait("junction_capture_scene");
  level thread _id_4254();
  scripts\engine\utility::flag_set("dropship_go");
}

_id_4690() {
  var_0 = getEntArray("corridor_2_extras", "targetname");

  if(isDefined(var_0) && var_0.size) {
    var_1 = scripts\sp\utility::_id_22CD("corridor_2_extras");
    _id_D7B5(var_1);
  }
}

_id_4254() {
  scripts\engine\utility::flag_wait("junction_capture_scene_door_close");
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_3", "close", "locked", "generic_door_close");
}

_id_D7B5(var_0) {
  foreach(var_2 in var_0) {
    thread _id_D7B6(var_2);
  }
}

_id_D7B6(var_0) {
  var_0 endon("death");
  var_1 = getEnt("vol_junction_hall_2", "targetname");
  scripts\engine\utility::flag_wait("junction_capture_scene_door_close");
  wait 1;

  if(var_0 istouching(var_1)) {
    var_0 delete();
  }
}

_id_B203() {
  scripts\sp\maps\yard\yard_fx::_id_132CE(1);
  scripts\sp\maps\yard\yard_audio::_id_25EE("junction_capture", "main");
  level notify("vfx_tram_lights_off");
  var_0 = scripts\engine\utility::getStruct("org_ethan_hack", "targetname");

  if(!isDefined(level._id_6754)) {
    scripts\sp\maps\yard\yard_util::_id_106D9("org_ethan_hack");
  } else {
    if(isDefined(level._id_6037)) {
      level._id_6754 unlink();
      level._id_6037 notify("elevator_end_idle");
      level._id_6754 scripts\sp\utility::anim_stopanimScripted();
      scripts\engine\utility::waitframe();
    }

    level._id_6754 dontinterpolate();
    level._id_6754 _meth_80F1(var_0.origin, var_0.angles, 500000.0);
    level._id_6754 setgoalpos(level._id_6754.origin);
  }

  var_1 = scripts\engine\utility::getStruct("org_salter_ship_mid", "targetname");

  if(!isDefined(level._id_EA2C)) {
    scripts\sp\maps\yard\yard_util::_id_107BE("org_salter_ship_mid");
  } else {
    level._id_EA2C dontinterpolate();
    level._id_EA2C _meth_80F1(var_1.origin, var_1.angles, 500000.0);
    level._id_EA2C setgoalpos(level._id_EA2C.origin);
  }

  _id_F27B();
  scripts\engine\utility::array_thread(getEntArray("rack_open_trigger", "targetname"), ::_id_F27A);
  thread _id_F8F0();
  scripts\sp\utility::_id_2669("yard_junction_capture");
  thread _id_A4FE();
  thread _id_A4FF();
  thread _id_A500();
  scripts\engine\utility::flag_wait("junction_capture_end");
  thread scripts\sp\utility::_id_12641("yard_central_tr");
}

_id_F8F0() {
  var_0 = getEntArray("junction_c6_spawners", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_1747(::_id_3372);
  }
}

_id_3372() {
  self.dontmelee = 1;
}

joint2() {
  thread _id_1051A();
  thread _id_10518();
  thread _id_10517();
}

_id_1051A() {
  var_0 = getEntArray("test_turret_node", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_10519();
  }
}

_id_10518() {
  var_0 = getEnt("capture_amb_jackal_00", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10808();
  var_1 thread _id_0BDC::_id_A373("captured_jackal_00");
  wait 3;

  if(!scripts\engine\utility::flag("junction_capture_corridor_3_first_rack")) {
    var_0 = getEnt("capture_amb_jackal_01", "targetname");
    var_1 = var_0 scripts\sp\utility::_id_10808();
    var_1 thread _id_0BDC::_id_A373("captured_jackal_01");
  }
}

_id_10519() {
  var_0 = 0.5;
  var_1 = 1.5;
  var_2 = scripts\engine\utility::getStructArray(self.target, "targetname");

  while(!scripts\engine\utility::flag("junction_capture_corridor_3_first_rack")) {
    var_3 = scripts\engine\utility::random(var_2);
    self.angles = vectortoangles(self.origin - var_3.origin);
    playFX(level._effect["fake_turret_small"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    playFX(level._effect["fake_flack"], self.origin);
    wait(randomfloatrange(var_0, var_1));
  }
}

_id_10517() {
  var_0 = 3.5;
  var_1 = 8.5;
  var_2 = scripts\engine\utility::getStructArray("spacebattle_explosion", "targetname");

  while(!scripts\engine\utility::flag("junction_capture_corridor_3_first_rack")) {
    var_3 = scripts\engine\utility::random(var_2);
    playFX(level._effect["vfx_jackal_death_01_zerog"], var_3.origin);
    wait(randomfloatrange(var_0, var_1));
  }
}

_id_A4FE() {
  wait 0.5;
  scripts\sp\utility::_id_10350("yard_slt_raiderfeverwere");
  scripts\sp\utility::_id_1034D("yard_plr_rogethansitrep");
  scripts\sp\utility::_id_10350("yard_slt_copyeyesonout");
  level.player stopgestureviewmodel();
  thread _id_A509();
  scripts\engine\utility::flag_wait("junction_capture_corridor_3_go");
  var_0 = getEntArray("junction_door_4", "targetname");
  var_1 = var_0[0];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "door_closed") {
      var_1 = var_3;
      break;
    }
  }

  scripts\sp\utility::_id_10350("yard_eth_workingonitsir");

  if(!scripts\engine\utility::flag("junction_capture_corridor_3_first_rack")) {
    scripts\sp\utility::_id_10350("yard_eth_illopenitwhenyoureset");
    scripts\engine\utility::flag_wait("junction_capture_corridor_3_first_rack");
    thread scripts\sp\utility::_id_1034D("yard_plr_copyopenitup");
  }

  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_4", "open", "unlock", "generic_door_open");
  var_5 = scripts\sp\utility::_id_22CD("corridor_3_actor");
  thread _id_E286("corridor_3_mg", 3);
  thread _id_E286("corridor_3_lmg", 4);
  scripts\engine\utility::flag_wait("junction_capture_corridor_3_mid");
  var_6 = scripts\sp\utility::_id_22C6(scripts\sp\utility::_id_77DF("corridor_3_mid"));
  level notify("stop_respawn");
  scripts\engine\utility::flag_wait("junction_capture_corridor_3_retreat");
  thread _id_4691();
}

_id_1F26() {
  scripts\engine\utility::flag_wait("junction_capture_corridor_4_go");
  var_0 = scripts\engine\utility::getStruct("org_anim_server_hit", "targetname");
  var_1 = _id_F278("rack11");
  var_2 = var_1._id_119E6;
  var_3 = scripts\sp\utility::_id_10639("server");
  var_4 = scripts\sp\utility::_id_107EA("server_runner_guy", 1);
  var_4._id_1FBB = "enemy";
  var_5 = getanimlength(var_4 scripts\sp\utility::_id_7DC1("server_hit")) * 0.54;
  var_4 scripts\sp\utility::_id_F415(1);
  var_4.allowdeath = 1;
  var_0 thread scripts\sp\anim::_id_1F2C([var_3, var_4], "server_hit");
  wait 0.05;
  var_3 _meth_82B0(var_3 scripts\sp\utility::_id_7DC1("server_hit"), 0.1);
  var_4 _meth_82B0(var_4 scripts\sp\utility::_id_7DC1("server_hit"), 0.1);
  wait 0.05;
  var_3 _meth_82B1(var_3 scripts\sp\utility::_id_7DC1("server_hit"), 0);
  var_4 _meth_82B1(var_4 scripts\sp\utility::_id_7DC1("server_hit"), 0);
  wait 0.05;
  scripts\engine\utility::delaythread(1.75, ::_id_F279, "rack11");
  var_3 _meth_82B1(var_3 scripts\sp\utility::_id_7DC1("server_hit"), 1);
  var_4 _meth_82B1(var_4 scripts\sp\utility::_id_7DC1("server_hit"), 1);
  var_4 scripts\engine\utility::delaythread(var_5, scripts\sp\utility::_id_F415, 0);
  var_1 scripts\engine\utility::delaycall(var_5, ::disconnectpaths);
}

_id_A509() {
  scripts\engine\utility::flag_wait("junction_capture_ethan_comment_rack");
  scripts\sp\utility::_id_1034D("yard_plr_gotnocover");
  thread scripts\sp\utility::_id_10350("yard_eth_illtakecareofthat");
  scripts\engine\utility::delaythread(0.5, ::_id_F279, "rack07");
  scripts\engine\utility::delaythread(1.5, ::_id_F279, "rack04");
  scripts\engine\utility::delaythread(2.5, ::_id_F279, "rack08");
  wait 2;
}

_id_A4FF() {
  thread _id_1F26();
  scripts\engine\utility::flag_wait("junction_capture_corridor_4_go");
  thread _id_A508();
  var_0 = scripts\sp\utility::_id_22C6(getEntArray("corridor_4", "targetname"), 1);
  level thread _id_4694(var_0);
  scripts\engine\utility::flag_wait_either("junction_capture_corridor_4_c8", "junction_corridor_4_c8_start");
  _id_4693();
}

_id_4693() {
  var_0 = getEnt("cover_react_volume", "targetname");
  var_1 = scripts\sp\utility::_id_107EA("corridor_4_c8", 1);
  var_1.maxhealth = 2100;
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_final", "open", "unlocked", "generic_door_open");
  thread scripts\sp\utility::_id_10350("yard_eth_yougotahunterin");
  var_1 thread _id_0A04::_id_3454(1);
  var_1 _meth_82F1(var_0);
  var_1 endon("death");
  scripts\engine\utility::flag_wait("junction_capture_end_room_door_close");
  wait 1.5;
  var_0 = getEnt("vol_capture_second_half", "targetname");
  var_2 = var_0 scripts\sp\utility::_id_77E3("axis");

  foreach(var_4 in var_2) {
    var_4 delete();
  }
}

_id_4694(var_0) {
  scripts\sp\utility::_id_13754(var_0);
  scripts\engine\utility::flag_set("junction_corridor_4_c8_start");
}

_id_A508() {
  scripts\engine\utility::flag_wait("junction_capture_corridor_4_enemy_special");
  var_0 = _id_F278("rack_special_1");
  var_1 = _id_F278("rack_special_2");
  var_0 thread _id_1093F();
  var_0 thread _id_6437();
  wait 0.5;
  var_1 thread _id_1093F();
  var_1 thread _id_6437();
}

_id_6437() {
  var_0 = getaiarray("axis");
  var_1 = 4096;
  var_2 = undefined;

  if(var_0.size) {
    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(scripts\engine\utility::distance_2d_squared(self.origin, var_0[var_3].origin) < var_1) {
        var_2 = var_0[var_3];
      }
    }
  }

  if(isDefined(var_2)) {
    level thread _id_470B(var_2);
  }
}

_id_470B(var_0) {
  var_0 endon("death");
  wait 1;
  var_1 = getEnt("cover_react_volume", "targetname");
  var_0 _meth_82F1(var_1);
}

_id_1093F() {
  var_0 = 0.75;
  var_1 = -54.0;
  thread scripts\sp\utility::play_sound_on_entity("server_open");
  self moveTo(self.origin + self._id_BD2A * var_1, var_0, var_0 / 2, var_0 / 2);
  self._id_9C5B = 0;
  wait(var_0);

  if(isDefined(self._id_119E6) && self._id_119E6._id_9C5B == 0) {
    self connectpaths();
  } else if(isDefined(self._id_2EFF) && self._id_2EFF._id_9C5B == 0) {
    self connectpaths();
  }
}

_id_4691() {
  var_0 = getaiarray("axis");
  var_1 = getEnt("corridor_4_runner_goal", "targetname");
  var_2 = getEnt("corridor_4_runner", "targetname");

  if(var_0.size) {
    foreach(var_4 in var_0) {
      if(!issubstr(var_4.classname, "c6")) {
        var_4 _meth_82F1(var_1);
        var_4 thread _id_E86E();
      }
    }
  }
}

_id_E86E() {
  var_0 = self;
  var_0 endon("death");
  var_0.ignoresuppression = 1;
  var_0.ignoreall = 1;
  var_0 scripts\engine\utility::waittill_any("damage", "goal");
  var_0.ignoreall = 0;
}

_id_A50A(var_0) {
  level._id_341D endon("death");
  scripts\sp\utility::_id_10350("yard_eth_yougotahunterin");

  while(isDefined(level._id_341D) && isalive(level._id_341D) && !scripts\sp\utility::_id_CFAC(var_0)) {
    wait 0.05;
  }

  scripts\sp\utility::_id_1034D("yard_plr_affirmative");
  scripts\sp\utility::_id_10350("yard_eth_shootthatblockh");
}

_id_E286(var_0, var_1) {
  level endon("stop_respawn");
  level.player endon("hack_control_target");

  if(!isDefined(var_1)) {
    var_1 = 100000;
  }

  var_2 = getEnt(var_0, "targetname");
  var_3 = 0;

  while(var_3 < var_1) {
    var_3++;
    var_2.count = 1;
    var_4 = var_2 scripts\sp\utility::_id_10619(1);
    var_4 waittill("death");
    wait(randomfloatrange(2.5, 4.0));
  }
}

_id_A500(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  level notify("all_dead");
  thread _id_1328B();
  scripts\engine\utility::flag_wait("junction_capture_end_room_door_close");
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_final", "close", "locked", "generic_door_close");
  var_1 = getEnt("junction_end_door_blocker", "targetname");

  if(isDefined(var_1)) {
    var_1.origin = var_1.origin + (0, 0, 128);
  }

  level.player scripts\sp\utility::_id_D08C("ges_radio");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  scripts\sp\utility::_id_1034D("yard_plr_ethanimblocke");
  level.player playSound("ges_plr_radio_off");
  level.player stopgestureviewmodel();
  setmusicstate("");
  scripts\sp\utility::_id_10350("yard_eth_usetheventilation");
  thread scripts\sp\utility::_id_1034D("yard_plr_rogerthat");
  _id_119BB();
}

_id_1328B() {
  scripts\sp\utility::_id_127B3("trig_player_in_vent");
  thread _id_1328A();
  thread vent_crawl_hint();
  level.player _meth_84FE();
  thread _id_13287();
  level thread _id_13289();
  scripts\engine\utility::flag_set("junction_capture_end");
}

vent_crawl_hint() {
  level endon("new_spaced_sequence");
  wait 5;
  var_0 = 0;

  if(level.player getstance() == "prone") {
    var_0 = 1;
  }

  var_1 = 840;

  while(!var_0) {
    if(level.player.origin[2] >= var_1) {
      if(level.player getstance() != "prone") {
        var_0 = 0;
        scripts\sp\utility::_id_56BA("crawl_hint");
      } else {
        var_0 = 1;
        scripts\engine\utility::flag_set("player_crawling");
      }

      wait 0.1;
    }

    wait 0.05;
  }
}

vent_prone_success() {
  return scripts\engine\utility::flag("player_crawling");
}

_id_1328A() {
  var_0 = level.player getcurrentprimaryweapon();
  level.player endon("death");

  while(!scripts\engine\utility::flag("yard_stop_crawl_hack")) {
    if("prone" == level.player getstance()) {
      level.player disableweaponswitch();
    } else {
      level.player enableweaponswitch();
    }

    scripts\engine\utility::waitframe();
  }

  level.player enableweaponswitch();
}

_id_13287() {
  level endon("new_spaced_sequence");

  if(level.player getstance() != "prone") {
    level.player setstance("crouch");
  }

  level.player scripts\engine\utility::allow_stances(0);
  wait 1;
  level.player scripts\engine\utility::allow_stances(1);
  scripts\sp\utility::_id_127B3("trig_player_in_vent");
  clearallcorpses();
  thread _id_13287();
}

_id_4260() {
  scripts\engine\utility::flag_wait("junction_capture_end_room_door_close");
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("junction_door_final", "close", "locked", "generic_door_close");
}

_id_62C2(var_0) {
  level endon("all_dead");
  scripts\sp\utility::_id_13753(var_0, var_0.size - 1);
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 _meth_82EE(getnode("final_spot", "targetname"));
  }
}

_id_13289() {
  var_0 = scripts\engine\utility::getStruct("org_salter_ship", "targetname");

  if(!isDefined(level._id_EA2C)) {
    scripts\sp\maps\yard\yard_util::_id_107BE("org_salter_ship");
  } else {
    level._id_EA2C dontinterpolate();
    level._id_EA2C _meth_80F1(var_0.origin, var_0.angles, 500000.0);
    level._id_EA2C setgoalpos(level._id_EA2C.origin);
  }

  thread scripts\sp\maps\yard\yard_audio::_id_25E6();
  scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_1034D, "yard_plr_samemovingasfas");
  scripts\sp\pip_util::_id_2ADF("yard_hud_salter_pip_01");
  scripts\sp\utility::_id_2669("yard_junction_spaced");
}

_id_F27B() {
  level._id_F277 = [];
  var_0 = getEntArray("server_cover", "script_noteworthy");

  for(var_1 = var_0.size; var_1 > 0; var_1--) {
    if(isDefined(var_0[var_1 - 1].script_type) && var_0[var_1 - 1].script_type == "damage_volume") {
      var_0 = scripts\sp\utility::array_remove_index(var_0, var_1 - 1);
    }
  }

  foreach(var_3 in var_0) {
    if(var_3.classname == "script_brushmodel") {
      level._id_F277 = scripts\engine\utility::array_add(level._id_F277, var_3);
    }
  }

  foreach(var_6 in level._id_F277) {
    var_7 = undefined;
    var_8 = var_6 scripts\sp\utility::_id_7A8F();

    foreach(var_10 in var_8) {
      if(!isDefined(var_10.script_noteworthy) && var_10.classname == "script_brushmodel") {
        var_7 = var_10;
        break;
      }
    }

    var_6._id_119E6 = var_7;
    var_7._id_2EFF = var_6;
    var_6._id_9C5B = 0;
    var_7._id_9C5B = 0;
    _id_F27C(var_6);
    _id_F27C(var_7);
  }
}

_id_F27C(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_type) && var_3.script_type == "damage_volume") {
      var_0._id_4CD8 = var_3;
      var_0._id_4CD8 setCanDamage(1);
    }

    var_3 linkTo(var_0);
  }

  var_5 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_0._id_BD2A = anglesToForward(var_5.angles);
  var_0.health = 100;
}

_id_F27A() {
  self waittill("trigger");

  if(isDefined(self.script_noteworthy)) {
    thread _id_F279(self.script_noteworthy);
  }
}

_id_F279(var_0) {
  var_1 = _id_F278(var_0);
  var_2 = var_1._id_119E6;

  if(var_1._id_9C5B) {
    return;
  }
  var_3 = 0.75;
  var_4 = 54;
  var_1._id_9C5B = 1;
  var_1 thread scripts\sp\utility::play_sound_on_entity("server_open");
  var_1 moveTo(var_1.origin + var_1._id_BD2A * var_4, var_3, var_3 / 2, var_3 / 2);
  var_1 scripts\engine\utility::delaycall(var_3, ::disconnectpaths);

  if(!_id_1C6B(var_0)) {
    return;
  }
  wait 0.5;
  var_2._id_9C5B = 1;
  var_2 thread scripts\sp\utility::play_sound_on_entity("server_open");
  var_2 moveTo(var_2.origin + var_2._id_BD2A * var_4, var_3, var_3 / 2, var_3 / 2);
  var_2 waittill("movedone");
}

_id_1C6B(var_0) {
  if(var_0 == "rack04") {
    return 1;
  }

  if(var_0 == "rack15") {
    return 1;
  }

  return 0;
}

_id_F27F() {
  var_0 = 0.75;
  var_1 = -54.0;

  while(self._id_9C5B) {
    self._id_4CD8 waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(isPlayer(var_3) && var_6 == "MOD_MELEE") {
      thread scripts\sp\utility::play_sound_on_entity("server_open");
      self moveTo(self.origin + self._id_BD2A * var_1, var_0, var_0 / 2, var_0 / 2);
      self._id_9C5B = 0;
      wait(var_0);

      if(isDefined(self._id_119E6) && self._id_119E6._id_9C5B == 0) {
        self connectpaths();
      } else if(isDefined(self._id_2EFF) && self._id_2EFF._id_9C5B == 0) {
        self connectpaths();
      }
    }

    wait 0.05;
  }
}

_id_F27E(var_0) {
  var_1 = _id_F278(var_0);
  var_2 = var_1._id_119E6;
  playFX(scripts\engine\utility::getfx("server_damage"), var_1.origin);

  if(var_1._id_9C5B) {
    var_1 moveTo(var_1.origin + var_1._id_BD2A * -54.0, 0.05);
  }

  if(var_2._id_9C5B) {
    var_2 moveTo(var_2.origin + var_2._id_BD2A * -54.0, 0.05);
  }

  var_1._id_9C5B = 0;
  var_2._id_9C5B = 0;
  wait 0.05;
  var_1 connectpaths();
}

_id_F278(var_0) {
  var_1 = undefined;

  foreach(var_3 in level._id_F277) {
    if(var_3.script_parameters == var_0) {
      return var_3;
    }
  }
}

_id_B204() {
  scripts\sp\maps\yard\yard_fx::_id_132CE(0);
  scripts\sp\maps\yard\yard_fx::_id_132D0(1);
  scripts\sp\maps\yard\yard_audio::_id_25EE("junction_spaced", "main");
  thread _id_A514();
  scripts\sp\utility::_id_28D7("axis");
  scripts\engine\utility::flag_wait("junction_spaced_end");
}

_id_3B7B() {}

_id_A518(var_0, var_1, var_2) {
  var_3 = scripts\sp\utility::_id_107EA(var_0);
  var_3._id_1FBB = var_1;
  var_3._id_28CF = 0;
  var_3.ignoreall = 1;

  if(var_2) {
    var_3 scripts\sp\utility::_id_23B7();
  } else {
    var_3 scripts\sp\utility::_id_72EC("iw7_sdfar", "primary");
  }

  return var_3;
}

_id_A514() {
  _id_BF14();
}

_id_BF14() {
  var_0 = scripts\engine\utility::getStruct("spaced_ap", "targetname");
  var_1 = scripts\sp\player_rig::get_player_score();
  var_0 scripts\sp\anim::_id_1EC3(var_1, "spaced_scene");
  level._id_D267 hide();
  var_2 = scripts\sp\utility::_id_10639("j_prop_ammo");
  var_3 = scripts\sp\utility::_id_10639("j_prop_missiles");
  var_4 = scripts\sp\utility::_id_10639("j_prop_grate");
  var_4 thread _id_1051C();
  var_5 = getEnt("yard_anim_vent", "targetname");
  var_5 hide();
  var_6 = getEnt("yard_anim_vent_new", "targetname");
  var_0 scripts\sp\anim::_id_1EC1([var_2, var_3, var_4], "spaced_scene");
  var_7 = getEnt("spaced_crate", "targetname");
  var_8 = getEnt("spaced_missiles", "targetname");
  var_7.angles = var_2 gettagangles("j_prop_1");
  var_8.angles = var_3 gettagangles("j_prop_1");
  var_7.origin = var_2 gettagorigin("j_prop_1");
  var_8.origin = var_3 gettagorigin("j_prop_1");
  var_7 linkTo(var_2, "j_prop_1");
  var_8 linkTo(var_3, "j_prop_1");
  var_5 linkTo(var_4, "j_prop_1");
  var_6 linkTo(var_4, "j_prop_1");
  scripts\sp\utility::_id_127B3("junction_spaced_enemies_trig");

  while(!istransientloaded("yard_central_tr")) {
    wait 0.05;
    waitforalltransients();
  }

  thread scripts\sp\maps\yard\yard_audio::_id_10523();
  var_9 = getaiarray("axis");

  foreach(var_11 in var_9) {
    var_11 delete();
  }

  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("yard_stop_crawl_hack");
  level notify("new_spaced_sequence");
  level notify("yard_junction_ammo_cleanup");
  var_13 = _id_A518("spaced_human_01", "spaced_guy_01", 0);
  var_14 = _id_A518("spaced_human_02", "spaced_guy_02", 0);
  var_15 = _id_A518("spaced_human_03", "spaced_guy_03", 0);
  var_16 = _id_A518("spaced_c12_01", "c12", 1);
  var_9 = [];
  var_9[var_9.size] = var_13;
  var_9[var_9.size] = var_14;
  var_9[var_9.size] = var_15;
  thread scripts\sp\maps\yard\yard_fx::_id_13355();
  var_13 thread scripts\sp\maps\yard\yard_fx::_id_13354();
  var_14 thread scripts\sp\maps\yard\yard_fx::_id_13354();
  var_15 thread scripts\sp\maps\yard\yard_fx::_id_13354();
  var_9[var_9.size] = var_16;
  var_9[var_9.size] = var_2;
  var_9[var_9.size] = var_3;
  level.player disableweapons();
  level.player _meth_823C(level._id_D267, "tag_player", 0.25);
  wait 0.25;
  level._id_D267 show();
  var_0 thread scripts\sp\anim::_id_1F35(var_4, "spaced_scene");
  thread _id_84C4(var_5, var_6);
  var_0 thread scripts\sp\anim::_id_1F35(level._id_D267, "spaced_scene");
  level._id_D267 thread _id_10525();
  level.player scripts\engine\utility::delaycall(2, ::setclienttriggeraudiozonepartialwithfade, "yard_cargo_fall_room_filtered", 1.5, "mix", "filter");
  level.player scripts\engine\utility::delaycall(8, ::clearclienttriggeraudiozone, 1.5);
  var_0 scripts\sp\anim::_id_1F2C(var_9, "spaced_scene");
  var_13 delete();
  var_14 delete();
  var_15 delete();
  var_16 delete();
  var_7 unlink();
  var_8 unlink();
  var_7 delete();
  var_8 delete();
  var_2 delete();
  var_3 delete();
  var_5 unlink();
  var_4 delete();
}

_id_84C4(var_0, var_1) {
  wait 1;
  var_0 show();
  var_1 hide();
}

_id_1051C() {
  self waittillmatch("single anim", "door_close");
  thread _id_10522();
  self waittillmatch("single anim", "airlock_open");
  thread _id_A515(self);
}

_id_10525() {
  thread _id_10524();
  self waittillmatch("single anim", "end");
  level._id_D267 hide();
  level.player unlink();
  scripts\engine\utility::waitframe();
  level.player setstance("stand");
  level.player enableweapons();
  level.player _meth_80A1();
}

_id_10524() {
  scripts\engine\utility::waittillmatch_any_return("single anim", "player_land", "land");
  thread _id_10520();
  scripts\engine\utility::exploder("vfx_yard_spaced_landing");
  level.player dodamage(10, level.player.origin);
  level.player _meth_80D1();
  level.player setstance("stand");
}

_id_10520() {
  _id_0B0A::_id_583F(0, 309.5, 4.25, 465, 733.25, 0.82, 0.05);
  wait 1.5;
  _id_0B0A::_id_583D(3.0);
}

_id_A517(var_0) {
  level.player _meth_84FD();
  level.player setstance("stand");
  level.player _meth_80D1();
  var_0 thread scripts\sp\anim::_id_1F35(level._id_D267, "spaced_player");
  wait 2.5;
  level._id_D267 _meth_83A1();
  level.player unlink();
  level._id_D267 delete();
  level.player enableweapons();
  level.player setstance("crouch");
  level.player scripts\engine\utility::allow_crouch(1);
}

_id_A516(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;
  self setcontents(0);
  var_6 = 4.5;
  var_7 = var_6 - var_5;
  wait(var_5);
  _id_0F1B::_id_1272D();
  self.dontmelee = 1;
  wait(var_7);
  _id_117F9(var_2, var_3, var_4);
}

_id_117F9(var_0, var_1, var_2) {
  self endon("death");
  self endon("deleted");
  self endon("removed");

  if(!isDefined(self)) {
    return;
  }
  self._id_C05C = 1;
  var_3 = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, self gettagorigin("j_SpineUpper"));
  var_4 = pointonsegmentnearesttopoint(var_1.origin, var_2.origin, self gettagorigin("j_SpineUpper"));
  var_5 = (var_3[0], var_3[1], var_4[2]);
  var_6 = vectorNormalize(var_5 - self gettagorigin("j_SpineUpper"));
  var_7 = 0.2;
  var_8 = 250;
  var_9 = distance2d(self.origin, var_5);
  var_10 = var_9 / var_8;
  var_11 = var_7 * var_10;
  wait(var_11);

  if(isDefined(self._id_B14F)) {
    scripts\sp\utility::_id_1101B();
  }

  self._id_13D68 = var_6 * 5000;
  self._id_4E46 = ::_id_1051E;
  scripts\sp\utility::_id_54C6();
  wait 17;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

_id_1051E() {
  scripts\anim\shared::_id_5D1A();
  self _meth_839B("torso_upper", self._id_13D68);
  return 1;
}

_id_A512() {
  wait 4;
  var_0 = getEnt("sliding_box", "targetname");
  var_0 thread _id_1051D(var_0.target);
}

_id_1051D(var_0) {
  var_1 = 0.5;

  if(!isDefined(var_0)) {
    self delete();
    return;
  }

  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  self moveTo(var_2.origin, var_1, 0, 0);
  self rotateTo(var_2.angles, var_1, 0, 0);
  wait(var_1);
  _id_1051D(var_2.target);
}

_id_A515(var_0) {
  var_1 = getEntArray("cargo_locked_door", "targetname");
  var_2 = scripts\engine\utility::getStruct("junction_spaced_door_light", "targetname");
  var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
  var_4 = scripts\engine\utility::getStruct("junction_spaced_door_wind", "targetname");
  var_5 = var_4 scripts\engine\utility::spawn_tag_origin();
  var_6 = getEnt("junction_space_door", "targetname");
  playFXOnTag(scripts\engine\utility::getfx("vfx_spaced_warning_light"), var_3, "tag_origin");
  playFX(level._effect["spaced_air"], var_4.origin);
  var_3 thread scripts\engine\utility::play_loop_sound_on_entity("spaced_scene_alarm");
  _id_10521();
  thread _id_104D1("open");
  thread scripts\sp\maps\yard\yard_util::_id_59B0("junction_spaced_outsidedoor", "z", -220, "generic_door_open", 0.5);
  var_5 thread scripts\engine\utility::play_loop_sound_on_entity("spaced_scene_wind");
  scripts\engine\utility::exploder("vfx_yard_spaced_decomp");
  playFXOnTag(scripts\engine\utility::getfx("vfx_spaced_wind"), var_5, "tag_origin");
  scripts\sp\utility::_id_EBA6(1, 0);
  var_0 waittillmatch("single anim", "airlock_close");
  var_5 delete();
  thread _id_104D1("close");
  scripts\sp\maps\yard\yard_util::_id_59B0("junction_spaced_outsidedoor", "z", 220, "generic_door_close", 2);
  wait 2;
  scripts\sp\utility::_id_E1F0();
  var_3 delete();
  level.player scripts\sp\utility::_id_1034D("yard_plr_thanksethan");
  scripts\sp\utility::_id_10350("yard_eth_thankyouinspite");
  level.player thread scripts\sp\utility::_id_1034D("yard_plr_metoo");
  level notify("open_spaced_doors");
  scripts\engine\utility::flag_set("junction_spaced_end");
  thread scripts\sp\utility::_id_1264E("yard_tram_tr");
}

_id_10522() {
  var_0 = getEnt("spaced_right", "targetname");
  var_1 = getEnt("spaced_left", "targetname");
  var_2 = var_1.origin;
  var_3 = var_0.origin;
  var_4 = scripts\engine\utility::getStruct("spaced_left_closed", "targetname");
  var_5 = scripts\engine\utility::getStruct("spaced_right_closed", "targetname");
  var_1 moveTo(var_4.origin, 1, 0);
  var_0 moveTo(var_5.origin, 1, 0);
  var_0 thread scripts\sp\utility::play_sound_on_entity("generic_door_close");
  level waittill("open_spaced_doors");
  var_6 = getEnt("spaced_door_clip_player_left", "targetname");
  var_7 = getEnt("spaced_door_clip_player_right", "targetname");
  var_6 linkTo(var_1);
  var_7 linkTo(var_0);
  var_1 moveTo(var_2, 1, 0);
  var_0 moveTo(var_3, 1, 0);
  var_0 thread scripts\sp\utility::play_sound_on_entity("generic_door_open");
}

_id_10521() {
  var_0 = getEntArray("spaced_door_large", "targetname");
  var_1 = getEnt("spaced_door_model_bottom", "targetname");
  var_2 = getEnt("spaced_door_model_upper", "targetname");

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_noteworthy) &var_4.script_noteworthy == "top") {
      var_2 linkTo(var_4);
      var_4 hide();
    }

    if(isDefined(var_4.script_noteworthy) &var_4.script_noteworthy == "bottom") {
      var_1 linkTo(var_4);
      var_4 hide();
    }
  }
}

_id_104D1(var_0) {
  var_1 = getEntArray("spaced_door_large", "targetname");
  var_2 = undefined;

  if(isDefined(var_0)) {
    if(var_0 == "open") {
      var_2 = 90;
    } else {
      var_2 = -90;
    }
  }

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_noteworthy) &var_4.script_noteworthy == "top") {
      var_4 movez(var_2, 1, 0, 0);
    }

    if(isDefined(var_4.script_noteworthy) &var_4.script_noteworthy == "bottom") {
      var_4 movez(var_2 * -1, 1, 0, 0);
    }
  }
}

_id_119BB() {
  var_0 = getEntArray("hangar_light", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 _meth_8134();

    if(var_3 == 0) {
      var_2 setlightintensity(300.0);
      var_2 _meth_82FC((1, 0.913, 0.69));
      continue;
    }

    var_2 setlightintensity(0.0);
  }
}

_id_BC6B() {
  self waittill("trigger");
  var_0 = scripts\sp\utility::_id_7A8F();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.classname == "script_brushmodel") {
      if(!isDefined(var_3._id_F8A3)) {
        var_3._id_F8A3 = 1;
        var_3.opened = 0;

        if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "opened") {
          var_3.opened = 1;
        }

        var_4 = getEntArray(var_3.target, "targetname");

        foreach(var_6 in var_4) {
          var_6 linkTo(var_3);
        }

        var_8 = scripts\engine\utility::getStruct(var_3.target, "targetname");
        var_3._id_BD2A = anglesToForward(var_8.angles);
      }

      var_1[var_1.size] = var_3;
    }
  }

  foreach(var_11 in var_1) {
    var_11 thread _id_BC6A();
  }
}

_id_BC6A() {
  scripts\sp\utility::script_delay();
  var_0 = 0.75;
  var_1 = 54;
  var_2 = "server_open";

  if(self.opened) {
    var_1 = var_1 * -1;
    self.opened = 0;
    var_2 = "server_close";
  }

  thread scripts\sp\utility::play_sound_on_entity(var_2);
  self moveTo(self.origin + self._id_BD2A * var_1, var_0, var_0 / 2, var_0 / 2);
  self waittill("movedone");

  if(self.opened) {
    self disconnectPaths();
  } else {
    self connectpaths();
  }
}

_id_F5EF() {
  var_0 = getEntArray("junction_door_1", "targetname");
  var_1 = getEntArray("junction_door_2", "targetname");
  var_2 = getEntArray("junction_door_3", "targetname");
  var_3 = getEntArray("junction_door_4", "targetname");
  var_4 = getEntArray("junction_door_5", "targetname");
  var_5 = getEntArray("junction_door_final", "targetname");
  var_6 = getEntArray("junction_door_fake", "targetname");
  var_7 = getEntArray("cargo_locked_door", "targetname");
  var_8 = [var_0, var_1, var_2];
  var_9 = [var_3, var_6, var_7, var_4];

  foreach(var_11 in var_8) {
    scripts\engine\utility::array_thread(var_11, scripts\sp\maps\yard\yard_util::_id_F595);
  }

  foreach(var_11 in var_9) {
    scripts\engine\utility::array_thread(var_11, scripts\sp\maps\yard\yard_util::_id_F594);
  }
}

_id_C9F0(var_0) {
  var_1 = getEntArray("corridor_door", "targetname");

  if(isDefined(var_0) && var_0 == "unlock") {
    foreach(var_3 in var_1) {
      if(isDefined(var_3.classname) && var_3.classname == "script_model") {
        if(scripts\sp\utility::hastag(var_3.model, "door_locked")) {
          var_3 hidepart("tag_locked", var_3.model);
          var_3 hidepart("door_inactive", var_3.model);
          var_3 showpart("tag_unlocked", var_3.model);
        }
      }
    }
  }

  if(isDefined(var_0) && var_0 == "locked") {
    foreach(var_3 in var_1) {
      if(isDefined(var_3.classname) && var_3.classname == "script_model") {
        if(scripts\sp\utility::hastag(var_3.model, "light_green")) {
          var_3 hidepart("tag_unlocked", var_3.model);
          var_3 hidepart("door_inactive", var_3.model);
          var_3 showpart("tag_locked", var_3.model);
        }
      }
    }
  }
}