/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\airdrop_cp.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_873B147E08B0443BA0F13FD721D572A8A811FC05A0D8", ::airdrop_airdropmultipleinit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_A2DD124ECA9DB4CDD1569CD4B1EDC9CA4ADC33B7", ::airdrop_registerscoreinfo);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_855012A6C7EA4BFBE41F1071FF1C708FA2E2952D", ::airdrop_registeractionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_87DE11570791851DCA552914E4BDCE93B2379B", ::airdrop_updateuiprogress);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549", ::airdrop_allowactionset);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_81BC1FDD06A3C197ADBA30A0D24E773873B9665B6FABECF316435008EB553F718F", ::airdrop_unresolvedcollisionnearestnode);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_B485117F6118DBED30D34D122C500353E787AF", ::airdrop_showerrormessage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_A1C61066D3304A728AFB93ABF73DDB95E8B8", ::airdrop_awardkillstreak);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BD53157A9377DBFB98D8730770938DE2D7A602358FB7E2", ::airdrop_showkillstreaksplash);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BDEC10D7BDF951795318BFE3516922EAA34E", ::airdrop_gettargetmarker);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8E211A852D4E4627DBC1A65D631D961CB1AC2239DE83A1C916472BE6", ::airdrop_airdropmultipledropcrates);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80", ::airdrop_registercrateforcleanup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_951314597E0CC5D797BE4B1DBB53C215A11645D00B90", ::airdrop_makeweaponfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8B5212D6C2B656923A56D68C39EDADD0E42C3AB2", ::airdrop_makeitemfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA", ::airdrop_outlinedisable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_ACF51385FEB7159F8357EFA593835831C06FC7457A", ::airdrop_br_forcegiveweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_AA1C1936160EA3AEE456C4DBDBA3860B6C3459860BC6D8C4B08D6D", ::airdrop_capturelootcachecallback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_91A61B03A31C80F1738B3BE3F21F3A916D079F9F5D3F214823F0502BBB", ::airdrop_iskillstreakblockedforbots);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_A1EA19D07FB4945FB4F491A94ACB65D909F7D190EB68E8159B9F9D", ::airdrop_botiskillstreaksupported);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_B2061DE7CDF3672EAB40B0AA7083EAF389A6619E53B9CF325B203A1030C95E", ::airdrop_getgamemodespecificcratedata);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_AC0B185773E206F0A1DDA5F9028D094E1AA383DFDF685688ECF7", ::br_challenges);
  level.crate_random_weapons = ["_encstr_A63D1371A22C38F00B2FB7ABEF73C8F8C7FED8431B", "_encstr_923E13B5027510D0B3A9BBE152FB9850C1691F83E8", "_encstr_83BC122A7EC8FFE5D1C95B7210F1DD43066FA5A7", "_encstr_9A671346F2E847E8A369E4FBD95B10224F63A8B352", "_encstr_8F3214BE124A5768F407C840E728A09DC1BFA7B1AED3", "_encstr_8BBC121E4283D8E723B1F0784A7AAFB0F7FFBE2F", "_encstr_BD3E144CE436DBBDE8EBEE95B083B7B9BEA1DA9819C4", "_encstr_9330145A33493F5D282FEFC56B3065737888E223323B", "_encstr_95BC12264E63DEF68E7D77AC2C07F6DCF5D6891A", "_encstr_917D111339D8B77BE87DEE595807BD37D7B6A1", "_encstr_8B1913C3D8C03FA2B1F0BB37C7617AF64ED8220E62", "_encstr_AFED1592D660573D0921A39AC859751B7E31191A61688B", "_encstr_97BC12312763DBBD1D7DDDAC0B07B79BF5B5D80F", "_encstr_A1BC1298271BDE7B47D777595883B7E6BEB683A6", "_encstr_ABBC1231C9C6EDF61DF5EE590B077B37FAD60EDC", "_encstr_97BC12312763DBBD1D7DDDAC0B07B79BF5C14E06", "_encstr_83BC122A7EC8FFE5D1C95B7210F1DD4306E7BBAD", "_encstr_9A2B15C2703905675B60BFA507A31F0D37F8FB1B08E7BD", "_encstr_A1BF1398271BDE7B47D777595883B7E6BE389946C0"];
}

initcpcratedata() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_850703B7D9");
  var_0.capturestring = &"_encstr_AB3D0CCD21FA16C320FDB9B02715";
  var_0.enemymodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -10000;
  var_0.timeout = undefined;
  var_0.activatecallback = ::cpcrateactivatecallback;
  var_0.capturecallback = ::cpcratecapturecallback;
}

getcpcratedatabytype(var_0) {
  var_1 = spawnStruct();
  var_1.type = var_0;
  return var_1;
}

cpcrateactivatecallback(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80")]](self);
  }
}

cpcratecapturecallback(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_91651315562FDFA84C43777B8FE8E85986237123A5"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_91651315562FDFA84C43777B8FE8E85986237123A5")]](var_0);

  var_0[[level.custom_giveloadout]](0);
}

initcparmsraceemptycrate() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_852812B11C7D5839AD6E932C8D2BBED893C2472B");
  var_0.capturestring = "_encstr_B40101";
  var_0.enemymodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -10000;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 1;
  var_0.hasnointeraction = 1;
  var_0.activatecallback = undefined;
  var_0.capturecallback = undefined;
  var_0.destroyoncapture = 0;
  var_0.onecaptureperplayer = 0;
}

teleport_reference_silo() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_AD91137F1140CB8D78308B52A990C351266DFFBB93");
  var_0.capturestring = &"_encstr_AB3D0CCD21FA16C320FDB9B02715";
  var_0.enemymodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = "_encstr_8AAF25786B27FF68C73F60F068E751414112F8A0123A1143B759FAC8E31FFB1BF21A30107A577B";
  var_0.usepriority = -10000;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 1;
  var_0.activatecallback = ::cploadoutcrateactivatecallback;
  var_0.capturecallback = ::indanger;
  var_0.destroyoncapture = 0;
  var_0.onecaptureperplayer = 1;
}

indanger(var_0) {
  if(istrue(var_0.inlaststand)) {
    return;
  }
  if(!isDefined(self.numuses))
    self.numuses = 0;

  if(!isDefined(self.playersused))
    self.playersused = [];

  self.playersused[self.playersused.size] = var_0;
  var_0 scripts\cp\cp_ammo_crate::give_ammo_to_player_through_crate();
  scripts\cp\cp_armor::givearmor(var_0, 100, 1);
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(weapontype(var_3) == "_encstr_96390B3F9BB7FCA569EBAB6AD5") {
      if(var_3.basename == "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0") {
        if(var_0.gl_proj_override == "_encstr_8D7609A4F337C2C9C2BDB7")
          continue;
      }

      var_4 = weaponclipsize(var_3);
      var_0 givemaxammo(var_3);
    }
  }

  foreach(var_7 in var_0.powers) {
    if(var_7.charges < var_7.maxcharges)
      var_8 = 0;
  }

  thread scripts\cp\cp_grenade_crate::refill_grenades(var_0);
  var_0 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
  self.numuses++;

  if(self.numuses >= level.players.size) {
    if(isDefined(self.outlines)) {
      foreach(var_11 in self.outlines) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_11, self);
      }
    }

    thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

initcploadoutcratedata() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_8B8E0B66CA6E640F9BB86D90AC");
  var_0.capturestring = &"_encstr_9B8C1EB6C5E0B1E64F0791D997B05C4B29653EAB2E88D7ED6F2B79E1C3F73729";
  var_0.enemymodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -10000;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 1;
  var_0.activatecallback = ::cploadoutcrateactivatecallback;
  var_0.capturecallback = ::cploadoutcratecapturecallback;
  var_0.destroyoncapture = 0;
  var_0.onecaptureperplayer = 1;
}

toggle_ambient_vehicles_on_module() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_8C2911AA53EDAB3EC8A317EE3788022F8D69E3");
  var_0.capturestring = &"_encstr_8D8F1609A3E03F3238792F01354B4547F132632884708E79";
  var_0.enemymodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = "_encstr_8AAF25786B27FF68C73F60F068E751414112F8A0123A1143B759FAC8E31FFB1BF21A30107A577B";
  var_0.usepriority = -10000;
  var_0.timeout = 90;
  var_0.friendlyuseonly = 1;
  var_0.activatecallback = ::infectbonusscore;
  var_0.capturecallback = ::infectbonussuperonspawn;
  var_0.destroyoncapture = 0;
  var_0.onecaptureperplayer = 0;
  var_0.setplayerbeingrevivedextrainfo = 55;
  var_0.heliheightoffset = 12000;
}

teleport_room_doors() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_87141136F8F7C34F4DFAA3D0B3690F9B67844D");
  var_0.capturestring = &"_encstr_954E29E0DF78CB0B9157A4AF9DF1C52B0A95781944548772C279A94B93C9DA57206D81100F8847FA9911A5";
  var_0.enemymodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = "_encstr_8AAF25786B27FF68C73F60F068E751414112F8A0123A1143B759FAC8E31FFB1BF21A30107A577B";
  var_0.usepriority = -10000;
  var_0.timeout = 99999;
  var_0.friendlyuseonly = 1;
  var_0.activatecallback = ::cploadoutcrateactivatecallback;
  var_0.capturecallback = ::infectbonussuperontacinsert;
  var_0.destroyoncapture = 1;
  var_0.onecaptureperplayer = 0;
}

infectbonusscore(var_0) {
  thread scripts\cp_mp\killstreaks\airdrop::infilweaponraise();

  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80")]](self);
  }

  if(!isDefined(self.angles))
    self.angles = (0, 0, 0);
}

infectbonussuperontacinsert(var_0) {
  [[level._id_12D8C]](var_0);
}

infectbonussuperonspawn(var_0) {
  if(istrue(var_0.inlaststand)) {
    return;
  }
  if(!isDefined(self.numuses))
    self.numuses = 0;

  if(!isDefined(self.playersused))
    self.playersused = [];

  self.playersused[self.playersused.size] = var_0;

  if(isDefined(self.intro_techos_deposit_backseats)) {
    self thread[[self.intro_techos_deposit_backseats]](var_0);
    return;
  }

  if(!istrue(level.little_bird_mg_cp_onexitvehicle))
    var_0 scripts\cp\cp_ammo_crate::give_ammo_to_player_through_crate();

  scripts\cp\cp_armor::givearmor(var_0, 100, 1);
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(weapontype(var_3) == "_encstr_96390B3F9BB7FCA569EBAB6AD5") {
      if(var_3.basename == "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0") {
        if(var_0.gl_proj_override == "_encstr_8D7609A4F337C2C9C2BDB7")
          continue;
      }

      var_4 = weaponclipsize(var_3);
      var_0 givemaxammo(var_3);
    }
  }

  foreach(var_7 in var_0.powers) {
    if(var_7.charges < var_7.maxcharges)
      var_8 = 0;
  }

  thread scripts\cp\cp_grenade_crate::refill_grenades(var_0);
  var_0 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
  var_10 = ["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", "_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_B8840F126B9D8FF218872D21B7C03CC3CD", "_encstr_ACD20F4B118BEF03D380F9335815BC7761"];

  if(isDefined(self._id_129F9))
    var_10 = self._id_129F9;

  var_11 = scripts\engine\utility::random(var_10);
  var_12 = undefined;
  var_13 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_8D0B0F2DB9D9ACCD47DE39BC9AB1ED3A9B", "_encstr_96500B3AEDA3B0363563DE1DCD");

  if(var_13 < 4)
    var_12 = var_13;
  else
    var_12 = var_0.dpad_selection_index - 1;

  var_14 = scripts\cp\loot_system::get_empty_munition_slot(var_0);

  if(isDefined(var_14))
    var_12 = var_14;
  else {
    var_0 scripts\cp\utility::hint_prompt("_encstr_B6A9145BAE37D2A396B7B97DDC63DB1D9BBE33BA1B1B", 1, 2);
    return;
  }

  if(var_11 == "_encstr_AB8E0E73E9709BD298E7141D95E8DF43")
    var_0 scripts\cp\loot_system::try_give_munition_to_slot(var_11, var_12, "_encstr_AB8E0E73E9709BD298E7141D95E8DF43");
  else
    var_0 scripts\cp\loot_system::try_give_munition_to_slot(var_11, var_12);

  self.numuses++;

  if(self.numuses >= level.players.size) {
    if(isDefined(self.outlines)) {
      foreach(var_16 in self.outlines) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_16, self);
      }
    }

    thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

cploadoutcrateactivatecallback(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80")]](self);
  }
}

cploadoutcratecapturecallback(var_0) {
  if(!isDefined(self.numuses))
    self.numuses = 0;

  if(!isDefined(self.playersused))
    self.playersused = [];

  self.playersused[self.playersused.size] = var_0;

  if(!scripts\cp\cp_endgame::gamealreadyended())
    var_0 setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 2);

  self.numuses++;

  if(self.numuses >= level.players.size) {
    if(isDefined(self.outlines)) {
      foreach(var_2 in self.outlines) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_2, self);
      }
    }

    thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

airdrop_airdropmultipleinit() {
  scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_init();
}

airdrop_registerscoreinfo() {}

airdrop_registeractionset() {
  var_0 = getdvarint("_encstr_A5CD173B8E2AA1EFF2A3F99D3F8B3808C3E72633B7619090DA", 1);

  if(var_0)
    scripts\mp\playeractions::registeractionset("_encstr_828C09996A99584D51C7DB", ["_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_88780599B4E495", "_encstr_A6C7065BACB1CA95", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220"]);
  else
    scripts\mp\playeractions::registeractionset("_encstr_828C09996A99584D51C7DB", ["_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_AC20072B9FA9487832", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220"]);
}

airdrop_updateuiprogress(var_0, var_1) {
  if(!scripts\cp\utility::turn_off_sniper_laser() && !scripts\cp\utility::tryingtoleave())
    updateuiprogress(var_0, var_1);
}

updateuiprogress(var_0, var_1) {
  if(!isDefined(level.hostmigrationtimer)) {
    if(isDefined(var_0.interactteam) && var_0.interactteam == "_encstr_8BBA05185F8B99") {
      self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
      return;
    }

    var_2 = undefined;

    if(isDefined(var_0.objidnum))
      var_2 = var_0.objidnum;

    var_3 = 0;

    if(isDefined(var_0.teamprogress) && isDefined(var_0.claimteam)) {
      if(var_0.teamprogress[var_0.claimteam] > var_0.usetime)
        var_0.teamprogress[var_0.claimteam] = var_0.usetime;

      var_3 = var_0.teamprogress[var_0.claimteam] / var_0.usetime;
    } else {
      if(var_0.curprogress > var_0.usetime)
        var_0.curprogress = var_0.usetime;

      var_3 = var_0.curprogress / var_0.usetime;

      if(var_0.usetime <= 1000)
        var_3 = min(var_3 + 0.05, 1);
      else
        var_3 = min(var_3 + 0.01, 1);
    }

    if(isDefined(var_0.id)) {
      var_4 = 0;

      switch (var_0.id) {
        case "_encstr_BAE50DE60E739BA638C72068AF47B9":
          var_4 = 1;
          break;
        case "_encstr_A98F06181E4BCA85":
          var_4 = 2;
          break;
        case "_encstr_992E0C97A7734F7BF29B66D945D0":
          var_4 = 3;
          break;
        case "_encstr_AFA1181B75302922131A765909619B2951DBD555E9071BFFC59F":
          var_4 = 4;
          break;
        case "_encstr_AB19049D0FC0":
          var_4 = 8;
          break;
      }

      updateuisecuring(var_3, var_1, var_4, var_0, var_0.usetime);
    }
  }
}

isrevivetrigger() {
  if(isDefined(self.id) && self.id == "_encstr_9A43124032FAC143E35908750F93C99D24EBB038")
    return 1;

  return 0;
}

existinarray(var_0, var_1) {
  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(var_3 == var_0)
        return 1;
    }
  }

  return 0;
}

updateuisecuring(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(var_1) {
    if(!isDefined(var_3.usedby))
      var_3.usedby = [];

    if(!isDefined(self.migrationcapturereset))
      var_3 thread migrationcapturereset(self);

    if(!existinarray(self, var_3.usedby))
      var_3.usedby[var_3.usedby.size] = self;

    if(!isDefined(self.ui_securing)) {
      self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", var_2);
      self.ui_securing = 1;

      if(isDefined(var_3.trigger) && var_3.trigger isrevivetrigger()) {
        if(isDefined(var_3.trigger.owner)) {
          var_3.trigger.owner setclientomnvar("_encstr_ADFC0EEB491FDE8F28B12E6FAE1160AC", self getentitynumber());
          var_3.trigger.owner setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 6);
        }
      }
    }
  } else {
    if(isDefined(var_3.usedby) && existinarray(self, var_3.usedby))
      var_3.usedby = scripts\engine\utility::array_remove(var_3.usedby, self);

    self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
    self.ui_securing = undefined;

    if(isDefined(var_3.trigger) && var_3.trigger isrevivetrigger()) {
      if(isDefined(var_3.trigger.owner)) {
        var_3.trigger.owner setclientomnvar("_encstr_ADFC0EEB491FDE8F28B12E6FAE1160AC", -1);
        var_3.trigger.owner setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
      }
    }

    var_0 = 0.01;

    if(isDefined(var_3.objidnum))
      var_5 = var_3.objidnum;
  }

  if(var_4 == 500)
    var_0 = min(var_0 + 0.15, 1);

  if(var_0 != 0) {
    self setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_0);

    if(isDefined(var_3.trigger) && var_3.trigger isrevivetrigger()) {
      if(isDefined(var_3.trigger.owner))
        var_3.trigger.owner setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_0);
    }

    if(isDefined(var_3.objidnum))
      scripts\mp\objidpoolmanager::objective_set_progress(var_3.objidnum, var_0);
  }
}

migrationcapturereset(var_0) {
  var_0.migrationcapturereset = 1;
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");

  if(!isDefined(var_0) || !isDefined(self)) {
    return;
  }
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  self.migrationcapturereset = undefined;
}

airdrop_allowactionset(var_0, var_1) {
  scripts\mp\playeractions::allowactionset(var_0, var_1);
}

airdrop_unresolvedcollisionnearestnode(var_0, var_1, var_2) {
  childthread scripts\cp\cp_movers::unresolved_collision_nearest_node(var_0, var_1, var_2);
}

airdrop_showerrormessage(var_0) {}

airdrop_awardkillstreak(var_0, var_1, var_2) {}

airdrop_showkillstreaksplash(var_0, var_1, var_2) {}

airdrop_gettargetmarker(var_0) {
  return scripts\cp\inventory\cp_target_marker::gettargetmarker(var_0);
}

airdrop_airdropmultipledropcrates(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(var_0, var_1, var_2, var_3, var_4);
}

airdrop_registercrateforcleanup(var_0) {}

airdrop_makeweaponfromcrate() {}

airdrop_makeitemfromcrate() {}

airdrop_outlinedisable(var_0, var_1) {
  scripts\cp\cp_outline_utility::outlinedisable(var_0, var_1);
}

airdrop_br_forcegiveweapon(var_0, var_1, var_2) {}

airdrop_capturelootcachecallback() {}

airdrop_iskillstreakblockedforbots(var_0) {}

airdrop_botiskillstreaksupported(var_0) {}

airdrop_getgamemodespecificcratedata() {
  initcpcratedata();
  initcploadoutcratedata();
  toggle_ambient_vehicles_on_module();
  initcparmsraceemptycrate();
  teleport_reference_silo();
  teleport_room_doors();
}

br_challenges() {
  if(!isPlayer(self))
    return 0;

  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self)
    return 0;

  return 1;
}

makeitemsfromcrate(var_0) {
  var_1 = self.data;

  if(var_1.type == "_encstr_AC20072B9FA9487832") {
    var_2 = randomintrange(2, 4);
    var_3 = 6 - var_2;
  } else if(var_1.type == "_encstr_B19A0BD803A4E10F42E50598BB") {
    var_2 = randomintrange(1, 2);
    var_3 = 6 - var_2;
  } else {}
}

createdropweapon(var_0, var_1, var_2, var_3, var_4) {}

managedroppedents() {
  if(!isDefined(level.droppedweapons))
    level.droppedweapons = [];

  if(level.droppedweapons.size > 63) {
    var_0 = [];

    for(var_1 = 0; var_1 < level.droppedweapons.size; var_1++) {
      if(var_1 < 16) {
        if(isDefined(level.droppedweapons[var_1])) {
          if(isDefined(level.droppedweapons[var_1].pickupent))
            level.droppedweapons[var_1].pickupent delete();

          level.droppedweapons[var_1] delete();
        }

        continue;
      }

      var_0[var_0.size] = level.droppedweapons[var_1];
    }

    level.droppedweapons = var_0;
  }
}