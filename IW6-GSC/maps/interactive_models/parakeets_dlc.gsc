/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\parakeets_dlc.gsc
*****************************************************/

#include common_scripts\utility;
#using_animtree("animals_dlc");
main() {
  info = spawnStruct();
  info.interactive_type = "parakeets_dlc";
  info.rig_model = "pigeon_flock_rig";
  info.rig_animtree = #animtree;
  info.rig_numtags = 12;
  info.bird_model["idle"] = "parakeet";
  info.bird_model["fly"] = "parakeet_fly";
  info.bird_animtree = #animtree;
  info.topSpeed = 600;
  info.accn = 150;
  info.scareRadius = 300;
  info.death_effect = LoadFX("fx/props/chicken_exp_white");
  info.birdmodel_anims = [];
  info.rigmodel_anims = [];
  info.birdmodel_anims["idle"][0] = % pigeon_idle;
  info.birdmodel_anims["idleweight"][0] = 1;
  info.birdmodel_anims["idle"][1] = % pigeon_idle_twitch_1;
  info.birdmodel_anims["idleweight"][1] = 0.3;
  info.birdmodel_anims["flying"] = % pigeon_flying_cycle;
  info.rigmodel_anims["flying"] = % pigeon_flock_fly_loop;
  info.rigmodel_anims["takeoff_wire"] = % pigeon_flock_takeoff_wire;
  info.rigmodel_anims["land_wire"] = % pigeon_flock_land_wire;
  info.rigmodel_anims["takeoff_ground"] = % pigeon_flock_takeoff_ground;
  info.rigmodel_anims["land_ground"] = % pigeon_flock_land_ground;
  info.rigmodel_anims["takeoff_inpipe"] = % pigeon_flock_takeoff_inpipe;
  info.rigmodel_anims["land_inpipe"] = % pigeon_flock_land_inpipe;
  if(!isSP()) {
    info.birdmodel_anims["idlemp"][0] = "pigeon_idle";
    info.birdmodel_anims["idlemp"][1] = "pigeon_idle_twitch_1";
    info.birdmodel_anims["flyingmp"] = "pigeon_flying_cycle";

    info.rigmodel_anims["flyingmp"] = "pigeon_flock_fly_loop_mp";
    info.rigmodel_anims["takeoff_wiremp"] = "pigeon_flock_takeoff_wire_mp";
    info.rigmodel_anims["land_wiremp"] = "pigeon_flock_land_wire_mp";
    info.rigmodel_anims["takeoff_groundmp"] = "pigeon_flock_takeoff_ground_mp";
    info.rigmodel_anims["land_groundmp"] = "pigeon_flock_land_ground_mp";
    info.rigmodel_anims["takeoff_inpipemp"] = "pigeon_flock_takeoff_inpipe_mp";
    info.rigmodel_anims["land_inpipemp"] = "pigeon_flock_land_inpipe_mp";

  }
  info.sounds = [];
  info.sounds["takeoff"] = "anml_bird_startle_flyaway";

  PreCacheModel(info.rig_model);
  foreach(model in info.bird_model) {
    PreCacheModel(model);
  }

  if(!isDefined(level._interactive))
    level._interactive = [];
  level._interactive[info.interactive_type] = info;
  thread maps\interactive_models\_birds_dlc::birds(info);
}