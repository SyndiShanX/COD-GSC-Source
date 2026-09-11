/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\juggernaut\juggernaut_agent.gsc
*************************************************************/

function registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\juggernaut_agent::registerbehaviortree();
  aiasm\suicidebomber_cp_mp::asm_register();
  scripts\cp_mp\agents\agent_init::agent_init();

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  if(!isDefined(level.species_funcs["human"])) {
    level.species_funcs["human"] = [];
  }

  level.agent_definition["juggernaut"]["setup_func"] = &setupagent;
  level.agent_definition["juggernaut"]["setup_model_func"] = &setupmodel;
  scripts\aitypes\assets::juggernaut();
}

function setupagent() {
  self.animationarchetype = "juggernaut";
  self.defaultcoverselector = "cover_default";
  self.voice = "russian";
  self.unittype = "juggernaut";
  self setengagementmindist(256, 0);
  self setengagementmaxdist(768, 1024);
}

function setupmodel(var0, var1) {
  self.headmodelname = undefined;
  self setModel("body_opforce_juggernaut");
}