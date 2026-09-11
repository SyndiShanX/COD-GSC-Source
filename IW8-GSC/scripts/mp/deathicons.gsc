/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\deathicons.gsc
***********************************************/

function init() {}

function adddeathicon(var0, var1, var2, var3, var4) {
  var2 endon("disconnect");

  if(istrue(var2.ref_133cb)) {
    return;
  }

  if(!level.teambased) {
    return;
  }

  if(getDvar("ui_hud_showdeathicons") == "0") {
    return;
  }

  if(level.hardcoremode) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    return;
  }

  if(istrue(var2 scripts\mp\gametypes\br_public::isplayeringulag())) {
    return;
  }

  var5 = scripts\mp\utility\game::getgametype() == "br";
  var6 = scripts\mp\utility\game::getgametype() == "brtdm";
  var7 = var0 scripts\mp\utility\perk::_hasperk("specialty_silentkill");

  if(!var5 && var7) {
    return;
  }

  var8 = var1.origin;
  var8 += (0, 0, 40);
  var2 notify("addDeathIcon()");
  var2 endon("addDeathIcon()");

  if(isDefined(var2.waittill_usebutton_released_or_time_or_bomb_planted)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var2.waittill_usebutton_released_or_time_or_bomb_planted);
    var2.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
  }

  var2 notify("removed_death_icon");
  var9 = "hud_icon_death_spawn";
  var10 = var3;

  if(var5) {
    var11 = scripts\engine\utility::ter_op(isDefined(var2.pers["squadMemberIndex"]), var2.pers["squadMemberIndex"], 0);
    var9 = "hud_icon_death_player" + var11;

    if(var7) {
      var10 = [var2];
    } else if(scripts\mp\menus::brking_updateteamscore()) {
      var10 = level.squaddata[var3][var2.squadindex].players;
    } else {
      var10 = scripts\mp\utility\teams::getteamdata(var2.team, "players");
    }
  } else if(var6) {
    if(var7) {
      var10 = [var2];
    } else {
      var10 = scripts\mp\utility\teams::getteamdata(var2.team, "players");
    }
  }

  var12 = var2.origin;
  var13 = var5;
  var14 = var5;
  var2.waittill_usebutton_released_or_time_or_bomb_planted = var2 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var10, var9, undefined, 1, 0, 0, undefined, undefined, var13, var12, var14);

  if(isDefined(var2.waittill_usebutton_released_or_time_or_bomb_planted)) {
    if(var5 || var6) {
      thread setupminimapmaze(var2);
      return;
    }

    thread destroyslowly(var2);
    return;
  }
}

function setupminimapmaze(var0) {
  self endon("removed_death_icon");
  var1 = self.team;
  var2 = self.waittill_usebutton_released_or_time_or_bomb_planted;

  if(!var0) {
    setup_train_entarray_composite(var2, var1);
  }

  if(isDefined(self)) {
    setupdamage();
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var2);

  if(isDefined(self)) {
    self.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
    return;
  }
}

function setup_train_entarray_composite(var0, var1) {
  var2 = getdvarfloat("death_icon_teammate_duration", 10);
  var3 = getdvarfloat("death_icon_squadmate_duration_bonus", 0);
  wait var2;
  var4 = scripts\mp\utility\teams::getfriendlyplayers(var1);

  foreach(var6 in var4) {
    if(!isDefined(var6)) {
      continue;
    }

    if(var3 > 0) {
      if(isDefined(self.squadindex) && isDefined(var6.squadindex) && self.squadindex == var6.squadindex) {
        continue;
      }
    }

    if(isDefined(self) && var6 == self) {
      continue;
    }

    scripts\cp_mp\entityheadicons::ref_1315e(var0, var6);
  }

  if(var3 > 0) {
    wait var3;
    var4 = scripts\mp\utility\teams::getfriendlyplayers(var1);

    foreach(var6 in var4) {
      if(!isDefined(var6)) {
        continue;
      }

      if(isDefined(self.squadindex) && isDefined(var6.squadindex) && self.squadindex != var6.squadindex) {
        continue;
      }

      if(isDefined(self) && var6 == self) {
        continue;
      }

      scripts\cp_mp\entityheadicons::ref_1315e(var0, var6);
    }

    return;
  }
}

function setupdamage() {
  if(!scripts\mp\gametypes\br_public::isplayeringulag()) {
    var0 = getdvarfloat("death_icon_owner_duration", 15);

    if(!scripts\mp\utility\player::isreallyalive(self)) {
      self waittill("spawned_player");
    } else {
      var1 = gettime() - self.lastspawntime;
      var0 -= var1 / 1000;
    }

    if(var0 > 0) {
      wait var0;
      return;
    }

    return;
  }
}

function destroyslowly(var0) {
  self endon("removed_death_icon");
  var1 = self;
  var2 = self.waittill_usebutton_released_or_time_or_bomb_planted;
  wait var0;
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var2);

  if(isDefined(var1)) {
    var1.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
    return;
  }
}

function spawn_carriables_from_prefabs_all(var0) {
  if(!isDefined(var0) || !isDefined(var0.waittill_usebutton_released_or_time_or_bomb_planted)) {
    return;
  }

  scripts\cp_mp\entityheadicons::ref_1315e(var0.waittill_usebutton_released_or_time_or_bomb_planted, var0);
}

function ref_12c01(var0) {
  if(!isDefined(var0) || !isDefined(var0.waittill_usebutton_released_or_time_or_bomb_planted)) {
    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var0.waittill_usebutton_released_or_time_or_bomb_planted);
  var0.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
  var0 notify("removed_death_icon");
}

function ref_12bfd() {
  foreach(var1 in level.players) {
    ref_12c01(var1);
  }
}

function addenemydeathicon(var0, var1, var2, var3, var4) {
  var1 endon("disconnect");

  if(!level.teambased) {
    return;
  }

  if(istrue(var1 scripts\mp\gametypes\br_public::isplayeringulag())) {
    return;
  }

  var5 = var0.origin;
  var5 += (0, 0, 40);
  var1 notify("addDeathIcon()");
  var1 endon("addDeathIcon()");

  if(!var4) {
    if(getDvar("ui_hud_showdeathicons") == "0") {
      return;
    }

    if(level.hardcoremode) {
      return;
    }
  }

  if(isDefined(var1.waittill_vo_plays)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var1.waittill_vo_plays);
    var1.waittill_vo_plays = undefined;
  }

  var1 notify("removed_enemy_death_icon");

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var6 = "hud_realism_head_death";
    var7 = 0;
    var8 = 768;
    var9 = 10;
  } else {
    var6 = "hud_icon_death_hunter_spawn";
    var7 = 1;
    var8 = 768;
    var9 = 0;
  }

  var10 = var5.origin;
  var5.waittill_vo_plays = var5 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var6, var6, undefined, var7, var8, var9, undefined, undefined, undefined, var10);

  if(isDefined(var5.waittill_vo_plays)) {
    thread destroyenemyiconslowly(var5);
    return;
  }
}

function destroyenemyiconslowly(var0) {
  self endon("removed_enemy_death_icon");
  var1 = self;
  var2 = self.waittill_vo_plays;
  wait var0;
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var2);

  if(isDefined(var1)) {
    var1.waittill_vo_plays = undefined;
    return;
  }
}