/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\fish_school_snapper.gsc
***********************************************************/

#using_animtree("animals");

main() {
  var_0 = spawnStruct();
  var_0.name = "fish_school_snapper";
  var_0.targetname = "interactive_fish_school_snapper";
  var_0.piece = spawnStruct();
  var_0.piece.model = "sardines_flocking_rig";
  var_0.piece.tagprefix = "tag_attach";
  var_0.piece.maxturn = 5;
  var_0.piece.animtree = #animtree;
  var_0.piece.anims = [];
  var_0.piece.anims["idle_loop"] = % sardines_flock_loop;
  var_0.piece.anims["add_bend_left"] = % sardines_flock_add_left60;
  var_0.piece.anims["add_bend_right"] = % sardines_flock_add_right60;
  var_0.piece.anims["add_fast"] = % sardines_flock_add_stretch_horiz;
  var_0.piece.anims["add_tilt_left"] = % sardines_flock_add_tilt_left_add;
  var_0.piece.anims["add_tilt_right"] = % sardines_flock_add_tilt_right_add;
  var_0.piece.anims["add_tilt_left_child"] = % sardines_flock_add_tilt_left;
  var_0.piece.anims["add_tilt_right_child"] = % sardines_flock_add_tilt_right;
  var_0.piece.anims["add_rotate_left"] = % sardines_flock_add_rotate_left_add;
  var_0.piece.anims["add_rotate_left_child"] = % sardines_flock_add_rotate_left;
  var_0.piece.anims["add_rotate_right"] = % sardines_flock_add_rotate_right_add;
  var_0.piece.anims["add_rotate_right_child"] = % sardines_flock_add_rotate_right;
  var_0.fish = spawnStruct();
  var_0.fish.model = [];
  var_0.fish.model[1]["bright"] = "fish_emperorsnapper_rigid";
  var_0.fish.model[2]["bright"] = "fish_emperorsnapper_rigid";
  var_0.fish.model[2]["grey1"] = "fish_emperorsnapper_rigid";
  var_0.fish.model[2]["grey2"] = "fish_emperorsnapper_rigid";
  var_0.fish.model[3]["bright"] = "fish_emperorsnapper_rigid";
  var_0.fish.model[3]["grey1"] = "fish_emperorsnapper_rigid";
  var_0.fish.model[3]["grey2"] = "fish_emperorsnapper_rigid";
  var_0.fish.anims = [];
  var_0.fish.anims["idle_loop"] = % sardines_smallgroup_loop1;
  var_0.ball = spawnStruct();
  var_0.ball.rotationperiod = 5;
  var_0.ball.numtags = 16;
  var_0.ball.relocatespeed = 30;
  var_0.ball.reactdistance = 300;
  var_0.ball.panicdistance = 150;
  var_0.ball.maxdriftdist = 150;
  var_0.ball.driftspeed = 10;
  var_0.ball.ringvertoffset = 48;
  var_0.ball.rings = [];
  var_0.ball.rings[0] = spawnStruct();
  var_0.ball.rings[0].numpieces = 6;
  var_0.ball.rings[0].radius = 64;
  var_0.ball.rings[0].offset = -1 * var_0.ball.ringvertoffset;
  var_0.ball.rings[1] = spawnStruct();
  var_0.ball.rings[1].numpieces = 6;
  var_0.ball.rings[1].radius = 96;
  var_0.ball.rings[1].offset = -1 * var_0.ball.ringvertoffset;
  var_0.ball.rings[2] = spawnStruct();
  var_0.ball.rings[2].numpieces = 6;
  var_0.ball.rings[2].radius = 64;
  var_0.ball.rings[2].offset = var_0.ball.ringvertoffset;
  var_0.ball.rings[3] = spawnStruct();
  var_0.ball.rings[3].numpieces = 6;
  var_0.ball.rings[3].radius = 96;
  var_0.ball.rings[3].offset = var_0.ball.ringvertoffset;
  var_0.line = spawnStruct();
  var_0.line.spacing = 3;
  var_0.line.anims = [];
  var_0.line.anim_base = % sardines_flock_spin;
  var_0.line.anims[0] = % sardines_flock_spinloop;
  var_0.line.anims[1] = % sardines_flock_spinloop_fast;
  var_0.line.anims[2] = % sardines_flock_spinloop_faster;
  var_0.line.animspeeds[0] = 17.6;
  var_0.line.animspeeds[1] = 26.4;
  var_0.line.animspeeds[2] = 52.8;
  var_0.line.animoffset = 0.28;
  var_0.line.taper = 8;
  var_0.line.tagmodels = [];
  var_0.line.tagmodels["1"] = 5;
  var_0.line.tagmodels["4"] = 3;
  var_0.line.tagmodels["7"] = 3;
  var_0.line.tagmodels["10"] = 2;
  var_0.line.tagmodels["13"] = 2;
  var_0.line.tagmodels["16"] = 2;
  var_0.line.tagmodels["19"] = 1;
  var_0.line.tagmodels["22"] = 1;
  var_0.line.tagmodels["25"] = 1;
  var_0.line.tagmodels["28"] = 1;
  var_0.line.tagmodels["31"] = 1;

  if(!isDefined(level._interactive)) {
    level._interactive = [];
  }

  level._interactive["fish_school_snapper"] = var_0;
  thread maps\interactive_models\fish_school_sardines::sardines(var_0);
}