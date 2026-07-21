/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\agents\suicidebomber\suicidebomber_agent.gsc
***********************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\suicidebomber_agent::registerbehaviortree();
  character\character_cp_al_qatala_desert_ar_tmtyl::asm_register();
  scripts\cp_mp\agents\agent_init::agent_init();

  if(!isDefined(level.species_funcs))
    level.species_funcs = [];

  if(!isDefined(level.species_funcs["_encstr_A9C20643EAB52C9B"]))
    level.species_funcs["_encstr_A9C20643EAB52C9B"] = [];

  level.agent_definition["_encstr_8EF60E63FBE3D70440A312175B98CF6B"]["_encstr_A3E30B27A5A3108FCFCA0B50A2"] = ::setupagent;
  level.agent_definition["_encstr_8EF60E63FBE3D70440A312175B98CF6B"]["_encstr_A9CE11B9568ED5E0BE5BB72356D8EB66ABDCB1"] = ::setupmodel;
  scripts\aitypes\assets::suicidebomber();
}

setupagent() {
  self.animationarchetype = "_encstr_8EF60E63FBE3D70440A312175B98CF6B";
  self.defaultcoverselector = "_encstr_B23B0E52885CFFF289B1E5EE5330BD63";
  self.voice = "_encstr_8DC7086BEEA408C0AF8A";
  self.unittype = "_encstr_8EF60E63FBE3D70440A312175B98CF6B";
  self.dropweapon = 0;
  self.nocorpse = 1;
  self.repulsorname = "_encstr_83960CE65D4BC69619CA7657F202" + self getentitynumber();
  createnavrepulsor(self.repulsorname, -1, self, 200, 1, "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
}

onkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  destroynavrepulsor(self.repulsorname);
  self.nocorpse = 1;
  scripts\mp\mp_agent::default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

setupmodel(var_0, var_1) {
  if(self.team == "_encstr_8E8405EA382B2A") {
    if(isDefined(var_1) && isDefined(level.agentmodeltabledata)) {
      var_2 = weaponclass(var_1);
      var_3 = level.agentmodeltabledata[var_2].bodymodel;
      var_4 = level.agentmodeltabledata[var_2].headmodel;
    } else {
      var_3 = "_encstr_A1292AE80AE7F3EEB76024A85ABF91F74D9273A0623D0743778A369032FF1B7979DF1118DA15B57E6385BE15";
      var_4 = "_encstr_864423A19558C8FAB683AF7B3833DB9C36B2AFC6ED37C8BDE6BE47ACC9C9DB272DCDE8FA4C";
    }

    setcharmodels(var_3, var_4);
  } else
    self setModel("_encstr_95A2172BD829D15945012611FB13C39F1628B35730A1059261");
}

setcharmodels(var_0, var_1, var_2) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self setModel(var_0);

  if(isDefined(var_1) && var_1 != "_encstr_B40101") {
    self attach(var_1, "_encstr_B40101", 1);
    self.headmodel = var_1;
  } else
    self.headmodel = undefined;
}