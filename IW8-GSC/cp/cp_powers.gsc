/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_powers.gsc
***********************************************/

init() {
  level.powers = [];
  level.powersetfuncs = [];
  level.powerunsetfuncs = [];
  level.powerweaponmap = [];
  level.disablepowerfunc = ::power_disablepower;
  level.enablepowerfunc = ::power_enablepower;
  level.power_adjustcharges = ::power_adjustcharges;
  level.power_clearpower = ::zm_powershud_clearpower;
  level.power_haspower = ::haspower;
  level.clearpowers = ::clearpowers;
  level.power_modifycooldownrate = ::power_modifycooldownrate;
  scripts\cp\equipment\cp_trophy_system::trophy_init();
  level._effect["_encstr_B62C10F7C6BF18211D2DA79583E330C7B8DD"] = loadfx("_encstr_8BF32C134081A5CF8B437727F511F3EDA7207BEBB8177D7B414B3F2D131B4B057F90A372789F271319B8463624E2");
  level._effect["_encstr_82E219729EC75047CB5F9FA710DAE84FC8EDDE97B328052ED8B0AF"] = loadfx("_encstr_A5BE31538C0BAFCC6390871B1B73C71D46677308B2AF82A35499775020D8686F59FECA3F61B71083455030BFE00311FEB4CFC0");
  thread scripts\cp_mp\powershud::powershud_init();
  powerparsetable();

  if(isDefined(level.power_setup_init))
    level[[level.power_setup_init]]();
  else {
    powersetupfunctions("_encstr_8D7C09102FE7216D71A66D", undefined, undefined, undefined, "_encstr_B6E80AE6BBC14D331DEBF38F", undefined, undefined);
    powersetupfunctions("_encstr_B81D0C38EDBB56C9F599B12CDC34", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("_encstr_BACB0A1025606A1BF9E0105C", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("_encstr_848510DBC7AC4262F129A5ADEDF9AADA857B", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("_encstr_85690DDBA0378F1B267EA5D695EB7F", undefined, undefined, scripts\cp\cp_weapon_autosentry::give_crafted_sentry, undefined, undefined, undefined);
    powersetupfunctions("_encstr_87CB0E0B177C92B2411875BD7030E71B", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("_encstr_ABE813B8E843EAD21733C8EF4C832F8BBB8581C741", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("_encstr_8E910FA7E764B78317A2C973305A28B33B", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("_encstr_A2210C0B6FD3AA184FC7B0CD1A8B", undefined, ::takecover, ::givecover, undefined, undefined, undefined);
    powersetupfunctions("_encstr_A22A16E07BEE5693EB9B732C83B934EDE83AE4B2E658C895", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("_encstr_A5B00F4AB8E8356BE8A99BA7CDA9827CD0", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("_encstr_A78210CAB8D5A507FAA198F5CD2BCDE6BD93", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("_encstr_A19214DD0F1B17B217308AD2C0436D1733FD2E43A843", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("_encstr_820F114AE740032B7F8680CAD930B1D239F212", undefined, undefined, undefined, undefined, undefined, undefined);
    powersetupfunctions("_encstr_8B0E0CAC5CAB4B38FA46566CBDF2", undefined, undefined, undefined, undefined, undefined, undefined);
    thread scripts\cp\cp_weapon_autosentry::init();
  }

  if(!isDefined(level.cosine)) {
    level.cosine = [];
    level.cosine["_encstr_810703AF78"] = cos(90);
    level.cosine["_encstr_8807037320"] = cos(89);
    level.cosine["_encstr_960703127A"] = cos(45);
    level.cosine["_encstr_A30703C216"] = cos(25);
    level.cosine["_encstr_8607036335"] = cos(15);
    level.cosine["_encstr_AF0703133A"] = cos(10);
    level.cosine["_encstr_B84C027E"] = cos(5);
  }

  level setupovercookfuncs();
  scripts\engine\utility::flag_init("_encstr_96C411F3881FB7238B70B1BE7333CFBF47F82A");
  scripts\engine\utility::flag_set("_encstr_96C411F3881FB7238B70B1BE7333CFBF47F82A");
}

setupovercookfuncs() {
  level.overcook_func["_encstr_8C4A10BA936F7F31D0159D6ECB304757814B"] = ::fraggrenadeovercookfunc;
}

fraggrenadeovercookfunc(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = "_encstr_81580B52FF3F7F3D195A6A61A7";
  var_0 endon("_encstr_BD590F4338AF67F3DE164D4DA0C397EF57" + var_2);

  if(!isDefined(var_1) || var_1 != "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B") {
    return;
  }
  if(!var_0 haspower(var_2)) {
    return;
  }
  var_3 = var_0.origin;
  playFX(level._effect["_encstr_82E219729EC75047CB5F9FA710DAE84FC8EDDE97B328052ED8B0AF"], var_3);
  playsoundatpos(var_3, "_encstr_AF36183D3BE24401679AA1D8464C18901ABB89A1F7DB96C8B632");

  if(!isDefined(var_0.powers[var_2])) {
    return;
  }
  var_0 power_adjustcharges(var_0.powers[var_2].charges - 1, var_0.powers[var_2].slot, 1);
  var_0 power_updateammo(var_2);
  var_0 radiusdamage(var_3, 256, 150, 100, var_0, "_encstr_911B0C7DA090E9A7F799FD50DD48", "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B");
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_3);
  earthquake(0.5, 0.75, var_3, 800);

  foreach(var_5 in level.players) {
    if(var_5 scripts\cp\utility::isusingremote()) {
      continue;
    }
    if(distancesquared(var_3, var_5.origin) > 360000) {
      continue;
    }
    if(var_5 damageconetrace(var_3))
      var_5 thread scripts\cp\cp_weapon::dirteffect(var_3);

    var_5 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
  }

  var_0 thread reset_grenades();
  var_0 thread delete_last_second_grenade_throws(var_2);
}

reset_grenades() {
  self endon("_encstr_AD75063D571AE108");
  self disableoffhandweapons();

  while(self fragButtonPressed())
    wait 0.1;

  wait 0.1;
  self enableoffhandweapons();
}

delete_last_second_grenade_throws(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A2A31BE536CBB6B93E5BD081B3D75F480BA460E598CBF8C7E932C0F0AA");
  self notify("_encstr_88A22A9ADBDFDA13DA88B108690B1A97785FB5093233E9977DA7BAE0CDF9478EBFE51B3277A1EB22BEB03F40");
  thread end_function_after_time(0.25);
  self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_1, var_2, var_3, var_4);

  if(isDefined(var_1) && var_1.classname == "_encstr_8C8D08671D451291C849") {
    var_1 delete();
    power_adjustcharges(self.powers[var_0].charges + 1, self.powers[var_0].slot, 1);
  }
}

end_function_after_time(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);
  self notify("_encstr_A2A31BE536CBB6B93E5BD081B3D75F480BA460E598CBF8C7E932C0F0AA");
}

power_createdefaultstruct(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawnStruct();
  var_10.usetype = var_1;
  var_10.weaponuse = var_2;
  var_10.cooldowntime = var_4;
  var_10.id = var_3;

  if(level.gametype == "_encstr_B1BC09D6E3C9BBA3EFB318")
    var_10.maxcharges = 1;
  else
    var_10.maxcharges = var_5;

  var_10.deathreset = var_6;
  var_10.usecooldown = var_7;
  var_10.uitype = var_8;
  var_10.defaultslot = var_9;
  level.powers[var_0] = var_10;
}

powerparsetable() {
  var_0 = 1;

  if(isDefined(level.power_table))
    var_1 = level.power_table;
  else
    var_1 = "_encstr_A22D15C683E53683EB837BEE2B392A2CC463CA1736DCEC";

  for(;;) {
    var_2 = tablelookupbyrow(var_1, var_0, 0);

    if(var_2 == "_encstr_B40101") {
      break;
    }

    var_3 = tablelookupbyrow(var_1, var_0, 1);
    var_4 = tablelookupbyrow(var_1, var_0, 6);
    var_5 = tablelookupbyrow(var_1, var_0, 7);
    var_6 = tablelookupbyrow(var_1, var_0, 8);
    var_7 = tablelookupbyrow(var_1, var_0, 9);
    var_8 = tablelookupbyrow(var_1, var_0, 10);
    var_9 = tablelookupbyrow(var_1, var_0, 11);
    var_10 = tablelookupbyrow(var_1, var_0, 16);
    var_11 = tablelookupbyrow(var_1, var_0, 13);
    power_createdefaultstruct(var_3, var_4, var_5, int(var_2), float(var_6), int(var_7), int(var_8), int(var_9), var_10, var_11);

    if(isDefined(level.powerweaponmap[var_5]) && var_5 != "_encstr_A1C91E3133404F621697EF97F5B3FB8419399F2D0993E95AF8AFBF9719682296") {
      switch (var_5) {
        case "_encstr_B83C0D8AC20BB5608F431FFF576013":
          if(var_3 == "_encstr_B28A0F387BEE95C9AFE4ACEE2DB932AC27") {
            break;
          }
        default:
          break;
      }
    }

    level.powerweaponmap[var_5] = var_3;
    var_0++;
  }
}

powersetupfunctions(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = level.powers[var_0];

  if(!isDefined(var_7))
    scripts\engine\utility::error("_encstr_ADFB1B7D58B1C2973030AF8FB06B517B9BE0FD7EB55BEBA1D1D8BFD332" + var_0 + "_encstr_97606C58B57B233BB5A99608CBBF1FDBD2339E20F158EBDF66FB9A8230654AD6B0A557A83758E6A78730D2AEBB45E30F82518F678BE0724F35EB7BD04310EF8390C736EB995082225601B27AA97D1ABE3369B55231600CFFAF9B7AE290C5527410A921C6DBC894B7A1D0C39AB988");

  level.powersetfuncs[var_0] = var_1;
  level.powerunsetfuncs[var_0] = var_2;

  if(isDefined(var_3))
    var_7.usefunc = var_3;

  if(isDefined(var_4))
    var_7.updatenotify = var_4;

  if(isDefined(var_5))
    var_7.usednotify = var_5;

  if(isDefined(var_6))
    var_7.interruptnotify = var_6;
}

power_sethudstate(var_0, var_1) {
  var_2 = getpower(var_0);
  var_3 = self.powers[var_2];
  var_4 = level.powers[var_2];
  var_5 = var_3.hudstate;
  var_6 = var_3.charges;

  if(isDefined(var_5) && var_5 == var_1) {
    return;
  }
  if(isDefined(var_5))
    power_unsethudstate(var_0);

  switch (var_1) {
    case 0:
      scripts\cp_mp\powershud::powershud_beginpowerdrain(var_0);
      scripts\cp_mp\powershud::powershud_updatepowermeter(var_0, 1);
      powershud_updatepowerchargescp(var_2, var_0, var_6);
      thread power_watchhuddrainmeter(var_2);
      break;
    case 1:
      scripts\cp_mp\powershud::powershud_beginpowercooldown(var_0, 0);
      powershud_updatepowerchargescp(var_2, var_0, var_6);
      thread power_watchhudcooldownmeter(var_2);
      break;
    case 2:
      scripts\cp_mp\powershud::powershud_updatepowerdisabled(var_0, 0);
      scripts\cp_mp\powershud::powershud_updatepowermeter(var_0, 1);
      powershud_updatepowerchargescp(var_2, var_0, var_6);
      thread power_watchhudcharges(var_2);
      break;
    case 3:
      break;
  }

  var_3.hudstate = var_1;
  thread power_unsethudstateonremoved(var_0);
}

power_unsethudstate(var_0) {
  var_1 = getpower(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = self.powers[var_1];
  var_3 = var_2.hudstate;

  if(!isDefined(var_3)) {
    return;
  }
  switch (var_3) {
    case "_encstr_8AA40C536561B0B79AA3DBE59B62":
      break;
    case 0:
      scripts\cp_mp\powershud::powershud_endpowerdrain(var_0);
      break;
    case 2:
      break;
    case 1:
      scripts\cp_mp\powershud::powershud_finishpowercooldown(var_0, 0);
      break;
  }

  var_2.hudstate = undefined;
}

power_unsethudstateonremoved(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AC3B1E1CEDEE9527F55773DC59E8425D329AA385D195E9DC2556B5DECE5919BE" + var_0);
  self endon("_encstr_AC3B1E1CEDEE9527F55773DC59E8425D329AA385D195E9DC2556B5DECE5919BE" + var_0);
  var_1 = getpower(var_0);
  self waittill("_encstr_BD590F4338AF67F3DE164D4DA0C397EF57" + var_1);
  power_unsethudstate(var_0);
}

givepower(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 2;

  if(!isDefined(self.powers))
    self.powers = [];

  if(var_0 == "_encstr_8BBA05185F8B99") {
    return;
  }
  if(var_1 == "_encstr_84DB09430E5B9A0B6D2001")
    var_8++;

  for(var_9 = self getheldoffhand(); !nullweapon(var_9); var_9 = self getheldoffhand())
    waitframe();

  var_10 = getarraykeys(self.powers);

  foreach(var_12 in var_10) {
    if(self.powers[var_12].slot == var_1) {
      self.itemreplaced = var_12;
      removepower(var_12);
      break;
    }
  }

  if(isDefined(level.extra_charge_func))
    var_4 = [[level.extra_charge_func]](var_0);

  power_createplayerstruct(var_0, var_1, var_4, var_5, var_6, var_7);
  var_14 = self.powers[var_0];
  var_15 = level.powers[var_0];
  self notify("_encstr_8BE312E31FA8E1631DF84BF37D3A82D3C7556471" + var_1);
  var_16 = 0.0;

  if(isDefined(self.powercooldowns) && isDefined(self.powercooldowns[var_0])) {
    var_17 = self.powercooldowns[var_0];
    var_18 = power_cooldownremaining(var_17);

    if(var_18 > 0.0) {
      var_19 = var_14.charges * var_15.cooldowntime;
      var_14.charges = int((var_19 - var_18) / var_15.cooldowntime);

      if(var_14.charges < 0)
        var_14.charges = 0;

      for(var_16 = var_18; var_16 > var_15.cooldowntime; var_16 = var_16 - var_15.cooldowntime) {}
    }
  }

  if(var_1 == "_encstr_84DB09430E5B9A0B6D2001") {
    return;
  }
  var_14.weaponuse = undefined;

  if(var_15.weaponuse == "_encstr_A1C91E3133404F621697EF97F5B3FB8419399F2D0993E95AF8AFBF9719682296")
    var_14.weaponuse = scripts\engine\utility::ter_op(var_1 == "_encstr_BA7F0830B3A7859B60B0", "_encstr_B8CA20D3CFB45A7AF9932E72C858A4310463231F9DD3621FA85BA4BDE120E189E9A1", "_encstr_BE0122D22070ADE3105F3F6373AFCBDF48C9CD1F7B6873095E1B371F555D424AD01685A2");
  else
    var_14.weaponuse = var_15.weaponuse;

  var_20 = var_14.weaponuse;
  var_14.weaponuse = var_20;
  var_14.objweapon = getcompleteweaponname(var_20);
  self giveweapon(var_14.objweapon);
  self setweaponammoclip(var_14.objweapon, var_14.charges);

  if(var_14.slot == "_encstr_BA7F0830B3A7859B60B0") {
    self assignweaponoffhandprimary(var_14.objweapon);
    self.powerprimarygrenade = var_20;
    self setclientomnvar("_encstr_A2A415ED312753BFBB3AE08152D6694E3FA87FE697977B", var_14.charges);
  } else if(var_14.slot == "_encstr_AC8F0AE74163F85AAA380AD8") {
    self assignweaponoffhandsecondary(var_14.objweapon);
    self.powersecondarygrenade = var_20;
    self setclientomnvar("_encstr_AF0E1F3DE1F7834F4BCA305183E70F385B944F36594FE89B707180F0DA7ACFB1F7", var_14.charges);
  }

  if(isDefined(level.powersetfuncs[var_0]))
    self[[level.powersetfuncs[var_0]]](var_0);

  if(isDefined(var_6) && !var_6)
    thread remove_when_charges_exhausted(var_0);

  if(!isai(self)) {
    thread power_modifychargesonscavenge(var_0);
    thread power_modifychargesonpickuporfailure(var_0);
    thread managepowerbuttonuse(var_15, var_0, var_14.slot, var_15.cooldowntime, var_15.updatenotify, var_15.usednotify, var_20, var_16, var_2);
  }

  self notify("_encstr_BDD60FC17BDD2BE4CDFAD507910B8E95C8");
}

removepower(var_0) {
  if(isDefined(level.powerunsetfuncs[var_0]))
    self[[level.powerunsetfuncs[var_0]]]();

  if(isDefined(self.powers[var_0].weaponuse))
    self takeweapon(self.powers[var_0].weaponuse);

  if(self.powers[var_0].slot == "_encstr_BA7F0830B3A7859B60B0") {
    self clearoffhandprimary();
    self.powerprimarygrenade = undefined;
  } else if(self.powers[var_0].slot == "_encstr_AC8F0AE74163F85AAA380AD8") {
    self clearoffhandsecondary();
    self.powersecondarygrenade = undefined;
  }

  self notify("_encstr_BD590F4338AF67F3DE164D4DA0C397EF57" + var_0);
  zm_powershud_clearpower(self.powers[var_0].slot);
  self.powers[var_0] = undefined;
}

zm_powershud_clearpower(var_0) {
  if(var_0 == "_encstr_84DB09430E5B9A0B6D2001") {
    return;
  }
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var_0, 2), 0);
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var_0, 1), 0);
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var_0, 0), -1);
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var_0, 3), 0);
}

cleanpowercooldowns() {
  if(isDefined(self.powercooldowns) && self.powercooldowns.size > 0) {
    var_0 = self.powercooldowns;

    foreach(var_3, var_2 in var_0) {
      if(power_cooldownremaining(var_2) == 0.0)
        self.powercooldowns[var_3] = undefined;
    }
  }
}

power_cooldownremaining(var_0) {
  var_1 = level.powers[var_0.power];
  var_2 = (var_0.maxcharges - var_0.charges) * var_1.cooldowntime - (var_1.cooldowntime - var_0.cooldownleft);
  var_3 = (gettime() - var_0.timestamp) / 1000;
  return max(0, var_2 - var_3);
}

clearpowers() {
  self notify("_encstr_9AF10F83B7DDB2C99BFAD8C6B2C29BAA83");

  if(isDefined(self.powers)) {
    var_0 = self.powers;

    foreach(var_3, var_2 in var_0)
    removepower(var_3);

    self.powers = [];
  }
}

getpower(var_0) {
  if(!isDefined(self.powers))
    return undefined;

  foreach(var_3, var_2 in self.powers) {
    if(var_2.slot == var_0)
      return var_3;
  }

  return undefined;
}

clear_power_slot(var_0) {
  var_1 = self.powers;
  var_2 = power_getpowerkeys();

  foreach(var_4 in var_2) {
    if(var_1[var_4].slot == var_0) {
      self.powers[var_4] = undefined;
      self notify("_encstr_8CAA11E708C11153C7475D53254559CB48A833" + var_4);
      removepower(var_4);
    }
  }

  zm_powershud_clearpower(var_0);
}

what_power_is_in_slot(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = getarraykeys(self.powers);

  foreach(var_5 in var_3) {
    if(isDefined(self.powers[var_5].slot) && self.powers[var_5].slot == var_0) {
      var_2 = var_5;
      return var_2;
    }
  }

  return undefined;
}

power_getinputcommand(var_0) {
  return scripts\engine\utility::ter_op(self.powers[var_0].slot == "_encstr_BA7F0830B3A7859B60B0", "_encstr_9B0D065699E485D9", "_encstr_8E5F0795E6AD7BAD2B");
}

power_createplayerstruct(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.powers[var_0];
  var_7 = spawnStruct();
  var_7.slot = var_1;
  var_7.charges = var_6.maxcharges;

  if(istrue(var_2))
    var_7.charges++;

  if(isDefined(var_5))
    var_7.charges = var_5;

  var_7.maxcharges = quadgridcenterpoints(var_0, var_1);
  var_7.incooldown = 0;
  var_7.active = 0;
  var_7.cooldownleft = 0;
  var_7.cooldownratemod = 1.0;
  var_7.cooldown = var_3;
  var_7.permanent = var_4;
  var_7.passives = [];
  self.powers[var_0] = var_7;
}

quadgridcenterpoints(var_0, var_1) {
  if(scripts\cp\utility::tryingtoleave())
    return level.powers[var_0].maxcharges;

  return scripts\cp\cp_loadout::get_num_of_charges_for_power(self, var_1);
}

managepowerbuttonuse(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9AF10F83B7DDB2C99BFAD8C6B2C29BAA83");
  self endon("_encstr_BD590F4338AF67F3DE164D4DA0C397EF57" + var_1);
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_8) && var_8 || var_1 == "_encstr_AD67151CF6BB2BE4FA367B0E5E36C2471D4E95CD2C19CA")
    self endon("_encstr_BD170E77409E1B632149E02BF8CE8009");

  self endon("_encstr_8CAA11E708C11153C7475D53254559CB48A833" + var_1);
  scripts\cp_mp\powershud::powershud_assignpower(var_2, int(var_0.id), 1, int(self.powers[var_1].charges));
  scripts\cp\utility::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  power_sethudstate(var_2, 2);

  for(;;) {
    if(scripts\cp\cp_laststand::player_in_laststand(self))
      scripts\engine\utility::_id_143A6("_encstr_9695073995D94BD959", "_encstr_99E70F8E496BBA33A51FAE55ABF8FAAB23", "_encstr_910C1AF758764811B7FAF9A1F1775888CAA47341FD51E0ED93A2D3A9");

    power_updateammo(var_1);
    var_9 = var_6 + "_encstr_A72009A71F50268FB56323";
    thread watchearlyout(var_3, var_1, var_9);
    var_10 = scripts\engine\utility::ter_op(var_0.usetype == "_encstr_B2BA0C10FAF65158039FF378B473", "_encstr_883711F0997028D145335138C3FA58461872C3", "_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0");
    self waittill(var_10, var_11);

    if(var_11.basename != var_6) {
      continue;
    }
    var_3 = getpowercooldowntime(var_0);
    self notify(var_9);

    if(self.powers[var_1].charges != 0 && !self.powers[var_1].active) {
      var_12 = undefined;

      if(isDefined(var_0.usefunc)) {
        var_12 = self thread[[var_0.usefunc]](var_11);

        if(isDefined(var_12) && var_12 == 0)
          continue;
      }

      if(isDefined(var_5)) {
        self waittill(var_5, var_12);

        if(isDefined(var_12) && var_12 == 0)
          continue;
      }

      if(!isDefined(self.dont_use_charges) || self.dont_use_charges != var_1) {}
    }

    power_adjustcharges(-1, self.powers[var_1].slot);
    self notify("_encstr_88FE0C18676F8A6009AB0FC50D89" + var_1);

    if(isDefined(var_4) && level.powers[var_1].uitype == "_encstr_9AC906A143AFF113" && !istrue(self.powers[var_1].indrain))
      power_dodrain(var_1);

    thread power_docooldown(var_1, var_3, var_8);
  }
}

ispickedupgrenadetype(var_0) {
  switch (var_0) {
    case "_encstr_82BC15EB3D9FC0D60177D9E3DF5B95A007D2F1A026F488":
    case "_encstr_85690DDBA0378F1B267EA5D695EB7F":
    case "_encstr_848510DBC7AC4262F129A5ADEDF9AADA857B":
    case "_encstr_81580B52FF3F7F3D195A6A61A7":
    case "_encstr_ABE813B8E843EAD21733C8EF4C832F8BBB8581C741":
    case "_encstr_87CB0E0B177C92B2411875BD7030E71B":
      return 1;
    default:
      return 0;
  }
}

getpowercooldowntime(var_0) {
  if(istrue(level.powershortcooldown))
    return 0.1;
  else if(istrue(level.infinite_grenades))
    return 2.5;
  else if(scripts\cp\utility::is_consumable_active("_encstr_9B5E111C32FA7589C40F69903F17E0A9A29B37"))
    return var_0.cooldowntime;
  else
    return var_0.cooldowntime;
}

power_modifychargesonscavenge(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9AF10F83B7DDB2C99BFAD8C6B2C29BAA83");
  self endon("_encstr_BD590F4338AF67F3DE164D4DA0C397EF57" + var_0);
  var_1 = self.powers[var_0];
  var_2 = var_1.weaponuse;
  var_3 = var_1.slot;

  for(;;) {
    self waittill("_encstr_A6790F2B71AFFB7F58FF5D24F75805DFC0", var_4);

    if(var_4 == var_2)
      power_adjustcharges(var_1.maxcharges, var_3);

    var_5 = var_1.hudstate;

    if(var_5 == 1)
      power_sethudstate(var_3, 2);
  }
}

power_modifychargesonpickuporfailure(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9AF10F83B7DDB2C99BFAD8C6B2C29BAA83");
  self endon("_encstr_BD590F4338AF67F3DE164D4DA0C397EF57" + var_0);
  var_1 = self.powers[var_0];
  var_2 = var_1.weaponuse;
  var_3 = var_1.slot;

  for(;;) {
    self waittill("_encstr_9A3C117B6B0602C5284EC7CA23C808BAED8D93", var_4);

    if(var_4 == var_2)
      power_adjustcharges(1, var_3);

    var_5 = var_1.hudstate;

    if(var_5 == 1)
      power_sethudstate(var_3, 2);
  }
}

remove_when_charges_exhausted(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD590F4338AF67F3DE164D4DA0C397EF57" + var_0);
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.powers[var_0];

  while(isDefined(self.powers[var_0])) {
    self waittill("_encstr_88FE0C18676F8A6009AB0FC50D89" + var_0);

    if(istrue(level.powershortcooldown)) {
      continue;
    }
    if(var_1.charges < 1) {
      while(self isswitchingweapon() || scripts\engine\utility::array_contains(self.powers_active, var_0))
        wait 0.25;

      wait 0.25;
      thread removepower(var_0);
    }
  }
}

power_shouldcooldown(var_0) {
  if(!isDefined(self.powers[var_0]))
    return 0;

  if(istrue(self.powers[var_0].cooldown))
    return 1;

  if(istrue(level.powershortcooldown))
    return 1;

  if(level.powers[var_0].usecooldown)
    return 1;

  if(isDefined(self.powers[var_0].slot) && self.powers[var_0].slot != "_encstr_BA7F0830B3A7859B60B0")
    return 0;

  if(scripts\cp\utility::is_consumable_active("_encstr_9B5E111C32FA7589C40F69903F17E0A9A29B37") && level.powers[var_0].defaultslot != "_encstr_AC8F0AE74163F85AAA380AD8")
    return 1;

  if(istrue(level.infinite_grenades))
    return 1;

  return 0;
}

activatepower(var_0) {
  self.powers_active[self.powers_active.size] = var_0;
}

deactivatepower(var_0) {
  if(scripts\engine\utility::array_contains(self.powers_active, var_0))
    self.powers_active = scripts\engine\utility::array_remove(self.powers_active, var_0);
}

power_docooldown(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9AF10F83B7DDB2C99BFAD8C6B2C29BAA83");
  self endon("_encstr_BD590F4338AF67F3DE164D4DA0C397EF57" + var_0);
  self endon("_encstr_995A15837B7756E47DC6DB7BB191EDEEB97DCADC19598C" + var_0);

  if(isDefined(var_2) && var_2 || var_0 == "_encstr_AD67151CF6BB2BE4FA367B0E5E36C2471D4E95CD2C19CA")
    self endon("_encstr_BD170E77409E1B632149E02BF8CE8009");

  self endon("_encstr_8CAA11E708C11153C7475D53254559CB48A833" + var_0);
  self notify("_encstr_BDC81657B51BA32B3FD72830F35CC0CFF2D1C6550F526D76" + var_0);
  self endon("_encstr_BDC81657B51BA32B3FD72830F35CC0CFF2D1C6550F526D76" + var_0);
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = level.powers[var_0];
  var_4 = self.powers[var_0];
  var_5 = var_4.slot;
  var_6 = var_0 + "_encstr_9A1911FA6CB7DBD846B7DD37BED51C230BE8AC";
  var_4.incooldown = 1;

  if(!isDefined(var_4.cooldownsqueued))
    var_4.cooldownsqueued = 0;

  var_4.cooldownsqueued++;

  if(!isDefined(var_4.cooldowncounter))
    var_4.cooldowncounter = 0;

  if(!isDefined(var_4.cooldownleft))
    var_4.cooldownleft = 0;

  var_4.cooldownleft = var_4.cooldownleft + var_1;
  var_7 = var_4.hudstate;

  if(isDefined(var_7) && var_7 != 0 && var_4.charges == 0)
    power_sethudstate(var_5, 1);

  while(var_4.charges < var_4.maxcharges) {
    if(power_shouldcooldown(var_0))
      wait 0.1;
    else {
      level scripts\engine\utility::_id_143A6("_encstr_BEED1BFF7DB005279501418A28786BFF88EF7E20F3584BCF44B9EB9251", "_encstr_9A2618D2736696CD5A8E56D7B3E4CAB9C2C856FA2C1B8ED29D56", "_encstr_B15715AF9B5A76F0074288832FF27126520F19195F8330");
      var_1 = getpowercooldowntime(var_3);
    }

    if(var_4.cooldowncounter > var_1) {
      power_adjustcharges(1, var_5);
      power_updateammo(var_0);

      if(var_4.charges == var_4.maxcharges)
        thread power_endcooldown(var_0, var_2);

      var_4.cooldowncounter = var_4.cooldowncounter - var_1;
      var_4.cooldownleft = var_4.cooldownleft - var_1;
      var_4.cooldownsqueued--;

      if(isDefined(var_7) && var_7 != 0)
        power_sethudstate(var_5, 2);
    } else {
      var_4.cooldowncounter = var_4.cooldowncounter + 0.1;
      var_4.cooldownleft = var_4.cooldownleft - 0.1;
    }

    var_8 = min(1, var_4.cooldowncounter / var_1);
    self notify(var_6, var_8);
  }

  thread power_endcooldown(var_0, var_2);
}

power_endcooldown(var_0, var_1) {
  self notify("_encstr_995A15837B7756E47DC6DB7BB191EDEEB97DCADC19598C" + var_0);
  var_2 = self.powers[var_0];
  var_2.incooldown = 0;
  var_2.cooldowncounter = 0;
  var_2.cooldownleft = 0;
  var_2.cooldownsqueued = 0;

  if(isDefined(var_1) && var_1)
    self notify("_encstr_878C0E6737DF7383D05B195A1128CDDB");

  var_3 = var_2.hudstate;
  var_4 = var_2.slot;

  if(var_3 == 0) {
    return;
  }
  power_sethudstate(var_4, 2);
}

power_dodrain(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9A9913137F9B97B539FD5AFB141D0950BE80DDD0B6" + var_0);
  self notify("_encstr_93E0162288AF123AA648E7DF08F9EFFB4508EF5DE523BA4F" + var_0);
  var_1 = level.powers[var_0];
  var_2 = self.powers[var_0];
  var_3 = var_1.updatenotify;
  var_4 = var_1.interruptnotify;
  var_5 = var_2.slot;
  var_2.indrain = 1;
  power_disableactivation(var_0);
  power_sethudstate(var_5, 0);

  if(isDefined(var_4))
    thread power_enddrainoninterrupt(var_0, var_5, var_4);

  for(;;) {
    self waittill(var_3, var_6);

    if(var_6 == 0) {
      break;
    }
  }

  thread power_enddrain(var_0);
}

power_enddrainoninterrupt(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9AF10F83B7DDB2C99BFAD8C6B2C29BAA83");
  self endon("_encstr_BD590F4338AF67F3DE164D4DA0C397EF57" + var_0);
  self endon("_encstr_9A9913137F9B97B539FD5AFB141D0950BE80DDD0B6" + var_0);
  self waittill(var_2);
  thread power_enddrain(var_0);
}

power_enddrain(var_0) {
  self notify("_encstr_9A9913137F9B97B539FD5AFB141D0950BE80DDD0B6" + var_0);
  var_1 = self.powers[var_0];
  var_2 = var_1.slot;
  var_1.indrain = 0;
  power_enableactivation(var_0);

  if(var_1.charges > 0)
    power_sethudstate(var_2, 2);
  else
    power_sethudstate(var_2, 1);
}

haspower(var_0) {
  if(!isDefined(self.powers[var_0]))
    return 0;

  return 1;
}

waitonpowerbutton(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(var_0 == "_encstr_BA7F0830B3A7859B60B0")
    var_1 = "_encstr_8FEB1378F8AFE75067C90B814DB77B3B119072ADF7";
  else
    var_1 = "_encstr_92E715CB1DBFE0F621172B2F4F1A35185270D6E38215A0";

  for(;;) {
    if(!isDefined(self)) {
      wait 1;
      break;
    }

    self waittill(var_1);
    break;
  }
}

power_modifycooldownrate(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_AF1904A7F929";

  var_2 = power_getpowerkeys();

  foreach(var_4 in var_2) {
    if(isDefined(self.powers[var_4].slot) && self.powers[var_4].slot == var_1 || var_1 == "_encstr_AF1904A7F929")
      self.powers[var_4].cooldownratemod = var_0;
  }
}

power_adjustcharges(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = "_encstr_AF1904A7F929";

  var_3 = power_getpowerkeys();
  var_4 = var_0;

  foreach(var_6 in var_3) {
    if(!isDefined(var_0))
      var_4 = self.powers[var_6].maxcharges;

    if(self.powers[var_6].slot == var_1 || var_1 == "_encstr_AF1904A7F929") {
      if(isDefined(var_2))
        self.powers[var_6].charges = int(min(var_4, self.powers[var_6].maxcharges));
      else if(self.powers[var_6].charges + var_4 >= 0)
        self.powers[var_6].charges = self.powers[var_6].charges + var_4;
      else
        self.powers[var_6].charges = 0;

      self.powers[var_6].charges = int(clamp(self.powers[var_6].charges, 0, self.powers[var_6].maxcharges));
      self setweaponammoclip(self.powers[var_6].weaponuse, self.powers[var_6].charges);
      powershud_updatepowerchargescp(var_6, self.powers[var_6].slot, self.powers[var_6].charges);
    }
  }
}

_id_1281C(var_0) {
  var_1 = var_0 power_getpowerkeys();

  foreach(var_3 in var_1) {
    if(var_0.powers[var_3].charges != var_0.powers[var_3].maxcharges)
      return 0;
  }

  return 1;
}

power_getpowerkeys() {
  var_0 = getarraykeys(level.powers);
  var_1 = getarraykeys(self.powers);
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_1) {
    foreach(var_7 in var_0) {
      if(var_5 == var_7) {
        var_2[var_3] = var_5;
        var_3 = var_3 + 1;
        break;
      }
    }
  }

  return var_2;
}

power_disablepower(var_0) {
  if(scripts\common\utility::is_offhand_weapons_allowed())
    scripts\common\utility::allow_offhand_weapons(0);
}

power_enablepower(var_0) {
  if(!scripts\common\utility::is_offhand_weapons_allowed())
    scripts\common\utility::allow_offhand_weapons(1);
}

definepowerovertimeduration(var_0) {
  if(!isDefined(self.powerdurations))
    self.powerdurations = [];

  if(!isDefined(self.powerdurations[var_0]))
    self.powerdurations[var_0] = 0.0;
}

getpowerovertimeduration(var_0) {
  definepowerovertimeduration(var_0);
  return self.powerdurations[var_0];
}

setpowerovertimeduration(var_0, var_1) {
  definepowerovertimeduration(var_0);
  self.powerdurations[var_0] = var_1;
}

watchearlyout(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9AF10F83B7DDB2C99BFAD8C6B2C29BAA83");
  self endon("_encstr_BD590F4338AF67F3DE164D4DA0C397EF57" + var_1);
  self endon(var_2);
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0", var_3);
  var_4 = self.powers[var_1];
  var_5 = createheadicon(var_3);

  if(var_5 == var_4.weaponuse) {
    if(!isalive(self)) {
      if(var_4.charges > 0)
        power_adjustcharges(-1, var_4.slot);

      if(!var_4.incooldown) {
        var_4.cooldownleft = level.powers[var_1].cooldowntime;
        thread power_docooldown(var_1, var_0);
      }
    }
  }
}

ispowersbuttonPressed(var_0) {
  if(var_0 == "_encstr_9B0D065699E485D9" && self fragButtonPressed() || var_0 == "_encstr_8E5F0795E6AD7BAD2B" && self secondaryoffhandbuttonPressed())
    return 1;
  else
    return 0;
}

power_watchhudcharges(var_0) {
  self endon("_encstr_883517B72823072B6EEA94322D43A68D28A1E99BE8452FB00F" + var_0);
  var_1 = self.powers[var_0];
  var_2 = var_1.slot;

  for(;;) {
    self waittill("_encstr_8D1E1813F8AC8F82D9EF5859A5700FAFC051CA3A030603BFD8AF" + var_0, var_3);
    powershud_updatepowerchargescp(var_0, var_2, var_3);
  }
}

powershud_updatepowerchargescp(var_0, var_1, var_2) {
  self setclientomnvar(scripts\cp_mp\powershud::powershud_getslotomnvar(var_1, 0), int(var_2));
}

power_watchhuddrainmeter(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD590F4338AF67F3DE164D4DA0C397EF57" + var_0);
  self endon("_encstr_9A9913137F9B97B539FD5AFB141D0950BE80DDD0B6" + var_0);
  var_1 = self.powers[var_0];
  var_2 = level.powers[var_0];
  var_3 = var_1.slot;
  var_4 = var_2.updatenotify;

  if(!isDefined(var_4))
    var_4 = var_0 + "_encstr_A3A8083795B802FB73DD";

  for(;;) {
    self waittill(var_4, var_5);
    var_5 = max(0, min(1, var_5));
    scripts\cp_mp\powershud::powershud_updatepowerdrainprogress(var_3, var_5);
  }
}

power_watchhudcooldownmeter(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD590F4338AF67F3DE164D4DA0C397EF57" + var_0);
  self endon("_encstr_995A15837B7756E47DC6DB7BB191EDEEB97DCADC19598C" + var_0);
  var_1 = self.powers[var_0];
  var_2 = level.powers[var_0];
  var_3 = var_1.slot;
  var_4 = var_0 + "_encstr_9A1911FA6CB7DBD846B7DD37BED51C230BE8AC";

  for(;;) {
    self waittill(var_4, var_5);
    scripts\cp_mp\powershud::powershud_updatepowercooldown(var_3, var_5);
  }
}

power_disableactivation(var_0) {
  var_1 = self.powers[var_0];

  if(!isDefined(var_1.disableactivation))
    var_1.disableactivation = 0;

  var_1.disableactivation++;

  if(var_1.disableactivation == 1)
    power_updateammo(var_0);
}

power_enableactivation(var_0) {
  var_1 = self.powers[var_0];
  var_1.disableactivation--;

  if(var_1.disableactivation == 0)
    power_updateammo(var_0);
}

power_updateammo(var_0) {
  var_1 = self.powers[var_0];
  var_2 = isDefined(var_1.disableactivation) && var_1.disableactivation;
  var_3 = var_1.charges > 0;

  if(!var_2 && var_3)
    self setweaponammoclip(var_1.weaponuse, var_1.charges + 1);
  else {
    self setweaponammoclip(var_1.weaponuse, 0);

    if(scripts\cp\utility::turn_off_sniper_laser())
      thread _id_1281D(var_1.slot);
  }
}

_id_1281D(var_0) {
  if(var_0 == "_encstr_BA7F0830B3A7859B60B0")
    self setclientomnvar("_encstr_AA8C130E6F03FBA377FF10A09F5F7837CAD7081583", 3);
  else if(var_0 == "_encstr_AC8F0AE74163F85AAA380AD8") {
    wait 0.5;
    self setclientomnvar("_encstr_AA8C130E6F03FBA377FF10A09F5F7837CAD7081583", 4);
  }
}

power_addammo(var_0, var_1) {
  var_2 = self.powers[var_0];
  var_3 = isDefined(var_2.disableactivation) && var_2.disableactivation;
  var_4 = var_2.charges;

  if(!var_3) {
    if(var_4 + 1 < var_2.maxcharges) {
      self setweaponammoclip(var_2.objweapon, var_4 + 1);
      self notify("_encstr_8D1E1813F8AC8F82D9EF5859A5700FAFC051CA3A030603BFD8AF" + var_0, var_4 + 1);
      var_2.charges = var_2.charges + 1;
    } else {
      self setweaponammoclip(var_2.objweapon, var_2.maxcharges);
      self notify("_encstr_8D1E1813F8AC8F82D9EF5859A5700FAFC051CA3A030603BFD8AF" + var_0, var_2.maxcharges);
      var_2.charges = var_2.maxcharges;
    }
  } else
    self setweaponammoclip(var_2.weaponuse, 0);
}

get_info_for_player_powers(var_0) {
  var_1 = [];

  foreach(var_3 in getarraykeys(var_0.powers)) {
    var_4 = spawnStruct();
    var_4.slot = var_0.powers[var_3].slot;
    var_4.charges = var_0.powers[var_3].charges;
    var_4.cooldown = var_0.powers[var_3].cooldown;
    var_4.permanent = var_0.powers[var_3].permanent;
    var_4.maxcharges = var_0.powers[var_3].maxcharges;
    var_1[var_3] = var_4;
  }

  return var_1;
}

restore_powers(var_0, var_1) {
  foreach(var_6, var_3 in var_1) {
    var_4 = undefined;
    var_5 = 0;

    if(istrue(var_3.cooldown))
      var_4 = 1;

    if(istrue(var_3.permanent))
      var_5 = 1;

    if(var_3.slot == "_encstr_AC8F0AE74163F85AAA380AD8") {
      if(var_6 == "_encstr_84350B87AF1F692D19F2D0A8AB")
        var_0 givepower(var_6, var_3.slot, undefined, undefined, undefined, 1, 1, var_3.maxcharges);
      else
        var_0 givepower(var_6, var_3.slot, undefined, undefined, undefined, var_4, var_5, var_3.maxcharges);

      var_0 power_adjustcharges(var_3.charges, var_3.slot, 1);
      continue;
    }

    var_0 givepower(var_6, var_3.slot, undefined, undefined, undefined, undefined, 1, var_3.maxcharges);
    var_0 power_adjustcharges(var_3.charges, var_3.slot, 1);
  }
}

givecover(var_0) {
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_on_fired(undefined, undefined, undefined, 0);
}

takecover(var_0) {
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_on_take(undefined, undefined, 1);
}