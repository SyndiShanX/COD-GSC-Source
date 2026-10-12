/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\deathicons.gsc
***********************************************/

#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#namespace deathicons;

function init() {
  level.deathicons = spawnStruct();
  level.deathicons.var_e973113c908f1b3e = getdvarint(@ "hash_97e20befa2938a48", 10);
  level.deathicons.var_3c1ea16fb886db94 = getdvarint(@ "hash_f00ea016dc7b1272", 4000);
  level.deathicons.var_be5e71251b2fdb9d = getdvarfloat(@ "death_icon_teammate_duration", 10);
  level.deathicons.var_ec15e7c2b73e1708 = getdvarfloat(@ "hash_d4e44eecf9bc8099", 0);
}

function adddeathicon(attacker, entity, dyingplayer, team, timeout) {
  dyingplayer endon("disconnect");

  if(istrue(dyingplayer.skipdeathicon)) {
    return;
  }

  if(!level.teambased) {
    return;
  }

  if(getDvar(@ "ui_hud_showdeathicons") == "0") {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    return;
  }

  if(istrue(dyingplayer scripts\mp\gametypes\br_public::isplayeringulag())) {
    return;
  }

  if(scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }

  if(attacker _hasperk("specialty_operative")) {
    return;
  }

  isbr = scripts\cp_mp\utility\game_utility::isbrstylegametype();
  var_8f0d5dceeb1ec104 = scripts\mp\utility\game::getgametype() == "brtdm" || scripts\mp\utility\game::getgametype() == "brtdm_mgl";
  var_d9622d6cf6275394 = attacker _hasperk("specialty_silentkill");

  if(!isbr && var_d9622d6cf6275394) {
    return;
  }

  iconorg = entity.origin;
  iconorg += (0, 0, 40);
  dyingplayer notify("addDeathIcon()");
  dyingplayer endon("addDeathIcon()");
  assert(isgameplayteam(team));

  if(isDefined(dyingplayer.lastdeathheadicon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(dyingplayer.lastdeathheadicon);
    dyingplayer.lastdeathheadicon = undefined;
  }

  dyingplayer notify("removed_death_icon");
  image = "hud_icon_death_spawn";
  showto = team;

  if(isbr) {
    sessionnumber = dyingplayer.sessionuimemberindex;

    if(!isDefined(sessionnumber) || sessionnumber < 0) {
      iprintln("<dev string:x1c>" + dyingplayer.name + "<dev string:x47>");

      return;
    }

    image = "hud_icon_player_dead_" + dyingplayer.sessionuimemberindex + 1;

    if(var_d9622d6cf6275394) {
      showto = [dyingplayer];
    } else {
      showto = getteamdata(dyingplayer.team, "players");
    }
  } else if(var_8f0d5dceeb1ec104) {
    if(var_d9622d6cf6275394) {
      showto = [dyingplayer];
    } else {
      showto = getteamdata(dyingplayer.team, "players");
    }
  }

  overrideorigin = dyingplayer.origin;
  var_b3ea37733a1577e5 = isbr;
  showonminimap = isbr;
  dyingplayer.lastdeathheadicon = dyingplayer scripts\cp_mp\entityheadicons::setheadicon_singleimage(showto, image, undefined, 1, 0, 0, undefined, undefined, var_b3ea37733a1577e5, overrideorigin, showonminimap);

  if(isbr) {
    setheadiconteam(dyingplayer.lastdeathheadicon, dyingplayer.team);
    function_ea1ddef8aede7460(dyingplayer.lastdeathheadicon, dyingplayer.sessionuimemberindex + 1);
  }

  if(isDefined(dyingplayer.lastdeathheadicon)) {
    if(isbr || var_8f0d5dceeb1ec104) {
      dyingplayer thread function_55bb1f7a41bf2fbd(var_d9622d6cf6275394);
      return;
    }

    dyingplayer thread destroyslowly(timeout);
  }
}

function function_55bb1f7a41bf2fbd(var_d9622d6cf6275394) {
  self endon("removed_death_icon");
  team = self.team;
  icon = self.lastdeathheadicon;
  deathiconlocation = self.origin;
  jobs = [ &function_b3ff47edf02118d1];

  if(!var_d9622d6cf6275394) {
    jobs[jobs.size] = &function_e9a6ee3cebf7919c;
  }

  function_1f9d89277519b570(jobs, [icon, deathiconlocation, team]);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);

  if(isDefined(self)) {
    self.lastdeathheadicon = undefined;
  }
}

function function_e9a6ee3cebf7919c(icon, deathiconlocation, team) {
  wait level.deathicons.var_be5e71251b2fdb9d;
  teammates = getfriendlyplayers(team);

  foreach(player in teammates) {
    if(!isDefined(player)) {
      continue;
    }

    if(level.deathicons.var_ec15e7c2b73e1708 > 0) {
      if(isDefined(self.sessionsquadid) && isDefined(player.sessionsquadid) && self.sessionsquadid == player.sessionsquadid) {
        continue;
      }
    }

    if(isDefined(self) && player == self) {
      continue;
    }

    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(icon, player);
  }

  if(level.deathicons.var_ec15e7c2b73e1708 > 0) {
    wait level.deathicons.var_ec15e7c2b73e1708;
    teammates = getfriendlyplayers(team);

    foreach(player in teammates) {
      if(!isDefined(player)) {
        continue;
      }

      if(isDefined(self.sessionsquadid) && isDefined(player.sessionsquadid) && self.sessionsquadid != player.sessionsquadid) {
        continue;
      }

      if(isDefined(self) && player == self) {
        continue;
      }

      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(icon, player);
    }
  }
}

function function_b3ff47edf02118d1(icon, deathiconlocation, team) {
  player = self;
  player endon("disconnect");
  level endon("game_ended");
  var_fbf7a3d9a735ec16 = player br_public::isplayerinorgoingtogulag() || player br_public::isplayerwaitingresurgencerespawn() || br_public::isrespawningfromtoken(player);
  var_c4e3fe6f0f6c591d = istrue(player.issolo) && isDefined(player.respawndelay) && player.respawndelay <= 0;

  if(!scripts\mp\utility\player::isreallyalive(player) && !br_public::isrespawningfromtoken(player) && !var_fbf7a3d9a735ec16 && !istrue(level.useautorespawn) && !var_c4e3fe6f0f6c591d && scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  if(istrue(level.useautorespawn)) {
    player waittill("stop_updatePrestreamRespawn");
  } else {
    while(var_fbf7a3d9a735ec16) {
      wait 2;
      var_fbf7a3d9a735ec16 = player br_public::isplayerinorgoingtogulag() || player br_public::isplayerwaitingresurgencerespawn() || br_public::isrespawningfromtoken(player);
    }
  }

  scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(player.lastdeathheadicon, player);

  for(var_ed636cd9ad93833d = 0; !var_ed636cd9ad93833d; var_ed636cd9ad93833d = 1) {
    wait 1;

    if(isalive(player) && (player isonladder() || player ishanging() || player isonground() || player isswimming() || player isswimunderwater())) {}
  }

  if(isDefined(player.lastdeathpos)) {
    if(distance2d(deathiconlocation, player.origin) < level.deathicons.var_3c1ea16fb886db94) {
      wait max(level.deathicons.var_e973113c908f1b3e, 0);
    }
  }

  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(player.lastdeathheadicon, player);
}

function destroyslowly(timeout) {
  self endon("removed_death_icon");
  owner = self;
  icon = self.lastdeathheadicon;
  wait timeout;
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);

  if(isDefined(owner)) {
    owner.lastdeathheadicon = undefined;
  }
}

function hidedeathicon(player) {
  if(!isDefined(player) || !isDefined(player.lastdeathheadicon)) {
    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(player.lastdeathheadicon, player);
}

function removedeathicon(player) {
  if(!isDefined(player) || !isDefined(player.lastdeathheadicon)) {
    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(player.lastdeathheadicon);
  player.lastdeathheadicon = undefined;
  player notify("removed_death_icon");
}

function removealldeathicons() {
  foreach(player in level.players) {
    removedeathicon(player);
  }
}

function addenemydeathicon(entity, dyingplayer, var_dd573edaa0c55862, var_5582b247a8570f9b, timeout, var_29693175f0940203) {
  dyingplayer endon("disconnect");

  if(!level.teambased) {
    return;
  }

  if(istrue(dyingplayer scripts\mp\gametypes\br_public::isplayeringulag())) {
    return;
  }

  iconorg = entity.origin;
  iconorg += (0, 0, 40);
  dyingplayer notify("addDeathIcon()");
  dyingplayer endon("addDeathIcon()");
  assert(isarray(var_dd573edaa0c55862));

  if(!var_29693175f0940203) {
    if(getDvar(@ "ui_hud_showdeathicons") == "0") {
      return;
    }

    if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
      return;
    }
  }

  if(isDefined(dyingplayer.var_795ad0631cf24432)) {
    foreach(icon in dyingplayer.var_795ad0631cf24432) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
    }

    dyingplayer.var_795ad0631cf24432 = undefined;
  }

  dyingplayer notify("removed_enemy_death_icon");

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    image = "hud_realism_head_death";
    drawthroughgeo = 0;
    maxdrawdist = 768;
    naturaldist = 10;

    if(istrue(level.var_32fe21b3c5052471)) {
      image = "hud_icon_death_spawn";
    }
  } else {
    image = "hud_icon_death_hunter_spawn";
    drawthroughgeo = 1;
    maxdrawdist = 768;
    naturaldist = 0;

    if(istrue(level.var_32fe21b3c5052471)) {
      image = "hud_icon_death_spawn";
    }
  }

  overrideorigin = dyingplayer.origin;

  if(var_5582b247a8570f9b.size > 0) {
    var_5e156d8393667bcf = "esports_codcaster_waypoint_skull";
    head_icon = dyingplayer scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_5582b247a8570f9b, var_5e156d8393667bcf, undefined, drawthroughgeo, maxdrawdist, naturaldist, undefined, undefined, undefined, overrideorigin);
    setheadiconteam(head_icon, dyingplayer.team);
    dyingplayer.var_795ad0631cf24432 = scripts\engine\utility::array_add_safe(dyingplayer.var_795ad0631cf24432, head_icon);
  }

  if(var_dd573edaa0c55862.size > 0) {
    head_icon = dyingplayer scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_dd573edaa0c55862, image, undefined, drawthroughgeo, maxdrawdist, naturaldist, undefined, undefined, undefined, overrideorigin);
    dyingplayer.var_795ad0631cf24432 = scripts\engine\utility::array_add_safe(dyingplayer.var_795ad0631cf24432, head_icon);
  }

  if(isDefined(dyingplayer.var_795ad0631cf24432)) {
    dyingplayer thread destroyenemyiconslowly(timeout);
  }
}

function destroyenemyiconslowly(timeout) {
  self endon("removed_enemy_death_icon");
  owner = self;
  icons = self.var_795ad0631cf24432;
  wait timeout;

  foreach(icon in icons) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
  }

  if(isDefined(owner)) {
    owner.var_795ad0631cf24432 = undefined;
  }
}