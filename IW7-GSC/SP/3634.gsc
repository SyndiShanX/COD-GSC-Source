/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3634.gsc
**************************************/

_id_61FD(var_0, var_1) {
  self endon("death");
  self notifyonplayercommand("gundown_interupt", "+attack");
  self notifyonplayercommand("gundown_interupt", "+gostand");
  self notifyonplayercommand("gundown_interupt_noout", "+moveup");
  self notifyonplayercommand("gundown_interupt_noout", "+toggleads_throw");
  self notifyonplayercommand("gundown_interupt_noout", "+ads_akimbo_accessible");
  self notifyonplayercommand("gundown_interupt_noout", "+speed_throw");
  self notifyonplayercommand("gundown_reload_hit", "+usereload");

  if(!isDefined(level._id_EC8C["gundown_rig"]))
    _id_86ED();

  if(isDefined(var_0))
    level.player thread scripts\sp\utility::_id_D2CD(var_0, 0.1);

  setsaveddvar("player_sprintUnlimited", 1);
  setsaveddvar("bg_sprintLoopTimeScale", 1.3);
  wait 0.1;
  self._id_5533 = 0;
  var_2 = 0;

  for(;;) {
    while(level.player getcurrentweapon() == "none")
      wait 0.05;

    level.player thread _id_5521();
    _id_86F3(var_2);
    var_2 = 1750;
    self notify("gundown_cooldown_expired");

    if(self._id_5533) {
      break;
    }

    setsaveddvar("cg_drawCrosshair", 0);
    self _meth_818A();
    self allowfire(0);
    var_3 = level.player getcurrentweapon();
    var_4 = getweaponmodel(var_3);
    var_5 = scripts\sp\utility::_id_10639("gundown_rig", self.origin, self getplayerangles());
    var_5 _meth_81E2(self, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
    var_5 attach(var_4, "tag_weapon_right", 1);
    self._id_86F1 = var_5;
    thread _id_86EE();
    thread _id_86F2(var_0, var_1);
    thread _id_86F0();
    thread _id_86C6(var_5);
    var_6 = scripts\engine\utility::waittill_any_return("gundown_interupt", "gundown_interupt_noout", "weapnext", "weapon_switch_started", "gundown_disabled", "pickup");
    self notify("gun_up");

    if(var_6 == "gundown_interupt" || var_6 == "gundown_disabled") {
      var_5 scripts\engine\utility::delaycall(0.05, ::_meth_82B1, var_5 scripts\sp\utility::_id_7DC1("gundown_out"), 2);
      var_5 scripts\sp\anim::_id_1F35(var_5, "gundown_out");
    }

    var_5 delete();
    setsaveddvar("cg_drawCrosshair", 1);
    self showviewmodel();
    self allowfire(1);

    if(var_6 == "gundown_disabled") {
      break;
    }
  }

  level.player thread scripts\sp\utility::_id_D2CA(0.1);
  setsaveddvar("player_sprintUnlimited", 0);
  setsaveddvar("bg_sprintLoopTimeScale", 1);
}

_id_5532() {
  self notify("gundown_disabled");
}

_id_86F3(var_0) {
  self endon("disable_during_sprint");
  var_1 = gettime();

  while(gettime() - var_1 < var_0) {
    if(self adsButtonPressed())
      var_1 = gettime();
    else if(self attackButtonPressed())
      var_1 = gettime();
    else if(self issprinting())
      var_1 = gettime();
    else if(self issprintsliding())
      var_1 = gettime();
    else if(self isthrowinggrenade())
      var_1 = gettime();
    else if(self isreloading())
      var_1 = gettime();
    else if(self isjumping())
      var_1 = gettime();
    else if(scripts\sp\utility::_id_9F59())
      var_1 = gettime();
    else if(!self _meth_843C())
      var_1 = gettime();

    wait 0.05;
  }
}

#using_animtree("player");

_id_86C6(var_0) {
  self endon("gun_up");
  self endon("death");
  var_0 scripts\sp\anim::_id_1F35(var_0, "gundown_in");
  var_0 _meth_82A2(%viewmodel_honeybadger_walk_additive, 1.0, 0.0, 1.0);
  thread _id_86EF(var_0);
}

_id_86EF(var_0) {
  self endon("gun_up");

  for(;;) {
    var_1 = length(self getvelocity());
    var_2 = var_1 / 190;
    var_0 _meth_82A2(%gesture_demeaners_test_walk, var_2, 0.05, var_2 * 15.0);
    wait 0.05;
  }
}

_id_86F2(var_0, var_1) {
  self endon("gun_up");
  scripts\engine\utility::waitframe();

  for(;;) {
    if(self issprinting() || self issprintsliding()) {
      self notify("gundown_interupt_noout");

      if(isDefined(var_1))
        level.player thread scripts\sp\utility::_id_D2CD(var_1, 0.1);

      while(self _meth_8439())
        wait 0.05;

      if(isDefined(var_1))
        level.player thread scripts\sp\utility::_id_D2CD(var_0, 0.1);
    }

    wait 0.05;
  }
}

_id_5521() {
  self endon("gundown_cooldown_expired");
  scripts\engine\utility::waittill_any_return("gundown_disabled");
  self._id_5533 = 1;
}

_id_86F0() {
  self endon("gun_up");

  for(;;) {
    self waittill("gundown_reload_hit");

    if(self isreloading())
      self notify("gundown_interupt_noout");
  }
}

_id_86EE() {
  self waittill("death");

  if(isDefined(self._id_86F1))
    self._id_86F1 delete();
}

_id_86ED() {
  level._id_EC87["gundown_rig"] = #animtree;
  level._id_EC8C["gundown_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["gundown_rig"]["gundown_in"] = % vm_relaxed_in;
  level._id_EC85["gundown_rig"]["gundown_idle"][0] = % vm_relaxed_idle;
  level._id_EC85["gundown_rig"]["gundown_idle_addititve"] = % viewmodel_honeybadger_walk_additive;
  level._id_EC85["gundown_rig"]["gundown_out"] = % vm_relaxed_out;
}