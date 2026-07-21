/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\init_cp.gsc
***********************************************/

init() {
  level.killstreakfinishusefunc = ::onkillstreakfinishuse;
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_88C5055208731B", scripts\cp\killstreaks\cruise_predator_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AA060B6EB2731DE4BCFAEC57E6", "_encstr_88C5055208731B", scripts\cp\killstreaks\sentry_gun_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D20A3A60CDFAF353A37B6D", "_encstr_88C5055208731B", scripts\cp\killstreaks\airstrike_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_88C5055208731B", scripts\cp\killstreaks\juggernaut_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_88C5055208731B", scripts\cp\killstreaks\airdrop_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_933811582D932393DE38F5B6571B1D2D0ED82B", "_encstr_88C5055208731B", scripts\cp\killstreaks\airdrop_multiple_cp::airdrop_multiple_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", "_encstr_88C5055208731B", scripts\cp\killstreaks\white_phosphorus_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_86FD08B775CD07DC1338", "_encstr_88C5055208731B", scripts\cp\killstreaks\gunship_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_88C5055208731B", scripts\cp\killstreaks\manual_turret_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A2E60C6BC099B7E1A0A93A398F48", "_encstr_88C5055208731B", scripts\cp\killstreaks\toma_strike_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_88C5055208731B", scripts\cp\killstreaks\chopper_gunner_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", "_encstr_88C5055208731B", scripts\cp\killstreaks\chopper_support_cp::init_chopper_support);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_851904B59B34", "_encstr_88C5055208731B", scripts\cp\killstreaks\uav_cp::init_uav_cp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8F2C0AB2DA1CD74639B7372B", "_encstr_88C5055208731B", scripts\cp\killstreaks\emp_drone_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_88C5055208731B", scripts\cp\killstreaks\helper_drone_cp::helper_drone_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B8BA05F06B9785", "_encstr_88C5055208731B", scripts\mp\trials\trial_target_utility::init);
  thread scripts\cp\inventory\cp_target_marker::init();
  level thread scripts\mp\killstreaks\throwback_marker::init();
  level.killstreakweaponmap = [];
  level.killstreakweaponmap["_encstr_A29408E6D5D6CAAF5B1C"] = "_encstr_B8BA05F06B9785";
  level.killstreakweaponmap["_encstr_991712D71B1B4532A71761A8B9EBFAA743F09D87"] = "_encstr_BA67082278D537E3C827";
  level.killstreakweaponmap["_encstr_A2950D16C9E8D2361B59932FF55BC1"] = "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";
  level.killstreakweaponmap["_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B"] = "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";
  level.killstreakweaponmap["_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683"] = "_encstr_BA67082278D537E3C827";
  level.killstreakweaponmap["_encstr_841719F45B108D27234EBA22F3F51B056847656897A053C7C6E033"] = "_encstr_BA67082278D537E3C827";
  level.killstreakweaponmap["_encstr_A1961164BF61B71AE701D2BAE81F157B5E11E8"] = "_encstr_912B0778976260C323";
  level.killstreakweaponmap["_encstr_8DCB0F47F22330CEE7996B13A2E390583A"] = "_encstr_B270105ECB28E94BC5CFABAB937D524C5053";
  level.killstreakweaponmap["_encstr_969E11D61673EA0B8DF58EAE39272B477DB61C"] = "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4";
  level.killstreakweaponmap["_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B"] = "_encstr_B1B30B51D176511E377A1BC313";
  level.killstreakweaponmap["_encstr_95E70D8EDBDA85F5839CED35F5B683"] = "_encstr_A2E60C6BC099B7E1A0A93A398F48";
  level.killstreakweaponmap["_encstr_A22812C4735AC7E2B64317C3CF560A3128DE7D0A"] = "_encstr_A2E60C6BC099B7E1A0A93A398F48";
  level.killstreakweaponmap["_encstr_A3DA1116382CC6D056BE8EAE27E42BA3AFB583"] = "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A";
  level.killstreakweaponmap["_encstr_AC740FAA3BF169D025C6A373200C27E06B"] = "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A";
  level.killstreakweaponmap["_encstr_827E0D809A9733A0E3992D3FBF8D48"] = "_encstr_8CC008133958C81BACCB";
  level.killstreakweaponmap["_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0"] = "_encstr_8CC008133958C81BACCB";
  level.killstreakweaponmap["_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C"] = "_encstr_8CC008133958C81BACCB";
  level.killstreakweaponmap["_encstr_9560149CB08C2CC9F58C277B37B2BE07E4B7D4F55B1C"] = "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC";
  level.killstreakweaponmap["_encstr_88F90EF65F8E7A1AEED5251AE97F9788"] = "_encstr_86FD08B775CD07DC1338";
  level.killstreakweaponmap["_encstr_88710EC26CC49918FA1A815BB5AFADC1"] = "_encstr_86FD08B775CD07DC1338";
  level.killstreakweaponmap["_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"] = "_encstr_86FD08B775CD07DC1338";
  level.killstreakweaponmap["_encstr_A3BD0E01F601AA2FC983AD8FF391D9F8"] = "_encstr_86FD08B775CD07DC1338";
  level.killstreakweaponmap["_encstr_B20A13E6C5D1CBAA99F8F2EA78F722FBC8225795DF"] = "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA";
  level.killstreakweaponmap["_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E"] = "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3";
  level.killstreakweaponmap["_encstr_BD4611B956CDD14EF2F5E8ABC99C953AF55B38"] = "_encstr_AA060B6EB2731DE4BCFAEC57E6";
  level.killstreakweaponmap["_encstr_95DB19EB1C61A8BDE1DBF1F7FF3B73281233136682C2B8E219B7F9"] = "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2";
  level.killstreakweaponmap["_encstr_BEB21B5FC0A8FCDA2FAF847D165942BF93403777700132E2A34641F5FF"] = "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2";
  level.killstreakweaponmap["_encstr_A3BA1420F546180EC9EB83B92723D5E8FACF2B5E9DA8"] = "_encstr_8C980A867B3B569CFAA659E8";
  level.killstreakweaponmap["_encstr_87DF1286F6D9959CBE9AAC1DBEC1E47B35F56B07"] = "_encstr_8C980A867B3B569CFAA659E8";
  level.killstreakweaponmap["_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB"] = "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
  level.killstreakweaponmap["_encstr_A96115C8B283C6B7E5AFA6BA9DB32BC9372CBAE8FAADE0"] = "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
  level._id_11EAF = ["_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B"];
}

onkillstreakfinishuse(var_0) {
  if(var_0.streakname == "_encstr_86FD08B775CD07DC1338") {
    if(isDefined(var_0.owner))
      var_0.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
  }
}

gastrap_dmg_trig(var_0) {
  if(scripts\engine\utility::array_contains(level._id_11EAF, var_0.basename))
    return 0;
  else
    return 1;
}