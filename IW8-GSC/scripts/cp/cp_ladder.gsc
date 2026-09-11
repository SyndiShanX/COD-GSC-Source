/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_ladder.gsc
***********************************************/

function register_ladder_interactions() {}

function ladder_hint_func(var0, var1) {
  var2 = &"COOP_CRAFTING/PLACE_LADDER";
  return var2;
}

function ladder_activate_func(var0, var1) {
  if(placeladder(var0, var1)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var0);
    return;
  }
}

function ladder_init_func(var0) {
  foreach(var2 in var0) {
    if(var2.script_noteworthy == "dynamicLadder") {
      script_model_anims();
      var3 = scripts\engine\utility::drop_to_ground(var2.origin, 50, -200);
      var2.scenenode = spawn("script_origin", var3);
      var2.scenenode.angles = (0, var2.angles[1], 0);
      var4 = spawnStruct();
      add_dynamicladder(var4, var2);

      if(!isDefined(level.dynamicladders)) {
        level.dynamicladders = [];
      }

      level.dynamicladders[level.dynamicladders.size] = var4;

      if(abs(var3[2] - var4.ents[0].origin[2]) > 32) {
        var2.ishighladder = 1;
      }

      if(isDefined(var4.ents) && isDefined(var4.ents[var4.ents.size - 1])) {
        var4.ents[var4.ents.size - 1].origin -= (0, 5000, 0);
      }
    }
  }
}

function disable_ladders() {
  foreach(var1 in level.dynamicladders) {
    foreach(var3 in var1.ents) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var3);
    }
  }
}

function script_model_anims() {}

function setupdynamicladders() {
  script_model_anims();
  var0 = getEntArray("dynamicLadder", "targetname");

  foreach(var2 in var0) {
    var3 = spawnStruct();
    add_dynamicladder(var3, var2);

    if(!isDefined(level.dynamicladders)) {
      level.dynamicladders = [];
    }

    level.dynamicladders[level.dynamicladders.size] = var3;
  }
}

function add_dynamicladder(var0, var1) {
  if(!isDefined(var0.ents)) {
    var0.ents = [];
  }

  var0.ents[var0.ents.size] = var1;

  if(isDefined(var1.target)) {
    var2 = getEntArray(var1.target, "targetname");

    if(isDefined(var2) && var2.size > 0) {
      foreach(var4 in var2) {
        add_dynamicladder(var0, var4);
      }

      return;
    }

    return;
  }
}

#using_animtree("script_model");

function create_player_rig(var0, var1, var2) {
  if(!isDefined(var0) || isDefined(var0.player_rig)) {
    return;
  }

  var0.animname = var1;

  if(!isDefined(var2)) {
    var2 = "viewhands_base_iw8";
  }

  var0 predictstreampos(var0.origin);
  var3 = spawn("script_arms", var0.origin, 0, 0, var0);
  var3.player = var0;
  var0.player_rig = var3;
  var0.player_rig hide();
  var0.player_rig.animname = var1;
  var0.player_rig useanimtree(#animtree);
  var0 playerlinktodelta(var0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  watch_remove_rig(var0);
  remove_player_rig(var0);
}

function remove_player_rig(var0) {
  if(!isDefined(var0) || !isDefined(var0.player_rig)) {
    return;
  }

  var0 unlink();
  var1 = var0 getdroptofloorposition(var0.origin);

  if(isDefined(var1)) {
    var0 setOrigin(var1);
  } else {
    var0 setOrigin(var0.origin + (0, 0, 100));
  }

  var0.player_rig delete();
  var0.player_rig = undefined;
}

function watch_remove_rig(var0) {
  scripts\engine\utility::ref_143a6("remove_rig", "death", "disconnect");
}

function watchplayerdeath(var0) {
  self endon("ladder_complete");
  self.cancelladder = 0;

  for(;;) {
    if(!isDefined(var0) || !var0 scripts\cp_mp\utility\player_utility::_isalive()) {
      self.cancelladder = 1;
      break;
    }

    waitframe();
  }
}

#using_animtree("");

function placeladder(var0, var1) {
  thread watchplayerdeath(var0);
  var1.linktoent = var1 scripts\engine\utility::spawn_tag_origin();
  var1 playerlinktodelta(var1.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0);
  var1.linktoent moveTo(var0.scenenode.origin, 0.25, 0.1, 0.1);
  var1.linktoent rotateTo(var0.scenenode.angles, 0.25, 0.1, 0.1);
  var1 setstance("stand");
  wait 0.25;

  if(istrue(self.cancelladder)) {
    return false;
  }

  var1 unlink();
  var1.linktoent delete();
  var1.linktoent = undefined;
  var1 setOrigin(var0.scenenode.origin);
  var1 setplayerangles(var0.scenenode.angles);
  var2 = "place";
  var2 = scripts\engine\utility::ter_op(istrue(var0.ishighladder), "place_high", "place");
  setDvar("NMLOKNMRSK", 1);
  thread create_player_rig(var1, "player");
  var0.scenenode thread scripts\cp\cp_anim::anim_player_solo(var1, var1.player_rig, var2);

  if(isDefined(var0.target)) {
    getEnt(var0.target, "targetname").origin = getEnt(var0.target, "targetname").origin + (0, 5000, 0);
  }

  var3 = spawn("script_model", var0.scenenode.origin);
  var3 setModel("tactical_ladder_vm");
  var3.animname = "ladder";
  var3 useanimtree(#animtree);
  var0.placedladder = var3;
  var0.scenenode thread scripts\common\anim::anim_single_solo(var3, var2);
  var4 = getanimlength(level.scr_anim["player"][var2]);
  wait var4;
  setDvar("NMLOKNMRSK", 0);

  if(istrue(var0.cancelladder)) {
    return false;
  }

  var1 notify("ladder_complete");
  remove_player_rig(var1);
  var0 notify("ladder_complete");
  return true;
}