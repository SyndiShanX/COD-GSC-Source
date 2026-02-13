/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1989.gsc
*************************************************/

init() {}

_id_10A4(var_0, var_1, var_2, var_3, var_4) {
  var_2 endon("disconnect");

  if(!level.teambased) {
    return;
  }
  if(getDvar("#x3c7bd43665e01a790") == "0") {
    return;
  }
  if(level._id_74C4) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    return;
  }
  if(istrue(var_2 scripts\mp\gametypes\br_public::_id_8990())) {
    return;
  }
  var_5 = scripts\mp\utility\game::getgametype() == "br";
  var_6 = var_0 scripts\mp\utility\perk::_hasperk("specialty_silentkill");

  if(!var_5 && var_6) {
    return;
  }
  var_7 = var_1.origin;
  var_7 = var_7 + (0, 0, 40);
  var_2 notify("addDeathIcon()");
  var_2 endon("addDeathIcon()");

  if(isDefined(var_2._id_8FB9)) {
    _id_078F::_id_D593(var_2._id_8FB9);
    var_2._id_8FB9 = undefined;
  }

  var_2 notify("removed_death_icon");
  var_8 = "v_ui_icon_hud_deathmarker_deathmarker01";
  var_9 = var_3;

  if(var_5) {
    var_8 = "hud_icon_death_player" + var_2._id_2ABC;

    if(var_6) {
      var_9 = [var_2];
    } else {
      var_9 = scripts\mp\utility\teams::_id_6DCA(var_2.team, "players");
    }
  }

  var_10 = var_2.origin;
  var_11 = var_5;
  var_12 = var_5;
  var_2._id_8FB9 = var_2 _id_078F::_id_D59B(var_9, var_8, undefined, 1, 0, 0, undefined, undefined, var_11, var_10, var_12);

  if(isDefined(var_2._id_8FB9)) {
    if(var_5) {
      var_2 thread _id_74A0(var_6);
    } else {
      var_2 thread _id_4863(var_4);
    }
  }
}

_id_74A0(var_0) {
  self endon("removed_death_icon");
  var_1 = self.team;
  var_2 = self._id_8FB9;

  if(!var_0) {
    _id_744E(var_2, var_1);
  }

  if(isDefined(self)) {
    _id_747B();
  }

  _id_078F::_id_D593(var_2);

  if(isDefined(self)) {
    self._id_8FB9 = undefined;
  }
}

_id_744E(var_0, var_1) {
  var_2 = getdvarfloat("#x3a7c05637207d2acc", 10.0);
  wait(var_2);
  var_3 = scripts\mp\utility\teams::_id_6A59(var_1);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(isDefined(self) && var_5 == self) {
      continue;
    }
    _id_078F::_id_D599(var_0, var_5);
  }
}

_id_747B() {
  if(!scripts\mp\gametypes\br_public::_id_8990()) {
    var_0 = getdvarfloat("#x3ceeee483e7f677eb", 15.0);

    if(!scripts\mp\utility\player::isreallyalive(self)) {
      self waittill("spawned_player");
    } else {
      var_1 = gettime() - self._id_904F;
      var_0 = var_0 - var_1 / 1000;
    }

    if(var_0 > 0) {
      wait(var_0);
    }
  }
}

_id_4863(var_0) {
  self endon("removed_death_icon");
  var_1 = self;
  var_2 = self._id_8FB9;
  wait(var_0);
  _id_078F::_id_D593(var_2);

  if(isDefined(var_1)) {
    var_1._id_8FB9 = undefined;
  }
}

_id_78F3(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_8FB9)) {
    return;
  }
  _id_078F::_id_D599(var_0._id_8FB9, var_0);
}

_id_C48D(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_8FB9)) {
    return;
  }
  _id_078F::_id_D593(var_0._id_8FB9);
  var_0._id_8FB9 = undefined;
  var_0 notify("removed_death_icon");
}

_id_C46D() {
  foreach(var_1 in level.players) {
    _id_C48D(var_1);
  }
}

_id_10A8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 endon("disconnect");

  if(!level.teambased) {
    return;
  }
  if(istrue(var_1 scripts\mp\gametypes\br_public::_id_8990())) {
    return;
  }
  var_6 = var_0.origin;
  var_6 = var_6 + (0, 0, 40);
  var_1 notify("addDeathIcon()");
  var_1 endon("addDeathIcon()");

  if(!var_5) {
    if(getDvar("#x3c7bd43665e01a790") == "0") {
      return;
    }
    if(level._id_74C4) {
      return;
    }
  }

  if(isDefined(var_1.lastdeathheadiconsforenemy)) {
    foreach(var_8 in var_1.lastdeathheadiconsforenemy) {
      _id_078F::_id_D593(var_8);
    }

    var_1.lastdeathheadiconsforenemy = undefined;
  }

  var_1 notify("removed_enemy_death_icon");

  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    var_10 = "hud_realism_head_death";
    var_11 = 0;
    var_12 = 768;
    var_13 = 10;
  } else {
    var_10 = "hud_icon_death_hunter_spawn";
    var_11 = 1;
    var_12 = 768;
    var_13 = 0;
  }

  var_14 = var_1.origin;

  if(var_3.size > 0) {
    var_15 = "v_esports_ui_icon_codcaster_waypoint_skull";
    var_16 = var_1 _id_078F::_id_D59B(var_3, var_15, undefined, var_11, var_12, var_13, undefined, undefined, undefined, var_14);
    _func_0364(var_16, var_1.team);
    var_1.lastdeathheadiconsforenemy = scripts\engine\utility::_id_1B8D(var_1.lastdeathheadiconsforenemy, var_16);
  }

  if(var_2.size > 0) {
    var_16 = var_1 _id_078F::_id_D59B(var_2, var_10, undefined, var_11, var_12, var_13, undefined, undefined, undefined, var_14);
    var_1.lastdeathheadiconsforenemy = scripts\engine\utility::_id_1B8D(var_1.lastdeathheadiconsforenemy, var_16);
  }

  if(isDefined(var_1.lastdeathheadiconsforenemy)) {
    var_1 thread _id_484F(var_4);
  }
}

_id_484F(var_0) {
  self endon("removed_enemy_death_icon");
  var_1 = self;
  var_2 = self.lastdeathheadiconsforenemy;
  wait(var_0);

  foreach(var_4 in var_2) {
    _id_078F::_id_D593(var_4);
  }

  if(isDefined(var_1)) {
    var_1.lastdeathheadiconsforenemy = undefined;
  }
}