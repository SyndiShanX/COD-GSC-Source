/***************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\zombie_dlc2\zombie_dlc2_agent.gsc
***************************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\zombie_dlc2::func_DEE8();
  scripts\asm\zombie_dlc2\mp\states::func_2371();
  level.agent_definition["generic_zombie"]["asm"] = "zombie_dlc2";
  level.agent_definition["generic_zombie"]["behaviorTree"] = "zombie_dlc2";
  level.agent_definition["generic_zombie"]["animclass"] = "zombie_dlc2_animclass";
  level.var_13BDC = 1;
  level.var_4878 = 0;
  level.var_BF7C = 0;
  level.movemodefunc = [];
  level.var_BCE5 = [];
  level.var_C082 = [];
  level.var_126E9 = [];
  level.var_8EE6 = [];
  level.var_5662 = [];
  level.playerteam = "allies";
  scripts\mp\agents\zombie\zmb_zombie_agent::func_9890();
  scripts\mp\agents\zombie\zmb_zombie_agent::func_98A5();
  scripts\mp\agents\zombie\zmb_zombie_agent::func_97FB();
  scripts\mp\agents\zombie\zmb_zombie_agent::func_AEB0();
  thread func_FAB0();
  thread scripts\mp\agents\zombie\zmb_zombie_agent::func_BC5C();
}

zombieinit_dlc2() {
  scripts\asm\zombie\zombie::func_13F9A();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["generic_zombie"]["setup_func"] = ::setupagent;
  level.agent_definition["generic_zombie"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["generic_zombie"]["gametype_on_killed"] = ::scripts\cp\maps\cp_disco\cp_disco_damage::cp_disco_onzombiekilled;
  level.movemodefunc["generic_zombie"] = ::scripts\cp\agents\gametype_zombie::run_if_last_zombie;
  level.agent_funcs["generic_zombie"]["on_damaged"] = ::scripts\cp\maps\cp_disco\cp_disco_damage::cp_disco_onzombiedamaged;
  level.agent_funcs["generic_zombie"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::onzombiedamagefinished;
  level.agent_funcs["generic_zombie"]["on_killed"] = ::onzombiekilled;
}

setupagent() {
  scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
  self.kung_fu_punched = 0;
  self.pinched = undefined;
}

func_FACE(var_0) {
  scripts\mp\agents\zombie\zmb_zombie_agent::func_FACE();
}

dopiranhatrapdeath() {
  scripts\asm\asm::asm_setstate("piranha_trap");
}

onzombiedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  scripts\mp\agents\zombie\zmb_zombie_agent::onzombiedamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
}

onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\mp\agents\zombie\zmb_zombie_agent::onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

func_C4BD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\mp\agents\zombie\zmb_zombie_agent::func_C4BD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}