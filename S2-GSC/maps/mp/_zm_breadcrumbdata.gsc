/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_zm_breadcrumbdata.gsc
*********************************************/

func_00D5() {
  if(!isDefined(game["gamestarted"])) {
    function_0377("mp/ddl/zm_breadcrumbdata.ddl");
    function_0378();
  }
}

func_5EB1() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(!maps\mp\_utility::func_3FA0("prematch_done")) {
    level waittill("prematch_over");
  }

  if(isbot(self) || function_026D(self)) {
    return;
  }

  if(maps\mp\_utility::func_57A0(self) && isDefined(self.var_5CC6) && maps\mp\_matchdata::func_1F59(self.var_5CC6)) {
    var_00 = getdvarfloat("34");
    for(;;) {
      var_01 = self playerads() > 0.5;
      var_02 = self getcurrentweapon();
      var_03 = lib_0547::func_AAF9(var_02, 1, 0);
      recordzmbreadcrumbdataforplayer(self, self.var_5CC6, var_01, var_03);
      wait(var_00);
    }
  }
}