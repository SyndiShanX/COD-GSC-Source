/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1336.gsc
**************************************/

init() {
  _id_0586::_id_7BDB("Mad Minute", ::_id_7F42, ::_id_7F44);
  _id_0586::_id_7BDB("Mk. II", ::_id_7F43, ::_id_7F45);
  level._id_62B3["frag_skull_zm"] = ::_id_62AA;
  level._effect["zmb_death_mm_screen"] = loadfx("vfx/zombie/abilities_perks/zmb_death_mm_screen");
  level._effect["zmb_blood_ammo_up"] = loadfx("vfx/zombie/abilities_perks/zmb_blood_ammo_up");
  level._effect["zmb_blood_grenades_up"] = loadfx("vfx/zombie/abilities_perks/zmb_blood_grenades_up");
}

_id_3662() {
  _id_054B::_id_6AB2("role_ability_mad_minute_zm");
  self._id_5F5C = 1;
  var_0 = ["Mad Minute"];
  thread _id_0547::_id_73EC();
  _id_0547::_id_7458(1, "mad_minute");
  _playFXOnTag(level._effect["zmb_death_mm_screen"], self, "Tag_Origin");
  _id_0378::_id_8D74("aud_mad_minute_use");

  if(_id_0547::_id_4BA7("specialty_class_explosives_handler_zm")) {
    var_1 = 921600;

    foreach(var_3 in level.players) {
      var_4 = 0;

      if(var_3 == self) {
        var_4 = 1;
      } else if(distancesquared(self.origin, var_3.origin) < var_1) {
        var_4 = 1;
        var_3 _meth_866C(&"add_teammate_mod_buffs", 3, "specialty_class_explosives_handler_zm", 1, self);
      }

      if(var_4) {
        var_5 = var_3 getlethalweapon();

        if(isDefined(var_5)) {
          var_6 = var_3 getweaponammoclip(var_5);
          var_3 setweaponammoclip(var_5, var_6 + 2);
          _playFXOnTag(level._effect["zmb_blood_grenades_up"], var_3, "J_Hip_RI");
        }
      }
    }
  }

  if(_id_0547::_id_4BA7("specialty_class_ammo_carrier_zm")) {
    var_1 = 921600;

    foreach(var_3 in level.players) {
      if(var_3 == self) {
        continue;
      }
      if(distancesquared(self.origin, var_3.origin) < var_1) {
        var_9 = var_3 getcurrentprimaryweapon();

        if(!common_scripts\utility::_id_562E(level.nobonusammoreward[var_9])) {
          var_10 = _weaponclipsize(var_9);
          var_11 = var_3 getweaponammostock(var_9);
          var_3 setweaponammostock(var_9, var_11 + var_10);
          _playFXOnTag(level._effect["zmb_blood_ammo_up"], var_3, "TAG_WEAPON_RIGHT");
          var_3 _meth_866C(&"add_teammate_mod_buffs", 3, "specialty_class_ammo_carrier_zm", 1, self);
        }
      }
    }
  }

  if(_id_0547::_id_4BA7("specialty_class_squad_tactics_zm")) {
    var_1 = 921600;
    thread _id_0547::rangedperknotifyteammateui("specialty_class_squad_tactics_zm", var_1);
  }

  if(_id_0547::_id_4BA7("specialty_class_mk_ii_zm")) {
    var_0 = common_scripts\utility::_id_0F73(["Mk. II"], var_0);
  }

  _id_0586::_id_098F(var_0);
}

_id_2F9E() {
  if(common_scripts\utility::_id_562E(self._id_5F5C)) {
    _id_0547::_id_7458(0, "mad_minute");
    var_0 = ["Mad Minute"];

    if(_id_0547::_id_4BA7("specialty_class_mk_ii_zm")) {
      var_0[var_0.size] = "Mk. II";
    }

    _id_0586::_id_7CC9(var_0);
    self._id_5F5C = 0;
  }
}

_id_62A6(var_0, var_1, var_2) {
  var_3 = 1;

  if(isDefined(var_1._id_5F5C) && var_1._id_5F5C) {
    if(var_1 _id_0547::_id_4BA7("specialty_class_marksmanship_zm") && (var_2 == "head" || var_2 == "helmet")) {
      var_3 = var_3 * 3;
    }
  }

  var_4 = 921600;

  foreach(var_6 in level.players) {
    if(var_6 == var_1) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_6._id_5F5C) && var_6 _id_0547::_id_4BA7("specialty_class_squad_tactics_zm") && (var_2 == "head" || var_2 == "helmet") && distancesquared(var_1.origin, var_6.origin) < var_4) {
      var_3 = max(var_3, 1.5);
      break;
    }
  }

  if(isDefined(var_3)) {
    var_0 = var_0 * var_3;
  }

  return var_0;
}

_id_6BD4(var_0, var_1, var_2, var_3, var_4) {
  if(isPlayer(var_0) && var_0 _id_0547::_id_4BA7("specialty_class_frag_skull_zm")) {
    if(maps\mp\_utility::isbulletdamage(var_1) && (var_4 == "head" || var_4 == "helmet")) {
      var_5 = spawn("script_origin", var_3);
      var_5 _meth_8561("frag_skull_zm", var_0, var_5);
      wait 5;
      var_5 delete();
    }
  }
}

_id_62AA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(_isagent(var_0) && isalive(var_0)) {
    return var_0.maxhealth * 0.2;
  }
}

_id_0675(var_0) {
  return _id_056C::getattachmentforzombieweapon(var_0, "zmb_mad_minute");
}

_id_7F42(var_0) {
  var_1 = _id_0675(var_0.currentweapon);

  if(isDefined(var_1)) {
    var_0._id_0F20["Mad Minute"] = 1;
    var_2 = _func_3A5(var_0.currentweapon);
    var_2 = _id_0547::_id_0593(var_2, var_1);
    var_0.currentweapon = _id_0547::_id_062F(var_2);
  }
}

_id_7F44(var_0) {
  var_1 = _id_0675(var_0.currentweapon);

  if(isDefined(var_1)) {
    var_2 = _func_3A5(var_0.currentweapon);
    var_2 = _id_0547::_id_06AD(var_2, var_1);
    var_0.currentweapon = _id_0547::_id_062F(var_2);
    var_0._id_0F20["Mad Minute"] = undefined;
  }
}

_id_7F43(var_0) {
  var_1 = self;
  var_2 = _func_3A5(var_0.currentweapon);
  var_3 = var_1 _id_0586::_id_078B(var_2["weapon"]);

  if(isDefined(var_3)) {
    var_0._id_0F20["Mk. II"] = 1;
    var_4 = _func_3A5(var_3);
    var_0._id_6E35 = var_4;
    var_4 = _id_0547::_id_6117(var_4, var_2);
    var_0.currentweapon = _id_0547::_id_062F(var_4);
  }
}

_id_7F45(var_0) {
  if(common_scripts\utility::_id_562E(var_0._id_0F20["Mk. II"])) {
    var_1 = _func_3A5(var_0.currentweapon);
    var_2 = _func_3A5(var_0._id_6C57);

    foreach(var_5, var_4 in var_0._id_6E35) {
      var_1[var_5] = var_2[var_5];
    }

    var_0.currentweapon = _id_0547::_id_062F(var_1);
    var_0._id_6E35 = undefined;
    var_0._id_0F20["Mk. II"] = undefined;
  }
}