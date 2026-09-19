/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_special_weapons.gsc
************************************************/

init() {
  level._id_A85D = [];
  level._id_A85D["flamethrower"] = &"MP_FLAMETHROWER_PICKUP";
  level._id_A85D["molotovs"] = &"MP_MOLOTOV_PICKUP";
  level._id_A85D["mortar_strike"] = &"MP_MORTAR_STRIKE_PICKUP";
  level._id_A85D["tripwire"] = &"RAIDS_TRIPWIRE_COLLECT";
  level._id_A85D["raid_superweapon"] = &"RAIDS_SUPERWEAPON_PICKUP";
  level._id_A85D["raid_tesla_moon"] = &"RAIDS_SUPERWEAPON_PICKUP";
  level._id_A85D["raid_ss_serum_a"] = &"RAIDS_SERUM_PICKUP";
  level._id_A85D["raid_ss_serum_b"] = &"RAIDS_SERUM_PICKUP";
  level._id_A85D["raid_ss_serum_c"] = &"RAIDS_SERUM_PICKUP";
  level._id_A85D["incendiary_can"] = &"MP_MOLOTOV_PICKUP";
  thread _id_5356();
  thread onplayerconnect();
}

onplayerconnect() {
  level waittill("connected", var_0);
  var_0 loadweapons(["killstreak_air_strike_mp"]);
}

_id_5356() {
  level._id_90DB = [];
  var_0 = common_scripts\utility::_id_46B7("special_weapon", "targetname");
  level.all_crates = [];
  level.all_empty_crates = [];

  foreach(var_2 in var_0) {
    var_2._id_272F = _getent(var_2.target, "targetname");
    var_2.crate_empty = _getent(var_2._id_272F.target, "targetname");
    var_2.crate_empty hide();
    var_2._id_9D65 = _getent(var_2.crate_empty.target, "targetname");
    var_2._id_5A6E = var_2._id_9D65.setlookatent;
    var_2._id_00C5 = tablelookup("mp/killstreaktable.csv", 1, var_2._id_5A6E, 2);
    var_2._id_5A68 = tablelookup("mp/killstreaktable.csv", 1, var_2._id_5A6E, 19);

    if(issubstr(var_2._id_5A6E, "serum")) {
      level.raidserumstreaks = ["raid_ss_serum_a", "raid_ss_serum_b", "raid_ss_serum_c"];
      var_2._id_5A6E = common_scripts\utility::random(level.raidserumstreaks);
      var_2._id_5A68 = "scorestreak_raid_ss_serum_neutral_hud";
    } else if(issubstr(var_2._id_5A6E, "superweapon")) {
      level.raidsuperweaponstreaks = ["raid_superweapon", "raid_tesla_moon"];
      var_2._id_5A6E = common_scripts\utility::random(level.raidsuperweaponstreaks);
      var_2._id_5A68 = "scorestreak_raid_superweapon_neutral_hud";
    }

    var_2._id_9D65 sethintstring(level._id_A85D[var_2._id_5A6E]);
    var_2._id_A582 = getEntArray(var_2._id_9D65.target, "targetname");
    var_2.oncooldown = 0;
    var_2._id_6210 = undefined;
    _id_0502::_id_1D39(var_2);
    var_2 _id_0502::_id_1D3A(var_2._id_272F.origin, !var_2.oncooldown);
    var_2 _id_0502::_id_1D3B(!var_2.oncooldown);

    if(var_2._id_5A6E == "tripwire") {
      var_2.refillcount = var_2.setmovespeedscale;
      var_2._id_7DB6 = 0;
      var_2 thread trackvisualmodelsshow();
    } else {
      var_2.refillcount = 0;
      var_2._id_7DB6 = var_2.setmovespeedscale;
    }

    level.all_crates[level.all_crates.size] = var_2._id_272F;
    level.all_empty_crates[level.all_empty_crates.size] = var_2.crate_empty;
    var_2._id_272F hudoutlineenable(2, 1);
    var_2 thread _id_A943();
    var_2 thread weaponplayerconnect();
    var_2 thread weaponsetupfinishonconnect();
  }

  thread outro_logic();
}

weaponsetupfinishonconnect() {
  level endon("runBomberObjective");
  level waittill("connected", var_0);
  self._id_4F6B = _id_283A(self, self._id_5A68, 0, 1);

  if(isDefined(self.setlookatent) && self.setlookatent == "start_disabled")
    thread disablespecialweaponpickup();

  if(isDefined(self._id_9D65._id_0165) && (self._id_9D65._id_0165 == "attackers" || self._id_9D65._id_0165 == "defenders")) {
    var_1 = game[self._id_9D65._id_0165];
    self._id_9D65 setteamfortrigger(var_1);
  }
}

weaponplayerconnect() {
  level endon("runBomberObjective");
  level endon("game_ended");
  var_0 = self;

  for(;;) {
    level waittill("connected", var_1);
    var_1 thread onplayerspawned(var_0);
  }
}

onplayerspawned(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  level endon("runBomberObjective");

  for(;;) {
    self waittill("spawned_player");
    var_1 = var_0._id_9D65 getpickuptriggerteam();
    var_2 = common_scripts\utility::_id_0F79(var_1, self);

    if(isDefined(var_0._id_9D65._id_0165)) {
      var_3 = 0;
      var_1 = getpickuptriggerteam();

      if(isDefined(var_1) && !common_scripts\utility::_id_0F79(var_1, self) || _id_0502::_id_573E(var_3, self) == 0 || isDefined(self._id_A9F6) && (self._id_A9F6 == "war_tripwire_mp" || self._id_A9F6 == "killstreak_molotov_cocktail_mp" || self._id_A9F6 == "killstreak_molotov_cocktail_grenadier_mp")) {
        if(var_0.oncooldown == 0) {
          if(isDefined(var_0.refillcount) && var_0.refillcount > 0)
            weapsethighlight(var_0, var_2);

          if(var_2 && var_0._id_6989 != -1) {
            weapsethighlight(var_0, var_2);
            _objective_playermask_showto(var_0._id_6989, self getentitynumber());
          } else if(var_0._id_6989 != -1) {
            weapsethighlight(var_0, var_2);
            _objective_playermask_showto(var_0._id_6989, self getentitynumber());
            _objective_playermask_hidefrom(var_0._id_6989, self getentitynumber());
          }
        }
      }
    }
  }
}

weapsethighlight(var_0, var_1) {
  if(var_1) {
    var_0._id_272F hudoutlineenableforclient(self, 2, 1);
    var_0.crate_empty _meth_8006(self);
    var_0._id_272F showtoplayer(self);
  } else {
    var_0._id_272F hudoutlinedisableforclient(self);
    var_0._id_272F _meth_8006(self);
    var_0.crate_empty showtoplayer(self);
  }
}

_id_A943() {
  level endon("game_ended");
  level endon("runBomberObjective");
  self._id_9D65 waittill("trigger", var_0);
  var_1 = maps\mp\killstreaks\_raid_ss_serum_util::pickupisserum(self._id_5A6E);

  if(var_1) {
    while(!maps\mp\killstreaks\_raid_ss_serum_util::handleserumpickup(var_0))
      self._id_9D65 waittill("trigger", var_0);
  }

  var_2 = 0;
  var_3 = getpickuptriggerteam();

  if(isDefined(var_3) && !common_scripts\utility::_id_0F79(var_3, var_0) || _id_0502::_id_573E(var_2, var_0) == 0 || isDefined(var_0._id_A9F6) && (var_0._id_A9F6 == "war_tripwire_mp" || var_0._id_A9F6 == "killstreak_molotov_cocktail_mp" || var_0._id_A9F6 == "killstreak_molotov_cocktail_grenadier_mp" || var_0._id_A9F6 == "flamethrower_mp" || var_0._id_A9F6 == "flamethrower_grenadier_mp" || var_0._id_A9F6 == "flamethrower_german_mp" || var_0._id_A9F6 == "flamethrower_german_grenadier_mp")) {
    thread _id_A943();
    return;
  }

  self.refillcount--;
  self._id_9D65 makeunusable();
  var_0 _id_051E::_id_478D(self._id_5A6E, 0, 0, var_0, var_2);
  var_0 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(self._id_5A6E, 500, undefined, undefined);

  if(var_1)
    thread maps\mp\killstreaks\_raid_ss_serum_util::handledisableserumonpickup(self._id_5A6E, var_0);

  self._id_4F6B.alpha = 0;

  foreach(var_5 in self._id_A582)
  var_5 hide();

  self._id_272F hudoutlinedisable();
  thread _id_7DB5();
  thread playerholdingkillstreakwatcher(var_0);
}

disablespecialweaponpickup() {
  self._id_9D65 makeunusable();
  self._id_4F6B.alpha = 0;

  foreach(var_1 in self._id_A582)
  var_1 hide();

  self._id_272F hudoutlinedisable();
}

enablespecialweaponpickup() {
  self._id_9D65 makeusable();
  self._id_4F6B.alpha = 1;

  foreach(var_1 in self._id_A582)
  var_1 show();

  self._id_272F hudoutlineenable(2, 1);
}

trackvisualmodelsshow() {
  level endon("game_ended");
  level endon("runBomberObjective");
  var_0 = self._id_A582;
  var_1 = self.refillcount;

  while(self.refillcount > 0) {
    foreach(var_3 in var_0) {
      if(isDefined(var_3.setmovespeedscale)) {
        var_4 = var_3.setmovespeedscale;

        if(var_4 > self.refillcount / var_1 * var_0.size)
          var_3 hide();
        else
          var_3 show();
      }
    }

    waitframe();
  }

  _id_0502::_id_1D3B(0);
}

getpickuptriggerteam() {
  if(isDefined(self._id_0165)) {
    var_0 = _id_0502::_id_4627(game[self._id_0165]);
    return var_0;
  }

  return [];
}

_id_7DB5() {
  level endon("game_ended");
  level endon("runBomberObjective");

  if(self._id_5A6E == "tripwire" && self.refillcount == 0) {
    return;
  }
  self.oncooldown = 1;
  _id_0502::_id_1D3B(!self.oncooldown);

  if(issubstr(self._id_5A6E, "serum"))
    self._id_5A6E = common_scripts\utility::random(level.raidserumstreaks);
  else if(issubstr(self._id_5A68, "superweapon"))
    self._id_5A6E = common_scripts\utility::random(level.raidsuperweaponstreaks);

  if(getdvarint("mp_raid_dlc4_test_serums", 0) == 1)
    wait 5;
  else
    wait(self._id_7DB6);

  self.oncooldown = 0;
  _id_0502::_id_1D3B(!self.oncooldown);
  self._id_9D65 makeusable();

  foreach(var_1 in self._id_A582)
  var_1 show();

  self._id_272F hudoutlineenable(2, 1);
  self._id_4F6B.alpha = 0.4;
  waitframe();
  thread _id_A943();
}

playerholdingkillstreakwatcher(var_0) {
  level endon("game_ended");
  level endon("runBomberObjective");
  var_1 = 0;
  var_0 _id_0502::replacehintstringclient(&"MP_MOLOTOV_PICKUP", &"RAIDS_TRIPWIRE_BLANK");
  var_0 _id_0502::replacehintstringclient(&"RAIDS_TRIPWIRE_COLLECT", &"RAIDS_TRIPWIRE_BLANK");

  while(_id_0502::_id_573E(var_1, var_0) == 0 || isDefined(var_0._id_A9F6) && (var_0._id_A9F6 == "killstreak_molotov_cocktail_mp" || var_0._id_A9F6 == "killstreak_molotov_cocktail_grenadier_mp")) {
    common_scripts\utility::_id_0F71(level.all_crates, ::_meth_8006, var_0);
    common_scripts\utility::_id_0F71(level.all_empty_crates, ::showtoplayer, var_0);
    waitframe();
  }

  var_0 _id_0502::replacehintstringclient(&"MP_MOLOTOV_PICKUP", undefined);
  var_0 _id_0502::replacehintstringclient(&"RAIDS_TRIPWIRE_COLLECT", undefined);
  common_scripts\utility::_id_0F71(level.all_empty_crates, ::_meth_8006, var_0);
  common_scripts\utility::_id_0F71(level.all_crates, ::showtoplayer, var_0);
}

_id_283A(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || !isDefined(var_0.origin)) {
    return;
  }
  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = undefined;

  if(isDefined(var_0._id_0165) && (var_0._id_0165 == "attackers" || var_0._id_0165 == "defenders")) {
    var_5 = game[var_0._id_0165];
    var_4 = _newteamhudelem(var_5);
  } else
    var_4 = newhudelem();

  var_4 setshader(var_1, 0, 0, 7);
  var_4.alpha = 0.4;
  var_4 setwaypoint(1, 0, 0, 0, 0, 0, 0, var_3);
  var_4.x = var_0.origin[0];
  var_4.y = var_0.origin[1];
  var_4._id_01D9 = var_0.origin[2] + 10 - var_2;
  var_4._id_35B2 = "icon";
  var_4._id_6E74 = level._id_A012;
  level._id_90DB = common_scripts\utility::_id_0F6F(level._id_90DB, var_4);
  level._id_90DB = common_scripts\utility::_id_0F97(level._id_90DB);
  return var_4;
}

remove_all_special_weaps() {
  var_0 = common_scripts\utility::_id_46B7("special_weapon", "targetname");

  foreach(var_2 in var_0) {
    foreach(var_4 in var_2._id_A582)
    var_4 delete();

    var_2.crate_empty delete();
    var_2._id_272F delete();
  }

  if(isDefined(level._id_90DB)) {
    foreach(var_8 in level._id_90DB)
    var_8 destroy();
  }
}

outro_logic() {
  level waittill("game_end_vignette");
  remove_all_special_weaps();
}