/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\supply_sweep.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_BDAA0D36D38B6908F907E8D0F73D43", ::_encstr_A3461C0532A7EBAF1763F0E06B6D73E347CD05FFBE2310CBFA7BC0C0B283);
  teleportplayertoselection();

  for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
    level.teamdata[level.teamnamelist[var_0]]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"] = [];
    level.teamdata[level.teamnamelist[var_0]]["_encstr_A696131B23B357083833B79B2D2219108B49D0408A"] = 0;
    level.teamdata[level.teamnamelist[var_0]]["_encstr_A5D420CDEADAA6D50707C6F24D775659835A5AB1D8CDE8E4B20BD6354716C9E89523"] = 0;
  }
}

teleportplayertoselection() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9BDB136EABC107D897FA6E77CA9583AF378EC2C9E8"] = "_encstr_82D82445DAC0BF5943B8CF9B89CB53C0969F8F0F51E0A3AAE2C9B37B03B9CF8A46BF433EE8CB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ADDA11BF2D4AD079AFB153DB7AB72FF1A79E29"] = "_encstr_845C22A3B25938010B3F9F83EBA2D6D8FACF89D811AB40C7139BB3BFAFDA1540BFA7D0B1";
}

_encstr_A3461C0532A7EBAF1763F0E06B6D73E347CD05FFBE2310CBFA7BC0C0B283(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = undefined;

  if(istrue(level._encstr_88BE13E819E97B95C0A3F0B683509FA9778B8BFB9D))
    var_1 = "_encstr_BA0D2B25A348AB0AD719C10FB9B90FB9A1FD5983585A2A3D5D36A536BCEA8EF9B0C6ACF4EF89E22F470A2DC7AB";
  else if(istrue(self.hasradar))
    var_1 = "_encstr_99AD2BEDB77693022FC1600879F30F2FCF9D774F2A9336C2E7099811A1E7F60F2460F9DEC04763D56F29C059D9";

  if(isDefined(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]](var_1);

    return 0;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  var_2 = _encstr_8348121C8DC2CBC60B1B364B9BECCA371DD59359(var_0);

  if(!istrue(var_2))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  level thread _encstr_B284125AD70355DFBBDAE50191D983A788504AC3(self, var_0);
  return 1;
}

_encstr_8348121C8DC2CBC60B1B364B9BECCA371DD59359(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!istrue(var_0._id_133CC)) {
    var_1 = "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039";

    if(scripts\cp_mp\utility\game_utility::_id_140A9())
      var_1 = "_encstr_92EA1A170F3174E0A3CB73ABB7A738BDFABFDD9BD799C910F766D88B";

    var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, getcompleteweaponname(var_1));

    if(!istrue(var_2))
      return 0;
  }

  return 1;
}

_encstr_B284125AD70355DFBBDAE50191D983A788504AC3(var_0, var_1) {
  var_2 = var_0.team;
  _encstr_B14E1357355EA381485B129BB330C40B366FE7F7B1(var_0, var_2, var_1);
  var_3 = getdvarint("_encstr_BDA31A2F47EB6048ADC2EB60A85F90AC72A7A1EFF323BE90C49C3038", 20);
  var_4 = level.teamdata[var_2]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"].size > 0;
  var_5 = undefined;

  if(var_4)
    var_5 = level.teamdata[var_2]["_encstr_A696131B23B357083833B79B2D2219108B49D0408A"] + var_3 * 1000;
  else
    var_5 = gettime() + var_3 * 1000;

  level.teamdata[var_2]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"] = scripts\engine\utility::array_add(level.teamdata[var_2]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"], var_1);
  level.teamdata[var_2]["_encstr_A696131B23B357083833B79B2D2219108B49D0408A"] = var_5;
  var_6 = scripts\mp\utility\teams::getteamdata(var_2, "_encstr_9775086022BE1B413B8B");

  foreach(var_8 in var_6) {
    if(isDefined(var_8) && !var_8 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
      var_8 _meth_87EC(1);
      var_8 playsoundtoplayer("_encstr_8C721666519851539FC1B767F7BDFB8080FA116A4BB8E56B", var_8);
    }
  }

  var_10 = level.teamdata[var_2]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"].size >= 3;
  _encstr_86301E2210DD769349AD7C63BDF333FD2B50CBFAB069AAF7C3854E69DE582F87(var_10, var_2);
  var_11 = max((var_5 - gettime()) / 1000.0, 0.1);
  scripts\engine\utility::_id_143B9(var_11, "_encstr_9B1D0BC7932875276230426AA1");
  level.teamdata[var_2]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"] = scripts\engine\utility::array_remove(level.teamdata[var_2]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"], var_1);
  var_10 = level.teamdata[var_2]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"].size >= 3;
  _encstr_86301E2210DD769349AD7C63BDF333FD2B50CBFAB069AAF7C3854E69DE582F87(var_10, var_2);
  var_12 = level.teamdata[var_2]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"].size == 0;

  if(var_12) {
    var_6 = scripts\mp\utility\teams::getteamdata(var_2, "_encstr_9775086022BE1B413B8B");

    foreach(var_8 in var_6) {
      if(isDefined(var_8))
        var_8 _meth_87EC(0);
    }
  } else {
    while(!var_12 && !level.gameended) {
      var_5 = level.teamdata[var_2]["_encstr_A696131B23B357083833B79B2D2219108B49D0408A"];
      var_11 = max((var_5 - gettime()) / 1000.0, 0.1);
      scripts\engine\utility::_id_143B9(var_11, "_encstr_9B1D0BC7932875276230426AA1");
      var_12 = level.teamdata[var_2]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"].size == 0;
    }
  }

  _encstr_9ADF11AF58FB75D8BBADCBD0E12870B7175FEB(var_0, var_2, var_1);
}

_encstr_B14E1357355EA381485B129BB330C40B366FE7F7B1(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_2.streakname, var_0.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_A33412F06B07A98EA7054F47E477764F6B92F860", var_0);

  if(!istrue(level.gameended))
    _encstr_85351ED0E33162AF13220F19782BFFA99D2BA0482FDAB9699ACA0D9356320751(var_1, "_encstr_9BDB136EABC107D897FA6E77CA9583AF378EC2C9E8");

  level.teamdata[var_1]["_encstr_A5D420CDEADAA6D50707C6F24D775659835A5AB1D8CDE8E4B20BD6354716C9E89523"]++;
}

_encstr_9ADF11AF58FB75D8BBADCBD0E12870B7175FEB(var_0, var_1, var_2) {
  level.teamdata[var_1]["_encstr_A5D420CDEADAA6D50707C6F24D775659835A5AB1D8CDE8E4B20BD6354716C9E89523"]--;

  if(level.teamdata[var_1]["_encstr_A5D420CDEADAA6D50707C6F24D775659835A5AB1D8CDE8E4B20BD6354716C9E89523"] == 0 && !istrue(level.gameended))
    _encstr_85351ED0E33162AF13220F19782BFFA99D2BA0482FDAB9699ACA0D9356320751(var_1, "_encstr_ADDA11BF2D4AD079AFB153DB7AB72FF1A79E29");

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_2);

  if(isDefined(var_0) && !istrue(level._id_12AA4))
    var_0 scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_2);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC")]]("_encstr_8887145B961BD86E8EC9AC16B601ACDC8C5923109604" + var_2.streakname, var_0);
}

_encstr_86301E2210DD769349AD7C63BDF333FD2B50CBFAB069AAF7C3854E69DE582F87(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && !var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
      var_4 _meth_87ED(var_0);
  }
}

_encstr_85351ED0E33162AF13220F19782BFFA99D2BA0482FDAB9699ACA0D9356320751(var_0, var_1) {
  if(istrue(level.little_bird_mg_mp_init)) {
    return;
  }
  if(!isDefined(game["_encstr_B2DA070A5F8BAB87AF"][var_1])) {
    return;
  }
  var_2 = "_encstr_85B20D2F3AC9520B979FDBB7D14801" + game["_encstr_B2DA070A5F8BAB87AF"][var_1];
  var_3 = level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"];

  foreach(var_5 in var_3)
  thread _encstr_8BDD1892E3C8388283DFEFBFEB2F4A69F8680D1FBBC0F1EBD5B5(var_2, var_1, var_5, 1, 0);
}

_encstr_8BDD1892E3C8388283DFEFBFEB2F4A69F8680D1FBBC0F1EBD5B5(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_2)) {
    return;
  }
  var_2 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!isalive(var_2) && !istrue(var_4)) {
    return;
  }
  if(var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_11C7D(var_1, var_3)) {
    return;
  }
  if(isDefined(var_0)) {
    var_0 = tolower(var_0);
    var_6 = lookupsoundlength(var_0, 1) / 1000.0;

    if(isDefined(var_5))
      wait(var_5);

    var_2 queuedialogforplayer(var_0, var_1, var_6);
  }
}