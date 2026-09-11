/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\suicidebomber\suicidebomber_agent.gsc
*******************************************************************/

function registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\suicidebomber_agent::registerbehaviortree();
  character\character_cp_al_qatala_desert_ar_tmtyl::asm_register();
  scripts\cp_mp\agents\agent_init::agent_init();

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  if(!isDefined(level.species_funcs["human"])) {
    level.species_funcs["human"] = [];
  }

  level.agent_definition["suicidebomber"]["setup_func"] = &setupagent;
  level.agent_definition["suicidebomber"]["setup_model_func"] = &setupmodel;
  scripts\aitypes\assets::suicidebomber();
}

function setupagent() {
  self.animationarchetype = "suicidebomber";
  self.defaultcoverselector = "cover_default";
  self.voice = "unknown";
  self.unittype = "suicidebomber";
  self.dropweapon = 0;
  self.nocorpse = 1;
  self.repulsorname = "suicideguy " + self getentitynumber();
  createnavrepulsor(self.repulsorname, -1, self, 200, 1, "axis", "allies");
  self setengagementmindist(256, 0);
  self setengagementmaxdist(768, 1024);
}

function onkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  destroynavrepulsor(self.repulsorname);
  self.nocorpse = 1;
  scripts\mp\mp_agent::default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

function setupmodel(var_0, var_1) {
  if(self.team == "axis") {
    if(isDefined(var_1) && isDefined(level.agentmodeltabledata)) {
      var_2 = weaponclass(var_1);
      var_3 = level.agentmodeltabledata[var_2].bodymodel;
      var_4 = level.agentmodeltabledata[var_2].headmodel;
    } else {
      var_3 = "body_opforce_london_terrorist_1_bomb_vest";
      var_4 = "head_mp_opforce_london_terrorist_1";
    }

    setcharmodels(var_3, var_4);
    return;
  }

  self setModel("body_zmb_hero_dj_agent");
}

function setcharmodels(var_0, var_1, var_2) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self setModel(var_0);

  if(isDefined(var_1) && var_1 != "") {
    self attach(var_1, "", 1);
    self.headmodel = var_1;
    return;
  }

  self.headmodel = undefined;
}