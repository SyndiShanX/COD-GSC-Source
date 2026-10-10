/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\supers\super_suppression_rounds.gsc
*************************************************************/

#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\supers;
#using scripts\mp\supers\super_stoppingpower;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace super_suppression_rounds;

function function_d0930f871341093c() {
  level.onweapondropcreated callback_subscribe(&function_7da2a2f573cf8d9, level);
  level.onweapondroppickedup callback_subscribe(&function_afc54fc21dfdc776, level);
}

function suppressionrounds_beginuse() {
  playerweaponobj = self.lastnormalweaponobj;
  var_8de014639f689574 = nullweapon();

  if(scripts\mp\utility\weapon::ismeleeonly(playerweaponobj) || scripts\mp\utility\weapon::issuperweapon(playerweaponobj) || scripts\cp_mp\weapon::iskillstreakweapon(playerweaponobj) || scripts\mp\utility\weapon::isgamemodeweapon(playerweaponobj) || scripts\mp\utility\weapon::issinglehitweapon(playerweaponobj.basename) || scripts\cp_mp\weapon::isminigunweapon(playerweaponobj) || !function_a364b6e4dc3cc30a(playerweaponobj) || playerweaponobj.basename == "iw8_lm_dblmg_mp" || playerweaponobj.basename == "iw9_me_fists_mp" || playerweaponobj.basename == "jup_jp23_me_spear_mp") {
    if(scripts\engine\utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\engine\utility::getsharedfunc("hud", "showErrorMessage")]]("MP/SUPPORT_BOX_INCOMPAT");
    }

    return false;
  }

  result = scripts\mp\supers\super_stoppingpower::stoppingpower_cancelreload();

  if(!istrue(result)) {
    return false;
  }

  function_ed3c1a651b014773(playerweaponobj);

  setdevdvarifuninitialized(@ "hash_cf7e828b80157a7e", 0);
  setdevdvarifuninitialized(@ "hash_e99f272dcc64b03c", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_c3573be192cb700f", 0.7);

  scripts\cp_mp\challenges::function_d997435895422ecc("super_suppression_rounds", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "equipment_deployed");
  return true;
}

function function_b2d2056ee8b00689() {}

function function_a364b6e4dc3cc30a(objweapon) {
  if(!self isalternatemode(objweapon)) {
    return 1;
  }

  underbarrel = objweapon.underbarrel;
  return scripts\mp\weapons::isattachmentselectfire(objweapon, underbarrel);
}

function function_ed3c1a651b014773(playerweaponobj) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(self isalternatemode(playerweaponobj)) {
    var_8de014639f689574 = playerweaponobj;
    playerweaponobj = playerweaponobj getnoaltweapon();
  } else {
    var_8de014639f689574 = playerweaponobj getaltweapon();
  }

  var_12a372e8caa042bb = [];
  stockammo = 0;
  var_c88113bfedd68cf0 = 0;

  if(!isnullweapon(var_8de014639f689574)) {
    var_12a372e8caa042bb[var_12a372e8caa042bb.size] = var_8de014639f689574;
  }

  var_12a372e8caa042bb[var_12a372e8caa042bb.size] = playerweaponobj;

  foreach(weaponobj in var_12a372e8caa042bb) {
    isakimbo = 0;

    if(weaponobj.isdualwield) {
      isakimbo = 1;
    }

    if(issameweapon(weaponobj, playerweaponobj, 0)) {
      clipammo = scripts\mp\weapons::getammooverride(weaponobj);
      var_fb3893b4cbddc190 = clipammo * 2;

      if(isakimbo) {
        var_fb3893b4cbddc190 *= 2;
      }

      function_588eaa2556c4172c(self, weaponobj, var_fb3893b4cbddc190);

      if(true) {
        if(isakimbo) {
          clipammo = self getweaponammoclip(weaponobj, "left") + self getweaponammoclip(weaponobj, "right");
          stockammo = self getweaponammostock(weaponobj);
          oldammo = clipammo + stockammo;
          newammo = int(min(weaponmaxammo(weaponobj), oldammo + var_fb3893b4cbddc190));
          self setweaponammostock(weaponobj, newammo);
          self setweaponammoclip(weaponobj, 0, "left");
          self setweaponammoclip(weaponobj, 0, "right");
          continue;
        }

        clipammo = self getweaponammoclip(weaponobj);
        stockammo = self getweaponammostock(weaponobj);
        oldammo = clipammo + stockammo;
        maxammo = weaponmaxammo(weaponobj);
        totalammo = oldammo + var_fb3893b4cbddc190;
        var_c88113bfedd68cf0 = int(totalammo - maxammo);
        newstockammo = int(min(maxammo, totalammo));

        if(weaponobj.basename == "iw8_lm_dblmg_mp") {
          self setweaponammoclip(weaponobj, clipammo + var_fb3893b4cbddc190);
          continue;
        }

        self setweaponammoclip(weaponobj, 0);

        if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
          stockdifference = newstockammo - stockammo;
          scripts\mp\gametypes\br_weapons::br_give_weapon_ammo(weaponobj, stockdifference);
          continue;
        }

        self setweaponammostock(weaponobj, newstockammo);
      }
    }
  }

  thread function_3c8a31ca9d26e8a3(playerweaponobj, stockammo, var_c88113bfedd68cf0);
  return true;
}

function function_3c8a31ca9d26e8a3(weaponobj, stockammo, var_c88113bfedd68cf0) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(true) {
    if(self getcurrentprimaryweapon() != weaponobj) {
      break;
    }

    currentammo = self getweaponammoclip(weaponobj);

    if(currentammo > 0) {
      thread scripts\mp\hud_message::showsplash("suppression_rounds_activated", undefined, self);

      if(var_c88113bfedd68cf0 > 0) {
        self setweaponammostock(weaponobj, stockammo + var_c88113bfedd68cf0);
      }

      break;
    }

    waitframe();
  }

  if(scripts\engine\utility::issharedfuncdefined("supers", "superUseFinished")) {
    [[scripts\engine\utility::getsharedfunc("supers", "superUseFinished")]]();
  }
}

function function_588eaa2556c4172c(player, objweapon, numrounds) {
  var_2468893fc27de6f6 = spawnStruct();
  var_2468893fc27de6f6.player = player;
  var_2468893fc27de6f6.objweapon = objweapon;
  var_2468893fc27de6f6.rounds = numrounds;
  var_2468893fc27de6f6.var_6d8006af92216f09 = 0;
  var_2468893fc27de6f6.kills = 0;
  function_404622faff469ef4(player, var_2468893fc27de6f6);
}

function function_2ab57ffd17e456dc() {
  perkarray = self.var_96a36c88eb0e59b;

  foreach(perk in perkarray) {
    giveperk(perk);
  }
}

function function_d086a58c4a276ab7() {
  perkarray = self.var_96a36c88eb0e59b;

  foreach(perk in perkarray) {
    if(_hasperk(perk)) {
      removeperk(perk);
    }
  }
}

function function_78a297c602bcf14b() {
  perkarray = self.var_96a36c88eb0e59b;

  if(!isDefined(perkarray)) {
    return 0;
  }

  var_c81d87c234523f81 = 1;

  foreach(perk in perkarray) {
    if(!_hasperk(perk)) {
      var_c81d87c234523f81 = 0;
      break;
    }
  }

  return var_c81d87c234523f81;
}

function function_404622faff469ef4(player, var_2468893fc27de6f6) {
  if(!isDefined(player.var_2468893fc27de6f6)) {
    player.var_2468893fc27de6f6 = [];
  }

  if(!isDefined(player.var_96a36c88eb0e59b)) {
    player.var_96a36c88eb0e59b = ["specialty_bulletsuppress", "specialty_bulletpenetration", "specialty_armorpiercingks", "specialty_fastreload"];
  }

  id = getcompleteweaponnamenoalt(var_2468893fc27de6f6.objweapon);
  var_42d837d1bf3797d3 = player.var_2468893fc27de6f6[id];

  if(isDefined(var_42d837d1bf3797d3)) {
    var_42d837d1bf3797d3 thread suppressionrounds_removeapr();
  }

  player.var_2468893fc27de6f6[id] = var_2468893fc27de6f6;
  var_2468893fc27de6f6 thread function_ff064ef6be86cafd();
  var_2468893fc27de6f6 thread function_b62388feecc84e15();
  var_2468893fc27de6f6 thread function_3228d2697dab3222();
  var_2468893fc27de6f6 thread function_6831e37d3d71c426();
  var_2468893fc27de6f6 thread function_f12640f75796066();
  player thread function_1a941c69ee952e0d();
}

function function_1da49fb6441f8ab2() {
  var_2468893fc27de6f6 = function_8343403d68c45f63(self getcurrentweapon());
  return isDefined(var_2468893fc27de6f6) && istrue(var_2468893fc27de6f6.var_6d8006af92216f09);
}

function function_7da2a2f573cf8d9(weaponentity, droppingplayer, weaponobj) {
  if(!isDefined(weaponentity) || !isDefined(droppingplayer)) {
    return;
  }

  var_2468893fc27de6f6 = droppingplayer function_8343403d68c45f63(weaponobj);
  weaponentity.var_2468893fc27de6f6 = var_2468893fc27de6f6;
}

function function_afc54fc21dfdc776(weaponentity, var_480f8576be141bb4, weaponobj) {
  if(!isDefined(weaponentity.var_2468893fc27de6f6)) {
    return;
  }

  var_2468893fc27de6f6 = weaponentity.var_2468893fc27de6f6;
  var_2468893fc27de6f6.player = var_480f8576be141bb4;
  var_2468893fc27de6f6.var_6d8006af92216f09 = 0;
  var_2468893fc27de6f6.kills = 0;
  function_404622faff469ef4(var_480f8576be141bb4, var_2468893fc27de6f6);
}

function function_8343403d68c45f63(objweapon) {
  if(!isDefined(objweapon)) {
    return undefined;
  }

  if(!isDefined(self.var_2468893fc27de6f6)) {
    return undefined;
  }

  id = getcompleteweaponnamenoalt(objweapon);
  return self.var_2468893fc27de6f6[id];
}

function function_6831e37d3d71c426() {
  self endon("suppressionRounds_removeAPR");
  self.player endon("disconnect");

  while(self.player hasweapon(self.objweapon)) {
    if(function_8e06333f166199e3(self.player getcurrentweapon())) {
      if(!self.var_6d8006af92216f09) {
        self.player function_2ab57ffd17e456dc();
        self.var_6d8006af92216f09 = 1;
      }
    } else if(self.var_6d8006af92216f09) {
      self.player function_d086a58c4a276ab7();
      self.var_6d8006af92216f09 = 0;
    }

    self.player waittill("weapon_change");
  }

  thread suppressionrounds_removeapr();
}

function function_f12640f75796066() {
  self endon("suppressionRounds_removeAPR");
  self.player endon("disconnect");

  while(self.player hasweapon(self.objweapon)) {
    self.player waittill("weapon_fired", objweapon);

    if(function_8e06333f166199e3(objweapon)) {
      self.rounds--;

      if(self.rounds <= 0) {
        break;
      }
    }
  }

  self.player thread function_15338821a605345d(self.objweapon);
  thread suppressionrounds_removeapr();
}

function function_15338821a605345d(objweapon) {
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }

  rootname = getweaponrootname(objweapon);

  if(rootname != "iw9_dm_crossbow") {
    return;
  }

  self.lastcrossbowhadstoppingpower = 1;
  waittill_any_timeout_no_endon_death_2(2, "weapon_fired", "weapon_change");
  self.lastcrossbowhadstoppingpower = undefined;
}

function suppressionrounds_removeapr() {
  self notify("suppressionRounds_removeAPR");

  if(isDefined(self.player)) {
    if(self.var_6d8006af92216f09) {
      self.player function_d086a58c4a276ab7();
    }

    function_14ff80858876e74();
  }
}

function function_860d63c693c454f5() {
  self notify("suppressionRounds_removeAPR");

  if(isDefined(self.player)) {
    function_14ff80858876e74();
  }
}

function function_14ff80858876e74() {
  if(isDefined(self.player.var_2468893fc27de6f6)) {
    id = getcompleteweaponnamenoalt(self.objweapon);
    var_2468893fc27de6f6 = self.player.var_2468893fc27de6f6[id];

    if(isDefined(var_2468893fc27de6f6) && var_2468893fc27de6f6 == self) {
      self.player.var_2468893fc27de6f6[id] = undefined;
    }

    if(isDefined(self.player.super) && isDefined(self.player.super.vehiclehitcount)) {
      self.player scripts\cp_mp\challenges::function_d997435895422ecc("super_suppression_rounds", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"end"), self.player.super.vehiclehitcount);
      self.player.super.vehiclehitcount = undefined;
    }

    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.player, level.superglobals.staticsuperdata["super_suppression_rounds"].id, self.kills, 0);
  }
}

function function_8f9a9c04e9e4b5af(weaponobj) {
  if(isDefined(weaponobj)) {
    id = getcompleteweaponnamenoalt(weaponobj);
    var_2468893fc27de6f6 = self.var_2468893fc27de6f6[id];

    if(isDefined(var_2468893fc27de6f6)) {
      scripts\mp\utility\stats::incpersstat("suppressionRoundsKills", 1);
      scripts\mp\supers::combatrecordsuperkill("super_suppression_rounds");
      var_2468893fc27de6f6.kills++;
    }
  }
}

function function_8e06333f166199e3(objweapon) {
  var_c1711fe638727118 = self.player getammotype(self.objweapon);
  currentammotype = self.player getammotype(objweapon);
  var_9438d6b1d63250f7 = var_c1711fe638727118 == currentammotype;
  return issameweapon(objweapon, self.objweapon, 1) && var_9438d6b1d63250f7;
}

function function_ff064ef6be86cafd() {
  self.player endon("disconnect");
  self endon("suppressionRounds_removeAPR");
  self.player waittill("death");
  thread suppressionrounds_removeapr();
}

function function_b62388feecc84e15() {
  self.player endon("disconnect");
  self endon("suppressionRounds_removeAPR");
  level waittill("game_ended");
  thread suppressionrounds_removeapr();
}

function function_3228d2697dab3222() {
  self.player endon("disconnect");
  self endon("suppressionRounds_removeAPR");
  self.player waittill("all_perks_cleared");
  thread function_860d63c693c454f5();
}

function function_8f57fb80f166c568() {
  self.player endon("death_or_disconnect");
  self.player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  self.player waittill_any_3("weapon_fired", "weapon_change", "suppressionRounds_removeAPR");
  self.player scripts\mp\utility\perk::removeperk("specialty_fastreload");
}

function function_1a941c69ee952e0d() {
  self endon("death_or_disconnect");
  val::set("suppressionRounds", "sprint", 0);
  wait 0.4;
  val::reset_all("suppressionRounds");
}