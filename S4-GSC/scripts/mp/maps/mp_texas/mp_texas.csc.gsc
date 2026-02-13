/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_texas\mp_texas\.csc.gsc
*****************************************************/

main() {
  scripts\mp\lighting::init();
  _func_00DF("#x374f34613ef7590ef", 0);
  _func_00DF("#x3c51757bb6571dfe4", 0.45);
  _func_00DF("#x3e6f20dc89ca4522a", 2);
  _func_00DF("#x3e6f20cc89ca44ff7", 3);
  _func_00DF("#x3d16c9a360648a055", 1);
  _func_00DF("#x336c71b3429ba36e2", 1);
  _func_00DF("#x3931e06e107a35919", 700);
  _func_00DF("#x366a409d6a93d9df2", 16);
  _func_00DF("#x33a57ea4edb37c077", 1);
  scripts\common\trigger::_id_80A3();
  thread scripts\common\fx_zones::fx_zone_watcher("interior", "msg_fx_zone_interior");
  thread scripts\common\fx_zones::fx_zone_watcher("front", "msg_fx_zone_front");
  thread scripts\common\fx_zones::fx_zone_watcher("back", "msg_fx_zone_back");
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
    _func_00DF("#x3beed502923a4c08f", 8);
    _func_00DF("#x37d86c21e8a4c3886", 6);
    _func_00DF("#x366a409d6a93d9df2", 16);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x3beed502923a4c08f", 8);
    _func_00DF("#x37d86c21e8a4c3886", 6);
    _func_00DF("#x366a409d6a93d9df2", 16);
  }

  for(;;) {
    if(_func_00D5(0, "infil_lgt_dvars") == 0) {
      break;
    } else
      waitframe();
  }

  waitframe();

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x3beed502923a4c08f", 4);
    _func_00DF("#x37d86c21e8a4c3886", 2);
    _func_00DF("#x366a409d6a93d9df2", 16);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x3beed502923a4c08f", 6);
    _func_00DF("#x37d86c21e8a4c3886", 4);
    _func_00DF("#x366a409d6a93d9df2", 16);
  }
}