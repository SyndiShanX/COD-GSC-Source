/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_sealion\br_sealion_sidequest_fishing.gsc
***********************************************************************/

main() {
  level thread _id_DEEE3B97BF9C0945();
}

_id_DEEE3B97BF9C0945() {
  if(!getdvarint("dvar_DC22C2DA086230DF", 0)) {
    return;
  }
  waitframe();

  if(!scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    return;
  }
  level thread init();
}

init() {
  _id_618A1163576C3819();
  scripts\engine\scriptable::scriptable_adddamagedcallback(::_id_CFDA71453BAAE69D);
  level thread _id_2830A5E3B7D37FB8();
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  foreach(scriptable in level._id_10C122E690A46014._id_71D9FD7FFB3DE161)
  scriptable setscriptablepartstate("fishing_vfx", "enabled");
}

_id_618A1163576C3819() {
  level._id_10C122E690A46014 = spawnStruct();
  level._id_10C122E690A46014._id_A61A1C33714D934F = getdvarint("dvar_7171A114BEEBF815", 9);
  level._id_10C122E690A46014._id_58DD18A3C0D83313 = getdvarint("dvar_3FF1CB5D4C51376D", 20);
  level._id_10C122E690A46014._id_59002EA3C0FEAB2D = getdvarint("dvar_3FCEB55D4C2ABF53", 250);
  level._id_10C122E690A46014._id_5B7A05D9D9969B00 = getdvarint("dvar_5D032E79857E17EE", 3);
  level._id_10C122E690A46014._id_5B571BD9D97083AA = getdvarint("dvar_5CE020798557B16C", 6);
  _id_7EE2EA70C631C4BA();
}

_id_7EE2EA70C631C4BA() {
  level._id_10C122E690A46014._id_ED1ABA8B380E1520 = [];
  _id_D2366C783E31322D((10597, -8622, 300), 2400, "Water Treatment East", "Water Treatment East 1");
  _id_D2366C783E31322D((9868, -6741, 300), 1000, "Water Treatment East", "Water Treatment East 2");
  _id_D2366C783E31322D((8892, -8424, 300), 1000, "Water Treatment East", "Water Treatment East 3");
  _id_D2366C783E31322D((9035, -10333, 300), 1000, "Water Treatment East", "Water Treatment East 4");
  _id_D2366C783E31322D((8869, -13915, 300), 2100, "Water Treatment x Shipwreck", "Water Treatment x Shipwreck 1");
  _id_D2366C783E31322D((7604, -12557, 300), 1000, "Water Treatment x Shipwreck", "Water Treatment x Shipwreck 2");
  _id_D2366C783E31322D((7193, -14754, 300), 1000, "Water Treatment x Shipwreck", "Water Treatment x Shipwreck 3");
  _id_D2366C783E31322D((4058, -16653, 300), 1600, "Shipwreck x Water Treatment", "Shipwreck x Water Treatment 1");
  _id_D2366C783E31322D((3835, -15793, 300), 1000, "Shipwreck x Water Treatment", "Shipwreck x Water Treatment 2");
  _id_D2366C783E31322D((-412, -17745, 300), 2000, "Shipwreck", "Shipwreck 1");
  _id_D2366C783E31322D((-463, -16784, 300), 1000, "Shipwreck", "Shipwreck 2");
  _id_D2366C783E31322D((-5699, -17404, 300), 2500, "Shipwreck x Southeast Rock", "Shipwreck x Southeast Rock 1");
  _id_D2366C783E31322D((-4872, -15672, 300), 1000, "Shipwreck x Southeast Rock", "Shipwreck x Southeast Rock 2");
  _id_D2366C783E31322D((-7678, -16547, 300), 1000, "Shipwreck x Southeast Rock", "Shipwreck x Southeast Rock 3");
  _id_D2366C783E31322D((-10641, -14505, 300), 1800, "Southeast Rock", "Southeast Rock 1");
  _id_D2366C783E31322D((-9837, -14452, 300), 1000, "Southeast Rock", "Southeast Rock 2");
  _id_D2366C783E31322D((-10896, -12492, 300), 1000, "Southeast Rock", "Southeast Rock 3");
  _id_D2366C783E31322D((-15002, -10422, 300), 2500, "Port", "Port 1");
  _id_D2366C783E31322D((-12509, -10416, 300), 1000, "Port", "Port 2");
  _id_D2366C783E31322D((-14201, -7964, 300), 1000, "Port", "Port 3");
  _id_D2366C783E31322D((-15878, -4798, 300), 2000, "Beach Club Pier", "Beach Club Pier 1");
  _id_D2366C783E31322D((-14410, -5387, 300), 1000, "Beach Club Pier", "Beach Club Pier 2");
  _id_D2366C783E31322D((-17357, -3139, 300), 1000, "Beach Club Pier", "Beach Club Pier 3");
  _id_D2366C783E31322D((-17239, -1838, 300), 700, "Beach Club Pier", "Beach Club Pier 4");
  _id_D2366C783E31322D((-15651, -1078, 300), 700, "Beach Club Pier", "Beach Club Pier 5");
  _id_D2366C783E31322D((-14609, -1361, 300), 500, "Beach Club Pier", "Beach Club Pier 6");
  _id_D2366C783E31322D((-14679, -1978, 300), 400, "Beach Club Pier", "Beach Club Pier 7");
  _id_D2366C783E31322D((-18243, 3782, 300), 2400, "Beach Club x Jetty", "Beach Club x Jetty 1");
  _id_D2366C783E31322D((-17488, 1803, 300), 1000, "Beach Club x Jetty", "Beach Club x Jetty 2");
  _id_D2366C783E31322D((-15951, 4245, 300), 1000, "Beach Club x Jetty", "Beach Club x Jetty 3");
  _id_D2366C783E31322D((-13701, 6542, 300), 1600, "Harbor South", "Harbor South 1");
  _id_D2366C783E31322D((-13678, 5299, 300), 900, "Harbor South", "Harbor South 2");
  _id_D2366C783E31322D((-12439, 6378, 300), 900, "Harbor South", "Harbor South 3");
  _id_D2366C783E31322D((-11748, 4408, 300), 700, "Harbor South", "Harbor South 4");
  _id_D2366C783E31322D((-8086, 9577, 300), 1800, "Harbor", "Harbor 1");
  _id_D2366C783E31322D((-10335, 7838, 300), 1200, "Harbor", "Harbor 2");
  _id_D2366C783E31322D((-8974, 5203, 300), 1300, "Harbor", "Harbor 3");
  _id_D2366C783E31322D((-6810, 6185, 300), 1400, "Harbor", "Harbor 4");
  _id_D2366C783E31322D((-4350, 7432, 300), 2000, "Harbor", "Harbor 5");
  _id_D2366C783E31322D((-4191, 5228, 300), 800, "Harbor", "Harbor 6");
  _id_D2366C783E31322D((-5442, 4016, 300), 600, "Harbor", "Harbor 7");
  _id_D2366C783E31322D((-6805, 4224, 300), 800, "Harbor", "Harbor 8");
  _id_D2366C783E31322D((-4560, 12162, 300), 1000, "Harbor North", "Harbor North 1");
  _id_D2366C783E31322D((-2290, 11142, 300), 1100, "Harbor North", "Harbor North 2");
  _id_D2366C783E31322D((-1010, 13657, 300), 1000, "Harbor North", "Harbor North 3");
  _id_D2366C783E31322D((429, 11474, 300), 1200, "Harbor North", "Harbor North 4");
  _id_D2366C783E31322D((-841, 9466, 300), 700, "Harbor North", "Harbor North 5");
  _id_D2366C783E31322D((4063, 12260, 300), 1700, "Jetty x Northwest Point West", "Jetty x Northwest Point West 1");
  _id_D2366C783E31322D((3036, 10899, 300), 1000, "Jetty x Northwest Point West", "Jetty x Northwest Point West 2");
  _id_D2366C783E31322D((4113, 11082, 300), 1000, "Jetty x Northwest Point West", "Jetty x Northwest Point West 3");
  _id_D2366C783E31322D((5633, 12113, 300), 1000, "Jetty x Northwest Point West", "Jetty x Northwest Point West 4");
  _id_D2366C783E31322D((8707, 11944, 300), 1500, "Northwest Point West", "Northwest Point West 1");
  _id_D2366C783E31322D((8154, 11262, 300), 1000, "Northwest Point West", "Northwest Point West 2");
  _id_D2366C783E31322D((10143, 11375, 300), 1100, "Northwest Point West", "Northwest Point West 3");
  _id_D2366C783E31322D((14632, 11078, 300), 2500, "Northwest", "Northwest 1");
  _id_D2366C783E31322D((12771, 10824, 300), 1100, "Northwest", "Northwest 2");
  _id_D2366C783E31322D((13745, 9293, 300), 1100, "Northwest", "Northwest 3");
  _id_D2366C783E31322D((13915, 3837, 300), 2800, "Northwest Point North", "Northwest Point North 1");
  _id_D2366C783E31322D((11570, 7996, 300), 1000, "Northwest Point North", "Northwest Point North 2");
  _id_D2366C783E31322D((12397, 6345, 300), 1500, "Northwest Point North", "Northwest Point North 3");
  _id_D2366C783E31322D((11750, 5534, 300), 1500, "Northwest Point North", "Northwest Point North 4");
  _id_D2366C783E31322D((11183, 2418, 300), 1500, "Northwest Point North", "Northwest Point North 5");
  _id_D2366C783E31322D((11734, -2444, 300), 2700, "Water Treatment West", "Water Treatment West 1");
  _id_D2366C783E31322D((9990, -737, 300), 1000, "Water Treatment West", "Water Treatment West 2");
  _id_D2366C783E31322D((10296, -4162, 300), 1000, "Water Treatment West", "Water Treatment West 3");
  _id_D2366C783E31322D((7068, -2719, 300), 250, "Canals North", "Canals North 1");
  _id_D2366C783E31322D((6432, -2713, 300), 250, "Canals North", "Canals North 2");
  _id_D2366C783E31322D((5740, -2708, 300), 250, "Canals North", "Canals North 3");
  _id_D2366C783E31322D((4815, -2580, 300), 250, "Canals North", "Canals North 4");
  _id_D2366C783E31322D((4141, -2460, 300), 250, "Canals North", "Canals North 5");
  _id_D2366C783E31322D((3364, -2618, 300), 250, "Canals North", "Canals North 6");
  _id_D2366C783E31322D((2277, -3058, 300), 350, "Canals North", "Canals North 7");
  _id_D2366C783E31322D((1347, -3564, 300), 400, "Canals North", "Canals North 8");
  _id_D2366C783E31322D((824, -2910, 300), 350, "Canals North", "Canals North 9");
  _id_D2366C783E31322D((-11, -3197, 300), 300, "Canals North", "Canals North 10");
  _id_D2366C783E31322D((-8967, -8851, 300), 350, "Canals Southeast", "Canals Southeast 1");
  _id_D2366C783E31322D((-8378, -8498, 300), 350, "Canals Southeast", "Canals Southeast 2");
  _id_D2366C783E31322D((-7743, -8124, 300), 350, "Canals Southeast", "Canals Southeast 3");
  _id_D2366C783E31322D((-6975, -7677, 300), 300, "Canals Southeast", "Canals Southeast 4");
  _id_D2366C783E31322D((-6279, -7290, 300), 300, "Canals Southeast", "Canals Southeast 5");
  _id_D2366C783E31322D((-5767, -6906, 300), 300, "Canals Southeast", "Canals Southeast 6");
  _id_D2366C783E31322D((-5362, -5508, 300), 300, "Canals Southeast", "Canals Southeast 7");
  _id_D2366C783E31322D((-4230, -4590, 300), 450, "Canals Southeast", "Canals Southeast 8");
  _id_D2366C783E31322D((-3773, -3637, 300), 350, "Canals Southeast", "Canals Southeast 9");
  _id_D2366C783E31322D((-2984, -4402, 300), 350, "Canals Southeast", "Canals Southeast 10");
  _id_D2366C783E31322D((-3039, -3788, 300), 400, "Canals Southeast", "Canals Southeast 11");
  _id_D2366C783E31322D((-3944, 3488, 300), 250, "Canals West", "Canals West 1");
  _id_D2366C783E31322D((-3876, 2979, 300), 250, "Canals West", "Canals West 2");
  _id_D2366C783E31322D((-3746, 2434, 300), 250, "Canals West", "Canals West 3");
  _id_D2366C783E31322D((-3575, 1548, 300), 250, "Canals West", "Canals West 4");
  _id_D2366C783E31322D((-3099, 34, 300), 250, "Canals West", "Canals West 5");
  _id_D2366C783E31322D((-2795, -626, 300), 250, "Canals West", "Canals West 6");
  _id_D2366C783E31322D((-2399, -1507, 300), 250, "Canals West", "Canals West 7");
  _id_D2366C783E31322D((-1777, -2953, 300), 300, "Canals West", "Canals West 8");
}

_id_D2366C783E31322D(_id_254F9C6C23AD6894, _id_AE2730E7EECF1623, _id_EF2A503E8E869689, _id_8699FA5007AB6469) {
  locale = spawnStruct();
  locale.origin = _id_254F9C6C23AD6894;
  locale.radius = _id_AE2730E7EECF1623;
  locale.id = _id_EF2A503E8E869689;

  if(!isDefined(level._id_10C122E690A46014._id_ED1ABA8B380E1520[locale.id]))
    level._id_10C122E690A46014._id_ED1ABA8B380E1520[locale.id] = [];

  level._id_10C122E690A46014._id_ED1ABA8B380E1520[locale.id][level._id_10C122E690A46014._id_ED1ABA8B380E1520[locale.id].size] = locale;
}

_id_2830A5E3B7D37FB8() {
  _id_122570F942F8244A = int(min(level._id_10C122E690A46014._id_ED1ABA8B380E1520.size, level._id_10C122E690A46014._id_A61A1C33714D934F));

  if(_id_122570F942F8244A < level._id_10C122E690A46014._id_ED1ABA8B380E1520.size)
    level._id_10C122E690A46014._id_ED1ABA8B380E1520 = scripts\engine\utility::array_randomize_objects(level._id_10C122E690A46014._id_ED1ABA8B380E1520);

  foreach(_id_AC0E594AC96AA3A8, _id_28DC879FD3B05803 in level._id_10C122E690A46014._id_ED1ABA8B380E1520) {
    _id_28DC879FD3B05803 = scripts\engine\utility::array_randomize(_id_28DC879FD3B05803);
    _id_28DC879FD3B05803[0] thread _id_76F02EF1DA95F91B();
    _id_122570F942F8244A--;

    if(_id_122570F942F8244A == 0)
      return;
  }
}

_id_76F02EF1DA95F91B() {
  self._id_DEE9AFC0170A0F04 = 1;
  _id_58DF80BC53F9BC28 = randomint(360);
  _id_AE2730E7EECF1623 = randomint(self.radius - 250 + 1);
  _id_254F9C6C23AD6894 = self.origin + anglesToForward((0, _id_58DF80BC53F9BC28, 0)) * _id_AE2730E7EECF1623;
  self.scriptable = spawnscriptable("scriptable_sealion_sidequest_fishing", _id_254F9C6C23AD6894);
  self.scriptable._id_BA4D6E30B985AAEE = 1;
  self.scriptable._id_F93A6DAB8B32CD5D = self;

  if(!isDefined(level._id_10C122E690A46014._id_71D9FD7FFB3DE161))
    level._id_10C122E690A46014._id_71D9FD7FFB3DE161 = [];

  level._id_10C122E690A46014._id_71D9FD7FFB3DE161[level._id_10C122E690A46014._id_71D9FD7FFB3DE161.size] = self.scriptable;
}

_id_5305E60E5E259D77() {
  level._id_10C122E690A46014._id_ED1ABA8B380E1520 = scripts\engine\utility::array_randomize_objects(level._id_10C122E690A46014._id_ED1ABA8B380E1520);

  foreach(_id_28DC879FD3B05803 in level._id_10C122E690A46014._id_ED1ABA8B380E1520) {
    _id_DEE9AFC0170A0F04 = 0;

    foreach(_id_F93A6DAB8B32CD5D in _id_28DC879FD3B05803) {
      if(istrue(_id_F93A6DAB8B32CD5D._id_DEE9AFC0170A0F04))
        _id_DEE9AFC0170A0F04 = 1;
    }

    if(!_id_DEE9AFC0170A0F04) {
      _id_28DC879FD3B05803 = scripts\engine\utility::array_randomize(_id_28DC879FD3B05803);
      _id_28DC879FD3B05803[0] thread _id_76F02EF1DA95F91B();
      self._id_DEE9AFC0170A0F04 = 0;
      return;
    }
  }
}

_id_CFDA71453BAAE69D(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, _id_8BF74071A142B64C, modelindex, partname) {
  if(!istrue(instance._id_BA4D6E30B985AAEE)) {
    return;
  }
  if(idamage < 2) {
    return;
  }
  if(_id_8BF74071A142B64C[2] > 301) {
    return;
  }
  if(isPlayer(eattacker))
    eattacker _id_5762AC2F22202BA2::updatehitmarker("standard", 1, 0, 1, "hitequip");
  else if(isDefined(eattacker.owner) && isPlayer(eattacker.owner))
    eattacker.owner _id_5762AC2F22202BA2::updatehitmarker("standard", 1, 0, 1, "hitequip");

  if(isDefined(smeansofdeath) && smeansofdeath != "MOD_EXPLOSIVE_BULLET" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_PROJECTILE" && smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_EXPLOSIVE") {
    return;
  }
  if(!scripts\mp\flags::gameflag("prematch_fade_done")) {
    instance setscriptablepartstate("fishing_vfx", "disabled");
    return;
  }

  instance._id_F93A6DAB8B32CD5D thread _id_5305E60E5E259D77();
  level thread _id_376BE6A41E2DBE99(instance, eattacker);
}

_id_376BE6A41E2DBE99(node, player) {
  player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_299E800A2E86A20B");
  node setscriptablepartstate("fishing_vfx", "disabled");
  node._id_BA4D6E30B985AAEE = 0;
  wait 1;
  _id_239793E9AA66493E = randomintrange(level._id_10C122E690A46014._id_5B7A05D9D9969B00, level._id_10C122E690A46014._id_5B571BD9D97083AA + 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++) {
    _id_58DF80BC53F9BC28 = randomint(360);
    _id_AE2730E7EECF1623 = randomintrange(level._id_10C122E690A46014._id_58DD18A3C0D83313, level._id_10C122E690A46014._id_59002EA3C0FEAB2D + 1);
    _id_CCD641F9100F73F8 = node.origin + (0, 0, randomintrange(-50, -19)) + anglesToForward((0, _id_58DF80BC53F9BC28, 0)) * _id_AE2730E7EECF1623;
    _id_F619902B16773A61 = randomintrange(-10, 11);
    _id_CC0BEC21143E13D8 = randomint(360);
    _id_7AD2FA4AB913AE0E = randomint(360);

    if(_id_AC0E594AC96AA3A8 < _id_239793E9AA66493E) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_CCD641F9100F73F8, (_id_F619902B16773A61, _id_CC0BEC21143E13D8, _id_7AD2FA4AB913AE0E));
      _id_65920099D8CAF3B7 = _id_7E52B56769FA7774::spawnpickup("brloot_sealion_sidequest_fish", _id_CB4FAD49263E20C4);
      continue;
    }

    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_CCD641F9100F73F8, (0, _id_CC0BEC21143E13D8, 0));

    if(scripts\engine\utility::cointoss()) {
      _id_7E52B56769FA7774::spawnpickup("brloot_armor_plate", _id_CB4FAD49263E20C4);
      continue;
    }

    _id_92D8A509637FB29B = undefined;

    if(isDefined(player) && isPlayer(player)) {
      weapon = player getcurrentprimaryweapon();

      if(issubstr(weapon.basename, "_ar"))
        _id_92D8A509637FB29B = "brloot_ammo_762";
      else if(issubstr(weapon.basename, "_pi") || issubstr(weapon.basename, "_sm"))
        _id_92D8A509637FB29B = "brloot_ammo_919";
      else if(issubstr(weapon.basename, "_sh"))
        _id_92D8A509637FB29B = "brloot_ammo_12g";
      else if(issubstr(weapon.basename, "_sn") || issubstr(weapon.basename, "_dm"))
        _id_92D8A509637FB29B = "brloot_ammo_50cal";
      else {
        _id_2C878E7206CB78EA = ["brloot_ammo_762", "brloot_ammo_919", "brloot_ammo_12g", "brloot_ammo_50cal"];
        _id_92D8A509637FB29B = _id_2C878E7206CB78EA[randomint(_id_2C878E7206CB78EA.size)];
      }
    }

    _id_7E52B56769FA7774::spawnpickup(_id_92D8A509637FB29B, _id_CB4FAD49263E20C4);
  }

  waitframe();
  node freescriptable();
}