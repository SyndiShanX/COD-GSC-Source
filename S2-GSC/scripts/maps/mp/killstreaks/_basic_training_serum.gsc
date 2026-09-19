/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_basic_training_serum.gsc
*****************************************************************/

init() {
  level thread scorestreakdvarhostmigration();
  level._id_5A61["basic_training_serum"] = ::tryusebasictrainingserum;
  level._id_5A7D["basic_training_serum"] = "basic_training_serum";
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
    maps\mp\gametypes\_hostmigration::_id_A782();
  }
}

tryusebasictrainingserum(var_0) {
  var_1 = tryusebasictrainingseruminternal();
  return var_1;
}

tryusebasictrainingseruminternal() {
  if(maps\mp\_utility::isreallyalive(self)) {
    if(!isDefined(self.raidserumactive) || !self.raidserumactive) {
      _id_0485::_id_5E9A("basic_training_serum", self.origin);
      self.pers["basicTrainingSerumsUsed"]++;
      self.pers["basicTrainingSerumEarnTimeRemaining"] = level.serumbasictrainingcooldowninterval;
      self.pers["basicTrainingSerumEarnProgress"] = 0;
      thread startcombatbuff();
      _id_0378::_id_8D74("aud_serum_syringe_foley");
      _id_0378::_id_8D74("aud_serum_buff_start");
      return 1;
    } else {
      self iprintlnbold(&"KILLSTREAKS_DLC4_ONE_SERUM_AT_A_TIME");
      return 0;
    }
  } else
    return 0;
}

startcombatbuff() {
  thread combatbuffdeathlistener();
  self.raidpreserumperkslist = self._id_6F65;
  self.raidbasictrainingbuff = 1;
  self.raidserumactive = 1;
  self.basictrainingserumactive = 1;
  _id_0513::_id_A13B();

  foreach(var_1 in level.basictrainingserumperks) {
    if(!maps\mp\_utility::_hasperk(var_1))
      maps\mp\_utility::giveperk(var_1);
  }

  thread maps\mp\killstreaks\_raid_ss_serum_util::altered_state_apply(0, level.serumbasictrainingactiveduration, "orange", 0.25, 0.125, 0.4);
  thread maps\mp\killstreaks\_raid_ss_serum_util::serumtimerupdate(level.serumbasictrainingactiveduration);
  self waittill("serum_finished");

  foreach(var_1 in level.basictrainingserumperks) {
    if(!maps\mp\killstreaks\_raid_ss_serum_util::serumhadperk(var_1))
      maps\mp\_utility::_id_0735(var_1);
  }

  self.raidbasictrainingbuff = undefined;
  self.raidserumactive = undefined;
  self.basictrainingserumactive = undefined;
  _id_0513::_id_A13B();
}

combatbuffdeathlistener() {
  self endon("disconnect");
  self endon("serum_finished");
  level endon("game_ended");
  self waittill("death");
  self.raidbasictrainingbuff = undefined;
  self.raidserumactive = undefined;
  self.basictrainingserumactive = undefined;
  _id_0513::_id_A13B();
}