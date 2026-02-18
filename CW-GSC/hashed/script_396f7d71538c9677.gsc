/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_396f7d71538c9677.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapon_utils;
#namespace battlechatter;

function dialog_chance(chancekey) {
  dialogchance = mpdialog_value(chancekey);

  if(!isDefined(dialogchance) || dialogchance <= 0) {
    return false;
  } else if(dialogchance >= 100) {
    return true;
  }

  return randomint(100) < dialogchance;
}

function mpdialog_value(mpdialogkey, defaultvalue) {
  if(!isDefined(mpdialogkey)) {
    return defaultvalue;
  }

  if(!isDefined(level.var_36301b61)) {
    level.var_36301b61 = getscriptbundle("mpdialog_default");
  }

  mpdialog = level.var_36301b61;

  if(!isDefined(mpdialog)) {
    return defaultvalue;
  }

  structvalue = mpdialog.(mpdialogkey);

  if(!isDefined(structvalue)) {
    return defaultvalue;
  }

  return structvalue;
}

function function_e05060f0(player) {
  playerbundle = function_58c93260(player);

  if(!isDefined(playerbundle)) {
    return undefined;
  }

  return playerbundle.voiceprefix;
}

function function_58c93260(player, meansofdeath) {
  if(!isPlayer(player)) {
    return undefined;
  }

  bundlename = player getmpdialogname();

  if(!isDefined(bundlename)) {
    return undefined;
  }

  if(isDefined(meansofdeath) && meansofdeath == "MOD_META" && isDefined(self.pers) && (isDefined(self.pers[# "changed_specialist"]) ? self.pers[# "changed_specialist"] : 0)) {
    bundlename = self.var_89c4a60f;
  }

  if(!isDefined(level.var_acb08231)) {
    level.var_acb08231 = [];
  }

  if(!isDefined(level.var_acb08231[bundlename])) {
    level.var_acb08231[bundlename] = getscriptbundle(bundlename);
  }

  return level.var_acb08231[bundlename];
}

function function_cdd81094(weapon) {
  assert(isDefined(weapon));

  if(!isDefined(weapon.var_5c238c21)) {
    return undefined;
  }

  if(!isDefined(level.var_acb08231)) {
    level.var_acb08231 = [];
  }

  if(!isDefined(level.var_acb08231[weapon.var_5c238c21])) {
    level.var_acb08231[weapon.var_5c238c21] = getscriptbundle(weapon.var_5c238c21);
  }

  return level.var_acb08231[weapon.var_5c238c21];
}

function function_e1983f22() {
  return sessionmodeismultiplayergame() || sessionmodeiszombiesgame();
}

function function_d804d2f0(speakingplayer, player, allyradiussq) {
  if(!isDefined(player) || !isDefined(player.origin) || !isDefined(speakingplayer) || !isDefined(speakingplayer.origin) || !isalive(player) || player.sessionstate != "playing" || player.playingdialog || player isplayerunderwater() || player isremotecontrolling() || player isinvehicle() || player isweaponviewonlylinked() || player == speakingplayer || player.team != speakingplayer.team || player.playerrole == speakingplayer.playerrole || player hasperk(#"specialty_quieter")) {
    return false;
  }

  distsq = distancesquared(speakingplayer.origin, player.origin);

  if(distsq > allyradiussq) {
    return false;
  }

  return true;
}

function function_5d15920e(dialogkey, playerbundle) {
  if(dialogkey === playerbundle.exertdeathdrowned) {
    return "MOD_DROWN";
  }

  if(dialogkey === playerbundle.var_44d86dec) {
    return "MOD_EXPLOSIVE";
  }

  if(dialogkey === playerbundle.exertdeathburned) {
    return "MOD_BURNED";
  }

  if(dialogkey === playerbundle.var_207908de) {
    return "MOD_HEAD_SHOT";
  }

  if(dialogkey === playerbundle.var_1dfcabbd) {
    return "MOD_FALLING";
  }

  if(dialogkey === playerbundle.exertdeath) {
    return "MOD_UNKNOWN";
  }

  if(dialogkey === playerbundle.var_48305ed9) {
    return "MOD_DOT_SELF";
  }

  if(dialogkey === playerbundle.var_f8b4bcc1) {
    return "MOD_DOT";
  }

  if(dialogkey === playerbundle.exertdeathstabbed) {
    return "MOD_MELEE_ASSASSINATE";
  }

  if(dialogkey === playerbundle.exertdeathelectrocuted) {
    return "MOD_ELECTROCUTED";
  }

  if(dialogkey === playerbundle.var_53f25688) {
    return "MOD_MELEE_WEAPON_BUTT";
  }

  if(dialogkey === playerbundle.var_7a45f37b) {
    return "MOD_GAS";
  }

  if(dialogkey === playerbundle.var_35f92256) {
    return "MOD_CRUSH";
  }

  return "MOD_UNKNOWN";
}

function get_closest_player_ally(teamonly) {
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

function get_closest_player_enemy(origin, teamonly) {
  if(!isDefined(self.team)) {
    return undefined;
  }

  if(!isDefined(origin)) {
    origin = self.origin;
  }

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

function can_play_dialog(teamonly) {
  if(!isPlayer(self) || !isalive(self) || self.playingdialog === 1 || self isplayerunderwater() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked()) {
    return false;
  }

  if(isDefined(teamonly) && !teamonly && self hasperk(#"specialty_quieter")) {
    return false;
  }

  return true;
}

function get_friendly_players() {
  players = [];

  if(level.teambased && isDefined(self.team)) {
    foreach(player in function_a1ef346b(self.team)) {
      players[players.size] = player;
    }
  } else {
    players[0] = self;
  }

  return players;
}

function get_enemy_players() {
  players = [];

  if(level.teambased) {
    foreach(team, _ in level.teams) {
      if(team == self.team) {
        continue;
      }

      foreach(player in function_a1ef346b(team)) {
        players[players.size] = player;
      }
    }
  } else {
    foreach(player in function_a1ef346b()) {
      if(player != self) {
        players[players.size] = player;
      }
    }
  }

  return players;
}

function function_94b5718c(entity) {
  selfeye = self geteyeapprox();

  foreach(enemy in get_enemy_players()) {
    if(!isDefined(enemy)) {
      continue;
    }

    enemyeye = enemy geteyeapprox();

    if(sighttracepassed(selfeye, enemyeye, 0, enemy)) {
      return enemy;
    }
  }

  return undefined;
}

function get_random_key(dialogkey) {
  bundlename = self getmpdialogname();

  if(!isDefined(bundlename)) {
    return undefined;
  }

  if(!isDefined(level.var_f53efe5c[bundlename]) || !isDefined(level.var_f53efe5c[bundlename][dialogkey]) || level.var_f53efe5c[bundlename][dialogkey] == 0) {
    return dialogkey;
  }

  return dialogkey + randomint(level.var_f53efe5c[bundlename][dialogkey]);
}

function get_player_dialog_alias(dialogkey, meansofdeath) {
  if(!isPlayer(self)) {
    return undefined;
  }

  bundlename = self getmpdialogname();

  if(isDefined(meansofdeath) && meansofdeath == "MOD_META" && (isDefined(self.pers[# "changed_specialist"]) ? self.pers[# "changed_specialist"] : 0)) {
    bundlename = self.var_89c4a60f;
  }

  if(!isDefined(bundlename)) {
    return undefined;
  }

  playerbundle = getscriptbundle(bundlename);

  if(!isDefined(playerbundle)) {
    return undefined;
  }

  if(!isDefined(playerbundle) || !isDefined(dialogkey)) {
    return undefined;
  }

  if(ishash(dialogkey)) {
    if(isDefined(level.var_4edd846)) {
      dialogalias = self[[level.var_4edd846]](playerbundle, dialogkey);
    } else {
      iprintlnbold("<dev string:x38>" + function_9e72a96(dialogkey) + "<dev string:x4d>");
    }
  } else {
    dialogalias = playerbundle.(dialogkey);
  }

  if(!isDefined(dialogalias)) {
    return;
  }

  if(!ishash(dialogalias)) {
    voiceprefix = playerbundle.voiceprefix;

    if(isDefined(voiceprefix)) {
      dialogalias = voiceprefix + dialogalias;
    }
  }

  return dialogalias;
}

function function_db89c38f(speakingplayer, allyradiussq) {
  allies = [];

  foreach(player in level.players) {
    if(!function_d804d2f0(speakingplayer, player, allyradiussq)) {
      continue;
    }

    allies[allies.size] = player;
  }

  allies = arraysort(allies, speakingplayer.origin);

  if(!isDefined(allies) || allies.size == 0) {
    return undefined;
  }

  return allies[0];
}

function pick_boost_players(player1, player2) {
  player1 clientfield::set("play_boost", 1);
  player2 clientfield::set("play_boost", 2);
  game.boostplayerspicked[player1.team] = 1;
}