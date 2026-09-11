/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\marines\marines_civilians.gsc
*********************************************************/

function civilians_init() {
  precache_prop_models();
  precache_civilian_anims();
}

function precache_prop_models() {
  precachemodel("com_cellphone_on");
}

#using_animtree("generic_human");

function precache_civilian_anims() {
  level.scr_animtree["generic"] = #animtree;
  var0 = [];
  GscBinSkip0(0x2e, 0, 7);
}

function init_civilian_props() {
  anim.civilian_props = [];
  anim.civilian_props["civilian_texting_standing"] = "com_cellphone_on";
}

function populate_civilians(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  var5 = getspawner(var0, "targetname");
  var6 = scripts\engine\utility::getStructArray(var1, "targetname");
  var7 = [];

  foreach(var9 in var6) {
    if(var2) {
      var10 = var5 scripts\engine\sp\utility::dronespawn();
    } else {
      var10 = var5 scripts\engine\sp\utility::spawn_ai();
    }

    var7 = scripts\engine\utility::array_add(var7, var10);
    var5.count = 1;

    if(var2) {
      var10.origin = var9.origin;
      var10.angles = var9.angles;
    } else {
      var10 forceteleport(var9.origin, var9.angles);
    }

    if(isDefined(var9.script_noteworthy)) {
      var10.script_noteworthy = var9.script_noteworthy;
    }

    wait 0.05;

    if(var3) {
      thread looping_idle_animation(var10);
      continue;
    }

    thread single_animation(var10, var9);
  }

  return var7;
}

function looping_idle_animation(var0) {
  self.animname = "generic";
  var1 = var0.animation;
  var0 thread scripts\common\anim::anim_generic_loop(self, var1);
  var2 = attach_props(var1);
  self waittill("death");

  if(isDefined(var2)) {
    var2 delete();
    return;
  }
}

function single_animation(var0, var1) {
  self.animname = "generic";
  var2 = var0.animation;
  var3 = attach_props(var2);

  if(var1 == 1) {
    var0 scripts\common\anim::anim_generic(self, var2);

    if(isDefined(var3)) {
      var3 delete();
    }

    self delete();
    return;
  }

  var0 thread scripts\common\anim::anim_generic(self, var2);
  self waittill("death");

  if(isDefined(var3)) {
    var3 delete();
    return;
  }
}

function attach_props(var0) {
  if(isDefined(self.has_attached_props)) {
    return;
  }

  init_civilian_props();
  var1 = anim.civilian_props[var0];

  if(isDefined(var1)) {
    var2 = self attach(var1, "tag_inhand", 1);
    self.has_attached_props = 1;
    return var2;
  }
}