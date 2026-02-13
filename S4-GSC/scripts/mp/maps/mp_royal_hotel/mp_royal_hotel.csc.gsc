/*****************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_royal_hotel\mp_royal_hotel\.csc.gsc
*****************************************************************/

main() {
  scripts\common\globallogic_shared::init();
  scripts\mp\lighting::init();

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x3579351e851a0921f", 0);
  }

  _func_00DF("#x349f95007c32d2a20", 1000.0);
  _func_00DF("#x39d5d02f594809eea", 2000.0);
  _func_00DF("#x3cd4b822c2d2e00bb", 10000.0);
  _func_00DF("#x37fefb4705a36fb24", 1000.0);
  scripts\common\trigger::_id_80A3();
  thread scripts\common\fx_zones::fx_zone_watcher("interior", "msg_fx_zone_interior");
  thread scripts\common\fx_zones::fx_zone_watcher("bar", "msg_fx_zone_bar");
  thread scripts\common\fx_zones::fx_zone_watcher("terrace", "msg_fx_zone_terrace");
  thread scripts\common\fx_zones::fx_zone_watcher("vista", "msg_fx_zone_vista", "msg_fx_zone_vista_transition", "msg_fx_zone_vista_disable");
  _func_00DF("#x374f34613ef7590ef", 0);
  _func_00DF("#x3c51757bb6571dfe4", 0.45);
  _func_00DF("#x3e6f20dc89ca4522a", 1);
  _func_00DF("#x3d16c9a360648a055", 1);
  _func_00DF("#x3b216f9ce3ada90cf", 0);
  _func_00DF("#x3f93ae5bcf5c3c0c0", 1);
  _func_00DF("#x3fac8f39da5737155", 1);
  _func_00DF("#x3931e06e107a35919", 1750);
  _func_00DF("#x366a409d6a93d9df2", 4);

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x3beed502923a4c08f", 4);
    _func_00DF("#x37d86c21e8a4c3886", 2);
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
    _func_00DF("#x3579351e851a0921f", 0);
    _func_00DF("#x3beed502923a4c08f", 4);
    _func_00DF("#x37d86c21e8a4c3886", 2);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x3beed502923a4c08f", 6);
    _func_00DF("#x37d86c21e8a4c3886", 4);
  }
}