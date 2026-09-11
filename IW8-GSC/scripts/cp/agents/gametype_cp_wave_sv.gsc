/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\agents\gametype_cp_wave_sv.gsc
*****************************************************/

function givestreakpointswithtext(var_0, var_1, var_2) {
  if(isDefined(level.ignorescoring)) {
    return;
  }

  if(isDefined(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_1);
  }

  var_3 = modifyunifiedpoints(var_1, var_3, var_2);
  displayscoreeventpoints(var_3, var_1);
}

function giveunifiedpoints(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level.ignorescoring) && !issubstr(var_0, "assist")) {
    return;
  }

  if(isDefined(var_2)) {
    var_6 = var_2;
  } else {
    var_6 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_1);
  }

  var_6 = modifyunifiedpoints(var_1, var_6, var_2);
  var_7 = var_1 == "kill";
  var_8 = 0;
  var_9 = 0;
  var_10 = istrue(self.isjuggernaut);
  var_11 = update_objective_setmlgbackground(var_2);
  var_12 = scripts\cp\utility::_hasperk("specialty_killstreak_to_scorestreak");
  var_13 = var_9 && scripts\cp\utility::_hasperk("specialty_chain_killstreaks") && istrue(var_6);

  if(isDefined(var_5)) {
    if(isDefined(self.ref_119d4) && self.ref_119d4.size > 0) {
      if(istrue(self.ref_119d4[var_5 getentitynumber()])) {
        self.ref_119d4[var_5 getentitynumber()] = undefined;
        return;
      }
    }
  }

  if((var_7 || var_8 || var_13 || var_12) && (!var_10 || var_13 || var_12) && (!var_11 || var_12)) {}

  if(level.gametype == "cp_survival") {
    if(!isDefined(var_2)) {
      thread screenent_a(var_6);
    }
  }

  if(!istrue(var_4)) {
    thread scripts\cp\drone\emp_drone::giverankxp(var_1, var_6, var_2);
  }
}

function screenent_a(var_0) {
  var_1 = scripts\cp\cp_persistence::quickdropremovearmorfrominventory();
  var_0 = scripts\cp\cp_gamescore::round_up_to_nearest(var_0, 5);

  if(isDefined(self.ref_13bf3) && isDefined(self.ref_11b67)) {
    if(self.ref_13bf3 > self.ref_11b67) {
      var_0 = 0;
    } else {
      self.ref_13bf3 += var_0;
    }
  }

  var_2 = scripts\cp\cp_persistence::get_player_max_currency();
  var_3 = var_1 + var_0;
  var_3 = min(var_3, var_2);
  scripts\cp\cp_persistence::ref_130aa(var_3);
}

function modifyunifiedpoints(var_0, var_1, var_2) {
  switch (var_0) {
    case "damage":
      return 0;
    default:
      break;
  }

  var_3 = 0;

  if(var_0 == "kill" && var_2 hasattachment("gunperk_xp")) {
    var_3 += 20;
  }

  var_1 += var_3;

  if(isDefined(level.modifyunifiedpointscallback)) {
    var_1 = [[level.modifyunifiedpointscallback]](var_1, var_0, self, var_2);
  }

  return int(var_1);
}

function displayscoreeventpoints(var_0, var_1) {
  if(getdvarint("scr_disableScoreSplash", 0) == 1) {
    return;
  }

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  } else if(isDefined(self.totalxpearned) && isDefined(self.ref_11b7f)) {
    if(self.totalxpearned >= self.ref_11b7f) {
      return;
    }
  }

  if(level.codcasterenabled) {
    foreach(var_3 in level.players) {
      if(var_3 ismlgspectator()) {
        var_4 = var_3 getspectatingplayer();

        if(isDefined(var_4)) {
          var_5 = var_4 getentitynumber();
          var_6 = self getentitynumber();

          if(var_5 == var_6) {
            var_3 thread scripts\cp\drone\emp_drone::scorepointspopup(var_0);
            var_3 thread scripts\cp\drone\emp_drone::scoreeventpopup(var_1);
          }
        }
      }
    }
  }

  if(!isDefined(level.skippointdisplayxp)) {
    var_8 = 0;

    if(scripts\cp\utility::issimultaneouskillenabled()) {
      var_8 = var_1 == "kill";
    }

    thread scripts\cp\drone\emp_drone::scorepointspopup(var_0, var_8);
    return;
  }
}

function update_objective_setmlgbackground(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isstring(var_0)) {
    var_0 = getcompleteweaponname(var_0);
  }

  switch (var_0.basename) {
    case "bradley_tow_proj_mp":
    case "lighttank_tur_mp":
    case "tur_apc_rus_mp":
      return true;
  }

  return false;
}

function unset_relic_doomslayer(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isstring(var_0)) {
    var_0 = getcompleteweaponname(var_0);
  }

  switch (var_0.basename) {
    case "deploy_juggernaut_mp":
    case "deploy_airdrop_mp":
    case "iw8_green_beam_mp":
    case "iw8_spotter_scope_mp":
      return true;
  }

  return false;
}

function calculatematchbonus(var_0, var_1) {
  var_2 = 250;
  var_3 = var_1 / 60;
  var_4 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_0);
  var_5 = self.timeplayed["total"] / var_1;

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    var_3 = 1;
    var_5 = 1;
  }

  var_6 = scripts\cp\drone\emp_drone::getgametypexpmultiplier();
  var_7 = int(var_2 * var_4 * var_3 * var_5 * var_6);
  return var_7;
}

function updatematchbonusscores(var_0) {
  if(istrue(level.forcedend)) {
    var_1 = scripts\cp\cp_endgame::get_play_time() / 1000;
    var_1 = min(var_1, 1200);
  } else {
    var_1 = scripts\cp\cp_endgame::get_play_time() / 1000;
  }

  jumpiffalse(level.teambased) LOC_000001a7;
  jumpiffalse(var_1 != "tie") LOC_00000044;
  setwinningteam(var_1);

  foreach(var_3 in level.players) {
    if(isDefined(var_3.connectedpostgame)) {
      continue;
    }

    if(var_3.timeplayed["total"] < 1 || var_3.pers["participation"] < 1) {
      continue;
    }

    if(istrue(level.hostforcedend) && var_3 ishost()) {
      continue;
    }

    if(!istrue(var_3.pers["hasDoneAnyCombat"])) {
      continue;
    }

    if(var_1 == "tie") {
      var_4 = calculatematchbonus(var_3, "tie", var_1);
      thread givematchbonus(var_3, "tie");
      var_3.matchbonus = var_4;
    } else if(isDefined(var_3.pers["team"]) && var_3.pers["team"] == var_1) {
      var_4 = calculatematchbonus(var_3, "win", var_1);
      thread givematchbonus(var_3, "win");
      var_3.matchbonus = var_4;
    } else if(isDefined(var_3.pers["team"]) && var_3.pers["team"] != var_1) {
      var_4 = calculatematchbonus(var_3, "loss", var_1);
      thread givematchbonus(var_3, "loss");
      var_3.matchbonus = var_4;
    }

    freight_lift_button_activation(var_3, var_1);
  }

  return;
}

function givematchbonus(var_0, var_1) {
  self endon("disconnect");
  level waittill("give_match_bonus");
  scripts\cp\drone\emp_drone::giverankxp(var_0, var_1);

  if(var_0 == "win") {
    thread scripts\cp_mp\xmike109::givemidmatchaward("match_complete_win");
    return;
  }

  thread scripts\cp_mp\xmike109::givemidmatchaward("match_complete");
}

function freight_lift_button_activation(var_0) {
  var_0 = 600;

  if(istrue(self.pers["ignoreWeaponMatchBonus"]) || !isDefined(self.pers["killsPerWeapon"])) {
    return;
  }

  var_1 = scripts\cp\cp_weaponrank::reload_handle_hintstring() / 60;
  var_2 = var_0 / 60;
  var_3 = int(var_1 * var_2);
  var_4 = int(50);
  var_5 = self.timeplayed["total"] / var_0;
  var_6 = var_4 * var_5;
  var_7 = int(var_3 * var_6);
  var_7 -= int(self.pers["weaponMatchBonusKills"] * var_6);

  if(var_7 <= 0) {
    return;
  }

  var_8 = 0;

  foreach(var_10 in self.pers["killsPerWeapon"]) {
    var_8 += var_3 - var_10.killcount;
  }

  if(var_8 <= 0) {
    return;
  }

  foreach(var_10 in self.pers["killsPerWeapon"]) {
    var_13 = (var_3 - var_10.killcount) / var_8;
    var_14 = int(var_7 * var_13);
    scripts\cp\drone\emp_drone::incrankxp(0, var_10, var_14);

    foreach(var_16 in self.pers["matchdataWeaponStats"]) {
      if(issubstr(var_18, var_19)) {
        if(isDefined(var_16.stats["kills"]) && var_10.killcount > 0) {
          var_17 = var_13 * var_16.stats["kills"] / var_10.killcount;
          var_14 = int(var_7 * var_17);

          if(isDefined(var_16.stats["xp_earned"])) {
            var_16.stats["xp_earned"] = var_16.stats["xp_earned"] + var_14;
          } else {
            var_16.stats["xp_earned"] = var_14;
          }
        }
      }
    }
  }
}

function sethasdonecombat(var_0, var_1) {
  if(var_1 && !istrue(var_0.hasdonecombat)) {}

  var_0.hasdonecombat = var_1;

  if(var_1 && !istrue(var_0.pers["hasDoneAnyCombat"])) {
    var_0.pers["hasDoneAnyCombat"] = 1;
    return;
  }
}