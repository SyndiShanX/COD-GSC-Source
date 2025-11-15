/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_behavior_friendly.gsc
***********************************************/

stealth_behavior_friendly_main() {
  friendly_init();
  var_0 = self._stealth.behavior.ai_functions["state"]["hidden"];
  thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_0, "friendly_behavior");
  var_0 = self._stealth.behavior.ai_functions["state"]["spotted"];
  thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_0, "friendly_behavior");
}

friendly_state_hidden() {
  thread maps\_utility::set_battlechatter(0);
  self._stealth.behavior.oldgrenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  self.forcesidearm = undefined;
  self.ignoreme = 1;
}

friendly_state_spotted() {
  thread maps\_utility::set_battlechatter(1);

  if(isDefined(self._stealth.behavior.oldgrenadeammo))
    self.grenadeammo = self._stealth.behavior.oldgrenadeammo;
  else
    self.grenadeammo = 3;

  self.ignoreme = 0;
  self pushplayer(0);
  maps\_utility::disable_cqbwalk();
  thread friendly_spotted_getup_from_prone();
  self allowedstances("prone", "crouch", "stand");

  if(self.type != "dog" || !isDefined(self.in_melee) || !self.in_melee)
    maps\_utility::anim_stopanimscripted();
}

friendly_spotted_getup_from_prone(var_0) {
  self endon("death");

  if(self._stealth.logic.stance != "prone") {
    return;
  }
  maps\_utility::ent_flag_set("_stealth_custom_anim");
  var_1 = "_stealth_prone_2_run_roll";

  if(isDefined(var_0))
    self orientmode("face angle", var_0[1] + 20);

  thread maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self, "gravity", var_1);
  var_2 = getanimlength(maps\_utility::getanim_generic(var_1));
  wait(var_2 - 0.2);
  self notify("stop_animmode");
  maps\_utility::ent_flag_clear("_stealth_custom_anim");
}

friendly_init() {
  maps\_utility::ent_flag_init("_stealth_custom_anim");
  maps\_utility::ent_flag_init("_stealth_override_goalpos");
  self._stealth.behavior = spawnStruct();
  self._stealth.behavior.ai_functions = [];
  friendly_default_state_behavior();
  self._stealth.plugins = spawnStruct();
  thread maps\_stealth_shared_utilities::ai_stealth_pause_handler();
}

friendly_custom_state_behavior(var_0) {
  foreach(var_3, var_2 in var_0)
  maps\_stealth_shared_utilities::ai_create_behavior_function("state", var_3, var_2);

  var_4 = self._stealth.behavior.ai_functions["state"]["hidden"];
  thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_4, "friendly_behavior");
  var_4 = self._stealth.behavior.ai_functions["state"]["spotted"];
  thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_4, "friendly_behavior");
}

friendly_default_state_behavior() {
  var_0 = [];
  var_0["hidden"] = ::friendly_state_hidden;
  var_0["spotted"] = ::friendly_state_spotted;
  friendly_custom_state_behavior(var_0);
}