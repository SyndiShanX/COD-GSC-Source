/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_paris_s2_aud.gsc
*********************************************/

func_00F9() {
  func_7BBE();
  thread func_5C18();
}

func_7BBE() {
  lib_0378::func_8DC7("aud_tank_drive", ::tanks_driveby);
}

func_5C18() {
  lib_0380::func_6842("good_fire_metal_large", undefined, (-2706, 1560, 356));
  lib_0380::func_6842("good_fire_metal_med", undefined, (1141, 2006, 102));
  lib_0380::func_6842("good_fire_wood_large", undefined, (1972, 215, 202));
  lib_0380::func_6842("good_fire_wood_med", undefined, (1308, -631, 114));
  lib_0380::func_6842("good_fire_wood_med", undefined, (1213, -776, 90));
  lib_0380::func_6842("good_fire_wood_med", undefined, (-252, -1027, 280));
  lib_0380::func_6842("good_fire_wood_large", undefined, (-1872, -970, 230));
  lib_0380::func_6842("good_fire_wood_large", undefined, (986, 839, 273));
  lib_0380::func_6842("good_fire_wood_small", undefined, (92, 357, 41));
  lib_0380::func_6842("good_fire_wood_large", undefined, (-25, 472, 254));
  lib_0380::func_6842("good_fire_wood_small", undefined, (66, 361, 125));
  lib_0380::func_6842("good_fire_wood_med", undefined, (-137, 349, 151));
  lib_0380::func_6842("good_fire_wood_small", undefined, (-226, 555, 140));
  lib_0380::func_6842("good_fire_wood_small", undefined, (-231, 610, 140));
  lib_0380::func_6842("good_fire_wood_small", undefined, (-167, 1118, 140));
  lib_0380::func_6842("good_fire_wood_large", undefined, (-138, 1047, 234));
}

tanks_driveby() {
  var_00 = self;
  lib_0380::func_6846("tank_engine_lp", undefined, var_00);
}