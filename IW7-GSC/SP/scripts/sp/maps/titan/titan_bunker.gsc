/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_bunker.gsc
**************************************************/

_id_BA5F() {
  scripts\engine\utility::trigger_off("bunker_kill_volume", "targetname");
  var_0 = getnode("omar_bunker_tp", "targetname");
  var_1 = getnode("atom_bunker_tp", "targetname");
  var_2 = getnode("marine_1_bunker_tp", "targetname");
  var_3 = getnode("marine_2_bunker_tp", "targetname");
  scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("bunker_intro_spawn", "targetname"));
  scripts\sp\maps\titan\titan_code::_id_10733();
  level._id_C24B = scripts\sp\utility::_id_107EA("nunez");
  level._id_C24B._id_1FBB = "nunez";
  level._id_C24B.name = "Nunez";
  level._id_C24B scripts\sp\utility::_id_B14F(1);
  var_4 = [level._id_C47F, level._id_B33B, level._id_B33E, level._id_2429, level._id_C24B];
  level._id_DE2F = [];
  var_5 = getEntArray("bunker_door_redshirts", "targetname");

  foreach(var_7 in var_5) {
    var_8 = var_7 scripts\sp\utility::_id_10619(1);
    var_8._id_1FBB = var_7.script_noteworthy;
    var_8 scripts\sp\utility::_id_F2DA(0);
    level._id_DE2F[level._id_DE2F.size] = var_8;
  }

  level._id_3277 = scripts\engine\utility::array_combine(level._id_DE2F, var_4);
  level._id_C47F _meth_80F1(var_0.origin, var_0.angles);
  level._id_2429 _meth_80F1(var_1.origin, var_1.angles);
  level._id_B33B _meth_80F1(var_2.origin, var_2.angles);
  level._id_B33E _meth_80F1(var_3.origin, var_3.angles);
  thread _id_3B80();
}

_id_C82E(var_0) {}

_id_BA5D() {
  thread _id_D1FE();
  thread _id_326E();
  thread _id_5571();
  _id_BA60();
  level._id_3277 = scripts\engine\utility::array_remove(level._id_3277, level._id_C24B);
  level notify("commence_elevator_logic");
}

_id_5571() {
  level.player scripts\engine\utility::allow_fire(0);
  level.player scripts\engine\utility::allow_offhand_primary_weapons(0);
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  scripts\engine\utility::flag_wait("player_opened_ow_door");
  level.player scripts\engine\utility::allow_fire(1);
  level.player scripts\engine\utility::allow_offhand_primary_weapons(1);
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
}

_id_326E() {
  level endon("player_opened_ow_door");
  thread _id_3275(3.2);
  thread _id_3275(11.6);
  thread _id_3275(16.55);
  thread _id_3275(27.2);
  thread _id_3275(36.5);
  thread _id_3275(42);
  thread _id_3275(50.2);
  level waittill("player_on_elevator");

  for(;;) {
    wait(randomfloatrange(5, 8));
    _id_3275(0);
  }
}

_id_3275(var_0) {
  var_1 = 800;
  wait(var_0);
  playworldsound("scn_titan_bunker_quake_lr", level.player.origin);
  earthquake(randomfloatrange(0.1, 0.15), randomfloatrange(1.8, 2.8), level.player.origin, 9999);
}

_id_3281() {
  var_0 = scripts\sp\hud_util::createfontstring("objective", 1.8);
  var_0 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 0, 0);
  var_1 = gettime();

  for(;;) {
    var_2 = gettime() - var_1;
    var_2 = var_2 / 1000;
    var_0 settext(var_2);
    wait 0.05;
  }
}

_id_BA60() {
  level.player scripts\sp\utility::_id_F526("relaxed");
  thread _id_3B80();
  var_0 = getEnt("bunker_scene_gate", "targetname");
  var_1 = scripts\engine\utility::getStruct("bunker_gate_animNode", "targetname");
  var_1 thread _id_3271(var_0);

  for(var_2 = 0; var_2 < level._id_DE2F.size; var_2++) {
    var_3 = var_2 + 1;
    level._id_DE2F[var_2]._id_1FBB = scripts\sp\utility::string("redshirt" + var_3);
  }

  foreach(var_5 in level._id_10AC8) {
    var_5 _meth_83A1();
    var_5 scripts\sp\utility::_id_61C7();
    var_5 scripts\sp\utility::_id_F3B5("orange");
  }

  foreach(var_5 in level._id_DE2F) {
    var_5 _meth_83A1();
    var_5 scripts\sp\utility::_id_61C7();
    var_5 scripts\sp\utility::_id_F3B5("blue");
  }

  scripts\sp\utility::_id_15F1("initial_bunker_colors", "targetname");
  var_9 = getEnt("bunker_buddy_door", "targetname");

  if(!isDefined(level._id_C24B)) {
    level._id_C24B = scripts\sp\utility::_id_107EA("nunez");
    level._id_C24B._id_1FBB = "nunez";
    level._id_C24B.name = "Nunez";
  }

  foreach(var_5 in level._id_3277) {
    var_5 thread _id_3276(var_1);
    var_5.script_pushable = 0;
  }

  thread _id_CD64();
  thread _id_326F();
  level._id_2429 waittill("unlock_elevator");
}

_id_CD64() {
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("titan_hud_kotch_pip_01_full");

  while(!iscinematicplaying())
    scripts\engine\utility::waitframe();

  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  stopcinematicingame();
}

_id_F99B(var_0) {
  var_1 = getEnt("mco_light", "targetname");
  var_2 = getEnt("kashima_light", "targetname");
  var_3 = getEnt("brooks_light", "targetname");
  var_4 = getEnt("redshirt1_light", "targetname");
  var_5 = getEnt("redshirt2_light", "targetname");
  var_1 linkTo(level._id_C47F, "TAG_EYE", (2, 0, 1), (150, 0, 0));
  var_2 linkTo(level._id_B33B, "TAG_EYE", (2, 0, 1), (150, 0, 0));
  var_3 linkTo(level._id_B33E, "TAG_EYE", (2, 0, 1), (150, 0, 0));
  var_4 linkTo(var_0[0], "TAG_EYE", (2, 0, 1), (150, 0, 0));
  var_5 linkTo(var_0[1], "TAG_EYE", (2, 0, 1), (150, 0, 0));
}

_id_3276(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_0 = var_1;

  if(self == level._id_C24B) {
    scripts\sp\utility::_id_86E4();
    self.name = "";
    thread _id_C24C();
    scripts\engine\utility::waitframe();
    level notify("toggle_nunez_head");
  }

  var_0 scripts\sp\anim::_id_1F35(self, "bunker_scene");

  if(self == level._id_C47F) {
    level._id_C47F scripts\sp\interaction::_id_CD4F("bunker_omar_react");
    thread _id_8C5E();
    var_0 scripts\sp\anim::_id_1F35(self, "bunker_scene_cont");
    thread _id_CCBC(var_0);
  }

  if(self == level._id_C24B) {
    var_0 scripts\sp\anim::_id_1EE0(level._id_C24B, "bunker_scene");
    return;
  }

  if(self == level._id_2429) {
    scripts\sp\utility::_id_51E1("casual_gun");
    self setgoalpos(self.origin);
    var_2 = ["titan_plr_ethanyourewithm", "titan_eth_ayesir"];
    scripts\sp\maps\titan\titan_code::_id_48BD(var_2);
    wait 1;
    level._id_2429 notify("unlock_elevator");
    scripts\engine\utility::flag_set("obj_flag_heavy_weapon");
  } else
    var_0 thread scripts\sp\anim::_id_1EEA(self, "bunker_scene_idle", "stop_bunker_idle");

  level waittill("player_on_elevator");

  if(self == level._id_2429) {
    return;
  }
  var_0 notify("stop_bunker_idle");
  var_0 scripts\sp\anim::_id_1F35(self, "bunker_scene_exit");
}

_id_C24C() {
  var_0 = getEnt("nunez_head_coll", "targetname");
  var_0 connectpaths();
  var_0 notsolid();
  level waittill("toggle_nunez_head");
  var_0 disconnectPaths();
  var_0 solid();
}

_id_3271(var_0) {
  var_0._id_1FBB = "bunker_gate";
  var_0 scripts\sp\anim::_id_F64A();
  level waittill("player_on_elevator");
  scripts\sp\anim::_id_1F35(var_0, "bunker_scene_exit");
}

_id_CCBC(var_0) {
  level endon("player_on_elevator");

  for(;;) {
    wait(randomfloatrange(6, 10));

    if(scripts\engine\utility::cointoss()) {
      var_0 notify("stop_bunker_idle");
      var_0 scripts\sp\anim::_id_1F35(level._id_C47F, "bunker_nag");
      var_0 thread scripts\sp\anim::_id_1EEA(level._id_C47F, "bunker_scene_idle", "stop_bunker_idle");
      continue;
    }

    scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_thiswaysir");
  }

  var_0 notify("stop_bunker_idle");
}

_id_8C5E() {
  thread scripts\sp\utility::_id_7799(level.player, 1.25, 0.5);
  thread scripts\sp\utility::_id_7792(level.player);
  level waittill("player_on_elevator");
  self notify("start_gesture_lookat");
  self notify("eye_gesture_stop");
}

_id_326F() {
  scripts\engine\utility::exploder("jackal_cloud_ceiling");
  scripts\engine\utility::exploder("fx_background_mist_1");
  scripts\sp\utility::_id_10FEC("fx_background_mist_1_opt");
  scripts\sp\utility::_id_10FEC("refinery_clouds_top");
  scripts\sp\utility::_id_10FEC("mons_clouds");
  scripts\sp\utility::_id_10FEC("mons_clouds_4");
  wait 7;
  scripts\engine\utility::exploder("hit1");
  wait 7;
  scripts\engine\utility::exploder("hit2");
  wait 1;
  scripts\engine\utility::exploder("pmd exp");
}

_id_D1FE() {
  var_0 = getEnt("elevator_door", "targetname");
  var_1 = getEnt("elevator_door_col", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  if(isDefined(var_1))
    var_1 delete();

  var_2 = scripts\engine\utility::getStruct("bunker_exit", "targetname");
  var_3 = getEnt("ai_exit_door_col", "targetname");
  var_4 = getEnt("bunker_elevator", "targetname");
  var_1 = getEnt("bunker_elevator_door_col", "targetname");
  var_5 = getEnt("bunker_elevator_col", "targetname");
  var_0 = _id_7885();
  var_6 = getEnt("overwatch_player_gate", "targetname");
  var_7 = getEnt("player_in_elevator", "targetname");
  thread _id_6056();
  var_5 linkTo(var_4);
  var_1 linkTo(var_4);
  var_4 scripts\sp\anim::_id_1EC1(var_0, "elevator_door_open");
  level waittill("commence_elevator_logic");
  var_3 connectpaths();
  var_8 = getEnt("elevator_panel_03", "targetname");
  var_8 playSound("scn_titan_elevator_gate_open");
  var_4 thread scripts\sp\anim::_id_1F2C(var_0, "elevator_door_open");
  wait 0.25;
  level._id_2429 _meth_83A1();
  level._id_2429 scripts\sp\utility::_id_51E1("casual_gun");
  level._id_2429 scripts\sp\utility::_id_F3DD(32);
  level._id_2429 scripts\sp\utility::_id_54F7();
  level._id_2429 _meth_82EE(getnode("eth3n_elevator_pathnode", "targetname"));
  level._id_2429 waittill("goal");
  scripts\engine\utility::waitframe();
  level._id_2429 thread _id_0C4C::_id_1955(level.player, 2.0, 1.0);
  wait 2.5;
  level._id_2429 thread _id_0C4C::_id_195D(level.player);
  scripts\sp\utility::_id_127AE("player_in_elevator", "targetname");

  for(;;) {
    if(level.player istouching(var_1) != 1 && level.player istouching(var_7) && level._id_2429 istouching(var_7)) {
      break;
    }

    wait 0.05;
  }

  level notify("player_on_elevator");
  level.player scripts\sp\utility::_id_F526("normal");
  var_8 playSound("scn_titan_elevator_gate_close");
  var_4 scripts\sp\anim::_id_1F2C(var_0, "elevator_door_close");

  foreach(var_10 in var_0)
  var_10 linkTo(var_4);

  level._id_2429 linkTo(var_4);
  var_3 notsolid();
  var_3 connectpaths();
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_omr_seeyoutwoinhell");
  scripts\sp\maps\titan\titan_code::_id_D1D5("titan_plr_countonit");
  scripts\sp\utility::_id_15F1("bunker_exit_colors", "targetname");
  thread _id_60B5();
  thread _id_887E();
  var_4 thread _id_60CD();
  var_4 waittill("at_top");
  level notify("player_exit_elevator");

  if(isDefined(level._id_739C)) {
    level._id_739C _meth_83A1();
    level._id_739C._id_B14F = 0;
    level._id_739C delete();
  }

  var_12 = getaiarray("allies");
  var_12 = scripts\engine\utility::array_remove(var_12, level._id_2429);
  var_13 = getaiarray("axis");

  foreach(var_15 in var_12) {
    if(isDefined(var_15) && isalive(var_15))
      var_15 delete();
  }

  foreach(var_15 in var_13) {
    if(isDefined(var_15) && isalive(var_15))
      var_15 delete();
  }

  level._id_2429 thread _id_0C4C::_id_19BE();
  level._id_2429 unlink();
  var_8 playSound("scn_titan_elevator_gate_open");
  var_4 thread scripts\sp\anim::_id_1F2C(var_0, "elevator_door_open");
  wait 0.25;
  level._id_2429 _meth_82EE(getnode("eth3n_elevator_tp", "targetname"));
  level._id_2429 waittill("goal");
  level._id_2429 thread _id_0C4C::_id_195D(level.player);
}

_id_6056() {
  var_0 = getEnt("bunker_elevator_door_col", "targetname");
  level waittill("commence_elevator_logic");
  wait 1;
  var_0 notsolid();
  level waittill("player_on_elevator");
  var_0 solid();
  level waittill("player_exit_elevator");
  wait 1.3;
  var_0 notsolid();
}

_id_60B5() {
  level._id_C47F scripts\sp\utility::_id_10346("titan_usf_letsgetupthese");
  wait 2;
  thread _id_CD65();
}

_id_CD65() {
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("titan_hud_kotch_pip_02_full");

  while(!iscinematicplaying())
    scripts\engine\utility::waitframe();

  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  stopcinematicingame();
}

_id_7885() {
  var_0 = [];

  for(var_1 = 1; var_1 < 6; var_1++)
    var_0[var_1] = _id_F958("elevator_panel_0" + var_1);

  return var_0;
}

_id_F958(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1._id_1FBB = var_1.targetname;
  var_1 scripts\sp\anim::_id_F64A();
  return var_1;
}

_id_60CD() {
  thread scripts\sp\utility::play_sound_on_entity("titan_elevator_start_lr");
  thread scripts\engine\utility::play_loop_sound_on_entity("titan_elevator_loop_lr");
  self movez(712, 20, 7, 7);
  wait 19;
  thread scripts\sp\utility::play_sound_on_entity("titan_elevator_stop_lr");
  wait 0.5;
  self notify("at_top");
  thread scripts\engine\utility::stop_loop_sound_on_entity("titan_elevator_loop_lr");
}

_id_887E() {
  scripts\engine\utility::flag_wait("ow_earthquake");
  playworldsound("scn_titan_bunker_quake_lr", level.player.origin);
  earthquake(randomfloatrange(0.22, 0.3), randomfloatrange(2.2, 3.2), level.player.origin, 9999);
}

_id_3274() {
  scripts\engine\utility::trigger_off("bunker_kill_volume", "targetname");
  scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("ow_doorlift_animNode", "targetname"));
  scripts\sp\maps\titan\titan_code::_id_10733();
  level._id_C47F scripts\sp\utility::_id_1160F(getnode("omar_overwatch_node", "targetname"));
  level._id_2429 scripts\sp\utility::_id_1160F(getnode("eth3n_elevator_tp", "targetname"));
  level._id_B33B scripts\sp\utility::_id_1160F(getnode("marine1_overwatch_node", "targetname"));
  level._id_B33E scripts\sp\utility::_id_1160F(getnode("marine1_overwatch_node", "targetname"));

  foreach(var_1 in level._id_10AC8) {
    if(var_1 == level._id_2429) {
      continue;
    }
    var_1 scripts\sp\utility::_id_61C7();
    var_1 scripts\sp\utility::_id_F3B5("orange");
  }

  thread _id_C82E();
  level.player givemaxammo("iw7_steeldragon");
  level.player.ignoreme = 1;
  thread _id_3B80();
  scripts\engine\utility::exploder("fx_background_mist_1");
  scripts\engine\utility::exploder("pmd exp");
}

_id_3272() {
  scripts\engine\utility::exploder("jackal_cloud_ceiling");
  scripts\engine\utility::exploder("fx_background_mist_1");
  scripts\sp\utility::_id_10FEC("fx_background_mist_1_opt");
  scripts\sp\utility::_id_10FEC("mons_clouds");
  scripts\sp\utility::_id_10FEC("mons_clouds_4");
  scripts\sp\utility::_id_10FEC("refinery_reveal_clouds");
  scripts\sp\utility::_id_10FEC("refinery_clouds_top");
}

_id_3273() {
  var_0 = getEnt("overwatch_player_gate", "targetname");
  var_1 = getEntArray("script_vehicle_capitalship_freighter_small", "classname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3))
      var_3 delete();
  }

  thread _id_D1FF(var_0);
  level notify("kill_color_replacements");
  scripts\engine\utility::flag_wait("player_opened_ow_door");
  level._id_2429 scripts\sp\utility::_id_4145();
  level._id_2429 scripts\sp\utility::_id_F3DD(16);
  level._id_2429 _meth_82EE(getnode("eth3n_overwatch_pathnode", "targetname"));
  level.player scripts\sp\utility::_id_F416(1);
  level.player scripts\engine\utility::delaythread(3.0, scripts\sp\utility::_id_F416, 0);
  thread scripts\sp\maps\titan\titan_code::_id_D250(1);
  level thread _id_12BB8();
  scripts\engine\utility::exploder("ow_catwalk_explosion");
  thread _id_74AD();
}

_id_6CE7() {
  self endon("death");
  wait 5;
  var_0 = scripts\engine\utility::getclosest(self.origin, level._id_6AEB);

  while(isDefined(var_0)) {
    self _meth_8306(var_0);
    self shoot(1.0, var_0.origin);
    wait(randomfloatrange(0.15, 0.35));
  }
}

_id_C82F() {
  scripts\engine\utility::flag_wait("flag_ow_player_through_door");
  _id_191C();
  wait 1.5;
  level.player scripts\sp\utility::_id_1034D("titan_plr_enemydropships");
  level._id_C47F scripts\sp\utility::_id_10346("titan_usf_copyturnonthe");
  scripts\sp\utility::_id_15F1("bunker_over_watch_colors_1", "targetname");
  _id_191D();
  level._id_C47F scripts\sp\utility::_id_10346("titan_usf_autuictoriamortem");
}

_id_D1FF(var_0) {
  var_1 = scripts\engine\utility::getStruct("ow_doorlift_animNode", "targetname");
  level._id_E367 = var_1;
  var_2 = scripts\sp\utility::_id_10639("ow_gate");
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;

  if(!isDefined(level.player._id_1E9C)) {
    level.player._id_1E9C = scripts\sp\utility::_id_10639("player_rig", var_1.origin, var_1.angles);
    level.player._id_1E9C hide();
  }

  var_3 = [var_2, level.player._id_1E9C];
  var_1 scripts\sp\anim::_id_1EC1(var_3, "bunker_door_lift_intro");
  var_0.origin = var_2.origin;
  var_0 linkTo(var_2);
  var_4 = spawnStruct();
  var_4.origin = var_0.origin;
  var_4 _id_0E46::_id_48C4(undefined, (0, 0, 32), &"SCRIPT_DOORPEEK_OPEN", undefined, 500, undefined, undefined, 0);
  var_4 _id_0E46::_id_9016();
  var_4 _id_0E46::_id_DFE3();
  level.player playSound("titan_lift_door_lr");
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_prone(0);
  level.player _meth_823C(level.player._id_1E9C, "tag_player", 0.5, 0.25, 0.25);
  wait 0.5;
  level.player._id_1E9C show();
  level.player thread scripts\sp\utility::_id_10350("titan_plr_iminposition");
  level.player playerlinktodelta(level.player._id_1E9C, "tag_player", 1, 0, 0, 0, 0);
  scripts\engine\utility::flag_set("player_opened_ow_door");
  level._id_B6D6 scripts\engine\utility::delaythread(1, scripts\engine\utility::play_loop_sound_on_entity, "scn_monsintro_mons_idle_loop_high");
  var_1 scripts\sp\anim::_id_1F2C(var_3, "bunker_door_lift_intro");
  var_0 connectpaths();
  scripts\engine\utility::trigger_on("bunker_kill_volume", "targetname");
  _id_CBEB();
  level.player scripts\sp\utility::_id_F526("normal");
  scripts\engine\utility::flag_set("flag_ow_player_through_door");
  thread _id_C831("overwatch_kill_trig");
}

_id_CBEB() {
  level.player._id_1E9C hide();
  var_0 = scripts\engine\utility::getStruct("ret_look_at", "targetname");
  level.player unlink();
  var_1 = scripts\engine\utility::spawn_tag_origin(level.player.origin, var_0.angles);
  var_2 = anglesToForward(level.player.angles) * 32;
  var_1.origin = var_2 + level.player.origin;
  level.player _meth_823C(var_1, "tag_origin", 1, 0.25, 0.25);
  wait 0.5;
  level.player playerlinktodelta(var_1, "tag_origin", 50, 30, 30, 30, 30, 0);
  wait 2.5;
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  level.player unlink(1);
}

_id_191C() {
  var_0 = getaiarray("allies", "axis");

  foreach(var_2 in var_0)
  var_2.ignoreall = 1;
}

_id_191D() {
  var_0 = getaiarray("allies", "axis");

  foreach(var_2 in var_0)
  var_2.ignoreall = 0;
}

_id_D23D() {
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_CF8D();
  var_0 = 0;

  if(!var_0) {
    scripts\sp\utility::_id_22CD("overwatch_enemy_spawners", 1);
    var_1 = getspawnerarray("overwatch_enemy_spawners2");
    scripts\sp\utility::_id_15F5("ow_enemy_dropship_cowbell1");
    scripts\engine\utility::delaythread(5.0, ::_id_C82D);
    wait 5.0;

    foreach(var_3 in var_1)
    var_3 thread _id_0B77::_id_12799();

    _id_13766(4, 2.0, 10.0);
    scripts\sp\utility::_id_15F5("ow_enemy_dropship1");
    _id_13766(4, 25.0, 45.0);
  } else
    wait 2.0;
}

_id_13766(var_0, var_1, var_2) {
  level.player endon("death");
  level endon("waittill_enemies_alive_timeout");
  wait(var_1);
  level thread _id_1456(var_2 - var_1);

  for(;;) {
    var_3 = getaiarray("axis");

    if(var_3.size <= var_0) {
      break;
    }

    wait 0.05;
  }

  level notify("waittill_enemies_done");
}

_id_1456(var_0) {
  level.player endon("death");
  level endon("waittill_enemies_done");
  wait(var_0);
  level notify("waittill_enemies_alive_timeout");
}

_id_C82D() {
  level.player endon("death");
  level.player endon("jackal_boss_start");
  var_0 = 5.0;
  var_1 = 15.0;
  var_2 = 20.0;
  var_3 = gettime() + var_2 * 1000;

  for(;;) {
    wait(randomfloatrange(var_0, var_1));
    var_4 = getaiarray("axis");
    var_5 = undefined;

    foreach(var_7 in var_4) {
      if(distance(level.player.origin, var_7.origin) < 2000) {
        if(var_7 scripts\sp\utility::_id_3849(level.player.origin + (0, 0, 48), 0)) {
          var_5 = var_7;
          break;
        }
      }
    }

    if(isDefined(var_5)) {
      var_5 scripts\sp\utility::_id_F39C(level.player);
      continue;
    }

    if(gettime() >= var_3) {
      var_3 = gettime() + var_2 * 1000;
      continue;
    }
  }
}

_id_74AE() {
  var_0 = getEnt("ow_fuel_tank", "targetname");
  var_1 = getEnt("ow_fuel_tank_dest", "targetname");
  var_2 = scripts\engine\utility::getStruct("ow_fuel_tank_struct", "targetname");
  var_1 hide();
  level waittill("ow_explode");
  scripts\sp\utility::_id_15F1("bunker_over_watch_colors_2", "targetname");
  var_0 playSound("exp_helicopter_fuel");
  var_0 radiusdamage(var_0.origin, 200, 9999, 9999);
  var_3 = playFX(level._effect["ow_fuel_eplo"], var_2.origin);
  var_1 show();
  var_0 hide();
  wait 1;
  var_3 = spawnfx(level._effect["ow_fuel_burn"], var_2.origin, anglesToForward(var_2.angles), anglestoup(var_2.angles) * -1);
  triggerfx(var_3);
  level waittill("allies_arrived_ow");
  var_3 delete();
}

_id_74AD() {
  var_0 = getEnt("ow_fuel_tank", "targetname");
  var_1 = getEnt("ow_fuel_tank_dest", "targetname");
  var_2 = scripts\engine\utility::getStruct("ow_fuel_tank_struct", "targetname");
  var_1 hide();
  wait 1.5;
  var_0 playSound("exp_helicopter_fuel");
  var_3 = playFX(level._effect["ow_fuel_eplo"], var_2.origin);
  var_1 show();
  var_0 hide();
  wait 1;
  var_3 = spawnfx(level._effect["ow_fuel_burn"], var_2.origin, anglesToForward(var_2.angles), anglestoup(var_2.angles) * -1);
  triggerfx(var_3);
}

_id_40A2() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 _meth_81D0();

    wait(randomfloatrange(0.4, 1));
  }
}

_id_51EC(var_0, var_1) {
  wait 3;
  scripts\engine\utility::flag_set(var_1);
  var_0 waittill("trigger");
  self delete();
}

_id_A0DF() {
  scripts\engine\utility::trigger_off("bunker_kill_volume", "targetname");
  scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("calvary_start_player", "targetname"));
  scripts\sp\maps\titan\titan_code::_id_10733();
  level._id_DE2F = scripts\sp\utility::_id_22CD("bunker_door_redshirts");
  level._id_3277 = scripts\engine\utility::array_combine(level._id_DE2F, level._id_10AC8);
  level._id_C47F scripts\sp\utility::_id_1160F(getnode("omar_overwatch_node", "targetname"));
  level._id_2429 scripts\sp\utility::_id_1160F(getnode("atom_overwatch_node", "targetname"));
  level._id_B33B scripts\sp\utility::_id_1160F(getnode("marine1_overwatch_node", "targetname"));
  level._id_B33E scripts\sp\utility::_id_1160F(getnode("marine1_overwatch_node", "targetname"));
  var_0 = getnodearray("redshirt_overwatch_node", "targetname");

  foreach(var_3, var_2 in level._id_DE2F)
  var_2 scripts\sp\utility::_id_1160F(var_0[var_3]);

  foreach(var_5 in level._id_10AC8) {
    var_5 scripts\sp\utility::_id_61C7();
    var_5 scripts\sp\utility::_id_F3B5("orange");
  }

  foreach(var_5 in level._id_DE2F) {
    var_5 _meth_83A1();
    var_5 scripts\sp\utility::_id_61C7();
    var_5 scripts\sp\utility::_id_F3B5("blue");
  }

  thread _id_C82E();
  level.player.ignoreme = 1;
  thread _id_3B80();
}

_id_A0DB() {
  scripts\engine\utility::flag_init("jackal_boss_done_shooting_player");
  scripts\engine\utility::flag_init("jackal_boss_dead");
  level.player notify("jackal_boss_start");
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2 scripts\sp\utility::_id_F39C(undefined);

  wait 0.5;
}

_id_D7CA() {
  var_0 = getEnt("ow_jackal_preboss1", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10808();
  var_1 _id_0BDC::_id_19A0(1);
  var_1 _id_0BDC::_id_19AB(700);
  var_1 thread _id_0BDC::_id_A342(scripts\sp\utility::_id_7C9A(var_0.target), 0);
  var_1 thread _id_A2CB();
  wait 3.0;
  var_0 = getEnt("ow_jackal_preboss3", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10808();
  var_1 _id_0BDC::_id_19A0(1);
  var_1 _id_0BDC::_id_19AB(700);
  var_1 thread _id_0BDC::_id_A342(scripts\sp\utility::_id_7C9A(var_0.target), 0);
  wait 0.4;
  var_0 = getEnt("ow_jackal_preboss2", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10808();
  var_1 _id_0BDC::_id_19A0(1);
  var_1 _id_0BDC::_id_19AB(700);
  var_1 thread _id_0BDC::_id_A342(scripts\sp\utility::_id_7C9A(var_0.target), 0);
}

_id_A2CB() {
  self waittill("preboss_flyover_missile_catwalk");
  _id_0BDC::_id_19A7(400, 100, 40, 190);
  var_0 = "tag_flash_right";
  var_1 = scripts\engine\utility::getStruct("jackal_boss_missile_catwalk", "targetname");
  thread _id_A0D2();
  _id_0B76::_id_1992(var_0, var_1, 1);
}

_id_A0DE(var_0) {
  switch (var_0) {
    case 1:
      _id_0BDC::_id_19A7(250, 100, 40);
      break;
    case 2:
      _id_0BDC::_id_19A7(300, 100, 60);
      break;
    case 3:
      _id_0BDC::_id_19A7(300, 200, 40);
      break;
    case 4:
      _id_0BDC::_id_19A7(400, 200, 80);
      break;
    case 5:
      _id_0BDC::_id_19A7(600, 800, 300);
      break;
  }
}

_id_A0E0() {
  var_0 = getEnt("ow_jackal_boss", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10808();
  var_1.health = 10000;
  var_1._id_10A4C = var_0.target;
  thread _id_A0D4(var_1);
  var_1 _id_0BDC::_id_19AA("spaceship_ai_30mm_projectile_titan_boss");
  var_1 endon("death");
  level.player._id_A423 = getEnt("jackal_player_target", "targetname");
  level.player._id_A423 makeentitysentient("allies");
  level.player._id_A423.health = 99999;
  level.player._id_A423 linkTo(level.player, "tag_origin", (0, 0, 48), (0, 0, 0));
  var_1 thread _id_A0DC(2500);
  var_1 _id_A0DA();
  var_1 notify("stop_maintaining_health");
  var_1 _id_0BDC::_id_19AB(20);
  var_1 thread _id_A0DD();
  var_2 = 0;

  for(;;) {
    var_1 thread _id_A0D6();
    var_1 scripts\engine\utility::delaythread(1.0, ::_id_A0D5);
    var_1 thread _id_A0D7();
    var_3 = var_1 scripts\engine\utility::waittill_any_return("jackal_boss_fired_at", "jackal_boss_fire_at_allies_timeout");

    if(var_3 == "jackal_boss_fired_at")
      var_1 _id_A0D8(0);
    else if(var_3 == "jackal_boss_fire_at_allies_timeout") {
      var_2 = int(clamp(var_2 + 1, 1, 5));
      var_1 _id_A0DE(var_2);
      var_1 _id_A0D8(1);
    }

    wait 0.05;
  }
}

_id_A0D4(var_0) {
  var_0 waittill("death");
  level.player._id_A423 delete();
  scripts\engine\utility::flag_set("jackal_boss_dead");
}

_id_A0DA() {
  var_0 = scripts\engine\utility::getStruct("jackal_boss_hover_start", "targetname");
  _id_0BDC::_id_19A0(1);
  _id_0BDC::_id_19A7(250, 100, 40);
  _id_0BDC::_id_19AB(700);
  thread _id_0BDC::_id_A342(scripts\sp\utility::_id_7C9A(self._id_10A4C), 0.2);
  self setneargoalnotifydist(1000);
  self waittill("near_goal");
  _id_0BDC::_id_19AB(100);
  _id_0BDC::_id_19B2("face enemy");
  _id_0BDC::_id_A1EC(var_0.origin, 1, 384);
  thread _id_A0D6();
  wait 1.5;
  var_1 = "tag_flash_right";
  var_2 = scripts\engine\utility::getStruct("jackal_boss_missile_allies_intro", "targetname");
  _id_0B76::_id_1992(var_1, var_2);
}

_id_A0D2() {
  self waittill("missile_explode");
  scripts\engine\utility::exploder("ow_catwalk_explosion");
  var_0 = scripts\engine\utility::getStruct("jackal_boss_missile_catwalk", "targetname");
  level.player thread _id_0B1D::_id_859C(var_0.origin);
}

_id_A0DD() {
  self endon("death");
  var_0 = scripts\engine\utility::getStructArray("jackal_boss_random_hover", "targetname");
  var_1 = 2.0;
  var_2 = 8.0;

  for(;;) {
    var_3 = var_0[randomint(var_0.size)];
    _id_0BDC::_id_A1EC(var_3.origin, 1, 384);
    wait(randomfloatrange(var_1, var_2));
  }
}

_id_A0D6() {
  self notify("jackal_boss_fire_at_allies");
  self notify("jackal_boss_new_behavior");
  self endon("jackal_boss_new_behavior");
  self endon("death");
  _id_0BDC::_id_19AE("dont_shoot");
  var_0 = [level._id_C47F, level._id_2429, level._id_B33B, level._id_B33E];

  foreach(var_2 in var_0)
  var_2 scripts\sp\utility::_id_F415(1);

  for(;;) {
    var_4 = randomint(var_0.size);
    var_5 = var_0[var_4];
    _id_0BDC::_id_19B5(var_5);
    wait 0.7;
    var_6 = randomintrange(2, 5);

    for(var_7 = 0; var_7 < var_6; var_7++) {
      var_8 = randomfloatrange(0.5, 2.0);
      var_9 = randomfloatrange(0.4, 0.8);
      _id_0BDC::_id_19AE("shoot_forever");
      wait(var_8);
      _id_0BDC::_id_19AE("dont_shoot");
      wait(var_9);
    }
  }
}

_id_A0D8(var_0) {
  self notify("jackal_boss_fire_at_player");
  self notify("jackal_boss_new_behavior");
  self endon("jackal_boss_new_behavior");
  self endon("death");
  _id_0BDC::_id_19AE("dont_shoot");
  _id_0BDC::_id_19B5(level.player._id_A423);
  var_1 = [level._id_C47F, level._id_2429, level._id_B33B, level._id_B33E];

  foreach(var_3 in var_1)
  var_3 scripts\sp\utility::_id_F415(0);

  wait 0.3;

  if(isDefined(var_0) && var_0) {
    var_5 = scripts\engine\utility::getStructArray("jackal_boss_missile_hiding", "targetname");
    var_6 = 10000;
    var_7 = undefined;

    foreach(var_9 in var_5) {
      var_10 = distance(var_9.origin, level.player.origin);

      if(var_10 < var_6) {
        var_6 = var_10;
        var_7 = var_9;
      }
    }

    var_12 = "tag_flash_left";
    thread _id_0B76::_id_1992(var_12, var_7);
  }

  var_13 = randomfloatrange(4.0, 6.0);
  scripts\engine\utility::flag_clear("jackal_boss_done_shooting_player");
  thread scripts\engine\utility::flag_set_delayed("jackal_boss_done_shooting_player", var_13);
  _id_0BDC::_id_19AE("shoot_forever");
  var_14 = 0.1;
  var_15 = 1.0;
  var_16 = 1.5;
  var_17 = var_16 * 0.05 * (var_15 - var_14);
  var_18 = var_14;

  while(!scripts\engine\utility::flag("jackal_boss_done_shooting_player")) {
    _id_0BDC::_id_1980(var_18);
    var_18 = var_18 + var_17;
    var_18 = clamp(var_18, var_14, var_15);
    wait 0.05;
  }

  _id_0BDC::_id_19AE("dont_shoot");
}

_id_A0D3() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && isDefined(var_1.classname))
      iprintlnbold("health: " + self.health + ", damage: " + var_0 + ", " + var_1.classname);
    else
      iprintlnbold("health: " + self.health + ", damage: " + var_0);

    wait 0.05;
  }
}

_id_A0D9() {
  self endon("death");
  var_0 = self.health;

  for(;;) {
    if(var_0 != self.health) {
      iprintlnbold(self.health);
      var_0 = self.health;
    }

    wait 0.05;
  }
}

_id_A0D5() {
  self endon("death");
  self endon("jackal_boss_fire_at_player");
  var_0 = self.health;
  var_1 = 1000;

  for(;;) {
    if(self.health < var_0 - var_1) {
      break;
    }

    wait 0.05;
  }

  self notify("jackal_boss_fired_at");
}

_id_A0D7() {
  self endon("death");
  self endon("jackal_boss_fire_at_player");
  wait(randomfloatrange(4.0, 8.0));
  self notify("jackal_boss_fire_at_allies_timeout");
}

_id_A0DC(var_0) {
  self endon("death");
  self endon("stop_maintaining_health");

  for(;;) {
    if(self.health < var_0)
      self.health = var_0;

    wait 0.05;
  }
}

_id_1A59() {
  scripts\engine\utility::trigger_off("bunker_kill_volume", "targetname");
  scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("calvary_start_player", "targetname"));
  scripts\sp\maps\titan\titan_code::_id_10733();
  level._id_DE2F = scripts\sp\utility::_id_22CD("bunker_door_redshirts");
  level._id_3277 = scripts\engine\utility::array_combine(level._id_DE2F, level._id_10AC8);
  level._id_C47F scripts\sp\utility::_id_1160F(getnode("omar_overwatch_node", "targetname"));
  level._id_2429 scripts\sp\utility::_id_1160F(getnode("atom_overwatch_node", "targetname"));
  level._id_B33B scripts\sp\utility::_id_1160F(getnode("marine1_overwatch_node", "targetname"));
  level._id_B33E scripts\sp\utility::_id_1160F(getnode("marine1_overwatch_node", "targetname"));
  var_0 = getnodearray("redshirt_overwatch_node", "targetname");

  foreach(var_3, var_2 in level._id_DE2F)
  var_2 scripts\sp\utility::_id_1160F(var_0[var_3]);

  foreach(var_5 in level._id_10AC8) {
    var_5 scripts\sp\utility::_id_61C7();
    var_5 scripts\sp\utility::_id_F3B5("orange");
  }

  foreach(var_5 in level._id_DE2F) {
    var_5 _meth_83A1();
    var_5 scripts\sp\utility::_id_61C7();
    var_5 scripts\sp\utility::_id_F3B5("blue");
  }

  thread _id_C82E();
  level.player.ignoreme = 1;
  thread _id_3B80();
}

_id_1A58() {
  var_0 = scripts\engine\utility::getStruct("ow_jackal_strafe", "targetname");
  thread _id_EB71();
  var_1 = scripts\sp\utility::_id_8201("ow_bunker_ally_jackal_anim", "targetname");
  var_2 = _id_10748(var_1, "ow_ally_jackal_0", "allies");
  thread _id_50BD(var_0, var_2);
}

_id_6FEA(var_0) {
  wait 1;

  foreach(var_2 in var_0)
  var_2 _id_0BDC::_id_6B4C("fly", 1);
}

_id_A1CF(var_0) {
  wait(var_0);
  earthquake(randomfloatrange(0.2, 0.3), randomfloatrange(2.8, 3.8), level.player.origin, 9999);
}

_id_EB71() {
  wait 8;
  setmusicstate("mx_396_titan_savedbyret");
}

_id_1A5A() {
  level._id_2429 scripts\sp\utility::_id_10346("titan_eth_moreairthreats");
  scripts\engine\utility::flag_wait("send_ow_allies");
  level._id_B33E scripts\sp\utility::_id_10346("titan_ksh_headupapproachinghot");
}

_id_50BD(var_0, var_1) {
  wait 0.5;
  var_0 thread _id_1F7A(var_1, "ow_ally_attack", 0);
}

_id_1F7A(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(isDefined(var_4))
      thread _id_1F79(var_4, var_1, var_2);
  }
}

_id_A27E() {
  self waittill("death", var_0, var_1, var_2);
  wait 1;
}

_id_1F79(var_0, var_1, var_2) {
  var_0 endon("death");
  var_3 = spawnStruct();
  var_3.origin = self.origin;
  var_3.angles = self.angles;

  if(!var_2)
    var_3 scripts\sp\anim::_id_1F35(var_0, var_1);
  else {
    var_3 thread scripts\sp\anim::_id_1F35(var_0, var_1);

    for(;;) {
      var_4 = var_0 islegacyagent(var_0 scripts\sp\utility::_id_7DC1(var_1));

      if(var_4 >= 0.9) {
        break;
      }

      wait 0.05;
    }
  }

  var_0 notify("death");
}

_id_C832(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = scripts\engine\utility::spawn_tag_origin(var_0[var_2] gettagorigin("tag_flash"), var_0[var_2] gettagangles("tag_flash"));
    var_3 thread _id_0B76::_id_A332(var_1[var_2], 0, var_0[var_2]);
    wait 0.3;
  }
}

_id_10748(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [];

  foreach(var_6 in var_0) {
    var_7 = var_6 scripts\sp\utility::_id_10808();
    var_7 scripts\sp\vehicle::_id_8441();
    var_7 thread _id_A27E();
    var_7 scripts\asm\asm_bb::bb_setanimScripted();
    var_7._id_1FBB = var_1 + var_3;
    var_4[var_3] = var_7;
    var_7.team = var_2;
    var_7._id_9930 = 1;
    var_3++;
    wait 0.05;
  }

  return var_4;
}

_id_3792() {
  scripts\engine\utility::trigger_off("bunker_kill_volume", "targetname");
  var_0 = getnode("omar_bunker_tp", "targetname");
  var_1 = getnode("atom_bunker_tp", "targetname");
  var_2 = getnode("marine_1_bunker_tp", "targetname");
  var_3 = getnode("marine_2_bunker_tp", "targetname");
  scripts\sp\maps\titan\titan_code::_id_BC52("calvary_start_player");
  scripts\sp\maps\titan\titan_code::_id_10733();
  level._id_DE2F = scripts\sp\utility::_id_22CD("bunker_door_redshirts");
  level._id_3277 = scripts\engine\utility::array_combine(level._id_DE2F, level._id_10AC8);
  level._id_C47F scripts\sp\utility::_id_1160F(getnode("omar_overwatch_node", "targetname"));
  level._id_2429 scripts\sp\utility::_id_1160F(getnode("atom_overwatch_node", "targetname"));
  level._id_B33B scripts\sp\utility::_id_1160F(getnode("marine1_overwatch_node", "targetname"));
  level._id_B33E scripts\sp\utility::_id_1160F(getnode("marine1_overwatch_node", "targetname"));
  var_4 = getnodearray("redshirt_overwatch_node", "targetname");

  foreach(var_7, var_6 in level._id_DE2F)
  var_6 scripts\sp\utility::_id_1160F(var_4[var_7]);

  thread _id_3B80();
  scripts\engine\utility::delaythread(1, ::_id_12BB8);
}

_id_3790() {
  var_0 = getEnt("intro_retribution", "targetname");
  var_1 = getvehiclenode("mons_chase_path", "targetname");
  var_2 = getEnt("overwatch_player_gate", "targetname");
  level._id_E367 = scripts\engine\utility::getStruct("ow_doorlift_animNode", "targetname");
  var_3 = scripts\engine\utility::getStruct("ally_ow_ds_end", "targetname");
  _id_0BDB::spawn_jackal_mip_buffer("veh_mil_air_un_jackal_02_player");
  wait 0.5;
  thread _id_E397();
  wait 1.75;
  level._id_E35D = var_0 scripts\sp\utility::_id_10808();
  wait 0.05;
  level._id_E35D _id_0BB8::_id_39D0("idle");
  level._id_E35D _id_0BB8::_id_39CD("heavy");
  thread _id_E318();
  level._id_E35D playSound("scn_titan_retribution_flyover");
  level._id_E35D scripts\engine\utility::delaycall(2.2, ::playsound, "scn_titan_retribution_flyover_ducking");
  level._id_E35D._id_1FBB = "retribution";
  level._id_E35D scripts\sp\anim::_id_F64A();
  thread _id_E305();
  level._id_E367 thread _id_EA34(6);
  level._id_E367 thread _id_CF75(9);
  level._id_2429 thread _id_0C4C::_id_195D(level._id_E35D);
  wait 4;
  scripts\engine\utility::flag_set("player_ret_unlink");
  wait 3;

  if(isDefined(level._id_B6D6)) {
    level._id_B6D6 attachpath(var_1);
    level._id_B6D6 vehicle_setspeed(400, 30, 15);
    scripts\sp\vehicle_paths::_id_845A(level._id_B6D6);
    level._id_B6D6 playSound("scn_titan_overwatch_mons_chase");
    level._id_B6D6 scripts\engine\utility::delaythread(1.5, _id_0BB8::_id_39CD, "idle");
  }

  wait 2;
  scripts\sp\utility::_id_A6F2();
  level.player scripts\sp\utility::_id_F416(0);
  level waittill("cavalry_arrived_vo");
  scripts\engine\utility::flag_set("mons_scene_done");
}

_id_E318() {
  var_0 = 1.5;
  var_1 = 5;
  var_2 = 1.25;
  var_3 = 2;
  var_4 = 1000;
  var_5 = 10;
  screenshake(level.player.origin, var_0, var_0, var_0, var_1, var_2, var_3, var_4, var_5, var_5, var_5);
}

_id_E305() {
  level._id_E367 scripts\sp\anim::_id_1F35(level._id_E35D, "ow_arrival");
  level._id_E35D delete();
}

_id_3791() {}

_id_E397() {
  var_0 = ["titan_usf_friendliesinthewire", "titan_brk_hellyeahwegot", "titan_eth_retributionbearingoneeight", "titan_nav_yourownsize", "titan_nav_letstakethisbig", "titan_plr_extremecautiongator", "titan_nav_likespittingonhell"];
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_friendliesinthewire");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_brk_hellyeahwegot");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_eth_retributionbearingoneeight");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_nav_yourownsize");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_nav_letstakethisbig");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_extremecautiongator");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_nav_likespittingonhell");
  scripts\engine\utility::flag_set("ok_to_ow_jump");
  level.player scripts\sp\utility::_id_10350("titan_slt_needaride");
  level.player scripts\sp\utility::_id_10350("titan_plr_whattookyouso");
  level.player scripts\sp\utility::_id_10350("titan_slt_whenwereyougonna");
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_rightaboutnow");
  level notify("cavalry_arrived_vo");
}

_id_EA7B(var_0) {
  if(var_0._id_1FBB == "plyr_jackal_mons_arrival")
    thread _id_D180(var_0);

  scripts\sp\anim::_id_1F35(var_0, "salter_arrival");
}

_id_EA34(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  if(!isDefined(level._id_EAD6))
    scripts\sp\maps\titan\titan_code::_id_10732();

  level._id_EAD6 _id_0BDC::_id_19A0();
  level._id_EAD6 thread _id_0C1A::_id_A3B6("fly", 1.0);
  level._id_EAD6 thread _id_0C20::_id_A3B7("fly");
  level._id_EAD6._id_1FBB = "salter";
  level._id_EAD6 scripts\sp\anim::_id_F64A();
  thread _id_C831("overwatch_kill_trig_2");
  thread _id_C831("overwatch_kill_trig_3");
  scripts\sp\anim::_id_1F35(level._id_EAD6, "ow_ally_arrival");
  level._id_EAD6 _id_0BDC::_id_19B0("hover");
  level._id_EAD6 _id_0BDC::_id_19B2("face angle", self.angles);
  level._id_EAD6 _id_0BDC::_id_A1EC(level._id_EAD6.origin + (0, 0, 200), 1);
}

#using_animtree("jackal");

_id_CF75(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  var_1 = scripts\sp\utility::_id_8201("ow_bunker_ally_jackal_anim", "targetname");
  var_2 = var_1[0] scripts\sp\utility::_id_10808();
  var_2 thread _id_0BDC::_id_F43D("player");
  var_2 _id_0BDC::_id_A07D();
  wait 0.1;
  var_2 thread _id_0C1A::_id_A3B6("fly", 1.0);
  var_2 thread _id_0C20::_id_A3B7("fly");
  var_2._id_1FBB = "player_jackal";
  var_2 scripts\sp\anim::_id_F64A();
  var_2 _id_0BDC::_id_A19F();
  var_2 _id_0BDC::_id_104A6(0);
  scripts\sp\anim::_id_1F35(var_2, "ow_ally_arrival");
  var_2 thread _id_0C1A::_id_A3B6("hover", 1.0);
  var_2 thread _id_0C20::_id_A3B7("hover");
  level.player scripts\sp\maps\titan\titan_code::_id_D85C();
  var_2 setanimknob(%titan_jackal_reveal_vehicle_idle, 1, 0.5, 1);
  var_2._id_116AE = var_2 scripts\engine\utility::spawn_tag_origin();
  var_2._id_116AE linkTo(var_2, "j_weapon_hatch_right2", (0, 0, 30), (0, 0, 0));
  objective_add(scripts\sp\utility::_id_C264("OBJ_PLAYER_JACKAL"), "invisible");
  objective_onentity(scripts\sp\utility::_id_C264("OBJ_PLAYER_JACKAL"), var_2._id_116AE);
  objective_state(scripts\sp\utility::_id_C264("OBJ_PLAYER_JACKAL"), "current");
  scripts\engine\utility::flag_wait("jackals_player_jumped");
  objective_delete(scripts\sp\utility::_id_C264("OBJ_PLAYER_JACKAL"));
  var_2 _id_0BDC::_id_F48D("jump_in");
  var_2 _id_0BDC::_id_F5BD("instant");
  var_2 notify("stop_idle");
  level._id_2429 linkTo(var_2, "tag_player", var_2 gettagorigin("tag_player"), var_2 gettagangles("tag_player"));
  var_2 thread scripts\sp\anim::_id_1F35(level._id_2429, "mount_jackal", "tag_player");
  var_2 thread _id_0BDB::_id_F51F();
  _id_0BDC::_id_A151();
  _id_0BDC::_id_A15B();
  _id_0BDC::_id_137D6();
  _id_0BDC::_id_A149();
  _id_0BDC::_id_A166();
  _id_0BDC::_id_D16C(var_2.origin, 1, 0, 0);
  _id_0BDC::_id_D165(var_2.origin + anglesToForward(var_2.angles) * 1000, 1, 0, 0);
  setomnvar("ui_level_transition", 1);
  level.player _meth_82C0("titan_transition_to_titanjackal", 1.0);
  wait 1.75;
  scripts\engine\utility::flag_set("jackal_mount_complete");
  level._id_2429 scripts\sp\utility::_id_1101B();
  level._id_2429 delete();
}

_id_C831(var_0) {
  level endon("player_in_jackal");
  var_1 = getEnt(var_0, "targetname");

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(isDefined(level.player) && level.player istouching(var_1))
      level.player dodamage(10000, level.player.origin);

    scripts\engine\utility::waitframe();
  }
}

_id_A22C() {
  self endon("stop_idle");
  scripts\sp\utility::anim_stopanimScripted();
  var_0 = getanimlength(%titan_jackal_reveal_vehicle_idle);

  for(;;) {
    self setanimknob(%titan_jackal_reveal_vehicle_idle, 1, 0.05, 1);
    wait(var_0);
  }
}

_id_2F2A() {
  for(;;)
    wait 0.05;
}

_id_D180(var_0) {
  wait 12;
  var_0 delete();
  scripts\engine\utility::flag_set("show_player_jackal");
  var_1 = _id_0BDC::_id_1079F("player_rooftop_jackal");
  var_1 _id_0BDC::_id_F48D("jump_in");
  var_1 _meth_8491("land");
  var_1 _meth_849F(0);
}

_id_10792() {
  var_0 = [];

  foreach(var_2 in self) {
    var_3 = var_2 scripts\sp\utility::_id_10619(1);
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_3B80() {
  if(!isDefined(level._id_B6D6)) {
    var_0 = getEnt("mi_mons", "targetname");
    var_0._id_ED7C = "heavy idle";
    level._id_B6D6 = scripts\sp\vehicle::_id_1080C("mi_mons");
    level._id_B6D6 scripts\engine\utility::delaythread(0.2, _id_0BB8::_id_397F, 1, 0);
    level._id_B6D6 scripts\engine\utility::delaythread(0.2, _id_0BB8::_id_39CD, "idle");
  }

  var_1 = getvehiclenode("mons_chase_path", "targetname");
  level._id_B6D6 vehicle_teleport(var_1.origin, var_1.angles);
}

_id_12BB8() {
  var_0 = getaiarray();
  var_0 = scripts\engine\utility::array_remove(var_0, level._id_2429);
  var_0 = scripts\engine\utility::array_remove(var_0, level._id_B33E);
  scripts\engine\utility::array_call(var_0, ::_meth_83A1);
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_1101B);
  scripts\engine\utility::array_call(var_0, ::_meth_81D0);
  scripts\engine\utility::array_call(var_0, ::delete);
  clearallcorpses();
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_1264E("titan_base_tr");
  scripts\sp\utility::_id_1264E("titan_launch_art_tr");
  scripts\sp\utility::_id_1264E("titan_refinery_interior_tr");
  scripts\sp\utility::_id_1264E("titan_jackal_tr");
  wait 2;
  level thread scripts\sp\utility::_id_BF97();
}