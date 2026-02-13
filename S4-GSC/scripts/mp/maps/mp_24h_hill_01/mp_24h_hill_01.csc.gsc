/*****************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_24h_hill_01\mp_24h_hill_01\.csc.gsc
*****************************************************************/

main() {
  scripts\mp\lighting::init();
  _func_00DF("#x3c51757bb6571dfe4", 0.45);
  _func_00DF("#x3e6f20dc89ca4522a", 2);
  _func_00DF("#x3e6f20cc89ca44ff7", 3);
  _func_00DF("#x366a409d6a93d9df2", 10);
  _func_00DF("#x336c71b3429ba36e2", 1);
  _func_00DF("#x3d16c9a360648a055", 1);
  _func_00DF("#x3931e06e107a35919", 700);

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x374f34613ef7590ef", 0);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x374f34613ef7590ef", 1);
  }

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x3ea70431c60e87bc", 0);
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
    _func_00DF("#x366a409d6a93d9df2", 10);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x366a409d6a93d9df2", 10);
  }
}