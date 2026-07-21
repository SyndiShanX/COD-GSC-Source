/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn\cp_dwn_twn_bank_vehicle_create_script.gsc
************************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883");

  if(!scripts\cp\so_trigger::cs_is_starttime())
    scripts\cp\so_trigger::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\so_trigger::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\so_trigger::strike_setup_arrays(var_1, "_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883");
  scripts\cp\so_trigger::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\so_trigger::wait_for_flags(var_2, "_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883");
  else
    scripts\cp\so_trigger::wait_for_flags(var_2, "_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (26400, -13760, -262.74), (0.83, 89.98, -1.27), "_encstr_8B7E0A8916375BD71D0BB96D", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (26368, -17600, -231.25), (360, 90, 2.26), "_encstr_8B7E0A8916375BD71D0BB96D", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (21568, -12736, -216), (0, 0, 0), "_encstr_8B7E0A8916375BD71D0BB96D", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23040, -16448, -216), (0, 0, 0), "_encstr_8B7E0A8916375BD71D0BB96D", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (25022.7, -19854.6, -224.06), (0.3, 45.01, 1.32), "_encstr_8B7E0A8916375BD71D0BB96D", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23104, -18992, -65.81), (0, 330, 0), "_encstr_AD7D0E61765E68984BE3839BEB53D808", "_encstr_8B8C06E68B0B6751", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22304, -20192, 62.19), (0, 45, 0), "_encstr_AD7D0E61765E68984BE3839BEB53D808", "_encstr_998C06F8A3EB27BB", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23168, -19040, -72.02), undefined, "_encstr_8B8C06E68B0B6751", "_encstr_84FA07F82784ED8B77", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22432, -20064, 56.19), (0, 45, 0), "_encstr_998C06F8A3EB27BB", "_encstr_85FA074B13032D6DFE", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (26368, -17600, -231.25), (360, 90, 2.26), "_encstr_874D103A18A33D87B66D31268ADEEB46F940", "_encstr_A78C062CD58E7B0D", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (26432, -17088, -228.38), (2.27, 0.04, 0.91), "_encstr_A78C062CD58E7B0D", "_encstr_AB8C0652EB7DF703", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (26432, -16832, -223.73), (1.41, 0.03, 1.28), "_encstr_AB8C0652EB7DF703", "_encstr_938C069E6B60AFDF", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (26336, -16480, -217.37), (0.27, 0, 0.58), "_encstr_938C069E6B60AFDF", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (25022.7, -19854.6, -224.06), (0.3, 45.01, 1.32), "_encstr_874D103A18A33D87B66D31268ADEEB46F940", "_encstr_A18C06C257A3DBCD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (25430, -19537.8, -226.04), (1.6, 315, 0), "_encstr_A18C06C257A3DBCD", "_encstr_A98C0658054B6A90", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (25611, -19356.8, -226.04), (1.6, 315, 0), "_encstr_A98C0658054B6A90", "_encstr_BA8C0616EA3AED72", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (25868.5, -19108.5, -223.37), (1.6, 315, -0), "_encstr_BA8C0616EA3AED72", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23040, -16448, -216), (0, 0, 0), "_encstr_874D103A18A33D87B66D31268ADEEB46F940", "_encstr_B1FA074F23FD32F13A", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23552, -16464, -200.06), (360, 270, 3.58), "_encstr_B1FA074F23FD32F13A", "_encstr_BAFA07C2AB47F613C4", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23848, -16464, -184.06), (360, 270, 3.58), "_encstr_BAFA07C2AB47F613C4", "_encstr_95FA0785AE3A7B4C23", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (24312, -16568, -184), (0, 270, 0), "_encstr_95FA0785AE3A7B4C23", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (21568, -12736, -216), (0, 0, 0), "_encstr_874D103A18A33D87B66D31268ADEEB46F940", "_encstr_A2FA071AA335AF5A82", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22080, -12704, -216), (0, 270, 0), "_encstr_A2FA071AA335AF5A82", "_encstr_9AFA07314BCBA09A03", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22336, -12704, -216), (0, 270, 0), "_encstr_9AFA07314BCBA09A03", "_encstr_AFFA07C27BED67924A", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22688, -12704, -216), (0, 270, 0), "_encstr_AFFA07C27BED67924A", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (26400, -13760, -262.74), (0.83, 89.98, -1.27), "_encstr_874D103A18A33D87B66D31268ADEEB46F940", "_encstr_A9FA078F637BE71306", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (26400, -13248, -264), (0, 0, 0), "_encstr_A9FA078F637BE71306", "_encstr_8CFA07603B73AF53A6", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (26400, -12992, -264), (0, 0, 0), "_encstr_8CFA07603B73AF53A6", "_encstr_8AFA074F75D3E86B0E", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (26368, -12672, -264), (0, 0, 0), "_encstr_8AFA074F75D3E86B0E", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23488, -19296, -65.81), undefined, "_encstr_84FA07F82784ED8B77", "_encstr_B2FA07965BD34A52CB", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23872, -18944, -65.81), undefined, "_encstr_B2FA07965BD34A52CB", "_encstr_84FA07F82784ED8DF7", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23520, -18576, -65.81), undefined, "_encstr_84FA07F82784ED8DF7", "_encstr_8AFA074F75D3E86D82", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23072, -18880, -52), undefined, "_encstr_8AFA074F75D3E86D82", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22688, -19872, 62.19), (0, 45, 0), "_encstr_85FA074B13032D6DFE", "_encstr_95FA0785AE3A7B8C43", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22365.3, -19485.3, 62.19), (0, 45, 0), "_encstr_95FA0785AE3A7B8C43", "_encstr_B4FA07E99BBCB0D687", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22078.9, -19742.9, 62.19), (0, 45, 0), "_encstr_B4FA07E99BBCB0D687", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22592, -20512, 176), (0, 45, 0), "_encstr_AD7D0E61765E68984BE3839BEB53D808", "_encstr_B6FA07B20849455253", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22688, -20448, 190.19), (0, 45, 0), "_encstr_B6FA07B20849455253", "_encstr_A6FA07B2FD096212D3", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23168, -20000, 190.19), (0, 45, 0), "_encstr_AFFA07C27BED671252", "_encstr_A9FA078F637BE77308", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23008, -19840, 190.19), (0, 45, 0), "_encstr_A9FA078F637BE77308", "_encstr_A5FA072CAB1D7B6670", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22560, -20320, 190.19), (0, 45, 0), "_encstr_8DFA0702B8F9D5C6E3", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (21824, -19328, 176), (0, 45, 0), "_encstr_AD7D0E61765E68984BE3839BEB53D808", "_encstr_8CFA07603B73AF13AA", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (21920, -19264, 190.19), (0, 45, 0), "_encstr_8CFA07603B73AF13AA", "_encstr_B1FA074F23FD32F332", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22116.1, -19071.8, 190.19), (0, 135, 0), "_encstr_B1FA074F23FD32F332", "_encstr_BAFA07C2AB47F633C8", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (21920.3, -18926.6, 190.19), (0, 225, 0), "_encstr_BAFA07C2AB47F633C8", "_encstr_A9FA078F637BE75303", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (21742.3, -19057.1, 190.19), (0, 315, 0), "_encstr_A9FA078F637BE75303", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22928, -20224, 190.19), (0, 45, 0), "_encstr_A6FA07B2FD096212D3", "_encstr_AFFA07C27BED671252", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22776, -20096, 190.19), (0, 225, 0), "_encstr_A5FA072CAB1D7B6670", "_encstr_8DFA0702B8F9D5C6E3", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}