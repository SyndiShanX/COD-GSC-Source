/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\airstrike_mp.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", scripts\cp_mp\killstreaks\airstrike::tryuseairstrikefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B", scripts\cp_mp\killstreaks\airstrike::tryuseairstrikefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA", scripts\cp_mp\killstreaks\airstrike::tryuseairstrikefromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_8FAC11C18072B2380AD74C27F737C966AEA0D0", ::init_airstrike_params);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB", ::airstrike_getmapselectpoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656", ::airstrike_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B", ::airstrike_addspawndangerzone);
}

init_airstrike_params() {
  level.airstrikesettings = [];
  var_0 = "_encstr_9B7314EBFB1BAF7748300DD929B082116711232FFB9F";
  var_1 = "_encstr_BE0119536188F031096B03D76323ABDF78E8CF1E13A24FAA57376B";

  if(scripts\cp_mp\utility\game_utility::_id_140AA()) {
    var_0 = "_encstr_8457116ADB72388878A2AD1D97843F406863CC";
    var_1 = "_encstr_8457116ADB72388878A2AD1D97843F406863CC";
  }

  level.airstrikesettings["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"] = spawnStruct();
  level.airstrikesettings["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"].streakname = "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";
  level.airstrikesettings["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"].modelbase = var_0;
  level.airstrikesettings["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"].modelbasealt = var_1;
  var_2 = "_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B";

  if(scripts\cp_mp\utility\game_utility::_id_140A9())
    var_2 = "_encstr_95C419518C324FF2C9585B5320E52127B178B0D53020BBB1977817";

  level.airstrikesettings["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"].deployweaponobj = getcompleteweaponname(var_2, ["_encstr_A1AA0D2E01D783B0AD9B42E7080B22"]);
  level.airstrikesettings["_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B"] = spawnStruct();
  level.airstrikesettings["_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B"].streakname = "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B";
  level.airstrikesettings["_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B"].modelbase = "_encstr_9B7314EBFB1BAF7748300DD929B082116711232FFB9F";
  level.airstrikesettings["_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B"].deployweaponobj = getcompleteweaponname(scripts\mp\killstreaks\mapselect::getmapselectweapon());
  level.airstrikesettings["_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA"] = spawnStruct();
  level.airstrikesettings["_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA"].streakname = "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA";
  level.airstrikesettings["_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA"].modelbase = "_encstr_932518D55D2CF2809FB290FE1AA7CE1102A51D63C655E8D19A6F";
  level.airstrikesettings["_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA"].deployweaponobj = getcompleteweaponname(scripts\mp\killstreaks\mapselect::getmapselectweapon());
}

airstrike_getmapselectpoint(var_0, var_1, var_2) {
  return scripts\mp\killstreaks\mapselect::getselectmappoint(var_0, var_1, var_2);
}

airstrike_startmapselectsequence(var_0, var_1, var_2) {
  scripts\mp\killstreaks\mapselect::startmapselectsequence(var_0, var_1, var_2);
}

airstrike_addspawndangerzone(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\mp\spawnlogic::addspawndangerzone(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}