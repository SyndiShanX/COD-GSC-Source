/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bulletstorm.gsc
*********************************************/

func_3258() {
  level.bulletstormshield = [];
  level.bulletstormshield["bubble"] = spawnStruct();
  level.bulletstormshield["bubble"].createfullscreenimage = ::func_498C;
  level.bulletstormshield["bubble"].friendlymodel = "prop_mp_bulletstorm";
  level.bulletstormshield["bubble"].enemymodel = "prop_mp_bulletstorm_enemy";
  level.bulletstormshield["section"] = spawnStruct();
  level.bulletstormshield["section"].createfullscreenimage = ::func_4A0F;
  level.bulletstormshield["section"].friendlymodel = "prop_mp_bulletstorm_v3";
  level.bulletstormshield["section"].enemymodel = "prop_mp_bulletstorm_v3_enemy";
}

func_10D76(var_0) {
  self.powers["power_bulletstorm"].var_19 = 1;
  scripts\engine\utility::allow_weapon_switch(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowdoublejump(0);
  self allowlean(0);
  self.var_3253 = spawnStruct();
  self.var_3253.var_4C15 = self getcurrentweapon();
  self.var_3253.var_DF66 = self getweaponammoclip(self.var_3253.var_4C15);
  self.var_3253.var_DF67 = self getweaponammostock(self.var_3253.var_4C15);
  scripts\mp\utility::_takeweapon(self.var_3253.var_4C15);
  var_1 = getcustomizationviewmodel(1);
  var_2 = self[[level.bulletstormshield[var_1].createfullscreenimage]](var_0);
  thread func_139BF(var_1, var_2);
  thread func_139BC();
  self.var_FC99 = 1;
}

func_139BF(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
}

func_139BC() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("death", "disconnect");
  self.var_FC99 = undefined;
  self.var_3255 = undefined;
  self.var_3254 = undefined;
  self.var_3256 = undefined;
}

getcustomizationviewmodel(var_0) {
  var_1 = undefined;
  switch (var_0) {
    case 1:
      var_1 = "bubble";
      break;

    case 2:
      var_1 = "section";
      break;
  }

  return var_1;
}

func_498C(var_0) {
  var_1 = self.origin;
  var_2 = spawn("script_model", var_1);
  var_2 setModel(level.bulletstormshield["bubble"].friendlymodel);
  var_2.health = 999999;
  var_2.var_AC75 = 4;
  var_2.var_E749 = 720;
  var_2.var_11A33 = 0;
  var_2.var_4D63 = 250;
  var_2.var_28AF = "bulletstorm_device_mp";
  var_2 setCanDamage(1);
  var_2 hide();
  var_2.attachmentrollcount = [];
  if(isDefined(self.var_3255)) {
    var_2.var_AC75 = self.var_3255;
  }

  if(isDefined(self.var_3254)) {
    var_2.health = self.var_3254;
  }

  if(isDefined(self.var_3256)) {
    var_2.var_E749 = self.var_3256;
  }

  var_3 = spawn("script_model", var_2.origin + (0, 0, 10));
  var_3 setModel("tag_origin");
  var_3 thread func_BD2E(self);
  var_3 thread func_13B3A(var_2);
  var_4 = spawn("script_model", var_1);
  var_4 setModel(level.bulletstormshield["bubble"].enemymodel);
  var_4 hide();
  var_4 thread func_BD2E(self);
  var_4 thread func_13B3A(var_2);
  var_2 thread func_BD2E(self);
  var_2 thread func_3259(self, var_3, var_4);
  func_10112(self, var_2, var_4);
  return var_2;
}

func_4A0F() {
  var_0 = self gettagorigin("j_mainroot");
  var_1 = spawn("script_model", var_0);
  var_1 setModel("tag_origin");
  var_1 thread func_BD2E(self);
  return var_1;
}

func_24AA(var_0, var_1) {
  var_2[0] = (50, 0, 10);
  var_2[1] = (0, 50, 10);
  var_2[2] = (-50, 0, 10);
  var_2[3] = (0, -50, 10);
  var_3 = 4;
  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = spawn("script_model", self.origin + (0, 0, 50));
    var_5 setModel(level.bulletstormshield["section"].friendlymodel);
    var_5 linkto(self, "tag_origin", var_2[var_4], (0, 90 * var_4 + 1, 0));
    var_5 thread func_13B3A(var_1);
  }
}

func_BD2E(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  self endon("shield_lifetime_hit");
  for(;;) {
    scripts\engine\utility::waitframe();
    if(isDefined(self)) {
      self.origin = var_0.origin;
    }
  }
}

func_3259(var_0, var_1, var_2) {
  self endon("stop_bulletstorm");
  thread func_139B8(var_0);
  thread func_13B61(var_0);
  thread func_139BA(var_0);
  thread func_139BE(var_0);
  var_3 = "hitbulletstorm";
  thread func_10A10(self.var_E749, 4, 1, 1);
  var_1 thread func_10A10(self.var_E749, 4, 1, 1);
  var_2 thread func_10A10(self.var_E749, 4, 1, 1);
  for(;;) {
    self waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D);
    playFX(scripts\engine\utility::getfx("bulletstorm_shield_hit"), var_7);
    playsoundatpos(var_7, "bs_shield_impact");
    var_5 scripts\mp\damagefeedback::updatedamagefeedback(var_3);
  }
}

func_10112(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(var_4)) {
      var_4 func_12E6B(var_0.team, var_1, var_2);
    }
  }
}

func_12E6B(var_0, var_1, var_2) {
  var_3 = undefined;
  if(self.team == var_0) {
    var_3 = var_1;
  } else {
    var_3 = var_2;
  }

  if(isDefined(var_3)) {
    var_3 showtoplayer(self);
    thread func_139BD(var_0, var_3, var_1, var_2);
    thread func_139BB(var_0, var_3, var_1, var_2);
  }
}

func_139BD(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 endon("death");
  self waittill("joined_team");
  var_1 hidefromplayer(self);
  scripts\engine\utility::waitframe();
  func_12E6B(var_0, var_2, var_3);
}

func_139BB(var_0, var_1, var_2, var_3) {}

func_139B8(var_0) {
  self endon("stop_bulletstorm");
  var_0 scripts\engine\utility::waittill_any_3("death", "disconnect");
  self notify("stop_bulletstorm", 1);
}

func_13B61(var_0) {
  self waittill("stop_bulletstorm", var_1);
  if(isDefined(var_0)) {
    var_2 = var_0 gettagorigin("j_mainroot");
    func_10D75(var_0, self.var_11A33, var_2, self.var_4D63);
    var_0.var_FC99 = undefined;
    var_0 setclientomnvar("ui_bulletstorm_update", -1);
    var_0.var_3255 = undefined;
    var_0.var_3254 = undefined;
    var_0.var_3256 = undefined;
    var_0.powers["power_bulletstorm"].var_19 = 0;
    var_3 = -1;
    if(var_1) {
      var_3 = 0;
    }

    var_0 notify("powers_bulletstorm_update", var_3);
    var_0 scripts\engine\utility::allow_weapon_switch(1);
    var_0 allowcrouch(1);
    var_0 allowprone(1);
    var_0 allowdoublejump(1);
    var_0 allowlean(1);
    var_4 = var_0.var_3253.var_4C15;
    var_5 = var_0.var_3253.var_DF66;
    var_6 = var_0.var_3253.var_DF67;
    var_0 giveweapon(var_4, 0, 0, 0, 1);
    var_0 setweaponammoclip(var_4, var_5);
    var_0 setweaponammostock(var_4, var_6);
    var_0 scripts\mp\utility::_switchtoweaponimmediate(var_4);
  }

  self delete();
}

func_139BE(var_0) {
  self endon("stop_bulletstorm");
  for(;;) {
    var_0 waittill("multi_use_activated", var_1);
    if(var_1 == "power_bulletstorm") {
      self notify("stop_bulletstorm", 1);
    }
  }
}

func_139BA(var_0) {
  self endon("stop_bulletstorm");
  var_1 = 0.25;
  for(;;) {
    if(self.var_AC75 >= 1) {
      var_0 setclientomnvar("ui_bulletstorm_update", int(self.var_AC75));
    } else {
      break;
    }

    wait(0.05);
    if(self.var_AC75 > 1) {
      self.var_AC75 = self.var_AC75 - 0.05;
      self notify("powers_bulletstorm_update", self.var_AC75 * var_1);
    }
  }

  self notify("shield_lifetime_hit");
  self notify("stop_bulletstorm", 1);
}

func_10D75(var_0, var_1, var_2, var_3) {
  if(var_1 > 0) {
    var_4 = getdvarint("scr_bulletstorm_explosion", 1);
    playFX(scripts\engine\utility::getfx("bulletstorm_explode"), var_2);
    playFX(scripts\engine\utility::getfx("bulletstorm_explode2"), var_2);
    if(var_4 == 1) {
      var_0 playlocalsound("bs_shield_explo");
      var_0 playSound("bs_shield_explo_npc");
    } else {
      var_0 playlocalsound("bs_shield_explo");
      var_0 playSound("bs_shield_explo_npc");
    }

    var_0 thread scripts\mp\shellshock::grenade_earthquake(undefined, 0);
    var_1 = int(clamp(var_1, 20, 150));
    var_3 = int(clamp(var_3, 50, 250));
    foreach(var_6 in level.players) {
      if(var_6 == var_0) {
        continue;
      }

      if(var_6.team == var_0.team) {
        continue;
      }

      var_7 = getcustomizationhead(var_4, var_2, var_3, var_0, var_6, var_1);
      if(var_7.var_38BF) {
        if(var_4 == 1) {
          if(var_7.var_4D70 >= var_6.health) {
            var_6.customdeath = 1;
          }

          var_6 dodamage(var_7.var_4D70, var_2, var_0, self, "MOD_EXPLOSIVE");
          var_6 thread func_139B9(var_2, var_3, 1);
          continue;
        }

        var_0 notify("stun_hit");
        var_6 notify("concussed", var_0);
        var_6 shellshock("concussion_grenade_mp", var_7.var_5FE9);
        var_6.concussionendtime = gettime() + var_7.var_5FE9 * 1000;
        var_0 thread scripts\mp\damagefeedback::updatedamagefeedback("stun");
      }
    }
  }
}

func_13B3A(var_0) {
  level endon("game_ended");
  var_0 waittill("stop_bulletstorm");
  if(isDefined(self)) {
    self delete();
  }
}

func_10A10(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  if(isDefined(self)) {
    self rotateyaw(var_0, var_1, var_2, var_3);
  }

  wait(var_1);
  thread func_10A10(var_0, var_1, var_2, var_3, var_4);
}

func_5116(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  wait(var_0);
  physicsexplosionsphere(var_1, var_2, var_2, var_3);
}

func_139B9(var_0, var_1, var_2) {
  self endon("disconnect");
  self waittill("start_instant_ragdoll", var_3, var_4);
  scripts\engine\utility::waitframe();
  physicsexplosionsphere(var_0, var_1 + 40, var_1 + 20, var_2);
}

func_5105(var_0, var_1) {
  level endon("game_ended");
  wait(var_0);
  if(isDefined(var_1)) {
    var_1 delete();
  }
}

getcustomizationhead(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.var_38BF = 0;
  var_6.var_4D70 = 0;
  var_6.var_5FE9 = 0;
  var_7 = distance(var_1, var_4.origin);
  if(var_7 <= var_2) {
    if(var_7 <= 50) {
      var_6.var_38BF = 1;
    } else {
      var_8 = [];
      var_8[var_8.size] = "physicscontents_solid";
      var_8[var_8.size] = "physicscontents_glass";
      var_8[var_8.size] = "physicscontents_vehicle";
      var_9 = physics_createcontents(var_8);
      var_0A = [];
      var_0B = physics_raycast(var_1, var_4.origin, var_9, var_0A, 0, "physicsquery_any");
      if(!var_0B) {
        var_6.var_38BF = 1;
      }
    }

    if(var_6.var_38BF) {
      if(var_0 == 1) {
        var_6.var_4D70 = var_5 - var_5 / var_2 / var_7;
      } else {
        var_0C = 1 - var_7 / var_2;
        if(var_0C < 0) {
          var_0C = 0;
        }

        var_0D = 2 + 4 * var_0C;
        var_6.var_5FE9 = scripts\mp\perks\_perkfunctions::applystunresistence(var_3, var_4, var_0D);
      }
    }
  }

  return var_6;
}