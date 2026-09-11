/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_hq.gsc
************************************************/

function main() {
  setup_callbacks();
  deactivate_front_trigger_hurt();
}

function deactivate_front_trigger_hurt() {
  ref_131df();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &deactivate_gas_trap;
  level.bot_funcs["should_start_cautious_approach"] = &ref_132df;
}

function ref_131df() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var0 = 0;

  foreach(var2 in level.objectives) {
    var2 thread scripts\mp\bots\bots_gametype_common::monitor_zone_control();
    var3 = 0;

    if(istrue(var2.trigger.trigger_off)) {
      var2.trigger scripts\engine\utility::trigger_on();
      var3 = 1;
    }

    var2.nodes = scripts\mp\bots\bots_gametype_common::bot_get_valid_nodes_in_trigger(var2.trigger);

    if(var3) {
      var2.trigger scripts\engine\utility::trigger_off();
    }
  }

  level.death_info_func = 1;

  if(!var0) {
    var5 = find_current_radio();

    if(!isDefined(var5)) {
      var5 = scripts\engine\utility::random(level.objectives);
    }

    scripts\mp\bots\bots_gametype_common::custom_damageshield([var5]);
    level.damagepercenthigh[var5.trigger getentitynumber()] = 1;
    level.bot_gametype_precaching_done = 1;
    thread currlocation(var5);
    return;
  }
}

function currlocation(var0) {
  for(var1 = scripts\engine\utility::array_remove(level.objectives, var0); var1.size > 0; var1 = scripts\engine\utility::array_remove(var1, var2)) {
    var2 = undefined;
    var3 = find_current_radio();

    if(isDefined(var3) && scripts\engine\utility::array_contains(var1, var3)) {
      var2 = var3;
    } else {
      var2 = scripts\engine\utility::random(var1);
    }

    scripts\mp\bots\bots_gametype_common::custom_damageshield([var2]);
    level.damagepercenthigh[var2.trigger getentitynumber()] = 1;
  }
}

function deactivate_gas_trap() {
  self notify("bot_hq_think");
  self endon("bot_hq_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }

    var0 = find_current_radio();

    if(!isDefined(var0) || !istrue(var0.active) || !isDefined(level.damagepercenthigh[var0.trigger getentitynumber()])) {
      custompassengerwaitfunc();
      self[[self.personality_update_function]]();
      continue;
    }

    var1 = level.zone scripts\mp\gameobjects::getownerteam();

    if(self.team != var1) {
      if(!deactivate_gas_trap_cloud_parent(var0)) {
        custom_explode_mine(var0);
      }

      continue;
    }

    var2 = scripts\engine\utility::get_enemy_team(self.team);
    var3 = level.zone.touchlist[var2].size > 0;

    if(var3) {
      if(!deactivate_gas_trap_cloud_parent(var0)) {
        custom_explode_mine(var0);
      }

      continue;
    }

    if(!deactivate_hacked_console(var0)) {
      if(deactivate_gas_trap_cloud_parent(var0)) {
        wait randomfloat(2);
        custompassengerwaitfunc();
        continue;
      }

      deal_damage_after_time(var0);
    }
  }
}

function find_current_radio() {
  foreach(var1 in level.objectives) {
    if(isDefined(level.zone) && var1.trigger == level.zone.trigger) {
      return var1;
    }
  }
}

function deactivate_gas_trap_cloud_parent(var0) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing()) {
    return false;
  }

  return isDefined(self.initpayloadpunish) && self.initpayloadpunish == var0;
}

function deactivate_hacked_console(var0) {
  if(!scripts\mp\bots\bots_util::bot_is_protecting()) {
    return false;
  }

  return isDefined(self.initpayloadpunish) && self.initpayloadpunish == var0;
}

function custom_explode_mine(var0) {
  self.initpayloadpunish = var0;
  GscBinSkip1(0x45, "entrance_points_index", var0.entrance_indices);
}

function deal_damage_after_time(var0) {
  self.initpayloadpunish = var0;
  var1 = length(var0.ref_14713.setplacementxpshare) * 2;
  GscBinSkip1(0x45, "override_origin_node", var0.get_wave_targetname);
}

function custompassengerwaitfunc() {
  if(scripts\mp\bots\bots_util::bot_is_defending()) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
  }

  self.initpayloadpunish = undefined;
}

function ref_132df(var0) {
  if(var0) {
    var1 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var1 == "neutral" || var1 == self.team) {
      return 0;
    }
  }

  return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default(var0);
}