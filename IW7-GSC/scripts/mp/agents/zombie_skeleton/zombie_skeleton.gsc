/*****************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\zombie_skeleton\zombie_skeleton.gsc
*****************************************************************/

zombie_skeleton_init() {
  registerscriptedagent();
  level.agent_funcs["skeleton"]["on_damaged"] = ::scripts\cp\agents\gametype_zombie::onzombiedamaged;
  level.agent_funcs["skeleton"]["gametype_on_damage_finished"] = ::scripts\cp\agents\gametype_zombie::onzombiedamagefinished;
  level.agent_funcs["skeleton"]["gametype_on_killed"] = ::scripts\cp\agents\gametype_zombie::onzombiekilled;
  level.movemodefunc["skeleton"] = ::scripts\cp\agents\gametype_zombie::run_if_last_zombie;
}

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  func_AEB0();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["skeleton"]["setup_func"] = ::setupagent;
  level.agent_definition["skeleton"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["skeleton"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::onzombiedamagefinished;
  level.agent_funcs["skeleton"]["on_killed"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::onzombiekilled;
}

setupagent() {
  scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
  self.is_skeleton = 1;
}

func_899C() {
  self endon("death");
  level waittill("game_ended");
  self clearpath();
  foreach(var_04, var_01 in self.var_164D) {
    var_02 = var_01.var_4BC0;
    var_03 = level.asm[var_04].states[var_02];
    scripts\asm\asm::func_2388(var_04, var_02, var_03, var_03.var_116FB);
    scripts\asm\asm::func_238A(var_04, "idle", 0.2, undefined, undefined, undefined);
  }
}

func_FACE(param_00) {
  if(isDefined(level.skeleton_model_override)) {
    self setModel(level.skeleton_model_override);
  } else {
    self setModel("fullbody_zmb_skeleton");
  }

  thread scripts\mp\agents\zombie\zmb_zombie_agent::func_50EF();
}

func_AEB0() {}

should_spawn_skeleton() {
  return undefined;
}