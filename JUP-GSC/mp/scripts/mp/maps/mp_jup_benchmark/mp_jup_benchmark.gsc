/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_benchmark\mp_jup_benchmark.gsc
********************************************************************/

#using script_21eb8cfd25d4abbc;
#using script_48554021bb847168;
#using script_68c9c628ce1ce624;
#using script_7e6e889d00ab1286;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\killstreaks\nuke;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\compass;
#using scripts\mp\equipment;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_benchmark\gen\mp_jup_benchmark_art;
#using scripts\mp\maps\mp_jup_benchmark\mp_jup_benchmark_fx;
#using scripts\mp\maps\mp_jup_benchmark\mp_jup_benchmark_lighting;
#using scripts\mp\mp_agent;
#using scripts\mp\supers;
#using scripts\mp\utility\perk;
#namespace mp_jup_benchmark;

function private function_1810f6c6a90c53d() {
  return [[(192.147, 1094.27, 190), (480.685, 1175.19, 220), 200, 125], [(142.409, 1020.34, 190), (406.228, 910.804, 350), 200, 125], [(775.737, 940.13, 190), (584.311, 694.218, 190), 200, 125], [(706, 645, 190), (415.706, 553.773, 250), 200, 125], [(527.916, 866.856, 190), (773.593, 808.744, 212), 200, 125], [(747.244, 721.516, 190), (490.199, 757.905, 190), 200, 125], [(102.408, 1116.22, 190), (404.405, 912.98, 220), 200, 125], [(480.756, 998.738, 190), (763.39, 913.954, 190), 200, 125]];
}

function private function_f6c2f942cbce9169() {
  return [function_f6baf57ea0d666fe(int(ceil(function_1534e73bf007553d())), &function_6ce435ce33ba4791), function_f6baf57ea0d666fe(7, undefined, &function_d6a05bb507f63966), function_f6baf57ea0d666fe(16), function_f6baf57ea0d666fe(13), function_f6baf57ea0d666fe(11)];
}

function main() {
  initdvars();
  scripts\mp\maps\mp_jup_benchmark\gen\mp_jup_benchmark_art::main();
  scripts\mp\maps\mp_jup_benchmark\mp_jup_benchmark_fx::main();
  scripts\mp\maps\mp_jup_benchmark\mp_jup_benchmark_lighting::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_jup_benchmark");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  function_47cb327205a065e3();
  level.var_9de370d7bf15cd5a = [];
  level.var_5aea0aebeb1f6f3a = [];
  level.var_ac5790b85c5ebcd4 = 0;
  level.var_f70d0bb42f912148 = -1;
  level.onplayerconnect = &onplayerconnect;

  level.var_b54542b9e76b8f10 = undefined;

  level.var_4ee510072abc3181["enemy_group_0"] = &spawnenemies;
  level.var_4ee510072abc3181["enemy_group_1"] = &spawnenemies;
  level.var_4ee510072abc3181["enemy_group_2"] = &spawnenemies;
  level.var_4ee510072abc3181["enemy_group_3"] = &spawnenemies;
  level.var_4ee510072abc3181["enemy_group_4"] = &spawnenemies;

  if(!function_5dae57c13c89243()) {
    function_83b40bc68a15eb7c();
  }

  zone_info = function_f6c2f942cbce9169();

  if(zone_info.size > 0) {
    var_3739d740ec871550 = zone_info[0].duration_seconds;

    for(i = 1; i < zone_info.size; i++) {
      var_3739d740ec871550 = var_3739d740ec871550 << 5 | zone_info[i].duration_seconds;
    }

    var_3739d740ec871550 = var_3739d740ec871550 << 5 | zone_info.size;
    setomnvar("ui_benchmark_create_zones", var_3739d740ec871550);
  }

  if(getdvarint(@ "hash_2972c32ac4afd252", 0) != 1 && !function_ed98c3ba3d253905()) {
    function_8857c1fc6f6d3fa(0);
  }
}

function private function_5dae57c13c89243() {
  return getdvarint(@ "hash_44ee5b351087304c", 0) == 1;
}

function private function_c5d8a30154282590() {
  return getdvarint(@ "hash_e8f28a4951421b29", 1) == 1;
}

function private get_ai_health() {
  return true;
}

function private function_83b40bc68a15eb7c() {
  if(isDefined(level.var_9afb952daafd8532) && level.var_9afb952daafd8532.size > 0) {
    assertmsg("<dev string:x1c>");
  }

  var_9afb952daafd8532 = [];
  level.var_9afb952daafd8532 = [];
  var_9afb952daafd8532["enemy_group_0"]["enemy_0"] = [function_50895d42c69a30a("enemy_group_0_0", (728, 3194, 130), (0, 78.8401, 0)), function_50895d42c69a30a("enemy_group_0_00", (1489.18, 3188.24, 137), (0, 78.8401, 0))];
  var_9afb952daafd8532["enemy_group_0"]["enemy_1"] = [function_50895d42c69a30a("enemy_group_0", (754.946, 1012.25, 319), (0, 80.3325, 0), 0, 0, "stand", &function_1fb834c4fc4208da, function_aa4ec0df376c123b("dx_bc_aqsc_atac_aqs2_launchingarocket", 5, 0.3))];
  var_9afb952daafd8532["enemy_group_1"]["enemy_0"] = [function_50895d42c69a30a("enemy_group_1_00", (183.868, 1502.05, 124.848), (0, 25.6175, 0), 0, 0, "crouch")];
  var_9afb952daafd8532["enemy_group_1"]["enemy_1"] = [function_50895d42c69a30a("enemy_group_1_1", (-586, 1850, -160), (0, 18, 0)), function_50895d42c69a30a("enemy_group_1_01", (115.008, 1867.93, 9.79528), (0, 344.894, 0))];
  var_9afb952daafd8532["enemy_group_1"]["enemy_2"] = [function_50895d42c69a30a("enemy_group_1_2", (-551, 2682, -88), (0, -25, 0), 0, 0, "crouch"), function_50895d42c69a30a("enemy_group_1_02", (-81, 2333, -23), (0, -52, 0), 0, 0, "crouch")];
  var_9afb952daafd8532["enemy_group_1"]["enemy_3"] = [function_50895d42c69a30a("enemy_group_1", (-341.771, 2440.41, -56.262), (0, 313.689, 0), 0, 0, "stand", &function_f007416f3e1b1a09)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_4"] = [function_50895d42c69a30a("enemy_group_1", (240, 1923, 54), (0, -41, 0), 1, 0, "crouch", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_5"] = [function_50895d42c69a30a("enemy_group_1", (230, 2036, 32), (0, 136, 0), 1, 0, "stand", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_6"] = [function_50895d42c69a30a("enemy_group_1", (315, 1957, 142), (0, -50, 0), 1, 0, "prone", &function_2e666684527a4546, function_aa4ec0df376c123b("dx_bc_aqsc_tcor_aqs2_ineedcover", 3))];
  var_9afb952daafd8532["enemy_group_1"]["enemy_7"] = [function_50895d42c69a30a("enemy_group_1", (-593.09, 2547.19, -18.6578), (0, 298.613, 0), 1, 0, "prone", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_8"] = [function_50895d42c69a30a("enemy_group_1", (-509.513, 2550.05, -87.0054), (0, 315.35, 0), 1, 0, "stand", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_9"] = [function_50895d42c69a30a("enemy_group_1", (-537.901, 2421.69, -99.4382), (0, 325.478, 0), 1, 0, "stand", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_10"] = [function_50895d42c69a30a("enemy_group_1", (-797, 2415, -124), (0, -50, 0), 1, 0, "stand", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_11"] = [function_50895d42c69a30a("enemy_group_1", (-553, 2865, 5.75), (0, -50, 0), 1, 0, "stand", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_12"] = [function_50895d42c69a30a("enemy_group_1", (-468, 2775, -47), (0, -50, 0), 1, 0, "stand", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_13"] = [function_50895d42c69a30a("enemy_group_1", (-349, 2823, 130), (0, -50, 0), 1, 0, "stand", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_14"] = [function_50895d42c69a30a("enemy_group_1", (-345, 2915, 137), (0, -63, 0), 1, 0, "stand", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_15"] = [function_50895d42c69a30a("enemy_group_1", (-1015, 2573, 104), (0, -27, 0), 1, 0, "stand", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_16"] = [function_50895d42c69a30a("enemy_group_1", (-1008, 2715, 91), (0, -40, 0), 1, 0, "stand", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_1"]["enemy_17"] = [function_50895d42c69a30a("enemy_group_1", (-1346, 2468, 29), (0, -27, 0), 1, 0, "stand", &function_2e666684527a4546)];
  var_9afb952daafd8532["enemy_group_2"]["enemy_0"] = [function_50895d42c69a30a("enemy_group_2", (171.819, 862.789, 318.201), (0, 60.7388, 0), 0, 0, "stand", &function_f007416f3e1b1a09)];
  var_9afb952daafd8532["enemy_group_2"]["enemy_1"] = [function_50895d42c69a30a("enemy_group_2", (887.161, 947.229, 190), (0, 170.985, 0), 0, 0, "stand", undefined, function_aa4ec0df376c123b("dx_bc_aqsc_atac_aqs2_imshooting", 3, 0.05))];
  var_9afb952daafd8532["enemy_group_3"]["enemy_0"] = [function_50895d42c69a30a("enemy_group_3", (64.7386, 353.321, 182), (0, 213.66, 0), 0, 0, "stand", &function_952dc7a0de119532)];
  var_9afb952daafd8532["enemy_group_4"]["enemy_0"] = [function_50895d42c69a30a("enemy_group_4", (1200, 1964, 145), (0, -140, 0), 1, 0, "stand", &function_952dc7a0de119532)];
  var_9afb952daafd8532["enemy_group_4"]["enemy_1"] = [function_50895d42c69a30a("enemy_group_4", (1105, 2278, 163), (0, -126, 0), 1, 0, "crouch", &function_952dc7a0de119532)];
  var_9afb952daafd8532["enemy_group_4"]["enemy_2"] = [function_50895d42c69a30a("enemy_group_4", (1417, 2185, 153), (0, -140, 0), 1, 0, "crouch", &function_952dc7a0de119532)];
  var_9afb952daafd8532["enemy_group_4"]["enemy_3"] = [function_50895d42c69a30a("enemy_group_4", (920, 2133, 146), (0, -121, 0), 1, 0, "crouch", &function_952dc7a0de119532)];

  level.var_c9015938cda707d1 = [];

  foreach(enemy_group, enemy_array in var_9afb952daafd8532) {
    level.var_c9015938cda707d1[string(enemy_group)] = 0;

    var_128347c669b00c0d = 0;

    foreach(struct_array in enemy_array) {
      if(struct_array.size > 0 && !istrue(struct_array[0].var_ac673d5e8ab086f5)) {
        struct_array[0].var_128347c669b00c0d = var_128347c669b00c0d;
        var_128347c669b00c0d++;
      }

      for(j = 0; j < struct_array.size; j++) {
        struct = struct_array[j];

        if(j + 1 < struct_array.size) {
          struct.target = struct_array[j + 1].targetname;
        }
      }
    }
  }

  var_e4358e56ced21c8c = [];

  foreach(group, var_62071589605efe83 in var_9afb952daafd8532) {
    var_e4358e56ced21c8c[group] = [];

    foreach(struct_array in var_62071589605efe83) {
      var_e4358e56ced21c8c[group][var_e4358e56ced21c8c[group].size] = struct_array[0];
    }
  }

  level.var_9afb952daafd8532 = var_e4358e56ced21c8c;
}

function private function_470350e8e748d844() {
  return namespace_2a06ffe6a2b4132::function_5842ae542da36283([["nade", "thermite_mp", 0, (1354.98, 3035.2, 203.38), 0], ["missile", "gunship_hellfire_mp", (754, 1072, 382), (1110.21, 2806.24, 188.334), 1], ["nade", "molotov_mp", 0, (883, 2372, 154), 0], ["nade", "thermobaric_grenade_jup_mp", 0, (1279.72, 2425.49, 150.815), 1], ["nade", "jup_smoke_grenade_mp", 0, (1006, 1945, 134), 1]]);
}

function private function_bb206c7d3decab59() {
  return namespace_2a06ffe6a2b4132::function_5842ae542da36283([["nade", "frag_grenade_mp", 0, (306.203, 1045.9, 190), 0], ["nade", "frag_grenade_mp", 0, (595.474, 942.979, 190), 0], ["nade", "frag_grenade_mp", 0, (691.039, 716.492, 190), 0], ["nade", "frag_grenade_mp", 0, (213.713, 705.925, 191), 0], ["nade", "frag_grenade_mp", 0, (459.292, 552.724, 190), 0], ["nade", "frag_grenade_mp", 0, (480.901, 1001.12, 190), 0], ["nade", "frag_grenade_mp", 0, (632.953, 556.202, 190), 0], ["nade", "frag_grenade_mp", 0, (232.307, 887.11, 190), 0], ["nade", "frag_grenade_mp", 0, (126.884, 1053.98, 190), 0], ["nade", "explosion", 0, (445, 1160, 190), 0]]);
}

function private function_c46e758c3b291352(player) {
  vfx_origin = getdvarvector(@ "hash_80fbd19b54aa1eb0", (1287, 3285, 146));
  airstrike_origin = getdvarvector(@ "hash_8d1946c2087a7706", (391, 1195, 190));
  ghost_origin = getdvarvector(@ "hash_8bbbcea6c8fd92d1", (162, 490, 182));
  choppers_origin = getdvarvector(@ "hash_174ed8073e7d467e", (245, 1020, 190));
  nuke_origin = getdvarvector(@ "hash_e4b860e046079781", (115, 400, 180));
  var_88d87cc6de40716e = getdvarvector(@ "hash_899284261b3a4708", (393, 1350, 190));
  var_29450101213c7b63 = getdvarvector(@ "hash_b0c20344f4a1770d", (1222, 2877, 128));
  var_fa5f13a736405903 = getdvarvector(@ "hash_e528d2f82a583f26", (450, 1695, 111));
  trigger_radius = 50;
  thread function_c1903e1f99c29097(player, "VFX Sequence", vfx_origin, trigger_radius, &function_3f61cb09115d6984);
  thread function_c1903e1f99c29097(player, "Explosion Damage", var_29450101213c7b63, trigger_radius, &function_ed6e58cdd7112e67);
  thread function_c1903e1f99c29097(player, "Bullet Damage", var_88d87cc6de40716e, trigger_radius, &function_7c4f8b1de422efec);
  thread function_c1903e1f99c29097(player, "Ragdoll explosions", var_fa5f13a736405903, trigger_radius, &function_e82a6af3d2195354);
  thread function_c1903e1f99c29097(player, "Airstrike", airstrike_origin, trigger_radius, &function_85d860f53b4502ce);

  if(function_ed98c3ba3d253905()) {
    thread function_c1903e1f99c29097(player, "Spawn Ghost", ghost_origin, trigger_radius, &function_9dde08d506749cf7);
  }

  thread function_c1903e1f99c29097(player, "Helicopter", choppers_origin, trigger_radius, &function_872feadf1dbf2e6c);
  thread function_c1903e1f99c29097(player, "Nuke", nuke_origin, trigger_radius, &function_12315996b29aec80);
}

function private initdvars() {
  if(!function_ed98c3ba3d253905() && getdvarint(@ "hash_d5fd9067cafb06b9") != 1) {
    setDvar(@ "hash_d5fd9067cafb06b9", 1);
  }

  setDvar(@ "hash_c11db9baa9e5bc9b", 1);
  setDvar(@ "scr_skip_infils", 1);
  setDvar(@ "hash_c653d32c30815d2b", 0);
  setDvar(@ "scr_game_matchstarttime", 0);
  setDvar(@ "hash_94af58bec500b3b9", 1);
  setDvar(@ "hash_2a4f08bc79265550", 1);
  setDvar(@ "player_sustainammo", 1);
  level.var_92b187a00d3dd091 = 1;
  level.blocknukekills = 1;
  level.nosuspensemusic = 1;
}

function private onplayerconnect(player) {
  player waittill("spawned");

  if(isbot(player)) {
    return;
  }

  namespace_5d1a752b8be8c9e4::function_6a71d7af83d45844(&onplayerdisconnect, player);

  if(function_ed98c3ba3d253905()) {
    function_330f16f709c7b2bd(player);
  } else {
    function_27b7f83af15c463f(player);
  }

  player waittill("player_active");

  thread namespace_5d1a752b8be8c9e4::function_d91b80df39c4c83f(player);

  if(function_ed98c3ba3d253905()) {
    function_45d9f7f1ca6bd8dd(player);
  } else {
    benchmark_start(player);
  }

  function_4a7af138eadf4bf7("<dev string:x67>", "<dev string:x7b>", &function_d702b9704d201780, ["<dev string:x8e>"]);
  function_4a7af138eadf4bf7("<dev string:x94>", "<dev string:x7b>", &function_1c11cc9e05713f46, ["<dev string:xa9>"]);
  function_4a7af138eadf4bf7("<dev string:xaf>", "<dev string:x7b>", &debug_noclip, ["<dev string:xc0>"]);
  function_4a7af138eadf4bf7("<dev string:xc6>", "<dev string:xde>", &namespace_2a06ffe6a2b4132::function_a214d0f4e69fa9d7, undefined);
  function_4a7af138eadf4bf7("<dev string:xfa>", "<dev string:xde>", undefined, undefined);
  function_4a7af138eadf4bf7("<dev string:x111>", "<dev string:x128>", &namespace_6c0bcb025e487cb4::function_1e886a86efe8cab6, undefined);
  function_4a7af138eadf4bf7("<dev string:x143>", "<dev string:x128>", undefined, undefined);
  function_4a7af138eadf4bf7("<dev string:x157>", "<dev string:x128>", undefined, undefined);
  namespace_5d1a752b8be8c9e4::function_39485f1ee834e5df(player);
}

function private onplayerdisconnect(player) {
  player lerpfovscalefactor(1, 0);
  namespace_5d1a752b8be8c9e4::function_b55adbce52a84ae4();
}

function private function_50895d42c69a30a(targetname, origin, angles, var_ac673d5e8ab086f5, var_549a5e52755e2da, var_ddd12ce6cd02783d, var_ed93b9c8d17e399c, var_25ced5840d1964e1) {
  if(!isDefined(var_ac673d5e8ab086f5)) {
    var_ac673d5e8ab086f5 = 0;
  }

  if(!isDefined(var_549a5e52755e2da)) {
    var_549a5e52755e2da = 0;
  }

  if(!isDefined(var_ddd12ce6cd02783d)) {
    var_ddd12ce6cd02783d = "stand";
  }

  if(!isDefined(var_ed93b9c8d17e399c)) {
    var_ed93b9c8d17e399c = &ai_basic;
  }

  if(!isDefined(var_25ced5840d1964e1)) {
    var_25ced5840d1964e1 = undefined;
  }

  script_struct = spawn("script_origin", origin);
  script_struct.targetname = targetname;
  script_struct.origin = origin;
  script_struct.angles = angles;
  script_struct.goalradius = 3;
  script_struct.modelscale = "1";
  script_struct.script_parameters = var_ddd12ce6cd02783d;
  script_struct.script_forcegoal = 1;
  script_struct.var_549a5e52755e2da = var_549a5e52755e2da;
  script_struct.var_ac673d5e8ab086f5 = var_ac673d5e8ab086f5;

  if(istrue(var_ac673d5e8ab086f5)) {
    script_struct.var_128347c669b00c0d = -1;
  } else {
    script_struct.var_128347c669b00c0d = -9999;
  }

  script_struct.var_ed93b9c8d17e399c = var_ed93b9c8d17e399c;
  script_struct.var_25ced5840d1964e1 = var_25ced5840d1964e1;
  return script_struct;
}

function private function_952dc7a0de119532(script_struct) {
  agent = ai_basic(script_struct);
  agent.var_b3ccac0547995d5c = 1;
  agent.var_8c9f82b3e706ba42 = 1;
  forward_vector = agent getEye() + vectorNormalize(anglesToForward(agent.angles)) * 300;
  fake_enemy = spawn_tag_origin(forward_vector);
  fake_enemy setModel("tag_origin_only_collision");
  fake_enemy makeentitysentient("allies");
  fake_enemy notsolid();
  fake_enemy.health = 10000;
  agent.favoriteenemy = fake_enemy;
  return agent;
}

function private ai_basic(agentstruct) {
  agent = agentstruct scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_benchmark_base", agentstruct.origin, agentstruct.angles);
  agent.health = get_ai_health();
  agent.disablebulletwhizbyreaction = 1;
  agent setcanusecover(0);
  agent.disablerunngun = 1;
  agent.disabledodge = 1;
  agent.aggressivemode = 0;
  agent scripts\engine\utility::set_movement_speed(160);
  return agent;
}

function private function_2e666684527a4546(agentstruct) {
  agent = ai_basic(agentstruct);
  agent enabletraversals(0);
  agent scripts\engine\utility::set_movement_speed(0);
  return agent;
}

function private function_f007416f3e1b1a09(agentstruct) {
  agent = ai_basic(agentstruct);
  agent.var_b3ccac0547995d5c = 1;
  return agent;
}

function private function_1fb834c4fc4208da(agentstruct) {
  agent = function_f007416f3e1b1a09(agentstruct);
  agent.var_243517b4b15ea0ea = [0.15];
  return agent;
}

function private function_45d9f7f1ca6bd8dd(player) {
  iprintlnbold("<dev string:x16d>");
  adddebugcommand("<dev string:x1ce>");
  setdevdvar(@ "scr_devchangetimelimit", 0);
  setDvar(@ "hash_aff3efc76e4dfeb2", 0);
  namespace_5d1a752b8be8c9e4::function_3f766cec506a0862(%"hash_55b1316b0c9bbe85", 0);
  thread namespace_6c0bcb025e487cb4::function_f178ffb3b7e8f054(player);
  thread namespace_2a06ffe6a2b4132::function_75e0c9d28c4fa84b(player, 1);
  thread function_dbe0451646f4d30f(player);
  thread function_61f3ce164ef1f960(player);
  namespace_4121a3de9a9601c8::function_e5ca1b100ee7f420();
  function_aad02f3462b8b878(player);
  namespace_4121a3de9a9601c8::function_3769d0ae67ca1ee8(player);
  namespace_2a06ffe6a2b4132::function_135f9f255157ecd6(&function_aad02f3462b8b878);
}

function private function_aad02f3462b8b878(player) {
  namespace_4121a3de9a9601c8::function_d6f7b6f9e9bc119();
  namespace_4121a3de9a9601c8::function_fe10197ad5c2b028("<dev string:x1d5>", &function_e82a6af3d2195354);
  namespace_4121a3de9a9601c8::function_fe10197ad5c2b028("<dev string:x1e0>", &function_85d860f53b4502ce);
  namespace_4121a3de9a9601c8::function_fe10197ad5c2b028("<dev string:x1ed>", &function_872feadf1dbf2e6c);
  namespace_4121a3de9a9601c8::function_fe10197ad5c2b028("<dev string:x1fc>", &function_12315996b29aec80);
  namespace_5d1a752b8be8c9e4::function_a75d7d6c3c181558();
}

function private benchmark_start(player) {
  setDvar(@ "mp_benchmark_mode", 1);

  if(isdevbuild() && getdvarint(@ "hash_a6580d9de6607747", 0) == 1) {
    setomnvar("ui_start_benchmark", 1);
    thread function_c52bbaa695829f71(0, 1, player);
    wait 1;
    function_1c7d1e4fb99ef2c9();
    return;
  }

  level.var_4a9bbc7f74f48ccd = getdvarfloat(@ "hash_dab366f405822e6c");

  if(function_c5d8a30154282590()) {
    function_c46e758c3b291352(player);
  }

  if(getdvarint(@ "hash_2972c32ac4afd252", 0) != 1) {
    level.var_f70d0bb42f912148 = 0;
    function_8857c1fc6f6d3fa(0);
    player setsoundsubmix("fade_to_black_all_except_music");
    var_6025a2509dba6b38 = (733, 1350, 825);
    var_c34b8ecfe7e3b107 = (48.1272, 243.808, -0.649958);
    direction_vector = vectorNormalize((642, 1165, 595) - var_6025a2509dba6b38);
    starting_angles = generateaxisanglesfromforwardvector(direction_vector, (0, 0, 1));
    spawn_point = spawn("script_origin", var_6025a2509dba6b38);
    spawn_point.angles = var_c34b8ecfe7e3b107;
    player playerlinktoabsolute(spawn_point);
    thread function_fd70cf6883992643(player);
    level waittill("turret_bullet_damage_finished");
    wait 0.5;
    thread namespace_2a06ffe6a2b4132::function_96f86549e383586(player, function_bb206c7d3decab59());
    wait 1;
    setomnvar("ui_start_benchmark", 1);
    wait 0.25;
    function_1d2b611b24d8e7cb(1);

    if(player islinked()) {
      player unlink(1);
    }

    spawn_point delete();
    player clearsoundsubmix("fade_to_black_all_except_music", 1);
  } else {
    setomnvar("ui_start_benchmark", 1);
  }

  thread function_919aaa5b02cedeaf(player);
  thread function_4f89e05a88128c9(player);
}

function private function_330f16f709c7b2bd(player) {
  player setOrigin((2318, 4614, 76), 1, 1);
  player setplayerangles((3, 204, 0));
  player.team = "allies";
  player.sessionteam = player.team;
  player.sessionstate = "playing";
  player.safefromnuke = 1;
  player.magic_bullet_shield = 1;

  if(isDefined(player.secondaryweaponobj) && player.secondaryweaponobj.basename != "none") {
    player takeweapon(player.secondaryweaponobj);
  }

  if(isDefined(player.primaryweaponobj) && player.primaryweaponobj.basename != "none") {
    player takeweapon(player.primaryweaponobj);
  }

  player scripts\mp\equipment::setequipmentslotammo("primary", 0);
  player scripts\mp\equipment::setequipmentslotammo("secondary", 0);
  player scripts\mp\supers::clearsuper();
  player scripts\mp\equipment::takeequipment("super");
  player scripts\mp\utility\perk::giveperk("specialty_lightweight");
  player scripts\mp\utility\perk::giveperk("specialty_quickdraw");
  player scripts\mp\utility\perk::giveperk("specialty_fastsprintrecovery");
  player scripts\mp\utility\perk::giveperk("specialty_hustle");
  player scripts\mp\utility\perk::giveperk("specialty_fastcrouchmovement");
  player scripts\mp\utility\perk::giveperk("specialty_stalker");
  player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  player scripts\mp\utility\perk::giveperk("specialty_tactical_recon");
  player scripts\mp\utility\perk::giveperk("specialty_warhead");
  attachments = ["iw9_minireddot04_tall", "ammo_556n", "jup_jp01_ar_golf36_pgrip_tac", "iw9_selectsemi", "jup_jp01_ar_golf36_mag_30_556n", "jup_jp01_ar_golf36_stock_assault", "jup_jp01_ar_golf36_bar_fusion", "jup_golf36_rec"];
  weapon = scripts\cp_mp\weapon::buildweapon("jup_jp01_ar_golf36_mp", attachments);
  player giveweapon(weapon);
  player switchtoweapon(weapon);
  level.player = player;
}

function private function_27b7f83af15c463f(player) {
  player.team = "allies";
  player.sessionteam = player.team;
  player.sessionstate = "playing";
  player.safefromnuke = 1;
  player utility::hidehudenable();
  player disableweapons();
  player lerpfovscalefactor(0, 0);
  level.player = player;
}

#using_animtree("player");

function private function_919aaa5b02cedeaf(player) {
  player endon("death_or_disconnect");
  starting_origin = getdvarvector(@ "hash_2746839c72ca5cc5", (1365, 3240, 150));
  starting_angles = getdvarvector(@ "hash_6806b8a53bb9ad1b", (0, 0, 0));
  starting_node = spawn_tag_origin(starting_origin, starting_angles);
  player setOrigin(starting_node.origin);
  player setplayerangles(starting_node.angles);
  player playerhide();
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_animname["player_rig"]["mp_vm_benchmark"] = "jup_mp_vm_benchmark";
  level.scr_anim["player_rig"]["mp_vm_benchmark"] = % jup_mp_vm_benchmark;
  level.scr_eventanim["player_rig"]["mp_vm_benchmark"] = % "mp_vm_benchmark";
  level.scr_viewmodelanim["player_rig"]["mp_vm_benchmark"] = "jup_mp_vm_benchmark";
  player_rig = spawn("script_model", starting_node.origin);
  player_rig.animname = "player_rig";
  player_rig setModel("mp_western_vm_arms_milsim_usmc_mef_1_1");
  player_rig.angles = starting_node.angles;
  player_rig useanimtree(#animtree);
  flyby_cam = spawn("script_model", starting_node.origin);
  flyby_cam.animname = "flyby_cam";
  flyby_cam setModel("mp_western_vm_arms_milsim_usmc_mef_1_1");
  flyby_cam.angles = starting_node.angles;
  flyby_cam useanimtree(#animtree);
  flyby_cam hideallparts();
  player_weapon = function_11ceb2b87e4aea3f(player_rig);
  setomnvar("ui_benchmark_gun_model_ent", player_weapon);

  if(getdvarint(@ "hash_eb25f735560d7e36", 0) != 1) {
    function_8ad7fc4e776e0e6c();
    thread function_7be377ccddccf59d(player);
  }

  if(getdvarint(@ "hash_dfc28ba505e748e6", 0) != 1) {
    level.var_f70d0bb42f912148 = 1;
    var_5f3be4ae829e184f = function_c0af2b7def50dcc7();
    player.animname = "flyby_cam";
    player playerlinktoabsolute(flyby_cam, "tag_player");

    level.var_b54542b9e76b8f10 = flyby_cam;

    starting_node scripts\common\anim::anim_first_frame_solo(flyby_cam, "mp_vm_benchmark");
    starting_node thread scripts\common\anim::anim_single_solo(flyby_cam, "mp_vm_benchmark");
    wait function_1534e73bf007553d() - 0.5;
    function_8857c1fc6f6d3fa(0.5);
    wait 0.5;
    function_1d2b611b24d8e7cb(1);
    var_5f3be4ae829e184f scripts\cp_mp\agents\agent_utils::despawnagent();
  }

  level.var_f70d0bb42f912148 = 2;
  player.animname = "player_rig";

  if(!isdevbuild() || player islinked() || getdvarint(@ "hash_dfc28ba505e748e6", 0) == 1) {
    player playerlinktoabsolute(player_rig, "tag_player");
  }

  level.var_b54542b9e76b8f10 = player_rig;

  starting_node scripts\common\anim::anim_first_frame_solo(player_rig, "mp_vm_benchmark");
  player_rig scripts\common\anim::anim_first_frame_solo(player_weapon, "mp_vm_benchmark", "j_gun");
  player_rig thread scripts\common\anim::anim_single_solo(player_weapon, "mp_vm_benchmark", "j_gun");
  starting_node thread scripts\common\anim::anim_single_solo(player_rig, "mp_vm_benchmark");
  thread function_9dde08d506749cf7(player);
}

#using_animtree("script_model");

function private function_11ceb2b87e4aea3f(player_rig) {
  level.scr_animtree["player_weapon"] = #animtree;
  level.scr_anim["player_weapon"]["mp_vm_benchmark"] = % jup_mp_vm_benchmark_weapon;
  level.scr_animname["player_weapon"]["mp_vm_benchmark"] = "jup_mp_vm_benchmark_weapon";
  level.scr_eventanim["player_weapon"]["mp_vm_benchmark"] = % "mp_vm_benchmark";
  player_weapon = spawn("script_model", (0, 0, 0));
  player_weapon setModel("wpn_jup_vm_jp01_ar_golf36_benchmark");
  player_weapon useanimtree(#animtree);
  player_weapon.animname = "player_weapon";
  player_weapon linkTo(player_rig, "j_gun", (0, 0, 0), (0, 0, 0));
  return player_weapon;
}

#using_animtree("player");

function private function_47cb327205a065e3() {
  level.scr_animtree["flyby_cam"] = #animtree;
  level.scr_anim["flyby_cam"]["mp_vm_benchmark"] = % jup_mp_flyby_benchmark;
  level.scr_animname["flyby_cam"]["mp_vm_benchmark"] = "jup_mp_flyby_benchmark";
  level.scr_eventanim["flyby_cam"]["mp_vm_benchmark"] = "mp_vm_benchmark";
  level.scr_viewmodelanim["flyby_cam"]["mp_vm_benchmark"] = "jup_mp_flyby_benchmark";
}

function private function_1534e73bf007553d() {
  return scripts\common\anim::function_52351c3338da63f4("flyby_cam", "mp_vm_benchmark");
}

function private function_8ad7fc4e776e0e6c() {
  scripts\common\anim::addnotetrack_customfunction("player_weapon", "player_fire_kill", &function_81c942a8f88e3aa5, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "player_enter_water", &namespace_5d1a752b8be8c9e4::function_d86dced7ae3bc595, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "player_surface_water", &namespace_5d1a752b8be8c9e4::function_52428a50527a126, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "player_exit_water", &namespace_5d1a752b8be8c9e4::playerexitwater, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "show_weapon_reticle", &namespace_5d1a752b8be8c9e4::function_1162676dee6bce34, "mp_vm_benchmark");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "hide_weapon_reticle", &namespace_5d1a752b8be8c9e4::function_a5aae04b01a04e77, "mp_vm_benchmark");

  if(getdvarint(@ "hash_719fb9117ea7668d", 1) == 1) {
    scripts\common\anim::addnotetrack_customfunction("player_rig", "tac_ads_fov_in", &namespace_5d1a752b8be8c9e4::function_d94ab9ccf09710b9, "mp_vm_benchmark");
    scripts\common\anim::addnotetrack_customfunction("player_rig", "tac_ads_fov_out", &namespace_5d1a752b8be8c9e4::function_1d1876b4d9eeb93a, "mp_vm_benchmark");
  }
}

function private function_7be377ccddccf59d(player) {
  player endon("death_or_disconnect");
  var_fe877c25155245e2 = scripts\engine\utility::ter_op(getdvarint(@ "hash_dfc28ba505e748e6", 0) != 1, function_1534e73bf007553d(), 0);
  wait var_fe877c25155245e2;
  wait 5;
  function_b11b460cc47954fe("enemy_group_0");
  wait 9.5;
  function_b11b460cc47954fe("enemy_group_1");
  wait 6;
  function_b11b460cc47954fe("enemy_group_2");
  wait 8;
  function_b11b460cc47954fe("enemy_group_3");
  wait 7;
  function_b11b460cc47954fe("enemy_group_4");
}

function private function_4f89e05a88128c9(player) {
  player endon("death_or_disconnect");
  zone_info = function_f6c2f942cbce9169();

  for(i = 0; i < zone_info.size; i++) {
    if(isDefined(zone_info[i].var_5d3f1f6ae5e71bc6)) {
      thread[[zone_info[i].var_5d3f1f6ae5e71bc6]](zone_info[i].duration_seconds, player);
    }

    thread function_c52bbaa695829f71(i, zone_info[i].duration_seconds, player);
    wait zone_info[i].duration_seconds;

    if(isDefined(zone_info[i].var_e1bac41c959fbb66)) {
      thread[[zone_info[i].var_e1bac41c959fbb66]](player);
    }
  }
}

function private function_c52bbaa695829f71(zone_index, var_e8101fe99202d1ae, player) {
  player endon("death_or_disconnect");

  if(!hasomnvar("benchmark_zone_change")) {
    return;
  }

  setomnvar("benchmark_zone_change", (zone_index << 8) + var_e8101fe99202d1ae);
}

function private function_6ce435ce33ba4791(zone_duration, player) {
  player endon("death_or_disconnect");
  player function_eb0326e0c8803f41(0, "_fc_01");
  namespace_5d1a752b8be8c9e4::function_3f766cec506a0862(%"hash_36a7b1083533db6c", zone_duration);
}

function private function_d6a05bb507f63966(player) {
  player endon("death_or_disconnect");
  wait 1;
  namespace_5d1a752b8be8c9e4::function_3f766cec506a0862(%"hash_55b1316b0c9bbe85", 2);
  player function_eb0326e0c8803f41(2, "");
}

function private function_81c942a8f88e3aa5(weapon_model) {
  if(level.var_9de370d7bf15cd5a.size == 0) {
    assertmsg("<dev string:x204>");
    return;
  }

  var_2e04341476474e17 = level.var_9de370d7bf15cd5a[0];
  var_e18c728cf36651d1 = undefined;

  foreach(enemy_struct in var_2e04341476474e17) {
    if(!isDefined(enemy_struct)) {
      assertmsg("<dev string:x25f>");
      continue;
    }

    if(isDefined(enemy_struct.var_128347c669b00c0d) && enemy_struct.var_128347c669b00c0d != -9999) {
      if(enemy_struct.var_128347c669b00c0d == level.var_ac5790b85c5ebcd4) {
        var_e18c728cf36651d1 = enemy_struct.enemy_ref;
        break;
      }

      continue;
    }

    assertmsg("<dev string:x2a2>");
  }

  if(isDefined(var_e18c728cf36651d1)) {
    if(scripts\engine\utility::is_dead_or_dying(var_e18c728cf36651d1)) {
      assertmsg("<dev string:x30c>");
    }

    var_379cadd4c9b0cd35 = level.player.origin + (0, 0, 35);

    if(isDefined(weapon_model)) {
      if(modelhastag(weapon_model.model, "tag_flash")) {
        playFXOnTag(getfx("vfx_muzzle_flash"), weapon_model, "tag_flash");
        var_379cadd4c9b0cd35 = weapon_model gettagorigin("tag_flash");
      } else {
        playFX(getfx("vfx_muzzle_flash"), var_379cadd4c9b0cd35);
      }
    }

    bullet_end_origin = var_e18c728cf36651d1 gettagorigin("tag_eye");
    magicbullet("iw9_ar_mike4_mp_benchmark", var_379cadd4c9b0cd35, bullet_end_origin, level.player);

    thread function_5c3bc447572e6477(var_379cadd4c9b0cd35, bullet_end_origin);

    var_2b7e5208b7c62489 = 0;

    if(scripts\engine\utility::is_dead_or_dying(var_e18c728cf36651d1)) {
      var_2b7e5208b7c62489 = 1;
      iprintlnbold("KILL!");
    } else if(function_ed98c3ba3d253905()) {
      iprintlnbold("MISS!");
    } else {
      assertmsg("<dev string:x347>");
    }

    if(!function_ed98c3ba3d253905() || var_2b7e5208b7c62489) {
      level.var_ac5790b85c5ebcd4++;
    }

    return;
  }

  assertmsg("<dev string:x358>");
}

function private function_da708648ed6694ef(endposition, var_ed135574299ed3a1, var_d5023b702aeae09f, randomrange) {
  if(!isDefined(var_d5023b702aeae09f)) {
    var_d5023b702aeae09f = 0;
  }

  if(!isDefined(randomrange)) {
    randomrange = 200;
  }

  var_2c220fb2a7797010 = (endposition[0], endposition[1], endposition[2] * 2);

  while(var_ed135574299ed3a1 > 0) {
    if(var_d5023b702aeae09f) {
      var_fe035bf07ab01a3b = randomfloatrange(endposition[0] - randomrange, endposition[0] + randomrange);
      var_fe035af07ab01808 = randomfloatrange(endposition[1] - randomrange, endposition[1] + randomrange);
    } else {
      var_fe035bf07ab01a3b = endposition[0];
      var_fe035af07ab01808 = endposition[1];
    }

    magicbullet("gunship_hellfire_mp", var_2c220fb2a7797010, (var_fe035bf07ab01a3b, var_fe035af07ab01808, endposition[2]));
    var_ed135574299ed3a1--;
    wait 0.3;
  }
}

function private function_1f1b77d5f3982cdf(player, var_7a5c0758ba4f2ff1, explodepos) {
  var_763c373a9831e77b = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("nuke_multi", player);
  var_763c373a9831e77b.streakname = "nuke_multi";
  var_763c373a9831e77b.debug_state = "begin_use";
  var_763c373a9831e77b.var_8b07383e09b74fad = 1;
  var_763c373a9831e77b.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var_763c373a9831e77b.streakname);
  player scripts\cp_mp\killstreaks\nuke::nuke_start(var_763c373a9831e77b, 0, player.origin + (0, 0, 900), explodepos, 0, var_7a5c0758ba4f2ff1, "nuke_multi_mp");
}

function private function_85d860f53b4502ce(player) {
  var_5c05eb41829c0d4c = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("precision_airstrike", player);
  var_5c05eb41829c0d4c.targetoverride = getdvarvector(@ "hash_57661853395a51a3", (100, -610, 75));
  var_5c05eb41829c0d4c.directionyawoverride = getdvarfloat(@ "hash_abd52befee5b5d46", 0.75);
  var_5c05eb41829c0d4c.planeflyheightoverride = 400;
  var_5c05eb41829c0d4c.var_e27e4095040fe813 = 1.6;
  var_5c05eb41829c0d4c.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var_5c05eb41829c0d4c.streakname);
  player scripts\cp_mp\killstreaks\airstrike::tryuseairstrikefromstruct(var_5c05eb41829c0d4c);
  wait 7.2;
  thread function_da708648ed6694ef((-945, -610, 75), 1);
  wait 0.2;
  thread function_da708648ed6694ef((100, -610, 75), 1);
  wait 1.5;
  thread function_da708648ed6694ef((-450, -610, 75), 1);
}

function private function_e67ca577ffe7bbfa() {
  self endon("death");
  self waittill("reached_path_end");
  scripts\engine\utility::set_movement_speed(0);

  if(!istrue(self.var_bb65f3d75b4d8556)) {
    self.ignoreme = 0;
    self.ignoreall = 0;
  }

  self.baimedataimtarget = 1;

  if(isDefined(self.currentnode) && function_5b7e9a4c946f3a13(self.currentnode.script_parameters, ["stand", "crouch", "prone"])) {
    self allowedstances(self.currentnode.script_parameters);
  }

  thread function_ef0f9cd5de157e6();
}

function private function_ef0f9cd5de157e6() {
  self endon("death");
  wait_array = [];
  index = 0;

  if(isDefined(self.var_243517b4b15ea0ea)) {
    wait_array = self.var_243517b4b15ea0ea;
  } else {
    wait_array = [0.4, 0.2, 0.1];
  }

  while(isalive(self)) {
    start = self gettagorigin("tag_flash");
    end = level.player getEye();
    gun_forward = anglesToForward(self gettagangles("tag_flash"));
    var_53f1b3d4cb41ecae = vectorNormalize(end - start);

    if(function_fb0753afc466b10f(gun_forward, var_53f1b3d4cb41ecae) || istrue(self.var_8c9f82b3e706ba42)) {
      if(!istrue(self.var_b3ccac0547995d5c)) {
        var_79e7b310fa1db887 = self gettagangles("tag_flash");
        playFX(getfx("vfx_muzzle_flash"), start, anglesToForward(var_79e7b310fa1db887), anglestoup(var_79e7b310fa1db887));
        magicbullet(self.primaryweapon, start, end + (-20, 0, 0), self);
      } else {
        self shoot();
      }

      wait wait_array[index % wait_array.size];
      index++;
      continue;
    }

    wait 0.05;
  }
}

function private function_fb0753afc466b10f(gun_forward, var_f5354afc4a687e0) {
  max_angle = 12;
  var_a3cd3112c6949144 = math::anglebetweenvectors(gun_forward, var_f5354afc4a687e0);
  return var_a3cd3112c6949144 < max_angle;
}

function private function_b11b460cc47954fe(targetname) {
  assert(isDefined(targetname));

  if(function_5dae57c13c89243()) {
    var_e4358e56ced21c8c = utility::getStructArray(targetname, "targetname");
  } else {
    var_e4358e56ced21c8c = level.var_9afb952daafd8532[targetname];
  }

  if(!isDefined(var_e4358e56ced21c8c) || var_e4358e56ced21c8c.size == 0) {
    assertmsg("<dev string:x3a0>" + targetname);
  }

  thread[[level.var_4ee510072abc3181[targetname]]](var_e4358e56ced21c8c);
}

function private function_c0117d5a90626fd(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  var_a40c8df25cb99c54 = self.var_128347c669b00c0d != -1;

  if(var_a40c8df25cb99c54 && einflictor != level.player && !scripts\engine\utility::isbulletdamage(smeansofdeath)) {
    return 0;
  }

  return idamage;
}

function private spawnenemies(var_e4358e56ced21c8c) {
  var_5cfbae3901f17a7 = undefined;
  var_5bdcc9c6ba0f7550 = -1;
  var_62071589605efe83 = [];

  foreach(agentstruct in var_e4358e56ced21c8c) {
    agent = undefined;

    if(isDefined(agentstruct.var_ed93b9c8d17e399c)) {
      agent = [[agentstruct.var_ed93b9c8d17e399c]](agentstruct);
    } else {
      agent = ai_basic();
    }

    if(isDefined(agentstruct.var_25ced5840d1964e1)) {
      thread namespace_5d1a752b8be8c9e4::function_af45038443aa19b(level.player, agent, agentstruct.var_25ced5840d1964e1.alias, agentstruct.var_25ced5840d1964e1.wait_time, agentstruct.var_25ced5840d1964e1.percentage);
    }

    agent.var_128347c669b00c0d = agentstruct.var_128347c669b00c0d;
    agent.var_970170ffd4b081ac = &function_c0117d5a90626fd;
    level.var_5aea0aebeb1f6f3a[level.var_5aea0aebeb1f6f3a.size] = agent;

    if(isDefined(agentstruct.target) || istrue(agent.var_bb65f3d75b4d8556)) {
      agent.ignoreme = 1;
      agent.ignoreall = 1;
    }

    if(!isDefined(agentstruct.modelscale)) {
      agentstruct.modelscale = "1";
    }

    if(!isDefined(agentstruct.goalradius)) {
      agentstruct.goalradius = 3;
    }

    if(!isDefined(agentstruct.var_549a5e52755e2da) || agentstruct.var_549a5e52755e2da < 0) {
      agentstruct.var_549a5e52755e2da = 0;
    }

    utility::delaythread(agentstruct.var_549a5e52755e2da, &function_8e97768c6ba49cf3, agent, agentstruct);

    thread function_ab50b0cfe0a25e10(agent, agentstruct.var_128347c669b00c0d);

    var_62071589605efe83[var_62071589605efe83.size] = agentstruct;
    agentstruct.enemy_ref = agent;
    thread function_67e0f9270330d8e7(agent, agentstruct);

    if(agentstruct.var_128347c669b00c0d >= var_5bdcc9c6ba0f7550) {
      var_5bdcc9c6ba0f7550 = agentstruct.var_128347c669b00c0d;
      var_5cfbae3901f17a7 = agent;
    }
  }

  level.var_9de370d7bf15cd5a[level.var_9de370d7bf15cd5a.size] = var_62071589605efe83;
  thread function_59f7ea289a2bfe33(var_5cfbae3901f17a7);
}

function private function_59f7ea289a2bfe33(var_c02afadc71c5e932) {
  if(!isDefined(var_c02afadc71c5e932)) {
    assertmsg("<dev string:x3df>");
    return;
  }

  var_c02afadc71c5e932 waittill("death");

  if(level.var_9de370d7bf15cd5a.size > 0) {
    level.var_9de370d7bf15cd5a = array_remove_index(level.var_9de370d7bf15cd5a, 0);
    level.var_ac5790b85c5ebcd4 = 0;
    iprintlnbold("Last enemy in group killed");
    return;
  }

  assertmsg("<dev string:x40b>");
}

function private function_67e0f9270330d8e7(enemy, spawn_struct) {
  enemy waittill("death");
  spawn_struct.enemy_ref = undefined;
}

function private function_8e97768c6ba49cf3(agent, agentstruct) {
  agent thread scripts\mp\ai_behavior::function_4c61a6fd42fa58(agentstruct);
  agent thread function_e67ca577ffe7bbfa();
}

function private function_872feadf1dbf2e6c(player) {
  first_speed = 20;
  var_5423da9b00ffb644 = (-8700, 3000, 400);
  var_6e58fd73230b427f = (6700, 1250, 400);
  spawnhelicopters(first_speed, var_5423da9b00ffb644, var_6e58fd73230b427f);
  second_speed = 50;
  var_d3ee33524bf085a8 = (-6720, 2250, 300);
  var_387195ccfb1e70c3 = (735, 1435, 600);
  spawnhelicopters(second_speed, var_d3ee33524bf085a8, var_387195ccfb1e70c3);
}

function private spawnhelicopters(chopper_speed, var_9a385189e17648d7, var_cccda3070a0fe6b6) {
  var_178deecd85fa4021 = getdvarint(@ "hash_c4ee7446cb970962", 3);
  var_963fa64a0c086512 = getdvarfloat(@ "hash_6aa0bc115baaa7de", 500);
  direction_vector = vectorNormalize(var_cccda3070a0fe6b6 - var_9a385189e17648d7);
  starting_angles = generateaxisanglesfromforwardvector(direction_vector, (0, 0, 1));

  for(i = 0; i < var_178deecd85fa4021; i++) {
    var_ccd3e6f1fa89f0eb = var_963fa64a0c086512 * i;
    var_e634d026ea7a8691 = var_9a385189e17648d7 + (direction_vector[0] + var_ccd3e6f1fa89f0eb, direction_vector[1] + var_ccd3e6f1fa89f0eb, var_9a385189e17648d7[2]);
    chopper = spawnVehicle("veh9_mil_air_heli_ahotel64_mp", "apache_spawner", "veh_apache_mp_phys", var_e634d026ea7a8691, starting_angles);
    chopper.script_startinghealth = 100000;
    chopper setscriptablepartstate("engine", "on");
    chopper setmaxpitchroll(20, 20);
    chopper vehicle_setspeed(150, chopper_speed, 60);
    var_281a2a89b605a1a0 = var_cccda3070a0fe6b6 + (direction_vector[0] + var_ccd3e6f1fa89f0eb, direction_vector[1] + var_ccd3e6f1fa89f0eb, var_cccda3070a0fe6b6[2]);
    chopper setvehgoalpos(var_281a2a89b605a1a0, 1);
  }
}

function private function_f8a56971cf3264c1(start_position, end_position, var_d9ca98eb73e09c8f, var_a24ff953682e3b2e, spread, playsound) {
  if(!isDefined(playsound)) {
    playsound = 0;
  }

  turret = spawnturret("misc_turret", start_position, "pac_sentry_turret_mp");
  var_279080a508850b56 = function_d4d21b1f836bf9f0();

  if(isDefined(turret)) {
    turret setCanDamage(1);
    turret setModel("weapon_wm_mg_sentry_turret");
    turret dontinterpolate();
    turret.ignorerandombulletdamage = 1;
    turret.ignoreall = 1;
    turrettarget = spawn("script_model", end_position);

    if(turret turretcantarget(turrettarget.origin)) {
      turret snaptotargetentity(turrettarget);
    } else {
      assertmsg("<dev string:x429>");
    }

    var_4a9a619161cf4818 = getdvarint(@ "hash_4869c1af55b562b4", 0) == 1 && function_ed98c3ba3d253905();

    if(!var_4a9a619161cf4818) {
      var_a24ff953682e3b2e = var_d9ca98eb73e09c8f.size;
    }

    for(i = 0; i < var_a24ff953682e3b2e; i++) {
      turret shootturret(undefined, 6);

      if(!playsound) {
        turret stopsounds();
      }

      waitframe();

      if(var_4a9a619161cf4818) {
        var_1855726eba4efd75 = (randomfloatrange(abs(spread) * -1, abs(spread)), randomfloatrange(abs(spread) * -1, abs(spread)), randomfloatrange(abs(spread) * -1, abs(spread)));
        turrettarget.origin = (end_position[0] + var_1855726eba4efd75[0], end_position[1] + var_1855726eba4efd75[1], end_position[2] + var_1855726eba4efd75[2]);
        continue;
      }

      var_f366890a05935d8d = var_d9ca98eb73e09c8f[i];
      turrettarget.origin = (end_position[0] + var_f366890a05935d8d[0], end_position[1] + var_f366890a05935d8d[1], end_position[2] + var_f366890a05935d8d[2]);
    }

    turret delete();
    turrettarget delete();
  }

  level notify("turret_bullet_damage_finished");
}

function private function_fd70cf6883992643(player) {
  player endon("death_or_disconnect");
  var_f56a9c0baa4c80d4 = function_1810f6c6a90c53d();
  var_279080a508850b56 = function_d4d21b1f836bf9f0();

  foreach(bullet_array in var_f56a9c0baa4c80d4) {
    if(bullet_array.size != 4) {
      assertmsg("<dev string:x479>");
      continue;
    }

    start_position = bullet_array[0];
    end_position = bullet_array[1];
    var_63169026e5dce4a2 = bullet_array[2];
    spread = bullet_array[3];
    thread function_f8a56971cf3264c1(start_position, end_position, var_279080a508850b56, var_63169026e5dce4a2, spread);
  }
}

function private function_3f61cb09115d6984(player) {
  if(function_ed98c3ba3d253905()) {
    if(namespace_2a06ffe6a2b4132::function_420969790027e6f()) {
      namespace_2a06ffe6a2b4132::function_e8683d8412fba24f(player, 0);
    } else {
      thread namespace_2a06ffe6a2b4132::function_96f86549e383586(player, function_470350e8e748d844());
      iprintlnbold("<dev string:x4ac>");
    }
  } else {
    thread namespace_2a06ffe6a2b4132::function_96f86549e383586(player, function_470350e8e748d844());
  }

  return true;
}

#using_animtree("script_model");

function private function_9dde08d506749cf7(player) {
  player endon("death_or_disconnect");
  level.scr_animtree["ghost_sequence"] = #animtree;
  level.scr_anim["ghost_sequence"]["mp_vm_benchmark"] = % jup_mp_ghost_benchmark;
  level.scr_animname["ghost_sequence"]["mp_vm_benchmark"] = "jup_mp_ghost_benchmark";
  level.scr_eventanim["ghost_sequence"]["mp_vm_benchmark"] = "mp_vm_benchmark";
  level.scr_viewmodelanim["ghost_sequence"]["mp_vm_benchmark"] = "jup_mp_ghost_benchmark";
  ghost_origin = getdvarvector(@ "hash_f1279492577aba0c", (0, 0, 0));
  ghost_angles = getdvarvector(@ "hash_9c5bcf7eab5ed00e", (0, 0, 0));
  ghost_model = spawn("script_model", ghost_origin);
  ghost_model.angles = ghost_angles;
  ghost_model setModel("body_c_jup_sp_hero_ghost_urban");
  ghost_head = spawn("script_model", (0, 0, 0));
  ghost_head setModel("c_jup_head_hero_ghost_nvm");
  ghost_head linkTo(ghost_model, "j_spine4", (0, 0, 0), (0, 0, 0));
  ghost_gun = spawn("script_model", (0, 0, 0));
  ghost_gun setModel("wpn_jup_vm_jp01_ar_golf36_benchmark");
  ghost_gun linkTo(ghost_model, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  starting_node = spawn_tag_origin(ghost_origin, ghost_angles);
  ghost_model.animname = "ghost_sequence";
  ghost_model useanimtree(#animtree);
  starting_node scripts\common\anim::anim_first_frame_solo(ghost_model, "mp_vm_benchmark");
  starting_node thread scripts\common\anim::anim_single_solo(ghost_model, "mp_vm_benchmark");

  thread function_ef57a3251328e251(ghost_model);

  var_49f2033a17ddc788 = scripts\common\anim::function_52351c3338da63f4("ghost_sequence", "mp_vm_benchmark");
  thread function_af45038443aa19b(player, ghost_model, "dx_op_bttl_onu6_ghos", var_49f2033a17ddc788 - 17, 0.9);
}

function private function_12315996b29aec80(player) {
  var_7a5c0758ba4f2ff1 = getdvarint(@ "hash_7af24cddfeab37b9", 10);

  if(var_7a5c0758ba4f2ff1 < 3) {
    assertmsg("<dev string:x4f0>");
    return;
  }

  explodepos = getdvarvector(@ "hash_e31cf514697f762", (-6845, 4135, -270));
  function_1f1b77d5f3982cdf(player, var_7a5c0758ba4f2ff1, explodepos);

  if(!function_ed98c3ba3d253905()) {
    wait var_7a5c0758ba4f2ff1 + 6;
    function_1c7d1e4fb99ef2c9();

    foreach(enemy in level.var_5aea0aebeb1f6f3a) {
      if(isDefined(enemy) && isalive(enemy)) {
        enemy scripts\cp_mp\agents\agent_utils::despawnagent();
      }
    }
  }
}

function private function_e82a6af3d2195354(player) {
  radiusdamage((386, 1973, 67), 100, 100, 100, player, "MOD_EXPLOSIVE", "c4_mp");
  wait 0.5;

  for(i = 0; i < 2; i++) {
    player launchgrenade("semtex_mp", (-974, 2148, -160), (0, 0, 0), 0.05);
    wait 0.1;
  }

  radiusdamage((-1346, 2468, 29), 50, 50, 50, player, "MOD_EXPLOSIVE", "c4_mp");
  wait 0.7;
  radiusdamage((-538, 2582, -94), 30, 100, 100, player, "MOD_EXPLOSIVE", "c4_mp");
  wait 0.2;
  radiusdamage((-1015, 2573, 104), 20, 300, 300, player, "MOD_EXPLOSIVE", "c4_mp");
  radiusdamage((-1008, 2715, 91), 20, 300, 300, player, "MOD_EXPLOSIVE", "c4_mp");
  player launchgrenade("semtex_mp", (-346, 2975, 132), (0, 0, 0), 0.05);
  radiusdamage((-346, 2975, 132), 200, 300, 300, player, "MOD_EXPLOSIVE", "c4_mp");
  radiusdamage((-595, 2921, -7), 200, 300, 300, player, "MOD_EXPLOSIVE", "c4_mp");
}

function private function_7c4f8b1de422efec(player) {
  damage_weapon = scripts\cp_mp\weapon::buildweapon("iw9_ar_mike4_mp", ["laserbox_hip04", "none", "none", "none", "none", "none"], "none", "none");
  player dodamage(player.health * 0.1, player.origin, player, undefined, "MOD_RIFLE_BULLET", damage_weapon);
  wait 0.1;
  player dodamage(player.health * 0.1, player.origin, player, undefined, "MOD_RIFLE_BULLET", damage_weapon);
  wait 0.1;
  player dodamage(player.health * 0.25, player.origin, player, undefined, "MOD_RIFLE_BULLET", damage_weapon);
}

function private function_ed6e58cdd7112e67(player) {
  player dodamage(player.health * 0.15, player.origin, player, undefined, "MOD_EXPLOSIVE", "c4_mp");
}

function private function_c0af2b7def50dcc7() {
  origin = getdvarvector(@ "hash_d3c527d19ae2515c", (2219, 4654, 18));
  angles = getdvarvector(@ "hash_417cb47982400a9e", (0, -140, 0));
  agent = scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_base", origin, angles);

  if(!isDefined(agent)) {
    assertmsg("<dev string:x51f>");
    return undefined;
  }

  agent enabletraversals(0);
  agent.dontevershoot = 1;
  agent.bt.cannotmelee = 1;
  agent scripts\engine\utility::set_movement_speed(0);
  agent enabletraversals(0);
  agent allowedstances("stand");
  agent.aggressivemode = 0;
  agent function_9215ce6fc83759b9(600);
  agent agentsetfavoriteenemy(undefined);
  agent.ignoreme = 1;
  agent.ignoreall = 1;
  agent.disablebulletwhizbyreaction = 1;
  agent setcanusecover(0);
  agent.disablerunngun = 1;
  agent.disabledodge = 1;
  agent.scripted_mode = 1;
  return agent;
}

function private function_ab50b0cfe0a25e10(agent, var_87693ce482749800) {
  agent endon("<dev string:x558>");
  level.player endon("<dev string:x561>");

  if(!isDefined(var_87693ce482749800)) {
    var_87693ce482749800 = "<dev string:x578>";
  }

  if(var_87693ce482749800 == -1) {
    var_87693ce482749800 = "<dev string:x59b>";
  } else if(var_87693ce482749800 == -9999) {
    var_87693ce482749800 = "<dev string:x5af>";
  }

  while(true) {
    var_166e5196f2d1c91d = agent gettagorigin("<dev string:x5d2>");
    print3d(var_166e5196f2d1c91d, var_87693ce482749800, (1, 0, 0), 1, 1, 1);
    waitframe();
  }
}

function private function_61f3ce164ef1f960(player) {
  level endon("<dev string:x5dd>");
  player endon("<dev string:x5eb>");
  buttondown = 0;
  var_ddab7b8531f97681 = 0;

  for(;;) {
    if(!function_5dae57c13c89243() && getdvarint(@ "hash_eb1fe583508df55f", 0) == 1) {
      i = 1;

      foreach(var_e4170769bbe4047f, var_4d145c553ba90634 in level.var_c9015938cda707d1) {
        if(player buttonPressed(string(i))) {
          if(!var_4d145c553ba90634) {
            function_b11b460cc47954fe(var_e4170769bbe4047f);
          }

          level.var_c9015938cda707d1[var_e4170769bbe4047f] = 1;
          break;
        } else {
          level.var_c9015938cda707d1[var_e4170769bbe4047f] = 0;
        }

        i++;
      }
    }

    if(getdvarint(@ "hash_eb1fe583508df55f", 0) == 1 && player buttonPressed("<dev string:x604>")) {
      if(!buttondown) {
        if(level.var_9de370d7bf15cd5a.size > 0) {
          function_81c942a8f88e3aa5(undefined);
        }
      }

      buttondown = 1;
    } else if(player buttonPressed("<dev string:x60c>")) {
      if(!buttondown) {
        thread function_fd70cf6883992643(player);
      }

      buttondown = 1;
    } else if(player buttonPressed("<dev string:x614>")) {
      if(!buttondown) {
        function_5a93e9a1c0ba1f95(200, 125);
      }

      buttondown = 1;
    } else {
      buttondown = 0;
    }

    waitframe();
  }
}

function private debug_noclip() {
  if(!function_ed98c3ba3d253905()) {
    if(level.var_f70d0bb42f912148 != 0) {
      if(level.player islinked()) {
        level.player unlink(1);
      } else if(isDefined(level.var_b54542b9e76b8f10)) {
        level.player playerlinktoabsolute(level.var_b54542b9e76b8f10, "<dev string:x61a>");
      }
    }
  }

  adddebugcommand("<dev string:x628>");
}

function private function_5c3bc447572e6477(line_start, line_end) {
  level endon("<dev string:x5dd>");
  level.player endon("<dev string:x5eb>");
  thread scripts\engine\utility::draw_line_for_time(line_start, line_end, 0, 1, 0, 3);
}

function private function_dbe0451646f4d30f(player) {
  level endon("<dev string:x5dd>");
  player endon("<dev string:x5eb>");
  var_d3e31f685d0b4bd6 = function_1810f6c6a90c53d();
  const_radius = 15;

  for(;;) {
    if(getdvarint(@ "hash_f802d08d640f01c2", 0) == 0) {
      waitframe();
      continue;
    }

    foreach(index, bullet_info in var_d3e31f685d0b4bd6) {
      print3d(bullet_info[0], "<dev string:x633>" + index, (0, 0, 1), 1, 0.5, 1, 1);
      sphere(bullet_info[0], const_radius, (0, 0, 1), 0, 1);
      line(bullet_info[0], bullet_info[1], (0, 0, 1), 1, 0, 1);
    }

    waitframe();
  }
}

function private function_5a93e9a1c0ba1f95(amount, spread) {
  if(!isDefined(amount)) {
    amount = 300;
  }

  if(!isDefined(spread)) {
    spread = 100;
  }

  fileid = openfile("<dev string:x63f>", "<dev string:x659>");

  if(fileid == -1) {
    assertmsg("<dev string:x662>");
    return 0;
  }

  fprintln(fileid, "<dev string:x68b>");

  for(i = 0; i < amount; i++) {
    var_1855726eba4efd75 = (randomfloatrange(abs(spread) * -1, abs(spread)), randomfloatrange(abs(spread) * -1, abs(spread)), randomfloatrange(abs(spread) * -1, abs(spread)));
    fprintln(fileid, "<dev string:x6eb>" + var_1855726eba4efd75[0] + "<dev string:x6f1>" + var_1855726eba4efd75[1] + "<dev string:x6f1>" + var_1855726eba4efd75[2] + "<dev string:x6f7>");
  }

  assertmsg("<dev string:x6fe>");
}

function private function_ef57a3251328e251(ghost_model) {
  level endon("<dev string:x5dd>");
  level.player endon("<dev string:x5eb>");

  for(;;) {
    text = "<dev string:x720>" + ghost_model.origin[0] + "<dev string:x6f1>" + ghost_model.origin[1] + "<dev string:x6f1>" + ghost_model.origin[2];
    printtoscreen2d(300, 100, text, (1, 0, 0), 1.3, 1);
    line(ghost_model.origin, ghost_model.origin + (0, 0, 2000), (1, 0, 0), 1, 0, 1);
    waitframe();
  }
}

function private function_d4d21b1f836bf9f0() {
  var_d9ca98eb73e09c8f = [(-73.3719, 41.1224, -20.7443), (-0.205994, 17.8299, -102.478), (87.6389, 76.355, -112.755), (120.445, -35.8582, 106.415), (-78.2318, 6.75201, -14.2441), (96.5576, -89.4165, -56.1905), (28.4042, -115.723, -87.7457), (17.8223, 105.057, -99.7391), (-3.58582, 56.3431, -79.071), (-55.4657, -97.7249, -66.8869), (6.11115, 32.692, 43.4113), (-10.3607, 79.3991, 52.5208), (30.5328, -7.65228, 6.21796), (-110.924, -103.668, 51.178), (67.4515, -56.8848, 15.3427), (-58.4869, -28.1601, -73.0362), (19.3481, -99.2737, -16.5558), (-67.8711, -31.7459, -9.4986), (30.4031, 57.6248, 74.3866), (-19.3176, 52.7649, 74.4705), (52.4445, 90.2176, -36.7813), (-0.671387, 21.3776, 122.391), (37.2086, -38.1546, -25.9552), (64.1098, 98.7091, 58.5251), (-44.7617, -105.858, -97.5418), (73.6465, -96.1761, -68.0466), (-36.9949, 56.015, 121.086), (42.3737, -85.8307, -36.438), (-4.84467, 33.9737, -105.385), (82.1075, 107.651, 8.96454), (-11.1237, 4.60815, -37.8723), (17.2577, 82.2296, -89.6149), (117.302, 56.3736, 18.8599), (-15.0146, -16.0065, -49.8505), (-39.8331, 7.52258, 13.0539), (-6.5155, 33.7524, -34.6069), (-12.9166, -81.9931, 56.5338), (79.0405, -29.9759, 90.8051), (-36.0947, -1.80817, -3.95966), (117.729, 87.4939, -107.162), (-70.5032, 104.668, -53.7186), (89.1342, -113.388, 46.196), (121.269, -63.2095, 111.694), (110.115, -73.9136, 11.7874), (-82.4814, -15.8539, -88.8214), (-65.1169, -72.4716, 105.804), (-96.3135, -71.2357, 35.9421), (56.4194, 35.08, -17.9367), (74.44, -95.5887, 4.16565), (121.544, 23.9334, 85.762), (93.8034, -38.1775, 44.1818), (41.2598, -55.0003, -94.1391), (-32.6157, 111.374, -119.774), (16.9449, 80.2155, 57.5562), (74.7757, 116.814, -22.5525), (-84.6176, -71.2814, -55.7632), (32.0206, 122.963, -83.4885), (88.5925, -110.252, -66.6199), (-56.0074, -79.5975, 77.9724), (52.4216, 119.003, -39.772), (30.6473, 8.69751, 113.899), (-12.3291, 101.646, -48.8052), (9.90295, 70.1447, 33.9432), (13.1073, 73.5397, 12.7716), (8.59833, 86.5479, 26.2299), (-70.755, -77.7893, -85.1517), (42.984, 74.7223, -114.09), (97.4503, -122.62, 88.2492), (26.2985, 111.16, 25.6271), (-119.713, 46.9894, 107.368), (-35.5606, -84.938, 9.51385), (77.8122, -65.0101, 18.692), (6.78253, 90.3549, 25.1389), (-120.216, -117.76, 107.742), (-31.25, -105.934, -47.9584), (-31.6238, -83.0917, 98.5413), (101.021, -71.0526, 92.3004), (-122.345, -73.2574, 54.306), (-111.382, -94.3756, -37.4527), (-1.07574, -111.71, -25.8865), (35.9344, -88.2874, -50.4608), (41.6794, -2.41852, -39.9246), (-76.4847, -84.3124, 117.95), (23.468, -40.863, -57.5333), (-27.5803, 99.6552, -79.7501), (44.1742, 46.0892, -1.93024), (-84.7244, 11.055, 9.90295), (-93.338, 108.627, 108.91), (-36.7889, 26.3672, -58.5403), (-97.4121, 122.429, -12.9242), (-83.0688, -66.2766, 19.7983), (-6.5918, -101.639, -85.1288), (-87.059, -106.377, 76.7441), (10.8337, 109.917, 120.842), (113.335, 81.2759, 21.759), (79.7806, 101.875, 110.39), (5.26428, 27.9617, 25.5127), (60.4553, -87.2192, 46.0968), (-35.2631, 16.3345, -84.0454), (115.532, 90.2176, 57.8537), (124.352, -77.5223, -62.8204), (113.434, 93.3533, -42.5491), (6.78253, 90.538, -42.9459), (-68.634, -123.985, 66.246), (110.588, 0.556946, -98.6176), (-99.1974, 17.3111, -60.3714), (53.154, 100.899, -94.7418), (96.2372, 30.8304, 17.7155), (2.89154, 50.7126, 47.8516), (-16.1438, -121.933, 99.9146), (109.375, -40.7791, 89.5691), (72.8302, 3.12042, 110.489), (-17.5629, 94.3375, 1.92261), (-22.9416, 33.9355, 96.4508), (118.874, -82.6569, 35.8963), (-98.465, -73.3109, 105.034), (45.0592, 10.4675, 4.40979), (94.5206, -95.9167, -19.8364), (-25.0626, -46.257, 124.596), (-43.9911, 71.9986, 22.5906), (-7.57599, 54.4052, 66.8716), (94.0857, -18.0359, 80.9326), (44.632, -10.3912, 54.9393), (-124.313, -94.9326, 57.8156), (-106.049, -30.6396, 95.8557), (5.93567, 87.2498, -19.0964), (13.2446, -85.4492, -43.6859), (93.3304, 31.4636, 29.747), (-15.2893, -47.2641, -17.7612), (94.7647, 39.9017, -69.5877), (-79.5517, -34.7366, 48.4543), (-62.0422, 115.097, 7.82776), (26.3062, 51.5213, -35.7437), (67.3752, 2.39563, 124.557), (71.6095, 62.3093, 65.6815), (106.209, -75.7828, 62.2101), (-29.1595, 123.207, -114.723), (99.7849, 48.8663, 70.7397), (70.5109, 23.1934, -27.7252), (107.574, -30.5176, -99.9832), (80.1315, 61.6989, 29.9911), (70.7016, 82.0236, 90.3625), (32.0053, -117.859, 59.0591), (101.486, 11.3678, -38.1699), (-34.8358, 49.7971, 35.0494), (-49.5224, 31.6544, 59.906), (95.6192, 109.459, 73.3795), (106.705, 26.8326, 115.089), (72.9675, -87.4939, -67.2836), (107.292, 80.6656, 59.5856), (-76.1108, 86.0901, 97.3816), (-123.993, 37.5443, -106.361), (-39.0625, -42.0914, -51.2772), (104.828, -22.6517, -90.1489), (-68.6874, 1.23596, -48.0804), (41.6183, 14.5569, 45.1584), (10.7727, 4.78363, -12.1384), (-121.91, 54.863, -111.13), (52.6276, -96.4279, -34.0195), (-50.6363, -113.319, -39.3829), (47.0123, 108.765, 53.3752), (-13.382, -108.33, -13.6566), (-78.4225, -51.0635, 13.855), (-88.0127, -7.48444, 122.597), (-112.572, 61.1191, -91.1636), (-43.19, 108.81, 111.687), (-106.491, -49.9039, 35.0571), (-75.2945, -121.605, 21.5607), (-84.8389, 47.02, 103.493), (37.6129, 112.869, -12.9776), (-91.7664, -103.6, 64.2014), (-51.7273, -92.8421, 51.9333), (74.8978, -87.5702, 44.7998), (6.21033, -94.4824, 17.9291), (1.4267, -76.0193, 110.733), (-72.258, -44.9982, -37.9257), (8.02612, 51.3763, 114.09), (-27.0004, -106.712, -2.47955), (85.8994, 29.2435, 40.9088), (27.2369, 36.377, -5.06592), (103.966, -12.2452, -115.906), (-52.4292, -56.2668, 61.6302), (-63.8199, -118.683, -73.2498), (123.787, 9.14764, -81.3217), (57.6859, 38.4674, 59.3948), (-10.1547, -3.50952, -124.207), (122.589, -98.671, -110.58), (-84.3735, 74.9588, -41.2216), (85.6247, 7.08771, 73.2803), (83.2138, 100.38, 96.8094), (-46.6232, 88.9511, 26.8173), (63.0035, 102.074, -43.9072), (14.8849, -80.2765, 87.2726), (-71.2738, 60.0967, -35.5225), (45.9595, -110.672, 77.7512), (91.9189, 110.626, -112.64), (23.1018, -122.612, -48.2101), (-77.7893, -61.3251, -58.5861), (-39.0167, -44.3497, 37.529), (103.745, 72.5021, -52.4292)];
  return var_d9ca98eb73e09c8f;
}