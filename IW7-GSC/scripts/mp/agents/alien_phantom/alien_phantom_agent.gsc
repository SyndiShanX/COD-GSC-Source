/*******************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\alien_phantom\alien_phantom_agent.gsc
*******************************************************************/

registerscriptedagent() {
  scripts\mp\agents\alien_phantom\alien_phantom_tunedata::setuptunedata();
  scripts\aitypes\bt_util::init();
  behaviortree\alien_goon::func_DEE8();
  scripts\asm\alien_goon\mp\states::func_2371();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["alien_phantom"]["setup_func"] = ::setupagent;
  level.agent_definition["alien_phantom"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["alien_phantom"]["on_damaged"] = ::scripts\mp\agents\alien_goon\alien_goon_agent::func_C4E0;
  level.agent_funcs["alien_phantom"]["gametype_on_damage_finished"] = ::scripts\cp\agents\gametype_zombie::onzombiedamagefinished;
  level.agent_funcs["alien_phantom"]["gametype_on_killed"] = ::scripts\cp\maps\cp_final\cp_final_damage::cp_final_onzombiekilled;
  level.agent_funcs["alien_phantom"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::onzombiedamagefinished;
  level.agent_funcs["alien_phantom"]["on_killed"] = ::onkilled;
  level.brute_loot_check = [];
  if(!isDefined(level.var_8CBD)) {
    level.var_8CBD = [];
  }

  level.var_8CBD["alien_phantom"] = ::calculatealienphantomhealth;
  if(!isDefined(level.damage_feedback_overrride)) {
    level.damage_feedback_overrride = [];
  }
}

func_FACE(param_00) {
  self setModel("alien_brute");
}

setupagent() {
  scripts\mp\agents\alien_goon\alien_goon_agent::setupagent();
  self.var_B601 = 67;
  self.preventplayerpushdist = 12;
  self.spawn_round_num = level.wave_num;
  self.immune_against_nuke = 1;
}

calculatealienphantomhealth() {
  var_00 = scripts\mp\agents\alien_goon\alien_goon_agent::calculatealiengoonhealth();
  var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(level.players.size < 2) {
    var_00 = var_00 / 2;
  }

  return var_00 * var_01.goon_health_multiplier;
}

onkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(level.no_loot_drop) || !level.no_loot_drop) {
    var_09 = scripts\engine\utility::random(["ammo_max", "instakill_30", "cash_2", "instakill_30", "cash_2", "instakill_30", "cash_2"]);
    if(isDefined(var_09) && !isDefined(self.var_72AC)) {
      if(!isDefined(level.brute_loot_check[self.spawn_round_num])) {
        level.brute_loot_check[self.spawn_round_num] = 1;
        level thread scripts\cp\loot::drop_loot(self.origin, param_01, var_09, undefined, undefined, 1);
      }
    }

    var_0A = 400;
    foreach(var_0C in level.players) {
      if(var_0C scripts\cp\utility::is_valid_player()) {
        var_0C scripts\cp\cp_persistence::give_player_currency(var_0A);
      }
    }
  }

  if(self isethereal()) {
    level.totalphantomsjumping--;
    if(level.totalphantomsjumping <= 0) {
      level.totalphantomsjumping = 0;
    }
  }

  scripts\mp\agents\zombie\zmb_zombie_agent::onzombiekilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}