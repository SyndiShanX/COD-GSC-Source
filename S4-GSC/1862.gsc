/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1862.gsc
*************************************************/

init() {
  scripts\engine\utility::_id_5C11("vo_system_setup_done");
  scripts\engine\utility::_id_5C11("dialogue_done");
  _id_076F::_id_8172();
  level thread onplayerconnect();
  level thread _id_CF1C();
  game["dialogue"]["axis_male_cough"] = [];
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_1";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_2";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_3";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_4";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_5";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_6";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_7";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_3_enemy_8";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_1";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_2";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_3";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_4";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_5";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_6";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_7";
  game["dialogue"]["axis_male_cough"][game["dialogue"]["axis_male_cough"].size] = "generic_cough_fit_enemy_8";
  game["dialogue"]["axis_female_cough"] = [];
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_1";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_2";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_3";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_4";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_5";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_6";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_7";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_3_friendly_8";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_1";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_2";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_3";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_4";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_5";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_6";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_7";
  game["dialogue"]["axis_female_cough"][game["dialogue"]["axis_female_cough"].size] = "woman_cough_fit_friendly_8";
  game["dialogue"]["allies_male_cough"] = [];
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_1";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_2";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_3";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_4";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_5";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_6";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_7";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_3_friendly_8";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_1";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_2";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_3";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_4";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_5";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_6";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_7";
  game["dialogue"]["allies_male_cough"][game["dialogue"]["allies_male_cough"].size] = "generic_cough_fit_friendly_8";
  game["dialogue"]["allies_female_cough"] = [];
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_1";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_2";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_3";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_4";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_5";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_6";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_7";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_3_friendly_8";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_1";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_2";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_3";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_4";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_5";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_6";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_7";
  game["dialogue"]["allies_female_cough"][game["dialogue"]["allies_female_cough"].size] = "woman_cough_fit_friendly_8";

  if(!isDefined(level._id_10552)) {
    level._id_10552 = [];
  }

  if(isDefined(level._id_9345)) {
    level._id_10552 = [[level._id_9345]](level._id_10552);
  }

  level.hub_music_states = [];
  level.hub_music_states = scripts\engine\utility::array_add(level.hub_music_states, "hub_spawn_01");
  level.hub_music_states = scripts\engine\utility::array_add(level.hub_music_states, "hub_spawn_02");
  level.hub_music_states = scripts\engine\utility::array_add(level.hub_music_states, "hub_spawn_03");
  level.hub_music_states = scripts\engine\utility::array_add(level.hub_music_states, "hub_spawn_04");

  if(!isDefined(level.round_start_music_states)) {
    level.round_start_music_states = [];
    level.round_start_music_states = scripts\engine\utility::array_add(level.round_start_music_states, "hub_spawn_01");
    level.round_start_music_states = scripts\engine\utility::array_add(level.round_start_music_states, "hub_spawn_02");
    level.round_start_music_states = scripts\engine\utility::array_add(level.round_start_music_states, "hub_spawn_03");
    level.round_start_music_states = scripts\engine\utility::array_add(level.round_start_music_states, "hub_spawn_04");
  }

  if(!isDefined(level.round_end_music_states)) {
    level.round_end_music_states = [];
    level.round_end_music_states = scripts\engine\utility::array_add(level.round_end_music_states, "rbz_round_end");
  }
}

_id_253B() {}

_id_30DF() {
  if(level.players.size != 4) {
    return 0;
  }

  if(_id_076F::_id_8716()) {
    return 0;
  }

  return 1;
}

_id_105A5() {
  if(istrue(level._id_18F9)) {
    return 1;
  } else if(istrue(level._id_B632)) {
    return 1;
  } else {
    foreach(var_1 in level.players) {
      if(istrue(var_1._id_10648)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_6AFB(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = level._id_10508[var_0[var_2]];
    var_1 = var_1 + _id_076F::_id_6763(var_3 + var_0[var_2]);
  }

  return var_1;
}

_id_68D7(var_0, var_1) {
  var_2 = [var_0];
  var_3 = var_0;

  for(;;) {
    if(var_1 && isDefined(level._id_1043A[var_3]._id_A49C)) {
      var_2[var_2.size] = level._id_1043A[var_3]._id_A49C;
      var_3 = level._id_1043A[var_3]._id_A49C;
      continue;
    }

    break;
  }

  return var_2;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  self waittill("spawned_player");

  if(!scripts\engine\utility::_id_5C00("vo_system_setup_done")) {
    scripts\engine\utility::_id_5C1B("vo_system_setup_done");
  }
}

_id_B91A(var_0, var_1) {
  if(scripts\cp\utility::_id_89AE() || level._id_AB30) {
    return;
  }
  var_2 = var_0._id_105F0 + "laststand";
  var_0 thread _id_076F::_id_B305(var_2);
}

_id_B91D(var_0, var_1) {
  var_2 = var_0._id_105F0 + "reviving";
  var_0 thread _id_076F::_id_B305(var_2);
}

_id_B91E(var_0) {
  var_1 = 45000;
  var_2 = gettime();

  if(!isDefined(level._id_A47E) || level._id_A47E < var_2) {
    if(isDefined(level._id_A47E)) {
      if(randomint(100) < 60) {
        return;
      }
    }

    level._id_A47E = var_2 + randomintrange(var_1, var_1 + 5000);
    var_3 = scripts\cp\utility::_id_636E();
    var_4 = scripts\engine\utility::random(var_3);

    if(!isDefined(var_4)) {
      return;
    }
    switch (var_0) {
      case "scriptable_alien_lynx_jump":
      case "scriptable_alien_tatra_t815_jump":
        var_5 = var_4._id_105F0 + "alien_approach_truck";
        var_4 _id_076F::_id_B305(var_5);
        break;
    }
  }
}

_id_CF1C() {
  level endon("game_ended");
  level._id_CF1D = [];

  for(;;) {
    level waittill("scriptable", var_0);
    level thread _id_B91E(var_0);
  }
}

_id_B2D7(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 + "_solo";

  if(_func_0205(var_6)) {
    _id_076F::_id_B305(var_6);
  }
}

_id_B8F1(var_0, var_1, var_2) {
  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(var_0);
    }
  } else if(isDefined(var_1)) {
    if(isDefined(var_2)) {
      for(var_3 = 0; var_3 < level.players.size; var_3++) {
        var_4 = level.players[var_3];

        if(var_4 _meth_81E2() && !var_4 _meth_81E3()) {
          continue;
        }
        if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1 && !_id_883F(var_4, var_2)) {
          var_4 playlocalsound(var_0);
        }
      }

      return;
    }

    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(var_4 _meth_81E2() && !var_4 _meth_81E3()) {
        continue;
      }
      if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
        var_4 playlocalsound(var_0);
      }
    }

    return;
  } else if(isDefined(var_2)) {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(level.players[var_3] _meth_81E2() && !level.players[var_3] _meth_81E3()) {
        continue;
      }
      if(!_id_883F(level.players[var_3], var_2)) {
        level.players[var_3] playlocalsound(var_0);
      }
    }
  } else {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(level.players[var_3] _meth_81E2() && !level.players[var_3] _meth_81E3()) {
        continue;
      }
      level.players[var_3] playlocalsound(var_0);
    }
  }
}

_id_883F(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2]) {
      return 1;
    }
  }

  return 0;
}

_id_B827(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\cp\utility::_id_636E();

  if(var_7.size < 1) {
    return;
  }
  var_8 = scripts\engine\utility::random(var_7);
  var_9 = var_8._id_105F0 + var_0;
  var_8 _id_076F::_id_B305(var_9);
}

_id_B2FF(var_0, var_1) {
  var_2 = var_0._id_105F0 + var_1;
  var_0 thread _id_076F::_id_B305(var_2, undefined, 2);
}

_id_B91B(var_0, var_1) {
  if(scripts\cp\utility::_id_89AE() || level._id_AB30) {
    return;
  }
  var_2 = var_0._id_105F0 + "last_stand";
  var_0 thread _id_076F::_id_B305(var_2, undefined, 1);
}

_id_B3DC(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isPlayer(self)) {
    return;
  }
  var_7 = scripts\cp\utility::_id_636E();
  var_7 = scripts\engine\utility::array_remove(var_7, self);

  if(var_7.size < 1) {
    return;
  }
  var_8 = var_7[0];
  var_9 = var_8._id_105F0 + "reaction_casualty_generic";
  var_8 _id_076F::_id_B305(var_9, undefined, 1);
}

_id_8601(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_4436() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 = getdvarint("#x31e6cfd4dd3cf2a1b", 0);

    if(var_0 != 0) {
      switch (var_0) {
        case 1:
          self._id_105F0 = "p1_";
          break;
        case 2:
          self._id_105F0 = "p2_";
          break;
        case 3:
          self._id_105F0 = "p3_";
          break;
        case 4:
          self._id_105F0 = "p4_";
          break;
        default:
          break;
      }

      setDvar("#x31e6cfd4dd3cf2a1b", 0);
    }

    wait 1;
  }
}

_id_102A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level._id_1673)) {
    level._id_1673 = [];
    level thread _id_1673();
  }

  var_7 = spawnStruct();
  var_7._id_1446 = var_0;
  var_7._id_B296 = var_1;
  var_7._id_9E9A = var_2;
  var_7._id_9C10 = var_3;
  var_7._id_A479 = 0;
  var_7._id_33BE = var_5;
  var_7._id_9C2B = var_4;

  if(isDefined(var_6)) {
    var_7._id_A479 = gettime() + var_6 * 1000;
  }

  level._id_1673 = scripts\engine\utility::_id_1B8D(level._id_1673, var_7);
}

_id_1673() {
  for(;;) {
    while(level._id_1673.size == 0) {
      wait 1;
    }

    var_0 = scripts\engine\utility::array_randomize(level._id_1673);

    foreach(var_2 in var_0) {
      if(gettime() < var_2._id_A479) {
        continue;
      }
      var_3 = randomintrange(var_2._id_9E9A, var_2._id_9C10 + 1);
      var_4 = var_2._id_33BE;

      if(scripts\cp\utility::_id_190A(var_2._id_B296, 4096)) {
        wait 1;
        continue;
      }

      var_5 = scripts\cp\utility::_id_190A(var_2._id_B296, var_2._id_9C2B);

      if(!var_5 || randomint(100) > var_4) {
        wait 1;
        continue;
      }

      var_6 = var_2._id_1446;

      if(_func_0107(var_2._id_1446)) {
        var_6 = scripts\engine\utility::random(var_2._id_1446);
      }

      if(_func_0205(var_6)) {
        playsoundatpos(var_2._id_B296, var_6);
      }

      var_2._id_A479 = gettime() + var_3 * 1000;
      wait 1;
    }

    wait 1;
  }
}