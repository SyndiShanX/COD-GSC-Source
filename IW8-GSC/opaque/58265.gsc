/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58265.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_9B7310AFD59D7A46303148D96B5882726203", ::_id_13E2A, ::_encstr_8F8F24BF8057BB97CDFD35C10B8A14EAC22A3AAF29749837F4A83F4320A6C3A99B1C212AF9AD);
  scripts\common\ui::lui_registercallback("_encstr_914421D3F7690B2360504ADF450F8FA7777BF4D930EB3583A27AA786B0CB4B163C7AB9", ::_id_1266A);
  super_enemy_spawning();
  super_has_targets();
  scripts\common\utility::allow_register_set("_encstr_881D1D7639B2B2371316E57DB98E9CD2D62BF5C959B947E44BB18EA5EDB9E6", ["_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_914C0EDDB20B837BB97D38D2365BAB83", "_encstr_92100762872552A643", "_encstr_919007AA5148539DA0", "_encstr_88780599B4E495", "_encstr_AD1904291F7B", "_encstr_A6C7065BACB1CA95", "_encstr_880811DD703AAFCB14FF28383F59A3C902DE42", "_encstr_B24E11E8C140668309413A234F0BE9176B9185", "_encstr_962F0CB3560DD236D8CAD7576E59", "_encstr_84B60AC693C2E8B27D5DCDCA", "_encstr_B2050D90D3372F6698BB027983772A"]);
}

super_enemy_spawning() {
  level.sentry_shouldshoot = spawnStruct();
  level.sentry_shouldshoot.inuse = 0;
  level.sentry_shouldshoot.stab_blink_black_fade = 0;
  level.sentry_shouldshoot.triggers = [];
  level.sentry_shouldshoot._id_13DC5 = 0;
  level.sentry_shouldshoot.playersintrigger = [];
  level.sentry_shouldshoot._encstr_B1750D0F608BA17A1BEE86FF5B1333 = getdvarint("_encstr_A33D13DEBE43DF112A2F2080FB6FC9A77BA4DDE5D4", 2000);
  level.sentry_shouldshoot._encstr_8BCA0C34F3A88C1978EDFD392373 = getdvarint("_encstr_B2941BFBC8D3679A7310D7B2D1694A9719BB9887B4C7D32FDA8B606858", 1);
  level.sentry_shouldshoot._encstr_967E0AA00EC0E5111D384302 = getdvarfloat("_encstr_A7FC19035EBEF16A2BF1C542D887B4A8FDCFD2C77237D05910ECC1", 100);
  level.sentry_shouldshoot._encstr_A9E30B72E87D873FFBB5FAE1CB = getdvarfloat("_encstr_8EB21D9BB04D712BD338FDF0479EF7898B08D2D130D3320B2E1FECF4D7219F", 2500);
  level.sentry_shouldshoot._encstr_8AE90EB5B4DC8C5ACD4785D1E885B1B6 = level.sentry_shouldshoot._encstr_A9E30B72E87D873FFBB5FAE1CB + getdvarint("_encstr_825614CD1BC97D139C7D6B3C83EB76FA632B73763AD0", 8000) / 2;
  level.vehicle_shoulddocollisiondamagetoplayer = spawnStruct();
  level.vehicle_shoulddocollisiondamagetoplayer.inuse = 0;
  level.vehicle_shoulddocollisiondamagetoplayer._encstr_B1750D0F608BA17A1BEE86FF5B1333 = getdvarint("_encstr_A3531496F60B9769526778C8C3A7805FF39E8513CBB3", 4000);
  level.vehicle_shoulddocollisiondamagetoplayer._encstr_AC4C092FD011D2B2751CEF = getdvarint("_encstr_A79517CDC693BE264EBED6C338FAB5BEB5B491D7272C37CE56", 10000);
  level.vehicle_shoulddocollisiondamagetoplayer._encstr_87560A36DE9BEC272CCD9D95 = getdvarint("_encstr_AAD518E6C69CEB3139D7DA1E1CBEDA7D36DB37767DC985DCD959", 30000);
  level.vehicle_shoulddocollisiondamagetoplayer._encstr_A15C0C015783D18BDA6B58281237 = getdvarint("_encstr_BEC11A782BF261E2EB214A485097D7A7D528E5394092DF9BB7308A38", 50000);
  level.vehicle_shoulddocollisiondamagetoplayer._encstr_858E17D3DDC7A75F2868516684DBCBA1437B01FEEA21A0DF27 = getdvarint("_encstr_A62724B9B1E4BE13C9EBB60FE0AFD6F539DE1B5B7D76275867968E2FF5B55A23FA4E58B9CECA", 12000);
  level.vehicle_shoulddocollisiondamagetoplayer._encstr_9938184E7B8DB5EBD993583BD23AF2EBD8ED37ECAF932CB9B356 = getdvarint("_encstr_A11F25274FE368D8A20170EAF2A758A03B97FF9F271A4698DEE45BC2D14C406002EF55134B6285", 9000);
  level.vehicle_shoulddocollisiondamagetoplayer._encstr_A5C21AC360CEC27EE21DBA05600B721F24F8D8CF311AE1DAA288D8AD = getdvarint("_encstr_BE13279B1B4EBE3193F5DA1EC1BEDAEB4E7B8DB57DB3C9586796D1CBD78DDB73D9564EFA27B0DC9DCA", 5000);
  level.vehicle_shoulddocollisiondamagetoplayer._encstr_B6E91BA2D02053C19CCDA7C3C33D6BAF80385D6F0908F4996E83938F33 = getdvarint("_encstr_A23F28CEAE53CF211A1F30908B1F58973BD54E5A09BA5D89E6DFC0804F74103DB2FF3E5D9103C310DF07", 2500);
  level.vehicle_shoulddocollisiondamagetoplayer._encstr_8C6C15928873EF7FEB33BD3D29AE5F9A38B7FBFB5037E0 = getdvarint("_encstr_B60A229BBAD0619A88287BE83BB7CF5FA57A466281271A27C58117204835C9154F4D370F", 6000);
  level.vehicle_shoulddocollisiondamagetoplayer._encstr_858816B30A77420932982B13B411D8181BE26E3B72EB8C2B = getdvarint("_encstr_921723A397D391C29E8FD2FB133F72665B57916A0107CB6D9AE1373078458C97ABCAC8E9B7", 6000);
  level.vehicle_shoulddocollisiondamagetoplayer._encstr_A39318F3AF63AA0F7B91DD216136B0324E18CB05F8403B22773A = getdvarint("_encstr_ADAE25DBC862419D92E620A2E34F0BF7EB874230474BAA723F6CF1C2F04DDF8A40A622F9A80FAD", 7000);
  level.vehicle_shoulddocollisiondamagetoplayer._encstr_8F3819637DE7B7A1D84B4D07EC595D775B5AAFF39836AAB96B7A02 = getdvarint("_encstr_873C269713F29156ABA9F84243479AD98A673F3F871A302D1F32B6C8DAAB44F062D43F852185C065", 9000);
}

super_has_targets() {
  level._effect["_encstr_83C510EC932B2BCD4C0BBCBE96AD8385C68E"] = loadfx("_encstr_84783F88A340D0E35B28B02692F62B838C57B0901EF751B3022211BFA82E1B09E6FB30888FC70B6DFB811E3E1241471151E729E0E721833DB230984B9D8B9379AC");
  level._effect["_encstr_AF8C1799EA1D5048A20F6327077A8FC8B3C30670544E08F57B"] = loadfx("_encstr_9B3646A4071BC7B8E76A7968BB4770B7826E1025CD822360DD63E878BF6F88C30AD718B536BEC5C998C780F88E470105823898338FB29973693761289F8099BF7B2989CBA58A733B");
  level._effect["_encstr_BE9917EFEB729558526E12AE1435E0DF4A5B27490BDA63D87A"] = loadfx("_encstr_8B1446FE454845372C9A518AFB286F0A80336E747F081EEFDD8B5AA2E270B747489117EC7BA263BB7B86B29B83A0A7FE9833AF489B88AB23AF7A7952500FF776489718C42BE0377B");
}

_id_13E2A(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  var_1 = getcompleteweaponname("_encstr_817D15E2C8EFD2DFE8884C5588F0DF1C2F90EB4A41738A");
  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, var_1, 1, ::_id_14587, undefined, ::_encstr_916F17F85180D007AEF3D33A3B0E6B0BC833707FFD201ED7DA);

  if(!istrue(var_2))
    return 0;

  var_3 = undefined;

  if(!isDefined(var_0._id_13A81)) {
    if(getdvarint("_encstr_919A2B0F8B7A19EE132160CABBCF1408D7E5ADA53160B02DCB7AB811513FD8E06F753305CC4150FBE7129138DA", 1))
      scripts\common\utility::allow_movement(0);

    var_3 = _id_14582(var_0, var_1, undefined);

    if(getdvarint("_encstr_919A2B0F8B7A19EE132160CABBCF1408D7E5ADA53160B02DCB7AB811513FD8E06F753305CC4150FBE7129138DA", 1))
      scripts\common\utility::allow_movement(1);

    if(!isDefined(var_3) || !istrue(var_3.success)) {
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_0.streakname, self.origin);

  thread _id_1384D(var_3, var_0);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_0);

  return 1;
}

_encstr_8F8F24BF8057BB97CDFD35C10B8A14EAC22A3AAF29749837F4A83F4320A6C3A99B1C212AF9AD(var_0) {
  if(scripts\engine\utility::cointoss())
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_BDF5174B114617DEE02FFCC545F8665F78C9C213BB93F31740", self);
  else
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_ABEC1C7358A567BF98804C452C208FAF57D0FAABAB4B1AE7D1E8547D4689", self);
}

_encstr_916F17F85180D007AEF3D33A3B0E6B0BC833707FFD201ED7DA(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");

  if(istrue(var_0.failed) || !isDefined(var_0._id_13923))
    scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);
  else {
    var_3 = "_encstr_869F1E422A011541855F78F8B7AFDB792A55C65B893ADD897543F0C057C7D081";

    if(var_0._id_13923 == 1)
      var_3 = "_encstr_96E51D92FAD1C5B175AFA828879F8B097A6516AB59CAA3982FE750F09FA5A3";

    var_4 = getcompleteweaponname(var_3);
    self giveweapon(var_4, 0, 0, -1, 1);
    self switchtoweaponimmediate(var_4);
    scripts\common\utility::allow_set("_encstr_881D1D7639B2B2371316E57DB98E9CD2D62BF5C959B947E44BB18EA5EDB9E6", 0, "_encstr_AF7815C0654DDD22C15910CF2D7B6F82C438E6E1169CC2");
    var_5 = 4.3;
    wait(var_5);
    scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);
    scripts\common\utility::allow_set("_encstr_881D1D7639B2B2371316E57DB98E9CD2D62BF5C959B947E44BB18EA5EDB9E6", 1, "_encstr_AF7815C0654DDD22C15910CF2D7B6F82C438E6E1169CC2");
    scripts\cp_mp\utility\inventory_utility::getridofweapon(var_4, 1);
  }

  var_6 = self getcurrentweapon();

  if(var_6.basename == "_encstr_8BBA05185F8B99")
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
}

serverroomdogtagrevive(var_0, var_1, var_2) {
  _encstr_BA5F1137E893D2ADB20BD163DBB1851D2DF637(var_0, var_1, var_2, 2);
}

_encstr_9AA1164FAB6FF3856E370B53AB0B8AD0AD02DBBBCF4F3D4B(var_0, var_1, var_2) {
  _encstr_BA5F1137E893D2ADB20BD163DBB1851D2DF637(var_0, var_1, var_2, 3);
}

vehicle_spawn_cp_gamemodesupportsabandonedtimeout(var_0, var_1, var_2) {
  _encstr_BA5F1137E893D2ADB20BD163DBB1851D2DF637(var_0, var_1, var_2, 1);
}

_encstr_BA5F1137E893D2ADB20BD163DBB1851D2DF637(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4.angles = var_1;
  var_4.pers = [];
  var_4.team = "_encstr_A7A408B9CA5D1D4E2C63";
  var_4.defaultoperatorteam = "_encstr_A7A408B9CA5D1D4E2C63";
  var_4.classname = "_encstr_BD4E0B7B104D6AD4DB384717A0";
  var_5 = var_4 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_9B7310AFD59D7A46303148D96B5882726203", var_4);
  var_5.owner = var_4;
  var_5._id_13923 = var_3;
  var_5.radius = var_2;
  var_6 = spawnStruct();
  var_6.location = var_0;
  var_6.angles = var_1;
  var_6.string = "_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773";
  var_4 thread _id_1384D(var_6, var_5);
}

_id_14587(var_0) {
  if(_encstr_ADA92F8703C2106F837BA0903396AC185D9D012BB8EF3818F343A63B4B8BD18076F59D9B5E1311F46B2A3BE0F2621C188E::_encstr_83200F6F2FF4E3A5207875FEF130E11BDD()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_977B1E4A3969CDC88E3B79C11DF03BE6B708A16FE15FFD9874156704D17131D8");

    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  if(sequence_interaction_activate() && vehicle_showvalidlittlebirds()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_93681D2129FAA6A293113D8AA05E513DD41424FAAA9C1465289226280913A2");

    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  server_triggered(var_0);
  return 1;
}

_id_14582(var_0, var_1, var_2) {
  var_3 = 2.1;
  var_4 = scripts\engine\utility::waittill_any_ents_or_timeout_return(var_3, level, "_encstr_B2B50D50ABA5D2DD3F8E7B2B17484B");

  if(!isDefined(var_4)) {
    var_0.failed = 1;
    return undefined;
  } else if(var_4 == "_encstr_B2B50D50ABA5D2DD3F8E7B2B17484B") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_977B1E4A3969CDC88E3B79C11DF03BE6B708A16FE15FFD9874156704D17131D8");

    var_0.failed = 1;
    return undefined;
  }

  var_5 = seq3_warning_room_c(var_0);
  var_6 = 1;

  if(isDefined(var_0._id_13923))
    var_6 = var_0._id_13923;
  else if(isDefined(self._id_1300B) && self._id_1300B != 0)
    var_6 = self._id_1300B;

  var_0._id_13923 = var_6;

  if(var_0._id_13923 == 2 && sequence_interaction_activate()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_955820AEC2EF3C130DE0D111A80D5F97FFBD2036695FA6CBE59811B140FD8B6D7325");

    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    var_0.failed = 1;
    return undefined;
  } else if(var_0._id_13923 == 1 && vehicle_showvalidlittlebirds()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A5F91F4892D76AA89C889E8A28CB6915727A9A900ABEAA728295054A31A0908954");

    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    var_0.failed = 1;
    return undefined;
  }

  if(!isDefined(var_5) || !istrue(var_5.success)) {
    if(isDefined(var_5) && !istrue(var_5.success) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")) {
      if(var_5.string == "_encstr_8E1904BF7881")
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_88A31A942F6BE4DA0996F50737672E37C17BFE24BC3FE91B680FA831");
      else if(var_5.string == "_encstr_B2B50D50ABA5D2DD3F8E7B2B17484B")
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_977B1E4A3969CDC88E3B79C11DF03BE6B708A16FE15FFD9874156704D17131D8");
    }

    var_0.failed = 1;
    return undefined;
  }

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888");

    var_0.failed = 1;
    return undefined;
  }

  var_7 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](self, var_0.streakname);
    var_7 = 2.0;
  }

  return var_5;
}

seq3_warning_room_c(var_0, var_1, var_2) {
  scripts\common\utility::allow_weapon_switch(0);
  self setsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
  var_3 = _id_125C2();

  if(!isDefined(var_3) || !istrue(var_3.success)) {
    scripts\common\utility::allow_weapon_switch(1);
    self clearsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
    return var_3;
  }

  scripts\common\utility::allow_weapon_switch(1);
  self clearsoundsubmix("_encstr_83E6165B437132C0FC8DF32B32DDC87A295715C3D3EA8F98");
  return var_3;
}

_encstr_ADE82091A35103B58BABFF63DBA4AB45292D49FB7BF05ACAE7ED96B7DF231DC725F7() {
  level endon("_encstr_B2B50D50ABA5D2DD3F8E7B2B17484B");
  var_0 = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773", "_encstr_91A21017B155D07573493840921FB5C8AD06", "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  return var_0;
}

_id_125C2() {
  self setclientomnvar("_encstr_B89A13BA4BBE4CE4BEDC347B77FA8E0BB17DDA1638", 1);
  self beginlocationselection(0, 0, 0, 0, 4);
  thread _encstr_A94B1E076358BC959336DE36CDCAC656B11DACDC8C3B0B6B561BD8952CCD5D38();
  var_0 = _encstr_ADE82091A35103B58BABFF63DBA4AB45292D49FB7BF05ACAE7ED96B7DF231DC725F7();
  self notify("_encstr_91341FD94E2BB29B2658F2BECDE8932DDA2BEBCD958D568D3A4BBDB97D91DE372B");

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.string = "_encstr_B2B50D50ABA5D2DD3F8E7B2B17484B";
  }

  var_0.success = 0;
  self endlocationselection();

  if(isDefined(var_0) && var_0.string == "_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773") {
    if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_0.location, 1)) {
      var_1 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13C34(var_0.location);
      var_2 = var_1["_encstr_BD260953AA97E3F014279D"];

      if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_2, 1))
        var_0.success = 1;
      else
        var_0.string = "_encstr_8E1904BF7881";
    } else
      var_0.string = "_encstr_8E1904BF7881";
  }

  self setclientomnvar("_encstr_B89A13BA4BBE4CE4BEDC347B77FA8E0BB17DDA1638", 0);
  return var_0;
}

_encstr_A94B1E076358BC959336DE36CDCAC656B11DACDC8C3B0B6B561BD8952CCD5D38() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_91341FD94E2BB29B2658F2BECDE8932DDA2BEBCD958D568D3A4BBDB97D91DE372B");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endlocationselection();
  var_0 setclientomnvar("_encstr_B89A13BA4BBE4CE4BEDC347B77FA8E0BB17DDA1638", 0);
}

server_triggered(var_0) {
  scripts\mp\killstreaks\mapselect::startmapselectsequence(0, 0, 0);
}

_id_1384D(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = 1;

  if(isDefined(var_1._id_13923))
    var_2 = var_1._id_13923;

  var_1.player = self;
  var_1.starttime = gettime();

  if(var_2 == 2)
    thread seq3_tvnums_str(var_0, var_1);
  else if(var_2 == 3)
    thread _encstr_B88F199953E7DD18FE01ABB73CA278928FF9D1639B4F06F8121993(var_0, var_1);
  else
    thread vehicle_showteamtanks(var_0, var_1);

  if(isPlayer(self))
    self._encstr_A9D30FC3578B8CD01BBA3CF781EB6B5985 = var_2;

  var_1 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  scripts\cp\vehicles\vehicle_compass_cp::_id_12004("_encstr_B2261135B5A107BBD5A03389A8B84BFFD07FE2");
  thread server_unlocked(var_1);
}

seq3_tvnums_str(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8B0214794ED7F8E3BEFB6E96282B3BA75788B7A90F5A");
  _encstr_84B928CE93CACA378958E5E6E8392D5BB27D8DC6CAB0B9AB0EA59B3AAC39E45D07E856196ED19CB2C26D();

  if(isPlayer(self))
    sequence_progression(1);

  var_1._id_134E3 = _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::sandbox_combat_area();
  _encstr_A9F11BECC9ACACCD13C2F2CDD14E2DD6CA7DB9B24757E01DB0C99DB2D1(var_0, var_1);
  var_2 = var_0.location;
  _encstr_8D1E1C625BA58F8530EB494BA9D80CCFDD96BABB010F03BF90D35A2B93E0(var_2);
  _encstr_82F621FFAE3907154D88EB43C8850CE7918050624DE35F5A7B9BC34B78FBC4A728F4C7(var_1, var_0);
  _encstr_8B7C1A0C533F050D45D7D90BC07BF7B805FF8D8F10E32F113A61F0CD(var_1);
  var_3 = var_2 - var_1._id_134E3;
  var_3 = vectorNormalize((var_3[0], var_3[1], 0));
  var_4 = -1 * var_3;
  var_5 = getdvarint("_encstr_825614CD1BC97D139C7D6B3C83EB76FA632B73763AD0", 8000);
  var_1.startorigin = var_2 + var_4 * var_5 / 2;
  var_1.endorigin = var_2 + var_3 * var_5 / 2;
  var_1.dir = vectorNormalize(var_1.endorigin - var_1.startorigin);
  var_6 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::semtex_used();
  var_1._encstr_9AF912735B9F2EB0D77ADF139EFFA0F667C28858 = _encstr_A514106A024BFBB2E9D0470B98039723C92D(var_1.startorigin, var_6);
  var_1._encstr_84FF0E709558EBDFCD6BBA02D31603E7 = _encstr_A3D7186BC25BB21C4E959DB495DD4BB60E0BB18ED8D2931B1B2B(var_1.startorigin, var_1.origin, var_1.endorigin, var_3, var_1.change_keypad_display_digit, var_5);
  var_1.start_area_fx_end = seq3_warning_room_a(var_1.startorigin);

  if(isPlayer(self)) {
    var_1.start_area_fx_end setscriptabledamageowner(self);
    thread scripts\mp\hud_message::showsplash("_encstr_9A8E2489C9BE7658B6ACD1CB38CAAF5B2BDC46DE8E16D7EC9C56ACDC4C58CBD7DC474EAC58B6");
  }

  _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::set_number_of_subway_cars_on_track(var_1);
}

_encstr_B88F199953E7DD18FE01ABB73CA278928FF9D1639B4F06F8121993(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8B0214794ED7F8E3BEFB6E96282B3BA75788B7A90F5A");
  _encstr_84B928CE93CACA378958E5E6E8392D5BB27D8DC6CAB0B9AB0EA59B3AAC39E45D07E856196ED19CB2C26D();
  var_1._id_134E3 = _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::sandbox_combat_area();
  _encstr_8C85201756C1FFFDA550C37BE0DD748FB9A8999CEDE93F446D78CBB110DBEB4F70AD(var_0, var_1);
  var_2 = _encstr_A9F11BECC9ACACCD13C2F2CDD14E2DD6CA7DB9B24757E01DB0C99DB2D1(var_0, var_1);

  if(var_2)
    _encstr_8C85201756C1FFFDA550C37BE0DD748FB9A8999CEDE93F446D78CBB110DBEB4F70AD(var_0, var_1);

  var_3 = var_0.location;
  _encstr_8D1E1C625BA58F8530EB494BA9D80CCFDD96BABB010F03BF90D35A2B93E0(var_3);
  _encstr_82F621FFAE3907154D88EB43C8850CE7918050624DE35F5A7B9BC34B78FBC4A728F4C7(var_1, var_0);
  _encstr_8B7C1A0C533F050D45D7D90BC07BF7B805FF8D8F10E32F113A61F0CD(var_1);
  var_1.start_area_fx_end = seq3_warning_room_a(var_1.startorigin);
  _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::set_number_of_subway_cars_on_track(var_1);
}

_encstr_8C85201756C1FFFDA550C37BE0DD748FB9A8999CEDE93F446D78CBB110DBEB4F70AD(var_0, var_1) {
  var_2 = vectorNormalize(var_0.location - var_1._id_134E3);
  var_3 = getdvarint("_encstr_9BF1187FA8FBE79A256895C8E757825F803093A7E8502FA35B13", 200000);
  var_4 = var_1._id_134E3;
  var_5 = var_1._id_134E3 + var_2 * var_3;
  var_6 = scripts\engine\trace::ray_trace(var_4, var_5, undefined, scripts\engine\trace::create_world_contents());
  _encstr_A2051D58433FA3A0FB19C33EE4538867E7397068BA56C999EF0E4438DA47F2(var_0, var_1, var_6, var_2);
}

_encstr_A2051D58433FA3A0FB19C33EE4538867E7397068BA56C999EF0E4438DA47F2(var_0, var_1, var_2, var_3) {
  var_4 = var_2["_encstr_BD260953AA97E3F014279D"];
  var_0.location = var_4;
  var_1.startorigin = var_4;
  var_1.endorigin = var_4;
  var_1.dir = var_3;

  if(var_2["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
    var_1._encstr_9AF912735B9F2EB0D77ADF139EFFA0F667C28858 = var_4;
    var_1._encstr_B8CB12DFF9BF2B7C38B32DB328F8BE328E731F3B = var_2["_encstr_820E07FAE8780B3A4C"];
  } else {
    var_1._encstr_9AF912735B9F2EB0D77ADF139EFFA0F667C28858 = undefined;
    var_1._encstr_B8CB12DFF9BF2B7C38B32DB328F8BE328E731F3B = undefined;
  }
}

_encstr_84B928CE93CACA378958E5E6E8392D5BB27D8DC6CAB0B9AB0EA59B3AAC39E45D07E856196ED19CB2C26D() {
  if(!isDefined(level._id_11E18.setincomingremovedcallback.vo_one_remain)) {
    return;
  }
  var_0 = level._id_11E18.setincomingremovedcallback.vo_one_remain;
  level._id_11E18.setincomingremovedcallback.vo_one_remain = undefined;
  _encstr_AB8426D9E4ACACE64C16E5B91D9CA5D6CAFA1BB156B073D58307392B3B4B59BBCA9BE85AA396B2CD(var_0);
}

_encstr_A9F11BECC9ACACCD13C2F2CDD14E2DD6CA7DB9B24757E01DB0C99DB2D1(var_0, var_1) {
  var_2 = var_0.location;
  var_3 = level._id_11E18.setincomingremovedcallback.origin;

  if(_encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::_encstr_82721067B0307712D1BA4C8594D77B29DB48())
    [var_5, var_3] = _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::_encstr_AB5314ECD92B1D73CAF047969B9159F0EDE4A59D4BDC();

  var_6 = distance2d(var_2, var_3);
  var_7 = level.sentry_shouldshoot._encstr_8AE90EB5B4DC8C5ACD4785D1E885B1B6;

  if(var_1._id_13923 == 3)
    var_7 = level.sentry_shouldshoot._encstr_A9E30B72E87D873FFBB5FAE1CB;

  if(var_6 <= var_7) {
    var_8 = _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::sandbox_combat_area(var_3);
    var_9 = var_2 - var_8;
    var_9 = vectorNormalize((var_9[0], var_9[1], 0));
    var_10 = var_8 + var_9 * var_7;
    var_1._id_134E3 = var_8;
    var_0.location = (var_10[0], var_10[1], var_2[2]);

    if(var_1._id_13923 == 3 && isDefined(var_1._encstr_B8CB12DFF9BF2B7C38B32DB328F8BE328E731F3B)) {
      var_11 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::semtex_used();
      var_0.location = _encstr_A514106A024BFBB2E9D0470B98039723C92D(var_0.location, var_11);
    }

    return 1;
  }

  return 0;
}

_encstr_8D1E1C625BA58F8530EB494BA9D80CCFDD96BABB010F03BF90D35A2B93E0(var_0) {
  if(getdvarint("_encstr_96A215D389DE977660476D70F1E1FCFF90E04A4B103D6B", 0) != 1) {
    return;
  }
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057"))
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057")]](99);

  if(!isDefined(var_1)) {
    return;
  }
  server_activate(var_1, "_encstr_B2911B9B980103BBA18EAB56E1CB7A979BAF889B9FB7F3C7CA9DA1C098", self, var_0 + (0, 0, 50));
  level thread _encstr_AD321C3B93AC569B89C2BCCDA3275AB52BAFD02CDC23C6596B5827DA594E(var_1);
}

_encstr_82F621FFAE3907154D88EB43C8850CE7918050624DE35F5A7B9BC34B78FBC4A728F4C7(var_0, var_1) {
  var_0.shots_fired++;
  var_0.origin = var_1.location;

  if(isDefined(var_0.radius))
    var_0.change_keypad_display_digit = var_0.radius;
  else
    var_0.change_keypad_display_digit = level.sentry_shouldshoot._encstr_B1750D0F608BA17A1BEE86FF5B1333;
}

_encstr_8B7C1A0C533F050D45D7D90BC07BF7B805FF8D8F10E32F113A61F0CD(var_0) {
  var_1 = "_encstr_B472124FF2275040FB7A4A59429B0538FE737DB9" + var_0._id_134E3[0] + "_encstr_974C0246" + var_0._id_134E3[1] + "_encstr_974C0246" + var_0._id_134E3[2] + "_encstr_974C0246" + var_0.origin[0] + "_encstr_974C0246" + var_0.origin[1] + "_encstr_974C0246" + var_0.origin[2];
  logprint(var_1);
}

seq3_warning_room_a(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_1 setModel("_encstr_8537133F27195C609DA7C8414E59D1839293A3B753");
  var_1 unmarkkeyframedmover(1);
  return var_1;
}

server_structs(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  sequence_progression(0);
  _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::_encstr_BE810F17A040F4224BA9BD728D259AB988();
  var_0.circleent = _id_11A9F(var_0.startorigin, var_0.change_keypad_display_digit, 0, 2);
  var_1 = _encstr_9A251DCE935656CD982C97DC3AE4D2ADCABE762B8E0B8EE85836DA3AA5B656(var_0);
  var_0.start_area_fx_end setscriptablepartstate("_encstr_9A1F0539BDB747", "_encstr_A18008BD35E222F01BD0");
  var_0.start_area_fx_end setscriptablepartstate("_encstr_816E079685517D0975", "_encstr_AB0703DBB9");
  var_0.circleent moveTo((var_0.endorigin[0], var_0.endorigin[1], var_0.change_keypad_display_digit), var_1, 0.1, 0.1);
  var_2 = var_0.owner;

  if(!isPlayer(var_2))
    var_2 = level._id_11E18.setincomingremovedcallback;
  else
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B1C70E5CAF777B11A63250E94BFAFBB1", var_2);

  var_3 = _encstr_979B1EDF5D90E77BF6E143EB6BD65FDC389F532F8DC02C332519DAA373A7BF94(var_0, var_1, var_2);
  var_0.start_area_fx_end setscriptablepartstate("_encstr_B2BE0788BAF573592F", "_encstr_B419059BD17BE0");
  var_0.start_area_fx_end setscriptablepartstate("_encstr_9A1F0539BDB747", "_encstr_921D09D9D9C0090D7275B4");
  _encstr_AB8426D9E4ACACE64C16E5B91D9CA5D6CAFA1BB156B073D58307392B3B4B59BBCA9BE85AA396B2CD(var_0, 1);
  thread kiosk_spent_total(var_0.circleent, 1);

  if(isDefined(var_2) && isPlayer(var_2)) {
    var_2 notify("_encstr_A33D19D4FA32AB903AD780B9F7446BCBBAA740EC945A7BFBE8FF70");
    var_2 scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
  }

  return var_3;
}

_encstr_86FB1E9DC9565973890BCBCD3A9CD25B56F53BCAE89158B50BB32BCD47C2A359(var_0) {
  if(var_0.change_keypad_display_digit == level.sentry_shouldshoot._encstr_B1750D0F608BA17A1BEE86FF5B1333)
    return "_encstr_B61F0C73A008A641179827BEBFCD";
  else
    return "_encstr_B82F0C06A3AA5D3BEF67C89023E4";
}

_encstr_979B1EDF5D90E77BF6E143EB6BD65FDC389F532F8DC02C332519DAA373A7BF94(var_0, var_1, var_2) {
  level._id_11E18.setincomingremovedcallback endon("_encstr_B1920ED9AD7D469CA5D9CA9BD7F69999");
  var_3 = _encstr_86FB1E9DC9565973890BCBCD3A9CD25B56F53BCAE89158B50BB32BCD47C2A359(var_0);
  var_4 = 256;
  var_5 = 128;
  var_6 = 30;

  if(isDefined(var_0._id_13923) && var_0._id_13923 == 3)
    var_0 thread _encstr_830B1A47D3B0FD72BE4B67F39B5EBA0FD83B7ECBC860815B864B43CB(var_4, var_0._encstr_9AF912735B9F2EB0D77ADF139EFFA0F667C28858, var_0._encstr_B8CB12DFF9BF2B7C38B32DB328F8BE328E731F3B, var_5, var_2, var_6);

  var_7 = gettime() + var_1 * 1000;

  while(gettime() < var_7) {
    [var_9, var_10] = _encstr_A1C91CE79198566213C1BFD3DBB51A92E8FA9EEC08B0E1BAE78FBFD32766(var_0);
    _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::set_maze_ai_state(var_10);
    var_0.start_area_fx_end.origin = var_10;
    var_11 = _encstr_B8171047D56B029B6F3B4BD1E520935772C9(var_10);

    if(isDefined(var_11)) {
      var_12 = vectorcross(var_11, (1, 0, 0));
      var_13 = vectortoangles(var_12);
      var_0.start_area_fx_end.angles = var_13;
    }

    var_0.start_area_fx_end setscriptablepartstate("_encstr_B2BE0788BAF573592F", var_3);
    var_0 seq3_sequence(var_4, var_10, var_0.start_area_fx_end.angles, var_5, 0, var_2, var_6);
    var_0 _encstr_B12B1E809BE70B0843B16B669C3BD0DF4FD190D0C37DBBE337CAFD576D9FD99B(var_10, var_2);
    waitframe();

    if(isDefined(var_0._encstr_9AF912735B9F2EB0D77ADF139EFFA0F667C28858))
      var_0._encstr_B10D15079CACEC4BB7BA9BECC97BD5B919B7C9A53B2D9B = var_9;
  }

  return 1;
}

_encstr_B12B1E809BE70B0843B16B669C3BD0DF4FD190D0C37DBBE337CAFD576D9FD99B(var_0, var_1) {
  if(!isDefined(self._encstr_A57E10EDC5893BECA91007538081D5D21F6D))
    self._encstr_A57E10EDC5893BECA91007538081D5D21F6D = gettime();

  if(self._encstr_A57E10EDC5893BECA91007538081D5D21F6D <= gettime()) {
    _encstr_A6AE1B0408E707A07883E13B2CBD5802635135B19BF5925D4AF11704E5(var_0, var_1);
    self._encstr_A57E10EDC5893BECA91007538081D5D21F6D = gettime() + getdvarfloat("_encstr_B1771D0FD88B97EA357885F8D747724F9020F7DFC8E5E1426B0C8F7F3EEB2B", 0.125) * 1000;
  }
}

_encstr_A6AE1B0408E707A07883E13B2CBD5802635135B19BF5925D4AF11704E5(var_0, var_1) {
  var_2 = self.change_keypad_display_digit;
  var_3 = 1000;
  isaltbunkerscriptable(var_0, var_2, var_3, var_1, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", getcompleteweaponname("_encstr_9B7310AFD59D7A46303148D96B5882726203"), level._id_11E18.setincomingremovedcallback.clear_look_at_ent.origin, 1);
}

_encstr_9A251DCE935656CD982C97DC3AE4D2ADCABE762B8E0B8EE85836DA3AA5B656(var_0) {
  if(var_0._id_13923 == 3)
    return getdvarfloat("_encstr_840E166EC639BE1393D7DAF01C7DCEBE3AD25B95FA39C2BC", 6);

  return getdvarfloat("_encstr_81141262435ADFFB3A01DF3AB309986FB84C7777", 6);
}

_encstr_AB8426D9E4ACACE64C16E5B91D9CA5D6CAFA1BB156B073D58307392B3B4B59BBCA9BE85AA396B2CD(var_0, var_1) {
  if(isDefined(var_0._encstr_84FF0E709558EBDFCD6BBA02D31603E7))
    var_0._encstr_84FF0E709558EBDFCD6BBA02D31603E7 delete();

  thread kiosk_spent_total(var_0.start_area_fx_end, var_1);
}

_encstr_A1C91CE79198566213C1BFD3DBB51A92E8FA9EEC08B0E1BAE78FBFD32766(var_0) {
  var_1 = distance2d(var_0.startorigin, var_0.circleent.origin);
  var_2 = var_0.startorigin + var_0.dir * var_1;

  if(var_0._id_13923 == 2) {
    if(isDefined(var_0._encstr_B10D15079CACEC4BB7BA9BECC97BD5B919B7C9A53B2D9B))
      var_2 = var_2 + (0, 0, var_0._encstr_B10D15079CACEC4BB7BA9BECC97BD5B919B7C9A53B2D9B[2]);
    else if(isDefined(var_0._encstr_9AF912735B9F2EB0D77ADF139EFFA0F667C28858))
      var_2 = var_2 + (0, 0, var_0._encstr_9AF912735B9F2EB0D77ADF139EFFA0F667C28858[2]);
  }

  var_3 = var_2;
  var_4 = var_2;

  if(var_0._id_13923 == 2) {
    var_3 = _encstr_A514106A024BFBB2E9D0470B98039723C92D(var_2, getdvarint("_encstr_99FA1A6E36C9D7139C7DDA871CBEECBE31CA0B5BF5D3AF8EE42C1B56", 2500));
    var_4 = _encstr_A27C141AF00BCBB1F8B02357687367F2E3146517E6A1(var_3);

    if(istrue(level.sentry_shouldshoot._encstr_8BCA0C34F3A88C1978EDFD392373))
      var_4 = _encstr_8BCA0C34F3A88C1978EDFD392373(var_4, var_0._encstr_B10D15079CACEC4BB7BA9BECC97BD5B919B7C9A53B2D9B, level.sentry_shouldshoot._encstr_967E0AA00EC0E5111D384302);

    var_4 = _encstr_863B0EAFFFBAF8F0300648C06AEF10AA(var_0, var_4);
  }

  if(!isDefined(var_0._encstr_99D308C1FCD9509603E8)) {
    var_0._encstr_99D308C1FCD9509603E8 = [];
    var_0._encstr_BD580B02489B66A79917495423 = [];
  }

  var_0._encstr_99D308C1FCD9509603E8[var_0._encstr_99D308C1FCD9509603E8.size] = var_4;
  var_0._encstr_BD580B02489B66A79917495423[var_0._encstr_BD580B02489B66A79917495423.size] = var_3;
  return [var_3, var_4];
}

_encstr_B8171047D56B029B6F3B4BD1E520935772C9(var_0) {
  var_1 = scripts\engine\trace::create_contents(0, 1);
  var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifytriggerlocation(var_0, 100, -200, var_1);
  return var_2["_encstr_820E07FAE8780B3A4C"];
}

_encstr_A514106A024BFBB2E9D0470B98039723C92D(var_0, var_1) {
  var_2 = scripts\engine\trace::create_contents(0, 1);
  var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_0, var_1, undefined, var_2);
  return var_3;
}

_encstr_A27C141AF00BCBB1F8B02357687367F2E3146517E6A1(var_0) {
  if(isscriptabledefined()) {
    var_1 = getclosestpointonnavmesh(var_0);
    var_2 = distance2d(var_0, var_1);

    if(var_2 < getdvarint("_encstr_8217206E6C4EAF8939D7AD3CC1F5D9EB982B85B5BEF0BCAFE6C29DBEB76633CD5947", 500)) {
      var_3 = var_1[2] - var_0[2];

      if(var_3 < getdvarint("_encstr_83491FDC6CE4FAC493D7B6C31CEBCEF598950B5BAF3DF5CD58CEAFBD6633B9598E", 1000))
        var_0 = (var_0[0], var_0[1], var_1[2]);
    }
  }

  return var_0;
}

_encstr_8BCA0C34F3A88C1978EDFD392373(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    return var_0;

  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = var_0[2] - var_1[2];

  if(abs(var_3) > var_2) {
    if(!isDefined(level._id_11E18._encstr_AAF50EDBB06BF017C3F350454020C359) || level._id_11E18._encstr_AAF50EDBB06BF017C3F350454020C359 < abs(var_3))
      level._id_11E18._encstr_AAF50EDBB06BF017C3F350454020C359 = var_3;

    var_4 = scripts\engine\utility::sign(var_3);
    return var_1 + (0, 0, var_4 * var_2);
  }

  return var_0;
}

_encstr_863B0EAFFFBAF8F0300648C06AEF10AA(var_0, var_1) {
  var_2 = 0.5;

  if(isDefined(var_0._encstr_99D308C1FCD9509603E8)) {
    var_3 = var_0._encstr_99D308C1FCD9509603E8[var_0._encstr_99D308C1FCD9509603E8.size - 1];
    var_4 = var_1[2] - var_3[2];
    var_5 = var_4 * getdvarfloat("_encstr_ACE71B1AE2B329808EC1207A182752B7C2D58F3F1F7841431AEDAD018C", var_2);
    var_1 = (var_1[0], var_1[1], var_3[2] + var_5);
  }

  return var_1;
}

kiosk_spent_total(var_0, var_1) {
  if(isDefined(var_1) && var_1 > 0)
    wait(var_1);

  var_0 delete();
}

isaltbunkerscriptable(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!istrue(var_7))
    radiusdamage(var_0, var_1, var_2, var_2, var_3, var_4, var_5, 0, 1, 1);

  if(getdvarint("_encstr_99D81B73C790D18336FECAA32398D31630AB1FED2718E7735391D27A2B", 1)) {
    var_8 = tablesort(var_0 + (0, 0, -100), var_1, 400);

    foreach(var_10 in var_8) {
      if(isalive(var_10) && var_10.health > 1)
        var_10 dodamage(var_10.health, var_6, var_3, var_3, var_4, var_5);
    }
  }

  var_12 = float(var_1 * var_1);

  if(isDefined(level.cratedata) && isDefined(level.cratedata.crates)) {
    foreach(var_14 in level.cratedata.crates) {
      if(isDefined(var_14)) {
        var_15 = distance2dsquared(var_14.origin, var_0);

        if(var_15 < var_12) {
          if(isDefined(var_14.trial_flares))
            var_14 thread _encstr_87BD2DF34710DC4BB5FB6E72A3205F96B0238C71F92BE2EE563361DAE9696F0BF8B115CF6BF86D8B88EB9A5631BEBF::train_get_anim_ents_index();
          else
            var_14 thread destroycrate();
        }
      }
    }
  }

  if(istrue(var_7)) {
    var_17 = scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0);
    var_18 = scripts\engine\trace::ray_trace(var_6, var_0, [var_3], var_17);

    if(isDefined(var_18["_encstr_850E077B0BF30318B9"])) {
      var_19 = var_18["_encstr_850E077B0BF30318B9"];

      if(isalive(var_19) && (isPlayer(var_19) || var_19 nuke_vault_suicidebombers()))
        var_19 dodamage(var_2, var_6, var_3, var_3, var_4, var_5);
    }
  }
}

destroycrate() {
  if(isDefined(self.molotov_delete_oldest_trigger))
    self.molotov_delete_oldest_trigger delete();

  playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], self.origin);
  scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

seq3_gate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  seq3_cypher_tagorigin(var_1, var_2, var_6);
  seq3_puzzle_attempts(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

seq3_cypher_tagorigin(var_0, var_1, var_2) {
  var_3 = spawnfx(scripts\engine\utility::getfx("_encstr_AF8C1799EA1D5048A20F6327077A8FC8B3C30670544E08F57B"), var_0, anglesToForward(var_1), anglestoup(var_1));
  thread seq3_crate_usable(var_3, var_2);
  return var_3;
}

seq3_crate_usable(var_0, var_1) {
  triggerfx(var_0);
  wait(var_1);
  var_0 delete();
}

seq3_puzzle_attempts(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = seq3_keypad_init(var_0, var_1, var_2, var_3, var_4, var_5);
  var_7 thread seq3_reset_switch();
  var_7 thread seq3_russian_cypher_str();
  var_7 thread seq3_puzzle_complete(var_6);
  return var_7;
}

seq3_keypad_init(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_5))
    var_5 = level._id_11E18.setincomingremovedcallback;

  var_6 = var_1 - anglestoup(var_2) * var_4;
  var_7 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_6, 0, var_0, var_3);
  var_7.angles = var_2;
  var_7.count = 0;
  var_7.attacker = var_5;
  var_7.inflictor = var_5;
  var_7 hide();
  var_7 seq3_numbers_array();
  return var_7;
}

seq3_reset_switch() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0) || !isalive(var_0)) {
      continue;
    }
    server_interact_used_think(var_0);
    var_0 seq3_has_seen_tiers(self.attacker, self.inflictor, self.killcament, self);
  }
}

seq3_russian_cypher_str() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(self.count > 0) {
      foreach(var_1 in level.sentry_shouldshoot.playersintrigger) {
        if(!isDefined(var_1)) {
          continue;
        }
        if(!isPlayer(var_1) || !isalive(var_1)) {
          continue;
        }
        if(var_1 istouching(self)) {
          continue;
        }
        server_rack_clip(var_1);
        var_1 seq3_keyboards(self);
      }
    }

    waitframe();
  }
}

seq3_puzzle_complete(var_0) {
  seq3_cleanup_leftovers(var_0);

  foreach(var_2 in level.sentry_shouldshoot.playersintrigger) {
    if(isDefined(var_2))
      server_rack_clip(var_2);
  }

  thread seq3_monitor_2_spawned();
}

seq3_has_seen_tiers(var_0, var_1, var_2, var_3) {
  seq3_computersused(var_0, var_1, var_2);
  sentry_trap_structs(var_3);
  thread seq3_sequences();
}

seq3_keyboards(var_0) {
  seq3_emergency_lights(var_0.id);
}

seq3_computersused(var_0, var_1, var_2) {
  if(!isDefined(self.seq3_thermitetank_settings)) {
    var_3 = spawnStruct();
    var_3.timeon = 0;
    var_3.timeoff = 0;
    var_3.timetodamage = 0;
    var_3.updatetimestamp = 0;
    var_3.firstdamagedone = 0;
    var_3.victim = self;
    var_3.sources = [];
    self.seq3_thermitetank_settings = var_3;
  }

  self.seq3_thermitetank_settings.attacker = var_0;
  self.seq3_thermitetank_settings.inflictor = var_1;
  self.seq3_thermitetank_settings.killcament = var_2;
}

seq3_sequences() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88660EE03537E73A3FF39DDA0209EDD0");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_977F0FBA0EC8B0A3CAF589AB27735A379D");
  self endon("_encstr_977F0FBA0EC8B0A3CAF589AB27735A379D");
  thread sentryturret_allowpickupofturret();

  if(gettime() <= self.seq3_thermitetank_settings.updatetimestamp)
    waitframe();

  var_0 = undefined;

  for(;;) {
    foreach(var_3, var_2 in self.seq3_thermitetank_settings.sources) {
      if(isDefined(var_2) && var_2 seq3_elevator_init(self)) {
        if(!isDefined(var_0) || var_2.id > var_0.id)
          var_0 = var_2;

        continue;
      }

      seq3_emergency_lights(var_3);
    }

    var_4 = seq3_spawners_intro(self);

    switch (var_4) {
      case "_encstr_B2BE0788BAF573592F":
        seq3_sequences_correct(self, var_0);
        break;
      case "_encstr_8E95062EE46DB683":
        thread seq3_computer_interaction();
        break;
      case "_encstr_8DDE08CDF61D434BB9B3":
      default:
        break;
    }

    wait 0.05;
  }
}

seq3_spawners_intro(var_0) {
  var_1 = "_encstr_8DDE08CDF61D434BB9B3";

  if(!isDefined(var_0.seq3_thermitetank_settings))
    return var_1;

  if(var_0.seq3_thermitetank_settings.timetodamage <= 0) {
    var_1 = "_encstr_B2BE0788BAF573592F";
    var_0.seq3_thermitetank_settings.timetodamage = 0.25;
  } else
    var_0.seq3_thermitetank_settings.timetodamage = var_0.seq3_thermitetank_settings.timetodamage - 0.05;

  if(sequence_interaction_hint(var_0)) {
    var_0.seq3_thermitetank_settings.timeoff = 0;
    var_0.seq3_thermitetank_settings.timeon = var_0.seq3_thermitetank_settings.timeon + 0.05;
  } else {
    var_0.seq3_thermitetank_settings.timeoff = var_0.seq3_thermitetank_settings.timeoff + 0.05;

    if(var_0.seq3_thermitetank_settings.timeoff >= 0.25)
      var_1 = "_encstr_8E95062EE46DB683";
  }

  var_0.seq3_thermitetank_settings.updatetimestamp = gettime();
  return var_1;
}

seq3_sequences_correct(var_0, var_1) {
  if(!isDefined(var_0.seq3_thermitetank_settings) || !isDefined(var_1)) {
    return;
  }
  var_2 = 25;
  var_3 = var_1.attacker.origin;
  var_4 = var_1.attacker;
  var_5 = var_1.attacker;
  var_0 dodamage(var_2, var_3, var_4, var_5, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", getcompleteweaponname("_encstr_9B7310AFD59D7A46303148D96B5882726203"));

  if(!istrue(var_0.seq3_thermitetank_settings.firstdamagedone))
    playfxontagforclients(scripts\engine\utility::getfx("_encstr_BE9917EFEB729558526E12AE1435E0DF4A5B27490BDA63D87A"), var_0, "_encstr_A130084D2FDAD8AA8F62", var_0);

  var_0.seq3_thermitetank_settings.firstdamagedone = 1;
}

seq3_elevator_init(var_0) {
  if(!sequence_interaction_hint(var_0))
    return 0;

  if(!isDefined(var_0.seq3_thermitetank_settings.sources[self.id]))
    return 0;

  return 1;
}

sentryturret_allowpickupofturret() {
  self notify("_encstr_BAAE104FC1C0D6FE1BC77958AB6873A30E59");
  self endon("_encstr_BAAE104FC1C0D6FE1BC77958AB6873A30E59");
  childthread sentryturret_canpickup();
  childthread sentryturret_watchgameend();
}

sentryturret_canpickup() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88660EE03537E73A3FF39DDA0209EDD0");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  thread seq3_computer_interaction();
}

sentryturret_watchgameend() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88660EE03537E73A3FF39DDA0209EDD0");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread seq3_computer_interaction();
}

seq3_cleanup_leftovers(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);
}

seq3_computer_interaction() {
  self notify("_encstr_88660EE03537E73A3FF39DDA0209EDD0");

  if(isDefined(self.seq3_thermitetank_settings) && isDefined(self.seq3_thermitetank_settings.sources)) {
    foreach(var_1 in self.seq3_thermitetank_settings.sources)
    seq3_emergency_lights(var_1.id);
  }

  stopfxontagforclients(scripts\engine\utility::getfx("_encstr_BE9917EFEB729558526E12AE1435E0DF4A5B27490BDA63D87A"), self, "_encstr_A130084D2FDAD8AA8F62", self);
  self.seq3_thermitetank_settings = undefined;
}

sentry_trap_structs(var_0) {
  if(!isDefined(self.seq3_thermitetank_settings)) {
    return;
  }
  self.seq3_thermitetank_settings.sources[var_0.id] = var_0;
}

seq3_emergency_lights(var_0) {
  if(!isDefined(self.seq3_thermitetank_settings)) {
    return;
  }
  self.seq3_thermitetank_settings.sources[var_0] = undefined;
}

seq3_digits_display_array() {
  if(!isDefined(self.seq3_thermitetank_settings))
    return 0;

  return self.seq3_thermitetank_settings.sources.size;
}

seq3_displaymodels(var_0) {
  return seq3_digits_display_array() == 1 && isDefined(self.seq3_thermitetank_settings.sources[var_0.id]);
}

seq3_numbers_array() {
  self.id = seq3_warning_tier();
  self.stab_blink_black_fade = seq3_warning_room_b();
  seq3_tier(self);
}

seq3_monitor_2_spawned() {
  sequence_interaction_init(self);
  self delete();
}

seq3_sequence(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self._id_13923 != 2) {
    return;
  }
  if(!isDefined(self._encstr_8ED210385F028B78698E1B4AFD2B832B162D))
    self._encstr_8ED210385F028B78698E1B4AFD2B832B162D = gettime();

  if(!isDefined(self._encstr_B1F9117303FB83B33899733D1393E10ADCAB9B))
    self._encstr_B1F9117303FB83B33899733D1393E10ADCAB9B = gettime();

  if(self._encstr_8ED210385F028B78698E1B4AFD2B832B162D <= gettime()) {
    seq3_cypher_tagorigin(var_1, var_2, var_6);
    self._encstr_8ED210385F028B78698E1B4AFD2B832B162D = gettime() + getdvarfloat("_encstr_9194214B1146FF1E182FF5D8494967B7E64BD3E27F1F8753519DF5D97FF06F8B9D212B", 0.25) * 1000;
  }

  if(self._encstr_B1F9117303FB83B33899733D1393E10ADCAB9B <= gettime()) {
    seq3_puzzle_attempts(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    self._encstr_B1F9117303FB83B33899733D1393E10ADCAB9B = gettime() + getdvarfloat("_encstr_927922979F6EA132D8AE652823D97FF9CE1B2B6B67976AFC41131F72FE5892521447FF83", 0.25) * 1000;
  }
}

_encstr_830B1A47D3B0FD72BE4B67F39B5EBA0FD83B7ECBC860815B864B43CB(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1) || !isDefined(var_2) || !isDefined(self._encstr_B8CB12DFF9BF2B7C38B32DB328F8BE328E731F3B)) {
    return;
  }
  wait 3.0;
  var_6 = 256;
  var_7 = 60;
  var_8 = 448.0;
  var_9 = anglesToForward(var_2) * var_8;
  seq3_gate(var_0, var_1, var_2, var_3, 0, var_4, var_5);

  for(var_10 = 0; var_10 < 6; var_10++) {
    var_11 = rotatepointaroundvector(self._encstr_B8CB12DFF9BF2B7C38B32DB328F8BE328E731F3B, var_9, var_7 * var_10);
    var_12 = _encstr_A514106A024BFBB2E9D0470B98039723C92D(var_1 + var_11, 250);

    if(!isDefined(var_12)) {
      continue;
    }
    var_13 = _encstr_8BCA0C34F3A88C1978EDFD392373(var_12, var_1, var_6);

    if(var_13[2] != var_12[2]) {
      continue;
    }
    seq3_gate(var_0, var_12, var_2, var_3, 0, var_4, var_5);
  }
}

sequence_progression(var_0) {
  level.sentry_shouldshoot.inuse = var_0;
  _id_13186("_encstr_A74C0277", var_0);
}

sequence_interaction_activate() {
  return level.sentry_shouldshoot.inuse;
}

seq3_warning_room_b() {
  if(!isDefined(level.sentry_shouldshoot.stab_blink_black_fade))
    level.sentry_shouldshoot.stab_blink_black_fade = 0;

  return level.sentry_shouldshoot.stab_blink_black_fade;
}

seq3_wheelson_starts() {
  if(!isDefined(level.sentry_shouldshoot.stab_blink_black_fade))
    level.sentry_shouldshoot.stab_blink_black_fade = 0;
}

seq3_warning_tier() {
  var_0 = level.sentry_shouldshoot._id_13DC5;
  level.sentry_shouldshoot._id_13DC5++;
  return var_0;
}

seq3_tier(var_0) {
  level.sentry_shouldshoot.triggers = scripts\engine\utility::array_add(level.sentry_shouldshoot.triggers, var_0);
}

sequence_interaction_init(var_0) {
  level.sentry_shouldshoot.triggers = scripts\engine\utility::array_remove(level.sentry_shouldshoot.triggers, var_0);
}

server_interact_used_think(var_0) {
  if(seq3_elevator_init(var_0)) {
    return;
  }
  self.count++;
  var_1 = var_0 getentitynumber();
  level.sentry_shouldshoot.playersintrigger[var_1] = var_0;
}

server_rack_clip(var_0) {
  if(!seq3_elevator_init(var_0)) {
    return;
  }
  self.count--;

  if(var_0 seq3_digits_display_array() <= 0) {
    var_1 = var_0 getentitynumber();
    level.sentry_shouldshoot.playersintrigger[var_1] = undefined;
  }
}

sequence_interaction_hint(var_0) {
  if(!isDefined(var_0.seq3_thermitetank_settings))
    return 0;

  return var_0.seq3_thermitetank_settings.sources.size > 0;
}

nuke_vault_suicidebombers() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56");
}

_encstr_A3D7186BC25BB21C4E959DB495DD4BB60E0BB18ED8D2931B1B2B(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_4 * 2.0;
  var_7 = 2 + int(ceil((var_5 - var_6) / var_6));
  var_8 = var_4 + getdvarint("_encstr_A6FF144771E851315B87E0C343FFC9511FC1CB921B23", 500);
  var_9 = var_5 + var_4 + var_4;
  var_10 = vectortoangles(var_3);
  var_11 = float(var_9) / var_4;

  for(var_12 = 0; var_12 < var_7 - 1; var_12++) {
    var_13 = var_0 + var_3 * var_12 * var_6;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7")]](var_13, var_8, "_encstr_9B7310AFD59D7A46303148D96B5882726203", 0);

    thread _encstr_A2611E3C0B122B1BE7C38A1DAEB1CBA8A14BF330CE674D144010BDCA738D95CF(var_13, var_8);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7")]](var_2, var_8, "_encstr_9B7310AFD59D7A46303148D96B5882726203", 0);

  thread _encstr_A2611E3C0B122B1BE7C38A1DAEB1CBA8A14BF330CE674D144010BDCA738D95CF(var_2, var_8);
  var_14 = _id_11A9F(var_1, var_4, 1, 6);
  var_14.angles = (var_11, var_10[1], 0);
  return var_14;
}

_id_11A9F(var_0, var_1, var_2, var_3) {
  var_4 = getmaxobjectivecount(var_0[0], var_0[1], var_1);
  var_4 setmapcirclecolorindex(var_2);
  var_4 setmapcircleiconindex(0);
  var_4 setmapcirclestyleindex(var_3);
  return var_4;
}

vehicle_showteamtanks(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  _encstr_A1FE275B2B73EDB9A1B0CD3AC94B6D2BD7B1635916E6EAC14BDCA3AC27275707D12B8C373A93AC58D6();

  if(isPlayer(self)) {
    vehicle_spawn_abandonedtimeoutcallback(1);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8D2E0E6B993FBD63695FAF5F4B171533", self);
  }

  var_1.shots_fired++;
  var_2 = var_0.location;
  _encstr_87831A22CF724FE3E007E0D0A3093883C9F2AD35A3EB31E9C207A8C8(var_0, var_1);

  if(getdvarint("_encstr_96A215D389DE977660476D70F1E1FCFF90E04A4B103D6B", 0) == 1) {
    var_3 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057"))
      var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057")]](99);

    if(isDefined(var_3)) {
      server_activate(var_3, "_encstr_81C01AEA4BEBB5837D3139EBD0BA8C7D5A8DB79BF5DA59B9DBDC1AC2", self, var_1.origin + (0, 0, 50));
      level thread _encstr_AD321C3B93AC569B89C2BCCDA3275AB52BAFD02CDC23C6596B5827DA594E(var_3);
    }
  }

  var_1._id_134E3 = _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::vehiclespawn_littlebirdmg();
  var_4 = var_2 - var_1._id_134E3;
  var_4 = vectorNormalize((var_4[0], var_4[1], 0));
  var_5 = -1 * var_4;
  var_6 = getdvarint("_encstr_A6FF144771E851315B87E0C343FFC9511FC1CB921B23", 500);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7")]](var_1.origin, var_1.change_fronttruck_label + var_6, "_encstr_B8FF0F509F66E8E77AAE405EC3F31BD0D5", 0);

  thread _encstr_83781A8B0180BE0F5AD83AC2632DEB77309F2B0DA52887177750027A(var_1.origin, var_1.change_fronttruck_label + var_6);
  var_1.startorigin = var_1._id_134E3;
  var_1.endorigin = var_1.origin;
  var_1.start_area_fx_end = _id_11A9F(var_1.endorigin, var_1.change_fronttruck_label, 1, 5);

  if(isPlayer(self))
    thread scripts\mp\hud_message::showsplash("_encstr_AC0823757B4104B0AD9F43FAC28D09495AA3E1E79B4AC0D8FD3528B3EC71D1FE234B6B034F");

  _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::waitfor_firstgroup_killedoffenough(var_1);
}

_encstr_87831A22CF724FE3E007E0D0A3093883C9F2AD35A3EB31E9C207A8C8(var_0, var_1) {
  var_2 = var_0.location;
  var_1.origin = var_2;
  var_1.change_goal_radius_weapons_free_internal = "_encstr_B4AD059D68F0E7";
  var_1.change_fronttruck_label = level.vehicle_shoulddocollisiondamagetoplayer._encstr_B1750D0F608BA17A1BEE86FF5B1333;

  if(isDefined(var_1.radius))
    var_1.change_fronttruck_label = var_1.radius;

  var_3 = level._id_11E18.wait_for_next_hack_complete.origin;

  if(_encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::_encstr_A75B0D22F123D04BFDAB2818D2D313())
    [var_5, var_3] = _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::_encstr_A61E142FB829FC6A5BAB83FC987192A830785F9750E0();
  else {
    [var_7, var_8] = _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::_encstr_ADAE18C390A620B18FA03063B2AB0FDAC89FB2086BAB2A722F63();

    if(var_7)
      var_3 = _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::_encstr_A20F1097F785735958A94708E090919A6B0D(var_8);
  }

  var_9 = distance2d(var_2, var_3);

  if(var_9 <= level.vehicle_shoulddocollisiondamagetoplayer._encstr_B1750D0F608BA17A1BEE86FF5B1333) {
    var_1.origin = var_3;
    var_1.change_fronttruck_label = level.vehicle_shoulddocollisiondamagetoplayer._encstr_B1750D0F608BA17A1BEE86FF5B1333;
    var_1.change_goal_radius_weapons_free_internal = 2;
  } else if(var_9 <= level.vehicle_shoulddocollisiondamagetoplayer._encstr_AC4C092FD011D2B2751CEF)
    var_1.change_goal_radius_weapons_free_internal = 1;
  else
    var_1.change_goal_radius_weapons_free_internal = 0;
}

_encstr_A1FE275B2B73EDB9A1B0CD3AC94B6D2BD7B1635916E6EAC14BDCA3AC27275707D12B8C373A93AC58D6() {
  if(!isDefined(level._id_11E18.wait_for_next_hack_complete.vo_one_remain)) {
    return;
  }
  var_0 = level._id_11E18.wait_for_next_hack_complete.vo_one_remain;
  level._id_11E18.wait_for_next_hack_complete.vo_one_remain = undefined;
  _encstr_B152254723D0129398F912DBF3F8C3CA2047C3F793087B6880A38F2388A0070237F15F0B6B2543(var_0);
}

vehicle_spawn_cancelpendingrespawns(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  vehicle_spawn_abandonedtimeoutcallback(0);
  _encstr_937329180FF2509933B2F0E94ABE8F19458FA8302BBDABEFBA1AC0E72563B740BF23B889E74803B5B242C6::_encstr_B29C0F300AE36508142499DF44BA30BFAF();
  var_1 = level._id_11E18.wait_for_next_hack_complete;

  if(var_0.change_goal_radius_weapons_free_internal == 0 || var_0.change_goal_radius_weapons_free_internal == 1) {
    var_1 setscriptablepartstate("_encstr_816E079685517D0975", "_encstr_8FA906CC80677438", 0);
    var_2 = var_1 gettagorigin("_encstr_83A709A316CEAF6ECB731B");
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
    var_3 setModel("_encstr_BD9B1E63ADD7E4F6D86DAF98BDBA63C8B2C9FAC019EBDA9573B76E1A0BD7B9CC");
    var_0._encstr_8A1F05937B366D = var_3;
    var_3 linkTo(var_1, "_encstr_83A709A316CEAF6ECB731B", (0, 0, 0), (0, 0, 0));
    var_3 dontinterpolate();
    var_3 unmarkkeyframedmover(1);
    level._id_11E18.wait_for_next_hack_complete scripts\engine\utility::waittill_notify_or_timeout("_encstr_B18C13528D53ED17ECEAF9A89282F7DB3F22E8DEEB", 2.25);
    var_0.circleent = _id_11A9F(var_0.startorigin, var_0.change_fronttruck_label, 0, 2);
    var_4 = distance2d(var_0.startorigin, var_0.endorigin);
    [var_6, var_7] = _encstr_B6A01A6BC7081D87B5980A63810EFF965B8110FA47102357D153421B(var_4);
    var_8 = var_4 / var_6;
    var_3 unlink();
    var_9 = -1 * var_7;
    var_10 = trajectorycalculateinitialvelocity(var_3.origin, var_0.origin, (0, 0, var_9), var_8);
    var_3 movegravity(var_10, var_8, var_7);
    var_3 setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_930B07BB1B6B3854FF", 0);
    var_0.circleent moveTo((var_0.endorigin[0], var_0.endorigin[1], var_0.change_fronttruck_label), var_8, 0.1, 0.1);
    wait(var_8);
    var_3 setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_930B07BB1B6B3854FF", 0);
    var_3 thread vehicle_spawn_abandonedtimeout();
  }

  var_11 = var_0.owner;

  if(!isPlayer(var_11))
    var_11 = var_1;

  isaltbunkerscriptable(var_0.origin + (0, 0, 100), var_0.change_fronttruck_label, 1000, var_11, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", getcompleteweaponname("_encstr_B8FF0F509F66E8E77AAE405EC3F31BD0D5"), var_0._id_134E3);
  isaltbunkerscriptable(var_0.origin + (0, 0, 500), var_0.change_fronttruck_label, 1000, var_11, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", getcompleteweaponname("_encstr_B8FF0F509F66E8E77AAE405EC3F31BD0D5"), var_0._id_134E3);
  isaltbunkerscriptable(var_0.origin + (0, 0, 1000), var_0.change_fronttruck_label, 1000, var_11, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", getcompleteweaponname("_encstr_B8FF0F509F66E8E77AAE405EC3F31BD0D5"), var_0._id_134E3);

  if(isDefined(var_11) && isPlayer(var_11)) {
    var_11 notify("_encstr_A33D19D4FA32AB903AD780B9F7446BCBBAA740EC945A7BFBE8FF70");
    var_11 scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
  }

  _encstr_B152254723D0129398F912DBF3F8C3CA2047C3F793087B6880A38F2388A0070237F15F0B6B2543(var_0);

  if(var_0.change_goal_radius_weapons_free_internal == 0 || var_0.change_goal_radius_weapons_free_internal == 1) {
    wait 1;

    if(isDefined(var_0.circleent))
      var_0.circleent delete();

    wait 1.5;

    if(isDefined(var_0._encstr_8A1F05937B366D))
      var_0._encstr_8A1F05937B366D delete();
  }
}

_encstr_B6A01A6BC7081D87B5980A63810EFF965B8110FA47102357D153421B(var_0) {
  var_1 = level.vehicle_shoulddocollisiondamagetoplayer._encstr_8C6C15928873EF7FEB33BD3D29AE5F9A38B7FBFB5037E0;
  var_2 = level.vehicle_shoulddocollisiondamagetoplayer._encstr_858E17D3DDC7A75F2868516684DBCBA1437B01FEEA21A0DF27;

  if(var_0 > level.vehicle_shoulddocollisiondamagetoplayer._encstr_A15C0C015783D18BDA6B58281237) {
    var_1 = level.vehicle_shoulddocollisiondamagetoplayer._encstr_8F3819637DE7B7A1D84B4D07EC595D775B5AAFF39836AAB96B7A02;
    var_2 = level.vehicle_shoulddocollisiondamagetoplayer._encstr_B6E91BA2D02053C19CCDA7C3C33D6BAF80385D6F0908F4996E83938F33;
  } else if(var_0 > level.vehicle_shoulddocollisiondamagetoplayer._encstr_87560A36DE9BEC272CCD9D95) {
    var_1 = level.vehicle_shoulddocollisiondamagetoplayer._encstr_A39318F3AF63AA0F7B91DD216136B0324E18CB05F8403B22773A;
    var_2 = level.vehicle_shoulddocollisiondamagetoplayer._encstr_A5C21AC360CEC27EE21DBA05600B721F24F8D8CF311AE1DAA288D8AD;
  } else if(var_0 > level.vehicle_shoulddocollisiondamagetoplayer._encstr_AC4C092FD011D2B2751CEF) {
    var_1 = level.vehicle_shoulddocollisiondamagetoplayer._encstr_858816B30A77420932982B13B411D8181BE26E3B72EB8C2B;
    var_2 = level.vehicle_shoulddocollisiondamagetoplayer._encstr_9938184E7B8DB5EBD993583BD23AF2EBD8ED37ECAF932CB9B356;
  }

  return [var_1, var_2];
}

_encstr_B152254723D0129398F912DBF3F8C3CA2047C3F793087B6880A38F2388A0070237F15F0B6B2543(var_0) {
  var_0.start_area_fx_end delete();
}

vehicle_spawn_abandonedtimeoutcallback(var_0) {
  level.vehicle_shoulddocollisiondamagetoplayer.inuse = var_0;
  _id_13186("_encstr_A94C02B6", var_0);
}

vehicle_showvalidlittlebirds() {
  return level.vehicle_shoulddocollisiondamagetoplayer.inuse;
}

vehicle_spawn_abandonedtimeout() {
  self endon("_encstr_AD75063D571AE108");
  wait 0.05;
  self setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self hide(1);
}

server_activate(var_0, var_1, var_2, var_3) {
  objective_icon(var_0, var_1);
  objective_showtoplayersinmask(var_0);

  if(isPlayer(var_2))
    objective_addclienttomask(var_0, var_2);

  objective_position(var_0, var_3);
  objective_setplayintro(var_0, 0);
  objective_setplayoutro(var_0, 0);
  objective_setbackground(var_0, 1);

  if(level.teambased || !isPlayer(var_2))
    objective_setownerteam(var_0, var_2.team);
  else
    objective_setownerclient(var_0, var_2);

  objective_state(var_0, "_encstr_AF5A081BBAC993AC73A3");
}

_encstr_AD321C3B93AC569B89C2BCCDA3275AB52BAFD02CDC23C6596B5827DA594E(var_0) {
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](var_0);
}

server_unlocked(var_0) {
  self endon("_encstr_A33D19D4FA32AB903AD780B9F7446BCBBAA740EC945A7BFBE8FF70");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
}

_id_1266A(var_0) {
  self._id_1300B = var_0;
}

_encstr_A2611E3C0B122B1BE7C38A1DAEB1CBA8A14BF330CE674D144010BDCA738D95CF(var_0, var_1) {
  var_2 = self.team != "_encstr_A7A408B9CA5D1D4E2C63";
  var_3 = scripts\common\utility::playersincylinder(var_0, var_1);

  foreach(var_5 in var_3) {
    if(var_2 && var_5.team != self.team) {
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B8A31960C9FC734AE0B867F6494989D3C8DF63EBD72379F160B1B3", var_5);
      continue;
    }

    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_AD9B129DEBA5E61B7BB55A9BECBE0B8EA316D8B5", var_5);
  }
}

_encstr_83781A8B0180BE0F5AD83AC2632DEB77309F2B0DA52887177750027A(var_0, var_1) {
  var_2 = self.team != "_encstr_A7A408B9CA5D1D4E2C63";
  var_3 = scripts\common\utility::playersincylinder(var_0, var_1);

  foreach(var_5 in var_3) {
    if(var_2 && var_5.team != self.team) {
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_95BF19B6EB4BDC36EDB596CDECF516E847161BB5EBC1B1165E56E4", var_5);
      continue;
    }

    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8B6112ADF5B473C6DE5BA53776BE853A472CD8AD", var_5);
  }
}

_id_13186(var_0, var_1) {
  var_2 = 0;

  if(var_0 == "_encstr_A94C02B6")
    var_2 = 1;

  var_3 = 0;

  if(istrue(var_1))
    var_3 = 1;

  var_4 = 1;
  var_5 = var_2;
  var_6 = var_3 << var_5;
  var_7 = ~(1 << var_5);
  var_8 = getomnvar("_encstr_B8B117C323AFC50798E4FF438351A348DD1A47234045AA743B");
  var_9 = var_8 &var_7;
  var_10 = var_9 + var_6;
  setomnvar("_encstr_B8B117C323AFC50798E4FF438351A348DD1A47234045AA743B", var_10);
}