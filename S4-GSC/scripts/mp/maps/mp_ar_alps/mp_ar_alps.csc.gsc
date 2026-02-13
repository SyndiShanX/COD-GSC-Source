/*********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_ar_alps\mp_ar_alps\.csc.gsc
*********************************************************/

main() {
  scripts\mp\lighting::init();
  _func_00DF("#x374f34613ef7590ef", 1);
  _func_00DF("#x3c51757bb6571dfe4", 0.45);
  _func_00DF("#x3e6f20dc89ca4522a", 2);
  _func_00DF("#x3e6f20cc89ca44ff7", 3);
  _func_00DF("#x366a409d6a93d9df2", 8);
  _func_00DF("#x336c71b3429ba36e2", 1);
  _func_00DF("#x3d16c9a360648a055", 1);
  _func_00DF("#x3931e06e107a35919", 1200);
  _func_00DF("#x375846f2cf02aaaf7", 1.2);
  _func_00DF("#x3e4ad4b60f6720dec", 1.5);
  thread _id_7E24();
  scripts\common\trigger::_id_80A3();
  thread scripts\common\fx_zones::fx_zone_watcher("base_a", "msg_fx_zone_base_a");
  thread scripts\common\fx_zones::fx_zone_watcher("base_b", "msg_fx_zone_base_b");
  thread scripts\common\fx_zones::fx_zone_watcher("base_c", "msg_fx_zone_base_c");
  thread scripts\common\fx_zones::fx_zone_watcher("base_d", "msg_fx_zone_base_d");
  thread scripts\common\fx_zones::fx_zone_watcher("base_e", "msg_fx_zone_base_e");
  thread scripts\common\fx_zones::fx_zone_watcher("base_f", "msg_fx_zone_base_f");
  thread scripts\common\fx_zones::fx_zone_watcher("base_g", "msg_fx_zone_base_g");
  _func_00DF("#x31edd4e9e1da7a385", "-10000 -6000 1500");
  _func_00DF("#x354449bd7ec3a6f40", "5000 5000");
  _func_00DF("#x3967813cae2acb7ce", 8000);
  _func_00DF("#x31de026e8fa468623", 6000);
  _func_00DF("#x32968b38509c960bd", "0.407 0.517 0.047");
  _func_00DF("#x327adf0e8fbde79f3", 0.00005);
  _func_00DF("#x3a0e7b593d3c0e8da", 100);
  _func_00DF("#x3a4318f362d722f7", 0.5);
  _func_00DF("#x32b424a6863c27e68", 0.5);
  _func_00DF("#x3aa6c49f229fc101a", 1);
  _func_00DF("#x3ff2a6e077d5ec2b1", 0);
  _func_00DF("#x36e952d31b9f309bc", 30);
  _func_00DF("#x375c5914412ffb42", 0);
  _func_00DF("#x3ee0f9158dfb5299d", 300);
  _func_00DF("#x395bc229b9c21ed4e", 0.94);
  _func_00DF("#x34279f192ae40dd6c", 20);
  _func_00DF("#x31f16a9250834871a", "1.0 1.0 1.0");
  _func_00DF("#x3f20be48d62a25563", 0.92);
  _func_00DF("#x3d51094dbed61e7ac", "1.0 0.5 0.5");
  _func_00DF("#x3bd7e2932a6fc6c1f", 305);
  _func_00DF("#x36466747178ffe7ff", 1);
  _func_00DF("#x36443627178d978b1", 0);
  _func_00DF("#x34c061399680fe12b", 0.3038);
  _func_00DF("#x3e295f30a9ffccdc", 0.15);
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