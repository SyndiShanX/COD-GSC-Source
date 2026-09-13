/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4188b160715793ab.gsc
***********************************************/

_id_F27A95467CF49300(dist, _id_D08B0B7680610EDA, _id_B8ECC8EBA55FE9A3, _id_7B4632935AEF1893) {
  self endon("death");
  _id_35FD51823F9DBC3E(dist, _id_B8ECC8EBA55FE9A3, _id_7B4632935AEF1893);
  self notify("enemy_close");

  if(istrue(_id_D08B0B7680610EDA)) {
    self.fixednode = 0;
    self setgoalpos(self.origin);
    self.goalradius = 4096;
  } else
    self.goalradius = 1024;
}

_id_35FD51823F9DBC3E(dist, _id_B8ECC8EBA55FE9A3, _id_7B4632935AEF1893) {
  self endon("death");

  if(!isDefined(dist))
    dist = 100;

  _id_ABD9EE4725B96FC2 = dist * dist;
  _id_94388E6B3645AF0C = 0;

  while(!_id_94388E6B3645AF0C) {
    foreach(player in level.players) {
      if(!isDefined(player.origin)) {
        continue;
      }
      if(distance2dsquared(player.origin, self.origin) < _id_ABD9EE4725B96FC2) {
        _id_94388E6B3645AF0C = 1;

        if(isDefined(_id_B8ECC8EBA55FE9A3)) {
          if(player.origin[2] <= self.origin[2] + _id_B8ECC8EBA55FE9A3)
            _id_94388E6B3645AF0C = 0;
        }

        if(isDefined(_id_7B4632935AEF1893)) {
          if(player.origin[2] >= self.origin[2] + _id_7B4632935AEF1893)
            _id_94388E6B3645AF0C = 0;
        }
      }
    }

    wait 0.1;
  }
}

_id_98182259D5216A0B(num, enemy_list) {
  _id_CFDC992223FF2AA5(enemy_list, num);

  foreach(guy in enemy_list) {
    guy.goalradius = 2048;
    guy cleargoalvolume();
  }
}

_id_CFDC992223FF2AA5(spawned, _id_7F0C5EAD0494E282) {
  if(!isDefined(_id_7F0C5EAD0494E282))
    _id_7F0C5EAD0494E282 = 0;

  for(;;) {
    wait 1;
    alive = 0;

    foreach(ent in spawned) {
      if(isalive(ent) && ent.health > 0) {
        alive++;
        continue;
      }
    }

    if(alive > _id_7F0C5EAD0494E282)
      continue;
    else
      return;
  }
}

_id_22A691CA6FEC37D3(_id_4E289DE92961AB3D, _id_6427FE21EEFCB66B, goal_radius, _id_F64031E7AD2FAF08) {
  level endon("kill_respawn_threads");

  if(istrue(_id_6427FE21EEFCB66B)) {
    return;
  }
  self waittill("death");
  thread _id_C185EB46D6B12CBA(_id_4E289DE92961AB3D, goal_radius, _id_F64031E7AD2FAF08);
}

_id_C185EB46D6B12CBA(spawner, goal_radius, _id_F64031E7AD2FAF08) {
  aitype = "actor_enemy_cp_rus_desert_" + spawner.script_noteworthy;
  org = spawner.origin;
  _id_C6736586AE30F7EA = getnodesinradiussorted(spawner.origin, 100, 0, 512, "cover");

  if(isDefined(_id_C6736586AE30F7EA) && _id_C6736586AE30F7EA.size > 0)
    org = _id_C6736586AE30F7EA[0].origin;

  ai = _id_537A712B2BE3193C::_id_43825E7633150BE3(aitype, spawner, 0, goal_radius);

  if(isDefined(ai)) {
    if(spawner.script_noteworthy == "sniper") {
      ai scripts\common\ai::find_and_teleport_to_cover();
      ai.fixednode = 1;
      ai.neverforcesnipermissenemy = 1;
      ai.sniperaccuracyset = 1;
      ai.baseaccuracy = 1;
      ai laseron();
      ai thread _id_22A691CA6FEC37D3(spawner);
    }

    ai.goalradius = goal_radius;
    ai scripts\engine\utility::delaythread(3, ::_id_3B02EEBE0B11F734);

    if(spawner.script_noteworthy == "sniper")
      ai thread _id_F27A95467CF49300(goal_radius * 2, 1);
    else
      ai thread _id_F27A95467CF49300(goal_radius);

    ai thread _id_9261F1B6BAA7B9B5();
    ai thread _id_DA85BDADAE5246C7(spawner);
  }
}

_id_9261F1B6BAA7B9B5() {
  foreach(player in level.players)
  self getenemyinfo(player);
}

_id_DA85BDADAE5246C7(spawner) {
  if(isDefined(spawner.target)) {
    loc = scripts\engine\utility::getStruct(spawner.target, "targetname");
    self setgoalpos(loc.origin);
    msg = scripts\engine\utility::waittill_any_return_4("goal", "goal_reached", "death");

    if(isDefined(spawner.radius))
      self.goalradius = spawner.radius;
  }
}

_id_3B02EEBE0B11F734(_id_25F0D68EE22434EB) {
  if(!getdvarint("dvar_26524832A07CF602", 1)) {
    self.dropweapon = 0;
    return;
  }

  if(!isDefined(_id_25F0D68EE22434EB))
    _id_25F0D68EE22434EB = 0;

  self.dropweapon = _id_25F0D68EE22434EB;
  self._id_98ADD129A7ECB962 = 0;
}

_id_4B38E20E4EFD31E8(targetname) {
  _id_C2996EA54CDAC32C = "at_mine_loc";

  if(isDefined(targetname))
    _id_C2996EA54CDAC32C = targetname;

  _id_8EC1EF0203900B0C = scripts\engine\utility::getStructArray(_id_C2996EA54CDAC32C, "targetname");

  foreach(_id_0C3EA9B1A20FF199 in _id_8EC1EF0203900B0C) {
    _id_0C3EA9B1A20FF199 _id_0D85F0BCE73A6DF2();
    wait 0.1;
  }
}

_id_0D85F0BCE73A6DF2() {
  pos = self.origin + (0, 0, 100);
  _id_E020078567E41613 = magicgrenademanual("at_mine_mp", pos, (0, 0, 10));
  _id_E020078567E41613.owner = _id_E020078567E41613;
  _id_E020078567E41613.team = "axis";
  thread scripts\cp\equipment\cp_at_mine::at_mine_plant(_id_E020078567E41613);
}

_id_1E4C3B5E18582E4D(targetname) {
  if(isDefined(level._id_8E6E84BCF72A908F)) {
    foreach(_id_C00448D30DF1BEA6 in level._id_8E6E84BCF72A908F) {
      if(_id_C00448D30DF1BEA6.targetname == targetname)
        return 1;
    }

    return 0;
  }

  return undefined;
}