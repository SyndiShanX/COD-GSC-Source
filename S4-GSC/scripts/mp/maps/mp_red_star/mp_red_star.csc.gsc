/***********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_red_star\mp_red_star\.csc.gsc
***********************************************************/

main() {
  scripts\mp\lighting::init();
  scripts\common\trigger::_id_80A3();
  thread scripts\common\fx_zones::fx_zone_watcher("apartment", "msg_fx_zone_apartment");
  thread scripts\common\fx_zones::fx_zone_watcher("courtyard", "msg_fx_zone_courtyard");
  thread scripts\common\fx_zones::fx_zone_watcher("underground", "msg_fx_zone_underground");
  thread scripts\common\fx_zones::fx_zone_watcher("office", "msg_fx_zone_office");
  _func_00DF("#x374f34613ef7590ef", 1);
  _func_00DF("#x3c51757bb6571dfe4", 0.45);
  _func_00DF("#x3e6f20dc89ca4522a", 2);
  _func_00DF("#x3d16c9a360648a055", 1);
  _func_00DF("#x316739b0b2f3ad379", 1);
  _func_00DF("#x327cef7ae0eea8806", 2);
  _func_00DF("#x366a409d6a93d9df2", 16);
  _func_00DF("#x3931e06e107a35919", 1000);
  _func_00DF("#x375846f2cf02aaaf7", 1.2);
  _func_00DF("#x3e4ad4b60f6720dec", 1.5);
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
    _func_00DF("#x366a409d6a93d9df2", 16);
  }

  if(_func_00A0() || _func_009D() || _func_009A()) {
    _func_00DF("#x366a409d6a93d9df2", 16);
  }
}