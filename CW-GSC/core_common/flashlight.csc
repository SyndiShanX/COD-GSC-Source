/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\flashlight.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace flashlight;

function private autoexec __init__system__() {
  system::register(#"flashlight", &preinit, undefined, undefined, undefined);
}

function function_69258685(localclientnum, flashlightfx = "light/fx9_light_cp_flashlight", flashlightfxtag = "tag_light") {
  if(!isDefined(self.flashlight)) {
    self.flashlight = {};
  }

  var_5a528883 = self.flashlight.fx !== flashlightfx;
  var_f49dadc4 = self.flashlight.fxtag !== flashlightfxtag;
  var_5a9e0eeb = var_5a528883 && flashlightfx !== "light/fx9_light_cp_flashlight" ? flashlightfx : undefined;
  var_9acb6f5e = var_f49dadc4 && flashlightfxtag !== "tag_light" ? flashlightfxtag : undefined;

  if(!isDefined(self.flashlight) && (isDefined(var_5a9e0eeb) || isDefined(var_9acb6f5e))) {
    self.flashlight = {};
  }

  self.flashlight.fx = var_5a9e0eeb;
  self.flashlight.fxtag = var_9acb6f5e;

  if(self == level) {
    level notify(#"hash_3832e59879eaf7fd");
    return;
  }

  flashlight_on = isDefined(self.flashlight.fxid);

  if(flashlight_on && (var_5a528883 || var_f49dadc4)) {
    self function_24a560cf(localclientnum);
    self function_69fc092e(localclientnum);
  }
}

function function_663e512c(fxtag) {
  self.flashlight.var_787d46f2 = fxtag;
}

function private preinit() {
  register_clientfields();
}

function private register_clientfields() {
  clientfield::register("actor", "flashlightfx", 1, 1, "int", &function_7e507d3c, 0, 0);
  clientfield::register("scriptmover", "flashlightfx", 1, 2, "int", &function_8cd382e7, 0, 0);
  clientfield::register("actor", "gunflashlightfx", 1, 1, "int", &function_db7bbe6c, 0, 0);
}

function private function_db7bbe6c(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  flashlight_on = self clientfield::get("gunflashlightfx");
  var_787d46f2 = "tag_muzzle";

  if(isDefined(self.flashlight.var_787d46f2)) {
    var_787d46f2 = self.flashlight.var_787d46f2;
  }

  if(flashlight_on) {
    function_69258685(wasdemojump, "light/fx9_light_cp_flashlight", var_787d46f2);
  }

  function_2573297e(wasdemojump, flashlight_on);

  if(!flashlight_on) {
    function_69258685(wasdemojump, "light/fx9_light_cp_flashlight", "tag_light");
  }
}

function private function_7e507d3c(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  flashlight_on = self clientfield::get("flashlightfx");
  function_2573297e(wasdemojump, flashlight_on);
}

function private function_2573297e(localclientnum, flashlight_on) {
  if(flashlight_on == 1) {
    var_17716e4f = isDefined(self.flashlight.fxid);

    if(var_17716e4f && !isfxplaying(localclientnum, self.flashlight.fxid)) {
      self function_24a560cf(localclientnum);
    }

    if(!isDefined(self.flashlight.fxid)) {
      self function_69fc092e(localclientnum);
    }

    return;
  }

  if(flashlight_on == 0 && isDefined(self.flashlight.fxid)) {
    self function_24a560cf(localclientnum);
  }
}

function private function_8cd382e7(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump == 1) {
    self notify(#"hash_6f398d21a29fce31");
    self function_a530c545(fieldname, 1);
    return;
  }

  if(wasdemojump == 0) {
    self notify(#"hash_6f398d21a29fce31");
    self function_a530c545(fieldname, 0);
    return;
  }

  if(wasdemojump == 2) {
    self thread function_2b580006(fieldname);
  }
}

function private function_a530c545(localclientnum, on) {
  if(is_true(on)) {
    if(!isDefined(self.var_103f6c4c)) {
      fx = isDefined(level.flashlight.fx) ? level.flashlight.fx : "light/fx9_light_cp_flashlight";
      self.var_103f6c4c = util::playFXOnTag(localclientnum, fx, self, "tag_light");
    }

    return;
  }

  if(isDefined(self.var_103f6c4c)) {
    killfx(localclientnum, self.var_103f6c4c);
    self.var_103f6c4c = undefined;
  }
}

function private function_2b580006(localclientnum) {
  self notify(#"hash_6f398d21a29fce31");
  self endon(#"hash_6f398d21a29fce31", #"death");
  self function_a530c545(localclientnum, 0);
  wait randomfloatrange(0.2, 0.3);
  self function_a530c545(localclientnum, 1);
  wait randomfloatrange(0.2, 0.4);
  self function_a530c545(localclientnum, 0);
  wait randomfloatrange(0.2, 0.3);
  self function_a530c545(localclientnum, 1);
  wait randomfloatrange(0.2, 0.3);
  self function_a530c545(localclientnum, 0);
}

function private function_69fc092e(localclientnum) {
  if(!isDefined(self.flashlight)) {
    self.flashlight = {};
  }

  if(isDefined(self.flashlight.fx)) {
    flashlightfx = self.flashlight.fx;
  } else if(isDefined(level.flashlight.fx)) {
    flashlightfx = level.flashlight.fx;
  } else {
    flashlightfx = "light/fx9_light_cp_flashlight";
  }

  if(isDefined(self.flashlight.fxtag)) {
    flashlightfxtag = self.flashlight.fxtag;
  } else if(isDefined(level.flashlight.fxtag)) {
    flashlightfxtag = level.flashlight.fxtag;
  } else {
    flashlightfxtag = "tag_light";
  }

  self.flashlight.fxid = util::playFXOnTag(localclientnum, flashlightfx, self, flashlightfxtag);
  self thread function_54557944(localclientnum);
}

function private function_24a560cf(localclientnum) {
  if(isDefined(self.flashlight.fxid)) {
    killfx(localclientnum, self.flashlight.fxid);
    self.flashlight.fxid = undefined;

    if(!isDefined(self.flashlight.fx) && !isDefined(self.flashlight.fxtag)) {
      self.flashlight = undefined;
    }
  }
}

function private function_54557944(localclientnum) {
  self notify("261acc760efea5e1");
  self endon("261acc760efea5e1");
  self endon(#"death");
  level waittill(#"hash_3832e59879eaf7fd");
  self function_24a560cf(localclientnum);
  self function_69fc092e(localclientnum);
}