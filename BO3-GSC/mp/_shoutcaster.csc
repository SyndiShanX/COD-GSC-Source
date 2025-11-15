/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_shoutcaster.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#namespace shoutcaster;

function is_shoutcaster(localclientnum) {
  return isshoutcaster(localclientnum);
}

function is_shoutcaster_using_team_identity(localclientnum) {
  return is_shoutcaster(localclientnum) && getshoutcastersetting(localclientnum, "shoutcaster_team_identity");
}

function get_team_color_id(localclientnum, team) {
  if(team == "allies") {
    return getshoutcastersetting(localclientnum, "shoutcaster_fe_team1_color");
  }
  return getshoutcastersetting(localclientnum, "shoutcaster_fe_team2_color");
}

function get_team_color_fx(localclientnum, team, script_bundle) {
  color = get_team_color_id(localclientnum, team);
  return script_bundle.objects[color].fx_colorid;
}

function get_color_fx(localclientnum, script_bundle) {
  effects = [];
  effects["allies"] = get_team_color_fx(localclientnum, "allies", script_bundle);
  effects["axis"] = get_team_color_fx(localclientnum, "axis", script_bundle);
  return effects;
}

function is_friendly(localclientnum) {
  localplayer = getlocalplayer(localclientnum);
  scorepanel_flipped = getshoutcastersetting(localclientnum, "shoutcaster_flip_scorepanel");
  if(!scorepanel_flipped) {
    friendly = self.team == "allies";
  } else {
    friendly = self.team == "axis";
  }
  return friendly;
}