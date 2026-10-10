/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_145a7b1cf6f09c42.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\interaction;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#namespace namespace_76b8c9d9aeef6321;

function setupobjective(trigger, skipobjid, var_5ddbc1faed2c56e6, reservedobjid) {
  visual[0] = spawn("script_model", trigger.origin);
  ownerteam = function_2e3b4aa15c51aa90(trigger.script_label);
  alloweduser = function_a7de388c32637f42(trigger.script_label);
  moneypile = createuseobject(ownerteam, trigger, visual, (0, 0, 64), reservedobjid, skipobjid);
  moneypile setvisibleteam("any");
  moneypile allowuse(alloweduser);
  moneypile.trigger setusepriority(-1 - 1 - 1 - 1);
  moneypile.trigger setuseholdduration("duration_short");
  moneypile.trigger sethintonobstruction("show");
  moneypile requestid(1, 1, reservedobjid);
  moneypile.exclusiveuse = 0;
  moneypile.clientprogress = [];
  moneypile.checkuseconditioninthink = 1;
  moneypile.var_2efb40714a6e9468 = 1;
  moneypile.allowsweapon = 0;
  moneypile.var_cc367d287df0480b = 0;

  if(ownerteam == "neutral") {
    moneypile setobjectivestatusicons(level.var_909dfa41d4c004d8, level.var_909dfa41d4c004d8);
    currentmoney = ter_op(getdvarint(@ "hash_4e4da58f88e22860", 0), 20, 1000);
    moneypile.currentmoney = currentmoney;
    moneypile setusetime(level.neutralcapturetime);
  } else {
    moneypile setobjectivestatusicons(level.var_46d190af0e774ad, level.iconsteal);
    moneypile.currentmoney = 0;
    moneypile setusetime(level.enemycapturetime);

    if(game["switchedsides"]) {
      if(ownerteam == "allies") {
        moneypile.currentmoney = game["attackerGoldBars"];
      } else {
        moneypile.currentmoney = game["defenderGoldBars"];
      }
    }

    function_f01b3311ea2144e(moneypile);
  }

  moneypile.id = "moneypile";
  moneypile.onuse = &function_cc1facd3f297a76c;
  moneypile.usecondition = &function_d154043bb1c69c98;
  moneypile.var_53f88be23696a633 = &function_d154043bb1c69c98;
  moneypile.reservedobjid = reservedobjid;
  moneypile.ownerteam = ownerteam;
  moneypile.origin = trigger.origin;

  if(trigger.script_label == "_a" || trigger.script_label == "_b") {
    clonetrigger = spawn("trigger_radius", trigger.origin, 0, 90, 128);
    clonetrigger.script_label = trigger.script_label;
    clonetrigger.moneypile = moneypile;
    thread function_28d3a4d017b4d4a5(clonetrigger);
    moneypile thread function_b41e97065e86a3ea();
  }

  moneypile.trigger.moneypile = moneypile;
  moneypile.trigger scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_a31737d625cdf5eb);
  return moneypile;
}

function function_a31737d625cdf5eb(usable, player) {
  if(isDefined(player) && isDefined(usable)) {
    if(usable.moneypile function_d154043bb1c69c98(player)) {
      return {
        #string: &"MP/TAKE_GOLD", #type: "HINT_NOBUTTON"};
    } else {
      return {
        #string: &"", #type: "HINT_NOICON"};
    }
  }

  return {
    #string: &"", #type: "HINT_NOICON"};
}

function function_28d3a4d017b4d4a5(dropzone) {
  level endon("game_ended");

  while(true) {
    dropzone waittill("trigger", player);

    if(level.gameended) {
      return;
    }

    if(!isPlayer(player)) {
      continue;
    }

    if(dropzone.moneypile.ownerteam == player.team && player.currentmoney > 0) {
      for(i = 0; i < player.currentmoney; i++) {
        player thread doscoreevent(#"gold_secure");
      }

      player incpersstat("gold_secure", player.currentmoney);
      player setextrascore0(player.pers["gold_secure"]);
      dropzone.moneypile.currentmoney += player.currentmoney;
      player.currentmoney = 0;
      player setclientomnvar("ui_gold", player.currentmoney);
      function_f01b3311ea2144e(dropzone.moneypile);
      player playSound("br_pickup_cash_vlrg_01");
    }
  }
}

function function_b41e97065e86a3ea() {
  level waittill("round_end_finished");

  if(self.ownerteam == "allies") {
    game["attackerGoldBars"] = self.currentmoney;
    return;
  }

  game["defenderGoldBars"] = self.currentmoney;
}

function function_d154043bb1c69c98(player) {
  if(self.currentmoney <= 0 || player.currentmoney >= player.maxmoney || level.gameended) {
    return false;
  }

  return true;
}

function function_cc1facd3f297a76c(player) {
  player.currentmoney += 1;
  player setclientomnvar("ui_gold", player.currentmoney);
  player updateuiprogress(self, 0);
  self.currentmoney -= 1;
  player playSound("br_pickup_cash_lrg_01");

  if(self.ownerteam != "neutral") {
    function_f01b3311ea2144e(self);
    player thread doscoreevent(#"gold_steal");
    player incpersstat("gold_steal", 1);
    player setextrascore1(player.pers["gold_steal"]);
    function_d626b8e88755fe64(player);
    return;
  }

  player thread doscoreevent(#"gold_collect");

  if(getdvarint(@ "hash_4e4da58f88e22860", 0) && self.currentmoney <= 0) {
    function_896249bc3c12863d();
    function_9030f4d114a157df(level.var_ecec7a4115b35c9[level.var_9916fff305749068]);
  }
}

function function_d626b8e88755fe64(player) {
  otherteam = getotherteam(player.team)[0];
  otherteamflag = ter_op(otherteam == "axis", "axis_team_splash_appeared", "allies_team_splash_appeared");

  if(!flag(otherteamflag)) {
    flag_set(otherteamflag);
    assertex(isDefined(level.var_9105385a7ecadc0c), "<dev string:x1c>");
    showsplashtoteam(otherteam, "gold_rush_steal", undefined, undefined, undefined, undefined, level.var_9105385a7ecadc0c);
    thread function_87134192ff77be44(otherteamflag);
  }
}

function function_87134192ff77be44(otherteamflag) {
  wait 10;
  flag_clear(otherteamflag);
}

function function_2e3b4aa15c51aa90(objectivekey) {
  if(objectivekey == "_a") {
    ownerteam = ter_op(game["switchedsides"], "axis", "allies");
  } else if(objectivekey == "_b") {
    ownerteam = ter_op(game["switchedsides"], "allies", "axis");
  } else {
    ownerteam = "neutral";
  }

  return ownerteam;
}

function function_a7de388c32637f42(objectivekey) {
  if(objectivekey == "_a" || objectivekey == "_b") {
    ownerteam = "enemy";
  } else {
    ownerteam = "any";
  }

  return ownerteam;
}

function function_f01b3311ea2144e(moneypile) {
  scripts\mp\gamescore::_setteamscore(moneypile.ownerteam, moneypile.currentmoney);

  if(moneypile.currentmoney == 0) {
    moneypile scripts\mp\gameobjects::setvisibleteam("friendly");
    return;
  }

  moneypile scripts\mp\gameobjects::setvisibleteam("any");
}

function function_896249bc3c12863d() {
  if(level.var_ecec7a4115b35c9.size == level.var_9916fff305749068) {
    level.var_9916fff305749068 = 1;
    return;
  }

  level.var_9916fff305749068++;
}

function function_9030f4d114a157df(var_6a0664dbed9c56fc) {
  foreach(var_963ddbf1bda4c460 in level.var_ecec7a4115b35c9) {
    if(var_963ddbf1bda4c460 == var_6a0664dbed9c56fc) {
      thread function_c9dce10ad224933a(var_963ddbf1bda4c460);
      continue;
    }

    function_e61ac104d25c6faa(var_963ddbf1bda4c460, "none", 0);
  }
}

function function_c9dce10ad224933a(var_963ddbf1bda4c460) {
  wait 5;
  function_e61ac104d25c6faa(var_963ddbf1bda4c460, "any", 20);
}

function function_e61ac104d25c6faa(var_963ddbf1bda4c460, visibility, currentmoney) {
  var_963ddbf1bda4c460 setvisibleteam(visibility);
  var_963ddbf1bda4c460 allowuse(visibility);
  var_963ddbf1bda4c460.currentmoney = currentmoney;

  foreach(var_5658359672a6082c in level.var_c78ba5dba4b7d426) {
    if(int(var_5658359672a6082c.script_objective) == int(var_963ddbf1bda4c460.trigger.script_objective)) {
      if(visibility == "any") {
        var_5658359672a6082c show();
        continue;
      }

      var_5658359672a6082c hide();
    }
  }
}