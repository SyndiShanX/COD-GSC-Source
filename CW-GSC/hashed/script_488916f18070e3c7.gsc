/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_488916f18070e3c7.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace namespace_d3c2ca3;

function private autoexec __init__system__() {
  system::register(#"hash_41fdf840d8ce98ad", undefined, &postinit, undefined, undefined);
}

function autoexec postinit() {
  window_triggers = getEntArray("window_trigger", "targetname");
  array::thread_all(window_triggers, &callback::on_trigger, &function_82c985d1);
}

function function_82c985d1(var_1482c45a) {
  if(!isDefined(self.busy)) {
    self.busy = 0;
  }

  if(is_false(self.busy)) {
    level endon(#"game_ended");

    if(!isDefined(self.scene)) {
      self.scene = struct::get(self.target);
    }

    self.busy = 1;
    self.scene scene::play(self.scene.scriptbundlename, "gust");
    self.busy = 0;
  }
}