/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1336.gsc
*********************************************/

lib_0538::func_00D5() {
  lib_0586::func_7BDB("Mad Minute", ::lib_0538::func_7F42, ::lib_0538::func_7F44);
  lib_0586::func_7BDB("Mk. II", ::lib_0538::func_7F43, ::lib_0538::func_7F45);
  level.var_62B3["frag_skull_zm"] = ::lib_0538::func_62AA;
  level.var_0611["zmb_death_mm_screen"] = loadfx("vfx/zombie/abilities_perks\zmb_death_mm_screen");
  level.var_0611["zmb_blood_ammo_up"] = loadfx("vfx/zombie/abilities_perks\zmb_blood_ammo_up");
  level.var_0611["zmb_blood_grenades_up"] = loadfx("vfx/zombie/abilities_perks\zmb_blood_grenades_up");
}

lib_0538::func_3662() {
  maps\mp\zombies\_zombies_roles::func_6AB2("role_ability_mad_minute_zm");
  self.var_5F5C = 1;
  var_00 = ["Mad Minute"];
  thread lib_0547::func_73EC();
  lib_0547::func_7458(1, "mad_minute");
  playFXOnTag(level.var_0611["zmb_death_mm_screen"], self, "Tag_Origin");
  lib_0378::func_8D74("aud_mad_minute_use");
  if(lib_0547::func_4BA7("specialty_class_explosives_handler_zm")) {
    var_01 = 921600;
    foreach(var_03 in level.var_744A) {
      var_04 = 0;
      if(var_03 == self) {
        var_04 = 1;
      } else if(distancesquared(self.var_0116, var_03.var_0116) < var_01) {
        var_04 = 1;
        var_03 luinotifyeventextraplayer(&"add_teammate_mod_buffs", 3, "specialty_class_explosives_handler_zm", 1, self);
      }

      if(var_04) {
        var_05 = var_03 method_834A();
        if(isDefined(var_05)) {
          var_06 = var_03 getweaponammoclip(var_05);
          var_03 method_82FA(var_05, var_06 + 2);
          playFXOnTag(level.var_0611["zmb_blood_grenades_up"], var_03, "J_Hip_RI");
        }
      }
    }
  }

  if(lib_0547::func_4BA7("specialty_class_ammo_carrier_zm")) {
    var_01 = 921600;
    foreach(var_08 in level.var_744A) {
      if(var_08 == self) {
        continue;
      }

      if(distancesquared(self.var_0116, var_08.var_0116) < var_04) {
        var_09 = var_08 getcurrentprimaryweapon();
        if(!common_scripts\utility::func_562E(level.nobonusammoreward[var_09])) {
          var_0A = weaponclipsize(var_09);
          var_0B = var_08 getweaponammostock(var_09);
          var_08 setweaponammostock(var_09, var_0B + var_0A);
          playFXOnTag(level.var_0611["zmb_blood_ammo_up"], var_08, "TAG_WEAPON_RIGHT");
          var_08 luinotifyeventextraplayer(&"add_teammate_mod_buffs", 3, "specialty_class_ammo_carrier_zm", 1, self);
        }
      }
    }
  }

  if(lib_0547::func_4BA7("specialty_class_squad_tactics_zm")) {
    var_01 = 921600;
    thread lib_0547::rangedperknotifyteammateui("specialty_class_squad_tactics_zm", var_07);
  }

  if(lib_0547::func_4BA7("specialty_class_mk_ii_zm")) {
    var_07 = common_scripts\utility::func_0F73(["Mk. II"], var_07);
  }

  lib_0586::func_098F(var_07);
}

lib_0538::func_2F9E() {
  if(common_scripts\utility::func_562E(self.var_5F5C)) {
    lib_0547::func_7458(0, "mad_minute");
    var_00 = ["Mad Minute"];
    if(lib_0547::func_4BA7("specialty_class_mk_ii_zm")) {
      var_00[var_00.size] = "Mk. II";
    }

    lib_0586::func_7CC9(var_00);
    self.var_5F5C = 0;
  }
}

lib_0538::func_62A6(param_00, param_01, param_02) {
  var_03 = 1;
  if(isDefined(param_01.var_5F5C) && param_01.var_5F5C) {
    if(param_01 lib_0547::func_4BA7("specialty_class_marksmanship_zm") && param_02 == "head" || param_02 == "helmet") {
      var_03 = var_03 * 3;
    }
  }

  var_04 = 921600;
  foreach(var_06 in level.var_744A) {
    if(var_06 == param_01) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_06.var_5F5C) && var_06 lib_0547::func_4BA7("specialty_class_squad_tactics_zm") && (param_02 == "head" || param_02 == "helmet") && distancesquared(param_01.var_0116, var_06.var_0116) < var_04) {
      var_03 = max(var_03, 1.5);
      break;
    }
  }

  if(isDefined(var_03)) {
    param_00 = param_00 * var_03;
  }

  return param_00;
}

lib_0538::func_6BD4(param_00, param_01, param_02, param_03, param_04) {
  if(isPlayer(param_00) && param_00 lib_0547::func_4BA7("specialty_class_frag_skull_zm")) {
    if(maps\mp\_utility::func_5694(param_01) && param_04 == "head" || param_04 == "helmet") {
      var_05 = spawn("script_origin", param_03);
      var_05 detonateusingweapon("frag_skull_zm", param_00, var_05);
      wait(5);
      var_05 delete();
    }
  }
}

lib_0538::func_62AA(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(function_01EF(param_00) && isalive(param_00)) {
    return param_00.var_00FB * 0.2;
  }
}

lib_0538::func_0675(param_00) {
  return lib_056C::getattachmentforzombieweapon(param_00, "zmb_mad_minute");
}

lib_0538::func_7F42(param_00) {
  var_01 = lib_0538::func_0675(param_00.var_2953);
  if(isDefined(var_01)) {
    param_00.var_0F20["Mad Minute"] = 1;
    var_02 = function_03A5(param_00.var_2953);
    var_02 = lib_0547::func_0593(var_02, var_01);
    param_00.var_2953 = lib_0547::func_062F(var_02);
  }
}

lib_0538::func_7F44(param_00) {
  var_01 = lib_0538::func_0675(param_00.var_2953);
  if(isDefined(var_01)) {
    var_02 = function_03A5(param_00.var_2953);
    var_02 = lib_0547::func_06AD(var_02, var_01);
    param_00.var_2953 = lib_0547::func_062F(var_02);
    param_00.var_0F20["Mad Minute"] = undefined;
  }
}

lib_0538::func_7F43(param_00) {
  var_01 = self;
  var_02 = function_03A5(param_00.var_2953);
  var_03 = var_01 lib_0586::func_078B(var_02["weapon"]);
  if(isDefined(var_03)) {
    param_00.var_0F20["Mk. II"] = 1;
    var_04 = function_03A5(var_03);
    param_00.var_6E35 = var_04;
    var_04 = lib_0547::func_6117(var_04, var_02);
    param_00.var_2953 = lib_0547::func_062F(var_04);
  }
}

lib_0538::func_7F45(param_00) {
  if(common_scripts\utility::func_562E(param_00.var_0F20["Mk. II"])) {
    var_01 = function_03A5(param_00.var_2953);
    var_02 = function_03A5(param_00.var_6C57);
    foreach(var_05, var_04 in param_00.var_6E35) {
      var_01[var_05] = var_02[var_05];
    }

    param_00.var_2953 = lib_0547::func_062F(var_01);
    param_00.var_6E35 = undefined;
    param_00.var_0F20["Mk. II"] = undefined;
  }
}