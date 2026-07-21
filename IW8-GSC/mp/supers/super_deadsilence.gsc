/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\supers\super_deadsilence.gsc
***********************************************/

superdeadsilence_beginsuper() {
  scripts\mp\utility\perk::giveperk("_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939");
  scripts\mp\utility\perk::giveperk("_encstr_99241C0B7A0D70DB62CB697BEF7A1049A2965363E575D986CAE791793FE3");

  if(!scripts\mp\utility\game::isanymlgmatch())
    scripts\mp\utility\perk::giveperk("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8");

  self.deadsilencekills = 0;
  self playlocalsound("_encstr_BADC127043EA5C3B078002455ED797E30BF2281B");
  superdeadsilence_updateuistate(0);
  thread applyfovpresentation();
  thread _id_1397E();
  return 1;
}

superdeadsilence_endsuper(var_0) {
  scripts\mp\utility\perk::removeperk("_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939");
  scripts\mp\utility\perk::removeperk("_encstr_99241C0B7A0D70DB62CB697BEF7A1049A2965363E575D986CAE791793FE3");

  if(!scripts\mp\utility\game::isanymlgmatch())
    scripts\mp\utility\perk::removeperk("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8");

  scripts\cp\vehicles\vehicle_compass_cp::_id_12032("_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D", self.deadsilencekills);

  if(scripts\mp\utility\game::getgametype() != "_encstr_AAE507E8423F63C163")
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self, level.superglobals.staticsuperdata["_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D"].id, self.deadsilencekills, istrue(var_0));

  thread superdeadsilence_endhudsequence();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B607038AAB", "_encstr_AB0F11DCBAE02B274D8DB78E6863ACC237AA0E"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B607038AAB", "_encstr_AB0F11DCBAE02B274D8DB78E6863ACC237AA0E")]](self);

  return 0;
}

superdeadsilence_onkill() {
  if(scripts\mp\utility\game::getgametype() != "_encstr_AAE507E8423F63C163") {
    scripts\mp\utility\stats::incpersstat("_encstr_994F1107B1107C21BBD19743375568B9A0387A", 1);
    scripts\mp\supers::combatrecordsuperkill("_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D");
    self.deadsilencekills++;
    var_0 = scripts\mp\supers::relic_fastbleedout_returnfunc("_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D");

    if(self.deadsilencekills > var_0) {
      var_1 = self.deadsilencekills - var_0;
      scripts\mp\supers::hide_plunderboxes("_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D", var_1);
    }
  }

  var_2 = scripts\mp\utility\game::unset_relic_grounded();
  var_3 = 1;

  if(var_2) {
    var_4 = scripts\mp\supers::getcurrentsuper();

    if(istrue(var_4.shouldcrossbowhitmarker))
      var_3 = 0;
    else
      var_4.shouldcrossbowhitmarker = 1;
  }

  if(var_3) {
    self playlocalsound("_encstr_BADC127043EA5C3B078002455ED797E30BF2281B");
    superdeadsilence_updateuistate(1);
    scripts\mp\supers::resetsuperusepercent();
    thread applyfovpresentation();
  }
}

superdeadsilence_endhudsequence() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  superdeadsilence_updateuistate(2);
  wait 1;
  superdeadsilence_updateuistate(-1);
}

superdeadsilence_updateuistate(var_0) {
  self.deadsilenceuistate = var_0;
  self setclientomnvar("_encstr_A97717236F39FDF8B9C78BC0ED6578A6724F9FBDF753B190C9", var_0);
}

applyfovpresentation() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_8A37157F78F36C9385A8830A1EFB0B2D98C0F753D848D6");
  self endon("_encstr_8A37157F78F36C9385A8830A1EFB0B2D98C0F753D848D6");
  self lerpfovbypreset("_encstr_8B880E3B782B3B528F416928DF5B3D4D");
  var_0 = self.super.staticdata.usetime;
  var_1 = var_0 - 2;
  scripts\engine\utility::_id_143BF(var_1, "_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
  self playlocalsound("_encstr_AFE610235616C837D2632B738DB2BE959B32");
}

_id_1397E() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_950113E6EA07CA93EBABB995FACCB4DCD26E0D2B19");
  self notify("_encstr_AC9D23EA8DD96A32CD60D7CBF84014D24D2EF7697423B36B1001F7AB41B9DD9A63303F1F55");
  self endon("_encstr_AC9D23EA8DD96A32CD60D7CBF84014D24D2EF7697423B36B1001F7AB41B9DD9A63303F1F55");
  level scripts\engine\utility::_id_143A5("_encstr_9B1D0BC7932875276230426AA1", "_encstr_AD9F1168238D48239B0EFB68667263B1FE57F0");
  thread scripts\mp\supers::superusefinished();
}