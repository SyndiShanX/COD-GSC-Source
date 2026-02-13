/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2013.gsc
*************************************************/

init() {
  var_0 = scripts\mp\utility\dvars::_id_6BFB(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_healthregentime"), "#x362b15ff47d91275");
  scripts\mp\tweakables::_id_D738("player", "healthregentime", var_0);
  scripts\mp\tweakables::_id_D737("player", "healthregentime", var_0);
  level._id_7644 = scripts\mp\tweakables::_id_6E14("player", "healthregentime");
  level._id_7647 = level._id_7644 <= 0;
  level._id_B6D2 = level._id_7644;
  _id_0AA3::_id_C28D(::onplayerspawned);
}

onplayerspawned() {
  thread _id_9A29();
  self visionsetthermalforplayer(game["thermal_vision"]);
}

_id_9A29() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self._id_4401 = 0;
  self._id_4409 = 0;
  self._id_7556 = 0;
  self _meth_83EF("sys_deaths_door_exit");
  self _meth_83EF("sys_deaths_door_intro_impact");
  self _meth_8680("deaths_door_mp");

  for(;;) {
    scripts\engine\utility::_id_108C5("damage", "force_regeneration");
    thread _id_762D();
  }
}

_id_AAC8() {
  if(istrue(self._id_4401)) {
    return;
  }
  self._id_4401 = 1;
  self._id_ADE5 = 0;

  if(!istrue(self._id_4409)) {
    self._id_4409 = 1;
    self playlocalsound("sys_deaths_door_intro_impact");

    if(scripts\mp\utility\player::_id_8855()) {
      self _meth_83EF("sys_deaths_door_exit_mp_fm");
      self playlocalsound("sys_deaths_door_breath_lp_mp_fm");
    } else {
      self _meth_83EF("sys_deaths_door_exit_mp");
      self playlocalsound("sys_deaths_door_breath_lp_mp");
    }

    self _meth_867F("deaths_door_mp", 0.2, 1);
    _func_02E3("deaths_door", "on", 0.05);
    self enableplayerbreathsystem(0);
    thread _id_B669();
  }

  if(level._id_7647) {
    self painvisionon();
  }

  self notify("deaths_door_enter");
}

_id_AADF(var_0) {
  if(istrue(var_0)) {
    self._id_ADE5 = 0;
    self._id_7556 = 0;
  }

  if(!istrue(self._id_4401)) {
    return;
  }
  self._id_4401 = 0;
  self._id_4409 = 0;
  self _meth_83EF("sys_deaths_door_intro_impact");

  if(scripts\mp\utility\player::_id_8855()) {
    self playlocalsound("sys_deaths_door_exit_mp_fm");
    wait 0.2;
    self _meth_83EF("sys_deaths_door_breath_lp_mp_fm");
  } else {
    self playlocalsound("sys_deaths_door_exit_mp");
    wait 0.55;
    self _meth_83EF("sys_deaths_door_breath_lp_mp");
  }

  self _meth_83EF("sys_deaths_door_lp_mp");
  self _meth_83EF("sys_deaths_door_breath_lp_mp");
  self _meth_8680("deaths_door_mp");
  _func_02E3("deaths_door", "", 0.05);

  if(level._id_7647) {
    self painvisionoff();
  }

  self notify("deaths_door_exit");
}

_id_AAF5() {
  self notify("healed");
  level notify("healed", self);
  thread _id_07C3::_id_C4F5();
  self setclientomnvar("ui_health_regen_hud", 0);

  if(level.gameended) {
    return;
  }
  if(scripts\mp\utility\player::_id_8ACE()) {
    return;
  }
}

_id_6A91(var_0) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    if(isDefined(var_0)) {
      if(var_0 == "equip_bandages") {
        return self.maxhealth * _id_0A03::_id_68F6() / _id_0A03::_id_68F7();
      }

      return self.maxhealth / _id_0A03::_id_6A3B();
    }
  }

  return 4;
}

_id_762D(var_0) {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  self notify("healhRegenThink");
  self endon("healhRegenThink");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_1 = !istrue(self._id_11B4) && !istrue(self._id_21BE) && !istrue(self._id_9070);
  var_2 = self.health / self.maxhealth;

  if(var_2 < 0.55 && !scripts\mp\utility\player::_id_8ACE()) {
    _id_AAC8();
  }

  if(var_1) {
    if(level._id_7647) {
      return;
    }
    while(istrue(self._id_7647) || !scripts\mp\utility\player::_id_85EC()) {
      waitframe();
    }

    _id_10806();
  }

  if(!var_1 || scripts\mp\utility\perk::_hasperk("specialty_regenfaster")) {
    self setclientomnvar("ui_health_regen_hud", 1);
  }

  var_3 = self.maxhealth / 50.0;
  var_4 = 0.0;
  var_5 = self.health;
  var_6 = istrue(self._id_11B4);
  self notify("heal_started");

  for(;;) {
    if(!scripts\mp\utility\player::_id_85EC() || istrue(self._id_7647) && var_1) {
      self notify("heal_interrupted");
      return;
    }

    wait 0.05;
    var_7 = var_3;

    if(istrue(self._id_11B4)) {
      var_7 = _id_09FC::_id_6A90();
    } else if(istrue(self._id_21BE)) {
      var_7 = _id_6A91(var_0);
      wait 1;
    } else if(istrue(self._id_9070))
      var_7 = _id_0A6F::_id_9067();
    else if(scripts\mp\utility\perk::_hasperk("specialty_regenfaster")) {
      var_7 = var_3 * level._id_C1BE;
    }

    if(self.health < self.maxhealth) {
      var_8 = self.health + var_7 + var_4;
      var_9 = int(min(self.maxhealth, var_8));
      var_4 = var_8 - var_9;
      self.health = var_9;
      var_2 = self.health / self.maxhealth;

      if(var_2 > 0.8) {
        _id_AADF(1);
      }
    }

    if(self.health >= self.maxhealth) {
      self.health = self.maxhealth;
      break;
    }
  }

  if(var_6) {
    var_10 = self.health - var_5;
    _id_07C3::_id_3AC3("equip_adrenaline", var_10);
    scripts\mp\utility\stats::_id_7DAE("stimDamageHealed", var_10);
    _id_07BC::_id_ABAE(var_10);
    _id_07A9::_id_977B(self, var_10, self);
  }

  if(isDefined(self.pers["damageHealed"])) {
    var_10 = self.health - var_5;
    scripts\mp\utility\stats::_id_7DAE("damageHealed", var_10);
  }

  if(self.health - var_5 >= self.maxhealth * 0.7) {
    thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_001");
  }

  if(var_1) {
    level thread scripts\mp\battlechatter_mp::_id_F759(self, "player_recover");
  }

  _id_AAF5();
}

_id_10806() {
  self endon("force_regeneration");
  self endon("begin_regeneration");
  self._id_DD04 = 0.0;

  if(isDefined(self._id_9044)) {
    var_0 = gettime();
    var_1 = var_0 - self._id_9044;
    var_1 = var_1 * 0.001;

    if(scripts\mp\utility\perk::_hasperk("specialty_shrapnel_resist")) {
      var_2 = 1;
      self._id_DD04 = max(var_2 - var_1, 0);
    } else
      self._id_DD04 = max(3 - var_1, 0);
  }

  if(!isDefined(self._id_C1B9)) {
    self._id_C1B9 = 1;
  }

  var_3 = self._id_DD04 > 0.0;

  if(var_3) {
    thread _id_19E7();
  }

  if(!isDefined(self._id_C1B8) || gettime() - self._id_C1B8 > 150) {
    self._id_C1B7 = 0;
  }

  var_4 = level._id_B6D2 + self._id_DD04;
  self._id_41E6 = var_4;
  var_0 = gettime() * 0.001;

  while(self._id_41E6 - self._id_C1B7 > 0) {
    self._id_41E6 = self._id_41E6 - (gettime() * 0.001 - var_0) * self._id_C1B9;
    var_0 = gettime() * 0.001;

    if(var_3 && self._id_41E6 - self._id_C1B7 <= level._id_B6D2) {
      var_3 = 0;

      if(self._id_C1B7 > 0) {
        self notify("shrapnel_ended");
      } else {
        self notify("shrapnel_ended_early");
      }
    }

    wait 0.05;
  }

  if(var_3) {
    self notify("shrapnel_ended_early");
  }

  self._id_C1B7 = 0;
  self._id_C1B8 = 0;
}

_id_C17C(var_0) {
  if(!isDefined(self._id_C1B7)) {
    self._id_C1B7 = 0;
    self._id_C1B8 = 0;
  }

  self._id_C1B7 = self._id_C1B7 + var_0;
  self._id_C1B8 = gettime();
}

_id_B669(var_0) {
  self endon("death_or_disconnect");
  self endon("deaths_door_exit");
  self endon("healed");
  self endon("last_stand_revived");
  level endon("game_ended");
  wait 0.5;

  for(;;) {
    if(scripts\mp\utility\player::_id_8ACE()) {
      waitframe();
      continue;
    }

    if(level._id_7647) {
      self._id_ADE5++;

      if(self._id_ADE5 > scripts\engine\utility::ter_op(istrue(self._id_7556), 1, 4)) {
        wait 1.0;
        self._id_7556 = 1;
        _id_AADF(0);
        break;
      }
    }

    wait 1.7;
  }
}

_id_19E7() {
  self endon("disconnect");
  self notify("applyShrapnelFX");
  self endon("applyShrapnelFX");
  self setclientomnvar("ui_shrapnel_overlay", 1);
  var_0 = _id_19E8();

  if(istrue(var_0)) {
    self setclientomnvar("ui_shrapnel_overlay", 2);
  } else {
    self setclientomnvar("ui_shrapnel_overlay", 3);
  }
}

_id_19E8() {
  self endon("death");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  var_0 = scripts\engine\utility::_id_10898("shrapnel_ended_early", "shrapnel_ended", "force_regeneration");
  return var_0 == "shrapnel_ended";
}