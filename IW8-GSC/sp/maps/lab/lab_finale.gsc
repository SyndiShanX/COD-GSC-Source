/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\lab\lab_finale.gsc
***********************************************/

finale_preload() {
  precachemodel("viewhands_farah_55inch");
  precachemodel("viewhands_farah_55inch_wind");
  precachemodel("weapon_wm_me_tactical_knife_v2");
  precachemodel("body_hero_farah_wind");
  precachemodel("head_hero_farah_wind");
  precachemodel("head_hero_nikolai_no_hair");
  precachemodel("hat_hero_nikolai_headset");
  precachemodel("body_hero_nikolai_lab");
  precachemodel("head_villain_barkov_old_blendshape");
  precachemodel("head_villain_barkov_old_blendshape_lab");
  precachemodel("body_villain_barkov_wind");
  precachemodel("veh8_mil_air_mindia8_static");
  precachemodel("veh8_mil_air_mindia8_interior_vm");
  precachemodel("parts_radio_small");
  precachemodel("foliage_tree_spruce_01");
  precachemodel("foliage_tree_spruce_02");
  precachemodel("foliage_tree_spruce_03");
  precachesuit("iw8_teenager_combat");
  precachemodel("body_villain_barkov_wind_all_stab_1");
  precachemodel("body_villain_barkov_wind_all_stab_2");
  precachemodel("body_villain_barkov_wind_all_stab_3");
  precachemodel("body_villain_barkov_wind_all_stab_4");
  precachemodel("body_villain_barkov_wind_all_stab_5");
  precachemodel("body_villain_barkov_wind_all_stab_6");
  precachemodel("body_villain_barkov_wind_gun_stab_3");
  precachemodel("body_villain_barkov_wind_gun_stab_4");
  precachemodel("body_villain_barkov_wind_gun_stab_5");
  precachemodel("body_villain_barkov_wind_gun_stab_6");
  precachemodel("head_villain_barkov_stab_5_blendshape");
}

finale_postload() {
  scripts\engine\utility::flag_init("finale_scene");
  scripts\engine\utility::flag_init("next_dialog_line");
  scripts\engine\utility::flag_init("beg_lines");
  scripts\engine\utility::flag_init("kick_lines");
  scripts\engine\utility::flag_init("start_lookback");
  scripts\engine\utility::flag_init("stabed_01");
  scripts\engine\utility::flag_init("stabed_02");
  scripts\engine\utility::flag_init("stabed_03");
  scripts\engine\utility::flag_init("set_fire");
  scripts\engine\utility::flag_init("move_heli");
  scripts\engine\utility::flag_init("barkov_dead");
  scripts\engine\utility::flag_init("script_end_start");
  scripts\engine\utility::flag_init("script_end");
  scripts\engine\utility::flag_init("start_choking_scene");
  scripts\engine\utility::flag_init("ready_for_kickoff");
  level.meleehintshow = 1;
  scripts\engine\sp\utility::add_hint_string("lab_stab", &"LAB/FINALE_MELEE");
  scripts\engine\sp\utility::add_hint_string("melee_stealth", &"CONTEXT_MELEE/STEALTH_KILL", ::melee_hint_break);

  if(!getdvarint("LLQQOPKTKM")) {
    var_0 = getEnt("finale_heli_reflect_model", "targetname");

    if(isDefined(var_0))
      var_0 delete();

    var_1 = scripts\engine\utility::array_combine(getEntArray("heli_nets", "targetname"), getEntArray("finale_heliTarp", "targetname"));

    foreach(var_3 in var_1)
    var_3 hide();
  }
}

melee_hint_break() {
  return level.meleehintshow;
}

finale_perspective_start() {
  scripts\sp\maps\lab\lab_util.gsc::spawn_team_price();
  level.pipes_bomb = scripts\engine\utility::getStruct("start_point_struct", "script_noteworthy");
  scripts\engine\sp\utility::set_start_location("final_pipes_start", [level.player, level.price, level.rebel_1, level.rebel_2, level.rebel_3]);
  thread finale_heli_setup();
}

finale_perspective_catchup() {
  level.player.handle_unresolved_collision = ::empty_collision_handler;
}

finale_perspective_main() {
  level.player.handle_unresolved_collision = ::empty_collision_handler;
  thread setup_heli_scene();
  thread place_finale_trees("finale_scene_trees_firstshot");
  thread disable_scriptable_shadows();
  bomb_plant_scene();

  if(isDefined(level.og_zplanes))
    setsaveddvar("OMNONNMOTP", level.og_zplanes);

  level.player setclienttriggeraudiozone("lab_helicopter", 0.25);
  heli_intro_scene();
  thread delete_allies();
}

empty_collision_handler() {}

#using_animtree("vehicles");

fix_heli_blades() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  level.finale_heli setscriptablepartstate("engine", "off");
  level.finale_heli setscriptablepartstate("engine", "on");
  level.finale_heli useanimtree(#animtree);
  var_0 = level.vehicle.templates.driveidle[level.finale_heli.model];
  var_1 = level.vehicle.templates.driveidle_animrate[level.finale_heli.model];
  level.finale_heli setanim(var_0, 1, 0.2, var_1);
}

place_finale_trees(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level.fake_trees))
    level.fake_trees = [];

  foreach(var_3 in var_1) {
    var_4 = spawn("script_model", var_3.origin);
    var_4.angles = var_3.angles;
    level.fake_trees[level.fake_trees.size] = var_4;
    var_4 setModel(var_3.script_noteworthy);
    var_4 dontcastdistantshadows();
    var_4 dontcastshadows();
  }
}

disable_scriptable_shadows() {
  wait 5;
  var_0 = getscriptablearray();
  var_1 = [level.player, level.player_rig, level.barkov, level.farah, level.finale_heli, level.nikolai, level.finale_heli.pilot];
  var_1 = scripts\engine\utility::array_removeundefined(var_1);
  var_0 = scripts\engine\utility::array_remove_array(var_0, var_1);
  var_0 = scripts\engine\utility::array_remove_array(var_0, getaiarray());

  foreach(var_3 in var_0) {
    if(!isDefined(var_3) || distance2d(level.player.origin, var_3.origin) < 400) {
      continue;
    }
    var_3 dontcastshadows();
  }
}

enable_scriptable_shadows() {
  var_0 = getscriptablearray();

  foreach(var_2 in var_0) {
    var_2 castdistantshadows();
    var_2 castshadows();
  }
}

finale_trees_delete(var_0) {
  foreach(var_2 in level.fake_trees) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

bomb_plant_scene() {
  var_0 = scripts\sp\maps\lab\lab_lighting.gsc::pipes_hero_light_rig_setup();

  while(!isDefined(level.pipes_bomb))
    waitframe();

  var_1 = scripts\engine\utility::getStruct(level.pipes_bomb.target, "targetname");
  var_0.origin = var_1.origin;
  thread scripts\sp\maps\lab\lab_lighting.gsc::enable_pipes_hero_lights();
  childthread bomb_plant_dialog();
  kyle_logic_thread();
  visionsetnaked("lab_ending_sss", 2);
  thread scripts\sp\maps\lab\lab_util.gsc::cine_letterboxing_up(1.5);
  thread bomb_plant_cinematic_settings();
  var_2 = scripts\engine\sp\utility::spawn_anim_model("finale_bomb");

  if(var_2 tagexists("j_c4_clacker"))
    var_2 hidepart("j_c4_clacker");

  if(var_2 tagexists("j_trigger"))
    var_2 hidepart("j_trigger");

  var_3 = [level.kyle, level.price, level.finale_heli_intro, var_2];
  level.player allowmelee(0);
  level.player.movespeedscale = 0;
  level.player setmovespeedscale(0);
  thread move_barkov_closer(var_1);
  thread audio_pipes_bomb_plant_start();
  var_1 scripts\sp\player_rig::link_player_to_rig("pipes_bomb_plant_cam", "stand", 1, 0.2, 1, 0, 0, 0, 0);
  scripts\engine\utility::array_thread(var_3, ::play_single_anim_last_frame, var_1, "pipes_bomb_plant");
  var_1 scripts\common\anim::anim_single_solo(level.player_rig, "pipes_bomb_plant_cam");
  level.player allowmelee(1);
  level.finale_heli_intro thread setup_final_shot();
  thread disable_pipes_lights();
}

audio_pipes_bomb_plant_start() {
  wait 0.2;
}

disable_pipes_lights() {
  var_0 = getEntArray("pipes_hero_light", "targetname");

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      var_2 setlightintensity(0);
      var_2 unlink();
      var_2 delete();
    }
  }
}

move_barkov_closer(var_0) {
  level.barkov.streamnode = scripts\engine\utility::spawn_script_origin(var_0.origin, level.finale_heli.angles);
  level.barkov.streamnode scripts\common\anim::anim_first_frame_solo(level.barkov, "finale_intro");
  level.barkov show();
}

play_single_anim_last_frame(var_0, var_1) {
  level endon("start_barkov_scene");
  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  var_0 scripts\common\anim::anim_last_frame_solo(self, var_1);
}

bomb_plant_cinematic_settings() {
  level scripts\engine\sp\utility::dof_enable(5.6, 10);
  wait 2;
  level.price scripts\engine\sp\utility::dof_enable_autofocus(2.8, 2, undefined, undefined, "tag_eye");
  wait 4.5;
  level scripts\engine\sp\utility::dof_enable(2.8, 600, 2, undefined);
  wait 4.75;
  level scripts\engine\sp\utility::dof_disable();
}

setup_final_shot() {
  self hide();
  setup_final_shot_animnode();
}

setup_final_shot_animnode() {
  self.struct = spawnStruct();
  self.struct.origin = (-84.749, 0, -137.265);
  self.struct.angles = (0, 0, 0);
  self.struct scripts\common\anim::anim_first_frame_solo(self, "final_shot");
}

bomb_plant_dialog() {
  level endon("bomb_plant_end");

  foreach(var_1 in scripts\engine\sp\utility::getvehiclearray())
  var_1 scalevolume(0, 0);

  foreach(var_1 in scripts\engine\sp\utility::getvehiclearray())
  var_1 scalevolume(0.15, 10);

  wait 6;
  wait 10;
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say("dx_vom_pri_perspective_swap_barkov_20");
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say("dx_vom_pri_finale_heli_intro_10");
}

kyle_logic_thread() {
  if(!isDefined(level.kyle))
    scripts\sp\maps\lab\lab_util.gsc::spawn_kyle();

  level.kyle scripts\engine\sp\utility::name_hide();
  level.kyle detach(level.kyle.headmodel);

  if(isDefined(level.kyle.hatmodel))
    level.kyle detach(level.kyle.hatmodel);
}

setup_heli_scene() {
  while(!isDefined(level.finale_heli))
    waitframe();

  var_0 = level.finale_heli;
  var_1 = "finale_intro";
  wait 3;
  level.finale_heli.idle_animnode1 = scripts\engine\utility::getStruct("finale_heli_idle1", "targetname");
  level.finale_heli.idle_animnode2 = scripts\engine\utility::getStruct("finale_heli_idle2", "targetname");
  level.finale_heli dontinterpolate();
  level.finale_heli.idle_animnode1 thread scripts\common\anim::anim_loop_solo(level.finale_heli, "finale_sway", "stop_heli_loop");
  level.finale_heli hideallparts();
  level.alt_rig = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  level.alt_rig setModel("viewhands_farah_55inch_wind");
  level.alt_rig dontcastshadows();
  level.alt_rig linkTo(var_0);
  level.alt_rig linkTo(var_0);
  level.alt_rig hide();
  var_0 scripts\common\anim::anim_first_frame_solo(level.alt_rig, var_1 + "_cam");
  level.farah linkTo(var_0);
  level.farah hide();
  var_0 scripts\common\anim::anim_first_frame_solo(level.farah, var_1);
  level.finale_heli.pilot hide();
  level.farah scripts\engine\sp\utility::name_hide();
  thread audio_start_ramp_emitters();
}

audio_start_ramp_emitters() {
  level.sfx_heli_ramp_left = spawn("script_origin", level.finale_heli.origin + (-150, -350, -80));
  level.sfx_heli_ramp_left linkTo(level.finale_heli);
  level.sfx_heli_ramp_right = spawn("script_origin", level.finale_heli.origin + (-350, -150, -80));
  level.sfx_heli_ramp_right linkTo(level.finale_heli);
  level.sfx_heli_ramp_center = spawn("script_origin", level.finale_heli.origin + (-250, -250, -80));
  level.sfx_heli_ramp_center linkTo(level.finale_heli);
  level.sfx_heli_ramp_left playLoopSound("emt_lab_heli_ramp_wind_left");
  level.sfx_heli_ramp_right playLoopSound("emt_lab_heli_ramp_wind_right");
  level.sfx_heli_ramp_center playLoopSound("emt_lab_heli_ramp_wind_center");
}

heli_intro_scene() {
  level.finale_heli showallparts();
  level.finale_heli.pilot show();
  thread finale_extras_setup();
  level.player_rig finale_cam_anim(level.finale_heli, "finale_intro");
}

finale_cam_anim(var_0, var_1) {
  var_2 = scripts\engine\utility::getanim(var_1 + "_cam");
  var_3 = getstartorigin(var_0.origin, var_0.angles, var_2);
  var_4 = getstartangles(var_0.origin, var_0.angles, var_2);
  scripts\sp\hud_util::fade_out(0);
  scripts\sp\player_rig::unlink_player_from_rig(0, "prone", 1);
  level.finale_heli finale_show_heli();
  level.barkov.propmodel = spawn("script_model", level.barkov.origin);
  level.barkov.propmodel setModel("parts_radio_small");
  level.player hideviewmodel();
  level.player modifybasefov(45, 0.05);
  level.alt_rig dontinterpolate();
  level.player dontinterpolate();
  level.player setOrigin(var_3);
  level.player setplayerangles(var_4);
  var_0 link_player_to_set_rig(level.alt_rig, var_1 + "_cam", "prone", 0, undefined, 1);
  level notify("finale_intro_start");
  thread cine_cam_settings();
  thread finale_cam_other_anims(var_0, var_1);
  finale_cam_player_anims(var_0, var_1 + "_cam");
  thread finale_cam_extras();
  thread finale_cam_finish(var_0, var_1);
}

finale_cam_extras() {
  level.alt_rig hide();
  level.player showviewmodel();
  level.player setcinematicmotionoverride("iw8_heli_ride");
  level notify("finale_intro_end");
  level.finale_heli.idle_animnode1 scripts\engine\sp\utility::notify_delay("stop_heli_loop", 0.15);
  level.finale_heli thread hover_pattern_internal();
}

hover_pattern_internal() {
  level endon("barkov_dead");
  var_0 = scripts\engine\utility::getStruct("finale_path_end", "targetname");
  change_yaw_angle(var_0);
  var_0 = scripts\engine\utility::getStruct("ending_path_start", "targetname");
  scripts\engine\sp\utility::flagwaitthread("start_choking_scene", ::change_yaw_angle, var_0);
  self setyawspeed(14, 2, 2);

  for(;;) {
    self setgoalyaw(level.heli_yaw["left"]);
    wait(randomfloatrange(1, 1.75));
    self setgoalyaw(level.heli_yaw["angles"]);
    wait(randomfloatrange(1, 1.75));
    self setgoalyaw(level.heli_yaw["right"]);
    wait(randomfloatrange(1, 1.75));
    self setgoalyaw(level.heli_yaw["angles"]);
    wait(randomfloatrange(1, 1.75));
  }
}

change_yaw_angle(var_0) {
  level.heli_yaw["angles"] = var_0.angles[1];
  level.heli_yaw["left"] = level.heli_yaw["angles"] + 2;
  level.heli_yaw["right"] = level.heli_yaw["angles"] - 2;
}

cine_cam_settings() {
  waitframe();
  setsaveddvar("SLSMSSTQP", 0.1);
  level.barkov scripts\engine\sp\utility::dof_enable_autofocus(2.8, 500, undefined, undefined, "tag_eye", undefined, 1);
  wait 3;
  level scripts\engine\sp\utility::dof_enable(2, 70);
  wait 3;
  level scripts\engine\sp\utility::dof_enable(2, 60);
  wait 2;
  level.player modifybasefov(55, 4);
  level.farah scripts\engine\sp\utility::dof_enable_autofocus(2.8, 1, undefined, undefined, "tag_eye", undefined, 1);
  wait 2;
  level.farah scripts\engine\sp\utility::dof_enable_autofocus(2.8, 5, undefined, undefined, "tag_eye", undefined, 1);
  wait 2;
  scripts\engine\sp\utility::dof_disable();
}

delete_allies() {
  level.kyle scripts\sp\maps\lab\lab_util.gsc::disable_magic_bullet_delete();
  level.price scripts\sp\maps\lab\lab_util.gsc::disable_magic_bullet_delete();
  level.rebel_1.spawner notify("stop_rebel_flood");
  level.rebel_1 scripts\sp\maps\lab\lab_util.gsc::disable_magic_bullet_delete();
  level.rebel_2.spawner notify("stop_rebel_flood");
  level.rebel_2 scripts\sp\maps\lab\lab_util.gsc::disable_magic_bullet_delete();
  level.rebel_3.spawner notify("stop_rebel_flood");
  level.rebel_3 scripts\sp\maps\lab\lab_util.gsc::disable_magic_bullet_delete();
}

finale_show_heli() {
  self showallparts();

  foreach(var_1 in self.nets)
  var_1 show();

  var_3 = scripts\engine\utility::array_combine(getEntArray("heli_nets", "targetname"), getEntArray("finale_heliTarp", "targetname"));

  foreach(var_5 in var_3)
  var_5 show();

  thread fix_heli_blades();
}

finale_cam_finish(var_0, var_1) {
  thread farah_as_player_vo();
  wait 0.05;
  level.alt_rig hide();
  unlink_player_from_set_rig(level.alt_rig, 0, "prone", 1, 1);
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 1);
  level.player setentitysoundcontext("gender", "female", 0.1);
  thread start_heli_shake();
  thread finale_knockdown_scene_setup_rig(var_0);
  level.barkov scripts\engine\utility::delaycall(0.2, ::setlookattext, "Gen. Barkov", &"");
  var_2 = scripts\engine\utility::getStruct("finale_path_start", "targetname");
  var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");

  if(!level.finale_heli scripts\common\vehicle::ishelicopter())
    level.finale_heli attachpath(var_2);

  level.finale_heli thread scripts\common\vehicle::vehicle_paths(var_2);
  scripts\common\vehicle_paths::gopath(level.finale_heli);
  level.finale_heli vehicle_setspeed(23, 5, 5);
  level.finale_heli.oob_enabled = 1;
  level.finale_heli thread player_is_outofbounds();
  thread setup_bodies_for_streaming(var_0);
}

finale_cam_finish_kickoff(var_0, var_1) {
  level.player showviewmodel();
  level.player showlegsandshadow();
  wait 0.3;
  level.alt_rig hide();
  unlink_player_from_set_rig(level.alt_rig, 0, "prone", 1, 1);
  level.player setentitysoundcontext("gender", "female", 0.1);
  thread finale_knockdown_scene_setup_rig(var_0);
  level.barkov scripts\engine\utility::delaycall(0.2, ::setlookattext, "Gen. Barkov", &"");
  level.finale_heli.oob_enabled = 1;
  level.finale_heli thread player_is_outofbounds();
  thread setup_bodies_for_streaming(var_0);
}

farah_as_player_vo() {
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_finale_heli_intro_12");
  wait 0.3;
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_finale_heli_intro_13");
}

setup_bodies_for_streaming(var_0) {
  level.barkovfakebodies = [];
  var_1 = ["body_villain_barkov_wind_all_stab_1", "body_villain_barkov_wind_all_stab_2", "body_villain_barkov_wind_all_stab_3", "body_villain_barkov_wind_all_stab_4", "body_villain_barkov_wind_all_stab_5", "body_villain_barkov_wind_all_stab_6", "body_villain_barkov_wind_gun_stab_3", "body_villain_barkov_wind_gun_stab_4", "body_villain_barkov_wind_gun_stab_5", "body_villain_barkov_wind_gun_stab_6", "head_villain_barkov_stab_5_blendshape"];

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    thread spawn_in_streaming_bodies(var_0, var_1[var_2]);

  level scripts\engine\utility::waittill_any("barkov_dead", "stop_screen_shake");
  scripts\engine\utility::array_delete(level.barkovfakebodies);
}

spawn_in_streaming_bodies(var_0, var_1) {
  if(var_1 == "head_villain_barkov_stab_5_blendshape") {
    var_2 = havemapentseffects("actor_enemy_villain_barkov_old", var_0.origin, var_0.angles, 1, 0, 1);
    var_2.ignoreme = 1;
    var_2.ignoreall = 1;
    var_2 scripts\engine\utility::disable_pain();
    var_2 scripts\sp\utility::context_melee_enable(0);
    var_2 scripts\engine\sp\utility::battlechatter_off();
    var_2 scripts\engine\sp\utility::name_hide();
    var_2 scripts\engine\sp\utility::disable_bulletwhizbyreaction();
    var_2 scripts\engine\sp\utility::disable_danger_react();
    var_2 scripts\engine\sp\utility::disable_surprise();
    var_2 scripts\engine\sp\utility::disable_damagefeedback();
    var_2 scripts\common\ai::gun_remove();
    var_2 linkTo(var_0, "tag_origin", (166.5, -0.5, -110), (0, 0, 0));
    var_2 detach(var_2.headmodel);
    var_2 attach(var_1);
    var_2 visiblenotsolid();
  } else {
    var_2 = spawn("script_model", var_0.origin);
    var_2 linkTo(var_0, "tag_origin", (166.5, -0.5, -110), (0, 0, 0));
    var_2 setModel(var_1);
    var_2 notsolid();
  }

  var_2 dontcastshadows();
  level.barkovfakebodies[level.barkovfakebodies.size] = var_2;
}

finale_cam_player_anims(var_0, var_1) {
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var_2 = scripts\engine\utility::getanim(var_1 + "_end");
  var_3 = getstartorigin(var_0.origin, var_0.angles, var_2);
  var_4 = getstartangles(var_0.origin, var_0.angles, var_2);
  level.player showviewmodel();
  scripts\engine\utility::delaythread(0.1, scripts\sp\hud_util::fade_in, 0);
  level.player dontinterpolate();
  level.alt_rig dontinterpolate();
  var_0 scripts\common\anim::anim_single_solo(level.alt_rig, var_1);
  unlink_player_from_set_rig(level.alt_rig, 0, "prone", 1, 1);
  level notify("player_is_prone_and_in_control");
  level.player dontinterpolate();
  level.player setOrigin(var_3);
  level.player setplayerangles(var_4);
  level.alt_rig dontinterpolate();
  level.player dontinterpolate();
  var_0 link_player_to_set_rig(level.alt_rig, var_1 + "_end", "prone", 0, undefined, 1);
}

start_heli_shake() {
  level endon("stop_screen_shake");
  level.og_mbradial = getdvarint("NMORQOTSK");

  if(isplatformps4())
    setsaveddvar("NMORQOTSK", 3);
  else
    setsaveddvar("NMORQOTSK", 4);

  for(;;) {
    level.player screenshakeonentity(0.2, 0.5, 0.4, 5, 0, 0, 1000, 6, 1.8, 50);
    wait 5;
  }
}

rand_num(var_0, var_1) {
  var_2 = randomfloatrange(var_0 - var_1, var_0 + var_1);
  return var_2;
}

finale_cam_other_anims(var_0, var_1) {
  showmayhem("mayh_lab_heli_tarp");
  thread audio_finale_heli_start();
  level.farah thread finale_cam_farah_anims(var_0, var_1);
  level.barkov thread finale_cam_barkov_anims(var_0, var_1);
  thread start_fake_combat_below();
}

audio_finale_heli_start() {
  level waittill("start_tarp_sim");
  level waittill("player_is_prone_and_in_control");
}

finale_cam_farah_anims(var_0, var_1) {
  self show();
  self dontinterpolate();
  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  self hide();
  level.knife hide();
  hidemayhem("mayh_lab_heli_tarp");
}

finale_cam_barkov_anims(var_0, var_1) {
  self show();
  self linkTo(var_0);
  self dontinterpolate();
  var_0 thread scripts\common\anim::anim_single_solo(self, var_1);
  self.propmodel linkTo(self, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
  scripts\engine\utility::delaythread(6, ::barkov_wind_change);
  wait 9;
  self dontinterpolate();
  var_0 thread scripts\common\anim::anim_loop_solo(self, var_1 + "_idle", "stop_finale_intro_idle");
  level waittill("finale_intro_end");
}

barkov_wind_change() {
  self setModel("body_villain_barkov_wind");
}

finale_knockdown_scene_setup_rig(var_0) {
  level.alt_rig hide();
  level.alt_rig linkTo(var_0);
  var_0 scripts\common\anim::anim_first_frame_solo(level.alt_rig, "finale_knock_down");
}

finale_kick_scene_setup_rig(var_0) {
  level.alt_rig hide();
  level.alt_rig linkTo(var_0);
  var_0 scripts\common\anim::anim_first_frame_solo(level.alt_rig, "finale_stabbed");
}

finale_extras_setup() {
  setomnvar("ui_hide_hud", 1);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  setomnvar("ui_hide_weapon_info", 1);
  thread player_waittill_player_death();
}

player_waittill_player_death() {
  level.player waittill("death");
  setomnvar("ui_hide_hud", 0);
}

link_player_to_set_rig(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_0.allows))
    set_player_set_rig_allows(var_0);

  var_0 hide();

  if(isDefined(var_1))
    thread scripts\common\anim::anim_first_frame_solo(var_0, var_1);

  var_0.ogstance = level.player getstance();

  if(!isDefined(var_2))
    var_2 = "stand";

  var_0.stance = var_2;

  switch (var_2) {
    case "stand":
      level.player scripts\common\utility::allow_crouch(0, "player_rig");
      level.player scripts\common\utility::allow_prone(0, "player_rig");
      break;
    case "crouch":
      level.player scripts\common\utility::allow_stand(0, "player_rig");
      level.player scripts\common\utility::allow_prone(0, "player_rig");
      break;
    case "prone":
      level.player scripts\common\utility::allow_stand(0, "player_rig");
      level.player scripts\common\utility::allow_crouch(0, "player_rig");
      break;
  }

  level.player setstance(var_2);
  level.player enablequickweaponswitch(1);
  level.player scripts\common\utility::allow_array(var_0.allows, 0, "player_rig");

  if(!isDefined(var_3))
    var_3 = 1;

  if(var_3) {
    if(!isDefined(var_4))
      var_4 = 0.2;

    level.player playerlinktoblend(var_0, "tag_player", var_4);
    wait(var_4);
    waitframe();
  }

  if(istrue(var_5))
    level.player playerlinktoabsolute(var_0, "tag_player");
  else {
    if(!isDefined(var_10))
      var_10 = 0;

    if(!isDefined(var_6))
      var_6 = 45;

    if(!isDefined(var_7))
      var_7 = 45;

    if(!isDefined(var_8))
      var_8 = 15;

    if(!isDefined(var_9))
      var_9 = 15;

    level.player playerlinktodelta(var_0, "tag_player", 1, var_6, var_7, var_8, var_9, var_10);
  }

  var_0 show();
  return var_0;
}

set_player_set_rig_allows(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = ["weapon", "offhand_weapons", "melee", "sprint", "jump", "mantle"];

  var_0.allows = var_1;
}

unlink_player_from_set_rig(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\engine\utility::is_equal(level.player getlinkedparent(), var_0)) {
    return;
  }
  switch (var_0.stance) {
    case "stand":
      level.player scripts\common\utility::allow_crouch(1, "player_rig");
      level.player scripts\common\utility::allow_prone(1, "player_rig");
      break;
    case "crouch":
      level.player scripts\common\utility::allow_stand(1, "player_rig");
      level.player scripts\common\utility::allow_prone(1, "player_rig");
      break;
    case "prone":
      level.player scripts\common\utility::allow_stand(1, "player_rig");
      level.player scripts\common\utility::allow_crouch(1, "player_rig");
      break;
  }

  if(istrue(var_1))
    var_2 = var_0.ogstance;

  if(isDefined(var_2)) {
    if(istrue(var_3))
      level.player setstance(var_2, 1, 1, 1);
    else if(var_2 != var_0.stance)
      level.player setstance(var_2);
  }

  level.player unlink();
  level.player enablequickweaponswitch(0);
  level.player scripts\common\utility::allow_array(var_0.allows, 1, "player_rig");

  if(!istrue(var_4))
    var_0 delete();
}

finale_heli_start() {
  thread place_finale_trees("finale_scene_trees_finalshot");
  finale_heli_setup();
  var_0 = "finale_intro";
  var_1 = level.finale_heli;
  level.finale_heli_intro thread setup_final_shot();
  level.finale_heli.idle_animnode1 = scripts\engine\utility::getStruct("finale_heli_idle1", "targetname");
  level.finale_heli.idle_animnode2 = scripts\engine\utility::getStruct("finale_heli_idle2", "targetname");
  level.finale_heli.idle_animnode1 thread scripts\common\anim::anim_loop_solo(level.finale_heli, "finale_sway", "stop_heli_loop");
  level.barkov linkTo(var_1);
  level.farah linkTo(var_1);
  var_1 thread scripts\common\anim::anim_loop_solo(level.barkov, var_0 + "_idle", "stop_finale_intro_idle");
  var_1 scripts\common\anim::anim_first_frame_solo(level.farah, "finale_kickoff_sh01");
  level.barkov show();
  level.barkov barkov_wind_change();
  level.finale_heli finale_show_heli();
  level.barkov.propmodel = spawn("script_model", level.barkov.origin);
  level.barkov.propmodel setModel("parts_radio_small");
  level.barkov.propmodel linkTo(level.barkov, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
  level.price = scripts\engine\utility::spawn_script_origin();
  thread finale_extras_setup();
  level.player modifybasefov(55, 0.05);
  visionsetnaked("lab_ending_sss");
  level.og_zplanes = getDvar("OMNONNMOTP");
  level.player hideviewmodel();
  level.player hidelegsandshadow();
  level.alt_rig = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  level.alt_rig setModel("viewhands_farah_55inch_wind");
  level.alt_rig dontcastshadows();
  var_1 link_player_to_set_rig(level.alt_rig, var_0 + "_cam_end", "prone", 0, undefined, 1);
  level.finale_heli.idle_animnode1 scripts\engine\sp\utility::notify_delay("stop_heli_loop", 0.3);
  thread finale_cam_finish(var_1, var_0);
  level.player setstance("prone", 1, 1, 1);
  level.player showviewmodel();
  thread setup_player_last_frame(var_1, var_0);
  thread start_heli_shake();
  thread start_fake_combat_below();
}

finale_heli_main() {
  thread players_health_as_farah();
  level.barkov.anim_playvo_func = scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue_on_tag;
  level.barkov thread barkov_damage(level.finale_heli);
  boss_fight_intro();
  scripts\engine\utility::flag_wait("ready_for_kickoff");
}

finale_heli_catchup() {}

players_health_as_farah() {
  var_0 = 60;

  if(level.gameskill == 3)
    var_0 = 80;
  else if(level.gameskill == 0)
    var_0 = 45;

  level.player scripts\sp\player::set_player_max_health(var_0);
  level.player scripts\sp\player::scale_player_death_shield_duration(0.1);
}

start_fake_combat_below() {
  createthreatbiasgroup("heli_farah");
  createthreatbiasgroup("heli_barkov");
  createthreatbiasgroup("ground_allies");
  level.player setthreatbiasgroup("heli_farah");
  level.barkov setthreatbiasgroup("heli_barkov");
  setignoremegroup("heli_farah", "axis");
  setignoremegroup("heli_barkov", "allies");
  setignoremegroup("ground_allies", "heli_barkov");
  level.finale_heli.ignoreme = 1;
  level.finale_combat_ai = [];

  for(var_0 = 1; var_0 < 6; var_0++)
    thread fake_ally_setup(var_0);

  scripts\engine\sp\utility::activate_trigger_with_targetname("fake_ally_trigger");

  for(var_0 = 1; var_0 < 6; var_0++)
    thread fake_enemy_setup(var_0);

  thread sfx_dist_battle();
}

sfx_dist_battle() {
  var_0 = spawn("script_origin", (1076, 2119, 383));
  var_0 playLoopSound("emt_dist_battle_lp");
  level waittill("stop_spawning_finale_combat");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(3, 1);
}

fake_ally_setup(var_0) {
  level endon("stop_spawning_finale_combat");
  var_1 = getspawner("redshirt_rebel_" + var_0, "targetname");
  var_2 = var_1 stalingradspawn();
  var_2 childthread fake_ally_death_watcher(var_0);
  var_2 setthreatbiasgroup("ground_allies");
  level.finale_combat_ai[var_0 - 1] = var_2;
  var_2 dontcastdistantshadows();
  var_2 endon("death");
  wait 0.1;
  var_3 = scripts\engine\utility::getStruct("fake_ally_struct_" + var_0, "targetname");
  var_2 forceteleport(var_3.origin, var_3.angles);
  wait 0.1;
  var_2 scripts\engine\sp\utility::set_force_color("o");
}

fake_ally_death_watcher(var_0) {
  self waittill("death");
  wait 1;
  thread fake_ally_setup(var_0);
}

fake_enemy_setup(var_0) {
  level endon("stop_spawning_finale_combat");
  var_1 = getEnt("fake_enemy_volume", "targetname");
  var_2 = getspawner("fake_combat_enemy_" + var_0, "targetname");
  var_3 = var_2 stalingradspawn();
  var_3 childthread fake_enemy_death_watcher(var_0);
  level.finale_combat_ai[var_0 + 4] = var_3;
  var_3 dontcastdistantshadows();
  var_3 endon("death");
  wait 0.1;
  var_4 = scripts\engine\utility::getStruct("fake_enemy_struct_" + var_0, "targetname");
  var_3 forceteleport(var_4.origin, var_4.angles);
  wait 0.1;
  var_3 setgoalvolumeauto(var_1);
}

fake_enemy_death_watcher(var_0) {
  self waittill("death");
  wait 1;
  thread fake_enemy_setup(var_0);
}

setup_player_last_frame(var_0, var_1) {
  level.player dontinterpolate();
  var_0 scripts\common\anim::anim_first_frame_solo(level.alt_rig, var_1 + "_cam_end");
}

boss_fight_intro() {
  finale_player_setup();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);

  foreach(var_1 in level.heroes) {
    if(isDefined(var_1)) {
      var_1.ignoreme = 1;
      var_1.ignoreall = 1;
    }
  }

  thread choke_screen_effects();
  level.player notifyonplayercommand("melee_pressed", "+melee");
  level.player notifyonplayercommand("melee_pressed", "+melee_zoom");
  level.player notifyonplayercommand("melee_pressed", "+melee_sprint");
  level.player notifyonplayercommand("melee_pressed", "+melee_breath");
  level.player notifyonplayercommand("attack_pressed", "+attack");
  level.player notifyonplayercommand("ads_pressed", "+speed_throw");
  scripts\engine\utility::flag_set("finale_scene");
  scripts\engine\sp\utility::autosave_by_name("heli_scene");
  level.finale_heli thread swap_clip();
}

finale_player_setup() {
  level.player setsuit("iw8_teenager_combat");
  level.player takeallweapons();
  scripts\engine\sp\utility::blend_movespeedscale(0.7, 1);
  scripts\sp\maps\lab\lab_util.gsc::setplayerviewmodel("viewhands_farah_55inch", undefined, "default_character_shadow");
  level.scr_model["player_rig"] = "viewhands_farah_55inch_wind";
  scripts\sp\utility::context_melee_set_arms("viewhands_farah_55inch_wind");
  var_0[0] = scripts\sp\utility::make_weapon("iw8_farahknife_sp");
  var_0[1] = scripts\sp\utility::make_weapon("iw8_pi_golf21_tfarah");

  foreach(var_2 in var_0)
  level.player giveweapon(var_2);

  level.player switchtoweapon(var_0[0]);
}

swap_clip() {
  level.barkov endon("death");

  for(;;) {
    waitframe();

    if(level.player getstance() != "prone" && distancesquared(level.player.origin, level.barkov.origin) > 100 & 100) {
      break;
    }
  }
}

finale_kickoff_start() {
  thread place_finale_trees("finale_scene_trees_finalshot");
  thread disable_scriptable_shadows();
  finale_heli_setup();
  var_0 = "finale_intro";
  var_1 = level.finale_heli;
  level.finale_heli.clip_stand delete();
  level.finale_heli.clip_crawl delete();
  scripts\engine\utility::delaythread(0.3, ::finale_player_setup);
  level.finale_heli_intro thread setup_final_shot();
  level.finale_heli.idle_animnode1 = scripts\engine\utility::getStruct("finale_heli_idle1", "targetname");
  level.finale_heli.idle_animnode2 = scripts\engine\utility::getStruct("finale_heli_idle2", "targetname");
  level.finale_heli.idle_animnode2 thread scripts\common\anim::anim_loop_solo(level.finale_heli, "finale_sway", "stop_heli_loop");
  level.barkov linkTo(var_1);
  level.farah linkTo(var_1);
  level.barkov.iscompletelydead = 1;
  var_1 thread scripts\common\anim::anim_loop_solo(level.barkov, "finale_death_stabbed_idle", "finale_idle");
  var_1 scripts\common\anim::anim_first_frame_solo(level.farah, "finale_kickoff_sh01");
  level.barkov show();
  level.barkov barkov_wind_change();
  level.barkov.kickoffstart = "finale_kickoff_start_alt";
  level.finale_heli finale_show_heli();
  level.kickout = 0;
  level.finale_heli.started_second_position = 1;
  level.price = scripts\engine\utility::spawn_script_origin();
  thread finale_extras_setup();
  level.player modifybasefov(55, 0.05);
  visionsetnaked("lab_ending_sss");
  level.og_zplanes = getDvar("OMNONNMOTP");
  level.player hideviewmodel();
  level.player hidelegsandshadow();
  level.alt_rig = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  level.alt_rig setModel("viewhands_farah_55inch_wind");
  level.alt_rig dontcastshadows();
  var_1 link_player_to_set_rig(level.alt_rig, var_0 + "_cam_end", "prone", 0, undefined, 1);
  level.finale_heli.idle_animnode2 scripts\engine\sp\utility::notify_delay("stop_heli_loop", 0.3);
  thread finale_cam_finish_kickoff(var_1, var_0);
  level.player setstance("prone", 1, 1, 1);
  thread setup_player_last_frame(var_1, var_0);
  thread start_heli_shake();
  thread start_fake_combat_below();
}

finale_kickoff_main() {
  level.barkov barkov_kick_out_scene(level.finale_heli, level.kickout);
  scripts\engine\utility::flag_wait("barkov_dead");
}

finale_kickoff_catchup() {}

barkov_kick_out_scene(var_0, var_1) {
  scripts\engine\utility::delaythread(0.2, scripts\engine\sp\utility::autosave_now);
  thread can_be_shot_again(var_0);
  dialogue_wheel_start();
  setomnvar("ui_dialogue_prompts_active", 0);
  setsaveddvar("OMNONNMOTP", "0.1 400 2 1000");
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  level notify("barkov_dead");
  level notify("end_longdeath_lines");
  thread heli_final_path();
  thread barkov_damage_ending(var_0);
  scripts\engine\utility::flag_set("kick_lines");
  scripts\sp\player\cursor_hint::remove_cursor_hint();
}

can_be_shot_again(var_0) {
  level endon("barkov_dead");

  if(!istrue(self.iscompletelydead)) {
    self waittill("damage");
    var_0 notify("finale_idle");
    long_death_barkov(0);
  }
}

barkov_damage_ending(var_0) {
  level.player modifybasefov(55, 4);
  level.alt_rig linkTo(var_0);
  var_0 link_player_to_set_rig(level.alt_rig, self.kickoffstart, "stand", 0, undefined, 0, 25, 25, 25, 25, 1);
  thread barkov_damage_ending_setup();

  if(self.iscompletelydead) {
    var_0 scripts\common\anim::anim_single_solo(level.alt_rig, self.kickoffstart);
    var_0 scripts\common\anim::anim_last_frame_solo(level.alt_rig, self.kickoffstart);
    self notify("longdeath_ender");
    var_0 notify("finale_idle");
  } else {
    self notify("longdeath_ender");
    var_0 notify("finale_idle");
    var_0 scripts\common\anim::anim_single([level.alt_rig, self], self.kickoffstart);
    var_0 scripts\common\anim::anim_last_frame_solo(level.alt_rig, self.kickoffstart);
    var_0 scripts\common\anim::anim_last_frame_solo(level.barkov, self.kickoffstart);
  }

  thread finale_skip();
  finale_skippable_section(var_0);
  scripts\sp\utility::userskip_stop();
  thread scripts\sp\analytics::analytics_kleenex_update("end_stopwatch");
  level thread scripts\sp\utility::giveachievement_wrapper("finish", 1);

  if(level.lowestgameskill + 1 > 3) {
    var_1 = 1;
    var_2 = level.player getlocalplayerprofiledata("missionHighestDifficulty");

    for(var_3 = 0; var_3 < 13; var_3++) {
      if(var_2[var_3] != "4" && var_2[var_3] != "5") {
        var_1 = undefined;
        break;
      }
    }

    if(istrue(var_1))
      level thread scripts\sp\utility::giveachievement_wrapper("vetfinish", 1);
  }

  level thread lab_ending_bink();
}

barkov_damage_ending_setup() {
  level.alt_rig hide();
  level.alt_rig scripts\engine\utility::delaycall(0.5, ::show);
  thread scripts\sp\maps\lab\lab_util.gsc::cine_letterboxing_up(1.5);
  thread kickoff_cinematic_settings();
  level.player lerpfovscalefactor(0, 1.5);
  level.player lerpviewangleclamp(1.5, 0.3, 0.3, 0, 0, 0, 0);
}

finale_skippable_section(var_0) {
  level endon("skip_end_scene");
  childthread kickoff_setup();
  childthread cleanup_finale_combat_guys(37);
  level.barkov childthread barkov_kickoff_anim(var_0);
  var_0 thread scripts\common\anim::anim_single_solo(level.farah, "finale_kickoff_sh01");
  var_0 scripts\common\anim::anim_single_solo(level.alt_rig, "finale_kickoff_sh01");
  childthread halt_heli_end_movement(0.1);
  wait 0.1;
  var_1 = level.alt_rig scripts\engine\utility::getanim("finale_kickoff_sh02");
  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1);
  var_3 = getstartangles(var_0.origin, var_0.angles, var_1);
  scripts\engine\utility::flag_set("barkov_dead");
  scripts\sp\hud_util::fade_out(0);
  unlink_player_from_set_rig(level.alt_rig, 0, undefined, 0, 1);
  level.finale_heli_intro.struct scripts\common\anim::anim_first_frame_solo(level.alt_rig, "final_shot");
  level.player dontinterpolate();
  level.player setOrigin(var_2);
  level.player setplayerangles(var_3);
  var_0 scripts\sp\player_rig::link_player_to_rig("finale_kickoff_sh02", "stand", 0, undefined, 1);
  level.player_rig linkTo(var_0);
  level.player_rig dontinterpolate();
  level.player_rig hide();
  var_4 = [level.player_rig, level.farah, level.finale_heli.pilot, level.finale_heli];
  level.finale_heli.pilot show();
  level.farah childthread farah_body_swap_again();
  childthread trigger_hill_destruction();
  childthread audio_finale_cockpit_shot();
  thread mus_cockpit_finale();
  scripts\sp\hud_util::fade_in(0.05);
  thread fix_heli_blades();
  level.farah dontinterpolate();
  level.player dontinterpolate();
  level.player_rig dontinterpolate();
  var_0 scripts\common\anim::anim_single(var_4, "finale_kickoff_sh02");
  scripts\sp\hud_util::fade_out(0);
  thread fix_heli_blades();
  var_0 scripts\common\anim::anim_last_frame_solo(level.farah, "finale_kickoff_sh02");
  var_0 scripts\common\anim::anim_last_frame_solo(level.finale_heli.pilot, "finale_kickoff_sh02");
  scripts\engine\utility::exploder("final_damage");
  childthread audio_final_shot_start();
  var_1 = level.alt_rig scripts\engine\utility::getanim("final_shot");
  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1);
  var_3 = getstartangles(var_0.origin, var_0.angles, var_1);
  scripts\sp\player_rig::unlink_player_from_rig(0, "prone", 1, 1);
  level.player dontinterpolate();
  level.player setOrigin(var_2);
  level.player setplayerangles(var_3);
  finale_shot_cleanup();
  level.finale_heli_intro.struct link_player_to_set_rig(level.alt_rig, "final_shot", "stand", 0, undefined, 1);
  level.finale_heli_intro show();
  level.alt_rig hide();
  scripts\sp\hud_util::fade_in(0.05);
  level.finale_heli_intro.struct scripts\common\anim::anim_single([level.finale_heli_intro, level.alt_rig], "final_shot");
  wait 4;
  level.endhud fadeinscreen(0.01);
}

audio_finale_cockpit_shot() {
  level.player clearsoundsubmix("sp_lab_ending_duck_1", 0.2);
}

audio_final_shot_start() {
  if(isDefined(level.sfx_heli_ramp_left))
    level.sfx_heli_ramp_left thread scripts\engine\sp\utility::sound_fade_and_delete(0.2, 1);

  if(isDefined(level.sfx_heli_ramp_right))
    level.sfx_heli_ramp_right thread scripts\engine\sp\utility::sound_fade_and_delete(0.2, 1);

  if(isDefined(level.sfx_heli_ramp_center))
    level.sfx_heli_ramp_center thread scripts\engine\sp\utility::sound_fade_and_delete(0.2, 1);

  level.player setclienttriggeraudiozone("lab_hillside", 0.1);
  level.player playSound("scn_lab_final_heli_flyover_lr");
  wait 3.0;
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 3.0);
}

trigger_hill_destruction() {
  childthread place_finale_trees("finale_scene_trees_finalshot");
  childthread enable_scriptable_shadows();
  var_0 = getscriptablearray("rockable_car", "targetname");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("body", "dead");
    var_2 stopsounds();
    playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_md"), var_2.origin + (0, 0, 30));
  }

  childthread trigger_hill_trees();
  var_4 = getscriptablearray("guard_tower", "script_noteworthy");

  foreach(var_6 in var_4) {
    var_6 setscriptablepartstate("base", "exploded", 1);
    playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_lrg"), var_6.origin + (0, 0, 30));
  }

  if(!isDefined(level.tank2)) {
    var_8 = getvehiclenode("hill_mid_start_node", "targetname");
    var_9 = spawn("script_model", var_8.origin);
    var_9.angles = var_8.angles;
    var_9 setModel("veh8_mil_lnd_bromeo_animated_dst");
    playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_lrg"), var_9.origin + (0, 0, 30));
  }

  scripts\engine\utility::exploder("heli_crash_1");
  scripts\engine\utility::exploder("bromeo_death_1");
}

finale_skip() {
  setsaveddvar("OMNONNMOTP", level.og_zplanes);
  var_0 = scripts\sp\utility::userskip_wait();

  if(!var_0) {
    return;
  }
  setmusicstate("mx_lab_null");
  scripts\sp\hud_util::fade_out(0);
  wait 0.2;
  level notify("skip_end_scene");
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 0.5);

  if(isDefined(level.endhud))
    level.endhud destroy();

  if(isDefined(level.farah)) {
    level.farah stopsounds();
    waitframe();
    level.farah scripts\sp\maps\lab\lab_util.gsc::stop_magic_bullet_safe();
    level.farah delete();
  }

  if(isDefined(level.price))
    level.price stopsounds();

  if(isDefined(level.alex))
    level.alex stopsounds();

  if(isDefined(level.sfx_heli_ramp_left))
    level.sfx_heli_ramp_left thread scripts\engine\sp\utility::sound_fade_and_delete(0, 1);

  if(isDefined(level.sfx_heli_ramp_right))
    level.sfx_heli_ramp_right thread scripts\engine\sp\utility::sound_fade_and_delete(0, 1);

  if(isDefined(level.sfx_heli_ramp_center))
    level.sfx_heli_ramp_center thread scripts\engine\sp\utility::sound_fade_and_delete(0, 1);

  if(isDefined(level.player_rig))
    level.player_rig stopsounds();

  if(isDefined(level.alt_rig))
    level.alt_rig stopsounds();

  if(isDefined(level.barkov)) {
    level.barkov stopsounds();
    waitframe();
    level.barkov scripts\sp\maps\lab\lab_util.gsc::stop_magic_bullet_safe();
    level.barkov delete();
  }

  if(isDefined(level.finale_heli) && isDefined(level.finale_heli.pilot)) {
    level.finale_heli.pilot scripts\sp\maps\lab\lab_util.gsc::stop_magic_bullet_safe();
    level.finale_heli.pilot delete();
  }

  if(isDefined(level.finale_heli))
    level.finale_heli delete();

  if(isDefined(level.finale_heli_intro))
    level.finale_heli_intro delete();

  scripts\engine\utility::flag_set("barkov_dead");
  thread cleanup_finale_combat_guys(0.1);
  setsaveddvar("NMORQOTSK", level.og_mbradial);
  scripts\sp\maps\lab\lab_util.gsc::cine_letterboxing_down(0);
  wait 0.2;
  scripts\engine\utility::delaythread(0.05, scripts\sp\hud_util::fade_in, 0.05);

  if(isDefined(level.kyle))
    level.kyle delete();
}

kickoff_setup() {
  level.alt_rig hide();
  thread ending_cleanup();
  level.farah scripts\engine\utility::delaycall(0.5, ::show);
  level.farah scripts\engine\sp\utility::name_hide();
  level.farah thread farah_body_swap();
  level.player scripts\engine\utility::delaycall(0.2, ::clearcinematicmotionoverride);
  wait 1.5;
  setsaveddvar("NMORQOTSK", level.og_mbradial);
  level notify("stop_screen_shake");
  level.player screenshakeonentity(0.2, 0.5, 0.4, 14, 0, 8, 1000, 6, 1.8, 50);
}

cleanup_finale_combat_guys(var_0) {
  wait(var_0);
  level notify("stop_spawning_finale_combat");

  foreach(var_3, var_2 in level.finale_combat_ai) {
    if(var_3 < 5) {
      var_2 thread cleanup_ai();
      continue;
    }

    var_2 scripts\engine\utility::delaythread(8, ::cleanup_ai);
  }
}

cleanup_ai() {
  if(isDefined(self) && isalive(self))
    self kill();
}

farah_body_swap() {
  self.og_model = self.model;
  self setModel("body_hero_farah_wind");
  self.og_headmodel = self.headmodel;
  self detach(self.headmodel);
  self attach("head_hero_farah_wind");
  self.headmodel = "head_hero_farah_wind";
}

farah_body_swap_again() {
  self setModel(self.og_model);
  self detach(self.headmodel);
  self attach(self.og_headmodel);
  self.headmodel = self.og_headmodel;
}

trigger_hill_trees() {
  var_0 = getscriptablearray("spruce_02", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("base", "death");
    playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_sml"), var_2.origin + (0, 0, 130));
  }
}

kickoff_cinematic_settings() {
  level.barkov scripts\engine\sp\utility::dof_enable_autofocus(5.6, 1, undefined, undefined, "tag_eye");
  wait 9;
  level scripts\engine\sp\utility::dof_enable(2.8, 30, 1, 0);
  wait 6;
  level.farah scripts\engine\sp\utility::dof_enable_autofocus(2.8, 1, undefined, undefined, "tag_eye");
  wait 28;
  level scripts\engine\sp\utility::dof_enable(2.8, 600, 1, 0);
  wait 15.7;
  level scripts\engine\sp\utility::dof_enable(5.6, 10, 0.05);
  wait 3.3;
  level scripts\engine\sp\utility::dof_enable(4, 20, 5, 0);
  wait 4;
  level.farah scripts\engine\sp\utility::dof_enable_autofocus(4, 3, undefined, undefined, "tag_eye");
  wait 5;
  scripts\engine\sp\utility::dof_disable();
}

barkov_kickoff_anim(var_0) {
  scripts\engine\sp\utility::anim_stopanimScripted();
  self dontinterpolate();
  var_0 scripts\common\anim::anim_single_solo(self, "finale_kickoff_sh01");
  self.diequietly = 1;
  self.skipdeathanim = 1;

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  self.allowdeath = 1;
  self startragdoll();
  self kill();
}

lab_ending_bink() {
  level.hud_finale_black = scripts\sp\hud_util::create_client_overlay("black", 1, undefined);
  level.hud_finale_black.foreground = 0;
  play_ending_bink();
  setomnvar("ui_hide_hud", 1);
  scripts\sp\credits::playcredits();
  scripts\engine\sp\utility::nextmission();
}

play_ending_bink() {
  level.player setplayerprogression("currentMission", "none");
  setmusicstate("");
  scripts\engine\utility::delaythread(0.1, scripts\sp\credits::createmwlogo);
  setsaveddvar("MMRNLMPPLT", "1");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame("sp_epilogue");
  scripts\engine\utility::flag_init("skipped_ending_bink");
  thread skip_ending_bink_thread();

  while(!iscinematicplaying())
    waitframe();

  level.player setclientomnvar("ui_hide_full_hud", 1);
  thread ending_zplanes();
  var_0 = 108475;

  while(!scripts\engine\utility::flag("skipped_ending_bink") && cinematicgettimeinmsec() < var_0)
    waitframe();

  scripts\sp\utility::userskip_stop();

  if(scripts\engine\utility::flag("skipped_ending_bink")) {
    if(iscinematicplaying())
      stopcinematicingame();

    thread ending_bink_skipped_audio_transition();
  } else
    thread ending_bink_audio_transition();

  while(iscinematicplaying())
    waitframe();
}

ending_zplanes() {
  wait 0.5;
  setsaveddvar("OMNONNMOTP", "1 5 5 10");
}

skip_ending_bink_thread() {
  var_0 = scripts\sp\utility::userskip_wait();

  if(var_0)
    scripts\engine\utility::flag_set("skipped_ending_bink");
}

ending_bink_audio_transition() {
  setmusicstate("mx_credits_noskip");
}

ending_bink_skipped_audio_transition() {
  setmusicstate("mx_credits_skip");
}

finale_heli_setup() {
  var_0 = scripts\engine\utility::getStruct("finale_path_end", "targetname");
  level.finale_heli_intro = scripts\common\vehicle::spawn_vehicle_from_targetname("finale_heli_intro");
  level.finale_heli_intro scripts\engine\sp\utility::assign_animtree("finale_heli");
  level.finale_heli_intro vehicle_turnengineoff();
  level.finale_heli = scripts\common\vehicle::spawn_vehicle_from_targetname("finale_heli");
  level.finale_heli vehicle_turnengineoff();
  level.finale_heli hideallparts();
  level.finale_heli scripts\engine\sp\utility::assign_animtree("finale_heli");
  level.finale_heli thread scripts\sp\maps\lab\lab_lighting.gsc::finale_heli_lights();
  var_1 = level.finale_heli;
  var_1.dontdisconnectpaths = 1;
  var_1 notsolid();
  var_1.pilot = spawn_pilot_nikolai(var_1);
  var_1.linked_ents = [];
  var_1.pilot hide();
  var_1.ground_ent = getEnt("finale_heligroundref", "targetname");
  var_1.linked_ents[var_1.linked_ents.size] = var_1.ground_ent;
  var_1.safe_trigger = getEnt("finale_heli_safe", "targetname");
  var_1.linked_ents[var_1.linked_ents.size] = var_1.safe_trigger;
  var_1.safe_trigger enablelinkTo();
  var_1.start_trigger = getEnt("finale_heli_start_lookback", "targetname");
  var_1.linked_ents[var_1.linked_ents.size] = var_1.start_trigger;
  var_1.start_trigger enablelinkTo();
  var_1.clips = getEnt("finale_heliClip", "targetname");
  var_1.linked_ents[var_1.linked_ents.size] = var_1.clips;
  var_1.tarps = getEntArray("finale_heliTarp", "targetname");

  foreach(var_3 in var_1.tarps)
  var_1.linked_ents[var_1.linked_ents.size] = var_3;

  var_1.oob = getEnt("finale_heli_outOfBounds", "targetname");
  var_1.oob enablelinkTo();
  var_1.oob linkTo(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1.clip_stand = getEnt("finale_barkovClip_stand", "targetname");
  var_1.clip_stand linkTo(var_1);
  var_1.clip_crawl = getEnt("finale_barkovClip_crawl", "targetname");
  var_1.clip_crawl linkTo(var_1);
  var_1.lookorgs = getEntArray("barkov_look_structs", "targetname");

  foreach(var_6 in var_1.lookorgs)
  var_6 linkTo(var_1);

  var_1.bloodsplat[0] = getEnt("blood_splat1", "targetname");
  var_1.bloodsplat[1] = getEnt("blood_splat2", "targetname");

  foreach(var_6 in var_1.bloodsplat)
  var_1.linked_ents[var_1.linked_ents.size] = var_6;

  var_1.bloodsplat[0] hide();
  var_1.bloodsplat[1] hide();
  var_1.nets = getEntArray("heli_nets", "targetname");

  foreach(var_11 in var_1.nets)
  var_1.linked_ents[var_1.linked_ents.size] = var_11;

  foreach(var_6 in var_1.linked_ents)
  var_6 linkTo(var_1);

  spawn_heli_farah();
  spawn_barkov();
}

spawn_barkov() {
  var_0 = getspawner("finale_barkov", "targetname");
  level.barkov = var_0 scripts\engine\sp\utility::spawn_ai(1, 0);
  level.barkov actoraimassistoff();
  level.barkov.animname = "barkov";
  level.barkov hide();
  level.prompt_knife = spawn("script_model", level.barkov gettagorigin("tag_accessory_right"));
  level.prompt_knife setModel("weapon_wm_me_tactical_knife_v2");
  level.prompt_knife.angles = level.barkov gettagangles("tag_accessory_right");
  level.prompt_knife linkTo(level.barkov, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  level.prompt_knife hide();
  level.barkov scripts\engine\sp\utility::battlechatter_off();
  level.barkov.noloot = 1;
  level.barkov.ignoreall = 1;
  level.barkov.ignoreme = 1;
  level.barkov.disable_gun_recall = 1;
  level.barkov scripts\engine\utility::disable_pain();
  level.barkov scripts\common\ai::magic_bullet_shield();
  var_1 = level.barkov.meleechargedistvsplayer - 150;
  level.barkov.meleechargedistvsplayer = var_1;
  level.barkov.context_melee_victim_lives = 1;
  level.barkov.health = 3000;
  level.barkov.diequietly = 1;
  level.barkov.skipdeathanim = 1;
  level.barkov.disabledeathorient = 1;
  level.barkov.shotduringanim = 0;
  level.barkov.firststabs = 0;
}

barkov_damage(var_0) {
  scripts\sp\player::player_movement_state("cqb");
  level scripts\sp\utility::context_melee_enable(0);
  self.dirfacing = "back";
  self.animeshotdir = "finale_shot_injure";
  self.kickoffstart = "finale_kickoff_start";
  self.iscompletelydead = 0;
  self.barkovreloading = 0;
  self.jchestorg = scripts\engine\utility::spawn_script_origin();
  self.jchestorg linkTo(self, "j_chest", (0, 0, 0), (0, 0, 0));
  level.finale_heli vehicle_turnengineoff();
  level.finale_heli.started_second_position = 0;
  level notify("start_barkov_scene");
  thread barkov_swap_to_blendshape();
  thread barkov_lookback_scene_start(var_0);
  thread barkov_check_for_melee_range(var_0);
  thread barkov_damage_notifies(var_0);
  thread barkov_idle_vo();
  var_1 = scripts\engine\utility::waittill_any_return("barkov_is_missed", "barkov_is_stabbed", "barkov_is_shot");
  barkov_struggle_setup(var_0);
  level.og_zplanes = getDvar("OMNONNMOTP");
  thread mus_barkov_stab();

  switch (var_1) {
    case "barkov_is_missed":
      barkov_shooting_path(var_0);
      break;
    case "barkov_is_stabbed":
      if(level.player getstance() == "prone") {
        level.finale_heli thread heli_stop_for_context(5);
        barkov_melee_path(var_0, "_back", 1);
      } else {
        level.finale_heli thread heli_stop_for_context(2);
        barkov_melee_path(var_0, "_back", 0);
      }

      break;
    case "barkov_is_shot":
      if(isDefined(self.damagearray["location"]) && self.damagearray["location"] == "head") {
        if(self.dirfacing == "back" || self.dirfacing == "side")
          barkov_gun_path(var_0, "headshot", "finale_shot_death");
        else
          barkov_gun_path(var_0, "headshot", "finale_shot_death_side");
      } else if(isDefined(self.damagearray["location"]) && self.damagearray["location"] == "chest") {
        if(self.dirfacing == "back" || self.dirfacing == "side")
          barkov_gun_path(var_0, "chestshot", self.animeshotdir);
        else
          barkov_gun_path(var_0, "chestshot", "finale_shot_injure_front");
      } else if(self.dirfacing == "back" || self.dirfacing == "side")
        barkov_gun_path(var_0, "chestshot", self.animeshotdir);
      else
        barkov_gun_path(var_0, "chestshot", "finale_shot_injure_front");

      break;
    default:
      break;
  }
}

barkov_idle_vo() {
  level endon("player_spotted_finale");
  level endon("stop_radio_scene");
  wait 1;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_20");
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue_on_tag("dx_vom_ru4_finale_heli_intro_30", "j_wrist_le");
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_30");
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue_on_tag("dx_vom_ru1_finale_heli_intro_20", "j_wrist_le");
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_40");
  wait 1;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_50");
  wait 1.2;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_60");
  wait 1;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_140");
  wait 1;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_70");
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue_on_tag("dx_vom_ru4_finale_heli_intro_30", "j_wrist_le");
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_80");
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue_on_tag("dx_vom_ru3_finale_heli_intro_10", "j_wrist_le");
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_90");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_160");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_200");
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue_on_tag("dx_vom_ru1_finale_heli_intro_20", "j_wrist_le");
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_100");
  wait 2;
  scripts\engine\utility::flag_set("start_lookback");
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_110");
  wait 4;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_120");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_130");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_intro_180");
  wait 1;

  while(self.dirfacing != "side")
    waitframe();

  self notify("damage", 0, level.player, undefined, undefined, "MOD_MISS");
}

player_is_outofbounds() {
  level endon("barkov_dead");

  for(;;) {
    if(level.finale_heli.oob_enabled && !level.player istouching(level.finale_heli.oob)) {
      break;
    }

    wait 0.4;
  }

  level notify("stop_screen_shake");
  level.player kill();
}

barkov_swap_to_blendshape() {
  self.og_headmodel = self.headmodel;
  self detach(self.headmodel);
  self attach("head_villain_barkov_old_blendshape_lab");
  self.headmodel = "head_villain_barkov_old_blendshape_lab";
}

barkov_check_for_melee_range(var_0) {
  level.player endon("death");
  level endon("barkov_dead");
  thread custom_context_range(0.5);
  thread melee_off();
  level.barkovmaxmeleedistsq = squared(90);
  var_1 = squared(60);
  var_2 = level.barkovmaxmeleedistsq;

  for(;;) {
    var_3 = level.player scripts\engine\utility::waittill_any_return("melee_pressed", "attack_pressed", "ads_pressed");
    var_4 = distancesquared(level.player.origin, level.barkov.origin);

    switch (var_3) {
      case "melee_pressed":
        var_5 = level.player getcurrentweapon();
        var_6 = getweaponbasename(var_5);

        if(var_6 == "iw8_gunless_teen_farah") {} else {
          if(level.player getstance() == "prone")
            var_2 = var_1;
          else
            var_2 = level.barkovmaxmeleedistsq;

          if(!level.player ismeleeing() && var_4 < var_2) {
            if(barkov_in_player_sight())
              self notify("barkov_is_stabbed");
          }
        }

        break;
      case "attack_pressed":
        var_5 = level.player getcurrentweapon();
        var_6 = getweaponbasename(var_5);

        if(var_6 == "iw8_pi_golf21_tfarah") {
          if(level.player getcurrentweaponclipammo() > 0)
            self notify("barkov_is_missed");
        } else if(var_6 == "iw8_gunless_teen_farah") {} else {
          if(level.player getstance() == "prone")
            var_2 = var_1;
          else
            var_2 = level.barkovmaxmeleedistsq;

          if(!level.player ismeleeing() && var_4 < var_2) {
            if(barkov_in_player_sight())
              self notify("barkov_is_stabbed");
          }
        }

        break;
      case "ads_pressed":
        var_5 = level.player getcurrentweapon();
        var_6 = getweaponbasename(var_5);

        if(var_6 == "iw8_farahknife_sp" && !level.player ismeleeing() && var_4 < level.barkovmaxmeleedistsq) {
          if(barkov_in_player_sight())
            self notify("barkov_is_stabbed");
        }

        break;
      case "default":
        break;
    }

    waitframe();
  }
}

custom_context_range(var_0) {
  level endon("player_spotted_finale");
  var_1 = squared(60);
  var_2 = gettime();
  var_3 = var_0 * 1000;
  var_4 = var_2 + var_3;

  while(isalive(self)) {
    if(turn_off_prompt(var_1)) {
      level.meleehintshow = 0;

      if(gettime() >= var_4)
        level.player scripts\engine\sp\utility::display_hint("melee_stealth");

      while(turn_off_prompt(var_1))
        waitframe();
    } else {
      level.meleehintshow = 1;

      while(!turn_off_prompt(var_1))
        waitframe();
    }

    waitframe();
  }
}

melee_off() {
  level endon("barkov_dead");
  var_0 = squared(100);

  while(isalive(self)) {
    if(melee_distance_check(var_0)) {
      level.player allowmelee(0);

      while(melee_distance_check(var_0))
        waitframe();
    } else {
      level.player allowmelee(1);

      while(!melee_distance_check(var_0))
        waitframe();
    }

    waitframe();
  }
}

turn_off_prompt(var_0) {
  var_1 = 1;

  if(!melee_distance_check(var_0))
    var_1 = 0;

  if(!barkov_in_player_sight())
    var_1 = 0;

  return var_1;
}

melee_distance_check(var_0) {
  if(distance2dsquared(level.player.origin, level.barkov.jchestorg.origin) < var_0)
    return 1;

  return 0;
}

barkov_in_player_sight() {
  level.player endon("death");

  if(scripts\sp\maps\lab\lab_util.gsc::in_player_fov(level.cos60, level.barkov gettagorigin("j_chest"), [level.player, level.barkov]))
    return 1;

  if(scripts\sp\maps\lab\lab_util.gsc::in_player_fov(level.cos60, level.barkov gettagorigin("j_head"), [level.player, level.barkov]))
    return 1;

  return 0;
}

barkov_damage_notifies(var_0) {
  for(;;) {
    self waittill("damage", var_1, var_1, var_1, var_1, var_2, var_1, var_1, var_3, var_1, var_4);
    self.damagearray["type"] = var_2;
    self.damagearray["part"] = var_3;
    self.damagearray["location"] = "other";

    switch (var_2) {
      case "MOD_MISS":
        self notify("barkov_is_missed");
        break;
      case "MOD_MELEE":
        if(isDefined(var_4) && getweaponbasename(var_4) == "iw8_gunless_teen_farah") {
          break;
        }

        self notify("barkov_melee_damage");
        break;
      case "MOD_RIFLE_BULLET":
        if(scripts\sp\damagefeedback::isheadshot(var_3) || var_3 == "j_helmet")
          self.damagearray["location"] = "head";
        else if(var_3 == "j_chest")
          self.damagearray["location"] = "chest";

        self notify("barkov_is_shot");
        break;
    }
  }
}

barkov_lookback_scene_start(var_0) {
  level endon("player_spotted_finale");
  level.stealth_check["is_animated"] = 0;
  level.stealth_check["is_shooting"] = 0;
  level.sound_orgs[0] = spawn("script_origin", self.origin);
  level.sound_orgs[1] = spawn("script_origin", self.origin);
  level.sound_orgs[2] = spawn("script_origin", self.origin);

  foreach(var_2 in level.sound_orgs) {
    var_2 linkTo(self);
    var_2 scalevolume(0, 0.0);
  }

  wait 1;
  scripts\engine\utility::ent_flag_init("end_barkov_lookBack");

  for(;;) {
    if(level.player istouching(level.finale_heli.start_trigger)) {
      break;
    } else if(scripts\engine\utility::flag("start_lookback")) {
      break;
    }

    waitframe();
  }

  scripts\engine\sp\utility::anim_stopanimScripted();

  for(;;) {
    scripts\engine\sp\utility::delaychildthread(0.1, ::lookback_scene_safe);
    var_0 notify("stop_finale_intro_idle");
    level.stealth_check["is_animated"] = 1;
    var_0 scripts\common\anim::anim_single_solo(self, "finale_look_left");
    self.dirfacing = "side";
    change_animshot_dir("finale_shot_injure_side");
    var_0 thread scripts\common\anim::anim_loop_solo(self, "finale_look_idle", "stop_finale_intro_idle");
    scripts\engine\utility::ent_flag_wait("end_barkov_lookBack");
    scripts\engine\utility::ent_flag_clear("end_barkov_lookBack");
    var_0 notify("stop_finale_intro_idle");
    level.stealth_check["is_animated"] = 0;
    var_0 scripts\common\anim::anim_single_solo(self, "finale_look_right");
    self.dirfacing = "back";
    change_animshot_dir("finale_shot_injure");
    var_0 thread scripts\common\anim::anim_loop_solo(self, "finale_intro_idle", "stop_finale_intro_idle");
    wait 3;
  }
}

change_animshot_dir(var_0) {
  self.animeshotdir = var_0;
}

lookback_scene_safe() {
  var_0 = gettime();
  var_1 = var_0 + 3000;

  for(;;) {
    if(gettime() <= var_1) {
      if(!level.player istouching(level.finale_heli.safe_trigger) || level.player getstance() != "prone") {
        scripts\engine\sp\utility::delaychildthread(0.1, ::lookback_timeout_based_on_stance);
        scripts\engine\sp\utility::delaychildthread(0.1, ::lookback_start_audio_timeout);
        var_2 = level scripts\engine\utility::waittill_any_return("player_is_hiding", "player_timeout");
        level notify("stop_audio_timeout");

        foreach(var_4 in level.sound_orgs)
        var_4 stoploopsound();

        switch (var_2) {
          case "player_is_hiding":
            break;
          case "player_timeout":
            self notify("damage", 0, level.player, undefined, undefined, "MOD_MISS");
            break;
        }
      }
    } else {
      scripts\engine\utility::ent_flag_set("end_barkov_lookBack");
      break;
    }

    waitframe();
  }
}

lookback_timeout_based_on_stance() {
  level endon("stop_audio_timeout");
  level endon("player_spotted_finale");
  var_0 = 0;
  level.sound_orgs[0] playLoopSound("ui_stealth_threat_low_lp");
  level.sound_orgs[1] playLoopSound("ui_stealth_threat_med_lp");
  level.sound_orgs[2] playLoopSound("ui_stealth_threat_high_lp");

  foreach(var_2 in level.sound_orgs)
  var_2 scalevolume(0, 0);

  foreach(var_2 in level.sound_orgs)
  var_2 scalevolume(1, 2.4);

  while(var_0 <= 2.4) {
    wait 0.1;

    if(var_0 >= 1.6)
      level.player playRumbleOnEntity("damage_heavy");
    else if(var_0 >= 0.8)
      level.player playRumbleOnEntity("damage_light");
    else
      level.player playRumbleOnEntity("light_1s");

    if(level.player getstance() == "prone") {
      var_0 = var_0 + 0.1;
      continue;
    }

    if(level.player getstance() == "crouch") {
      var_0 = var_0 + 0.15;
      continue;
    }

    var_0 = 3.4;
  }

  level notify("player_timeout");
}

lookback_start_audio_timeout() {
  level endon("stop_audio_timeout");
  level endon("player_spotted_finale");

  while(!level.player istouching(level.finale_heli.safe_trigger) || level.player getstance() != "prone")
    waitframe();

  level notify("player_is_hiding");
}

heli_stop_for_context(var_0) {
  self vehicle_setspeedimmediate(0);
  level waittill("resume_heli_path");
  self vehicle_setspeed(13, 4);
}

heli_stop(var_0) {
  self.oob_enabled = 0;
  scripts\common\utility::vehicle_detachfrompath();
  self vehicle_cleardrivingstate();
  self.idle_animnode2 = scripts\engine\utility::getStruct("finale_heli_idle2", "targetname");
  self.idle_animnode2.angles = self gettagangles("tag_origin");
  self.idle_animnode2 thread scripts\common\anim::anim_loop_solo(self, var_0, "stop_heli_loop");
  self rotateTo((0, 0, 0), 1);
  self.started_second_position = 1;
  self.oob_enabled = 1;
}

barkov_struggle_setup(var_0) {
  level notify("stop_radio_scene");
  level.meleehintshow = 1;
  level notify("death_scene");
  thread delete_orgs();
}

delete_orgs() {
  level scripts\engine\utility::waittill_any_timeout(1, "player_spotted_finale");

  foreach(var_1 in level.sound_orgs) {
    if(isDefined(var_1)) {
      var_1 stoploopsound();
      var_1 delete();
    }
  }
}

barkov_shooting_path(var_0) {
  self endon("barkov_charge_shot");
  var_0 notify("stop_finale_intro_idle");
  level notify("player_spotted_finale");
  self.animname = "barkov";
  thread barkov_charged_player_vo();
  thread barkov_within_melee_range(var_0);
  thread barkov_firing_loop(var_0);
  var_1 = scripts\engine\utility::waittill_any_return("barkov_is_stabbed", "barkov_is_shot", "barkov_melee_damage");
  barkov_struggle_setup(var_0);
  self notify("barkov_stop_shooting");
  self notify("stop_anim_aim");
  scripts\engine\sp\utility::anim_stopanimScripted();

  switch (var_1) {
    case "barkov_melee_damage":
    case "barkov_is_stabbed":
      if(level.stealth_check["is_shooting"]) {
        self setlookattext("", &"");

        if(isalive(level.player)) {
          level.player enableinvulnerability();
          level.player thread stab_fail_extras();
          level notify("disable_light_6");
          level notify("move_window_light_fail");
          var_0 scripts\sp\player_rig::link_player_to_rig("finale_stab_fail", "stand", 0, undefined, 1);
          level.player setstance("stand", 1);
          level.player_rig linkTo(var_0);
          var_0 thread scripts\common\anim::anim_single_solo(level.player_rig, "finale_stab_fail");
          var_0 scripts\common\anim::anim_single_solo(self, "finale_stab_fail");
          var_0 scripts\common\anim::anim_last_frame_solo(self, "finale_stab_fail");
        }

        level waittill("forever");
      } else if(level.player getstance() == "prone") {
        level.finale_heli thread heli_stop_for_context(5);
        barkov_melee_path(var_0, "_front", 1);
      } else {
        level.finale_heli thread heli_stop_for_context(2);
        barkov_melee_path(var_0, "_front", 0);
      }

      break;
    case "barkov_is_shot":
      if(isDefined(self.damagearray["location"]) && self.damagearray["location"] == "head") {
        self.kickoffstart = "finale_kickoff_start_alt";
        barkov_gun_path(var_0, "headshot", "finale_gun_aim_death");
      } else if(isDefined(self.damagearray["location"]) && self.damagearray["location"] == "chest")
        barkov_gun_path(var_0, "chestshot", "finale_shot_injure_front");
      else
        barkov_gun_path(var_0, "other", "finale_shot_injure_front");

      break;
    default:
      break;
  }
}

stab_fail_extras() {
  level.player lerpfovscalefactor(0, 0.25);
  level.player scripts\engine\utility::delaycall(0.6, ::hideviewmodel);
  level.finale_heli scripts\common\utility::vehicle_detachfrompath();
  level.finale_heli vehicle_cleardrivingstate();
}

barkov_within_melee_range(var_0) {
  self endon("barkov_stop_shooting");
  level.player endon("death");
  var_1 = squared(60);
  var_2 = 0;
  var_3 = undefined;

  for(;;) {
    var_4 = distancesquared(level.player.origin, level.barkov.origin);

    if(!var_2 && var_4 < var_1) {
      var_2 = 1;
      var_3 = gettime();
    } else if(var_2 && var_4 >= var_1) {
      var_2 = 0;
      var_3 = undefined;
    }

    if(var_2 && isDefined(var_3)) {
      if(level.stealth_check["is_shooting"] && level.player getstance() == "prone")
        level.player scripts\sp\utility::do_damage(level.player.health + 1000, self.origin, self, self, "MOD_PISTOL_BULLET");
      else if(isDefined(var_3)) {
        if(level.stealth_check["is_shooting"] && gettime() >= var_3 + 1000) {
          level.player shellshock("captive_hit", 1);

          if(level.player.health > 12) {
            var_5 = min(level.player.health - 2, 20);
            level.player scripts\sp\utility::do_damage(var_5, self.origin, self, self, "MOD_MELEE");
          }

          level.player playRumbleOnEntity("heavy_1s");
          self notify("barkov_is_stabbed");
        }
      }
    }

    waitframe();
  }
}

barkov_firing_loop(var_0) {
  self endon("barkov_stop_shooting");
  scripts\engine\utility::delaythread(0.2, ::barkov_is_armed);
  var_0 scripts\common\anim::anim_single_solo(self, "finale_look_spotted");
  level.barkov.ignoreall = 0;
  level.barkov.ignoreme = 0;
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  self getenemyinfo(level.player);
  var_1["left"] = 35;
  var_1["right"] = -35;
  var_1["up"] = -10;
  var_1["down"] = 45;
  childthread anim_aim_and_reload("finale_gun_aim", var_0, var_1);
}

barkov_is_armed() {
  level.stealth_check["is_shooting"] = 1;
}

barkov_charged_player_vo() {
  self endon("barkov_stop_shooting");
  level.player endon("death");
  wait 0.15;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_alertfail_10");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_30");
  wait 2.5;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_10");
  wait 1;

  while(!self.barkovreloading)
    wait 0.1;

  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_80");
  wait 0.7;
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_hidenseek_90");
  wait 0.7;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_100");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_420");
  wait 2.5;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_50");
  wait 0.7;
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_hidenseek_60");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_370");
  wait 1;

  while(!self.barkovreloading)
    wait 0.1;

  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_130");
  wait 0.7;
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_hidenseek_140");
  wait 0.8;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_150");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_230");
  wait 2.3;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_250");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_260");
  wait 2.5;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_270");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_290");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_300");
  wait 2.5;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_330");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_340");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_440");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_350");
  wait 2.5;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_390");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_240");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_400");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_460");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_470");
  wait 0.8;
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_hidenseek_180");
  wait 1;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_190");
  wait 0.7;
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_hidenseek_200");
  wait 1;
  scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_210");
}

barkov_gun_path(var_0, var_1, var_2) {
  if(isDefined(level.finale_heli.clip_stand))
    level.finale_heli.clip_stand delete();

  level.barkov notify("stop_simple_dialogue");
  level.barkov stopsounds();
  level notify("player_spotted_finale");
  var_0 notify("stop_finale_intro_idle");

  if(isDefined(level.finale_heli.reflectionvolume2))
    level.finale_heli.reflectionvolume2 hide();

  if(var_1 == "headshot") {
    level.barkov setlookattext("", &"");
    level.barkov.kickoffstart = "finale_kickoff_start_alt";
    var_0 scripts\common\anim::anim_single_solo(self, var_2);
    var_0 thread scripts\common\anim::anim_loop_solo(self, "finale_death_stabbed_idle", "finale_idle");

    if(isDefined(level.barkov.propmodel))
      level.barkov.propmodel delete();

    facial_death();
    self.iscompletelydead = 1;
    level.kickout = 0;
    scripts\engine\utility::flag_set("start_choking_scene");
    scripts\engine\utility::flag_set("ready_for_kickoff");
    wait 0.65;
  } else {
    thread barkov_shot_dialog(var_1);
    level.barkov setlookattext("", &"");
    thread barkov_damaged_during_anim();
    var_0 scripts\common\anim::anim_single_solo(self, var_2);

    if(!self.shotduringanim)
      thread barkov_crawl_anim_shot(var_0);

    barkov_stab_post_melee(var_0, 0);
  }
}

barkov_damaged_during_anim() {
  level endon("start_choking_scene");
  var_0 = scripts\engine\utility::waittill_any_return("barkov_is_shot");
  self.shotduringanim = 1;
}

mus_barkov_stab() {
  setmusicstate("mx_lab_farah_stab");
}

barkov_melee_path(var_0, var_1, var_2) {
  if(var_1 == "_front")
    level.barkov scripts\engine\utility::delaythread(0.6, scripts\sp\maps\lab\lab_vo_util.gsc::simple_dialogue, "dx_vom_bkv_finale_heli_kill_knife_10");

  self setlookattext("", &"");
  thread barkov_melee_setup();
  setsaveddvar("OMNONNMOTP", "0.1 400 2 1000");
  level.player lerpfovscalefactor(0, 0.25);

  if(!isalive(level.player)) {
    return;
  }
  level.player enableinvulnerability();
  level notify("player_spotted_finale");

  if(isDefined(var_2) && var_2) {
    var_0 scripts\sp\player_rig::link_player_to_rig("finale_stab_prone", "prone", 1, 0.2, 0, 0, 0, 0, 0);
    level.barkov linkTo(var_0);
    level.player_rig linkTo(var_0);
    level.player hideviewmodel();
    var_0 scripts\common\anim::anim_single_solo(level.player_rig, "finale_stab_prone");
    level.player setstance("stand", 1, 1, 1);
    level.player_rig hide();
    scripts\sp\player_rig::unlink_player_from_rig(0, undefined, undefined, 1);
    level.player_rig dontinterpolate();
    var_0 scripts\common\anim::anim_first_frame_solo(level.player_rig, "finale_stab" + var_1);
    level.player dontinterpolate();
    var_0 scripts\sp\player_rig::link_player_to_rig("finale_stab" + var_1, "stand", 0, undefined, 0, 0, 0, 0, 0);
  } else {
    var_0 scripts\sp\player_rig::link_player_to_rig("finale_stab" + var_1, "stand", 1, 0.2, 0, 0, 0, 0, 0);
    level.barkov linkTo(var_0);
    level.player_rig linkTo(var_0);
    level.player hideviewmodel();
  }

  var_0 notify("stop_finale_intro_idle");
  thread barkov_choke_takedown_anims(var_0, var_1);
  wait 3;
  var_3 = getanimlength(scripts\engine\utility::getanim("finale_stab" + var_1));
  var_4 = getanimlength(scripts\engine\utility::getanim("finale_knock_down"));
  var_5 = var_3 + var_4;
  barkov_choke_scene(var_0, var_5);
}

barkov_choke_takedown_anims(var_0, var_1) {
  self endon("choke_takedown_interrupted");
  var_0 scripts\common\anim::anim_single([self, level.player_rig], "finale_stab" + var_1);
  var_0 scripts\common\anim::anim_single([self, level.player_rig], "finale_knock_down");
  var_0 thread scripts\common\anim::anim_loop_solo(level.player_rig, "finale_choke01_idle", "stop_choke");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "finale_choke01_idle", "stop_choke");
  level.player setworldupreferenceangles((0, 110, 60));
}

barkov_choke_scene(var_0, var_1) {
  var_0 notify("stop_anim");
  level.player_rig show();
  scripts\engine\utility::delaythread(4, ::show_cursor_on_prompt_knife);
  var_2 = level.prompt_knife scripts\engine\utility::waittill_notify_or_timeout_return("trigger", var_1 + 5);

  if(isDefined(level.finale_heli.reflectionvolume2))
    level.finale_heli.reflectionvolume2 hide();

  switch (var_2) {
    case "timeout":
      var_0 notify("stop_choke");
      level.prompt_knife scripts\sp\player\cursor_hint::remove_cursor_hint();
      scripts\engine\utility::delaythread(3, scripts\sp\utility::missionfailedwrapper);
      var_0 thread scripts\common\anim::anim_single_solo(level.player_rig, "choke_deathA");
      var_0 scripts\common\anim::anim_single_solo(level.barkov, "choke_deathA");
      var_0 scripts\common\anim::anim_last_frame_solo(level.barkov, "choke_deathA");
      level waittill("never");
      break;
    default:
      self notify("choke_takedown_interrupted");
      var_0 notify("stop_choke");
      var_0 thread scripts\common\anim::anim_single_solo(level.player_rig, "finale_grab_knife");
      var_0 scripts\common\anim::anim_single_solo(level.barkov, "finale_grab_knife");
      var_0 thread scripts\common\anim::anim_loop_solo(level.barkov, "finale_grab_knife_idle", "stop_grab");
      var_0 thread scripts\common\anim::anim_loop_solo(level.player_rig, "finale_grab_knife_idle", "stop_grab");
      level.player showviewmodel();
      thread finale_kick_scene_setup_rig(var_0);
      barkov_stab_post_melee(var_0, 1);
      break;
  }
}

show_cursor_on_prompt_knife() {
  level.prompt_knife scripts\sp\player\cursor_hint::create_cursor_hint("j_gun", (0, 0, 1), &"LAB/CURSOR_GRAB", 50, 60, 65, 1, undefined, undefined, undefined, "duration_none");
}

barkov_melee_setup() {
  level.player allowmelee(0);
  level.player hidelegs();

  if(isDefined(level.finale_heli.clip_stand))
    level.finale_heli.clip_stand delete();
}

barkov_stab_post_melee(var_0, var_1) {
  var_2 = undefined;
  scripts\engine\utility::flag_set("start_choking_scene");

  if(var_1) {
    wait 0.2;
    childthread timeout_notify_melee_thread(5);
    var_2 = level.player scripts\engine\utility::waittill_any_return("melee_pressed", "attack_pressed", "ads_pressed", "reload_pressed", "melee_timed_out", "crawl_timed_out");
    level thread scripts\engine\sp\utility::notify_delay("resume_heli_path", 0.3);
  } else if(self.shotduringanim)
    var_2 = "shot_during_anim";
  else
    var_2 = "crawl_timed_out";

  level.player setworldupreferenceangles((0, 0, 0));
  level.player notify("end_timeout_thread");

  switch (var_2) {
    case "melee_timed_out":
      var_0 notify("stop_grab");
      var_0 notify("finale_idle");
      scripts\engine\utility::delaythread(3, scripts\sp\utility::missionfailedwrapper);
      var_0 thread scripts\common\anim::anim_single_solo(level.player_rig, "choke_deathB");
      var_0 scripts\common\anim::anim_single_solo(level.barkov, "choke_deathB");
      var_0 scripts\common\anim::anim_last_frame_solo(level.barkov, "choke_deathB");
      level waittill("never");
      break;
    case "ads_pressed":
    case "melee_pressed":
    case "attack_pressed":
      var_3 = level.player getcurrentweapon();
      var_4 = getweaponbasename(var_3);
      level notify("stop_choking", 1);

      if(var_4 == "iw8_pi_golf21_tfarah") {
        barkov_shot_loop(var_0);
        level.kickout = 0;
        scripts\engine\utility::flag_set("ready_for_kickoff");
      } else {
        barkov_stab_loop(var_0, var_1);
        level.kickout = 1;
        scripts\engine\utility::flag_set("ready_for_kickoff");
      }

      break;
    case "shot_during_anim":
      self.kickoffstart = "finale_kickoff_start_alt";
      barkov_shot_loop(var_0);
      level.kickout = 0;
      scripts\engine\utility::flag_set("ready_for_kickoff");
      break;
    case "crawl_timed_out":
      var_0 notify("stop_grab");
      var_0 notify("finale_idle");
      barkov_crawl_scene(var_0);
      level.kickout = 1;
      scripts\engine\utility::flag_set("ready_for_kickoff");
      break;
    default:
      barkov_stab_loop(var_0, var_1);
      level.kickout = 1;
      scripts\engine\utility::flag_set("ready_for_kickoff");
      break;
  }
}

barkov_shot_loop(var_0) {
  var_0 notify("finale_idle");
  self notify("longdeath_ender");
  level notify("end_longdeath_lines");
  level notify("end_kick_lines");
  level notify("stop_crawling_notify");
  level.knife hide();

  if(isDefined(level.finale_heli.clip_crawl))
    level.finale_heli.clip_crawl delete();

  var_0 scripts\common\anim::anim_single_solo(self, "finale_death_shot");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "finale_death_stabbed_idle", "finale_idle");
  facial_death();
  self.iscompletelydead = 1;
}

barkov_stab_loop(var_0, var_1) {
  scripts\engine\utility::flag_set("next_dialog_line");

  if(!isDefined(level.player_rig)) {
    var_0 scripts\sp\player_rig::link_player_to_rig("finale_stab02", "crouch", 0, undefined, 0, 50, 50, 50, 50, 1);
    level.player_rig linkTo(var_0);
    level.barkov linkTo(var_0);
  }

  var_0 notify("stop_grab");
  var_0 notify("finale_idle");

  if(var_1) {
    level.finale_heli.bloodsplat[0] show();
    thread barkov_crawl_anim(var_0);
    var_0 scripts\common\anim::anim_single_solo(level.player_rig, "finale_stab02");
  }

  thread scripts\engine\sp\utility::dof_disable_autofocus();
  setsaveddvar("OMNONNMOTP", level.og_zplanes);
  level.knife hide();
  barkov_crawl_scene(var_0);
}

barkov_crawl_anim(var_0) {
  level endon("stop_crawling_notify");
  var_0 scripts\common\anim::anim_single_solo(self, "finale_stab02");
  var_0 scripts\common\anim::anim_single_solo(self, "finale_stab02b");
  var_0 scripts\common\anim::anim_last_frame_solo(self, "finale_stab02b");
  self notify("barkov_crawl_finished");
}

barkov_crawl_anim_shot(var_0) {
  level endon("stop_crawling_notify");
  var_0 scripts\common\anim::anim_single_solo(self, "finale_stab02b");
  var_0 scripts\common\anim::anim_last_frame_solo(self, "finale_stab02b");
  self notify("barkov_crawl_finished");
}

barkov_crawl_scene(var_0) {
  level notify("stop_choking", 1);
  scripts\engine\utility::delaythread(0.2, scripts\engine\sp\utility::autosave_now);
  level endon("stop_crawl_scene");
  thread custom_context_range(3.5);
  level.barkovmaxmeleedistsq = squared(80);

  if(isDefined(level.player_rig))
    scripts\sp\player_rig::unlink_player_from_rig();

  level.player allowmelee(0);
  var_1 = scripts\engine\utility::spawn_script_origin(self gettagorigin("j_chest"), self gettagangles("j_chest"));
  var_1 linkTo(self, "j_chest");
  var_2 = scripts\engine\utility::waittill_any_return("barkov_is_stabbed", "barkov_is_shot", "barkov_crawl_finished");
  level notify("player_spotted_finale");
  level.meleehintshow = 1;

  if(isDefined(level.finale_heli.clip_crawl))
    level.finale_heli.clip_crawl delete();

  switch (var_2) {
    case "barkov_crawl_finished":
      if(isalive(level.player))
        scripts\sp\utility::missionfailedwrapper();

      level waittill("never");
      break;
    case "barkov_is_stabbed":
      level.player notify("end_timeout_thread");
      level notify("stop_crawl_anims");
      level notify("stop_crawling_notify");
      level.player allowmelee(0);
      setsaveddvar("OMNONNMOTP", "0.1 400 2 1000");

      if(!isDefined(level.player_rig)) {
        level.player_rig = scripts\engine\sp\utility::spawn_anim_model("player_rig");
        level.player_rig hide();
        level.player_rig dontinterpolate();
        var_0 scripts\common\anim::anim_first_frame_solo(level.player_rig, "finale_choke_stab01");
      }

      level.player giveweapon("iw8_gunless_teen_farah");
      level.player switchtoweapon("iw8_gunless_teen_farah");
      level.player takeweapon("iw8_farahknife_sp");
      level.player_rig linkTo(var_0);

      if(level.player getstance() == "prone") {
        var_0 scripts\sp\player_rig::link_player_to_rig("finale_choke_stab01", "crouch", 1, 0.2, 1);
        level.player hideviewmodel();
        level.player_rig hide();
        level.player_rig scripts\engine\utility::delaycall(0.4, ::show);
      } else
        var_0 scripts\sp\player_rig::link_player_to_rig("finale_choke_stab01", "crouch", 1, 0.2, 1);

      var_0 notify("stop_crawl");
      scripts\engine\sp\utility::anim_stopanimScripted();
      var_0 notify("stop_choke");
      level notify("stop_choking", 1);
      var_0 thread scripts\common\anim::anim_single_solo(self, "finale_choke_stab01");
      var_0 scripts\common\anim::anim_single_solo(level.player_rig, "finale_choke_stab01");
      var_0 thread scripts\common\anim::anim_loop_solo(level.player_rig, "finale_choke_stab01_idle", "stop_choke");
      var_0 thread scripts\common\anim::anim_loop_solo(self, "finale_choke_stab01_idle", "stop_choke");
      level.player showviewmodel();
      finale_stab(var_0, "finale_choke_stab02");
      finale_stab(var_0, "finale_choke_stab03");
      finale_stab(var_0, "finale_choke_stab04");
      setsaveddvar("OMNONNMOTP", level.og_zplanes);
      scripts\sp\player_rig::unlink_player_from_rig(undefined, undefined, undefined, 1);
      thread player_rig_end_scene_setup(var_0);
      scripts\engine\utility::flag_set("beg_lines");
      thread long_death_barkov(1);
      break;
    case "barkov_is_shot":
      level.player notify("end_timeout_thread");
      level notify("stop_crawl_anims");
      level notify("stop_crawling_notify");
      scripts\engine\sp\utility::anim_stopanimScripted();
      var_0 notify("stop_crawl");
      var_0 notify("stop_choke");
      level notify("stop_choking", 1);
      scripts\engine\utility::flag_set("beg_lines");
      self.kickoffstart = "finale_kickoff_start_alt";
      var_0 scripts\common\anim::anim_single_solo(self, "finale_death_shot");
      thread long_death_barkov(0);
      break;
    default:
      scripts\sp\utility::missionfailedwrapper();
      level waittill("never");
      break;
  }
}

player_rig_end_scene_setup(var_0) {
  level.player_rig hide();
  level.player_rig linkTo(var_0);
  var_0 scripts\common\anim::anim_first_frame_solo(level.alt_rig, "finale_kickoff_sh02");
}

dialogue_wheel_start() {
  level endon("barkov_dead");
  setomnvar("ui_dialogue_prompts_choice", 0);
  setomnvar("ui_dialogue_prompts_option_a", "lab/barkov_option_1");
  setomnvar("ui_dialogue_prompts_option_b", "lab/barkov_option_2");
  setomnvar("ui_dialogue_prompts_option_c", "lab/barkov_option_3");
  setomnvar("ui_dialogue_prompts_option_d", "lab/barkov_option_4");
  setomnvar("ui_dialogue_prompts_duration", 0);
  setomnvar("ui_dialogue_prompts_active", 1);
  level.attackpressed = undefined;
  var_0 = 1;
  var_1 = squared(100);
  var_2 = cos(25);
  self.chestorigin = scripts\engine\utility::spawn_script_origin(self gettagorigin("j_spineupper"));
  self.chestorigin linkTo(self, "j_spineupper", (0, 0, 0), (0, 0, 0));
  var_3 = getEntArray("barkov_look_structs", "targetname");
  childthread player_is_pressing_attack();

  for(;;) {
    var_4 = distancesquared(level.player.origin, self.chestorigin.origin);

    if(dialogue_wheel_check(var_4, var_1, var_2, var_3)) {
      if(!var_0) {
        dialogue_wheel_player_state(0);
        wait 0.15;
        setomnvar("ui_dialogue_prompts_active", 1);
        waitframe();
        var_0 = 1;
      }

      if(level.player buttonPressed("BUTTON_X") || level.player buttonPressed("1")) {
        setomnvar("ui_dialogue_prompts_choice", 1);
        waitframe();
        level.finaledialogue = "dx_vom_far_finale_heli_lastwords_10";
        thread mus_farah_final_speech();
        scripts\sp\analytics::analytics_event_upload("KickOff Dialogue", 1);
        break;
      } else if(level.player buttonPressed("BUTTON_A") || level.player buttonPressed("2")) {
        setomnvar("ui_dialogue_prompts_choice", 2);
        waitframe();
        level.finaledialogue = "dx_vom_far_finale_heli_lastwords_20";
        level.finaledialoguelong = 1;
        thread mus_farah_final_speech();
        scripts\sp\analytics::analytics_event_upload("KickOff Dialogue", 2);
        break;
      } else if(level.player buttonPressed("BUTTON_B") || level.player buttonPressed("3")) {
        setomnvar("ui_dialogue_prompts_choice", 3);
        waitframe();
        level.finaledialogue = "dx_vom_far_finale_heli_lastwords_40";
        thread mus_farah_final_speech();
        scripts\sp\analytics::analytics_event_upload("KickOff Dialogue", 3);
        break;
      } else if(level.player buttonPressed("BUTTON_Y") || level.player buttonPressed("4")) {
        setomnvar("ui_dialogue_prompts_choice", 4);
        waitframe();
        level.finaledialogue = "dx_vom_far_finale_heli_lastwords_30";
        level.finaledialoguelong = 1;
        thread mus_farah_final_speech();
        scripts\sp\analytics::analytics_event_upload("KickOff Dialogue", 4);
        break;
      } else if(isDefined(level.attackpressed) || level.player meleeButtonPressed()) {
        level.finaledialogue = undefined;
        thread mus_farah_final_speech();
        scripts\sp\analytics::analytics_event_upload("KickOff Dialogue", 5);
        break;
      }
    } else {
      if(var_0) {
        dialogue_wheel_player_state(1);
        setomnvar("ui_dialogue_prompts_active", 0);
        waitframe();
      }

      var_0 = 0;
    }

    waitframe();
  }
}

player_is_pressing_attack() {
  for(;;) {
    level.attackpressed = undefined;
    level.player waittill("attack_pressed");
    level.attackpressed = 1;
    wait 0.1;
  }
}

dialogue_wheel_check(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(var_0 > var_1)
    var_4 = 0;

  if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.chestorigin.origin, var_2))
    var_4 = 0;

  if(level.player getstance() == "prone")
    var_4 = 0;

  return var_4;
}

dialogue_wheel_player_state(var_0) {
  level.player allowmelee(var_0);
  level.player allowfire(var_0);
  level.player allowjump(var_0);
  level.player allowreload(var_0);
  level.player allowprone(var_0);
  level.player allowcrouch(var_0);
}

mus_farah_final_speech() {
  level.player setsoundsubmix("sp_lab_ending_duck_1", 3.0);
  setmusicstate("");
}

mus_cockpit_finale() {
  setmusicstate("mx_lab_helo_finale");
}

heli_final_path() {
  level endon("skip_end_scene");
  level waittill("finale_heli_move_to_kickoff");

  if(!scripts\engine\utility::flag("start_choking_scene"))
    scripts\engine\utility::flag_set("start_choking_scene");

  var_0 = scripts\engine\utility::getStruct("ending_path_start", "targetname");
  level.finale_heli dontinterpolate();
  level.player dontinterpolate();
  level.alt_rig dontinterpolate();
  level.barkov dontinterpolate();

  if(isDefined(level.finale_heli.started_second_position) && !level.finale_heli.started_second_position)
    level.finale_heli heli_stop("finale_idle");
  else {
    level.finale_heli.idle_animnode2 notify("stop_heli_loop");
    level.finale_heli.idle_animnode2 thread scripts\common\anim::anim_loop_solo(level.finale_heli, "finale_idle", "stop_heli_loop");
  }

  wait 0.2;
  level.finale_heli.idle_animnode2 notify("stop_heli_loop");
  var_1 = scripts\engine\utility::getStruct("ending_path_start2", "targetname");
  level.finale_heli cleartargetyaw();
  level.finale_heli vehicle_setspeed(7, 2);
  level.finale_heli setneargoalnotifydist(300);
  level.finale_heli setmaxpitchroll(5, 5);
  level.finale_heli vehicle_helisetai(var_1.origin, 7, 2, 0, undefined, var_1.angles, var_1.angles[1], 0, 0, 0, 0, 0, 0);
  level.finale_heli waittill("near_goal");

  if(!scripts\engine\utility::flag("set_fire"))
    scripts\engine\utility::flag_set("set_fire");

  level.finale_heli vehicle_setspeed(0, 1, 2);
}

finale_shot_cleanup() {
  level.finale_heli delete();
  var_0 = [level.farah, level.finale_heli.pilot];

  foreach(var_2 in var_0) {
    var_2 linkTo(level.finale_heli_intro, "tag_origin", (0, 0, 0), (0, 0, 0));
    level.finale_heli_intro thread scripts\common\anim::anim_loop_solo(var_2, "final_shot");
  }
}

halt_heli_end_movement(var_0) {
  level.finale_heli vehicle_setspeed(0);
  level.finale_heli sethoverparams(0, 0, 0);
  scripts\engine\utility::array_call(level.finale_heli.nets, ::hide);
  wait(var_0);
  wait 0.7;
  level.finale_heli vehicle_setspeed(10);
  level.finale_heli sethoverparams(100, 10, 10);
}

ending_cleanup() {
  if(isDefined(level.knife))
    level.knife delete();

  if(isDefined(level.prompt_knife))
    level.prompt_knife delete();
}

barkov_shot_dialog(var_0) {
  level endon("end_longdeath_lines");
  barkov_shot_dialog_internal(var_0);
}

barkov_shot_dialog_internal(var_0) {
  level endon("crawl_stab");

  if(var_0 == "chestshot")
    level.barkov thread scripts\sp\maps\lab\lab_vo_util.gsc::say("dx_vom_bkv_finale_heli_shot_10", 1);
  else
    level.barkov thread scripts\sp\maps\lab\lab_vo_util.gsc::say("dx_vom_bkv_finale_heli_shot_20", 1);

  wait 2;
}

barkov_pain() {
  if(!isDefined(level.barcov_pain)) {
    var_0 = ["dx_vom_bkv_finale_heli_shot_10", "dx_vom_bkv_finale_heli_shot_20", "dx_vom_bkv_finale_heli_kill_knife_40"];
    level.barkov_pain = scripts\engine\sp\utility::create_deck(var_0);
  }

  level.barkov scripts\sp\maps\lab\lab_vo_util.gsc::say(level.barkov_pain scripts\engine\sp\utility::deck_draw(), 1);
}

barkov_kick_dialog() {
  level endon("end_kick_lines");
  scripts\engine\utility::flag_wait("kick_lines");
  level.barkov scripts\sp\maps\lab\lab_vo_util.gsc::say("dx_vom_bkv_finale_heli_kill_knife_90", 1);
}

long_death_barkov(var_0) {
  self endon("longdeath_ender");

  if(istrue(var_0)) {
    thread stop_final_speech();
    self waittillmatch("single anim", "end");
    self notify("barkov_speech_is_over");
  }

  level.finale_heli thread scripts\common\anim::anim_loop_solo(level.barkov, "finale_death_stabbed_idle", "finale_idle");
  facial_death();
  self.iscompletelydead = 1;
}

stop_final_speech() {
  self endon("barkov_speech_is_over");
  var_0 = scripts\engine\utility::waittill_any_return("barkov_is_stabbed", "barkov_is_shot", "barkov_melee_damage");
}

finale_stab(var_0, var_1) {
  level notify("finale_stab");
  level notify("start_choking", 6);

  if(timed_melee_check(7, 60)) {
    var_0 notify("stop_choke");
    level notify("stop_choking", 1);
    level.barkov notify("next_finale_stab");

    if(var_1 == "finale_choke_stab04") {
      facial_clear();
      thread show_finale_bloodsplat();
    }

    var_0 thread scripts\common\anim::anim_single_solo(level.barkov, var_1);
    var_0 scripts\common\anim::anim_single_solo(level.player_rig, var_1);

    if(var_1 != "finale_choke_stab04") {
      var_0 thread scripts\common\anim::anim_loop_solo(level.player_rig, var_1 + "_idle", "stop_choke");
      var_0 thread scripts\common\anim::anim_loop_solo(level.barkov, var_1 + "_idle", "stop_choke");
    }
  } else {
    scripts\sp\utility::missionfailedwrapper();
    level waittill("never");
  }
}

show_finale_bloodsplat() {
  wait 0.3;
  level.finale_heli.bloodsplat[1] show();
}

choke_screen_effects() {
  if(!isDefined(level.player.breathoverlay))
    setup_breath_overlay();

  for(;;) {
    level waittill("start_choking", var_0);

    if(!isDefined(level.player.breathoverlay))
      setup_breath_overlay();

    level.player.breathoverlay fadeovertime(var_0);
    level.player.breathoverlay.alpha = 1;
    visionsetnaked("lab_near_death", var_0 - 1);
    level waittill("stop_choking");
    level.player.breathoverlay fadeovertime(1);
    level.player.breathoverlay.alpha = 0;
    visionsetnaked("lab_ending_sss", 1);
  }
}

setup_breath_overlay() {
  level.player.breathoverlay = newclienthudelem(level.player);
  level.player.breathoverlay.sort = 12;
  level.player.breathoverlay.x = 0;
  level.player.breathoverlay.y = 0;
  level.player.breathoverlay.alignx = "left";
  level.player.breathoverlay.aligny = "top";
  level.player.breathoverlay.sort = 1;
  level.player.breathoverlay.foreground = 0;
  level.player.breathoverlay.lowresbackground = 1;
  level.player.breathoverlay.horzalign = "fullscreen";
  level.player.breathoverlay.vertalign = "fullscreen";
  level.player.breathoverlay.alpha = 0;
  level.player.breathoverlay.enablehudlighting = 1;
  level.player.breathoverlay setshader("ui_player_pain_deathsdoor_pulse_overlay", 640, 480);
}

barkov_watcher_attack() {
  level endon("barkov_dead");

  for(;;) {
    var_0 = level.player scripts\engine\utility::waittill_any_return("melee_pressed", "attack_pressed", "ads_pressed");

    if(var_0 == "attack_pressed") {
      var_1 = level.player getcurrentweapon();
      var_2 = getweaponbasename(var_1);

      if(var_2 == "iw8_pi_golf21_tfarah")
        self.weaponused = "gun";
      else
        self.weaponused = "melee";

      continue;
    }

    self.weaponused = "melee";
  }
}

timed_melee_check(var_0, var_1) {
  var_2 = 0;
  var_3 = gettime() + var_0 * 1000;
  childthread timeout_notify_melee_thread(var_0);

  while(gettime() < var_3 && isalive(level.barkov)) {
    var_4 = level.player scripts\engine\utility::waittill_any_return("melee_pressed", "attack_pressed", "ads_pressed", "melee_timed_out");

    if(var_4 == "melee_timed_out") {
      break;
    }

    var_5 = level.barkov getEye();

    if(distancesquared(level.player.origin, var_5) < var_1 * var_1) {
      if(scripts\sp\maps\lab\lab_util.gsc::in_player_fov(level.cos60, var_5, [level.player, level.barkov])) {
        level.player notify("end_timeout_thread");
        var_2 = 1;
        break;
      }
    }

    waitframe();
  }

  return var_2;
}

timeout_notify_melee_thread(var_0) {
  level.player endon("end_timeout_thread");
  level.player scripts\engine\sp\utility::notify_delay("melee_timed_out", var_0);
}

spawn_pilot_nikolai(var_0) {
  var_1 = getEnt("finale_heli_pilot", "script_noteworthy");
  var_1 scripts\sp\utility::context_melee_enable(0);
  var_1 scripts\engine\sp\utility::battlechatter_off();
  var_1 scripts\engine\utility::disable_pain();
  var_1 scripts\engine\sp\utility::name_hide();
  var_1 scripts\engine\sp\utility::disable_bulletwhizbyreaction();
  var_1 scripts\engine\sp\utility::disable_danger_react();
  var_1 scripts\engine\sp\utility::disable_surprise();
  var_1 scripts\engine\sp\utility::disable_damagefeedback();
  var_1 scripts\engine\sp\utility::name_hide();
  var_1 linkTo(var_0);
  var_1 hide();
  var_1 visiblenotsolid();
  var_1 setModel("body_hero_nikolai_lab");
  var_1 detach(var_1.headmodel);
  var_1.headmodel = "head_hero_nikolai_no_hair";
  var_1 attach(var_1.headmodel);

  if(isDefined(var_1.hatmodel))
    var_1 detach(var_1.hatmodel);

  var_1.hatmodel = "hat_hero_nikolai_headset";
  var_1 attach(var_1.hatmodel);
  return var_1;
}

spawn_heli_farah() {
  scripts\sp\maps\lab\lab_util.gsc::spawn_farah();
  level.farah hide();
  level.farah.ignoreall = 1;
  level.farah.ignoreme = 1;
  level.farah.animname = "farah";
  level.farah scripts\sp\maps\lab\lab_util.gsc::stop_magic_bullet_safe();
  level.farah scripts\common\ai::gun_remove();

  if(!isDefined(level.knife)) {
    level.knife = spawn("script_model", level.farah gettagorigin("tag_accessory_right"));
    level.knife setModel("weapon_wm_me_tactical_knife_v2");
    level.knife linkTo(level.farah, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  }
}

fadeoutscreen(var_0) {
  var_1 = scripts\sp\hud_util::create_client_overlay("black", 0);
  setomnvar("ui_hide_hud", 1);
  var_1 fadeovertime(var_0);
  var_1.alpha = 1;
  return var_1;
}

fadeinscreen(var_0) {
  self fadeovertime(var_0);
  self.alpha = 0;
  setomnvar("ui_hide_hud", 0);
  scripts\engine\utility::delaycall(var_0, ::destroy);
}

anim_aim_and_reload(var_0, var_1, var_2) {
  self.og_leftaimlimit = self.leftaimlimit;
  self.og_rightaimlimit = self.rightaimlimit;
  self.og_upaimlimit = self.upaimlimit;
  self.og_downaimlimit = self.downaimlimit;

  if(isDefined(var_2)) {
    self.leftaimlimit = var_2["left"];
    self.rightaimlimit = var_2["right"];
    self.upaimlimit = var_2["up"];
    self.downaimlimit = var_2["down"];
  } else {
    self.leftaimlimit = 50;
    self.rightaimlimit = -50;
    self.upaimlimit = -20;
    self.downaimlimit = 20;
  }

  self.aim_animprefix = var_0;
  self.aim_animnode = var_1;
  scripts\asm\asm_sp::asm_animcustom(::anim_aim_internal, ::anim_aim_end);
}

anim_aim_internal() {
  self endon("death");
  self endon("stop_anim_aim");
  var_0 = undefined;

  if(isDefined(self.aim_animnode))
    var_0 = self.aim_animnode;

  var_1 = self.aim_animprefix;
  childthread anim_aim_shoot(var_1);
  var_2 = self.enemy;

  if(isDefined(self.favoriteenemy))
    var_2 = self.favoriteenemy;

  scripts\asm\asm_bb::bb_newshootparams(undefined, var_2, 1);
  scripts\asm\asm_bb::bb_claimshootparams(0);
  scripts\aitypes\combat::setshootstyle("single", 0);
  self._blackboard.shootparams_burstcount = randomintrange(1, 5);
  self._blackboard.shootparams_shotsperburst = 1;
  self.asm.track.aim_2 = scripts\engine\utility::getanim(var_1 + "_2_knob");
  self.asm.track.aim_4 = scripts\engine\utility::getanim(var_1 + "_4_knob");
  self.asm.track.aim_6 = scripts\engine\utility::getanim(var_1 + "_6_knob");
  self.asm.track.aim_8 = scripts\engine\utility::getanim(var_1 + "_8_knob");
  self setanimknoblimited(scripts\engine\utility::getanim(var_1 + "_2"), 1, 0.2);
  self setanimknoblimited(scripts\engine\utility::getanim(var_1 + "_4"), 1, 0.2);
  self setanimknoblimited(scripts\engine\utility::getanim(var_1 + "_6"), 1, 0.2);
  self setanimknoblimited(scripts\engine\utility::getanim(var_1 + "_8"), 1, 0.2);
  self.asm.forcetrackloop = 1;
  var_3 = scripts\engine\utility::getanim(var_1 + "_5");
  self animmode("noclip");

  if(isDefined(var_0)) {
    var_4 = getstartorigin(var_0.origin, var_0.angles, var_3);
    var_5 = getstartangles(var_0.origin, var_0.angles, var_3);
    self forceteleport(var_4, var_5);
  }

  for(;;) {
    self setflaggedanimrestart("aim_loop", var_3, 1);
    self waittillmatch("aim_loop", "end");
  }
}

anim_aim_end() {
  self.asm.forcetrackloop = 0;
  self.leftaimlimit = self.og_leftaimlimit;
  self.rightaimlimit = self.og_rightaimlimit;
  self.upaimlimit = self.og_upaimlimit;
  self.downaimlimit = self.og_downaimlimit;
  self.og_leftaimlimit = undefined;
  self.og_rightaimlimit = undefined;
  self.og_upaimlimit = undefined;
  self.og_downaimlimit = undefined;
}

#using_animtree("generic_human");

anim_aim_shoot(var_0) {
  waittillframeend;
  level.bulletcount = 0;
  var_1 = scripts\engine\utility::getanim("finale_gun_aim_reload");
  var_2 = isDefined(level.scr_anim[self.animname]["finale_gun_fire"]);
  var_3 = undefined;

  if(var_2) {
    var_3 = level.scr_anim[self.animname]["finale_gun_fire"];
    self setanimknoblimitedrestart(var_3, 1, 0.2);
  }

  for(;;) {
    waitframe();

    if(!isDefined(self.enemy)) {
      continue;
    }
    scripts\asm\asm_bb::bb_updateshootparams(self.enemy getshootatpos(), self.enemy, 1);
    var_4 = self._blackboard.shootparams_shotsperburst;
    var_5 = var_4 == 1 || self._blackboard.shootparams_style == "semi";

    if(scripts\aitypes\combat::isaimedataimtarget()) {
      if(!isDefined(self.asm.shootparams))
        scripts\asm\shoot\script_funcs::shoot_updateparams();

      var_4 = self._blackboard.shootparams_shotsperburst;
      var_5 = var_4 == 1 || self._blackboard.shootparams_style == "semi";

      while(level.bulletcount < 6) {
        wait(randomfloat(0.2));

        if(level.bulletcount == 0)
          level.stealth_check["is_shooting"] = 1;

        level.bulletcount++;
        scripts\asm\shoot\script_funcs::shootatshootentorpos(var_5);

        if(level.bulletcount == 6)
          level.stealth_check["is_shooting"] = 0;

        if(var_2)
          self setanim(var_3, 1);

        wait 0.5;

        if(var_2)
          self clearanim(var_3, 0.1);
      }

      self.barkovreloading = 1;
      self setflaggedanimknoballrestart("reload_anim", var_1, %root, 1);
      self waittillmatch("reload_anim", "end");
      level.bulletcount = 0;
      wait 0.4;
      self.barkovreloading = 0;
    }
  }
}

facial_death() {
  self clearanim(%head, 0.1);
  self setfacialindex("death");
}

facial_clear() {
  self clearanim(%scripted_talking, 0.1);
}