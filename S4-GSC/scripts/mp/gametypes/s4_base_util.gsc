/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\s4_base_util.gsc
*************************************************/

_id_110EF() {
  var_0 = self;
  var_0 thread _id_CA27(level._id_1A7A.origin, level._id_1A7A.angles, var_0 getEye(), var_0 getplayerangles(), 1);
  thread _id_07F8::matchbeginmusicfromcountdown(var_0);
}

_id_CA27(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_5 notify("RunCameraSlam");
  var_5 endon("RunCameraSlam");
  var_5 endon("disconnect");

  if(!isDefined(var_5._id_2FF7)) {
    var_6 = spawn("script_model", var_0);
    var_6 setModel("tag_origin");
    var_5._id_2FF7 = var_6;
  }

  var_5._id_2FF7.angles = var_1;
  var_5 cameralinkto(var_5._id_2FF7, "tag_origin", 1, 1);
  var_5._id_2FF7 moveto(var_2, 1);
  var_5._id_2FF7 rotateto(var_3, 1);

  if(istrue(var_4)) {
    wait 1;
    var_5 _meth_8060();
    var_5._id_2FF7 delete();
  }
}

_id_46F1() {
  if(!isDefined(level._id_146A)) {
    return;
  }
  level._id_146A = scripts\engine\utility::_id_1BD1(level._id_146A);

  foreach(var_1 in level._id_146A) {
    var_1 delete();
  }
}

_id_F3DC() {
  var_0 = self;
  var_0 thread _id_F3DD();
}

_id_F3DD() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 notify("track_grenade_usage_internal");
  var_0 endon("track_grenade_usage_internal");

  for(;;) {
    var_0 waittill("grenade_fire", var_1, var_2);
    var_0 thread scripts\mp\gametypes\arena_evo_tourney::arena_evo_projectile_tracking(var_1);

    if(!isDefined(level._id_146A)) {
      level._id_146A = [];
    }

    level._id_146A[level._id_146A.size] = var_1;
    level._id_146A = scripts\engine\utility::_id_1BD1(level._id_146A);
  }
}

get_player_origin_check(var_0) {
  if(scripts\mp\utility\player::isreallyalive(var_0)) {
    return var_0.origin;
  }

  if(var_0 scripts\mp\utility\player::_id_88C7()) {
    return undefined;
  }

  if(isDefined(self._id_E293) && isDefined(self._id_E293._id_E332)) {
    return self._id_E293._id_E332;
  }

  return var_0.origin;
}

set_xp_omnvars() {
  var_0 = self;

  if(isDefined(var_0._id_B16D)) {
    var_0 setclientomnvar("ui_arena_evo_stat_placement_bonus_xp", var_0._id_B16D);
  }

  var_1 = var_0.pers["summary"]["xp"];
  var_0 setclientomnvar("ui_arena_evo_stat_total_xp", var_1);
}

initbaselights() {
  var_0 = _func_03C0("scriptable_hardpoint_chevron_lighting_alps", "classname");

  foreach(var_2 in var_0) {
    var_3 = var_2._id_039B;

    if(!isDefined(var_3)) {
      continue;
    }
    if(!isDefined(level._id_A8E8[var_3])) {
      continue;
    }
    if(!isDefined(level._id_A8E8[var_3].baselights)) {
      level._id_A8E8[var_3].baselights = [];
    }

    level._id_A8E8[var_3].baselights[level._id_A8E8[var_3].baselights.size] = var_2;
    var_2 setlightscriptablepartstate("chevron_0", "idle");
  }
}

updatebaselightstate(var_0) {
  self notify("updateBaseLightState");
  self endon("updateBaseLightState");

  if(!isDefined(level._id_A8E8) || level._id_A8E8.size == 0) {
    return;
  }
  var_1 = self.baselights;

  foreach(var_3 in var_1) {
    var_3 setlightscriptablepartstate("chevron_0", var_0);
  }
}

setlightscriptablepartstate(var_0, var_1) {
  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  self setscriptablepartstate(var_0, var_1);
}

_id_B61B(var_0, var_1) {
  var_2 = self;
  var_3 = var_2 getweaponslistprimaries();
  var_4 = [];
  var_5 = [];

  foreach(var_7 in var_3) {
    if(!isDefined(var_4[var_7.basename])) {
      var_4[var_7.basename] = var_7;
      var_5[var_7.basename] = getweaponattachments(var_7);
    }
  }

  var_9 = 0;

  foreach(var_12, var_7 in var_4) {
    var_11 = getcompleteweaponname(var_7 _meth_8625());
    var_11 = scripts\mp\utility\script::_id_EA63(stripvariantid(var_11), "_mp");

    if(isDefined(var_2.pickedupweapons) && isDefined(var_2.mostrecentweaponpurchased)) {
      if(scripts\engine\utility::array_contains(var_2.pickedupweapons, var_11) && var_2.mostrecentweaponpurchased != var_11) {
        continue;
      }
    }

    if(var_9 == 0) {
      var_2.pers["classCache"][self.class]._id_9685 = var_5[var_7.basename];
      var_2.pers["classCache"][self.class]._id_9684 = generateattachmentids(var_5[var_7.basename], var_7._id_0071);
      var_2 scripts\mp\gametypes\s4_base_loot::_id_D160(var_11, "arena_evo_loadout_override_primary");
    } else {
      var_2.pers["classCache"][self.class]._id_9694 = var_5[var_7.basename];
      var_2.pers["classCache"][self.class]._id_9693 = generateattachmentids(var_5[var_7.basename], var_7._id_0071);
      var_2 scripts\mp\gametypes\s4_base_loot::_id_D160(var_11, "arena_evo_loadout_override_secondary");
    }

    var_9++;
  }

  var_2 scripts\mp\gametypes\s4_base_loot::_id_AD3D(var_2.pers["classCache"][self.class], undefined, var_0, var_1);
}

s4_base_set_equipment_active(var_0) {
  var_1 = self;

  if(isbot(var_1)) {
    return;
  }
  if(var_0 && scripts\mp\equipment::_id_85BF("primary") && scripts\mp\equipment::_id_85BF("secondary")) {
    return;
  }
  if(!var_0 && !scripts\mp\equipment::_id_85BF("primary") && !scripts\mp\equipment::_id_85BF("secondary")) {
    return;
  }
  var_1 scripts\mp\equipment::_id_153B("primary", var_0);
  var_1 scripts\mp\equipment::_id_153B("secondary", var_0);
}

base_getafkchecktimeseconds() {
  return getdvarint("#x3a8135425ff115d1e", 90);
}

is_player_active() {
  if(isDefined(self.lastbaseactivitytime) && self.lastbaseactivitytime + base_getafkchecktimeseconds() * 1000 >= gettime()) {
    return 1;
  }

  return 0;
}

stripvariantid(var_0) {
  var_1 = strtok(var_0, "_");

  if(!_func_010D(var_1[var_1.size - 1], "v")) {
    return var_0;
  }

  var_2 = var_1[0];

  for(var_3 = 1; var_3 < var_1.size - 1; var_3++) {
    var_2 = var_2 + "_" + var_1[var_3];
  }

  return var_2;
}

generateattachmentids(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2[var_3] = var_1[var_0[var_3]];
  }

  return var_2;
}

s4_base_set_player_allows(var_0) {
  var_1 = self;

  switch (var_0) {
    case "arena_evo_player_state_playing":
      var_1._id_B928 = 0;
      var_1._id_0480 = 0;
      var_1 _meth_86C5();
      var_1 allowfire(1);
      var_1 s4_baset_set_weapon_level_omnvars();
      var_1 s4_base_allow(1);
      var_1 thread s4_base_set_equipment_active(1);
      var_1 scripts\mp\battlechatter_mp::_id_523A(var_1);
      break;
  }

  var_1._id_41B1 = var_0;
}

is_in_combat_state() {
  var_0 = self;
  var_1 = s4_base_get_player_allow_state();
  return scripts\engine\utility::is_equal(var_1, "arena_evo_player_state_playing");
}

is_in_weapon_upgrade_state() {
  var_0 = self;

  if(var_0 _meth_8270() != "mount_none") {
    return 0;
  }

  var_1 = s4_base_get_player_allow_state();

  switch (var_1) {
    case "arena_evo_player_state_intermission":
      return 0;
    default:
      return 1;
  }
}

s4_base_get_player_allow_state() {
  var_0 = self;

  if(!isDefined(var_0._id_41B1)) {
    return "";
  }

  return var_0._id_41B1;
}

s4_base_allow(var_0) {
  if(var_0 && scripts\common\utility::_id_85CE() && scripts\common\utility::_id_8616()) {
    return;
  }
  if(!var_0 && !scripts\common\utility::_id_85CE() && !scripts\common\utility::_id_8616()) {
    return;
  }
  self allowmovement(var_0);
  scripts\common\utility::_id_153E(var_0);
  scripts\common\utility::_id_1587(var_0);
  scripts\common\utility::_id_154E(var_0);
  scripts\common\utility::_id_1554(var_0);
  scripts\common\utility::_id_1581(var_0);
  scripts\common\utility::_id_154F(var_0);

  if(!istrue(level._id_4ACD)) {
    scripts\common\utility::_id_1558(var_0);
    scripts\common\utility::_id_1557(var_0);
  }
}

s4_baset_set_weapon_level_omnvars(var_0) {
  var_1 = self;

  if(isDefined(var_0)) {
    var_2 = scripts\mp\utility\script::_id_EA63(var_0, "_mp");

    if(iss4baselauncherweapon(var_0)) {
      var_1 setclientomnvar("ui_arena_weapon_rank_" + var_2, 0);
      return;
    }

    if(scripts\mp\gametypes\s4_base_loot::s4_base_has_used_weapon(var_0)) {
      var_1 setclientomnvar("ui_arena_weapon_rank_" + var_2, scripts\mp\gametypes\s4_base_weapon_util::s4_base_get_weapon_level(var_0));
    } else {
      var_1 setclientomnvar("ui_arena_weapon_rank_" + var_2, -1);
    }

    return;
  }

  foreach(var_6, var_4 in var_1._id_1AA4) {
    var_5 = scripts\mp\utility\script::_id_EA63(var_6, "_mp");

    if(!scripts\mp\gametypes\s4_base_loot::s4_base_has_used_weapon(var_6)) {
      var_4 = -1;
    }

    if(iss4baselauncherweapon(var_6)) {
      continue;
    }
    var_1 setclientomnvar("ui_arena_weapon_rank_" + var_5, var_4);
  }
}

s4_base_get_spawn_weapon(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    if(scripts\engine\utility::is_equal(var_1.basename, self._id_4422.basename)) {
      var_0 = var_1;
    }
  }

  if(isDefined(var_2)) {
    if(scripts\engine\utility::is_equal(var_2.basename, self._id_4422.basename)) {
      var_0 = var_2;
    }
  }

  return var_0;
}

disablescriptableforotherteam(var_0) {
  var_1 = self;
  var_1 wait_for_usable_state();
  var_2 = scripts\mp\utility\game::_id_6BE2(var_0)[0];

  foreach(var_4 in level._id_EF6A[var_2]["players"]) {
    var_1 _meth_86A8(var_4);
  }
}

wait_for_usable_state() {
  var_0 = self;

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }
    var_1 = var_0 _meth_8575(var_0.type, 1);

    if(scripts\engine\utility::is_equal(var_1, "visible") || scripts\engine\utility::is_equal(var_1, "delayAuto")) {
      break;
    }

    waitframe();
  }

  waitframe();
}

basedlogrecordplayerpurchaseevent(var_0, var_1, var_2) {
  var_3 = ["item_name", var_1, "item_cost", var_2];
  var_0 _meth_870F("dlog_event_mp_base_player_purchases", var_3);
}

iss4baselauncherweapon(var_0) {
  var_0 = scripts\mp\utility\script::_id_EA63(var_0, "_mp");

  switch (var_0) {
    case "s4_la_palpha":
    case "s4_la_palpha42":
    case "s4_la_mkilo1":
    case "s4_la_m1bravo":
      return 1;
    default:
      return 0;
  }
}

displaysummonmotorcycleerror() {
  scripts\common\base_warnings::base_warnings_show("summon_motorcycle_error");
  wait 2;
  scripts\common\base_warnings::base_warning_hide();
}

ismotorcyclesummonable() {
  if(!isDefined(self.vehicle) && isalive(self) && !istrue(self.innocapturearea) && !self _meth_86B8() && !self isonladder() && !isDefined(self._id_84E2) && !self _meth_846A() && self _meth_876E("ui_tac_ops_map_open") == 0) {
    var_0 = 9000000;

    if(isDefined(self._id_22A2) && isDefined(self._id_22A2.type) && issubstr(self._id_22A2.type, "vehicle")) {
      var_0 = 1000000;
    }

    if(isDefined(self.motoid) && distancesquared(self.origin, self.motoid.origin) < var_0) {
      return 0;
    } else {
      return 1;
    }
  }

  return 0;
}

updatemotorcycleomnvar() {
  var_0 = self _meth_876E("ui_motorcycle_summonable");
  var_1 = ismotorcyclesummonable();

  if(!isDefined(var_0) || var_0 != var_1) {
    self setclientomnvar("ui_motorcycle_summonable", var_1);
    self.motosummon = var_1;
  }
}

motorcycle_monitor_summonability() {
  if(isbot(self)) {
    return;
  }
  self notify("monitor_moto_summon");
  self endon("monitor_moto_summon");
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(isDefined(self) && !_func_0458(self)) {
    updatemotorcycleomnvar();
    wait 1;
  }
}

motorcycle_monitor_summon() {
  if(isbot(self)) {
    return;
  }
  self notify("motorcycle_monitor_start");
  level endon("game_ended");
  self endon("motorcycle_monitor_start");
  self endon("death_or_disconnect");
  self notifyonplayercommand("spawn_moto", "+actionslot 2");
  self notifyonplayercommand("spawn_moto", "call_motorcycle");

  for(;;) {
    self waittill("spawn_moto");
    self setclientomnvar("ui_base_spawn_moto", gettime());

    if(isDefined(level._id_1031A) && level._id_1031A.size >= getdvarint("#x37b4d162f54abd8cb", 24)) {
      scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/TOO_MANY_VEHICLES");
      continue;
    }

    if(ismotorcyclesummonable()) {
      var_0 = getdvarint("#x3aaee70a03b469d94", 700);
      var_1 = spawnStruct();
      var_2 = (self.angles[0], self.angles[1], 0.0);
      var_1.angles = self.angles * (0, 1, 0);
      var_3 = undefined;

      while(var_0 <= var_0 + 200) {
        var_1.origin = self.origin + anglesToForward(var_2) * 100 + (0, 0, var_0);
        var_4 = var_1.origin + (1, 1, 1);
        var_5 = 150;
        var_6 = [];
        var_7 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 0, 1, 0, 0, 0);
        var_8 = scripts\engine\trace::_id_E40C(var_1.origin, var_4, var_5, var_6, var_7);

        if(isDefined(var_8[0])) {
          var_0 = var_0 + 20;
          continue;
        } else {
          var_3 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle("motorcycle", var_1, undefined);
          thread scripts\mp\gametypes\arms_race_audio::play_motorcycle_summon(var_3);
          break;
        }
      }

      if(isDefined(var_3)) {
        playFX(scripts\engine\utility::getfx("vfx_ar_mc_spawn_flash"), var_1.origin);

        if(!isDefined(level._id_1031A)) {
          level._id_1031A = [];
        }

        level._id_1031A[level._id_1031A.size] = var_3;
        self.motoid = var_3;

        if(scripts\cp_mp\vehicles\vehicle_spawn::_id_10271() && var_3._id_A924.size == 0) {
          var_3 thread scripts\cp_mp\vehicles\vehicle_spawn::_id_10291();
        }

        var_3._id_ADAE = self.team;
      } else
        displaysummonmotorcycleerror();

      updatemotorcycleomnvar();
      wait 10;
    }
  }
}

basemonitorweaponfire() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("begin_firing");
    thread basemonitorweaponfiretime();
  }
}

basemonitorweaponfiretime() {
  self endon("disconnect");
  self._id_90CA = gettime();
  self notify("monitorWeaponFireTime");
  self endon("monitorWeaponFireTime");
  scripts\engine\utility::_id_108C5("end_firing", "death");
  self._id_90C9 = gettime();
}

base_dialogonplayersinbase(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_5)) {
    wait(var_5);
  }

  foreach(var_9 in level.players) {
    if(!isalive(var_9) || isDefined(var_9.vehicle)) {
      continue;
    }
    if(isDefined(var_1) && var_9.team != var_1) {
      continue;
    }
    if(var_9 istouching(var_0.trigger) && var_9.sessionstate == "playing") {
      var_9 _id_0A8D::_id_9137(var_2, var_3, var_4, undefined, var_6, var_7);
    }
  }
}