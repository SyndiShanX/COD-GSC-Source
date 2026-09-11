/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_smg_prototype.gsc
***********************************************/

function smg_flank_player(var0, var1) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(var0)) {
    wait var0;
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
    var2 = scripts\engine\utility::ter_op(randomint(2) > 0, "left", "right");
    var3 = getflankingpointforenemyonmedian(self.enemy, var2);

    if(isnode(var3)) {
      var4 = var3.origin;
    } else {
      var4 = var4;
    }

    self setgoalpos(var4);
    var5 = scripts\engine\utility::ref_143ad("goal_reached", "goal");
    watchforenemydistance();
  }
}

function drawdebugdestination(var0) {
  level endon("game_ended");
  self endon("change_flanking_pos");

  for(;;) {
    waitframe();
  }
}

function getflankpositiononplayer(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(var2) && var2 == "left") {
    var3 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var0, (0, var1, 0)));
  } else {
    var3 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var0, (0, var1 * -1, 0)));
  }

  var4 = getnodearray("flanking_node", "targetname");

  if(var4.size > 0) {
    var4 = sortbydistance(var4, var3);
    var5 = var4[0];

    if(distance(var5.origin, var3) <= 1024) {
      return var5;
    }
  }

  return var3;
}

function getmedianpointforplayersinteam(var0) {
  var1 = (0, 0, 0);
  var2 = scripts\cp\utility::getplayersinteam(var0);

  foreach(var4 in var2) {
    var1 += var4.origin;
  }

  var1 /= var2.size;
  var1 = scripts\engine\utility::drop_to_ground(var1);
  return var1;
}

function getaverageforwardvectorforplayersinteam(var0) {
  var1 = (0, 0, 0);
  var2 = scripts\cp\utility::getplayersinteam(var0);

  foreach(var4 in var2) {
    var5 = anglesToForward(var4.angles);
    var1 += var5;
  }

  var1 -= (0, 0, var1[2]);
  return var1;
}

function getminradiusofteamblob(var0, var1) {
  var2 = scripts\cp\utility::getplayersinteam(var0);
  var3 = 0;

  foreach(var5 in var2) {
    var6 = distance(var1, var5.origin);

    if(var6 > var3 && var6 <= 1024) {
      var3 = var6;
    }
  }

  return var3;
}

function getflankingpointforenemyonmedian(var0, var1) {
  var2 = undefined;
  var3 = getmedianpointforplayersinteam(var0.team);
  var4 = getminradiusofteamblob(var0.team, var3);

  if(isDefined(var1) && var1 == "left") {
    var2 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var0, (0, var4, 0)));
  } else {
    var2 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var0, (0, var4 * -1, 0)));
  }

  var5 = getnodearray("flanking_node", "targetname");

  if(var5.size > 0) {
    var5 = sortbydistance(var5, var2);
    var6 = var5[0];

    if(distance(var6.origin, var2) <= 1024) {
      return var6;
    }
  }

  var7 = getnodesinradius(var3, 1024, 512);

  if(var7.size > 0) {
    foreach(var9 in var7) {
      if(istrue(var9.isoccupiedbylmg)) {
        var7 = scripts\engine\utility::array_remove(var7, var9);
      }
    }

    var7 = sortbydistance(var7, var3);
    var6 = var7[0];

    if(distance(var6.origin, var2) <= 1024) {
      return var6;
    }
  }

  return var2;
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