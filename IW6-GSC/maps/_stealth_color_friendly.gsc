/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_color_friendly.gsc
********************************************/

stealth_color_friendly_main() {
  friendly_init();
  var_0 = self._stealth.behavior.ai_functions["color"]["hidden"];
  thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_0, "color_friendly");
  var_0 = self._stealth.behavior.ai_functions["color"]["spotted"];
  thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_0, "color_friendly");
}

friendly_color_hidden() {
  maps\_utility::disable_ai_color();
  self.fixednode = 0;
}

friendly_color_spotted() {
  maps\_utility::enable_ai_color();
}

friendly_init() {
  friendly_default_color_behavior();
  self._stealth.plugins.color_system = 1;
}

friendly_custom_color_behavior(var_0) {
  foreach(var_3, var_2 in var_0) {
    maps\_stealth_shared_utilities::ai_create_behavior_function("color", var_3, var_2);
  }

  var_4 = self._stealth.behavior.ai_functions["color"]["hidden"];
  thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_4, "color_friendly");
  var_4 = self._stealth.behavior.ai_functions["color"]["spotted"];
  thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_4, "color_friendly");
}

friendly_default_color_behavior() {
  var_0 = [];
  var_0["hidden"] = ::friendly_color_hidden;
  var_0["spotted"] = ::friendly_color_spotted;
  friendly_custom_color_behavior(var_0);
}