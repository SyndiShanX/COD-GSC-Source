/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\equipment\zm_crystal_shard.gsc
*****************************************************/

crystal_shard_used(var_0) {
  var_0 endon("death");
  var_0 hide();
  var_1 = scripts\cp\utility::_id_E190("s4_zm_dark_aether_crystal_shard", var_0.origin, var_0.angles);
  var_1 notsolid();
  var_1._id_0203 = var_0;
  var_0.crystal_shard = var_1;
  var_0.crystal_shard linkto(var_0);
  var_0 thread crystal_shard_timeout();
  var_0 waittill("missile_stuck", var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(isDefined(var_8)) {
    var_9 = var_8 _meth_8575("anemone_mouth", 1);

    if(isDefined(var_9) && var_9 == "active") {
      if(!istrue(var_8.has_crystal)) {
        var_0 thread crystal_shard_swallow_by_anemone(var_8);
        return;
      }
    }
  }

  var_0 detonate();
}

crystal_shard_timeout() {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.crystal_shard)) {
    self.crystal_shard delete();
  }
}

crystal_shard_swallow_by_anemone(var_0) {
  var_0 notify("crystal_shard_swallowed");
  var_1 = self.crystal_shard;

  if(isDefined(var_1)) {
    var_1 unlink();
    var_1 endon("death");
    var_1 moveto(var_0.origin + 20 * anglestoup(var_0.angles), 1);
    var_1 waittill("movedone");
    var_1 delete();
  }

  self delete();
}

electric_heart_init() {
  level._effect["vfx_blue_crystal_ground_explosion"] = loadfx("vfx/s4/zombie/vfx_blue_crystal_ground_explosion");
}

electric_heart_used(var_0) {
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_1);

  if(isDefined(var_1)) {
    if(var_1.model == "s4_zm_floating_monolith") {
      var_0 thread electric_heart_stick_to_pillar(var_1, self, var_0.origin);
    }
  }

  thread electric_heart_explode(var_0);
  var_0 detonate();
}

electric_heart_stick_to_pillar(var_0, var_1, var_2) {
  var_0 notify("electric_heart_stuck", var_1, var_2);
  playsoundatpos(self.origin, "zmb_heart_land_on_pillar");
}

electric_heart_explode(var_0) {
  var_0 thread scripts\cp\utility::_id_A695("death", "end_explode");
  var_0 endon("end_explode");
  var_1 = var_0.owner;
  var_2 = var_0._id_10D0C;
  var_0 waittill("explode", var_3);
  playFX(scripts\engine\utility::getfx("vfx_blue_crystal_ground_explosion"), var_3);
  var_0 thread electrify_zombies_in_range(var_3, var_1, var_2);
}

electrify_zombies_in_range(var_0, var_1, var_2) {
  var_3 = _func_0071(var_0, 256);

  foreach(var_5 in var_3) {
    var_1 thread electrify_zombie(var_5, var_2);
  }
}

electrify_zombie(var_0, var_1) {
  if(isDefined(var_0.zm_ai_category) && (var_0.zm_ai_category == "special" || var_0.zm_ai_category == "elite")) {
    return;
  }
  var_0 endon("death");
  var_0 scripts\aitypes\zombie_common\stun::stun(5, "dead_wire");

  if(isPlayer(self)) {
    var_2 = self;
    var_3 = self;
  } else {
    var_2 = var_0;
    var_3 = var_0;
  }

  var_0 dodamage(10, var_0.origin, var_2, var_3, "MOD_UNKNOWN", var_1);
  var_0 setscriptablepartstate("electricity", "active");
  var_0 playLoopSound("zmb_deadwire_stun_lp");
  wait 5;
  var_0 setscriptablepartstate("electricity", "neutral");
  var_0 stoploopsound("zmb_deadwire_stun_lp");
}