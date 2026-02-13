/*************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_berlin_01\mp_berlin_01\.csc.gsc
*************************************************************/

main() {
  scripts\mp\lighting::init();

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x331fa312c3eaa3b0b", 0);
    _func_00DF("#x3579351e851a0921f", 0);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x3c5fdcb456a1e0f2d", 1);
    _func_00DF("#x3b216f9ce3ada90cf", 1);
  }

  _func_00DF("#x316739b0b2f3ad379", 1);
  _func_00DF("#x374f34613ef7590ef", 0);
  _func_00DF("#x3c51757bb6571dfe4", 0.35);
  _func_00DF("#x3e6f20dc89ca4522a", 2);
  _func_00DF("#x3e6f20cc89ca44ff7", 1);
  _func_00DF("#x327cef7ae0eea8806", 2);
  _func_00DF("#x3931e06e107a35919", 1300);
  _func_00DF("#x366a409d6a93d9df2", 9);
  _func_00DF("#x3f93ae5bcf5c3c0c0", 1);
  _func_00DF("#x3fac8f39da5737155", 1);
  _func_00DF("#x38c27879e101d5ae5", 1);
  _func_00DF("#x36953c7226815560c", "128 364 1280 8192");
  _func_00DF("#x3bfe2019086956203", 4);

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x3beed502923a4c08f", 4);
    _func_00DF("#x37d86c21e8a4c3886", 2);
    _func_00DF("#x3ea70431c60e87bc", 0);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x3beed502923a4c08f", 6);
    _func_00DF("#x37d86c21e8a4c3886", 4);
  }

  thread _id_7E24();
}

_id_7E24() {
  for(;;) {
    if(_func_00D5(0, "infil_lgt_dvars") == 1) {
      break;
    } else
      waitframe();
  }

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x331fa312c3eaa3b0b", 1);
    _func_00DF("#x3579351e851a0921f", 1);
    _func_00DF("#x3beed502923a4c08f", 8);
    _func_00DF("#x37d86c21e8a4c3886", 6);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x3beed502923a4c08f", 8);
    _func_00DF("#x37d86c21e8a4c3886", 6);
  }

  for(;;) {
    if(_func_00D5(0, "infil_lgt_dvars") == 0) {
      break;
    } else
      waitframe();
  }

  waitframe();

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x331fa312c3eaa3b0b", 0);
    _func_00DF("#x3579351e851a0921f", 1);
    _func_00DF("#x3beed502923a4c08f", 4);
    _func_00DF("#x37d86c21e8a4c3886", 2);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x3beed502923a4c08f", 6);
    _func_00DF("#x37d86c21e8a4c3886", 4);
  }
}