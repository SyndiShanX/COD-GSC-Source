/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2793.gsc
***************************************/

init() {
  level.var_90AE = getserverhostname();
  setfriendlyfire(scripts\mp\tweakables::gettweakablevalue("team", "fftype"));
  constraingametype(getdvar("g_gametype"));

  for(;;) {
    updateserversettings();
    wait 5;
  }
}

updateserversettings() {
  var_0 = scripts\mp\tweakables::gettweakablevalue("team", "fftype");

  if(level.friendlyfire != var_0) {
    setfriendlyfire(var_0);
  }
}

constraingametype(var_0) {
  var_1 = getEntArray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_0 == "dm") {
      if(isDefined(var_3.script_gametype_dm) && var_3.script_gametype_dm != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "tdm") {
      if(isDefined(var_3.script_gametype_tdm) && var_3.script_gametype_tdm != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "ctf") {
      if(isDefined(var_3.script_gametype_ctf) && var_3.script_gametype_ctf != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "hq") {
      if(isDefined(var_3.script_gametype_hq) && var_3.script_gametype_hq != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "sd") {
      if(isDefined(var_3.script_gametype_sd) && var_3.script_gametype_sd != "1") {
        var_3 delete();
      }

      continue;
    }

    if(var_0 == "koth") {
      if(isDefined(var_3.script_gametype_koth) && var_3.script_gametype_koth != "1") {
        var_3 delete();
      }
    }
  }
}

setfriendlyfire(var_0) {
  level.friendlyfire = var_0;
  setdvar("ui_friendlyfire", var_0);
  setdvar("cg_drawFriendlyHUDGrenades", var_0);
}