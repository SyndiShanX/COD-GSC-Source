/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\crows_dlc.gsc
*************************************************/

#include common_scripts\utility;
#using_animtree("animals_dlc");
main() {
  info = spawnStruct();
  info.interactive_type = "crows_dlc";
  info.rig_model = "use_radiant_model";
  info.rig_animtree = #animtree;
  info.rig_numtags = 2;
  info.bird_model["idle"] = "crow_fly";
  info.bird_model["fly"] = "crow_fly";
  info.bird_animtree = #animtree;
  info.topSpeed = 300;
  info.accn = 75;
  info.scareRadius = 600;
  info.death_effect = LoadFX("fx/props/bird_feather_exp_black");
  info.birdmodel_anims = [];
  info.rigmodel_anims = [];
  info.birdmodel_anims["idle"][0] = % crow_idle_1;
  info.birdmodel_anims["idleweight"][0] = 1;
  info.birdmodel_anims["idle"][1] = % crow_idle_2;
  info.birdmodel_anims["idleweight"][1] = 0.3;
  info.birdmodel_anims["flying"] = % crow_fly;
  info.rigmodel_anims["flying"] = % pigeon_flock_fly_loop;
  info.rigmodel_anims["takeoff_wire"] = % pigeon_flock_takeoff_wire;
  info.rigmodel_anims["land_wire"] = % pigeon_flock_land_wire;
  info.rigmodel_anims["takeoff_ground"] = % pigeon_flock_takeoff_ground;
  info.rigmodel_anims["land_ground"] = % pigeon_flock_land_ground;
  info.rigmodel_anims["takeoff_inpipe"] = % pigeon_flock_takeoff_inpipe;
  info.rigmodel_anims["land_inpipe"] = % pigeon_flock_land_inpipe;
  if(!isSP()) {
    info.birdmodel_anims["idlemp"][0] = "crow_idle_1";
    info.birdmodel_anims["idlemp"][1] = "crow_idle_2";
    info.birdmodel_anims["flyingmp"] = "crow_fly";

    info.rigmodel_anims["flyingmp"] = "pigeon_flock_fly_loop_mp";
    info.rigmodel_anims["takeoff_wiremp"] = "pigeon_flock_takeoff_wire_mp";
    info.rigmodel_anims["land_wiremp"] = "pigeon_flock_land_wire_mp";
    info.rigmodel_anims["takeoff_groundmp"] = "pigeon_flock_takeoff_ground_mp";
    info.rigmodel_anims["land_groundmp"] = "pigeon_flock_land_ground_mp";
    info.rigmodel_anims["takeoff_inpipemp"] = "pigeon_flock_takeoff_inpipe_mp";
    info.rigmodel_anims["land_inpipemp"] = "pigeon_flock_land_inpipe_mp";

  }
  info.sounds = [];
  info.sounds["takeoff"] = "anml_crow_startle_flyaway";
  info.sounds["idle"] = "anml_crow_idle";

  PreCacheModel(info.rig_model);
  foreach(model in info.bird_model) {
    PreCacheModel(model);
  }

  if(!isDefined(level._interactive)) {
    level._interactive = [];
  }
  level._interactive[info.interactive_type] = info;
  thread maps\interactive_models\_birds_dlc::birds(info);
}