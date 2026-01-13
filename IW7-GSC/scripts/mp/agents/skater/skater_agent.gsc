/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\skater\skater_agent.gsc
*****************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\zombie_dlc2::func_DEE8();
  scripts\asm\zombie_dlc2\mp\states::func_2371();
  func_AEB0();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_funcs["skater"]["on_damaged"] = ::scripts\cp\maps\cp_disco\cp_disco_damage::cp_disco_onzombiedamaged;
  level.agent_funcs["skater"]["gametype_on_damage_finished"] = ::scripts\cp\agents\gametype_zombie::onzombiedamagefinished;
  level.agent_funcs["skater"]["gametype_on_killed"] = ::scripts\cp\agents\gametype_zombie::onzombiekilled;
  level.movemodefunc["skater"] = ::scripts\cp\agents\gametype_zombie::run_if_last_zombie;
  level.agent_definition["skater"]["setup_func"] = ::setupagent;
  level.agent_definition["skater"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["skater"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::onzombiedamagefinished;
  level.agent_funcs["skater"]["on_killed"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::onzombiekilled;
  if(!isDefined(level.var_8CBD)) {
    level.var_8CBD = [];
  }

  level.var_8CBD["skater"] = ::func_3725;
}

setupagent() {
  scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
  self.entered_playspace = 1;
  self.is_suicide_bomber = 1;
  self.nocorpse = 1;
  self.allowpain = 0;
  if(isDefined(level.suicider_avoidance_radius)) {
    self setavoidanceradius(level.suicider_avoidance_radius);
  }

  thread func_899C();
}

func_899C() {
  self endon("death");
  level waittill("game_ended");
  self clearpath();
  foreach(var_4, var_1 in self.var_164D) {
    var_2 = var_1.var_4BC0;
    var_3 = level.asm[var_4].states[var_2];
    scripts\asm\asm::func_2388(var_4, var_2, var_3, var_3.var_116FB);
    scripts\asm\asm::func_238A(var_4, "idle", 0.2, undefined, undefined, undefined);
  }
}

func_FACE(var_0) {
  self setModel("roller_skater_female_white");
  thread scripts\mp\agents\zombie\zmb_zombie_agent::func_50EF();
}

func_AEB0() {
  level._effect["suicide_zmb_death"] = loadfx("vfx\iw7\_requests\coop\vfx_zmb_blackhole_death");
  level._effect["suicide_zmb_explode"] = loadfx("vfx\iw7\levels\cp_disco\vfx_disco_rollerskate_exp.vfx");
}

func_3725() {
  var_0 = 200;
  switch (level.specialroundcounter) {
    case 0:
      var_0 = 145;
      break;

    case 1:
      var_0 = 400;
      break;

    case 2:
      var_0 = 900;
      break;

    case 3:
      var_0 = 900;
      break;

    default:
      var_0 = 900;
      break;
  }

  return var_0;
}