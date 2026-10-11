/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\points.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\cp_awards;
#using scripts\cp\cp_gamescore;
#using scripts\cp\cp_weaponrank;
#using scripts\cp\endgame;
#using scripts\cp\events;
#using scripts\cp\persistence;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace points;

function initpoints() {
  level.var_97e29f66f7229f48 = &doscoreevent;
}

function givestreakpointswithtext(event, objweapon, pointsoverride) {
  if(isDefined(level.ignorescoring)) {
    return;
  }

  if(isDefined(pointsoverride)) {
    points = pointsoverride;
  } else {
    points = scripts\cp\rank::getscoreinfovalue(event);
    assertex(isDefined(points), "giveStreakPointsWithText() with event \"" + event + "\", but that event doesn't exist in the gametype's scoreeventlist asset.");
  }

  points = modifyunifiedpoints(event, points, objweapon);
  displayscoreeventpoints(points, event);
}

function doscoreevent(event, objweapon, pointsoverride, xpoverride, victim, var_51bdae03b05bc75e, dontwait, cankillchain, streakinfo, var_ad8c6c5cc50af10b, eventinfo) {
  if(function_240f7f4e57340e8f()) {
    return;
  }

  if(istrue(level.gameended)) {
    isvalidevent = 0;

    if(isarray(event)) {
      if(isnumber(level.gameendtime)) {
        if(event[1] <= level.gameendtime) {
          isvalidevent = 1;
          event = event[0];
        }
      }
    } else if(isDefined(event)) {
      isvalidevent = 1;
    }

    if(!isvalidevent) {
      return;
    }
  } else if(isarray(event)) {
    event = event[0];
  }

  if(istrue(self.pers["ignoreWeaponKillXP"])) {
    objweapon = undefined;
  }

  showsplash = scripts\cp\rank::function_e3dfd7e570749681(event);

  if(showsplash) {
    thread scripts\cp\events::killeventtextpopup(event, 1);
  }

  if(scripts\cp\rank::function_34294184e90b96c(event)) {
    scripts\cp\cp_awards::givemidmatchaward(event, objweapon, pointsoverride, xpoverride, var_51bdae03b05bc75e, dontwait, victim, cankillchain, streakinfo, var_ad8c6c5cc50af10b, eventinfo);
    return;
  }

  giveunifiedpoints(event, objweapon, pointsoverride, xpoverride, victim, cankillchain, streakinfo, var_ad8c6c5cc50af10b, eventinfo);
}

function giveunifiedpoints(event, objweapon, pointsoverride, xpoverride, victim, cankillchain, streakinfo, var_827c276da1cdcf23, eventinfo) {
  if(function_240f7f4e57340e8f()) {
    return;
  }

  if(istrue(level.gameended)) {
    isvalidevent = 0;

    if(isarray(event)) {
      if(isnumber(level.gameendtime)) {
        if(event[1] <= level.gameendtime) {
          isvalidevent = 1;
          event = event[0];
        }
      }
    } else if(isDefined(event)) {
      isvalidevent = 1;
    }

    if(!isvalidevent) {
      return;
    }
  } else if(isarray(event)) {
    event = event[0];
  }

  if(istrue(self.pers["ignoreWeaponKillXP"])) {
    objweapon = undefined;
  }

  if(!isxhash(event)) {
    assertex(1, event);
    event = getxhash(event);
  }

  if(istrue(level.ignorescoring)) {
    var_587eb1f4e11a34f3 = 1;
    var_e7a7e20ec68138e3 = scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\cp\utility::gameflag("prematch_done");

    if(var_e7a7e20ec68138e3) {
      var_587eb1f4e11a34f3 = 0;
    }

    if(var_587eb1f4e11a34f3) {
      return;
    }
  }

  if(istrue(game["practiceRound"])) {
    return;
  }

  if(isDefined(pointsoverride)) {
    points = pointsoverride;
  } else {
    points = scripts\cp\rank::getscoreinfovalue(event);
    assertex(isDefined(points), "giveUnifiedPoints() with event \"" + getxhashsourcename(event) + "\", but that event doesn't exist in the gametype's scoreeventlist asset");

    if(!isDefined(points)) {
      points = 0;
    }
  }

  points = modifyunifiedpoints(event, points, objweapon);

  if(isDefined(objweapon)) {
    weaponobj = scripts\cp\weapon::mapweapon(objweapon);
    sweapon = getcompleteweaponname(weaponobj);
  }

  if(isDefined(streakinfo)) {
    streakinfo.score += points;
  }

  isassist = event == #"assist";
  iskill = event == #"kill";
  supermultiplier = 1;

  if(iskill || isassist) {}

  var_798ada8b24ba4887 = 1;

  if(isDefined(xpoverride) && xpoverride < 0) {
    var_798ada8b24ba4887 = 0;
  }

  if(var_798ada8b24ba4887) {
    xp = xpoverride;

    if(!isDefined(xp)) {
      if(isDefined(pointsoverride)) {
        xp = points;
      } else {
        xp = scripts\cp\rank::getscoreinfoxp(event);
      }
    }

    xp = default_to(xp, 0);

    if(iskill) {
      if(isDefined(objweapon)) {
        var_9bcadacc6ecad1 = objweapon hasattachment("gunperk_xp") || _hasperk("specialty_gunperk_xp");

        if(var_9bcadacc6ecad1) {
          xp += 20;
        }
      }
    }

    var_e9f5dfee6649f67a = isDefined(self.pers) && istrue(self.pers["ignoreWeaponKillXP"]);
    thread scripts\cp\rank::giverankxp(event, xp, objweapon, undefined, undefined, var_e9f5dfee6649f67a, undefined, eventinfo);
  }

  thread scripts\cp\events::killeventtextpopup(event, 0);

  if(istrue(level.var_1e17e3480b1d264d) && isDefined(level.var_9c1e3c18b99409e9) && points > 0 && event != "br_kioskBuy") {
    self[[level.var_9c1e3c18b99409e9]](points);
  }
}

function give_munition_currency(amount) {
  current_amount = scripts\cp\persistence::get_player_munition_currency();
  amount = scripts\cp\cp_gamescore::round_up_to_nearest(amount, 5);

  if(isDefined(self.totalmuncurrencyearned) && isDefined(self.maxmuncurrencycap)) {
    if(self.totalmuncurrencyearned > self.maxmuncurrencycap) {
      if(isDefined(self.totalweaponxpearned)) {
        self iprintln("<dev string:x1c>" + self.totalweaponxpearned);
      }

      amount = 0;
    } else {
      self.totalmuncurrencyearned += amount;
    }
  }

  max_amount = scripts\cp\persistence::get_player_max_currency();
  new_amount = current_amount + amount;
  new_amount = min(new_amount, max_amount);
  scripts\cp\persistence::set_player_munition_currency(new_amount);
}

function modifyunifiedpoints(event, points, objweapon) {
  if(event == #"damage") {
    return 0;
  }

  bonuspool = 0;

  if(isDefined(objweapon)) {
    if(event == "kill" && objweapon hasattachment("gunperk_xp")) {
      bonuspool += 20;
    }
  }

  points += bonuspool;

  if(isDefined(level.modifyunifiedpointscallback)) {
    points = [[level.modifyunifiedpointscallback]](points, event, self, objweapon);
  }

  return int(points);
}

function displayscoreeventpoints(points, event) {
  if(getdvarint(@ "hash_a3a1cab75dca6cc6", 0) == 1) {
    return;
  }

  if(function_93d685ac42f15c61()) {
    return;
  } else if(isDefined(self.totalxpearned) && isDefined(self.maxxpcap)) {
    if(self.totalxpearned >= self.maxxpcap) {
      return;
    }
  }

  if(!isDefined(level.skippointdisplayxp)) {
    var_dc03362b77c5058d = 0;

    if(issimultaneouskillenabled()) {
      var_dc03362b77c5058d = event == #"kill";
    }

    thread scripts\cp\rank::scorepointspopup(points, var_dc03362b77c5058d);
  }
}

function isnokillstreakprogressweapon(objweapon) {
  if(!isDefined(objweapon)) {
    return false;
  }

  if(isstring(objweapon)) {
    objweapon = makeweapon(objweapon);
  }

  switch (objweapon.basename) {
    case #"hash_2f1a9d8e2f127205":
    case #"hash_a622e958420b92a0":
    case #"hash_fd9c279f85990dad":
      return true;
  }

  return false;
}

function isforcekillstreakprogressweapon(objweapon) {
  if(!isDefined(objweapon)) {
    return false;
  }

  if(isstring(objweapon)) {
    objweapon = makeweapon(objweapon);
  }

  switch (objweapon.basename) {
    case #"hash_2de2eefce564d9cc":
    case #"hash_448b7248104bfa9c":
    case #"hash_a13a4988b0d2c105":
    case #"hash_aacdf3a6d5b91585":
      return true;
  }

  return false;
}

function calculatematchbonus(matchresult, gamelength) {
  matchbonusbaseline = 250;
  var_f5c150745db5bf66 = gamelength / 60;
  var_30fb07c2ca202ff = scripts\cp\rank::function_6d17f84162f0d8f0(matchresult);
  modescalar = scripts\cp\rank::getgametypexpmultiplier();

  if(scripts\cp\utility::function_138028ca2b958511()) {
    var_479ff69364253676 = getdvarint(@ "hash_7f9d5cd3ca6245a4", 4);
    modescalar *= var_479ff69364253676;
  }

  matchbonus = int(matchbonusbaseline * var_30fb07c2ca202ff * modescalar);
  return matchbonus;
}

function updatematchbonusscores(winner) {
  gamelength = scripts\cp\endgame::get_play_time() / 1000;
  gamelength = min(gamelength, 1200);

  if(level.teambased) {
    if(winner != "tie") {
      setwinningteam(winner);
    }

    foreach(player in level.players) {
      if(isDefined(player.connectedpostgame)) {
        continue;
      }

      if(player.timeplayed["total"] < 1 || player.pers["participation"] < 1) {
        continue;
      }

      if(istrue(level.hostforcedend) && player ishost()) {
        continue;
      }

      if(!istrue(player.pers["hasDoneAnyCombat"])) {
        continue;
      }

      if(winner == "tie") {
        playerscore = player calculatematchbonus("tie", gamelength);
        player thread givematchbonus("tie", playerscore);
        player.matchbonus = playerscore;
      } else if(isDefined(player.pers["team"]) && player.pers["team"] == winner) {
        playerscore = player calculatematchbonus("win", gamelength);
        player thread givematchbonus("win", playerscore);
        player.matchbonus = playerscore;
      } else if(isDefined(player.pers["team"]) && player.pers["team"] != winner) {
        playerscore = player calculatematchbonus("loss", gamelength);
        player thread givematchbonus("loss", playerscore);
        player.matchbonus = playerscore;
      }

      player calculateweaponmatchbonus(gamelength);
    }

    return;
  }

  winnerresult = "win";
  loserresult = "loss";

  if(!isDefined(winner)) {
    winnerresult = "tie";
    loserresult = "tie";
  }

  foreach(player in level.players) {
    if(isDefined(player.connectedpostgame)) {
      continue;
    }

    if(player.timeplayed["total"] < 1 || player.pers["participation"] < 1) {
      continue;
    }

    if(!istrue(player.pers["hasDoneAnyCombat"])) {
      continue;
    }

    iswinner = 0;

    for(pidx = 0; pidx < min(level.placement["all"].size, 3); pidx++) {
      if(level.placement["all"][pidx] != player) {
        continue;
      }

      iswinner = 1;
    }

    if(iswinner) {
      playerscore = player calculatematchbonus(winnerresult, gamelength);
      player thread givematchbonus("win", playerscore);
      player.matchbonus = playerscore;
    } else {
      playerscore = player calculatematchbonus(loserresult, gamelength);
      player thread givematchbonus("loss", playerscore);
      player.matchbonus = playerscore;
    }

    player calculateweaponmatchbonus(gamelength);
  }
}

function givematchbonus(scoretype, score) {
  self endon("disconnect");
  level waittill("give_match_bonus");
  scripts\cp\rank::giverankxp(getxhash(scoretype), score);

  if(scoretype == "win") {
    thread doscoreevent(#"hash_fe606101a22e3e79");
    return;
  }

  assertex(scoretype == "tie" || scoretype == "loss", "Unexpected scoreType for giveMatchBonus(), \"" + scoretype + "\"");
  thread doscoreevent(#"match_complete");
}

function calculateweaponmatchbonus(gamelength) {
  gamelength = 600;

  if(istrue(self.pers["ignoreWeaponMatchBonus"]) || !isDefined(self.pers["killsPerWeapon"])) {
    return;
  }

  var_11865501de9083d = scripts\cp\cp_weaponrank::getgametypekillsperhouravg() / 60;
  var_f5c150745db5bf66 = gamelength / 60;
  var_162a122a3e3cce1a = int(var_11865501de9083d * var_f5c150745db5bf66);
  killincrement = int(50);
  var_9bf173c2aa7eb966 = killincrement * 1;
  var_4b7cf89acaabdcac = int(var_162a122a3e3cce1a * var_9bf173c2aa7eb966);
  var_4b7cf89acaabdcac -= int(self.pers["weaponMatchBonusKills"] * var_9bf173c2aa7eb966);

  if(var_4b7cf89acaabdcac <= 0) {
    return;
  }

  totaldiff = 0;

  foreach(data in self.pers["killsPerWeapon"]) {
    totaldiff += var_162a122a3e3cce1a - data.killcount;
  }

  if(totaldiff <= 0) {
    return;
  }

  foreach(data in self.pers["killsPerWeapon"]) {
    ratio = (var_162a122a3e3cce1a - data.killcount) / totaldiff;
    xpgain = int(var_4b7cf89acaabdcac * ratio);
    scripts\cp\rank::incrankxp(0, data, xpgain, getxhash("WeaponMatchBonus"));

    foreach(datastruct in self.pers["weaponStats"]) {
      if(issubstr(var_10ca4bf7aa9c3ed2, weaponkey)) {
        if(isDefined(datastruct.stats["kills"]) && data.killcount > 0) {
          specificratio = ratio * datastruct.stats["kills"] / data.killcount;
          xpgain = int(var_4b7cf89acaabdcac * specificratio);

          if(isDefined(datastruct.stats["xp_earned"])) {
            datastruct.stats["xp_earned"] = datastruct.stats["xp_earned"] + xpgain;
            continue;
          }

          datastruct.stats["xp_earned"] = xpgain;
        }
      }
    }
  }
}

function sethasdonecombat(player, newhasdonecombat) {
  if(newhasdonecombat && !istrue(player.hasdonecombat)) {}

  player.hasdonecombat = newhasdonecombat;

  if(newhasdonecombat && !istrue(player.pers["hasDoneAnyCombat"])) {
    player.pers["hasDoneAnyCombat"] = 1;
  }
}