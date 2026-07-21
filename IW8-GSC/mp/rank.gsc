/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\rank.gsc
***********************************************/

init() {
  level.scoreinfo = [];
  var_0 = getdvarint("_encstr_B6F00BA4D4072B85F1F10A99AF");
  level.vip_death_player_hits_million = getdvarint("_encstr_A1F021DC1BC9F5AD968D1BAF31C90B36B5561DF5E6D885B1D27376AFC85ACD164C36CA", 1);

  if(level.vip_death_player_hits_million != 1) {
    level.vip_failquest = getdvarint("_encstr_A2E4171B41164FEC7099240F9DF036F73239E341ABED6F62B0", 25);
    level.vip_completequest = getdvarint("_encstr_A1F017DC1BC9F5AD968D1BAF31C90B36B5561DF5E458B99DCA", 10);
    level.vip_bink_vo = getdvarint("_encstr_B4E3196E1BE4FAB6B4D863D79839851BDACAD1D7C195E41BB29BE8", 10) / 100;
    level.vindia_assault3_check_size = getdvarint("_encstr_B8D717F8E76E783FFCA91BD0A236108B8F291377E1FD0B562B", 5);
  }

  if(var_0 > 4 || var_0 < 0)
    exitlevel(0);

  addglobalrankxpmultiplier(var_0, "_encstr_B66612EDCDB1B4CD56F56B077DF0839B3658D856");
  var_1 = getdvarint("_encstr_83670B2B6F5B07122F6EE127B2");

  if(var_1 > 4 || var_1 < 0)
    exitlevel(0);

  battle_tracks_playerinlisteningzoneinternal(var_1, "_encstr_AA361B47F548748B85D6625ADB65DB2F7961D0C307D8FD6FA0A95B4223");
  var_2 = getdvarint("_encstr_87370B354C4974D8BFB5434F67", 1);

  if(var_2 > 4 || var_2 < 0)
    exitlevel(0);

  battle_tracks_playerselectrandomtracks(var_2, "_encstr_B40518DE37362DCD957DDBE0ACE4851DBD27EB0FE0B9B1C26395");
  var_3 = getdvarint("_encstr_A7260BC4A4A4272A452A45A8A9", 1);

  if(var_3 > 4 || var_3 < 0)
    exitlevel(0);

  battle_tracks_playerinsidezone(var_3, "_encstr_B1CD14BD9B364BB995F51BC6C2E6EBC338DC6CC26395");
  level.ranktable = [];
  level.weaponranktable = [];
  var_4 = _func_428();
  level.maxrank = int(tablelookup(var_4, 0, "_encstr_ADF308608F704BC31A2C", 1));
  level._id_11B5C = int(tablelookup(var_4, 0, "_encstr_A15B098159DB91995F1AC0", 1));

  for(var_5 = 0; var_5 <= level.maxrank; var_5++) {
    level.ranktable[var_5][0] = int(tablelookup(var_4, 0, var_5, 2));
    level.ranktable[var_5][1] = int(tablelookup(var_4, 0, var_5, 3));
    level.ranktable[var_5][2] = int(tablelookup(var_4, 0, var_5, 7));
    level.ranktable[var_5][3] = tablelookup(var_4, 0, var_5, 15);
  }

  scripts\mp\weaponrank::init();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  level.prestigeextras = [];
  level thread onplayerconnect();
}

isregisteredevent(var_0) {
  if(isDefined(level.scoreinfo[var_0]))
    return 1;
  else
    return 0;
}

registerscoreinfo(var_0, var_1, var_2) {
  level.scoreinfo[var_0][var_1] = var_2;

  if(var_0 == "_encstr_ABD70578F3D02C" && var_1 == "_encstr_BA94069D16D8ABAC")
    setomnvar("_encstr_A91718CF50F64732F39DE123FBB10A3718C82313490BB92AEBA5", int(var_2));
}

_id_12189(var_0, var_1) {
  var_2 = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8F4508C13AAFE0B555E7" + var_0, var_1);
  level.scoreinfo[var_0]["_encstr_BA94069D16D8ABAC"] = var_2;
}

getscoreinfovalue(var_0) {
  var_1 = "_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8F4508C13AAFE0B555E7" + var_0;

  if(getDvar(var_1) != "_encstr_B40101")
    return getdvarint(var_1);
  else
    return level.scoreinfo[var_0]["_encstr_BA94069D16D8ABAC"];
}

getscoreinfocategory(var_0, var_1) {
  if(istrue(level.removekilleventsplash) && !isDefined(level.scoreinfo[var_0])) {
    return;
  }
  switch (var_1) {
    case "_encstr_BA94069D16D8ABAC":
      var_2 = "_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8F4508C13AAFE0B555E7" + var_0;

      if(getDvar(var_2) != "_encstr_B40101")
        return getdvarint(var_2);
      else
        return level.scoreinfo[var_0]["_encstr_BA94069D16D8ABAC"];
    default:
      return level.scoreinfo[var_0][var_1];
  }
}

getrankinfominxp(var_0) {
  return level.ranktable[var_0][0];
}

getrankinfoxpamt(var_0) {
  return level.ranktable[var_0][1];
}

getrankinfomaxxp(var_0) {
  return level.ranktable[var_0][2];
}

initcpammoarmorcrate(var_0) {
  var_1 = spawnStruct();
  var_2 = level.loadoutsgroup;
  var_1._id_12507 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8BFF0A63E8D78F37E0C7F8F8");
  var_1._id_1454F = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_8C160DAFE71BF161681EB5BCB0F8FC");
  var_1._id_14548 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6");
  var_1._id_14549 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_AC5B11276F638919E0863E8278603213977BC2");
  var_1._id_1454B = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A9FA0E8BE3BF871942571010A378F033");
  var_1._id_1454E = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_858110A5BB0EEB16C97DADB134859C1B5AB2");
  var_1._id_1454C = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_AA4E0E62DBBA974F10DFB72A838517D5");
  var_1._id_1454D = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_99550F225BABC7E65077BBB13990FBCE96");
  var_1._id_1454A = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_95FA0EA5EE1CFA5827D733B08DB45B16");
  var_1._id_14550 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_BDF710419C225F46FDE93B32B8337A6BE00D");
  var_1._id_1456E = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_857F0EA5BB0EEB37B57DAD38B0C1584D");
  var_1._id_1456C = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A2170C621BEB872268B7727DC920");
  var_1._id_1456B = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A3320E102B50DF0BDF2FC7C5EF2F1065");
  var_1._id_14570 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A3850ED02338F9BEDA6FF9E3EB22A3CA");
  var_1._id_1456F = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_977F0EB4EE70AF9BDAF5B5831683589B");
  var_1._id_14572 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_826B0D691C902EABB02913EB9F638B");
  var_1._id_14573 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_B6D70E4268A119076810CED916132F1A");
  var_1._id_14567 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A1E70FBB8CDA89535851E1C3D9EB66A97A");
  var_1._id_14566 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_B10B12CC2CE969D3A8513F1BC883B4723B648253");
  var_1._id_14569 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_8A5C0FA8E32097400C0797904EA782221F");
  var_1._id_1456A = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A96310D2BBC1F5B9A1AF27B7B5B27BE09B06");
  var_1._id_1455A = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_9AB60FB477707DB1DAFA6DD263DB1364C4");
  var_1._id_1455F = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A2650D3B7B57574AFFAF4BDCA3811A");
  var_1._id_1455B = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A1BA0E5A770EBE63D6D7C65A5B0B1C63");
  var_1._id_1455C = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_ABCD0F5A770EF5C6ADAF6BCEB7B199990D");
  var_1._id_1457B = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_92DF0ED45BDA2E53D81F08FF1B5F9FC2");
  var_1._id_1457A = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A52C0E7020307103407898128DC7C6CB");
  var_1._id_1457C = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A1E90DBB8CDA89536851CF8BDD6B66");
  var_1._id_14574 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_B4190F4BDDC1BE9BB9D70BB10786584D0C");
  var_1._id_14575 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_AC7D1038AF48868F8289E7F45CAAD7487DEF");
  var_1._id_14577 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_82660D691C902EABA8293197FB038E");
  var_1._id_14579 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A32A0FA7EFE3098B8006FCC79BB0ADE210");
  var_1._id_14576 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD");
  var_1._id_14565 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_BAB10F67F72A59E09850B24028F0060E50");
  var_1._id_14561 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_8D900DB477077D1C2DD736E0C28385");
  var_1._id_14564 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_9106102387E011DF472978E0722F376ADAB9");
  var_1._id_14563 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_8BE20ED75722A6731BF84F3064CA126B");
  var_1._id_14562 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_88FE0D0157202970845121C58E802F");
  var_1._id_14559 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_BA090ED4634AD742CFC7BBABA36F5A77");
  var_1._id_14555 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A5090EB4DD83D78D16BE3B4EED5BACB7");
  var_1._id_14558 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A3EF0E518C324F35EBD9CA8250CB3A22");
  var_1._id_14556 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_97EF0EA5BB70FA1BB0AFD4D56396593A");
  var_1._id_14557 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A2A80D2D771CBE8D58EBDA9D7B8D33");
  var_1._id_14554 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_87610AB4EE83FAD6374B3395");
  var_1._id_14560 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_8EF4120387DA5772B528A25C906463B05F38F38F");
  var_1._id_14553 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A7ED0AD79F73990E28334B92");
  var_1._id_1456D = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_AFB61044F3DA4723B9B78F5B33DE1AB9E892");
  var_1._id_14552 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_AC940FE7036051A1F8304BA6AEFCB82AB6");
  var_1._id_1455D = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_9BCD0F4B7707AFB1D6BEDAB37B1B9966B1");
  var_1._id_14551 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_AC77112A4BA8EEF132C6AF10250A0A617EE292");
  var_1._id_1455E = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A5400E522BDBB7D5B8678D832398DDDE");
  var_1._id_14578 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_88F60EF477AA1917C80F0C3A6946EACA");
  var_1._id_14571 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_A50910B4DD83D76ED6BE9BADECDB8D33A1A9");
  var_1._id_14568 = var_0 getplayerdata(var_2, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", "_encstr_9B080EA5BBE0D79B34BE5BA5D6956463");
  return var_1;
}

initcrossbowusage(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;

  if(var_3 != 0) {
    var_2.xp = var_2.xp + var_3;
    var_2.count++;
  }
}

initcprooftopcrate(var_0, var_1) {
  var_2 = var_1._id_12507 - var_0._id_12507;
  var_3 = spawnStruct();
  var_3.xp = 0;
  var_3.count = 0;
  initcrossbowusage(var_0._id_1454F, var_1._id_1454F, var_3);
  initcrossbowusage(var_0._id_14548, var_1._id_14548, var_3);
  initcrossbowusage(var_0._id_14549, var_1._id_14549, var_3);
  initcrossbowusage(var_0._id_1454B, var_1._id_1454B, var_3);
  initcrossbowusage(var_0._id_1454E, var_1._id_1454E, var_3);
  initcrossbowusage(var_0._id_1454C, var_1._id_1454C, var_3);
  initcrossbowusage(var_0._id_1454D, var_1._id_1454D, var_3);
  initcrossbowusage(var_0._id_1454A, var_1._id_1454A, var_3);
  initcrossbowusage(var_0._id_14550, var_1._id_14550, var_3);
  initcrossbowusage(var_0._id_1456E, var_1._id_1456E, var_3);
  initcrossbowusage(var_0._id_1456C, var_1._id_1456C, var_3);
  initcrossbowusage(var_0._id_1456B, var_1._id_1456B, var_3);
  initcrossbowusage(var_0._id_14570, var_1._id_14570, var_3);
  initcrossbowusage(var_0._id_1456F, var_1._id_1456F, var_3);
  initcrossbowusage(var_0._id_14572, var_1._id_14572, var_3);
  initcrossbowusage(var_0._id_14573, var_1._id_14573, var_3);
  initcrossbowusage(var_0._id_14567, var_1._id_14567, var_3);
  initcrossbowusage(var_0._id_14566, var_1._id_14566, var_3);
  initcrossbowusage(var_0._id_14569, var_1._id_14569, var_3);
  initcrossbowusage(var_0._id_1456A, var_1._id_1456A, var_3);
  initcrossbowusage(var_0._id_1455A, var_1._id_1455A, var_3);
  initcrossbowusage(var_0._id_1455F, var_1._id_1455F, var_3);
  initcrossbowusage(var_0._id_1455B, var_1._id_1455B, var_3);
  initcrossbowusage(var_0._id_1455C, var_1._id_1455C, var_3);
  initcrossbowusage(var_0._id_1457B, var_1._id_1457B, var_3);
  initcrossbowusage(var_0._id_1457A, var_1._id_1457A, var_3);
  initcrossbowusage(var_0._id_1457C, var_1._id_1457C, var_3);
  initcrossbowusage(var_0._id_14574, var_1._id_14574, var_3);
  initcrossbowusage(var_0._id_14575, var_1._id_14575, var_3);
  initcrossbowusage(var_0._id_14577, var_1._id_14577, var_3);
  initcrossbowusage(var_0._id_14579, var_1._id_14579, var_3);
  initcrossbowusage(var_0._id_14576, var_1._id_14576, var_3);
  initcrossbowusage(var_0._id_14565, var_1._id_14565, var_3);
  initcrossbowusage(var_0._id_14561, var_1._id_14561, var_3);
  initcrossbowusage(var_0._id_14564, var_1._id_14564, var_3);
  initcrossbowusage(var_0._id_14563, var_1._id_14563, var_3);
  initcrossbowusage(var_0._id_14562, var_1._id_14562, var_3);
  initcrossbowusage(var_0._id_14559, var_1._id_14559, var_3);
  initcrossbowusage(var_0._id_14555, var_1._id_14555, var_3);
  initcrossbowusage(var_0._id_14558, var_1._id_14558, var_3);
  initcrossbowusage(var_0._id_14556, var_1._id_14556, var_3);
  initcrossbowusage(var_0._id_14557, var_1._id_14557, var_3);
  initcrossbowusage(var_0._id_14554, var_1._id_14554, var_3);
  initcrossbowusage(var_0._id_14560, var_1._id_14560, var_3);
  initcrossbowusage(var_0._id_14553, var_1._id_14553, var_3);
  initcrossbowusage(var_0._id_1456D, var_1._id_1456D, var_3);
  initcrossbowusage(var_0._id_14552, var_1._id_14552, var_3);
  initcrossbowusage(var_0._id_1455D, var_1._id_1455D, var_3);
  initcrossbowusage(var_0._id_14551, var_1._id_14551, var_3);
  initcrossbowusage(var_0._id_1455E, var_1._id_1455E, var_3);
  initcrossbowusage(var_0._id_14578, var_1._id_14578, var_3);
  initcrossbowusage(var_0._id_14571, var_1._id_14571, var_3);
  initcrossbowusage(var_0._id_14568, var_1._id_14568, var_3);

  if(var_2 != 0 || var_3.xp != 0)
    self dlog_recordplayerevent("_encstr_A7401D034938FAD7A8B32FF5EBA1208287DB8FC3475E93A108FBA97C612873", ["_encstr_8458106ADB72B388EE97A09A4F0E24D88B45", var_0._id_12507, "_encstr_AC620E083BE9AA4B5BA1535F890295B1", var_1._id_12507, "_encstr_ABAF15919633CCF5BB2B0B38B7B9FAE183F5D8F6D5CDA3", var_3.count, "_encstr_AD8C0FAC1A602FEF24DFFAB8A75D099859", var_3.xp]);
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!isai(var_0))
      var_0.initdismembermentlist = initcpammoarmorcrate(var_0);

    if(!isai(var_0)) {
      if(level.playerxpenabled) {
        var_0.pers["_encstr_851207B317B203FA5A"] = var_0 getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8BFF0A63E8D78F37E0C7F8F8");
        var_0.pers["_encstr_A7700D1358473A36B2070BCD3787C1"] = var_0 getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_97340E22A1C474C4D50B81576338CBCF");
        var_1 = var_0 getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_83250C68679183370209EE7F5D0A");

        if(!isDefined(var_0.pers["_encstr_8E3912E1605F0B3EBBAA7967627F76A9EEDC5F59"]))
          var_0.pers["_encstr_8E3912E1605F0B3EBBAA7967627F76A9EEDC5F59"] = 0;
      } else {
        var_1 = 0;
        var_0.pers["_encstr_851207B317B203FA5A"] = 0;
        var_0.pers["_encstr_A7700D1358473A36B2070BCD3787C1"] = 0;
      }
    } else {
      var_1 = 0;
      var_0.pers["_encstr_851207B317B203FA5A"] = 0;
      var_0.pers["_encstr_A7700D1358473A36B2070BCD3787C1"] = 0;
    }

    var_0.pers["_encstr_A7EC09AFBBDF6B0710524A"] = [];

    if(var_0.pers["_encstr_851207B317B203FA5A"] < 0)
      var_0.pers["_encstr_851207B317B203FA5A"] = 0;

    if(var_0.pers["_encstr_A7700D1358473A36B2070BCD3787C1"] < 0)
      var_0.pers["_encstr_A7700D1358473A36B2070BCD3787C1"] = 0;

    var_2 = var_0 getrankxp();
    var_3 = var_0 getrankforxp(var_2);
    var_4 = var_0 rodwatcher(var_2);
    var_0.pers["_encstr_A51F05CB11A052"] = var_3;
    var_0.pers["_encstr_A1ED09400BA5D351227715"] = var_1;
    var_0 setrank(var_3 + var_4, var_1);
    var_0.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"] = 0;
    var_0.scoreupdatetotal = 0;
    var_0.scorepointsqueue = 0;
    var_0.scoreeventqueue = [];
    var_0.postgamepromotion = 0;
    var_0 setclientdvar("_encstr_B4F10DEAA5F5C1E4F6B57B3A4BDE73", 0);

    if(!isDefined(var_0.pers["_encstr_AA3B085BC34075B70E12"])) {
      var_0.pers["_encstr_AA3B085BC34075B70E12"] = [];
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = 0;
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"] = 0;
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_932E0A09FB023CC0DA8D7FFF"] = 0;
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_84A40620D6E488A3"] = 0;
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B6A2056BD237D8"] = 0;
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_BDC706D9372AABE8"] = 0;
      var_0.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = 0;
    }

    var_0 setclientdvar("_encstr_8D410B996AD8A5BC640751B95F", 0);

    if(level.playerxpenabled) {
      var_5 = getdvarint("_encstr_82040BEBF751F74784D0BADE77");
      var_6 = var_0 getprivatepartysize() > 1;

      if(var_6) {
        var_0 addrankxpmultiplier(var_5, "_encstr_921218BF8D102002158FD27BE110D2C39B0F165BF307FA6F0AC1");

        if(_func_043E(var_0))
          var_0 addrankxpmultiplier(1.1, "_encstr_8E761908926DABB017D73EA1C1135E2197FBB0018B02D729DF1C35");
      }

      if(var_0 getplayerdata("_encstr_8C07031599", "_encstr_9207176036A1C71BD3C0A2A898335673190CFDE94F88EB28C9"))
        var_0.prestigedoubleweaponxp = 1;
      else
        var_0.prestigedoubleweaponxp = 0;
    }

    var_0.scoreeventcount = 0;
    var_0.scoreeventlistindex = 0;
    var_0 setclientomnvar("_encstr_88C91757B4FA9B1BDB9CCAFA56D9AC9B1DFAD8DBE6E839BD8D", -1);
    var_0 setclientomnvar("_encstr_8CD01CAEB4BE38DB1DECD7371B7B93CAD759D959B947EBD8F69BD1937BB1", -1);
  }
}

onplayerspawned() {
  if(isai(self))
    self.pers["_encstr_851207B317B203FA5A"] = scripts\mp\bots\bots_util::get_rank_xp_for_bot();
  else if(!level.playerxpenabled)
    self.pers["_encstr_851207B317B203FA5A"] = 0;
  else {}

  playerupdaterank();
}

playerupdaterank() {
  var_0 = self.pers["_encstr_851207B317B203FA5A"];

  if(var_0 < 0) {
    var_0 = 0;
    self.pers["_encstr_851207B317B203FA5A"] = 0;
  }

  var_1 = getrankforxp(var_0);
  self.pers["_encstr_A51F05CB11A052"] = var_1;

  if(isai(self) || !isDefined(self.pers["_encstr_A1ED09400BA5D351227715"])) {
    if(level.playerxpenabled && isDefined(self.bufferedstats))
      var_2 = getprestigelevel();
    else
      var_2 = 0;

    self setrank(var_1, var_2);
    self.pers["_encstr_A1ED09400BA5D351227715"] = var_2;
  }
}

tryresetrankxp() {
  if(issubstr(self.class, "_encstr_BD34078D57B9A37BD6")) {
    if(!level.playerxpenabled)
      self.pers["_encstr_851207B317B203FA5A"] = 0;
    else if(isai(self))
      self.pers["_encstr_851207B317B203FA5A"] = 0;
    else {}
  }
}

giverankxp(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self.owner) && !isbot(self)) {
    self.owner giverankxp(var_0, var_1, var_2);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }
  var_5 = botnodeavailabletoteam(self);
  var_1 = int(var_1 * var_5);

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  if(!level.playerxpenabled) {
    if(var_3 == 0)
      scripts\mp\utility\points::displayscoreeventpoints(var_1, var_0);

    return;
  }

  if(!isDefined(var_1) || var_1 == 0) {
    return;
  }
  var_6 = getscoreinfocategory(var_0, "_encstr_852906B39CBD5D38");

  if((!isDefined(level.forceranking) || !level.forceranking) && !scripts\mp\menus::brking_updateteamscore()) {
    if(level.teambased) {
      var_7 = 0;

      foreach(var_9 in level.teamnamelist) {
        if(scripts\mp\utility\teams::getteamdata(var_9, "_encstr_AB580A05672AE35D5FFF50B8")) {
          var_7++;

          if(var_7 >= 2) {
            break;
          }
        }
      }

      if(var_7 < 2)
        return;
    } else {
      var_11 = 0;

      foreach(var_9 in level.teamnamelist) {
        var_11 = var_11 + scripts\mp\utility\teams::getteamdata(var_9, "_encstr_AB580A05672AE35D5FFF50B8");

        if(var_11 >= 2) {
          break;
        }
      }

      if(var_11 < 2)
        return;
    }
  }

  var_1 = calculate_teleport_data_for_player(var_1);
  var_14 = getscoreinfocategory(var_0, "_encstr_889C0B0BD88DBDBB48ED37ABB9");
  var_15 = 1.0;
  var_16 = var_1;
  var_17 = 0;

  if(istrue(var_14)) {
    var_15 = getrankxpmultipliertotal();
    var_16 = int(var_1 * var_15);
    var_17 = int(max(var_16 - var_1, 0));
    var_18 = round_spawn_bombers(var_0, var_2);
    var_16 = var_16 + int(var_18);
    var_17 = var_17 + int(var_18);
  }

  if(!var_3)
    scripts\mp\utility\points::displayscoreeventpoints(var_16, var_0);

  thread waitandapplyxp(var_0, var_1, var_16, var_17, var_2, var_4);
}

calculate_teleport_data_for_player(var_0) {
  var_1 = var_0;

  if(level.vip_death_player_hits_million != 1) {
    if(self.kills > level.vip_failquest) {
      var_2 = min(int(1 + (self.kills - level.vip_failquest) / level.vip_completequest), level.vindia_assault3_check_size);
      var_3 = 1 - level.vip_bink_vo * var_2;
      var_1 = int(var_0 * var_3);
    }
  }

  return var_1;
}

waitandapplyxp(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_5))
    var_5 = 0;

  if(!var_5) {
    waitframe();
    scripts\mp\utility\script::waittillslowprocessallowed();
  }

  var_6 = getrankxp();

  if(updaterank(var_6)) {}

  syncxpstat();
  var_7 = 0;

  if(isDefined(var_4)) {
    if(isDefined(var_4._id_121D9))
      var_4 = var_4._id_121D9;

    if(scripts\mp\weaponrank::weaponshouldgetxp(var_4.basename)) {
      var_7 = var_1;
      var_7 = var_7 * scripts\mp\weaponrank::getweaponrankxpmultipliertotal();
      var_7 = int(var_7);
    }
  }

  incrankxp(var_2, var_4, var_7, var_0);

  if(level.playerxpenabled && !isai(self)) {
    if(isDefined(var_4) && (scripts\mp\utility\weapon::iscacprimaryweapon(var_4) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_4))) {
      if(!scripts\mp\utility\weapon::ispickedupweapon(var_4) || scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
        scripts\common\utility::_id_13E0A(level._id_11B31, scripts\mp\utility\weapon::getweaponrootname(var_4), "_encstr_AF2F0A13317F6999F380EB53", var_7, -1, var_4);
    }
  }

  recordxpgains(var_0, var_1, var_3);
  var_8 = getprestigelevel();
  var_9 = getrank();
}

recordxpgains(var_0, var_1, var_2) {
  var_3 = var_1 + var_2;
  var_4 = getscoreinfocategory(var_0, "_encstr_852906B39CBD5D38");

  if(!isDefined(var_4) || var_4 == "_encstr_B40101") {
    self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B6A2056BD237D8"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B6A2056BD237D8"] + var_1;
    self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
    self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
    return;
  }

  switch (var_4) {
    case "_encstr_851E0C12C829661B5E9EC7CE2DE3":
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_84A40620D6E488A3"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_84A40620D6E488A3"] + var_1;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
      break;
    case "_encstr_932E0A09FB023CC0DA8D7FFF":
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_932E0A09FB023CC0DA8D7FFF"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_932E0A09FB023CC0DA8D7FFF"] + var_1;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
      break;
    case "_encstr_BDC706D9372AABE8":
      if(!isDefined(self.pers["_encstr_95EE0966486F7B7989C9B9"]))
        self.pers["_encstr_95EE0966486F7B7989C9B9"] = var_1;
      else
        self.pers["_encstr_95EE0966486F7B7989C9B9"] = self.pers["_encstr_95EE0966486F7B7989C9B9"] + var_1;

      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_BDC706D9372AABE8"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_BDC706D9372AABE8"] + var_1;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
      break;
    case "_encstr_AA7C07466F9DA30713":
      if(!isDefined(self.pers["_encstr_95EE0966486F7B7989C9B9"]))
        self.pers["_encstr_95EE0966486F7B7989C9B9"] = var_1;
      else
        self.pers["_encstr_95EE0966486F7B7989C9B9"] = self.pers["_encstr_95EE0966486F7B7989C9B9"] + var_1;

      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"] + var_1;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
      break;
    case "_encstr_8D8C08635FE8FBBCEA77":
      if(!isDefined(self.pers["_encstr_A7D40A36EDF6A35ADCD9B028"]))
        self.pers["_encstr_A7D40A36EDF6A35ADCD9B028"] = var_1;
      else
        self.pers["_encstr_A7D40A36EDF6A35ADCD9B028"] = self.pers["_encstr_A7D40A36EDF6A35ADCD9B028"] + var_1;

      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"] + var_1;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
      break;
    case "_encstr_AF190997F3A62B7168C0DA":
      if(!isDefined(self.pers["_encstr_A6120A23912A685B5702D6DF"]))
        self.pers["_encstr_A6120A23912A685B5702D6DF"] = var_1;
      else
        self.pers["_encstr_A6120A23912A685B5702D6DF"] = self.pers["_encstr_A6120A23912A685B5702D6DF"] + var_1;

      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"] + var_1;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
      break;
    default:
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_82FB06EB26785BD7"] + var_1;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_854E08AE457A73FBC8CB"] + var_2;
      self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] = self.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"] + var_3;
      break;
  }
}

updaterank(var_0) {
  var_1 = getrank();
  var_2 = getprestigelevel();
  var_3 = self.pers["_encstr_A51F05CB11A052"] + self.pers["_encstr_A1ED09400BA5D351227715"];
  var_4 = var_1 + var_2;
  self.pers["_encstr_A51F05CB11A052"] = var_1;
  self.pers["_encstr_A1ED09400BA5D351227715"] = var_2;

  if(var_4 == var_3 || var_4 >= level.maxrank + level._id_11B5C)
    return 0;

  self setrank(var_1, var_2);
  return 1;
}

updaterankannouncehud() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_92B10CEBAF2A86AB452F3B3B905F");
  self endon("_encstr_92B10CEBAF2A86AB452F3B3B905F");
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(!isDefined(var_0)) {
    return;
  }
  if(!scripts\mp\flags::levelflag("_encstr_ACCF0A3B0BD6B2EBDB3BAC27"))
    level scripts\engine\utility::waittill_notify_or_timeout("_encstr_ACCF0A3B0BD6B2EBDB3BAC27", 0.25);

  var_1 = self.pers["_encstr_A51F05CB11A052"] + self.pers["_encstr_A1ED09400BA5D351227715"];

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];
    var_4 = var_3.pers["_encstr_8AEF05472BC2D6"];

    if(isDefined(var_4) && var_4 == var_0)
      var_3 iprintln(&"_encstr_ABEC196149DDEC863F096979B5477F236B4139B93907D54FD7E574", self, var_1 + 1);
  }
}

queuescorepointspopup(var_0) {
  self.scorepointsqueue = self.scorepointsqueue + var_0;
}

flushscorepointspopupqueue() {
  scorepointspopup(self.scorepointsqueue);
  self.scorepointsqueue = 0;
}

flushscorepointspopupqueueonspawn() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self notify("_encstr_874124BD1C33F0532F6AB803127B98688D7C1F49B7DA18A7CF23F1EB7A2FC041A2C16FBD6854");
  self endon("_encstr_874124BD1C33F0532F6AB803127B98688D7C1F49B7DA18A7CF23F1EB7A2FC041A2C16FBD6854");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 0.1;
  flushscorepointspopupqueue();
}

scorepointspopup(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");

  if(var_0 == 0) {
    return;
  }
  if(!scripts\mp\utility\player::isreallyalive(self) && !self ismlgspectator() && !scripts\mp\utility\player::isusingremote()) {
    if(!istrue(var_1) || scripts\mp\utility\player::isinkillcam()) {
      queuescorepointspopup(var_0);
      thread flushscorepointspopupqueueonspawn();
      return;
    }
  }

  self notify("_encstr_A67011DEBE9285F108EF4B30EB432FC70BA3D7");
  self endon("_encstr_A67011DEBE9285F108EF4B30EB432FC70BA3D7");
  self.scoreupdatetotal = self.scoreupdatetotal + var_0;
  self setclientomnvar("_encstr_91D01073C4AF0BBA383004680F417A1A3BB3", self.scoreupdatetotal);
  self setclientomnvar("_encstr_A174174338B8DBC568F5444BFFC88DA3D573797A4085777F30", gettime());
  wait 1.0;
  self.scoreupdatetotal = 0;
}

notifyplayerscore() {
  waitframe();
  level notify("_encstr_936A14BA3823B03A59D7C18DB0F295C9F537B17B93CA", self, self.scoreupdatetotal);
}

queuescoreeventpopup(var_0) {
  self.scoreeventqueue[self.scoreeventqueue.size] = var_0;
}

flushscoreeventpopupqueue() {
  var_0 = self.scoreeventqueue;
  self.scoreeventqueue = [];

  foreach(var_2 in var_0)
  scoreeventpopup(var_2);
}

flushscoreeventpopupqueueonspawn() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self notify("_encstr_A9712339ED8D60CB3187CFFDB7780C683E43679092D5306F8B67E3EB07B2C608C91B28056C");
  self endon("_encstr_A9712339ED8D60CB3187CFFDB7780C683E43679092D5306F8B67E3EB07B2C608C91B28056C");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 0.1;
  flushscoreeventpopupqueue();
}

getscoreeventpriority(var_0) {
  if(getdvarint("_encstr_8FA517573F931898A91AE199C58D694EFAD3E39F8B9ADF18F0", 0) == 1)
    return 0;

  var_1 = getscoreinfocategory(var_0, "_encstr_978C092BB8FBFDEB302D69");

  if(!istrue(var_1))
    return 0;

  return var_1;
}

scoreeventalwaysshowassplash(var_0) {
  if(getdvarint("_encstr_8FA517573F931898A91AE199C58D694EFAD3E39F8B9ADF18F0", 0) == 1)
    return 0;

  var_1 = getscoreinfocategory(var_0, "_encstr_BA9D118536DDC22F37D443BDDD6AC1638537D0");

  if(!istrue(var_1))
    return 0;

  return 1;
}

scoreeventhastext(var_0) {
  if(getdvarint("_encstr_8FA517573F931898A91AE199C58D694EFAD3E39F8B9ADF18F0", 0) == 1)
    return 0;

  var_1 = getscoreinfocategory(var_0, "_encstr_AA5B08F5B421339B1359");
  var_2 = getscoreinfocategory(var_0, "_encstr_81EF05D156E1A3");

  if(!isDefined(var_1) || var_1 < 0 || !isDefined(var_2) || var_2 == "_encstr_B40101")
    return 0;

  return 1;
}

scoreeventpopup(var_0) {
  if(getdvarint("_encstr_8FA517573F931898A91AE199C58D694EFAD3E39F8B9ADF18F0", 0) == 1) {
    return;
  }
  if(isDefined(self.owner))
    self.owner scoreeventpopup(var_0);

  if(!isPlayer(self)) {
    return;
  }
  var_1 = getscoreinfocategory(var_0, "_encstr_AA5B08F5B421339B1359");
  var_2 = getscoreinfocategory(var_0, "_encstr_81EF05D156E1A3");

  if(!isDefined(var_1) || var_1 < 0 || !isDefined(var_2) || var_2 == "_encstr_B40101") {
    return;
  }
  if(!scripts\mp\utility\player::isreallyalive(self) && !self ismlgspectator() && !scripts\mp\utility\player::isusingremote()) {
    queuescoreeventpopup(var_0);
    thread flushscoreeventpopupqueueonspawn();
    return;
  }

  if(!isDefined(self.scoreeventlistsize)) {
    self.scoreeventlistsize = 1;
    thread clearscoreeventlistafterwait();
  } else {
    self.scoreeventlistsize++;

    if(self.scoreeventlistsize > 5) {
      self.scoreeventlistsize = 5;
      return;
    }
  }

  self setclientomnvar("_encstr_93881AD52D7D83F63A9DEB6E8DDB4EAC7D2BD99573D1F5D82D6E1DF5" + self.scoreeventlistindex, var_1);
  self setclientomnvar("_encstr_85231593887F62375896CDFF254317ED81A18AAAB0F1D1" + self.scoreeventlistindex, var_1);
  self setclientomnvar("_encstr_88C91757B4FA9B1BDB9CCAFA56D9AC9B1DFAD8DBE6E839BD8D", self.scoreeventcount % 10);
  self setclientomnvar("_encstr_8CD01CAEB4BE38DB1DECD7371B7B93CAD759D959B947EBD8F69BD1937BB1", self.scoreeventcount % 10);
  self.scoreeventlistindex++;
  self.scoreeventlistindex = self.scoreeventlistindex % 5;
  self.scoreeventcount++;
}

clearscoreeventlistafterwait() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_826C1F8BD14967427FC83AE3903B3B0F40453C09F6B32F8FE9C0F3C9A85B73F210");
  self endon("_encstr_826C1F8BD14967427FC83AE3903B3B0F40453C09F6B32F8FE9C0F3C9A85B73F210");
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 0.5);
  self.scoreeventlistsize = undefined;
}

getrank() {
  var_0 = self.pers["_encstr_851207B317B203FA5A"];
  var_1 = self.pers["_encstr_A51F05CB11A052"];

  if(var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1))
    return var_1;
  else
    return getrankforxp(var_0);
}

rodwatcher(var_0) {
  var_1 = getrankinfomaxxp(level.maxrank);

  if(var_0 >= var_1) {
    var_2 = var_0 - var_1;
    var_3 = int(var_2 / getdvarint("_encstr_97A00AEDF4A97611898B6F27") + 1);
    return var_3;
  }

  return 0;
}

getrankforxp(var_0) {
  var_1 = level.maxrank;

  if(var_0 >= getrankinfominxp(var_1))
    return var_1;
  else
    var_1--;

  while(var_1 > 0) {
    if(var_0 >= getrankinfominxp(var_1) && var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1))
      return var_1;

    var_1--;
  }

  return var_1;
}

getmatchbonusspm() {
  var_0 = getrank() + 1;
  return (3 + var_0 * 0.5) * 10;
}

getprestigelevel() {
  if(isai(self) && isDefined(self.pers["_encstr_ABF70E0EC92BB9E84B76957D33C2B6CA"]))
    return self.pers["_encstr_ABF70E0EC92BB9E84B76957D33C2B6CA"];
  else
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_83250C68679183370209EE7F5D0A");
}

getrankxp() {
  return self.pers["_encstr_851207B317B203FA5A"];
}

registerpickupcreatedcallback() {
  return self.pers["_encstr_A7700D1358473A36B2070BCD3787C1"];
}

safedivide(var_0) {
  if(isDefined(self.pers["_encstr_A7EC09AFBBDF6B0710524A"][var_0]))
    return self.pers["_encstr_A7EC09AFBBDF6B0710524A"][var_0];
  else if(isenumvaluevalid(level.loadoutsgroup, "_encstr_9AA40EC4BD588CF6AED1BA952C07DE9B", var_0))
    return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_BEDE0A8359473B2570B76868", var_0);
  else
    return 0;
}

incrankxp(var_0, var_1, var_2, var_3) {
  if(!level.playerxpenabled) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(!isDefined(level._id_11B53))
    level._id_11B53 = getdvarint("_encstr_847B13A0B74ADEF57A3BAFB8551209068C47709813", 0);

  if(level._id_11B53 > 0 && getrank() + 1 >= level._id_11B53)
    var_0 = 0;

  var_4 = getrankxp();
  var_5 = int(min(var_4 + var_0, getrankinfomaxxp(level.maxrank) - 1));

  if(self.pers["_encstr_A51F05CB11A052"] == level.maxrank && var_5 >= getrankinfomaxxp(level.maxrank))
    var_5 = getrankinfomaxxp(level.maxrank);

  self.pers["_encstr_8E3912E1605F0B3EBBAA7967627F76A9EEDC5F59"] = self.pers["_encstr_8E3912E1605F0B3EBBAA7967627F76A9EEDC5F59"] + var_0;
  self.pers["_encstr_851207B317B203FA5A"] = var_5;
  var_6 = registerpublicevent();
  var_7 = var_0 * var_6;
  var_8 = registerpickupcreatedcallback();
  self.pers["_encstr_A7700D1358473A36B2070BCD3787C1"] = var_8 + var_7;
  var_9 = "_encstr_B40101";

  if(isDefined(var_1)) {
    var_9 = scripts\mp\utility\weapon::relic_nuketimer_globalthread(var_1.basename);
    var_10 = scripts\mp\utility\weapon::getweaponrootname(var_9);
    var_11 = safedivide(var_10);
    self.pers["_encstr_A7EC09AFBBDF6B0710524A"][var_10] = var_11 + var_2;
  }

  var_12 = residuallight();
  var_13 = var_0 * var_12;
  var_14 = relic_award_bullets();
  var_15 = var_0 * var_14;
  var_16 = 1.0;
  var_17 = 1.0;
  var_18 = 1.0;
  var_19 = 1.0;
  var_20 = 1.0;

  if(isDefined(level.rankxpmultipliers) && isDefined(level.rankxpmultipliers["_encstr_B66612EDCDB1B4CD56F56B077DF0839B3658D856"]) && level.rankxpmultipliers["_encstr_B66612EDCDB1B4CD56F56B077DF0839B3658D856"] >= 2)
    var_16 = 2.0;

  if(isDefined(level.weaponrankxpmultipliers) && isDefined(level.weaponrankxpmultipliers["_encstr_AC1A194FFE95C0B01789D8639187FD482A47C5B780FA480E2F52D1"]) && level.weaponrankxpmultipliers["_encstr_AC1A194FFE95C0B01789D8639187FD482A47C5B780FA480E2F52D1"] >= 2)
    var_17 = 2.0;

  if(isDefined(level._id_12133) && isDefined(level._id_12133["_encstr_B40518DE37362DCD957DDBE0ACE4851DBD27EB0FE0B9B1C26395"]) && level._id_12133["_encstr_B40518DE37362DCD957DDBE0ACE4851DBD27EB0FE0B9B1C26395"] >= 2)
    var_19 = 2.0;

  if(isDefined(level.cleanupfunc) && isDefined(level.cleanupfunc["_encstr_AA361B47F548748B85D6625ADB65DB2F7961D0C307D8FD6FA0A95B4223"]) && level.cleanupfunc["_encstr_AA361B47F548748B85D6625ADB65DB2F7961D0C307D8FD6FA0A95B4223"] >= 2)
    var_18 = 2.0;

  if(isDefined(level.halfheight) && isDefined(level.halfheight["_encstr_B1CD14BD9B364BB995F51BC6C2E6EBC338DC6CC26395"]) && level.halfheight["_encstr_B1CD14BD9B364BB995F51BC6C2E6EBC338DC6CC26395"] >= 2)
    var_20 = 2.0;

  var_21 = int(scripts\cp_mp\utility\game_utility::gettimesincegamestart() / 1000.0);
  self reportchallengeuserevent("_encstr_ABD0095B07D716468C3C83", var_0, scripts\mp\teams::lookupcurrentoperator(self.team), var_9, var_2, var_7, int(var_16 * 100.0), int(var_17 * 100.0), int(var_18 * 100.0), var_21, var_13, int(var_19 * 100.0), var_15, int(var_20 * 100.0));
  scripts\mp\analyticslog::_id_119BF(self, var_0, var_9, var_2, var_3);
}

syncxpstat() {
  var_0 = getrankxp();
  var_1 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8CFD0EDD51312A070C8B9AE3B3534F65", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_B607032B8B");

  if(var_1 > var_0) {
    return;
  }
  self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8CFD0EDD51312A070C8B9AE3B3534F65", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_B607032B8B", var_0);
}

delayplayerscorepopup(var_0, var_1, var_2) {
  wait(var_0);
  thread scripts\mp\utility\points::giveunifiedpoints(var_1);
}

getgametypexpmultiplier() {
  if(!isDefined(level.gametypexpmodifier)) {
    var_0 = getdvarfloat("_encstr_91011E1BB71B4F9DFEF06BC849F107ED0B9F192B67234099077D07F6BA54F22D", 1.0);

    if(var_0 != 1.0)
      level.gametypexpmodifier = var_0;
    else
      level.gametypexpmodifier = float(tablelookup("_encstr_A107165A83180FCEF06BDCC959E8128B57B9C242E08687C3", 0, scripts\mp\utility\game::getgametype(), 17));
  }

  return level.gametypexpmodifier;
}

addglobalrankxpmultiplier(var_0, var_1) {
  level addrankxpmultiplier(var_0, var_1);
}

getglobalrankxpmultiplier() {
  var_0 = level getrankxpmultiplier();
  var_1 = getdvarint("_encstr_968F1ACD6CC9D7C82DDCB098C656F51E0EAFE6C685C656D717BA4BD1", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1)
    exitlevel(0);

  return var_0;
}

addrankxpmultiplier(var_0, var_1) {
  var_2 = 4 / level getrankxpmultiplier();

  if(var_0 > var_2) {
    return;
  }
  if(!isDefined(self.rankxpmultipliers))
    self.rankxpmultipliers = [];

  if(isDefined(self.rankxpmultipliers[var_1]))
    self.rankxpmultipliers[var_1] = max(self.rankxpmultipliers[var_1], var_0);
  else
    self.rankxpmultipliers[var_1] = var_0;
}

getrankxpmultiplier() {
  if(!isDefined(self.rankxpmultipliers))
    return 1.0;

  var_0 = 1.0;

  foreach(var_2 in self.rankxpmultipliers) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_0 = var_0 * var_2;
  }

  return var_0;
}

respawntagsfreed() {
  if(self resetclientkillstreakindexes())
    return getbnetigrweaponxpmultiplier();
  else if(self isps4player()) {
    var_0 = getdvarfloat("_encstr_8FD80B3949012245CBAFE98589", 1.0);
    return var_0;
  }

  return 1.0;
}

removeglobalrankxpmultiplier(var_0) {
  level removerankxpmultiplier(var_0);
}

removerankxpmultiplier(var_0) {
  if(!isDefined(self.rankxpmultipliers)) {
    return;
  }
  if(!isDefined(self.rankxpmultipliers[var_0])) {
    return;
  }
  self.rankxpmultipliers[var_0] = undefined;
}

addteamrankxpmultiplier(var_0, var_1, var_2) {
  if(!level.teambased)
    var_1 = "_encstr_AF1904A7F929";

  if(!isDefined(self.teamrankxpmultipliers))
    level.teamrankxpmultipliers = [];

  if(!isDefined(level.teamrankxpmultipliers[var_1]))
    level.teamrankxpmultipliers[var_1] = [];

  if(isDefined(level.teamrankxpmultipliers[var_1][var_2]))
    level.teamrankxpmultipliers[var_1][var_2] = max(self.teamrankxpmultipliers[var_1][var_2], var_0);
  else
    level.teamrankxpmultipliers[var_1][var_2] = var_0;
}

removeteamrankxpmultiplier(var_0, var_1) {
  if(!level.teambased)
    var_0 = "_encstr_AF1904A7F929";

  if(!isDefined(level.teamrankxpmultipliers)) {
    return;
  }
  if(!isDefined(level.teamrankxpmultipliers[var_0])) {
    return;
  }
  if(!isDefined(level.teamrankxpmultipliers[var_0][var_1])) {
    return;
  }
  level.teamrankxpmultipliers[var_0][var_1] = undefined;
}

getteamrankxpmultiplier(var_0) {
  if(!level.teambased)
    var_0 = "_encstr_AF1904A7F929";

  if(!isDefined(var_0) || !isDefined(level.teamrankxpmultipliers) || !isDefined(level.teamrankxpmultipliers[var_0]))
    return 1.0;

  var_1 = 1.0;

  foreach(var_3 in level.teamrankxpmultipliers[var_0]) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1 = var_1 * var_3;
  }

  return var_1;
}

risktokensbanked() {
  if(!isDefined(level._id_12751))
    level._id_12751 = getdvarfloat("_encstr_8E7017FE9E63FF3354B7E040BF638B476BC26006768A515912", 1.0);

  return level._id_12751;
}

getrankxpmultipliertotal() {
  var_0 = getrankxpmultiplier();
  var_1 = getglobalrankxpmultiplier();
  var_2 = getteamrankxpmultiplier(self.team);
  var_3 = respawntagsfreed();
  var_4 = risktokensbanked();
  var_5 = scripts\engine\utility::ter_op(_func_043E(self), 1.1, 1.0);
  var_6 = var_0 * var_1 * var_2 * var_3 * var_4 * var_5;
  return var_6;
}

round_spawn_bombers(var_0, var_1) {
  var_2 = 0;
  var_2 = var_2 + calculate_path_struct(var_0, var_1);
  return var_2;
}

calculate_path_struct(var_0, var_1) {
  var_2 = 0;

  if(var_0 == "_encstr_ABD70578F3D02C") {
    var_3 = isDefined(var_1) && var_1 hasattachment("_encstr_AA210BC97B46A89D1397FFB993", 1) || scripts\mp\utility\perk::_hasperk("_encstr_8CED153FA88FC87B4F02339A593F2DF8621585871F3098");

    if(var_3)
      var_2 = var_2 + 20;
  }

  return var_2;
}

battle_tracks_playerinlisteningzoneinternal(var_0, var_1) {
  level battle_tracks_gettogglestate(var_0, var_1);
}

remindermessage() {
  var_0 = level registerpreviousprop();
  var_1 = getdvarint("_encstr_968F1ACD6CC9D7C82DDCB098C656F51E0EAFE6C685C656D717BA4BD1", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1)
    exitlevel(0);

  return var_0;
}

battle_tracks_gettogglestate(var_0, var_1) {
  var_2 = 4 / level registerpreviousprop();

  if(var_0 > var_2) {
    return;
  }
  if(!isDefined(self.cleanupfunc))
    self.cleanupfunc = [];

  if(isDefined(self.cleanupfunc[var_1]))
    self.cleanupfunc[var_1] = max(self.cleanupfunc[var_1], var_0);
  else
    self.cleanupfunc[var_1] = var_0;
}

registerpreviousprop() {
  if(!isDefined(self.cleanupfunc))
    return 1.0;

  var_0 = 1.0;

  foreach(var_2 in self.cleanupfunc) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_0 = var_0 * var_2;
  }

  return var_0;
}

registerpublicevent() {
  var_0 = registerpreviousprop();
  var_1 = remindermessage();
  var_2 = radiusdamagestepped(self);
  var_3 = var_0 * var_1 * var_2;
  return var_3;
}

battle_tracks_playerselectrandomtracks(var_0, var_1) {
  level battle_tracks_togglestateis(var_0, var_1);
}

remove_bank_lbravos() {
  var_0 = level resetvisionsetnighttodefault();
  var_1 = getdvarint("_encstr_968F1ACD6CC9D7C82DDCB098C656F51E0EAFE6C685C656D717BA4BD1", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1)
    exitlevel(0);

  return var_0;
}

battle_tracks_togglestateis(var_0, var_1) {
  var_2 = 4 / level resetvisionsetnighttodefault();

  if(var_0 > var_2) {
    return;
  }
  if(!isDefined(self._id_12133))
    self._id_12133 = [];

  if(isDefined(self._id_12133[var_1]))
    self._id_12133[var_1] = max(self._id_12133[var_1], var_0);
  else
    self._id_12133[var_1] = var_0;
}

residuallight() {
  var_0 = resetvisionsetnighttodefault();
  var_1 = remove_bad_loot_drops();
  var_2 = respawntagsfreed();
  var_3 = risktokensbanked();
  var_4 = scripts\engine\utility::ter_op(_func_043E(self), 1.1, 1.0);
  var_5 = var_0 * var_1 * var_2 * var_3 * var_4;
  return var_5;
}

resetvisionsetnighttodefault() {
  if(!isDefined(self._id_12133))
    return 1.0;

  var_0 = 1.0;

  foreach(var_2 in self._id_12133) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_0 = var_0 * var_2;
  }

  return var_0;
}

remove_bad_loot_drops() {
  return level resetvisionsetnighttodefault();
}

battle_tracks_playerinsidezone(var_0, var_1) {
  level battle_tracks_hasemptybattletracks(var_0, var_1);
}

remove_assault_class() {
  var_0 = level relic_amped_wait_till_revived();
  var_1 = getdvarint("_encstr_968F1ACD6CC9D7C82DDCB098C656F51E0EAFE6C685C656D717BA4BD1", 0) == 0;

  if((var_0 > 4 || var_0 < 0) && var_1)
    exitlevel(0);

  return var_0;
}

battle_tracks_hasemptybattletracks(var_0, var_1) {
  var_2 = 4 / level relic_amped_wait_till_revived();

  if(var_0 > var_2) {
    return;
  }
  if(!isDefined(self.halfheight))
    self.halfheight = [];

  if(isDefined(self.halfheight[var_1]))
    self.halfheight[var_1] = max(self.halfheight[var_1], var_0);
  else
    self.halfheight[var_1] = var_0;
}

relic_award_bullets() {
  var_0 = relic_amped_wait_till_revived();
  var_1 = remote_tank_think();
  var_2 = respawntagsfreed();
  var_3 = risktokensbanked();
  var_4 = scripts\engine\utility::ter_op(_func_043F(self), 1.0, 0);
  var_5 = scripts\engine\utility::ter_op(_func_043E(self), 1.1, 1.0);
  var_6 = var_0 * var_1 * var_2 * var_3 * var_4 * var_5;
  return var_6;
}

relic_amped_wait_till_revived() {
  if(!isDefined(self.halfheight))
    return 1.0;

  var_0 = 1.0;

  foreach(var_2 in self.halfheight) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_0 = var_0 * var_2;
  }

  return var_0;
}

remote_tank_think() {
  return level relic_amped_wait_till_revived();
}