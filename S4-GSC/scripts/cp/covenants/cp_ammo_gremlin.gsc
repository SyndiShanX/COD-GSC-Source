/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\cp_ammo_gremlin.gsc
****************************************************/

init() {
  _id_0945::_id_C2B1("specialty_ammo_gremlin", ::set_ammo_gremlin, ::unset_ammo_gremlin);
  _id_0945::_id_C2B1("specialty_ammo_gremlin_current");
}

set_ammo_gremlin() {
  wait 0.1;

  if(scripts\cp\utility::_hasperk("specialty_ammo_gremlin_current")) {
    thread ammo_gremlin_replenish_ammo_primary();
  }

  thread ammo_gremlin_replenish_ammo();
  thread ammo_gremlin_swap_watcher();
}

unset_ammo_gremlin() {
  self notify("end_ammo_gremlin");
}

ammo_gremlin_swap_watcher() {
  self endon("disconnect");
  self endon("end_ammo_gremlin");
  self waittill("weapon_change", var_0);
  thread set_ammo_gremlin();
  self notify("end_ammo_gremlin");
}

ammo_gremlin_replenish_ammo() {
  self endon("disconnect");
  self endon("end_ammo_gremlin");

  for(;;) {
    var_0 = _id_0945::_id_664E("ammo_refill_from_stock_rate");
    var_1 = self._id_0132;
    var_2 = undefined;

    foreach(var_4 in self.primaryweapons) {
      if(var_1 != var_4 && !scripts\cp\utility::_id_88F6(var_4)) {
        var_2 = var_4;
      }
    }

    if(!isDefined(var_2) || var_2.basename == "none") {
      wait 0.1;
      continue;
    }

    var_6 = weaponclipsize(var_2);
    wait(var_0 / var_6);
    var_1 = self._id_0132;

    if(var_1 == var_2 || scripts\cp\utility::_id_88F6(var_1)) {
      continue;
    }
    if(!istrue(self._id_E3E5)) {
      if(!scripts\cp\utility::_id_88F6(var_2)) {
        var_7 = self getweaponammoclip(var_2);
        var_8 = self getweaponammostock(var_2);

        if(var_7 < var_2._id_00EB && var_8 > 0) {
          self setweaponammoclip(var_2, var_7 + 1);
          self setweaponammostock(var_2, var_8 - 1);
        }
      }
    }
  }
}

ammo_gremlin_replenish_ammo_primary() {
  self endon("disconnect");
  self endon("end_ammo_gremlin");

  for(;;) {
    var_0 = _id_0945::_id_664E("ammo_refill_from_stock_rate");
    var_1 = self._id_0132;
    var_2 = weaponclipsize(var_1);

    if(isnullweapon(var_1) || var_2 == 0) {
      wait 0.1;
      continue;
    }

    wait(var_0 / var_2);

    if(!istrue(self._id_E3E5)) {
      if(!scripts\cp\utility::_id_88F6(var_1)) {
        var_3 = self getweaponammoclip(var_1);
        var_4 = self getweaponammostock(var_1);

        if(var_3 < var_1._id_00EB && var_4 > 0) {
          self setweaponammoclip(var_1, var_3 + 1);
          self setweaponammostock(var_1, var_4 - 1);
        }
      }
    }
  }
}