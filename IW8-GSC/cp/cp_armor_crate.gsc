/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_armor_crate.gsc
***********************************************/

armor_crate_init() {
  var_0 = spawnStruct();
  var_0.id = "_encstr_A7B606DA83796F4A";
  var_0.weaponinfo = "_encstr_B4E9147053F0F70EFB580FA689A0BB721C4F3B7918E1";
  var_0.modelbase = "_encstr_B2EF1C72B04D64FFB85D3717E1A68F6BC998FADB481D1D5376370235886B";
  var_0.hintstring = &"_encstr_95B41987383F51D74E622B07D5B92909EAE195F00F866EC991A31B";
  var_0.streakname = "_encstr_A7B606DA83796F4A";
  var_0.splashname = "_encstr_87C7111F2F75829F201BB2BA7093FC895EBFB3";
  var_0.shadername = "_encstr_A2A021367BD61C583737AFF6989AC17BA537A3D7232B0EC6DE5EAF33394B59CD8C8D2F";
  var_0.headicon = "_encstr_838614DE3FB73A6239B8B757785127B2DFDFE2D52855";
  var_0.headiconoffset = 20;
  var_0.lifespan = 90.0;
  var_0.usexp = 50;
  var_0.onusesfx = "_encstr_A3C80F4AF0E9DFB1709519F44369C36705";
  var_0.deployedsfx = "_encstr_A3C80F4AF0E9DFB1709519F44369C36705";
  var_0.deathvfx = loadfx("_encstr_8DDE45CE661E794BDD1CF2834EBDE0E5E6C6C9A5E03A1613C659CDF2EC991EAF7B999986B07346D7DDAD7D6EABE00EDE271DC4DB3CFA589CB5EDE4EB3A5AB5ACDE573A8BEC991E");
  var_0.onusecallback = ::armorbox_onusedeployable;
  var_0.canusecallback = ::armorbox_canusedeployable;
  var_0.deployfunc = ::armorbox_onusedeployable;
  var_0._id_120AA = "_encstr_922F1539B14DE8600392D3BB5A1B2EA0A904B1932EF480";
  var_0.usetime = 1000;
  var_0.maxhealth = 100;
  var_0.maxuses = 4;
  var_0.canreusebox = 0;
  var_0.allowmeleedamage = 1;
  var_0.damagefeedback = "_encstr_B40101";
  var_0.grenadeusefunc = ::supportbox_grenadelaunchfunc;
  var_0.ondeploycallback = scripts\cp\cp_deployablebox::supportbox_ondeploy;
  var_0.deployanimduration = scripts\cp\cp_deployablebox::supportbox_getdeployanimduration();
  level.boxsettings["_encstr_A7B606DA83796F4A"] = var_0;
  level.deployable_box["_encstr_A7B606DA83796F4A"] = [];
}

weaponswitchendedsupportbox(var_0, var_1) {
  if(istrue(var_1))
    thread supportbox_watchplayerweapon(var_0);
}

tryusesupportbox(var_0, var_1) {
  return 1;
}

armorbox_canusedeployable(var_0) {
  return 1;
}

supportbox_grenadelaunchfunc(var_0) {
  var_1 = self gettagorigin("_encstr_97D713BBD1BFE0A996C869808715CA98BF331BF759");
  var_2 = 400;
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoup(self.angles);
  var_4 = var_4 * 0.6;
  var_5 = vectorNormalize(var_3 + var_4);
  var_6 = var_5 * var_2;
  var_7 = magicbullet("_encstr_84791870E738DEF3FA7DA8A692121141BF67C8200FF533D7F365", var_1, var_1 + var_6, self);
  self notify("_encstr_9B620D8F0DC07577C551F16A3826BF", var_7);
}

armorbox_onusedeployable(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\cp\cp_armor::player_have_full_armor(self)) {
    scripts\cp\utility::hint_prompt("_encstr_BEB50A6B7A70CF59B3ED30B6", 1, 3);
    return 0;
  }

  scripts\cp\cp_armor::givearmor(self, 100, 1);
  self playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
  return 1;
}

supportbox_watchplayerweapon(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AB0214A177405080ABC78D89CF915D50F88D489A9FBC");
  self notifyonplayercommand("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommand("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");
  self notifyonplayercommand("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_8B5C0ECA58B1A32DDE73E6B1DBE804A6");
  self notifyonplayercommand("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_865C0EBE0BCF1BA710C08384685B4A33");
  var_1 = scripts\engine\utility::_id_143AE("_encstr_9B620D8F0DC07577C551F16A3826BF", "_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC");

  if(!isDefined(var_1)) {
    return;
  }
  if(var_1 == "_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A")
    self switchtoweapon(self.lastdroppableweaponobj);

  for(;;) {
    var_2 = self getcurrentweapon();

    if(var_2 != var_0.objweapon) {
      self notify("_encstr_95E2216DD2631BE61DE4B20BB6F5995ADC9637A12B32AFDD4BE834AFEEB2C21CBD37AF" + var_0.weaponname);
      break;
    }

    waitframe();
  }
}

supportbox_handledamage() {
  var_0 = level.boxsettings[self.boxtype];
}

supportbox_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = level.boxsettings[self.boxtype];
  var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
}

supportbox_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_7 = level.boxsettings[self.boxtype];
  return var_6;
}

supportbox_waittill_removeorweaponchange(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = spawnStruct();
  thread supportbox_waittill_notify(var_0, var_2);
  thread supportbox_waittill_notify(var_1, var_2);
  var_2 waittill("_encstr_BE3009989F7CABE51AAFDD", var_3, var_4);
  var_2 notify("_encstr_B81804322D2B");
  var_5 = spawnStruct();
  var_5.msg = var_3;
  var_5.param = var_4;
  return var_5;
}

supportbox_waittill_notify(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_B81804322D2B");
  self waittill(var_0, var_2);
  var_1 notify("_encstr_BE3009989F7CABE51AAFDD", var_0, var_2);
}

cangive_ammo() {
  var_0 = scripts\cp\utility::getvalidtakeweapon();
  var_1 = self getweaponammoclip(var_0);
  var_2 = weaponclipsize(var_0);
  var_3 = weaponmaxammo(var_0);
  var_4 = self getweaponammostock(var_0);

  if(var_4 < var_3 || var_1 < var_2)
    return 1;
  else
    return 0;
}

give_ammo_to_player_through_crate() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(weapontype(var_2) == "_encstr_A5450BC280BF4B604068C33187") {
      continue;
    }
    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_2)) {
      continue;
    }
    var_3 = weaponclipsize(var_2);
    self givemaxammo(var_2);
  }

  self playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
}

adjust_clip_ammo_from_stock(var_0, var_1, var_2, var_3, var_4) {
  if(!istrue(var_4)) {
    var_5 = weaponmaxammo(var_1);
    var_6 = var_0 getweaponammostock(var_1);
    var_7 = var_5 - var_6;
    var_8 = scripts\engine\utility::ter_op(var_7 >= var_3, var_6 + var_3, var_5);
    var_0 setweaponammostock(var_1, var_8);
  }

  var_9 = var_0 getweaponammoclip(var_1, var_2);
  var_10 = var_3 - var_9;
  var_11 = min(var_9 + var_10, var_3);
  var_0 setweaponammoclip(var_1, int(var_11), var_2);
}

test_ammo_crate(var_0) {
  var_0 thread watch_dpad();
  var_0 notify("_encstr_A13E0A73CAEEAFC1F6BBB2C9", "_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67");
  scripts\cp\utility::set_crafted_inventory_item("_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67", ::give_crafted_ammo_crate, var_0);
}

give_crafted_ammo_crate(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("_encstr_A13E0A73CAEEAFC1F6BBB2C9", "_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67");
  scripts\cp\utility::set_crafted_inventory_item("_encstr_95C81377364865C02D0BFF21F53B17C30A083BDA67", ::give_crafted_ammo_crate, var_1);
}

watch_dpad() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8A1F0E932BD6EDB3B2AF9B5937479C97");
  self notify("_encstr_AF3213D3968133BB1FB8939AA0C7B3E7DBF6504D2E");
  self endon("_encstr_AF3213D3968133BB1FB8939AA0C7B3E7DBF6504D2E");
  self notifyonplayercommand("_encstr_82430F72B539A4808DF3A10F85263922E8", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");

  for(;;) {
    self waittill("_encstr_82430F72B539A4808DF3A10F85263922E8");

    if(istrue(self.iscarrying)) {
      continue;
    }
    if(istrue(self.linked_to_coaster)) {
      continue;
    }
    if(isDefined(self.allow_carry) && self.allow_carry == 0) {
      continue;
    }
    if(scripts\cp\utility::is_valid_player()) {
      break;
    }
  }
}