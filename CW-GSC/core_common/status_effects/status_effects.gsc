/*********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effects.gsc
*********************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace status_effect;

function private autoexec __init__system__() {
  system::register(#"status_effects", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_connect(&on_player_connect);
  callback::on_disconnect(&on_player_disconnect);
  callback::on_end_game(&on_end_game);

  level thread status_effects_init();
}

function on_player_connect() {
  if(!isDefined(self._gadgets_player)) {
    self._gadgets_player = [];
  }

  self thread status_effects_devgui_player_connect();
}

function on_player_disconnect() {
  self thread status_effects_devgui_player_disconnect();
}

function on_end_game() {
  if(!isPlayer(self)) {
    return;
  }

  self thread function_6519f95f();
}

function status_effects_init() {
  setDvar(#"scr_status_effects_devgui_cmd", "<dev string:x38>");
  setDvar(#"scr_status_effects_devgui_arg", 0);
  setDvar(#"scr_status_effects_devgui_player", 0);

  if(isdedicated()) {
    return;
  }

  level.status_effects_devgui_base = "<dev string:x3c>";
  level.status_effects_devgui_player_connect = &status_effects_devgui_player_connect;
  level.status_effects_devgui_player_disconnect = &status_effects_devgui_player_disconnect;
  level thread status_effects_devgui_think();
}

function status_effects_devgui_player_disconnect() {
  if(!isDefined(level.status_effects_devgui_base)) {
    return;
  }

  remove_cmd_with_root = "<dev string:x58>" + level.status_effects_devgui_base + self.playername + "<dev string:x6a>";
  util::add_queued_debug_command(remove_cmd_with_root);
}

function status_effects_devgui_player_connect() {
  if(!isDefined(level.status_effects_devgui_base)) {
    return;
  }

  index = self getentitynumber() + 1;
  status_effects_devgui_add_player_status_effects(level.status_effects_devgui_base, self.playername, index);
  status_effects_devgui_add_player_grenades(level.status_effects_devgui_base, self.playername, index);
  function_2a302935(level.status_effects_devgui_base, self.playername, index);
}

function function_2a302935(root, pname, index) {
  add_cmd_with_root = "<dev string:x71>" + root + pname + "<dev string:x80>";
  pid = "<dev string:x38>" + index;
  status_effects_devgui_add_player_command(add_cmd_with_root, pid, "<dev string:x85>", "<dev string:x9c>", undefined);
}

function status_effects_devgui_add_player_status_effects(root, pname, index) {
  add_cmd_with_root = "<dev string:x71>" + root + pname + "<dev string:xa9>";
  pid = "<dev string:x38>" + index;

  if(isDefined(level.var_233471d2)) {
    for(i = 0; i < level.var_233471d2.size; i++) {
      if(!isDefined(level.var_233471d2[i])) {
        println("<dev string:xbd>" + i);
      }

      if(isDefined(level.var_233471d2[i].var_18d16a6b)) {
        status_effects_devgui_add_player_command(add_cmd_with_root, pid, level.var_233471d2[i].var_18d16a6b, "<dev string:x13d>", i);
      }
    }
  }
}

function status_effects_devgui_add_player_grenades(root, pname, index) {
  add_cmd_with_root = "<dev string:x71>" + root + pname + "<dev string:x14b>";
  pid = "<dev string:x38>" + index;

  if(isDefined(level.var_233471d2)) {
    for(i = 0; i < level.var_233471d2.size; i++) {
      if(!isDefined(level.var_233471d2[i])) {
        println("<dev string:x15f>" + i);
      }

      if(isDefined(level.var_233471d2[i].var_18d16a6b)) {
        grenade = "<dev string:x1e7>" + level.var_233471d2[i].var_18d16a6b;
        status_effects_devgui_add_player_command(add_cmd_with_root, pid, grenade, "<dev string:x201>", grenade);
      }
    }
  }
}

function status_effects_devgui_add_player_command(root, pid, cmdname, cmddvar, argdvar) {
  if(!isDefined(argdvar)) {
    argdvar = "<dev string:x211>";
  }

  adddebugcommand(root + cmdname + "<dev string:x21c>" + "<dev string:x227>" + "<dev string:x24b>" + pid + "<dev string:x250>" + "<dev string:x259>" + "<dev string:x24b>" + cmddvar + "<dev string:x250>" + "<dev string:x27a>" + "<dev string:x24b>" + argdvar + "<dev string:x6a>");
}

function status_effects_devgui_think() {
  for(;;) {
    cmd = getdvarstring(#"scr_status_effects_devgui_cmd");

    if(cmd == "<dev string:x38>") {
      waitframe(1);
      continue;
    }

    pid = getdvarint(#"scr_status_effects_devgui_player", 0);

    switch (cmd) {
      case # "set_active":
        status_effects_set_active_effect(pid);
        break;
      case # "give_grenade":
        status_effects_give_grenade(pid);
        break;
      case # "clear_all":
        function_64ba1c7e(pid);
      default:
        break;
    }

    setDvar(#"scr_status_effects_devgui_cmd", "<dev string:x38>");
    setDvar(#"scr_status_effects_devgui_arg", "<dev string:x38>");
    wait 0.5;
  }
}

function function_64ba1c7e(pid) {
  player = getplayers()[pid - 1];

  if(isDefined(player)) {
    player function_6519f95f();
  }
}

function status_effects_set_active_effect(pid) {
  arg = getdvarint(#"scr_status_effects_devgui_arg", 0);
  player = getplayers()[pid - 1];

  if(isDefined(player)) {
    player function_e2bff3ce(arg, undefined, player);
  }
}

function status_effects_give_grenade(pid) {
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