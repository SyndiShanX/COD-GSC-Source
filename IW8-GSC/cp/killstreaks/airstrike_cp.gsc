/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\airstrike_cp.gsc
***********************************************/

getmapselectweapon() {
  return "_encstr_9A2011B5CDAF272BADB7D1ACF56B0BC1BEB1C1";
}

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_8FAC11C18072B2380AD74C27F737C966AEA0D0", ::init_airstrike_params);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB", ::airstrike_getmapselectpoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_B485117F6118DBED30D34D122C500353E787AF", ::airstrike_showerrormessage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656", ::airstrike_startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B", ::airstrike_addspawndangerzone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_8B330D3ADBD0F47B4B9536570725A8", ::airstrike_munitionused);
}

init_airstrike_params() {
  level.airstrikesettings = [];
  level.airstrikesettings["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"] = spawnStruct();
  level.airstrikesettings["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"].streakname = "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";
  level.airstrikesettings["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"].modelbase = "_encstr_9B7314EBFB1BAF7748300DD929B082116711232FFB9F";
  level.airstrikesettings["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"].modelbasealt = "_encstr_BE0119536188F031096B03D76323ABDF78E8CF1E13A24FAA57376B";
  level.airstrikesettings["_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B"] = spawnStruct();
  level.airstrikesettings["_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B"].streakname = "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B";
  level.airstrikesettings["_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B"].modelbase = "_encstr_9B7314EBFB1BAF7748300DD929B082116711232FFB9F";
  level.airstrikesettings["_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA"] = spawnStruct();
  level.airstrikesettings["_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA"].streakname = "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA";
  level.airstrikesettings["_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA"].modelbase = "_encstr_932518D55D2CF2809FB290FE1AA7CE1102A51D63C655E8D19A6F";
  level.eairstrikeheight = getEnt("_encstr_A9E210B2E845424BDB3BE3E543C1C78F9998", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(level.eairstrikeheight)) {
    var_0 = (-16, 0, 2576);
    level.eairstrikeheight = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);
    level.eairstrikeheight.targetname = "_encstr_A9E210B2E845424BDB3BE3E543C1C78F9998";
  }

  if(getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 1)
    return;
  else
    wait 10;

  level.airstrikesettings["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"].deployweaponobj = getcompleteweaponname("_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B", ["_encstr_A1AA0D2E01D783B0AD9B42E7080B22"]);
  level.airstrikesettings["_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B"].deployweaponobj = getcompleteweaponname("_encstr_9A2011B5CDAF272BADB7D1ACF56B0BC1BEB1C1");
  level.airstrikesettings["_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA"].deployweaponobj = getcompleteweaponname("_encstr_9A2011B5CDAF272BADB7D1ACF56B0BC1BEB1C1");

  if(level.script == "_encstr_951A0E70E899F83F87F3B04D2F0B7A73")
    level.airstrikesettings["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"].deployweaponobj = getcompleteweaponname("_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B", ["_encstr_AFE61C9B07F6E847CA939B1BBD38CA7D1ABC269C9646FAE8D09539DAC2B1"]);
}

airstrike_getmapselectpoint(var_0, var_1, var_2) {
  return scripts\cp\cp_mapselect::getselectmappoint(var_0, var_1, var_2);
}

airstrike_showerrormessage(var_0) {}

airstrike_startmapselectsequence(var_0, var_1, var_2) {
  scripts\cp\cp_mapselect::startmapselectsequence(var_0, var_1, var_2);
}

airstrike_addspawndangerzone(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

airstrike_munitionused(var_0, var_1) {
  self notify("_encstr_A5DA0FD65D9B961D4BB7B99B7D5D6EAC32", "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895");

  foreach(var_3 in level.players)
  var_3 thread scripts\cp\cp_hud_message::showsplash("_encstr_93AE1CB06BF70B47CA8F20BFE222AF7023E748506F61C03DF3B3AECBBC1A", undefined, self);
}