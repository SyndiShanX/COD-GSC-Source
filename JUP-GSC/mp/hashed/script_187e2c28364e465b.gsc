/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_187e2c28364e465b.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#using scripts\mp\utility\points;
#namespace wm_zombie;

function init() {
  if(getdvarint(@ "hash_1196c97cf6cee66e", 0)) {
    function_c601738431d10af5();
    level.var_57ebe7619b06b864 = getdvarint(@ "hash_8db2a71a503618ca", 150);

    level thread function_7f6e135f90bd62a0();
  }
}

function function_4fa29d44e69039cb(origin, angles) {
  zombie_agent = scripts\mp\mp_agent::spawnnewagentaitype("actor_jup_spawner_zombie_base_wm", origin, angles, "team_two_hundred");

  if(isDefined(zombie_agent)) {
    if(istrue(level.var_2b3c3eb6681278d6)) {
      zombie_agent thread function_346d8332b7c75c38();
    }

    if(isDefined(level.var_57ebe7619b06b864)) {
      zombie_agent.maxhealth = level.var_57ebe7619b06b864;
      zombie_agent.health = zombie_agent.maxhealth;
    }

    zombie_agent callback::add("on_zombie_ai_killed", &function_2e97441e00b9a886);
  }

  return zombie_agent;
}

function function_2e97441e00b9a886(params) {
  if(isDefined(params.eattacker) && isDefined(params.smeansofdeath) && params.smeansofdeath != "MOD_SUICIDE") {
    player = undefined;

    if(isPlayer(params.eattacker)) {
      player = params.eattacker;
    } else if(isDefined(params.eattacker.owner) && isPlayer(params.eattacker.owner)) {
      player = params.eattacker.owner;
    }

    if(isDefined(player)) {
      player points::doscoreevent(#"zombie_kia");
    }
  }
}

function function_346d8332b7c75c38() {
  self endon("death");
  var_f43f4f0822bef9f1 = randomfloat(2);
  wait var_f43f4f0822bef9f1;

  while(true) {
    pinglocationenemyteams(self.origin, "axis");
    pinglocationenemyteams(self.origin, "allies");
    wait 3;
  }
}

function function_ce8588d31df66dd8(origin, angles, disable_physics) {
  var_6b8ae74960e802f2 = ter_op(istrue(disable_physics), 1, 0);
  return utility::function_ec8a443fe8165fe4("jup_pi_raygun_mp", origin, [], angles, var_6b8ae74960e802f2);
}

function function_c601738431d10af5() {
  if(!isDefined(level.var_f1339ee09ea219d8)) {
    level.var_f1339ee09ea219d8 = [];
  }

  level.var_f1339ee09ea219d8 = array_add(level.var_f1339ee09ea219d8, "jup_pi_raygun_mp");
  level.var_517ae1797c9e1995 = &function_aa2be556dc1c242;
}

function function_aa2be556dc1c242(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon) {
  if(isDefined(objweapon)) {
    if(objweapon.basename == "jup_pi_raygun_mp" && is_equal(eattacker, victim)) {
      return 15;
    }
  }

  return idamage;
}

function private function_7f6e135f90bd62a0() {
  while(true) {
    zombie_dvar = getdvarint(@ "hash_79fb288119ec1063", 0);

    if(zombie_dvar) {
      setDvar(@ "hash_79fb288119ec1063", 0);
      origin = function_9b4c82dba041b23d();
      function_4fa29d44e69039cb(origin, (0, 0, 0));
    }

    raygun_dvar = getdvarint(@ "hash_8234e6abb2fdcfc7", 0);

    if(raygun_dvar) {
      setDvar(@ "hash_8234e6abb2fdcfc7", 0);
      origin = function_9b4c82dba041b23d();
      function_ce8588d31df66dd8(origin, (0, 0, 0));
    }

    wait 1;
  }
}

# /