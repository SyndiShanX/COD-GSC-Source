/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_mannequin.gsc
***********************************************/

#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_devgui;

#namespace zm_ai_mannequin;

autoexec __init__system__() {
  system::register(#"zm_ai_mannequin", &__init__, &__main__, undefined);
}

__init__() {
  spawner::add_archetype_spawn_function(#"zombie", &function_c381536b);

  zm_devgui::function_c7dd7a17("<dev string:x38>", "<dev string:x41>");

}

__main__() {}

private function_c381536b() {
  if(isDefined(self.subarchetype) && self.subarchetype == #"mannequin") {
    self.var_80d367d8 = 1;
  }
}