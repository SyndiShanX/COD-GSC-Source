/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_15cba36f180ab171.gsc
*************************************************/

#using script_1311c5c284dd1537;
#using script_15cba36f180ab171;
#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\equipment\tactical_camera;
#using scripts\mp\outline;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\supers;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace namespace_da3c8f2cdcad316c;

function function_7142c6e9236c9683() {
  level.var_bb0266f422d9afa3["agentTacCam"] = spawnStruct();
  namespace_5fa40aef0a0c4a61::function_55ddd213c3e34c53();
  function_3d6a680d27d4b77();
}

function function_3d6a680d27d4b77() {
  var_195d2e0ed33c2a87 = level.struct_class_names["script_noteworthy"]["trapper_taccam"];

  if(!isDefined(var_195d2e0ed33c2a87)) {
    return;
  }

  foreach(node in var_195d2e0ed33c2a87) {
    function_70e28195e1f4871e(node, node.origin, 1);
  }
}

function function_55ddd213c3e34c53() {
  leveldata = function_f0698aee89c18210("agentTacCam");
  leveldata.supername = "super_tac_camera";
  leveldata.lifetime = getdvarint(@ "hash_13717e6e87cb530f", 120);
  leveldata.destroyfunc = &function_f44b37d060d14eb5;
  leveldata.var_d6fdc3b56b33f4e3 = &function_7acc5aa2b73fe93b;
  leveldata.var_273f2a99f4833f00 = &function_daf83774b715c487;
  leveldata.var_547e8b267c03d017 = &function_1ee10c87668846d9;
  leveldata.var_1eb35a5a7992e498 = &function_7acc5aa2b73fe93b;
  leveldata.var_6e5f6320607eb69 = &function_a60052d904a2d492;
  leveldata.var_4fbadc7102d30912 = 250000;
  leveldata.var_16187e4d354c3c97 = 250000;
  leveldata.sensorduration = 3;
  leveldata.markingsfx = "equip_tactical_cam_marking";
  leveldata.maxhealth = 100;
  leveldata.var_604c545b594e97ec = &function_6a2036b8607b2fa6;
  leveldata.damagehandler = &function_7b5cbf35f63ba5d2;
  leveldata.orientationcontents = scripts\engine\trace::create_contents(1, 0, 0, 1, 0, 1, 0, 1, 1);
  leveldata.var_106bf36856a998f = getEntArray("tacCameraInvalid", "targetname");
}

function function_4f7fc48f506a21f3() {
  cameracenter = self getvieworigin();
  cameraorientation = self getplayerangles();
  cameraforward = anglesToForward(cameraorientation);
  cameratraceend = cameracenter + cameraforward * 256;
  ignorearray = self;
  var_e76c084d206cfb7f = function_f0698aee89c18210("agentTacCam").orientationcontents;
  deploytrace = ray_trace(cameracenter, cameratraceend, ignorearray, var_e76c084d206cfb7f, 0, 0, 1);

  if(deploytrace["hittype"] == "hittype_none") {
    return;
  }

  deploypos = deploytrace["position"];
  deployfwd = math::vector_project_onto_plane(vectorNormalize(self.origin - deploytrace["position"]), deploytrace["normal"]);
  deployup = deploytrace["normal"];
  deployright = vectorcross(deployfwd, deployup);
  deployorientation = axistoangles(deployfwd, deployright, deployup);
  deploystruct = spawnStruct();
  deploystruct.origin = deploypos;
  deploystruct.angles = deployorientation;
  function_70e28195e1f4871e(deploystruct, deploypos);
}

function function_70e28195e1f4871e(deploystruct, deploypos, nolifetime) {
  camera = function_ee24b83d39692536(deploystruct, undefined, deploypos, "tactical_camera_turret_mp", "turret_tactical_camera_v0", "agentTacCam", 1);
  camera setmode("manual");
  camera.var_d20dfbbbcd940269 = 1;
  camera.poi = scripts\mp\poi::function_6cc445c02b5effac(camera.origin);

  if(!istrue(nolifetime)) {
    camera thread function_b3b59c099f93a503(1);
  }

  camera thread function_7cd9c9609b1d3fe2();
  camera thread namespace_5633828963c62e57::function_23cf186c8b512748();
}

function function_f44b37d060d14eb5() {
  self notify("death");
  self.isdestroyed = 1;
  self setscriptablepartstate("destroyed", "on", 0);
  scripts\mp\outline::outlinedisableinternalall(self);
  wait 0.1;
  self delete();
}

function function_7b5cbf35f63ba5d2(data) {
  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return 0;
  }

  if(data.meansofdeath == "MOD_IMPACT") {
    return 0;
  }

  damage2ret = data.damage;
  hits = undefined;

  if(isexplosivedamagemod(data.meansofdeath)) {
    hits = function_35fe12b0d93b4bee(data);
  } else if(isbulletdamage(data.meansofdeath)) {
    hits = function_a6bd73d933b524e3(data);
  }

  if(isDefined(hits)) {
    damage2ret = int(ceil(min(1, hits / 5) * self.maxhealth));
  }

  if(self.damagetaken + damage2ret / self.maxhealth > 0.5) {
    if(!istrue(self.isdamaged)) {
      self.isdamaged = 1;
      self setscriptablepartstate("damaged", "on", 0);
    }
  }

  return damage2ret;
}

function function_6a2036b8607b2fa6(data) {
  attacker = data.attacker;

  if(!isDefined(data.attacker)) {
    return;
  }

  if(scripts\mp\utility\teams::function_44a6f98cc3c0f5f4(attacker.team)) {}

  if(isPlayer(attacker)) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::doscoreevent(#"hash_1ee8d6bcaf4366be");
    attacker thread scripts\mp\battlechatter_mp::onfieldupgradedestroy(#"bc_fieldupgrade_killfirm_taccamera");
  }

  function_f44b37d060d14eb5();
}

function private function_35fe12b0d93b4bee(data, isenemydamage) {
  if(data.damage > 200) {
    return 20;
  }

  if(data.damage > 70) {
    return 10;
  }

  if(data.damage > 30) {
    return 7;
  }

  return 2;
}

function private function_a6bd73d933b524e3(data, isenemydamage) {
  basehits = ter_op(scripts\mp\utility\damage::isfmjdamage(data.objweapon, data.meansofdeath) && isenemydamage, 2, 0);

  if(data.damage > 150) {
    return (basehits + 10);
  }

  if(data.damage >= 50) {
    return (basehits + 5);
  }

  if(data.damage >= 30) {
    return (basehits + 3);
  }

  if(data.damage >= 20) {
    return (basehits + 2);
  }

  return basehits + 1;
}

function function_7cd9c9609b1d3fe2() {
  level endon("game_ended");
  self endon("death");
  entmask = function_869ccb4e3451b8c6(["etype_player", "etype_ai"]);

  while(true) {
    targetarray = function_b1eef70090b5b7b5(self.origin, 1575, entmask);

    foreach(ent in targetarray) {
      if(!isDefined(ent)) {
        continue;
      }

      if(isPlayer(ent) || isbot(ent)) {
        if(issharedfuncdefined("player", "isReallyAlive")) {
          if(![[getsharedfunc("player", "isReallyAlive")]](ent)) {
            continue;
          }
        }
      }

      if(isagent(ent)) {
        continue;
      }

      if(scripts\cp_mp\emp_debuff::is_empd()) {
        continue;
      }

      targetinfo = function_9d2bec87e0754872(ent);

      if(!targetinfo.isvisible || !targetinfo.isindetectrange) {
        continue;
      }

      if(istrue(self.markingtarget)) {
        continue;
      }

      function_97d222273f4855e1(ent);
    }

    wait 0.25;
  }
}

function function_97d222273f4855e1(victimplayer) {
  self settargetentity(victimplayer);
  timetracked = 0;
  trackedduration = getdvarfloat(@ "hash_6cb0cf97f8ae3387", 3);

  while(timetracked < trackedduration) {
    targetinfo = function_9d2bec87e0754872(victimplayer);

    if(!targetinfo.isvisible || !targetinfo.isindetectrange) {
      self cleartargetentity();
      return;
    }

    timetracked += level.framedurationseconds;
    waitframe();
  }

  level thread draw_line_for_time(victimplayer scripts\mp\utility\player::getstancetop(), self.origin, 1, 0, 0, 100);
  level thread draw_line_for_time(victimplayer scripts\mp\utility\player::getstancecenter(), self.origin, 1, 0, 0, 100);
  level thread draw_line_for_time(victimplayer.origin, self.origin, 1, 0, 0, 100);

  scripts\mp\pmc_missions::function_800f75fe5e5c7462(victimplayer, self);
  namespace_5fa40aef0a0c4a61::function_312239156654c258(victimplayer);

  if(isDefined(level.var_e7c5eb1e41445c13)) {
    self[[level.var_e7c5eb1e41445c13]](victimplayer);
  }

  function_86f2d395b5545b01(victimplayer);
}

function function_312239156654c258(victimplayer) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.var_f489aabfe37a8afa)) {
    self.var_f489aabfe37a8afa = [];
  }

  if(array_contains_key(self.var_f489aabfe37a8afa, victimplayer.team)) {
    return;
  }

  self.var_f489aabfe37a8afa[victimplayer.team] = [victimplayer.team];
  id = scripts\mp\utility\outline::outlineenableforteam(self, victimplayer.team, "spotter_notarget_equipment", "perk_superior");
}

function function_86f2d395b5545b01(victimplayer) {
  timer = 0;

  while(true) {
    victimplayer thread function_7d61d7b52c318d47();
    victimplayer function_748f3520a7e525a9();
    victimplayer playlocalsound("recon_drone_spotted_plr");
    var_5756e405d4393132 = undefined;

    if(isDefined(self.poi) && getdvarint(@ "hash_e242c057ecb7ee6b", 1) == 1) {
      var_5756e405d4393132 = function_7e3f22e620f3f71e(self.poi, "everybody");
    } else {
      var_5756e405d4393132 = utility::function_2d7fd59d039fa69b(victimplayer.origin, 800, 0);
    }

    foreach(agent in var_5756e405d4393132) {
      if(!isDefined(agent) || isint(agent)) {
        continue;
      }

      if(!isagent(agent)) {
        continue;
      }

      if(!isDefined(agent.team)) {
        continue;
      }

      agent getenemyinfo(victimplayer);
    }

    refreshtime = getdvarfloat(@ "hash_476ba3b2fd5d8fea", 5);

    while(timer < refreshtime) {
      targetinfo = function_9d2bec87e0754872(victimplayer);

      if(!targetinfo.isvisible || !targetinfo.isindetectrange || !targetinfo.var_9ae205c4c40af967) {
        self cleartargetentity();
        return;
      }

      wait 0.25;
      timer += 0.25;
    }

    timer = 0;
    waitframe();
  }
}