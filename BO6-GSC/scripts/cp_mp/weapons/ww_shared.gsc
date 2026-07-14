/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\weapons\ww_shared.gsc
***********************************************/

#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace ww_shared;

function private autoexec __init__system__() {
  system::register(#"ww_shared", undefined, undefined, &post_main);
}

function show_hud_tutorial_message(tutorial_message_text, message_duration = 9.5) {
  self notify("409eea8352f2375d");
  self endon("409eea8352f2375d");
  level endon("game_ended");
  self endon("disconnect");
  assert(isnumber(message_duration), "<dev string:x24>");
  message_duration = max(message_duration, 2);

  if(!hud_management::function_3a5ea1e8f80924f5("ww_tutorial_message_zm")) {
    hud_management::function_6c64f5190d26c96("ww_tutorial_message_zm", "scripted_widget_ww_tutorial_message_zm");
  }

  hud_management::function_332d1650d80633c4("ww_tutorial_message_zm", 0, 0, 0, 0);
  hud_management::function_195e74a403805f("ww_tutorial_message_zm", "locstring_index", getlocstringindex(tutorial_message_text) ?? 0);
  hud_management::function_d04a6b5e3d6f9bb8("ww_tutorial_message_zm", "Show");
  wait message_duration - 0.5;

  if(self) {
    hud_management::function_d04a6b5e3d6f9bb8("ww_tutorial_message_zm", "Hide");
  } else {
    return;
  }

  wait 0.6;

  if(self && hud_management::function_3a5ea1e8f80924f5("ww_tutorial_message_zm")) {
    hud_management::scripted_widget_destroy("ww_tutorial_message_zm");
  }
}

function function_50a43e11790d1a15(weapon_name, var_845c4e66931a5ce3, var_88a6e05244d65d08) {
  assert(isPlayer(self), "<dev string:x5a>");
  assert(isstring(weapon_name), "<dev string:x91>");
  assert(isstring(var_88a6e05244d65d08), "<dev string:xb1>");
  level endon("game_ended");
  self endon("death_or_disconnect");
  utility::function_7c10ea82c1e305b8(var_845c4e66931a5ce3, var_88a6e05244d65d08);
  self notify("stop_monitor_ww_ambient_fx_" + weapon_name + "_state");
  waitframe();

  if(self) {
    data = function_3f47706f13684728(weapon_name);
    data.var_845c4e66931a5ce3 = undefined;
    data.var_bc3ad5120bbdf8ea = undefined;
    data.var_88a6e05244d65d08 = undefined;
  }
}

function function_3472b693f638483a(weapon_name, var_845c4e66931a5ce3, var_bc3ad5120bbdf8ea, var_88a6e05244d65d08) {
  self notify("dc0acf9b52525fc6");
  self endon("dc0acf9b52525fc6");
  assert(isPlayer(self), "<dev string:x5a>");
  assert(isstring(weapon_name), "<dev string:x91>");
  assert(isstring(var_845c4e66931a5ce3), "<dev string:xdc>");
  assert(isstring(var_bc3ad5120bbdf8ea), "<dev string:x105>");
  assert(isstring(var_88a6e05244d65d08), "<dev string:xb1>");
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stop_monitor_ww_ambient_fx_" + weapon_name + "_state");
  childthread function_68ec63128ba030ec(weapon_name);
  childthread function_13a498dce15e6900(weapon_name);
  childthread function_1f96acfd76120b74(weapon_name);
  wait 0.2;
  data = function_3f47706f13684728(weapon_name);
  data.var_845c4e66931a5ce3 = var_845c4e66931a5ce3;
  data.var_bc3ad5120bbdf8ea = var_bc3ad5120bbdf8ea;
  data.var_88a6e05244d65d08 = var_88a6e05244d65d08;

  while(true) {
    if(!istrue(data.is_switching) && !istrue(data.is_raising) && !data.inspect_end) {
      if(!level.var_50a43e11790d1a15) {
        utility::function_32b24db3127bff40(var_845c4e66931a5ce3, var_bc3ad5120bbdf8ea);
      } else {
        utility::function_32b24db3127bff40(var_845c4e66931a5ce3, var_88a6e05244d65d08);
      }
    }

    waitframe();
  }
}

function private post_main() {
  scene::function_85b13b837056bc8b(&function_a129aa9337577eb8);
  scene::function_53de0775d8452750(&function_b0f647e09ffd1a1d);
}

function private function_a129aa9337577eb8() {
  level.var_50a43e11790d1a15 = 1;
}

function private function_b0f647e09ffd1a1d() {
  level.var_50a43e11790d1a15 = 0;
}

function private function_68ec63128ba030ec(weapon_name) {
  self notify("e97ecd31c0a83b5");
  self endon("e97ecd31c0a83b5");
  data = function_3f47706f13684728(weapon_name);
  data.is_switching = 0;

  while(true) {
    self waittill("weapon_switch_started");
    waitframe();
    utility::function_32b24db3127bff40(data.var_845c4e66931a5ce3, data.var_88a6e05244d65d08);
    data.is_switching = 1;

    while(true) {
      result = utility::waittill_any_return_params("weapon_raise_code", "weapon_switch_canceled", "offhand_end", "melee_fired");

      if(result["message"] == "weapon_raise_code" || result["message"] == "melee_fired") {
        weapon = result[0];

        if(isweapon(weapon) && getweaponrootstring(weapon) == weapon_name) {
          break;
        }

        continue;
      }

      break;
    }

    data.is_switching = 0;
  }
}

function private function_13a498dce15e6900(weapon_name) {
  self notify("8368bcc76af5edcc");
  self endon("8368bcc76af5edcc");
  data = function_3f47706f13684728(weapon_name);
  data.is_raising = 0;

  while(true) {
    self waittill("weapon_raise_code", weapon);

    if(weapon.basename != weapon_name) {
      continue;
    }

    data.is_raising = 1;
    utility::function_32b24db3127bff40(data.var_845c4e66931a5ce3, data.var_88a6e05244d65d08);
    wait 0.1;
    data.is_raising = 0;
  }
}

function private function_1f96acfd76120b74(weapon_name) {
  self notify("36e88067d56c1645");
  self endon("36e88067d56c1645");
  data = function_3f47706f13684728(weapon_name);
  data.inspect_end = 0;

  while(true) {
    self waittill("weapon_inspect");

    while(self function_985124b0e1e74f2e()) {
      waitframe();
    }

    data.inspect_end = 1;
    utility::function_32b24db3127bff40(data.var_845c4e66931a5ce3, data.var_88a6e05244d65d08);
    waitframe();
    data.inspect_end = 0;
  }
}

function private function_3f47706f13684728(weapon_name) {
  if(!isarray(self.ww_shared_player_data)) {
    self.ww_shared_player_data = [];
  }

  if(isstring(weapon_name)) {
    if(!isDefined(self.ww_shared_player_data[weapon_name])) {
      self.ww_shared_player_data[weapon_name] = {};
    }

    return self.ww_shared_player_data[weapon_name];
  }
}