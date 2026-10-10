/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_18b61963cd1351ff.gsc
*************************************************/

#using script_18b61963cd1351ff;
#using script_214930d31a3a8321;
#using script_669f1da0d61f1ffa;
#using script_711820027508efbb;
#using script_edb8e725d068ac9;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\overlord;
#using scripts\engine\utility;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\mp_agent;
#namespace namespace_d3a01dcb29d44376;

function function_8e2171f77cd463b() {
  level.var_76ab5294a83d90c2 = getStruct("fletcher_spawn", "targetname");

  if(isDefined(level.var_76ab5294a83d90c2)) {
    level.var_376e6e8117393127 = scripts\mp\mp_agent::spawnnewagentaitype("jup_ob_ally_fletcher_base", level.var_76ab5294a83d90c2.origin, level.var_76ab5294a83d90c2.angles, level.allyteam);

    if(isDefined(level.var_376e6e8117393127)) {
      level.var_376e6e8117393127 scripts\common\ai::magic_bullet_shield();
      level.var_376e6e8117393127.var_9f009877c3bea958 = 1;
      level.var_376e6e8117393127.ignoreme = 1;
      level.var_376e6e8117393127.var_69b049cf4b18c73b = 1;
      level.var_376e6e8117393127.battlechatter.stateoverride = "combat";

      if(!threatbiasgroupexists("ally_ai")) {
        createthreatbiasgroup("ally_ai");
      }

      level.var_376e6e8117393127 setthreatbiasgroup("ally_ai");
      level.var_376e6e8117393127 function_65cdab0fc78aba8f(level.var_376e6e8117393127.origin, 3000);

      if(isDefined(level.a_ai_allies)) {
        level.a_ai_allies[level.a_ai_allies.size] = level.var_376e6e8117393127;
      }

      level.var_376e6e8117393127 setgoalpos(level.var_76ab5294a83d90c2.origin);
      level.var_376e6e8117393127.goalradius = 10;
      function_b8e5141bbcda90e();
      function_606642b946a01237("ambient_blocker_fletcher", level.var_76ab5294a83d90c2.origin, 400, 1);
      level.var_376e6e8117393127 thread function_e9bbf51c045b4d47();
    }
  }
}

function function_b8e5141bbcda90e() {
  if(isDefined(level.var_376e6e8117393127)) {
    var_d31429e0a68259a4 = scripts\mp\mp_agent::spawnnewagentaitype("jup_ob_enemy_basic_specialforce_chemist_bodyguard", level.var_76ab5294a83d90c2.origin + (10, 0, 0), level.var_76ab5294a83d90c2.angles, level.allyteam);
    var_d31429e0a68259a4 scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff("body_c_jup_sp_enemy_pmc_spforce_05", "head_c_jup_sp_enemy_pmc_spforce_04");
    var_d31429e0a68259a4 scripts\common\ai::magic_bullet_shield();
    var_d31429e0a68259a4.ignoreme = 1;
    var_d31429e0a68259a4.var_69b049cf4b18c73b = 0;
    var_d31429e0a68259a4.iscompanion = 1;
    level.var_376e6e8117393127 attach("hat_child_hadir_gas_mask_wm_br", "j_head");
    level.var_376e6e8117393127.battlechatter.stateoverride = "combat";

    if(!threatbiasgroupexists("ally_ai")) {
      createthreatbiasgroup("ally_ai");
    }

    level.var_376e6e8117393127 setthreatbiasgroup("ally_ai");
    level.var_376e6e8117393127 function_65cdab0fc78aba8f(var_d31429e0a68259a4.origin, 3000);

    if(isDefined(level.a_ai_allies)) {
      level.a_ai_allies[level.a_ai_allies.size] = level.var_376e6e8117393127;
    }

    var_d31429e0a68259a4 setgoalentity(level.var_376e6e8117393127);
    var_d31429e0a68259a4.goalradius = 50;
    level.var_d31429e0a68259a4 = var_d31429e0a68259a4;
  }

  waitframe();

  if(isDefined(level.var_376e6e8117393127)) {
    spawnpos = (-25876, -21545, 571);
    var_1b8210e0db900e1a = scripts\mp\mp_agent::spawnnewagentaitype("jup_ob_enemy_basic_specialforce_chemist_bodyguard", level.var_76ab5294a83d90c2.origin + (-10, 0, 0), (1, 259, 0), level.allyteam);
    var_1b8210e0db900e1a scripts\common\ai::magic_bullet_shield();
    var_1b8210e0db900e1a.ignoreme = 1;
    var_1b8210e0db900e1a.var_69b049cf4b18c73b = 0;
    var_1b8210e0db900e1a.iscompanion = 1;
    var_1b8210e0db900e1a.battlechatter.stateoverride = "combat";
    var_1b8210e0db900e1a attach("hat_child_hadir_gas_mask_wm_br", "j_head");

    if(!threatbiasgroupexists("ally_ai")) {
      createthreatbiasgroup("ally_ai");
    }

    var_1b8210e0db900e1a setthreatbiasgroup("ally_ai");
    var_1b8210e0db900e1a function_65cdab0fc78aba8f(var_d31429e0a68259a4.origin, 3000);

    if(isDefined(level.a_ai_allies)) {
      level.a_ai_allies[level.a_ai_allies.size] = level.var_376e6e8117393127;
    }

    var_1b8210e0db900e1a setgoalpos(spawnpos, 10);
    level.var_1b8210e0db900e1a = var_1b8210e0db900e1a;
  }

  waitframe();

  if(isDefined(level.var_376e6e8117393127)) {
    spawnpos = (-25740, -21901, 571);
    var_2692e299e63da688 = scripts\mp\mp_agent::spawnnewagentaitype("jup_ob_enemy_basic_specialforce_chemist_bodyguard", level.var_76ab5294a83d90c2.origin + (-10, 0, 0), (2, 306, 0), level.allyteam);
    var_2692e299e63da688 scripts\common\ai::magic_bullet_shield();
    var_2692e299e63da688.ignoreme = 1;
    var_2692e299e63da688.var_69b049cf4b18c73b = 0;
    var_2692e299e63da688.iscompanion = 1;
    var_2692e299e63da688.battlechatter.stateoverride = "combat";
    var_2692e299e63da688 attach("hat_child_hadir_gas_mask_wm_br", "j_head");

    if(!threatbiasgroupexists("ally_ai")) {
      createthreatbiasgroup("ally_ai");
    }

    var_2692e299e63da688 setthreatbiasgroup("ally_ai");
    var_2692e299e63da688 function_65cdab0fc78aba8f(var_d31429e0a68259a4.origin, 3000);

    if(isDefined(level.a_ai_allies)) {
      level.a_ai_allies[level.a_ai_allies.size] = level.var_376e6e8117393127;
    }

    var_2692e299e63da688 setgoalpos(spawnpos, 10);
    level.var_2692e299e63da688 = var_2692e299e63da688;
  }

  level.var_1799b15c773d3141 = [var_1b8210e0db900e1a, var_2692e299e63da688];
}

function function_9f0dd15f85ea6a7c() {
  fletcher_mall_path = getStructArray("fletcher_mall_path", "script_noteworthy");
  fletcher_mall_path = scripts\engine\utility::array_sort_by_script_index(fletcher_mall_path);
  level.var_d31429e0a68259a4.goalradius = 25;
  level.var_d31429e0a68259a4.goalheight = 32;
  level.var_1b8210e0db900e1a.goalradius = 25;
  level.var_1b8210e0db900e1a.goalheight = 32;
  level.var_2692e299e63da688.goalradius = 25;
  level.var_2692e299e63da688.goalheight = 32;
  level.var_376e6e8117393127.goalradius = 25;
  level.var_376e6e8117393127.goalheight = 32;
  self setgoalpath(fletcher_mall_path);
  level.var_d31429e0a68259a4 setgoalpath(fletcher_mall_path);
  level.var_1b8210e0db900e1a setgoalpath(fletcher_mall_path);
  level.var_2692e299e63da688 setgoalpath(fletcher_mall_path);
  thread function_97466e70b4e1748("fletcher_mall_path", getdvarint(@ "hash_848a65a672b63ff", 120));
  self waittill("goal");
  self notify("discard_timeout");
  thread function_973c94b4840e3cdb();
  level.var_d31429e0a68259a4 thread function_973c94b4840e3cdb();
  level.var_1b8210e0db900e1a thread function_973c94b4840e3cdb();
  level.var_2692e299e63da688 thread function_973c94b4840e3cdb();
  self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
  level.var_1b8210e0db900e1a detach("hat_child_hadir_gas_mask_wm_br", "j_head");
  level.var_2692e299e63da688 detach("hat_child_hadir_gas_mask_wm_br", "j_head");
  flag_set("fletcher_mall_at_acv");
  level.var_c921cb81dd47af55 namespace_87ebdf00d835c96b::function_e0d25e0c4548bc8b();
}

function function_97466e70b4e1748(var_efe09092d38dec28, timeout) {
  self endon("death");
  level endon("game_ended");
  level endon("disconnect");
  self endon("discard_timeout");
  wait timeout;
  fletcher_mall_path = getStructArray(var_efe09092d38dec28, "script_noteworthy");
  fletcher_mall_path = scripts\engine\utility::array_sort_by_script_index(fletcher_mall_path);
  self forceteleport(fletcher_mall_path[fletcher_mall_path.size - 1].origin, fletcher_mall_path[fletcher_mall_path.size - 1].angles, 9999999, 0);
  waitframe();
  level.var_d31429e0a68259a4 forceteleport(self.origin, self.angles, 9999999, 0);
  level.var_1b8210e0db900e1a forceteleport(self.origin, self.angles, 9999999, 0);
  level.var_2692e299e63da688 forceteleport(self.origin, self.angles, 9999999, 0);
  self notify("goal");
  level.var_d31429e0a68259a4 notify("goal");
  level.var_1b8210e0db900e1a notify("goal");
  level.var_2692e299e63da688 notify("goal");
}

function function_a2b2e57638845542(goalnode) {
  level.var_376e6e8117393127 setgoalpos(goalnode.origin);
  level.var_376e6e8117393127.goalradius = 1;
  level.var_376e6e8117393127 thread function_c13cd463c6a5b436(goalnode);
}

function function_c13cd463c6a5b436(goalnode) {
  self notify("fletcher_stuck_watcher");
  self endon("fletcher_stuck_watcher");
  self endon("goal");
  self endon("game_ended");
  previousorigin = self.origin;
  var_4992b188fce1634b = 0;

  while(true) {
    distsq = distancesquared(previousorigin, self.origin);

    if(distsq < 900) {
      var_4992b188fce1634b++;

      if(var_4992b188fce1634b >= 4) {
        function_a2b2e57638845542(goalnode);
      }
    } else {
      var_4992b188fce1634b = 0;
    }

    wait 0.5;
  }
}

function function_f246b3550eda8b6f() {
  aliveplayers = [];
  var_5e7be3a99a2fb3e8 = 0;

  foreach(player in level.players) {
    if(isalive(player) && isPlayer(player)) {
      aliveplayers[var_5e7be3a99a2fb3e8] = player;
    }

    var_5e7be3a99a2fb3e8++;
  }

  var_8850d9f771525016 = random(aliveplayers);
  self.var_140a5fde675674fe = var_8850d9f771525016;
  self setgoalentity(var_8850d9f771525016);
  self.goalradius = 100;
  self.var_cbd2c45e12e0c27a = var_8850d9f771525016;
  thread function_1744bfae3e614a0e(var_8850d9f771525016);
}

function function_cc2a173f1d10e82e() {
  self.var_140a5fde675674fe = undefined;

  if(isDefined(level.var_59a5ab1b4256bb79)) {
    level.var_376e6e8117393127 setgoalentity(level.var_59a5ab1b4256bb79);
    level.var_376e6e8117393127.goalradius = 10;
    self.var_cbd2c45e12e0c27a = level.var_59a5ab1b4256bb79;
  }

  self notify("following_acv");
}

function function_973c94b4840e3cdb() {
  self notify("lead_acv");
  self endon("lead_acv");
  self endon("new_goal_given");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    newgoalpos = level.var_59a5ab1b4256bb79.origin + anglesToForward(level.var_59a5ab1b4256bb79.angles) * 700;
    self setgoalpos(newgoalpos);
    self.goalradius = 100;
    wait 0.1;
  }
}

function function_1744bfae3e614a0e(var_8850d9f771525016) {
  self endon("following_acv");
  var_8850d9f771525016 waittill("death");
  function_f246b3550eda8b6f();
}

function function_bd3cad6d2bf080a0() {
  level.var_376e6e8117393127.ignoreme = 1;
  level.var_376e6e8117393127 set("catchup_ignoreall", "ignoreall", 1);
  level.var_376e6e8117393127 setgoalpath(level.var_3bd5693ef6922254);
  level.var_376e6e8117393127 thread function_951ba093cad53377();
  level.var_376e6e8117393127 waittill_any_2("goal", "fletcher_force_teleported");

  if(getdvarint(@ "hash_6bb56af5969c9dc9", 1) || getdvarint(@ "hash_35faba7502dbe9b0", 0)) {
    level.var_376e6e8117393127 thread throw_grenade();
    level thread function_c65a4e91afcf5b6b();
  } else {
    level thread function_c65a4e91afcf5b6b();
  }

  level waittill("aether_grenade_thrown");
  wait 2;
  playFXOnTag(getfx("rift_teleport"), level.var_376e6e8117393127, "tag_origin");
  wait 0.75;
  level.var_376e6e8117393127 forceteleport((-999999, -999999, -999999), (0, 0, 0), 9999999, 0);
  level.riftgate setscriptablepartstate("aether_exit_body", "off");

  if(!getdvarint(@ "hash_35faba7502dbe9b0", 0) && !getdvarint(@ "hash_6bb56af5969c9dc9", 1)) {
    namespace_68270f885c7fd3ef::function_20c25d1093aa4277();
  }

  wait 1;
  level.var_376e6e8117393127 scripts\common\ai::stop_magic_bullet_shield();
  level.var_376e6e8117393127 kill();
}

function function_951ba093cad53377() {
  level endon("game_ended");
  level endon("disconnect");
  self endon("goal");
  wait 15;
  level.var_376e6e8117393127.origin = level.var_3bd5693ef6922254[level.var_3bd5693ef6922254.size - 1].origin;
  level.var_376e6e8117393127 setgoalpos(level.var_3bd5693ef6922254[level.var_3bd5693ef6922254.size - 1].origin);
  level.var_376e6e8117393127 notify("fletcher_force_teleported");
}

function function_c65a4e91afcf5b6b() {
  level endon("game_ended");
  level endon("disconnect");
  scripts\cp_mp\overlord::playconversation("s2_outlast_complete", level.players);
}

function throw_grenade() {
  level endon("game_ended");
  level endon("disconnect");
  wait 5;
  level.var_376e6e8117393127 set("catchup_ignoreall", "ignoreall", 0);
  level.var_376e6e8117393127.grenadeweapon = makeweapon("s2_aether_grenade_vial_ob");
  level.var_376e6e8117393127.grenadeammo = 100;
  gas_spawn = getStruct("aether_gas_spawn", "script_noteworthy");
  gasfx = spawnscriptable("s2_ob_jup_scriptable_chemist_aether_gas", gas_spawn.origin + (50, 0, 0), gas_spawn.angles);
  level.gasfx = gasfx;

  if(getdvarint(@ "hash_35faba7502dbe9b0", 0)) {
    level thread function_24a7b362c9c4595a();

    if(isDefined(level.var_a2bcb45a0ad08c1d)) {
      level.var_a2bcb45a0ad08c1d namespace_75b9b66caa533c31::function_4c7fb6ad4120d921();
      namespace_68270f885c7fd3ef::function_cc39c0ba7d4e88c1();
      function_5dee2cde694b7cda();
    }

    return;
  }

  level.var_d31429e0a68259a4 function_d717c2b8b04c7018();
  level.var_1b8210e0db900e1a function_d717c2b8b04c7018();
  level.var_2692e299e63da688 function_d717c2b8b04c7018();
  level.var_376e6e8117393127 scripts\cp_mp\agents\agent_utils::function_ae99616202575e39(level.gasfx.origin, "s2_aether_grenade_vial_ob");
  level notify("aether_grenade_thrown");
  wait 1.5;
  level.gasfx setscriptablepartstate("formation_vfx", "active");
  grenade = magicgrenademanual("jup_gas_grenade_ob_aether", gas_spawn.origin, (0, 0, 0), 0);
  grenade.owner = level.var_376e6e8117393127;
  grenade.owner thread scripts\mp\equipment\gas_grenade::gas_used(grenade);
  wait 0.5;
  thread namespace_e82bfd865c02eb4b::function_29fa208e114ef7be();
  animindex = scripts\asm\asm::asm_lookupanimfromalias("animscripted", "humangun_turn_into");
  xanim = scripts\asm\asm::asm_getxanim("animscripted", animindex);

  if(isDefined(xanim)) {
    animlength = getanimlength(xanim);
    wait animlength;
  }

  namespace_68270f885c7fd3ef::function_d3ae53a6be4cc8fc();
}

function function_29fa208e114ef7be() {
  level endon("game_ended");
  level endon("disconnect");
  level.var_d31429e0a68259a4 thread function_a6dc3a7d16338e02();
  wait 0.1;
  level.var_1b8210e0db900e1a thread function_a6dc3a7d16338e02();
  waitframe();
  level.var_2692e299e63da688 thread function_a6dc3a7d16338e02();
}

function function_d717c2b8b04c7018() {
  scripts\engine\utility::disable_pain();
  self.ignoreall = 1;
  self.aggressivemode = 0;
  self.ignoresuppression = 1;
  self.ignoreme = 1;
  val::set("humangun_transforming", "ignoreall", 1);
  val::set("humangun_transforming", "disallow_stun", 1);
  val::set("humangun_transforming", "disallow_knockdown", 1);
}

function function_a6dc3a7d16338e02() {
  namespace_bbdaab8ec2235136::function_3c0a0f8cc46643f1("humangun_turn_into");
}

function function_5dee2cde694b7cda() {
  var_f0125a769d3cfb1e = 2;

  while(level.var_a2bcb45a0ad08c1d.agents.size < var_f0125a769d3cfb1e + 1) {
    waitframe();
  }

  waitframe();

  for(i = 0; i < level.var_a2bcb45a0ad08c1d.agents.size; i++) {
    var_731369fe1319fa6f = level.var_a2bcb45a0ad08c1d.agents[i];

    if(issubstr(var_731369fe1319fa6f.agent_type, "bodyguard")) {
      var_731369fe1319fa6f forceteleport(level.var_3b03dfb6ebc3d34b[i - 1], level.var_79e1ab54bcfa7fc5[i - 1], 9999999, 0);
      var_731369fe1319fa6f.maxhealth = 6000;
      var_731369fe1319fa6f.health = 6000;
      var_731369fe1319fa6f.agenthealth = 6000;
      var_731369fe1319fa6f.helmethealth = 50;
      var_731369fe1319fa6f.var_cfc69e5588a5bed6 = 50;
    }
  }

  waitframe();

  for(i = 0; i < level.var_a2bcb45a0ad08c1d.agents.size; i++) {
    var_731369fe1319fa6f = level.var_a2bcb45a0ad08c1d.agents[i];

    if(issubstr(var_731369fe1319fa6f.agent_type, "bodyguard")) {
      playFXOnTag(getfx("chemist_head"), var_731369fe1319fa6f, "j_head");
    }
  }
}

function function_24a7b362c9c4595a() {
  level endon("disconnect");
  level.var_a2bcb45a0ad08c1d waittill("warlord_spawned");
  level.var_376e6e8117393127 thread scripts\cp_mp\agents\agent_utils::function_ae99616202575e39(level.gasfx.origin, "gas_grenade_exgm_chemist_rift_offensive");
  level.gasfx setscriptablepartstate("formation_vfx", "active");
  level.var_325b7d271026b22d = level.var_d31429e0a68259a4.origin;
  level.var_fa910ab739efb783 = level.var_d31429e0a68259a4.angles;

  for(i = 0; i < level.var_1799b15c773d3141.size; i++) {
    level.var_3b03dfb6ebc3d34b[i] = level.var_1799b15c773d3141[i].origin;
    level.var_79e1ab54bcfa7fc5[i] = level.var_1799b15c773d3141[i].angles;
  }

  level notify("swap_chemist");
  waitframe();
  level.var_d31429e0a68259a4 forceteleport((-999999, -999999, -999999), (0, 0, 0), 9999999, 0);
  level.var_1b8210e0db900e1a forceteleport((-999999, -999999, -999999), (0, 0, 0), 9999999, 0);
  level.var_2692e299e63da688 forceteleport((-999999, -999999, -999999), (0, 0, 0), 9999999, 0);
  wait 1;
  level.var_d31429e0a68259a4 scripts\common\ai::stop_magic_bullet_shield();
  level.var_d31429e0a68259a4 kill();
  level.var_1b8210e0db900e1a scripts\common\ai::stop_magic_bullet_shield();
  level.var_1b8210e0db900e1a kill();
  level.var_2692e299e63da688 scripts\common\ai::stop_magic_bullet_shield();
  level.var_2692e299e63da688 kill();
}

function goto_stage() {
  gas_spawn = getStruct("aether_gas_spawn", "script_noteworthy");
  level.var_3bd5693ef6922254 = getStructArray("fletcher_betrayal_goal", "script_noteworthy");
  level.var_376e6e8117393127 setgoalpos(level.var_3bd5693ef6922254[0].origin, 15);
  level.var_376e6e8117393127 notify("new_goal_given");
  level.var_d31429e0a68259a4 setgoalpos(gas_spawn.origin, 10);
  level.var_d31429e0a68259a4 notify("new_goal_given");
  level.var_1b8210e0db900e1a setgoalpos(gas_spawn.origin + (50, 0, 0), 10);
  level.var_1b8210e0db900e1a notify("new_goal_given");
  level.var_2692e299e63da688 setgoalpos(gas_spawn.origin + (-50, 0, 0), 10);
  level.var_2692e299e63da688 notify("new_goal_given");
}

function betrayal() {
  level waittill("start_betrayal");
  function_bd3cad6d2bf080a0();
}

function function_e9bbf51c045b4d47() {
  self notify("stay_near_target");
  self endon("stay_near_target");
  self endon("game_ended");
  self.var_7a09280a7f23f0c5 = 0;
  set("catchup_ignoreall", "ignoreall", 0);

  while(true) {
    if(isDefined(self.var_cbd2c45e12e0c27a)) {
      distsq = distancesquared(self.var_cbd2c45e12e0c27a.origin, self.origin);

      if(distsq > 1000000 && !istrue(self.var_7a09280a7f23f0c5)) {
        set("catchup_ignoreall", "ignoreall", 1);
        self.var_7a09280a7f23f0c5 = 1;
      } else if(istrue(self.var_7a09280a7f23f0c5) && distsq <= 90000) {
        set("catchup_ignoreall", "ignoreall", 0);
        self.var_7a09280a7f23f0c5 = 0;
      }
    } else if(istrue(self.var_7a09280a7f23f0c5)) {
      set("catchup_ignoreall", "ignoreall", 0);
      self.var_7a09280a7f23f0c5 = 0;
    }

    wait 0.3;
  }
}