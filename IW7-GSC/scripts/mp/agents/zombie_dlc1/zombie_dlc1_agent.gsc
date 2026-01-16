/***************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\zombie_dlc1\zombie_dlc1_agent.gsc
***************************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\zombie_dlc1::func_DEE8();
  scripts\asm\zombie_dlc1\mp\states::func_2371();
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

zombieinit_dlc1() {
  scripts\asm\zombie\zombie::func_13F9A();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["generic_zombie"]["setup_func"] = ::setupagent;
  level.agent_definition["generic_zombie"]["setup_model_func"] = ::func_FACE;
  level.movemodefunc["generic_zombie"] = ::scripts\cp\agents\gametype_zombie::run_if_last_zombie;
  level.agent_funcs["generic_zombie"]["on_damaged_finished"] = ::onzombiedamagefinished;
  level.agent_funcs["generic_zombie"]["on_killed"] = ::onzombiekilled;
}

setupagent() {
  scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
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
  if(isDefined(self.balloon_in_hand)) {
    self.balloon_in_hand delete();
    self.balloon_in_hand = undefined;
  }

  if(isDefined(self.bholdingballooninleft) && isDefined(self.balloon_model)) {
    if(self.bholdingballooninleft) {
      self detach(self.balloon_model, "tag_accessory_left");
    } else {
      self detach(self.balloon_model, "tag_accessory_right");
    }
  }

  self.bholdingballooninleft = undefined;
  self.balloon_model = undefined;
  scripts\mp\agents\zombie\zmb_zombie_agent::onzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

func_C4BD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\mp\agents\zombie\zmb_zombie_agent::func_C4BD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}