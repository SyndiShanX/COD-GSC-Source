/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\slasher\slasher_agent_dlc4.gsc
************************************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  behaviortree\slasher::func_DEE8();
  scripts\asm\slasher_dlc4\mp\states::func_2371();
  scripts\mp\agents\slasher\slasher_tunedata::setuptunedata();
  thread func_FAB0();
}

func_FAB0() {
  scripts\mp\agents\slasher\slasher_agent::func_FAB0();
  level.agent_funcs["slasher"]["on_damaged"] = ::onslasherdamaged;
  level.agent_funcs["slasher"]["on_killed"] = ::onslasherkilled;
  level.agent_definition["slasher"]["setup_func"] = ::setup_slasher_dlc4_agent;
  if(!isDefined(level.damage_feedback_overrride)) {
    level.damage_feedback_overrride = [];
  }

  level.damage_feedback_overrride["slasher"] = scripts\cp\maps\cp_final\cp_final_damage::slasher_processdamagefeedback;
  if(!isDefined(level.var_8CBD)) {
    level.var_8CBD = [];
  }

  level.var_8CBD["slasher"] = ::calculateslasherhealth;
}

setup_slasher_dlc4_agent() {
  scripts\mp\agents\slasher\slasher_agent::setupagent();
  self.spawn_round_num = level.wave_num;
  self.not_affected_by_traps = 1;
}

calculateslasherhealth() {
  return 30000;
}

onslasherdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = var_2;
  var_2 = min(var_2, 300);
  if(isDefined(self.nodamagescale)) {
    var_2 = var_0C;
  }

  scripts\cp\maps\cp_final\cp_final_damage::cp_final_onzombiedamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
}

onslasherkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self detach("weapon_zmb_slasher_vm", "tag_weapon_right");
  self.nocorpse = 1;
  if(isDefined(level.slasher_loot_func)) {
    self[[level.slasher_loot_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  var_9 = 1000;
  foreach(var_0B in level.players) {
    if(var_0B scripts\cp\utility::is_valid_player()) {
      var_0B scripts\cp\cp_persistence::give_player_currency(var_9);
    }
  }

  scripts\mp\mp_agent::default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}