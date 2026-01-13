/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3960.gsc
************************/

zombie_cop_init() {
  registerscriptedagent();
  if(!isDefined(level.cop_spawn_percent)) {
    level.cop_spawn_percent = 5;
  }

  level.agent_funcs["zombie_cop"]["on_damaged"] = ::scripts\cp\agents\gametype_zombie::onzombiedamaged;
  level.agent_funcs["zombie_cop"]["gametype_on_damage_finished"] = ::scripts\cp\agents\gametype_zombie::onzombiedamagefinished;
  level.agent_funcs["zombie_cop"]["gametype_on_killed"] = ::scripts\cp\agents\gametype_zombie::onzombiekilled;
  level.movemodefunc["zombie_cop"] = ::scripts\cp\agents\gametype_zombie::run_if_last_zombie;
}

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  lib_03B4::func_DEE8();
  lib_0F46::func_2371();
  func_AEB0();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["zombie_cop"]["setup_func"] = ::setupagent;
  level.agent_definition["zombie_cop"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["zombie_cop"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::onzombiedamagefinished;
  level.agent_funcs["zombie_cop"]["on_killed"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::onzombiekilled;
  level.var_1094E["zombie_cop"] = ::func_FF94;
}

setupagent() {
  scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
  self.is_cop = 1;
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
  self setModel("police_officer_zombie");
  thread scripts\mp\agents\zombie\zmb_zombie_agent::func_50EF();
}

func_AEB0() {}

func_FF94() {
  if(level.wave_num >= 20) {
    var_0 = min(level.wave_num - 10, 20);
  } else {
    var_0 = level.cop_spawn_percent;
  }

  var_1 = 5;
  var_2 = "zombie_cop";
  if(getdvarint("scr_force_cop_spawn", 0) == 1) {
    var_1 = 0;
    var_0 = 100;
  }

  if(getdvarint("scr_force_no_cop_spawn", 0) == 1) {
    var_1 = 500;
    var_0 = 0;
  }

  if(level.wave_num > var_1) {
    if(randomint(100) < var_0) {
      return var_2;
    }

    return undefined;
  }

  return undefined;
}