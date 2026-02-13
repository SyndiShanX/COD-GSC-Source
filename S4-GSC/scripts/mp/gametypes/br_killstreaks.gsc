/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_killstreaks.gsc
***************************************************/

_id_B66E() {
  return !isDefined(self._id_2BD8);
}

_id_EDC7(var_0) {
  var_1 = level._id_2A95._id_2A42[var_0._id_CF22];
  self._id_2BD8 = var_1;
  _id_B703(var_1);
  _id_B6BE();
  thread _id_B6CD(var_1);
}

_id_B703(var_0) {
  self._id_2BDA = scripts\mp\hud_util::createfontstring("default", 0.75);
  self._id_2BDA scripts\mp\hud_util::setpoint("CENTER", "BOTTOM LEFT", 270, -70);
  self._id_2BDA.label = &"MP_BR_ACTIVATE_KILLSTREAK";
  var_1 = game["killstreakTable"]._id_EC74[var_0]["hudIcon"];
  self._id_2BD9 = scripts\mp\hud_util::createicon(var_1, 30, 30);
  self._id_2BD9 scripts\mp\hud_util::setpoint("CENTER", "BOTTOM LEFT", 270, -45);
}

_id_B6BE() {
  self giveweapon("super_default_mp");
  self setweaponammoclip("super_default_mp", 1);
  self _meth_84E9("super_default_mp");
}

_id_B6CD(var_0) {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("special_weapon_fired", var_1);
    var_2 = _id_B804();

    if(var_2) {
      _id_B762();
      return;
    } else
      self setweaponammoclip("super_default_mp", 1);
  }
}

_id_B804() {
  if(!isalive(self)) {
    return 0;
  }

  var_0 = scripts\mp\killstreaks\killstreaks::_id_4057(self._id_2BD8);
  var_1 = scripts\mp\killstreaks\killstreaks::_id_F62A(var_0);
  return istrue(var_1);
}

_id_B762() {
  self takeweapon("super_default_mp");
  self._id_2BD8 = undefined;

  if(isDefined(self._id_2BDA)) {
    self._id_2BDA destroy();
  }

  if(isDefined(self._id_2BD9)) {
    self._id_2BD9 destroy();
  }
}

_id_4344(var_0, var_1, var_2, var_3) {
  var_4 = scripts\common\utility::_id_B7B6(var_0, var_1);

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && scripts\mp\utility\player::isreallyalive(var_6) && var_6.team != self.team) {
      _id_4343(var_6, var_2, var_3);
    }
  }
}

_id_4343(var_0, var_1, var_2, var_3) {
  if(istrue(var_2) && scripts\mp\utility\killstreak::_id_6AE1(var_1)) {
    var_4 = scripts\mp\gametypes\br_public::_id_2BBB(self);
    var_5 = var_4 + "_enemy_" + var_1 + "_inbound";
    var_0 _id_0A8D::_id_9137(var_5, "killstreak_used");
  }

  switch (var_1) {
    case "toma_strike":
      var_1 = 1;
      break;
    case "precision_airstrike":
      var_1 = 2;
      break;
    case "gulag_closed":
      var_1 = 3;
      break;
    default:
      var_1 = 0;
      break;
  }

  if(var_1 > 0) {
    var_0 setclientomnvar("ui_br_danger_warning", var_1);
    _id_4345(var_0, var_3);
  }
}

_id_4345(var_0, var_1) {
  var_2 = var_0 getxuid();

  if(!isDefined(var_1)) {
    var_1 = 4;
  }

  level notify("danger_notify_start_" + var_2);
  level thread _id_10AC1(var_0, var_2, "death_or_disconnect");
  level thread _id_10AC1(var_0, var_2, undefined, var_1);
}

_id_10AC1(var_0, var_1, var_2, var_3) {
  level endon("danger_notify_start_" + var_1);
  level endon("danger_notify_finished_" + var_1);
  level endon("game_ended");

  if(isDefined(var_2)) {
    var_0 waittill(var_2);
  } else if(isDefined(var_3)) {
    wait(var_3);
  }

  if(isDefined(var_0)) {
    var_0 setclientomnvar("ui_br_danger_warning", 0);
  }

  level notify("danger_notify_finished_" + var_1);
}