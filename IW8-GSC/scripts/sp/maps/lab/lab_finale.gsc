/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\lab\lab_finale.gsc
***********************************************/

function finale_preload() {
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

function finale_postload() {
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
  scripts\engine\sp\utility::add_hint_string("melee_stealth", &"CONTEXT_MELEE/STEALTH_KILL", &melee_hint_break);

  if(!getdvarint("LLQQOPKTKM")) {
    var0 = getEnt("finale_heli_reflect_model", "targetname");

    if(isDefined(var0)) {
      var0 delete();
    }

    var1 = scripts\engine\utility::array_combine(getEntArray("heli_nets", "targetname"), getEntArray("finale_heliTarp", "targetname"));

    foreach(var3 in var1) {
      var3 hide();
    }

    return;
  }
}

function melee_hint_break() {
  return level.meleehintshow;
}

function finale_perspective_start() {
  scripts\sp\maps\lab\lab_util::spawn_team_price();
  level.pipes_bomb = scripts\engine\utility::getStruct("start_point_struct", "script_noteworthy");
  scripts\engine\sp\utility::set_start_location("final_pipes_start", [level.player, level.price, level.rebel_1, level.rebel_2, level.rebel_3]);
  thread finale_heli_setup();
}

function finale_perspective_catchup() {
  level.player.handle_unresolved_collision = &empty_collision_handler;
}

function finale_perspective_main() {
  level.player.handle_unresolved_collision = &empty_collision_handler;
  thread setup_heli_scene();
  thread place_finale_trees("finale_scene_trees_firstshot");
  thread disable_scriptable_shadows();
  bomb_plant_scene();

  if(isDefined(level.og_zplanes)) {
    setsaveddvar("OMNONNMOTP", level.og_zplanes);
  }

  level.player setclienttriggeraudiozone("lab_helicopter", 0.25);
  heli_intro_scene();
  thread delete_allies();
}

function empty_collision_handler() {}

#using_animtree("vehicles");

function fix_heli_blades() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  level.finale_heli setscriptablepartstate("engine", "off");
  level.finale_heli setscriptablepartstate("engine", "on");
  level.finale_heli useanimtree(#animtree);
  var0 = level.vehicle.templates.driveidle[level.finale_heli.model];
  var1 = level.vehicle.templates.driveidle_animrate[level.finale_heli.model];
  level.finale_heli setanim(var0, 1, 0.2, var1);
}

function place_finale_trees(var0) {
  var1 = scripts\engine\utility::getStructArray(var0, "targetname");

  if(!isDefined(var1)) {
    return;
  }

  if(!isDefined(level.fake_trees)) {
    level.fake_trees = [];
  }

  foreach(var3 in var1) {
    var4 = spawn("script_model", var3.origin);
    var4.angles = var3.angles;
    level.fake_trees[level.fake_trees.size] = var4;
    var4 setModel(var3.script_noteworthy);
    var4 dontcastdistantshadows();
    var4 dontcastshadows();
  }
}

function disable_scriptable_shadows() {
  wait 5;
  var0 = getscriptablearray();
  var1 = [level.player, level.player_rig, level.barkov, level.farah, level.finale_heli, level.nikolai, level.finale_heli.pilot];
  var1 = scripts\engine\utility::array_removeundefined(var1);
  var0 = scripts\engine\utility::array_remove_array(var0, var1);
  var0 = scripts\engine\utility::array_remove_array(var0, getaiarray());

  foreach(var3 in var0) {
    if(!isDefined(var3) || distance2d(level.player.origin, var3.origin) < 400) {
      continue;
    }

    var3 dontcastshadows();
  }
}

function enable_scriptable_shadows() {
  var0 = getscriptablearray();

  foreach(var2 in var0) {
    var2 castdistantshadows();
    var2 castshadows();
  }
}

function finale_trees_delete(var0) {
  foreach(var2 in level.fake_trees) {
    if(isDefined(var2)) {
      var2 delete();
    }
  }
}

function bomb_plant_scene() {
  var0 = scripts\sp\maps\lab\lab_lighting::pipes_hero_light_rig_setup();

  while(!isDefined(level.pipes_bomb)) {
    waitframe();
  }

  var1 = scripts\engine\utility::getStruct(level.pipes_bomb.target, "targetname");
  var0.origin = var1.origin;
  thread scripts\sp\maps\lab\lab_lighting::enable_pipes_hero_lights();
  GscBinSkip4(0x35);
}

function audio_pipes_bomb_plant_start() {
  wait 0.2;
}

function disable_pipes_lights() {
  var0 = getEntArray("pipes_hero_light", "targetname");

  if(isDefined(var0)) {
    foreach(var2 in var0) {
      var2 setlightintensity(0);
      var2 unlink();
      var2 delete();
    }

    return;
  }
}

function move_barkov_closer(var0) {
  level.barkov.streamnode = scripts\engine\utility::spawn_script_origin(var0.origin, level.finale_heli.angles);
  level.barkov.streamnode scripts\common\anim::anim_first_frame_solo(level.barkov, "finale_intro");
  level.barkov show();
}

function play_single_anim_last_frame(var0, var1) {
  level endon("start_barkov_scene");
  var0 scripts\common\anim::anim_single_solo(self, var1);
  var0 scripts\common\anim::anim_last_frame_solo(self, var1);
}

function bomb_plant_cinematic_settings() {
  level scripts\engine\sp\utility::dof_enable(5.6, 10);
  wait 2;
  level.price scripts\engine\sp\utility::dof_enable_autofocus(2.8, 2, undefined, undefined, "tag_eye");
  wait 4.5;
  level scripts\engine\sp\utility::dof_enable(2.8, 600, 2, undefined);
  wait 4.75;
  level scripts\engine\sp\utility::dof_disable();
}

function setup_final_shot() {
  self hide();
  setup_final_shot_animnode();
}

function setup_final_shot_animnode() {
  self.struct = spawnStruct();
  self.struct.origin = (-84.749, 0, -137.265);
  self.struct.angles = (0, 0, 0);
  self.struct scripts\common\anim::anim_first_frame_solo(self, "final_shot");
}

function bomb_plant_dialog() {
  level endon("bomb_plant_end");

  foreach(var1 in scripts\engine\sp\utility::getvehiclearray()) {
    var1 scalevolume(0, 0);
  }

  foreach(var1 in scripts\engine\sp\utility::getvehiclearray()) {
    var1 scalevolume(0.15, 10);
  }

  wait 6;
  wait 10;
  level.price scripts\sp\maps\lab\lab_vo_util::say("dx_vom_pri_perspective_swap_barkov_20");
  level.price scripts\sp\maps\lab\lab_vo_util::say("dx_vom_pri_finale_heli_intro_10");
}

function kyle_logic_thread() {
  if(!isDefined(level.kyle)) {
    scripts\sp\maps\lab\lab_util::spawn_kyle();
  }

  level.kyle scripts\engine\sp\utility::name_hide();
  level.kyle detach(level.kyle.headmodel);

  if(isDefined(level.kyle.hatmodel)) {
    level.kyle detach(level.kyle.hatmodel);
    return;
  }
}

function setup_heli_scene() {
  while(!isDefined(level.finale_heli)) {
    waitframe();
  }

  var0 = level.finale_heli;
  var1 = "finale_intro";
  wait 3;
  level.finale_heli.idle_animnode1 = scripts\engine\utility::getStruct("finale_heli_idle1", "targetname");
  level.finale_heli.idle_animnode2 = scripts\engine\utility::getStruct("finale_heli_idle2", "targetname");
  level.finale_heli dontinterpolate();
  level.finale_heli.idle_animnode1 thread scripts\common\anim::anim_loop_solo(level.finale_heli, "finale_sway", "stop_heli_loop");
  level.finale_heli hideallparts();
  level.alt_rig = scripts\engine\sp\utility::spawn_anim_model("player_rig");
  level.alt_rig setModel("viewhands_farah_55inch_wind");
  level.alt_rig dontcastshadows();
  level.alt_rig linkTo(var0);
  level.alt_rig linkTo(var0);
  level.alt_rig hide();
  var0 scripts\common\anim::anim_first_frame_solo(level.alt_rig, var1 + "_cam");
  level.farah linkTo(var0);
  level.farah hide();
  var0 scripts\common\anim::anim_first_frame_solo(level.farah, var1);
  level.finale_heli.pilot hide();
  level.farah scripts\engine\sp\utility::name_hide();
  thread audio_start_ramp_emitters();
}

function audio_start_ramp_emitters() {
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

function heli_intro_scene() {
  level.finale_heli showallparts();
  level.finale_heli.pilot show();
  thread finale_extras_setup();
  finale_cam_anim(level.player_rig, level.finale_heli, "finale_intro");
}

function finale_cam_anim(var0, var1) {
  var2 = scripts\engine\utility::getanim(var1 + "_cam");
  var3 = getstartorigin(var0.origin, var0.angles, var2);
  var4 = getstartangles(var0.origin, var0.angles, var2);
  scripts\sp\hud_util::fade_out(0);
  scripts\sp\player_rig::unlink_player_from_rig(0, "prone", 1);
  finale_show_heli(level.finale_heli);
  level.barkov.propmodel = spawn("script_model", level.barkov.origin);
  level.barkov.propmodel setModel("parts_radio_small");
  level.player hideviewmodel();
  level.player modifybasefov(45, 0.05);
  level.alt_rig dontinterpolate();
  level.player dontinterpolate();
  level.player setOrigin(var3);
  level.player setplayerangles(var4);
  link_player_to_set_rig(var0, level.alt_rig, var1 + "_cam", "prone", 0, undefined, 1);
  level notify("finale_intro_start");
  thread cine_cam_settings();
  thread finale_cam_other_anims(var0, var1);
  finale_cam_player_anims(var0, var1 + "_cam");
  thread finale_cam_extras();
  thread finale_cam_finish(var0, var1);
}

function finale_cam_extras() {
  level.alt_rig hide();
  level.player showviewmodel();
  level.player setcinematicmotionoverride("iw8_heli_ride");
  level notify("finale_intro_end");
  level.finale_heli.idle_animnode1 scripts\engine\sp\utility::notify_delay("stop_heli_loop", 0.15);
  thread hover_pattern_internal();
}

function hover_pattern_internal() {
  level endon("barkov_dead");
  var0 = scripts\engine\utility::getStruct("finale_path_end", "targetname");
  change_yaw_angle(var0);
  var0 = scripts\engine\utility::getStruct("ending_path_start", "targetname");
  scripts\engine\sp\utility::flagwaitthread("start_choking_scene", &change_yaw_angle, var0);
  self setyawspeed(14, 2, 2);

  for(;;) {
    self setgoalyaw(level.heli_yaw["left"]);
    wait randomfloatrange(1, 1.75);
    self setgoalyaw(level.heli_yaw["angles"]);
    wait randomfloatrange(1, 1.75);
    self setgoalyaw(level.heli_yaw["right"]);
    wait randomfloatrange(1, 1.75);
    self setgoalyaw(level.heli_yaw["angles"]);
    wait randomfloatrange(1, 1.75);
  }
}

function change_yaw_angle(var0) {
  level.heli_yaw["angles"] = var0.angles[1];
  level.heli_yaw["left"] = level.heli_yaw["angles"] + 2;
  level.heli_yaw["right"] = level.heli_yaw["angles"] - 2;
}

function cine_cam_settings() {
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

function delete_allies() {
  level.kyle scripts\sp\maps\lab\lab_util::disable_magic_bullet_delete();
  level.price scripts\sp\maps\lab\lab_util::disable_magic_bullet_delete();
  level.rebel_1.spawner notify("stop_rebel_flood");
  level.rebel_1 scripts\sp\maps\lab\lab_util::disable_magic_bullet_delete();
  level.rebel_2.spawner notify("stop_rebel_flood");
  level.rebel_2 scripts\sp\maps\lab\lab_util::disable_magic_bullet_delete();
  level.rebel_3.spawner notify("stop_rebel_flood");
  level.rebel_3 scripts\sp\maps\lab\lab_util::disable_magic_bullet_delete();
}

function finale_show_heli() {
  self showallparts();

  foreach(var1 in self.nets) {
    var1 show();
  }

  var3 = scripts\engine\utility::array_combine(getEntArray("heli_nets", "targetname"), getEntArray("finale_heliTarp", "targetname"));

  foreach(var5 in var3) {
    var5 show();
  }

  thread fix_heli_blades();
}

function finale_cam_finish(var0, var1) {
  thread farah_as_player_vo();
  wait 0.05;
  level.alt_rig hide();
  unlink_player_from_set_rig(level.alt_rig, 0, "prone", 1, 1);
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 1);
  level.player setentitysoundcontext("gender", "female", 0.1);
  thread start_heli_shake();
  thread finale_knockdown_scene_setup_rig(var0);
  level.barkov scripts\engine\utility::delaycall(0.2, &setlookattext, "Gen. Barkov", &"");
  var2 = scripts\engine\utility::getStruct("finale_path_start", "targetname");
  var2 = scripts\engine\utility::getStruct(var2.target, "targetname");

  if(!level.finale_heli scripts\common\vehicle::ishelicopter()) {
    level.finale_heli attachpath(var2);
  }

  level.finale_heli thread scripts\common\vehicle::vehicle_paths(var2);
  scripts\common\vehicle_paths::gopath(level.finale_heli);
  level.finale_heli vehicle_setspeed(23, 5, 5);
  level.finale_heli.oob_enabled = 1;
  thread player_is_outofbounds();
  thread setup_bodies_for_streaming(var0);
}

function finale_cam_finish_kickoff(var0, var1) {
  level.player showviewmodel();
  level.player showlegsandshadow();
  wait 0.3;
  level.alt_rig hide();
  unlink_player_from_set_rig(level.alt_rig, 0, "prone", 1, 1);
  level.player setentitysoundcontext("gender", "female", 0.1);
  thread finale_knockdown_scene_setup_rig(var0);
  level.barkov scripts\engine\utility::delaycall(0.2, &setlookattext, "Gen. Barkov", &"");
  level.finale_heli.oob_enabled = 1;
  thread player_is_outofbounds();
  thread setup_bodies_for_streaming(var0);
}

function farah_as_player_vo() {
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_finale_heli_intro_12");
  wait 0.3;
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_far_finale_heli_intro_13");
}

function setup_bodies_for_streaming(var0) {
  level.barkovfakebodies = [];
  var1 = ["body_villain_barkov_wind_all_stab_1", "body_villain_barkov_wind_all_stab_2", "body_villain_barkov_wind_all_stab_3", "body_villain_barkov_wind_all_stab_4", "body_villain_barkov_wind_all_stab_5", "body_villain_barkov_wind_all_stab_6", "body_villain_barkov_wind_gun_stab_3", "body_villain_barkov_wind_gun_stab_4", "body_villain_barkov_wind_gun_stab_5", "body_villain_barkov_wind_gun_stab_6", "head_villain_barkov_stab_5_blendshape"];

  for(var2 = 0; var2 < var1.size; var2++) {
    thread spawn_in_streaming_bodies(var0, var1[var2]);
  }

  level scripts\engine\utility::waittill_any("barkov_dead", "stop_screen_shake");
  scripts\engine\utility::array_delete(level.barkovfakebodies);
}

function spawn_in_streaming_bodies(var0, var1) {
  if(var1 == "head_villain_barkov_stab_5_blendshape") {
    var2 = havemapentseffects("actor_enemy_villain_barkov_old", var0.origin, var0.angles, 1, 0, 1);
    var2.ignoreme = 1;
    var2.ignoreall = 1;
    var2 scripts\engine\utility::disable_pain();
    var2 scripts\sp\utility::context_melee_enable(0);
    var2 scripts\engine\sp\utility::battlechatter_off();
    var2 scripts\engine\sp\utility::name_hide();
    var2 scripts\engine\sp\utility::disable_bulletwhizbyreaction();
    var2 scripts\engine\sp\utility::disable_danger_react();
    var2 scripts\engine\sp\utility::disable_surprise();
    var2 scripts\engine\sp\utility::disable_damagefeedback();
    var2 scripts\common\ai::gun_remove();
    var2 linkTo(var0, "tag_origin", (166.5, -0.5, -110), (0, 0, 0));
    var2 detach(var2.headmodel);
    var2 attach(var1);
    var2 visiblenotsolid();
  } else {
    var2 = spawn("script_model", var1.origin);
    var2 linkTo(var1, "tag_origin", (166.5, -0.5, -110), (0, 0, 0));
    var2 setModel(var2);
    var2 notsolid();
  }

  var2 dontcastshadows();
  level.barkovfakebodies[level.barkovfakebodies.size] = var2;
}

function finale_cam_player_anims(var0, var1) {
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var2 = scripts\engine\utility::getanim(var1 + "_end");
  var3 = getstartorigin(var0.origin, var0.angles, var2);
  var4 = getstartangles(var0.origin, var0.angles, var2);
  level.player showviewmodel();
  scripts\engine\utility::delaythread(0.1, &scripts\sp\hud_util::fade_in, 0);
  level.player dontinterpolate();
  level.alt_rig dontinterpolate();
  var0 scripts\common\anim::anim_single_solo(level.alt_rig, var1);
  unlink_player_from_set_rig(level.alt_rig, 0, "prone", 1, 1);
  level notify("player_is_prone_and_in_control");
  level.player dontinterpolate();
  level.player setOrigin(var3);
  level.player setplayerangles(var4);
  level.alt_rig dontinterpolate();
  level.player dontinterpolate();
  link_player_to_set_rig(var0, level.alt_rig, var1 + "_end", "prone", 0, undefined, 1);
}

function start_heli_shake() {
  level endon("stop_screen_shake");
  level.og_mbradial = getdvarint("NMORQOTSK");

  if(isplatformps4()) {
    setsaveddvar("NMORQOTSK", 3);
  } else {
    setsaveddvar("NMORQOTSK", 4);
  }

  for(;;) {
    level.player screenshakeonentity(0.2, 0.5, 0.4, 5, 0, 0, 1000, 6, 1.8, 50);
    wait 5;
  }
}

function rand_num(var0, var1) {
  var2 = randomfloatrange(var0 - var1, var0 + var1);
  return var2;
}

function finale_cam_other_anims(var0, var1) {
  showmayhem("mayh_lab_heli_tarp");
  thread audio_finale_heli_start();
  thread finale_cam_farah_anims(level.farah, var0);
  thread finale_cam_barkov_anims(level.barkov, var0);
  thread start_fake_combat_below();
}

function audio_finale_heli_start() {
  level waittill("start_tarp_sim");
  level waittill("player_is_prone_and_in_control");
}

function finale_cam_farah_anims(var0, var1) {
  self show();
  self dontinterpolate();
  var0 scripts\common\anim::anim_single_solo(self, var1);
  self hide();
  level.knife hide();
  hidemayhem("mayh_lab_heli_tarp");
}

function finale_cam_barkov_anims(var0, var1) {
  self show();
  self linkTo(var0);
  self dontinterpolate();
  var0 thread scripts\common\anim::anim_single_solo(self, var1);
  self.propmodel linkTo(self, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
  scripts\engine\utility::delaythread(6, &barkov_wind_change);
  wait 9;
  self dontinterpolate();
  var0 thread scripts\common\anim::anim_loop_solo(self, var1 + "_idle", "stop_finale_intro_idle");
  level waittill("finale_intro_end");
}

function barkov_wind_change() {
  self setModel("body_villain_barkov_wind");
}

function finale_knockdown_scene_setup_rig(var0) {
  level.alt_rig hide();
  level.alt_rig linkTo(var0);
  var0 scripts\common\anim::anim_first_frame_solo(level.alt_rig, "finale_knock_down");
}

function finale_kick_scene_setup_rig(var0) {
  level.alt_rig hide();
  level.alt_rig linkTo(var0);
  var0 scripts\common\anim::anim_first_frame_solo(level.alt_rig, "finale_stabbed");
}

function finale_extras_setup() {
  setomnvar("ui_hide_hud", 1);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  setomnvar("ui_hide_weapon_info", 1);
  thread player_waittill_player_death();
}

function player_waittill_player_death() {
  level.player waittill("death");
  setomnvar("ui_hide_hud", 0);
}

function link_player_to_set_rig(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  if(!isDefined(var0.allows)) {
    set_player_set_rig_allows(var0);
  }

  var0 hide();

  if(isDefined(var1)) {
    thread scripts\common\anim::anim_first_frame_solo(var0, var1);
  }

  var0.ogstance = level.player getstance();

  if(!isDefined(var2)) {
    var2 = "stand";
  }

  var0.stance = var2;

  switch (var2) {
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

  level.player setstance(var2);
  level.player enablequickweaponswitch(1);
  level.player scripts\common\utility::allow_array(var0.allows, 0, "player_rig");

  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(var3) {
    if(!isDefined(var4)) {
      var4 = 0.2;
    }

    level.player playerlinktoblend(var0, "tag_player", var4);
    wait var4;
    waitframe();
  }

  if(istrue(var5)) {
    level.player playerlinktoabsolute(var0, "tag_player");
  } else {
    if(!isDefined(var10)) {
      var10 = 0;
    }

    if(!isDefined(var6)) {
      var6 = 45;
    }

    if(!isDefined(var7)) {
      var7 = 45;
    }

    if(!isDefined(var8)) {
      var8 = 15;
    }

    if(!isDefined(var9)) {
      var9 = 15;
    }

    level.player playerlinktodelta(var0, "tag_player", 1, var6, var7, var8, var9, var10);
  }

  var0 show();
  return var0;
}

function set_player_set_rig_allows(var0, var1) {
  if(!isDefined(var1)) {
    var1 = ["weapon", "offhand_weapons", "melee", "sprint", "jump", "mantle"];
  }

  var0.allows = var1;
}

function unlink_player_from_set_rig(var0, var1, var2, var3, var4) {
  if(!scripts\engine\utility::is_equal(level.player getlinkedparent(), var0)) {
    return;
  }

  switch (var0.stance) {
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

  if(istrue(var1)) {
    var2 = var0.ogstance;
  }

  if(isDefined(var2)) {
    if(istrue(var3)) {
      level.player setstance(var2, 1, 1, 1);
    } else if(var2 != var0.stance) {
      level.player setstance(var2);
    }
  }

  level.player unlink();
  level.player enablequickweaponswitch(0);
  level.player scripts\common\utility::allow_array(var0.allows, 1, "player_rig");

  if(!istrue(var4)) {
    var0 delete();
    return;
  }
}

function finale_heli_start() {
  thread place_finale_trees("finale_scene_trees_finalshot");
  finale_heli_setup();
  var0 = "finale_intro";
  var1 = level.finale_heli;
  thread setup_final_shot();
  level.finale_heli.idle_animnode1 = scripts\engine\utility::getStruct("finale_heli_idle1", "targetname");
  level.finale_heli.idle_animnode2 = scripts\engine\utility::getStruct("finale_heli_idle2", "targetname");
  level.finale_heli.idle_animnode1 thread scripts\common\anim::anim_loop_solo(level.finale_heli, "finale_sway", "stop_heli_loop");
  level.barkov linkTo(var1);
  level.farah linkTo(var1);
  var1 thread scripts\common\anim::anim_loop_solo(level.barkov, var0 + "_idle", "stop_finale_intro_idle");
  var1 scripts\common\anim::anim_first_frame_solo(level.farah, "finale_kickoff_sh01");
  level.barkov show();
  barkov_wind_change(level.barkov);
  finale_show_heli(level.finale_heli);
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
  link_player_to_set_rig(var1, level.alt_rig, var0 + "_cam_end", "prone", 0, undefined, 1);
  level.finale_heli.idle_animnode1 scripts\engine\sp\utility::notify_delay("stop_heli_loop", 0.3);
  thread finale_cam_finish(var1, var0);
  level.player setstance("prone", 1, 1, 1);
  level.player showviewmodel();
  thread setup_player_last_frame(var1, var0);
  thread start_heli_shake();
  thread start_fake_combat_below();
}

function finale_heli_main() {
  thread players_health_as_farah();
  level.barkov.anim_playvo_func = &scripts\sp\maps\lab\lab_vo_util::simple_dialogue_on_tag;
  thread barkov_damage(level.barkov);
  boss_fight_intro();
  scripts\engine\utility::flag_wait("ready_for_kickoff");
}

function finale_heli_catchup() {}

function players_health_as_farah() {
  var0 = 60;

  if(level.gameskill == 3) {
    var0 = 80;
  } else if(level.gameskill == 0) {
    var0 = 45;
  }

  level.player scripts\sp\player::set_player_max_health(var0);
  level.player scripts\sp\player::scale_player_death_shield_duration(0.1);
}

function start_fake_combat_below() {
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

  for(var0 = 1; var0 < 6; var0++) {
    thread fake_ally_setup(var0);
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("fake_ally_trigger");

  for(var0 = 1; var0 < 6; var0++) {
    thread fake_enemy_setup(var0);
  }

  thread sfx_dist_battle();
}

function sfx_dist_battle() {
  var0 = spawn("script_origin", (1076, 2119, 383));
  var0 playLoopSound("emt_dist_battle_lp");
  level waittill("stop_spawning_finale_combat");
  var0 scripts\engine\sp\utility::sound_fade_and_delete(3, 1);
}

function fake_ally_setup(var0) {
  level endon("stop_spawning_finale_combat");
  var1 = getspawner("redshirt_rebel_" + var0, "targetname");
  var2 = var1 stalingradspawn();
  GscBinSkip4(0x6e, var2, var0);
}

function fake_ally_death_watcher(var0) {
  self waittill("death");
  wait 1;
  thread fake_ally_setup(var0);
}

function fake_enemy_setup(var0) {
  level endon("stop_spawning_finale_combat");
  var1 = getEnt("fake_enemy_volume", "targetname");
  var2 = getspawner("fake_combat_enemy_" + var0, "targetname");
  var3 = var2 stalingradspawn();
  GscBinSkip4(0x6e, var3, var0);
}

function fake_enemy_death_watcher(var0) {
  self waittill("death");
  wait 1;
  thread fake_enemy_setup(var0);
}

function setup_player_last_frame(var0, var1) {
  level.player dontinterpolate();
  var0 scripts\common\anim::anim_first_frame_solo(level.alt_rig, var1 + "_cam_end");
}

function boss_fight_intro() {
  finale_player_setup();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);

  foreach(var1 in level.heroes) {
    if(isDefined(var1)) {
      var1.ignoreme = 1;
      var1.ignoreall = 1;
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
  thread swap_clip();
}

function finale_player_setup() {
  level.player setsuit("iw8_teenager_combat");
  level.player takeallweapons();
  scripts\engine\sp\utility::blend_movespeedscale(0.7, 1);
  scripts\sp\maps\lab\lab_util::setplayerviewmodel("viewhands_farah_55inch", undefined, "default_character_shadow");
  level.scr_model["player_rig"] = "viewhands_farah_55inch_wind";
  scripts\sp\utility::context_melee_set_arms("viewhands_farah_55inch_wind");
  GscBinSkip1(0x45, 0, scripts\sp\utility::make_weapon("iw8_farahknife_sp"));
}

function swap_clip() {
  level.barkov endon("death");

  for(;;) {
    waitframe();

    if(level.player getstance() != "prone" && distancesquared(level.player.origin, level.barkov.origin) > 100 & 100) {
      break;
    }
  }
}

function finale_kickoff_start() {
  thread place_finale_trees("finale_scene_trees_finalshot");
  thread disable_scriptable_shadows();
  finale_heli_setup();
  var0 = "finale_intro";
  var1 = level.finale_heli;
  level.finale_heli.clip_stand delete();
  level.finale_heli.clip_crawl delete();
  scripts\engine\utility::delaythread(0.3, &finale_player_setup);
  thread setup_final_shot();
  level.finale_heli.idle_animnode1 = scripts\engine\utility::getStruct("finale_heli_idle1", "targetname");
  level.finale_heli.idle_animnode2 = scripts\engine\utility::getStruct("finale_heli_idle2", "targetname");
  level.finale_heli.idle_animnode2 thread scripts\common\anim::anim_loop_solo(level.finale_heli, "finale_sway", "stop_heli_loop");
  level.barkov linkTo(var1);
  level.farah linkTo(var1);
  level.barkov.iscompletelydead = 1;
  var1 thread scripts\common\anim::anim_loop_solo(level.barkov, "finale_death_stabbed_idle", "finale_idle");
  var1 scripts\common\anim::anim_first_frame_solo(level.farah, "finale_kickoff_sh01");
  level.barkov show();
  barkov_wind_change(level.barkov);
  level.barkov.kickoffstart = "finale_kickoff_start_alt";
  finale_show_heli(level.finale_heli);
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
  link_player_to_set_rig(var1, level.alt_rig, var0 + "_cam_end", "prone", 0, undefined, 1);
  level.finale_heli.idle_animnode2 scripts\engine\sp\utility::notify_delay("stop_heli_loop", 0.3);
  thread finale_cam_finish_kickoff(var1, var0);
  level.player setstance("prone", 1, 1, 1);
  thread setup_player_last_frame(var1, var0);
  thread start_heli_shake();
  thread start_fake_combat_below();
}

function finale_kickoff_main() {
  barkov_kick_out_scene(level.barkov, level.finale_heli, level.kickout);
  scripts\engine\utility::flag_wait("barkov_dead");
}

function finale_kickoff_catchup() {}

function barkov_kick_out_scene(var0, var1) {
  scripts\engine\utility::delaythread(0.2, &scripts\engine\sp\utility::autosave_now);
  thread can_be_shot_again(var0);
  dialogue_wheel_start();
  setomnvar("ui_dialogue_prompts_active", 0);
  setsaveddvar("OMNONNMOTP", "0.1 400 2 1000");
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  level notify("barkov_dead");
  level notify("end_longdeath_lines");
  thread heli_final_path();
  thread barkov_damage_ending(var0);
  scripts\engine\utility::flag_set("kick_lines");
  scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function can_be_shot_again(var0) {
  level endon("barkov_dead");

  if(!istrue(self.iscompletelydead)) {
    self waittill("damage");
    var0 notify("finale_idle");
    long_death_barkov(0);
    return;
  }
}

function barkov_damage_ending(var0) {
  level.player modifybasefov(55, 4);
  level.alt_rig linkTo(var0);
  link_player_to_set_rig(var0, level.alt_rig, self.kickoffstart, "stand", 0, undefined, 0, 25, 25, 25, 25, 1);
  thread barkov_damage_ending_setup();

  if(self.iscompletelydead) {
    var0 scripts\common\anim::anim_single_solo(level.alt_rig, self.kickoffstart);
    var0 scripts\common\anim::anim_last_frame_solo(level.alt_rig, self.kickoffstart);
    self notify("longdeath_ender");
    var0 notify("finale_idle");
  } else {
    self notify("longdeath_ender");
    var0 notify("finale_idle");
    var0 scripts\common\anim::anim_single([level.alt_rig, self], self.kickoffstart);
    var0 scripts\common\anim::anim_last_frame_solo(level.alt_rig, self.kickoffstart);
    var0 scripts\common\anim::anim_last_frame_solo(level.barkov, self.kickoffstart);
  }

  thread finale_skip();
  finale_skippable_section(var0);
  scripts\sp\utility::userskip_stop();
  thread scripts\sp\analytics::analytics_kleenex_update("end_stopwatch");
  level thread scripts\sp\utility::giveachievement_wrapper("finish", 1);

  if(level.lowestgameskill + 1 > 3) {
    var1 = 1;
    var2 = level.player getlocalplayerprofiledata("missionHighestDifficulty");

    for(var3 = 0; var3 < 13; var3++) {
      if(var2[var3] != "4" && var2[var3] != "5") {
        var1 = undefined;
        break;
      }
    }

    if(istrue(var1)) {
      level thread scripts\sp\utility::giveachievement_wrapper("vetfinish", 1);
    }
  }

  thread lab_ending_bink();
}

function barkov_damage_ending_setup() {
  level.alt_rig hide();
  level.alt_rig scripts\engine\utility::delaycall(0.5, &show);
  thread scripts\sp\maps\lab\lab_util::cine_letterboxing_up(1.5);
  thread kickoff_cinematic_settings();
  level.player lerpfovscalefactor(0, 1.5);
  level.player lerpviewangleclamp(1.5, 0.3, 0.3, 0, 0, 0, 0);
}

function finale_skippable_section(var0) {
  level endon("skip_end_scene");
  GscBinSkip4(0x35);
}

function audio_finale_cockpit_shot() {
  level.player clearsoundsubmix("sp_lab_ending_duck_1", 0.2);
}

function audio_final_shot_start() {
  if(isDefined(level.sfx_heli_ramp_left)) {
    level.sfx_heli_ramp_left thread scripts\engine\sp\utility::sound_fade_and_delete(0.2, 1);
  }

  if(isDefined(level.sfx_heli_ramp_right)) {
    level.sfx_heli_ramp_right thread scripts\engine\sp\utility::sound_fade_and_delete(0.2, 1);
  }

  if(isDefined(level.sfx_heli_ramp_center)) {
    level.sfx_heli_ramp_center thread scripts\engine\sp\utility::sound_fade_and_delete(0.2, 1);
  }

  level.player setclienttriggeraudiozone("lab_hillside", 0.1);
  level.player playSound("scn_lab_final_heli_flyover_lr");
  wait 3;
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 3);
}

function trigger_hill_destruction() {
  GscBinSkip4(0x35, "finale_scene_trees_finalshot");
}

function finale_skip() {
  setsaveddvar("OMNONNMOTP", level.og_zplanes);
  var0 = scripts\sp\utility::userskip_wait();

  if(!var0) {
    return;
  }

  setmusicstate("mx_lab_null");
  scripts\sp\hud_util::fade_out(0);
  wait 0.2;
  level notify("skip_end_scene");
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 0.5);

  if(isDefined(level.endhud)) {
    level.endhud destroy();
  }

  if(isDefined(level.farah)) {
    level.farah stopsounds();
    waitframe();
    level.farah scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe();
    level.farah delete();
  }

  if(isDefined(level.price)) {
    level.price stopsounds();
  }

  if(isDefined(level.alex)) {
    level.alex stopsounds();
  }

  if(isDefined(level.sfx_heli_ramp_left)) {
    level.sfx_heli_ramp_left thread scripts\engine\sp\utility::sound_fade_and_delete(0, 1);
  }

  if(isDefined(level.sfx_heli_ramp_right)) {
    level.sfx_heli_ramp_right thread scripts\engine\sp\utility::sound_fade_and_delete(0, 1);
  }

  if(isDefined(level.sfx_heli_ramp_center)) {
    level.sfx_heli_ramp_center thread scripts\engine\sp\utility::sound_fade_and_delete(0, 1);
  }

  if(isDefined(level.player_rig)) {
    level.player_rig stopsounds();
  }

  if(isDefined(level.alt_rig)) {
    level.alt_rig stopsounds();
  }

  if(isDefined(level.barkov)) {
    level.barkov stopsounds();
    waitframe();
    level.barkov scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe();
    level.barkov delete();
  }

  if(isDefined(level.finale_heli) && isDefined(level.finale_heli.pilot)) {
    level.finale_heli.pilot scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe();
    level.finale_heli.pilot delete();
  }

  if(isDefined(level.finale_heli)) {
    level.finale_heli delete();
  }

  if(isDefined(level.finale_heli_intro)) {
    level.finale_heli_intro delete();
  }

  scripts\engine\utility::flag_set("barkov_dead");
  thread cleanup_finale_combat_guys(0.1);
  setsaveddvar("NMORQOTSK", level.og_mbradial);
  scripts\sp\maps\lab\lab_util::cine_letterboxing_down(0);
  wait 0.2;
  scripts\engine\utility::delaythread(0.05, &scripts\sp\hud_util::fade_in, 0.05);

  if(isDefined(level.kyle)) {
    level.kyle delete();
    return;
  }
}

function kickoff_setup() {
  level.alt_rig hide();
  thread ending_cleanup();
  level.farah scripts\engine\utility::delaycall(0.5, &show);
  level.farah scripts\engine\sp\utility::name_hide();
  thread farah_body_swap();
  level.player scripts\engine\utility::delaycall(0.2, &clearcinematicmotionoverride);
  wait 1.5;
  setsaveddvar("NMORQOTSK", level.og_mbradial);
  level notify("stop_screen_shake");
  level.player screenshakeonentity(0.2, 0.5, 0.4, 14, 0, 8, 1000, 6, 1.8, 50);
}

function cleanup_finale_combat_guys(var0) {
  wait var0;
  level notify("stop_spawning_finale_combat");

  foreach(var2 in level.finale_combat_ai) {
    if(var3 < 5) {
      thread cleanup_ai();
      continue;
    }

    var2 scripts\engine\utility::delaythread(8, &cleanup_ai);
  }
}

function cleanup_ai() {
  if(isDefined(self) && isalive(self)) {
    self kill();
    return;
  }
}

function farah_body_swap() {
  self.og_model = self.model;
  self setModel("body_hero_farah_wind");
  self.og_headmodel = self.headmodel;
  self detach(self.headmodel);
  self attach("head_hero_farah_wind");
  self.headmodel = "head_hero_farah_wind";
}

function farah_body_swap_again() {
  self setModel(self.og_model);
  self detach(self.headmodel);
  self attach(self.og_headmodel);
  self.headmodel = self.og_headmodel;
}

function trigger_hill_trees() {
  var0 = getscriptablearray("spruce_02", "script_noteworthy");

  foreach(var2 in var0) {
    var2 setscriptablepartstate("base", "death");
    playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_sml"), var2.origin + (0, 0, 130));
  }
}

function kickoff_cinematic_settings() {
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

function barkov_kickoff_anim(var0) {
  scripts\engine\sp\utility::anim_stopanimScripted();
  self dontinterpolate();
  var0 scripts\common\anim::anim_single_solo(self, "finale_kickoff_sh01");
  self.diequietly = 1;
  self.skipdeathanim = 1;

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  self.allowdeath = 1;
  self startragdoll();
  self kill();
}

function lab_ending_bink() {
  level.hud_finale_black = scripts\sp\hud_util::create_client_overlay("black", 1, undefined);
  level.hud_finale_black.foreground = 0;
  play_ending_bink();
  setomnvar("ui_hide_hud", 1);
  scripts\sp\credits::playcredits();
  scripts\engine\sp\utility::nextmission();
}

function play_ending_bink() {
  level.player setplayerprogression("currentMission", "none");
  setmusicstate("");
  scripts\engine\utility::delaythread(0.1, &scripts\sp\credits::createmwlogo);
  setsaveddvar("MMRNLMPPLT", "1");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame("sp_epilogue");
  scripts\engine\utility::flag_init("skipped_ending_bink");
  thread skip_ending_bink_thread();

  while(!iscinematicplaying()) {
    waitframe();
  }

  level.player setclientomnvar("ui_hide_full_hud", 1);
  thread ending_zplanes();
  var0 = 108475;

  while(!scripts\engine\utility::flag("skipped_ending_bink") && cinematicgettimeinmsec() < var0) {
    waitframe();
  }

  scripts\sp\utility::userskip_stop();

  if(scripts\engine\utility::flag("skipped_ending_bink")) {
    if(iscinematicplaying()) {
      stopcinematicingame();
    }

    thread ending_bink_skipped_audio_transition();
  } else {
    thread ending_bink_audio_transition();
  }

  while(iscinematicplaying()) {
    waitframe();
  }
}

function ending_zplanes() {
  wait 0.5;
  setsaveddvar("OMNONNMOTP", "1 5 5 10");
}

function skip_ending_bink_thread() {
  var0 = scripts\sp\utility::userskip_wait();

  if(var0) {
    scripts\engine\utility::flag_set("skipped_ending_bink");
    return;
  }
}

function ending_bink_audio_transition() {
  setmusicstate("mx_credits_noskip");
}

function ending_bink_skipped_audio_transition() {
  setmusicstate("mx_credits_skip");
}

function finale_heli_setup() {
  var0 = scripts\engine\utility::getStruct("finale_path_end", "targetname");
  level.finale_heli_intro = scripts\common\vehicle::spawn_vehicle_from_targetname("finale_heli_intro");
  level.finale_heli_intro scripts\engine\sp\utility::assign_animtree("finale_heli");
  level.finale_heli_intro vehicle_turnengineoff();
  level.finale_heli = scripts\common\vehicle::spawn_vehicle_from_targetname("finale_heli");
  level.finale_heli vehicle_turnengineoff();
  level.finale_heli hideallparts();
  level.finale_heli scripts\engine\sp\utility::assign_animtree("finale_heli");
  level.finale_heli thread scripts\sp\maps\lab\lab_lighting::finale_heli_lights();
  var1 = level.finale_heli;
  var1.dontdisconnectpaths = 1;
  var1 notsolid();
  var1.pilot = spawn_pilot_nikolai(var1);
  var1.linked_ents = [];
  var1.pilot hide();
  var1.ground_ent = getEnt("finale_heligroundref", "targetname");
  var1.linked_ents[var1.linked_ents.size] = var1.ground_ent;
  var1.safe_trigger = getEnt("finale_heli_safe", "targetname");
  var1.linked_ents[var1.linked_ents.size] = var1.safe_trigger;
  var1.safe_trigger enablelinkTo();
  var1.start_trigger = getEnt("finale_heli_start_lookback", "targetname");
  var1.linked_ents[var1.linked_ents.size] = var1.start_trigger;
  var1.start_trigger enablelinkTo();
  var1.clips = getEnt("finale_heliClip", "targetname");
  var1.linked_ents[var1.linked_ents.size] = var1.clips;
  var1.tarps = getEntArray("finale_heliTarp", "targetname");

  foreach(var3 in var1.tarps) {
    var1.linked_ents[var1.linked_ents.size] = var3;
  }

  var1.oob = getEnt("finale_heli_outOfBounds", "targetname");
  var1.oob enablelinkTo();
  var1.oob linkTo(var1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var1.clip_stand = getEnt("finale_barkovClip_stand", "targetname");
  var1.clip_stand linkTo(var1);
  var1.clip_crawl = getEnt("finale_barkovClip_crawl", "targetname");
  var1.clip_crawl linkTo(var1);
  var1.lookorgs = getEntArray("barkov_look_structs", "targetname");

  foreach(var6 in var1.lookorgs) {
    var6 linkTo(var1);
  }

  var1.bloodsplat[0] = getEnt("blood_splat1", "targetname");
  var1.bloodsplat[1] = getEnt("blood_splat2", "targetname");

  foreach(var6 in var1.bloodsplat) {
    var1.linked_ents[var1.linked_ents.size] = var6;
  }

  var1.bloodsplat[0] hide();
  var1.bloodsplat[1] hide();
  var1.nets = getEntArray("heli_nets", "targetname");

  foreach(var11 in var1.nets) {
    var1.linked_ents[var1.linked_ents.size] = var11;
  }

  foreach(var6 in var1.linked_ents) {
    var6 linkTo(var1);
  }

  spawn_heli_farah();
  spawn_barkov();
}

function spawn_barkov() {
  var0 = getspawner("finale_barkov", "targetname");
  level.barkov = var0 scripts\engine\sp\utility::spawn_ai(1, 0);
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
  var1 = level.barkov.meleechargedistvsplayer - 150;
  level.barkov.meleechargedistvsplayer = var1;
  level.barkov.context_melee_victim_lives = 1;
  level.barkov.health = 3000;
  level.barkov.diequietly = 1;
  level.barkov.skipdeathanim = 1;
  level.barkov.disabledeathorient = 1;
  level.barkov.shotduringanim = 0;
  level.barkov.firststabs = 0;
}

function barkov_damage(var0) {
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
  thread barkov_lookback_scene_start(var0);
  thread barkov_check_for_melee_range(var0);
  thread barkov_damage_notifies(var0);
  thread barkov_idle_vo();
  var1 = scripts\engine\utility::waittill_any_return("barkov_is_missed", "barkov_is_stabbed", "barkov_is_shot");
  barkov_struggle_setup(var0);
  level.og_zplanes = getDvar("OMNONNMOTP");
  thread mus_barkov_stab();

  switch (var1) {
    case "barkov_is_missed":
      barkov_shooting_path(var0);
      break;
    case "barkov_is_stabbed":
      if(level.player getstance() == "prone") {
        thread heli_stop_for_context(level.finale_heli);
        barkov_melee_path(var0, "_back", 1);
      } else {
        thread heli_stop_for_context(level.finale_heli);
        barkov_melee_path(var0, "_back", 0);
      }

      break;
    case "barkov_is_shot":
      if(isDefined(self.damagearray["location"]) && self.damagearray["location"] == "head") {
        if(self.dirfacing == "back" || self.dirfacing == "side") {
          barkov_gun_path(var0, "headshot", "finale_shot_death");
        } else {
          barkov_gun_path(var0, "headshot", "finale_shot_death_side");
        }
      } else if(isDefined(self.damagearray["location"]) && self.damagearray["location"] == "chest") {
        if(self.dirfacing == "back" || self.dirfacing == "side") {
          barkov_gun_path(var0, "chestshot", self.animeshotdir);
        } else {
          barkov_gun_path(var0, "chestshot", "finale_shot_injure_front");
        }
      } else if(self.dirfacing == "back" || self.dirfacing == "side") {
        barkov_gun_path(var0, "chestshot", self.animeshotdir);
      } else {
        barkov_gun_path(var0, "chestshot", "finale_shot_injure_front");
      }

      break;
    default:
      break;
  }
}

function barkov_idle_vo() {
  level endon("player_spotted_finale");
  level endon("stop_radio_scene");
  wait 1;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_20");
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue_on_tag("dx_vom_ru4_finale_heli_intro_30", "j_wrist_le");
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_30");
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue_on_tag("dx_vom_ru1_finale_heli_intro_20", "j_wrist_le");
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_40");
  wait 1;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_50");
  wait 1.2;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_60");
  wait 1;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_140");
  wait 1;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_70");
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue_on_tag("dx_vom_ru4_finale_heli_intro_30", "j_wrist_le");
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_80");
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue_on_tag("dx_vom_ru3_finale_heli_intro_10", "j_wrist_le");
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_90");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_160");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_200");
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue_on_tag("dx_vom_ru1_finale_heli_intro_20", "j_wrist_le");
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_100");
  wait 2;
  scripts\engine\utility::flag_set("start_lookback");
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_110");
  wait 4;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_120");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_130");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_intro_180");
  wait 1;

  while(self.dirfacing != "side") {
    waitframe();
  }

  self notify("damage", 0, level.player, undefined, undefined, "MOD_MISS");
}

function player_is_outofbounds() {
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

function barkov_swap_to_blendshape() {
  self.og_headmodel = self.headmodel;
  self detach(self.headmodel);
  self attach("head_villain_barkov_old_blendshape_lab");
  self.headmodel = "head_villain_barkov_old_blendshape_lab";
}

function barkov_check_for_melee_range(var0) {
  level.player endon("death");
  level endon("barkov_dead");
  thread custom_context_range(0.5);
  thread melee_off();
  level.barkovmaxmeleedistsq = squared(90);
  var1 = squared(60);
  var2 = level.barkovmaxmeleedistsq;

  for(;;) {
    var3 = level.player scripts\engine\utility::waittill_any_return("melee_pressed", "attack_pressed", "ads_pressed");
    var4 = distancesquared(level.player.origin, level.barkov.origin);

    switch (var3) {
      case "melee_pressed":
        var5 = level.player getcurrentweapon();
        var6 = getweaponbasename(var5);

        if(var6 == "iw8_gunless_teen_farah") {} else {
          if(level.player getstance() == "prone") {
            var2 = var1;
          } else {
            var2 = level.barkovmaxmeleedistsq;
          }

          if(!level.player ismeleeing() && var4 < var2) {
            if(barkov_in_player_sight()) {
              self notify("barkov_is_stabbed");
            }
          }
        }

        break;
      case "attack_pressed":
        var5 = level.player getcurrentweapon();
        var6 = getweaponbasename(var5);

        if(var6 == "iw8_pi_golf21_tfarah") {
          if(level.player getcurrentweaponclipammo() > 0) {
            self notify("barkov_is_missed");
          }
        } else if(var6 == "iw8_gunless_teen_farah") {} else {
          if(level.player getstance() == "prone") {
            var2 = var1;
          } else {
            var2 = level.barkovmaxmeleedistsq;
          }

          if(!level.player ismeleeing() && var4 < var2) {
            if(barkov_in_player_sight()) {
              self notify("barkov_is_stabbed");
            }
          }
        }

        break;
      case "ads_pressed":
        var5 = level.player getcurrentweapon();
        var6 = getweaponbasename(var5);

        if(var6 == "iw8_farahknife_sp" && !level.player ismeleeing() && var4 < level.barkovmaxmeleedistsq) {
          if(barkov_in_player_sight()) {
            self notify("barkov_is_stabbed");
          }
        }

        break;
      case "default":
        break;
    }

    waitframe();
  }
}

function custom_context_range(var0) {
  level endon("player_spotted_finale");
  var1 = squared(60);
  var2 = gettime();
  var3 = var0 * 1000;
  var4 = var2 + var3;

  while(isalive(self)) {
    if(turn_off_prompt(var1)) {
      level.meleehintshow = 0;

      if(gettime() >= var4) {
        level.player scripts\engine\sp\utility::display_hint("melee_stealth");
      }

      while(turn_off_prompt(var1)) {
        waitframe();
      }
    } else {
      level.meleehintshow = 1;

      while(!turn_off_prompt(var1)) {
        waitframe();
      }
    }

    waitframe();
  }
}

function melee_off() {
  level endon("barkov_dead");
  var0 = squared(100);

  while(isalive(self)) {
    if(melee_distance_check(var0)) {
      level.player allowmelee(0);

      while(melee_distance_check(var0)) {
        waitframe();
      }
    } else {
      level.player allowmelee(1);

      while(!melee_distance_check(var0)) {
        waitframe();
      }
    }

    waitframe();
  }
}

function turn_off_prompt(var0) {
  var1 = 1;

  if(!melee_distance_check(var0)) {
    var1 = 0;
  }

  if(!barkov_in_player_sight()) {
    var1 = 0;
  }

  return var1;
}

function melee_distance_check(var0) {
  if(distance2dsquared(level.player.origin, level.barkov.jchestorg.origin) < var0) {
    return true;
  }

  return false;
}

function barkov_in_player_sight() {
  level.player endon("death");

  if(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos60, level.barkov gettagorigin("j_chest"), [level.player, level.barkov])) {
    return true;
  }

  if(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos60, level.barkov gettagorigin("j_head"), [level.player, level.barkov])) {
    return true;
  }

  return false;
}

function barkov_damage_notifies(var0) {
  for(;;) {
    self waittill("damage", var1, var1, var1, var1, var2, var1, var1, var3, var1, var4);
    self.damagearray["type"] = var2;
    self.damagearray["part"] = var3;
    self.damagearray["location"] = "other";

    switch (var2) {
      case "MOD_MISS":
        self notify("barkov_is_missed");
        break;
      case "MOD_MELEE":
        if(isDefined(var4) && getweaponbasename(var4) == "iw8_gunless_teen_farah") {
          break;
        }

        self notify("barkov_melee_damage");
        break;
      case "MOD_RIFLE_BULLET":
        if(scripts\sp\damagefeedback::isheadshot(var3) || var3 == "j_helmet") {
          self.damagearray["location"] = "head";
        } else if(var3 == "j_chest") {
          self.damagearray["location"] = "chest";
        }

        self notify("barkov_is_shot");
        break;
    }
  }
}

function barkov_lookback_scene_start(var0) {
  level endon("player_spotted_finale");
  level.stealth_check["is_animated"] = 0;
  level.stealth_check["is_shooting"] = 0;
  level.sound_orgs[0] = spawn("script_origin", self.origin);
  level.sound_orgs[1] = spawn("script_origin", self.origin);
  level.sound_orgs[2] = spawn("script_origin", self.origin);

  foreach(var2 in level.sound_orgs) {
    var2 linkTo(self);
    var2 scalevolume(0, 0);
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
    scripts\engine\sp\utility::delaychildthread(0.1, &lookback_scene_safe);
    var0 notify("stop_finale_intro_idle");
    level.stealth_check["is_animated"] = 1;
    var0 scripts\common\anim::anim_single_solo(self, "finale_look_left");
    self.dirfacing = "side";
    change_animshot_dir("finale_shot_injure_side");
    var0 thread scripts\common\anim::anim_loop_solo(self, "finale_look_idle", "stop_finale_intro_idle");
    scripts\engine\utility::ent_flag_wait("end_barkov_lookBack");
    scripts\engine\utility::ent_flag_clear("end_barkov_lookBack");
    var0 notify("stop_finale_intro_idle");
    level.stealth_check["is_animated"] = 0;
    var0 scripts\common\anim::anim_single_solo(self, "finale_look_right");
    self.dirfacing = "back";
    change_animshot_dir("finale_shot_injure");
    var0 thread scripts\common\anim::anim_loop_solo(self, "finale_intro_idle", "stop_finale_intro_idle");
    wait 3;
  }
}

function change_animshot_dir(var0) {
  self.animeshotdir = var0;
}

function lookback_scene_safe() {
  var0 = gettime();
  var1 = var0 + 3000;

  for(;;) {
    if(gettime() <= var1) {
      if(!level.player istouching(level.finale_heli.safe_trigger) || level.player getstance() != "prone") {
        scripts\engine\sp\utility::delaychildthread(0.1, &lookback_timeout_based_on_stance);
        scripts\engine\sp\utility::delaychildthread(0.1, &lookback_start_audio_timeout);
        var2 = level scripts\engine\utility::waittill_any_return("player_is_hiding", "player_timeout");
        level notify("stop_audio_timeout");

        foreach(var4 in level.sound_orgs) {
          var4 stoploopsound();
        }

        switch (var2) {
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

function lookback_timeout_based_on_stance() {
  level endon("stop_audio_timeout");
  level endon("player_spotted_finale");
  var0 = 0;
  level.sound_orgs[0] playLoopSound("ui_stealth_threat_low_lp");
  level.sound_orgs[1] playLoopSound("ui_stealth_threat_med_lp");
  level.sound_orgs[2] playLoopSound("ui_stealth_threat_high_lp");

  foreach(var2 in level.sound_orgs) {
    var2 scalevolume(0, 0);
  }

  foreach(var2 in level.sound_orgs) {
    var2 scalevolume(1, 2.4);
  }

  while(var0 <= 2.4) {
    wait 0.1;

    if(var0 >= 1.6) {
      level.player playRumbleOnEntity("damage_heavy");
    } else if(var0 >= 0.8) {
      level.player playRumbleOnEntity("damage_light");
    } else {
      level.player playRumbleOnEntity("light_1s");
    }

    if(level.player getstance() == "prone") {
      var0 += 0.1;
      continue;
    }

    if(level.player getstance() == "crouch") {
      var0 += 0.15;
      continue;
    }

    var0 = 3.4;
  }

  level notify("player_timeout");
}

function lookback_start_audio_timeout() {
  level endon("stop_audio_timeout");
  level endon("player_spotted_finale");

  while(!level.player istouching(level.finale_heli.safe_trigger) || level.player getstance() != "prone") {
    waitframe();
  }

  level notify("player_is_hiding");
}

function heli_stop_for_context(var0) {
  self vehicle_setspeedimmediate(0);
  level waittill("resume_heli_path");
  self vehicle_setspeed(13, 4);
}

function heli_stop(var0) {
  self.oob_enabled = 0;
  scripts\common\utility::vehicle_detachfrompath();
  self vehicle_cleardrivingstate();
  self.idle_animnode2 = scripts\engine\utility::getStruct("finale_heli_idle2", "targetname");
  self.idle_animnode2.angles = self gettagangles("tag_origin");
  self.idle_animnode2 thread scripts\common\anim::anim_loop_solo(self, var0, "stop_heli_loop");
  self rotateTo((0, 0, 0), 1);
  self.started_second_position = 1;
  self.oob_enabled = 1;
}

function barkov_struggle_setup(var0) {
  level notify("stop_radio_scene");
  level.meleehintshow = 1;
  level notify("death_scene");
  thread delete_orgs();
}

function delete_orgs() {
  level scripts\engine\utility::waittill_any_timeout(1, "player_spotted_finale");

  foreach(var1 in level.sound_orgs) {
    if(isDefined(var1)) {
      var1 stoploopsound();
      var1 delete();
    }
  }
}

function barkov_shooting_path(var0) {
  self endon("barkov_charge_shot");
  var0 notify("stop_finale_intro_idle");
  level notify("player_spotted_finale");
  self.animname = "barkov";
  thread barkov_charged_player_vo();
  thread barkov_within_melee_range(var0);
  thread barkov_firing_loop(var0);
  var1 = scripts\engine\utility::waittill_any_return("barkov_is_stabbed", "barkov_is_shot", "barkov_melee_damage");
  barkov_struggle_setup(var0);
  self notify("barkov_stop_shooting");
  self notify("stop_anim_aim");
  scripts\engine\sp\utility::anim_stopanimScripted();

  switch (var1) {
    case "barkov_melee_damage":
    case "barkov_is_stabbed":
      if(level.stealth_check["is_shooting"]) {
        self setlookattext("", &"");

        if(isalive(level.player)) {
          level.player enableinvulnerability();
          thread stab_fail_extras();
          level notify("disable_light_6");
          level notify("move_window_light_fail");
          var0 scripts\sp\player_rig::link_player_to_rig("finale_stab_fail", "stand", 0, undefined, 1);
          level.player setstance("stand", 1);
          level.player_rig linkTo(var0);
          var0 thread scripts\common\anim::anim_single_solo(level.player_rig, "finale_stab_fail");
          var0 scripts\common\anim::anim_single_solo(self, "finale_stab_fail");
          var0 scripts\common\anim::anim_last_frame_solo(self, "finale_stab_fail");
        }

        level waittill("forever");
      } else if(level.player getstance() == "prone") {
        thread heli_stop_for_context(level.finale_heli);
        barkov_melee_path(var0, "_front", 1);
      } else {
        thread heli_stop_for_context(level.finale_heli);
        barkov_melee_path(var0, "_front", 0);
      }

      break;
    case "barkov_is_shot":
      if(isDefined(self.damagearray["location"]) && self.damagearray["location"] == "head") {
        self.kickoffstart = "finale_kickoff_start_alt";
        barkov_gun_path(var0, "headshot", "finale_gun_aim_death");
      } else if(isDefined(self.damagearray["location"]) && self.damagearray["location"] == "chest") {
        barkov_gun_path(var0, "chestshot", "finale_shot_injure_front");
      } else {
        barkov_gun_path(var0, "other", "finale_shot_injure_front");
      }

      break;
    default:
      break;
  }
}

function stab_fail_extras() {
  level.player lerpfovscalefactor(0, 0.25);
  level.player scripts\engine\utility::delaycall(0.6, &hideviewmodel);
  level.finale_heli scripts\common\utility::vehicle_detachfrompath();
  level.finale_heli vehicle_cleardrivingstate();
}

function barkov_within_melee_range(var0) {
  self endon("barkov_stop_shooting");
  level.player endon("death");
  var1 = squared(60);
  var2 = 0;
  var3 = undefined;

  for(;;) {
    var4 = distancesquared(level.player.origin, level.barkov.origin);

    if(!var2 && var4 < var1) {
      var2 = 1;
      var3 = gettime();
    } else if(var2 && var4 >= var1) {
      var2 = 0;
      var3 = undefined;
    }

    if(var2 && isDefined(var3)) {
      if(level.stealth_check["is_shooting"] && level.player getstance() == "prone") {
        level.player scripts\sp\utility::do_damage(level.player.health + 1000, self.origin, self, self, "MOD_PISTOL_BULLET");
      } else if(isDefined(var3)) {
        if(level.stealth_check["is_shooting"] && gettime() >= var3 + 1000) {
          level.player shellshock("captive_hit", 1);

          if(level.player.health > 12) {
            var5 = min(level.player.health - 2, 20);
            level.player scripts\sp\utility::do_damage(var5, self.origin, self, self, "MOD_MELEE");
          }

          level.player playRumbleOnEntity("heavy_1s");
          self notify("barkov_is_stabbed");
        }
      }
    }

    waitframe();
  }
}

function barkov_firing_loop(var0) {
  self endon("barkov_stop_shooting");
  scripts\engine\utility::delaythread(0.2, &barkov_is_armed);
  var0 scripts\common\anim::anim_single_solo(self, "finale_look_spotted");
  level.barkov.ignoreall = 0;
  level.barkov.ignoreme = 0;
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  self getenemyinfo(level.player);
  GscBinSkip1(0x45, "left", 35);
}

function barkov_is_armed() {
  level.stealth_check["is_shooting"] = 1;
}

function barkov_charged_player_vo() {
  self endon("barkov_stop_shooting");
  level.player endon("death");
  wait 0.15;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_alertfail_10");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_30");
  wait 2.5;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_10");
  wait 1;

  while(!self.barkovreloading) {
    wait 0.1;
  }

  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_80");
  wait 0.7;
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_hidenseek_90");
  wait 0.7;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_100");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_420");
  wait 2.5;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_50");
  wait 0.7;
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_hidenseek_60");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_370");
  wait 1;

  while(!self.barkovreloading) {
    wait 0.1;
  }

  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_130");
  wait 0.7;
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_hidenseek_140");
  wait 0.8;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_150");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_230");
  wait 2.3;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_250");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_260");
  wait 2.5;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_270");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_290");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_300");
  wait 2.5;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_330");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_340");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_440");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_350");
  wait 2.5;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_390");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_240");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_400");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_460");
  wait 3;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_470");
  wait 0.8;
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_hidenseek_180");
  wait 1;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_190");
  wait 0.7;
  level.player scripts\engine\sp\utility::smart_player_dialogue_interrupt("dx_vom_far_finale_heli_hidenseek_200");
  wait 1;
  scripts\sp\maps\lab\lab_vo_util::simple_dialogue("dx_vom_bkv_finale_heli_hidenseek_210");
}

function barkov_gun_path(var0, var1, var2) {
  if(isDefined(level.finale_heli.clip_stand)) {
    level.finale_heli.clip_stand delete();
  }

  level.barkov notify("stop_simple_dialogue");
  level.barkov stopsounds();
  level notify("player_spotted_finale");
  var0 notify("stop_finale_intro_idle");

  if(isDefined(level.finale_heli.reflectionvolume2)) {
    level.finale_heli.reflectionvolume2 hide();
  }

  if(var1 == "headshot") {
    level.barkov setlookattext("", &"");
    level.barkov.kickoffstart = "finale_kickoff_start_alt";
    var0 scripts\common\anim::anim_single_solo(self, var2);
    var0 thread scripts\common\anim::anim_loop_solo(self, "finale_death_stabbed_idle", "finale_idle");

    if(isDefined(level.barkov.propmodel)) {
      level.barkov.propmodel delete();
    }

    facial_death();
    self.iscompletelydead = 1;
    level.kickout = 0;
    scripts\engine\utility::flag_set("start_choking_scene");
    scripts\engine\utility::flag_set("ready_for_kickoff");
    wait 0.65;
    return;
  }

  thread barkov_shot_dialog(var1);
  level.barkov setlookattext("", &"");
  thread barkov_damaged_during_anim();
  var0 scripts\common\anim::anim_single_solo(self, var2);

  if(!self.shotduringanim) {
    thread barkov_crawl_anim_shot(var0);
  }

  barkov_stab_post_melee(var0, 0);
}

function barkov_damaged_during_anim() {
  level endon("start_choking_scene");
  var0 = scripts\engine\utility::waittill_any_return("barkov_is_shot");
  self.shotduringanim = 1;
}

function mus_barkov_stab() {
  setmusicstate("mx_lab_farah_stab");
}

function barkov_melee_path(var0, var1, var2) {
  if(var1 == "_front") {
    level.barkov scripts\engine\utility::delaythread(0.6, &scripts\sp\maps\lab\lab_vo_util::simple_dialogue, "dx_vom_bkv_finale_heli_kill_knife_10");
  }

  self setlookattext("", &"");
  thread barkov_melee_setup();
  setsaveddvar("OMNONNMOTP", "0.1 400 2 1000");
  level.player lerpfovscalefactor(0, 0.25);

  if(!isalive(level.player)) {
    return;
  }

  level.player enableinvulnerability();
  level notify("player_spotted_finale");

  if(isDefined(var2) && var2) {
    var0 scripts\sp\player_rig::link_player_to_rig("finale_stab_prone", "prone", 1, 0.2, 0, 0, 0, 0, 0);
    level.barkov linkTo(var0);
    level.player_rig linkTo(var0);
    level.player hideviewmodel();
    var0 scripts\common\anim::anim_single_solo(level.player_rig, "finale_stab_prone");
    level.player setstance("stand", 1, 1, 1);
    level.player_rig hide();
    scripts\sp\player_rig::unlink_player_from_rig(0, undefined, undefined, 1);
    level.player_rig dontinterpolate();
    var0 scripts\common\anim::anim_first_frame_solo(level.player_rig, "finale_stab" + var1);
    level.player dontinterpolate();
    var0 scripts\sp\player_rig::link_player_to_rig("finale_stab" + var1, "stand", 0, undefined, 0, 0, 0, 0, 0);
  } else {
    var0 scripts\sp\player_rig::link_player_to_rig("finale_stab" + var1, "stand", 1, 0.2, 0, 0, 0, 0, 0);
    level.barkov linkTo(var0);
    level.player_rig linkTo(var0);
    level.player hideviewmodel();
  }

  var0 notify("stop_finale_intro_idle");
  thread barkov_choke_takedown_anims(var0, var1);
  wait 3;
  var3 = getanimlength(scripts\engine\utility::getanim("finale_stab" + var1));
  var4 = getanimlength(scripts\engine\utility::getanim("finale_knock_down"));
  var5 = var3 + var4;
  barkov_choke_scene(var0, var5);
}

function barkov_choke_takedown_anims(var0, var1) {
  self endon("choke_takedown_interrupted");
  var0 scripts\common\anim::anim_single([self, level.player_rig], "finale_stab" + var1);
  var0 scripts\common\anim::anim_single([self, level.player_rig], "finale_knock_down");
  var0 thread scripts\common\anim::anim_loop_solo(level.player_rig, "finale_choke01_idle", "stop_choke");
  var0 thread scripts\common\anim::anim_loop_solo(self, "finale_choke01_idle", "stop_choke");
  level.player setworldupreferenceangles((0, 110, 60));
}

function barkov_choke_scene(var0, var1) {
  var0 notify("stop_anim");
  level.player_rig show();
  scripts\engine\utility::delaythread(4, &show_cursor_on_prompt_knife);
  var2 = level.prompt_knife scripts\engine\utility::waittill_notify_or_timeout_return("trigger", var1 + 5);

  if(isDefined(level.finale_heli.reflectionvolume2)) {
    level.finale_heli.reflectionvolume2 hide();
  }

  switch (var2) {
    case "timeout":
      var0 notify("stop_choke");
      level.prompt_knife scripts\sp\player\cursor_hint::remove_cursor_hint();
      scripts\engine\utility::delaythread(3, &scripts\sp\utility::missionfailedwrapper);
      var0 thread scripts\common\anim::anim_single_solo(level.player_rig, "choke_deathA");
      var0 scripts\common\anim::anim_single_solo(level.barkov, "choke_deathA");
      var0 scripts\common\anim::anim_last_frame_solo(level.barkov, "choke_deathA");
      level waittill("never");
      break;
    default:
      self notify("choke_takedown_interrupted");
      var0 notify("stop_choke");
      var0 thread scripts\common\anim::anim_single_solo(level.player_rig, "finale_grab_knife");
      var0 scripts\common\anim::anim_single_solo(level.barkov, "finale_grab_knife");
      var0 thread scripts\common\anim::anim_loop_solo(level.barkov, "finale_grab_knife_idle", "stop_grab");
      var0 thread scripts\common\anim::anim_loop_solo(level.player_rig, "finale_grab_knife_idle", "stop_grab");
      level.player showviewmodel();
      thread finale_kick_scene_setup_rig(var0);
      barkov_stab_post_melee(var0, 1);
      break;
  }
}

function show_cursor_on_prompt_knife() {
  level.prompt_knife scripts\sp\player\cursor_hint::create_cursor_hint("j_gun", (0, 0, 1), &"LAB/CURSOR_GRAB", 50, 60, 65, 1, undefined, undefined, undefined, "duration_none");
}

function barkov_melee_setup() {
  level.player allowmelee(0);
  level.player hidelegs();

  if(isDefined(level.finale_heli.clip_stand)) {
    level.finale_heli.clip_stand delete();
    return;
  }
}

function barkov_stab_post_melee(var0, var1) {
  var2 = undefined;
  scripts\engine\utility::flag_set("start_choking_scene");

  if(var1) {
    wait 0.2;
    GscBinSkip4(0x35, 5);
  }

  if(self.shotduringanim) {
    var2 = "shot_during_anim";
  } else {
    var2 = "crawl_timed_out";
  }

  level.player setworldupreferenceangles((0, 0, 0));
  level.player notify("end_timeout_thread");

  switch (var2) {
    case "melee_timed_out":
      var0 notify("stop_grab");
      var0 notify("finale_idle");
      scripts\engine\utility::delaythread(3, &scripts\sp\utility::missionfailedwrapper);
      var0 thread scripts\common\anim::anim_single_solo(level.player_rig, "choke_deathB");
      var0 scripts\common\anim::anim_single_solo(level.barkov, "choke_deathB");
      var0 scripts\common\anim::anim_last_frame_solo(level.barkov, "choke_deathB");
      level waittill("never");
      break;
    case "ads_pressed":
    case "melee_pressed":
    case "attack_pressed":
      var3 = level.player getcurrentweapon();
      var4 = getweaponbasename(var3);
      level notify("stop_choking", 1);

      if(var4 == "iw8_pi_golf21_tfarah") {
        barkov_shot_loop(var0);
        level.kickout = 0;
        scripts\engine\utility::flag_set("ready_for_kickoff");
      } else {
        barkov_stab_loop(var0, var1);
        level.kickout = 1;
        scripts\engine\utility::flag_set("ready_for_kickoff");
      }

      break;
    case "shot_during_anim":
      self.kickoffstart = "finale_kickoff_start_alt";
      barkov_shot_loop(var0);
      level.kickout = 0;
      scripts\engine\utility::flag_set("ready_for_kickoff");
      break;
    case "crawl_timed_out":
      var0 notify("stop_grab");
      var0 notify("finale_idle");
      barkov_crawl_scene(var0);
      level.kickout = 1;
      scripts\engine\utility::flag_set("ready_for_kickoff");
      break;
    default:
      barkov_stab_loop(var0, var1);
      level.kickout = 1;
      scripts\engine\utility::flag_set("ready_for_kickoff");
      break;
  }
}

function barkov_shot_loop(var0) {
  var0 notify("finale_idle");
  self notify("longdeath_ender");
  level notify("end_longdeath_lines");
  level notify("end_kick_lines");
  level notify("stop_crawling_notify");
  level.knife hide();

  if(isDefined(level.finale_heli.clip_crawl)) {
    level.finale_heli.clip_crawl delete();
  }

  var0 scripts\common\anim::anim_single_solo(self, "finale_death_shot");
  var0 thread scripts\common\anim::anim_loop_solo(self, "finale_death_stabbed_idle", "finale_idle");
  facial_death();
  self.iscompletelydead = 1;
}

function barkov_stab_loop(var0, var1) {
  scripts\engine\utility::flag_set("next_dialog_line");

  if(!isDefined(level.player_rig)) {
    var0 scripts\sp\player_rig::link_player_to_rig("finale_stab02", "crouch", 0, undefined, 0, 50, 50, 50, 50, 1);
    level.player_rig linkTo(var0);
    level.barkov linkTo(var0);
  }

  var0 notify("stop_grab");
  var0 notify("finale_idle");

  if(var1) {
    level.finale_heli.bloodsplat[0] show();
    thread barkov_crawl_anim(var0);
    var0 scripts\common\anim::anim_single_solo(level.player_rig, "finale_stab02");
  }

  thread scripts\engine\sp\utility::dof_disable_autofocus();
  setsaveddvar("OMNONNMOTP", level.og_zplanes);
  level.knife hide();
  barkov_crawl_scene(var0);
}

function barkov_crawl_anim(var0) {
  level endon("stop_crawling_notify");
  var0 scripts\common\anim::anim_single_solo(self, "finale_stab02");
  var0 scripts\common\anim::anim_single_solo(self, "finale_stab02b");
  var0 scripts\common\anim::anim_last_frame_solo(self, "finale_stab02b");
  self notify("barkov_crawl_finished");
}

function barkov_crawl_anim_shot(var0) {
  level endon("stop_crawling_notify");
  var0 scripts\common\anim::anim_single_solo(self, "finale_stab02b");
  var0 scripts\common\anim::anim_last_frame_solo(self, "finale_stab02b");
  self notify("barkov_crawl_finished");
}

function barkov_crawl_scene(var0) {
  level notify("stop_choking", 1);
  scripts\engine\utility::delaythread(0.2, &scripts\engine\sp\utility::autosave_now);
  level endon("stop_crawl_scene");
  thread custom_context_range(3.5);
  level.barkovmaxmeleedistsq = squared(80);

  if(isDefined(level.player_rig)) {
    scripts\sp\player_rig::unlink_player_from_rig();
  }

  level.player allowmelee(0);
  var1 = scripts\engine\utility::spawn_script_origin(self gettagorigin("j_chest"), self gettagangles("j_chest"));
  var1 linkTo(self, "j_chest");
  var2 = scripts\engine\utility::waittill_any_return("barkov_is_stabbed", "barkov_is_shot", "barkov_crawl_finished");
  level notify("player_spotted_finale");
  level.meleehintshow = 1;

  if(isDefined(level.finale_heli.clip_crawl)) {
    level.finale_heli.clip_crawl delete();
  }

  switch (var2) {
    case "barkov_crawl_finished":
      if(isalive(level.player)) {
        scripts\sp\utility::missionfailedwrapper();
      }

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
        var0 scripts\common\anim::anim_first_frame_solo(level.player_rig, "finale_choke_stab01");
      }

      level.player giveweapon("iw8_gunless_teen_farah");
      level.player switchtoweapon("iw8_gunless_teen_farah");
      level.player takeweapon("iw8_farahknife_sp");
      level.player_rig linkTo(var0);

      if(level.player getstance() == "prone") {
        var0 scripts\sp\player_rig::link_player_to_rig("finale_choke_stab01", "crouch", 1, 0.2, 1);
        level.player hideviewmodel();
        level.player_rig hide();
        level.player_rig scripts\engine\utility::delaycall(0.4, &show);
      } else {
        var0 scripts\sp\player_rig::link_player_to_rig("finale_choke_stab01", "crouch", 1, 0.2, 1);
      }

      var0 notify("stop_crawl");
      scripts\engine\sp\utility::anim_stopanimScripted();
      var0 notify("stop_choke");
      level notify("stop_choking", 1);
      var0 thread scripts\common\anim::anim_single_solo(self, "finale_choke_stab01");
      var0 scripts\common\anim::anim_single_solo(level.player_rig, "finale_choke_stab01");
      var0 thread scripts\common\anim::anim_loop_solo(level.player_rig, "finale_choke_stab01_idle", "stop_choke");
      var0 thread scripts\common\anim::anim_loop_solo(self, "finale_choke_stab01_idle", "stop_choke");
      level.player showviewmodel();
      finale_stab(var0, "finale_choke_stab02");
      finale_stab(var0, "finale_choke_stab03");
      finale_stab(var0, "finale_choke_stab04");
      setsaveddvar("OMNONNMOTP", level.og_zplanes);
      scripts\sp\player_rig::unlink_player_from_rig(undefined, undefined, undefined, 1);
      thread player_rig_end_scene_setup(var0);
      scripts\engine\utility::flag_set("beg_lines");
      thread long_death_barkov(1);
      break;
    case "barkov_is_shot":
      level.player notify("end_timeout_thread");
      level notify("stop_crawl_anims");
      level notify("stop_crawling_notify");
      scripts\engine\sp\utility::anim_stopanimScripted();
      var0 notify("stop_crawl");
      var0 notify("stop_choke");
      level notify("stop_choking", 1);
      scripts\engine\utility::flag_set("beg_lines");
      self.kickoffstart = "finale_kickoff_start_alt";
      var0 scripts\common\anim::anim_single_solo(self, "finale_death_shot");
      thread long_death_barkov(0);
      break;
    default:
      scripts\sp\utility::missionfailedwrapper();
      level waittill("never");
      break;
  }
}

function player_rig_end_scene_setup(var0) {
  level.player_rig hide();
  level.player_rig linkTo(var0);
  var0 scripts\common\anim::anim_first_frame_solo(level.alt_rig, "finale_kickoff_sh02");
}

function dialogue_wheel_start() {
  level endon("barkov_dead");
  setomnvar("ui_dialogue_prompts_choice", 0);
  setomnvar("ui_dialogue_prompts_option_a", "lab/barkov_option_1");
  setomnvar("ui_dialogue_prompts_option_b", "lab/barkov_option_2");
  setomnvar("ui_dialogue_prompts_option_c", "lab/barkov_option_3");
  setomnvar("ui_dialogue_prompts_option_d", "lab/barkov_option_4");
  setomnvar("ui_dialogue_prompts_duration", 0);
  setomnvar("ui_dialogue_prompts_active", 1);
  level.attackpressed = undefined;
  var0 = 1;
  var1 = squared(100);
  var2 = cos(25);
  self.chestorigin = scripts\engine\utility::spawn_script_origin(self gettagorigin("j_spineupper"));
  self.chestorigin linkTo(self, "j_spineupper", (0, 0, 0), (0, 0, 0));
  var3 = getEntArray("barkov_look_structs", "targetname");
  GscBinSkip4(0x35);
}

function player_is_pressing_attack() {
  for(;;) {
    level.attackpressed = undefined;
    level.player waittill("attack_pressed");
    level.attackpressed = 1;
    wait 0.1;
  }
}

function dialogue_wheel_check(var0, var1, var2, var3) {
  var4 = 1;

  if(var0 > var1) {
    var4 = 0;
  }

  if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.chestorigin.origin, var2)) {
    var4 = 0;
  }

  if(level.player getstance() == "prone") {
    var4 = 0;
  }

  return var4;
}

function dialogue_wheel_player_state(var0) {
  level.player allowmelee(var0);
  level.player allowfire(var0);
  level.player allowjump(var0);
  level.player allowreload(var0);
  level.player allowprone(var0);
  level.player allowcrouch(var0);
}

function mus_farah_final_speech() {
  level.player setsoundsubmix("sp_lab_ending_duck_1", 3);
  setmusicstate("");
}

function mus_cockpit_finale() {
  setmusicstate("mx_lab_helo_finale");
}

function heli_final_path() {
  level endon("skip_end_scene");
  level waittill("finale_heli_move_to_kickoff");

  if(!scripts\engine\utility::flag("start_choking_scene")) {
    scripts\engine\utility::flag_set("start_choking_scene");
  }

  var0 = scripts\engine\utility::getStruct("ending_path_start", "targetname");
  level.finale_heli dontinterpolate();
  level.player dontinterpolate();
  level.alt_rig dontinterpolate();
  level.barkov dontinterpolate();

  if(isDefined(level.finale_heli.started_second_position) && !level.finale_heli.started_second_position) {
    heli_stop(level.finale_heli, "finale_idle");
  } else {
    level.finale_heli.idle_animnode2 notify("stop_heli_loop");
    level.finale_heli.idle_animnode2 thread scripts\common\anim::anim_loop_solo(level.finale_heli, "finale_idle", "stop_heli_loop");
  }

  wait 0.2;
  level.finale_heli.idle_animnode2 notify("stop_heli_loop");
  var1 = scripts\engine\utility::getStruct("ending_path_start2", "targetname");
  level.finale_heli cleartargetyaw();
  level.finale_heli vehicle_setspeed(7, 2);
  level.finale_heli setneargoalnotifydist(300);
  level.finale_heli setmaxpitchroll(5, 5);
  level.finale_heli vehicle_helisetai(var1.origin, 7, 2, 0, undefined, var1.angles, var1.angles[1], 0, 0, 0, 0, 0, 0);
  level.finale_heli waittill("near_goal");

  if(!scripts\engine\utility::flag("set_fire")) {
    scripts\engine\utility::flag_set("set_fire");
  }

  level.finale_heli vehicle_setspeed(0, 1, 2);
}

function finale_shot_cleanup() {
  level.finale_heli delete();
  var0 = [level.farah, level.finale_heli.pilot];

  foreach(var2 in var0) {
    var2 linkTo(level.finale_heli_intro, "tag_origin", (0, 0, 0), (0, 0, 0));
    level.finale_heli_intro thread scripts\common\anim::anim_loop_solo(var2, "final_shot");
  }
}

function halt_heli_end_movement(var0) {
  level.finale_heli vehicle_setspeed(0);
  level.finale_heli sethoverparams(0, 0, 0);
  scripts\engine\utility::array_call(level.finale_heli.nets, &hide);
  wait var0;
  wait 0.7;
  level.finale_heli vehicle_setspeed(10);
  level.finale_heli sethoverparams(100, 10, 10);
}

function ending_cleanup() {
  if(isDefined(level.knife)) {
    level.knife delete();
  }

  if(isDefined(level.prompt_knife)) {
    level.prompt_knife delete();
    return;
  }
}

function barkov_shot_dialog(var0) {
  level endon("end_longdeath_lines");
  barkov_shot_dialog_internal(var0);
}

function barkov_shot_dialog_internal(var0) {
  level endon("crawl_stab");

  if(var0 == "chestshot") {
    level.barkov thread scripts\sp\maps\lab\lab_vo_util::say("dx_vom_bkv_finale_heli_shot_10", 1);
  } else {
    level.barkov thread scripts\sp\maps\lab\lab_vo_util::say("dx_vom_bkv_finale_heli_shot_20", 1);
  }

  wait 2;
}

function barkov_pain() {
  if(!isDefined(level.barcov_pain)) {
    var0 = ["dx_vom_bkv_finale_heli_shot_10", "dx_vom_bkv_finale_heli_shot_20", "dx_vom_bkv_finale_heli_kill_knife_40"];
    level.barkov_pain = scripts\engine\sp\utility::create_deck(var0);
  }

  level.barkov scripts\sp\maps\lab\lab_vo_util::say(level.barkov_pain scripts\engine\sp\utility::deck_draw(), 1);
}

function barkov_kick_dialog() {
  level endon("end_kick_lines");
  scripts\engine\utility::flag_wait("kick_lines");
  level.barkov scripts\sp\maps\lab\lab_vo_util::say("dx_vom_bkv_finale_heli_kill_knife_90", 1);
}

function long_death_barkov(var0) {
  self endon("longdeath_ender");

  if(istrue(var0)) {
    thread stop_final_speech();
    self waittillmatch("single anim", "end");
    self notify("barkov_speech_is_over");
  }

  level.finale_heli thread scripts\common\anim::anim_loop_solo(level.barkov, "finale_death_stabbed_idle", "finale_idle");
  facial_death();
  self.iscompletelydead = 1;
}

function stop_final_speech() {
  self endon("barkov_speech_is_over");
  var0 = scripts\engine\utility::waittill_any_return("barkov_is_stabbed", "barkov_is_shot", "barkov_melee_damage");
}

function finale_stab(var0, var1) {
  level notify("finale_stab");
  level notify("start_choking", 6);

  if(timed_melee_check(7, 60)) {
    var0 notify("stop_choke");
    level notify("stop_choking", 1);
    level.barkov notify("next_finale_stab");

    if(var1 == "finale_choke_stab04") {
      facial_clear();
      thread show_finale_bloodsplat();
    }

    var0 thread scripts\common\anim::anim_single_solo(level.barkov, var1);
    var0 scripts\common\anim::anim_single_solo(level.player_rig, var1);

    if(var1 != "finale_choke_stab04") {
      var0 thread scripts\common\anim::anim_loop_solo(level.player_rig, var1 + "_idle", "stop_choke");
      var0 thread scripts\common\anim::anim_loop_solo(level.barkov, var1 + "_idle", "stop_choke");
      return;
    }

    return;
  }

  scripts\sp\utility::missionfailedwrapper();
  level waittill("never");
}

function show_finale_bloodsplat() {
  wait 0.3;
  level.finale_heli.bloodsplat[1] show();
}

function choke_screen_effects() {
  jumpiftrue(isDefined(level.player.breathoverlay)) LOC_00000015;
  setup_breath_overlay();

  for(;;) {
    level waittill("start_choking", var0);

    if(!isDefined(level.player.breathoverlay)) {
      setup_breath_overlay();
    }

    level.player.breathoverlay fadeovertime(var0);
    level.player.breathoverlay.alpha = 1;
    visionsetnaked("lab_near_death", var0 - 1);
    level waittill("stop_choking");
    level.player.breathoverlay fadeovertime(1);
    level.player.breathoverlay.alpha = 0;
    visionsetnaked("lab_ending_sss", 1);
  }
}

function setup_breath_overlay() {
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

function barkov_watcher_attack() {
  level endon("barkov_dead");

  for(;;) {
    var0 = level.player scripts\engine\utility::waittill_any_return("melee_pressed", "attack_pressed", "ads_pressed");

    if(var0 == "attack_pressed") {
      var1 = level.player getcurrentweapon();
      var2 = getweaponbasename(var1);

      if(var2 == "iw8_pi_golf21_tfarah") {
        self.weaponused = "gun";
      } else {
        self.weaponused = "melee";
      }

      continue;
    }

    self.weaponused = "melee";
  }
}

function timed_melee_check(var0, var1) {
  var2 = 0;
  var3 = gettime() + var0 * 1000;
  GscBinSkip4(0x35, var0);
}

function timeout_notify_melee_thread(var0) {
  level.player endon("end_timeout_thread");
  level.player scripts\engine\sp\utility::notify_delay("melee_timed_out", var0);
}

function spawn_pilot_nikolai(var0) {
  var1 = getEnt("finale_heli_pilot", "script_noteworthy");
  var1 scripts\sp\utility::context_melee_enable(0);
  var1 scripts\engine\sp\utility::battlechatter_off();
  var1 scripts\engine\utility::disable_pain();
  var1 scripts\engine\sp\utility::name_hide();
  var1 scripts\engine\sp\utility::disable_bulletwhizbyreaction();
  var1 scripts\engine\sp\utility::disable_danger_react();
  var1 scripts\engine\sp\utility::disable_surprise();
  var1 scripts\engine\sp\utility::disable_damagefeedback();
  var1 scripts\engine\sp\utility::name_hide();
  var1 linkTo(var0);
  var1 hide();
  var1 visiblenotsolid();
  var1 setModel("body_hero_nikolai_lab");
  var1 detach(var1.headmodel);
  var1.headmodel = "head_hero_nikolai_no_hair";
  var1 attach(var1.headmodel);

  if(isDefined(var1.hatmodel)) {
    var1 detach(var1.hatmodel);
  }

  var1.hatmodel = "hat_hero_nikolai_headset";
  var1 attach(var1.hatmodel);
  return var1;
}

function spawn_heli_farah() {
  scripts\sp\maps\lab\lab_util::spawn_farah();
  level.farah hide();
  level.farah.ignoreall = 1;
  level.farah.ignoreme = 1;
  level.farah.animname = "farah";
  level.farah scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe();
  level.farah scripts\common\ai::gun_remove();

  if(!isDefined(level.knife)) {
    level.knife = spawn("script_model", level.farah gettagorigin("tag_accessory_right"));
    level.knife setModel("weapon_wm_me_tactical_knife_v2");
    level.knife linkTo(level.farah, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
    return;
  }
}

function fadeoutscreen(var0) {
  var1 = scripts\sp\hud_util::create_client_overlay("black", 0);
  setomnvar("ui_hide_hud", 1);
  var1 fadeovertime(var0);
  var1.alpha = 1;
  return var1;
}

function fadeinscreen(var0) {
  self fadeovertime(var0);
  self.alpha = 0;
  setomnvar("ui_hide_hud", 0);
  scripts\engine\utility::delaycall(var0, &destroy);
}

function anim_aim_and_reload(var0, var1, var2) {
  self.og_leftaimlimit = self.leftaimlimit;
  self.og_rightaimlimit = self.rightaimlimit;
  self.og_upaimlimit = self.upaimlimit;
  self.og_downaimlimit = self.downaimlimit;

  if(isDefined(var2)) {
    self.leftaimlimit = var2["left"];
    self.rightaimlimit = var2["right"];
    self.upaimlimit = var2["up"];
    self.downaimlimit = var2["down"];
  } else {
    self.leftaimlimit = 50;
    self.rightaimlimit = -50;
    self.upaimlimit = -20;
    self.downaimlimit = 20;
  }

  self.aim_animprefix = var0;
  self.aim_animnode = var1;
  scripts\asm\asm_sp::asm_animcustom(&anim_aim_internal, &anim_aim_end);
}

function anim_aim_internal() {
  self endon("death");
  self endon("stop_anim_aim");
  var0 = undefined;

  if(isDefined(self.aim_animnode)) {
    var0 = self.aim_animnode;
  }

  var1 = self.aim_animprefix;
  GscBinSkip4(0x35, var1);
}

function anim_aim_end() {
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

function anim_aim_shoot(var0) {
  waittillframeend();
  level.bulletcount = 0;
  var1 = scripts\engine\utility::getanim("finale_gun_aim_reload");
  var2 = isDefined(level.scr_anim[self.animname]["finale_gun_fire"]);
  var3 = undefined;
  jumpiffalse(var2) LOC_00000050;
  var3 = level.scr_anim[self.animname]["finale_gun_fire"];
  self setanimknoblimitedrestart(var3, 1, 0.2);

  for(;;) {
    waitframe();

    if(!isDefined(self.enemy)) {
      continue;
    }

    scripts\asm\asm_bb::bb_updateshootparams(self.enemy getshootatpos(), self.enemy, 1);
    var4 = self._blackboard.shootparams_shotsperburst;
    var5 = var4 == 1 || self._blackboard.shootparams_style == "semi";

    if(scripts\aitypes\combat::isaimedataimtarget()) {
      if(!isDefined(self.asm.shootparams)) {
        scripts\asm\shoot\script_funcs::shoot_updateparams();
      }

      var4 = self._blackboard.shootparams_shotsperburst;
      var5 = var4 == 1 || self._blackboard.shootparams_style == "semi";

      while(level.bulletcount < 6) {
        wait randomfloat(0.2);

        if(level.bulletcount == 0) {
          level.stealth_check["is_shooting"] = 1;
        }

        level.bulletcount++;
        scripts\asm\shoot\script_funcs::shootatshootentorpos(var5);

        if(level.bulletcount == 6) {
          level.stealth_check["is_shooting"] = 0;
        }

        if(var2) {
          self setanim(var3, 1);
        }

        wait 0.5;

        if(var2) {
          self clearanim(var3, 0.1);
        }
      }

      self.barkovreloading = 1;
      self setflaggedanimknoballrestart("reload_anim", var1, %root, 1);
      self waittillmatch("reload_anim", "end");
      level.bulletcount = 0;
      wait 0.4;
      self.barkovreloading = 0;
    }
  }
}

#using_animtree("");

function facial_death() {
  self clearanim(%head, 0.1);
  self setfacialindex("death");
}

function facial_clear() {
  self clearanim(%scripted_talking, 0.1);
}