/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\jetfighter.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace jetfighter;

function private autoexec __init__system__() {
  system::register(#"jetfighter", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  clientfield::register("scriptmover", "jetfighter_contrail", 1, 1, "int", &jetfighter_contrail, 0, 0);
  level.var_852b61e4 = getscriptbundle("killstreak_jetfighter");
}

function jetfighter_contrail(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  util::waittill_dobj(fieldname);

  if(bwastimejump) {
    self.fx = util::playFXOnTag(fieldname, level.var_852b61e4.var_dcbb40c5, self, level.var_852b61e4.var_d678978c);
    self.fx = util::playFXOnTag(fieldname, level.var_852b61e4.var_2375a152, self, level.var_852b61e4.var_e5082065);
    self renderoverridebundle::function_f4eab437(fieldname, 1, #"rob_sonar_set_enemy");
    localplayer = function_5c10bd79(fieldname);
    self function_1f0c7136(2);

    if(localplayer hasperk(fieldname, #"specialty_showscorestreakicons") || self.team == localplayer.team) {
      self setcompassicon(level.var_852b61e4.var_cb98fbf7);
      self function_5e00861(level.var_852b61e4.var_c3e4af00);
      var_b13727dd = getgametypesetting("compassAnchorScorestreakIcons");
      self function_dce2238(var_b13727dd);
    }
  }
}