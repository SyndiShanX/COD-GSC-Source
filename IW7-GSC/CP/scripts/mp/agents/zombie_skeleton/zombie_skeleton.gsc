/*****************************************************************
 * Decompiled and Edited by SyndiShanX
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
  _id_AEB0();
  thread _id_FAB0();
}

_id_FAB0() {
  level endon("game_ended");

  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["skeleton"]["setup_func"] = ::setupagent;
  level.agent_definition["skeleton"]["setup_model_func"] = ::_id_FACE;
  level.agent_funcs["skeleton"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zombie_agent::onzombiedamagefinished;
  level.agent_funcs["skeleton"]["on_killed"] = ::scripts\mp\agents\zombie\zombie_agent::onzombiekilled;
}

setupagent() {
  scripts\mp\agents\zombie\zombie_agent::setupagent();
  self.is_skeleton = 1;
}

_id_899C() {
  self endon("death");
  level waittill("game_ended");
  self clearpath();

  foreach(var_4, var_1 in self._id_164D) {
    var_2 = var_1._id_4BC0;
    var_3 = anim.asm[var_4].states[var_2];
    scripts\asm\asm::_id_2388(var_4, var_2, var_3, var_3._id_116FB);
    scripts\asm\asm::_id_238A(var_4, "idle", 0.2, undefined, undefined, undefined);
  }
}

_id_FACE(var_0) {
  if(isDefined(level.skeleton_model_override)) {
    self setModel(level.skeleton_model_override);
  } else {
    self setModel("fullbody_zmb_skeleton");
  }

  thread scripts\mp\agents\zombie\zombie_agent::_id_50EF();
}

_id_AEB0() {}

should_spawn_skeleton() {
  return undefined;
}