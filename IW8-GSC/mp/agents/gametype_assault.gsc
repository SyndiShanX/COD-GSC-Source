/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\agents\gametype_assault.gsc
***********************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["_encstr_8BB007E03658CBCAE4"]["_encstr_B672066D30FF90B7"] = ::agent_player_dom_think;
}

agent_player_dom_think() {
  thread _encstr_8FB2269BC6E42DE01DDC5EDA389731DB3A37BCC4F6476EFA3B0BB6ACA3BC38CAF58CB7DA177637C6::bot_dom_think();
}

agent_squadmember_dom_think() {
  var_0 = undefined;

  foreach(var_2 in self.owner.touchtriggers) {
    if(var_2.id == "_encstr_87D9083A6F628DDB5F1F")
      var_0 = var_2;
  }

  if(isDefined(var_0)) {
    var_4 = var_0 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getflagteam();

    if(var_4 != self.team) {
      if(!_encstr_8FB2269BC6E42DE01DDC5EDA389731DB3A37BCC4F6476EFA3B0BB6ACA3BC38CAF58CB7DA177637C6::bot_is_capturing_flag(var_0))
        _encstr_8FB2269BC6E42DE01DDC5EDA389731DB3A37BCC4F6476EFA3B0BB6ACA3BC38CAF58CB7DA177637C6::capture_flag(var_0, "_encstr_99CC09DA9020C4ECD149AD", 1);

      return 1;
    }
  }

  return 0;
}