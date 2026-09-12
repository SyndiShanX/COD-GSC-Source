/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\mp_br_ex_olaride.gsc
******************************************************/

function get_olarideexfil_transient() {
  switch (level.script) {
    case "mp_br_mechanics":
      return "mp_infil_wz_island_ending_olaride_tr";
    case "mp_wz_island":
      return "mp_infil_wz_island_ending_olaride_tr";
  }

  return undefined;
}

function olarideexfil_loadtransient() {
  if(!getdvarint("scr_br_ending_placement")) {
    self.ref_13CE3 = get_olarideexfil_transient();
    unloadinfiltransient(self.ref_13CE3);
    setomnvarforallclients("ui_br_end_game_splash_type", 18);
    var_0 = getdvarfloat("scr_br_end_transient_wait", level.brendingoverrideinfo.preloadwaittime);
    thread olarideexfil_fadetoblack(var_0 - 1, 0.9, 1.5, 0.75, 1);
    wait var_0;
    return;
  }
}

function olarideexfil_set_brcircle(var_0, var_1) {
  if(!isDefined(level.br_circle)) {
    return;
  }

  if(!isDefined(level.br_circle.dangercircleent)) {
    return;
  }

  waitframe();
  var_2 = (self.origin + self.gameending.origin) / 2;
  var_3 = distance2d(var_2, self.gameending.origin) + var_0;
  level.br_circle.dangercircleent brcirclemoveTo(var_2[0], var_2[1], var_3, var_1);
}

function olarideexfil_music_sfx_start() {
  level endon("game_ended");

  if(self.winners.size == 0) {
    return;
  }

  var_0 = level.brendingoverrideinfo.exfiltypename);
var_1 = "mus_br3_olaride_exfill_heroes_3_players_intro";
var_2 = "br_exfil_olaride_heroes_part1_3person_lr";
var_3 = "br_exfil_olaride_heroes_part2_lr";

if(var_0 == "heroes") {
  var_3 = "br_exfil_olaride_heroes_part2_lr";

  switch (self.winners.size) {
    case 1:
      var_1 = "mus_br3_olaride_exfill_heroes_1_player_intro";
      var_2 = "br_exfil_olaride_heroes_part1_1person_lr";
      break;
    case 2:
      var_1 = "mus_br3_olaride_exfill_heroes_2_players_intro";
      var_2 = "br_exfil_olaride_heroes_part1_2person_lr";
      break;
    case 3:
      var_1 = "mus_br3_olaride_exfill_heroes_3_players_intro";
      var_2 = "br_exfil_olaride_heroes_part1_3person_lr";
      break;
    case 4:
      var_1 = "mus_br3_olaride_exfill_heroes_4_players_intro";
      var_2 = "br_exfil_olaride_heroes_part1_4person_lr";
      break;
  }
} else if(var_0 == "villains") {
  var_3 = "br_exfil_olaride_villains_part2_lr";

  switch (self.winners.size) {
    case 1:
      var_1 = "mus_br3_olaride_exfill_villains_1_player_intro";
      var_2 = "br_exfil_olaride_villains_part1_1person_lr";
      break;
    case 2:
      var_1 = "mus_br3_olaride_exfill_villains_2_players_intro";
      var_2 = "br_exfil_olaride_villains_part1_2person_lr";
      break;
    case 3:
      var_1 = "mus_br3_olaride_exfill_villains_3_players_intro";
      var_2 = "br_exfil_olaride_villains_part1_3person_lr";
      break;
    case 4:
      var_1 = "mus_br3_olaride_exfill_villains_4_players_intro";
      var_2 = "br_exfil_olaride_villains_part1_4person_lr";
      break;
  }
}

foreach(var_5 in level.players) {
  if(!isDefined(var_5)) {
    continue;
  }

  var_5 playlocalsound(var_2);
  var_5 playlocalsound(var_1);
}

waitframe();
setmusicstate("");

foreach(var_5 in level.players) {
  if(!isDefined(var_5)) {
    continue;
  }

  var_5 setsoundsubmix("mp_br_exfil_fade_olaride", 4);
}

level waittill("shot_080_started");

foreach(var_5 in level.players) {
  if(!isDefined(var_5)) {
    continue;
  }

  var_5 playlocalsound(var_3);
}
}

function olarideexfil_setupchopper() {
  var_0 = scripts\mp\gametypes\br_ending::ref_135CA("veh8_mil_air_blima_scriptmodel");
  var_0 unmarkkeyframedmover(1);
  self.onkillingblow = var_0;
}

function olarideexfil_choppershowrotors(var_0) {
  var_1 = level.defendkill.onkillingblow;

  if(isDefined(var_1)) {
    if(istrue(var_0)) {
      var_1 showpart("tag_main_rotor_blade_01");
      var_1 showpart("tag_main_rotor_blade_02");
      var_1 showpart("tag_main_rotor_blade_03");
      var_1 showpart("tag_main_rotor_blade_04");
      var_1 showpart("tag_tail_rotor_blade_01");
      var_1 showpart("tag_tail_rotor_blade_02");
      var_1 showpart("tag_tail_rotor_blade_03");
      var_1 showpart("tag_tail_rotor_blade_04");
      return;
    }

    var_1 hidepart("tag_main_rotor_blade_01");
    var_1 hidepart("tag_main_rotor_blade_02");
    var_1 hidepart("tag_main_rotor_blade_03");
    var_1 hidepart("tag_main_rotor_blade_04");
    var_1 hidepart("tag_tail_rotor_blade_01");
    var_1 hidepart("tag_tail_rotor_blade_02");
    var_1 hidepart("tag_tail_rotor_blade_03");
    var_1 hidepart("tag_tail_rotor_blade_04");
    return;
  }
}

function olarideexfil_updatewinners() {
  self.winners = scripts\engine\utility::array_removeundefined(self.winners);

  if(self.winners.size == 0) {
    scripts\mp\gametypes\br_ending::init_death_animations(self);
    return;
  }
}

function olarideexfil_fx_init() {
  var_0 = level.brendingoverrideinfo.exfiltypename);
level._effect["player_disconnect"] = loadfx("vfx/iw8_br/gameplay/vfx_br_disconnect_player.vfx");
level._effect["olarideExfil_rotorwash"] = loadfx("vfx/iw8_br/island/cin/exfil_s5/vfx_br3_exfil_blima_rotor.vfx");

if(var_0 == "heroes") {
  level._effect["olarideHeroesExfil_contrail"] = loadfx("vfx/iw8_br/island/cin/exfil_s5/vfx_br3_exfil_contrail.vfx");
  level._effect["olarideHeroesExfil_trail"] = loadfx("vfx/iw8_br/island/cin/exfil_s5/vfx_br3_exfil_wing_trail.vfx");
  return;
}

if(var_0 == "villains") {
  level._effect["olarideVillainsExfil_bomb"] = loadfx("vfx/iw8_br/island/cin/exfil_s5/vfx_br3_exfil_bomb_sml_runner.vfx");
  level._effect["vfx_tracer_front_straight"] = loadfx("vfx/iw8_br/island/cin/exfil_s5/vfx_br3_exfil_tracer_front_straight");
  return;
}
}

function olarideexfil_setwind(var_0) {
  foreach(var_2 in self.winners) {
    if(isDefined(var_2)) {
      var_2 scripts\mp\utility\player::ref_1328C(var_0, 1);
    }
  }
}

function olaridechopper_playFX() {
  self endon("death");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("olarideExfil_rotorwash"), self, "tag_origin");
}

function olarideexfil_deleteloot(var_0) {
  var_1 = 50000;
  var_2 = canceljoins(undefined, undefined, var_0, var_1);

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
      if(!scripts\mp\gametypes\br_pickups::update_gamebattles_char_loc(var_4, 1)) {
        continue;
      }

      if(var_4 getscriptableisreserved() && !isDefined(var_4.embassy_main)) {
        continue;
      }

      var_5 = undefined;

      if(scripts\mp\gametypes\br_pickups::islootcache(var_4)) {
        var_5 = "body";
      }

      scripts\mp\gametypes\br_pickups::ref_11A21(var_4, var_5);
    }
  }

  if(isDefined(level.delete_pipe_ents.scriptables)) {
    foreach(var_8 in level.delete_pipe_ents.scriptables) {
      if(isDefined(var_8)) {
        var_8 delete();
      }
    }

    return;
  }
}

function olarideexfil_setuphudelement(var_0) {
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("black", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.sort = -1;
  var_0.color = (0.15, 0.15, 0.15);
  var_0.alpha = 0;
  var_0 sendcollectedclientanticheatdata(1);
}

function olarideexfil_fadetoblack(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0)) {
    wait var_0;
  }

  if(isDefined(level.olarideexfilcoveroverlay)) {
    return;
  }

  level.olarideexfilcoveroverlay = newhudelem();
  olarideexfil_setuphudelement(level.olarideexfilcoveroverlay);

  if(isDefined(var_1)) {
    level.olarideexfilcoveroverlay fadeovertime(var_1);
    level.olarideexfilcoveroverlay.alpha = 1;
    wait var_1;
  }

  if(isDefined(var_2)) {
    wait var_2;
  }

  if(isDefined(var_3)) {
    level.olarideexfilcoveroverlay fadeovertime(var_3);
    level.olarideexfilcoveroverlay.alpha = 0;
    wait var_3;
  }

  if(istrue(var_4)) {
    level.olarideexfilcoveroverlay destroy();
    return;
  }
}

function olarideexfil_preloadlocation(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2 calloutmarkerping_getinventoryslot(0);
      var_2 scripts\mp\gametypes\br_public::ref_126B9(var_0);
    }
  }
}

function olarideexfil_teleportplayers(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_3 setOrigin(var_0);
      var_3 setplayerangles(var_1);
    }
  }
}

function olarideexfil_playerremovecinematicblacklayerifneeded() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1) && var_1 scripts\mp\gametypes\br_gulag::ref_125EA()) {
      var_1 thread scripts\mp\gametypes\br_gulag::ref_12523();
    }
  }
}

function heroesexfil_init() {
  level.brendingoverrideinfo = spawnStruct();
  level.brendingoverrideinfo.endingpackoverridefunc = &heroesexfil_pack;
  level.brendingoverrideinfo.endingstructsoverridefunc = &heroesexfil_override_ending_structs;
  level.brendingoverrideinfo.exfiltypename) = "heroes";
level.brendingoverrideinfo.preloadending = 1;
level.brendingoverrideinfo.preloadwaittime = 9;
level.brendingoverrideinfo.usefactionweapons = 1;
level.brendingoverrideinfo.endingviewingplayerorigin = (11396, 14885, 8800);
level.brendingoverrideinfo.endingviewingplayerangles = (5, 273, 0);
olarideexfil_fx_init();
}

#using_animtree("");

function heroesexfil_pack(var_0) {
  olarideexfil_loadtransient();
  olarideexfil_playerremovecinematicblacklayerifneeded();
  thread olarideexfil_music_sfx_start();
  self.ref_142D0 = "mp_wz_island_s05_exfil_g_ltm";
  scripts\mp\gametypes\br_gametype_olaride::brolaride_detachallflag();
  olarideexfil_setupchopper();
  heroesexfil_setupfightersaircraft();
  olarideexfil_deleteloot(self.origin);
  olarideexfil_deletesmokecolumn();
  olarideexfil_updatewinners();
  thread scripts\mp\gametypes\br_gametypes::ref_12E05("exfilStart", self.winners);
  self.gameending = scripts\mp\gametypes\br_ending::init_carepackages();
  self.ref_121B8 = [];
  var_1 = 0;
  self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene1");
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olarideheroes_sh010_start);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_g_blima_sh010);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint($br_exfil_olaride_g_cam_sh010);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_g_guy0_sh010, %br_exfil_olaride_g_guy0_sh010_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_g_guy1_sh010, %br_exfil_olaride_g_guy1_sh010_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_g_guy2_sh010, %br_exfil_olaride_g_guy2_sh010_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_g_guy3_sh010, %br_exfil_olaride_g_guy3_sh010_fem);
  var_1++;
  self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene2");
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olarideheroes_sh020_start);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_g_blima_sh020);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_g_guy0_sh020, %br_exfil_olaride_g_guy0_sh020_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_g_guy1_sh020, %br_exfil_olaride_g_guy1_sh020_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_g_guy2_sh020, %br_exfil_olaride_g_guy2_sh020_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_g_guy3_sh020, %br_exfil_olaride_g_guy3_sh020_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_g_cam_sh020);
  var_1++;
  self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene3");
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olarideheroes_sh030_start);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_g_blima_sh030);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_g_guy0_sh030, %br_exfil_olaride_g_guy0_sh030_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_g_guy1_sh030, %br_exfil_olaride_g_guy1_sh030_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_g_guy2_sh030, %br_exfil_olaride_g_guy2_sh030_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_g_guy3_sh030, %br_exfil_olaride_g_guy3_sh030_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_g_cam_sh030);

  if(self.winners.size >= 2) {
    var_1++;
    self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene4");
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olarideheroes_sh040_start);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_g_blima_sh040);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_g_guy0_sh040, %br_exfil_olaride_g_guy0_sh040_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_g_guy1_sh040, %br_exfil_olaride_g_guy1_sh040_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_g_guy2_sh040, %br_exfil_olaride_g_guy2_sh040_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_g_guy3_sh040, %br_exfil_olaride_g_guy3_sh040_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_g_cam_sh040);
  }

  if(self.winners.size >= 3) {
    var_1++;
    self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene5");
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olarideheroes_sh050_start);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_g_blima_sh050);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_g_guy0_sh050, %br_exfil_olaride_g_guy0_sh050_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_g_guy1_sh050, %br_exfil_olaride_g_guy1_sh050_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_g_guy2_sh050, %br_exfil_olaride_g_guy2_sh050_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_g_guy3_sh050, %br_exfil_olaride_g_guy3_sh050_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_g_cam_sh050);
  }

  if(self.winners.size == 4) {
    var_1++;
    self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene6");
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olarideheroes_sh060_start);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_g_blima_sh060);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_g_guy0_sh060, %br_exfil_olaride_g_guy0_sh060_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_g_guy1_sh060, %br_exfil_olaride_g_guy1_sh060_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_g_guy2_sh060, %br_exfil_olaride_g_guy2_sh060_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_g_guy3_sh060, %br_exfil_olaride_g_guy3_sh060_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_g_cam_sh060);
  }

  var_1++;
  self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene7");
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olarideheroes_sh070_start);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_g_blima_sh070);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_g_guy0_sh070, %br_exfil_olaride_g_guy0_sh070_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_g_guy1_sh070, %br_exfil_olaride_g_guy1_sh070_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_g_guy2_sh070, %br_exfil_olaride_g_guy2_sh070_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_g_guy3_sh070, %br_exfil_olaride_g_guy3_sh070_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_g_cam_sh070);
  var_1++;
  self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene75");
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olarideheroes_sh075_start);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_g_blima_sh075);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_g_guy0_sh075, %br_exfil_olaride_g_guy0_sh075_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_g_guy1_sh075, %br_exfil_olaride_g_guy1_sh075_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_g_guy2_sh075, %br_exfil_olaride_g_guy2_sh075_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_g_guy3_sh075, %br_exfil_olaride_g_guy3_sh075_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_g_cam_sh075);
  var_1++;
  self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene8");
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olarideheroes_sh080_start);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_g_blima_sh080);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.aircraftfighter1, %br_exfil_olaride_g_suniform01_sh080);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.aircraftfighter2, %br_exfil_olaride_g_suniform02_sh080);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_g_cam_sh080);
}

function olarideheroes_sh010_start(var_0) {
  thread olarideexfil_set_brcircle(level.defendkill, 16500);
  olarideexfil_setwind(level.defendkill, "10");
  setomnvarforallclients("ui_br_end_game_splash_type", 17);
  scripts\mp\gametypes\br_ending::allplayers_setforcefov(43);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(1, 1500);
  thread olaridechopper_playFX();
  olarideexfil_choppershowrotors(0);
}

function olarideheroes_sh020_start(var_0) {
  scripts\mp\gametypes\br_ending::brking_ontimelimit(5, 90);
  thread olaridechopper_playFX();
}

function olarideheroes_sh030_start(var_0) {
  thread olarideexfil_set_brcircle(level.defendkill, 98000);
  olarideexfil_setwind(level.defendkill, "20");
  setomnvarforallclients("ui_br_end_game_splash_type", 13);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(4, 50);
  thread olaridechopper_playFX();
}

function olarideheroes_sh040_start(var_0) {
  setomnvarforallclients("ui_br_end_game_splash_type", 14);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(3, 60, 1, 1);
  thread olaridechopper_playFX();
}

function olarideheroes_sh050_start(var_0) {
  olarideexfil_setwind(level.defendkill, "40");
  setomnvarforallclients("ui_br_end_game_splash_type", 15);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(3, 40);
  thread olaridechopper_playFX();
}

function olarideheroes_sh060_start(var_0) {
  setomnvarforallclients("ui_br_end_game_splash_type", 16);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(4, 40);
  thread olaridechopper_playFX();
  thread olarideexfil_fadetoblack(3.2, 0.15, 0.05, 0.7, 1);
}

function olarideheroes_sh070_start(var_0) {
  scripts\mp\gametypes\br_ending::brking_ontimelimit(5, 75);
  thread olaridechopper_playFX();
  thread olarideexfil_fadetoblack(2.8, 0.15, 0.05, 0.7, 1);
}

function olarideheroes_sh075_start(var_0) {
  olarideexfil_setwind(level.defendkill, "60");
  scripts\mp\gametypes\br_ending::brking_ontimelimit(3, 150, 2, 2);
  thread olaridechopper_playFX();
  olarideexfil_teleportplayers((13962, 8336, 7700), (338, 105, 0));
  olarideexfil_preloadlocation((13962, 8336, 7700));
}

function olarideheroes_sh080_start(var_0) {
  level notify("shot_080_started");
  scripts\mp\gametypes\br_circle::spawn_carriable_at_struct();
  thread olaridechopper_playFX();
  thread heroesexfil_aircraftplayFX();
  thread heroesexfil_aircraftplayFX();
  var_1 = 1;
  scripts\mp\gametypes\br_ending::allplayers_setforcefov(43, var_1);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(20, 5000);
  thread olarideexfil_fadetoblack(9.45, 0.25);
}

function heroesexfil_override_ending_structs(var_0) {
  var_0 = [];
  var_0[0] = scripts\mp\gametypes\br_ending.gsc::init_level_drop_structs((11389, 13673, 8664), (0, 0, 0));
  return var_0;
}

function heroesexfil_setupfightersaircraft() {
  var_0 = spawn("script_origin", (0, 0, 0));
  var_1 = "veh8_mil_air_suniform25";
  self.aircraftfighter1 = var_0 scripts\mp\gametypes\br_ending::ref_135CA(var_1, "br_exfil_olaride_g_suniform01_sh080");
  self.aircraftfighter2 = var_0 scripts\mp\gametypes\br_ending::ref_135CA(var_1, "br_exfil_olaride_g_suniform02_sh080");
  self.aircraftfighter1 hide();
  self.aircraftfighter2 hide();
}

function heroesexfil_aircraftplayFX() {
  self endon("death");
  self show();
  self unmarkkeyframedmover(1);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("olarideHeroesExfil_contrail"), self, "tag_engine_left");
  playFXOnTag(scripts\engine\utility::getfx("olarideHeroesExfil_contrail"), self, "tag_engine_right");
  playFXOnTag(scripts\engine\utility::getfx("olarideHeroesExfil_trail"), self, "tag_wingtip_left");
  playFXOnTag(scripts\engine\utility::getfx("olarideHeroesExfil_trail"), self, "tag_wingtip_right");
}

function olarideexfil_deletesmokecolumn() {
  if(isDefined(level.islandsmoke)) {
    scripts\engine\utility::kill_exploder(level.islandsmoke);
  }
}

function villainsexfil_init() {
  level.brendingoverrideinfo = spawnStruct();
  level.brendingoverrideinfo.endingpackoverridefunc = &villainsexfil_pack;
  level.brendingoverrideinfo.endingstructsoverridefunc = &villainsexfil_override_ending_structs;
  level.brendingoverrideinfo.exfiltypename) = "villains";
level.brendingoverrideinfo.preloadending = 1;
level.brendingoverrideinfo.preloadwaittime = 9;
level.brendingoverrideinfo.usefactionweapons = 1;
level.brendingoverrideinfo.endingviewingplayerorigin = (12039, 13515, 8750);
level.brendingoverrideinfo.endingviewingplayerangles = (353, 159, 0);
olarideexfil_fx_init();
}

function villainsexfil_pack(var_0) {
  olarideexfil_loadtransient();
  olarideexfil_playerremovecinematicblacklayerifneeded();
  thread olarideexfil_music_sfx_start();
  self.ref_142D0 = "mp_wz_island_s05_exfil_b_ltm";
  scripts\mp\gametypes\br_gametype_olaride::brolaride_detachallflag();
  olarideexfil_setupchopper();
  villainsexfil_setupprops();
  olarideexfil_deleteloot(self.origin);
  olarideexfil_updatewinners();
  thread scripts\mp\gametypes\br_gametypes::ref_12E05("exfilStart", self.winners);
  self.gameending = scripts\mp\gametypes\br_ending::init_carepackages();
  self.ref_121B8 = [];
  var_1 = 0;
  self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene1");
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olaridevillains_sh010_start);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_b_blima_sh010);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_b_cam_sh010);
  var_1++;
  self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene2");
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olaridevillains_sh020_start);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_b_blima_sh020);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.gunner1, %br_exfil_olaride_b_gunner1_sh020);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.gunner2, %br_exfil_olaride_b_gunner2_sh020);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_b_guy0_sh020, %br_exfil_olaride_b_guy0_sh020_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_b_guy1_sh020, %br_exfil_olaride_b_guy1_sh020_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_b_guy2_sh020, %br_exfil_olaride_b_guy2_sh020_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_b_guy3_sh020, %br_exfil_olaride_b_guy3_sh020_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_b_cam_sh020);
  villainsexfil_shootfromnotetrack();
  var_1++;
  self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene3");
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olaridevillains_sh030_start);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_b_blima_sh030);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.gunner1, %br_exfil_olaride_b_gunner1_sh030);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.gunner2, %br_exfil_olaride_b_gunner2_sh030);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_b_guy0_sh030, %br_exfil_olaride_b_guy0_sh030_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_b_guy1_sh030, %br_exfil_olaride_b_guy1_sh030_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_b_guy2_sh030, %br_exfil_olaride_b_guy2_sh030_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_b_guy3_sh030, %br_exfil_olaride_b_guy3_sh030_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_b_cam_sh030);
  villainsexfil_shootfromnotetrack();

  if(self.winners.size >= 2) {
    var_1++;
    self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene4");
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olaridevillains_sh040_start);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_b_blima_sh040);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.pistolprop, %br_exfil_olaride_b_pistol_sh040);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.gunner1, %br_exfil_olaride_b_gunner1_sh040);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.gunner2, %br_exfil_olaride_b_gunner2_sh040);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_b_guy0_sh040, %br_exfil_olaride_b_guy0_sh040_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_b_guy1_sh040, %br_exfil_olaride_b_guy1_sh040_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_b_guy2_sh040, %br_exfil_olaride_b_guy2_sh040_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_b_guy3_sh040, %br_exfil_olaride_b_guy3_sh040_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_b_cam_sh040);
    villainsexfil_shootfromnotetrack();
  }

  if(self.winners.size >= 3) {
    var_1++;
    self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene5");
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olaridevillains_sh050_start);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_b_blima_sh050);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.grenadeprop, %br_exfil_olaride_b_grenade_sh050);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.gunner1, %br_exfil_olaride_b_gunner1_sh050);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.gunner2, %br_exfil_olaride_b_gunner2_sh050);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_b_guy0_sh050, %br_exfil_olaride_b_guy0_sh050_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_b_guy1_sh050, %br_exfil_olaride_b_guy1_sh050_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_b_guy2_sh050, %br_exfil_olaride_b_guy2_sh050_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_b_guy3_sh050, %br_exfil_olaride_b_guy3_sh050_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_b_cam_sh050);
    villainsexfil_shootfromnotetrack();
  }

  if(self.winners.size == 4) {
    var_1++;
    self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene6");
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olaridevillains_sh060_start);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_b_blima_sh060);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.gunner1, %br_exfil_olaride_b_gunner1_sh060);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.gunner2, %br_exfil_olaride_b_gunner2_sh060);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_b_guy0_sh060, %br_exfil_olaride_b_guy0_sh060_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_b_guy1_sh060, %br_exfil_olaride_b_guy1_sh060_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_b_guy2_sh060, %br_exfil_olaride_b_guy2_sh060_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_b_guy3_sh060, %br_exfil_olaride_b_guy3_sh060_fem);
    self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_b_cam_sh060);
    villainsexfil_shootfromnotetrack();
  }

  var_1++;
  self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene7");
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olaridevillains_sh070_start);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_b_blima_sh070);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.gunner1, %br_exfil_olaride_b_gunner1_sh070);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.gunner2, %br_exfil_olaride_b_gunner2_sh070);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[0], %br_exfil_olaride_b_guy0_sh070, %br_exfil_olaride_b_guy0_sh070_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[1], %br_exfil_olaride_b_guy1_sh070, %br_exfil_olaride_b_guy1_sh070_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[2], %br_exfil_olaride_b_guy2_sh070, %br_exfil_olaride_b_guy2_sh070_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_vector(self.winners[3], %br_exfil_olaride_b_guy3_sh070, %br_exfil_olaride_b_guy3_sh070_fem);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_b_cam_sh070);
  villainsexfil_shootfromnotetrack();
  var_1++;
  self.ref_121B8[var_1] = scripts\mp\gametypes\br_ending::init_bomb_objective("scene8");
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::backendevent([], &olaridevillains_sh080_start);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::back_struct(self.onkillingblow, %br_exfil_olaride_b_blima_sh080);
  self.ref_121B8[var_1] scripts\mp\gametypes\br_ending::awardstadiumblueprint(%br_exfil_olaride_b_cam_sh080);
}

function olaridevillains_sh010_start(var_0) {
  thread olarideexfil_set_brcircle(level.defendkill, 7700);
  scripts\mp\gametypes\br_ending::allplayers_setforcefov(40);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(2, 2000);
  setomnvarforallclients("ui_br_end_game_splash_type", 17);
  thread olaridechopper_playFX();
  olarideexfil_choppershowrotors(0);
  olarideexfil_teleportplayers((13410, 10749, 9150), (5, 166, 0));
  olarideexfil_preloadlocation((13410, 10749, 9150));
}

function olaridevillains_sh020_start(var_0) {
  playsoundatpos((13753, 11136, 9199), "br_exfil_olaride_villains_axis_gunfight");
  scripts\mp\gametypes\br_ending::brking_ontimelimit(5, 150);
  thread olaridechopper_playFX();
  olarideexfil_choppershowrotors(1);
}

function olaridevillains_sh030_start(var_0) {
  olarideexfil_setwind(level.defendkill, "10");
  setomnvarforallclients("ui_br_end_game_splash_type", 13);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(3, 75);
  thread olaridechopper_playFX();
  olarideexfil_choppershowrotors(0);
}

function olaridevillains_sh040_start(var_0) {
  olarideexfil_setwind(level.defendkill, "20");
  setomnvarforallclients("ui_br_end_game_splash_type", 14);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(2, 75);
  thread olaridechopper_playFX();
}

function olaridevillains_sh050_start(var_0) {
  olarideexfil_setwind(level.defendkill, "30");
  setomnvarforallclients("ui_br_end_game_splash_type", 15);
  level.defendkill.pistolprop delete();
  scripts\mp\gametypes\br_ending::brking_ontimelimit(2, 60);
  thread olaridechopper_playFX();
}

function olaridevillains_sh060_start(var_0) {
  thread olaridevillains_sh060_grenadeexplosound();
  olarideexfil_deletesmokecolumn();
  olarideexfil_setwind(level.defendkill, "40");
  setomnvarforallclients("ui_br_end_game_splash_type", 16);
  level.defendkill.grenadeprop delete();
  scripts\mp\gametypes\br_ending::brking_ontimelimit(6, 75);
  thread olaridechopper_playFX();
}

function olaridevillains_sh060_grenadeexplosound() {
  wait 0.5;
  playsoundatpos((13191, 11762, 9138), "frag_grenade_expl_trans");
}

function olaridevillains_sh070_start(var_0) {
  if(isDefined(level.defendkill.pistolprop)) {
    level.defendkill.pistolprop delete();
  }

  olarideexfil_setwind(level.defendkill, "60");
  scripts\mp\gametypes\br_ending::brking_ontimelimit(8, 500, 1, 1);
  thread olaridechopper_playFX();
  olarideexfil_teleportplayers((13962, 8336, 7700), (338, 105, 0));
  olarideexfil_preloadlocation((13962, 8336, 7700));
}

function olaridevillains_sh080_start(var_0) {
  level notify("shot_080_started");
  level.islandsmoke = scripts\engine\utility::ter_op(getdvarint("scr_br_caldera_volcano_olaride_smoke", 0), "olaride_volcano_smoke_big", "olaride_volcano_smoke_small");
  scripts\engine\utility::exploder(level.islandsmoke);
  scripts\mp\gametypes\br_circle::spawn_carriable_at_struct();
  var_1 = 1;
  scripts\mp\gametypes\br_ending::allplayers_setforcefov(40, var_1);
  scripts\mp\gametypes\br_ending::brking_ontimelimit(20, 5000);
  thread olaridechopper_playFX();
  thread villainsexfil_bombplayFX();
  thread olarideexfil_fadetoblack(12.5, 0.25);
}

function villainsexfil_override_ending_structs(var_0) {
  var_0 = [];
  var_0[0] = scripts\mp\gametypes\br_ending.gsc::init_level_drop_structs((12805, 10896, 9068), (0, 0, 0));
  return var_0;
}

function villainsexfil_bombplayFX() {
  var_0 = (11533, 13058, 15264);
  playFX(scripts\engine\utility::getfx("olarideVillainsExfil_bomb"), var_0);
  wait 10.5;
  scripts\engine\utility::exploder("lava_bomb_volcano_explosion");
}

function villainsexfil_setupprops() {
  var_0 = "offhand_wm_grenade_mike67";
  self.grenadeprop = scripts\mp\gametypes\br_ending::ref_135CA(var_0, "br_exfil_olaride_b_grenade_sh050");
  var_1 = "weapon_wm_stream_pi";
  self.pistolprop = scripts\mp\gametypes\br_ending::ref_135CA(var_1, "br_exfil_olaride_b_pistol_sh040");
  var_2 = "fullbody_zombie_a_br";
  self.gunner1 = scripts\mp\gametypes\br_ending::ref_135CA(var_2, "br_exfil_olaride_b_gunner1_sh020");
  self.gunner2 = scripts\mp\gametypes\br_ending::ref_135CA(var_2, "br_exfil_olaride_b_gunner2_sh020");
}

function villainsexfil_shootfromnotetrack() {
  scripts\common\anim::addnotetrack_customfunction(self.winners[0].animname, "fire", &scripts\mp\gametypes\br_ending::shoot_gun_from_notetrack);

  if(self.winners.size > 1) {
    scripts\common\anim::addnotetrack_customfunction(self.winners[1].animname, "fire", &scripts\mp\gametypes\br_ending::shoot_gun_from_notetrack);
    scripts\common\anim::addnotetrack_customfunction(self.winners[1].animname, "fire_pistol", &scripts\mp\gametypes\br_ending::shoot_gun_pistol_from_notetrack);
  }

  if(self.winners.size > 2) {
    scripts\common\anim::addnotetrack_customfunction(self.winners[2].animname, "fire", &scripts\mp\gametypes\br_ending::shoot_gun_from_notetrack);
  }

  if(self.winners.size > 3) {
    scripts\common\anim::addnotetrack_customfunction(self.winners[3].animname, "fire", &scripts\mp\gametypes\br_ending::shoot_gun_from_notetrack);
    return;
  }
}

function villainsexfil_gunnershootfromnotetrack() {
  scripts\common\anim::addnotetrack_customfunction(self.gunner1.animname, "fire", &scripts\mp\gametypes\br_ending::shoot_sfx_from_notetrack);
  scripts\common\anim::addnotetrack_customfunction(self.gunner2.animname, "fire", &scripts\mp\gametypes\br_ending::shoot_sfx_from_notetrack);
}