/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_point_drops.gsc
*************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_bgb_pack;
#include scripts\zm_common\zm_score;

#namespace zm_bgb_point_drops;

autoexec __init__system__() {
  system::register(#"zm_bgb_point_drops", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_point_drops", "activated", 1, undefined, undefined, &validation, &activation);
  bgb_pack::function_9d4db403(#"zm_bgb_point_drops", 5);
  bgb_pack::function_430d063b(#"zm_bgb_point_drops");
  bgb_pack::function_a1194b9a(#"zm_bgb_point_drops");
  bgb_pack::function_4de6c08a(#"zm_bgb_point_drops");
}

activation() {
  self zm_score::minus_to_player_score(500);
  self thread bgb::function_c6cd71d5("bonus_points_player_shared");
}

validation() {
  if(self zm_score::can_player_purchase(500) && self bgb::function_9d8118f5()) {
    return true;
  }

  return false;
}