/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2793.gsc
***************************************/

init() {
  level.func_90AE = getserverhostname();
  setfriendlyfire(scripts\mp\tweakables::gettweakablevalue("team", "fftype"));
  constraingametype(getdvar("g_gametype"));

  for(;;) {
    updateserversettings();
    wait 5;
  }
}

updateserversettings() {
  var_00 = scripts\mp\tweakables::gettweakablevalue("team", "fftype");

  if(level.friendlyfire != var_00) {
    setfriendlyfire(var_00);
  }
}

constraingametype(var_00) {
  var_01 = getEntArray();

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    var_03 = var_1[var_02];

    if(var_00 == "dm") {
      if(isDefined(var_3.script_gametype_dm) && var_3.script_gametype_dm != "1") {
        var_03 delete();
      }

      continue;
    }

    if(var_00 == "tdm") {
      if(isDefined(var_3.script_gametype_tdm) && var_3.script_gametype_tdm != "1") {
        var_03 delete();
      }

      continue;
    }

    if(var_00 == "ctf") {
      if(isDefined(var_3.script_gametype_ctf) && var_3.script_gametype_ctf != "1") {
        var_03 delete();
      }

      continue;
    }

    if(var_00 == "hq") {
      if(isDefined(var_3.script_gametype_hq) && var_3.script_gametype_hq != "1") {
        var_03 delete();
      }

      continue;
    }

    if(var_00 == "sd") {
      if(isDefined(var_3.script_gametype_sd) && var_3.script_gametype_sd != "1") {
        var_03 delete();
      }

      continue;
    }

    if(var_00 == "koth") {
      if(isDefined(var_3.script_gametype_koth) && var_3.script_gametype_koth != "1") {
        var_03 delete();
      }
    }
  }
}

setfriendlyfire(var_00) {
  level.friendlyfire = var_00;
  setdvar("ui_friendlyfire", var_00);
  setdvar("cg_drawFriendlyHUDGrenades", var_00);
}