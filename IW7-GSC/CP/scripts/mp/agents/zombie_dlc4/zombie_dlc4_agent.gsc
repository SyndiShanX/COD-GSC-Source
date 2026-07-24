/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\agents\zombie_dlc4\zombie_dlc4_agent.gsc
***************************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\zombie_dlc4::_id_DEE8();
  scripts\asm\zombie_dlc4\mp\states::_id_2371();

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  level.agent_definition["generic_zombie"]["asm"] = "zombie_dlc4";
  level.agent_definition["generic_zombie"]["behaviorTree"] = "zombie_dlc4";
  level.agent_definition["generic_zombie"]["animclass"] = "zombie_dlc4_animclass";
  level._id_13BDC = 1;
  level._id_4878 = 0;
  level._id_BF7C = 0;
  level.movemodefunc = [];
  level._id_BCE5 = [];
  level._id_C082 = [];
  level._id_126E9 = [];
  level._id_8EE6 = [];
  level._id_5662 = [];
  level.playerteam = "allies";
  scripts\mp\agents\zombie\zombie_agent::_id_9890();
  scripts\mp\agents\zombie\zombie_agent::_id_98A5();
  scripts\mp\agents\zombie\zombie_agent::_id_97FB();
  scripts\mp\agents\zombie\zombie_agent::_id_AEB0();
  thread _id_FAB0();
  thread scripts\mp\agents\zombie\zombie_agent::_id_BC5C();
}

zombieinit_dlc() {
  scripts\asm\zombie\zombie::_id_13F9A();
}

_id_FAB0() {
  level endon("game_ended");

  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["generic_zombie"]["setup_func"] = ::setupagent;
  level.agent_definition["generic_zombie"]["setup_model_func"] = ::_id_FACE;
  level.agent_funcs["generic_zombie"]["gametype_on_damage_finished"] = ::scripts\cp\agents\gametype_zombie::onzombiedamagefinished;
  level.agent_funcs["generic_zombie"]["gametype_on_killed"] = ::scripts\cp\maps\cp_final\cp_final_damage::cp_final_onzombiekilled;
  level.agent_funcs["generic_zombie"]["on_damaged"] = ::scripts\cp\maps\cp_final\cp_final_damage::cp_final_onzombiedamaged;
  level.agent_funcs["generic_zombie"]["on_damaged_finished"] = ::onzombiedamagefinished;
  level.agent_funcs["generic_zombie"]["on_killed"] = ::onzombiekilled;
}

setupagent() {
  scripts\mp\agents\zombie\zombie_agent::setupagent();
  self.kung_fu_punched = 0;
  self.pinched = undefined;
  self.fridge_trap_marked = undefined;

  if(scripts\engine\utility::is_true(self.activated_venomx_sphere)) {
    self.activated_venomx_sphere = undefined;
  }

  if(scripts\engine\utility::is_true(self.dot_triggered)) {
    self.dot_triggered = undefined;
  }
}

_id_FACE(var_0) {
  scripts\mp\agents\zombie\zombie_agent::_id_FACE();
}

dopiranhatrapdeath() {
  scripts\asm\asm::asm_setstate("piranha_trap");
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