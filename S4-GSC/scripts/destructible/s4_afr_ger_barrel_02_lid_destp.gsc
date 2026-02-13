/*******************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\destructible\s4_afr_ger_barrel_02_lid_destp.gsc
*******************************************************************/

init_exploding_barrels(var_0) {
  if(getdvarint("#x3a8fb0620196c6263") == 1) {
    return;
  }
  if(!isDefined(level.red_barrels_initialized)) {
    level.red_barrels_initialized = 1;
    level thread barrel_init_thread(var_0);
  }
}

barrel_init_thread(var_0) {
  init_barrel_fx();
  waitframe();
  level.red_barrels = getEntArray("scriptable_s4_afr_ger_barrel_02_lid_destp", "classname");

  for(var_1 = 0; !isDefined(level.red_barrels[0]); var_1++) {
    if(var_1 > 15) {
      return;
    }
    wait 1;
    level.red_barrels = getEntArray("scriptable_s4_afr_ger_barrel_02_lid_destp", "classname");
  }

  if(!scripts\common\utility::issp() && isDefined(level.dynamicmapelementsdisabled) && level.dynamicmapelementsdisabled) {
    foreach(var_3 in level.red_barrels) {
      var_3.origin = var_3.origin + (0, 0, -4000);
    }
  } else {
    foreach(var_3 in level.red_barrels) {
      var_3.health = 1000;
      var_3.active_fxs = [];
      var_3 thread barrel_impact_watcher();
      var_3 thread listen_for_exploded_state();
    }

    scripts\engine\utility::_id_5C1B("scriptable_s4_afr_ger_barrel_02_lid_destp_initialized");
  }
}

listen_for_exploded_state() {
  self waittillmatch("scriptableNotification", "oil_barrel_exploded");
  self notify("oil_barrel_exploded");
  var_0 = spawn("trigger_radius_fire", self.origin, 0, 40, 40);
  var_0._id_0392 = 1;
  thread barrel_trigger_fire(var_0);
  var_0 scripts\engine\utility::_id_46A5(10.0, ::delete);

  if(isDefined(self.burningbarrelindicator)) {
    self.burningbarrelindicator delete();
  }

  foreach(var_2 in self.active_fxs) {
    var_2 delete();
  }
}

barrel_trigger_fire(var_0) {
  var_0 endon("death");

  if(isDefined(var_0._id_F5AC)) {
    var_0 endon(var_0._id_F5AC);
  }

  var_1 = 1;
  var_2 = 5;
  var_3 = 0;

  if(!isDefined(var_0._id_CCFD) && !isDefined(var_0._id_CCFB)) {
    var_0._id_CCFD = 0.05;
    var_0._id_CCFB = 0.05;
  }

  if(var_0._id_CCFD == var_0._id_CCFB) {
    var_0._id_0393 = var_0._id_CCFD;
  }

  if(isDefined(var_0._id_0392)) {
    var_1 = var_0._id_0392;
  }

  for(;;) {
    var_0 waittill("trigger", var_4);
    var_5 = var_0.origin;

    if(isPlayer(var_4)) {
      var_3 = var_1;

      if(var_0.classname == "trigger_radius_fire") {
        if(isDefined(var_0._id_03A0)) {
          if(distance2dsquared(var_4.origin, var_0.origin) <= _func_0219(var_0._id_03A0)) {
            if(isDefined(var_0._id_CDEB) && _func_02B7(var_0._id_CDEB)) {
              var_2 = var_0._id_CDEB;
            }

            var_3 = var_3 * var_2;
          }
        }
      } else if(isDefined(var_0.target)) {
        var_6 = scripts\engine\utility::getstruct(var_0.target, "targetname");
        var_5 = var_6.origin;

        if(isDefined(var_6._id_03A0)) {
          if(distance2dsquared(var_4.origin, var_6.origin) <= _func_0219(var_6._id_03A0)) {
            if(isDefined(var_0._id_CDEB) && _func_02B7(var_0._id_CDEB)) {
              var_2 = var_0._id_CDEB;
            }

            var_3 = var_3 * var_2;
          }
        }
      }
    }

    if(istrue(var_4._id_014C)) {
      continue;
    }
    var_4 dodamage(var_3, var_5, self, self, "MOD_FIRE", undefined);

    if(var_3 < 6) {
      var_4 playrumbleonentity("damage_light");
    } else {
      var_4 playrumbleonentity("damage_heavy");
    }

    var_0 scripts\engine\utility::_id_0393();
  }
}

init_barrel_fx() {
  level._effect["oil_stream"] = loadfx("vfx/iw8_mp/level/torez/vfx_torez_oil_stream.vfx");
  level._effect["oil_spark"] = loadfx("vfx/iw8/weap/_impact/incendiary/vfx_incendiary_limbs.vfx");
  level._effect["flame_spurt0"] = loadfx("vfx/z/destruct/dest_barrel_flames.vfx");
}

barrel_impact_watcher() {
  self endon("death");
  self endon("oil_barrel_exploded");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET") {
      if(isDefined(var_1.classname) && var_1.classname != "player") {
        continue;
      }
      if(isDefined(level.player)) {
        var_10 = level.player;
      } else {
        var_10 = var_1;
      }

      if(!isDefined(var_1)) {
        return;
      }
      var_11 = var_10.angles;
      var_12 = anglesToForward(var_11);
      var_13 = var_10.origin + (0, 0, 50);
      var_14 = scripts\engine\trace::ray_trace(var_13, var_3 + var_2 * 3000, undefined, undefined, undefined, undefined, 1);
      var_15 = var_2;
      var_2 = var_14["normal"] * -1;

      if(var_2 == (0, 0, 0)) {
        var_2 = var_15;
      }

      if(self _meth_8575("part_0", 0) == "id_very_damaged_state") {
        if(scripts\common\utility::issp()) {
          if(!isDefined(self.burningbarrelindicator)) {
            self.burningbarrelindicator = scripts\engine\utility::_id_A5DA("magicgrenade", "barrel_grenade", self.origin + (0, 0, 10), self.origin, 9999, 0);
            self.burningbarrelindicator._id_0481 = "offhand_barrel_grenade";
            self.burningbarrelindicator makeunusable();
          }
        }

        if(self.active_fxs.size <= 4) {
          var_16 = spawnfx(scripts\engine\utility::getfx("flame_spurt0"), var_3, var_2 * -1);
          triggerfx(var_16);
          self.active_fxs = scripts\engine\utility::array_add(self.active_fxs, var_16);
        }
      } else if(self.active_fxs.size <= 4) {
        var_17 = spawnfx(scripts\engine\utility::getfx("oil_stream"), var_3, var_2 * -1);
        triggerfx(var_17);
        self.active_fxs = scripts\engine\utility::array_add(self.active_fxs, var_17);
        var_18 = spawnfx(scripts\engine\utility::getfx("oil_spark"), var_3, var_2 * -1);
        triggerfx(var_18);
        self.active_fxs = scripts\engine\utility::array_add(self.active_fxs, var_18);
      }

      continue;
    }

    if(var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH") {
      if(scripts\common\utility::issp()) {
        if(var_0 > 250) {
          self setscriptablepartstate("part_0", "id_exploded_state");
        } else if(var_0 > 50) {
          if(self _meth_8575("part_0", 0) != "id_exploded_state") {
            self setscriptablepartstate("part_0", "id_very_damaged_state");
          }
        }

        continue;
      }

      self setscriptablepartstate("part_0", "id_exploded_state");
    }
  }
}