/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\drone\utility.gsc
***********************************************/

deploy_drone(var_0, var_1) {
  if(istrue(var_0.using_drone))
    return 0;

  var_0.using_drone = 1;
  var_0.disable_map_tablet = 1;
  var_0.pre_drone_weapon = var_0 getcurrentweapon();

  if(istrue(var_1.play_intro)) {
    var_0 giveweapon("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E");
    var_0 switchtoweapon("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E");
    var_0 notifyonplayercommand("_encstr_A72F1BB185E66CB2C6EB322B1CB1DB2FBEA159631CAC93F59127F6E656", "_encstr_A6E60A229B175A3B48A543AB");
    var_2 = var_0 scripts\engine\utility::_id_143BA(0.6, "_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_A72F1BB185E66CB2C6EB322B1CB1DB2FBEA159631CAC93F59127F6E656");

    if(!isDefined(var_2) || var_2 != "_encstr_995408F398012F656821") {
      var_0 takeweapon("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E");
      var_0 switchtoweapon(var_0.pre_drone_weapon);
      var_0.using_drone = undefined;
      return 0;
    }

    var_2 = var_0 scripts\engine\utility::_id_143B9(1.4, "_encstr_8CBE0BD1BED30936AB03C0B02B");

    if(!isDefined(var_2) || var_2 != "_encstr_995408F398012F656821") {
      var_0 takeweapon("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E");
      var_0 switchtoweapon(var_0.pre_drone_weapon);
      var_0.using_drone = undefined;
      return 0;
    }
  }

  if(!istrue(var_1.no_control)) {
    var_0 scripts\common\utility::allow_weapon_switch(0);
    return deploy_helper_drone_actual(var_0, var_1);
  } else {
    var_0 takeweapon("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E");
    var_0 switchtoweapon(var_0.pre_drone_weapon);
    var_0.using_drone = undefined;
    return 1;
  }
}

deploy_helper_drone_actual(var_0, var_1) {
  var_2 = var_0.origin + (0, 0, 150);

  if(!istrue(var_1.detonate_mines))
    var_2 = find_safe_spawn(var_0);

  var_3 = create_drone(var_0, var_2, var_1);

  if(isDefined(var_3)) {
    if(var_0 isjumping())
      var_0 setOrigin(scripts\engine\utility::drop_to_ground(var_0.origin));

    if(istrue(var_0.dont_move_from_drone)) {
      var_0 notify("_encstr_8AE40D9139DECD597DC6A5B9D69532");
      waitframe();
    }

    var_0 cameralinkTo(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_0 remotecontrolvehicle(var_3);
    var_0 notify("_encstr_86090DC9722588458FBAEAF0E31B06");
    var_0.drone = var_3;
    var_0 scripts\common\utility::allow_usability(0);

    if(istrue(var_1.send_down))
      var_3 thread send_drone_down(var_3, var_0, var_1);

    turn_on_drone_hud(var_0);

    if(!istrue(var_0.dont_move_from_drone)) {
      var_0 thread keep_player_on_ground();
      var_0 thread move_away_from_vehicles();
    }

    var_0.pre_drone_angles = var_0 getplayerangles();
    return 1;
  }

  return 0;
}

send_drone_down(var_0, var_1, var_2) {
  wait 0.05;
  var_3 = scripts\engine\utility::drop_to_ground(var_0.origin, -1500, -30000);
  var_3 = var_3 + (0, 0, 2500);
}

keep_player_on_ground() {
  while(istrue(self.using_drone)) {
    var_0 = scripts\engine\utility::drop_to_ground(self.origin);
    self setOrigin(var_0);
    wait 0.05;
  }
}

move_away_from_vehicles() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 600;
  var_1 = var_0 * var_0;
  var_2 = 0;
  var_3 = -3;
  var_4 = self.origin;

  while(istrue(self.using_drone)) {
    if(var_2 >= var_3 + 3) {
      var_5 = vehicle_getarray();

      foreach(var_7 in var_5) {
        if(distancesquared(self.origin, var_7.origin) < var_1) {
          var_8 = length2d(self.origin - var_4);

          if(var_8 > 500 && var_8 < 5000) {
            scripts\cp\utility::moveplayerperpendicularly(1200);
            var_3 = var_2;
          }
        }
      }
    }

    var_2 = var_2 + 2;
    wait 2;
  }
}

exit_drone(var_0, var_1) {
  if(isent(var_1))
    var_1 playSound("_encstr_B6011586E78A6778D463D8E807D7F1BB534B7E807842C9");

  if(!isent(var_1)) {
    return;
  }
  var_0 cameraunlink(var_1);
  var_0 remotecontrolvehicleoff();

  if(var_0 hasweapon("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E"))
    var_0 takeweapon("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E");

  var_0 scripts\common\utility::allow_weapon_switch(1);
  var_0.last_weapon = var_0.pre_drone_weapon;
  var_2 = var_0 scripts\cp\utility::getweapontoswitchbackto();
  var_0 switchtoweapon(var_2);
  var_0 takeweapon("_encstr_9A2011B5CDAF272BADB7D1ACF56B0BC1BEB1C1");
  var_0 scripts\common\utility::allow_usability(1);
  turn_off_drone_hud(var_0);
  var_0 setplayerangles(var_0.pre_drone_angles);
  var_0.using_drone = undefined;
  var_0.disable_map_tablet = undefined;
  var_0 notify("_encstr_88D00E3B7B9B3CA095EFB8551AAA05C9");
  var_0 notify("_encstr_B80910D79858A80105B4FE12F101C5F76343");
}

create_drone(var_0, var_1, var_2) {
  var_3 = spawnhelicopter(var_0, var_1, var_0 getplayerangles(), var_2.vehicle_info, var_2.model);

  if(!isDefined(var_3)) {
    return;
  }
  var_3 enableaimassist();
  var_3 setnodeploy(1);
  var_3.speed = var_2.speed;
  var_3.accel = var_2.accel;
  var_3.angles = var_0.angles;
  var_3.owner = var_0;
  var_3.team = var_0.team;

  if(isDefined(var_2.self_destruct))
    var_3.self_destruct = var_2.self_destruct;

  if(isDefined(var_2.detonate_mines))
    var_3.detonate_mines = var_2.detonate_mines;

  if(isDefined(var_2.mark_ai))
    var_3.mark_ai = var_2.mark_ai;

  if(isDefined(var_2.mark_vehicles))
    var_3.mark_vehicles = var_2.mark_vehicles;

  var_3 vehicle_setspeed(var_3.speed, var_3.accel);
  var_3 setotherent(var_0);
  var_3 vehicle_invoketriggers(1);
  var_3 vehicle_breakglass(1);
  var_3.useobj = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
  var_3.useobj setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3.useobj linkTo(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3.useobj hide();
  var_3 thread timeout_monitor(var_0, var_3, var_2);
  var_3 thread damage_monitor(var_0, var_3, var_2);
  var_3 thread player_exit_monitor(var_0, var_3);

  if(istrue(var_2.detonate_mines))
    var_3 thread remote_detonation_monitor(var_0, var_3);

  if(isDefined(var_2.use_func))
    var_3 thread[[var_2.use_func]](var_0, var_3);

  return var_3;
}

player_exit_monitor(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 notifyonplayercommand("_encstr_8C090B1D893063FFB5C3627A09", "_encstr_A6E308B2DCE8B0B936B2");
  var_2 = var_0 scripts\engine\utility::_id_143A6("_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_8C090B1D893063FFB5C3627A09");
  exit_drone(var_0, var_1);
  drone_explode(var_1);
}

timeout_monitor(var_0, var_1, var_2) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(var_2.timeout * 1000));
  wait(var_2.timeout);
  exit_drone(var_0, var_1);
  drone_explode(var_1);
}

damage_monitor(var_0, var_1, var_2) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 setCanDamage(1);
  var_1.health = 999999;
  var_1.maxhealth = 999999;
  var_1.fake_health = var_2.health;
  var_3 = var_2.health;
  var_0 setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", 1);

  for(;;) {
    var_1 waittill("_encstr_B2BE0788BAF573592F", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_1.health = 999999;
    var_1.maxhealth = 999999;
    var_1.fake_health = var_1.fake_health - var_4;
    var_0 setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", var_1.fake_health / var_3);

    if(isDefined(var_5) && isPlayer(var_5))
      var_5 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB");

    if(var_1.fake_health < 0) {
      exit_drone(var_0, var_1);
      drone_explode(var_1);
    }
  }
}

remote_detonation_monitor(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 notifyonplayercommand("_encstr_A2BF1039CAB6B78E59D719AC3AF6B92C3A59", "_encstr_A9E60828803C73F11780");
  var_2 = 1000;
  var_3 = var_2 * var_2;
  var_0.targets_for_remote_detonation = [];
  var_0 thread show_ied_nearby_message_think(var_0, var_1);
  var_0 thread mark_detonate_targets(var_0, var_1);
  var_0 thread remove_outline_on_exit_think(var_0, var_1);

  for(;;) {
    if(soundexists("_encstr_8AD612A72230FDF860818790BD37BE6B1A4AE72A"))
      var_1 playsoundtoplayer("_encstr_8AD612A72230FDF860818790BD37BE6B1A4AE72A", var_0);

    var_0 waittill("_encstr_A2BF1039CAB6B78E59D719AC3AF6B92C3A59");

    foreach(var_5 in var_0.targets_for_remote_detonation) {
      if(isai(var_5)) {
        var_5 dodamage(5000, var_5.origin, var_0);
        continue;
      }

      var_5 notify("_encstr_B2BE0788BAF573592F", 5000, var_0);
    }

    if(soundexists("_encstr_A37F0FC84EED7359D7B65ACD59D7ABDC59"))
      var_1 playsoundonmovingent("_encstr_A37F0FC84EED7359D7B65ACD59D7ABDC59");

    waitframe();
  }
}

show_ied_nearby_message_think(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.showing_ied_nearby_message = 0;
  wait 0.15;

  for(;;) {
    var_0.targets_for_remote_detonation = scripts\engine\utility::array_removeundefined(var_0.targets_for_remote_detonation);

    if(var_0.targets_for_remote_detonation.size > 0) {
      if(var_0.showing_ied_nearby_message == 0) {
        var_0 setclientomnvar("_encstr_BE6E0E6C38FAD25623F5DCCA0B27135E", 1);
        var_0.showing_ied_nearby_message = 1;
      }
    } else if(var_0.showing_ied_nearby_message == 1) {
      var_0 setclientomnvar("_encstr_BE6E0E6C38FAD25623F5DCCA0B27135E", 0);
      var_0.showing_ied_nearby_message = 0;
    }

    waitframe();
  }
}

remove_outline_on_exit_think(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 waittill("_encstr_AD75063D571AE108");
  var_0 setclientomnvar("_encstr_BE6E0E6C38FAD25623F5DCCA0B27135E", 0);

  foreach(var_3 in var_0.targets_for_remote_detonation)
  var_3 hudoutlinedisableforclient(var_0);
}

mark_detonate_targets(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = 1000;
  var_3 = var_2 * var_2;

  for(;;) {
    if(isDefined(level.identified_ieds)) {
      foreach(var_5 in level.identified_ieds) {
        if(distancesquared(var_5.origin, var_1.origin) < var_3 && var_0 worldpointinreticle_circle(var_5.origin, 25, 115)) {
          show_bomb_to_drone(var_5, var_0);
          continue;
        }

        hide_bomb_from_drone(var_5, var_0);
      }
    }

    if(isDefined(level.spawned_enemies)) {
      foreach(var_8 in level.spawned_enemies) {
        if(isDefined(var_8.unittype) && var_8.unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B") {
          if(distancesquared(var_8.origin, var_1.origin) < var_3 && var_0 worldpointinreticle_circle(var_8.origin, 25, 115)) {
            show_bomb_to_drone(var_8, var_0);
            continue;
          }

          hide_bomb_from_drone(var_8, var_0);
        }
      }
    }

    waitframe();
  }
}

show_bomb_to_drone(var_0, var_1) {
  if(scripts\engine\utility::array_contains(var_1.targets_for_remote_detonation, var_0)) {
    return;
  }
  if(isDefined(var_0) && isDefined(var_0.origin)) {
    var_1.targets_for_remote_detonation = scripts\engine\utility::array_add(var_1.targets_for_remote_detonation, var_0);
    var_0 hudoutlineenableforclient(var_1, 1, 0, 1);
  }
}

hide_bomb_from_drone(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.origin)) {
    var_1.targets_for_remote_detonation = scripts\engine\utility::array_remove(var_1.targets_for_remote_detonation, var_0);
    var_0 hudoutlinedisableforclient(var_1);
  }
}

remove_ied_marker_vfx(var_0) {
  if(isDefined(var_0.mine_drone_marker_vfx))
    var_0.mine_drone_marker_vfx delete();
}

drone_explode(var_0) {
  playFX(level._effect["_encstr_BE52103B07CAD707F23870738F8543EBA910"], var_0.origin);
  var_0 delete();
}

turn_on_drone_hud(var_0) {
  var_0 setclientomnvar("_encstr_88251899F0F79026675B7507593BED2A480FA637328BAB7F8067", 1);
  var_0 visionsetnakedforplayer("_encstr_ABAA0C8E6FE7CA0EA940FFABA801", 0);
}

turn_off_drone_hud(var_0) {
  var_0 setclientomnvar("_encstr_88251899F0F79026675B7507593BED2A480FA637328BAB7F8067", 0);
  var_0 visionsetnakedforplayer("_encstr_B40101", 0);
}

find_safe_spawn(var_0) {
  var_1 = var_0.angles;
  var_2 = (0, 0, 35);
  var_3 = 30;
  var_4 = var_2[2];
  var_5 = 15;
  var_6 = anglesToForward(var_0.angles);
  var_7 = anglestoright(var_0.angles);
  var_8 = var_0 getEye();
  var_9 = var_0 getstance();

  if(var_9 == "_encstr_922406F1A6FD5E05")
    var_8 = var_8 + (0, 0, 10);

  var_10 = var_8 + (0, 0, var_4);
  var_11 = var_10 + var_3 * var_6;

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_10 - var_3 * var_6;

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_11 + var_3 * var_7;

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_10 - var_3 * var_7;

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_10;

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  waitframe();
  var_11 = var_10 + 0.707 * var_3 * (var_6 + var_7);

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_10 + 0.707 * var_3 * (var_6 - var_7);

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_10 + 0.707 * var_3 * (var_7 - var_6);

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  var_11 = var_10 + 0.707 * var_3 * (-1 * var_6 - var_7);

  if(check_spawn_point(var_0, var_8, var_11, var_5)) {
    var_0.recondronesafespawn = var_11;
    return var_11;
  }

  return var_10;
}

check_spawn_point(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4"]);

  if(scripts\engine\trace::sphere_trace_passed(var_1, var_1, var_3, var_0, var_5))
    var_4 = 1;

  return var_4;
}

load_fx() {
  level._effect["_encstr_BE52103B07CAD707F23870738F8543EBA910"] = loadfx("_encstr_8A7A3054A580A84810DA114F33FD5A8493102BC3F3F7F14ACEC005A0F6A913887E19474B8810EB350F2C191DBB135D831868");
}