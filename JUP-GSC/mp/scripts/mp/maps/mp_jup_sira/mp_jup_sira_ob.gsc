/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_sira\mp_jup_sira_ob.gsc
*************************************************************/

#using script_100adcc1cc11d2fa;
#using script_15ecde6c46a131b0;
#using script_2047cdbf5176ba0;
#using script_231b61569cad7b2;
#using script_25d8bf4d117350f3;
#using script_387aedcdc1d5f902;
#using script_3b037cef6d23090b;
#using script_48a11db4632a4042;
#using script_4e6e58ab5d96c2b0;
#using script_528320cb3630530d;
#using script_711820027508efbb;
#using script_712b2709e2e169ea;
#using script_7e681eb8fbdc4f5e;
#using script_92b815b18f0ba61;
#using scripts\common\callbacks;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\maps\mp_jup_sira\mp_jup_sira_lighting;
#namespace mp_jup_sira_ob;

function autoexec init() {
  level.var_cf32182eec3bc910 = &main;
}

function main() {
  setDvar(@ "hash_2fe0283b419ff08a", 1);
  function_eb7f544259415a09("mp_jup_sira_ob");
  level.var_60af3227c0f55adf = 1;
  level.var_b017944f02bb5e97 = 1;
  level.outofboundstriggers = getEntArray("OutOfBounds_ob", "targetname");
  level.var_db80981879714f15 = &namespace_b000de497fab9bf4::function_348e0a3041479e64;
  function_a397a005277bf6df();
  namespace_b000de497fab9bf4::function_c9eea6ea790d37bd();
  function_43983d74c830fa72("outbreak_riftrun");
  callback::add("player_spawned", &function_2dcca6d862cc31d5);
  callback::add("player_connect", &function_c154e3abec6b5381);
  namespace_b5341cf5cfc91b36::main();
  namespace_9d587018045b8b98::main();
  namespace_e71ed1e132bcd182::main();
  scripts\engine\utility::flag_set("lockedspaces_create_script_initialized");
  thread scripts\mp\maps\mp_jup_sira\mp_jup_sira_lighting::main();
  thread function_135c08561081b6cf();
  thread disable_announcer();
  thread function_b93fb821b8d8035e();
  thread function_4dd5d69d550c0999();
  thread function_f3e573baf0974858();
  level thread function_3106d895f0955848();
  level callback::add("register_features", &function_8f4bf0e19a5adf56);

  if(getdvarint(@ "hash_c385fef4df4638cb", 0)) {
    level callback::add("register_activities", &function_9699376ba1b63be0);
    level callback::add("register_objectives", &function_8590c1ef54dc93cf);
    level callback::add("ob_dark_aether_exit_used", &function_61aea37385c298a9);
    level callback::add("on_zombie_ai_spawned", &function_c0ec711e1ca76fd7);
    level callback::add("outlast_phase_crystals_destroyed", &scripts\mp\maps\mp_jup_sira\mp_jup_sira_lighting::function_bfd6485208f4b621);
    namespace_d38a1af3e02dea2f::function_48e697a59457ec45();
    thread function_88d1cace9dd87631();
    return;
  }

  if(getdvarint(@ "hash_3a4e983e54a9ae7e", 0)) {
    level callback::add("register_activities", &function_5b64b44ac4335194);
    level callback::add("register_objectives", &function_a420046da7bae925);
    namespace_d38a1af3e02dea2f::function_48e697a59457ec45();
    namespace_932cd7b76b4df76a::main();
    namespace_132af1548678fcbe::main();
    level thread function_46d73bb45da26012();
    level thread namespace_a1cde428d7647a68::function_ab13526d8a324001();
    level thread namespace_b311bec7b243be6d::function_58176ae2f61825a8();
    level thread namespace_68270f885c7fd3ef::function_88afb65283d1a3e();
  }
}

function disable_announcer() {
  level flag_wait("ob_infil_completed");
  level.disableannouncer = 1;
}

function function_c154e3abec6b5381(sparams) {
  delaythread(0.5, &function_1b4c60d1baa7885f, "outbreak_riftrun");
}

function function_b93fb821b8d8035e() {
  level flag_wait("ai_spawn_director_initialized");

  if(getdvarint(@ "hash_c385fef4df4638cb", 0)) {
    function_9b8829ab4092a7d7("ob_rift_run", 1);
    function_9b8829ab4092a7d7("ob_rift_run_zombie_ambient", 1);
    function_9b8829ab4092a7d7("ob_zombie_ambient", 0);

    if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
      function_9b8829ab4092a7d7("ob_rift_run_hard", 1);
    } else {
      function_9b8829ab4092a7d7("ob_rift_run_normal", 1);
    }
  } else {
    function_9b8829ab4092a7d7("ob_zombie_ambient", 1);
    function_9b8829ab4092a7d7("ob_rift_story", 1);
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

function function_46d73bb45da26012() {
  level flag_wait("ai_spawn_director_initialized");
  a_blockers = getStructArray("ambient_blocker_story_mission", "targetname");

  foreach(pos in a_blockers) {
    if(isDefined(pos.radius)) {
      function_606642b946a01237("ambient_blocker", pos.origin, pos.radius, 1);
    }
  }
}

function private function_4dd5d69d550c0999() {
  level endon("game_ended");
  scrambler = spawn("script_model", function_dc80e43dced96932());
  scrambler forcenetfieldhighlod(1);
  n_radius = int(default_to(function_868dda939525d6dd(), 10000));

  while(true) {
    if(!isDefined(level.players) || level.players.size < 1) {
      waitframe();
      continue;
    }

    owner = random(level.players);
    scrambler.team = owner.team;
    scrambler makescrambler(owner, undefined, n_radius, 1);
    owner waittill("disconnect");
    scrambler clearscrambler();
  }
}

function private function_dc80e43dced96932() {
  a_corners = getStructArray("minimap_corner", "targetname");
  v_loc = (0, 0, 0);

  if(a_corners.size) {
    foreach(corner in a_corners) {
      v_loc += corner.origin;
    }

    v_loc /= a_corners.size;
  }

  return v_loc;
}

function private function_868dda939525d6dd() {
  a_corners = getStructArray("minimap_corner", "targetname");

  if(a_corners.size > 1) {
    return (distance2d(a_corners[0].origin, a_corners[1].origin) / 1.9);
  }
}

function function_f3e573baf0974858() {
  level.var_fd811442ea11f020 = 0;
  var_f407b42a960afd35 = getStructArray("meteorite_spawn", "targetname");

  foreach(spawnpoint in var_f407b42a960afd35) {
    meteorite = spawnscriptable("jup_season2_5_ob_meteorite_ee", spawnpoint.origin);
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("meteor_interact", &function_f19f21e5a0b646dc);
  }
}

function function_f19f21e5a0b646dc(instance, part, state, player, bautouse, usestring) {
  if(isDefined(instance)) {
    player playSound("evt_ob_rr_meteor_affirm");
    level.var_fd811442ea11f020++;

    if(level.var_fd811442ea11f020 >= 3) {
      foreach(player in level.players) {
        player playlocalsound("mus_ob_rr_easteregg_115_instrumental");
      }
    }

    instance freescriptable();
  }
}

function function_3106d895f0955848() {
  level flag_wait("ob_infil_completed");
  wait 25;
  agentteam = "axis";

  if(isDefined(level.players[0])) {
    agentteam = level.players[0].team;
  }

  var_ecefa5152147562a = agentteam + "_Infil";
  function_c7311cb3f768f21e(var_ecefa5152147562a, 0);
}