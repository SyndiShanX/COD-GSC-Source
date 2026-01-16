/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_divisions.gsc
********************************************/

checkforseason1start() {
  if(!isvalidplayer()) {
    return;
  }
  if(isdefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  if(isdefined(level.ishorde) && level.ishorde) {
    return;
  }
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(isdefined(self.pers["division"]) && isdefined(self.pers["division"]["seasonStart"])) {
    return;
  }
  var_0 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "currentSeason");
  var_1 = getdvarint("scr_game_season");

  if(var_1 > 0 && var_0 == 0) {
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division", 0);
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "mmr", -31768);
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionRelegationCounter", 0);
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionChallengePlayed", 0);
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionChallengeWon", 0);
    self setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "matchPrediction", 0);
    self setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "matchDp", 0);
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "currentSeason", var_1);
    self.pers["division"]["seasonStart"] = 1;
  }
}

init() {
  if(maps\mp\_utility::invirtuallobby()) {
    return;
  }
  if(getdvarint("scr_game_division") == 1) {
    level.teammmr["allies"] = 0;
    level.teammmr["axis"] = 0;
    thread onrankedmatchstart();
    thread onmatchend();
  } else
    thread onnonrankedmatchstart();
}

isvalidplayer() {
  return !isbot(self) && !isagent(self) && !istestclient(self);
}

onnonrankedmatchstart() {
  level endon("game_win");
  level endon("exitLevel_called");

  foreach(var_1 in level.players) {
    var_1 checkforseason1start();
    var_1 clearmatchprediction();
    var_1.pers["division"]["index"] = 0;
  }

  for (;;) {
    level waittill("connected", var_1);
    var_1 checkforseason1start();
    var_1 clearmatchprediction();
    var_1.pers["division"]["index"] = 0;
  }
}

onrankedmatchstart() {
  level endon("game_win");
  level endon("exitLevel_called");

  foreach(var_1 in level.players)
  var_1 thread onplayerconnect();

  for (;;) {
    level waittill("connected", var_1);
    var_1 thread onplayerconnect();
  }
}

onplayerconnect() {
  level endon("game_win");
  level endon("exitLevel_called");

  if(isvalidplayer()) {
    checkforseason1start();
    initloss();
    self setdivision(self.pers["division"]["init"]["dp"]);
  }
}

onmatchend() {
  level endon("exitLevel_called");

  for (;;) {
    level waittill("game_win", var_0);

    if(!isdefined(var_0) || var_0 != "axis" && var_0 != "allies" && var_0 != "tie") {
      continue;
    }
    calculateteammmrs();
    checkforfeit();

    foreach(var_2 in level.players) {
      if(!var_2 isvalidplayer()) {
        continue;
      }
      var_2 calculatematchprediction();
      var_3 = var_2.pers["division"]["init"]["dp"];

      if(var_2.pers["division"]["wonByForfeit"] || var_2.team == var_0)
        var_2 ondivisionwin(var_3);
      else if(var_0 == "tie")
        var_2 ondivisiontie(var_3);
      else
        var_2 ondivisionloss(var_3);

      var_4 = var_2 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division");
      var_2 setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "matchDp", var_4 - var_3 + 128);
      var_2 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "rankedPlaylistLockTime", 0);
    }

    break;
  }
}

ondivisionwin(var_0) {
  getdivisionpointrange(var_0);

  if(!isdefined(self.pers["division"]["minDP"])) {
    return;
  }
  var_1 = getdivisionpointsdelta(self.pers["division"]["matchPrediction"], "win");
  var_2 = self.pers["division"]["init"]["deltaDP"];
  setplayermmr(var_1);
  savematchprediction("win");
  self.pers["division"]["dp"] = var_0;

  if(self.pers["division"]["minDP"] == var_0)
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionRelegationCounter", self.pers["division"]["init"]["relegation"]);

  if(isdefined(self.pers["division"]["maxDP"])) {
    if(self.pers["division"]["maxDP"] == var_0) {
      if(self.pers["division"]["init"]["winBits"] > 0) {
        self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division", var_0 + 1);
        self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionRelegationCounter", 0);
      } else
        self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division", var_0);

      updatedivisionchallengestatus(1);
    } else
      self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division", int(min(float(self.pers["division"]["maxDP"]), float(var_0 + var_1))));
  } else
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division", var_0 + var_1);
}

ondivisionloss(var_0) {
  getdivisionpointrange(var_0);

  if(!isdefined(self.pers["division"]["minDP"])) {
    return;
  }
  var_1 = getdivisionpointsdelta(self.pers["division"]["matchPrediction"], "loss");
  var_2 = self.pers["division"]["init"]["deltaDP"];
  var_3 = var_1 - var_2;
  savematchprediction("loss");

  if(var_3 == 0) {
    return;
  }
  setplayermmr(var_1);

  if(isdefined(self.pers["division"]["maxDP"]) && self.pers["division"]["maxDP"] == var_0)
    return;
  else if(self.pers["division"]["minDP"] == var_0)
    return;
  else
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division", int(max(float(self.pers["division"]["minDP"]), float(var_0 + var_1))));
}

ondivisiontie(var_0) {
  getdivisionpointrange(var_0);

  if(!isdefined(self.pers["division"]["minDP"])) {
    return;
  }
  var_1 = getdivisionpointsdelta(self.pers["division"]["matchPrediction"], "tie");
  var_2 = self.pers["division"]["init"]["deltaDP"];
  var_3 = var_1 - var_2;
  savematchprediction("tie");

  if(var_3 == 0) {
    return;
  }
  setplayermmr(var_1);

  if(self.pers["division"]["minDP"] == var_0)
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionRelegationCounter", self.pers["division"]["init"]["relegation"]);

  if(isdefined(self.pers["division"]["maxDP"])) {
    if(self.pers["division"]["maxDP"] == var_0) {
      self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division", var_0);
      self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionChallengePlayed", self.pers["division"]["init"]["playBits"]);
      self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionChallengeWon", self.pers["division"]["init"]["winBits"]);
      return;
    } else if(var_1 > 0) {
      self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division", int(min(float(self.pers["division"]["maxDP"]), float(var_0 + var_1))));
      return;
    }
  }

  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division", int(max(float(self.pers["division"]["minDP"]), float(var_0 + var_1))));
}

initloss() {
  if(isdefined(self.pers["division"]) && isdefined(self.pers["division"]["init"])) {
    return;
  }
  clearmatchprediction();
  var_0 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division");
  var_1 = int(tablelookup("mp\divisiontable.csv", 0, "forfeit", 1));
  getdivisionchallengestatus();
  getmmr();

  if(self.pers["division"]["wins"] >= 2 || self.pers["division"]["losses"] >= 2)
    cleardivisionchallengestatus();

  if(self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionRelegationCounter") >= 3)
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionRelegationCounter", 0);

  self.pers["division"]["init"]["dp"] = var_0;
  self.pers["division"]["init"]["deltaDP"] = var_1;
  self.pers["division"]["init"]["relegation"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionRelegationCounter");
  self.pers["division"]["init"]["playBits"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionChallengePlayed");
  self.pers["division"]["init"]["winBits"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionChallengeWon");
  self.pers["division"]["init"]["MMR"] = self.pers["division"]["MMR"];
  thread updatelockouttime();
  self.pers["division"]["dp"] = var_0;
  getdivisionpointrange(var_0);

  if(!isdefined(self.pers["division"]["minDP"])) {
    return;
  }
  setplayermmr(var_1);

  if(isdefined(self.pers["division"]["maxDP"]) && self.pers["division"]["maxDP"] == var_0) {
    self.pers["division"]["losses"]++;

    if(self.pers["division"]["losses"] >= 2)
      self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division", self.pers["division"]["minDP"] + getdivisionresetoffset());
    else {

    }

    updatedivisionchallengestatus(0);
  } else if(self.pers["division"]["minDP"] == var_0) {
    if(self.pers["division"]["minDP"] > 0) {
      var_2 = self.pers["division"]["init"]["relegation"] + 1;

      if(var_2 >= 3) {
        getdivisionpointrange(var_0 - 1);
        self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division", self.pers["division"]["minDP"] + getdivisionresetoffset());
      } else {

      }

      self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionRelegationCounter", var_2);
    }
  } else
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "division", int(max(float(self.pers["division"]["minDP"]), float(var_0 + var_1))));
}

updatelockouttime() {
  level endon("exitLevel_called");
  level endon("game_win");
  self endon("disconnect");

  for (;;) {
    if(isremovedentity(self)) {
      break;
    }

    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "rankedPlaylistLockTime", gettimeutc());
    wait 10;
  }
}

getdivisionpointrange(var_0) {
  var_1 = tablegetrowcount("mp\divisiontable.csv");
  var_2 = tablelookuprownum("mp\divisiontable.csv", 0, "bronze");

  for (var_3 = var_2; var_3 < var_1; var_3++) {
    var_4 = tablelookupbyrow("mp\divisiontable.csv", var_3, 2);

    if(!isdefined(var_4) || var_4 == "") {
      self.pers["division"]["minDP"] = int(tablelookupbyrow("mp\divisiontable.csv", var_3, 1));
      self.pers["division"]["maxDP"] = undefined;
      self.pers["division"]["index"] = var_3 - var_2;
      return;
    }

    var_5 = int(var_4);

    if(var_0 <= var_5) {
      self.pers["division"]["minDP"] = int(tablelookupbyrow("mp\divisiontable.csv", var_3, 1));
      self.pers["division"]["maxDP"] = var_5;
      self.pers["division"]["index"] = var_3 - var_2;
      return;
    }
  }

  self.pers["division"]["minDP"] = undefined;
  self.pers["division"]["maxDP"] = undefined;
}

getdivisionchallengestatus() {
  var_0 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionChallengePlayed");
  var_1 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionChallengeWon");
  var_2 = 0;
  var_3 = 0;

  for (var_4 = 0; var_4 < 3; var_4++) {
    if(var_0 >> var_4 & 1) {
      if(var_1 >> var_4 & 1)
        var_2++;
      else
        var_3++;

      continue;
    }

    break;
  }

  self.pers["division"]["wins"] = var_2;
  self.pers["division"]["losses"] = var_3;
}

cleardivisionchallengestatus() {
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionChallengePlayed", 0);
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionChallengeWon", 0);
  self.pers["division"]["wins"] = 0;
  self.pers["division"]["losses"] = 0;
}

updatedivisionchallengestatus(var_0) {
  var_1 = self.pers["division"]["init"]["playBits"];
  var_2 = self.pers["division"]["init"]["winBits"];
  var_1 = var_1 << 1 | 1;
  var_2 = var_2 << 1;

  if(var_0)
    var_2 = var_2 | 1;

  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionChallengePlayed", var_1);
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "divisionChallengeWon", var_2);
}

getmmr() {
  var_0 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "mmr");
  var_0 = var_0 - -32768;
  self.pers["division"]["MMR"] = var_0;
}

savemmr() {
  var_0 = self.pers["division"]["MMR"] + -32768;
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "mmr", var_0);
}

savematchprediction(var_0) {
  var_1 = 8;
  var_2 = self.pers["division"]["matchPrediction"];

  if(var_2 == "win")
    var_1 = var_1 | 1;
  else if(var_2 == "loss")
    var_1 = var_1 | 2;

  if(var_0 == "win")
    var_1 = var_1 | 16;
  else if(var_0 == "loss")
    var_1 = var_1 | 32;

  self setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "matchPrediction", var_1);
}

clearmatchprediction() {
  if(!isvalidplayer()) {
    return;
  }
  self setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "matchPrediction", 0);
}

calculateteammmrs() {
  var_0["axis"] = 0;
  var_0["allies"] = 0;
  level.teammmr["axis"] = 0;
  level.teammmr["allies"] = 0;

  foreach(var_2 in level.players) {
    if(!var_2 isvalidplayer()) {
      continue;
    }
    if(!isdefined(var_2.team) || var_2.team != "allies" && var_2.team != "axis") {
      continue;
    }
    if(!isdefined(var_2.pers["division"]["init"]["MMR"])) {
      continue;
    }
    var_0[var_2.team]++;
    level.teammmr[var_2.team] = level.teammmr[var_2.team] + var_2.pers["division"]["init"]["MMR"];
  }

  if(var_0["axis"] > 0)
    level.teammmr["axis"] = level.teammmr["axis"] / var_0["axis"];

  if(var_0["allies"] > 0)
    level.teammmr["allies"] = level.teammmr["allies"] / var_0["allies"];
}

calculatematchprediction() {
  if(!isdefined(self.pers["division"]["init"]["MMR"])) {
    return;
  }
  var_0 = self.pers["division"]["init"]["MMR"];
  var_1 = var_0;
  self.pers["division"]["matchPrediction"] = "tie";

  if(!isdefined(self.team))
    return;
  else if(self.team == "axis")
    var_1 = level.teammmr["allies"];
  else if(self.team == "allies")
    var_1 = level.teammmr["axis"];
  else
    return;

  if(var_0 < var_1 - 25)
    self.pers["division"]["matchPrediction"] = "loss";

  if(var_0 > var_1 + 25)
    self.pers["division"]["matchPrediction"] = "win";
}

getdivisionpointsdelta(var_0, var_1) {
  var_2 = tablelookuprownum("mp\divisiontable.csv", 0, var_0);

  if(var_1 == "win")
    return int(tablelookupbyrow("mp\divisiontable.csv", var_2, 1));

  if(var_1 == "loss")
    return int(tablelookupbyrow("mp\divisiontable.csv", var_2, 3));

  return int(tablelookupbyrow("mp\divisiontable.csv", var_2, 2));
}

getdivisionresetoffset() {
  return int(tablelookup("mp\divisiontable.csv", 0, "resetOffset", 1));
}

setplayermmr(var_0) {
  if(!isdefined(self.pers["division"]["init"]["MMR"])) {
    return;
  }
  var_1 = self.pers["division"]["init"]["MMR"];

  if(var_0 < 0 && var_1 < 0 - var_0)
    var_0 = 0 - var_1;

  if(65535 - var_1 < var_0)
    var_0 = 65535 - var_1;

  var_1 = var_1 + var_0;
  self.pers["division"]["MMR"] = var_1;
  savemmr();
}

checkforfeit() {
  var_0["allies"] = 0;
  var_0["axis"] = 0;

  foreach(var_2 in level.players) {
    if(isdefined(var_2.team) && isdefined(var_0[var_2.team]))
      var_0[var_2.team]++;
  }

  foreach(var_2 in level.players) {
    if(isdefined(var_2.team)) {
      if(var_2.team == "allies" && var_0["axis"] == 0) {
        var_2.pers["division"]["wonByForfeit"] = 1;
        continue;
      }

      if(var_2.team == "axis" && var_0["allies"] == 0) {
        var_2.pers["division"]["wonByForfeit"] = 1;
        continue;
      }

      var_2.pers["division"]["wonByForfeit"] = 0;
    }
  }
}