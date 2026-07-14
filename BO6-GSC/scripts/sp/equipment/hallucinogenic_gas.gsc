/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\hallucinogenic_gas.gsc
*******************************************************/

#using scripts\anim\face;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\animbank;
#using scripts\common\shellshock_utility;
#using scripts\common\system;
#using scripts\engine\hud_management;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#namespace hallucinogenic_gas;

function private autoexec __init__system__() {
  system::register(#"hallucinogenic_gas", undefined, &pre_main, undefined);
}

function private pre_main() {
  offhands::registerprecachefunc("hQ\xf2xq\x97\xfa\xbb[\x9bg\x1bX\x90\x9c\x89Q\x1d", &precache);
}

function precache(offhand) {
  offhands::registeroffhandfirefunc(offhand, &function_27a6f41ca3dc9747);
}

function function_27a6f41ca3dc9747(grenade, weapon) {
  grenadeowner = self;

  if(isDefined(level.battlechatter)) {
    function_99e8e66d1969d7cb(grenadeowner, undefined, "\x9e\x19\xa8K\xf6\xfc3<R\xc1\xd4\xbay", "~\xb6\xb6\x88e\xbb$gz\xed'\xb6\x14");
  }

  grenade waittill("*\x83\xc10XI\x1e", grenadeorigin);
  earthquake(0.25, 0.35, grenadeorigin, 1000);
  playrumbleonposition("R\xd3\xafp\xb0w(\x97]l4rp\x9f", grenadeorigin);
  explode_time = gettime();
  gas_duration = 5000;
  start_radius = squared(128);
  end_radius = squared(768);
  effect_radius = 262144;

  if(!isDefined(level.var_311bb263b4bdacda)) {
    level.var_311bb263b4bdacda = 0;
  }

  enemies = getaiarray("?\xb1\xc0\x9a");

  foreach(enemy in enemies) {
    enemydistsquared = distancesquared(enemy.origin, grenadeorigin);
    hasstealth = isDefined(enemy.stealth);
    incombat = isDefined(enemy.fnisinstealthcombat) && enemy[[enemy.fnisinstealthcombat]]();

    if(hasstealth && !incombat && enemydistsquared <= 1048576) {
      event = spawnStruct();
      event.typeorig = "+\x1e\x1c\xd8\xbds\xd2{\xb9";
      event.type = "\x8e\x86U\b\xe9s\xa7\xb1\x87\x99\xb9";
      event.entity = level.player;
      event.origin = grenadeorigin;
      event.investigate_pos = grenadeorigin;
      enemy[[enemy.fnsetstealthstate]]("\x11t\x12\x1a", event);
    }

    if(enemydistsquared <= 262144) {
      enemy face::saygenericdialogue("\x1b\xb7\xd5;\x1a\xeb\xccZ\x8e");

      if(!isDefined(enemy.stealth)) {
        enemy aieventlistenerevent("+\x1e\x1c\xd8\xbds\xd2{\xb9", self, grenadeorigin);
      }
    }
  }

  gas_tracker = spawnStruct();
  gas_tracker.count = 0;
  gas_tracker.active = 1;

  while(true) {
    current_duration = gettime() - explode_time;

    if(current_duration >= gas_duration) {
      gas_tracker.active = 0;
      return;
    }

    playerdistancesquared = distancesquared(level.player.origin, grenadeorigin);

    if(!istrue(level.player function_e79fa57f21de336d()) && !level.player utility::ent_flag("T\xfc\xb0gk!\".\x1c\n\v\x19\x03-$") && playerdistancesquared <= 147456) {
      level.player thread player_hallucinate(grenadeorigin, gas_tracker);
    }

    var_95a54a334d749fdd = getaiarrayinradius(grenadeorigin, 1024, "?\xb1\xc0\x9a");
    var_c692ebdd3e7caf81 = getaiarrayinradius(grenadeorigin, 512, "?\xb1\xc0\x9a");
    var_c692ebdd3e7caf81 = sortbydistance(var_c692ebdd3e7caf81, grenadeorigin);
    var_ec06dc7d974cd8b5 = int(min(5, var_95a54a334d749fdd.size * 0.5));

    for(i = 0; i < var_c692ebdd3e7caf81.size; i++) {
      enemy = var_c692ebdd3e7caf81[i];

      if(isDefined(enemy) && isalive(enemy)) {
        if(enemy utility::ent_flag("T\xfc\xb0gk!\".\x1c\n\v\x19\x03-$")) {
          waitframe();
          continue;
        }

        if(gas_tracker.count > var_ec06dc7d974cd8b5) {
          waitframe();
          continue;
        }

        if(!enemy utility::ent_flag("\xd1<\x06p\x82\x97c\xd4\xdd\xc2\x99\xd2\xec\xfd\xccP$\xde6")) {
          if(gas_tracker.count > int(var_ec06dc7d974cd8b5 * 0.5)) {
            if(enemy utility::ent_flag("gh\x15\xf1Yi\x84\x96\x89\xa4\x992\xe94\xce") || utility::cointoss()) {
              waitframe();
              continue;
            }
          }
        }

        if(!istrue(enemy function_e79fa57f21de336d())) {
          enemy thread ai_hallucinate(grenadeorigin);
          enemy thread function_14c2a0cc30f8fad(gas_tracker);
          level.var_311bb263b4bdacda++;
          gas_tracker.count++;
        }

        wait 0.1;
      }
    }

    wait 0.5;
  }
}

function function_e734af524233d5f4(origin) {
  thread ai_hallucinate(origin);
}

function private function_14c2a0cc30f8fad(gas_tracker) {
  self waittill("\x1e\xfd\xd1\xa2\a");
  wait randomfloatrange(0.5, 1.5);
  level.var_311bb263b4bdacda--;

  if(isDefined(gas_tracker)) {
    gas_tracker.count--;
  }
}

function private ai_hallucinate(grenadeorigin) {
  assert(isactor(self));
  actor = self;
  actor endon("\x1e\xfd\xd1\xa2\a");

  if(istrue(actor function_e79fa57f21de336d())) {
    return;
  }

  actor.var_ce24a06b79999621 = 1;
  actor.originalteam = actor.team;
  wait 0.5;
  actor setcanusecover(0);
  duration = randomfloatrange(1.5, 4.5);
  actor notify("f\x8d,nh\xc4\v\xb9\xb3", (0, 0, 0), 1, 1, level.player, "O\x15\x1b\xad\x9ff", duration);
  grenadelength = animbank::get_length("\xdb\x82\vO\x92\xdb)=s\x86\x93\xaa7\x89X;7\xb8^\xac\xca\x15=\xc9nx\xbbR\xd3\x11x", ",\xe1\x93So\x98\r", 0);
  totalwaittime = grenadelength + utility::function_7db7b41478a3232a(30000);
  actor thread function_9766768fca032a15(30000);
  actor thread makevulnerable();
  actor thread makeberserk();
  actor.og_goalradius = actor.goalradius;
  actor.balwayscoverexposed = 1;
  actor setcanusecover(0);
  actor allowedstances("\x8b\x90\xb5\xc4W");
  actor.dontmelee = 1;
  actor.cannotmelee = 1;
  actor.og_grenadeammo = actor.grenadeammo;
  actor.grenadeammo = 0;
  actor setbtgoalpos(4, actor.origin);
  actor setbtgoalRadius(4, 12);
  target = switchtonearesttarget();

  if(isDefined(actor.pacifist)) {
    actor.og_pacifist = actor.pacifist;
    actor utility_sp::set_pacifist(0);
  }

  if(isDefined(actor.ignoreall)) {
    actor.og_ignoreall = actor.ignoreall;
    actor ai::set_ignoreall(0);
  }

  endtime = gettime() + 30000;

  while(gettime() < endtime) {
    waitframe();

    if(!isalive(target)) {
      target = actor switchtonearesttarget();
    }

    if(actor utility::ent_flag("T\xfc\xb0gk!\".\x1c\n\v\x19\x03-$")) {
      break;
    }

    if(!istrue(actor function_e79fa57f21de336d())) {
      break;
    }
  }

  actor.var_ce24a06b79999621 = 0;
  actor.team = actor.originalteam;

  if(actor.originalteam == "?\xb1\xc0\x9a") {
    actor.skip_friendly_fire_check = undefined;
  }

  actor setcanusecover(1);

  if(isDefined(actor.og_pacifist)) {
    actor utility_sp::set_pacifist(actor.og_pacifist);
  }

  if(isDefined(actor.og_ignoreall)) {
    actor ai::set_ignoreall(actor.og_ignoreall);
  }

  actor notify("\xa1\xca\xde|xg-I\x827\xcfJ9\xb2ij");
  actor.grenadeammo = actor.og_grenadeammo;
  actor.goalradius = actor.og_goalradius;
  actor.balwayscoverexposed = 0;
  actor setcanusecover(1);
  actor allowedstances("\x8b\x90\xb5\xc4W", "1x\xc5\xb4\xabx", "GX\xa9]\x82");
  actor.dontmelee = 0;
  actor.cannotmelee = 0;
  actor clearanim(actor asm::asm_getroot(), 0.2);
  actor.favoriteenemy = undefined;
  actor clearbtgoal(4);

  if(!actor utility::ent_flag("T\xfc\xb0gk!\".\x1c\n\v\x19\x03-$")) {
    actor utility::ent_flag_set("gh\x15\xf1Yi\x84\x96\x89\xa4\x992\xe94\xce");
  }

  flash_time = randomfloatrange(5, 10);
  actor notify("f\x8d,nh\xc4\v\xb9\xb3", grenadeorigin, 1, 1, level.player, "O\x15\x1b\xad\x9ff", flash_time);
}

function private makevulnerable() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xa1\xca\xde|xg-I\x827\xcfJ9\xb2ij");
  utility_sp::set_attackeraccuracy(0.5);
  wait utility::function_7db7b41478a3232a(10000);
  count = 0;

  while(istrue(function_e79fa57f21de336d())) {
    newmaxhealth = int(max(self.maxhealth * 0.5 + 1, 1));
    self.maxhealth = newmaxhealth;
    newattackeraccuracy = int(min(count * 2 + 1, 10));
    utility_sp::set_attackeraccuracy(1 + newattackeraccuracy);
    count++;
    wait randomfloatrange(4, 6);
  }
}

function private makeberserk() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xa1\xca\xde|xg-I\x827\xcfJ9\xb2ij");
  wait utility::function_7db7b41478a3232a(15000);
  newgoalradius = 768;
  og_favoriteenemy = undefined;

  while(istrue(function_e79fa57f21de336d())) {
    if(isDefined(self.favoriteenemy)) {
      if(!isDefined(og_favoriteenemy)) {
        og_favoriteenemy = self.favoriteenemy;
      } else if(self.favoriteenemy != og_favoriteenemy) {
        og_favoriteenemy = self.favoriteenemy;
        newgoalradius = 768;
      }

      pos = self getclosestreachablepointonnavmesh(self.favoriteenemy.origin);
      newgoalradiussq = squared(newgoalradius);

      if(distance2dsquared(pos, self.favoriteenemy.origin) < newgoalradiussq) {
        self.goalradius = newgoalradius;
        self setgoalentity(self.favoriteenemy);
        newgoalradius = max(256, newgoalradius - 128);
      }
    }

    wait randomfloatrange(5, 10);
  }
}

function private function_9766768fca032a15(totalwaittime) {
  self endon("\x1e\xfd\xd1\xa2\a");
  ai = self;
  widget_struct = spawnStruct();
  widget_struct.param = "b\xfc,\xe8\xb9\x12k{\x87\\CKK\x0f\xcf.\n\xd2\xaa";
  level.player hud_management::function_f084d4c0fc5a8b4b(ai, "\xee\xde\xff\f\xea\xf0\x82\x01\xcd}\xf7\x8a8\x13#\xc7\xbf\xfbN\xc0\xe0\xb3\x9a\x9f\xc7\x9c\aE", "9\xcd\x99\r\x0f6i\x18\x0f\xa9\x1d\xc7M\xf8\x82`\x91\xdc\xcd\xbf2\x1e\xb8\x05\xb3\xb0\xb4;\xc0\xf7\xee\x12\xa9\x14<\x1bRw\xd2\x9f\x11:\xe4\\\xee<", "9\xcd\x99\r\x0f6i\x18\x0f\xa9\x1d\xc7M\xf8\x82`\x9f\xdf\xcb\x8b.\t@\x0e!\xa6\xac\x1aH\xf2+\x12\xf5\xc5~\x1f\xde5J\x02\xc0\x1b\xc4\xc5~~", widget_struct);
  fields = [];
  fields["\x92\xd3\x9f\xbb"] = totalwaittime;
  level.player hud_management::function_282d7915f90d757c(ai, "\xee\xde\xff\f\xea\xf0\x82\x01\xcd}\xf7\x8a8\x13#\xc7\xbf\xfbN\xc0\xe0\xb3\x9a\x9f\xc7\x9c\aE", fields);
  ai utility::waittill_any_timeout(totalwaittime, "\xafYgV\xa2`\xa2D\xa8\x96na\x99G7\x90-of", "\x1e\xfd\xd1\xa2\a");
  level.player hud_management::function_5e19eeec60f33c1e(ai, "\xee\xde\xff\f\xea\xf0\x82\x01\xcd}\xf7\x8a8\x13#\xc7\xbf\xfbN\xc0\xe0\xb3\x9a\x9f\xc7\x9c\aE");
}

function private switchtonearesttarget() {
  assert(isactor(self));
  actor = self;
  target = level.player;
  ais = getaiarrayinradius(actor.origin, 768, actor.team);

  if(ais.size > 1) {
    ais = sortbydistance(ais, actor.origin);
    target = ais[1];
  } else {
    ais = getaiarrayinradius(actor.origin, 1024);

    if(ais.size > 1) {
      ais = sortbydistance(ais, actor.origin);
      target = ais[1];
    }
  }

  assert(isDefined(target));

  if(target.team == "?\xb1\xc0\x9a") {
    actor.team = "O\x15\x1b\xad\x9ff";
    actor.skip_friendly_fire_check = 1;
  } else {
    actor.team = "?\xb1\xc0\x9a";
  }

  actor.favoriteenemy = target;
  return target;
}

function private player_hallucinate(grenadeorigin, gas_tracker) {
  if(!isalive(level.player)) {
    return;
  }

  level.player endon("\x1e\xfd\xd1\xa2\a");
  traceoffset = (0, 0, 18);

  if(!trace::ray_trace_passed(level.player.origin + traceoffset, grenadeorigin + traceoffset, level.player)) {
    return;
  }

  if(level.player isweaponsenabled() && isDefined(level.player.currentweapon) && level.player.currentweapon.basename != "\r+x5") {
    level.player forceplaygestureviewmodel("dM\x8636\xfd\r\x13\xf1G\v\xcf\xa5\xb4o_\x87\xe7?\xa1\x84\xa3", undefined, 0.5, 0, 1, 0);
  }

  level thread function_887b49838059159f(grenadeorigin, gas_tracker);
}

function private function_887b49838059159f(grenadeorigin, gas_tracker) {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  level.player.var_ce24a06b79999621 = 1;
  starttime = gettime();
  playerinradius = 0;
  var_39ec26b3447f0678 = 0;

  while(!utility::time_has_passed(starttime, 10)) {
    if(!istrue(level.player function_e79fa57f21de336d())) {
      break;
    }

    if(level.player function_931c1b3c83efdbd9()) {
      break;
    }

    shockassetname = % "cer_gas_trap_light_mp";

    if(istrue(gas_tracker.active)) {
      playerinradius = distancesquared(level.player.origin, grenadeorigin) <= 147456;

      if(istrue(playerinradius)) {
        shockassetname = % "cer_gas_trap_heavy_mp";

        if(!istrue(var_39ec26b3447f0678)) {
          visionsetnaked(";\x85\xb9_:'\xc2\x83", 0.2);
          var_39ec26b3447f0678 = 1;
        }
      }
    } else if(istrue(var_39ec26b3447f0678)) {
      visionsetnaked("", 0.2);
      var_39ec26b3447f0678 = 0;
    }

    level.player shellshock_utility::_shellshock(shockassetname, #"gas", 0.5, 0);
    wait 0.2;
  }

  level thread function_dca387284aa11e1f();
}

function private function_dca387284aa11e1f() {
  pbgpostfxbundleend(level.player, %"hash_791d997365b2ff35");
  level.player shellshock_utility::_stopshellshock();
  visionsetnaked("", 0.2);
  level.player.var_ce24a06b79999621 = 0;
}

function function_d017f3f3be6e4de9(grenadeorigin) {
  assert(isDefined(self) && isalive(self), "<dev string:x24>");

  if(!isDefined(grenadeorigin)) {
    grenadeorigin = self.origin;
  }

  if(!istrue(function_e79fa57f21de336d())) {
    if(isPlayer(self)) {
      thread player_hallucinate(grenadeorigin);
      return;
    }

    thread ai_hallucinate(grenadeorigin);
    thread function_14c2a0cc30f8fad();
    level.var_311bb263b4bdacda++;
  }
}

function function_1cffad9f507c7a71() {
  assert(isDefined(self) && isalive(self), "<dev string:x61>");

  if(istrue(function_e79fa57f21de336d())) {
    self.var_ce24a06b79999621 = 0;
  }
}

function function_e79fa57f21de336d() {
  assert(isDefined(self) && isalive(self), "<dev string:x9d>");
  return self.var_ce24a06b79999621;
}

function function_846557f30dd36585(hgrenade_immune = 1) {
  assert(isDefined(self) && isalive(self), "<dev string:xdd>");

  if(istrue(hgrenade_immune)) {
    utility::ent_flag_clear("\xd1<\x06p\x82\x97c\xd4\xdd\xc2\x99\xd2\xec\xfd\xccP$\xde6", 1);
    utility::ent_flag_clear("gh\x15\xf1Yi\x84\x96\x89\xa4\x992\xe94\xce", 1);
    utility::ent_flag_set("T\xfc\xb0gk!\".\x1c\n\v\x19\x03-$");
    return;
  }

  utility::ent_flag_clear("T\xfc\xb0gk!\".\x1c\n\v\x19\x03-$", 1);
}

function function_931c1b3c83efdbd9() {
  assert(isDefined(self) && isalive(self), "<dev string:x12b>");
  return utility::ent_flag("T\xfc\xb0gk!\".\x1c\n\v\x19\x03-$");
}

function function_d6db2ecb75878d96(hgrenade_resist = 1) {
  assert(isDefined(self) && isalive(self), "<dev string:x174>");

  if(istrue(hgrenade_resist)) {
    utility::ent_flag_clear("\xd1<\x06p\x82\x97c\xd4\xdd\xc2\x99\xd2\xec\xfd\xccP$\xde6", 1);
    utility::ent_flag_clear("T\xfc\xb0gk!\".\x1c\n\v\x19\x03-$", 1);
    utility::ent_flag_set("gh\x15\xf1Yi\x84\x96\x89\xa4\x992\xe94\xce");
    return;
  }

  utility::ent_flag_clear("gh\x15\xf1Yi\x84\x96\x89\xa4\x992\xe94\xce", 1);
}

function function_8adb5d93d3b49ec2() {
  assert(isDefined(self) && isalive(self), "<dev string:x1c2>");
  return utility::ent_flag("gh\x15\xf1Yi\x84\x96\x89\xa4\x992\xe94\xce");
}

function function_7ed139d5ace7bf5c(hgrenade_vulnerable = 1) {
  assert(isDefined(self) && isalive(self), "<dev string:x20f>");

  if(istrue(hgrenade_vulnerable)) {
    utility::ent_flag_clear("gh\x15\xf1Yi\x84\x96\x89\xa4\x992\xe94\xce", 1);
    utility::ent_flag_clear("T\xfc\xb0gk!\".\x1c\n\v\x19\x03-$", 1);
    utility::ent_flag_set("\xd1<\x06p\x82\x97c\xd4\xdd\xc2\x99\xd2\xec\xfd\xccP$\xde6");
    return;
  }

  utility::ent_flag_clear("\xd1<\x06p\x82\x97c\xd4\xdd\xc2\x99\xd2\xec\xfd\xccP$\xde6", 1);
}

function function_fa8a7225c96bb200() {
  assert(isDefined(self) && isalive(self), "<dev string:x261>");
  return utility::ent_flag("\xd1<\x06p\x82\x97c\xd4\xdd\xc2\x99\xd2\xec\xfd\xccP$\xde6");
}