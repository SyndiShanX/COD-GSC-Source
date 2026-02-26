/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1162c195eb8dd834.gsc
***********************************************/

#using script_71527a5629b857da;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace smart_bundle;

function sb_flags() {
  flag::init("sb_reset_all");
}

function function_b904b36d() {
  self.var_60b8c535 = gettime();

  self.var_84410238 = struct::get_array("smart_bundle", "script_noteworthy");
  self.var_84410238 = arraycombine(self.var_84410238, struct::get_array("smart_bundle", "variantname"), 0, 0);

  level.smart_bundle.setup_debug = getdvarint(#"hash_2df1d55877e98127", 0);

  if(is_true(level.smart_bundle.setup_debug)) {
    self.var_d4a6710d = [];
    self.var_d4a6710d[#"hash_4bb619fee6f7679e"] = [];

    for(i = 0; i < self.var_84410238.size; i++) {
      if(isDefined(self.var_84410238[i].targetname)) {
        if(!isDefined(self.var_d4a6710d[self.var_84410238[i].targetname])) {
          self.var_d4a6710d[self.var_84410238[i].targetname] = [];
        }

        self.var_d4a6710d[self.var_84410238[i].targetname][self.var_d4a6710d[self.var_84410238[i].targetname].size] = self.var_84410238[i];
        continue;
      }

      self.var_d4a6710d[#"hash_4bb619fee6f7679e"][self.var_d4a6710d[#"hash_4bb619fee6f7679e"].size] = self.var_84410238[i];
    }
  }

  self.var_99772156 = [];
  self function_32f64450();

  for(i = 0; i < self.var_84410238.size; i++) {
    self.var_84410238[i] function_8eabba5();
    self.var_84410238[i] thread function_d199bc6b();
  }

  self.var_770cd5ec = gettime();
  self.var_4eb8c8f6 = (self.var_770cd5ec - self.var_60b8c535) / 1000;

  if(is_true(level.smart_bundle.setup_debug)) {
    self thread function_491e6cbe();
  }
}

function function_bda27289() {
  var_c210334b = [];

  for(i = 0; i < self.var_146f1420.size; i++) {
    if(isspawner(self.var_146f1420[i])) {
      self.spawner_ents[self.spawner_ents.size] = self.var_146f1420[i];
      continue;
    }

    var_c210334b[var_c210334b.size] = self.var_146f1420[i];
  }

  if(self.spawner_ents.size) {
    self.var_146f1420 = var_c210334b;
  }
}

function function_8eabba5() {
  self.var_39a8d200 = "initializing";
  self.var_146f1420 = self util::get_linked_ents();
  self.smart_models = [];
  self.var_4961c57a = self function_7f8ba812();
  self.dynamic_ents = [];
  self.weapon_ents = [];
  self.var_435fd319 = [];
  self.fn_callbacks = [];
  self.spawner_ents = [];
  self.var_468b39b = 0;
  self function_459301ea();
  self function_7d6d474a();
  function_bda27289();
  function_9a3f951a(1);
  function_49ff1123();
  self.var_2b96e535 = 1;

  if(!(isDefined(self.variantname) && self.variantname == "smart_bundle")) {
    if(isDefined(self.script_parameters)) {
      values = strtok(self.script_parameters, " ");

      foreach(value in values) {
        switch (value) {
          case # "permanent":
            self.permanent = 1;
            break;
          case # "start_active":
            self.start_active = 1;
            break;
          case # "hash_4ce8ffa2208104d1":
            self.var_8c524d0b = 1;
            break;
          case # "hash_6bc7f996db1c551e":
            self.var_43db0d3e = 1;
            break;
          default:

            iprintln("<dev string:x38>" + value);

            break;
        }
      }
    }
  }

  if(is_true(self.var_8c524d0b)) {
    if(isDefined(self.targetname)) {
      if(!isDefined(self.script_flag_true)) {
        self.script_flag_true = "";
      }

      self.script_flag_true = self.script_flag_true + " " + self.targetname + "_flag_true";
      self.var_38a97b32 = self.targetname + "_flag_true";
    } else {
      iprintln("<dev string:x5b>" + self.origin + "<dev string:x76>");
    }
  }

  if(isDefined(self.script_flag_true)) {
    self.var_12b42a5c = create_flags_and_return_tokens(self.script_flag_true);
  }

  if(isDefined(self.script_flag_false)) {
    self.var_67f376ee = create_flags_and_return_tokens(self.script_flag_false);
  }

  if(is_true(level.smart_bundle.setup_debug)) {
    self.var_a0bbcf82 = 0;

    foreach(ent in self.spawner_ents) {
      if(!isDefined(ent.vehicletype)) {
        self.var_a0bbcf82 = 1;
        break;
      }
    }
  }
}

function function_7d6d474a() {
  a_s_targets = self.var_4961c57a;

  foreach(s_target in a_s_targets) {
    if(s_target scene::function_9503138e()) {
      self.var_468b39b = 1;
      self.scene_name = s_target.scriptbundlename;
      return;
    }
  }
}

function function_d199bc6b() {
  self endon(#"death");
  self endon(#"hash_259aadae63b5fba0");

  if(!isDefined(self.script_flag_true) && !isDefined(self.script_flag_false)) {
    iprintlnbold("<dev string:x9e>" + self.origin + "<dev string:xb2>");

    return;
  }

  if(is_true(level.smart_bundle.setup_debug)) {
    self thread function_a6298abd();
  }

  while(true) {
    self.var_39a8d200 = "wait_activate";
    self notify(self.var_39a8d200);

    if(!is_true(function_c8d0e6e())) {
      self function_e4a02f4e();
    }

    self.var_39a8d200 = "constructing";
    self notify(self.var_39a8d200);

    if(!is_true(function_c8d0e6e())) {
      function_4cc8ffdb();
    }

    self.var_39a8d200 = "active";
    self notify(self.var_39a8d200);

    if(!is_true(function_c8d0e6e())) {
      self function_3fad8c3b();
    }

    if(is_true(self.permanent)) {
      break;
    }

    self.var_39a8d200 = "wait_deactivate";
    self notify(self.var_39a8d200);

    if(!is_true(function_c8d0e6e())) {
      function_7b8674fb();
    }

    self.var_39a8d200 = "destructing";
    self notify(self.var_39a8d200);

    if(!is_true(function_c8d0e6e())) {
      self function_cd166c09();
    }
  }
}

function function_e4a02f4e() {
  if(is_true(self.start_active)) {
    self.start_active = undefined;
    return;
  }

  self.var_b5f8363 = undefined;

  while(true) {
    time_check = gettime();

    if(isDefined(self.var_12b42a5c)) {
      self function_48b43844(self.var_12b42a5c, 1);
    }

    if(isDefined(self.var_67f376ee)) {
      self function_48b43844(self.var_67f376ee, 0);
    }

    if(isDefined(self.radius)) {
      dist = distance(self.origin, level.player getorigin()) - self.radius;

      if(dist > 0) {
        dist /= 320;
        dist = math::clamp(dist, 0.05, 2);

        debug_radius(dist);

        wait dist;
      }
    }

    if(time_check == gettime()) {
      break;
    }
  }
}

function function_4cc8ffdb() {
  if(isDefined(self.var_623ac581)) {
    if(!is_true([[self.var_623ac581]]())) {
      return;
    }
  }

  function_30c324b5();
  function_f2f249d();
  function_12a6420e();
  function_3ccd66c3();

  if(self.var_468b39b) {
    thread function_bc78de5d();
  } else if(self.spawner_ents.size) {
    function_30e5290f();
  }

  thread function_40af2aa3();
}

function function_3fad8c3b() {
  return true;
}

function function_7b8674fb() {
  self endon(#"despawn");
  self function_f3d46509(1);
}

function function_cd166c09() {
  self notify(#"hash_740faf03c1eeca5b");
  function_1ae872f3();
  function_9a3f951a();
  function_729e9efe();
  function_2c8d3c01();

  if(isDefined(self.var_60efc9d0)) {
    for(i = self.var_60efc9d0.size - 1; i >= 0; i--) {
      if(isalive(self.var_60efc9d0[i])) {
        self.var_60efc9d0[i] delete();
      }
    }

    self.var_60efc9d0 = undefined;
  }

  if(self.dynamic_ents.size) {
    for(i = 0; i < self.dynamic_ents.size; i++) {
      if(isDefined(self.dynamic_ents[i])) {
        self.dynamic_ents[i] delete();
      }
    }
  }

  self.dynamic_ents = [];
  function_389d0cb3();
}

function function_30c324b5() {
  if(self.smart_models.size == 0) {
    return;
  }

  self.var_454745b9 = [];

  foreach(sm in self.smart_models) {
    var_75026f76 = util::spawn_model(sm.model, sm.origin, sm.angles, 0, 1);

    if(isDefined(sm.linkname)) {
      var_75026f76.linkname = sm.linkname;
    }

    if(isDefined(sm.targetname)) {
      var_75026f76.targetname = sm.targetname;
    }

    if(isDefined(sm.script_noteworthy)) {
      var_75026f76.script_noteworthy = sm.script_noteworthy;
    }

    if(isDefined(sm.script_parameters)) {
      var_75026f76.script_parameters = sm.script_parameters;
    }

    if(isDefined(sm.modelscale)) {
      if(isstring(sm.modelscale)) {
        sm.modelscale = float(sm.modelscale);
      }

      var_75026f76 setscale(sm.modelscale);
    }

    self.var_454745b9[self.var_454745b9.size] = var_75026f76;
  }

  waittillframeend();
  self notify(#"hash_2c5cc8d3d6ed8b34");
}

function function_1ae872f3() {
  if(isDefined(self.var_454745b9)) {
    array::delete_all(self.var_454745b9);
    self.var_454745b9 = undefined;
  }
}

function function_9a3f951a(first_init) {
  for(i = 0; i < self.var_146f1420.size; i++) {
    if(self.var_146f1420[i].classname == "script_model" || self.var_146f1420[i].classname == "script_brushmodel") {
      self function_dd63e599(self.var_146f1420[i]);
    } else if(strstartswith(self.var_146f1420[i].classname, "light")) {
      self function_dd3b5896(self.var_146f1420[i]);
    }

    if(!((i + 1) % 20)) {
      waitframe(1);
    }
  }

  if(i > 20) {
    name = "<dev string:x10f>";

    if(isDefined(self.targetname)) {
      name = self.targetname;
    }

    iprintln(i + "<dev string:x11a>" + name);
  }
}

function function_f2f249d() {
  for(i = 0; i < self.var_146f1420.size; i++) {
    if(self.var_146f1420[i].classname == "script_model" || self.var_146f1420[i].classname == "script_brushmodel") {
      if(isDefined(self.var_146f1420[i].var_12b42a5c) || isDefined(self.var_146f1420[i].var_67f376ee)) {
        self thread function_46173073(self.var_146f1420[i]);
      } else {
        self function_f91a4fac(self.var_146f1420[i]);
      }

      continue;
    }

    if(strstartswith(self.var_146f1420[i].classname, "light")) {
      self function_7f992074(self.var_146f1420[i]);
    }
  }
}

function function_dd63e599(script_model) {
  script_model hide_notsolid();

  if(script_model.classname == "script_brushmodel") {
    script_model connectpaths();
  }
}

function function_f91a4fac(script_model) {
  script_model show_solid();

  if(script_model.classname == "script_brushmodel") {
    script_model disconnectpaths();
  }
}

function hide_notsolid() {
  self hide();
  self notsolid();
}

function show_solid() {
  self show();
  self solid();
}

function function_46173073(script_model) {
  self endon(#"hash_740faf03c1eeca5b");
  script_model endon(#"death");

  while(true) {
    if(isDefined(script_model.var_67f376ee)) {
      script_model function_48b43844(script_model.var_67f376ee, 0);
    }

    if(isDefined(script_model.var_12b42a5c)) {
      script_model function_48b43844(script_model.var_12b42a5c, 1);
    }

    self function_f91a4fac(script_model);

    if(isDefined(script_model.var_67f376ee)) {
      script_model function_7022dcf2(script_model.var_67f376ee, 1);
    }

    if(isDefined(script_model.var_12b42a5c)) {
      script_model function_7022dcf2(script_model.var_12b42a5c, 0);
    }

    self function_dd63e599(script_model);
  }
}

function function_dd3b5896(light) {
  if(!isDefined(light.default_intensity)) {
    light.default_intensity = light getlightintensity();
  }

  light setlightintensity(0);
}

function function_7f992074(light) {
  intensity = 2;

  if(isDefined(light.default_intensity)) {
    intensity = light.default_intensity;
  }

  if(isDefined(light.script_intensity)) {
    intensity = light.script_intensity;
  }

  light setlightintensity(intensity);
}

function function_3ccd66c3() {
  if(isDefined(self.script_exploder_radiant)) {
    activateclientradiantexploder(self.script_exploder_radiant);
  }
}

function function_2c8d3c01() {
  if(isDefined(self.script_exploder_radiant)) {
    deactivateclientradiantexploder(self.script_exploder_radiant);
  }
}

function function_32f64450() {
  weapons = [];
  entities = getEntArray();

  for(i = 0; i < entities.size; i++) {
    if(!isDefined(entities[i].classname)) {
      continue;
    }

    if(strstartswith(entities[i].classname, "weapon_") && isDefined(entities[i].targetname)) {
      if(!isDefined(self.var_99772156[entities[i].targetname])) {
        self.var_99772156[entities[i].targetname] = [];
      }

      self.var_99772156[entities[i].targetname][self.var_99772156[entities[i].targetname].size] = entities[i];

      if(isDefined(level.smart_bundle.var_d4a6710d[entities[i].targetname]) && level.smart_bundle.var_d4a6710d[entities[i].targetname].size > 1) {
        iprintlnbold("<dev string:x144>" + entities[i].targetname + "<dev string:x1d6>");
      }
    }
  }
}

function function_49ff1123() {
  if(!isDefined(self.targetname)) {
    return;
  }

  if(isDefined(level.smart_bundle.var_99772156[self.targetname])) {
    foreach(weapon in level.smart_bundle.var_99772156[self.targetname]) {
      if(isDefined(weapon.script_noteworthy)) {
        weapon.script_flag_true = weapon.script_noteworthy;
        weapon.var_12b42a5c = create_flags_and_return_tokens(weapon.script_flag_true);
      }

      if(isDefined(weapon.script_parameters)) {
        weapon.script_flag_false = weapon.script_parameters;
        weapon.var_67f376ee = create_flags_and_return_tokens(weapon.script_flag_false);
      }

      weapon.origin -= (0, 0, 4096);
      weapon.var_9da55e9 = 1;
      weapon hide();
      self.weapon_ents[self.weapon_ents.size] = weapon;
    }
  }
}

function function_729e9efe() {
  for(i = 0; i < self.var_435fd319.size; i++) {
    if(isDefined(self.var_435fd319[i])) {
      self.var_435fd319[i] delete();
      continue;
    }

    entities = getentitiesinradius(self.weapon_ents[i].origin + (0, 0, 4096), 18);

    if(isDefined(entities)) {
      foreach(ent in entities) {
        if(!isDefined(ent.classname)) {
          continue;
        }

        if(strstartswith(ent.classname, "weapon_") && !isDefined(ent.targetname)) {
          ent delete();
          break;
        }
      }
    }
  }

  self.var_435fd319 = [];
}

function function_12a6420e() {
  for(i = 0; i < self.weapon_ents.size; i++) {
    if(!isDefined(self.weapon_ents[i])) {
      continue;
    }

    weap = self.weapon_ents[i];

    if(isDefined(weap.var_12b42a5c)) {
      self thread function_799d23e5(weap);
      continue;
    }

    self function_5ec2506f(weap);
  }
}

function function_5ec2506f(weap) {
  new_weap = spawnweapon(weap.item, weap.origin + (0, 0, 4096), weap.angles, weap.spawnflags);
  new_weap.angles = weap.angles;
  self.var_435fd319[self.var_435fd319.size] = new_weap;

  if(isDefined(self.targetname)) {
    self.var_435fd319[self.var_435fd319.size - 1].targetname = self.targetname;
  }

  return new_weap;
}

function function_799d23e5(weapon) {
  self endon(#"hash_740faf03c1eeca5b");
  weapon endon(#"death");

  while(true) {
    if(isDefined(weapon.var_67f376ee)) {
      weapon function_48b43844(weapon.var_67f376ee, 0);
    }

    if(isDefined(weapon.var_12b42a5c)) {
      weapon function_48b43844(weapon.var_12b42a5c, 1);
    }

    new_weap = self function_5ec2506f(weapon);

    if(isDefined(weapon.var_67f376ee)) {
      weapon function_7022dcf2(weapon.var_67f376ee, 1);
    }

    if(isDefined(weapon.var_12b42a5c)) {
      weapon function_7022dcf2(weapon.var_12b42a5c, 0);
    }

    if(isDefined(new_weap)) {
      new_weap delete();
    }
  }
}

function function_c8d0e6e() {
  if(isDefined(self.fn_callbacks[self.var_39a8d200])) {
    return [[self.fn_callbacks[self.var_39a8d200]]]();
  }

  return 0;
}

function sb_tick() {
  level endon(#"hash_6c615e84f3905f49");

  while(true) {
    level flag::wait_till("sb_reset_all");

    iprintln("<dev string:x24f>");

    foreach(smart_bundle in self.var_84410238) {
      smart_bundle function_cd166c09();
      smart_bundle notify(#"hash_259aadae63b5fba0");
    }

    level flag::wait_till_clear("sb_reset_all");

    iprintln("<dev string:x26f>");

    function_ecd7b564();
  }
}

function function_ecd7b564() {
  foreach(smart_bundle in self.var_84410238) {
    if(isDefined(smart_bundle)) {
      smart_bundle thread function_d199bc6b();
    }
  }
}

function function_6410533e(obj_struct) {
  obj_struct.on_ai = 0;
  obj_struct.optional_obj = 0;
  obj_struct.var_dffd37e7 = 0;
  obj_struct.var_262caa7f = 0;
  assert(isDefined(obj_struct.targetname), "<dev string:x292>");

  foreach(token in obj_struct.var_3803ef1e) {
    switch (token) {
      case # "search_area":
        obj_struct.var_dffd37e7 = 1;

        if(isDefined(obj_struct.target)) {
          obj_struct.search_vol = getent(obj_struct.target, "targetname");
        } else if(!isDefined(obj_struct.radius)) {
          obj_struct.radius = 512;

          iprintln(obj_struct.targetname + "<dev string:x2fb>");
        }

        break;
      case # "optional":
        obj_struct.optional_obj = 1;
        break;
      case # "on_ai":
        obj_struct.on_ai = 1;
        break;
      case # "hash_56311e749da142f":
        obj_struct.var_262caa7f = 1;
        break;
      case # "force_remove":
        obj_struct.force_remove = 1;
        break;
      default:

        iprintln(obj_struct.targetname + "<dev string:x339>" + token);

        break;
    }
  }

  if(isDefined(obj_struct.targetname)) {
    if(!isDefined(obj_struct.script_flag_true)) {
      obj_struct.script_flag_true = "";
    }

    if(!isDefined(obj_struct.script_flag_false)) {
      obj_struct.script_flag_false = "";
    }

    obj_struct.script_flag_true = obj_struct.targetname + "_active " + obj_struct.script_flag_true;
    obj_struct.script_flag_false = obj_struct.targetname + "_complete " + obj_struct.script_flag_false;
  }

  obj_struct function_51029384();
}

function function_40af2aa3() {
  for(i = 0; i < self.var_4961c57a.size; i++) {
    if(isDefined(self.var_4961c57a[i].script_noteworthy) && self.var_4961c57a[i].script_noteworthy == "objective_info") {
      desc = self.var_4961c57a[i].targetname;

      if(isDefined(self.var_4961c57a[i].script_objective)) {
        desc = self.var_4961c57a[i].script_objective;
      }

      if(!isDefined(desc)) {
        desc = "Objective with no description";
      }

      iprintln("<dev string:x35b>" + desc);

      self thread function_74620370(self.var_4961c57a[i]);
    }
  }
}

function function_74620370(obj_struct) {
  obj_struct endon(#"hash_511658d5f7f609e6");

  if(obj_struct.var_262caa7f) {
    foreach(flag in obj_struct.var_12b42a5c) {
      level flag::set(flag);
    }
  }

  while(true) {
    obj_struct function_9a0ffb73();

    if(obj_struct.on_ai) {
      if(!function_d48a3aef(obj_struct)) {
        return;
      }
    } else {
      obj_struct.var_691af0d0 = 1;
      label = undefined;

      if(is_true(obj_struct.var_dffd37e7)) {
        label = "Search Area";
        thread search_area_handling(obj_struct);
      }

      desc = obj_struct.targetname;

      if(isDefined(obj_struct.script_objective)) {
        desc = obj_struct.script_objective;
      }

      if(isDefined(level.var_ebad26ee)) {
        level flag::wait_till_clear(level.var_ebad26ee);
      }
    }

    obj_struct function_f3d46509();

    if(isDefined(level.var_ebad26ee)) {
      level flag::wait_till_clear(level.var_ebad26ee);
    }

    obj_struct notify(#"hash_9c87e8499427b2e");
    obj_struct.var_691af0d0 = undefined;
  }
}

function function_d48a3aef(obj_struct) {
  assert(isDefined(obj_struct.target), "<dev string:x369>" + obj_struct.targetname);
  ents = getEntArray(obj_struct.target, "targetname");

  if(ents.size == 0) {
    return false;
  }

  ais = [];
  spawners = [];

  foreach(ent in ents) {
    if(isspawner(ent)) {
      spawners[spawners.size] = ent;
    }
  }

  time_check = gettime() + 5000;

  while(spawners.size != ais.size && time_check > gettime()) {
    ents = getEntArray(obj_struct.target, "targetname");
    ais = [];

    foreach(ent in spawners) {
      if(isDefined(ent.var_de1cdf28) && isalive(ent.var_de1cdf28)) {
        ais[ais.size] = ent.var_de1cdf28;
      }
    }

    waitframe(1);
  }

  if(ais.size == 0) {
    iprintln("<dev string:x3af>");

    return false;
  }

  desc = obj_struct.targetname;

  if(isDefined(obj_struct.script_objective)) {
    desc = obj_struct.script_objective;
  }

  label = "Talk To";
  obj_struct.var_691af0d0 = 1;
  height_add = (0, 0, 78);

  if(isDefined(level.var_ebad26ee)) {
    level flag::wait_till_clear(level.var_ebad26ee);
  }

  return true;
}

function search_area_handling(obj_struct) {
  obj_struct endon(#"hash_9c87e8499427b2e");
  wait 0.25;

  if(!isDefined(obj_struct.radius)) {
    return;
  }

  inside = 0;
  mul = 1;

  while(true) {
    if(isDefined(obj_struct.radius)) {
      real_dist = distance(obj_struct.origin, level.player getorigin());
      var_333a51b7 = real_dist * mul;
      dist = distance(obj_struct.origin, level.player getorigin()) - obj_struct.radius * mul;

      if(!inside) {
        if(dist > 0) {
          dist /= 320;
          dist = math::clamp(dist, 0.05, 2);
          wait dist;
        } else {
          mul = 1.2;
          inside = 1;

          iprintln("<dev string:x3ce>");

          obj_struct.var_6d4da557 = 1;
        }
      } else if(inside) {
        if(dist > 0) {
          mul = 1;
          inside = 0;

          iprintln("<dev string:x3e5>");

          obj_struct.var_6d4da557 = undefined;
        }
      }
    }

    waitframe(1);
  }
}

function function_389d0cb3() {
  for(i = 0; i < self.var_4961c57a.size; i++) {
    if(is_true(self.var_4961c57a[i].var_691af0d0)) {
      self thread function_b2e08f9(self.var_4961c57a[i]);
    }

    self.var_4961c57a[i] notify(#"hash_511658d5f7f609e6");
  }
}

function function_b2e08f9(obj_struct) {
  obj_struct notify(#"hash_9c87e8499427b2e");

  if(isDefined(level.var_ebad26ee)) {
    level flag::wait_till_clear(level.var_ebad26ee);
  }

  obj_struct.var_691af0d0 = undefined;

  if(is_true(obj_struct.var_6d4da557)) {
    obj_struct.var_6d4da557 = undefined;
  }
}

function function_981cea53(obj_id) {
  return false;
}

function function_a55d27bf(objectivename, objstate, objposition, objdescription, objlabel, var_ab2ea29a, objzoffset, var_fb9adc05, var_264b768b, var_4aba5bae, var_1444b216, var_a5a362, var_616ed336, objtype) {
  return false;
}

function function_945b8496(objectivename, objstate, objposition, objdescription, objlabel, var_ab2ea29a, objzoffset, var_fb9adc05, var_264b768b, var_4aba5bae, var_1444b216, var_a5a362, var_616ed336, objtype) {
  return false;
}

function function_cf7e280(objectivename, locationname, locationposition) {
  return false;
}

function function_864ef3e9(objectivename, locationname, locationentity) {
  return false;
}

function function_e0683aa4(objectivename) {
  return false;
}

function function_cc12d55a(objectivename) {
  return false;
}

function function_fc5d17bb(objectivename) {
  return false;
}

function create_flags_and_return_tokens(flag_string) {
  var_8042aabd = strtok(flag_string, " ");
  return var_8042aabd;
}

function function_51029384() {
  if(isDefined(self.script_flag_true)) {
    self.var_12b42a5c = create_flags_and_return_tokens(self.script_flag_true);
  }

  if(isDefined(self.script_flag_false)) {
    self.var_67f376ee = create_flags_and_return_tokens(self.script_flag_false);
  }
}

function function_459301ea() {
  for(i = 0; i < self.var_146f1420.size; i++) {
    self.var_146f1420[i] function_51029384();
  }

  for(i = 0; i < self.var_4961c57a.size; i++) {
    if(isDefined(self.var_4961c57a[i].script_parameters)) {
      self.var_4961c57a[i].var_3803ef1e = strtok(self.var_4961c57a[i].script_parameters, " ");
    }

    if(isDefined(self.var_4961c57a[i].script_noteworthy) && self.var_4961c57a[i].script_noteworthy == "objective_info") {
      self function_6410533e(self.var_4961c57a[i]);
    }

    self.var_4961c57a[i] function_51029384();
  }
}

function function_7f8ba812() {
  array = [];
  var_feebff9c = "linkname";

  if(isDefined(self.script_linkto)) {
    iprintlnbold("<dev string:x3fa>");

    var_feebff9c = "script_linkName";
  }

  linknames = util::get_links();

  for(i = 0; i < linknames.size; i++) {
    structs = struct::get_array(linknames[i], var_feebff9c);

    if(structs.size > 0) {
      foreach(struct in structs) {
        if(struct.variantname === "smart_model") {
          self.smart_models[self.smart_models.size] = struct;
          continue;
        }

        array[array.size] = struct;
      }
    }
  }

  return array;
}

function function_48b43844(array, state) {
  self endon(#"death");

  for(i = 0; i < array.size; i++) {
    if(level flag::get(array[i]) != state) {
      level waittill(array[i]);
      i = -1;
    }
  }
}

function function_879a654e(var_5e752bb5) {
  ent = spawnStruct();
  ent.var_b5f8363 = var_5e752bb5.size;

  for(i = 0; i < ent.var_b5f8363; i++) {
    self childthread function_212661b4(var_5e752bb5[i], ent);
  }

  while(ent.var_b5f8363 > 0) {
    ent waittill(#"hash_600eff9ce29513a0");
    waittillframeend();
  }

  ent notify(#"die");
}

function function_212661b4(wait_on, ent) {
  level waittill(wait_on);
  ent.var_b5f8363--;
  ent notify(#"hash_600eff9ce29513a0");
}

function function_7022dcf2(array, state) {
  self endon(#"death");

  while(true) {
    for(i = 0; i < array.size; i++) {
      if(level flag::get(array[i]) == state) {
        return;
      }
    }

    level waittill(array);
  }
}

function function_78f5e495(array1, state1, array2, state2) {
  self endon(#"death");

  if(!isDefined(array1) && !isDefined(array2)) {
    return;
  }

  if(!isDefined(array1)) {
    array1 = [];
  }

  if(!isDefined(array2)) {
    array2 = [];
  }

  while(true) {
    for(i = 0; i < array1.size; i++) {
      if(level flag::get(array1[i]) == state1) {
        return;
      }
    }

    for(i = 0; i < array2.size; i++) {
      if(level flag::get(array2[i]) == state2) {
        return;
      }
    }

    level waittill(array1, array2);
  }
}

function function_9a0ffb73(include_radius) {
  self endon(#"death");

  while(true) {
    time_check = gettime();

    if(isDefined(self.var_12b42a5c)) {
      self function_48b43844(self.var_12b42a5c, 1);
    }

    if(isDefined(self.var_67f376ee)) {
      self function_48b43844(self.var_67f376ee, 0);
    }

    if(is_true(include_radius) && isDefined(self.radius)) {
      dist = distance(self.origin, level.player getorigin()) - self.radius;

      if(dist > 0) {
        dist /= 320;
        dist = math::clamp(dist, 0.05, 2);
        wait dist;
      }
    }

    if(time_check == gettime()) {
      break;
    }
  }
}

function function_f3d46509(include_radius) {
  self endon(#"death");

  while(true) {
    time_check = gettime();
    self function_78f5e495(self.var_12b42a5c, 0, self.var_67f376ee, 1);

    if(is_true(include_radius) && isDefined(self.radius)) {
      dist = distance(self.origin, level.player getorigin()) - self.radius * 1.2;

      if(dist < 0) {
        dist /= 320;
        dist = math::clamp(dist, 0.05, 2);
        wait dist;
      }
    }

    if(time_check == gettime()) {
      break;
    }
  }
}

function function_58ca92b7() {
  level.smart_bundle.unique_id++;
  return "smart_bundleid_" + level.smart_bundle.unique_id;
}

function function_491e6cbe() {
  if(!isDefined(getDvar(#"hash_33f2d0ac296c4d13"))) {
    setDvar(#"hash_33f2d0ac296c4d13", "<dev string:x454>");
  }

  mapname = util::get_map_name();
  adddebugcommand("<dev string:x459>" + mapname + "<dev string:x46a>");
  adddebugcommand("<dev string:x459>" + mapname + "<dev string:x4b4>");
  adddebugcommand("<dev string:x459>" + mapname + "<dev string:x4fc>");
  self thread function_b86b7747();
}

function function_3bd2188a() {
  wait 1;

  for(i = 0; i < level.smart_bundle.var_84410238.size; i++) {
    level.smart_bundle.var_84410238[i] function_3bb15d22();
  }
}

function function_3bb15d22() {
  if(!self.var_a0bbcf82) {
    return;
  }

  if(isDefined(self.var_38a97b32)) {
    self notify("<dev string:x547>" + self.var_38a97b32);
    self notify(#"hash_46a4872a3e5fa801");
    self endon("<dev string:x547>" + self.var_38a97b32);
  } else {
    self endon(#"hash_46a4872a3e5fa801");
  }

  while(true) {
    if(!getdvarint(#"hash_7cd0134a1e4d074c")) {
      wait 1;
      continue;
    }

    color = (1, 0, 0);

    if(isDefined(self.var_38a97b32)) {
      if(level flag::get(self.var_38a97b32)) {
        color = (0, 0, 1);
      }

      print3d(self.origin, self.var_38a97b32, color, 1, 2, 1);
    } else {
      print3d(self.origin, "<dev string:x555>", color, 1, 3, 1);
    }

    waitframe(1);
  }
}

function function_595fd211() {
  level endon(#"hash_54aee3abfd596cec");

  while(true) {
    ai = getactorteamarray("axis");
    waitframe(1);
  }
}

function function_d2b6003e() {
  level endon(#"hash_54aee3abfd596cec");
  self endon(#"death");
  wait 2;

  if(isDefined(self.var_12b42a5c)) {
    foreach(flag in self.var_12b42a5c) {
      self thread debug_smart_bundle_flag(flag);
    }
  }

  if(isDefined(self.var_67f376ee)) {
    foreach(flag in self.var_67f376ee) {
      self thread debug_smart_bundle_flag(flag);
    }
  }

  while(true) {
    print3d(self.origin - (0, 0, 72), self.var_39a8d200, (0, 0, 1), 0.7, 1, 1);

    waitframe(1);
  }
}

function function_a6298abd() {
  self notify(#"hash_29b1f6bea26892aa");
  self endon(#"hash_29b1f6bea26892aa");
  level endon(#"hash_54aee3abfd596cec");
  wait 1;
  col = [];
  col[0] = (1, 0, 0);
  col[1] = (0, 1, 0);
  dist_threshold = 1300;
  var_a942f5e3 = 1000;
  var_88351da = 4000;

  while(true) {
    var_5d749e51 = getdvarint(#"hash_33f2d0ac296c4d13");

    if(!var_5d749e51) {
      wait 1;
      continue;
    }

    waitframe(1);
    player = getplayers()[0];
    dist = distance(player.origin, self.origin);

    if(dist > var_88351da) {
      continue;
    }

    if(dist < dist_threshold / 4) {
      dist = dist_threshold / 4;
    }

    mid = 0;
    text_size = 0.75;
    size_inc = 18;
    flags = [];

    if(isDefined(self.var_12b42a5c)) {
      foreach(flag in self.var_12b42a5c) {
        flags[flags.size] = {
          #name: flag, #col: level flag::get(flag)
        };
      }
    }

    mid = flags.size;

    if(isDefined(self.var_67f376ee)) {
      foreach(flag in self.var_67f376ee) {
        flags[flags.size] = {
          #name: flag, #col: level flag::get(flag) == 0
        };
      }
    }

    text_size = text_size * dist / dist_threshold;
    size_inc = size_inc * dist / dist_threshold;
    zoff = (0, 0, (flags.size + 2) * size_inc);
    sub = (0, 0, size_inc * -1);
    curr = self.origin + zoff;
    header = "<dev string:x590>" + self.origin;

    if(isDefined(self.targetname)) {
      header = self.targetname;
    }

    header_col = (0.5, 0.5, 0.5);

    if(self.var_39a8d200 == "<dev string:x59f>" || self.var_39a8d200 == "<dev string:x5b2>") {
      header_col = (0, 1, 0);
      header += "<dev string:x5bc>";
    } else {
      header += "<dev string:x5c3>";
    }

    if(var_5d749e51 == 1 && dist > var_a942f5e3) {
      print3d(curr, header, header_col, 1, 1.5 * text_size, 1);
      continue;
    }

    print3d(curr, header, header_col, 1, text_size * 1.5, 1);
    curr += sub;

    if(mid > 0) {
      print3d(curr, "<dev string:x5cb>", (1, 1, 1), 1, text_size * 0.75, 1);
      curr += sub;
    }

    for(i = 0; i < flags.size; i++) {
      if(i == mid && mid != flags.size) {
        print3d(curr, "<dev string:x5e3>", (1, 1, 1), 1, text_size * 0.75, 1);
        curr += sub;
      }

      print3d(curr, flags[i].name, col[flags[i].col], 1, text_size, 1);
      curr += sub;
    }
  }
}

function debug_smart_bundle_flag(flag) {
  level endon(#"hash_54aee3abfd596cec");
  level notify(flag + "debug_smart_bundle_flag");
  level endon(flag + "debug_smart_bundle_flag");
  self endon(#"death");

  while(true) {
    level flag::wait_till_clear(flag);
    iprintln(flag + " Clear");
    level flag::wait_till(flag);
    iprintln(flag + " Set");
  }
}

function debug_radius(dist) {
  sphere(self.origin, self.radius, (0.5, 0.5, 0), 0, undefined, int(dist / 0.05));
  print3d(self.origin, dist, (1, 1, 1), 1, 2, int(dist / 0.05));
}

function function_b86b7747() {
  level endon(#"hash_54aee3abfd596cec");
  structs = struct::get_array("signpost_struct", "script_noteworthy");
  array::thread_all(structs, &function_1589ded);
}

function function_1589ded() {
  level endon(#"hash_54aee3abfd596cec");

  print3d(self.origin, self.script_parameters, (1, 1, 1), 1, 0.3, 99999);
}

function function_e646a263(weapon_index) {
  self endon(#"hash_55722f50e357be3d");
  org = self.var_435fd319[weapon_index].origin;

  while(isDefined(self.var_435fd319[weapon_index])) {
    sphere(self.var_435fd319[weapon_index].origin, 4, (0, 0, 1), 0, undefined, 1);

    waitframe(1);
  }

  entities = undefined;

  while(true) {
    waitframe(1);
    entities = getentitiesinradius(self.weapon_ents[weapon_index].origin + (0, 0, 4096), 64);

    if(!isDefined(entities)) {
      sphere(self.weapon_ents[weapon_index].origin + (0, 0, 4096), 12, (1, 0, 0), 0, undefined, 1);

      continue;
    }

    if(isDefined(entities)) {
      foreach(ent in entities) {
        if(!isDefined(ent.classname)) {
          continue;
        }

        if(strstartswith(ent.classname, "weapon_") && !isDefined(ent.targetname)) {
          sphere(ent.origin, 16, (0, 1, 0), 0, undefined, 100);

          ent.targetname = self.targetname;
          self.var_435fd319[weapon_index] = ent;
          self thread function_e646a263(weapon_index);
          return;
        }
      }
    }

    sphere(self.weapon_ents[weapon_index].origin + (0, 0, 4096), 8, (1, 0, 0), 0, undefined, 1);

    sphere(self.weapon_ents[weapon_index].origin + (0, 0, 4096), 24, (1, 0, 0), 0, undefined, 1);

    sphere(self.weapon_ents[weapon_index].origin + (0, 0, 4096), 32, (1, 0, 0), 0, undefined, 1);
  }
}