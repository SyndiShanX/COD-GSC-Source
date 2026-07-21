/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58318.gsc
***********************************************/

tut_bots_forcelaststand_onknock(var_0) {
  if(isDefined(level.isaxeweapon))
    return [[level.isaxeweapon]](var_0);

  return 0;
}

watchgrenadeaxepickup(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(self.weapon_name) && isDefined(var_1))
    self.weapon_name = var_1;

  self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_2, var_3);
  var_4 = 45;
  thread watchaxetimeout(var_4);
  thread watchgrenadedeath();

  if(!scripts\mp\flags::gameflag("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F"))
    thread _encstr_83B21183360468437B4B434B1FE31EF8AD4D69();

  var_5 = self.weapon_object;
  thread watchaxeuse(var_0, var_5);
  thread watchaxeautopickup(var_0, var_5);
}

watchaxetimeout(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.hostmigrationwait))
    [[level.hostmigrationwait]](var_0);

  self delete();
}

watchaxeautopickup(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin - (0, 0, 40), 0, 64, 64);
  var_2 enablelinkTo();
  var_2 linkTo(self);
  self.knife_trigger = var_2;
  var_2 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_2 waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(!var_0 hasweapon(var_1)) {
      continue;
    }
    if(var_0 playercanautopickupaxe(self)) {
      var_0 playerpickupaxe(var_1, 1);
      self delete();
      break;
    }
  }
}

watchaxeuse(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_2 linkTo(self);
  self.useobj_trigger = var_2;
  var_2 makeusable();
  var_2 setusefov(360);
  var_2 setuserange(64);
  var_2 setusepriority(0);
}

_encstr_83B21183360468437B4B434B1FE31EF8AD4D69() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  self delete();
}

playercanautopickupaxe(var_0) {
  if(isDefined(var_0.owner) && self != var_0.owner)
    return 0;

  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = self getweaponslistprimaries();

  foreach(var_6 in var_4) {
    if(tut_bots_forcelaststand_onknock(var_6))
      var_3 = 1;

    if(issubstr(var_6.basename, "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C"))
      var_2 = 1;

    if(!var_6.isalternate)
      var_1++;
  }

  var_8 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_player_full(self, "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014");

  if(var_3)
    return !var_8;

  if(var_2 || var_1 < 2)
    return 1;

  return 0;
}

playerpickupaxe(var_0, var_1) {
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
    var_8 = issubstr(var_3.basename, "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");

    if(!var_1 || var_8 || var_7)
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_2);

    var_9 = 0;

    if(var_5 == 0) {
      self setweaponammoclip(var_2, 1);
      var_9 = 1;
    }

    if(var_9)
      self setweaponammostock(var_2, var_6);
    else {
      self setweaponammostock(var_2, var_6 + 1);
      _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_give_type(self, "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014", 1, 0);
    }

    if(isDefined(level.long_death_manager))
      self[[level.long_death_manager]]("_encstr_961904BF105A");

    return;
  }

  var_10 = undefined;
  var_11 = 0;

  foreach(var_13 in var_4) {
    if(var_13.isalternate) {
      continue;
    }
    if(issubstr(var_13.basename, "_encstr_8F300B35924A5B48EBF37808D3")) {
      continue;
    }
    var_14 = self getweaponammoclip(var_13) == 0 && tut_bots_forcelaststand_onknock(var_13);

    if(!isDefined(var_10) && (weaponispreferreddrop(var_13) || var_14))
      var_10 = var_13;

    var_11++;
  }

  var_16 = undefined;

  if(isDefined(var_10))
    var_16 = var_10;
  else if(var_11 >= 2)
    var_16 = var_3;

  var_17 = !var_1 || isDefined(var_16) && issubstr(var_3.basename, var_16.basename);

  if(isDefined(var_16)) {
    var_14 = self getweaponammoclip(var_16) == 0 && tut_bots_forcelaststand_onknock(var_16);
    var_18 = var_16.basename == "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";
    var_19 = weaponcandrop(var_16) && !var_14;

    if(var_19) {
      var_20 = self dropitem(var_16);

      if(isDefined(var_20)) {
        var_21 = createheadicon(var_16);

        if(isDefined(self.tookweaponfrom[var_21])) {
          var_20.owner = self.tookweaponfrom[var_21];
          self.tookweaponfrom[var_21] = undefined;
        } else
          var_20.owner = self;

        var_20.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
        var_20.objweapon = var_16;

        if(isDefined(level.watchweaponpickup))
          var_20 thread[[level.watchweaponpickup]]();

        var_20 thread lastseentime();
      }
    } else if(!var_19 && !(var_18 && var_11 < 2) && !(var_14 && var_11 < 2))
      self takeweapon(var_16);
  }

  var_22 = 0;

  if(isDefined(self) && isDefined(self.br_ammo["_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"]))
    var_22 = self.br_ammo["_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"];

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
  self setweaponammoclip(var_2, 1);

  if(var_17)
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_2);

  self setweaponammoclip(var_2, 1);
  self setweaponammostock(var_2, var_22);

  if(isDefined(level.long_death_manager))
    self[[level.long_death_manager]]("_encstr_961904BF105A");

  if(isDefined(level.fixupplayerweapons))
    [[level.fixupplayerweapons]](self, var_2);
}

lastseentime() {
  self endon("_encstr_AD75063D571AE108");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

watchgrenadedeath() {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.knife_trigger))
    self.knife_trigger delete();

  if(isDefined(self.useobj_trigger))
    self.useobj_trigger delete();
}

waittill_grenade_throw() {
  for(;;) {
    self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_0, var_1, var_2, var_3);

    if(!scripts\mp\utility\weapon::grenadethrown(var_0)) {
      continue;
    }
    if(isDefined(level.grenadeinitialize))
      self[[level.grenadeinitialize]](var_0, var_1, var_2, var_3);

    self notify("_encstr_97E30EEC9359DC0B19ACBE47D027BDDD");
    return var_0;
  }
}