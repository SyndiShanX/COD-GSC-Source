/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\pigeons.gsc
***********************************************/

#using_animtree("animals");

main() {
  var_0 = spawnStruct();
  var_0.interactive_type = "pigeons";
  var_0.rig_model = "pigeon_flock_rig";
  var_0.rig_animtree = #animtree;
  var_0.rig_numtags = 12;
  var_0.bird_model["idle"] = "pigeon_iw5";
  var_0.bird_model["fly"] = "pigeon_fly_iw5";
  var_0.bird_animtree = #animtree;
  var_0.topspeed = 400;
  var_0.accn = 100;
  var_0.scareradius = 300;
  var_0.death_effect = loadfx("fx/props/chicken_exp_white");
  var_0.birdmodel_anims = [];
  var_0.rigmodel_anims = [];
  var_0.birdmodel_anims["idle"][0] = % pigeon_idle;
  var_0.birdmodel_anims["idleweight"][0] = 1;
  var_0.birdmodel_anims["idle"][1] = % pigeon_idle_twitch_1;
  var_0.birdmodel_anims["idleweight"][1] = 0.3;
  var_0.birdmodel_anims["flying"] = % pigeon_flying_cycle;
  var_0.rigmodel_anims["flying"] = % pigeon_flock_fly_loop;
  var_0.rigmodel_anims["takeoff_wire"] = % pigeon_flock_takeoff_wire;
  var_0.rigmodel_anims["land_wire"] = % pigeon_flock_land_wire;
  var_0.rigmodel_anims["takeoff_ground"] = % pigeon_flock_takeoff_ground;
  var_0.rigmodel_anims["land_ground"] = % pigeon_flock_land_ground;
  var_0.rigmodel_anims["takeoff_inpipe"] = % pigeon_flock_takeoff_inpipe;
  var_0.rigmodel_anims["land_inpipe"] = % pigeon_flock_land_inpipe;

  if(!common_scripts\utility::issp()) {
    var_0.birdmodel_anims["idlemp"][0] = "pigeon_idle";
    var_0.birdmodel_anims["idlemp"][1] = "pigeon_idle_twitch_1";
    var_0.birdmodel_anims["flyingmp"] = "pigeon_flying_cycle";
    var_0.rigmodel_anims["flyingmp"] = "pigeon_flock_fly_loop";
    var_0.rigmodel_anims["takeoff_wiremp"] = "pigeon_flock_takeoff_wire";
    var_0.rigmodel_anims["land_wiremp"] = "pigeon_flock_land_wire";
    var_0.rigmodel_anims["takeoff_groundmp"] = "pigeon_flock_takeoff_ground";
    var_0.rigmodel_anims["land_groundmp"] = "pigeon_flock_land_ground";
    var_0.rigmodel_anims["takeoff_inpipemp"] = "pigeon_flock_takeoff_inpipe";
    var_0.rigmodel_anims["land_inpipemp"] = "pigeon_flock_land_inpipe";
  }

  var_0.sounds = [];
  var_0.sounds["takeoff"] = "anml_bird_startle_flyaway";

  if(!isDefined(level._interactive))
    level._interactive = [];

  level._interactive[var_0.interactive_type] = var_0;
  thread maps\interactive_models\_birds::birds();
}