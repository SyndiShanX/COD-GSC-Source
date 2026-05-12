/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_raid_ss_serum_a.gsc
****************************************************/

func_00D5() {
  level.var_5A61["raid_ss_serum_a"] = ::truuseseruma;
  level.var_5A7D["raid_ss_serum_a"] = "raid_ss_serum_a";
}

truuseseruma(param_00) {
  var_01 = truuseserumainternal();
  return var_01;
}

truuseserumainternal() {
  if(maps\mp\_utility::func_57A0(self)) {
    if(!isDefined(self.raidserumactive) || !self.raidserumactive) {
      maps\mp\_matchdata::func_5E9A("raid_ss_serum_a", self.var_116);
      thread startawareness();
      lib_0378::func_8D74("aud_serum_syringe_foley");
      lib_0378::func_8D74("aud_serum_buff_start");
      return 1;
    }

    self iclientprintlnbold(&"KILLSTREAKS_DLC4_ONE_SERUM_AT_A_TIME");
    return 0;
  }

  return 0;
}

startawareness() {
  thread awarenessdeathlistener();
  self.raidserumactive = 1;
  self.raidpreserumperkslist = self.var_6F65;
  if(!maps\mp\_utility::func_649("specialty_perception")) {
    maps\mp\_utility::func_47A2("specialty_perception");
  }

  if(getdvarint("mp_raid_dlc4_test_serums", 0) == 1) {
    thread maps\mp\killstreaks\_raid_ss_serum_util::altered_state_apply(0, 5, "green");
  } else {
    thread maps\mp\killstreaks\_raid_ss_serum_util::altered_state_apply(0, 30, "green");
  }

  thread highlightenemyplayers();
}

highlightenemyplayers() {
  level endon("game_ended");
  self endon("disconnect");
  thread stopserumtimer();
  self.awarenessserumactive = 1;
  foreach(var_01 in level.var_744A) {
    if(var_01.var_1A7 != self.var_1A7) {
      thread awarenessserumhighlightplayer(var_01);
    }
  }
}

awarenessserumhighlightplayer(param_00) {
  param_00 endon("disconnect");
  while(self.awarenessserumactive) {
    if(isDefined(param_00.var_6DEC) && param_00.var_6DEC) {
      while(self.awarenessserumactive && param_00.var_6DEC) {
        wait 0.05;
      }
    }

    param_00 hudoutlineenableforclient(self, 1, 0);
    while(self.awarenessserumactive && !isDefined(param_00.var_6DEC) || !param_00.var_6DEC) {
      wait 0.05;
    }
  }

  param_00 hudoutlinedisableforclient(self);
}

stopserumtimer() {
  level endon("game_ended");
  self endon("disconnect");
  if(getdvarint("mp_raid_dlc4_test_serums", 0) == 1) {
    thread maps\mp\killstreaks\_raid_ss_serum_util::serumtimerupdate(5);
  } else {
    thread maps\mp\killstreaks\_raid_ss_serum_util::serumtimerupdate(30);
  }

  self waittill("serum_finished");
  if(!maps\mp\killstreaks\_raid_ss_serum_util::serumhadperk("specialty_perception")) {
    maps\mp\_utility::func_735("specialty_perception");
  }

  self.raidserumactive = undefined;
  self.awarenessserumactive = 0;
}

awarenessdeathlistener() {
  self endon("disconnect");
  self endon("serum_finished");
  level endon("game_ended");
  self waittill("death");
  self.raidserumactive = undefined;
  self.awarenessserumactive = 0;
}