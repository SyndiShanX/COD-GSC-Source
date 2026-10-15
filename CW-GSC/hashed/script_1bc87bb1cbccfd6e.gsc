/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1bc87bb1cbccfd6e.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\ui\ent_name;

#namespace helicopter;

function private autoexec __init__system__() {
  system::register(#"chopper", &_preload, undefined, undefined, undefined);
}

function private _preload() {}

function function_2b057725() {
  level.player = isDefined(level.player) ? level.player : getPlayers()[0];

  if(!scripted_widgets::exists(#"chopper_display")) {
    scripted_widgets::create(#"chopper_display", #"chopper");
  }

  level.player val::set(#"helicopter", "show_weapon_hud", 0);
  level.player thread function_3cc2b159();
  entname::remove_all();
}

function function_437dfc97() {
  level.player = isDefined(level.player) ? level.player : getPlayers()[0];
  self notify("30dbc82404b4037b");
  self endon("30dbc82404b4037b");

  if(scripted_widgets::exists(#"chopper_display")) {
    scripted_widgets::remove(#"chopper_display");
  }

  level.player val::reset(#"helicopter", "show_crosshair");
  level.player val::reset(#"helicopter", "show_weapon_hud");
  level.player notify(#"hash_6f1306832c75c68f");

  if(scripted_widgets::exists(#"hash_10ec463196b21e75")) {
    scripted_widgets::remove(#"hash_10ec463196b21e75");
  }
}

function private function_3cc2b159() {
  self endon(#"hash_6f1306832c75c68f", #"death");
  self thread function_d7c9c129();

  while(true) {
    if(isDefined(level.var_7466d419)) {
      weaponheat = level.var_7466d419 getturretheatvalue(3);
      weaponoverheating = level.var_7466d419 isvehicleturretoverheating(3);
      rocketammo = level.var_7466d419 function_e2d89efe(0);
      reloading = level.var_7466d419 function_fde0d99e(0) > 0;
      globallogic_ui::function_9ed5232e("cp_chopper_hud.weaponHeat", weaponheat, 0);
      globallogic_ui::function_9ed5232e("cp_chopper_hud.weaponOverheating", weaponoverheating, 0);
      globallogic_ui::function_9ed5232e("cp_chopper_hud.rocketAmmo", rocketammo, 0);
      globallogic_ui::function_9ed5232e("cp_chopper_hud.rocketReloading", reloading, 0);
    }

    waitframe(1);
  }
}

function function_d7c9c129() {
  self endon(#"hash_6f1306832c75c68f", #"death");
  var_e583559a = getEnt("vol_ripcord_reticle", "targetname");

  if(!scripted_widgets::exists(#"hash_10ec463196b21e75")) {
    scripted_widgets::create(#"hash_10ec463196b21e75", #"hash_1624d8814bab0c71");
  }

  while(true) {
    if(isDefined(level.var_7466d419)) {
      weaponoverfriendly = 0;
      weaponoverenemy = 0;
      v_origin = self getplayercamerapos();
      v_angles = anglesToForward(self getplayerangles());
      a_trace = bulletTrace(v_origin, v_origin + vectorscale(v_angles, 30000), 1, level.var_7466d419, 1, 0, self);
      e_hit = a_trace[#"entity"];
      str_name = #"";
      n_team = 0;

      if(isDefined(e_hit)) {
        if(isalive(e_hit) && isvehicle(e_hit) && e_hit util::is_on_side(#"allies")) {
          weaponoverfriendly = 1;

          if(isDefined(e_hit.var_97de493f)) {
            str_name = e_hit.var_97de493f;
            n_team = 1;
          }
        } else if(e_hit util::is_on_side(#"axis")) {
          if(isalive(e_hit)) {
            weaponoverenemy = 1;
          } else if(e_hit flag::get(#"hash_5e822f0ec26ae171") && !e_hit flag::get(#"hash_667f31bea2f2a495")) {
            weaponoverenemy = 1;
          }
        }
      } else {
        v_hit = a_trace[#"position"];

        if(isDefined(v_hit) && istouching(v_hit, var_e583559a)) {
          weaponoverfriendly = 1;
          str_name = #"hash_37c430482010f0d0";
          n_team = 1;
        }
      }

      if(weaponoverfriendly || weaponoverenemy) {
        level flag::set("chopper_hud_target_highlighted");
        level flag::clear("chopper_hud_delayed_reticle_clear");
        scripted_widgets::set_text(#"hash_10ec463196b21e75", str_name);
        scripted_widgets::set_state(#"hash_10ec463196b21e75", n_team);
        globallogic_ui::function_9ed5232e("cp_chopper_hud.weaponOverFriendly", weaponoverfriendly, 0);
        globallogic_ui::function_9ed5232e("cp_chopper_hud.weaponOverEnemy", weaponoverenemy, 0);
      } else if(level flag::get("chopper_hud_target_highlighted") && !level flag::get("chopper_hud_delayed_reticle_clear")) {
        level flag::clear("chopper_hud_target_highlighted");
        level flag::set("chopper_hud_delayed_reticle_clear");
        self thread chopper_hud_delayed_reticle_clear();
      } else if(!level flag::get("chopper_hud_delayed_reticle_clear")) {
        function_5c086305();
      }
    }

    waitframe(1);
  }
}

function chopper_hud_delayed_reticle_clear() {
  self endon(#"hash_6f1306832c75c68f", #"death");
  level endon(#"chopper_hud_target_highlighted");
  waitframe(3);
  function_5c086305();
  level flag::clear("chopper_hud_delayed_reticle_clear");
}

function function_5c086305() {
  scripted_widgets::set_text(#"hash_10ec463196b21e75", #"");
  scripted_widgets::set_state(#"hash_10ec463196b21e75", 0);
  globallogic_ui::function_9ed5232e("cp_chopper_hud.weaponOverFriendly", 0, 0);
  globallogic_ui::function_9ed5232e("cp_chopper_hud.weaponOverEnemy", 0, 0);
}