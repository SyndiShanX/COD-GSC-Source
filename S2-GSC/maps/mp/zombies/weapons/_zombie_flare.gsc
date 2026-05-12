/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_flare.gsc
*****************************************************/

func_00D5(param_00) {
  common_scripts\utility::func_92C("signal_flare_zombie", "vfx/smoke/signal_flare_volumetric_runner");
  common_scripts\utility::func_92C("signal_flare_zombie_spec", "vfx/zombie/prototype_fx/dig/zmd_flare_volumetric_runner");
  level.zombietacticalweapon["signal_flare_zm"] = 1;
}

flare_get_weapon_name() {
  return "signal_flare_zm";
}

flare_player_give_flare() {
  var_00 = "signal_flare_zm";
  if(!common_scripts\utility::func_562E(self.seen_flare_hint)) {
    lib_0555::func_83DD("dlc3_tac_hint", self);
    self.seen_flare_hint = 1;
  }

  thread flare_player_throw_monitor();
  self.var_60A0 = 3;
  self method_831E(var_00);
  lib_0586::func_78C(var_00);
  self method_82FA(var_00, 3);
}

flare_player_throw_monitor() {
  self notify("starting_flare_watch");
  self endon("disconnect");
  self endon("starting_flare_watch");
  for(;;) {
    var_00 = flare_player_get_thrown_flare();
    flare_player_throw(var_00);
    wait 0.05;
  }
}

flare_player_get_thrown_flare() {
  self endon("disconnect");
  self endon("starting_flare_watch");
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(issubstr(var_01, "signal_flare_")) {
      var_00.var_1D0 = var_01;
      return var_00;
    }

    wait 0.05;
  }
}

flare_player_throw(param_00) {
  self endon("disconnect");
  self endon("starting_flare_watch");
  if(isDefined(param_00)) {
    param_00 endon("death");
    if(lib_0547::func_577E(self)) {
      param_00 delete();
      return;
    }

    param_00 thread flare_handle_effects(self, param_00.var_1D0);
  }
}

flare_handle_effects(param_00, param_01) {
  param_00 endon("disconnect");
  self endon("make_dud");
  self endon("death");
  self waittill("missile_stuck");
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(level.zmb_on_signal_flare_stuck)) {
    level thread[[level.zmb_on_signal_flare_stuck]](self);
  }

  var_02 = spawnStruct();
  var_02.landing_point = self.var_116;
  var_02.var_117 = self.var_117;
  var_02.var_3D33 = 1750;
  var_02.burn_duration = 1750;
  var_02.var_3D37 = 16384;
  var_02.var_3F83 = common_scripts\utility::func_8FFC();
  var_02.var_3F83 method_8449(self);
  var_02.var_3F83 method_805B();
  playFXOnTag(common_scripts\utility::func_44F5("signal_flare_zombie"), var_02.var_3F83, "TAG_ORIGIN");
  thread flare_handle_cleanup(var_02);
  wait(1);
  while(isDefined(self)) {
    var_03 = lib_0547::func_408F();
    foreach(var_05 in var_03) {
      var_06 = var_05.var_A4B;
      if(!lib_0547::func_5565(var_06, "zombie_generic") && !lib_0547::func_5565(var_06, "zombie_berserker") && !lib_0547::func_5565(var_06, "zombie_exploder")) {
        continue;
      }

      if(common_scripts\utility::func_562E(var_05.on_fire)) {
        continue;
      }

      if(distancesquared(var_05.var_116, var_02.landing_point) < var_02.var_3D37 / 2) {
        if(bullettracepassed(var_05.var_116, var_02.landing_point, 0, var_05, self)) {
          var_05 setonfire(var_05.var_FB / 10, 0.5, 5, "none", 1, self.var_117, "dot_generic_zm");
          var_05 thread flare_zombie_burn(2.5);
          var_05.on_fire = 1;
        }
      }
    }

    wait(0.2);
  }
}

flare_zombie_burn(param_00) {
  self endon("death");
  wait(param_00);
  self.on_fire = 0;
}

flare_handle_cleanup(param_00) {
  self waittill("death");
  killfxontag(common_scripts\utility::func_44F5("signal_flare_zombie"), param_00.var_3F83, "TAG_ORIGIN");
  if(isDefined(param_00.var_3F71)) {
    param_00.var_3F71 delete();
  }

  if(isDefined(param_00.var_3F83)) {
    param_00.var_3F83 delete();
  }
}