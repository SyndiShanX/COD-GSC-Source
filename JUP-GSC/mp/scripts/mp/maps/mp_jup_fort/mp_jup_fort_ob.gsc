/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_fort\mp_jup_fort_ob.gsc
**********************************************************/

#using script_100adcc1cc11d2fa;
#using script_1be98242d2bd926e;
#using script_1c6e50e1bfd8faaa;
#using script_2047cdbf5176ba0;
#using script_355d3dcecb9a21f4;
#using script_4e6e58ab5d96c2b0;
#using script_528320cb3630530d;
#using script_60659e03a44888ce;
#using script_7d3d10da73f1f763;
#using script_92b815b18f0ba61;
#using script_afd81a5975a288c;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\maps\mp_jup_fort\mp_jup_fort_lighting;
#using scripts\ob\ob_rift_gate;
#namespace mp_jup_fort_ob;

function autoexec init() {
  level.var_870202fb30967234 = &main;
}

function main() {
  setDvar(@ "hash_2fe0283b419ff08a", 1);
  function_eb7f544259415a09("mp_jup_fort_ob");
  level.var_60af3227c0f55adf = 1;
  level.var_b017944f02bb5e97 = 1;
  level.outofboundstriggers = getEntArray("OutOfBounds_ob", "targetname");
  level.var_db80981879714f15 = &namespace_b000de497fab9bf4::function_348e0a3041479e64;
  function_40e7fdd70c68231f();
  namespace_b000de497fab9bf4::function_c9eea6ea790d37bd();
  namespace_36b345dc7ec3503e::main();
  namespace_d1d97996bcffb010::main();
  namespace_35558fc001df04a::main();
  scripts\engine\utility::flag_set("lockedspaces_create_script_initialized");
  thread scripts\mp\maps\mp_jup_fort\mp_jup_fort_lighting::main();
  thread function_135c08561081b6cf();
  thread disable_announcer();

  if(getdvarint(@ "ob_rift_run", 0)) {
    ob_music::function_43983d74c830fa72("outbreak_riftrun");
    level callback::add("player_spawned", &namespace_6f390e4fde2064d::function_2dcca6d862cc31d5);
    level callback::add("player_connect", &function_c154e3abec6b5381);
    level callback::add("register_features", &namespace_6f390e4fde2064d::function_dc150a1bb8f2dfde);
    level callback::add("register_activities", &namespace_6f390e4fde2064d::function_94d29d832035af94);
    level callback::add("ob_dark_aether_exit_used", &namespace_6f390e4fde2064d::function_61aea37385c298a9);
    level callback::add("register_objectives", &namespace_6f390e4fde2064d::function_5d39bca170851543);
    level callback::add("on_zombie_ai_spawned", &namespace_6f390e4fde2064d::function_c0ec711e1ca76fd7);
    level callback::add("outlast_phase_crystals_destroyed", &scripts\mp\maps\mp_jup_fort\mp_jup_fort_lighting::function_bfd6485208f4b621);

    if(!getdvarint(@ "hash_abc1d9ea495ec189", 0)) {
      callback::add("player_item_drop", &scripts\ob\ob_rift_gate::on_item_drop);
    }

    thread function_9afbb024ba4b1116();
    namespace_d38a1af3e02dea2f::function_48e697a59457ec45();
    thread namespace_6f390e4fde2064d::function_b74088644ee18731();
    return;
  }

  if(getdvarint(@ "hash_596076b5ab54d511", 0)) {
    level callback::add("player_spawned", &namespace_6f390e4fde2064d::function_2dcca6d862cc31d5);
    level callback::add("player_connect", &function_c154e3abec6b5381);
    level callback::add("register_features", &namespace_6f390e4fde2064d::function_dc150a1bb8f2dfde);
    level callback::add("register_activities", &namespace_6f390e4fde2064d::function_94d29d832035af94);

    if(!getdvarint(@ "hash_abc1d9ea495ec189", 0)) {
      callback::add("player_item_drop", &scripts\ob\ob_rift_gate::on_item_drop);
    }

    thread function_9afbb024ba4b1116();
    namespace_865fadac6587933f::main();
    thread namespace_1accee5a5436c3b4::function_3dd46b5ca402d985();
    thread function_632bf331b85b85ac();
    return;
  }

  if(getdvarint(@ "ob_unstable_rift", 0)) {
    utility::callsharedfunc("ob_unstable_rift", "init_map");
    utility::callsharedfunc("ob_unstable_rift", "init_mode");
  }
}

function disable_announcer() {
  level flag_wait("ob_infil_completed");
  level.disableannouncer = 1;
}

function function_c154e3abec6b5381(sparams) {
  delaythread(0.5, &function_1b4c60d1baa7885f, "outbreak_riftrun");
}

function function_9afbb024ba4b1116() {
  level flag_wait("ai_spawn_director_initialized");

  if(getdvarint(@ "ob_rift_run", 0)) {
    function_9b8829ab4092a7d7("ob_rift_run", 1);
    function_9b8829ab4092a7d7("ob_zombie_ambient", 0);
  } else {
    function_9b8829ab4092a7d7("ob_zombie_ambient", 1);
  }

  setDvar(@ "hash_f1d095735ac37f33", 1);
  a_blockers = getStructArray("s_ambient_blocker", "targetname");

  foreach(pos in a_blockers) {
    if(isDefined(pos.radius)) {
      function_606642b946a01237("ambient_blocker", pos.origin, pos.radius, 1);
    }
  }
}

function function_135c08561081b6cf() {
  level flag_wait("ai_spawn_director_initialized");
  scripts\cp_mp\agents\ai_spawn_director::process_create_script();
}

function function_632bf331b85b85ac() {
  level flag_wait("ob_infil_completed");
  var_aa44570d0ce3af7c = [];
  var_cd05af3824c52cde = getentitylessscriptablearray("s_outlast_fort", "target");

  foreach(prop_scriptable in var_cd05af3824c52cde) {
    if(is_equal(prop_scriptable.script_noteworthy, "outlast_phase_crystal")) {
      if(!isDefined(prop_scriptable.targetname)) {
        continue;
      }

      switch (prop_scriptable.targetname) {
        case #"hash_3fc1dec043e7c2ed":
          prop_scriptable setscriptablepartstate("body", "enabled_outlast_phase_crystal_01");
          break;
        case #"hash_4f4b067cdd2a227d":
          prop_scriptable setscriptablepartstate("body", "enabled_outlast_phase_crystal_02");
          break;
        case #"hash_fafe02a60e439165":
          prop_scriptable setscriptablepartstate("body", "enabled_outlast_phase_crystal_03");
          break;
        case #"hash_9ceae540f6c4f91f":
          prop_scriptable setscriptablepartstate("body", "enabled_outlast_phase_crystal_04");
          break;
        case #"hash_3e70bc44fce010a4":
          prop_scriptable setscriptablepartstate("body", "enabled_outlast_phase_crystal_05");
          break;
        case #"hash_59ca4af302edd1d9":
          prop_scriptable setscriptablepartstate("body", "enabled_outlast_phase_crystal_06");
          break;
      }

      continue;
    }

    if(is_equal(prop_scriptable.targetname, "outlast_aether_vfx_prop") && isDefined(prop_scriptable.script_noteworthy) && prop_scriptable getscriptableparthasstate("body", prop_scriptable.script_noteworthy)) {
      prop_scriptable setscriptablepartstate("body", prop_scriptable.script_noteworthy);
      continue;
    }

    if(prop_scriptable getscriptableparthasstate("body", "enabled")) {
      prop_scriptable setscriptablepartstate("body", "enabled");
      continue;
    }

    if(prop_scriptable getscriptableparthasstate("base", "enabled")) {
      prop_scriptable setscriptablepartstate("base", "enabled");
    }
  }
}