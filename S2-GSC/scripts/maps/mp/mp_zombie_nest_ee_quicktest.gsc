/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_quicktest.gsc
***********************************************************/

main() {
  level._id_6662 = common_scripts\utility::_id_46B7("objective_testing_spawners", "targetname");
  level._id_6664 = common_scripts\utility::_id_46B7("objective_testing_spawners_salt", "targetname");
  level._id_6663 = common_scripts\utility::_id_46B7("objective_testing_spawners_com", "targetname");
  level._id_6661 = common_scripts\utility::_id_46B7("objective_testing_spawners_blimp", "targetname");
}

_id_772E() {
  for(;;) {
    var_0 = 0;

    foreach(var_2 in maps\mp\agents\_agent_utility::_id_43FD("all")) {
      if(common_scripts\utility::_id_562E(var_2._id_6816)) {
        continue;
      }
      if(var_2._id_901F <= level._id_A980 && var_2._id_6816)
        var_0++;
    }

    _iprintln("zombies left to kill: " + var_0);
    wait 1;
  }
}

_id_0CAE(var_0, var_1, var_2, var_3) {
  wait 0.5;

  foreach(var_5 in level._id_AC1D)
  var_5 notify("open", level.players[0]);

  var_7 = _id_4420(var_3);

  for(;;) {
    if(isDefined(level.players)) {
      for(var_8 = 0; var_8 < level.players.size; var_8++) {
        if(!isDefined(level.players[var_8]._id_57D9)) {
          level.players[var_8]._id_57D9 = 1;

          if(isDefined(var_7)) {
            level.players[var_8] setOrigin(var_7[var_8].origin);
            level.players[var_8] setplayerangles(var_7[var_8].angles);
          }

          level.players[var_8] _id_8706(var_0, var_1);

          if(0)
            level.players[var_8]._id_AC5B = 1;

          level.players[var_8] maps\mp\gametypes\zombies::_id_4798(var_2 - 500);
          level.players[var_8] _id_056A::_id_47B5();
          level.players[var_8] _id_056A::_id_47B8();
          level.players[var_8] _id_056A::_id_47B1();
        }
      }
    }

    wait 1;
  }
}

_id_8706(var_0, var_1) {
  var_2 = self getcurrentweapon();
  _id_0586::_id_078C(var_0);
  _id_0586::_id_078C(var_1);
  _id_0586::_id_078E(var_0);
  _id_0586::_id_0790(var_2);
}

_id_4420(var_0) {
  var_1 = [(0, 0, 0)];

  switch (var_0) {
    case 1:
      var_1 = level._id_6664;
      thread maps\mp\mp_zombie_nest_ee_shard::_id_784E();
      break;
    case 2:
      var_1 = level._id_6663;
      thread maps\mp\mp_zombie_nest_ee_shard::_id_7866();
      break;
    case 3:
      var_1 = level._id_6663;
      thread maps\mp\mp_zombie_nest_ee_cart::_id_7865();
      break;
    case 4:
      var_1 = level._id_6663;
      thread maps\mp\mp_zombie_nest_ee_fuses::_id_785D();
      break;
    case 5:
      var_1 = level._id_6662;
      thread maps\mp\mp_zombie_nest_ee_tower_battle::_id_170D();
      break;
    case 6:
      var_1 = level._id_6662;
      thread maps\mp\mp_zombie_nest_ee_tower_battle::_id_1715();
      break;
    case 7:
      var_1 = level._id_6661;
      break;
    case 8:
      var_1 = level._id_6661;
      thread maps\mp\mp_zombie_nest_ee_final_boss::_id_7853();
      thread maps\mp\mp_zombie_nest_ee_overcharge::_id_784B();
      break;
    default:
      break;
  }

  return var_1;
}

_id_7C11(var_0) {
  while(!isDefined(level.players))
    wait 0.1;

  wait 1;
  level._id_A980 = var_0;
}