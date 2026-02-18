/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_413ab8fe25a61c50.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2440f86f9cd325ac;
#using script_2a5bf5b4a00cee0d;
#using script_3faf478d5b0850fe;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_68cdf0ca5df5e;
#using script_74a56359b7d02ab6;
#using script_f38dc50f0e82277;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_77eccc4f;

function function_93e7ee52(challengetype = 0, name) {
  level.doa.var_e5ef2ab4 |= 1 << challengetype;
  level.doa.var_a598a835 = undefined;
  level.doa.var_a77e4601 = [];
  level flag::clear("challenge_round_spawnOverride");
  timestart = gettime();
  namespace_1e25ad94::debugmsg("Challenge (" + name + ") starting at: " + timestart + " RoundNumber: " + level.doa.roundnumber);
  waitframe(1);
  var_af104f33 = function_fa798421(name);
  level doa_banner::function_7a0e5387(var_af104f33);

  switch (challengetype) {
    case 1:
      level thread namespace_9fc66ac::announce(62);
      def = doa_enemy::function_251ee3bd("barreler_zombie");
      [[def]] - > function_7edd7727(6);
      level.doa.var_a77e4601[level.doa.var_a77e4601.size] = def;
      def = doa_enemy::function_251ee3bd("basic_zombie");
      level.doa.var_a77e4601[level.doa.var_a77e4601.size] = def;
      level.doa.var_a77e4601[level.doa.var_a77e4601.size] = def;
      break;
    case 2:
      level thread namespace_9fc66ac::announce(62);
      level thread function_d1dc367c();
      def = doa_enemy::function_251ee3bd("riser_zombie");
      break;
    case 3:
      level thread namespace_9fc66ac::announce(62);
      level thread function_97aae609();
      def = doa_enemy::function_251ee3bd("smoke_zombie");
      [[def]] - > function_7edd7727(6);
      break;
    case 4:
      level thread namespace_9fc66ac::announce(62);
      def = doa_enemy::function_251ee3bd("gladiator_destroyer");
      [[def]] - > function_7edd7727(6);
      level.doa.var_a77e4601[level.doa.var_a77e4601.size] = def;
      def = doa_enemy::function_251ee3bd("gladiator_marauder");
      [[def]] - > function_7edd7727(6);
      level.doa.var_a77e4601[level.doa.var_a77e4601.size] = def;
      def = doa_enemy::function_251ee3bd("basic_zombie");

      for(count = 6; count; count--) {
        level.doa.var_a77e4601[level.doa.var_a77e4601.size] = def;
      }

      break;
    case 5:
      level thread namespace_9fc66ac::announce(62);
      def = doa_enemy::function_251ee3bd("ghost_zombie");
      [[def]] - > function_7edd7727(6);
      level.doa.var_a77e4601[level.doa.var_a77e4601.size] = def;
      break;
    case 6:
      level thread namespace_9fc66ac::announce(63);
      level thread function_17f47e92();
      break;
    case 7:
      level thread namespace_9fc66ac::announce(62);
      level thread function_9f6da3ff();
      break;
    case 8:
      level thread namespace_9fc66ac::announce(62);
      level thread function_cd4e6a10();
      break;
    case 9:
      level thread namespace_9fc66ac::announce(62);
      def = doa_enemy::function_251ee3bd("pole_zombie");

      for(count = getplayers().size; count; count--) {
        level.doa.var_a77e4601[level.doa.var_a77e4601.size] = def;
      }

      [[def]] - > function_7edd7727(6);
      def = doa_enemy::function_251ee3bd("basic_zombie");
      level.doa.var_a77e4601[level.doa.var_a77e4601.size] = def;
      level.doa.var_a77e4601[level.doa.var_a77e4601.size] = def;
      level.doa.var_a77e4601[level.doa.var_a77e4601.size] = def;
      level.doa.var_a77e4601[level.doa.var_a77e4601.size] = def;
      break;
    case 10:
      level thread namespace_9fc66ac::announce(63);
      level thread function_382bc607();
      break;
    case 11:
      level thread namespace_9fc66ac::announce(62);
      level thread function_bd313167();
      break;
    case 12:
      level thread namespace_9fc66ac::announce(63);
      level thread function_c6834d32();
      break;
  }

  lootstructs = struct::get_array(name + "_challenge_loot", "targetname");

  foreach(loot in lootstructs) {
    if(isDefined(loot.script_noteworthy)) {
      items = strtok(loot.script_noteworthy, ";");
      item = items[randomint(items.size)];
      def = namespace_dfc652ee::function_6265bde4(item);

      if(isDefined(def)) {
        pickup = level namespace_dfc652ee::itemspawn(def, loot.origin, undefined, undefined, 1);

        if(isDefined(pickup)) {
          pickup.origin = loot.origin;
          pickup notify(#"hash_2a866f50cc161ca8");

          if(isDefined(pickup.glowfx) && pickup.glowfx !== "glow_yellow") {
            util::wait_network_frame();
            pickup namespace_83eb6304::turnofffx(pickup.glowfx);
            pickup namespace_83eb6304::function_3ecfde67("glow_yellow");
          }
        }
      }
    }
  }

  level notify(#"challenge_ready");
}

function init() {
  level flag::init("challenge_round_spawnOverride", 0);
  main();
}

function main() {
  level.doa.var_e5ef2ab4 = 0;
  level.doa.var_a77e4601 = [];
  level.doa.var_a598a835 = undefined;
  level flag::clear("challenge_round_spawnOverride");
}

function function_1a010742(name) {
  switch (name) {
    case # "jungle":
      return 4;
    case # "cartel":
      return 1;
    case # "graveyard":
      return 2;
    case # "temple":
      return 3;
    case # "watertemple":
      return 5;
    case # "icecave":
      return 6;
    case # "bloodlake":
      return 7;
    case # "witchwood":
      return 8;
    case # "wintercave":
      return 9;
    case # "geothermal":
      return 10;
    case # "alpine":
      return 11;
    case # "boss":
      return 12;
  }

  return 0;
}

function function_fa798421(name) {
  switch (name) {
    case # "jungle":
      return 32;
    case # "cartel":
      return 42;
    case # "graveyard":
      return 30;
    case # "temple":
      return 31;
    case # "watertemple":
      return 33;
    case # "icecave":
      return 34;
    case # "bloodlake":
      return 35;
    case # "witchwood":
      return 36;
    case # "wintercave":
      return 38;
    case # "geothermal":
      return 39;
    case # "alpine":
      return 40;
    case # "boss":
      if(level.doa.var_6c58d51 == 0) {
        return 41;
      } else {
        return 43;
      }

      break;
  }

  return undefined;
}

function function_379191c(name) {
  level.doa.var_a77e4601 = [];
  challenge = function_1a010742(name);

  if(challenge == 0) {
    return false;
  }

  if(function_d53627e4(challenge)) {
    return false;
  }

  level thread function_93e7ee52(challenge, name);
  return true;
}

function function_d53627e4(type) {
  return level.doa.var_e5ef2ab4 & 1 << type;
}

function function_d1dc367c() {
  level endon(#"arena_completed");
  level endon(#"game_over");
  level flag::set("challenge_round_spawnOverride");
  var_a1c7d06b = doa_enemy::function_251ee3bd("riser_zombie");
  origin = [[level.doa.var_39e3fa99]] - > function_ffcf1d1();
  level.doa.var_ccbf8c33 = [[level.doa.var_39e3fa99]] - > function_3476ff6d();
  level.doa.var_2020337e = 0;
  level.doa.var_a598a835 = &function_6876f78c;
  wait 5;
  waves = 5 + 4 * level.doa.var_6c58d51;
  var_87b290c9 = level.doa.var_ccbf8c33.size;
  level.doa.var_13e8f9c9 = "walk";
  players = namespace_7f5aeb59::function_23e1f90f();
  var_58bd90cd = 2;

  while(waves) {
    for(numai = var_87b290c9; numai > 0; numai--) {
      doa_enemy::function_a6b807ea(var_a1c7d06b, 1, origin, 0, undefined, players[0], undefined, level.doa.var_39e3fa99, undefined, undefined, -1);
    }

    while(level.doa.var_dcbded2.size || namespace_ec06fe4a::function_9788bacc() > 5) {
      wait 1;
    }

    waves--;
    var_58bd90cd--;

    if(var_58bd90cd <= 0) {
      var_58bd90cd = 2;
      var_87b290c9 -= 8;

      if(var_87b290c9 < 20) {
        var_87b290c9 = 20;
      }

      level.doa.var_13e8f9c9 = namespace_250e9486::function_bb0817aa(level.doa.var_13e8f9c9);
    }
  }

  [[level.doa.var_39e3fa99]] - > setpaused(0);
  level.doa.var_ccbf8c33 = undefined;
  level.doa.var_2020337e = undefined;
  level.doa.var_a598a835 = undefined;
  level.doa.var_13e8f9c9 = undefined;
  level flag::clear("challenge_round_spawnOverride");
}

function function_97aae609() {
  level endon(#"arena_completed");
  level endon(#"game_over");
  level flag::set("challenge_round_spawnOverride");
  var_94f3b914 = doa_enemy::function_251ee3bd("smoke_zombie");
  origin = [[level.doa.var_39e3fa99]] - > getcenter();
  struct = struct::get([[level.doa.var_39e3fa99]] - > getname() + "_challenge", "targetname");
  level.doa.var_6d072a34 = isDefined(struct) ? struct : origin;
  level.doa.var_a598a835 = &function_29ff6b1;
  wait 5;

  for(waves = 3 + 3 * level.doa.var_6c58d51; waves; waves--) {
    function_d1603826(var_94f3b914);
    wait 10;

    for(regular = randomintrange(5, 15); regular; regular--) {
      spot = [[level.doa.var_39e3fa99]] - > function_21d1be3d(function_7802d126());
      namespace_8c04284b::function_24058346(spot);
    }

    wait 10;

    while(level.doa.var_dcbded2.size || namespace_ec06fe4a::function_9788bacc() > 5) {
      wait 1;
    }
  }

  level flag::clear("challenge_round_spawnOverride");
}

function function_7802d126() {
  roll = randomint(100);

  if(roll > 75) {
    return "top";
  }

  if(roll > 55) {
    return "left";
  }

  if(roll > 25) {
    return "right";
  }

  return "bottom";
}

function function_d1603826(var_94f3b914, var_9e20508c = 15) {
  doa_enemy::function_a6b807ea(var_94f3b914, var_9e20508c, level.doa.var_6d072a34.origin, 0, undefined, undefined, undefined, level.doa.var_39e3fa99);
}

function function_6876f78c() {
  spot = level.doa.var_2020337e;
  level.doa.var_2020337e++;

  if(level.doa.var_2020337e > level.doa.var_ccbf8c33.size) {
    level.doa.var_2020337e = 0;
  }

  return level.doa.var_ccbf8c33[spot];
}

function function_29ff6b1() {
  return level.doa.var_6d072a34;
}

function function_17f47e92() {
  maxai = [[level.doa.var_39e3fa99]] - > function_c892290a();
  [[level.doa.var_39e3fa99]] - > function_6d5262dc(16 + 8 * getplayers().size);

  if(!isDefined(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = [];
  } else if(!isarray(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = array(level.doa.var_a77e4601);
  }

  level.doa.var_a77e4601[level.doa.var_a77e4601.size] = level.doa.var_65a70dc;
  def = doa_enemy::function_251ee3bd("crawler_zombie");
  [[def]] - > function_7edd7727(6);
  level.doa.var_6d072a34 = struct::get([[level.doa.var_39e3fa99]] - > getname() + "_challenge", "targetname");

  if(!isDefined(level.doa.var_d15a522)) {
    level.doa.var_d15a522 = doa_enemy::function_d7c5adee("blight_father");
  }

  var_f8ff628e = doa_enemy::function_db55a448(level.doa.var_d15a522, level.doa.var_6d072a34.origin);

  if(is_true(level.var_a095060b)) {
    var_f8ff628e thread namespace_ec06fe4a::function_3b3bb5c(0.1, 600);
  }

  if(isDefined(var_f8ff628e)) {
    var_f8ff628e waittill(#"death");
  }

  [[level.doa.var_39e3fa99]] - > function_6d5262dc(maxai);
}

function function_201a7d58() {
  spawnloc = spawnStruct();

  if(randomint(100) < 60) {
    spawnloc.origin = [[level.doa.var_39e3fa99]] - > function_70fb5745().origin + (0, 0, 1600);
    spawnloc.angles = [[level.doa.var_39e3fa99]] - > function_70fb5745().angles;
  } else {
    players = getplayers();

    if(players.size) {
      player = players[randomint(players.size)];
      spawnloc.origin = player.origin + (0, 0, 1600);
      spawnloc.angles = player.angles;
    } else {
      spawnloc.origin = [[level.doa.var_39e3fa99]] - > function_70fb5745().origin + (0, 0, 1600);
      spawnloc.angles = [[level.doa.var_39e3fa99]] - > function_70fb5745().angles;
    }
  }

  return spawnloc;
}

function function_9f6da3ff() {
  level endon(#"game_over");
  level flag::set("challenge_round_spawnOverride");
  var_94f3b914 = doa_enemy::function_251ee3bd("meatball_large");
  [[var_94f3b914]] - > function_7edd7727(6);
  wait 5;
  origin = [[level.doa.var_39e3fa99]] - > function_ffcf1d1();
  waves = 4 + getplayers().size;
  level.doa.var_a598a835 = &function_201a7d58;

  while(waves) {
    if(level flag::get("doa_round_over")) {
      break;
    }

    doa_enemy::function_a6b807ea(var_94f3b914, 6, origin, 0, undefined, undefined, undefined, level.doa.var_39e3fa99);
    result = level waittilltimeout(30, #"doa_round_over");
    waves--;
  }

  level flag::clear("challenge_round_spawnOverride");
  level.doa.var_a598a835 = undefined;
}

function function_cd4e6a10() {
  level endon(#"arena_completed");
  level endon(#"game_over");
  maxai = [[level.doa.var_39e3fa99]] - > function_c892290a();
  [[level.doa.var_39e3fa99]] - > function_6d5262dc(24);
  var_94f3b914 = doa_enemy::function_251ee3bd("wolf_ghosthound");
  [[var_94f3b914]] - > function_7edd7727(6);

  if(!isDefined(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = [];
  } else if(!isarray(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = array(level.doa.var_a77e4601);
  }

  level.doa.var_a77e4601[level.doa.var_a77e4601.size] = var_94f3b914;
  var_94f3b914 = doa_enemy::function_251ee3bd("riser_zombie");

  if(!isDefined(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = [];
  } else if(!isarray(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = array(level.doa.var_a77e4601);
  }

  level.doa.var_a77e4601[level.doa.var_a77e4601.size] = var_94f3b914;

  if(!isDefined(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = [];
  } else if(!isarray(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = array(level.doa.var_a77e4601);
  }

  level.doa.var_a77e4601[level.doa.var_a77e4601.size] = var_94f3b914;

  if(!isDefined(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = [];
  } else if(!isarray(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = array(level.doa.var_a77e4601);
  }

  level.doa.var_a77e4601[level.doa.var_a77e4601.size] = level.doa.var_65a70dc;
  level waittill(#"hash_c57f3f18a005e45");
  origin = [[level.doa.var_39e3fa99]] - > function_ffcf1d1();

  if(!isDefined(level.doa.var_ce4f409c)) {
    level.doa.var_ce4f409c = doa_enemy::function_d7c5adee("werewolf");
  }

  var_f8ff628e = doa_enemy::function_db55a448(level.doa.var_ce4f409c, origin);

  if(isDefined(var_f8ff628e)) {
    level doa_banner::function_7a0e5387(37);
    level thread namespace_9fc66ac::announce(63);

    if(is_true(level.var_a095060b)) {
      var_f8ff628e thread namespace_ec06fe4a::function_3b3bb5c(0.1, 1500);
    }

    var_f8ff628e waittill(#"death");
  }

  namespace_8c04284b::function_c8462f96();
  level namespace_ec06fe4a::function_de70888a();
  [[level.doa.var_39e3fa99]] - > function_6d5262dc(maxai);
}

function function_bd313167() {
  level endon(#"arena_completed");
  level endon(#"game_over");
  maxai = [[level.doa.var_39e3fa99]] - > function_c892290a();
  [[level.doa.var_39e3fa99]] - > function_6d5262dc(28);
  var_94f3b914 = doa_enemy::function_251ee3bd("brutus");
  [[var_94f3b914]] - > function_7edd7727(6);

  if(!isDefined(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = [];
  } else if(!isarray(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = array(level.doa.var_a77e4601);
  }

  level.doa.var_a77e4601[level.doa.var_a77e4601.size] = var_94f3b914;

  if(!isDefined(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = [];
  } else if(!isarray(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = array(level.doa.var_a77e4601);
  }

  level.doa.var_a77e4601[level.doa.var_a77e4601.size] = level.doa.var_65a70dc;

  if(!isDefined(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = [];
  } else if(!isarray(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = array(level.doa.var_a77e4601);
  }

  level.doa.var_a77e4601[level.doa.var_a77e4601.size] = level.doa.var_65a70dc;

  if(!isDefined(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = [];
  } else if(!isarray(level.doa.var_a77e4601)) {
    level.doa.var_a77e4601 = array(level.doa.var_a77e4601);
  }

  level.doa.var_a77e4601[level.doa.var_a77e4601.size] = level.doa.var_65a70dc;
  [[level.doa.var_39e3fa99]] - > function_6d5262dc(maxai);
}

function function_c6834d32() {
  origin = [[level.doa.var_39e3fa99]] - > getcenter();
  struct = struct::get([[level.doa.var_39e3fa99]] - > getname() + "_challenge", "targetname");
  level.doa.var_6d072a34 = isDefined(struct) ? struct : origin;

  if(!isDefined(level.doa.var_b52c4a7b)) {
    level.doa.var_b52c4a7b = doa_enemy::function_d7c5adee("margwa");
  }

  var_f89c12f1 = [];

  if(!isDefined(var_f89c12f1)) {
    var_f89c12f1 = [];
  } else if(!isarray(var_f89c12f1)) {
    var_f89c12f1 = array(var_f89c12f1);
  }

  var_f89c12f1[var_f89c12f1.size] = doa_enemy::function_db55a448(level.doa.var_b52c4a7b, level.doa.var_6d072a34.origin);
  var_58d08b46 = math::clamp(level.doa.var_6c58d51, 0, 6);

  if(var_58d08b46 > 0) {
    if(!isDefined(level.doa.var_de4248da)) {
      level.doa.var_de4248da = array(doa_enemy::function_d7c5adee("margwa"), doa_enemy::function_d7c5adee("blight_father"), doa_enemy::function_d7c5adee("werewolf"), doa_enemy::function_d7c5adee("gegenees"));
    }

    while(var_58d08b46) {
      if(!isDefined(var_f89c12f1)) {
        var_f89c12f1 = [];
      } else if(!isarray(var_f89c12f1)) {
        var_f89c12f1 = array(var_f89c12f1);
      }

      var_f89c12f1[var_f89c12f1.size] = doa_enemy::function_db55a448(level.doa.var_de4248da[randomint(level.doa.var_de4248da.size)], [[level.doa.var_39e3fa99]] - > function_70fb5745().origin);
      var_58d08b46--;
    }
  }

  foreach(boss in var_f89c12f1) {
    if(is_true(level.var_a095060b)) {
      boss thread namespace_ec06fe4a::function_3b3bb5c(0.1, 600);
    }
  }

  while(true) {
    function_1eaaceab(var_f89c12f1);

    if(var_f89c12f1.size == 0) {
      break;
    }

    wait 2;
  }
}

function function_382bc607() {
  origin = [[level.doa.var_39e3fa99]] - > getcenter();
  struct = struct::get([[level.doa.var_39e3fa99]] - > getname() + "_challenge", "targetname");
  level.doa.var_6d072a34 = isDefined(struct) ? struct : origin;

  if(!isDefined(level.doa.var_59bbfb44)) {
    level.doa.var_59bbfb44 = doa_enemy::function_d7c5adee("gegenees");
  }

  var_f8ff628e = doa_enemy::function_db55a448(level.doa.var_59bbfb44, level.doa.var_6d072a34.origin);

  if(isDefined(var_f8ff628e)) {
    if(is_true(level.var_a095060b)) {
      var_f8ff628e thread namespace_ec06fe4a::function_3b3bb5c(0.1, 600);
    }

    var_f8ff628e waittill(#"death");
  }

  namespace_8c04284b::function_c8462f96();
  level namespace_ec06fe4a::function_de70888a();
}