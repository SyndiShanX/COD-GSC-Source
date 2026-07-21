/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\loot_system.gsc
***********************************************/

init_loot() {
  level.disable_loot_drop = 1;
  level.active_loot_spots = [];
  level.assault_weapons_array = ["_encstr_A63D1371A22C38F00B2FB7ABEF73C8F8C7FED8431B", "_encstr_8F3214BE124A5768F407C840E728A09DC1BFA7B1AED3", "_encstr_917D111339D8B77BE87DEE595807BD37D7B6A1", "_encstr_97BC12312763DBBD1D7DDDAC0B07B79BF5B5D80F"];
  level.lmg_weapons_array = ["_encstr_BD3E144CE436DBBDE8EBEE95B083B7B9BEA1DA9819C4", "_encstr_83BC122A7EC8FFE5D1C95B7210F1DD4306E7BBAD"];
  level.smg_weapons_array = ["_encstr_83BC122A7EC8FFE5D1C95B7210F1DD43066FA5A7", "_encstr_A1BC1298271BDE7B47D777595883B7E6BEB683A6", "_encstr_ABBC1231C9C6EDF61DF5EE590B077B37FAD60EDC", "_encstr_97BC12312763DBBD1D7DDDAC0B07B79BF5C14E06"];
  level.shotgun_weapons_array = ["_encstr_9A671346F2E847E8A369E4FBD95B10224F63A8B352", "_encstr_8B1913C3D8C03FA2B1F0BB37C7617AF64ED8220E62"];
  level.sniper_weapons_array = ["_encstr_923E13B5027510D0B3A9BBE152FB9850C1691F83E8", "_encstr_9330145A33493F5D282FEFC56B3065737888E223323B", "_encstr_95BC12264E63DEF68E7D77AC2C07F6DCF5D6891A", "_encstr_AFED1592D660573D0921A39AC859751B7E31191A61688B"];
  level.pistol_weapons_array = ["_encstr_8BBC121E4283D8E723B1F0784A7AAFB0F7FFBE2F", "_encstr_9A2B15C2703905675B60BFA507A31F0D37F8FB1B08E7BD"];
  init_loot_scriptables();
}

init_loot_scriptables() {
  scripts\engine\scriptable::scriptable_addusedcallback(::loot_pickup);
}

loot_pickup(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "_encstr_BE8B08E323FB2BCD6268") {
    var_5 = give_loot_based_on_pickup(var_1, var_3);

    if(istrue(var_5))
      level thread _id_119F4(var_0, var_1, var_2, var_3);
    else {}
  }
}

_id_119F4(var_0, var_1, var_2, var_3) {
  var_4 = strtok(var_1, "_encstr_BA4C02DF");
  var_5 = var_4[1];
  var_6 = var_4[2];
  var_3 playsoundtoplayer("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B", var_3);
  var_0 setscriptablepartstate(var_1, "_encstr_95DF070DD22319CA9B");
  level notify("_encstr_BAA71D50AB71B74FD9A0038BD82BC26F0818C3F1B1F81F96FB40CA02702971" + var_0.type + var_0.origin);

  if(var_5 == "_encstr_978D09FA80F57CF330A07E") {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_7 setModel("_encstr_AB7E215269940BF6C0719FBF0B213A27C703EA0BB37EDF687177D1BC319803F3E55922");
    var_7.angles = var_0.angles;
    var_7 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A24E069389FFAA3C");
    var_7 setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_ADB405071B8AE8");
    var_3 scripts\cp\utility::playerplaypickupanim("_encstr_B10F1296DD07BE3BB2B9FA0EA51BADD51CAF89C9");
    wait 1;
    var_7 delete();
  }
}

give_loot_based_on_pickup(var_0, var_1) {
  var_2 = strtok(var_0, "_encstr_BA4C02DF");
  var_3 = var_2[1];
  var_4 = var_2[2];
  var_5 = 0;

  switch (var_3) {
    case "_encstr_B483058670B0B7":
      var_5 = give_ammo(var_0, var_1);
      break;
    case "_encstr_A7B606DA83796F4A":
      break;
    case "_encstr_A19A077135838FDED1":
      break;
    case "_encstr_91B50734CA58631D1A":
      break;
    case "_encstr_87C7087705F442A1C839":
      var_5 = give_offhands(var_4, var_1);
      break;
    case "_encstr_AC20072B9FA9487832":
      var_5 = give_ammo_from_scavenged_weapon(var_0, var_1);
      break;
    case "_encstr_978D09FA80F57CF330A07E":
      var_5 = give_munition(var_0, var_1);
      break;
    default:
      return var_5;
  }

  return var_5;
}

give_munition(var_0, var_1) {
  var_2 = strtok(var_0, "_encstr_BA4C02DF");
  var_3 = "_encstr_B40101";

  for(var_4 = 2; var_4 < var_2.size; var_4++) {
    if(isDefined(var_2[var_4])) {
      if(var_3 == "_encstr_B40101") {
        var_3 = var_3 + var_2[var_4];
        continue;
      }

      var_3 = var_3 + "_encstr_BA4C02DF" + var_2[var_4];
    }
  }

  var_5 = undefined;
  var_6 = var_1 getplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD");

  if(var_6 < 4)
    var_5 = var_6;
  else
    var_5 = var_1.dpad_selection_index - 1;

  var_7 = get_empty_munition_slot(var_1);

  if(isDefined(var_7))
    var_5 = var_7;
  else {
    var_1 scripts\cp\utility::hint_prompt("_encstr_B6A9145BAE37D2A396B7B97DDC63DB1D9BBE33BA1B1B", 1, 2);
    return 0;
  }

  switch (var_3) {
    case "_encstr_8B2F11706B178D79CB05C8591957405FBCE250":
      var_1 scripts\cp\cp_munitions::give_munition_to_slot("_encstr_8B2F11706B178D79CB05C8591957405FBCE250", var_5);
      return 1;
    case "_encstr_B483058670B0B7":
      return var_1 try_give_munition_to_slot(var_3, var_5, "_encstr_A3990BDBEF05B561FA5A488BD8", "_encstr_A31C07E04BD8ADABE0");
    case "_encstr_A7AF07D1EF1B06683C":
      return var_1 try_give_munition_to_slot(var_3, var_5, "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_A31C07E04BD8ADABE0");
    case "_encstr_8F32093FD4AB3709F2C7F0":
    case "_encstr_A3C10B770DA547567D0E34DBE6":
    case "_encstr_886B0D58B2B56F2019B79BDBA305EB":
    case "_encstr_ACD20F4B118BEF03D380F9335815BC7761":
    case "_encstr_A6E3114659E036BD97B026B1CABE6CBD9D59C9":
    case "_encstr_B8840F126B9D8FF218872D21B7C03CC3CD":
    case "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38":
    case "_encstr_851904B59B34":
    case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
    case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
    case "_encstr_9B1807D39B48FD93A3":
    case "_encstr_A7B606DA83796F4A":
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      return var_1 try_give_munition_to_slot(var_3, var_5, undefined, "_encstr_A31C07E04BD8ADABE0");
    default:
      break;
  }

  var_1 iprintlnbold("_encstr_B68229498BBFBFEEC88FBCF039A83657179BA2A22B47BF629243AEB32D70FBFB4FD0CB5AF0C5879D18E598" + var_0);
  return 0;
}

try_give_munition_to_slot(var_0, var_1, var_2, var_3) {
  var_4 = var_0;

  if(isDefined(var_2))
    var_4 = var_2;

  scripts\cp\cp_munitions::give_munition_to_slot(var_4, var_1, var_3);
  return 1;
}

force_hint_prompt_timer(var_0, var_1) {
  self forceusehinton(var_0);
  wait(var_1);
  self forceusehintoff();
}

get_empty_munition_slot(var_0) {
  for(var_1 = 0; var_1 < var_0.munition_slots.size; var_1++) {
    if(var_0 is_empty_or_none(var_1))
      return var_1;
  }
}

is_empty_or_none(var_0) {
  var_1 = self;

  if(!isDefined(var_1.munition_slots))
    return 1;

  if(var_1.munition_slots[var_0].ref == "_encstr_8BBA05185F8B99" || var_1.munition_slots[var_0].ref == "_encstr_8E8A07AFE30F7349A2" || var_1.munition_slots[var_0].ref == "_encstr_828A0759AD88584327" || var_1.munition_slots[var_0].ref == "_encstr_928A072B57E3DD20C3")
    return 1;

  return 0;
}

give_ammo_from_scavenged_weapon(var_0, var_1) {
  var_2 = var_1 getcurrentweapon();
  var_3 = scripts\cp\utility::getweaponrootname(var_2);
  var_4 = scripts\cp\utility::weapongroupmap(var_3);

  if(scripts\engine\utility::array_contains(level.assault_weapons_array, var_0) && var_4 == "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D")
    return give_ammo(var_0, var_1);
  else if(scripts\engine\utility::array_contains(level.smg_weapons_array, var_0) && var_4 == "_encstr_AF710BF4355A9195B0FF0AEAD0")
    return give_ammo(var_0, var_1);
  else if(scripts\engine\utility::array_contains(level.sniper_weapons_array, var_0) && (var_4 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33" || var_4 == "_encstr_A1710B57AD31DBCDCDF1422A60"))
    return give_ammo(var_0, var_1);
  else if(scripts\engine\utility::array_contains(level.lmg_weapons_array, var_0) && var_4 == "_encstr_A3710BEEACC2E0B737EB36B676")
    return give_ammo(var_0, var_1);
  else if(scripts\engine\utility::array_contains(level.shotgun_weapons_array, var_0) && var_4 == "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9")
    return give_ammo(var_0, var_1);
  else if(scripts\engine\utility::array_contains(level.pistol_weapons_array, var_0) && var_4 == "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36")
    return give_ammo(var_0, var_1);
  else
    return 0;
}

give_offhands(var_0, var_1) {
  var_2 = "_encstr_BA7F0830B3A7859B60B0";

  switch (var_0) {
    case "_encstr_BE7206A2D07B1322":
    case "_encstr_88A906570DDE7B21":
      var_2 = "_encstr_AC8F0AE74163F85AAA380AD8";
      break;
  }

  var_3 = scripts\cp\cp_powers::power_getpowerkeys();

  foreach(var_6, var_5 in var_1.powers) {
    if(var_1.powers[var_6].slot == var_2) {
      if(var_1.powers[var_6].charges + 1 > var_1.powers[var_6].maxcharges)
        return 0;
    }
  }

  var_1 scripts\cp\cp_powers::power_adjustcharges(1, var_2);
  var_1 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
  return 1;
}

give_ammo(var_0, var_1) {
  return var_1 give_ammo_clip();
}

give_ammo_clip() {
  var_0 = self getcurrentweapon();
  var_1 = scripts\cp\utility::getrawbaseweaponname(var_0);
  var_2 = weaponclipsize(var_0);

  if(weapontype(var_0) == "_encstr_A5450BC280BF4B604068C33187" || scripts\cp\cp_weapon::is_incompatible_weapon(var_0)) {
    var_3 = self getweaponslistprimaries();

    foreach(var_5 in var_3) {
      if(var_5 == var_0) {
        continue;
      }
      if(!scripts\cp\cp_weapon::isbulletweapon(var_0)) {
        continue;
      }
      var_2 = weaponclipsize(var_5);
      var_1 = scripts\cp\utility::getrawbaseweaponname(var_5);

      if(self getweaponammostock(var_5) < weaponmaxammo(var_5)) {
        var_6 = self getweaponammostock(var_5);
        self setweaponammostock(var_5, var_2 + var_6);
        self.itempicked = createheadicon(var_5);
      } else if(self getweaponammoclip(var_5) < weaponclipsize(var_5))
        self setweaponammoclip(var_5, weaponclipsize(var_5));
      else
        return 0;

      return 1;
    }
  } else if(self getweaponammostock(var_0) < weaponmaxammo(var_0)) {
    var_6 = self getweaponammostock(var_0);
    self setweaponammostock(var_0, var_2 + var_6);
    self.itempicked = createheadicon(var_0);
  } else if(self getweaponammoclip(var_0) < weaponclipsize(var_0))
    self setweaponammoclip(var_0, weaponclipsize(var_0));
  else
    return 0;

  self playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
  return 1;
}