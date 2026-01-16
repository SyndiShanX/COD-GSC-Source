/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_40556c4400b0a478.gsc
***********************************************/

#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\zm\ai\zm_ai_brutus;
#include scripts\zm_common\zm_devgui;

#namespace namespace_9d28c60;

autoexec __init__system__() {
  system::register(#"hash_2e2fcde8843638d9", &__init__, undefined, undefined);
}

private __init__() {
  spawner::add_archetype_spawn_function(#"brutus", &function_e67297f2);

  function_f2cc1ec();

}

private function_e67297f2() {
  if(self.subarchetype !== #"brutus_special") {
    return;
  }

  self attach("c_t8_zmb_mob_brutus_boss_baton", "tag_weapon_right");
}

private function_f2cc1ec() {
  adddebugcommand("<dev string:x38>");
  adddebugcommand("<dev string:x89>");
  zm_devgui::add_custom_devgui_callback(&function_5162a3de);
}

private function_5162a3de(cmd) {
  switch (cmd) {
    case #"hash_3b5a33d5b7ae4e80":
      spawners = getspawnerarray();

      foreach(spawner in spawners) {
        if(spawner.subarchetype === #"brutus_special" && isDefined(spawner.script_noteworthy)) {
          zm_devgui::spawn_archetype(spawner.script_noteworthy);
          break;
        }
      }

      break;
    case #"hash_2e229b658a79d09f":
      brutuses = getaiarchetypearray(#"brutus");

      foreach(brutus in brutuses) {
        if(brutus.subarchetype === #"brutus_special") {
          brutus kill(undefined, undefined, undefined, undefined, 0, 1);
        }
      }

      break;
    default:
      break;
  }
}

