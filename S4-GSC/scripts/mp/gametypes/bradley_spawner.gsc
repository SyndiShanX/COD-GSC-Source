/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\bradley_spawner.gsc
****************************************************/

_id_82A9() {
  if(getdvarint("#x3472b950714ddf102", 0) <= 0) {
    return;
  }
  var_0 = scripts\engine\utility::getstructarray("veh_bromeo_neutral", "targetname");
  var_1 = scripts\engine\utility::getstructarray("veh_bromeo_allies", "targetname");
  var_2 = scripts\engine\utility::getstructarray("veh_bromeo_axis", "targetname");
  level._id_EE5E = [];
  _id_E390(var_0);
  _id_E390(var_1, "allies");
  _id_E390(var_2, "axis");
  level thread _id_A149();
}

_id_A149() {
  level endon("game_ended");

  for(;;) {
    _id_A14A();
    wait 0.05;
  }
}

_id_A14A() {
  level._id_EE5E = scripts\engine\utility::_id_1BD1(level._id_EE5E);

  foreach(var_1 in level._id_EE5E) {
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(var_1);
    var_3 = isDefined(var_2) && var_2.size > 0;

    if(!isDefined(var_1._id_F23A)) {
      if(var_3) {
        var_1._id_F23A = 1;
      }

      continue;
    }

    if(isDefined(var_1._id_F238)) {
      if(var_3) {
        var_1._id_F238 = undefined;
      } else if(var_1._id_F238 <= gettime()) {
        var_1 thread _id_09D6::_id_93C6();
      }

      continue;
    }

    if(!var_3) {
      var_1._id_F238 = gettime() + var_1._id_CE85 * 1000;
    }
  }
}

_id_A0F1(var_0, var_1) {
  var_0._id_CE85 = var_1;
  level._id_EE5E[level._id_EE5E.size] = var_0;
}

_id_E390(var_0, var_1) {
  level endon("game_ended");
  wait 0.05;

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.angles)) {
      var_3.angles = (0, 0, 0);
    }

    var_4 = scripts\engine\utility::ter_op(isDefined(var_3._id_CD51), var_3._id_CD51, 0);
    var_5 = scripts\engine\utility::ter_op(isDefined(var_3._id_CE85), var_3._id_CE85, 0);
    level thread _id_E38F(var_3.origin, var_3.angles, var_1, var_4, var_5);
  }
}

_id_E38F(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_5 = _id_E38E(var_0, var_1, var_2, var_4, 0);

  if(var_3) {
    for(;;) {
      var_5 waittill("death");
      wait 3.0;
      var_5 = _id_E38E(var_0, var_1, var_2, var_4, 1);
    }
  }
}

_id_E38E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  _id_09D6::_id_93D9(var_5);
  var_5._id_31F7 = 0;
  var_5._id_E325 = scripts\engine\utility::ter_op(istrue(var_4), "airdrop_at_position_unsafe", "place_at_position_unsafe");
  var_5.origin = var_0;
  var_5.angles = var_1;
  var_5.team = var_2;
  var_6 = _id_09D6::_id_941A(var_5);

  if(var_3 > 0) {
    _id_A0F1(var_6, var_3);
  }

  return var_6;
}

_id_82A8() {
  level._id_EE57 = scripts\engine\utility::getstructarray("tdm_bradley_allies", "targetname");
  level._id_EE5A = scripts\engine\utility::getstructarray("tdm_bradley_axis", "targetname");
  level._id_EE5D = scripts\engine\utility::getstructarray("tdm_bradley_neutral", "targetname");
  level._id_EE59 = scripts\engine\utility::getstructarray("dom_bradley_allies", "targetname");
  level._id_EE5C = scripts\engine\utility::getstructarray("dom_bradley_axis", "targetname");
  level._id_EE4D = scripts\engine\utility::getstructarray("dom_bradley_a", "targetname");
  level._id_EE4E = scripts\engine\utility::getstructarray("dom_bradley_b", "targetname");
  level._id_EE4F = scripts\engine\utility::getstructarray("dom_bradley_c", "targetname");
  level._id_EE58 = scripts\engine\utility::getstructarray("cmd_bradley_allies", "targetname");
  level._id_EE5B = scripts\engine\utility::getstructarray("cmd_bradley_axis", "targetname");
  level._id_EE4B = scripts\engine\utility::getstructarray("cmd_bradley_2", "targetname");
  level._id_EE4C = scripts\engine\utility::getstructarray("cmd_bradley_3", "targetname");
  level._id_EE4A = scripts\engine\utility::getstructarray("cmd_bradley_1", "targetname");

  if(getdvarint("#x3d5540792cc3f54f1", 0) == 0) {
    return;
  }
  var_0 = ["cmd", "dom", "war", "arm"];
  var_1 = scripts\engine\utility::_id_1BAB(var_0, scripts\mp\utility\game::getgametype());

  if(!isDefined(var_1)) {
    var_1 = var_0.size;
  }

  for(var_2 = var_1; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(var_3 == "war") {
      if(level._id_EE57.size != 0 || level._id_EE5A.size != 0 || level._id_EE5D.size != 0) {
        _id_E385();

        if(level._id_EE5D.size != 0) {
          thread _id_8CE8();
        }

        break;
      }
    } else if(var_3 == "dom") {
      if(level._id_EE59.size != 0 || level._id_EE5C.size != 0 || level._id_EE4D.size != 0 || level._id_EE4E.size != 0 || level._id_EE4F.size != 0) {
        thread _id_8CE7();
        break;
      }
    } else if(var_3 == "cmd") {
      if(level._id_EE58.size != 0 || level._id_EE5B.size != 0 || level._id_EE4A.size != 0 || level._id_EE4B.size != 0 || level._id_EE4C.size != 0) {
        _id_E383();
        break;
      }
    }
  }
}

_id_E385() {
  if(level._id_EE57.size != 0 && level._id_EE5A.size != 0) {
    var_0 = (0, 0, 0);

    if(isDefined(level._id_EE57[0].angles)) {
      var_0 = level._id_EE57[0].angles;
    }

    thread _id_E26E(level._id_EE57[0].origin, var_0, "allies");
    var_0 = (0, 0, 0);

    if(isDefined(level._id_EE5A[0].angles)) {
      var_0 = level._id_EE5A[0].angles;
    }

    thread _id_E26E(level._id_EE5A[0].origin, var_0, "axis");
  }
}

_id_E384() {
  if(level._id_EE59.size != 0 && level._id_EE5C.size != 0) {
    var_0 = (0, 0, 0);
    var_1 = (0, 0, 0);
    var_2 = (0, 0, 0);
    var_3 = (0, 0, 0);

    if(isDefined(level._id_EE59[0].angles)) {
      var_0 = level._id_EE59[0].angles;
    }

    var_1 = level._id_EE59[0].origin;

    if(isDefined(level._id_EE5C[0].angles)) {
      var_2 = level._id_EE5C[0].angles;
    }

    var_3 = level._id_EE5C[0].origin;

    if(game["switchedsides"]) {
      thread _id_E26E(var_3, var_2, "allies");
      thread _id_E26E(var_1, var_0, "axis");
    } else {
      thread _id_E26E(var_3, var_2, "axis");
      thread _id_E26E(var_1, var_0, "allies");
    }
  }
}

_id_E383() {
  if(level._id_EE58.size != 0 && level._id_EE5B.size != 0) {
    var_0 = (0, 0, 0);

    if(isDefined(level._id_EE58[0].angles)) {
      var_0 = level._id_EE58[0].angles;
    }

    thread _id_E26E(level._id_EE58[0].origin, var_0, "allies");
    var_0 = (0, 0, 0);

    if(isDefined(level._id_EE5B[0].angles)) {
      var_0 = level._id_EE5B[0].angles;
    }

    thread _id_E26E(level._id_EE5B[0].origin, var_0, "axis");
  }
}

_id_8CE8() {
  level endon("game_ended");
  wait 12;
  var_0 = scripts\engine\utility::random(level._id_EE5D);
  var_1 = (0, 0, 0);

  if(isDefined(var_0.angles)) {
    var_1 = var_0.angles;
  }

  thread _id_E26E(var_0.origin, var_1);
  var_2 = scripts\mp\utility\game::_id_6DE5();
  var_3 = var_2 / 3;
  var_4 = max(var_3, 180);
  var_4 = min(var_4, 240);

  for(;;) {
    wait(var_4);

    if(scripts\cp_mp\vehicles\vehicle_tracking::_id_102BC("light_tank").size < 2) {
      var_0 = _id_D071();
      thread _id_E26E(var_0.origin, var_0.angles);
    }
  }
}

_id_8CE7() {
  level endon("game_ended");
  wait 60;
  var_0 = scripts\mp\utility\game::_id_6DE5();
  var_1 = var_0 / 3;
  var_2 = max(var_1, 180);
  var_2 = min(var_2, 240);

  for(;;) {
    wait(var_2);

    if(scripts\cp_mp\vehicles\vehicle_tracking::_id_102BC("light_tank").size < 2) {
      var_3 = _id_D053();

      if(!isDefined(var_3)) {
        var_3 = _id_46DF();
      }

      _id_E299(var_3);
    }
  }
}

_id_E299(var_0) {
  if(var_0._id_A8E1 == "_a") {
    var_1 = scripts\engine\utility::random(level._id_EE4D);
  } else if(var_0._id_A8E1 == "_b") {
    var_1 = scripts\engine\utility::random(level._id_EE4E);
  } else {
    var_1 = scripts\engine\utility::random(level._id_EE4F);
  }

  if(isDefined(var_1)) {
    var_2 = (0, 0, 0);

    if(isDefined(var_1.angles)) {
      var_2 = var_1.angles;
    }

    thread _id_E26E(var_1.origin, var_2);
  }
}

_id_F75F(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_id_102BC("light_tank").size < 2) {
    if(var_0 == 1) {
      if(level._id_EE4A.size != 0) {
        var_1 = (0, 0, 0);
        var_2 = scripts\engine\utility::random(level._id_EE4A);

        if(isDefined(var_2.angles)) {
          var_1 = var_2.angles;
        }

        thread _id_E26E(var_2.origin, var_1, "allies");
      }
    } else if(var_0 == 2) {
      if(level._id_EE4B.size != 0) {
        var_1 = (0, 0, 0);
        var_2 = scripts\engine\utility::random(level._id_EE4B);

        if(isDefined(var_2.angles)) {
          var_1 = var_2.angles;
        }

        thread _id_E26E(var_2.origin, var_1, "allies");
      }
    } else if(var_0 == 3) {
      if(level._id_EE4C.size != 0) {
        var_1 = (0, 0, 0);
        var_2 = scripts\engine\utility::random(level._id_EE4C);

        if(isDefined(var_2.angles)) {
          var_1 = var_2.angles;
        }

        thread _id_E26E(var_2.origin, var_1, "allies");
      }
    }
  }
}

_id_46DF() {
  level endon("game_ended");

  for(;;) {
    wait 3;
    var_0 = _id_D053();

    if(isDefined(var_0)) {
      return var_0;
    }
  }
}

_id_D071() {
  var_0 = scripts\engine\utility::random(level._id_EE5D);
  return var_0;
}

_id_D053() {
  var_0 = scripts\mp\gametypes\dom::_id_6DCB("allies");
  var_1 = scripts\mp\gametypes\dom::_id_6DCB("axis");
  var_2 = scripts\mp\gametypes\dom::_id_6DCB("neutral");

  if(var_0.size == 3 || var_1.size == 3) {
    return undefined;
  } else if(var_0.size < var_1.size) {
    if(var_0.size == 0) {
      return var_2[0];
    }

    return var_0[0];
  } else if(var_0.size > var_1.size) {
    if(var_1.size == 0) {
      return var_2[0];
    }

    return var_1[0];
  }

  return undefined;
}

_id_E26E(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  _id_09D6::_id_93D9(var_3);
  var_3._id_31F7 = 0;
  var_3._id_E325 = "airdrop_at_position";
  var_3.origin = var_0;
  var_3.angles = var_1;
  var_3.team = var_2;
  var_4 = _id_09D6::_id_93B3(var_3);
}