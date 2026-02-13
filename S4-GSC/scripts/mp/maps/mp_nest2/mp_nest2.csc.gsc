/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_nest2\mp_nest2\.csc.gsc
*****************************************************/

main() {
  scripts\mp\lighting::init();
  scripts\common\trigger::_id_80A3();
  _func_00DF("#x374f34613ef7590ef", 0);
  _func_00DF("#x3c51757bb6571dfe4", 0.45);
  _func_00DF("#x3e6f20dc89ca4522a", 2);
  _func_00DF("#x3e6f20cc89ca44ff7", 3);
  _func_00DF("#x3d16c9a360648a055", 1);
  _func_00DF("#x336c71b3429ba36e2", 1);
  _func_00DF("#x3931e06e107a35919", 700);
  _func_00DF("#x3c65a53586be74477", 1000);
  _func_00DF("#x366a409d6a93d9df2", 14);
  _func_00DF("#x38c27879e101d5ae5", 1);
  _func_00DF("#x375846f2cf02aaaf7", 1.3);
  _func_00DF("#x349f95007c32d2a20", 1000.0);
  _func_00DF("#x39d5d02f594809eea", 2000.0);
  _func_00DF("#x3cd4b822c2d2e00bb", 10000.0);
  _func_00DF("#x37fefb4705a36fb24", 1000.0);
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
    _func_00DF("#x366a409d6a93d9df2", 14);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x366a409d6a93d9df2", 14);
  }
}