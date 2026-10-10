/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_503dc616192c6c7b.gsc
*************************************************/

#using script_61afae50a53c3917;
#using script_7b13d902fe77425;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;
#namespace namespace_9349b4e74d680d99;

function init() {
  callback::add("on_ai_killed", &function_e5ea18b76842725f);
  scripts\engine\utility::registersharedfunc("relics", "check_ai_disguise_execution", &function_a214770b3d91c9c5);
  scripts\engine\utility::registersharedfunc("disguise", "should_finish_execution_first", &should_finish_execution_first);
}

function private function_e5ea18b76842725f(sparams) {
  if(isDefined(self.var_6e8703546e2c7067) && isDefined(self) && isDefined(sparams.eattacker) && isDefined(sparams.smeansofdeath) && isDefined(sparams) && isDefined(self.var_75e4bf6d72a3df01) && isPlayer(sparams.eattacker) && sparams.smeansofdeath == "MOD_EXECUTION" && self.var_6e8703546e2c7067 == sparams.eattacker && gettime() - self.var_75e4bf6d72a3df01 < 3000) {
    thread function_4274f780d2a511f9(sparams.eattacker, self.origin);
  }
}

function private function_4274f780d2a511f9(var_fb7680c7bee58bb9, var_8232fe13bffb624) {
  level endon("game_ended");
  var_fb7680c7bee58bb9 endon("death");
  wait 2;

  if(isDefined(var_fb7680c7bee58bb9) && !namespace_c8baf39126f1ef99::function_d737da36e4f0f6c2(var_fb7680c7bee58bb9, "ob_jup_item_reward_giraffe_s5")) {
    namespace_c8baf39126f1ef99::function_65e52fad2bce952c(var_fb7680c7bee58bb9, "ob_jup_item_reward_giraffe_s5", var_8232fe13bffb624, 1);
    wait 2;
    thread scripts\cp_mp\overlord::playconversation("RFT_S5_5_RGUQ_Relic_Drop_Giraffe", [var_fb7680c7bee58bb9]);
  }
}

function function_a214770b3d91c9c5(attacker) {
  if(isDefined(attacker) && isDefined(self) && isPlayer(attacker) && namespace_362d05f5d79f98cd::function_eaee8a3e6cdeefcf(attacker) && namespace_c8baf39126f1ef99::function_d737da36e4f0f6c2(attacker, "ob_jup_item_reward_giraffe_s5") == 0 && istrue(attacker.var_8a13c2b607afaae7) && attacker isinexecutionattack() && self isinexecutionvictim()) {
    self.var_75e4bf6d72a3df01 = gettime();
    self.var_6e8703546e2c7067 = attacker;
  }
}

function should_finish_execution_first() {
  return true;
}