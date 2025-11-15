/*************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\lumberjack\lumberjack_agent.gsc
*************************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\lumberjack::func_DEE8();
  scripts\asm\lumberjack\mp\states::func_2371();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["lumberjack"]["setup_func"] = ::setupagent;
  level.agent_definition["lumberjack"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["lumberjack"]["on_damaged"] = ::scripts\cp\agents\gametype_zombie::onzombiedamaged;
  level.agent_funcs["lumberjack"]["gametype_on_damage_finished"] = ::scripts\cp\agents\gametype_zombie::onzombiedamagefinished;
  level.agent_funcs["lumberjack"]["gametype_on_killed"] = ::scripts\cp\agents\gametype_zombie::onzombiekilled;
  level.var_1094E["lumberjack"] = ::should_spawn_lumberjack;
}

setupagent() {
  scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
}

func_FACE(param_00) {
  self setModel("zombie_lumberjack");
  thread delay_eye_glow();
}

delay_eye_glow() {
  self endon("death");
  wait(0.5);
  self getrandomhovernodesaroundtargetpos(1, 0.1);
}

onzombiedamagefinished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C) {
  scripts\mp\agents\zombie\zmb_zombie_agent::onzombiedamagefinished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C);
}

onzombiekilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  scripts\mp\agents\zombie\zmb_zombie_agent::onzombiekilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}

func_C4BD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  scripts\mp\agents\zombie\zmb_zombie_agent::func_C4BD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

should_spawn_lumberjack() {
  var_00 = 0;
  if(level.wave_num >= 20) {
    var_00 = min(level.wave_num - 10, 20);
  } else {
    var_00 = level.lumberjack_spawn_percent;
  }

  var_01 = 5;
  if(getdvarint("scr_force_lumberjack_spawn", 0) == 1) {
    var_01 = 0;
    var_00 = 100;
  }

  if(getdvarint("scr_force_no_lumberjack_spawn", 0) == 1) {
    var_01 = 500;
    var_00 = 0;
  }

  if(level.wave_num > var_01) {
    if(randomint(100) < var_00) {
      return "lumberjack";
    }

    return undefined;
  }

  return undefined;
}