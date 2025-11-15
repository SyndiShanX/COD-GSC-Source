/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2704.gsc
***************************************/

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

func_10D76(var_00) {
  self.powers["power_bulletstorm"].active = 1;
  scripts\engine\utility::allow_weapon_switch(0);
  self getnumberoffrozenticksfromwave(0);
  self getnumownedactiveagents(0);
  self allowdoublejump(0);
  self allowlean(0);
  self.func_3253 = spawnStruct();
  self.func_3253.func_4C15 = self getcurrentweapon();
  self.func_3253.func_DF66 = self getweaponammoclip(self.func_3253.func_4C15);
  self.func_3253.func_DF67 = self getweaponammostock(self.func_3253.func_4C15);
  scripts\mp\utility\game::_takeweapon(self.func_3253.func_4C15);
  var_01 = getcustomizationviewmodel(1);
  var_02 = self[[level.bulletstormshield[var_01].createfullscreenimage]](var_00);
  thread func_139BF(var_01, var_02);
  thread func_139BC();
  self.func_FC99 = 1;
}

func_139BF(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
}

func_139BC() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any("death", "disconnect");
  self.func_FC99 = undefined;
  self.func_3255 = undefined;
  self.func_3254 = undefined;
  self.func_3256 = undefined;
}

getcustomizationviewmodel(var_00) {
  var_01 = undefined;

  switch (var_00) {
    case 1:
      var_01 = "bubble";
      break;
    case 2:
      var_01 = "section";
      break;
  }

  return var_01;
}

func_498C(var_00) {
  var_01 = self.origin;
  var_02 = spawn("script_model", var_01);
  var_02 setModel(level.bulletstormshield["bubble"].friendlymodel);
  var_2.health = 999999;
  var_2.func_AC75 = 4;
  var_2.func_E749 = 720;
  var_2.func_11A33 = 0;
  var_2.func_4D63 = 250;
  var_2.func_28AF = "bulletstorm_device_mp";
  var_02 setCanDamage(1);
  var_02 hide();
  var_2.attachmentrollcount = [];

  if(isDefined(self.func_3255))
    var_2.func_AC75 = self.func_3255;

  if(isDefined(self.func_3254))
    var_2.health = self.func_3254;

  if(isDefined(self.func_3256))
    var_2.func_E749 = self.func_3256;

  var_03 = spawn("script_model", var_2.origin + (0, 0, 10));
  var_03 setModel("tag_origin");
  var_03 thread func_BD2E(self);
  var_03 thread func_13B3A(var_02);
  var_04 = spawn("script_model", var_01);
  var_04 setModel(level.bulletstormshield["bubble"].enemymodel);
  var_04 hide();
  var_04 thread func_BD2E(self);
  var_04 thread func_13B3A(var_02);
  var_02 thread func_BD2E(self);
  var_02 thread func_3259(self, var_03, var_04);
  func_10112(self, var_02, var_04);
  return var_02;
}

func_4A0F() {
  var_00 = self gettagorigin("j_mainroot");
  var_01 = spawn("script_model", var_00);
  var_01 setModel("tag_origin");
  var_01 thread func_BD2E(self);
  return var_01;
}

func_24AA(var_00, var_01) {
  var_2[0] = (50, 0, 10);
  var_2[1] = (0, 50, 10);
  var_2[2] = (-50, 0, 10);
  var_2[3] = (0, -50, 10);
  var_03 = 4;

  for(var_04 = 0; var_04 < var_03; var_4++) {
    var_05 = spawn("script_model", self.origin + (0, 0, 50));
    var_05 setModel(level.bulletstormshield["section"].friendlymodel);
    var_05 linkto(self, "tag_origin", var_2[var_04], (0, 90 * (var_04 + 1), 0));
    var_05 thread func_13B3A(var_01);
  }
}

func_BD2E(var_00) {
  var_00 endon("death");
  var_00 endon("disconnect");
  self endon("shield_lifetime_hit");

  for(;;) {
    scripts\engine\utility::waitframe();

    if(isDefined(self))
      self.origin = var_0.origin;
  }
}

func_3259(var_00, var_01, var_02) {
  self endon("stop_bulletstorm");
  thread func_139B8(var_00);
  thread func_13B61(var_00);
  thread func_139BA(var_00);
  thread func_139BE(var_00);
  var_03 = "hitbulletstorm";
  thread func_10A10(self.func_E749, 4, 1, 1);
  var_01 thread func_10A10(self.func_E749, 4, 1, 1);
  var_02 thread func_10A10(self.func_E749, 4, 1, 1);

  for(;;) {
    self waittill("damage", var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);
    playFX(scripts\engine\utility::getfx("bulletstorm_shield_hit"), var_07);
    playLoopSound(var_07, "bs_shield_impact");
    var_05 scripts\mp\damagefeedback::updatedamagefeedback(var_03);
  }
}

func_10112(var_00, var_01, var_02) {
  foreach(var_04 in level.players) {
    if(!isDefined(var_04)) {
      continue;
    }
    if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(var_04))
      var_04 func_12E6B(var_0.team, var_01, var_02);
  }
}

func_12E6B(var_00, var_01, var_02) {
  var_03 = undefined;

  if(self.team == var_00)
    var_03 = var_01;
  else
    var_03 = var_02;

  if(isDefined(var_03)) {
    var_03 giveperkequipment(self);
    thread func_139BD(var_00, var_03, var_01, var_02);
    thread func_139BB(var_00, var_03, var_01, var_02);
  }
}

func_139BD(var_00, var_01, var_02, var_03) {
  self endon("disconnect");
  level endon("game_ended");
  var_01 endon("death");
  self waittill("joined_team");
  var_01 hidefromplayer(self);
  scripts\engine\utility::waitframe();
  func_12E6B(var_00, var_02, var_03);
}

func_139BB(var_00, var_01, var_02, var_03) {}

func_139B8(var_00) {
  self endon("stop_bulletstorm");
  var_00 scripts\engine\utility::waittill_any("death", "disconnect");
  self notify("stop_bulletstorm", 1);
}

func_13B61(var_00) {
  self waittill("stop_bulletstorm", var_01);

  if(isDefined(var_00)) {
    var_02 = var_00 gettagorigin("j_mainroot");
    func_10D75(var_00, self.func_11A33, var_02, self.func_4D63);
    var_0.func_FC99 = undefined;
    var_00 setclientomnvar("ui_bulletstorm_update", -1);
    var_0.func_3255 = undefined;
    var_0.func_3254 = undefined;
    var_0.func_3256 = undefined;
    var_0.powers["power_bulletstorm"].active = 0;
    var_03 = -1;

    if(var_01)
      var_03 = 0;

    var_00 notify("powers_bulletstorm_update", var_03);
    var_00 scripts\engine\utility::allow_weapon_switch(1);
    var_00 getnumberoffrozenticksfromwave(1);
    var_00 getnumownedactiveagents(1);
    var_00 allowdoublejump(1);
    var_00 allowlean(1);
    var_04 = var_0.func_3253.func_4C15;
    var_05 = var_0.func_3253.func_DF66;
    var_06 = var_0.func_3253.func_DF67;
    var_00 giveweapon(var_04, 0, 0, 0, 1);
    var_00 setweaponammoclip(var_04, var_05);
    var_00 setweaponammostock(var_04, var_06);
    var_00 scripts\mp\utility\game::_switchtoweaponimmediate(var_04);
  }

  self delete();
}

func_139BE(var_00) {
  self endon("stop_bulletstorm");

  for(;;) {
    var_00 waittill("multi_use_activated", var_01);

    if(var_01 == "power_bulletstorm")
      self notify("stop_bulletstorm", 1);
  }
}

func_139BA(var_00) {
  self endon("stop_bulletstorm");
  var_01 = 0.25;

  for(;;) {
    if(self.func_AC75 >= 1)
      var_00 setclientomnvar("ui_bulletstorm_update", int(self.func_AC75));
    else
      break;

    wait 0.05;

    if(self.func_AC75 > 1) {
      self.func_AC75 = self.func_AC75 - 0.05;
      self notify("powers_bulletstorm_update", self.func_AC75 * var_01);
    }
  }

  self notify("shield_lifetime_hit");
  self notify("stop_bulletstorm", 1);
}

func_10D75(var_00, var_01, var_02, var_03) {
  if(var_01 > 0) {
    var_04 = getdvarint("scr_bulletstorm_explosion", 1);
    playFX(scripts\engine\utility::getfx("bulletstorm_explode"), var_02);
    playFX(scripts\engine\utility::getfx("bulletstorm_explode2"), var_02);

    if(var_04 == 1) {
      var_00 playlocalsound("bs_shield_explo");
      var_00 playSound("bs_shield_explo_npc");
    } else {
      var_00 playlocalsound("bs_shield_explo");
      var_00 playSound("bs_shield_explo_npc");
    }

    var_00 thread scripts\mp\shellshock::grenade_earthquake(undefined, 0);
    var_01 = int(clamp(var_01, 20, 150));
    var_03 = int(clamp(var_03, 50, 250));

    foreach(var_06 in level.players) {
      if(var_06 == var_00) {
        continue;
      }
      if(var_6.team == var_0.team) {
        continue;
      }
      var_07 = getcustomizationhead(var_04, var_02, var_03, var_00, var_06, var_01);

      if(var_7.func_38BF) {
        if(var_04 == 1) {
          if(var_7.func_4D70 >= var_6.health)
            var_6.customdeath = 1;

          var_06 getrandomarmkillstreak(var_7.func_4D70, var_02, var_00, self, "MOD_EXPLOSIVE");
          var_06 thread func_139B9(var_02, var_03, 1.0);
          continue;
        }

        var_00 notify("stun_hit");
        var_06 notify("concussed", var_00);
        var_06 shellshock("concussion_grenade_mp", var_7.func_5FE9);
        var_6.concussionendtime = gettime() + var_7.func_5FE9 * 1000;
        var_00 thread scripts\mp\damagefeedback::updatedamagefeedback("stun");
      }
    }
  }
}

func_13B3A(var_00) {
  level endon("game_ended");
  var_00 waittill("stop_bulletstorm");

  if(isDefined(self))
    self delete();
}

func_10A10(var_00, var_01, var_02, var_03, var_04) {
  self endon("death");

  if(isDefined(self))
    self rotateyaw(var_00, var_01, var_02, var_03);

  wait(var_01);
  thread func_10A10(var_00, var_01, var_02, var_03, var_04);
}

func_5116(var_00, var_01, var_02, var_03) {
  level endon("game_ended");
  wait(var_00);
  physicsexplosionsphere(var_01, var_02, var_02, var_03);
}

func_139B9(var_00, var_01, var_02) {
  self endon("disconnect");
  self waittill("start_instant_ragdoll", var_03, var_04);
  scripts\engine\utility::waitframe();
  physicsexplosionsphere(var_00, var_01 + 40, var_01 + 20, var_02);
}

func_5105(var_00, var_01) {
  level endon("game_ended");
  wait(var_00);

  if(isDefined(var_01))
    var_01 delete();
}

getcustomizationhead(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = spawnStruct();
  var_6.func_38BF = 0;
  var_6.func_4D70 = 0;
  var_6.func_5FE9 = 0;
  var_07 = distance(var_01, var_4.origin);

  if(var_07 <= var_02) {
    if(var_07 <= 50)
      var_6.func_38BF = 1;
    else {
      var_08 = [];
      var_8[var_8.size] = "physicscontents_solid";
      var_8[var_8.size] = "physicscontents_glass";
      var_8[var_8.size] = "physicscontents_vehicle";
      var_09 = physics_createcontents(var_08);
      var_10 = [];
      var_11 = physics_raycast(var_01, var_4.origin, var_09, var_10, 0, "physicsquery_any");

      if(!var_11)
        var_6.func_38BF = 1;
    }

    if(var_6.func_38BF) {
      if(var_00 == 1)
        var_6.func_4D70 = var_05 - var_05 / (var_02 / var_07);
      else {
        var_12 = 1 - var_07 / var_02;

        if(var_12 < 0)
          var_12 = 0;

        var_13 = 2 + 4 * var_12;
        var_6.func_5FE9 = scripts\mp\perks\perkfunctions::applystunresistence(var_03, var_04, var_13);
      }
    }
  }

  return var_06;
}