/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\global_fx_code.gsc
***********************************************/

function global_fx(var0, var1, var2, var3, var4) {
  init();
  level.global_fx[var0] = var3;
  var5 = scripts\engine\utility::getstructarray_delete(var0, "targetname");

  if(!isDefined(var5)) {
    return;
  }

  if(!var5.size) {
    return;
  }

  if(!isDefined(var3)) {
    var3 = var1;
  }

  if(!isDefined(var2)) {
    var2 = randomfloatrange(-20, -15);
  }

  foreach(var7 in var5) {
    if(!isDefined(level._effect[var3])) {
      level._effect[var3] = loadfx(var1);
    }

    if(!isDefined(var7.angles)) {
      var7.angles = (0, 0, 0);
    }

    var8 = scripts\engine\utility::createoneshoteffect(var3);
    var8.v["origin"] = var7.origin;
    var8.v["angles"] = var7.angles;
    var8.v["fxid"] = var3;
    var8.v["delay"] = var2;

    if(isDefined(var4)) {
      var8.v["soundalias"] = var4;
    }

    if(!isDefined(var7.script_noteworthy)) {
      continue;
    }

    var9 = var7.script_noteworthy;

    if(!isDefined(level._global_fx_ents[var9])) {
      level._global_fx_ents[var9] = [];
    }

    level._global_fx_ents[var9][level._global_fx_ents[var9].size] = var8;
  }
}

function init() {
  if(!scripts\engine\utility::add_init_script("global_FX", &init)) {
    return;
  }

  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  if(!isDefined(level.global_fx)) {
    level.global_fx = [];
  }

  level._global_fx_ents = [];
}