/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\serversettings.gsc
***********************************************/

init() {
  level.hostname = getserverhostname();
  setfriendlyfire(scripts\mp\tweakables::gettweakablevalue("_encstr_8AEF05472BC2D6", "_encstr_B6270766991D5E0759"));
  constraingametype(getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB"));

  for(;;) {
    updateserversettings();
    wait 5;
  }
}

updateserversettings() {
  var_0 = scripts\mp\tweakables::gettweakablevalue("_encstr_8AEF05472BC2D6", "_encstr_B6270766991D5E0759");

  if(level.friendlyfire != var_0)
    setfriendlyfire(var_0);
}

constraingametype(var_0) {
  var_1 = getEntArray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(var_0 == "_encstr_9707038CB6") {
      if(isDefined(var_3.script_gametype_dm) && var_3.script_gametype_dm != "_encstr_A34C02BB")
        var_3 delete();

      continue;
    }

    if(var_0 == "_encstr_A11904E823B6") {
      if(isDefined(var_3.script_gametype_tdm) && var_3.script_gametype_tdm != "_encstr_A34C02BB")
        var_3 delete();

      continue;
    }

    if(var_0 == "_encstr_8E1904B3F501") {
      if(isDefined(var_3.script_gametype_ctf) && var_3.script_gametype_ctf != "_encstr_A34C02BB")
        var_3 delete();

      continue;
    }

    if(var_0 == "_encstr_8E07030349") {
      if(isDefined(var_3.script_gametype_hq) && var_3.script_gametype_hq != "_encstr_A34C02BB")
        var_3 delete();

      continue;
    }

    if(var_0 == "_encstr_B807035284") {
      if(isDefined(var_3.script_gametype_sd) && var_3.script_gametype_sd != "_encstr_A34C02BB")
        var_3 delete();

      continue;
    }

    if(var_0 == "_encstr_BDD705AD7BD143") {
      if(isDefined(var_3.script_gametype_koth) && var_3.script_gametype_koth != "_encstr_A34C02BB")
        var_3 delete();
    }
  }
}

setfriendlyfire(var_0) {
  level.friendlyfire = var_0;
  setDvar("_encstr_840310574BFA66E4D2B2DC91C62FCC4B9CCA", var_0);
  setDvar("_encstr_A7970BF98DC947BC808359D183", var_0);
}