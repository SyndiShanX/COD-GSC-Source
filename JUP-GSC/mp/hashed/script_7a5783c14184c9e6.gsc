/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7a5783c14184c9e6.gsc
*************************************************/

#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\utility\teams;
#namespace namespace_562c09f7cd8fb4f5;

function function_78422799f477b8e6(spawndata, team, weaponname, modelname, aitype) {
  level endon("game_ended");

  if(!isDefined(weaponname)) {
    weaponname = "jup_cougar_mg_gunner_turret_mp";
  }

  if(!isDefined(modelname)) {
    modelname = "weapon_wm_mg_mobile_turret";
  }

  turret = spawnturret("misc_turret", spawndata.origin, weaponname, 0);
  turret.var_3763391e00ccdd58 = 1;
  turret setModel(modelname);

  if(isDefined(spawndata.angles)) {
    turret.angles = spawndata.angles;
  }

  turret setmode("sentry_offline");
  turret makeunusable();
  turret setdefaultdroppitch(0);
  turret.usemode = "manual_target";
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();

  if(!isDefined(level.var_f7914aa9690e3289)) {
    level.var_f7914aa9690e3289 = [];
  }

  level.var_f7914aa9690e3289[level.var_f7914aa9690e3289.size] = turret;
  turret startfiring();
  turret setmode("manual");
  return turret;
}

function function_3cd75d5bf0fc9989(spawndata, team, aitype, weaponname, modelname) {
  level endon("game_ended");
  scripts\mp\ai_mp_controller::function_2fc80954fa70d153();

  if(!isDefined(aitype)) {
    aitype = "jup_enemy_mp_lmg_tier1_pmc";
  }

  var_9ba5cef5b2b49421 = getStruct(spawndata.target, "targetname");
  agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, var_9ba5cef5b2b49421.origin, var_9ba5cef5b2b49421.angles, "absolute", "show", "rpg", undefined, team, undefined, undefined, 1, undefined, 0, undefined);

  if(isDefined(agent)) {
    agent scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(agent, "team", team);
    agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(undefined, undefined, undefined, undefined, undefined, 0, 0);
    agent.var_b582b10663b5b2a9 = 0;
    agent.ignoreall = 1;
    agent clearbtgoal(4);
    agent function_e64ea2b4e79c4b74(4);
    agent.var_6384ebeaed4efe3e = 1;
  }

  if(isDefined(spawndata.script_label)) {
    var_99fe65bbdb024783 = getEnt("mg_agent_mount_trigger" + spawndata.script_label, "targetname");

    if(!isDefined(var_99fe65bbdb024783)) {
      assertmsg("<dev string:x1c>");
    } else {
      while(true) {
        var_99fe65bbdb024783 waittill("trigger", player);

        if(!is_equal(player.pers["team"], game["attackers"])) {
          continue;
        }

        break;
      }
    }
  }

  if(!isalive(agent)) {
    return;
  }

  agent clearbtgoal(4);
  agent setbtgoalpos(4, getclosestpointonnavmesh(spawndata.origin));
  aimpos = spawn("script_model", self.origin + anglesToForward(self.origin) * 100);
  self.aimpos = aimpos;
  self settargetentity(aimpos);

  level thread function_6b6a08026758fca9(aimpos);

  if(istrue(level.var_2f006c7490fb7639)) {
    scripts\common\ai::ai_operate_turret(agent, self);
    self.owner = agent;
    thread function_86880084e476db84();
    return;
  }

  wait 3;

  if(isalive(agent)) {
    scripts\common\ai::ai_operate_turret(agent, self);
    self.owner = agent;
    self.colmodel.owner = self.owner;
    agent.var_859f7cb544b5801d = self;
    self.owner thread function_bd80506147960d00();
    thread function_69c4dd9b2bc55b1b();
  }
}

function function_69c4dd9b2bc55b1b() {
  level endon("game_ended");
  self endon("death");
  self endon("agent_mg_destroyed");
  turret = self;
  burst = 9;

  while(true) {
    if(!istrue(function_a233031a44bbbb0d(turret, turret.owner))) {
      return;
    }

    blackboard = turret.owner._blackboard;

    if(!isDefined(blackboard) || !isDefined(blackboard.aigroundturretstate) || blackboard.aigroundturretstate != "turret_mounted") {
      waitframe();
      continue;
    }

    break;
  }

  wait 1.5;

  while(true) {
    if(!istrue(function_a233031a44bbbb0d(turret, turret.owner))) {
      return;
    }

    attackers = scripts\mp\utility\teams::getteamdata(game["attackers"], "alivePlayers");
    var_95f2a51e7b487eb2 = sortbydistancecullbyradius(attackers, self.origin, 2400);
    var_1e1dd312897f5c42 = [];

    foreach(attacker in var_95f2a51e7b487eb2) {
      var_de72f19d4de18b4f = distance2dsquared(attacker.origin, self.origin);

      if(var_de72f19d4de18b4f >= 100000) {
        var_1e1dd312897f5c42[var_1e1dd312897f5c42.size] = attacker;
      }
    }

    target = array_random(var_1e1dd312897f5c42);

    if(isDefined(target)) {
      function_597e32613762e969(target, self.aimpos, burst);
      wait randomfloatrange(3, 3.5);
      continue;
    }

    wait 0.2;
  }
}

function function_86880084e476db84() {
  level endon("game_ended");
  turret = self;
  burst = 6;

  while(true) {
    if(isDefined(self.var_57abfc2b0a18dd65)) {
      function_597e32613762e969(self.var_57abfc2b0a18dd65, self.aimpos, burst);
    }

    wait 0.5;
  }
}

function function_597e32613762e969(target, aimpos, burst) {
  self endon("agent_mg_destroyed");
  turret = self;
  var_bd2a07ce8b285aa4 = target.origin + vectornormalize2(turret.origin - target.origin) * 600;

  if(distance2dsquared(var_bd2a07ce8b285aa4, self.origin) > 100000) {
    aimpos moveTo(var_bd2a07ce8b285aa4, 0.2);
    var_777a0430627e00a8 = vectornormalize2(target.origin - turret.origin) * 1000;
  } else {
    aimpos moveTo(target.origin + vectornormalize2(target.origin - turret.origin) * 100, 0.2);
    var_777a0430627e00a8 = undefined;
  }

  wait 0.2;

  for(i = 0; i < burst; i++) {
    if(!istrue(function_a233031a44bbbb0d(turret, turret.owner))) {
      return;
    }

    if(turret.owner isflashed()) {
      turret.owner._blackboard.aigroundturretstate = "none";
      turret.owner.ignoreall = 1;
      turret.owner.ignoreme = 1;
      turret.owner.var_ab002334e3a455a5 = 1;
      wait 2;
      break;
    }

    if(istrue(turret.owner.var_ab002334e3a455a5)) {
      scripts\common\ai::ai_operate_turret(turret.owner, turret);
      turret.owner.var_ab002334e3a455a5 = undefined;

      while(true) {
        if(!istrue(function_a233031a44bbbb0d(turret, turret.owner))) {
          return;
        }

        blackboard = turret.owner._blackboard;

        if(!isDefined(blackboard) || !isDefined(blackboard.aigroundturretstate) || blackboard.aigroundturretstate != "turret_mounted") {
          waitframe();
          continue;
        }

        break;
      }

      wait 1.5;
    }

    if(isDefined(turret.owner)) {
      turret shootturret();
    }

    if(isDefined(var_777a0430627e00a8)) {
      aimpos moveTo(aimpos.origin + var_777a0430627e00a8 / burst, 0.05);
    }

    wait 0.13;
  }
}

function function_6b6a08026758fca9(aimpos) {
  while(isDefined(aimpos)) {
    sphere(aimpos.origin, 50);
    waitframe();
  }
}

function function_a233031a44bbbb0d(turret, owner) {
  if(!isDefined(owner) || !isalive(owner)) {
    turret setmode("sentry_offline");
    turret cleartargetentity();
    turret.owner = undefined;
    turret hudoutlinedisable();

    if(isDefined(turret.aimpos)) {
      turret.aimpos delete();
    }

    return false;
  }

  return true;
}

function function_bd80506147960d00() {
  level endon("game_ended");
  self endon("death");
  var_68e6f05a4ee24dee = scripts\engine\trace::create_contents(1, 1);
  outlinetype = "outlinefill_enemy_hvt";

  while(isalive(self) == 1) {
    foreach(player in level.players) {
      forward = anglesToForward(player getplayerangles());

      if(within_fov(player getEye(), player getplayerangles(), self.origin, cos(60))) {
        hits = physics_raycast(player getEye(), player getEye() + forward * 150000, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_closest");
      }

      if(isDefined(hits) && hits.size > 0) {
        foreach(hit in hits) {
          if(isDefined(hit["entity"]) && hit["entity"] == self) {
            if(is_equal(player.pers["team"], self.pers["team"])) {} else {
              self hudoutlineenableforclient(player, outlinetype);

              if(isDefined(self.var_859f7cb544b5801d) && isDefined(self._blackboard) && isDefined(self._blackboard.aigroundturretstate) && self._blackboard.aigroundturretstate == "turret_mounted") {
                self.var_859f7cb544b5801d hudoutlineenableforclient(player, outlinetype);
              }
            }

            break;
          }

          self hudoutlinedisableforclient(player);

          if(isDefined(self.var_859f7cb544b5801d)) {
            self.var_859f7cb544b5801d hudoutlinedisableforclient(player);
          }
        }
      }
    }

    waitframe();
  }
}