/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\laststand_heal.gsc
************************************************/

function laststandheal_onset() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("lastStandHeal_unset");
  waittillframeend();
  thread laststandheal_watchrespawn();
  self.laststandheal_hassuperweapon = 1;

  for(;;) {
    if(self.laststandheal_hassuperweapon && (!istrue(self.inlaststand) || istrue(self.stuckinlaststand) || istrue(scripts\mp\utility\player::registerpuzzleinteractions()))) {
      var_0 = scripts\mp\supers::getcurrentsuper().staticdata.weapon;
      self clearoffhandspecial();

      if(isDefined(var_0)) {
        scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
      }

      self.laststandheal_hassuperweapon = 0;
    } else if(!self.laststandheal_hassuperweapon && istrue(self.inlaststand) && !istrue(self.stuckinlaststand) && !istrue(scripts\mp\utility\player::registerpuzzleinteractions())) {
      var_0 = scripts\mp\supers::getcurrentsuper().staticdata.weapon;
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
      var_1 = scripts\engine\utility::ter_op(scripts\mp\supers::issuperready(), 1, 0);
      self setweaponammoclip(var_0, var_1);
      self assignweaponoffhandspecial(var_0);
      self.laststandheal_hassuperweapon = 1;
    }

    wait 0.05;
  }
}

function laststandheal_unset() {
  self notify("lastStandHeal_unset");
}

function laststandheal_watchrespawn() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("lastStandHeal_unset");

  for(;;) {
    self waittill("spawned_player");
    waittillframeend();
    laststandheal_onrespawn();
  }
}

function laststandheal_onrespawn() {
  var_0 = scripts\mp\supers::getcurrentsuper().staticdata.weapon;
  self clearoffhandspecial();

  if(isDefined(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
  }

  self.laststandheal_hassuperweapon = 0;
}

function laststandheal_beginuse() {
  thread laststandheal_think();
  thread laststandheal_setinactivewhendone();
  return true;
}

function laststandheal_think() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("last_stand_finished");
  scripts\engine\utility::delaythread(0.05, &laststandheal_drainsupermeter);
  self.laststandhealisactive = 1;
  self notify("last_stand_heal_active");
  self notify("handle_revive_message");
  scripts\common\utility::allow_movement(0);
  wait 0.45;
  self playlocalsound("laststand_heal_start");
  self notify("force_regeneration");

  while(self.health < self.maxhealth) {
    waitframe();
  }

  scripts\common\utility::allow_movement(1);
  scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
  self playlocalsound("laststand_heal_done");
  self notify("last_stand_heal_success");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "use_self_revive");
}

function laststandheal_drainsupermeter() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("last_stand_heal_success");

  for(;;) {
    scripts\mp\supers::reducesuperusepercent(5, 0, 1);
    var_0 = scripts\mp\supers::getcurrentsuper();

    if(var_0.usepercent <= 0) {
      return;
    }
  }
}

function laststandheal_setinactivewhendone() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::ref_143b4("death", "last_stand_finished");
  self.laststandhealisactive = 0;
}

function laststandheal_gethealthperframe() {
  return 2;
}