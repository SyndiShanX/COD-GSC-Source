/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\white_phosphorus.gsc
**************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", "_encstr_88C5055208731B")]]();

  level._effect["_encstr_AB9621508BDF4BBD37E0D8A83059A82FEDBB0B71DFA68B74420F20D3E019D7CBA08A32"] = loadfx("_encstr_A1DB3A1D358310ABDC8ACE958B2DF3889371C02473C3F75F97A5A8293FEF62F99BFB8183AB1DB8C81250D3239F1F272028E097B068A2AF9A8083490B");
  level._effect["_encstr_AB2918F74B50AB2FCFE8E2AAC8A9248F6BAD7BA75EB90BF753F0"] = loadfx("_encstr_82A836C3919877C2F4393F8FD1B0AA7960783ACB8B98C13AE08DD3D3A74462A10821B95220709BC3ABA79BFFE7789BE3C089AF5D50D0567B");
  level.activewpzones = [];
  level.activewpinnerzones = [];
  level.white_phosphorus_damage_area = getEnt("_encstr_8EA4184B2207A5B041E0595F0B7220E0836B43F64A7F51D867CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

weapongivenwp(var_0) {
  if(istrue(level.wpinprogress)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A9F6169A6CF8A15F646309113F5B185FE1016716B3942DC5");

    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656")]](0, 1, 1);

  return 1;
}

tryusewp() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", self);
  return tryusewpfromstruct(var_0);
}

tryusewpfromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  var_1 = getcompleteweaponname("_encstr_B42011379B76D2F27318ABE7680BCA981E68D3");
  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, var_1, 1, ::weapongivenwp);

  if(!istrue(var_2))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  var_3 = wp_getmapselectioninfo(var_0, 1, 1);

  if(!isDefined(var_3))
    return 0;

  thread wp_startdeploy(var_3, var_0);
  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](self, var_0.streakname);
    var_4 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_0.streakname, 1, var_4);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]]("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_A20516C8533FA186AF10CBBDF5E7AB6165FB58A80A92CB5B", self);

  return 1;
}

wp_getmapselectioninfo(var_0, var_1, var_2) {
  scripts\common\utility::allow_weapon_switch(0);
  self setsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB"))
    var_3 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB")]](var_0, var_1, var_2);

  if(!isDefined(var_3)) {
    scripts\common\utility::allow_weapon_switch(1);
    self clearsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
    return undefined;
  }

  scripts\common\utility::allow_weapon_switch(1);
  self clearsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
  return var_3;
}

wp_startdeploy(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(level.wpinprogress)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A9F6169A6CF8A15F646309113F5B185FE1016716B3942DC5");

    return 0;
  }

  level.wpinprogress = 1;

  foreach(var_6, var_3 in var_0) {
    var_4 = var_3.location;
    var_5 = var_3.angles;
    wp_finishdeployment(var_4, var_5, var_1);

    if(var_0.size > 1 && var_6 < var_0.size - 1)
      wait(randomfloatrange(1, 3.0));
  }
}

wp_finishdeployment(var_0, var_1, var_2) {
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread _id_145E6("_encstr_8D820B49520F0EC02DDE6367EC");
  thread _id_145E6("_encstr_81170C244F9CBDE72C01BB99A298");
  thread _id_145E6("_encstr_923011E397F3A22518DEF23AB1087CEAD53F1B");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  var_3 = wp_createplane(var_0, var_1, var_2);

  if(!isDefined(var_3))
    return 0;

  var_3 thread _id_145EA();
  var_3 thread wp_deliverpayloads(var_2);
}

wp_createplane(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_4 = 28000;
  var_5 = 5000;
  var_6 = 2500;
  var_7 = 1500;
  var_8 = (0, var_1, 0);

  if(!isDefined(var_3))
    var_6 = var_6 + 3000;
  else {
    var_6 = var_3.origin[2] + 3000;
    var_7 = scripts\cp_mp\killstreaks\airstrike::getexplodedistance(var_6);
  }

  var_9 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_0, var_8, var_4, var_3, var_6, var_5, var_7);
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_9["_encstr_B18C0B5E9C6FA319E20A487853"]);
  var_10.angles = var_8;
  var_10.flightpath = var_9;
  var_10.owner = self;
  var_10.team = self.team;
  var_10.streakinfo = var_2;
  var_10.speed = var_5;
  var_11 = "_encstr_99331DB5CFDA43990534F896DEF9080883170D336BF22E40721B866BC7CB70";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(self))
    var_11 = "_encstr_932518D55D2CF2809FB290FE1AA7CE1102A51D63C655E8D19A6F";

  var_10 setModel(var_11);
  var_12 = undefined;
  var_13 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841"))
    var_13 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841");

  if(isDefined(var_13)) {
    var_12 = var_10[[var_13]]("_encstr_B89D105A36DB9BD76B2D9B4BB60BC17DEEE0", var_10.team, 1, 1, 1);
    var_10.minimapid = var_12;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_10[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_10.streakinfo.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", self);

  return var_10;
}

_id_145E6(var_0, var_1) {
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill(var_0);
  level.wpinprogress = undefined;
  level notify("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
}

_id_145EA() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  wp_removeplane(self);
}

_id_145E8() {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");

  if(_id_145E3("_encstr_BE7206A2D07B1322", self))
    level wp_removefromactivewplist("_encstr_BE7206A2D07B1322", self);
  else {
    var_0 = 0;

    if(var_0)
      self freescriptable();
    else
      self delete();
  }
}

_id_145E7(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");

  if(isDefined(self.killcament))
    self.killcament delete();

  if(_id_145E3("_encstr_AC8F06D3206EFD9B", self))
    level wp_removefromactivewplist("_encstr_AC8F06D3206EFD9B", self, var_0, 1);

  self notify("_encstr_8BD01660BB25E1EED760B8A65CB7B3A38A9158B0F2FF7F43");
  var_1 = 0;

  if(var_1)
    self freescriptable();
  else
    self delete();
}

wp_deliverpayloads(var_0) {
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.flightpath["_encstr_B18C0B5E9C6FA319E20A487853"];
  var_2 = self.flightpath["_encstr_ACB7092280809AF7F8F8DB"];
  var_3 = self.flightpath["_encstr_B602088CA52B1198DD3F"];
  var_4 = var_1 + anglesToForward(self.angles) * 12500;
  var_5 = var_2 - anglesToForward(self.angles) * 12500;
  var_6 = length(var_4 - var_5);
  var_7 = 30;
  self.owner thread wp_watchend(var_0, var_7);
  self.owner thread _id_145E9(var_0);
  self moveTo(var_2, var_3);
  self setscriptablepartstate("_encstr_B6C907C4EDC8BC19B0", "_encstr_AB0703DBB9", 0);
  self scriptmodelplayanim("_encstr_911C145D5321E22B70F8ADB21BCAF2BB36554B1B0B62");
  thread wp_enterpayloadaudio();
  thread wp_exitpayloadaudio(var_2, var_3);
  var_9 = 3;
  wp_handlepayloadtyperelease(::wp_fireairburst, var_1, var_4, var_6, var_7, 4000, var_9, 1);
  wp_handlepayloadtyperelease(::wp_firesmoke, var_1, var_4, var_6, var_7, 4000, 3, 1);
  wp_handlepayloadtyperelease(::wp_fireflaregroup, var_1, var_4, var_6, var_7, 2000, 6, 2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_3);
  self stopsounds();
  self scriptmodelplayanimdeltamotion("_encstr_81AF13C8027FF2332648881FB047AAA3B7E9016953");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5.33);
  wp_removeplane(self);
}

wp_watchend(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  self notify("_encstr_97E21AEE435AE82BD70ED0F6E607A1BD39D5CDFACC2DB9B4B986AC32");
  scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
}

_id_145E9(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_97E21AEE435AE82BD70ED0F6E607A1BD39D5CDFACC2DB9B4B986AC32");
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
}

wp_enterpayloadaudio() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  waitframe();
  self playsoundonmovingent("_encstr_863F1DD3DF87A86060C1F328744C68E05BCBA76FE79B0542DD29D9A01802B0");
}

wp_exitpayloadaudio(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  playsoundatpos(var_0, "_encstr_BE7F1C2F308ACF4279307BB403299A87EBB0BFDFD95B3D7F1B28C7A87B01");
}

wp_watchunsuccessfulzones(var_0) {
  level endon("_encstr_9672125F836EF27A4D25497A157FF2B571C86F9B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(var_1 = 0; var_1 < var_0; var_1++)
    level waittill("_encstr_BDF40F0B73D06B5DF85BC7C66BF8A55FE5");

  level.wpinprogress = undefined;
}

wp_handlepayloadtyperelease(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = int(var_3 / var_5);
  var_9 = 0;

  if(!isDefined(var_6))
    var_6 = var_8;
  else {
    var_10 = var_8 - var_6;
    var_9 = int(var_10 / 2);
  }

  if(isDefined(var_7))
    var_9 = var_9 + var_7;

  var_11 = anglesToForward(self.angles);
  var_12 = var_2;
  var_13 = 0;

  for(var_14 = 0; var_14 < var_8; var_14++) {
    var_15 = length(var_1 - var_12) / self.speed;

    if(var_14 < var_9) {
      var_12 = var_12 + var_11 * var_5;
      continue;
    }

    var_16 = var_12 - (0, 0, 2000);

    if(var_0 == ::wp_fireflaregroup) {
      var_17 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1 + (0, 0, 1500));
      var_17 thread wp_movekillcam(var_15, var_16, var_11, var_4);
      self thread[[var_0]](var_16, var_11, var_15, var_17);
    } else if(var_0 == ::wp_firesmoke)
      self thread[[var_0]](var_16, var_11, var_15, var_14);
    else
      self thread[[var_0]](var_16, var_11, var_15);

    var_12 = var_12 + var_11 * var_5;
    var_13++;

    if(var_13 == var_6) {
      break;
    }
  }
}

wp_movekillcam(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = var_1 - var_2 * 3500;
  var_4 = var_1 - var_2 * 1000;
  self moveTo(var_1, var_0 + 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0 + 2);
  self moveTo(var_4, 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_3);
  self delete();
}

wp_testpayloads(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
}

wp_fireairburst(var_0, var_1, var_2) {
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = var_0 - var_1 * 3000;
  var_4 = var_0 - var_1 * 2000;
  var_5 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  playFX(scripts\engine\utility::getfx("_encstr_AB9621508BDF4BBD37E0D8A83059A82FEDBB0B71DFA68B74420F20D3E019D7CBA08A32"), var_3, var_1);
  playsoundatpos(var_4, "_encstr_BA4B1FE96F42513FB77EEB22808D57195839977BA74064C3D750B35969E33B0D48");
}

wp_firesmoke(var_0, var_1, var_2, var_3) {
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(self.playersininitialsmokerange))
    self.playersininitialsmokerange = [];

  if(!isDefined(self.playersoutsideinitialsmokerange))
    self.playersoutsideinitialsmokerange = [];

  var_4 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype != "_encstr_B81904B04E6B")
    var_4 = 0;

  var_5 = scripts\engine\trace::ray_trace(var_0, var_0 - (0, 0, 10000));
  var_6 = var_5["_encstr_BD260953AA97E3F014279D"];
  var_7 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  var_9 = 0;

  if(var_9)
    var_10 = easepower("_encstr_851919ABBFA04768B9BB2B297348D0F6F8BB60FB4BE79191E110CF", var_6, self.angles);
  else {
    var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
    var_10 setModel("_encstr_A7E31794164F93CBD963FD67CFF817AFD96270D868676068E0");
    var_10 setentityowner(self.owner);
  }

  var_10.team = self.team;
  var_10.owner = self.owner;
  var_10.streakinfo = self.streakinfo;
  var_10 thread _id_145E8();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  level thread _id_145E5(var_10);

  if(istrue(var_4)) {
    var_11 = isDefined(var_3) && var_3 == 3;

    if(istrue(var_11)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.5);
      self.playersininitialsmokerange = scripts\common\utility::playersincylinder(var_6, 2000);
      self.playersoutsideinitialsmokerange = scripts\engine\utility::array_difference(level.players, self.playersininitialsmokerange);
      var_10 thread wp_watchdisorienteffect(2000, self.playersininitialsmokerange, self.playersoutsideinitialsmokerange);
    }
  } else {
    if(scripts\cp_mp\utility\game_utility::isnightmap() || scripts\cp_mp\utility\game_utility::update_operator_west_char_loc())
      var_10 setscriptablepartstate("_encstr_AD790C43755F6885C9FB9B9FFB23", "_encstr_AB0703DBB9", 0);
    else
      var_10 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9", 0);

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.5);
    var_10 thread wp_watchdisorienteffect(2000, var_4);
  }

  level wp_addtoactivewplist("_encstr_BE7206A2D07B1322", var_10);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_7);
  level wp_removefromactivewplist("_encstr_BE7206A2D07B1322", var_10);
}

wp_fireflaregroup(var_0, var_1, var_2, var_3) {
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = self.owner;
  var_5 = self.team;
  var_6 = self.angles;
  var_7 = scripts\engine\trace::ray_trace(var_0, var_0 - (0, 0, 10000), self, undefined, 1, 1);
  var_8 = var_7["_encstr_BD260953AA97E3F014279D"];
  var_9 = var_7["_encstr_8BCA0C2BFD504F333E6D7513637B"];
  var_10 = isDefined(level.white_phosphorus_damage_area);

  if(istrue(var_10)) {
    level.white_phosphorus_damage_area dontinterpolate();
    level.white_phosphorus_damage_area.owner = var_4;
    level.white_phosphorus_damage_area.team = var_5;
    level.white_phosphorus_damage_area.streakinfo = self.streakinfo;
  }

  var_11 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  var_12 = wp_getflarepositions(var_0, var_8, 4, int(250.0));

  foreach(var_14 in var_12) {
    var_15 = 0;

    if(var_15)
      var_16 = easepower("_encstr_851919ABBFA04768B9BB2B297348D0F6F8BB60FB4BE79191E110CF", var_14.flareorigin, var_6);
    else {
      var_16 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_14.flareorigin);
      var_16 setModel("_encstr_A7E31794164F93CBD963FD67CFF817AFD96270D868676068E0");
      var_16 setentityowner(var_4);
      var_16.angles = var_6;
    }

    var_16.owner = var_4;
    var_16.team = var_5;
    var_16.streakinfo = self.streakinfo;
    var_16.struct = var_14;
    var_16.weapon_name = "_encstr_95DB19EB1C61A8BDE1DBF1F7FF3B73281233136682C2B8E219B7F9";
    var_16.killcament = var_3;
    var_16 thread _id_145E7("_encstr_B89B0531ABE4CD");
    var_16 thread wp_projwatchimpact(var_11, "_encstr_B89B0531ABE4CD", var_9);
    wait(randomfloatrange(0.1, 0.4));
  }

  if(istrue(var_10))
    level.white_phosphorus_damage_area.origin = (0, 0, 50000);
}

wp_getflarepositions(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = self.angles * (0, 1, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"];
  var_9 = physics_createcontents(var_8);
  var_10 = -2000;
  var_11 = 0;

  for(var_12 = 0; var_12 < var_2; var_12++) {
    var_13 = var_6 * var_10 + var_7 * var_11;
    var_14 = var_1 + var_6 * var_10;
    var_15 = var_1 + var_13;
    var_16 = scripts\engine\trace::ray_trace(var_15 + (0, 0, var_0[2]), var_15 - (0, 0, 10000), level.characters, var_9);
    var_17 = var_16["_encstr_BD260953AA97E3F014279D"];
    var_18 = var_1 * (1, 1, 0) + (0, 0, var_17[2]) + var_6 * var_10;
    var_19 = spawnStruct();
    var_19.damageorigin = var_18;
    var_19.flareorigin = var_17;
    var_4[var_4.size] = var_19;
    var_10 = var_10 + 500;
    var_11 = randomintrange(-750, 750);
  }

  return var_4;
}

wp_projwatchimpact(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2.5);
  self.projimpacted = 1;
  level wp_addtoactivewplist("_encstr_AC8F06D3206EFD9B", self);
  self setscriptablepartstate("_encstr_878807108A42A309BB", "_encstr_AB0703DBB9", 0);

  if(isDefined(var_2) && var_2 == "_encstr_A28E0F9BEA9C99D1BC83B27DDDC23AB227")
    self setscriptablepartstate("_encstr_8CCA12AE212B9B0740FF7DA1CB79291F0735D8FB", "_encstr_AB0703DBB9", 0);
  else
    self setscriptablepartstate("_encstr_B1A9062B08CFA39F", "_encstr_AB0703DBB9", 0);

  var_3 = self.struct.damageorigin + (0, 0, 10);

  if(isDefined(self.owner))
    self radiusdamage(var_3, 512, 500, 500, self.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_95DB19EB1C61A8BDE1DBF1F7FF3B73281233136682C2B8E219B7F9");

  if(isDefined(var_2) && var_2 != "_encstr_A28E0F9BEA9C99D1BC83B27DDDC23AB227") {
    if(isDefined(var_1)) {
      self.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 100));

      if(var_1 == "_encstr_B89B0531ABE4CD")
        thread wp_watchburneffect(300);
      else
        thread wp_watchblindeffect(300);

      if(!scripts\common\utility::iscp()) {
        scripts\cp_mp\utility\killstreak_utility::killstreak_createdangerzone(self.origin, 300, 300, var_0, self.owner, self.team);
        thread _id_145E2();
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
    level wp_removefromactivewplist("_encstr_AC8F06D3206EFD9B", self, var_1, 1);
    self notify("_encstr_8BD01660BB25E1EED760B8A65CB7B3A38A9158B0F2FF7F43");
    self setscriptablepartstate("_encstr_B1A9062B08CFA39F", "_encstr_BA19049F4B2D", 0);
    self setscriptablepartstate("_encstr_8BBC0C1C5CB77BF3E90260581B7C", "_encstr_AB0703DBB9", 0);
  }

  if(isDefined(self.killcament))
    self.killcament delete();

  thread _id_145E1(15);
}

_id_145E2() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.dangerzoneid;
  self waittill("_encstr_AD75063D571AE108");
  scripts\cp_mp\utility\killstreak_utility::killstreak_destroydangerzone(var_0);
}

_id_145E1(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 0;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(var_1)
    self freescriptable();
  else
    self delete();
}

wp_watchdisorienteffect(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self.playersindisorientradius = [];

  if(isDefined(var_1) && isDefined(var_2)) {
    thread wp_delaydisorientplayersinrange(0.15, 2000, var_1);
    thread wp_delaydisorientplayersinrange(0.25, undefined, var_2);
  } else {
    for(;;) {
      var_3 = scripts\common\utility::playersincylinder(self.origin, var_0);
      var_4 = scripts\engine\utility::array_difference(level.players, var_3);

      foreach(var_6 in var_3) {
        if(!var_6 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        if(!wp_isinwpzone("_encstr_BE7206A2D07B1322", var_6, self))
          wp_addplayertostatusradiuslist("_encstr_BE7206A2D07B1322", var_6);

        if(!istrue(var_6.wpdisorient))
          var_6 thread wp_startdisorientplayer(self);
      }

      foreach(var_6 in var_4) {
        if(!var_6 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        if(istrue(var_6.wpdisorient) && wp_isinwpzone("_encstr_BE7206A2D07B1322", var_6, self))
          var_6 thread wp_stopdisorientplayer(self);
      }

      waitframe();
    }
  }
}

wp_getplayerswithinrange(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(distance2dsquared(self.origin, var_4.origin) <= var_1 * var_1)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

wp_delaydisorientplayersinrange(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0) && var_0 > 0)
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  var_3 = var_2;

  if(isDefined(var_1) && var_1 > 0)
    var_3 = wp_getplayerswithinrange(var_2, var_1);

  foreach(var_5 in var_3) {
    if(var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
      wp_addplayertostatusradiuslist("_encstr_BE7206A2D07B1322", var_5);

      if(!istrue(var_5.wpdisorient))
        var_5 thread wp_startdisorientplayer(self);
    }

    var_5 thread wp_startdisorientplayeronspawn(self);
  }
}

wp_watchburneffect(var_0) {
  self endon("_encstr_8BD01660BB25E1EED760B8A65CB7B3A38A9158B0F2FF7F43");
  self endon("_encstr_AD75063D571AE108");
  self.playersininnerradius = [];

  for(;;) {
    foreach(var_2 in level.players) {
      if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(distance2d(self.origin, var_2.origin) <= var_0 && scripts\engine\trace::ray_trace_passed(var_2 getEye(), self.origin + (0, 0, 30), var_2)) {
        if(!istrue(var_2.wpburning))
          var_2 thread wp_startburnplayer(self, self.owner);

        continue;
      }

      if(istrue(var_2.wpburning) && wp_isinwpzone("_encstr_AC8F06D3206EFD9B", var_2, self))
        var_2 wp_stopburnplayer(self);
    }

    waitframe();
  }
}

wp_watchblindeffect(var_0) {
  self endon("_encstr_8BD01660BB25E1EED760B8A65CB7B3A38A9158B0F2FF7F43");
  self endon("_encstr_AD75063D571AE108");
  self.playersininnerradius = [];

  for(;;) {
    foreach(var_2 in level.players) {
      if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(distance2d(self.origin, var_2.origin) <= var_0 && scripts\engine\trace::ray_trace_passed(var_2 getEye(), self.origin + (0, 0, 30), var_2)) {
        if(!istrue(var_2.wpblinding))
          var_2 wp_startblindplayer(self);

        continue;
      }

      if(istrue(var_2.wpblinding) && wp_isinwpzone("_encstr_AC8F06D3206EFD9B", var_2, self))
        var_2 wp_stopblindplayer(self);
    }

    waitframe();
  }
}

wp_addtoactivewplist(var_0, var_1) {
  if(var_0 == "_encstr_BE7206A2D07B1322")
    level.activewpzones[level.activewpzones.size] = var_1;
  else
    level.activewpinnerzones[level.activewpinnerzones.size] = var_1;
}

_id_145E3(var_0, var_1) {
  var_2 = 0;

  if(var_0 == "_encstr_BE7206A2D07B1322") {
    foreach(var_4 in level.activewpzones) {
      if(var_4 == var_1) {
        var_2 = 1;
        break;
      }
    }
  } else {
    foreach(var_4 in level.activewpinnerzones) {
      if(var_4 == var_1) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

wp_removefromactivewplist(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return;
  }
  var_4 = [];

  if(var_0 == "_encstr_BE7206A2D07B1322") {
    foreach(var_6 in level.activewpzones) {
      if(var_6 == var_1) {
        continue;
      }
      var_4[var_4.size] = var_6;
    }

    level.activewpzones = var_4;

    if(isDefined(var_1.playersindisorientradius)) {
      foreach(var_9 in var_1.playersindisorientradius) {
        if(isDefined(var_9) && !wp_isinanywpzone("_encstr_BE7206A2D07B1322", var_9))
          var_9 thread wp_stopdisorientplayer(var_1);
      }
    }

    if(level.activewpzones.size <= 0)
      level.wpinprogress = undefined;
  } else {
    foreach(var_6 in level.activewpinnerzones) {
      if(var_6 == var_1) {
        continue;
      }
      var_4[var_4.size] = var_6;
    }

    level.activewpinnerzones = var_4;

    if(isDefined(var_1.playersininnerradius)) {
      foreach(var_9 in var_1.playersininnerradius) {
        if(isDefined(var_9) && !wp_isinanywpzone("_encstr_AC8F06D3206EFD9B", var_9)) {
          if(var_2 == "_encstr_B89B0531ABE4CD") {
            var_9 thread wp_stopburnplayer(var_1);
            continue;
          }

          var_9 thread wp_stopblindplayer(var_1);
        }
      }
    }
  }

  if(istrue(var_3)) {
    return;
  }
  var_15 = 0;

  if(var_15)
    var_1 freescriptable();
  else
    var_1 delete();
}

wp_isinanywpzone(var_0, var_1) {
  var_2 = 0;

  if(var_0 == "_encstr_BE7206A2D07B1322") {
    foreach(var_4 in level.activewpzones) {
      if(wp_isinwpzone(var_0, var_1, var_4)) {
        var_2 = 1;
        break;
      }
    }
  } else {
    foreach(var_4 in level.activewpinnerzones) {
      if(wp_isinwpzone(var_0, var_1, var_4)) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

wp_isinwpzone(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = undefined;

  if(var_0 == "_encstr_BE7206A2D07B1322")
    var_4 = var_2.playersindisorientradius;
  else
    var_4 = var_2.playersininnerradius;

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(var_6 == var_1) {
        var_3 = 1;
        break;
      }
    }
  }

  return var_3;
}

wp_addplayertostatusradiuslist(var_0, var_1) {
  if(var_0 == "_encstr_BE7206A2D07B1322")
    self.playersindisorientradius[self.playersindisorientradius.size] = var_1;
  else
    self.playersininnerradius[self.playersininnerradius.size] = var_1;
}

wp_removeplayerfromstatusradiuslist(var_0, var_1) {
  if(var_0 == "_encstr_BE7206A2D07B1322") {
    var_2 = [];

    foreach(var_4 in self.playersindisorientradius) {
      if(var_4 == var_1) {
        continue;
      }
      var_2[var_2.size] = var_4;
    }

    self.playersindisorientradius = var_2;
  } else {
    var_2 = [];

    foreach(var_4 in self.playersininnerradius) {
      if(var_4 == var_1) {
        continue;
      }
      var_2[var_2.size] = var_4;
    }

    self.playersininnerradius = var_2;
  }
}

wp_removeplayerfromallstatusradiuslists(var_0, var_1) {
  if(var_0 == "_encstr_BE7206A2D07B1322") {
    foreach(var_3 in level.activewpzones) {
      if(wp_isinwpzone(var_0, var_1, var_3))
        var_3 wp_removeplayerfromstatusradiuslist(var_0, var_1);
    }
  } else {
    foreach(var_3 in level.activewpinnerzones) {
      if(wp_isinwpzone(var_0, var_1, var_3))
        var_3 wp_removeplayerfromstatusradiuslist(var_0, var_1);
    }
  }
}

wp_startdisorientplayeronspawn(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    var_0 wp_addplayertostatusradiuslist("_encstr_BE7206A2D07B1322", self);
    thread wp_startdisorientplayer(var_0);
  }
}

wp_startdisorientplayer(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_BD6B0FA6549F2B9737A2A0386B0CABA0AB");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.wpdisorient = 1;

  while(isDefined(self.sessionstate) && self.sessionstate != "_encstr_877508C1D8C22F2DDC3B")
    waitframe();

  thread wp_stopdisorientonplayerdeath(var_0);
  thread wp_monitorsmokevisionset(var_0);
  playfxontagforclients(scripts\engine\utility::getfx("_encstr_AB2918F74B50AB2FCFE8E2AAC8A9248F6BAD7BA75EB90BF753F0"), self, "_encstr_A130084D2FDAD8AA8F62", self);

  if(level.teambased && self.team == var_0.team || self == var_0.owner) {
    var_1 = 1;

    if(istrue(var_1))
      return;
  }

  self.wphealthblock = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5")]]("_encstr_B1D01DCD1CB21BA585C6A397BE268D7BB1DAEBD02B85631D34FA4ECACECAE6");

  if(self.health > 10) {
    var_3 = wp_gethealthdebuffamount();
    wp_degenhealth(var_3, var_0);
  }

  if(!wp_hasresistperk())
    enableloopingcoughaudio();
}

wp_degenhealth(var_0, var_1) {
  if(istrue(self.gasmaskequipped)) {
    return;
  }
  if(!isDefined(self.wphealthblock)) {
    self.wphealthblock = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5")]]("_encstr_B1D01DCD1CB21BA585C6A397BE268D7BB1DAEBD02B85631D34FA4ECACECAE6");
  }

  self dodamage(var_0, self.origin, var_1.owner, var_1, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_95DB19EB1C61A8BDE1DBF1F7FF3B73281233136682C2B8E219B7F9");
}

wp_startdofshiftforplayer(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(istrue(self.wpdisorient))
    wait(randomfloatrange(1, 3));
}

wp_stopdisorientonplayerdeath(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BD6B0FA6549F2B9737A2A0386B0CABA0AB");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  wp_stopdisorientplayer(var_0, 1);
}

wp_stopdisorientplayer(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(var_1))
    level wp_removeplayerfromallstatusradiuslists("_encstr_BE7206A2D07B1322", self);
  else
    var_0 wp_removeplayerfromstatusradiuslist("_encstr_BE7206A2D07B1322", self);

  if(!wp_isinanywpzone("_encstr_BE7206A2D07B1322", self) || istrue(var_1)) {
    if(istrue(self.wpdisorient)) {
      self.wpdisorient = undefined;

      if(scripts\cp_mp\utility\player_utility::_isalive())
        scripts\mp\utility\player::_id_12CC5(2);

      stopfxontagforclients(scripts\engine\utility::getfx("_encstr_AB2918F74B50AB2FCFE8E2AAC8A9248F6BAD7BA75EB90BF753F0"), self, "_encstr_A130084D2FDAD8AA8F62", self);

      if(istrue(self.wphealthblock)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD")]]("_encstr_B1D01DCD1CB21BA585C6A397BE268D7BB1DAEBD02B85631D34FA4ECACECAE6");

        self.wphealthblock = undefined;
      }

      disableloopingcoughaudio();
      self notify("_encstr_BD6B0FA6549F2B9737A2A0386B0CABA0AB");
    }
  }
}

wp_startburnplayer(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_85BD0D5BC8B77A1FB36F0F2A857B93");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(level.teambased && self.team == var_0.team && self != var_0.owner) {
    var_2 = 1;

    if(istrue(var_2))
      return;
  }

  var_0 wp_addplayertostatusradiuslist("_encstr_AC8F06D3206EFD9B", self);
  self.wpburning = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_B1870D0FE8B1C262638EEB22F05D59"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_B1870D0FE8B1C262638EEB22F05D59")]](undefined, "_encstr_8C8F0A271958E29348C8438F");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_84C817B29003834F7B7D8BAF8EA36FCF61704A9A60B57BAB91"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_84C817B29003834F7B7D8BAF8EA36FCF61704A9A60B57BAB91")]]("_encstr_884B19BB1AD2E895EBC11ADE9B07A1DEC9BA37F5C4D593DC96739D", ::wp_playcorpsetableburningfx);

  thread wp_stopstatuseffectondeath(var_0);
  var_4 = 10;

  for(;;) {
    if(self.health <= var_4)
      self notify("_encstr_8D1A0B6ED1BD1CAF3295CE2BDC");

    self dodamage(var_4, self.origin, var_1, var_0, "_encstr_9B0D099AD3887D91252954", var_0.weapon_name);
    wait 0.5;
    var_4++;

    if(var_4 >= 20)
      var_4 = 20;

    self.lastburntime = gettime();
  }
}

wp_stopburnplayer(var_0) {
  var_0 wp_removeplayerfromstatusradiuslist("_encstr_AC8F06D3206EFD9B", self);

  if(!wp_isinanywpzone("_encstr_AC8F06D3206EFD9B", self)) {
    wp_resetstatuseffect();
    self notify("_encstr_85BD0D5BC8B77A1FB36F0F2A857B93");
  }
}

wp_startblindplayer(var_0) {
  if(level.teambased && self.team == var_0.team || self == var_0.owner) {
    var_1 = 1;

    if(istrue(var_1))
      return;
  }

  var_0 wp_addplayertostatusradiuslist("_encstr_AC8F06D3206EFD9B", self);
  self.wpblinding = 1;
  thread wp_stopstatuseffectondeath(var_0);
  self visionsetnakedforplayer("_encstr_A2A0097783F5991B1627B2", 1);
}

wp_stopblindplayer(var_0) {
  var_0 wp_removeplayerfromstatusradiuslist("_encstr_AC8F06D3206EFD9B", self);

  if(!wp_isinanywpzone("_encstr_AC8F06D3206EFD9B", self))
    wp_resetstatuseffect();
}

wp_stopstatuseffectondeath(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  wp_resetstatuseffect(1);
}

wp_resetstatuseffect(var_0) {
  if(istrue(self.wpburning)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_AC7F0ED86A22C349BB7536A55A8BF5F9"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AC7F0ED86A22C349BB7536A55A8BF5F9")]](undefined, "_encstr_8C8F0A271958E29348C8438F");

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8CF17F18B73B76D2BBA77EDF37386196B6AFE4A8D50E8FA1B"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8CF17F18B73B76D2BBA77EDF37386196B6AFE4A8D50E8FA1B")]]("_encstr_884B19BB1AD2E895EBC11ADE9B07A1DEC9BA37F5C4D593DC96739D");
    }

    self.wpburning = undefined;
  }

  if(istrue(self.wpblinding)) {
    self.wpblinding = undefined;

    if(wp_isinanywpzone("_encstr_BE7206A2D07B1322", self))
      self visionsetnakedforplayer(wp_getsmokevisionset(), 1);
    else
      scripts\mp\utility\player::_id_12CC5(1);
  }

  if(istrue(var_0))
    level wp_removeplayerfromallstatusradiuslists("_encstr_AC8F06D3206EFD9B", self);
}

wp_removeplane(var_0) {
  if(isDefined(var_0.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](var_0.minimapid);

    var_0.minimapid = undefined;
  }

  var_0 delete();
}

wp_getsmokevisionset() {
  var_0 = "_encstr_A2CD09BB38AFCD5BDBB656";
  var_1 = "_encstr_A9270F372BDE16C8F708113FDE012F30B0";
  var_2 = var_0;

  if(scripts\cp_mp\utility\game_utility::isnightmap() || scripts\cp_mp\utility\game_utility::update_operator_west_char_loc())
    var_2 = var_1;

  return var_2;
}

wp_monitorsmokevisionset(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD6B0FA6549F2B9737A2A0386B0CABA0AB");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = undefined;

  for(;;) {
    if(istrue(self.wpdisorient)) {
      var_2 = wp_getsmokevisionset();

      if(!isDefined(var_1) || var_2 != var_1) {
        var_1 = var_2;
        self visionsetnakedforplayer(var_2, 2);
      }
    }

    waitframe();
  }
}

wp_gethealthdebuffamount() {
  var_0 = 50;

  if(wp_hasresistperk())
    var_0 = var_0 * 0.5;

  var_1 = self.health;
  var_2 = var_1 - var_0;

  if(var_2 < 10)
    var_0 = var_0 - (10 - var_2);

  return var_0;
}

wp_playcorpsetableburningfx(var_0) {
  var_0 setscriptablepartstate("_encstr_ADF30BB0CB5749EBDB6D5BD007", "_encstr_86390885FB5A76780D42", 0);
}

wp_hasresistperk() {
  return isDefined(self.perks) && isDefined(self.perks["_encstr_AD22156EC1AC1BD2B0B18EF2AF471636D7C9AC37B4E6E8"]);
}

enableloopingcoughaudio() {
  if(!isDefined(self.loopingcoughaudio))
    self.loopingcoughaudio = 0;

  self.loopingcoughaudio++;

  if(self.loopingcoughaudio == 1)
    thread startloopingcoughaudio();
}

disableloopingcoughaudio() {
  if(!isDefined(self.loopingcoughaudio)) {
    return;
  }
  self.loopingcoughaudio--;

  if(self.loopingcoughaudio == 0) {
    thread stoploopingcoughaudio();
    self.loopingcoughaudio = undefined;
  }
}

startloopingcoughaudio() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B90176C8D560B9331F6DEC1A5B93B68EDBAEC0D0A578C5AF6");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = randomfloatrange(4, 7);

    if(!loopingcoughaudioissupressed() && isDefined(self.operatorcustomization)) {
      var_1 = "_encstr_8E1818B77DCD5F5A13A0419AD87357239EFE072D3789A7A0575A";

      if(self.team == "_encstr_9A8507BA4040188D08") {
        if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39") {
          var_2 = game["_encstr_B85109BAD04FB3DD30FB7D"]["_encstr_92E414E9DDA4807DE3A72D2347EA31387FF6D0E38718"].size;
          var_3 = randomint(var_2);
          var_1 = game["_encstr_B85109BAD04FB3DD30FB7D"]["_encstr_92E414E9DDA4807DE3A72D2347EA31387FF6D0E38718"][var_3];
        } else {
          var_2 = game["_encstr_B85109BAD04FB3DD30FB7D"]["_encstr_95601258368D2D9537EBD60B36B2BE36DEBACE86"].size;
          var_3 = randomint(var_2);
          var_1 = game["_encstr_B85109BAD04FB3DD30FB7D"]["_encstr_95601258368D2D9537EBD60B36B2BE36DEBACE86"][var_3];
        }
      } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39") {
        var_2 = game["_encstr_B85109BAD04FB3DD30FB7D"]["_encstr_8A8212C848BAAF6F561DB0DB718B408E65EF17CB"].size;
        var_3 = randomint(var_2);
        var_1 = game["_encstr_B85109BAD04FB3DD30FB7D"]["_encstr_8A8212C848BAAF6F561DB0DB718B408E65EF17CB"][var_3];
      } else {
        var_2 = game["_encstr_B85109BAD04FB3DD30FB7D"]["_encstr_B2A11071DBFFEEA9152999F36FFE60B59F72"].size;
        var_3 = randomint(var_2);
        var_1 = game["_encstr_B85109BAD04FB3DD30FB7D"]["_encstr_B2A11071DBFFEEA9152999F36FFE60B59F72"][var_3];
      }

      if(!isai(self))
        self playsoundtoplayer("_encstr_AC1F11299EBB31F7125F13233B09B66855F730", self, self);

      if(istrue(self.loopingcoughaudio))
        self playsoundonmovingent(var_1);
    }

    wait(var_0);
  }
}

stoploopingcoughaudio() {
  self notify("_encstr_9B90176C8D560B9331F6DEC1A5B93B68EDBAEC0D0A578C5AF6");
}

enableloopingcoughaudiosupression() {
  if(!isDefined(self.loopingcoughaudiosupression))
    self.loopingcoughaudiosupression = 0;

  self.loopingcoughaudiosupression++;
}

disableloopingcoughaudiosupression() {
  if(!isDefined(self.loopingcoughaudiosupression)) {
    return;
  }
  self.loopingcoughaudiosupression--;
}

loopingcoughaudioissupressed() {
  return isDefined(self.loopingcoughaudiosupression) && self.loopingcoughaudiosupression > 0;
}

clearloopingcoughaudio() {
  self notify("_encstr_9B90176C8D560B9331F6DEC1A5B93B68EDBAEC0D0A578C5AF6");
  self.loopingcoughaudio = undefined;
  self.loopingcoughaudiosupression = undefined;
}

_id_145E5(var_0) {
  var_0 setscriptablepartstate("_encstr_A78A0E2DB50E0BD847D76C56B94756C9", "_encstr_AB0703DBB9", 0);
  waitframe();
  var_0 setscriptablepartstate("_encstr_A78A0E2DB50E0BD847D76C56B94756C9", "_encstr_BA19049F4B2D", 0);
}