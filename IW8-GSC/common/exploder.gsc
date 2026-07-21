/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\exploder.gsc
***********************************************/

setup_individual_exploder(var_0) {
  var_1 = var_0.targetname;

  if(!isDefined(var_1))
    var_1 = "_encstr_B40101";

  if(exploder_starts_hidden(var_0)) {
    var_0 hide();
    return;
  }

  if(exploder_is_damaged_model(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1) {
      if(isDefined(var_0.script_disconnectpaths))
        var_0 connectpaths();
    }

    return;
  }

  if(exploder_is_chunk(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1)
      var_0 connectpaths();

    return;
  }
}

addinitexploders(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(isDefined(var_2.script_prefab_exploder)) {
      var_2.script_exploder = var_2.script_prefab_exploder;
      level.init_exploders[level.init_exploders.size] = var_2;
      continue;
    }

    if(isDefined(var_2.script_exploder)) {
      var_3 = 1;

      if(!isDefined(var_2.angles))
        var_2.angles = (0, 0, 0);

      level.init_exploders[level.init_exploders.size] = var_2;
    }
  }
}

removedeletableexploders(var_0) {
  foreach(var_3, var_2 in var_0) {
    if(isDefined(var_2.script_delete) && var_2.script_delete)
      level.struct[var_3] = undefined;
  }
}

setupexploders() {
  level.init_exploders = [];
  level.exploders = [];
  var_0 = getEntArray("_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C", "_encstr_AC110A7F14873B5B3D073009");
  var_1 = getEntArray("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_3 in var_1)
  var_0[var_0.size] = var_3;

  foreach(var_6 in var_0) {
    if(isDefined(var_6.script_prefab_exploder))
      var_6.script_exploder = var_6.script_prefab_exploder;

    if(isDefined(var_6.masked_exploder)) {
      continue;
    }
    if(isDefined(var_6.script_exploder))
      setup_individual_exploder(var_6);
  }

  addinitexploders(getEntArray("_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C", "_encstr_AC110A7F14873B5B3D073009"));
  addinitexploders(getEntArray("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_AC110A7F14873B5B3D073009"));
  addinitexploders(level.struct);

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  var_8 = [];
  var_8["_encstr_B1E916593CC136F68CAC9CC64357DCDA10B35ADC2D4C6356"] = 1;
  var_8["_encstr_87E80E56F083B1DB32CAE4C6D0579B5B"] = 1;
  var_8["_encstr_A63B09CA3CE01B7B8C2B27"] = 1;

  foreach(var_10 in level.init_exploders) {
    var_6 = scripts\engine\utility::createexploder(var_10.script_fxid, 1);
    var_6.v = [];
    var_6.v["_encstr_97FE07DE392D76D2CD"] = var_10.origin;
    var_6.v["_encstr_A7610758E6CED8569B"] = var_10.angles;
    var_6.v["_encstr_96750613A808E91B"] = var_10.script_delay;
    var_6.v["_encstr_A6380BC8B2D858CBEB83F6E6A3"] = var_10.script_delay_post;
    var_6.v["_encstr_BAD107D5718A383CEB"] = var_10.script_firefx;
    var_6.v["_encstr_A6450CCCD29CACCCC391B2B1C2CB"] = var_10.script_firefxdelay;
    var_6.v["_encstr_B2500CF0E3F86547115B3A4F2D8F"] = var_10.script_firefxsound;
    var_6.v["_encstr_97F90B95B04EA343E2ABC25B95"] = var_10.script_earthquake;
    var_6.v["_encstr_816E079685517D0975"] = var_10.script_rumble;
    var_6.v["_encstr_B2BE0788BAF573592F"] = var_10.script_damage;
    var_6.v["_encstr_A36A0EBC6778571703399BA28873CB47"] = var_10.script_radius;
    var_6.v["_encstr_8D760BA3EF33C54D42B1B4A19B"] = var_10.script_soundalias;
    var_6.v["_encstr_826407935938AC161D"] = var_10.script_repeat;
    var_6.v["_encstr_AB9A0AC80DCBE9A137FDD988"] = var_10.script_delay_min;
    var_6.v["_encstr_A59A0AB1672C48FBB9E79B91"] = var_10.script_delay_max;
    var_6.v["_encstr_A16007A921A23B85E3"] = var_10.target;
    var_6.v["_encstr_82BE06497D8CC0D6"] = var_10.script_ender;
    var_6.v["_encstr_93EB086BE882C3227F06"] = var_10.script_physics;
    var_6.v["_encstr_81EF05D197C12B"] = "_encstr_A63B09CA3CE01B7B8C2B27";
    var_6.v["_encstr_B49409B1CAEB0E38F64DC7"] = var_10.script_trace;
    var_6.v["_encstr_979208AB0EC32060E3DB"] = var_10.script_envonly;

    if(!isDefined(var_6.v["_encstr_A7610758E6CED8569B"]))
      var_6.v["_encstr_A7610758E6CED8569B"] = (0, 0, 0);

    var_6 scripts\common\createfx::set_forward_and_up_vectors();

    if(!isDefined(var_10.script_fxid))
      var_6.v["_encstr_95780526F31FA7"] = "_encstr_A67306780FE2ADD9";
    else
      var_6.v["_encstr_95780526F31FA7"] = var_10.script_fxid;

    var_6.v["_encstr_A63B09CA3CE01B7B8C2B27"] = var_10.script_exploder;

    if(!isDefined(var_6.v["_encstr_96750613A808E91B"]))
      var_6.v["_encstr_96750613A808E91B"] = 0;

    if(isDefined(var_10.target)) {
      var_11 = getEntArray(var_6.v["_encstr_A16007A921A23B85E3"], "_encstr_B2CE0BA1D0FB19FDC54613D9BF")[0];

      if(isDefined(var_11)) {
        var_12 = var_11.origin;
        var_6.v["_encstr_A7610758E6CED8569B"] = vectortoangles(var_12 - var_6.v["_encstr_97FE07DE392D76D2CD"]);
      } else {
        var_11 = scripts\engine\utility::get_target_ent(var_6.v["_encstr_A16007A921A23B85E3"]);

        if(isDefined(var_11)) {
          var_12 = var_11.origin;
          var_6.v["_encstr_A7610758E6CED8569B"] = vectortoangles(var_12 - var_6.v["_encstr_97FE07DE392D76D2CD"]);
        }
      }
    }

    if(isstruct(var_10)) {
      var_6.model = var_10;

      if(isDefined(var_6.model.script_modelname))
        precachemodel(var_6.model.script_modelname);
    } else if(var_10.code_classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C" || isDefined(var_10.model)) {
      var_6.model = var_10;
      var_6.model.disconnect_paths = var_10.script_disconnectpaths;
    }

    if(isDefined(var_10.targetname) && isDefined(var_8[var_10.targetname]))
      var_6.v["_encstr_81470E2588617828C789CD1F8B8A438A"] = var_10.targetname;
    else
      var_6.v["_encstr_81470E2588617828C789CD1F8B8A438A"] = "_encstr_820E07FAE8780B3A4C";

    if(isDefined(var_10.masked_exploder)) {
      var_6.v["_encstr_862810A06E5FD3577AF1607A50E80ACD658A"] = var_10.model;
      var_6.v["_encstr_95611B5BB06E6D9546EB56C33836DE46CA39BE371C58DD9B33C65876DC"] = var_10.spawnflags;
      var_6.v["_encstr_857B27D7680B033AB9D82798B74152D41158A727E0434933A1F06FD41E072A96D818DFA31099AC7AC7"] = var_10.script_disconnectpaths;
      var_10 delete();
    }

    var_6 scripts\common\createfx::post_entity_creation_function();
    var_13 = var_6.v["_encstr_A63B09CA3CE01B7B8C2B27"];

    if(!isDefined(level.exploders[var_13]))
      level.exploders[var_13] = [];

    level.exploders[var_13][level.exploders[var_13].size] = var_6;
  }

  level.init_exploders = undefined;
  removedeletableexploders(level.struct);
}

exploder_flag_wait(var_0, var_1) {
  if(!scripts\engine\utility::flag_exist(var_0))
    scripts\engine\utility::flag_init(var_0);

  scripts\engine\utility::flag_wait(var_0);

  foreach(var_3 in var_1) {
    foreach(var_5 in level.createfxexploders[var_3])
    var_5 scripts\engine\utility::activate_individual_exploder();
  }
}

exploder_is_damaged_model(var_0) {
  return isDefined(var_0.targetname) && var_0.targetname == "_encstr_A63B09CA3CE01B7B8C2B27";
}

exploder_starts_hidden(var_0) {
  return var_0.model == "_encstr_840703F23B" && (!isDefined(var_0.targetname) || var_0.targetname != "_encstr_87E80E56F083B1DB32CAE4C6D0579B5B");
}

exploder_is_chunk(var_0) {
  return isDefined(var_0.targetname) && var_0.targetname == "_encstr_87E80E56F083B1DB32CAE4C6D0579B5B";
}

show_exploder_models_proc(var_0) {
  var_0 = var_0 + "_encstr_B40101";
  var_1 = get_exploders();

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isstruct(var_3.model)) {
        continue;
      }
      if(!exploder_starts_hidden(var_3.model) && !exploder_is_damaged_model(var_3.model) && !exploder_is_chunk(var_3.model))
        var_3.model show();

      if(isDefined(var_3.brush_shown))
        var_3.model show();
    }
  }
}

get_exploders(var_0) {
  var_1 = [];

  if(level.createfx_enabled)
    var_1 = get_createfx_exploders(var_0);
  else if(isDefined(level.createfxexploders[var_0]))
    var_1 = level.createfxexploders[var_0];

  if(isDefined(level.exploders[var_0])) {
    foreach(var_3 in level.exploders[var_0])
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

get_createfx_exploders(var_0) {}

stop_exploder_proc(var_0, var_1, var_2) {
  var_0 = var_0 + "_encstr_B40101";
  var_3 = 0;
  var_4 = get_exploders(var_0);

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(!isDefined(var_6.looper)) {
        continue;
      }
      if(isDefined(var_6.loopsound_ent)) {
        var_6.loopsound_ent stoploopsound();
        var_6.loopsound_ent delete();
      }

      var_6.looper delete();
      var_3 = 1;
    }
  }

  if(!shouldrunserversideeffects() && (isplatformconsole() || !var_3))
    stop_clientside_exploder(var_0, var_1, var_2);
}

stop_clientside_exploder(var_0, var_1, var_2) {
  if(isplatformconsole()) {
    loadinfiltransient(var_0, var_1, var_2);
    return;
  }

  if(!is_valid_clientside_exploder_name(var_0)) {
    return;
  }
  var_3 = int(var_0);
  loadinfiltransient(var_3, var_1, var_2);
}

get_exploder_array_proc(var_0) {
  var_0 = var_0 + "_encstr_B40101";
  var_1 = [];
  var_2 = get_exploders(var_0);

  if(isDefined(var_2))
    var_1 = var_2;

  return var_1;
}

hide_exploder_models_proc(var_0) {
  var_0 = var_0 + "_encstr_B40101";
  var_1 = get_exploders(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isstruct(var_3.model)) {
        continue;
      }
      if(isDefined(var_3.model))
        var_3.model hide();
    }
  }
}

delete_exploder_proc(var_0) {
  var_0 = var_0 + "_encstr_B40101";
  var_1 = get_exploders(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isstruct(var_3.model)) {
        continue;
      }
      if(isDefined(var_3.model))
        var_3.model delete();
    }
  }

  level notify("_encstr_A52E1530D025BD154BEF787201EFEBED9DC0687C2B5372" + var_0);
}

exploder_damage() {
  if(isDefined(self.v["_encstr_96750613A808E91B"]))
    var_0 = self.v["_encstr_96750613A808E91B"];
  else
    var_0 = 0;

  if(isDefined(self.v["_encstr_A36A0EBC6778571703399BA28873CB47"]))
    var_1 = self.v["_encstr_A36A0EBC6778571703399BA28873CB47"];
  else
    var_1 = 128;

  var_2 = self.v["_encstr_B2BE0788BAF573592F"];
  var_3 = self.v["_encstr_97FE07DE392D76D2CD"];

  if(isDefined(self.v["_encstr_979208AB0EC32060E3DB"]))
    var_4 = self.v["_encstr_979208AB0EC32060E3DB"];
  else
    var_4 = 0;

  if(isDefined(self.v["_encstr_B49409B1CAEB0E38F64DC7"]))
    var_5 = self.v["_encstr_B49409B1CAEB0E38F64DC7"];
  else
    var_5 = 1;

  wait(var_0);
  radiusdamage(var_3, var_1, var_2, var_2, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", undefined, var_4, var_5);
}

activate_individual_exploder_proc() {
  if(isDefined(self.v["_encstr_BAD107D5718A383CEB"]))
    thread fire_effect();

  if(isDefined(self.v["_encstr_95780526F31FA7"]) && self.v["_encstr_95780526F31FA7"] != "_encstr_A67306780FE2ADD9")
    thread cannon_effect();
  else if(isDefined(self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"]) && self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"] != "_encstr_BA19049E7739")
    thread sound_effect();

  if(isDefined(self.v["_encstr_A7DC0A731F08BBCBC8033D87"]) && self.v["_encstr_A7DC0A731F08BBCBC8033D87"] != "_encstr_BA19049E7739")
    thread effect_loopsound();

  if(isDefined(self.v["_encstr_B2BE0788BAF573592F"]))
    thread exploder_damage();

  if(isDefined(self.v["_encstr_97F90B95B04EA343E2ABC25B95"]))
    thread exploder_earthquake();

  if(isDefined(self.v["_encstr_816E079685517D0975"]))
    thread exploder_rumble();

  if(self.v["_encstr_81470E2588617828C789CD1F8B8A438A"] == "_encstr_A63B09CA3CE01B7B8C2B27")
    thread brush_show();
  else if(self.v["_encstr_81470E2588617828C789CD1F8B8A438A"] == "_encstr_87E80E56F083B1DB32CAE4C6D0579B5B" || self.v["_encstr_81470E2588617828C789CD1F8B8A438A"] == "_encstr_B1E916593CC136F68CAC9CC64357DCDA10B35ADC2D4C6356")
    thread brush_throw();
  else
    thread brush_delete();
}

brush_delete() {
  var_0 = self.v["_encstr_A63B09CA3CE01B7B8C2B27"];

  if(isDefined(self.v["_encstr_96750613A808E91B"]))
    wait(self.v["_encstr_96750613A808E91B"]);
  else
    waitframe();

  if(!isDefined(self.model)) {
    return;
  }
  if(isstruct(self.model)) {
    return;
  }
  if(scripts\common\utility::issp() && isDefined(self.model.classname)) {
    if(self.model.spawnflags & 1)
      self.model call[[level.func["_encstr_B4A50D583AB837D53F1387E2241B48"]]]();
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

  if(!isDefined(self.v["_encstr_95780526F31FA7"]) || self.v["_encstr_95780526F31FA7"] == "_encstr_A67306780FE2ADD9")
    self.v["_encstr_A63B09CA3CE01B7B8C2B27"] = undefined;

  waittillframeend;
  self.model delete();
}

brush_throw() {
  if(isDefined(self.v["_encstr_96750613A808E91B"]))
    wait(self.v["_encstr_96750613A808E91B"]);

  var_0 = undefined;

  if(isDefined(self.v["_encstr_A16007A921A23B85E3"]))
    var_0 = scripts\engine\utility::get_target_ent(self.v["_encstr_A16007A921A23B85E3"]);

  if(!isDefined(var_0)) {
    self.model delete();
    return;
  }

  self.model show();

  if(isDefined(self.v["_encstr_A6380BC8B2D858CBEB83F6E6A3"]))
    wait(self.v["_encstr_A6380BC8B2D858CBEB83F6E6A3"]);

  var_1 = self.v["_encstr_97FE07DE392D76D2CD"];
  var_2 = self.v["_encstr_A7610758E6CED8569B"];
  var_3 = var_0.origin;
  var_4 = isDefined(self.v["_encstr_93EB086BE882C3227F06"]);

  if(var_4) {
    var_5 = undefined;

    if(isDefined(var_0.target))
      var_5 = var_0 scripts\engine\utility::get_target_ent();

    if(isDefined(var_5)) {
      var_6 = var_0.origin;
      var_7 = vectorNormalize(var_5.origin - var_0.origin);
    } else {
      var_6 = self.model.origin;
      var_7 = vectorNormalize(var_3 - self.model.origin);
    }

    var_7 = var_7 * self.v["_encstr_93EB086BE882C3227F06"];
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
    self.v["_encstr_97FE07DE392D76D2CD"] = var_1;
    self.v["_encstr_A7610758E6CED8569B"] = var_2;
    self.model hide();
    return;
  }

  self.v["_encstr_A63B09CA3CE01B7B8C2B27"] = undefined;
  wait 6;
  self.model delete();
}

brush_show() {
  if(isDefined(self.v["_encstr_96750613A808E91B"]))
    wait(self.v["_encstr_96750613A808E91B"]);

  var_0 = 0;
  var_1 = undefined;

  if(!isDefined(self.model.script_modelname)) {
    self.model show();
    self.model solid();
  } else {
    var_0 = 1;
    var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.model.origin);
    var_1.angles = self.model.angles;
    var_1 setModel(self.model.script_modelname);

    if(isDefined(self.model.script_linkname))
      var_1.script_linkname = self.model.script_linkname;
  }

  self.brush_shown = 1;

  if(!var_0 && scripts\common\utility::issp() && self.model.spawnflags & 1) {
    if(!isDefined(self.model.disconnect_paths))
      self.model call[[level.func["_encstr_B4A50D583AB837D53F1387E2241B48"]]]();
    else
      self.model call[[level.func["_encstr_B41C1023A59BC67BB99B2B8D4705581D1ADC"]]]();
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    wait 3;
    self.exploded = undefined;

    if(!var_0) {
      self.model hide();
      self.model notsolid();
    } else
      var_1 delete();
  }
}

exploder_rumble() {
  if(!scripts\common\utility::issp()) {
    return;
  }
  exploder_delay();
  level.player playRumbleOnEntity(self.v["_encstr_816E079685517D0975"]);
}

exploder_delay() {
  if(!isDefined(self.v["_encstr_96750613A808E91B"]))
    self.v["_encstr_96750613A808E91B"] = 0;

  var_0 = self.v["_encstr_96750613A808E91B"];
  var_1 = self.v["_encstr_96750613A808E91B"] + 0.001;

  if(isDefined(self.v["_encstr_AB9A0AC80DCBE9A137FDD988"]))
    var_0 = self.v["_encstr_AB9A0AC80DCBE9A137FDD988"];

  if(isDefined(self.v["_encstr_A59A0AB1672C48FBB9E79B91"]))
    var_1 = self.v["_encstr_A59A0AB1672C48FBB9E79B91"];

  if(var_0 > 0)
    wait(randomfloatrange(var_0, var_1));
}

effect_loopsound() {
  if(isDefined(self.loopsound_ent)) {
    self.loopsound_ent stoploopsound();
    self.loopsound_ent delete();
  }

  var_0 = self.v["_encstr_97FE07DE392D76D2CD"];
  var_1 = self.v["_encstr_A7DC0A731F08BBCBC8033D87"];
  exploder_delay();
  self.loopsound_ent = scripts\engine\utility::play_loopsound_in_space(var_1, var_0);
}

sound_effect() {
  effect_soundalias();
}

effect_soundalias() {
  var_0 = self.v["_encstr_97FE07DE392D76D2CD"];
  var_1 = self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"];
  exploder_delay();
  scripts\engine\utility::play_sound_in_space(var_1, var_0);
}

exploder_earthquake() {
  exploder_delay();
  scripts\engine\utility::do_earthquake(self.v["_encstr_97F90B95B04EA343E2ABC25B95"], self.v["_encstr_97FE07DE392D76D2CD"]);
}

exploder_playSound() {
  if(!isDefined(self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"]) || self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"] == "_encstr_BA19049E7739") {
    return;
  }
  scripts\engine\utility::play_sound_in_space(self.v["_encstr_8D760BA3EF33C54D42B1B4A19B"], self.v["_encstr_97FE07DE392D76D2CD"]);
}

fire_effect() {
  var_0 = self.v["_encstr_B42E085325A82CB3F221"];
  var_1 = self.v["_encstr_87070365F7"];
  var_2 = undefined;
  var_3 = self.v["_encstr_B2500CF0E3F86547115B3A4F2D8F"];
  var_4 = self.v["_encstr_97FE07DE392D76D2CD"];
  var_5 = self.v["_encstr_BAD107D5718A383CEB"];
  var_6 = self.v["_encstr_82BE06497D8CC0D6"];

  if(!isDefined(var_6))
    var_6 = "_encstr_BD86178D9CCA2C47B2333CFAAC99CCCAB13AD4A3BD1C0E2BE4";

  var_7 = 0.5;

  if(isDefined(self.v["_encstr_A6450CCCD29CACCCC391B2B1C2CB"]))
    var_7 = self.v["_encstr_A6450CCCD29CACCCC391B2B1C2CB"];

  exploder_delay();

  if(isDefined(var_3))
    scripts\engine\utility::loop_fx_sound(var_3, var_4, 1, var_6);

  playFX(level._effect[var_5], self.v["_encstr_97FE07DE392D76D2CD"], var_0, var_1);
}

cannon_effect() {
  if(isDefined(self.v["_encstr_826407935938AC161D"])) {
    thread exploder_playSound();

    for(var_0 = 0; var_0 < self.v["_encstr_826407935938AC161D"]; var_0++) {
      playFX(level._effect[self.v["_encstr_95780526F31FA7"]], self.v["_encstr_97FE07DE392D76D2CD"], self.v["_encstr_B42E085325A82CB3F221"], self.v["_encstr_87070365F7"]);
      exploder_delay();
    }

    return;
  }

  exploder_delay();

  if(isDefined(self.looper))
    self.looper delete();

  self.looper = spawnfx(scripts\engine\utility::getfx(self.v["_encstr_95780526F31FA7"]), self.v["_encstr_97FE07DE392D76D2CD"], self.v["_encstr_B42E085325A82CB3F221"], self.v["_encstr_87070365F7"]);
  triggerfx(self.looper);
  exploder_playSound();
}

activate_exploder(var_0, var_1, var_2) {
  var_0 = var_0 + "_encstr_B40101";
  level notify("_encstr_8C740B6732B854C21DFB9B87AF" + var_0);
  var_3 = 0;
  var_4 = get_exploders(var_0);

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      var_6 scripts\engine\utility::activate_individual_exploder();
      var_3 = 1;
    }
  }

  if(!shouldrunserversideeffects() && (isplatformconsole() || !var_3))
    activate_clientside_exploder(var_0, var_1, var_2);
}

activate_clientside_exploder(var_0, var_1, var_2) {
  if(isplatformconsole()) {
    activateclientexploder(var_0, var_1, var_2);
    return;
  }

  if(!is_valid_clientside_exploder_name(var_0)) {
    return;
  }
  var_3 = int(var_0);
  activateclientexploder(var_3, var_1, var_2);
}

is_valid_clientside_exploder_name(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = var_0;

  if(isstring(var_0)) {
    var_1 = int(var_0);

    if(var_1 == 0 && var_0 != "_encstr_934C0218")
      return 0;
  }

  return var_1 >= 0;
}

shouldrunserversideeffects() {
  if(scripts\common\utility::issp() && !isplatformconsole())
    return 1;

  if(!isDefined(level.createfx_enabled))
    scripts\engine\utility::set_createfx_enabled();

  if(level.createfx_enabled)
    return 1;
  else
    return getDvar("_encstr_AB960B911A474C8A3CDCFF0FC9") != "_encstr_A34C02BB";
}

exploder_before_load(var_0, var_1, var_2) {
  waittillframeend;
  waittillframeend;
  activate_exploder(var_0, var_1, var_2);
}

exploder_after_load(var_0, var_1, var_2) {
  activate_exploder(var_0, var_1, var_2);
}