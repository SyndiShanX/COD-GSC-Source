/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\crate_drops\cp_crate_drops_cs.gsc
************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_93431232DF1F8A5AD0CB5FF12CE3FFEA07110A46");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (33722.4, 2443.68, -774.13), (0, 90, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_B8830A406B4F87315502AFDB", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (30266.2, -2672.16, -823.87), (0, 90, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_BD830AABDBA9E87B836F5F81", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (27178.3, -1900.91, -728.69), (0, 90, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_87830A2E8B8259A0FD3781DA", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (24293.3, 8279.66, -446.88), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_BE830A4728A1F402732971E2", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-20391.7, 15738.1, -62.88), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_A5E009137C82E371736F82", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-17924.8, 21607.7, -449.75), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_83E009D0D24D85366DBE46", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-27095.2, -6273.19, -14.53), (360, 327, 84.6), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_8BE009D32F68613F1AF8E7", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-26105.3, -9970.42, -38.81), (360, 90, 85.9), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_9AE009A1DBE56BE03AB843", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-10961.7, 1267.69, -318.88), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_A5460D0648B381D09829D70D83B73A", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-11174.5, 6604.94, -398.88), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_86460D85C1D8BE2BB91BB7933AAF8C", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-13940.3, 10607.7, -399), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_8B460DDAC37EAF8F4027878211F9C2", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-23108.3, 3372.55, -312.88), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_93D90AD6F627B036CA6ED7C4", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2018.8, 45793.4, 1404.53), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_BA620AF523181BD66FA88967", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1659.41, 48980.2, 1136.78), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_95620A5BB48D4C8537ACF591", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5538.43, 46126.4, 1128.45), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_AF620AB24851E336E8B3DFBD", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6792.52, 46996.8, 1029), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_A2620A399A122D9A87DBB9CA", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6020.94, 49549.2, 1033), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_9A620A059BD843C307922141", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (534.1, 30310.2, -67.6), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_838F0806EE826101F766", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5356.95, 30635.6, 353.41), (360, 327, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_8E5709505A9681F9275256", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4552.3, 31312.1, 395.56), (360, 327, 101.81), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_BE570936C2C6A1B2F5C885", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (32517.4, 37053.1, 739.9), (0, 327, 99.7), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_92720903B8D392C32A50C9", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (32384.7, 42457, 720.78), (0, 90, 90), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_877209C5EAC24E4EF2FAC8", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (31818.2, 6740.83, -629.53), (360, 90, 81.3), "_encstr_A5FE0C81AB475B8AE123DB5F7B4A", undefined, "_encstr_AC830A60BBA6C928DF7DB806", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}