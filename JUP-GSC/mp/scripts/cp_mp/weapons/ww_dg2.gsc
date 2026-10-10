/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\weapons\ww_dg2.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\weapons\lightning_chain;
#using scripts\engine\utility;
#namespace ww_dg2;

function private autoexec __init__system__() {
  system::register(#"ww_dg2", undefined, &pre_main, &post_main);
}

function private pre_main() {
  utility::registersharedfunc("ww_dg2", "init", &init);
}

function private post_main() {
  common_init();
  utility::function_f3bb4f4911a1beb2("ww_dg2", "init");
}

function private init() {
  level.var_b8d710fc87c905a1 = lightning_chain::create_lightning_chain_params(10, 300, 50, 0.5, 3);
}

function private common_init() {
  level callback::add("on_zombie_ai_damaged", &function_fcb148baa85e63de);
  level callback::add("on_soldier_ai_damaged", &function_fcb148baa85e63de);
  level callback::add("player_weapon_change", &function_5aff8c871be4b6a5);
  level callback::add("player_spawned", &function_66f5c15498542ce8);
  level callback::add("on_player_damage_effects", &function_a8217ec145971b7e);

  if(utility::issharedfuncdefined("zombie_utils", "registerDamageCallback")) {
    utility::function_f3bb4f4911a1beb2("zombie_utils", "registerDamageCallback", &function_9eb3bd76e4d989d0);
  }

  function_9a024cd909d6e0a3(&function_9eb3bd76e4d989d0);
}

function private function_7f857f171729eb77() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    var_f659875a12b8b65a = 0;
    var_c872f109df7b2a6c = 0;
    enemies = getaiarrayinradius(self.origin, 200);

    foreach(enemy in enemies) {
      if(!isalive(enemy)) {
        continue;
      }

      if(istrue(enemy.lc_stunned)) {
        var_d0731a385b1a1495 = vectorNormalize(enemy.origin - self.origin);
        var_12a9bd2434c6a3ce = anglesToForward(self getplayerangles());
        dot = vectordot(var_d0731a385b1a1495, var_12a9bd2434c6a3ce);

        if(dot > 0.5) {
          var_f659875a12b8b65a = 1;

          if(istrue(enemy.var_29a419c3cdeccf06)) {
            var_c872f109df7b2a6c = 1;
          }

          break;
        }
      }
    }

    if(istrue(var_f659875a12b8b65a)) {
      if(!utility::function_35c178c80fa19cbd("DG2SplashVfx", "hit")) {
        if(istrue(var_c872f109df7b2a6c)) {
          utility::function_3677f2be30fdd581("DG2SplashVfx", "near_pap");
        } else {
          utility::function_3677f2be30fdd581("DG2SplashVfx", "near");
        }
      }
    } else if(utility::function_35c178c80fa19cbd("DG2SplashVfx", "near") || utility::function_35c178c80fa19cbd("DG2SplashVfx", "near_pap")) {
      utility::function_3677f2be30fdd581("DG2SplashVfx", "off");
    }

    wait 0.1;
  }
}

function private function_66f5c15498542ce8(params) {
  thread function_7f857f171729eb77();
  thread function_ad1e9f526ceb1e9a();
}

function private function_a8217ec145971b7e(var_2809cfd0f803f738) {
  self endon("death_or_disconnect");

  if(!isDefined(var_2809cfd0f803f738.objweapon) || var_2809cfd0f803f738.objweapon.basename != "jup_ar_dg2_mp") {
    return;
  }

  self notify("play_dg2_splash_vfx");
  self endon("play_dg2_splash_vfx");
  utility::function_3677f2be30fdd581("DG2SplashVfx", "hit");
  wait 0.5;
  utility::function_3677f2be30fdd581("DG2SplashVfx", "off");
}

function private function_ad1e9f526ceb1e9a() {
  self endon("disconnect");
  self waittill("death");
  utility::function_3677f2be30fdd581("DG2SplashVfx", "off");
}

function private function_fcb148baa85e63de(params) {
  if(isPlayer(params.eattacker) && params.sweapon.basename == "jup_ar_dg2_mp" && isDefined(params.einflictor) && (params.smeansofdeath == "MOD_PROJECTILE" || params.smeansofdeath == "MOD_PROJECTILE_SPLASH") && !istrue(self.lc_stunned)) {
    if(!isenemyteam(self.team, params.eattacker.team)) {
      return;
    }

    if(istrue(params.einflictor.var_d52b09a011a12b2a)) {
      return;
    } else {
      params.einflictor.var_d52b09a011a12b2a = 1;
    }

    params.eattacker.tesla_enemies_hit = 1;
    params.eattacker.tesla_enemies = undefined;
    params.eattacker.tesla_arc_count = 0;
    params.eattacker.tesla_firing = 1;
    var_b8d710fc87c905a1 = level.var_b8d710fc87c905a1;
    var_b8d710fc87c905a1.weapon = params.objweapon;
    var_b8d710fc87c905a1.player = params.eattacker;
    var_b8d710fc87c905a1.inflictor = params.einflictor;
    var_b8d710fc87c905a1.should_gib_head = 1;
    var_b8d710fc87c905a1.var_cc8643dde5979643 = params.eattacker namespace_2b1145f62aa835b8::function_af5127390d3221e9(params.sweapon);
    var_b8d710fc87c905a1.lc_id = string(params.eattacker getentitynumber()) + string(gettime());
    var_b8d710fc87c905a1.metabonename = params.metabonename;
    thread lightning_chain::arc_damage(self, params.eattacker, var_b8d710fc87c905a1);
  }
}

function private function_9eb3bd76e4d989d0(params) {
  if(isPlayer(params.eattacker) && params.sweapon.basename == "jup_ar_dg2_mp" && isDefined(params.einflictor) && (params.smeansofdeath == "MOD_PROJECTILE" || params.smeansofdeath == "MOD_PROJECTILE_SPLASH")) {
    return 1;
  }

  return -1;
}

function private function_5aff8c871be4b6a5(params) {
  if(!isDefined(params.weapon)) {
    return;
  }

  if(params.weapon.basename == "jup_ar_dg2_mp") {
    thread monitor_dg2_state(params.weapon);
    thread function_899ba52ba125b9af();
    return;
  }

  self notify("stop_monitor_dg2_state");
  self setscriptablepartstate("DG2Vfx", "off", 0);
  self.dg2_idle = 0;
  self.var_64d25496d1d39ad9 = 0;
}

function private function_899ba52ba125b9af() {
  self endon("death");
  self endon("stop_monitor_dg2_state");

  while(true) {
    result = waittill_any_return_5("weapon_switch_started", "skydive_deployparachute", "weapon_switch_canceled", "offhand_end", "skydive_end");

    if(!isDefined(result)) {
      continue;
    }

    if(result == "weapon_switch_started" || result == "skydive_deployparachute") {
      self.var_64d25496d1d39ad9 = 1;
      continue;
    }

    self.var_64d25496d1d39ad9 = 0;
  }
}

function private monitor_dg2_state(current_weapon) {
  self endon("death");
  self notify("stop_monitor_dg2_state");
  self endon("stop_monitor_dg2_state");
  var_e6f4ad46c089cece = 0;
  var_2f22cd958c8197fe = weaponclipsize(current_weapon);

  if(var_2f22cd958c8197fe == 6) {
    var_c24ad3a8bd139969 = 1;
  } else {
    var_c24ad3a8bd139969 = 0;
  }

  if(!istrue(self.var_5f57f272725cd5e0)) {
    wait 1;
    self.var_5f57f272725cd5e0 = 1;
  }

  while(true) {
    if(istrue(self.var_64d25496d1d39ad9)) {
      ammo_state = 0;
    } else {
      var_86d39fd35daed6a2 = self getcurrentweaponclipammo();

      if(var_c24ad3a8bd139969) {
        ammo_state = int(ceil(var_86d39fd35daed6a2 / 2));
      } else {
        ammo_state = var_86d39fd35daed6a2;
      }
    }

    if(ammo_state != var_e6f4ad46c089cece) {
      if(ammo_state == 0) {
        var_7933e922445754e3 = "off";
      } else {
        var_7933e922445754e3 = "vfx_start_" + ammo_state;

        if(var_c24ad3a8bd139969) {
          var_7933e922445754e3 += "_paped";
        }
      }

      self setscriptablepartstate("DG2Vfx", var_7933e922445754e3, 0);
      var_e6f4ad46c089cece = ammo_state;
    }

    waitframe();
  }
}