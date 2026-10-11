/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4d09faa32d8aa068.gsc
*************************************************/

#using script_595089f78ef8e11b;
#using scripts\asm\asm_bb;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_5b42435b9c80a670;

function function_70332948ed09c6b1() {
  if(flag("deathworm_audio")) {
    return;
  }

  flag_set("deathworm_audio");
  function_d571b479e74c1c29("vox_ai_deathworm_headbanger_bite", "vox_ai_deathworm_headbanger_bite", 5);
  function_d571b479e74c1c29("vox_ai_deathworm_pain", "vox_ai_deathworm_pain", 4.6, 1);
  function_d571b479e74c1c29("vox_ai_deathworm_beam", "vox_ai_deathworm_beam", 6);
  function_d571b479e74c1c29("vox_ai_deathworm_beam_outro", "vox_ai_deathworm_beam_outro", 3.5);
  function_d571b479e74c1c29("vox_ai_deathworm_death", "vox_ai_deathworm_death", 5, 1);
  function_d571b479e74c1c29("vox_ai_deathworm_tunnel", "vox_ai_deathworm_tunnel", 3.6);
  function_d571b479e74c1c29("vox_ai_deathworm_spittle", "vox_ai_deathworm_spittle", 5.8);
  function_d571b479e74c1c29("vox_ai_deathworm_spawner", "vox_ai_deathworm_spawner", 7.6);
  function_d571b479e74c1c29("vox_ai_deathworm_idle", "vox_ai_deathworm_idle", 4.5);
  function_d571b479e74c1c29("vox_ai_deathworm_idle_pre", "vox_ai_deathworm_idle_pre", 2);
  function_d571b479e74c1c29("vox_ai_deathworm_roar_short", "vox_ai_deathworm_roar_short", 3.4);
  function_d571b479e74c1c29("vox_ai_deathworm_headbanger_roar", "vox_ai_deathworm_headbanger_roar", 3.4);
  function_d571b479e74c1c29("vox_ai_deathworm_bite", "vox_ai_deathworm_bite", 9.7);
  function_d571b479e74c1c29("vox_ai_deathworm_bite_fast", "vox_ai_deathworm_bite_fast", 5);
  function_d571b479e74c1c29("vox_ai_deathworm_emerge", "vox_ai_deathworm_emerge", 5.1);
  function_d571b479e74c1c29("vox_ai_deathworm_bite_short", "vox_ai_deathworm_bite_short", 3);
  function_d571b479e74c1c29("vox_ai_deathworm_bite_long", "vox_ai_deathworm_bite_long", 4);
  function_d571b479e74c1c29("vox_ai_deathworm_shark_bite", "vox_ai_deathworm_shark_bite", 4.6);
}

function function_54f789069ca4eded() {
  self.var_82420c8df7f30a5b = &function_c5e2196bf3620c86;
  self.var_daecc3775e583764 = [];
}

function private function_c5e2196bf3620c86(event) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(level.var_d9c60d7c8f3041f)) {
    return;
  }

  var_42db284ef44b45b = level.var_d9c60d7c8f3041f[event];

  if(!isDefined(var_42db284ef44b45b)) {
    return;
  }

  scriptable_part = var_42db284ef44b45b.scriptable_part;
  playbacktime = var_42db284ef44b45b.playbacktime;
  var_2e0a313d03359b86 = var_42db284ef44b45b.var_2e0a313d03359b86;
  thread function_54cfa98e93367c03(scriptable_part, playbacktime, var_2e0a313d03359b86);
}

function function_54cfa98e93367c03(scriptable_part, playbacktime, var_2e0a313d03359b86) {
  self endon("death");

  if(self isscriptable()) {
    if(self getscriptablepartstate("base") == "off") {
      return;
    }

    if(istrue(var_2e0a313d03359b86)) {
      if(self getscriptablehaspart(scriptable_part)) {
        self setscriptablepartstate(scriptable_part, "on");
        self.var_daecc3775e583764[self.var_daecc3775e583764.size] = scriptable_part;
        thread function_79c65ef98ad52fab(playbacktime, scriptable_part);
      }

      foreach(vox in self.var_daecc3775e583764) {
        if(vox != scriptable_part) {
          self notify("stop" + vox);
          function_ecda43fa32d7ef19(vox);
          waitframe();
        }
      }

      return;
    } else if(self.var_daecc3775e583764.size > 1) {
      foreach(vox in self.var_daecc3775e583764) {
        if(vox == scriptable_part) {
          self notify("stop" + scriptable_part);
          function_ecda43fa32d7ef19(scriptable_part);
          waitframe();
        }
      }
    }

    if(self getscriptablehaspart(scriptable_part) && self getscriptablepartstate(scriptable_part) != "on") {
      utility::function_3ab9164ef76940fd(scriptable_part, "on");
      self.var_daecc3775e583764[self.var_daecc3775e583764.size] = scriptable_part;
      thread function_79c65ef98ad52fab(playbacktime, scriptable_part);
    }
  }
}

function function_79c65ef98ad52fab(playbacktime, scriptable_part) {
  self endon("death");
  self endon("interruptVO");
  self endon("stop" + scriptable_part);
  wait playbacktime;
  function_ecda43fa32d7ef19(scriptable_part);
}

function function_ecda43fa32d7ef19(scriptable_part) {
  if(self isscriptable()) {
    if(self getscriptablehaspart(scriptable_part) && self getscriptablepartstate(scriptable_part) != "off") {
      utility::function_3ab9164ef76940fd(scriptable_part, "off");
      self.var_daecc3775e583764 = array_remove(self.var_daecc3775e583764, scriptable_part);
    }
  }
}

function function_d571b479e74c1c29(event, scriptable_part, playbacktime, var_2e0a313d03359b86) {
  level.var_d9c60d7c8f3041f = default_to(level.var_d9c60d7c8f3041f, []);
  state = spawnStruct();
  state.scriptable_part = scriptable_part;
  state.playbacktime = playbacktime;
  state.var_2e0a313d03359b86 = default_to(var_2e0a313d03359b86, 0);
  level.var_d9c60d7c8f3041f[event] = state;
}