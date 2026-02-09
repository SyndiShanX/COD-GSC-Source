/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\traps\_trap_airstrike.gsc
*****************************************************/

init() {
  precachelaser("trap_zm");
  precacheitem("trap_missile_zm_mp");
  precacheitem("orbitalsupport_missile_mp");
}

trap_airstrike_begin() {
  var_0 = [];
  var_1 = common_scripts\utility::getstructarray(self.target, "targetname");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.script_noteworthy)) {
      continue;
    }
    if(var_3.script_noteworthy == "trap_airstrike_target") {
      var_0 = common_scripts\utility::add_to_array(var_0, var_3);
    }
  }

  wait 3;

  for(var_5 = 0; var_5 < 12; var_5++) {
    var_0 = common_scripts\utility::array_randomize(var_0);
    var_0 = common_scripts\utility::array_sort_by_handler(var_0, ::zombies_in_strike_zone);
    var_0 = common_scripts\utility::array_reverse(var_0);
    var_6 = var_0[0];
    var_0 = common_scripts\utility::array_remove(var_0, var_6);
    thread trap_airstrike_fire_missile(var_6);
    wait(randomfloatrange(0.5, 1.5));
  }
}

zombies_in_strike_zone() {
  self.numzombies = 0;
  var_0 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
  var_0 = sortbydistance(var_0, self.origin, 384);
  self.numzombies = var_0.size;
  return self.numzombies;
}

trap_airstrike_fire_missile(var_0) {
  var_1 = (var_0.origin[0], var_0.origin[1], var_0.origin[2] + 8000);
  var_2 = magicbullet("trap_missile_zm_mp", var_1, var_0.origin, self.owner);
  var_2 thread trap_airstrike_laser(var_1, var_0.origin);
  var_2 thread trap_airstrike_damage_think(self.owner);
}

trap_airstrike_laser(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_3 = vectortoangles(var_1 - var_0);
  var_2.origin = var_0;
  var_2.angles = var_3;
  var_2.start_origin = var_0;
  var_2.start_angles = var_3;
  var_2 setModel("tag_laser");
  var_2 laseron("trap_zm");
  var_4 = spawnfx(common_scripts\utility::getfx("trap_airstrike_laser_target"), var_1, (0, 0, 90));
  triggerfx(var_4);
  self waittill("death");
  var_2 delete();
  var_4 delete();
}

trap_airstrike_damage_think(var_0) {
  self waittill("death");
  var_1 = self.origin;
  thread trap_airstrike_radius_damage(var_1);
  physicsexplosionsphere(var_1, 512, 64, randomfloatrange(2, 5));
  earthquake(0.3, 0.5, var_1, 400);
  playrumbleonposition("artillery_rumble", var_1);
}

trap_airstrike_radius_damage(var_0) {
  wait 0.05;
  var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
  var_2 = sortbydistance(var_1, var_0, 384);
  var_3 = sortbydistance(var_2, var_0, 128);

  foreach(var_5 in var_2) {
    if(isDefined(var_5.agentteam) && var_5.agentteam == level.playerteam) {
      if(common_scripts\utility::array_contains(var_3, var_5) && var_5.health > 1) {
        var_5 dodamage(1, var_0);
      }

      continue;
    }

    if(isPlayer(var_5)) {
      if(!maps\mp\zombies\_util::isplayerinlaststand(var_5)) {
        if(common_scripts\utility::array_contains(var_3, var_5)) {
          var_6 = var_5.health * 0.5;

          if(var_6 > 20) {
            var_6 = 20;
          }

          var_5 dodamage(var_6, var_0);
        } else if(var_5.health > 1) {
          var_5 dodamage(1, var_0);
        }
      }

      continue;
    }

    if(var_5 maps\mp\zombies\_util::istrapresistant()) {
      if(common_scripts\utility::array_contains(var_3, var_5)) {
        var_7 = 0.5;
      } else {
        var_7 = 0.1;
      }

      var_6 = var_5.health * var_7;

      if(isDefined(var_5.maxhealth)) {
        var_6 = var_5.maxhealth * var_7;
      }
    } else if(common_scripts\utility::array_contains(var_3, var_5)) {
      var_6 = var_5.health + 10;

      if(isDefined(var_5.maxhealth)) {
        var_6 = var_5.maxhealth + 10;
      }
    } else {
      var_6 = var_5.health * 0.5;

      if(isDefined(var_5.maxhealth)) {
        var_6 = var_5.maxhealth * 0.5;
      }
    }

    var_5 dodamage(var_6, var_0, self.owner, self.owner, "MOD_EXPLOSIVE", "trap_missile_zm_mp");
  }
}