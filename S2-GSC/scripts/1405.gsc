/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1405.gsc
**************************************/

_id_5162() {
  common_scripts\utility::_id_092C("jack_detonate", "vfx/explosion/zmb_jack_in_the_box_explosion");
  common_scripts\utility::_id_092C("jack_fuse", "vfx/explosion/zmb_jack_in_the_box_fuse");
  _id_054D::register_grenadier_immune_zombie_equipment("jack_in_box_decoy_zm");
  _id_054D::register_persistent_tactical_zombie_equipment("jack_in_box_decoy_zm");
}

_id_4766() {
  if(common_scripts\utility::_id_562E(self._id_4B72)) {
    return;
  }
  _id_0555::issprinting("jitb", self);
  self._id_4B72 = 1;
  thread _id_73F3();
  self setoffhandsecondaryclass("jack_in_box_decoy_zm");
  _id_0586::_id_078C("jack_in_box_decoy_zm");
  self setweaponammoclip("jack_in_box_decoy_zm", 3);
}

_id_73F3() {
  self notify("starting_jack_watch");
  self endon("disconnect");
  self endon("starting_jack_watch");

  for(;;) {
    var_0 = _id_4383();
    _id_737D(var_0);
    waitframe();
  }
}

_id_4383() {
  self endon("disconnect");
  self endon("starting_jack_watch");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isDefined(var_1) && var_1 == "jack_in_box_decoy_zm") {
      var_0._id_01D0 = var_1;
      return var_0;
    }

    waitframe();
  }
}

_id_737D(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("starting_jack_watch");

  if(isDefined(var_0)) {
    var_0 endon("death");

    if(_id_0547::_id_577E(self)) {
      var_0 delete();
      return;
    }

    var_0 hide();
    var_3 = spawn("script_model", var_0.origin);
    var_3 setModel("vm_zom_jack_in_the_box");
    var_3 linkTo(var_0, "tag_weapon", (0, 0, 0), (0, 90, 0));
    var_3 scriptmodelplayanim("va_jackinbox_box_close_idle");
    var_3 notsolid();
    var_3.origin = var_0.origin;
    var_3 thread _id_2E63(var_0, self, var_1, var_2);
  }
}

_id_2E63(var_0, var_1, var_2, var_3) {
  var_4 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), 15);
  var_5 = 0.0;
  var_6 = 0.1;
  var_7 = 1;
  var_8 = self.origin + (0, 0, 32);
  var_0 common_scripts\utility::waittill_notify_or_timeout("missile_stuck", 15);
  _id_0378::_id_8D74("aud_jack_in_box_land");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level.jack_in_box_secret_handler) && self[[level.jack_in_box_secret_handler]](var_0)) {
    self delete();
    return;
  }

  thread _id_11C8();

  if(isDefined(var_0)) {
    var_0 delete();
  }

  self.targetname = "jokerGrenade";

  if(isDefined(var_3)) {
    self thread[[var_3]]("jack_exploded");
  }

  if(isDefined(var_2)) {
    wait(var_2);
  } else {
    wait 7;
  }

  self scriptmodelclearanim();
  _playFXOnTag(common_scripts\utility::_id_44F5("jack_fuse"), self, "wick_02");
  _id_0378::_id_8D74("aud_jack_open");
  self scriptmodelplayanim("va_jackinbox_box_open");
  wait 1;
  playFX(common_scripts\utility::_id_44F5("jack_detonate"), self.origin);
  _id_0378::_id_8D74("aud_jack_in_box_explode");

  foreach(var_10 in maps\mp\agents\_agent_utility::_id_43FD("all")) {
    if(isDefined(var_10) && distance(var_10.origin, self.origin) < 128) {
      var_10 dodamage(var_4, self.origin, var_1, self, "MOD_GRENADE", "jack_in_box_decoy_zm");

      if(isPlayer(var_1) && isalive(var_1) && !_id_0547::_id_577E(var_1)) {
        var_1 maps\mp\gametypes\zombies::_id_4798(50);
      }
    }
  }

  var_12 = self.origin + (0, 0, 96);
  self notify("jack_exploded");
  level notify("jack_exploded", self.origin);

  if(isDefined(self)) {
    self delete();
  }

  waitframe();

  if(isDefined(var_1 _id_0586::_id_078A("blunderbuss_pap_zm"))) {
    var_1 maps\mp\zombies\weapons\_zombie_funderbuss::fire_funderbuss_grenades(var_12, (80, 0, 0));
  }
}

_id_11C8() {
  self endon("jack_exploded");

  if(level.players.size > 0) {
    self._id_4883 = _func_2E1(self.origin, level.players[0]);
  } else {
    self._id_4883 = self.origin;
  }

  level notify("jack_in_box_live");
  var_0 = 0;

  if(isDefined(level._id_AC80) && isDefined(level._id_AC80._id_ACB3) && level._id_AC80._id_ACB3.size > 0) {
    var_0 = _id_055A::_id_578A(self._id_4883, 1);
  }

  if(!var_0) {
    return;
  }
  for(;;) {
    foreach(var_2 in _id_0547::_id_408F()) {
      if(common_scripts\utility::_id_562E(var_2.ignoredistractiondrones)) {
        continue;
      }
      if(var_2._id_0A4B == "zombie_boss_village") {
        continue;
      }
      if(var_2._id_0A4B == "zombie_bob") {
        continue;
      }
      if(isDefined(var_2._id_3045) && var_2._id_3045 == self) {
        continue;
      }
      if(isDefined(var_2._id_3044) && var_2._id_3044 >= 5) {
        if(distance(var_2.origin, self.origin) > 128) {
          var_2._id_3045 = self;
          var_2._id_3044 = 0;
          var_2._id_3043 = undefined;
          continue;
        }
      }

      if(!isDefined(var_2._id_3043) || distancesquared(var_2._id_3043._id_4883, var_2.origin) > distancesquared(self._id_4883, var_2.origin)) {
        var_3 = var_2 _meth_857B(var_2.origin, self._id_4883);

        if(var_3.size > 0) {
          var_2._id_3043 = self;
          var_2._id_3044 = 0;
          var_2._id_3045 = undefined;
        }
      }
    }

    wait 0.1;
  }
}

_id_4769() {
  while(!isDefined(level.players)) {
    wait 0.1;
  }

  level.players[randomint(level.players.size)] thread _id_4766();
  wait 0.5;
}

_id_59DF(var_0) {
  while(isDefined(var_0)) {
    wait 0.01;

    if(isDefined(var_0) && isDefined(self)) {
      self.origin = var_0.origin;
      self.angles = (0, 0, 0);
    }
  }
}