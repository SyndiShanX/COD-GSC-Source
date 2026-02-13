/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2336.gsc
*************************************************/

init() {
  level.aether_grenade_tag_overrides["s4_thermite_zm"] = "j_gun";
}

_id_F0FB(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_3 = var_0;
    var_0 = self launchgrenade("s4_thermite_zm", var_3.origin, (0, 0, 0));
    var_0._id_7014 = var_3;
    var_0.angles = var_3.angles;
    var_0.owner = self;
    var_0 linkto(var_3);
    var_0 setscriptablepartstate("visibility", "hide", 0);
  }

  var_0.thermitekills = 0;
  var_0._id_714E = self.name;
  var_0 thread _id_F0FC();
  var_0 thread _id_F0FE(var_1, var_2);
}

_id_F0FE(var_0, var_1) {
  self endon("death");
  var_2 = undefined;

  if(istrue(var_0)) {
    var_3 = _id_F0FD();

    if(!istrue(var_3)) {
      thread _id_F0F4();
      return;
    }

    if(isDefined(self._id_7014)) {
      self._id_7014 delete();
    }
  } else {
    self waittill("missile_stuck", var_2, var_4);

    if(istrue(var_1)) {
      _id_F0F9(var_2, var_4);
    }
  }

  level notify("grenade_exploded_during_stealth", self, "thermite_mp", self._id_714E);

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  self setscriptablepartstate("effects", "impact", 0);
  self setscriptablepartstate("damage", "impact", 0);

  if(getdvarint("#x3dee089cb49164e4e", 0)) {
    scripts\engine\utility::_id_5474("thermite_impact_damage");
  }

  self radiusdamage(self.origin, 125, 30, 30, self.owner, "MOD_FIRE", "s4_thermite_zm");
  wait 0.5;

  if(getdvarint("#x3dee089cb49164e4e", 0)) {
    scripts\engine\utility::_id_5470("thermite_impact_damage");
  }

  var_5 = 1;

  while(var_5 <= 10) {
    var_6 = var_5 + 1;

    if(scripts\engine\utility::_id_9FC4(var_6, 2) > 0) {
      self setscriptablepartstate("damage", "antiVehicle", 0);
      self radiusdamage(self.origin, 125, 25, 10, self.owner, "MOD_FIRE", "s4_thermite_zm");
    } else {
      self setscriptablepartstate("damage", "antiPlayer", 0);
      self radiusdamage(self.origin, 125, 25, 10, self.owner, "MOD_FIRE", "s4_thermite_zm");
    }

    var_5 = var_6;
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
  _id_F0F9(var_0, var_1);
  return 1;
}

_id_F0F9(var_0, var_1) {
  if(isDefined(var_0)) {
    if(isPlayer(var_0) || isagent(var_0)) {
      if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
        if(isDefined(var_1)) {
          self linkto(var_0, var_1);
        } else {
          self linkto(var_0, "j_spine", (0, 0, 0));
        }

        if(isPlayer(var_0)) {
          var_0 thread _id_0777::_id_523C(0.6);
        }
      }
    } else if(isDefined(var_1))
      self linkto(var_0, var_1);
    else {
      self linkto(var_0);
    }
  }
}

_id_F0FC() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  thread _id_F0F5();
}

_id_F0F5() {
  var_0 = self _meth_8151();

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(istrue(var_0.inlaststand)) {
      var_0 thread _id_F0F8();
    }
  }

  thread _id_F0F4(5);
  self setscriptablepartstate("effects", "burnEnd", 0);
}

_id_F0F4(var_0) {
  self notify("death");
  self._id_57CE = 1;
  self _meth_85A3(1);
  wait(var_0);

  if(isDefined(self)) {
    self delete();
  }
}

_id_F0FA(var_0) {
  if(var_0._id_9CD6 == "MOD_IMPACT") {
    return 1;
  }

  var_0._id_103C2 thread _id_0777::_id_523C(0.6);
  return 1;
}

_id_F0F8() {
  self endon("disconnect");
  self notify("newBurnFXLaststand");
  self endon("newBurnFXLaststand");
  waitframe();
  thread _id_0777::_id_523C(4);
}

get_thermite_impact_damage_radius() {
  return 125;
}

get_thermite_tick_damage_radius() {
  return 125;
}