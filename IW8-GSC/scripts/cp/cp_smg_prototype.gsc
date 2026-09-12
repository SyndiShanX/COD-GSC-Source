/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_smg_prototype.gsc
***********************************************/

function smg_flank_player(var_0, var_1) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(var_0)) {
    wait var_0;
  }

  self.hunting_player = 1;
  self.no_fallback = 1;
  self.goalradius = 64;
  self.grenadeammo = 255;
  self.script_forcegrenade = 1;
  self.grenadesafedist = 200;

  for(;;) {
    if(!isDefined(self.enemy)) {
      wait 0.5;
      self.hunting_player = 0;
      continue;
    }

    self.hunting_player = 1;
    self.script_forcegrenade = 1;
    var_2 = scripts\engine\utility::ter_op(randomint(2) > 0, "left", "right");
    var_3 = getflankingpointforenemyonmedian(self.enemy, var_2);

    if(isnode(var_3)) {
      var_4 = var_3.origin;
    } else {
      var_4 = var_4;
    }

    self setgoalpos(var_4);
    var_5 = scripts\engine\utility::ref_143AD("goal_reached", "goal");
    watchforenemydistance();
  }
}

function drawdebugdestination(var_0) {
  level endon("game_ended");
  self endon("change_flanking_pos");

  for(;;) {
    waitframe();
  }
}

function getflankpositiononplayer(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2) && var_2 == "left") {
    var_3 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var_0, (0, var_1, 0)));
  } else {
    var_3 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var_0, (0, var_1 * -1, 0)));
  }

  var_4 = getnodearray("flanking_node", "targetname");

  if(var_4.size > 0) {
    var_4 = sortbydistance(var_4, var_3);
    var_5 = var_4[0];

    if(distance(var_5.origin, var_3) <= 1024) {
      return var_5;
    }
  }

  return var_3;
}

function getmedianpointforplayersinteam(var_0) {
  var_1 = (0, 0, 0);
  var_2 = scripts\cp\utility::getplayersinteam(var_0);

  foreach(var_4 in var_2) {
    var_1 += var_4.origin;
  }

  var_1 /= var_2.size;
  var_1 = scripts\engine\utility::drop_to_ground(var_1);
  return var_1;
}

function getaverageforwardvectorforplayersinteam(var_0) {
  var_1 = (0, 0, 0);
  var_2 = scripts\cp\utility::getplayersinteam(var_0);

  foreach(var_4 in var_2) {
    var_5 = anglesToForward(var_4.angles);
    var_1 += var_5;
  }

  var_1 -= (0, 0, var_1[2]);
  return var_1;
}

function getminradiusofteamblob(var_0, var_1) {
  var_2 = scripts\cp\utility::getplayersinteam(var_0);
  var_3 = 0;

  foreach(var_5 in var_2) {
    var_6 = distance(var_1, var_5.origin);

    if(var_6 > var_3 && var_6 <= 1024) {
      var_3 = var_6;
    }
  }

  return var_3;
}

function getflankingpointforenemyonmedian(var_0, var_1) {
  var_2 = undefined;
  var_3 = getmedianpointforplayersinteam(var_0.team);
  var_4 = getminradiusofteamblob(var_0.team, var_3);

  if(isDefined(var_1) && var_1 == "left") {
    var_2 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var_0, (0, var_4, 0)));
  } else {
    var_2 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var_0, (0, var_4 * -1, 0)));
  }

  var_5 = getnodearray("flanking_node", "targetname");

  if(var_5.size > 0) {
    var_5 = sortbydistance(var_5, var_2);
    var_6 = var_5[0];

    if(distance(var_6.origin, var_2) <= 1024) {
      return var_6;
    }
  }

  var_7 = getnodesinradius(var_3, 1024, 512);

  if(var_7.size > 0) {
    foreach(var_9 in var_7) {
      if(istrue(var_9.isoccupiedbylmg)) {
        var_7 = scripts\engine\utility::array_remove(var_7, var_9);
      }
    }

    var_7 = sortbydistance(var_7, var_3);
    var_6 = var_7[0];

    if(distance(var_6.origin, var_2) <= 1024) {
      return var_6;
    }
  }

  return var_2;
}

function watchforenemydistance() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(isDefined(self.enemy)) {
      if(distance(self.origin, self.enemy.origin) > 512) {
        self notify("change_flanking_pos");
        return;
      }
    }

    wait 3;
  }
}