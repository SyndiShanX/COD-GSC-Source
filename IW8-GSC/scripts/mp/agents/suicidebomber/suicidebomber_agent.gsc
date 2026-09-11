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

function onkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  destroynavrepulsor(self.repulsorname);
  self.nocorpse = 1;
  scripts\mp\mp_agent::default_on_killed(var0, var1, var2, var3, var4, var5, var6, var7, var8);
}

function setupmodel(var0, var1) {
  if(self.team == "axis") {
    if(isDefined(var1) && isDefined(level.agentmodeltabledata)) {
      var2 = weaponclass(var1);
      var3 = level.agentmodeltabledata[var2].bodymodel;
      var4 = level.agentmodeltabledata[var2].headmodel;
    } else {
      var3 = "body_opforce_london_terrorist_1_bomb_vest";
      var4 = "head_mp_opforce_london_terrorist_1";
    }

    setcharmodels(var3, var4);
    return;
  }

  self setModel("body_zmb_hero_dj_agent");
}

function setcharmodels(var0, var1, var2) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self setModel(var0);

  if(isDefined(var1) && var1 != "") {
    self attach(var1, "", 1);
    self.headmodel = var1;
    return;
  }

  self.headmodel = undefined;
}