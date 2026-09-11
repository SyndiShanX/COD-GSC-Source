/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\soldier\soldier_agent.gsc
*******************************************************/

function registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\soldier_agent::registerbehaviortree();
  aiasm\suicidebomber_cp_mp::asm_register();
  scripts\cp_mp\agents\agent_init::agent_init();

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  if(!isDefined(level.species_funcs["human"])) {
    level.species_funcs["human"] = [];
  }

  level.agent_definition["soldier_agent"]["setup_func"] = &setupagent;
  level.agent_definition["soldier_agent"]["setup_model_func"] = &setupmodel;
  scripts\aitypes\assets::soldier();
}

function setupagent() {
  self.animationarchetype = "soldier";
  self.defaultcoverselector = "cover_default";
  self.voice = "unknown";
  self.unittype = "soldier";
  self.grenadeammo = 5;
  self.grenadeweapon = getcompleteweaponname("frag_grenade_mp");
  self setengagementmindist(256, 0);
  self setengagementmaxdist(768, 1024);
  setupsoldieraitype();
}

function setupsoldieraitype() {}

function setupmodel(var_0, var_1) {
  if(self.team == "axis") {
    var_2 = weaponclass(var_1);

    if(isDefined(var_1) && isDefined(level.agentmodeltabledata) && isDefined(level.agentmodeltabledata[var_2])) {
      var_3 = level.agentmodeltabledata[var_2].bodymodel;
      var_4 = level.agentmodeltabledata[var_2].headmodel;
    } else {
      var_3 = "body_opforce_london_terrorist_1_2";
      var_4 = "head_male_bc_03";
    }

    setcharmodels(var_3, var_4);
    return;
  }

  if(self.team == "allies") {
    setcharmodels("body_mp_western_fireteam_west_ar_1_1_lod1", "head_mp_western_fireteam_west_ar_1_1_lod1");
    return;
  }
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