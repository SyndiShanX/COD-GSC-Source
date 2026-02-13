/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2563.gsc
*************************************************/

_id_68F6() {
  return 0.2;
}

_id_68F7() {
  return 5;
}

_id_6A3B() {
  return 5;
}

_id_68F8(var_0) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    var_1 = 1;

    if(isDefined(self._id_2A0F) && self._id_2A0F == 3) {
      var_1 = 0.75;
    }

    if(var_0 == "equip_bandages") {
      return 5 * var_1;
    }

    return 5 * var_1;
  }

  return 5;
}

_id_FE29(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(self.health == self.maxhealth) {
    self iprintlnbold("Your health is full!");
    return;
  }

  var_2 = "bandage_mp";

  if(scripts\mp\utility\game::getgametype() == "br") {
    var_2 = "bandage_br_fake";
  }

  self disableweaponswitch();
  self allowfire(0);
  self _meth_852A(var_2);
  wait 0.25;
  self._id_21BE = 1;
  self._id_7647 = 0;
  _id_21BF(var_0);
  wait 0.25;

  if(self hasweapon(var_2)) {
    scripts\cp_mp\utility\inventory_utility::_id_6CF7(var_2);
  }

  self allowfire(1);
  self enableweaponswitch();
  var_1--;
  scripts\mp\equipment::_id_D545("health", var_1);
  self._id_21BE = 0;
  self._id_7647 = 1;
}

_id_21BF(var_0) {
  self endon("heal_end");
  self endon("death_or_disconnect");
  level endon("game_ended");
  thread scripts\mp\gametypes\br_public::_id_10B7A();
  thread scripts\mp\healthoverlay::_id_762D(var_0);
  wait(_id_68F8(var_0));
}

_id_FEAD(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(self._id_FF04)) {
    return;
  }
  if(istrue(self.inlaststand)) {
    self iprintlnbold("You need to be revived by an ally!");
    return;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_br_healer")) {
    self.health = clamp(self.health + 20, 0, self.maxhealth);
  }

  if(var_0 == "equip_armorplate") {
    _id_0A00::_id_FE25(var_0, var_1);
  } else if(var_0 != "equip_adrenalinebr") {
    _id_FE29(var_0, var_1);
  } else if(self.health < self.maxhealth) {
    var_1--;
    scripts\mp\equipment::_id_D545("health", var_1);

    if(scripts\mp\utility\game::getgametype() == "br") {
      self _meth_852A("adrenaline_br_fake");
      _id_09FC::_id_FE21();
      thread scripts\mp\healthoverlay::_id_762D(var_0);
    } else {
      self _meth_852A("s4_adrenaline_mp");
      _id_09FC::_id_FE21();
    }
  }

  if(scripts\mp\equipment::_id_6A15("health") == 0) {
    var_2 = -1;
    var_3 = 0;

    foreach(var_6, var_5 in self._id_2A62) {
      if(isDefined(var_5._id_CF22)) {
        if(var_5._id_CF22 == level._id_2A95._id_2A43[var_0]) {
          scripts\mp\equipment::_id_D545("health", var_5._id_011A);
          scripts\mp\gametypes\br_public::_id_C4D7(var_6);
          var_3 = 1;
          break;
        } else if(var_5._id_8B3D == "health")
          var_2 = var_6;
      }
    }

    if(!var_3 && var_2 >= 0) {
      scripts\mp\equipment::giveequipment(level._id_2A95._id_2A42[self._id_2A62[var_2]._id_CF22], "health");
      scripts\mp\equipment::_id_D545("health", self._id_2A62[var_2]._id_011A);
      self._id_2A62[var_2] = undefined;
    } else
      scripts\mp\equipment::_id_EDBD("health");
  }
}