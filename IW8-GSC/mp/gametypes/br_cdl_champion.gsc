/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_cdl_champion.gsc
***********************************************/

init() {
  if(!scripts\mp\flags::levelflag("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\mp\flags::levelflagwait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  _id_12800();
}

_id_12800() {
  var_0 = getdvarint("_encstr_917717EE104E59D19DE023E370E70B707741C4C07748D18F07", 0);
  var_1 = relic_amped_explosion_time();
  var_2 = "_encstr_818123FA50872FA741905247B68B7FF733781241B84F67DBBE055A7FCFD027714F102B7A98";
  var_3 = ["_encstr_9A79208DDAFA1956C6BD93D79BE8B0324BAE5BAFD8DE91C6BE2658E6B959E47D0C98", "_encstr_BA79207915B981E92387A0D1EF6C21C962BB61686E5259F037DB3050B3959B079FF2", "_encstr_A97920F9D241700D9A6A7351D6217B31D8B390EFEA20C05AA7865AF07E0B6ED1472B", "_encstr_A57920A1CF894DA8EB55DB767AC4B0F542372BBF9FD205283FEEA16825BD60A02F9A", "_encstr_86792061B1B80DF579C05B81F63BE17F994DF09F0E77BDD381151A88360D5B16222F"];
  var_4 = ["_encstr_86C6119BADF04328F0DEF6FDD3387A09582D4B", "_encstr_95020BCCDEC6D20BEC2BAFBD73", "_encstr_876E0A9DDFBA68481AB998B0"];
  var_5 = ["_encstr_9A2D12D29829C5A75BF6A7B08382DF4E57C83A7B", "_encstr_8EB30C9AD061BDDFD127FEE6CD3B"];
  var_6 = relic_amped_in_warning(var_2, var_4[0]);

  if(isDefined(var_6)) {
    if(istrue(var_0))
      _id_13136(var_6, var_5[0], 0);
    else
      _id_13136(var_6, var_5[0], 1);
  }

  for(var_7 = 0; var_7 < var_3.size; var_7++) {
    var_8 = relic_amped_in_warning(var_3[var_7], var_4[2]);

    if(isDefined(var_8)) {
      if(scripts\engine\utility::array_contains(var_1, var_7)) {
        _id_13136(var_8, var_5[1], 1);
        continue;
      }

      _id_13136(var_8, var_5[1], 0);
    }
  }
}

_id_13136(var_0, var_1, var_2) {
  if(istrue(var_2))
    var_0 setscriptablepartstate(var_1, "_encstr_BE8B08E323FB2BCD6268");
  else
    var_0 setscriptablepartstate(var_1, "_encstr_95DF070DD22319CA9B");
}

relic_amped_in_warning(var_0, var_1) {
  var_2 = getentitylessscriptablearrayinradius(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_2)) {
    return;
  }
  foreach(var_4 in var_2) {
    if(var_4.type == var_0)
      return var_4;
  }

  return;
}

relic_amped_explosion_time() {
  var_0 = [];

  if(getDvar("_encstr_92AC185776A20F087247CE7F40D90B09C2F009E657F97F80B2E3") != "_encstr_B40101") {
    var_1 = strtok(getDvar("_encstr_92AC185776A20F087247CE7F40D90B09C2F009E657F97F80B2E3"), "_encstr_974C0246");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(int(var_1[var_2]) == 0)
        return [];

      var_0[var_0.size] = int(var_1[var_2]) - 1;
    }
  }

  return var_0;
}