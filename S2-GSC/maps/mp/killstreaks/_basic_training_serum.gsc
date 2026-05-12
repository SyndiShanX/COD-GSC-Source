/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_basic_training_serum.gsc
*********************************************************/

func_00D5() {
  level thread scorestreakdvarhostmigration();
  level.var_5A61["basic_training_serum"] = ::tryusebasictrainingserum;
  level.var_5A7D["basic_training_serum"] = "basic_training_serum";
  level.basictrainingserumperks = ["specialty_rof", "specialty_bulletaccuracy", "specialty_fastreload", "specialty_quickdraw_new", "specialty_quickswap"];
  level.serumbasictrainingcooldowninterval = 30000;
  level.serumbasictrainingactiveduration = 8;
}

scorestreakdvarhostmigration() {
  level endon("game_ended");
  setDvar("scorestreak_enabled_basic_training_serum", 1);
  for(;;) {
    level waittill("host_migration_begin");
    setDvar("scorestreak_enabled_basic_training_serum", 1);
    maps\mp\gametypes\_hostmigration::func_A782();
  }
}

tryusebasictrainingserum(param_00) {
  var_01 = tryusebasictrainingseruminternal();
  return var_01;
}

tryusebasictrainingseruminternal() {
  if(maps\mp\_utility::func_57A0(self)) {
    if(!isDefined(self.raidserumactive) || !self.raidserumactive) {
      maps\mp\_matchdata::func_5E9A("basic_training_serum", self.var_0116);
      self.var_012C["basicTrainingSerumsUsed"]++;
      self.var_012C["basicTrainingSerumEarnTimeRemaining"] = level.serumbasictrainingcooldowninterval;
      self.var_012C["basicTrainingSerumEarnProgress"] = 0;
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
  self.raidbasictrainingbuff = 1;
  self.raidserumactive = 1;
  self.basictrainingserumactive = 1;
  maps\mp\gametypes\_weapons::func_A13B();
  foreach(var_01 in level.basictrainingserumperks) {
    if(!maps\mp\_utility::func_0649(var_01)) {
      maps\mp\_utility::func_47A2(var_01);
    }
  }

  thread maps\mp\killstreaks\_raid_ss_serum_util::altered_state_apply(0, level.serumbasictrainingactiveduration, "orange", 0.25, 0.125, 0.4);
  thread maps\mp\killstreaks\_raid_ss_serum_util::serumtimerupdate(level.serumbasictrainingactiveduration);
  self waittill("serum_finished");
  foreach(var_01 in level.basictrainingserumperks) {
    if(!maps\mp\killstreaks\_raid_ss_serum_util::serumhadperk(var_01)) {
      maps\mp\_utility::func_0735(var_01);
    }
  }

  self.raidbasictrainingbuff = undefined;
  self.raidserumactive = undefined;
  self.basictrainingserumactive = undefined;
  maps\mp\gametypes\_weapons::func_A13B();
}

combatbuffdeathlistener() {
  self endon("disconnect");
  self endon("serum_finished");
  level endon("game_ended");
  self waittill("death");
  self.raidbasictrainingbuff = undefined;
  self.raidserumactive = undefined;
  self.basictrainingserumactive = undefined;
  maps\mp\gametypes\_weapons::func_A13B();
}