/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\agents\lumberjack\lumberjack_agent.gsc
*************************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\lumberjack::_id_DEE8();
  scripts\asm\lumberjack\mp\states::_id_2371();
  thread _id_FAB0();
}

_id_FAB0() {
  level endon("game_ended");

  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["lumberjack"]["setup_func"] = ::setupagent;
  level.agent_definition["lumberjack"]["setup_model_func"] = ::_id_FACE;
  level.agent_funcs["lumberjack"]["on_damaged"] = ::scripts\cp\agents\gametype_zombie::onzombiedamaged;
  level.agent_funcs["lumberjack"]["gametype_on_damage_finished"] = ::scripts\cp\agents\gametype_zombie::onzombiedamagefinished;
  level.agent_funcs["lumberjack"]["gametype_on_killed"] = ::scripts\cp\agents\gametype_zombie::onzombiekilled;
  level._id_1094E["lumberjack"] = ::should_spawn_lumberjack;
}

setupagent() {
  scripts\mp\agents\zombie\zombie_agent::setupagent();
}

_id_FACE(var_0) {
  self setModel("zombie_lumberjack");
  thread delay_eye_glow();
}

delay_eye_glow() {
  self endon("death");
  wait 0.5;
  self emissiveblend(1, 0.1);
}

onzombiedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  scripts\mp\agents\zombie\zombie_agent::onzombiedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
}

onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\mp\agents\zombie\zombie_agent::onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_C4BD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\mp\agents\zombie\zombie_agent::_id_C4BD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

should_spawn_lumberjack() {
  var_0 = 0;

  if(level.wave_num >= 20) {
    var_0 = min(level.wave_num - 10, 20);
  } else {
    var_0 = level.lumberjack_spawn_percent;
  }

  var_1 = 5;

  if(getdvarint("scr_force_lumberjack_spawn", 0) == 1) {
    var_1 = 0;
    var_0 = 100;
  }

  if(getdvarint("scr_force_no_lumberjack_spawn", 0) == 1) {
    var_1 = 500;
    var_0 = 0;
  }

  if(level.wave_num > var_1) {
    if(randomint(100) < var_0) {
      return "lumberjack";
    }

    return undefined;
  }

  return undefined;
}