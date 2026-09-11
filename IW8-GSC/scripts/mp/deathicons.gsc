/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\deathicons.gsc
***********************************************/

function init() {}

function adddeathicon(var_0, var_1, var_2, var_3, var_4) {
  var_2 endon("disconnect");

  if(istrue(var_2.ref_133cb)) {
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

  if(istrue(var_2 scripts\mp\gametypes\br_public::isplayeringulag())) {
    return;
  }

  var_5 = scripts\mp\utility\game::getgametype() == "br";
  var_6 = scripts\mp\utility\game::getgametype() == "brtdm";
  var_7 = var_0 scripts\mp\utility\perk::_hasperk("specialty_silentkill");

  if(!var_5 && var_7) {
    return;
  }

  var_8 = var_1.origin;
  var_8 += (0, 0, 40);
  var_2 notify("addDeathIcon()");
  var_2 endon("addDeathIcon()");

  if(isDefined(var_2.waittill_usebutton_released_or_time_or_bomb_planted)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_2.waittill_usebutton_released_or_time_or_bomb_planted);
    var_2.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
  }

  var_2 notify("removed_death_icon");
  var_9 = "hud_icon_death_spawn";
  var_10 = var_3;

  if(var_5) {
    var_11 = scripts\engine\utility::ter_op(isDefined(var_2.pers["squadMemberIndex"]), var_2.pers["squadMemberIndex"], 0);
    var_9 = "hud_icon_death_player" + var_11;

    if(var_7) {
      var_10 = [var_2];
    } else if(scripts\mp\menus::brking_updateteamscore()) {
      var_10 = level.squaddata[var_3][var_2.squadindex].players;
    } else {
      var_10 = scripts\mp\utility\teams::getteamdata(var_2.team, "players");
    }
  } else if(var_6) {
    if(var_7) {
      var_10 = [var_2];
    } else {
      var_10 = scripts\mp\utility\teams::getteamdata(var_2.team, "players");
    }
  }

  var_12 = var_2.origin;
  var_13 = var_5;
  var_14 = var_5;
  var_2.waittill_usebutton_released_or_time_or_bomb_planted = var_2 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_10, var_9, undefined, 1, 0, 0, undefined, undefined, var_13, var_12, var_14);

  if(isDefined(var_2.waittill_usebutton_released_or_time_or_bomb_planted)) {
    if(var_5 || var_6) {
      thread setupminimapmaze(var_2);
      return;
    }

    thread destroyslowly(var_2);
    return;
  }
}

function setupminimapmaze(var_0) {
  self endon("removed_death_icon");
  var_1 = self.team;
  var_2 = self.waittill_usebutton_released_or_time_or_bomb_planted;

  if(!var_0) {
    setup_train_entarray_composite(var_2, var_1);
  }

  if(isDefined(self)) {
    setupdamage();
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_2);

  if(isDefined(self)) {
    self.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
    return;
  }
}

function setup_train_entarray_composite(var_0, var_1) {
  var_2 = getdvarfloat("death_icon_teammate_duration", 10);
  var_3 = getdvarfloat("death_icon_squadmate_duration_bonus", 0);
  wait var_2;
  var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_1);

  foreach(var_6 in var_4) {
    if(!isDefined(var_6)) {
      continue;
    }

    if(var_3 > 0) {
      if(isDefined(self.squadindex) && isDefined(var_6.squadindex) && self.squadindex == var_6.squadindex) {
        continue;
      }
    }

    if(isDefined(self) && var_6 == self) {
      continue;
    }

    scripts\cp_mp\entityheadicons::ref_1315e(var_0, var_6);
  }

  if(var_3 > 0) {
    wait var_3;
    var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_1);

    foreach(var_6 in var_4) {
      if(!isDefined(var_6)) {
        continue;
      }

      if(isDefined(self.squadindex) && isDefined(var_6.squadindex) && self.squadindex != var_6.squadindex) {
        continue;
      }

      if(isDefined(self) && var_6 == self) {
        continue;
      }

      scripts\cp_mp\entityheadicons::ref_1315e(var_0, var_6);
    }

    return;
  }
}

function setupdamage() {
  if(!scripts\mp\gametypes\br_public::isplayeringulag()) {
    var_0 = getdvarfloat("death_icon_owner_duration", 15);

    if(!scripts\mp\utility\player::isreallyalive(self)) {
      self waittill("spawned_player");
    } else {
      var_1 = gettime() - self.lastspawntime;
      var_0 -= var_1 / 1000;
    }

    if(var_0 > 0) {
      wait var_0;
      return;
    }

    return;
  }
}

function destroyslowly(var_0) {
  self endon("removed_death_icon");
  var_1 = self;
  var_2 = self.waittill_usebutton_released_or_time_or_bomb_planted;
  wait var_0;
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_2);

  if(isDefined(var_1)) {
    var_1.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
    return;
  }
}

function spawn_carriables_from_prefabs_all(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.waittill_usebutton_released_or_time_or_bomb_planted)) {
    return;
  }

  scripts\cp_mp\entityheadicons::ref_1315e(var_0.waittill_usebutton_released_or_time_or_bomb_planted, var_0);
}

function ref_12c01(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.waittill_usebutton_released_or_time_or_bomb_planted)) {
    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_0.waittill_usebutton_released_or_time_or_bomb_planted);
  var_0.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
  var_0 notify("removed_death_icon");
}

function ref_12bfd() {
  foreach(var_1 in level.players) {
    ref_12c01(var_1);
  }
}

function addenemydeathicon(var_0, var_1, var_2, var_3, var_4) {
  var_1 endon("disconnect");

  if(!level.teambased) {
    return;
  }

  if(istrue(var_1 scripts\mp\gametypes\br_public::isplayeringulag())) {
    return;
  }

  var_5 = var_0.origin;
  var_5 += (0, 0, 40);
  var_1 notify("addDeathIcon()");
  var_1 endon("addDeathIcon()");

  if(!var_4) {
    if(getDvar("ui_hud_showdeathicons") == "0") {
      return;
    }

    if(level.hardcoremode) {
      return;
    }
  }

  if(isDefined(var_1.waittill_vo_plays)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_1.waittill_vo_plays);
    var_1.waittill_vo_plays = undefined;
  }

  var_1 notify("removed_enemy_death_icon");

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_6 = "hud_realism_head_death";
    var_7 = 0;
    var_8 = 768;
    var_9 = 10;
  } else {
    var_6 = "hud_icon_death_hunter_spawn";
    var_7 = 1;
    var_8 = 768;
    var_9 = 0;
  }

  var_10 = var_5.origin;
  var_5.waittill_vo_plays = var_5 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_6, var_6, undefined, var_7, var_8, var_9, undefined, undefined, undefined, var_10);

  if(isDefined(var_5.waittill_vo_plays)) {
    thread destroyenemyiconslowly(var_5);
    return;
  }
}

function destroyenemyiconslowly(var_0) {
  self endon("removed_enemy_death_icon");
  var_1 = self;
  var_2 = self.waittill_vo_plays;
  wait var_0;
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_2);

  if(isDefined(var_1)) {
    var_1.waittill_vo_plays = undefined;
    return;
  }
}