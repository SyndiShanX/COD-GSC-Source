/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_blackstation_accolades.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_accolades;
#using scripts\shared\ai\systems\destructible_character;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace namespace_23567e72;

function function_4d39a2af() {
  accolades::register("MISSION_BLACKSTATION_CHALLENGE3", "micromissile_kill_challenge");
  accolades::register("MISSION_BLACKSTATION_CHALLENGE4", "technical_turret_challenge");
  accolades::register("MISSION_BLACKSTATION_CHALLENGE5", "warlord_pistol_challenge");
  accolades::register("MISSION_BLACKSTATION_CHALLENGE6", "speed_distance_challenge");
  accolades::register("MISSION_BLACKSTATION_CHALLENGE7", "rpg_kill_challenge");
  accolades::register("MISSION_BLACKSTATION_CHALLENGE8", "robot_human_challenge");
  accolades::register("MISSION_BLACKSTATION_CHALLENGE9", "powerstation_roof_challenge");
  accolades::register("MISSION_BLACKSTATION_CHALLENGE10", "headshot_breach_challenge");
  accolades::register("MISSION_BLACKSTATION_CHALLENGE11", "robot_powerup_challenge");
  accolades::register("MISSION_BLACKSTATION_CHALLENGE12", "warlord_turret_challenge");
  accolades::register("MISSION_BLACKSTATION_CHALLENGE13", "warlord_barrel_challenge");
  accolades::register("MISSION_BLACKSTATION_CHALLENGE14", "riotshield_melee_challenge");
  accolades::register("MISSION_BLACKSTATION_CHALLENGE15", "riotshield_headshot_challenge");
  callback::on_spawned(&function_3a6b5b3e);
  function_c6595cb5();
  function_86716d12();
  function_80f71baf();
  function_ed62e62f();
  function_be537152();
  function_fe5a0b6();
  level thread function_69b1ee49();
  level thread function_91fa5513();
  level thread function_29c337dd();
  level thread function_7d2dae0a();
  level.var_76663db9 = 1;
  level.var_8454c072 = 1;
  level.var_63855bec = 1;
}

function function_3a6b5b3e() {
  self function_806ef44e();
  self function_ba5f78c4();
  self function_ca5e3a6();
  self function_81a32f61();
  self function_91f0e7d2();
  self function_78f93084();
  self function_c169f275();
}

function function_806ef44e() {
  self.var_8477b47b = 0;
  self.var_3a4bbe6b = undefined;
}

function function_c6595cb5() {
  callback::on_ai_killed(&function_e83f24);
}

function function_f673d34(params) {
  params.eattacker.var_3a4bbe6b = params.einflictor.birthtime;
  params.eattacker.var_8477b47b = 0;
}

function function_feac00a() {
  self notify("hash_dff0891a");
  self endon("hash_dff0891a");
  self endon("death");
  wait(3);
  self.var_8477b47b = 0;
  self.var_3a4bbe6b = undefined;
}

function function_e83f24(params) {
  if(isplayer(params.eattacker) && params.weapon == getweapon("micromissile_launcher")) {
    params.eattacker thread function_feac00a();
    if(!isDefined(params.eattacker.var_3a4bbe6b)) {
      function_f673d34(params);
    }
    if((abs(params.eattacker.var_3a4bbe6b - params.einflictor.birthtime)) <= 400) {
      params.eattacker.var_8477b47b++;
      if(params.eattacker.var_8477b47b == 5) {
        params.eattacker notify("hash_38460066");
      }
    }
  }
}

function function_86716d12() {
  callback::on_ai_killed(&function_2f913423);
}

function function_2f913423(params) {
  if(isplayer(params.eattacker) && params.weapon.name == "turret_bo3_civ_truck_pickup_tech_54i") {
    params.eattacker notify("hash_4a4fc79");
  }
}

function function_80f71baf() {
  spawner::add_archetype_spawn_function("warlord", &function_41954f8f);
}

function function_41954f8f() {
  self endon("death");
  level flag::wait_till("warlord_fight");
  wait(1);
  self.overrideactordamage = &function_587c487b;
  self thread warlord_death_watcher();
}

function function_587c487b(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, vsurfacenormal) {
  if(isplayer(eattacker) && weapon.weapclass != "pistol") {
    level.var_76663db9 = 0;
  }
  return idamage;
}

function warlord_death_watcher() {
  self waittill("death", eattacker, damagefromunderneath, weapon, point, dir);
  if(level.var_76663db9 && isplayer(eattacker)) {
    foreach(player in level.activeplayers) {
      player notify("hash_c5775d94");
    }
  } else if(isplayer(eattacker) && weapon.name == "turret_bo3_civ_truck_pickup_tech_54i") {
    eattacker notify("hash_3f3be7cb");
  }
}

function function_ba5f78c4() {
  self.var_d7f34b97 = 0;
  self.s_timer = util::new_timer(3);
}

function function_ed62e62f() {
  callback::on_ai_killed(&function_9cb470ce);
}

function function_9cb470ce(params) {
  if(isplayer(params.eattacker) && distancesquared(params.eattacker.origin, self.origin) >= 3240000) {
    if(params.eattacker.var_d7f34b97 == 0) {
      params.eattacker.s_timer = util::new_timer(3);
      params.eattacker.var_d7f34b97++;
    } else {
      params.eattacker.var_d7f34b97++;
      if(params.eattacker.var_d7f34b97 >= 3 && params.eattacker.s_timer util::get_time_left() > 0) {
        params.eattacker notify("hash_2a10a12a");
      } else if(params.eattacker.s_timer util::get_time_left() <= 0) {
        params.eattacker.var_d7f34b97 = 0;
      }
    }
  }
}

function function_ca5e3a6() {
  self.var_65338a8f = 0;
  self.s_timer = util::new_timer(1);
}

function function_be537152() {
  callback::on_ai_killed(&function_55a74563);
}

function function_55a74563(params) {
  if(isplayer(params.eattacker) && issubstr(self.classname, "rpg")) {
    if(params.eattacker.var_65338a8f == 0) {
      params.eattacker.s_timer = util::new_timer(1);
      params.eattacker.var_65338a8f++;
    } else {
      params.eattacker.var_65338a8f++;
      if(params.eattacker.var_65338a8f >= 2 && params.eattacker.s_timer util::get_time_left() > 0) {
        params.eattacker notify("hash_f70d22e7");
      } else if(params.eattacker.s_timer util::get_time_left() <= 0) {
        params.eattacker.var_65338a8f = 1;
        params.eattacker.s_timer = util::new_timer(1);
      }
    }
  }
}

function function_81a32f61() {
  self.var_27d2276e = 0;
  self.var_6fd54591 = 0;
  self thread function_35dfc997();
}

function function_35dfc997() {
  self endon("death");
  while(true) {
    self waittill("reload");
    self.var_27d2276e = 0;
    self.var_6fd54591 = 0;
  }
}

function function_fe5a0b6() {
  callback::on_ai_killed(&function_635e0947);
}

function function_635e0947(params) {
  if(isplayer(params.eattacker)) {
    if(self.archetype == "human") {
      params.eattacker.var_6fd54591++;
    } else if(self.archetype == "robot") {
      params.eattacker.var_27d2276e++;
    }
    if(params.eattacker.var_6fd54591 > 0 && params.eattacker.var_27d2276e > 0) {
      params.eattacker notify("hash_b92df4b");
    }
  }
}

function function_af8faf92() {
  self endon("death");
  trigger::wait_till("trigger_roof_escape", "targetname", self);
  level.var_8454c072 = 0;
}

function function_69b1ee49() {
  spawner::waittill_ai_group_cleared("group_roof_workers");
  if(level.var_8454c072) {
    foreach(player in level.activeplayers) {
      player notify("hash_74cdbe17");
    }
  }
}

function function_91f0e7d2() {
  self.var_a7590ae5 = 0;
}

function function_91fa5513() {
  level waittill("wheelhouse_breached");
  callback::on_ai_killed(&function_92bc12da);
  level flag::wait_till("barge_breach_cleared");
  callback::remove_on_ai_killed(&function_92bc12da);
}

function function_92bc12da(params) {
  if(isplayer(params.eattacker)) {
    if(params.shitloc == "head" || params.shitloc == "helmet" || params.shitloc == "neck") {
      params.eattacker.var_a7590ae5++;
      if(params.eattacker.var_a7590ae5 >= 3) {
        params.eattacker notify("hash_9fa2e64b");
      }
    }
  }
}

function function_78f93084() {
  self.var_10276781 = 0;
}

function function_29c337dd() {
  level flag::wait_till("comm_relay_engaged");
  callback::on_ai_killed(&function_8c9ce56);
  level flag::wait_till("relay_room_clear");
  callback::remove_on_ai_killed(&function_8c9ce56);
}

function function_8c9ce56(params) {
  if(isplayer(params.eattacker)) {
    if(issubstr(self.targetname, "comm_relay_awaken_robot") && !isDefined(self.b_activated)) {
      params.eattacker.var_10276781++;
      if(params.eattacker.var_10276781 >= 4) {
        params.eattacker notify("hash_4e109d00");
      }
    }
  }
}

function function_f0b50148() {
  level flag::wait_till("warlord_fight");
  callback::on_ai_killed(&function_b82c8e7b);
  level flag::wait_till("drone_strike");
  callback::remove_on_ai_killed(&function_b82c8e7b);
}

function function_26aa602b() {
  level flag::wait_till("flag_enter_police_station");
  callback::on_ai_killed(&function_b82c8e7b);
  level flag::wait_till("flag_kane_intro_complete");
  callback::remove_on_ai_killed(&function_b82c8e7b);
}

function function_328b2c47() {
  level flag::wait_till("blackstation_exterior_engaged");
  callback::on_ai_killed(&function_b82c8e7b);
  level flag::wait_till("warlord_dead");
  callback::remove_on_ai_killed(&function_b82c8e7b);
}

function function_b82c8e7b(params) {
  if(isplayer(params.eattacker) && self.archetype == "warlord") {
    if(params.einflictor.targetname === "destructible") {
      params.eattacker notify("hash_729650f9");
    }
  }
}

function function_92e8d6d8(a_ai) {
  foreach(ai in a_ai) {
    ai.overrideactordamage = &function_aa2360ca;
  }
  foreach(var_3f7c5c5d in a_ai) {
    var_3f7c5c5d thread riotshield_death();
  }
  level thread function_ccfcd136(a_ai);
}

function function_aa2360ca(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, vsurfacenormal) {
  if(!isDefined(weapon)) {
    return idamage;
  }
  str_weapon_name = weapon.rootweapon.name;
  if(isplayer(eattacker)) {
    if(smeansofdeath !== "MOD_MELEE" && smeansofdeath !== "MOD_MELEE_ASSASSINATE" && smeansofdeath !== "MOD_MELEE_WEAPON_BUTT" && str_weapon_name != "flash_grenade" && str_weapon_name != "gadget_es_strike" && str_weapon_name != "gadget_es_strike_upgraded" && str_weapon_name != "gadget_sensory_overload") {
      level.var_63855bec = 0;
    }
  }
  return idamage;
}

function function_ccfcd136(a_ai) {
  array::wait_till(a_ai, "death");
  wait(1);
  if(level.var_63855bec) {
    foreach(player in level.activeplayers) {
      player notify("hash_22e4c723");
    }
  }
}

function riotshield_death() {
  self waittill("death", eattacker, damagefromunderneath, weapon, point, dir);
  if(!isplayer(eattacker)) {
    level.var_63855bec = 0;
  }
}

function function_c169f275() {
  self.var_a7590ae5 = 0;
}

function function_7d2dae0a() {
  level flag::wait_till("flag_enter_police_station");
  callback::on_ai_killed(&function_cdf3285b);
  level flag::wait_till("flag_kane_intro_complete");
  callback::remove_on_ai_killed(&function_cdf3285b);
}

function function_cdf3285b(params) {
  if(isplayer(params.eattacker) && self.archetype == "human_riotshield") {
    if(params.shitloc == "head" || params.shitloc == "helmet" || params.shitloc == "neck") {
      params.eattacker.var_a7590ae5++;
      params.eattacker notify("hash_d34814eb");
    }
  }
}