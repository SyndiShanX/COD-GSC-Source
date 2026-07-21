/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\class.gsc
***********************************************/

init() {
  level.classmap["_encstr_AB8007922817677232"] = 0;
  level.classmap["_encstr_A78007C63685CD3789"] = 1;
  level.classmap["_encstr_A18007BB31E23313B5"] = 2;
  level.classmap["_encstr_A70708DF6DCAB0B8BF17"] = 0;
  level.classmap["_encstr_A307088717F8DDDD407F"] = 1;
  level.classmap["_encstr_930708BF0DAAD0D8DF57"] = 2;
  level.classmap["_encstr_9107083785324850579F"] = 3;
  level.classmap["_encstr_8F0708D09B1239386FD5"] = 4;
  level.classmap["_encstr_B80708569588A8800563"] = 5;
  level.classmap["_encstr_AC07087767838DC0AD0B"] = 6;
  level.classmap["_encstr_BE07082645E74367A0D2"] = 7;
  level.classmap["_encstr_8E0708864DF7B39F1DDF"] = 8;
  level.classmap["_encstr_9375099857F3F3A7A2227F"] = 9;
  level.classmap["_encstr_8D550D5AB82303913579EE03EFFBEF"] = 0;
  level.classmap["_encstr_A5550D2CC3B4CDFAE459B1A5C1AC23"] = 1;
  level.classmap["_encstr_86550D77D8522756CA27B0E85BF5E3"] = 2;
  level.classmap["_encstr_BA550DB0E15A6EFA4E598D9607B268"] = 3;
  level.classmap["_encstr_A9550D58C3A56ED793568D96C1CA4D"] = 4;
  level.classmap["_encstr_8C550D2C0F5A9B7DC92B365A1CAC63"] = 5;
  level.classmap["_encstr_8F800F27CA0AC0B543DE931DA1F3137D72"] = 0;
  level.classmap["_encstr_B8800FD06D7BC43D56211B8DA6082A52D7"] = 1;
  level.classmap["_encstr_AC800FF03AE5D3A9C74F2EAD4B9733839A"] = 2;
  level.classmap["_encstr_BE800F0FE88DF9C27F303AF70613CBBD63"] = 3;
  level.classmap["_encstr_8E800FF383F28310339103F98601F0CDDF"] = 4;
  level.classmap["_encstr_82800F21CABBB32822A71523838C480D6A"] = 5;
  level.classmap["_encstr_AAAC09D09972B9C83F2B7F"] = 0;
  level.classmap["_encstr_A90B0D7BF38003BF978062EAA87DCF"] = 0;
  level.classmap["_encstr_B6DC0ED85D37479D2C5B566BDBC89589"] = 0;
  level.classmap["_encstr_B4DC0ED6B5F7537F3148BF8740C9357F"] = 1;
  level.classmap["_encstr_95DC0E695B7BA8BC02AFEBF38F7AF5CA"] = 2;
  level.classmap["_encstr_85DC0EB22B3E5B579843C5C56F989F02"] = 3;
  level.classmap["_encstr_8ADC0E1BD5B98ECEB0D659ADB78C956A"] = 4;
  level.classmap["_encstr_84DC0E42054B4B7AE760214B9F88A943"] = 5;
  level.classmap["_encstr_B2DC0E7A2FAFCBA7A3EB99855F12D51A"] = 6;
  level.classmap["_encstr_81DC0E8DAEB9479D16D6CAADDE8C2B70"] = 7;
  level.classmap["_encstr_AADC0EFF532B5B8796B5A1382050C7DA"] = 8;
  level.classmap["_encstr_B4130F88C34A717127C51D01AF5B7983E2"] = 9;
  level.classmap["_encstr_A17A10F0BB3219197F6DB5B977B381875F47"] = 0;
  level.classmap["_encstr_A77A10BA206F9B1F51C11505E8D9DFE9F9B2"] = 1;
  level.classmap["_encstr_AB7A104B9D4BF3C7DB785AD28039BFA74126"] = 2;
  level.classmap["_encstr_997A10B1579BD1D9856BACB6F6C8ACBE911A"] = 3;
  level.classmap["_encstr_9B7A10365517B39FD1689FA760A955C981CD"] = 4;
  level.classmap["_encstr_A7AA09C616D81B26586CB5"] = 0;
  level.classmap["_encstr_A5450947E0B60E5060CB6B"] = 0;
  level.classmap["_encstr_8345096F85A579A798F922"] = 1;
  level.classmap["_encstr_8B45098A61FC578BB809DB"] = 2;
  level.classmap["_encstr_99450998AF6D91B5706B1C"] = 3;
  level.classmap["_encstr_9B4509237F5259BDAD53AD"] = 4;
  level.classmap["_encstr_A74509851A62C7E8F1E136"] = 5;
  level.classmap["_encstr_AB450911C7C6A81D6A63D7"] = 6;
  level.classmap["_encstr_9345094255FBAA9BB8CB08"] = 7;
  level.classmap["_encstr_A145098DE7DA7B1BDC7B6A"] = 8;
  level.classmap["_encstr_ADCC0A0C40507380E98383F2"] = 9;
  level.classmap["_encstr_85CC0AAB10F1211391751A12"] = 10;
  level.classmap["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"] = 0;
  level.defaultclass = "_encstr_A5C70EAF9C49C71B915F2F46E7D5397C";

  if(getdvarint("_encstr_8CA11BD05F05A7183259B84BD1811C3B5A884B10BB44B78BF290D37C7B", 0))
    level.classtablename = "_encstr_84EC21C21B80970528CF434C83584DF7C031AB69210D4BBE50C95C1F83189212768B63";
  else if(level.gametype == "_encstr_B607038AAB" || level.gametype == "_encstr_931D068662634370")
    level.classtablename = "_encstr_92501DDA07F2D88D85CD6E4716266395BE31E4F591593316EA363AB81B6ED9";
  else if(scripts\mp\utility\game::tv_station_intro_camera()) {
    var_0 = getdvarint("_encstr_B1B5186E0EF36FA1A44720287BC1D9512AB9E874670BFD28944F", 0);

    switch (var_0) {
      case 1:
        level.classtablename = "_encstr_B6C51F15770F623471F8A7A370C9FCCA170E5D8CDF332B53DE30DBCB5868ABD3ED";
        break;
      default:
        level.classtablename = "_encstr_B8F812C3DBEEAE4049F25BB31E3238D5960F774D";
        break;
    }

    setomnvar("_encstr_96B1177D4BA16109B60B1F343FF865405787AB2D0AB32C0D42", var_0);
  } else if(getdvarint("_encstr_8FF112A33F9B792935E3137F6ABA17EF22531BDA", 0))
    level.classtablename = "_encstr_A7F9176B385E8D8D2C6EDC475898B156AF472BE61D171BE667";
  else if(scripts\mp\utility\game::isanymlgmatch())
    level.classtablename = "_encstr_8734160AD3486FFDE0178B74CB1305BF982912A2B0365733";
  else
    level.classtablename = "_encstr_B8F812C3DBEEAE4049F25BB31E3238D5960F774D";

  level thread onplayerconnecting();
  level thread onplayerspawned();
}

getclasschoice(var_0) {
  return var_0;
}

getweaponchoice(var_0) {
  var_1 = strtok(var_0, "_encstr_964C0249");

  if(var_1.size > 1)
    return int(var_1[1]);
  else
    return 0;
}

cac_getweapon(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_AC20072B9FA9487832");
}

cac_getweaponattachment(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_BA6F1012A0E9A677F8598D8EEDA757AB4318", var_2, "_encstr_B19A0BD803A4E10F42E50598BB");
}

force_interrupt_current_combat_action(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_BA6F1012A0E9A677F8598D8EEDA757AB4318", var_2, "_encstr_8A3E0A0D67C353E09EEBD48D");
}

cac_getweaponlootitemid(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_8DE00B8DF6DBA34AD1B2D64A88");
}

cac_getweaponvariantid(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_8A3E0A0D67C353E09EEBD48D");
}

cac_getweaponcamo(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_B19005D885B5F6");
}

cac_getweaponreticle(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_925008E456475A6CB195");
}

cac_getkillstreak(var_0, var_1) {
  var_2 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_99CD115A4808DC6A332BEF20D0BF5D93CD07E3", var_0, "_encstr_85CE0B9770B02C73A1760F06D2");
  return var_2;
}

cac_getcharacterarchetype() {
  if(isDefined(self.changedarchetypeinfo))
    return self.changedarchetypeinfo.archetype;

  return "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
}

cac_getequipmentprimary(var_0) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A68810D2AB3D2F92F853CEDC1790DB07E783", 0, "_encstr_BE8F0A272F9B2BE97268AE8B");
}

cac_getextraequipmentprimary(var_0) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A68810D2AB3D2F92F853CEDC1790DB07E783", 0, "_encstr_8E770C58F36B9D518FE03FAEC73F");
}

cac_getequipmentsecondary(var_0) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A68810D2AB3D2F92F853CEDC1790DB07E783", 1, "_encstr_BE8F0A272F9B2BE97268AE8B");
}

cac_getextraequipmentsecondary(var_0) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A68810D2AB3D2F92F853CEDC1790DB07E783", 1, "_encstr_8E770C58F36B9D518FE03FAEC73F");
}

cac_getsuper() {
  if(isDefined(self.changedarchetypeinfo))
    return self.changedarchetypeinfo.super;

  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_AB010F01B25370857BA7A99B17335750FA");
}

cac_getfieldupgrade(var_0) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_A6F60EC2E12B524B9F7AB11EF9D1C543", var_0);
}

cac_getgesture() {
  var_0 = "_encstr_8BBA05185F8B99";

  if(isDefined(self.changedarchetypeinfo)) {
    var_1 = level.archetypeids[self.changedarchetypeinfo.archetype];
    var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_84B415C293C6D0B2D15EC1CAA039AC33B2C995E6C6B2CD", var_1, "_encstr_8F0508CE59DCA357392B");
  } else
    var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8F0508CE59DCA357392B");

  return scripts\cp_mp\gestures::getgesturedata(var_0);
}

cac_getaccessoryweapon() {
  var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8AB00E403B67A5699B3F6EF409A31159");
  return scripts\mp\accessories::getaccessoryweaponbyindex(var_0);
}

cac_getaccessorydata() {
  var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8AB00E403B67A5699B3F6EF409A31159");
  return scripts\mp\accessories::getaccessorydatabyindex(var_0);
}

force_interrupt_all_current_combat_actions() {
  var_0 = self getplayerdata(level.loadoutsgroup, "_encstr_A97E13D0EB9813572253E03BDC5A98E3720DE3F30A", "_encstr_8AB00E403B67A5699B3F6EF409A31159");
  return scripts\mp\accessories::register_respawn_functions(var_0);
}

cac_getloadoutperk(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_86CB0DFB97F7022F90BB3A7F53487B", var_1);
}

cac_getloadoutextraperk(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_88350B3DCA135B1A8FAA969243", var_1);
}

cac_getloadoutarchetypeperk() {
  if(isDefined(self.changedarchetypeinfo))
    return self.changedarchetypeinfo.trait;

  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_81C90E0E1B48381A7DB3FBA789AD3363");
}

cac_getusingspecialist(var_0) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1F1105D9BA5E69D350E59B1B4856396B947");
}

cac_getweaponcosmeticattachment(var_0, var_1) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_88AC1316CD5A9A3BEBCB973F34541E073007CDED93");
}

cac_getweaponsticker(var_0, var_1, var_2) {
  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_96B309644842810FB3EB1F", var_0, "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", var_1, "_encstr_929E081F5412E20869BD", var_2);
}

recipe_getkillstreak(var_0, var_1, var_2) {
  return scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_0, var_1, "_encstr_959506B911C79707", "_encstr_92671047270112C372B96652DED3714543B7", var_2, "_encstr_85CE0B9770B02C73A1760F06D2");
}

table_getarchetype(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1", var_1 + 1);
}

table_getloadoutname(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_ADDA0C81370E70F89F03F419FAB7", var_1 + 1);
}

_id_139E4(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(var_2 == 0, "_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3", "_encstr_99B2286888EADCAFF83B919362D82E502F18AB292D5116D86759C01D572BA8F0931B51BA61DDA87533DF");
  var_4 = tablelookup(var_0, 0, var_3, var_1 + 1);

  if(var_4 == "_encstr_B40101")
    return 0;
  else
    return istrue(int(var_4));
}

table_getweapon(var_0, var_1, var_2) {
  if(var_2 == 0)
    return tablelookup(var_0, 0, "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243", var_1 + 1);
  else
    return tablelookup(var_0, 0, "_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B", var_1 + 1);
}

table_getweaponattachment(var_0, var_1, var_2, var_3) {
  var_4 = "_encstr_8BBA05185F8B99";

  if(var_2 == 0)
    var_4 = tablelookup(var_0, 0, "_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878" + (var_3 + 1), var_1 + 1);
  else
    var_4 = tablelookup(var_0, 0, "_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB" + (var_3 + 1), var_1 + 1);

  if(var_4 == "_encstr_B40101" || var_4 == "_encstr_8BBA05185F8B99")
    return "_encstr_8BBA05185F8B99";
  else
    return var_4;
}

table_getweaponcamo(var_0, var_1, var_2) {
  if(var_2 == 0)
    return tablelookup(var_0, 0, "_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED", var_1 + 1);
  else
    return tablelookup(var_0, 0, "_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560", var_1 + 1);
}

table_getweaponreticle(var_0, var_1, var_2) {
  if(var_2 == 0)
    return tablelookup(var_0, 0, "_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3", var_1 + 1);
  else
    return tablelookup(var_0, 0, "_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D", var_1 + 1);
}

_id_139E6(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(var_2 == 0)
    var_4 = tablelookup(var_0, 0, "_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222", var_1 + 1);
  else
    var_4 = tablelookup(var_0, 0, "_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75", var_1 + 1);

  return _id_139E7(var_3, var_4);
}

_id_139E7(var_0, var_1) {
  if(var_0 == "_encstr_8BBA05185F8B99")
    return 0;

  if(!isDefined(level.confirm_good_pickup_location)) {
    level.confirm_good_pickup_location = [];
    level.confirm_good_pickup_location["_encstr_AC940FE7036051A1F8304BA6AEFCB82AB6"] = [1];
    level.confirm_good_pickup_location["_encstr_8C160DAFE71BF161681EB5BCB0F8FC"] = [5];
    level.confirm_good_pickup_location["_encstr_99550F225BABC7E65077BBB13990FBCE96"] = [3];
    level.confirm_good_pickup_location["_encstr_BDF710419C225F46FDE93B32B8337A6BE00D"] = [3];
    level.confirm_good_pickup_location["_encstr_826B0D691C902EABB02913EB9F638B"] = [4];
    level.confirm_good_pickup_location["_encstr_A96310D2BBC1F5B9A1AF27B7B5B27BE09B06"] = [5];
    level.confirm_good_pickup_location["_encstr_A1E70FBB8CDA89535851E1C3D9EB66A97A"] = [3];
    level.confirm_good_pickup_location["_encstr_ABCD0F5A770EF5C6ADAF6BCEB7B199990D"] = [4];
    level.confirm_good_pickup_location["_encstr_A52C0E7020307103407898128DC7C6CB"] = [16];
    level.confirm_good_pickup_location["_encstr_B4190F4BDDC1BE9BB9D70BB10786584D0C"] = [2];
    level.confirm_good_pickup_location["_encstr_A32A0FA7EFE3098B8006FCC79BB0ADE210"] = [4];
    level.confirm_good_pickup_location["_encstr_8BE20ED75722A6731BF84F3064CA126B"] = [3];
    level.confirm_good_pickup_location["_encstr_8D900DB477077D1C2DD736E0C28385"] = [15];
    var_2 = getDvar("_encstr_BDCE1EB98DE4BE4C1BF61BB55923A1630BB9CD5116131BB259C2E4962C9BA3CD", "_encstr_B40101");

    if(var_2 != "_encstr_B40101") {
      var_3 = strtok(var_2, "_encstr_964C0249");

      foreach(var_5 in var_3) {
        var_6 = strtok(var_5, "_encstr_854C021F");

        if(var_6.size == 2) {
          var_7 = var_6[0];
          var_8 = int(var_6[1]);

          if(!isDefined(level.confirm_good_pickup_location[var_7]))
            level.confirm_good_pickup_location[var_7] = [];

          level.confirm_good_pickup_location[var_7][level.confirm_good_pickup_location[var_7].size] = var_8;
        }
      }
    }
  }

  var_10 = undefined;

  if(isDefined(level.confirm_good_pickup_location[var_0]))
    var_10 = level.confirm_good_pickup_location[var_0];

  var_11 = 0;
  var_12 = getdvarint("_encstr_832821687F8206251242667D167A73CBEBDB7078EB2DFFE32BAC6FF0B3B1BB90249F68", 0);

  if(var_12 == 1)
    var_11 = scripts\mp\utility\weapon::runspawnmodule_isolated(var_0, var_10);
  else {
    var_13 = strtok(var_1, "_encstr_974C0246");
    var_14 = [];

    foreach(var_16 in var_13) {
      var_17 = int(var_16);

      if(!isDefined(var_10) || !scripts\engine\utility::array_contains(var_10, var_17))
        var_14[var_14.size] = var_17;
    }

    if(var_14.size != 0)
      var_11 = var_14[randomint(var_14.size)];
  }

  if(var_11 == -1)
    var_11 = scripts\mp\utility\weapon::runspawnmodule_isolated(var_0, var_10);

  var_19 = scripts\mp\utility\weapon::_id_1458C(var_0, var_11);

  if(!var_19)
    var_11 = 0;

  return var_11;
}

table_getperk(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "_encstr_AD0E0C49FFD6A830573B7FC143F7" + (var_2 + 1), var_1 + 1);
}

table_getextraperk(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "_encstr_8EAD11E1576E1098FF63B51A4BCB476987A217" + (var_2 + 1), var_1 + 1);
}

table_getequipmentprimary(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB", var_1 + 1);
}

table_getextraequipmentprimary(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "_encstr_B8141D4CD0C932385B1BE7E9D1C8DFF773FB94EB1541184BFFBAB38186438B", var_1 + 1);
  return isDefined(var_2) && var_2 == "_encstr_AAEF05B9394BAB";
}

table_getequipmentsecondary(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B", var_1 + 1);
}

table_getextraequipmentsecondary(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "_encstr_8EA71F285227ADE0CBE403710CF268F58F6B2D13DA6FD0706ACD57A70E5F203617", var_1 + 1);
  return isDefined(var_2) && var_2 == "_encstr_AAEF05B9394BAB";
}

table_getsuper(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_85920D9D304BCAFF3B38EF7F3011BA", var_1 + 1);
}

table_getspecialist(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, "_encstr_A1AF127930DEA598DB6B4723D21841095413CABD", var_1 + 1);
  return isDefined(var_2) && var_2 == "_encstr_AAEF05B9394BAB";
}

table_getgesture(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_B4450F51E53FE10F4B0C1791B7ABED8085", var_1 + 1);
}

table_getaccessory(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_A705111CF85BBB97531BE8D8909F9B1B570231", var_1 + 1);
}

table_getexecution(var_0, var_1) {
  return tablelookup(var_0, 0, "_encstr_81E6112CD2D9B12F700387D0E8A7C32341A7DD", var_1 + 1);
}

table_getkillstreak(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, "_encstr_8AA50E70256120B05BC3BFC9E3628F10" + var_2, var_1 + 1);
}

loadout_getplayerstreaktype(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_B4E513336362CD0ED87B23A707319FB3DA1B98ABA0":
      var_1 = "_encstr_B29108FB78F3394A7385";
      break;
    case "_encstr_AA2F166B1B7A20BFA2CBD3C9A7C9FED005B650A185D958ED":
    case "_encstr_BAAE0B0FF9C056F999C9F4D008":
      var_1 = "_encstr_BAAE0B0FF9C056F999C9F4D008";
      break;
    case "_encstr_A5B514FB55DD15C3A26C581735C7CB208BC265158F1F":
      var_1 = "_encstr_9A040910D25A57235BFB2D";
      break;
    default:
      var_1 = "_encstr_AB3508737F830710ACDB";
  }

  return var_1;
}

getloadoutstreaktypefromstreaktype(var_0) {
  if(!isDefined(var_0))
    return "_encstr_ABB313CD4793CA16B5A3CB38B27D0BCD9B165DC6D1";

  switch (var_0) {
    case "_encstr_B29108FB78F3394A7385":
      return "_encstr_B4E513336362CD0ED87B23A707319FB3DA1B98ABA0";
    case "_encstr_BAAE0B0FF9C056F999C9F4D008":
      return "_encstr_AA2F166B1B7A20BFA2CBD3C9A7C9FED005B650A185D958ED";
    case "_encstr_AB3508737F830710ACDB":
      return "_encstr_ABB313CD4793CA16B5A3CB38B27D0BCD9B165DC6D1";
    default:
      return "_encstr_ABB313CD4793CA16B5A3CB38B27D0BCD9B165DC6D1";
  }
}

loadout_getclassteam(var_0) {
  if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    var_0 = "_encstr_8BBA05185F8B99";

  var_1 = undefined;

  if(issubstr(var_0, "_encstr_8E8405EA382B2A"))
    var_1 = "_encstr_8E8405EA382B2A";
  else if(issubstr(var_0, "_encstr_9A8507BA4040188D08"))
    var_1 = "_encstr_9A8507BA4040188D08";
  else
    var_1 = "_encstr_8BBA05185F8B99";

  return var_1;
}

loadout_clearplayer(var_0) {
  loadout_clearweapons(var_0);
  _detachall(var_0);
  scripts\mp\equipment::clearallequipment();

  if(isDefined(self.loadoutarchetype))
    clearscriptable();

  scripts\mp\archetypes\archcommon::removearchetype(self.loadoutarchetype);
  loadout_clearperks(var_0);
  scripts\mp\perks\weaponpassives::forgetpassives();
  scripts\cp_mp\gestures::cleargesture();
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\accessories::clearplayeraccessory();
  scripts\mp\perks\perkpackage::_id_12301();

  if(!istrue(var_0)) {
    resetfunctionality();
    resetactionslots();
  }
}

loadout_clearweapons(var_0) {
  if(istrue(var_0)) {
    if(isDefined(self.primaryweaponobj))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.primaryweaponobj);

    if(isDefined(self.secondaryweaponobj) && self.secondaryweaponobj.basename != "_encstr_8BBA05185F8B99")
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.secondaryweaponobj);
  } else
    self takeallweapons();

  self.primaryweapon = undefined;
  self.primaryweaponobj = undefined;
  self.secondaryweapon = undefined;
  self.secondaryweaponobj = undefined;
}

loadout_giveperk(var_0) {
  if(!isDefined(self.loadoutperks))
    self.loadoutperks = [];

  scripts\mp\utility\perk::giveperk(var_0);
  self.loadoutperks[self.loadoutperks.size] = var_0;
}

loadout_removeperk(var_0) {
  if(isDefined(self.loadoutperks)) {
    var_1 = 0;
    var_2 = [];

    foreach(var_4 in self.loadoutperks) {
      if(!var_1) {
        if(var_4 == var_0) {
          scripts\mp\utility\perk::removeperk(var_4);
          var_1 = 1;
          continue;
        }
      }

      var_2[var_2.size] = var_4;
    }

    self.loadoutperks = var_2;
  }
}

loadout_clearperks(var_0) {
  if(istrue(var_0)) {
    if(isDefined(self.loadoutperks)) {
      foreach(var_2 in self.loadoutperks)
      scripts\mp\utility\perk::removeperk(var_2);
    }
  } else {
    scripts\mp\perks\perks::_clearperks();
    self notify("_encstr_ADB9121B6B1A70608D729893D1737895228B9BA9");
  }

  self.loadoutperks = [];
  self notify("_encstr_958B16B1DBC232DBD51DBE0E2B39ADCD7D1B1B5916275619");
}

loadout_getclassstruct() {
  var_0 = spawnStruct();
  var_0.loadoutarchetype = "_encstr_8BBA05185F8B99";
  var_0.loadoutprimary = "_encstr_8BBA05185F8B99";
  var_0.loadoutprimaryattachments = [];
  var_0.loadoutprimaryattachmentids = [];

  for(var_1 = 0; var_1 < 10; var_1++) {
    var_0.loadoutprimaryattachments[var_1] = "_encstr_8BBA05185F8B99";
    var_0.loadoutprimaryattachmentids[var_1] = 0;
  }

  var_0.loadoutprimarycamo = "_encstr_8BBA05185F8B99";
  var_0.loadoutprimaryreticle = "_encstr_8BBA05185F8B99";
  var_0.loadoutprimarylootitemid = 0;
  var_0.loadoutprimaryvariantid = -1;
  var_0.loadoutprimarycosmeticattachment = "_encstr_8BBA05185F8B99";
  var_0.loadoutprimarystickers = [];

  for(var_2 = 0; var_2 < 4; var_2++)
    var_0.loadoutprimarystickers[var_2] = "_encstr_8BBA05185F8B99";

  var_0.loadoutsecondary = "_encstr_8BBA05185F8B99";
  var_0.loadoutsecondaryattachments = [];
  var_0.loadoutsecondaryattachmentids = [];

  for(var_1 = 0; var_1 < 10; var_1++) {
    var_0.loadoutsecondaryattachments[var_1] = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondaryattachmentids[var_1] = 0;
  }

  var_0.loadoutsecondarycamo = "_encstr_8BBA05185F8B99";
  var_0.loadoutsecondaryreticle = "_encstr_8BBA05185F8B99";
  var_0.loadoutsecondarylootitemid = 0;
  var_0.loadoutsecondaryvariantid = -1;
  var_0.loadoutsecondarycosmeticattachment = "_encstr_8BBA05185F8B99";
  var_0.loadoutsecondarystickers = [];

  for(var_2 = 0; var_2 < 4; var_2++)
    var_0.loadoutsecondarystickers[var_2] = "_encstr_8BBA05185F8B99";

  var_0.loadoutmeleeslot = "_encstr_8BBA05185F8B99";
  var_0.loadoutperksfromgamemode = 0;
  var_0.loadoutperks = [];
  var_0.loadoutstandardperks = [];
  var_0.loadoutextraperks = [];
  var_0.loadoutrigtrait = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";
  var_0.loadoutusingspecialist = 0;
  var_0.loadoutequipmentprimary = "_encstr_8BBA05185F8B99";
  var_0.loadoutextraequipmentprimary = 0;
  var_0.loadoutequipmentsecondary = "_encstr_8BBA05185F8B99";
  var_0.loadoutextraequipmentsecondary = 0;
  var_0.loadoutsuper = "_encstr_8BBA05185F8B99";
  var_0.loadoutgesture = "_encstr_8BBA05185F8B99";
  var_0.loadoutaccessorydata = "_encstr_8BBA05185F8B99";
  var_0.loadoutaccessoryweapon = "_encstr_8BBA05185F8B99";
  var_0.loadoutstreaksfilled = 0;
  var_0.loadoutstreaktype = "_encstr_ABB313CD4793CA16B5A3CB38B27D0BCD9B165DC6D1";
  var_0.loadoutkillstreak1 = "_encstr_8BBA05185F8B99";
  var_0.loadoutkillstreak2 = "_encstr_8BBA05185F8B99";
  var_0.loadoutkillstreak3 = "_encstr_8BBA05185F8B99";
  var_0.tweakedbyplayerduringmatch = 0;
  var_0.gamemodeforcednewloadout = 0;
  var_0.uavbestid = 0;
  return var_0;
}

zombieregenratescaleingas(var_0) {
  var_1 = spawnStruct();
  var_1.loadoutarchetype = var_0.loadoutarchetype;

  if(isDefined(var_0._id_11960))
    var_1._id_11960 = var_0._id_11960;

  var_1.loadoutprimary = var_0.loadoutprimary;
  var_1.loadoutprimaryattachments = var_0.loadoutprimaryattachments;
  var_1.loadoutprimaryattachmentids = var_0.loadoutprimaryattachmentids;
  var_1.loadoutprimarycamo = var_0.loadoutprimarycamo;
  var_1.loadoutprimaryreticle = var_0.loadoutprimaryreticle;
  var_1.loadoutprimarylootitemid = var_0.loadoutprimarylootitemid;
  var_1.loadoutprimaryvariantid = var_0.loadoutprimaryvariantid;
  var_1.loadoutprimarycosmeticattachment = var_0.loadoutprimarycosmeticattachment;
  var_1.loadoutprimarystickers = var_0.loadoutprimaryweaponstickers;

  if(isDefined(var_0._id_11961))
    var_1._id_11961 = var_0._id_11961;

  var_1.loadoutsecondary = var_0.loadoutsecondary;
  var_1.loadoutsecondaryattachments = var_0.loadoutsecondaryattachments;
  var_1.loadoutsecondaryattachmentids = var_0.loadoutsecondaryattachmentids;
  var_1.loadoutsecondarycamo = var_0.loadoutsecondarycamo;
  var_1.loadoutsecondaryreticle = var_0.loadoutsecondaryreticle;
  var_1.loadoutsecondarylootitemid = var_0.loadoutsecondarylootitemid;
  var_1.loadoutsecondaryvariantid = var_0.loadoutsecondaryvariantid;
  var_1.loadoutsecondarycosmeticattachment = var_0.loadoutsecondarycosmeticattachment;
  var_1.loadoutsecondarystickers = var_0.loadoutsecondarystickers;
  var_1.loadoutmeleeslot = var_0.loadoutmeleeslot;
  var_1.loadoutperksfromgamemode = var_0.loadoutperksfromgamemode;
  var_1.loadoutperks = var_0.loadoutperks;
  var_1.loadoutstandardperks = var_0.loadoutstandardperks;
  var_1.loadoutextraperks = var_0.loadoutextraperks;
  var_1.loadoutrigtrait = var_0.loadoutrigtrait;
  var_1.loadoutusingspecialist = var_0.loadoutusingspecialist;
  var_1.loadoutequipmentprimary = var_0.loadoutequipmentprimary;
  var_1.loadoutextraequipmentprimary = var_0.loadoutextraequipmentprimary;
  var_1.loadoutequipmentsecondary = var_0.loadoutequipmentsecondary;
  var_1.loadoutextraequipmentsecondary = var_0.loadoutextraequipmentsecondary;
  var_1.loadoutsuper = var_0.loadoutsuper;
  var_1.loadoutgesture = var_0.loadoutgesture;
  var_1.loadoutaccessorydata = var_0.loadoutaccessorydata;
  var_1.loadoutaccessoryweapon = var_0.loadoutaccessoryweapon;
  var_1.loadoutstreaksfilled = var_0.loadoutstreaksfilled;
  var_1.loadoutstreaktype = var_0.loadoutstreaktype;
  var_1.loadoutkillstreak1 = var_0.loadoutkillstreak1;
  var_1.loadoutkillstreak2 = var_0.loadoutkillstreak2;
  var_1.loadoutkillstreak3 = var_0.loadoutkillstreak3;
  var_1.tweakedbyplayerduringmatch = var_0.tweakedbyplayerduringmatch;
  var_1.gamemodeforcednewloadout = var_0.gamemodeforcednewloadout;
  var_1.uavbestid = var_0.uavbestid;
  var_1 = loadout_updateclass(var_1, "_encstr_97E80747B0C3B98211");
  return var_1;
}

loadout_updateclassteam(var_0, var_1, var_2) {
  var_2 = loadout_getclassteam(var_1);
  var_3 = getclassindex(var_1);
  self.class_num = var_3;
  self.classteam = var_2;
  var_0.loadoutarchetype = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_2, var_3, "_encstr_959506B911C79707", "_encstr_96400A3B8A2EB05D3B73D379");
  var_0.loadoutprimary = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_2, var_3, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 0, "_encstr_AC20072B9FA9487832");

  if(var_0.loadoutprimary == "_encstr_8BBA05185F8B99")
    var_0.loadoutprimary = "_encstr_A7ED0AD79F73990E28334B92";
  else {
    for(var_4 = 0; var_4 < 10; var_4++)
      var_0.loadoutprimaryattachments[var_4] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_2, var_3, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 0, "_encstr_BA6F1012A0E9A677F8598D8EEDA757AB4318", var_4, "_encstr_B19A0BD803A4E10F42E50598BB");

    for(var_5 = 0; var_5 < 4; var_5++)
      var_0.loadoutprimarystickers[var_5] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_2, var_3, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 0, "_encstr_929E081F5412E20869BD", var_5);
  }

  var_0.loadoutprimarycamo = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_2, var_3, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 0, "_encstr_B19005D885B5F6");
  var_0.loadoutprimaryreticle = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_2, var_3, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 0, "_encstr_925008E456475A6CB195");
  var_0.loadoutsecondary = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_2, var_3, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 1, "_encstr_AC20072B9FA9487832");

  for(var_4 = 0; var_4 < 10; var_4++)
    var_0.loadoutsecondaryattachments[var_4] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_2, var_3, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 1, "_encstr_BA6F1012A0E9A677F8598D8EEDA757AB4318", var_4, "_encstr_B19A0BD803A4E10F42E50598BB");

  for(var_5 = 0; var_5 < 4; var_5++)
    var_0.loadoutsecondarystickers[var_5] = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_2, var_3, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 1, "_encstr_929E081F5412E20869BD", var_5);

  var_0.loadoutsecondarycamo = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_2, var_3, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 1, "_encstr_B19005D885B5F6");
  var_0.loadoutsecondaryreticle = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_2, var_3, "_encstr_959506B911C79707", "_encstr_A1BE0DDD5658E07BE6D4561D5D83B9", 1, "_encstr_925008E456475A6CB195");
  var_0.loadoutmeleeslot = "_encstr_8BBA05185F8B99";
  var_0.loadoutequipmentprimary = "_encstr_8BBA05185F8B99";
  var_0.loadoutextraequipmentprimary = 0;
  var_0.loadoutequipmentsecondary = "_encstr_8BBA05185F8B99";
  var_0.loadoutextraequipmentsecondary = 0;
  var_0.loadoutsuper = "_encstr_8BBA05185F8B99";
  var_0.loadoutgesture = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_2, var_3, "_encstr_959506B911C79707", "_encstr_8F0508CE59DCA357392B");
  var_0.loadoutstreaksfilled = 1;
  var_0.loadoutkillstreak1 = recipe_getkillstreak(var_2, var_3, 0);
  var_0.loadoutkillstreak2 = recipe_getkillstreak(var_2, var_3, 1);
  var_0.loadoutkillstreak3 = recipe_getkillstreak(var_2, var_3, 2);
}

loadout_updateclasscustom(var_0, var_1) {
  var_2 = getclassindex(var_1);
  self.class_num = var_2;

  if(!isDefined(var_2)) {
    var_3 = scripts\engine\utility::ter_op(isDefined(self.name), self.name, "_encstr_AA3A0C14C35837A70410A21AD940");
    var_4 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, "_encstr_AA3A0C14C35837A70410A21AD940");
    scripts\mp\utility\script::laststand_dogtags("_encstr_AA2C2788DD6928B843CB9FC3F37AF7F005BEF0A142C3D96DDBD3C7EBEAF66F80D9CD78B92F787BA8C6" + var_3 + "_encstr_B10E1702DD2DE84310B473CE8563A59108B1B1859B6E089E40" + var_4);
  }

  var_0.loadoutarchetype = cac_getcharacterarchetype();
  var_0.loadoutprimary = cac_getweapon(var_2, 0);

  for(var_5 = 0; var_5 < 10; var_5++) {
    var_0.loadoutprimaryattachments[var_5] = cac_getweaponattachment(var_2, 0, var_5);
    var_0.loadoutprimaryattachmentids[var_5] = force_interrupt_current_combat_action(var_2, 0, var_5);
  }

  var_0.loadoutprimarycamo = cac_getweaponcamo(var_2, 0);
  var_0.loadoutprimaryreticle = cac_getweaponreticle(var_2, 0);
  var_0.loadoutprimarylootitemid = cac_getweaponlootitemid(var_2, 0);
  var_0.loadoutprimaryvariantid = cac_getweaponvariantid(var_2, 0);
  var_0.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(var_2, 0);

  for(var_6 = 0; var_6 < 4; var_6++)
    var_0.loadoutprimarystickers[var_6] = cac_getweaponsticker(var_2, 0, var_6);

  var_0.loadoutsecondary = cac_getweapon(var_2, 1);

  for(var_5 = 0; var_5 < 10; var_5++) {
    var_0.loadoutsecondaryattachments[var_5] = cac_getweaponattachment(var_2, 1, var_5);
    var_0.loadoutsecondaryattachmentids[var_5] = force_interrupt_current_combat_action(var_2, 1, var_5);
  }

  var_0.loadoutsecondarycamo = cac_getweaponcamo(var_2, 1);
  var_0.loadoutsecondaryreticle = cac_getweaponreticle(var_2, 1);
  var_0.loadoutsecondarylootitemid = cac_getweaponlootitemid(var_2, 1);
  var_0.loadoutsecondaryvariantid = cac_getweaponvariantid(var_2, 1);
  var_0.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(var_2, 1);

  for(var_6 = 0; var_6 < 4; var_6++)
    var_0.loadoutsecondarystickers[var_6] = cac_getweaponsticker(var_2, 1, var_6);

  var_0.loadoutequipmentprimary = cac_getequipmentprimary(var_2);
  var_0.loadoutextraequipmentprimary = cac_getextraequipmentprimary(var_2);
  var_0.loadoutequipmentsecondary = cac_getequipmentsecondary(var_2);
  var_0.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary(var_2);
  var_0.loadoutsuper = cac_getsuper();
  var_0.loadoutgesture = cac_getgesture();
  _encstr_887E1DC67B8591DBAB47F5571C91168E568D368537CDC28D8DB2E637F639CB(var_0);
  var_0.loadoutstreaksfilled = 1;
  var_0.loadoutkillstreak1 = cac_getkillstreak(0, var_1);
  var_0.loadoutkillstreak2 = cac_getkillstreak(1, var_1);
  var_0.loadoutkillstreak3 = cac_getkillstreak(2, var_1);
  var_0.loadoutusingspecialist = cac_getusingspecialist(var_2);
  var_7 = 0;

  foreach(var_9 in var_0.loadoutprimaryattachments) {
    if(var_9 != "_encstr_8BBA05185F8B99")
      var_7++;
  }

  var_11 = 0;

  foreach(var_9 in var_0.loadoutsecondaryattachments) {
    if(var_9 != "_encstr_8BBA05185F8B99")
      var_11++;
  }

  var_14 = int(tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 4, var_0.loadoutprimary, 18));

  if(var_14 < var_7) {
    for(var_5 = 0; var_5 < 10; var_5++) {
      var_0.loadoutprimaryattachments[var_5] = "_encstr_8BBA05185F8B99";
      var_0.loadoutprimaryattachmentids[var_5] = 0;
    }
  }

  var_14 = int(tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 4, var_0.loadoutsecondary, 18));

  if(var_14 < var_11) {
    for(var_5 = 0; var_5 < 10; var_5++) {
      var_0.loadoutsecondaryattachments[var_5] = "_encstr_8BBA05185F8B99";
      var_0.loadoutsecondaryattachmentids[var_5] = 0;
    }
  }
}

loadout_updateclassgamemode(var_0, var_1) {
  var_2 = getclassindex(var_1);
  self.class_num = var_2;
  var_3 = self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"];

  if(isDefined(var_3["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"]))
    var_0.loadoutarchetype = var_3["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"];
  else if(isbot(self)) {
    var_4 = scripts\mp\bots\bots_loadout::bot_loadout_class_callback();
    var_0.loadoutarchetype = var_4["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"];
  } else
    var_0.loadoutarchetype = cac_getcharacterarchetype();

  if(isDefined(var_3["_encstr_88241078EF8B28200F7B666B5FA3A3DA28A3"]))
    var_0.loadoutrigtrait = var_3["_encstr_88241078EF8B28200F7B666B5FA3A3DA28A3"];

  if(isDefined(var_3["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"]))
    var_0._id_11960 = var_3["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"];

  if(isDefined(var_3["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"]))
    var_0.loadoutprimary = var_3["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];

  for(var_5 = 0; var_5 < 10; var_5++) {
    var_6 = getattachmentloadoutstring(var_5, "_encstr_BA7F0830B3A7859B60B0");

    if(isDefined(var_3[var_6]))
      var_0.loadoutprimaryattachments[var_5] = var_3[var_6];
  }

  for(var_7 = 0; var_7 < 4; var_7++) {
    var_8 = getstickerloadoutstring(var_7, "_encstr_BA7F0830B3A7859B60B0");

    if(isDefined(var_3[var_8]))
      var_0.loadoutprimarystickers[var_7] = var_3[var_8];
  }

  if(isDefined(var_3["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"]))
    var_0.loadoutprimarycamo = var_3["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"];

  if(isDefined(var_3["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"]))
    var_0.loadoutprimarycosmeticattachment = var_3["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"];

  if(isDefined(var_3["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"]))
    var_0.loadoutprimaryreticle = var_3["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"];

  if(isDefined(var_3["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"]))
    var_0.loadoutprimaryvariantid = var_3["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"];

  if(isDefined(var_3["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"]) && scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916") {
    if(isDefined(var_3["_encstr_A6741E660FB7A8A1BBE20819CB0A6B811798EE53958F53C3964A18F0E1E71B58"]) && isDefined(self.pers["_encstr_8AEF05472BC2D6"]) && var_3["_encstr_A6741E660FB7A8A1BBE20819CB0A6B811798EE53958F53C3964A18F0E1E71B58"] == self.pers["_encstr_8AEF05472BC2D6"]) {
      if(isDefined(var_3["_encstr_97081A4EB7ABCD23EA5AE6A6E8E42B58D6149C5AB68539970D2C6B7B"]))
        var_0.loadoutprimarycamo = var_3["_encstr_97081A4EB7ABCD23EA5AE6A6E8E42B58D6149C5AB68539970D2C6B7B"];
    }

    if(var_3["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] != -1)
      setomnvar("_encstr_A1021AAB96D7164EB2DCB0AF0E39A5B658932F2B0B392DB0B9472944", var_3["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"]);
  }

  if(isDefined(var_3["_encstr_99B2286888EADCAFF83B919362D82E502F18AB292D5116D86759C01D572BA8F0931B51BA61DDA87533DF"]))
    var_0._id_11961 = var_3["_encstr_99B2286888EADCAFF83B919362D82E502F18AB292D5116D86759C01D572BA8F0931B51BA61DDA87533DF"];

  if(isDefined(var_3["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"]))
    var_0.loadoutsecondary = var_3["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"];

  for(var_5 = 0; var_5 < 10; var_5++) {
    var_6 = getattachmentloadoutstring(var_5, "_encstr_AC8F0AE74163F85AAA380AD8");

    if(isDefined(var_3[var_6]))
      var_0.loadoutsecondaryattachments[var_5] = var_3[var_6];
  }

  for(var_7 = 0; var_7 < 4; var_7++) {
    var_8 = getstickerloadoutstring(var_7, "_encstr_AC8F0AE74163F85AAA380AD8");

    if(isDefined(var_3[var_8]))
      var_0.loadoutsecondarystickers[var_7] = var_3[var_8];
  }

  if(isDefined(var_3["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"]))
    var_0.loadoutsecondarycamo = var_3["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"];

  if(isDefined(var_3["_encstr_9595235890C7B9771BDD9B2F9BDFF5BB2263E1B7D89B7B431340776318E9BF6ABAB9EF550B"]))
    var_0.loadoutsecondarycosmeticattachment = var_3["_encstr_9595235890C7B9771BDD9B2F9BDFF5BB2263E1B7D89B7B431340776318E9BF6ABAB9EF550B"];

  if(isDefined(var_3["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"]))
    var_0.loadoutsecondaryreticle = var_3["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"];

  if(isDefined(var_3["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"]))
    var_0.loadoutsecondaryvariantid = var_3["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"];

  if(isDefined(var_3["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"]) && scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916" && var_3["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] != -1) {
    if(isDefined(var_3["_encstr_AC711F781AB32D79A76930A66CEB81FB9C027808628F6BF337AB4FA15F1BC943C5"]) && isDefined(self.pers["_encstr_8AEF05472BC2D6"]) && var_3["_encstr_AC711F781AB32D79A76930A66CEB81FB9C027808628F6BF337AB4FA15F1BC943C5"] == self.pers["_encstr_8AEF05472BC2D6"]) {
      if(isDefined(var_3["_encstr_A3AF1CC2E88B820C8738C3CF28DBC5BA6F6E8F3E40D55A510B907F0FC850"]))
        var_0.loadoutsecondarycamo = var_3["_encstr_A3AF1CC2E88B820C8738C3CF28DBC5BA6F6E8F3E40D55A510B907F0FC850"];
    }

    if(var_3["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] != -1)
      setomnvar("_encstr_8C1F1C1BF3F75A22F928E717E8D1EB627D9DE652635D126A2D48E3A3C12D", var_3["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"]);
  }

  if(isDefined(var_3["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"]))
    var_0.loadoutmeleeslot = var_3["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"];

  var_0.loadoutperksfromgamemode = isDefined(var_3["_encstr_86CB0DFB97F7022F90BB3A7F53487B"]);

  if(isDefined(var_3["_encstr_86CB0DFB97F7022F90BB3A7F53487B"]))
    var_0.loadoutperks = var_3["_encstr_86CB0DFB97F7022F90BB3A7F53487B"];

  var_0._id_1195E = isDefined(var_3["_encstr_97EA12B1B7C223DBBA3A8AE1A327582859C95BE6"]);

  if(isDefined(var_3["_encstr_97EA12B1B7C223DBBA3A8AE1A327582859C95BE6"]))
    var_0.loadoutextraperks = var_3["_encstr_97EA12B1B7C223DBBA3A8AE1A327582859C95BE6"];

  if(isDefined(var_3["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"]))
    var_0.loadoutequipmentprimary = var_3["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"];

  if(isDefined(var_3["_encstr_B8141D4CD0C932385B1BE7E9D1C8DFF773FB94EB1541184BFFBAB38186438B"]))
    var_0.loadoutextraequipmentprimary = var_3["_encstr_B8141D4CD0C932385B1BE7E9D1C8DFF773FB94EB1541184BFFBAB38186438B"];

  if(isDefined(var_3["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"]))
    var_0.loadoutequipmentsecondary = var_3["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"];

  if(isDefined(var_3["_encstr_8EA71F285227ADE0CBE403710CF268F58F6B2D13DA6FD0706ACD57A70E5F203617"]))
    var_0.loadoutextraequipmentsecondary = var_3["_encstr_8EA71F285227ADE0CBE403710CF268F58F6B2D13DA6FD0706ACD57A70E5F203617"];

  if(isDefined(var_3["_encstr_85920D9D304BCAFF3B38EF7F3011BA"]))
    var_0.loadoutsuper = var_3["_encstr_85920D9D304BCAFF3B38EF7F3011BA"];

  if(isbot(self)) {
    var_0.loadoutaccessoryweapon = "_encstr_8BBA05185F8B99";
    var_0.loadoutaccessorydata = "_encstr_8BBA05185F8B99";
    var_0.loadoutaccessorylogic = "_encstr_8BBA05185F8B99";
  } else
    _encstr_887E1DC67B8591DBAB47F5571C91168E568D368537CDC28D8DB2E637F639CB(var_0);

  if(isDefined(var_3["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"])) {
    if(var_3["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] == "_encstr_A63C0B33252188F56B439B89EF") {
      if(isbot(self))
        var_0.loadoutgesture = "_encstr_8BBA05185F8B99";
      else
        var_0.loadoutgesture = cac_getgesture();
    } else
      var_0.loadoutgesture = var_3["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"];
  }

  if(isDefined(var_3["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"]) && var_3["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] != "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249" || isDefined(var_3["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"]) && var_3["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] != "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249" || isDefined(var_3["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"]) && var_3["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] != "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249") {
    var_0.loadoutstreaksfilled = 1;
    var_0.loadoutkillstreak1 = var_3["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"];
    var_0.loadoutkillstreak2 = var_3["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"];
    var_0.loadoutkillstreak3 = var_3["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"];
  }

  if(isDefined(var_3["_encstr_BD7517A417C0D76F6D53B1DBD8C897C2A0FB2339A310DC5795"]))
    var_0.loadoutusingspecialist = 1;
}

zone_get_node_nearest_2d_bounds(var_0, var_1) {
  var_2 = getclassindex(var_1);
  self.class_num = var_2;
  var_3 = self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"];
  var_4 = issubstr(var_1, "_encstr_86130F396BB313C7404F95C59DBAF1E73F");

  if(!var_4) {
    var_0.loadoutarchetype = cac_getcharacterarchetype();

    if(isDefined(var_3["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"]))
      var_0._id_11960 = var_3["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"];

    if(isDefined(var_3["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"])) {
      var_0.loadoutprimary = var_3["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];

      for(var_5 = 0; var_5 < 10; var_5++) {
        var_6 = getattachmentloadoutstring(var_5, "_encstr_BA7F0830B3A7859B60B0");

        if(isDefined(var_3[var_6]))
          var_0.loadoutprimaryattachments[var_5] = var_3[var_6];
      }

      for(var_7 = 0; var_7 < 4; var_7++) {
        var_8 = getstickerloadoutstring(var_7, "_encstr_BA7F0830B3A7859B60B0");

        if(isDefined(var_3[var_8]))
          var_0.loadoutprimarystickers[var_7] = var_3[var_8];
      }

      if(isDefined(var_3["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"]))
        var_0.loadoutprimarycamo = var_3["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"];

      if(isDefined(var_3["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"]))
        var_0.loadoutprimarycosmeticattachment = var_3["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"];

      if(isDefined(var_3["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"]))
        var_0.loadoutprimaryreticle = var_3["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"];

      if(isDefined(var_3["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"]))
        var_0.loadoutprimaryvariantid = var_3["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"];
    } else {
      var_0.loadoutprimary = cac_getweapon(var_2, 0);

      for(var_5 = 0; var_5 < 10; var_5++) {
        var_0.loadoutprimaryattachments[var_5] = cac_getweaponattachment(var_2, 0, var_5);
        var_0.loadoutprimaryattachmentids[var_5] = force_interrupt_current_combat_action(var_2, 0, var_5);
      }

      var_0.loadoutprimarycamo = cac_getweaponcamo(var_2, 0);
      var_0.loadoutprimaryreticle = cac_getweaponreticle(var_2, 0);
      var_0.loadoutprimarylootitemid = cac_getweaponlootitemid(var_2, 0);
      var_0.loadoutprimaryvariantid = cac_getweaponvariantid(var_2, 0);
      var_0.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(var_2, 0);

      for(var_7 = 0; var_7 < 4; var_7++)
        var_0.loadoutprimarystickers[var_7] = cac_getweaponsticker(var_2, 0, var_7);
    }

    if(isDefined(var_3["_encstr_99B2286888EADCAFF83B919362D82E502F18AB292D5116D86759C01D572BA8F0931B51BA61DDA87533DF"]))
      var_0._id_11961 = var_3["_encstr_99B2286888EADCAFF83B919362D82E502F18AB292D5116D86759C01D572BA8F0931B51BA61DDA87533DF"];

    if(isDefined(var_3["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"])) {
      var_0.loadoutsecondary = var_3["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"];

      for(var_5 = 0; var_5 < 10; var_5++) {
        var_6 = getattachmentloadoutstring(var_5, "_encstr_AC8F0AE74163F85AAA380AD8");

        if(isDefined(var_3[var_6]))
          var_0.loadoutsecondaryattachments[var_5] = var_3[var_6];
      }

      for(var_7 = 0; var_7 < 4; var_7++) {
        var_8 = getstickerloadoutstring(var_7, "_encstr_AC8F0AE74163F85AAA380AD8");

        if(isDefined(var_3[var_8]))
          var_0.loadoutsecondarystickers[var_7] = var_3[var_8];
      }

      if(isDefined(var_3["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"]))
        var_0.loadoutsecondarycamo = var_3["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"];

      if(isDefined(var_3["_encstr_9595235890C7B9771BDD9B2F9BDFF5BB2263E1B7D89B7B431340776318E9BF6ABAB9EF550B"]))
        var_0.loadoutsecondarycosmeticattachment = var_3["_encstr_9595235890C7B9771BDD9B2F9BDFF5BB2263E1B7D89B7B431340776318E9BF6ABAB9EF550B"];

      if(isDefined(var_3["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"]))
        var_0.loadoutsecondaryreticle = var_3["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"];

      if(isDefined(var_3["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"]))
        var_0.loadoutsecondaryvariantid = var_3["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"];
    } else {
      var_0.loadoutsecondary = cac_getweapon(var_2, 1);

      for(var_5 = 0; var_5 < 10; var_5++) {
        var_0.loadoutsecondaryattachments[var_5] = cac_getweaponattachment(var_2, 1, var_5);
        var_0.loadoutsecondaryattachmentids[var_5] = force_interrupt_current_combat_action(var_2, 1, var_5);
      }

      var_0.loadoutsecondarycamo = cac_getweaponcamo(var_2, 1);
      var_0.loadoutsecondaryreticle = cac_getweaponreticle(var_2, 1);
      var_0.loadoutsecondarylootitemid = cac_getweaponlootitemid(var_2, 1);
      var_0.loadoutsecondaryvariantid = cac_getweaponvariantid(var_2, 1);
      var_0.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(var_2, 1);

      for(var_7 = 0; var_7 < 4; var_7++)
        var_0.loadoutsecondarystickers[var_7] = cac_getweaponsticker(var_2, 1, var_7);
    }

    if(isDefined(var_3["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"]))
      var_0.loadoutmeleeslot = var_3["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"];

    var_0.loadoutequipmentprimary = cac_getequipmentprimary(var_2);
    var_0.loadoutextraequipmentprimary = cac_getextraequipmentprimary(var_2);
    var_0.loadoutequipmentsecondary = cac_getequipmentsecondary(var_2);
    var_0.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary(var_2);
    var_0.loadoutsuper = cac_getsuper();
    var_0.loadoutgesture = cac_getgesture();
    _encstr_887E1DC67B8591DBAB47F5571C91168E568D368537CDC28D8DB2E637F639CB(var_0);
    var_0.loadoutstreaksfilled = 1;
    var_0.loadoutkillstreak1 = cac_getkillstreak(0, var_1);
    var_0.loadoutkillstreak2 = cac_getkillstreak(1, var_1);
    var_0.loadoutkillstreak3 = cac_getkillstreak(2, var_1);
    var_0.loadoutusingspecialist = cac_getusingspecialist(var_2);
  } else {
    if(isDefined(var_3["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"]))
      var_0._id_11960 = var_3["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"];

    if(isDefined(var_3["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"])) {
      var_0.loadoutprimary = var_3["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];

      for(var_5 = 0; var_5 < 10; var_5++) {
        var_6 = getattachmentloadoutstring(var_5, "_encstr_BA7F0830B3A7859B60B0");

        if(isDefined(var_3[var_6]))
          var_0.loadoutprimaryattachments[var_5] = var_3[var_6];
      }

      for(var_7 = 0; var_7 < 4; var_7++) {
        var_8 = getstickerloadoutstring(var_7, "_encstr_BA7F0830B3A7859B60B0");

        if(isDefined(var_3[var_8]))
          var_0.loadoutprimarystickers[var_7] = var_3[var_8];
      }

      if(isDefined(var_3["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"]))
        var_0.loadoutprimarycamo = var_3["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"];

      if(isDefined(var_3["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"]))
        var_0.loadoutprimarycosmeticattachment = var_3["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"];

      if(isDefined(var_3["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"]))
        var_0.loadoutprimaryreticle = var_3["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"];

      if(isDefined(var_3["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"]))
        var_0.loadoutprimaryvariantid = var_3["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"];
    } else if(!isagent(self) && self calloutmarkerping_getEnt() && getdvarint("_encstr_B4861F7F779659CED8D34ED78C5011226183F7E79FBDC394B018C41841F051EAC8", 1) == 1)
      zoomkey(var_0);
    else {
      var_0.loadoutprimary = table_getweapon(level.classtablename, var_2, 0);

      for(var_5 = 0; var_5 < 10; var_5++)
        var_0.loadoutprimaryattachments[var_5] = table_getweaponattachment(level.classtablename, var_2, 0, var_5);

      var_0.loadoutprimarycamo = table_getweaponcamo(level.classtablename, var_2, 0);
      var_0.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, var_2, 0);
      var_0.loadoutsecondary = table_getweapon(level.classtablename, var_2, 1);

      for(var_5 = 0; var_5 < 10; var_5++)
        var_0.loadoutsecondaryattachments[var_5] = table_getweaponattachment(level.classtablename, var_2, 1, var_5);

      var_0.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, var_2, 1);
      var_0.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, var_2, 1);
    }

    var_0.loadoutequipmentprimary = table_getequipmentprimary(level.classtablename, var_2);
    var_0.loadoutextraequipmentprimary = table_getextraequipmentprimary(level.classtablename, var_2);
    var_0.loadoutequipmentsecondary = table_getequipmentsecondary(level.classtablename, var_2);
    var_0.loadoutextraequipmentsecondary = table_getextraequipmentsecondary(level.classtablename, var_2);
    var_0.loadoutgesture = table_getgesture(level.classtablename, var_2);
    var_0.loadoutsuper = table_getsuper(level.classtablename, var_2);
    var_0.loadoutusingspecialist = table_getspecialist(level.classtablename, var_2);
    _encstr_887E1DC67B8591DBAB47F5571C91168E568D368537CDC28D8DB2E637F639CB(var_0);
    var_0.loadoutarchetype = cac_getcharacterarchetype();
    var_0.loadoutkillstreak1 = cac_getkillstreak(0, var_1);
    var_0.loadoutkillstreak2 = cac_getkillstreak(1, var_1);
    var_0.loadoutkillstreak3 = cac_getkillstreak(2, var_1);
    var_0.loadoutrigtrait = cac_getloadoutarchetypeperk();

    if(getdvarint("_encstr_A9FC18078342216E07CB69F3D017A688DF34BB97202B81BF4352", 0))
      var_0.loadoutsuper = "_encstr_92520EE65707594E7D894E1646C62BE5";
  }
}

loadout_updateclasscallback(var_0) {
  if(!isDefined(self.classcallback))
    scripts\engine\utility::error("_encstr_A2FA443BA1398B9D1BF94943DF5916EB513992A2C8A7538380CF54518F188E6B0D11AA3B91680FFFCA157D3183D8227F254112529B17B775A83F6368CFA0AE8359E1FA1A6D3C");

  var_1 = self[[self.classcallback]]();

  if(!isDefined(var_1))
    scripts\engine\utility::error("_encstr_93293CFB4AAA3893AA03B13B5BA7CEC0C7F00D55CFD57ADEC7FAE9C8C26B0F385A2B8BF1647EC82ED756E1E8FB323638767337E157E60BE1134A19917216");

  if(isDefined(var_1["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"]))
    var_0.loadoutarchetype = var_1["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"];

  if(isDefined(var_1["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"]))
    var_0._id_11960 = var_1["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"];

  if(isDefined(var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"]))
    var_0.loadoutprimary = var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_3 = getattachmentloadoutstring(var_2, "_encstr_BA7F0830B3A7859B60B0");

    if(isDefined(var_1[var_3]))
      var_0.loadoutprimaryattachments[var_2] = var_1[var_3];
  }

  if(isDefined(var_1["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"]))
    var_0.loadoutprimarycamo = var_1["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"];

  if(isDefined(var_1["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"]))
    var_0.loadoutprimaryreticle = var_1["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"];

  if(isDefined(var_1["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"]))
    var_0.loadoutprimaryvariantid = var_1["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"];

  if(isDefined(var_1["_encstr_99B2286888EADCAFF83B919362D82E502F18AB292D5116D86759C01D572BA8F0931B51BA61DDA87533DF"]))
    var_0._id_11961 = var_1["_encstr_99B2286888EADCAFF83B919362D82E502F18AB292D5116D86759C01D572BA8F0931B51BA61DDA87533DF"];

  if(isDefined(var_1["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"]))
    var_0.loadoutsecondary = var_1["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"];

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_3 = getattachmentloadoutstring(var_2, "_encstr_AC8F0AE74163F85AAA380AD8");

    if(isDefined(var_1[var_3]))
      var_0.loadoutsecondaryattachments[var_2] = var_1[var_3];
  }

  if(isDefined(var_1["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"]))
    var_0.loadoutsecondarycamo = var_1["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"];

  if(isDefined(var_1["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"]))
    var_0.loadoutsecondaryreticle = var_1["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"];

  if(isDefined(var_1["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"]))
    var_0.loadoutsecondaryvariantid = var_1["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"];

  if(isDefined(var_1["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"]))
    var_0.loadoutmeleeslot = var_1["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"];

  if(isDefined(var_1["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"]))
    var_0.loadoutequipmentprimary = var_1["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"];

  if(isDefined(var_1["_encstr_B8141D4CD0C932385B1BE7E9D1C8DFF773FB94EB1541184BFFBAB38186438B"]))
    var_0.loadoutextraequipmentprimary = var_1["_encstr_B8141D4CD0C932385B1BE7E9D1C8DFF773FB94EB1541184BFFBAB38186438B"];

  if(isDefined(var_1["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"]))
    var_0.loadoutequipmentsecondary = var_1["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"];

  if(isDefined(var_1["_encstr_8EA71F285227ADE0CBE403710CF268F58F6B2D13DA6FD0706ACD57A70E5F203617"]))
    var_0.loadoutextraequipmentsecondary = var_1["_encstr_8EA71F285227ADE0CBE403710CF268F58F6B2D13DA6FD0706ACD57A70E5F203617"];

  if(isDefined(var_1["_encstr_85920D9D304BCAFF3B38EF7F3011BA"]))
    var_0.loadoutsuper = var_1["_encstr_85920D9D304BCAFF3B38EF7F3011BA"];

  if(isDefined(var_1["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"]))
    var_0.loadoutgesture = var_1["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"];

  var_0.loadoutstreaksfilled = isDefined(var_1["_encstr_8BBF0F195FB7B9E76303D1F07B3FB3104E"]) || isDefined(var_1["_encstr_8DBF0FD8ED16C8ED57A3A9A39C5685B523"]) || isDefined(var_1["_encstr_A5BF0FD5086FE44D43DCFB7B357B4F0CCB"]);

  if(isDefined(var_1["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"]))
    var_0.loadoutstreaktype = var_1["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"];

  if(isDefined(var_1["_encstr_8BBF0F195FB7B9E76303D1F07B3FB3104E"]))
    var_0.loadoutkillstreak1 = var_1["_encstr_8BBF0F195FB7B9E76303D1F07B3FB3104E"];

  if(isDefined(var_1["_encstr_8DBF0FD8ED16C8ED57A3A9A39C5685B523"]))
    var_0.loadoutkillstreak2 = var_1["_encstr_8DBF0FD8ED16C8ED57A3A9A39C5685B523"];

  if(isDefined(var_1["_encstr_A5BF0FD5086FE44D43DCFB7B357B4F0CCB"]))
    var_0.loadoutkillstreak3 = var_1["_encstr_A5BF0FD5086FE44D43DCFB7B357B4F0CCB"];
}

loadout_updateclassdefault(var_0, var_1) {
  var_2 = getclassindex(var_1);
  self.class_num = var_2;

  if(!isDefined(var_2)) {
    var_3 = "_encstr_AA3A0C14C35837A70410A21AD940";
    var_4 = "_encstr_AA3A0C14C35837A70410A21AD940";

    if(isDefined(self.name))
      var_3 = self.name;

    if(isDefined(var_1))
      var_4 = var_1;

    scripts\mp\utility\script::laststand_dogtags("_encstr_ACC2282098A33C202319411743EF511B4F01896E2653C4DFB9F30F051B4B03E7BBC1C8206B8B82E8AD8F" + var_3 + "_encstr_B10E1702DD2DE84310B473CE8563A59108B1B1859B6E089E40" + var_4);
  }

  if(!isagent(self) && self calloutmarkerping_getEnt() && getdvarint("_encstr_B4861F7F779659CED8D34ED78C5011226183F7E79FBDC394B018C41841F051EAC8", 1) == 1) {
    zoomkey(var_0);
    _encstr_831925E1870FFBB0330C5E9FC3994F33050E64097B6326D8B0EB33BBDF2D03CB3857D7D1BD8312(var_0);
  } else {
    zoneislocked(var_0, var_2);
    _encstr_887E1DC67B8591DBAB47F5571C91168E568D368537CDC28D8DB2E637F639CB(var_0);
  }

  var_0.loadoutequipmentprimary = table_getequipmentprimary(level.classtablename, var_2);
  var_0.loadoutextraequipmentprimary = table_getextraequipmentprimary(level.classtablename, var_2);
  var_0.loadoutequipmentsecondary = table_getequipmentsecondary(level.classtablename, var_2);
  var_0.loadoutextraequipmentsecondary = table_getextraequipmentsecondary(level.classtablename, var_2);
  var_0.loadoutgesture = table_getgesture(level.classtablename, var_2);
  var_0.loadoutsuper = table_getsuper(level.classtablename, var_2);
  var_0.loadoutusingspecialist = table_getspecialist(level.classtablename, var_2);
  var_0.loadoutarchetype = cac_getcharacterarchetype();
  var_0.loadoutkillstreak1 = cac_getkillstreak(0, var_1);
  var_0.loadoutkillstreak2 = cac_getkillstreak(1, var_1);
  var_0.loadoutkillstreak3 = cac_getkillstreak(2, var_1);
  var_0.loadoutrigtrait = cac_getloadoutarchetypeperk();

  if(getdvarint("_encstr_A9FC18078342216E07CB69F3D017A688DF34BB97202B81BF4352", 0))
    var_0.loadoutsuper = "_encstr_92520EE65707594E7D894E1646C62BE5";
}

zoneislocked(var_0, var_1) {
  var_0.loadoutprimary = table_getweapon(level.classtablename, var_1, 0);

  for(var_2 = 0; var_2 < 10; var_2++)
    var_0.loadoutprimaryattachments[var_2] = table_getweaponattachment(level.classtablename, var_1, 0, var_2);

  var_0.loadoutprimarycamo = table_getweaponcamo(level.classtablename, var_1, 0);
  var_0.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, var_1, 0);
  var_0.loadoutsecondary = table_getweapon(level.classtablename, var_1, 1);

  for(var_2 = 0; var_2 < 10; var_2++)
    var_0.loadoutsecondaryattachments[var_2] = table_getweaponattachment(level.classtablename, var_1, 1, var_2);

  var_0.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, var_1, 1);
  var_0.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, var_1, 1);
}

zoomkey(var_0) {
  if(!isDefined(self.showextractiontime)) {
    if(!isDefined(level.showextractiontime)) {
      var_1 = randomint(200);
      level.showextractiontime = var_1;
      level.showhint = var_1;
    } else {
      level.showextractiontime++;
      level.showhint++;
    }

    self.showextractiontime = level.showextractiontime;
    self.showhint = level.showhint;
  }

  var_2 = zone_stompeenemyprogressupdate(self.showextractiontime, 1);
  var_3 = zone_stompeenemyprogressupdate(self.showhint, 0);
  var_4 = var_2[0];
  var_5 = var_2[1];
  var_6 = var_3[0];
  var_7 = var_3[1];
  var_0.loadoutprimary = var_4;

  foreach(var_10, var_9 in var_5.attachcustomtoidmap) {
    var_0.loadoutprimaryattachments[var_0.loadoutprimaryattachments.size] = var_10;
    var_0.loadoutprimaryattachmentids[var_0.loadoutprimaryattachmentids.size] = var_9;
  }

  var_0.loadoutprimaryvariantid = var_5.variantid;
  var_0.loadoutsecondary = var_6;

  foreach(var_10, var_9 in var_7.attachcustomtoidmap) {
    var_0.loadoutsecondaryattachments[var_0.loadoutsecondaryattachments.size] = var_10;
    var_0.loadoutsecondaryattachmentids[var_0.loadoutsecondaryattachmentids.size] = var_9;
  }

  var_0.loadoutsecondaryvariantid = var_7.variantid;
}

zone_stompeenemyprogressupdate(var_0, var_1) {
  var_2 = 0;
  var_3 = -1;
  var_4 = getdvarint("_encstr_86231BBFAF2DE1632058FA7D971802EF39953B332B5E0B301843EFFB21", 1);

  for(;;) {
    foreach(var_8, var_6 in level.weaponlootmapdata) {
      if(var_6.variantid == 0 || var_6.update_focus_fire_objective || !isDefined(var_6.attachcustomtoidmap)) {
        continue;
      }
      if(var_4 && isDefined(var_6.tut_bot_nameplate) && !var_6.tut_bot_nameplate) {
        continue;
      }
      var_7 = strtok(var_8, "_encstr_854C021F")[0];

      if(var_1 != scripts\mp\utility\weapon::iscacprimaryweapon(var_7)) {
        continue;
      }
      var_3++;

      if(var_3 == var_0)
        return [var_7, var_6];
    }
  }
}

_encstr_887E1DC67B8591DBAB47F5571C91168E568D368537CDC28D8DB2E637F639CB(var_0) {
  var_1 = cac_getaccessoryweapon();
  var_2 = cac_getaccessorydata();
  var_3 = force_interrupt_all_current_combat_actions();
  _encstr_91872563EDB032B7EAD1BEBAC18CC2D1B28D36C29BDC0BB18D95B99BDE3997A59BE8B2279B85C6(var_0, var_1, var_2, var_3);
}

_encstr_831925E1870FFBB0330C5E9FC3994F33050E64097B6326D8B0EB33BBDF2D03CB3857D7D1BD8312(var_0) {
  var_1 = getarraykeys(level.accessoryweaponbyindex);

  if(!isDefined(self._encstr_AFB81704B1107CD2BDEFCF7F37568AA358583AC8A873041A0B)) {
    if(!isDefined(level._encstr_AFB81704B1107CD2BDEFCF7F37568AA358583AC8A873041A0B)) {
      var_2 = randomint(var_1.size);
      level._encstr_AFB81704B1107CD2BDEFCF7F37568AA358583AC8A873041A0B = var_2;
    } else {
      level._encstr_AFB81704B1107CD2BDEFCF7F37568AA358583AC8A873041A0B++;

      if(level._encstr_AFB81704B1107CD2BDEFCF7F37568AA358583AC8A873041A0B >= var_1.size)
        level._encstr_AFB81704B1107CD2BDEFCF7F37568AA358583AC8A873041A0B = 0;
    }

    self._encstr_AFB81704B1107CD2BDEFCF7F37568AA358583AC8A873041A0B = level._encstr_AFB81704B1107CD2BDEFCF7F37568AA358583AC8A873041A0B;
  }

  var_3 = var_1[self._encstr_AFB81704B1107CD2BDEFCF7F37568AA358583AC8A873041A0B];
  var_4 = scripts\mp\accessories::getaccessoryweaponbyindex(var_3);
  var_5 = scripts\mp\accessories::getaccessorydatabyindex(var_3);
  var_6 = scripts\mp\accessories::register_respawn_functions(var_3);
  _encstr_91872563EDB032B7EAD1BEBAC18CC2D1B28D36C29BDC0BB18D95B99BDE3997A59BE8B2279B85C6(var_0, var_4, var_5, var_6);
}

_encstr_91872563EDB032B7EAD1BEBAC18CC2D1B28D36C29BDC0BB18D95B99BDE3997A59BE8B2279B85C6(var_0, var_1, var_2, var_3) {
  var_4 = getdvarint("_encstr_8A9D16575FAE61FCC028246B86683B7A8DD7EFAFE55B8ABB", -1);

  if(var_4 >= 0 && isDefined(var_1)) {
    if(!isDefined(level._encstr_8F3F150D3F80BA8B288673B51F12E89DFBEDC79BFBFF81))
      level._encstr_8F3F150D3F80BA8B288673B51F12E89DFBEDC79BFBFF81 = [];

    level._encstr_8F3F150D3F80BA8B288673B51F12E89DFBEDC79BFBFF81 = scripts\engine\utility::array_removeundefined(level._encstr_8F3F150D3F80BA8B288673B51F12E89DFBEDC79BFBFF81);

    if(level._encstr_8F3F150D3F80BA8B288673B51F12E89DFBEDC79BFBFF81.size < var_4)
      level._encstr_8F3F150D3F80BA8B288673B51F12E89DFBEDC79BFBFF81[level._encstr_8F3F150D3F80BA8B288673B51F12E89DFBEDC79BFBFF81.size] = var_1;
    else if(scripts\engine\utility::array_contains(level._encstr_8F3F150D3F80BA8B288673B51F12E89DFBEDC79BFBFF81, var_1)) {} else {
      var_0.loadoutaccessoryweapon = "_encstr_8BBA05185F8B99";
      var_0.loadoutaccessorydata = "_encstr_8BBA05185F8B99";
      var_0.loadoutaccessorylogic = "_encstr_8BBA05185F8B99";
      return;
    }
  }

  var_0.loadoutaccessoryweapon = var_1;
  var_0.loadoutaccessorydata = var_2;
  var_0.loadoutaccessorylogic = var_3;
}

loadout_updatestreaktype(var_0) {
  if(istrue(var_0.loadoutusingspecialist))
    self.streaktype = "_encstr_AA2F166B1B7A20BFA2CBD3C9A7C9FED005B650A185D958ED";
  else
    self.streaktype = "_encstr_ABB313CD4793CA16B5A3CB38B27D0BCD9B165DC6D1";

  var_0.loadoutstreaktype = self.streaktype;
}

loadout_updateabilities(var_0, var_1) {
  if(!isDefined(self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"]))
    self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = [];

  if(!isDefined(self.pers["_encstr_AA67151BD081D442538512D3673DAA994B3063A7D0381B"]))
    self.pers["_encstr_AA67151BD081D442538512D3673DAA994B3063A7D0381B"] = [];

  if(!isDefined(self.pers["_encstr_97EA12B1B7C223DBBA3A8AE1A327582859C95BE6"]))
    self.pers["_encstr_97EA12B1B7C223DBBA3A8AE1A327582859C95BE6"] = [];

  if(!isDefined(self.pers["_encstr_88241078EF8B28200F7B666B5FA3A3DA28A3"]))
    self.pers["_encstr_88241078EF8B28200F7B666B5FA3A3DA28A3"] = [];

  if(!isDefined(self.pers["_encstr_BD7517A417C0D76F6D53B1DBD8C897C2A0FB2339A310DC5795"]))
    self.pers["_encstr_BD7517A417C0D76F6D53B1DBD8C897C2A0FB2339A310DC5795"] = 0;

  var_2 = getsubstr(var_1, 0, 7) == "_encstr_8B1608EC43B8D647A113";
  var_3 = getsubstr(var_1, 0, 14) == "_encstr_86130F396BB313C7404F95C59DBAF1E73F";

  if(var_0.loadoutperksfromgamemode) {
    var_0.loadoutstandardperks = var_0.loadoutperks;

    if(var_0._id_1195E)
      var_0.loadoutextraperks = var_0.loadoutextraperks;
  } else if(!scripts\mp\utility\perk::perksenabled())
    return;
  else if(isai(self)) {
    if(isDefined(self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"]))
      var_0.loadoutperks = self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"];
  } else {
    if(var_1 == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79" || var_1 == "_encstr_97E80747B0C3B98211") {
      return;
    }
    var_4 = loadout_getclassteam(var_1);

    for(var_5 = 0; var_5 < 3; var_5++) {
      var_6 = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";

      if(var_4 != "_encstr_8BBA05185F8B99") {
        var_7 = getclassindex(var_1);
        var_6 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_4, var_7, "_encstr_959506B911C79707", "_encstr_86CB0DFB97F7022F90BB3A7F53487B");
      } else if(var_2 || var_3) {
        var_7 = getclassindex(var_1);
        var_6 = table_getperk(level.classtablename, var_7, var_5);
      } else
        var_6 = cac_getloadoutperk(self.class_num, var_5);

      if(isDefined(var_6) && var_6 != "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249") {
        var_0.loadoutperks[var_0.loadoutperks.size] = var_6;
        var_0.loadoutstandardperks[var_0.loadoutstandardperks.size] = var_6;
      }
    }

    for(var_5 = 0; var_5 < 3; var_5++) {
      var_6 = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";

      if(var_4 != "_encstr_8BBA05185F8B99") {
        var_7 = getclassindex(var_1);
        var_6 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_4, var_7, "_encstr_959506B911C79707", "_encstr_88350B3DCA135B1A8FAA969243");
      } else if(var_2 || var_3) {
        var_7 = getclassindex(var_1);
        var_6 = table_getextraperk(level.classtablename, var_7, var_5);
      } else
        var_6 = cac_getloadoutextraperk(self.class_num, var_5);

      if(isDefined(var_6) && var_6 != "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249")
        var_0.loadoutextraperks[var_0.loadoutextraperks.size] = var_6;
    }

    var_6 = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";

    if(var_4 != "_encstr_8BBA05185F8B99") {
      var_7 = getclassindex(var_1);
      var_6 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("_encstr_84300F8DA55BE923D593C180FA2AE7A1D7", var_4, var_7, "_encstr_959506B911C79707", "_encstr_81C90E0E1B48381A7DB3FBA789AD3363");
    } else
      var_6 = cac_getloadoutarchetypeperk();

    if(isDefined(var_6) && var_6 != "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249") {
      var_0.loadoutperks[var_0.loadoutperks.size] = var_6;
      self.pers["_encstr_88241078EF8B28200F7B666B5FA3A3DA28A3"] = var_6;
      var_0.loadoutrigtrait = var_6;
    }

    var_7 = getclassindex(var_1);
    return;
  }
}

loadout_getclasstype(var_0) {
  var_1 = loadout_getclassteam(var_0);

  if(var_1 == "_encstr_8BBA05185F8B99" && !isDefined(var_0))
    return "_encstr_BD34078D57B9A37BD6";

  if(var_1 != "_encstr_8BBA05185F8B99")
    return "_encstr_8AEF05472BC2D6";
  else if(issubstr(var_0, "_encstr_BD34078D57B9A37BD6"))
    return "_encstr_BD34078D57B9A37BD6";
  else if(var_0 == "_encstr_AAAC09D09972B9C83F2B7F")
    return "_encstr_AAAC09D09972B9C83F2B7F";
  else if(issubstr(var_0, "_encstr_A90B0D7BF38003BF978062EAA87DCF"))
    return "_encstr_A90B0D7BF38003BF978062EAA87DCF";
  else if(var_0 == "_encstr_A7AA09C616D81B26586CB5")
    return "_encstr_A7AA09C616D81B26586CB5";
  else if(var_0 == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")
    return "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
  else if(var_0 == "_encstr_97E80747B0C3B98211")
    return "_encstr_97E80747B0C3B98211";
  else
    return "_encstr_8B1608EC43B8D647A113";
}

_id_1194E(var_0, var_1) {
  var_2 = loadout_getclasstype(var_1);

  switch (var_2) {
    case "_encstr_8AEF05472BC2D6":
      break;
    case "_encstr_BD34078D57B9A37BD6":
      break;
    case "_encstr_A90B0D7BF38003BF978062EAA87DCF":
      break;
    case "_encstr_AAAC09D09972B9C83F2B7F":
      _id_1194F(var_0, var_1);
      break;
    case "_encstr_A7AA09C616D81B26586CB5":
      break;
    case "_encstr_8B1608EC43B8D647A113":
      break;
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      break;
  }

  return var_0;
}

loadout_updateclass(var_0, var_1) {
  if(!isagent(self) && self calloutmarkerping_getEnt() && getdvarint("_encstr_B4861F7F779659CED8D34ED78C5011226183F7E79FBDC394B018C41841F051EAC8", 1) == 1 && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    var_1 = "_encstr_8B1608EC43B8D647A113" + (randomint(5) + 1);

  var_2 = loadout_getclasstype(var_1);

  switch (var_2) {
    case "_encstr_8AEF05472BC2D6":
      loadout_updateclassteam(var_0, var_1);
      break;
    case "_encstr_BD34078D57B9A37BD6":
      loadout_updateclasscustom(var_0, var_1);
      break;
    case "_encstr_AAAC09D09972B9C83F2B7F":
      loadout_updateclassgamemode(var_0, var_1);
      break;
    case "_encstr_A90B0D7BF38003BF978062EAA87DCF":
      zone_get_node_nearest_2d_bounds(var_0, var_1);
      break;
    case "_encstr_A7AA09C616D81B26586CB5":
      loadout_updateclasscallback(var_0);
      break;
    case "_encstr_8B1608EC43B8D647A113":
      loadout_updateclassdefault(var_0, var_1);
      break;
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      break;
    case "_encstr_97E80747B0C3B98211":
      break;
  }

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]))
    self.pers["_encstr_8D7219B4C7F706C592BD3D83B01856F377308FD8D11E3488E5990A"] = scripts\mp\teams::pickdefaultoperatorskin(var_0.loadoutprimary);

  loadout_updatehasnvg(var_0);
  loadout_updateclassfistweapons(var_0);
  loadout_updatestreaktype(var_0);
  loadout_updateabilities(var_0, var_1);
  var_0 = loadout_validateclass(var_0, var_1);

  if(!isbot(self) && isDefined(level.set_systems_init_flag) && level.set_systems_init_flag)
    zvelscale(var_0);
  else
    loadout_updateclassfinalweapons(var_0);

  if(isDefined(level._id_11C88))
    self[[level._id_11C88]](var_0);

  return var_0;
}

loadout_updateclassfistweapons(var_0) {
  if(isDefined(level.set_systems_init_flag) && level.set_systems_init_flag && issameweapon(var_0.loadoutprimary))
    var_0.loadoutprimary = var_0.loadoutprimary;
  else if(var_0.loadoutprimary == "_encstr_8BBA05185F8B99")
    var_0.loadoutprimary = "_encstr_A7ED0AD79F73990E28334B92";

  if(scripts\mp\utility\game::handle_carry_special_item()) {
    if(var_0.loadoutsecondary == "_encstr_8BBA05185F8B99")
      var_0.loadoutsecondary = "_encstr_8BBA05185F8B99";
  } else if(var_0.loadoutsecondary == "_encstr_8BBA05185F8B99" && var_0.loadoutprimary != "_encstr_A7ED0AD79F73990E28334B92" && !istrue(self.isjuggernaut))
    var_0.loadoutsecondary = "_encstr_A7ED0AD79F73990E28334B92";
  else if(var_0.loadoutprimary == "_encstr_A7ED0AD79F73990E28334B92" && var_0.loadoutsecondary == "_encstr_A7ED0AD79F73990E28334B92")
    var_0.loadoutsecondary = "_encstr_8BBA05185F8B99";
}

loadout_updatehasnvg(var_0) {
  if(scripts\cp_mp\utility\game_utility::isnightmap())
    var_0.loadouthasnvg = 1;
}

loadout_validateclass(var_0, var_1) {
  var_2 = scripts\mp\utility\game::isanymlgmatch() && issubstr(var_1, "_encstr_8B1608EC43B8D647A113");

  if(issubstr(var_1, "_encstr_BD34078D57B9A37BD6") || var_2)
    return scripts\mp\validation::validateloadout(var_0);

  return var_0;
}

loadout_forcearchetype(var_0) {
  var_1 = getdvarint("_encstr_870D0F99F69CB1B2A027361AAC8E2FC1CA", 0);

  if(var_1 > 0) {
    var_2 = getdvarint("_encstr_870D0F99F69CB1B2A027361AAC8E2FC1CA", 0);

    switch (var_2) {
      case 1:
        var_0.loadoutarchetype = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
        break;
      default:
        var_0.loadoutarchetype = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
        break;
    }
  } else if(var_1 == -1) {
    var_3 = ["_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D"];
    var_4 = randomint(var_3.size);
    var_0.loadoutarchetype = var_3[var_4];
    self iprintlnbold("_encstr_92E0131A3A83494F59608D93131CDAC3DA7B77CAA9" + var_3[var_4]);
  }
}

loadout_updateplayerarchetype(var_0) {
  if(!istrue(self.btestclient)) {
    if(!isDefined(level.aonrules) || level.aonrules == 0) {}
  }

  self.loadoutarchetype = var_0.loadoutarchetype;
  scripts\mp\weapons::updatemovespeedscale();
  var_1 = 1;
  var_2 = 2;
  var_3 = 4;
  var_4 = 8;
  var_5 = 0;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = 400;
  var_9 = 400;
  var_10 = 900;

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_9 = 133.333;
    var_10 = 1800;
  }

  switch (self.loadoutarchetype) {
    case "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D":
      var_5 = var_1 | var_2 | var_3;
      var_6 = scripts\mp\archetypes\archassault::applyarchetype;
      var_7 = "_encstr_BEE00A93594E2BE548C7786C";
      self.clothtype = var_7;
      break;
    default:
      if(!istrue(self.btestclient)) {
        if(!isDefined(level.aonrules) || level.aonrules == 0) {}
      }

      break;
  }

  self setcamerathirdperson(0);

  if(getdvarint("_encstr_8C4B1B9A71EE373F11238F37B71346A782AB4243F93EE776B8038069C9")) {
    self allowdoublejump(var_5 &var_1);
    self allowwallrun(var_5 &var_3);
    self allowdodge(var_5 &var_4);
  } else {
    self allowdoublejump(0);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowslide(var_5 &var_2);
  self allowlean(0);
  self energy_setmax(0, var_8);
  self energy_setenergy(0, var_8);
  self energy_setrestorerate(0, var_9);
  self energy_setresttimems(0, var_10);
  self energy_setmax(1, 50);
  self energy_setenergy(1, 50);
  self energy_setrestorerate(1, 10);
  self energy_setresttimems(1, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 2500, 0));

  if(isDefined(var_6))
    self[[var_6]]();
}

loadout_updateclassfinalweapons(var_0) {
  if(istrue(var_0._id_11960))
    var_0.loadoutprimaryobject = fixsuperforbr(var_0.loadoutprimary, var_0.loadoutprimaryattachments, var_0.loadoutprimarycamo, var_0.loadoutprimaryreticle, var_0.loadoutprimaryvariantid, var_0.loadoutprimaryattachmentids, var_0.loadoutprimarycosmeticattachment, var_0.loadoutprimarystickers, istrue(var_0.loadouthasnvg));
  else
    var_0.loadoutprimaryobject = buildweapon(var_0.loadoutprimary, var_0.loadoutprimaryattachments, var_0.loadoutprimarycamo, var_0.loadoutprimaryreticle, var_0.loadoutprimaryvariantid, var_0.loadoutprimaryattachmentids, var_0.loadoutprimarycosmeticattachment, var_0.loadoutprimarystickers, istrue(var_0.loadouthasnvg));

  var_0.loadoutprimaryfullname = createheadicon(var_0.loadoutprimaryobject);

  if(var_0.loadoutsecondary == "_encstr_8BBA05185F8B99") {
    var_0.loadoutsecondaryfullname = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondaryobject = undefined;
  } else {
    if(istrue(var_0._id_11961))
      var_0.loadoutsecondaryobject = fixsuperforbr(var_0.loadoutsecondary, var_0.loadoutsecondaryattachments, var_0.loadoutsecondarycamo, var_0.loadoutsecondaryreticle, var_0.loadoutsecondaryvariantid, var_0.loadoutsecondaryattachmentids, var_0.loadoutsecondarycosmeticattachment, var_0.loadoutsecondarystickers, istrue(var_0.loadouthasnvg));
    else
      var_0.loadoutsecondaryobject = buildweapon(var_0.loadoutsecondary, var_0.loadoutsecondaryattachments, var_0.loadoutsecondarycamo, var_0.loadoutsecondaryreticle, var_0.loadoutsecondaryvariantid, var_0.loadoutsecondaryattachmentids, var_0.loadoutsecondarycosmeticattachment, var_0.loadoutsecondarystickers, istrue(var_0.loadouthasnvg));

    var_0.loadoutsecondaryfullname = createheadicon(var_0.loadoutsecondaryobject);
  }

  if(var_0.loadoutmeleeslot != "_encstr_8BBA05185F8B99") {
    self giveweapon(var_0.loadoutmeleeslot);
    self assignweaponmeleeslot(var_0.loadoutmeleeslot);
  }
}

loadout_updateplayerweapons(var_0, var_1, var_2, var_3) {
  var_4 = respawnitems_getrespawnitems();
  var_5 = respawnitems_hasweapondata(var_4);
  var_6 = level.magcount;
  var_7 = loadout_giveprimaryweapon(var_0, var_4, var_5);
  var_8 = loadout_givesecondaryweapon(var_0, var_4, var_5);
  zombievehiclelaststand(var_0, var_7, var_8, var_4, var_5, var_6);
  self.loadoutmeleeslot = var_0.loadoutmeleeslot;

  if(!isDefined(var_7))
    scripts\mp\utility\script::laststand_dogtags(var_0.loadoutprimary);

  if(isDefined(var_7) && self hasweapon(var_7))
    var_9 = var_7;
  else
    var_9 = var_8;

  if(isDefined(var_8) && var_8.basename != "_encstr_8BBA05185F8B99" && isDefined(var_7) && var_7.basename == "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C")
    var_9 = var_8;

  if(!isai(self))
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_9);

  if(!isDefined(var_2) || var_2) {
    var_3 = shouldskipfirstraise(var_9, var_3);

    if(!isagent(self))
      self setspawnweapon(var_9, !var_3);
  }

  self.spawnweaponobj = var_9;
  _id_11951();
}

zombierespawning() {
  if(isDefined(self.primaryweaponobj) && !self hasweapon(self.primaryweaponobj)) {
    loadout_giveprimaryweapon(self.classstruct);
    thread _id_13C58();
  }

  if(isDefined(self.secondaryweaponobj) && !self hasweapon(self.secondaryweaponobj)) {
    loadout_givesecondaryweapon(self.classstruct);
    thread _id_13C58();
  }
}

loadout_giveprimaryweapon(var_0, var_1, var_2) {
  self.loadoutprimary = var_0.loadoutprimary;
  self.loadoutprimarycamo = var_0.loadoutprimarycamo;
  self.loadoutprimaryattachments = var_0.loadoutprimaryattachments;
  self.loadoutprimaryattachmentids = var_0.loadoutprimaryattachmentids;
  self.loadoutprimaryreticle = var_0.loadoutprimaryreticle;
  self.loadoutprimarylootitemid = var_0.loadoutprimarylootitemid;
  self.loadoutprimaryvariantid = var_0.loadoutprimaryvariantid;
  var_3 = zombiespawninair("_encstr_BA7F0830B3A7859B60B0", var_0.loadoutprimaryobject, var_1, var_2);
  self.primaryweapon = var_0.loadoutprimaryfullname;
  self.primaryweaponobj = var_0.loadoutprimaryobject;
  self.pers["_encstr_BE310E88C361A8C3DBA8445586D31770"] = var_0.loadoutprimaryfullname;
  return var_3;
}

loadout_givesecondaryweapon(var_0, var_1, var_2) {
  self.loadoutsecondary = var_0.loadoutsecondary;
  self.loadoutsecondarycamo = var_0.loadoutsecondarycamo;
  self.loadoutsecondaryattachments = var_0.loadoutsecondaryattachments;
  self.loadoutsecondaryattachmentids = var_0.loadoutsecondaryattachmentids;
  self.loadoutsecondaryreticle = var_0.loadoutsecondaryreticle;
  self.loadoutsecondarylootitemid = var_0.loadoutsecondarylootitemid;
  self.loadoutsecondaryvariantid = var_0.loadoutsecondaryvariantid;
  var_3 = zombiespawninair("_encstr_AC8F0AE74163F85AAA380AD8", var_0.loadoutsecondaryobject, var_1, var_2);
  self.secondaryweapon = var_0.loadoutsecondaryfullname;
  self.secondaryweaponobj = var_0.loadoutsecondaryobject;
  self.pers["_encstr_85891093AA774080F789052B879FB0971F72"] = var_0.loadoutsecondaryfullname;
  return var_3;
}

zombiespawninair(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(!istrue(var_3))
    var_4 = var_1;
  else
    var_4 = respawnitems_getweaponobj(var_2, var_0);

  if(!getqueuedspleveltransients(var_4)) {
    if(scripts\mp\riotshield::isriotshield(var_4) && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && isDefined(self.infil) && !istrue(self.stopchallengetimers)) {} else {
      var_4 = scripts\mp\weapons::updatesavedaltstate(var_4);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_4, undefined, undefined, 1);
      scripts\mp\weapons::updatetogglescopestate(var_4);
      scripts\mp\perks\weaponpassives::loadoutweapongiven(var_4);
    }
  }

  return var_4;
}

zombievehiclelaststand(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(isDefined(var_0.loadoutprimaryobject) && var_0.loadoutprimaryobject.basename != "_encstr_8BBA05185F8B99")
    var_6[var_6.size] = var_0.loadoutprimaryobject;

  if(isDefined(var_0.loadoutsecondaryobject) && var_0.loadoutsecondaryobject.basename != "_encstr_8BBA05185F8B99")
    var_6[var_6.size] = var_0.loadoutsecondaryobject;

  foreach(var_8 in var_6)
  var_8.should_spawn_boss_one = var_8 hasattachment("_encstr_B45E080DA3A03EDFD998", 1);

  if(isDefined(level._id_11C73))
    self[[level._id_11C73]](var_6);
  else if(istrue(var_4)) {
    respawnitems_giveweaponammo(var_3, "_encstr_BA7F0830B3A7859B60B0");
    respawnitems_giveweaponammo(var_3, "_encstr_AC8F0AE74163F85AAA380AD8");
  } else if(var_5 != 3) {
    if(isDefined(var_1))
      spawnammocountoverride_giveweaponammo(var_1, "_encstr_BA7F0830B3A7859B60B0", var_5);

    if(isDefined(var_2))
      spawnammocountoverride_giveweaponammo(var_2, "_encstr_AC8F0AE74163F85AAA380AD8", var_5);
  } else {
    foreach(var_8 in var_6) {
      if(istrue(var_8.should_spawn_boss_one)) {
        var_11 = weaponmaxammo(var_8) - weaponstartammo(var_8);
        var_12 = self getweaponammostock(var_8);
        self setweaponammostock(var_8, var_12 + var_11);
      }
    }
  }

  if(!istrue(var_4) && var_5 == 3) {
    foreach(var_8 in var_6) {
      if(istrue(var_8.hasalternate)) {
        var_15 = var_8 getaltweapon();
        var_16 = weaponclass(var_15);

        if(var_16 == "_encstr_8C8D08671D451291C849" && istrue(var_8.should_spawn_boss_one))
          self setweaponammostock(var_15, 1);
        else if(var_16 == "_encstr_A1100738A33A638123")
          self setweaponammoclip(var_15, scripts\engine\utility::ter_op(istrue(var_8.should_spawn_boss_one), 8, 6));

        continue;
      }

      if(scripts\mp\utility\weapon::turnexfiltoside(var_8))
        self setweaponammostock(var_8, self getweaponammostock(var_8) + weaponclipsize(var_8) * 3);
    }
  }
}

_id_11951() {
  scripts\mp\weapons::updatemovespeedscale();
}

loadout_updateplayerperks(var_0) {
  loadout_giveperk("_encstr_9A871B9BA008488198DBDB8B56AADD04615713F4EB11F882C28BC8D057");

  if(scripts\mp\utility\game::islaststandenabled())
    scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");

  loadout_giveperk("_encstr_A2821B5F1039FB0A6391B3E810112283C158AFA758D63D729D3AFC2564");

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    loadout_giveperk("_encstr_A97E1950E1284F5BE2D1630BF78B3BDF7E0AA713C1FDC285A81598");

  if(var_0.loadoutstandardperks.size > 0) {
    var_1 = getdvarint("_encstr_A76D149BD827AF36B71623BD5747419527ADCDF4CC66", 0) == 0;

    if(var_1)
      scripts\mp\perks\perks::giveperks(var_0.loadoutperks, 0);
  }

  self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = var_0.loadoutperks;
  self.pers["_encstr_AA67151BD081D442538512D3673DAA994B3063A7D0381B"] = var_0.loadoutstandardperks;
  self.pers["_encstr_97EA12B1B7C223DBBA3A8AE1A327582859C95BE6"] = var_0.loadoutextraperks;
  self.pers["_encstr_88241078EF8B28200F7B666B5FA3A3DA28A3"] = var_0.loadoutrigtrait;
  self.pers["_encstr_BD7517A417C0D76F6D53B1DBD8C897C2A0FB2339A310DC5795"] = var_0.loadoutusingspecialist;

  if(isDefined(self.avoidkillstreakonspawntimer) && self.avoidkillstreakonspawntimer > 0)
    thread scripts\mp\perks\perks::giveperksafterspawn();

  if(!isagent(self) && scripts\mp\utility\dvars::getintproperty("_encstr_9351151ECB634657AC4A784882423F9BBF7EA617218FA8", 1) == 1 && game["_encstr_A1AD062E09D98338"] != "_encstr_ACE709DA22939BA8075060")
    scripts\mp\perks\perks::setomnvarsforperklist("_encstr_85E20F57B4EB6E8358DDB9BEC159275BF5", self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"]);
}

loadout_updateplayerequipment(var_0) {
  var_1 = respawnitems_getrespawnitems();
  var_2 = respawnitems_hasequipmentdata(var_1);
  self.loadoutequipmentprimary = var_0.loadoutequipmentprimary;
  self.loadoutequipmentsecondary = var_0.loadoutequipmentsecondary;
  var_3 = undefined;

  if(!var_2)
    var_3 = var_0.loadoutequipmentprimary;
  else
    var_3 = respawnitems_getequipmentref(var_1, "_encstr_BA7F0830B3A7859B60B0");

  var_4 = undefined;

  if(!var_2)
    var_4 = var_0.loadoutequipmentsecondary;
  else
    var_4 = respawnitems_getequipmentref(var_1, "_encstr_AC8F0AE74163F85AAA380AD8");

  scripts\mp\equipment::giveequipment(var_3, "_encstr_BA7F0830B3A7859B60B0");
  scripts\mp\equipment::giveequipment(var_4, "_encstr_AC8F0AE74163F85AAA380AD8");

  if(var_2) {
    respawnitems_giveequipmentammo(var_1, "_encstr_BA7F0830B3A7859B60B0");
    respawnitems_giveequipmentammo(var_1, "_encstr_AC8F0AE74163F85AAA380AD8");
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    thread scripts\mp\equipment\nvg::runnvg();
    thread loadout_updateplayernvgs();
  }
}

loadout_updateplayernvgs() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_8BB619A877A9491FEBABAF1D82D24BF315233048D7454365811F0E");
  self endon("_encstr_8BB619A877A9491FEBABAF1D82D24BF315233048D7454365811F0E");
  var_0 = 0;

  if(game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0 && !istrue(self.hasspawned)) {
    if(!scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") || scripts\mp\flags::gameflag("_encstr_8C0D0E8410E8B112602F133F559DCAF4"))
      var_0 = 1;
  } else if(istrue(self.pers["_encstr_BDAA073552DA154FC7"]))
    var_0 = 1;

  if(istrue(self.inspawncamera))
    scripts\engine\utility::_id_143A5("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527", "_encstr_867E0DE2A9B51FDB1027D3DC7328DB");

  while(!isDefined(self.operatorcustomization))
    waitframe();

  if(var_0)
    self nightvisionviewon(1);

  scripts\mp\equipment\nvg::nvg_update3rdperson(var_0);
}

loadout_updateplayersuper(var_0) {
  var_1 = scripts\cp_mp\vehicles\light_tank::light_tank_supported();

  if(!var_1 && var_0.loadoutsuper == "_encstr_92520EE65707594E7D894E1646C62BE5")
    var_0.loadoutsuper = "_encstr_8A8B1187B763D5F82F6A51E959EB8898FB032B";

  var_2 = var_0.loadoutsuper;
  var_3 = respawnitems_getrespawnitems();
  var_4 = respawnitems_hassuperdata(var_3);

  if(var_4)
    var_2 = respawnitems_getsuperref(var_3);

  if(isDefined(scripts\mp\supers::getcurrentsuper())) {
    var_5 = scripts\mp\supers::getcurrentsuperref();

    if(var_5 == var_2 && !haschangedarchetype()) {
      scripts\mp\supers::givesuperweapon(self.super);
      return;
    }
  }

  if(var_2 == "_encstr_8BBA05185F8B99" || !level.allowsupers) {
    scripts\mp\supers::clearsuper();
    self.loadoutsuper = undefined;
  } else if(level.allowsupers && isDefined(self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]) && isDefined(self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_85920D9D304BCAFF3B38EF7F3011BA"])) {
    self.loadoutsuper = self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_85920D9D304BCAFF3B38EF7F3011BA"];
    scripts\mp\supers::givesuper(self.loadoutsuper, 1);
  } else if(var_2 == "_encstr_92520EE65707594E7D894E1646C62BE5" && !scripts\cp_mp\vehicles\light_tank::light_tank_supported()) {
    scripts\mp\supers::clearsuper();
    self.loadoutsuper = undefined;
  } else {
    self.loadoutsuper = var_0.loadoutsuper;
    scripts\mp\supers::givesuper(var_2, 1);

    if(var_4) {
      scripts\mp\supers::setsuperbasepoints(respawnitems_getsuperpoints(var_3));
      scripts\mp\supers::setsuperextrapoints(respawnitems_getsuperextrapoints(var_3));
    }
  }
}

loadout_updateplayergesture(var_0) {
  if(!istrue(self.btestclient)) {
    if(var_0.loadoutgesture != "_encstr_8BBA05185F8B99") {
      self.loadoutgesture = var_0.loadoutgesture;
      scripts\cp_mp\gestures::givegesture(var_0.loadoutgesture);
    }
  }
}

zombiethermalon(var_0) {
  var_1 = getdvarint("_encstr_B47D193A766D59E34087E00963F3085F0EAB2B5F6EA51EA35FC0CD", 0);

  if(var_1 && isDefined(var_0.loadoutaccessorydata)) {
    var_2 = scripts\mp\accessories::register_script_model_animation(var_0.loadoutaccessorydata);

    if(isDefined(var_2) && var_2 == "_encstr_AF0703BB78")
      return 1;
  }

  return 0;
}

loadout_updateplayeraccessory(var_0) {
  if(!istrue(self.btestclient)) {
    if(isDefined(var_0.loadoutaccessoryweapon) && var_0.loadoutaccessoryweapon != "_encstr_8BBA05185F8B99") {
      if(zombiethermalon(var_0)) {
        return;
      }
      self.loadoutaccessorydata = var_0.loadoutaccessorydata;
      self.loadoutaccessoryweapon = var_0.loadoutaccessoryweapon;
      scripts\mp\accessories::giveplayeraccessory(var_0.loadoutaccessorydata, var_0.loadoutaccessoryweapon, var_0.loadoutaccessorylogic);
    }
  }
}

loadout_updateplayerstreaktype(var_0) {
  self.streaktype = loadout_getplayerstreaktype(var_0.loadoutstreaktype);
}

loadout_updateplayerkillstreaks(var_0, var_1) {
  if(!level.allowkillstreaks) {
    var_0.loadoutkillstreak1 = "_encstr_8BBA05185F8B99";
    var_0.loadoutkillstreak2 = "_encstr_8BBA05185F8B99";
    var_0.loadoutkillstreak3 = "_encstr_8BBA05185F8B99";
  }

  if(var_0.loadoutstreaksfilled == 0 && isDefined(self.streakdata) && self.streakdata.streaks.size > 0 && var_1 == "_encstr_AAAC09D09972B9C83F2B7F") {
    var_2 = 0;

    foreach(var_4 in self.streakdata.streaks) {
      if(var_2 == 0) {
        var_0.loadoutkillstreak1 = var_4;
        var_2++;
        continue;
      }

      if(var_2 == 1) {
        var_0.loadoutkillstreak2 = var_4;
        var_2++;
        continue;
      }

      if(var_2 == 2) {
        var_0.loadoutkillstreak3 = var_4;
        break;
      }
    }
  }

  if(scripts\mp\utility\game::usefloorrocks()) {
    var_2 = 0;
    var_6 = getDvar("_encstr_A2DD246EC6C9AF9D85D659D7B18D85E69BE8B0311B59D76EA39C5916ADEB7BB3B239932D322B", "_encstr_AB6628D5360B316B12CF484B8F51C0FDE15E43DE0A8355B0E3E73A608F62591FFBC4C86866DA477BD153");

    if(var_6 != "_encstr_B40101") {
      var_6 = strtok(var_6, "_encstr_964C0249");

      foreach(var_4 in var_6) {
        if(var_2 == 0) {
          var_0.loadoutkillstreak1 = var_6[0];
          var_2++;
          continue;
        }

        if(var_2 == 1) {
          var_0.loadoutkillstreak2 = var_6[1];
          var_2++;
          continue;
        }

        if(var_2 == 2) {
          var_0.loadoutkillstreak3 = var_6[2];
          break;
        }
      }
    }
  }

  if(level.allowkillstreaks && getDvar("_encstr_A2E3197B3835F1801D3BCBDBF46BD5316A575C501AC8EBBD0B873B", "_encstr_B40101") != "_encstr_B40101") {
    var_9 = [];

    if(getDvar("_encstr_9B05190FFEB8E7EBE528B3D3E37C5801EC7F3C28FE4BB32B986266", "_encstr_B40101") != "_encstr_B40101") {
      var_9 = strtok(getDvar("_encstr_9B05190FFEB8E7EBE528B3D3E37C5801EC7F3C28FE4BB32B986266", "_encstr_B40101"), "_encstr_974C0246");

      for(var_10 = 0; var_10 < 3; var_10++) {
        if(var_10 < var_9.size) {
          var_11 = var_9[var_10];

          if(!isDefined(level.killstreaksetups[var_11]))
            var_9[var_10] = "_encstr_8BBA05185F8B99";

          continue;
        }

        var_9[var_10] = "_encstr_8BBA05185F8B99";
      }
    } else {
      var_9[0] = "_encstr_A2E60C6BC099B7E1A0A93A398F48";
      var_9[1] = "_encstr_8C980A867B3B569CFAA659E8";
      var_9[2] = "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A";
    }

    var_12 = strtok(getDvar("_encstr_A2E3197B3835F1801D3BCBDBF46BD5316A575C501AC8EBBD0B873B", "_encstr_B40101"), "_encstr_974C0246");

    foreach(var_14 in var_12) {
      if(var_0.loadoutkillstreak1 == var_14) {
        var_0.loadoutkillstreak1 = var_9[0];
        continue;
      }

      if(var_0.loadoutkillstreak2 == var_14) {
        var_0.loadoutkillstreak2 = var_9[1];
        continue;
      }

      if(var_0.loadoutkillstreak3 == var_14)
        var_0.loadoutkillstreak3 = var_9[2];
    }
  }

  var_16 = [var_0.loadoutkillstreak1, var_0.loadoutkillstreak2, var_0.loadoutkillstreak3];

  if(level.allowkillstreaks) {
    self.pers["_encstr_88F00E86851BD6CA91A9D127590B6DDC"] = 0;
    var_16 = replacetankwithwheelson(var_0);
  }

  self.loadoutusingspecialist = var_0.loadoutusingspecialist;
  self getfollowedplayer(self.loadoutusingspecialist);

  if(var_0.loadoutusingspecialist && level.allowkillstreaks)
    var_16 = replacewithspecialistkillstreaks(var_0);

  var_17 = respawnitems_getrespawnitems();
  var_18 = respawnitems_hasstreakdata(var_17);

  if(var_18 && level.allowkillstreaks)
    var_16 = respawnitems_getstreaks(var_17);

  if(level.allowkillstreaks)
    var_16 = sortkillstreaksbycost(var_16);

  if(!isagent(self)) {
    var_19 = scripts\mp\killstreaks\killstreaks::arekillstreaksequipped(var_16);

    if(!var_19) {
      self notify("_encstr_A9960ED401B340ADAFB8F880D245433B");
      var_20 = scripts\mp\killstreaks\killstreaks::getgimmeslotkillstreakstructs();
      var_21 = scripts\mp\killstreaks\killstreaks::getavailableequippedkillstreakstructs();

      if(!scripts\mp\utility\perk::_hasperk("_encstr_A29E1E378356D85A16C63A97D7DCD583C1B7931DFA5B2DC6D8DC3A93B20BDA6E") && !isDefined(self.earnedmaxkillstreak))
        scripts\mp\killstreaks\killstreaks::clearkillstreaks();

      for(var_22 = 0; var_22 < var_16.size; var_22++) {
        var_23 = var_16[var_22];

        if(isDefined(var_23) && var_23 != "_encstr_8BBA05185F8B99" && var_23 != "_encstr_B40101")
          scripts\mp\killstreaks\killstreaks::equipkillstreak(var_23, var_22 + 1);
      }

      for(var_24 = var_20.size - 1; var_24 >= 0; var_24--) {
        var_23 = var_20[var_24];

        if(!var_23.isspecialist)
          scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct(var_20[var_24], "_encstr_8261067B1D34AC27");
      }

      for(var_24 = 0; var_24 < var_21.size; var_24++) {
        var_23 = var_21[var_24];

        if(!var_23.isspecialist)
          scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct(var_21[var_24], "_encstr_8261067B1D34AC27");
      }
    }
  }

  self notify("_encstr_BD4C19FA831517AAE113A4BC3F40726FB77813506860CFA2D063A4");
}

sortkillstreaksbycost(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    if(isDefined(var_0[var_1]) && var_0[var_1] != "_encstr_8BBA05185F8B99" && var_0[var_1] != "_encstr_B40101") {
      for(var_2 = var_1 + 1; var_2 < var_0.size; var_2++) {
        if(isDefined(var_0[var_2]) && var_0[var_2] != "_encstr_8BBA05185F8B99" && var_0[var_2] != "_encstr_B40101") {
          var_3 = scripts\mp\killstreaks\killstreaks::calcstreakcost(var_0[var_1]);
          var_4 = scripts\mp\killstreaks\killstreaks::calcstreakcost(var_0[var_2]);

          if(var_4 < var_3) {
            var_5 = var_0[var_2];
            var_0[var_2] = var_0[var_1];
            var_0[var_1] = var_5;
          }
        }
      }
    }
  }

  return var_0;
}

loadout_updateplayeractionslots(var_0, var_1) {
  self setactionslot(3, "_encstr_B4DC085639F9C2779108");
}

loadout_updatefieldupgrades(var_0, var_1) {
  if(var_1 == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
    return;
  }
  self.loadoutfieldupgrade1 = var_0.loadoutfieldupgrade1;
  self.loadoutfieldupgrade2 = var_0.loadoutfieldupgrade2;

  if(setgamebattleplayerstats(self.loadoutfieldupgrade1))
    self.loadoutfieldupgrade1 = "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D";

  if(setgamebattleplayerstats(self.loadoutfieldupgrade2))
    self.loadoutfieldupgrade2 = "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D";

  if(scripts\mp\utility\game::isanymlgmatch() || self.loadoutfieldupgrade1 == self.loadoutfieldupgrade2)
    self.loadoutfieldupgrade2 = "_encstr_8BBA05185F8B99";

  if(level.allowsupers) {
    var_2 = scripts\cp_mp\utility\game_utility::getmapname();

    if(issubstr(var_2, "_encstr_AA1606AD077DB6FA") && var_2 != "_encstr_A5110B50E25F68A83BD3D3EBBB") {
      self.loadoutfieldupgrade1 = player_give_killstreak(self.loadoutfieldupgrade1);
      self.loadoutfieldupgrade2 = player_give_killstreak(self.loadoutfieldupgrade2);

      if(self.loadoutfieldupgrade1 == self.loadoutfieldupgrade2)
        self.loadoutfieldupgrade2 = "_encstr_8BBA05185F8B99";
    }

    thread scripts\mp\supers::watchplayersuperdelayweapon();
    thread scripts\mp\perks\perkpackage::perkpackage_initperkpackages();

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
      var_3 = player_get_carepackage_sentry(self.loadoutfieldupgrade1);

      if(isDefined(level.forcegivesuper)) {
        self[[level.forcegivesuper]](var_3);
        return;
      }

      return;
    }
  } else if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    self._id_11954 = player_get_carepackage_sentry(self.loadoutfieldupgrade1);

    if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
      if(isDefined(level.forcegivesuper))
        self[[level.forcegivesuper]]("_encstr_96F610C7E33F527201D9B5BD3029AC9B1841");
    }

    self.loadoutfieldupgrade1 = "_encstr_8BBA05185F8B99";
    self.loadoutfieldupgrade2 = "_encstr_8BBA05185F8B99";

    if(getdvarint("_encstr_933B11DC6C93FA23D2B91631C65914AC4ED69B", 0) == 0)
      scripts\mp\perks\perkpackage::perkpackage_initpersdata();
  }
}

player_get_carepackage_sentry(var_0) {
  if(!isDefined(var_0) || var_0 == "_encstr_8BBA05185F8B99")
    return "_encstr_96F610C7E33F527201D9B5BD3029AC9B1841";

  return var_0;
}

player_give_killstreak(var_0) {
  switch (var_0) {
    case "_encstr_B12F1220EBA20B8BB7A7656F984F30B70F0348C0":
    case "_encstr_995B109BAB0756E47DCA5B837D914EEDB995":
    case "_encstr_955F12039B0FAFA2B9AD353BBF18A113B6704AEA":
      var_0 = "_encstr_96F610C7E33F527201D9B5BD3029AC9B1841";
      break;
    default:
      break;
  }

  return var_0;
}

loadout_updateplayer(var_0, var_1, var_2, var_3, var_4) {
  loadout_updateplayerstreaktype(var_1);
  loadout_updateplayerarchetype(var_1);

  if(!istrue(level.noweaponsonstart))
    loadout_updateplayerweapons(var_1, var_2, var_3, var_4);

  loadout_updateplayerperks(var_1);

  if(!istrue(level.noweaponsonstart))
    loadout_updateplayerequipment(var_1);

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]) && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    loadout_updateplayerkillstreaks(var_1, var_2);

  loadout_updateplayeractionslots(var_1, var_2);

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]))
    loadout_updatefieldupgrades(var_0, var_2);

  self.pers["_encstr_92690A5B078ED325F539E25E"] = self.class;
  self.lastclass = self.class;
  self.lastarchetypeinfo = self.changedarchetypeinfo;

  if(isDefined(self.gamemode_chosenclass)) {
    self.pers["_encstr_959506B911C79707"] = self.gamemode_chosenclass;
    self.pers["_encstr_92690A5B078ED325F539E25E"] = self.gamemode_chosenclass;
    self.class = self.gamemode_chosenclass;
    self.lastclass = self.gamemode_chosenclass;
    self.gamemode_chosenclass = undefined;
  }

  if(isDefined(self.revive_chosenclass)) {
    self.pers["_encstr_959506B911C79707"] = self.revive_chosenclass;
    self.pers["_encstr_92690A5B078ED325F539E25E"] = self.revive_chosenclass;
    self.class = self.revive_chosenclass;
    self.lastclass = self.revive_chosenclass;
  }

  scripts\mp\teams::setupplayermodel();
  loadout_updateplayeraccessory(var_1);
}

setmlgspectatorclientloadoutdata(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_B6BA232317243971282F89BBF7C33F38C72AAD58BC9D7825F0F7A3B12FFBFDC16103115834");
  var_0 endon("_encstr_B6BA232317243971282F89BBF7C33F38C72AAD58BC9D7825F0F7A3B12FFBFDC16103115834");
  var_0 updatemlgammoinfo();
  var_0 disableplayeruseforallplayers(level.laststand);
  var_0 setclientweaponinfo(0, var_1.loadoutprimaryfullname);
  var_0 setclientweaponinfo(1, var_1.loadoutsecondaryfullname);

  if(isDefined(self.equipment["_encstr_BA7F0830B3A7859B60B0"])) {
    var_2 = scripts\mp\equipment::getequipmenttableinfo(self.equipment["_encstr_BA7F0830B3A7859B60B0"]);
    var_0 setclientloadoutinfo("_encstr_A3750D07274B6B164EBCA07BDD5693", var_2.id);
  }

  if(isDefined(self.equipment["_encstr_AC8F0AE74163F85AAA380AD8"])) {
    var_3 = scripts\mp\equipment::getequipmenttableinfo(self.equipment["_encstr_AC8F0AE74163F85AAA380AD8"]);
    var_0 setclientloadoutinfo("_encstr_B2B90FF8DAA6D5DD34496B68D3A08B9F62", var_3.id);
  }

  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
    var_4 = scripts\mp\codcasterclientmatchdata::getcodcasterplayervalue(var_0, "_encstr_99F30B8C2CB50B7695887BB9CA");
    scripts\mp\codcasterclientmatchdata::setcodcasterplayervalue(var_0, "_encstr_99F30B8C2CB50B7695887BB9CA", var_4);
  }

  if(isDefined(self.loadoutfieldupgrade1))
    var_0 setclientloadoutinfo("_encstr_B6760D6431CFD0A9336B48E8929753", scripts\mp\supers::getsuperid(self.loadoutfieldupgrade1));

  var_5 = scripts\mp\supers::getsuperid(var_1.loadoutsuper);
  var_0 setclientloadoutinfo("_encstr_BEB406F03B72BB3B", var_5);

  if(isai(var_0)) {
    for(var_6 = 0; var_6 < var_1.loadoutperks.size; var_6++) {
      var_7 = var_1.loadoutperks[var_6];
      var_8 = scripts\mp\perks\perks::getperkid(var_7);
      var_0 setclientloadoutinfo(var_6 + 1 + "_encstr_A26E0691A86DE310", var_8);
    }
  } else {
    if(var_1.loadoutperksfromgamemode)
      var_1.loadoutstandardperks = var_1.loadoutperks;

    for(var_6 = 0; var_6 < self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"].size; var_6++) {
      var_7 = self.pers["_encstr_86CB0DFB97F7022F90BB3A7F53487B"][var_6];
      var_8 = scripts\mp\perks\perks::getperkid(var_7);
      var_0 setclientloadoutinfo(var_6 + 1 + "_encstr_A26E0691A86DE310", var_8);
    }

    for(var_6 = 0; var_6 < var_1.loadoutextraperks.size; var_6++) {
      var_7 = var_1.loadoutextraperks[var_6];
      var_8 = scripts\mp\perks\perks::getperkid(var_7);
      var_0 setclientloadoutinfo(var_6 + 1 + "_encstr_A2730BFAB21E8EC92C145639DA", var_8);
    }
  }

  var_9 = var_1.loadoutrigtrait;
  var_10 = scripts\mp\perks\perks::getperkid(var_9);
  var_0 setclientloadoutinfo("_encstr_B1A709934BEC4539855A1D", var_10);
  var_11 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(var_1.loadoutarchetype);
  var_0 setclientloadoutinfo("_encstr_96400A3B8A2EB05D3B73D379", var_11);
}

shouldallowinstantclassswap() {
  if(scripts\cp_mp\utility\player_utility::isinvehicle(1) || istrue(self.isjuggernaut))
    disableclassswapallowed();

  if(!isDefined(self.instantclassswapallowed))
    return 1;

  return self.instantclassswapallowed;
}

swaploadout() {
  if(scripts\engine\utility::ent_flag_exist("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223") && scripts\engine\utility::ent_flag("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223")) {
    self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
    self endon("_encstr_81170C244F9CBDE72C01BB99A298");
    self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
    self notify("_encstr_9AC10C9B77C2C162DE16917BAE47");
    self endon("_encstr_9AC10C9B77C2C162DE16917BAE47");

    if(!scripts\engine\utility::ent_flag("_encstr_A939144BAF46E088EA019B2FA56B712B4F109F346317"))
      scripts\engine\utility::ent_flag_set("_encstr_A939144BAF46E088EA019B2FA56B712B4F109F346317");

    self waittill("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223");
  }

  setclass(self.pers["_encstr_959506B911C79707"]);
  self.tag_stowed_back = undefined;
  self.tag_stowed_hip = undefined;
  scripts\mp\weapons::savetogglescopestates();
  scripts\mp\weapons::savealtstates();

  if(scripts\mp\utility\game::allowclasschoice())
    scripts\mp\utility\stats::incpersstat("_encstr_A2710D9E486FC3D0E7406FCD473B8B", 1);

  giveloadout(self.pers["_encstr_8AEF05472BC2D6"], self.pers["_encstr_959506B911C79707"], undefined, 1);
  var_0 = scripts\mp\utility\game::unset_relic_grounded() && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(var_0 && isDefined(level.calculateclientmatchdataextrainfopayload))
    self[[level.calculateclientmatchdataextrainfopayload]]();

  if(scripts\engine\utility::ent_flag_exist("_encstr_A939144BAF46E088EA019B2FA56B712B4F109F346317") && scripts\engine\utility::ent_flag("_encstr_A939144BAF46E088EA019B2FA56B712B4F109F346317")) {
    scripts\engine\utility::ent_flag_clear("_encstr_A939144BAF46E088EA019B2FA56B712B4F109F346317");
    scripts\engine\utility::ent_flag_set("_encstr_922615F7247E402C077F234875145F70E5F3EB80E8C46B");
  }
}

giveloadout(var_0, var_1, var_2, var_3, var_4) {
  self notify("_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");
  self.gettingloadout = 1;

  if(isDefined(self.perks))
    self.oldperks = self.perks;

  loadout_clearplayer(var_3);
  var_5 = zombiesignorevehicleexplosions();
  var_5 = _id_1194E(var_5, var_1);
  self.select_bridge_two_spawners = var_5;
  var_6 = undefined;

  if(isDefined(self.preloadedclassstruct)) {
    var_6 = self.preloadedclassstruct;
    self.preloadedclassstruct = undefined;
    self.class_num = getclassindex(var_1);

    if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
      self setmoverantilagged(self.class_num);
  } else {
    var_6 = loadout_getclassstruct();
    var_6 = loadout_updateclass(var_6, var_1);
  }

  self.classstruct = var_6;
  loadout_updateplayer(var_5, var_6, var_1, var_2, var_4);

  if(var_1 != "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
    if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
      loadout_lognewlygivenloadout(var_5, var_6, var_1);
  }

  self.gettingloadout = 0;
  respawnitems_clear();
  self notify("_encstr_8B840CAA40330BB28F412E40DB59");
  self notify("_encstr_B2030CA0C91D2F44C0B314F8836B");
  scripts\mp\rank::tryresetrankxp();

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]) && !isagent(self))
    scripts\mp\killstreaks\killstreaks::resetforloadoutswitch();

  scripts\mp\playerlogic::trydisableminimap();
}

loadout_lognewlygivenloadout(var_0, var_1, var_2) {
  if(!isPlayer(self) && !isalive(self)) {
    return;
  }
  if(isagent(self)) {
    return;
  }
  if(level.codcasterenabled)
    thread setmlgspectatorclientloadoutdata(self, var_1);

  if(getdvarint("_encstr_A5B60A1F499D8F973153F986") == 0) {
    return;
  }
  if(var_1.uavbestid) {
    var_3 = 99;
    var_4 = "_encstr_97E80747B0C3B98211";
  } else {
    var_3 = getclassindex(var_2);
    var_4 = loadout_getclasstype(var_2);
    var_5 = getsubstr(var_2, 0, 7) == "_encstr_8B1608EC43B8D647A113";

    if(var_5)
      var_3 = var_3 + 20;
  }

  var_6 = var_1.tweakedbyplayerduringmatch || var_1.gamemodeforcednewloadout;
  var_1.tweakedbyplayerduringmatch = 0;
  var_1.gamemodeforcednewloadout = 0;
  var_7 = 0;

  if(!isDefined(self.pers["_encstr_833D0EDDFD979FE570E0012FBFBF1AB6"]))
    self.pers["_encstr_833D0EDDFD979FE570E0012FBFBF1AB6"] = [];

  var_8 = -1;

  foreach(var_12, var_10 in self.pers["_encstr_833D0EDDFD979FE570E0012FBFBF1AB6"]) {
    var_11 = self.pers["_encstr_833D0EDDFD979FE570E0012FBFBF1AB6"][var_12];

    if(var_11 == var_3) {
      if(var_6) {
        var_7 = var_7 + 1;
        continue;
      }

      var_8 = var_12;
    }
  }

  if(var_8 == -1 || var_1.uavbestid) {
    var_8 = self.pers["_encstr_833D0EDDFD979FE570E0012FBFBF1AB6"].size;
    self.pers["_encstr_833D0EDDFD979FE570E0012FBFBF1AB6"][var_8] = var_3;
    loadout_logloadout(var_0, var_1, var_8, var_7, var_4);
  }

  self.loadoutindex = var_8;
}

loadout_logloadout(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;
  var_6 = var_4;
  var_7 = var_3;

  if(isDefined(self.matchdatalifeindex))
    var_8 = self.matchdatalifeindex;
  else
    var_8 = -1;

  var_9 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_10 = var_1.loadoutprimary;
  var_11 = [];

  for(var_12 = 0; var_12 < 10; var_12++) {
    var_11[var_12] = var_1.loadoutprimaryattachments[var_12];

    if(!isDefined(var_11[var_12]))
      var_11[var_12] = "_encstr_B40101";
  }

  var_13 = var_1.loadoutprimarycamo;
  var_14 = var_1.loadoutprimaryreticle;
  var_15 = var_1.loadoutprimarylootitemid;
  var_16 = var_1.loadoutprimaryvariantid;
  var_17 = var_1.loadoutsecondary;
  var_18 = [];

  for(var_12 = 0; var_12 < 10; var_12++) {
    var_18[var_12] = var_1.loadoutsecondaryattachments[var_12];

    if(!isDefined(var_18[var_12]))
      var_18[var_12] = "_encstr_B40101";
  }

  var_19 = var_1.loadoutsecondarycamo;
  var_20 = var_1.loadoutsecondaryreticle;
  var_21 = var_1.loadoutsecondarylootitemid;
  var_22 = var_1.loadoutsecondaryvariantid;
  var_23 = var_1.loadoutequipmentprimary;
  var_24 = var_1.loadoutequipmentsecondary;
  var_25 = [];
  var_26 = 3;

  for(var_27 = 0; var_27 < var_26; var_27++) {
    var_28 = "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249";

    if(isDefined(var_1.loadoutstandardperks[var_27]))
      var_28 = var_1.loadoutstandardperks[var_27];

    var_25[var_27] = var_28;
  }

  var_29 = [];
  var_30 = var_1.loadoutextraperks.size;

  if(var_30 > 3)
    var_30 = 3;

  for(var_27 = 0; var_27 < var_30; var_27++)
    var_29[var_27] = var_1.loadoutextraperks[var_27];

  for(var_27 = 0; var_27 < 3; var_27++) {
    if(!isDefined(var_29[var_27]))
      var_29[var_27] = "_encstr_A3BA05E0735C50";
  }

  self dlog_recordplayerevent("_encstr_B8141A445108023E7B5B67C5D1A19B5372E397E39960981F79FDBD0D", ["_encstr_85C60EB1E70F014FCBDB59E052A703DA", var_2, "_encstr_BD4D0B9A201F7F6A4129B1A013", var_6, "_encstr_97EB15B5B4C8FA5BB03AC6A1FA5619B41D7D1BDEEAE63A", var_7, "_encstr_96FA1593DB3E3374015B32BF36B0A1DA1D1F373BB9EDCB", var_8, "_encstr_8CFB19C8FA35BB9ECFF328BCEA1FAD079DC240E882C1CFB3D71A45", var_9, "_encstr_838B1C8F2A226B81DA4761281FE17BB7BA99869D035B190EA72FA808CF36", var_10, "_encstr_ACD82207C9A5AD1693CBD7775616077BE6D76E2B1DAEC1BEB08ED1856CA16B95DCA3D70C", var_11[0], "_encstr_B8D8227063A07516856B1E23D75383ED75D85F9034E3C0A779DBB9C9D1620512C3CC719E", var_11[1], "_encstr_8FD822D05892ED69533B894B9A174BAF7D074EBFD543FB1199A30BF3FE6009E5B0F8117A", var_11[2], "_encstr_91D8220EC94BB5B09C2FEBBB2B2CC1DE73D7CD598EBAC1F58547A3C2B11A5BB2DC8EF566", var_11[3], "_encstr_92D822ABA8D8E991FDEBE82F332F5AEFD5019ED34B7D3711D7C9E14B6FF887E5F6E0D1DC", var_11[4], "_encstr_AB881A1CE42DAD164E977DBB5958C1DEDCFA9B9547BA837D1B16B67B", var_13, "_encstr_85771DF7525A13E9B25F491037F9835F92B1EEF52B73F1169A4718E8071CF9", var_14, "_encstr_870122CBE36709B02AC9174FFDD683C0D3A923916BCF3F09C5A76F71DF3CE89DA701F839", var_15, "_encstr_9109201182B480572B4B3E23923F97D80DD79FA32C1BB0B0D3E293E8BA2B4DA16444", var_16, "_encstr_BA8C1E37CAB1EDDC190B39BCD7BB59C20EED9BAFE6AC47D5C1EBBBB20BC17BCD", var_17, "_encstr_AA8F248E6F02EFE04CA788D87777592BDB1588AF42DA91CB204728A823B9D171523F701DD1E7", var_18[0], "_encstr_978F241B2BEFFD9B91A76271501B7F8631B85251084B738F4B807974DDE13F8CA370DA5B01BB", var_18[1], "_encstr_888F24E659C6BD732385C997AFDDCA58C1B7B9AF9B95E8AB0EAF85A33A2CC60DDA569B8EFA64", var_18[2], "_encstr_818F24B9956CBDE68C5827CBAF77CA2CE0B7CDD79B95A3EA38F5B0D1D10BB1A1D62BDC3ABE99", var_18[3], "_encstr_8A8F2487F752D018142E33AA59EF881FBB770557375A259838895903BBA1C0C3C2A78D99EFF7", var_18[4], "_encstr_9AF71C734A97A0601769E50BAF3BF07F0342687EB3E765E02A7FCF33B565", var_19, "_encstr_88191F37B2B1B7372316C9E5AFEE59C2E07BE67DDCB247EA83AF4E958EA5C61B95", var_20, "_encstr_92C624CDACB17BB9320BC92FAFEE56B007B737D79B2BE85D38EBD8DEED1DF596E8CA5B7DD223", var_21, "_encstr_996222C720617FF2D1AFBA7098AF1A396B083BEF3819BC8B11A8836E76BB92CE33215F8B", var_22, "_encstr_954B1007392D5B589CBCD79DE4957316C856", var_23, "_encstr_963E0E11992E505B67F2503EBA570738", var_24, "_encstr_AC240F41F7CEB0385FC3967B3AABE2B132", var_25[0], "_encstr_B8240F62D86387273BB5D7F0C523CF812B", var_25[1], "_encstr_8F240FC0B7163107E52B091B88CD7F7907", var_25[2], "_encstr_92E61569D8BC587F216B3F2B630ABDB07F329103842F02", var_29[0], "_encstr_BEE615A7F0BB4A2AFF71950E6DB723F466183F739036C1", var_29[1], "_encstr_8EE615416B3BDEE809B40F0BA46DABA5EF83D92BE23F36", var_29[2], "_encstr_B67F0D1A8099036A1825ADB10F19E2", var_1.loadoutkillstreak1, "_encstr_A67F0DEF97A36A6A1BAB65716B4983", var_1.loadoutkillstreak2, "_encstr_B27F0D5BA5D8C6CD3AC9AC2CDAAF19", var_1.loadoutkillstreak3, "_encstr_BD7410AE1BE0D5437873E39ABB4F9B4FD951", var_0.loadoutfieldupgrade1, "_encstr_87741099D2CA8D8CBEABC1D9C9B019B2D74C", var_0.loadoutfieldupgrade2]);
}

hasvalidationinfraction() {
  return isDefined(self.pers) && isDefined(self.pers["_encstr_B4D4163B168DB432C28E4B7B7325CD9993C2C6A35AEDCDCD"]) && self.pers["_encstr_B4D4163B168DB432C28E4B7B7325CD9993C2C6A35AEDCDCD"] > 0;
}

recordvalidationinfraction() {
  if(isDefined(self.pers) && isDefined(self.pers["_encstr_B4D4163B168DB432C28E4B7B7325CD9993C2C6A35AEDCDCD"]))
    self.pers["_encstr_B4D4163B168DB432C28E4B7B7325CD9993C2C6A35AEDCDCD"] = self.pers["_encstr_B4D4163B168DB432C28E4B7B7325CD9993C2C6A35AEDCDCD"] + 1;
}

_detachall(var_0) {
  if(!istrue(var_0))
    self.headmodel = undefined;

  if(isDefined(self.riotshieldmodel))
    scripts\mp\riotshield::riotshield_detach(1);

  if(isDefined(self.riotshieldmodelstowed))
    scripts\mp\riotshield::riotshield_detach(0);

  if(!istrue(var_0))
    self detachall();

  scripts\mp\equipment\nvg::clearnvg(istrue(var_0));
}

trackriotshield_ontrophystow() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");

  for(;;) {
    self waittill("_encstr_B89B11B393CACDC2C859AF8357638D13B08DD6", var_0);

    if(var_0.basename != "_encstr_92EA0A290B32FF88A90170EB") {
      continue;
    }
    if(!isDefined(self.riotshieldmodel)) {
      continue;
    }
    scripts\mp\riotshield::riotshield_move(1);
    self waittill("_encstr_9A630C851C886BC33D8221E3EEB1");

    if(scripts\mp\riotshield::isriotshield(self getcurrentweapon()) && isDefined(self.riotshieldmodelstowed))
      scripts\mp\riotshield::riotshield_move(0);
  }
}

valuehud(var_0) {
  if(isDefined(var_0) && var_0.basename != "_encstr_8BBA05185F8B99") {
    if(scripts\mp\utility\weapon::issuperweapon(var_0.basename))
      return 1;

    var_1 = scripts\mp\utility\weapon::getequipmenttype(var_0.basename);

    if(isDefined(var_1) && var_1 == "_encstr_B116071BCAD186858D")
      return 1;
  }

  return 0;
}

_id_13C57() {
  for(;;) {
    self waittill("_encstr_B89B11B393CACDC2C859AF8357638D13B08DD6", var_0);

    if(!nullweapon(var_0) && var_0.basename == "_encstr_9AAE0876FCB7603101DB" && scripts\mp\riotshield::isriotshield(self getcurrentweapon()))
      self._id_1207E = 1;

    waitframe();
  }
}

_id_13C5D() {
  if(!istrue(self._id_1207E)) {
    var_0 = self getheldoffhand();

    if(!nullweapon(var_0) && var_0.basename != "_encstr_9AAE0876FCB7603101DB" && scripts\mp\riotshield::isriotshield(self getcurrentweapon()) && valuehud(var_0))
      self._id_1207E = 1;
  }
}

_id_13C5F() {
  self._id_12D52 = undefined;
  self._id_12D51 = undefined;

  for(;;) {
    self waittill("_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC", var_0);

    if(!scripts\mp\riotshield::isriotshield(var_0)) {
      self._id_12D52 = gettime() + 200;
      continue;
    }

    self._id_12D52 = undefined;
    self._id_12D51 = undefined;
  }
}

_id_13C5E() {
  for(;;) {
    self waittill("_encstr_885017907A76D1D8831FFEF431B301A951A2A8C0F28F315183", var_0);
    waittillframeend;

    if(scripts\mp\riotshield::isriotshield(var_0)) {
      self._id_12D52 = undefined;
      self._id_12D51 = undefined;
    }
  }
}

_id_13C58(var_0) {
  self notify("_encstr_9560241D392C6CAD252DF6A3A934D256D832BED6DB9BA51DB727D4865A56D8230AD1E8C21B1A");
  self endon("_encstr_9560241D392C6CAD252DF6A3A934D256D832BED6DB9BA51DB727D4865A56D8230AD1E8C21B1A");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_972412923398FB27DBD8AAC281B8B377988B3B68");

  if(isDefined(self.infil))
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  childthread _id_13C57();

  if(isDefined(var_0))
    self._id_1443A = var_0;
  else if(!isDefined(self._id_1443A))
    self._id_1443A = 0;

  while(scripts\mp\riotshield::riotshield_hasweapon()) {
    _id_13C5D();

    if(!istrue(self.inlaststand)) {
      if(self._id_1443A) {
        self.watch_for_heli_bosses_dead = 1;
        self.watch_for_heli_death = gettime() + 1000;
      } else if(isDefined(self.watch_for_heli_death) && gettime() >= self.watch_for_heli_death) {
        self.watch_for_heli_bosses_dead = undefined;
        self.watch_for_heli_death = undefined;
      }

      self._id_1443A = 0;
    } else {
      self.watch_for_heli_bosses_dead = undefined;
      self.watch_for_heli_death = undefined;
      self._id_1443A = 1;
    }

    if(self isonladder())
      _id_13C5A();
    else if(self isinexecutionattack())
      _id_13C5A();
    else if(self isinexecutionvictim())
      _id_13C5B();
    else if(self isparachuting() || self isskydiving())
      _id_13C5A();
    else if(istrue(self.watch_for_heli_bosses_dead))
      _id_13C5A();
    else if(istrue(self._id_1207E)) {
      if(nullweapon(self getheldoffhand())) {
        self._id_1207E = undefined;
        _id_13C5C();
      } else
        _id_13C5A();
    } else
      _id_13C5C();

    waitframe();
  }

  _id_13C5C();
}

_id_13C5A() {
  var_0 = isDefined(self.riotshieldmodel);
  var_1 = isDefined(self.riotshieldmodelstowed);

  if(!var_1) {
    if(var_0)
      scripts\mp\riotshield::riotshield_move(1);
    else
      scripts\mp\riotshield::riotshield_attach(0, scripts\mp\riotshield::riotshield_getmodel());
  }
}

_id_13C59() {
  var_0 = isDefined(self.riotshieldmodel);
  var_1 = isDefined(self.riotshieldmodelstowed);

  if(!var_0) {
    if(var_1)
      scripts\mp\riotshield::riotshield_move(0);
    else
      scripts\mp\riotshield::riotshield_attach(1, scripts\mp\riotshield::riotshield_getmodel());
  }
}

_id_13C5B() {
  var_0 = isDefined(self.riotshieldmodel);
  var_1 = isDefined(self.riotshieldmodelstowed);

  if(var_0)
    scripts\mp\riotshield::riotshield_detach(1);

  if(var_1)
    scripts\mp\riotshield::riotshield_detach(0);
}

_id_13C5C() {
  if(scripts\mp\riotshield::riotshield_hasweapon()) {
    var_0 = scripts\mp\riotshield::isriotshield(self getcurrentweapon());

    if(var_0) {
      _id_13C59();
      return;
    }

    _id_13C5A();
    return;
  } else {
    var_1 = isDefined(self.riotshieldmodel);
    var_2 = isDefined(self.riotshieldmodelstowed);

    if(var_1)
      scripts\mp\riotshield::riotshield_detach(1);

    if(var_2)
      scripts\mp\riotshield::riotshield_detach(0);
  }
}

riotshieldonweaponchange(var_0) {
  if(scripts\mp\riotshield::riotshield_hasweapon())
    thread _id_13C58();
  else {
    _id_13C5C();
    _id_12D4E();
    self notify("_encstr_972412923398FB27DBD8AAC281B8B377988B3B68");
  }
}

_id_12D4E(var_0) {
  self.watch_for_heli_bosses_dead = undefined;
  self.watch_for_heli_death = undefined;
  self._id_1443A = undefined;

  if(istrue(var_0)) {
    self.hasriotshield = undefined;
    self.hasriotshieldequipped = undefined;
    self.riotshieldmodel = undefined;
    self.riotshieldmodelstowed = undefined;
  }
}

fixsuperforbr(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = buildweaponassetname(var_0, var_4);
  var_10 = scripts\mp\utility\weapon::weaponattachcustomtoidmap(var_0, var_4);

  if(!isDefined(var_10))
    var_10 = [];

  var_11 = [];

  foreach(var_16, var_13 in var_10) {
    var_14 = scripts\mp\utility\weapon::attachmentmap_tounique(var_16, var_9);
    var_15 = scripts\mp\utility\weapon::carryiteminfo(var_14);

    if(isDefined(var_15))
      var_11[var_15] = 1;
  }

  if(isDefined(var_1)) {
    foreach(var_19, var_16 in var_1) {
      if(var_11.size > 0) {
        var_14 = scripts\mp\utility\weapon::attachmentmap_tounique(var_16, var_9);
        var_15 = scripts\mp\utility\weapon::carryitemomnvar(var_14);

        if(isDefined(var_11[var_15]))
          continue;
      }

      var_18 = 0;

      if(isDefined(var_5) && isDefined(var_5[var_19]))
        var_18 = var_5[var_19];

      var_10[var_16] = var_18;
    }
  }

  return buildweapon_attachmentidmap(var_0, var_10, var_2, var_3, var_4, var_6, var_7, var_8);
}

fixcollision(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\mp\utility\weapon::weaponattachcustomtoidmap(var_0, var_3);

  if(!isDefined(var_7))
    var_7 = [];

  return buildweapon_attachmentidmap(var_0, var_7, var_1, var_2, var_3, var_4, var_5, var_6);
}

buildweapon_attachmentidmap(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = [];
  var_9 = [];

  foreach(var_12, var_11 in var_1) {
    var_8[var_8.size] = var_12;
    var_9[var_9.size] = var_11;
  }

  return buildweapon(var_0, var_8, var_2, var_3, var_4, var_9, var_5, var_6, var_7);
}

buildweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_1)) {} else
    var_1 = [];

  if(!isDefined(var_2))
    var_2 = "_encstr_8BBA05185F8B99";

  if(isDefined(var_4) && var_4 <= 0)
    var_4 = undefined;

  var_9 = buildweaponassetname(var_0, var_4);
  var_10 = buildweaponattachmentidmap(var_1, var_5);

  if(istrue(var_8)) {
    if(scripts\mp\utility\weapon::weaponsupportslaserir(var_9)) {
      var_11 = scripts\mp\utility\weapon::getweaponnvgattachment(var_9);

      if(!isDefined(var_10[var_11])) {
        if(var_10.size > 0)
          var_10[var_11] = 0;
      }
    }
  }

  var_12 = buildweaponuniqueattachmenttoidmap(var_0, var_10, var_4);

  if(isDefined(var_6) && var_6 != "_encstr_8BBA05185F8B99") {
    var_6 = player_get_secondary_weapon_object(var_6);
    var_12[var_6] = 0;
  }

  var_12 = filterinvalidattachmentsfromidmap(var_12, var_9);
  var_12 = getbrendsplashpostgamestate(var_12, var_9);

  if(!isDefined(var_9) || var_9 == "_encstr_B40101")
    scripts\mp\utility\script::laststand_dogtags("_encstr_95332FC4EA5AB119BAAC2C83B7DC109604C4C24608EEB2850EDEB9A09B6ECA1D930BD6B208D2024EEDF647E458AD957440" + scripts\engine\utility::ter_op(isDefined(var_0), var_0, "_encstr_A3BA05E0735C50") + "_encstr_AD600C8CAF5312DBC9104E211D19" + scripts\engine\utility::ter_op(isDefined(var_4), var_4, "_encstr_8BBA05185F8B99"));

  var_13 = getcompleteweaponname(var_9, [], undefined, var_2, var_4);

  if(isDefined(var_9) && !isDefined(var_13))
    scripts\mp\utility\script::laststand_dogtags("_encstr_96EC2E13ABA51B32D5AC1607DE9B015A029BAE363608EECA85E07B73E808EE2BB007BD37286EE6593A9CB0DA2B807A08" + var_9 + "_encstr_AF860E82F2BBC727F92C1F457066B231" + scripts\engine\utility::ter_op(isDefined(var_0), var_0, "_encstr_A3BA05E0735C50") + "_encstr_9A880D6E2290589AD8EF5D5BB9397F" + scripts\engine\utility::ter_op(isDefined(var_4), var_4, "_encstr_8BBA05185F8B99"));

  foreach(var_16, var_15 in var_12)
  var_13 = var_13 withattachment(var_16, var_15);

  if(isDefined(var_7)) {
    for(var_17 = 0; var_17 < var_7.size; var_17++) {
      var_18 = var_7[var_17];

      if(var_18 == "_encstr_8BBA05185F8B99") {
        continue;
      }
      if("_encstr_8C07031127" != getsubstr(var_18, 0, 2))
        var_18 = "_encstr_8C07031127" + var_7[var_17];

      var_13 = var_13 setsticker(var_17, var_18);
    }
  }

  if(isDefined(var_13.scope) && !isstartstr(var_13.scope, "_encstr_88B90DB49CEDCD378C95992C578D8E")) {
    var_19 = getreticleindex(var_3);

    if(isDefined(var_19))
      var_13 = var_13 withreticle(var_19);
  }

  return var_13;
}

player_get_secondary_weapon_object(var_0) {
  switch (var_0) {
    case "_encstr_B2271A2C2BA186C3D723A289CB3D13FC2029B8A917604E930DBE6F97":
      var_0 = "_encstr_B2271A2C2BA186C3D723A289CB3D13FC2029B88917604E930DBE6F97";
    default:
      break;
  }

  return var_0;
}

buildweaponattachmentidmap(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(isDefined(var_1) && var_5 < var_1.size) {
      var_2[var_4] = var_1[var_5];
      continue;
    }

    var_2[var_4] = 0;
  }

  return var_2;
}

buildweaponuniqueattachmenttoidmap(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = [];

  var_1 = scripts\engine\utility::array_remove_key(var_1, "_encstr_8BBA05185F8B99");
  var_3 = scripts\mp\utility\weapon::weaponattachdefaulttoidmap(var_0, var_2);
  var_4 = buildweaponassetname(var_0, var_2);
  var_5 = [];

  if(isDefined(var_3))
    var_5 = combinedefaultandcustomattachmentidmaps(var_3, var_1);

  var_6 = [];

  if(var_5.size > 0) {
    var_5 = filterattachmenttoidmap(var_5, var_0);

    foreach(var_10, var_8 in var_5) {
      var_9 = scripts\mp\utility\weapon::attachmentmap_tounique(var_10, var_4);
      var_6[var_9] = var_8;
    }
  }

  var_11 = [];
  var_12 = 0;
  var_13 = undefined;

  foreach(var_20, var_8 in var_6) {
    var_15 = scripts\mp\utility\weapon::attachmentmap_toextra(var_20);

    if(isDefined(var_15)) {
      var_16 = 0;

      if(isDefined(var_2)) {
        var_17 = scripts\mp\utility\weapon::attachmentmap_tobase(var_15);
        var_16 = scripts\mp\utility\weapon::attachmentmap_extratovariantid(var_17, var_0, var_2);
      } else if(var_8 != 0)
        var_16 = var_8;

      var_18 = scripts\mp\utility\weapon::attachmentmap_tounique(var_15, var_4);
      var_11[var_18] = var_16;
    }

    var_19 = scripts\mp\utility\weapon::attachmentmap_tobase(var_20);

    if(!isDefined(var_13) && tv_station_fastrope_two_infil_rider_start_targetname(var_19))
      var_13 = var_20;

    if(!var_12 && (useeventtype(var_19) || useeventtimestamp(var_20)))
      var_12 = 1;
  }

  if(var_11.size > 0)
    var_6 = scripts\engine\utility::array_combine_unique_keys(var_6, var_11);

  if(isDefined(var_13) && var_12 && !issubstr(var_0, "_encstr_81190403FB70")) {
    var_13 = scripts\engine\utility::ter_op(var_13 == "_encstr_A7AC0DC616D8DCD6D9EBB6A56DB20D", "_encstr_8F7C1046AE3217C0849FB09867A5334F4A57", "_encstr_A1990773BF80C75CD9");
    var_6[var_13] = 0;
  }

  return var_6;
}

combinedefaultandcustomattachmentidmaps(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(scripts\engine\utility::array_contains_key(var_1, var_5)) {
      continue;
    }
    var_2[var_5] = var_4;
  }

  foreach(var_5, var_4 in var_1)
  var_2[var_5] = var_4;

  return var_2;
}

filterattachmenttoidmap(var_0, var_1) {
  var_2 = [];
  var_3 = [];
  var_4 = [];
  var_5 = getfirstarraykey(var_0);
  var_4[0] = var_5;

  for(var_6 = 0; var_6 < var_4.size; var_6++) {
    var_7 = var_4[var_6];

    if(var_7 != "_encstr_8BBA05185F8B99") {
      var_8 = scripts\mp\utility\weapon::attachmentmap_tounique(var_7, var_1);
      var_9 = 1;

      for(var_10 = 0; var_10 < var_2.size; var_10++) {
        var_11 = var_2[var_10];

        if(var_11 == "_encstr_B40101") {
          continue;
        }
        if(var_7 == var_11) {
          var_9 = 0;
          break;
        }

        var_12 = scripts\mp\utility\weapon::attachmentsconflict(var_7, var_11, var_1, var_8, var_3[var_10]);

        if(var_12 == var_7) {
          var_2[var_10] = "_encstr_B40101";
          var_3[var_10] = "_encstr_B40101";
          continue;
        }

        if(var_12 != "_encstr_B40101") {
          var_2[var_10] = "_encstr_B40101";
          var_3[var_10] = "_encstr_B40101";
          var_9 = 0;
          var_13 = [];
          var_13 = strtok(var_12, "_encstr_974C0246");

          for(var_14 = 0; var_14 < var_13.size; var_14++)
            var_4[var_4.size] = var_13[var_14];

          break;
        }
      }

      if(var_9) {
        var_15 = var_2.size;
        var_2[var_15] = var_7;
        var_3[var_15] = var_8;
      }
    }

    if(var_6 == var_4.size - 1) {
      var_5 = getnextarraykey(var_0, var_5);

      if(isDefined(var_5))
        var_4[var_4.size] = var_5;
    }
  }

  var_16 = [];

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_7 = var_2[var_6];

    if(var_7 != "_encstr_B40101") {
      var_17 = scripts\engine\utility::ter_op(isDefined(var_0[var_7]), var_0[var_7], 0);
      var_16[var_7] = var_17;
    }
  }

  return var_16;
}

filterinvalidattachmentsfromidmap(var_0, var_1) {
  var_2 = getcompleteweaponname(var_1);
  var_3 = [];

  foreach(var_6, var_5 in var_0) {
    if(var_2 canuseattachment(var_6)) {
      var_3[var_6] = var_5;
      continue;
    }

    thread invalidattachmentwarning(var_6, var_1);
  }

  return var_3;
}

getbrendsplashpostgamestate(var_0, var_1) {
  if(!isDefined(level._encstr_AB721901D9019A0E680FAD906CB570559E03228D6FE9CADA6077FF))
    level._encstr_AB721901D9019A0E680FAD906CB570559E03228D6FE9CADA6077FF = [];

  var_2 = [];

  foreach(var_10, var_4 in var_0) {
    var_5 = var_10;

    foreach(var_9, var_7 in var_0) {
      var_8 = scripts\mp\utility\weapon::attachmentmap_tobase(var_10);

      if(isDefined(level.carryingplayer[var_9]) && isDefined(level.carryingplayer[var_9][var_8])) {
        var_5 = level.carryingplayer[var_9][var_8];
        level._encstr_AB721901D9019A0E680FAD906CB570559E03228D6FE9CADA6077FF[var_5] = var_8;
      }
    }

    var_2[var_5] = var_4;
  }

  return var_2;
}

invalidattachmentwarning(var_0, var_1) {
  var_2 = "_encstr_9A85153850905884D8FBCE08336BDF0BC06F5735E3FAF1" + var_0 + "_encstr_A1720516F8209A" + var_1;

  if(isDefined(self) && isPlayer(self)) {
    if(getdvarint("_encstr_A90F0DE66C39AF1CC6B0E5A395CDE8", 0) == 1)
      self iprintlnbold(var_2);
    else {}
  }
}

buildweaponassetname(var_0, var_1) {
  return scripts\mp\utility\weapon::weaponassetnamemap(var_0, var_1);
}

getreticleindex(var_0) {
  if(!isDefined(var_0))
    return undefined;

  var_1 = int(tablelookup("_encstr_87B614A0123F80A55B87EFE9AF01FF48042F40F97ACE", 1, var_0, 5));

  if(!isDefined(var_1) || var_1 == 0)
    return undefined;

  return var_1;
}

tv_station_fastrope_two_infil_rider_start_targetname(var_0) {
  return var_0 == "_encstr_BEE308C2D9C177A398E1" || var_0 == "_encstr_B699078DC2C637D63B" || var_0 == "_encstr_AFBD0CD88536DC6BCE91E4575BDC";
}

useeventtimestamp(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "_encstr_AB1A088A2B783257C116") || var_0 == "_encstr_B27A1082F9336B55771306F0584283B87187" || scripts\engine\utility::string_starts_with(var_0, "_encstr_BE510D3A0228B503DFF0F761D188D2") || var_0 == "_encstr_8C56104C2C9C63A59D4347D79D2CC683D058" || var_0 == "_encstr_A37C104B03863ADDB863F8495B80EC73539B" || var_0 == "_encstr_8C171083CB3E336880BBF33113D8A4BB9B63";
}

useeventtype(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "_encstr_AD3E09B95A632BDC6CCA27");
}

vehicle_checkpiggybackexploit(var_0) {
  return var_0 _meth_87B8();
}

getweaponpassives(var_0, var_1) {
  return scripts\mp\loot::getpassivesforweapon(var_0, var_1);
}

weaponhaspassive(var_0, var_1, var_2) {
  var_3 = getweaponpassives(var_0, var_1);

  if(!isDefined(var_3) || var_3.size <= 0)
    return 0;

  foreach(var_5 in var_3) {
    if(var_2 == var_5)
      return 1;
  }

  return 0;
}

getweaponvariantattachments(var_0, var_1) {
  var_2 = [];
  var_3 = getweaponpassives(var_0, var_1);

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      var_6 = scripts\mp\passives::getpassiveattachment(var_5);

      if(!isDefined(var_6)) {
        continue;
      }
      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

replenishloadout() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];
  var_1 = self.pers["_encstr_959506B911C79707"];
  var_2 = self getweaponslistall();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    self givemaxammo(var_4);
    self setweaponammoclip(var_4, 9999);
    var_5 = var_4.basename;

    if(var_5 == "_encstr_ACC40CC1F8A321601715CFBFE0EA" || var_5 == "_encstr_81C7168ED858299AF0A5AF4FE1AD536788C1C315F351F583")
      self setweaponammostock(var_4, 2);
  }
}

onplayerconnecting() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 enableplayerbreathsystem(0);

    if(!isDefined(var_0.pers["_encstr_959506B911C79707"]))
      var_0.pers["_encstr_959506B911C79707"] = "_encstr_B40101";

    if(!isDefined(var_0.pers["_encstr_92690A5B078ED325F539E25E"]))
      var_0.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";

    var_0.class = var_0.pers["_encstr_959506B911C79707"];
    var_0.lastclass = var_0.pers["_encstr_92690A5B078ED325F539E25E"];
    var_0.changedarchetypeinfo = var_0.pers["_encstr_ADAD15A7080628E4C70A6D73028BADB05888234BA62FD8"];
    var_0.lastarchetypeinfo = undefined;

    if(!isDefined(var_0.pers["_encstr_B4D4163B168DB432C28E4B7B7325CD9993C2C6A35AEDCDCD"]))
      var_0.pers["_encstr_B4D4163B168DB432C28E4B7B7325CD9993C2C6A35AEDCDCD"] = 0;
  }
}

onplayerspawned() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_0);
    var_0 enableplayerbreathsystem(1);

    if(getdvarint("_encstr_8714143EEB4366550A69A8C8F36913387395503258F3", 0)) {
      if(istrue(var_0.iszombie)) {
        var_0 _meth_87AA("_encstr_BACB074025B01AAA28");
        var_0 setentitysoundcontext("_encstr_8E7107F41FA289914A", "_encstr_BACB074025B01AAA28");
      } else if(isDefined(var_0.operatorcustomization) && isDefined(var_0.operatorcustomization.gender) && var_0.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
        var_0 _meth_87AA("_encstr_B82907C2887BC62B39");
      else
        var_0 _meth_87AA("_encstr_B40101");
    } else if(getdvarint("_encstr_A614141F9B6A09DE2311F1588BBF01D087F53FBF1852", 0)) {
      if(istrue(var_0.unset_relic_gun_game)) {
        var_0 _meth_87AA("_encstr_ADF80637DB2FC38C");
        var_0 setentitysoundcontext("_encstr_8E7107F41FA289914A", "_encstr_BACB074025B01AAA28");
      } else if(isDefined(var_0.operatorcustomization) && isDefined(var_0.operatorcustomization.gender) && var_0.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
        var_0 _meth_87AA("_encstr_B82907C2887BC62B39");
      else
        var_0 _meth_87AA("_encstr_B40101");
    } else if(istrue(level.setplayerselfrevivingextrainfo) && scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163" && var_0.team == "_encstr_8E8405EA382B2A")
      var_0 _meth_87AA("_encstr_BACB074025B01AAA28");
    else if(isDefined(var_0.operatorcustomization) && isDefined(var_0.operatorcustomization.gender) && var_0.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
      var_0 _meth_87AA("_encstr_B82907C2887BC62B39");
    else
      var_0 _meth_87AA("_encstr_B40101");

    var_0 stoplocalsound("_encstr_921012A70D0383A0A3294B5F90BB5F4AD3972B5C");

    if(isDefined(var_0._id_12135)) {
      var_0 clearsoundsubmix("_encstr_AF5F144BBBE0FAAD83FA37E02CBB37AF3658AD959C85");
      var_0._id_12135 stoploopsound(self._id_12136);
      var_0._id_12135 delete();
      var_0._id_12135 = undefined;
      var_0._id_12136 = undefined;
    }

    if(isDefined(var_0.operatorcustomization.clothtype) && var_0.operatorcustomization.clothtype != "_encstr_B40101") {
      if(istrue(var_0.iszombie))
        var_0 setclothtype("_encstr_A99506D77CD5A833");
      else
        var_0 setclothtype(var_0.operatorcustomization.clothtype);

      continue;
    }

    var_0 setclothtype("_encstr_BEE00A93594E2BE548C7786C");
  }
}

fadeaway(var_0, var_1) {
  wait(var_0);
  self fadeovertime(var_1);
  self.alpha = 0;
}

setclass(var_0) {
  self.curclass = var_0;
}

haschangedclass() {
  if(isDefined(self.lastclass) && self.lastclass != self.class || !isDefined(self.lastclass))
    return 1;

  if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163" && (!isDefined(self.last_infected_class) || self.last_infected_class != self.infected_class))
    return 1;

  return 0;
}

haschangedarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    if(!isDefined(self.lastarchetypeinfo))
      return 1;

    if(self.changedarchetypeinfo != self.lastarchetypeinfo)
      return 1;
  }

  return 0;
}

resetactionslots() {
  self setactionslot(1, "_encstr_B40101");
  self setactionslot(2, "_encstr_B40101");
  self setactionslot(3, "_encstr_B40101");
  self setactionslot(4, "_encstr_B40101");

  if(!isagent(self) && !self isconsoleplayer()) {
    self setactionslot(5, "_encstr_B40101");
    self setactionslot(6, "_encstr_B40101");
    self setactionslot(7, "_encstr_B40101");
  }
}

resetfunctionality() {
  self enableequipdeployvfx(0);

  if(!isagent(self)) {
    self setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 0);
    vehicle_allowplayeruse(self, 1);

    if(level.minimaponbydefault)
      self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 0);
    else
      self setclientomnvar("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 1);
  }

  scripts\common\input_allow::clear_all_allow_info();
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_141CA(self, 1);
  scripts\common\utility::allow_script_weapon_switch(0);
  self.doublejumpenergy = undefined;
  self.doublejumpenergyrestorerate = undefined;
  self.enabledcollisionnotifies = undefined;
  self.enabledequipdeployvfx = undefined;
  self.minimapstatetracker = undefined;
  self.isstunned = undefined;
  self.isblinded = undefined;
  self.nocorpse = undefined;
  self.prematchlook = undefined;
  self.ladderexecutionblocked = undefined;
  scripts\mp\damage::resetattackerlist();
  scripts\mp\damage::clearcorpsetablefuncs();
  _id_12D4E();
  scripts\cp_mp\utility\player_utility::cleardemeanorsafe();
  scripts\mp\weapons::clearburnfx();
  scripts\mp\equipment\molotov::_id_11CB6();
  scripts\mp\equipment\throwing_knife_mp::_id_13B52();
  scripts\mp\equipment\flash_grenade::clearflash(1);
  scripts\mp\equipment\gas_grenade::gas_clear(1);

  if(!isagent(self)) {
    scripts\mp\utility\player::spawn_carriables_from_scriptables_total_percentage();
    scripts\cp_mp\killstreaks\helper_drone::markeduioff();
  }

  scripts\cp_mp\killstreaks\white_phosphorus::clearloopingcoughaudio();
  scripts\mp\utility\player::_resetenableignoreme();
  scripts\cp_mp\utility\player_utility::_id_125D0();
}

clearscriptable() {
  self setscriptablepartstate("_encstr_8D6D0C79D7A9D74ECACB11BF4740", "_encstr_B4250C393D87BECBF505530E27C3");
}

changearchetype(var_0, var_1, var_2) {
  if(isDefined(self.changedarchetypeinfo)) {
    var_3 = self.changedarchetypeinfo;

    if(var_3.archetype == var_0 && var_3.super == var_1 && var_3.trait == var_2)
      return;
  }

  var_4 = spawnStruct();
  var_4.archetype = var_0;
  var_4.super = var_1;
  var_4.trait = var_2;
  self.changedarchetypeinfo = var_4;
  self.pers["_encstr_ADAD15A7080628E4C70A6D73028BADB05888234BA62FD8"] = var_4;

  if(isDefined(self.pers["_encstr_959506B911C79707"]) && self.pers["_encstr_959506B911C79707"] != "_encstr_B40101") {
    preloadandqueueclass(self.pers["_encstr_959506B911C79707"]);

    if(shouldallowinstantclassswap())
      thread swaploadout();
    else if(isalive(self))
      self iprintlnbold(game["_encstr_A1B10847BD1A23B8FA8B"]["_encstr_A2280B469090F6E23D374BDFBF"]);
  }
}

getattachmentloadoutstring(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1 == "_encstr_BA7F0830B3A7859B60B0", "_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878", "_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB");

  if(var_0 == 0)
    return var_2;

  return var_2 + (var_0 + 1);
}

getstickerloadoutstring(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1 == "_encstr_BA7F0830B3A7859B60B0", "_encstr_B6FC168DDB85197B5D471439D2DA2C27F2A9A3A58DB6B227", "_encstr_9BB9182BB7D71132DB69D990F7D29E302EAB832FD37FD6EA9302");

  if(var_0 == 0)
    return var_2;

  return var_2 + (var_0 + 1);
}

getmaxprimaryattachments() {
  return 10;
}

getmaxsecondaryattachments() {
  return 10;
}

getmaxattachments(var_0) {
  return scripts\engine\utility::ter_op(var_0 == "_encstr_BA7F0830B3A7859B60B0", getmaxprimaryattachments(), getmaxsecondaryattachments());
}

fillemptystreakslots(var_0, var_1) {
  if(!level.allowkillstreaks) {
    return;
  }
  var_2 = [];
  var_3 = [];

  foreach(var_6, var_5 in var_0) {
    if(var_5 == "_encstr_8BBA05185F8B99") {
      var_2[var_2.size] = var_6;
      continue;
    }

    var_3[var_3.size] = var_5;
  }

  if(var_2.size > 0)
    self.pers["_encstr_88F00E86851BD6CA91A9D127590B6DDC"] = 1;

  foreach(var_8 in var_2) {
    var_9 = findfirststreakdifferentcost(var_3);

    if(var_8 + 1 == 1)
      var_1.loadoutkillstreak1 = var_9;
    else if(var_8 + 1 == 2)
      var_1.loadoutkillstreak2 = var_9;
    else
      var_1.loadoutkillstreak3 = var_9;

    var_3[var_3.size] = var_9;
  }

  return [var_1.loadoutkillstreak1, var_1.loadoutkillstreak2, var_1.loadoutkillstreak3];
}

findfirststreakdifferentcost(var_0) {
  var_1 = [];

  foreach(var_8, var_3 in game["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"].tabledatabyref) {
    if(!istrue(int(var_3["_encstr_A60B0C5B60D8AFED315DC5F54508"]))) {
      continue;
    }
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(var_8 == var_6 || scripts\mp\killstreaks\killstreaks::calcstreakcost(var_8) == scripts\mp\killstreaks\killstreaks::calcstreakcost(var_6)) {
        var_4 = 1;
        break;
      }
    }

    if(!istrue(var_4))
      var_1[var_1.size] = var_8;
  }

  return var_1[0];
}

replacetankwithwheelson(var_0) {
  if(!level.allowkillstreaks) {
    return;
  }
  var_1 = scripts\cp_mp\vehicles\light_tank::light_tank_supported();

  if(!var_1) {
    if(var_0.loadoutkillstreak1 == "_encstr_8CC008133958C81BACCB")
      var_0.loadoutkillstreak1 = "_encstr_B1B30B51D176511E377A1BC313";
    else if(var_0.loadoutkillstreak2 == "_encstr_8CC008133958C81BACCB")
      var_0.loadoutkillstreak2 = "_encstr_B1B30B51D176511E377A1BC313";
    else if(var_0.loadoutkillstreak3 == "_encstr_8CC008133958C81BACCB")
      var_0.loadoutkillstreak3 = "_encstr_B1B30B51D176511E377A1BC313";

    self.pers["_encstr_88F00E86851BD6CA91A9D127590B6DDC"] = 1;
  }

  return [var_0.loadoutkillstreak1, var_0.loadoutkillstreak2, var_0.loadoutkillstreak3];
}

replacewithspecialistkillstreaks(var_0) {
  return ["_encstr_96AF127BC7026103B6E82B336B116240E3833979", "_encstr_AAAF12036BFFD628063483AF34E1A8ADDBB21EA3", "_encstr_81AF120B0297F6342960F003808FB803ED284F33", "_encstr_8A0F16B7C8A936CB116ADA5265E973273A603182270EDB4B"];
}

updateinstantclassswapallowed() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.instantclassswapallowed = 1;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    var_0 = scripts\mp\gamelogic::generate_randomized_primary_weapon_objs(scripts\mp\utility\game::round_vehicle_logic());

    if(var_0) {
      scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
      _id_13FE4();
    }
  } else {
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
    _id_13FE4();
  }

  disableclassswapallowed();
}

_id_13FE4() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = scripts\engine\utility::ter_op(scripts\mp\utility\game::ismlgmatch(), 5, 15);

  if(scripts\mp\gamelogic::generate_randomized_primary_weapon_objs(scripts\mp\utility\game::round_vehicle_logic())) {
    while(scripts\mp\utility\game::updatehistoryhud(self))
      waitframe();

    self waittill("_encstr_A9E113A3A845C6179835FCE5D801DF0DA9587A5B20");
  }

  if(scripts\mp\utility\perk::_hasperk("_encstr_A925123F2B991E48CFE833A7EF1C3D73384F6733"))
    var_0 = scripts\engine\utility::ter_op(scripts\mp\utility\game::ismlgmatch(), 5, 5);

  wait(var_0);
}

disableclassswapallowed() {
  if(istrue(self.instantclassswapallowed)) {
    self.instantclassswapallowed = 0;

    if(scripts\mp\utility\game::isteamreviveenabled()) {
      self.revive_chosenclass = self.class;
      self.pers["_encstr_954311604208F1F6EB479537243739B9364B10"] = self.class;
    }
  }
}

isvalidclass(var_0) {
  return isDefined(var_0) && var_0 != "_encstr_B40101";
}

getclassindex(var_0) {
  return level.classmap[var_0];
}

preloadandqueueclass(var_0, var_1) {
  var_2 = loadout_getorbuildclassstruct(var_0);
  preloadandqueueclassstruct(var_2, var_1);
  return var_2;
}

preloadandqueueclassstruct(var_0, var_1, var_2) {
  var_3 = scripts\mp\playerlogic::getplayerassets(var_0);
  scripts\mp\playerlogic::loadplayerassets([var_3], var_1, var_2);
  self.preloadedclassstruct = var_0;
}

loadout_getorbuildclassstruct(var_0) {
  if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" && !isDefined(var_0))
    var_0 = "_encstr_A70708DF6DCAB0B8BF17";

  var_1 = loadout_getclasstype(var_0);
  var_2 = getcachedloadoutstruct(var_0, var_1);
  var_3 = var_1 == "_encstr_BD34078D57B9A37BD6" || var_1 == "_encstr_8B1608EC43B8D647A113";

  if(var_3 && scripts\mp\utility\game::unset_relic_grounded())
    self.wam_sequence = var_0;

  if(isDefined(var_2)) {
    if(!isDefined(var_2.loadoutprimaryobject) && isDefined(var_2.loadoutprimaryfullname))
      var_2.loadoutprimaryobject = asmdevgetallstates(var_2.loadoutprimaryfullname);

    if(!isDefined(var_2.loadoutsecondaryobject) && isDefined(var_2.loadoutsecondaryfullname))
      var_2.loadoutsecondaryobject = asmdevgetallstates(var_2.loadoutsecondaryfullname);
  }

  if(isDefined(var_2)) {
    if(var_0 == "_encstr_AAAC09D09972B9C83F2B7F") {
      var_4 = loadout_getclassstruct();
      var_4 = loadout_updateclass(var_4, var_0);
      var_5 = compareclassstructs(var_4, var_2);

      if(!var_5) {
        var_4.gamemodeforcednewloadout = 1;
        trytocacheclassstruct(var_4, var_0, var_1);
        return var_4;
      }
    }

    return var_2;
  }

  var_6 = loadout_getclassstruct();
  var_6 = loadout_updateclass(var_6, var_0);
  trytocacheclassstruct(var_6, var_0, var_1);
  return var_6;
}

zombiesignorevehicleexplosions() {
  if(!isDefined(self.pers["_encstr_92A41439126FFEC0DD8C6773CC4538BD372B13E30AFB"]))
    _id_11950();

  return self.pers["_encstr_92A41439126FFEC0DD8C6773CC4538BD372B13E30AFB"];
}

_id_11950() {
  var_0 = spawnStruct();

  if(!isagent(self)) {
    var_0.loadoutfieldupgrade1 = cac_getfieldupgrade(0);
    var_0.loadoutfieldupgrade2 = cac_getfieldupgrade(1);
  } else {
    var_0.loadoutfieldupgrade1 = "_encstr_8BBA05185F8B99";
    var_0.loadoutfieldupgrade2 = "_encstr_8BBA05185F8B99";
  }

  self.pers["_encstr_92A41439126FFEC0DD8C6773CC4538BD372B13E30AFB"] = var_0;
}

zombieregenratescaleoutgas() {
  var_0 = zombiesignorevehicleexplosions();
  _id_11950();
  var_1 = zombiesignorevehicleexplosions();

  if(var_0.loadoutfieldupgrade1 != var_1.loadoutfieldupgrade1)
    return 1;

  if(var_0.loadoutfieldupgrade2 != var_1.loadoutfieldupgrade2)
    return 1;

  return 0;
}

_id_1194F(var_0, var_1) {
  var_2 = self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"];

  if(isDefined(var_2["_encstr_91C8151BEDB08C7BAEE891B4B28D91550E9DC9588CAC62"]))
    var_0.loadoutfieldupgrade1 = var_2["_encstr_91C8151BEDB08C7BAEE891B4B28D91550E9DC9588CAC62"];

  if(isDefined(var_2["_encstr_ACC815D8F62C23F6BAD19196598DC8AA387693C2C8598C"]))
    var_0.loadoutfieldupgrade2 = var_2["_encstr_ACC815D8F62C23F6BAD19196598DC8AA387693C2C8598C"];
}

loadout_editcachedclassstruct(var_0) {
  var_1 = loadout_getclasstype(var_0);
  var_2 = getcachedloadoutstruct(var_0, var_1);

  if(isDefined(var_2)) {
    var_3 = loadout_getclassstruct();
    var_3 = loadout_updateclass(var_3, var_0);
    var_4 = compareclassstructs(var_3, var_2);

    if(!var_4) {
      var_3.tweakedbyplayerduringmatch = 1;
      trytocacheclassstruct(var_3, var_0, var_1);
      return 1;
    }
  }

  return 0;
}

getcachedloadoutstruct(var_0, var_1) {
  switch (var_1) {
    case "_encstr_A90B0D7BF38003BF978062EAA87DCF":
    case "_encstr_BD34078D57B9A37BD6":
    case "_encstr_AAAC09D09972B9C83F2B7F":
    case "_encstr_8B1608EC43B8D647A113":
      if(!isDefined(self.pers["_encstr_A1B90BC25B81E32841B9C081E7"])) {
        break;
      }

      return self.pers["_encstr_A1B90BC25B81E32841B9C081E7"][var_0];
  }

  return undefined;
}

trytocacheclassstruct(var_0, var_1, var_2) {
  switch (var_2) {
    case "_encstr_A90B0D7BF38003BF978062EAA87DCF":
    case "_encstr_BD34078D57B9A37BD6":
    case "_encstr_AAAC09D09972B9C83F2B7F":
    case "_encstr_8B1608EC43B8D647A113":
      addclassstructtocache(var_0, var_1);
      break;
  }
}

addclassstructtocache(var_0, var_1) {
  if(!isDefined(self.pers["_encstr_A1B90BC25B81E32841B9C081E7"]))
    self.pers["_encstr_A1B90BC25B81E32841B9C081E7"][var_1] = [];

  self.pers["_encstr_A1B90BC25B81E32841B9C081E7"][var_1] = var_0;
}

loadout_emptycacheofloadout(var_0) {
  if(!isDefined(self.pers["_encstr_A1B90BC25B81E32841B9C081E7"])) {
    return;
  }
  self.pers["_encstr_A1B90BC25B81E32841B9C081E7"][var_0] = undefined;
}

loadout_gamemodeloadoutchanged() {
  self.pers["_encstr_A1B90BC25B81E32841B9C081E7"]["_encstr_AAAC09D09972B9C83F2B7F"] = undefined;
}

copyclassfornextlife(var_0) {
  self setclientomnvar("_encstr_B43912ABD2AF8DDB85917BAE1DBE8DDB1C4B5623", gettime());
  thread allow_cp_munitions();
  var_1 = undefined;

  if(isDefined(var_0.juggcontext) && isDefined(var_0.juggcontext.prevclassstruct))
    var_1 = var_0.juggcontext.prevclassstruct;
  else
    var_1 = var_0.classstruct;

  self.pers["_encstr_8D460CEF80FBE4FA6946A00323C3"] = zombieregenratescaleingas(var_1);
  self.pers["_encstr_B1BD0B15A70BFB576312500202"] = var_0;
}

allow_cp_munitions() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_BA350853C128FB939DB9");
  self setclientomnvar("_encstr_B4E613F3B229C48D99790F254331BFF49E6399DA20", 11);
}

zombiesdamagezombies(var_0, var_1) {
  var_0.loadoutsuper = var_1.loadoutsuper;
  var_0.loadoutstreaksfilled = var_1.loadoutstreaksfilled;
  var_0.loadoutstreaktype = var_1.loadoutstreaktype;
  var_0.loadoutkillstreak1 = var_1.loadoutkillstreak1;
  var_0.loadoutkillstreak2 = var_1.loadoutkillstreak2;
  var_0.loadoutkillstreak3 = var_1.loadoutkillstreak3;
  var_0.loadoutaccessoryweapon = var_1.loadoutaccessoryweapon;
  var_0.loadoutaccessorydata = var_1.loadoutaccessorydata;
  var_0.loadoutaccessorylogic = var_1.loadoutaccessorylogic;
  var_0.tweakedbyplayerduringmatch = 0;
  var_0.gamemodeforcednewloadout = 0;
  var_0.uavbestid = 1;
}

shouldskipfirstraise(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(!istrue(self.hasspawned))
    var_1 = 1;

  if(scripts\cp_mp\utility\game_utility::shouldskipfirstraise() && istrue(self.hasspawned))
    var_1 = 1;

  if(istrue(self._id_1443D))
    var_1 = 1;

  if(weaponclass(var_0.basename) == "_encstr_BE0703A54C" && !istrue(self.usingascender))
    var_1 = 1;

  if(scripts\mp\utility\game::getgametype() == "_encstr_AAE507E8423F63C163" && istrue(self.faux_spawn_infected))
    var_1 = 1;

  return var_1;
}

respawnitems_saveplayeritemstostruct(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_3 = 0;

  if(!isDefined(var_0) || var_0)
    respawnitems_saveweapons(var_4);

  if(!isDefined(var_1) || var_1)
    respawnitems_saveequipmentitems(var_4);

  if(!isDefined(var_2) || var_2)
    respawnitems_savestreaks(var_4);

  if(!isDefined(var_3) || var_3)
    respawnitems_savesuper(var_4);

  return var_4;
}

respawnitems_assignrespawnitems(var_0) {
  self.respawnitems = var_0;
}

respawnitems_hasrespawnitems() {
  return isDefined(self.respawnitems);
}

respawnitems_getrespawnitems() {
  if(isDefined(self.respawnitems))
    return self.respawnitems;

  return undefined;
}

respawnitems_clear() {
  self.respawnitems = undefined;
}

respawnitems_saveweapons(var_0) {
  var_1 = [];
  var_2 = self.primaryweapons;
  var_3 = self.currentweapon;

  foreach(var_5 in var_2) {
    if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var_5))
      var_1[var_1.size] = var_5;
  }

  var_7 = undefined;

  if(isDefined(self.lastcacweaponobj))
    var_7 = self.lastcacweaponobj;
  else if(!scripts\mp\utility\weapon::iscacprimaryorsecondary(self.currentweapon))
    var_7 = self.currentweapon;
  else if(var_1.size > 0)
    var_7 = var_1[0];

  if(getqueuedspleveltransients(var_7))
    var_7 = getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");

  respawnitems_saveweapon(var_7, "_encstr_BA7F0830B3A7859B60B0", var_0);
  var_8 = undefined;

  foreach(var_5 in var_1) {
    if(!isnullweapon(var_5, var_7, 1)) {
      var_8 = var_5;
      break;
    }
  }

  if(isDefined(var_8))
    respawnitems_saveweapon(var_8, "_encstr_AC8F0AE74163F85AAA380AD8", var_0);
}

respawnitems_saveweapon(var_0, var_1, var_2) {
  if(!isDefined(var_2.weapons))
    var_2.weapons = [];

  var_3 = spawnStruct();
  var_2.weapons[var_1] = var_3;
  var_3.weaponobj = var_0;
  var_3.clipammo = self getweaponammoclip(var_0);
  var_3.stockammo = self getweaponammostock(var_0);

  if(var_0.hasalternate) {
    var_4 = var_0 getaltweapon();
    var_3.altclipammo = self getweaponammoclip(var_4);
    var_3.altstockammo = self getweaponammostock(var_4);
  }
}

respawnitems_saveequipmentitems(var_0) {
  respawnitems_saveequipment("_encstr_BA7F0830B3A7859B60B0", var_0);
  respawnitems_saveequipment("_encstr_AC8F0AE74163F85AAA380AD8", var_0);
}

respawnitems_saveequipment(var_0, var_1) {
  var_2 = scripts\mp\equipment::getcurrentequipment(var_0);

  if(!isDefined(var_2))
    var_2 = "_encstr_8BBA05185F8B99";

  if(!isDefined(var_1.equipment))
    var_1.equipment = [];

  var_3 = spawnStruct();
  var_1.equipment[var_0] = var_3;
  var_3.item = var_2;

  if(var_2 != "_encstr_8BBA05185F8B99")
    var_3.ammo = scripts\mp\equipment::getequipmentammo(var_3.item);
  else
    var_3.ammo = 0;
}

respawnitems_savestreaks(var_0) {
  var_1 = spawnStruct();
  var_1.streaks = [];
  var_1.streakpoints = self.streakpoints;

  if(!isDefined(self.streakpoints)) {
    return;
  }
  var_2 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(1);

  if(isDefined(var_2))
    var_1.streaks[var_1.streaks.size] = var_2.streakname;

  var_2 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(2);

  if(isDefined(var_2))
    var_1.streaks[var_1.streaks.size] = var_2.streakname;

  var_2 = scripts\mp\killstreaks\killstreaks::getkillstreakinslot(3);

  if(isDefined(var_2))
    var_1.streaks[var_1.streaks.size] = var_2.streakname;

  if(var_1.streaks.size <= 0) {
    return;
  }
  var_0.streakstate = var_1;
}

respawnitems_savesuper(var_0) {
  var_1 = scripts\mp\supers::getcurrentsuperref();

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = spawnStruct();
  var_0.superstate = var_2;
  var_2.super = var_1;
  var_2.superpoints = scripts\mp\supers::getcurrentsuperbasepoints();
  var_2.extrapoints = scripts\mp\supers::getcurrentsuperextrapoints();
}

respawnitems_hasweapondata(var_0) {
  if(!isDefined(var_0))
    return 0;

  return isDefined(var_0.weapons);
}

respawnitems_getweaponobj(var_0, var_1) {
  return var_0.weapons[var_1].weaponobj;
}

respawnitems_giveweaponammo(var_0, var_1) {
  var_2 = var_0.weapons[var_1];
  self setweaponammoclip(var_2.weaponobj, var_2.clipammo);
  self setweaponammostock(var_2.weaponobj, var_2.stockammo);

  if(var_2.weaponobj.hasalternate) {
    var_3 = var_2.weaponobj getaltweapon();
    self setweaponammoclip(var_3, var_2.altclipammo);
    self setweaponammostock(var_3, var_2.altstockammo);
  }
}

respawnitems_hasequipmentdata(var_0) {
  if(!isDefined(var_0))
    return 0;

  return isDefined(var_0.equipment);
}

respawnitems_getequipmentref(var_0, var_1) {
  return var_0.equipment[var_1].item;
}

respawnitems_giveequipmentammo(var_0, var_1) {
  var_2 = respawnitems_getequipmentref(var_0, var_1);

  if(!isDefined(var_2) || var_2 == "_encstr_8BBA05185F8B99") {
    return;
  }
  var_3 = var_0.equipment[var_1].ammo;

  if(!isDefined(var_3)) {
    return;
  }
  scripts\mp\equipment::setequipmentammo(var_2, var_3);
}

respawnitems_hasstreakdata(var_0) {
  if(!isDefined(var_0))
    return 0;

  return isDefined(var_0.streakstate);
}

respawnitems_getstreakpoints(var_0) {
  return var_0.streakstate.streakpoints;
}

respawnitems_getstreaks(var_0) {
  return var_0.streakstate.streaks;
}

respawnitems_hassuperdata(var_0) {
  if(!isDefined(var_0))
    return 0;

  return isDefined(var_0.superstate);
}

respawnitems_getsuperref(var_0) {
  return var_0.superstate.super;
}

respawnitems_getsuperpoints(var_0) {
  return var_0.superstate.superpoints;
}

respawnitems_getsuperextrapoints(var_0) {
  return var_0.superstate.extrapoints;
}

spawnammocountoverride_giveweaponammo(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = !var_2;

  if(var_4 && !update_health_bar_to_players(var_0)) {
    var_5 = 0;
    var_6 = 0;

    if(var_0 hasattachment("_encstr_AD9C07E0478148252A", 1))
      self setweaponammoclip(var_3, var_5, "_encstr_A5AD056A019C63");
  } else {
    var_5 = var_3.clipsize;
    var_6 = var_2 - 1;
  }

  if(var_2 == 7)
    var_6 = weaponmaxammo(var_3);
  else if(issubstr(var_3.basename, "_encstr_B10B12CC2CE969D3A8513F1BC883B4723B648253") && !var_4)
    var_6 = var_3.clipsize * var_6 + 18;
  else
    var_6 = var_3.clipsize * var_6;

  self setweaponammoclip(var_3, var_5);
  self setweaponammostock(var_3, var_6);

  if(var_0.hasalternate) {
    var_7 = var_0 getaltweapon();

    if(var_4) {
      var_8 = 0;
      var_9 = 0;
    } else {
      var_8 = self getweaponammoclip(var_7);
      var_9 = self getweaponammostock(var_7);
    }

    self setweaponammoclip(var_7, var_8);
    self setweaponammostock(var_7, var_9);
  }
}

update_health_bar_to_players(var_0) {
  var_1 = scripts\mp\utility\weapon::isknifeonly(var_0.basename) || scripts\mp\utility\weapon::turret_aimed_at_last_known(var_0.basename) || scripts\mp\utility\weapon::isaxeweapon(var_0.basename) || scripts\mp\utility\weapon::update_health_bar_to_player(var_0) || scripts\mp\riotshield::isriotshield(var_0.basename);
  return var_1;
}

compareclassstructs(var_0, var_1) {
  if(var_0.loadoutarchetype != var_1.loadoutarchetype)
    return 0;

  if(var_0.loadoutprimary != var_1.loadoutprimary)
    return 0;

  if(!checkclassstructarray(var_0.loadoutprimaryattachments, var_1.loadoutprimaryattachments))
    return 0;

  if(!checkclassstructarray(var_0.loadoutprimaryattachmentids, var_1.loadoutprimaryattachmentids))
    return 0;

  if(var_0.loadoutprimarycamo != var_1.loadoutprimarycamo)
    return 0;

  if(var_0.loadoutprimaryreticle != var_1.loadoutprimaryreticle)
    return 0;

  if(var_0.loadoutprimarylootitemid != var_1.loadoutprimarylootitemid)
    return 0;

  if(var_0.loadoutprimaryvariantid != var_1.loadoutprimaryvariantid)
    return 0;

  if(var_0.loadoutprimarycosmeticattachment != var_1.loadoutprimarycosmeticattachment)
    return 0;

  if(var_0.loadoutsecondary != var_1.loadoutsecondary)
    return 0;

  if(!checkclassstructarray(var_0.loadoutsecondaryattachments, var_1.loadoutsecondaryattachments))
    return 0;

  if(!checkclassstructarray(var_0.loadoutsecondaryattachmentids, var_1.loadoutsecondaryattachmentids))
    return 0;

  if(var_0.loadoutsecondarycamo != var_1.loadoutsecondarycamo)
    return 0;

  if(var_0.loadoutsecondaryreticle != var_1.loadoutsecondaryreticle)
    return 0;

  if(var_0.loadoutsecondarylootitemid != var_1.loadoutsecondarylootitemid)
    return 0;

  if(var_0.loadoutsecondaryvariantid != var_1.loadoutsecondaryvariantid)
    return 0;

  if(var_0.loadoutsecondarycosmeticattachment != var_1.loadoutsecondarycosmeticattachment)
    return 0;

  if(!checkclassstructarray(var_0.loadoutperks, var_1.loadoutperks))
    return 0;

  if(!checkclassstructarray(var_0.loadoutstandardperks, var_1.loadoutstandardperks))
    return 0;

  if(!checkclassstructarray(var_0.loadoutextraperks, var_1.loadoutextraperks))
    return 0;

  if(var_0.loadoutusingspecialist != var_1.loadoutusingspecialist)
    return 0;

  if(var_0.loadoutmeleeslot != var_1.loadoutmeleeslot)
    return 0;

  if(var_0.loadoutperksfromgamemode != var_1.loadoutperksfromgamemode)
    return 0;

  if(var_0.loadoutrigtrait != var_1.loadoutrigtrait)
    return 0;

  if(var_0.loadoutequipmentprimary != var_1.loadoutequipmentprimary)
    return 0;

  if(var_0.loadoutextraequipmentprimary != var_1.loadoutextraequipmentprimary)
    return 0;

  if(var_0.loadoutequipmentsecondary != var_1.loadoutequipmentsecondary)
    return 0;

  if(var_0.loadoutextraequipmentsecondary != var_1.loadoutextraequipmentsecondary)
    return 0;

  if(var_0.loadoutsuper != var_1.loadoutsuper)
    return 0;

  if(var_0.loadoutgesture != var_1.loadoutgesture)
    return 0;

  if(var_0.loadoutstreaksfilled != var_1.loadoutstreaksfilled)
    return 0;

  if(var_0.loadoutstreaktype != var_1.loadoutstreaktype)
    return 0;

  if(var_0.loadoutkillstreak1 != var_1.loadoutkillstreak1)
    return 0;

  if(var_0.loadoutkillstreak2 != var_1.loadoutkillstreak2)
    return 0;

  if(var_0.loadoutkillstreak3 != var_1.loadoutkillstreak3)
    return 0;

  return 1;
}

checkclassstructarray(var_0, var_1) {
  if(var_0.size != var_1.size)
    return 0;

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_1[var_4]))
      return 0;

    if(var_1[var_4] != var_3)
      return 0;
  }

  return 1;
}

computerrebootsequence_init() {
  scripts\engine\utility::ent_flag_init("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223");
  scripts\engine\utility::ent_flag_init("_encstr_A939144BAF46E088EA019B2FA56B712B4F109F346317");
  scripts\engine\utility::ent_flag_init("_encstr_922615F7247E402C077F234875145F70E5F3EB80E8C46B");
  scripts\engine\utility::ent_flag_set("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223");
}

_id_13F02() {
  if(scripts\engine\utility::ent_flag_exist("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223") && scripts\engine\utility::ent_flag("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223"))
    scripts\engine\utility::ent_flag_clear("_encstr_9AB914B977C2C131DE0B8CDEAB1DF5C4B1B71BD6B223");
}

zvelscale(var_0) {
  var_0.loadoutprimaryobject = var_0.loadoutprimary;

  if(issameweapon(var_0.loadoutprimary))
    var_0.loadoutprimaryfullname = createheadicon(var_0.loadoutprimaryobject);

  if(var_0.loadoutsecondary == "_encstr_8BBA05185F8B99") {
    var_0.loadoutsecondaryfullname = "_encstr_8BBA05185F8B99";
    var_0.loadoutsecondaryobject = undefined;
  } else {
    if(istrue(var_0._id_11961))
      var_0.loadoutsecondaryobject = fixsuperforbr(var_0.loadoutsecondary, var_0.loadoutsecondaryattachments, var_0.loadoutsecondarycamo, var_0.loadoutsecondaryreticle, var_0.loadoutsecondaryvariantid, var_0.loadoutsecondaryattachmentids, var_0.loadoutsecondarycosmeticattachment, var_0.loadoutsecondarystickers, istrue(var_0.loadouthasnvg));
    else
      var_0.loadoutsecondaryobject = buildweapon(var_0.loadoutsecondary, var_0.loadoutsecondaryattachments, var_0.loadoutsecondarycamo, var_0.loadoutsecondaryreticle, var_0.loadoutsecondaryvariantid, var_0.loadoutsecondaryattachmentids, var_0.loadoutsecondarycosmeticattachment, var_0.loadoutsecondarystickers, istrue(var_0.loadouthasnvg));

    var_0.loadoutsecondaryfullname = createheadicon(var_0.loadoutsecondaryobject);
  }

  if(var_0.loadoutmeleeslot != "_encstr_8BBA05185F8B99") {
    self giveweapon(var_0.loadoutmeleeslot);
    self assignweaponmeleeslot(var_0.loadoutmeleeslot);
  }
}