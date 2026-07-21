/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\tutorial\br_tut_ui.gsc
***********************************************/

_encstr_B6301A9B259BB7EB95E6E7C05FAF6827985B0488B8E070E29332D578(var_0, var_1) {
  level.player sethudtutorialmessage(var_0);
  wait(var_1);
  level.player clearhudtutorialmessage();
}

_encstr_8AAB1886AB46EBB6CAE66EC23B95D7DDC25AD1F5377BA3D2CC2F(var_0, var_1) {
  level.player sethudtutorialmessage(var_0);
  self waittill(var_1);
  level.player clearhudtutorialmessage();
}

_encstr_8549111C93ED8D59379BEB3B7B7DB8AB95EA59(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "_encstr_85C20DD9D32F7ED81E1FD3E75C05E9";

  if(!isDefined(var_1))
    var_1 = 10;

  level._id_14304 = [];
  level._id_14303 = var_0;
  level._id_14308 = var_1;

  for(;;) {
    if(level._id_14304.size) {
      var_2 = [];

      foreach(var_4 in level._id_14304) {
        _id_1243A(var_4);
        var_2[var_2.size] = var_4;
      }

      level._id_14304 = scripts\engine\utility::array_remove_array(level._id_14304, var_2);
    }

    waitframe();
  }
}

_id_1243A(var_0) {
  if(isDefined(self.watch_for_players_touching_ground)) {
    while(_encstr_850813FBE187A355B8CE44CAE698901A6839670B6F())
      waitframe();
  }

  self playSound(var_0);
  wait(lookupsoundlength(var_0) / 1000.0);
  self notify(var_0);
}

_encstr_850813FBE187A355B8CE44CAE698901A6839670B6F() {
  return gettime() - self.watch_for_players_touching_ground < 400;
}

_id_143A2() {
  while(level._id_14304.size)
    wait 0.1;
}

_encstr_A7FB12B3B7BEC5AEACAE59F55ADC7D56B607A3F2() {
  return !level._id_14304.size;
}

_encstr_8FB9111356C1EF7BABA1B25A788776EB5BB781(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = level._id_14308;

  var_3 = [];

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = var_0 + var_2;
    var_3[var_3.size] = var_5;
    var_2 = var_2 + level._id_14308;
  }

  return var_3;
}

_encstr_860B0EDD61276058237A6836B27B0F88(var_0, var_1, var_2) {
  self endon(var_1);

  if(!isDefined(var_2))
    var_2 = 10;

  var_3 = 1;

  for(;;) {
    foreach(var_5 in var_0) {
      if(!var_3)
        wait(var_2);

      var_3 = 0;

      if(scripts\engine\utility::flag_exist(var_1) && scripts\engine\utility::flag(var_1)) {
        return;
      }
      _encstr_919D13C18D2CE57DE8A5C6D87D36DBAD0EB156D12B(var_5);
    }
  }
}

_encstr_A927170509D9168EDF6AB3F3D90B21D0E96417B0867B7566B4(var_0, var_1, var_2) {
  self endon(var_1);

  if(!isDefined(var_2))
    var_2 = 10;

  for(;;) {
    foreach(var_4 in var_0) {
      _encstr_8A591C0BC2874301AF880939B116888DD7DBA0F0AA27F64845782913B4FF(var_4);
      wait(var_2);
    }

    waitframe();
  }
}

_encstr_A9031787B3725EC82FED516957F1D01C496F05016F2B283824(var_0, var_1, var_2) {
  self endon("_encstr_8EC309AB132C79DB219462");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 10;

  if(!isDefined(var_2))
    var_2 = 10;

  wait(var_2);
  thread _encstr_A927170509D9168EDF6AB3F3D90B21D0E96417B0867B7566B4(var_0, "_encstr_8EC309AB132C79DB219462", var_1);
}

_encstr_8D870E4BDD4EAB201790F958124B1389(var_0, var_1, var_2) {
  _encstr_A33A0DCF334F8907CE0187D08C2B89();
  waitframe();
  level.player thread _encstr_A9031787B3725EC82FED516957F1D01C496F05016F2B283824(var_0, var_1, var_2);
}

_encstr_A33A0DCF334F8907CE0187D08C2B89() {
  level.player notify("_encstr_8EC309AB132C79DB219462");
}

add_to_vo_queue(var_0) {
  level._id_14304[level._id_14304.size] = level._id_14303 + var_0;
}

_encstr_A11519C28C32BE2C36A50BCDFAB0939C852FFAE8BDFA175759ABB2(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0.3;

  foreach(var_3 in var_0)
  add_to_vo_queue(var_3);
}

_encstr_8BF3196250B9B9FF6A673439F610E3F1F170098BA077EA7721CD05(var_0) {
  level._id_14304[level._id_14304.size] = var_0;
}

_encstr_A71B1F602A77CFD99BF0B13BFB0723079EF370F893C1C1D02F1EC838C11F49EB47(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0.3;

  foreach(var_3 in var_0)
  _encstr_8BF3196250B9B9FF6A673439F610E3F1F170098BA077EA7721CD05(var_3);
}

_id_143EC(var_0) {
  while(scripts\engine\utility::array_contains(level._id_14304, level._id_14303 + var_0))
    waitframe();
}

_encstr_84121BE753D88B4B2B286A4111FB13C5A03F616C9788951F4F8DB22BBB(var_0) {
  while(scripts\engine\utility::array_contains(level._id_14304, var_0))
    waitframe();
}

_encstr_919D13C18D2CE57DE8A5C6D87D36DBAD0EB156D12B(var_0) {
  add_to_vo_queue(var_0);
  self waittill(level._id_14303 + var_0);
}

_encstr_8A591C0BC2874301AF880939B116888DD7DBA0F0AA27F64845782913B4FF(var_0) {
  _encstr_8BF3196250B9B9FF6A673439F610E3F1F170098BA077EA7721CD05(var_0);
  self waittill(var_0);
}

_encstr_87E50B26DEA37DDC38CAC2D6E6(var_0, var_1, var_2) {
  var_3 = level.bots["_encstr_9775086022BE1B413B8B"][var_0];
  var_4 = var_1 + var_3.operatorcustomization.voice + "_encstr_BA4C02DF" + var_2;
  var_3 playSound(var_4);
}

_encstr_8B800AA5E6334B1BD79B990F() {
  level.player setclienttriggeraudiozone("_encstr_96BE1849327B0D186ADB176BE09379C7E74F2B3BD9BF30C084A4", 1);
  wait 3;
  level.player playlocalsound("_encstr_85951A5A366D79F2DB6107138090A421235EB2C2078FF2344140270B", undefined, undefined, 1);
  wait 0.8;
  _encstr_A71B1F602A77CFD99BF0B13BFB0723079EF370F893C1C1D02F1EC838C11F49EB47(["_encstr_AA72248CF0FA13E46BD7377B1BB0BECEC2DA2B475EE0B2BE3AEA8EFADD16C93DDBCD59FA4C03", "_encstr_93C41BAF8B079AB268311F6780C1A792CD25B2E5E0AF53ED3110B7267A", "_encstr_91021D6ADBC93582FDA97BCF7A91C7ADCEFBC8375117D848677947F59742B7"]);
  level.player clearclienttriggeraudiozone(3);
}