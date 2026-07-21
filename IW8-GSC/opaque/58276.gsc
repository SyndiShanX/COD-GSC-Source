/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58276.gsc
***********************************************/

init() {
  level._effect["_encstr_8F2C193BCC1ED7B6B436366BDEDCCEB227AF37B13956AC377D660F"] = loadfx("_encstr_855335A4071BC7B8E76A7968BB47B193926F1F215E63BF83CD179810CF6FEBC56B19963535B9FF288C0BF810FB7F412561BA863E4DC281");
  level._effect["_encstr_AB441B5307D859123A03611B77326CC08AD159A8ED2778C0C353731B53"] = loadfx("_encstr_A9A136CE330F97A5EE70AFC439CBB30BD6AC38362C977993BADAC41BCA5E67990FD739BAB6D7B6C239ADB2197D26D8DEED46BE3A9CB04B1B");
  level._effect["_encstr_99F41BCECCE1FAB6A58D63B5DEB9762B39FACD5BB7D656EB1D392CB4B1"] = loadfx("_encstr_9B1834D69D8A50FF43FAF11A63567262E5E060A96783DFBBD7E24633313E255F01308AAD9881AF1C8D30BD0FC87787DB77CB33E7CFDA");
  level._effect["_encstr_99CD208B30A8EF6C90E8AD40504B5CD74E9043688A7B4F32194A82739AB7B3CCCF06"] = loadfx("_encstr_8778349B5E7852D33BFA38383276DC1902696A406E4A72E897C88B9BDD5635B2DBB943902F977318AF8B590178DF8380C907369BC7ED");
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B849136B771CF2D2309B595C5010048AF89DAFB7F5"] = "_encstr_AF861460CFAFD31DAF4B5BC95B3498A998ED4D48851A";
  var_0 = spawnStruct();
  var_0._id_138FD = "_encstr_A9DF0B12E879852F78B8EFE54E";
  var_0.parachute_get_path = getdvarfloat("_encstr_BDB728B01AB28F79F310F0F43DABC3995A61F8F802CD3310AB4F8D6E2F030B0D470938907B2649E8577E", 45);
  var_0.parachuteoverheadwarningprematchtimeoutms = getdvarfloat("_encstr_BD782816114E371E5B324F33A740EB184F5F404B205847029839CBDD57583850206FF470EB925B74D15B", 2.0);
  var_0.spotlight_model = getdvarint("_encstr_84ED2423792E6786B0895F4F8BD80BA3D6963A0A2089673D88DF77308B7357D7FEC942B2EBDE", 2500);
  var_0.parachuteoverheadwarningheight = getdvarfloat("_encstr_91952B4B1146FF1E1831F7D76320E30B6E0E429298118F9510B7F5DA7FA0ABC319608ADA46FD278A3089E1DF05", 1.8);
  var_0.parachutedeploydelay = getdvarfloat("_encstr_95FB2DCD6C39FA9827147BBBAC395D076E7DB5963663D6DB9B3B599CBE33F6B7D1CDA3560E37D723AE9C588ED2DEE6", 1.8);
  var_0.asm_playfacialanim_mp = ::asm_playfacialanim_mp;
  var_0._id_12A35 = ::_id_12A35;
  var_0._id_1449E = ::_id_1449E;
  var_0.isdeathshieldskippingenabled = ::isdeathshieldskippingenabled;
  _keypadscriptableused_bunkeralt::_id_12AF4(var_0);
}

asm_playfacialanim_mp() {
  self._id_1265D = 0;
  self._id_11E08 = 2;
  self.player._id_1282D = 1;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B849136B771CF2D2309B595C5010048AF89DAFB7F5", self.player);
  self.player scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  self.player scripts\mp\utility\perk::giveperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  self.player scripts\mp\utility\perk::giveperk("_encstr_914F16A370BF7614A9F38B9F993B399B21980493A0CF2045");
  self.player scripts\mp\utility\perk::giveperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
  self.player scripts\mp\utility\perk::giveperk("_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392");
  self.player scripts\mp\utility\perk::giveperk("_encstr_ADBE1520D8B843E906A483BA51C3791B2DB02C51D1FB40");
  _id_1353C();
  self.player playlocalsound("_encstr_972C23B607AFC17BEECA93BA1CEB0B6CD1B4D92C1D2BD7B6D2368DADDBDC9D59C9AF0EC69C");
  _keypadscriptableused_bunkeralt::_id_12425(self.player, "_encstr_96C427D2604F723F48EEB4B568B30F7B53182B6BA19F6C9380418FA61C39B38983384372706363CFB9");
}

_id_1449E() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.player endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B730DFFD9982B77A0F0CB574B5080");
  var_0 = 0;

  while(gettime() < self.mp_layover_patch) {
    var_1 = gettime();

    if(var_1 - var_0 >= self._id_12E2D.parachuteoverheadwarningprematchtimeoutms * 1000) {
      thread _id_13ED8();
      thread _id_13341();
      var_0 = gettime();
    }

    waitframe();
  }
}

isdeathshieldskippingenabled() {
  self notify("_encstr_8C631A37D2E6D936AC3AB7E6D71959851BA35ACEC2E856BECC57736C");
  self endon("_encstr_8C631A37D2E6D936AC3AB7E6D71959851BA35ACEC2E856BECC57736C");
  self.player scripts\mp\utility\perk::removeperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  self.player scripts\mp\utility\perk::removeperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
  self.player scripts\mp\utility\perk::removeperk("_encstr_914F16A370BF7614A9F38B9F993B399B21980493A0CF2045");
  self.player scripts\mp\utility\perk::removeperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
  self.player scripts\mp\utility\perk::removeperk("_encstr_AB6D127F07796F1BA8D24DDF5FB80B504DC2B392");
  self.player scripts\mp\utility\perk::removeperk("_encstr_ADBE1520D8B843E906A483BA51C3791B2DB02C51D1FB40");
  self.player._id_1282D = 0;
  self.player lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
  lb_dmg_factor_tail_rotor();

  if(isalive(self.player))
    self.player playlocalsound("_encstr_876A25B6C1AF1CB7BB95935DE0AFC8CA2CD8A3D2EC16D1B2AF6D96B136B6EDE6ECB24EBE38639C");
}

_id_12A35() {
  open_starting_safehouse_door(self._id_12E2D.parachute_get_path);
  self.player playlocalsound("_encstr_B69C256DE1F91AB7B4B93B7323988B1750AF0CE175A0A347489082EAC8E9C70D881B824FD130EA");
  self.player lerpfovbypreset("_encstr_8B880E3B782B3B528F416928DF5B3D4D");
}

_id_11FF1(var_0) {
  if(isDefined(var_0.attacker._id_1282D)) {
    if(var_0.attacker._id_1282D) {
      playFX(scripts\engine\utility::getfx("_encstr_99CD208B30A8EF6C90E8AD40504B5CD74E9043688A7B4F32194A82739AB7B3CCCF06"), var_0.victim.origin);
      var_1 = easepower("_encstr_A5F01AE21AF872F7682F0305C141D943D96310EF5FB20D8B219E2320", var_0.victim.origin);
      var_1 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_863B1B9FEF8A793837C589C1EADF38239263130B9FB2B510445CB6139F");
      var_0.attacker playlocalsound("_encstr_A581272D4FC77BEF6BA05B4F2046CE5217E5B4A5A0E96229D330F70FF0589CDAF770BFDF9E77EB7C7B");
      var_2 = var_0.attacker _keypadscriptableused_bunkeralt::_id_1249C("_encstr_A9DF0B12E879852F78B8EFE54E");
      var_2._id_1265D++;

      if(var_2._id_1265D % 3 == 0) {
        var_3 = clamp(var_2._id_11E08 + 1, 2, 2);
        var_2._id_11E08 = var_3;
      }

      var_4 = (var_2._id_11E08 - 1) * 75;
      var_2.player thread scripts\mp\rank::giverankxp("_encstr_93F620139C7D4ED5AD9836ACAFD6D28D8DB6F6CDB3AC277DB6963636BE98DBB9BAE6", var_4, var_0.objweapon);
      var_2.player thread scripts\mp\rank::scoreeventpopup("_encstr_93F620139C7D4ED5AD9836ACAFD6D28D8DB6F6CDB3AC277DB6963636BE98DBB9BAE6");
    }
  }
}

open_starting_safehouse_door(var_0) {
  self.mp_layover_patch = gettime() + var_0 * 1000;
  self.player thread _keypadscriptableused_bunkeralt::_id_13F7E(undefined, 3, 2);
}

_id_1353C() {
  playFXOnTag(scripts\engine\utility::getfx("_encstr_99F41BCECCE1FAB6A58D63B5DEB9762B39FACD5BB7D656EB1D392CB4B1"), self.player, "_encstr_8EEC09159F6238030BFA23");
  stopfxontagforclients(scripts\engine\utility::getfx("_encstr_99F41BCECCE1FAB6A58D63B5DEB9762B39FACD5BB7D656EB1D392CB4B1"), self.player, "_encstr_8EEC09159F6238030BFA23", self.player);
}

lb_dmg_factor_tail_rotor() {
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_99F41BCECCE1FAB6A58D63B5DEB9762B39FACD5BB7D656EB1D392CB4B1"), self.player, "_encstr_8EEC09159F6238030BFA23");
  self.player playlocalsound("_encstr_876A25B6C1AF1CB7BB95935DE0AFC8CA2CD8A3D2EC16D1B2AF6D96B136B6EDE6ECB24EBE38639C");
}

_id_13341() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.player endon("_encstr_AFE6149356D6DE67CAFAA39385B1D6959CAF075927B6");
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.player thread _id_12BD0();
  self.player scripts\mp\utility\perk::giveperk("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B");
  wait(self._id_12E2D.parachutedeploydelay);
  self.player scripts\mp\utility\perk::removeperk("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B");
  self.player notify("_encstr_AFE6149356D6DE67CAFAA39385B1D6959CAF075927B6");
}

_id_12BD0() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AFE6149356D6DE67CAFAA39385B1D6959CAF075927B6");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  scripts\mp\utility\perk::removeperk("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B");
  self notify("_encstr_AFE6149356D6DE67CAFAA39385B1D6959CAF075927B6");
}

_id_13ED8() {
  var_0 = self.player;
  var_1 = self.player.origin;
  var_2 = self.player.angles;
  var_3 = init_hacking_consoles_internal(var_0, var_1);
  var_4 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
  var_5 = scripts\common\utility::playersinsphere(var_1, self._id_12E2D.spotlight_model);
  var_6 = prematchinitblueprintloadouts(var_1, self._id_12E2D.spotlight_model);

  if(var_6.size)
    var_5 = scripts\engine\utility::array_combine(var_5, var_6);

  self._id_12ED0 = var_5;

  if(var_5.size > 0)
    var_7 = scripts\engine\utility::ter_op(self.player.team == "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");

  foreach(var_9 in var_5) {
    if(!scripts\mp\utility\player::isreallyalive(var_9) || !scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_9)) {
      continue;
    }
    thread c4vehiclemultkill(var_9, var_0, var_3);
    thread c4_placing_bc(var_9, var_0);
  }

  triggerportableradarping(var_1, var_0, self._id_12E2D.spotlight_model, 500, "_encstr_83371CE0BB1D19A37A7D65EB9973E50150DF4088338F9073422350FB2B8B");
}

c4_placing_bc(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.player endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isagent(var_0)) {
    return;
  }
  if(isDefined(var_0) && isDefined(var_1))
    var_2 = playfxontagforclients(scripts\engine\utility::getfx("_encstr_AB441B5307D859123A03611B77326CC08AD159A8ED2778C0C353731B53"), var_0, "_encstr_8EEC09159F6238030BFA23", var_1);

  wait(self._id_12E2D.parachuteoverheadwarningheight / 1.8);

  if(isDefined(var_0) && isDefined(var_1))
    stopfxontagforclients(scripts\engine\utility::getfx("_encstr_AB441B5307D859123A03611B77326CC08AD159A8ED2778C0C353731B53"), var_0, "_encstr_8EEC09159F6238030BFA23", var_1);
}

c4vehiclemultkill(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  var_2.targets[var_3] = var_0;
  var_2.endtimes[var_3] = gettime() + self._id_12E2D.parachuteoverheadwarningheight * 1000.0;
  var_2.outlineids[var_3] = scripts\mp\utility\outline::outlineenableforplayer(var_0, var_1, "_encstr_9A7E14FA431C3079E7859F2B12D6464B1FC28F3CF8F3", "_encstr_BE8F0A272F9B2BE97268AE8B");

  if(isPlayer(var_0) || isbot(var_0)) {}

  var_2 thread _id_13FB1();
  var_0.lastsnapshotgrenadetime = gettime();
  var_1 scripts\mp\damage::combatrecordtacticalstat("_encstr_A15317C13205384F894F55535B939BC0BC0109BB5F76200D02");
  var_1 scripts\mp\utility\stats::incpersstat("_encstr_A5910DC36001AB5F38D063F487B53F", 1);
}

init_hacking_consoles_internal(var_0, var_1) {
  var_2 = undefined;

  if(1) {
    var_2 = spawnStruct();
    var_2.owner = var_0;
    var_2.position = var_1;
    var_2.isalive = 1;
    var_2.targets = [];
    var_2.endtimes = [];
    var_2.outlineids = [];
  }

  return var_2;
}

_id_13FB1() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9B730DFFD9982B77A0F0CB574B5080");

  if(!istrue(self.isalive)) {
    return;
  }
  self notify("_encstr_BD3107D507320BA356");
  self endon("_encstr_BD3107D507320BA356");
  thread _id_13430();

  while(self.targets.size > 0) {
    foreach(var_5, var_1 in self.targets) {
      var_1 = self.targets[var_5];
      var_2 = self.endtimes[var_5];
      var_3 = self.outlineids[var_5];

      if(!scripts\mp\utility\player::isreallyalive(var_1) || gettime() >= var_2) {
        scripts\mp\utility\outline::outlinedisable(var_3, var_1);
        var_4 = isPlayer(var_1);

        if(isDefined(var_1) && var_4)
          var_1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();

        self.targets[var_5] = undefined;
        self.endtimes[var_5] = undefined;
        self.outlineids[var_5] = undefined;
      }
    }

    waitframe();
  }

  thread _id_13431();
}

_id_13430() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BD3107D507320BA356");
  self endon("_encstr_9B730DFFD9982B77A0F0CB574B5080");
  _id_1342F();
  thread _id_13431();
}

_id_1342F() {
  self endon("_encstr_9B730DFFD9982B77A0F0CB574B5080");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;)
    waitframe();
}

_id_13431() {
  self notify("_encstr_AD75063D571AE108");
  self.isalive = 0;

  foreach(var_3, var_1 in self.targets) {
    var_1 = self.targets[var_3];
    var_2 = self.outlineids[var_3];
    scripts\mp\utility\outline::outlinedisable(var_2, var_1);

    if(isDefined(var_1) && (isPlayer(var_1) || isbot(var_1)))
      var_1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
  }
}

prematchinitblueprintloadouts(var_0, var_1) {
  var_2 = prematchinitloadouts(var_0, var_1);
  var_3 = [];
  var_4 = var_1 * var_1;

  foreach(var_6 in var_2) {
    var_7 = distancesquared(var_6.origin, var_0);

    if(var_7 < var_4)
      var_3[var_3.size] = var_6;
  }

  return var_3;
}

prematchinitloadouts(var_0, var_1) {
  var_2 = physics_createcontents(["_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763"]);
  var_3 = (var_1, var_1, var_1);
  var_4 = var_0 - var_3;
  var_5 = var_0 + var_3;
  var_6 = physics_aabbbroadphasequery(var_4, var_5, var_2, []);
  return var_6;
}

isplatepouch() {
  _encstr_86272063EE5BD1037B9032D850808A4F614F53F7470393A82283E9789593B5978ED7::_id_12B21(::isplacementplayerobstructed);
  level thread isplayerbrsquadleader();
}

isplayerbrsquadleader() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.player))
    waitframe();
}

isplacementplayerobstructed(var_0, var_1) {
  var_2 = "_encstr_B40101";

  switch (var_0) {
    case "_encstr_A9081D6AC308055F942D536AAEFAFF7D105BFFCE7FE84A97C7F85B1213CD53":
      level.player _keypadscriptableused_bunkeralt::_id_1393A("_encstr_A9DF0B12E879852F78B8EFE54E");
      break;
    case "_encstr_A2071E8ED533307F1ACBD86002392F28A34C99883EFFD96D49B3B058AA8ADB43":
      var_3 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      easepower("_encstr_95B92103EB79A817D5214DCB499238186968EF535B962BE86183435D382D9F02775813", var_3);
      break;
    case "_encstr_ACA826CD4FD8235F993B60CBB97C156BBAF95F633AD0D0BBF4C945381A4C9BB5313BA057C15B0BD0":
      var_4 = scripts\mp\utility\teams::getteamdata(level.player.team, "_encstr_9775086022BE1B413B8B");
      var_4 = scripts\engine\utility::array_remove(var_4, level.player);
      var_4[randomintrange(0, var_4.size)] _keypadscriptableused_bunkeralt::_id_1393A("_encstr_A9DF0B12E879852F78B8EFE54E");
      break;
    case "_encstr_8D2A237208BEB1066F77DBB71F3B9037EAC3172B5361F9B99883C765B3594867A4AADB7DF9":
      var_5 = scripts\engine\utility::ter_op(level.player.team == "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");
      var_4 = scripts\mp\utility\teams::getteamdata(var_5, "_encstr_9775086022BE1B413B8B");
      var_4[randomintrange(0, var_4.size)] _keypadscriptableused_bunkeralt::_id_1393A("_encstr_A9DF0B12E879852F78B8EFE54E");
      break;
  }
}