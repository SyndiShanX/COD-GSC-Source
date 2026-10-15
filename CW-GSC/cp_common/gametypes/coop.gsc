/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\coop.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using script_44b0b8420eabacad;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\gamedifficulty;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_spawn;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\globallogic_utils;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace coop;

function event_handler[gametype_init] main(eventstruct) {
  clientfield::register("playercorpse", "hide_body", 1, 1, "int");
  clientfield::register("toplayer", "killcam_menu", 1, 1, "int");
  globallogic::init();
  level.gametype = util::get_game_type();
  level.var_837aa533 = hash(level.gametype);

  if(isDefined(level.gametype)) {
    level.var_12323003 = function_16495154(level.var_837aa533);
    level.basegametype = function_be90acca(level.var_837aa533);
  }

  util::registerroundswitch(0, 9);
  util::registertimelimit(0, 0);
  util::registerscorelimit(0, 0);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 0);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  spawner::add_global_spawn_function(#"axis", &function_e89f60e2);
  level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
  level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
  level.teamscoreperdeath = getgametypesetting(#"teamscoreperdeath");
  level.teamscoreperheadshot = getgametypesetting(#"teamscoreperheadshot");
  level.teambased = 1;
  level.overrideteamscore = 1;
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.onspawnplayerunified = undefined;
  level.onplayerkilled = &onplayerkilled;
  level.disable_last_stand = 1;
  level.takelivesondeath = 0;
  level.livesdonotreset = 1;
  level.ondeadevent = undefined;
  level.var_31c6ebd4 = &function_31c6ebd4;
  callback::on_bleedout(&onplayerbleedout);
  callback::on_mission_failed(&on_mission_failed);
  level.gametypespawnedasspectator = &spawnedasspectator;
  level thread checkpointfadein();
  level.endgameonscorelimit = 0;
  level.endgameontimelimit = 0;
  level.var_e23fea8c = &function_ddc47ed1;
  level.ontimelimit = &globallogic::blank;
  level.onscorelimit = &globallogic::blank;
  gameobjects::register_allowed_gameobject(level.gametype);
  game.dialog[#"gametype"] = "coop_start";
  game.dialog[#"gametype_hardcore"] = "hccoop_start";
  game.dialog[#"offense_obj"] = "generic_boost";
  game.dialog[#"defense_obj"] = "generic_boost";
  setDvar(#"force_no_cac", 1);
}

function on_mission_failed() {
  level thread fadeoutandloadcheckpoint(level.var_85b00b2b, level.var_30eb363);

  foreach(player in getPlayers()) {
    bb::logplayermapnotification("mission_fail", player);
  }
}

function function_e89f60e2() {
  self influencers::create_influencer_generic("enemy_spawn", self.origin, #"allies");
  self influencers::create_influencer_generic("enemy", self, #"allies", 1);
}

function function_45b62760() {
  self matchrecordplayerspawned();
  skiptoindex = skipto::function_a002f769();

  if(skiptoindex >= 0) {
    self matchrecordsetcheckpointstat(skiptoindex, "checkpoint_restores", 1);
  }

  primaryweapon = isDefined(self.primaryweapon) ? self.primaryweapon : level.weaponnone;
  secondaryweapon = isDefined(self.secondaryweapon) ? self.secondaryweapon : level.weaponnone;
  grenadetypeprimary = isDefined(self.grenadetypeprimary) ? self.grenadetypeprimary : level.weaponnone;
  grenadetypesecondary = isDefined(self.grenadetypesecondary) ? self.grenadetypesecondary : level.weaponnone;
  self.killstreak = [];

  for(i = 0; i < 3; i++) {
    if(level.loadoutkillstreaksenabled && isDefined(self.killstreak[i]) && isDefined(level.killstreakindices[self.killstreak[i]])) {
      killstreaks[i] = level.killstreakindices[self.killstreak[i]];
      continue;
    }

    killstreaks[i] = 0;
  }

  self recordloadoutperksandkillstreaks(primaryweapon, secondaryweapon, grenadetypeprimary, grenadetypesecondary, killstreaks[0], killstreaks[1], killstreaks[2]);
}

function checkpointfadein() {
  while(true) {
    level waittill(#"save_restore");
    player = getPlayers()[0];
    level thread lui::screen_fade(0, 1, 1, "black");
    globallogic_ui::function_cdbb5c49(1, 1);
    player function_a7af3a2a();
    util::cleanupactorcorpses();
    matchrecorderincrementheaderstat("checkpointRestoreCount", 1);

    foreach(player in level.players) {
      player closemenu(game.menu[#"menu_start_menu"]);

      if(player flag::get(#"mobile_armory_in_use")) {
        player notify(#"menuresponse", {
          #menu: "mobile_armory_loadout", #response: "cancel", #intpayload: 0
        });
      }

      player closemenu(game.menu[#"menu_changeclass"]);
      player closemenu(game.menu[#"menu_changeclass_offline"]);

      if(player.sessionstate == "spectator") {
        if(!isDefined(player.curclass)) {
          player thread globallogic_ui::beginclasschoice();
        } else {
          player thread globallogic_spawn::waitandspawnclient();
        }
      }

      player thread val::set_for_time(3, "checkpoint_restore", "takedamage", 0);

      if(!is_true(world.checkpoint_used)) {
        world.checkpoint_used = 1;
      }

      player function_45b62760();
    }

    player endon(#"death");
    player val::set(#"checkpointfadein", "show_crosshair", 0);
    player val::set(#"checkpointfadein", "freezecontrols", 1);
    player val::set(#"checkpointfadein", "takedamage", 0);
    player val::set(#"checkpointfadein", "allowdeath", 0);
    player val::set(#"checkpointfadein", "pre_load_ghost", 1);
    player function_a7af3a2a();
    level util::delay(0.05, undefined, &lui::screen_fade, 0.25, 0, 1, "black", 1);
    player util::function_8b0c9d28(undefined, 5);
    wait 0.4;
    level flag::wait_till(#"gameplay_started");
    player val::reset_all(#"checkpointfadein");
    globallogic_ui::function_cdbb5c49(0);
  }
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game.switchedsides)) {
    game.switchedsides = 0;
  }

  if(game.switchedsides) {
    oldattackers = game.attackers;
    olddefenders = game.defenders;
    game.attackers = olddefenders;
    game.defenders = oldattackers;
  }

  level.displayroundendtext = 0;
  influencers::create_map_placed_influencers();
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  foreach(team in level.playerteams) {
    util::setobjectivetext(team, #"hash_6d9d9822a460249b");
    util::setobjectivehinttext(team, #"hash_6800331814c69e15");
    util::setobjectivescoretext(team, #"hash_6d9d9822a460249b");
  }

  level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  spawnpoint = spawning::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
  level thread respawn_spectators_on_objective_change();
  function_ddc47ed1();
  level flag::wait_till("first_player_spawned");

  foreach(player in level.players) {
    bb::logobjectivestatuschange("_level", player, "start");
  }
}

function function_ddc47ed1() {
  skipto::update_spawn_points(1);
}

function private spawnplayer_internal() {
  spawns = skipto::filter_player_spawnpoints(level.var_cd012e52);
  self spawn(spawns[0].origin, spawns[0].angles);
  self.lastspawntime = gettime();
}

function onspawnplayer(predictedspawn, question) {
  pixbeginevent(#"");
  self.usingobj = undefined;
  self spawnplayer_internal();
  self thread function_bb5fae75();
  self.eligible_for_death_invulnerability = 1;
  self thread gamedifficulty::playerhurtcheck();
  pixendevent();
}

function onscoreclosemusic() {
  teamscores = [];

  while(!level.gameended) {
    scorelimit = level.scorelimit;
    scorethreshold = scorelimit * 0.1;
    scorethresholdstart = abs(scorelimit - scorethreshold);
    scorelimitcheck = scorelimit - 10;
    topscore = 0;
    runnerupscore = 0;

    foreach(team, _ in level.teams) {
      score = [[level._getteamscore]](team);

      if(score > topscore) {
        runnerupscore = topscore;
        topscore = score;
        continue;
      }

      if(score > runnerupscore) {
        runnerupscore = score;
      }
    }

    scoredif = topscore - runnerupscore;

    if(scoredif <= scorethreshold && scorethresholdstart <= topscore) {
      return;
    }

    wait 1;
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  self closemenu(game.menu[#"menu_changeclass"]);
  primaries = self getweaponslistprimaries();

  if(isDefined(primaries)) {
    foreach(primary_weapon in primaries) {
      if(primary_weapon !== self.secondaryloadoutweapon) {
        self._current_weapon = primary_weapon;
        break;
      }
    }
  }

  self player::take_weapons();
  self savegame::set_player_data("saved_weapon", self._current_weapon.rootweapon.name);
  self savegame::set_player_data("saved_weapon_attachments", util::function_2146bd83(self._current_weapon));
  self savegame::set_player_data("saved_weapondata", self._weapons);
  self._weapons = undefined;
  self.gun_removed = undefined;

  if(isDefined(level.var_5be43b2d)) {
    return;
  }

  level.dead_player = self;

  if(isDefined(level.var_85b00b2b)) {
    fail_reason = level.var_85b00b2b;
  }

  if(level.players.size == 1) {
    if(!self util::function_a1d6293()) {
      self playsoundtoplayer(#"evt_death_down", self);
    }

    if(is_true(level.usefpsdeathcam)) {
      self.var_e36aebf2 = 1;

      if(is_true(level.usecpkillcam) && is_true(self.var_30a1aeee)) {
        self thread function_ffac0e3();
      }

      self waittilltimeout(5, #"cp_deathcam_ended");
    }

    level thread fadeoutandloadcheckpoint(fail_reason, level.var_30eb363);
    return;
  }

  if(level.gameskill >= 2) {
    playSoundAtPosition(#"evt_death_down", (0, 0, 0));
    level thread fadeoutandloadcheckpoint(fail_reason, level.var_30eb363);
  }
}

function fadeoutandloadcheckpoint(str_reason_for_fail, str_hint_to_not_fail) {
  level.var_5be43b2d = 1;
  setslowmotion(1);
  level flag::set(#"mission_failed");

  if(!isDefined(str_reason_for_fail)) {
    str_reason_for_fail = #"";
  }

  if(!isDefined(str_hint_to_not_fail)) {
    str_hint_to_not_fail = #"";
  }

  foreach(player in level.players) {
    player thread util::hide_hint_text(0);
    player val::set(#"load_checkpoint", "show_hud", 0);
    bb::logobjectivestatuschange(level.skipto_point, player, "restart");
    player val::set(#"fadeoutandloadcheckpoint", "freezecontrols");
    player.restoringcheckpoint = 1;

    if(!isDefined(level.var_59f4be9a)) {
      level thread lui::screen_fade(0, 0.001, 0.001, "black", 0);
      waitframe(1);
    }

    player.mission_fail_menu = player openluimenu("CPMissionFailed");
    player setluimenudata(player.mission_fail_menu, #"missionfailreason", str_reason_for_fail);
    globallogic_ui::function_9ed5232e("hudItems.cpMissionFailedEntry.MissionFailHint", str_hint_to_not_fail, 0, 1);
    globallogic_ui::function_9ed5232e("hudItems.cpMissionFailedEntry.MissionFailReason", str_reason_for_fail, 0, 1);

    if(isalive(player)) {
      snd::play("uin_cp_failure");
    }

    player setluimenudata(player.mission_fail_menu, #"missionfailhint", str_hint_to_not_fail);
  }

  var_effac39e = 1.25;

  if(isDefined(level.dead_player)) {
    if(is_true(level.usecpkillcam)) {
      foreach(player in level.players) {
        if(is_true(player.var_8fc85657)) {
          level.dead_player waittill(#"end_killcam", #"fade_out_killcam");

          if(isDefined(level.dead_player.var_55180cd8)) {
            var_effac39e = level.dead_player.var_55180cd8;
          }
        }
      }
    }

    if(level.dead_player util::function_a1d6293()) {
      wait 0.7;
    } else {
      level thread lui::screen_fade(var_effac39e, 1, 0, "black", 0);
      wait var_effac39e;
    }

    screen_faded = 1;

    if(is_true(level.usecpkillcam)) {
      foreach(player in level.players) {
        if(is_true(player.var_8fc85657)) {
          player clientfield::set_to_player("killcam_menu", 0);
        }
      }
    }
  }

  if(!isDefined(screen_faded)) {
    level thread lui::screen_fade(var_effac39e, 1, 0, "black", 0);
    wait var_effac39e;
  }

  if(str_reason_for_fail != #"" || str_hint_to_not_fail != #"") {
    wait 2.6;
  }

  if(is_true(level.gameended)) {
    wait 1000;
  }

  foreach(player in level.players) {
    player notify(#"camera_sequence_completed");
    player cameraactivate(0);
    player val::reset(#"fadeoutandloadcheckpoint", "freezecontrols");
  }

  if(isDefined(level.heroes)) {
    foreach(key, hero in level.heroes) {
      util::unmake_hero(key);
    }
  }

  player = level.dead_player;

  if(!isDefined(player)) {
    player = level.players[0];
  }

  player util::function_e05fc3fb(0);
  globallogic_ui::function_760546ce();
  globallogic_ui::function_cdbb5c49(1, 1);

  if(isDefined(player.mission_fail_menu)) {
    player setluimenudata(player.mission_fail_menu, #"missionfailreason", #"");
    player setluimenudata(player.mission_fail_menu, #"missionfailhint", #"");
    player closemenu("CPMissionFailed");
  }

  checkpointrestart();
}

function function_ffac0e3() {
  self endon(#"disconnect", #"camera_sequence_completed");
  level endon(#"game_ended");
  self clientfield::set_to_player("killcam_menu", 1);

  printtoprightln("<dev string:x38>", (1, 0, 1));

  while(self useButtonPressed()) {
    waitframe(1);
  }

  while(!self useButtonPressed()) {
    waitframe(1);
  }

  self.var_8fc85657 = 1;
  self clientfield::set_to_player("killcam_menu", 0);
  self notify(#"hash_149b5fe3276ace1c");
}

function function_c5eb768b() {
  if(!isDefined(self.var_ca00be20)) {
    self.var_ca00be20 = newdebughudelem(self);
    self.var_ca00be20.archived = 0;
    self.var_ca00be20.x = 0;
    self.var_ca00be20.alignx = "<dev string:x50>";
    self.var_ca00be20.aligny = "<dev string:x5a>";
    self.var_ca00be20.horzalign = "<dev string:x50>";
    self.var_ca00be20.vertalign = "<dev string:x64>";
    self.var_ca00be20.sort = 1;
    self.var_ca00be20.font = "<dev string:x6e>";
  }

  if(self issplitscreen()) {
    self.var_ca00be20.y = -100;
    self.var_ca00be20.fontscale = 1;
  } else {
    self.var_ca00be20.y = -180;
    self.var_ca00be20.fontscale = 1.5;
  }

  self.var_ca00be20 settext(#"hash_335a164eda0d56ff");
  self.var_ca00be20.alpha = 1;
}

function function_31c6ebd4() {
  self endon(#"disconnect", #"camera_sequence_completed", #"end_respawn");
  level endon(#"game_ended");

  self function_c5eb768b();
  printtoprightln("<dev string:x38>", (1, 0, 1));

  while(self useButtonPressed()) {
    waitframe(1);
  }

  while(!self useButtonPressed()) {
    waitframe(1);
  }

  self.var_8fc85657 = 1;
  self.var_ca00be20.alpha = 0;
}

function onplayerbleedout() {
  if(!is_true(level.var_ba2a141)) {
    foreach(player in level.players) {
      if(player != self && player.sessionstate != "dead" && player.sessionstate != "spectator") {
        return;
      }
    }
  }

  if(!is_true(level.level_ending)) {
    level thread fadeoutandloadcheckpoint();
  }

  level.level_ending = 1;

  if(!is_true(level.level_ending)) {
    errormsg("<dev string:x7b>");
  }
}

function wait_to_spawn() {
  self notify(#"wait_to_spawn_singleton");
  self endon(#"wait_to_spawn_singleton");

  if(is_true(level.inprematchperiod) || !isDefined(self.completedinitialspawn)) {
    self.completedinitialspawn = 1;
    return true;
  }

  hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], 15);
  level waittilltimeout(15, #"objective_changed");
  return true;
}

function respawn_spectators_on_objective_change() {
  level flag::wait_till("all_players_spawned");

  while(true) {
    level waittill(#"objective_changed");

    foreach(player in level.players) {
      if(player.sessionstate == "spectator" && globallogic_utils::isvalidclass(player.curclass)) {
        player globallogic_spawn::waitandspawnclient();
      }
    }
  }
}

function spawnedasspectator() {
  if(!isDefined(self.completedinitialspawn)) {
    return true;
  }

  return false;
}

function function_fd5dfc25() {
  self endon(#"death", #"disconnect");

  if(is_true(self.currentweapon.isheavyweapon)) {
    return;
  }

  a_weaponlist = self getweaponslist();
  var_4fd19a76 = [];

  foreach(weapon in a_weaponlist) {
    if(is_true(weapon.isheavyweapon)) {
      if(!isDefined(var_4fd19a76)) {
        var_4fd19a76 = [];
      } else if(!isarray(var_4fd19a76)) {
        var_4fd19a76 = array(var_4fd19a76);
      }

      var_4fd19a76[var_4fd19a76.size] = weapon;
    }
  }

  var_43dfbfaf = var_4fd19a76[0];

  if(isDefined(var_43dfbfaf)) {
    if(self getweaponammoclip(var_43dfbfaf) + self getweaponammostock(var_43dfbfaf) > 0) {
      if(isDefined(self.var_444b2634)) {
        if(gettime() - self.var_444b2634 > 90000) {
          switch (var_43dfbfaf.rootweapon.name) {
            case #"launcher_standard":
              if(self.var_83f25fdb < 5) {
                self util::show_hint_text(#"hash_3d4165067dc18a6b");
              }

              break;
            case #"spike_launcher":
              if(self.var_83f25fdb < 10) {
                self util::show_hint_text(#"hash_9b1201effcb0c57");
              }

              break;
            case #"micromissile_launcher":
              if(self.var_83f25fdb < 10) {
                self util::show_hint_text(#"hash_50d6975fce35fa60");
              }

              break;
          }
        }
      }
    }
  }
}

function function_bb5fae75() {
  self notify(#"hash_1d6b9f8f1e2663d9");
  self endon(#"death", #"hash_1d6b9f8f1e2663d9");

  for(var_543d6995 = 0; true; var_543d6995 = 0) {
    waitresult = self waittill(#"weapon_change");

    if(isDefined(waitresult.weapon)) {
      if(is_true(waitresult.weapon.isheavyweapon)) {
        if(!isDefined(self.var_83f25fdb)) {
          self.var_83f25fdb = 0;
        }

        self thread function_b296ed1c();
        var_543d6995 = 1;
        continue;
      }

      if(var_543d6995) {
        self.var_444b2634 = gettime();
      }

      self notify(#"hash_6afb6967ed216cca");
    }
  }
}

function function_b296ed1c() {
  self endon(#"death", #"hash_6afb6967ed216cca");

  while(true) {
    waitresult = self waittill(#"weapon_fired");

    if(is_true(waitresult.weapon.isheavyweapon)) {
      self.var_83f25fdb++;
    }
  }
}