/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_stoker.csc
***********************************************/

#include scripts\core_common\ai\systems\fx_character;
#include scripts\core_common\ai_shared;
#include scripts\core_common\footsteps_shared;
#include scripts\core_common\system_shared;

#namespace archetype_stoker;

autoexec __init__system__() {
  system::register(#"stoker", &__init__, undefined, undefined);
}

__init__() {
  footsteps::registeraitypefootstepcb(#"stoker", &function_7188417c);
  ai::add_archetype_spawn_function(#"stoker", &function_580b77a2);
}

function_7188417c(localclientnum, pos, surface, notetrack, bone) {
  e_player = function_5c10bd79(localclientnum);
  n_dist = distancesquared(pos, e_player.origin);
  var_166f3552 = 1000000;

  if(var_166f3552 > 0) {
    n_scale = (var_166f3552 - n_dist) / var_166f3552;
  } else {
    return;
  }

  if(n_scale > 1 || n_scale < 0) {
    return;
  }

  n_scale *= 0.25;

  if(n_scale <= 0.01) {
    return;
  }

  earthquake(localclientnum, n_scale, 0.1, pos, n_dist);

  if(n_scale <= 0.25 && n_scale > 0.2) {
    function_36e4ebd4(localclientnum, "anim_med");
    return;
  }

  if(n_scale <= 0.2 && n_scale > 0.1) {
    function_36e4ebd4(localclientnum, "damage_light");
    return;
  }

  function_36e4ebd4(localclientnum, "damage_light");
}

private function_580b77a2(localclientnum) {
  fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}