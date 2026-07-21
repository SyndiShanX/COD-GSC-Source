/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_smg_prototype.gsc
***********************************************/

smg_flank_player(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0))
    wait(var_0);

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
    var_2 = scripts\engine\utility::ter_op(randomint(2) > 0, "_encstr_A5AD056A019C63", "_encstr_8253060E2B5FE330");
    var_3 = getflankingpointforenemyonmedian(self.enemy, var_2);

    if(isnode(var_3))
      var_4 = var_3.origin;
    else
      var_4 = var_3;

    self setgoalpos(var_4);
    var_5 = scripts\engine\utility::_id_143AD("_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_8B7205D9ED5958");
    watchforenemydistance();
  }
}

drawdebugdestination(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D6414F341980D072D4ECA7291F07F8498375768F7A0");

  for(;;)
    waitframe();
}

getflankpositiononplayer(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2) && var_2 == "_encstr_A5AD056A019C63")
    var_3 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var_0, (0, var_1, 0)));
  else
    var_3 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var_0, (0, var_1 * -1, 0)));

  var_4 = getnodearray("_encstr_83750E9963C273D6D2DCCEEBCD7B3259", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_4.size > 0) {
    var_4 = sortbydistance(var_4, var_3);
    var_5 = var_4[0];

    if(distance(var_5.origin, var_3) <= 1024)
      return var_5;
  }

  return var_3;
}

getmedianpointforplayersinteam(var_0) {
  var_1 = (0, 0, 0);
  var_2 = scripts\cp\utility::getplayersinteam(var_0);

  foreach(var_4 in var_2)
  var_1 = var_1 + var_4.origin;

  var_1 = var_1 / var_2.size;
  var_1 = scripts\engine\utility::drop_to_ground(var_1);
  return var_1;
}

getaverageforwardvectorforplayersinteam(var_0) {
  var_1 = (0, 0, 0);
  var_2 = scripts\cp\utility::getplayersinteam(var_0);

  foreach(var_4 in var_2) {
    var_5 = anglesToForward(var_4.angles);
    var_1 = var_1 + var_5;
  }

  var_1 = var_1 - (0, 0, var_1[2]);
  return var_1;
}

getminradiusofteamblob(var_0, var_1) {
  var_2 = scripts\cp\utility::getplayersinteam(var_0);
  var_3 = 0;

  foreach(var_5 in var_2) {
    var_6 = distance(var_1, var_5.origin);

    if(var_6 > var_3 && var_6 <= 1024)
      var_3 = var_6;
  }

  return var_3;
}

getflankingpointforenemyonmedian(var_0, var_1) {
  var_2 = undefined;
  var_3 = getmedianpointforplayersinteam(var_0.team);
  var_4 = getminradiusofteamblob(var_0.team, var_3);

  if(isDefined(var_1) && var_1 == "_encstr_A5AD056A019C63")
    var_2 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var_0, (0, var_4, 0)));
  else
    var_2 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var_0, (0, var_4 * -1, 0)));

  var_5 = getnodearray("_encstr_83750E9963C273D6D2DCCEEBCD7B3259", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_5.size > 0) {
    var_5 = sortbydistance(var_5, var_2);
    var_6 = var_5[0];

    if(distance(var_6.origin, var_2) <= 1024)
      return var_6;
  }

  var_7 = getnodesinradius(var_3, 1024, 512);

  if(var_7.size > 0) {
    foreach(var_9 in var_7) {
      if(istrue(var_9.isoccupiedbylmg))
        var_7 = scripts\engine\utility::array_remove(var_7, var_9);
    }

    var_7 = sortbydistance(var_7, var_3);
    var_6 = var_7[0];

    if(distance(var_6.origin, var_2) <= 1024)
      return var_6;
  }

  return var_2;
}

watchforenemydistance() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(isDefined(self.enemy)) {
      if(distance(self.origin, self.enemy.origin) > 512) {
        self notify("_encstr_8D6414F341980D072D4ECA7291F07F8498375768F7A0");
        return;
      }
    }

    wait 3;
  }
}