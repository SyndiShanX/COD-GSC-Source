/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58318.gsc
***********************************************/

function tut_bots_forcelaststand_onknock(var0) {
  if(isDefined(level.isaxeweapon)) {
    return [[level.isaxeweapon]](var0);
  }

  return 0;
}

function watchgrenadeaxepickup(var0, var1) {
  self endon("death");
  level endon("game_ended");
  jumpiffalse(!isDefined(self.weapon_name) && isDefined(var1)) LOC_00000028;
  self.weapon_name = var1;
  self waittill("missile_stuck", var2, var3);
  var4 = 45;
  thread watchaxetimeout(var4);
  thread watchgrenadedeath();

  if(!scripts\mp\flags::gameflag("prematch_fade_done")) {
    thread watchprematchend();
  }

  var5 = self.weapon_object;
  thread watchaxeuse(var0, var5);
  thread watchaxeautopickup(var0, var5);
}

function watchaxetimeout(var0) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(level.hostmigrationwait)) {
    [[level.hostmigrationwait]](var0);
  }

  self delete();
}

function watchaxeautopickup(var0, var1) {
  self endon("death");
  level endon("game_ended");
  var2 = spawn("trigger_radius", self.origin - (0, 0, 40), 0, 64, 64);
  var2 enablelinkTo();
  var2 linkTo(self);
  self.knife_trigger = var2;
  var2 endon("death");

  for(;;) {
    var2 waittill("trigger", var0);

    if(!isPlayer(var0)) {
      continue;
    }

    if(!var0 hasweapon(var1)) {
      continue;
    }

    if(playercanautopickupaxe(var0, self)) {
      playerpickupaxe(var0, var1, 1);
      self delete();
      break;
    }
  }
}

function watchaxeuse(var0, var1) {
  self endon("death");
  level endon("game_ended");
  var2 = spawn("script_model", self.origin);
  var2 linkTo(self);
  self.useobj_trigger = var2;
  var2 makeusable();
  var2 setusefov(360);
  var2 setuserange(64);
  var2 setusepriority(0);
}

function watchprematchend() {
  self endon("death");
  level endon("game_ended");
  level waittill("prematch_fade_done");
  self delete();
}

function playercanautopickupaxe(var0) {
  if(isDefined(var0.owner) && self != var0.owner) {
    return false;
  }

  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = self getweaponslistprimaries();

  foreach(var6 in var4) {
    if(tut_bots_forcelaststand_onknock(var6)) {
      var3 = 1;
    }

    if(issubstr(var6.basename, "iw8_fists_mp")) {
      var2 = 1;
    }

    if(!var6.isalternate) {
      var1++;
    }
  }

  var8 = scripts\mp\gametypes\br_weapons::br_ammo_type_player_full(self, "brloot_ammo_rocket");

  if(var3) {
    return !var8;
  }

  if(var2 || var1 < 2) {
    return true;
  }

  return false;
}

function playerpickupaxe(var0, var1) {
  var2 = var0 getnoaltweapon();
  var3 = self getcurrentweapon();
  var4 = self getweaponslistprimaries();

  if(self hasweapon(var0)) {
    var5 = self getweaponammoclip(var0);
    var6 = self getweaponammostock(var0);

    if(!var1 && var5 > 0) {
      self dropitem(var0);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var2);
    } else if(!issubstr(var3.basename, var0.basename)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var2);
    }

    var7 = self getweaponammoclip(var3) == 0 && tut_bots_forcelaststand_onknock(var3);
    var8 = issubstr(var3.basename, "iw8_fists_mp");

    if(!var1 || var8 || var7) {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var2);
    }

    var9 = 0;

    if(var5 == 0) {
      self setweaponammoclip(var2, 1);
      var9 = 1;
    }

    if(var9) {
      self setweaponammostock(var2, var6);
    } else {
      self setweaponammostock(var2, var6 + 1);
      scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, "brloot_ammo_rocket", 1, 0);
    }

    if(isDefined(level.long_death_manager)) {
      self[[level.long_death_manager]]("axe");
    }

    return;
  }

  var10 = undefined;
  var11 = 0;

  foreach(var13 in var9) {
    if(var13.isalternate) {
      continue;
    }

    if(issubstr(var13.basename, "uplinkball")) {
      continue;
    }

    var14 = self getweaponammoclip(var13) == 0 && tut_bots_forcelaststand_onknock(var13);

    if(!isDefined(var10) && (weaponispreferreddrop(var13) || var14)) {
      var10 = var13;
    }

    var11++;
  }

  var16 = undefined;

  if(isDefined(var10)) {
    var16 = var10;
  } else if(var11 >= 2) {
    var16 = var8;
  }

  var17 = !var6 || isDefined(var16) && issubstr(var8.basename, var16.basename);

  if(isDefined(var16)) {
    var14 = self getweaponammoclip(var16) == 0 && tut_bots_forcelaststand_onknock(var16);
    var18 = var16.basename == "iw8_fists_mp";
    var19 = weaponcandrop(var16) && !var14;

    if(var19) {
      var20 = self dropitem(var16);

      if(isDefined(var20)) {
        var21 = createheadicon(var16);

        if(isDefined(self.tookweaponfrom[var21])) {
          var20.owner = self.tookweaponfrom[var21];
          self.tookweaponfrom[var21] = undefined;
        } else {
          var20.owner = self;
        }

        var20.targetname = "dropped_weapon";
        var20.objweapon = var16;

        if(isDefined(level.watchweaponpickup)) {
          var20 thread[[level.watchweaponpickup]]();
        }

        thread lastseentime();
      }
    } else if(!var19 && !(var18 && var11 < 2) && !(var14 && var11 < 2)) {
      self takeweapon(var16);
    }
  }

  var22 = 0;

  if(isDefined(self) && isDefined(self.br_ammo["brloot_ammo_rocket"])) {
    var22 = self.br_ammo["brloot_ammo_rocket"];
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var7);
  self setweaponammoclip(var7, 1);

  if(var17) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var7);
  }

  self setweaponammoclip(var7, 1);
  self setweaponammostock(var7, var22);

  if(isDefined(level.long_death_manager)) {
    self[[level.long_death_manager]]("axe");
  }

  if(isDefined(level.fixupplayerweapons)) {
    [[level.fixupplayerweapons]](self, var7);
    return;
  }
}

function lastseentime() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }

  self delete();
}

function watchgrenadedeath() {
  self waittill("death");

  if(isDefined(self.knife_trigger)) {
    self.knife_trigger delete();
  }

  if(isDefined(self.useobj_trigger)) {
    self.useobj_trigger delete();
    return;
  }
}

function waittill_grenade_throw() {
  for(;;) {
    self waittill("grenade_fire", var0, var1, var2, var3);

    if(!scripts\mp\utility\weapon::grenadethrown(var0)) {
      continue;
    }

    if(isDefined(level.grenadeinitialize)) {
      self[[level.grenadeinitialize]](var0, var1, var2, var3);
    }

    self notify("grenade_throw");
    return var0;
  }
}