/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_raid_ss_serum_b.gsc
****************************************************/

func_00D5() {
  level.var_5A61["raid_ss_serum_b"] = ::truuseserumb;
  level.var_5A7D["raid_ss_serum_b"] = "raid_ss_serum_b";
  level.raidcombatbuffmovespeedscale = 1.15;
  level.raidserumbperks = ["specialty_crouchmovement", "specialty_falldamage", "specialty_fastreload", "specialty_sprintreload", "specialty_stalker", "specialty_reducedsway", "specialty_quickswap", "specialty_sharp_focus", "specialty_fastermelee", "specialty_eagleeyes", "specialty_spygame", "specialty_quickdraw_new", "specialty_bulletaccuracy", "specialty_extendedmelee", "specialty_sprintfire", "specialty_divefire"];
}

truuseserumb(param_00) {
  var_01 = truuseserumbinternal();
  return var_01;
}

truuseserumbinternal() {
  if(maps\mp\_utility::func_57A0(self)) {
    if(!isDefined(self.raidserumactive) || !self.raidserumactive) {
      maps\mp\_matchdata::func_5E9A("raid_ss_serum_b", self.var_116);
      thread startcombatbuff();
      lib_0378::func_8D74("aud_serum_syringe_foley");
      lib_0378::func_8D74("aud_serum_buff_start");
      return 1;
    }

    self iclientprintlnbold(&"KILLSTREAKS_DLC4_ONE_SERUM_AT_A_TIME");
    return 0;
  }

  return 0;
}

startcombatbuff() {
  thread combatbuffdeathlistener();
  self.raidpreserumperkslist = self.var_6F65;
  self.raidcombatbuff = 1;
  self.raidserumactive = 1;
  maps\mp\gametypes\_weapons::func_A13B();
  foreach(var_01 in level.raidserumbperks) {
    if(!maps\mp\_utility::func_649(var_01)) {
      maps\mp\_utility::func_47A2(var_01);
    }
  }

  if(getdvarint("mp_raid_dlc4_test_serums", 0) == 1) {
    thread maps\mp\killstreaks\_raid_ss_serum_util::altered_state_apply(0, 5, "purple");
    thread maps\mp\killstreaks\_raid_ss_serum_util::serumtimerupdate(5);
  } else {
    thread maps\mp\killstreaks\_raid_ss_serum_util::altered_state_apply(0, 30, "purple");
    thread maps\mp\killstreaks\_raid_ss_serum_util::serumtimerupdate(30);
  }

  self waittill("serum_finished");
  foreach(var_01 in level.raidserumbperks) {
    if(!maps\mp\killstreaks\_raid_ss_serum_util::serumhadperk(var_01)) {
      maps\mp\_utility::func_735(var_01);
    }
  }

  self.raidcombatbuff = undefined;
  self.raidserumactive = undefined;
  maps\mp\gametypes\_weapons::func_A13B();
}

combatbuffdeathlistener() {
  self endon("disconnect");
  self endon("serum_finished");
  level endon("game_ended");
  self waittill("death");
  self.raidserumactive = undefined;
  self.raidcombatbuff = 0;
  maps\mp\gametypes\_weapons::func_A13B();
}