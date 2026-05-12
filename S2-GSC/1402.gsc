/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1402.gsc
*********************************************/

lib_057A::func_52A4() {
  lib_0561::initconsumablesfromtable("weapons", ::lib_057A::func_A249, ::lib_057A::func_1F8A, ::lib_057A::func_472E);
}

lib_057A::func_1F8A(param_00) {
  if(!lib_0561::func_1F7B()) {
    return 0;
  }

  if(!common_scripts\utility::func_0668()) {
    return 0;
  }

  if(!isDefined(self.var_4BA6) || !self.var_4BA6) {
    return 1;
  }

  if(isDefined(self.var_A9C1) && lib_057A::func_259B(param_00) == self.var_A9C1) {
    return 0;
  }

  return 1;
}

lib_057A::func_472E(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "";
  }

  switch (param_00) {
    case "epic":
      return 4;

    case "legendary":
      return 3;

    case "rare":
      return 2;

    case "common":
      return 1;

    default:
      return 0;
  }
}

lib_057A::func_A249(param_00) {
  self endon("disconnect");
  self endon("begin_last_stand");
  var_01 = self.var_259F[param_00].var_0109;
  lib_057A::func_259C(var_01);
  thread lib_057A::func_259E(var_01);
  level.var_400E[level.var_400E.size] = ["survivalist_set 3 -1", self];
  level.var_400E[level.var_400E.size] = ["survivalist_set 4 -1", self];
  self endon("weapon_consumable_used");
  childthread lib_057A::func_A9A6();
  var_02 = 0;
  var_03 = common_scripts\utility::func_A715("death", "weapon_consumable_timeout", "weapon_consumable_force_take");
  if(var_03 == "weapon_consumable_force_take") {
    var_02 = 1;
  }

  lib_057A::func_259D(var_02);
}

lib_057A::func_259E(param_00, param_01) {
  var_02 = consumable_getappendstring(param_00);
  if(!isDefined(param_01)) {
    param_01 = lib_057A::func_A9A8();
  }

  self setclientomnvar("ui_zm_" + var_02, gettime() + int(param_01 * 1000));
  thread maps\mp\gametypes\_hud_message::func_9102("zm_consumable_" + var_02);
  thread consumable_uisplash_kill(param_00, param_01);
}

consumable_uisplash_kill(param_00, param_01) {
  self endon("weapon_consumable_timeout");
  self endon("death");
  var_02 = consumable_getappendstring(param_00);
  if(isDefined(param_01)) {
    common_scripts\utility::func_A70D(param_01, self, "weapon_consumable_taken", self, "weapon_consumable_used");
  } else {
    common_scripts\utility::func_A70A("weapon_consumable_taken", "weapon_consumable_used");
  }

  self setclientomnvar("ui_zm_" + var_02, 0);
}

consumable_getappendstring(param_00) {
  switch (param_00) {
    case "consumable_zm_weapon_bazooka":
      return "bazooka";

    case "consumable_zm_weapon_panzerschreck":
      return "panzerschreck";

    case "consumable_zm_weapon_flamethrower":
      return "flamethrower";

    case "consumable_zm_weapon_ability":
      return "ability";

    case "consumable_zm_weapon_shield":
      return "shield";

    default:
      return "";
  }
}

lib_057A::func_259B(param_00) {
  if(!isDefined(param_00)) {
    return "";
  }

  switch (param_00) {
    case "consumable_zm_weapon_bazooka":
      return "bazooka_zm";

    case "consumable_zm_weapon_panzerschreck":
      return "panzerschreck_zm";

    case "consumable_zm_weapon_flamethrower":
      return "flamethrower_zm";

    default:
      return "";
  }
}

lib_057A::func_259C(param_00) {
  self method_8615("zmb_pickup_general");
  if(lib_057A::func_A260()) {
    if(isDefined(self.var_A9C1) && self hasweapon(self.var_A9C1)) {
      lib_0586::func_0790(self.var_A9C1);
      if(self.var_A9C1 == "flamethrower_zm") {
        self method_802E("npc_usa_flamethrower_backpack");
      }
    }

    self notify("weapon_consumable_used");
  } else {
    self.var_5B98 = self getcurrentprimaryweapon();
  }

  self.var_A9C1 = lib_057A::func_259B(param_00);
  self.var_4BA6 = 1;
  lib_0586::func_078C(self.var_A9C1);
  lib_0586::func_078E(self.var_A9C1);
  thread lib_054E::playeruseconsumableweapon();
  if(self.var_A9C1 == "flamethrower_zm") {
    self attach("npc_usa_flamethrower_backpack");
  }

  childthread lib_057A::func_A9B6();
  childthread weapon_switch_listener(self.var_A9C1);
}

lib_057A::func_259D(param_00) {
  if(!lib_057A::func_A260()) {
    return;
  }

  self.var_4BA6 = 0;
  if(common_scripts\utility::func_562E(param_00)) {
    self notify("weapon_consumable_taken");
  }

  var_01 = 0;
  var_02 = "";
  if((isDefined(self.var_5378) && self.var_5378) || param_00) {
    var_01 = 1;
  }

  if(!var_01) {
    if(isDefined(self.var_5B98) && self hasweapon(self.var_5B98)) {
      var_02 = self.var_5B98;
    } else {
      var_03 = self getweaponslistprimaries();
      foreach(var_05 in var_03) {
        if(!issubstr(var_05, "combatknife")) {
          var_02 = var_05;
          break;
        }
      }
    }

    lib_0586::func_078E(var_02);
    self.var_5B98 = undefined;
  }

  if(self hasweapon(self.var_A9C1)) {
    lib_0586::func_0790(self.var_A9C1);
  }

  if(self.var_A9C1 == "flamethrower_zm") {
    self method_802E("npc_usa_flamethrower_backpack");
  }

  self.var_A9C1 = undefined;
}

lib_057A::func_A260() {
  return isDefined(self.var_4BA6) && self.var_4BA6;
}

lib_057A::func_A9A6() {
  self endon("death");
  self endon("weapon_consumable_used");
  self endon("weapon_consumable_taken");
  var_00 = lib_057A::func_A9A8();
  wait(var_00);
  self notify("weapon_consumable_timeout");
}

weapon_switch_listener(param_00) {
  self endon("death");
  self endon("weapon_consumable_used");
  self endon("weapon_consumable_taken");
  self endon("weapon_consumable_force_take");
  for(;;) {
    self waittill("weapon_change", var_01);
    if(lib_0547::func_577E(self)) {
      return;
    }

    if(var_01 == param_00 || var_01 == "none") {
      continue;
    }

    if(lib_0547::func_5865(var_01)) {
      continue;
    }

    break;
  }

  self notify("weapon_consumable_force_take");
}

lib_057A::func_A9B6() {
  self endon("weapon_consumable_timeout");
  self endon("weapon_consumable_used");
  self endon("weapon_consumable_taken");
  self endon("death");
  var_00 = self.var_A9C1;
  for(;;) {
    self waittill("reload");
    var_01 = self getweaponammostock(var_00);
    if(var_01 == 0) {
      self setweaponammostock(var_00, 1);
    }
  }
}

lib_057A::func_A9A8() {
  return 30 + maps\mp\zombies\_zombies_perks::func_0633();
}