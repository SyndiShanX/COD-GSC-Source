/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_phantom_reload.gsc
****************************************************/

#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_utility;

#namespace zm_bgb_phantom_reload;

autoexec __init__system__() {
  system::register(#"zm_bgb_phantom_reload", &__init__, undefined, "bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_phantom_reload", "time", 240, &enable, &disable, undefined, undefined);
}

enable() {
  self thread function_44514728();
}

disable() {
  self notify(#"hash_1980fe24a98adbe4");
}

function_44514728() {
  self endon(#"hash_1980fe24a98adbe4");

  while(true) {
    self waittill(#"reload_start");
    w_current = self getcurrentweapon();

    if(w_current.isabilityweapon) {
      continue;
    }

    if(math::cointoss(30)) {
      n_clip_size = w_current.clipsize;
      self setweaponammoclip(w_current, n_clip_size);
    }

    self waittill(#"reload");
  }
}