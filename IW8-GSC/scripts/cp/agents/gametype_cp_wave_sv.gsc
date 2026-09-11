/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\agents\gametype_cp_wave_sv.gsc
*****************************************************/

function givestreakpointswithtext(var0, var1, var2) {
  if(isDefined(level.ignorescoring)) {
    return;
  }

  if(isDefined(var2)) {
    var3 = var2;
  } else {
    var3 = scripts\cp\drone\emp_drone::getscoreinfovalue(var1);
  }

  var3 = modifyunifiedpoints(var1, var3, var2);
  displayscoreeventpoints(var3, var1);
}

function giveunifiedpoints(var0, var1, var2, var3, var4, var5) {
  if(isDefined(level.ignorescoring) && !issubstr(var0, "assist")) {
    return;
  }

  if(isDefined(var2)) {
    var6 = var2;
  } else {
    var6 = scripts\cp\drone\emp_drone::getscoreinfovalue(var1);
  }

  var6 = modifyunifiedpoints(var1, var6, var2);
  var7 = var1 == "kill";
  var8 = 0;
  var9 = 0;
  var10 = istrue(self.isjuggernaut);
  var11 = update_objective_setmlgbackground(var2);
  var12 = scripts\cp\utility::_hasperk("specialty_killstreak_to_scorestreak");
  var13 = var9 && scripts\cp\utility::_hasperk("specialty_chain_killstreaks") && istrue(var6);

  if(isDefined(var5)) {
    if(isDefined(self.ref_119d4) && self.ref_119d4.size > 0) {
      if(istrue(self.ref_119d4[var5 getentitynumber()])) {
        self.ref_119d4[var5 getentitynumber()] = undefined;
        return;
      }
    }
  }

  if((var7 || var8 || var13 || var12) && (!var10 || var13 || var12) && (!var11 || var12)) {}

  if(level.gametype == "cp_survival") {
    if(!isDefined(var2)) {
      thread screenent_a(var6);
    }
  }

  if(!istrue(var4)) {
    thread scripts\cp\drone\emp_drone::giverankxp(var1, var6, var2);
  }
}

function screenent_a(var0) {
  var1 = scripts\cp\cp_persistence::quickdropremovearmorfrominventory();
  var0 = scripts\cp\cp_gamescore::round_up_to_nearest(var0, 5);

  if(isDefined(self.ref_13bf3) && isDefined(self.ref_11b67)) {
    if(self.ref_13bf3 > self.ref_11b67) {
      var0 = 0;
    } else {
      self.ref_13bf3 += var0;
    }
  }

  var2 = scripts\cp\cp_persistence::get_player_max_currency();
  var3 = var1 + var0;
  var3 = min(var3, var2);
  scripts\cp\cp_persistence::ref_130aa(var3);
}

function modifyunifiedpoints(var0, var1, var2) {
  switch (var0) {
    case "damage":
      return 0;
    default:
      break;
  }

  var3 = 0;

  if(var0 == "kill" && var2 hasattachment("gunperk_xp")) {
    var3 += 20;
  }

  var1 += var3;

  if(isDefined(level.modifyunifiedpointscallback)) {
    var1 = [[level.modifyunifiedpointscallback]](var1, var0, self, var2);
  }

  return int(var1);
}

function displayscoreeventpoints(var0, var1) {
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
    foreach(var3 in level.players) {
      if(var3 ismlgspectator()) {
        var4 = var3 getspectatingplayer();

        if(isDefined(var4)) {
          var5 = var4 getentitynumber();
          var6 = self getentitynumber();

          if(var5 == var6) {
            var3 thread scripts\cp\drone\emp_drone::scorepointspopup(var0);
            var3 thread scripts\cp\drone\emp_drone::scoreeventpopup(var1);
          }
        }
      }
    }
  }

  if(!isDefined(level.skippointdisplayxp)) {
    var8 = 0;

    if(scripts\cp\utility::issimultaneouskillenabled()) {
      var8 = var1 == "kill";
    }

    thread scripts\cp\drone\emp_drone::scorepointspopup(var0, var8);
    return;
  }
}

function update_objective_setmlgbackground(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isstring(var0)) {
    var0 = getcompleteweaponname(var0);
  }

  switch (var0.basename) {
    case "bradley_tow_proj_mp":
    case "lighttank_tur_mp":
    case "tur_apc_rus_mp":
      return true;
  }

  return false;
}

function unset_relic_doomslayer(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isstring(var0)) {
    var0 = getcompleteweaponname(var0);
  }

  switch (var0.basename) {
    case "deploy_juggernaut_mp":
    case "deploy_airdrop_mp":
    case "iw8_green_beam_mp":
    case "iw8_spotter_scope_mp":
      return true;
  }

  return false;
}

function calculatematchbonus(var0, var1) {
  var2 = 250;
  var3 = var1 / 60;
  var4 = scripts\cp\drone\emp_drone::getscoreinfovalue(var0);
  var5 = self.timeplayed["total"] / var1;

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    var3 = 1;
    var5 = 1;
  }

  var6 = scripts\cp\drone\emp_drone::getgametypexpmultiplier();
  var7 = int(var2 * var4 * var3 * var5 * var6);
  return var7;
}

function updatematchbonusscores(var0) {
  if(istrue(level.forcedend)) {
    var1 = scripts\cp\cp_endgame::get_play_time() / 1000;
    var1 = min(var1, 1200);
  } else {
    var1 = scripts\cp\cp_endgame::get_play_time() / 1000;
  }

  jumpiffalse(level.teambased) LOC_000001a7;
  jumpiffalse(var1 != "tie") LOC_00000044;
  setwinningteam(var1);

  foreach(var3 in level.players) {
    if(isDefined(var3.connectedpostgame)) {
      continue;
    }

    if(var3.timeplayed["total"] < 1 || var3.pers["participation"] < 1) {
      continue;
    }

    if(istrue(level.hostforcedend) && var3 ishost()) {
      continue;
    }

    if(!istrue(var3.pers["hasDoneAnyCombat"])) {
      continue;
    }

    if(var1 == "tie") {
      var4 = calculatematchbonus(var3, "tie", var1);
      thread givematchbonus(var3, "tie");
      var3.matchbonus = var4;
    } else if(isDefined(var3.pers["team"]) && var3.pers["team"] == var1) {
      var4 = calculatematchbonus(var3, "win", var1);
      thread givematchbonus(var3, "win");
      var3.matchbonus = var4;
    } else if(isDefined(var3.pers["team"]) && var3.pers["team"] != var1) {
      var4 = calculatematchbonus(var3, "loss", var1);
      thread givematchbonus(var3, "loss");
      var3.matchbonus = var4;
    }

    freight_lift_button_activation(var3, var1);
  }

  return;
}

function givematchbonus(var0, var1) {
  self endon("disconnect");
  level waittill("give_match_bonus");
  scripts\cp\drone\emp_drone::giverankxp(var0, var1);

  if(var0 == "win") {
    thread scripts\cp_mp\xmike109::givemidmatchaward("match_complete_win");
    return;
  }

  thread scripts\cp_mp\xmike109::givemidmatchaward("match_complete");
}

function freight_lift_button_activation(var0) {
  var0 = 600;

  if(istrue(self.pers["ignoreWeaponMatchBonus"]) || !isDefined(self.pers["killsPerWeapon"])) {
    return;
  }

  var1 = scripts\cp\cp_weaponrank::reload_handle_hintstring() / 60;
  var2 = var0 / 60;
  var3 = int(var1 * var2);
  var4 = int(50);
  var5 = self.timeplayed["total"] / var0;
  var6 = var4 * var5;
  var7 = int(var3 * var6);
  var7 -= int(self.pers["weaponMatchBonusKills"] * var6);

  if(var7 <= 0) {
    return;
  }

  var8 = 0;

  foreach(var10 in self.pers["killsPerWeapon"]) {
    var8 += var3 - var10.killcount;
  }

  if(var8 <= 0) {
    return;
  }

  foreach(var10 in self.pers["killsPerWeapon"]) {
    var13 = (var3 - var10.killcount) / var8;
    var14 = int(var7 * var13);
    scripts\cp\drone\emp_drone::incrankxp(0, var10, var14);

    foreach(var16 in self.pers["matchdataWeaponStats"]) {
      if(issubstr(var18, var19)) {
        if(isDefined(var16.stats["kills"]) && var10.killcount > 0) {
          var17 = var13 * var16.stats["kills"] / var10.killcount;
          var14 = int(var7 * var17);

          if(isDefined(var16.stats["xp_earned"])) {
            var16.stats["xp_earned"] = var16.stats["xp_earned"] + var14;
          } else {
            var16.stats["xp_earned"] = var14;
          }
        }
      }
    }
  }
}

function sethasdonecombat(var0, var1) {
  if(var1 && !istrue(var0.hasdonecombat)) {}

  var0.hasdonecombat = var1;

  if(var1 && !istrue(var0.pers["hasDoneAnyCombat"])) {
    var0.pers["hasDoneAnyCombat"] = 1;
    return;
  }
}