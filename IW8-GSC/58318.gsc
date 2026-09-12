/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58318.gsc
***********************************************/

function tut_bots_forcelaststand_onknock(var_0) {
  if(isDefined(level.isaxeweapon)) {
    return [[level.isaxeweapon]](var_0);
  }

  return 0;
}

function watchgrenadeaxepickup(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  jumpiffalse(!isDefined(self.weapon_name) && isDefined(var_1)) LOC_00000028;
  self.weapon_name = var_1;
  self waittill("missile_stuck", var_2, var_3);
  var_4 = 45;
  thread watchaxetimeout(var_4);
  thread watchgrenadedeath();

  if(!scripts\mp\flags::gameflag("prematch_fade_done")) {
    thread watchprematchend();
  }

  var_5 = self.weapon_object;
  thread watchaxeuse(var_0, var_5);
  thread watchaxeautopickup(var_0, var_5);
}

function watchaxetimeout(var_0) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(level.hostmigrationwait)) {
    [[level.hostmigrationwait]](var_0);
  }

  self delete();
}

function watchaxeautopickup(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  var_2 = spawn("trigger_radius", self.origin - (0, 0, 40), 0, 64, 64);
  var_2 enablelinkTo();
  var_2 linkTo(self);
  self.knife_trigger = var_2;
  var_2 endon("death");

  for(;;) {
    var_2 waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }

    if(!var_0 hasweapon(var_1)) {
      continue;
    }

    if(playercanautopickupaxe(var_0, self)) {
      playerpickupaxe(var_0, var_1, 1);
      self delete();
      break;
    }
  }
}

function watchaxeuse(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  var_2 = spawn("script_model", self.origin);
  var_2 linkTo(self);
  self.useobj_trigger = var_2;
  var_2 makeusable();
  var_2 setusefov(360);
  var_2 setuserange(64);
  var_2 setusepriority(0);
}

function watchprematchend() {
  self endon("death");
  level endon("game_ended");
  level waittill("prematch_fade_done");
  self delete();
}

function playercanautopickupaxe(var_0) {
  if(isDefined(var_0.owner) && self != var_0.owner) {
    return false;
  }

  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = self getweaponslistprimaries();

  foreach(var_6 in var_4) {
    if(tut_bots_forcelaststand_onknock(var_6)) {
      var_3 = 1;
    }

    if(issubstr(var_6.basename, "iw8_fists_mp")) {
      var_2 = 1;
    }

    if(!var_6.isalternate) {
      var_1++;
    }
  }

  var_8 = scripts\mp\gametypes\br_weapons::br_ammo_type_player_full(self, "brloot_ammo_rocket");

  if(var_3) {
    return !var_8;
  }

  if(var_2 || var_1 < 2) {
    return true;
  }

  return false;
}

function playerpickupaxe(var_0, var_1) {
  var_2 = var_0 getnoaltweapon();
  var_3 = self getcurrentweapon();
  var_4 = self getweaponslistprimaries();

  if(self hasweapon(var_0)) {
    var_5 = self getweaponammoclip(var_0);
    var_6 = self getweaponammostock(var_0);

    if(!var_1 && var_5 > 0) {
      self dropitem(var_0);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
    } else if(!issubstr(var_3.basename, var_0.basename)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
    }

    var_7 = self getweaponammoclip(var_3) == 0 && tut_bots_forcelaststand_onknock(var_3);
    var_8 = issubstr(var_3.basename, "iw8_fists_mp");

    if(!var_1 || var_8 || var_7) {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_2);
    }

    var_9 = 0;

    if(var_5 == 0) {
      self setweaponammoclip(var_2, 1);
      var_9 = 1;
    }

    if(var_9) {
      self setweaponammostock(var_2, var_6);
    } else {
      self setweaponammostock(var_2, var_6 + 1);
      scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, "brloot_ammo_rocket", 1, 0);
    }

    if(isDefined(level.long_death_manager)) {
      self[[level.long_death_manager]]("axe");
    }

    return;
  }

  var_10 = undefined;
  var_11 = 0;

  foreach(var_13 in var_9) {
    if(var_13.isalternate) {
      continue;
    }

    if(issubstr(var_13.basename, "uplinkball")) {
      continue;
    }

    var_14 = self getweaponammoclip(var_13) == 0 && tut_bots_forcelaststand_onknock(var_13);

    if(!isDefined(var_10) && (weaponispreferreddrop(var_13) || var_14)) {
      var_10 = var_13;
    }

    var_11++;
  }

  var_16 = undefined;

  if(isDefined(var_10)) {
    var_16 = var_10;
  } else if(var_11 >= 2) {
    var_16 = var_8;
  }

  var_17 = !var_6 || isDefined(var_16) && issubstr(var_8.basename, var_16.basename);

  if(isDefined(var_16)) {
    var_14 = self getweaponammoclip(var_16) == 0 && tut_bots_forcelaststand_onknock(var_16);
    var_18 = var_16.basename == "iw8_fists_mp";
    var_19 = weaponcandrop(var_16) && !var_14;

    if(var_19) {
      var_20 = self dropitem(var_16);

      if(isDefined(var_20)) {
        var_21 = createheadicon(var_16);

        if(isDefined(self.tookweaponfrom[var_21])) {
          var_20.owner = self.tookweaponfrom[var_21];
          self.tookweaponfrom[var_21] = undefined;
        } else {
          var_20.owner = self;
        }

        var_20.targetname = "dropped_weapon";
        var_20.objweapon = var_16;

        if(isDefined(level.watchweaponpickup)) {
          var_20 thread[[level.watchweaponpickup]]();
        }

        thread lastseentime();
      }
    } else if(!var_19 && !(var_18 && var_11 < 2) && !(var_14 && var_11 < 2)) {
      self takeweapon(var_16);
    }
  }

  var_22 = 0;

  if(isDefined(self) && isDefined(self.br_ammo["brloot_ammo_rocket"])) {
    var_22 = self.br_ammo["brloot_ammo_rocket"];
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_7);
  self setweaponammoclip(var_7, 1);

  if(var_17) {
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_7);
  }

  self setweaponammoclip(var_7, 1);
  self setweaponammostock(var_7, var_22);

  if(isDefined(level.long_death_manager)) {
    self[[level.long_death_manager]]("axe");
  }

  if(isDefined(level.fixupplayerweapons)) {
    [[level.fixupplayerweapons]](self, var_7);
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
    self waittill("grenade_fire", var_0, var_1, var_2, var_3);

    if(!scripts\mp\utility\weapon::grenadethrown(var_0)) {
      continue;
    }

    if(isDefined(level.grenadeinitialize)) {
      self[[level.grenadeinitialize]](var_0, var_1, var_2, var_3);
    }

    self notify("grenade_throw");
    return var_0;
  }
}