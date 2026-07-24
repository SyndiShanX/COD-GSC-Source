/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\prisoner\prisoner_church.gsc
********************************************************/

_id_D83F() {
  scripts\engine\utility::flag_init("flag_church_outside_end");
  scripts\engine\utility::flag_init("flag_church_end");
  scripts\engine\utility::flag_init("flag_hvr_struggle_2_start");
  scripts\engine\utility::flag_init("flag_hvr_struggle_3_start");
  scripts\engine\utility::flag_init("flag_hvt_struggle_complete");
  scripts\engine\utility::flag_init("atom_entered_dropship");
  scripts\engine\utility::flag_init("flag_exfil_at_retribution");
  scripts\engine\utility::flag_init("flag_rafters_end");
  scripts\engine\utility::flag_init("bait_door_open");
  scripts\engine\utility::flag_init("hallway_runner_go");
  scripts\engine\utility::flag_init("rafters_entered");
  scripts\engine\utility::flag_init("entrance_player_spotted");
  scripts\engine\utility::flag_init("church_grenade_cancel");
  scripts\engine\utility::flag_init("window_dialogue");
  scripts\engine\utility::flag_init("annex_countdown_flag");
}

_id_D704() {}

_id_10BE8() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_church_outside");
  scripts\engine\utility::flag_set("enable_volumetrics");
  setsaveddvar("sm_sunEnable", 1);
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
  setsaveddvar("sm_sunCascadeSizeMultiplier1", 2);
  scripts\engine\utility::flag_set("sunshadow_churchend_on");
  setumbraportalstate("umbra_l_churchroad_view", 1);
  setumbraportalstate("umbra_r_churchroad_view", 1);
  setumbraportalstate("umbra_mdlf_courtyard_view", 0);
  setumbraportalstate("umbra_mdrt_courtyard_view", 0);
  setumbraportalstate("umbra_purseshop_view", 1);
  setumbraportalstate("umbra_bedroom_view", 0);
  setumbraportalstate("umbra_cafe_view", 0);
  setumbraportalstate("umbra_apartment_view", 0);
  scripts\engine\utility::flag_clear("portal_bedroom_view");
  scripts\engine\utility::flag_set("portal_churchroad_view");
  scripts\engine\utility::flag_clear("portal_mdlf_courtyard_view");
  scripts\engine\utility::flag_clear("portal_mdrt_courtyard_view");
  scripts\engine\utility::flag_set("portal_purseshop_view");
  scripts\engine\utility::flag_clear("portal_cafe_view");
  scripts\engine\utility::flag_clear("portal_apartment_view");
  scripts\sp\maps\prisoner\gen\prisoner_art::_id_10105();
}

_id_B1A7() {
  thread _id_3F4A();
  thread _id_3F32();
  thread _id_3F34();
  scripts\engine\utility::flag_wait("flag_church_outside_end");
  var_0 = getEnt("church_window_clip", "targetname");
  var_0 movez(-256, 0.05);
}

_id_3F4A() {
  scripts\sp\utility::_id_28D7("axis");
}

_id_3F32() {
  setmusicstate("mx_245_prisoner_church");
  var_0 = scripts\sp\utility::_id_22CD("enemy_church_lobby_guards", 1);
  scripts\sp\utility::_id_127AE("church_entrance_window_dialogue_trig", "targetname");
  thread _id_13D56(var_0);
  level notify("player_headed_inside");
  scripts\engine\utility::array_thread(var_0, ::_id_AEB2);
  scripts\sp\utility::_id_127AE("church_atwindow_trig", "targetname");
  var_1 = scripts\engine\utility::getStruct("lobbylookat", "targetname");

  while(!level.player scripts\sp\utility::_id_D1DF(var_1.origin, 0.01, 1) && !scripts\engine\utility::flag("flag_church_outside_end")) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_wait_any("entrance_player_spotted", "flag_church_outside_end");

  if(isalive(var_0[0])) {
    scripts\engine\utility::play_sound_in_space("pris_sd_2a_exposed_acquired", var_0[0].origin + (0, 0, 70));
  } else if(isalive(var_0[1])) {
    scripts\engine\utility::play_sound_in_space("pris_sd_2a_exposed_acquired", var_0[1].origin + (0, 0, 70));
  }

  scripts\engine\utility::flag_wait_any("lobby_death_1", "lobby_death_2");
  wait 0.25;
  var_2 = scripts\sp\utility::_id_107EA("enemy_church_lobby_backup", 1);
  var_2.goalradius = 64;
  var_3 = getnode("church_node_01", "targetname");
  var_2 _meth_82EE(var_3);
  var_4 = getEnt("church_lobby_door", "targetname");
  var_4.clip = getEnt("lobby_door_clip", "targetname");
  var_4.clip linkTo(var_4);
  var_4 rotateYaw(-90, 0.75);
  var_4 playSound("church_door_open");
  var_4 waittill("rotatedone");
  var_4.clip connectpaths();
  var_4.clip delete();
  var_5 = getnode("lobby_exposed", "targetname");
  var_2 _meth_82EE(var_5);
}

_id_AEB2() {
  if(isalive(self)) {
    self endon("death");
    self.ignoreall = 1;
    self addaieventlistener("grenade danger");
    self addaieventlistener("gunshot");
    self addaieventlistener("gunshot_teammate");
    self addaieventlistener("silenced_shot");
    self addaieventlistener("bulletwhizby");
    self addaieventlistener("projectile_impact");
    self addaieventlistener("explode");
  }

  scripts\sp\utility::_id_127AE("church_atwindow_trig", "targetname");
  scripts\engine\utility::waittill_any_timeout(2.0, "ai_events", "flag_church_outside_end");

  if(isalive(self)) {
    self.ignoreall = 0;
  }

  scripts\engine\utility::flag_set("entrance_player_spotted");
}

_id_13D56(var_0) {
  scripts\engine\utility::flag_set("window_dialogue");

  if(isalive(var_0[0])) {
    thread scripts\engine\utility::play_sound_in_space("prisoner_sf2_wecantletany", var_0[0].origin + (0, 0, 70));
    wait 2;
  }

  if(isalive(var_0[1]) && isalive(var_0[0])) {
    scripts\engine\utility::play_sound_in_space("prisoner_sf1_siryessir", var_0[1].origin + (0, 0, 70));
  }
}

_id_3F34() {
  thread _id_3F33();
  level endon("player_headed_inside");
  thread _id_13D62();
  var_0 = 1;
  scripts\engine\utility::flag_wait("hvt_inside_church");
  thread _id_1FF0();

  while(var_0 || !scripts\engine\utility::flag("annex_countdown_flag")) {
    var_1 = getaicount("axis", "all");

    if(var_1 <= 2) {
      var_0 = 0;
    }

    wait 0.1;
  }

  wait 1.0;
  var_2 = scripts\engine\utility::getStruct("chuch_lobbyguy_animorigin", "targetname");
  wait 1.0;

  if(!scripts\engine\utility::flag("window_dialogue")) {
    level.player scripts\sp\utility::_id_1034D("prisoner_plr_thismustbethean");
  }

  wait 10.0;
  level notify("marker_on");
  level.player scripts\sp\utility::_id_1034D("prisoner_plr_gottagetinside");
}

_id_1FF0() {
  wait 10;
  scripts\engine\utility::flag_set("annex_countdown_flag");
}

_id_13D62() {
  level waittill("marker_on");
  var_0 = scripts\engine\utility::getStruct("church_entrance_window_marker_spot", "targetname");
  objective_add(scripts\sp\utility::_id_C264("window_nag_marker"), "current", "", var_0.origin);
  var_1 = getEnt("church_entrance_window_marker_near", "targetname");
  var_1 waittill("trigger");
  objective_delete(scripts\sp\utility::_id_C264("window_nag_marker"));

  while(level.player istouching(var_1)) {
    wait 0.5;
  }
}

_id_3F33() {
  scripts\sp\utility::_id_127AE("church_atwindow_trig", "targetname");
  objective_delete(scripts\sp\utility::_id_C264("window_nag_marker"));
  level notify("church_atwindow_trig");
}

_id_10BE3() {
  var_0 = getEnt("church_lobby_door", "targetname");
  var_0 rotateYaw(-90, 0.05, 0, 0);
  var_0.clip = getEnt("lobby_door_clip", "targetname");
  var_0.clip delete();
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_church");
  var_1 = getEnt("church_window_clip", "targetname");
  var_1 movez(-256, 0.05);
  scripts\engine\utility::flag_set("enable_volumetrics");
  setsaveddvar("sm_sunEnable", 0);
}

_id_B1A2() {
  scripts\sp\maps\prisoner\prisoner_courtyard::_id_4064();
  thread _id_3F49();
  level.player scripts\sp\utility::_id_2B76(0.8, 0.05);
  thread _id_3F3D();
  thread _id_3F40();
  thread _id_3F38();
  thread _id_3F3B();
  thread _id_3F48();
  thread _id_3F36();
  thread _id_3F41();

  foreach(var_1 in level._id_125D6) {
    scripts\sp\utility::_id_1264E(var_1);
    wait 0.1;
  }

  thread pc_transient_wait_church();
  scripts\sp\utility::_id_12641("prisoner_church_interior_tr");
  scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_BF97, undefined, 0, 0);
  scripts\engine\utility::flag_wait("flag_church_end");
}

pc_transient_wait_church() {
  if(!level.console) {
    scripts\sp\utility::_id_127AE("church_running_above_trig", "targetname");
    wait 5;
    waitfortransient("prisoner_church_interior_tr");
  }
}

_id_3F49() {
  var_0 = getEntArray("church_ext_light", "targetname");

  foreach(var_2 in var_0) {
    var_2 _meth_8300(13);
  }

  var_4 = getEntArray("church_int_light", "targetname");

  foreach(var_2 in var_4) {
    if(isDefined(var_2.script_noteworthy)) {
      var_2 setlightintensity(int(var_2.script_noteworthy));
    }
  }
}

_id_3F3D() {
  scripts\sp\utility::_id_2669("church_bottom");
  scripts\sp\utility::_id_127AE("church_running_above_trig", "targetname");
  wait 0.25;
  var_0 = scripts\sp\utility::_id_22CD("enemy_church_antechamber", 1);
  var_1 = scripts\sp\utility::_id_107EA("antechamber_stairs");
  var_1.ignoreall = 1;

  if(isalive(var_0[0])) {
    scripts\engine\utility::play_sound_in_space("prisoner_sf1_lookforhostiles", var_0[0].origin + (5, 0, 30));
  }

  var_0[0] scripts\sp\utility::_id_51E1("cqb");
  var_0[1] scripts\sp\utility::_id_51E1("cqb");
  scripts\engine\utility::flag_set("hallway_runner_go");
  scripts\sp\utility::_id_127AE("church_stairs_alert", "targetname");

  if(isalive(var_1)) {
    var_1.ignoreall = 0;
  }
}

_id_AEB3() {
  level endon("door_kick_open");
  level endon("church_lobby_hallway_doordoor_kick_start");

  for(;;) {
    var_0 = _id_0B1E::_id_794C("church_lobby_hallway_door");

    if(isDefined(var_0) && var_0 >= 15) {
      level notify("door_kick_open");
    }

    wait 0.05;
  }
}

_id_3F40() {
  scripts\sp\utility::_id_127AE("church_running_above_trig", "targetname");
  var_0 = scripts\engine\utility::getStructArray("church_running_above_fx", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getfx(var_2.script_noteworthy);
    var_4 = var_2.script_delay;
    scripts\engine\utility::noself_delaycall(var_4, ::playfx, var_3, var_2.origin, anglesToForward(var_2.angles), anglestoup(var_2.angles));
  }
}

_id_C7F5(var_0, var_1, var_2, var_3) {
  if(var_3 == "walk") {
    var_4 = 0.7;
    var_5 = "step_walk_up_wood";
  } else {
    var_4 = 0.3;
    var_5 = "step_run_up_wood";
  }

  if(var_2 >= var_4) {
    var_6 = var_2 / var_4;
  } else {
    var_6 = 1;
  }

  var_7 = spawn("script_model", var_0);
  wait 0.02;
  var_7 moveTo(var_1, var_2);

  for(var_8 = 0; var_8 < var_6; var_8++) {
    var_7 playSound(var_5);
    level.player _id_1E87(var_7, var_3);
    wait(var_4);
  }

  var_7 delete();
}

_id_1E87(var_0, var_1) {
  var_2 = var_0.origin - level.player getshootatpos();
  var_2 = vectorNormalize(var_2);
  var_3 = 360 - vectortoangles(var_2)[0];

  if(var_3 > 10 && var_3 < 90) {
    if(var_1 == "walk") {
      var_0 playSound("step_walk_up_wood_creak");
    } else {
      var_0 playSound("step_run_up_wood_creak");
    }
  }
}

_id_3F36() {
  var_0 = getEnt("church_running_above_trig", "targetname");
  var_0 waittill("trigger");
  playworldsound("church_plywood_dist", (-5425, -16044, -734));
  scripts\engine\utility::delaythread(0.1, ::_id_C7F5, (-5186, -15843, -734), (-5386, -16140, -638), 1.5, "run");
  scripts\engine\utility::delaythread(3.5, ::_id_C7F5, (-5272, -15803, -626), (-5527, -15831, -626), 5.5, "walk");
  scripts\engine\utility::delaythread(2.0, scripts\engine\utility::play_sound_in_space, "scn_church_footsteps_staircase", (-5291, -16110, -678));
}

_id_3F38() {
  var_0 = getEnt("enemy_church_grenade_trig", "targetname");
  var_0 waittill("trigger");
  thread _id_D656();
  wait 0.1;
  level._id_8588 = scripts\sp\utility::_id_107EA("enemy_church_grenade", 1);
  level._id_8588 scripts\sp\utility::_id_51E1("sprint");
  level._id_8588 scripts\sp\utility::_id_5564();
  var_1 = scripts\engine\utility::getStruct("church_grenade_start", "targetname");
  var_2 = scripts\engine\utility::getStruct("church_grenade_end", "targetname");
  var_0 = getEnt("trig_sound_door_slam", "targetname");
  var_0 waittill("trigger");

  if(isalive(level._id_8588)) {
    thread scripts\engine\utility::play_sound_in_space("prisoner_ria_wereoutoftimesc", var_1.origin);
  }

  wait 1.0;

  if(isalive(level._id_8588)) {
    var_3 = vectorNormalize(var_2.origin - var_1.origin) * 350;
    var_4 = magicgrenademanual("frag", var_1.origin, var_3, 3);
    level._id_8588 notify("grenade_fire", var_4, "frag");
    wait 4.5;

    if(!scripts\engine\utility::flag("church_grenade_cancel") && isalive(level._id_8588)) {
      var_3 = vectorNormalize(var_2.origin - var_1.origin) * 350;
      var_4 = magicgrenademanual("frag", var_1.origin, var_3, 3);
      level._id_8588 notify("grenade_fire", var_4, "frag");
    }

    wait 2;

    if(isalive(level._id_8588)) {
      level._id_8588 scripts\sp\utility::_id_6224();
    }
  }
}

_id_3F3B() {
  scripts\engine\utility::flag_init("player_in_the_library");
  scripts\sp\utility::_id_127AE("church_interact_bait_trig", "targetname");
  scripts\engine\utility::flag_set("player_in_the_library");
  thread _id_AC45();
  scripts\sp\utility::_id_127AE("church_shotgun_bot_trig", "targetname");
  thread church_library_radio_start();
  wait 0.1;
  var_0 = scripts\sp\utility::_id_107EA("church_bait_door_c6", 1);
  thread _id_8806();
  var_1 = scripts\sp\utility::_id_22CD("library_guys", 1);
  wait 0.01;
  level._id_3F2D playSound("pnr_emt_wood_barrier_destr");
  level._id_3F2D rotateYaw(128, 0.25, 0, 0.0);
  scripts\engine\utility::flag_set("bait_door_open");
  wait 0.25;
  level._id_3F2D.clip connectpaths();
  var_0 scripts\sp\utility::_id_F3DD(10);
  var_0 setgoalentity(level.player, 500);
  wait 0.5;
  level._id_3F2D rotateYaw(-10, 1, 0, 0.0);
  scripts\sp\utility::_id_13753(var_1);
  scripts\sp\utility::_id_2669("church_middle");
}

church_library_radio_start() {
  level endon("stoplibrary_radio");

  for(;;) {
    var_0 = randomfloatrange(5.0, 7.0);
    wait(var_0);
    thread scripts\engine\utility::play_sound_in_space("prisoner_sf1_church_radio", (-5136, -15474, -616));
  }
}

_id_8806() {
  level endon("belfry_entered");
  scripts\engine\utility::flag_wait("flag_church_end");
  var_0 = _id_0E29::_id_87F3();

  if(isDefined(var_0.targetname) && var_0.targetname == "church_bait_door_c6") {
    _id_0E29::_id_87E0(3);
  }
}

_id_D656() {
  level._id_3F2D = getEnt("church_bait_door", "targetname");
  level._id_3F2D.clip = getEnt("church_bait_door_clip", "targetname");
  level._id_3F2D.clip linkTo(level._id_3F2D);
  level._id_3F2D rotateYaw(70, 0.05, 0, 0.0);
  level._id_B00B = scripts\engine\utility::getStruct("church_bait_door_interact", "targetname");

  while(!scripts\engine\utility::flag("player_in_the_library") && !level.player scripts\sp\utility::_id_D1DF(level._id_B00B.origin, 0.5)) {
    scripts\engine\utility::waitframe();
  }

  level._id_3F2D rotateYaw(-70, 1.5, 0, 0.0);
  wait 1.5;
  level._id_B00B _id_0E46::_id_48C4(undefined, undefined, undefined, undefined, 700, 10);
  scripts\sp\utility::_id_127AE("church_shotgun_bot_trig", "targetname");
  level._id_B00B _id_0E46::_id_DFE3();
}

_id_AC45() {
  scripts\engine\utility::play_sound_in_space("prisoner_sf1_wellholdthispos", (-5202.7, -15230.4, -641));
}

_id_AC46() {
  level._id_3F2D rotateYaw(20, 0.5, 0, 0.0);
  wait 0.5;
  level._id_3F2D rotateYaw(-20, 0.5, 0, 0.0);
}

_id_3F3A() {
  scripts\engine\utility::flag_wait("flag_church_end");
  var_0 = getEnt("church_attic_ladder", "targetname");
  thread scripts\engine\utility::play_sound_in_space("prisoner_chruch_ladder_fall_start", (-5217, -15820, -166));
  var_0 rotateroll(-113, 1.5, 0.5, 0);
  wait 1.5;
  thread scripts\engine\utility::play_sound_in_space("prisoner_chruch_ladder_fall_end", (-5339, -15998, -294));
  var_0 rotateroll(2, 0.2, 0, 0);
  wait 0.2;
  var_0 rotateroll(-2, 0.15, 0, 0);
  var_1 = scripts\engine\utility::getStruct("rafters_hvr_tease_spot1", "targetname");
  wait 1;
  scripts\engine\utility::play_sound_in_space("prisoner_sf1_getcommandertot", (-5217, -15820, -166));
  wait 1;
  var_2 = scripts\engine\utility::getStruct("church_rafters_tabletguy_animorigin", "targetname");
  thread scripts\engine\utility::play_sound_in_space("prisoner_ria_powerthegenerat", var_2.origin);
  level thread scripts\sp\utility::_id_BF98();
}

_id_3F48() {
  scripts\sp\utility::_id_127AE("church_hvt_attic_tease", "targetname");
  var_0 = scripts\engine\utility::getStruct("attic_hvr_tease_spot1", "targetname");
  var_1 = scripts\engine\utility::getStruct("attic_hvr_tease_spot2", "targetname");
  var_2 = scripts\engine\utility::getStruct("hvt_stair_glimpse", "targetname");
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("hvt", 1);
  level._id_920F.ignoreall = 1;
  level._id_920F scripts\sp\utility::_id_F3E0(35);
  level._id_920F setgoalpos(var_1.origin);
  level._id_920F _meth_80F1(var_0.origin, var_0.angles, 1000000);
  level._id_920F playSound("prisoner_hvt_church_stairs");
  level._id_920F thread scripts\sp\utility::_id_10346("pris_sd_1_exposed_breaking");
  wait 2;
  var_3 = _id_0E26::_id_107D2(var_1.origin, var_1.angles, "axis", level.player);
  var_3.moveplaybackrate = 0.75;
  level.player scripts\sp\utility::_id_1034D("prisoner_plr_sonofa");
  level._id_920F waittill("goal");
  var_4 = scripts\engine\utility::getStruct("rafters_hvr_tease_spot1", "targetname");
  level._id_920F _meth_80F1(var_4.origin, var_4.angles, 1000000);
  level._id_920F scripts\sp\utility::_id_1101B();
  level._id_920F delete();
}

_id_3F42() {
  setmusicstate("");
  var_0 = scripts\engine\utility::getStruct("church_table_flip_ap", "targetname");
  var_1 = getEnt("table_flip", "targetname");
  var_1 scripts\sp\utility::_id_23B7("church_table");
  var_1.clip = getEnt("table_flip_clip", "targetname");
  var_1.clip linkTo(var_1);
  var_0 scripts\sp\anim::_id_1EC3(var_1, "church_table_anim");
  scripts\sp\utility::_id_127AE("church_rafters_enter_trigger", "targetname");

  if(isalive(level._id_113B1)) {
    var_0 thread scripts\sp\anim::_id_1F35(var_1, "church_table_anim");
    var_2 = [var_1];
    var_1.clip connectpaths();
    wait 1.6;
    var_1.clip disconnectPaths();
  }

  scripts\engine\utility::flag_set("rafters_entered");
}

_id_3F41() {
  var_0 = getEnt("trig_sound_moving_objects_footsteps", "targetname");
  var_0 waittill("trigger");
  playworldsound("church_moving_objects_dist", (-5080, -15588, -138));
  scripts\engine\utility::delaythread(1.5, ::_id_C7F5, (-5080, -15588, -138), (-5032, -15258, -138), 8.5, "walk");
}

_id_10BEA() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_church_rafters");
  scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_BF97, undefined, 0, 0);
  scripts\engine\utility::flag_set("enable_volumetrics");
  setsaveddvar("sm_sunEnable", 0);
}

_id_B1A9() {
  scripts\engine\utility::flag_init("flag_rafters_go_loud");
  level._id_5992 = getEnt("fake_peek_church", "targetname");
  thread _id_2549();
  thread _id_2A8C();
  thread _id_3F3A();
  thread _id_3F42();
  scripts\engine\utility::flag_wait("flag_rafters_end");
}

_id_2549() {
  level._id_254A = scripts\sp\utility::_id_22CD("enemy_church_rafters1");
  level._id_113B1 = scripts\sp\utility::_id_107EA("enemy_church_table_flipper");
  level._id_254A = scripts\engine\utility::array_add(level._id_254A, level._id_113B1);

  foreach(var_1 in level._id_254A) {
    var_1.ignoreall = 1;
  }

  scripts\sp\utility::_id_127AE("church_rafters_enter_trigger", "targetname");
  level notify("entered_rafters");
  thread _id_2548();
  wait 2.0;

  foreach(var_1 in level._id_254A) {
    if(isalive(var_1)) {
      var_1.ignoreall = 0;
    }

    wait 0.2;
  }
}

_id_2548() {
  wait 1.0;
  level endon("chatter_played");

  foreach(var_1 in level._id_254A) {
    if(isDefined(var_1)) {
      scripts\engine\utility::play_sound_in_space("pris_sd_5_callout_clock_6", var_1.origin + (0, 0, 70));
      level notify("chatter_played");
    }
  }
}

_id_2A8C() {
  scripts\sp\utility::_id_127B3("trig_bells_enemy_spawn");
  var_0 = scripts\sp\utility::_id_22CD("enemy_church_bells1");
  var_0[0] scripts\sp\utility::_id_51E1("sprint");
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), var_0[0], "tag_flash");
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), var_0[0], "tag_flash");
  scripts\sp\utility::_id_127B3("trig_bells_enemy2_run");
}

_id_10BE5() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_church_hvr_finale");
  scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_BF97, undefined, 0, 0);
  scripts\sp\maps\prisoner\prisoner_hvt_scene::_id_D75A();
  scripts\engine\utility::flag_set("enable_volumetrics");
  setsaveddvar("sm_sunEnable", 0);
}

_id_B1A4() {
  wait 0.5;
  scripts\sp\maps\prisoner\prisoner_hvt_scene::_id_9240();
}