/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\exploder.gsc
***********************************************/

function setup_individual_exploder(var0) {
  var1 = var0.targetname;

  if(!isDefined(var1)) {
    var1 = "";
  }

  if(exploder_starts_hidden(var0)) {
    var0 hide();
    return;
  }

  if(exploder_is_damaged_model(var0)) {
    var0 hide();
    var0 notsolid();

    if(isDefined(var0.spawnflags) && var0.spawnflags & 1) {
      if(isDefined(var0.script_disconnectpaths)) {
        var0 connectpaths();
      }
    }

    return;
  }

  if(exploder_is_chunk(var0)) {
    var0 hide();
    var0 notsolid();

    if(isDefined(var0.spawnflags) && var0.spawnflags & 1) {
      var0 connectpaths();
    }

    return;
  }
}

function addinitexploders(var0) {
  foreach(var2 in var0) {
    if(!isDefined(var2)) {
      continue;
    }

    if(isDefined(var2.script_prefab_exploder)) {
      var2.script_exploder = var2.script_prefab_exploder;
      level.init_exploders[level.init_exploders.size] = var2;
      continue;
    }

    if(isDefined(var2.script_exploder)) {
      var3 = 1;

      if(!isDefined(var2.angles)) {
        var2.angles = (0, 0, 0);
      }

      level.init_exploders[level.init_exploders.size] = var2;
    }
  }
}

function removedeletableexploders(var0) {
  foreach(var2 in var0) {
    if(isDefined(var2.script_delete) && var2.script_delete) {
      level.struct[var3] = undefined;
    }
  }
}

function setupexploders() {
  level.init_exploders = [];
  level.exploders = [];
  var0 = getEntArray("script_brushmodel", "classname");
  var1 = getEntArray("script_model", "classname");

  foreach(var3 in var1) {
    var0 = var3;
  }

  foreach(var6 in var0) {
    if(isDefined(var6.script_prefab_exploder)) {
      var6.script_exploder = var6.script_prefab_exploder;
    }

    if(isDefined(var6.masked_exploder)) {
      continue;
    }

    if(isDefined(var6.script_exploder)) {
      setup_individual_exploder(var6);
    }
  }

  addinitexploders(getEntArray("script_brushmodel", "classname"));
  addinitexploders(getEntArray("script_model", "classname"));
  addinitexploders(level.struct);

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  var8 = [];
  GscBinSkip0(0x2e, "exploderchunk visible", 1);
}

function exploder_flag_wait(var0, var1) {
  if(!scripts\engine\utility::flag_exist(var0)) {
    scripts\engine\utility::flag_init(var0);
  }

  scripts\engine\utility::flag_wait(var0);

  foreach(var3 in var1) {
    foreach(var5 in level.createfxexploders[var3]) {
      var5 scripts\engine\utility::activate_individual_exploder();
    }
  }
}

function exploder_is_damaged_model(var0) {
  return isDefined(var0.targetname) && var0.targetname == "exploder";
}

function exploder_starts_hidden(var0) {
  return var0.model == "fx" && (!isDefined(var0.targetname) || var0.targetname != "exploderchunk");
}

function exploder_is_chunk(var0) {
  return isDefined(var0.targetname) && var0.targetname == "exploderchunk";
}

function show_exploder_models_proc(var0) {
  var0 += "";
  var1 = get_exploders();

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      if(isstruct(var3.model)) {
        continue;
      }

      if(!exploder_starts_hidden(var3.model) && !exploder_is_damaged_model(var3.model) && !exploder_is_chunk(var3.model)) {
        var3.model show();
      }

      if(isDefined(var3.brush_shown)) {
        var3.model show();
      }
    }

    return;
  }
}

function get_exploders(var0) {
  var1 = [];

  if(level.createfx_enabled) {
    var1 = get_createfx_exploders(var0);
  } else if(isDefined(level.createfxexploders[var0])) {
    var1 = level.createfxexploders[var0];
  }

  if(isDefined(level.exploders[var0])) {
    foreach(var3 in level.exploders[var0]) {
      var1 = var3;
    }
  }

  return var1;
}

function get_createfx_exploders(var0) {}

function stop_exploder_proc(var0, var1, var2) {
  var0 += "";
  var3 = 0;
  var4 = get_exploders(var0);

  if(isDefined(var4)) {
    foreach(var6 in var4) {
      if(!isDefined(var6.looper)) {
        continue;
      }

      if(isDefined(var6.loopsound_ent)) {
        var6.loopsound_ent stoploopsound();
        var6.loopsound_ent delete();
      }

      var6.looper delete();
      var3 = 1;
    }
  }

  if(!shouldrunserversideeffects() && (isplatformconsole() || !var3)) {
    stop_clientside_exploder(var0, var1, var2);
    return;
  }
}

function stop_clientside_exploder(var0, var1, var2) {
  if(isplatformconsole()) {
    loadinfiltransient(var0, var1, var2);
    return;
  }

  if(!is_valid_clientside_exploder_name(var0)) {
    return;
  }

  var3 = int(var0);
  loadinfiltransient(var3, var1, var2);
}

function get_exploder_array_proc(var0) {
  var0 += "";
  var1 = [];
  var2 = get_exploders(var0);

  if(isDefined(var2)) {
    var1 = var2;
  }

  return var1;
}

function hide_exploder_models_proc(var0) {
  var0 += "";
  var1 = get_exploders(var0);

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      if(isstruct(var3.model)) {
        continue;
      }

      if(isDefined(var3.model)) {
        var3.model hide();
      }
    }

    return;
  }
}

function delete_exploder_proc(var0) {
  var0 += "";
  var1 = get_exploders(var0);

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      if(isstruct(var3.model)) {
        continue;
      }

      if(isDefined(var3.model)) {
        var3.model delete();
      }
    }
  }

  level notify("killexplodertridgers" + var0);
}

function exploder_damage() {
  if(isDefined(self.v["delay"])) {
    var0 = self.v["delay"];
  } else {
    var0 = 0;
  }

  if(isDefined(self.v["damage_radius"])) {
    var1 = self.v["damage_radius"];
  } else {
    var1 = 128;
  }

  var2 = self.v["damage"];
  var3 = self.v["origin"];

  if(isDefined(self.v["envonly"])) {
    var4 = self.v["envonly"];
  } else {
    var4 = 0;
  }

  if(isDefined(self.v["dotraces"])) {
    var5 = self.v["dotraces"];
  } else {
    var5 = 1;
  }

  wait var2;
  radiusdamage(var4, var3, var4, var4, undefined, "MOD_EXPLOSIVE", undefined, var5, var5);
}

function activate_individual_exploder_proc() {
  if(isDefined(self.v["firefx"])) {
    thread fire_effect();
  }

  if(isDefined(self.v["fxid"]) && self.v["fxid"] != "No FX") {
    thread cannon_effect();
  } else if(isDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil") {
    thread sound_effect();
  }

  if(isDefined(self.v["loopsound"]) && self.v["loopsound"] != "nil") {
    thread effect_loopsound();
  }

  if(isDefined(self.v["damage"])) {
    thread exploder_damage();
  }

  if(isDefined(self.v["earthquake"])) {
    thread exploder_earthquake();
  }

  if(isDefined(self.v["rumble"])) {
    thread exploder_rumble();
  }

  if(self.v["exploder_type"] == "exploder") {
    thread brush_show();
    return;
  }

  if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible") {
    thread brush_throw();
    return;
  }

  thread brush_delete();
}

function brush_delete() {
  var0 = self.v["exploder"];

  if(isDefined(self.v["delay"])) {
    wait self.v["delay"];
  } else {
    waitframe();
  }

  if(!isDefined(self.model)) {
    return;
  }

  if(isstruct(self.model)) {
    return;
  }

  if(scripts\common\utility::issp() && isDefined(self.model.classname)) {
    if(self.model.spawnflags & 1) {
      self.model builtin[[level.func["connectPaths"]]]();
    }
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }

    self.exploded = 1;
    self.model hide();
    self.model notsolid();
    wait 3;
    self.exploded = undefined;
    self.model show();
    self.model solid();
    return;
  }

  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX") {
    self.v["exploder"] = undefined;
  }

  waittillframeend();
  self.model delete();
}

function brush_throw() {
  if(isDefined(self.v["delay"])) {
    wait self.v["delay"];
  }

  var0 = undefined;

  if(isDefined(self.v["target"])) {
    var0 = scripts\engine\utility::get_target_ent(self.v["target"]);
  }

  if(!isDefined(var0)) {
    self.model delete();
    return;
  }

  self.model show();

  if(isDefined(self.v["delay_post"])) {
    wait self.v["delay_post"];
  }

  var1 = self.v["origin"];
  var2 = self.v["angles"];
  var3 = var0.origin;
  var4 = isDefined(self.v["physics"]);

  if(var4) {
    var5 = undefined;

    if(isDefined(var0.target)) {
      var5 = var0 scripts\engine\utility::get_target_ent();
    }

    if(isDefined(var5)) {
      var6 = var0.origin;
      var7 = vectorNormalize(var5.origin - var0.origin);
    } else {
      var6 = self.model.origin;
      var7 = vectorNormalize(var5 - self.model.origin);
    }

    var7 *= self.v["physics"];
    self.model physicslaunchserver(var6, var7);
    return;
  } else {
    var7 = var6 - self.model.origin;
    self.model rotatevelocity(var7, 12);
    self.model movegravity(var7, 12);
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }

    self.exploded = 1;
    wait 3;
    self.exploded = undefined;
    self.v["origin"] = var6;
    self.v["angles"] = var7;
    self.model hide();
    return;
  }

  self.v["exploder"] = undefined;
  wait 6;
  self.model delete();
}

function brush_show() {
  if(isDefined(self.v["delay"])) {
    wait self.v["delay"];
  }

  var0 = 0;
  var1 = undefined;

  if(!isDefined(self.model.script_modelname)) {
    self.model show();
    self.model solid();
  } else {
    var0 = 1;
    var1 = spawn("script_model", self.model.origin);
    var1.angles = self.model.angles;
    var1 setModel(self.model.script_modelname);

    if(isDefined(self.model.script_linkname)) {
      var1.script_linkname = self.model.script_linkname;
    }
  }

  self.brush_shown = 1;

  if(!var0 && scripts\common\utility::issp() && self.model.spawnflags & 1) {
    if(!isDefined(self.model.disconnect_paths)) {
      self.model builtin[[level.func["connectPaths"]]]();
    } else {
      self.model builtin[[level.func["disconnectPaths"]]]();
    }
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }

    self.exploded = 1;
    wait 3;
    self.exploded = undefined;

    if(!var0) {
      self.model hide();
      self.model notsolid();
      return;
    }

    var1 delete();
    return;
  }
}

function exploder_rumble() {
  if(!scripts\common\utility::issp()) {
    return;
  }

  exploder_delay();
  level.player playRumbleOnEntity(self.v["rumble"]);
}

function exploder_delay() {
  if(!isDefined(self.v["delay"])) {
    self.v["delay"] = 0;
  }

  var0 = self.v["delay"];
  var1 = self.v["delay"] + 0.001;

  if(isDefined(self.v["delay_min"])) {
    var0 = self.v["delay_min"];
  }

  if(isDefined(self.v["delay_max"])) {
    var1 = self.v["delay_max"];
  }

  if(var0 > 0) {
    wait randomfloatrange(var0, var1);
    return;
  }
}

function effect_loopsound() {
  if(isDefined(self.loopsound_ent)) {
    self.loopsound_ent stoploopsound();
    self.loopsound_ent delete();
  }

  var0 = self.v["origin"];
  var1 = self.v["loopsound"];
  exploder_delay();
  self.loopsound_ent = scripts\engine\utility::play_loopsound_in_space(var1, var0);
}

function sound_effect() {
  effect_soundalias();
}

function effect_soundalias() {
  var0 = self.v["origin"];
  var1 = self.v["soundalias"];
  exploder_delay();
  scripts\engine\utility::play_sound_in_space(var1, var0);
}

function exploder_earthquake() {
  exploder_delay();
  scripts\engine\utility::do_earthquake(self.v["earthquake"], self.v["origin"]);
}

function exploder_playSound() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }

  scripts\engine\utility::play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}

function fire_effect() {
  var0 = self.v["forward"];
  var1 = self.v["up"];
  var2 = undefined;
  var3 = self.v["firefxsound"];
  var4 = self.v["origin"];
  var5 = self.v["firefx"];
  var6 = self.v["ender"];

  if(!isDefined(var6)) {
    var6 = "createfx_effectStopper";
  }

  var7 = 0.5;

  if(isDefined(self.v["firefxdelay"])) {
    var7 = self.v["firefxdelay"];
  }

  exploder_delay();

  if(isDefined(var3)) {
    scripts\engine\utility::loop_fx_sound(var3, var4, 1, var6);
  }

  playFX(level._effect[var5], self.v["origin"], var0, var1);
}

function cannon_effect() {
  if(isDefined(self.v["repeat"])) {
    thread exploder_playSound();

    for(var0 = 0; var0 < self.v["repeat"]; var0++) {
      playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      exploder_delay();
    }

    return;
  }

  exploder_delay();

  if(isDefined(self.looper)) {
    self.looper delete();
  }

  self.looper = spawnfx(scripts\engine\utility::getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);
  triggerfx(self.looper);
  exploder_playSound();
}

function activate_exploder(var0, var1, var2) {
  var0 += "";
  level notify("exploding_" + var0);
  var3 = 0;
  var4 = get_exploders(var0);

  if(isDefined(var4)) {
    foreach(var6 in var4) {
      var6 scripts\engine\utility::activate_individual_exploder();
      var3 = 1;
    }
  }

  if(!shouldrunserversideeffects() && (isplatformconsole() || !var3)) {
    activate_clientside_exploder(var0, var1, var2);
    return;
  }
}

function activate_clientside_exploder(var0, var1, var2) {
  if(isplatformconsole()) {
    activateclientexploder(var0, var1, var2);
    return;
  }

  if(!is_valid_clientside_exploder_name(var0)) {
    return;
  }

  var3 = int(var0);
  activateclientexploder(var3, var1, var2);
}

function is_valid_clientside_exploder_name(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = var0;

  if(isstring(var0)) {
    var1 = int(var0);

    if(var1 == 0 && var0 != "0") {
      return false;
    }
  }

  return var1 >= 0;
}

function shouldrunserversideeffects() {
  if(scripts\common\utility::issp() && !isplatformconsole()) {
    return 1;
  }

  if(!isDefined(level.createfx_enabled)) {
    scripts\engine\utility::set_createfx_enabled();
  }

  if(level.createfx_enabled) {
    return 1;
  }

  return getDvar("OKOLRTLORL") != "1";
}

function exploder_before_load(var0, var1, var2) {
  waittillframeend();
  waittillframeend();
  activate_exploder(var0, var1, var2);
}

function exploder_after_load(var0, var1, var2) {
  activate_exploder(var0, var1, var2);
}