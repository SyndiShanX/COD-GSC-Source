/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\bots\bot_difficulty.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#namespace bot_difficulty;

function preinit() {
  callback::on_joined_team(&function_e161bc77);
}

function private function_e161bc77(params) {
  if(!isbot(self)) {
    return;
  }

  self assign();
}

function assign() {
  sessionmode = currentsessionmode();

  switch (sessionmode) {
    case 1:
      self function_d46cc4f5();
      break;
  }

  self callback::callback(#"hash_730d00ef91d71acf");
}

function private function_d46cc4f5() {
  team = isDefined(self.pers[# "team"]) ? self.pers[# "team"] : self.team;
  difficulty = level function_c0e2f147(team);
  self.bot.difficulty = level function_abad20c4(difficulty);
}

function private function_c0e2f147(team) {
  if(is_true(getgametypesetting(#"hash_c6a2e6c3e86125a"))) {
    return getgametypesetting(#"bot_difficulty_vs_bots");
  }

  if(!level.teambased) {
    team = # "allies";
  }

  teamstr = level.teams[team];

  if(!isDefined(teamstr)) {
    return undefined;
  }

  return getgametypesetting(#"hash_7a5a6325a6e843b7" + teamstr);
}

function private function_abad20c4(difficulty = 0) {
  switch (difficulty) {
    case 1:
      return getscriptbundle(#"hash_4e14664ff6086a77");
    case 2:
      return getscriptbundle(#"hash_70373311631d808e");
    case 3:
      return getscriptbundle(#"hash_4e151fcf3acee254");
    case 0:
    default:
      return getscriptbundle(#"hash_e8255beefa53aa1");
  }
}