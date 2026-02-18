/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\flashlight.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace flashlight;

function private autoexec __init__system__() {
  system::register(#"flashlight", &function_f64316de, undefined, undefined, undefined);
}

function function_9b7441d1(flashlight_out = 0) {
  if(!isDefined(self.flashlight)) {
    self.flashlight = {};
  }

  var_5e61cb7e = self getblackboardattribute("_flashlight");

  if(is_true(flashlight_out) && var_5e61cb7e !== "flashlight_out" || !is_true(flashlight_out) && var_5e61cb7e !== "flashlight_stow") {
    self.flashlight.transition = 1;
    self thread function_1ad12840();
  } else if(is_true(self.flashlight.transition)) {
    self.flashlight.transition = undefined;
  }

  self.flashlight.out = flashlight_out;
  function_ac53d0fb();
}

function function_8d59ee47(flashlight_out = 0) {
  if(flashlight_out) {
    if(function_b8090745()) {
      self thread function_1ad12840("detach", &function_229440d2);
    } else {
      function_229440d2();
    }
  } else {
    function_ac53d0fb();
  }

  self.flashlight.out = flashlight_out;
}

function function_b8090745() {
  if(self getblackboardattribute("_flashlight") === "flashlight_out") {
    return true;
  }

  return false;
}

function function_7b72a4ab(flashlightmodel, var_f8962b6d) {
  if(!isDefined(self.flashlight)) {
    self.flashlight = {};
  }

  self.flashlight.modeloverride = flashlightmodel;
  self.flashlight.var_69749c1 = isDefined(var_f8962b6d) ? var_f8962b6d : flashlightmodel;
}

function function_3ed8613f() {
  modelname = "com_flashlight_on_xforward_no_tag_weapon";

  if(isDefined(self.flashlight.modeloverride)) {
    modelname = self.flashlight.modeloverride;
  } else if(isDefined(level.flashlight.modeloverride)) {
    modelname = level.flashlight.modeloverride;
  }

  return modelname;
}

function function_54c2c072() {
  modelname = "com_flashlight_on_xforward_no_tag_weapon_off";

  if(isDefined(self.flashlight.var_69749c1)) {
    modelname = self.flashlight.var_69749c1;
  } else if(isDefined(level.flashlight.var_69749c1)) {
    modelname = level.flashlight.var_69749c1;
  }

  return modelname;
}

function function_32fb7a97(var_704fb596 = "tag_accessory_left") {
  if(!isDefined(self.flashlight)) {
    self.flashlight = {};
  }

  self.flashlight.tagoverride = var_704fb596;
}

function function_e77dc163() {
  tag = "tag_accessory_left";

  if(isDefined(self.flashlight.tagoverride)) {
    tag = self.flashlight.tagoverride;
  } else if(isDefined(level.flashlight.tagoverride)) {
    tag = level.flashlight.tagoverride;
  }

  return tag;
}

function function_65e5c8c8(var_45c9e542) {
  if(!isDefined(self.flashlight)) {
    self.flashlight = {};
  }

  if(isDefined(self.flashlight.model)) {
    return;
  }

  modelname = self function_3ed8613f();
  tag = self function_e77dc163();
  self attach(modelname, tag, 1);
  self.flashlight.model = modelname;
  self.flashlight.tag = tag;

  if(is_true(var_45c9e542) && isDefined(self.fnstealthflashlighton)) {
    self[[self.fnstealthflashlighton]]();
  }

  self thread function_4e897ec7();
}

function function_bfffb3fe() {
  if(!isDefined(self.flashlight.model)) {
    return;
  }

  if(isDefined(self.fnstealthflashlightoff)) {
    self[[self.fnstealthflashlightoff]]();
  }

  if(isDefined(self.flashlight.model) && isDefined(self.flashlight.tag)) {
    self detach(self.flashlight.model, self.flashlight.tag);
  }

  self.flashlight.model = undefined;
  self.flashlight.tag = undefined;
  self notify(#"hash_41c8d256b3d76cf");
}

function function_7db73593() {
  model = function_54c2c072();
  tag = self.flashlight.tag;
  self function_bfffb3fe();

  if(isDefined(model) && isDefined(tag)) {
    origin = self gettagorigin(tag);
    angles = self gettagangles(tag);

    if(isDefined(origin) && isDefined(angles)) {
      ent = spawn("script_model", origin);

      if(isDefined(ent)) {
        ent endon(#"death");
        ent setModel(model);
        ent.angles = angles;
        ent physicslaunch();
        ent clientfield::set("flashlightfx", 1);

        if(is_true(self.in_melee_death)) {
          wait randomfloatrange(3, 4);
        }

        wait randomfloatrange(0.1, 0.3);
        ent clientfield::set("flashlightfx", 2);
      }
    }
  }
}

function function_7c2f623b() {
  if(!isDefined(self.flashlight.model)) {
    self function_65e5c8c8(1);
  }

  if(!isDefined(self.flashlight.model)) {
    return;
  }

  if(is_true(self.flashlight.on)) {
    return;
  }

  self.flashlight.on = 1;
  self setblackboardattribute("_flashlight", "flashlight_out");
  self clientfield::set("flashlightfx", 1);
}

function function_229440d2(forced = 0, fxtag) {
  if(!isDefined(self.flashlight)) {
    self.flashlight = {};
  }

  if(!forced) {
    if(isDefined(self.flashlight.model)) {
      return;
    }

    if(!is_true(self.flashlight.out)) {
      return;
    }

    if(is_true(self.flashlight.on)) {
      return;
    }
  }

  self.flashlight.on = 1;
  self.flashlight.var_229440d2 = 1;
  self.flashlight.tag = isDefined(fxtag) ? fxtag : "tag_muzzle";
  self clientfield::set("gunflashlightfx", 1);
}

function function_47df32b8() {
  return is_true(self.flashlight.on);
}

function function_ac53d0fb() {
  if(!isDefined(self.flashlight)) {
    self.flashlight = {};
  }

  if(isDefined(self.flashlight.model)) {
    return;
  }

  if(!is_true(self.flashlight.on)) {
    return;
  }

  self.flashlight.on = undefined;
  self.flashlight.tag = undefined;
  self.flashlight.var_229440d2 = undefined;
  self clientfield::set("gunflashlightfx", 0);
  self setblackboardattribute("_flashlight", "flashlight_stow");
}

function function_3aec1b7() {
  return is_true(self.flashlight.var_229440d2);
}

function light_off() {
  if(!isDefined(self.flashlight.model)) {
    return;
  }

  if(!is_true(self.flashlight.on)) {
    return;
  }

  self.flashlight.on = undefined;
  self clientfield::set("flashlightfx", 0);
}

function function_51dea76e(othersentient) {
  entnum = self getentitynumber();
  range_sq = sqr(isDefined(self.var_1c936867) ? self.var_1c936867 : 850);
  cosfov = 0.866;

  if(is_true(self.flashlight.on)) {
    var_78601034 = othersentient getEye();
    flash_origin = self gettagorigin(self.flashlight.tag);
    flash_angles = self gettagangles(self.flashlight.tag);

    if(isDefined(flash_origin) && isDefined(flash_angles) && distancesquared(flash_origin, var_78601034) < range_sq) {
      if(self util::function_aae7d83d(flash_origin, flash_angles, var_78601034, cosfov)) {
        if(sighttracepassed(flash_origin + anglesToForward(flash_angles) * 20, var_78601034, 0, othersentient)) {
          return true;
        }
      }
    }
  }

  return false;
}

function private function_f64316de() {
  function_bc948200();
  level.var_ab828d57 = &function_7db73593;
  callback::on_ai_spawned(&function_fb6fb7ad);
}

function private function_bc948200() {
  clientfield::register("actor", "flashlightfx", 1, 1, "int");
  clientfield::register("scriptmover", "flashlightfx", 1, 2, "int");
  clientfield::register("actor", "gunflashlightfx", 1, 1, "int");
}

function private function_fb6fb7ad() {
  if(self.species !== "human") {
    return;
  }

  self.var_710f0e6e = &function_65e5c8c8;
  self.fnstealthflashlightdetach = &function_bfffb3fe;
  self.fnstealthflashlighton = &function_7c2f623b;
  self.fnstealthflashlightoff = &light_off;
  self setblackboardattribute("_flashlight", "flashlight_stow");
}

function private function_4e897ec7() {
  self notify("18d939c31eb079a4");
  self endon("18d939c31eb079a4");
  self endon(#"hash_41c8d256b3d76cf", #"entitydeleted");
  self waittill(#"death");
  waittillframeend();

  if(isDefined(self)) {
    self thread function_7db73593();
  }
}

function function_1ad12840(var_baa290f1, var_affc8431) {
  self notify("a4eb5bb1979f8c");
  self endon("a4eb5bb1979f8c");
  self endon(#"death", #"entitydeleted", #"hash_335827d811ed5f67");
  result = self waittilltimeout(5, #"attach", #"detach");

  if(result._notify === "attach") {
    self function_65e5c8c8(1);
  } else if(result._notify === "detach") {
    self function_bfffb3fe();
  }

  if(result._notify === var_baa290f1) {
    self[[var_affc8431]]();
  }
}