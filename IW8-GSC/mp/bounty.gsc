/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bounty.gsc
***********************************************/

init() {
  level.bounty_index = [];
  level._effect["_encstr_8D4D16D9991EF5D6F6FAB6DE9B59BCEBB12CCD1AEBB2F083"] = loadfx("_encstr_961F2FE34C7176E1632A26DF3819B19B135EEBDA80F33B7FAB4873D7A830A7C2EF7837D0AF17E26B30991F5358C0463A79");

  if(1) {
    thread onplayerconnect();
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
    scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::onplayerjoinedteam);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 bountyinit();
  }
}

bountyinit() {
  if(!isDefined(self.bountypoints)) {
    playerregisterbountyindex();
    playerresetbountypoints();
    playerresetbountystreak();
  }
}

onplayerdisconnect(var_0) {
  if(isDefined(var_0.bounty_index))
    level.bounty_index[var_0.bounty_index] = undefined;
}

onplayerjoinedspectators(var_0) {
  if(1) {
    if(isDefined(var_0.bounty_index)) {
      var_0 playerresetbountypoints();
      var_0 playerresetbountystreak();
    }
  }
}

onplayerjoinedteam(var_0) {
  if(1) {
    if(isDefined(var_0.bounty_index)) {
      var_0 playerresetbountypoints();
      var_0 playerresetbountystreak();
    }
  }
}

playerregisterbountyindex() {
  for(var_0 = 0; isDefined(level.bounty_index[var_0]); var_0++) {}

  level.bounty_index[var_0] = self;
  self.bounty_index = var_0;
}

playergetbountypoints() {
  return self.bountypoints;
}

playersetbountypoints(var_0) {
  self.bountypoints = var_0;
  level.bounty_index[self.bounty_index] setbountycount(self.bountypoints);
}

playerresetbountypoints(var_0) {
  if(!1) {
    return;
  }
  if(isDefined(var_0))
    wait(var_0);

  if(isDefined(self))
    playersetbountypoints(0);
}

playerresetbountystreak(var_0) {
  if(!1) {
    return;
  }
  if(isDefined(var_0))
    wait(var_0);

  if(isDefined(self))
    self.bountystreak = 0;
}

bountyincreasestreak(var_0) {
  if(!1) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = 1;

  self.bountystreak = self.bountystreak + var_0;
  bountyconvert();
}

bountyconvert() {
  if(!1) {
    return;
  }
  var_0 = playergetbountypoints();
  var_1 = int(floor(self.bountystreak / 3));

  if(var_1 > var_0 && var_1 <= 5)
    playersetbountypoints(var_1);
}

bountycollect(var_0, var_1) {
  if(!1) {
    return;
  }
  if(scripts\mp\utility\perk::_hasperk("_encstr_B1B5116ECA8217E0A9731878D7C278639A73E3")) {
    if(var_0 > 0) {
      for(var_2 = 0; var_2 < var_0; var_2++) {
        thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B64C0742801D38E33F");
        bountyincreasestreak();
        playFX(scripts\engine\utility::getfx("_encstr_8D4D16D9991EF5D6F6FAB6DE9B59BCEBB12CCD1AEBB2F083"), var_1 + (0, 0, 45));
      }

      thread scripts\mp\hud_util::teamplayercardsplash("_encstr_884E19303A35E9D8EF34E87E37B7A091D861B8C802CD2391C34D0D", self);
    }
  }
}