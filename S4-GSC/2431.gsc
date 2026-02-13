/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2431.gsc
*************************************************/

_id_8054(var_0) {
  level._id_7D9B = 1;
  level._id_3E21 = 24;

  if(isDefined(level.script)) {
    switch (level.script) {
      case "cp_zmb":
        var_0._id_0E67 = ["STICKER_COLLECTOR", "SOUL_KEY", "THE_BIGGER_THEY_ARE", "HOFF_THE_CHARTS", "ROCK_ON", "GET_PACKED", "BATTERIES_NOT_INCLUDED", "I_LOVE_THE_80_S", "INSERT_COIN", "BRAIN_DEAD"];
        break;
      case "cp_rave":
        var_0._id_0E67 = ["LOCKSMITH", "SUPER_SLACKER", "STICK_EM", "HALLUCINATION_NATION", "TABLES_TURNED", "RAVE_ON", "RIDE_FOR_YOUR_LIFE", "SCRAPBOOKING", "PUMP_IT_UP", "TOP_CAMPER"];
        break;
      case "cp_disco":
        var_0._id_0E67 = ["BOOK_WORM", "COIN_OP", "BEAT_OF_THE_DRUM", "SLICED_AND_DICED", "PEST_CONTROL", "EXTERMINATOR", "SHAOLIN_SKILLS", "MESSAGE_RECEIVED", "SOUL_BROTHER", "SOME_ASSEMBLY_REQUIRED"];
        break;
      default:
        var_0._id_0E67 = ["STICKER_COLLECTOR", "SOUL_KEY", "THE_BIGGER_THEY_ARE", "HOFF_THE_CHARTS", "ROCK_ON", "GET_PACKED", "BATTERIES_NOT_INCLUDED", "I_LOVE_THE_80_S", "INSERT_COIN", "BRAIN_DEAD", "LOCKSMITH", "SUPER_SLACKER", "STICK_EM", "HALLUCINATION_NATION", "TABLES_TURNED", "RAVE_ON", "RIDE_FOR_YOUR_LIFE", "SCRAPBOOKING", "PUMP_IT_UP", "TOP_CAMPER", "BOOK_WORM", "COIN_OP", "BEAT_OF_THE_DRUM", "SLICED_AND_DICED", "PEST_CONTROL", "EXTERMINATOR", "SHAOLIN_SKILLS", "MESSAGE_RECEIVED", "SOUL_BROTHER", "SOME_ASSEMBLY_REQUIRED"];
        break;
    }
  }

  if(isDefined(var_0._id_0E69)) {
    [[var_0._id_0E69]]();
  }
}

_id_C1DC() {
  _id_C1C2("STICKER_COLLECTOR", 24, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("SOUL_KEY", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("THE_BIGGER_THEY_ARE", 5, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("HOFF_THE_CHARTS", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("ROCK_ON", 1, ::_id_4573, ::_id_4589, ::_id_1D35);
  _id_C1C2("GET_PACKED", 1, ::_id_4573, ::_id_4589, ::_id_1D35);
  _id_C1C2("BATTERIES_NOT_INCLUDED", 1, ::_id_4573, ::_id_4589, ::_id_1D35);
  _id_C1C2("I_LOVE_THE_80_S", 2, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("INSERT_COIN", 20, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("BRAIN_DEAD", 30, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("LOCKSMITH", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("SUPER_SLACKER", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("STICK_EM", 100, ::_id_4573, ::_id_4589, ::_id_1D35);
  _id_C1C2("HALLUCINATION_NATION", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("TABLES_TURNED", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("RAVE_ON", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("RIDE_FOR_YOUR_LIFE", 4, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("SCRAPBOOKING", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("PUMP_IT_UP", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("TOP_CAMPER", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("BOOK_WORM", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("COIN_OP", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("BEAT_OF_THE_DRUM", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("SLICED_AND_DICED", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("PEST_CONTROL", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("EXTERMINATOR", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("SHAOLIN_SKILLS", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("MESSAGE_RECEIVED", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("SOUL_BROTHER", 1, ::_id_4573, ::_id_4589, ::_id_5544);
  _id_C1C2("SOME_ASSEMBLY_REQUIRED", 1, ::_id_4573, ::_id_4589, ::_id_5544);
}

_id_C1C2(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5[[var_2]](var_1, var_3, var_4);
  self._id_0E67[var_0] = var_5;
}

_id_4573(var_0, var_1, var_2) {
  self._id_BD88 = 0;
  self._id_01FA = var_0;
  self._id_DAEC = var_1;
  self._id_85DF = var_2;
  self._id_0E64 = 0;
}

_id_FB33(var_0, var_1, var_2) {
  if(level._id_1A32.size <= 0 || !scripts\engine\utility::array_contains(level._id_1A32, var_1)) {
    var_0 _id_FB34(var_0, 1, var_2);
  } else {
    level._id_1A32 = scripts\engine\utility::array_remove(level._id_1A32, var_1);

    foreach(var_0 in level.players) {
      var_0 _id_FB31("INSERT_COIN", 1);
    }

    var_0 _id_FB34(var_0, 1, var_2);
  }
}

_id_FB34(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_A771)) {
    var_0._id_A771 = 1;
  } else {
    var_0._id_A771++;
  }

  if(var_0._id_A771 >= 30 && var_2 >= 10) {
    var_0 _id_FB31("BRAIN_DEAD", 30);
  }
}

_id_4589(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return 1;
}

_id_FBB8(var_0) {
  self._id_BD88 = self._id_BD88 + var_0;
}

_id_1D35() {
  return self._id_BD88 >= self._id_01FA;
}

_id_5544() {
  return self._id_BD88 == self._id_01FA;
}

_id_857F() {
  return self._id_0E64;
}

_id_9B0C() {
  self._id_0E64 = 1;
}

_id_8704(var_0) {
  return isDefined(var_0);
}

_id_FB31(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(scripts\cp\utility::_id_857B()) {
    return;
  }
  var_12 = self._id_0E67[var_0];

  if(!_id_8704(var_12)) {
    return;
  }
  if(var_12 _id_857F()) {
    return;
  }
  if(var_12[[var_12._id_DAEC]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11)) {
    var_12 _id_FBB8(var_1);

    if(var_12[[var_12._id_85DF]]()) {
      self _meth_819A(var_0);
      var_12 _id_9B0C();
    }
  }
}

_id_FB32(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 _id_FB31(var_0, var_1);
  }
}