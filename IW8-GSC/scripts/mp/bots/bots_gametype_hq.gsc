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
  var_0 = 0;

  foreach(var_2 in level.objectives) {
    var_2 thread scripts\mp\bots\bots_gametype_common::monitor_zone_control();
    var_3 = 0;

    if(istrue(var_2.trigger.trigger_off)) {
      var_2.trigger scripts\engine\utility::trigger_on();
      var_3 = 1;
    }

    var_2.nodes = scripts\mp\bots\bots_gametype_common::bot_get_valid_nodes_in_trigger(var_2.trigger);

    if(var_3) {
      var_2.trigger scripts\engine\utility::trigger_off();
    }
  }

  level.death_info_func = 1;

  if(!var_0) {
    var_5 = find_current_radio();

    if(!isDefined(var_5)) {
      var_5 = scripts\engine\utility::random(level.objectives);
    }

    scripts\mp\bots\bots_gametype_common::custom_damageshield([var_5]);
    level.damagepercenthigh[var_5.trigger getentitynumber()] = 1;
    level.bot_gametype_precaching_done = 1;
    thread currlocation(var_5);
    return;
  }
}

function currlocation(var_0) {
  for(var_1 = scripts\engine\utility::array_remove(level.objectives, var_0); var_1.size > 0; var_1 = scripts\engine\utility::array_remove(var_1, var_2)) {
    var_2 = undefined;
    var_3 = find_current_radio();

    if(isDefined(var_3) && scripts\engine\utility::array_contains(var_1, var_3)) {
      var_2 = var_3;
    } else {
      var_2 = scripts\engine\utility::random(var_1);
    }

    scripts\mp\bots\bots_gametype_common::custom_damageshield([var_2]);
    level.damagepercenthigh[var_2.trigger getentitynumber()] = 1;
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

    var_0 = find_current_radio();

    if(!isDefined(var_0) || !istrue(var_0.active) || !isDefined(level.damagepercenthigh[var_0.trigger getentitynumber()])) {
      custompassengerwaitfunc();
      self[[self.personality_update_function]]();
      continue;
    }

    var_1 = level.zone scripts\mp\gameobjects::getownerteam();

    if(self.team != var_1) {
      if(!deactivate_gas_trap_cloud_parent(var_0)) {
        custom_explode_mine(var_0);
      }

      continue;
    }

    var_2 = scripts\engine\utility::get_enemy_team(self.team);
    var_3 = level.zone.touchlist[var_2].size > 0;

    if(var_3) {
      if(!deactivate_gas_trap_cloud_parent(var_0)) {
        custom_explode_mine(var_0);
      }

      continue;
    }

    if(!deactivate_hacked_console(var_0)) {
      if(deactivate_gas_trap_cloud_parent(var_0)) {
        wait randomfloat(2);
        custompassengerwaitfunc();
        continue;
      }

      deal_damage_after_time(var_0);
    }
  }
}

function find_current_radio() {
  foreach(var_1 in level.objectives) {
    if(isDefined(level.zone) && var_1.trigger == level.zone.trigger) {
      return var_1;
    }
  }
}

function deactivate_gas_trap_cloud_parent(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing()) {
    return false;
  }

  return isDefined(self.initpayloadpunish) && self.initpayloadpunish == var_0;
}

function deactivate_hacked_console(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_protecting()) {
    return false;
  }

  return isDefined(self.initpayloadpunish) && self.initpayloadpunish == var_0;
}

function custom_explode_mine(var_0) {
  self.initpayloadpunish = var_0;
  GscBinSkip1(0x45, "entrance_points_index", var_0.entrance_indices);
}

function deal_damage_after_time(var_0) {
  self.initpayloadpunish = var_0;
  var_1 = length(var_0.ref_14713.setplacementxpshare) * 2;
  GscBinSkip1(0x45, "override_origin_node", var_0.get_wave_targetname);
}

function custompassengerwaitfunc() {
  if(scripts\mp\bots\bots_util::bot_is_defending()) {
    scripts\mp\bots\bots_strategy::bot_defend_stop();
  }

  self.initpayloadpunish = undefined;
}

function ref_132df(var_0) {
  if(var_0) {
    var_1 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var_1 == "neutral" || var_1 == self.team) {
      return 0;
    }
  }

  return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default(var_0);
}