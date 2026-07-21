/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_ladder.gsc
***********************************************/

register_ladder_interactions() {}

ladder_hint_func(var_0, var_1) {
  var_2 = &"_encstr_B20B1BC3D8943BA1F7F97038F1DBAD2FC03F44B9467DBFBD1BA12854A9";
  return var_2;
}

ladder_activate_func(var_0, var_1) {
  if(placeladder(var_0, var_1))
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

ladder_init_func(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "_encstr_AD3F0E325E730BDA2DC6C4163291B2C9") {
      script_model_anims();
      var_3 = scripts\engine\utility::drop_to_ground(var_2.origin, 50.0, -200.0);
      var_2.scenenode = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_3);
      var_2.scenenode.angles = (0, var_2.angles[1], 0);
      var_4 = spawnStruct();
      add_dynamicladder(var_4, var_2);

      if(!isDefined(level.dynamicladders))
        level.dynamicladders = [];

      level.dynamicladders[level.dynamicladders.size] = var_4;

      if(abs(var_3[2] - var_4.ents[0].origin[2]) > 32)
        var_2.ishighladder = 1;

      if(isDefined(var_4.ents) && isDefined(var_4.ents[var_4.ents.size - 1]))
        var_4.ents[var_4.ents.size - 1].origin = var_4.ents[var_4.ents.size - 1].origin - (0, 5000, 0);
    }
  }
}

disable_ladders() {
  foreach(var_1 in level.dynamicladders) {
    foreach(var_3 in var_1.ents)
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
  }
}

script_model_anims() {}

setupdynamicladders() {
  script_model_anims();
  var_0 = getEntArray("_encstr_AD3F0E325E730BDA2DC6C4163291B2C9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = spawnStruct();
    add_dynamicladder(var_3, var_2);

    if(!isDefined(level.dynamicladders))
      level.dynamicladders = [];

    level.dynamicladders[level.dynamicladders.size] = var_3;
  }
}

add_dynamicladder(var_0, var_1) {
  if(!isDefined(var_0.ents))
    var_0.ents = [];

  var_0.ents[var_0.ents.size] = var_1;

  if(isDefined(var_1.target)) {
    var_2 = getEntArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2)
      add_dynamicladder(var_0, var_4);
    }
  }
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }
  var_0.animname = var_1;

  if(!isDefined(var_2))
    var_2 = "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A";

  var_0 predictstreampos(var_0.origin);
  var_3 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 0, 0);
  var_0 watch_remove_rig();
  remove_player_rig(var_0);
}

remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1))
    var_0 setOrigin(var_1);
  else
    var_0 setOrigin(var_0.origin + (0, 0, 100));

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

watch_remove_rig(var_0) {
  scripts\engine\utility::_id_143A6("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
}

watchplayerdeath(var_0) {
  self endon("_encstr_AC7C1010F714E1A34389E6F81D3BE9896C9F");
  self.cancelladder = 0;

  for(;;) {
    if(!isDefined(var_0) || !var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      self.cancelladder = 1;
      break;
    }

    waitframe();
  }
}

#using_animtree("_encstr_B40101");

placeladder(var_0, var_1) {
  var_0 thread watchplayerdeath(var_1);
  var_1.linktoent = var_1 scripts\engine\utility::spawn_tag_origin();
  var_1 playerlinktodelta(var_1.linktoent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1, 0, 0, 0, 0, 0);
  var_1.linktoent moveTo(var_0.scenenode.origin, 0.25, 0.1, 0.1);
  var_1.linktoent rotateTo(var_0.scenenode.angles, 0.25, 0.1, 0.1);
  var_1 setstance("_encstr_A5AD069B231F0BAF");
  wait 0.25;

  if(istrue(self.cancelladder))
    return 0;

  var_1 unlink();
  var_1.linktoent delete();
  var_1.linktoent = undefined;
  var_1 setOrigin(var_0.scenenode.origin);
  var_1 setplayerangles(var_0.scenenode.angles);
  var_2 = "_encstr_A94E0638D8B0D859";
  var_2 = scripts\engine\utility::ter_op(istrue(var_0.ishighladder), "_encstr_954D0B07362CD859D7345A9DD0", "_encstr_A94E0638D8B0D859");
  setDvar("_encstr_856D0B9C3562D3969C6AA435A5", 1);
  thread create_player_rig(var_1, "_encstr_8BB007E03658CBCAE4");
  var_0.scenenode thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, var_2);

  if(isDefined(var_0.target))
    getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin + (0, 5000, 0);

  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.scenenode.origin);
  var_3 setModel("_encstr_9A08131D0B6CA396360B36EB63581919ACE4D7D9DA");
  var_3.animname = "_encstr_A7E607E068D02BA2B6";
  var_3 useanimtree(#animtree);
  var_0.placedladder = var_3;
  var_0.scenenode thread scripts\common\anim::anim_single_solo(var_3, var_2);
  var_4 = getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"][var_2]);
  wait(var_4);
  setDvar("_encstr_856D0B9C3562D3969C6AA435A5", 0);

  if(istrue(var_0.cancelladder))
    return 0;

  var_1 notify("_encstr_AC7C1010F714E1A34389E6F81D3BE9896C9F");
  remove_player_rig(var_1);
  var_0 notify("_encstr_AC7C1010F714E1A34389E6F81D3BE9896C9F");
  return 1;
}