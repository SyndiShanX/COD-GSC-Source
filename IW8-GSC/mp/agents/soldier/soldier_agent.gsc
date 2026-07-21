/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\agents\soldier\soldier_agent.gsc
***********************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\soldier_agent::registerbehaviortree();
  aiasm\suicidebomber_cp_mp::asm_register();
  scripts\cp_mp\agents\agent_init::agent_init();

  if(!isDefined(level.species_funcs))
    level.species_funcs = [];

  if(!isDefined(level.species_funcs["_encstr_A9C20643EAB52C9B"]))
    level.species_funcs["_encstr_A9C20643EAB52C9B"] = [];

  level.agent_definition["_encstr_A7E80E1818902B623DBA872BD4C1184C"]["_encstr_A3E30B27A5A3108FCFCA0B50A2"] = ::setupagent;
  level.agent_definition["_encstr_A7E80E1818902B623DBA872BD4C1184C"]["_encstr_A9CE11B9568ED5E0BE5BB72356D8EB66ABDCB1"] = ::setupmodel;
  scripts\aitypes\assets::soldier();
}

setupagent() {
  self.animationarchetype = "_encstr_958C08CDDBD8325A959C";
  self.defaultcoverselector = "_encstr_B23B0E52885CFFF289B1E5EE5330BD63";
  self.voice = "_encstr_8DC7086BEEA408C0AF8A";
  self.unittype = "_encstr_958C08CDDBD8325A959C";
  self.grenadeammo = 5;
  self.grenadeweapon = getcompleteweaponname("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B");
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
  setupsoldieraitype();
}

setupsoldieraitype() {}

setupmodel(var_0, var_1) {
  if(self.team == "_encstr_8E8405EA382B2A") {
    var_2 = weaponclass(var_1);

    if(isDefined(var_1) && isDefined(level.agentmodeltabledata) && isDefined(level.agentmodeltabledata[var_2])) {
      var_3 = level.agentmodeltabledata[var_2].bodymodel;
      var_4 = level.agentmodeltabledata[var_2].headmodel;
    } else {
      var_3 = "_encstr_9BB12213BDC897EBB70733BDC9362B7D1BEDE6237B73FAE8599393F6932DB9E8F589D746";
      var_4 = "_encstr_B1BB1014B72AFA0761C250022FAEB0C8AA0B";
    }

    setcharmodels(var_3, var_4);
  } else if(self.team == "_encstr_9A8507BA4040188D08")
    setcharmodels("_encstr_96F32AA6F70BB21FFDAB49BB921231493B6EA02C598BF9812782C039ABAFF7A33709BE08F9972B8F4D8A8042", "_encstr_92592A8BE397627F701BD9DB51689C8AF61DCF3B43463A2C68014D290BE0C3D3D89BF3679B78A7CF08A807BA");
  else {}
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