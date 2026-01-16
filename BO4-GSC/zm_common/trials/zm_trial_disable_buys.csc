/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_disable_buys.csc
******************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_disable_buys;

autoexec __init__system__() {
  system::register(#"zm_trial_disable_buys", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"disable_buys", &on_begin, &on_end);
  forcestreamxmodel(#"p8_zm_wall_buy_ar_accurate");
  forcestreamxmodel(#"p8_zm_wall_buy_ar_fastfire");
  forcestreamxmodel(#"p8_zm_wall_buy_ar_modular");
  forcestreamxmodel(#"p8_zm_wall_buy_ar_stealth");
  forcestreamxmodel(#"p8_zm_wall_buy_bowie_knife");
  forcestreamxmodel(#"p8_zm_wall_buy_lmg_titan");
  forcestreamxmodel(#"p8_zm_wall_buy_pistol_burst");
  forcestreamxmodel(#"p8_zm_wall_buy_pistol_standard");
  forcestreamxmodel(#"p8_zm_wall_buy_shotgun_pump");
  forcestreamxmodel(#"p8_zm_wall_buy_shotgun_trenchgun");
  forcestreamxmodel(#"p8_zm_wall_buy_smg_accurate");
  forcestreamxmodel(#"p8_zm_wall_buy_smg_mp9");
  forcestreamxmodel(#"p8_zm_wall_buy_smg_drum_pistol");
  forcestreamxmodel(#"p8_zm_wall_buy_smg_fastfire");
  forcestreamxmodel(#"p8_zm_wall_buy_smg_handling");
  forcestreamxmodel(#"hash_1e826c91e070af89");
  forcestreamxmodel(#"p8_zm_wall_buy_tr_leveraction");
  forcestreamxmodel(#"p8_zm_wall_buy_tr_longburst");
  forcestreamxmodel(#"p8_zm_wall_buy_tr_powersemi");
  forcestreamxmodel(#"p8_zm_wall_buy_symbol_01");
  forcestreamxmodel(#"p8_zm_wall_buy_symbol_01_middle");
  forcestreamxmodel(#"p8_zm_wall_buy_symbol_01_reverse");
  forcestreamxmodel(#"hash_38b107b1b645837d");
}

private on_begin(local_client_num, params) {}

private on_end(local_client_num) {}