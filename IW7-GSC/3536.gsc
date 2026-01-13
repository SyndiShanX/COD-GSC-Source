/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3536.gsc
**************************************/

marktarget_init() {
  level._effect["marked_target"] = loadfx("vfx\iw7\_requests\mp\vfx_marked_target_z.vfx");
}

marktarget_run(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\engine\utility::isbulletdamage(var_1) && isplayer(var_0) && var_0.team != self.team && !var_0 scripts\mp\utility\game::_hasperk("specialty_empimmune") && !isDefined(var_0.ismarkedtarget)) {
    thread marktarget_execute(var_0);
  }
}

marktarget_execute(var_0) {
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  var_2 linkto(var_1, "tag_origin", (0, 0, 45), (0, 0, 0));
  var_1 linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0.ismarkedtarget = 1;
  var_0.healthregendisabled = 1;
  wait 0.1;
  tagmarkedplayer(var_0, var_2);
  wait 0.1;

  if(isDefined(var_0)) {
    var_0 removemarkfromtarget(var_1);
  }
}

tagmarkedplayer(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  scripts\mp\missions::func_D991("ch_trait_marked_target");
  var_2 = gettime() + 3000;

  while(isalive(var_0) && gettime() < var_2) {
    if(level.gametype != "dm") {
      var_3 = _playfxontagforteam(scripts\engine\utility::getfx("marked_target"), var_1, "tag_origin", self.team);
    } else {
      var_3 = playfxontagforclients(scripts\engine\utility::getfx("marked_target"), var_1, "tag_origin", self);
    }

    wait 1.1;
  }
}

removemarkfromtarget(var_0) {
  var_0 delete();
  self.ismarkedtarget = undefined;
  self.healthregendisabled = undefined;
}

func_13AA0(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death(var_2, "leave");

  if(isDefined(var_1)) {
    scripts\mp\utility\game::outlinedisable(var_0, var_1);
  }
}