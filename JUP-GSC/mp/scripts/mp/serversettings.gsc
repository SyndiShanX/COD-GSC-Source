/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\serversettings.gsc
***********************************************/

#using scripts\cp_mp\utility\game_utility;
#using scripts\mp\tweakables;
#namespace serversettings;

function init() {
  level.hostname = getserverhostname();
  setfriendlyfire(scripts\mp\tweakables::gettweakablevalue("team", "fftype"));
  constraingametype(scripts\cp_mp\utility\game_utility::getgametype());

  for(;;) {
    updateserversettings();
    wait 5;
  }
}

function updateserversettings() {
  scr_friendlyfire = scripts\mp\tweakables::gettweakablevalue("team", "fftype");

  if(level.friendlyfire != scr_friendlyfire) {
    setfriendlyfire(scr_friendlyfire);
  }
}

function constraingametype(gametype) {
  entities = getEntArray();

  for(i = 0; i < entities.size; i++) {
    entity = entities[i];

    if(gametype == "dm") {
      if(isDefined(entity.script_gametype_dm) && entity.script_gametype_dm != "1") {
        entity delete();
      }

      continue;
    }

    if(gametype == "tdm") {
      if(isDefined(entity.script_gametype_tdm) && entity.script_gametype_tdm != "1") {
        entity delete();
      }

      continue;
    }

    if(gametype == "ctf") {
      if(isDefined(entity.script_gametype_ctf) && entity.script_gametype_ctf != "1") {
        entity delete();
      }

      continue;
    }

    if(gametype == "hq") {
      if(isDefined(entity.script_gametype_hq) && entity.script_gametype_hq != "1") {
        entity delete();
      }

      continue;
    }

    if(gametype == "sd") {
      if(isDefined(entity.script_gametype_sd) && entity.script_gametype_sd != "1") {
        entity delete();
      }

      continue;
    }

    if(gametype == "koth" || gametype == "koth_horde" || gametype == "koth_jugg") {
      if(isDefined(entity.script_gametype_koth) && entity.script_gametype_koth != "1") {
        entity delete();
      }
    }
  }
}

function setfriendlyfire(enabled) {
  level.friendlyfire = enabled;
  setDvar(@ "ui_friendlyfire", enabled);
  setDvar(@ "hash_11420719fff4b2a2", enabled);
}