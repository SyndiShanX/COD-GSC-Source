/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\serversettings.gsc
***********************************************/

init() {
  level.hostname = getserverhostname();
  setfriendlyfire(scripts\mp\tweakables::gettweakablevalue("team", "fftype"));
  constraingametype(getDvar("g_gametype"));

  for(;;) {
    updateserversettings();
    wait 5;
  }
}

updateserversettings() {
  _id_F285149ED7055B33 = scripts\mp\tweakables::gettweakablevalue("team", "fftype");

  if(level.friendlyfire != _id_F285149ED7055B33)
    setfriendlyfire(_id_F285149ED7055B33);
}

constraingametype(gametype) {
  entities = getEntArray();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < entities.size; _id_AC0E594AC96AA3A8++) {
    entity = entities[_id_AC0E594AC96AA3A8];

    if(gametype == "dm") {
      if(isDefined(entity.script_gametype_dm) && entity.script_gametype_dm != "1")
        entity delete();

      continue;
    }

    if(gametype == "tdm") {
      if(isDefined(entity.script_gametype_tdm) && entity.script_gametype_tdm != "1")
        entity delete();

      continue;
    }

    if(gametype == "ctf") {
      if(isDefined(entity.script_gametype_ctf) && entity.script_gametype_ctf != "1")
        entity delete();

      continue;
    }

    if(gametype == "hq") {
      if(isDefined(entity.script_gametype_hq) && entity.script_gametype_hq != "1")
        entity delete();

      continue;
    }

    if(gametype == "sd") {
      if(isDefined(entity.script_gametype_sd) && entity.script_gametype_sd != "1")
        entity delete();

      continue;
    }

    if(gametype == "koth") {
      if(isDefined(entity.script_gametype_koth) && entity.script_gametype_koth != "1")
        entity delete();
    }
  }
}

setfriendlyfire(enabled) {
  level.friendlyfire = enabled;
  setDvar("ui_friendlyfire", enabled);
  setDvar("cg_drawFriendlyHUDGrenades", enabled);
}