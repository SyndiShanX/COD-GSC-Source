/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_59a48734035ff34d.gsc
*************************************************/

#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace namespace_d0fc9ba845d3f014;

function init(var_c8fe12c76b06111e, activityinstance) {
  if(!isDefined(var_c8fe12c76b06111e)) {
    return;
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("entless_trap_defuse_object", &function_836cdac4b1d38941);
  scripts\engine\scriptable::scriptable_adddamagedcallback(&function_2a19c46ce6857095);

  foreach(trap in var_c8fe12c76b06111e) {
    angles = (0, 0, 0);

    if(isDefined(trap.angles)) {
      angles = trap.angles;
    }

    trap.var_33e966146e01b39a = trap.origin + anglesToForward(angles) * 0.5 + anglestoup(angles) * 3.5;
    trap.var_bb7aa8ce4dd0428f = trap.var_33e966146e01b39a + anglestoleft(angles) * 200;

    if(isDefined(activityinstance)) {
      trap.activityref = activityinstance;
    }

    trap setscriptablepartstate("entless_trap_defuse_object", "active");
    trap setscriptablepartstate("explosive_base", "healthy");
    trap thread detectplayer();
  }
}

function create_laser_trap() {
  struct = self;
  angles = (0, 0, 0);

  if(isDefined(struct.angles)) {
    angles = struct.angles;
  }

  trap = spawnscriptable("entless_lasertrap", struct.origin, angles);
  return trap;
}

function function_836cdac4b1d38941(instance, part, state, player, bautouse, usestring) {
  if(part == "entless_trap_defuse_object") {
    function_de1ff0b717ef1a19(instance);
  }
}

function function_de1ff0b717ef1a19(var_8b429ec000467dcb, var_130c845ace729a7e) {
  assert(isDefined(var_8b429ec000467dcb), "<dev string:x1c>");
  assert(var_8b429ec000467dcb getscriptablehaspart("<dev string:x65>"));
  current_state = var_8b429ec000467dcb getscriptablepartstate("entless_trap_defuse_object");

  if(isDefined(current_state) && current_state != "disabled") {
    if(!istrue(var_130c845ace729a7e)) {
      playsoundatpos(var_8b429ec000467dcb.origin, "cp_laser_disable");
    }

    var_8b429ec000467dcb notify("destroyed");
    var_8b429ec000467dcb setscriptablepartstate("entless_trap_defuse_object", "disabled");
    var_8b429ec000467dcb setscriptablepartstate("explosive_base", "off");
  }
}

function function_1de2b98e5b1f0590(einflictor, rangeoverride) {
  instance = self;
  instance notify("destroyed");
  instance.destroyed = 1;
  instance setscriptablepartstate("entless_trap_defuse_object", "disabled");
  mindamage = getdvarint(@ "hash_ea6e58c378d245e5", 133);
  maxdamage = getdvarint(@ "hash_d5ff13fe4588f203", 666);
  traprange = ter_op(isDefined(rangeoverride), rangeoverride, getdvarint(@ "hash_db8f6fd15e9a7db6", 256));
  waittillframeend();
  attacker = einflictor;

  if(isDefined(instance.activityref) && isDefined(instance.activityref.agents)) {
    foreach(agent in instance.activityref.agents) {
      if(isDefined(agent)) {
        attacker = agent;
        break;
      }
    }
  }

  radiusdamage(instance.origin, traprange, maxdamage, mindamage, attacker, "MOD_EXPLOSIVE");
}

function function_2a19c46ce6857095(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(!is_equal(instance.type, "entless_lasertrap") || istrue(instance.destroyed)) {
    return;
  }

  var_a1acf2297da3341f = getdvarint(@ "hash_38407fe4a9acdba9", 50);
  instance thread function_1de2b98e5b1f0590(einflictor, var_a1acf2297da3341f);
}

function trigger_trap(player) {
  trap = self;

  if(isDefined(player) && isPlayer(player)) {
    if(player isufo()) {
      return 0;
    }

    player.var_230a3287f9ad2965 = 1;
    player.shouldskipdeathsshield = 1;
  }

  trap setscriptablepartstate("explosive_base", "explode");
  trap thread function_1de2b98e5b1f0590(player);
}

function detectplayer() {
  self notify("entless_laser_traps_detectPlayer");
  self endon("entless_laser_traps_detectPlayer");
  level endon("game_ended");
  self endon("destroyed");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  var_4a5d9d7667048bf3 = scripts\engine\trace::create_character_contents();
  var_71fcc381ba289efb = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 1);

  while(true) {
    start = self.var_33e966146e01b39a;
    nearby_players = sortbydistancecullbyradius(level.players, start, 1024);

    if(nearby_players.size == 0) {
      waitframe();
      continue;
    }

    trace = scripts\engine\trace::ray_trace(start, self.var_bb7aa8ce4dd0428f, [], var_71fcc381ba289efb);

    if(isDefined(trace["entity"]) && trace["hittype"] == "hittype_entity") {
      if(isPlayer(trace["entity"])) {
        player = trace["entity"];
        detonated = trigger_trap(player);
        return;
      }
    }

    end = trace["position"];

    if(getdvarint(@ "hash_388b2c9297bbe819", 0) != 0) {
      line(start, end, (1, 0, 0), 1, 0, 1);
    }

    trace = scripts\engine\trace::ray_trace(start, end, [], var_4a5d9d7667048bf3);

    if(isDefined(trace["entity"]) && trace["hittype"] == "hittype_entity") {
      if(isPlayer(trace["entity"])) {
        player = trace["entity"];
        eyepos = player getEye();

        if(trace["position"][2] <= eyepos[2]) {
          detonated = trigger_trap(player);
          return;
        }
      }
    }

    waitframe();
  }
}