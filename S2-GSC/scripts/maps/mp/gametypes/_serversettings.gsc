/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_serversettings.gsc
*********************************************************/

init() {
  level._id_4E0E = getDvar("5656");

  if(level._id_4E0E == "") {
    level._id_4E0E = "CoDHost";
  }

  setDvar("5656", level._id_4E0E);
  level._id_0C32 = getdvarint("4372", 1);
  setDvar("4372", level._id_0C32);
  level._id_3EC4 = _id_0511::_id_46F7("team", "fftype");
  _id_2596(getDvar("1924"));

  for(;;) {
    _id_A164();
    wait 5;
  }
}

_id_A164() {
  var_0 = getDvar("5656");

  if(level._id_4E0E != var_0) {
    level._id_4E0E = var_0;
  }

  var_1 = getdvarint("4372", 1);

  if(level._id_0C32 != var_1) {
    level._id_0C32 = var_1;
  }

  var_2 = _id_0511::_id_46F7("team", "fftype");

  if(level._id_3EC4 != var_2) {
    level._id_3EC4 = var_2;
  }
}

_id_2596(var_0) {
  var_1 = getEntArray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_0 == "dm") {
      if(isDefined(var_3.teleport) && var_3.teleport != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "tdm") {
      if(isDefined(var_3.ispathdirect) && var_3.ispathdirect != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "ctf") {
      if(isDefined(var_3.maymovefrompointtopoint) && var_3.maymovefrompointtopoint != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "hq") {
      if(isDefined(var_3.forceteleport) && var_3.forceteleport != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "sd") {
      if(isDefined(var_3.withinapproxpathdist) && var_3.withinapproxpathdist != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "koth") {
      if(isDefined(var_3.safeteleport) && var_3.safeteleport != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "atdm") {
      if(isDefined(var_3.maymovetopoint) && var_3.maymovetopoint != "1") {
        var_3 delete();
      }
    }
  }
}