/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\s4_quips_mp.gsc
*************************************************/

triggerhasquip(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return getquipid(var_0) != 0;
}

triggerquip(var_0) {
  var_1 = getquipid(var_0);
  var_2 = getalias(var_1);

  if(isDefined(var_2) && var_2 != "") {
    playquip(var_2, undefined);
  }

  if(!isDefined(var_2) || var_2 == "") {
    thread _id_07A9::logevent_votriggered(self, var_0, "none");
  } else {
    thread _id_07A9::logevent_votriggered(self, var_0, var_2);
  }
}

getquipid(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", self._id_AC3D._id_AC41, "quips", var_0);
  return var_1;
}

getalias(var_0) {
  var_1 = _func_0222("loot/operator_quip_ids.csv", 0, var_0, 13);
  return var_1;
}

quippedtoorecently(var_0, var_1) {
  if(!isPlayer(self)) {
    return 0;
  }

  if(!isDefined(self.quips)) {
    return 0;
  }

  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 0;
  }

  if(!isDefined(var_1)) {
    var_1 = getalias(var_0);
  }

  if(!isDefined(self.quips[var_1])) {
    return 0;
  }

  var_2 = var_1 == getalias(getquipid("quiptrigger_015"));
  var_3 = scripts\engine\utility::ter_op(var_2, 3, 1);
  return self.quips[var_1] + 10000 * var_3 >= gettime();
}

playquip(var_0, var_1) {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  var_2 = self._id_AC3D.voiceprefix;
  var_3 = self._id_AC3D.voiceprefix + "3d";
  var_4 = var_2 + "_" + self._id_AC3D._id_10691 + "_" + var_0;
  var_5 = var_3 + "_" + self._id_AC3D._id_10691 + "_" + var_0;
  var_6 = _func_0205(var_4);
  var_7 = _func_0205(var_5);
  var_8 = splitoperatorvoiceid(self._id_AC3D._id_10691);
  var_9 = [var_2, var_8[0], var_8[1], var_0];
  var_10 = [var_3, var_8[0], var_8[1], var_0];

  if(quippedtoorecently(undefined, var_0)) {
    return;
  }
  if(var_6) {
    self _meth_8854("battlechatter", var_9[0], var_9[1], var_9[2], var_9[3], self, var_1);
  }

  if(var_7) {
    var_11 = [];
    var_11[var_11.size] = self;

    foreach(var_13 in level._id_EF89) {
      var_14 = level._id_EF6A[var_13]["players"];

      foreach(var_16 in var_14) {
        if(var_16 _meth_81E2()) {
          var_17 = var_16 _meth_81E4();

          if(!scripts\engine\utility::array_contains(var_11, var_16) && !scripts\engine\utility::array_contains(var_11, var_17)) {
            var_11[var_11.size] = var_16;
          }
        }

        if(scripts\mp\utility\game::getgametype() == "arena_evo" && var_13 != scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(self.pers["team"])) {
          if(!scripts\engine\utility::array_contains(var_11, var_16)) {
            var_11[var_11.size] = var_16;
          }
        }

        if(!scripts\engine\utility::array_contains(var_11, var_16)) {
          self _meth_8854("battlechatter", var_10[0], var_10[1], var_10[2], var_10[3], var_16, var_1);
        }
      }
    }
  }

  self.quips[var_0] = gettime();
}

splitoperatorvoiceid(var_0) {
  var_1 = [];
  var_2 = "";
  var_3 = var_0.size;

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(var_5 == "_") {
      var_1[var_1.size] = var_2;
      var_2 = "";
      continue;
    }

    if(var_4 == var_0.size - 1) {
      var_2 = var_2 + var_5;
      var_1[var_1.size] = var_2;
      continue;
    }

    var_2 = var_2 + var_5;
  }

  return var_1;
}