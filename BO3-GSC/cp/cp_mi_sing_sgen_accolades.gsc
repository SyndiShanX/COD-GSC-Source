/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_sgen_accolades.gsc
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
#namespace namespace_99202726;

function function_66df416f() {
  accolades::register("MISSION_SGEN_UNTOUCHED");
  accolades::register("MISSION_SGEN_SCORE");
  accolades::register("MISSION_SGEN_COLLECTIBLE");
  accolades::register("MISSION_SGEN_CHALLENGE3", "accolade_3_doubleshot_success");
  accolades::register("MISSION_SGEN_CHALLENGE4", "accolade_04_immolate_grant");
  accolades::register("MISSION_SGEN_CHALLENGE5", "accolade_05_melee_kill");
  accolades::register("MISSION_SGEN_CHALLENGE6", "accolade_06_confirmed_hit");
  accolades::register("MISSION_SGEN_CHALLENGE7", "accolade_07_stealth_kill");
  accolades::register("MISSION_SGEN_CHALLENGE8", "accolade_08_sniper_kill");
  accolades::register("MISSION_SGEN_CHALLENGE9", "accolade_09_long_shot_success");
  accolades::register("MISSION_SGEN_CHALLENGE10", "accolade_10_electro_bots_success");
  accolades::register("MISSION_SGEN_CHALLENGE11", "accolade_11_flood_exterminate_grant");
  accolades::register("MISSION_SGEN_CHALLENGE13", "accolade_13_stay_awhile_grant");
  accolades::register("MISSION_SGEN_CHALLENGE15", "accolade_15_depth_charge_damage_granted");
  accolades::register("MISSION_SGEN_CHALLENGE16", "accolade_16_kill_depth_charge_success");
  accolades::register("MISSION_SGEN_CHALLENGE17", "accolade_17_rocket_kill_success");
  level flag::wait_till("all_players_spawned");
  level thread function_b5ffeeac();
  level thread function_3fafea6d();
  level thread function_3bf99ff5();
  level thread function_3be7776b();
  level thread function_5335c37e();
  level thread function_a07abde9();
  callback::on_spawned( & function_d5c2bb53);
  level flag::wait_till("all_players_spawned");
  switch (level.current_skipto) {
    case "post_intro": {
      function_6a1ab5fc();
      function_b2309b8();
      function_6a2780bc();
      break;
    }
    case "enter_sgen": {
      function_6a1ab5fc();
      function_b2309b8();
      function_6a2780bc();
      break;
    }
    case "silo_swim": {
      function_f3915502();
    }
    default: {
      break;
    }
  }
}

function function_d5c2bb53() {
  self function_b67d38c4();
  self function_a07abde9();
}

function function_b5ffeeac() {
  callback::on_ai_killed( & function_6b1e8f3c);
  foreach(player in level.activeplayers) {
    player.var_f329477a = undefined;
  }
}

function function_b67d38c4() {
  self.var_f329477a = undefined;
}

function function_6b1e8f3c(params) {
  if(isplayer(params.eattacker)) {
    if(isDefined(params.weapon) && (params.smeansofdeath == "MOD_PISTOL_BULLET" || params.smeansofdeath == "MOD_RIFLE_BULLET")) {
      if(isDefined(params.eattacker.var_f329477a)) {
        if(params.eattacker.var_f329477a == params.eattacker._bbdata["shots"]) {
          params.eattacker notify("hash_450a5f27");
        }
      }
      params.eattacker.var_f329477a = params.eattacker._bbdata["shots"];
    }
  }
}

function function_3fafea6d() {
  foreach(player in level.activeplayers) {
    player.var_370e0a49 = 0;
  }
  callback::on_ai_killed( & function_ed6cec59);
}

function function_ed6cec59(s_params) {
  if(self.archetype === "robot" && s_params.weapon.name == "gadget_immolation") {
    if(!isDefined(s_params.eattacker.var_6749af1d)) {
      s_params.eattacker.var_6749af1d = [];
    }
    n_time_current = gettime();
    if(!isDefined(s_params.eattacker.var_6749af1d)) {
      s_params.eattacker.var_6749af1d = [];
    } else if(!isarray(s_params.eattacker.var_6749af1d)) {
      s_params.eattacker.var_6749af1d = array(s_params.eattacker.var_6749af1d);
    }
    s_params.eattacker.var_6749af1d[s_params.eattacker.var_6749af1d.size] = n_time_current;
    if(s_params.eattacker.var_6749af1d.size >= 4) {
      var_10db1e52 = s_params.eattacker.var_6749af1d.size - 4;
      var_97e374a8 = n_time_current - 1500;
      var_84abbef6 = 0;
      for(i = var_10db1e52; i < s_params.eattacker.var_6749af1d.size; i++) {
        if(s_params.eattacker.var_6749af1d[i] >= var_97e374a8) {
          var_84abbef6++;
        }
      }
      if(var_84abbef6 >= 4) {
        s_params.eattacker notify("hash_be3e251c");
      }
    }
  }
}

function function_3bf99ff5() {
  callback::on_ai_killed( & function_25a5bc35);
}

function function_25a5bc35(params) {
  if(self.archetype == "robot" && self.movemode == "run") {
    if(isplayer(params.eattacker)) {
      if(function_3dc86a1(params)) {
        params.eattacker notify("hash_55b52735");
      }
    }
  }
}

function function_3dc86a1(params) {
  if(params.weapon.type == "melee") {
    return true;
  }
  if(params.smeansofdeath == "MOD_MELEE_WEAPON_BUTT") {
    return true;
  }
  if(params.weapon.name == "hero_gravity_spikes_cyebercom") {
    return true;
  }
  if(params.weapon.name == "hero_gravity_spikes_cyebercom_upgraded") {
    return true;
  }
  return false;
}

function function_3be7776b() {
  foreach(player in level.activeplayers) {
    player function_c05b6c67();
  }
  callback::on_spawned( & function_c05b6c67);
  callback::on_ai_damage( & function_d77515b3);
}

function function_c05b6c67() {
  self.var_ad8b41e2 = 0;
  self.var_ad217527 = 0;
}

function function_d77515b3(params) {
  if(isplayer(params.eattacker)) {
    if(self.archetype == "robot") {
      if(params.shitloc == "head" || params.shitloc == "helmet" || params.shitloc == "neck") {
        if(!params.eattacker.var_ad8b41e2) {
          params.eattacker.var_ad217527 = params.eattacker._bbdata["shots"];
        } else {
          params.eattacker.var_ad217527++;
        }
        if(params.eattacker.var_ad217527 == params.eattacker._bbdata["shots"]) {
          params.eattacker.var_ad8b41e2++;
          if(params.eattacker.var_ad8b41e2 >= 5) {
            params.eattacker notify("hash_d90d93fc");
          }
        } else {
          params.eattacker.var_ad217527 = params.eattacker._bbdata["shots"];
          params.eattacker.var_ad8b41e2 = 1;
        }
      } else {
        params.eattacker.var_ad8b41e2 = 0;
      }
    }
  }
}

function function_6a1ab5fc() {
  callback::on_ai_killed( & function_94847029);
}

function function_94847029(params) {
  if(isplayer(params.eattacker)) {
    if(!level flag::get("exterior_gone_hot")) {
      params.eattacker notify("hash_8ff5db7c");
    }
  }
}

function function_45afef12() {
  callback::remove_on_ai_killed( & function_94847029);
}

function function_b2309b8() {
  callback::on_ai_killed( & function_52b96b46);
}

function function_52b96b46(params) {
  if(isplayer(params.eattacker)) {
    if(!level flag::get("exterior_gone_hot")) {
      if(self.scoretype == "_sniper") {
        params.eattacker notify("hash_4a89e4c7");
      }
    }
  }
}

function function_59fa6593() {
  callback::remove_on_ai_killed( & function_52b96b46);
}

function function_6a2780bc() {
  callback::on_ai_killed( & function_707a731a);
}

function function_707a731a(params) {
  if(isplayer(params.eattacker)) {
    var_701fc082 = params.eattacker.origin;
    var_b0bb8558 = self.origin;
    if(distance(var_701fc082, var_b0bb8558) > 2500) {
      params.eattacker notify("hash_f1d371eb");
    }
  }
}

function function_6d2fd9d2() {
  callback::remove_on_ai_killed( & function_707a731a);
}

function function_5335c37e() {
  callback::on_ai_killed( & function_e7cebc20);
}

function function_e7cebc20(params) {
  if(isplayer(params.eattacker)) {
    if(params.smeansofdeath == "MOD_ELECTROCUTED") {
      if(isDefined(params.eattacker.var_e6cc8b44)) {
        if(params.eattacker.var_e6cc8b44 == params.einflictor) {
          params.eattacker.var_60d52155++;
          if(params.eattacker.var_60d52155 == 2) {
            params.eattacker notify("hash_b6737fd1");
          }
        } else {
          function_5fc826b3(params);
        }
      } else {
        function_5fc826b3(params);
      }
    }
  }
}

function function_17b77884() {
  self.var_60d52155 = 0;
  self.var_e6cc8b44 = undefined;
}

function function_5fc826b3(params) {
  params.eattacker.var_e6cc8b44 = params.einflictor;
  params.eattacker.var_60d52155 = 0;
}

function function_bc2458f5() {
  if(!level flag::get("flood_runner_escaped")) {
    foreach(player in level.activeplayers) {
      player notify("hash_ff15c287");
    }
  }
}

function function_c75f9c25() {
  foreach(player in level.players) {
    player notify("hash_4b80918a");
  }
}

function function_f3915502() {
  foreach(player in level.activeplayers) {
    player function_79aac6ce();
  }
  callback::on_spawned( & function_79aac6ce);
}

function function_79aac6ce() {
  self.var_bae308b3 = 0;
  self thread function_962154a7();
}

function function_962154a7() {
  self endon("death");
  level endon("hash_1e73602d");
  while(true) {
    self waittill("damage", damage, attacker);
    if(isDefined(attacker.scoretype)) {
      if(attacker.scoretype == "_depth_charge") {
        self.var_bae308b3 = 1;
      }
    }
  }
}

function function_fde8c3ce() {
  foreach(player in level.activeplayers) {
    if(!player.var_bae308b3) {
      player notify("hash_cdcbe1e7");
    }
  }
}

function function_e85e2afd(e_attacker) {
  e_attacker notify("hash_5a5ed90f");
}

function function_a07abde9() {
  callback::on_ai_killed( & function_89c51083);
  foreach(player in level.activeplayers) {
    player.var_9dbb738f = undefined;
  }
}

function function_d669046f() {
  self.var_9dbb738f = undefined;
}

function function_89c51083(params) {
  if(isplayer(params.eattacker)) {
    if(!params.eattacker isonground()) {
      if(params.weapon.weapclass == "rocketlauncher") {
        if(isDefined(params.eattacker.var_9dbb738f)) {
          if(params.eattacker.var_9dbb738f == params.eattacker._bbdata["shots"]) {
            params.eattacker notify("hash_ed8b1690");
          }
        }
        params.eattacker.var_9dbb738f = params.eattacker._bbdata["shots"];
      }
    }
  }
}