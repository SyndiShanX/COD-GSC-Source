/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\spycam.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\hud_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\weapon;
#namespace spycam;

function autoexec main() {
  level._effect["vfx_spycam_flash"] = loadfx("vfx/t10/core/equipment/vfx_equip_spy_camera_flash.vfx");
}

function function_ba4f176b24eb2f54(grenade) {
  ref = scripts\cp_mp\equipment::function_7f245729fcb6414d(grenade.weapon_name);
  grenade.tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);

  if(!isDefined(grenade.tableinfo.bundle)) {
    assertmsg("<dev string:x1c>");
  }

  grenade.owner thread function_9aeb6df65448c679(grenade);
}

function function_4e66f81e9876bea5() {
  thread function_3a92f9c9d2238aaa(0.05);
}

function function_3a92f9c9d2238aaa(deletiondelay) {
  self notify("death");
  wait deletiondelay;

  if(isDefined(self)) {
    self delete();
  }
}

function function_9aeb6df65448c679(spycam) {
  self endon("death");
  self endon("disconnect");
  var_dd44977fb56bb74d = self function_6b85f728c99dd393();
  maxdist = default_to(spycam.tableinfo.bundle.var_9f11de6722b51256, 2000);
  maxtargets = default_to(spycam.tableinfo.bundle.var_e5abc0f581c07f40, 5);
  markradius = default_to(spycam.tableinfo.bundle.var_936f9dcb5700c93, 250);
  markfov = self function_a2882c2e9c3b3773();
  var_bc6fbc429f3b60b1 = 2 | 131072 | 16 | 2048 | 16384;
  ents = self function_c5140fff72feca2d(maxdist, markfov, var_bc6fbc429f3b60b1, 0);
  targets = [];

  foreach(ent in ents) {
    if(!isDefined(ent)) {
      continue;
    }

    if(ent == self || ent == spycam) {
      continue;
    }

    if(isDefined(ent.spycamdebuff)) {
      continue;
    }

    isplayertarget = 0;
    marktarget = 0;

    if(isagent(ent) || isPlayer(ent)) {
      if(ent hasperk("specialty_noscopeoutline")) {
        continue;
      }

      marktarget = 1;
      isplayertarget = 1;
      ent notify("spycam_marked");
    } else if(isDefined(ent.streakname)) {
      marktarget = 1;
    } else {
      if(!isDefined(ent.weapon_name)) {
        continue;
      }

      equipmenttype = scripts\mp\utility\weapon::getweapontype(ent.weapon_name);

      if(isDefined(equipmenttype)) {
        if(equipmenttype == "lethal" || equipmenttype == "tactical" || equipmenttype == "super") {
          marktarget = 1;
        }
      }
    }

    if(marktarget) {
      if(level.teambased) {
        if(self.team == ent.team) {
          continue;
        }
      }

      isvisible = spycam function_bea67d26e9b43209(ent, var_dd44977fb56bb74d);
      isinreticle = function_2495d714d2a215ad(ent, markfov, markradius);

      if(isvisible && isinreticle) {
        targetstruct = spawnStruct();
        targetstruct.ent = ent;
        targetstruct.isplayertarget = isplayertarget;
        playertoenemy = ent.origin - self getEye();
        targetstruct.dist = abs(vectordot(anglestoright(self getplayerangles()), playertoenemy));

        if(targets.size < maxtargets) {
          targets[targets.size] = targetstruct;
          continue;
        }

        maxdistance = targetstruct.dist;
        maxdistanceindex = 0;
        marktarget = 0;

        for(i = 0; i < targets.size; i++) {
          if(targets[i].dist > maxdistance) {
            maxdistance = targets[i].dist;
            maxdistanceindex = i;
            marktarget = 1;
          }
        }

        if(marktarget) {
          targets[maxdistanceindex] = targetstruct;
        }
      }
    }
  }

  if(targets.size == 0) {
    ref = spycam.tableinfo.ref;
    currentammo = scripts\cp_mp\equipment::getequipmentammo(ref);
    scripts\cp_mp\equipment::setequipmentammo(ref, currentammo + 1);
    self playlocalsound(isDefined(spycam.tableinfo.bundle.var_40d93f42db3bc962) ? spycam.tableinfo.bundle.var_40d93f42db3bc962 : "eqp_spycam_nomark", undefined, undefined, 1);
    scripts\mp\hud_message::showerrormessage("MP/NO_VALID_TARGETS");
  } else {
    playFXOnTag(getfx("vfx_spycam_flash"), spycam, "tag_fx");
    self playlocalsound("eqp_spycam_marked", undefined, undefined, 1);
    spycam function_a71f7b8d9c21d2ae(targets);
  }

  spycam function_4e66f81e9876bea5();
}

function function_a71f7b8d9c21d2ae(targets) {
  var_f7f98e87323ea94f = default_to(self.tableinfo.bundle.var_55330c96a554d828, 5);
  outlineduration = default_to(self.tableinfo.bundle.var_abe769977867a8a, 5);

  foreach(target in targets) {
    target.ent.spycamdebuff = 1;
    target.outlineid = scripts\mp\utility\outline::outlineenableforteam(target.ent, self.team, "spycam", "equipment");

    if(target.isplayertarget) {
      self.owner thread scripts\mp\utility\points::doscoreevent(#"hash_dc7164f56f09735");
      target.ent thread function_2eb2d3583b7c4407(var_f7f98e87323ea94f, self.owner);
    } else {
      self.owner thread scripts\mp\utility\points::doscoreevent(#"hash_1c18ff436ea31cd5");
      target.ent thread function_2a37dbf39464630c(var_f7f98e87323ea94f, self.owner);
    }

    target.ent thread function_9d4d2d7da0db21f3(var_f7f98e87323ea94f);
  }

  thread function_86a974a0b589e89(outlineduration, targets);
}

function function_86a974a0b589e89(outlineduration, targets) {
  wait outlineduration;

  foreach(target in targets) {
    if(isDefined(target.ent)) {
      scripts\mp\utility\outline::outlinedisable(target.outlineid, target.ent);
    }
  }
}

function function_9d4d2d7da0db21f3(var_f7f98e87323ea94f) {
  self endon("disconnect");
  result = waittill_notify_or_timeout_return("spycam_debuff_killed", var_f7f98e87323ea94f);

  if(result == "timeout") {
    self notify("spycam_debuff_expired");
  }

  if(isDefined(self.spycamdebuff)) {
    self.spycamdebuff = undefined;
  }
}

function function_2eb2d3583b7c4407(duration, owner) {
  self endon("disconnect");
  self endon("spycam_debuff_expired");
  thread function_ecb52768dc9c454();
  self waittill("death");

  if(scripts\cp_mp\utility\player_utility::playersareenemies(self, owner)) {
    owner thread scripts\mp\utility\points::doscoreevent(#"hash_cbe9f73b6b0cfe11");
  }

  self notify("spycam_debuff_killed");
}

function function_ecb52768dc9c454() {
  self endon("disconnect");
  self endon("spycam_debuff_expired");
  self endon("spycam_debuff_killed");
  markedlocation = self.origin;

  while(true) {
    pinglocationenemyteams(markedlocation, self.team, self, 1, 0);
    wait 0.5;
  }
}

function function_2a37dbf39464630c(duration, owner) {
  self endon("disconnect");
  self endon("spycam_debuff_expired");
  self waittill("enemy_destroyed_equipment", attacker);

  if(isDefined(attacker) && isDefined(attacker.team) && attacker.team == owner.team) {
    owner thread scripts\mp\utility\points::doscoreevent(#"hash_f0b95bafe4e2d9f0");
  }

  self notify("spycam_debuff_killed");
}

function function_bea67d26e9b43209(target, var_dd44977fb56bb74d) {
  if(!isDefined(target)) {
    return false;
  }

  tracecontents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  playerhead = self.owner scripts\mp\utility\player::getstancetop();
  defaultorigin = target.origin;
  tracepoints = [defaultorigin];

  if(isPlayer(target)) {
    headpos = (0, 0, 0);

    if(scripts\mp\utility\player::isreallyalive(target)) {
      headpos = target scripts\mp\utility\player::getstancetop();
    }

    centerpos = (0, 0, 0);

    if(scripts\mp\utility\player::isreallyalive(target)) {
      centerpos = target scripts\mp\utility\player::getstancecenter();
    }

    tracepoints = [headpos, centerpos, defaultorigin];
  } else if(isagent(target)) {
    tracepoints = [defaultorigin + (0, 0, 1)];
  }

  ignorelist = [self, self.owner, target];

  if(isDefined(target.colmodel)) {
    ignorelist[ignorelist.size] = target.colmodel;
  }

  for(i = 0; i < tracepoints.size; i++) {
    if(!scripts\engine\trace::ray_trace_passed(playerhead, tracepoints[i], ignorelist, tracecontents)) {
      return false;
    }

    if(!var_dd44977fb56bb74d && outlineoccluded(playerhead, tracepoints[i])) {
      return false;
    }

    return true;
  }

  return false;
}

function function_2495d714d2a215ad(scantarget, scanfov, var_5e43b44751d01b1a) {
  if(!isDefined(scantarget)) {
    return false;
  }

  targetorigin = scantarget.origin;
  scanpoints = [targetorigin];

  if(isPlayer(scantarget)) {
    headpos = scantarget scripts\mp\utility\player::getstancetop();
    centerpos = scantarget scripts\mp\utility\player::getstancecenter();
    scanpoints = [targetorigin, headpos, centerpos];
  } else if(isagent(scantarget)) {
    centerpos = scantarget scripts\mp\agents\agent_utility::function_b071e509c0fb69b0();
    headpos = scantarget scripts\mp\agents\agent_utility::function_2e1b23386b967c10();
    scanpoints = [targetorigin + (0, 0, 1), centerpos, headpos];
  }

  foreach(point in scanpoints) {
    if(self worldpointinreticle_circle(point, scanfov, var_5e43b44751d01b1a)) {
      return true;
    }
  }

  return false;
}