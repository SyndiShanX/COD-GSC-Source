/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_raid_ss_serum_c.gsc
****************************************************/

func_00D5() {
  level.var_5A61["raid_ss_serum_c"] = ::truuseserumc;
  level.var_5A7D["raid_ss_serum_c"] = "raid_ss_serum_c";
  level.var_5A7D["war_sword_mp"] = "raid_ss_serum_c";
  level.raidmaniacmovespeedscale = 1.15;
}

truuseserumc(param_00) {
  var_01 = truuseserumcinternal();
  return var_01;
}

truuseserumcinternal() {
  if(maps\mp\_utility::func_57A0(self)) {
    if(!isDefined(self.raidserumactive) || !self.raidserumactive) {
      maps\mp\_matchdata::func_5E9A("raid_ss_serum_c", self.var_116);
      thread startmaniac();
      lib_0378::func_8D74("aud_serum_syringe_foley");
      lib_0378::func_8D74("aud_serum_buff_start");
      return 1;
    }

    self iclientprintlnbold(&"KILLSTREAKS_DLC4_ONE_SERUM_AT_A_TIME");
    return 0;
  }

  return 0;
}

startmaniac() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  thread maniacdeathlistener();
  self.raidserumactive = 1;
  self.raidmaniac = 1;
  maps\mp\gametypes\_weapons::func_A13B();
  self.var_BC = 100;
  thread maniacoverlay();
  thread maniacweapon();
  if(getdvarint("mp_raid_dlc4_test_serums", 0) == 1) {
    thread maps\mp\killstreaks\_raid_ss_serum_util::serumtimerupdate(5);
  } else {
    thread maps\mp\killstreaks\_raid_ss_serum_util::serumtimerupdate(30);
  }

  self waittill("serum_finished");
  onmaniacend();
  self notify("stop_maniac");
  maps\mp\gametypes\_weapons::func_A13B();
}

maniacweapon() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("altered_state_start");
  var_00 = self getcurrentprimaryweapon();
  var_01 = self hasweapon("war_sword_mp");
  if(!var_01) {
    maps\mp\_utility::func_642("war_sword_mp");
  }

  self switchtoweapon("war_sword_mp");
  common_scripts\utility::func_603();
  common_scripts\utility::func_600();
  self waittill("altered_state_end");
  common_scripts\utility::func_614();
  common_scripts\utility::func_617();
  self switchtoweapon(var_00);
  self waittill("weapon_switch_started");
  if(!var_01) {
    self takeweapon("war_sword_mp");
  }
}

maniacoverlay() {
  self endon("stop_maniac");
  if(getdvarint("mp_raid_dlc4_test_serums", 0) == 1) {
    thread maps\mp\killstreaks\_raid_ss_serum_util::altered_state_apply(0, 5, "blue");
  } else {
    thread maps\mp\killstreaks\_raid_ss_serum_util::altered_state_apply(0, 30, "blue");
  }

  self waittill("death");
  self notify("force_stop_serum");
  onmaniacend();
}

onmaniacend() {
  self.raidmaniac = undefined;
  self.raidserumactive = undefined;
  self setclientomnvar("serum_active_percent", 0);
}

maniacdeathlistener() {
  self endon("disconnect");
  self endon("serum_finished");
  level endon("game_ended");
  self waittill("death");
  onmaniacend();
  maps\mp\gametypes\_weapons::func_A13B();
}