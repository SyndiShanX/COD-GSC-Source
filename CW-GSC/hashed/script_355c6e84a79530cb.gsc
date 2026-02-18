/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_355c6e84a79530cb.gsc
***********************************************/

#using script_23ffc3f9567be80c;
#using script_25be5471a9c31833;
#using script_2618e0f3e5e11649;
#using script_340a2e805e35f7a2;
#using script_4ccfb58a9443a60b;
#using script_6b2d896ac43eb90;
#using script_6fc2be37feeb317b;
#using script_7a5293d92c61c788;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\armor;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\objective_manager;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#namespace namespace_73df937d;

function private autoexec __init__system__() {
  system::register(#"hash_5ff56dba9074b0b4", &preinit, undefined, &finalize, #"content_manager");
}

function preinit() {
  content_manager::register_script("safehouse", &function_d0e7af66);
  level clientfield::register("scriptmover", "safehouse_claim_fx", 1, 1, "int");
  callback::add_callback(#"objective_started", &function_83b6d24a);
  callback::add_callback(#"objective_ended", &function_2b1da4a6);
}

function finalize() {
  level.contentmanager.var_a4bccdb2 = [];
  level.contentmanager.var_bb7e7804 = 1;
  level thread function_9d178321();

  level thread init_devgui();
}

function spawn_safehouse(destination) {
  var_3007472f = level.contentmanager.var_1d9d92ba.var_d5b937da;

  if(isDefined(var_3007472f)) {
    var_df889249 = array::random(strtok(var_3007472f, ","));
  }

  var_85065ec2 = [];

  foreach(location in destination.locations) {
    safehouse = location.instances[# "safehouse"];

    if(isDefined(safehouse)) {
      var_5838bf4c = safehouse;

      if(!isDefined(var_df889249) || var_df889249 === safehouse.script_int) {
        if(!isDefined(var_85065ec2)) {
          var_85065ec2 = [];
        } else if(!isarray(var_85065ec2)) {
          var_85065ec2 = array(var_85065ec2);
        }

        var_85065ec2[var_85065ec2.size] = safehouse;
      }
    }
  }

  safehouse = array::random(var_85065ec2);

  if(!isDefined(var_5838bf4c)) {
    safehouse = var_5838bf4c;
  }

  if(isDefined(safehouse)) {
    objective_manager::function_9d4e6125(safehouse.content_script_name);
    content_manager::spawn_instance(safehouse);
    level.contentmanager.var_c4181ea = safehouse;
  }
}

function function_d0e7af66(instance) {
  assert(isarray(instance.contentgroups[# "claim_interact"]), "<dev string:x38>");
  assert(instance.contentgroups[# "claim_interact"].size == 1, "<dev string:x66>");
  namespace_ce1f29cc::function_12c2f41f(instance.origin, 2500);
  var_f86415a9 = arraysortclosest(getEntArray("ambush_trigger", "targetname"), instance.origin, undefined, undefined, 2500);
  array::delete_all(var_f86415a9);
  var_7d0e37f8 = instance.contentgroups[# "claim_interact"][0];
  function_e9bd72e8(var_7d0e37f8, instance);

  if(!is_true(level.var_53bc31ad)) {
    level zm_vo::function_7622cb70("safehouseApproach", 1.5, 1);
  }
}

function function_2b0784c1() {
  self luinotifyevent(#"hash_5159e35a62fb7083", 3, 1, 0, 0);
}

function function_d9ea0e09(eventstruct) {
  assert(isDefined(self.instance), "<dev string:x89>");

  if(level flag::get("objective_locked")) {
    return;
  }

  player = eventstruct.activator;
  instance = self.instance;
  scriptmodel = self.scriptmodel;

  if(isPlayer(player) && player zm_score::can_player_purchase(0) && !is_true(self.var_c1e1d9cb)) {
    foreach(spectator in getplayers()) {
      if(spectator.sessionstate === "spectator") {
        spectator notify(#"force_spawn");
      }
    }

    self.var_c1e1d9cb = 1;
    scriptmodel clientfield::set("safehouse_claim_fx", 0);
    level thread function_e1fab6a9(instance, scriptmodel.origin);
    level thread function_98715738(instance);

    if(is_true(level.var_53bc31ad)) {
      level thread function_2ed0fa9b(instance, scriptmodel.origin);
    }

    playrumbleonposition("sr_prototype_safehouse_rumble", self.origin);
    player thread function_2b0784c1();
    player zm_score::minus_to_player_score(0);
    objid = instance.objectiveid;
    objective_setinvisibletoall(objid);
    waittillframeend();
    util::wait_network_frame();
    level notify(#"safehouse_claimed");

    if(isDefined(self)) {
      if(isDefined(scriptmodel)) {
        scriptmodel delete();
      }

      self delete();
    }

    return;
  }

  playsoundatposition(#"hash_331360fb3bc61a2e", scriptmodel.origin + (0, 0, 50));
}

function function_e1fab6a9(instance, v_center) {
  assert(isDefined(instance), "<dev string:xb3>");
  a_machines = content_manager::get_children(instance);
  a_machines = arraysortclosest(a_machines, v_center);
  n_time_elapsed = 0;
  wait 2.4;

  foreach(s_machine in a_machines) {
    n_dist = distance(s_machine.origin, v_center);
    n_wait = n_dist / 600 * 1.5 - n_time_elapsed - 0.1;

    if(n_wait > 0 && n_time_elapsed < 1.5) {
      wait n_wait;
      n_time_elapsed += n_wait;
    }

    level thread function_ae44cb3d(instance, s_machine.content_key);

    if(is_true(level.var_53bc31ad)) {
      a_ai = getaiteamarray(level.zombie_team);

      foreach(ai in a_ai) {
        if(isalive(ai) && ai.zm_ai_category === # "normal" && distance(ai.origin, v_center) < 600) {
          v_dir = vectornormalize(ai.origin - v_center);
          v_launch = v_dir * randomintrange(80, 100) + (0, 0, 150);
          ai thread zm_utility::function_ffc279(v_launch);
        }
      }
    }
  }
}

function function_2ed0fa9b(instance, v_center) {
  level endon(#"end_game");

  if(!is_true(level.var_53bc31ad)) {
    return;
  }

  s_waitresult = v_center waittill(#"hash_5000b502c39b09a3");
  playrumbleonposition("sr_prototype_safehouse_rumble", s_waitresult.mdl_beacon.origin);
  a_machines = content_manager::get_children(v_center);

  foreach(s_machine in a_machines) {
    if(isDefined(s_machine.trigger)) {
      s_machine.trigger delete();
    }

    if(!isarray(s_machine.parent.a_models)) {
      continue;
    }

    foreach(model in s_machine.parent.a_models) {
      if(!isDefined(model)) {
        continue;
      }

      if(isDefined(model.trigger)) {
        model.trigger delete();
      }

      if(isDefined(model.var_e55c8b4e)) {
        if(isDefined(level.var_49f8cef4)) {
          [[level.var_49f8cef4]](model.var_e55c8b4e);
        } else {
          objective_delete(model.var_e55c8b4e);
          gameobjects::release_obj_id(model.var_e55c8b4e);
        }

        model.var_e55c8b4e = undefined;
      }

      if(isDefined(model.objectiveid)) {
        if(isDefined(level.var_49f8cef4)) {
          [[level.var_49f8cef4]](model.objectiveid);
        } else {
          objective_delete(model.objectiveid);
          gameobjects::release_obj_id(model.objectiveid);
        }

        model.objectiveid = undefined;
      }

      if(!is_true(model.var_c7f10fc1)) {
        model scene::stop();
        model thread function_5bc27bd2();
      }
    }
  }
}

function function_5bc27bd2() {
  self endon(#"death");

  if(is_true(self.var_da50f358)) {
    return;
  }

  self.var_da50f358 = 1;
  self notify(#"hash_6088c0a8269c8f8b");

  if(isDefined(self.var_7cf0a191)) {
    self[[self.var_7cf0a191]]();
  }

  playFXOnTag(#"sr/fx9_obj_exploitative_teleporting", self, "tag_origin");
  wait 1.5;
  self delete();
}

function function_ae44cb3d(instance, var_eece1f6a) {
  switch (var_eece1f6a) {
    case # "perk_machine_choice":
      if(zm_utility::is_survival()) {
        var_78a3e26a = # "hash_6e47d6576612543c";
      } else {
        var_78a3e26a = # "p9_fxanim_zm_gp_wunderfizz_on_xmodel";
      }

      namespace_82b4c2d1::function_999594fe(instance.contentgroups[# "perk_machine_choice"], #"hash_4af85251966549b8", var_78a3e26a, #"hash_3eac5ec7a888ddfb", 0);
      break;
    case # "armor_machine":
      namespace_dd7e54e3::function_1cbc3614(instance.contentgroups[# "armor_machine"]);
      break;
    case # "crafting_table":
      namespace_1cc7b406::function_7dddb953(instance.contentgroups[# "crafting_table"]);
      break;
    case # "weapon_machine":
      namespace_4b9fccd8::function_cb9d309b(instance.contentgroups[# "weapon_machine"]);
      break;
    case # "beacon":
      namespace_dbb31ff3::function_67dce9cd(instance.contentgroups[# "beacon"]);
      break;
  }
}

function function_f1bc8a08(player) {
  self endon(#"death");

  if(isDefined(player.armortier)) {
    switch (player.armortier) {
      case 0:
        self sethintstring(#"hash_5a07d4e777cd962a", "Armor Lv. 1", 500);
        break;
      case 1:
        self sethintstring(#"hash_5a07d4e777cd962a", "Armor Lv. 2", 1000);
        break;
      case 2:
        self sethintstring(#"hash_5a07d4e777cd962a", "Armor Lv. 3", 1500);
        break;
      case 3:
        if(player armor::at_peak_armor_bars()) {
          self sethintstring(#"hash_7dfea1c8f4ee103");
        } else {
          self sethintstring(#"hash_3ed2de51f2aea0ff", 1000);
        }

        break;
    }
  }
}

function function_e9bd72e8(var_7d0e37f8, instance) {
  scriptmodel = content_manager::spawn_script_model(var_7d0e37f8, "tag_origin");
  scriptmodel.origin += (0, 0, 40);
  scriptmodel clientfield::set("safehouse_claim_fx", 1);
  scriptmodel.targetname = "unclaimed_safehouse";
  trigger = content_manager::spawn_interact(var_7d0e37f8, &function_d9ea0e09, #"hash_5ecd49cccca29d87", 0, undefined, undefined, undefined, (0, 0, 40));
  trigger.instance = instance;
  trigger.scriptmodel = scriptmodel;

  if(!isDefined(instance.objectiveid)) {
    objid = zm_utility::function_f5a222a8(#"hash_5eb3b916fdb77012", scriptmodel);
    instance.objectiveid = objid;
    scriptmodel zm_utility::function_747180ea(objid, undefined, trigger);
  } else {
    objective_setvisibletoall(instance.objectiveid);
  }

  if(is_true(level.var_53bc31ad)) {
    instance thread function_67cbc98f(scriptmodel);
  }

  var_7d0e37f8.claimtrigger = trigger;
}

function function_67cbc98f(var_ce558baf) {
  level flag::wait_till(#"hash_742b43f40747c72a");

  if(isDefined(self.objectiveid)) {
    if(isDefined(var_ce558baf)) {
      var_ce558baf zm_utility::function_48d9a9c9();
    }

    objective_setinvisibletoall(self.objectiveid);
  }
}

function function_83b6d24a() {
  foreach(location in level.contentmanager.locations) {
    safehouse = location.instances[# "safehouse"];

    if(isDefined(safehouse.contentgroups[# "claim_interact"][0].claimtrigger)) {
      trigger = safehouse.contentgroups[# "claim_interact"][0].claimtrigger;
      trigger sethintstring(#"hash_6d645426c03ab096");
    }
  }
}

function function_2b1da4a6() {
  foreach(location in level.contentmanager.locations) {
    safehouse = location.instances[# "safehouse"];

    if(isDefined(safehouse.contentgroups[# "claim_interact"][0].claimtrigger)) {
      trigger = safehouse.contentgroups[# "claim_interact"][0].claimtrigger;
      trigger sethintstring(#"hash_5ecd49cccca29d87", 0);
    }
  }
}

function function_7fa49a26(instance, var_56fa2ec1) {
  instance.var_1dab08f1 = var_56fa2ec1;
}

function private function_9d178321() {
  level flag::wait_till(#"hash_7ace2c0d668c5128");

  foreach(location in level.contentmanager.locations) {
    safehouse = location.instances[# "safehouse"];

    if(isDefined(safehouse)) {
      a_structs = struct::get_array(safehouse.targetname, "target");

      foreach(struct in a_structs) {
        if(struct.content_key === # "zed") {
          safehouse.var_8947b368 = content_manager::spawn_script_model(struct, #"toy_stuffed_animal_monkey_01");
          safehouse.var_8947b368 val::set(#"zed", "allowdeath", 0);
          safehouse.s_ee = struct;
          return;
        }
      }
    }
  }
}

function private function_98715738(instance) {
  foreach(location in level.contentmanager.locations) {
    safehouse = location.instances[# "safehouse"];

    if(isDefined(safehouse.var_8947b368)) {
      var_8947b368 = safehouse.var_8947b368;
      s_ee = safehouse.s_ee;
      break;
    }
  }

  if(isDefined(var_8947b368) && isDefined(s_ee)) {
    var_8947b368 val::set(#"zed", "takedamage", 1);
    s_result = var_8947b368 waittill(#"damage", #"death");
    player = s_result.attacker;

    if(isPlayer(player) && player getstance() === "crouch") {
      weapon = player getcurrentweapon();
      wait 5;

      if(isalive(player) && player getstance() === "prone" && weapon !== player getcurrentweapon()) {
        s_ee.angles += (0, 90, 0);
        s_ee thread namespace_65181344::function_fd87c780(#"survival_ee_special_drops", 1, 2);
      }
    }
  }
}

function init_devgui() {
  util::waittill_can_add_debug_command();
  level thread function_dab40c5f();
  adddebugcommand("<dev string:xc8>");
  util::add_devgui(content_manager::devgui_path("<dev string:xf3>", 105), "<dev string:x10c>");
}

function function_dab40c5f() {
  while(true) {
    if(getdvarint(#"hash_112f254e6d461fd6", 0)) {
      setDvar(#"hash_112f254e6d461fd6", 0);
      instance = level.contentmanager.var_c4181ea;

      if(isDefined(instance)) {
        foreach(player in getplayers()) {
          player setorigin(instance.origin);
        }
      }
    }

    wait 0.1;
  }
}