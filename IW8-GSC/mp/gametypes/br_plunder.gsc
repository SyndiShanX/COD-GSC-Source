/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_plunder.gsc
***********************************************/

init() {
  level.br_plunder_enabled = getdvarint("_encstr_93560F9B1BC9AFC44EBE1C36BA3746CA4E", 1) != 0;

  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  thread setupplunderextractionsites();
  thermite_linktostuck();
  thermite_watchglstuck();
  level._effect["_encstr_A77412B358622F2289451AD6264959CB68A84F67"] = loadfx("_encstr_AC5632E3B071B5DF9B7337026EA8DF6EF3300B3AE02B0D6B51BB2F3A06CE8FF73D49A323D0D1150F2EAD0A3F1F1667FE9D104ACB");

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_934D17B986DEABD832BA6E593B7BC61913164EC26ECDCA3AE6())
    level._effect["_encstr_A28815D9CC87FA9839BE6C58E61A13B2C28CB2934816CE"] = loadfx("_encstr_86FA2DD99987CB4BDDC1FA8939CBCE0BD65683D8C2E5CBD9333CFA8927BE3BDB8D32FA1358B1DA83166CDA71CE331E");
  else
    level._effect["_encstr_A28815D9CC87FA9839BE6C58E61A13B2C28CB2934816CE"] = loadfx("_encstr_838C2F8C2F33EF80DF42618043AF99AB8A170719469BA72BB65B5998BB0790FFE2BF7B081BF2A1F69A0738188B1ECB152B");

  level.br_plunder_lobby = getdvarint("_encstr_824215B2BE0597E88A966A31952619E72A79A8B7C1BB50", 0) != 0 && istrue(level.allowprematchdamage);
  level.br_plunder = spawnStruct();
  level.br_plunder._id_127BF = 65535;
  level.br_plunder._id_12790 = 0;
  level.br_plunder._id_127AD = 0;
  level.br_plunder._id_1278F = 0;
  level.br_plunder._id_127AC = 0;
  level.br_plunder.wait_for_all_players_in_airlock = 0;
  level.br_plunder.wait_fire_mainhouse_flashbangs_and_smokes = 0;
  level.br_plunder.oscope_freq_think = 0;
  level.br_plunder.oscope_freq = 0;
  level.br_plunder.oscope_sign_think = 0;
  level.br_plunder.oscope_sign = 0;
  level.br_plunder._id_12784 = 0;
  level.delete_on_unloaded = getdvarfloat("_encstr_8B0D1D6ED893FA3193F5078DD5DC8C2B9CBE8C95C247A1D7E80B87EBC16CE8", 3.0);
  level.delete_on_track_delete = getdvarfloat("_encstr_93A41EEA59A06F0A1E9FDBA3E3C8B28D4826A7F7B1281091FAF3B7CB4FEF8AD4", 2.0);
  level.delete_on_exit_icon_trigger_pre_race = getdvarfloat("_encstr_84F41E53C07BC00A53B92789637DD9B27EE70A35E7535481E103E84FE110B179", 5.0);
  setupquantities();
  tracegroundheightexfil();
  toggle_wind();
  level.br_depots = [];
  level thread _id_12788();
  level thread _id_1278D();

  if(inplunderlivelobby()) {
    level.br_plunder_ents = [];
    thread plunderlivelobby();
  }

  toggle_trap();
  _id_1278E();
  _debug_rooftopobjstart::playertimestamp();
  _encstr_8B6D2AA046225F99543B5ADAC9BFCF1BA83BFB2BC9993BD7E918E18B18CBAF63530E2DEF45DF6859EE522AB2::_id_140F9();
  touchdown_origin();
  thermite_watchstucktoterrain();

  if(getdvarint("_encstr_B1921FDC8DC9F559B985C41B5905B1D59B3256C914A5B1B2F4D9CA9CE4A5C856E6", 0) == 1)
    _id_128A7();
}

_id_12788(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_8B7A1187533F0D1369DFC88EF81BD79B148B8D");

  for(;;) {
    level waittill("_encstr_95F112120D99C0D46893093D7142F3E9E21BCFCD");
    var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getvalidplayersinarray(level.players, level.questinfo.defaultfilter);
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroy_jammer_relocate(var_3);
  }
}

_id_1278D() {
  var_0 = getdvarint("_encstr_96A01C373693BE134EF50E8DBAE62356C9AFDC3A2C278EFA16DAF6EAE647", 0);

  if(!var_0) {
    return;
  }
  level waittill("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");

  foreach(var_2 in level.players)
  var_2 playersetplundercount(var_0);
}

_id_11C91(var_0, var_1) {
  if(level.br_plunder_enabled)
    level.br_plunder.vehicle_collision_updateinstance[var_0] = level.br_plunder.vehicle_collision_updateinstance[var_0] + var_1;
}

setupquantities() {
  level.br_plunder._id_12954 = [];
  level.br_plunder.names = [];
  level.br_plunder.vehicle_collision_updateinstance = [];

  foreach(var_2, var_1 in level.br_pickups.counts) {
    if(!issubstr(var_2, "_encstr_930A14BD0A6D08D8BB9153D81BFB052B824FC73393D4")) {
      continue;
    }
    level.br_plunder.names[level.br_plunder.names.size] = var_2;
  }

  for(var_3 = 0; var_3 < level.br_plunder.names.size; var_3++)
    level.br_plunder._id_12954[var_3] = level.br_pickups.counts[level.br_plunder.names[var_3]];

  level.br_plunder.vehicle_collision_updateinstance["_encstr_B2B01D8673D045F77D990F34EB05875150FF8B8E87CBC86068055D822009FA"] = getscriptablelootspawnedcountbyrarity("_encstr_B2B01D8673D045F77D990F34EB05875150FF8B8E87CBC86068055D822009FA");
  level.br_plunder.vehicle_collision_updateinstance["_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922"] = getscriptablelootspawnedcountbyrarity("_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922");
  level.br_plunder.vehicle_collision_updateinstance["_encstr_AB201FCBA509CA5790C63A05BB7864A2DE67473F4FA371052829F54D5098A65996"] = getscriptablelootspawnedcountbyrarity("_encstr_AB201FCBA509CA5790C63A05BB7864A2DE67473F4FA371052829F54D5098A65996");
  level.br_plunder.vehicle_collision_updateinstance["_encstr_99201FC49CB1DBDB1D7D0EB1EAB932CAC9BED858B9A17DABE61BF6DADADB9B7DCC"] = getscriptablelootspawnedcountbyrarity("_encstr_99201FC49CB1DBDB1D7D0EB1EAB932CAC9BED858B9A17DABE61BF6DADADB9B7DCC");
  level.br_plunder.vehicle_collision_updateinstance["_encstr_AC611B9843E4685F3BA1575103B28191425F08083F88265DB212C5F00A"] = getscriptablelootspawnedcountbyrarity("_encstr_AC611B9843E4685F3BA1575103B28191425F08083F88265DB212C5F00A");
  level.br_plunder.vehicle_collision_updateinstance["_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3"] = getscriptablelootspawnedcountbyrarity("_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3");
  level.br_plunder.vehicle_collision_updateinstance["_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926"] = getscriptablelootspawnedcountbyrarity("_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926");
  level.br_plunder.vehicle_collision_updateinstance["_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2"] = getscriptablelootspawnedcountbyrarity("_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2");
  level.br_plunder.vehicle_collision_updateinstance["_encstr_A14F2021F21C08C03BFF69494F429D90BA0189D9DA70D10902F74B4523DADEC87F72"] = getscriptablelootspawnedcountbyrarity("_encstr_A14F2021F21C08C03BFF69494F429D90BA0189D9DA70D10902F74B4523DADEC87F72");
  level.br_plunder.vehicle_collision_updateinstance["_encstr_B4D90E9636AFD277F08057BF3029380A"] = getscriptablelootspawnedcountbyrarity("_encstr_B4D90E9636AFD277F08057BF3029380A");
  level.br_plunder.vehicle_collision_updateinstance["_encstr_A17816F8CBF52F182B5FB1BB6BEF2DE7DDA1C078A28D6333"] = getscriptablelootspawnedcountbyrarity("_encstr_A17816F8CBF52F182B5FB1BB6BEF2DE7DDA1C078A28D6333");

  foreach(var_2, var_1 in level.br_plunder.names) {
    if(!isDefined(level.br_plunder._id_12954[var_2]))
      level.br_plunder.vehicle_collision_updateinstance[var_2] = getscriptablelootspawnedcountbyrarity(var_2);
  }

  if(level.br_plunder.names.size <= 1) {
    return;
  }
  var_5 = 0;

  while(var_5 == 0) {
    var_5 = 1;

    for(var_3 = 0; var_3 < level.br_plunder.names.size - 1; var_3++) {
      if(level.br_plunder._id_12954[var_3] > level.br_plunder._id_12954[var_3 + 1]) {
        var_5 = 0;
        var_6 = level.br_plunder._id_12954[var_3];
        level.br_plunder._id_12954[var_3] = level.br_plunder._id_12954[var_3 + 1];
        level.br_plunder._id_12954[var_3 + 1] = var_6;
        var_7 = level.br_plunder.names[var_3];
        level.br_plunder.names[var_3] = level.br_plunder.names[var_3 + 1];
        level.br_plunder.names[var_3 + 1] = var_7;
      }
    }
  }
}

tracegroundheightexfil() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_847A1AB88B4DF8F97ABAB0A510431DC18303392037E1D3A36323953D"] = "_encstr_A5092238B1579B8C56E4FA0E8D5DCD322B93FAB21E8E4EC2D88EF54E56B8D595CD475932";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83EA1FF3E995CA4C0853C1570A5882F26621C72749307310607BC95EA340D1FBCD"] = "_encstr_B1DD27CBD1BDE264D0BB39FA5078A6FA1D45EF1781656B5938832106C8D0E073E5DD677F3D8E020660";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_821C1E17357BF5A945D3E920E38CA323E2DB18168C7291532DFBE1607FB17B53"] = "_encstr_8A9F265B412D72F4A0CBA96AE0C8360A8DD55F87F1D5FBA9A81351B658405003552DD73BA3F74365";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A52C1853F8633D14C5EE1ED282ABEB67BF28B1768017763DA737"] = "_encstr_ADCC201808C86D08FBE34EF31377D2F7C3CBEF1F58F0AE96ABFB6F80652730A55357";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8A951D88A48B102AEA2A68A9F31BDB2831DC49375E4432182B03D28FCB4D3D"] = "_encstr_A1BA251CC65DDC23569CF51C1BAB3746CA39FAACE1479C0B6C1D7D99C24B36FAC60DB7071CB2E4";
}

toggle_wind() {
  level._id_127C5 = getEntArray("_encstr_B2890CCAB34352DB971BF001B3C9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

playerplaybankanim() {
  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing()) {
    return;
  }
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12616("_encstr_A13E1A4BEE70AF9D569BAFC1B1E59CF5360B9B86FA0DC23723DBCC66", 1.84);
}

playerremoveplunderfrominventory() {
  foreach(var_2, var_1 in self.br_inventory_slots) {
    if(var_1.scriptablename == "_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922") {
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::removeitemfrominventory(var_2);
      return;
    }
  }
}

disablealldepotsforplayer(var_0) {
  for(var_1 = 0; var_1 < level.br_depots.size; var_1++) {
    var_2 = level.br_depots[var_1];

    if(isDefined(var_2) && !istrue(var_2.disabled))
      var_2 depotmakeunusabletoplayer(var_0);
  }
}

enablealldepotsforplayer(var_0) {
  for(var_1 = 0; var_1 < level.br_depots.size; var_1++) {
    var_2 = level.br_depots[var_1];

    if(isDefined(var_2) && !istrue(var_2.disabled))
      var_2 depotmakeusabletoplayer(var_0);
  }
}

depotmakeusabletoplayer(var_0) {
  self enableplayeruse(var_0);

  if(isDefined(self.objectiveiconid))
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objectiveiconid, var_0);
}

depotmakeunusabletoplayer(var_0) {
  self disableplayeruse(var_0);

  if(isDefined(self.objectiveiconid))
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objectiveiconid, var_0);
}

depotmakeunsabletoall() {
  self makeunusable();

  if(isDefined(self.objectiveiconid)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  }
}

initplayer() {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  if(!isDefined(self.plundercount))
    self.plundercount = 0;

  if(!isDefined(self.plunderbanked))
    self.plunderbanked = 0;

  if(!isDefined(self.haspickedupplunderyet))
    self.haspickedupplunderyet = 0;

  if(self.plundercount == 0)
    playersetplundercount(0);
}

playerdropplunder() {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  playersetplundercount(0);
}

bankplunderongameended() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.players) {
    if(isDefined(var_1.plundercount) && var_1.plundercount > 0)
      var_1 _id_12618(var_1.plundercount);
  }
}

playerdropplunderondeath(var_0, var_1) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  if(istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8A4319E0710B51CAC6649BE8B2B33B4DD36D17ABDC83956D875BD0", var_0, var_1))) {
    return;
  }
  var_2 = level.delete_on_track_delete + level.delete_on_unloaded + level.delete_on_exit_icon_trigger_pre_race;
  var_3 = level.delete_on_track_delete / var_2;
  var_4 = level.delete_on_unloaded / var_2;
  var_5 = level.delete_on_exit_icon_trigger_pre_race / var_2;

  if(isDefined(self.plundercount) && self.plundercount > 0)
    var_6 = self.plundercount;
  else
    var_6 = 0;

  var_7 = int(min(var_6, max(2, int(var_6 * var_3))) + 0.5);
  var_8 = int(max(1, int(var_6 * var_5)));
  self.plundercountondeath = var_7;
  playersetplundercount(var_7);

  if(var_8 <= 0) {
    return;
  }
  ml_p3_func(var_8, var_0);
}

takeplunderpickup(var_0) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  var_1 = 1;

  if(isDefined(var_0.count))
    var_1 = var_0.count;

  if(var_1 < 0)
    scripts\mp\utility\script::laststand_dogtags("_encstr_85A0290D6E82FB2744F768309F72FF3BEA140597965E39493D87887823F8306BB3BA571D1CF21D9948BA2A" + var_1 + "_encstr_8F831D810ECBC0B35B9B100DCD7D6A76E03A6B6373EF0A1C216CF710D737BE" + var_0.scriptablename);

  if(scripts\engine\utility::array_contains(level.br_plunder.names, var_0.scriptablename)) {
    _id_12627(var_1);
    level.br_plunder._id_12790 = level.br_plunder._id_12790 + 1;
    level.br_plunder._id_127AD = level.br_plunder._id_127AD + var_1;
    _id_11C91(var_0.scriptablename, -1);
    var_2 = "_encstr_8EAD05E157ED90";

    if(isDefined(var_0.tracknonoobplayerlocation._id_11A40))
      var_2 = var_0.tracknonoobplayerlocation._id_11A40;

    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::_id_13C44(self, var_2, var_1);
  } else
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::trypickupitem(var_0.scriptablename, var_1);
}

_encstr_A3931CF387678A230BBBCA8377B370C34C88DD29E5403FD2B5AABEAB2EEC(var_0) {
  if(!isDefined(level._encstr_BA66153348D733EBA8A57674B5B37FBE01A89ABA805FAA))
    level._encstr_BA66153348D733EBA8A57674B5B37FBE01A89ABA805FAA = [];

  level._encstr_BA66153348D733EBA8A57674B5B37FBE01A89ABA805FAA[level._encstr_BA66153348D733EBA8A57674B5B37FBE01A89ABA805FAA.size] = var_0;
}

toggle_trap() {
  var_0 = [];
  var_0[1] = "_encstr_BEB517C0FAB9B53B07F0B135F633015D11D3A8E8B24FE19393";
  var_0[2] = "_encstr_BEB517C0FAB9B53B07F0B135F633015D11D3A8E8B24FE19393";
  var_0[8] = "_encstr_BEB517C0FAB9B53B07F0B135F633015D11D3A8E8B24FE19393";
  level._id_12621 = var_0;
  var_1 = [];
  var_1[1] = ::_id_12628;
  var_1[2] = ::_id_1261D;
  var_1[8] = ::_encstr_88441B71FCD640354B7BF8C382CBFDD0EA5CD3CB943ED8891BB25109FA;
  var_1[3] = ::_id_12619;
  var_1[4] = ::_id_12624;
  var_1[5] = ::_id_1261B;
  var_1[6] = ::_id_12626;
  level._id_12620 = var_1;
}

_id_12627(var_0, var_1) {
  return _id_1261F(var_0, 1, undefined, var_1);
}

_encstr_B2F0138B9DE9403DB35B79430BFA754093F3512105(var_0, var_1, var_2) {
  return _id_1261F(var_0, 8, var_1, var_2);
}

_id_1261C(var_0, var_1, var_2) {
  return _id_1261F(var_0, 2, var_1, var_2);
}

_id_12618(var_0, var_1, var_2) {
  return _id_1261F(var_0, 3, var_1, var_2);
}

_id_12623(var_0, var_1) {
  return _id_1261F(var_0, 4, undefined, var_1);
}

_id_1261A(var_0, var_1, var_2) {
  return _id_1261F(var_0, 5, var_1, var_2);
}

_id_12625(var_0, var_1, var_2) {
  return _id_1261F(var_0, 6, var_1, var_2);
}

_id_12622(var_0, var_1) {
  return _id_1261F(var_0, 4, undefined, var_1);
}

_id_1261E(var_0, var_1) {
  return _id_1261F(var_0, 4, undefined, var_1);
}

_id_1261F(var_0, var_1, var_2, var_3) {
  if(!istrue(level.br_plunder_enabled) || !isDefined(self.plundercount)) {
    return;
  }
  if(var_1 == 7) {
    if(self.team == var_2.team)
      var_1 = 2;
    else
      var_1 = 8;
  }

  if(var_0 < 0)
    scripts\mp\utility\script::laststand_dogtags("_encstr_883D2AB8FA66B3E9835061E506E3D16DC7C398B093EEA309A755F8DDEE4BB109B73BB04A2B9473187A105A7F" + var_0 + "_encstr_8FE5094681BD6F92B8ED80" + var_1);

  if(var_1 == 2 || var_1 == 3 || var_1 == 4)
    var_0 = int(min(self.plundercount, var_0));
  else if(var_1 == 8)
    var_0 = int(min(var_2._id_127D0, var_0));

  if(!isDefined(self._id_127B8))
    self._id_127B8 = [];

  if(!isDefined(self._id_127B9))
    self._id_127B9 = [];

  if(!isDefined(self.warningclearcallbacks))
    self.warningclearcallbacks = 0;

  var_5 = scripts\engine\utility::ter_op(var_1 == 5, 3, var_1);
  var_6 = level._id_12621[var_5];
  var_7 = self._id_127B9[var_1];
  var_8 = self._id_127B8[var_1];

  if(!isDefined(var_8) || gettime() - var_8 > 2000)
    var_7 = 0;

  var_7 = var_7 + var_0;

  if(isPlayer(self) && isDefined(var_6)) {
    var_9 = int(min(var_7, self.plundercount + var_0));
    self setclientomnvar(var_6, var_9);
  }

  self.warningclearcallbacks = var_1;
  self._id_127B8[var_1] = gettime();
  self._id_127B9[var_1] = var_7;
  var_10 = level._id_12620[var_1];

  if(isDefined(var_10))
    var_3 = self[[var_10]](var_0, var_2, var_3);

  if(isDefined(var_3)) {
    if(isDefined(var_3.player) && !var_3.player _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
      if(isDefined(var_3._id_126AF) && var_3._id_126AF != "_encstr_8BBA05185F8B99") {
        if(var_3._id_126AF != "_encstr_BD1E18894EBE07D8AB9B19ACC9F5CCA5E4E6D1AF83A5366DD5E0" || !istrue(var_3.player.haspickedupplunderyet)) {
          if(isDefined(level._id_127CD)) {
            if(var_0 + self.plundercount > level._id_127CD) {
              var_3.player thread scripts\mp\hud_message::showsplash(var_3._id_126AF);

              if(var_3._id_126AF == "_encstr_BD1E18894EBE07D8AB9B19ACC9F5CCA5E4E6D1AF83A5366DD5E0")
                var_3.player.haspickedupplunderyet = 1;
            }
          } else {
            var_3.player thread scripts\mp\hud_message::showsplash(var_3._id_126AF);

            if(var_3._id_126AF == "_encstr_BD1E18894EBE07D8AB9B19ACC9F5CCA5E4E6D1AF83A5366DD5E0")
              var_3.player.haspickedupplunderyet = 1;
          }
        }
      }

      if(isDefined(var_3._id_12667) && (!isDefined(var_3._id_12668) || var_3._id_12668 > 0))
        var_3.player thread scripts\mp\utility\points::giveunifiedpoints(var_3._id_12667, undefined, var_3._id_12668);
    }

    if(istrue(var_3._id_1244D)) {
      if(var_1 == 3)
        thread playerplaybankanim();
      else if(var_1 == 2 || var_1 == 8)
        thread _id_12615();
    }

    if(isDefined(var_3.amount))
      var_0 = var_3.amount;

    if(istrue(var_3._id_1275C)) {
      var_11 = scripts\engine\utility::ter_op(isDefined(var_3._id_127CC), var_3._id_127CC, var_0);
      _id_1275D(self, var_11);
    }
  }

  switch (var_1) {
    case 4:
    case 3:
    case 2:
      var_0 = var_0 * -1;
      break;
    case 8:
    case 6:
    case 5:
      var_0 = 0;
      break;
    case 1:
      break;
  }

  if(isDefined(var_0)) {
    var_3._id_127B4 = var_0;
    thread playersetplundercount(self.plundercount + var_0, var_3);
  }

  _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::_id_121B6();
  return var_3;
}

_id_140D2(var_0) {
  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case 8:
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
    case 2:
    case 1:
      return 1;
    default:
      return 0;
  }
}

_id_12628(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = init_subway_cars(self);

  if(!istrue(self.haspickedupplunderyet)) {
    var_2._id_126AF = "_encstr_BD1E18894EBE07D8AB9B19ACC9F5CCA5E4E6D1AF83A5366DD5E0";
    thread _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::_id_1334A();
  }

  scripts\cp\vehicles\vehicle_compass_cp::_id_12060(var_0);
  return var_2;
}

_encstr_88441B71FCD640354B7BF8C382CBFDD0EA5CD3CB943ED8891BB25109FA(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = init_subway_cars(self);

  if(!isDefined(var_2._id_1275C)) {
    var_2._id_1275C = 1;
    var_2._id_127CC = undefined;
  }

  if(!isDefined(var_2._id_1244D))
    var_2._id_1244D = 1;

  if(isDefined(var_1)) {
    var_3 = _id_1278C(var_1._id_127C8);
    thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_B89535894ED7CE58D6CA47BC0756BE27C28EBE9C0BD895AFE5DEEA277DA35958DAEBE61DDE8DCABE999CDE6BBE59DCACD65EEB13586ECA", undefined, self.team);
    thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_865830F65A310F91D52708685BF56E9D7A43E006762AC31E857398F0673723D9E2ED65180F538F805707C038A31F592B8BD7", undefined, var_1.team);
    var_1 _encstr_AB941BFD089B7BB5177845F568159050988D6EC28969D3BF33509B95EA(var_0, 1, var_3._encstr_9A3E230F7B8B52C5C0AB85CB40A01D4BE895EBA7E735CB9CA8313A557B682F03BE015F2F51, var_2);
  }

  return var_2;
}

_id_1261D(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = init_subway_cars(self);

  if(!isDefined(var_2._id_1275C)) {
    var_2._id_1275C = 1;
    var_2._id_127CC = undefined;
  }

  if(!isDefined(var_2._id_1244D))
    var_2._id_1244D = 1;

  if(isDefined(var_1)) {
    var_3 = _id_1278C(var_1._id_127C8);

    if(isDefined(var_3.get_closest_enemy_near_turret) && var_3.get_closest_enemy_near_turret > 0) {
      var_4 = var_1._id_127D0 + var_0 - var_3.get_closest_enemy_near_turret;

      if(var_4 >= 0) {
        var_0 = var_0 - var_4;

        if(!istrue(var_1._id_127AE))
          _id_12799(var_1);
      }
    }

    var_5 = 1;

    foreach(var_7 in var_1.plunder) {
      var_8 = var_7.player;

      if(isDefined(var_8) && var_8 == self) {
        var_7.plundercount = var_7.plundercount + var_0;
        var_5 = 0;
        break;
      }
    }

    if(var_5) {
      var_7 = spawnStruct();
      var_7.player = self;
      var_7.team = self.team;
      var_7.plundercount = var_0;
      var_10 = var_1.plunder.size;

      for(var_11 = 0; var_11 < var_1.plunder.size; var_11++) {
        if(!isDefined(var_1.plunder[var_11])) {
          var_10 = var_11;
          break;
        }
      }

      var_1.plunder[var_10] = var_7;
    }
  }

  var_2.amount = var_0;
  var_1._id_127D0 = var_1._id_127D0 + var_0;

  if(!isDefined(level.teamdata[self.team]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"]))
    level.teamdata[self.team]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] = int(var_0);
  else
    level.teamdata[self.team]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] = level.teamdata[self.team]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] + int(var_0);

  return var_2;
}

_id_12619(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = init_subway_cars(self);

  if(!isDefined(var_2._id_126AF))
    var_2._id_126AF = "_encstr_85B5129EB229B071A350221D9EA6EEC8E878A7C9";

  if(!isDefined(var_2._id_12667))
    var_2._id_12667 = scripts\engine\utility::ter_op(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E", "_encstr_8F1219792BCBA880CD325ED19EA39848D2B3CFFFA3B1E110EECF82", "_encstr_BDB50DA8EA73EDB9AF32E8FE39AF60");

  if(!isDefined(var_2._id_12668))
    var_2._id_12668 = int(scripts\mp\rank::getscoreinfovalue(var_2._id_12667) * (var_0 / 10));

  if(!isDefined(var_2._id_1275C)) {
    var_2._id_1275C = 1;
    var_2._id_127CC = undefined;
  }

  if(!isDefined(var_2._id_1244D))
    var_2._id_1244D = 1;

  self.plunderbanked = self.plunderbanked + var_0;

  if(self.plunderbanked > level.br_plunder._id_127BF)
    self.plunderbanked = level.br_plunder._id_127BF;

  if(!isDefined(level.teamdata[self.team]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"]))
    level.teamdata[self.team]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"] = var_0;
  else
    level.teamdata[self.team]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"] = level.teamdata[self.team]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"] + var_0;

  foreach(var_4 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex))
  var_4 scripts\cp\vehicles\vehicle_compass_cp::_id_12004("_encstr_A2AF098C6BF4FA892CE6DA", var_0);

  return var_2;
}

_id_12624(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = init_subway_cars(self);

  return var_2;
}

_id_1261B(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = init_subway_cars(self);

  if(!isDefined(var_2._id_127CC))
    var_2._id_127CC = 0;

  var_2._id_131AB = 1;
  var_3 = self.team;

  if(isDefined(var_1) && isDefined(var_1.plunder)) {
    foreach(var_6, var_5 in var_1.plunder) {
      if(isDefined(var_5.player) && var_5.player == self) {
        var_3 = var_5.team;

        if(!isDefined(var_0))
          var_0 = var_5.plundercount;
        else
          var_0 = min(var_0, var_5.plundercount);

        var_5.plundercount = var_5.plundercount - var_0;

        if(var_5.plundercount == 0)
          var_1.plunder[var_6] = undefined;

        self.plunderbanked = self.plunderbanked + var_0;

        if(self.plunderbanked > level.br_plunder._id_127BF)
          self.plunderbanked = level.br_plunder._id_127BF;

        break;
      }
    }

    if(!isDefined(var_2._id_12667))
      var_2._id_12667 = scripts\engine\utility::ter_op(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E", "_encstr_8F1219792BCBA880CD325ED19EA39848D2B3CFFFA3B1E110EECF82", "_encstr_BDB50DA8EA73EDB9AF32E8FE39AF60");

    if(!isDefined(var_2._id_12668))
      var_2._id_12668 = int(scripts\mp\rank::getscoreinfovalue(var_2._id_12667) * (var_0 / 10));
  }

  var_0 = int(var_0);
  level.teamdata[var_3]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] = level.teamdata[var_3]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] - var_0;
  level.teamdata[var_3]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"] = level.teamdata[var_3]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"] + var_0;

  foreach(var_8 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex))
  var_8 scripts\cp\vehicles\vehicle_compass_cp::_id_12004("_encstr_A2AF098C6BF4FA892CE6DA", var_0);

  return var_2;
}

_id_12626(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = init_subway_cars(self);

  var_2._id_131AB = 1;
  var_3 = self.team;

  if(isDefined(var_1) && isDefined(var_1.plunder)) {
    foreach(var_6, var_5 in var_1.plunder) {
      if(isDefined(var_5.player) && var_5.player == self) {
        var_3 = var_5.team;

        if(!isDefined(var_0))
          var_0 = var_5.plundercount;
        else
          var_0 = min(var_0, var_5.plundercount);

        var_5.plundercount = var_5.plundercount - var_0;

        if(var_5.plundercount == 0)
          var_1.plunder[var_6] = undefined;

        break;
      }
    }
  }

  var_0 = int(var_0);
  level.teamdata[var_3]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] = level.teamdata[var_3]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] - var_0;
  return var_2;
}

num_players_in_safehouse(var_0) {
  var_1 = istrue(level._encstr_A28B1623D2DC8589362B38B1D5DC32B22789C237AD4BCD9D);

  if(!isDefined(self.plunder)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = init_subway_cars();

  var_0.brwatchforminplayersmatchstart = 0;
  var_0.teams = [];
  var_0._id_11F3A = 0;

  foreach(var_6, var_3 in self.plunder) {
    if(isDefined(var_3.player) || var_3.plundercount <= 0) {
      continue;
    }
    var_4 = var_3.team;
    var_5 = var_3.plundercount;

    if(!var_1) {
      level.teamdata[var_4]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] = level.teamdata[var_4]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] - var_5;
      level.teamdata[var_4]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"] = level.teamdata[var_4]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"] + var_5;
    }

    var_0.brwatchforminplayersmatchstart = var_0.brwatchforminplayersmatchstart + var_5;
    var_0.teams[var_0.teams.size] = var_4;
    self.plunder[var_6] = undefined;
  }

  foreach(var_3 in self.plunder) {
    if(var_3.plundercount <= 0) {
      continue;
    }
    var_8 = var_3.player;
    var_4 = var_3.team;
    var_5 = var_3.plundercount;
    var_9 = undefined;

    if(isDefined(var_0))
      var_9 = ignoregulagredeploysplash(var_0, var_8, var_4);

    if(!var_1)
      var_9 = var_8 _id_1261A(var_5, self, var_9);

    if(isDefined(var_9) && isDefined(var_9.amount))
      var_5 = var_9.amount;

    var_0.brwatchforminplayersmatchstart = var_0.brwatchforminplayersmatchstart + var_5;
    var_0.teams[var_0.teams.size] = var_4;
    var_0._id_11F3A++;
  }

  var_0.teams = scripts\engine\utility::array_remove_duplicates(var_0.teams);
  var_11 = 0;

  if(var_0.teams.size > 1)
    var_11 = 1;
  else if(var_0.teams.size == 1 && var_0.teams[0] != self.team)
    var_11 = 1;

  var_12 = _id_1278C(self._id_127C8, undefined, 1);

  if(isDefined(var_12) && isDefined(var_12.outline_enemy_ai_for_duration))
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detonatefx(var_0._id_11F3A, var_0.brwatchforminplayersmatchstart, var_12.outline_enemy_ai_for_duration, var_11, self.origin);

  self.plunder = [];
  return var_0;
}

_encstr_AB941BFD089B7BB5177845F568159050988D6EC28969D3BF33509B95EA(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.plunder)) {
    return;
  }
  if(!isDefined(var_3))
    var_3 = init_subway_cars();

  var_3.brwatchforminplayersmatchstart = 0;
  var_3.teams = [];
  var_4 = var_0;

  foreach(var_9, var_6 in self.plunder) {
    if(var_4 <= 0) {
      break;
    }

    if(isDefined(var_6.player) || var_6.plundercount <= 0) {
      continue;
    }
    var_7 = var_6.team;
    var_8 = min(var_6.plundercount, var_4);
    var_6.plundercount = var_6.plundercount - var_8;
    level.teamdata[var_7]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] = level.teamdata[var_7]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] - var_8;
    var_4 = var_4 - var_8;
    self._id_127D0 = self._id_127D0 - var_8;
    var_3.brwatchforminplayersmatchstart = var_3.brwatchforminplayersmatchstart + var_8;
    var_3.teams[var_3.teams.size] = var_7;

    if(var_6.plundercount == 0)
      self.plunder[var_9] = undefined;
  }

  foreach(var_6 in self.plunder) {
    if(var_4 <= 0) {
      break;
    }

    if(var_6.plundercount <= 0) {
      continue;
    }
    var_11 = var_6.player;
    var_7 = var_6.team;
    var_8 = min(var_6.plundercount, var_4);
    var_12 = undefined;

    if(isDefined(var_3))
      var_12 = ignoregulagredeploysplash(var_3, var_11, var_7);

    var_11 _id_12625(var_8, self, var_12);

    if(isDefined(var_12) && isDefined(var_12.amount))
      var_8 = var_12.amount;

    var_4 = var_4 - var_8;
    self._id_127D0 = self._id_127D0 - var_8;
    var_3.brwatchforminplayersmatchstart = var_3.brwatchforminplayersmatchstart + var_8;
    var_3.teams[var_3.teams.size] = var_7;
  }

  if(istrue(var_1)) {
    var_14 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
    dropplunderbyrarity(var_0, var_14, var_2);
  }

  if(self._id_127D0 <= 0) {
    self._id_127D0 = 0;
    var_3.amount = 0;
  }

  if(level.teamdata[self.team]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] < 0)
    level.teamdata[self.team]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] = 0;

  return var_3;
}

num_rocket_per_attack(var_0, var_1, var_2) {
  if(!isDefined(self.plunder)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = init_subway_cars();

  var_2.brwatchforminplayersmatchstart = 0;
  var_2.teams = [];
  var_3 = 0;

  foreach(var_8, var_5 in self.plunder) {
    if(isDefined(var_5.player) || var_5.plundercount <= 0) {
      continue;
    }
    var_6 = var_5.team;
    var_7 = var_5.plundercount;
    level.teamdata[var_6]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] = level.teamdata[var_6]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] - var_7;
    var_2.brwatchforminplayersmatchstart = var_2.brwatchforminplayersmatchstart + var_7;
    var_2.teams[var_2.teams.size] = var_6;
    self.plunder[var_8] = undefined;
  }

  foreach(var_5 in self.plunder) {
    if(var_5.plundercount <= 0) {
      continue;
    }
    var_10 = var_5.player;
    var_6 = var_5.team;
    var_7 = var_5.plundercount;
    var_11 = undefined;

    if(isDefined(var_2))
      var_11 = ignoregulagredeploysplash(var_2, var_10, var_6);

    var_10 _id_12625(var_7, self, var_11);

    if(isDefined(var_11) && isDefined(var_11.amount))
      var_7 = var_11.amount;

    var_2.brwatchforminplayersmatchstart = var_2.brwatchforminplayersmatchstart + var_7;
    var_2.teams[var_2.teams.size] = var_6;
    var_3 = var_3 + var_7;
  }

  self.plunder = [];

  if(istrue(var_0)) {
    var_13 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
    dropplunderbyrarity(var_2.brwatchforminplayersmatchstart, var_13, var_1);
  }

  return var_2;
}

init_subway_cars(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.player = undefined;

  if(isDefined(var_0))
    var_2.player = var_0;

  var_2._id_126AF = undefined;
  var_2._id_12667 = undefined;
  var_2._id_12668 = undefined;
  var_2._id_131AB = undefined;
  var_2._id_1275C = undefined;
  var_2._id_127CC = undefined;
  var_2._id_1244D = undefined;
  return var_2;
}

ignoregulagredeploysplash(var_0, var_1, var_2) {
  var_3 = init_subway_cars();

  if(isDefined(var_0.player)) {
    var_3.player = var_0.player;
    var_1 = var_0.player;
  } else if(isDefined(var_1))
    var_3.player = var_1;

  if(isDefined(var_0._id_126AF))
    var_3._id_126AF = var_0._id_126AF;

  if(isDefined(var_0._id_12667))
    var_3._id_12667 = var_0._id_12667;

  if(isDefined(var_0._id_12668))
    var_3._id_12668 = var_0._id_12668;

  if(isDefined(var_0._id_131AB))
    var_3._id_131AB = var_0._id_131AB;

  if(isDefined(var_0._id_1275C))
    var_3._id_1275C = var_0._id_1275C;

  if(isDefined(var_0._id_127CC))
    var_3._id_127CC = var_0._id_127CC;

  if(isDefined(var_0._id_1244D))
    var_3._id_1244D = var_0._id_1244D;

  return var_3;
}

playersetplundercount(var_0, var_1) {
  if(!isDefined(self.plundercount))
    self.plundercount = 0;

  var_2 = self.plundercount;
  var_3 = var_0 - self.plundercount;

  if((!isDefined(var_1) || !istrue(var_1._id_131AB)) && var_3 == 0) {
    return;
  }
  self.plundercount = var_0;

  if(self.plundercount > level.br_plunder._id_127BF) {
    scripts\mp\hud_message::showerrormessage("_encstr_9B4C28F7D3C1EEFAB9D4ED0F576F2F6F91692141D9D7EAC9C81750D18958C40D2159C099BD419E70A57D");
    self.plundercount = level.br_plunder._id_127BF;
  }

  if(isDefined(self.petwatch))
    scripts\cp_mp\pet_watch::_id_1206D();

  var_4 = self.plundercount;
  _id_1268A(var_4);

  if(var_0 > 0) {
    if(istrue(level._id_127D4) && var_3 != 0)
      _id_12781(self, 1, 1);

    enablealldepotsforplayer(self);

    if(inplunderlivelobby() && var_0 >= 10)
      thread playerdelayautobankplunder();
  } else {
    if(istrue(level._id_127D4) && var_3 != 0)
      _id_12781(self, 0, 1);

    disablealldepotsforplayer(self);
  }

  if(isDefined(level.teamdata[self.team]["_encstr_813D11B9340B207DDF63B7993A973D70E39139"]) && isDefined(var_1) && isDefined(var_1._id_127B4)) {
    if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15")
      level.teamdata[self.team]["_encstr_813D11B9340B207DDF63B7993A973D70E39139"] = level.teamdata[self.team]["_encstr_813D11B9340B207DDF63B7993A973D70E39139"] + (self.plundercount - var_2);
    else
      level.teamdata[self.team]["_encstr_813D11B9340B207DDF63B7993A973D70E39139"] = level.teamdata[self.team]["_encstr_813D11B9340B207DDF63B7993A973D70E39139"] + var_1._id_127B4;
  }

  thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_96F00CAFF7571301BDFBC0989252", var_1);

  if(isDefined(level._encstr_BA66153348D733EBA8A57674B5B37FBE01A89ABA805FAA)) {
    foreach(var_6 in level._encstr_BA66153348D733EBA8A57674B5B37FBE01A89ABA805FAA)[[var_6]](var_1);
  }
}

_id_1268A(var_0) {
  [var_2, var_3, var_4] = _id_12577();
  var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_at_max(self.team, self.squadindex, var_4);

  if(!isDefined(var_5))
    var_5 = 0;

  var_6 = respawn_used_once(var_0, var_5, var_2, var_3);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_131C3(self.team, self.squadindex, var_4, var_6);
  var_7 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var_9 in var_7) {
    if(isbot(var_9) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
      continue;
    }
    var_9 setclientomnvar(var_4, var_6);
  }
}

respawn_used_once(var_0, var_1, var_2, var_3) {
  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (var_0 &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = var_1 &var_6;
  var_8 = var_7 + var_5;
  return var_8;
}

_id_12577() {
  var_0 = 0;
  var_1 = 0;
  var_2 = "_encstr_B40101";

  switch (self.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]) {
    case 1:
      [var_0, var_1, var_2] = [0, 16, "_encstr_8B2E14E0DA99951B271051D51613217D7182B87802EB"];
      break;
    case 2:
      [var_0, var_1, var_2] = [16, 16, "_encstr_8B2E14E0DA99951B271051D51613217D7182B87802EB"];
      break;
    case 3:
      [var_0, var_1, var_2] = [0, 16, "_encstr_A799156584291D9B8F0BA0100BCC317571AED0EDDD7345"];
      break;
    case 4:
      [var_0, var_1, var_2] = [16, 16, "_encstr_A799156584291D9B8F0BA0100BCC317571AED0EDDD7345"];
      break;
    default:
      break;
  }

  return [var_0, var_1, var_2];
}

dangercircletick(var_0, var_1) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  var_2 = var_1 * var_1;

  for(var_3 = 0; var_3 < level.br_depots.size; var_3++) {
    var_4 = level.br_depots[var_3];

    if(isDefined(var_4) && !istrue(var_4.disabled) && distance2dsquared(var_0, var_4.origin) > var_2) {
      var_4.disabled = 1;
      var_4 depotmakeunsabletoall();
    }
  }

  for(var_3 = 0; var_3 < level.br_plunder_sites.size; var_3++) {
    var_5 = level.br_plunder_sites[var_3];

    if(isDefined(var_5) && !istrue(var_5.disabled) && distance2dsquared(var_0, var_5.origin) > var_2) {
      var_5.disabled = 1;
      var_5 setscriptablepartstate(var_5.type, var_5.load_relics_from_playlistdvars);
    }
  }
}

_id_12615() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12518() || self isgestureplaying()) {
    return;
  }
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12616("_encstr_A13E1A4BEE70AF9D569BAFC1B1E59CF5360B9B86FA0DC23723DBCC66", 1.84);
}

cratedropplunder() {
  if(!isDefined(self.plunder)) {
    return;
  }
  var_0 = 0;

  for(var_1 = 0; var_1 < self.plunder.size; var_1++)
    var_0 = var_0 + self.plunder[var_1].plundercount;

  self.angles = (0, 0, 0);
  var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  dropplunderbyrarity(var_0, var_2);
}

dropplundersounds(var_0, var_1) {
  if(var_1 <= 0) {
    return;
  }
  var_2 = var_0 + (0, 0, 24);
  var_3 = "_encstr_B40101";
  wait 0.5;

  switch (var_1) {
    case 0:
      break;
    case 1:
      var_3 = "_encstr_9A97135B4591D7B535F777D9552B1A58B530E7727B";
      break;
    case 2:
      var_3 = "_encstr_BA97132D76292433F758190393D0951252E3C7C077";
      break;
    case 3:
      var_3 = "_encstr_A99713561A17E195AD7B790852C3753957A270F733";
      break;
    case 4:
      var_3 = "_encstr_A29713E9D8185C6B7D23F18BAACBD31B7205D18AF2";
      break;
    case 5:
      var_3 = "_encstr_B19713C01B8F412D32A21897BDCB4D091DA3A1CAEE";
      break;
    case 6:
    default:
      var_3 = "_encstr_B497134CE4F58CE4ED0EEB078D5D378C2B93AF18C6";
      break;
  }

  playsoundatpos(var_2, var_3);
}

dropplunderbyrarity(var_0, var_1, var_2, var_3) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  var_4 = [];
  var_5 = [];
  var_6 = 0;
  var_7 = 6;

  if(isDefined(var_2))
    var_7 = var_2;

  for(var_8 = level.br_plunder._id_12954.size - 1; var_8 >= 0; var_8--) {
    var_5[var_8] = int(var_0 / level.br_plunder._id_12954[var_8]);
    var_5[var_8] = int(clamp(var_5[var_8], 0, var_7 - var_6));
    var_6 = var_6 + var_5[var_8];

    if(var_0 <= 0 || var_6 >= var_7) {
      break;
    } else
      var_0 = var_0 - var_5[var_8] * level.br_plunder._id_12954[var_8];
  }

  for(var_9 = level.br_plunder._id_12954.size - 1; var_9 >= 0; var_9--) {
    if(!isDefined(var_5[var_9])) {
      continue;
    }
    for(var_10 = 0; var_10 < var_5[var_9]; var_10++) {
      var_11 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, self.origin, self.angles, self, var_3);
      var_12 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(level.br_plunder.names[var_9], var_11, level.br_plunder._id_12954[var_9], 1);
      _id_11C91(level.br_plunder.names[var_9], 1);

      if(isDefined(var_12)) {
        var_4[var_4.size] = var_12;

        if(inplunderlivelobby())
          level.br_plunder_ents[level.br_plunder_ents.size] = var_12;
      }
    }
  }

  level.br_plunder._id_1278F = level.br_plunder._id_1278F + var_6;
  level.br_plunder._id_127AC = level.br_plunder._id_127AC + var_0;
  level thread dropplundersounds(self.origin, var_4.size);
  return var_4;
}

ml_p3_func(var_0, var_1) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  var_2 = [];
  var_3 = [];
  var_4 = 0;

  for(var_5 = level.br_plunder.names.size - 1; var_5 >= 0; var_5--) {
    if(var_0 >= level.br_plunder._id_12954[var_5]) {
      var_4 = var_5;
      break;
    }
  }

  var_6 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
  var_7 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(level.br_plunder.names[var_4], var_6, var_0, 1);
  _id_11C91(level.br_plunder.names[var_4], 1);

  if(isDefined(var_7)) {
    var_2[var_2.size] = var_7;

    if(inplunderlivelobby())
      level.br_plunder_ents[level.br_plunder_ents.size] = var_7;
  }

  level.br_plunder._id_1278F++;
  level.br_plunder._id_127AC = level.br_plunder._id_127AC + var_0;
  level thread dropplundersounds(self.origin, var_2.size);
  return var_2;
}

updateplayerspawninputtype() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_ADF20D88BB7DC8C9AA6A4653C3822F"))
    return 0;

  return istrue(level.br_plunder_enabled) && level.br_plunder_sites.size != 0 && getdvarint("_encstr_86ED156F67A669FA93669A65DB1804027E87E7BFE145D3", 0) != 0;
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

thermite_linktostuck() {
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_AAE208481F244BE0C2E3"] = % _encstr_997517F83389FE757DD960136FC8FCF8B64192C9816B8F22CD;
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_8A7A0A5BA3208BF9C830903B"] = % _encstr_97891980DB4A08B002C77151F5ED48ED9BB13889D2A740B81DDF79;
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_873A093C894049E9A0FBDB"] = % _encstr_87DB18EA7737AEE3D61150515B821DFB6B7978E7E4DB6F807B90;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

thermite_watchglstuck() {
  level.scr_animtree["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"] = #animtree;
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_BD990893ED1CCAF55ACD"] = % _encstr_84011C96BBC1F5C4E4AFE0B157CDC82B9CBE0DB2D85ABE93F61C59FAB49B;
  level.scr_animname["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_BD990893ED1CCAF55ACD"] = "_encstr_84011C96BBC1F5C4E4AFE0B157CDC82B9CBE0DB2D85ABE93F61C59FAB49B";
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_A19E0A123871C2C710D81773"] = % _encstr_8B8C1EE40B825702BD61AA58ADEDE943AEE7E4D1687351DAE7617AFF789FB80A;
  level.scr_animname["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_A19E0A123871C2C710D81773"] = "_encstr_8B8C1EE40B825702BD61AA58ADEDE943AEE7E4D1687351DAE7617AFF789FB80A";
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_A38109E4ED0E2BD7DBBA1D"] = % _encstr_BDA71D1B174F60C0AA09EB60AB6E28A5034F919BD3E22808DFDA711ED55DE0;
  level.scr_animname["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_A38109E4ED0E2BD7DBBA1D"] = "_encstr_BDA71D1B174F60C0AA09EB60AB6E28A5034F919BD3E22808DFDA711ED55DE0";
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_97F90789B0ECFA4BDC"] = % _encstr_85B11B6CDBF26F0A1E9FDBA3E3C8B28D4826A4F710C02742FFF75FAF2D;
  level.scr_animname["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_97F90789B0ECFA4BDC"] = "_encstr_85B11B6CDBF26F0A1E9FDBA3E3C8B28D4826A4F710C02742FFF75FAF2D";
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_A5C209C167CF81186227AB"] = % _encstr_9A711DF9348AF71E658173AAC88557D77B88706DC1C8AF266BA889A230EF0A;
  level.scr_animname["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_A5C209C167CF81186227AB"] = "_encstr_9A711DF9348AF71E658173AAC88557D77B88706DC1C8AF266BA889A230EF0A";
  level.scr_anim["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_AB33087537C218C0B5DB"] = % _encstr_A3961CCB8750B988EB11C08858DA49B515F7F00BC221F12A07D8C9F77FA5;
  level.scr_animname["_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192"]["_encstr_AB33087537C218C0B5DB"] = "_encstr_A3961CCB8750B988EB11C08858DA49B515F7F00BC221F12A07D8C9F77FA5";
}

thermite_watchstucktoterrain() {
  var_0 = [];
  var_1 = _id_1278C("_encstr_8A5110B3A5B5B0F59A1B492B5B62C70B7C6A", 1);
  var_1._id_12F7D = "_encstr_A1EB22D00BAC5067F3799FA9CB6A49D91A2760F8FB6A29379B9C18A0A9539BA3758F523A";
  var_0[var_0.size] = var_1;
  var_1 = _id_1278C("_encstr_A65110D9546B401DBF0314B9CAA7CFE0C7E2", 1);
  var_1._id_12F7D = "_encstr_93EB22233820DF425110DAD56D3DAA9D4BE9B7D3E01B094A7913654D40EFB234F1815A72";
  var_0[var_0.size] = var_1;
  var_1 = _id_1278C("_encstr_B4AB16DF8A20F26AC6994BF781FB4359081715A320F8AD93", 1);
  var_1._id_12F7D = "_encstr_9B62228A0D88354FCD16135BB9A6FBE168A114024388BBC776C8BB42C67FD323E871BD8A";
  var_0[var_0.size] = var_1;
  var_1 = _id_1278C("_encstr_B4F91169D8BC587FE20B7123436A3F1844BE77", 1);
  var_1._id_12F7D = "_encstr_82051D5B3350BFC763E1A74DB1A2053F7DC13BAAB36A2C2F47F3A078F7A0EA";
  var_0[var_0.size] = var_1;

  foreach(var_1 in var_0) {
    var_1.type = 1;
    var_1.usetime = 0;
    var_1._id_14077 = 3;
    var_1._id_14075 = getdvarint("_encstr_85B81916A3409F7F8033829D150364E8F868672BBB57411DB71D9B", 20000);
    var_1._id_13ACC = 0;
    var_1._id_14078 = "_encstr_88CC216B6F170BA5D5C6B04D3718CF6FEF06EFB34123FB1FB047B1284DABC0D91F3C80";
    var_1._id_14079 = "_encstr_AFA624CCB72ED5C955FD3863D1CC03C17FE7270366342F5A180E0CD57B035720F9033968E487";
    var_1._id_12F7E = "_encstr_9ADD1516C68EB4ECB246560E7B6E963AB1AB4E9C56B91D";
    var_1._id_12F77 = "_encstr_A1120FEC2DB9D24C36951BD593392B9BD1";
    var_1.origin_delta = 0;
    var_1.overrideviewkickscaledmr = getdvarint("_encstr_959D19BFB756991863F3CD57E9A8787221DBF75733F0F3C4F09BC5", 30);
    var_1.original_disablelongdeath = "_encstr_ACA41A3C1FFFFD87594B775905E11310A9AB55212C50FF9E07389718";
    var_1.get_closest_enemy_near_turret = 0;
    var_1.impactwatcher = ::smokekill;
    var_1.org_in_bad_place = ::snowfx;
    var_1.carriable_error_messsage_watch = ::smodelcollections;
    var_1.outline_enemy_ai_for_duration = "_encstr_9A8F0CB1A5E8471BB2EB894B39C8";
  }
}

retrieve_data_objective() {
  var_0 = [];

  if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    var_0 = getentitylessscriptablearrayinradius("_encstr_B2890CCAB34352DB971BF001B3C9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = getentitylessscriptablearrayinradius("_encstr_B4AE155687E84E85C6E8BE1C2CC8F54CF67395F20B4E91", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_1.size > 0)
      var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  } else {
    var_2 = getentitylessscriptablearrayinradius("_encstr_B80816928CB878D80772CF12C821C5CF576181DDEA692AA7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3 = getentitylessscriptablearrayinradius("_encstr_AC08165103E38098A55A2679C09C604F3ACBFBE7F3A97712", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_0 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  if(var_0.size > 0) {
    foreach(var_5 in var_0) {
      var_5.audio_shf_kill_hangar_lights = "_encstr_930B07BB1B6B3854FF";
      var_5.audio_jugg_spawn = "_encstr_B43F0E4671B87173BD8FD73315553AA4";
      var_5.load_relics_from_playlistdvars = "_encstr_BE8B08E323FB2BCD6268";
      var_5.little_bird_onexitheavydamagestate = "_encstr_BE8B08E323FB2BCD6268";
    }

    return var_0;
  } else {
    var_0 = getentitylessscriptablearrayinradius("_encstr_96331352D92BF55061F5894D5ACB7A117F9887626E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_5 in var_0) {
      var_5.audio_shf_kill_hangar_lights = "_encstr_BE8B08E323FB2BCD6268";
      var_5.audio_jugg_spawn = "_encstr_A1120FEC2DB9D24C36951AD593392B9BD1";
      var_5.load_relics_from_playlistdvars = "_encstr_95DF070DD22319CA9B";
    }

    return var_0;
  }
}

setupplunderextractionsites() {
  level.br_plunder_sites = retrieve_data_objective();
  level.delete_old_gate = [];
  level.delete_old_gate[level.delete_old_gate.size] = "_encstr_BA511F1EBE517AFF1B61631B1870AC820540A71025D5523BE3C8270B318B695BF3";
  level.delete_old_gate[level.delete_old_gate.size] = "_encstr_A1EB22D00BAC5067F3799FA9CB6A49D91A2760F8FB6A29379B9C18A0A9539BA3758F523A";
  level.delete_old_gate[level.delete_old_gate.size] = "_encstr_93EB22233820DF425110DAD56D3DAA9D4BE9B7D3E01B094A7913654D40EFB234F1815A72";
  level.delete_old_gate[level.delete_old_gate.size] = "_encstr_82051D5B3350BFC763E1A74DB1A2053F7DC13BAAB36A2C2F47F3A078F7A0EA";
  level.delete_old_gate[level.delete_old_gate.size] = "_encstr_9B62228A0D88354FCD16135BB9A6FBE168A114024388BBC776C8BB42C67FD323E871BD8A";
  level.delete_on_death_or_dissconnect = [];
  level.delete_on_death_or_dissconnect[level.delete_on_death_or_dissconnect.size] = "_encstr_930B07BB1B6B3854FF";
  level.delete_on_death_or_dissconnect[level.delete_on_death_or_dissconnect.size] = "_encstr_ADB6081B579B6B508D62";
  level.delete_on_death_or_dissconnect[level.delete_on_death_or_dissconnect.size] = "_encstr_B43F0E4671B87173BDCFD73315553AA4";
  level.delete_on_death_or_dissconnect[level.delete_on_death_or_dissconnect.size] = "_encstr_8B1613E94F28D44B25F1F38BFB0D73CB90236778C9";
  level.delete_on_death_or_dissconnect[level.delete_on_death_or_dissconnect.size] = "_encstr_A1120FEC2DB9D24C36951BD593392B9BD1";

  if(!updateplayerspawninputtype()) {
    var_0 = getEntArray("_encstr_8CE11A32A0804662ADFD6F9FF1CDCB81C84BEC7D587906CAFEDB9FB3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_2 in var_0)
    var_2 delete();

    foreach(var_5 in level.br_plunder_sites)
    var_5 setscriptablepartstate(var_5.type, "_encstr_95DF070DD22319CA9B");

    level.br_plunder_sites = [];
    return;
  }

  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  scripts\engine\scriptable::scriptable_addusedcallback(::plundersiteused);

  if(isDefined(level._id_11B3F) && level._id_11B3F > 0 && !istrue(level._id_14086))
    wait(level._id_11B3F);
  else if(istrue(level._id_14086))
    scripts\mp\flags::gameflagwait("_encstr_811D12412EE567151F4DB94E919A9269AFA20A3F");

  foreach(var_8 in level.players) {
    if(isDefined(var_8)) {
      if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
        var_8 scripts\mp\hud_message::showsplash("_encstr_877E16A6CD615B82FC4B7068BB3F5883FA74B0B6E3FA3D4B");
    }
  }

  foreach(var_5 in level.br_plunder_sites) {
    var_11 = scripts\engine\utility::ter_op(istrue(level._id_13368) && !istrue(level._id_13363), var_5.audio_jugg_spawn, var_5.audio_shf_kill_hangar_lights);
    var_5 setscriptablepartstate(var_5.type, var_11);
  }
}

register_vfx() {
  if(!updateplayerspawninputtype()) {
    return;
  }
  var_0 = retrieve_data_objective();
  return var_0;
}

_id_1314B(var_0) {
  foreach(var_2 in level.br_plunder_sites) {
    if(!scripts\engine\utility::array_contains(var_0, var_2))
      var_2 setscriptablepartstate(var_2.type, "_encstr_95DF070DD22319CA9B");
  }

  level.br_plunder_sites = var_0;
}

isspecialistbonus(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin + (0, 0, 1000));
  var_1 setModel("_encstr_B2681F23E5D0519E0729F97F8B2D1BC8E008509FEFB8B208F0D4A3F34965024858");
  var_2 = var_0.origin[0];
  var_3 = var_0.origin[1];
  var_4 = 800;
  var_5 = var_1 tracegroundpoint(var_2, var_3);
  var_6 = var_5 + var_4;
  var_7 = (var_2, var_3, var_6);
  var_1.origin = var_7;

  for(;;)
    waitframe();
}

plundersiteused(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || !isDefined(var_3)) {
    return;
  }
  if(!isDefined(level.delete_old_gate) || !isDefined(level.delete_on_death_or_dissconnect)) {
    return;
  }
  var_5 = 1;

  foreach(var_7 in level.delete_old_gate) {
    if(var_7 != var_1) {
      continue;
    }
    var_5 = 0;
    break;
  }

  if(var_5) {
    return;
  }
  var_5 = 1;

  foreach(var_10 in level.delete_on_death_or_dissconnect) {
    if(var_10 != var_2) {
      continue;
    }
    var_5 = 0;
    break;
  }

  if(var_5) {
    return;
  }
  thread plundersiteusedinternal(var_0, var_1, var_2, var_3);
}

plundersiteusedinternal(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.disabled)) {
    return;
  }
  if(isDefined(var_0.heli)) {
    var_3 playerdenyextraction(undefined, &"_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");
    return;
  }

  var_4 = scripts\engine\utility::ter_op(istrue(level._id_13368) && !istrue(level._id_13363), "_encstr_88270DD8EEA39025D75B765D5B4B63", "_encstr_8C8F065F254DC395");
  var_0 setscriptablepartstate(var_0.type, var_4);
  var_5 = getgroundposition(var_0.origin, 1) + (0, 0, 2);
  var_6 = var_3 playerspawnextractchopper(var_5, var_0);

  if(isDefined(var_6)) {
    var_6.site = var_0;
    var_0.heli = var_6;
    var_0.team = var_3.team;
    thread init_trap_room_spawning_module(var_5);
    var_3 _id_126C7();

    if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_847A1AB88B4DF8F97ABAB0A510431DC18303392037E1D3A36323953D", var_3.team, 1);

    level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_8340195EBA771F6BF0F31B2EA30FCABD9889392A80DB178D674D01", var_3, var_3.team);
    var_6 thread so_endgame(var_0);
  } else {
    playerdenyextraction(undefined, &"_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");
    var_4 = scripts\engine\utility::ter_op(istrue(level._id_13368) && !istrue(level._id_13363), var_0.audio_jugg_spawn, var_0.audio_shf_kill_hangar_lights);
    var_0 setscriptablepartstate(var_0.type, var_4);
    return;
  }

  if(istrue(level._id_127BA)) {
    var_7 = scripts\common\utility::playersincylinder(var_0.origin, 15000);
    var_8 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_3.team, var_3.squadindex);

    foreach(var_10 in var_7) {
      if(!scripts\engine\utility::array_contains(var_8, var_10))
        var_10 thread scripts\mp\hud_message::showsplash("_encstr_92681E634B989742F35B66564DA74955C083C9FBF60BC89A4BFE79F7B08C200D", undefined, var_3);
    }
  }

  if(istrue(level._id_11DAD)) {
    var_0.disabled = 1;
    var_4 = scripts\engine\utility::ter_op(istrue(level._id_13368) && !istrue(level._id_13363), var_0.little_bird_onexitheavydamagestate, var_0.load_relics_from_playlistdvars);
    var_0 setscriptablepartstate(var_0.type, var_4);
    level thread _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::play_tape_machine_animations(var_0);
  }
}

_id_126C7() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12616("_encstr_8C4F1BB4DDC1BECEACB9EB0E36F2E4AF381BAB9B192B93D7DCDAB7D695", 1.867);
}

playerdenyextraction(var_0, var_1) {
  self iprintlnbold(var_1);
  self playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");

  if(isDefined(var_0)) {
    var_2 = self getweaponammoclip(var_0);
    self setweaponammoclip(var_0, var_2 + 1);
  }
}

init_trap_room_spawning_module(var_0) {
  wait 1.35;
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_1 setModel("_encstr_AAD412E6C69CEBB9B6DBD659D7CE9C9537583256");
  var_1.angles = (0, 90, 90);
  var_1 playSound("_encstr_B4731D67EDA520C50F5A4913028B8F28FC79C733B78FC3972B71E31B2A9BBE");
  var_1 playLoopSound("_encstr_85CC1BF750D02B12F7FE0EC2D5916AEBF8A82F57298B95FAF785997D47");
  var_1 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9");
  wait 17;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_8FA70A7917830EF0B09E4379");
  var_1 playSound("_encstr_88741E3B933094C7F831728A58C65BCF300FB4B13390D18B9B2B6BE283171387");
  wait 1;
  var_1 stoploopsound();
  wait 4.5;
  var_1 delete();
}

playerspawnextractchopper(var_0, var_1) {
  var_2 = var_0;
  var_3 = var_2 + (0, 0, 2000);
  var_4 = var_2 + (0, 0, 8000);
  var_5 = var_2 + (0, 0, 800);
  var_6 = 0;
  var_7 = (0, 0, 0);
  var_8 = getdvarint("_encstr_B6431C9F66A2E978F1B358421B1FE57D43B240B3579FD77F712AAD4F7BAA", 0);

  if(var_8) {
    var_9 = relic_squadlink_turn_team_headobjectives(var_2);

    if(isDefined(var_9)) {
      var_10 = var_9.script_noteworthy;
      var_7 = var_10.angles;
    } else {
      var_6 = relic_award_one_bullet(var_1, var_4, var_3);
      var_7 = (0, var_6, 0);
    }
  } else {
    var_6 = relic_award_one_bullet(var_1, var_4, var_3);
    var_7 = (0, var_6, 0);
  }

  if(getdvarint("_encstr_8DE71F533BD391114877E7786B762FA2EB096CF112FF296368D8854A390912A28F", 0) == 1) {
    var_11 = -100;
    var_12 = 60;
    var_13 = anglesToForward(var_7);
    var_14 = anglestoright(var_7);
    var_2 = var_2 + var_13 * var_11 + var_14 * var_12;
    var_3 = var_2 + (0, 0, 2000);
    var_5 = var_2 + (0, 0, 800);
  }

  var_15 = var_4 - anglesToForward(var_7) * 20000;
  var_16 = spawnheli(self, var_15, var_3, var_5, var_2);
  return var_16;
}

relic_squadlink_turn_team_headobjectives(var_0) {
  var_1 = undefined;

  foreach(var_3 in level._id_127C5) {
    if(isDefined(var_3) && distance2dsquared(var_3.origin, var_0) <= 10000) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

relic_award_one_bullet(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_0.player_respawn))
    return var_0.player_respawn;

  var_3 = 10;
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 1, 1, 0);
  var_5 = 0;

  for(var_6 = 0; var_6 < 360; var_6 = var_6 + var_3) {
    var_5 = var_5 + var_6;
    var_7 = (0, var_5, 0);
    var_8 = var_1 - anglesToForward(var_7) * 20000;
    var_9 = var_2;
    var_10 = scripts\engine\trace::sphere_trace(var_8, var_9, 100, undefined, var_4, 1);

    if(var_10["_encstr_A53009A25003666B9818C6"] == 1) {
      if(isDefined(var_0))
        var_0.player_respawn = var_5;

      return var_5;
    }

    if(var_6 % 3 == 0)
      waitframe();
  }

  return var_5;
}

drophelicrate(var_0) {
  if(!isDefined(var_0.plunder)) {
    return;
  }
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_8A951D88A48B102AEA2A68A9F31BDB2831DC49375E4432182B03D28FCB4D3D", self.team, 1);
  _id_12782(self.crate, 0);
  var_1 = self.crate;
  self.crate = undefined;
  var_1.plunder = var_0.plunder;
  var_2 = var_1.origin;
  var_3 = (var_2[0], var_2[1], -12000);
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_5 = scripts\engine\trace::ray_trace(var_2, var_3, var_0, var_4);
  var_6 = var_5["_encstr_BD260953AA97E3F014279D"];
  var_7 = var_2[2] - var_6[2];

  if(var_7 > 0) {
    var_8 = sqrt(2 * var_7 / 800);
    var_1 moveTo(var_6, var_8, var_8, 0);
    wait(var_8);
  }

  var_1.origin = var_6;
  playFX(scripts\engine\utility::getfx("_encstr_AA66152FE0E3D49367871116EE23AB9DEE5897F348391C"), var_6);
  var_1 num_rocket_per_attack(1);
  var_1 thread smokinggunprogress(var_0);
}

frag_crate_spawn(var_0, var_1, var_2) {
  var_3 = var_0 * 0.0000157828;
  var_4 = 0.5 * var_2;
  var_5 = var_1;
  var_6 = -1 * var_3;
  var_7 = (-1 * var_5 + sqrt(var_5 * var_5 - 4 * var_4 * var_6)) / (2 * var_4);
  var_7 = var_7 * 3600;
  var_7 = var_7 + 1.5;
  return var_7;
}

frag_crate_player_at_max_ammo(var_0) {
  var_1 = frag_crate_spawn(20000, 100, 125);
  var_2 = frag_crate_spawn(var_0, 25.0, 31.25);
  var_3 = var_1 + var_2;
  return var_3;
}

so_endgame(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_1 = self.originalangle[2];
  var_2 = self.lastweaponfiretimeend[2] - var_1;
  self.player_weapon_fired_monitor = frag_crate_player_at_max_ammo(var_2);
  thread heliwatchgameendleave();
  self._id_1287C = 1;
  helidescend();
  self._id_1287C = undefined;
  self setscriptablepartstate("_encstr_ACFF0D1B50BF6BCF23C80631FDC8AB", "_encstr_AB0703DBB9");

  if(!istrue(level.gameended)) {
    if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_83EA1FF3E995CA4C0853C1570A5882F26621C72749307310607BC95EA340D1FBCD", self.team, 1);

    thread sound_distraction_mechanic_init(var_0);
    return;
  }

  thread sol_3_4_pool(1);
}

sound_distraction_mechanic_init(var_0) {
  var_1 = undefined;

  if(var_0.type == "_encstr_A1EB22D00BAC5067F3799FA9CB6A49D91A2760F8FB6A29379B9C18A0A9539BA3758F523A")
    var_1 = "_encstr_8A5110B3A5B5B0F59A1B492B5B62C70B7C6A";
  else if(var_0.type == "_encstr_93EB22233820DF425110DAD56D3DAA9D4BE9B7D3E01B094A7913654D40EFB234F1815A72")
    var_1 = "_encstr_A65110D9546B401DBF0314B9CAA7CFE0C7E2";
  else if(var_0.type == "_encstr_9B62228A0D88354FCD16135BB9A6FBE168A114024388BBC776C8BB42C67FD323E871BD8A")
    var_1 = "_encstr_B4AB16DF8A20F26AC6994BF781FB4359081715A320F8AD93";
  else if(var_0.type == "_encstr_82051D5B3350BFC763E1A74DB1A2053F7DC13BAAB36A2C2F47F3A078F7A0EA")
    var_1 = "_encstr_B4F91169D8BC587FE20B7123436A3F1844BE77";
  else {}

  _id_12796(var_0, var_1);
  var_2 = undefined;

  if(isDefined(self.team))
    var_2 = scripts\mp\utility\teams::getfriendlyplayers(self.team);

  thread _id_127A4(var_0, var_2);
  _id_127AA(var_0, var_2);
}

smoke_door(var_0) {
  if(!istrue(level.gameended) && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_A52C1853F8633D14C5EE1ED282ABEB67BF28B1768017763DA737", self.team, 1);

  var_1 = var_0 num_players_in_safehouse();

  if(isDefined(var_1) && isDefined(var_1.brwatchforminplayersmatchstart) && var_1.brwatchforminplayersmatchstart > 0) {
    level.br_plunder.oscope_sign_think = level.br_plunder.oscope_sign_think + var_1.brwatchforminplayersmatchstart;
    level.br_plunder.oscope_sign++;
  }
}

_id_13694(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_1 setModel("_encstr_BA95205B96E61BEB392C1C563663B437CEFAC97BE0ACBE8198F533B4269527EB26E4");
  var_1 linkTo(var_0, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", (0, 0, 0), (0, 0, 0));
  var_1.animname = var_0.animname;
  var_1 scripts\common\anim::setanimtree();
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "_encstr_BD990893ED1CCAF55ACD", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_2 setModel("_encstr_866B2398E4BE071BAEE68C2B4EAFACE1A3C9588DD1B4EDE6BE23AC364B3B59C95ED798C2B3");
  var_2 linkTo(var_0, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", (0, 0, 0), (0, 0, 0));
  var_2.animname = var_0.animname;
  var_2 scripts\common\anim::setanimtree();
  var_0 scripts\common\anim::anim_first_frame_solo(var_2, "_encstr_97F90789B0ECFA4BDC", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_0.rope = var_1;
  var_0.crate = var_2;
}

spawnheli(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;
  var_6 = vectortoangles(var_2 * (1, 1, 0) - var_1 * (1, 1, 0));
  var_7 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_1, var_6, "_encstr_A215169359C387A680CB7370EBD12AF3F5902A2AC33007DA", "_encstr_B2681F23E5D0519E0729F97F8B2D1BC8E008509FEFB8B208F0D4A3F34965024858");

  if(!isDefined(var_7)) {
    return;
  }
  var_7.damagecallback = ::callback_vehicledamage;
  var_7.speed = 100;
  var_7.accel = 125;
  var_7.health = scripts\engine\utility::ter_op(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_BE180419DAE9" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8AE1099A0B999F2D28AF15" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_9B1F05BE4B9B52" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_866209ECEDB1197DEE0B4E", level.overheatlimit, 1000);
  var_7.maxhealth = var_7.health;
  var_7.team = var_0.team;
  var_7.owner = var_0;
  var_7.lifeid = 0;
  var_7.flaresreservecount = var_5;
  var_7.nuke_vault_riotshield_internal = var_1;
  var_7.lastweaponfiretimeend = var_2;
  var_7.spawn_sentries_from_targetname = var_3;
  var_7.originalangle = var_4;
  var_7._id_12EE8 = var_6;
  var_7.vehiclename = "_encstr_9BEF16359B67FDA671371305E0BDB293E166C898324FA18B";
  var_7.animname = "_encstr_8753150319055ADC98E371C79A28F262D6B1379BE32192";
  var_7 setCanDamage(1);
  var_7 setmaxpitchroll(10, 25);
  var_7 vehicle_setspeed(var_7.speed, var_7.accel);
  var_7 sethoverparams(1, 1, 1);
  var_7 setturningability(0.05);
  var_7 setyawspeed(45, 25, 25, 0.5);
  var_7 setotherent(var_0);
  var_7 setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9");
  var_7 setscriptablepartstate("_encstr_BE900B2B41DBC3A11853EFF871", "_encstr_8419044EB232");
  var_7 setscriptablepartstate("_encstr_A5590E6C7BB1AD83D21DAFB1A5EC868E", "_encstr_AB0703DBB9");
  var_7 setscriptablepartstate("_encstr_86D00D5048E3DA5929B8B1F772D18F", "_encstr_AB0703DBB9");
  var_7.scenenode = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7.originalangle);
  var_7.scenenode.angles = var_7._id_12EE8;
  var_7.scenenode setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_7.scenenode scripts\common\anim::anim_first_frame_solo(var_7, "_encstr_AAE208481F244BE0C2E3");
  _id_13694(var_7);
  return var_7;
}

smokinggunprogress(var_0) {
  _id_12786(self);
  self hide();

  if(isDefined(var_0))
    var_0.crate = undefined;

  waitframe();
  self delete();
}

smuggler_post_tele_kill() {
  self endon("_encstr_A9B60A3495C6A5F5D9DEB92B");
  var_0 = self.owner;
  self waittill("_encstr_AD75063D571AE108", var_1, var_2, var_3, var_4);
  var_5 = 0;

  if(isDefined(self.plunder)) {
    foreach(var_7 in self.plunder)
    var_5 = var_5 + var_7.plundercount;
  }

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detonatefunc(var_5, "_encstr_9A8F0CB1A5E8471BB2EB894B39C8", self.originalangle, self.origin);
  thread drophelicrate(self);
  smoke_enemy_think();

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.largeprojectiledamage) && !istrue(self.isdepot)) {
    self vehicle_setspeed(25, 5);
    thread smokesignal(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  snowballfighthint(var_1);
}

smoke_enemy_think() {
  if(isDefined(self.rope))
    self.rope delete();

  if(isDefined(self.crate))
    self.crate thread smokinggunprogress(self);

  if(isDefined(self.scenenode))
    self.scenenode delete();
}

snowballfighthint(var_0) {
  var_1 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37") + (0, 0, 40);
  self radiusdamage(var_1, 256, 140, 70, var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
  playFX(scripts\engine\utility::getfx("_encstr_86A914B1963AA38DB2BE89D2938CAFAC3CC11BED32AC"), var_1, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_1, "_encstr_B1CA1AD495531E3FE4F288904ABA8F539F285FC0FA4B46074AFA9858");
  earthquake(0.4, 800, var_1, 0.7);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_1);
  physicsexplosionsphere(var_1, 500, 200, 1);
  self notify("_encstr_860808CB78E2984063BA");
  wait 0.35;
  level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_88D61A4C27AF56F01D4EB06C8EAFD059B15AFAB943B73AFA46B7DD37", self.owner, self.team);
  smuggler_killed_early();
}

smuggler_killed_early() {
  smoke_enemy_think();
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

smokesignal(var_0) {
  self endon("_encstr_860808CB78E2984063BA");
  self notify("_encstr_A3AC0E689D58D2870256B720A28B8AA7");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
}

callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner))
      var_1 = var_1.owner;
  }

  if(istrue(level.overheatreductionamount)) {
    return;
  }
  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["_encstr_8AEF05472BC2D6"] == self.team && !level.friendlyfire && level.teambased) && var_1 != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  var_2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self, var_4, var_2);
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_B40101");

  if(self.health - var_2 <= 900 && (!isDefined(self.smoking) || !self.smoking))
    self.smoking = 1;

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

sol_3_4_pool(var_0) {
  if(istrue(self._id_13E15) || istrue(self.leaving)) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_8F120D71530B30A3C77938119EA6F0");
  self._id_13E15 = 1;

  if(!istrue(level.gameended) && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_821C1E17357BF5A945D3E920E38CA323E2DB18168C7291532DFBE1607FB17B53", self.team, 1);

  var_1 = self.site;

  if(isDefined(var_1)) {
    _id_1279A(var_1);
    smoke_door(var_1);

    if(isDefined(var_1.heli) && var_1.heli == self) {
      var_1.heli = undefined;
      var_1.team = undefined;
      var_1 notify("_encstr_9B7A0AF45D2962A7702893C3");
    }

    var_1 thread skip_charge_plant(self.site.type);
    self.site = undefined;
  }

  self._id_12A47 = 1;
  self waittill("_encstr_AA350FBB4D1E4108194B7759901D99EB09");
  self notify("_encstr_BA2D081B2B58B32D37EC");
  self.leaving = 1;
  self._id_13E15 = undefined;
  var_2 = getanimlength(level.scr_anim[self.animname]["_encstr_873A093C894049E9A0FBDB"]);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "_encstr_873A093C894049E9A0FBDB");
  thread scripts\common\anim::anim_single_solo(self.rope, "_encstr_A38109E4ED0E2BD7DBBA1D", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  thread scripts\common\anim::anim_single_solo(self.crate, "_encstr_AB33087537C218C0B5DB", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  self stoploopsound();
  self notify("_encstr_A9B60A3495C6A5F5D9DEB92B");
  smuggler_killed_early();
}

skip_charge_plant(var_0) {
  var_1 = scripts\engine\utility::ter_op(istrue(level._id_13368) && !istrue(level._id_13363), "_encstr_88270DD8EEA39025D75B765D5B4B63", "_encstr_8C8F065F254DC395");
  self setscriptablepartstate(var_0, var_1);
  wait 6;

  if(isDefined(self)) {
    var_1 = scripts\engine\utility::ter_op(istrue(level._id_13368) && !istrue(level._id_13363), self.audio_jugg_spawn, self.audio_shf_kill_hangar_lights);
    self setscriptablepartstate(var_0, var_1);
  }
}

helidescend() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = getanimlength(level.scr_anim[self.animname]["_encstr_AAE208481F244BE0C2E3"]);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "_encstr_AAE208481F244BE0C2E3");
  thread scripts\common\anim::anim_single_solo(self.rope, "_encstr_BD990893ED1CCAF55ACD", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  thread scripts\common\anim::anim_single_solo(self.crate, "_encstr_97F90789B0ECFA4BDC", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  thread soldier_agent_lwfn9();
  thread sololink();
  thread soldier_encounter_test();
}

soldier_agent_lwfn9() {
  self endon("_encstr_AD75063D571AE108");
  self.scenenode endon("_encstr_AD75063D571AE108");
  var_0 = getanimlength(level.scr_anim[self.animname]["_encstr_8A7A0A5BA3208BF9C830903B"]);

  for(;;) {
    self.scenenode thread scripts\common\anim::anim_single_solo(self, "_encstr_8A7A0A5BA3208BF9C830903B");
    wait(var_0);

    if(istrue(self._id_12A47) && !istrue(self._id_1287C)) {
      self notify("_encstr_AA350FBB4D1E4108194B7759901D99EB09");
      break;
    }
  }
}

sololink() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = getanimlength(level.scr_anim[self.animname]["_encstr_A19E0A123871C2C710D81773"]);

  for(;;) {
    thread scripts\common\anim::anim_single_solo(self.rope, "_encstr_A19E0A123871C2C710D81773", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
    wait(var_0);

    if(istrue(self._id_12A47)) {
      break;
    }
  }
}

soldier_encounter_test() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = getanimlength(level.scr_anim[self.animname]["_encstr_A5C209C167CF81186227AB"]);

  for(;;) {
    thread scripts\common\anim::anim_single_solo(self.crate, "_encstr_A5C209C167CF81186227AB", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
    wait(var_0);

    if(istrue(self._id_12A47)) {
      break;
    }
  }
}

nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56");
}

snapplayertotoppos() {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8D7D06302FE5E159", var_0);

    if(isDefined(var_0) && var_0 nuke_vault_suicidebomber_internal())
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "_encstr_8D4E0A501FCB898912CB3FA3");
  }
}

snappointtooutofboundstriggertrace() {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 70;
  var_1 = -80;
  var_2 = 150;
  var_3 = 25;
  var_4 = -100;

  for(;;) {
    var_5 = getentarrayinradius("_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56", "_encstr_AC110A7F14873B5B3D073009", self.origin, getdvarfloat("_encstr_88DE0C99B5F3EBF77031AD38034E", 400));

    if(var_5.size <= 1) {
      wait 0.5;
      continue;
    }

    var_6 = scripts\engine\trace::create_vehicle_contents();
    var_7 = anglesToForward(self.angles);
    var_8 = self.origin + var_7 * getdvarfloat("_encstr_8CDC077B631EE3FFA8", var_2) + (0, 0, getdvarfloat("_encstr_BADC07F043CB4C1733", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_10) && var_10 nuke_vault_suicidebomber_internal()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "_encstr_8D4E0A501FCB898912CB3FA3");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("_encstr_86DC073AACE647FAD6", var_3) + (0, 0, getdvarfloat("_encstr_BADC07F043CB4C1733", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_10) && var_10 nuke_vault_suicidebomber_internal()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "_encstr_8D4E0A501FCB898912CB3FA3");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("_encstr_A2DC078ECACD3A7D89", var_4) + (0, 0, getdvarfloat("_encstr_BADC07F043CB4C1733", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_10) && var_10 nuke_vault_suicidebomber_internal()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "_encstr_8D4E0A501FCB898912CB3FA3");
      waitframe();
      continue;
    }

    waitframe();
  }
}

tracegroundheight(var_0) {
  var_1 = 800;
  var_2 = tracegroundpoint(var_0);
  var_3 = var_2 + var_1;
  return var_3;
}

tracegroundpoint(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_1 = -99999;
  var_2 = (var_0[0], var_0[1], var_1);
  var_3 = [self];
  var_4 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 1, 1, 0);
  var_5 = scripts\engine\trace::sphere_trace(var_0, var_2, 100, var_3, var_4, 1);
  var_6 = var_5["_encstr_BD260953AA97E3F014279D"][2];
  return var_6;
}

heliwatchgameendleave() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8F120D71530B30A3C77938119EA6F0");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread sol_3_4_pool(0);
}

smokekill(var_0, var_1) {
  _id_1279D(var_0);
}

snowfx(var_0) {
  if(isDefined(var_0.heli))
    var_0.heli thread sol_3_4_pool(1);
}

smodelcollections(var_0) {}

plunderlivelobby() {
  thread autopickupplunder();
}

inplunderlivelobby() {
  return istrue(level.br_plunder_enabled) && istrue(level.br_plunder_lobby) && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
}

autopickupplunder() {
  var_0 = 0.1;
  var_1 = 25;
  var_2 = var_1 * var_1;

  while(inplunderlivelobby()) {
    for(var_3 = 0; var_3 < level.br_plunder_ents.size; var_3++) {
      var_4 = level.br_plunder_ents[var_3];

      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = var_4.origin;

      for(var_6 = 0; var_6 < level.players.size; var_6++) {
        var_7 = level.players[var_6];

        if(!isalive(var_7)) {
          continue;
        }
        var_8 = distancesquared(var_7.origin, var_5);

        if(var_8 < var_2) {
          var_7 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::brpickupsusecallback(var_4, var_7);
          break;
        }
      }
    }

    wait(var_0);
  }
}

playerdelayautobankplunder() {
  self notify("_encstr_BE951B6BE0DF972FE809EDFC5B68FE6FFD38C0E2C8A26B25F8B5E4FD55");
  self endon("_encstr_BE951B6BE0DF972FE809EDFC5B68FE6FFD38C0E2C8A26B25F8B5E4FD55");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 2;
  _id_12618(self.plundercount);
}

playerplunderlivelobbydropondeath(var_0) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  if(inplunderlivelobby()) {
    var_1 = var_0 == "_encstr_8DED0A21C79B660BC7588981";
    var_2 = 1;

    if(var_1 && isDefined(self.plundercount) && self.plundercount > 1) {
      var_2 = self.plundercount;
      playersetplundercount(0);
    }

    if(var_2 <= 0) {
      return;
    }
    if(level.br_plunder_ents.size > 0)
      level.br_plunder_ents = scripts\engine\utility::array_removeundefined(level.br_plunder_ents);

    var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
    return ml_p3_func(var_2, var_3);
  }
}

touchdown_origin() {
  foreach(var_1 in level.teamnamelist) {
    level.teamdata[var_1]["_encstr_813D11B9340B207DDF63B7993A973D70E39139"] = 0;
    level.teamdata[var_1]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"] = 0;
    level.teamdata[var_1]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"] = 0;
  }

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52") {
    foreach(var_1 in level.teamnamelist) {
      level.teamdata[var_1]["_encstr_9B8B102DCDA2DBC07B53D0F85FB43821AAB5"] = 0;
      level.teamdata[var_1]["_encstr_96A210A308527F75686B6E4CDB98FDFF8BC3"] = 0;
      level.teamdata[var_1]["_encstr_A11E0D297F7275B8A346F128349D20"] = 0;
    }
  }
}

retry_no_votes(var_0) {
  var_1 = level.br_plunder.names[0];

  for(var_2 = level.br_plunder._id_12954.size - 1; var_2 > 0; var_2--) {
    if(var_0 >= level.br_plunder._id_12954[var_2]) {
      var_1 = level.br_plunder.names[var_2];
      break;
    }
  }

  return var_1;
}

_id_1275D(var_0, var_1) {
  if(var_1 == 0) {
    return;
  }
  var_2 = retry_no_votes(var_1);
  var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getcashsoundaliasforplayer(var_0, var_2);
  var_0 playsoundtoplayer(var_3, self);
}

_id_128A7() {
  var_0 = getdvarint("_encstr_88681F60F6F2F8380CAF10CCB21291A049E5A025257E72212B7B29B3AEC77476FA", 1);

  if(var_0 <= 1) {
    return;
  }
  foreach(var_9, var_2 in level.br_pickups.counts) {
    if(!issubstr(var_9, "_encstr_930A14BD0A6D08D8BB9153D81BFB052B824FC73393D4")) {
      continue;
    }
    var_3 = level.br_pickups.counts[var_9];
    var_4 = var_3 * var_0;
    level.br_pickups.counts[var_9] = var_4;
    var_5 = getentitylessscriptablearrayinradius(var_9);

    if(var_5.size >= 1) {
      foreach(var_7 in var_5)
      var_7.count = var_4;
    }
  }

  for(var_10 = 0; var_10 < level.br_plunder.names.size; var_10++)
    level.br_plunder._id_12954[var_10] = level.br_pickups.counts[level.br_plunder.names[var_10]];
}

_id_128A6(var_0) {
  foreach(var_7, var_2 in level.br_plunder.names) {
    level.br_plunder._id_12954[var_7] = int(float(level.br_plunder._id_12954[var_7]) * var_0);
    level.br_pickups.counts[var_2] = level.br_plunder._id_12954[var_7];
    var_3 = getentitylessscriptablearrayinradius(var_2);

    foreach(var_5 in var_3)
    var_5.count = level.br_plunder._id_12954[var_7];

    waitframe();
  }
}

ismountconfigenabled() {
  var_0 = 0;

  foreach(var_4, var_2 in level.br_plunder.names) {
    var_3 = getentitylessscriptablearrayinradius(var_2);
    var_0 = var_0 + var_3.size * level.br_pickups.counts[var_2];
  }

  var_0 = var_0 * 100;
  level._id_13BEC = var_0;
}

_id_1278E() {
  level._id_127C7 = spawnStruct();
  level._id_127C7.data = [];
  level._id_127C7.instances = [];
  level._id_127C7.uniqueinstanceid = 0;
  level._id_127C7._id_13AA6 = [];
  level._id_127C7._id_13AA3 = [];
  level._id_127C7._id_13AA4 = [];

  for(var_0 = 1; var_0 <= 4; var_0++) {
    level._id_127C7._id_13AA3[var_0] = "_encstr_8782182DCC6155C3D74318D8D304F9ADC9B2AD3725191308C4E7" + var_0;
    level._id_127C7._id_13AA4[var_0] = "_encstr_B475196BE9A9684E0F6BE8F3B2DB8DA0F16AC31987018898037286" + var_0;
  }

  scripts\common\interactive::interactive_addusedcallback(::_id_127A1, "_encstr_AFEF1280D94353FF2B48F19A406772071B300A11");
  scripts\engine\scriptable::scriptable_addusedcallback(::_id_127A3);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_12795);
  level._id_127D4 = getdvarint("_encstr_BACD23FF7B8AE93EC3F1F378BB5BE5E022E5475BC434C0F7BBDAA961A11B2DF03725C9E191", 0) > 0;
}

_id_1278C(var_0, var_1, var_2) {
  var_3 = level._id_127C7;
  var_4 = var_3.data[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_3.data[var_0] = var_4;
      var_4.usetime = 0.75;
      var_4._id_14077 = 2;
      var_4._id_14075 = 250;
      var_4._id_13ACC = 1;
      var_4._id_13AA5 = 0;
      var_4._id_1407A = "_encstr_938115619876A5534538994901EF831F1F639B653F43EF";
      var_4._id_1407C = "_encstr_A9211AE9C3AF15FB90FDC0758108CB3F67574159978E6D21085649F5";
      var_4._id_14078 = "_encstr_963A23A1B92072312D0DF328FF93B5AD99999F813C75F1F9A0F8CF391FE6E34F0148495949";
      var_4._id_1407B = "_encstr_85C01AFC51EEEE41D50EA799770F392FC7D9F44749933079BE19E7B9";
      var_4._id_14079 = "_encstr_A2DD26A9A0BC283105345112A789118A92BEA1A09393D38AFA1151053D6A4AA2AF262A282B4A9CA3";
      var_4._id_12F7D = undefined;
      var_4._id_12F7E = undefined;
      var_4._id_12F77 = undefined;
      var_4.origin_delta = 60;
      var_4.overrideviewkickscaledmr = 0;
      var_4.original_disablelongdeath = "_encstr_8C7E1CC77110A83883A65F04B8B1700507A15B6F8157F9205740548D98CD";
      var_4.get_closest_enemy_near_turret = 2000;
      var_4._id_14098 = undefined;
      var_4._id_14068 = ::_id_1279F;
      var_4.impactwatcher = undefined;
      var_4.org_in_bad_place = undefined;
      var_4.outline_enemy_ai_for_duration = undefined;
    } else {}
  }

  return var_4;
}

_id_12796(var_0, var_1) {
  var_2 = level._id_127C7;
  var_3 = _id_1278C(var_1);
  var_0._id_127C8 = var_1;
  var_0.startorigin = var_0.origin;
  var_0.plunder = [];
  var_0._id_127D0 = 0;
  var_0._id_127BD = level._id_127C7.uniqueinstanceid;
  level._id_127C7.uniqueinstanceid++;
  var_0._id_126BE = [];
  var_2.instances[var_0._id_127BD] = var_0;
  _id_12780(var_0);

  if(!isDefined(var_3._id_12F7D))
    var_0 scripts\common\interactive::interactive_addusedcallbacktoentity("_encstr_AFEF1280D94353FF2B48F19A406772071B300A11");

  _id_12782(var_0, 1);
}

_id_12786(var_0) {
  var_1 = level._id_127C7;
  var_0 notify("_encstr_AC8C1EE1607578FABAA0275842023CF828B36FC7CA108EBB784103A59B18A9C1");
  _id_12782(var_0, 0, 1);
  var_0._id_127C8 = undefined;
  var_0._id_127D3 = undefined;
  var_0._id_127AE = undefined;
  var_0.startorigin = undefined;
  var_0.plunder = undefined;
  var_0._id_127D0 = undefined;
  _id_1279A(var_0);
  var_0._id_126BE = undefined;

  if(isDefined(var_0._id_127BD))
    var_1.instances[var_0._id_127BD] = undefined;

  _id_12797(var_0);
  var_0 scripts\common\interactive::interactive_removeusedcallbackfromentity();
}

_id_1279E(var_0) {
  var_1 = level._id_127C7;

  if(!isDefined(var_1))
    return 0;

  var_2 = undefined;

  if(isDefined(var_0._id_127BD))
    var_2 = var_1.instances[var_0._id_127BD];

  return isDefined(var_2) && var_2 == var_0;
}

_id_12782(var_0, var_1, var_2) {
  var_0 notify("_encstr_AD761B37155BD589653309E053B4202F91FFAF30AAF2B9D05AF751785F");
  var_3 = undefined;

  if(isDefined(var_0._id_127C8))
    var_3 = _id_1278C(var_0._id_127C8, undefined, var_2);

  if(isDefined(var_3)) {
    if(isDefined(var_3._id_12F7D)) {
      if(var_1)
        var_0 setscriptablepartstate(var_3._id_12F7D, var_3._id_12F7E, 0);
      else
        var_0 setscriptablepartstate(var_3._id_12F7D, var_3._id_12F77, 0);
    } else if(var_1)
      var_0 makeusable();
    else
      var_0 makeunusable();

    var_4 = istrue(var_0._id_127D3);
    var_0._id_127D3 = scripts\engine\utility::ter_op(var_1, var_1, undefined);

    if(!var_4) {
      if(var_1) {
        foreach(var_6 in level.players)
        _id_12783(var_0, var_6, _id_12793(var_0, var_6));
      }
    } else if(!var_1)
      var_0 notify("_encstr_97DB18C2ED81921B40D0C74B407ED59B7368CFBC4ECB3A5CE978");
  }
}

_id_12783(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_0._id_127C8))
    var_4 = _id_1278C(var_0._id_127C8, undefined, var_3);

  if(isDefined(var_4)) {
    if(isDefined(var_4._id_12F7D)) {
      if(var_2)
        var_0 enablescriptablepartplayeruse(var_4._id_12F7D, var_1);
      else
        var_0 disablescriptablepartplayeruse(var_4._id_12F7D, var_1);
    } else if(var_2)
      var_0 enableplayeruse(var_1);
    else
      var_0 disableplayeruse(var_1);
  }

  if(!var_2)
    var_0 notify("_encstr_9AFA1D534ADBA088547CDF1D89317076574129B8B3F76E286F44B73DB72259" + var_1 getentitynumber());
}

_id_12781(var_0, var_1, var_2) {
  var_3 = level._id_127C7;

  foreach(var_5 in var_3.instances) {
    if(isDefined(var_5))
      _id_12783(var_5, var_0, var_1, 1);
  }
}

_id_12793(var_0, var_1) {
  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  if(scripts\mp\utility\player::unset_relic_trex(var_1))
    return 0;

  var_2 = _id_1278C(var_0._id_127C8);
  var_3 = istrue(var_2._id_13ACC) || istrue(var_0.playerplunderbankdepositcallback);

  if(var_3 && isDefined(var_0.team) && var_1.team != var_0.team)
    return 0;

  return 1;
}

_id_12794(var_0, var_1, var_2) {
  var_3 = _id_1278C(var_0._id_127C8);

  if(!istrue(var_0._id_127D3))
    return 0;

  if(var_3._id_14077 == 7) {
    if(var_0.team != var_1.team) {
      if(!isDefined(var_3.brking_ispointinmovingcircle) || !istrue(var_3.brking_ispointinmovingcircle)) {
        var_1 playlocalsound("_encstr_B80516BE1E972B5C9B48D3DFC0B609335B2046F68817B294");

        if(isDefined(var_3._encstr_8FD60DAA488AB988410FD9E0602337) && var_3._encstr_8FD60DAA488AB988410FD9E0602337 != "_encstr_B40101")
          var_1 scripts\mp\hud_message::showerrormessage(var_3._encstr_8FD60DAA488AB988410FD9E0602337);

        return 0;
      }

      if(var_0._id_127D0 <= 0) {
        var_1 playlocalsound("_encstr_B80516BE1E972B5C9B48D3DFC0B609335B2046F68817B294");
        var_1 scripts\mp\hud_message::showerrormessage(var_3._encstr_8FD60DAA488AB988410FD9E0602337);
        return 0;
      }
    } else if(var_0.team == var_1.team && (!isDefined(var_1.plundercount) || var_1.plundercount <= 0)) {
      if(istrue(var_2) && isDefined(var_3._id_1407B) && var_3._id_1407B != "_encstr_B40101") {
        var_1 playlocalsound("_encstr_B80516BE1E972B5C9B48D3DFC0B609335B2046F68817B294");
        var_1 scripts\mp\hud_message::showerrormessage(var_3._id_1407B);
      }

      return 0;
    }
  }

  if(var_3._id_14077 == 2 || var_3._id_14077 == 3) {
    if(!isDefined(var_1.plundercount) || var_1.plundercount <= 0 && (!isDefined(var_1.overheatreductiontime) || isDefined(var_1.override_minimap_hide) && isDefined(var_0.index) && var_1.override_minimap_hide != var_0.index)) {
      if(istrue(var_2) && isDefined(var_3._id_1407B) && var_3._id_1407B != "_encstr_B40101") {
        var_1 playlocalsound("_encstr_B80516BE1E972B5C9B48D3DFC0B609335B2046F68817B294");
        var_1 scripts\mp\hud_message::showerrormessage(var_3._id_1407B);
      }

      return 0;
    } else if(istrue(var_0._id_127AE)) {
      if(istrue(var_2) && isDefined(var_3._id_14078) && var_3._id_14078 != "_encstr_B40101") {
        var_1 playlocalsound("_encstr_B80516BE1E972B5C9B48D3DFC0B609335B2046F68817B294");
        var_1 scripts\mp\hud_message::showerrormessage(var_3._id_14078);
      }

      return 0;
    }
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    if(istrue(var_2) && isDefined(var_3._id_1407C) && var_3._id_1407C != "_encstr_B40101") {
      var_1 playlocalsound("_encstr_B80516BE1E972B5C9B48D3DFC0B609335B2046F68817B294");
      var_1 scripts\mp\hud_message::showerrormessage(var_3._id_1407C);
    }

    return 0;
  }

  if(scripts\mp\utility\player::unset_relic_trex(var_1)) {
    if(istrue(var_2) && isDefined(var_3._id_1407A) && var_3._id_1407A != "_encstr_B40101") {
      var_1 playlocalsound("_encstr_B80516BE1E972B5C9B48D3DFC0B609335B2046F68817B294");
      var_1 scripts\mp\hud_message::showerrormessage(var_3._id_1407A);
    }

    return 0;
  }

  if(var_1 isparachuting() || var_1 isskydiving())
    return 0;

  if(var_1 isinexecutionattack() || var_1 isinexecutionvictim())
    return 0;

  if(isDefined(var_3._id_14098))
    return [[var_3._id_14098]](var_0, var_1, var_2);

  return 1;
}

_id_127A3(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  var_5 = var_0.entity;

  if(!isDefined(var_5) || isDefined(var_5.playermaxheath))
    var_5 = var_0;

  if(!_id_1279E(var_5)) {
    return;
  }
  var_6 = _id_1278C(var_5._id_127C8);

  if(!isDefined(var_6._id_12F7D)) {
    return;
  }
  if(var_1 != var_6._id_12F7D) {
    return;
  }
  if(var_2 != var_6._id_12F7E) {
    return;
  }
  if(!_id_12794(var_5, var_3, 1)) {
    return;
  }
  thread _id_127A2(var_5, var_3);
}

_id_127A1(var_0, var_1) {
  if(!_id_1279E(var_0)) {
    return;
  }
  if(!_id_12794(var_0, var_1, 1)) {
    return;
  }
  thread _id_127A2(var_0, var_1);
}

_id_127A2(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_3 = gettime();
  _id_1279B(var_1, 1);
  _id_12783(var_0, var_1, 0);
  _id_127A5(var_0, var_1);

  if(isDefined(var_1)) {
    if(isDefined(var_0))
      _id_12783(var_0, var_1, 1);

    if(var_1 scripts\cp_mp\utility\player_utility::_isalive())
      _id_1279B(var_1, 0);

    var_1._id_127C9 = undefined;

    if(isPlayer(var_1)) {
      var_4 = 0;
      var_5 = undefined;

      if(!var_4 && var_1 scripts\cp_mp\utility\player_utility::_isalive() && !var_1 scripts\cp_mp\utility\player_utility::isinvehicle() && !scripts\mp\utility\player::unset_relic_trex(var_1)) {
        if(istrue(var_0.oscope_ampl))
          var_5 = 2;
        else if(isDefined(var_1._id_127CA) && isDefined(var_1._id_127CA._id_14076) && var_1._id_127CA._id_14076 - gettime() <= 1.5)
          var_5 = 1.5;
      }

      thread _id_12785(var_1, var_5);
    }
  }

  if(isDefined(var_0) && isDefined(var_0._id_126BE))
    var_0._id_126BE[var_2] = undefined;

  if(isDefined(var_1) && isPlayer(var_1))
    _id_127AA(var_0, var_1);
}

_id_127A5(var_0, var_1) {
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_97DB18C2ED81921B40D0C74B407ED59B7368CFBC4ECB3A5CE978");
  var_0 endon("_encstr_9AFA1D534ADBA088547CDF1D89317076574129B8B3F76E286F44B73DB72259" + var_1 getentitynumber());
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = _id_1278C(var_0._id_127C8);
  var_0._id_126BE[var_1 getentitynumber()] = var_1;
  _id_127AB(var_1, var_0._id_127BD, var_2.type, 1, var_0._id_127AF, var_0._id_127D0);
  _id_127A6(var_1);
  _id_127AA(var_0, var_1);
  var_3 = 0;
  var_4 = 0;
  var_5 = var_2.usetime;
  var_6 = 0;

  for(var_7 = 0; var_1 useButtonPressed(); var_4 = var_4 + 0.05) {
    var_8 = undefined;

    if(var_3) {
      var_3 = 0;
      var_8 = 0;
    } else
      var_8 = 1;

    if(!_id_12794(var_0, var_1, var_8)) {
      return;
    }
    if(var_4 >= var_5) {
      if(var_2._id_14077 == 7 && var_0.team != var_1.team) {
        var_7 = int(var_2._encstr_A73E0C5F793D9AE488D0AD33A8F8);
        var_5 = var_4 + var_2._encstr_BEC50A783C37EEECF3424A55;
      } else {
        var_7 = int(min(var_1.plundercount, var_2._id_14075));
        var_5 = var_4 + var_2.usetime;
      }

      if(isDefined(var_2._id_14068))
        thread[[var_2._id_14068]](var_0, var_1, var_7);
      else {}

      var_6 = var_4;

      if(isDefined(var_1._id_127CA))
        var_1._id_127CA._id_14076 = gettime();

      var_3 = 1;
    }

    wait 0.05;
  }
}

_id_1279F(var_0, var_1, var_2) {
  var_3 = _id_1278C(var_0._id_127C8);
  var_4 = var_1 _id_1261F(var_2, var_3._id_14077, var_0);

  if(isDefined(var_4) && isDefined(var_4.amount))
    var_2 = var_4.amount;

  if(var_2 > 0) {
    _id_127AB(var_1, undefined, undefined, undefined, undefined, var_0._id_127D0, var_2);
    _id_127A6(var_1);
  }
}

_id_1279B(var_0, var_1) {
  var_2 = ["_encstr_B18F09518733412BAF1AA0", "_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_BEF4071AA87BDF5220", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_88780599B4E495", "_encstr_A6C7065BACB1CA95", "_encstr_AF4D07932B1BDE5846", "_encstr_AD1904291F7B", "_encstr_919007AA5148539DA0", "_encstr_83230A7F177D22B4413B75BA", "_encstr_86A00B412DA32D63B72F90F05F", "_encstr_880811DD703AAFCB14FF28383F59A3C902DE42", "_encstr_962F0CB3560DD236D8CAD7576E59", "_encstr_A91E0E983FF591A981B7D5E64B1BA599"];

  if(istrue(var_0._id_127C9) && var_1) {
    return;
  }
  if(!istrue(var_0._id_127C9) && !var_1) {
    return;
  }
  var_0 scripts\common\utility::allow_array(var_2, !var_1);

  if(var_1)
    var_0._id_127C9 = 1;
  else
    var_0._id_127C9 = undefined;
}

_id_127A4(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AC8C1EE1607578FABAA0275842023CF828B36FC7CA108EBB784103A59B18A9C1");
  var_0 notify("_encstr_92D32179F4CBE0BD1FA3963B3AA3E0D06444FFF5793BD0FD3F1AED80038325203DBF75");
  var_0 endon("_encstr_92D32179F4CBE0BD1FA3963B3AA3E0D06444FFF5793BD0FD3F1AED80038325203DBF75");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = _id_1278C(var_0._id_127C8);

  if(!isDefined(var_0._id_127B1)) {
    var_0._id_127B1 = [];
    var_0._id_127B2 = 0;
    var_3 = scripts\engine\utility::ter_op(isDefined(var_2.overrideviewkickscaledmr), var_2.overrideviewkickscaledmr, 0);
    var_4 = scripts\engine\utility::ter_op(isDefined(var_2.origin_delta), var_2.origin_delta, 0);
    var_0._id_127CB = gettime() + var_3 * 1000;
    var_0._id_127AF = gettime() + (var_3 + var_4) * 1000;
  }

  if(isDefined(var_1)) {
    if(!isarray(var_1))
      var_1 = [var_1];

    foreach(var_6 in var_1) {
      if(isDefined(var_6) && isPlayer(var_6))
        var_0._id_127B1[var_6 getentitynumber()] = var_6;
    }
  }

  while(gettime() <= var_0._id_127AF) {
    if(gettime() - var_0._id_127B2 >= 1000) {
      if(gettime() > var_0._id_127CB) {
        var_8 = int(max(0, (var_0._id_127AF - gettime()) / 1000));

        foreach(var_6 in var_0._id_127B1) {
          if(isDefined(var_6))
            thread _id_127A0(var_6, var_0, var_8);
        }
      }

      var_0._id_127B2 = gettime();
    }

    wait 0.05;
  }

  thread _id_1279C(var_0, 1);
}

_id_1279C(var_0, var_1) {
  _id_1279A(var_0);
  var_2 = _id_1278C(var_0._id_127C8);

  if(isDefined(var_2.impactwatcher))
    [[var_2.impactwatcher]](var_0, var_1);
}

_id_1279A(var_0) {
  var_0 notify("_encstr_92D32179F4CBE0BD1FA3963B3AA3E0D06444FFF5793BD0FD3F1AED80038325203DBF75");
  var_0._id_127B1 = undefined;
  var_0._id_127AF = undefined;
  var_0._id_127B2 = undefined;
}

_id_127A0(var_0, var_1, var_2) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_92D927AB585B6894D36EE825336B9DD7DB5890FD085BBD0255A7D76375E4A3E0EF30F08D785EF13A2F");
  var_0 endon("_encstr_92D927AB585B6894D36EE825336B9DD7DB5890FD085BBD0255A7D76375E4A3E0EF30F08D785EF13A2F");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0._id_127B0))
    var_0._id_127B0 = [];

  var_3 = _id_1278C(var_1._id_127C8);

  if(isDefined(var_3.original_disablelongdeath)) {
    var_4 = spawnStruct();
    var_4.origin = var_1.origin;
    var_4.msg = var_3.original_disablelongdeath;
    var_4.value = var_2;
    var_0._id_127B0[var_0._id_127B0.size] = var_4;
  }

  waittillframeend;

  if(!var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag() && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_5 = undefined;
    var_6 = 2147483647;

    foreach(var_4 in var_0._id_127B0) {
      var_8 = distance2dsquared(var_0.origin, var_4.origin);

      if(var_8 < var_6) {
        var_6 = var_8;
        var_5 = var_4;
      }
    }
  }

  var_0._id_127B0 = undefined;
}

_id_1279D(var_0) {
  var_0.oscope_ampl = 1;
  _id_1279A(var_0);
  _id_12782(var_0, 0);
  _id_12797(var_0);
  var_1 = _id_1278C(var_0._id_127C8);

  if(isDefined(var_1.org_in_bad_place))
    [[var_1.org_in_bad_place]](var_0);
}

_id_12799(var_0) {
  var_0._id_127AE = 1;
  _id_12782(var_0, 0);
  var_1 = _id_1278C(var_0._id_127C8);

  if(isDefined(var_1.carriable_error_messsage_watch))
    [[var_1.carriable_error_messsage_watch]](var_0);
}

_id_12795() {
  _id_12781(self, 1, 1);
}

_id_127AB(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3) && !var_3) {
    _id_12785(var_0);
    return;
  }

  var_7 = var_0._id_127CA;

  if(!isDefined(var_7)) {
    var_7 = spawnStruct();
    var_0._id_127CA = var_7;
    var_7._id_127BD = var_1;
    var_7.type = var_2;
    var_7.visible = 0;
    var_7.endtime = undefined;
    var_7._id_127D0 = undefined;
    var_7._id_127B7 = undefined;
    var_7.timestamp = undefined;
  } else if(isDefined(var_1) && isDefined(var_7._id_127BD) && var_1 != var_7._id_127BD) {
    return;
  }
  var_8 = 0;

  if(istrue(var_3)) {
    var_8 = !var_7.visible;
    var_7.visible = 1;
  }

  if(isDefined(var_4))
    var_7.endtime = var_4;

  if(isDefined(var_5))
    var_7._id_127D0 = var_5;

  if(isDefined(var_6)) {
    var_7._id_127B7 = var_6;
    var_9 = level._id_127C7.instances[var_7._id_127BD];

    foreach(var_11 in var_9._id_126BE) {
      if(var_11 != var_0) {
        _id_127AB(var_0, undefined, undefined, undefined, undefined, var_5, undefined);
        _id_127A6(var_0);
      }
    }

    if(isDefined(var_9.team))
      _id_127AA(var_9, scripts\mp\utility\teams::getfriendlyplayers(var_9.team));
  } else if(isDefined(var_7.timestamp) && var_7.timestamp < gettime())
    var_7._id_127B7 = undefined;

  var_7.timestamp = gettime();
}

_id_12785(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_868823C1635D3723ACC9EB9BB29B32252B1CDBE65AE8B79CBCEA2D237695D19EDADCB32CC9");
  var_0._id_127CA = undefined;

  if(isDefined(var_1) && var_1 > 0)
    wait(var_1);

  var_0 setclientomnvar("_encstr_9A7819AED2FA9827BEC1635D73C8B239FA4E5938DBE6A547DE275E", 0);
}

_id_127A6(var_0) {
  var_0 notify("_encstr_868823C1635D3723ACC9EB9BB29B32252B1CDBE65AE8B79CBCEA2D237695D19EDADCB32CC9");
  var_1 = var_0._id_127CA;

  if(!isDefined(var_1)) {
    var_0 setclientomnvar("_encstr_9A7819AED2FA9827BEC1635D73C8B239FA4E5938DBE6A547DE275E", 0);
    return;
  }

  var_2 = 0;
  var_3 = 0;
  var_4 = var_1.visible;
  var_5 = 1;

  if(isDefined(var_4))
    var_2 = var_2 | int(var_4) << var_3;

  var_3 = var_3 + var_5;
  var_4 = var_1.type;
  var_5 = 1;

  if(isDefined(var_4))
    var_2 = var_2 | int(var_4) << var_3;

  var_3 = var_3 + var_5;
  var_4 = var_1.endtime;
  var_5 = 14;

  if(isDefined(var_4)) {
    var_4 = int(var_4 / 250);
    var_4 = var_4 & 16383;
    var_2 = var_2 | int(var_4) << var_3;
  }

  var_3 = var_3 + var_5;
  var_6 = getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E";

  if(var_1.type == 0) {
    var_4 = var_1._id_127D0;
    var_5 = 9;

    if(isDefined(var_4)) {
      var_7 = 5;

      if(var_6)
        var_7 = 50;

      var_4 = int(var_4 / var_7);
      var_4 = var_4 & 511;
      var_2 = var_2 | int(var_4) << var_3;
    }

    var_3 = var_3 + var_5;
    var_4 = var_1._id_127B7;
    var_5 = 6;

    if(isDefined(var_4)) {
      var_7 = 5;

      if(var_6)
        var_7 = 50;

      var_4 = int(var_4 / var_7);
      var_4 = var_4 & 63;
      var_2 = var_2 | int(var_4) << var_3;
    }
  } else {
    var_4 = var_1._id_127B7;
    var_5 = 15;

    if(isDefined(var_4)) {
      var_4 = int(var_4 / 5);
      var_4 = var_4 & 32767;
      var_2 = var_2 | int(var_4) << var_3;
    }
  }

  var_0 setclientomnvar("_encstr_9A7819AED2FA9827BEC1635D73C8B239FA4E5938DBE6A547DE275E", var_2);
}

_id_12780(var_0) {
  var_1 = level._id_127C7;
  var_2 = _id_1278C(var_0._id_127C8);

  if(!istrue(var_2._id_13AA5)) {
    return;
  }
  if(!isDefined(var_1._id_13AA6[var_0.team]))
    var_1._id_13AA6[var_0.team] = [];

  var_3 = [];

  for(var_4 = 1; var_4 <= 4; var_4++)
    var_3[var_4] = var_4;

  foreach(var_6 in var_1._id_13AA6[var_0.team])
  var_3[var_6.building_magic_grenade_damage] = undefined;

  foreach(var_9 in var_3) {
    var_0.building_magic_grenade_damage = var_9;
    break;
  }

  if(isDefined(var_0.building_magic_grenade_damage)) {
    var_1._id_13AA6[var_0.team] = scripts\engine\utility::array_add(var_1._id_13AA6[var_0.team], var_0);
    var_11 = var_1._id_13AA3[var_0.building_magic_grenade_damage];

    foreach(var_13 in scripts\mp\utility\teams::getfriendlyplayers(var_0.team))
    var_13 setclientomnvar(var_11, var_0 getentitynumber());
  } else {}
}

_id_12797(var_0) {
  var_1 = level._id_127C7;
  var_2 = var_0.building_magic_grenade_damage;

  if(!isDefined(var_2)) {
    return;
  }
  var_0.building_magic_grenade_damage = undefined;
  var_1._id_13AA6[var_0.team] = scripts\engine\utility::array_remove(var_1._id_13AA6[var_0.team], var_0);

  if(var_1._id_13AA6[var_0.team].size == 0)
    var_1._id_13AA6[var_0.team] = undefined;

  var_3 = var_1._id_13AA3[var_2];
  var_4 = var_1._id_13AA4[var_2];

  foreach(var_6 in scripts\mp\utility\teams::getfriendlyplayers(var_0.team)) {
    var_6 setclientomnvar(var_3, -1);
    var_6 setclientomnvar(var_4, 0);
  }
}

_id_127AA(var_0, var_1) {
  var_2 = level._id_127C7;

  if(!isDefined(var_0.building_magic_grenade_damage)) {
    return;
  }
  if(!isarray(var_1))
    var_1 = [var_1];

  if(var_1.size == 0) {
    return;
  }
  var_3 = 0;
  var_4 = 0;
  var_5 = 1;
  var_6 = 1;
  var_3 = var_3 + var_5;
  var_4 = var_4 + var_6;
  var_5 = var_0._id_127AF;
  var_6 = 14;

  if(isDefined(var_5)) {
    var_5 = var_5 / 250;
    var_5 = int(min(var_5, 16383));
    var_3 = var_3 + (var_5 << var_4);
  }

  var_4 = var_4 + var_6;
  var_5 = var_0._id_127D0;
  var_6 = 9;

  if(isDefined(var_5)) {
    var_5 = var_5 / 5;
    var_5 = int(min(var_5, 511));
    var_3 = var_3 + (var_5 << var_4);
  }

  var_7 = var_2._id_13AA4[var_0.building_magic_grenade_damage];

  foreach(var_9 in var_1) {
    if(scripts\engine\utility::array_contains(var_0._id_126BE, var_9)) {
      var_9 setclientomnvar(var_7, var_3 &~1);
      continue;
    }

    var_9 setclientomnvar(var_7, var_3);
  }
}