/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3536.gsc
***************************************/

marktarget_init() {
  level._effect["marked_target"] = loadfx("vfx\iw7\_requests\mp\vfx_marked_target_z.vfx");
}

marktarget_run(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\engine\utility::isbulletdamage(var_01) && isplayer(var_00) && var_0.team != self.team && !var_00 scripts\mp\utility\game::_hasperk("specialty_empimmune") && !isDefined(var_0.ismarkedtarget)) {
    thread marktarget_execute(var_00);
  }
}

marktarget_execute(var_00) {
  var_01 = var_00 scripts\engine\utility::spawn_tag_origin();
  var_02 = spawn("script_model", var_1.origin);
  var_02 setModel("tag_origin");
  var_02 linkto(var_01, "tag_origin", (0, 0, 45), (0, 0, 0));
  var_01 linkto(var_00, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0.ismarkedtarget = 1;
  var_0.healthregendisabled = 1;
  wait 0.1;
  tagmarkedplayer(var_00, var_02);
  wait 0.1;

  if(isDefined(var_00)) {
    var_00 removemarkfromtarget(var_01);
  }
}

tagmarkedplayer(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  scripts\mp\missions::func_D991("ch_trait_marked_target");
  var_02 = gettime() + 3000;

  while(isalive(var_00) && gettime() < var_02) {
    if(level.gametype != "dm") {
      var_03 = _playfxontagforteam(scripts\engine\utility::getfx("marked_target"), var_01, "tag_origin", self.team);
    }
    else {
      var_03 = playfxontagforclients(scripts\engine\utility::getfx("marked_target"), var_01, "tag_origin", self);
    }

    wait 1.1;
  }
}

removemarkfromtarget(var_00) {
  var_00 delete();
  self.ismarkedtarget = undefined;
  self.healthregendisabled = undefined;
}

func_13AA0(var_00, var_01, var_02) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death(var_02, "leave");

  if(isDefined(var_01)) {
    scripts\mp\utility\game::outlinedisable(var_00, var_01);
  }
}