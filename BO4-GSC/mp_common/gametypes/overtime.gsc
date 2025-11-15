/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\overtime.gsc
***********************************************/

#namespace overtime;

autoexec main() {
  if(!isDefined(game.overtime_round)) {
    game.overtime_round = 0;
  }

  if(!isDefined(level.nextroundisovertime)) {
    level.nextroundisovertime = 0;
  }
}

is_overtime_round() {
  if(game.overtime_round > 0) {
    return true;
  }

  return false;
}

round_stats_init() {
  if(is_overtime_round()) {
    setmatchflag("overtime", 1);
  } else {
    setmatchflag("overtime", 0);
  }

  if(!isDefined(game.stat[#"overtimeroundswon"])) {
    game.stat[#"overtimeroundswon"] = [];
  }

  if(!isDefined(game.stat[#"overtimeroundswon"][#"tie"])) {
    game.stat[#"overtimeroundswon"][#"tie"] = 0;
  }

  foreach(team, _ in level.teams) {
    if(!isDefined(game.stat[#"overtimeroundswon"][team])) {
      game.stat[#"overtimeroundswon"][team] = 0;
    }
  }
}

get_rounds_played() {
  if(game.overtime_round == 0) {
    return game.overtime_round;
  }

  return game.overtime_round - 1;
}

function_f435f4dd() {
  if(isDefined(level.shouldplayovertimeround)) {
    if([
        [level.shouldplayovertimeround]
      ]()) {
      level.nextroundisovertime = 1;
      return;
    }
  }

  level.nextroundisovertime = 0;
}