/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2586.gsc
*************************************************/

_id_F0F7() {
  level._effect["thermite_burst"] = loadfx("vfx/s4/equipment/vfx_thermite_burn_new.vfx");
}

_id_F0FB(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_0;
    var_0 = scripts\mp\utility\weapon::_id_0C48("s4_thermite_mp", var_2.origin, (0, 0, 0));
    scripts\mp\weapons::_id_7168(var_0, makeweapon("s4_thermite_mp"));
    var_0._id_7014 = var_2;
    var_0.angles = var_2.angles;
    var_0._id_7015 = self getcurrentweapon();
    var_0 linkto(var_2);
    var_0._id_57CE = 1;
    var_0 setscriptablepartstate("visibility", "hide", 0);
  }

  var_0 thread _id_F0FC();
  var_0 thread _id_F0FE(var_1);
}

_id_F0FE(var_0) {
  self endon("death");
  var_1 = undefined;

  if(istrue(var_0)) {
    var_2 = _id_F0FD();

    if(!istrue(var_2)) {
      thread _id_F0F4();
      return;
    }

    if(isDefined(self._id_7014)) {
      self._id_7014 delete();
    }
  } else
    self waittill("missile_stuck", var_1);

  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");

  if(!istrue(var_0)) {
    if(isDefined(var_1) && isPlayer(var_1)) {
      thread scripts\mp\weapons::_id_717C(self, var_1);
    }
  }

  thread _id_F0FF();
  playFX(level._effect["thermite_burst"], self.origin);
  self setscriptablepartstate("effects", "impact", 0);
  _id_F0F6("s4_thermite_mp");

  if(!istrue(level._id_434D)) {
    self._id_4349 = _id_0817::_id_1135(self.origin, 175, 175, self.owner.team, 100, self.owner, 1, self, 1);
  }

  wait 0.5;
  var_3 = 1;

  while(var_3 <= 10) {
    var_4 = var_3 + 1;

    if(scripts\engine\utility::_id_9FC4(var_4, 2) > 0) {
      _id_F0F6("s4_thermite_mp");
    } else {
      _id_F0F6("s4_thermite_mp");
    }

    var_3 = var_4;
    wait 0.5;
  }

  thread _id_F0F5();
}

_id_F0FD() {
  self._id_7014 endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self._id_7014 waittill("missile_stuck", var_0, var_1, var_2, var_3, var_4, var_5);

  if(isDefined(var_0)) {
    if(isPlayer(var_0) || isagent(var_0)) {
      if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
        if(isPlayer(var_0)) {
          thread scripts\mp\weapons::_id_717C(self, var_0);
        }

        if(isDefined(var_1)) {
          self linkto(var_0, var_1);
        } else {
          self linkto(var_0, "j_spine4", (0, 0, 0));
        }
      }
    } else if(isDefined(var_1))
      self linkto(var_0, var_1);
    else {
      self linkto(var_0);
    }
  }

  return 1;
}

_id_F0FF() {
  self endon("death");
  var_0 = self _meth_8151();

  while(isDefined(var_0)) {
    self waittill("missile_stuck", var_0);
  }

  self._id_20ED = _func_02B2(self.origin, (100, 100, 100), (0, 0, 0));
}

_id_F0F6(var_0) {
  var_1 = 100;
  var_2 = 33;
  var_3 = 25;
  var_4 = "MOD_FIRE";

  if(var_0 == "s4_thermite_mp") {
    var_1 = 100;
    var_2 = 25;
    var_3 = 25;
  }

  var_5 = self._id_EA8F;

  if(isDefined(var_5)) {
    if(isPlayer(var_5) && var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_5 dodamage(var_2, self.origin, self.owner, self, var_4, var_0);
      var_5 _id_09BF::_id_10A2("thermiteStuck", 0, 0, ::_id_F0F3);
    } else
      var_5 = undefined;
  }

  self radiusdamage(self.origin, var_1, var_2, var_3, self.owner, var_4, var_0);

  if(isDefined(var_5)) {
    var_5 _id_09BF::_id_C48A("thermiteStuck", 0);
  }
}

_id_F0F3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(!isDefined(var_0.weapon_name) || var_0.weapon_name != "s4_thermite_mp") {
    return 1;
  }

  if(!isDefined(var_0._id_EA8F) || var_0._id_EA8F != var_2) {
    return 1;
  }

  return 0;
}

_id_F0FC() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  thread _id_F0F5();
}

_id_F0F5() {
  thread _id_F0F4(5);
  self setscriptablepartstate("effects", "burnEnd", 0);
}

_id_F0F4(var_0) {
  self notify("death");
  self._id_57CE = 1;

  if(isDefined(self._id_4349)) {
    _id_0817::_id_C51F(self._id_4349);
    self._id_4349 = undefined;
  }

  if(isDefined(self._id_20ED)) {
    _func_02B1(self._id_20ED);
    self._id_20ED = undefined;
  }

  self _meth_85A3(1);

  if(isDefined(var_0)) {
    wait(var_0);
  }

  self delete();
}

_id_F0FA(var_0) {
  if(var_0._id_9CD6 == "MOD_IMPACT") {
    return 1;
  }

  var_0._id_103C2._id_8F9E = gettime();
  var_0._id_103C2 thread scripts\mp\weapons::_id_523C(0.6);
  return 1;
}