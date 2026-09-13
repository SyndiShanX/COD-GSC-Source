/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_assault.gsc
**************************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["player"]["think"] = ::agent_player_dom_think;
}

agent_player_dom_think() {
  thread _id_35F1C253181907B1::bot_dom_think();
}

agent_squadmember_dom_think() {
  _id_5A94482DD280F417 = undefined;

  foreach(trigger in self.owner.touchtriggers) {
    if(trigger.id == "domFlag")
      _id_5A94482DD280F417 = trigger;
  }

  if(isDefined(_id_5A94482DD280F417)) {
    _id_A2191D9C6BBA5BA1 = _id_5A94482DD280F417 _id_2DC3A143158CEC7C::getflagteam();

    if(_id_A2191D9C6BBA5BA1 != self.team) {
      if(!_id_35F1C253181907B1::bot_is_capturing_flag(_id_5A94482DD280F417))
        _id_35F1C253181907B1::capture_flag(_id_5A94482DD280F417, "critical", 1);

      return 1;
    }
  }

  return 0;
}