/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\mp_br_ex_victory_screen.gsc
*************************************************************/

function victoryscreenexfil_should_enable() {
  return level.script == "mp_wz_island";
}

function victoryscreenexfil_init() {
  level.brendingoverrideinfo = spawnStruct();
  level.brendingoverrideinfo.preloadending = 1;
  level.brendingoverrideinfo.endingstructsoverridefunc = &victoryscreenexfil_override_ending_structs;
  level.brendingoverrideinfo.endingviewingplayersetup = &victoryscreenexfil_ending_viewing_player_setup;
  level.brendingoverrideinfo.overridewinnersfunc = &victoryscreenexfil_get_winners;
  level.brendingoverrideinfo.exfiltypename = "victory_screen";
  level.brendingoverrideinfo.endingpackoverridefunc = &victoryscreenexfil_ending_pack_override;
  level.brendingoverrideinfo.playeranims = create_player_anims_array();
}

function victoryscreenexfil_override_ending_structs(var_0) {
  if(level.script == "mp_wz_island") {
    var_1 = [];
    var_2 = (21605, -50768, 440);
    var_3 = scripts\engine\utility::drop_to_ground(var_2, 1000, -1000, (0, 0, 1));
    var_1 = scripts\mp\gametypes\br_ending::init_level_drop_structs(var_3, (0, 300, 0));
    return var_1;
  }

  return var_3;
}

#using_animtree("");

function victoryscreenexfil_ending_pack_override(var_0) {
  if(!getdvarint("scr_br_ending_placement")) {
    self.ref_13CE3 = get_victoryscreenexfil_transient();
    unloadinfiltransient(self.ref_13CE3);
    setomnvarforallclients("ui_br_end_game_splash_type", 18);
    var_1 = getdvarfloat("scr_br_end_transient_wait", 6);
    wait var_1;
  }

  if(self.winners.size == 0) {
    scripts\mp\gametypes\br_ending::init_death_animations(self);
  }

  self.ref_121B8 = [];
  var_2 = 0;
  var_3 = "scene";
  self.ref_121B8[var_2] = scripts\mp\gametypes\br_ending::init_bomb_objective(var_3 + var_2);

  for(var_4 = 0; var_4 < self.winners.size; var_4++) {
    var_5 = self.winners[var_4];
    var_6 = level.brendingoverrideinfo.playeranims[var_4].playeranim;
    var_7 = var_6;
    var_8 = undefined;
    self.ref_121B8[var_2] scripts\mp\gametypes\br_ending::back_vector(var_5, var_6, var_7, var_8);
  }

  var_9 = scripts\mp\gametypes\br_ending::ref_135CA("veh8_mil_air_mindia8");
  self.ref_121B8[var_2] scripts\mp\gametypes\br_ending::back_struct(var_9, %wz_victoryscreen_helicopter);
  var_10 = scripts\mp\gametypes\br_ending::ref_135CA("veh_s4_mil_ratrace_suv_wz");
  self.ref_121B8[var_2] scripts\mp\gametypes\br_ending::back_struct(var_10, $wz_victoryscreen_suv);
  self.ref_121B8[var_2] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_victoryscreen_sh001_cam);
  var_2++;

  for(var_4 = 0; var_4 < self.winners.size; var_4++) {
    self.ref_121B8[var_2] = scripts\mp\gametypes\br_ending::init_bomb_objective(var_3 + var_2);
    self.ref_121B8[var_2] scripts\mp\gametypes\br_ending::backendevent(var_4, &victoryscreenexfil_player_highlight_camera_start);
    self.ref_121B8[var_2] scripts\mp\gametypes\br_ending::awardstadiumblueprint(level.brendingoverrideinfo.playeranims[var_4].cameraanim);
    var_2++;
  }

  self.ref_121B8[var_2] = scripts\mp\gametypes\br_ending::init_bomb_objective(var_3 + var_2);
  self.ref_121B8[var_2] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%wz_victoryscreen_sh012_cam);
  thread watch_ending_all_scenes_end();
}

function watch_ending_all_scenes_end() {
  self waittill("all_scenes_end");
  var_0 = 0.2;

  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\gametypes\br_ending::nag_get_in_heli(var_0);
  }
}

function create_player_anims_array() {
  var_0 = [];
  var_1 = spawnStruct();
  var_1.playeranim = % wz_victoryscreen_idle_npc04;
  var_1.cameraanim = % wz_victoryscreen_sh004_cam;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.playeranim = % wz_victoryscreen_idle_npc02;
  var_1.cameraanim = % wz_victoryscreen_sh002_cam;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.playeranim = % wz_victoryscreen_idle_npc06;
  var_1.cameraanim = % wz_victoryscreen_sh006_cam;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.playeranim = % wz_victoryscreen_idle_npc05;
  var_1.cameraanim = % wz_victoryscreen_sh005_cam;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.playeranim = % wz_victoryscreen_idle_npc01;
  var_1.cameraanim = % wz_victoryscreen_sh011_cam;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.playeranim = % wz_victoryscreen_idle_npc03;
  var_1.cameraanim = % wz_victoryscreen_sh003_cam;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.playeranim = % wz_victoryscreen_idle_npc07;
  var_1.cameraanim = % wz_victoryscreen_sh007_cam;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.playeranim = % wz_victoryscreen_idle_npc08;
  var_1.cameraanim = % wz_victoryscreen_sh008_cam;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.playeranim = % wz_victoryscreen_idle_npc10;
  var_1.cameraanim = % wz_victoryscreen_sh009_cam;
  var_0 = var_1;
  var_1 = spawnStruct();
  var_1.playeranim = % wz_victoryscreen_idle_npc09;
  var_1.cameraanim = % wz_victoryscreen_sh010_cam;
  var_0 = var_1;
  return var_0;
}

function get_victoryscreenexfil_transient() {
  return "mp_infil_wz_island_ending_victory_screen_tr";
}

function enable_player_hightlight(var_0) {
  if(var_0 == 0) {
    setomnvarforallclients("ui_br_end_game_splash_type", 13);
    return;
  }

  if(var_0 == 1) {
    setomnvarforallclients("ui_br_end_game_splash_type", 14);
    return;
  }

  if(var_0 == 2) {
    setomnvarforallclients("ui_br_end_game_splash_type", 15);
    return;
  }

  if(var_0 == 3) {
    setomnvarforallclients("ui_br_end_game_splash_type", 16);
    return;
  }
}

function victoryscreenexfil_player_highlight_camera_start(var_0) {
  enable_player_hightlight(var_0);
}

function victoryscreenexfil_ending_viewing_player_setup() {
  self endon("disconnect");
  var_0 = 0.5;
  var_1 = 1;
  self setclientomnvar("ui_world_fade", 1);
  self playerhide(1);
  wait var_0;
  scripts\mp\gametypes\br_ending::musictriggerthink(var_1);
}

function victoryscreenexfil_get_winners(var_0) {
  var_1 = min(level.brendingoverrideinfo.playeranims.size, var_0.size);
  return scripts\engine\utility::array_slice(var_0, 0, var_1);
}