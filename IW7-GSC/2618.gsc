/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2618.gsc
**************************************/

setup_individual_exploder(var_0) {
  var_1 = var_0.targetname;

  if(!isDefined(level.exploders[var_1])) {
    level.exploders[var_1] = [];
  }

  var_2 = var_0.targetname;

  if(!isDefined(var_2)) {
    var_2 = "";
  }

  level.exploders[var_1][level.exploders[var_1].size] = var_0;

  if(exploder_model_starts_hidden(var_0)) {
    var_0 hide();
    return;
  }

  if(exploder_model_is_damaged_model(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1) {
      if(isDefined(var_0.script_disconnectpaths)) {
        var_0 connectpaths();
      }
    }

    return;
  }

  if(exploder_model_is_chunk(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1) {
      var_0 connectpaths();
    }

    return;
  }
}

setupexploders() {
  scripts\engine\utility::set_createfx_enabled();
  level.exploders = [];
  var_0 = getEntArray("script_brushmodel", "classname");
  var_1 = getEntArray("script_model", "classname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_0[var_0.size] = var_1[var_2];
  }

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_prefab_exploder)) {
      var_4.targetname = var_4.script_prefab_exploder;
    }

    if(isDefined(var_4.masked_exploder)) {
      continue;
    }
    if(isDefined(var_4.targetname)) {
      setup_individual_exploder(var_4);
    }
  }

  var_6 = [];
  var_7 = getEntArray("script_brushmodel", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2].script_prefab_exploder)) {
      var_7[var_2].targetname = var_7[var_2].script_prefab_exploder;
    }

    if(isDefined(var_7[var_2].targetname)) {
      var_6[var_6.size] = var_7[var_2];
    }
  }

  var_7 = getEntArray("script_model", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2].script_prefab_exploder)) {
      var_7[var_2].targetname = var_7[var_2].script_prefab_exploder;
    }

    if(isDefined(var_7[var_2].targetname)) {
      var_6[var_6.size] = var_7[var_2];
    }
  }

  var_7 = getEntArray("item_health", "classname");

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isDefined(var_7[var_2].script_prefab_exploder)) {
      var_7[var_2].targetname = var_7[var_2].script_prefab_exploder;
    }

    if(isDefined(var_7[var_2].targetname)) {
      var_6[var_6.size] = var_7[var_2];
    }
  }

  var_7 = level.struct;

  for(var_2 = 0; var_2 < var_7.size; var_2++) {
    if(!isDefined(var_7[var_2])) {
      continue;
    }
    if(isDefined(var_7[var_2].script_prefab_exploder)) {
      var_7[var_2].targetname = var_7[var_2].script_prefab_exploder;
    }

    if(isDefined(var_7[var_2].targetname)) {
      if(!isDefined(var_7[var_2].angles)) {
        var_7[var_2].angles = (0, 0, 0);
      }

      var_6[var_6.size] = var_7[var_2];
    }
  }

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  var_8 = [];
  var_8["exploderchunk visible"] = 1;
  var_8["exploderchunk"] = 1;
  var_8["exploder"] = 1;
  thread setup_flag_exploders();

  for(var_2 = 0; var_2 < var_6.size; var_2++) {
    var_9 = var_6[var_2];
    var_4 = scripts\engine\utility::createexploder(var_9.script_fxid);
    var_4.v = [];
    var_4.v["origin"] = var_9.origin;
    var_4.v["angles"] = var_9.angles;
    var_4.v["delay"] = var_9.script_delay;
    var_4.v["delay_post"] = var_9.script_delay_post;
    var_4.v["firefx"] = var_9.script_firefx;
    var_4.v["firefxdelay"] = var_9.script_firefxdelay;
    var_4.v["firefxsound"] = var_9.script_firefxsound;
    var_4.v["earthquake"] = var_9.script_earthquake;
    var_4.v["rumble"] = var_9.script_rumble;
    var_4.v["damage"] = var_9.script_damage;
    var_4.v["damage_radius"] = var_9.script_radius;
    var_4.v["soundalias"] = var_9.script_soundalias;
    var_4.v["repeat"] = var_9.script_repeat;
    var_4.v["delay_min"] = var_9.script_delay_min;
    var_4.v["delay_max"] = var_9.script_delay_max;
    var_4.v["target"] = var_9.target;
    var_4.v["ender"] = var_9.script_ender;
    var_4.v["physics"] = var_9.script_physics;
    var_4.v["type"] = "exploder";

    if(!isDefined(var_9.script_fxid)) {
      var_4.v["fxid"] = "No FX";
    } else {
      var_4.v["fxid"] = var_9.script_fxid;
    }

    var_4.v["exploder"] = var_9.targetname;

    if(isDefined(level.createfxexploders)) {
      var_10 = level.createfxexploders[var_4.v["exploder"]];

      if(!isDefined(var_10)) {
        var_10 = [];
      }

      var_10[var_10.size] = var_4;
      level.createfxexploders[var_4.v["exploder"]] = var_10;
    }

    if(!isDefined(var_4.v["delay"])) {
      var_4.v["delay"] = 0;
    }

    if(isDefined(var_9.target)) {
      var_11 = getEntArray(var_4.v["target"], "targetname")[0];

      if(isDefined(var_11)) {
        var_12 = var_11.origin;
        var_4.v["angles"] = vectortoangles(var_12 - var_4.v["origin"]);
      } else {
        var_11 = scripts\engine\utility::get_target_ent(var_4.v["target"]);

        if(isDefined(var_11)) {
          var_12 = var_11.origin;
          var_4.v["angles"] = vectortoangles(var_12 - var_4.v["origin"]);
        }
      }
    }

    if(!isDefined(var_9.code_classname)) {
      var_4.model = var_9;

      if(isDefined(var_4.model.script_modelname)) {
        precachemodel(var_4.model.script_modelname);
      }
    } else if(var_9.code_classname == "script_brushmodel" || isDefined(var_9.model)) {
      var_4.model = var_9;
      var_4.model.disconnect_paths = var_9.script_disconnectpaths;
    }

    if(isDefined(var_9.targetname) && isDefined(var_8[var_9.targetname])) {
      var_4.v["exploder_type"] = var_9.targetname;
    } else {
      var_4.v["exploder_type"] = "normal";
    }

    if(isDefined(var_9.masked_exploder)) {
      var_4.v["masked_exploder"] = var_9.model;
      var_4.v["masked_exploder_spawnflags"] = var_9.spawnflags;
      var_4.v["masked_exploder_script_disconnectpaths"] = var_9.script_disconnectpaths;
      var_9 delete();
    }

    var_4 scripts\common\createfx::post_entity_creation_function();
  }
}

setup_flag_exploders() {
  waittillframeend;
  waittillframeend;
  waittillframeend;
  var_0 = [];

  foreach(var_2 in level.createfxent) {
    if(var_2.v["type"] != "exploder") {
      continue;
    }
    var_3 = var_2.v["flag"];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == "nil") {
      var_2.v["flag"] = undefined;
    }

    var_0[var_3] = 1;
  }

  foreach(var_7, var_6 in var_0) {
    thread exploder_flag_wait(var_7);
  }
}

exploder_flag_wait(var_0) {
  if(!scripts\engine\utility::flag_exist(var_0)) {
    scripts\engine\utility::flag_init(var_0);
  }

  scripts\engine\utility::flag_wait(var_0);

  foreach(var_2 in level.createfxent) {
    if(var_2.v["type"] != "exploder") {
      continue;
    }
    var_3 = var_2.v["flag"];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 != var_0) {
      continue;
    }
    var_2 scripts\engine\utility::activate_individual_exploder();
  }
}

exploder_model_is_damaged_model(var_0) {
  return isDefined(var_0.targetname) && var_0.targetname == "exploder";
}

exploder_model_starts_hidden(var_0) {
  return var_0.model == "fx" && (!isDefined(var_0.targetname) || var_0.targetname != "exploderchunk");
}

exploder_model_is_chunk(var_0) {
  return isDefined(var_0.targetname) && var_0.targetname == "exploderchunk";
}

show_exploder_models_proc(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(!exploder_model_starts_hidden(var_3.model) && !exploder_model_is_damaged_model(var_3.model) && !exploder_model_is_chunk(var_3.model)) {
          var_3.model show();
        }

        if(isDefined(var_3.brush_shown)) {
          var_3.model show();
        }
      }

      return;
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(isDefined(var_3.model)) {
        if(!exploder_model_starts_hidden(var_3.model) && !exploder_model_is_damaged_model(var_3.model) && !exploder_model_is_chunk(var_3.model)) {
          var_3.model show();
        }

        if(isDefined(var_3.brush_shown)) {
          var_3.model show();
        }
      }
    }
  }
}

stop_exploder_proc(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(!isDefined(var_3.looper)) {
          continue;
        }
        if(isDefined(var_3.loopsound_ent)) {
          var_3.loopsound_ent stoploopsound();
          var_3.loopsound_ent delete();
        }

        var_3.looper delete();
      }

      return;
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(!isDefined(var_3.looper)) {
        continue;
      }
      if(isDefined(var_3.loopsound_ent)) {
        var_3.loopsound_ent stoploopsound();
        var_3.loopsound_ent delete();
      }

      var_3.looper delete();
    }
  }
}

get_exploder_array_proc(var_0) {
  var_0 = var_0 + "";
  var_1 = [];

  if(isDefined(level.createfxexploders)) {
    var_2 = level.createfxexploders[var_0];

    if(isDefined(var_2)) {
      var_1 = var_2;
    }
  } else {
    foreach(var_4 in level.createfxent) {
      if(var_4.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_4.v["exploder"])) {
        continue;
      }
      if(var_4.v["exploder"] + "" != var_0) {
        continue;
      }
      var_1[var_1.size] = var_4;
    }
  }

  return var_1;
}

hide_exploder_models_proc(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3.model)) {
          var_3.model hide();
        }
      }

      return;
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(isDefined(var_3.model)) {
        var_3.model hide();
      }
    }
  }
}

delete_exploder_proc(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3.model)) {
          var_3.model delete();
        }
      }
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(isDefined(var_3.model)) {
        var_3.model delete();
      }
    }
  }

  level notify("killexplodertridgers" + var_0);
}

exploder_damage() {
  if(isDefined(self.v["delay"])) {
    var_0 = self.v["delay"];
  } else {
    var_0 = 0;
  }

  if(isDefined(self.v["damage_radius"])) {
    var_1 = self.v["damage_radius"];
  } else {
    var_1 = 128;
  }

  var_2 = self.v["damage"];
  var_3 = self.v["origin"];
  wait(var_0);

  if(isDefined(level.custom_radius_damage_for_exploders)) {
    [[level.custom_radius_damage_for_exploders]](var_3, var_1, var_2);
  } else {
    radiusdamage(var_3, var_1, var_2, var_2);
  }
}

activate_individual_exploder_proc() {
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
  } else if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible") {
    thread brush_throw();
  } else {
    thread brush_delete();
  }
}

brush_delete() {
  var_0 = self.v["exploder"];

  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  } else {
    wait 0.05;
  }

  if(!isDefined(self.model)) {
    return;
  }
  if(isDefined(self.model.classname)) {
    if(!_isstruct(self.model) && isDefined(self.model.classname)) {
      if(scripts\engine\utility::issp() && self.model.spawnflags & 1) {
        self.model call[[level.func["connectPaths"]]]();
      }
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

  waittillframeend;

  if(isDefined(self.model) && !_isstruct(self.model) && isDefined(self.model.classname)) {
    self.model delete();
  }
}

brush_throw() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }

  var_0 = undefined;

  if(isDefined(self.v["target"])) {
    var_0 = scripts\engine\utility::get_target_ent(self.v["target"]);
  }

  if(!isDefined(var_0)) {
    self.model delete();
    return;
  }

  self.model show();

  if(isDefined(self.v["delay_post"])) {
    wait(self.v["delay_post"]);
  }

  var_1 = self.v["origin"];
  var_2 = self.v["angles"];
  var_3 = var_0.origin;
  var_4 = isDefined(self.v["physics"]);

  if(var_4) {
    var_5 = undefined;

    if(isDefined(var_0.target)) {
      var_5 = var_0 scripts\engine\utility::get_target_ent();
    }

    if(isDefined(var_5)) {
      var_6 = var_0.origin;
      var_7 = vectornormalize(var_5.origin - var_0.origin);
    } else {
      var_6 = self.model.origin;
      var_7 = vectornormalize(var_3 - self.model.origin);
    }

    var_7 = var_7 * self.v["physics"];
    self.model physicslaunchserver(var_6, var_7);
    return;
  } else {
    var_7 = var_3 - self.model.origin;
    self.model rotatevelocity(var_7, 12);
    self.model movegravity(var_7, 12);
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    wait 3;
    self.exploded = undefined;
    self.v["origin"] = var_1;
    self.v["angles"] = var_2;
    self.model hide();
    return;
  }

  self.v["exploder"] = undefined;
  wait 6;
  self.model delete();
}

brush_show() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }

  if(!isDefined(self.model.script_modelname)) {
    self.model show();
    self.model solid();
  } else {
    var_0 = self.model scripts\engine\utility::spawn_tag_origin();

    if(isDefined(self.model.script_linkname)) {
      var_0.script_linkname = self.model.script_linkname;
    }

    var_0 setModel(self.model.script_modelname);
    var_0 show();
  }

  self.brush_shown = 1;

  if(scripts\engine\utility::issp() && !isDefined(self.model.script_modelname) && self.model.spawnflags & 1) {
    if(!isDefined(self.model.disconnect_paths)) {
      self.model call[[level.func["connectPaths"]]]();
    } else {
      self.model call[[level.func["disconnectPaths"]]]();
    }
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    wait 3;
    self.exploded = undefined;

    if(!isDefined(self.model.script_modelname)) {
      self.model hide();
      self.model notsolid();
    }
  }
}

exploder_rumble() {
  if(!scripts\engine\utility::issp()) {
    return;
  }
  exploder_delay();
  level.player playrumbleonentity(self.v["rumble"]);
}

exploder_delay() {
  if(!isDefined(self.v["delay"])) {
    self.v["delay"] = 0;
  }

  var_0 = self.v["delay"];
  var_1 = self.v["delay"] + 0.001;

  if(isDefined(self.v["delay_min"])) {
    var_0 = self.v["delay_min"];
  }

  if(isDefined(self.v["delay_max"])) {
    var_1 = self.v["delay_max"];
  }

  if(var_0 > 0) {
    wait(randomfloatrange(var_0, var_1));
  }
}

effect_loopsound() {
  if(isDefined(self.loopsound_ent)) {
    self.loopsound_ent stoploopsound();
    self.loopsound_ent delete();
  }

  var_0 = self.v["origin"];
  var_1 = self.v["loopsound"];
  exploder_delay();
  self.loopsound_ent = scripts\engine\utility::play_loopsound_in_space(var_1, var_0);
}

sound_effect() {
  effect_soundalias();
}

effect_soundalias() {
  var_0 = self.v["origin"];
  var_1 = self.v["soundalias"];
  exploder_delay();
  scripts\engine\utility::play_sound_in_space(var_1, var_0);
}

exploder_earthquake() {
  exploder_delay();
  scripts\engine\utility::do_earthquake(self.v["earthquake"], self.v["origin"]);
}

exploder_playSound() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }
  scripts\engine\utility::play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}

fire_effect() {
  var_0 = self.v["forward"];
  var_1 = self.v["up"];
  var_2 = undefined;
  var_3 = self.v["firefxsound"];
  var_4 = self.v["origin"];
  var_5 = self.v["firefx"];
  var_6 = self.v["ender"];

  if(!isDefined(var_6)) {
    var_6 = "createfx_effectStopper";
  }

  var_7 = 0.5;

  if(isDefined(self.v["firefxdelay"])) {
    var_7 = self.v["firefxdelay"];
  }

  exploder_delay();

  if(isDefined(var_3)) {
    scripts\engine\utility::loop_fx_sound(var_3, var_4, 1, var_6);
  }

  playFX(level._effect[var_5], self.v["origin"], var_0, var_1);
}

cannon_effect() {
  if(isDefined(self.v["repeat"])) {
    thread exploder_playSound();

    for(var_0 = 0; var_0 < self.v["repeat"]; var_0++) {
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

activate_exploder(var_0, var_1, var_2) {
  var_0 = var_0 + "";
  level notify("exploding_" + var_0);
  var_3 = 0;

  if(isDefined(level.createfxexploders) && !level.createfx_enabled) {
    var_4 = level.createfxexploders[var_0];

    if(isDefined(var_4)) {
      foreach(var_6 in var_4) {
        var_6 scripts\engine\utility::activate_individual_exploder();
        var_3 = 1;
      }
    }
  } else {
    for(var_8 = 0; var_8 < level.createfxent.size; var_8++) {
      var_6 = level.createfxent[var_8];

      if(!isDefined(var_6)) {
        continue;
      }
      if(var_6.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_6.v["exploder"])) {
        continue;
      }
      if(var_6.v["exploder"] + "" != var_0) {
        continue;
      }
      var_6 scripts\engine\utility::activate_individual_exploder();
      var_3 = 1;
    }
  }

  if(!shouldrunserversideeffects() && !var_3) {
    activate_clientside_exploder(var_0, var_1, var_2);
  }
}

activate_clientside_exploder(var_0, var_1, var_2) {
  if(!is_valid_clientside_exploder_name(var_0)) {
    return;
  }
  var_3 = int(var_0);
  activateclientexploder(var_3, var_1, var_2);
}

is_valid_clientside_exploder_name(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0;

  if(isstring(var_0)) {
    var_1 = int(var_0);

    if(var_1 == 0 && var_0 != "0") {
      return 0;
    }
  }

  return var_1 >= 0;
}

shouldrunserversideeffects() {
  if(scripts\engine\utility::issp()) {
    return 1;
  }

  if(!isDefined(level.createfx_enabled)) {
    scripts\engine\utility::set_createfx_enabled();
  }

  if(level.createfx_enabled) {
    return 1;
  } else {
    return getdvar("clientSideEffects") != "1";
  }
}

exploder_before_load(var_0, var_1, var_2) {
  waittillframeend;
  waittillframeend;
  activate_exploder(var_0, var_1, var_2);
}

exploder_after_load(var_0, var_1, var_2) {
  activate_exploder(var_0, var_1, var_2);
}