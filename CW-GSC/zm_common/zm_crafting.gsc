/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_crafting.gsc
***********************************************/

#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_challenges;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_progress;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace zm_crafting;

function private autoexec __init__system__() {
  system::register(#"zm_crafting", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  level.var_5df2581a = [];
  level.crafting_components = [];
  function_475a63eb();
}

function private postinit() {
  function_7a8f3cbd();
  function_60a6c623();
  setup_tables();

  if(zombie_utility::get_zombie_var(#"highlight_craftables") || zm_custom::function_901b751c(#"zmcraftingkeyline")) {
    level thread function_40f32480();
  }

  thread devgui_think();
}

function function_60a6c623() {
  foundries = getscriptbundles("craftfoundry");

  foreach(foundry in foundries) {
    setup_craftfoundry(foundry);
  }
}

function setup_craftfoundry(craftfoundry) {
  if(isDefined(craftfoundry)) {
    if(!is_true(craftfoundry.loaded)) {
      craftfoundry.loaded = 1;
      craftfoundry.blueprints = [];

      switch (craftfoundry.blueprintcount) {
        case 8:
          craftfoundry.blueprints[7] = function_b18074d0(craftfoundry.blueprint08);
        case 7:
          craftfoundry.blueprints[6] = function_b18074d0(craftfoundry.blueprint07);
        case 6:
          craftfoundry.blueprints[5] = function_b18074d0(craftfoundry.blueprint06);
        case 5:
          craftfoundry.blueprints[4] = function_b18074d0(craftfoundry.blueprint05);
        case 4:
          craftfoundry.blueprints[3] = function_b18074d0(craftfoundry.blueprint04);
        case 3:
          craftfoundry.blueprints[2] = function_b18074d0(craftfoundry.blueprint03);
        case 2:
          craftfoundry.blueprints[1] = function_b18074d0(craftfoundry.blueprint02);
        case 1:
          craftfoundry.blueprints[0] = function_b18074d0(craftfoundry.blueprint01);
          break;
      }

      function_e197bb07(craftfoundry);
    }
  }
}

function setup_tables() {
  level.var_4fe2f84d = [];
  var_c443493d = getEntArray("crafting_trigger", "targetname");

  foreach(trigger in var_c443493d) {
    var_6886faaa = trigger.var_6886faaa;

    if(isDefined(var_6886faaa)) {
      trigger.craftfoundry = function_c1552513(var_6886faaa);
    } else {
      assertmsg("<dev string:x38>");
    }

    unitrigger = function_f665fde0(trigger);

    if(!isDefined(level.var_4fe2f84d[var_6886faaa])) {
      level.var_4fe2f84d[var_6886faaa] = [];
    }

    if(!isDefined(level.var_4fe2f84d[var_6886faaa])) {
      level.var_4fe2f84d[var_6886faaa] = [];
    } else if(!isarray(level.var_4fe2f84d[var_6886faaa])) {
      level.var_4fe2f84d[var_6886faaa] = array(level.var_4fe2f84d[var_6886faaa]);
    }

    if(!isinarray(level.var_4fe2f84d[var_6886faaa], unitrigger)) {
      level.var_4fe2f84d[var_6886faaa][level.var_4fe2f84d[var_6886faaa].size] = unitrigger;
    }

    level thread function_3012605d(unitrigger);
  }
}

function reset_table() {
  assert(!is_true(self.registered), "<dev string:x5e>");
  zm_unitrigger::register_static_unitrigger(self, &crafting_think);
  self function_35f5c90b(#"craft");
  self.crafted = 0;
  self.blueprint.completed = 0;
}

function function_c1552513(name) {
  craftfoundry = getscriptbundle(name);

  if(isDefined(craftfoundry)) {
    craftfoundry.name = name;
    setup_craftfoundry(craftfoundry);
  } else {
    assertmsg("<dev string:x92>" + name);
  }

  return craftfoundry;
}

function function_b18074d0(name) {
  blueprint = getscriptbundle(name);

  if(isDefined(blueprint)) {
    if(!is_true(blueprint.loaded)) {
      blueprint.loaded = 1;
      blueprint.name = name;
      blueprint.components = [];

      switch (blueprint.componentcount) {
        case 8:
          blueprint.components[7] = get_component(blueprint.var_f4d434cb, blueprint);
        case 7:
          blueprint.components[6] = get_component(blueprint.component07, blueprint);
        case 6:
          blueprint.components[5] = get_component(blueprint.registerperk_packa_seepainterminate, blueprint);
        case 5:
          blueprint.components[4] = get_component(blueprint.component05, blueprint);
        case 4:
          blueprint.components[3] = get_component(blueprint.component04, blueprint);
        case 3:
          blueprint.components[2] = get_component(blueprint.component03, blueprint);
        case 2:
          blueprint.components[1] = get_component(blueprint.component02, blueprint);
        case 1:
          blueprint.components[0] = get_component(blueprint.component01, blueprint);
          break;
      }

      blueprint.var_54a97edd = get_component(blueprint.result, blueprint);
      x = isDefined(blueprint.var_2206e7ed) ? float(blueprint.var_2206e7ed) : 0;
      y = isDefined(blueprint.var_e414062) ? float(blueprint.var_e414062) : 0;
      z = isDefined(blueprint.var_3c809ce0) ? float(blueprint.var_3c809ce0) : 0;
      blueprint.v_offset = (x, y, z);
      x = isDefined(blueprint.prj_scr_round_pause) ? float(blueprint.prj_scr_round_pause) : 0;
      y = isDefined(blueprint.var_11928e3b) ? float(blueprint.var_11928e3b) : 0;
      z = isDefined(blueprint.var_71c8b937) ? float(blueprint.var_71c8b937) : 0;
      blueprint.v_angles = (x, y, z);

      if(!isDefined(blueprint.var_4dbc4aee)) {
        blueprint.var_4dbc4aee = "ERROR: Missing Prompt String";
      }

      function_728a82e0(blueprint);

      level thread function_e5af6b6e(blueprint);
    }
  } else {
    assertmsg("<dev string:xad>" + name);
  }

  return blueprint;
}

function get_component(component, blueprint) {
  if(isstring(component) || ishash(component)) {
    component_name = component;
    component = getweapon(component);
  } else {
    component_name = component.name;
  }

  if(isDefined(blueprint)) {
    var_f61629fd = blueprint.name;
  }

  if(!isDefined(level.crafting_components[component.name])) {
    if(component == level.weaponnone) {
      if(isDefined(component_name)) {
        component_name = function_9e72a96(component_name);
      }

      if(isDefined(var_f61629fd)) {
        var_f61629fd = function_9e72a96(var_f61629fd);
      }

      assertmsg("<dev string:xc3>" + (isDefined(component_name) ? component_name : "<dev string:xe3>") + "<dev string:xf0>" + (isDefined(var_f61629fd) ? var_f61629fd : "<dev string:xe3>"));
    }

    function_4765f5b3(component);

    level.crafting_components[component.name] = component;
  }

  if(isDefined(blueprint) && isDefined(blueprint.result)) {
    if(is_true(blueprint.result.isriotshield)) {
      if(!zm_custom::function_901b751c(#"zmshieldisenabled")) {
        a_items = getitemarray();

        foreach(e_item in a_items) {
          if(e_item.item == component) {
            e_item delete();
          }
        }
      } else {
        zm_items::function_4d230236(component, &function_86531922);
      }
    } else {
      zm_items::function_4d230236(component, &function_d56724a6);
    }
  }

  return level.crafting_components[component.name];
}

function private function_40f32480() {
  level waittill(#"all_players_spawned");
  a_items = getitemarray();

  foreach(e_item in a_items) {
    if(isDefined(e_item.item) && isinarray(level.crafting_components, e_item.item)) {
      e_item clientfield::set("highlight_item", 1);
    }
  }
}

function function_728a82e0(blueprint) {
  if(!isDefined(level.var_5df2581a[blueprint.name])) {
    blueprint.completed = 0;
    blueprint.builder = undefined;
    level.var_5df2581a[blueprint.name] = blueprint;
  }
}

function function_31d883d7() {
  results = [];

  foreach(blueprint in level.var_5df2581a) {
    if(blueprint.completed) {
      if(!isDefined(results)) {
        results = [];
      } else if(!isarray(results)) {
        results = array(results);
      }

      results[results.size] = blueprint;
    }
  }

  return results;
}

function function_4165306b(player) {
  results = [];

  if(isDefined(self.craftfoundry.blueprints)) {
    foreach(blueprint in self.craftfoundry.blueprints) {
      if(!blueprint.completed && function_6d1e4410(player, blueprint)) {
        if(!isDefined(results)) {
          results = [];
        } else if(!isarray(results)) {
          results = array(results);
        }

        results[results.size] = blueprint;
      }
    }
  } else {
    blueprint = self.craftfoundry;

    if(!blueprint.completed && function_6d1e4410(player, blueprint)) {
      if(!isDefined(results)) {
        results = [];
      } else if(!isarray(results)) {
        results = array(results);
      }

      results[results.size] = blueprint;
    }
  }

  return results;
}

function function_6d1e4410(player, blueprint) {
  foreach(component in blueprint.components) {
    if(!zm_items::player_has(player, component)) {
      return false;
    }
  }

  return true;
}

function function_6f635422(player, blueprint) {
  foreach(component in blueprint.components) {
    if(zm_items::player_has(player, component)) {
      zm_items::player_take(player, component);
    }
  }
}

function function_7a8f3cbd() {
  level.var_90237ebd = zm_progress::function_53a680b8(&function_7362ecc8, &function_8962a3bb, &function_735c3a67, &function_f7dbfdf9, &function_d95a600f, &function_73f3bb03);
  level.var_98dad84e = zm_progress::function_53a680b8(&function_7362ecc8, &function_8962a3bb, &function_735c3a67, &function_f7dbfdf9, &function_d95a600f, &function_73f3bb03);
  zm_progress::function_163442cb(level.var_98dad84e, level.weaponnone);
}

function function_7362ecc8(player, unitrigger) {
  if(is_true(unitrigger.locked)) {
    return false;
  }

  blueprints = unitrigger function_4165306b(player);

  if(blueprints.size < 1) {
    return false;
  }

  if(is_true(unitrigger.blueprint.locked)) {
    return false;
  }

  return true;
}

function function_8962a3bb(player, unitrigger) {
  return true;
}

function function_735c3a67(player, unitrigger) {
  if(isDefined(player)) {
    unitrigger.locked = 1;
    unitrigger.blueprint.locked = 1;
    player playSound(#"hash_1fff2aa71bff91fa");
  }
}

function function_f7dbfdf9(player, unitrigger) {
  if(isDefined(unitrigger)) {
    unitrigger notify(#"crafting_fail");
    unitrigger playSound(#"hash_15b7f680d9f65b62");
  }
}

function function_d95a600f(player, unitrigger) {
  if(isDefined(unitrigger)) {
    unitrigger notify(#"crafting_success");
    unitrigger playSound(#"hash_421a00cb329b2a45");
  }
}

function function_73f3bb03(player, unitrigger) {
  unitrigger.locked = 0;
  unitrigger.blueprint.locked = 0;
}

function function_7bffa1ac(weapon) {
  if(zm_equipment::is_equipment(weapon)) {
    if(zm_equipment::is_limited(weapon) && zm_equipment::limited_in_use(weapon)) {
      return true;
    }

    return false;
  }

  return !zm_weapons::limited_weapon_below_quota(weapon, undefined);
}

function function_2d53738e(weapon) {
  if(zm_equipment::is_equipment(weapon)) {
    return zm_equipment::is_player_equipment(weapon);
  }

  return self hasweapon(weapon);
}

function function_48ce9379(weapon) {
  if(isDefined(self.var_4e90ce0c)) {
    return array::contains(self.var_4e90ce0c, weapon);
  }

  return false;
}

function function_126fc77c(player) {
  if(!isDefined(self.stub)) {
    iprintlnbold("<dev string:x102>");

    return 0;
  }

  can_use = self.stub function_18f2be60(player);

  if(!isDefined(self.stub.hint_string)) {
    iprintlnbold("<dev string:x13e>");

    return can_use;
  }

  if(isDefined(level.var_a6f62e91) && isDefined(self.stub.cost) && self.stub[[level.var_a6f62e91]](player, #"crafting_table")) {
    self sethintstringforplayer(player, self.stub.hint_string, self.stub.cost);
  } else if(isDefined(self.stub.cost) && self.stub.cost != 0) {
    self sethintstring(self.stub.hint_string, self.stub.cost);
  } else {
    self sethintstring(self.stub.hint_string);
  }

  return can_use;
}

function function_f665fde0(trig) {
  if(!isDefined(trig)) {
    return;
  }

  unitrigger_stub = spawnStruct();
  unitrigger_stub.craftfoundry = trig.craftfoundry;

  if(zm_utility::get_story() == 1 && isDefined(trig.target2)) {
    unitrigger_stub.var_c2f40a58 = getent(trig.target2, "targetname");
    unitrigger_stub.var_c2f40a58 ghost();
  }

  if(zm_utility::get_story() == 1 && isDefined(trig.target3)) {
    unitrigger_stub.var_4f749ffe = getent(trig.target3, "targetname");
    unitrigger_stub.var_4f749ffe ghost();
  }

  angles = trig.script_angles;

  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  unitrigger_stub.origin = trig.origin + anglestoright(angles) * -6;
  unitrigger_stub.angles = trig.angles;

  if(isDefined(trig.script_angles)) {
    unitrigger_stub.angles = trig.script_angles;
  }

  unitrigger_stub.delete_trigger = 1;
  unitrigger_stub.crafted = 0;
  unitrigger_stub.var_c66d8f22 = 1;
  unitrigger_stub.var_42839ec7 = 1;
  unitrigger_stub.usetime = int(3000);

  if(isDefined(self.usetime)) {
    unitrigger_stub.usetime = self.usetime;
  } else if(isDefined(trig.usetime)) {
    unitrigger_stub.usetime = trig.usetime;
  }

  tmins = trig getmins();
  tmaxs = trig getmaxs();
  tsize = tmaxs - tmins;

  if(isDefined(trig.script_depth)) {
    unitrigger_stub.script_length = trig.script_depth;
  } else {
    unitrigger_stub.script_length = tsize[1];
  }

  if(isDefined(trig.script_width)) {
    unitrigger_stub.script_width = trig.script_width;
  } else {
    unitrigger_stub.script_width = tsize[0];
  }

  if(isDefined(trig.script_height)) {
    unitrigger_stub.script_height = trig.script_height;
  } else {
    unitrigger_stub.script_height = tsize[2];
  }

  unitrigger_stub.target = trig.target;
  unitrigger_stub.targetname = trig.targetname;
  unitrigger_stub.script_noteworthy = trig.script_noteworthy;
  unitrigger_stub.script_parameters = trig.script_parameters;
  unitrigger_stub.script_string = trig.script_string;
  unitrigger_stub.cursor_hint = "HINT_NOICON";
  unitrigger_stub.hint_string = # "hash_a502ccb8fec4c7a";
  unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
  unitrigger_stub.require_look_at = 1;
  unitrigger_stub.require_look_toward = 0;
  unitrigger_stub.var_c060d2c8 = 1;
  zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
  unitrigger_stub.prompt_and_visibility_func = &function_126fc77c;
  zm_unitrigger::register_static_unitrigger(unitrigger_stub, &crafting_think);
  unitrigger_stub.piece_trigger = trig;
  trig.trigger_stub = unitrigger_stub;

  if(isDefined(trig.zombie_weapon_upgrade)) {
    unitrigger_stub.zombie_weapon_upgrade = getweapon(trig.zombie_weapon_upgrade);
  }

  if(isDefined(unitrigger_stub.target)) {
    m_target = getent(unitrigger_stub.target, "targetname");

    if(isDefined(m_target)) {
      unitrigger_stub.model = m_target;

      if(isDefined(unitrigger_stub.zombie_weapon_upgrade)) {
        unitrigger_stub.model useweaponhidetags(unitrigger_stub.zombie_weapon_upgrade);
      }

      if(isDefined(unitrigger_stub.model.script_parameters)) {
        a_utm_params = strtok(unitrigger_stub.model.script_parameters, " ");

        foreach(param in a_utm_params) {
          if(param == "starts_visible") {
            b_start_visible = 1;
            continue;
          }

          if(param == "starts_empty") {
            b_start_empty = 1;
          }
        }
      }

      if(b_start_visible !== 1) {
        unitrigger_stub.model ghost();
        unitrigger_stub.model notsolid();
      }
    }
  }

  if(isDefined(unitrigger_stub.model) && b_start_empty === 1) {
    for(i = 0; i < unitrigger_stub.craftablespawn.a_piecespawns.size; i++) {
      if(isDefined(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name)) {
        if(unitrigger_stub.craftablespawn.a_piecespawns[i].crafted !== 1) {
          unitrigger_stub.model hidepart(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name);
          continue;
        }

        unitrigger_stub.model showpart(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name);
      }
    }
  }

  if(unitrigger_stub.delete_trigger) {
    trig delete();
  }

  unitrigger_stub function_35f5c90b(#"craft");
  return unitrigger_stub;
}

function function_987a472(modelname, blueprint) {
  if(isDefined(self.stub)) {
    s_crafting = self.stub;
  } else {
    s_crafting = self;
  }

  if(!isDefined(s_crafting.model)) {
    s_model = struct::get(s_crafting.target, "targetname");

    if(isDefined(s_model)) {
      m_spawn = spawn("script_model", s_model.origin);
      m_spawn.origin += blueprint.v_offset;

      if(isDefined(s_crafting.v_origin_offset)) {
        m_spawn.origin += s_crafting.v_origin_offset;
      }

      m_spawn.angles = s_model.angles;
      m_spawn.angles += blueprint.v_angles;

      if(isDefined(s_crafting.v_angle_offset)) {
        m_spawn.angles += s_crafting.v_angle_offset;
      }

      m_spawn setModel(modelname);
      s_crafting.model = m_spawn;
      s_crafting.model notsolid();
      s_crafting.model show();
    } else {
      assertmsg("<dev string:x16a>");
    }

    return;
  }

  s_crafting.model notsolid();
  s_crafting.model show();
}

function event_handler[button_bit_melee_pressed] player_melee() {
  player = self;

  if(!isDefined(player.useholdent) || !isDefined(player.useholdent.stub)) {
    return;
  }

  stub = player.useholdent.stub;

  if(isDefined(stub.var_90dfb0bf) && isDefined(level.var_b87dee47[stub.var_90dfb0bf].var_cb2020d8)) {
    stub[[level.var_b87dee47[stub.var_90dfb0bf].var_cb2020d8]](player);
  }
}

function function_ca244624(var_55426150) {
  if(!isDefined(level.var_4fe2f84d[var_55426150])) {
    return;
  }

  foreach(trigger in level.var_4fe2f84d[var_55426150]) {
    trigger.locked = 1;
    level thread zm_unitrigger::unregister_unitrigger(trigger);
  }
}

function function_d1f16587(var_55426150, func) {
  if(!isDefined(level.var_4fe2f84d[var_55426150])) {
    return;
  }

  foreach(trigger in level.var_4fe2f84d[var_55426150]) {
    if(!isDefined(trigger.craftfoundry.callback_funcs)) {
      trigger.craftfoundry.callback_funcs = [];
    }

    if(!isDefined(trigger.craftfoundry.callback_funcs)) {
      trigger.craftfoundry.callback_funcs = [];
    } else if(!isarray(trigger.craftfoundry.callback_funcs)) {
      trigger.craftfoundry.callback_funcs = array(trigger.craftfoundry.callback_funcs);
    }

    if(!isinarray(trigger.craftfoundry.callback_funcs, func)) {
      trigger.craftfoundry.callback_funcs[trigger.craftfoundry.callback_funcs.size] = func;
    }
  }
}

function function_86531922(e_holder, w_item) {
  if(isDefined(w_item.gadgetreadysoundplayer)) {
    self thread zm_audio::create_and_play_dialog(#"shield_pickup", w_item.gadgetreadysoundplayer);
  } else {
    self thread zm_audio::create_and_play_dialog(#"shield_piece", #"pickup");
  }

  self playSound(#"hash_230737b2535a3374");

  if(w_item.var_f56ac2bd !== "") {
    level zm_ui_inventory::function_7df6bb60(hash(w_item.var_f56ac2bd), 1);
  }
}

function function_d56724a6(e_holder, w_item) {
  if(w_item.var_f56ac2bd !== "") {
    level zm_ui_inventory::function_7df6bb60(hash(w_item.var_f56ac2bd), 1);
  }

  if(isDefined(w_item.var_25bb96cc)) {
    self playSound(w_item.var_25bb96cc);
  } else {
    self playSound(#"hash_230737b2535a3374");
  }

  if(isDefined(w_item.gadgetreadysoundplayer)) {
    self thread zm_audio::create_and_play_dialog(#"component_pickup", w_item.gadgetreadysoundplayer);
    return;
  }

  if(isDefined(w_item.var_62a98b13)) {
    self thread zm_audio::create_and_play_dialog(#"component_pickup", w_item.var_62a98b13);
    return;
  }

  self thread zm_audio::create_and_play_dialog(#"component_pickup", #"generic");
}

function private function_475a63eb() {
  if(!isDefined(level.var_b87dee47)) {
    level.var_b87dee47 = [];
  }

  function_e1eeba22(#"craft", &function_8109ae21, &function_f37c4bb5, &function_b03ccfce, &function_d564a5c0);
  function_e1eeba22(#"persistent_buy", &function_9693e041, &function_df8ce6e2, &function_b03ccfce);
  function_e1eeba22(#"buy_once_then_box", &function_15d10d06, &function_42673a26, &function_6e16f902);
  function_e1eeba22(#"one_time_craft", &function_f189f7f, &function_5a4c40a2, &function_578c67bf);
  function_e1eeba22(#"spawn_as_ingredient", &function_f189f7f, &function_5a4c40a2, &function_3c45b116);
  function_e1eeba22(#"spawn_as_item", &function_f189f7f, &function_5a4c40a2, &function_230f6303);
}

function private function_e1eeba22(state, var_a3d8c117, var_ea7ebe1f, var_aee03b4c, var_cb2020d8) {
  var_90dfb0bf = spawnStruct();
  var_90dfb0bf.name = state;
  var_90dfb0bf.var_a3d8c117 = var_a3d8c117;
  var_90dfb0bf.var_ea7ebe1f = var_ea7ebe1f;
  var_90dfb0bf.var_cb2020d8 = var_cb2020d8;
  var_90dfb0bf.var_aee03b4c = var_aee03b4c;
  level.var_b87dee47[state] = var_90dfb0bf;
}

function private function_35f5c90b(state) {
  if(!isDefined(state)) {
    return;
  }

  self.var_90dfb0bf = state;

  if(!isDefined(level.var_b87dee47[self.var_90dfb0bf])) {
    if(ishash(state)) {
      state = "<dev string:x1a2>" + function_9e72a96(state);
    }

    assertmsg("<dev string:x1a7>" + state);

    return;
  }

  if(isDefined(level.var_b87dee47[self.var_90dfb0bf].var_aee03b4c)) {
    self[[level.var_b87dee47[self.var_90dfb0bf].var_aee03b4c]]();
  }
}

function function_18f2be60(player) {
  if(is_true(self.locked)) {
    self.hint_string = "";
    return 0;
  }

  if(player laststand::player_is_in_laststand() || player zm_utility::in_revive_trigger()) {
    self.hint_string = "";
    return 0;
  }

  if(player zm_utility::is_drinking() && !is_true(player.var_1f8802c9)) {
    self.hint_string = "";
    return 0;
  }

  initial_current_weapon = player getcurrentweapon();
  current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);

  if(zm_equipment::is_equipment(current_weapon)) {
    self.hint_string = "";
    return 0;
  }

  if(isDefined(self.var_90dfb0bf)) {
    return self[[level.var_b87dee47[self.var_90dfb0bf].var_a3d8c117]](player);
  }

  self.hint_string = "";
  return 0;
}

function crafting_think() {
  self notify(#"crafting_think");
  self endon(#"crafting_think", #"kill_trigger", #"death");

  while(isDefined(self)) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;
    level notify(#"crafting_started", {
      #unitrigger: self, #activator: player
    });

    if(isDefined(self.stub.var_90dfb0bf)) {
      self[[level.var_b87dee47[self.stub.var_90dfb0bf].var_ea7ebe1f]](player);
    }
  }
}

function private function_b03ccfce() {}

function private function_f189f7f(player) {
  self.hint_string = "";
  return false;
}

function private function_5a4c40a2(player) {}

function private function_8109ae21(player) {
  blueprints = function_4165306b(player);
  var_9c8338de = blueprints.size;

  if(!isDefined(self.blueprint) || self.var_9c8338de !== var_9c8338de || is_true(self.blueprint.completed)) {
    self.blueprint = self.craftfoundry;

    if(blueprints.size) {
      if(!isDefined(self.var_c0df4857)) {
        self.var_c0df4857 = 0;
      }

      if(self.var_c0df4857 >= blueprints.size) {
        self.var_c0df4857 = 0;
      }

      self.blueprint = blueprints[self.var_c0df4857];
    }

    self.var_9c8338de = var_9c8338de;
  }

  if(blueprints.size < 1 || !array::contains(blueprints, self.blueprint)) {
    self.hint_string = # "hash_64cb545dd18c607";

    if(isDefined(level.var_37ad3691)) {
      self[[level.var_37ad3691]]();
    }

    if(zm_utility::get_story() == 1 && isDefined(self.var_c2f40a58) && is_true(self.var_c2f40a58.is_visible)) {
      self.var_c2f40a58 ghost();
      self.var_c2f40a58.is_visible = undefined;
    }

    return true;
  }

  if(is_true(self.blueprint.locked)) {
    self.hint_string = "";
    return false;
  }

  if(blueprints.size > 1 && isDefined(self.blueprint.var_4050486a)) {
    self.hint_string = self.blueprint.var_4050486a;
  } else {
    self.hint_string = self.blueprint.var_4dbc4aee;
  }

  if(zm_utility::get_story() == 1 && isDefined(self.var_c2f40a58)) {
    if(isDefined(self.blueprint.mdlblueprint)) {
      if(self.blueprint.mdlblueprint !== self.var_c2f40a58) {
        self.var_c2f40a58 setModel(self.blueprint.mdlblueprint);
        self.var_c2f40a58 show();
        self.var_c2f40a58.is_visible = 1;
      } else if(!is_true(self.var_c2f40a58.is_visible)) {
        self.var_c2f40a58 show();
        self.var_c2f40a58.is_visible = 1;
      }
    } else if(is_true(self.var_c2f40a58.is_visible)) {
      self.var_c2f40a58 ghost();
      self.var_c2f40a58.is_visible = undefined;
    }
  }

  return true;
}

function private function_d564a5c0(player) {
  if(self.crafted) {
    return;
  }

  if(!isDefined(self.blueprint)) {
    return;
  }

  if(is_true(self.blueprint.locked)) {
    return;
  }

  blueprints = function_4165306b(player);
  var_9c8338de = blueprints.size;

  if(self.var_9c8338de != var_9c8338de) {
    return;
  }

  self.blueprint = self.craftfoundry;

  if(blueprints.size) {
    if(!isDefined(self.var_c0df4857)) {
      self.var_c0df4857 = 0;
    }

    self.var_c0df4857++;

    if(self.var_c0df4857 >= blueprints.size) {
      self.var_c0df4857 = 0;
    }

    self.blueprint = blueprints[self.var_c0df4857];
  }
}

function private function_f37c4bb5(player) {
  if(self.stub.crafted) {
    return;
  }

  if(!isDefined(self.stub.blueprint)) {
    return;
  }

  var_c060d2c8 = self.stub.var_c060d2c8;
  silent = 0;
  initial_current_weapon = player getcurrentweapon();
  current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);

  if(current_weapon.isheroweapon || current_weapon.isgadget || current_weapon.isriotshield) {
    silent = 1;
  }

  if(silent) {
    progress_result = zm_progress::progress_think(player, level.var_98dad84e, var_c060d2c8);
  } else {
    progress_result = zm_progress::progress_think(player, level.var_90237ebd, var_c060d2c8);
  }

  self notify(#"hash_6db03c91467a21f5", {
    #b_completed: progress_result
  });

  if(progress_result) {
    self.stub.crafted = 1;
    player_crafted = player;
    self.stub.blueprint.completed = 1;

    if(is_true(self.stub.blueprint.takecomponents)) {
      function_6f635422(player, self.stub.blueprint);
    }

    level notify(#"blueprint_completed", {
      #blueprint: self.stub.blueprint, #produced: self.stub.blueprint.var_54a97edd, #player: player
    });
    player notify(#"blueprint_completed", {
      #blueprint: self.stub.blueprint, #produced: self.stub.blueprint.var_54a97edd
    });

    if(self.stub.blueprint.postcraft === "persistent_buy" || self.stub.blueprint.postcraft === "buy_once_then_box" || self.stub.blueprint.postcraft === "spawn_as_ingredient") {
      function_987a472(self.stub.blueprint.var_54a97edd.worldmodel, self.stub.blueprint);
    }

    if(isDefined(player_crafted)) {
      player_crafted playSound(#"zmb_craftable_complete");

      if(isDefined(self.stub.blueprint.name)) {
        player_crafted thread zm_audio::create_and_play_dialog(#"build_complete", self.stub.blueprint.name);
      }
    }

    if(isDefined(self.stub.craftfoundry.callback_funcs)) {
      foreach(func in self.stub.craftfoundry.callback_funcs) {
        self thread[[func]](player);
      }
    }

    if(isDefined(self.stub.blueprint.var_54a97edd) && is_true(self.stub.blueprint.var_54a97edd.isriotshield)) {
      foreach(e_player in getplayers()) {
        e_player zm_challenges::debug_print("<dev string:x1c2>");

        e_player zm_stats::increment_challenge_stat(#"shields_built", undefined, 1);
      }
    }

    if(isDefined(self.stub.blueprint.postcraft)) {
      self.stub function_35f5c90b(self.stub.blueprint.postcraft);
    }
  }
}

function function_a187b293(player) {
  if(self.crafted) {
    return;
  }

  if(!isDefined(player)) {
    player = array::random(level.players);
  }

  if(!isDefined(self.blueprint)) {
    self.blueprint = self.craftfoundry;
  }

  a_s_blueprints = function_4165306b(player);
  self.var_9c8338de = a_s_blueprints.size;
  self.crafted = 1;
  self.blueprint.completed = 1;

  if(self.blueprint.postcraft === "persistent_buy" || self.blueprint.postcraft === "buy_once_then_box" || self.blueprint.postcraft === "spawn_as_ingredient") {
    function_987a472(self.blueprint.var_54a97edd.worldmodel, self.blueprint);
  }

  if(isDefined(self.craftfoundry.callback_funcs)) {
    foreach(func in self.craftfoundry.callback_funcs) {
      self thread[[func]](player);
    }
  }

  if(isDefined(self.blueprint.postcraft)) {
    self function_35f5c90b(self.blueprint.postcraft);
  }
}

function private function_578c67bf() {
  thread zm_unitrigger::unregister_unitrigger(self);
}

function private function_3c45b116() {
  v_origin = self.origin;
  v_angles = self.angles;

  if(!isDefined(self.model)) {
    s_model = struct::get(self.target, "targetname");

    if(isDefined(s_model)) {
      v_origin = s_model.origin;

      if(isDefined(self.v_origin_offset)) {
        v_origin += self.v_origin_offset;
      }

      v_angles = s_model.angles;

      if(isDefined(self.v_angle_offset)) {
        v_angles += self.v_angle_offset;
      }
    }
  } else {
    v_origin = self.model.origin;
    v_angles = self.model.angles;
  }

  zm_items::spawn_item(self.blueprint.var_54a97edd, v_origin, v_angles);
  thread zm_unitrigger::unregister_unitrigger(self);
}

function private function_230f6303() {
  v_origin = self.origin;
  v_angles = self.angles;

  if(!isDefined(self.model)) {
    s_model = struct::get(self.target, "targetname");

    if(isDefined(s_model)) {
      v_origin = s_model.origin;

      if(isDefined(self.v_origin_offset)) {
        v_origin += self.v_origin_offset;
      }

      v_angles = s_model.angles;

      if(isDefined(self.v_angle_offset)) {
        v_angles += self.v_angle_offset;
      }
    }
  } else {
    self.model notsolid();
    self.model show();
  }

  thread zm_unitrigger::unregister_unitrigger(self);
}

function private function_9693e041(player) {
  if(player function_7bffa1ac(self.blueprint.var_54a97edd)) {
    self.hint_string = # "hash_718d32f9e8cea17";
    self.cost = undefined;
    return true;
  }

  if(player function_2d53738e(self.blueprint.var_54a97edd)) {
    if(is_true(self.var_ad7ae074)) {
      return true;
    }

    if(is_true(self.blueprint.var_54a97edd.isriotshield) && isDefined(player.player_shield_reset_health) && is_true(player.var_d3345483)) {
      self.cost = function_ceac3bf9(player, 1);
      str = self.blueprint.var_1238231a;
      var_e7ed2264 = function_c9163c5d(str);
      hint_str = player zm_utility::function_d6046228(str, var_e7ed2264);
      backup_str = player zm_utility::function_d6046228(#"zombie/repair_shield", #"hash_197687e8f04962c9");
      self.hint_string = isDefined(hint_str) ? hint_str : backup_str;
      _shad_turret_debug_server = 1;
    } else {
      self.hint_string = # "hash_53fd856df9288be7";
      self.cost = undefined;
      return true;
    }
  } else if(!player function_2d53738e(self.blueprint.var_54a97edd) && (is_true(self.blueprint.var_c028dcfe) && !player function_48ce9379(self.blueprint.var_54a97edd) || is_true(level.var_905507c3))) {
    str = self.blueprint.var_abd9b2d0;
    var_e7ed2264 = function_c9163c5d(str);
    hint_str = player zm_utility::function_d6046228(str, var_e7ed2264);
    self.hint_string = isDefined(hint_str) ? hint_str : "";
    self.cost = undefined;
  } else if(zm_trial_disable_buys::is_active()) {
    self.hint_string = # "hash_55d25caf8f7bbb2f";
  } else {
    if(!is_true(_shad_turret_debug_server)) {
      str = self.blueprint.var_391591d0;
      var_e7ed2264 = function_c9163c5d(str);
      self.hint_string = player zm_utility::function_d6046228(str, var_e7ed2264);
    }

    self.cost = function_ceac3bf9(player);

    if(self.cost == 0) {
      str = self.blueprint.var_abd9b2d0;
      var_e7ed2264 = function_c9163c5d(str);
      hint_str = player zm_utility::function_d6046228(str, var_e7ed2264);
      self.hint_string = isDefined(hint_str) ? hint_str : "";
      self.cost = undefined;
    }
  }

  if(isDefined(level.var_932a1afb)) {
    self[[level.var_932a1afb]](player);
  }

  return true;
}

function function_c9163c5d(str) {
  if(isDefined(str) && str != "") {
    str += "_KEYBOARD";
  }

  return str;
}

function function_ceac3bf9(player, b_repaired = 0) {
  if(!isDefined(player.var_36ea3103)) {
    player.var_36ea3103 = 0;
  }

  if(isDefined(player.talisman_shield_price) && self.blueprint.var_54a97edd.isriotshield) {
    var_a185bd91 = player.talisman_shield_price;
  } else {
    var_a185bd91 = 0;
  }

  switch (player.var_36ea3103) {
    case 0:
      n_cost = 0;
      break;
    case 1:
      n_cost = 250;
      break;
    case 2:
      n_cost = 500;
      break;
    case 3:
      n_cost = 750;
      break;
    case 4:
      n_cost = 1000;
      break;
    case 5:
      n_cost = 1250;
      break;
    case 6:
      n_cost = 1500;
      break;
    case 7:
      n_cost = 2000;
      break;
    default:
      n_cost = player function_86cab486();
      break;
  }

  n_cost -= var_a185bd91;

  if(n_cost < 100) {
    n_cost = 100;
  }

  if(b_repaired) {
    n_cost = math::clamp(n_cost, 250, 2500);
  }

  return n_cost;
}

function private function_86cab486() {
  if(!isDefined(self.var_76a15cfd)) {
    self.var_76a15cfd = 0;
  }

  if(self.var_3b6a5556 !== level.round_number) {
    n_cost = 2500;
  } else {
    switch (self.var_76a15cfd) {
      case 0:
        n_cost = 2500;
        break;
      case 1:
        n_cost = 3000;
        break;
      case 2:
        n_cost = 4000;
        break;
      default:
        n_cost = 5000;
        break;
    }
  }

  return n_cost;
}

function function_fccf9f0d() {
  if(self.var_36ea3103 >= 8) {
    if(self.var_3b6a5556 !== level.round_number) {
      self.var_76a15cfd = 1;
      self.var_3b6a5556 = level.round_number;
    } else {
      self.var_76a15cfd++;
    }
  }

  self.var_36ea3103++;
}

function private function_df8ce6e2(player) {
  if(isDefined(level.var_f7d93c4e)) {
    if(!is_true(self[[level.var_f7d93c4e]](player))) {
      return;
    }
  }

  if(!is_true(self.stub.crafted)) {
    self.stub.hint_string = "";
    self sethintstring(self.stub.hint_string);
    return;
  }

  if(player != self.parent_player) {
    return;
  }

  if(!zm_utility::is_player_valid(player)) {
    player thread zm_utility::ignore_triggers(0.5);
    return;
  }

  if(isDefined(level.var_a6f62e91)) {
    if(self[[level.var_a6f62e91]](player, #"crafting_table")) {
      return;
    }
  }

  if(player function_2d53738e(self.stub.blueprint.var_54a97edd)) {
    if(is_true(self.stub.blueprint.var_54a97edd.isriotshield) && isDefined(player.player_shield_reset_health) && is_true(player.var_d3345483)) {
      var_d97673ff = 1;
    } else {
      return;
    }
  }

  if(player function_7bffa1ac(self.stub.blueprint.var_54a97edd)) {
    self.stub.hint_string = "";
    self sethintstring(self.stub.hint_string);
    return;
  }

  if(is_true(var_d97673ff)) {
    var_f66d1847 = self.stub function_ceac3bf9(player, 1);
  } else {
    var_f66d1847 = self.stub function_ceac3bf9(player);
  }

  if(isDefined(var_f66d1847) && var_f66d1847 > 0) {
    if(is_true(self.stub.blueprint.var_c028dcfe) && !player function_48ce9379(self.stub.blueprint.var_54a97edd)) {
      if(!isDefined(player.var_4e90ce0c)) {
        player.var_4e90ce0c = [];
      }

      array::add(player.var_4e90ce0c, self.stub.blueprint.var_54a97edd, 0);
      player thread function_fccf9f0d();
    } else if(zm_trial_disable_buys::is_active()) {
      return;
    } else if(player zm_score::can_player_purchase(var_f66d1847)) {
      player thread function_fccf9f0d();
      player zm_score::minus_to_player_score(var_f66d1847);
      player zm_utility::play_sound_on_ent("purchase");
    } else {
      zm_utility::play_sound_on_ent("no_purchase");
      player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
      return;
    }
  }

  if(isDefined(self.stub.blueprint.var_fe8a5e39)) {
    if(!isDefined(player.var_2f3339f0)) {
      player.var_2f3339f0 = [];
    }

    if(!is_true(player.var_2f3339f0[self.stub.blueprint.var_54a97edd])) {
      player thread zm_equipment::show_hint_text(self.stub.blueprint.var_fe8a5e39);
      player.var_2f3339f0[self.stub.blueprint.var_54a97edd] = 1;
    }
  }

  if(is_true(self.stub.blueprint.var_54a97edd.isriotshield)) {
    if(is_true(var_d97673ff)) {
      player[[player.player_shield_reset_health]](undefined, 1);
    } else if(is_true(player.hasriotshield) && isDefined(player.weaponriotshield)) {
      player zm_weapons::weapon_take(player.weaponriotshield);
    }
  }

  if(!is_true(var_d97673ff)) {
    player zm_weapons::weapon_give(self.stub.blueprint.var_54a97edd);
  } else {
    player playSound(#"hash_230737b2535a3374");
  }

  player notify(#"hash_77d44943fb143b18", {
    #weapon: self.stub.blueprint.var_54a97edd
  });
  player zm_stats::function_c0c6ab19(#"weapons_bought", 1, 1);
  player contracts::increment_zm_contract(#"contract_zm_weapons_bought", 1, #"zstandard");
  self.stub.bought = 1;
  self.stub.hint_string = "";
  self.stub.cost = undefined;
  self sethintstring(self.stub.hint_string);
  self.stub.var_ad7ae074 = 1;
  self.stub thread function_d94efa98();
  player zm_stats::track_craftables_pickedup(self.stub.blueprint.var_54a97edd);

  if(isDefined(level.var_8c978b55)) {
    self[[level.var_8c978b55]](player);
  }
}

function private function_d94efa98() {
  self endon(#"death");
  self notify("6c1441a4d6cc4b06");
  self endon("6c1441a4d6cc4b06");
  wait 5;
  self.var_ad7ae074 = undefined;
}

function private function_6e16f902() {
  if(isDefined(self.model)) {
    self.model notsolid();
    self.model show();
  }
}

function private function_15d10d06(player) {
  if(player function_7bffa1ac(self.blueprint.var_54a97edd)) {
    self.hint_string = # "hash_7b4e31b02c13ed59";
    return true;
  } else if(is_true(self.bought)) {
    self.hint_string = # "hash_48157c44f8771b6c";
    return true;
  }

  str = self.blueprint.var_391591d0;
  var_e7ed2264 = function_c9163c5d(str);
  self.hint_string = player zm_utility::function_d6046228(str, var_e7ed2264);
  return true;
}

function private function_42673a26(player) {
  if(is_true(self.stub.bought)) {
    return;
  }

  current_weapon = player getcurrentweapon();

  if(zm_loadout::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon)) {
    return;
  }

  if(!is_true(self.stub.crafted)) {
    self.stub.hint_string = "";
    self sethintstring(self.stub.hint_string);
    return;
  }

  if(!zm_utility::is_player_valid(player)) {
    player thread zm_utility::ignore_triggers(0.5);
    return;
  }

  if(player != self.parent_player) {
    return;
  }

  if(isDefined(self.stub.model)) {}

  if(!player function_7bffa1ac(self.stub.blueprint.var_54a97edd)) {
    player zm_weapons::weapon_give(self.stub.blueprint.var_54a97edd);
    zm_weapons::function_603af7a8(self.stub.blueprint.var_54a97edd);
    self.stub.bought = 1;
  }

  if(player function_7bffa1ac(self.stub.blueprint.var_54a97edd)) {
    self.stub.hint_string = # "hash_7b4e31b02c13ed59";
  } else {
    self.stub.hint_string = # "hash_48157c44f8771b6c";
  }

  self sethintstring(self.stub.hint_string);
}

function function_3012605d(unitrigger) {
  if(!isDefined(level.var_644b04e2)) {
    level.var_644b04e2 = [];
  }

  if(!isDefined(level.var_a9839862)) {
    level.var_a9839862 = 0;
  }

  table_id = level.var_a9839862;
  level.var_a9839862++;
  level.var_644b04e2[table_id] = unitrigger;
  name = unitrigger.craftfoundry.name;

  if(unitrigger.craftfoundry.displayname != "<dev string:x1e9>") {
    name = unitrigger.craftfoundry.displayname;
  }

  util::waittill_can_add_debug_command();
  str_cmd = "<dev string:x1ed>" + table_id + "<dev string:x220>" + name + "<dev string:x226>" + table_id + "<dev string:x250>";
  adddebugcommand(str_cmd);
}

function function_e197bb07(foundry) {}

function function_e5af6b6e(blueprint) {
  name = blueprint.name;

  if(blueprint.displayname != "<dev string:x1e9>") {
    name = blueprint.displayname;
  }

  foreach(component in blueprint.components) {
    function_e9e4a1d0(name, component);
  }
}

function function_e9e4a1d0(var_a13e8cac, component) {
  util::waittill_can_add_debug_command();
  name = getweaponname(component);
  str_cmd = "<dev string:x256>" + var_a13e8cac + "<dev string:x27f>" + name + "<dev string:x289>" + name + "<dev string:x250>";
  adddebugcommand(str_cmd);
}

function function_4765f5b3(component) {}

function devgui_get_players() {
  var_4ab6b47 = getdvarstring(#"hash_7c8c0c3f35357a53");

  if(var_4ab6b47 != "<dev string:x1e9>") {
    player_id = int(var_4ab6b47);

    if(player_id > 0 && player_id <= 4 && isDefined(getplayers()[player_id - 1])) {
      result = [];
      result[player_id - 1] = getplayers()[player_id - 1];
      return result;
    }
  }

  return getplayers();
}

function devgui_think() {
  setDvar(#"hash_7c8c0c3f35357a53", "<dev string:x1e9>");
  util::waittill_can_add_debug_command();
  str_cmd = "<dev string:x2ae>";
  adddebugcommand(str_cmd);

  for(i = 1; i <= 4; i++) {
    util::waittill_can_add_debug_command();
    str_cmd = "<dev string:x2fc>" + i + "<dev string:x32a>" + i + "<dev string:x32f>" + i + "<dev string:x250>";
    adddebugcommand(str_cmd);
  }

  while(true) {
    var_cf5ebef8 = getdvarstring(#"hash_43086839e587cc6c");

    if(var_cf5ebef8 != "<dev string:x1e9>") {
      table_id = int(var_cf5ebef8);
      array::thread_all(devgui_get_players(), &function_fe738a08, table_id);
      setDvar(#"hash_43086839e587cc6c", "<dev string:x1e9>");
    }

    component = getdvarstring(#"hash_3a357be22156749e");

    if(component != "<dev string:x1e9>") {
      w_comp = get_component(component);
      array::thread_all(devgui_get_players(), &function_3e29352d, w_comp);
      setDvar(#"hash_3a357be22156749e", "<dev string:x1e9>");
    }

    wait 1;
  }
}

function function_3e29352d(w_comp) {
  self giveweapon(w_comp);
}

function function_fe738a08(table_id) {
  unitrigger = level.var_644b04e2[table_id];
  entnum = self getentitynumber();
  origin = unitrigger.origin;
  forward = anglesToForward(unitrigger.angles);
  right = anglestoright(unitrigger.angles);
  var_21f5823e = vectortoangles(forward * -1);
  plorigin = origin + 48 * forward;

  switch (entnum) {
    case 0:
      plorigin += 16 * right;
      break;
    case 1:
      plorigin += 16 * forward;
      break;
    case 2:
      plorigin -= 16 * right;
      break;
    case 3:
      plorigin -= 16 * forward;
      break;
  }

  self setorigin(plorigin);
  self setplayerangles(var_21f5823e);
}