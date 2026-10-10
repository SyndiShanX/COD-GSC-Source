/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1407e72346815bc3.gsc
*************************************************/

#using script_1407e72346815bc3;
#using scripts\cp_mp\stealth\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\perk;
#namespace manager_mp;

function init() {
  if(getDvar(@ "hash_7611a2790a0bf7fe", "") == "dmz" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "exgm") {
    level.var_6ccee8e6c00f06e6 = &namespace_583fd9066a09cd33::init_player;
    setdvarifuninitialized(@ "scr_sixthsense_enabled", 1);

    if(getdvarint(@ "scr_sixthsense_enabled")) {
      level.stealth.fnsixthsense = &sixthsense_init;
      level thread scripts\cp_mp\stealth\utility::function_a5ff5e1965faf40e();
    }
  }
}

function init_player() {
  self waittill("giveLoadout");

  if(isDefined(level.stealth.fnsixthsense)) {
    [[level.stealth.fnsixthsense]]();
  }
}

function sixthsense_init() {
  self endon("death");
  self.sixthsense = spawnStruct();
  self.sixthsense.active = 1;

  setdvarifuninitialized(@ "hash_3a87475a75de0350", 0);

  scripts\mp\utility\perk::giveperk("specialty_ai_stealth_sixth_sense");
}

function dropaiaccuracy() {
  if(!istrue(level.supportsai)) {
    return;
  }

  assertex(isPlayer(self), " This function needs to be called on a Player entity ");
  scripts\cp_mp\stealth\utility::setattackeraccuracy(0.1);
}

function revertaiaccuracy() {
  if(!istrue(level.supportsai)) {
    return;
  }

  assertex(isPlayer(self), " This function needs to be called on a Player entity ");
  scripts\cp_mp\stealth\utility::setattackeraccuracy(1);
}