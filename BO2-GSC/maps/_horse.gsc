/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_horse.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_anim;
#include animscripts\shared;
#using_animtree("horse");

main() {
  self useanimtree(#animtree);
  self build_horse_anims();
  self.dismount_enabled = 1;
  self.disable_make_useable = 0;
  self.disable_weapon_changes = 0;

  if(!isDefined(level.horse_in_combat))
    build_aianims(::setanims);

  build_unload_groups(::unload_groups);
  level.vehicle_death_thread[self.vehicletype] = ::horse_death;
  loadfx("vehicle/treadfx/fx_afgh_treadfx_horse_hoof_impact");

  if(self.vehicletype == "horse_player") {
    level._effect["player_dust_riding_trot"] = loadfx("maps/afghanistan/fx_afgh_dust_riding_trot");
    level._effect["player_dust_riding_gallup"] = loadfx("maps/afghanistan/fx_afgh_dust_riding_gallup");
  }

  level._effect["horse_hits_ground"] = loadfx("env/dirt/fx_afgh_sand_horse_impact");

  if(isDefined(self.script_string))
    self setmodel(self.script_string);
  else if(issubstr(self.vehicletype, "low")) {
    idx = randomint(level.horse_model_variants["low"].size);
    self setmodel(level.horse_model_variants["low"][idx]);
  } else {
    idx = randomint(level.horse_model_variants["high"].size);
    self setmodel(level.horse_model_variants["high"][idx]);
  }

  self choose_sprint_anim();
  self ent_flag_init("mounting_horse");
  self ent_flag_init("dismounting_horse");
  self ent_flag_init("pause_animation");
  self ent_flag_init("playing_scripted_anim");
  self thread watch_mounting();
  self thread horse_animating();
  self.overridevehicledamage = ::horsecallback_vehicledamage;
}

choose_sprint_anim() {
  self.sprint_anim = level.horse_sprint_anims[level.horse_sprint_idx];
  level.horse_sprint_idx++;

  if(level.horse_sprint_idx > 3)
    level.horse_sprint_idx = 0;
}

precache_models() {
  level.player_viewmodel_noleft = "c_usa_mason_afgan_noleft_viewhands";
  precachemodel("anim_horse1_black_fb");
  precachemodel("anim_horse1_brown_black_fb");
  precachemodel("anim_horse1_brown_spots_fb");
  precachemodel("anim_horse1_grey_fb");
  precachemodel("anim_horse1_light_brown_fb");
  precachemodel("anim_horse1_white_fb");
  precachemodel("anim_horse1_white02_fb");
  precachemodel("anim_horse1_black_fb_low");
  precachemodel("anim_horse1_brown_black_fb_low");
  precachemodel("anim_horse1_brown_spots_fb_low");
  precachemodel("anim_horse1_grey_fb_low");
  precachemodel("anim_horse1_light_brown_fb_low");
  precachemodel("anim_horse1_white_fb_low");
  precachemodel("anim_horse1_white02_fb_low");
  precachemodel("viewmodel_horse1_fb");
  precachemodel("viewmodel_horse1_black_fb");
  precachemodel("viewmodel_horse1_brown_black_fb");
  precachemodel("viewmodel_horse1_brown_spots_fb");
  precachemodel("viewmodel_horse1_grey_fb");
  precachemodel("viewmodel_horse1_light_brown_fb");
  precachemodel("viewmodel_horse1_white_fb");
  precachemodel("viewmodel_horse1_white02_fb");
  precachemodel(level.player_viewmodel_noleft);
}

debug_horse() {
  self endon("death");
  recordent(self);

  while(true) {
    org = self gettagorigin("tag_driver");
    angles = self gettagangles("tag_driver");

    if(!isDefined(self.bone_fxaxis)) {
      self.bone_fxaxis = spawn("script_model", org);
      self.bone_fxaxis setmodel("fx_axis_createfx");
      recordent(self.bone_fxaxis);
    }

    if(isDefined(self.bone_fxaxis)) {
      self.bone_fxaxis.origin = org;
      self.bone_fxaxis.angles = angles;
    }

    wait 0.05;
  }

}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("horse");
#using_animtree("generic_human");

build_horse_anims() {
  level.reverse = 1;
  level.idle = 2;
  level.walk = 3;
  level.trot = 4;
  level.run = 5;
  level.sprint = 6;
  level.jump = 7;
  level.mount = 8;
  level.dismount = 9;
  level.rearback = 13;
  level.turn_180 = 14;
  self.idle_state = 0;
  self.idle_anim_finished_state = 0;
  self.current_anim_speed = level.idle;
  self.is_horse = 1;

  if(isDefined(level.horse_anims_inited)) {
    return;
  }
  level.horse_anims_inited = 1;
  level.horse_speeds = [];
  level.horse_speeds[level.reverse - 1] = -5000;
  level.horse_speeds[level.reverse] = -2.5;
  level.horse_speeds[level.idle] = 0;
  level.horse_speeds[level.walk] = 3;
  level.horse_speeds[level.trot] = 8;
  level.horse_speeds[level.run] = 16;
  level.horse_speeds[level.sprint] = 20;
  level.horse_speeds[level.sprint + 1] = 5000;
  level.horse_turn_speeds[level.walk] = 1;
  level.horse_turn_speeds[level.trot] = 1;
  level.horse_turn_speeds[level.run] = 1;
  level.horse_turn_speeds[level.sprint] = 1;
  level.horse_anims = [];
  level.horse_ai_anims = [];
  level.horse_player_anims = [];
  level.horse_idles = [];
  level.horse_idles[0] = spawnstruct();
  level.horse_idles[0].animations = [];
  level.horse_idles[0].ai_animations = [];
  level.horse_idles[0].player_animations = [];
  level.horse_idles[0].transitions = [];
  level.horse_idles[0].animations[0] = % a_horse_stand_idle;
  level.horse_idles[0].animations[1] = % a_horse_stand_idle_twitch_a;
  level.horse_idles[0].animations[2] = % a_horse_stand_idle_to_right_idle;
  level.horse_idles[0].ai_animations[0] = % ai_horse_rider_stand_idle;
  level.horse_idles[0].ai_animations[1] = % ai_horse_rider_stand_idle_twitch_a;
  level.horse_idles[0].ai_animations[2] = % ai_horse_rider_stand_idle_to_right_idle;
  level.horse_idles[0].player_animations[0] = % int_horse_player_stand_idle;
  level.horse_idles[0].player_animations[1] = % int_horse_player_stand_idle_twitch_a;
  level.horse_idles[0].player_animations[2] = % int_horse_player_stand_idle_to_right_idle;
  level.horse_idles[0].transitions[2] = 1;
  level.horse_idles[0].animations[3] = % a_horse_stand_idle_to_forward_idle;
  level.horse_idles[0].ai_animations[3] = % ai_horse_rider_stand_idle_to_forward_idle;
  level.horse_idles[0].player_animations[3] = % int_horse_player_stand_idle_to_forward_idle;
  level.horse_idles[0].transitions[3] = 2;
  level.horse_idles[0].animations[4] = % a_horse_stand_idle_to_wide_idle;
  level.horse_idles[0].ai_animations[4] = % ai_horse_rider_stand_idle_to_wide_idle;
  level.horse_idles[0].player_animations[4] = % int_horse_player_stand_idle_to_wide_idle;
  level.horse_idles[0].transitions[4] = 3;
  level.horse_idles[0].animations[5] = % a_horse_stand_idle_to_eat_idle;
  level.horse_idles[0].ai_animations[5] = % ai_horse_rider_stand_idle_to_eat_idle;
  level.horse_idles[0].player_animations[5] = % int_horse_player_stand_idle_to_eat_idle;
  level.horse_idles[0].transitions[5] = 5;

  level.horse_idles[0].ai_animnames = [];
  level.horse_idles[0].ai_animnames[0] = "ai_horse_rider_stand_idle";
  level.horse_idles[0].ai_animnames[1] = "ai_horse_rider_stand_idle_twitch_a";
  level.horse_idles[0].ai_animnames[2] = "ai_horse_rider_stand_idle_to_right_idle";
  level.horse_idles[0].ai_animnames[3] = "ai_horse_rider_stand_idle_to_forward_idle";
  level.horse_idles[0].ai_animnames[4] = "ai_horse_rider_stand_idle_to_wide_idle";
  level.horse_idles[0].ai_animnames[5] = "ai_horse_rider_stand_idle_to_eat_idle";

  level.horse_idles[1] = spawnstruct();
  level.horse_idles[1].animations = [];
  level.horse_idles[1].ai_animations = [];
  level.horse_idles[1].player_animations = [];
  level.horse_idles[1].transitions = [];
  level.horse_idles[1].animations[0] = % a_horse_right_idle;
  level.horse_idles[1].animations[1] = % a_horse_right_idle_to_stand_idle;
  level.horse_idles[1].ai_animations[0] = % ai_horse_rider_right_idle;
  level.horse_idles[1].ai_animations[1] = % ai_horse_rider_right_idle_to_stand_idle;
  level.horse_idles[1].player_animations[0] = % int_horse_player_right_idle;
  level.horse_idles[1].player_animations[1] = % int_horse_player_right_idle_to_stand_idle;
  level.horse_idles[1].transitions[1] = 0;
  level.horse_idles[1].animations[2] = % a_horse_right_idle_to_forward_idle;
  level.horse_idles[1].ai_animations[2] = % ai_horse_rider_right_idle_to_forward_idle;
  level.horse_idles[1].player_animations[2] = % int_horse_player_right_idle_to_forward_idle;
  level.horse_idles[1].transitions[2] = 2;

  level.horse_idles[1].ai_animnames = [];
  level.horse_idles[1].ai_animnames[0] = "ai_horse_rider_right_idle";
  level.horse_idles[1].ai_animnames[1] = "ai_horse_rider_right_idle_to_stand_idle";
  level.horse_idles[1].ai_animnames[2] = "ai_horse_rider_right_idle_to_forward_idle";

  level.horse_idles[2] = spawnstruct();
  level.horse_idles[2].animations = [];
  level.horse_idles[2].ai_animations = [];
  level.horse_idles[2].player_animations = [];
  level.horse_idles[2].transitions = [];
  level.horse_idles[2].animations[0] = % a_horse_forward_idle;
  level.horse_idles[2].animations[1] = % a_horse_forward_idle_to_right_idle;
  level.horse_idles[2].ai_animations[0] = % ai_horse_rider_forward_idle;
  level.horse_idles[2].ai_animations[1] = % ai_horse_rider_forward_idle_to_right_idle;
  level.horse_idles[2].player_animations[0] = % int_horse_player_forward_idle;
  level.horse_idles[2].player_animations[1] = % int_horse_player_forward_idle_to_right_idle;
  level.horse_idles[2].transitions[1] = 1;
  level.horse_idles[2].animations[2] = % a_horse_forward_idle_to_stand_idle;
  level.horse_idles[2].ai_animations[2] = % ai_horse_rider_forward_idle_to_stand_idle;
  level.horse_idles[2].player_animations[2] = % int_horse_player_forward_idle_to_stand_idle;
  level.horse_idles[2].transitions[2] = 0;
  level.horse_idles[2].animations[3] = % a_horse_forward_idle_to_eat_idle;
  level.horse_idles[2].ai_animations[3] = % ai_horse_rider_forward_idle_to_eat_idle;
  level.horse_idles[2].player_animations[3] = % int_horse_player_forward_idle_to_eat_idle;
  level.horse_idles[2].transitions[3] = 5;

  level.horse_idles[2].ai_animnames = [];
  level.horse_idles[2].ai_animnames[0] = "ai_horse_rider_forward_idle";
  level.horse_idles[2].ai_animnames[1] = "ai_horse_rider_forward_idle_to_right_idle";
  level.horse_idles[2].ai_animnames[2] = "ai_horse_rider_forward_idle_to_stand_idle";
  level.horse_idles[2].ai_animnames[3] = "ai_horse_rider_forward_idle_to_eat_idle";

  level.horse_idles[3] = spawnstruct();
  level.horse_idles[3].animations = [];
  level.horse_idles[3].ai_animations = [];
  level.horse_idles[3].player_animations = [];
  level.horse_idles[3].transitions = [];
  level.horse_idles[3].animations[0] = % a_horse_wide_idle;
  level.horse_idles[3].animations[1] = % a_horse_wide_idle_twitch_a;
  level.horse_idles[3].animations[2] = % a_horse_wide_idle_to_forward_idle;
  level.horse_idles[3].ai_animations[0] = % ai_horse_rider_wide_idle;
  level.horse_idles[3].ai_animations[1] = % ai_horse_rider_wide_idle_twitch_a;
  level.horse_idles[3].ai_animations[2] = % ai_horse_rider_wide_idle_to_forward_idle;
  level.horse_idles[3].player_animations[0] = % int_horse_player_wide_idle;
  level.horse_idles[3].player_animations[1] = % int_horse_player_wide_idle_twitch_a;
  level.horse_idles[3].player_animations[2] = % int_horse_player_wide_idle_to_forward_idle;
  level.horse_idles[3].transitions[2] = 2;
  level.horse_idles[3].animations[3] = % a_horse_wide_idle_to_frisky_idle;
  level.horse_idles[3].ai_animations[3] = % ai_horse_rider_wide_idle_to_frisky_idle;
  level.horse_idles[3].player_animations[3] = % int_horse_player_wide_idle_to_frisky_idle;
  level.horse_idles[3].transitions[3] = 4;
  level.horse_idles[3].animations[4] = % a_horse_wide_idle_to_right_idle;
  level.horse_idles[3].ai_animations[4] = % ai_horse_rider_wide_idle_to_right_idle;
  level.horse_idles[3].player_animations[4] = % int_horse_player_wide_idle_to_right_idle;
  level.horse_idles[3].transitions[4] = 1;

  level.horse_idles[3].ai_animnames = [];
  level.horse_idles[3].ai_animnames[0] = "ai_horse_rider_wide_idle";
  level.horse_idles[3].ai_animnames[1] = "ai_horse_rider_wide_idle_twitch_a";
  level.horse_idles[3].ai_animnames[2] = "ai_horse_rider_wide_idle_to_forward_idle";
  level.horse_idles[3].ai_animnames[3] = "ai_horse_rider_wide_idle_to_frisky_idle";
  level.horse_idles[3].ai_animnames[4] = "ai_horse_rider_wide_idle_to_right_idle";

  level.horse_idles[4] = spawnstruct();
  level.horse_idles[4].animations = [];
  level.horse_idles[4].ai_animations = [];
  level.horse_idles[4].player_animations = [];
  level.horse_idles[4].transitions = [];
  level.horse_idles[4].animations[0] = % a_horse_frisky_idle;
  level.horse_idles[4].animations[1] = % a_horse_frisky_idle_twitch_a;
  level.horse_idles[4].animations[2] = % a_horse_frisky_idle_twitch_b;
  level.horse_idles[4].animations[3] = % a_horse_frisky_idle_twitch_c;
  level.horse_idles[4].animations[4] = % a_horse_frisky_idle_to_wide_idle;
  level.horse_idles[4].ai_animations[0] = % ai_horse_rider_frisky_idle;
  level.horse_idles[4].ai_animations[1] = % ai_horse_rider_frisky_idle_twitch_a;
  level.horse_idles[4].ai_animations[2] = % ai_horse_rider_frisky_idle_twitch_b;
  level.horse_idles[4].ai_animations[3] = % ai_horse_rider_frisky_idle_twitch_c;
  level.horse_idles[4].ai_animations[4] = % ai_horse_rider_frisky_idle_to_wide_idle;
  level.horse_idles[4].player_animations[0] = % int_horse_player_frisky_idle;
  level.horse_idles[4].player_animations[1] = % int_horse_player_frisky_idle_twitch_a;
  level.horse_idles[4].player_animations[2] = % int_horse_player_frisky_idle_twitch_b;
  level.horse_idles[4].player_animations[3] = % int_horse_player_frisky_idle_twitch_c;
  level.horse_idles[4].player_animations[4] = % int_horse_player_frisky_idle_to_wide_idle;
  level.horse_idles[4].transitions[4] = 3;

  level.horse_idles[4].ai_animnames = [];
  level.horse_idles[4].ai_animnames[0] = "ai_horse_rider_frisky_idle";
  level.horse_idles[4].ai_animnames[1] = "ai_horse_rider_frisky_idle_twitch_a";
  level.horse_idles[4].ai_animnames[2] = "ai_horse_rider_frisky_idle_twitch_b";
  level.horse_idles[4].ai_animnames[3] = "ai_horse_rider_frisky_idle_twitch_c";
  level.horse_idles[4].ai_animnames[4] = "ai_horse_rider_frisky_idle_to_wide_idle";

  level.horse_idles[5] = spawnstruct();
  level.horse_idles[5].animations = [];
  level.horse_idles[5].ai_animations = [];
  level.horse_idles[5].player_animations = [];
  level.horse_idles[5].transitions = [];
  level.horse_idles[5].animations[0] = % a_horse_eat_idle;
  level.horse_idles[5].animations[1] = % a_horse_eat_idle_twitch_a;
  level.horse_idles[5].animations[2] = % a_horse_eat_idle_twitch_b;
  level.horse_idles[5].animations[3] = % a_horse_eat_idle_to_eat_idle_b;
  level.horse_idles[5].ai_animations[0] = % ai_horse_rider_eat_idle;
  level.horse_idles[5].ai_animations[1] = % ai_horse_rider_eat_idle_twitch_a;
  level.horse_idles[5].ai_animations[2] = % ai_horse_rider_eat_idle_twitch_b;
  level.horse_idles[5].ai_animations[3] = % ai_horse_rider_eat_idle_to_eat_idle_b;
  level.horse_idles[5].player_animations[0] = % int_horse_player_eat_idle;
  level.horse_idles[5].player_animations[1] = % int_horse_player_eat_idle_twitch_a;
  level.horse_idles[5].player_animations[2] = % int_horse_player_eat_idle_twitch_b;
  level.horse_idles[5].player_animations[3] = % int_horse_player_eat_idle_to_eat_idle_b;
  level.horse_idles[5].transitions[3] = 6;
  level.horse_idles[5].animations[4] = % a_horse_eat_idle_to_stand_idle;
  level.horse_idles[5].ai_animations[4] = % ai_horse_rider_eat_idle_to_stand_idle;
  level.horse_idles[5].player_animations[4] = % int_horse_player_eat_idle_to_stand_idle;
  level.horse_idles[5].transitions[4] = 0;
  level.horse_idles[5].animations[5] = % a_horse_eat_idle_to_wide_idle;
  level.horse_idles[5].ai_animations[5] = % ai_horse_rider_eat_idle_to_wide_idle;
  level.horse_idles[5].player_animations[5] = % int_horse_player_eat_idle_to_wide_idle;
  level.horse_idles[5].transitions[5] = 3;

  level.horse_idles[5].ai_animnames = [];
  level.horse_idles[5].ai_animnames[0] = "ai_horse_rider_eat_idle";
  level.horse_idles[5].ai_animnames[1] = "ai_horse_rider_eat_idle_twitch_a";
  level.horse_idles[5].ai_animnames[2] = "ai_horse_rider_eat_idle_twitch_b";
  level.horse_idles[5].ai_animnames[3] = "ai_horse_rider_eat_idle_to_eat_idle_b";
  level.horse_idles[5].ai_animnames[4] = "ai_horse_rider_eat_idle_to_stand_idle";
  level.horse_idles[5].ai_animnames[5] = "ai_horse_rider_eat_idle_to_wide_idle";

  level.horse_idles[6] = spawnstruct();
  level.horse_idles[6].animations = [];
  level.horse_idles[6].ai_animations = [];
  level.horse_idles[6].player_animations = [];
  level.horse_idles[6].transitions = [];
  level.horse_idles[6].animations[0] = % a_horse_eat_idle_b;
  level.horse_idles[6].animations[1] = % a_horse_eat_idle_b_twitch_a;
  level.horse_idles[6].animations[2] = % a_horse_eat_idle_b_twitch_b;
  level.horse_idles[6].animations[3] = % a_horse_eat_idle_b_twitch_c;
  level.horse_idles[6].animations[4] = % a_horse_eat_idle_b_to_eat_idle;
  level.horse_idles[6].ai_animations[0] = % ai_horse_rider_eat_idle_b;
  level.horse_idles[6].ai_animations[1] = % ai_horse_rider_eat_idle_b_twitch_a;
  level.horse_idles[6].ai_animations[2] = % ai_horse_rider_eat_idle_b_twitch_b;
  level.horse_idles[6].ai_animations[3] = % ai_horse_rider_eat_idle_b_twitch_c;
  level.horse_idles[6].ai_animations[4] = % ai_horse_rider_eat_idle_b_to_eat_idle;
  level.horse_idles[6].player_animations[0] = % int_horse_player_eat_idle_b;
  level.horse_idles[6].player_animations[1] = % int_horse_player_eat_idle_b_twitch_a;
  level.horse_idles[6].player_animations[2] = % int_horse_player_eat_idle_b_twitch_b;
  level.horse_idles[6].player_animations[3] = % int_horse_player_eat_idle_b_twitch_c;
  level.horse_idles[6].player_animations[4] = % int_horse_player_eat_idle_b_to_eat_idle;
  level.horse_idles[6].transitions[4] = 5;
  level.horse_idles[6].animations[5] = % a_horse_eat_idle_b_to_stand_idle;
  level.horse_idles[6].ai_animations[5] = % ai_horse_rider_eat_idle_b_to_stand_idle;
  level.horse_idles[6].player_animations[5] = % int_horse_player_eat_idle_b_to_stand_idle;
  level.horse_idles[6].transitions[5] = 0;

  level.horse_idles[6].ai_animnames = [];
  level.horse_idles[6].ai_animnames[0] = "ai_horse_rider_eat_idle_b";
  level.horse_idles[6].ai_animnames[1] = "ai_horse_rider_eat_idle_b_twitch_a";
  level.horse_idles[6].ai_animnames[2] = "ai_horse_rider_eat_idle_b_twitch_b";
  level.horse_idles[6].ai_animnames[3] = "ai_horse_rider_eat_idle_b_twitch_c";
  level.horse_idles[6].ai_animnames[4] = "ai_horse_rider_eat_idle_b_to_eat_idle";
  level.horse_idles[6].ai_animnames[5] = "ai_horse_rider_eat_idle_b_to_stand_idle";

  level.horse_anims[level.reverse] = % a_horse_walk_b;
  level.horse_anims[level.idle] = [];
  level.horse_anims[level.idle][0] = % a_horse_stand_idle;
  level.horse_anims[level.idle][1] = % a_horse_idle_turn_l;
  level.horse_anims[level.idle][2] = % a_horse_idle_turn_r;
  level.horse_anims[level.walk] = [];
  level.horse_anims[level.walk][0] = % a_horse_walk_f;
  level.horse_anims[level.trot] = [];
  level.horse_anims[level.trot][0] = % a_horse_trot_f;
  level.horse_anims[level.run] = [];
  level.horse_anims[level.run][0] = % a_horse_canter_f;
  level.horse_anims[level.sprint] = [];
  level.horse_anims[level.sprint][0] = % a_horse_sprint_f;
  level.horse_anims[level.jump][0] = % a_horse_jump_init;
  level.horse_anims[level.jump][1] = % a_horse_jump_midair;
  level.horse_anims[level.jump][2] = % a_horse_jump_land_from_above;
  level.horse_anims[level.mount][0] = % a_horse_get_on_leftside;
  level.horse_anims[level.mount][1] = % a_horse_get_on_rightside;
  level.horse_anims[level.dismount][0] = % a_horse_get_off_leftside;
  level.horse_anims[level.dismount][1] = % a_horse_get_off_rightside;
  level.horse_anims[10][0] = % a_horse_get_on_combat_leftside;
  level.horse_anims[10][1] = % a_horse_get_on_combat_rightside;
  level.horse_anims[11][0] = % a_horse_get_off_combat_leftside;
  level.horse_anims[11][1] = % a_horse_get_off_combat_rightside;
  level.horse_anims[12] = % a_horse_hitwall;
  level.horse_anims[level.rearback] = % a_horse_rearback_nofall;
  level.horse_anims[level.turn_180] = % a_horse_turn180_r;
  level.horse_sprint_anims = [];
  level.horse_sprint_anims[0] = % a_horse_sprint_f;
  level.horse_sprint_anims[1] = % a_horse_sprint_f_alt_a;
  level.horse_sprint_anims[2] = % a_horse_sprint_f_alt_b;
  level.horse_sprint_anims[3] = % a_horse_sprint_f_alt_c;
  level.horse_sprint_anims = array_randomize(level.horse_sprint_anims);
  level.horse_sprint_idx = 0;
  level.horse_ai_anims[level.reverse] = % ai_horse_rider_walk_b;
  level.horse_ai_anims[level.idle] = [];
  level.horse_ai_anims[level.idle][0] = % ai_horse_rider_stand_idle;
  level.horse_ai_anims[level.idle][1] = % ai_horse_rider_idle_turn_l;
  level.horse_ai_anims[level.idle][2] = % ai_horse_rider_idle_turn_r;
  level.horse_ai_anims[level.walk] = [];
  level.horse_ai_anims[level.walk][0] = % ai_horse_rider_walk_f;
  level.horse_ai_anims[level.trot] = [];
  level.horse_ai_anims[level.trot][0] = % ai_horse_rider_trot_f;
  level.horse_ai_anims[level.run] = [];
  level.horse_ai_anims[level.run][0] = % ai_horse_rider_canter_f;
  level.horse_ai_anims[level.sprint] = [];
  level.horse_ai_anims[level.sprint][0] = % ai_horse_rider_sprint_f;
  level.horse_ai_anims[level.jump][0] = % ai_horse_rider_jump_init;
  level.horse_ai_anims[level.jump][1] = % ai_horse_rider_jump_midair;
  level.horse_ai_anims[level.jump][2] = % ai_horse_rider_jump_land_from_above;
  level.horse_ai_anims[level.mount][0] = % ai_horse_rider_get_on_leftside;
  level.horse_ai_anims[level.mount][1] = % ai_horse_rider_get_on_rightside;
  level.horse_ai_anims[level.dismount][0] = % ai_horse_rider_get_off_leftside;
  level.horse_ai_anims[level.dismount][1] = % ai_horse_rider_get_off_rightside;
  level.horse_ai_anims[10][0] = % ai_horse_rider_get_on_combat_leftside;
  level.horse_ai_anims[10][1] = % ai_horse_rider_get_on_combat_rightside;
  level.horse_ai_anims[11][0] = % ai_horse_rider_get_off_combat_leftside;
  level.horse_ai_anims[11][1] = % ai_horse_rider_get_off_combat_rightside;
  level.horse_ai_anims[12] = % ai_horse_rider_hitwall;
  level.horse_ai_anims[level.rearback] = % ai_horse_rider_rearback_nofall;
  level.aim_f = 0;
  level.aim_l = 1;
  level.aim_r = 2;
  level.fire = 0;
  level.horse_ai_aim_anims[level.idle] = [];
  level.horse_ai_aim_anims[level.idle][level.aim_f] = [];
  level.horse_ai_aim_anims[level.idle][level.aim_f][2] = % ai_horse_rider_aim_f_2;
  level.horse_ai_aim_anims[level.idle][level.aim_f][4] = % ai_horse_rider_aim_f_4;
  level.horse_ai_aim_anims[level.idle][level.aim_f][5] = % ai_horse_rider_aim_f_5;
  level.horse_ai_aim_anims[level.idle][level.aim_f][6] = % ai_horse_rider_aim_f_6;
  level.horse_ai_aim_anims[level.idle][level.aim_f][8] = % ai_horse_rider_aim_f_8;
  level.horse_ai_aim_anims[level.idle][level.aim_f][level.fire] = % ai_horse_rider_aim_f_fire;
  level.horse_ai_aim_anims[level.idle][level.aim_l] = [];
  level.horse_ai_aim_anims[level.idle][level.aim_l][2] = % ai_horse_rider_aim_l_2;
  level.horse_ai_aim_anims[level.idle][level.aim_l][4] = % ai_horse_rider_aim_l_4;
  level.horse_ai_aim_anims[level.idle][level.aim_l][5] = % ai_horse_rider_aim_l_5;
  level.horse_ai_aim_anims[level.idle][level.aim_l][6] = % ai_horse_rider_aim_l_6;
  level.horse_ai_aim_anims[level.idle][level.aim_l][8] = % ai_horse_rider_aim_l_8;
  level.horse_ai_aim_anims[level.idle][level.aim_l][level.fire] = % ai_horse_rider_aim_l_fire;
  level.horse_ai_aim_anims[level.idle][level.aim_r] = [];
  level.horse_ai_aim_anims[level.idle][level.aim_r][2] = % ai_horse_rider_aim_r_2;
  level.horse_ai_aim_anims[level.idle][level.aim_r][4] = % ai_horse_rider_aim_r_4;
  level.horse_ai_aim_anims[level.idle][level.aim_r][5] = % ai_horse_rider_aim_r_5;
  level.horse_ai_aim_anims[level.idle][level.aim_r][6] = % ai_horse_rider_aim_r_6;
  level.horse_ai_aim_anims[level.idle][level.aim_r][8] = % ai_horse_rider_aim_r_8;
  level.horse_ai_aim_anims[level.idle][level.aim_r][level.fire] = % ai_horse_rider_aim_r_fire;
  level.horse_ai_aim_anims[level.walk] = [];
  level.horse_ai_aim_anims[level.walk][level.aim_f] = [];
  level.horse_ai_aim_anims[level.walk][level.aim_f][2] = % ai_horse_rider_walk_aim_f_2;
  level.horse_ai_aim_anims[level.walk][level.aim_f][4] = % ai_horse_rider_walk_aim_f_4;
  level.horse_ai_aim_anims[level.walk][level.aim_f][5] = % ai_horse_rider_walk_aim_f_5;
  level.horse_ai_aim_anims[level.walk][level.aim_f][6] = % ai_horse_rider_walk_aim_f_6;
  level.horse_ai_aim_anims[level.walk][level.aim_f][8] = % ai_horse_rider_walk_aim_f_8;
  level.horse_ai_aim_anims[level.walk][level.aim_f][level.fire] = % ai_horse_rider_walk_aim_f_fire;
  level.horse_ai_aim_anims[level.walk][level.aim_l] = [];
  level.horse_ai_aim_anims[level.walk][level.aim_l][2] = % ai_horse_rider_walk_aim_l_2;
  level.horse_ai_aim_anims[level.walk][level.aim_l][4] = % ai_horse_rider_walk_aim_l_4;
  level.horse_ai_aim_anims[level.walk][level.aim_l][5] = % ai_horse_rider_walk_aim_l_5;
  level.horse_ai_aim_anims[level.walk][level.aim_l][6] = % ai_horse_rider_walk_aim_l_6;
  level.horse_ai_aim_anims[level.walk][level.aim_l][8] = % ai_horse_rider_walk_aim_l_8;
  level.horse_ai_aim_anims[level.walk][level.aim_l][level.fire] = % ai_horse_rider_walk_aim_l_fire;
  level.horse_ai_aim_anims[level.walk][level.aim_r] = [];
  level.horse_ai_aim_anims[level.walk][level.aim_r][2] = % ai_horse_rider_walk_aim_r_2;
  level.horse_ai_aim_anims[level.walk][level.aim_r][4] = % ai_horse_rider_walk_aim_r_4;
  level.horse_ai_aim_anims[level.walk][level.aim_r][5] = % ai_horse_rider_walk_aim_r_5;
  level.horse_ai_aim_anims[level.walk][level.aim_r][6] = % ai_horse_rider_walk_aim_r_6;
  level.horse_ai_aim_anims[level.walk][level.aim_r][8] = % ai_horse_rider_walk_aim_r_8;
  level.horse_ai_aim_anims[level.walk][level.aim_r][level.fire] = % ai_horse_rider_walk_aim_r_fire;
  level.horse_ai_aim_anims[level.trot] = [];
  level.horse_ai_aim_anims[level.trot][level.aim_f] = [];
  level.horse_ai_aim_anims[level.trot][level.aim_f][2] = % ai_horse_rider_trot_aim_f_2;
  level.horse_ai_aim_anims[level.trot][level.aim_f][4] = % ai_horse_rider_trot_aim_f_4;
  level.horse_ai_aim_anims[level.trot][level.aim_f][5] = % ai_horse_rider_trot_aim_f_5;
  level.horse_ai_aim_anims[level.trot][level.aim_f][6] = % ai_horse_rider_trot_aim_f_6;
  level.horse_ai_aim_anims[level.trot][level.aim_f][8] = % ai_horse_rider_trot_aim_f_8;
  level.horse_ai_aim_anims[level.trot][level.aim_f][level.fire] = % ai_horse_rider_trot_aim_f_fire;
  level.horse_ai_aim_anims[level.trot][level.aim_l] = [];
  level.horse_ai_aim_anims[level.trot][level.aim_l][2] = % ai_horse_rider_trot_aim_l_2;
  level.horse_ai_aim_anims[level.trot][level.aim_l][4] = % ai_horse_rider_trot_aim_l_4;
  level.horse_ai_aim_anims[level.trot][level.aim_l][5] = % ai_horse_rider_trot_aim_l_5;
  level.horse_ai_aim_anims[level.trot][level.aim_l][6] = % ai_horse_rider_trot_aim_l_6;
  level.horse_ai_aim_anims[level.trot][level.aim_l][8] = % ai_horse_rider_trot_aim_l_8;
  level.horse_ai_aim_anims[level.trot][level.aim_l][level.fire] = % ai_horse_rider_trot_aim_l_fire;
  level.horse_ai_aim_anims[level.trot][level.aim_r] = [];
  level.horse_ai_aim_anims[level.trot][level.aim_r][2] = % ai_horse_rider_trot_aim_r_2;
  level.horse_ai_aim_anims[level.trot][level.aim_r][4] = % ai_horse_rider_trot_aim_r_4;
  level.horse_ai_aim_anims[level.trot][level.aim_r][5] = % ai_horse_rider_trot_aim_r_5;
  level.horse_ai_aim_anims[level.trot][level.aim_r][6] = % ai_horse_rider_trot_aim_r_6;
  level.horse_ai_aim_anims[level.trot][level.aim_r][8] = % ai_horse_rider_trot_aim_r_8;
  level.horse_ai_aim_anims[level.trot][level.aim_r][level.fire] = % ai_horse_rider_trot_aim_r_fire;
  level.horse_ai_aim_anims[level.run] = [];
  level.horse_ai_aim_anims[level.run][level.aim_f] = [];
  level.horse_ai_aim_anims[level.run][level.aim_f][2] = % ai_horse_rider_canter_aim_f_2;
  level.horse_ai_aim_anims[level.run][level.aim_f][4] = % ai_horse_rider_canter_aim_f_4;
  level.horse_ai_aim_anims[level.run][level.aim_f][5] = % ai_horse_rider_canter_aim_f_5;
  level.horse_ai_aim_anims[level.run][level.aim_f][6] = % ai_horse_rider_canter_aim_f_6;
  level.horse_ai_aim_anims[level.run][level.aim_f][8] = % ai_horse_rider_canter_aim_f_8;
  level.horse_ai_aim_anims[level.run][level.aim_f][level.fire] = % ai_horse_rider_canter_aim_f_fire;
  level.horse_ai_aim_anims[level.run][level.aim_l] = [];
  level.horse_ai_aim_anims[level.run][level.aim_l][2] = % ai_horse_rider_canter_aim_l_2;
  level.horse_ai_aim_anims[level.run][level.aim_l][4] = % ai_horse_rider_canter_aim_l_4;
  level.horse_ai_aim_anims[level.run][level.aim_l][5] = % ai_horse_rider_canter_aim_l_5;
  level.horse_ai_aim_anims[level.run][level.aim_l][6] = % ai_horse_rider_canter_aim_l_6;
  level.horse_ai_aim_anims[level.run][level.aim_l][8] = % ai_horse_rider_canter_aim_l_8;
  level.horse_ai_aim_anims[level.run][level.aim_l][level.fire] = % ai_horse_rider_canter_aim_l_fire;
  level.horse_ai_aim_anims[level.run][level.aim_r] = [];
  level.horse_ai_aim_anims[level.run][level.aim_r][2] = % ai_horse_rider_canter_aim_r_2;
  level.horse_ai_aim_anims[level.run][level.aim_r][4] = % ai_horse_rider_canter_aim_r_4;
  level.horse_ai_aim_anims[level.run][level.aim_r][5] = % ai_horse_rider_canter_aim_r_5;
  level.horse_ai_aim_anims[level.run][level.aim_r][6] = % ai_horse_rider_canter_aim_r_6;
  level.horse_ai_aim_anims[level.run][level.aim_r][8] = % ai_horse_rider_canter_aim_r_8;
  level.horse_ai_aim_anims[level.run][level.aim_r][level.fire] = % ai_horse_rider_canter_aim_r_fire;
  level.horse_ai_aim_anims[level.sprint] = [];
  level.horse_ai_aim_anims[level.sprint][level.aim_f] = [];
  level.horse_ai_aim_anims[level.sprint][level.aim_f][2] = % ai_horse_rider_sprint_aim_f_2;
  level.horse_ai_aim_anims[level.sprint][level.aim_f][4] = % ai_horse_rider_sprint_aim_f_4;
  level.horse_ai_aim_anims[level.sprint][level.aim_f][5] = % ai_horse_rider_sprint_aim_f_5;
  level.horse_ai_aim_anims[level.sprint][level.aim_f][6] = % ai_horse_rider_sprint_aim_f_6;
  level.horse_ai_aim_anims[level.sprint][level.aim_f][8] = % ai_horse_rider_sprint_aim_f_8;
  level.horse_ai_aim_anims[level.sprint][level.aim_f][level.fire] = % ai_horse_rider_sprint_aim_f_fire;
  level.horse_ai_aim_anims[level.sprint][level.aim_l] = [];
  level.horse_ai_aim_anims[level.sprint][level.aim_l][2] = % ai_horse_rider_sprint_aim_l_2;
  level.horse_ai_aim_anims[level.sprint][level.aim_l][4] = % ai_horse_rider_sprint_aim_l_4;
  level.horse_ai_aim_anims[level.sprint][level.aim_l][5] = % ai_horse_rider_sprint_aim_l_5;
  level.horse_ai_aim_anims[level.sprint][level.aim_l][6] = % ai_horse_rider_sprint_aim_l_6;
  level.horse_ai_aim_anims[level.sprint][level.aim_l][8] = % ai_horse_rider_sprint_aim_l_8;
  level.horse_ai_aim_anims[level.sprint][level.aim_l][level.fire] = % ai_horse_rider_sprint_aim_l_fire;
  level.horse_ai_aim_anims[level.sprint][level.aim_r] = [];
  level.horse_ai_aim_anims[level.sprint][level.aim_r][2] = % ai_horse_rider_sprint_aim_r_2;
  level.horse_ai_aim_anims[level.sprint][level.aim_r][4] = % ai_horse_rider_sprint_aim_r_4;
  level.horse_ai_aim_anims[level.sprint][level.aim_r][5] = % ai_horse_rider_sprint_aim_r_5;
  level.horse_ai_aim_anims[level.sprint][level.aim_r][6] = % ai_horse_rider_sprint_aim_r_6;
  level.horse_ai_aim_anims[level.sprint][level.aim_r][8] = % ai_horse_rider_sprint_aim_r_8;
  level.horse_ai_aim_anims[level.sprint][level.aim_r][level.fire] = % ai_horse_rider_sprint_aim_r_fire;
  level.horse_player_anims[level.reverse] = % int_horse_player_walk_b;
  level.horse_player_anims[level.idle] = [];
  level.horse_player_anims[level.idle][0] = % int_horse_player_stand_idle;
  level.horse_player_anims[level.idle][1] = % int_horse_player_idle_turn_l;
  level.horse_player_anims[level.idle][2] = % int_horse_player_idle_turn_r;
  level.horse_player_anims[level.walk] = [];
  level.horse_player_anims[level.walk][0] = % int_horse_player_walk_f;
  level.horse_player_anims[level.trot] = [];
  level.horse_player_anims[level.trot][0] = % int_horse_player_trot_f;
  level.horse_player_anims[level.run] = [];
  level.horse_player_anims[level.run][0] = % int_horse_player_canter_f;
  level.horse_player_anims[level.sprint] = [];
  level.horse_player_anims[level.sprint][0] = % int_horse_player_sprint_f;
  level.horse_player_anims[level.sprint][3] = % int_horse_player_sprint_boost;
  level.horse_player_anims[level.jump][0] = % int_horse_player_jump_init;
  level.horse_player_anims[level.jump][1] = % int_horse_player_jump_midair;
  level.horse_player_anims[level.jump][2] = % int_horse_player_jump_land_from_above;
  level.horse_player_anims[level.mount][0] = % int_horse_player_get_on_leftside;
  level.horse_player_anims[level.mount][1] = % int_horse_player_get_on_rightside;
  level.horse_player_anims[level.dismount][0] = % int_horse_player_get_off_leftside;
  level.horse_player_anims[level.dismount][1] = % int_horse_player_get_off_rightside;
  level.horse_player_anims[10][0] = % int_horse_player_get_on_combat_leftside;
  level.horse_player_anims[10][1] = % int_horse_player_get_on_combat_rightside;
  level.horse_player_anims[11][0] = % int_horse_player_get_off_combat_leftside;
  level.horse_player_anims[11][1] = % int_horse_player_get_off_combat_rightside;
  level.horse_player_anims[12] = % int_horse_rider_hitwall;
  level.horse_player_anims[level.rearback] = % int_horse_player_rearback_nofall;
  level.horse_player_anims[level.turn_180] = % int_horse_player_turn180_r;
  level.horse_deaths = [];
  level.horse_deaths[0] = spawnstruct();
  level.horse_deaths[0].animation = % a_horse_death_galloping;
  level.horse_deaths[0].ai_animation = % ai_horse_rider_death_galloping;
  level.horse_deaths[0].player_animation = % int_horse_player_death_galloping;
  level.horse_deaths[1] = spawnstruct();
  level.horse_deaths[1].animation = % a_horse_death_galloping_faceplant;
  level.horse_deaths[1].ai_animation = % ai_horse_rider_death_galloping_faceplant;
  level.horse_deaths[1].player_animation = % int_horse_player_death_galloping_faceplant;
  level.horse_deaths[2] = spawnstruct();
  level.horse_deaths[2].animation = % a_horse_death_standing_slow;
  level.horse_deaths[2].ai_animation = % ai_horse_rider_death_standing_slow;
  level.horse_deaths[2].player_animation = % int_horse_player_death_standing_slow;
  level.horse_deaths[3] = spawnstruct();
  level.horse_deaths[3].animation = % a_horse_death_standing_fast;
  level.horse_deaths[3].ai_animation = % ai_horse_rider_death_standing_fast;
  level.horse_deaths[3].player_animation = % int_horse_player_death_standing_fast;
  level.horse_deaths_explosive = [];
  level.horse_deaths_explosive[0] = spawnstruct();
  level.horse_deaths_explosive[0].animation = % a_horse_sprint_explosive_death_fly_forward_a;
  level.horse_deaths_explosive[0].ai_animation = % ai_horse_rider_sprint_explosive_death_fly_forward_a;
  level.horse_deaths_explosive[1] = spawnstruct();
  level.horse_deaths_explosive[1].animation = % a_horse_sprint_explosive_death_fly_forward_b;
  level.horse_deaths_explosive[1].ai_animation = % ai_horse_rider_sprint_explosive_death_fly_forward_b;
  level.horse_deaths_explosive[2] = spawnstruct();
  level.horse_deaths_explosive[2].animation = % a_horse_sprint_explosive_death_fly_forward_c;
  level.horse_deaths_explosive[2].ai_animation = % ai_horse_rider_sprint_explosive_death_fly_forward_c;
  level.horse_deaths_explosive[3] = spawnstruct();
  level.horse_deaths_explosive[3].animation = % a_horse_sprint_explosive_death_fly_forward_d;
  level.horse_deaths_explosive[3].ai_animation = % ai_horse_rider_sprint_explosive_death_fly_forward_d;
  level.horse_deaths_explosive[4] = spawnstruct();
  level.horse_deaths_explosive[4].animation = % a_horse_sprint_explosive_death_fly_forward_e;
  level.horse_deaths_explosive[4].ai_animation = % ai_horse_rider_sprint_explosive_death_fly_forward_e;
  level.horse_deaths_explosive[5] = spawnstruct();
  level.horse_deaths_explosive[5].animation = % a_horse_sprint_explosive_death_fly_forward_f;
  level.horse_deaths_explosive[5].ai_animation = % ai_horse_rider_sprint_explosive_death_fly_forward_f;
  level.horse_model_variants = [];
  level.horse_model_variants["high"] = [];
  level.horse_model_variants["high"][level.horse_model_variants["high"].size] = "anim_horse1_fb";
  level.horse_model_variants["high"][level.horse_model_variants["high"].size] = "anim_horse1_black_fb";
  level.horse_model_variants["high"][level.horse_model_variants["high"].size] = "anim_horse1_brown_black_fb";
  level.horse_model_variants["high"][level.horse_model_variants["high"].size] = "anim_horse1_brown_spots_fb";
  level.horse_model_variants["high"][level.horse_model_variants["high"].size] = "anim_horse1_grey_fb";
  level.horse_model_variants["high"][level.horse_model_variants["high"].size] = "anim_horse1_light_brown_fb";
  level.horse_model_variants["high"][level.horse_model_variants["high"].size] = "anim_horse1_white_fb";
  level.horse_model_variants["high"][level.horse_model_variants["high"].size] = "anim_horse1_white02_fb";
  level.horse_model_variants["low"] = [];
  level.horse_model_variants["low"][level.horse_model_variants["low"].size] = "anim_horse1_fb_low";
  level.horse_model_variants["low"][level.horse_model_variants["low"].size] = "anim_horse1_black_fb_low";
  level.horse_model_variants["low"][level.horse_model_variants["low"].size] = "anim_horse1_brown_black_fb_low";
  level.horse_model_variants["low"][level.horse_model_variants["low"].size] = "anim_horse1_brown_spots_fb_low";
  level.horse_model_variants["low"][level.horse_model_variants["low"].size] = "anim_horse1_grey_fb_low";
  level.horse_model_variants["low"][level.horse_model_variants["low"].size] = "anim_horse1_light_brown_fb_low";
  level.horse_model_variants["low"][level.horse_model_variants["low"].size] = "anim_horse1_white_fb_low";
  level.horse_model_variants["low"][level.horse_model_variants["low"].size] = "anim_horse1_white02_fb_low";
  level.horse_viewmodel_variants = [];
  level.horse_viewmodel_variants["anim_horse1_fb"] = "viewmodel_horse1_fb";
  level.horse_viewmodel_variants["anim_horse1_black_fb"] = "viewmodel_horse1_black_fb";
  level.horse_viewmodel_variants["anim_horse1_brown_black_fb"] = "viewmodel_horse1_brown_black_fb";
  level.horse_viewmodel_variants["anim_horse1_brown_spots_fb"] = "viewmodel_horse1_brown_spots_fb";
  level.horse_viewmodel_variants["anim_horse1_grey_fb"] = "viewmodel_horse1_grey_fb";
  level.horse_viewmodel_variants["anim_horse1_light_brown_fb"] = "viewmodel_horse1_light_brown_fb";
  level.horse_viewmodel_variants["anim_horse1_white_fb"] = "viewmodel_horse1_white_fb";
  level.horse_viewmodel_variants["anim_horse1_white02_fb"] = "viewmodel_horse1_white02_fb";
}

get_explosive_death_horse() {
  if(!isDefined(level.explosive_death_index)) {
    level.horse_deaths_explosive = array_randomize(level.horse_deaths_explosive);
    level.explosive_death_index = 0;
  } else {
    level.explosive_death_index++;

    if(level.explosive_death_index == level.horse_deaths_explosive.size) {
      level.horse_deaths_explosive = array_randomize(level.horse_deaths_explosive);
      level.explosive_death_index = 0;
    }
  }

  death_anim = level.horse_deaths_explosive[level.explosive_death_index].animation;
  return death_anim;
}

get_explosive_death_ai() {
  if(isDefined(level.explosive_death_index)) {
    death_anim = level.horse_deaths_explosive[level.explosive_death_index].ai_animation;
    return death_anim;
  }
}

unload_groups() {
  unload_groups = [];
  unload_groups["all"] = [];
  unload_groups["driver"] = [];
  group = "all";
  unload_groups[group][unload_groups[group].size] = 0;
  group = "driver";
  unload_groups[group][unload_groups[group].size] = 0;
}

precache_fx() {
  level._effect["player_wind"] = loadfx("bio/animals/fx_horse_riding_wind");
}

set_wind_effect(fx_name) {
  assert(isDefined(fx_name), "Please specify an fx name.");
  level._effect["player_wind"] = loadfx(fx_name);
}

set_visionset_idle(visionset_name, visionset_fade) {
  assert(isDefined(visionset_name), "Please specify a vision set name.");
  assert(isDefined(visionset_fade), "Please specify a vision set fade time.");
  self.visionset_idle = visionset_name;
  self.visionset_idle_fade = visionset_fade;
}

set_visionset_run(visionset_name, visionset_fade) {
  assert(isDefined(visionset_name), "Please specify a vision set name.");
  assert(isDefined(visionset_fade), "Please specify a vision set fade time.");
  self.visionset_run = visionset_name;
  self.visionset_run_fade = visionset_fade;
}

scale_wait(x1, x2, y1, y2, z) {
  if(z < x1)
    z = x1;

  if(z > x2)
    z = x2;

  dx = x2 - x1;
  n = (z - x1) / dx;
  dy = y2 - y1;
  w = n * dy + y1;
  return w;
}

get_wait() {
  speed = self getspeedmph();
  abs_speed = abs(int(speed));
  wait_time = scale_wait(1, 50, 0.2, 0.088, abs_speed);
  return wait_time;
}

gallop_driving() {
  self endon("death");
  self endon("no_driver");

  while(true) {
    if(abs(self getspeed()) < 0.1)
      wait 0.01;
    else if(abs(self getspeed()) >= 0.1) {
      if(self getspeedmph() < 22) {
        if(!self.isjumping)
          self playsound("fly_horse_hoofhit_t_plr_01");

        wait(self get_wait() * 1.3);

        if(!self.isjumping)
          self playsound("fly_horse_hoofhit_t_plr_02");

        wait(self get_wait() * 1.3);

        if(!self.isjumping)
          self playsound("fly_horse_hoofhit_t_plr_03");

        wait(self get_wait() * 1.3);
      } else if(self getspeedmph() >= 22) {
        if(!self.isjumping)
          self playsound("fly_horse_hoofhit_g_plr_01");

        wait(self get_wait());

        if(!self.isjumping)
          self playsound("fly_horse_hoofhit_g_plr_02");

        wait(self get_wait());

        if(!self.isjumping)
          self playsound("fly_gear_run_plr");

        if(!self.isjumping)
          self playsound("fly_horse_hoofhit_g_plr_03");

        wait(self get_wait() * 2);
      }
    }
  }
}

wind_driving() {
  self endon("death");
  self endon("no_driver");
  player_offset = vectorscale((0, 0, 1), 56.0);

  while(true) {
    while(self getspeedmph() >= self.speed_run) {
      playfx(level._effect["player_wind"], self.driver.origin + player_offset);
      wait 0.3;
    }

    wait 0.05;
  }
}

horse_breathing() {
  self endon("death");

  while(true) {
    speed = self getspeedmph();

    if(speed <= self.speed_idle)
      speed = 1;

    wait_time = 1.5 / speed;
    wait(wait_time);
    self veh_toggle_exhaust_fx(1);

    if(wait_time >= 1.5)
      self.soundsnout playsound("chr_horse_breath_i_mono");
    else if(wait_time < 1.5)
      self.soundsnout playsound("chr_horse_breath_t_mono");

    wait 1;
    self veh_toggle_exhaust_fx(0);
  }
}

#using_animtree("horse");

update_idle_anim() {
  if(self.current_anim_speed != level.idle)
    self.idle_state = 0;

  if(self.current_anim_speed != level.idle || gettime() >= self.idle_end_time) {
    if(self.current_anim_speed == level.idle)
      self.idle_state = self.idle_anim_finished_state;

    idle_struct = level.horse_idles[self.idle_state];
    anim_index = randomint(idle_struct.animations.size);
    driver = self get_driver();

    if(isDefined(driver)) {
      if(!isai(driver)) {
        if(randomint(100) > 50)
          idle_struct = level.horse_idles[0];
        else
          idle_struct = level.horse_idles[3];

        anim_index = 0;
      }
    }

    if(is_true(self.is_panic)) {
      idle_struct = level.horse_idles[4];
      anim_index = randomint(idle_struct.animations.size);
    }

    idle_anim = idle_struct.animations[anim_index];
    idle_ai_anim = idle_struct.ai_animations[anim_index];
    idle_player_anim = idle_struct.player_animations[anim_index];

    if(isDefined(idle_struct.transitions[anim_index]))
      self.idle_anim_finished_state = idle_struct.transitions[anim_index];
    else
      self.idle_anim_finished_state = self.idle_state;

    self.idle_end_time = gettime() + getanimlength(idle_anim) * 1000;
    self.current_anim = idle_anim;
    self.rider_nextanimation = idle_ai_anim;
    self setanimknoballrestart(idle_anim, % root, 1, 0.2, 1);

    if(isDefined(driver) && isDefined(driver.update_idle_anim))
      driver[[driver.update_idle_anim]](idle_struct, anim_index);
  }

  self.current_anim_speed = level.idle;
}

horse_rearback() {
  self endon("death");
  self ent_flag_set("pause_animation");
  driver = self get_driver();

  if(isDefined(driver) && isDefined(driver.update_rearback_anim))
    driver thread[[driver.update_rearback_anim]](self);

  self setanimknoballrestart(level.horse_anims[level.rearback], % root, 1, 0.2, 1);
  len = getanimlength(level.horse_anims[level.rearback]);
  wait(len);
  self.idle_end_time = gettime();
  self ent_flag_clear("pause_animation");
}

play_horse_anim(animname) {
  self endon("death");
  self setanimknoball(animname, % root, 1, 0.2, 1);
  wait(getanimlength(animname));
}

horse_panic() {
  self.is_panic = 1;
  self notify("panic");
}

horse_stop() {
  self endon("death");
  self ent_flag_set("pause_animation");
  driver = self get_driver();

  if(isDefined(driver) && isDefined(driver.update_stop_anim))
    driver thread[[driver.update_stop_anim]]();

  stop_in = % a_horse_short_stop_init;
  stop_out = % a_horse_short_stop_finish;
  self play_horse_anim(stop_in);
  self play_horse_anim(stop_out);
  self.idle_end_time = gettime();
  self ent_flag_clear("pause_animation");
}

horse_animating() {
  self endon("death");
  wait 0.5;
  self.idle_end_time = 0;
  level.loco_idle = 0;
  level.loco_trans = 1;
  level.loco_motion = 2;
  self.state_loco = level.loco_idle;

  if(getdvarint(#"_id_92A3625D") == 0)
    setdvarint("scr_horse_speed", 0);

  while(true) {
    speed = self getspeedmph();
    angular_velocity = self getangularvelocity();
    turning_speed = abs(angular_velocity[2]);

    if(getdvarint(#"_id_92A3625D") > 0)
      speed = getdvarint(#"_id_92A3625D");

    if(isDefined(self.horse_animating_override)) {
      self thread[[self.horse_animating_override]]();
      return;
    }

    if(isDefined(self.current_anim)) {
      self.current_time = self getanimtime(self.current_anim);

      if(self.current_time > 1)
        self.current_time = 0;
    }

    if(self.ent_flag["mounting_horse"] || self.ent_flag["dismounting_horse"] || self.ent_flag["playing_scripted_anim"] || self.ent_flag["pause_animation"]) {
    } else if(speed < -0.05) {
      self.current_anim_speed = level.reverse;
      anim_rate = speed / level.horse_speeds[self.current_anim_speed];
      anim_rate = clamp(anim_rate, 0.5, 1.5);
      self.current_anim = level.horse_anims[level.reverse];
      self setanimknoball(level.horse_anims[level.reverse], % root, 1, 0.2, anim_rate);
      driver = self get_driver();

      if(isDefined(driver) && isDefined(driver.update_reverse_anim))
        driver[[driver.update_reverse_anim]](anim_rate);
    } else if(speed < 2 && turning_speed > 0.2) {
      anim_rate = turning_speed;
      anim_index = 1;

      if(angular_velocity[2] <= 0)
        anim_index = 2;

      self.current_anim = level.horse_anims[level.idle][anim_index];
      self setanimknoball(level.horse_anims[level.idle][anim_index], % root, 1, 0.2, anim_rate);
      driver = self get_driver();

      if(isDefined(driver) && isDefined(driver.update_turn_anim))
        driver[[driver.update_turn_anim]](anim_rate, anim_index);

      self.current_anim_speed = level.idle;
      self.idle_end_time = 0;
    } else if(speed < 0.05) {
      self.state_loco = level.loco_idle;
      update_idle_anim();
    } else {
      self.state_loco = level.loco_motion;
      self update_run_anim(speed);
    }

    wait 0.05;
  }
}

update_run_anim(speed) {
  next_anim_delta = level.horse_speeds[self.current_anim_speed + 1] - level.horse_speeds[self.current_anim_speed];
  next_anim_speed = level.horse_speeds[self.current_anim_speed] + next_anim_delta * 0.6;
  prev_anim_delta = level.horse_speeds[self.current_anim_speed] - level.horse_speeds[self.current_anim_speed - 1];
  prev_anim_speed = level.horse_speeds[self.current_anim_speed] - prev_anim_delta * 0.6;

  if(speed > next_anim_speed)
    self.current_anim_speed++;
  else if(speed < prev_anim_speed)
    self.current_anim_speed--;

  if(self.current_anim_speed <= level.idle)
    self.current_anim_speed = level.walk;

  anim_rate = speed / level.horse_speeds[self.current_anim_speed];
  anim_rate = clamp(anim_rate, 0.5, 1.35);
  self.current_anim = level.horse_anims[self.current_anim_speed][0];

  if(self.current_anim_speed == level.sprint && isDefined(self.sprint_anim))
    self.current_anim = self.sprint_anim;

  self setanimknoball(self.current_anim, get_horse_root(), 1, 0.2, anim_rate);
  driver = self get_driver();

  if(isDefined(driver) && isDefined(driver.update_run_anim))
    driver[[driver.update_run_anim]](anim_rate, self);
}

update_horse_fx(speed) {
  if(!isDefined(self.current_fx_speed))
    self.current_fx_speed = speed;
  else if(self.current_fx_speed == speed)
    return;
  else
    self.current_fx_speed = speed;

  player = get_players()[0];

  if(speed == level.trot)
    player thread horse_fx("player_dust_riding_trot");
  else if(speed == level.run || speed == level.sprint)
    player thread horse_fx("player_dust_riding_gallup");
  else
    player thread horse_fx();
}

horse_fx(fx_name) {
  if(isDefined(self.current_fx)) {
    self.current_fx unlink();
    self.current_fx delete();
  }

  if(isDefined(fx_name)) {
    self.current_fx = spawn("script_model", self.origin);
    self.current_fx.angles = self.angles;
    self.current_fx linkto(self);
    self.current_fx setmodel("tag_origin");
    playfxontag(level._effect[fx_name], self.current_fx, "tag_origin");
  }
}

horse_death() {
  self.script_crashtypeoverride = "horse";
  self.ignore_death_jolt = 1;
  self notsolid();
  self setvehicleavoidance(0);

  if(is_true(self.delete_on_death)) {
    return;
  }
  self.dontfreeme = 1;
  death_anim = undefined;
  death_ai_anim = undefined;

  if(isDefined(self.current_anim_speed)) {
    if(self.current_anim_speed == level.idle) {
      if(randomintrange(1, 100) < 50) {
        death_anim = level.horse_deaths[2].animation;
        death_ai_anim = level.horse_deaths[2].ai_animation;
      } else {
        death_anim = level.horse_deaths[3].animation;
        death_ai_anim = level.horse_deaths[3].ai_animation;
      }
    } else if(self.current_anim_speed < level.sprint) {
      death_anim = get_explosive_death_horse();
      death_ai_anim = get_explosive_death_ai();
    } else {
      death_anim = get_explosive_death_horse();
      death_ai_anim = get_explosive_death_ai();
    }
  }

  if(isDefined(self.death_anim))
    death_anim = self.death_anim;

  if(isDefined(death_anim)) {
    self setflaggedanimknoball("horse_death", death_anim, % root, 1, 0.2, 1);
    driver = self get_driver();

    if(isDefined(driver)) {
      if(isai(driver))
        driver.explosion_death_override = death_ai_anim;
    }

    self animscripts\shared::donotetracks("horse_death", ::handle_horse_death_fx);
    self waittillmatch("horse_death", "stop");

    if(self.classname == "script_vehicle")
      self vehicle_setspeed(0, 25, "Dead");
  }

  self.dontfreeme = undefined;
}

handle_horse_death_fx(str_notetrack) {
  if(str_notetrack == "hitground")
    playfx(level._effect["horse_hits_ground"], self.origin);
}

weapon_needs_left_hand_on_horse(weapon) {
  if(issubstr(weapon, "+tacknife"))
    return true;

  if(issubstr(weapon, "+"))
    weapon = strtok(weapon, "+")[0];

  switch (weapon) {
    case "870mcs_sp":
    case "ballista_sp":
    case "barretm82_sp":
    case "dsr50_sp":
    case "hatchet_80s_sp":
    case "hatchet_sp":
    case "judge_sp":
    case "knife_ballistic_80s_sp":
    case "knife_ballistic_sp":
    case "ksg_sp":
    case "minigun_80s_sp":
    case "minigun_sp":
    case "riotshield_sp":
    case "satchel_charge_80s_sp":
    case "satchel_charge_sp":
    case "spas_sp":
      return true;
    default:
      return false;
  }

  return false;
}

watch_for_weapon_switch_left_hand(driver) {
  self endon("death");
  self endon("no_driver");
  driver.body endon("stop_player_ride");

  while(true) {
    driver waittill("weapon_change", new_weapon, old_weapon);
    needs_left = weapon_needs_left_hand_on_horse(new_weapon);
    driver update_view_hands(!needs_left);

    if(needs_left)
      self.driver.body hide();
    else
      self.driver.body show();
  }
}

sprint_start(driver) {
  self.is_boosting = 1;
  driver disableweapons();
  self.needs_sprint_release = 1;
}

sprint_end(driver) {
  self.is_boosting = 0;
  self.needs_sprint_release = 1;
  driver enableweapons();
}

horse_turn180() {
  self endon("death");
  self setbrake(1);
  self horse_waittill_no_roll();
  self ent_flag_set("pause_animation");
  driver = self get_driver();

  if(isDefined(driver) && isDefined(driver.update_turn180_anim))
    driver thread[[driver.update_turn180_anim]](self);

  self animscripted("horse_180turn", self.origin, self.angles, level.horse_anims[level.turn_180]);
  len = getanimlength(level.horse_anims[level.turn_180]);
  wait(len);
  self.idle_end_time = gettime();
  self ent_flag_clear("pause_animation");
  self setbrake(0);
}

waitch_for_180turn(driver) {
  self endon("death");
  self endon("no_driver");

  while(true) {
    if(driver jumpbuttonpressed())
      self horse_turn180();
    else
      wait 0.05;
  }
}

watch_for_rolled_over(driver) {
  self endon("death");
  self endon("no_driver");

  while(isDefined(driver)) {
    if(abs(self.angles[2]) > 55)
      driver dodamage(50, self.origin);

    wait 0.1;
  }
}

watch_for_sprint(driver) {
  self endon("death");
  self endon("no_driver");
  self.max_speed = self getmaxspeed() / 17.6;
  self.max_sprint_speed = self.max_speed * 1.5;
  self.min_sprint_speed = self.max_speed * 0.65;
  self.min_sprint_start_speed = self.max_speed * 0.8;
  self.sprint_meter = 100;
  self.sprint_meter_max = 100;
  self.sprint_meter_min = self.sprint_meter_max * 0.25;
  self.sprint_time = 20;
  self.sprint_recover_time = 10;
  self.is_boosting = 0;
  self.needs_sprint_release = 0;
  bpressingsprint = 0;
  bmeterempty = 0;
  sprint_drain_rate = self.sprint_meter_max / self.sprint_time;
  sprint_recover_rate = self.sprint_meter_max / self.sprint_recover_time;

  while(true) {
    speed = self getspeedmph();
    forward = anglestoforward(self.angles);
    stick = driver getnormalizedmovement();
    bcanstartsprint = bmeterempty == 0 && speed > self.min_sprint_start_speed && stick[0] > 0.85;
    bpressingsprint = self.driver sprintbuttonpressed();

    if(is_true(self.needs_sprint_release)) {
      if(!bpressingsprint)
        self.needs_sprint_release = 0;
    }

    if(bcanstartsprint && bpressingsprint && is_sprint_allowed() && !self.is_boosting && !self.needs_sprint_release)
      self sprint_start(driver);

    if(self.is_boosting) {
      if(!is_true(level.horse_sprint_unlimited))
        self.sprint_meter = self.sprint_meter - sprint_drain_rate * 0.05;

      throttle = self getthrottle();

      if(self.sprint_meter < 0) {
        self.sprint_meter = 0;
        bmeterempty = 1;
        self sprint_end(driver);
      } else if(throttle < 0.3 || self.driver attackbuttonpressed() || speed < self.min_sprint_speed || self.driver adsbuttonpressed() || self.driver changeseatbuttonpressed() || absangleclamp180(self.driver getplayerangles()[1] - self.angles[1]) > 60 || !self.needs_sprint_release && bpressingsprint) {
        if(self.driver changeseatbuttonpressed())
          wait 0.1;

        self sprint_end(driver);
      } else {
        self setvehmaxspeed(self.max_sprint_speed);

        if(speed < self.max_sprint_speed)
          self launchvehicle(forward * 160 * 0.05);
      }
    } else {
      if(!is_true(level.horse_sprint_unlimited))
        self.sprint_meter = self.sprint_meter + sprint_recover_rate * 0.05;

      if(bmeterempty) {
        if(self.sprint_meter > self.sprint_meter_min)
          bmeterempty = 0;
      }

      if(self.sprint_meter > self.sprint_meter_max)
        self.sprint_meter = self.sprint_meter_max;

      if(isDefined(level.horse_override_max_speed)) {
        self setvehmaxspeed(level.horse_override_max_speed);

        if(speed > level.horse_override_max_speed)
          self launchvehicle(forward * -80 * 0.05);
      } else {
        max_speed = self.max_speed;
        self setvehmaxspeed(max_speed);

        if(driver playerads() > 0.3) {
          max_speed = max_speed * 0.65;

          if(speed > max_speed + 2)
            self setvehmaxspeed(self.max_speed * 0.8);
        }

        if(speed > max_speed)
          self launchvehicle(forward * -80 * 0.05);
      }
    }

    wait 0.05;
  }
}

is_sprint_allowed() {
  if(isDefined(level.horse_allow_sprint))
    return level.horse_allow_sprint;
  else
    return 1;
}

allow_horse_sprint(b_allow_sprint) {
  assert(isDefined(b_allow_sprint), "Must pass in a value for allow_horse_sprint()");
  level.horse_allow_sprint = b_allow_sprint;
}

override_player_horse_speed(n_speed) {
  level.horse_override_max_speed = n_speed;
}

use_horse(user) {
  self.disable_grenade_dismount_check = 1;
  self notify("trigger", user);
}

delay_body() {
  self endon("death");
  wait 0.1;
  self.driver.body show();
}

horse_waittill_no_roll() {
  for(max_time = 1; max_time > 0; max_time = max_time - 0.05) {
    if(abs(self.angles[2]) < 5) {
      break;
    }

    wait 0.05;
  }
}

horse_is_exit_position_ok() {
  right = anglestoright(self.angles);
  start = self.origin + vectorscale((0, 0, 1), 15.0) + right * -10;
  end = start + right * -15;
  results = physicstraceex(start, end, vectorscale((-1, -1, 0), 14.0), (14, 14, 60), self, 1);

  if(results["fraction"] == 1)
    return true;

  start = self.origin + vectorscale((0, 0, 1), 15.0) + right * 10;
  end = start + right * 15;
  results = physicstraceex(start, end, vectorscale((-1, -1, 0), 14.0), (14, 14, 60), self, 1);

  if(results["fraction"] == 1) {
    self.dismount_right = 1;
    return true;
  }

  return false;
}

cant_dismount_hint() {
  screen_message_create(&"SCRIPT_HINT_CANT_DISMOUNT_HERE");
  wait 3;
  screen_message_delete();
}

watch_mounting() {
  self endon("death");
  flag_wait("all_players_connected");

  if(!self.disable_make_useable)
    self makevehicleusable();

  self setvehicleavoidance(1, undefined, 1);
  self.ignore_death_jolt = 1;

  while(true) {
    self waittill("trigger", useent);

    if(!isplayer(useent)) {
      continue;
    }
    self setvehicleavoidance(1, undefined, 2);

    while(true) {
      if(!useent isswitchingweapons()) {
        break;
      }

      wait 0.05;
    }

    self.driver = useent;
    self.driver set_mount_direction(self, self.driver.origin);
    self.driver allowjump(0);
    self notsolid();
    self clearvehgoalpos();
    self cancelaimove();
    need_left_hand = weapon_needs_left_hand_on_horse(self.driver getcurrentweapon());
    self.driver update_view_hands(!need_left_hand);

    if(is_true(self.disable_mount_anim)) {
      println("horse mounting anim disabled");

      if(!self.disable_weapon_changes)
        self.driver disableweapons();

      self.driver.body unlink();

      if(!self.disable_weapon_changes)
        self.driver enableweapons();

      mount_anim = level.horse_player_anims[10][self.driver.side];
      org = getstartorigin(self.origin, self.angles, mount_anim);
      angles = self.angles;
      delta = getcycleoriginoffset(angles, mount_anim);
      self.driver.body.origin = org + delta;
      self.driver.body.angles = angles;
      self.driver.body linkto(self, "tag_origin");
      self thread horse_update_reigns(1);
    } else {
      self.driver.is_on_horse = 0;
      self.driver mount(self);
    }

    if(need_left_hand)
      self.driver.body hide();
    else
      self.driver.body show();

    self makevehicleusable();
    self useby(self.driver);
    wait 0.1;
    self.driver setplayerviewratescale(120);
    self solid();
    self thread watch_for_sprint(self.driver);
    self thread watch_for_rolled_over(self.driver);
    self thread watch_for_weapon_switch_left_hand(self.driver);
    self.idle_end_time = 0;
    self thread horse_fx();

    if(is_true(self.disable_mount_anim))
      self thread delay_body();

    if(!self.disable_make_useable)
      self makevehicleusable();

    while(true) {
      self waittill("trigger", useent);

      if(useent == self.driver && self.dismount_enabled && (!self.driver isthrowinggrenade() || isDefined(self.disable_grenade_dismount_check))) {
        self setbrake(1);
        self horse_waittill_no_roll();
        self.dismount_right = undefined;

        if(self horse_is_exit_position_ok()) {
          break;
        } else {
          level thread cant_dismount_hint();
          wait 0.05;
          self notify("cant_dismount_here");
          self setbrake(0);
        }
      }
    }

    self.being_dismounted = 1;

    if(is_true(self.is_boosting)) {
      self sprint_end(self.driver);
      wait_network_frame();
    }

    self.disable_grenade_dismount_check = undefined;
    self.driver.body.rearback = 0;
    self.driver.body notify("stop_player_ride");
    self.driver disableweapons();

    if(is_true(self.disable_mount_anim)) {
    } else if(!self.driver isthrowinggrenade())
      self.driver waittill("weapon_change");

    self useby(self.driver);
    self.driver allowjump(1);
    self.driver resetplayerviewratescale();
    self.driver.body show();
    self.driver update_view_hands(0);

    if(is_true(self.disable_mount_anim)) {
      println("horse mounting anim disabled");

      if(!self.disable_weapon_changes)
        self.driver disableweapons();

      self.driver unlink();
      self.driver.body unlink();
      self.driver.body hide();
      self.driver.body.origin = self.driver.origin;
      self.driver.body.anlges = self.driver.angles;
      self.driver.body linkto(self.driver);
      wait_network_frame();

      if(!self.disable_weapon_changes)
        self.driver enableweapons();

      self horse_update_reigns(0);
    } else
      self.driver dismount(self);

    if(!self.disable_make_useable)
      self makevehicleusable();

    self setbrake(0);
    self notify("no_driver");
    self.driver.body.pause_animation = 0;
    self.driver = undefined;
    self.being_dismounted = 0;
  }
}

set_mount_direction(horse, mount_org) {
  horse_facing = vectornormalize(anglestoright(horse.angles));
  horse_player = mount_org - horse.origin;
  horse_player = (horse_player[0], horse_player[1], 0);
  horse_player = vectornormalize(horse_player);
  side = 0;
  dot = vectordot(horse_facing, horse_player);

  if(dot > 0)
    side = 1;

  self.side = side;
}

update_view_hands(no_left) {
  if(no_left)
    self setviewmodel(level.player_viewmodel_noleft);
  else
    self setviewmodel(level.player_viewmodel);
}

ready_horse() {
  if(is_true(level.horse_in_combat))
    self setflaggedanimknoballrestart("mount_horse", level.horse_anims[10][0], % root, 1, 0.2, 0);
  else
    self setflaggedanimknoballrestart("mount_horse", level.horse_anims[10][0], % root, 1, 0.2, 0);
}

horse_update_reigns(hide) {
  if(is_true(hide)) {
    self.old_model = self.model;
    self setmodel(level.horse_viewmodel_variants[self.model]);
  } else
    self setmodel(self.old_model);

  wait 0.1;
}

horse_wait_for_reigns(notifyname, hide) {
  self endon("death");
  self waittillmatch(notifyname, "horse_switch");
  self horse_update_reigns(hide);
}

#using_animtree("generic_human");

mount(horse) {
  horse ent_flag_set("mounting_horse");

  if(!horse.disable_weapon_changes)
    self disableweapons();

  self freezecontrols(1);

  if(self getstance() != "stand") {
    self setstance("stand");

    while(self getstance() != "stand")
      wait 0.05;
  }

  horse thread ready_horse();
  self.body unlink();
  wait 0.05;
  self.body.origin = self.origin;
  self.body.angles = self.angles;
  mount_anim = level.horse_player_anims[level.mount][self.side];

  if(is_true(level.horse_in_combat))
    mount_anim = level.horse_player_anims[10][self.side];

  self startcameratween(0.3);
  self.body setanim(mount_anim, 1, 0, 0);
  self playerlinktoabsolute(self.body, "tag_player");
  wait 0.05;
  horse_mount_anim = level.horse_anims[level.mount][self.side];

  if(is_true(level.horse_in_combat))
    horse_mount_anim = level.horse_anims[10][self.side];

  horse setflaggedanimknoballrestart("mount_horse", horse_mount_anim, % root, 1, 0, 1);
  horse thread horse_wait_for_reigns("mount_horse", 1);
  self.body animscripted("mount", horse.origin, horse.angles, mount_anim, "normal", % root, 1, 0, 0.65);
  self.body show();
  self.body waittillmatch("mount", "end");
  self.body stopanimscripted();
  self unlink();

  if(!horse.disable_weapon_changes)
    self enableweapons();

  self.body linkto(horse, "tag_origin");
  self freezecontrols(0);
  self.is_on_horse = 1;

  if(isplayer(self)) {
    self.my_horse = horse;
    self thread set_horseback_melee_values();
  }

  horse ent_flag_clear("mounting_horse");
}

#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("player");

dismount(horse) {
  horse ent_flag_set("dismounting_horse");

  if(self.health <= 0) {
    return;
  }
  if(!horse.disable_weapon_changes)
    self disableweapons();

  self startcameratween(0.1);
  self playerlinktoabsolute(self.body, "tag_player");

  if(is_true(level.horse_in_combat)) {
    if(isDefined(horse.dismount_right))
      horse_dismount_anim = level.horse_anims[11][1];
    else
      horse_dismount_anim = level.horse_anims[11][0];
  } else if(isDefined(horse.dismount_right))
    horse_dismount_anim = level.horse_anims[level.dismount][1];
  else
    horse_dismount_anim = level.horse_anims[level.dismount][0];

  horse setflaggedanimknoball("horse_dismount", horse_dismount_anim, % root, 1, 0.2, 1);
  horse thread horse_wait_for_reigns("horse_dismount", 0);

  if(is_true(level.horse_in_combat)) {
    if(isDefined(horse.dismount_right))
      player_dismount_anim = level.horse_player_anims[11][1];
    else
      player_dismount_anim = level.horse_player_anims[11][0];
  } else if(isDefined(horse.dismount_right))
    player_dismount_anim = level.horse_player_anims[level.dismount][1];
  else
    player_dismount_anim = level.horse_player_anims[level.dismount][0];

  level.dismount_time = gettime();
  self.body animscripted("dismount", horse.origin, horse.angles, player_dismount_anim, "normal", % root, 1, 0.2);
  self.body waittillmatch("dismount", "unlink");
  self.body unlink();
  self.body waittillmatch("dismount", "end");
  self.body stopanimscripted();
  horse notsolid();
  self unlink();
  self showviewmodel();
  self enableweapons();
  self.body unlink();
  self.body hide();
  self.body.origin = self.origin;
  self.body.angles = self.angles;
  self.body linkto(self);
  self.body clearanim( % root, 0);
  horse solid();
  horse makevehicleusable();
  self.is_on_horse = 0;

  if(isplayer(self)) {
    self thread reset_player_melee_values();
    self.my_horse = undefined;
  }

  horse ent_flag_clear("dismounting_horse");
}

get_driver() {
  if(isDefined(self.driver) && isDefined(self.driver.body))
    return self.driver.body;
  else if(isDefined(self.riders) && self.riders.size > 0 && (!isDefined(self.unloadque) || self.unloadque.size == 0))
    return self.riders[0];

  return undefined;
}

is_on_horseback() {
  if(!isDefined(self.is_on_horse))
    return 0;

  return self.is_on_horse;
}

watch_for_horse_melee(horse) {
  while(true) {
    if(level.player meleebuttonpressed()) {
    }

    wait 0.05;
  }
}

set_horseback_melee_values() {
  setsaveddvar("player_meleerange", 110);
  setsaveddvar("player_meleeheight", 100);
  setsaveddvar("player_meleewidth", 100);
}

reset_player_melee_values() {
  setsaveddvar("player_meleerange", 64);
  setsaveddvar("player_meleeheight", 10);
  setsaveddvar("player_meleewidth", 10);
}

#using_animtree("generic_human");

get_generic_human_root() {
  return % root;
}

#using_animtree("horse");

get_horse_root() {
  return % root;
}

#using_animtree("generic_human");
#using_animtree("horse");
#using_animtree("generic_human");
#using_animtree("horse");
#using_animtree("generic_human");

setanims() {
  positions = [];

  for(i = 0; i < 1; i++)
    positions[i] = spawnstruct();

  positions[0].sittag = "tag_driver";
  positions[0].getin = % ai_horse_rider_get_on_leftside;
  positions[0].vehicle_getinanim = % a_horse_get_on_leftside;
  positions[0].getout = % ai_horse_rider_get_off_leftside;
  positions[0].vehicle_getoutanim = % a_horse_get_on_rightside;
  positions[0].explosion_death = % ai_horse_rider_sprint_explosive_death_fly_forward_a;
  return positions;
}

#using_animtree("horse");
#using_animtree("generic_human");

set_horse_in_combat(is_combat) {
  level.horse_in_combat = is_combat;
  wait 0.5;

  if(is_combat) {
    level.vehicle_aianims["horse"][0].getin = % ai_horse_rider_get_on_combat_leftside;
    level.vehicle_aianims["horse"][0].getout = % ai_horse_rider_get_off_combat_leftside;
    level.vehicle_aianims["horse_player"][0].getin = % ai_horse_rider_get_on_combat_leftside;
    level.vehicle_aianims["horse_player"][0].getout = % ai_horse_rider_get_off_combat_leftside;
    level.vehicle_aianims["horse_low"][0].getin = % ai_horse_rider_get_on_combat_leftside;
    level.vehicle_aianims["horse_low"][0].getout = % ai_horse_rider_get_off_combat_leftside;
    level.vehicle_aianims["horse_player_low"][0].getin = % ai_horse_rider_get_on_combat_leftside;
    level.vehicle_aianims["horse_player_low"][0].getout = % ai_horse_rider_get_off_combat_leftside;
    level.vehicle_aianims["horse"][0].vehicle_getinanim = % a_horse_get_on_combat_leftside;
    level.vehicle_aianims["horse"][0].vehicle_getoutanim = % a_horse_get_off_combat_leftside;
    level.vehicle_aianims["horse_player"][0].vehicle_getinanim = % a_horse_get_on_combat_leftside;
    level.vehicle_aianims["horse_player"][0].vehicle_getoutanim = % a_horse_get_off_combat_leftside;
    level.vehicle_aianims["horse_low"][0].vehicle_getinanim = % a_horse_get_on_combat_leftside;
    level.vehicle_aianims["horse_low"][0].vehicle_getoutanim = % a_horse_get_off_combat_leftside;
    level.vehicle_aianims["horse_player_low"][0].vehicle_getinanim = % a_horse_get_on_combat_leftside;
    level.vehicle_aianims["horse_player_low"][0].vehicle_getoutanim = % a_horse_get_off_combat_leftside;
  } else {
    level.vehicle_aianims["horse"][0].getin = % ai_horse_rider_get_on_leftside;
    level.vehicle_aianims["horse"][0].getout = % ai_horse_rider_get_off_leftside;
    level.vehicle_aianims["horse_player"][0].getin = % ai_horse_rider_get_on_leftside;
    level.vehicle_aianims["horse_player"][0].getout = % ai_horse_rider_get_off_leftside;
    level.vehicle_aianims["horse_low"][0].getin = % ai_horse_rider_get_on_leftside;
    level.vehicle_aianims["horse_low"][0].getout = % ai_horse_rider_get_off_leftside;
    level.vehicle_aianims["horse_player_low"][0].getin = % ai_horse_rider_get_on_leftside;
    level.vehicle_aianims["horse_player_low"][0].getout = % ai_horse_rider_get_off_leftside;
  }
}

horse_actor_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(self.health > 0 && !is_true(self.magic_bullet_shield)) {
    if(isDefined(einflictor.vehicletype) && (einflictor.vehicletype == "horse_player" || einflictor.vehicletype == "horse" || einflictor.vehicletype == "horse_player_low" || einflictor.vehicletype == "horse_low") && smeansofdeath == "MOD_CRUSH") {
      bones = [];
      bones[0] = "J_SpineUpper";
      bones[1] = "J_Ankle_LE";
      bones[2] = "J_Knee_LE";
      bones[3] = "J_Head";
      bones = array_randomize(bones);
      speed = einflictor getspeedmph() * 5;
      up = randomfloatrange(0.15, 0.35);
      velocity = (vdir[0], vdir[1], up);
      velocity = velocity * speed;
      self startragdoll();
      self launchragdoll(velocity, bones[0]);
      player = getplayers()[0];
      player playrumbleonentity("damage_heavy");

      if(isplayer(eattacker)) {
        eattacker playsound("evt_horse_trample_ai");

        if(self.team == "axis" && !isDefined(self.killed_by_horse)) {
          self.killed_by_horse = 1;
          level notify("player_trampled_ai_with_horse");
        }
      }

      earthquake(0.5, 0.3, player.origin, 150);
      return self.health;
    }
  }

  return idamage;
}

horse_damage_panic() {
  self endon("death");
  self endon("panic");

  if(is_true(self.is_panic)) {
    return;
  }
  self.is_panic = 1;
  wait 12;
  self.is_panic = 0;
}

horsecallback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  self horse_damage_panic();

  if(smeansofdeath == "MOD_CRUSH") {
    driver = self getseatoccupant(0);

    if(isDefined(driver)) {
      if(abs(self.angles[2]) > 35) {
        damage = idamage;

        if(damage < 30)
          damage = 30;

        driver dodamage(damage, eattacker.origin, eattacker);
      } else if(eattacker.vehicleclass == "tank") {
        if(self istouching(eattacker)) {
          damage = idamage;
          driver dodamage(damage, eattacker.origin, eattacker);
        }
      }
    }
  }

  return idamage;
}