/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2087.gsc
*************************************************/

init() {
  _id_0AA3::_id_C28D(::onplayerspawned);
  setsaveddvar("#x359518d6edb406980", 0);
}

onplayerspawned() {
  self._id_0DD8 = [];
  thread _id_10E16();
}

_id_10E16() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = gettime();

  for(;;) {
    self waittill("bulletwhizby", var_1, var_2);
    var_0 = _id_4EAC(var_1, var_0);
  }
}

_id_4EAC(var_0, var_1) {
  if(gettime() - var_1 > 190 && !scripts\mp\utility\player::_id_8ACE() && getDvar("#x3835f0e1e481fb6b2") == "") {
    thread _id_10E13(var_0);
    var_1 = gettime();
  }

  var_2 = var_0 getcurrentweapon();

  if(weaponclass(var_2) == "sniper") {
    scripts\mp\battlechatter_mp::_id_F759(self, "flavor_surprise", undefined, 0.2);
  }

  thread scripts\mp\battlechatter_mp::_id_111F(var_0);
  return var_1;
}

_id_4EAD() {
  foreach(var_1 in self._id_0DD8) {
    if(isalive(var_1)) {
      var_1 delete();
    }
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_whizby_event", 0);
  }
}

_id_10E13(var_0) {
  if(getdvarint("#x359518d6edb406980", 1) == 1) {
    var_1 = var_0 getcurrentweapon();
    var_2 = weaponclass(var_1);

    if(var_1 _meth_8624("linearbrake", 1) && !scripts\mp\utility\weapon::_id_88F6(var_1) && !scripts\mp\utility\perk::_hasperk("specialty_blastshield")) {
      if(!isDefined(self._id_EBBB)) {
        self._id_EBBB = 0;
      }

      self notify("whizbyBlur_reset");
      var_3 = self._id_EBBB;
      self._id_EBBB = clamp(self._id_EBBB + _id_6DA9(var_2, self, var_0), 0, 100);
      scripts\mp\gamescore::_id_F3FA(var_0, self, var_1.basename);
      thread _id_10E12(var_3, self._id_EBBB);
    }
  }
}

_id_10E12(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("whizbyBlur_reset");
  var_2 = 0.3;

  while(var_0 < var_1) {
    var_0 = var_0 + 20;
    self earthquakeforplayer(var_2, 1.1, self.origin, 100);
    var_2 = var_2 + 0.1;
    wait 0.05;
  }
}

_id_10E11(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("whizbyBlur_reset");

  while(self._id_EBBB > 0) {
    self._id_EBBB = self._id_EBBB - 2.5;

    if(self._id_EBBB < 0) {
      self._id_EBBB = 0;
    }

    var_2 = clamp(self._id_EBBB, 0, 100);
    wait 0.2;
  }

  self._id_EBBB = 0;
  scripts\mp\gamescore::_id_FB2C(var_0, self, var_1);
}

_id_6DA9(var_0, var_1, var_2) {
  var_3 = distance2d(var_1.origin, var_2.origin);

  if(var_3 < 1024) {
    var_3 = var_3 * 0.25;
  }

  switch (var_0) {
    case "mg":
      return 10.0 * (var_3 / 1024);
    case "sniper":
      return 5.0 * (var_3 / 1024);
    default:
      return 0;
  }
}