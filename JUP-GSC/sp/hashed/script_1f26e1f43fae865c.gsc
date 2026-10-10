/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1f26e1f43fae865c.gsc
*************************************************/

#using script_19b3e06c555316d7;
#using script_3a8f9ace195c9da9;
#using script_3c5077a8847a5d9e;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_weapon;
#using scripts\engine\utility;
#namespace namespace_1b96af200012c965;

function function_15ac00c604af0413(teleport_struct) {
  flag_wait("player_spawned_with_loadout");
  spawner = getStruct("overwatch_ally_price", "targetname");
  ally = spawner function_3bc156ea86eac9e2();
  ally.name = "Price";
  ally.animname = "overwatch_ally";
  ally.team = "allies";
  ally.ignoreme = 1;
  ally.dontevershoot = 1;
  ally.goalradius = 1;
  ally set_movement_speed(220);
  ally.agentname = &"CP_JUP_APT/PRICE";
  ally.var_e0143f4f183d8a12 = 1;
  ally disableaimassist();
  ally.baseaccuracy = 1;
  ally.accuracy = ally.baseaccuracy;
  ally setengagementmindist(300, 200);
  ally setengagementmaxdist(4000, 5000);
  ally function_9215ce6fc83759b9(5000);
  ally.disablepistol = 1;
  primaryweaponhash = "iw9_dm_la700_mp, [ laserir_box ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[primaryweaponhash])) {
    level.var_67b54180a55f70e1[primaryweaponhash] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_dm_la700_mp", ["laserir_box"], "none", "none");
  }

  secondaryweaponhash = "iw9_sm_mpapa5_sp";

  if(!isDefined(level.var_67b54180a55f70e1[secondaryweaponhash])) {
    level.var_67b54180a55f70e1[secondaryweaponhash] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_sm_mpapa5_sp");
  }

  ally.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
  ally giveweapon(ally.weapon);
  ally setspawnweapon(ally.weapon);
  ally.bulletsinclip = weaponclipsize(ally.weapon);
  ally.primaryweapon = ally.weapon;
  ally.weapon = level.var_67b54180a55f70e1[secondaryweaponhash];
  ally giveweapon(ally.weapon);
  ally.bulletsinclip = weaponclipsize(ally.secondaryweapon);
  ally.secondaryweapon = ally.weapon;
  ally scripts\common\ai::set_gunpose("ads");

  if(isDefined(teleport_struct)) {
    start_pos = function_7a18da6e48b71c35(teleport_struct);
    ally.origin = start_pos.origin;
  }

  ally scripts\common\ai::magic_bullet_shield();
  level.ally = ally;
}

function function_1a36b4303dafa62() {
  level endon("end_ally_overwatch");
  var_3796fe8cf560b672 = getStruct("ally_overwatch_loc", "targetname");
  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  var_a93fe0cfcd3db568 = undefined;
  flag_set("flag_dungeon_apt_overwatch_enabled");
  thread function_e4447c9494b98b9a();

  while(true) {
    wait 1;

    if(!flag("flag_dungeon_apt_overwatch_enabled")) {
      continue;
    }

    if(isDefined(var_a93fe0cfcd3db568)) {
      var_aaecca81af75003b = var_a93fe0cfcd3db568 + 4000;

      if(flag("flag_dungeon_apt_player_low_health")) {
        var_aaecca81af75003b = var_a93fe0cfcd3db568 + 3000;
      }

      if(gettime() < var_aaecca81af75003b) {
        continue;
      }
    }

    guys = getaiarray("axis");

    if(!isDefined(guys)) {
      continue;
    }

    guys = array_remove(guys, level.hvt);
    guys = array_remove(guys, level.ally);
    guys = array_removedead_or_dying(guys);
    guys = sortbydistance(guys, level.player.origin);
    shoot_target = undefined;
    var_57a6f36ed19b10a6 = 0;

    foreach(guy in guys) {
      castend = guy gettagorigin("j_head");
      castresult = physics_raycast(var_3796fe8cf560b672.origin, castend, contents, undefined, 0, "physicsquery_closest", 0);

      if(isDefined(castresult) && castresult.size > 0) {
        continue;
      }

      in_fov = within_fov(level.player getEye(), level.player getplayerangles(), castend, cos(60));

      if(!in_fov && !flag("flag_dungeon_apt_player_low_health")) {
        continue;
      }

      if(isDefined(self.heli)) {
        continue;
      }

      var_b3c44708dfcab166 = within_fov(level.player getEye(), level.player getplayerangles(), castend, cos(30));

      if(var_b3c44708dfcab166 && !flag("flag_dungeon_apt_player_low_health")) {
        continue;
      }

      if(!function_e7c30095a6cdc3ef(guy getEye()) && !flag("flag_dungeon_apt_player_low_health")) {
        continue;
      }

      shoot_target = guy;
      break;
    }

    if(isDefined(var_a93fe0cfcd3db568) && gettime() > var_a93fe0cfcd3db568 + 14000) {
      shoot_target = random(guys);
      var_57a6f36ed19b10a6 = 1;
    }

    if(!isDefined(shoot_target)) {
      continue;
    }

    shot_end = undefined;
    var_98ccb7441919420b = 0;
    var_e014aa33281c00d8 = 0.7;

    if(flag("flag_dungeon_apt_player_low_health")) {
      var_e014aa33281c00d8 = 0.9;
    }

    if(randomfloat(1) <= var_e014aa33281c00d8 && !var_57a6f36ed19b10a6) {
      var_98ccb7441919420b = 1;
      thread function_37bd1c32c1e3741b(shoot_target);
      shot_end = shoot_target gettagorigin("j_head");
    } else {
      shot_end = shoot_target gettagorigin("j_head") + (0, 0, 40);
    }

    level.ally shoot(1, shoot_target);

    line(level.ally gettagorigin("<dev string:x1c>"), shot_end, (0.7, 0.7, 0.7), 1, 1, 30);

    if(istrue(var_98ccb7441919420b)) {
      shoot_target kill();
    }
  }
}

function function_581b69a0b787b8a5(guys) {
  guys = sortbydistance(guys, level.player.origin);

  foreach(guy in guys) {
    can_see = level.ally function_ca53f38b1eb70113(guy getEye(), 0, 4000);

    if(can_see) {
      return guy;
    }
  }

  return guys[0];
}

function function_e4447c9494b98b9a() {
  level.player endon("death");

  while(true) {
    wait 0.25;

    if(level.player.health < 75) {
      flag_set("flag_dungeon_apt_player_low_health");
      continue;
    }

    flag_clear("flag_dungeon_apt_player_low_health");
  }
}

function function_37bd1c32c1e3741b(var_662f372e4d310c25) {
  results = var_662f372e4d310c25 waittill_any_timeout_1(2, "death");

  if(is_equal(results, "timeout")) {
    return;
  }

  if(randomint(10) < 7) {
    return;
  }

  level notify("ally_overwatch_kill");
}