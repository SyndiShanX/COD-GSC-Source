/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_bat.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\duplicaterender_mgr;
#include scripts\core_common\filter_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\zm_common\zm_utility;

#namespace bat;

autoexec main() {
  vehicle::add_vehicletype_callback("bat", &function_9b3fe343);
  clientfield::register("vehicle", "bat_transform_fx", 8000, 1, "int", &battransformfx, 0, 0);
}

private function_9b3fe343(localclientnum) {
  self mapshaderconstant(localclientnum, 0, "scriptVector2", 0.1);

  if(isDefined(level.debug_keyline_zombies) && level.debug_keyline_zombies) {
    self duplicate_render::set_dr_flag("keyline_active", 1);
    self duplicate_render::update_dr_filters(localclientnum);
  }

  util::playFXOnTag(localclientnum, #"hash_1cb1e3e527bd121c", self, "tag_eye");
}

battransformfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    e_player = function_5c10bd79(localclientnum);
    physicsexplosionsphere(localclientnum, self.origin, 250, 30, 5);
    n_dist = distance(self.origin, e_player.origin);

    if(n_dist < 400) {
      function_36e4ebd4(localclientnum, "damage_light");
    }
  }
}