/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\26851.gsc
**************************************/

_id_68B1(var_0, var_1) {
  common_scripts\utility::flag_init("player_can_die_on_zodiac");
  common_scripts\utility::flag_init("player_shot_on_zodiac");
  common_scripts\utility::flag_set("player_can_die_on_zodiac");

  if(!isDefined(var_0)) {
    level._id_68B2 = "viewhands_player_udt";
  } else {
    level._id_68B2 = var_0;
  }
  if(!isDefined(var_1)) {
    level._id_68B3 = "vehicle_zodiac_viewmodel";
  } else {
    level._id_68B3 = var_1;
  }
  level._id_68B4 = "viewmodel_miniUZI";
  level._id_68B5 = "uzi";
  precachemodel(level._id_68B2);
  precachemodel(level._id_68B3);
  precachemodel(level._id_68B4);
  precacheitem(level._id_68B5);
  level._id_68B6 = loadfx("muzzleflashes/uzi_flash_view");
  level._id_68B7 = loadfx("shellejects/pistol_view");
  level._id_68B8 = [];
  level._id_68B8["weap_glock_fire_snowmobile"] = "weap_miniuzi_fire_plr";
  _id_6870();
  maps\_utility::add_hint_string("zodiac_attack", &"SCRIPT_PLATFORM_SNOWMOBILE_ATTACK", ::_id_68DD);
  maps\_utility::add_hint_string("zodiac_drive", &"SCRIPT_PLATFORM_SNOWMOBILE_DRIVE", ::_id_68DE);
  maps\_utility::add_hint_string("zodiac_reverse", &"SCRIPT_PLATFORM_SNOWMOBILE_REVERSE", ::_id_68E2);
}

_id_68B9(var_0, var_1) {
  var_2 = self;
  var_2 makeusable();
  self waittill("vehicle_mount", var_3);

  if(!getdvarint("scr_zodiac_test") && maps\_utility::_id_1451()) {
    maps\_utility::delaythread(20, maps\_utility::_id_1F61, "zodiac_attack");
    maps\_utility::delaythread(3, maps\_utility::_id_1F61, "zodiac_drive");
  }

  var_3.vehicle = var_2;
  var_2._id_68BA = var_2.model;
  var_2._id_68BB = 32;
  var_2._id_1032 = "zodiac_player";
  var_2 maps\_utility::_id_2629();
  var_2 makeunusable();
  var_2 dontcastshadows();
  var_3 thread _id_68DF(var_2);

  if(!isDefined(var_1) || !isDefined(var_0)) {
    var_3 thread _id_68BE(var_2, var_0, var_1);
  }
  var_3 thread _id_68C3(var_2);
  var_3 thread _id_68C6(var_2, var_1);
  var_3 thread _id_68C7(var_2, "pullout_anim");
  var_3 thread _id_68C7(var_2, "fire_anim");
  var_3 thread _id_68C7(var_2, "reload_anim");
  var_3 thread _id_68C7(var_2, "putaway_anim");
  var_3 _id_68C8(var_2, var_1);
  var_2 common_scripts\utility::waittill_either("vehicle_dismount", "death");
  var_3.vehicle = undefined;
}

_id_68BC() {
  return getaiarray("bad_guys");
}

_id_68BD() {
  return getaiarray("bad_guys");
}

_id_68BE(var_0, var_1, var_2) {
  var_0 endon("vehicle_dismount");
  var_0 endon("death");
  var_0 endon("stop_targetting");
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];

  if(!isDefined(var_2)) {
    var_3["player"] = 490000;
    var_4["player"] = 1690000;
    var_5["player"] = 1690000;
    var_6["player"] = ::_id_68BC;
    var_7["player"] = spawnStruct();
    var_7["player"]._id_15D9 = -20;
    var_7["player"]._id_15DA = 20;
    var_7["player"]._id_68BF = 0;
    var_8 = "player";
  } else {
    var_8 = "price";
  }
  if(!isDefined(var_1)) {
    var_3["price"] = 1000000;
    var_4["price"] = 14440000;
    var_5["price"] = 18490000;
    var_6["price"] = ::_id_68BD;
    var_7["price"]["right"] = spawnStruct();
    var_7["price"]["right"]._id_15D9 = -80;
    var_7["price"]["right"]._id_15DA = 5;
    var_7["price"]["right"]._id_68BF = -25;
    var_7["price"]["right"]._id_68C0 = -55;
    var_7["price"]["right"]._id_68C1 = 5;
    var_7["price"]["left"] = spawnStruct();
    var_7["price"]["left"]._id_15D9 = -5;
    var_7["price"]["left"]._id_15DA = 80;
    var_7["price"]["left"]._id_68BF = 25;
    var_7["price"]["left"]._id_68C0 = -5;
    var_7["price"]["left"]._id_68C1 = 55;
  }

  for(;;) {
    var_9 = var_3[var_8];
    var_10 = [[var_6[var_8]]]();
    var_11 = 180.1;
    var_12 = undefined;
    var_13 = self;

    if(var_8 == "price") {
      var_13 = level._id_4877;
    }
    var_14 = var_13.origin;
    var_15 = var_7["player"];

    if(var_8 == "price") {
      if(!isDefined(var_13.a._id_6887)) {
        var_8 = "player";
        wait 0.05;
        continue;
      }

      var_15 = var_7["price"][var_13.a._id_6887];
    }

    foreach(var_17 in var_10) {
      var_18 = var_17.origin;

      if(isDefined(var_17._id_0EF1)) {
        if(var_17._id_0EF1 == level._id_68C2) {
          var_9 = var_3[var_8];
        }
        var_9 = var_4[var_8];
      } else {
        var_9 = var_5[var_8];
      }
      var_19 = distancesquared(var_18, var_14);

      if(var_19 > var_9) {
        continue;
      }
      var_20 = vectortoangles(var_18 - var_14);
      var_21 = angleclamp180(var_20[0]);

      if(abs(var_21) > 15) {
        continue;
      }
      var_22 = angleclamp180(var_20[1] - var_13.angles[1]);

      if(var_22 < var_15._id_15D9 || var_22 > var_15._id_15DA) {
        continue;
      }
      if(var_8 == "price") {
        if(var_19 < 62500) {
          var_12 = var_17;
          break;
        }

        if(isDefined(var_13._id_6882) && var_17 == var_13._id_6882 && var_22 >= var_15._id_68C0 && var_22 <= var_15._id_68C1) {
          var_12 = var_17;
          break;
        }
      }

      var_22 = abs(angleclamp180(var_22 - var_15._id_68BF));

      if(var_22 < var_11) {
        var_11 = var_22;
        var_12 = var_17;
      }
    }

    var_13._id_6882 = var_12;
    wait 0.1;

    if(isDefined(var_2)) {
      var_8 = "price";
      continue;
    }

    if(isDefined(var_1)) {
      var_8 = "player";
      continue;
    }

    if(var_8 == "price") {
      var_8 = "player";
      continue;
    }

    var_8 = "price";
  }
}

_id_68C3(var_0) {
  var_0 endon("vehicle_dismount");
  var_0 endon("death");
  level endon("avalanche_begins");
  var_0 _id_68C4();
  var_1 = var_0 vehicle_getspeed();
  var_1 = var_1 * 17.6;
  var_2 = (0, var_1, 64);
  thread _id_68C5(var_0, var_2);
  maps\_utility::_id_281A();
}

_id_68C4() {
  level endon("player_crashes");
  self waittill("veh_collision");
}

_id_68C5(var_0, var_1) {
  var_0 waittill("vehicle_dismount");
  maps\_utility::_id_1EC5(var_1);

  if(common_scripts\utility::flag("player_can_die_on_zodiac")) {
    maps\_utility::_id_1887();
  }
  wait 1.0;
}

_id_68C6(var_0, var_1) {
  var_0 endon("vehicle_dismount");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("third_person");
    _id_68CC(var_0);
    var_0 waittill("first_person");
    _id_68C8(var_0, var_1);
  }
}

_id_68C7(var_0, var_1) {
  var_0 endon("vehicle_dismount");
  var_0 endon("death");

  for(;;) {
    var_0 waittill(var_1, var_2);
    var_3 = getsubstr(var_2, 0, 3);

    if(var_3 == "ps_") {
      var_4 = getsubstr(var_2, 3);

      if(isDefined(level._id_68B8[var_4])) {
        var_4 = level._id_68B8[var_4];
      }
      var_0 playSound(var_4);
      continue;
    }
  }
}

_id_68C8(var_0, var_1) {
  if(isDefined(var_0._id_68C9)) {
    return;
  }
  var_0 setModel(level._id_68B3);
  var_0 attach(level._id_68B2, "tag_player");
  var_0 clearanim(var_0 maps\_utility::_id_1281("root"), 0);
  var_0._id_68C9 = 1;
  thread _id_68CD(var_0, var_1);
}

_id_68CA(var_0) {
  if(!isDefined(var_0._id_68C9)) {
    return;
  }
  if(isDefined(var_0._id_68CB)) {
    var_0 detach(level._id_68B4, "tag_weapon_left");
    var_0._id_68CB = undefined;
  }

  var_0 detach(level._id_68B2, "tag_player");
  var_0 clearanim(var_0 maps\_utility::_id_1281("root"), 0);
  var_0._id_68C9 = undefined;
  var_0 notify("kill_anims");
}

_id_68CC(var_0) {
  if(!isDefined(var_0._id_68C9)) {
    return;
  }
  _id_68CA(var_0);
  var_0 setModel(var_0._id_68BA);
}

_id_68CD(var_0, var_1) {
  var_0 endon("vehicle_dismount");
  var_0 endon("death");
  var_0 endon("kill_anims");
  var_0 endon("cleanup");
  childthread _id_68DB(var_0, var_1);
}

_id_68CE(var_0) {
  var_1 = common_scripts\utility::getStructArray("dont_assist_destructible_destruction_here", "targetname");

  foreach(var_3 in var_1) {
    if(distance(var_3.origin, var_0.origin) < var_3.radius) {
      return;
    }
  }

  self notify("new_shootable_stuff_assist");
  self endon("new_shootable_stuff_assist");
  var_0 waittill("damage", var_5, var_6, var_7, var_8, var_9);

  for(var_10 = 0; var_10 < 10; var_10++) {
    wait 0.05;
    var_0 notify("damage", var_5, level.player, var_7, var_8, var_9);
  }
}

_id_68CF(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isalive(self._id_6882)) {
    var_3._id_2816 = self._id_6882;
    var_3.origin = self._id_6882 getshootatpos() + common_scripts\utility::randomvectorrange(-10, 10) + (0, 0, -1 * randomfloat(40));
    return var_3;
  }

  var_4 = common_scripts\utility::array_combine(getEntArray("destructible_toy", "targetname"), getEntArray("explodable_barrel", "targetname"));

  foreach(var_6 in var_4) {
    if(distance(level.player.origin, var_6.origin) > 2300) {
      continue;
    }
    if(!maps\_utility::_id_26AB(level.player.origin, level.player.angles, var_6.origin, 0.965925)) {
      continue;
    }
    if(!level.player sightconetrace(var_6 getshootatpos(), var_6)) {
      continue;
    }
    var_3._id_2816 = var_6;
    var_3.origin = var_6.origin;
    thread _id_68CE(var_6);
    return var_3;
  }

  var_8 = _id_68D1();

  foreach(var_6 in var_8) {
    if(distance(level.player.origin, var_6.origin) > 1300) {
      continue;
    }
    if(!maps\_utility::_id_26AB(level.player.origin, level.player.angles, var_6.origin, cos(15))) {
      continue;
    }
    if(!level.player sightconetrace(var_6.origin + (0, 0, 16), var_6)) {
      continue;
    }
    var_3._id_2816 = var_6;
    var_3.origin = var_6.origin;
    var_3._id_68D0 = 1;
    return var_3;
  }

  if(isDefined(var_2)) {
    return var_3;
  }
  var_11 = var_0 gettagangles("tag_flash");
  var_12 = anglesToForward(var_11);
  var_3.origin = var_1 + var_12 * 1500;
  return var_3;
}

_id_68D1() {
  var_0 = getEntArray("script_vehicle_zodiac_physics", "classname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3 == level._id_68D2) {
      continue;
    }
    if(isDefined(level._id_68C2) && var_3 == level._id_68C2) {
      continue;
    }
    if(isDefined(level._id_68D3) && var_3 == level._id_68D3) {
      continue;
    }
    if(isspawner(var_3)) {
      continue;
    }
    if(var_3._id_0A39.size > 1) {
      continue;
    }
    if(!var_3._id_0A39.size) {
      continue;
    }
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "bobbing_boat") {
      continue;
    }
    var_3 thread _id_68D4();
    var_1[var_1.size] = var_3._id_0A39[0];
  }

  return var_1;
}

_id_68D4() {
  self notify("wipeout_when_not_in_fov");
  self endon("wipeout_when_not_in_fov");
  self endon("death");

  while(maps\_utility::_id_26AD(self.origin, 0.5)) {
    wait 0.05;
  }
  self._id_439F = 1;
}

_id_68D5(var_0, var_1, var_2) {
  var_3 = bulletTrace(var_1, var_2, 0, self);

  if(!isDefined(var_3["entity"])) {
    return 0;
  }
  if(var_3["entity"] != var_0) {
    return 0;
  }
  return 1;
}

_id_68D6(var_0) {
  var_1 = var_0 gettagorigin("tag_flash");
  var_2 = _id_68CF(var_0, var_1);

  if(common_scripts\utility::flag("player_in_sight_of_boarding")) {
    magicbullet(level._id_68B5, var_1, var_1 + (0, 0, 255), self);
  } else {
    magicbullet(level._id_68B5, var_1, var_2.origin, self);
  }
  playFXOnTag(level._id_68B6, var_0, "tag_flash");
  playFXOnTag(level._id_68B7, var_0, "tag_brass");
  level.player playrumbleonentity("smg_fire");

  if(!isDefined(var_2._id_2816)) {
    return;
  }
  if(!isai(var_2._id_2816)) {
    var_2._id_2816 notify("damage", 50, level.player, self.origin, var_2._id_2816.origin, "MOD_PISTOL_BULLET", "", "");
  }
  if(isDefined(var_2._id_68D0)) {
    _id_68D7(var_2._id_2816);
    return;
  }
}

_id_68D7(var_0) {
  var_0 notify("newanim");
  var_0 startragdoll();
  var_0._id_0EF1._id_439F = 1;
}

_id_68D8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon(var_2);
  var_0 setflaggedanimrestart(var_1, var_0 maps\_utility::_id_1281(var_3), 0.001, 0.08, 1.0);
  var_0 setflaggedanimrestart(var_1, var_0 maps\_utility::_id_1281(var_4), 0.001, 0.08, 1.0);
  var_0 setflaggedanimrestart(var_1, var_0 maps\_utility::_id_1281(var_5), 0.001, 0.08, 1.0);

  for(;;) {
    var_6 = var_0 vehicle_getsteering() * -1.0;

    if(var_6 >= 0.0) {
      var_7 = 0.001;
      var_8 = -0.999 * var_6 + 1.0;
      var_9 = 0.999 * var_6 + 0.001;
    } else {
      var_7 = -0.999 * var_6 + 0.001;
      var_8 = 0.999 * var_6 + 1.0;
      var_9 = 0.001;
    }

    var_0 setflaggedanim(var_1, var_0 maps\_utility::_id_1281(var_3), var_7, 0.08, 1.0);
    var_0 setflaggedanim(var_1, var_0 maps\_utility::_id_1281(var_4), var_8, 0.08, 1.0);
    var_0 setflaggedanim(var_1, var_0 maps\_utility::_id_1281(var_5), var_9, 0.08, 1.0);
    wait 0.05;
  }
}

_id_68D9(var_0) {
  var_0 setanimknoblimited(var_0 maps\_utility::_id_1281("gun_pullout_root"), 1.0, 0.0, 1.0);
  childthread _id_68D8(var_0, "pullout_anim", "pullout_done", "gun_pullout_L", "gun_pullout", "gun_pullout_R");
  var_0 waittillmatch("pullout_anim", "attach_gun");
  var_0 attach(level._id_68B4, "tag_weapon_left");
  var_0 hidepart("TAG_ACOG_2", level._id_68B4);
  var_0 hidepart("TAG_RAIL", level._id_68B4);
  var_0 hidepart("TAG_RED_DOT", level._id_68B4);
  var_0 hidepart("TAG_EOTECH", level._id_68B4);
  var_0 hidepart("TAG_SILENCER", level._id_68B4);
  var_0 hidepart("TAG_THERMAL_SCOPE", level._id_68B4);
  var_0 hidepart("TAG_RETICLE_RED_DOT", level._id_68B4);
  var_0 hidepart("TAG_EOTECH_RETICLE", level._id_68B4);
  var_0 hidepart("TAG_RETICLE_ACOG", level._id_68B4);
  var_0 hidepart("TAG_RETICLE_THERMAL_SCOPE", level._id_68B4);
  var_0._id_68CB = 1;
  var_0 waittillmatch("pullout_anim", "end");
  var_0 notify("pullout_done");
  var_0 setanim(var_0 maps\_utility::_id_1281("uzi"), 1.0, 0.0, 1.0);
  var_0 setanimknoblimited(var_0 maps\_utility::_id_1281("gun_idle"), 1.0, 0.0, 1.0);
  var_0._id_68DA = 1.0;

  for(;;) {
    if(var_0._id_68DA <= 0.0) {
      break;
    }

    var_1 = _id_68DC();

    if(var_1 && var_0._id_68BB > 0) {
      common_scripts\utility::flag_set("player_shot_on_zodiac");
      var_0 setflaggedanimknoblimitedrestart("fire_anim", var_0 maps\_utility::_id_1281("gun_fire"), 1.0, 0.0, 1.0);

      if(var_0._id_68BB == 1) {
        var_0 setanimknoblimitedrestart(var_0 maps\_utility::_id_1281("uzi_last_fire"), 1.0, 0.0, 1.0);
      } else {
        var_0 setanimknoblimitedrestart(var_0 maps\_utility::_id_1281("uzi_fire"), 1.0, 0.0, 1.0);
      }
      _id_68D6(var_0);
      wait 0.05;
      var_0._id_68BB = var_0._id_68BB - 1;
      var_0._id_68DA = 1.0;
    } else if(var_0._id_68BB <= 0) {
      var_0 setflaggedanimknoblimitedrestart("reload_anim", var_0 maps\_utility::_id_1281("gun_reload"), 1.0, 0.0, 1.0);
      var_0 setanimknoblimitedrestart(var_0 maps\_utility::_id_1281("uzi_reload"), 1.0, 0.0, 1.0);
      var_0 waittillmatch("reload_anim", "end");
      var_0._id_68BB = 32;
      var_0._id_68DA = 1.0;
    } else {
      var_0 setanimknoblimited(var_0 maps\_utility::_id_1281("gun_idle"), 1.0, 0.0, 1.0);
      var_0._id_68DA = var_0._id_68DA - 0.05;
    }

    wait 0.05;
  }

  var_0 setanimknoblimited(var_0 maps\_utility::_id_1281("gun_putaway_root"), 1.0, 0.0, 1.0);
  childthread _id_68D8(var_0, "putaway_anim", "putaway_done", "gun_putaway_L", "gun_putaway", "gun_putaway_R");
  var_0 waittillmatch("putaway_anim", "detach_gun");

  if(isDefined(var_0._id_68CB)) {
    var_0 detach(level._id_68B4, "tag_weapon_left");
    var_0._id_68CB = undefined;
  }

  var_0 waittillmatch("putaway_anim", "end");
  var_0 notify("putaway_done");
  var_0 notify("drive_shooting_done");
}

_id_68DB(var_0, var_1) {
  var_0 setanim(var_0 maps\_utility::_id_1281("drive_left_arm"), 1.0, 0.1, 1.0);
  var_0 setanim(var_0 maps\_utility::_id_1281("shoot_left_arm"), 0.0, 0.1, 1.0);

  if(isDefined(var_1) && var_1) {
    return;
  }
  for(;;) {
    var_2 = _id_68DC();

    if(var_2) {
      var_0 setanim(var_0 maps\_utility::_id_1281("drive_left_arm"), 0.001, 0.1, 1.0);
      var_0 setanim(var_0 maps\_utility::_id_1281("shoot_left_arm"), 1.0, 0.1, 1.0);
      childthread _id_68D9(var_0);
      var_0 waittill("drive_shooting_done");
    }

    var_0 setanim(var_0 maps\_utility::_id_1281("drive_left_arm"), 1.0, 0.1, 1.0);
    var_0 setanim(var_0 maps\_utility::_id_1281("shoot_left_arm"), 0.0, 0.1, 1.0);
    wait 0.05;
  }
}

_id_68DC() {
  if(!level.console) {
    return self attackButtonPressed();
  }
  return self vehicleattackButtonPressed();
}

#using_animtree("vehicles");

_id_6870() {
  level._id_1245["zodiac_player"] = #animtree;
  level._id_1F90["zodiac_player"] = level._id_68B2;
  level._id_0C59["zodiac_player"]["root"] = % root;
  level._id_0C59["zodiac_player"]["left_arm"] = % player_snowmobile_left_arm;
  level._id_0C59["zodiac_player"]["drive_left_arm"] = % player_snowmobile_drive_left_arm;
  level._id_0C59["zodiac_player"]["shoot_left_arm"] = % player_snowmobile_shoot_left_arm;
  level._id_0C59["zodiac_player"]["gun_fire"] = % player_snowmobile_gun_fire;
  level._id_0C59["zodiac_player"]["gun_idle"] = % player_snowmobile_gun_idle;
  level._id_0C59["zodiac_player"]["gun_pullout_root"] = % player_snowmobile_gun_pullout_root;
  level._id_0C59["zodiac_player"]["gun_pullout_L"] = % player_snowmobile_gun_pullout_l;
  level._id_0C59["zodiac_player"]["gun_pullout"] = % player_snowmobile_gun_pullout;
  level._id_0C59["zodiac_player"]["gun_pullout_R"] = % player_snowmobile_gun_pullout_r;
  level._id_0C59["zodiac_player"]["gun_putaway_root"] = % player_snowmobile_gun_putaway_root;
  level._id_0C59["zodiac_player"]["gun_putaway_L"] = % player_snowmobile_gun_putaway_l;
  level._id_0C59["zodiac_player"]["gun_putaway"] = % player_snowmobile_gun_putaway;
  level._id_0C59["zodiac_player"]["gun_putaway_R"] = % player_snowmobile_gun_putaway_r;
  level._id_0C59["zodiac_player"]["gun_reload"] = % player_snowmobile_gun_reload;
  level._id_0C59["zodiac_player"]["right_arm"] = % player_snowmobile_right_arm;
  level._id_0C59["zodiac_player"]["uzi"] = % snowmobile_glock;
  level._id_0C59["zodiac_player"]["uzi_fire"] = % snowmobile_glock_fire;
  level._id_0C59["zodiac_player"]["uzi_last_fire"] = % snowmobile_glock_last_fire;
  level._id_0C59["zodiac_player"]["uzi_reload"] = % snowmobile_glock_reload;
  level._id_0C59["zodiac_player"]["sleeve_pose"] = % player_sleeve_pose;
  level._id_0C59["zodiac_player"]["sleeve_flapping"] = % player_sleeve_flapping;
}

_id_68DD() {
  if(!isDefined(level.player.vehicle)) {
    return 1;
  }
  return common_scripts\utility::flag("player_shot_on_zodiac");
}

_id_68DE() {
  if(!isDefined(level.player.vehicle)) {
    return 1;
  }
  return level.player.vehicle.veh_speed > 10;
}

_id_68DF(var_0) {
  self endon("death");
  var_0 endon("vehicle_dismount");
  var_0 endon("death");
  level endon("no_more_reverse_hints");
  var_0 _id_68E1();
  var_0._id_68E0 = 0;

  for(;;) {
    if(abs(var_0.veh_speed) < 5) {
      var_0._id_68E0++;

      if(var_0._id_68E0 >= 3) {
        var_0 maps\_utility::_id_1F61("zodiac_reverse");
      }
    } else {
      var_0._id_68E0 = 0;
    }
    wait 1;
  }
}

_id_68E1() {
  for(;;) {
    if(self.veh_speed > 40) {
      return;
    }
    wait 1;
  }
}

_id_68E2() {
  if(!isDefined(self.vehicle)) {
    return 1;
  }
  return self.vehicle._id_68E0 < 3;
}