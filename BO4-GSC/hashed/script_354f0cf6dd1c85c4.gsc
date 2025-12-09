/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_354f0cf6dd1c85c4.gsc
***********************************************/

#namespace shoutcaster;

is_shoutcaster(localclientnum) {
  return function_d224c0e6(localclientnum);
}

is_shoutcaster_using_team_identity(localclientnum) {
  return is_shoutcaster(localclientnum) && getshoutcastersetting(localclientnum, "shoutcaster_fe_team_identity");
}

get_team_color_id(localclientnum, team) {
  if(team == # "allies") {
    return getshoutcastersetting(localclientnum, "shoutcaster_fe_team1_color");
  }
  return getshoutcastersetting(localclientnum, "shoutcaster_fe_team2_color");
}

get_team_color_fx(localclientnum, team, script_bundle) {
  color = get_team_color_id(localclientnum, team);
  return script_bundle.objects[color].fx_colorid;
}

get_color_fx(localclientnum, script_bundle) {
  effects = [];
  effects[# "allies"] = get_team_color_fx(localclientnum, # "allies", script_bundle);
  effects[# "axis"] = get_team_color_fx(localclientnum, # "axis", script_bundle);
  return effects;
}

is_friendly(localclientnum) {
  localplayer = function_f97e7787(localclientnum);
  scorepanel_flipped = getshoutcastersetting(localclientnum, "shoutcaster_flip_scorepanel");
  if(!scorepanel_flipped) {
    friendly = self.team == # "allies";
  } else {
    friendly = self.team == # "axis";
  }
  return friendly;
}