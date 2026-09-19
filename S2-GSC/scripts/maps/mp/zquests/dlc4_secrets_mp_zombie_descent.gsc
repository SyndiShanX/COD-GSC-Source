/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zquests\dlc4_secrets_mp_zombie_descent.gsc
**********************************************************************/

init_dlc4_secrets_mp_zombie_descent() {
  level.callbackplayerdamagesecondaryhandling = maps\mp\zquests\zmb_secret_challenges_util::report_player_damaged;
  _id_0547::register_postenemykilledfunc(::run_secret_challenges_kill_tracking);
  _id_0565::zombiegearchallengeregister("african_set", [::african_set_0, ::african_set_1, ::african_set_2, ::african_set_3, ::african_set_4], "african_set_kill");
  _id_0565::zombiegearchallengeregister("outlaw_set", [::outlaw_set_0, ::outlaw_set_1, ::outlaw_set_2, ::outlaw_set_3, ::outlaw_set_4], "outlaw_set_kill");
  _id_0565::zombiegearchallengeregister("arabic_set", [::arabic_set_0, ::arabic_set_1, ::arabic_set_2, ::arabic_set_3, ::arabic_set_4], "arabic_set_kill");
}

african_set_0() {
  var_0 = self;
  var_1 = "african_set_0";
  level endon(var_1);
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("quest_deathraven", "quest_deathraven_activate_rush"));
  level thread maps\mp\zquests\zmb_secret_challenges_util::register_on_player_dmg_func(maps\mp\zquests\zmb_secret_challenges_util::kill_hidden_challenge, var_1, maps\mp\zquests\zmb_secret_challenges_util::agent_is_zombie);
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("quest_deathraven", "quest_deathraven_pickup_weap"));

  if(self istouching(_getent("zone_gallery_deathravent_event", "targetname")))
    return 1;
  else
    return 0;
}

african_set_1() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0.cekillstealsscythe = 0;

  while(var_0.cekillstealsscythe < 12)
    waitframe();

  return 1;
}

african_set_2() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    self waittill("death_raven_energy_full", var_1);

    if(!isDefined(var_1) || common_scripts\utility::_id_562E(var_1)) {
      break;
    }
  }

  return 1;
}

african_set_3() {
  var_0 = self;
  var_0 endon("disconnect");
  level endon("another_player_joined1");
  level childthread maps\mp\zquests\zmb_secret_challenges_util::fail_on_another_player_joined(self, "another_player_joined", 1);
  common_scripts\utility::_id_3C9F("flag_boss_complete");
  return level._id_A980 <= 25 && level.players.size == 1;
}

african_set_4() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = ["zombie_king_uber_sun", "zombie_king_uber_flame"];

  while(isDefined(var_1) && var_1.size > 0) {
    var_0 waittill("dr_shield_activate", var_2);
    var_3 = common_scripts\utility::_id_0F7E(var_1, var_2);

    if(isDefined(var_2) && isDefined(var_3))
      var_1 = common_scripts\utility::_id_0F93(var_1, var_2);
  }

  return 1;
}

outlaw_set_0() {
  var_0 = self;
  var_0 waittill("outlaw_0_complete");
  return 1;
}

outlaw_set_1() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = "zone_crash";
  var_2 = "zone_alter";
  var_3 = 105;

  for(;;) {
    var_0 wait_for_player_in_zone(var_1);

    if(var_0 wait_for_player_in_zone(var_2, var_3)) {
      break;
    }
  }

  return 1;
}

wait_for_player_in_zone(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");
  var_3 = gettime();

  for(;;) {
    if(isDefined(var_1) && (gettime() - var_3) / 1000 > var_1)
      return 0;

    var_4 = var_2 _id_055A::_id_462D();

    if(_id_0547::_id_5565(var_4, var_0))
      return 1;

    waitframe();
  }
}

outlaw_set_2() {
  common_scripts\utility::_id_3C9F("moon_constellation_1_complete");
  var_0 = gettime() * 0.001;

  while(gettime() * 0.001 - var_0 < 300 && !common_scripts\utility::_id_3C77("moon_constellation_3_complete"))
    wait 1;

  if(common_scripts\utility::_id_3C77("moon_constellation_3_complete") && _id_0547::_id_5565(level.ravenweaponmanager["spike"]._id_0117, self))
    return 1;
  else
    return 0;
}

outlaw_set_3() {
  var_0 = self;
  var_0 waittill("dark_passenger_survived");
  return 1;
}

outlaw_set_4() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0.craftedweapons = 0;

  while(var_0.craftedweapons < 4)
    waitframe();

  return 1;
}

arabic_set_0() {
  var_0 = self;
  var_0 endon("disconnect");

  while(!isDefined(level._id_A980) || level._id_A980 < 15)
    waitframe();

  return !_id_0557::_id_783E("quest_firstdoor", "quest_firstdoor_bloodpool");
}

arabic_set_1() {
  if(!isDefined(level.zombie_slam_dunks))
    level.zombie_slam_dunks = 0;

  while(level.zombie_slam_dunks < 5)
    waitframe();

  return 1;
}

arabic_set_2() {
  level waittill("wustlinground_trip");
  return 1;
}

arabic_set_3() {
  var_0 = self;
  var_0.boodshielddamagesustained = 0;

  while(var_0.boodshielddamagesustained < 10000)
    waitframe();

  return 1;
}

arabic_set_4() {
  var_0 = self;
  var_0 waittill("blood_is_power");
  return 1;
}

run_secret_challenges_kill_tracking(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  if(issubstr(var_4, "scythe") && var_4 != "zom_dlc4_scythe_zm" && common_scripts\utility::_id_562E(self.beingeatenbyce))
    var_1.cekillstealsscythe++;

  if(issubstr(var_4, "scythe") && !_id_0547::_id_5565(self._id_0A4B, "zombie_dlc4"))
    var_1.only_charged_scythe_with_corpse_eaters = 0;

  if(common_scripts\utility::_id_562E(self.throwingzombie)) {
    var_9 = common_scripts\utility::_id_46B5("zmb_bloodraven_code_display", "targetname");

    if(_distance2d(self.origin, var_9.origin) < 260)
      level.zombie_slam_dunks++;
  }
}