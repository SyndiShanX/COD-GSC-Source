/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\dialog_shared.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace dialog_shared;

autoexec __init__system__() {
  system::register(#"dialog_shared", &__init__, undefined, undefined);
}

__init__() {
  level thread devgui_think();

  if(!sessionmodeismultiplayergame() || !sessionmodeiswarzonegame()) {
    callback::on_joined_team(&on_joined_team);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_damage(&taking_fire_vox);
  }

  level.heroplaydialog = &play_dialog;
  level.playgadgetready = &play_gadget_ready;
  level.playgadgetactivate = &play_gadget_activate;
  level.playgadgetsuccess = &play_gadget_success;
  level.playpromotionreaction = &play_promotion_reaction;
  level.playthrowhatchet = &play_throw_hatchet;
  level.playgadgetoff = &play_gadget_off;
  level.var_da2d586a = &function_78c16252;
  level.bcsounds = [];
  level.bcsounds[#"incoming_alert"] = [];
  level.bcsounds[#"incoming_alert"][#"frag_grenade"] = "incomingFrag";
  level.bcsounds[#"incoming_alert"][#"incendiary_grenade"] = "incomingIncendiary";
  level.bcsounds[#"incoming_alert"][#"sticky_grenade"] = "incomingSemtex";
  level.bcsounds[#"incoming_alert"][#"launcher_standard"] = "threatRpg";
  level.bcsounds[#"incoming_delay"] = [];
  level.bcsounds[#"incoming_delay"][#"frag_grenade"] = "fragGrenadeDelay";
  level.bcsounds[#"incoming_delay"][#"incendiary_grenade"] = "incendiaryGrenadeDelay";
  level.bcsounds[#"incoming_alert"][#"sticky_grenade"] = "semtexDelay";
  level.bcsounds[#"incoming_delay"][#"launcher_standard"] = "missileDelay";
  level.bcsounds[#"kill_dialog"] = [];
  level.bcsounds[#"kill_dialog"][#"battery"] = "killBattery";
  level.bcsounds[#"kill_dialog"][#"buffassault"] = "killBuffAssault";
  level.bcsounds[#"kill_dialog"][#"engineer"] = "killEngineer";
  level.bcsounds[#"kill_dialog"][#"firebreak"] = "killFirebreak";
  level.bcsounds[#"kill_dialog"][#"nomad"] = "killNomad";
  level.bcsounds[#"kill_dialog"][#"prophet"] = "killProphet";
  level.bcsounds[#"kill_dialog"][#"recon"] = "killRecon";
  level.bcsounds[#"kill_dialog"][#"ruin"] = "killRuin";
  level.bcsounds[#"kill_dialog"][#"seraph"] = "killSeraph";
  level.bcsounds[#"kill_dialog"][#"swatpolice"] = "killSwatPolice";
  level.bcsounds[#"kill_dialog"][#"outrider"] = "killOutrider";
  level.bcsounds[#"kill_dialog"][#"reaper"] = "killReaper";
  level.bcsounds[#"kill_dialog"][#"spectre"] = "killSpectre";

  if(level.teambased && !isDefined(game.boostplayerspicked)) {
    game.boostplayerspicked = [];

    foreach(team, _ in level.teams) {
      game.boostplayerspicked[team] = 0;
    }
  }

  level.allowbattlechatter[#"bc"] = getgametypesetting(#"allowbattlechatter");
  clientfield::register("world", "boost_number", 1, 2, "int");
  clientfield::register("allplayers", "play_boost", 1, 2, "int");
  level thread pick_boost_number();
  keycounts = [];
  playerdialogbundles = struct::get_script_bundles("mpdialog_player");

  foreach(bundle in playerdialogbundles) {
    count_keys(keycounts, bundle, "killGeneric");
    count_keys(keycounts, bundle, "killSniper");
    count_keys(keycounts, bundle, "killBattery");
    count_keys(keycounts, bundle, "killBuffAssault");
    count_keys(keycounts, bundle, "killEngineer");
    count_keys(keycounts, bundle, "killFirebreak");
    count_keys(keycounts, bundle, "killNomad");
    count_keys(keycounts, bundle, "killProphet");
    count_keys(keycounts, bundle, "killRecon");
    count_keys(keycounts, bundle, "killRuin");
    count_keys(keycounts, bundle, "killSeraph");
    count_keys(keycounts, bundle, "killSwatPolice");
    count_keys(keycounts, bundle, "killOutrider");
    count_keys(keycounts, bundle, "killReaper");
    count_keys(keycounts, bundle, "killSpectre");
  }

  level.var_f53efe5c = keycounts;

  if(sessionmodeiswarzonegame()) {
    level.var_f53efe5c = undefined;
  }

  level.allowspecialistdialog = mpdialog_value("enableHeroDialog", 0) && isDefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"];
  level.playstartconversation = mpdialog_value("enableConversation", 0) && isDefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"];
}

flush_dialog() {
  foreach(player in level.players) {
    player flush_dialog_on_player();
  }
}

flush_dialog_on_player() {
  self.leaderdialogqueue = [];
  self.currentleaderdialog = undefined;
  self.killstreakdialogqueue = [];
  self.scorestreakdialogplaying = 0;
  self notify(#"flush_dialog");
}

get_dialog_bundle_alias(dialogbundle, dialogkey) {
  if(!isDefined(dialogbundle) || !isDefined(dialogkey)) {
    return undefined;
  }

  dialogalias = dialogbundle.(dialogkey);

  if(!isDefined(dialogalias)) {
    return;
  }

  voiceprefix = dialogbundle.("voiceprefix");

  if(isDefined(voiceprefix)) {
    dialogalias = voiceprefix + dialogalias;
  }

  return dialogalias;
}

pick_boost_number() {
  wait 5;
  level clientfield::set("boost_number", randomint(4));
}

on_joined_team(params) {
  self endon(#"disconnect");

  if(level.teambased) {
    if(self.team == #"allies") {
      self set_blops_dialog();
    } else {
      self set_cdp_dialog();
    }
  } else if(randomintrange(0, 2)) {
    self set_blops_dialog();
  } else {
    self set_cdp_dialog();
  }

  self flush_dialog_on_player();
}

set_blops_dialog() {
  self.pers[#"mptaacom"] = "blops_taacom";
  self.pers[#"mpcommander"] = "blops_commander";
}

set_cdp_dialog() {
  self.pers[#"mptaacom"] = "cdp_taacom";
  self.pers[#"mpcommander"] = "cdp_commander";
}

on_player_spawned() {
  self.enemythreattime = 0;
  self.heartbeatsnd = 0;
  self.soundmod = "player";
  self.voxunderwatertime = 0;
  self.voxemergebreath = 0;
  self.voxdrowning = 0;
  self.pilotisspeaking = 0;
  self.playingdialog = 0;
  self.playinggadgetreadydialog = 0;
  self.playedgadgetsuccess = 1;

  if(!level.allowbattlechatter[#"bc"]) {
    return;
  }

  self thread water_vox();

  if(level.teambased) {
    self thread enemy_threat();
    self thread check_boost_start_conversation();
  }
}

dialog_chance(chancekey) {
  dialogchance = mpdialog_value(chancekey);

  if(!isDefined(dialogchance) || dialogchance <= 0) {
    return false;
  } else if(dialogchance >= 100) {
    return true;
  }

  return randomint(100) < dialogchance;
}

mpdialog_value(mpdialogkey, defaultvalue) {
  if(!isDefined(mpdialogkey)) {
    return defaultvalue;
  }

  mpdialog = struct::get_script_bundle("mpdialog", "mpdialog_default");

  if(!isDefined(mpdialog)) {
    return defaultvalue;
  }

  structvalue = mpdialog.(mpdialogkey);

  if(!isDefined(structvalue)) {
    return defaultvalue;
  }

  return structvalue;
}

water_vox() {
  self endon(#"death");
  level endon(#"game_ended");
  interval = mpdialog_value("underwaterInterval", float(function_60d95f53()) / 1000);

  if(interval <= 0) {
    assert(interval > 0, "<dev string:x38>");
    return;
  }

  while(true) {
    wait interval;

    if(self isplayerunderwater()) {
      if(!self.voxunderwatertime && !self.voxemergebreath) {
        self stopsounds();
        self.voxunderwatertime = gettime();
      } else if(self.voxunderwatertime) {
        if(gettime() > self.voxunderwatertime + int(mpdialog_value("underwaterBreathTime", 0) * 1000)) {
          self.voxunderwatertime = 0;
          self.voxemergebreath = 1;
        }
      }

      continue;
    }

    if(self.voxdrowning) {
      self thread play_dialog("exertEmergeGasp", 20, mpdialog_value("playerExertBuffer", 0));
      self.voxdrowning = 0;
      self.voxemergebreath = 0;
      continue;
    }

    if(self.voxemergebreath) {
      self thread play_dialog("exertEmergeBreath", 20, mpdialog_value("playerExertBuffer", 0));
      self.voxemergebreath = 0;
    }
  }
}

taking_fire_vox(params) {
  if(isDefined(params.eattacker) && (isai(params.eattacker) || isvehicle(params.eattacker) || isplayer(params.eattacker))) {
    if(isDefined(params.eattacker.team) && util::function_fbce7263(self.team, params.eattacker.team)) {
      takingfire_cooldown = "taking_fire_vo_" + string(self.team);

      if(level util::iscooldownready(takingfire_cooldown)) {
        self play_dialog("takingFire", 1);
        level util::cooldown(takingfire_cooldown, 5);
      }
    }
  }
}

pain_vox(meansofdeath) {
  if(dialog_chance("smallPainChance")) {
    if(meansofdeath == "MOD_DROWN") {
      dialogkey = "exertPainDrowning";
      self.voxdrowning = 1;
    } else if(meansofdeath == "MOD_DOT" || meansofdeath == "MOD_DOT_SELF") {
      if(!isDefined(self.var_dbffaa32)) {
        return;
      }

      dialogkey = "exertPainDamageTick";
    } else if(meansofdeath == "MOD_FALLING") {
      dialogkey = "exertPainFalling";
    } else if(self isplayerunderwater()) {
      dialogkey = "exertPainUnderwater";
    } else {
      dialogkey = "exertPain";
    }

    exertbuffer = mpdialog_value("playerExertBuffer", 0);
    self thread play_dialog(dialogkey, 30, exertbuffer);
  }
}

on_player_suicide_or_team_kill(player, type) {
  self endon(#"death");
  level endon(#"game_ended");
  waittillframeend();

  if(!level.teambased) {
    return;
  }
}

on_player_near_explodable(object, type) {
  self endon(#"death");
  level endon(#"game_ended");
}

enemy_threat() {
  self endon(#"death");
  level endon(#"game_ended");

  while(true) {
    self waittill(#"weapon_ads");

    if(self hasperk(#"specialty_quieter")) {
      continue;
    }

    if(self.enemythreattime + int(mpdialog_value("enemyContactInterval", 0) * 1000) >= gettime()) {
      continue;
    }

    closest_ally = self get_closest_player_ally(1);

    if(!isDefined(closest_ally)) {
      continue;
    }

    allyradius = mpdialog_value("enemyContactAllyRadius", 0);

    if(distancesquared(self.origin, closest_ally.origin) < allyradius * allyradius) {
      eyepoint = self getEye();
      dir = anglesToForward(self getplayerangles());
      dir *= mpdialog_value("enemyContactDistance", 0);
      endpoint = eyepoint + dir;
      traceresult = bulletTrace(eyepoint, endpoint, 1, self);

      if(isDefined(traceresult[#"entity"]) && traceresult[#"entity"].classname == "player" && util::function_fbce7263(traceresult[#"entity"].team, self.team)) {
        if(dialog_chance("enemyContactChance")) {
          self thread play_dialog("threatInfantry", 1);
          level notify(#"level_enemy_spotted", self.team);
          self.enemythreattime = gettime();
        }
      }
    }
  }
}

killed_by_sniper(sniper) {
  self endon(#"disconnect");
  sniper endon(#"disconnect");
  level endon(#"game_ended");

  if(!level.teambased) {
    return 0;
  }

  waittillframeend();

  if(dialog_chance("sniperKillChance")) {
    closest_ally = self get_closest_player_ally();
    allyradius = mpdialog_value("sniperKillAllyRadius", 0);

    if(isDefined(closest_ally) && distancesquared(self.origin, closest_ally.origin) < allyradius * allyradius) {
      closest_ally thread play_dialog("threatSniper", 1);
      sniper.spottedtime = gettime();
      sniper.spottedby = [];
      players = self get_friendly_players();
      players = arraysort(players, self.origin);
      voiceradius = mpdialog_value("playerVoiceRadius", 0);
      voiceradiussq = voiceradius * voiceradius;

      foreach(player in players) {
        if(distancesquared(closest_ally.origin, player.origin) <= voiceradiussq) {
          sniper.spottedby[sniper.spottedby.size] = player;
        }
      }
    }
  }
}

player_killed(attacker, killstreaktype) {
  if(!level.teambased) {
    return;
  }

  if(self === attacker) {
    return;
  }

  waittillframeend();

  if(isDefined(killstreaktype)) {
    if(!isDefined(level.killstreaks[killstreaktype]) || !isDefined(level.killstreaks[killstreaktype].threatonkill) || !level.killstreaks[killstreaktype].threatonkill || !dialog_chance("killstreakKillChance")) {
      return;
    }

    ally = get_closest_player_ally(1);
    allyradius = mpdialog_value("killstreakKillAllyRadius", 0);

    if(isDefined(ally) && distancesquared(self.origin, ally.origin) < allyradius * allyradius) {
      ally play_killstreak_threat(killstreaktype);
    }
  }
}

heavyweaponkilllogic(attacker, weapon, victim) {
  if(!isDefined(attacker.heavyweaponkillcount)) {
    attacker.heavyweaponkillcount = 0;
  }

  attacker.heavyweaponkillcount++;

  if(!(isDefined(attacker.playedgadgetsuccess) && attacker.playedgadgetsuccess) && attacker.heavyweaponkillcount >= mpdialog_value("heroWeaponKillCount", 0)) {
    attacker thread play_gadget_success(weapon, "enemyKillDelay", victim);
    attacker thread heavy_weapon_success_reaction();
  }
}

playkillbattlechatter(attacker, weapon, victim, einflictor) {
  if(isplayer(attacker)) {
    level thread say_kill_battle_chatter(attacker, weapon, victim, einflictor);
  }

  if(isDefined(einflictor)) {
    einflictor notify(#"bhtn_action_notify", {
      #action: "attack_kill"
    });
  }
}

say_kill_battle_chatter(attacker, weapon, victim, inflictor) {
  if(weapon.skipbattlechatterkill || !isDefined(attacker) || !isplayer(attacker) || !isalive(attacker) || attacker isremotecontrolling() || attacker isinvehicle() || attacker isweaponviewonlylinked() || !isDefined(victim) || !isplayer(victim)) {
    return;
  }

  if(isDefined(inflictor) && !isplayer(inflictor) && inflictor.birthtime < attacker.spawntime) {
    return;
  }

  if(weapon.isheavyweapon) {
    heavyweaponkilllogic(attacker, weapon, victim);
  } else if(isDefined(attacker.speedburston) && attacker.speedburston) {
    if(!(isDefined(attacker.speedburstkill) && attacker.speedburstkill)) {
      speedburstkilldist = mpdialog_value("speedBurstKillDistance", 0);

      if(distancesquared(attacker.origin, victim.origin) < speedburstkilldist * speedburstkilldist) {
        attacker.speedburstkill = 1;
      }
    }
  } else if(dialog_chance("enemyKillChance")) {
    if(isDefined(victim.spottedtime) && victim.spottedtime + mpdialog_value("enemySniperKillTime", 0) >= gettime() && array::contains(victim.spottedby, attacker) && dialog_chance("enemySniperKillChance")) {
      killdialog = attacker get_random_key("killSniper");
    } else if(dialog_chance("enemyHeroKillChance")) {
      victimdialogname = victim getmpdialogname();
      killdialog = attacker get_random_key(level.bcsounds[#"kill_dialog"][victimdialogname]);
    } else {
      killdialog = attacker get_random_key("killGeneric");
    }
  }

  victim.spottedtime = undefined;
  victim.spottedby = undefined;

  if(!isDefined(killdialog)) {
    return;
  }

  attacker thread wait_play_dialog(mpdialog_value("enemyKillDelay", 0), killdialog, 1, undefined, victim, "cancel_kill_dialog");
}

event_handler[missile_fire] function_28a568b9(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  grenade = eventstruct.projectile;
  weapon = eventstruct.weapon;

  if(!isDefined(grenade.weapon) || !isDefined(grenade.weapon.rootweapon) || !dialog_chance("incomingProjectileChance")) {
    return;
  }

  dialogkey = level.bcsounds[#"incoming_alert"][grenade.weapon.rootweapon.name];

  if(isDefined(dialogkey)) {
    waittime = mpdialog_value(level.bcsounds[#"incoming_delay"][grenade.weapon.rootweapon.name], float(function_60d95f53()) / 1000);
    level thread incoming_projectile_alert(self, grenade, dialogkey, waittime);
  }
}

event_handler[grenade_fire] function_54ca82b9(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  missile = eventstruct.projectile;

  if(!isDefined(missile.item) || !isDefined(missile.item.rootweapon) || !dialog_chance("incomingProjectileChance")) {
    return;
  }

  dialogkey = level.bcsounds[#"incoming_alert"][missile.item.rootweapon.name];

  if(isDefined(dialogkey)) {
    waittime = mpdialog_value(level.bcsounds[#"incoming_delay"][missile.item.rootweapon.name], float(function_60d95f53()) / 1000);
    level thread incoming_projectile_alert(self, missile, dialogkey, waittime);
  }
}

incoming_projectile_alert(thrower, projectile, dialogkey, waittime) {
  level endon(#"game_ended");

  if(waittime <= 0) {
    assert(waittime > 0, "<dev string:x80>");
    return;
  }

  while(true) {
    wait waittime;

    if(waittime > 0.2) {
      waittime /= 2;
    }

    if(!isDefined(projectile)) {
      return;
    }

    if(!isDefined(thrower) || thrower.team == #"spectator") {
      return;
    }

    if(level.players.size) {
      closest_enemy = thrower get_closest_player_enemy(projectile.origin);
      incomingprojectileradius = mpdialog_value("incomingProjectileRadius", 0);

      if(isDefined(closest_enemy) && distancesquared(projectile.origin, closest_enemy.origin) < incomingprojectileradius * incomingprojectileradius) {
        closest_enemy thread play_dialog(dialogkey, 6);
        return;
      }
    }
  }
}

event_handler[grenade_stuck] function_2ad593d8(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  grenade = eventstruct.projectile;

  if(isalive(self) && isDefined(grenade) && isDefined(grenade.weapon)) {
    if(grenade.weapon.rootweapon.name == "sticky_grenade") {
      self thread play_dialog("stuckSticky", 6);
    }
  }
}

heavy_weapon_success_reaction() {
  self endon(#"death");
  level endon(#"game_ended");

  if(!level.teambased) {
    return;
  }

  allies = [];
  allyradiussq = mpdialog_value("playerVoiceRadius", 0);
  allyradiussq *= allyradiussq;

  foreach(player in level.players) {
    if(!isDefined(player) || !isalive(player) || player.sessionstate != "playing" || player == self || util::function_fbce7263(player.team, self.team)) {
      continue;
    }

    distsq = distancesquared(self.origin, player.origin);

    if(distsq > allyradiussq) {
      continue;
    }

    allies[allies.size] = player;
  }

  wait mpdialog_value("enemyKillDelay", 0) + 0.1;

  while(self.playingdialog) {
    wait 0.5;
  }

  allies = arraysort(allies, self.origin);

  foreach(player in allies) {
    if(!isalive(player) || player.sessionstate != "playing" || player.playingdialog || player isplayerunderwater() || player isremotecontrolling() || player isinvehicle() || player isweaponviewonlylinked()) {
      continue;
    }

    distsq = distancesquared(self.origin, player.origin);

    if(distsq > allyradiussq) {
      break;
    }

    player play_dialog("heroWeaponSuccessReaction", 1);
    break;
  }
}

play_promotion_reaction() {
  self endon(#"death");
  level endon(#"game_ended");

  if(!level.teambased) {
    return;
  }

  wait 9;
  players = self get_friendly_players();
  players = arraysort(players, self.origin);
  selfdialog = self getmpdialogname();
  voiceradius = mpdialog_value("playerVoiceRadius", 0);
  voiceradiussq = voiceradius * voiceradius;

  foreach(player in players) {
    if(player == self || player getmpdialogname() == selfdialog || !player can_play_dialog(1) || distancesquared(self.origin, player.origin) >= voiceradiussq) {
      continue;
    }

    dialogalias = player get_player_dialog_alias("promotionReaction");

    if(!isDefined(dialogalias)) {
      continue;
    }

    ally = player;
    break;
  }

  if(isDefined(ally)) {
    ally playsoundontag(dialogalias, "J_Head", undefined, self);
    ally thread wait_dialog_buffer(mpdialog_value("playerDialogBuffer", 0));
  }
}

gametype_specific_battle_chatter(event, team) {
  self endon(#"death");
  level endon(#"game_ended");
}

play_laststand_vox() {
  dialogkey = "laststandDown";

  if(isDefined(dialogkey)) {
    self play_dialog(dialogkey, 1);
  }
}

function_78c16252() {
  dialogkey = "exertFullyHealedBreath";
  dialogalias = self get_player_dialog_alias(dialogkey);

  if(isDefined(dialogalias)) {
    self thread play_dialog(dialogkey, 16);
  }
}

play_death_vox(body, attacker, weapon, meansofdeath) {
  dialogkey = self get_death_vox(weapon, meansofdeath);
  dialogalias = self get_player_dialog_alias(dialogkey);

  if(isDefined(dialogalias)) {
    body playsoundontag(dialogalias, "J_Head");
  }
}

get_death_vox(weapon, meansofdeath) {
  if(self isplayerunderwater()) {
    return "exertDeathDrowned";
  }

  if(isDefined(meansofdeath)) {
    switch (meansofdeath) {
      case #"mod_burned":
        return "exertDeathBurned";
      case #"mod_drown":
        return "exertDeathDrowned";
      case #"mod_dot":
        return "exertDeathDrowned";
      case #"mod_dot_self":
        return "exertDeathDrowned";
    }
  }

  if(isDefined(weapon) && meansofdeath !== "MOD_MELEE_WEAPON_BUTT") {
    switch (weapon.rootweapon.name) {
      case #"knife_loadout":
      case #"hatchet":
        return "exertDeathStabbed";
      case #"hero_firefly_swarm":
        return "exertDeathBurned";
      case #"hero_lightninggun_arc":
        return "exertDeathElectrocuted";
    }
  }

  return "exertDeath";
}

play_killstreak_threat(killstreaktype) {
  if(!isDefined(killstreaktype) || !isDefined(level.killstreaks[killstreaktype])) {
    return;
  }

  self thread play_dialog(level.killstreaks[killstreaktype].threatdialogkey, 1);
}

wait_play_dialog(waittime, dialogkey, dialogflags, dialogbuffer, enemy, endnotify) {
  self endon(#"death");
  level endon(#"game_ended");

  if(isDefined(waittime) && waittime > 0) {
    if(isDefined(endnotify)) {
      self endon(endnotify);
    }

    wait waittime;
  }

  self thread play_dialog(dialogkey, dialogflags, dialogbuffer, enemy);
}

play_dialog(dialogkey, dialogflags, dialogbuffer, enemy) {
  self endon(#"death");
  level endon(#"game_ended");

  if(level flag::exists("intro_igcs_done")) {
    if(!level flag::get("intro_igcs_done")) {
      return;
    }
  } else if(isDefined(mission)) {
    if(!mission flag::exists("intro_igcs_done") || !mission flag::get("intro_igcs_done")) {
      return;
    }
  } else {
    return;
  }

  if(!isDefined(dialogkey) || !isplayer(self) || !isalive(self) || level.gameended) {
    return;
  }

  global_cooldown = "global_" + self.team;
  charactertype_cooldown = "character_" + self getmpdialogname() + self.team;

  if(!level util::iscooldownready(global_cooldown) || !level util::iscooldownready(charactertype_cooldown)) {
    return;
  }

  level util::cooldown(global_cooldown, 0.9);
  level util::cooldown(charactertype_cooldown, 2.5);

  if(self scene::is_igc_active()) {
    return;
  }

  if(level flagsys::get(#"chyron_active")) {
    return;
  }

  if(isDefined(self.team) && level flagsys::get(#"dialog_mutex_" + self.team)) {
    return;
  }

  if(!isDefined(dialogflags)) {
    dialogflags = 0;
  }

  if(!level.allowspecialistdialog && (dialogflags&16) == 0) {
    return;
  }

  if(!isDefined(dialogbuffer)) {
    dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
  }

  dialogalias = self get_player_dialog_alias(dialogkey);

  if(!isDefined(dialogalias)) {
    return;
  }

  if(self isplayerunderwater() && !(dialogflags&8)) {
    return;
  }

  if(self.playingdialog) {
    if(!(dialogflags&4)) {
      return;
    }

    self stopsounds();
    waitframe(1);
  }

  if(dialogflags&32) {
    self.playinggadgetreadydialog = 1;
  }

  if(dialogflags&64) {
    if(!isDefined(self.stolendialogindex)) {
      self.stolendialogindex = 0;
    }

    dialogalias = dialogalias + "_0" + self.stolendialogindex;
    self.stolendialogindex++;
    self.stolendialogindex %= 4;
  }

  if(dialogflags&2) {
    self playsoundontag(dialogalias, "J_Head");
  } else if(dialogflags&1) {
    if(isDefined(enemy)) {
      self playsoundontag(dialogalias, "J_Head", self.team, enemy);
    } else {
      self playsoundontag(dialogalias, "J_Head", self.team);
    }
  } else {
    self playlocalsound(dialogalias);
  }

  self notify(#"played_dialog");
  self thread wait_dialog_buffer(dialogbuffer);
}

wait_dialog_buffer(dialogbuffer) {
  self endon(#"death", #"played_dialog", #"stop_dialog");
  level endon(#"game_ended");
  self.playingdialog = 1;

  if(isDefined(dialogbuffer) && dialogbuffer > 0) {
    wait dialogbuffer;
  }

  self.playingdialog = 0;
  self.playinggadgetreadydialog = 0;
}

stop_dialog() {
  self notify(#"stop_dialog");
  self stopsounds();
  self.playingdialog = 0;
  self.playinggadgetreadydialog = 0;
}

wait_playback_time(soundalias) {}

get_player_dialog_alias(dialogkey) {
  if(!isplayer(self)) {
    return undefined;
  }

  bundlename = self getmpdialogname();

  if(!isDefined(bundlename)) {
    return undefined;
  }

  playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);

  if(!isDefined(playerbundle)) {
    return undefined;
  }

  return get_dialog_bundle_alias(playerbundle, dialogkey);
}

count_keys(&keycounts, bundle, dialogkey) {
  i = 0;
  field = dialogkey + i;

  for(fieldvalue = bundle.(field); isDefined(fieldvalue); fieldvalue = bundle.(field)) {
    aliasarray[i] = fieldvalue;
    i++;
    field = dialogkey + i;
  }

  if(!isDefined(keycounts[bundle.name])) {
    keycounts[bundle.name] = [];
  }

  keycounts[bundle.name][dialogkey] = i;
}

get_random_key(dialogkey) {
  bundlename = self getmpdialogname();

  if(!isDefined(bundlename)) {
    return undefined;
  }

  if(!isDefined(level.var_f53efe5c[bundlename]) || !isDefined(level.var_f53efe5c[bundlename][dialogkey])) {
    return dialogkey;
  }

  keycount = level.var_f53efe5c[bundlename][dialogkey];

  if(keycount > 0) {
    return (dialogkey + randomint(keycount));
  }

  return dialogkey + 0;
}

play_gadget_ready(weapon, userflip = 0) {
  if(!isDefined(weapon)) {
    return;
  }

  dialogkey = undefined;

  switch (weapon.name) {
    case #"hero_gravityspikes":
      dialogkey = "gravspikesWeaponReady";
      break;
    case #"gadget_speed_burst":
      dialogkey = "overdriveAbilityReady";
      break;
    case #"gadget_vision_pulse":
      dialogkey = "visionpulseAbilityReady";
      break;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
      dialogkey = "tempestWeaponReady";
      break;
    case #"hero_pineapplegun":
    case #"hero_pineapplegun_companion":
      dialogkey = "warmachineWeaponREady";
      break;
    case #"gadget_armor":
      dialogkey = "kineticArmorAbilityReady";
      break;
    case #"hero_annihilator":
      dialogkey = "annihilatorWeaponReady";
      break;
    case #"gadget_combat_efficiency":
      dialogkey = "combatfocusAbilityReady";
      break;
    case #"hero_chemicalgelgun":
      dialogkey = "hiveWeaponReady";
      break;
    case #"gadget_resurrect":
      dialogkey = "rejackAbilityReady";
      break;
    case #"hero_minigun":
      dialogkey = "scytheWeaponReady";
      break;
    case #"gadget_clone":
      dialogkey = "psychosisAbilityReady";
      break;
    case #"gadget_camo":
      dialogkey = "activeCamoAbilityReady";
      break;
    case #"hero_flamethrower":
      dialogkey = "purifierWeaponReady";
      break;
    case #"gadget_heat_wave":
      dialogkey = "heatwaveAbilityReady";
      break;
    default:
      return;
  }

  if(!(isDefined(self.isthief) && self.isthief) && !(isDefined(self.isroulette) && self.isroulette)) {
    dialogflags = undefined;
    self thread play_dialog(dialogkey, dialogflags);
    return;
  }

  waittime = 0;
  dialogflags = 32;

  if(userflip) {
    minwaittime = 0;

    if(self.playinggadgetreadydialog) {
      self stop_dialog();
      minwaittime = float(function_60d95f53()) / 1000;
    }

    if(isDefined(self.isthief) && self.isthief) {
      delaykey = "thiefFlipDelay";
    } else {
      delaykey = "rouletteFlipDelay";
    }

    waittime = mpdialog_value(delaykey, minwaittime);
    dialogflags += 64;
  } else {
    if(isDefined(self.isthief) && self.isthief) {
      generickey = "thiefWeaponReady";
      repeatkey = "thiefWeaponRepeat";
      repeatthresholdkey = "thiefRepeatThreshold";
      chancekey = "thiefReadyChance";
      delaykey = "thiefRevealDelay";
    } else {
      generickey = "rouletteAbilityReady";
      repeatkey = "rouletteAbilityRepeat";
      repeatthresholdkey = "rouletteRepeatThreshold";
      chancekey = "rouletteReadyChance";
      delaykey = "rouletteRevealDelay";
    }

    if(randomint(100) < mpdialog_value(chancekey, 0)) {
      dialogkey = generickey;
    } else {
      waittime = mpdialog_value(delaykey, 0);

      if(self.laststolengadget === weapon && self.laststolengadgettime + int(mpdialog_value(repeatthresholdkey, 0) * 1000) > gettime()) {
        dialogkey = repeatkey;
      } else {
        dialogflags += 64;
      }
    }
  }

  self.laststolengadget = weapon;
  self.laststolengadgettime = gettime();

  if(waittime) {
    self notify(#"cancel_kill_dialog");
  }

  self thread wait_play_dialog(waittime, dialogkey, dialogflags);
}

play_gadget_activate(weapon) {
  if(!isDefined(weapon)) {
    return;
  }

  dialogkey = undefined;

  switch (weapon.name) {
    case #"hero_gravityspikes":
      dialogkey = "gravspikesWeaponUse";
      dialogflags = 22;
      dialogbuffer = 0.05;
      break;
    case #"gadget_speed_burst":
      dialogkey = "overdriveAbilityUse";
      break;
    case #"gadget_vision_pulse":
      dialogkey = "visionpulseAbilityUse";
      break;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
      dialogkey = "tempestWeaponUse";
      break;
    case #"hero_pineapplegun":
    case #"hero_pineapplegun_companion":
      dialogkey = "warmachineWeaponUse";
      break;
    case #"gadget_armor":
      dialogkey = "kineticArmorAbilityUse";
      break;
    case #"hero_annihilator":
      dialogkey = "annihilatorWeaponUse";
      break;
    case #"gadget_combat_efficiency":
      dialogkey = "combatfocusAbilityUse";
      break;
    case #"hero_chemicalgelgun":
      dialogkey = "hiveWeaponUse";
      break;
    case #"gadget_resurrect":
      dialogkey = "rejackAbilityUse";
      break;
    case #"hero_minigun":
      dialogkey = "scytheWeaponUse";
      break;
    case #"gadget_clone":
      dialogkey = "psychosisAbilityUse";
      break;
    case #"gadget_camo":
      dialogkey = "activeCamoAbilityUse";
      break;
    case #"hero_flamethrower":
      dialogkey = "purifierWeaponUse";
      break;
    case #"gadget_heat_wave":
      dialogkey = "heatwaveAbilityUse";
      break;
    default:
      return;
  }

  self thread play_dialog(dialogkey, dialogflags, dialogbuffer);
}

play_gadget_success(weapon, waitkey, victim) {
  if(!isDefined(weapon)) {
    return;
  }

  dialogkey = undefined;

  switch (weapon.name) {
    case #"hero_gravityspikes":
      dialogkey = "gravspikesWeaponSuccess";
      break;
    case #"gadget_speed_burst":
      dialogkey = "overdriveAbilitySuccess";
      break;
    case #"gadget_vision_pulse":
      dialogkey = "visionpulseAbilitySuccess";
      break;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
      dialogkey = "tempestWeaponSuccess";
      break;
    case #"hero_pineapplegun":
    case #"hero_pineapplegun_companion":
      dialogkey = "warmachineWeaponSuccess";
      break;
    case #"gadget_armor":
      dialogkey = "kineticArmorAbilitySuccess";
      break;
    case #"hero_annihilator":
      dialogkey = "annihilatorWeaponSuccess";
      break;
    case #"gadget_combat_efficiency":
      dialogkey = "combatfocusAbilitySuccess";
      break;
    case #"hero_chemicalgelgun":
      dialogkey = "hiveWeaponSuccess";
      break;
    case #"gadget_resurrect":
      dialogkey = "rejackAbilitySuccess";
      break;
    case #"hero_minigun":
      dialogkey = "scytheWeaponSuccess";
      break;
    case #"gadget_clone":
      dialogkey = "psychosisAbilitySuccess";
      break;
    case #"gadget_camo":
      dialogkey = "activeCamoAbilitySuccess";
      break;
    case #"hero_flamethrower":
      dialogkey = "purifierWeaponSuccess";
      break;
    case #"gadget_heat_wave":
      dialogkey = "heatwaveAbilitySuccess";
      break;
    default:
      return;
  }

  if(isDefined(waitkey)) {
    waittime = mpdialog_value(waitkey, 0);
  }

  dialogkey += "0";
  self.playedgadgetsuccess = 1;
  self thread wait_play_dialog(waittime, dialogkey, 1, undefined, victim);
}

play_gadget_off(weapon) {
  if(!isDefined(weapon)) {
    return;
  }

  dialogkey = undefined;

  switch (weapon.name) {
    case #"gadget_speed_burst":
      dialogkey = "overdriveAbilityOff";
      break;
    case #"hero_pineapplegun":
    case #"hero_pineapplegun_companion":
      dialogkey = "warmachineWeaponOff";
      break;
    default:
      return;
  }

  self thread play_dialog(dialogkey, 1);
}

play_throw_hatchet() {
  self thread play_dialog("exertAxeThrow", 21, mpdialog_value("playerExertBuffer", 0));
}

get_enemy_players() {
  players = [];

  if(level.teambased) {
    foreach(team, _ in level.teams) {
      if(team == self.team) {
        continue;
      }

      foreach(player in level.aliveplayers[team]) {
        players[players.size] = player;
      }
    }
  } else {
    foreach(player in level.activeplayers) {
      if(player != self) {
        players[players.size] = player;
      }
    }
  }

  return players;
}

get_friendly_players() {
  players = [];

  if(level.teambased && isDefined(self.team) && isDefined(level.aliveplayers) && isDefined(level.aliveplayers[self.team])) {
    foreach(player in level.aliveplayers[self.team]) {
      players[players.size] = player;
    }
  } else {
    players[0] = self;
  }

  return players;
}

can_play_dialog(teamonly) {
  if(!isplayer(self) || !isalive(self) || self.playingdialog === 1 || self isplayerunderwater() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked()) {
    return false;
  }

  if(isDefined(teamonly) && !teamonly && self hasperk(#"specialty_quieter")) {
    return false;
  }

  return true;
}

get_closest_player_enemy(origin = self.origin, teamonly) {
  players = self get_enemy_players();
  players = arraysort(players, origin);

  foreach(player in players) {
    if(!player can_play_dialog(teamonly)) {
      continue;
    }

    return player;
  }

  return undefined;
}

get_closest_player_ally(teamonly) {
  if(!level.teambased) {
    return undefined;
  }

  players = self get_friendly_players();
  players = arraysort(players, self.origin);

  foreach(player in players) {
    if(player == self || !player can_play_dialog(teamonly)) {
      continue;
    }

    return player;
  }

  return undefined;
}

check_boost_start_conversation() {
  if(!level.playstartconversation) {
    return;
  }

  if(!level.inprematchperiod || !level.teambased || game.boostplayerspicked[self.team]) {
    return;
  }

  players = self get_friendly_players();
  array::add(players, self, 0);
  players = array::randomize(players);
  playerindex = 1;

  foreach(player in players) {
    if(!isDefined(player) || !isplayer(player)) {
      continue;
    }

    playerdialog = player getmpdialogname();

    for(i = playerindex; i < players.size; i++) {
      playeri = players[i];

      if(!isDefined(playeri) || !isplayer(playeri)) {
        continue;
      }

      if(playerdialog != playeri getmpdialogname()) {
        pick_boost_players(player, playeri);
        return;
      }
    }

    playerindex++;
  }
}

pick_boost_players(player1, player2) {
  player1 clientfield::set("play_boost", 1);
  player2 clientfield::set("play_boost", 2);
  game.boostplayerspicked[player1.team] = 1;
}

game_end_vox(winner, tie) {
  if(!level.allowspecialistdialog) {
    return;
  }

  foreach(player in level.players) {
    if(player issplitscreen()) {
      continue;
    }

    if(tie) {
      dialogkey = "boostDraw";
    } else if(level.teambased && isDefined(level.teams[winner]) && player.pers[#"team"] == winner || !level.teambased && player == winner) {
      dialogkey = "boostWin";
    } else {
      dialogkey = "boostLoss";
    }

    dialogalias = player get_player_dialog_alias(dialogkey);

    if(isDefined(dialogalias)) {
      player playlocalsound(dialogalias);
    }
  }
}

devgui_think() {
  setdvar(#"devgui_mpdialog", "<dev string:xbc>");
  setdvar(#"testalias_player", "<dev string:xbf>");
  setdvar(#"testalias_taacom", "<dev string:xdc>");
  setdvar(#"testalias_commander", "<dev string:xf8>");

  while(true) {
    wait 1;
    player = util::gethostplayer();

    if(!isDefined(player)) {
      continue;
    }

    spacing = getdvarfloat(#"testdialog_spacing", 0.25);

    switch (getdvarstring(#"devgui_mpdialog", "<dev string:xbc>")) {
      case #"hash_7912e80189f9c6":
        player thread test_player_dialog(0);
        player thread test_taacom_dialog(spacing);
        player thread test_commander_dialog(2 * spacing);
        break;
      case #"hash_69c6be086f76a9d4":
        player thread test_player_dialog(0);
        player thread test_commander_dialog(spacing);
        break;
      case #"hash_3af5f0a904b3f8fa":
        player thread test_other_dialog(0);
        player thread test_commander_dialog(spacing);
        break;
      case #"hash_32945da5f7ac491":
        player thread test_taacom_dialog(0);
        player thread test_commander_dialog(spacing);
        break;
      case #"hash_597b27a5c8857d19":
        player thread test_player_dialog(0);
        player thread test_taacom_dialog(spacing);
        break;
      case #"hash_74f798193af006b3":
        player thread test_other_dialog(0);
        player thread test_taacom_dialog(spacing);
        break;
      case #"hash_5bd6a2c5d0ff3cb2":
        player thread test_other_dialog(0);
        player thread test_player_dialog(spacing);
        break;
      case #"hash_4a5a66c89be92eb":
        player thread play_conv_self_other();
        break;
      case #"hash_18683ef7652f40ed":
        player thread play_conv_other_self();
        break;
      case #"hash_2b559b1a5e81715f":
        player thread play_conv_other_other();
        break;
    }

    setdvar(#"devgui_mpdialog", "<dev string:xbc>");
  }
}

test_other_dialog(delay) {
  players = arraysort(level.players, self.origin);

  foreach(player in players) {
    if(player != self && isalive(player)) {
      player thread test_player_dialog(delay);
      return;
    }
  }
}

test_player_dialog(delay) {
  if(!isDefined(delay)) {
    delay = 0;
  }

  wait delay;
  self playsoundontag(getdvarstring(#"testalias_player", "<dev string:xbc>"), "<dev string:x11b>");
}

test_taacom_dialog(delay) {
  if(!isDefined(delay)) {
    delay = 0;
  }

  wait delay;
  self playlocalsound(getdvarstring(#"testalias_taacom", "<dev string:xbc>"));
}

test_commander_dialog(delay) {
  if(!isDefined(delay)) {
    delay = 0;
  }

  wait delay;
  self playlocalsound(getdvarstring(#"testalias_commander", "<dev string:xbc>"));
}

play_test_dialog(dialogkey) {
  dialogalias = self get_player_dialog_alias(dialogkey);
  self playsoundontag(dialogalias, "<dev string:x11b>");
}

response_key() {
  switch (self getmpdialogname()) {
    case #"assassin":
      return "<dev string:x124>";
    case #"grenadier":
      return "<dev string:x12e>";
    case #"outrider":
      return "<dev string:x13a>";
    case #"prophet":
      return "<dev string:x145>";
    case #"pyro":
      return "<dev string:x154>";
    case #"reaper":
      return "<dev string:x160>";
    case #"ruin":
      return "<dev string:x169>";
    case #"seraph":
      return "<dev string:x175>";
    case #"trapper":
      return "<dev string:x180>";
  }

  return "<dev string:xbc>";
}

play_conv_self_other() {
  num = randomintrange(0, 4);
  self play_test_dialog("<dev string:x18a>" + num);
  wait 4;
  players = arraysort(level.players, self.origin);

  foreach(player in players) {
    if(player != self && isalive(player)) {
      player play_test_dialog("<dev string:x197>" + self response_key() + num);
      break;
    }
  }
}

play_conv_other_self() {
  num = randomintrange(0, 4);
  players = arraysort(level.players, self.origin);

  foreach(player in players) {
    if(player != self && isalive(player)) {
      player play_test_dialog("<dev string:x18a>" + num);
      break;
    }
  }

  wait 4;
  self play_test_dialog("<dev string:x197>" + player response_key() + num);
}

play_conv_other_other() {
  num = randomintrange(0, 4);
  players = arraysort(level.players, self.origin);

  foreach(player in players) {
    if(player != self && isalive(player)) {
      player play_test_dialog("<dev string:x18a>" + num);
      firstplayer = player;
      break;
    }
  }

  wait 4;

  foreach(player in players) {
    if(player != self && player !== firstplayer && isalive(player)) {
      player play_test_dialog("<dev string:x197>" + firstplayer response_key() + num);
      break;
    }
  }
}

