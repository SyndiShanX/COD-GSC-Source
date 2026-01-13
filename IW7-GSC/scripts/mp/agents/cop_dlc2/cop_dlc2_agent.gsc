/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\cop_dlc2\cop_dlc2_agent.gsc
*********************************************************/

registerscriptedagent() {
  if(!isDefined(level.cop_spawn_percent)) {
    level.cop_spawn_percent = 5;
  }

  level.agent_funcs["cop_dlc2"]["on_damaged"] = scripts\cp\agents\gametype_zombie::onzombiedamaged;
  level.agent_funcs["cop_dlc2"]["gametype_on_damage_finished"] = scripts\cp\agents\gametype_zombie::onzombiedamagefinished;
  level.agent_funcs["cop_dlc2"]["gametype_on_killed"] = scripts\cp\agents\gametype_zombie::onzombiekilled;
  level.movemodefunc["cop_dlc2"] = scripts\cp\agents\gametype_zombie::run_if_last_zombie;
  scripts\aitypes\bt_util::init();
  func_AEB0();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["cop_dlc2"]["setup_func"] = ::setupagent;
  level.agent_definition["cop_dlc2"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["cop_dlc2"]["on_damaged_finished"] = scripts\mp\agents\zombie\zmb_zombie_agent::onzombiedamagefinished;
  level.agent_funcs["cop_dlc2"]["on_killed"] = scripts\mp\agents\zombie\zmb_zombie_agent::onzombiekilled;
  level.var_1094E["cop_dlc2"] = ::func_FF94;
}

setupagent() {
  scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
  thread func_899C();
  self.is_cop = 1;
}

func_899C() {
  self endon("death");
  level waittill("game_ended");
  self clearpath();
  foreach(var_4, var_1 in self.var_164D) {
    var_2 = var_1.var_4BC0;
    var_3 = level.asm[var_4].states[var_2];
    scripts\asm\asm::func_2388(var_4, var_2, var_3, var_3.var_116FB);
    scripts\asm\asm::func_238A(var_4, "idle", 0.2, undefined, undefined, undefined);
  }
}

func_FACE(var_0) {
  self setModel("police_officer_zombie");
  thread scripts\mp\agents\zombie\zmb_zombie_agent::func_50EF();
}

func_AEB0() {}

func_FF94() {
  return undefined;
}