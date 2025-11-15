/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\perks\_perk_mark_targets.gsc
***************************************************/

marktarget_init() {
  level._effect["marked_target"] = loadfx("vfx\iw7\_requests\mp\vfx_marked_target_z.vfx");
}

marktarget_run(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(scripts\engine\utility::isbulletdamage(param_01) && isplayer(param_00) && param_00.team != self.team && !param_00 scripts\mp\utility::_hasperk("specialty_empimmune") && !isDefined(param_00.ismarkedtarget)) {
    thread marktarget_execute(param_00);
  }
}

marktarget_execute(param_00) {
  var_01 = param_00 scripts\engine\utility::spawn_tag_origin();
  var_02 = spawn("script_model", var_01.origin);
  var_02 setModel("tag_origin");
  var_02 linkto(var_01, "tag_origin", (0, 0, 45), (0, 0, 0));
  var_01 linkto(param_00, "tag_origin", (0, 0, 0), (0, 0, 0));
  param_00.ismarkedtarget = 1;
  param_00.healthregendisabled = 1;
  wait(0.1);
  tagmarkedplayer(param_00, var_02);
  wait(0.1);
  if(isDefined(param_00)) {
    param_00 removemarkfromtarget(var_01);
  }
}

tagmarkedplayer(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  scripts\mp\missions::func_D991("ch_trait_marked_target");
  var_02 = gettime() + 3000;
  while(isalive(param_00) && gettime() < var_02) {
    if(level.gametype != "dm") {
      var_03 = playfxontagforteam(scripts\engine\utility::getfx("marked_target"), param_01, "tag_origin", self.team);
      continue;
    }

    var_03 = playfxontagforclients(scripts\engine\utility::getfx("marked_target"), param_01, "tag_origin", self);
    wait(1.1);
  }
}

removemarkfromtarget(param_00) {
  param_00 delete();
  self.ismarkedtarget = undefined;
  self.healthregendisabled = undefined;
}

func_13AA0(param_00, param_01, param_02) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death_2(param_02, "leave");
  if(isDefined(param_01)) {
    scripts\mp\utility::outlinedisable(param_00, param_01);
  }
}