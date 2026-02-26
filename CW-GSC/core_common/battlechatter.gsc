/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\battlechatter.gsc
***********************************************/

#using script_1f17c601c8e8824c;
#using script_396f7d71538c9677;
#using script_6d9bde564029bdf6;
#using script_725554a59d6a75b9;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weapon_utils;
#namespace battlechatter;

function private autoexec __init__system__() {
  system::register(#"battlechatter", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level thread devgui_think();

  callback::on_spawned(&on_player_spawned);
  callback::function_33f0ddd3(&function_33f0ddd3);
  callback::on_game_playing(&function_9cc82a74);

  if(is_true(level.teambased) && !isDefined(game.boostplayerspicked)) {
    game.boostplayerspicked = [];

    foreach(team, _ in level.teams) {
      game.boostplayerspicked[team] = 0;
    }
  }

  level.allowbattlechatter[#"bc"] = currentsessionmode() != 4 && (isDefined(getgametypesetting(#"allowbattlechatter")) ? getgametypesetting(#"allowbattlechatter") : 0);
  mpdialog = getscriptbundle("mpdialog_default");

  if(!isDefined(mpdialog)) {
    mpdialog = spawnStruct();
  }

  level.var_3602c1be = &playkillbattlechatter;
  level.allowspecialistdialog = (isDefined(mpdialog.enableherodialog) ? mpdialog.enableherodialog : 0) && is_true(level.allowbattlechatter[#"bc"]);
  level.playstartconversation = (isDefined(mpdialog.enableconversation) ? mpdialog.enableconversation : 0) && is_true(level.allowbattlechatter[#"bc"]);
  level.var_add8e0f2 = [#"frag_grenade", #"eq_sticky_grenade", #"eq_flash_grenade", #"eq_slow_grenade", #"willy_pete", #"nightingale", #"eq_molotov", #"satchel_charge", #"hatchet", #"land_mine", #"trophy_system"];
  level.var_648e79b7 = [];
  level.var_75aa0434 = [];
  level.var_e444d44 = 1;
}

function on_player_spawned() {
  self.enemythreattime = 0;
  self.heartbeatsnd = 0;
  self.soundmod = "player";
  self.voxunderwatertime = 0;
  self.voxemergebreath = 0;
  self.voxdrowning = 0;
  self.pilotisspeaking = 0;
  self.playingdialog = 0;
  self.playinggadgetreadydialog = 0;
  self.var_6765d33e = 0;
  self.playedgadgetsuccess = 1;
  self.var_d853c1af = function_58c93260(self).var_d853c1af;
  level.var_648e79b7[self getentitynumber()] = undefined;
  self callback::add_callback("weapon_melee", &function_90cedf5b);
}

function function_33f0ddd3(eventstruct) {
  self.var_d853c1af = function_58c93260(self).var_d853c1af;
}

function wait_play_dialog(waittime, dialogkey, dialogflags, dialogbuffer, enemy, endnotify) {
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

function function_f57e565f(dialogkey, entity, waittime) {
  self endon(#"death");
  level endon(#"game_ended");

  if(!isDefined(self) || is_true(self.playingdialog) || !isPlayer(self) || !isDefined(entity) || self == entity && self isplayerunderwater() || !isPlayer(entity)) {
    return;
  }

  dialogalias = entity get_player_dialog_alias(dialogkey, undefined);

  if(isDefined(waittime) && waittime > 0) {
    wait waittime;

    if(!isDefined(self) || is_true(self.playingdialog) || !isPlayer(self) || !isDefined(entity) || self == entity && self isplayerunderwater() || !isPlayer(entity)) {
      return;
    }
  }

  if(isDefined(dialogalias)) {
    self playsoundtoplayer(dialogalias, self);
    self thread wait_dialog_buffer(mpdialog_value("killstreakDialogBuffer", 0));
  }
}

function play_dialog(dialogkey, dialogflags, dialogbuffer, enemy) {
  dialogalias = self get_player_dialog_alias(dialogkey, undefined);
  function_a48c33ff(dialogalias, dialogflags, dialogbuffer, enemy);
}

function function_5896274(waittime, dialogalias, dialogflags, dialogbuffer, enemy, endnotify) {
  self endon(#"death");
  level endon(#"game_ended");

  if(isDefined(waittime) && waittime > 0) {
    if(isDefined(endnotify)) {
      self endon(endnotify);
    }

    wait waittime;
  }

  self thread function_a48c33ff(dialogalias, dialogflags, dialogbuffer, enemy);
}

function function_a48c33ff(dialogalias, dialogflags, dialogbuffer, enemy) {
  self endon(#"death");
  var_c84adc7e = !sessionmodeiswarzonegame() || !isDefined(dialogflags) || dialogflags & 128;

  if(!var_c84adc7e) {
    level endon(#"game_ended");
  }

  if(!isDefined(dialogalias) || !isPlayer(self) || !isalive(self) || level.gameended && !var_c84adc7e) {
    return;
  }

  if(!isDefined(dialogflags)) {
    dialogflags = 0;
  }

  if(!is_true(level.allowspecialistdialog) && (dialogflags & 16) == 0) {
    return;
  }

  if(is_true(level.var_28ebc1e8)) {
    dialogbuffer = float(max(isDefined(soundgetplaybacktime(dialogalias)) ? soundgetplaybacktime(dialogalias) : 500, 500)) / 1000;
  }

  if(!isDefined(dialogbuffer)) {
    dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
  }

  if(self isplayerunderwater() && !(dialogflags & 8)) {
    return;
  }

  if(is_true(self.playingdialog)) {
    if(!(dialogflags & 4)) {
      return;
    }

    if(sessionmodeiszombiesgame()) {
      if(isDefined(self.str_vo_being_spoken)) {
        self stop_dialog(self.str_vo_being_spoken);
      }
    } else {
      self stopsounds();
    }

    waitframe(1);
  }

  if(dialogflags & 32) {
    self.playinggadgetreadydialog = 1;
  }

  if(dialogflags & 64) {
    if(!isDefined(self.stolendialogindex)) {
      self.stolendialogindex = 0;
    }

    dialogalias = dialogalias + "_0" + self.stolendialogindex;
    self.stolendialogindex++;
    self.stolendialogindex %= 4;
  }

  if(dialogflags & 2) {
    if(self hasdobj() && self haspart("J_Head")) {
      self playsoundontag(dialogalias, "J_Head");
    }
  } else if(dialogflags & 1) {
    if(self hasdobj() && self haspart("J_Head")) {
      if(isDefined(enemy)) {
        self playsoundontag(dialogalias, "J_Head", self.team, enemy);
      } else {
        self playsoundontag(dialogalias, "J_Head", self.team);
      }
    }
  } else {
    self playlocalsound(dialogalias);
  }

  self notify(#"played_dialog");
  self thread wait_dialog_buffer(dialogbuffer);
}

function wait_dialog_buffer(dialogbuffer) {
  self endon(#"death", #"played_dialog", #"stop_dialog");
  level endon(#"game_ended");
  self.playingdialog = 1;

  if(isDefined(dialogbuffer) && dialogbuffer > 0) {
    wait dialogbuffer;
  }

  self.playingdialog = 0;
  self.var_6765d33e = 0;
  self.playinggadgetreadydialog = 0;
  self notify(#"done_speaking");
}

function stop_dialog(var_cdaf7797) {
  self notify(#"stop_dialog");

  if(isDefined(var_cdaf7797)) {
    self stopsound(var_cdaf7797);
  } else {
    self stopsounds();
  }

  self notify(#"done_speaking");
  self.playingdialog = 0;
  self.var_6765d33e = 0;
  self.playinggadgetreadydialog = 0;
}

function function_9d4a3d68(var_11317dc8, speakingplayer, secondplayer, weapon, startdelay, var_44e63719) {
  level endon(#"game_ended");
  speakingplayer endon(#"disconnect");
  assert(isDefined(var_11317dc8));
  assert(isPlayer(speakingplayer));
  startdelay = isDefined(startdelay) ? startdelay : 0;

  if(sessionmodeiszombiesgame()) {
    var_44e63719 = isDefined(var_44e63719) ? var_44e63719 : 1;
  } else {
    var_44e63719 = isDefined(var_44e63719) ? var_44e63719 : 4;
  }

  if(startdelay > 0) {
    wait startdelay;

    if(!isDefined(speakingplayer)) {
      return;
    }
  }

  speakingplayer playsoundevent(var_11317dc8, weapon, secondplayer);
  thread wait_dialog_buffer(var_44e63719);
}

function check_boost_start_conversation() {
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
    playerdialog = player getmpdialogname();

    for(i = playerindex; i < players.size; i++) {
      playeri = players[i];

      if(playerdialog != playeri getmpdialogname()) {
        pick_boost_players(player, playeri);
        return;
      }
    }

    playerindex++;
  }
}

function function_e6457410(var_5c238c21, attacker, victim, weapon, inflictor) {
  if(!isDefined(victim) || !isPlayer(victim) || victim hasperk(#"specialty_quieter")) {
    return false;
  }

  if(!isDefined(inflictor) || !isPlayer(weapon)) {
    return false;
  }

  if(!isDefined(attacker)) {
    return false;
  }

  if(!(isDefined(attacker.var_4a648cbd) ? attacker.var_4a648cbd : 0)) {
    return false;
  }

  var_49376124 = isDefined(attacker.var_14e8550b) ? attacker.var_14e8550b : 0;

  if(var_49376124 == 0) {
    return false;
  }

  return victim.var_3528f7e9 == var_49376124;
}

function function_46ac5cbb(victim) {
  if(!dialog_chance("specialKillChance")) {
    return undefined;
  }

  if(!isDefined(victim.currentweapon)) {
    return undefined;
  }

  var_5c238c21 = function_cdd81094(victim.currentweapon);

  if(!isDefined(var_5c238c21) || !isDefined(var_5c238c21.destroyedalias)) {
    return;
  }

  return var_5c238c21.destroyedalias;
}

function function_551980b7(speakingplayer, var_76787d10) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(var_76787d10)) {
    return;
  }

  if(!isDefined(speakingplayer) || !isPlayer(speakingplayer)) {
    return;
  }

  if(!isDefined(var_76787d10) || !isPlayer(var_76787d10)) {
    return;
  }

  var_daeb4f94 = function_58c93260(speakingplayer);
  var_2708cdb2 = function_58c93260(var_76787d10);

  if(!isDefined(var_daeb4f94) || !isDefined(var_2708cdb2)) {
    return;
  }

  if(!isDefined(var_daeb4f94.voiceprefix) || !isDefined(var_2708cdb2.var_ff5e0d8e)) {
    return;
  }

  thread function_9d4a3d68(6, speakingplayer, var_76787d10, level.weaponnone, 0, 4);
}

function function_bd715920(var_28b40381, attacker, eventorigin, eventobject, timedelay) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self)) {
    return;
  }

  if((isDefined(self.var_87b1ba00) ? self.var_87b1ba00 : 0) || (isDefined(eventobject.var_87b1ba00) ? eventobject.var_87b1ba00 : 0) || !isDefined(var_28b40381)) {
    return;
  }

  weaponbundle = function_cdd81094(var_28b40381);

  if(!isDefined(weaponbundle)) {
    return;
  }

  var_4a247dec = isDefined(weaponbundle.var_2bb73e97) ? weaponbundle.var_2bb73e97 : 0;
  var_2f741f8e = isDefined(weaponbundle.var_9715d1af) ? weaponbundle.var_9715d1af : 0;
  var_4e424b8b = isDefined(weaponbundle.var_c6face5d) ? weaponbundle.var_c6face5d : 0;
  var_494ab587 = isDefined(weaponbundle.var_97a93569) ? weaponbundle.var_97a93569 : 0;

  if(isDefined(var_4a247dec) ? var_4a247dec : 0) {
    if(isDefined(attacker) && isPlayer(attacker) && !attacker hasperk(#"specialty_quieter")) {
      if(isDefined(var_2f741f8e) ? var_2f741f8e : 0) {
        eventobject.var_87b1ba00 = 1;
      } else {
        self.var_87b1ba00 = 1;
      }

      attacker function_95e44f78(var_28b40381, timedelay);
      return;
    }

    return;
  }

  if(isDefined(eventorigin)) {
    players = self getenemies();
    allyradius = mpdialog_value("enemyContactAllyRadius", 0);
    enemydistance = mpdialog_value("enemyContactDistance", 0);

    foreach(player in players) {
      if(!isPlayer(player) || player hasperk(#"specialty_quieter")) {
        continue;
      }

      if(isDefined(attacker) && isPlayer(attacker) && player == attacker) {
        continue;
      }

      if(isDefined(var_4e424b8b) ? var_4e424b8b : 0) {
        if(distancesquared(eventorigin, player.origin) < sqr(allyradius)) {
          if(isDefined(var_494ab587) ? var_494ab587 : 0) {
            relativepos = vectornormalize(player.origin - eventorigin);
            dir = anglesToForward(self getplayerangles());
            dotproduct = vectordot(relativepos, dir);

            if(dotproduct > 0) {
              continue;
            }
          } else {
            continue;
          }
        }
      }

      if(distancesquared(eventorigin, player.origin) > sqr(enemydistance)) {
        continue;
      }

      eyepoint = player getEye();
      relativepos = vectornormalize(eventorigin - eyepoint);
      dir = anglesToForward(player getplayerangles());
      dotproduct = vectordot(relativepos, dir);

      if(dotproduct > 0) {
        if(sighttracepassed(eventorigin, eyepoint, 1, player, eventobject)) {
          if(isDefined(var_2f741f8e) ? var_2f741f8e : 0) {
            eventobject.var_87b1ba00 = 1;
          } else {
            self.var_87b1ba00 = 1;
          }

          player function_95e44f78(var_28b40381, timedelay);
          return;
        }
      }
    }
  }
}

function function_fc82b10(weapon, eventorigin, eventobject) {
  if(!isDefined(weapon)) {
    return;
  }

  weaponbundle = function_cdd81094(weapon);

  if(!isDefined(weaponbundle.var_ff5e0d8e)) {
    return;
  }

  if(isDefined(eventobject.var_87b1ba00) ? eventobject.var_87b1ba00 : 0) {
    return;
  }

  var_4e424b8b = isDefined(weaponbundle.var_c6face5d) ? weaponbundle.var_c6face5d : 0;

  if(isDefined(eventorigin)) {
    players = self getenemies();

    if(isDefined(players) && players.size > 0) {
      playerbundle = function_58c93260(players[0], undefined);

      if(!isDefined(playerbundle.voiceprefix)) {
        return;
      }

      dialogkey = playerbundle.voiceprefix + weaponbundle.var_ff5e0d8e;
      allyradius = mpdialog_value("enemyContactAllyRadius", 0);
      enemydistance = mpdialog_value("enemyContactDistance", 0);

      foreach(player in players) {
        if(!isPlayer(player) || player hasperk(#"specialty_quieter")) {
          continue;
        }

        distancetoplayer = distancesquared(eventorigin, player.origin);

        if(var_4e424b8b) {
          if(distancetoplayer < sqr(allyradius)) {
            relativepos = vectornormalize(player.origin - eventorigin);
            dir = anglesToForward(self getplayerangles());
            dotproduct = vectordot(relativepos, dir);

            if(dotproduct > 0) {
              continue;
            }
          }
        }

        if(distancetoplayer > sqr(enemydistance)) {
          continue;
        }

        eyepoint = player getEye();
        relativepos = vectornormalize(eventorigin - eyepoint);
        dir = anglesToForward(player getplayerangles());
        dotproduct = vectordot(relativepos, dir);

        if(dotproduct > 0) {
          if(sighttracepassed(eventorigin, eyepoint, 1, player, eventobject)) {
            eventobject.var_87b1ba00 = 1;
            player thread function_a48c33ff(dialogkey, 2);
            return;
          }
        }
      }
    }
  }
}

function function_95e44f78(weapon, timedelay) {
  playerbundle = function_58c93260(self, undefined);

  if(!isDefined(playerbundle) || !isDefined(playerbundle.voiceprefix)) {
    return;
  }

  var_5c238c21 = function_cdd81094(timedelay);

  if(!isDefined(var_5c238c21) || !isDefined(var_5c238c21.var_ff5e0d8e)) {
    return;
  }

  dialogkey = playerbundle.voiceprefix + var_5c238c21.var_ff5e0d8e;
  thread function_9d4a3d68(6, self, undefined, level.weaponnone, var_5c238c21.var_c4d151c8, var_5c238c21.var_4eb6c155);
}

function function_b06bbccf(sniper) {
  if(!function_e1983f22()) {
    return false;
  }

  if(!isDefined(sniper) || !isDefined(self) || !level.teambased || !is_true(level.allowspecialistdialog)) {
    return false;
  }

  if(!dialog_chance("sniperKillChance")) {
    return false;
  }

  closest_ally = self get_closest_player_ally(0);
  allyradius = mpdialog_value("sniperKillAllyRadius", 0);

  if(!isDefined(closest_ally) || distancesquared(self.origin, closest_ally.origin) > allyradius * allyradius) {
    return false;
  }

  voiceprefix = function_e05060f0(closest_ally);

  if(!isDefined(voiceprefix)) {
    return false;
  }

  playerbundle = function_58c93260(closest_ally);

  if(!isDefined(playerbundle) || !isDefined(playerbundle.threatsniper)) {
    return false;
  }

  var_a1886234 = voiceprefix + playerbundle.threatsniper;
  closest_ally thread function_a48c33ff(var_a1886234, 2);
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

  return true;
}

function function_bafe1ee4(weapon) {
  if(!function_e1983f22()) {
    return false;
  }

  voiceprefix = function_e05060f0(self);

  if(!isDefined(voiceprefix)) {
    return false;
  }

  weaponbundle = function_cdd81094(weapon);

  if(!isDefined(weaponbundle)) {
    return false;
  }

  dialogalias = voiceprefix + weaponbundle.var_2c07bbf1;
  self thread function_a48c33ff(dialogalias, 6);
  return true;
}

function function_d2600afc(attacker, owner, gadgetweapon, attackerweapon) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(attacker) || !isPlayer(attacker) || attacker hasperk(#"specialty_quieter")) {
    return;
  }

  if(!isDefined(gadgetweapon) || isDefined(owner) && owner == attacker) {
    return;
  }

  if(isDefined(level.var_98769415)) {
    if(isDefined(attackerweapon) && isDefined([[level.var_98769415]](attackerweapon))) {
      return;
    }
  }

  var_5c238c21 = function_cdd81094(gadgetweapon);

  if(!isDefined(var_5c238c21) || !isDefined(var_5c238c21.destroyedalias)) {
    return;
  }

  thread function_9d4a3d68(9, attacker, undefined, gadgetweapon, var_5c238c21.var_8f77c9dd, var_5c238c21.var_51812235);
}

function playkillbattlechatter(dialogkey, attacker, weapon, victim, inflictor) {
  if(!is_true(level.allowspecialistdialog)) {
    return;
  }

  if(!isDefined(attacker) || !isPlayer(attacker) || !isalive(attacker) || attacker isremotecontrolling() || attacker isweaponviewonlylinked() || attacker hasperk(#"specialty_quieter")) {
    return;
  }

  var_7370ffbd = isvehicle(inflictor);

  if(!var_7370ffbd && attacker isinvehicle()) {
    return;
  }

  if(isDefined(inflictor) && inflictor.classname != "worldspawn" && !isPlayer(inflictor) && inflictor.birthtime < attacker.spawntime && !var_7370ffbd) {
    return;
  }

  if((isDefined(self.var_2b0c267) ? self.var_2b0c267 : 0) > gettime()) {
    return;
  }

  var_9074cacb = function_58c93260(attacker);

  if(!isDefined(var_9074cacb)) {
    return;
  }

  if(isDefined(dialogkey)) {
    suffix = var_9074cacb.(dialogkey);
  } else if(isDefined(victim)) {
    var_5c238c21 = function_cdd81094(weapon);
    var_25db02aa = victim function_e6457410(var_5c238c21, attacker, victim, weapon, inflictor);

    if(var_25db02aa) {
      var_71449560 = isDefined(var_5c238c21.var_9ccf7d8b) ? var_5c238c21.var_9ccf7d8b : 4;

      if(isDefined(var_5c238c21.var_48b8bd2c)) {
        var_71449560 += isDefined(var_5c238c21.var_c4d151c8) ? var_5c238c21.var_c4d151c8 : 0;
        var_71449560 += isDefined(var_5c238c21.var_4eb6c155) ? var_5c238c21.var_4eb6c155 : 4;
      }

      thread function_9d4a3d68(0, attacker, undefined, weapon, var_5c238c21.var_57c1e152, var_71449560);
      return;
    }

    if(var_25db02aa || weapon.skipbattlechatterkill) {
      return;
    }

    if(isPlayer(victim) && dialog_chance("enemyKillChance")) {
      suffix = function_46ac5cbb(victim);

      if(!isDefined(suffix) && isDefined(victim.spottedtime) && victim.spottedtime + mpdialog_value("enemySniperKillTime", 0) >= gettime() && array::contains(victim.spottedby, attacker) && dialog_chance("enemySniperKillChance")) {
        suffix = var_9074cacb.("killSniper");
      }

      if(!isDefined(suffix)) {
        if(randomfloatrange(0, 1) < 0.8) {
          suffix = var_9074cacb.killgeneric;
        } else if(victim util::is_female()) {
          suffix = var_9074cacb.var_3823c559;
        } else {
          suffix = var_9074cacb.var_9903c3b;
        }
      }
    }

    victim.spottedtime = undefined;
    victim.spottedby = undefined;
  }

  if(isDefined(suffix) && isDefined(var_9074cacb.voiceprefix)) {
    killdialog = var_9074cacb.voiceprefix + suffix;
  }

  if(!isDefined(killdialog) || inflictor.var_259f6c17 === 1) {
    return;
  }

  self.var_2b0c267 = gettime() + int(mpdialog_value("enemyKillCooldown", 7) * 1000);
  attacker thread function_5896274(mpdialog_value("enemyKillDelay", 0), killdialog, 2, undefined, victim, "cancel_kill_dialog");
}

function function_b5242998() {
  self endon(#"death");
  level endon(#"game_ended");

  if(!is_true(level.teambased) || !is_true(level.allowspecialistdialog)) {
    return;
  }

  allies = [];
  allyradiussq = mpdialog_value("playerVoiceRadius", 0);
  allyradiussq *= allyradiussq;

  foreach(player in level.players) {
    if(!isDefined(player) || !isalive(player) || player.sessionstate != "playing" || player == self || player hasperk(#"specialty_quieter") || util::function_fbce7263(player.team, self.team)) {
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

    player play_dialog("heroWeaponSuccessReaction", 2);
    break;
  }
}

function function_f5b398b6() {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self) || self hasperk(#"specialty_quieter")) {
    return;
  }

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
    if(player == self) {
      continue;
    }

    playerdialog = player getmpdialogname();

    if(!isDefined(playerdialog) || playerdialog == selfdialog || !player can_play_dialog(1) || distancesquared(self.origin, player.origin) >= voiceradiussq) {
      continue;
    }

    dialogalias = player get_player_dialog_alias("promotionReaction", undefined);

    if(!isDefined(dialogalias)) {
      continue;
    }

    ally = player;
    break;
  }

  if(isDefined(ally)) {
    if(ally hasdobj() && ally haspart("J_Head")) {
      ally playsoundontag(dialogalias, "J_Head", undefined, self);
    } else {
      ally playsoundontag(dialogalias, "tag_origin", undefined, self);
    }

    ally thread wait_dialog_buffer(mpdialog_value("playerDialogBuffer", 0));
  }
}

function function_576ff6fe(killstreaktype) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self) || self hasperk(#"specialty_quieter")) {
    return;
  }

  if(!isDefined(killstreaktype) || !isDefined(level.killstreaks[killstreaktype])) {
    return;
  }

  if(!isDefined(level.killstreaks[killstreaktype].script_bundle.var_c236921c)) {
    return;
  }

  playerbundle = function_58c93260(self);

  if(!isDefined(playerbundle) || !isDefined(playerbundle.voiceprefix)) {
    return;
  }

  dialogalias = playerbundle.voiceprefix + level.killstreaks[killstreaktype].script_bundle.var_c236921c;
  self thread function_a48c33ff(dialogalias, 1);
}

function playkillstreakthreat(killstreaktype) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self) || self hasperk(#"specialty_quieter")) {
    return;
  }

  if(!isDefined(killstreaktype) || !isDefined(level.killstreaks[killstreaktype])) {
    return;
  }

  if(!isDefined(level.killstreaks[killstreaktype].script_bundle.var_aef5ea0a)) {
    return;
  }

  playerbundle = function_58c93260(self);

  if(!isDefined(playerbundle) || !isDefined(playerbundle.voiceprefix)) {
    return;
  }

  dialogalias = playerbundle.voiceprefix + level.killstreaks[killstreaktype].script_bundle.var_aef5ea0a;

  if(killstreaks::function_c5927b3f(killstreaks::get_killstreak_weapon(killstreaktype))) {
    self thread function_a48c33ff(dialogalias, 1);
    return;
  }

  self thread function_a48c33ff(dialogalias, 2);
}

function function_eebf94f6(killstreaktype, weapon) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self) || self hasperk(#"specialty_quieter")) {
    return;
  }

  if(isDefined(level.var_98769415)) {
    if(!isDefined(weapon) || !isDefined(level.killstreaks[weapon])) {
      return;
    }
  }

  if(!isDefined(level.killstreaks[weapon].script_bundle.var_1b390aa1)) {
    return;
  }

  playerbundle = function_58c93260(self);

  if(!isDefined(playerbundle) || !isDefined(playerbundle.voiceprefix)) {
    return;
  }

  thread function_9d4a3d68(11, self, undefined, killstreaks::get_killstreak_weapon(weapon));
}

function playgadgetready(weapon, userflip = 0) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self) || self hasperk(#"specialty_quieter")) {
    return;
  }

  if(!isDefined(weapon) || gettime() - (isDefined(level.starttime) ? level.starttime : 0) < int(mpdialog_value("readyAudioDelay", 0) * 1000)) {
    return;
  }

  var_5c238c21 = function_cdd81094(weapon);

  if(!isDefined(var_5c238c21) || !isDefined(var_5c238c21.var_788c5852)) {
    return;
  }

  playerbundle = function_58c93260(self);

  if(!isDefined(playerbundle) || !isDefined(playerbundle.voiceprefix)) {
    return;
  }

  dialogkey = playerbundle.voiceprefix + var_5c238c21.var_788c5852;

  if(!is_true(self.isthief) && !is_true(self.isroulette)) {
    self thread function_a48c33ff(dialogkey, 2);
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

    if(is_true(self.isthief)) {
      delaykey = "thiefFlipDelay";
    } else {
      delaykey = "rouletteFlipDelay";
    }

    waittime = mpdialog_value(delaykey, minwaittime);
    dialogflags += 64;
  } else {
    if(is_true(self.isthief)) {
      generickey = playerbundle.thiefweaponready;
      repeatkey = playerbundle.thiefweaponrepeat;
      repeatthresholdkey = "thiefRepeatThreshold";
      chancekey = "thiefReadyChance";
      delaykey = "thiefRevealDelay";
    } else {
      generickey = playerbundle.rouletteabilityready;
      repeatkey = playerbundle.rouletteabilityrepeat;
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

  self thread function_5896274(waittime, dialogkey, dialogflags, undefined, undefined, undefined);
}

function function_1d4b0ec0(dogstate, dog) {
  if(!is_true(level.allowspecialistdialog)) {
    return;
  }

  if(!isDefined(dog)) {
    return;
  }

  if(!isDefined(self.script_owner) || !isPlayer(self.script_owner) || self.script_owner hasperk(#"specialty_quieter")) {
    return;
  }

  bundlename = self.script_owner getmpdialogname();

  if(!isDefined(bundlename)) {
    return;
  }

  playerbundle = getscriptbundle(bundlename);

  if(!isDefined(playerbundle)) {
    return;
  }

  dialogkey = undefined;

  switch (dog) {
    case 0:
      dialogkey = playerbundle.var_499ffcee;
      break;
    case 1:
      dialogkey = playerbundle.var_38ab9818;
      break;
    default:
      return;
  }

  self.script_owner thread function_a48c33ff(dialogkey);
}

function function_e3ebbf87(var_aa988d26, var_c1132df6) {
  if(!isDefined(var_aa988d26) || !isDefined(self) || !isPlayer(self)) {
    return;
  }

  self notify("65648e39688585a");
  self endon("65648e39688585a");
  self endon(#"death", #"disconnect");

  if(!sessionmodeiswarzonegame()) {
    level endon(#"game_ended");
  }

  waittime = mpdialog_value("calloutTriggerDelay", 0);
  wait waittime;

  if(!isDefined(self) || !isPlayer(self) || self isplayerunderwater()) {
    return;
  }

  if(is_true(self.playingdialog)) {
    return;
  }

  dialogbundle = function_58c93260(self);

  if(!isDefined(dialogbundle) || !isDefined(dialogbundle.voiceprefix)) {
    return;
  }

  if(!is_true(var_c1132df6) && !isDefined(var_aa988d26.var_4bc5b617) || is_true(var_c1132df6) && !isDefined(var_aa988d26.var_5cb8190f)) {
    return;
  }

  var_4bc5b617 = is_true(var_c1132df6) ? var_aa988d26.var_5cb8190f : var_aa988d26.var_4bc5b617;
  dialogalias = dialogbundle.voiceprefix + var_4bc5b617;
  dialogbuffer = mpdialog_value("calloutDialogBuffer", 0);
  self thread function_a48c33ff(dialogalias, 146, dialogbuffer);
}

function function_fff18afc(dialogkey, var_4d5833c) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self)) {
    return;
  }

  if(!isDefined(dialogkey) || self isplayerunderwater()) {
    return;
  }

  dialogbuffer = mpdialog_value("killstreakDialogBuffer", 0);
  voiceprefix = function_e05060f0(self);

  if(isDefined(voiceprefix)) {
    dialogalias = voiceprefix + dialogkey;
  } else {
    dialogalias = dialogkey;
  }

  if(is_true(level.var_28ebc1e8)) {
    dialogbuffer = float(max(isDefined(soundgetplaybacktime(dialogalias)) ? soundgetplaybacktime(dialogalias) : 500, 500)) / 1000;
  }

  if(!self hasperk(#"specialty_quieter")) {
    self function_a48c33ff(dialogalias, 5, dialogbuffer, undefined);
  }

  var_cf210c5b = self get_player_dialog_alias(var_4d5833c, undefined);

  if(isDefined(var_cf210c5b)) {
    self function_253c2ba4(var_cf210c5b, dialogbuffer);
  }
}

function function_cad61ec(weapon) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self)) {
    return;
  }

  if(!isDefined(weapon) || !isalive(self) || level.gameended || self isplayerunderwater()) {
    return;
  }

  var_5c238c21 = function_cdd81094(weapon);

  if(!isDefined(var_5c238c21) || !isDefined(var_5c238c21.deployalias)) {
    return;
  }

  thread function_9d4a3d68(8, self, undefined, weapon, var_5c238c21.var_25b5335a, var_5c238c21.var_373ebd09);
}

function function_916b4c72(weapon) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self) || self hasperk(#"specialty_quieter")) {
    return;
  }

  if(!isDefined(weapon) || !isalive(self) || level.gameended || (isDefined(self.var_8720dd77) ? self.var_8720dd77 : 0) > gettime() || self isplayerunderwater()) {
    return;
  }

  playerbundle = function_58c93260(self, undefined);

  if(!isDefined(playerbundle) || !isDefined(playerbundle.voiceprefix)) {
    return;
  }

  var_5c238c21 = function_cdd81094(weapon);

  if(!isDefined(var_5c238c21) || !isDefined(var_5c238c21.var_931a4bf8)) {
    return;
  }

  dialogkey = playerbundle.voiceprefix + var_5c238c21.var_931a4bf8;
  self.var_8720dd77 = gettime() + int(mpdialog_value("useFailDelay", 5) * 1000);
  self playsoundtoplayer(dialogkey, self);
  self thread wait_dialog_buffer(mpdialog_value("playerDialogBuffer", 0));
}

function function_4b6a650d(weapon) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self)) {
    return;
  }

  if(!isDefined(weapon) || self isplayerunderwater()) {
    return;
  }

  playerbundle = function_58c93260(self, undefined);

  if(!isDefined(playerbundle) || !isDefined(playerbundle.voiceprefix)) {
    return;
  }

  var_5c238c21 = function_cdd81094(weapon);

  if(!isDefined(var_5c238c21) || !isDefined(var_5c238c21.equipalias)) {
    return;
  }

  thread function_9d4a3d68(10, self, undefined, weapon, var_5c238c21.var_79b79488, var_5c238c21.var_eeb8e319);
}

function function_26dd1669(weapon) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self)) {
    return;
  }

  if(!isDefined(weapon) || self isplayerunderwater()) {
    return;
  }

  if(self.var_108457e7[weapon.name] === 1) {
    return;
  }

  playerbundle = function_58c93260(self, undefined);

  if(!isDefined(playerbundle) || !isDefined(playerbundle.voiceprefix)) {
    return;
  }

  var_5c238c21 = function_cdd81094(weapon);

  if(!isDefined(var_5c238c21) || !isDefined(var_5c238c21.usealias)) {
    self function_624f04c6(playerbundle);
    return;
  }

  if(isinarray(level.var_add8e0f2, weapon.rootweapon.name) && randomfloatrange(0, 1) < 0.5) {
    self function_624f04c6(playerbundle);
    return;
  }

  thread function_9d4a3d68(7, self, undefined, weapon, var_5c238c21.var_14da1618, var_5c238c21.var_b76b8205);
}

function private function_253c2ba4(var_cf210c5b, dialogbuffer) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self) || !isDefined(var_cf210c5b)) {
    return;
  }

  if(!isDefined(dialogbuffer)) {
    dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
  }

  teamarray = getplayers(self.team);

  if(self hasperk(#"specialty_quieter")) {
    arrayremovevalue(teamarray, self, 0);
  } else {
    localplayers = getplayers(self.team, self.origin, 1200);

    foreach(localplayer in localplayers) {
      arrayremovevalue(teamarray, localplayer, 0);
    }
  }

  foreach(player in teamarray) {
    if(!isDefined(player) || !isalive(player) || is_true(player.playingdialog) && !is_true(player.var_6765d33e)) {
      continue;
    }

    player.var_6765d33e = 0;
    player playsoundtoplayer(var_cf210c5b, player);
    player thread wait_dialog_buffer(dialogbuffer);
  }
}

function play_gadget_success(weapon, waitkey, victim, var_5d738b56) {
  if(!is_true(level.allowspecialistdialog) || !isDefined(self) || !isPlayer(self) || self hasperk(#"specialty_quieter")) {
    return;
  }

  if(!isDefined(victim) || !level.teambased) {
    return;
  }

  var_5c238c21 = function_cdd81094(victim);

  if(!isDefined(var_5c238c21) || !isDefined(var_5c238c21.var_c8d8482c)) {
    return;
  }

  self.playedgadgetsuccess = 1;
  var_71449560 = isDefined(var_5c238c21.var_9ccf7d8b) ? var_5c238c21.var_9ccf7d8b : 4;

  if(isDefined(var_5c238c21.var_48b8bd2c)) {
    var_71449560 += isDefined(var_5c238c21.var_c4d151c8) ? var_5c238c21.var_c4d151c8 : 0;
    var_71449560 += isDefined(var_5c238c21.var_4eb6c155) ? var_5c238c21.var_4eb6c155 : 4;
  }

  thread function_9d4a3d68(0, self, var_5d738b56, victim, var_5c238c21.var_57c1e152, var_71449560);
}

function function_98898d14(player, objective) {
  if(isDefined(objective.var_76975be4[player.team]) && objective.var_b4ea8d3f[player.team] + int(20 * 1000) < gettime()) {
    return;
  }

  if(randomfloatrange(0, 1) < 0.25) {
    var_57fce7c = function_8c4b101f(player.team, player.origin, 360);

    if(var_57fce7c.size >= 2) {
      player play_dialog("captureStartObjective", 1);
      objective.var_b4ea8d3f[player.team] = gettime();
    }
  }
}

function function_924699f4(player, objective) {
  if(isDefined(objective.var_2a30805a[player.team]) && objective.var_fe3d79b9[player.team] + int(20 * 1000) < gettime()) {
    return;
  }

  if(randomfloatrange(0, 1) < 0.25) {
    var_57fce7c = function_8c4b101f(player.team, player.origin, 360);

    if(var_57fce7c.size >= 2) {
      player play_dialog("capturedObjective", 1);
      objective.var_fe3d79b9[player.team] = gettime();
    }
  }
}

function game_end_vox(winner) {
  if(!is_true(level.allowspecialistdialog)) {
    return;
  }

  foreach(player in level.players) {
    if(player issplitscreen()) {
      continue;
    }

    bundlename = player getmpdialogname();

    if(!isDefined(bundlename)) {
      return;
    }

    playerbundle = getscriptbundle(bundlename);

    if(!isDefined(playerbundle.voiceprefix)) {
      return;
    }

    if(isDefined(winner) && level.teambased && isDefined(level.teams[winner]) && player.pers[#"team"] == winner || !level.teambased && player == winner) {
      dialogkey = playerbundle.boostwin;
    } else {
      dialogkey = playerbundle.boostloss;
    }

    if(isDefined(playerbundle.voiceprefix) && isDefined(dialogkey)) {
      player playlocalsound(playerbundle.voiceprefix + dialogkey);
    }
  }
}

function function_72b65730() {
  bundlename = self getmpdialogname();

  if(!isDefined(bundlename)) {
    return;
  }

  playerbundle = getscriptbundle(bundlename);

  if(!isDefined(playerbundle)) {
    return;
  }

  dialogkey = playerbundle.var_96b4150c;
  waittime = mpdialog_value("playerExertBuffer", 0);
  thread function_5896274(waittime, dialogkey, 2);
}

function heavyweaponkilllogic(attacker, weapon, victim) {
  if(!isDefined(attacker.heavyweaponkillcount)) {
    attacker.heavyweaponkillcount = 0;
  }

  attacker.heavyweaponkillcount++;

  if(!is_true(attacker.playedgadgetsuccess) && attacker.heavyweaponkillcount >= mpdialog_value("heroWeaponKillCount", 0)) {
    attacker thread play_gadget_success(weapon, "enemyKillDelay", victim);
    attacker thread function_b5242998();
  }
}

function function_9cc82a74() {
  if(!function_e1983f22()) {
    return;
  }

  self notify("738694dfda3636e4");
  self endon("738694dfda3636e4");
  level endon(#"match_end");

  while(true) {
    level waittill(#"hash_6c17824062de93e5");

    while(true) {
      if(level.var_648e79b7.size == 0) {
        break;
      }

      var_d465d941 = [];

      foreach(key, entry in level.var_648e79b7) {
        if(entry.timestamp < gettime()) {
          dialogkey = undefined;
          attacker = getentbynum(key);
          weapon = entry.weapon;
          victim = entry.victim;
          einflictor = entry.einflictor;
          var_46604f00 = level.var_42648a02[entry.statname];

          if(isDefined(var_46604f00)) {
            dialogkey = var_46604f00[2];
            var_e76fd8fa = var_46604f00[4];
          }

          if(isDefined(level.var_3602c1be)) {
            if(is_false(attacker.playingdialog)) {
              [[level.var_3602c1be]](dialogkey, attacker, weapon, victim, einflictor);
              level thread function_d8bd5eb9(attacker, var_e76fd8fa);
            }
          }

          if(!isDefined(var_d465d941)) {
            var_d465d941 = [];
          } else if(!isarray(var_d465d941)) {
            var_d465d941 = array(var_d465d941);
          }

          var_d465d941[var_d465d941.size] = entry;
          level.var_75aa0434 = [];
        }
      }

      foreach(entry in var_d465d941) {
        arrayremovevalue(level.var_648e79b7, entry, 1);
      }

      wait 0.1;
    }
  }
}

function function_d8bd5eb9(player, var_e76fd8fa) {
  if(!isDefined(var_e76fd8fa) || randomfloatrange(0, 1) < 0.25) {
    return;
  }

  wait 3;

  if(!isPlayer(player) || player hasperk(#"specialty_quieter")) {
    return;
  }

  voiceradius = mpdialog_value("playerVoiceRadius", 0);
  allies = function_8c4b101f(player.team, player.origin, voiceradius);
  allies = arraysort(allies, player.origin);
  selfdialog = player getmpdialogname();

  foreach(ally in allies) {
    if(ally == player) {
      continue;
    }

    playerdialog = ally getmpdialogname();

    if(!isDefined(playerdialog) || playerdialog == selfdialog || !ally can_play_dialog(1)) {
      continue;
    }

    if(var_e76fd8fa == 1) {
      dialogalias = ally get_player_dialog_alias("congratulateLarge");
    } else {
      dialogalias = ally get_player_dialog_alias("congratulateSmall");
    }

    if(isDefined(dialogalias)) {
      break;
    }
  }

  if(isDefined(ally) && isDefined(dialogalias)) {
    if(ally hasdobj() && ally haspart("J_Head")) {
      ally playsoundontag(dialogalias, "J_Head", undefined, player);
    } else {
      ally playsoundontag(dialogalias, "tag_origin", undefined, player);
    }

    ally thread wait_dialog_buffer(mpdialog_value("playerDialogBuffer", 0));
  }
}

function event_handler[event_8da88658] function_382adb6c(params) {
  self endon(#"death");
  level endon(#"game_ended");

  if(!(isDefined(self) && isDefined(params)) || !isPlayer(self) || params.isattacker !== 1) {
    return;
  }

  dialogbundle = function_58c93260(self);

  if(!isDefined(dialogbundle.voiceprefix)) {
    return;
  }

  var_eb7a15a5 = dialogbundle.executionkills;

  foreach(execution in var_eb7a15a5) {
    if(execution.executionname === params.executionname) {
      suffix = execution.var_e265e63e;
      delay = execution.var_8e1cee6b;
      break;
    }
  }

  if(!isDefined(suffix)) {
    return;
  }

  if(isDefined(delay)) {
    wait delay;
  }

  self function_a48c33ff(dialogbundle.voiceprefix + suffix, 2);
}

function event_handler[player_callout] function_6bd27812(params) {
  dialogkey = params.var_91cd890c;

  if(isDefined(dialogkey)) {
    if(params.var_fb597e32 === 1) {
      self play_dialog(dialogkey, 2);
      return;
    }

    self play_dialog(dialogkey, 1);
    return;
  }

  dialogbundle = function_58c93260(self);

  if(!isDefined(dialogbundle.voiceprefix)) {
    return;
  }

  var_329e32aa = dialogbundle.gestures;

  if(isDefined(params.var_e0ae7605)) {
    var_dc42e861 = params.var_e0ae7605;

    if(var_dc42e861 >= 38) {
      var_dc42e861++;
    }

    foreach(gesture in var_329e32aa) {
      if(gesture.gestureindex == var_dc42e861) {
        suffix = gesture.var_723e292;
        delay = gesture.var_87e637b;
        break;
      }
    }
  }

  if(!isDefined(suffix)) {
    return;
  }

  if(isDefined(delay)) {
    wait delay;
  }

  if(isDefined(self)) {
    self function_a48c33ff(dialogbundle.voiceprefix + suffix, 2);
  }
}