/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\laststand_heal.gsc
************************************************/

laststandheal_onset() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("lastStandHeal_unset");
  waittillframeend;
  thread laststandheal_watchrespawn();
  self.laststandheal_hassuperweapon = 1;

  for(;;) {
    if(self.laststandheal_hassuperweapon && (!istrue(self.inlaststand) || istrue(self.stuckinlaststand) || istrue(scripts\mp\utility\player::getbeingrevivedinternal()))) {
      _id_641083E829D5514C = scripts\mp\supers::getcurrentsuper().staticdata.weapon;
      self clearoffhandspecial();

      if(isDefined(_id_641083E829D5514C))
        scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_641083E829D5514C);

      self.laststandheal_hassuperweapon = 0;
    } else if(!self.laststandheal_hassuperweapon && istrue(self.inlaststand) && !istrue(self.stuckinlaststand) && !istrue(scripts\mp\utility\player::getbeingrevivedinternal())) {
      _id_641083E829D5514C = scripts\mp\supers::getcurrentsuper().staticdata.weapon;
      scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_641083E829D5514C);
      ammo = scripts\engine\utility::ter_op(scripts\mp\supers::issuperready(), 1, 0);
      self setweaponammoclip(_id_641083E829D5514C, ammo);
      self assignweaponoffhandspecial(_id_641083E829D5514C);
      self.laststandheal_hassuperweapon = 1;
    }

    wait 0.05;
  }
}

laststandheal_unset() {
  self notify("lastStandHeal_unset");
}

laststandheal_watchrespawn() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("lastStandHeal_unset");

  for(;;) {
    self waittill("spawned_player");
    waittillframeend;
    laststandheal_onrespawn();
  }
}

laststandheal_onrespawn() {
  _id_641083E829D5514C = scripts\mp\supers::getcurrentsuper().staticdata.weapon;
  self clearoffhandspecial();

  if(isDefined(_id_641083E829D5514C))
    scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_641083E829D5514C);

  self.laststandheal_hassuperweapon = 0;
}

laststandheal_beginuse() {
  thread laststandheal_think();
  thread laststandheal_setinactivewhendone();
  return 1;
}

laststandheal_think() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("last_stand_finished");
  scripts\engine\utility::delaythread(0.05, ::laststandheal_drainsupermeter);
  self.laststandhealisactive = 1;
  self notify("last_stand_heal_active");
  self notify("handle_revive_message");
  _id_3B64EB40368C1450::set("lastStandHeal", "allow_movement", 0);
  wait 0.45;
  self playlocalsound("laststand_heal_start");
  self notify("force_regeneration");

  while(self.health < self.maxhealth)
    waitframe();

  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("lastStandHeal");
  scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
  self playlocalsound("laststand_heal_done");
  self notify("last_stand_heal_success");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_1F1F4FE800E03B33");
}

laststandheal_drainsupermeter() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("last_stand_heal_success");

  for(;;) {
    scripts\mp\supers::reducesuperusepercent(5, 0, 1);
    _id_19163E14365D9264 = scripts\mp\supers::getcurrentsuper();

    if(_id_19163E14365D9264.usepercent <= 0)
      return;
  }
}

laststandheal_setinactivewhendone() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_return_no_endon_death_2("death", "last_stand_finished");
  self.laststandhealisactive = 0;
}

laststandheal_gethealthperframe() {
  return 2;
}