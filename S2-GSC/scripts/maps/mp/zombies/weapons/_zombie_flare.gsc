/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_flare.gsc
*************************************************************/

init(var_0) {
  common_scripts\utility::_id_092C("signal_flare_zombie", "vfx/smoke/signal_flare_volumetric_runner");
  common_scripts\utility::_id_092C("signal_flare_zombie_spec", "vfx/zombie/prototype_fx/dig/zmd_flare_volumetric_runner");
  level.zombietacticalweapon["signal_flare_zm"] = 1;
}

flare_get_weapon_name() {
  return "signal_flare_zm";
}

flare_player_give_flare() {
  var_0 = "signal_flare_zm";

  if(!common_scripts\utility::_id_562E(self.seen_flare_hint)) {
    _id_0555::_id_83DD("dlc3_tac_hint", self);
    self.seen_flare_hint = 1;
  }

  thread flare_player_throw_monitor();
  self._id_60A0 = 3;
  self setoffhandsecondaryclass(var_0);
  _id_0586::_id_078C(var_0);
  self setweaponammoclip(var_0, 3);
}

flare_player_throw_monitor() {
  self notify("starting_flare_watch");
  self endon("disconnect");
  self endon("starting_flare_watch");

  for(;;) {
    var_0 = flare_player_get_thrown_flare();
    flare_player_throw(var_0);
    waitframe();
  }
}

flare_player_get_thrown_flare() {
  self endon("disconnect");
  self endon("starting_flare_watch");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(issubstr(var_1, "signal_flare_")) {
      var_0._id_01D0 = var_1;
      return var_0;
    }

    waitframe();
  }
}

flare_player_throw(var_0) {
  self endon("disconnect");
  self endon("starting_flare_watch");

  if(isDefined(var_0)) {
    var_0 endon("death");

    if(_id_0547::_id_577E(self)) {
      var_0 delete();
      return;
    }

    var_0 thread flare_handle_effects(self, var_0._id_01D0);
  }
}

flare_handle_effects(var_0, var_1) {
  var_0 endon("disconnect");
  self endon("make_dud");
  self endon("death");
  self waittill("missile_stuck");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level.zmb_on_signal_flare_stuck))
    level thread[[level.zmb_on_signal_flare_stuck]](self);

  var_2 = spawnStruct();
  var_2.landing_point = self.origin;
  var_2._id_0117 = self._id_0117;
  var_2._id_3D33 = 1750;
  var_2.burn_duration = 1750;
  var_2._id_3D37 = 16384;
  var_2._id_3F83 = common_scripts\utility::_id_8FFC();
  var_2._id_3F83 linktosynchronizedparent(self);
  var_2._id_3F83 _meth_805B();
  _func_147(common_scripts\utility::_id_44F5("signal_flare_zombie"), var_2._id_3F83, "TAG_ORIGIN");
  thread flare_handle_cleanup(var_2);
  wait 1;

  while(isDefined(self)) {
    var_3 = _id_0547::_id_408F();

    foreach(var_5 in var_3) {
      var_6 = var_5._id_0A4B;

      if(!_id_0547::_id_5565(var_6, "zombie_generic") && !_id_0547::_id_5565(var_6, "zombie_berserker") && !_id_0547::_id_5565(var_6, "zombie_exploder")) {
        continue;
      }
      if(common_scripts\utility::_id_562E(var_5.on_fire)) {
        continue;
      }
      if(distancesquared(var_5.origin, var_2.landing_point) < var_2._id_3D37 / 2) {
        if(_func_07E(var_5.origin, var_2.landing_point, 0, var_5, self)) {
          var_5 _meth_8682(var_5.maxhealth / 10, 0.5, 5, "none", 1, self._id_0117, "dot_generic_zm");
          var_5 thread flare_zombie_burn(2.5);
          var_5.on_fire = 1;
        }
      }
    }

    wait 0.2;
  }
}

flare_zombie_burn(var_0) {
  self endon("death");
  wait(var_0);
  self.on_fire = 0;
}

flare_handle_cleanup(var_0) {
  self waittill("death");
  _func_149(common_scripts\utility::_id_44F5("signal_flare_zombie"), var_0._id_3F83, "TAG_ORIGIN");

  if(isDefined(var_0._id_3F71))
    var_0._id_3F71 delete();

  if(isDefined(var_0._id_3F83))
    var_0._id_3F83 delete();
}