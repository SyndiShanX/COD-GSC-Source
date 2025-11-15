/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\shroud.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace shroud;

autoexec __init__system__() {
  system::register(#"shroud", &init_shared, undefined, undefined);
}

init_shared(localclientnum) {
  clientfield::register("missile", "shroud_state", 1, 1, "int", &function_37bf13ad, 0, 1);
  clientfield::register("clientuimodel", "hudItems.shroudCount", 1, 3, "int", undefined, 0, 0);
  callback::add_weapon_type("eq_shroud", &arrow_spawned);
}

arrow_spawned(localclientnum) {
  self.var_44dad7e8 = 1;
}

private function_37bf13ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  starttime = gettime();

  while(isDefined(self) && !self hasdobj(localclientnum)) {
    if(gettime() - starttime > 1000) {
      return;
    }

    waitframe(1);
  }

  if(!isDefined(self)) {
    return;
  }

  switch (newval) {
    case 0:
    default:
      break;
    case 1:
      self thread function_a252eaf0(localclientnum, self getentitynumber(), self.team);
      self thread function_e3a084cd(localclientnum, bwastimejump);
      break;
  }
}

private function_90fc4e4c() {
  if(isDefined(self.var_981be9e8)) {
    if(!isDefined(level.var_effa221)) {
      level.var_effa221 = [];
    }

    var_7f14472d = 0;

    foreach(shroud in level.var_effa221) {
      if(!isDefined(shroud) || shroud.team != self.team) {
        continue;
      }

      distsq = distance2dsquared(self.origin, shroud.origin);

      if(distsq <= 1690000) {
        var_7f14472d = 1;
        break;
      }
    }

    if(!var_7f14472d) {
      self.var_981be9e8 disableonradar();
      self.var_981be9e8 function_811196d1(1);
      return;
    }

    self.var_981be9e8 enableonradar();
    self.var_981be9e8 function_811196d1(0);
  }
}

private function_a252eaf0(localclientnum, entnum, team) {
  self waittill(#"death");

  if(isDefined(self.iconent)) {
    self.iconent delete();
  }

  if(!isDefined(level.var_effa221)) {
    level.var_effa221 = [];
  }

  level.var_effa221[entnum] = undefined;

  foreach(player in getplayers(localclientnum)) {
    if(isDefined(player) && player.team == team) {
      player function_90fc4e4c();
    }
  }
}

private function_27e74bc4() {
  self notify("7fcaa52d398d10a6");
  self endon("7fcaa52d398d10a6");
  self waittill(#"death", #"disconnect");

  if(isDefined(self.var_981be9e8)) {
    self.var_981be9e8 delete();
  }
}

private function_e3a084cd(localclientnum, bwastimejump) {
  localplayer = function_5c10bd79(localclientnum);

  if(bwastimejump === 1) {
    if(isDefined(self.iconent)) {
      return;
    }
  } else if(isDefined(self.iconent)) {
    self.iconent delete();
  }

  self.iconent = spawn(localclientnum, self.origin, "script_model", localplayer getentitynumber(), self.team);
  self.iconent setModel(#"tag_origin");
  self.iconent linkto(self);
  self.iconent setcompassicon("minimap_shroud_flying");
  self.iconent function_8e04481f();
  self.iconent function_5e00861(0.25);
  self.iconent function_a5edb367(#"neutral");
  self thread function_6b2bc612(localclientnum, "o_reaper_t8_radar_shroud_projectile_closed_idle");
  self endon(#"death");
  flystarttime = getservertime(localclientnum);
  startorigin = self.origin;
  var_dc3f8ecd = startorigin;

  for(var_3d3d7bb1 = 0; var_3d3d7bb1 < 250; var_3d3d7bb1 = 0) {
    var_dc3f8ecd = self.origin;
    var_450cbe48 = getservertime(localclientnum);
    elapsedtime = var_450cbe48 - flystarttime;
    waitframe(1);
    parent = self getlinkedent();

    if(isDefined(parent) || var_dc3f8ecd == self.origin) {
      var_3d3d7bb1 = var_3d3d7bb1 + getservertime(localclientnum) - var_450cbe48;
      continue;
    }
  }

  if(isDefined(self.iconent)) {
    self.iconent enableonradar();
    self.iconent function_811196d1(0);
    self.iconent function_78fd6084();
    self.iconent function_27c5be6c(1);

    if(isDefined(localplayer) && !localplayer util::isenemyteam(self.team)) {
      self.iconent setcompassicon("minimap_shroud_friendly");
    } else {
      self.iconent setcompassicon("minimap_shroud");
    }

    diameter = 2600;
    self.iconent function_5e00861(diameter, 1);
    self thread function_6b2bc612(localclientnum, "o_reaper_t8_radar_shroud_projectile_open", "o_reaper_t8_radar_shroud_projectile_closed_idle");
    self thread function_e140ca2b(localclientnum);

    if(!isDefined(level.var_effa221)) {
      level.var_effa221 = [];
    }

    level.var_effa221[self getentitynumber()] = self;
    self thread function_25f0bf77(localclientnum);
  }
}

private function_99c31219(localclientnum) {
  players = getplayers(localclientnum);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(player.var_981be9e8)) {
      player.var_981be9e8 delete();
      player.var_981be9e8 = undefined;
    }
  }
}

private function_25f0bf77(localclientnum) {
  self endon(#"death");
  function_99c31219(localclientnum);
  var_e74c7608 = 10;
  var_bec8c458 = 0;

  while(true) {
    if(isDefined(self.iconent) && self.iconent.team != self.team) {
      self.iconent.team = self.team;
      localplayer = function_5c10bd79(localclientnum);

      if(localplayer.team == self.team) {
        self.iconent setcompassicon("minimap_shroud_friendly");
      } else {
        self.iconent setcompassicon("minimap_shroud");
      }

      function_99c31219(localclientnum);
    }

    players = getplayers(localclientnum);
    endpoint = var_bec8c458 + var_e74c7608;
    i = var_bec8c458;

    if(players.size < endpoint) {
      endpoint = players.size;
    }

    while(i < endpoint) {
      player = players[i];

      if(!isDefined(player)) {} else if(player.team == self.team) {
        if(!isDefined(player.var_981be9e8)) {
          player.var_981be9e8 = spawn(localclientnum, player.origin, "script_model", player getentitynumber(), self.team);
          player.var_981be9e8 setModel(#"tag_origin");
          player.var_981be9e8 linkto(player);
          player.var_981be9e8 setcompassicon("minimap_shroud_friendly_ping");
          player.var_981be9e8 function_8e04481f();
          player.var_981be9e8 function_5e00861(1.3);
          player thread function_27e74bc4();
        }

        player function_90fc4e4c();
      }

      i++;
    }

    if(i == players.size) {
      i = 0;
    }

    var_bec8c458 = i;
    wait 0.1;
  }
}

function_6b2bc612(localclientnum, animname, prevanim) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);
  self useanimtree("generic");
  self setanimrestart(animname, 1, 0, 1);

  if(isDefined(prevanim)) {
    self setanimrestart(prevanim, 0, 0, 1);
  }
}

function_e140ca2b(localclientnum) {
  self endon(#"death");
  self waittill(#"finished_opening");
  self thread function_6b2bc612(localclientnum, "o_reaper_t8_radar_shroud_projectile_open_idle");
}