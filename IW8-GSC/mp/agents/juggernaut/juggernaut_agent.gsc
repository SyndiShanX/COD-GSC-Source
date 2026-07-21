/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\agents\juggernaut\juggernaut_agent.gsc
*****************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\juggernaut_agent::registerbehaviortree();
  aiasm\suicidebomber_cp_mp::asm_register();
  scripts\cp_mp\agents\agent_init::agent_init();

  if(!isDefined(level.species_funcs))
    level.species_funcs = [];

  if(!isDefined(level.species_funcs["_encstr_A9C20643EAB52C9B"]))
    level.species_funcs["_encstr_A9C20643EAB52C9B"] = [];

  level.agent_definition["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"]["_encstr_A3E30B27A5A3108FCFCA0B50A2"] = ::setupagent;
  level.agent_definition["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"]["_encstr_A9CE11B9568ED5E0BE5BB72356D8EB66ABDCB1"] = ::setupmodel;
  scripts\aitypes\assets::juggernaut();
}

setupagent() {
  self.animationarchetype = "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
  self.defaultcoverselector = "_encstr_B23B0E52885CFFF289B1E5EE5330BD63";
  self.voice = "_encstr_964A08F5B3EE7B335128";
  self.unittype = "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
}

setupmodel(var_0, var_1) {
  self.headmodelname = undefined;
  self setModel("_encstr_95361801488D295FE801BB887261B81EF0CBF797711BF20B0BA1");
}