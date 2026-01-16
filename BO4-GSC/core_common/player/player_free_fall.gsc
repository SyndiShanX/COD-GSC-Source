/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\player\player_free_fall.gsc
***************************************************/

#include script_1d29de500c266470;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace player_free_fall;

autoexec __init__system__() {
  system::register(#"player_free_fall", &__init__, undefined, undefined);
}

__init__() {
  callback::add_callback(#"freefall", &function_c9a18304);
  callback::add_callback(#"parachute", &function_26d46af3);
  callback::add_callback(#"debug_movement", &function_a7e644f6);
  level.parachute_weapon = getweapon(#"parachute");

  level thread function_1fc427dc();

}

function_d2a1520c() {
  wingsuit = self namespace_eb06e24d::get_wingsuit();

  if(self util::is_female()) {
    return wingsuit.var_5677bd3d;
  }

  return wingsuit.var_94166112;
}

private function_c9a18304(eventstruct) {
  model = function_d2a1520c();

  if(eventstruct.freefall) {
    if(!self isattached(model)) {
      self attach(model);
    }

    if(!isDefined(eventstruct.var_695a7111) || eventstruct.var_695a7111) {
      parachute = self namespace_eb06e24d::get_parachute();
      parachute_weapon = parachute.("parachute");

      if(isDefined(parachute_weapon)) {
        if(!self hasweapon(parachute_weapon)) {
          self giveweapon(parachute_weapon);
        }

        self switchtoweaponimmediate(parachute_weapon);
        self thread function_b6e83203(0.5);
      }
    }

    return;
  }

  if(self isattached(model)) {
    self detach(model);
  }

  if(!self function_9a0edd92()) {
    parachute = self namespace_eb06e24d::get_parachute();
    parachute_weapon = parachute.("parachute");

    if(isDefined(parachute_weapon)) {
      if(self hasweapon(parachute_weapon)) {
        self takeweapon(parachute_weapon);
      }
    }
  }

  self setclientuivisibilityflag("weapon_hud_visible", 1);
}

private function_6aac1790(var_dbb94a) {
  if(isDefined(var_dbb94a) && !self isattached(var_dbb94a, "tag_weapon_right")) {}
}

private function_b6e83203(delay) {
  if(isDefined(delay)) {
    self endon(#"death", #"disconnect");
    wait delay;
  }

  parachute = self namespace_eb06e24d::get_parachute();
  var_dbb94a = parachute.("parachuteLit");
  function_6aac1790(var_dbb94a);
}

private function_26d46af3(eventstruct) {
  if(eventstruct.parachute) {
    self function_b6e83203();
    return;
  }

  parachute = self namespace_eb06e24d::get_parachute();
  parachute_weapon = parachute.("parachute");
  var_dbb94a = parachute.("parachuteLit");

  if(isDefined(parachute_weapon)) {
    self takeweapon(parachute_weapon);
  }

  if(isDefined(var_dbb94a)) {}
}

private function_a7e644f6(eventstruct) {
  if(!eventstruct.debug_movement) {
    if(getdvarint(#"hash_bfa71d08f383550", 0)) {
      speed = 8800;
      velocity = anglesToForward(self getplayerangles()) * speed;
      self forcefreefall(1, velocity, getdvarint(#"hash_bfa71d08f383550", 0) == 1);
    }
  }
}

private function_1fc427dc() {
  mapname = util::get_map_name();
  waitframe(1);
  waitframe(1);
  adddebugcommand("<dev string:x38>");
  adddebugcommand("<dev string:x64>");
  adddebugcommand("<dev string:x89>");
  adddebugcommand("<dev string:xad>" + mapname + "<dev string:xbb>");
  adddebugcommand("<dev string:xf2>" + mapname + "<dev string:x103>");
  adddebugcommand("<dev string:xf2>" + mapname + "<dev string:x139>");
  waitframe(1);
  adddebugcommand("<dev string:x17a>" + mapname + "<dev string:x18a>");
}

