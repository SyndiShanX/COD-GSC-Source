/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_dom.gsc
***********************************************/

function main() {
  setup_callbacks();
}

function setup_callbacks() {
  level.agent_funcs["player"]["think"] = &agent_player_dom_think;
}

function agent_player_dom_think() {
  thread scripts\mp\bots\bots_gametype_dom::bot_dom_think();
}

function agent_squadmember_dom_think() {
  var_0 = undefined;

  foreach(var_2 in self.owner.touchtriggers) {
    if(var_2.id == "domFlag") {
      var_0 = var_2;
    }
  }

  if(isDefined(var_0)) {
    var_4 = var_0 scripts\mp\gametypes\dom::getflagteam();

    if(var_4 != self.team) {
      if(!scripts\mp\bots\bots_gametype_dom::bot_is_capturing_flag(var_0)) {
        scripts\mp\bots\bots_gametype_dom::capture_flag(var_0, "critical", 1);
      }

      return true;
    }
  }

  return false;
}