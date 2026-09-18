/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1405.gsc
*********************************************/

func_5162() {
  common_scripts\utility::func_92C("jack_detonate", "vfx/explosion/zmb_jack_in_the_box_explosion");
  common_scripts\utility::func_92C("jack_fuse", "vfx/explosion/zmb_jack_in_the_box_fuse");
  lib_054D::register_grenadier_immune_zombie_equipment("jack_in_box_decoy_zm");
  lib_054D::register_persistent_tactical_zombie_equipment("jack_in_box_decoy_zm");
}

func_4766() {
  if(common_scripts\utility::func_562E(self.var_4B72)) {
    return;
  }

  lib_0555::func_83DD("jitb", self);
  self.var_4B72 = 1;
  thread func_73F3();
  self setoffhandsecondaryclass("jack_in_box_decoy_zm");
  lib_0586::func_78C("jack_in_box_decoy_zm");
  self setweaponammoclip("jack_in_box_decoy_zm", 3);
}

func_73F3() {
  self notify("starting_jack_watch");
  self endon("disconnect");
  self endon("starting_jack_watch");
  for(;;) {
    var_00 = func_4383();
    func_737D(var_00);
    wait 0.05;
  }
}

func_4383() {
  self endon("disconnect");
  self endon("starting_jack_watch");
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(isDefined(var_01) && var_01 == "jack_in_box_decoy_zm") {
      var_00.var_1D0 = var_01;
      return var_00;
    }

    wait 0.05;
  }
}

func_737D(param_00, param_01, param_02) {
  self endon("disconnect");
  self endon("starting_jack_watch");
  if(isDefined(param_00)) {
    param_00 endon("death");
    if(lib_0547::func_577E(self)) {
      param_00 delete();
      return;
    }

    param_00 hide();
    var_03 = spawn("script_model", param_00.origin);
    var_03 setModel("vm_zom_jack_in_the_box");
    var_03 linkTo(param_00, "tag_weapon", (0, 0, 0), (0, 90, 0));
    var_03 scriptmodelplayanim("va_jackinbox_box_close_idle");
    var_03 notsolid();
    var_03.origin = param_00.origin;
    var_03 thread func_2E63(param_00, self, param_01, param_02);
  }
}

func_2E63(param_00, param_01, param_02, param_03) {
  var_04 = maps / mp / gametypes / zombies::func_1E59(lib_0547::func_A51("zombie_generic"), 15);
  var_05 = 0;
  var_06 = 0.1;
  var_07 = 1;
  var_08 = self.origin + (0, 0, 32);
  param_00 common_scripts\utility::waittill_notify_or_timeout("missile_stuck", 15);
  lib_0378::func_8D74("aud_jack_in_box_land");
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(level.jack_in_box_secret_handler) && self[[level.jack_in_box_secret_handler]](param_00)) {
    self delete();
    return;
  }

  thread func_11C8();
  if(isDefined(param_00)) {
    param_00 delete();
  }

  self.targetname = "jokerGrenade";
  if(isDefined(param_03)) {
    self thread[[param_03]]("jack_exploded");
  }

  if(isDefined(param_02)) {
    wait(param_02);
  } else {
    wait(7);
  }

  self scriptmodelclearanim();
  playFXOnTag(common_scripts\utility::func_44F5("jack_fuse"), self, "wick_02");
  lib_0378::func_8D74("aud_jack_open");
  self scriptmodelplayanim("va_jackinbox_box_open");
  wait(1);
  playFX(common_scripts\utility::func_44F5("jack_detonate"), self.origin);
  lib_0378::func_8D74("aud_jack_in_box_explode");
  foreach(var_0A in maps / mp / agents / _agent_utility::func_43FD("all")) {
    if(isDefined(var_0A) && distance(var_0A.origin, self.origin) < 128) {
      var_0A dodamage(var_04, self.origin, param_01, self, "MOD_GRENADE", "jack_in_box_decoy_zm");
      if(isPlayer(param_01) && isalive(param_01) && !lib_0547::func_577E(param_01)) {
        param_01 maps / mp / gametypes / zombies::func_4798(50);
      }
    }
  }

  var_0C = self.origin + (0, 0, 96);
  self notify("jack_exploded");
  level notify("jack_exploded", self.origin);
  if(isDefined(self)) {
    self delete();
  }

  wait 0.05;
  if(isDefined(param_01 lib_0586::func_78A("blunderbuss_pap_zm"))) {
    param_01 maps / mp / zombies / weapons / _zombie_funderbuss::fire_funderbuss_grenades(var_0C, (80, 0, 0));
  }
}

func_11C8() {
  self endon("jack_exploded");
  if(level.players.size > 0) {
    self.var_4883 = getclosestpointonnavmesh(self.origin, level.players[0]);
  } else {
    self.var_4883 = self.origin;
  }

  level notify("jack_in_box_live");
  var_00 = 0;
  if(isDefined(level.var_AC80) && isDefined(level.var_AC80.var_ACB3) && level.var_AC80.var_ACB3.size > 0) {
    var_00 = lib_055A::func_578A(self.var_4883, 1);
  }

  if(!var_00) {
    return;
  }

  for(;;) {
    foreach(var_02 in lib_0547::func_408F()) {
      if(common_scripts\utility::func_562E(var_02.ignoredistractiondrones)) {
        continue;
      }

      if(var_02.var_A4B == "zombie_boss_village") {
        continue;
      }

      if(var_02.var_A4B == "zombie_bob") {
        continue;
      }

      if(isDefined(var_02.var_3045) && var_02.var_3045 == self) {
        continue;
      }

      if(isDefined(var_02.var_3044) && var_02.var_3044 >= 5) {
        if(distance(var_02.origin, self.origin) > 128) {
          var_02.var_3045 = self;
          var_02.var_3044 = 0;
          var_02.var_3043 = undefined;
          continue;
        }
      }

      if(!isDefined(var_02.var_3043) || distancesquared(var_02.var_3043.var_4883, var_02.origin) > distancesquared(self.var_4883, var_02.origin)) {
        var_03 = var_02 method_857B(var_02.origin, self.var_4883);
        if(var_03.size > 0) {
          var_02.var_3043 = self;
          var_02.var_3044 = 0;
          var_02.var_3045 = undefined;
        }
      }
    }

    wait(0.1);
  }
}

func_4769() {
  while(!isDefined(level.players)) {
    wait(0.1);
  }

  level.players[randomint(level.players.size)] thread func_4766();
  wait(0.5);
}

func_59DF(param_00) {
  while(isDefined(param_00)) {
    wait(0.01);
    if(isDefined(param_00) && isDefined(self)) {
      self.origin = param_00.origin;
      self.angles = (0, 0, 0);
    }
  }
}