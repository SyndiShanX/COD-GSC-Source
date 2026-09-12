/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_ladder.gsc
***********************************************/

function register_ladder_interactions() {}

function ladder_hint_func(var_0, var_1) {
  var_2 = &"COOP_CRAFTING/PLACE_LADDER";
  return var_2;
}

function ladder_activate_func(var_0, var_1) {
  if(placeladder(var_0, var_1)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    return;
  }
}

function ladder_init_func(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "dynamicLadder") {
      script_model_anims();
      var_3 = scripts\engine\utility::drop_to_ground(var_2.origin, 50, -200);
      var_2.scenenode = spawn("script_origin", var_3);
      var_2.scenenode.angles = (0, var_2.angles[1], 0);
      var_4 = spawnStruct();
      add_dynamicladder(var_4, var_2);

      if(!isDefined(level.dynamicladders)) {
        level.dynamicladders = [];
      }

      level.dynamicladders[level.dynamicladders.size] = var_4;

      if(abs(var_3[2] - var_4.ents[0].origin[2]) > 32) {
        var_2.ishighladder = 1;
      }

      if(isDefined(var_4.ents) && isDefined(var_4.ents[var_4.ents.size - 1])) {
        var_4.ents[var_4.ents.size - 1].origin -= (0, 5000, 0);
      }
    }
  }
}

function disable_ladders() {
  foreach(var_1 in level.dynamicladders) {
    foreach(var_3 in var_1.ents) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
    }
  }
}

function script_model_anims() {}

function setupdynamicladders() {
  script_model_anims();
  var_0 = getEntArray("dynamicLadder", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawnStruct();
    add_dynamicladder(var_3, var_2);

    if(!isDefined(level.dynamicladders)) {
      level.dynamicladders = [];
    }

    level.dynamicladders[level.dynamicladders.size] = var_3;
  }
}

function add_dynamicladder(var_0, var_1) {
  if(!isDefined(var_0.ents)) {
    var_0.ents = [];
  }

  var_0.ents[var_0.ents.size] = var_1;

  if(isDefined(var_1.target)) {
    var_2 = getEntArray(var_1.target, "targetname");

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2) {
        add_dynamicladder(var_0, var_4);
      }

      return;
    }

    return;
  }
}

#using_animtree("script_model");

function create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }

  var_0.animname = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0 predictstreampos(var_0.origin);
  var_3 = spawn("script_arms", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0 playerlinktodelta(var_0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  watch_remove_rig(var_0);
  remove_player_rig(var_0);
}

function remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1)) {
    var_0 setOrigin(var_1);
  } else {
    var_0 setOrigin(var_0.origin + (0, 0, 100));
  }

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

function watch_remove_rig(var_0) {
  scripts\engine\utility::ref_143A6("remove_rig", "death", "disconnect");
}

function watchplayerdeath(var_0) {
  self endon("ladder_complete");
  self.cancelladder = 0;

  for(;;) {
    if(!isDefined(var_0) || !var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      self.cancelladder = 1;
      break;
    }

    waitframe();
  }
}

#using_animtree("");

function placeladder(var_0, var_1) {
  thread watchplayerdeath(var_0);
  var_1.linktoent = var_1 scripts\engine\utility::spawn_tag_origin();
  var_1 playerlinktodelta(var_1.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_1.linktoent moveTo(var_0.scenenode.origin, 0.25, 0.1, 0.1);
  var_1.linktoent rotateTo(var_0.scenenode.angles, 0.25, 0.1, 0.1);
  var_1 setstance("stand");
  wait 0.25;

  if(istrue(self.cancelladder)) {
    return false;
  }

  var_1 unlink();
  var_1.linktoent delete();
  var_1.linktoent = undefined;
  var_1 setOrigin(var_0.scenenode.origin);
  var_1 setplayerangles(var_0.scenenode.angles);
  var_2 = "place";
  var_2 = scripts\engine\utility::ter_op(istrue(var_0.ishighladder), "place_high", "place");
  setDvar("depthSortViewmodel", 1);
  thread create_player_rig(var_1, "player");
  var_0.scenenode thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, var_2);

  if(isDefined(var_0.target)) {
    getEnt(var_0.target, "targetname").origin = getEnt(var_0.target, "targetname").origin + (0, 5000, 0);
  }

  var_3 = spawn("script_model", var_0.scenenode.origin);
  var_3 setModel("tactical_ladder_vm");
  var_3.animname = "ladder";
  var_3 useanimtree(#animtree);
  var_0.placedladder = var_3;
  var_0.scenenode thread scripts\common\anim::anim_single_solo(var_3, var_2);
  var_4 = getanimlength(level.scr_anim["player"][var_2]);
  wait var_4;
  setDvar("depthSortViewmodel", 0);

  if(istrue(var_0.cancelladder)) {
    return false;
  }

  var_1 notify("ladder_complete");
  remove_player_rig(var_1);
  var_0 notify("ladder_complete");
  return true;
}