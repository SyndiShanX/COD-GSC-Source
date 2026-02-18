/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie_eye_glow.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace zombie_eye_glow;

function private autoexec __init__system__() {
  system::register(#"zombie_eye_glow", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "zombie_eye_glow", 1, 3, "int");
  callback::on_ai_spawned(&on_ai_spawned);
  callback::on_ai_killed(&on_ai_killed);
}

function private postinit() {}

function on_ai_spawned() {
  self endon(#"death");

  if(self.archetype === # "zombie") {
    self thread delayed_zombie_eye_glow();
    callback::function_d8abfc3d(#"head_gibbed", &function_95cae3e3);
  }
}

function on_ai_killed(params) {
  if(self.archetype === # "zombie") {
    self function_95cae3e3();
  }
}

function delayed_zombie_eye_glow(var_64959d6d) {
  self notify("4ce8b1e0390be791");
  self endon("4ce8b1e0390be791");
  self endon(#"death");

  if(is_true(self.in_the_ground) || is_true(self.in_the_ceiling)) {
    while(!isDefined(self.create_eyes)) {
      wait 0.1;
    }
  } else {
    wait 0.5;
  }

  self function_b43f92cd(var_64959d6d);
}

function function_b43f92cd(var_64959d6d = 1) {
  if(!isDefined(self) || !isactor(self)) {
    return;
  }

  if(isDefined(self.var_1f966535)) {
    var_64959d6d = self.var_1f966535;
  } else if(isDefined(level.var_1f966535)) {
    var_64959d6d = level.var_1f966535;
  }

  if(!is_true(self.no_eye_glow) && !is_true(self.is_inert)) {
    self clientfield::set("zombie_eye_glow", var_64959d6d);
  }
}

function function_95cae3e3() {
  if(!isDefined(self) || !isactor(self)) {
    return;
  }

  self clientfield::set("zombie_eye_glow", 0);
}