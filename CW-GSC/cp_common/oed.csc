/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\oed.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#namespace oed;

function private autoexec __init__system__() {
  system::register(#"oed", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "sitrep_toggle", 1, 1, "int", &function_8305981d, 0, 0);
  clientfield::register("toplayer", "active_dni_fx", 1, 1, "counter", &function_81c8f4da, 0, 0);
  clientfield::register("toplayer", "hack_dni_fx", 1, 1, "counter", &hack_dni_fx, 0, 0);
  clientfield::register("actor", "sitrep_material", 1, 1, "int", &function_fb942d18, 0, 0);
  clientfield::register("vehicle", "sitrep_material", 1, 1, "int", &function_fb942d18, 0, 0);
  clientfield::register("scriptmover", "sitrep_material", 1, 1, "int", &function_fb942d18, 0, 0);
  clientfield::register("item", "sitrep_material", 1, 1, "int", &function_fb942d18, 0, 0);
  clientfield::register("vehicle", "turret_keyline_render", 1, 1, "int", &function_c2b3ec13, 0, 0);
  clientfield::register("vehicle", "vehicle_keyline_toggle", 1, 1, "int", &vehicle_keyline_toggle, 0, 0);
  callback::on_spawned(&on_player_spawned);
  callback::on_localclient_shutdown(&on_localplayer_shutdown);
}

function on_player_spawned(localclientnum) {
  var_1d3b43d0 = 10500;
  var_9abc8c03 = 3000;

  if(isDefined(level.var_8df232be)) {
    var_1d3b43d0 = level.var_8df232be;
  }

  if(isDefined(level.var_9f5b2c84)) {
    var_9abc8c03 = level.var_9f5b2c84;
  }

  self thread function_66d9f518(localclientnum);
}

function on_localplayer_shutdown(localclientnum) {}

function function_81c8f4da(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread postfx::playpostfxbundle(#"hash_2ffa41d555c1e46e");
}

function hack_dni_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread postfx::playpostfxbundle(#"hash_28506c424004a886");
  self playSound(0, #"hash_3afb4f0542190053");
}

function function_8305981d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self function_21c0fa55()) {
    return;
  }

  if(!isDefined(self.localclientnum)) {
    return;
  }

  if(self.localclientnum != fieldname) {
    return;
  }

  self thread function_182c5d6b(fieldname, bwastimejump);
}

function function_182c5d6b(lcn, newval) {
  self.var_bef05351 = newval;
  level notify(#"player_sitrep_toggle");
}

function function_fb942d18(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  assert(isDefined(self), "<dev string:x38>");

  if(bwastimejump == 1) {
    self thread function_88883a8f(fieldname);
    return;
  }

  self notify(#"keyline_disabled");
  self function_e4f63ce7(fieldname);
}

function private function_88883a8f(localclientnum) {
  self endon(#"keyline_disabled");

  if(function_73f4b33(localclientnum) === self.team || self.team === # "none" || self.script_team === # "any") {
    self function_67243557(localclientnum);

    if(isDefined(self)) {
      self thread function_f8588df3(localclientnum, &function_67243557, &function_e4f63ce7);
      self waittill(#"death");

      if(isDefined(self)) {
        self function_e4f63ce7(localclientnum);
      }
    }
  }
}

function private function_67243557(localclientnum) {
  self endon(#"death", #"keyline_disabled");

  while(is_true(isigcactive(localclientnum))) {
    waitframe(1);
  }

  self playrenderoverridebundle(#"hash_44a7b967f9f18d4f");
}

function private function_e4f63ce7(localclientnum) {
  if(isDefined(self)) {
    self stoprenderoverridebundle(#"hash_44a7b967f9f18d4f");
  }
}

function function_f8588df3(localclientnum, var_80583f56, var_1ca727c) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death", #"disconnect", #"keyline_disabled");
  e_player = function_5c10bd79(localclientnum);
  self.var_cc9b9440 = 1;

  while(true) {
    waitresult = level waittill(#"igc_activated", #"player_sitrep_toggle");

    if(isigcactive(localclientnum)) {
      if(self.var_cc9b9440) {
        self[[var_1ca727c]](localclientnum);
        self.var_cc9b9440 = 0;
      }

      continue;
    }

    if(isDefined(e_player)) {
      if(waitresult._notify == "igc_activated" && is_true(e_player.var_bef05351)) {
        if(!waitresult.b_active && !self.var_cc9b9440) {
          self[[var_80583f56]](localclientnum);
          self.var_cc9b9440 = 1;
        }

        continue;
      }

      if(waitresult._notify == "player_sitrep_toggle" && is_true(e_player.var_bef05351)) {
        if(!self.var_cc9b9440) {
          self[[var_80583f56]](localclientnum);
          self.var_cc9b9440 = 1;
        }

        continue;
      }

      if(!is_true(e_player.var_bef05351)) {
        if(self.var_cc9b9440) {
          self[[var_1ca727c]](localclientnum);
          self.var_cc9b9440 = 0;
        }
      }
    }
  }
}

function function_66d9f518(localclientnum) {
  self endon(#"disconnect");

  if(function_73f4b33(localclientnum) != self.team) {
    return;
  }

  self function_a47e049d(localclientnum);

  if(isDefined(self)) {
    self thread function_f8588df3(localclientnum, &function_a47e049d, &function_ac5dfb21);
    self waittill(#"death", #"keyline_disabled");

    if(isDefined(self)) {
      self function_ac5dfb21(localclientnum);
    }
  }
}

function private function_a47e049d(localclientnum) {
  self endon(#"death", #"disconnect");
  localclient = function_5c10bd79(localclientnum);

  if(self.team == function_73f4b33(localclientnum) && localclient != self && !is_true(self.var_d676dcaa)) {
    while(is_true(isigcactive(localclientnum))) {
      waitframe(1);
    }

    self playrenderoverridebundle(#"hash_1cbf6d26721c59a7");
  }
}

function private function_ac5dfb21(localclientnum) {
  localclient = function_5c10bd79(localclientnum);

  if(isDefined(self) && localclient != self) {
    self stoprenderoverridebundle(#"hash_1cbf6d26721c59a7");
  }
}

function function_c2b3ec13(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump && self.team == function_73f4b33(fieldname)) {
    self thread function_66d9f518(fieldname);
    return;
  }

  self notify(#"keyline_disabled");
}

function vehicle_keyline_toggle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_player = function_5c10bd79(fieldname);
  e_player endon(#"death", #"disconnect");
  self endon(#"death");
  waitframe(1);
  var_80730518 = getplayervehicle(e_player);

  if(bwastimejump == 1) {
    foreach(var_ac85c33a in getplayers(fieldname)) {
      if(isbot(var_ac85c33a) && var_ac85c33a.owner === e_player && var_80730518 === self && (self.archetype === "fighter" || self.scriptvehicletype === "player_fav")) {
        var_ac85c33a thread function_39273849(1);
      }
    }

    if(self !== var_80730518 && self.team === function_73f4b33(fieldname)) {
      self thread function_66d9f518(fieldname);
    }

    return;
  }

  foreach(var_ac85c33a in getplayers(fieldname)) {
    if(isbot(var_ac85c33a) && var_ac85c33a.owner === e_player && !isDefined(var_80730518)) {
      var_ac85c33a thread function_39273849(0);
    }
  }

  self notify(#"keyline_disabled");
  self.var_4e2bc5fc = undefined;
}

function function_39273849(b_disabled) {
  self notify(#"render_override");
  self endon(#"death", #"render_override");

  while(is_true(self.owner.var_4e2bc5fc)) {
    wait 0.2;
  }

  if(b_disabled) {
    self stoprenderoverridebundle(#"hash_1cbf6d26721c59a7");
    self.var_d676dcaa = 1;
    return;
  }

  self playrenderoverridebundle(#"hash_1cbf6d26721c59a7");
  self.var_d676dcaa = undefined;
}