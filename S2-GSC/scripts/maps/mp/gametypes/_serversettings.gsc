/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_serversettings.gsc
*********************************************************/

init() {
  level.hostname = getDvar("sv_hostname");

  if(level.hostname == "") {
    level.hostname = "CoDHost";
  }

  setDvar("sv_hostname", level.hostname);
  level._id_0C32 = getdvarint("4372", 1);
  setDvar("g_allowVote", level._id_0C32);
  level.friendlyfire = _id_0511::gettweakablevalue("team", "fftype");
  constraingametype(getDvar("g_gametype"));

  for(;;) {
    updateserversettings();
    wait 5;
  }
}

updateserversettings() {
  var_0 = getDvar("sv_hostname");

  if(level.hostname != var_0) {
    level.hostname = var_0;
  }

  var_1 = getdvarint("4372", 1);

  if(level._id_0C32 != var_1) {
    level._id_0C32 = var_1;
  }

  var_2 = _id_0511::gettweakablevalue("team", "fftype");

  if(level.friendlyfire != var_2) {
    level.friendlyfire = var_2;
  }
}

constraingametype(var_0) {
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