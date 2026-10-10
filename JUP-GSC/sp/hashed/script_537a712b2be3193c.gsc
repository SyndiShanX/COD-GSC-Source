/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_537a712b2be3193c.gsc
*************************************************/

#using script_537a712b2be3193c;
#using script_68fa6b4ee60216ae;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp\agent_drops;
#using scripts\cp\aitypes;
#using scripts\cp\coop_stealth;
#using scripts\cp\helicopter\cp_helicopter;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#using scripts\stealth\utility;
#namespace namespace_4757a2c5a9b3ff3d;

function ai_spawn(aitype, spawnpoint, drop, goalradius) {
  ai = scripts\mp\mp_agent::spawnnewagentaitype(aitype, spawnpoint.origin, (0, 0, 0));

  if(isDefined(ai)) {
    ai scripts\cp\spawning::function_389fff85c076f49e();
    ai function_b292d0931fd89cd1(aitype);
    ai function_9d7852eaabe40398(aitype);
    ai function_a5bf59b49d59188(aitype);
    ai notify("stop_hunting");

    if(!namespace_d9d93e01b62de24a::function_578d89786b7eda1()) {
      ai cleargoalvolume();
      ai setgoalpos(ai.origin);
    }

    if(isDefined(goalradius)) {
      ai.goalradius = goalradius;
    } else {
      ai.goalradius = 1024;
    }

    ai namespace_f07a91c6c17492be::init(aitype);
    ai delaythread(3, &function_3b02eebe0b11f734, drop);
    return ai;
  }

  return undefined;
}

function function_b292d0931fd89cd1(aitype) {
  if(issubstr(aitype, "_smg")) {
    scripts\cp\agent_drops::function_6fdbf71c8217cfc5("cash_drop_100");
    return;
  }

  if(issubstr(aitype, "_ar")) {
    scripts\cp\agent_drops::function_6fdbf71c8217cfc5("cash_drop_100");
    return;
  }

  if(issubstr(aitype, "_sniper")) {
    scripts\cp\agent_drops::function_6fdbf71c8217cfc5("cash_drop_100");
    return;
  }

  if(issubstr(aitype, "_juggernaut")) {
    scripts\cp\agent_drops::function_6fdbf71c8217cfc5("cash_drop_1000");
    return;
  }

  if(issubstr(aitype, "_shotgun")) {
    scripts\cp\agent_drops::function_6fdbf71c8217cfc5("cash_drop_100");
    return;
  }

  if(issubstr(aitype, "_lmg")) {
    scripts\cp\agent_drops::function_6fdbf71c8217cfc5("cash_drop_100");
    return;
  }

  if(issubstr(aitype, "_rpg")) {
    scripts\cp\agent_drops::function_6fdbf71c8217cfc5("cash_drop_100");
  }
}

function function_9d7852eaabe40398(aitype) {
  scripts\cp\spawning::function_389fff85c076f49e();
  scripts\cp\agent_drops::function_6fdbf71c8217cfc5("brloot_armor_plate");
  scripts\cp\agent_drops::function_6fdbf71c8217cfc5("brloot_powerup_equipment");
}

function function_a5bf59b49d59188(aitype) {
  if(issubstr(aitype, "_juggernaut")) {
    scripts\cp\aitypes::set_juggernaut_flags();
    return;
  }

  if(issubstr(aitype, "riotshield")) {
    self.shoulddropriotshield = 1;
    return;
  }

  if(issubstr(aitype, "heavy")) {
    scripts\cp\spawning::give_soldier_armor();
    return;
  }

  function_bc6dbd7aed124330();
}

function function_bc6dbd7aed124330() {
  if(!isDefined(level.current_wave)) {
    level.current_wave = 0;
  }

  if(level.current_wave < 6) {
    return;
  }

  multiplier = level.current_wave - 6 + 1;
  self.baseaccuracy += 0.1 * multiplier;
  maxhealth = self.maxhealth + multiplier * 25;

  if(maxhealth > 810) {
    maxhealth = 810;
  }

  self.maxhealth = maxhealth;
  self.health = maxhealth;
}

function function_192f8a34d0ae130f(ai_array, leaders) {
  leader = random(ai_array);

  if(getdvarint(@ "squad_debug", 0) > 0) {
    leader hudoutlineenable("<dev string:x1c>");
  }

  if(getdvarint(@ "hash_a43cc6d0cbf7ab63", 0) > 0) {
    return;
  }

  if(isDefined(leaders)) {
    if(isarray(leaders)) {
      leader = random(leaders);
    } else {
      leader = leaders;
    }
  }

  while(true) {
    alive = 0;

    foreach(ai in ai_array) {
      if(!isalive(ai) || ai.health < 1) {
        continue;
      }

      alive = 1;
    }

    if(!alive) {
      return;
    }

    if(isDefined(leader) && isalive(leader)) {
      foreach(ai in ai_array) {
        if(!isDefined(ai)) {
          continue;
        }

        if(ai == leader) {
          continue;
        }

        if(!isalive(ai) || ai.health < 1) {
          continue;
        }

        if(!isDefined(ai.goalent) || ai.goalent != leader) {
          if(getDvar(@ "squad_debug") != "") {
            ai hudoutlineenable("outline_nodepth_white");
          }

          ai notify("stop_hunting");
          ai setgoalentity(leader);
          ai.goalent = leader;
        }

        var_4666c0e35742bc07 = 0;

        foreach(player in level.players) {
          if(distance2dsquared(leader.origin, player.origin) < squared(leader.goalradius)) {
            var_4666c0e35742bc07 = 1;
          }
        }

        ai.goalradius = 256;

        if(var_4666c0e35742bc07 || distance2dsquared(leader.origin, ai.origin) < squared(ai.goalradius)) {
          if(distance2dsquared(leader.origin, ai.origin) < squared(ai.goalradius)) {
            ai setcoverselectionfocusent(leader);
            ai.goalradius = 800;
          }
        }
      }
    } else {
      ai_array = array_removeundefined(ai_array);

      if(ai_array.size == 0) {
        return;
      }

      leader = random(ai_array);

      if(isDefined(leaders)) {
        alive = 0;

        foreach(guy in leaders) {
          if(!isalive(guy) || guy.health < 1) {
            continue;
          }

          alive = 1;
        }

        if(alive) {
          if(isarray(leaders)) {
            leader = random(leaders);
          } else {
            leader = leaders;
          }
        }
      }

      leader notify("stop_hunting");

      if(getDvar(@ "squad_debug") != "") {
        leader hudoutlineenable("outline_nodepth_green");
      }

      leader thread function_9c0fbe62c1b9d660();
    }

    wait 1;
  }
}

function function_edbfa2ba7f3b537f() {
  while(true) {
    level waittill("spawn_boss_heli");
    search_point = spawnStruct();
    search_point.origin = (0, 0, 2000);
    search_point.script_noteworthy = "test_path";
    spawn_point = spawnStruct();
    spawn_point.origin = (-10000, -10000, 1200);
    spawn_point.angles = (0, 0, 0);
    spawn_point.classname_mp = "script_vehicle_apache_east";
    spawn_point.script_modelname = "veh8_mil_air_ahotel64_ks_east_mp";
    spawn_point.vehicletype = "veh_apache_cp";
    heli = scripts\common\vehicle::vehicle_spawn(spawn_point);
    heli.death_fx_on_self = 1;
    heli.circle_radius = 2500;
    heli scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "chopper_gunner_turret_cp", "tag_turret");
    heli thread function_8d90f05d674519ff(1);
    heli.isheli = 1;
    heli.health = 50000;
    heli.maxhealth = 50000;
    heli.team = "axis";
    heli setvehicleteam(heli.team);
    heli setmaxpitchroll(15, 15);
    heli.health_remaining = 2250;
    level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(heli, 1800);
    heli sethoverparams(25, 15, 10);
    heli.headicon = createheadicon(heli);
    setheadiconimage(heli.headicon, "hud_icon_head_equipment_enemy");
    setheadiconmaxdistance(heli.headicon, 12000);
    setheadiconnaturaldistance(heli.headicon, 1500);
    setheadiconzoffset(heli.headicon, 10);
    setheadiconsnaptoedges(heli.headicon, 1);

    if(!isDefined(level.special_lockon_target_list)) {
      level.special_lockon_target_list = [];
    }

    level.special_lockon_target_list[level.special_lockon_target_list.size] = heli;
    level.attack_heli = heli;
    heli waittill("death");
  }
}

function function_8d90f05d674519ff(var_472c96d6a8ed7d53) {
  tag_pilot = "tag_pilot";

  if(!self tagexists(tag_pilot)) {
    tag_pilot = "tag_pilot1";
  }

  self.pilot = spawn("script_model", self gettagorigin(tag_pilot));
  self.pilot setModel("aq_pilot_fullbody_1");
  self.pilot linkTo(self, tag_pilot, (0, 0, 0), (0, 0, 0));
  self.pilot scriptmodelplayanimdeltamotion("vh_mindia8_pilot_idle");

  if(isDefined(var_472c96d6a8ed7d53)) {
    thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor();
  }
}

function function_3b02eebe0b11f734(shoulddrop) {
  if(!getdvarint(@ "hash_26524832a07cf602", 1)) {
    self.dropweapon = 0;
    return;
  }

  if(!isDefined(shoulddrop)) {
    shoulddrop = 0;
  }

  self.dropweapon = shoulddrop;
  self.var_98add129a7ecb962 = 0;
}

function function_578d89786b7eda1() {
  return getdvarint(@ "hash_45ded5ed971fb14a", 0) != 0;
}

function function_3ba1a006f4de9686() {
  self.script_stealthgroup = "dogs";
  namespace_d9d93e01b62de24a::function_e92ec2858fc2ac1();
}

function function_9c0fbe62c1b9d660() {
  self endon("death");
  self endon("stop_hunting");
  player = random(level.players);

  while(true) {
    if(!isDefined(player) || istrue(player.inlaststand)) {
      selected = 0;

      foreach(new_player in level.players) {
        if(istrue(new_player.inlaststand)) {
          continue;
        }

        player = new_player;
        selected = 1;
      }

      if(!selected) {
        wait 3;
        player = undefined;
        continue;
      }
    }

    foreach(player_ent in level.players) {
      self getenemyinfo(player_ent);
    }

    org = player.origin;
    wait 3;
  }
}

function function_e4f3059610095250(spawned, var_7f0c5ead0494e282, var_da87f68719e2b303) {
  if(!isDefined(var_7f0c5ead0494e282)) {
    var_7f0c5ead0494e282 = 0;
  }

  wave_num = level.current_wave;

  if(isDefined(var_da87f68719e2b303)) {
    wave_num = var_da87f68719e2b303;
  }

  while(true) {
    wait 1;
    alive = 0;

    if(!isDefined(spawned)) {
      spawned = level.var_603f2855fc89966[wave_num];
    }

    if(!isDefined(spawned)) {
      return;
    }

    foreach(ent in spawned) {
      if(isalive(ent) && ent.health > 0) {
        if(!isDefined(ent.old_pos)) {
          ent.old_pos = ent.origin;
        } else if(distancesquared(ent.old_pos, ent.origin) < squared(16)) {
          if(!isDefined(ent.stuck_counter)) {
            ent.stuck_counter = 0;
          } else {
            ent.stuck_counter++;
          }

          if(ent.stuck_counter > 5) {
            if(getdvarint(@ "hash_9056536d4ffb50d3", 0) > 0) {
              iprintln("<dev string:x32>" + ent.origin);

              if(!istrue(ent.outlined)) {
                ent hudoutlineenable("<dev string:x5e>");
                ent.outlined = 1;
              }
            } else {
              println("<dev string:x32>" + ent.origin);
            }
          }
        }

        alive++;
      }
    }

    if(alive > var_7f0c5ead0494e282) {
      continue;
    }

    return;
  }
}

function function_e92ec2858fc2ac1(group_name, func) {
  if(isDefined(self.spawnpoint)) {
    self.spawnpoint.spawnflags = 512;
  }

  self.goalradius = 16;
  self.sightmaxdistance = 2200;

  if(!isDefined(self.script_stealthgroup)) {
    self.script_stealthgroup = "stealth_intro_group";
  }

  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
}

function function_ab858daac5d7b598() {
  stealth_hidden = [];
  stealth_hidden["prone"] = 800;
  stealth_hidden["crouch"] = 1500;
  stealth_hidden["stand"] = 3000;
  stealth_spotted = [];
  stealth_spotted["prone"] = 800;
  stealth_spotted["crouch"] = 1500;
  stealth_spotted["stand"] = 3000;
  scripts\stealth\utility::set_detect_ranges(stealth_hidden, stealth_spotted);
}

function function_c84a5070bb4a2d2d(overridevalue) {
  if(isDefined(overridevalue)) {
    scripts\cp\coop_stealth::set_maxvisibledist(overridevalue);
    return;
  }

  scripts\cp\coop_stealth::set_maxvisibledist(8192);
}