/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\game.gsc
***********************************************/

getotherteam(var_0) {
  return scripts\mp\utility\teams::getenemyteams(var_0);
}

gettimepassed() {
  if(!isDefined(level.starttime) || !isDefined(level.discardtime))
    return 0;

  if(level.timerstopped)
    return level.timerpausetime - level.starttime - level.discardtime - level.overtimetotal;
  else
    return gettime() - level.starttime - level.discardtime - level.overtimetotal;
}

gettimepassedpercentage() {
  var_0 = gettimelimit();

  if(var_0 == 0)
    return 0;

  return gettimepassed() / (gettimelimit() * 1000) * 100;
}

getsecondspassed() {
  return gettimepassed() / 1000;
}

getminutespassed() {
  return getsecondspassed() / 60;
}

setuipostgamefade(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(level.nukedetonated)) {
    return;
  }
  if(!isDefined(self.fadecurrent))
    self.fadecurrent = 0.0;

  if(self.fadecurrent == var_0) {
    return;
  }
  if(isDefined(var_1))
    wait(var_1);

  self notify("_encstr_916E12FB4328DBB7BF7093EB5D0F7F8FD1336475");
  self endon("_encstr_916E12FB4328DBB7BF7093EB5D0F7F8FD1336475");

  if(self.fadecurrent < var_0)
    self.fadecurrent = clamp(self.fadecurrent + 0.5 * abs(self.fadecurrent - var_0), 0.0, 1.0);
  else
    self.fadecurrent = clamp(self.fadecurrent - 0.5 * abs(self.fadecurrent - var_0), 0.0, 1.0);

  self setclientomnvar("_encstr_A6760EE5091FEBB773621879EACE6901", self.fadecurrent);
  wait 0.1;
  self.fadecurrent = var_0;
  self setclientomnvar("_encstr_A6760EE5091FEBB773621879EACE6901", self.fadecurrent);
}

registerroundswitchdvar(var_0, var_1, var_2, var_3) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_AB460CD345D5D0959B6F6B294752", var_1);
  var_0 = "_encstr_AF1805EFE726E9" + var_0 + "_encstr_85730D60523A2308A47708E073FB80";
  level.roundswitchdvar = var_0;
  level.roundswitchmin = var_2;
  level.roundswitchmax = var_3;
  level.roundswitch = getdvarint(var_0, var_1);

  if(level.roundswitch < var_2)
    level.roundswitch = var_2;
  else if(level.roundswitch > var_3)
    level.roundswitch = var_3;
}

registerroundlimitdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_95BD0B27EDABDC468DA5D62D8E", var_1);
}

registernumteamsdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_85FF09D8B33A4149816F48", var_1);
}

registerwinlimitdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_97B20977D2B91B2DAD4BD1", var_1);
}

registerwinbytwoenableddvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_ABB71054FF738E8A330F97505321A3101A87", var_1);
}

registerwinbytwomaxroundsdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_B1FD12FB4C7608A363F7EFE3C7CB6E1805E501F3", var_1);
}

registerdogtagsenableddvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_B631089D3F97E1F394E6", var_1);
}

registerscorelimitdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_B6FB0B93B87F020F183BE5E94D", var_1);
}

registertimelimitdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("_encstr_8B250A53848DC8D17A472BE9", var_1);
  setDvar("_encstr_BAE90DED0CA1B96025D758789F499B", gettimelimit());
}

registerhalftimedvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_AADE09481E247875C2EFAB", var_1);
  setDvar("_encstr_BDB40C80BAF9E1198B267DFB35F7", gethalftime());
}

registernumlivesdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_AAAE09A03BDF5128C33DB7", var_1);
}

registernumrevivesdvar(var_0, var_1) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_AFBE0B9BD5B69C2BECA5EC56DC", var_1);
}

setovertimelimitdvar(var_0) {
  setDvar("_encstr_AFE312DEB32B4EE8D25BCAA2966B95C45AAD5A1D", var_0);
}

registerlaststandhealthdvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_A53810B3C346BBAB50C17DC7DCE0A1729D49", var_0);
}

registerlaststandrevivehealthdvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarint("_encstr_9B251672990E6B6A600BBEBC45C06BA734B1A86A6169A39C", var_0);
}

registerlaststandtimerdvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("_encstr_8BF40FB278977327EBEF36346D10877FFD", var_0);
}

registerlaststandrevivetimerdvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("_encstr_A2061581D9773367DBDAA0F8C1B71528CB45058B3DF73B", var_0);
}

registerlaststandweapondvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvar("_encstr_A204106372BA8107A31948B5C70F8951652A", var_0);
}

registerlaststandweapondelaydvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("_encstr_8CB915C62C371D6AA3859B19BA2BC283B7378859B1C2E5", var_0);
}

registerlaststandsuicidetimerdvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("_encstr_8A67161B589B4735E8B09B466ABAD28DA519AC51A5AD2B39", var_0);
}

registerlaststandinvulntimerdvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("_encstr_BD2715D04A976DC953299DF179BDA8B5B3126FF81227A6", var_0);
}

registerlaststandrevivedecayscaledvar(var_0) {
  scripts\mp\utility\dvars::registerwatchdvarfloat("_encstr_8F291AC00792113B6589804B31E3451A43931459C66B88EB614141C7", var_0);
}

isroundbased() {
  if(!level.teambased)
    return 0;

  if(level.winlimit != 1 && level.roundlimit != 1)
    return 1;

  if(getgametype() == "_encstr_9B0703CD93" || getgametype() == "_encstr_B807035284" || getgametype() == "_encstr_A54F06D32A2F0498" || getgametype() == "_encstr_ACF906B79752C5E8" || getgametype() == "_encstr_93A2056DBB5853")
    return 1;

  return 0;
}

safehouse_vo_return_start(var_0) {
  return "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8";
}

vehicle_collision_ignorefuturemultievent(var_0) {
  if(var_0 == safehouse_vo_return_start() && (isDefined(level._id_14687) || deposit_from_compromised_convoy_delayed_failsafe()))
    return 1;

  return 0;
}

deposit_from_compromised_convoy_delayed_failsafe() {
  return getdvarint("_encstr_BE39126E1B27AF134ED7BA372BF52CECCA738ECD", 0) > 0 || istrue(level.disable_oob_immunity_on_riders);
}

isfirstround() {
  if(!level.teambased)
    return 1;

  if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0)
    return 1;

  return 0;
}

nextroundisfinalround() {
  if(level.forcedend)
    return 1;

  if(!level.teambased)
    return 1;

  if(level.roundlimit > 1 && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] >= level.roundlimit - 1 && !istimetobeatrulegametype() && !isscoretobeatrulegametype())
    return 1;

  if(isovertimesupportedgametype() && (hitroundlimit() || hitwinlimit())) {
    if(shouldplaywinbytwo() && islastwinbytwo())
      return 1;
    else if(istimetobeatrulegametype() || isscoretobeatrulegametype()) {
      if(game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] == 1)
        return 1;
    } else if(!level.playovertime)
      return 1;
  }

  var_0 = 0;

  foreach(var_2 in level.teamnamelist) {
    if(level vehicle_collision_ignorefuturemultievent(var_2)) {
      continue;
    }
    var_3 = getroundswon(var_2);

    if(var_3 == level.winlimit - 1) {
      var_0 = 1;
      break;
    }
  }

  var_5 = level.winlimit > 0 && var_0;

  if(var_5 && allteamstied()) {
    if(isovertimesupportedgametype())
      return 0;
    else
      return 1;
  }

  return 0;
}

nextroundismatchpoint() {
  if(level.forcedend)
    return 1;

  if(!level.teambased)
    return 1;

  if(level.roundlimit > 1 && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] >= level.roundlimit - 1 && !istimetobeatrulegametype() && !isscoretobeatrulegametype())
    return 1;

  if(isovertimesupportedgametype() && (hitroundlimit() || hitwinlimit())) {
    if(shouldplaywinbytwo() && islastwinbytwo())
      return 1;
    else if(istimetobeatrulegametype() || isscoretobeatrulegametype()) {
      if(game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] == 1)
        return 1;
    } else if(!level.playovertime)
      return 1;
  }

  var_0 = 0;

  foreach(var_2 in level.teamnamelist) {
    if(level vehicle_collision_ignorefuturemultievent(var_2)) {
      continue;
    }
    var_3 = getroundswon(var_2);

    if(var_3 == level.winlimit - 1) {
      if(shouldplaywinbytwo() && istrue(game["_encstr_81B214E944CF327529C890144977980FD94F2F69D5B8"]))
        game["_encstr_81B214E944CF327529C890144977980FD94F2F69D5B8"] = 0;

      return 1;
    }
  }

  return 0;
}

wasonlyround() {
  if(level.playovertime)
    return 0;

  if(!level.teambased)
    return 1;

  if(isDefined(level.onlyroundoverride))
    return 0;

  if(level.winlimit == 1 && hitwinlimit())
    return 1;

  if(level.roundlimit == 1)
    return 1;

  return 0;
}

waslastround() {
  if(level.forcedend)
    return 1;

  if(istrue(level.initcircuitbreakers))
    return 1;

  if(wasonlyround())
    return 1;

  if(!level.teambased)
    return 1;

  if(hitroundlimit() || hitwinlimit())
    return !level.playovertime;

  return 0;
}

iswinbytworulegametype() {
  switch (getgametype()) {
    case "_encstr_A54F06D32A2F0498":
    case "_encstr_9B0703CD93":
    case "_encstr_B807035284":
    case "_encstr_A9B606B0C956B916":
      return getdvarint("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_B6D31121680355C3EA95CFDF0550171EA1401A", 0) == 1;
  }

  return 0;
}

getmaxwinbytworounds() {
  return getdvarint("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_920513E787CA6871117B9B90D5F1588E42170D293F", level.winlimit);
}

shouldplaywinbytwo() {
  var_0 = game["_encstr_B81B0A39EDABE69137D5BDCD"]["_encstr_9A8507BA4040188D08"];
  var_1 = game["_encstr_B81B0A39EDABE69137D5BDCD"]["_encstr_8E8405EA382B2A"];
  return iswinbytworulegametype() && abs(var_0 - var_1) < 2 && game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] < getmaxwinbytworounds();
}

islastwinbytwo() {
  return shouldplaywinbytwo() && game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] == getmaxwinbytworounds() - 1;
}

_id_1332B() {
  var_0 = game["_encstr_B81B0A39EDABE69137D5BDCD"]["_encstr_9A8507BA4040188D08"];
  var_1 = game["_encstr_B81B0A39EDABE69137D5BDCD"]["_encstr_8E8405EA382B2A"];
  return abs(var_0 - var_1) < 2;
}

istimetobeatrulegametype() {
  switch (getgametype()) {
    case "_encstr_A1D0081CC297B1EDB08C":
    case "_encstr_819B0572BF80BB":
    case "_encstr_8E1904B3F501":
      return 1;
  }

  return 0;
}

intimetobeat() {
  return isDefined(game["_encstr_A16D07532531CB4BF7"]) && game["_encstr_A16D07532531CB4BF7"] == "_encstr_A1680AE42B6CF6E48C152A12";
}

settimetobeat(var_0) {
  if(!istimetobeatrulegametype())
    return 0;

  var_1 = getsecondspassed();
  var_2 = scripts\mp\gamescore::_getteamscore(var_0);

  if(!istimetobeatvalid() || var_1 < game["_encstr_8AC00BAB7C452B05C2338B8B83"] && var_2 >= game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"]) {
    if(game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] != "_encstr_8BBA05185F8B99" && game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] != var_0)
      game["_encstr_AD900E232359BABC98958F964BC1DCE2"] = game["_encstr_8AC00BAB7C452B05C2338B8B83"];

    game["_encstr_8AC00BAB7C452B05C2338B8B83"] = var_1;
    game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] = var_0;
    game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"] = var_2;
    return 1;
  }

  return 0;
}

istimetobeatvalid() {
  return game["_encstr_8AC00BAB7C452B05C2338B8B83"] != 0;
}

shouldplaytimetobeatot() {
  return istimetobeatvalid() && game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] == 1;
}

isscoretobeatrulegametype() {
  switch (getgametype()) {
    case "_encstr_A61F054B28EBE0":
      return 1;
  }

  return 0;
}

setscoretobeat(var_0, var_1) {
  if(!isscoretobeatrulegametype())
    return 0;

  var_2 = game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] != "_encstr_8BBA05185F8B99" && var_1 == game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"];

  if(var_1 >= game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"]) {
    if(game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] != "_encstr_8BBA05185F8B99" && game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] != var_0)
      game["_encstr_883713937828897747AB8029C109B9058012E7F399"] = game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"];

    game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"] = var_0;
    game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"] = var_1;
  }

  foreach(var_4 in level.players) {
    var_4 setclientomnvar("_encstr_8FF119C32B2FB02533F57B446ADB08EB42505FD16BA8888B210B5B", scripts\engine\utility::ter_op(var_4.team == game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"], game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"], game["_encstr_883713937828897747AB8029C109B9058012E7F399"]));
    var_4 setclientomnvar("_encstr_8A0416B3C8487F75D8237957F9507DA790C3AA99313D27AB", scripts\engine\utility::ter_op(var_4.team != game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"], game["_encstr_ABFD10CBF8B8B58970452F374136A2E7E8C1"], game["_encstr_883713937828897747AB8029C109B9058012E7F399"]));
  }

  if(var_2)
    return "_encstr_8D19048EA595";
  else
    return game["_encstr_A5D40F8ED2DACA51F62456C2D14556586B"];
}

shouldplayscoretobeatot() {
  return isscoretobeatrulegametype() && game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] == 1;
}

isovertimesupportedgametype() {
  if(isgamebattlematch())
    return 1;

  switch (getgametype()) {
    case "_encstr_A1D0081CC297B1EDB08C":
    case "_encstr_9719046E3182":
    case "_encstr_97AB06BBB583D1F5":
    case "_encstr_A61F054B28EBE0":
    case "_encstr_819B0572BF80BB":
    case "_encstr_8E1904B3F501":
      return 1;
    case "_encstr_B60703EACA":
    case "_encstr_A54F06D32A2F0498":
    case "_encstr_9B0703CD93":
    case "_encstr_B807035284":
    case "_encstr_A9B606B0C956B916":
      return iswinbytworulegametype();
  }

  return 0;
}

getmaxovertimeroundsbygametype() {
  if(isgamebattlematch())
    return -1;

  var_0 = 0;

  switch (getgametype()) {
    case "_encstr_A1D0081CC297B1EDB08C":
    case "_encstr_97AB06BBB583D1F5":
    case "_encstr_819B0572BF80BB":
    case "_encstr_8E1904B3F501":
    case "_encstr_A54F06D32A2F0498":
    case "_encstr_9B0703CD93":
    case "_encstr_B807035284":
      var_0 = 2;
      break;
    case "_encstr_9719046E3182":
    case "_encstr_B60703EACA":
      var_0 = 1;
      break;
  }

  if(isanymlgmatch() && !istimetobeatrulegametype())
    return -1;

  return var_0;
}

getwingamebytype() {
  if(!isDefined(level.wingamebytype)) {
    if(!isroundbased() || !isobjectivebased() || ismoddedroundgame())
      level.wingamebytype = "_encstr_96040B1D59B0AD35B1F64E599B";
    else
      level.wingamebytype = "_encstr_B81B0A39EDABE69137D5BDCD";
  }

  return level.wingamebytype;
}

issimultaneouskillenabled() {
  if(!isDefined(level.simultaneouskillenabled))
    level.simultaneouskillenabled = getdvarint("_encstr_A3ED0B751E5F0B7A8F49291169", 0) == 0;

  return level.simultaneouskillenabled;
}

cantiebysimultaneouskill() {
  if(!issimultaneouskillenabled())
    return 0;

  var_0 = 0;

  switch (getgametype()) {
    case "_encstr_9707038CB6":
    case "_encstr_B41904BB8593":
    case "_encstr_931D068662634370":
    case "_encstr_8A1804DAAB75":
    case "_encstr_AA5606FD1AF05085":
    case "_encstr_B81904B04E6B":
      var_0 = 1;
  }

  return var_0;
}

shouldplayovertime() {
  if(!hitroundlimit() && !hitwinlimit())
    return 0;

  if(!isovertimesupportedgametype())
    return 0;

  var_0 = allteamstied();

  if(var_0 && inovertime()) {
    var_1 = getmaxovertimeroundsbygametype();
    var_0 = scripts\engine\utility::ter_op(var_1 == -1, 1, game["_encstr_976315179550E2533320C2B9481503DF48419C61E3082F"] < var_1);
  }

  var_2 = shouldplaywinbytwo();
  var_3 = shouldplaytimetobeatot();
  var_4 = shouldplayscoretobeatot();
  return !level.forcedend && (var_0 || var_2 || var_3 || var_4);
}

resetscoreonroundstart() {
  if(istrue(level.resetscoreonroundstart))
    return 1;

  return (getgametype() == "_encstr_8E1904B3F501" || getgametype() == "_encstr_97AB06BBB583D1F5") && !inovertime() && getwingamebytype() == "_encstr_B81B0A39EDABE69137D5BDCD";
}

canplayhalfwayvo() {
  if(!isDefined(level.didhalfscorevoboost))
    level.didhalfscorevoboost = 0;

  if(level.didhalfscorevoboost)
    return 0;

  switch (getgametype()) {
    case "_encstr_9A7205B39CB919":
    case "_encstr_A7290676E4D2378C":
    case "_encstr_9707038CB6":
    case "_encstr_B41904BB8593":
    case "_encstr_BDD705AD7BD143":
    case "_encstr_8E07030349":
    case "_encstr_A20D05FBEB01F2":
    case "_encstr_931D068662634370":
    case "_encstr_959105B99040BD":
    case "_encstr_85EF050CB150E7":
    case "_encstr_B60703EACA":
    case "_encstr_819B0572BF80BB":
    case "_encstr_8218041DF5FA":
    case "_encstr_AAE507E8423F63C163":
    case "_encstr_AA5606FD1AF05085":
    case "_encstr_B81904B04E6B":
      return 1;
    case "_encstr_A5CF08F84A0788E8B2E3":
    case "_encstr_8A1804DAAB75":
    case "_encstr_8E1904B3F501":
    case "_encstr_A54F06D32A2F0498":
    case "_encstr_9B0703CD93":
    case "_encstr_B807035284":
      return 0;
    default:
      return 0;
  }
}

hittimelimit() {
  if(scripts\mp\utility\dvars::getwatcheddvar("_encstr_8B250A53848DC8D17A472BE9") <= 0)
    return 0;

  var_0 = scripts\mp\gamelogic::gettimeremaining();

  if(var_0 > 0)
    return 0;

  return 1;
}

hitroundlimit() {
  if(level.roundlimit <= 0)
    return 0;

  return game["_encstr_8DC30DAA0285FD69FAE113371B1934"] >= level.roundlimit;
}

hitscorelimit() {
  if(isobjectivebased())
    return 0;

  if(level.roundscorelimit <= 0)
    return 0;

  if(level.teambased) {
    foreach(var_1 in level.teamnamelist) {
      if(game["_encstr_96040B1D59B0AD35B1F64E599B"][var_1] >= level.roundscorelimit)
        return 1;
    }
  } else {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(isDefined(var_4.score) && var_4.score >= level.roundscorelimit)
        return 1;
    }
  }

  return 0;
}

hitwinlimit() {
  if(level.winlimit <= 0)
    return 0;

  if(!level.teambased)
    return 1;

  foreach(var_1 in level.teamnamelist) {
    if(getroundswon(var_1) >= level.winlimit)
      return 1;
  }

  return 0;
}

getscorelimit() {
  if(isroundbased()) {
    if(level.roundlimit)
      return level.roundlimit;
    else
      return level.winlimit;
  } else
    return level.roundscorelimit;
}

getroundswon(var_0) {
  return game["_encstr_B81B0A39EDABE69137D5BDCD"][var_0];
}

allteamstied() {
  var_0 = getwingamebytype();
  var_1 = undefined;

  foreach(var_3 in level.teamnamelist) {
    if(!isDefined(var_1)) {
      var_1 = game[var_0][var_3];
      continue;
    }

    if(var_1 != game[var_0][var_3])
      return 0;
  }

  return 1;
}

isobjectivebased() {
  return level.objectivebased;
}

gettimelimit() {
  if(inovertime() && (!isDefined(game["_encstr_BA4B0FE95DF1DB273D7CFBF2E38D6795F0"]) || !game["_encstr_BA4B0FE95DF1DB273D7CFBF2E38D6795F0"])) {
    if(istrue(game["_encstr_8AC00BAB7C452B05C2338B8B83"]))
      return game["_encstr_8AC00BAB7C452B05C2338B8B83"];
    else {
      var_0 = getdvarfloat("_encstr_AFE312DEB32B4EE8D25BCAA2966B95C45AAD5A1D");

      if(var_0 > 0)
        return var_0;
      else
        return scripts\mp\utility\dvars::getwatcheddvar("_encstr_8B250A53848DC8D17A472BE9");
    }
  } else if(isDefined(level.extratime) && level.extratime > 0)
    return scripts\mp\utility\dvars::getwatcheddvar("_encstr_8B250A53848DC8D17A472BE9") + level.extratime;
  else
    return scripts\mp\utility\dvars::getwatcheddvar("_encstr_8B250A53848DC8D17A472BE9");
}

gethalftime() {
  if(inovertime())
    return 0;
  else if(isDefined(game["_encstr_BA4B0FE95DF1DB273D7CFBF2E38D6795F0"]) && game["_encstr_BA4B0FE95DF1DB273D7CFBF2E38D6795F0"])
    return 0;
  else
    return scripts\mp\utility\dvars::getwatcheddvar("_encstr_AADE09481E247875C2EFAB");
}

inovertime() {
  return isDefined(game["_encstr_A16D07532531CB4BF7"]) && game["_encstr_A16D07532531CB4BF7"] == "_encstr_8B6D0940CC35339149DA08";
}

gamehasstarted() {
  if(isDefined(level.gamehasstarted))
    return level.gamehasstarted;

  if(level.teambased) {
    foreach(var_1 in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(var_1, "_encstr_A1310B432F9BDEFBEF4393B0F1"))
        return 1;
    }

    return 0;
  }

  return level.maxplayercount > 1;
}

getlivingplayers(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isalive(var_3)) {
      continue;
    }
    if(level.teambased && isDefined(var_0)) {
      if(var_0 == var_3.pers["_encstr_8AEF05472BC2D6"])
        var_1[var_1.size] = var_3;

      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

rankingenabled() {
  if(!isPlayer(self))
    return 0;

  return level.rankedmatch && !self.usingonlinedataoffline;
}

onlinestatsenabled() {
  if(!isPlayer(self))
    return 0;

  return level.onlinestatsenabled && !self.usingonlinedataoffline;
}

privatematch() {
  return level.onlinegame && getdvarint("_encstr_93390B136AA2628AA8A93529D4");
}

lobbyteamselectenabled() {
  return level.systemlink || privatematch() && getdvarint("_encstr_95900B1C8FD0D5FFA8409922B5", 0) || _func_426();
}

matchmakinggame() {
  return level.matchmakingmatch;
}

getgametypenumlives() {
  return scripts\mp\utility\dvars::getwatcheddvar("_encstr_AAAE09A03BDF5128C33DB7");
}

getlastlivingplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_0) && var_3.team != var_0) {
      continue;
    }
    if(!var_3 scripts\cp_mp\utility\player_utility::_isalive() && !var_3 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }
    if(isDefined(var_3.switching_teams) && var_3.switching_teams) {
      continue;
    }
    var_1 = var_3;
  }

  return var_1;
}

_id_13E13() {
  var_0 = undefined;

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive() && !var_2 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }
    if(level.codcasterenabled) {
      if(var_2 ismlgspectator())
        continue;
    }

    if(isDefined(var_0))
      return undefined;
    else
      var_0 = var_2;
  }

  if(isDefined(var_0))
    return var_0;
  else
    return undefined;
}

getpotentiallivingplayers() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive() && !var_2 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }
    if(level.codcasterenabled) {
      if(var_2 ismlgspectator())
        continue;
    }

    var_0[var_0.size] = var_2;
  }

  return var_0;
}

denysystemicteamchoice() {
  if(!isbot(self) && !initmaxspeedforpathlengthtable(self)) {
    if(isgamebattlematch())
      return 1;

    if(dotournamentendgame())
      return 1;

    if(level.codcasterenabled)
      return 0;
  }

  if(getdvarint("_encstr_8C93142646BB27FBFB2F8360C30933B7722C90A3DEA2", 0) > 0)
    return 1;

  return 0;
}

allowteamassignment() {
  if(getgametype() == "_encstr_B607038AAB" || getgametype() == "_encstr_8E9E088D9C58E65B2B19")
    return level.teambased;

  var_0 = doesmodesupportplayerteamchoice();
  return var_0;
}

doesmodesupportplayerteamchoice() {
  if(getgametype() == "_encstr_8A1804DAAB75" || getgametype() == "_encstr_AAE507E8423F63C163")
    return 0;

  var_0 = int(tablelookup("_encstr_A107165A83180FCEF06BDCC959E8128B57B9C242E08687C3", 0, getgametype(), 4));
  return var_0 > 0;
}

allowclasschoice() {
  if(getdvarint("_encstr_8C93142646BB27FBFB2F8360C30933B7722C90A3DEA2", 0) > 0 || skiploadout())
    return 0;

  if(isDefined(level.allowclasschoicefunc)) {
    var_0 = self[[level.allowclasschoicefunc]]();

    if(isDefined(var_0))
      return var_0;
  }

  if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") && isDefined(level.bypassclasschoicefunc))
    return 0;

  var_1 = int(tablelookup("_encstr_A107165A83180FCEF06BDCC959E8128B57B9C242E08687C3", 0, getgametype(), 5));

  if(!isai(self) && istrue(level.denyclasschoice))
    return 0;

  return var_1;
}

skiploadout() {
  if(getgametype() == "_encstr_9707038CB6")
    return istrue(level.aonrules);
  else if(getgametype() == "_encstr_A9B606B0C956B916")
    return isDefined(level.arenaloadouts) && level.arenaloadouts != 1;

  return 0;
}

showfakeloadout() {
  return 0;
}

setfakeloadoutweaponslot(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_3 = [];

  if(var_2 != "_encstr_87610AB4EE83FAD6374B3395")
    var_3 = getweaponattachments(var_0);

  if(isDefined(var_2))
    var_4 = tablelookuprownum("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 4, var_2);
  else {}

  for(var_5 = 0; var_5 < 3; var_5++) {
    var_6 = -1;

    if(isDefined(var_3[var_5])) {
      if(!scripts\mp\utility\weapon::isattachmentsniperscopedefault(var_0, var_3[var_5]))
        var_6 = tablelookuprownum("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_3[var_5]);
    }
  }
}

setcommonrulesfrommatchrulesdata(var_0) {
  var_1 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_AB580A05672AE35D5FFF50B8");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_8C040BBEA3CAB0B5C6B7D5373A", var_1);
  var_2 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_924509C9454670BEB7ABA9");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_BEA80A1E58376F9833A3E30F", var_2);
  var_3 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_8B250A53848DC8C17A472BE9");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_8E6F0BE85BD29B9174974068CB", var_3);
  registertimelimitdvar(getgametype(), var_3);
  var_4 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B6FB0B93B87F020F1C3BE5E94D");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_88520CD11BF6EF7BAF0CF3F931B3", var_4);
  registerscorelimitdvar(getgametype(), var_4);
  var_5 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_97B20977D2B9132DAD4BD1");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_B28B0AAFBB2DB931B4DA2DE8", var_5);
  registerwinlimitdvar(getgametype(), var_5);
  var_6 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_95BD0B27EDABDC4689A5D62D8E");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_BE630CD7BD584DEB1888DCEFECB0", var_6);
  registerroundlimitdvar(getgametype(), var_6);
  var_7 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_AB460CD345D5D095996F6B294752");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_85730D60523A2308A4F708E073FB80", var_7);
  registerroundswitchdvar(getgametype(), var_7, 0, 9);
  var_8 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_ABB71054FF739E8AB30F97515321A3101A87");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_B6D31121680355C3EA95CFDF0550171EA1401A", var_8);
  registerwinbytwoenableddvar(getgametype(), var_8);
  var_9 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B1FD12FB4C7609A361F7EFA3C7CB7E1805E501F3");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_920513E787CA6871117B9B90D5F1588E42170D293F", var_9);
  registerwinbytwomaxroundsdvar(getgametype(), var_9);
  var_10 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B631089D3F97A1F394E6");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_8316094F78B8E73DB90F9B", var_10);
  registerdogtagsenableddvar(getgametype(), var_10);
  var_11 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_84F6156833910335E14260F59F8A5988F733D920EF2D7B");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_AD2E167DE60E85EE370593F61DAC6C47D2DB9BA296D62BE4", var_11);
  var_12 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_AAAE09A03BDF4128C33DB7");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_A5B70A7E58D31199826EB896", var_12);
  registernumlivesdvar(getgametype(), var_12);
  var_13 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_AFBE0B9BD5B6942BECA5EC56DC");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_A6A90CC9A3CBEF46426B5A332A77", var_13);
  registernumrevivesdvar(getgametype(), var_13);
  setdynamicdvar("_encstr_856E15E68D93D7E0D80BF25639FADA163CA1AC0B8DD134", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B19F0A5BC2F0122BC2B1D11A"));
  setdynamicdvar("_encstr_874F1B0F078649C8D081F8C7DB71E822D7819B9BCDA57295A84BF4CDD1", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B8B60C43CAC28D8ED09259B3CAB9"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_A2361158ECA233609C4348F857A578410AD5CD", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B8B60C43CAC28D8ED09259B3CAB9"));
  setdynamicdvar("_encstr_92B31E6A264B092BC11117337037231243783E7CC10BFB4133223723527088C3", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B42513393BC2BEE5F58D670519EFC25AB3E2508A83"));
  setdynamicdvar("_encstr_AF7F18B9B1C9EBE0B1B0BC2BC9AFC8D29BB0988D5653DEABE6D1", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_BE860DE4FC28B7AEC9290407E3066D"));
  setdynamicdvar("_encstr_BE7315A211E8277359AB87CFB5E8FA51B89BD2EBC9A0A4", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_A5510A30AA778D29B3C97D51"));
  var_14 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_A53810B3C346BBAB50C17DC7DCE0A1729D49");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_8A5511EEC287465822842B3DBCDCE8071BDB80", var_14);
  registerlaststandhealthdvar(var_14);
  var_15 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_9B251672990E6B6A600BBEBC45C06BA734B1A86A6169A39C");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_8ED717A07B2197402FCBD94A7DFB8F98942C72E4D7BF8A39F0", var_15);
  registerlaststandrevivehealthdvar(var_15);
  var_16 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_8BF40FB278977327EBEF36346D10877FFD");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_8FA6100F03A20E1893DBE118C7BCB8495AD3", var_16);
  registerlaststandtimerdvar(var_16);
  var_17 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_A2061581D9773367DBDAA0F8C1B71528CB45058B3DF73B");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_A93C16FA630B9BE84D1D859B4629569DB467ACA24BDA2BE4", var_17);
  registerlaststandrevivetimerdvar(var_17);
  var_18 = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_8A67161B589B4735E8B09B466ABAD28DA519AC51A5AD2B39");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_9A7E17B94911D3F5DBB19358045745571784D37F9F87F89D7E", var_18);
  registerlaststandsuicidetimerdvar(var_18);
  setdynamicdvar("_encstr_B8241B93B845495B183FF1E54E86AB0FA5704B4AA01FBF0F1117E01768", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_9B33109E752E73EC42176B3157053F1387D8"));
  level.matchrules_damagemultiplier = 0;
  setdynamicdvar("_encstr_8575137616EB7729A10F98517BF92061E2FAE3FE6D", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_96B00A7E4F82030372481F2D"));
  setdynamicdvar("_encstr_BE2516DB6F38792F07109239BBE77F2EA0D35455A9987AEF", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B67914DC0E568D47583A596A7B32CA828D8DDEEEB223"));
  setdynamicdvar("_encstr_86E7166FB8EBF7DA7301E7117F01229F1350BF9B582101A2", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_88C00CF3C870171C98018C8B3390"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_BA4F0D51325B4AFCF99017FB78B3AD", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_BDBE0CB696B1C6C616B58A5E0EAC"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_AC0C128F19B324D80F4EC829E8B735D6BB99A3C3", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_8C7413E233105B739FC1B7D6F535E89C80381BEF29"));
  setdynamicdvar("_encstr_8C851703DE2317BFA33002B968E576AB98B5B581E0E807C669", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_A9020EABDB72560815255048D4F5A897"));
  setdynamicdvar("_encstr_9A2112B98D39F53B2CB695EB667B938DCABA859D", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_88500EB83A37F37B3F2CFCFF21AF84A5"));
  setdynamicdvar("_encstr_9B7018DCB127EB76B0D695FAC9B0C81639842D46AC285AE6CECD", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_AA070F4EB02358E4244B8C5635A1BD8E37"));
  setdynamicdvar("_encstr_B6A01973C790D197BFB84AD1E0879BDE508D30E15180EF6B555083", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_837211D87BDA83C2E6E6902D8C2BA29BACB5E5"));
  setdynamicdvar("_encstr_8A3F19076FC348D091AD51EE9579900E2A83C9BBEBDAB7F8A6079B", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_A69C117B40C5E0D6C7DF530F6B9D6734A0F1E7"));
  setdynamicdvar("_encstr_A7A71CCDC69CD7EC2C6BCAFA194B6E2C13B1B2E68385DDB9C60BB5B2E416", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B69B1391D237162663CAA9070BDDB934C2D656C9C2"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_96131449B3894798E035AA850F70A6D720A9628279DB", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_86410DE597333F0B678D9589355988"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_91B613AFE65D4BD85A2356CD382CEEE68CCA1B0B2F", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_965C12E657B41BD21959A93885DDE611B26358E5"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_829F126E5BE9383DB30F474937CBF0F085F5D122", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_87F511A00A83EB6FBF430F8F3FEBD5A36D9258"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_868016716B3753D79353D3D873BB5D436D60EA9BF69FF34B", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_AA8E148C6E53FB674DEF9818D76E7D231A96030F85CB"));
  setdynamicdvar("_encstr_BD781816114E3717BA7E6371622989074D6381C601A033E25018", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B86B0D2570C53FAAA2811F4872C4E2"));
  level.matchrules_allowcustomclasses = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_87C013C2C6B17BEE1A5DCDA3DEB60DB158376E2BE6");
  level.supportintel = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_AB920BFF489D7734D78843E528");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_95591220F12318474310E0D07A1A39937F99B2AE", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_97C51137E43B607F440AC0C883A32D79679B46"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_97390CEB58638DDE77055993B56E", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_BDDD0BCA8DB14A27D898EABAAA"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_ADCD0D3760636950DFF10BF3376B03", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_A31F0CEF447502281BEBE94B0B23"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_A34C0F76FA03BF3815E167A93C3C30FB93", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_8F8B0EAD848BCB55C1C721EC0A0D09EC"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_9214148FB570C0029582523B020922E79B2351CA4207", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_A9451313BF33C827C9888D82B068569393183710EB"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_95AB17D79CBDEACD2325CAD12C4BCDA9A39395B0DA05277B9D", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B8C916DBCFB5EA6C9151EBB6C8A883838E631F27D95EA227"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_B1CC147D19B20BD1A1252B47C296CD9A3A9CACC25BCD", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_811A13E1AF6F1329D3C59B89D06A9A519632690F7F"));
  setdynamicdvar("_encstr_AF9C1C4776324FA223DAF53FC9909A2B51ABDA1668434737C55A4A76B2B7", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_ADB113CBD822109B8C675040C3A733DCEBAF62306B"));
  setdynamicdvar("_encstr_B13819BFD77BF0580935D9965BE2909FB46709393F432E2B218C03", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_8BA110672891B0701BF9CD02DD15AA6978B8"));
  setdynamicdvar("_encstr_81751D4F98CBD7FA5321C7711653C3B593D97FC7B84528428DCCCF3A7709AA", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_9B22143E45AB55029D9F671B4F80613A27F54B177371"));
  setdynamicdvar("_encstr_858F18D7DE83CFBF1890D14F02CB5B027DE71738ED342E77A527", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_8F110F9BEA1C2B4E28F6A59BD1DC53F623"));
  setdynamicdvar("_encstr_8ECC1E63506D78E759BB13885A19495F35E9D3E049D7031D2B8568D5784F3033", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_84F6156833910335E14260F59F8A5988F733D920EF2D7B"));
  setdynamicdvar("_encstr_ACFE154B609DA1EF41D1050779E9EB34E37040A28013E0", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_873B0F7F0B88491BA1DBB3D3715D22B9CB"));
  setdynamicdvar("_encstr_8EC81CCD8D93AF9D85B5ACF5AC17AE4BE0B695B9E8D46A41C97BD12B8D47", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_8BAF13CAB85D4BE0DA95B98E9A4D41277B472B368E"));
  setdynamicdvar("_encstr_8FE51EB3E9BEF7579843C5F779F01A57EE60AA283115934D4007F0D12140A7D3", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B1BF1517870BAAF3E1822142042BC8D576601FA1AB1AD6"));
  setdynamicdvar("_encstr_82DB1AC6CB18A0DC51A1D3F78DDF53689EBB8DA7D80897EB654EBD7A", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_9BBB110CBBF036FB41D1906A58287F2DD81B92"));
  setdynamicdvar("_encstr_850C14573F931880A19D613E8486C94FDA8FB1E7F71B", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_99400B9A78875EB751D19F87E5"));
  setdynamicdvar("_encstr_A55013D38A731888F6C56B27F91D48DBD361281823", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_93F20AF326D3608982EA28E8"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_AB010FC6324238867BE78F9B1392D508EC", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"));
  setdynamicdvar("_encstr_82DB17C6CB18A0DC51A1D3F787C753C00C8F893781B885ECE5", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B8030E3A90CF6B771950D75F909101B2"));
  setdynamicdvar("_encstr_81A61B7BCF98D98FA7B072D99903D30C63FBF8E445B81E0BC528CA6203", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_925712BFD914B24C311A139AD1E89C997B1B276B"));
  setdynamicdvar("_encstr_91631A0BD64B514A5953575747B86C5B4DEF3123A933070FC8CF0F2A", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_8B4911AC3C662DC65036D1A5672B4596B55639"));
  setdynamicdvar("_encstr_86A61F93C99ED7B2D07BB9AD3521FA4F4683683A90FD7768B873D4872308028760", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_8F731442B0C02C20FF93D72FC1148A7CB959BECA28C0"));
  level.crankedbombtimer = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_A56611CF76F7181BE5BD95B82D4EC19B0B3592");
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_91B612AFC69C0B9BDA2B4609B7AD4C452DDA5993", level.crankedbombtimer);
  scripts\mp\cranked::registercrankedtimerdvar(getgametype(), level.crankedbombtimer);
  setdynamicdvar("_encstr_932D120B7E330FA19A8B7B714540FFA76F4BA86C", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_A55E0998E22F7F10D76635"));
  setdynamicdvar("_encstr_925916E7EF1ED14710B857D173F88B9B7B0737134BC82A3D", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_B8110DD3FF021B18DE497CBD6F03BD"));
  setdynamicdvar("_encstr_B80817528380F1C006B5F5B17015F9AF7B43891F3BA457F31A", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_BA120E085F6928B692A7C9CF0FDA7198"));

  if(!isDefined(var_0))
    setdynamicdvar("_encstr_A621104F98CBD7CB5B27C5719C7583A9D3C0", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_A54E0D719B1F05C0B7C45315F91A50"));

  setDvar("_encstr_BAE50BF142A0C7670673B9A11F", getdvarint("_encstr_9A2112B98D39F53B2CB695EB667B938DCABA859D") == 1);
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_8E730F8922EDB3D067CC3D27D40B3C1F16", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_923F0EBB1E376BDB730A79C3C20B9838"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_92030FE79BAAEB101CB27FD11ADBD09172", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_836F0EA35788D01196DBAB43B28B2CB8"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_82A310D12BF5E3F8EB336FFD2A73C1BB9B12", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_83060F8270D0F6D3362917B3F9D54A2443"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_AC5C15FF61C8EA16D0037407796833B290F10347356DF3", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_9927146BBD011855435B4B4B03AB93C8B45E3020A363"));
  setdynamicdvar("_encstr_AF1805EFE726E9" + getgametype() + "_encstr_A6D511FA38DBA5CDA3CD0A2BC9D235B42DB136", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_9A2810E07B96E68EDC0A569CA5A696A5D8D8"));
  setdynamicdvar("_encstr_AC2013AB1EBA317CC26F2B577FBA31B055B5108087", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_A7C30A7FD931F347952A7878"));
  setdynamicdvar("_encstr_8DFE1527F0A3AFB233C49257A1FF4B5DCD28D76BE0B9CF", "_encstr_B40101");
  setdynamicdvar("_encstr_8A19149BB04D713331ACC0E4CF19FF4F8F2850E218CF", "_encstr_B40101");

  if(privatematch() || level.systemlink || isanymlgmatch()) {
    level.codcasterenabled = getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_8AB31120CA2787698724E5662DCB514D8DF290");
    setDvar("_encstr_B4CC0B9A3D9A9CE915A03DA99A", level.codcasterenabled);
    setdynamicdvar("_encstr_85F6186F966321C7B788A810A5332B2B8073CC380BD9A150DDC5", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_BD480F7A81953FAC2129A9A23141B44FB5"));
    setdynamicdvar("_encstr_ACCD189B1B27AFEC58B6ACF5277BABB9C8353A58393A8A5AB6B2", getmatchrulesdata("_encstr_BE700D6CB76BDAF673F4E0E84BF673", "_encstr_AB030F63F545400509938BB58B21DB10ED"));
  }
}

reinitializematchrulesonmigration() {
  for(;;) {
    level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
    [[level.initializematchrules]]();
  }
}

reinitializethermal(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0))
    var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");

    if(isDefined(self.lastvisionsetthermal))
      self visionsetthermalforplayer(self.lastvisionsetthermal, 0);
  }
}

getmatchrulesspecialclass(var_0, var_1) {
  var_2 = [];
  var_2["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  var_3 = [];
  var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 0, "_encstr_AC20072B9FA9487832");
  var_2["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 0, "_encstr_BA6F1012A0E9A677F8598D8EEDA757AB4318", 0, "_encstr_B19A0BD803A4E10F42E50598BB");
  var_2["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 0, "_encstr_BA6F1012A0E9A677F8598D8EEDA757AB4318", 1, "_encstr_B19A0BD803A4E10F42E50598BB");
  var_2["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 0, "_encstr_B19005D885B5F6");
  var_2["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 0, "_encstr_925008E456475A6CB195");
  var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 1, "_encstr_AC20072B9FA9487832");
  var_2["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 1, "_encstr_BA6F1012A0E9A677F8598D8EEDA757AB4318", 0, "_encstr_B19A0BD803A4E10F42E50598BB");
  var_2["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 1, "_encstr_BA6F1012A0E9A677F8598D8EEDA757AB4318", 1, "_encstr_B19A0BD803A4E10F42E50598BB");
  var_2["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 1, "_encstr_B19005D885B5F6");
  var_2["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 1, "_encstr_925008E456475A6CB195");
  var_2["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = var_3;
  var_2["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = scripts\mp\class::recipe_getkillstreak(var_0, var_1, 0);
  var_2["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = scripts\mp\class::recipe_getkillstreak(var_0, var_1, 1);
  var_2["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = scripts\mp\class::recipe_getkillstreak(var_0, var_1, 2);
  return var_2;
}

isplayeroutsideofanybombsite(var_0) {
  if(isDefined(level.objectives)) {
    foreach(var_2 in level.objectives) {
      if(self istouching(var_2.noweapondropallowedtrigger))
        return 0;
    }
  }

  return 1;
}

gamehasneutralcrateowner(var_0) {
  switch (var_0) {
    case "_encstr_852009F3B82927C7799CC9":
    case "_encstr_A11805E67B3A33":
      return 1;
    default:
      return 0;
  }
}

isanymlgmatch() {
  if(isusingmatchrulesdata()) {
    if(getdvarint("_encstr_97BF0B2745629351153993898A") == 0 && getmatchrulesdata("_encstr_A722109B17986AD731A12348E89FB35D78A9") == 1)
      return 1;
  }

  return getdvarint("_encstr_BA8A0BC49EA68A9654A2292A53") || istrue(level.get_wave_max_count);
}

ismlgsystemlink() {
  if(level.systemlink && (getdvarint("_encstr_BA8A0BC49EA68A9654A2292A53") || istrue(level.get_wave_max_count)))
    return 1;

  return 0;
}

ismlgprivatematch() {
  if(privatematch() && (getdvarint("_encstr_BA8A0BC49EA68A9654A2292A53") || istrue(level.get_wave_max_count)))
    return 1;

  return 0;
}

ismlgmatch() {
  if(ismlgsystemlink() || ismlgprivatematch())
    return 1;

  return 0;
}

setmlgannouncement(var_0, var_1, var_2, var_3) {
  if(var_1 == "_encstr_8E8405EA382B2A")
    var_0 = var_0 + 2000;
  else if(var_1 == "_encstr_9A8507BA4040188D08")
    var_0 = var_0 + 1000;

  if(isDefined(var_2))
    var_0 = var_0 + (var_2 + 1) * 10000;

  if(isDefined(var_3)) {
    if(isnumber(var_3))
      var_0 = var_0 + (var_3 + 1) * 1000000;
    else
      scripts\engine\utility::error("_encstr_B2C448B863B7C90B2225B7153DAA5B281DD3F84AAF509BE5FADE8D179362195355C360B86BF43379F2B371AE2F6BC7F1A72308F0B2F88CAD5B5EF923472623A204FBF8B2E351636BC716" + var_3);
  }

  if(isDefined(var_0))
    setomnvar("_encstr_93B7145B174101D8A711E118458758C83A8FF3F3F31B", var_0);
}

ismoddedroundgame() {
  if(getgametype() == "_encstr_8218041DF5FA" || getgametype() == "_encstr_8E1904B3F501" || getgametype() == "_encstr_A61F054B28EBE0" || getgametype() == "_encstr_97AB06BBB583D1F5")
    return 1;

  return 0;
}

isusingdefaultclass(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1)) {
    if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_8C8F065F255DC395"))
      var_2 = 1;
  } else {
    for(var_1 = 0; var_1 < 6; var_1++) {
      if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_8C8F065F255DC395")) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

getmatchrulesdatawithteamandindex(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_1 == "_encstr_8E8405EA382B2A")
    var_2 = var_2 + 6;

  if(isDefined(var_6))
    return getmatchrulesdata(var_0, var_2, var_3, var_4, var_5, var_6);
  else if(isDefined(var_5))
    return getmatchrulesdata(var_0, var_2, var_3, var_4, var_5);
  else
    return getmatchrulesdata(var_0, var_2, var_3, var_4);
}

isspawnprotected() {
  return gettime() < self.spawntime + level.killstreakspawnshielddelayms;
}

ismatchstartprotected() {
  return isDefined(level.starttime) && gettime() < level.starttime + level.equipmentmatchstartshieldms;
}

unset_relic_grounded() {
  var_0 = getgametype() == "_encstr_B607038AAB";
  var_1 = getgametype() == "_encstr_931D068662634370";
  return var_0 || var_1;
}

getgametype() {
  return level.gametype;
}

round_vehicle_logic() {
  var_0 = getgametype();

  if(var_0 == "_encstr_B607038AAB") {
    var_1 = getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101");

    if(var_1 != "_encstr_B40101")
      return var_1;
  }

  return var_0;
}

usingfallback() {
  var_0 = getgametype();
  var_1 = round_vehicle_logic();
  return var_0 != var_1;
}

validate_track() {
  if(round_vehicle_logic() == "_encstr_B607038AAB")
    return 1;
  else if(round_vehicle_logic() == "_encstr_AFDD05A6AB763B")
    return 1;

  return 0;
}

lpcfeaturegated() {
  if(getdvarint("_encstr_B12B18208A227F0977A2666DA467D1D503A2A068427FE36033DD") == 1)
    return 1;

  if(getgametype() == "_encstr_B81904B04E6B" || getgametype() == "_encstr_B607038AAB" || getgametype() == "_encstr_931D068662634370" || level.leanthread == 1)
    return 1;

  return 0;
}

runleanthreadmode() {
  if(getdvarint("_encstr_B12B18208A227F0977A2666DA467D1D503A2A068427FE36033DD") == 1)
    return 1;

  if(getgametype() == "_encstr_B607038AAB" || level.leanthread == 1)
    return 1;

  return 0;
}

issquadmode() {
  return getdvarint("_encstr_A79B0AF64A38711C9EE7B139", 0) > 1;
}

gamehasinfil() {
  if(!isDefined(game["_encstr_9B8F06A38D72C380"]))
    return 0;

  var_0 = 1;

  foreach(var_2 in level.teamnamelist) {
    if(!isDefined(game["_encstr_9B8F06A38D72C380"][var_2]) || !isDefined(game["_encstr_9B8F06A38D72C380"][var_2]["_encstr_99EC06E297A25BEE"])) {
      var_0 = 0;
      break;
    }
  }

  return var_0;
}

teamhasinfil(var_0) {
  return gamehasinfil() && scripts\mp\utility\teams::isgameplayteam(var_0) && isDefined(game["_encstr_9B8F06A38D72C380"][var_0]["_encstr_99EC06E297A25BEE"]);
}

iskillstreakdenied() {
  return scripts\cp_mp\emp_debuff::is_empd() || isairdenied();
}

isairdenied() {
  if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return 0;

  return 0;
}

getmaxoutofboundstime() {
  var_0 = level.outofboundstime;

  if(!isDefined(var_0)) {
    var_0 = max(0, scripts\engine\utility::ter_op(matchmakinggame(), getdvarfloat("_encstr_870314ABF20B10C0EBC4376DDA552840FB6BC710FA8F", 3), 3));
    level.outofboundstime = var_0;
  }

  return var_0;
}

getmaxoutofboundscooldown() {
  var_0 = level.outofboundscooldown;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("_encstr_877E182E4EB32F60FD530140630FFB957AF2BEB8252A1128C723", 3));
    level.outofboundscooldown = var_0;
  }

  return var_0;
}

getmaxoutofboundsminefieldtime() {
  var_0 = level.outofboundstimeminefield;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("_encstr_8D961DA686034127A53B7475A56F885A99FB14820DCF448B3D77E4A855BB5D", 3));
    level.outofboundstimeminefield = var_0;
  }

  return var_0;
}

getmaxoutofboundsrestrictedtime() {
  level.outofboundstimerestricted = 5;
  return level.outofboundstimerestricted;
}

repair_grill_fixing_short_sfx() {
  if(!isDefined(level._id_12162))
    level._id_12162 = max(0, getdvarfloat("_encstr_870314ABF20B10C0EBC4376DDA552840FB6BC710FA8F", 5));

  return level._id_12162;
}

runbrgametypefunc() {
  var_0 = self;

  if(isDefined(var_0._id_120B4))
    return var_0._id_120B4;

  return undefined;
}

repair_grill_stop_exit_foley_sfx() {
  if(!isDefined(level._id_12164))
    level._id_12164 = getdvarint("_encstr_84371C0AB9408FEAFE7F7B375BA962E95886C217B3B87D12D567130F4BC5", 30);

  return level._id_12164;
}

repair_grill_start_enter_foley_sfx() {
  if(!isDefined(level._id_12163))
    level._id_12163 = getdvarint("_encstr_9A1A1B9B6C39D7C427AF1CB0F2B1DB0B23BE4EB2C84E2CBBAF8EA56BCA", 10);

  return level._id_12163;
}

updateobjectivetext() {
  if(self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    self setclientdvar("_encstr_A7CF0B9D6675D1895769D7CFA1", "_encstr_B40101");
  else {
    if(level.roundscorelimit > 0 && !isobjectivebased()) {
      if(isDefined(getobjectivescoretext(self.pers["_encstr_8AEF05472BC2D6"]))) {
        if(level.splitscreen) {
          self setclientdvar("_encstr_A7CF0B9D6675D1895769D7CFA1", getobjectivescoretext(self.pers["_encstr_8AEF05472BC2D6"]));
          return;
        }

        self setclientdvar("_encstr_A7CF0B9D6675D1895769D7CFA1", getobjectivescoretext(self.pers["_encstr_8AEF05472BC2D6"]), level.roundscorelimit);
        return;
        return;
      }

      return;
    }

    if(isDefined(getobjectivetext(self.pers["_encstr_8AEF05472BC2D6"])))
      self setclientdvar("_encstr_A7CF0B9D6675D1895769D7CFA1", getobjectivetext(self.pers["_encstr_8AEF05472BC2D6"]));
  }
}

setobjectivetext(var_0, var_1) {
  game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_AF3C0BA03AF218AE9C7BB038DF" + var_0] = var_1;
}

setobjectivescoretext(var_0, var_1) {
  game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_994D11DA38FD7FAF93A3666D509B670535E841" + var_0] = var_1;
}

setobjectivehinttext(var_0, var_1) {
  game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_8161103DA9B085EAED031357079B32F62896" + var_0] = var_1;
}

getobjectivetext(var_0) {
  return game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_AF3C0BA03AF218AE9C7BB038DF" + var_0];
}

getobjectivescoretext(var_0) {
  return game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_994D11DA38FD7FAF93A3666D509B670535E841" + var_0];
}

getobjectivehinttext(var_0) {
  return game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_8161103DA9B085EAED031357079B32F62896" + var_0];
}

testgamemodestringlist(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "_encstr_B40101" || !isDefined(var_1) || var_1 == "_encstr_B40101")
    return 0;

  return issubstr(var_0, var_1);
}

islaststandenabled() {
  return isDefined(level.laststand) && level.laststand == 1;
}

isteamreviveenabled() {
  return isDefined(level.laststand) && level.laststand == 2;
}

checkrealismhudsettings() {
  if(istrue(level.testrandomrealismclients)) {
    if(!isDefined(self.isrealismenabled)) {
      if(scripts\engine\utility::cointoss()) {
        self setclientomnvar("_encstr_A9320F0D41514B53F00B9B88F56682EDCC", 1);
        self.isrealismenabled = 1;
      } else {
        self setclientomnvar("_encstr_A9320F0D41514B53F00B9B88F56682EDCC", 0);
        self.isrealismenabled = 0;
      }
    }
  } else if(scripts\cp_mp\utility\game_utility::isrealismenabled())
    self setclientomnvar("_encstr_A9320F0D41514B53F00B9B88F56682EDCC", 1);
  else
    self setclientomnvar("_encstr_A9320F0D41514B53F00B9B88F56682EDCC", 0);
}

isdefending(var_0) {
  var_1 = 0;

  switch (getgametype()) {
    case "_encstr_ACF906B79752C5E8":
      if(isDefined(level.cyberemp.carrier) && self.team == level.cyberemp.ownerteam && self != level.cyberemp.carrier) {
        var_2 = distancesquared(level.cyberemp.carrier.origin, self.origin);
        var_3 = distancesquared(level.cyberemp.carrier.origin, var_0.origin);

        if(var_2 < 90000 || var_3 < 90000) {
          var_1 = 1;
          break;
        }
      }

      foreach(var_5 in level.objectives) {
        if(istrue(var_5.trigger.trigger_off)) {
          continue;
        }
        var_6 = var_5.ownerteam;

        if(var_6 == self.team) {
          var_2 = distancesquared(var_5.trigger.origin, self.origin);
          var_3 = distancesquared(var_5.trigger.origin, var_0.origin);

          if(var_2 < 90000 || var_3 < 90000) {
            var_1 = 1;
            break;
          }
        }
      }

      break;
    case "_encstr_B60703EACA":
    case "_encstr_9B0703CD93":
    case "_encstr_B807035284":
      if(self.team != game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
        break;
      }

      foreach(var_9 in level.objectives) {
        var_10 = distancesquared(var_9.trigger.origin, var_0.origin);

        if(var_10 < 90000) {
          var_1 = 1;
          break;
        }
      }

      break;
    case "_encstr_A7290676E4D2378C":
    case "_encstr_A20D05FBEB01F2":
    case "_encstr_A54F06D32A2F0498":
    case "_encstr_8218041DF5FA":
    case "_encstr_B81904B04E6B":
      foreach(var_9 in level.objectives) {
        if(self.team != var_9.ownerteam) {
          continue;
        }
        var_13 = distancesquared(var_9.curorigin, self.origin);
        var_14 = distancesquared(var_9.curorigin, var_0.origin);

        if(var_13 < 90000 || var_14 < 90000) {
          var_1 = 1;
          break;
        }
      }

      break;
    case "_encstr_9A7205B39CB919":
    case "_encstr_BDD705AD7BD143":
    case "_encstr_8E07030349":
      if(isDefined(level.zone))
        var_1 = ispointinvolume(self.origin, level.zone.trigger) || ispointinvolume(var_0.origin, level.zone.trigger);

      break;
  }

  return var_1;
}

turret_outline_watcher(var_0) {
  var_1 = 0;

  switch (getgametype()) {
    case "_encstr_ACF906B79752C5E8":
      if(istrue(var_0.isbombcarrier)) {
        var_1 = 1;
        break;
      }

      if(isDefined(level.cyberemp.carrier) && self.team == level.cyberemp.ownerteam && self != level.cyberemp.carrier) {
        var_2 = distancesquared(level.cyberemp.carrier.origin, self.origin);
        var_3 = distancesquared(level.cyberemp.carrier.origin, var_0.origin);

        if(var_2 < 90000 || var_3 < 90000) {
          var_1 = 1;
          break;
        }
      }

      foreach(var_5 in level.objectives) {
        if(istrue(var_5.trigger.trigger_off)) {
          continue;
        }
        var_6 = var_5.ownerteam;

        if(var_6 != self.team) {
          var_7 = distancesquared(var_5.trigger.origin, self.origin);
          var_8 = distancesquared(var_5.trigger.origin, var_0.origin);

          if(var_7 < 90000 || var_8 < 90000) {
            var_1 = 1;
            break;
          }
        }
      }

      break;
    case "_encstr_B60703EACA":
    case "_encstr_9B0703CD93":
    case "_encstr_B807035284":
      if(self.team == game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
        break;
      }

      foreach(var_11 in level.objectives) {
        var_12 = distancesquared(var_11.trigger.origin, var_0.origin);

        if(var_12 < 90000) {
          var_1 = 1;
          break;
        }
      }

      break;
    case "_encstr_A7290676E4D2378C":
    case "_encstr_A20D05FBEB01F2":
    case "_encstr_A54F06D32A2F0498":
    case "_encstr_8218041DF5FA":
    case "_encstr_B81904B04E6B":
      foreach(var_11 in level.objectives) {
        if(self.team == var_11.ownerteam) {
          continue;
        }
        var_7 = distancesquared(var_11.curorigin, self.origin);
        var_8 = distancesquared(var_11.curorigin, var_0.origin);

        if(var_7 < 90000 || var_8 < 90000) {
          var_1 = 1;
          break;
        }
      }

      break;
    case "_encstr_9A7205B39CB919":
    case "_encstr_BDD705AD7BD143":
    case "_encstr_8E07030349":
      if(isDefined(level.zone))
        var_1 = ispointinvolume(self.origin, level.zone.trigger) || ispointinvolume(var_0.origin, level.zone.trigger);

      break;
  }

  return var_1;
}

gametypesupportsbasejumping() {
  switch (getgametype()) {
    case "_encstr_B41904BB8593":
    case "_encstr_8CA606F38878410D":
    case "_encstr_931D068662634370":
    case "_encstr_A54F06D32A2F0498":
    case "_encstr_8218041DF5FA":
    case "_encstr_AAE507E8423F63C163":
    case "_encstr_B607038AAB":
    case "_encstr_B81904B04E6B":
      return 1;
    default:
      return 0;
  }
}

mapsupportsbasejumping() {
  if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death())
    return 1;

  switch (level.mapname) {
    case "_encstr_87640FB60EF51BC239837B8D7D1D95E61D":
    case "_encstr_A62810B638BEE44BD9AC396ED232CAF5B3EE":
    case "_encstr_876510B60EF583E4B76B2BB9851995BED9BB":
    case "_encstr_81060EEA3847D0DBBAD5EB771EEF11BF":
    case "_encstr_831E0F7F2968E2AFC819F0FED3B0D70AD4":
    case "_encstr_BA3F0A7D37E6935EE590C3CF":
    case "_encstr_ACA10F6D0F871A2DAE5887E338C10A87F3":
    case "_encstr_A3930F8FD35F7A396BA3D6614DF1A0B245":
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
    case "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319":
    case "_encstr_AC880C67503EA82A05DD62214CE7":
    case "_encstr_93D20D28714743B99070632BAF3944":
    case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
    case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
    case "_encstr_93A80FB50EBE8DF6C6B036ACFA47ACB98E":
      return 1;
    default:
      return 0;
  }
}

_id_119AC(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\matchdata::gettimefrommatchstart(gettime());

  if(!isDefined(var_2)) {
    return;
  }
  var_6 = "_encstr_B40101";

  if(isDefined(var_4))
    var_6 = var_4;
  else
    var_6 = "_encstr_8BBA05185F8B99";

  if(!isDefined(var_0)) {
    if(isDefined(var_3))
      getentitylessscriptablearray("_encstr_9B62188C3190378F453352EA9BB0AFAD308F151E47B8FD2FF86B", ["_encstr_8F1A16DC1308374955937A5281AB3E8B210B6F5335D123CB", var_5, "_encstr_8E670DEF48B8AFBFCA487D8D7F68AC", var_2, "_encstr_8F510B2B87E8E4C2F55ACD997B", var_6, "_encstr_BD0C0CA230B0C1E29617730F5331", "_encstr_8BBA05185F8B99", "_encstr_BE9C0F462D1219419B33F040B7B4196B4A", "_encstr_8BBA05185F8B99", "_encstr_AFB307A77BCDACBEF0", var_3[0], "_encstr_9AB307FAA773616F88", var_3[1], "_encstr_8CB307620FDBC9D7F0", var_3[2]]);
    else
      getentitylessscriptablearray("_encstr_9B62188C3190378F453352EA9BB0AFAD308F151E47B8FD2FF86B", ["_encstr_8F1A16DC1308374955937A5281AB3E8B210B6F5335D123CB", var_5, "_encstr_8E670DEF48B8AFBFCA487D8D7F68AC", var_2, "_encstr_8F510B2B87E8E4C2F55ACD997B", var_6]);
  } else if(isDefined(var_1)) {
    if(isDefined(var_3))
      getentitylessscriptablearray("_encstr_9B62188C3190378F453352EA9BB0AFAD308F151E47B8FD2FF86B", ["_encstr_8BB007E03658CBCAE4", var_0, "_encstr_8C5C0AB1DEDC3A596E1D5927", var_1, "_encstr_8F1A16DC1308374955937A5281AB3E8B210B6F5335D123CB", var_5, "_encstr_8E670DEF48B8AFBFCA487D8D7F68AC", var_2, "_encstr_8F510B2B87E8E4C2F55ACD997B", var_6, "_encstr_BD0C0CA230B0C1E29617730F5331", var_0.team, "_encstr_BE9C0F462D1219419B33F040B7B4196B4A", var_1.team, "_encstr_AFB307A77BCDACBEF0", var_3[0], "_encstr_9AB307FAA773616F88", var_3[1], "_encstr_8CB307620FDBC9D7F0", var_3[2]]);
    else
      getentitylessscriptablearray("_encstr_9B62188C3190378F453352EA9BB0AFAD308F151E47B8FD2FF86B", ["_encstr_8BB007E03658CBCAE4", var_0, "_encstr_8C5C0AB1DEDC3A596E1D5927", var_1, "_encstr_8F1A16DC1308374955937A5281AB3E8B210B6F5335D123CB", var_5, "_encstr_8E670DEF48B8AFBFCA487D8D7F68AC", var_2, "_encstr_8F510B2B87E8E4C2F55ACD997B", var_6, "_encstr_BD0C0CA230B0C1E29617730F5331", var_0.team, "_encstr_BE9C0F462D1219419B33F040B7B4196B4A", var_1.team]);
  } else if(isDefined(var_3))
    getentitylessscriptablearray("_encstr_9B62188C3190378F453352EA9BB0AFAD308F151E47B8FD2FF86B", ["_encstr_8BB007E03658CBCAE4", var_0, "_encstr_8F1A16DC1308374955937A5281AB3E8B210B6F5335D123CB", var_5, "_encstr_8E670DEF48B8AFBFCA487D8D7F68AC", var_2, "_encstr_8F510B2B87E8E4C2F55ACD997B", var_6, "_encstr_BD0C0CA230B0C1E29617730F5331", var_0.team, "_encstr_BE9C0F462D1219419B33F040B7B4196B4A", "_encstr_8BBA05185F8B99", "_encstr_AFB307A77BCDACBEF0", var_3[0], "_encstr_9AB307FAA773616F88", var_3[1], "_encstr_8CB307620FDBC9D7F0", var_3[2]]);
  else
    getentitylessscriptablearray("_encstr_9B62188C3190378F453352EA9BB0AFAD308F151E47B8FD2FF86B", ["_encstr_8BB007E03658CBCAE4", var_0, "_encstr_8F1A16DC1308374955937A5281AB3E8B210B6F5335D123CB", var_5, "_encstr_8E670DEF48B8AFBFCA487D8D7F68AC", var_2, "_encstr_8F510B2B87E8E4C2F55ACD997B", var_6, "_encstr_BD0C0CA230B0C1E29617730F5331", var_0.team]);
}

updatex1stashhud() {
  return istrue(level.updatex1prematchloadoutarray);
}

unset_relic_landlocked() {
  return istrue(level.unset_relic_laststandmelee) || istrue(level.unset_relic_lfo) || istrue(level.unset_relic_laststand);
}

vcloseangles() {
  var_0 = 0;

  switch (scripts\cp_mp\utility\game_utility::getmapname()) {
    case "_encstr_A62810B638BEE44BD9AC396ED232CAF5B3EE":
    case "_encstr_876510B60EF583E4B76B2BB9851995BED9BB":
    case "_encstr_81060EEA3847D0DBBAD5EB771EEF11BF":
    case "_encstr_831E0F7F2968E2AFC819F0FED3B0D70AD4":
    case "_encstr_AC880C67503EA82A05DD62214CE7":
    case "_encstr_93D20D28714743B99070632BAF3944":
    case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
    case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
      return 1;
    default:
      return 0;
  }
}

get_allowed_vehicle_types_from_spawnpoint(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = scripts\cp_mp\utility\game_utility::getmapname();

  if((getgametype() == "_encstr_B81904B04E6B" || unset_relic_landlocked()) && vcloseangles() || getdvarint("_encstr_BEFB21472F830890D1ED112E57B7705EAA1FC5EBB38AEDF1E90299A1FC75B88560A779", 0) == 1) {
    if(var_3 != "_encstr_93FB0A6B1C7D2CB92D5EB00D") {
      if(istrue(level._id_121C8))
        var_1 = 1;

      if(istrue(level._id_121C9) && !istrue(var_0.little_bird_mg_playerexitturret))
        var_2 = 1;
    }
  }

  if(var_1)
    var_0 getclientomnvar();
  else
    var_0 weaponswitchbuttonPressed();

  if(var_2)
    var_0 skydive_cutautodeployon();
  else
    var_0 skydive_cutautodeployoff();
}

tv_station_intro_camera() {
  return matchmakinggame() && getdvarint("_encstr_B1B5186E0EF36FA1A44720287BC1D9512AB9E874670BFD28944F", 0) > 0;
}

usefloorrocks() {
  return matchmakinggame() && getdvarint("_encstr_B1B5186E0EF36FA1A44720287BC1D9512AB9E874670BFD28944F", 0) == 1;
}

handle_carry_special_item() {
  if(tv_station_intro_camera()) {
    switch (getdvarint("_encstr_B1B5186E0EF36FA1A44720287BC1D9512AB9E874670BFD28944F", 0)) {
      case 1:
        return 1;
      default:
        return 0;
    }
  } else if(isDefined(level.set_systems_init_flag) && level.set_systems_init_flag > 0)
    return 1;

  return 0;
}

usequesttimer() {
  return getdvarint("_encstr_B647249F66A2E97070DFC6453FB7A2FD6DB35D53E7DCAB41416DAC436AED4F1E98A060106B3B", 0) != 0;
}

updatetextongamepadchange() {
  switch (getgametype()) {
    case "_encstr_931D068662634370":
      return 0;
    case "_encstr_B607038AAB":
      switch (round_vehicle_logic()) {
        case "_encstr_91070301C2":
        case "_encstr_A1D0081CC297B1EDB08C":
        case "_encstr_866209ECEDB1197DEE0B4E":
        case "_encstr_B18D0B5281530117EDEAC82033":
        case "_encstr_9B1F05BE4B9B52":
        case "_encstr_8AE1099A0B999F2D28AF15":
        case "_encstr_BE180419DAE9":
        case "_encstr_816E079685517D0975":
          return 0;
      }
  }

  return 1;
}

_id_131A3(var_0, var_1) {
  if(var_1)
    var_0.c130 = 1;
  else
    var_0.c130 = undefined;
}

updatehistoryhud(var_0) {
  return istrue(var_0.c130);
}