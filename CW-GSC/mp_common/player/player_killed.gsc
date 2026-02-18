/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\player\player_killed.gsc
***********************************************/

#using script_725554a59d6a75b9;
#using script_7a8059ca02b7b09e;
#using script_7f6cd71c43c45c57;
#using scripts\abilities\ability_player;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\gamestate_util;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\math_shared;
#using scripts\core_common\medals_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\spectating;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\bb;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\deathicons;
#using scripts\mp_common\gametypes\display_transition;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\player\player_damage;
#using scripts\mp_common\player\player_record;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;
#using scripts\weapons\weapons;
#namespace player;

function function_df36a02d(attacker, weapon, mod) {
  if(getdvarint(#"hash_45ba615a0cae5393", 0) > 0) {
    attacker = self;
    weapon = attacker getcurrentweapon();
  }

  if(isDefined(weapon)) {
    var_2f9ea2b9 = weapons::getbaseweapon(weapon);
    baseweaponindex = getbaseweaponitemindex(var_2f9ea2b9);
    self clientfield::set_player_uimodel("huditems.killedByItemIndex", baseweaponindex);
  } else {
    self clientfield::set_player_uimodel("huditems.killedByItemIndex", 0);
  }

  if(isDefined(attacker)) {
    self clientfield::set_player_uimodel("huditems.killedByEntNum", attacker getentitynumber());
  } else {
    self clientfield::set_player_uimodel("huditems.killedByEntNum", 15);
  }

  if(isDefined(mod)) {
    modindex = function_4a856ead(mod);

    if(mod != "MOD_META") {
      if(attacker === self) {
        modindex = function_4a856ead("MOD_SUICIDE");
      } else if(weapon === level.weaponnone) {
        modindex = function_4a856ead("MOD_UNKNOWN");
        self clientfield::set_player_uimodel("huditems.killedByEntNum", self getentitynumber());
      }
    }

    self clientfield::set_player_uimodel("huditems.killedByMOD", modindex);
  } else {
    self clientfield::set_player_uimodel("huditems.killedByEntNum", 15);
  }

  attachments = function_30d57f0e(weapon);
  self clientfield::set_player_uimodel("huditems.killedByAttachmentCount", attachments.size);

  for(var_20d65af5 = 0; var_20d65af5 < attachments.size && var_20d65af5 < 5; var_20d65af5++) {
    self clientfield::set_player_uimodel("huditems.killedByAttachment" + var_20d65af5, attachments[var_20d65af5]);
  }

  var_89ea0a9f = 0;

  if(isPlayer(attacker) && isDefined(baseweaponindex) && baseweaponindex > 0) {
    var_e28d611d = attacker function_b17c1957(baseweaponindex) === 1;
    weaponclass = util::getweaponclass(weapon);

    switch (weaponclass) {
      case # "weapon_knife":
        var_f2c36eba = # "hash_49b586d05aaa0209";
        var_22938e87 = # "kills";
        break;
      case # "weapon_launcher":
        var_f2c36eba = # "hash_67536f932f6aeb36";
        var_22938e87 = # "hash_497df827743010c3";
        break;
      default:
        var_f2c36eba = # "hash_14b7133a39a0456e";
        var_22938e87 = # "ekia";
        break;
    }

    var_b9d38f6c = attacker stats::function_1bb1c57c(#"weapon_challenges", weapon.statname, var_f2c36eba, #"challengetier") > 0;
    var_4175f0ae = attacker stats::function_1bb1c57c(#"weapon_challenges", weapon.statname, #"challenges", #"challengetier") > 0;
    var_b4f9ec1a = var_e28d611d && var_b9d38f6c && var_4175f0ae;

    if(attacker stats::function_1bb1c57c(#"globalchallenges", #"weapons_mastery", #"challengetier") > 0) {
      var_89ea0a9f = 3;
    }

    if(var_89ea0a9f == 0) {
      if(weaponclass == # "weapon_knife" || weaponclass == # "weapon_special") {
        if(attacker stats::function_1bb1c57c(#"globalchallenges", #"hash_7f0ce2a2e0a76e67", #"challengetier") > 0) {
          var_89ea0a9f = 2;
        }
      } else if(attacker stats::function_1bb1c57c(#"hash_78666913f57209e4", weaponclass, #"challenges_completed", #"challengetier") > 0) {
        var_89ea0a9f = 2;
      }
    }

    if(var_89ea0a9f == 0) {
      if(attacker stats::function_1bb1c57c(#"hash_78666913f57209e4", weaponclass, var_22938e87, #"challengetier") >= 5) {
        var_89ea0a9f = 1;
      }
    }
  }

  self clientfield::set_player_uimodel("huditems.killedByMasteryBadgeMarksman", var_e28d611d === 1);
  self clientfield::set_player_uimodel("huditems.killedByMasteryBadgeSharpshooter", var_b9d38f6c === 1);
  self clientfield::set_player_uimodel("huditems.killedByMasteryBadgeExpert", var_4175f0ae === 1);
  self clientfield::set_player_uimodel("huditems.killedByMasteryBadgeMaster", var_b4f9ec1a === 1);
  self clientfield::set_player_uimodel("huditems.killedByClassMasteryBadge", var_89ea0a9f);
}

function function_7622d447(attacker) {
  if(isDefined(self.attackers)) {
    for(j = 0; j < self.attackers.size; j++) {
      player = self.attackers[j];

      if(self function_ca27b62b(attacker, player)) {
        damage_done = self.attackerdamage[player.clientid].damage;
        einflictor = self.attackerdamage[player.clientid].einflictor;
        weapon = self.attackerdamage[player.clientid].weapon;
        player function_b8871aa2(einflictor, self, damage_done, weapon);
      }
    }
  }
}

function function_7eea9ada(player) {
  timeofdeath = gettime();

  if(isDefined(self.laststandparams.laststandstarttime)) {
    timeofdeath = self.laststandparams.laststandstarttime;
  }

  if(isDefined(level.var_c77de7d6) && level.var_c77de7d6 > 0 && timeofdeath > int(level.var_c77de7d6 * 1000) + self.attackerdamage[player.clientid].lastdamagetime) {
    return false;
  }

  return true;
}

function function_ca27b62b(attacker, player) {
  if(!isDefined(player)) {
    return false;
  }

  if(isDefined(attacker) && player util::isenemyteam(attacker.team)) {
    return false;
  }

  if(self.attackerdamage[player.clientid].damage == 0) {
    return false;
  }

  if(is_true(level.ekiaresetondeath) && isDefined(player.deathtime) && player.deathtime > self.attackerdamage[player.clientid].lastdamagetime) {
    return false;
  }

  if(!self function_7eea9ada(player)) {
    return false;
  }

  return true;
}

function function_284c61bd(attacker, meansofdeath, bledout = 0) {
  if(isDefined(self.attackers) && isDefined(attacker)) {
    for(j = 0; j < self.attackers.size; j++) {
      player = self.attackers[j];

      if(!isDefined(player)) {
        continue;
      }

      if(self.team == player.team) {
        continue;
      }

      if(self.attackerdamage[player.clientid].damage == 0) {
        continue;
      }

      if(is_true(level.ekiaresetondeath) && isDefined(player.deathtime) && player.deathtime > self.attackerdamage[player.clientid].lastdamagetime) {
        continue;
      }

      if(!self function_7eea9ada(player) && !bledout) {
        continue;
      }

      if(isDefined(self.laststandparams.attacker)) {
        attacker = self.laststandparams.attacker;
      }

      einflictor = self.attackerdamage[player.clientid].einflictor;
      weapon = self.attackerdamage[player.clientid].weapon;

      if(player != attacker) {
        meansofdeath = self.attackerdamage[player.clientid].meansofdeath;
      }

      self function_4e3e8bee(einflictor, player, meansofdeath, weapon, attacker);
    }
  }
}

function private function_66cec679() {
  team = self.team;
  teammates = getplayers(team);

  foreach(player in teammates) {
    player spectating::set_permissions();

    if(player == self) {
      continue;
    }

    if(player.sessionstate == "spectator") {
      player.spectatorclient = self getentitynumber();
    }
  }
}

function private function_448f7ed2() {
  if(!is_true(level.var_3e5fe4d1)) {
    return false;
  }

  if(level.var_f2814a96 !== 0 && level.var_f2814a96 !== 2) {
    return false;
  }

  if(is_true(level.wave_spawn)) {
    time = gettime();
    team = self.pers[# "team"];

    if(isDefined(team) && isDefined(level.lastwave) && isDefined(level.lastwave[team]) && isDefined(level.wavedelay) && isDefined(level.wavedelay[team])) {
      wavedelay = int(level.wavedelay[team] * 1000);
      lasttime = time - level.lastwave[team];
      timediff = wavedelay - lasttime;
      var_4e7f2872 = isDefined(level.var_75db41a7) && time >= level.var_75db41a7;

      if(timediff > 5000 && !var_4e7f2872) {
        return true;
      }
    }
  } else {
    return true;
  }

  return false;
}

function callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc, psoffsettime, deathanimduration, enteredresurrect = 0) {
  profilelog_begintiming(7, "ship");
  self endon(#"spawned");
  self.var_4ef33446 = smeansofdeath == "MOD_META";

  if(getdvarint(#"hash_2517ca1e8454c3c8", 0) == 1) {
    self.var_4ef33446 = 1;
  }

  if(gamestate::is_game_over()) {
    post_game_death(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    return;
  }

  if(self.sessionteam == # "spectator") {
    return;
  }

  util::function_1ea0b2ce();
  level.var_445b1bca = gettime();
  self needsrevive(0);

  if(isDefined(self.burning) && self.burning == 1) {
    self setburn(0);
  }

  self.cur_kill_streak = 0;
  self.suicide = 0;
  self.teamkilled = 0;
  countdeath = !is_true(self.var_cee93f5) && !self.var_4ef33446;

  if(countdeath) {
    if(!isDefined(self.var_a7d7e50a)) {
      self.var_a7d7e50a = 0;
    }

    level.deaths[self.team]++;
    self.var_a7d7e50a++;
    start_generator_captureshouldshowpain();
  }

  attacker callback::callback(#"on_killed_player");
  self thread globallogic_audio::flush_leader_dialog_key_on_player("equipmentDestroyed");
  weapon = update_weapon(einflictor, weapon);
  pixbeginevent(#"");
  self thread audio::function_30d4f8c4(attacker, smeansofdeath, weapon);
  wasinlaststand = 0;
  bledout = 0;
  deathtimeoffset = 0;
  attackerstance = undefined;
  self.laststandthislife = undefined;
  self.vattackerorigin = undefined;
  self.spawn.response = undefined;
  self function_df36a02d(attacker, weapon, smeansofdeath);
  weapon_at_time_of_death = self getcurrentweapon();
  var_8efc9727 = isPlayer(attacker) && self util::isenemyplayer(attacker) == 0;
  var_41c4d474 = isPlayer(attacker) && self == attacker;
  vattacker = isDefined(attacker) ? attacker : self;
  var_a44c7fd8 = {
    #victimorigin: self.origin, #victimangles: self getplayerangles(), #victimweapon: self.currentweapon, #einflictor: einflictor, #attacker: attacker, #attackerorigin: vattacker.origin, #attackerangles: isPlayer(vattacker) ? vattacker getplayerangles() : vattacker.angles, #idamage: idamage, #smeansofdeath: smeansofdeath, #weapon: weapon, #var_fd90b0bb: var_fd90b0bb, #vdir: vdir, #shitloc: shitloc, #matchtime: function_f8d53445()
  };

  if(isDefined(self.uselaststandparams) && enteredresurrect == 0) {
    self.uselaststandparams = undefined;
    assert(isDefined(self.laststandparams));

    if(isDefined(self.laststandparams) && (!level.teambased || !isDefined(attacker) || !isPlayer(attacker) || !var_8efc9727 || var_41c4d474)) {
      einflictor = self.laststandparams.einflictor;
      attacker = self.laststandparams.attacker;
      attackerstance = self.laststandparams.attackerstance;
      idamage = self.laststandparams.idamage;
      smeansofdeath = self.laststandparams.smeansofdeath;
      assert(isDefined(smeansofdeath));
      weapon = self.laststandparams.weapon;
      var_fd90b0bb = self.laststandparams.var_fd90b0bb;
      vdir = self.laststandparams.vdir;
      shitloc = self.laststandparams.shitloc;
      self.vattackerorigin = self.laststandparams.vattackerorigin;
      self.killcam_entity_info_cached = self.laststandparams.killcam_entity_info_cached;

      if(!is_true(self.laststandparams.var_59b19c1b)) {
        deathtimeoffset = float(gettime() - self.laststandparams.laststandstarttime) / 1000;
      }

      bledout = self.laststandparams.bledout;
      wasinlaststand = 1;
      var_8efc9727 = isPlayer(attacker) && self util::isenemyplayer(attacker) == 0;
      var_41c4d474 = isPlayer(attacker) && self == attacker;
    }
  }

  self stopsounds();
  var_c391d0a8 = self function_fc51dcf8(attacker, weapon, smeansofdeath, shitloc, var_41c4d474 || var_8efc9727);
  params = {
    #victim: self, #einflictor: einflictor, #eattacker: attacker, #idamage: idamage, #smeansofdeath: smeansofdeath, #weapon: weapon, #var_fd90b0bb: var_fd90b0bb, #vdir: vdir, #shitloc: shitloc, #psoffsettime: psoffsettime, #deathanimduration: deathanimduration, #laststandparams: self.laststandparams, #var_c0577970: var_c391d0a8.assisted_suicide
  };
  self callback::callback(#"on_player_killed", params);

  if(isDefined(var_c391d0a8.attacker)) {
    attacker = var_c391d0a8.attacker;
    smeansofdeath = var_c391d0a8.smeansofdeath;
    shitloc = var_c391d0a8.shitloc;
    weapon = var_c391d0a8.weapon;
  }

  self function_5f6cde96(var_41c4d474, var_8efc9727);
  var_c391d0a8.attacker = update_attacker(attacker, weapon);
  attacker = var_c391d0a8.attacker;
  function_813829e3(einflictor);
  self thread function_8826f676();
  self function_a3030357(var_c391d0a8.var_23da26bf, einflictor, var_c391d0a8.var_60851fcf, var_c391d0a8.var_4b5379af, bledout);
  self function_c2c4d6e9(var_c391d0a8, bledout, enteredresurrect, countdeath);
  pixendevent();
  var_a35e901f = var_a44c7fd8;

  if(isDefined(self.var_5b73c96a)) {
    self.var_5b73c96a = undefined;
    var_a35e901f = self.laststandparams;
  }

  self function_4a762be0(var_c391d0a8, var_a35e901f, weapon_at_time_of_death, attackerstance, countdeath, var_41c4d474, var_8efc9727, wasinlaststand, bledout, enteredresurrect);
  self function_c220950f(var_c391d0a8, idamage, weapon_at_time_of_death);
  level thread globallogic::updateteamstatus();
  level thread globallogic::updatealivetimes(self.team);
  self thread function_395ef176();
  self weapons::detach_carry_object_model();
  self function_7804764f(var_a35e901f, deathanimduration, psoffsettime, enteredresurrect);

  if(enteredresurrect) {
    thread globallogic_spawn::spawnqueuedclient(self.team, attacker);
  }

  self function_ff3ec0d4(einflictor, attacker, idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc, psoffsettime, deathanimduration);
  self function_7622d447();
  self.laststandparams = undefined;
  self.var_a1d415ee = undefined;

  if(isDefined(self.attackers)) {
    self.attackers = [];
  }

  if(!isDefined(self.killstreak_delay_killcam)) {
    self thread[[level.spawnplayerprediction]]();
  }

  if(self.currentspectatingclient != -1 && (level.spectatetype == 4 || level.spectatetype == 5) && self.pers[# "team"] != # "spectator") {
    function_39a7df61(self);
  }

  profilelog_endtiming(7, "gs=" + game.state);
  self function_42862f77(var_a35e901f, var_c391d0a8.attacker, deathtimeoffset, psoffsettime, deathanimduration, var_8efc9727, var_41c4d474, var_c391d0a8.assisted_suicide, enteredresurrect);
  function_93115f65(enteredresurrect);
}

function private function_e3cd54bf(attacker, einflictor, var_41c4d474, assistedsuicide) {
  if(getdvarint(#"scr_forcekillcam", 0) != 0) {
    return true;
  }

  if(isDefined(self.killstreak_delay_killcam)) {
    return false;
  }

  if(var_41c4d474) {
    return false;
  }

  if(assistedsuicide) {
    return false;
  }

  if(level.killcammode == 2) {
    return false;
  }

  if(self.var_4ef33446) {
    return false;
  }

  if(isPlayer(attacker)) {
    return true;
  }

  if(isDefined(einflictor.killcament)) {
    return true;
  }

  return false;
}

function private function_388d8a53(attacker, einflictor, var_41c4d474, assistedsuicide) {
  var_c547267e = -1;

  if(!var_41c4d474 && !assistedsuicide && isPlayer(attacker)) {
    var_c547267e = attacker getentitynumber();
  }

  if(isDefined(einflictor.killcament) && !isPlayer(attacker)) {
    var_c547267e = self getentitynumber();
  }

  if(getdvarint(#"scr_forcekillcam", 0) != 0 && var_c547267e < 0) {
    var_c547267e = self getentitynumber();
  }

  return var_c547267e;
}

function private function_42862f77(death_params, attacker, deathtimeoffset, psoffsettime, deathanimduration, var_8efc9727, var_41c4d474, assistedsuicide, enteredresurrect) {
  if(isDefined(self.killcam_entity_info_cached)) {
    killcam_entity_info = self.killcam_entity_info_cached;
    self.killcam_entity_info_cached = undefined;
  } else {
    killcam_entity_info = killcam::get_killcam_entity_info(death_params.attacker, death_params.einflictor, death_params.weapon);
  }

  perks = [];
  killstreaks = globallogic::getkillstreaks(death_params.attacker);
  var_c547267e = function_388d8a53(attacker, death_params.einflictor, var_41c4d474, assistedsuicide);
  self thread killcam::function_eb3deeec(var_c547267e, self getentitynumber(), killcam_entity_info, death_params.weapon, death_params.smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, death_params.attacker);
  wasteamkill = var_8efc9727 && !(var_41c4d474 || assistedsuicide);

  if(wasteamkill == 0 && assistedsuicide == 0 && death_params.smeansofdeath != "MOD_SUICIDE" && !(!isDefined(death_params.attacker) || death_params.attacker.classname == "trigger_hurt" || death_params.attacker.classname == "worldspawn" || var_41c4d474 || isDefined(death_params.attacker.disablefinalkillcam))) {
    level thread killcam::record_settings(var_c547267e, self getentitynumber(), killcam_entity_info, death_params.weapon, death_params.smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, death_params.attacker);
    var_c8fa9c41 = isPlayer(death_params.attacker) ? death_params.attacker getxuid() : 0;
    level thread potm::function_5523a49a(#"kill", var_c547267e, var_c8fa9c41, self, killcam_entity_info, death_params.weapon, death_params.smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, death_params.attacker, death_params.einflictor);
  }

  if(enteredresurrect) {
    return;
  }

  livesleft = !(level.numlives && !self.pers[# "lives"]) && !(level.numteamlives && !game.lives[self.team]);
  timeuntilspawn = globallogic_spawn::timeuntilspawn(1);

  if(livesleft) {
    self function_6bf621ea(#"respawn_timer", 2, int(timeuntilspawn + deathanimduration + level.playerrespawndelay * 1000 - 250), self getentitynumber());
  }

  if(!self.var_4ef33446) {
    if(is_true(self.var_342564dd) && self == death_params.attacker) {
      waitframe(1);
    } else {
      wait 0.25;
    }
  }

  self.cancelkillcam = 0;

  if(!userspawnselection::isspawnselectenabled()) {
    self thread killcam::cancel_on_use();
  }

  if(!self.var_4ef33446) {
    self watch_death(death_params.weapon, death_params.attacker, death_params.smeansofdeath, deathanimduration);
  }

  self.respawntimerstarttime = gettime();
  keep_deathcam = 0;

  if(level.killcammode == 2) {
    self.var_686890d5 = undefined;
    function_fcaec253();
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    livesleft = !(level.numlives && !self.pers[# "lives"]) && !(level.numteamlives && !game.lives[self.team]);

    if(livesleft && !teams::is_all_dead(self.team)) {
      if(is_true(level.spawnsystem.deathcirclerespawn)) {
        self thread[[level.spawnspectator]](self.origin + (0, 0, 60), self.angles);
      } else if(is_true(level.var_ce3bff50)) {
        self.var_7350dfd7 = 1;
      } else {
        function_93115f65();
      }

      return;
    }

    if(!is_true(self.var_686890d5)) {
      self thread[[level.spawnspectator]](self.origin + (0, 0, 60), self.angles);
    }

    return;
  } else {
    if(game.state != # "playing") {
      return;
    }

    if(isDefined(self.overrideplayerdeadstatus)) {
      keep_deathcam = self[[self.overrideplayerdeadstatus]]();
    }
  }

  dokillcam = self function_e3cd54bf(attacker, death_params.einflictor, var_41c4d474, assistedsuicide);

  if(!self.cancelkillcam && dokillcam && level.killcammode == 1 && wasteamkill == 0) {
    self clientfield::set_player_uimodel("hudItems.killcamActive", 1);
    livesleft = !(level.numlives && !self.pers[# "lives"]) && !(level.numteamlives && !game.lives[self.team]);
    timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
    willrespawnimmediately = livesleft && timeuntilspawn <= 0 && !level.playerqueuedrespawn && !userspawnselection::isspawnselectenabled();
    self killcam::killcam(var_c547267e, self getentitynumber(), killcam_entity_info, death_params.weapon, death_params.smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, willrespawnimmediately, globallogic_utils::timeuntilroundend(), perks, killstreaks, death_params.attacker, keep_deathcam);

    if(sessionmodeiswarzonegame()) {
      self luinotifyevent(#"hash_5b2d65a026de792d", 0);
    }
  } else if(self.cancelkillcam) {
    if(isDefined(self.killcamsskipped)) {
      self.killcamsskipped++;
    } else {
      self.killcamsskipped = 1;
    }
  }

  self clientfield::set_player_uimodel("hudItems.killcamActive", 0);
  self function_7b0f4389();

  if(self.var_4ef33446) {
    waitframe(1);
  }

  secondary_deathcam = 0;
  timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
  shoulddoseconddeathcam = timeuntilspawn > 0;

  if(shoulddoseconddeathcam && isDefined(self.secondarydeathcamtime)) {
    secondary_deathcam = self[[self.secondarydeathcamtime]]();
  }

  if(secondary_deathcam > 0 && !self.cancelkillcam) {
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    globallogic_utils::waitfortimeornotify(secondary_deathcam, "end_death_delay");
    self notify(#"death_delay_finished");
  }

  if(!self.cancelkillcam && dokillcam && level.killcammode == 1 && keep_deathcam) {
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
  }

  function_fcaec253();
}

function function_fcaec253() {
  if(!isDefined(level.var_d1455682.eliminateddisplaytransition) || level.var_d1455682.eliminateddisplaytransition.size == 0) {
    return;
  }

  if(!gamestate::is_state(#"pregame") && !gamestate::is_game_over()) {
    self.var_686890d5 = 1;

    if(teams::is_all_dead(self.team)) {
      self function_66cec679();
      self thread display_transition::function_1caf5c87(self.team);
      return;
    }

    if(function_21695e86()) {
      if(self function_448f7ed2()) {
        self thread display_transition::function_b3964dc9();
      }

      return;
    }

    self thread display_transition::function_9b2bd02c();
  }
}

function private function_7804764f(death_params, deathanimduration, psoffsettime, enteredresurrect) {
  pixbeginevent(#"");

  if(enteredresurrect == 0) {
    var_86825274 = death_params.weapon;

    if(weapons::ismeleemod(death_params.smeansofdeath) && var_86825274.type != "melee") {
      var_86825274 = level.weaponnone;
    }

    body = self cloneplayer(deathanimduration, var_86825274, death_params.attacker, death_params.vdir);

    if(isDefined(body) && !level.inprematchperiod) {
      body notsolid();

      if(is_true(self.var_6f9e9dc9)) {
        body.var_6f9e9dc9 = 1;
      }

      vattackerorigin = undefined;

      if(isDefined(death_params.attacker)) {
        vattackerorigin = death_params.attacker.origin;
      }

      self create_body(death_params, vattackerorigin, deathanimduration, body);
      self battlechatter::play_death_vox(body, death_params.attacker, death_params.weapon, death_params.smeansofdeath);
      var_a1d415ee = self.var_a1d415ee;

      if(isDefined(var_a1d415ee)) {
        globallogic::doweaponspecificcorpseeffects(body, var_a1d415ee.einflictor, var_a1d415ee.attacker, var_a1d415ee.idamage, var_a1d415ee.smeansofdeath, var_a1d415ee.weapon, var_a1d415ee.var_fd90b0bb, var_a1d415ee.vdir, var_a1d415ee.shitloc, psoffsettime);
      } else if(!isDefined(self.laststandparams) || !is_true(self.laststandparams.bledout)) {
        globallogic::doweaponspecificcorpseeffects(body, death_params.einflictor, death_params.attacker, death_params.idamage, death_params.smeansofdeath, death_params.weapon, death_params.var_fd90b0bb, death_params.vdir, death_params.shitloc, psoffsettime);
      }
    }
  }

  pixendevent();
}

function private function_c220950f(var_c391d0a8, idamage, weapon_at_time_of_death) {
  killer = undefined;
  killerloadoutindex = -1;
  killerwasads = 0;
  killerinvictimfov = 0;
  victiminkillerfov = 0;
  weapon = var_c391d0a8.weapon;
  victimspecialist = function_b14806c6(self player_role::get(), currentsessionmode());

  if(isPlayer(var_c391d0a8.attacker)) {
    attackerspecialist = function_b14806c6(var_c391d0a8.attacker player_role::get(), currentsessionmode());
    killer = var_c391d0a8.attacker;
    killerloadoutindex = var_c391d0a8.attacker.class_num;
    killerwasads = var_c391d0a8.attacker playerads() >= 1;
    killerinvictimfov = util::within_fov(self.origin, self.angles, killer.origin, self.fovcosine);
    victiminkillerfov = util::within_fov(killer.origin, killer.angles, self.origin, killer.fovcosine);
    var_c144d535 = isDefined(self.currentweapon) ? self.currentweapon.name : "";
    attacker_origin = isPlayer(killer) ? killer.origin : (0, 0, 0);

    if(killstreaks::is_killstreak_weapon(weapon)) {
      killstreak = killstreaks::get_killstreak_for_weapon_for_stats(weapon);
      bb::function_c3b9e07f(var_c391d0a8.attacker, attacker_origin, attackerspecialist, weapon.name, self, self.origin, victimspecialist, var_c144d535, idamage, var_c391d0a8.smeansofdeath, var_c391d0a8.shitloc, 1, killstreak);
    } else {
      bb::function_c3b9e07f(var_c391d0a8.attacker, attacker_origin, attackerspecialist, weapon.name, self, self.origin, victimspecialist, var_c144d535, idamage, var_c391d0a8.smeansofdeath, var_c391d0a8.shitloc, 1, undefined);
    }
  } else {
    bb::function_c3b9e07f(undefined, undefined, undefined, weapon.name, self, self.origin, victimspecialist, undefined, idamage, var_c391d0a8.smeansofdeath, var_c391d0a8.shitloc, 1, undefined);
  }

  victimweapon = undefined;
  victimweaponpickedup = 0;
  victimkillstreakweaponindex = 0;
  var_8926cc9f = 0;

  if(isDefined(weapon_at_time_of_death)) {
    victimweapon = weapon_at_time_of_death;

    if(isDefined(self.pickedupweapons) && isDefined(self.pickedupweapons[victimweapon])) {
      victimweaponpickedup = 1;
    }

    if(killstreaks::is_killstreak_weapon(victimweapon)) {
      killstreak = killstreaks::get_killstreak_for_weapon_for_stats(victimweapon);

      if(isDefined(level.killstreaks[killstreak].menuname)) {
        var_8926cc9f = 1;
        victimkillstreakweaponindex = level.killstreakindices[level.killstreaks[killstreak].menuname];

        if(!isDefined(victimkillstreakweaponindex)) {
          var_8926cc9f = 0;
          victimkillstreakweaponindex = 0;
        }
      }
    }
  }

  victimwasads = self playerads() >= 1;
  killerweaponpickedup = 0;
  killerkillstreakweaponindex = 0;
  var_28af8061 = 0;

  if(isDefined(weapon)) {
    if(isDefined(killer) && isDefined(killer.pickedupweapons) && isDefined(killer.pickedupweapons[weapon])) {
      killerweaponpickedup = 1;
    }

    if(killstreaks::is_killstreak_weapon(weapon)) {
      killstreak = killstreaks::get_killstreak_for_weapon_for_stats(weapon);

      if(isDefined(level.killstreaks[killstreak].menuname)) {
        var_28af8061 = 1;
        killerkillstreakweaponindex = level.killstreakindices[level.killstreaks[killstreak].menuname];

        if(!isDefined(killerkillstreakweaponindex)) {
          var_28af8061 = 0;
          killerkillstreakweaponindex = 0;
        }
      }
    }
  }

  paramstruct = spawnStruct();
  paramstruct.victimloadoutindex = self.class_num;
  paramstruct.victimweaponpickedup = victimweaponpickedup;
  paramstruct.victimwasads = victimwasads;
  paramstruct.killerloadoutindex = killerloadoutindex;
  paramstruct.killerweaponpickedup = killerweaponpickedup;
  paramstruct.killerwasads = killerwasads;
  paramstruct.victiminkillerfov = victiminkillerfov;
  paramstruct.killerinvictimfov = killerinvictimfov;
  paramstruct.killerkillstreakweaponindex = killerkillstreakweaponindex;
  paramstruct.victimkillstreakweaponindex = victimkillstreakweaponindex;
  paramstruct.var_28af8061 = var_28af8061;
  paramstruct.var_8926cc9f = var_8926cc9f;
  matchrecordlogadditionaldeathinfo(self, killer, victimweapon, weapon, paramstruct);
  self player_record::record_special_move_data_for_life(killer);

  attackerstring = "<dev string:x38>";

  if(isDefined(killer)) {
    attackerstring = killer getxuid() + "<dev string:x40>" + killer.name + "<dev string:x45>";
  }

  print("<dev string:x4a>" + var_c391d0a8.smeansofdeath + "<dev string:x40>" + weapon.name + "<dev string:x50>" + attackerstring + "<dev string:x58>" + idamage + "<dev string:x5f>" + (isDefined(var_c391d0a8.shitloc) ? var_c391d0a8.shitloc : "<dev string:x66>") + "<dev string:x6a>" + int(self.origin[0]) + "<dev string:x71>" + int(self.origin[1]) + "<dev string:x71>" + int(self.origin[2]));
}

function private function_4a762be0(var_c391d0a8, var_a44c7fd8, weapon_at_time_of_death, attackerstance, countdeath, var_41c4d474, var_8efc9727, wasinlaststand, bledout, enteredresurrect) {
  pixbeginevent(#"");
  awardassists = 0;
  wasteamkill = 0;
  wassuicide = 0;

  if(wasinlaststand) {
    function_caabcf70(self, var_a44c7fd8, self.laststandparams, self.var_a1d415ee);
  }

  if(!self.var_4ef33446) {
    self update_weapon_stats(var_c391d0a8.attacker, var_c391d0a8.weapon, var_c391d0a8.smeansofdeath, var_a44c7fd8.einflictor);
  }

  if(var_c391d0a8.assisted_suicide) {
    scoreevents::processscoreevent(#"assisted_suicide", var_c391d0a8.attacker, self, var_c391d0a8.weapon);
    level thread telemetry::function_18135b72(#"hash_37f96a1d3c57a089", {
      #player: self, #var_bdc4bbd2: # "assistedsuicide"});
  }

  if(countdeath) {
    scoreevents::processscoreevent(#"death", self, self, var_c391d0a8.weapon);
  }

  if(isPlayer(var_c391d0a8.attacker)) {
    if(var_41c4d474 || var_c391d0a8.assisted_suicide == 1) {
      if(countdeath) {
        wassuicide = 1;
        awardassists = self player_suicide(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_c391d0a8.smeansofdeath, var_c391d0a8.weapon, var_c391d0a8.shitloc);

        if(var_c391d0a8.assisted_suicide == 1) {
          self function_284c61bd(var_c391d0a8.attacker, var_c391d0a8.smeansofdeath);
        }

        if(self.friendlydamage === 1 && level.friendlyfire === 4) {
          self team_kill(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_c391d0a8.smeansofdeath, var_c391d0a8.weapon, var_c391d0a8.shitloc);
        }
      }
    } else {
      pixbeginevent(#"");

      if(var_8efc9727 && var_c391d0a8.smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {} else if(var_8efc9727) {
        wasteamkill = 1;
        self team_kill(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_c391d0a8.smeansofdeath, var_c391d0a8.weapon, var_c391d0a8.shitloc);
      } else {
        updatekillstreak(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_c391d0a8.weapon);
        self kill(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_c391d0a8.smeansofdeath, var_c391d0a8.weapon, var_c391d0a8.shitloc);
        self function_284c61bd(var_c391d0a8.attacker, var_c391d0a8.smeansofdeath, bledout);

        if(level.teambased) {
          awardassists = 1;
        }
      }

      if(var_c391d0a8.smeansofdeath == "MOD_HEAD_SHOT" && !wasteamkill && !isDefined(killstreaks::get_killstreak_for_weapon(var_c391d0a8.weapon))) {
        scoreevents::processscoreevent(#"headshot", var_c391d0a8.attacker, self, var_c391d0a8.weapon);
        var_c391d0a8.attacker contracts::player_contract_event(#"headshot", var_c391d0a8.weapon);
      }

      var_c391d0a8.prevlastkilltime = var_c391d0a8.lastkilltime;
      var_c391d0a8.attacker.lastkilltime = gettime();
      var_c391d0a8.attacker.var_e03e3ae5 = gettime();
      pixendevent();
    }

    if(!var_41c4d474 && !var_8efc9727) {
      var_c391d0a8.attacker notify(#"killed_enemy_player", {
        #victim: self, #weapon: var_c391d0a8.weapon, #time: gettime()
      });

      if(isDefined(self.laststandparams.var_5eb847d5)) {
        self thread challenges::function_ee74d44(self.laststandparams.var_5eb847d5, bledout);

        if(var_a44c7fd8.smeansofdeath === "MOD_EXECUTION") {
          var_38e70910 = var_a44c7fd8.einflictor;

          if(isPlayer(var_38e70910)) {
            var_dd480cd = var_c391d0a8.attacker function_803e2c82();
            self globallogic_score::function_706caaf3(var_a44c7fd8.smeansofdeath, var_38e70910, self, var_dd480cd);
          }
        }
      } else {
        self thread challenges::playerkilled(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_a44c7fd8.idamage, var_c391d0a8.smeansofdeath, var_c391d0a8.weapon, var_c391d0a8.shitloc, attackerstance, bledout);
      }
    } else if(var_41c4d474) {
      self thread challenges::function_c3b411f6(var_c391d0a8.smeansofdeath);
    } else if(var_8efc9727) {
      self thread challenges::function_cbfdab8f(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_a44c7fd8.idamage, var_c391d0a8.smeansofdeath, var_c391d0a8.weapon, var_c391d0a8.shitloc, attackerstance, bledout);
    }

    if(isDefined(var_c391d0a8.attacker.pers)) {
      if(var_c391d0a8.attacker.pers[# "hash_49e7469988944ecf"] === 1) {
        if(var_c391d0a8.weapon.statindex == level.weapon_hero_annihilator.statindex) {
          scoreevents::processscoreevent(#"hash_39926f44fa76b382", var_c391d0a8.attacker, self, var_c391d0a8.weapon);
          var_c391d0a8.attacker.pers[# "hash_49e7469988944ecf"] = undefined;
        }
      }
    }
  } else if(isDefined(var_c391d0a8.attacker) && (var_c391d0a8.attacker.classname == "trigger_hurt" || var_c391d0a8.attacker.classname == "worldspawn")) {
    scoreevents::processscoreevent(#"suicide", self, undefined, undefined);
    self globallogic_score::incpersstat(#"suicides", 1);
    self.suicides = self globallogic_score::getpersstat(#"suicides");
    self.suicide = 1;
    awardassists = 1;
    self function_284c61bd(undefined, var_c391d0a8.smeansofdeath);

    if(level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
      self notify(#"teamkillkicked");
      self function_3c238bc5();
    }

    self thread challenges::function_c3b411f6(var_c391d0a8.smeansofdeath);
  } else {
    wassuicide = 1;

    if(isDefined(var_a44c7fd8.einflictor.killcament)) {
      wassuicide = 0;
    }

    if(isDefined(var_c391d0a8.attacker) && isDefined(var_c391d0a8.attacker.team) && isDefined(level.teams[var_c391d0a8.attacker.team])) {
      if(self util::isenemyteam(var_c391d0a8.attacker.team)) {
        if(level.teambased) {
          if(!isDefined(killstreaks::get_killstreak_for_weapon(var_c391d0a8.weapon)) || is_true(level.killstreaksgivegamescore)) {
            globallogic_score::giveteamscore("kill", var_c391d0a8.attacker.team);
          }
        }

        wassuicide = 0;
      }
    }

    awardassists = 1;
    self function_284c61bd(undefined, var_c391d0a8.smeansofdeath);
    self thread challenges::function_c3b411f6(var_c391d0a8.smeansofdeath);
  }

  if(!level.ingraceperiod && enteredresurrect == 0) {
    if(var_c391d0a8.smeansofdeath != "MOD_FALLING") {
      if(var_c391d0a8.weapon.name != "incendiary_fire") {
        self weapons::drop_scavenger_for_death(var_c391d0a8.attacker);
      }
    }

    if(should_drop_weapon_on_death(wasteamkill, wassuicide, weapon_at_time_of_death, var_c391d0a8.smeansofdeath)) {
      self weapons::drop_for_death(var_c391d0a8.attacker, var_c391d0a8.weapon, var_c391d0a8.smeansofdeath, var_a44c7fd8.idamage, 0);
    }
  }

  if(awardassists) {
    self function_48a1200f(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_c391d0a8.weapon);
  }

  pixendevent();
}

function private function_c2c4d6e9(var_c391d0a8, bledout, enteredresurrect, countdeath) {
  self update_killstreaks(bledout.attacker, bledout.weapon);

  if(enteredresurrect == 0) {
    self.sessionstate = "dead";
    self.statusicon = "hud_status_dead";
  }

  self.hasriotshield = 0;
  self.hasriotshieldequipped = 0;
  self.pers[# "weapon"] = undefined;
  self.killedplayerscurrent = [];
  self.lastattacker = bledout.attacker;
  self.lastdeathpos = self.origin;
  self.pickedupweapons = [];
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self.wantsafespawn = 0;

  if(countdeath) {
    if(!isDefined(self.deathcount)) {
      self.deathcount = 0;
    }

    self.deathcount++;
  }

  println("<dev string:x76>" + self.clientid + "<dev string:x82>" + self.deathcount);
}

function private function_fc51dcf8(attacker, weapon, smeansofdeath, shitloc, var_20227168) {
  var_3a41c58c = {
    #attacker: undefined, #weapon: weapon, #smeansofdeath: smeansofdeath, #shitloc: shitloc, #assisted_suicide: 0
  };

  if(isDefined(self.attackers) && (!isDefined(attacker) || attacker.classname === "trigger_hurt" || attacker.classname === "worldspawn" || is_true(attacker.ismagicbullet) || attacker == self)) {
    if(!var_20227168) {
      foreach(player in self.attackers) {
        if(!isDefined(player)) {
          continue;
        }

        if(!isDefined(self.attackerdamage[player.clientid]) || !isDefined(self.attackerdamage[player.clientid].damage)) {
          continue;
        }

        if(player == self) {
          continue;
        }

        if(!self function_7eea9ada(player)) {
          continue;
        }

        if(!globallogic_player::allowedassistweapon(self.attackerdamage[player.clientid].weapon)) {
          continue;
        }

        attacker_damage = self.attackerdamage[player.clientid];

        if(attacker_damage.damage > 1 && !isDefined(var_3a41c58c.attacker)) {
          var_3a41c58c.attacker = player;
          var_3a41c58c.smeansofdeath = attacker_damage.meansofdeath;
          var_3a41c58c.weapon = attacker_damage.weapon;
          var_3a41c58c.shitloc = attacker_damage.shitloc;
          continue;
        }

        if(isDefined(var_3a41c58c.attacker) && self.attackerdamage[player.clientid].damage > self.attackerdamage[var_3a41c58c.attacker.clientid].damage) {
          var_3a41c58c.attacker = player;
          var_3a41c58c.smeansofdeath = attacker_damage.meansofdeath;
          var_3a41c58c.weapon = attacker_damage.weapon;
          var_3a41c58c.shitloc = attacker_damage.shitloc;
        }
      }
    }

    if(isDefined(var_3a41c58c.attacker)) {
      var_3a41c58c.assisted_suicide = 1;
    }
  }

  if(!isDefined(var_3a41c58c.attacker)) {
    var_3a41c58c.attacker = attacker;
  }

  var_3a41c58c.smeansofdeath = self function_b029639e(var_3a41c58c.attacker, var_3a41c58c.weapon, var_3a41c58c.smeansofdeath, var_3a41c58c.shitloc);

  if(isDefined(self.var_a1d415ee) && isPlayer(self.var_a1d415ee.attacker)) {
    var_3a41c58c.var_23da26bf = self.var_a1d415ee.attacker;
    var_3a41c58c.var_60851fcf = self.var_a1d415ee.weapon;
    var_3a41c58c.var_4b5379af = self.var_a1d415ee.smeansofdeath;
    var_3a41c58c.var_6613188 = self.var_a1d415ee.shitloc;
  } else {
    var_3a41c58c.var_23da26bf = var_3a41c58c.attacker;
    var_3a41c58c.var_4b5379af = var_3a41c58c.smeansofdeath;
    var_3a41c58c.var_60851fcf = var_3a41c58c.weapon;
    var_3a41c58c.var_6613188 = var_3a41c58c.shitloc;
  }

  return var_3a41c58c;
}

function private function_5f6cde96(var_41c4d474, var_8efc9727) {
  self.deathtime = gettime();
  self.pers[# "deathtime"] = self.deathtime;

  if(!var_41c4d474 && !var_8efc9727) {
    assert(isDefined(self.lastspawntime));

    if(!isDefined(self.alivetimecurrentindex)) {
      self.alivetimecurrentindex = 0;
    }

    if(isDefined(self.lastspawntime)) {
      self.alivetimes[self.alivetimecurrentindex] = self.deathtime - self.lastspawntime;
    } else {
      self.alivetimes[self.alivetimecurrentindex] = 0;
    }

    self.alivetimecurrentindex = (self.alivetimecurrentindex + 1) % level.alivetimemaxcount;
  }
}

function function_e3d34c3b() {
  wait 20;
  function_93115f65();
}

function function_6faccb24() {
  var_3db6ed91 = level.deathcircles.size - 2;

  if(var_3db6ed91 < 0) {
    return false;
  }

  if(level.deathcircleindex === var_3db6ed91) {
    return (is_true(level.deathcircle.var_8663a20d.scaling) || level.deathcircle.var_8663a20d.radius <= 0);
  }

  return false;
}

function function_9956f107() {
  if(isDefined(level.deathcircle.var_8663a20d) && !isDefined(level.deathcircle.nextcircle)) {
    return true;
  }

  return false;
}

function function_21695e86() {
  if(game.state != # "pregame" && game.state != # "playing") {
    return 0;
  }

  if(is_true(level.deathcircle.enabled)) {
    if(is_true(level.var_d91ebbf4)) {
      if(function_6faccb24()) {
        return 0;
      }

      if(isDefined(level.var_78442886) && isDefined(level.var_245d4af9) && level.var_78442886 >= level.var_245d4af9) {
        return 0;
      }
    }

    if(is_true(level.wave_spawn) && function_9956f107()) {
      return 0;
    }
  }

  return spawning::function_29b859d1();
}

function private function_93115f65(enteredresurrect) {
  if(is_true(enteredresurrect)) {
    return;
  }

  if(game.state != # "playing") {
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamtargetentity = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    return;
  }

  function_f9dc085a();
  userespawntime = 1;

  if(isDefined(level.hostmigrationtimer)) {
    userespawntime = 0;
  }

  hostmigration::waittillhostmigrationcountdown();

  if(globallogic_utils::isvalidclass(self.curclass) || !loadout::function_87bcb1b()) {
    timepassed = undefined;

    if(isDefined(self.respawntimerstarttime) && userespawntime) {
      timepassed = float(gettime() - self.respawntimerstarttime) / 1000;
    }

    self thread[[level.spawnclient]](timepassed);
    self.respawntimerstarttime = undefined;
  }
}

function private function_caabcf70(victim, callbackparams, laststandparams, var_a1d415ee) {
  assert(isDefined(victim));
  assert(isDefined(callbackparams));

  if(!isDefined(victim) || !isDefined(callbackparams)) {
    return;
  }

  var_f53d817d = isDefined(laststandparams) ? laststandparams : callbackparams;
  var_ee2f4691 = isDefined(var_a1d415ee) ? var_a1d415ee : callbackparams;
  function_ad11630f(victim, var_f53d817d.victimorigin, var_f53d817d.victimangles, var_f53d817d.victimweapon, var_f53d817d.attacker, var_f53d817d.attackerorigin, var_f53d817d.attackerangles, var_f53d817d.weapon, var_f53d817d.matchtime, var_f53d817d.shitloc, var_f53d817d.smeansofdeath, var_ee2f4691.attacker, var_ee2f4691.attackerorigin, var_ee2f4691.attackerangles, var_ee2f4691.weapon, var_ee2f4691.matchtime, var_ee2f4691.shitloc, var_ee2f4691.smeansofdeath);
  lifeindex = victim match_record::get_player_stat(#"hash_ec4aea1a8bbd82");

  if(isDefined(lifeindex) && isDefined(victim) && isPlayer(victim)) {
    victimindex = victim match_record::get_player_index();

    if(isDefined(victimindex)) {
      match_record::set_stat(#"lives", lifeindex, #"player_index", victimindex);
    }

    if(isDefined(var_f53d817d) && isDefined(var_f53d817d.attacker) && isPlayer(var_f53d817d.attacker)) {
      attackerindex = var_f53d817d.attacker match_record::get_player_index();

      if(isDefined(attackerindex)) {
        match_record::set_stat(#"lives", lifeindex, #"attacker_index", attackerindex);
      }
    }

    if(isDefined(var_ee2f4691) && isDefined(var_ee2f4691.attacker) && isPlayer(var_ee2f4691.attacker)) {
      killerindex = var_ee2f4691.attacker match_record::get_player_index();

      if(isDefined(killerindex)) {
        match_record::set_stat(#"lives", lifeindex, #"killer_index", killerindex);
      }
    }
  }
}

function private function_7b0f4389() {
  self.var_eca4c67f = 0;

  if(userspawnselection::isspawnselectenabled() && !is_true(self.switching_teams) && self globallogic_spawn::mayspawn()) {
    while(!self function_d1be915f()) {
      waitframe(1);
    }

    showmenu = self userspawnselection::shouldshowspawnselectionmenu();

    if(showmenu) {
      if(isDefined(self.predicted_spawn_point)) {
        self setorigin(self.predicted_spawn_point.origin);
        self setplayerangles(self.predicted_spawn_point.angles);
      }

      specialistindex = self player_role::get();

      if(player_role::is_valid(specialistindex)) {
        self.var_eca4c67f = 1;
        self userspawnselection::function_b55c5868();
        self userspawnselection::waitforspawnselection();
      }

      return;
    }

    self userspawnselection::activatespawnselectionmenu();
  }
}

function private function_d1be915f() {
  if(self isremotecontrolling()) {
    return false;
  }

  if(isDefined(self.killstreak_delay_killcam)) {
    return false;
  }

  return true;
}

function private watch_death(weapon, attacker, smeansofdeath, deathanimduration) {
  defaultplayerdeathwatchtime = 1.75;

  if(smeansofdeath == "MOD_MELEE_ASSASSINATE" || 0 > weapon.deathcamtime) {
    defaultplayerdeathwatchtime = deathanimduration * 0.001 + 0.5;
  } else if(0 < weapon.deathcamtime) {
    defaultplayerdeathwatchtime = weapon.deathcamtime;
  }

  if(isDefined(level.overrideplayerdeathwatchtimer)) {
    defaultplayerdeathwatchtime = [[level.overrideplayerdeathwatchtimer]](defaultplayerdeathwatchtime);
  }

  if(getdvarfloat(#"hash_8138dbf7b9de085", -1) >= 0) {
    defaultplayerdeathwatchtime = getdvarfloat(#"hash_8138dbf7b9de085", -1);
  }

  if(!(is_true(self.var_342564dd) && self == attacker)) {
    globallogic_utils::waitfortimeornotify(defaultplayerdeathwatchtime, "end_death_delay");
  }

  self notify(#"death_delay_finished");
}

function private function_b029639e(attacker, weapon, smeansofdeath, shitloc) {
  assert(isDefined(smeansofdeath));

  if(weapons::isheadshot(weapon, shitloc, smeansofdeath) && isPlayer(attacker)) {
    return "MOD_HEAD_SHOT";
  }

  switch (weapon.name) {
    case # "dog_bite":
      return "MOD_PISTOL_BULLET";
    case # "destructible_car":
      return "MOD_EXPLOSIVE";
    case # "explodable_barrel":
      return "MOD_EXPLOSIVE";
  }

  return smeansofdeath;
}

function private update_killstreaks(attacker, weapon) {
  if(!isDefined(self.switching_teams) && !self.var_4ef33446) {
    if(isPlayer(attacker) && level.teambased && attacker != self && !self util::isenemyteam(attacker.team)) {
      self.pers[# "cur_kill_streak"] = 0;
      self.pers[# "hash_53c274d14dadc40b"] = 0;
      self.pers[# "cur_total_kill_streak"] = 0;
      self.pers[# "totalkillstreakcount"] = 0;
      self.pers[# "killstreaksearnedthiskillstreak"] = 0;
      self setplayercurrentstreak(0);
    } else {
      if(!is_true(self.var_cee93f5)) {
        self globallogic_score::incpersstat(#"deaths", 1, 1, 1);

        if(!killstreaks::is_killstreak_weapon(weapon)) {
          self globallogic_score::incpersstat(#"hash_1b15df9adb572d1d", 1, 0, 0);
        }
      }

      self.deaths = self globallogic_score::getpersstat(#"deaths");
      self updatestatratio("kdratio", "kills", "deaths");

      if(level.hardcoremode === 1) {
        if(!is_true(self.var_cee93f5)) {
          self globallogic_score::incpersstat(#"deaths_hc", 1, 1, 1);
        }

        self updatestatratio("kdratio_hc", "kills_hc", "deaths_hc");
      }

      if(self.pers[# "cur_kill_streak"] > self.pers[# "best_kill_streak"]) {
        self.pers[# "best_kill_streak"] = self.pers[# "cur_kill_streak"];
        self function_ef823e71(15, self.pers[# "best_kill_streak"]);

        if(level.var_268c70a7 === 1 && isDefined(self.var_a504287b.var_52bfc9cc)) {
          var_c6267937 = self.pers[# "cur_kill_streak"];
          var_3e5f5126 = isDefined(self.var_a504287b) && isDefined(self.var_a504287b.var_52bfc9cc);

          if(var_3e5f5126 && var_c6267937 > self.var_a504287b.var_52bfc9cc) {
            self.var_a504287b.var_52bfc9cc = var_c6267937;
          }
        }
      }

      self.pers[# "kill_streak_before_death"] = self.pers[# "cur_kill_streak"];

      if(isDefined(self.pers[# "hvo"]) && isDefined(self.pers[# "hvo"][# "current"])) {
        self.pers[# "hvo"][# "current"][# "highestkillstreak"] = 0;
      }

      self.pers[# "cur_kill_streak"] = 0;
      self.pers[# "hash_53c274d14dadc40b"] = 0;
      self.pers[# "cur_total_kill_streak"] = 0;
      self.pers[# "totalkillstreakcount"] = 0;
      self.pers[# "killstreaksearnedthiskillstreak"] = 0;
      self setplayercurrentstreak(0);

      if(isDefined(self.cur_death_streak)) {
        self.cur_death_streak++;

        if(self.cur_death_streak >= getdvarint(#"perk_deathstreakcountrequired", 0)) {
          self enabledeathstreak();
        }
      }
    }
  } else {
    self.pers[# "cur_kill_streak"] = 0;
    self.pers[# "hash_53c274d14dadc40b"] = 0;
    self.pers[# "cur_total_kill_streak"] = 0;
    self.pers[# "totalkillstreakcount"] = 0;
    self.pers[# "killstreaksearnedthiskillstreak"] = 0;
    self setplayercurrentstreak(0);
  }

  if(killstreaks::is_killstreak_weapon(weapon)) {
    level.globalkillstreaksdeathsfrom++;
  }
}

function private update_weapon_stats(attacker, weapon, smeansofdeath, inflictor) {
  if(isPlayer(attacker) && attacker != self && (!level.teambased || self util::isenemyteam(attacker.team))) {
    attackerweaponpickedup = 0;

    if(isDefined(attacker.pickedupweapons) && isDefined(attacker.pickedupweapons[weapon])) {
      attackerweaponpickedup = 1;
    }

    self stats::function_eec52333(weapon, #"deaths", 1, self.class_num, attackerweaponpickedup);
    var_bb166c5e = stats::function_3f64434(weapon);
    self stats::function_622feb0d(var_bb166c5e, #"deaths", 1);
    victim_weapon = self.lastdroppableweapon;

    if(isDefined(victim_weapon)) {
      victimweaponpickedup = 0;

      if(isDefined(self.pickedupweapons) && isDefined(self.pickedupweapons[victim_weapon])) {
        victimweaponpickedup = 1;
      }

      self stats::function_eec52333(victim_weapon, #"deathsduringuse", 1, self.class_num, victimweaponpickedup);
      level thread telemetry::function_18135b72(#"hash_b88b6d2e0028e13", {
        #player: self, #weapon: victim_weapon, #statname: # "deathsduringuse", #value: 1, #weaponpickedup: victimweaponpickedup
      });
    }

    recordweaponstatkills = 1;

    if(attacker.isthief === 1 && isDefined(weapon) && weapon.isheroweapon === 1) {
      recordweaponstatkills = 0;
    }

    if(smeansofdeath != "MOD_FALLING" && recordweaponstatkills) {
      if(weapon.name == # "explosive_bolt" && isDefined(inflictor) && isDefined(inflictor.ownerweaponatlaunch) && inflictor.owneradsatlaunch) {
        inflictorownerweaponatlaunchpickedup = 0;

        if(isDefined(attacker.pickedupweapons) && isDefined(attacker.pickedupweapons[inflictor.ownerweaponatlaunch])) {
          inflictorownerweaponatlaunchpickedup = 1;
        }

        attacker stats::function_eec52333(inflictor.ownerweaponatlaunch, #"kills", 1, attacker.class_num, inflictorownerweaponatlaunchpickedup, 1);
        level thread telemetry::function_18135b72(#"hash_b88b6d2e0028e13", {
          #player: attacker, #weapon: inflictor.ownerweaponatlaunch, #statname: # "kills", #value: 1, #weaponpickedup: inflictorownerweaponatlaunchpickedup
        });
      } else {
        attacker stats::function_eec52333(weapon, #"kills", 1, attacker.class_num, attackerweaponpickedup);
        attacker stats::function_80099ca1(weapon.name, #"best_kills");
        attacker stats::function_e24eec31(weapon, #"hash_49b586d05aaa0209", 1);
        level thread telemetry::function_18135b72(#"hash_b88b6d2e0028e13", {
          #player: attacker, #weapon: weapon, #statname: # "kills", #value: 1, #weaponpickedup: attackerweaponpickedup
        });
      }
    }

    if(smeansofdeath == "MOD_HEAD_SHOT") {
      attacker stats::function_eec52333(weapon, #"headshots", 1, attacker.class_num, attackerweaponpickedup);

      if(weapon.statname === # "special_crossbow_t9") {
        attacker stats::function_e24eec31(weapon, #"destroy_any", 1);
      }

      level thread telemetry::function_18135b72(#"hash_b88b6d2e0028e13", {
        #player: attacker, #weapon: weapon, #statname: # "headshots", #value: 1, #weaponpickedup: attackerweaponpickedup
      });
    }

    if(smeansofdeath == "MOD_PROJECTILE") {
      attacker stats::function_e24eec31(weapon, #"direct_hit_kills", 1);
    }
  }
}

function function_a3030357(attacker, einflictor, weapon, smeansofdeath, bledout, var_bee367e6) {
  if(self.var_4ef33446) {
    return;
  }

  if(!isPlayer(einflictor) || self util::isenemyplayer(einflictor) == 0 || isDefined(smeansofdeath) && killstreaks::is_killstreak_weapon(smeansofdeath)) {
    level notify(#"reset_obituary_count");
    level.lastobituaryplayercount = 0;
    level.lastobituaryplayer = undefined;
  } else {
    if(isDefined(level.lastobituaryplayer) && level.lastobituaryplayer == einflictor) {
      level.lastobituaryplayercount++;
    } else {
      level notify(#"reset_obituary_count");
      level.lastobituaryplayer = einflictor;
      level.lastobituaryplayercount = 1;
    }

    level thread scoreevents::decrementlastobituaryplayercountafterfade();

    if(level.lastobituaryplayercount >= 4) {
      level notify(#"reset_obituary_count");
      level.lastobituaryplayercount = 0;
      level.lastobituaryplayer = undefined;
      self thread scoreevents::uninterruptedobitfeedkills(einflictor, smeansofdeath);
    }
  }

  overrideentitycamera = function_c0f28ff9(einflictor, smeansofdeath);
  var_50d1e41a = potm::function_775b9ad1(smeansofdeath, bledout);
  var_e9d49a33 = function_faf77690(smeansofdeath, weapon, einflictor);

  if(isDefined(weapon) && weapon.archetype === "robot") {
    if(bledout == "MOD_HIT_BY_OBJECT") {
      smeansofdeath = getweapon(#"combat_robot_marker");
    }

    bledout = "MOD_RIFLE_BULLET";
  }

  if(var_bee367e6) {
    bledout = "MOD_BLED_OUT";
  }

  var_f87dccb5 = self util::isenemyteam(einflictor.team);

  if(level.teambased && isDefined(einflictor.pers) && !var_f87dccb5 && bledout == "MOD_GRENADE" && level.friendlyfire == 0) {
    obituary(self, self, smeansofdeath, bledout);
    demo::kill_bookmark(self, self, weapon, var_50d1e41a, overrideentitycamera);

    if(!var_e9d49a33) {
      potm::kill_bookmark(self, self, weapon, var_50d1e41a, overrideentitycamera);
    }

    return;
  }

  obituary(self, einflictor, smeansofdeath, bledout);
  demo::kill_bookmark(einflictor, self, weapon, var_50d1e41a, overrideentitycamera);

  if(!var_e9d49a33) {
    potm::kill_bookmark(einflictor, self, weapon, var_50d1e41a, overrideentitycamera);
  }
}

function function_faf77690(weapon, einflictor, attacker) {
  var_e9d49a33 = 0;

  if(level.gametype === "spy" && weapon === getweapon(#"cobra_20mm_comlink")) {
    return var_e9d49a33;
  }

  if(isDefined(weapon) && killstreaks::is_killstreak_weapon(weapon)) {
    var_e9d49a33 = 1;
  }

  if(isDefined(einflictor) && (is_true(einflictor.var_e9d49a33) || isDefined(einflictor.owner) && is_true(einflictor.owner.var_e9d49a33))) {
    var_e9d49a33 = 1;
  }

  var_f87dccb5 = self util::isenemyteam(attacker.team);

  if(self != attacker && !var_f87dccb5) {
    var_e9d49a33 = 1;
  }

  return var_e9d49a33;
}

function function_c0f28ff9(attacker, weapon) {
  overrideentitycamera = 0;

  if(!isDefined(weapon)) {
    return overrideentitycamera;
  }

  if(killstreaks::is_killstreak_weapon(weapon)) {
    overrideentitycamera = killstreaks::should_override_entity_camera_in_demo(attacker, weapon);
  }

  return overrideentitycamera;
}

function private player_suicide(einflictor, attacker, smeansofdeath, weapon, shitloc) {
  awardassists = 0;
  self.suicide = 0;

  if(isDefined(self.switching_teams)) {
    if(!level.teambased && isDefined(level.teams[self.leaving_team]) && isDefined(level.teams[self.joining_team]) && level.teams[self.leaving_team] != level.teams[self.joining_team]) {
      playercounts = self teams::count_players();
      playercounts[self.leaving_team]--;
      playercounts[self.joining_team]++;

      if(playercounts[self.joining_team] - playercounts[self.leaving_team] > 1) {
        scoreevents::processscoreevent(#"suicide", self, undefined, undefined);
        self globallogic_score::incpersstat(#"suicides", 1);
        self.suicides = self globallogic_score::getpersstat(#"suicides");
        self.suicide = 1;
      }
    }
  } else {
    scoreevents::processscoreevent(#"suicide", self);
    self globallogic_score::incpersstat(#"suicides", 1);
    self.suicides = self globallogic_score::getpersstat(#"suicides");

    if(smeansofdeath === "MOD_SUICIDE" && shitloc === "none" && is_true(self.throwinggrenade)) {
      self.lastgrenadesuicidetime = gettime();
    }

    if(level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
      self notify(#"teamkillkicked");
      self function_3c238bc5();
    }

    awardassists = 1;
    self.suicide = 1;
  }

  if(isDefined(self.friendlydamage)) {
    self iprintln(#"mp/friendly_fire_will_not");

    if(level.teamkillpointloss) {
      scoresub = self[[level.getteamkillscore]](einflictor, attacker, smeansofdeath, weapon);
      globallogic_score::function_17a678b7(attacker, scoresub);
    }
  }

  return awardassists;
}

function private team_kill(einflictor, attacker, smeansofdeath, weapon, shitloc) {
  scoreevents::processscoreevent(#"team_kill", smeansofdeath, undefined, shitloc);
  self.teamkilled = 1;

  if(!ignore_team_kills(shitloc, weapon, attacker)) {
    teamkill_penalty = self[[level.getteamkillpenalty]](attacker, smeansofdeath, weapon, shitloc);
    smeansofdeath globallogic_score::incpersstat(#"teamkills_nostats", teamkill_penalty, 0);
    smeansofdeath globallogic_score::incpersstat(#"teamkills", 1);

    if(!isDefined(smeansofdeath.teamkillsthisround)) {
      smeansofdeath.teamkillsthisround = 0;
    }

    smeansofdeath.teamkillsthisround++;

    if(level.friendlyfire == 4 && smeansofdeath.pers[# "teamkills_nostats"] == level.var_fe3ff9c1) {
      smeansofdeath.var_e03ca8a5 = 1;
    }

    if(level.teamkillpointloss) {
      scoresub = self[[level.getteamkillscore]](attacker, smeansofdeath, weapon, shitloc);
      globallogic_score::function_17a678b7(smeansofdeath, scoresub);
    }

    if(globallogic_utils::gettimepassed() < 5000) {
      var_821200bb = 1;
    } else if(smeansofdeath.pers[# "teamkills_nostats"] > 1 && globallogic_utils::gettimepassed() < int((8 + smeansofdeath.pers[# "teamkills_nostats"]) * 1000)) {
      var_821200bb = 1;
    } else {
      var_821200bb = smeansofdeath function_821200bb();
    }

    var_20010f49 = level.var_73e51905 === 1 && !gamemodeisarena();

    if(var_821200bb > 0 && !var_20010f49) {
      smeansofdeath.teamkillpunish = 1;
      smeansofdeath thread wait_and_suicide();

      if(smeansofdeath function_78a6af2d(var_821200bb)) {
        smeansofdeath notify(#"teamkillkicked");
        smeansofdeath thread function_dd602974();
      }

      smeansofdeath thread function_a932bf9c();
    }
  }
}

function private wait_and_suicide() {
  self endon(#"disconnect");
  self val::set(#"wait_and_suicide", "freezecontrols");
  wait 0.25;
  self val::reset(#"wait_and_suicide", "freezecontrols");
  self suicide();
}

function private function_48a1200f(einflictor, attacker, weapon) {
  pixbeginevent(#"");

  if(isDefined(self.attackers)) {
    for(j = 0; j < self.attackers.size; j++) {
      player = self.attackers[j];

      if(!isDefined(player)) {
        continue;
      }

      if(player == attacker) {
        continue;
      }

      if(player util::isenemyteam(attacker.team)) {
        continue;
      }

      damage_done = self.attackerdamage[player.clientid].damage;

      if(sessionmodeismultiplayergame() && isDefined(player.currentweapon)) {
        function_92d1707f(#"hash_d1357992f4715f0", {
          #gametime: function_f8d53445(), #assistspawnid: getplayerspawnid(player), #assistspecialist: function_b14806c6(player player_role::get(), currentsessionmode()), #assistweapon: player.currentweapon.name
        });
      }

      player thread globallogic_score::processassist(self, damage_done, self.attackerdamage[player.clientid].weapon, self.attackerdamage[player.clientid].time, self.attackerdamage[player.clientid].smeansofdeath);
    }
  }

  if(level.teambased) {
    self globallogic_score::function_c2ea00b2(attacker, einflictor, weapon);
  }

  if(isDefined(self.lastattackedshieldplayer) && isDefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != attacker) {
    if(gettime() - self.lastattackedshieldtime < 4000) {
      self.lastattackedshieldplayer thread globallogic_score::processshieldassist(self);
    }
  }

  pixendevent();
}

function function_f632c17e(weapon) {
  if(isDefined(weapon) && isDefined(level.iskillstreakweapon) && [[level.iskillstreakweapon]](weapon)) {
    return true;
  }

  if(isDefined(weapon) && isDefined(weapon.statname) && isDefined(level.iskillstreakweapon) && [[level.iskillstreakweapon]](getweapon(weapon.statname))) {
    return true;
  }

  switch (weapon.name) {
    case # "ar_accurate_t8_swat":
    case # "hash_17df39d53492b0bf":
    case # "tank_robot_launcher_turret":
    case # "ac130_chaingun":
    case # "hash_7b24d0d0d2823bca":
      return true;
  }

  return false;
}

function private function_4e3e8bee(einflictor, attacker, smeansofdeath, weapon, var_e7a369ea) {
  attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self, var_e7a369ea);
  killstreak = killstreaks::get_killstreak_for_weapon(weapon);
  var_7414b854 = self function_63aa4562();

  if(isDefined(killstreak)) {
    if(scoreevents::isregisteredevent(killstreak)) {
      scoreevents::processscoreevent(killstreak, attacker, self, weapon);
    }

    if(isDefined(einflictor)) {
      bundle = einflictor killstreak_bundles::function_48e9536e();

      if(isDefined(bundle) && is_true(bundle.var_ad1e41b)) {
        scoreevents::processscoreevent(#"ekia", attacker, self, weapon);
      }

      if(killstreak == "dart" || killstreak == "inventory_dart") {
        einflictor notify(#"veh_collision");
        callback::callback(#"veh_collision", {
          #normal: (0, 0, 1)
        });
      }
    }

    if(weapon.iscarriedkillstreak === 1) {
      if(!isDefined(attacker.var_8e94d71c)) {
        attacker.var_8e94d71c = [];
      }

      if(!isDefined(attacker.var_8e94d71c[weapon])) {
        attacker.var_8e94d71c[weapon] = 0;
      }

      attacker.var_8e94d71c[weapon]++;
      attacker contracts::increment_contract(#"hash_1c65fc76b2b14014");

      if(isDefined(attacker.var_63fa6458[killstreak])) {
        attacker.var_63fa6458[killstreak].kills++;
      }

      if(var_e7a369ea != attacker) {
        scoreevents::processscoreevent(#"ekia", attacker, self, weapon);
      }
    } else if(isDefined(einflictor.killstreakid)) {
      if(!isDefined(level.scorestreak_kills[einflictor.killstreakid])) {
        level.scorestreak_kills[einflictor.killstreakid] = 0;
      }

      level.scorestreak_kills[einflictor.killstreakid]++;

      if(isDefined(attacker.var_9fa3bd36[einflictor.killstreakid])) {
        attacker.var_9fa3bd36[einflictor.killstreakid].kills++;
      }
    }
  } else if(!function_f632c17e(weapon)) {
    if(var_e7a369ea == attacker) {
      if(isDefined(self.laststandparams)) {
        if(isDefined(self.var_a1d415ee) && self.laststandparams.attacker !== self.var_a1d415ee.attacker) {
          scoreevents::processscoreevent(#"kill", self.laststandparams.attacker, self, self.laststandparams.weapon);
          scoreevents::processscoreevent(#"cleaned_up", self.var_a1d415ee.attacker, self, self.var_a1d415ee.weapon);
          scoreevents::processscoreevent(#"hash_3a4044777bf1a070", self.var_a1d415ee.attacker, self, self.var_a1d415ee.weapon);
        } else {
          scoreevents::processscoreevent(#"kill", attacker, self, weapon);
        }
      } else {
        scoreevents::processscoreevent(#"kill", attacker, self, weapon);
      }
    } else {
      scoreevents::processscoreevent(#"ekia", attacker, self, weapon);
    }
  }

  damage = self function_40c6c42d(attacker);

  if(var_7414b854 && is_true(getgametypesetting(#"hash_1d4b880b345fe1ac"))) {
    function_f887b191(self, attacker, damage, 4);
  } else {
    function_f887b191(self, attacker, damage);
  }

  attacker thread globallogic_score::trackattackerkill(self.name, self.pers[# "rank"], self.pers[# "rankxp"], self.pers[# "prestige"], self getxuid(), weapon);
  attacker thread globallogic_score::inckillstreaktracker(weapon);
}

function function_63aa4562() {
  teammates = getplayers(self.team);

  foreach(teammate in teammates) {
    if(isalive(teammate) && !teammate laststand::player_is_in_laststand()) {
      return false;
    }
  }

  return true;
}

function private kill(einflictor, attacker, smeansofdeath, weapon, shitloc) {
  if(!isDefined(killstreaks::get_killstreak_for_weapon(shitloc)) || is_true(level.killstreaksgivegamescore)) {
    globallogic_score::inctotalkills(smeansofdeath.team);
  }

  attackername = smeansofdeath.name;
  self thread globallogic_score::trackattackeedeath(attackername, smeansofdeath.pers[# "rank"], smeansofdeath.pers[# "rankxp"], smeansofdeath.pers[# "prestige"], smeansofdeath getxuid());
  self thread medals::setlastkilledby(smeansofdeath, attacker);

  if(level.teambased && smeansofdeath.team != # "spectator") {
    killstreak = killstreaks::get_killstreak_for_weapon(shitloc);

    if(!isDefined(killstreak) || is_true(level.killstreaksgivegamescore)) {
      globallogic_score::giveteamscore("kill", smeansofdeath.team);
    }
  }

  scoresub = level.deathpointloss;

  if(scoresub != 0) {
    globallogic_score::function_17a678b7(self, scoresub);
  }

  level thread function_e8decd0b(smeansofdeath, shitloc, self, attacker, weapon);
}

function private should_allow_postgame_death(smeansofdeath) {
  if(smeansofdeath == "MOD_POST_GAME") {
    return true;
  }

  return false;
}

function private post_game_death(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!should_allow_postgame_death(weapon)) {
    return;
  }

  self weapons::detach_carry_object_model();
  self.sessionstate = "dead";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  clone_weapon = vdir;

  if(weapons::ismeleemod(weapon) && clone_weapon.type != "melee") {
    clone_weapon = level.weaponnone;
  }

  body = self cloneplayer(deathanimduration, clone_weapon, idamage, shitloc);

  if(isDefined(body)) {
    body notsolid();
    vattacker = isDefined(idamage) ? idamage : self;
    death_params = {
      #victimorigin: self.origin, #victimangles: self getplayerangles(), #victimweapon: self.currentweapon, #einflictor: attacker, #attacker: idamage, #attackerorigin: vattacker.origin, #attackerangles: isPlayer(vattacker) ? vattacker getplayerangles() : vattacker.angles, #idamage: smeansofdeath, #smeansofdeath: weapon, #weapon: vdir, #vdir: shitloc, #shitloc: psoffsettime, #matchtime: function_f8d53445()
    };
    self create_body(death_params, (0, 0, 0), deathanimduration, body);
  }
}

function private function_395ef176() {
  self endon(#"disconnect");
  var_8f42b3ff = 10 - getplayers(self.team).size;
  var_65671d4a = level.numteamlives - var_8f42b3ff;

  if(is_true(level.teambased) && is_true(level.takelivesondeath) && level.numteamlives > 0) {
    enemy_team = util::getotherteam(self.team);
    teamarray = getplayers(self.team);

    if(game.lives[self.team] == 0 && !level.var_61952d8b[self.team]) {
      level.var_61952d8b[self.team] = 1;
      level.var_a236b703[self.team] = 1;
      thread globallogic_audio::leader_dialog("controlNoLives", self.team);
      thread globallogic_audio::leader_dialog("controlNoLivesEnemy", enemy_team);
      clientfield::set_world_uimodel("hudItems.team" + level.teamindex[self.team] + ".noRespawnsLeft", 1);
      level notify(#"hash_15b8b6edc4ed3032", {
        #var_7090bf53: 1
      });
      game.lives[self.team] = 0;
      level.var_9161927e[self.team] = teamarray.size;
      teammates = function_a1ef346b(self.team);

      foreach(player in teammates) {
        player luinotifyevent(#"hash_6b67aa04e378d681", 1, 7);
      }

      util::function_a3f7de13(24, self.team);
    }

    if(level.deaths[self.team] >= var_65671d4a && !level.var_a236b703[self.team]) {
      level.var_a236b703[self.team] = 1;
      thread globallogic_audio::leader_dialog("controlLowLives", self.team);
      thread globallogic_audio::leader_dialog("controlLowLivesEnemy", enemy_team);
    }

    if(isDefined(level.var_9161927e) && isDefined(level.var_9161927e[self.team])) {
      if(level.var_9161927e[self.team] > 0) {
        teammates = function_a1ef346b(self.team);

        foreach(player in teammates) {
          player luinotifyevent(#"hash_6b67aa04e378d681", 2, 1, level.var_9161927e[self.team]);
        }
      }

      if(level.var_9161927e[self.team] == 1) {
        thread globallogic_audio::leader_dialog("roundEncourageLastPlayer", self.team);
        thread globallogic_audio::leader_dialog("roundEncourageLastPlayerEnemy", enemy_team);
      }

      level.var_9161927e[self.team]--;
    }

    function_c49fc862(self.team);
    return;
  }

  clientfield::set_player_uimodel("hudItems.playerLivesCount", level.numlives - self.var_a7d7e50a);

  if(is_true(level.var_4348a050)) {
    var_e6caaa48 = level.playerlives[# "allies"];
    var_5724b72f = level.playerlives[# "axis"];

    if(level.gametype == "sd" && userspawnselection::function_127864f2(self)) {
      return;
    }

    if(var_e6caaa48 > 0 && var_5724b72f > 0) {
      foreach(player in function_a1ef346b()) {
        if(!isDefined(player)) {
          continue;
        }

        player luinotifyevent(#"hash_6b67aa04e378d681", 3, 2, var_e6caaa48, var_5724b72f);
      }
    }
  }
}

function private function_5c5a8dad(lives) {
  if(lives == 0) {
    level notify(#"player_eliminated");
    self notify(#"player_eliminated");
  }
}

function private start_generator_captureshouldshowpain() {
  if(!is_true(level.takelivesondeath)) {
    self function_5c5a8dad(self.pers[# "lives"]);
    return;
  }

  if(is_true(self.var_cee93f5)) {
    return;
  }

  if(game.lives[self.team] > 0) {
    if(is_true(level.competitiveteamlives)) {} else if(self.attackers.size < 1) {
      return;
    } else {
      foreach(attacker in self.attackers) {
        if(!isDefined(attacker)) {
          continue;
        }

        if(attacker.team != self.team) {
          removelives = 1;
          break;
        }
      }

      if(!is_true(removelives)) {
        return;
      }
    }

    game.lives[self.team]--;

    if(self.pers[# "lives"] == 0) {
      self function_5c5a8dad(game.lives[self.team]);
    }

    return;
  }

  if(self.pers[# "lives"]) {
    self.pers[# "lives"]--;
    self function_5c5a8dad(self.pers[# "lives"]);
  }
}

function private create_body(death_params, vattackerorigin, deathanimduration, body) {
  if(death_params.smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone") {
    self.body = body;

    if(!isDefined(self.switching_teams)) {
      thread deathicons::add(body, self, self.team);
    }

    return;
  }

  if(isDefined(level.ragdoll_override) && self[[level.ragdoll_override]](death_params.idamage, death_params.smeansofdeath, death_params.weapon, death_params.shitloc, death_params.vdir, vattackerorigin, deathanimduration, death_params.einflictor, 0, body)) {
    return;
  }

  if(self isonladder() || self function_b4813488() || self isziplining() || self ismantling() || death_params.smeansofdeath == "MOD_CRUSH" || death_params.smeansofdeath == "MOD_HIT_BY_OBJECT") {
    body startragdoll();
  }

  if(!self isonground() && death_params.smeansofdeath != "MOD_FALLING") {
    if(getdvarint(#"scr_disable_air_death_ragdoll", 0) == 0) {
      body startragdoll();
    }
  }

  if(death_params.smeansofdeath == "MOD_MELEE_ASSASSINATE" && !death_params.attacker isonground()) {
    body start_death_from_above_ragdoll(death_params.vdir);
  }

  if(self is_explosive_ragdoll(death_params.weapon, death_params.einflictor)) {
    body start_explosive_ragdoll(death_params.vdir, death_params.weapon);
  }

  thread delayed_ragdoll(body, death_params.shitloc, death_params.vdir, death_params.weapon, death_params.einflictor, death_params.smeansofdeath);

  if(death_params.smeansofdeath == "MOD_CRUSH") {
    body globallogic_vehicle::vehiclecrush(death_params.attacker, death_params.einflictor);
  }

  hidedeathicon = isPlayer(death_params.attacker) && death_params.attacker hasperk(#"hash_67340eb8c5d0f17f");
  self.body = body;

  if(!isDefined(self.switching_teams) && !hidedeathicon) {
    thread deathicons::add(body, self, self.team);
  }

  body.player = self;
  body.iscorpse = 1;
  self.body callback::callback(#"on_player_corpse", death_params);
}

function private should_drop_weapon_on_death(wasteamkill, wassuicide, current_weapon, smeansofdeath) {
  if(wasteamkill) {
    return false;
  }

  if(wassuicide) {
    return false;
  }

  if(smeansofdeath == "MOD_TRIGGER_HURT" && !self isonground()) {
    return false;
  }

  if(isDefined(current_weapon) && current_weapon.isheavyweapon) {
    return false;
  }

  return true;
}

function private function_8826f676() {
  if(isbot(self)) {
    level.globallarryskilled++;
  }
}

function private function_f9dc085a() {
  if(isDefined(self.killstreak_delay_killcam)) {
    while(isDefined(self.killstreak_delay_killcam)) {
      wait 0.1;
    }

    wait 2;
    self killstreaks::reset_killstreak_delay_killcam();
  }
}

function private function_3c238bc5() {
  self globallogic_score::incpersstat(#"sessionbans", 1);
  self endon(#"disconnect");
  waittillframeend();
  globallogic::gamehistoryplayerkicked();
  ban(self getentitynumber());
  globallogic_audio::leader_dialog("gamePlayerKicked");
}

function private function_dd602974() {
  self globallogic_score::incpersstat(#"sessionbans", 1);
  self endon(#"disconnect");
  waittillframeend();
  playlistbanquantum = tweakables::gettweakablevalue("team", "teamkillerplaylistbanquantum");
  playlistbanpenalty = tweakables::gettweakablevalue("team", "teamkillerplaylistbanpenalty");

  if(playlistbanquantum > 0 && playlistbanpenalty > 0) {
    timeplayedtotal = self stats::get_stat_global(#"time_played_total");
    minutesplayed = timeplayedtotal / 60;
    freebees = 2;
    banallowance = int(floor(minutesplayed / playlistbanquantum)) + freebees;

    if(self globallogic_score::getpersstat(#"sessionbans") > banallowance) {
      self stats::set_stat_global(#"gametypeban", timeplayedtotal + playlistbanpenalty * 60);
    }
  }

  globallogic::gamehistoryplayerkicked();
  ban(self getentitynumber(), "EXE/PLAYERKICK_TEAM_KILL");
  globallogic_audio::leader_dialog("gamePlayerKicked");
}

function function_821200bb() {
  teamkills = self.pers[# "teamkills_nostats"];

  if(level.friendlyfire == 4) {
    if(teamkills < level.var_fe3ff9c1) {
      return 0;
    } else {
      exceeded = teamkills - level.var_fe3ff9c1 - 1;
      return (level.var_ca1c5097 + level.var_2c3d094b * exceeded);
    }

    return;
  }

  if(level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills) {
    return 0;
  }

  exceeded = teamkills - level.minimumallowedteamkills;
  return level.teamkillspawndelay * exceeded;
}

function private function_78a6af2d(var_821200bb) {
  if(isbot(self)) {
    return false;
  }

  if(level.friendlyfire == 4) {
    if(self.pers[# "teamkills_nostats"] >= level.var_fe3ff9c1 + level.var_3297fce5) {
      return true;
    }

    return false;
  }

  if(var_821200bb && level.minimumallowedteamkills >= 0) {
    if(globallogic_utils::gettimepassed() >= 5000) {
      return true;
    }

    if(self.pers[# "teamkills_nostats"] > 1) {
      return true;
    }
  }

  return false;
}

function function_a932bf9c() {
  if(level.friendlyfire == 4) {
    return;
  }

  timeperoneteamkillreduction = 20;
  reductionpersecond = 1 / timeperoneteamkillreduction;

  while(true) {
    if(isalive(self)) {
      self.pers[# "teamkills_nostats"] -= reductionpersecond;

      if(self.pers[# "teamkills_nostats"] < level.minimumallowedteamkills) {
        self.pers[# "teamkills_nostats"] = level.minimumallowedteamkills;
        break;
      }
    }

    wait 1;
  }
}

function private ignore_team_kills(weapon, smeansofdeath, einflictor) {
  if(weapons::ismeleemod(smeansofdeath)) {
    return false;
  }

  if(weapon.ignore_team_kills === 1 || weapon.ignoreteamkills === 1) {
    return true;
  }

  if(isDefined(einflictor) && einflictor.ignore_team_kills === 1) {
    return true;
  }

  if(isDefined(einflictor) && isDefined(einflictor.destroyedby) && isDefined(einflictor.owner) && einflictor.destroyedby != einflictor.owner) {
    return true;
  }

  if(isDefined(einflictor) && einflictor.classname == "worldspawn") {
    return true;
  }

  return false;
}

function private is_explosive_ragdoll(weapon, inflictor) {
  if(!isDefined(weapon)) {
    return false;
  }

  if(weapon.name == # "destructible_car" || weapon.name == # "explodable_barrel") {
    return true;
  }

  if(weapon.projexplosiontype == "grenade") {
    if(isDefined(inflictor) && isDefined(inflictor.stucktoplayer)) {
      if(inflictor.stucktoplayer == self) {
        return true;
      }
    }
  }

  return false;
}

function private start_explosive_ragdoll(dir, weapon) {
  if(!isDefined(self)) {
    return;
  }

  x = randomintrange(50, 100);
  y = randomintrange(50, 100);
  z = randomintrange(10, 20);

  if(isDefined(weapon) && (weapon.name == # "sticky_grenade" || weapon.name == # "explosive_bolt")) {
    if(isDefined(dir) && lengthsquared(dir) > 0) {
      x = dir[0] * x;
      y = dir[1] * y;
    }
  } else {
    if(math::cointoss()) {
      x *= -1;
    }

    if(math::cointoss()) {
      y *= -1;
    }
  }

  self startragdoll();
  self launchragdoll((x, y, z));
}

function private start_death_from_above_ragdoll(dir) {
  if(!isDefined(self)) {
    return;
  }

  self startragdoll();
  self launchragdoll((0, 0, -100));
}

function private delayed_ragdoll(ent, shitloc, vdir, weapon, einflictor, smeansofdeath) {
  if(isDefined(smeansofdeath)) {
    if(is_true(smeansofdeath.var_6f9e9dc9)) {
      if(!smeansofdeath isragdoll()) {
        smeansofdeath startragdoll();
      }

      return;
    }

    deathanim = smeansofdeath getcorpseanim();

    if(isDefined(deathanim) && animhasnotetrack(deathanim, "ignore_ragdoll")) {
      return;
    }
  }

  waittillframeend();

  if(!isDefined(smeansofdeath)) {
    return;
  }

  if(smeansofdeath isragdoll()) {
    return;
  }

  deathanim = smeansofdeath getcorpseanim();

  if(!isDefined(deathanim) || animhasnotetrack(deathanim, "ignore_ragdoll")) {
    return;
  }

  startfrac = 0.35;

  if(animhasnotetrack(deathanim, "start_ragdoll")) {
    times = getnotetracktimes(deathanim, "start_ragdoll");

    if(isDefined(times)) {
      startfrac = times[0];
    }
  }

  waittime = startfrac * getanimlength(deathanim);

  if(waittime > 0) {
    wait waittime;
  }

  if(isDefined(smeansofdeath)) {
    smeansofdeath startragdoll();
  }
}

function private update_attacker(attacker, weapon) {
  if(isai(attacker) && isDefined(attacker.script_owner)) {
    if(!level.teambased || self util::isenemyteam(attacker.script_owner.team)) {
      attacker = attacker.script_owner;
    }
  }

  if(attacker.classname == "script_vehicle" && isDefined(attacker.owner)) {
    attacker notify(#"killed", {
      #victim: self
    });
    attacker = attacker.owner;
  }

  if(isai(attacker)) {
    attacker notify(#"killed", {
      #victim: self
    });
  }

  if(isDefined(self.capturinglastflag) && self.capturinglastflag == 1) {
    attacker.lastcapkiller = 1;
  }

  if(isDefined(attacker) && attacker != self && isDefined(weapon)) {
    if(weapon.statname == # "planemortar") {
      if(!isDefined(attacker.planemortarbda)) {
        attacker.planemortarbda = 0;
      }

      attacker.planemortarbda++;
    } else if(weapon.statname == # "dart" || weapon.statname == # "dart_turret") {
      if(!isDefined(attacker.dartbda)) {
        attacker.dartbda = 0;
      }

      attacker.dartbda++;
    } else if(weapon.name == # "straferun_rockets" || weapon.name == # "straferun_gun") {
      if(isDefined(attacker.straferunbda)) {
        attacker.straferunbda++;
      }
    } else if(weapon.statname == # "remote_missile" || weapon.statname == # "remote_missile_missile" || weapon.name == # "remote_missile_bomblet") {
      if(!isDefined(attacker.remotemissilebda)) {
        attacker.remotemissilebda = 0;
      }

      attacker.remotemissilebda++;
    }
  }

  if(isDefined(attacker) && isPlayer(attacker) && isDefined(self.clientid)) {
    if(!isDefined(attacker.damagedplayers)) {
      attacker.damagedplayers = [];
    }

    attacker.damagedplayers[self.clientid] = undefined;
  }

  return attacker;
}

function private function_813829e3(einflictor) {
  if(isDefined(einflictor) && einflictor.classname == "script_vehicle") {
    einflictor notify(#"killed", {
      #victim: self
    });

    if(isDefined(einflictor.bda)) {
      einflictor.bda++;
    }
  }
}

function private update_weapon(einflictor, weapon) {
  if(weapon == level.weaponnone && isDefined(einflictor)) {
    if(isDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
      weapon = getweapon(#"explodable_barrel");
    } else if(isDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
      weapon = getweapon(#"destructible_car");
    }
  }

  return weapon;
}

function private function_e8decd0b(attacker, weapon, victim, einflictor, smeansofdeath) {
  if(isPlayer(attacker) && smeansofdeath !== "MOD_EXECUTION") {
    if(!killstreaks::is_killstreak_weapon(weapon) || killstreaks::function_e3a30c69(weapon)) {
      attackerentnum = attacker getentitynumber();
      var_46604f00 = level.var_648e79b7[attackerentnum];

      if(attacker.var_d853c1af === 1 || !isDefined(var_46604f00)) {
        statname = # "hash_23e04a595aa862a";
        var_46604f00 = {
          #statname: statname, #timestamp: gettime() + level.var_42648a02[statname][3], #weapon: weapon, #victim: victim, #inflictor: einflictor
        };
        level.var_648e79b7[attackerentnum] = var_46604f00;
      }
    }
  }

  if(isDefined(einflictor)) {
    bhtnactionstartevent(einflictor, "attack_kill");
    einflictor notify(#"bhtn_action_notify", {
      #action: "attack_kill"});
  }

  level notify(#"hash_6c17824062de93e5");
}

function updatekillstreak(einflictor, attacker, weapon) {
  if(isalive(attacker)) {
    pixbeginevent(#"");

    if(!isDefined(einflictor) || !isDefined(einflictor.requireddeathcount) || attacker.deathcount == einflictor.requireddeathcount) {
      shouldgivekillstreak = killstreaks::should_give_killstreak(weapon);
      shouldgivekillstreak &= !attacker isinvehicle();

      if(shouldgivekillstreak) {
        attacker killstreaks::add_to_killstreak_count(weapon);
      }

      attacker.pers[# "cur_total_kill_streak"]++;
      attacker setplayercurrentstreak(attacker.pers[# "cur_total_kill_streak"]);

      if(isDefined(level.killstreaks) && shouldgivekillstreak) {
        attacker.pers[# "cur_kill_streak"]++;
        var_6456e8ec = attacker.pers[# "cur_kill_streak"];

        if(attacker.pers[# "cur_kill_streak"] > attacker.pers[# "hash_763287bc117e302f"]) {
          attacker.pers[# "hash_763287bc117e302f"] = attacker.pers[# "cur_kill_streak"];

          if(level.onlinegame) {
            var_49174772 = (attacker.pers[# "hash_6f1b3f108570635b"] * attacker.pers[# "hash_20893916fb58d59f"] + attacker.pers[# "hash_763287bc117e302f"]) / (attacker.pers[# "hash_20893916fb58d59f"] + 1);
            attacker stats::function_baa25a23(#"average_kill_streak", int(var_49174772 + 0.5));
            attacker.pers[# "hash_222259801297f7c3"] = var_49174772;
          }
        }

        if(var_6456e8ec >= 2) {
          attacker stats::function_dad108fa(#"hash_282c9a3c92912ce6", 1);
          attacker stats::function_dad108fa(#"hash_3cd0e341588351df", 1);

          if(var_6456e8ec % 3 == 0) {
            attacker contracts::increment_contract(#"hash_7421121f0a9bbb59");
            attacker contracts::increment_contract(#"hash_5dbc64ebf45c8ee3");
            attacker stats::function_dad108fa(#"hash_1e44ac63ebde7a17", 1);
            attacker stats::function_bcf9602(#"hash_7e82640bedc5ea04", 1, #"hash_5c49df97f4f82e12");
            attacker stats::function_42277145(#"hash_76bf5bf08a08dab1", 1);
            attacker stats::function_bcf9602(#"hash_5a973e436e73a0f", 1, #"hash_6abe83944d701459");
            attacker stats::function_42277145(#"hash_3a26c4202d86ea27", 1);
            attacker stats::function_bcf9602(#"hash_513bc8963a91d302", 1, #"hash_735ace6b22542a65");
          }

          var_c874a8ab = 0;

          if(var_6456e8ec % 5 == 0) {
            attacker activecamo::function_896ac347(weapon, #"killstreak_5", 1);
            attacker challenges::function_38ad2427(#"hash_6f392a12f973aea5", 1);
            attacker stats::function_dad108fa(#"hash_4dd8ba4e6feef49", 1);
            attacker stats::function_dad108fa(#"hash_9a724d151675675", 1);
            attacker stats::function_dad108fa(#"hash_2744901d51719355", 1);
            attacker stats::function_dad108fa(#"hash_27448e1d51718fef", 1);
            attacker stats::function_dad108fa(#"hash_5e6403da30069b30", 1);
            attacker contracts::increment_contract(#"hash_4c15367eed618401");
            attacker contracts::increment_contract(#"hash_28f8bfd8c472ba9b");
            attacker stats::function_42277145(#"hash_777764b99c34fd19", 1);
            attacker stats::function_42277145(#"hash_3d915cbfdb04556d", 1);
            var_c874a8ab = int(min(floor(var_c874a8ab / 5), 6));
          }

          if(var_6456e8ec % 10 == 0) {
            attacker challenges::killstreakten();
            attacker stats::function_dad108fa(#"hash_6ed460230fb70df8", 1);
            attacker contracts::increment_contract(#"contract_mp_merciless");
          }

          var_dbaa74e2 = {
            #notificationtype: # "streak", #var_c874a8ab: var_c874a8ab
          };

          if(var_6456e8ec <= 30) {
            var_f952d0b8 = # "killstreak_" + attacker.pers[# "cur_kill_streak"];
            scoreevents::processscoreevent(var_f952d0b8, attacker, self, weapon, undefined, var_dbaa74e2);

            if(var_6456e8ec == 30) {
              attacker challenges::killstreak_30_noscorestreaks();
              attacker killstreaks::function_edde22a8();
            }

            if(var_6456e8ec % 5 == 0) {
              attacker stats::function_cc215323(var_f952d0b8 + "_for_medal_spotlight", 1);
            }
          } else {
            scoreevents::processscoreevent(#"killstreak_more_than_30", attacker, self, weapon, undefined, var_dbaa74e2);
          }

          if(isDefined(attacker.var_ea1458aa)) {
            if(attacker.pers[# "cur_kill_streak"] >= 5 && attacker.pers[# "cur_kill_streak"] % 5 && attacker.pers[# "cur_kill_streak"] < 30 || attacker.pers[# "cur_kill_streak"] > 30) {
              if(!isDefined(attacker.var_ea1458aa.var_2bad4cbb)) {
                attacker.var_ea1458aa.var_2bad4cbb = 0;
              }

              attacker.var_ea1458aa.var_2bad4cbb++;
              attacker challenges::function_a4db0a4c();
            }
          }
        }

        if(!isDefined(level.usingmomentum) || !level.usingmomentum) {
          attacker thread killstreaks::give_for_streak();
        }

        weaponclass = util::getweaponclass(weapon);
        weaponclass = isstring(weaponclass) ? hash(weaponclass) : weaponclass;

        if(weaponclass === # "weapon_pistol") {
          attacker.pers[# "hash_53c274d14dadc40b"]++;

          if(attacker.pers[# "hash_53c274d14dadc40b"] % 5 == 0) {
            attacker stats::function_dad108fa(#"hash_58e366e5dfa6f45c", 1);
          }
        }
      }
    }

    pixendevent();
  }

  if(isDefined(attacker.gametype_kill_streak) && attacker.pers[# "cur_kill_streak"] > attacker.gametype_kill_streak) {
    attacker stats::function_baa25a23(#"kill_streak", attacker.pers[# "cur_kill_streak"]);
    attacker.gametype_kill_streak = attacker.pers[# "cur_kill_streak"];
  }

  if(isDefined(attacker.var_b6f732c0) && attacker.pers[# "cur_kill_streak"] > attacker.var_b6f732c0) {
    attacker stats::set_stat_global(#"longest_killstreak", attacker.pers[# "cur_kill_streak"]);
    attacker.var_b6f732c0 = attacker.pers[# "cur_kill_streak"];
  }
}

function function_ff3ec0d4(einflictor, attacker, idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc, psoffsettime, deathanimduration) {
  foreach(callback in level.var_da2045d0) {
    if(callback.threaded) {
      self thread[[callback.callback]](attacker, idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc, psoffsettime, deathanimduration);
      continue;
    }

    profilestart();
    self[[callback.callback]](attacker, idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc, psoffsettime, deathanimduration);
    profilestop();
  }
}

function function_b8871aa2(einflictor, victim, idamage, weapon) {
  foreach(callback in level.var_fa66fada) {
    if(callback.threaded) {
      self thread[[callback.callback]](einflictor, victim, idamage, weapon);
      continue;
    }

    profilestart();
    self[[callback.callback]](einflictor, victim, idamage, weapon);
    profilestop();
  }
}