/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1381.gsc
**************************************/

_id_5373() {
  level thread _id_400A();
}

unlocksurvivalmaps() {
  if(!_func_2A3()) {
    return;
  }
  if(getdvarint("spv_shattered_srv_unlock_auto", 0) == 0) {
    return;
  }
  var_0 = self;
  var_0 _meth_8697(42, [5, 5]);
}

getzombiegeareventvalue(var_0) {
  switch (var_0) {
    case "raven_set":
      return 2;
    case "treasure_set":
      return 1;
    case "assassin_set":
      return 3;
    case "survivalist_set":
      return 4;
    case "mountain_man_set":
      return 5;
    case "bat_elite_set":
      return 6;
    case "hunter_blood_set":
      return 12;
    case "hunter_bat_set":
      return 11;
    case "hunter_origin_set":
      return 10;
    case "mountain_man_blood_set":
      return 15;
    case "mountain_man_bat_set":
      return 14;
    case "mountain_man_origin_set":
      return 13;
    case "survivalist_blood_set":
      return 9;
    case "survivalist_bat_set":
      return 8;
    case "survivalist_origin_set":
      return 7;
    case "assassin_blood_set":
      return 18;
    case "assassin_bat_set":
      return 17;
    case "assassin_origin_set":
      return 16;
    case "surgeon_set":
      return 19;
    case "rebel_set":
      return 20;
    case "super_soldier_set":
      return 21;
    case "arrow_set":
      return 23;
    case "captain_set":
      return 24;
    case "explorer_set":
      return 25;
    case "african_set":
      return 26;
    case "outlaw_set":
      return 27;
    case "arabic_set":
      return 28;
    case "wicht_set":
      return 29;
  }
}

_id_7C07(var_0) {
  if(!isDefined(level._id_400C))
    level._id_400C = [];

  level._id_400C[var_0] = 16;
}

_id_400A() {
  level endon("game_over");
  self endon("disconnect");

  if(!isDefined(level._id_400E))
    level._id_400E = [];

  if(!isDefined(level._id_400C))
    level._id_400C = [];

  if(!isDefined(level._id_400D))
    level._id_400D = [];

  for(;;) {
    if(level._id_400E.size > 0) {
      foreach(var_1 in level._id_400E) {
        var_2 = strtok(var_1[0], " ");
        var_3 = var_2[0];
        var_4 = int(var_2[1]);
        var_5 = int(var_2[2]);
        var_6 = var_1[1];
        var_7 = var_3 + var_4;
        var_8 = level._id_400C[var_3];

        if(!isDefined(var_8)) {
          continue;
        }
        if(common_scripts\utility::_id_562E(level._id_400D[var_7])) {
          continue;
        }
        if(var_5 < 0) {
          level._id_400D[var_7] = 1;
          continue;
        }

        if(!isDefined(var_6)) {
          continue;
        }
        if(common_scripts\utility::_id_562E(level.onlinegame)) {
          if(_func_031(var_6) && var_6 == "all") {
            if(!isDefined(level.players)) {
              continue;
            }
            foreach(var_10 in level.players)
            var_10 _id_83DB(var_8, var_4, var_5, var_3);

            continue;
          }

          if(!_func_279(var_6) && isPlayer(var_6))
            var_6 _id_83DB(var_8, var_4, var_5, var_3);
        }
      }

      level._id_400E = [];
    }

    waitframe();
  }
}

_id_83DB(var_0, var_1, var_2, var_3) {
  if(!common_scripts\utility::_id_562E(self._id_596A)) {
    return;
  }
  if(!isDefined(self._id_400B))
    self._id_400B = [];

  var_4 = var_3 + var_1;

  if(common_scripts\utility::_id_562E(self._id_400B[var_4])) {
    return;
  }
  self._id_400B[var_4] = 1;
  thread maps\mp\gametypes\_hud_message::_id_9102(var_4 + "_objective_complete");
  _id_0468::_id_0A2B(var_3, var_1);
}

getchallengesplashref(var_0, var_1) {
  return var_0 + var_1 + "_objective_complete";
}

zombiegearchallengecompleteall(var_0, var_1) {
  var_2 = get_is_testing_offline();

  foreach(var_4 in level.players)
  var_4 zombiegearchallengecomplete(var_0, var_1, var_2);
}

zombiegearchallengecomplete(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = getchallengesplashref(var_0, var_1);
  var_5 = getzombiegeareventvalue(var_0);
  var_6 = [3, var_5, 4, var_1];

  if(!common_scripts\utility::_id_562E(var_2))
    var_3 _meth_8697(16, var_6);

  var_3 thread maps\mp\gametypes\_hud_message::_id_9102(var_4);
}

zombiegearchallengethread(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = var_0.splashrefprefix;
  var_3 = var_0.challengebitindex;
  var_4 = var_0.challengefunc;
  var_5 = var_1 wait_for_challenge_return(var_4);
  var_6 = get_is_testing_offline();

  if(!level.onlinegame && !var_6) {
    return;
  }
  if(!common_scripts\utility::_id_562E(var_5)) {
    return;
  }
  var_1 zombiegearchallengecomplete(var_2, var_3, var_6);
}

get_is_testing_offline() {
  var_0 = 0;
  return var_0;
}

wait_for_challenge_return(var_0) {
  var_1 = self[[var_0]]();
  return var_1;
}

zombiegearchallengeregister(var_0, var_1, var_2) {
  foreach(var_7, var_4 in var_1) {
    var_5 = spawnStruct();
    var_5.splashrefprefix = var_0;
    var_5.challengebitindex = var_7;
    var_5.challengefunc = var_4;

    if(isDefined(var_2))
      var_6 = var_2 + var_7;
    else
      var_6 = undefined;

    level thread maps\mp\_utility::_id_6F74(::zombiegearchallengethread, var_5, var_6);
  }
}