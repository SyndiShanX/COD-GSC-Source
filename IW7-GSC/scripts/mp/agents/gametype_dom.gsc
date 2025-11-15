/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_dom.gsc
**********************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["squadmate"]["gametype_update"] = ::agent_squadmember_dom_think;
  level.agent_funcs["player"]["think"] = ::agent_player_dom_think;
}

agent_player_dom_think() {
  thread scripts\mp\bots\gametype_dom::bot_dom_think();
}

agent_squadmember_dom_think() {
  var_00 = undefined;
  foreach(var_02 in self.triggerportableradarping.touchtriggers) {
    if(var_02.useobj.id == "domFlag") {
      var_00 = var_02;
    }
  }

  if(isDefined(var_00)) {
    var_04 = var_00 scripts\mp\gametypes\dom::getflagteam();
    if(var_04 != self.team) {
      if(!scripts\mp\bots\gametype_dom::bot_is_capturing_flag(var_00)) {
        scripts\mp\bots\gametype_dom::capture_flag(var_00, "critical", 1);
      }

      return 1;
    }
  }

  return 0;
}