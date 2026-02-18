/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\battlechatter.gsc
*************************************************/

#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter_table;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#namespace battlechatter;

function private autoexec __init__system__() {
  system::register(#"battlechatter_cp", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
  var_1d952608 = getactorspawnerarray();
  callback::on_ai_spawned(&function_b791d0e4);

  function_5ac4dc99("<dev string:x38>", 0);

  battlechatter_table::function_c5dda35e("combat", [# "hash_2a1fada6b78bcec4"]);
}

function init() {
  callback::on_spawned(&on_player_spawned);
  level.battlechatter_init = 1;
  level.allowbattlechatter = [];
  level.allowbattlechatter[# "bc"] = 1;
  level.allowbattlechatter[# "allies"] = 1;
  level.allowbattlechatter[# "axis"] = 1;
  level.allowbattlechatter[# "team3"] = 1;
  level.var_69427377 = [];
  level.var_69427377[# "cover_exit"] = "cover_break";
  level.var_69427377[# "moving_up"] = "moving_up_other";
}

function is_hero(ai) {
  if(!isstring(ai.voiceprefix)) {
    return false;
  }

  if(ai.voiceprefix.size >= 8) {
    return true;
  }

  return false;
}

function function_51759b03(var_84d1299, eventstruct = undefined) {
  if(is_true(level.var_cc83507)) {
    return false;
  }

  if(!isactor(self)) {
    if(isPlayer(self)) {
      if(!is_true(var_84d1299)) {
        return false;
      }
    } else {
      return false;
    }
  }

  if(isDefined(self.archetype) && self.archetype == "zombie") {
    return false;
  }

  if(isDefined(self.archetype) && self.archetype == "direwolf") {
    return false;
  }

  if(isDefined(self.team) && !is_true(level.allowbattlechatter[self.team])) {
    return false;
  }

  if(isDefined(level.var_8b7cb19c) && isDefined(eventstruct)) {
    result = self[[level.var_8b7cb19c]](eventstruct);

    if(!is_true(result)) {
      return false;
    }
  }

  return true;
}

function private function_2346ea47(event) {
  if(event == # "flanked") {
    if(self haspath() || absangleclamp180(self aiutility::function_dc8e1a0a()) < 45) {
      return false;
    }
  }

  return true;
}

function function_4a19b47a() {
  assert(isDefined(self.voiceprefix));

  if(is_hero(self)) {
    self.var_3d0026c9 = "";
    return;
  }

  switch (self.voiceprefix) {
    case # "hash_6600f5c535189183":
      self.var_3d0026c9 = randomintrange(1, 3);
      break;
    case # "hash_6d6e10c538f37ef3":
      self.var_3d0026c9 = randomintrange(1, 5);
      break;
    default:
      self.var_3d0026c9 = randomintrange(1, 4);
      break;
  }
}

function function_b791d0e4() {
  self endon(#"disconnect");

  if(!self function_51759b03()) {
    return;
  }

  if(isDefined(self.archetype) && self.archetype == "zombie_dog") {
    self thread function_d85f6f61();
    self thread function_124ccedf();
    return;
  }

  if(!isDefined(self.voiceprefix)) {
    self.voiceprefix = "vox_ax";
  }

  self function_4a19b47a();
  self.isspeaking = 0;
  self.soundmod = "player";
  self thread function_158cbf3();

  if(self.team == # "allies") {
    self thread function_e1c920f9();
  }
}

function private function_158cbf3() {
  self endon(#"death");

  while(true) {
    result = self waittill(#"asm_notify");

    if(self function_2346ea47(result.param)) {
      self function_bd51deb1(result.param);
    }
  }
}

function function_e1c920f9() {
  self endon(#"death");

  while(true) {
    result = self waittill(#"damage");

    if(isPlayer(result.attacker) && damage_is_valid_for_friendlyfire_warning(result.mod)) {
      self function_bd51deb1("friendlyfire");
    }
  }
}

function damage_is_valid_for_friendlyfire_warning(mod) {
  if(!isDefined(mod)) {
    return false;
  }

  switch (mod) {
    case # "mod_grenade":
    case # "mod_crush":
    case # "mod_grenade_splash":
    case # "mod_impact":
    case # "mod_melee":
      return false;
  }

  return true;
}

function event_handler[actor_killed] function_a94f4749(eventstruct) {
  if(!self function_51759b03()) {
    return;
  }

  if(isDefined(self.archetype) && self.archetype == "zombie_dog") {
    return;
  }

  if(is_true(self.diequietly)) {
    return;
  }

  if(!isDefined(self.voiceprefix) || !isDefined(self.var_3d0026c9)) {
    return;
  }

  attacker = eventstruct.attacker;
  meansofdeath = eventstruct.mod;

  if(isDefined(self.archetype) && self.archetype == # "robot") {
    if(isDefined(attacker) && !isPlayer(attacker)) {
      if(meansofdeath == "MOD_MELEE") {
        attacker thread function_bd51deb1("meleeKill");
      } else {
        attacker thread function_bd51deb1("enemyKill");
      }
    }

    return;
  }

  if(isDefined(self)) {
    meleeassassinate = isDefined(meansofdeath) && meansofdeath == "MOD_MELEE_ASSASSINATE";

    if(isDefined(self.archetype) && self.archetype == "warlord") {
      self playSound(#"hash_2083f6ebc94b5bc7");
    }

    if(!is_true(self.var_ff22950d) && !meleeassassinate && isDefined(attacker)) {
      if(battlechatter_table::function_4e83ff35("combat", "announce", meansofdeath) > 0) {
        self thread function_bd51deb1(meansofdeath);
      } else {
        self thread function_bd51deb1("death");
      }

      self.var_c719b698 = 1;
    }

    if(is_true(self.var_e598a03f) && isDefined(attacker) && !isPlayer(attacker)) {
      attacker thread function_bd51deb1("sniperdown");
      return;
    }

    if(isDefined(attacker) && !isPlayer(attacker)) {
      if(meansofdeath == "MOD_MELEE") {
        attacker thread function_bd51deb1("meleeKill");
      } else {
        attacker thread function_bd51deb1("enemyKill");
      }
    }

    sniper = isDefined(attacker) && isDefined(attacker.scoretype) && attacker.scoretype == "_sniper";

    if(!meleeassassinate) {
      close_ai = function_c17c8a8e(self);

      if(isDefined(close_ai) && !is_true(close_ai.var_ff22950d)) {
        if(sniper) {
          attacker.var_e598a03f = 1;
          close_ai thread function_bd51deb1("sniperthreat");
          return;
        }

        close_ai thread function_bd51deb1("friendlydown");
      }
    }
  }
}

function event_handler[bhtn_action_start] function_8f82e45e(eventstruct) {
  if(!self function_51759b03(0, eventstruct)) {
    return;
  }

  if((is_true(self.diequietly) || is_true(self.var_c719b698)) && eventstruct.action === "death") {
    return;
  }

  if(isDefined(self.archetype) && self.archetype == "zombie_dog") {
    return;
  }

  self thread function_bd51deb1(eventstruct.action);
}

function event_handler[bhtn_action_terminate] function_535f1141(eventstruct) {}

function function_bd51deb1(notify_string) {
  self function_4e7b6f6d("combat", "announce", notify_string);
  var_73691c34 = level.var_69427377[notify_string];

  if(isDefined(var_73691c34)) {
    var_97a035a7 = self function_fb35fc43(1, 15);

    if(var_97a035a7.size > 0) {
      var_97a035a7[randomint(var_97a035a7.size)] function_bd51deb1(var_73691c34);
    }
  }
}

function function_4e7b6f6d(category, type, modifier) {
  if(!isDefined(modifier)) {
    return;
  }

  is_death = (isDefined(modifier) ? modifier : "") == "death";
  probability = battlechatter_table::function_4e83ff35(category, type, modifier);

  if(probability >= 100 || randomfloatrange(0, 100) <= probability) {
    delay = battlechatter_table::function_2d2570e3(category, type, modifier);
    key = modifier;

    if(!ishash(modifier)) {
      key = "" + category + "_" + type + "_" + modifier;
    }

    var_db05b8ae = isDefined(level.var_5eabfd9[key]) ? level.var_5eabfd9[key] : 0;

    if(delay <= 0 || gettime() > var_db05b8ae) {
      var_cba6af0b = battlechatter_table::function_ac3d3b19(category, type, modifier);

      if(isDefined(var_cba6af0b) && isDefined(var_cba6af0b[0]) && var_cba6af0b[0] != "") {
        alias = var_cba6af0b[randomint(var_cba6af0b.size)];
        self function_9cb2c120(self, alias, undefined, undefined, 1, undefined, is_death);

        if(delay > 0) {
          level.var_5eabfd9[key] = gettime() + delay * 1000;
        }

        return 1;
      }
    }
  }
}

function event_handler[grenade_fire] function_edd0c161(eventstruct) {
  if(!self function_51759b03(1)) {
    return;
  }

  if(isai(self) && isDefined(self.archetype) && self.archetype == "zombie_dog") {
    return;
  }

  grenade = eventstruct.projectile;
  weapon = eventstruct.weapon;

  if(weapon.name == # "eq_frag_grenade" || weapon.name == # "frag_grenade" || weapon.name == # "hash_15ed0347f1459a04") {
    self thread function_bd51deb1("grenadetoss");
    level thread function_8be08180(self, grenade, "grenadeincoming");
    return;
  }

  if(weapon.name == # "eq_flash_grenade" || weapon.name == # "flash_grenade" || weapon.name == # "hash_ae7d40bb12f5ab6") {
    self thread function_bd51deb1("flashtoss");
    level thread function_8be08180(self, grenade, "flashincoming");
  }
}

function function_8be08180(thrower, grenade, event) {
  wait 1;

  if(!isDefined(thrower) || !isDefined(grenade)) {
    return;
  }

  team = # "axis";

  if(isDefined(thrower.team) && team == thrower.team) {
    team = # "allies";
  }

  ai = function_c9f7a37c(team, grenade);

  if(isDefined(ai)) {
    ai thread function_bd51deb1(event);
  }
}

function event_handler[grenade_stuck] function_2a82bb92(eventstruct) {
  if(!self function_51759b03()) {
    return;
  }

  if(isDefined(self.archetype) && self.archetype == "zombie_dog") {
    return;
  }

  grenade = eventstruct.projectile;

  if(isDefined(grenade)) {
    grenade.stucktoplayer = self;
  }

  if(isalive(self)) {
    self thread function_bd51deb1("stickyincoming");
  }
}

function function_e0d850d2() {
  self endon(#"disconnect");
  waitresult = self waittill(#"death");
  attacker = waitresult.attacker;
  meansofdeath = waitresult.mod;

  if(isDefined(attacker) && !isPlayer(attacker)) {
    if(meansofdeath == "MOD_MELEE") {
      attacker thread function_bd51deb1("meleeKill");
      return;
    }

    attacker thread function_bd51deb1("enemyKill");
  }
}

function function_413ce774(object, type) {
  wait randomfloatrange(0.1, 0.4);
  ai = function_c9f7a37c("both", object, 500);

  if(isDefined(ai)) {
    if(type == "car") {
      level thread function_9cb2c120(ai, "destructiblecar");
      return;
    }

    level thread function_9cb2c120(ai, "destructiblebarrel");
  }
}

function function_bf0a663a() {
  level endon(#"unloaded");
  self endon(#"death", #"disconnect", #"cybercom_action");

  if(!isDefined(level.var_85c7869d)) {
    level.var_85c7869d = 0;
    enemies = getaiteamarray(#"axis", #"team3");
    level.var_ecbd73e7 = array();

    foreach(enemy in enemies) {
      if(isDefined(enemy.archetype) && enemy.archetype == # "robot") {
        array::add(level.var_ecbd73e7, enemy, 0);
      }
    }
  }

  while(true) {
    wait 1;
    t = gettime();

    if(t > level.var_85c7869d + 1000) {
      level.var_85c7869d = t;
      enemies = getaiteamarray(#"axis", #"team3");
      function_1eaaceab(level.var_ecbd73e7);
      arrayremovevalue(level.var_ecbd73e7, undefined);

      foreach(enemy in enemies) {
        if(isDefined(enemy.archetype) && enemy.archetype == # "robot") {
          array::add(level.var_ecbd73e7, enemy, 0);
        }
      }
    }

    if(level.var_ecbd73e7.size <= 0) {
      continue;
    }

    played_sound = 0;

    foreach(robot in level.var_ecbd73e7) {
      if(!isDefined(robot)) {
        continue;
      }

      if(distancesquared(robot.origin, self.origin) < 90000) {
        if(isDefined(robot.current_scene)) {
          continue;
        }

        if(isDefined(robot.health) && robot.health <= 0) {
          continue;
        }

        if(isDefined(level.scenes) && level.scenes.size >= 1) {
          continue;
        }

        yaw = self getyawtospot(robot.origin);
        diff = self.origin[2] - robot.origin[2];

        if((yaw < -95 || yaw > 95) && abs(diff) < 200) {
          robot playSound(#"hash_49057ee50c660740");
          played_sound = 1;
          break;
        }
      }
    }

    if(played_sound) {
      wait 5;
    }
  }
}

function getyawtospot(spot) {
  pos = spot;
  yaw = self.angles[1] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

function private event_handler[battlechatter] function_bf4d6a54(parms) {
  self function_9cb2c120(self, parms.suffix, undefined, undefined, 1);
}

function function_9cb2c120(ai, line, var_7488e05b, category, var_954826ad, var_a8bd89dd, is_death = 0) {
  if(!isDefined(ai)) {
    return;
  }

  ai endon(#"death", #"disconnect");

  if(isDefined(var_7488e05b)) {
    assert(!isDefined(var_a8bd89dd));
    var_a8bd89dd = [line + "_response"];
  }

  if(!isDefined(ai.voiceprefix) || !isDefined(ai.var_3d0026c9)) {
    return;
  }

  if(isDefined(ai.archetype) && ai.archetype == # "robot") {
    soundalias = ai.voiceprefix + ai.var_3d0026c9 + "_" + "chatter";
  } else if(!is_hero(ai) && strstartswith(line, "exert_")) {
    if(line == "exert_immolation") {
      line = "exert_death_scream";
    }

    soundalias = "vox_male_" + line;
  } else {
    soundalias = ai.voiceprefix + ai.var_3d0026c9 + "_" + line;
  }

  ai thread function_7e56a9a1(soundalias, var_954826ad, var_a8bd89dd, category, is_death);
}

function function_7e56a9a1(soundalias, var_954826ad, var_a8bd89dd, category, is_death = 0) {
  if(!isDefined(soundalias)) {
    return;
  }

  if(!isDefined(var_954826ad)) {
    var_954826ad = 0;
  }

  if(self function_96dd94f5(category) && (!is_true(self.isspeaking) || var_954826ad)) {
    if(!isDefined(self.enemy) && !var_954826ad) {
      return;
    }

    function_14984343();

    if(!isalive(self) && !is_death) {
      return;
    }

    if(!isDefined(self)) {
      return;
    }

    if(is_true(self.istalking)) {
      return;
    }

    if(is_true(self.isspeaking)) {
      self notify(#"bc_interrupt");
    }

    if(soundexists(soundalias)) {
      if(getdvarint(#"bc_debug")) {
        print3d(self.origin + (0, 0, 60), soundalias, (0, 1, 0), 1, 1, 100);
      }

      if(isalive(self) && isactor(self) && self.archetype !== # "zombie_dog" && self.archetype !== # "mp_dog") {
        self playsoundontag(soundalias, "j_head");
      } else {
        self playSound(soundalias);
      }

      self thread wait_playback_time(soundalias);
      result = self waittill(soundalias, #"death", #"disconnect", #"bc_interrupt");

      if(isDefined(self)) {
        if(result._notify == soundalias) {
          if(isDefined(var_a8bd89dd) && var_a8bd89dd.size > 0) {
            response = var_a8bd89dd[0];
            arrayremovevalue(var_a8bd89dd, response);
            ai = function_c17c8a8e(self);

            if(isDefined(ai) && isDefined(response)) {
              level thread function_9cb2c120(ai, response, undefined, undefined, undefined, var_a8bd89dd);
            }
          }
        } else if(result._notify == "bc_interrupt") {
          self stopsound(soundalias);
        } else if(!is_true(is_death)) {
          self stopsound(soundalias);
        }
      }

      return;
    }

    if(getdvarint(#"bc_debug")) {
      print3d(self.origin + (0, 0, 60), soundalias, (1, 0, 0), 1, 1, 100);
    }
  }
}

function function_14984343() {
  if(!isDefined(level.var_c3687237)) {
    level thread function_aacf773a();
  }

  while(level.var_c3687237 != 0) {
    util::wait_network_frame();
  }

  level.var_c3687237++;
}

function function_aacf773a() {
  while(true) {
    level.var_c3687237 = 0;
    util::wait_network_frame();
  }
}

function function_96dd94f5(str_category = "bc") {
  if(isDefined(level.allowbattlechatter) && !is_true(level.allowbattlechatter[str_category])) {
    return false;
  }

  if(isDefined(self.allowbattlechatter) && !is_true(self.allowbattlechatter[str_category])) {
    return false;
  }

  return true;
}

function on_player_spawned() {
  self endon(#"disconnect");
  self.soundmod = "player";
  self.var_c7a2467a = 0;
  self.var_2503219f = 1;
  self.isspeaking = 0;
  self thread pain_vox();
  self thread function_bf0a663a();
}

function function_a0ec1dc0(suffix) {
  soundalias = "vox_plyr_" + suffix;

  if(self function_96dd94f5() && !is_true(self.istalking) && !is_true(self.isspeaking)) {
    self playsoundtoplayer(soundalias, self);
    self thread wait_playback_time(soundalias);
  }
}

function pain_vox() {
  self endon(#"death", #"disconnect");

  while(true) {
    waitresult = self waittill(#"hash_3ac4241a987b394f");

    if(randomintrange(0, 100) <= 100) {
      if(isalive(self)) {
        if(waitresult.mod == "MOD_DROWN") {
          soundalias = "chr_swimming_drown";
          self.var_c7a2467a = 1;

          if(self.var_2503219f) {
            self thread function_5ef33d49();
          }
        }

        soundalias = "vox_plyr_exert_pain";
        self thread function_7e56a9a1(soundalias, 1);
      }
    }

    wait 0.5;
  }
}

function function_5ef33d49() {
  self endon(#"death", #"disconnect", #"snd_gasp");
  level endon(#"game_ended");
  self.var_2503219f = 0;

  while(true) {
    if(!self isplayerunderwater() && self.var_c7a2467a) {
      self.var_c7a2467a = 0;
      self.var_2503219f = 1;
      self thread function_7e56a9a1("vox_pm1_gas_gasp", 1);
      self notify(#"snd_gasp");
    }

    wait 0.5;
  }
}

function wait_playback_time(soundalias, timeout) {
  self endon(#"death", #"disconnect");
  playbacktime = soundgetplaybacktime(timeout);
  self.isspeaking = 1;

  if(playbacktime >= 0) {
    waittime = playbacktime * 0.001;
    wait waittime;
  } else {
    wait 1;
  }

  self notify(timeout);
  self.isspeaking = 0;
}

function function_c17c8a8e(var_928cff8, maxdist) {
  if(isDefined(var_928cff8)) {
    aiarray = getaiteamarray(var_928cff8.team);
    aiarray = arraysort(aiarray, var_928cff8.origin);

    if(!isDefined(maxdist)) {
      maxdist = 1000;
    }

    foreach(dude in aiarray) {
      if(!isDefined(var_928cff8)) {
        return undefined;
      }

      if(!isDefined(dude) || !isalive(dude) || !isDefined(dude.var_3d0026c9)) {
        continue;
      }

      if(dude == var_928cff8) {
        continue;
      }

      if(isvehicle(dude)) {
        continue;
      }

      if(isDefined(dude.archetype) && dude.archetype == # "robot") {
        continue;
      }

      if(!is_hero(dude) && !is_hero(var_928cff8)) {
        if(dude.var_3d0026c9 == var_928cff8.var_3d0026c9) {
          continue;
        }
      }

      if(distance(var_928cff8.origin, dude.origin) > maxdist) {
        continue;
      }

      return dude;
    }
  }

  return undefined;
}

function function_c9f7a37c(team, object, maxdist) {
  if(!isDefined(object)) {
    return;
  }

  if(team == "both") {
    aiarray = getaiteamarray(#"axis", #"allies");
  } else {
    aiarray = getaiteamarray(team);
  }

  aiarray = arraysort(aiarray, object.origin);

  if(!isDefined(maxdist)) {
    maxdist = 1000;
  }

  foreach(dude in aiarray) {
    if(!isDefined(dude) || !isalive(dude)) {
      continue;
    }

    if(isvehicle(dude)) {
      continue;
    }

    if(isDefined(dude.archetype) && dude.archetype == # "robot") {
      continue;
    }

    if(!isDefined(dude.voiceprefix) || !isDefined(dude.var_3d0026c9)) {
      continue;
    }

    if(distance(dude.origin, object.origin) > maxdist) {
      continue;
    }

    return dude;
  }

  return undefined;
}

function function_2ab9360b(b_allow, str_category = "bc") {
  assert(isDefined(b_allow), "<dev string:x44>");
  self.allowbattlechatter[str_category] = b_allow;
}

function function_d85f6f61() {
  self endon(#"death", #"disconnect");

  while(true) {
    self playsoundontag("aml_dog_bark", "tag_eye");
    wait randomfloatrange(1, 3.5);
  }
}

function function_124ccedf() {
  self waittill(#"death");

  if(isDefined(self)) {
    self playSound(#"hash_4c37db042a332449");
  }
}