/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1335.gsc
*********************************************/

lib_0537::func_00D5() {
  self.var_569F = 0;
  level.var_0611["zmb_moon_zmb_blind"] = loadfx("vfx/zombie/abilities_perks\zmb_moon_zmb_blind");
  level.var_0611["zmb_moon_player_camo_cam"] = loadfx("vfx/zombie/abilities_perks\zmb_moon_player_camo_cam");
  level.var_0611["zmb_moon_player_camo_wv"] = loadfx("vfx/zombie/abilities_perks\zmb_moon_player_camo_wv");
  level.var_0611["zmb_moon_speed_up"] = loadfx("vfx/zombie/abilities_perks\zmb_moon_speed_up");
}

lib_0537::func_3662() {
  maps\mp\zombies\_zombies_roles::func_6AB2("role_ability_camo_zm");
  self.var_569F = 1;
  lib_0547::func_8A6D(1);
  if(!isDefined(level.custom_camo_func_on)) {
    self visionsetnakedforplayer("zm_camo", 0.25);
  } else {
    self[[level.custom_camo_func_on]]();
  }

  playfxontagforclients(level.var_0611["zmb_moon_player_camo_cam"], self, "Tag_Origin", self);
  lib_0378::func_8D74("aud_camo_use");
  thread lib_0537::func_17BB();
  thread camoplayerfx();
  lib_0547::func_7ACD();
  if(lib_0547::func_4BA7("specialty_class_survivalist_zm")) {
    var_00 = lib_0547::func_73E9() + 1;
    lib_0547::func_7454(int(min(var_00, 3)));
  }

  thread powerlosswhenfiring();
}

camoplayerfx() {
  if(lib_0547::func_4BA7("specialty_class_mobilization_zm")) {
    var_00 = spawnlinkedfx(level.var_0611["zmb_moon_speed_up"], self, "J_Knee_LE");
    var_01 = spawnlinkedfx(level.var_0611["zmb_moon_speed_up"], self, "J_Knee_RI");
    triggerfx(var_00);
    triggerfx(var_01);
    common_scripts\utility::func_A70A("camo_ended", "disconnect");
    var_00 delete();
    var_01 delete();
  }
}

lib_0537::func_17BB() {
  self endon("camo_ended");
  while(self.var_569F) {
    foreach(var_01 in lib_0547::func_408F()) {
      if(!isDefined(var_01.var_5689) || var_01.var_5689 == 0) {
        playfxontagforclients(level.var_0611["zmb_moon_zmb_blind"], var_01, "J_Head", self);
        var_01.var_5689 = 1;
      }
    }

    wait(0.4);
  }
}

lib_0537::func_2F9E() {
  if(common_scripts\utility::func_562E(self.var_569F)) {
    self.var_569F = 0;
    self notify("camo_ended");
    foreach(var_01 in lib_0547::func_408F()) {
      var_01.var_5689 = 0;
    }

    foreach(var_01 in lib_0547::func_408F()) {
      stopFXOnTag(level.var_0611["zmb_moon_zmb_blind"], var_01, "J_Head");
    }

    lib_0547::func_8A6D(0);
    if(!isDefined(level.custom_camo_func_off)) {
      self visionsetnakedforplayer("", 0.25);
    } else {
      self[[level.custom_camo_func_off]]();
    }

    lib_0547::func_7ACD();
  }
}

lib_0537::func_62A6(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 0;
  if(isDefined(param_01)) {
    var_05 = common_scripts\utility::func_562E(param_01.var_3BE1);
  } else {
    var_05 = common_scripts\utility::func_562E(param_02.var_569F);
  }

  if(var_05) {
    if(lib_0547::func_5863(param_04) && param_02 lib_0547::func_4BA7("specialty_class_saboteur_zm")) {
      var_06 = maps\mp\zombies\_zombies_perks::func_466B(param_04);
      param_00 = param_00 * var_06;
      param_02 luinotifyeventextraplayer(&"trigger_mod_proc", 1, "specialty_class_saboteur_zm");
    }
  }

  return param_00;
}

lib_0537::func_6ADC(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(param_01)) {
    var_0A = 0;
    if(isDefined(param_00) && param_00 != param_01) {
      var_0A = common_scripts\utility::func_562E(param_00.var_3BE1);
    } else {
      var_0A = common_scripts\utility::func_562E(param_01.var_569F);
    }

    if(var_0A) {
      if(maps\mp\_utility::func_5755(param_04) && isPlayer(param_01) && param_01 lib_0547::func_4BA7("specialty_class_serrated_edge_zm")) {
        param_01 thread lib_0537::func_83F1(self);
        param_01 luinotifyeventextraplayer(&"trigger_mod_proc", 1, "specialty_class_serrated_edge_zm");
      }

      if(isPlayer(param_01)) {
        if(!0 || maps\mp\_utility::func_4571() == "mp_zombie_island") {
          if(!0 || isDefined(self.var_0A4B) && self.var_0A4B == "zombie_assassin") {
            var_0B = 0 - param_02 * 0 - 0;
            param_01 lib_0533::func_0F37(var_0B, 0, 1);
            return;
          }

          return;
        }

        return;
      }
    }
  }
}

lib_0537::func_6B7E(param_00) {
  if(!isPlayer(self)) {
    return;
  }

  if(isPlayer(param_00) && common_scripts\utility::func_562E(param_00.var_569F) && param_00 lib_0547::func_4BA7("specialty_class_covert_exfiltration_zm")) {
    thread lib_0537::func_3F91(param_00);
  }
}

lib_0537::func_3F91(param_00) {
  self endon("disconnect");
  lib_0547::func_8A6D(1);
  self luinotifyeventextraplayer(&"add_teammate_mod_buffs", 3, "specialty_class_covert_exfiltration_zm", 0, param_00);
  param_00 luinotifyeventextraplayer(&"trigger_mod_proc", 1, "specialty_class_covert_exfiltration_zm");
  common_scripts\utility::func_A71A(5, "death", "enter_last_stand");
  self luinotifyeventextraplayer(&"remove_teammate_mod_buffs", 1, "specialty_class_covert_exfiltration_zm");
  lib_0547::func_8A6D(0);
}

lib_0537::func_83F1(param_00) {
  var_01 = "serratedEdgeApplied" + self getentitynumber();
  var_02 = "serratedEdgeExpired" + self getentitynumber();
  param_00 notify(var_01);
  param_00 endon(var_02);
  param_00 endon(var_01);
  var_03 = param_00.var_83F1;
  if(!isDefined(var_03)) {
    var_03 = spawnlinkedfx(common_scripts\utility::func_44F5("serrated_edge_bleed"), param_00, "J_Spine4");
    triggerfx(var_03);
    param_00.var_83F1 = var_03;
    param_00.var_83F2 = [];
  }

  if(!common_scripts\utility::func_0F79(param_00.var_83F2, self)) {
    param_00.var_83F2[param_00.var_83F2.size] = self;
  }

  var_04 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_generic"), level.var_A980);
  var_05 = var_04 * 0.03;
  param_00 childthread lib_0547::func_AC38(param_00, var_05, self, 1.5, 30, "dot_generic_zm");
  param_00 common_scripts\utility::func_A74B("death", 30);
  var_06 = 0;
  if(isDefined(param_00.var_83F2)) {
    param_00.var_83F2 = common_scripts\utility::func_0F93(param_00.var_83F2, self);
    var_06 = param_00.var_83F2.size == 0;
  } else if(isDefined(var_03) && !function_0279(var_03)) {
    var_06 = 1;
  }

  if(var_06) {
    var_03 delete();
  }

  param_00 notify(var_02);
}

powerlosswhenfiring() {
  if(!0 || maps\mp\_utility::func_4571() == "mp_zombie_island") {
    self endon("death");
    self endon("disconnect");
    self endon("camo_ended");
    for(;;) {
      self waittill("weapon_fired", var_00);
      var_01 = lib_0547::func_9475(var_00);
      if(!issubstr(var_01, "pap")) {
        var_01 = var_01 + "_mp";
      }

      var_02 = getzombieweaponclass(var_01);
      var_03 = -0.1;
      switch (var_02) {
        case "weapon_assault":
          if(issubstr(var_00, "m1a1_zm") || issubstr(var_00, "svt40_zm") || issubstr(var_00, "garand") || issubstr(var_00, "g43") || issubstr(var_00, "type5")) {
            var_03 = -0.1;
          } else {
            var_03 = -0.06;
          }
          break;

        case "weapon_lmg":
          var_03 = -0.06;
          break;

        case "weapon_smg":
          var_03 = -0.04;
          break;

        case "weapon_shotgun":
          if(issubstr(var_00, "walther")) {
            var_03 = -0.1;
          } else {
            var_03 = -0.2;
          }
          break;

        case "weapon_sniper":
          if(issubstr(var_00, "karabin")) {
            var_03 = -0.1;
          } else {
            var_03 = -0.2;
          }
          break;

        case "weapon_heavy":
          var_03 = -0.06;
          break;

        case "weapon_pistol":
          var_03 = -0.1;
          break;

        case "other":
          var_03 = -0.1;
          break;
      }

      if(!lib_0547::func_5565(self.rentingability, "role_ability_camo_zm")) {
        lib_0533::func_0F37(var_03, 0, 1);
      }
    }
  }
}

getzombieweaponclass(param_00) {
  var_01 = maps\mp\_utility::func_4431(param_00);
  var_02 = level.zombieweaponclass[var_01];
  if(isDefined(var_02)) {
    return var_02;
  }

  var_02 = tablelookup("mp/statstable.csv", 2, var_01, 0);
  if(var_02 == "") {
    var_02 = tablelookup("mp/statstable.csv", 2, param_00, 0);
  } else if(param_00 == "none") {
    var_02 = "other";
  } else if(var_02 == "") {
    var_02 = "other";
  }

  if(isDefined(var_02)) {
    level.zombieweaponclass[var_01] = var_02;
  }

  return var_02;
}