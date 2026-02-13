/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2472.gsc
*************************************************/

_id_F1A6() {
  level._id_F1C9 = getdvarfloat("#x390e9c65294eab894", 12);
  level._id_F1CA = getdvarfloat("#x311e0701a146d97a8", 20);
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_star", "init")]]();
}

_id_F1AD(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_star", "onGive")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_star", "onGive")]](var_0, var_1);
  }
}

_id_F1AE(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_star", "onTake")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_star", "onTake")]](var_0, var_1);
  }
}

_id_F1B0(var_0) {
  var_0 makeunusable();

  if(!isDefined(var_0._id_5562)) {
    var_0._id_5562 = "equip_throwing_star";
  }

  var_1 = undefined;
  var_2 = undefined;
  var_3 = self.name;
  var_0 waittill("missile_stuck", var_1, var_2);
  level notify("grenade_exploded_during_stealth", var_0, "s4_throwing_star_mp", var_3);
  var_4 = isDefined(var_2) && var_2 == "tag_flicker";
  var_5 = isDefined(var_2) && var_2 == "tag_weapon";

  if(isDefined(var_1) && (isPlayer(var_1) || isagent(var_1)) && var_4) {
    var_1 notify("shield_hit", var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_star", "onStuck")) {
    var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_star", "onStuck")]](var_0, var_4, var_5);

    if(!var_6) {
      return;
    }
  }

  var_0 _id_F1A7();
}

_id_F1A7() {
  self makeunusable();
  var_0 = spawn("trigger_radius", self.origin, 0, 64, 64);
  var_0._id_0481 = "dropped_star";
  var_0 _meth_80DB();
  var_0 linkto(self);
  self._id_E599 = var_0;

  if(!isDefined(level._id_F1C4)) {
    level._id_F1C4 = [];
  }

  var_1 = [self];

  foreach(var_3 in level._id_F1C4) {
    if(var_1.size >= level._id_F1C9) {
      if(isDefined(var_3)) {
        var_3 _id_F1A5();
      }

      continue;
    }

    if(isDefined(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  level._id_F1C4 = var_1;
  thread _id_F1B1();
  thread _id_F1B2();
}

_id_F1B1() {
  self endon("death");

  for(;;) {
    self._id_E599 waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(!var_0 hasweapon(self._id_10D0C)) {
      continue;
    }
    if(var_0 _id_F1AF(self._id_5562)) {
      thread _id_F1A5();
    }
  }
}

_id_F1B2() {
  self endon("death");
  wait(level._id_F1CA);
  thread _id_F1A5();
}

_id_F1A5() {
  if(isDefined(self._id_E599)) {
    self._id_E599 delete();
  }

  self delete();
}

_id_F1AF(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_star", "tryToPickup")) {
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_star", "tryToPickup")]](var_0);
    return var_1;
  }

  return 1;
}