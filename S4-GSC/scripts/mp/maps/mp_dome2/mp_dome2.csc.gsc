/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_dome2\mp_dome2\.csc.gsc
*****************************************************/

main() {
  scripts\mp\lighting::init();
  _func_00DF("#x316739b0b2f3ad379", 1);
  _func_00DF("#x374f34613ef7590ef", 1);
  _func_00DF("#x3c51757bb6571dfe4", 0.35);
  _func_00DF("#x3e6f20dc89ca4522a", 2);
  _func_00DF("#x3e6f20cc89ca44ff7", 1);
  _func_00DF("#x327cef7ae0eea8806", 2);
  _func_00DF("#x3931e06e107a35919", 800);
  _func_00DF("#x366a409d6a93d9df2", 8);
  _func_00DF("#x3f93ae5bcf5c3c0c0", 1);
  _func_00DF("#x3fac8f39da5737155", 1);
  thread _id_7E24();
}

_id_7E24() {
  for(;;) {
    if(_func_00D5(0, "infil_lgt_dvars") == 1) {
      break;
    } else
      waitframe();
  }

  if(_func_009F() || _func_009C()) {}

  if(_func_00A0() || _func_009D() || _func_009A()) {}

  for(;;) {
    if(_func_00D5(0, "infil_lgt_dvars") == 0) {
      break;
    } else
      waitframe();
  }

  waitframe();

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x366a409d6a93d9df2", 8);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x366a409d6a93d9df2", 8);
  }
}