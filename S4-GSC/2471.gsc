/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2471.gsc
*************************************************/

_id_F198() {
  level._id_F1BC = getdvarfloat("#x3a3c3af2f0d401fe5", 12);
  level._id_F1BD = getdvarfloat("#x3c9328c48f35b48e1", 20);
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "init")]]();
}

_id_F19F(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "onGive")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "onGive")]](var_0, var_1);
  }
}

_id_F1A0(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "onTake")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "onTake")]](var_0, var_1);
  }
}

_id_F1A2(var_0) {
  var_0 makeunusable();

  if(!isDefined(var_0._id_5562)) {
    var_0._id_5562 = "equip_throwing_knife";
  }

  var_1 = undefined;
  var_2 = undefined;
  var_3 = self.name;
  var_0 waittill("missile_stuck", var_1, var_2);
  level notify("grenade_exploded_during_stealth", var_0, "s4_throwing_knife_mp", var_3);
  var_4 = isDefined(var_2) && var_2 == "tag_flicker";
  var_5 = isDefined(var_2) && var_2 == "tag_weapon";

  if(isDefined(var_1) && (isPlayer(var_1) || isagent(var_1)) && var_4) {
    var_1 notify("shield_hit", var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "onStuck")) {
    var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "onStuck")]](var_0, var_4, var_5);

    if(!var_6) {
      return;
    }
  }

  var_0 _id_F199();
}

_id_F199() {
  self makeunusable();
  var_0 = spawn("trigger_radius", self.origin, 0, 64, 64);
  var_0._id_0481 = "dropped_knife";
  var_0 _meth_80DB();
  var_0 linkto(self);
  self._id_8E32 = var_0;

  if(!isDefined(level._id_F1C4)) {
    level._id_F1C4 = [];
  }

  var_1 = [self];

  foreach(var_3 in level._id_F1C4) {
    if(var_1.size >= level._id_F1BC) {
      if(isDefined(var_3)) {
        var_3 _id_F197();
      }

      continue;
    }

    if(isDefined(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  level._id_F1C4 = var_1;
  thread _id_F1A3();
  thread _id_F1A4();
}

_id_F1A3() {
  self endon("death");

  for(;;) {
    self._id_8E32 waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(!var_0 hasweapon(self._id_10D0C)) {
      continue;
    }
    if(var_0 _id_F1A1(self._id_5562)) {
      var_0 playsoundtoplayer("weap_pickup_knife", var_0, var_0);
      thread _id_F197();
    }
  }
}

_id_F1A4() {
  self endon("death");
  wait(level._id_F1BD);
  thread _id_F197();
}

_id_F197() {
  if(isDefined(self._id_8E32)) {
    self._id_8E32 delete();
  }

  self delete();
}

_id_F1A1(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "tryToPickup")) {
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "tryToPickup")]](var_0);
    return var_1;
  }

  return 1;
}