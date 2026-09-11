/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\agents\soldier_agent_spec.gsc
****************************************************/

function soldier_agent_specialize_init() {
  level.soldier_specialization = 1;
  level.soldier_agent_specialize_func["suicidebomber"] = &blank;
  level.soldier_agent_specialize_func["juggernaut"] = &setup_jugg;
  level.soldier_agent_specialize_func["armored"] = &setup_armored;
  level.soldier_agent_specialize_func["armored_helmet"] = &setup_armored_helmet;
  level.soldier_agent_specialize_func["none"] = &blank;
  level.soldier_agent_specialize_func["soldier"] = &blank;
  level.soldier_agent_specialize_func["sniper"] = &blank;
  level.soldier_agent_specialize_func["shotgun"] = &blank;
  level.soldier_agent_specialize_func["ar"] = &blank;
  level.soldier_agent_specialize_func["lmg"] = &blank;
  level.soldier_agent_specialize_func["smg"] = &blank;
  level.soldier_agent_specialize_func["rpg"] = &blank;
  loadvfx();
}

function loadvfx() {}

function blank() {}

function setup_jugg() {
  var_0 = "body_opforce_juggernaut";
  var_1 = undefined;
  setcharmodels(var_0, var_1);
  self.maxhealth = 2500;
  self.health = 2500;
  self.spec = "juggernaut";
  self.wearing_helmet = 1;
  self.allowpain = 0;
  self.walkdist = 3000;
  self.cautiousnavigation = 1;
  self.runcooldown = 30000;
  self.goalradius = 256;
}

function give_shoulder_launchers() {
  var_0 = self gettagorigin("tag_reflector_arm_ri");
  var_1 = spawn("script_model", var_0);
  var_2 = self gettagorigin("tag_reflector_arm_le");
  var_3 = spawn("script_model", var_2);
  thread delete_launchers_on_death(var_1, var_3);
}

function delete_launchers_on_death(var_0, var_1) {
  var_0 setModel("attachment_wm_ub_mike203");
  var_1 setModel("attachment_wm_ub_mike203");
  var_0 linkTo(self, "tag_reflector_arm_ri", (0, 0, 0), (270, 0, 0));
  var_1 linkTo(self, "tag_reflector_arm_le", (0, 0, 0), (270, 0, 0));
  self waittill("death");
  var_0 delete();
  var_1 delete();
}

function setup_armored() {
  var_0 = "body_sa_militia_ar_cp";
  var_1 = "head_al_qatala_2_ar";
  setcharmodels(var_0, var_1);
  self.spec = "armored";
}

function setup_armored_helmet() {
  var_0 = "body_sa_militia_ar_cp";
  var_1 = "head_mp_eastern_fireteam_east_ar_1";
  setcharmodels(var_0, var_1);
  self.spec = "armored_helmet";
  self.wearing_helmet = 1;
}

function setcharmodels(var_0, var_1, var_2) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self setModel(var_0);

  if(isDefined(var_1)) {
    self attach(var_1, "", 1);
    self.headmodel = var_1;
    return;
  }
}