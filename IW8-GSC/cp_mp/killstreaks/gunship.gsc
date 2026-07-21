/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\gunship.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_86FD08B775CD07DC1338", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_86FD08B775CD07DC1338", "_encstr_88C5055208731B")]]();

  level._effect["_encstr_9A5007A9E5275F8ACA"] = loadfx("_encstr_8B7C3084124B4F036FB2FFC8E0AEFFF80C9906CB90C3AE276D7EB0CB6E69A7FF12B8F76B878FCBAFB3556D7752A758EE4153");
  level._effect["_encstr_BD270FB10BE3EE101438FFF55C7E88BDCF"] = loadfx("_encstr_87092B66FC2BB74CABD081A9CFD7F4B1238D505D82B50BE3078EA0805726297FB2FF8F3358BFC34D70B20D7AB9");
  level._effect["_encstr_810C0FAA9043CF5BA128F310D5EB8B17A5"] = loadfx("_encstr_AC403060B2C887F03FD0404170B678F335FAD0F84B2753C806A6D4C347E760D75EB2A8C8237EF70333CDE53D5593405D478B");
  level._effect["_encstr_885111303A75FB7BBF1FFE7737B3E0AB5F12A3"] = loadfx("_encstr_8E6D317CDFC31F104FD2D148DB3F682B2AC5768532CA4B184F9333D87F89A1D3A77AF8838A0137A3E7B3585877A81B355B97E3");
  level.cosine = [];
  level.cosine["_encstr_960703127A"] = cos(45);
  level.cosine["_encstr_B84C027E"] = cos(5);
  level.physicssphereradius["_encstr_88F90EF65F8E7A1AEED5251AE97F9788"] = 60;
  level.physicssphereradius["_encstr_88710EC26CC49918FA1A815BB5AFADC1"] = 600;
  level.physicssphereradius["_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"] = 1000;
  level.physicssphereforce["_encstr_88F90EF65F8E7A1AEED5251AE97F9788"] = 0;
  level.physicssphereforce["_encstr_88710EC26CC49918FA1A815BB5AFADC1"] = 3.0;
  level.physicssphereforce["_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"] = 6.0;
  level.weaponreloadtime["_encstr_88F90EF65F8E7A1AEED5251AE97F9788"] = 2;
  level.weaponreloadtime["_encstr_88710EC26CC49918FA1A815BB5AFADC1"] = 4;
  level.weaponreloadtime["_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"] = 6;
  level.gunship_speed["_encstr_ACA20538F84D39"] = 250;
  level.gunship_speed["_encstr_B4F507E4BD4785E856"] = 120;
  scripts\engine\utility::flag_init("_encstr_A93A1F6AC305183BE903B72B252F48ABA79EDFF5171B332D133F9032923F05A7BA");
  scripts\engine\utility::flag_set("_encstr_A93A1F6AC305183BE903B72B252F48ABA79EDFF5171B332D133F9032923F05A7BA");
  var_0 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = level.mapcenter;

  if(var_0.size) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_86FD08B775CD07DC1338", "_encstr_BA150EC95C66282EE2FBA7E38B7BF5C0"))
      var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_86FD08B775CD07DC1338", "_encstr_BA150EC95C66282EE2FBA7E38B7BF5C0")]](var_0[0].origin, var_0[1].origin);
  }

  level.gunship = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  level.gunship setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.gunship.angles = (0, 115, 0);
  level.gunship.owner = undefined;
  level.gunship.thermal_vision = "_encstr_B1251107DB7EDBA1118B90F0C3B53B886F4D17";
  level.gunship.enhanced_vision = "_encstr_A13E120BC66299C0F52B37A185B9D85646FA6B07";
  level.gunship.targetname = "_encstr_BEF2169E18534A1028AB48C963486B20F3E5A103C7CB7858";
  level.gunship hide();
  level.gunshipinuse = 0;
  level.gunship.deployweaponobj = getcompleteweaponname("_encstr_A18315B30F0132D10B889B42C7798B6D13B3279B969960");
  thread rotateplane("_encstr_AB0703DBB9");
  scripts\mp\playeractions::registeractionset("_encstr_885D0DCEBA37DCD0D21CA4DCE8C9DE", ["_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220", "_encstr_8F0508CE59DCA357392B", "_encstr_88780599B4E495", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_B8840F32A81197F3C9E32F3E9B303FCB45", "_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_8CF40B9B3BFD1849BB9CC8C6B4"]);
  scripts\mp\playeractions::registeractionset("_encstr_86010B6750307382DB3743C295", ["_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220", "_encstr_8F0508CE59DCA357392B", "_encstr_B8840F32A81197F3C9E32F3E9B303FCB45", "_encstr_8CF40B9B3BFD1849BB9CC8C6B4"]);
  level.gunshipqueue = [];
  init_gunship_intro_anims();
  init_gunship_vo();
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("_encstr_86FD08B775CD07DC1338", "_encstr_AB0703DBB9", 9);
}

weapongivengunship(var_0) {
  return 1;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_gunship_intro_anims() {
  level.scr_animtree["_encstr_86FD08B775CD07DC1338"] = #animtree;
  level.scr_anim["_encstr_86FD08B775CD07DC1338"]["_encstr_A66F0ED43B8287503193B10883446BC7"] = % _encstr_84E3159A43E0D78E18A31A1CABA8C256BF5E52326BCEB7;
  level.scr_animname["_encstr_86FD08B775CD07DC1338"]["_encstr_A66F0ED43B8287503193B10883446BC7"] = "_encstr_84E3159A43E0D78E18A31A1CABA8C256BF5E52326BCEB7";
  level.scr_anim["_encstr_86FD08B775CD07DC1338"]["_encstr_BA7C12FC13AAAF4829FBC9609B6C43DF01BEE1FD"] = % _encstr_8E4119D6E0D70BD834C2E436D29526CC037DA5731D27EDD758363A;
  level.scr_animname["_encstr_86FD08B775CD07DC1338"]["_encstr_BA7C12FC13AAAF4829FBC9609B6C43DF01BEE1FD"] = "_encstr_8E4119D6E0D70BD834C2E436D29526CC037DA5731D27EDD758363A";
  level.scr_anim["_encstr_86FD08B775CD07DC1338"]["_encstr_BD17135F485D3B64AC2BE608400B183FFF4C6D6D4F"] = % _encstr_8341199D3A771EE610C23DA9D7E75F9613BFB45AC3CA17BF7FCD61;
  level.scr_animname["_encstr_86FD08B775CD07DC1338"]["_encstr_BD17135F485D3B64AC2BE608400B183FFF4C6D6D4F"] = "_encstr_8341199D3A771EE610C23DA9D7E75F9613BFB45AC3CA17BF7FCD61";
  level.scr_anim["_encstr_86FD08B775CD07DC1338"]["_encstr_AFB10E76ABCD6ED0D2E0FA322B85D1D0"] = % _encstr_9BC315E5BF6E07A6A9784BA2109B0AF62BB074655F536B;
  level.scr_animname["_encstr_86FD08B775CD07DC1338"]["_encstr_AFB10E76ABCD6ED0D2E0FA322B85D1D0"] = "_encstr_9BC315E5BF6E07A6A9784BA2109B0AF62BB074655F536B";
  level.gunship_crashanimlength = getanimlength(level.scr_anim["_encstr_86FD08B775CD07DC1338"]["_encstr_AFB10E76ABCD6ED0D2E0FA322B85D1D0"]);
}

init_gunship_vo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8A110F9FE0C832C910ABB9D7686A51A72D"] = "_encstr_8A110F9FE0C832C910ABB9D7686A51A72D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF6F17FC3DAA975488A1010BA0B58CB181C016A932A39B2DC9"] = "_encstr_B4A41D789BB88E531712AFC33918E8EA80F141B802C379FF4B1B2D93D39013";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF13161873BDCF20974890F125EBEBA3A9BB18D0FBD32B79"] = "_encstr_93D31C787B8317984898E6C08558C51F51CD2B703F23CFE610385BEB632C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B13611978FBAE62001729E915DFFB808326739"] = "_encstr_85910C5F3D55BBF8B818DF0BF833";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D8B105837C8E7FC9AB25F1871FB067032FB"] = "_encstr_921D0DDFC5284B1922608F9D6BB35B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B4951CD16B838E7074589FF171DCB0D87F2149997217CC40812CFBDF90C3"] = "_encstr_8A801BF820CAAFB3599721D16B9B5F8FE74752FF726EC1B158E8DFD697";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BDE81D71CB232ED0D4F83F9111BC1078DFC1A939D2776CE061CD43B9316348"] = "_encstr_85801B9DAB9B6E86A5C1EB32B0B558D959AF9C952C36E8D27BE6F59981";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD271CB10BE3EE101438FFD151FC50389F0169F912372CA0A10883F36EA0"] = "_encstr_A3801BCEAECD9B1A5A38D78C585B0BD959D739CA16368EB4DEE6FA6818";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ABE8153B38058B547B038EEDCCAF1B3AA993BFC5ED6682"] = "_encstr_ABE8153B38058B547B038EEDCCAF1B3AA993BFC5ED6682";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD270FB10BE3EE101438FFF55C7E88BDCF"] = "_encstr_A62F168FED856B0848E80FCB8823F692611057C55FE5425B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AFBE17D9D537DC43D2C1BE130C4DADDAD7E495D87B588CB2C8"] = "_encstr_8AC015C97B46B01BA2FBFFADC79AD078E459BBABF3BD88";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAA316172040E3124BA771A3AF1B1A87ABD8B3AF28B92D1A"] = "_encstr_918D149D5DDCB9345AC1FAE4B263B716467D68066BB5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_821216ECAECDB9A1B41CEB19D4D65BEB9C2BB1BDC2C8B232"] = "_encstr_9B9C140773A0A3F8C08BA9EAC163375A0D8FEAC6DB59";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AABE116803CDBF50C718C0C6F20FFB71F45AF0"] = "_encstr_BD030EBF6D181FD41B40498238634A2B";
}

tryusegunship() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_86FD08B775CD07DC1338", self);
  return tryusegunshipfromstruct(var_0);
}

tryusegunshipfromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361")]](self, "_encstr_9BB5154F0EC76772DC592A20AB039518AC1F0229871602");

  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, ::weapongivengunship);

  if(!istrue(var_1))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      return 0;
    }
  }

  if(istrue(level.gunshipinuse)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");

    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  if(level.gameended) {
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  var_2 = gunship_startuse(self, var_0);

  if(!istrue(var_2))
    return 0;

  return var_2;
}

gunship_monitormanualplayerexit(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_99CC1EFA6008DF6BF748AF2BD457D995CE05C3E9AA98AB22E88B217B088B128B"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_99CC1EFA6008DF6BF748AF2BD457D995CE05C3E9AA98AB22E88B217B088B128B")]]();

  self waittill("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  thread gunship_leave(var_0);
}

gunship_startuse(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.gunshipplayer))
    return 0;

  var_2 = randomint(360);
  var_3 = 9000;
  var_4 = cos(var_2) * var_3;
  var_5 = sin(var_2) * var_3;
  var_6 = 8000;
  var_7 = vectorNormalize((var_4, var_5, var_6));
  var_7 = var_7 * var_6;
  level.gunshipinuse = 1;

  if(scripts\common\utility::iscp())
    var_0.start_position = var_0.origin;

  var_8 = gunship_playintro(var_0, var_1, var_2, var_7);

  if(!isDefined(var_8) || var_8 == 0) {
    level.gunshipinuse = 0;
    return 0;
  }

  var_9 = gunship_spawn(var_0, var_1, var_2, var_7);

  if(!isDefined(var_9)) {
    level.gunshipinuse = 0;
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_8B180D9FD0E134A197E5FDB243538B", var_0);

  if(getdvarint("_encstr_82570B397A4D3192935192A562")) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B807125285B0A9B80472F441202DC7F76301A797"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B807125285B0A9B80472F441202DC7F76301A797")]](0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_9.streakinfo.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0);

  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(var_9, ::gunship_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(var_9, ::gunship_lockedonremovedcallback);
  var_9 thread gunship_attachgunner(var_0);
  var_9 thread gunship_watchchangeweapons(var_0);
  var_9 thread gunship_watchweaponfired(var_0);
  var_9 thread gunship_watchthermaltoggle(var_0);
  var_9 thread gunship_watchdamage(var_0);
  var_9 thread gunship_watchtimeout(var_0);
  var_9 thread set_up_coop_push(var_0);
  var_9 thread set_up_pilots(var_0, "_encstr_8D820B49520F0EC02DDE6367EC");
  var_9 thread set_up_pilots(var_0, "_encstr_81170C244F9CBDE72C01BB99A298");
  var_9 thread set_up_pilots(var_0, "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  var_9 thread set_up_pilots(var_0, "_encstr_835E111B0F57AAF772B2857B91972DCBC070DA");
  var_9 thread gunship_watchendgame(var_0);
  var_9 thread gunship_playpilotfx(var_0);
  var_9 thread gunship_linklightfxent();
  var_9 thread gunship_linkwingfxents();
  var_9 thread gunship_monitormanualplayerexit(var_0);
  var_9 thread gunship_trackvelocity(var_0);
  var_9 thread gunship_watchtargets(var_0);
  var_9 thread gunship_watchkills(var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4"))
    var_9 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4")]](::gunship_handlemissiledetection);

  var_9 playLoopSound("_encstr_9AD91096EE07AFD6B9F5166C896603AF3683");
  return 1;
}

gunship_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_ABE8153B38058B547B038EEDCCAF1B3AA993BFC5ED6682");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", self.owner, "_encstr_85CE0B9770B02C73A1760F06D2");
}

gunship_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", self.owner, "_encstr_85CE0B9770B02C73A1760F06D2");
}

gunship_playintro(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 disablephysicaldepthoffieldscripting();
  var_0 gunship_allowstances(0);
  var_4 = 0;

  if(!var_4) {
    var_0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var_0 scripts\mp\playeractions::allowactionset("_encstr_885D0DCEBA37DCD0D21CA4DCE8C9DE", 0);
  }

  var_5 = "_encstr_A66F0ED43B8287503193B10883446BC7";
  var_7 = level.scr_anim[var_1.streakname][var_5];
  var_8 = getanimlength(var_7);

  if(gunship_islargemap()) {
    if(level.gametype == "_encstr_B81904B04E6B") {
      if(isDefined(level.hqmidpoint))
        level.gunship.origin = level.hqmidpoint;
    } else if(isDefined(level.set_up_blockade_gate_anims))
      level.gunship.origin = level.set_up_blockade_gate_anims;
    else
      level.gunship.origin = var_0.origin;
  }

  var_9 = "_encstr_990B1C90532CF2E013E390766B4B32295251A22EDAB04B7291E62F9F07DA";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0))
    var_9 = "_encstr_AB902174699CD92047B045DF89932839F08EE382A548F097711B8AAF1A53089B46E888";

  level.gunship_intromodel = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.gunship.origin);
  level.gunship_intromodel setModel(var_9);
  level.gunship_intromodel.angles = level.gunship.angles;
  level.gunship_intromodel setotherent(var_0);
  level.gunship_intromodel.animname = var_1.streakname;
  level.gunship_intromodel.owner = var_0;

  if(!var_4) {
    foreach(var_11 in level.players) {
      if(var_11 != var_0)
        level.gunship_intromodel hidefromplayer(var_11);
    }

    level.gunship_intromodel thread gunship_hideintromodelonplayerconnect();
  }

  var_13 = 2000;

  switch (level.mapname) {
    case "_encstr_99020BB0027F38974BA78783FF":
    case "_encstr_BDFF088922C9FF1946BF":
      var_13 = 500;
      break;
  }

  level.gunship_intromodel linkTo(level.gunship, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_3 - (0, 0, var_13), (0, var_2 + 90, 0));
  level.gunship_intromodel thread set_up_minigun("_encstr_8D820B49520F0EC02DDE6367EC", var_1);
  level.gunship_intromodel thread set_up_minigun("_encstr_81170C244F9CBDE72C01BB99A298", var_1);
  level.gunship_intromodel thread set_up_minigun("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", var_1);
  waitframe();

  if(!isDefined(level.gunship_intromodel))
    return 0;

  level.gunship_intromodel scripts\common\anim::setanimtree();
  level.gunship_intromodel.scenenode = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.gunship_intromodel.origin);
  level.gunship_intromodel.scenenode.angles = level.gunship_intromodel.angles;
  level.gunship_intromodel.scenenode setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.gunship_intromodel playsoundtoplayer("_encstr_8FA413636F3718E0B311E1B992DB72509AA3C1DDF7", var_0);

  if(!var_4) {
    var_0 cameralinkTo(level.gunship_intromodel, "_encstr_8E010B996FB7B6B3C1D1183343", 0, 1);
    var_0 painvisionoff();
    var_0 scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    level.gunship_intromodel setscriptablepartstate("_encstr_B4660D7AD01083331B28BB4ABBA577", "_encstr_AB0703DBB9", 0);
    level.gunship_intromodel setscriptablepartstate("_encstr_93310D5A904D6717492FF1CE412065", "_encstr_AB0703DBB9", 0);
    level.gunship_intromodel thread gunship_startintroshake(var_5, var_8, var_0);
    level.gunship_intromodel thread gunship_queuecamerazoom(var_8, var_0);
    level.gunship_intromodel thread gunship_playdofintroeffects();
  }

  var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_1.streakname, 1);
  level.gunship_intromodel.scenenode scripts\common\anim::anim_single_solo(level.gunship_intromodel, var_5);

  if(!isDefined(level.gunship_intromodel))
    return 0;

  level.gunship_intromodel notify("_encstr_B83F124F639ABEB0B94B91ED4B21FFC9B0A38D78");

  if(!var_4) {
    var_0 disablephysicaldepthoffieldscripting();
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var_0 scripts\mp\playeractions::allowactionset("_encstr_885D0DCEBA37DCD0D21CA4DCE8C9DE", 1);
  }

  return 1;
}

set_up_minigun(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B83F124F639ABEB0B94B91ED4B21FFC9B0A38D78");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = level.gunship_intromodel.owner;
  var_2 waittill(var_0);

  if(var_0 == "_encstr_8D820B49520F0EC02DDE6367EC")
    level.gunshipinuse = 0;

  set_ui_omnvar_for_relics(var_2, var_1);
}

set_ui_omnvar_for_relics(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && !var_2) {
    var_0 cameraunlink();
    var_0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var_0 disablephysicaldepthoffieldscripting();
    var_0 scripts\mp\playeractions::allowactionset("_encstr_885D0DCEBA37DCD0D21CA4DCE8C9DE", 1);
    var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var_1.streakname, "_encstr_BA19049F4B2D");
    var_0 setclientomnvar("_encstr_8DE30DAE96D70B1BC49903FA0DD5C8", 0);
    var_0 painvisionon();
    var_0 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    var_0 visionsetkillstreakforplayer("_encstr_B40101");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_0, 0);
  }

  var_1 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  self setscriptablepartstate("_encstr_B4660D7AD01083331B28BB4ABBA577", "_encstr_BA19049F4B2D", 0);
  self setscriptablepartstate("_encstr_93310D5A904D6717492FF1CE412065", "_encstr_BA19049F4B2D", 0);
  self delete();
}

gunship_hideintromodelonplayerconnect() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    self hidefromplayer(var_0);
  }
}

gunship_playdofintroeffects() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner enablephysicaldepthoffieldscripting();
  self.owner setphysicaldepthoffield(1.4, 20, 10, 10);
  wait 0.1;
  self.owner setphysicaldepthoffield(0.125, 1500, 5, 10);
  wait 3;
  self.owner setphysicaldepthoffield(0.125, 1000, 5, 10);
  wait 1.5;
  self.owner setphysicaldepthoffield(5.6, 5000, 1, 1);
}

gunship_startintroshake(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  var_3 = var_1;
  var_4 = 0.45;
  var_5 = 0.05;

  while(var_3 > 0) {
    earthquake(var_4, var_5, self.origin, 5000);
    var_4 = var_4 - 0.01;

    if(var_4 <= 0.12)
      var_4 = 0.12;

    var_3 = var_3 - var_5;
    wait(var_5);
  }
}

gunship_queuecamerazoom(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0 - 0.2);
  var_1 visionsetkillstreakforplayer("_encstr_B4C919474BD33310F54193EBF7DCC8F52A2347EFAB3A898007A538", 0.1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_1, 1, 0.1);
}

gunship_returnplayer(var_0) {
  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);

  if(isDefined(var_0)) {
    var_1 = 0;

    if(!var_1) {
      var_0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
      var_0 scripts\mp\playeractions::allowactionset("_encstr_86010B6750307382DB3743C295", 1);
      var_0 gunship_allowstances(1);
    }

    var_0 setclientomnvar("_encstr_B1C71B55998F982BE5C290B03B7FF350372C53C5FA2F8119013A783862", 0);
    var_0 visionsetthermalforplayer("_encstr_B40101");
    var_0 scripts\cp_mp\utility\player_utility::setthermalvision(0);
    var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "_encstr_BA19049F4B2D");
    var_0 setclientomnvar("_encstr_8DE30DAE96D70B1BC49903FA0DD5C8", 0);
    var_0 stoploopsound();
    var_0 visionsetkillstreakforplayer("_encstr_B40101");
    var_0 clearclienttriggeraudiozone(0.5);
    var_0 painvisionon();
    var_0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var_0 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    var_0.usinggunship = undefined;

    if(getdvarint("_encstr_82570B397A4D3192935192A562")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B807125285B0A9B80472F441202DC7F76301A797"))
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B807125285B0A9B80472F441202DC7F76301A797")]](1);
    }

    if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(level.gunship.deployweaponobj);
      var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(level.gunship.deployweaponobj);
    }

    if(!var_1)
      var_0 thread gunship_restoreplayerweapon(self.streakinfo);

    var_0 unlink();

    if(isDefined(var_0.gunship_cloudsfx))
      var_0.gunship_cloudsfx delete();
  }

  gunship_lockedonremovedcallback();

  if(isDefined(self.enemytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);

  if(isDefined(self.friendlytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.friendlytargetmarkergroup);

  if(isDefined(level.gunship_intromodel))
    level.gunship_intromodel delete();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_86FD08B775CD07DC1338", "_encstr_BD3E0B4CE4AF9C95E60E2CDD37"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_86FD08B775CD07DC1338", "_encstr_BD3E0B4CE4AF9C95E60E2CDD37")]](var_0);

  level.gunshipinuse = 0;
}

gunship_restoreplayerweapon(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::allow_fire(0);
    wait 0.05;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);
    wait 0.767;
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_88710EC26CC49918FA1A815BB5AFADC1");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_88F90EF65F8E7A1AEED5251AE97F9788");
    scripts\cp_mp\utility\inventory_utility::_takeweapon(level.gunship.deployweaponobj);
    scripts\common\utility::allow_fire(1);
    scripts\common\utility::allow_weapon_switch(1);
  }
}

gunship_watchdamage(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 4096);

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_11 = undefined;

    if(isDefined(level.teambased) && isPlayer(var_2) && (var_2.team == self.team && (!isDefined(var_11) || !var_11))) {
      continue;
    }
    if(var_5 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_5 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_5 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5") {
      continue;
    }
    if(isDefined(self.owner) && self.owner isusinggunship()) {
      var_12 = "_encstr_8FA906CC80677438";

      if(isexplosivedamagemod(var_5)) {
        if(ceil(var_1 / self.maxhealth) >= 0.33) {
          self.owner earthquakeforplayer(0.25, 0.2, self.camera.origin, 150);
          self.owner playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
          var_12 = "_encstr_B846067B175AA56A";
        } else {
          self.owner earthquakeforplayer(0.15, 0.15, self.camera.origin, 150);
          self.owner playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");
        }
      }

      thread gunship_screeninterference(0.2, var_12);
    }

    self.wasdamaged = 1;
    var_13 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2"))
      var_13 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2")]](var_2, var_10, var_5, var_1, self.maxhealth, 4, 5, 25, 0, 350);

    if(isPlayer(var_2)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA"))
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA")]]("_encstr_A2FB098A2035874AB0F358");
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B2D0E10DA55893B8B12D5DF13A3A071"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B2D0E10DA55893B8B12D5DF13A3A071")]](var_2, var_10, self, var_5, var_13);

    if(isDefined(var_2.owner) && isPlayer(var_2.owner)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA"))
        var_2.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA")]]("_encstr_A2FB098A2035874AB0F358");
    }

    self.damagetaken = self.damagetaken + var_13;
    self.currenthealth = self.maxhealth - self.damagetaken;

    if(isDefined(self.owner) && self.owner isusinggunship())
      var_0 setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", self.currenthealth / self.maxhealth);

    if(self.currenthealth <= 500 && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");

      if(isDefined(self.owner) && self.owner isusinggunship()) {
        self.flashlight setscriptablepartstate("_encstr_8F2E14B1C25B5927B0AF320BDAC2CEB2F53696B33447", "_encstr_AB0703DBB9");
        self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_B4951CD16B838E7074589FF171DCB0D87F2149997217CC40812CFBDF90C3");
      }
    } else if(self.currenthealth <= 250 && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_BA19049F4B2D");
      self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");

      if(isDefined(self.owner) && self.owner isusinggunship()) {
        self.flashlight setscriptablepartstate("_encstr_96B0156B4F82A135B68E31210FE0A74057859A2C11C32D", "_encstr_AB0703DBB9");
        self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_BDE81D71CB232ED0D4F83F9111BC1078DFC1A939D2776CE061CD43B9316348");
        self.owner playlocalsound("_encstr_AD5A18B5DCFA58C6269906D7C8585B583B59D7EE589C9B5A739D");
      }
    } else if(self.currenthealth <= 0 && self.currentdamagestate == 2) {
      self.currentdamagestate = 3;
      self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_BA19049F4B2D");
      self setscriptablepartstate("_encstr_BD7D0A1E904061166A7C49B3", "_encstr_BA19049F4B2D");
      thread gunship_startengineblowoutfx();

      if(isDefined(self.owner) && self.owner isusinggunship()) {
        self.flashlight setscriptablepartstate("_encstr_B19C14D8C2DA5993C27D9158B50B7695AF43B2859D5E", "_encstr_AB0703DBB9");
        self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_BD271CB10BE3EE101438FFD151FC50389F0169F912372CA0A10883F36EA0");
      }
    }

    if(self.damagetaken >= self.maxhealth) {
      var_14 = self.streakinfo.streakname;
      var_15 = undefined;
      var_16 = "_encstr_ACB80B32E13893EAC81A9F1209" + var_14;
      var_17 = undefined;
      var_18 = "_encstr_A76B138D2C1B36EDEA477D19959B1D4E7B97B223F5" + var_14;
      var_19 = 1;

      if(isPlayer(var_2)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
          thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]](var_18, var_2);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24"))
        var_20 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24")]](var_14, var_2, var_10, var_15, var_1, var_16, var_17, var_18, var_19);

      thread gunship_crash(8, var_0);
    }
  }
}

gunship_startengineblowoutfx() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.leftwingfxent setscriptablepartstate("_encstr_8DF80F4260DF54B3A9509A9C50336F9B51", "_encstr_AB0703DBB9");
  self.leftwingfxent setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_AB0703DBB9");
  var_0 = randomfloatrange(0.5, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self.rightwingfxent setscriptablepartstate("_encstr_8DF80F4260DF54B3A9509A9C50336F9B51", "_encstr_AB0703DBB9");
  self.rightwingfxent setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_AB0703DBB9");
}

gunship_watchtimeout(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(self.timeout);
  thread gunship_leave(var_0);
}

set_up_coop_push(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread gunship_leave(var_0);
}

gunship_leave(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_BA2D081B2B58B32D37EC");
  self unlink();
  self rotateroll(30, 3);
  var_1 = self.angles;
  var_2 = anglesToForward(var_1);

  if(isDefined(self.owner))
    self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_B4D110E8A56BCAED57E87DB3AB9B6E0DD21C", 1);

  gunship_returnplayer(var_0);
  self moveTo(self.origin + var_2 * 50000, 10, 5);
  gunship_waittilldestination(self.origin + var_2 * 50000);
  gunship_removeplane(0);
}

gunship_waittilldestination(var_0) {
  while(isDefined(self) && self.origin != var_0)
    waitframe();
}

set_up_pilots(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill(var_1);
  thread gunship_crash(8, var_0);
}

gunship_watchendgame(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "_encstr_BA19049F4B2D");
  var_0 setclientomnvar("_encstr_8DE30DAE96D70B1BC49903FA0DD5C8", 0);
}

gunship_trackvelocity(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.velocity = (0, 0, 0);

  for(;;) {
    self.lastorigin = self.origin;
    wait(level.framedurationseconds);
    self.velocity = (self.origin - self.lastorigin) / level.framedurationseconds;
  }
}

gunship_spawn(var_0, var_1, var_2, var_3) {
  var_4 = "_encstr_A2631FB45A529979FFC38AD1A78BCB79A143F14846614917EFB297A957CD16E34D";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0))
    var_4 = "_encstr_8C1724D3C333875F90D8F531F198BA491F6733079569DA5DAA6BFA09ABC0F1B261878F7F3F8D";

  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.gunship.origin);
  var_5 setModel(var_4);
  var_5 setCanDamage(1);
  var_5.currenthealth = 1000;
  var_5.maxhealth = var_5.currenthealth;
  var_5.health = 99999;
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5.timeout = 45;
  var_5.currentdamagestate = 0;
  var_5 scripts\mp\sentientpoolmanager::registersentient("_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0, undefined, undefined, 1, 0);
  var_5.flaresreservecount = 2;
  var_5.streakinfo = var_1;
  var_5 scriptmoveroutline();
  var_5 scriptmoverthermal();
  var_5 setotherent(var_0);
  var_8 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841"))
    var_8 = var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841")]]("_encstr_A26F161C306860B15F6053C34D33BBA17A2DBA6048E1B3B7", var_5.team, 1, 1, 1);

  var_5.minimapid = var_8;
  var_5 linkTo(level.gunship, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_3, (0, var_2 + 90, -30));
  level notify("_encstr_993D15DA0BE1DEA3B3459387E6596F257F59934278BD17", var_5);
  return var_5;
}

gunship_updateoverlaycoords(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_86BD0980BBC647A80FDE04");
  var_0 endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.05;
  thread gunship_updateplanemodelcoords(var_0);
  thread gunship_updateplayerpositioncoords(var_0);
  thread gunship_updateaimingcoords(var_0);
}

gunship_updateplanemodelcoords(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_86BD0980BBC647A80FDE04");
  var_0 endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self setclientomnvar("_encstr_AFE615AB96F5C236629981FA8DB7DEC91998F51CF637C3", int(var_0.origin[0]));
    self setclientomnvar("_encstr_9AE615808F7709E70FDA17A826023793B40649202FF342", int(var_0.origin[1]));
    self setclientomnvar("_encstr_8CE615D5A5BE2CD8893318AFB17BF64E19C4EB837BDCA7", int(var_0.origin[2]));
    wait 0.5;
  }
}

gunship_updateplayerpositioncoords(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_86BD0980BBC647A80FDE04");
  var_0 endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  waitframe();
  self setclientomnvar("_encstr_9127155862213B91C63B17B84397D8A5577F91F87A4241", int(self.origin[0]));
  self setclientomnvar("_encstr_AC271573F141983E4EB77B9E5ADFE0D827029FF16F3210", int(self.origin[1]));
  self setclientomnvar("_encstr_A32715C3FA17D778126B31F723ED502683271EEB220F92", int(self.origin[2]));
}

gunship_updateaimingcoords(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_86BD0980BBC647A80FDE04");
  var_0 endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 = self getvieworigin();
    var_2 = var_1 + anglesToForward(self getplayerangles()) * 15000;
    var_3 = physicstrace(var_1, var_2);
    self setclientomnvar("_encstr_92FF150BD0372967C2D3F3413708EA43BCD799334FF82B", int(var_3[0]));
    self setclientomnvar("_encstr_BEFF1523A111C80E7E87AB4EAA2F30E87753EFA15FC2C0", int(var_3[1]));
    self setclientomnvar("_encstr_BDFF158564C9FB5901E6A2E19F671015A21A688F7DA375", int(var_3[2]));
    wait 0.1;
  }
}

rotateplane(var_0) {
  level notify("_encstr_B15F18D349D8BAD79658FBD24365A3F5F0D57D77D108C2E73711");
  level endon("_encstr_B15F18D349D8BAD79658FBD24365A3F5F0D57D77D108C2E73711");

  if(var_0 == "_encstr_AB0703DBB9") {
    var_1 = 10;
    var_2 = level.gunship_speed["_encstr_B4F507E4BD4785E856"] / 360 * var_1;
    level.gunship rotateYaw(level.gunship.angles[2] + var_1, var_2, var_2, 0);
    var_3 = 360 / level.gunship_speed["_encstr_B4F507E4BD4785E856"];
    var_4 = var_3 * 0.0174533;
    level.gunship_magnitude = var_4 * 9000;

    for(;;) {
      level.gunship rotateYaw(360, level.gunship_speed["_encstr_B4F507E4BD4785E856"]);
      wait(level.gunship_speed["_encstr_B4F507E4BD4785E856"]);
    }
  } else if(var_0 == "_encstr_BA19049F4B2D") {
    var_5 = 10;
    var_2 = level.gunship_speed["_encstr_B4F507E4BD4785E856"] / 360 * var_5;
    level.gunship rotateYaw(level.gunship.angles[2] + var_5, var_2, 0, var_2);
  } else if(var_0 == "_encstr_8F9E06C26033324B") {
    var_1 = 50;
    var_2 = level.gunship_speed["_encstr_B4F507E4BD4785E856"] / 360 * var_1;
    level.gunship rotateYaw(level.gunship.angles[2] + var_1, var_2, var_2, 0);
  }
}

gunship_attachgunner(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 visionsetkillstreakforplayer("_encstr_B40101", level.framedurationseconds);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_0, 0, 0.1);
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_88710EC26CC49918FA1A815BB5AFADC1");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_88F90EF65F8E7A1AEED5251AE97F9788");
  var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9");
  self.currentvisionset = "_encstr_AF500C2C1B136660BE8D7BC6F627";
  waitframe();
  var_0 cameraunlink();

  if(isDefined(level.gunship_intromodel)) {
    if(isDefined(level.gunship_intromodel.scenenode))
      level.gunship_intromodel.scenenode delete();

    level.gunship_intromodel setscriptablepartstate("_encstr_B4660D7AD01083331B28BB4ABBA577", "_encstr_BA19049F4B2D", 0);
    level.gunship_intromodel setscriptablepartstate("_encstr_93310D5A904D6717492FF1CE412065", "_encstr_BA19049F4B2D", 0);
    level.gunship_intromodel hide();
  }

  self.camera = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin - (0, 0, 20));
  self.camera setModel("_encstr_8E010B996FB7B6B3C1D1183343");
  self.camera.angles = vectortoangles(level.gunship.origin - self.camera.origin);
  self.camera linkTo(self);

  if(isbot(var_0))
    var_0 cameralinkTo(self.camera, "_encstr_8E010B996FB7B6B3C1D1183343");
  else {
    var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_8A110F9FE0C832C910ABB9D7686A51A72D");
    var_0.usinggunship = 1;
    var_0 playerlinkweaponviewtodelta(self.camera, "_encstr_8E010B996FB7B6B3C1D1183343", 1.0, 100, 100, 17, 90, 0);
    var_0 playerlinkedsetviewznear(0);
    var_0 visionsetkillstreakforplayer(self.currentvisionset);
    var_0 setclienttriggeraudiozone("_encstr_A17E11B92FE7737B6FA8EFD2F4FBAB6A05372F");
    var_0 setplayerangles(self.camera.angles);
    var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "_encstr_AB0703DBB9");
    var_0 setclientomnvar("_encstr_8DE30DAE96D70B1BC49903FA0DD5C8", 1);
    var_0 setclientomnvar("_encstr_85AC1CF0D081B7D4BAAB277983AFCBFF5F6B9FDFE32F4DFFCB903E218045", var_0 getweaponammoclip("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"));
    var_0 setclientomnvar("_encstr_88B61CBA5AEB6D968DB1DC8E27AC2CB6FABB950BC1B7CDAF8CF5586BDABD", var_0 getweaponammoclip("_encstr_88710EC26CC49918FA1A815BB5AFADC1"));
    var_0 setclientomnvar("_encstr_929F1C13497162184881FBAB43D8C7902FD3D72E532F4EA1B20F86D7AADF", var_0 getweaponammoclip("_encstr_88F90EF65F8E7A1AEED5251AE97F9788"));
    var_0 setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(self.timeout * 1000));
    var_0 setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", self.maxhealth);
    var_0 setclientomnvar("_encstr_B1D115D55AAF5BA5B1C69B47E4562C5BAF998DC293959B", self.flaresreservecount);
    var_0 scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_A37A196F13897ACB10E3FFC6F871F62253E7C7BFF3A523912168B2", "_encstr_AC190479FF92", self.timeout, 0);
    var_0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var_0 scripts\mp\playeractions::allowactionset("_encstr_86010B6750307382DB3743C295", 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_86FD08B775CD07DC1338", "_encstr_9A54146BDB7AE82C23D1A1CB0AE75D311632E7EB6222"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_86FD08B775CD07DC1338", "_encstr_9A54146BDB7AE82C23D1A1CB0AE75D311632E7EB6222")]](var_0);

    var_0 thread gunship_updateoverlaycoords(self);
  }
}

gunship_watchchangeweapons(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = ["_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9", "_encstr_88710EC26CC49918FA1A815BB5AFADC1", "_encstr_88F90EF65F8E7A1AEED5251AE97F9788"];
  var_0 scripts\common\utility::allow_weapon_switch(0);

  if(!isai(var_0)) {
    var_0 notifyonplayercommand("_encstr_8D6F1658CD28560C4CFB07FF27C3635740E78358CEA3A05E", "_encstr_A6E60A229B175A3B48A543AB");
    var_0 notifyonplayercommand("_encstr_8D6F1658CD28560C4CFB07FF27C3635740E78358CEA3A05E", "_encstr_81E10A4B8F483EAB573B2AE3");
    var_0 setclientomnvar("_encstr_AA6315AE967D5B4BB11BE6D19C59C25BFAEE2BB083DEB9", 3);
  }

  var_3 = 3;

  for(;;) {
    var_0 waittill("_encstr_8D6F1658CD28560C4CFB07FF27C3635740E78358CEA3A05E");
    var_0 playlocalsound("_encstr_93C41AEC0CC949ABAB3157576A8BC8F1FFAD7622F8BD43FFB0104743");
    var_4 = var_0 getcurrentweapon();
    var_5 = var_4;

    foreach(var_9, var_7 in var_2) {
      if(var_4.basename == var_7) {
        var_8 = var_9 + 1;

        if(var_8 > var_2.size - 1)
          var_8 = 0;

        var_5 = var_2[var_8];
        break;
      }
    }

    var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_5);

    if(self.currentvisionset == "_encstr_9966162345622836E29FAE98038AD0BEBDDF207C2BDBB320") {
      var_10 = gunship_getdofinfobyweapon(var_5);
      var_0 setphysicaldepthoffield(var_10.fstop, var_10.focusdistance, 20, 20);
    }

    var_3--;

    if(var_3 == 0)
      var_3 = 3;

    var_0 setclientomnvar("_encstr_AA6315AE967D5B4BB11BE6D19C59C25BFAEE2BB083DEB9", var_3);
    playfxontagforclients(scripts\engine\utility::getfx("_encstr_810C0FAA9043CF5BA128F310D5EB8B17A5"), var_0, "_encstr_A130084D2FDAD8AA8F62", var_0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.4);
  }
}

gunship_watchweaponfired(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = self.streakinfo;

  for(;;) {
    var_0 waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_3);
    var_0 thread gunship_watchweaponimpact(var_3);
    var_3.streakinfo = var_2;
    var_2.shots_fired++;
    var_4 = var_0 getcurrentweapon();
    var_5 = var_0 getweaponammoclip(var_4);

    switch (var_4.basename) {
      case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
        earthquake(0.2, 1, self.origin, 1000);
        var_0 setclientomnvar("_encstr_85AC1CF0D081B7D4BAAB277983AFCBFF5F6B9FDFE32F4DFFCB903E218045", var_5);
        var_3 thread gunship_watch105mmexplosion(self, var_0);
        break;
      case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
        earthquake(0.1, 0.5, self.origin, 1000);
        var_0 setclientomnvar("_encstr_88B61CBA5AEB6D968DB1DC8E27AC2CB6FABB950BC1B7CDAF8CF5586BDABD", var_5);
        break;
      case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
        var_0 setclientomnvar("_encstr_929F1C13497162184881FBAB43D8C7902FD3D72E532F4EA1B20F86D7AADF", var_5);
        break;
    }

    if(var_5 == 0)
      var_0 thread gunship_weaponreload(var_4, self);
  }
}

gunship_watchweaponimpact(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = self getcurrentweapon();
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_3, var_4, var_5, var_6, var_7, var_8);
  var_9 = 0.5;
  var_10 = 100;

  if(isDefined(var_2) && isDefined(var_2.basename)) {
    switch (var_2.basename) {
      case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
        var_9 = 1.5;
        var_10 = 500;
        break;
      case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
        var_9 = 1;
        var_10 = 300;
        break;
    }
  }

  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_11 setModel("_encstr_A5A9131AC3AF376E32A7F88F31E87267B59BD1E24B");
  var_11.angles = vectortoangles(var_8);
  var_11 linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_12 = "_encstr_AB0703DBB9";

  if(istrue(var_1))
    var_12 = "_encstr_96221067CD45D3EF66A8531FAB78A43915DB";

  var_11 setscriptablepartstate(var_0.weapon_name, var_12, 0);

  if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_0.origin, var_10, var_10, self.team, var_9, self, 1);

    var_11 setotherent(self);
    var_0 detonate();
  } else
    var_0 delete();

  var_13 = var_11.origin;
  var_14 = getmissileexplscale(var_0.weapon_name);
  var_15 = 0.75;
  var_16 = getmissileexplradius(var_0.weapon_name);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AB4D1537203BD17A197552887023E27283586FEF403015"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AB4D1537203BD17A197552887023E27283586FEF403015")]](var_13, var_14, var_15, var_16);

  var_11 thread deleteaftertime(5);
}

getmissileexplscale(var_0) {
  var_1 = 1.0;

  switch (var_0) {
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
      var_1 = 0.75;
      break;
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
      var_1 = 0.5;
      break;
    case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
      var_1 = 0.15;
      break;
  }

  return var_1;
}

getmissileexplradius(var_0) {
  var_1 = 1.0;

  switch (var_0) {
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
      var_1 = 2000;
      break;
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
      var_1 = 1300;
      break;
    case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
      var_1 = 700;
      break;
  }

  return var_1;
}

gunship_watch105mmexplosion(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 endon("_encstr_86BD0980BBC647A80FDE04");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AD75063D571AE108");
  earthquake(0.125, 0.5, var_0.origin, 1000);
  var_2 = gunship_getvisionsetformat(var_0.currentvisionset);
  var_3 = gunship_getvisionset(var_2);

  if(var_2 == "_encstr_A17905D82AB415")
    var_1 visionsetthermalforplayer(var_3);
  else
    var_1 visionsetkillstreakforplayer(var_3);

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);

  if(var_2 == "_encstr_A17905D82AB415")
    var_1 visionsetthermalforplayer(var_0.currentvisionset);
  else
    var_1 visionsetkillstreakforplayer(var_0.currentvisionset);
}

gunship_screeninterference(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");

  if(isDefined(var_2)) {
    var_3 = gunship_getvisionsetformat(self.currentvisionset);
    var_4 = gunship_getvisionset(var_3, var_1);

    if(var_3 == "_encstr_A17905D82AB415")
      var_2 visionsetthermalforplayer(var_4);
    else
      var_2 visionsetkillstreakforplayer(var_4);

    if(isDefined(var_0) && isDefined(self.currentvisionset)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

      if(var_3 == "_encstr_A17905D82AB415")
        var_2 visionsetthermalforplayer(self.currentvisionset);
      else
        var_2 visionsetkillstreakforplayer(self.currentvisionset);
    }
  }
}

gunship_getvisionsetformat(var_0) {
  return scripts\engine\utility::ter_op(issubstr(var_0, "_encstr_A17905D82AB415"), "_encstr_A17905D82AB415", "_encstr_A18E06C6F663DB9C");
}

gunship_getvisionset(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1)) {
    if(var_0 == "_encstr_A17905D82AB415")
      var_2 = var_0 + "_encstr_93D313B9F1475318081B608684385067E8C14370F7" + var_1 + "_encstr_81670806AA6F51E807BD";
    else
      var_2 = "_encstr_957E0D858D6266607DB1DED8F6E47D" + var_1 + "_encstr_81670806AA6F51E807BD";
  } else
    var_2 = "_encstr_A3110798D7C29A9AAE" + var_0 + "_encstr_8A9108A7AFA8282B8A30";

  return var_2;
}

gunship_watchthermaltoggle(var_0) {
  if(!isai(var_0))
    var_0 thread scripts\cp_mp\utility\player_utility::watchthermalinputchange();

  gunship_watchthermaltoggleinternal(var_0);

  if(isDefined(var_0) && !isai(var_0))
    var_0 scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();
}

gunship_watchthermaltoggleinternal(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.flashlight = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  self.flashlight setModel("_encstr_AD7E0CB637EB851B896603D7DA38");
  self.flashlight dontinterpolate();
  self.flashlight thread gunship_watchthermalflashlightpos(self, var_0);

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    self.flashlight thread gunship_showflashlight();

  var_1 = 0;
  var_2 = 1;
  var_4 = 12;
  var_5 = 1000;

  if(scripts\cp_mp\utility\game_utility::isnightmap() && istrue(var_2)) {
    var_0 setclientomnvar("_encstr_B1C71B55998F982BE5C290B03B7FF350372C53C5FA2F8119013A783862", 1);
    var_0 visionsetthermalforplayer("_encstr_9966162345622836E29FAE98038AD0BEBDDF207C2BDBB320");
    var_0 scripts\cp_mp\utility\player_utility::setthermalvision(1, var_4, var_5);
    self.currentvisionset = "_encstr_9966162345622836E29FAE98038AD0BEBDDF207C2BDBB320";
    self.flashlight notify("_encstr_81BF0E5404EF03A16DEAB8C8D3497778");
    var_1 = 1;
    var_0 scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_9A4B1E2B8BB08BEAD9B8720A48B76367E878ABD911394B36E770EA82685F9D6B", "_encstr_AC190479FF92", self.timeout, 0);
  }

  for(;;) {
    var_0 waittill("_encstr_83DC143FAF8C707E6B3133B8FA6B2180652FBB8F2477");
    var_6 = var_0 getcurrentweapon();
    var_7 = gunship_getdofinfobyweapon(var_6.basename);

    if(!istrue(var_1)) {
      var_0 setclientomnvar("_encstr_B1C71B55998F982BE5C290B03B7FF350372C53C5FA2F8119013A783862", 1);
      var_0 visionsetthermalforplayer("_encstr_9966162345622836E29FAE98038AD0BEBDDF207C2BDBB320");
      var_0 scripts\cp_mp\utility\player_utility::setthermalvision(1, var_7.fstop, var_7.focusdistance);
      self.currentvisionset = "_encstr_9966162345622836E29FAE98038AD0BEBDDF207C2BDBB320";
      var_1 = 1;
      var_0 scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_9A4B1E2B8BB08BEAD9B8720A48B76367E878ABD911394B36E770EA82685F9D6B", "_encstr_AC190479FF92", self.timeout, 0);
      continue;
    }

    var_0 setclientomnvar("_encstr_B1C71B55998F982BE5C290B03B7FF350372C53C5FA2F8119013A783862", 0);
    var_0 scripts\cp_mp\utility\player_utility::setthermalvision(0);
    var_0 visionsetkillstreakforplayer("_encstr_AF500C2C1B136660BE8D7BC6F627");
    self.currentvisionset = "_encstr_AF500C2C1B136660BE8D7BC6F627";
    var_1 = 0;
    var_0 scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_A37A196F13897ACB10E3FFC6F871F62253E7C7BFF3A523912168B2", "_encstr_AC190479FF92", self.timeout, 0);
  }
}

gunship_getdofinfobyweapon(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
      var_1.fstop = 8;
      var_1.focusdistance = 600;
      break;
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
      var_1.fstop = 8;
      var_1.focusdistance = 600;
      break;
    case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
      var_1.fstop = 8;
      var_1.focusdistance = 3500;
      break;
  }

  return var_1;
}

gunship_watchthermalflashlightpos(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = 1;

  while(isDefined(var_0) && isDefined(var_1)) {
    self.origin = var_0.origin;

    if(istrue(var_2))
      self.angles = var_1 getplayerangles();

    wait 0.05;
  }

  if(isDefined(self))
    self delete();
}

gunship_showflashlight() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_885111303A75FB7BBF1FFE7737B3E0AB5F12A3"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  for(;;) {
    level waittill("_encstr_BA0814928D80F1D246C7E7D3A3668A2510CE8D9B1978");
    stopFXOnTag(scripts\engine\utility::getfx("_encstr_885111303A75FB7BBF1FFE7737B3E0AB5F12A3"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    playFXOnTag(scripts\engine\utility::getfx("_encstr_885111303A75FB7BBF1FFE7737B3E0AB5F12A3"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  }
}

gunship_weaponreload(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_86BD0980BBC647A80FDE04");
  var_1 endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = getgunshipweaponrootname(var_0);
  self playlocalsound(var_2 + "_encstr_A9C50BFADAC1EB9C56D8F68519");
  gunship_waitforweaponreloadtime(var_0, var_2);
  var_3 = var_2 + "_encstr_B1DC0A77EDB5C26FF079B7FF";

  if(var_2 == "_encstr_99B50C59FFB2F282E86B570FC8D9")
    var_3 = "_encstr_AFBE17D9D537DC43D2C1BE130C4DADDAD7E495D87B588CB2C8";
  else if(var_2 == "_encstr_AFC90B7A01F7BE7A81E9B8FD43")
    var_3 = "_encstr_AAA316172040E3124BA771A3AF1B1A87ABD8B3AF28B92D1A";
  else
    var_3 = "_encstr_821216ECAECDB9A1B41CEB19D4D65BEB9C2BB1BDC2C8B232";

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(var_3);
  var_4 = weaponmaxammo(var_0);
  self setweaponammoclip(var_0, var_4);
  var_5 = undefined;

  switch (var_2) {
    case "_encstr_99B50C59FFB2F282E86B570FC8D9":
      var_5 = "_encstr_85AC1CF0D081B7D4BAAB277983AFCBFF5F6B9FDFE32F4DFFCB903E218045";
      break;
    case "_encstr_AFC90B7A01F7BE7A81E9B8FD43":
      var_5 = "_encstr_88B61CBA5AEB6D968DB1DC8E27AC2CB6FABB950BC1B7CDAF8CF5586BDABD";
      break;
    case "_encstr_91B90BB0C64C990CD79153B5B6":
      var_5 = "_encstr_929F1C13497162184881FBAB43D8C7902FD3D72E532F4EA1B20F86D7AADF";
      break;
  }

  self setclientomnvar(var_5, var_4);
}

gunship_waitforweaponreloadtime(var_0, var_1) {
  var_2 = level.weaponreloadtime[var_0.basename];
  var_3 = undefined;

  switch (var_1) {
    case "_encstr_99B50C59FFB2F282E86B570FC8D9":
      var_3 = "_encstr_8A0E21BB4BEE34CBB06A7B12ED0A10A93FA1BEA3270E51093E2389EC908002403C204D";
      break;
    case "_encstr_AFC90B7A01F7BE7A81E9B8FD43":
      var_3 = "_encstr_8F2C21BAD2D7DA963636B993CAC2D6AF77B21638B7E6EB197D27AC8D7B16C847A5DA56";
      break;
    case "_encstr_91B90BB0C64C990CD79153B5B6":
      var_3 = "_encstr_B6D02157B4EBB64BB1D8DCE4B258ADF5BB2B850EB773FACCEB272BD8BD85C8A3B46BCA";
      break;
  }

  self setclientomnvar(var_3, gettime() + int(var_2 * 1000));

  for(;;) {
    wait 0.05;
    var_2 = var_2 - 0.05;

    if(var_2 <= 0) {
      break;
    }
  }
}

getgunshipweaponrootname(var_0) {
  var_1 = 0;
  var_2 = var_0.basename;
  var_3 = strtok(var_2, "_encstr_BA4C02DF");
  return var_3[var_1] + "_encstr_BA4C02DF" + var_3[var_1 + 1];
}

gunship_playpilotfx(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0.gunship_cloudsfx = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 getEye());
  var_0.gunship_cloudsfx setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0.gunship_cloudsfx linkTo(var_0, "_encstr_A130084D2FDAD8AA8F62");
  waitframe();
  playfxontagforclients(scripts\engine\utility::getfx("_encstr_9A5007A9E5275F8ACA"), var_0.gunship_cloudsfx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0);
}

deleteaftertime(var_0) {
  self endon("_encstr_AD75063D571AE108");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self delete();
}

gunship_crash(var_0, var_1) {
  self notify("_encstr_86BD0980BBC647A80FDE04");
  self.crashed = 1;
  gunship_returnplayer(var_1);
  thread gunship_movetocrashpos(var_0);
}

gunship_movetocrashpos(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.leftwingfxent setscriptablepartstate("_encstr_8DF80F4260DF54B3A9509A9C50336F9B51", "_encstr_BA19049F4B2D");
  self.rightwingfxent setscriptablepartstate("_encstr_8DF80F4260DF54B3A9509A9C50336F9B51", "_encstr_BA19049F4B2D");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  self.leftwingfxent setscriptablepartstate("_encstr_8DF80F4260DF54B3A9509A9C50336F9B51", "_encstr_AB0703DBB9");
  self.rightwingfxent setscriptablepartstate("_encstr_8DF80F4260DF54B3A9509A9C50336F9B51", "_encstr_AB0703DBB9");
  self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_AABE116803CDBF50C718C0C6F20FFB71F45AF0", 1);
  self unlink();
  self.scenenode = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  self.scenenode setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.scenenode.angles = vectortoangles(anglesToForward(self.angles));
  self.leftwingfxent setscriptablepartstate("_encstr_8DF80F4260DF54B3A9509A9C50336F9B51", "_encstr_BA19049F4B2D");
  self.rightwingfxent setscriptablepartstate("_encstr_8DF80F4260DF54B3A9509A9C50336F9B51", "_encstr_BA19049F4B2D");
  self.leftwingfxent setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_BA19049F4B2D");
  self.rightwingfxent setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_BA19049F4B2D");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_1 setModel("_encstr_9B48116F5FC17FB6CA4A723F419B472DFB17C8");
  var_1.angles = self.angles;
  var_1.animname = self.streakinfo.streakname;
  var_1 scripts\common\anim::setanimtree();
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_2 setModel("_encstr_AD7E0CB637EB851B896603D7DA38");
  var_2.angles = self.angles;
  var_2 linkTo(var_1, "_encstr_8F1E092CC9F71178C01941", (0, 0, -10), (0, 0, 0));
  var_3 = "_encstr_B4740A47F226E0430F7A4813";
  var_2 setscriptablepartstate(var_3, "_encstr_AB0703DBB9", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_850E077B0BF30318B9", "_encstr_9B560FC8B236165E51B9D111CA36568E59")) {
    var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_850E077B0BF30318B9", "_encstr_9B560FC8B236165E51B9D111CA36568E59")]](10);
    var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_850E077B0BF30318B9", "_encstr_9B560FC8B236165E51B9D111CA36568E59")]](10);
  }

  var_1 thread gunship_crash_audio();
  thread gunship_delayhide();
  thread gunship_crashexplosionscreenshake(level.gunship_crashanimlength);
  thread gunship_crashexplosionradiostatic(level.gunship_crashanimlength);
  self.scenenode scripts\common\anim::anim_single_solo(var_1, "_encstr_AFB10E76ABCD6ED0D2E0FA322B85D1D0", undefined);
  self.scenenode delete();
  gunship_removeplane(1);
}

gunship_delayhide() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.05;
  self hide();
}

gunship_crashexplosionscreenshake(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0 - 2;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp_mp\utility\player_utility::_isalive())
      var_3 earthquakeforplayer(0.25, 2, self.origin, 30000);
  }
}

gunship_crashexplosionradiostatic(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0 - 3;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  scripts\cp_mp\utility\dialog_utility::playoperatorstaticinterrupt();
}

gunship_crash_audio() {
  waitframe();
  playsoundatpos(self.origin, "_encstr_8454182CB7E7A0F86E97B95EF62E602969436F5ACF27EF797125");
  playsoundatpos(self.origin, "_encstr_8D241AA5EEE0AFD6E6F5858D626606D7CA0FE0D87BF5C6F6BBBE0623");
  playsoundatpos(self.origin, "_encstr_8A50199063F83972FBAF1B272EC7E7F16B3C19280F3750B3A30B0F");
  playsoundatpos(self.origin, "_encstr_8330135B336F578893A7D8D0068BAB1FE39CC3500F");
}

gunship_removeplane(var_0) {
  if(isDefined(self.flashlight))
    self.flashlight delete();

  if(isDefined(self.camera))
    self.camera delete();

  if(isDefined(self.leftwingfxent))
    self.leftwingfxent delete();

  if(isDefined(self.rightwingfxent))
    self.rightwingfxent delete();

  if(isDefined(self.lightfxent))
    self.lightfxent delete();

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](self.minimapid);

    self.minimapid = undefined;
  }

  self.streakinfo.onspray = istrue(var_0);

  if(!scripts\common\utility::iscp()) {
    if(isDefined(self.owner))
      self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);
  }

  self delete();
}

gunship_control_bot_aiming() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_5 = undefined;
  var_6 = (self botgetdifficultysetting("_encstr_931A0E4579C2F71079AADE3F0A788720") + self botgetdifficultysetting("_encstr_AA770EADC2C34ADC0BD836AB9CB0C6F2")) / 2;
  var_7 = 0;

  for(;;) {
    var_8 = 0;
    var_9 = 0;

    if(isDefined(var_1) && var_1.health <= 0 && gettime() - var_1.deathtime < 2000) {
      var_8 = 1;
      var_9 = 1;
    } else if(isalive(self.enemy) && (self botcanseeentity(self.enemy) || gettime() - self lastknowntime(self.enemy) <= 300)) {
      var_8 = 1;
      var_1 = self.enemy;
      var_10 = var_1.origin;
      var_0 = self.enemy.origin;

      if(self botcanseeentity(self.enemy)) {
        var_7 = 0;
        var_9 = 1;
        var_11 = gettime();
      } else {
        var_7 = var_7 + 0.05;

        if(var_7 > 5.0)
          var_8 = 0;
      }
    }

    if(var_8) {
      if(isDefined(var_0))
        var_2 = var_0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9B9B05A21F601A", "_encstr_9BFA11317B1DD789F623E5AF2D37AF91AC1646")) {
        if(var_9 && (self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9B9B05A21F601A", "_encstr_9BFA11317B1DD789F623E5AF2D37AF91AC1646")]]() || distancesquared(var_2, level.gunship.origin) > level.physicssphereradius["_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"] * level.physicssphereradius["_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"]))
          self botpressbutton("_encstr_999A07C61338F9A23A");
      }

      if(gettime() > var_4 + 500) {
        var_12 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_13 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_14 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_5 = (150 * var_12, 150 * var_13, 150 * var_14);
        var_4 = gettime();
      }

      var_2 = var_2 + var_5;
    } else if(gettime() > var_3) {
      var_3 = gettime() + randomintrange(1000, 2000);
      var_2 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9B9B05A21F601A", "_encstr_954B1A76B28ED79C583719BDDA7D7B57E8372D8C59D71DC2933BCAE8"))
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9B9B05A21F601A", "_encstr_954B1A76B28ED79C583719BDDA7D7B57E8372D8C59D71DC2933BCAE8")]]();
    }

    self botlookatpoint(var_2, 0.2, "_encstr_A7300E08584D77DBA497CF3FC5432757");
    wait 0.05;
  }
}

gunship_handlemissiledetection(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_8B670FAEBFBD03705FE9ADCEC95BBE3BA6"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_8B670FAEBFBD03705FE9ADCEC95BBE3BA6")]](var_2);

      var_2 thread gunship_playflaresfx(var_3);
      var_2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_BD270FB10BE3EE101438FFF55C7E88BDCF", 1);
      var_6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB"))
        var_6 = var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB")]]();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A12D21C8A30471B1029AF6066E2BA37B7B5F7078DBD92B5318BD768647300D61D437D0"))
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A12D21C8A30471B1029AF6066E2BA37B7B5F7078DBD92B5318BD768647300D61D437D0")]](var_0);

      self missile_settargetEnt(var_6);
      self notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");
      return;
    } else if(var_5 < 300 && var_2.flaresreservecount <= 0) {
      var_2 thread gunship_playfakebodyexplosion();
      var_7 = weapongetdamagemax(self.weapon_name);

      if(isDefined(self.owner))
        var_2 dodamage(var_7, self.owner.origin, self.owner, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", self.weapon_name);

      self delete();
    }

    waitframe();
  }
}

gunship_playfakebodyexplosion() {
  if(!isDefined(self.missileexplcounter))
    self.missileexplcounter = 0;

  self.missileexplcounter++;

  if(self.missileexplcounter > 4)
    self.missileexplcounter = 0;

  self setscriptablepartstate("_encstr_922413DD2FFC553F055F7F46690CB79167D9EB8039" + self.missileexplcounter, "_encstr_AB0703DBB9", 0);
  self playsoundonmovingent("_encstr_A94B1C96BB0EAFAD9BAFC236C46603F5325A6EE8EB935BA3F52BF0C18DED");
  wait 2;
  self setscriptablepartstate("_encstr_922413DD2FFC553F055F7F46690CB79167D9EB8039" + self.missileexplcounter, "_encstr_BA19049F4B2D", 0);
}

gunship_playflaresfx(var_0) {
  var_1 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";

  if(isDefined(var_0))
    var_1 = var_0;

  playsoundatpos(self gettagorigin(var_1), "_encstr_85C01038632FFF500A73598F4E05183E6FDB");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_BD270FB10BE3EE101438FFF55C7E88BDCF"), self, var_1);
  var_2 = self.flaresreservecount + 1;
  self setscriptablepartstate("_encstr_869A0D6FD9A89519D4395F1B030641" + var_2, "_encstr_AB0703DBB9", 0);
}

isusinggunship() {
  return isDefined(self.usinggunship);
}

gunship_linklightfxent() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.05;
  var_0 = anglesToForward(self.angles);
  self setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", "_encstr_AB0703DBB9");
}

gunship_linkwingfxents() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.05;
  var_0 = self gettagorigin("_encstr_934C143A16CEFAD8B2338ED77BAB475993F50EE4EDC1");
  self.leftwingfxent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  self.leftwingfxent setModel("_encstr_AD7E0CB637EB851B896603D7DA38");
  self.leftwingfxent.angles = self.angles;
  self.leftwingfxent setotherent(self.owner);
  self.leftwingfxent linkTo(self, "_encstr_934C143A16CEFAD8B2338ED77BAB475993F50EE4EDC1", (0, 0, 0), (0, 0, 0));
  var_1 = self gettagorigin("_encstr_8D5D15472CD9AF4EB4761AA3AFEDAEE859C9FA0E93F683");
  self.rightwingfxent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  self.rightwingfxent setModel("_encstr_AD7E0CB637EB851B896603D7DA38");
  self.rightwingfxent.angles = self.angles;
  self.rightwingfxent setotherent(self.owner);
  self.rightwingfxent linkTo(self, "_encstr_8D5D15472CD9AF4EB4761AA3AFEDAEE859C9FA0E93F683", (0, 0, 0), (0, 0, 0));
  self setscriptablepartstate("_encstr_BD7D0A1E904061166A7C49B3", "_encstr_AB0703DBB9");
}

gunship_watchtargets(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  for(;;) {
    var_1 = [];

    foreach(var_3 in level.players) {
      if(!isDefined(var_3) || !var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(self.owner worldpointinreticle_circle(var_3.origin, 80, 100)) {
        if(level.teambased && var_3.team == self.team) {
          continue;
        }
        if(var_3 == self.owner) {
          continue;
        }
        if(!scripts\cp_mp\utility\killstreak_utility::streakcanseetarget(self.origin, var_3 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28"), self)) {
          continue;
        }
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
          if(var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9"))
            continue;
        }

        var_1 = gunship_getnearbytargets(var_3);
        break;
      }

      wait 0.05;
    }

    if(var_1.size > 0 && var_1.size < 2)
      var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_AF6F17FC3DAA975488A1010BA0B58CB181C016A932A39B2DC9");
    else if(var_1.size >= 2)
      var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_AF13161873BDCF20974890F125EBEBA3A9BB18D0FBD32B79");

    wait(randomintrange(5, 15));
  }
}

gunship_getnearbytargets(var_0) {
  var_1 = scripts\common\utility::playersinsphere(var_0.origin, 300);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(level.teambased && var_4.team != var_0.team) {
      continue;
    }
    if(!level.teambased && var_4 == self.owner) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

gunship_watchkills(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self.owner waittill("_encstr_92FB1BA870FADEE4054823C2E74B9D214FEB3260C71EC5E1A19595F873", var_1, var_2);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

    if(isDefined(self.owner.recentkillcount)) {
      if(self.owner.recentkillcount >= 1 && gunship_iskillstreakweapon(var_2))
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_B13611978FBAE62001729E915DFFB808326739");
    }
  }
}

gunship_iskillstreakweapon(var_0) {
  return scripts\engine\utility::ter_op(isDefined(var_0) && (var_0 == "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9" || var_0 == "_encstr_88710EC26CC49918FA1A815BB5AFADC1" || var_0 == "_encstr_88F90EF65F8E7A1AEED5251AE97F9788"), 1, 0);
}

gunship_islargemap() {
  var_0 = scripts\cp_mp\utility\game_utility::islargemap();
  return var_0;
}

gunship_allowstances(var_0) {
  if(!istrue(var_0)) {
    self.gunship_disabledstances = [];
    var_1 = self getstance();

    switch (var_1) {
      case "_encstr_A5AD069B231F0BAF":
        self.gunship_disabledstances = ["_encstr_B13D076BED70539F23", "_encstr_922406F1A6FD5E05"];
        break;
      case "_encstr_B13D076BED70539F23":
        self.gunship_disabledstances = ["_encstr_A5AD069B231F0BAF", "_encstr_922406F1A6FD5E05"];
        break;
      case "_encstr_922406F1A6FD5E05":
        self.gunship_disabledstances = ["_encstr_A5AD069B231F0BAF", "_encstr_B13D076BED70539F23"];
        break;
    }

    scripts\mp\playeractions::registeractionset("_encstr_91EB0EECABE69B432DC16AA3C2E6B156", self.gunship_disabledstances);
    scripts\mp\playeractions::allowactionset("_encstr_91EB0EECABE69B432DC16AA3C2E6B156", 0);
  } else
    scripts\mp\playeractions::allowactionset("_encstr_91EB0EECABE69B432DC16AA3C2E6B156", 1);
}