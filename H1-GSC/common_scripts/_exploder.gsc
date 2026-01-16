/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: common_scripts\_exploder.gsc
****************************************/

getexploders(var_0) {
  var_0 = var_0 + "";

  if(isdefined(level.createfxexploders))
    return level.createfxexploders[var_0];

  var_1 = [];

  foreach(var_3 in level.createfxent) {
    if(!isdefined(var_3)) {
      continue;
    }
    if(var_3.v["type"] != "exploder") {
      continue;
    }
    if(!isdefined(var_3.v["exploder"])) {
      continue;
    }
    if(var_3.v["exploder"] == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

setup_individual_exploder(var_0) {
  var_1 = var_0.script_exploder;

  if(!isdefined(level.exploders[var_1]))
    level.exploders[var_1] = [];

  var_2 = var_0.targetname;

  if(!isdefined(var_2))
    var_2 = "";

  level.exploders[var_1][level.exploders[var_1].size] = var_0;

  if(exploder_model_starts_hidden(var_0)) {
    var_0 hide();
    return;
  }

  if(exploder_model_is_damaged_model(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isdefined(var_0.spawnflags) && var_0.spawnflags & 1) {
      if(isdefined(var_0.script_disconnectpaths))
        var_0 connectpaths();
    }

    return;
  }

  if(exploder_model_is_chunk(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isdefined(var_0.spawnflags) && var_0.spawnflags & 1)
      var_0 connectpaths();

    return;
  }

  if(exploder_model_is_anim_model(var_0) && issubstr(var_0.targetname, "exploderanimhide")) {
    var_0 hide();
    var_0 notsolid();

    if(isdefined(var_0.spawnflags) && var_0.spawnflags & 1)
      var_0 connectpaths();

    return;
  }
}

setupexploders() {
  level.exploders = [];
  var_0 = getentarray("script_brushmodel", "classname");
  var_1 = getentarray("script_model", "classname");

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_0[var_0.size] = var_1[var_2];

  foreach(var_4 in var_0) {
    if(isdefined(var_4.script_prefab_exploder))
      var_4.script_exploder = var_4.script_prefab_exploder;

    if(isdefined(var_4.masked_exploder)) {
      continue;
    }
    if(isdefined(var_4.script_exploder))
      setup_individual_exploder(var_4);
  }

  var_6 = [];
  var_7 = getentarray("script_brushmodel", "classname");

  for (var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isdefined(var_7[var_2].script_prefab_exploder))
      var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;

    if(isdefined(var_7[var_2].script_exploder))
      var_6[var_6.size] = var_7[var_2];
  }

  var_7 = getentarray("script_model", "classname");

  for (var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isdefined(var_7[var_2].script_prefab_exploder))
      var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;

    if(isdefined(var_7[var_2].script_exploder))
      var_6[var_6.size] = var_7[var_2];
  }

  var_7 = getentarray("script_origin", "classname");

  for (var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isdefined(var_7[var_2].script_prefab_exploder))
      var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;

    if(isdefined(var_7[var_2].script_exploder))
      var_6[var_6.size] = var_7[var_2];
  }

  var_7 = getentarray("item_health", "classname");

  for (var_2 = 0; var_2 < var_7.size; var_2++) {
    if(isdefined(var_7[var_2].script_prefab_exploder))
      var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;

    if(isdefined(var_7[var_2].script_exploder))
      var_6[var_6.size] = var_7[var_2];
  }

  var_7 = level.struct;

  for (var_2 = 0; var_2 < var_7.size; var_2++) {
    if(!isdefined(var_7[var_2])) {
      continue;
    }
    if(isdefined(var_7[var_2].script_prefab_exploder))
      var_7[var_2].script_exploder = var_7[var_2].script_prefab_exploder;

    if(isdefined(var_7[var_2].script_exploder)) {
      if(!isdefined(var_7[var_2].angles))
        var_7[var_2].angles = (0, 0, 0);

      var_6[var_6.size] = var_7[var_2];
    }
  }

  if(!isdefined(level.createfxent))
    level.createfxent = [];

  var_8 = [];
  var_8["exploderchunk visible"] = 1;
  var_8["exploderchunk"] = 1;
  var_8["exploder"] = 1;
  thread setup_flag_exploders();

  for (var_2 = 0; var_2 < var_6.size; var_2++) {
    var_9 = var_6[var_2];
    var_4 = common_scripts\utility::createexploder(var_9.script_fxid);
    var_4.v = [];
    var_4.v["origin"] = var_9.origin;
    var_4.v["angles"] = var_9.angles;
    var_4.v["delay"] = var_9.script_delay;
    var_4.v["delay_post"] = var_9.script_delay_post;
    var_4.v["firefx"] = var_9.script_firefx;
    var_4.v["firefxdelay"] = var_9.script_firefxdelay;
    var_4.v["firefxsound"] = var_9.script_firefxsound;
    var_4.v["firefxtimeout"] = var_9.script_firefxtimeout;
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

    if(!isdefined(var_9.script_fxid))
      var_4.v["fxid"] = "No FX";
    else
      var_4.v["fxid"] = var_9.script_fxid;

    var_4.v["exploder"] = var_9.script_exploder;

    if(isdefined(level.createfxexploders)) {
      var_10 = level.createfxexploders[var_4.v["exploder"]];

      if(!isdefined(var_10))
        var_10 = [];

      var_10[var_10.size] = var_4;
      level.createfxexploders[var_4.v["exploder"]] = var_10;
    }

    if(!isdefined(var_4.v["delay"]))
      var_4.v["delay"] = 0;

    if(isdefined(var_9.target)) {
      var_11 = getentarray(var_4.v["target"], "targetname")[0];

      if(isdefined(var_11)) {
        var_12 = var_11.origin;
        var_4.v["angles"] = vectortoangles(var_12 - var_4.v["origin"]);
      } else {
        var_11 = common_scripts\utility::get_target_ent(var_4.v["target"]);

        if(isdefined(var_11)) {
          var_12 = var_11.origin;
          var_4.v["angles"] = vectortoangles(var_12 - var_4.v["origin"]);
        }
      }
    }

    if(!isdefined(var_9.code_classname)) {
      var_4.model = var_9;

      if(isdefined(var_4.model.script_modelname))
        precachemodel(var_4.model.script_modelname);
    } else if(var_9.code_classname == "script_brushmodel" || isdefined(var_9.model)) {
      var_4.model = var_9;
      var_4.model.disconnect_paths = var_9.script_disconnectpaths;
    }

    if(isdefined(var_9.targetname) && isdefined(var_8[var_9.targetname]))
      var_4.v["exploder_type"] = var_9.targetname;
    else if(isdefined(var_9.targetname) && issubstr(var_9.targetname, "exploderanim"))
      var_4.v["exploder_type"] = "exploderanim";
    else
      var_4.v["exploder_type"] = "normal";

    if(isdefined(var_9.masked_exploder)) {
      var_4.v["masked_exploder"] = var_9.model;
      var_4.v["masked_exploder_spawnflags"] = var_9.spawnflags;
      var_4.v["masked_exploder_script_disconnectpaths"] = var_9.script_disconnectpaths;
      var_9 delete();
    }

    var_4 common_scripts\_createfx::post_entity_creation_function();
  }

  if(level.createfx_enabled && getdvar("createfx_exploder_waittime") == "")
    setdvar("createfx_exploder_waittime", 3);
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

    if(!isdefined(var_3)) {
      continue;
    }
    if(var_3 == "nil")
      var_2.v["flag"] = undefined;

    var_0[var_3] = 1;
  }

  foreach(var_7, var_6 in var_0)
  thread exploder_flag_wait(var_7);
}

exploder_flag_wait(var_0) {
  if(!common_scripts\utility::flag_exist(var_0))
    common_scripts\utility::flag_init(var_0);

  common_scripts\utility::flag_wait(var_0);

  foreach(var_2 in level.createfxent) {
    if(var_2.v["type"] != "exploder") {
      continue;
    }
    var_3 = var_2.v["flag"];

    if(!isdefined(var_3)) {
      continue;
    }
    if(var_3 != var_0) {
      continue;
    }
    var_2 common_scripts\utility::activate_individual_exploder();
  }
}

exploder_model_is_damaged_model(var_0) {
  return isdefined(var_0.targetname) && var_0.targetname == "exploder";
}

exploder_model_starts_hidden(var_0) {
  return var_0.model == "fx" && (!isdefined(var_0.targetname) || var_0.targetname != "exploderchunk");
}

exploder_model_is_chunk(var_0) {
  return isdefined(var_0.targetname) && var_0.targetname == "exploderchunk";
}

exploder_model_is_anim_model(var_0) {
  return isdefined(var_0.targetname) && issubstr(var_0.targetname, "exploderanim");
}

show_exploder_models_proc(var_0) {
  var_0 = var_0 + "";

  if(isdefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isdefined(var_1)) {
      foreach(var_3 in var_1) {
        if(!exploder_model_starts_hidden(var_3.model) && !exploder_model_is_damaged_model(var_3.model) && !exploder_model_is_chunk(var_3.model))
          var_3.model show();

        if(isdefined(var_3.brush_shown))
          var_3.model show();
      }

      return;
    }
  } else {
    for (var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isdefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(isdefined(var_3.model)) {
        if(!exploder_model_starts_hidden(var_3.model) && !exploder_model_is_damaged_model(var_3.model) && !exploder_model_is_chunk(var_3.model))
          var_3.model show();

        if(isdefined(var_3.brush_shown))
          var_3.model show();
      }
    }
  }
}

stop_exploder_proc(var_0) {
  var_0 = var_0 + "";

  if(isdefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isdefined(var_1)) {
      foreach(var_3 in var_1) {
        if(!isdefined(var_3.looper)) {
          continue;
        }
        var_3.looper delete();
      }

      return;
    }
  } else {
    for (var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isdefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(!isdefined(var_3.looper)) {
        continue;
      }
      var_3.looper delete();
    }
  }
}

get_exploder_array_proc(var_0) {
  var_0 = var_0 + "";
  var_1 = [];

  if(isdefined(level.createfxexploders)) {
    var_2 = level.createfxexploders[var_0];

    if(isdefined(var_2))
      var_1 = var_2;
  } else {
    foreach(var_4 in level.createfxent) {
      if(var_4.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_4.v["exploder"])) {
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

  if(isdefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isdefined(var_1)) {
      foreach(var_3 in var_1) {
        if(isdefined(var_3.model))
          var_3.model hide();
      }

      return;
    }
  } else {
    for (var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isdefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(isdefined(var_3.model))
        var_3.model hide();
    }
  }
}

delete_exploder_proc(var_0) {
  var_0 = var_0 + "";

  if(isdefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isdefined(var_1)) {
      foreach(var_3 in var_1) {
        if(isdefined(var_3.model))
          var_3.model delete();
      }
    }
  } else {
    for (var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isdefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(isdefined(var_3.model))
        var_3.model delete();
    }
  }

  level notify("killexplodertridgers" + var_0);
}

exploder_damage() {
  if(isdefined(self.v["delay"]))
    var_0 = self.v["delay"];
  else
    var_0 = 0;

  if(isdefined(self.v["damage_radius"]))
    var_1 = self.v["damage_radius"];
  else
    var_1 = 128;

  var_2 = self.v["damage"];
  var_3 = self.v["origin"];
  wait(var_0);

  if(isdefined(level.custom_radius_damage_for_exploders))
    [[level.custom_radius_damage_for_exploders]](var_3, var_1, var_2);
  else
    radiusdamage(var_3, var_1, var_2, var_2);
}

activate_individual_exploder_proc() {
  if(isdefined(self.v["firefx"]))
    thread fire_effect();

  if(isdefined(self.v["fxid"]) && self.v["fxid"] != "No FX")
    thread cannon_effect();
  else if(isdefined(self.v["soundalias"]) && self.v["soundalias"] != "nil")
    thread sound_effect();

  if(isdefined(self.v["loopsound"]) && self.v["loopsound"] != "nil")
    thread effect_loopsound();

  if(isdefined(self.v["damage"]))
    thread exploder_damage();

  if(isdefined(self.v["earthquake"]))
    thread exploder_earthquake();

  if(isdefined(self.v["rumble"]))
    thread exploder_rumble();

  if(self.v["exploder_type"] == "exploderanim")
    thread exploder_anim();
  else if(self.v["exploder_type"] == "exploder")
    thread brush_show();
  else if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible")
    thread brush_throw();
  else
    thread brush_delete();
}

brush_delete() {
  var_0 = self.v["exploder"];

  if(isdefined(self.v["delay"]) && self.v["delay"] >= 0)
    wait(self.v["delay"]);
  else
    wait 0.05;

  if(!isdefined(self.model)) {
    return;
  }
  if(isdefined(self.model.classname)) {
    if(common_scripts\utility::issp() && self.model.spawnflags & 1)
      self.model call[[level.connectpathsfunction]]();
  }

  if(level.createfx_enabled) {
    if(isdefined(self.exploded)) {
      return;
    }
    self.exploded = 1;

    if(isdefined(self.model) && isdefined(self.model.classname)) {
      self.model hide();
      self.model notsolid();
    }

    var_1 = getdvarint("createfx_exploder_waittime", 3);
    wait(var_1);
    self.exploded = undefined;

    if(isdefined(self.model) && isdefined(self.model.classname)) {
      self.model show();
      self.model solid();
    }

    return;
  }

  if(!isdefined(self.v["fxid"]) || self.v["fxid"] == "No FX")
    self.v["exploder"] = undefined;

  waittillframeend;

  if(isdefined(self.model) && isdefined(self.model.classname))
    self.model delete();
}

brush_throw() {
  if(isdefined(self.v["delay"]))
    wait(self.v["delay"]);

  var_0 = undefined;

  if(isdefined(self.v["target"]))
    var_0 = common_scripts\utility::get_target_ent(self.v["target"]);

  if(!isdefined(var_0)) {
    if(isdefined(self.model))
      self.model delete();

    return;
  }

  self.model show();

  if(isdefined(self.v["delay_post"]))
    wait(self.v["delay_post"]);

  var_1 = self.v["origin"];
  var_2 = self.v["angles"];
  var_3 = var_0.origin;
  var_4 = var_3 - self.v["origin"];
  var_5 = var_4[0];
  var_6 = var_4[1];
  var_7 = var_4[2];
  var_8 = isdefined(self.v["physics"]);

  if(var_8) {
    var_9 = undefined;

    if(isdefined(var_0.target))
      var_9 = var_0 common_scripts\utility::get_target_ent();

    if(!isdefined(var_9)) {
      var_10 = var_1;
      var_11 = var_0.origin;
    } else {
      var_10 = var_0.origin;
      var_11 = (var_9.origin - var_0.origin) * self.v["physics"];
    }

    self.model physicslaunchclient(var_10, var_11);
    return;
  } else {
    self.model rotatevelocity((var_5, var_6, var_7), 12);
    self.model movegravity((var_5, var_6, var_7), 12);
  }

  if(level.createfx_enabled) {
    if(isdefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    var_12 = getdvarint("createfx_exploder_waittime", 3);
    wait(var_12);
    self.exploded = undefined;
    self.v["origin"] = var_1;
    self.v["angles"] = var_2;
    self.model hide();
    return;
  }

  self.v["exploder"] = undefined;
  wait 6;

  if(isdefined(self.model))
    self.model delete();
}

brush_show() {
  if(isdefined(self.v["delay"]))
    wait(self.v["delay"]);

  if(!isdefined(self.model.script_modelname)) {
    self.model show();
    self.model solid();
  } else {
    var_0 = self.model common_scripts\utility::spawn_tag_origin();

    if(isdefined(self.model.script_linkname))
      var_0.script_linkname = self.model.script_linkname;

    var_0 setmodel(self.model.script_modelname);
    var_0 show();
  }

  self.brush_shown = 1;

  if(common_scripts\utility::issp() && !isdefined(self.model.script_modelname) && self.model.spawnflags & 1) {
    if(!isdefined(self.model.disconnect_paths))
      self.model call[[level.connectpathsfunction]]();
    else
      self.model call[[level.disconnectpathsfunction]]();
  }

  if(level.createfx_enabled) {
    if(isdefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    var_1 = getdvarint("createfx_exploder_waittime", 3);
    wait(var_1);
    self.exploded = undefined;

    if(!isdefined(self.model.script_modelname)) {
      self.model hide();
      self.model notsolid();
    }
  }
}

exploder_anim() {
  var_0 = self.model;
  var_0 show();
  var_0 solid();

  if(isdefined(var_0.spawnflags) && var_0.spawnflags & 1)
    var_0 connectpaths();

  var_0 notify("play_exploder_anim");
}

exploder_rumble() {
  if(!common_scripts\utility::issp()) {
    return;
  }
  exploder_delay();
  level.player playrumbleonentity(self.v["rumble"]);
}

exploder_delay() {
  if(!isdefined(self.v["delay"]))
    self.v["delay"] = 0;

  var_0 = self.v["delay"];
  var_1 = self.v["delay"] + 0.001;

  if(isdefined(self.v["delay_min"]))
    var_0 = self.v["delay_min"];

  if(isdefined(self.v["delay_max"]))
    var_1 = self.v["delay_max"];

  if(var_0 > 0)
    wait(randomfloatrange(var_0, var_1));
}

effect_loopsound() {
  if(isdefined(self.loopsound_ent))
    self.loopsound_ent delete();

  var_0 = self.v["origin"];
  var_1 = self.v["loopsound"];
  exploder_delay();
  self.loopsound_ent = common_scripts\utility::play_loopsound_in_space(var_1, var_0);
}

sound_effect() {
  effect_soundalias();
}

effect_soundalias() {
  var_0 = self.v["origin"];
  var_1 = self.v["soundalias"];
  exploder_delay();
  common_scripts\utility::play_sound_in_space(var_1, var_0);
}

exploder_earthquake() {
  exploder_delay();
  common_scripts\utility::do_earthquake(self.v["earthquake"], self.v["origin"]);
}

exploder_playsound() {
  if(!isdefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }
  common_scripts\utility::play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}

fire_effect() {
  var_0 = self.v["forward"];
  var_1 = self.v["up"];
  var_2 = undefined;
  var_3 = self.v["firefxsound"];
  var_4 = self.v["origin"];
  var_5 = self.v["firefx"];
  var_6 = self.v["ender"];

  if(!isdefined(var_6))
    var_6 = "createfx_effectStopper";

  var_7 = 0.5;

  if(isdefined(self.v["firefxdelay"]))
    var_7 = self.v["firefxdelay"];

  exploder_delay();

  if(isdefined(var_3))
    common_scripts\utility::loop_fx_sound_with_angles(var_3, var_4, (0, 0, 0), 1, var_6);

  playfx(level._effect[var_5], self.v["origin"], var_0, var_1);
}

cannon_effect() {
  if(isdefined(self.v["repeat"])) {
    thread exploder_playsound();

    for (var_0 = 0; var_0 < self.v["repeat"]; var_0++) {
      playfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      exploder_delay();
    }

    return;
  }

  if(!isdefined(self.v["delay"]))
    self.v["delay"] = 0;

  if(self.v["delay"] >= 0) {
    exploder_delay();
    var_1 = 0;
  } else
    var_1 = self.v["delay"];

  if(isdefined(self.v["cannon_spawn_func"]))
    self[[self.v["cannon_spawn_func"]]]();
  else
    cannon_spawnfx(var_1);

  exploder_playsound();
}

cannon_spawnfx(var_0) {
  if(isdefined(self.looper))
    self.looper delete();

  self.looper = spawnfx(common_scripts\utility::getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);

  if(level.createfx_enabled)
    setfxkillondelete(self.looper, 1);

  if(self.v["delay"] >= 0)
    triggerfx(self.looper);
  else
    triggerfx(self.looper, var_0);
}

activate_exploder(var_0, var_1, var_2) {
  var_0 = var_0 + "";
  level notify("exploding_" + var_0);
  var_3 = 0;

  if(isdefined(level.createfxexploders) && !level.createfx_enabled) {
    var_4 = level.createfxexploders[var_0];

    if(isdefined(var_4)) {
      foreach(var_6 in var_4) {
        if(!var_6 check_exploder_platform()) {
          continue;
        }
        var_6 common_scripts\utility::activate_individual_exploder();
        var_3 = 1;
      }
    }
  } else {
    for (var_8 = 0; var_8 < level.createfxent.size; var_8++) {
      var_6 = level.createfxent[var_8];

      if(!isdefined(var_6)) {
        continue;
      }
      if(var_6.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_6.v["exploder"])) {
        continue;
      }
      if(var_6.v["exploder"] + "" != var_0) {
        continue;
      }
      if(!var_6 check_exploder_platform()) {
        continue;
      }
      var_6 common_scripts\utility::activate_individual_exploder();
      var_3 = 1;
    }
  }

  if(!shouldrunserversideeffects() && !var_3)
    activate_clientside_exploder(var_0, var_1, var_2);
}

exploder(var_0, var_1, var_2) {
  [[level._fx.exploderfunction]](var_0, var_1, var_2);
}

kill_exploder(var_0) {
  var_1 = getexploders(var_0);

  if(isdefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isdefined(var_3.looper))
        setfxkillondelete(var_3.looper, 1);
    }

    waitframe();

    foreach(var_3 in var_1)
    var_3 common_scripts\utility::pauseeffect();
  }
}

check_exploder_platform() {
  var_0 = self;

  if(isdefined(var_0.v["platform"]) && isdefined(level.currentgen)) {
    var_1 = var_0.v["platform"];

    if(var_1 == "cg" && !level.currentgen || var_1 == "ng" && !level.nextgen)
      return 0;
  }

  return 1;
}

activate_clientside_exploder(var_0, var_1, var_2) {
  if(!is_valid_clientside_exploder_name(var_0)) {
    return;
  }
  var_3 = int(var_0);
  activateclientexploder(var_3, var_1, var_2);
}

deactivate_clientside_exploder(var_0, var_1, var_2) {
  if(!is_valid_clientside_exploder_name(var_0)) {
    return;
  }
  var_3 = int(var_0);
  stopclientexploder(var_3, var_1, var_2);
}

is_valid_clientside_exploder_name(var_0) {
  if(!isdefined(var_0))
    return 0;

  var_1 = var_0;

  if(isstring(var_0)) {
    var_1 = int(var_0);

    if(var_1 == 0 && var_0 != "0")
      return 0;
  }

  return var_1 >= 0;
}

shouldrunserversideeffects() {
  if(common_scripts\utility::issp())
    return 1;

  if(!isdefined(level.createfx_enabled))
    level.createfx_enabled = getdvar("createfx") != "";

  if(level.createfx_enabled)
    return 1;
  else
    return getdvar("clientSideEffects") != "1";
}

exploder_before_load(var_0, var_1, var_2) {
  waittillframeend;
  waittillframeend;
  activate_exploder(var_0, var_1, var_2);
}

exploder_after_load(var_0, var_1, var_2) {
  activate_exploder(var_0, var_1, var_2);
}