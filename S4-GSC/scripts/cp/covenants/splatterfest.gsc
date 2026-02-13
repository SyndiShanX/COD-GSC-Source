/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\covenants\splatterfest.gsc
*************************************************/

init() {
  _id_0945::_id_C2B1("covenant_splatterfest", ::give_splatterfest, ::take_splatterfest);
}

watch_pending_splatters() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_splatterfest");

  for(;;) {
    if(self.pending_splatterfest_explosions.size > 0) {
      wait 0.15;
      var_0 = self.pending_splatterfest_explosions[0];
      do_explosion(var_0._id_96CF, var_0.attacker);
      self.pending_splatterfest_explosions = scripts\engine\utility::array_remove(self.pending_splatterfest_explosions, var_0);
      continue;
    }

    waitframe();
  }
}

do_explosion(var_0, var_1) {
  var_2 = var_0 + (0, 0, 60);
  playFX(level._effect["zmb_ai_explosion_death"], var_2);
  var_1 radiusdamage(var_2, 200, 50, 20, var_1, "MOD_EXPLOSIVE", "s4_splatterfest_zm");

  if(_func_0205("zmb_splatterfest_explo")) {
    playsoundatpos(var_2, "zmb_splatterfest_explo");
  }
}

give_splatterfest() {
  self.splat_failures = 0;
  var_0 = get_num_splatterfest_owners();

  if(var_0 == 1) {
    level _id_06CB::_id_AA4A(::check_killed_ai);
  }

  self.pending_splatterfest_explosions = [];
  thread watch_pending_splatters();
}

take_splatterfest() {
  self.splat_failures = undefined;
  var_0 = get_num_splatterfest_owners();

  if(var_0 == 0) {
    level _id_06CB::_id_C417(::check_killed_ai);
  }

  self notify("end_splatterfest");
}

get_num_splatterfest_owners() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2.splat_failures)) {
      var_0++;
    }
  }

  return var_0;
}

check_killed_ai(var_0) {
  var_1 = var_0._id_50FF;
  var_2 = var_0._id_DE2B;
  var_3 = isDefined(var_2) && _func_010F(var_2);

  if(isDefined(var_1) && isPlayer(var_1) && var_3 && var_1 scripts\cp\utility::_hasperk("covenant_splatterfest")) {
    if(get_should_splatter(var_1)) {
      var_4 = spawnStruct();
      var_4._id_96CF = self.origin;
      var_4.attacker = var_1;
      var_1.pending_splatterfest_explosions[var_1.pending_splatterfest_explosions.size] = var_4;
      var_1.splat_failures = 0;
    } else
      var_1.splat_failures++;
  }
}

get_should_splatter(var_0) {
  var_1 = var_0 _id_0945::_id_664E("splatterfest_min_chance");
  var_2 = var_0 _id_0945::_id_664E("splatterfest_max_chance");
  var_3 = var_0 _id_0945::_id_664E("splatterfest_chance_per_failure");
  var_4 = var_0.splat_failures;
  var_5 = min(var_1 + var_3 * var_4, var_2);
  return randomfloat(1.0) < var_5;
}

is_splatterfest_active(var_0) {
  return isDefined(var_0) && isDefined(var_0.basename) && var_0.basename == "s4_splatterfest_zm";
}