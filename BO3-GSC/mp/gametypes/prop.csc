/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\prop.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_callbacks;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\util_shared;
#namespace prop;

function main() {
  clientfield::register("allplayers", "hideTeamPlayer", 27000, 2, "int", &function_8e3b5ce2, 0, 0);
  clientfield::register("allplayers", "pingHighlight", 27000, 1, "int", &function_c87d7938, 0, 0);
  callback::on_localplayer_spawned(&function_b413fb86);
  level.var_f12ccf06 = &function_6baff676;
  level.var_c301d021 = &function_76519db0;
  thread function_576e8126();
}

function function_b413fb86(localclientnum) {
  level notify("localPlayerSpectatingEnd" + localclientnum);
  if(isspectating(localclientnum, 0)) {
    level thread function_f336ce55(localclientnum);
  }
  level thread function_2bb59404(localclientnum);
}

function function_f336ce55(localclientnum) {
  level notify("localPlayerSpectating" + localclientnum);
  level endon("localPlayerSpectatingEnd" + localclientnum);
  var_cfcb9b39 = playerbeingspectated(localclientnum);
  while(true) {
    player = playerbeingspectated(localclientnum);
    if(player != var_cfcb9b39) {
      level notify("localPlayerSpectating" + localclientnum);
    }
    wait(0.1);
  }
}

function function_576e8126() {
  while(true) {
    level waittill("team_changed", localclientnum);
    level notify("team_changed" + localclientnum);
  }
}

function function_c5c7c3ef(player) {
  parent = self getlinkedent();
  while(isDefined(parent)) {
    if(parent == player) {
      return true;
    }
    parent = parent getlinkedent();
  }
  return false;
}

function function_8ef128e8(localclientnum, player) {
  if(isDefined(player.prop)) {
    return player.prop;
  }
  ents = getEntArray(localclientnum);
  foreach(ent in ents) {
    if(!ent isPlayer() && isDefined(ent.owner) && ent.owner == player && ent function_c5c7c3ef(player)) {
      return ent;
    }
  }
}

function function_2bb59404(localclientnum) {
  level notify("setupPropPlayerNames" + localclientnum);
  level endon("setupPropPlayerNames" + localclientnum);
  while(true) {
    localplayer = getlocalplayer(localclientnum);
    spectating = isspectating(localclientnum, 0);
    players = getplayers(localclientnum);
    foreach(player in players) {
      if(player != localplayer || spectating && player ishidden() && isDefined(player.team) && player.team == localplayer.team) {
        player.prop = function_8ef128e8(localclientnum, player);
        if(isDefined(player.prop)) {
          if(!(isDefined(player.var_3a6ca2d4) && player.var_3a6ca2d4)) {
            player.prop setdrawownername(1, spectating);
            player.var_3a6ca2d4 = 1;
          }
        }
        continue;
      }
      if(isDefined(player.var_3a6ca2d4) && player.var_3a6ca2d4) {
        player.prop = function_8ef128e8(localclientnum, player);
        if(isDefined(player.prop)) {
          player.prop setdrawownername(0, spectating);
        }
        player.var_3a6ca2d4 = 0;
      }
    }
    wait(1);
  }
}

function function_76519db0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    self notify("hash_e622a96b");
    self duplicate_render::update_dr_flag(localclientnum, "prop_ally", 0);
    self duplicate_render::update_dr_flag(localclientnum, "prop_clone", 0);
  } else {
    self thread function_e622a96b(localclientnum, newval);
  }
}

function function_e622a96b(localclientnum, var_2300871f) {
  self endon("entityshutdown");
  level endon("disconnect");
  self notify("hash_e622a96b");
  self endon("hash_e622a96b");
  while(true) {
    localplayer = getlocalplayer(localclientnum);
    spectating = isspectating(localclientnum, 0) && !getinkillcam(localclientnum);
    var_9d961790 = !isDefined(self.owner) || self.owner != localplayer || spectating && isDefined(self.team) && isDefined(localplayer.team) && self.team == localplayer.team;
    if(var_2300871f == 1) {
      self duplicate_render::update_dr_flag(localclientnum, "prop_ally", var_9d961790);
      self duplicate_render::update_dr_flag(localclientnum, "prop_clone", 0);
    } else {
      self duplicate_render::update_dr_flag(localclientnum, "prop_clone", var_9d961790);
      self duplicate_render::update_dr_flag(localclientnum, "prop_ally", 0);
    }
    self duplicate_render::update_dr_filters(localclientnum);
    level util::waittill_any("team_changed" + localclientnum, "localPlayerSpectating" + localclientnum);
  }
}

function function_c87d7938(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    self notify("hash_e622a96b");
    self duplicate_render::update_dr_flag(localclientnum, "prop_clone", 0);
  } else {
    self thread function_b001ad83(localclientnum, newval);
  }
}

function function_b001ad83(localclientnum, var_2300871f) {
  self endon("entityshutdown");
  self notify("hash_b001ad83");
  self endon("hash_b001ad83");
  while(true) {
    localplayer = getlocalplayer(localclientnum);
    var_9d961790 = self != localplayer && isDefined(self.team) && isDefined(localplayer.team) && self.team == localplayer.team;
    self duplicate_render::update_dr_flag(localclientnum, "prop_clone", var_9d961790);
    level util::waittill_any("team_changed" + localclientnum, "localPlayerSpectating" + localclientnum);
  }
}

function function_6baff676(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = getlocalplayer(localclientnum);
  var_9d961790 = newval && isDefined(self.owner) && self.owner == localplayer;
  if(var_9d961790) {
    self duplicate_render::update_dr_flag(localclientnum, "prop_look_through", 1);
    self duplicate_render::set_dr_flag("hide_model", 1);
    self duplicate_render::set_dr_flag("active_camo_reveal", 0);
    self duplicate_render::set_dr_flag("active_camo_on", 1);
    self duplicate_render::update_dr_filters(localclientnum);
  } else {
    self duplicate_render::update_dr_flag(localclientnum, "prop_look_through", 0);
    self duplicate_render::set_dr_flag("hide_model", 0);
    self duplicate_render::set_dr_flag("active_camo_reveal", 0);
    self duplicate_render::set_dr_flag("active_camo_on", 0);
    self duplicate_render::update_dr_filters(localclientnum);
  }
}

function function_8e3b5ce2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    self notify("hash_8819b68d");
    if(!self function_4ff87091(localclientnum)) {
      self show();
    }
  } else {
    self function_4bf4d3e1(localclientnum, newval);
  }
}

function function_4ff87091(localclientnum) {
  if(isDefined(self.prop)) {
    return 1;
  }
  if(self isPlayer()) {
    self.prop = function_8ef128e8(localclientnum, self);
    return isDefined(self.prop);
  }
  return 0;
}

function function_4bf4d3e1(localclientnum, var_1c61204d) {
  self endon("entityshutdown");
  self notify("hash_8819b68d");
  self endon("hash_8819b68d");
  assert(var_1c61204d == 1 || var_1c61204d == 2);
  team = "allies";
  if(var_1c61204d == 2) {
    team = "axis";
  }
  while(true) {
    localplayer = getlocalplayer(localclientnum);
    ishidden = isDefined(localplayer.team) && team == localplayer.team && !isspectating(localclientnum);
    if(ishidden) {
      self hide();
    } else if(!self function_4ff87091(localclientnum)) {
      self show();
    }
    level waittill("team_changed" + localclientnum);
  }
}