/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7c3f86aa290a6354.gsc
***********************************************/

#using script_3411bb48d41bd3b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\item_inventory;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_score;
#namespace namespace_4faef43b;

function private autoexec __init__system__() {
  system::register(#"hash_3793eb4a6c52c66f", &__init__, undefined, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "" + # "hash_322ed89801938bb9", 1, 1, "counter");
  clientfield::register("scriptmover", "" + # "hash_6d9aa5215e695ca2", 1, 1, "counter");
  clientfield::register("scriptmover", "" + # "hash_1f232116f775fa91", 1, 1, "counter");
  clientfield::register("scriptmover", "" + # "hash_4719ef7fda616f3a", 1, 1, "counter");
  clientfield::register_clientuimodel("hudItems.reinforcing", 1, 1, "int", 0);
  level thread init_doors();
  level thread function_e5d01ba1();
  level.var_dd9a04c9 = 0;
  callback::on_player_killed(&on_player_killed);
}

function on_player_killed(death_params) {
  self clientfield::set_player_uimodel("hudItems.reinforcing", 0);
}

function function_3dfeef3b(reinforcing = 0) {
  self clientfield::set_player_uimodel("hudItems.reinforcing", reinforcing);
}

function init_doors() {
  var_51eefac8 = array("p9_sr_barricade_01_window_01", "p9_sr_barricade_01_window_01", "p9_sr_barricade_01_window_01", "p9_sr_barricade_01_window_01_dmg_a", "p9_sr_barricade_01_window_01_dmg_a", "p9_sr_barricade_01_window_01_dmg_a", "p9_sr_barricade_01_window_01_dmg_b", "p9_sr_barricade_01_window_01_dmg_b", "p9_sr_barricade_01_window_01_dmg_b");
  door_structs = struct::get_array("survival_door");

  foreach(door_struct in door_structs) {
    door_struct.var_a7417bea = var_51eefac8;
    door_struct.s_boards = arraygetclosest(door_struct.origin, struct::get_array("survival_door_boards"));
    use_trigger = spawn("trigger_radius_use", door_struct.origin, 0, 96, 96, 1);
    assert(isDefined(use_trigger));
    use_trigger triggerignoreteam();
    use_trigger setvisibletoall();
    use_trigger setteamfortrigger(#"none");
    use_trigger setcursorhint("HINT_NOICON");
    use_trigger sethintstring(#"hash_e0e56e669b6a886");
    use_trigger usetriggerignoreuseholdtime();
    door_model = spawn("script_model", door_struct.origin);
    assert(isDefined(door_model));
    door_model.angles = door_struct.angles;
    door_model.health = 10000000;
    door_model setCanDamage(1);
    door_model setModel("p8_wz_door_01");
    door_model.var_1c553fa4 = 1;
    door_model.damage_level = 0;
    door_model.var_27a45076 = 0;
    door_model.reinforced = 0;
    door_struct.trigger = use_trigger;
    door_struct.door = door_model;
    use_trigger.parent_struct = door_struct;
    door_model.parent_struct = door_struct;
    var_8b4e689b = spawn("trigger_radius", door_struct.origin, 0, 96, 96);
    var_8b4e689b.parent_struct = door_struct;
    var_8b4e689b thread function_6a3e8a89();
    use_trigger callback::on_trigger_once(&door_think);
    namespace_85745671::function_1ede0cd3(door_struct.target, door_struct.door, 1);
    function_be2c24a3(door_struct.target, 0);
  }
}

function function_6a3e8a89() {
  level endon(#"game_ended");

  while(true) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;
    var_b1336156 = gettime();
    elapsed_time = 0;
    parent_struct = self.parent_struct;
    door = self.parent_struct.door;

    while(isalive(player) && player istouching(self) && player useButtonPressed() && elapsed_time < 0.5) {
      elapsed_time = float(gettime() - var_b1336156) / 1000;
      progress = elapsed_time / 0.5;
      n_resource = player zm_score::function_ffc2d0bc();

      if(!isDefined(self.parent_struct.door)) {
        var_b9fbcc94 = 0;
      } else {
        var_b9fbcc94 = 0;
      }

      if(isDefined(n_resource) && n_resource >= var_b9fbcc94 && elapsed_time > 0.1) {
        if(!isDefined(door) || isDefined(door.damage_level) && door.damage_level > 0 || !is_true(door.reinforced)) {
          player clientfield::set_player_uimodel("hudItems.dynentUseHoldProgress", progress);
          player function_3dfeef3b(1);

          if(isDefined(self.parent_struct.trigger)) {
            self.parent_struct.trigger sethintstring("");
          }
        }
      }

      waitframe(1);
    }

    player function_3dfeef3b(0);

    if(elapsed_time >= 0.5) {
      n_resource = player zm_score::function_ffc2d0bc();

      if(!isDefined(self.parent_struct.door)) {
        var_b9fbcc94 = 0;
      } else {
        var_b9fbcc94 = 0;
      }

      if(isDefined(n_resource) && n_resource >= var_b9fbcc94) {
        var_c598073c = parent_struct function_55859752();

        if(var_c598073c) {
          player zm_score::minus_to_player_score(var_b9fbcc94);

          if(isDefined(self.parent_struct.trigger)) {
            self.parent_struct.trigger function_dae4ab9b(0.3);
            self.parent_struct.trigger sethintstring(#"");
          }
        }
      }

      continue;
    }

    if(!isDefined(self.parent_struct.door)) {
      self.parent_struct.trigger sethintstring(#"hash_3d9e6b6b1984617d");
      continue;
    }

    if(self.parent_struct.door.var_27a45076 === -1 || self.parent_struct.door.var_27a45076 === 1) {
      if(!is_true(self.parent_struct.door.reinforced)) {
        self.parent_struct.trigger sethintstring(#"hash_3197c6dc91249ca2");
      }

      continue;
    }

    if(!is_true(self.parent_struct.door.reinforced)) {
      self.parent_struct.trigger sethintstring(#"hash_e0e56e669b6a886");
    }
  }
}

function private door_think(eventstruct) {
  player = eventstruct.activator;
  parent_struct = self.parent_struct;
  door = self.parent_struct.door;

  if(isDefined(door) && is_true(door.reinforced)) {
    self thread function_48a16d8d(player, &door_think);
    return;
  }

  if(isDefined(door)) {
    current_angles = door.angles;
    var_f6f828b2 = (0, 90, 0) + current_angles;
    var_bc7389e4 = (0, -90, 0) + current_angles;
    in_front = vectordot(player.origin - door.origin, anglesToForward(door.angles)) > 0;

    if(door.var_27a45076 == 0 && in_front) {
      door rotateto(var_f6f828b2, 0.5);
      door.var_27a45076 = 1;
      function_be2c24a3(parent_struct.target, 1);

      if(!is_true(door.reinforced)) {
        self sethintstring(#"hash_3197c6dc91249ca2");
      } else {
        self sethintstring(#"hash_3df5eb7de3fa5e80");
      }
    } else if(door.var_27a45076 == 0 && !in_front) {
      door rotateto(var_bc7389e4, 0.5);
      door.var_27a45076 = -1;
      function_be2c24a3(parent_struct.target, 1);

      if(!is_true(door.reinforced)) {
        self sethintstring(#"hash_3197c6dc91249ca2");
      } else {
        self sethintstring(#"hash_3df5eb7de3fa5e80");
      }
    } else if(door.var_27a45076 == 1) {
      door rotateto(var_bc7389e4, 0.5);
      door.var_27a45076 = 0;
      function_be2c24a3(parent_struct.target, 0);

      if(!is_true(door.reinforced)) {
        self sethintstring(#"hash_e0e56e669b6a886");
      }
    } else if(door.var_27a45076 == -1) {
      door rotateto(var_f6f828b2, 0.5);
      door.var_27a45076 = 0;
      function_be2c24a3(parent_struct.target, 0);

      if(!is_true(door.reinforced)) {
        self sethintstring(#"hash_e0e56e669b6a886");
      }
    }

    if(door.var_27a45076 == 0) {
      door namespace_85745671::function_aa894590();
    } else {
      door namespace_85745671::function_a63a9610();
    }

    self thread function_be463e75(0.5, &door_think);
    return;
  }

  self sethintstring(#"hash_3d9e6b6b1984617d");
  self thread function_48a16d8d(player, &door_think);
}

function event_handler[event_1524de24] on_scriptmover_damage(eventstruct) {
  parent_struct = self.parent_struct;

  if(!isDefined(parent_struct)) {
    return;
  }

  if(parent_struct.targetname == "survival_door") {
    self function_ae47792b(eventstruct);
    return;
  }

  if(parent_struct.targetname == "survival_window") {
    self function_994e81b7(eventstruct);
  }
}

function function_ae47792b(eventstruct) {
  self endon(#"death", #"destroyed");
  self.health = 10000000;
  parent_struct = self.parent_struct;

  if(!is_true(self.var_1c553fa4)) {
    return;
  }

  if(isactor(eventstruct.attacker) && (eventstruct.mod === "MOD_MELEE" || eventstruct.mod === "MOD_EXPLOSIVE")) {
    self.damage_level++;

    if(self.var_27a45076 === 0) {
      self.parent_struct.trigger sethintstring(#"hash_330249c707d8e92b");
    }
  }

  if(!isDefined(self.parent_struct.fx_org)) {
    self.parent_struct.fx_org = spawn("script_model", self.origin);
    self.parent_struct.fx_org.angles = self.angles;
    waitframe(1);
  }

  if(self.damage_level > 8 || !self.reinforced && self.damage_level > 4) {
    self.parent_struct.fx_org clientfield::increment("" + # "hash_6d9aa5215e695ca2");

    if(level flag::get("obj_defend_start") && !level flag::get("obj_defend_complete") && level.var_dd9a04c9 < 3) {
      level thread globallogic_audio::leader_dialog("objectiveDefendBarrierBroken");
      level.var_dd9a04c9++;
    }

    if(!self.reinforced) {
      self playSound(#"hash_75beb5fd873ee815");
    } else {
      self playSound(#"hash_15d3a67feb395a2a");
    }

    function_be2c24a3(self.parent_struct.target, 1);
    self.parent_struct.trigger sethintstring(#"hash_3d9e6b6b1984617d");
    waittillframeend();
    self delete();
    return;
  }

  if(self.reinforced) {
    if(self.model != parent_struct.var_a7417bea[self.damage_level]) {
      self.parent_struct.fx_org clientfield::increment("" + # "hash_322ed89801938bb9");
    }

    self playSound(#"hash_7c72cea06ae4906c");
    self setModel(parent_struct.var_a7417bea[self.damage_level]);
    self.origin = parent_struct.s_boards.origin;
    self setscale(parent_struct.s_boards.modelscale);
    self thread function_9801cde9();
  }
}

function function_9801cde9() {
  self endon(#"death");
  self.var_1c553fa4 = 0;
  wait 1;
  self.var_1c553fa4 = 1;
}

function function_55859752() {
  door = self.door;

  if(!isDefined(door)) {
    door = spawn("script_model", self.origin);
    assert(isDefined(door));
    door.angles = self.angles;
    door.health = 10000000;
    door setCanDamage(1);
    door.var_27a45076 = 0;
    self.door = door;
    door.parent_struct = self;
    function_be2c24a3(self.target, 0);
  } else if(door.reinforced && door.damage_level <= 0 || door.var_27a45076 != 0) {
    return false;
  }

  door.damage_level = 0;
  door.var_1c553fa4 = 1;
  door setModel(self.var_a7417bea[door.damage_level]);
  door.origin = self.s_boards.origin;
  door setscale(self.s_boards.modelscale);
  door.reinforced = 1;
  namespace_85745671::function_1ede0cd3(self.target, self.door);
  door playSound(#"hash_4ef96dfa0f645331");
  return true;
}

function private function_e5d01ba1() {
  var_23c777e4 = array("p9_sr_barricade_01_window_01", "p9_sr_barricade_01_window_01", "p9_sr_barricade_01_window_01_dmg_a", "p9_sr_barricade_01_window_01_dmg_a", "p9_sr_barricade_01_window_01_dmg_b", "p9_sr_barricade_01_window_01_dmg_b");
  var_7f2b410c = array("p9_sr_barricade_01_window_02", "p9_sr_barricade_01_window_02", "p9_sr_barricade_01_window_02_dmg_a", "p9_sr_barricade_01_window_02_dmg_a", "p9_sr_barricade_01_window_02_dmg_b", "p9_sr_barricade_01_window_01_dmg_b");
  var_dbba5e0 = struct::get_array("survival_window");

  foreach(window_boards in var_dbba5e0) {
    window_boards.var_811c2d3a = undefined;

    if(window_boards.var_cd17ea88 == "window_01") {
      window_boards.var_811c2d3a = var_23c777e4;
    } else if(window_boards.var_cd17ea88 == "window_02") {
      window_boards.var_811c2d3a = var_7f2b410c;
    }

    window_trigger = spawn("trigger_radius", window_boards.origin, 0, 64, 80, 1);
    assert(isDefined(window_trigger));
    window_trigger triggerignoreteam();
    window_trigger setvisibletoall();
    window_trigger usetriggerrequirelookat();
    window_trigger setcursorhint("HINT_NOICON");
    window_trigger sethintstring(#"hash_3766e0d30f6782ad");
    window_trigger.window_boards = window_boards;
    window_boards.trigger = window_trigger;
    window_trigger.parent_struct = window_boards;
    window_trigger thread function_51095a3d();
  }
}

function private function_51095a3d() {
  level endon(#"game_ended");

  while(true) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;
    parent_struct = self.parent_struct;
    var_b1336156 = gettime();
    elapsed_time = 0;

    if(!isDefined(self.window_boards.window.model) || isDefined(self.window_boards.window.damage_level) && self.window_boards.window.damage_level > 0) {
      while(isalive(player) && player istouching(self) && player util::is_player_looking_at(self.parent_struct.origin, 0.8) && player useButtonPressed() && elapsed_time < 1.5) {
        elapsed_time = float(gettime() - var_b1336156) / 1000;
        progress = elapsed_time / 1.5;
        n_resource = player zm_score::function_ffc2d0bc();

        if(!isDefined(self.parent_struct.window)) {
          var_b9fbcc94 = 0;
        } else {
          var_b9fbcc94 = 0;
        }

        if(isDefined(n_resource) && n_resource >= var_b9fbcc94 && elapsed_time > 0.1) {
          player clientfield::set_player_uimodel("hudItems.dynentUseHoldProgress", progress);
          player function_3dfeef3b(1);
          self sethintstring("");
        }

        waitframe(1);
      }
    }

    player function_3dfeef3b(0);

    if(elapsed_time >= 1.5 && player util::is_player_looking_at(self.parent_struct.origin, 0.8)) {
      n_resource = player zm_score::function_ffc2d0bc();

      if(!isDefined(self.parent_struct.window)) {
        var_b9fbcc94 = 0;
      } else {
        var_b9fbcc94 = 0;
      }

      if(isDefined(n_resource) && n_resource >= var_b9fbcc94) {
        if(isDefined(n_resource) && n_resource >= var_b9fbcc94) {
          var_c598073c = parent_struct function_673a485();

          if(var_c598073c) {
            player zm_score::minus_to_player_score(var_b9fbcc94);
            self sethintstring("");
            self.parent_struct.window notify(#"repaired");
          }
        }
      }

      continue;
    }

    if(!isDefined(self.parent_struct.window)) {
      self sethintstring(#"hash_3766e0d30f6782ad");
      continue;
    }

    if(isDefined(self.parent_struct.window.damage_level) && self.parent_struct.window.damage_level > 0) {
      self sethintstring(#"hash_7b18ee0053fc3a7b");
    }
  }
}

function private function_994e81b7(eventstruct) {
  self endon(#"death", #"destroyed");
  self.health = 10000000;

  if(!is_true(self.var_1c553fa4)) {
    return;
  }

  if(isactor(eventstruct.attacker) && (eventstruct.mod === "MOD_MELEE" || eventstruct.mod === "MOD_EXPLOSIVE")) {
    self.damage_level++;
  }

  if(!isDefined(self.parent_struct.fx_org)) {
    self.parent_struct.fx_org = spawn("script_model", self.origin);
    self.parent_struct.fx_org.angles = self.angles;
    waitframe(1);
  }

  if(self.damage_level > 5) {
    self.parent_struct.fx_org clientfield::increment("" + # "hash_4719ef7fda616f3a");
    self playSound(#"hash_bf0f566d836c8a2");
    self.parent_struct.trigger sethintstring(#"hash_3766e0d30f6782ad");
    waittillframeend();
    self delete();
    return;
  }

  if(self.damage_level > 0) {
    if(self.model != self.parent_struct.var_811c2d3a[self.damage_level]) {
      self.parent_struct.fx_org clientfield::increment("" + # "hash_1f232116f775fa91");
    }

    self playSound(#"hash_6d3a81cd3c4049f4");
    self setModel(self.parent_struct.var_811c2d3a[self.damage_level]);
    self.parent_struct.trigger sethintstring(#"hash_7b18ee0053fc3a7b");

    if(!isPlayer(eventstruct.attacker)) {
      self thread function_82c85f70();
    }
  }
}

function function_82c85f70() {
  self endon(#"death");
  self.var_1c553fa4 = 0;
  wait 0.5;
  self.var_1c553fa4 = 1;
}

function function_673a485() {
  window = self.window;

  if(!isDefined(window)) {
    window = spawn("script_model", self.origin);
    assert(isDefined(window));
    window.angles = self.angles;
    window.health = 10000000;
    window setCanDamage(1);
    self.window = window;
    window.parent_struct = self;
  } else if(window.damage_level <= 0) {
    return false;
  }

  window.damage_level = 0;
  window.var_1c553fa4 = 1;
  window setModel(self.var_811c2d3a[window.damage_level]);
  window playSound(#"hash_65d45ffe1b39c009");
  namespace_85745671::function_1ede0cd3(self.target, self.window);
  return true;
}

function private function_48a16d8d(activator, func) {
  level endon(#"game_ended");

  while(activator useButtonPressed()) {
    waitframe(1);
  }

  self callback::on_trigger_once(func);
}

function private function_be463e75(delay, func) {
  level endon(#"game_ended");
  wait delay;
  self callback::on_trigger_once(func);
}

function private function_be2c24a3(var_6de4a710, value) {
  if(!isDefined(var_6de4a710)) {
    return;
  }

  var_e86e150a = undefined;

  if(ispathnode(var_6de4a710)) {
    var_e86e150a = var_6de4a710;
  } else {
    var_e86e150a = getnode(var_6de4a710, "targetname");
  }

  if(isDefined(var_e86e150a)) {
    other_node = namespace_85745671::function_5a4a952a(var_e86e150a);
    function_dc0a8e61(var_e86e150a, value);

    if(isDefined(other_node)) {
      function_dc0a8e61(other_node, value);
    }
  }
}