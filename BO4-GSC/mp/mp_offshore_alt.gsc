/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_offshore_alt.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\compass;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\mp\mp_offshore_alt_fx;
#include scripts\mp\mp_offshore_alt_player_rain;
#include scripts\mp\mp_offshore_alt_sound;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\load;

#namespace mp_offshore_alt;

event_handler[level_init] main(eventstruct) {
  callback::on_game_playing(&on_game_playing);
  callback::on_end_game(&on_end_game);
  mp_offshore_alt_fx::main();
  mp_offshore_alt_sound::main();
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((2730, 320, 72), (1648, -1560, -20), (3950, 1600, 131), (1012, 564, -10), (4460, 160, 57));
  setdvar(#"phys_buoyancy", 1);
  setdvar(#"phys_ragdoll_buoyancy", 1);
  function_2cdcf5c3();
}

function_2cdcf5c3() {
  if(util::isfirstround()) {
    level thread scene::play("p8_fxanim_mp_offshore_monkey_01_bundle", "idle");
    level thread scene::play("p8_fxanim_mp_offshore_monkey_02_bundle", "idle");
  }
}

on_game_playing() {
  array::delete_all(getEntArray("sun_block", "targetname"));
  wait getdvarfloat(#"hash_205d729c5c415715", 0);
  util::delay(0.2, undefined, &function_d29974fc);
  level thread function_fc73e385();

  if(util::isfirstround()) {
    util::delay(0.5, undefined, &function_fa491a59);
    level thread scene::play("p8_fxanim_mp_offshore_monkey_01_bundle", "run");
    level thread scene::play("p8_fxanim_mp_offshore_monkey_02_bundle", "run");
    util::delay(4, undefined, &scene::stop, "p8_fxanim_mp_offshore_monkey_01_bundle", 1);
    util::delay(4, undefined, &scene::stop, "p8_fxanim_mp_offshore_monkey_02_bundle", 1);
    return;
  }

  exploder::exploder("fxexp_tower_fire");
}

on_end_game() {
  if(!isDefined(level.var_ba9e60ac)) {
    level.var_ba9e60ac = [];
  }

  foreach(scene in level.var_ba9e60ac) {
    foreach(bundle in struct::get_array(scene, "scriptbundlename")) {
      bundle.barrage = 0;
    }
  }
}

function_d29974fc() {
  var_38bda94 = array("p8_fxanim_mp_seaside_parrots_orange_flock_01_bundle", "p8_fxanim_mp_seaside_parrots_orange_flock_02_bundle", "p8_fxanim_mp_seaside_parrots_scarlet_flock_01_bundle", "p8_fxanim_mp_seaside_parrots_scarlet_flock_02_bundle", "p8_fxanim_mp_seaside_parrots_yellow_flock_01_bundle", "p8_fxanim_mp_seaside_parrots_yellow_flock_02_bundle");

  foreach(str_scene in var_38bda94) {
    level thread scene::play(str_scene);
  }
}

function_fc73e385() {
  level.var_ba9e60ac = array("p8_fxanim_mp_offshore_artillery_volley_01_bundle", "p8_fxanim_mp_offshore_artillery_volley_02_bundle", "p8_fxanim_mp_offshore_artillery_volley_03_bundle", "p8_fxanim_mp_offshore_artillery_volley_04_bundle", "p8_fxanim_mp_offshore_artillery_volley_05_bundle", "p8_fxanim_mp_offshore_artillery_volley_06_bundle");
  level.var_ba9e60ac = array::randomize(level.var_ba9e60ac);

  foreach(scene in level.var_ba9e60ac) {
    array::thread_all(struct::get_array(scene, "scriptbundlename"), &function_c76ccdd2);
  }
}

function_c76ccdd2() {
  self.script_play_multiple = 1;
  self.barrage = 1;
  wait randomfloatrange(1, 10);

  while(self.barrage) {
    self scene::play();
    wait randomfloatrange(10, 20);
  }
}

function_fa491a59() {
  exploder::exploder("fxexp_tower_explosion");
  explode_pos = (2407.75, -2045.5, 68);
  playrumbleonposition("mp_offshore_tower_explosion", explode_pos);
}