/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\serversettings.gsc
***********************************************/

function init() {
  level.hostname = getserverhostname();
  setfriendlyfire(scripts\mp\tweakables::gettweakablevalue("team", "fftype"));
  constraingametype(getDvar("NKTMKRMSKR"));

  for(;;) {
    updateserversettings();
    wait 5;
  }
}

function updateserversettings() {
  var0 = scripts\mp\tweakables::gettweakablevalue("team", "fftype");

  if(level.friendlyfire != var0) {
    setfriendlyfire(var0);
    return;
  }
}

function constraingametype(var0) {
  var1 = getEntArray();

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(var0 == "dm") {
      if(isDefined(var3.script_gametype_dm) && var3.script_gametype_dm != "1") {
        var3 delete();
      }

      continue;
    }

    if(var0 == "tdm") {
      if(isDefined(var3.script_gametype_tdm) && var3.script_gametype_tdm != "1") {
        var3 delete();
      }

      continue;
    }

    if(var0 == "ctf") {
      if(isDefined(var3.script_gametype_ctf) && var3.script_gametype_ctf != "1") {
        var3 delete();
      }

      continue;
    }

    if(var0 == "hq") {
      if(isDefined(var3.script_gametype_hq) && var3.script_gametype_hq != "1") {
        var3 delete();
      }

      continue;
    }

    if(var0 == "sd") {
      if(isDefined(var3.script_gametype_sd) && var3.script_gametype_sd != "1") {
        var3 delete();
      }

      continue;
    }

    if(var0 == "koth") {
      if(isDefined(var3.script_gametype_koth) && var3.script_gametype_koth != "1") {
        var3 delete();
      }
    }
  }
}

function setfriendlyfire(var0) {
  level.friendlyfire = var0;
  setDvar("ui_friendlyfire", var0);
  setDvar("LMQOKPRSML", var0);
}