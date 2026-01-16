/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_icebreaker_water.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace mp_icebreaker_water;

autoexec __init__system__() {
  system::register(#"mp_icebreaker_water", &__init__, &__main__, undefined);
}

__init__() {
  clientfield::register("toplayer", "toggle_player_freezing_water", 1, 1, "counter");
  callback::on_spawned(&on_player_spawned);
}

__main__() {
  if(getdvarint(#"hash_517c09bbb9e82a90", 1)) {

    init_devgui();

      function_3b37c448();
  }
}

on_player_spawned() {
  self.var_653ea26 = 0;
}

function_3b37c448() {
  level.var_a6f19c15 = getEntArray("freezing_water_damage_trig", "targetname");
  array::thread_all(level.var_a6f19c15, &callback::on_trigger, &on_trigger);
}

on_trigger(s_info) {
  e_player = s_info.activator;

  function_2d706436(e_player);

    if(getdvarint(#"hash_517c09bbb9e82a90", 1) && isalive(e_player) && !(isDefined(e_player.var_6754f1c5) && e_player.var_6754f1c5) && getwaterheight(e_player.origin) - e_player.origin[2] >= getdvarint(#"hash_65893d2be0da2532", 30)) {

      if(getdvarint(#"hash_a23c3aad7eb7dd", 0)) {
        iprintlnbold("<dev string:x38>");
      }

        e_player.var_6754f1c5 = 1;
      e_player clientfield::increment_to_player("toggle_player_freezing_water");
      level thread start_freezing(e_player);

      while(level function_aa962363(e_player)) {
        waitframe(1);
      }

      if(isDefined(e_player)) {

        if(getdvarint(#"hash_a23c3aad7eb7dd", 0)) {
          iprintlnbold("<dev string:x46>");
        }

          e_player.var_6754f1c5 = 0;
        e_player clientfield::increment_to_player("toggle_player_freezing_water");
        level thread function_553ca6ce(e_player);
      }
    }
}

function_aa962363(e_player) {
  foreach(t_water in level.var_a6f19c15) {
    if(isalive(e_player) && isDefined(t_water) && e_player istouching(t_water) && getwaterheight(e_player.origin) - e_player.origin[2] >= getdvarint(#"hash_65893d2be0da2532", 30)) {
      return true;
    }
  }

  return false;
}

start_freezing(e_player) {
  while(isalive(e_player) && e_player.var_6754f1c5 && e_player.var_653ea26 < 1) {
    e_player.var_653ea26 += 0.1;

    if(e_player.var_653ea26 > 1) {
      e_player.var_653ea26 = 1;
    }

    if(getdvarint(#"hash_a23c3aad7eb7dd", 0)) {
      iprintln("<dev string:x53>" + e_player.var_653ea26);
    }

      wait 10 * 0.1;
  }

  if(getdvarint(#"hash_a23c3aad7eb7dd", 0) && isalive(e_player) && e_player.var_6754f1c5) {
    iprintlnbold("<dev string:x5e>");
  }

    while(0 && isalive(e_player) && e_player.var_6754f1c5) {

      if(getdvarint(#"hash_a23c3aad7eb7dd", 0)) {
        iprintlnbold("<dev string:x69>");
      }

        e_player dodamage(2, e_player.origin);
      e_player cleardamageindicator();
      wait 1;
    }
}

function_553ca6ce(e_player) {
  wait 1;

  while(isalive(e_player) && !e_player.var_6754f1c5 && e_player.var_653ea26 > 0) {
    e_player.var_653ea26 -= 0.2;

    if(e_player.var_653ea26 < 0) {
      e_player.var_653ea26 = 0;
    }

    if(getdvarint(#"hash_a23c3aad7eb7dd", 0)) {
      iprintln("<dev string:x7a>" + e_player.var_653ea26);
    }

      wait 5 * 0.2;
  }

  if(getdvarint(#"hash_a23c3aad7eb7dd", 0) && isalive(e_player) && !e_player.var_6754f1c5) {
    iprintlnbold("<dev string:x83>");
  }

}

init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x8c>" + mapname + "<dev string:x9c>");
  adddebugcommand("<dev string:x8c>" + mapname + "<dev string:xdf>");
  adddebugcommand("<dev string:x8c>" + mapname + "<dev string:x123>");
  adddebugcommand("<dev string:x8c>" + mapname + "<dev string:x162>");
}

function_2d706436(e_player) {
  if(!getdvarint(#"hash_a23c3aad7eb7dd", 0)) {
    return;
  }

  n_height = getwaterheight(e_player.origin) - e_player.origin[2];

  if(n_height > 0) {
    debug2dtext((800, 768, 0), "<dev string:x1a0>" + n_height, (1, 1, 1), 1, (0, 0, 0), 1, 1.2);
  }
}

