/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_doa_bo3.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\cp\cp_doa_bo3_enemy;
#using scripts\cp\cp_doa_bo3_fx;
#using scripts\cp\cp_doa_bo3_player_challenge;
#using scripts\cp\cp_doa_bo3_silverback_battle;
#using scripts\cp\cp_doa_bo3_sound;
#using scripts\cp\doa\_doa_arena;
#using scripts\cp\doa\_doa_core;
#using scripts\cp\doa\_doa_enemy;
#using scripts\cp\doa\_doa_fx;
#using scripts\cp\doa\_doa_gibs;
#using scripts\cp\doa\_doa_pickups;
#using scripts\cp\doa\_doa_player_utility;
#using scripts\cp\doa\_doa_round;
#using scripts\cp\doa\_doa_sfx;
#using scripts\cp\doa\_doa_utility;
#using scripts\shared\ai\systems\ai_blackboard;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicles\_quadtank;
#using scripts\shared\vehicles\_spider;
#namespace namespace_bb5d050c;

function setup_rex_starts() {
  util::add_gametype("doa");
}

function function_30fd2139() {
  if(sessionmodeisonlinegame()) {
    doa_utility::debugmsg("");
    precacheleaderboards("LB_CP_DOA_BO3_ROUND LB_CP_DOA_BO3_SCORE LB_CP_DOA_BO3_SILVERBACKS LB_CP_DOA_BO3_GEMS LB_CP_DOA_BO3_SKULLS LB_CP_DOA_BO3_SCORE_1PLAYER LB_CP_DOA_BO3_SCORE_2PLAYER LB_CP_DOA_BO3_SCORE_3PLAYER LB_CP_DOA_BO3_SCORE_4PLAYER LB_CP_DOA_BO3_ROUND_1PLAYER LB_CP_DOA_BO3_ROUND_2PLAYER LB_CP_DOA_BO3_ROUND_3PLAYER LB_CP_DOA_BO3_ROUND_4PLAYER");
  }
}

function main() {
  setdvar("ui_allowDisplayContinue", 0);
  clientfield::register("world", "redinsExploder", 1, 2, "int");
  clientfield::register("world", "activateBanner", 1, 3, "int");
  clientfield::register("world", "pumpBannerBar", 1, 8, "float");
  clientfield::register("scriptmover", "runcowanim", 1, 1, "int");
  clientfield::register("world", "redinstutorial", 1, 1, "int");
  clientfield::register("world", "redinsinstruct", 1, 12, "int");
  clientfield::register("scriptmover", "runsiegechickenanim", 8000, 2, "int");
  setsharedviewport(1);
  settopdowncamerayaw(0);
  function_30fd2139();
  setdvar("bg_friendlyFireMode", 0);
  level.var_7ed6996d = & init;
  level.var_fd84aa1f = & function_56600114;
  level thread namespace_693feb87::main();
  level thread namespace_e8effba5::main();
  level thread namespace_4fca3ee8::main();
}

function init() {
  level.doa.var_d18af0d = & function_957373c6;
  level.doa.var_fdc1fa6b = & function_dbb56674;
  level.doa.var_aeeb3a0e = & function_5ee7262b;
  level.doa.var_62423327 = & arenainit;
  level.doa.var_cefa8799 = & function_87092704;
  level.doa.var_c95041ea = & function_165c9bd0;
  level.doa.var_5ddb204f = & function_aab05139;
  level.doa.var_771e3915 = & namespace_51bd792::function_771e3915;
  namespace_51bd792::init();
  namespace_a3646565::init();
  function_d1c7245c();
  level.doa.enemyspawners = [];
  level.doa.var_e6fd0e17 = & namespace_51bd792::function_65762352;
  rootmenu = "devgui_cmd \"Zombietron/Spawn/Enemy/";
  spawners = getspawnerarray();
  setdvar("scr_spawn_name", "");
  type = undefined;
  foreach(spawner in spawners) {
    if(isDefined(spawner.team) && spawner.team != "axis") {
      continue;
    }
    if(isDefined(spawner.script_team) && spawner.script_team != "axis") {
      continue;
    }
    if(spawner.classname == "script_vehicle" && isDefined(spawner.archetype)) {
      if(issubstr(spawner.vehicletype, "_zombietron_")) {
        type = strtok2(spawner.vehicletype, "_zombietron_");
        name = type[1];
      } else {
        name = spawner.archetype;
      }
      cmd = (((rootmenu + name) + "\" \"zombie_devgui aispawn; scr_spawn_name ") + name) + "\" \n";
      level.doa.enemyspawners[name] = spawner;
      adddebugcommand(cmd);
      continue;
    }
    if(!issubstr(spawner.classname, "_zombietron_")) {
      continue;
    }
    type = strtok2(spawner.classname, "_zombietron_");
    name = type[1];
    if(isDefined(type) && type.size == 2) {
      classname = spawner.classname;
      if(isDefined(spawner.script_parameters)) {
        type = strtok(spawner.script_parameters, ":");
        classname = type[1];
        name = "zombie_" + classname;
      }
      cmd = (((rootmenu + name) + "\" \"zombie_devgui aispawn; scr_spawn_name ") + classname) + "\" \n";
      level.doa.enemyspawners[name] = spawner;
      adddebugcommand(cmd);
    }
  }
}

function function_dbb56674() {
  if(getplayers().size > 1) {
    mapname = namespace_3ca3c537::function_d2d75f5d();
    if(mapname == "vengeance") {
      return 8;
    }
    if(mapname == "clearing") {
      return 6;
    }
  }
  return -1;
}

function function_5ee7262b(def) {
  switch (def.type) {
    case "type_electric_mine": {
      break;
    }
    default: {
      assert(0);
      break;
    }
  }
}

function function_d1c7245c() {
  level.doa.var_af875fb7 = [];
  level.doa.var_1332e37a = [];
  guardian = spawnStruct();
  guardian.type = 30;
  guardian.spawner = getent("spawner_zombietron_skeleton", "targetname");
  guardian.spawnfunction = & namespace_51bd792::function_862e15fa;
  guardian.initfunction = & function_89a2ffc4;
  level.doa.var_af875fb7[level.doa.var_af875fb7.size] = guardian;
  guardian = spawnStruct();
  guardian.type = 31;
  guardian.spawner = getent("zombietron_guardian_robot", "targetname");
  guardian.spawnfunction = & namespace_51bd792::function_575e3933;
  guardian.initfunction = & function_75772673;
  level.doa.var_af875fb7[level.doa.var_af875fb7.size] = guardian;
}

function function_75772673(player) {
  self endon("death");
  self ai::set_behavior_attribute("rogue_control", "forced_level_1");
  self.health = 15000;
  self.team = player.team;
  self.owner = player;
  self.goalradius = 100;
  self.holdfire = 0;
  self.updatesight = 1;
  self.allowpain = 0;
  self setthreatbiasgroup("players");
  self ai::set_behavior_attribute("rogue_control_speed", "run");
  if(!isDefined(player.doa)) {
    self kill();
  }
  player.doa.var_af875fb7 = array::remove_undefined(player.doa.var_af875fb7);
  player.doa.var_af875fb7[player.doa.var_af875fb7.size] = self;
  blackboard::setblackboardattribute(self, "_desired_stance", "crouch");
  self thread function_cd6da677(player);
  self thread function_cef7f9fd();
  self thread function_8e619e60(player);
  color = namespace_831a4a7c::function_ee495f41(player.entnum);
  trail = "gem_trail_" + color;
  self setplayercollision(0);
  self namespace_51bd792::droptoground(self.origin, trail, "turret_impact", 0, 0);
  self namespace_1a381543::function_90118d8c("evt_robot_land");
  self namespace_eaa992c::function_285a2999("player_trail_" + color);
  while(isDefined(player)) {
    self clearforcedgoal();
    nodes = getnodesinradius(player.origin, 512, 128);
    if(isDefined(nodes) && nodes.size > 0) {
      goto = nodes[randomint(nodes.size)].origin;
      self useposition(goto);
    }
    wait(randomintrange(5, 12));
  }
}

function function_e1cd643e(projectile, weapon, player) {
  self endon("death");
  while(isDefined(projectile)) {
    self waittill("trigger", guy);
    if(!isDefined(guy.boss) && isalive(guy)) {
      guy dodamage(guy.health, self.origin, (isDefined(player) ? player : undefined), (isDefined(player) ? player : undefined), "torso_lower", "MOD_EXPLOSIVE", 0, weapon, -1, 1);
    }
  }
  self delete();
}

function function_8e619e60(player) {
  self endon("death");
  while(true) {
    self waittill("missile_fire", projectile, weapon);
    trigger = spawn("trigger_radius", projectile.origin, 9, 16, 24);
    trigger.targetname = "sawBladeProjectile";
    trigger enablelinkto();
    trigger linkto(projectile);
    trigger thread function_e1cd643e(projectile, weapon, player);
    trigger thread doa_utility::function_1bd67aef(3);
    trigger thread doa_utility::function_75e76155(projectile, "death");
  }
}

function function_89a2ffc4(player) {
  self.zombie_move_speed = "super_sprint";
  self.health = 15000;
  self.team = player.team;
  self.owner = player;
  self.goalradius = 100;
  self.allowpain = 0;
  self.aux_melee_damage = & function_f45d4afc;
  self namespace_eaa992c::function_285a2999("player_trail_" + namespace_831a4a7c::function_ee495f41(player.entnum));
  self.holdfire = 0;
  self.updatesight = 1;
  self setthreatbiasgroup("players");
  self setplayercollision(0);
  self notify("hash_6e8326fc");
  self cleartargetentity();
  if(!isDefined(player.doa)) {
    self kill();
    return;
  }
  self namespace_1a381543::function_90118d8c("evt_skel_rise");
  if(!isDefined(player.doa.var_af875fb7)) {
    player.doa.var_af875fb7 = [];
  }
  if(player.doa.var_af875fb7.size) {
    player.doa.var_af875fb7 = array::remove_undefined(player.doa.var_af875fb7);
  }
  player.doa.var_af875fb7[player.doa.var_af875fb7.size] = self;
  self thread function_cd6da677(player);
  self thread function_5633d485();
}

function function_f45d4afc(target) {
  if(self.team == target.team) {
    return;
  }
  vel = vectorscale(self.origin - target.origin, 0.2);
  target namespace_fba031c8::function_ddf685e8(vel, self);
  if(isDefined(target)) {
    target dodamage(1100, target.origin, self, self);
    self namespace_1a381543::function_90118d8c("evt_skel_attack");
  }
}

function function_cd6da677(owner) {
  self waittill("death");
  if(isDefined(owner)) {
    if(isDefined(self)) {
      arrayremovevalue(owner.doa.var_af875fb7, self, 0);
    } else {
      array::remove_undefined(owner.doa.var_af875fb7, 0);
    }
  }
}

function function_5633d485() {
  self endon("death");
  lifetime = self.owner doa_utility::function_1ded48e6(level.doa.rules.var_109b458d);
  self thread doa_utility::function_783519c1("doa_game_is_over", 1);
  self thread doa_utility::function_783519c1("doa_game_restart", 1);
  self thread doa_utility::function_783519c1("kill_guardians", 1);
  wait(lifetime);
  self kill();
}

function function_cef7f9fd() {
  self endon("death");
  lifetime = self.owner doa_utility::function_1ded48e6(level.doa.rules.var_109b458d);
  self thread doa_utility::function_783519c1("doa_game_is_over", 1);
  self thread doa_utility::function_783519c1("doa_game_restart", 1);
  self thread doa_utility::function_783519c1("kill_guardians", 1);
  wait(lifetime);
  self clientfield::increment("burnZombie");
  self.ignoreall = 1;
  self namespace_1a381543::function_90118d8c("gdt_immolation_robot_countdown");
  var_989e36b3 = 2000 + gettime();
  while(gettime() < var_989e36b3) {
    self dodamage(5, self.origin, undefined, undefined, "none", "MOD_RIFLE_BULLET", 0, getweapon("gadget_immolation"), -1, 1);
    self waittillmatch("bhtn_action_terminate");
  }
  self namespace_1a381543::function_90118d8c("wpn_incendiary_explode");
  playFXOnTag("explosions/fx_ability_exp_immolation", self, "j_spinelower");
  physicsexplosionsphere(self.origin, 200, 32, 2);
  util::wait_network_frame();
  radiusdamage(self.origin, 128, 1500, 1500);
  wait(0.1);
  if(isDefined(self) && isalive(self)) {
    self kill();
  }
}

function function_165c9bd0() {
  var_e6171788 = namespace_3ca3c537::function_d2d75f5d();
  if(var_e6171788 == "boss" && level.doa.arena_round_number == 3 || (isDefined(level.doa.var_602737ab) && level.doa.var_602737ab)) {
    if(isDefined(level.doa.var_602737ab) && level.doa.var_602737ab) {
      namespace_3ca3c537::function_5af67667(namespace_3ca3c537::function_5835533a("boss"), 1);
      namespace_3ca3c537::function_ba9c838e();
      level thread util::set_lighting_state(3);
      namespace_cdb9a8fe::function_55762a85();
      namespace_831a4a7c::function_82e3b1cb();
    }
    level.doa.var_602737ab = undefined;
    level thread function_1de9db1b("silverback");
    return true;
  }
  if(var_e6171788 == "cave" && level.doa.arena_round_number == 0 || (isDefined(level.doa.var_bae65231) && level.doa.var_bae65231)) {
    if(isDefined(level.doa.var_bae65231) && level.doa.var_bae65231) {
      namespace_3ca3c537::function_5af67667(namespace_3ca3c537::function_5835533a("cave"), 1);
      namespace_3ca3c537::function_ba9c838e();
      namespace_cdb9a8fe::function_55762a85();
      namespace_831a4a7c::function_82e3b1cb();
    }
    level.doa.var_bae65231 = undefined;
    level thread function_1de9db1b("margwa");
    return false;
  }
  return false;
}

function function_1de9db1b(name) {
  switch (name) {
    case "margwa": {
      namespace_51bd792::function_4ce6d0ea();
      level notify("hash_593b80cb");
      foreach(player in getplayers()) {
        player notify("hash_593b80cb");
      }
      break;
    }
    case "silverback": {
      namespace_a3646565::function_fc48f9f3();
      level notify("hash_593b80cb");
      foreach(player in getplayers()) {
        player notify("hash_593b80cb");
      }
      break;
    }
  }
}

function function_87092704(room) {
  switch (room.name) {
    case "tankmaze": {
      room.var_6f369ab4 = 99;
      room.var_45da785b = & namespace_df93fc7c::function_6aa91f48;
      room.var_58e293a2 = & namespace_df93fc7c::function_5f0b67a9;
      room.var_c64606ef = & namespace_df93fc7c::function_f1915ffb;
      room.var_1cd9eda = & namespace_df93fc7c::function_9e5e0a15;
      room.var_2530dc89 = & namespace_df93fc7c::function_a25fc96;
      room.var_5281efe5 = 47;
      room.var_2b9a70de = 47;
      room.timeout = 90;
      room.var_a90de2a1 = 30;
      room.random = 15;
      room.banner = 3;
      room.var_ac3f2368 = 0;
      break;
    }
    case "redins": {
      room.var_6f369ab4 = 99;
      room.var_45da785b = & namespace_df93fc7c::function_ba487e2a;
      room.var_58e293a2 = & namespace_df93fc7c::function_f14ef72f;
      room.var_c64606ef = & namespace_df93fc7c::function_ce5fc0d;
      room.var_1cd9eda = & namespace_df93fc7c::function_9d1b24f7;
      room.var_2530dc89 = & namespace_df93fc7c::function_e13abd74;
      room.var_5281efe5 = 11;
      room.var_2b9a70de = 11;
      room.var_a90de2a1 = 30;
      room.timeout = -1;
      room.random = 15;
      room.var_ac3f2368 = 0;
      break;
    }
    case "spiral": {
      room.var_6f369ab4 = 1;
      room.var_45da785b = & namespace_df93fc7c::function_31c377e;
      room.var_58e293a2 = & namespace_df93fc7c::function_8e0e22bb;
      room.var_1cd9eda = & namespace_df93fc7c::function_47a3686b;
      room.var_c64606ef = & namespace_df93fc7c::function_eee6e911;
      room.var_2530dc89 = & namespace_df93fc7c::function_7823dbb8;
      room.var_5281efe5 = 19;
      room.var_cbad0e8f = 19;
      room.var_2b9a70de = 19;
      room.timeout = -1;
      room.var_ac3f2368 = 0;
      break;
    }
    case "truck_soccer": {
      room.var_6f369ab4 = 99;
      room.var_45da785b = & namespace_df93fc7c::function_c7e4d911;
      room.var_58e293a2 = & namespace_df93fc7c::function_2ea4cb82;
      room.var_c64606ef = & namespace_df93fc7c::function_b3939e94;
      room.var_1cd9eda = & namespace_df93fc7c::function_92349eb6;
      room.var_2530dc89 = & namespace_df93fc7c::function_fd4f5419;
      room.banner = 2;
      room.var_5281efe5 = 26;
      room.var_2b9a70de = 26;
      room.timeout = 120;
      room.var_a90de2a1 = 30;
      room.random = 15;
      room.var_ac3f2368 = 0;
      break;
    }
  }
}

function arenainit(arena) {
  if(arena.name == "blood") {
    arena.var_f06f27e8 = & function_9d32f5d;
  }
  if(arena.name == "sgen") {
    arena.var_f06f27e8 = & function_b8aa2b56;
  }
}

function function_957373c6(def) {
  switch (def.number) {
    case 5: {
      def.round = 5;
      def.title = & "CP_DOA_BO3_CHALLENGE_COLLECTOR";
      def.var_84aef63e = 5;
      def.var_83bae1f8 = 1000;
      def.spawnfunc = & namespace_51bd792::function_53b44cb7;
      def.var_23502a36 = 1;
      def.cooldown = 0;
      def.var_759562f7 = 5000;
      break;
    }
    case 9: {
      def.round = 9;
      def.title = & "CP_DOA_BO3_ITS_MY_FARM";
      def.var_84aef63e = 40;
      def.var_83bae1f8 = 1000;
      def.spawnfunc = & namespace_51bd792::function_ce9bce16;
      def.var_23502a36 = 1;
      def.var_3ceda880 = 1;
      def.var_965be9 = & namespace_df93fc7c::function_c0485deb;
      def.var_474e643b = 36;
      break;
    }
    case 6: {
      def.round = 13;
      def.title = & "CP_DOA_BO3_CHALLENGE_RISERS";
      def.var_84aef63e = 40;
      def.var_83bae1f8 = 1000;
      def.spawnfunc = & namespace_51bd792::function_45849d81;
      def.var_23502a36 = 1;
      def.var_3ceda880 = 1;
      def.var_474e643b = 36;
      break;
    }
    case 11: {
      def.round = 17;
      def.var_84aef63e = 8;
      def.title = & "CP_DOA_BO3_CHALLENGE_SHADOW";
      def.var_83bae1f8 = 1000;
      def.maxhitpoints = 1000;
      def.spawnfunc = & namespace_51bd792::function_b9980eda;
      def.var_23502a36 = 1;
      break;
    }
    case 12: {
      def.round = 25;
      def.title = & "CP_DOA_BO3_CHALLENGE_BLOOD_RISERS";
      def.var_84aef63e = 40;
      def.spawnfunc = & namespace_51bd792::function_17de14f1;
      def.var_83bae1f8 = 1000;
      def.maxhitpoints = 1000;
      def.var_23502a36 = 1;
      def.var_3ceda880 = 1;
      def.var_474e643b = 50;
      def.var_a0b2e897 = "blood";
      def.var_79c72134 = 1;
      break;
    }
    case 2: {
      def.round = 26;
      def.title = & "CP_DOA_BO3_CHALLENGE_MEATBALLS";
      def.var_84aef63e = 6;
      def.spawnfunc = & namespace_51bd792::function_fb051310;
      def.var_83bae1f8 = 1000;
      def.maxhitpoints = 1000;
      def.var_3ceda880 = 1;
      def.var_23502a36 = 0.5;
      def.cooldown = 0;
      def.var_759562f7 = 30000;
      def.initfunc = & function_45c28296;
      def.endfunc = & function_f8fa5dcf;
      break;
    }
    case 4: {
      def.round = 33;
      def.title = & "CP_DOA_BO3_CHALLENGE_WARLORD";
      def.var_84aef63e = 5;
      def.var_83bae1f8 = 1000;
      def.spawnfunc = & namespace_51bd792::function_a0d7d949;
      def.var_23502a36 = 1;
      break;
    }
    case 10: {
      def.round = 40;
      def.title = & "CP_DOA_BO3_CHALLENGE_BLOODSUCKER";
      def.var_84aef63e = 20;
      def.var_83bae1f8 = 1000;
      def.maxhitpoints = 1000;
      def.spawnfunc = & namespace_51bd792::function_33525e11;
      def.var_23502a36 = 0.1;
      def.var_3ceda880 = 0;
      def.cooldown = 0;
      def.var_759562f7 = 10000;
      break;
    }
    case 1: {
      def.round = 45;
      def.title = & "CP_DOA_BO3_CHALLENGE_ROBOTS";
      def.var_84aef63e = 10;
      def.spawnfunc = & namespace_51bd792::function_4d2a4a76;
      def.var_83bae1f8 = 1000;
      def.var_23502a36 = 1;
      break;
    }
    case 7: {
      def.round = 49;
      def.title = & "CP_DOA_BO3_CHALLENGE_CELLBREAK";
      def.var_84aef63e = 10;
      def.var_83bae1f8 = 2000;
      def.spawnfunc = & namespace_51bd792::function_5e86b6fa;
      def.var_23502a36 = 1;
      break;
    }
    case 3: {
      def.round = 53;
      def.title = & "CP_DOA_BO3_CHALLENGE_DOGS";
      def.var_84aef63e = 6;
      def.var_83bae1f8 = 1000;
      def.maxhitpoints = 1000;
      def.spawnfunc = & namespace_51bd792::function_bb3b0416;
      def.var_23502a36 = 1;
      def.var_3ceda880 = 1;
      break;
    }
    case 13: {
      def.round = 60;
      def.title = & "CP_DOA_BO3_CHALLENGE_FURY";
      def.var_84aef63e = 6;
      def.var_83bae1f8 = 1000;
      def.maxhitpoints = 1000;
      def.spawnfunc = & namespace_51bd792::function_92159541;
      def.var_23502a36 = 0.5;
      def.var_3ceda880 = 0;
      def.cooldown = 0;
      def.var_759562f7 = 300000;
      def.var_965be9 = & function_dd708257;
      break;
    }
    case 8: {
      def.round = -1;
      def.var_84aef63e = 5;
      def.var_83bae1f8 = 1000;
      def.maxhitpoints = 1000;
      def.spawnfunc = & namespace_51bd792::function_1631202b;
      def.var_23502a36 = 1;
      def.var_3ceda880 = 0;
      level.doa.var_83a65bc6 = def;
      def.cooldown = 0;
      def.var_759562f7 = 5000;
      break;
    }
    case 14: {
      def.round = 37;
      def.title = & "CP_DOA_BO3_CHALLENGE_SPIDER0";
      def.var_7f46fadf = array(&"CP_DOA_BO3_CHALLENGE_SPIDER0", & "CP_DOA_BO3_CHALLENGE_SPIDER2", & "CP_DOA_BO3_CHALLENGE_SPIDER3", & "CP_DOA_BO3_CHALLENGE_SPIDER1");
      def.var_84aef63e = 10;
      def.var_83bae1f8 = 1000;
      def.maxhitpoints = 1000;
      def.spawnfunc = & namespace_51bd792::function_7512c5ee;
      def.endfunc = & function_7ea6d638;
      def.var_23502a36 = 1;
      def.var_3ceda880 = 0;
      def.cooldown = 0;
      def.var_759562f7 = 5000;
      def.var_474e643b = 20;
      def.var_75f2c952 = 24;
      def.var_9cf005d1 = 0;
      def.var_bb9ff15b = 2;
      level.doa.var_afdb45da = def;
      break;
    }
    default: {
      assert(0);
      break;
    }
  }
}

function function_7ea6d638(def) {
  def.round = def.round + 64;
  def.var_474e643b = def.var_474e643b + 4;
  def.var_75f2c952 = def.var_75f2c952 + 12;
  if(def.var_75f2c952 > 64) {
    def.var_75f2c952 = 64;
  }
  def.var_9cf005d1++;
  def.title = def.var_7f46fadf[def.var_9cf005d1 % def.var_7f46fadf.size];
}

function function_45c28296(def) {
  level.doa.var_9a1cbf58 = 0;
}

function function_f8fa5dcf(def) {
  level.doa.var_9a1cbf58 = 1;
}

function function_dd708257(def) {
  level.doa.var_2f019708 = 0;
}

function function_aab05139() {
  videostart("cp_doa_bo3_endgame");
}

function function_ceb822db(var_fed4dbb3) {
  return var_fed4dbb3;
}

function function_9d32f5d() {
  if(!isDefined(level.doa.var_43e34d24)) {
    level.doa.var_43e34d24 = getent("blood_riser_spawner", "targetname");
  }
  return namespace_51bd792::function_17de14f1(level.doa.var_43e34d24);
}

function function_b8aa2b56() {
  if(!isDefined(level.doa.var_8fb5dd7d)) {
    level.doa.var_8fb5dd7d = getent("zombie_riser", "targetname");
  }
  return namespace_51bd792::function_45849d81(level.doa.var_8fb5dd7d);
}

function function_56600114(name) {
  level notify("hash_56600114");
  level endon("hash_56600114");
  switch (name) {
    case "boss": {
      level thread function_2fb9e83f();
      break;
    }
  }
}

function function_2fb9e83f() {
  level notify("hash_2fb9e83f");
  level endon("hash_2fb9e83f");
  level endon("hash_ec7ca67b");
  wait(60);
  var_2c8bf5cd = math::clamp(level.doa.var_da96f13c + 1, 0, 3);
  level.doa.var_2c8bf5cd = [];
  while(var_2c8bf5cd > 0) {
    loc = doa_utility::function_ada6d90();
    level.doa.var_2c8bf5cd[level.doa.var_2c8bf5cd.size] = namespace_51bd792::margwaspawn(loc);
    var_2c8bf5cd--;
    wait(30);
  }
  while(level.doa.var_2c8bf5cd.size > 0) {
    level.doa.var_2c8bf5cd = array::remove_undefined(level.doa.var_2c8bf5cd);
    if(level.doa.var_2c8bf5cd.size == 0) {
      level flag::clear("doa_round_active");
      break;
    }
    wait(0.05);
  }
}