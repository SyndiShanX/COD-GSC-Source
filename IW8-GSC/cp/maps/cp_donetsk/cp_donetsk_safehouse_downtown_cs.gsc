/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_safehouse_downtown_cs.gsc
*******************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_BD71217A43E0C38D28AB1C03AF79521F941942224B4E9FC91097171679D01B5B50710B")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_BD71217A43E0C38D28AB1C03AF79521F941942224B4E9FC91097171679D01B5B50710B");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_BD71217A43E0C38D28AB1C03AF79521F941942224B4E9FC91097171679D01B5B50710B");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "_encstr_BD71217A43E0C38D28AB1C03AF79521F941942224B4E9FC91097171679D01B5B50710B");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_BD71217A43E0C38D28AB1C03AF79521F941942224B4E9FC91097171679D01B5B50710B");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_BD71217A43E0C38D28AB1C03AF79521F941942224B4E9FC91097171679D01B5B50710B");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19418, -21800.8, 34.5), (0, 0, 0), "_encstr_8B8C06E68B0B6751", "_encstr_998C06F8A3EB27BB", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19251, -22137, 22.25), (0, 315, 0), "_encstr_99E917850B6DD913B72EB856A9D0FA1AE2D3D3CDE94F026303", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19432, -21791.5, 21.5), (0, 135, 0), "_encstr_A78C062CD58E7B0D", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19074.5, -21925.5, 36.75), (0, 315, 0), "_encstr_88F71AB777F3190BEB6D10FBEF46B748F73BBF374FB05AA31F2AC50B", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19431, -21792, 20.5), (0, 330, 0), "_encstr_998C06F8A3EB27BB", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19418, -21800.8, 34.5), (0, 0, 0), "_encstr_9B8C06A74B53CF6B", "_encstr_A78C062CD58E7B0D", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25947.5, -12112, -207.5), (0, 135, 0), "_encstr_938C069E6B60AFDF", "_encstr_AB8C0652EB7DF703", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25931.3, -12112.7, -221.25), (0, 270, 0), "_encstr_A18C06C257A3DBCD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25910.9, -11979.1, -209.75), (0, 225, 0), "_encstr_81B21A8943BBF27427804103286B1019D7EB176599787F031108550B", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25932.3, -12112.9, -222), (0, 105, 0), "_encstr_AB8C0652EB7DF703", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25947.5, -12112, -207.5), (0, 135, 0), "_encstr_A98C0658054B6A90", "_encstr_A18C06C257A3DBCD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25398.5, -12041.1, -254), (0, 360, 0), "_encstr_8DE31E6E16992B43BDBA372BEB9DEACDE6D0BDC1BE38C60B9759C937E8589C3A", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25398.5, -12078.3, -254), (0, 360, 0), "_encstr_8DE31E6E16992B43BDBA372BEB9DEACDE6D0BDC1BE38C60B9759C937E8589C3A", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25398.5, -12008.5, -254), (0, 360, 0), "_encstr_8DE31E6E16992B43BDBA372BEB9DEACDE6D0BDC1BE38C60B9759C937E8589C3A", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (25400.7, -11973.5, -254), (0, 360, 0), "_encstr_8DE31E6E16992B43BDBA372BEB9DEACDE6D0BDC1BE38C60B9759C937E8589C3A", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19551.8, -21641.2, -16), (0, 225, 0), "_encstr_990C18B9169956A1B7D59B957D26EBC11B85CB95E46EE80BC98E", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19615.8, -21705.2, -16), (0, 225, 0), "_encstr_990C18B9169956A1B7D59B957D26EBC11B85CB95E46EE80BC98E", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19583.8, -21673.2, -16), (0, 225, 0), "_encstr_990C18B9169956A1B7D59B957D26EBC11B85CB95E46EE80BC98E", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19511.8, -21601.2, -16), (0, 225, 0), "_encstr_990C18B9169956A1B7D59B957D26EBC11B85CB95E46EE80BC98E", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19471.7, -21569.2, -16), (0, 225, 0), "_encstr_990C18B9169956A1B7D59B957D26EBC11B85CB95E46EE80BC98E", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.angles = (0, 45, 0);
  var_3.origin = (19160, -21832, -16);
  var_3.targetname = "_encstr_9520175D07CB9E91A36271088A3F7BB077AD5E4557ABC09F4B";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 315, 0);
  var_3.model = "_encstr_AD0212C82B1BBD4EEBDC5DB4E88D16CD597D0689";
  var_3.origin = (19412, -21804.5, 19.75);
  var_3.targetname = "_encstr_ADA2126BD2B99B96F6CDBE319CB45999D885E6CA";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 210, 0);
  var_3.origin = (19412.8, -21804.9, 22.5);
  var_3.target = "_encstr_9B8C06A74B53CF6B";
  var_3.targetname = "_encstr_A79C0FFA9793A31A5825C1E3CFA12B6FE0";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.model = "_encstr_A6481141B554C90F2A8383B52752DB70D79A83";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 45, 0);
  var_3.origin = (19412.5, -21805.5, 21.5);
  var_3.target = "_encstr_8B8C06E68B0B6751";
  var_3.targetname = "_encstr_BD6D169A60F69F0C20BD3703B3E0D7179D5EA22268C59F82";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.model = "_encstr_BAD323B12A6F78A857AE137FD57188383FC28E191297AC2021900B51FDE2997497CA61618B";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 315, 0);
  var_3.targetname = "_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.model = "_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365";
  var_3.origin = (19448, -21780, 22);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 45, 0);
  var_3.origin = (19192, -21800, -16);
  var_3.targetname = "_encstr_9520175D07CB9E91A36271088A3F7BB077AD5E4557ABC09F4B";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 45, 0);
  var_3.origin = (19136, -21856, -16);
  var_3.targetname = "_encstr_9520175D07CB9E91A36271088A3F7BB077AD5E4557ABC09F4B";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 45, 0);
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_3.origin = (19120, -21880, -16);
  var_3.targetname = "_encstr_9520175D07CB9E91A36271088A3F7BB077AD5E4557ABC09F4B";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.model = "_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365";
  var_3.origin = (19448, -21776, 22);
  var_3.targetname = "_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.targetname = "_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 315, 0);
  var_3.model = "_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365";
  var_3.origin = (19452, -21772, 22);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 45, 0);
  var_3.targetname = "_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.model = "_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365";
  var_3.origin = (19452, -21776, 22);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 0, 0);
  var_3.model = "_encstr_974B19B28974EB1620913F1FAB815E07A920BB4A30D897C150993C";
  var_3.origin = (19448, -21784, 22);
  var_3.targetname = "_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 135, 0);
  var_3.origin = (19456, -21773, 22);
  var_3.targetname = "_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.model = "_encstr_974B19B28974EB1620913F1FAB815E07A920BB4A30D897C150993C";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 120, 0);
  var_3.origin = (25721.3, -12030.7, -208);
  var_3.targetname = "_encstr_924517EF55858023AF0BEE93E2736D901DCD4F53D76D18F8EB";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 90, 0);
  var_3.model = "_encstr_AD0212C82B1BBD4EEBDC5DB4E88D16CD597D0689";
  var_3.origin = (25954.4, -12113.6, -222.25);
  var_3.targetname = "_encstr_AD551A1D4086EFC87F922E988BA98D6131B1C76F018F1F35334CD7F9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 345, 0);
  var_3.origin = (25954.1, -12112.8, -219.5);
  var_3.target = "_encstr_A98C0658054B6A90";
  var_3.targetname = "_encstr_97EF17B5B4E69B5AB737BECD2BC659B11D7D3BEADC3734DB1C";
  var_3.model = "_encstr_A6481141B554C90F2A8383B52752DB70D79A83";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 180, 0);
  var_3.origin = (25954.7, -12112.5, -220.5);
  var_3.target = "_encstr_938C069E6B60AFDF";
  var_3.targetname = "_encstr_86561E719CF32790D70B51380FFC29BF2B897C88355AC3BBBF5718E84F68A0D1";
  var_3.model = "_encstr_BAD323B12A6F78A857AE137FD57188383FC28E191297AC2021900B51FDE2997497CA61618B";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 90, 0);
  var_3.targetname = "_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560";
  var_3.model = "_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365";
  var_3.origin = (25939.3, -12110.2, -222);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 210, 0);
  var_3.origin = (25497, -11964.2, -235);
  var_3.targetname = "_encstr_924517EF55858023AF0BEE93E2736D901DCD4F53D76D18F8EB";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 255, 0);
  var_3.origin = (25692.6, -12030.7, -208);
  var_3.targetname = "_encstr_924517EF55858023AF0BEE93E2736D901DCD4F53D76D18F8EB";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 285, 0);
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_3.origin = (25465.5, -11965.1, -235.5);
  var_3.targetname = "_encstr_924517EF55858023AF0BEE93E2736D901DCD4F53D76D18F8EB";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 135, 0);
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.model = "_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365";
  var_3.origin = (25924.5, -12112, -222);
  var_3.targetname = "_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.targetname = "_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560";
  var_3.angles = (0, 90, 0);
  var_3.model = "_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365";
  var_3.origin = (25918.8, -12112.1, -222);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 180, 0);
  var_3.targetname = "_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560";
  var_3.model = "_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365";
  var_3.origin = (25921.7, -12109.1, -222);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 135, 0);
  var_3.model = "_encstr_974B19B28974EB1620913F1FAB815E07A920BB4A30D897C150993C";
  var_3.origin = (25938.9, -12120.7, -222);
  var_3.targetname = "_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 270, 0);
  var_3.origin = (25938.7, -12114.3, -222);
  var_3.targetname = "_encstr_AAE115E85D38C2E063DFADA3D38A3D08C57990CDC39560";
  var_3.model = "_encstr_974B19B28974EB1620913F1FAB815E07A920BB4A30D897C150993C";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0, 150, 0);
  var_3.model = "_encstr_9BA31FC8DB3FF08B92147D8FAABB9F997D63D8B85FE7E9530AB1F80F47E257CB84";
  var_3.origin = (25906.9, -12121.6, -221.5);
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}