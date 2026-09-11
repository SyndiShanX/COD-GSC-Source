/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_assault.gsc
**************************************************/

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
  var0 = undefined;

  foreach(var2 in self.owner.touchtriggers) {
    if(var2.id == "domFlag") {
      var0 = var2;
    }
  }

  if(isDefined(var0)) {
    var4 = var0 scripts\mp\gametypes\dom::getflagteam();

    if(var4 != self.team) {
      if(!scripts\mp\bots\bots_gametype_dom::bot_is_capturing_flag(var0)) {
        scripts\mp\bots\bots_gametype_dom::capture_flag(var0, "critical", 1);
      }

      return true;
    }
  }

  return false;
}