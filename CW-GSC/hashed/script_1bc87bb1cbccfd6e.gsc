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
  level.player = isDefined(level.player) ? level.player : getplayers()[0];

  if(!namespace_61e6d095::exists(#"chopper_display")) {
    namespace_61e6d095::create(#"chopper_display", #"chopper");
  }

  level.player val::set(#"helicopter", "show_weapon_hud", 0);
  level.player thread function_3cc2b159();
  entname::remove_all();
}

function function_437dfc97() {
  level.player = isDefined(level.player) ? level.player : getplayers()[0];
  self notify("30dbc82404b4037b");
  self endon("30dbc82404b4037b");

  if(namespace_61e6d095::exists(#"chopper_display")) {
    namespace_61e6d095::remove(#"chopper_display");
  }

  level.player val::reset(#"helicopter", "show_crosshair");
  level.player val::reset(#"helicopter", "show_weapon_hud");
  level.player notify(#"hash_6f1306832c75c68f");

  if(namespace_61e6d095::exists(#"hash_10ec463196b21e75")) {
    namespace_61e6d095::remove(#"hash_10ec463196b21e75");
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
  var_e583559a = getent("vol_ripcord_reticle", "targetname");

  if(!namespace_61e6d095::exists(#"hash_10ec463196b21e75")) {
    namespace_61e6d095::create(#"hash_10ec463196b21e75", #"hash_1624d8814bab0c71");
  }

  while(true) {
    if(isDefined(level.var_7466d419)) {
      var_2f37fbd = 0;
      weaponoverenemy = 0;
      v_origin = self getplayercamerapos();
      v_angles = anglesToForward(self getplayerangles());
      a_trace = bulletTrace(v_origin, v_origin + vectorscale(v_angles, 30000), 1, level.var_7466d419, 1, 0, self);
      var_fd92bc1 = a_trace[#"entity"];
      str_name = # "";
      var_dfc4aab4 = 0;

      if(isDefined(var_fd92bc1)) {
        if(isalive(var_fd92bc1) && isvehicle(var_fd92bc1) && var_fd92bc1 util::is_on_side(#"allies")) {
          var_2f37fbd = 1;

          if(isDefined(var_fd92bc1.var_97de493f)) {
            str_name = var_fd92bc1.var_97de493f;
            var_dfc4aab4 = 1;
          }
        } else if(var_fd92bc1 util::is_on_side(#"axis")) {
          if(isalive(var_fd92bc1)) {
            weaponoverenemy = 1;
          } else if(var_fd92bc1 flag::get(#"hash_5e822f0ec26ae171") && !var_fd92bc1 flag::get(#"hash_667f31bea2f2a495")) {
            weaponoverenemy = 1;
          }
        }
      } else {
        v_hit = a_trace[#"position"];

        if(isDefined(v_hit) && istouching(v_hit, var_e583559a)) {
          var_2f37fbd = 1;
          str_name = # "hash_37c430482010f0d0";
          var_dfc4aab4 = 1;
        }
      }

      if(var_2f37fbd || weaponoverenemy) {
        level flag::set("chopper_hud_target_highlighted");
        level flag::clear("chopper_hud_delayed_reticle_clear");
        namespace_61e6d095::set_text(#"hash_10ec463196b21e75", str_name);
        namespace_61e6d095::set_state(#"hash_10ec463196b21e75", var_dfc4aab4);
        globallogic_ui::function_9ed5232e("cp_chopper_hud.weaponOverFriendly", var_2f37fbd, 0);
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
  namespace_61e6d095::set_text(#"hash_10ec463196b21e75", #"");
  namespace_61e6d095::set_state(#"hash_10ec463196b21e75", 0);
  globallogic_ui::function_9ed5232e("cp_chopper_hud.weaponOverFriendly", 0, 0);
  globallogic_ui::function_9ed5232e("cp_chopper_hud.weaponOverEnemy", 0, 0);
}