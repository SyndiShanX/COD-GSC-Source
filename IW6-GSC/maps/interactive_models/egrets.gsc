/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\egrets.gsc
**********************************************/

#using_animtree("animals");

main() {
  var_0 = spawnStruct();
  var_0.interactive_type = "egrets";
  var_0.rig_model = "pigeon_flock_rig";
  var_0.rig_animtree = #animtree;
  var_0.rig_numtags = 12;
  var_0.bird_health = 500;
  var_0.bird_model["idle"] = "bird_egret_flock";
  var_0.bird_model["fly"] = "bird_egret_flock_fly";
  var_0.bird_animtree = #animtree;
  var_1 = 0.5;
  var_0.topspeed = 500;
  var_0.accn = 130;
  var_0.scareradius = 6000;
  var_0.death_effect = loadfx("fx/props/chicken_exp_white");
  var_0.birdmodel_anims = [];
  var_0.rigmodel_anims = [];
  var_0.birdmodel_anims["idle"] = % egret_flock_idle1;
  var_0.birdmodel_anims["takeoff"] = % egret_flock_takeoff;
  var_0.birdmodel_anims["flying"] = % egret_flock_fly;
  var_0.rigmodel_anims["flying"] = % bird_flock_large_fly_loop;
  var_0.rigmodel_anims["takeoff_tree"] = % bird_flock_large_takeoff_tree;
  var_0.rigmodel_anims["land_tree"] = % bird_flock_large_land_tree;
  var_0.rigmodel_anims["takeoff_ground"] = % bird_flock_large_takeoff_ground;
  var_0.rigmodel_anims["land_ground"] = % bird_flock_large_land_ground;

  if(!common_scripts\utility::issp()) {
    var_0.birdmodel_anims["idlemp"] = "egret_flock_idle1";
    var_0.birdmodel_anims["takeoffmp"] = "egret_flock_takeoff";
    var_0.birdmodel_anims["flyingmp"] = "egret_flock_fly";
    var_0.rigmodel_anims["flyingmp"] = "bird_flock_large_fly_loop";
    var_0.rigmodel_anims["takeoff_treemp"] = "bird_flock_large_takeoff_tree";
    var_0.rigmodel_anims["land_treemp"] = "bird_flock_large_land_tree";
    var_0.rigmodel_anims["takeoff_groundmp"] = "bird_flock_large_takeoff_ground";
    var_0.rigmodel_anims["land_groundmp"] = "bird_flock_large_land_ground";
  }

  if(!isDefined(level._interactive)) {
    level._interactive = [];
  }

  level._interactive["egrets"] = var_0;
  thread maps\interactive_models\_birds::birds();
}