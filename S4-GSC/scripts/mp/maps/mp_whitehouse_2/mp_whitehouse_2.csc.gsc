/*******************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_whitehouse_2\mp_whitehouse_2\.csc.gsc
*******************************************************************/

main() {
  scripts\common\globallogic_shared::init();
  scripts\mp\lighting::init();
  scripts\common\trigger::_id_80A3();
  thread scripts\common\fx_zones::fx_zone_watcher("dining", "msg_fx_zone_dining");
  thread scripts\common\fx_zones::fx_zone_watcher("east", "msg_fx_zone_east");
  thread scripts\common\fx_zones::fx_zone_watcher("rgb", "msg_fx_zone_rgb");
  thread scripts\common\fx_zones::fx_zone_watcher("grand", "msg_fx_zone_grand");
  _func_00DF("#x374f34613ef7590ef", 1);
  _func_00DF("#x3c51757bb6571dfe4", 0.45);
  _func_00DF("#x3e6f20dc89ca4522a", 2);
  _func_00DF("#x3e6f20cc89ca44ff7", 3);
  _func_00DF("#x3d16c9a360648a055", 1);
  _func_00DF("#x3931e06e107a35919", 700);
  _func_00DF("#x3c65a53586be74477", 2000);
  _func_00DF("#x366a409d6a93d9df2", 8);
  _func_00DF("#x3f93ae5bcf5c3c0c0", 1);
  _func_00DF("#x3fac8f39da5737155", 1);
  _func_00DF("#x375846f2cf02aaaf7", 1.3);
  _func_00DF("#x3e4ad4b60f6720dec", 1.5);

  if(_func_009F() || _func_009C()) {
    _func_00DF("#x3beed502923a4c08f", 6);
    _func_00DF("#x37d86c21e8a4c3886", 4);
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
    _func_00DF("#x3beed502923a4c08f", 6);
    _func_00DF("#x37d86c21e8a4c3886", 4);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x3beed502923a4c08f", 7);
    _func_00DF("#x37d86c21e8a4c3886", 5);
  }
}