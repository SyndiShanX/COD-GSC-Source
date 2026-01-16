/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effects.gsc
*********************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace status_effect;

autoexec __init__system__() {
  system::register(#"status_effects", &__init__, undefined, undefined);
}

__init__() {
  callback::on_connect(&on_player_connect);
  callback::on_disconnect(&on_player_disconnect);
  callback::on_end_game(&on_end_game);

  level thread status_effects_init();

}

on_player_connect() {
  if(!isDefined(self._gadgets_player)) {
    self._gadgets_player = [];
  }

  self thread status_effects_devgui_player_connect();

}

on_player_disconnect() {

  self thread status_effects_devgui_player_disconnect();

}

on_end_game() {
  foreach(player in level.players) {
    player thread function_6519f95f();
  }
}

status_effects_init() {
  setdvar(#"scr_status_effects_devgui_cmd", "<dev string:x38>");
  setdvar(#"scr_status_effects_devgui_arg", 0);
  setdvar(#"scr_status_effects_devgui_player", 0);

  if(isdedicated()) {
    return;
  }

  level.status_effects_devgui_base = "<dev string:x3b>";
  level.status_effects_devgui_player_connect = &status_effects_devgui_player_connect;
  level.status_effects_devgui_player_disconnect = &status_effects_devgui_player_disconnect;
  level thread status_effects_devgui_think();
}

status_effects_devgui_player_disconnect() {
  if(!isDefined(level.status_effects_devgui_base)) {
    return;
  }

  remove_cmd_with_root = "<dev string:x56>" + level.status_effects_devgui_base + self.playername + "<dev string:x67>";
  util::add_queued_debug_command(remove_cmd_with_root);
}

status_effects_devgui_player_connect() {
  if(!isDefined(level.status_effects_devgui_base)) {
    return;
  }

  players = getplayers();

  for(i = 0; i < players.size; i++) {
    if(players[i] != self) {
      continue;
    }

    status_effects_devgui_add_player_status_effects(level.status_effects_devgui_base, players[i].playername, i + 1);
    status_effects_devgui_add_player_grenades(level.status_effects_devgui_base, players[i].playername, i + 1);
    function_2a302935(level.status_effects_devgui_base, players[i].playername, i + 1);
    return;
  }
}

function_2a302935(root, pname, index) {
  add_cmd_with_root = "<dev string:x6d>" + root + pname + "<dev string:x7b>";
  pid = "<dev string:x38>" + index;
  status_effects_devgui_add_player_command(add_cmd_with_root, pid, "<dev string:x7f>", "<dev string:x95>", undefined);
}

status_effects_devgui_add_player_status_effects(root, pname, index) {
  add_cmd_with_root = "<dev string:x6d>" + root + pname + "<dev string:xa1>";
  pid = "<dev string:x38>" + index;

  if(isDefined(level.var_233471d2)) {
    for(i = 0; i < level.var_233471d2.size; i++) {
      if(!isDefined(level.var_233471d2[i])) {
        println("<dev string:xb4>" + i);
      }

      if(isDefined(level.var_233471d2[i].var_18d16a6b)) {
        status_effects_devgui_add_player_command(add_cmd_with_root, pid, level.var_233471d2[i].var_18d16a6b, "<dev string:x133>", i);
      }
    }
  }
}

status_effects_devgui_add_player_grenades(root, pname, index) {
  add_cmd_with_root = "<dev string:x6d>" + root + pname + "<dev string:x140>";
  pid = "<dev string:x38>" + index;

  if(isDefined(level.var_233471d2)) {
    for(i = 0; i < level.var_233471d2.size; i++) {
      if(!isDefined(level.var_233471d2[i])) {
        println("<dev string:x153>" + i);
      }

      if(isDefined(level.var_233471d2[i].var_18d16a6b)) {
        grenade = "<dev string:x1da>" + level.var_233471d2[i].var_18d16a6b;
        status_effects_devgui_add_player_command(add_cmd_with_root, pid, grenade, "<dev string:x1f3>", grenade);
      }
    }
  }
}

status_effects_devgui_add_player_command(root, pid, cmdname, cmddvar, argdvar) {
  if(!isDefined(argdvar)) {
    argdvar = "<dev string:x202>";
  }

  adddebugcommand(root + cmdname + "<dev string:x20c>" + "<dev string:x216>" + "<dev string:x239>" + pid + "<dev string:x23d>" + "<dev string:x245>" + "<dev string:x239>" + cmddvar + "<dev string:x23d>" + "<dev string:x265>" + "<dev string:x239>" + argdvar + "<dev string:x67>");
}

status_effects_devgui_think() {
  for(;;) {
    cmd = getdvarstring(#"scr_status_effects_devgui_cmd");

    if(cmd == "<dev string:x38>") {
      waitframe(1);
      continue;
    }

    pid = getdvarint(#"scr_status_effects_devgui_player", 0);

    switch (cmd) {
      case #"set_active":
        status_effects_set_active_effect(pid);
        break;
      case #"give_grenade":
        status_effects_give_grenade(pid);
        break;
      case #"clear_all":
        function_64ba1c7e(pid);
      default:
        break;
    }

    setdvar(#"scr_status_effects_devgui_cmd", "<dev string:x38>");
    setdvar(#"scr_status_effects_devgui_arg", "<dev string:x38>");
    wait 0.5;
  }
}

function_64ba1c7e(pid) {
  player = getplayers()[pid - 1];

  if(isDefined(player)) {
    player function_6519f95f();
  }
}

status_effects_set_active_effect(pid) {
  arg = getdvarint(#"scr_status_effects_devgui_arg", 0);
  player = getplayers()[pid - 1];

  if(isDefined(player)) {
    player function_e2bff3ce(arg, undefined, player);
  }
}

status_effects_give_grenade(pid) {
  arg = getdvarstring(#"scr_status_effects_devgui_arg");
  player = getplayers()[pid - 1];

  if(isDefined(player)) {
    weapon = getweapon(arg);
    grenades = 0;
    pweapons = player getweaponslist();

    foreach(pweapon in pweapons) {
      if(pweapon != weapon && pweapon.isgrenadeweapon) {
        grenades++;
      }
    }

    if(grenades > 1) {
      foreach(pweapon in pweapons) {
        if(pweapon != weapon && pweapon.isgrenadeweapon) {
          grenades--;
          player takeweapon(pweapon);

          if(grenades < 2) {
            break;
          }
        }
      }
    }

    player giveweapon(weapon);
  }
}

