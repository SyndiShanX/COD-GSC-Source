/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2650.gsc
*************************************************/

_id_3C67(var_0, var_1, var_2, var_3, var_4, var_5) {
  self._id_BDE6 = undefined;

  if(var_3 < 3.0) {
    return 0;
  }

  var_6 = _id_09B9::_id_EA05(var_1);

  if(!var_6) {
    return 0;
  }

  thread _id_10BDE(var_2);
  thread _id_10B64();

  if(!isDefined(var_4) || !var_4) {
    thread _id_10BDC(var_2);
  }

  if(isalive(var_0) && !istrue(var_0._id_50A0)) {
    _id_E691(var_0, var_1.streakname, var_2, var_5);
  } else {
    self notify(var_2);
    return 0;
  }

  return 1;
}

_id_10BDA(var_0, var_1) {
  self endon("disconnect");
  self endon(var_0);

  for(;;) {
    self waittill("player_killstreak_death", var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_3 != self && isPlayer(var_3)) {
      var_3 _id_0A9F::_id_7003("destroyed_" + var_1);
      thread scripts\mp\hud_util::_id_EF8D("callout_destroyed_" + var_1, var_3);
      var_8 = makeweaponfromstring(var_7);
      thread _id_07BC::_id_8DD8(var_1, self, self, var_3, var_4, var_6, var_8, "destroyed_" + var_1);
      thread _id_0A8D::_id_9137(var_1 + "_destroyed", undefined, undefined, self.origin);
    }

    self notify(var_0, 1);
  }
}

_id_10BDB(var_0) {
  self endon(var_0);
  self waittill("disconnect");
  self notify(var_0, 1);
}

_id_10BDF(var_0) {
  self endon(var_0);
  self waittill("joined_team");
  self notify(var_0, 1);
}

_id_10BDC(var_0) {
  self endon("disconnect");
  self endon(var_0);
  var_1 = level._id_5F3A;

  for(;;) {
    var_2 = 0;

    while(self useButtonPressed()) {
      var_2 = var_2 + var_1;

      if(var_2 > 0.75) {
        self._id_B701 = self.origin;
        self notify(var_0);
        return;
      }

      wait(var_1);
    }

    waitframe();
  }
}

_id_10BE0(var_0, var_1) {
  self endon("disconnect");
  self endon(var_0);
  wait(var_1);
  self notify(var_0, 1);
}

_id_10BDD(var_0) {
  self endon("disconnect");
  self endon(var_0);

  for(;;) {
    self waittill("emp_damage", var_1, var_2);
  }
}

_id_10BDE(var_0) {
  scripts\engine\utility::waittill_any_2(var_0, "level_game_ended");
  _id_E904();
}

_id_10B64() {
  level waittill("game_ended");
  self notify("level_game_ended");
}

_id_E691(var_0, var_1, var_2, var_3) {
  if(isDefined(self) && isalive(var_0)) {
    self _meth_850E(var_0);

    if(isDefined(var_3)) {
      self visionsetnakedforplayer(var_3, 0);
    }

    self._id_B75E = var_0;
  }
}

_id_E904() {
  if(isDefined(self)) {
    if(scripts\mp\utility\killstreak::_id_87C0()) {
      self _meth_850F();
      self visionsetnakedforplayer("", 0);
    }

    self.streakinfo notify("killstreak_finished_with_deploy_weapon");
    self._id_B75E = undefined;
    self._id_0F56 = undefined;
  }
}

_id_3924(var_0) {
  _id_09F1::_id_C474(var_0._id_965F);
  scripts\mp\class::_id_961E();
}

_id_C0C3(var_0) {
  var_1 = undefined;

  switch (var_0._id_965F) {
    case "archetype_assault":
      var_1 = _id_09F0::_id_19C5;
      break;
  }

  scripts\mp\class::_id_9653(var_0);

  if(isDefined(var_1)) {
    self[[var_1]]();
  }
}

_id_8D95(var_0) {}