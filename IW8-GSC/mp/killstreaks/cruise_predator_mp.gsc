/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\cruise_predator_mp.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", scripts\cp_mp\killstreaks\cruise_predator::tryusecruisepredatorfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_82750B33D0116933E1BD8A8B80", ::cruisepredator_registervo);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_A26B0C88C3FF7523FBDD0E70A24B", ::cruisepredator_eventrecord);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_9A54146BDB7AE82C23D1A1CB0AE75D311632E7EB6222", ::initbattleroyalec130airdropcratedata);
}

cruisepredator_registervo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A29714C9D80D517BFFC633DA6B8AA30F6333DD1D5F9F"] = "_encstr_95CF12CCC6859DED9CF53827B219B0A3ED4E4681";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_959714C69C57D2DCB2EB37ACE085C9C23AA5B737EB23"] = "_encstr_84CF1211C5815050CB8F19E59F52AF8857DA3363";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81BC11D61ABF40972F8998F072834D58738F47"] = "_encstr_8FCF1299362C67B7C97DC1395932C2D1BD274360";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87BC11E36528DC473D7EAA52608D0B15B857CA"] = "_encstr_99CF128A6060C66DF38EAAB811635F93C0062B43";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_96BC11A9E3170B20EFEF6F7FF69310C0DBA92B"] = "_encstr_8FCF1299362C67B7C97DC1395932C2D1BD276360";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A17E0CBB0DA329131B09E782F418"] = "_encstr_8AD7146622733C487D98E370BD4137492A9BF8EAE973";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B66D0C6CE4AED2CDACEBB5B4CD37"] = "_encstr_968A158D4ED55AE6ACD7389C5646161DED39BEDAA53737";
}

cruisepredator_eventrecord(var_0) {
  if(isDefined(var_0))
    scripts\mp\events::predatormissileimpact(var_0);
}

initbattleroyalec130airdropcratedata(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = level.players;
  var_4 = spawnStruct();

  foreach(var_6 in var_3) {
    if(level.teambased && var_6.team == var_0.team || var_6 == var_0) {
      var_2[var_2.size] = var_6;
      continue;
    }

    if(var_6 scripts\mp\utility\perk::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9")) {
      continue;
    }
    var_1[var_1.size] = var_6;
  }

  var_4.enemytargetmarkergroup = var_1;
  var_4.friendlytargetmarkergroup = var_2;
  return var_4;
}