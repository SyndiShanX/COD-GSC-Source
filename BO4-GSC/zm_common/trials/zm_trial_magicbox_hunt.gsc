/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_magicbox_hunt.gsc
*******************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb_pack;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;

#namespace zm_trial_magicbox_hunt;

autoexec __init__system__() {
  system::register(#"zm_trial_magicbox_hunt", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"magicbox_hunt", &on_begin, &on_end);
}

private on_begin(var_dd1a18c9) {
  level.var_dd1a18c9 = zm_trial::function_5769f26a(var_dd1a18c9);
  level.var_59f4d3a6 = 0;
  level.var_b69d170f = 0;
  level.var_bb641599 = 1;
  level.disable_firesale_drop = 1;
  zm_powerups::function_74b8ec6b("fire_sale");
  setgametypesetting(#"zmpowerupfiresale", 0);
  array::thread_all(getplayers(), &function_a4bcce4e);
  zm_trial_util::function_2976fa44(level.var_dd1a18c9);
  zm_trial_util::function_dace284(0);
  level thread function_cfb0f4d();
}

private on_end(round_reset) {
  zm_trial_util::function_f3dbeda7();
  level.var_dd1a18c9 = undefined;
  level.var_59f4d3a6 = undefined;
  level.var_bb641599 = 0;
  level.disable_firesale_drop = 0;
  zm_powerups::function_41cedb05("fire_sale");
  setgametypesetting(#"zmpowerupfiresale", 1);
  array::thread_all(getplayers(), &function_e8f640a5);

  if(!level.var_b69d170f) {
    zm_trial::fail(#"hash_52e05a9ea3e881ea");
  }

  level.var_b69d170f = undefined;
}

private function_cfb0f4d() {
  level endon(#"hash_7646638df88a3656", #"hash_2b35a48172d1e0c2");

  while(true) {
    level waittill(#"weapon_fly_away_start");
    level.var_59f4d3a6++;

    if(level.var_59f4d3a6 == level.var_dd1a18c9) {
      zm_trial_util::function_7d32b7d0(1);
      level.var_b69d170f = 1;
      level.var_bb641599 = 0;
      level notify(#"hash_2b35a48172d1e0c2");
      continue;
    }

    zm_trial_util::function_dace284(level.var_59f4d3a6);
  }
}

private function_a4bcce4e() {
  for(i = 0; i < 4; i++) {
    str_bgb = self.bgb_pack[i];

    if(str_bgb === #"zm_bgb_immolation_liquidation") {
      self.var_abfa1f6a = bgb_pack::function_834d35e(i);
      self bgb_pack::function_b2308cd(i, 3);
    }
  }
}

private function_e8f640a5() {
  for(i = 0; i < 4; i++) {
    str_bgb = self.bgb_pack[i];

    if(str_bgb === #"zm_bgb_immolation_liquidation") {
      self bgb_pack::function_b2308cd(i, self.var_abfa1f6a);
      self.var_abfa1f6a = undefined;
    }
  }
}