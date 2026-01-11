/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_accuracy_friendly.gsc
***********************************************/

stealth_accuracy_friendly_main() {
  friendly_init();
  var_0 = self._stealth.behavior.ai_functions["accuracy"]["hidden"];
  thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_0, "accuracy_friendly");
  var_0 = self._stealth.behavior.ai_functions["accuracy"]["spotted"];
  thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_0, "accuracy_friendly");
}

friendly_acc_hidden() {
  self.baseaccuracy = self._stealth.behavior.goodaccuracy;
  self.accuracy = self._stealth.behavior.goodaccuracy;
}

friendly_acc_spotted() {
  self.baseaccuracy = self._stealth.behavior.old_baseaccuracy;
  self.accuracy = self._stealth.behavior.old_accuracy;
}

friendly_init() {
  self._stealth.behavior.goodaccuracy = 50;
  self._stealth.behavior.old_baseaccuracy = self.baseaccuracy;
  self._stealth.behavior.old_accuracy = self.accuracy;
  friendly_default_acc_behavior();
  self._stealth.plugins.accaracy_mod = 1;
}

friendly_custom_acc_behavior(var_0) {
  foreach(var_3, var_2 in var_0) {
    maps\_stealth_shared_utilities::ai_create_behavior_function("accuracy", var_3, var_2);
  }

  var_4 = self._stealth.behavior.ai_functions["accuracy"]["hidden"];
  thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_4, "accuracy_friendly");
  var_4 = self._stealth.behavior.ai_functions["accuracy"]["spotted"];
  thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_4, "accuracy_friendly");
}

friendly_default_acc_behavior() {
  var_0 = [];
  var_0["hidden"] = ::friendly_acc_hidden;
  var_0["spotted"] = ::friendly_acc_spotted;
  friendly_custom_acc_behavior(var_0);
}