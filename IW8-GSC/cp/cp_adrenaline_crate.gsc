/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_adrenaline_crate.gsc
***********************************************/

adrenaline_crate_init() {
  var_0 = spawnStruct();
  var_0.id = "_encstr_B18B0B578C23412DAE3A487842";
  var_0.weaponinfo = "_encstr_9508192DEE707DB0239CB273851B2DDCCAF5B658C9DA9539D7B1C1";
  var_0.modelbase = "_encstr_B14616C0DA2711E973B47864858F93E30A2348D013FEA782";
  var_0.hintstring = &"_encstr_83D01ED0F4A741F5A14914191529C9A3971444A42AC9829852278AFA1514A515";
  var_0.streakname = "_encstr_B18B0B578C23412DAE3A487842";
  var_0.splashname = "_encstr_87C7111F2F75829F201BB2BA7093FC895EBFB3";
  var_0.shadername = "_encstr_A2A021367BD61C583737AFF6989AC17BA537A3D7232B0EC6DE5EAF33394B59CD8C8D2F";
  var_0.headicon = "_encstr_A1ED1AD8039FD15DA2B31530CCBA5FB837FF38A0FB794B3BBB9C9425";
  var_0.headiconoffset = 20;
  var_0.lifespan = 90.0;
  var_0.usexp = 50;
  var_0.onusesfx = "_encstr_A3C80F4AF0E9DFB1709519F44369C36705";
  var_0.deployedsfx = "_encstr_A3C80F4AF0E9DFB1709519F44369C36705";
  var_0.deathvfx = loadfx("_encstr_AD6133D68CB3F66AD7A20F0FB7BDEFDDF350CD1C63F068D6A3135978723B50A6C021CF8D8B51E80FB68BCB13C891F32673C08651E3");
  var_0.onusecallback = ::adrenalinebox_onusedeployable;
  var_0.canusecallback = ::adrenalinebox_canusedeployable;
  var_0.deployfunc = ::adrenalinebox_onusedeployable;
  var_0.usetime = 1000;
  var_0.maxhealth = 100;
  var_0.maxuses = 4;
  var_0.canreusebox = 0;
  var_0.allowmeleedamage = 1;
  var_0.damagefeedback = "_encstr_B40101";
  var_0.grenadeusefunc = ::supportbox_grenadelaunchfunc;
  var_0.ondeploycallback = scripts\cp\cp_deployablebox::supportbox_ondeploy;
  var_0.deployanimduration = scripts\cp\cp_deployablebox::supportbox_getdeployanimduration();
  level.boxsettings["_encstr_B18B0B578C23412DAE3A487842"] = var_0;
  level.deployable_box["_encstr_B18B0B578C23412DAE3A487842"] = [];
}

weaponswitchendedsupportbox(var_0, var_1) {
  if(istrue(var_1))
    thread supportbox_watchplayerweapon(var_0);
}

tryusesupportbox(var_0, var_1) {
  return 1;
}

adrenalinebox_canusedeployable(var_0) {
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

adrenalinebox_onusedeployable(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread give_auto_revive();
  self setclientomnvar("_encstr_8C910F25C4697F39FC1379E8E71E70BD12", 1);
}

give_adrenaline_for_time(var_0) {
  var_1 = self.perk_data["_encstr_939F1253D0677DFD2FACB3028159CFBF711CA1DB"];
  self.perk_data["_encstr_939F1253D0677DFD2FACB3028159CFBF711CA1DB"] = 5;
  scripts\cp\utility::giveperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  scripts\cp\utility::giveperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
  scripts\cp\utility::giveperk("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8");
  scripts\cp\utility::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  scripts\cp\utility::giveperk("_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392");
  scripts\cp\utility::giveperk("_encstr_914F16A370BF7614A9F38B9F993B399B21980493A0CF2045");
  scripts\cp\utility::giveperk("_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858");
  scripts\cp\cp_visionsets::add_visionset_to_stack(self, "_encstr_AD930C77295BBA8619118F52E9D8", 2);
  self lerpfovbypreset("_encstr_82300B7081FA4BE6E6D10BB9E8");
  wait(var_0);
  self.perk_data["_encstr_939F1253D0677DFD2FACB3028159CFBF711CA1DB"] = var_1;
  scripts\cp\utility::_unsetperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
  scripts\cp\utility::_unsetperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  scripts\cp\utility::_unsetperk("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8");
  scripts\cp\utility::_unsetperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  scripts\cp\utility::_unsetperk("_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392");
  scripts\cp\utility::_unsetperk("_encstr_914F16A370BF7614A9F38B9F993B399B21980493A0CF2045");
  scripts\cp\utility::_unsetperk("_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858");
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
  scripts\cp\cp_visionsets::remove_visionset_specific_from_stack(self, "_encstr_AD930C77295BBA8619118F52E9D8", 2);
}

give_auto_revive() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.has_auto_revive = 1;
  self waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  wait 0.1;

  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    scripts\cp\cp_laststand::instant_revive(self);

    if(isDefined(self.dogtag))
      self.dogtag delete();
  }

  self.has_auto_revive = 0;
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