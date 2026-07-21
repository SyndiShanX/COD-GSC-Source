/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_grenade_crate.gsc
***********************************************/

grenade_crate_init() {
  var_0 = spawnStruct();
  var_0.id = "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38";
  var_0.weaponinfo = "_encstr_84E81558CF28E6D952A6C1D5FC290BE9CA07B018070B5B";
  var_0.modelbase = "_encstr_8D37213817EA59A9EEEB89D0D70723AB333AA03EEBC20FB2F707B8E0FB5F7B2BBBE726";
  var_0.hintstring = &"_encstr_8D9F1B0DD3F4417D8629148C5129721D798E29A89C8288A2D71582B48A";
  var_0.streakname = "_encstr_B4F80E295AADB87F924F5F2F3BEA3D38";
  var_0.splashname = "_encstr_87C7111F2F75829F201BB2BA7093FC895EBFB3";
  var_0.shadername = "_encstr_A2A021367BD61C583737AFF6989AC17BA537A3D7232B0EC6DE5EAF33394B59CD8C8D2F";
  var_0.headicon = "_encstr_AB5A1BA1CBB77650E6CC7B17C94EF0480FA2F9CBB2A73968BFB66B79E4";
  var_0.headiconoffset = 20;
  var_0.lifespan = 90.0;
  var_0.usexp = 50;
  var_0.onusesfx = "_encstr_A3C80F4AF0E9DFB1709519F44369C36705";
  var_0.deployedsfx = "_encstr_A3C80F4AF0E9DFB1709519F44369C36705";
  var_0.deathvfx = loadfx("_encstr_92994A67333C972DDD83CB1C27BD07CBCDB1C99607E885898DAC9BE567CC877D7B33990D583791F577ADAFB95D83E0F639A3137B1EBEB23C078DB737B4EC2B6EF54796B62BEDAB8E173B333C");
  var_0.onusecallback = ::healthbox_onusedeployable;
  var_0.canusecallback = ::healthbox_canusedeployable;
  var_0.deployfunc = ::healthbox_onusedeployable;
  var_0._id_120AA = "_encstr_922F1539B14DE8600392D3BB5A1B2EA0A904B1932EF480";
  var_0.usetime = 1000;
  var_0.maxhealth = 100;
  var_0.maxuses = 4;
  var_0.canreusebox = 0;
  var_0.allowmeleedamage = 1;
  var_0.damagefeedback = "_encstr_B40101";
  var_0.grenadeusefunc = ::healthbox_grenadelaunchfunc;
  var_0.ondeploycallback = scripts\cp\cp_deployablebox::supportbox_ondeploy;
  var_0.deployanimduration = scripts\cp\cp_deployablebox::supportbox_getdeployanimduration();
  level.boxsettings["_encstr_B4F80E295AADB87F924F5F2F3BEA3D38"] = var_0;
  level.deployable_box["_encstr_B4F80E295AADB87F924F5F2F3BEA3D38"] = [];
}

weaponswitchendedsupportbox(var_0, var_1) {
  if(istrue(var_1))
    thread supportbox_watchplayerweapon(var_0);
}

tryusesupportbox(var_0, var_1) {
  return 1;
}

healthbox_canusedeployable(var_0) {
  return 1;
}

healthbox_grenadelaunchfunc(var_0) {
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

healthbox_onusedeployable(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 1;
  var_2 = 1;
  var_3 = self getweaponslistprimaries();

  foreach(var_5 in var_3) {
    if(weapontype(var_5) == "_encstr_96390B3F9BB7FCA569EBAB6AD5") {
      if(var_5.basename == "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0") {
        if(self.gl_proj_override == "_encstr_8D7609A4F337C2C9C2BDB7")
          continue;
      }

      if(!_id_11B4A(var_5)) {
        var_2 = 0;
        self setweaponammoclip(var_5, weaponclipsize(var_5));
        self givemaxammo(var_5);
      }
    }

    if(var_5.inventorytype == "_encstr_B4DC085639F9C2779108" && isDefined(var_5.underbarrel) && var_5.underbarrel == "_encstr_BE9708CBAB13138857AD") {
      if(!_id_11B4A(var_5)) {
        var_2 = 0;
        self setweaponammoclip(var_5, weaponclipsize(var_5));
        self setweaponammostock(var_5, 0);
      }
    }
  }

  foreach(var_8 in self.powers) {
    if(var_8.charges < var_8.maxcharges)
      var_1 = 0;
  }

  if(var_1 && var_2) {
    scripts\cp\utility::hint_prompt("_encstr_95640D5BB00FEB9D27ACE60B32B2E6", 1, 3);
    return 0;
  }

  thread refill_grenades(self);
  return 1;
}

_id_11B4A(var_0) {
  var_1 = self getweaponammoclip(var_0);
  var_2 = self getweaponammostock(var_0);
  var_3 = weaponclipsize(var_0);
  var_4 = weaponmaxammo(var_0);

  if(var_2 < var_4 || var_1 < var_3)
    return 0;

  return 1;
}

refill_grenades(var_0) {
  var_0 notify("_encstr_B64D16535807C851130B6F7DB01FBC5FA309B6421E53B4FD");

  foreach(var_3, var_2 in var_0.powers) {
    var_0 notify("_encstr_A6790F2B71AFFB7F58FF5D24F75805DFC0", var_2.weaponuse);
    var_0 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
    waitframe();
  }
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