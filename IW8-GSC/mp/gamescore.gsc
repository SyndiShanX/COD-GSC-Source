/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gamescore.gsc
***********************************************/

gethighestscoringteam() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in level.teamnamelist) {
    var_5 = game["_encstr_96040B1D59B0AD35B1F64E599B"][var_4];

    if(!isDefined(var_1) || var_5 > var_0) {
      var_0 = var_5;
      var_1 = var_4;
      var_2 = 0;
      continue;
    }

    if(var_5 == var_0)
      var_2 = 1;
  }

  if(var_2)
    return "_encstr_8D19048EA595";
  else
    return var_1;
}

remove_hunter_class(var_0) {
  var_1 = 0;
  var_2 = undefined;

  foreach(var_4 in level.teamnamelist) {
    if(isDefined(var_0) && var_4 == var_0) {
      continue;
    }
    var_5 = game["_encstr_96040B1D59B0AD35B1F64E599B"][var_4];

    if(!isDefined(var_2) || var_5 > var_1) {
      var_1 = var_5;
      var_2 = var_4;
    }
  }

  return [var_2, game["_encstr_96040B1D59B0AD35B1F64E599B"][var_2]];
}

_id_14026() {
  level notify("_encstr_A544190348B40E5828CFC32BC587A888BA5D7B20D87FC2B0378D31");
  level endon("_encstr_A544190348B40E5828CFC32BC587A888BA5D7B20D87FC2B0378D31");
  waittillframeend;
  var_0 = setteamplacement(game["_encstr_96040B1D59B0AD35B1F64E599B"], "_encstr_9767056D0FBFA8");
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_5 = game["_encstr_96040B1D59B0AD35B1F64E599B"][var_4];

    if(!isDefined(var_1) || var_5 < var_1) {
      var_1 = var_5;
      var_2++;
    }

    game["_encstr_85920F9B354B5AC018902F3FD811A69307"][var_4] = var_2;
  }
}

run_common_functions_stealth() {
  return game["_encstr_85920F9B354B5AC018902F3FD811A69307"];
}

hidesafecircle(var_0, var_1) {
  return var_0.score > var_1.score;
}

gethighestscoringplayer() {
  updateplacement();

  if(!level.placement["_encstr_AF1904A7F929"].size)
    return undefined;
  else
    return level.placement["_encstr_AF1904A7F929"][0];
}

ishighestscoringplayertied() {
  if(level.placement["_encstr_AF1904A7F929"].size > 1) {
    var_0 = _getplayerscore(level.placement["_encstr_AF1904A7F929"][0]);
    var_1 = _getplayerscore(level.placement["_encstr_AF1904A7F929"][1]);
    return var_0 == var_1;
  }

  return 0;
}

getlosingplayers() {
  updateplacement();
  var_0 = level.placement["_encstr_AF1904A7F929"];
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3 == level.placement["_encstr_AF1904A7F929"][0]) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

giveplayerscore(var_0, var_1, var_2) {
  if(istrue(level.ignorescoring) && !issubstr(var_0, "_encstr_A1BD075837DCD29B47")) {
    var_3 = scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

    if(!var_3)
      return;
  }

  if(!level.teambased) {
    foreach(var_5 in level.players) {
      if(scripts\mp\utility\game::issimultaneouskillenabled()) {
        if(var_5 != self) {
          continue;
        }
        if(level.roundscorelimit > 1 && var_5.pers["_encstr_82FB06EB26785BD7"] >= level.roundscorelimit)
          return;
      } else if(level.roundscorelimit > 1 && var_5.pers["_encstr_82FB06EB26785BD7"] >= level.roundscorelimit)
        return;
    }
  }

  var_5 = self;

  if(isDefined(self.owner) && !isbot(self))
    var_5 = self.owner;

  if(!isPlayer(var_5)) {
    return;
  }
  var_7 = var_1;

  if(isDefined(level.onplayerscore))
    var_1 = [[level.onplayerscore]](var_0, var_5, var_1, var_2);

  if(var_1 == 0) {
    return;
  }
  var_5.pers["_encstr_82FB06EB26785BD7"] = int(max(var_5.pers["_encstr_82FB06EB26785BD7"] + var_1, 0));
  var_5 scripts\mp\playerstats_interface::addtoplayerstat(int(var_7), "_encstr_AA270B12190951B94784B87C6B", "_encstr_82FB06EB26785BD7");

  if(var_5.pers["_encstr_82FB06EB26785BD7"] >= 65000)
    var_5.pers["_encstr_82FB06EB26785BD7"] = 65000;

  var_5.score = var_5.pers["_encstr_82FB06EB26785BD7"];
  var_8 = var_5.score;
  var_5 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_82FB06EB26785BD7", var_8);
  var_5 scripts\mp\gamelogic::checkplayerscorelimitsoon();
  var_5 thread scripts\mp\gamelogic::checkscorelimit();
  var_5 scripts\mp\utility\script::bufferednotify("_encstr_AD7116B258277356C8BECDB17BE459AF26D566999593B232", var_1);
  scripts\mp\analyticslog::logevent_reportgamescore(var_1, gettime(), scripts\mp\rank::getscoreinfocategory(var_0, "_encstr_AA5B08F5B421339B1359"));
  var_5 scripts\common\utility::_id_13E0A(level._id_11B2F, var_0);
  var_5 scripts\cp_mp\pet_watch::addobjectivescorecharge(var_0, int(var_7));
}

_setplayerscore(var_0, var_1) {
  if(var_1 == var_0.pers["_encstr_82FB06EB26785BD7"]) {
    return;
  }
  if(var_1 < 0) {
    return;
  }
  var_0.pers["_encstr_82FB06EB26785BD7"] = var_1;
  var_0.score = var_0.pers["_encstr_82FB06EB26785BD7"];
  var_0 thread scripts\mp\gamelogic::checkscorelimit();
}

_getplayerscore(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

  return var_0.pers["_encstr_82FB06EB26785BD7"];
}

checkffascorejip() {
  if(level.roundscorelimit > 0) {
    var_0 = self.score / level.roundscorelimit * 100;

    if(var_0 > level.scorepercentagecutoff) {
      setnojipscore(1, 1);
      level.nojip = 1;
    }
  }
}

giveteamscoreforobjective(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(scripts\mp\utility\game::cantiebysimultaneouskill())
    var_2 = 1;

  if(!isDefined(var_2))
    var_2 = 0;

  if(istrue(level.gameended) && !var_2) {
    return;
  }
  if(istrue(level.ignorescoring)) {
    return;
  }
  if(istrue(level.dontendonscore) && _getteamscore(var_0) >= level.scorelimit) {
    return;
  }
  if(var_2) {
    if(level.roundscorelimit > 1 && game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0] >= level.roundscorelimit)
      return;
  } else if(level.roundscorelimit > 1 && !istrue(level.dontendonscore)) {
    foreach(var_7 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_7)) {
        continue;
      }
      if(game["_encstr_96040B1D59B0AD35B1F64E599B"][var_7] >= level.roundscorelimit)
        return;
    }
  }

  _setteamscore(var_0, _getteamscore(var_0) + var_1, var_2);
  level notify("_encstr_8BE6123B1392677885316359A665E9A61A87AD93", var_0, _getteamscore(var_0));

  if(isDefined(level.onteamscore))
    [[level.onteamscore]](var_0, _getteamscore(var_0), var_3);

  if(isDefined(var_5))
    var_9 = var_5;
  else
    var_9 = freight_lift_door_switch(var_2);

  if(!istrue(var_4))
    _id_12762(var_9, var_2, level.waswinning);

  if(var_9 != "_encstr_8BBA05185F8B99") {
    level.waswinning = var_9;
    var_10 = _getteamscore(var_9);
    var_11 = level.roundscorelimit;

    if(var_10 == 0 || var_11 == 0) {
      return;
    }
    var_12 = var_10 / var_11 * 100;

    if(!scripts\mp\utility\game::isroundbased() && isDefined(level.nojip) && !level.nojip) {
      if(var_12 > level.scorepercentagecutoff) {
        setnojipscore(1, 1);
        level.nojip = 1;
      }
    }
  }

  if(!level.onlinegame)
    _id_119C1();
}

_id_12762(var_0, var_1, var_2) {
  if(!level.splitscreen && var_0 != "_encstr_8BBA05185F8B99" && var_0 != var_2 && gettime() - level.lastscorestatustime > 5000 && scripts\mp\utility\game::getscorelimit() != 1) {
    if(isDefined(level.delayleadtakendialog))
      level thread playleadtakendialog(var_1);
    else {
      level.lastscorestatustime = gettime();
      scripts\mp\utility\dialog::leaderdialog("_encstr_A2E60BEA819FA3E19883233585", var_0, "_encstr_A16D07532531CB4BF7");

      if(var_2 != "_encstr_8BBA05185F8B99")
        scripts\mp\utility\dialog::leaderdialog("_encstr_A3C70A9AF1EFF3B108AF0BF4", var_2, "_encstr_A16D07532531CB4BF7");
    }
  }
}

playleadtakendialog(var_0) {
  wait(level.delayleadtakendialog);
  level.lastscorestatustime = gettime();
  var_1 = freight_lift_door_switch(var_0);
  scripts\mp\utility\dialog::leaderdialog("_encstr_A2E60BEA819FA3E19883233585", var_1, "_encstr_A16D07532531CB4BF7");

  foreach(var_3 in level.teamnamelist) {
    if(var_3 != var_1)
      scripts\mp\utility\dialog::leaderdialog("_encstr_A3C70A9AF1EFF3B108AF0BF4", var_3, "_encstr_A16D07532531CB4BF7");
  }
}

freight_lift_door_switch(var_0) {
  var_1 = level.teamnamelist;

  if(!isDefined(level.waswinning))
    level.waswinning = "_encstr_8BBA05185F8B99";

  var_2 = "_encstr_8BBA05185F8B99";
  var_3 = 0;

  if(level.waswinning != "_encstr_8BBA05185F8B99") {
    var_2 = level.waswinning;
    var_3 = game["_encstr_96040B1D59B0AD35B1F64E599B"][level.waswinning];
  }

  var_4 = 1;

  foreach(var_6 in var_1) {
    if(var_6 == level.waswinning) {
      continue;
    }
    if(game["_encstr_96040B1D59B0AD35B1F64E599B"][var_6] > var_3) {
      var_2 = var_6;
      var_3 = game["_encstr_96040B1D59B0AD35B1F64E599B"][var_6];
      var_4 = 1;
      continue;
    }

    if(game["_encstr_96040B1D59B0AD35B1F64E599B"][var_6] == var_3) {
      var_4 = var_4 + 1;
      var_2 = "_encstr_8BBA05185F8B99";
    }
  }

  return var_2;
}

_setteamscore(var_0, var_1, var_2) {
  if(var_1 < 0)
    var_1 = 0;

  if(var_1 == game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0]) {
    return;
  }
  game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0] = var_1;
  updateteamscore(var_0);

  if(!istrue(level.dontendonscore))
    thread scripts\mp\gamelogic::roundend_checkscorelimit(var_0, var_2);
}

updateteamscore(var_0) {
  if(scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_0)) {
    return;
  }
  var_1 = 0;

  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame())
    var_1 = _getteamscore(var_0);
  else
    var_1 = game["_encstr_B81B0A39EDABE69137D5BDCD"][var_0];

  setteamscore(var_0, int(var_1));
  level thread _id_14026();
}

updatetotalteamscore(var_0) {
  if(!isDefined(game["_encstr_A3670BAC605B57D56FD84A9380"])) {
    game["_encstr_A3670BAC605B57D56FD84A9380"] = [];

    foreach(var_2 in level.teamnamelist)
    game["_encstr_A3670BAC605B57D56FD84A9380"][var_2] = 0;
  }

  var_4 = scripts\mp\utility\game::getwingamebytype();

  switch (var_4) {
    case "_encstr_B81B0A39EDABE69137D5BDCD":
      game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0] = game["_encstr_B81B0A39EDABE69137D5BDCD"][var_0];
      break;
    case "_encstr_96040B1D59B0AD35B1F64E599B":
      if(scripts\mp\utility\game::inovertime())
        game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0] = game["_encstr_8A2C11B172CF27C34133937AEF4522692FB2A0"][var_0] + game["_encstr_9AB20E70BE5F83398C0AC871C225EDB9"][var_0] + game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0];
      else if(scripts\mp\utility\game::resetscoreonroundstart()) {
        game["_encstr_A3670BAC605B57D56FD84A9380"][var_0] = game["_encstr_A3670BAC605B57D56FD84A9380"][var_0] + game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0];
        game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0] = game["_encstr_A3670BAC605B57D56FD84A9380"][var_0];
      }

      break;
  }

  setteamscore(var_0, int(game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0]));
}

updateovertimescore() {
  if(game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] == 0) {
    if(!isDefined(game["_encstr_8A2C11B172CF27C34133937AEF4522692FB2A0"])) {
      game["_encstr_8A2C11B172CF27C34133937AEF4522692FB2A0"] = [];

      foreach(var_1 in level.teamnamelist)
      game["_encstr_8A2C11B172CF27C34133937AEF4522692FB2A0"][var_1] = 0;
    }

    foreach(var_1 in level.teamnamelist)
    game["_encstr_8A2C11B172CF27C34133937AEF4522692FB2A0"][var_1] = game["_encstr_96040B1D59B0AD35B1F64E599B"][var_1] + game["_encstr_A3670BAC605B57D56FD84A9380"][var_1];
  }

  if(!isDefined(game["_encstr_9AB20E70BE5F83398C0AC871C225EDB9"])) {
    game["_encstr_9AB20E70BE5F83398C0AC871C225EDB9"] = [];

    foreach(var_1 in level.teamnamelist)
    game["_encstr_9AB20E70BE5F83398C0AC871C225EDB9"][var_1] = 0;
  }

  foreach(var_1 in level.teamnamelist)
  game["_encstr_9AB20E70BE5F83398C0AC871C225EDB9"][var_1] = game["_encstr_9AB20E70BE5F83398C0AC871C225EDB9"][var_1] + (game["_encstr_96040B1D59B0AD35B1F64E599B"][var_1] - game["_encstr_8A2C11B172CF27C34133937AEF4522692FB2A0"][var_1]);

  if(!scripts\mp\utility\game::iswinbytworulegametype()) {
    game["_encstr_96040B1D59B0AD35B1F64E599B"][game["_encstr_991C0AB9ED5B57161FE89B83"]] = 0;
    setteamscore(game["_encstr_991C0AB9ED5B57161FE89B83"], 0);
    game["_encstr_96040B1D59B0AD35B1F64E599B"][game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = 0;
    setteamscore(game["_encstr_B6A70A23CA6659DC91CAE4DC"], 0);

    if(scripts\mp\utility\game::istimetobeatvalid() && game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      game["_encstr_96040B1D59B0AD35B1F64E599B"][game["_encstr_991C0AB9ED5B57161FE89B83"]] = game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"];
      updateteamscore(game["_encstr_991C0AB9ED5B57161FE89B83"]);
      game["_encstr_9AB20E70BE5F83398C0AC871C225EDB9"][game["_encstr_991C0AB9ED5B57161FE89B83"]] = game["_encstr_9AB20E70BE5F83398C0AC871C225EDB9"][game["_encstr_991C0AB9ED5B57161FE89B83"]] - game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"];
    }

    if(scripts\mp\utility\game::istimetobeatvalid() && game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] == game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
      game["_encstr_96040B1D59B0AD35B1F64E599B"][game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"];
      updateteamscore(game["_encstr_B6A70A23CA6659DC91CAE4DC"]);
      game["_encstr_9AB20E70BE5F83398C0AC871C225EDB9"][game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = game["_encstr_9AB20E70BE5F83398C0AC871C225EDB9"][game["_encstr_B6A70A23CA6659DC91CAE4DC"]] - game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"];
    }
  }
}

_getteamscore(var_0) {
  return int(game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0]);
}

removedisconnectedplayerfromplacement() {
  if(!isDefined(level.placement) || !isDefined(level.placement["_encstr_AF1904A7F929"])) {
    return;
  }
  var_0 = 0;
  var_1 = level.placement["_encstr_AF1904A7F929"].size;
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(level.placement["_encstr_AF1904A7F929"][var_3] == self)
      var_2 = 1;

    if(var_2)
      level.placement["_encstr_AF1904A7F929"][var_3] = level.placement["_encstr_AF1904A7F929"][var_3 + 1];
  }

  if(!var_2) {
    return;
  }
  level.placement["_encstr_AF1904A7F929"][var_1 - 1] = undefined;

  if(level.teambased)
    updateteamplacement();
}

updateplacement() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(isDefined(var_2.connectedpostgame)) {
      continue;
    }
    if(var_2.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_2.pers["_encstr_8AEF05472BC2D6"] == "_encstr_933E090A10B17DDFB3E522" || var_2.pers["_encstr_8AEF05472BC2D6"] == "_encstr_8BBA05185F8B99") {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  for(var_4 = 1; var_4 < var_0.size; var_4++) {
    var_2 = var_0[var_4];
    var_5 = var_2.score;

    for(var_6 = var_4 - 1; var_6 >= 0 && getbetterplayer(var_2, var_0[var_6]) == var_2; var_6--)
      var_0[var_6 + 1] = var_0[var_6];

    var_0[var_6 + 1] = var_2;
  }

  level.placement["_encstr_AF1904A7F929"] = var_0;

  if(level.teambased)
    updateteamplacement();
}

getbetterplayer(var_0, var_1) {
  if(isDefined(level.lastplayerwins))
    return level.lastplayerwins;

  if(var_0.score > var_1.score)
    return var_0;

  if(var_1.score > var_0.score)
    return var_1;

  if(var_0.deaths < var_1.deaths)
    return var_0;

  if(var_1.deaths < var_0.deaths)
    return var_1;

  if(scripts\engine\utility::cointoss())
    return var_0;
  else
    return var_1;
}

updateteamplacement() {
  var_0 = level.placement["_encstr_AF1904A7F929"];
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3.pers["_encstr_8AEF05472BC2D6"];

    if(!isDefined(var_1[var_4]))
      var_1[var_4] = [];

    var_1[var_4][var_1[var_4].size] = var_3;
  }

  foreach(var_7 in level.teamnamelist) {
    if(isDefined(var_1[var_7])) {
      level.placement[var_7] = var_1[var_7];
      continue;
    }

    level.placement[var_7] = [];
  }
}

processassist(var_0, var_1, var_2) {
  if(isDefined(level.assists_disabled)) {
    return;
  }
  processassist_regularmp(var_0, var_1, var_2);
}

processassist_regularmp(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_1) && var_1.basename == "_encstr_95DB19EB1C61A8BDE1DBF1F7FF3B73281233136682C2B8E219B7F9") {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_0.ismarkedtarget)) {
    var_4 = var_0.attackers;
    var_3 = 1;
  }

  if(isDefined(var_0.markedbyboomperk))
    var_5 = var_0.markedbyboomperk;

  wait 0.05;
  scripts\mp\utility\script::waittillslowprocessallowed();
  var_6 = self.pers["_encstr_8AEF05472BC2D6"];

  if(!scripts\mp\utility\teams::isgameplayteam(var_6)) {
    return;
  }
  if(var_6 == var_0.pers["_encstr_8AEF05472BC2D6"] && level.teambased) {
    return;
  }
  var_7 = undefined;
  var_8 = "_encstr_A1BD075837DCD29B47";

  if(!level.teambased)
    var_8 = "_encstr_91A70B13A312807E13497961B2";

  var_9 = scripts\mp\rank::getscoreinfovalue(var_8);

  if(!level.teambased) {
    var_7 = var_9 + var_9 * var_2;
    thread scripts\mp\utility\points::giveunifiedpoints("_encstr_91A70B13A312807E13497961B2", var_1, var_7);
  } else if(isDefined(var_5) && scripts\engine\utility::array_contains_key(var_5, scripts\mp\utility\player::getuniqueid()))
    thread scripts\mp\utility\points::givestreakpointswithtext("_encstr_87250CAFCF9EB253B8FE125C30C8", var_1, undefined);
  else {
    var_7 = var_9 + var_9 * var_2;
    thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A1BD075837DCD29B47", var_1, var_7);
  }

  if(level.teambased) {
    var_10 = scripts\common\utility::playersinsphere(self.origin, 300);

    foreach(var_12 in var_10) {
      if(self.team != var_12.team || self == var_12) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_12)) {
        continue;
      }
      self.modifiers["_encstr_A7220B9A13D8E7E7A86082DAA8"] = 1;
      break;
    }
  }

  if(scripts\mp\utility\perk::_hasperk("_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F") && isDefined(self.hardlineactive)) {
    if(self.hardlineactive["_encstr_A1F308589BCD96CD476E"] == 1) {
      if(!scripts\mp\utility\weapon::iskillstreakweapon(var_1) && !scripts\mp\utility\weapon::issuperweapon(var_1))
        thread scripts\mp\utility\points::givestreakpointswithtext("_encstr_8CA910EFF003194391D09CD6AE696AD108F8", var_1, 1);
    }

    self notify("_encstr_8CA910EFF003194391D09CD6AE696AD108F8");
  }

  scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_A1F308589BCD96CD476E");

  if(isDefined(self.pers["_encstr_A1F308589BCD96CD476E"]) && self.pers["_encstr_A1F308589BCD96CD476E"] < 998) {
    scripts\mp\utility\stats::incpersstat("_encstr_A1F308589BCD96CD476E", 1);
    self.assists = scripts\mp\utility\stats::getpersstat("_encstr_A1F308589BCD96CD476E");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A1F308589BCD96CD476E", self.assists);
  }

  scripts\mp\utility\script::bufferednotify("_encstr_A3F1104953AFEBC04B0F8DAB5EB7082E9FBA", self.modifiers);
  thread scripts\cp\vehicles\vehicle_compass_cp::onplayerkillassist(var_0);
}

processshieldassist(var_0) {
  if(isDefined(level.assists_disabled)) {
    return;
  }
  processshieldassist_regularmp(var_0);
}

processshieldassist_regularmp(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.05;
  scripts\mp\utility\script::waittillslowprocessallowed();

  if(!scripts\mp\utility\teams::isgameplayteam(self.pers["_encstr_8AEF05472BC2D6"])) {
    return;
  }
  if(self.pers["_encstr_8AEF05472BC2D6"] == var_0.pers["_encstr_8AEF05472BC2D6"]) {
    return;
  }
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8BEC0E231AE8493AA84F2E4F2F31B0D9");
  scripts\mp\playerstats_interface::addtoplayerstat(1, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_A1F308589BCD96CD476E");

  if(self.pers["_encstr_A1F308589BCD96CD476E"] < 998) {
    scripts\mp\utility\stats::incpersstat("_encstr_A1F308589BCD96CD476E", 1);
    self.assists = scripts\mp\utility\stats::getpersstat("_encstr_A1F308589BCD96CD476E");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A1F308589BCD96CD476E", self.assists);
  }

  thread scripts\cp\vehicles\vehicle_compass_cp::onplayerkillassist(var_0);
}

initassisttrackers() {
  self notify("_encstr_A9F6138BA5AAD11D43E76880C35CB333D20C758E7A");
  self.buffedbyplayers = [];
  self.debuffedbyplayers = [];
}

trackdebuffassist(var_0, var_1, var_2) {
  if(!isDefined(var_1.debuffedbyplayers[var_2]))
    var_1.debuffedbyplayers[var_2] = [];

  if(scripts\mp\utility\game::lpcfeaturegated() && var_1.debuffedbyplayers[var_2].size >= getdvarint("_encstr_82F017C337DDB97D63E9C86188D7BAD79A186205B1B7BA2D52", 4) && getdvarint("_encstr_82F017C337DDB97D63E9C86188D7BAD79A186205B1B7BA2D52", 4) > 0)
    return 0;

  if(!isDefined(var_1.debuffedbyplayers[var_2][var_0 getentitynumber()]))
    var_1.debuffedbyplayers[var_2][var_0 getentitynumber()] = 0;

  var_1.debuffedbyplayers[var_2][var_0 getentitynumber()]++;
  return 1;
}

untrackdebuffassist(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(isDefined(var_1.debuffedbyplayers[var_2]) && isDefined(var_1.debuffedbyplayers[var_2][var_0 getentitynumber()])) {
      var_1.debuffedbyplayers[var_2][var_0 getentitynumber()]--;

      if(var_1.debuffedbyplayers[var_2][var_0 getentitynumber()] <= 0)
        var_1.debuffedbyplayers[var_2][var_0 getentitynumber()] = undefined;

      var_3 = 1;

      foreach(var_6, var_5 in var_1.debuffedbyplayers[var_2]) {
        if(var_5 > 0) {
          var_3 = 0;
          break;
        }
      }

      if(var_3 && isDefined(var_2) && isDefined(var_1.debuffedbyplayers)) {
        var_1.debuffedbyplayers[var_2] = undefined;
        return;
      }
    } else {}
  }
}

trackdebuffassistfortime(var_0, var_1, var_2, var_3, var_4) {
  var_1 endon("_encstr_A9F6138BA5AAD11D43E76880C35CB333D20C758E7A");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_5 = trackdebuffassist(var_0, var_1, var_2);

  if(!var_5) {
    return;
  }
  if(isDefined(var_4) && isstring(var_4))
    var_1 scripts\engine\utility::waittill_notify_or_timeout(var_4, var_3);
  else
    wait(var_3);

  untrackdebuffassist(var_0, var_1, var_2);
}

isdebuffedbyweapon(var_0, var_1) {
  if(scripts\mp\utility\game::runleanthreadmode())
    return 0;

  if(isDefined(var_0.debuffedbyplayers[var_1])) {
    foreach(var_4, var_3 in var_0.debuffedbyplayers[var_1]) {
      if(var_3 <= 0) {
        continue;
      }
      if(!isDefined(level.playersbyentitynumber[var_4])) {
        continue;
      }
      return 1;
    }
  }

  return 0;
}

isdebuffedbyweaponandplayer(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::runleanthreadmode())
    return 0;

  if(!isDefined(var_1.debuffedbyplayers[var_2]))
    return 0;

  if(!isDefined(var_1.debuffedbyplayers[var_2][var_0 getentitynumber()]))
    return 0;

  if(var_1.debuffedbyplayers[var_2][var_0 getentitynumber()] <= 0)
    return 0;

  return 1;
}

getdebuffattackersbyweapon(var_0, var_1) {
  if(scripts\mp\utility\game::runleanthreadmode())
    return undefined;

  var_2 = [];

  if(isPlayer(var_0)) {
    if(isDefined(var_0.debuffedbyplayers[var_1])) {
      foreach(var_5, var_4 in var_0.debuffedbyplayers[var_1]) {
        if(var_4 <= 0) {
          continue;
        }
        if(!isDefined(level.playersbyentitynumber[var_5])) {
          continue;
        }
        var_2[var_2.size] = level.playersbyentitynumber[var_5];
      }
    }
  }

  return var_2;
}

trackbuffassist(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  if(var_0 != var_1) {
    if(!isDefined(var_1.buffedbyplayers[var_2]))
      var_1.buffedbyplayers[var_2] = [];

    if(scripts\mp\utility\game::lpcfeaturegated() && var_1.buffedbyplayers[var_2].size >= getdvarint("_encstr_82F017C337DDB97D63E9C86188D7BAD79A186205B1B7BA2D52", 4) && getdvarint("_encstr_82F017C337DDB97D63E9C86188D7BAD79A186205B1B7BA2D52", 4) > 0)
      return 0;

    if(!isDefined(var_1.buffedbyplayers[var_2][var_0 getentitynumber()]))
      var_1.buffedbyplayers[var_2][var_0 getentitynumber()] = 0;

    var_1.buffedbyplayers[var_2][var_0 getentitynumber()]++;
    return 1;
  }
}

untrackbuffassist(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  if(isDefined(var_1)) {
    if(isDefined(var_1.buffedbyplayers[var_2]) && isDefined(var_1.buffedbyplayers[var_2][var_0 getentitynumber()])) {
      var_1.buffedbyplayers[var_2][var_0 getentitynumber()]--;

      if(var_1.buffedbyplayers[var_2][var_0 getentitynumber()] <= 0)
        var_1.buffedbyplayers[var_2][var_0 getentitynumber()] = undefined;
    } else {}
  }
}

trackbuffassistfortime(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  var_1 endon("_encstr_A9F6138BA5AAD11D43E76880C35CB333D20C758E7A");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_5 = trackbuffassist(var_0, var_1, var_2);

  if(!var_5) {
    return;
  }
  if(isDefined(var_4) && isstring(var_4))
    var_1 scripts\engine\utility::waittill_notify_or_timeout(var_4, var_3);
  else
    wait(var_3);

  untrackbuffassist(var_0, var_1, var_2);
}

awardbuffdebuffassists(var_0, var_1) {
  var_2 = [];

  foreach(var_10, var_4 in var_1.debuffedbyplayers) {
    foreach(var_9, var_6 in var_4) {
      if(var_6 <= 0) {
        continue;
      }
      var_7 = level.playersbyentitynumber[var_9];

      if(isDefined(var_7) && var_7.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_7.team != "_encstr_933E090A10B17DDFB3E522" && var_7 scripts\mp\utility\player::isenemy(var_1)) {
        var_8 = var_7.guid;

        if(!isDefined(var_2[var_8]))
          var_2[var_8] = var_7;
      }
    }
  }

  foreach(var_4 in var_0.buffedbyplayers) {
    foreach(var_9, var_13 in var_4) {
      if(var_13 <= 0) {
        continue;
      }
      var_7 = level.playersbyentitynumber[var_9];

      if(isDefined(var_7) && var_7.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_7.team != "_encstr_933E090A10B17DDFB3E522" && var_7 scripts\mp\utility\player::isenemy(var_1)) {
        var_8 = var_7.guid;

        if(!isDefined(var_2[var_8]))
          var_2[var_8] = var_7;
      }
    }
  }

  foreach(var_8, var_7 in var_2) {
    if(!isDefined(var_1.attackerdata) || !isDefined(var_1.attackerdata[var_7.guid]))
      scripts\mp\damage::addattacker(var_1, var_7, undefined, isundefinedweapon(), 0, undefined, undefined, undefined, undefined, undefined);
  }
}

gamemodeusesdeathmatchscoring(var_0) {
  return var_0 == "_encstr_9707038CB6" || var_0 == "_encstr_852009F3B82927C7799CC9";
}

_id_119C1() {
  var_0 = level.teamnamelist[0];
  var_1 = level.teamnamelist[1];
  var_2 = getteamscore(var_0);
  var_3 = getteamscore(var_1);
  getentitylessscriptablearray("_encstr_829C18099DE7B020C2436B7563497EC88F7251E6C65848601A17", ["_encstr_A1320C4D2DBAC109AEC19390D02D", var_0, "_encstr_87E70C47CA0BB5D719BEDCC2DA56", var_1, "_encstr_B8D90D043FA1759903279B625575A8", var_2, "_encstr_81D90DD1ACB0D67D23F5E66CDE4E2B", var_3]);
}