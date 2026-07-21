/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\whizby.gsc
***********************************************/

calloutmarkerping_init() {
  scripts\cp\vehicles\little_bird_mg_cp::fulton_actors_players();
  level.maxteamsize = 4;
  fulton();
  scripts\cp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_onplayerdisconnect);
  level.brloottablename = "_encstr_8DEA1936F836E171415AD8D0F3691B5B779D503D45AB2B05B6B328";
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_870D05C1969BB3", "_encstr_A25E1CB0A2ADF7D6CF38E0E405BB1D211BCAE8F0FAC53B6D9F5C71E80D43", ::fullweaponobj);
}

fulton() {
  setDvar("_encstr_82382F27A3224106376A2870C35BC978FA3383DD584C705CA78201B93BC3E888549D1B6FE573B11087BB986172EBBB982D", 40.0);
  setDvar("_encstr_A24A2B8F9E96B72133EB9878E780259F6A3027B3707A5527AEDC399F2CEC394CB3A7C568B09C677163BBF4AFDD", 5.0);
  setDvar("_encstr_BA902BDC36E4FA6CB08D1BF6BAA3B6B0E45B9593E02DDC3BAF462BB047A1F58E96DAACBDBAA3AF569B47B4A397", 20.0);
  setDvar("_encstr_91A72A37B3523176477A3840F34B3988EA0393AD487C604C97921189CBD3F898446D2B1FD563A18CAFCB4811", 40.0);
  setDvar("_encstr_8CDF2CF241B87712AFC1A3B7EBCD3A8140A8EF3A9BC81E2AE8F98F8701FB41EC30F067C55378E7F3DD9987770915", 20.0);
  setDvar("_encstr_ADDD29BF3BCAA9FECF82B0D87BF3A10B629B2B35B0F4E8340F1AE901535B7060FCE5A3975D1B19892782C3", 10.0);
  setDvar("_encstr_96C32FC3E8153967C9E9B4BF7D3307FE7DD02A4BD89BADBFE6C585A995980743934852126849A99F9BBD9BB438E0FFCD01", 40.0);
  setDvar("_encstr_AF152CB812BA9741B75409F0258BC8B3E23AB038BB943D19774485FF1C2376518C223848036B27F3777995E5F37B", 10.0);
}

fullweaponobj(var_0) {
  var_1 = spawnStruct();
  var_1._id_142F4 = "_encstr_B40101";
  var_1.fail_on_transmission_timeout = 0;

  if(isDefined(var_0.infected_music)) {
    switch (var_0.infected_music) {
      case "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30":
      case "_encstr_8348061DACC643DE":
      case "_encstr_8AA50F73A76340B0F9ABC7FD57330B802B":
      case "_encstr_B4750649E5A638C0":
      case "_encstr_B1F8111B037642AEF0D9F6BD7698E18957B99B":
      case "_encstr_BE76076250081CE2DF":
        var_1._id_142F4 = "_encstr_8C5C1938D2DCB3D7AC9B59D6BCFAB3B2A1B46CB1597D8DB49D34D1";
        var_1.fail_on_transmission_timeout = 1;
        return var_1;
      case "_encstr_AC540D92105BA5B3D95D1C12ED21EF":
      case "_encstr_B88216702D6F443D40E26F9EA56B6F4201D9F0CB66724ECA":
      case "_encstr_ADBD0E10C5D84BE589B80DBA93625F0B":
      case "_encstr_BEDB0ABB93F56A5919C1C782":
      case "_encstr_955C10E258838BE5D22F0F28B1A0AA273EF3":
      case "_encstr_8C3819FCAD6BCA6F8D4A80113265C1FE975B8B790FBAE327329340":
      case "_encstr_96D415B368D32A264101914949E5B8279B0F08C19F1ADB":
        var_1._id_142F4 = "_encstr_91201982D816D1776FD0DA1D6B60EB40C1631B591D914CB2670551";
        var_1.fail_on_transmission_timeout = 1;
        return var_1;
      case "_encstr_A6F90CB2FC09825758B150955870":
        var_1._id_142F4 = "_encstr_8461165893E8BFC9CF58CAC260197A4FE10AC3FFBBD1DB8D";
        var_1.fail_on_transmission_timeout = 1;
        return var_1;
      default:
    }
  } else if(isDefined(var_0.stop_all_ascend_anims)) {
    switch (var_0.stop_all_ascend_anims) {
      case "_encstr_8DC71569E5A638C00F6B687263378E48BD6ED70BB70E40":
      case "_encstr_BE7E0C1BA0E1F862272C3AF7051D":
      case "_encstr_B87511C5AFC221EDB723981807A9D94F695247":
      case "_encstr_AC351138CA467148D7C7830BBC47513B6A43D8":
      case "_encstr_B22E0C8072FEF9C04F4F0BF324CF":
      case "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30":
      case "_encstr_8348061DACC643DE":
      case "_encstr_8AA50F73A76340B0F9ABC7FD57330B802B":
      case "_encstr_B4750649E5A638C0":
      case "_encstr_B1F8111B037642AEF0D9F6BD7698E18957B99B":
      case "_encstr_BE76076250081CE2DF":
      case "_encstr_96EC0BA32B8D1AB7D70E8697E6":
      case "_encstr_A676126B09DBE9BB3681F8C01B4A73C1779761DF":
        var_1._id_142F4 = "_encstr_8C5C1938D2DCB3D7AC9B59D6BCFAB3B2A1B46CB1597D8DB49D34D1";
        var_1.fail_on_transmission_timeout = 1;
        return var_1;
      case "_encstr_9AC61183A0ABF33F2650086A4B2493561003CF":
      case "_encstr_AC540D92105BA5B3D95D1C12ED21EF":
      case "_encstr_B88216702D6F443D40E26F9EA56B6F4201D9F0CB66724ECA":
      case "_encstr_ADBD0E10C5D84BE589B80DBA93625F0B":
      case "_encstr_A9BD126328309B5418A75040C3A01CDFE6864B8B":
      case "_encstr_BD8411B5DAD28DF61999AF0B2DD7D2DC33B41B":
      case "_encstr_B87B11439AA9512A79A760E17BE35A272F677A":
      case "_encstr_BEDB0ABB93F56A5919C1C782":
      case "_encstr_955C10E258838BE5D22F0F28B1A0AA273EF3":
      case "_encstr_8C3819FCAD6BCA6F8D4A80113265C1FE975B8B790FBAE327329340":
      case "_encstr_96D415B368D32A264101914949E5B8279B0F08C19F1ADB":
      case "_encstr_ADA706A3E4BA1BB6":
        var_1._id_142F4 = "_encstr_91201982D816D1776FD0DA1D6B60EB40C1631B591D914CB2670551";
        var_1.fail_on_transmission_timeout = 1;
        return var_1;
      case "_encstr_BA020FB5D27319A5B00EBEB163F6B95646":
      case "_encstr_BAFD0BB5B473195A0BC1AF1B83":
      case "_encstr_873F0CB51C346BD71F0A5A81D28B":
      case "_encstr_B1B514E14EF31303A7BFA0B863D2B8435BB9EDFFE26B":
      case "_encstr_83E711590BA33738FF41710B35CB397DCA2711":
      case "_encstr_AB0D0C1B31E40B67BDEBB3AECD9B":
      case "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3":
      case "_encstr_92C70FB14C390BD9B7FA85AD31D2563747":
      case "_encstr_84AB069378304D32":
      case "_encstr_951007814D5B63F807":
      case "_encstr_BDFF1009A61BFBFB5F5728506F61303D72CD":
      case "_encstr_A6F90CB2FC09825758B150955870":
      case "_encstr_A9100DDA2D37325A161C7D53D59DCE":
      case "_encstr_88520840BAB5F918BF78":
      case "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3":
        var_1._id_142F4 = "_encstr_8461165893E8BFC9CF58CAC260197A4FE10AC3FFBBD1DB8D";
        var_1.fail_on_transmission_timeout = 1;
        return var_1;
      default:
    }
  } else {}
}

_id_131A7(var_0) {
  var_1 = self;
  var_1.br_squadindex = var_0;
  var_2 = var_1.game_extrainfo & 65528;
  var_2 = var_2 | var_0;
  var_1.game_extrainfo = var_2;
}

_id_13263(var_0) {
  if(isDefined(var_0.br_squadindex)) {
    return;
  }
  if(level.teambased) {
    var_1 = [];

    for(var_2 = 1; var_2 < level.maxteamsize + 1; var_2++)
      var_1[var_1.size] = var_2;

    var_3 = level.players;

    foreach(var_5 in var_3) {
      if(isDefined(var_5.br_squadindex))
        var_1 = scripts\engine\utility::array_remove(var_1, var_5.br_squadindex);
    }

    if(var_1.size == 0) {
      return;
    }
    var_7 = var_1[0];
    var_0 _id_131A7(var_7);
    return;
  }
}