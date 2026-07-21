/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\equipment\throwing_knife_cp.gsc
***********************************************/

throwing_knife_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_99C10CE3C6F341670758978F803B", ::_id_13B50);
}

_id_13B50(var_0) {
  if(scripts\cp\cp_powers::haspower("_encstr_B8F514D0A28B93131F1C5B4EEF57B87D7708B8908AA7"))
    var_1 = "_encstr_B8F514D0A28B93131F1C5B4EEF57B87D7708B8908AA7";
  else if(scripts\cp\cp_powers::haspower("_encstr_8D4919C1BDDD5627F5A334E4DBDDB4CDB369B95ACCB2BE332D2795"))
    var_1 = "_encstr_8D4919C1BDDD5627F5A334E4DBDDB4CDB369B95ACCB2BE332D2795";
  else if(scripts\cp\cp_powers::haspower("_encstr_B8631DCA3868B5EB68291B7B772402E64004C514F12B4752D9134F7B75C36A"))
    var_1 = "_encstr_B8631DCA3868B5EB68291B7B772402E64004C514F12B4752D9134F7B75C36A";
  else if(scripts\cp\cp_powers::haspower("_encstr_A6901AE78F3F490D39B3B890FACBF3E0A70360D31E1F76795A4A9068"))
    var_1 = "_encstr_A6901AE78F3F490D39B3B890FACBF3E0A70360D31E1F76795A4A9068";
  else
    return 0;

  var_2 = self.powers[var_1].charges;
  var_3 = self.powers[var_1].maxcharges;

  if(var_2 + 1 > var_3)
    return 0;

  scripts\cp\cp_powers::power_adjustcharges(1, "_encstr_BA7F0830B3A7859B60B0");
  scripts\cp\cp_damagefeedback::hudicontype("_encstr_92590EFBF91ED25750D8D7DC30B88E8A");
  return 1;
}