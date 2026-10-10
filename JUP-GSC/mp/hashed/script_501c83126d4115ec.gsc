/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_501c83126d4115ec.gsc
*************************************************/

#using script_40e63dd222434655;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_br;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#namespace escape_gas;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore, &createaction);
}

function evaluatescore(bot) {
  if(scripts\mp\gamelogic::inprematch()) {
    return 0;
  }

  var_a0f36ff3eae203ae = level.br_circle.circleindex + 1 >= level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount;

  if(!var_a0f36ff3eae203ae) {
    var_7d9a6d00a336393b = scripts\mp\gametypes\br_circle_util::gettimetilldangerforpoint(bot.origin);

    if(var_7d9a6d00a336393b >= 0) {
      finalscore = function_9d1ab012058221bb(var_7d9a6d00a336393b, self.constants.var_3dd54452af7d2b91, self.constants.var_49e2976ca0c853ef);
      finalscore += function_4e58bf49977d1bfd();
      return finalscore;
    }
  } else if(bot function_68aa3c169a03e3b9()) {
    return self.constants.var_5518deaf35f7b0ce;
  }

  return 0;
}

function createaction(bot) {
  return createactionbase("escape_gas", undefined, "main", "", &actionprocess, self, &function_f4caae7e8af9d32c, self.constants.var_57228f75b014a7b8, self.constants.var_daec6fd98c7cee50);
}

function actionprocess(bot) {
  bot allowreload(0);
  pointonnavmesh = bot function_bf97a7a48fa19ed3();
  stuckcount = 0;

  while(true) {
    if(!isDefined(pointonnavmesh)) {
      return "No destination";
    }

    bot setscriptgoal(pointonnavmesh, 64);
    bot botpressbutton("sprint", 1);
    lastbotpos = bot.origin;
    result = bot waittill_any_in_array_or_timeout(["goal", "bad_path"], 1);

    if(result == "bad_path") {
      pointonnavmesh = bot function_bf97a7a48fa19ed3(1);
      stuckcount = 0;
      continue;
    }

    if(result == "timeout") {
      var_889f315f34195c15 = 225;

      if(distancesquared(bot.origin, lastbotpos) > var_889f315f34195c15) {
        stuckcount = 0;
      } else {
        stuckcount++;

        if(stuckcount >= 5) {
          pointonnavmesh = bot function_bf97a7a48fa19ed3(1);
          stuckcount = 0;
        }
      }

      continue;
    }

    if(result == "goal") {
      break;
    }
  }

  bot notify("dormant_bot_suspending_chance");
}

function function_bf97a7a48fa19ed3(dorandom) {
  var_7ba79e92efeee9cd = 4000;
  destination = function_e5b4b5992cddb221().origin;

  if(istrue(dorandom)) {
    var_c4ca8c2703d417d4 = 400;
    randomrange = min(var_c4ca8c2703d417d4, scripts\mp\gametypes\br_circle::getdangercircleradius() * 0.8);
    destination = scripts\mp\gametypes\br_circle::getrandompointincircle(destination, randomrange);
  }

  return function_207ba502560fa1d2(destination, var_7ba79e92efeee9cd);
}

function function_68aa3c169a03e3b9() {
  if(!scripts\mp\flags::gameflag("graceperiod_done")) {
    return false;
  }

  if(!isvalidplayer(self)) {
    return false;
  }

  if(function_d987886bb9de9137() > 1 && !scripts\mp\gametypes\br_circle_util::function_29e8194ff7e13e2e()) {
    return false;
  }

  circleorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  circleradius = scripts\mp\gametypes\br_circle::getdangercircleradius();

  if(istrue(level.circleclosing)) {
    circleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    circleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();
  }

  var_fbadf88256285b55 = 0.7;
  var_dcd37eb0f547595 = 320;
  nearradius = max(circleradius * var_fbadf88256285b55, circleradius - var_dcd37eb0f547595);
  return !ispointinsidecircle(self.origin, circleorigin, nearradius);
}

function function_f4caae7e8af9d32c(action) {
  if(function_d57dd414963503d1()) {
    self allowreload(1);
  }
}